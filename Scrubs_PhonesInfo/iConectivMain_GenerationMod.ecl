// Machine-readable versions of the spec file and subsets thereof
EXPORT iConectivMain_GenerationMod := MODULE

  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_PhonesInfo';
  EXPORT spc_NAMESCOPE := 'iConectivMain';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id

  // The entire spec file
  EXPORT spcString :=
    'MODULE:Scrubs_PhonesInfo\n'
    + 'FILENAME:PhonesInfo\n'
    + 'NAMESCOPE:iConectivMain\n'
    + '\n'
    + 'FIELDTYPE:Invalid_Num:ALLOW(0123456789)\n'
    + 'FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 )\n'
    + 'FIELDTYPE:Invalid_DCT:ALLOW(ECTBN)\n'
    + 'FIELDTYPE:Invalid_TOS:ALLOW(MGOU)\n'
    + 'FIELDTYPE:Invalid_Port_Date:ALLOW(0123456789 /:-)\n'
    + 'FIELDTYPE:Invalid_ISO2:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)\n'
    + '\n'
    + 'FIELD:country_code:LIKE(Invalid_Num):TYPE(STRING3):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Num):TYPE(STRING12):0,0\n'
    + 'FIELD:dial_type:LIKE(Invalid_DCT):TYPE(STRING1):0,0\n'
    + 'FIELD:spid:LIKE(Invalid_Num):TYPE(STRING6):0,0\n'
    + 'FIELD:service_provider:TYPE(STRING):0,0\n'
    + 'FIELD:service_type:LIKE(Invalid_TOS):TYPE(STRING1):0,0\n'
    + 'FIELD:routing_code:LIKE(Invalid_Num_Blank):TYPE(STRING10):0,0\n'
    + 'FIELD:porting_dt:LIKE(Invalid_Port_Date):TYPE(STRING):0,0\n'
    + 'FIELD:country_abbr:LIKE(Invalid_ISO2):TYPE(STRING2):0,0\n'
    + 'FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0\n'
    + 'FIELD:file_dt_time:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:vendor_first_reported_dt:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:vendor_last_reported_dt:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:port_start_dt:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:port_end_dt:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:remove_port_dt:LIKE(Invalid_Num):TYPE(STRING):0,0\n'
    + 'FIELD:is_ported:TYPE(BOOLEAN1):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
