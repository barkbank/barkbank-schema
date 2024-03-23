CREATE TYPE t_dog_status AS ENUM (
  'INCOMPLETE',
  'ELIGIBLE',
  'INELIGIBLE',
  'PERMANENTLY_INELIGIBLE'
);

CREATE VIEW dogs_view AS (
  SELECT
    CASE
      WHEN tDog.dog_breed = '' AND tDog.dog_weight_kg IS NULL THEN 'INCOMPLETE'::t_dog_status
      WHEN tDog.dog_weight_kg < 20 THEN 'INELIGIBLE'::t_dog_status
      WHEN tDog.dog_ever_pregnant = 'YES' THEN 'PERMANENTLY_INELIGIBLE'::t_dog_status
      WHEN tDog.dog_ever_received_transfusion = 'YES' THEN 'PERMANENTLY_INELIGIBLE'::t_dog_status
      ELSE 'ELIGIBLE'::t_dog_status
    END as "dog_status",
    tDog.*
  FROM dogs as tDog
);
