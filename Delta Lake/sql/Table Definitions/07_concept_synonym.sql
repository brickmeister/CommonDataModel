CREATE
OR REPLACE TABLE concept_synonym (
  concept_id LONG,
  concept_synonym_name STRING,
  language_concept_id LONG
) USING DELTA;
