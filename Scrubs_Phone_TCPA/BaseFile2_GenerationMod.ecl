// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT BaseFile2_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Phone_TCPA';
  EXPORT spc_NAMESCOPE := 'BaseFile2';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Phone_TCPA';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,num,phone,end_range,expand_end_range,expand_range_max_count,expand_phone,is_current,dt_first_seen,dt_last_seen,phone_type';
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
    + 'MODULE:Scrubs_Phone_TCPA\n'
    + 'FILENAME:Phone_TCPA\n'
    + 'NAMESCOPE:BaseFile2\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Num_Space:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_PType:ALLOW(01)\n'
    + '\n'
    + 'FIELD:num:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:end_range:LIKE(Invalid_Num_Space):TYPE(STRING4):0,0\n'
    + 'FIELD:expand_end_range:LIKE(Invalid_Num_Space):TYPE(STRING10):0,0\n'
    + 'FIELD:expand_range_max_count:LIKE(Invalid_Num_Space):TYPE(INTEGER8):0,0\n'
    + 'FIELD:expand_phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:is_current:TYPE(BOOLEAN):0,0\n'
    + 'FIELD:dt_first_seen:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:dt_last_seen:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:phone_type:LIKE(Invalid_PType):TYPE(STRING1):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

