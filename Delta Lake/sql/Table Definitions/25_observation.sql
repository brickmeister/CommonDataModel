  CREATE
  OR REPLACE TABLE observation (
    observation_id LONG,
    person_id LONG,
    observation_concept_id LONG,
    observation_date DATE,
    observation_datetime TIMESTAMP,
    observation_type_concept_id LONG,
    value_as_number DOUBLE,
    value_as_string STRING,
    value_as_concept_id LONG,
    qualifier_concept_id LONG,
    unit_concept_id LONG,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    observation_source_value STRING,
    observation_source_concept_id LONG,
    unit_source_value STRING,
    qualifier_source_value STRING,
    observation_event_id LONG,
    obs_event_field_concept_id LONG,
    value_as_datetime TIMESTAMP
  ) USING DELTA;
