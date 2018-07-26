// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Civil_Court';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := '';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_first_reported,dt_last_reported,process_date,vendor,state_origin,source_file,case_key,parent_case_key,court_code,court,case_number,case_type_code,case_type,case_title,case_cause_code,case_cause,manner_of_filing_code,manner_of_filing,filing_date,manner_of_judgmt_code,manner_of_judgmt,judgmt_date,ruled_for_against_code,ruled_for_against,judgmt_type_code,judgmt_type,judgmt_disposition_date,judgmt_disposition_code,judgmt_disposition,disposition_code,disposition_description,disposition_date,suit_amount,award_amount';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
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
    + 'MODULE:<EnterModuleNameHere>\n'
    + 'FILENAME:<FileName>\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:dt_first_reported:TYPE(STRING8):0,0\n'
    + 'FIELD:dt_last_reported:TYPE(STRING8):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):0,0\n'
    + 'FIELD:vendor:TYPE(STRING2):0,0\n'
    + 'FIELD:state_origin:TYPE(STRING2):0,0\n'
    + 'FIELD:source_file:TYPE(STRING20):0,0\n'
    + 'FIELD:case_key:TYPE(STRING60):0,0\n'
    + 'FIELD:parent_case_key:TYPE(STRING60):0,0\n'
    + 'FIELD:court_code:TYPE(STRING10):0,0\n'
    + 'FIELD:court:TYPE(STRING60):0,0\n'
    + 'FIELD:case_number:TYPE(STRING35):0,0\n'
    + 'FIELD:case_type_code:TYPE(STRING10):0,0\n'
    + 'FIELD:case_type:TYPE(STRING60):0,0\n'
    + 'FIELD:case_title:TYPE(STRING175):0,0\n'
    + 'FIELD:case_cause_code:TYPE(STRING10):0,0\n'
    + 'FIELD:case_cause:TYPE(STRING60):0,0\n'
    + 'FIELD:manner_of_filing_code:TYPE(STRING10):0,0\n'
    + 'FIELD:manner_of_filing:TYPE(STRING50):0,0\n'
    + 'FIELD:filing_date:TYPE(STRING8):0,0\n'
    + 'FIELD:manner_of_judgmt_code:TYPE(STRING10):0,0\n'
    + 'FIELD:manner_of_judgmt:TYPE(STRING50):0,0\n'
    + 'FIELD:judgmt_date:TYPE(STRING8):0,0\n'
    + 'FIELD:ruled_for_against_code:TYPE(STRING5):0,0\n'
    + 'FIELD:ruled_for_against:TYPE(STRING20):0,0\n'
    + 'FIELD:judgmt_type_code:TYPE(STRING10):0,0\n'
    + 'FIELD:judgmt_type:TYPE(STRING65):0,0\n'
    + 'FIELD:judgmt_disposition_date:TYPE(STRING8):0,0\n'
    + 'FIELD:judgmt_disposition_code:TYPE(STRING10):0,0\n'
    + 'FIELD:judgmt_disposition:TYPE(STRING65):0,0\n'
    + 'FIELD:disposition_code:TYPE(STRING10):0,0\n'
    + 'FIELD:disposition_description:TYPE(STRING65):0,0\n'
    + 'FIELD:disposition_date:TYPE(STRING8):0,0\n'
    + 'FIELD:suit_amount:TYPE(STRING15):0,0\n'
    + 'FIELD:award_amount:TYPE(STRING15):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

