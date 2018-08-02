// Machine-readable versions of the spec file and subsets thereof
EXPORT raw_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Calbus';
  EXPORT spc_NAMESCOPE := 'raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Calbus\n'
    + 'FILENAME:Calbus \n'
    + 'NAMESCOPE:raw \n'
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
    + '// Remember to generate specificities and update the :0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + '\n'
    + 'FIELDTYPE:invalid_district:CUSTOM(Scrubs_Calbus.Functions.fn_district_code>0)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Calbus.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_account_type:ALLOW(SUT|)\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_Calbus.Functions.fn_chk_blanks>0) \n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_Calbus.Functions.fn_verify_state>0)   \n'
    + 'FIELDTYPE:invalid_zip_5:CUSTOM(Scrubs_Calbus.Functions.fn_verify_zip5>0)\n'
    + 'FIELDTYPE:invalid_zip_plus_4:CUSTOM(Scrubs_Calbus.Functions.fn_verify_zip4>0)\n'
    + 'FIELDTYPE:invalid_full_zip:CUSTOM(Scrubs_Calbus.Functions.fn_full_zip>0)\n'
    + 'FIELDTYPE:invalid_country_name:ALLOW(USA|)\n'
    + 'FIELDTYPE:invalid_start_date:CUSTOM(Scrubs_Calbus.Functions.fn_general_date>0)\n'
    + 'FIELDTYPE:invalid_ownership_code:ALLOW(B|C|D|E|F|G|K|L|O|P|R|S|T|V|)\n'
    + '\n'
    + 'FIELD:district_branch:TYPE(STRING3):LIKE(invalid_district):0,0\n'
    + 'FIELD:account_number:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:sub_account_number:TYPE(STRING5):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:district:TYPE(STRING3):LIKE(invalid_district):0,0\n'
    + 'FIELD:account_type:TYPE(STRING3):LIKE(invalid_account_type):0,0\n'
    + 'FIELD:firm_name:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:owner_name:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:business_street:TYPE(STRING40):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:business_city:TYPE(STRING30):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:business_state:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:business_zip_5:TYPE(STRING5):LIKE(invalid_zip_5):0,0\n'
    + 'FIELD:business_zip_plus_4:TYPE(STRING4):LIKE(invalid_zip_plus_4):0,0\n'
    + 'FIELD:business_foreign_zip:TYPE(STRING7):LIKE(invalid_full_zip):0,0\n'
    + 'FIELD:business_country_name:TYPE(STRING35):LIKE(invalid_country_name):0,0\n'
    + 'FIELD:start_date:TYPE(STRING8):LIKE(invalid_start_date):0,0\n'
    + 'FIELD:ownership_code:TYPE(STRING1):LIKE(invalid_ownership_code):0,0\n'
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
