// Machine-readable versions of the spec file and subsets thereof
EXPORT KeyGrowth_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Risk_Indicators';
  EXPORT spc_NAMESCOPE := 'KeyGrowth';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Risk_Indicators\n'
    + 'FILENAME:Risk_Indicators\n'
    + 'NAMESCOPE:KeyGrowth\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Growth:CUSTOM(fn_Invalid_Growth>0)\n'
    + '\n'
    + 'FIELD:dataset_name:TYPE(STRING):0,0\n'
    + 'FIELD:file_type:TYPE(STRING):0,0\n'
    + 'FIELD:version:TYPE(STRING):0,0\n'
    + 'FIELD:wu:TYPE(STRING):0,0\n'
    + 'FIELD:count_oldfile:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:count_newfile:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:count_deduped_combined:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:percent_change:LIKE(Invalid_Growth):TYPE(DECIMAL3):0,0\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
