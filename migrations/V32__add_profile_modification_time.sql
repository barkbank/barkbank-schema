ALTER TABLE dogs
ADD COLUMN profile_modification_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP;

UPDATE dogs
SET profile_modification_time = dog_modification_time;
