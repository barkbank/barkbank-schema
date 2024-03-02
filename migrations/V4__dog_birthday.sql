-- Change dog_birth_month to dog_birthday

ALTER TABLE dogs
ADD COLUMN dog_birthday TEXT NOT NULL,
ADD CONSTRAINT dog_birthday_fmt CHECK (dog_birthday ~ '^\d{4}-\d{2}-\d{2}$');

UPDATE dogs SET dog_birthday = dog_birth_month || '-00';

ALTER TABLE dogs DROP COLUMN dog_birth_month;
