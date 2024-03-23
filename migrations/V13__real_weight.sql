ALTER TABLE dogs
ALTER COLUMN dog_weight_kg TYPE REAL USING dog_weight_kg::REAL;
