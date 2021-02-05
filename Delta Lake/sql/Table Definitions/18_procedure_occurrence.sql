  CREATE
  OR REPLACE TABLE procedure_occurrence (
    procedure_occurrence_id LONG,
    person_id LONG,
    procedure_concept_id LONG,
    procedure_date DATE,
    procedure_datetime TIMESTAMP,
    procedure_type_concept_id LONG,
    modifier_concept_id LONG,
    quantity LONG,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    procedure_source_value STRING,
    procedure_source_concept_id LONG,
    modifier_source_value STRING
  ) USING DELTA;
--ZORDER BY (person_id)
