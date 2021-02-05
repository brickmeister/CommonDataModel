CREATE
OR REPLACE TABLE cohort_definition (
  cohort_definition_id LONG,
  cohort_definition_name STRING,
  cohort_definition_description STRING,
  definition_type_concept_id LONG,
  cohort_definition_syntax STRING,
  subject_concept_id LONG,
  cohort_initiation_date DATE
) USING DELTA;