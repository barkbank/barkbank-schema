ALTER TABLE dogs
ADD CONSTRAINT dog_pregnancy_check CHECK (
  (dog_gender <> 'MALE' OR dog_ever_pregnant = 'NO')
);