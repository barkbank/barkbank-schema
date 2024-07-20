ALTER TABLE vet_accounts DROP COLUMN vet_account_email;
ALTER TABLE vet_accounts DROP COLUMN vet_account_name;
ALTER TABLE vet_accounts ADD COLUMN vet_account_hashed_email TEXT NOT NULL;
ALTER TABLE vet_accounts ADD COLUMN vet_account_encrypted_email TEXT NOT NULL;
ALTER TABLE vet_accounts ADD COLUMN vet_account_encrypted_name TEXT NOT NULL;
ALTER TABLE vet_accounts ADD CONSTRAINT vet_accounts_unique_hashed_email UNIQUE(vet_account_hashed_email);
