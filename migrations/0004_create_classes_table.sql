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
            class_name CITEXT UNIQUE NOT NULL,
            teacher_id INTEGER NOT NULL REFERENCES users(id)
        );

        INSERT INTO migrations(migration_number) VALUES (current_migration_number);
    ELSE
        RAISE NOTICE 'Already ran migration %.', current_migration_number;
    END IF;
END
$do$;

COMMIT;
