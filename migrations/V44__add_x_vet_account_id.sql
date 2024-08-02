ALTER TABLE pawtal_events
ADD COLUMN x_vet_account_id TEXT DEFAULT NULL;

-- (1) It is necessary to recreate view_pawtal_events to include the new column.
-- This is because the `*` expression is resolved and at the time the CREATE
-- VIEW statement is executed and the columns included by the view is
-- consequently fixed at the point in time.
--
-- (2) CREATE OR REPLACE VIEW does not work in this case. Hence the view is
-- dropped and recreated.
DROP VIEW view_pawtal_events;
CREATE VIEW view_pawtal_events
WITH (security_invoker=on)
AS
SELECT
  *,
  (event_ts AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Singapore')::date AS "day"
FROM pawtal_events;
