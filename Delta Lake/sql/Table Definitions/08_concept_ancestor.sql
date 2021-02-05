CREATE
OR REPLACE TABLE concept_ancestor (
  ancestor_concept_id LONG,
  descendant_concept_id LONG,
  min_levels_of_separation LONG,
  max_levels_of_separation LONG
) USING DELTA;
