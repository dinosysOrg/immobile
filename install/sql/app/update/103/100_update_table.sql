\connect :DB_NAME

DO
$$
BEGIN

IF NOT EXISTS(SELECT column_name
                FROM information_schema.columns
                WHERE table_schema = 'management' AND table_name = 'houses' AND column_name = 'pending_money')
  THEN
    ALTER TABLE management.houses
      ADD COLUMN pending_money integer default 0;
  END IF;

END
$$
