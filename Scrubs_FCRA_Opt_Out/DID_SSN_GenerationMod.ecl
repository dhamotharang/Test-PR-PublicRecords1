// Machine-readable versions of the spec file and subsets thereof
EXPORT DID_SSN_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FCRA_Opt_Out';
  EXPORT spc_NAMESCOPE := 'DID_SSN';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_FCRA_Opt_Out\n'
    + 'FILENAME:FCRA_Opt_Out\n'
    + 'NAMESCOPE:DID_SSN \n'
    + '\n'
    + 'FIELDTYPE:Invalid_SSN:ALLOW(0123456789-x)\n'
    + 'FIELDTYPE:Invalid_JullianDate:ALLOW(0123456789):LENGTHS(7)\n'
    + 'FIELDTYPE:Invalid_Inname:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -\')\n'
    + 'FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2)\n'
    + 'FIELDTYPE:Invalid_Zip:ALLOW(0123456789):LENGTHS(5)\n'
    + 'FIELDTYPE:Invalid_SSN_append:ALLOW(0123456789):LENGTHS(9)\n'
    + 'FIELDTYPE:Invalid_Flag:ENUM(Y|N|y|n|)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)\n'
    + '\n'
    + 'FIELD:ssn:LIKE(Invalid_SSN):TYPE(STRING9):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:source_flag:TYPE(STRING1):0,0\n'
    + 'FIELD:julian_date:LIKE(Invalid_JullianDate):TYPE(STRING7):0,0\n'
    + 'FIELD:inname_first:LIKE(Invalid_Inname):TYPE(STRING15):0,0\n'
    + 'FIELD:inname_last:LIKE(Invalid_Inname):TYPE(STRING20):0,0\n'
    + 'FIELD:address:TYPE(STRING40):0,0\n'
    + 'FIELD:city:TYPE(STRING20):0,0\n'
    + 'FIELD:state:LIKE(Invalid_State):TYPE(STRING2):0,0\n'
    + 'FIELD:zip5:LIKE(Invalid_Zip):TYPE(STRING5):0,0\n'
    + 'FIELD:did_score:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:ssn_append:LIKE(Invalid_SSN_append):TYPE(STRING9):0,0\n'
    + 'FIELD:permanent_flag:LIKE(Invalid_Flag):TYPE(STRING1):0,0\n'
    + 'FIELD:opt_back_in:LIKE(Invalid_Flag):TYPE(STRING1):0,0\n'
    + 'FIELD:date_yyyymmdd:LIKE(Invalid_Date):TYPE(STRING8):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
