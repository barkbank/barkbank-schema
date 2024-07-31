CREATE TABLE pawtal_events (
  event_id BIGSERIAL,
  event_ts TIMESTAMP WITH TIME ZONE NOT NULL,
  event_type TEXT NOT NULL,
  ctk TEXT NOT NULL,
  account_type TEXT DEFAULT NULL,
  account_id TEXT DEFAULT NULL,
  stk TEXT DEFAULT NULL,
  x_pathname TEXT DEFAULT NULL,
  CONSTRAINT ui_events_pk PRIMARY KEY (event_id)
);

ALTER TABLE pawtal_events ENABLE ROW LEVEL SECURITY;
