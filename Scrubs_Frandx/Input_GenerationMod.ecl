// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Frandx';
  EXPORT spc_NAMESCOPE := 'Input';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Frandx';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,address1,address2,brand_name,city,company_name,exec_full_name,franchisee_id,fruns,industry,industry_type,phone,phone_extension,record_id,relationship_code,secondary_phone,sector,sic_code,state,unit_flag,zip_code,zip_code4';
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
    + 'MODULE:Scrubs_Frandx\n'
    + 'FILENAME:Frandx\n'
    + 'NAMESCOPE:Input\n'
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
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_alpha:CUSTOM(Scrubs.Functions.fn_ASCII_printable>0)\n'
    + 'FIELDTYPE:invalid_company_name:CUSTOM(Scrubs.Functions.fn_ASCII_printable>0)\n'
    + 'FIELDTYPE:invalid_franchisee_id:CUSTOM(Scrubs.Functions.fn_numeric>0,6)\n'
    + 'FIELDTYPE:invalid_fruns:CUSTOM(Scrubs.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_industry_type:ENUM(NON-FOOD|FOOD)\n'
    + 'FIELDTYPE:invalid_nonempty_number:CUSTOM(Scrubs.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs.Functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:invalid_relationship_code:ENUM(ST|AD|AR)\n'
    + 'FIELDTYPE:invalid_secondary_phone:CUSTOM(Scrubs.Functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:invalid_sic_code:CUSTOM(Scrubs.functions.fn_valid_SicCode > 0)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_unit_flag:ENUM(U|H|UN|HQ))\n'
    + 'FIELDTYPE:invalid_zip_code:CUSTOM(Scrubs.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_zip_code4:CUSTOM(Scrubs.Functions.fn_numeric_optional>0,4)\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:address1:TYPE(STRING):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:address2:TYPE(STRING):0,0\n'
    + 'FIELD:brand_name:TYPE(STRING):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:city:TYPE(STRING):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:company_name:TYPE(STRING):LIKE(invalid_company_name):0,0\n'
    + 'FIELD:exec_full_name:TYPE(STRING):0,0\n'
    + 'FIELD:franchisee_id:TYPE(STRING):LIKE(invalid_franchisee_id):0,0\n'
    + 'FIELD:fruns:TYPE(STRING):LIKE(invalid_fruns):0,0\n'
    + 'FIELD:industry:TYPE(STRING):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:industry_type:TYPE(STRING):LIKE(invalid_industry_type):0,0\n'
    + 'FIELD:phone:TYPE(STRING):LIKE(invalid_phone):0,0\n'
    + 'FIELD:phone_extension:TYPE(STRING):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:record_id:TYPE(STRING):LIKE(invalid_nonempty_number):0,0\n'
    + 'FIELD:relationship_code:TYPE(STRING):LIKE(invalid_relationship_code):0,0\n'
    + 'FIELD:secondary_phone:TYPE(STRING):LIKE(invalid_secondary_phone):0,0\n'
    + 'FIELD:sector:TYPE(STRING):LIKE(invalid_alpha):0,0\n'
    + 'FIELD:sic_code:TYPE(STRING):LIKE(invalid_sic_code):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(invalid_state):0,0\n'
    + 'FIELD:unit_flag:TYPE(STRING):LIKE(invalid_unit_flag):0,0\n'
    + 'FIELD:zip_code:TYPE(STRING):LIKE(invalid_zip_code):0,0\n'
    + 'FIELD:zip_code4:TYPE(STRING):LIKE(invalid_zip_code4):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

