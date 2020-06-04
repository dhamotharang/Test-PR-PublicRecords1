// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OPM';
  EXPORT spc_NAMESCOPE := 'raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'OPM';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,employee_name,duty_station,country,state,city,county,agency,agency_sub_element,computation_date,occupational_series,file_date';
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
    + 'MODULE:Scrubs_OPM\n'
    + 'FILENAME:OPM\n'
    + 'NAMESCOPE:raw\n'
    + '\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ.-\'`/, )\n'
    + 'FIELDTYPE:invalid_alpha_num:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_country:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ-,\' )\n'
    + 'FIELDTYPE:invalid_alpha_blank:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ \' )\n'
    + 'FIELDTYPE:invalid_alpha_blank_sp:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\',.(-) )\n'
    + 'FIELDTYPE:invalid_alpha_num_sp:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ(-)., /&:\')\n'
    + 'FIELDTYPE:invalid_past_date:CUSTOM(Scrubs_OPM.Functions.fn_check_past_date>0)\n'
    + 'FIELDTYPE:invalid_occu_Series_cd:CUSTOM(Scrubs_OPM.Functions.fn_check_occu_Series_cd>0)\n'
    + '\n'
    + 'FIELD:employee_name:TYPE(STRING):LIKE(invalid_name):0,0\n'
    + 'FIELD:duty_station:TYPE(STRING):LIKE(invalid_alpha_num):0,0\n'
    + 'FIELD:country:TYPE(STRING):LIKE(invalid_country):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(invalid_alpha_blank):0,0\n'
    + 'FIELD:city:TYPE(STRING):LIKE(invalid_alpha_blank_sp):0,0\n'
    + 'FIELD:county:TYPE(STRING):LIKE(invalid_alpha_blank_sp):0,0\n'
    + 'FIELD:agency:TYPE(STRING):LIKE(invalid_alpha_num_sp):0,0\n'
    + 'FIELD:agency_sub_element:TYPE(STRING):LIKE(invalid_alpha_num_sp):0,0\n'
    + 'FIELD:computation_date:TYPE(STRING):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:occupational_series:TYPE(STRING):LIKE(invalid_occu_Series_cd):0,0\n'
    + 'FIELD:file_date:TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

