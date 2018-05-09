-- Create table in the DB:
CREATE TABLE land_registry_price_paid_uk(
  transaction uuid,
  price numeric,
  transfer_date date,
  postcode text,
  property_type char(1),
  newly_built boolean,
  duration char(1),
  paon text,
  saon text,
  street text,
  locality text,
  city text,
  district text,
  county text,
  ppd_category_type char(1),
  record_status char(1));

-- Use \copy CSV data using an absolute path from your local
-- Be careful! \copy != COPY
-- \copy land_registry_price_paid_uk FROM '/FULL/PATH/TO/FILE/pp-2017.csv' with (format csv, encoding 'win1252', header false, null '', quote '"', force_null (postcode, saon, paon, street, locality, city, district));
\copy land_registry_price_paid_uk FROM '/csv-data/pp-2017.csv' with (format csv, encoding 'win1252', header false, null '', quote '"', force_null (postcode, saon, paon, street, locality, city, district));
