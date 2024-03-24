CREATE TYPE t_call_outcome AS ENUM ('APPOINTMENT', 'DECLINED', 'OPT_OUT');

CREATE TABLE calls (
  call_id BIGSERIAL,
  call_creation_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  vet_id BIGINT NOT NULL,
  dog_id BIGINT NOT NULL,
  call_outcome t_call_outcome NOT NULL,
  encrypted_opt_out_reason TEXT NOT NULL,
  CONSTRAINT calls_pk PRIMARY KEY (call_id)
);
