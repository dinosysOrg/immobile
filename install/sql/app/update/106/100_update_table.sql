\connect :DB_NAME

DO
$$
BEGIN

CREATE TABLE management.blogs   
(
  id bigserial NOT NULL,
  name character varying(200),
  link character varying(200),
  description character varying(500),
  content text,
  cover_url character varying(500),
  category character varying(100),
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT pk_blogs PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE management.blogs
  OWNER TO postgres;

END
$$
