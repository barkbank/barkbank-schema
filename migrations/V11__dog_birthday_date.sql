-- Create tmp column to store timestamps
ALTER TABLE dogs
ADD COLUMN tmp_dog_birthday TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT TIMESTAMP '1970-01-01';

-- Copy existing birthdays into the tmp column
UPDATE dogs SET tmp_dog_birthday = TO_TIMESTAMP(dog_birthday, 'YYYY-MM-DD');

-- Drop the old column and constraint
ALTER TABLE dogs DROP CONSTRAINT dog_birthday_fmt;
ALTER TABLE dogs DROP COLUMN dog_birthday;

-- Create new column in the correct type.
ALTER TABLE dogs
ADD COLUMN dog_birthday TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT TIMESTAMP '1970-01-01';

-- Copy values from tmp column to the new column.
UPDATE dogs SET dog_birthday = tmp_dog_birthday;

-- Drop the default value.
ALTER TABLE dogs ALTER COLUMN dog_birthday DROP DEFAULT;

-- Drop the tmp column
ALTER TABLE dogs DROP COLUMN tmp_dog_birthday;
