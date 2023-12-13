BEGIN;

DO
$do$
DECLARE
    current_migration_number integer := 7;
BEGIN
    IF NOT EXISTS (SELECT migration_number FROM migrations WHERE migration_number = current_migration_number) THEN

        -- AI_Interactions Table
        CREATE TABLE ai_interactions (
            id SERIAL PRIMARY KEY,
            student_id INTEGER NOT NULL REFERENCES users(id),
            room_id INTEGER NOT NULL REFERENCES rooms(id),
            ai_response TEXT,
            timestamp TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
        );

        INSERT INTO migrations(migration_number) VALUES (current_migration_number);
    ELSE
        RAISE NOTICE 'Already ran migration %.', current_migration_number;
    END IF;
END
$do$;

COMMIT;
