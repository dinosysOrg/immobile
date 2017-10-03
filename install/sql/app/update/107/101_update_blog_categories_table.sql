\connect :DB_NAME

DO
$$
BEGIN

CREATE TABLE IF NOT EXISTS settings.blog_categories (
  id bigserial NOT NULL,
  identifier varchar(255) NOT NULL UNIQUE,
  name varchar(255) NOT NULL,
  description varchar(255) NOT NULL,
  CONSTRAINT pk_settings_news_categories PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

CREATE TABLE IF NOT EXISTS staging.blog_categories (
  identifier varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  description varchar(255) NOT NULL,
  CONSTRAINT pk_staging_news_categories PRIMARY KEY (identifier)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE staging.blog_categories
  OWNER TO postgres;

END
$$
