CREATE TABLE donor_snapshots (
  "snapshot_id" BIGSERIAL,
  "day" DATE NOT NULL,
  "dog_id" BIGINT NOT NULL,
  "dog_breed" TEXT NOT NULL,
  "dog_age_months" INTEGER NOT NULL,
  "dog_gender" t_dog_gender NOT NULL,
  "dog_weight_kg" REAL NULL,
  "dog_dea1_point1" t_pos_neg_nil NOT NULL,
  "dog_ever_pregnant" t_yes_no_unknown NOT NULL,
  "dog_ever_received_transfusion" t_yes_no_unknown NOT NULL,
  "dog_medical_status" t_medical_status NOT NULL,
  "dog_profile_status" t_profile_status NOT NULL,
  "user_id" BIGINT NOT NULL,
  "user_residency" t_residency NOT NULL,
  CONSTRAINT unique_day_dog UNIQUE ("day", "dog_id"),
  CONSTRAINT donor_snapshots_pk PRIMARY KEY ("snapshot_id")
);

ALTER TABLE donor_snapshots ENABLE ROW LEVEL SECURITY;
