// Machine-readable versions of the spec file and subsets thereof
EXPORT CodesV3_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Codes';
  EXPORT spc_NAMESCOPE := 'CodesV3';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Codes\n'
    + 'FILENAME:Codes\n'
    + 'NAMESCOPE:CodesV3\n'
    + '\n'
    + 'FIELDTYPE:InvalidCode:Lengths(1..)\n'
    + '\n'
    + 'FIELD:file_name:TYPE(STRING35):0,0\n'
    + 'FIELD:field_name:TYPE(STRING50):0,0\n'
    + 'FIELD:field_name2:TYPE(STRING5):0,0\n'
    + 'FIELD:code:LIKE(InvalidCode):TYPE(STRING15):0,0\n'
    + 'FIELD:long_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:long_desc:TYPE(STRING330):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
