  CREATE
  OR REPLACE TABLE condition_occurrence (
    condition_occurrence_id LONG,
    person_id LONG,
    condition_concept_id LONG,
    condition_start_date DATE,
    condition_start_datetime TIMESTAMP,
    condition_end_date DATE,
    condition_end_datetime TIMESTAMP,
    condition_type_concept_id LONG,
    condition_status_concept_id LONG,
    stop_reason STRING,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    condition_source_value STRING,
    condition_source_concept_id LONG,
    condition_status_source_value STRING
  ) USING DELTA;
--ZORDER BY (person_id)
