  CREATE
  OR REPLACE TABLE drug_era (
    drug_era_id LONG,
    person_id LONG,
    drug_concept_id LONG,
    drug_era_start_datetime TIMESTAMP,
    drug_era_end_datetime TIMESTAMP,
    drug_exposure_count LONG,
    gap_days LONG
  ) USING DELTA;
--ZORDER BY (person_id)
