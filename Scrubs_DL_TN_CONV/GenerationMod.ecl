// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_DL_TN_CONV';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_DL_TN_CONV\n'
    + 'FILENAME:In_tn_conv\n'
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
    + '\n'
    + 'FIELDTYPE:invalid_past_date:CUSTOM(Scrubs_DL_TN_CONV.Functions.fn_valid_past_date>0)\n'
    + 'FIELDTYPE:invalid_dl_nbr:CUSTOM(Scrubs_DL_TN_CONV.Functions.fn_check_dl_number>0)\n'
    + 'FIELDTYPE:invalid_action_code:CUSTOM(Scrubs_DL_TN_CONV.Functions.fn_action_code>0)\n'
    + 'FIELDTYPE:invalid_lname:CUSTOM(Scrubs_DL_TN_CONV.Functions.fn_valid_lname>0)\n'
    + 'FIELDTYPE:invalid_county_code:CUSTOM(Scrubs_DL_TN_CONV.Functions.fn_county_code>0)\n'
    + 'FIELDTYPE:invalid_filler_data:CUSTOM(Scrubs_DL_TN_CONV.Functions.fn_filler_data>0)\n'
    + '\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:dl_number:TYPE(STRING9):LIKE(invalid_dl_nbr):0,0\n'
    + 'FIELD:birthdate:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:action_code:TYPE(STRING3):LIKE(invalid_action_code):0,0\n'
    + 'FIELD:event_date:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:post_date:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:last_name:TYPE(STRING29):LIKE(invalid_lname):0,0\n'
    + 'FIELD:county_code:TYPE(STRING2):LIKE(invalid_county_code):0,0\n'
    + 'FIELD:filler:TYPE(STRING131):LIKE(invalid_filler_data):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
