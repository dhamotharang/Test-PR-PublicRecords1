// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Medians_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_AVM';
  EXPORT spc_NAMESCOPE := 'Medians';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'AVM';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,history_date,fips_geo_12,median_valuation,history_history_date,history_median_valuation';
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
    + 'MODULE:Scrubs_AVM\n'
    + 'FILENAME:AVM \n'
    + 'NAMESCOPE:Medians\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)\n'
    + 'FIELDTYPE:Invalid_Chars:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+)\n'
    + 'FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789 )\n'
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

