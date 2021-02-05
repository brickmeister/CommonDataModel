CREATE
  OR REPLACE TABLE cost (
    cost_id LONG,
    person_id LONG,
    cost_event_id LONG,
    cost_event_field_concept_id LONG,
    cost_concept_id LONG,
    cost_type_concept_id LONG,
    currency_concept_id LONG,
    cost DOUBLE,
    incurred_date DATE,
    billed_date DATE,
    paid_date DATE,
    revenue_code_concept_id LONG,
    drg_concept_id LONG,
    cost_source_value STRING,
    cost_source_concept_id LONG,
    revenue_code_source_value STRING,
    drg_source_value STRING,
    payer_plan_period_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
