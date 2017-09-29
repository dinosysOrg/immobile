\connect :DB_NAME

DO
$$
BEGIN

CREATE TABLE IF NOT EXISTS blog.posts   
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
ALTER TABLE blog.posts
  OWNER TO postgres;

END
$$
