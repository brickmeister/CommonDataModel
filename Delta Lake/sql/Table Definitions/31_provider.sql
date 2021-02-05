CREATE
  OR REPLACE TABLE provider (
    provider_id LONG,
    provider_name STRING,
    npi STRING,
    dea STRING,
    specialty_concept_id LONG,
    care_site_id LONG,
    year_of_birth LONG,
    gender_concept_id LONG,
    provider_source_value STRING,
    specialty_source_value STRING,
    specialty_source_concept_id LONG,
    gender_source_value STRING,
    gender_source_concept_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
