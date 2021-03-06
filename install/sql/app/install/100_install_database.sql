CREATE DATABASE :DB_NAME
		WITH OWNER = postgres
		ENCODING = 'UTF8'
--		LC_COLLATE = 'en-US'
--		LC_CTYPE = 'en-US'
        TEMPLATE=template0;
\connect immobile;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Enable PostGIS (includes raster)
CREATE EXTENSION IF NOT EXISTS postgis;
