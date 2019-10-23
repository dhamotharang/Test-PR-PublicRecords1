// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT MBS_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_MBS';
  EXPORT spc_NAMESCOPE := 'MBS';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'MBS';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,fdn_file_info_id,fdn_file_code,gc_id,file_type,description,primary_source_entity,ind_type,update_freq,expiration_days,post_contract_expiration_days,status,product_include,expectation_of_victim_entities,suspected_discrepancy,confidence_that_activity_was_deceitful,workflow_stage_committed,workflow_stage_detected,channels,threat,alert_level,entity_type,entity_sub_type,role,evidence,date_added,user_added,date_changed,user_changed';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_MBS\n'
    + 'FILENAME:MBS\n'
    + 'NAMESCOPE:MBS \n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField> \n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName> \n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LENGTHS(0,4..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_alphanumeric:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=!+&,./#()_)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( -:)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:fdn_file_info_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:fdn_file_code:TYPE(STRING100):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:gc_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:file_type:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:description:TYPE(STRING256):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:primary_source_entity:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:ind_type:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:update_freq:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:expiration_days:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:post_contract_expiration_days:LIKE(invalid_numeric):TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:status:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:product_include:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:expectation_of_victim_entities:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:suspected_discrepancy:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:confidence_that_activity_was_deceitful:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:workflow_stage_committed:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:workflow_stage_detected:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:channels:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:threat:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:alert_level:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:entity_type:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:entity_sub_type:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:role:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:evidence:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:date_added:TYPE(STRING20):0,0\n'
    + 'FIELD:user_added:TYPE(STRING30):0,0\n'
    + 'FIELD:date_changed:TYPE(STRING20):0,0\n'
    + 'FIELD:user_changed:TYPE(STRING30):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

