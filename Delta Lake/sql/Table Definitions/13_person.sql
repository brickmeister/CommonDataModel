  CREATE
  OR REPLACE TABLE person (
    person_id LONG,
    gender_concept_id LONG,
    year_of_birth LONG,
    month_of_birth LONG,
    day_of_birth LONG,
    birth_datetime TIMESTAMP,
    death_datetime TIMESTAMP,
    race_concept_id LONG,
    ethnicity_concept_id LONG,
    location_id LONG,
    provider_id LONG,
    care_site_id LONG,
    person_source_value STRING,
    gender_source_value STRING,
    gender_source_concept_id LONG,
    race_source_value STRING,
    race_source_concept_id LONG,
    ethnicity_source_value STRING,
    ethnicity_source_concept_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
