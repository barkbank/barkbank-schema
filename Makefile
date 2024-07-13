.PHONY: default
default: test

.PHONY: ticket
ticket:
	@bash scripts/make-ticket.sh

# This runs the Flyway migrations in schema/ (the reference) and the migrations
# in migrations/ and then does a pgdump to see if they agree. The dumps will be
# available in the out/ directory.
.PHONY: test
test:
	bash scripts/test.sh

# This is like `make test`, but it keeps the database container running for
# debugging purposes.
.PHONY: keep
keep:
	bash scripts/test.sh keep

# This starts a local development database, if not already started,
# and runs the latest migrations against that database. The operation
# is idempotent. (It will run `make test` first.)
.PHONY: local
local: test
	bash scripts/local.sh

# This destroys the local development database. Use it if you want to
# reset.
.PHONY: local-destroy
local-destroy:
	bash scripts/local-destroy.sh

# Run migrations against the database configured by
# environments/$(target).sh. A value should be provided for
# target. E.g. `make target=dev deploy` (Default is 'dev')
target=dev
.PHONY: deploy
deploy: test
	bash scripts/deploy.sh environments/$(target).sh

# Run migrations on multiple targets
.PHONY: deploy-all
deploy-all: local deploy

# This removes the out/ directory.
.PHONY: clean
clean:
	rm -rf out
