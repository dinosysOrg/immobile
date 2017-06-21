\connect :DB_NAME
\encoding UTF8


CREATE OR REPLACE FUNCTION staging.merge_services()
  RETURNS void AS
$BODY$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT
      identifier,
      name,
      description,
      price,
      currency
    FROM staging.services
    LOOP
        UPDATE settings.services SET
          name = r.name,
          description = r.description,
          price = r.price,
          currency = r.currency
        WHERE identifier = r.identifier;
        IF NOT FOUND THEN
        INSERT INTO settings.services (
          identifier,
          name,
          description,
          price,
          currency
        )
        VALUES (
          r.identifier,
          r.name,
          r.description,
          r.price,
          r.currency
        );
        END IF;
    END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION staging.merge_services()
  OWNER TO postgres;

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


--- merge spatial areas ---
CREATE OR REPLACE FUNCTION staging.merge_spatial_areas()
  RETURNS void AS
$BODY$
DECLARE
    r RECORD;
BEGIN
    FOR r IN SELECT
      identifier,
      name,
      area
    FROM staging.spatial_areas
    LOOP
        UPDATE settings.spatial_areas SET
          name = r.name,
          area = ST_GeographyFromText('SRID=4326;' || r.area)
        WHERE identifier = r.identifier;
        IF NOT FOUND THEN
        INSERT INTO settings.spatial_areas (
          identifier,
          name,
          area
        )
        VALUES (
          r.identifier,
          r.name,
          ST_GeographyFromText('SRID=4326;' || r.area)
        );
        END IF;
    END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION staging.merge_spatial_areas()
  OWNER TO postgres;

