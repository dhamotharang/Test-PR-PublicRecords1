// Machine-readable versions of the spec file and subsets thereof
EXPORT Medians_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_AVM';
  EXPORT spc_NAMESCOPE := 'Medians';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_AVM\n'
    + 'FILENAME:AVM \n'
    + 'NAMESCOPE:Medians\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:Invalid_Chars:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + '\n'
    + 'FIELD:history_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:fips_geo_12:LIKE(Invalid_Num):TYPE(STRING12):0,0\n'
    + 'FIELD:median_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    + 'FIELD:history_history_date:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + 'FIELD:history_median_valuation:LIKE(Invalid_Num):TYPE(INTEGER8):0,0\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
