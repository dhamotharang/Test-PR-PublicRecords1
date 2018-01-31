// Machine-readable versions of the spec file and subsets thereof
EXPORT New_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Suppress';
  EXPORT spc_NAMESCOPE := 'New';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Suppress\n'
    + 'FILENAME:Suppress\n'
    + 'NAMESCOPE:New\n'
    + '\n'
    + 'FIELDTYPE:invalid_product:ENUM(ACCURINT|CONSUMER|LE|ALL)\n'
    + 'FIELDTYPE:invalid_linking_type:ENUM(DID|SSN|BDID|)\n'
    + 'FIELDTYPE:invalid_num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_document_type:ENUM(OFFENDER KEY|FARES ID|OFFICIAL RECORD|)\n'
    + 'FIELDTYPE:invlid_document_id:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- /)\n'
    + '\n'
    + '\n'
    + 'FIELD:product:LIKE(invalid_product):TYPE(STRING10):0,0\n'
    + 'FIELD:linking_type:LIKE(invalid_linking_type):TYPE(STRING5):0,0 \n'
    + 'FIELD:linking_id:LIKE(invalid_num):TYPE(STRING20):0,0\n'
    + 'FIELD:document_type:LIKE(invalid_document_type):TYPE(STRING15):0,0\n'
    + 'FIELD:document_id:LIKE(invlid_document_id):TYPE(STRING60):0,0\n'
    + 'FIELD:date_added:LIKE():TYPE(STRING8):0,0\n'
    + 'FIELD:user:TYPE(STRING25):0,0\n'
    + 'FIELD:compliance_id:LIKE(invalid_num):TYPE(STRING25):0,0\n'
    + 'FIELD:comment:TYPE(STRING255):0,0\n'
    + '\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
