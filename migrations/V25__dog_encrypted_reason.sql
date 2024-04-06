ALTER TABLE dogs
ADD COLUMN dog_encrypted_reason TEXT NOT NULL DEFAULT '';

ALTER TABLE dogs
DROP CONSTRAINT dog_participation_check;

ALTER TABLE dogs
ADD CONSTRAINT dog_participation_check CHECK (
    (dog_participation_status = 'PARTICIPATING' AND dog_pause_expiry_time IS NULL AND dog_encrypted_reason = '' )
    OR (dog_participation_status = 'PAUSED' AND dog_pause_expiry_time IS NOT NULL)
    OR (dog_participation_status = 'OPTED_OUT' AND dog_pause_expiry_time IS NULL)
);
