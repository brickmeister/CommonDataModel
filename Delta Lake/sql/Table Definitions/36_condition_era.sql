  CREATE
  OR REPLACE TABLE condition_era (
    condition_era_id LONG,
    person_id LONG,
    condition_concept_id LONG,
    condition_era_start_datetime TIMESTAMP,
    condition_era_end_datetime TIMESTAMP,
    condition_occurrence_count LONG
  ) USING DELTA;

-- COMMAND ----------

-- DBTITLE 1,OMOP Result Tables
--ZORDER BY (subject_id)
