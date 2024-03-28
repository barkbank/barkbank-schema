ALTER TABLE reports
ADD COLUMN dog_id BIGINT NOT NULL,
ADD COLUMN vet_id BIGINT NOT NULL;

ALTER TABLE reports
ADD CONSTRAINT reports_fk_dogs FOREIGN KEY (dog_id) REFERENCES dogs (dog_id) ON DELETE RESTRICT,
ADD CONSTRAINT reports_fk_vets FOREIGN KEY (vet_id) REFERENCES vets (vet_id) ON DELETE RESTRICT;

ALTER TABLE reports
ADD CONSTRAINT reports_unique_dog_visit_time UNIQUE (dog_id, visit_time);
