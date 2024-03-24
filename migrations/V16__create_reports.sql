CREATE TYPE t_pos_neg_nil AS ENUM ('POSITIVE', 'NEGATIVE', 'NIL');
CREATE TYPE t_reported_ineligibility AS ENUM ('NIL', 'TEMPORARY_INELIGIBLE', 'PERMANENTLY_INELIGIBLE');

CREATE TABLE reports (
  report_id BIGSERIAL,
  report_creation_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  report_modification_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  call_id BIGINT NOT NULL,
  visit_time TIMESTAMP WITH TIME ZONE NOT NULL,
  dog_weight_kg REAL NOT NULL,
  dog_body_conditioning_score INTEGER NOT NULL,
  dog_heartworm t_pos_neg_nil NOT NULL,
  dog_dea1_point1 t_pos_neg_nil NOT NULL,
  dog_reported_ineligibility t_reported_ineligibility NOT NULL,
  encrypted_ineligibility_reason TEXT NOT NULL,
  ineligibility_expiry_time TIMESTAMP WITH TIME ZONE,
  CONSTRAINT reports_fk_calls FOREIGN KEY (call_id) REFERENCES calls (call_id) ON DELETE RESTRICT,
  CONSTRAINT reports_pk PRIMARY KEY (report_id)
);

CREATE FUNCTION update_report_modification_time()
RETURNS TRIGGER AS $$
BEGIN
    NEW.report_modification_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_report_modification_time_trigger
BEFORE UPDATE ON reports
FOR EACH ROW EXECUTE FUNCTION update_report_modification_time();
