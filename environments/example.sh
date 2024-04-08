# An "example" environment.
#
# This runs migrations against the pawtaldevdb container that is created by
# scripts/local.sh.
#
# Special Notes - Since both the target database and Flyway run in container,
# the actual container IP and port values for the database are used.
#
theMigrationsDir=migrations
theDatabaseName=devdb
theDatabaseUser=postgres
theDatabasePassword=password
theHost=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pawtaldevdb)
thePort=5432
