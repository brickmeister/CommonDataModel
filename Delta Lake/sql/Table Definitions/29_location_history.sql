CREATE
  OR REPLACE TABLE location_history (
    location_history_id LONG,
    location_id LONG,
    relationship_type_concept_id LONG,
    domain_id STRING,
    entity_id LONG,
    start_date DATE,
    end_date DATE
  ) USING DELTA;
