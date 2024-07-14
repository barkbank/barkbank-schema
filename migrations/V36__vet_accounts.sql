CREATE TABLE vet_accounts (
  vet_account_id BIGSERIAL,
  vet_account_email TEXT NOT NULL,
  vet_id BIGINT,
  CONSTRAINT vet_accounts_unique_email UNIQUE (vet_account_email),
  CONSTRAINT vet_accounts_fk_vets FOREIGN KEY (vet_id) REFERENCES vets (vet_id),
  CONSTRAINT vet_account_pk PRIMARY KEY (vet_account_id)
);
