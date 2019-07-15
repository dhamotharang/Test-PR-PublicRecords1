// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT38;
EXPORT GenerationMod := MODULE(SALT38.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.2';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Anchor';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Anchor';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    '//SALT:  spc_file;\n'
    + 'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Anchor\n'
    + 'FILENAME:Anchor\n'
    + '\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\'):SPACES( -.,):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_alnum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( -.,):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0..8)\n'
    + 'FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( -.()\'&_`\\/,):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_address:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( -#.&:+\\/()_,):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_city:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\'):SPACES( ):LENGTHS(0..)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(0,5,9,10)\n'
    + 'FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)\n'
    + 'FIELDTYPE:invalid_ip:ALLOW(0123456789):SPACES(.):LENGTHS(0..)\n'
    + '\n'
    + 'FIELD:firstname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:lastname:LIKE(invalid_name):TYPE(STRING):0,0\n'
    + 'FIELD:address_1:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:address_2:LIKE(invalid_address):TYPE(STRING):0,0\n'
    + 'FIELD:city:LIKE(invalid_city):TYPE(STRING):0,0\n'
    + 'FIELD:state:LIKE(invalid_state):TYPE(STRING):0,0\n'
    + 'FIELD:zipcode:LIKE(invalid_zip):TYPE(STRING):0,0\n'
    + 'FIELD:sourceurl:TYPE(STRING):0,0\n'
    + 'FIELD:ipaddress:LIKE(invalid_ip):TYPE(STRING):0,0\n'
    + 'FIELD:optindate:LIKE(invalid_date):TYPE(STRING):0,0\n'
    + 'FIELD:emailaddress:TYPE(STRING):0,0\n'
    + 'FIELD:anchorinternalcode:TYPE(STRING):0,0\n'
    + 'FIELD:addresstype:TYPE(STRING):0,0\n'
    + 'FIELD:dob:LIKE(invalid_date):TYPE(STRING):0,0\n'
    + 'FIELD:latitude:TYPE(STRING):0,0\n'
    + 'FIELD:longitude:TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
