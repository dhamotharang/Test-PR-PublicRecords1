// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenDutyStd_Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OSHAIR';
  EXPORT spc_NAMESCOPE := 'GenDutyStd_Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'GenDutyStd_Raw_In_OSHAIR';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,activity_nr,citation_id,line_nr';
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
    + 'MODULE:Scrubs_OSHAIR\n'
    + 'FILENAME:GenDutyStd_Raw_In_OSHAIR\n'
    + 'NAMESCOPE:GenDutyStd_Raw\n'
    + '\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_alpha_numeric:CUSTOM(Scrubs.Functions.fn_alphanum > 0)\n'
    + '\n'
    + 'FIELD:activity_nr:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:citation_id:TYPE(STRING7):LIKE(invalid_alpha_numeric):0,0\n'
    + 'FIELD:line_nr:TYPE(STRING6):LIKE(invalid_numeric):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

