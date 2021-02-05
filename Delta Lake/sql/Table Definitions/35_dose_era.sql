  CREATE
  OR REPLACE TABLE dose_era (
    dose_era_id LONG,
    person_id LONG,
    drug_concept_id LONG,
    unit_concept_id LONG,
    dose_value DOUBLE,
    dose_era_start_datetime TIMESTAMP,
    dose_era_end_datetime TIMESTAMP
  ) USING DELTA;
--ZORDER BY (person_id)
