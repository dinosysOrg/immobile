\connect :DB_NAME

DO
$$
BEGIN

IF NOT EXISTS(SELECT column_name
                FROM information_schema.columns
                WHERE table_schema = 'management' AND table_name = 'blogs' AND column_name = 'user_id')
  THEN
    ALTER TABLE management.blogs
      ADD COLUMN user_id bigint;
  END IF;


IF NOT EXISTS(SELECT column_name
                FROM information_schema.columns
                WHERE table_schema = 'management' AND table_name = 'blogs' AND column_name = 'is_available')
  THEN
    ALTER TABLE management.blogs
      ADD COLUMN is_available boolean default true,
      ADD COLUMN is_show boolean default false,
      ADD COLUMN is_home boolean default false;
  END IF;


IF NOT EXISTS(SELECT column_name
                FROM information_schema.columns
                WHERE table_schema = 'management' AND table_name = 'blogs' AND column_name = 'status')
  THEN
    ALTER TABLE management.blogs
      ADD COLUMN status character varying(100);
  END IF;

END
$$
