SELECT
    ns.nspname as "namespace",
    CASE
        WHEN cls.relname IN (SELECT tablename FROM pg_tables)
        THEN 'table'
        ELSE 'view'
    END as "rel_type",
    cls.relname as "rel_name"
FROM pg_namespace as ns
LEFT JOIN pg_class as cls on ns.oid = cls.relnamespace
WHERE ns.nspname = 'public'
AND cls.relname <> 'flyway_schema_history'
AND (
    (
        -- Is a table without RLS enabled
        cls.relname IN (SELECT tablename FROM pg_tables)
        AND cls.relrowsecurity = false
    )
    OR (
        -- Is a view without security_invoker=on
        cls.relname IN (SELECT viewname FROM pg_views)
        AND (
            cls.reloptions IS NULL
            OR array_position(cls.reloptions, 'security_invoker=on') IS NULL
        )
    )
)
ORDER BY "namespace", "rel_type", "rel_name"
