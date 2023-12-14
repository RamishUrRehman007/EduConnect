BEGIN;

DO
$do$
DECLARE
    current_migration_number integer := 6;
BEGIN
    IF NOT EXISTS (SELECT migration_number FROM migrations WHERE migration_number = current_migration_number) THEN

        -- Messages Table
        CREATE TABLE messages (
            id SERIAL PRIMARY KEY,
            room_id INTEGER NOT NULL REFERENCES rooms(id),
            sender_id INTEGER NOT NULL REFERENCES users(id),
            content TEXT NOT NULL,
            created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
            -- updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
            -- deleted_at TIMESTAMPTZ
        );

        INSERT INTO migrations(migration_number) VALUES (current_migration_number);
    ELSE
        RAISE NOTICE 'Already ran migration %.', current_migration_number;
    END IF;
END
$do$;

COMMIT;
