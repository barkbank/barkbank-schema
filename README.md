# Bark Bank Schema

This repository contains migration scripts for the Bark Bank Database.

## Directories

- `migrations` — This directory contains schema migration scripts.
- `schema` — This directory contains the reference schema.
- `scripts` - This directory contains scripts.
- `environments` - This directory contains configurations for the ./deploy script.
- `out` - Ephemeral directory created for test outputs.

## How Tos

### How to prepare migrations

1. Update the reference schema in `schema/` to the desired state.
2. Add migration files to `migrations/`
3. Test using `make`. If this fails, fix the migrations and retry.

### How to run a dev database for local Pawtal

1. `make dev`
2. Note the connection details at the end of the run.

### How to apply migrations to the dev database for local Pawtal

1. `make dev`

### How to rollback migrations for local Pawtal

It is possible to rollback by writing undo scripts:

- https://documentation.red-gate.com/flyway/deploying-database-changes-via-a-pipeline/implementing-a-roll-back-strategy/rolling-back

However that sounds like more work. Fixing Forward is safer.

- https://www.liquibase.com/blog/roll-back-database-fix-forward
- https://documentation.red-gate.com/flyway/deploying-database-changes-via-a-pipeline/implementing-a-roll-back-strategy/rolling-forward

That said **if the migrations have not been merged to main**, we can attempt to clean it up. So for migrations not already in main we can do it this way:

1. Add migrations to reverse the error. E.g. if a column was added, then drop the column. Do revert errors in the reference schema also. Verify using `make test`.
2. Run `make dev` to apply the migrations.
3. At this point, the database should have the same schema as before the error. So we can delete the unnecessary migrations and run `make test` to verify.
4. Finally, connect to the database and delete the unnecessary rows from the `flyway_schema_history` table. They should have in the `script` column the names of the migration files deleted in the previous step.

### How to execute migrations against a database of my choosing

1. Write a configuration file in `environments/`.
    - For example `environemnts/example.sh` defines configuration for the `example` environment.
2. Execute `./deploy <env>` — E.g. `./deploy example`.
