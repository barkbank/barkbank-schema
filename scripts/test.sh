#!/bin/bash

set -e

### About
#
# This script compares the result of migrations against the reference schema.
# When they are compatible, the exit code of the script will be zero. Othersise
# the exit code will be non-zero.
#
# Output of pg_dump will be recorded in the out directory.
#

### Configuration

mDockerContainerName=pawtaltestdbcontainer
mDockerVolumeName=pawtaltestdbvolume

mHostPort=9100
mDatabaseUser=postgres  # do not change this
mDatabasePassword=password
mPostgresDockerImage=postgres:15.2

# https://hub.docker.com/r/flyway/flyway/tags
mFlywayDockerImage=flyway/flyway:10.4.1

mSchemaDir=schema
mMigrationsDir=migrations


function startDatabaseTestContainer {
    docker run \
        --name ${mDockerContainerName} \
        -e POSTGRES_USER=${mDatabaseUser} \
        -e POSTGRES_PASSWORD=${mDatabasePassword} \
        -p ${mHostPort}:5432 \
        -v ${mDockerVolumeName}:/var/lib/postgresql/data \
        -v $(pwd)/scripts:/scripts \
        -d \
        ${mPostgresDockerImage}

    # Give some time for database to be ready.
    sleep 3
}

function stopDatabaseTestContainer {
    # || : means ignore the exit code
    docker stop $mDockerContainerName 2> /dev/null || :
    docker remove $mDockerContainerName 2> /dev/null || :
    docker volume rm ${mDockerVolumeName} 2> /dev/null || :
}

# This will output the IP
function getContainerHostIp {
    local theContainerNameOrId=$1
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${theContainerNameOrId}
}

function createDatabase {
    local theDatabaseName=$1
    docker exec \
        -it ${mDockerContainerName} \
        psql \
        -U ${mDatabaseUser} \
        -d postgres \
        -c "CREATE DATABASE ${theDatabaseName}"
}

function runFlyway {
    local theDirectory=$1
    local theDatabaseName=$2
    local xHostIp=$(getContainerHostIp $mDockerContainerName)
    local xHostPort="5432"
    docker run --rm \
        -v $(pwd)/${theDirectory}:/flyway/sql \
        -e FLYWAY_URL=jdbc:postgresql://${xHostIp}:${xHostPort}/${theDatabaseName} \
        -e FLYWAY_USER=${mDatabaseUser} \
        -e FLYWAY_PASSWORD=${mDatabasePassword} \
        ${mFlywayDockerImage} migrate -locations=filesystem:/flyway/sql
}

# Does pg_dump on the $1 database into the ./out/$1-pgdump.sql file.
function collectPgDump {
    local theDatabaseName=$1
    mkdir -p out
    docker exec -t ${mDockerContainerName} pg_dump \
        -U postgres \
        -d ${theDatabaseName} > ./out/${theDatabaseName}-pgdump.sql
}

function ensureRlsEnabled {
    local theDatabaseName=$1
    local outFile="./out/${theDatabaseName}-missing-rls.txt"
    mkdir -p out
    docker exec -t ${mDockerContainerName} psql \
        -U postgres \
        -d ${theDatabaseName} \
        -f /scripts/list-missing-rls.sql > ${outFile}
    if grep -q "(0 rows)" ${outFile}; then
        echo "All tables and views have RLS enabled."
    else
        echo "There are tables or views without RLS enabled. Please review ${outFile}."
        cat ${outFile}
        exit 1
    fi
}

# Prepares a ./out/${1}db-dump.sql file containing the pg_dump output from a
# database with $1 migrations minus the lines containing Flyway migration
# records—e.g. V1__reference_schema
function getDump {
    local theDirectory=$1
    local xDBName="${theDirectory}db"
    createDatabase $xDBName
    runFlyway $theDirectory $xDBName
    collectPgDump $xDBName
    cat ./out/${xDBName}-pgdump.sql | grep -v "V.*__.*sql" > ./out/${xDBName}-dump.sql
    ensureRlsEnabled $xDBName
}

# This will output "true" or "false"
function doContainerIsRunning {
    docker inspect -f '{{.State.Running}}' ${mDockerContainerName} 2>/dev/null
}

function getSchemaAndMigrationDumps {
    local shouldKeep=$1
    stopDatabaseTestContainer
    startDatabaseTestContainer
    getDump $mSchemaDir
    getDump $mMigrationsDir
    if [[ "${shouldKeep}" == "keep" ]]; then
        echo "Database is left running at..."
        echo "Container: ${mDockerContainerName}"
        echo "postgres://${mDatabaseUser}:${mDatabasePassword}@localhost:${mHostPort}/${mSchemaDir}db"
        echo "postgres://${mDatabaseUser}:${mDatabasePassword}@localhost:${mHostPort}/${mMigrationsDir}db"
    else
        stopDatabaseTestContainer
    fi
}

getSchemaAndMigrationDumps $@
diff ./out/${mSchemaDir}db-dump.sql ./out/${mMigrationsDir}db-dump.sql
