// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT Activity_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Civil_Court';
  EXPORT spc_NAMESCOPE := 'Activity';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Civil_Court';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,dt_first_reported,dt_last_reported,process_date,vendor,state_origin,source_file,case_key,court_code,court,case_number,event_date,event_type_code,event_type_description_1,event_type_description_2';
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
    + 'MODULE:Scrubs_Civil_Court\n'
    + 'FILENAME:Civil_Court\n'
    + 'NAMESCOPE:Activity\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,\'future\')\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 -)\n'
    + 'FIELDTYPE:Invalid_CapLetter:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -)\n'
    + 'FIELDTYPE:Invalid_SourceFile:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -\\(\\))\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -)\n'
    + '\n'
    + 'FIELD:dt_first_reported:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:dt_last_reported:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:process_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:vendor:LIKE(Invalid_Num):TYPE(STRING2):0,0\n'
    + 'FIELD:state_origin:LIKE(Invalid_CapLetter):TYPE(STRING2):0,0\n'
    + 'FIELD:source_file:TYPE(STRING20):0,0\n'
    + 'FIELD:case_key:LIKE(Invalid_Char):TYPE(STRING60):0,0\n'
    + 'FIELD:court_code:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:court:TYPE(STRING60):0,0\n'
    + 'FIELD:case_number:LIKE(Invalid_Char):TYPE(STRING35):0,0\n'
    + 'FIELD:event_date:LIKE(Invalid_Future_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:event_type_code:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:event_type_description_1:TYPE(STRING65):0,0\n'
    + 'FIELD:event_type_description_2:TYPE(STRING65):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

