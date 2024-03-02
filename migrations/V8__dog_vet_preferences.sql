CREATE TABLE dog_vet_preferences (
  dog_id BIGINT NOT NULL,
  vet_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  preference_creation_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT dog_vet_preferences_fk_dogs FOREIGN KEY (dog_id) REFERENCES dogs (dog_id) ON DELETE CASCADE,
  CONSTRAINT dog_vet_preferences_fk_vets FOREIGN KEY (vet_id) REFERENCES vets (vet_id) ON DELETE CASCADE,
  CONSTRAINT dog_vet_preferences_fk_users FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
  CONSTRAINT dog_vet_preferences_pk PRIMARY KEY (dog_id, vet_id)
);
