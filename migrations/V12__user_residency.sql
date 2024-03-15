CREATE TYPE t_residency AS ENUM ('OTHER', 'SINGAPORE');

ALTER TABLE users
ADD COLUMN user_residency t_residency NOT NULL DEFAULT 'SINGAPORE';

ALTER TABLE users
ALTER COLUMN user_residency DROP DEFAULT;
