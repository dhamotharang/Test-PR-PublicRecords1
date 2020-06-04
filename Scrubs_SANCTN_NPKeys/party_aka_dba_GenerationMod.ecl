// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT party_aka_dba_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_SANCTN_NPKeys';
  EXPORT spc_NAMESCOPE := 'party_aka_dba';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'dbcode';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'SANCTN_NPKeys';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,batch,dbcode,incident_num,party_num,name_type,first_name,middle_name,last_name,aka_dba_text,party_key';
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
    + 'MODULE:Scrubs_SANCTN_NPKeys\n'
    + 'FILENAME:SANCTN_NPKeys\n'
    + 'NAMESCOPE:party_aka_dba\n'
    + 'SOURCEFIELD:dbcode\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_DBCode:ENUM(N|F|P)\n'
    + 'FIELDTYPE:Invalid_NameType:ENUM(D|A)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + '\n'
    + 'FIELD:batch:LIKE(Invalid_Batch):TYPE(STRING8):0,0\n'
    + 'FIELD:dbcode:LIKE(Invalid_DBCode):TYPE(STRING1):0,0\n'
    + 'FIELD:incident_num:LIKE(Invalid_Num):TYPE(STRING8):0,0\n'
    + 'FIELD:party_num:LIKE(Invalid_Num):TYPE(STRING7):0,0\n'
    + 'FIELD:name_type:LIKE(Invalid_NameType):TYPE(STRING1):0,0\n'
    + 'FIELD:first_name:TYPE(STRING50):0,0\n'
    + 'FIELD:middle_name:TYPE(STRING50):0,0\n'
    + 'FIELD:last_name:TYPE(STRING50):0,0\n'
    + 'FIELD:aka_dba_text:TYPE(STRING100):0,0\n'
    + 'FIELD:party_key:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

