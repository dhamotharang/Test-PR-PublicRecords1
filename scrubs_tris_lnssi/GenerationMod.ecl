// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)

  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'scrubs_tris_lnssi';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'tris_lnssi';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,contrib_risk_field,contrib_risk_value,contrib_risk_attr,contrib_state_excl';
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
    + 'MODULE:scrubs_tris_lnssi\n'
    + 'FILENAME:tris_lnssi\n'
    + '\n'
    + '// contrib_risk_field\n'
    + 'FIELDTYPE:Invalid_AlphaNumDash:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_- )\n'
    + '\n'
    + '// contrib_risk_value \n'
    + 'FIELDTYPE:Invalid_AlphaNumPunc:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz. )\n'
    + '\n'
    + '// contrib_risk_attr\n'
    + 'FIELDTYPE:Invalid_num:ALLOW(12345)\n'
    + '\n'
    + '// contrib_state_excl\n'
    + 'FIELDTYPE:Invalid_AlphaState:ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ_- )\n'
    + '\n'
    + '\n'
    + 'FIELD:contrib_risk_field:TYPE(STRING):LIKE(Invalid_AlphaNumDash):0,0\n'
    + 'FIELD:contrib_risk_value:TYPE(STRING):LIKE(Invalid_AlphaNumPunc):0,0\n'
    + 'FIELD:contrib_risk_attr:TYPE(STRING):LIKE(Invalid_num):0,0\n'
    + 'FIELD:contrib_state_excl:TYPE(STRING):LIKE(Invalid_AlphaState):0,0\n'
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
