// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FirstData';
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
  EXPORT spc_FILENAME := 'FirstData';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,process_date,filedate,record_type,action_code,cons_id,dl_state,dl_id,first_seen_date_true,last_seen_date,dispute_status,lex_id';
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
    + 'MODULE:Scrubs_FirstData\n'
    + 'FILENAME:FirstData\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_RecordType:ENUM(D|T)\n'
    + 'FIELDTYPE:Invalid_ActionType:ENUM(I|0|)\n'
    + 'FIELDTYPE:Invalid_ConsID:ALLOW(0123456789 ):LENGTHS(0,9)\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2)\n'
    + 'FIELDTYPE:Invalid_LexID:ALLOW(0123456789)\n'
    + '\n'
    + '\n'
    + 'FIELD:process_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:filedate:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:record_type:LIKE(Invalid_RecordType):TYPE(STRING1):0,0\n'
    + 'FIELD:action_code:LIKE(Invalid_ActionType):TYPE(STRING1):0,0\n'
    + 'FIELD:cons_id:LIKE(Invalid_ConsID):TYPE(STRING9):0,0\n'
    + 'FIELD:dl_state:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:dl_id:TYPE(STRING50):0,0\n'
    + 'FIELD:first_seen_date_true:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:last_seen_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:dispute_status:TYPE(STRING1):0,0\n'
    + 'FIELD:lex_id:LIKE(Invalid_LexID):TYPE(STRING15):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

