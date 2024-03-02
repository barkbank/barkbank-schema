-- Add dog_ever_pregnant and dog_ever_received_transfusion

CREATE TYPE t_yes_no_unknown AS ENUM ('YES', 'NO', 'UNKNOWN');

-- Add columns with default so existing records default to UNKNOWN
ALTER TABLE dogs
ADD COLUMN dog_ever_pregnant t_yes_no_unknown NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE dogs
ADD COLUMN dog_ever_received_transfusion t_yes_no_unknown NOT NULL DEFAULT 'UNKNOWN';

-- Drop DEFAULT so future records must specify a value.
ALTER TABLE dogs
ALTER COLUMN dog_ever_pregnant DROP DEFAULT;
ALTER TABLE dogs
ALTER COLUMN dog_ever_received_transfusion DROP DEFAULT;
