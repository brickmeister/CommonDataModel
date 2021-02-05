  CREATE
  OR REPLACE TABLE note (
    note_id LONG,
    person_id LONG,
    note_event_id LONG,
    note_event_field_concept_id LONG,
    note_date DATE,
    note_datetime TIMESTAMP,
    note_type_concept_id LONG,
    note_class_concept_id LONG,
    note_title STRING,
    note_text STRING,
    encoding_concept_id LONG,
    language_concept_id LONG,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    note_source_value STRING
  ) USING DELTA;
