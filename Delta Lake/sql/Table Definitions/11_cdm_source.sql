CREATE
OR REPLACE TABLE cdm_source (
  cdm_source_name STRING,
  cdm_source_abbreviation STRING,
  cdm_holder STRING,
  source_description STRING,
  source_documentation_reference STRING,
  cdm_etl_reference STRING,
  source_release_date DATE,
  cdm_release_date DATE,
  cdm_version STRING,
  vocabulary_version STRING
) USING DELTA;
