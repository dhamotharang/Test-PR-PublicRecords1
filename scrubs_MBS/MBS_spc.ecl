﻿MODULE:Scrubs_MBS
FILENAME:MBS
NAMESCOPE:MBS 
// Uncomment up to NINES for internal or external adl
// IDFIELD:EXISTS:<NameOfIDField>
// RIDFIELD:<NameOfRidField> 
// RECORDS:<NumberOfRecordsInDataFile>
// POPULATION:<ExpectedNumberOfEntitiesInDataFile>
// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
// Uncomment Process if doing external adl
// PROCESS:<ProcessName>
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// FUZZY can be used to create new types of FUZZY linking
FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LENGTHS(0,4..):ONFAIL(BLANK)
FIELDTYPE:invalid_alphanumeric:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=!+&,./#()_)
FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( -:)
FIELDTYPE:invalid_numeric:ALLOW(0123456789)
// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.
// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running
// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.
FIELD:fdn_file_info_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:fdn_file_code:TYPE(STRING100):LIKE(invalid_alphanumeric):0,0
FIELD:gc_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:file_type:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0
FIELD:description:TYPE(STRING256):LIKE(invalid_alphanumeric):0,0
FIELD:primary_source_entity:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0
FIELD:ind_type:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:update_freq:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0
FIELD:expiration_days:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:post_contract_expiration_days:LIKE(invalid_numeric):TYPE(UNSIGNED6):0,0
FIELD:status:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0
FIELD:product_include:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0
FIELD:expectation_of_victim_entities:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:suspected_discrepancy:TYPE(UNSIGNED2):0,0
FIELD:confidence_that_activity_was_deceitful:TYPE(UNSIGNED2):0,0
FIELD:workflow_stage_committed:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:workflow_stage_detected:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:channels:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:threat:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:alert_level:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:entity_type:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:entity_sub_type:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:role:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:evidence:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0
FIELD:date_added:TYPE(STRING20):0,0
FIELD:user_added:TYPE(STRING30):0,0
FIELD:date_changed:TYPE(STRING20):0,0
FIELD:user_changed:TYPE(STRING30):0,0
// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking
