\connect immobile
\encoding UTF8

CREATE OR REPLACE FUNCTION staging.merge_roles()
  RETURNS void AS
$BODY$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT
      identifier,
      name
    FROM staging.roles
    LOOP
        UPDATE settings.roles SET
          name = r.name
        WHERE identifier = r.identifier;
        IF NOT FOUND THEN
        INSERT INTO settings.roles (
          identifier,
          name
        )
        VALUES (
          r.identifier,
          r.name
        );
        END IF;
    END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION staging.merge_roles()
  OWNER TO postgres;
  


CREATE OR REPLACE FUNCTION staging.merge_estates()
  RETURNS void AS
$BODY$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT
      identifier,
      name
    FROM staging.estates
    LOOP
        UPDATE settings.estates SET
          name = r.name
        WHERE identifier = r.identifier;
        IF NOT FOUND THEN
        INSERT INTO settings.estates (
          identifier,
          name
        )
        VALUES (
          r.identifier,
          r.name
        );
        END IF;
    END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION staging.merge_estates()
  OWNER TO postgres;
  


CREATE OR REPLACE FUNCTION staging.merge_furnitures()
  RETURNS void AS
$BODY$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT
      identifier,
      name
    FROM staging.furnitures
    LOOP
        UPDATE settings.furnitures SET
          name = r.name
        WHERE identifier = r.identifier;
        IF NOT FOUND THEN
        INSERT INTO settings.furnitures (
          identifier,
          name
        )
        VALUES (
          r.identifier,
          r.name
        );
        END IF;
    END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION staging.merge_furnitures()
  OWNER TO postgres;




CREATE OR REPLACE FUNCTION staging.merge_conveniences()
  RETURNS void AS
$BODY$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT
      identifier,
      name,
      in_house
    FROM staging.conveniences
    LOOP
        UPDATE settings.conveniences SET
          name = r.name,
          in_house = r.in_house
        WHERE identifier = r.identifier;
        IF NOT FOUND THEN
        INSERT INTO settings.conveniences (
          identifier,
          name,
          in_house
        )
        VALUES (
          r.identifier,
          r.name,
          r.in_house
        );
        END IF;
    END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION staging.merge_conveniences()
  OWNER TO postgres;

