-- Replace dog_weight_kg_is_positive with dog_weight_kg_is_null_or_positive
--
-- In PostgreSQL ``a check constraint is satisfied if the check expression
-- evaluates to true or the null value. Since most expressions will evaluate to
-- the null value if any operand is null, they will not prevent null values in
-- the constrained columns'' (Ref1)
--
-- However, in the interest of clarity and the avoidence of doubt, we have
-- included it in the constraint.
--
-- Ref1:
-- https://www.postgresql.org/docs/15/ddl-constraints.html#DDL-CONSTRAINTS-CHECK-CONSTRAINTS

ALTER TABLE dogs
ADD CONSTRAINT dog_weight_kg_is_null_or_positive CHECK (dog_weight_kg IS NULL OR dog_weight_kg > 0);

ALTER TABLE dogs
DROP CONSTRAINT dog_weight_kg_is_positive;
