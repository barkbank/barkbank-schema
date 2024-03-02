-- Add dog_weight_kg to dogs table

ALTER TABLE dogs
ADD COLUMN dog_weight_kg INTEGER;

ALTER TABLE dogs
ADD CONSTRAINT dog_weight_kg_is_positive CHECK (dog_weight_kg > 0);
