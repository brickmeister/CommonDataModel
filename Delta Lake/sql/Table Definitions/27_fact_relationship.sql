CREATE
  OR REPLACE TABLE fact_relationship (
    domain_concept_id_1 LONG,
    fact_id_1 LONG,
    domain_concept_id_2 LONG,
    fact_id_2 LONG,
    relationship_concept_id LONG
  ) USING DELTA;
