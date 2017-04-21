\connect immobile

CREATE TABLE management.photos
(
  id bigserial NOT NULL,
  user_id bigint,
  product_id bigint,
  address character varying(200),
  number_bedroom integer,
  number_bathroom integer,
  size character varying(50),
  price character varying(50),
  matterport_url character varying(200),
  description text,
  latitude double precision,
  longitude double precision,
  CONSTRAINT pk_products PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.products
  OWNER TO postgres;


CREATE TABLE management.products
(
  id bigserial NOT NULL,
  user_id bigint,
  name character varying(50) NOT NULL,
  address character varying(200),
  number_bedroom integer,
  number_bathroom integer,
  size character varying(50),
  price character varying(50),
  matterport_url character varying(200),
  description text,
  latitude double precision,
  longitude double precision,
  CONSTRAINT pk_products PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.products
  OWNER TO postgres;

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
