\connect :DB_NAME

DO
$$
BEGIN

IF NOT EXISTS(SELECT column_name
                FROM information_schema.columns
                WHERE table_schema = 'management' AND table_name = 'users' AND column_name = 'link')
  THEN
    ALTER TABLE management.users
      ADD COLUMN link varchar(100);
  END IF;

END
$$
