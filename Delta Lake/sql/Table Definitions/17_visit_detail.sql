  CREATE
  OR REPLACE TABLE visit_detail (
    visit_detail_id LONG,
    person_id LONG,
    visit_detail_concept_id LONG,
    visit_detail_start_date DATE,
    visit_detail_start_datetime TIMESTAMP,
    visit_detail_end_date DATE,
    visit_detail_end_datetime TIMESTAMP,
    visit_detail_type_concept_id LONG,
    provider_id LONG,
    care_site_id LONG,
    discharge_to_concept_id LONG,
    admitted_from_concept_id LONG,
    admitted_from_source_value STRING,
    visit_detail_source_value STRING,
    visit_detail_source_concept_id LONG,
    discharge_to_source_value STRING,
    preceding_visit_detail_id LONG,
    visit_detail_parent_id LONG,
    visit_occurrence_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
