// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT DeactRaw2_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Phonesinfo';
  EXPORT spc_NAMESCOPE := 'DeactRaw2';
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
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,msisdn,timestamp,changeid,operatorid,msisdneid,msisdnnew,filename';
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
    + 'MODULE:Scrubs_Phonesinfo\n'
    + 'FILENAME:Phonesinfo\n'
    + 'NAMESCOPE:DeactRaw2\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 \\n)\n'
    + 'FIELDTYPE:Invalid_TimeStamp:ALLOW(0123456789- \\n) \n'
    + '\n'
    + 'FIELD:msisdn:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:timestamp:LIKE(Invalid_TimeStamp):TYPE(STRING):0,0\n'
    + 'FIELD:changeid:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:operatorid:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:msisdneid:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:msisdnnew:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:filename:TYPE(STRING255):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

