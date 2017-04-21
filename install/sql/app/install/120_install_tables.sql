\connect immobile


-- CREATE TABLE management.products
-- (
--   id bigserial NOT NULL,
--   identifier character varying(50) NOT NULL,
--   name character varying(50) NOT NULL,
--   unit character varying(50),
--   category character varying(50),
--   value_type character varying(50),
--   format_string character varying(50),
--   is_calculated boolean DEFAULT false,
--   aggregation_func character varying(50),
--   cal_message_id1 integer,
--   cal_message_id2 integer,
--   cal_operator character varying(50),
--   default_value real,
--   module character varying(50),
--   CONSTRAINT pk_messages PRIMARY KEY (id),
--   CONSTRAINT messages_identifier_key UNIQUE (identifier)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE management.products
--   OWNER TO postgres;

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
