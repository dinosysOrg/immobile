\c immobile
\encoding UTF8

-- TRUNCATE staging.dim_cities;

-- \COPY staging.dim_cities FROM '../../../settings/cities/cities15000.csv' DELIMITER ',' CSV ENCODING 'UTF8'

-- \COPY staging.spatial_areas FROM '../../../settings/spatial_areas/countries.csv' DELIMITER ';' CSV HEADER ENCODING 'utf-8'

-- SELECT staging.merge_cities();