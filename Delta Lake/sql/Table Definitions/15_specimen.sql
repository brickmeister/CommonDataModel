  CREATE
  OR REPLACE TABLE specimen (
    specimen_id LONG,
    person_id LONG,
    specimen_concept_id LONG,
    specimen_type_concept_id LONG,
    specimen_date date,
    specimen_datetime TIMESTAMP,
    quantity DOUBLE,
    unit_concept_id LONG,
    anatomic_site_concept_id LONG,
    disease_status_concept_id LONG,
    specimen_source_id STRING,
    specimen_source_value STRING,
    unit_source_value STRING,
    anatomic_site_source_value STRING,
    disease_status_source_value STRING
  ) USING DELTA;
--ZORDER BY (person_id)
