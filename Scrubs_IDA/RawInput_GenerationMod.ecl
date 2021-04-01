// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT RawInput_GenerationMod := MODULE(SALT311.iGenerationMod)

  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_IDA';
  EXPORT spc_NAMESCOPE := 'RawInput';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'IDA';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,firstname,middlename,lastname,suffix,addressline1,addressline2,city,state,zip,dob,ssn,dl,dlstate,phone,clientassigneduniquerecordid,emailaddress,ipaddress';
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
    + 'MODULE:Scrubs_IDA\n'
    + 'FILENAME:IDA\n'
    + 'NAMESCOPE:RawInput\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_FName:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ-):LENGTHS(2..15):WORDS(0,1)\n'
    + 'FIELDTYPE:Invalid_MName:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ.):LENGTHS(0..2):WORDS(0,1)\n'
    + 'FIELDTYPE:Invalid_LName:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ.-):LENGTHS(2..20):WORDS(0..2)\n'
    + 'FIELDTYPE:Invalid_Suffix:SPACES( ):ALLOW(SRJr.IVX12345PHMD):WORDS(0,1)\n'
    + 'FIELDTYPE:Invalid_Address1:SPACES(. ):LIKE(Invalid_AlphaNum):WORDS(0..7)\n'
    + 'FIELDTYPE:Invalid_Address2:SPACES(# ):LIKE(Invalid_AlphaNum):WORDS(0..2)\n'
    + 'FIELDTYPE:Invalid_City:SPACES(. ):LIKE(Invalid_Alpha):WORDS(0..4)\n'
    + 'FIELDTYPE:Invalid_State:CUSTOM(Scrubs.Functions.fn_verify_state > 0)\n'
    + 'FIELDTYPE:Invalid_Zip:LIKE(Invalid_Num):LENGTHS(0,3..5)\n'
    + 'FIELDTYPE:Invalid_DOB:CUSTOM(Scrubs.Functions.fn_dob > 0)\n'
    + 'FIELDTYPE:Invalid_SSN:SPACES( ):ALLOW(0123456789):LENGTHS(0,9):WORDS(0,1)\n'
    + 'FIELDTYPE:Invalid_DL:CUSTOM(Scrubs_IDA.Functions.FN_valid_DL > 0)\n'
    + 'FIELDTYPE:Invalid_Phone:LIKE(Invalid_Num):LENGTHS(0,10)\n'
    + 'FIELDTYPE:Invalid_Clientassigneduniquerecordid:ALLOW(nfr0123456789)\n'
    + 'FIELDTYPE:Invalid_Emailaddress:CUSTOM(Scrubs.Functions.fn_valid_email > 0)\n'
    + 'FIELDTYPE:Invalid_Ipaddress:CUSTOM(Scrubs.Functions.fn_valid_IP > 0)\n'
    + '\n'
    + 'FIELD:firstname:TYPE(STRING20):LIKE(Invalid_FName):0,0\n'
    + 'FIELD:middlename:TYPE(STRING20):LIKE(Invalid_MName):0,0\n'
    + 'FIELD:lastname:TYPE(STRING25):LIKE(Invalid_LName):0,0\n'
    + 'FIELD:suffix:TYPE(STRING3):LIKE(Invalid_Suffix):0,0\n'
    + 'FIELD:addressline1:TYPE(STRING50):LIKE(Invalid_Address1):0,0\n'
    + 'FIELD:addressline2:TYPE(STRING20):LIKE(Invalid_Address2):0,0\n'
    + 'FIELD:city:TYPE(STRING35):LIKE(Invalid_City):0,0\n'
    + 'FIELD:state:TYPE(STRING2):LIKE(Invalid_State):0,0\n'
    + 'FIELD:zip:TYPE(UNSIGNED3):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:dob:TYPE(UNSIGNED4):LIKE(Invalid_DOB):0,0\n'
    + 'FIELD:ssn:TYPE(STRING12):LIKE(Invalid_SSN):0,0\n'
    + 'FIELD:dl:TYPE(STRING12):LIKE(Invalid_DL):0,0\n'
    + 'FIELD:dlstate:TYPE(STRING5):LIKE(Invalid_State):0,0\n'
    + 'FIELD:phone:TYPE(STRING10):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:clientassigneduniquerecordid:TYPE(STRING):LIKE(Invalid_Clientassigneduniquerecordid):0,0\n'
    + 'FIELD:emailaddress:TYPE(STRING50):LIKE(Invalid_Emailaddress):0,0\n'
    + 'FIELD:ipaddress:TYPE(STRING15):LIKE(Invalid_Ipaddress):0,0'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
