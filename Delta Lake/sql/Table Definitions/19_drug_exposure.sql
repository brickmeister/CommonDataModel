  CREATE
  OR REPLACE TABLE drug_exposure (
    drug_exposure_id LONG,
    person_id LONG,
    drug_concept_id LONG,
    drug_exposure_start_date DATE,
    drug_exposure_start_datetime TIMESTAMP,
    drug_exposure_end_date DATE,
    drug_exposure_end_datetime TIMESTAMP,
    verbatim_end_date DATE,
    drug_type_concept_id LONG,
    stop_reason STRING,
    refills LONG,
    quantity DOUBLE,
    days_supply LONG,
    sig STRING,
    route_concept_id LONG,
    lot_number STRING,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    drug_source_value STRING,
    drug_source_concept_id LONG,
    route_source_value STRING,
    dose_unit_source_value STRING
  ) USING DELTA;
--ZORDER BY (person_id)
