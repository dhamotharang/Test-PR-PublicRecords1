// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT AccidentInjury_Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.8';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_OSHAIR';
  EXPORT spc_NAMESCOPE := 'AccidentInjury_Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'AccidentInjury_Raw_in_OSHAIR';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,summary_nr,rel_insp_nr,age,sex,nature_of_inj,part_of_body,src_of_injury,event_type,evn_factor,hum_factor,occ_code,degree_of_inj,task_assigned,hazsub,const_op,const_op_cause,fat_cause,fall_distance,fall_ht,injury_line_nr';
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
    + 'FILENAME:AccidentInjury_Raw_in_OSHAIR\n'
    + 'NAMESCOPE:AccidentInjury_Raw\n'
    + '\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_numeric_blank:CUSTOM(Scrubs_OSHAIR.Functions.fn_numeric_or_blank > 0)\n'
    + 'FIELDTYPE:invalid_date_time:CUSTOM(Scrubs_Oshair.Functions.fn_date_time > 0)\n'
    + 'FIELDTYPE:invalid_sex:CUSTOM(Scrubs_Oshair.Functions.fn_sex_code > 0)\n'
    + 'FIELDTYPE:invalid_degree_of_inj:CUSTOM(Scrubs_Oshair.Functions.fn_degree_inj > 0)\n'
    + 'FIELDTYPE:invalid_task_assigned:CUSTOM(Scrubs_Oshair.Functions.fn_task_assigned > 0)\n'
    + 'FIELDTYPE:invalid_alpha_numeric:CUSTOM(Scrubs.Functions.fn_alphaNum_or_blank > 0)\n'
    + '\n'
    + 'FIELD:summary_nr:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:rel_insp_nr:TYPE(STRING9):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:age:TYPE(STRING2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:sex:TYPE(STRING1):LIKE(invalid_sex):0,0\n'
    + 'FIELD:nature_of_inj:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:part_of_body:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:src_of_injury:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:event_type:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:evn_factor:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:hum_factor:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:occ_code:TYPE(STRING3):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:degree_of_inj:TYPE(STRING1):LIKE(invalid_degree_of_inj):0,0\n'
    + 'FIELD:task_assigned:TYPE(STRING1):LIKE(invalid_task_assigned):0,0\n'
    + 'FIELD:hazsub:TYPE(STRING4):LIKE(invalid_alpha_numeric):0,0\n'
    + 'FIELD:const_op:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:const_op_cause:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:fat_cause:TYPE(STRING2):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:fall_distance:TYPE(STRING4):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:fall_ht:TYPE(STRING4):LIKE(invalid_numeric_blank):0,0\n'
    + 'FIELD:injury_line_nr:TYPE(STRING250):LIKE(invalid_numeric):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

