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
            name CITEXT NOT NULL,
            class_id INTEGER NOT NULL REFERENCES classes(id),
            ai_instructions TEXT,
            created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
            deleted_at TIMESTAMPTZ
        );
        
        CREATE UNIQUE INDEX rooms_name_class_id_deleted_at_unique_idx ON rooms (name, class_id, COALESCE(deleted_at, 'infinity'));
        
        INSERT INTO migrations(migration_number) VALUES (current_migration_number);
    ELSE
        RAISE NOTICE 'Already ran migration %.', current_migration_number;
    END IF;
END
$do$;

COMMIT;
