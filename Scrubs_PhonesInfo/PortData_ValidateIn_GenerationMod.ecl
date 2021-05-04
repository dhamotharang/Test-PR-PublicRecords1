// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT PortData_ValidateIn_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'PortData_ValidateIn';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'PhonesInfo';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,tid,action,actts,digits,spid,altspid,laltspid,linetype';
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
    + 'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:PortData_ValidateIn\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Action:ALLOW(d|m|u)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:Invalid_AlphaNum_Spc:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 )\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Type:ALLOW(012345 )\n'
    + '\n'
    + 'FIELD:tid:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:action:LIKE(Invalid_Action):TYPE(STRING):0,0\n'
    + 'FIELD:actts:LIKE(Invalid_AlphaNum):TYPE(STRING):0,0\n'
    + 'FIELD:digits:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:spid:LIKE(Invalid_AlphaNum_Spc):TYPE(STRING):0,0\n'
    + 'FIELD:altspid:LIKE(Invalid_AlphaNum_Spc):TYPE(STRING):0,0\n'
    + 'FIELD:laltspid:LIKE(Invalid_AlphaNum_Spc):TYPE(STRING):0,0\n'
    + 'FIELD:linetype:LIKE(Invalid_Type):TYPE(STRING):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

