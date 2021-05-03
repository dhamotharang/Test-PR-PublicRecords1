// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Accident_Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OSHAIR';
  EXPORT spc_NAMESCOPE := 'Accident_Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Accident_Raw_in_OSHAIR';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,summary_nr,report_id,event_date_time,const_end_use,build_stories,nonbuild_ht,project_cost,project_type,sic_list,fatality';
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
    + 'FILENAME:Accident_Raw_in_OSHAIR\n'
    + 'NAMESCOPE:Accident_Raw\n'
    + '\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_numeric_blank:CUSTOM(Scrubs_Oshair.Functions.fn_numeric_or_blank > 0)\n'
    + 'FIELDTYPE:invalid_date_time:CUSTOM(Scrubs_Oshair.Functions.fn_date_time > 0)\n'
    + 'FIELDTYPE:invalid_const_end_use:CUSTOM(Scrubs_Oshair.Functions.fn_const_end_use > 0)\n'
    + 'FIELDTYPE:invalid_project_cost:CUSTOM(Scrubs_Oshair.Functions.fn_project_cost > 0)\n'
    + 'FIELDTYPE:invalid_project_type:CUSTOM(Scrubs_Oshair.Functions.fn_project_type > 0)\n'
    + 'FIELDTYPE:invalid_sic_list:CUSTOM(Scrubs_Oshair.Functions.fn_numeric_or_comma > 0)\n'
    + 'FIELDTYPE:invalid_fatality:CUSTOM(Scrubs_Oshair.Functions.fn_fatality > 0)\n'
    + '\n'
    + 'FIELD:summary_nr:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:report_id:TYPE(STRING7):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:event_date_time:TYPE(STRING16):LIKE(invalid_date_time):0,0\n'
    + 'FIELD:const_end_use:TYPE(STRING1):LIKE(invalid_const_end_use):0,0\n'
    + 'FIELD:build_stories:TYPE(STRING4):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:nonbuild_ht:TYPE(STRING4):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:project_cost:TYPE(STRING1):LIKE(invalid_project_cost):0,0\n'
    + 'FIELD:project_type:TYPE(STRING1):LIKE(invalid_project_type):0,0\n'
    + 'FIELD:sic_list:TYPE(STRING40):LIKE(invalid_sic_list):0,0\n'
    + 'FIELD:fatality:TYPE(STRING1):LIKE(invalid_fatality):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

