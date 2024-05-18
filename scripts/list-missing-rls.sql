SELECT
    ns.nspname as "namespace",
    CASE
        WHEN cls.relname IN (SELECT tablename FROM pg_tables)
        THEN 'table'
        ELSE 'view'
    END as "rel_type",
    cls.relname as "rel_name",
    cls.relrowsecurity as "rls_enabled"
FROM pg_namespace as ns
LEFT JOIN pg_class as cls on ns.oid = cls.relnamespace
WHERE ns.nspname = 'public'
AND (
    cls.relname IN (SELECT tablename FROM pg_tables)
    OR cls.relname IN (SELECT viewname FROM pg_views)
)
AND cls.relrowsecurity = false
ORDER BY namespace, rel_type, rel_name
