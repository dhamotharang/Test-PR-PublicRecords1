// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.1';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Txbus';
  EXPORT spc_NAMESCOPE := 'Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Txbus';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,taxpayer_number,outlet_number,taxpayer_name,taxpayer_address,taxpayer_city,taxpayer_state,taxpayer_zipcode,taxpayer_county_code,taxpayer_phone,taxpayer_org_type,outlet_name,outlet_address,outlet_city,outlet_state,outlet_zipcode,outlet_county_code,outlet_phone,outlet_naics_code,outlet_city_limits_indicator,outlet_permit_issue_date,outlet_first_sales_date,crlf';
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
    + 'MODULE:Scrubs_Txbus\n'
    + 'FILENAME:Txbus\n'
    + 'NAMESCOPE:Raw\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_taxpayer_number:CUSTOM(Scrubs_Txbus.Functions.fn_numeric>0,11)\n'
    + 'FIELDTYPE:invalid_outlet_number:CUSTOM(Scrubs_Txbus.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_taxpayer_name:SPACES( ):ALLOW( &\',-.0123457ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '//FIELDTYPE:taxpayer_address:SPACES( ):ALLOW( #-/0123456789:ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(16,13,15,17,14,18,11,19,20,12,21,10,22,23,25,24,26,27,28,31,29,40,30,32,9,33,35,34,36,8,39,37,38):WORDS(3,4,5,6,7,8,2,9):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:invalid_taxpayer_state:CUSTOM(Scrubs_Txbus.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_taxpayer_zipcode:CUSTOM(Scrubs_Txbus.Functions.fn_verify_zip5>0)\n'
    + 'FIELDTYPE:invalid_taxpayer_county_code:CUSTOM(Scrubs_Txbus.Functions.fn_numeric>0,3)\n'
    + 'FIELDTYPE:invalid_taxpayer_phone:CUSTOM(Scrubs_Txbus.Functions.fn_verify_phone>0) \n'
    + 'FIELDTYPE:invalid_taxpayer_org_type:CUSTOM(Scrubs_Txbus.Functions.fn_check_taxpayer_org_type>0)\n'
    + 'FIELDTYPE:outlet_name:SPACES( ):ALLOW( #&\',-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + '//FIELDTYPE:outlet_address:SPACES( ):ALLOW( #-0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(16,15,17,14,18,19,13,20,21,22,12,23,24,25,26,27,11,28,29,30,31,10,32,33,34,9,35,40,36,37,39):WORDS(3,4,5,6,7,2,8):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:invalid_outlet_state:CUSTOM(Scrubs_Txbus.Functions.fn_verify_state>0)\n'
    + 'FIELDTYPE:invalid_outlet_zipcode:CUSTOM(Scrubs_Txbus.Functions.fn_verify_zip5>0)\n'
    + 'FIELDTYPE:invalid_outlet_county_code:CUSTOM(Scrubs_Txbus.Functions.fn_numeric>0,3)\n'
    + 'FIELDTYPE:invalid_outlet_phone:CUSTOM(Scrubs_Txbus.Functions.fn_verify_phone>0) \n'
    + 'FIELDTYPE:invalid_outlet_naics_code:CUSTOM(Scrubs_Txbus.Functions.fn_naics_code>0)\n'
    + 'FIELDTYPE:invalid_outlet_city_limits_indicator:ENUM(Y|N|)\n'
    + 'FIELDTYPE:invalid_outlet_permit_issue_date:CUSTOM(Scrubs_Txbus.Functions.fn_general_date>0)\n'
    + 'FIELDTYPE:invalid_outlet_first_sales_date:CUSTOM(Scrubs_Txbus.Functions.fn_general_date>0)\n'
    + '//FIELDTYPE:crlf:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN) \n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + 'FIELD:taxpayer_number:TYPE(STRING11):LIKE(invalid_taxpayer_number):0,0\n'
    + 'FIELD:outlet_number:TYPE(STRING5):LIKE(invalid_outlet_number):0,0\n'
    + 'FIELD:taxpayer_name:TYPE(STRING50):LIKE(invalid_taxpayer_name):0,0\n'
    + 'FIELD:taxpayer_address:TYPE(STRING40):0,0\n'
    + 'FIELD:taxpayer_city:TYPE(STRING20):0,0\n'
    + 'FIELD:taxpayer_state:TYPE(STRING2):LIKE(invalid_taxpayer_state):0,0\n'
    + 'FIELD:taxpayer_zipcode:TYPE(STRING5):LIKE(invalid_taxpayer_zipcode):0,0\n'
    + 'FIELD:taxpayer_county_code:TYPE(STRING3):LIKE(invalid_taxpayer_zipcode):0,0\n'
    + 'FIELD:taxpayer_phone:TYPE(STRING10):LIKE(invalid_taxpayer_zipcode):0,0\n'
    + 'FIELD:taxpayer_org_type:TYPE(STRING2):0,0\n'
    + 'FIELD:outlet_name:TYPE(STRING50):LIKE(invalid_taxpayer_zipcode):0,0\n'
    + 'FIELD:outlet_address:TYPE(STRING40):0,0\n'
    + 'FIELD:outlet_city:TYPE(STRING20):0,0\n'
    + 'FIELD:outlet_state:TYPE(STRING2):LIKE(invalid_outlet_state):0,0\n'
    + 'FIELD:outlet_zipcode:TYPE(STRING5):LIKE(invalid_outlet_zipcode):0,0\n'
    + 'FIELD:outlet_county_code:TYPE(STRING3):LIKE(invalid_outlet_county_code):0,0\n'
    + 'FIELD:outlet_phone:TYPE(STRING10):LIKE(invalid_outlet_phone):0,0\n'
    + 'FIELD:outlet_naics_code:TYPE(STRING6):LIKE(invalid_outlet_naics_code):0,0\n'
    + 'FIELD:outlet_city_limits_indicator:TYPE(STRING1):LIKE(invalid_outlet_city_limits_indicator):0,0\n'
    + 'FIELD:outlet_permit_issue_date:TYPE(STRING8):LIKE(invalid_outlet_permit_issue_date):0,0\n'
    + 'FIELD:outlet_first_sales_date:TYPE(STRING8):LIKE(invalid_outlet_first_sales_date):0,0\n'
    + 'FIELD:crlf:TYPE(STRING2):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

