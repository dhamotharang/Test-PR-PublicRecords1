// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_CA_Orange_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FBNV2';
  EXPORT spc_NAMESCOPE := 'Input_CA_Orange';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'FBNV2';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,REGIS_NBR,BUSINESS_NAME,PHONE_NBR,FILE_DATE,FIRST_NAME,MIDDLE_NAME,LAST_NAME_COMPANY,OWNER_ADDRESS,prep_bus_addr_line1,prep_bus_addr_line_last,prep_owner_addr_line1,prep_owner_addr_line_last,cname';
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
    + 'MODULE:Scrubs_FBNV2\n'
    + 'FILENAME:FBNV2\n'
    + 'NAMESCOPE:Input_CA_Orange\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs.Functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:invalid_past_date:CUSTOM(Scrubs.fn_valid_pastDate > 0)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + '// FIELD::process_date:TYPE(STRING):0,0\t\n'
    + 'FIELD:REGIS_NBR:TYPE(STRING20):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:BUSINESS_LETTER:TYPE(STRING):0,0\t\n'
    + 'FIELD:BUSINESS_NAME:TYPE(STRING192):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:ADDRESS:TYPE(STRING):0,0\t\n'
    + '// FIELD:CITY:TYPE(STRING):0,0\t\n'
    + '// FIELD:STATE:TYPE(STRING):0,0\t\n'
    + '// FIELD:ZIP_CODE:TYPE(STRING):0,0\t\n'
    + 'FIELD:PHONE_NBR:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:FILE_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + '// FIELD:DOCETYEP:TYPE(STRING):0,0\t\n'
    + '// FIELD:OWNER_NBR:TYPE(STRING):0,0\t\n'
    + 'FIELD:FIRST_NAME:TYPE(STRING55):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:MIDDLE_NAME:TYPE(STRING55):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:LAST_NAME_COMPANY:TYPE(STRING55):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:OWNER_ADDRESS:TYPE(STRING40):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:OWNER_CITY:TYPE(STRING):0,0\t\n'
    + '// FIELD:OWNER_STATE:TYPE(STRING):0,0\t\n'
    + '// FIELD:OWNER_ZIP_CODE:TYPE(STRING):0,0\t\n'
    + '// FIELD:BUSINESS_TYPE:TYPE(STRING):0,0\n'
    + 'FIELD:prep_bus_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_bus_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_owner_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_owner_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + '// FIELD:title:TYPE(STRING):0,0\n'
    + '// FIELD:fname:TYPE(STRING):0,0\n'
    + '// FIELD:mname:TYPE(STRING):0,0\n'
    + '// FIELD:lname:TYPE(STRING):0,0\n'
    + '// FIELD:name_suffix:TYPE(STRING):0,0\n'
    + '// FIELD:name_score:TYPE(STRING):0,0\n'
    + 'FIELD:cname:TYPE(STRING55):LIKE(invalid_mandatory):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

