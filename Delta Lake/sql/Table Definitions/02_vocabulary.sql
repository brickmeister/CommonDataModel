CREATE
OR REPLACE TABLE vocabulary (
  vocabulary_id STRING,
  vocabulary_name STRING,
  vocabulary_reference STRING,
  vocabulary_version STRING,
  vocabulary_concept_id LONG
) USING DELTA;
