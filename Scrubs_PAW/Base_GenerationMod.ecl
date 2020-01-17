// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Base_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PAW';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'PAW';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,contact_id,company_phone,company_name,active_phone_flag,source_count,source,record_type,record_sid,global_sid,GLB,lname,fname,dt_last_seen,dt_first_seen,RawAid,zip,state,bdid,zip4,geo_long,geo_lat,county,company_zip,company_state,Company_RawAid,company_zip4,msa,did,ssn,phone,predir,company_predir,company_postdir,postdir,from_hdr,dead_flag';
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
    + 'MODULE:Scrubs_PAW\n'
    + 'FILENAME:PAW\n'
    + 'NAMESCOPE:Base\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_county:CUSTOM(Scrubs.Functions.fn_numeric_optional > 0,3)\n'
    + 'FIELDTYPE:invalid_dead_flag:ENUM(0|1)\n'
    + 'FIELDTYPE:invalid_direction:ENUM(E|N|S|W|NE|NW|SE|SW|)\n'
    + 'FIELDTYPE:invalid_from_hdr:ENUM(Y|N)\n'
    + 'FIELDTYPE:invalid_geo:CUSTOM(Scrubs.Functions.fn_geo_coord > 0)\n'
    + 'FIELDTYPE:invalid_glb:ENUM(Y|N)\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_msa:CUSTOM(Scrubs.Functions.fn_numeric_optional > 0,4)\n'
    + 'FIELDTYPE:invalid_name:CUSTOM(Scrubs_PAW.Functions.fn_invalid_name > 0)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_numeric_or_blank:CUSTOM(Scrubs.Functions.fn_numeric_optional > 0)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_PAW.Functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:invalid_phone_flag:ENUM(Y|N)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(C|H)\n'
    + 'FIELDTYPE:invalid_reformated_date:CUSTOM(Scrubs.Functions.fn_valid_GeneralDate > 0)\n'
    + 'FIELDTYPE:invalid_st:CUSTOM(Scrubs.Functions.fn_Valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs.Functions.fn_valid_zip>0)\n'
    + 'FIELDTYPE:invalid_zip4:CUSTOM(Scrubs_PAW.Functions.fn_verify_zip4>0)\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB \n'
    + '//---------------------------------------------------------------\n'
    + 'FIELD:contact_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:company_phone:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:company_name:TYPE(STRING120):LIKE(invalid_name):0,0\n'
    + 'FIELD:active_phone_flag:TYPE(STRING1):LIKE(invalid_phone_flag):0,0\n'
    + 'FIELD:source_count:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:source:TYPE(STRING2):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + 'FIELD:record_sid:TYPE(UNSIGNED8):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:global_sid:TYPE(UNSIGNED4):LIKE(invalid_numeric_or_blank):0,00\n'
    + 'FIELD:GLB:TYPE(STRING1):LIKE(invalid_glb):0,0\n'
    + 'FIELD:lname:TYPE(STRING20):LIKE(invalid_name):0,0\n'
    + 'FIELD:fname:TYPE(STRING20):LIKE(invalid_name):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(STRING8):LIKE(invalid_reformated_date):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(STRING8):LIKE(invalid_reformated_date):0,0\n'
    + 'FIELD:RawAid:TYPE(UNSIGNED8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(invalid_st):0,0 \n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(invalid_zip4):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):LIKE(invalid_geo):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):LIKE(invalid_geo):0,0\n'
    + 'FIELD:county:TYPE(STRING3):LIKE(invalid_county):0,0\n'
    + 'FIELD:company_zip:TYPE(STRING5):LIKE(invalid_zip5):0,0\n'
    + 'FIELD:company_state:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + 'FIELD:Company_RawAid:TYPE(UNSIGNED8):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:company_zip4:TYPE(STRING4):LIKE(invalid_zip4):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):LIKE(invalid_msa):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:ssn:TYPE(STRING9):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:phone:TYPE(STRING10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:company_predir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:company_postdir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:from_hdr:TYPE(STRING1):LIKE(invalid_from_hdr):0,0\n'
    + 'FIELD:dead_flag:TYPE(UNSIGNED1):LIKE(invalid_dead_flag):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

