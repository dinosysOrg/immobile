\c immobile
\encoding UTF8

TRUNCATE staging.roles;
TRUNCATE staging.estates;
TRUNCATE staging.conveniences;
TRUNCATE staging.furnitures;

\COPY staging.roles FROM '../../../settings/roles/roles.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8'
\COPY staging.estates FROM '../../../settings/estates/estates.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8'
\COPY staging.conveniences FROM '../../../settings/conveniences/conveniences.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8'
\COPY staging.furnitures FROM '../../../settings/furnitures/furnitures.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8'

SELECT staging.merge_roles();
SELECT staging.merge_estates();
SELECT staging.merge_conveniences();
SELECT staging.merge_furnitures();
