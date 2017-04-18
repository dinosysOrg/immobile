\connect immobile

-- BEGIN STAGING.TABLES

CREATE TABLE staging.countries
(
  identifier character varying(50) NOT NULL,
  name character varying(255),
  name_vi character varying(255),
  lat double precision,
  lon double precision,
  CONSTRAINT countries_identifier_key UNIQUE (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.countries
  OWNER TO postgres;

CREATE TABLE staging.cities
(
  country character varying(50) NOT NULL,
  identifier character varying(255) NOT NULL,
  name character varying(255),
  name_vi character varying(255),
  lat double precision,
  lon double precision,
  population integer,
  CONSTRAINT staging_cities_key UNIQUE (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.cities
  OWNER TO postgres;

CREATE TABLE staging.districts
(
  city character varying(255) NOT NULL,
  identifier character varying(255) NOT NULL,
  name character varying(255),
  name_vi character varying(255),
  lat double precision,
  lon double precision,
  CONSTRAINT staging_districts_key UNIQUE (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.districts
  OWNER TO postgres;

-- END STAGING.TABLES
