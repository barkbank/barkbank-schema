-- Add the new modification time columns.
ALTER TABLE users
ADD COLUMN user_modification_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE admins
ADD COLUMN admin_modification_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE vets
ADD COLUMN vet_modification_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE dogs
ADD COLUMN dog_modification_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP;


-- Initialise existing modification time to the creation time.
UPDATE users SET user_modification_time = user_creation_time;
UPDATE admins SET admin_modification_time = admin_creation_time;
UPDATE vets SET vet_modification_time = vet_creation_time;
UPDATE dogs SET dog_modification_time = dog_creation_time;


-- Install triggers to keep modification updated upon UPDATE
CREATE FUNCTION update_user()
RETURNS TRIGGER AS $$
BEGIN
    NEW.user_modification_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_user_trigger
BEFORE UPDATE ON users
FOR EACH ROW EXECUTE FUNCTION update_user();

CREATE FUNCTION update_admin()
RETURNS TRIGGER AS $$
BEGIN
    NEW.admin_modification_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_admin_trigger
BEFORE UPDATE ON admins
FOR EACH ROW EXECUTE FUNCTION update_admin();

CREATE FUNCTION update_vet()
RETURNS TRIGGER AS $$
BEGIN
    NEW.vet_modification_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_vet_trigger
BEFORE UPDATE ON vets
FOR EACH ROW EXECUTE FUNCTION update_vet();

CREATE FUNCTION update_dog()
RETURNS TRIGGER AS $$
BEGIN
    NEW.dog_modification_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_dog_trigger
BEFORE UPDATE ON dogs
FOR EACH ROW EXECUTE FUNCTION update_dog();
