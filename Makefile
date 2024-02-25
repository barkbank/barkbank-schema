.PHONY: default
default: test

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

# This starts a dev database, if not already started, and runs the latest
# migrations against that database. The operation is idempotent. (It will run
# `make test` first.)
.PHONY: dev
dev: test
	bash scripts/dev.sh

# This removes the out/ directory.
.PHONY: clean
clean:
	rm -rf out
