ALTER TABLE dogs
ADD CONSTRAINT dog_participation_check CHECK (
  (dog_participation_status <> 'PAUSED' AND dog_pause_expiry_time IS NULL)
  OR (dog_participation_status = 'PAUSED' AND dog_pause_expiry_time IS NOT NULL)
);
