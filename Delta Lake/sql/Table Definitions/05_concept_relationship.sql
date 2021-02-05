CREATE
OR REPLACE TABLE concept_relationship (
  concept_id_1 LONG,
  concept_id_2 LONG,
  relationship_id STRING,
  valid_start_date DATE,
  valid_end_date DATE,
  invalid_reason STRING
) USING DELTA;
