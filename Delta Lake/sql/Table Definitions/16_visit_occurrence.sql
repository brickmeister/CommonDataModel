  CREATE
  OR REPLACE TABLE visit_occurrence (
    visit_occurrence_id LONG,
    person_id LONG,
    visit_concept_id LONG,
    visit_start_date DATE,
    visit_start_datetime TIMESTAMP,
    visit_end_date DATE,
    visit_end_datetime TIMESTAMP,
    visit_type_concept_id LONG,
    provider_id LONG,
    care_site_id LONG,
    visit_source_value STRING,
    visit_source_concept_id LONG,
    admitted_from_concept_id LONG,
    admitted_from_source_value STRING,
    discharge_to_source_value STRING,
    discharge_to_concept_id LONG,
    preceding_visit_occurrence_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
