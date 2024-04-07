ALTER TABLE dogs
ADD CONSTRAINT dog_pregnancy_check CHECK (
  (dog_gender <> 'MALE' and dog_ever_pregnant <> 'YES')
);