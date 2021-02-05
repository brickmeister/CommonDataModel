CREATE
OR REPLACE TABLE drug_strength (
  drug_concept_id LONG,
  ingredient_concept_id LONG,
  amount_value DOUBLE,
  amount_unit_concept_id LONG,
  numerator_value DOUBLE,
  numerator_unit_concept_id LONG,
  denominator_value DOUBLE,
  denominator_unit_concept_id LONG,
  box_size LONG,
  valid_start_date DATE,
  valid_end_date DATE,
  invalid_reason STRING
) USING DELTA;
