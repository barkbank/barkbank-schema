ALTER TABLE dogs
ADD COLUMN dog_participation_status t_participation_status NOT NULL DEFAULT 'PARTICIPATING';

ALTER TABLE dogs
ADD COLUMN dog_pause_expiry_time TIMESTAMP WITH TIME ZONE DEFAULT NULL;
