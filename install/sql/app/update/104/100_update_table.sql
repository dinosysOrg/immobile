\connect :DB_NAME

DO
$$
BEGIN

CREATE TABLE IF NOT EXISTS management.bookmarks   
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

END
$$
