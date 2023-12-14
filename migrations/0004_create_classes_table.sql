BEGIN;

DO
$do$
DECLARE
    current_migration_number integer := 4;
BEGIN
    IF NOT EXISTS (SELECT migration_number FROM migrations WHERE migration_number = current_migration_number) THEN

        -- Classes Table
        CREATE TABLE classes (
            id SERIAL PRIMARY KEY,
            class_name CITEXT NOT NULL,
            teacher_id INTEGER NOT NULL REFERENCES users(id),
            deleted_at TIMESTAMPTZ
        );

        CREATE UNIQUE INDEX classes_class_name_deleted_at_unique_idx ON classes (class_name, COALESCE(deleted_at, 'infinity'));

        INSERT INTO migrations(migration_number) VALUES (current_migration_number);
    ELSE
        RAISE NOTICE 'Already ran migration %.', current_migration_number;
    END IF;
END
$do$;

COMMIT;
