\connect immobile

CREATE TABLE management.photos
(
  id bigserial NOT NULL,
  user_id bigint,
  product_id bigint,
  photo_url character varying(200),
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_photos PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.photos
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
  is_available boolean default true,
  latitude double precision,
  longitude double precision,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_products PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.products
  OWNER TO postgres;