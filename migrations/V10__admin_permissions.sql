-- Add columns to admins table for recording admin permissions.

ALTER TABLE admins
ADD COLUMN admin_can_manage_admin_accounts BOOLEAN NOT NULL DEFAULT FALSE,
ADD COLUMN admin_can_manage_vet_accounts BOOLEAN NOT NULL DEFAULT FALSE,
ADD COLUMN admin_can_manage_user_accounts BOOLEAN NOT NULL DEFAULT FALSE,
ADD COLUMN admin_can_manage_donors BOOLEAN NOT NULL DEFAULT FALSE;
