\connect :DB_NAME

CREATE TABLE IF NOT EXISTS staging.spatial_areas (
  identifier varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  area text NOT NULL,
  CONSTRAINT pk_staging_spatial_areas PRIMARY KEY (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.spatial_areas
  OWNER TO postgres;
  
CREATE TABLE IF NOT EXISTS settings.spatial_areas (
  id bigserial NOT NULL,
  identifier varchar(255) NOT NULL UNIQUE,
  name varchar(255) NOT NULL,
  area GEOGRAPHY NOT NULL,
  CONSTRAINT pk_settings_spatial_areas PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

