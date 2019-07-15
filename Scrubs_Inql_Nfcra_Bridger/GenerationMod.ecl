// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Inql_Nfcra_Bridger';
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
  EXPORT spc_FILENAME := 'File';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,datetime,customer_id,search_function_name,entity_type,field1,field2,field3,field4,field5,field6,field7,field8,field9,field10,field11,field12,field13,field14,field15,field16,id_';
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
    + 'MODULE:Scrubs_Inql_Nfcra_Bridger\n'
    + 'FILENAME:File\n'
    + '\n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\')\n'
    + 'FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):\n'
    + 'FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.):\n'
    + 'FIELDTYPE:NUMBER:ALLOW(0123456789):\n'
    + 'FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$*):SPACES( ):ONFAIL(CLEAN):\n'
    + '\n'
    + 'FIELDTYPE:datetime:SPACES( ):LIKE(NUMBER):WORDS(2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:customer_id:SPACES( ):LIKE(NUMBER):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:search_function_name:SPACES( ):ALLOW( -BRTacdeghilmrtÂ€Â“Ã¢):WORDS(3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:entity_type:SPACES( ):ALLOW(ABDEILNSTUVY_):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field1:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field2:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field3:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field4:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field5:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field6:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field7:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field8:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field9:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field10:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field11:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field12:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field13:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field14:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field15:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:field16:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:id_:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + '\n'
    + 'FIELD:datetime:LIKE(datetime):TYPE(STRING):0,0\n'
    + 'FIELD:customer_id:LIKE(datetime):TYPE(STRING):0,0\n'
    + 'FIELD:search_function_name:LIKE(datetime):TYPE(STRING):0,0\n'
    + 'FIELD:entity_type:LIKE(datetime):TYPE(STRING):0,0\n'
    + 'FIELD:field1:LIKE(field1):TYPE(STRING):0,0\n'
    + 'FIELD:field2:LIKE(field2):TYPE(STRING):0,0\n'
    + 'FIELD:field3:LIKE(field3):TYPE(STRING):0,0\n'
    + 'FIELD:field4:LIKE(field4):TYPE(STRING):0,0\n'
    + 'FIELD:field5:LIKE(field5):TYPE(STRING):0,0\n'
    + 'FIELD:field6:LIKE(field6):TYPE(STRING):0,0\n'
    + 'FIELD:field7:LIKE(field7):TYPE(STRING):0,0\n'
    + 'FIELD:field8:LIKE(field8):TYPE(STRING):0,0\n'
    + 'FIELD:field9:LIKE(field9):TYPE(STRING):0,0\n'
    + 'FIELD:field10:LIKE(field10):TYPE(STRING):0,0\n'
    + 'FIELD:field11:LIKE(field11):TYPE(STRING):0,0\n'
    + 'FIELD:field12:LIKE(field12):TYPE(STRING):0,0\n'
    + 'FIELD:field13:LIKE(field13):TYPE(STRING):0,0\n'
    + 'FIELD:field14:LIKE(field14):TYPE(STRING):0,0\n'
    + 'FIELD:field15:LIKE(field15):TYPE(STRING):0,0\n'
    + 'FIELD:field16:LIKE(field16):TYPE(STRING):0,0\n'
    + 'FIELD:id_:LIKE(id_):TYPE(STRING):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

