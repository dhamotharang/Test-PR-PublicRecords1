// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT ProductInclude_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_MBS';
  EXPORT spc_NAMESCOPE := 'ProductInclude';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'ProductInclude';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,fdn_file_product_include_id,fdn_file_info_id,product_id,status,date_added,user_added,date_changed,user_changed';
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
    + 'MODULE:Scrubs_MBS\n'
    + 'FILENAME:ProductInclude\n'
    + 'NAMESCOPE:ProductInclude \n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField> \n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl \n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LENGTHS(0,4..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_alphanumeric:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=\'!+&,./#()_)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( -:)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + 'FIELD:fdn_file_product_include_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:fdn_file_info_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:product_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:status:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:date_added:TYPE(STRING20):0,0\n'
    + 'FIELD:user_added:TYPE(STRING30):0,0\n'
    + 'FIELD:date_changed:TYPE(STRING20):0,0\n'
    + 'FIELD:user_changed:TYPE(STRING30):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking '
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

