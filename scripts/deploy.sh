#!/bin/bash

set -e

# Load Configuration File
mConfigFile=$1
if [ ! -f $mConfigFile ]; then
    echo "Missing configuration file: $mConfigFile"
    exit 1
fi
source $mConfigFile

if [ -z "$theMigrationsDir" ]; then
    echo "theMigrationsDir is not specified"
    exit 1
fi
if [ -z "$theDatabaseName" ]; then
    echo "theDatabaseName is not specified"
    exit 1
fi
if [ -z "$theDatabaseUser" ]; then
    echo "theDatabaseUser is not specified"
    exit 1
fi
if [ -z "$theDatabasePassword" ]; then
    echo "theDatabasePassword is not specified"
    exit 1
fi
if [ -z "$theHost" ]; then
    echo "theHost is not specified"
    exit 1
fi
if [ -z "$thePort" ]; then
    echo "thePort is not specified"
    exit 1
fi


mFlywayDockerImage=flyway/flyway:10.4.1

docker run --rm \
    -v $(pwd)/${theMigrationsDir}:/flyway/sql \
    -e FLYWAY_URL=jdbc:postgresql://${theHost}:${thePort}/${theDatabaseName} \
    -e FLYWAY_USER=${theDatabaseUser} \
    -e FLYWAY_PASSWORD=${theDatabasePassword} \
    ${mFlywayDockerImage} migrate -locations=filesystem:/flyway/sql
