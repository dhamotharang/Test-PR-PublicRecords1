// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_LaborActions_EBSA';
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
  EXPORT spc_FILENAME := 'LaborActions_EBSA';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dart_id,date_added,date_updated,website,state,casetype,plan_ein,plan_no,plan_year,plan_name,plan_administrator,admin_state,admin_zip_code,admin_zip_code4,closing_reason,closing_date,penalty_amount';
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
    + 'MODULE:Scrubs_LaborActions_EBSA\n'
    + 'FILENAME:LaborActions_EBSA\n'
    + '\n'
    + 'FIELDTYPE:Invalid_No:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Float:ALLOW(0123456789 .,-/)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ )\n'
    + 'FIELDTYPE:Invalid_AlphaNumChar:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789_.,-/&\\(\\))\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.Fn_Valid_Date > 0)\n'
    + 'FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)\n'
    + '\n'
    + 'FIELD:dart_id:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:date_added:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:date_updated:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:website:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(Invalid_State):0,0\n'
    + 'FIELD:casetype:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:plan_ein:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:plan_no:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:plan_year:TYPE(STRING):LIKE(Invalid_Float):0,0\n'
    + 'FIELD:plan_name:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:plan_administrator:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0\n'
    + 'FIELD:admin_state:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:admin_zip_code:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:admin_zip_code4:TYPE(STRING):LIKE(Invalid_No):0,0\n'
    + 'FIELD:closing_reason:TYPE(STRING):LIKE(Invalid_Alpha):0,0\n'
    + 'FIELD:closing_date:TYPE(STRING):LIKE(Invalid_Date):0,0\n'
    + 'FIELD:penalty_amount:TYPE(STRING):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

