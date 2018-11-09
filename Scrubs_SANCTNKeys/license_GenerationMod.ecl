// Machine-readable versions of the spec file and subsets thereof
EXPORT license_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_SANCTNKeys';
  EXPORT spc_NAMESCOPE := 'license';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_SANCTNKeys\n'
    + 'FILENAME:SANCTNKeys\n'
    + 'NAMESCOPE:license\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_LicenseNumber:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz .-#)\n'
    + 'FIELDTYPE:Invalid_ClnLicenseNumber:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_State:CUSTOM(Scrubs.fn_Valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:Invalid_LicenseType:CUSTOM(Scrubs_SANCTNKeys.fn_CodeCheck_Licence>0)\n'
    + '\n'
    + 'FIELD:batch_number:LIKE(Invalid_Batch):TYPE(STRING8):0,0\n'
    + 'FIELD:incident_number:LIKE(Invalid_Num):TYPE(STRING8):0,0\n'
    + 'FIELD:party_number:LIKE(Invalid_Num):TYPE(STRING8):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):0,0\n'
    + 'FIELD:order_number:LIKE(Invalid_Num):TYPE(STRING4):0,0\n'
    + 'FIELD:license_number:LIKE(Invalid_LicenseNumber):TYPE(STRING50):0,0\n'
    + 'FIELD:license_type:LIKE(Invalid_LicenseType):TYPE(STRING50):0,0\n'
    + 'FIELD:license_state:LIKE(Invalid_State):TYPE(STRING20):0,0\n'
    + 'FIELD:cln_license_number:LIKE(Invalid_ClnLicenseNumber):TYPE(STRING50):0,0\n'
    + 'FIELD:std_type_desc:TYPE(STRING50):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
