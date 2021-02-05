-- Databricks notebook source
CREATE
OR REPLACE TABLE metadata (
  metadata_concept_id LONG,
  metadata_type_concept_id LONG,
  name STRING,
  value_as_string STRING,
  value_as_concept_id LONG,
  metadata_date DATE,
  metadata_datetime TIMESTAMP
) USING DELTA;

INSERT INTO
  metadata
VALUES
  (
    0,
    0,
    'OHDSI OMOP CDM Version',
    '6.0',
    0,
    CURRENT_DATE,
    CURRENT_TIMESTAMP
  );
--ZORDER BY (person_id)