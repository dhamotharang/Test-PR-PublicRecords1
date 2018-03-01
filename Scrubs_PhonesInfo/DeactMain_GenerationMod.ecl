// Machine-readable versions of the spec file and subsets thereof
EXPORT DeactMain_GenerationMod := MODULE

  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'DeactMain';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id

  // The entire spec file
  EXPORT spcString :=
    'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:DeactMain\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Action_Code:ENUM(DE|SW|SU|RE):Lengths(1..)\n'
    + 'FIELDTYPE:Invalid_Deact_Code:ENUM(DE|SU| )\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)\n'
    + 'FIELDTYPE:Invalid_IS:ALLOW(YNP )\n'
    + '\n'
    + '\n'
    + 'FIELD:vendor_first_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:vendor_last_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:action_code:LIKE(Invalid_Action_Code):TYPE(STRING2):0,0\n'
    + 'FIELD:timestamp:LIKE(Invalid_Num):TYPE(STRING14):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:phone_swap:LIKE(Invalid_Num_Blank):TYPE(STRING10):0,0\n'
    + 'FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0\n'
    + 'FIELD:carrier_name:TYPE(STRING60):0,0\n'
    + 'FIELD:filedate:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:swap_start_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:swap_end_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:deact_code:LIKE(Invalid_Deact_Code):TYPE(STRING2):0,0\n'
    + 'FIELD:deact_start_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:deact_end_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:react_start_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:react_end_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:is_react:LIKE(Invalid_IS):TYPE(STRING2):0,0\n'
    + 'FIELD:is_deact:LIKE(Invalid_IS):TYPE(STRING2):0,0\n'
    + 'FIELD:porting_dt:LIKE(Invalid_Num_Blank):TYPE(UNSIGNED8):0,0'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
