// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'PhonesPlus_V2';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'record_sid'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'source';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Source_Level_Base';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:record_sid';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,cellphoneidkey,source,household_flag,did,datefirstseen,datelastseen,datevendorfirstreported,datevendorlastreported,first_build_date,last_build_date,dt_nonglb_last_seen';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
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
    'OPTIONS:-gn\n'
    + 'MODULE:PhonesPlus_V2\n'
    + 'RIDFIELD:record_sid:GENERATE\n'
    + 'SOURCEFIELD:source\n'
    + 'FILENAME:Source_Level_Base\n'
    + '\n'
    + 'FIELD:cellphoneidkey:TYPE(DATA16):0,0  //cellphoneidkey is a hash of fname, last name, clean address, and phone7\n'
    + 'FIELD:source:TYPE(STRING2):0,0\n'
    + 'FIELD:household_flag:TYPE(BOOLEAN):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:datefirstseen:RECORDDATE(FIRST,YYYYMM):0,0\n'
    + 'FIELD:datelastseen:RECORDDATE(LAST,YYYYMM):0,0\n'
    + 'FIELD:datevendorfirstreported:RECORDDATE(FIRST,YYYYMM):0,0\n'
    + 'FIELD:datevendorlastreported:RECORDDATE(LAST,YYYYMM):0,0\n'
    + 'FIELD:first_build_date:RECORDDATE(FIRST,YYYYMMDD):0,0\n'
    + 'FIELD:last_build_date:RECORDDATE(LAST,YYYYMMDD):0,0\n'
    + 'FIELD:dt_nonglb_last_seen:RECORDDATE(LAST,YYYYMM):0,0\n'
    + '\n'
    + 'INGESTFILE:Source_Level_Base:NAMED(PhonesPlus_V2.Prep_Source_Level_Ingest)\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

