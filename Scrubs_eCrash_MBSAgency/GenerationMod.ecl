// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'ï»¿OPTIONS:-gh\n'
    + 'MODULE:Scrubs_eCrash_MBSAgency\n'
    + 'FILENAME:eCrash_MBSAgency\n'
    + '\n'
    + 'FIELDTYPE:invalid_agency_id:ALLOW(0123456789):LENGTHS(7)\n'
    + 'FIELDTYPE:invalid_source_id:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ \\N):LENGTHS(0,1,2,3)\n'
    + 'FIELDTYPE:invalid_agency_state_abbr:CUSTOM(Scrubs.fn_Valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:invalid_agency_ori:ALLOW(0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ \\N)\n'
    + 'FIELDTYPE:invalid_allow_open_search:ALLOW(01):LENGTHS(1)\n'
    + 'FIELDTYPE:invalid_append_overwrite_flag:ENUM(AP|OW):LENGTHS(2)\n'
    + 'FIELDTYPE:invalid_drivers_exchange_flag:ALLOW(01):LENGTHS(1)\n'
    + '\n'
    + 'FIELD:agency_id:LIKE(invalid_agency_id):TYPE(STRING):0,0\n'
    + 'FIELD:agency_name:TYPE(STRING):0,0\n'
    + 'FIELD:source_id:LIKE(invalid_source_id):TYPE(STRING):0,0\n'
    + 'FIELD:agency_state_abbr:LIKE(invalid_agency_state_abbr):TYPE(STRING):0,0\n'
    + 'FIELD:agency_ori:LIKE(invalid_agency_ori):TYPE(STRING):0,0\n'
    + 'FIELD:allow_open_search:LIKE(invalid_allow_open_search):TYPE(STRING):0,0\n'
    + 'FIELD:append_overwrite_flag:LIKE(invalid_append_overwrite_flag):TYPE(STRING):0,0\n'
    + 'FIELD:drivers_exchange_flag:LIKE(invalid_drivers_exchange_flag):TYPE(STRING):0,0'
    ;
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
END;
