CREATE
OR REPLACE TABLE source_to_concept_map (
  source_code STRING,
  source_concept_id LONG,
  source_vocabulary_id STRING,
  source_code_description STRING,
  target_concept_id LONG,
  target_vocabulary_id STRING,
  valid_start_date DATE,
  valid_end_date DATE,
  invalid_reason STRING
) USING DELTA;
