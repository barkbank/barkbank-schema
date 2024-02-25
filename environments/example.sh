# An "example" environment. These configurations match those in scripts/dev.sh.
#
# Special Notes - The dev db runs in a container and so does Flyway. So we need
# to use the actual container IP and the actual port number (i.e. 5432).
#
theMigrationsDir=migrations
theDatabaseName=devdb
theDatabaseUser=postgres
theDatabasePassword=password
theHost=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pawtaldevdb)
thePort=5432
