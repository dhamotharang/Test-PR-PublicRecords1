// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT DeactMain2_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Phonesinfo';
  EXPORT spc_NAMESCOPE := 'DeactMain2';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Phonesinfo';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,groupid,vendor_first_reported_dt,vendor_last_reported_dt,action_code,timestamp,phone,phone_swap,filename,carrier_name,filedate,swap_start_dt,swap_end_dt,deact_code,deact_start_dt,deact_end_dt,react_start_dt,react_end_dt,is_react,is_deact,porting_dt,pk_carrier_name,days_apart';
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
    + 'MODULE:Scrubs_Phonesinfo\n'
    + 'FILENAME:Phonesinfo\n'
    + 'NAMESCOPE:DeactMain2\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(-0123456789 ) \n'
    + 'FIELDTYPE:Invalid_DeactCode:ENUM(DE|SU|) \n'
    + 'FIELDTYPE:Invalid_YN:ENUM(Y|N|P)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0,\'future\')\n'
    + '\n'
    + '\n'
    + 'FIELD:groupid:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_first_reported_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_last_reported_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:action_code:TYPE(STRING2):0,0\n'
    + 'FIELD:timestamp:LIKE(Invalid_Date):TYPE(STRING14):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:phone_swap:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:filename:TYPE(STRING255):0,0\n'
    + 'FIELD:carrier_name:TYPE(STRING60):0,0\n'
    + 'FIELD:filedate:LIKE(Invalid_Date):TYPE(STRING):0,0\n'
    + 'FIELD:swap_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:swap_end_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:deact_code:LIKE(Invalid_DeactCode):TYPE(STRING2):0,0\n'
    + 'FIELD:deact_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:deact_end_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:react_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:react_end_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:is_react:LIKE(Invalid_YN):TYPE(STRING2):0,0\n'
    + 'FIELD:is_deact:LIKE(Invalid_YN):TYPE(STRING2):0,0\n'
    + 'FIELD:porting_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:pk_carrier_name:TYPE(STRING):0,0\n'
    + 'FIELD:days_apart:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

