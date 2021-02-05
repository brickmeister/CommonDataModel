  CREATE
  OR REPLACE TABLE payer_plan_period (
    payer_plan_period_id LONG,
    person_id LONG,
    contract_person_id LONG,
    payer_plan_period_start_date DATE,
    payer_plan_period_end_date date,
    payer_concept_id LONG,
    plan_concept_id LONG,
    contract_concept_id LONG,
    sponsor_concept_id LONG,
    stop_reason_concept_id LONG,
    payer_source_value STRING,
    payer_source_concept_id LONG,
    plan_source_value STRING,
    plan_source_concept_id LONG,
    contract_source_value STRING,
    contract_source_concept_id LONG,
    sponsor_source_value STRING,
    sponsor_source_concept_id LONG,
    family_source_value STRING,
    stop_reason_source_value STRING,
    stop_reason_source_concept_id LONG
  ) USING DELTA;
