  CREATE
  OR REPLACE TABLE device_exposure (
    device_exposure_id LONG,
    person_id LONG,
    device_concept_id LONG,
    device_exposure_start_date DATE,
    device_exposure_start_datetime TIMESTAMP,
    device_exposure_end_date DATE,
    device_exposure_end_datetime TIMESTAMP,
    device_type_concept_id LONG,
    unique_device_id STRING,
    quantity LONG,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    device_source_value STRING,
    device_source_concept_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
