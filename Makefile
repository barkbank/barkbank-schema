.PHONY: default
default: test

######################################################################
# Ticketing
.PHONY: ticket

ticket:
	@bash scripts/make-ticket.sh


######################################################################
# Testing
.PHONY: test test-keep

# This runs the Flyway migrations in schema/ (the reference) and the migrations
# in migrations/ and then does a pgdump to see if they agree. The dumps will be
# available in the out/ directory.
test:
	bash scripts/test.sh

# This is like `make test`, but it keeps the database container running for
# debugging purposes.
test-keep:
	bash scripts/test.sh keep

######################################################################
# Local deployment
.PHONY: local local-destroy

# This starts a local development database, if not already started,
# and runs the latest migrations against that database. The operation
# is idempotent. (It will run `make test` first.)
local: test
	bash scripts/local.sh

# This destroys the local development database. Use it if you want to
# reset.
local-destroy:
	bash scripts/local-destroy.sh


######################################################################
# External deployments

# NOTE: We now deploy using github workflows. This section is
# deprecated. For interest, the old way of deploying is based on the
# scripts/deploy.sh script.


######################################################################
# Housekeeping
.PHONY: clean

# This removes the out/ directory.
clean:
	rm -rf out
