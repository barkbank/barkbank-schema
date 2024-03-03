-- Replace dog_weight_kg_is_positive with dog_weight_kg_is_null_or_positive

ALTER TABLE dogs
ADD CONSTRAINT dog_weight_kg_is_null_or_positive CHECK (dog_weight_kg IS NULL OR dog_weight_kg > 0);

ALTER TABLE dogs
DROP CONSTRAINT dog_weight_kg_is_positive;
