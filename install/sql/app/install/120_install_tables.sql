\housest :DB_NAME

-- BEGIN SETTINGS.TABLES

CREATE TABLE settings.roles   
(
  id bigserial NOT NULL,
  identifier character varying(50) NOT NULL,
  name character varying(50),
  CONSTRAINT pk_roles PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE settings.roles
  OWNER TO postgres;


CREATE TABLE settings.estates   
(
  id bigserial NOT NULL,
  identifier character varying(50) NOT NULL,
  name character varying(100) NOT NULL,
  type character varying(100),
  description character varying(500),
  CONSTRAINT pk_estates PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE settings.estates
  OWNER TO postgres;



CREATE TABLE settings.furnitures
(
  id bigserial NOT NULL,
  identifier character varying(50) NOT NULL,
  name character varying(200) NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_furnitures PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE settings.furnitures
  OWNER TO postgres;



CREATE TABLE settings.conveniences   
(
  id bigserial NOT NULL,
  identifier character varying(50) NOT NULL,
  name character varying(100) NOT NULL,
  description character varying(500),
  photo character varying(500),
  in_house boolean DEFAULT false,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_conveniences PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE settings.conveniences
  OWNER TO postgres;


CREATE TABLE settings.services   
(
  id bigserial NOT NULL,
  identifier character varying(50) NOT NULL,
  name character varying(200) NOT NULL,
  description text,
  price integer,
  currency character varying(50),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_services PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE settings.services
  OWNER TO postgres;


CREATE TABLE settings.spatial_areas (
  id bigserial NOT NULL,
  identifier varchar(255) NOT NULL UNIQUE,
  name varchar(255) NOT NULL,
  area GEOGRAPHY NOT NULL,
  CONSTRAINT pk_settings_spatial_areas PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
-- END SETTINGS.TABLES


-- BEGIN BLOG.TABLES
CREATE TABLE blog.posts   
(
  id bigserial NOT NULL,
  user_id bigint,
  name character varying(200),
  link character varying(200),
  description character varying(500),
  content text,
  cover_url character varying(500),
  category character varying(100),
  is_available boolean default true,
  is_show boolean default true,
  is_home boolean default false,
  status character varying(100),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_blogs PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.posts
  OWNER TO postgres;
-- END BLOG.TABLES


-- BEGIN MANAGEMENT.TABLES

CREATE TABLE management.bookmarks   
(
  id bigserial NOT NULL,
  user_id bigint,
  object_id bigint,
  provider character varying(100),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_bookmarks PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.bookmarks
  OWNER TO postgres;


CREATE TABLE management.tags   
(
  id bigserial NOT NULL,
  name character varying(100),
  count bigint NOT NULL,
  CONSTRAINT pk_tags PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.tags
  OWNER TO postgres;



CREATE TABLE management.users
(
  id bigserial NOT NULL,
  email character varying(100) DEFAULT '',
  phone character varying(100) DEFAULT '',
  skype character varying(100) DEFAULT '',
  address character varying(200),
  encrypted_password character varying(500) DEFAULT '',
  reset_password_token character varying(500),
  reset_password_sent_at timestamp with time zone,
  remember_created_at timestamp with time zone,
  sign_in_count bigint DEFAULT 0,
  current_sign_in_at timestamp with time zone,
  last_sign_in_at timestamp with time zone,
  current_sign_in_ip inet,
  last_sign_in_ip inet,
  confirmation_token character varying(500),
  confirmed_at timestamp with time zone,
  confirmation_sent_at timestamp with time zone,
  unconfirmed_email character varying(500),
  failed_attempts int DEFAULT 0,
  unlock_token character varying(500),
  locked_at timestamp with time zone,
  firstname character varying(100),
  lastname character varying(100),
  name character varying(100),
  link character varying(100),
  avatar character varying(500),
  provider character varying(100),
  uid character varying(500),
  is_home boolean default false,
  created_at timestamp with time zone NOT NULL,
  updated_at timestamp with time zone NOT NULL,

  is_available boolean default true,
  budget bigint DEFAULT 0,
  CONSTRAINT pk_users PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.users
  OWNER TO postgres;



CREATE TABLE management.projects
(
  id bigserial NOT NULL,
  name character varying(200) NOT NULL,
  link character varying(500),
  photo character varying(500),
  description text,
  address character varying(200),
  size integer,
  size_construction integer,
  time_bulding timestamp with time zone,
  time_completion timestamp with time zone,
  number_block integer,
  number_house integer,
  number_shophouse integer,
  number_floor integer,
  investor character varying(200),
  inc_management character varying(200),
  inc_design character varying(200),
  green_space character varying(200),
  destinition_construction character varying(200),
  fee_management integer,
  fee_park_car integer,
  fee_park_moto integer,
  currency character varying(200),
  progress_construction character varying(500),
  sale_policy character varying(500),
  is_show boolean default true,
  is_available boolean default true,
  is_home boolean default false,
  latitude numeric(16,10),
  longitude numeric(16,10),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_projects PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.projects
  OWNER TO postgres;



CREATE TABLE management.houses
(
  id bigserial NOT NULL,
  name character varying(500) NOT NULL,
  link character varying(500) NOT NULL,
  address character varying(200),
  number_bedroom integer,
  number_bathroom integer,
  size integer,
  price bigint,
  currency character varying(50),
  for_rent boolean default false,
  matterport_url character varying(200),
  description text,
  host_type character varying(50),
  status character varying(50),
  is_available boolean default true,
  project_id bigint,
  user_id bigint,
  estate_id bigint,
  is_show boolean default true,
  is_home boolean default false,
  latitude numeric(16,10),
  longitude numeric(16,10),
  pending_money bigint default 0,
  disable_at timestamp with time zone DEFAULT now(),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_houses PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES management.users (id),
  FOREIGN KEY (project_id) REFERENCES management.projects (id),
  FOREIGN KEY (estate_id) REFERENCES settings.estates (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.houses
  OWNER TO postgres;



CREATE TABLE management.contracts   
(
  id bigserial NOT NULL,
  house_id bigint NOT NULL,
  user_id bigint NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_contracts PRIMARY KEY (id),
  FOREIGN KEY (house_id) REFERENCES management.houses (id),
  FOREIGN KEY (user_id) REFERENCES management.users (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.contracts
  OWNER TO postgres;



CREATE TABLE management.photos
(
  id bigserial NOT NULL,
  user_id bigint,
  house_id bigint,
  project_id bigint,
  description text,
  photo_url character varying(200),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_photos PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES management.users (id),
  FOREIGN KEY (house_id) REFERENCES management.houses (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.photos
  OWNER TO postgres;


CREATE TABLE management.project_conveniences   
(
  id bigserial NOT NULL,
  project_id bigint NOT NULL,
  convenience_id bigint NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_project_conveniences PRIMARY KEY (id),
  FOREIGN KEY (project_id) REFERENCES management.projects (id),
  FOREIGN KEY (convenience_id) REFERENCES settings.conveniences (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.project_conveniences
  OWNER TO postgres;


CREATE TABLE management.house_furnitures
(
  id bigserial NOT NULL,
  house_id bigint NOT NULL,
  furniture_id bigint NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_house_furnitures PRIMARY KEY (id),
  FOREIGN KEY (house_id) REFERENCES management.houses (id),
  FOREIGN KEY (furniture_id) REFERENCES settings.furnitures (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.house_furnitures
  OWNER TO postgres;



CREATE TABLE management.house_conveniences   
(
  id bigserial NOT NULL,
  house_id bigint NOT NULL,
  convenience_id bigint NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_house_conveniences PRIMARY KEY (id),
  FOREIGN KEY (house_id) REFERENCES management.houses (id),
  FOREIGN KEY (convenience_id) REFERENCES settings.conveniences (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.house_conveniences
  OWNER TO postgres;


CREATE TABLE management.contract_services   
(
  id bigserial NOT NULL,
  contract_id bigint NOT NULL,
  service_id bigint NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_contract_services PRIMARY KEY (id),
  FOREIGN KEY (contract_id) REFERENCES management.contracts (id),
  FOREIGN KEY (service_id) REFERENCES settings.services (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.contract_services
  OWNER TO postgres;


CREATE TABLE management.role_users   
(
  id bigserial NOT NULL,
  user_id bigint NOT NULL,
  role_id bigint NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_role_users PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES management.users (id),
  FOREIGN KEY (role_id) REFERENCES settings.roles (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.role_users
  OWNER TO postgres;


CREATE TABLE management.house_tags   
(
  id bigserial NOT NULL,
  house_id bigint NOT NULL,
  tag_id bigint NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_house_tags PRIMARY KEY (id),
  FOREIGN KEY (house_id) REFERENCES management.houses (id),
  FOREIGN KEY (tag_id) REFERENCES management.tags (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.house_tags
  OWNER TO postgres;

-- END MANAGEMENT.TABLES


-- BEGIN STAGING.TABLES

CREATE TABLE staging.services   
(
  identifier character varying(50) NOT NULL,
  name character varying(200) NOT NULL,
  description text,
  price integer,
  currency character varying(50),
  CONSTRAINT services_identifier_key UNIQUE (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.services
  OWNER TO postgres;


CREATE TABLE staging.contracts   
(
  identifier character varying(50) NOT NULL,
  name character varying(200) NOT NULL,
  description text,
  price integer,
  currency character varying(50),
  CONSTRAINT contracts_identifier_key UNIQUE (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.contracts
  OWNER TO postgres;

CREATE TABLE staging.conveniences   
(
  identifier character varying(50) NOT NULL,
  name character varying(100) NOT NULL,
  description character varying(500),
  photo character varying(500),
  in_house boolean,
  CONSTRAINT conveniences_identifier_key UNIQUE (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.conveniences
  OWNER TO postgres;


CREATE TABLE staging.furnitures
(
  identifier character varying(50) NOT NULL,
  name character varying(255),
  CONSTRAINT furnitures_identifier_key UNIQUE (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.furnitures
  OWNER TO postgres;


CREATE TABLE staging.estates   
(
  identifier character varying(50) NOT NULL,
  name character varying(100) NOT NULL,
  type character varying(100),
  description character varying(500),
  CONSTRAINT estates_identifier_key UNIQUE (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.estates
  OWNER TO postgres;


CREATE TABLE staging.roles
(
  identifier character varying(50) NOT NULL,
  name character varying(255),
  CONSTRAINT roles_identifier_key UNIQUE (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.roles
  OWNER TO postgres;

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

CREATE TABLE staging.spatial_areas (
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
-- END STAGING.TABLES
