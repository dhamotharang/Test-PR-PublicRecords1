// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_DL_WY_MEDCERT';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_DL_WY_MEDCERT\n'
    + 'FILENAME:In_WY_MEDCERT\n'
    + '\n'
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
    + '\n'
    + 'FIELDTYPE:invalid_Past_Date:CUSTOM(Scrubs_DL_WY_MEDCERT.Functions.fn_valid_past_date>0)\n'
    + 'FIELDTYPE:invalid_General_Date:CUSTOM(Scrubs_DL_WY_MEDCERT.Functions.fn_valid_general_Date>0)\n'
    + 'FIELDTYPE:invalid_orig_name:CUSTOM(Scrubs_DL_WY_MEDCERT.functions.fn_chk_people_names>0,orig_middle_name,orig_last_name)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_DL_WY_MEDCERT.functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_DL_WY_MEDCERT.Functions.fn_chk_blanks>0)  \n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_DL_WY_MEDCERT.Functions.fn_verify_state>0)    \n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_DL_WY_MEDCERT.Functions.fn_verify_zip5>0)\n'
    + 'FIELDTYPE:invalid_orig_code:ALLOW(1|2|-|A|B|C|H|I|M|N|P|R|S|T|X|Z|)\n'
    + 'FIELDTYPE:invalid_med_cert_status:ALLOW(C|E|N|)\n'
    + 'FIELDTYPE:invalid_med_cert_type:ALLOW(A|I|N|)\n'
    + 'FIELDTYPE:invalid_clean_name:CUSTOM(Scrubs_DL_WY_MEDCERT.functions.fn_chk_people_names>0,clean_name_middle,clean_name_last)\n'
    + '\n'
    + 'FIELD:append_process_date:TYPE(STRING8):LIKE(invalid_Past_Date):0,0\n'
    + 'FIELD:orig_first_name:TYPE(STRING12):LIKE(invalid_orig_name):0,0\n'
    + 'FIELD:orig_middle_name:TYPE(STRING12):0,0\n'
    + 'FIELD:orig_last_name:TYPE(STRING20):0,0\n'
    + 'FIELD:mailing_street_addr_1:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:mailing_city_1:TYPE(STRING21):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:mailing_state_1:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:mailing_zip_code_1:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + 'FIELD:phys_street_addr_2:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:phys_city_2:TYPE(STRING21):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:phys_state_2:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:phys_zip_code_2:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + 'FIELD:orig_dl_number:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:orig_dob:TYPE(STRING8):LIKE(invalid_Past_Date):0,0\n'
    + 'FIELD:orig_code_1:TYPE(STRING1):LIKE(invalid_orig_code):0,0\n'
    + 'FIELD:orig_code_2:TYPE(STRING1):LIKE(invalid_orig_code):0,0\n'
    + 'FIELD:orig_code_3:TYPE(STRING1):LIKE(invalid_orig_code):0,0\n'
    + 'FIELD:orig_code_4:TYPE(STRING1):LIKE(invalid_orig_code):0,0\n'
    + 'FIELD:orig_code_5:TYPE(STRING1):LIKE(invalid_orig_code):0,0\n'
    + 'FIELD:orig_code_6:TYPE(STRING1):LIKE(invalid_orig_code):0,0\n'
    + 'FIELD:orig_code_7:TYPE(STRING1):LIKE(invalid_orig_code):0,0\n'
    + 'FIELD:orig_code_8:TYPE(STRING1):LIKE(invalid_orig_code):0,0\n'
    + 'FIELD:orig_issue_date:TYPE(STRING8):LIKE(invalid_Past_Date):0,0\n'
    + 'FIELD:orig_expire_date:TYPE(STRING8):LIKE(invalid_General_Date):0,0\n'
    + 'FIELD:med_cert_status:TYPE(STRING1):LIKE(invalid_med_cert_status):0,0\n'
    + 'FIELD:med_cert_type:TYPE(STRING2):LIKE(invalid_med_cert_type):0,0\n'
    + 'FIELD:med_cert_expire_date:TYPE(STRING8):LIKE(invalid_General_Date):0,0\n'
    + 'FIELD:name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_prefix:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_first:TYPE(STRING20):LIKE(invalid_clean_name):0,0\n'
    + 'FIELD:clean_name_middle:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_name_last:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_score:TYPE(STRING3):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
