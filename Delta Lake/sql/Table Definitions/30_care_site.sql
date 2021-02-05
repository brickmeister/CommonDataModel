CREATE
  OR REPLACE TABLE care_site (
    care_site_id LONG,
    care_site_name STRING,
    place_of_service_concept_id LONG,
    location_id LONG,
    care_site_source_value STRING,
    place_of_service_source_value STRING
  ) USING DELTA;
