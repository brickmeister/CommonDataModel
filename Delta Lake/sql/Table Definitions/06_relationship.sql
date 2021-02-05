CREATE
OR REPLACE TABLE relationship (
  relationship_id STRING,
  relationship_name STRING,
  is_hierarchical STRING,
  defines_ancestry STRING,
  reverse_relationship_id STRING,
  relationship_concept_id LONG
) USING DELTA;
