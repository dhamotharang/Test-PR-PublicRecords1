// Machine-readable versions of the spec file and subsets thereof
EXPORT Daily_Raw_Wireline_to_Wireless_GenerationMod := MODULE

  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'Daily_Raw_Wireline_to_Wireless';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id

  // The entire spec file
  EXPORT spcString :=
    'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:Daily_Raw_Wireline_to_Wireless\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Phone:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-:)\n'
    + '\n'
    + 'FIELD:phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0\n'
    + 'FIELD:lf:TYPE(STRING1):0,0\n'
    + 'FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0\n'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
