\connect :DB_NAME

DO
$$
BEGIN


CREATE OR REPLACE FUNCTION staging.merge_blog_categories()
  RETURNS void AS
$BODY$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT
      identifier,
      name,
      description
    FROM staging.blog_categories
    LOOP
        UPDATE settings.blog_categories SET
          name = r.name,
          description = r.description
        WHERE identifier = r.identifier;
        IF NOT FOUND THEN
        INSERT INTO settings.blog_categories (
          identifier,
          name,
          description
        )
        VALUES (
          r.identifier,
          r.name,
          r.description
        );
        END IF;
    END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION staging.merge_blog_categories()
  OWNER TO postgres;
  

END
$$
