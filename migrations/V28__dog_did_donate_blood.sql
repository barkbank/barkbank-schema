-- Add the new column and set the value to FALSE for all existing rows
ALTER TABLE reports
ADD COLUMN dog_did_donate_blood BOOLEAN NOT NULL DEFAULT FALSE;

-- Drop the default value
ALTER TABLE reports
ALTER COLUMN dog_did_donate_blood DROP DEFAULT;
