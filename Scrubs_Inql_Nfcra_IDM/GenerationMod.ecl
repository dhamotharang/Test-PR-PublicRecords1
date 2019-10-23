// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Inql_Nfcra_IDM';
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
  EXPORT spc_FILENAME := 'FILE';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,orig_transaction_id,orig_dateadded,orig_billingid,orig_function_name,orig_adl,orig_fname,orig_lname,orig_mname,orig_ssn,orig_address,orig_city,orig_state,orig_zip,orig_phone,orig_dob,orig_dln,orig_dln_st,orig_glb,orig_dppa,orig_fcra';
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
    + 'MODULE:Scrubs_Inql_Nfcra_IDM\n'
    + 'FILENAME:FILE\n'
    + '\n'
    + 'FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("\')\n'
    + 'FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):\n'
    + 'FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,\'.):\n'
    + 'FIELDTYPE:NUMBER:ALLOW(0123456789):\n'
    + 'FIELDTYPE:ALPHANUM:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):\n'
    + 'FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$*):SPACES( ):ONFAIL(CLEAN):\n'
    + '\n'
    + 'FIELDTYPE:orig_transaction_id:SPACES( ):LIKE(WORDBAG):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dateadded:SPACES( ):ALLOW( -.0123456789:):LEFTTRIM:LENGTHS(23,22,21):WORDS(2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_billingid:SPACES( ):LIKE(ALPHANUM):LEFTTRIM:LENGTHS(7,6,9,0):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_function_name:SPACES( ):LIKE(ALPHA):LEFTTRIM:LENGTHS(12,14):WORDS(1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_adl:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,10,12,9,11,8):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fname:SPACES( ):LIKE(NAME):WORDS(1,0,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_lname:SPACES( ):LIKE(NAME):WORDS(1,0,2,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_mname:SPACES( ):LIKE(NAME):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_ssn:SPACES( ):LIKE(NUMBER):LENGTHS(9,0,4,14):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_address:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_city:SPACES( ):LIKE(ALPHA):WORDS(1,2,0,3):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_state:SPACES( ):LIKE(ALPHA):WORDS(1,0,2):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_zip:SPACES( ):LIKE(NUMBER):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_phone:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,10,5,9,11):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dob:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(10,0,14):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dln:SPACES( ):LIKE(WORDBAG):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dln_st:SPACES( ):LIKE(WORDBAG):LEFTTRIM:LENGTHS(0,2):WORDS(0,1):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_glb:SPACES( ):ALLOW(13567):LEFTTRIM:LENGTHS(0,1,2):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_dppa:SPACES( ):ALLOW(01356):LEFTTRIM:LENGTHS(1,0,2):WORDS(1,0):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:orig_fcra:SPACES( ):ALLOW(01357):LEFTTRIM:LENGTHS(0,1):WORDS(0,1):ONFAIL(CLEAN)\n'
    + '\n'
    + 'FIELD:orig_transaction_id:LIKE(orig_transaction_id):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dateadded:LIKE(orig_dateadded):TYPE(STRING):0,0\n'
    + 'FIELD:orig_billingid:LIKE(orig_billingid):TYPE(STRING):0,0\n'
    + 'FIELD:orig_function_name:LIKE(orig_function_name):TYPE(STRING):0,0\n'
    + 'FIELD:orig_adl:LIKE(orig_adl):TYPE(STRING):0,0\n'
    + 'FIELD:orig_fname:LIKE(orig_fname):TYPE(STRING):0,0\n'
    + 'FIELD:orig_lname:LIKE(orig_lname):TYPE(STRING):0,0\n'
    + 'FIELD:orig_mname:LIKE(orig_mname):TYPE(STRING):0,0\n'
    + 'FIELD:orig_ssn:LIKE(orig_ssn):TYPE(STRING):0,0\n'
    + 'FIELD:orig_address:LIKE(orig_address):TYPE(STRING):0,0\n'
    + 'FIELD:orig_city:LIKE(orig_city):TYPE(STRING):0,0\n'
    + 'FIELD:orig_state:LIKE(orig_state):TYPE(STRING):0,0\n'
    + 'FIELD:orig_zip:LIKE(orig_zip):TYPE(STRING):0,0\n'
    + 'FIELD:orig_phone:LIKE(orig_phone):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dob:LIKE(orig_dob):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dln:LIKE(orig_dln):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dln_st:LIKE(orig_dln_st):TYPE(STRING):0,0\n'
    + 'FIELD:orig_glb:LIKE(orig_glb):TYPE(STRING):0,0\n'
    + 'FIELD:orig_dppa:LIKE(orig_dppa):TYPE(STRING):0,0\n'
    + 'FIELD:orig_fcra:LIKE(orig_fcra):TYPE(STRING):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

