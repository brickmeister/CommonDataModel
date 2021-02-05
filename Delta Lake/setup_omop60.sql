-- Databricks notebook source
-- MAGIC %md
-- MAGIC 
-- MAGIC # This is an implementation of OMOP v6.0 on Databricks Delta Lake

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Setup some widgets

-- COMMAND ----------

-- MAGIC %python
-- MAGIC 
-- MAGIC """
-- MAGIC Create a widget to get the database name
-- MAGIC """
-- MAGIC 
-- MAGIC dbutils.widgets.text("DATABASE_NAME", "OMOP60")
-- MAGIC dbutils.widgets.text("DATABASE_LOCATION", "/FileStore/tables/OMOP60")

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Clean Up Databases

-- COMMAND ----------

-- DBTITLE 1,Drop Existing OMOP Database
-- MAGIC %python
-- MAGIC 
-- MAGIC """
-- MAGIC Drop current database name,
-- MAGIC Drop tables as well
-- MAGIC """
-- MAGIC 
-- MAGIC spark.sql(f"""
-- MAGIC DROP DATABASE IF EXISTS {dbutils.widgets.get('DATABASE_NAME')} 
-- MAGIC   CASCADE;
-- MAGIC """);

-- COMMAND ----------

-- DBTITLE 1,Create OMOP Lakehouse Database
-- MAGIC %python
-- MAGIC 
-- MAGIC """
-- MAGIC Create a OMOP Database
-- MAGIC """
-- MAGIC 
-- MAGIC spark.sql(f"""
-- MAGIC CREATE DATABASE IF NOT EXISTS {dbutils.widgets.get('DATABASE_NAME')}
-- MAGIC   LOCATION '{dbutils.widgets.get('DATABASE_LOCATION')}';
-- MAGIC """)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Create Table Schema

-- COMMAND ----------

-- DBTITLE 1,Use OMOP Database
USE OMOP60;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Concept

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC 
-- MAGIC --
-- MAGIC -- Create the concept table
-- MAGIC -- https://www.ohdsi.org/web/wiki/doku.php?id=documentation:cdm:concept
-- MAGIC --
-- MAGIC 
-- MAGIC CREATE OR REPLACE TABLE concept (concept_id LONG,
-- MAGIC                                  concept_name STRING,
-- MAGIC                                  domain_id STRING,
-- MAGIC                                  vocabulary_id STRING,
-- MAGIC                                  concept_class_id STRING,
-- MAGIC                                  standard_concept STRING,
-- MAGIC                                  concept_code STRING,
-- MAGIC                                  valid_start_date DATE,
-- MAGIC                                  valid_end_date DATE,
-- MAGIC                                  invalid_reason STRING) 
-- MAGIC   USING DELTA;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Domain

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC 
-- MAGIC --
-- MAGIC -- Create the domain table
-- MAGIC -- https://www.ohdsi.org/web/wiki/doku.php?id=documentation:cdm:domain
-- MAGIC --
-- MAGIC 
-- MAGIC CREATE OR REPLACE TABLE vocabulary (vocabulary_id STRING,
-- MAGIC                                     vocabulary_name STRING,
-- MAGIC                                     vocabulary_reference STRING,
-- MAGIC                                     vocabulary_version STRING,
-- MAGIC                                     vocabulary_concept_id LONG)
-- MAGIC   USING DELTA;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Vocabulary

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC 
-- MAGIC --
-- MAGIC -- Create the domain table
-- MAGIC -- https://www.ohdsi.org/web/wiki/doku.php?id=documentation:cdm:vocabulary
-- MAGIC --
-- MAGIC 
-- MAGIC CREATE OR REPLACE TABLE vocabulary (vocabulary_id STRING,
-- MAGIC                                     vocabulary_name STRING,
-- MAGIC                                     vocabulary_reference STRING,
-- MAGIC                                     vocabulary_version STRING,
-- MAGIC                                     vocabulary_concept_id LONG) 
-- MAGIC   USING DELTA;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Concept Class

-- COMMAND ----------

--
-- Create the domain table
-- https://www.ohdsi.org/web/wiki/doku.php?id=documentation:cdm:concept_class
--

CREATE OR REPLACE TABLE concept_class (concept_class_id STRING,
                                       concept_class_name STRING,
                                       concept_class_concept_id LONG)
  USING DELTA;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ### Concept Relationship

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC 
-- MAGIC --
-- MAGIC -- Create the domain table
-- MAGIC -- https://www.ohdsi.org/web/wiki/doku.php?id=documentation:cdm:concept_relationship
-- MAGIC --
-- MAGIC 
-- MAGIC CREATE OR REPLACE TABLE concept_relationship (concept_id_1 LONG,
-- MAGIC                                               concept_id_2 LONG,
-- MAGIC                                               relationship_id STRING,
-- MAGIC                                               valid_start_date DATE,
-- MAGIC                                               valid_end_date DATE,
-- MAGIC                                               invalid_reason STRING)
-- MAGIC   USING DELTA;

-- COMMAND ----------

-- DBTITLE 1,OMOP Tables



CREATE
OR REPLACE TABLE relationship (
  relationship_id STRING,
  relationship_name STRING,
  is_hierarchical STRING,
  defines_ancestry STRING,
  reverse_relationship_id STRING,
  relationship_concept_id LONG
) USING DELTA;
CREATE
OR REPLACE TABLE concept_synonym (
  concept_id LONG,
  concept_synonym_name STRING,
  language_concept_id LONG
) USING DELTA;
CREATE
OR REPLACE TABLE concept_ancestor (
  ancestor_concept_id LONG,
  descendant_concept_id LONG,
  min_levels_of_separation LONG,
  max_levels_of_separation LONG
) USING DELTA;
CREATE
OR REPLACE TABLE source_to_concept_map (
  source_code STRING,
  source_concept_id LONG,
  source_vocabulary_id STRING,
  source_code_description STRING,
  target_concept_id LONG,
  target_vocabulary_id STRING,
  valid_start_date DATE,
  valid_end_date DATE,
  invalid_reason STRING
) USING DELTA;
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
CREATE
OR REPLACE TABLE cdm_source (
  cdm_source_name STRING,
  cdm_source_abbreviation STRING,
  cdm_holder STRING,
  source_description STRING,
  source_documentation_reference STRING,
  cdm_etl_reference STRING,
  source_release_date DATE,
  cdm_release_date DATE,
  cdm_version STRING,
  vocabulary_version STRING
) USING DELTA;
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
  CREATE
  OR REPLACE TABLE person (
    person_id LONG,
    gender_concept_id LONG,
    year_of_birth LONG,
    month_of_birth LONG,
    day_of_birth LONG,
    birth_datetime TIMESTAMP,
    death_datetime TIMESTAMP,
    race_concept_id LONG,
    ethnicity_concept_id LONG,
    location_id LONG,
    provider_id LONG,
    care_site_id LONG,
    person_source_value STRING,
    gender_source_value STRING,
    gender_source_concept_id LONG,
    race_source_value STRING,
    race_source_concept_id LONG,
    ethnicity_source_value STRING,
    ethnicity_source_concept_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE observation_period (
    observation_period_id LONG,
    person_id LONG,
    observation_period_start_date DATE,
    observation_period_end_date DATE,
    period_type_concept_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE specimen (
    specimen_id LONG,
    person_id LONG,
    specimen_concept_id LONG,
    specimen_type_concept_id LONG,
    specimen_date date,
    specimen_datetime TIMESTAMP,
    quantity DOUBLE,
    unit_concept_id LONG,
    anatomic_site_concept_id LONG,
    disease_status_concept_id LONG,
    specimen_source_id STRING,
    specimen_source_value STRING,
    unit_source_value STRING,
    anatomic_site_source_value STRING,
    disease_status_source_value STRING
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE visit_occurrence (
    visit_occurrence_id LONG,
    person_id LONG,
    visit_concept_id LONG,
    visit_start_date DATE,
    visit_start_datetime TIMESTAMP,
    visit_end_date DATE,
    visit_end_datetime TIMESTAMP,
    visit_type_concept_id LONG,
    provider_id LONG,
    care_site_id LONG,
    visit_source_value STRING,
    visit_source_concept_id LONG,
    admitted_from_concept_id LONG,
    admitted_from_source_value STRING,
    discharge_to_source_value STRING,
    discharge_to_concept_id LONG,
    preceding_visit_occurrence_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE visit_detail (
    visit_detail_id LONG,
    person_id LONG,
    visit_detail_concept_id LONG,
    visit_detail_start_date DATE,
    visit_detail_start_datetime TIMESTAMP,
    visit_detail_end_date DATE,
    visit_detail_end_datetime TIMESTAMP,
    visit_detail_type_concept_id LONG,
    provider_id LONG,
    care_site_id LONG,
    discharge_to_concept_id LONG,
    admitted_from_concept_id LONG,
    admitted_from_source_value STRING,
    visit_detail_source_value STRING,
    visit_detail_source_concept_id LONG,
    discharge_to_source_value STRING,
    preceding_visit_detail_id LONG,
    visit_detail_parent_id LONG,
    visit_occurrence_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
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
  CREATE
  OR REPLACE TABLE device_exposure (
    device_exposure_id LONG,
    person_id LONG,
    device_concept_id LONG,
    device_exposure_start_date DATE,
    device_exposure_start_datetime TIMESTAMP,
    device_exposure_end_date DATE,
    device_exposure_end_datetime TIMESTAMP,
    device_type_concept_id LONG,
    unique_device_id STRING,
    quantity LONG,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    device_source_value STRING,
    device_source_concept_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE condition_occurrence (
    condition_occurrence_id LONG,
    person_id LONG,
    condition_concept_id LONG,
    condition_start_date DATE,
    condition_start_datetime TIMESTAMP,
    condition_end_date DATE,
    condition_end_datetime TIMESTAMP,
    condition_type_concept_id LONG,
    condition_status_concept_id LONG,
    stop_reason STRING,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    condition_source_value STRING,
    condition_source_concept_id LONG,
    condition_status_source_value STRING
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE measurement (
    measurement_id LONG,
    person_id LONG,
    measurement_concept_id LONG,
    measurement_date DATE,
    measurement_datetime TIMESTAMP,
    measurement_time STRING,
    measurement_type_concept_id LONG,
    operator_concept_id LONG,
    value_as_number DOUBLE,
    value_as_concept_id LONG,
    unit_concept_id LONG,
    range_low DOUBLE,
    range_high DOUBLE,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    measurement_source_value STRING,
    measurement_source_concept_id LONG,
    unit_source_value STRING,
    value_source_value STRING
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE note (
    note_id LONG,
    person_id LONG,
    note_event_id LONG,
    note_event_field_concept_id LONG,
    note_date DATE,
    note_datetime TIMESTAMP,
    note_type_concept_id LONG,
    note_class_concept_id LONG,
    note_title STRING,
    note_text STRING,
    encoding_concept_id LONG,
    language_concept_id LONG,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    note_source_value STRING
  ) USING DELTA;
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
  CREATE
  OR REPLACE TABLE observation (
    observation_id LONG,
    person_id LONG,
    observation_concept_id LONG,
    observation_date DATE,
    observation_datetime TIMESTAMP,
    observation_type_concept_id LONG,
    value_as_number DOUBLE,
    value_as_string STRING,
    value_as_concept_id LONG,
    qualifier_concept_id LONG,
    unit_concept_id LONG,
    provider_id LONG,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    observation_source_value STRING,
    observation_source_concept_id LONG,
    unit_source_value STRING,
    qualifier_source_value STRING,
    observation_event_id LONG,
    obs_event_field_concept_id LONG,
    value_as_datetime TIMESTAMP
  ) USING DELTA;
CREATE
  OR REPLACE TABLE survey_conduct (
    survey_conduct_id LONG,
    person_id LONG,
    survey_concept_id LONG,
    survey_start_date DATE,
    survey_start_datetime TIMESTAMP,
    survey_end_date DATE,
    survey_end_datetime TIMESTAMP,
    provider_id LONG,
    assisted_concept_id LONG,
    respondent_type_concept_id LONG,
    timing_concept_id LONG,
    collection_method_concept_id LONG,
    assisted_source_value STRING,
    respondent_type_source_value STRING,
    timing_source_value STRING,
    collection_method_source_value STRING,
    survey_source_value STRING,
    survey_source_concept_id LONG,
    survey_source_identifier STRING,
    validated_survey_concept_id LONG,
    validated_survey_source_value STRING,
    survey_version_number STRING,
    visit_occurrence_id LONG,
    visit_detail_id LONG,
    response_visit_occurrence_id LONG
  ) USING DELTA;
CREATE
  OR REPLACE TABLE fact_relationship (
    domain_concept_id_1 LONG,
    fact_id_1 LONG,
    domain_concept_id_2 LONG,
    fact_id_2 LONG,
    relationship_concept_id LONG
  ) USING DELTA;
CREATE
  OR REPLACE TABLE location (
    location_id LONG,
    address_1 STRING,
    address_2 STRING,
    city STRING,
    state STRING,
    zip STRING,
    county STRING,
    country STRING,
    location_source_value STRING,
    latitude DOUBLE,
    longitude DOUBLE
  ) USING DELTA;
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
CREATE
  OR REPLACE TABLE care_site (
    care_site_id LONG,
    care_site_name STRING,
    place_of_service_concept_id LONG,
    location_id LONG,
    care_site_source_value STRING,
    place_of_service_source_value STRING
  ) USING DELTA;
CREATE
  OR REPLACE TABLE provider (
    provider_id LONG,
    provider_name STRING,
    npi STRING,
    dea STRING,
    specialty_concept_id LONG,
    care_site_id LONG,
    year_of_birth LONG,
    gender_concept_id LONG,
    provider_source_value STRING,
    specialty_source_value STRING,
    specialty_source_concept_id LONG,
    gender_source_value STRING,
    gender_source_concept_id LONG
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE payer_plan_period (
    payer_plan_period_id LONG,
    person_id LONG,
    contract_person_id LONG,
    payer_plan_period_start_date DATE,
    payer_plan_period_end_date date,
    payer_concept_id LONG,
    plan_concept_id LONG,
    contract_concept_id LONG,
    sponsor_concept_id LONG,
    stop_reason_concept_id LONG,
    payer_source_value STRING,
    payer_source_concept_id LONG,
    plan_source_value STRING,
    plan_source_concept_id LONG,
    contract_source_value STRING,
    contract_source_concept_id LONG,
    sponsor_source_value STRING,
    sponsor_source_concept_id LONG,
    family_source_value STRING,
    stop_reason_source_value STRING,
    stop_reason_source_concept_id LONG
  ) USING DELTA;
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
  CREATE
  OR REPLACE TABLE drug_era (
    drug_era_id LONG,
    person_id LONG,
    drug_concept_id LONG,
    drug_era_start_datetime TIMESTAMP,
    drug_era_end_datetime TIMESTAMP,
    drug_exposure_count LONG,
    gap_days LONG
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE dose_era (
    dose_era_id LONG,
    person_id LONG,
    drug_concept_id LONG,
    unit_concept_id LONG,
    dose_value DOUBLE,
    dose_era_start_datetime TIMESTAMP,
    dose_era_end_datetime TIMESTAMP
  ) USING DELTA;
--ZORDER BY (person_id)
  CREATE
  OR REPLACE TABLE condition_era (
    condition_era_id LONG,
    person_id LONG,
    condition_concept_id LONG,
    condition_era_start_datetime TIMESTAMP,
    condition_era_end_datetime TIMESTAMP,
    condition_occurrence_count LONG
  ) USING DELTA;

-- COMMAND ----------

-- DBTITLE 1,OMOP Result Tables
--ZORDER BY (subject_id)
CREATE
OR REPLACE TABLE cohort (
  cohort_definition_id LONG,
  subject_id LONG,
  cohort_start_date DATE,
  cohort_end_date DATE
) USING DELTA;
CREATE
OR REPLACE TABLE cohort_definition (
  cohort_definition_id LONG,
  cohort_definition_name STRING,
  cohort_definition_description STRING,
  definition_type_concept_id LONG,
  cohort_definition_syntax STRING,
  subject_concept_id LONG,
  cohort_initiation_date DATE
) USING DELTA;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC # Validate

-- COMMAND ----------

-- MAGIC %md
-- MAGIC 
-- MAGIC ## Metadata Version

-- COMMAND ----------

-- DBTITLE 1,Check Metadata Version
SELECT
  metadata_concept_id,
  metadata_type_concept_id,
  name,
  value_as_string,
  value_as_concept_id,
  metadata_date,
  metadata_datetime
FROM
  metadata;