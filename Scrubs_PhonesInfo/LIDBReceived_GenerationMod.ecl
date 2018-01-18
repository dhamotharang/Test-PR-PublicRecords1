// Machine-readable versions of the spec file and subsets thereof
EXPORT LIDBReceived_GenerationMod := MODULE

  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'LIDBReceived';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id

  // The entire spec file
  EXPORT spcString :=
    'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:LIDBReceived\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \\(\\)&-.,/-#@\')\n'
    + 'FIELDTYPE:Invalid_AccOwn:ALLOW(ABHGCDFE0123456789 )\n'
    + 'FIELDTYPE:Invalid_RefID:ALLOW(MGP0123456789 )\n'
    + '\n'
    + 'FIELD:reference_id:LIKE(Invalid_RefID):TYPE(STRING):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:reply_code:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:local_routing_number:LIKE(Invalid_Num):TYPE(STRING10):0,0\n'
    + 'FIELD:account_owner:LIKE(Invalid_AccOwn):TYPE(STRING4):0,0\n'
    + 'FIELD:carrier_name:LIKE(Invalid_Char):TYPE(STRING55):0,0\n'
    + 'FIELD:carrier_category:LIKE(Invalid_Char):TYPE(STRING10):0,0\n'
    + 'FIELD:local_area_transport_area:TYPE(STRING5):0,0\n'
    + 'FIELD:point_code:TYPE(STRING9):0,0\n'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
