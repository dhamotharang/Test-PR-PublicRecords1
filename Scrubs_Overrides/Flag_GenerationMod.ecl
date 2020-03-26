// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Flag_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.4';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Overrides';
  EXPORT spc_NAMESCOPE := 'Flag';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Overrides';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,flag_file_id,did,file_id,record_id,override_flag,in_dispute_flag,consumer_statement_flag,fname,mname,lname,name_suffix,ssn,dob,riskwise_uid,user_added,date_added,known_missing,user_changed,date_changed,lf';
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
    'OPTIONS:-gh \n'
    + 'MODULE:Scrubs_Overrides\n'
    + 'FILENAME:Overrides\n'
    + 'NAMESCOPE:Flag\n'
    + '\n'
    + 'FIELDTYPE:Invalid_FlagID:ALLOW(0123456789):LENGTHS(6..)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_Letters:ALLOW(abcdefghijklmnopqrstuvwxyz_):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_OverrideFlag:ENUM(1|2|)\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz \'.-)\n'
    + 'FIELDTYPE:Invalid_SSN:ALLOW(0123456789):LENGTHS(0,9)\n'
    + 'FIELDTYPE:Invalid_DOB:ALLOW(0123456789):LENGTHS(0,8)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + '\n'
    + 'FIELD:flag_file_id:LIKE(Invalid_FlagID):TYPE(STRING20):0,0\n'
    + 'FIELD:did:LIKE(Invalid_Num):TYPE(STRING12):0,0\n'
    + 'FIELD:file_id:LIKE(Invalid_Letters):TYPE(STRING20):0,0\n'
    + 'FIELD:record_id:TYPE(STRING100):0,0\n'
    + 'FIELD:override_flag:LIKE(Invalid_OverrideFlag):TYPE(STRING1):0,0\n'
    + 'FIELD:in_dispute_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:consumer_statement_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:fname:LIKE(Invalid_Char):TYPE(STRING30):0,0\n'
    + 'FIELD:mname:LIKE(Invalid_Char):TYPE(STRING30):0,0\n'
    + 'FIELD:lname:LIKE(Invalid_Char):TYPE(STRING30):0,0\n'
    + 'FIELD:name_suffix:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:ssn:LIKE(Invalid_SSN):TYPE(STRING9):0,0\n'
    + 'FIELD:dob:LIKE(Invalid_DOB):TYPE(STRING8):0,0\n'
    + 'FIELD:riskwise_uid:LIKE(Invalid_Num):TYPE(STRING20):0,0\n'
    + 'FIELD:user_added:TYPE(STRING30):0,0\n'
    + 'FIELD:date_added:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:known_missing:TYPE(STRING1):0,0\n'
    + 'FIELD:user_changed:TYPE(STRING30):0,0\n'
    + 'FIELD:date_changed:TYPE(STRING8):0,0\n'
    + 'FIELD:lf:TYPE(STRING1):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

