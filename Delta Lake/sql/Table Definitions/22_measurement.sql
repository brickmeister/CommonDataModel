  CREATE
  OR REPLACE TABLE measurement (
    measurement_id LONG,
    person_id LONG,
    measurement_concept_id LONG,
    measurement_date DATE,
    measurement_datetime TIMESTAMP,
    measurement_time STRING,
    measurement_type_concept_id LONG,
    operator_concept_id LONG,
    value_as_number DOUBLE,
    value_as_concept_id LONG,
    unit_concept_id LONG,
    range_low DOUBLE,
    range_high DOUBLE,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    measurement_source_value STRING,
    measurement_source_concept_id LONG,
    unit_source_value STRING,
    value_source_value STRING
  ) USING DELTA;
--ZORDER BY (person_id)
