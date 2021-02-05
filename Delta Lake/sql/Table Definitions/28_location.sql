CREATE
  OR REPLACE TABLE location (
    location_id LONG,
    address_1 STRING,
    address_2 STRING,
    city STRING,
    state STRING,
    zip STRING,
    county STRING,
    country STRING,
    location_source_value STRING,
    latitude DOUBLE,
    longitude DOUBLE
  ) USING DELTA;
