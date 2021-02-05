CREATE
OR REPLACE TABLE concept (
  concept_id LONG,
  concept_name STRING,
  domain_id STRING,
  vocabulary_id STRING,
  concept_class_id STRING,
  standard_concept STRING,
  concept_code STRING,
  valid_start_date DATE,
  valid_end_date DATE,
  invalid_reason STRING
) USING DELTA;
