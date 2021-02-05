CREATE
  OR REPLACE TABLE note_nlp (
    note_nlp_id LONG,
    note_id LONG,
    section_concept_id LONG,
    snippet STRING,
    offset STRING,
    lexical_variant STRING,
    note_nlp_concept_id LONG,
    nlp_system STRING,
    nlp_date DATE,
    nlp_datetime TIMESTAMP,
    term_exists STRING,
    term_temporal STRING,
    term_modifiers STRING,
    note_nlp_source_concept_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
