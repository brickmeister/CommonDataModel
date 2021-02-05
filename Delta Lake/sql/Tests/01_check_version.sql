--
-- Check current metadata version
--

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