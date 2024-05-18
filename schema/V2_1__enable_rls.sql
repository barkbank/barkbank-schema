ALTER TABLE admins ENABLE ROW LEVEL SECURITY;
ALTER TABLE calls ENABLE ROW LEVEL SECURITY;
ALTER TABLE dog_vet_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE dogs ENABLE ROW LEVEL SECURITY;
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE vets ENABLE ROW LEVEL SECURITY;

-- It is not possible for flyway to enable RLS on flyway_schema_history while it
-- is using the table. You'll have to do this manually...
--
-- ALTER TABLE flyway_schema_history ENABLE ROW LEVEL SECURITY;
