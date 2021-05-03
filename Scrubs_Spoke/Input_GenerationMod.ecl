// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Spoke';
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
  EXPORT spc_FILENAME := 'Spoke';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,first_name,last_name,job_title,company_name,validation_date,company_street_address,company_city,company_state,company_postal_code,company_phone_number,company_annual_revenue,company_business_description';
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
    + 'MODULE:Scrubs_Spoke\n'
    + 'FILENAME:Spoke\n'
    + 'NAMESCOPE:Input \n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_first_name:CUSTOM(Scrubs_Spoke.Functions.fn_valid_name>0)\n'
    + 'FIELDTYPE:invalid_last_name:CUSTOM(Scrubs_Spoke.Functions.fn_valid_name>0)\n'
    + 'FIELDTYPE:invalid_company_name:CUSTOM(Scrubs_Spoke.Functions.fn_valid_name>0)\n'
    + 'FIELDTYPE:invalid_validation_date:CUSTOM(Scrubs_Spoke.Functions.fn_valid_Date>0)\n'
    + 'FIELDTYPE:invalid_owner_name:CUSTOM(Scrubs_Spoke.Functions.fn_valid_name>0)\n'
    + 'FIELDTYPE:invalid_company_state:CUSTOM(Scrubs.Functions.fn_Valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:invalid_postal_code:CUSTOM(Scrubs.Functions.fn_valid_zip >0)\n'
    + 'FIELDTYPE:invalid_phone_number:CUSTOM(Scrubs.Functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:invalid_annual_revenue:CUSTOM(Scrubs.Functions.fn_numeric>0)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB \n'
    + '//---------------------------------------------------------------\n'
    + 'FIELD:first_name:TYPE(STRING50):LIKE(invalid_first_name):0,0\n'
    + 'FIELD:last_name:TYPE(STRING50):LIKE(invalid_last_name):0,0\n'
    + 'FIELD:job_title:TYPE(STRING125):0,0\n'
    + 'FIELD:company_name:TYPE(STRING255):LIKE(invalid_company_name):0,0\n'
    + 'FIELD:validation_date:TYPE(STRING19):0,0\n'
    + 'FIELD:company_street_address:TYPE(STRING100):0,0\n'
    + 'FIELD:company_city:TYPE(STRING40):0,0\n'
    + 'FIELD:company_state:TYPE(STRING5):LIKE(invalid_company_state):0,0\n'
    + 'FIELD:company_postal_code:TYPE(STRING19):LIKE(invalid_postal_code):0,0\n'
    + 'FIELD:company_phone_number:TYPE(STRING20):LIKE(invalid_phone_number):0,0\n'
    + 'FIELD:company_annual_revenue:TYPE(STRING30):LIKE(invalid_annual_revenue):0,0\n'
    + 'FIELD:company_business_description:TYPE(STRING255):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

