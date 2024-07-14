ALTER TABLE vet_accounts
ADD COLUMN vet_account_name TEXT NOT NULL DEFAULT '';

ALTER TABLE vet_accounts
ALTER COLUMN vet_account_name DROP DEFAULT;
