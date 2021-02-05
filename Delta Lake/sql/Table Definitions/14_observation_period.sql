  CREATE
  OR REPLACE TABLE observation_period (
    observation_period_id LONG,
    person_id LONG,
    observation_period_start_date DATE,
    observation_period_end_date DATE,
    period_type_concept_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
