\connect :DB_NAME

DO
$$
BEGIN

Create SCHEMA blog
  AUTHORIZATION postgres;

END
$$
