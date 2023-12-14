BEGIN;

DO
$do$
DECLARE
    current_migration_number integer := 2;
BEGIN
    IF NOT EXISTS (SELECT migration_number FROM migrations WHERE migration_number = current_migration_number) THEN
        CREATE EXTENSION IF NOT EXISTS citext;
        -- UserTypes Table
        CREATE TABLE user_types (
            id SERIAL PRIMARY KEY,
            type_description CITEXT UNIQUE NOT NULL
        );


        INSERT INTO user_types (id, type_description)
        VALUES
            (1, 'Super Admin'),
            (2, 'Admin'),
            (3, 'Teacher'),
            (4, 'Student'),
            (5, 'Parents');


        INSERT INTO migrations(migration_number) VALUES (current_migration_number);
    ELSE
        RAISE NOTICE 'Already ran migration %.', current_migration_number;
    END IF;
END
$do$;

COMMIT;
