BEGIN;

DO
$do$
DECLARE
    current_migration_number integer := 5;
BEGIN
    IF NOT EXISTS (SELECT migration_number FROM migrations WHERE migration_number = current_migration_number) THEN

        -- Rooms Table
        CREATE TABLE rooms (
            id SERIAL PRIMARY KEY,
            class_id INTEGER NOT NULL REFERENCES classes(id),
            creation_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
            ai_instructions TEXT,
            updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
        );

        INSERT INTO migrations(migration_number) VALUES (current_migration_number);
    ELSE
        RAISE NOTICE 'Already ran migration %.', current_migration_number;
    END IF;
END
$do$;

COMMIT;
