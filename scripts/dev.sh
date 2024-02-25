#!/bin/bash

set -e

### About
#
# This manages a dev database locally using Docker.
#
# - postgres://postgres:password@localhost:5800/devdb
#
# It will ensure that the database exists and then attempt to run migration
# against it.
#

### Configuration

mContainerName=pawtaldevdb
mContainerPort=5800
mVolumeName=pawtaldevdbvolume

mDatabaseName=devdb
mDatabaseUser=postgres
mDatabasePassword=password

mPostgresDockerImage=postgres:15.2
mFlywayDockerImage=flyway/flyway:10.4.1

mMigrationsDir=migrations


# This will output "true" or "false"
function doContainerIsRunning {
    docker inspect -f '{{.State.Running}}' ${mContainerName} 2>/dev/null
}

# This will output the IP of the container
function doGetContainerIp {
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${mContainerName}
}

function doStartContainer {
    echo "Starting container: ${mContainerName}"
    docker run \
        --name ${mContainerName} \
        -e POSTGRES_USER=${mDatabaseUser} \
        -e POSTGRES_PASSWORD=${mDatabasePassword} \
        -p ${mContainerPort}:5432 \
        -v ${mVolumeName}:/var/lib/postgresql/data \
        -d \
        ${mPostgresDockerImage}

    # Give some time for database to be ready.
    sleep 3
}

function doCreateDatabase {
    echo "Creating database: ${mDatabaseName}"
    docker exec \
        -it ${mContainerName} \
        psql \
        -U ${mDatabaseUser} \
        -d postgres \
        -c "CREATE DATABASE ${mDatabaseName}"
}

function doRunMigrations {
    echo "Running migrations"

    # Flyway runs inside its own container so it needs the actual IP and Port of
    # the PostgreSQL database container.
    local xHostIp=$(doGetContainerIp)
    local xHostPort="5432"

    docker run --rm \
        -v $(pwd)/${mMigrationsDir}:/flyway/sql \
        -e FLYWAY_URL=jdbc:postgresql://${xHostIp}:${xHostPort}/${mDatabaseName} \
        -e FLYWAY_USER=${mDatabaseUser} \
        -e FLYWAY_PASSWORD=${mDatabasePassword} \
        ${mFlywayDockerImage} migrate -locations=filesystem:/flyway/sql
}

function doEnsureDatabaseIsRunning {
    if [ "$(doContainerIsRunning)" == "true" ]; then
        echo "Container ${mContainerName} is running."
    else
        echo "Container ${mContainerName} is not running."
        doStartContainer
        doCreateDatabase
    fi
}

doEnsureDatabaseIsRunning
doRunMigrations

echo "Database is ready..."
echo "postgres://${mDatabaseUser}:${mDatabasePassword}@localhost:${mContainerPort}/${mDatabaseName}"
