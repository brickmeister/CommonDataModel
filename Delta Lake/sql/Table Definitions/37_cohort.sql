CREATE
OR REPLACE TABLE cohort (
  cohort_definition_id LONG,
  subject_id LONG,
  cohort_start_date DATE,
  cohort_end_date DATE
) USING DELTA;
