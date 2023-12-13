BEGIN;

DO
$do$
DECLARE
    current_migration_number integer := 3;
BEGIN
    IF NOT EXISTS (SELECT migration_number FROM migrations WHERE migration_number = current_migration_number) THEN

        -- Users Table
        CREATE TABLE users (
            id SERIAL PRIMARY KEY,
            username CITEXT UNIQUE NOT NULL,
            user_type_id INTEGER NOT NULL REFERENCES user_types(id),
            email CITEXT UNIQUE NOT NULL,
            password_hash TEXT NOT NULL,
            created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
        );

        INSERT INTO migrations(migration_number) VALUES (current_migration_number);
    ELSE
        RAISE NOTICE 'Already ran migration %.', current_migration_number;
    END IF;
END
$do$;

COMMIT;
