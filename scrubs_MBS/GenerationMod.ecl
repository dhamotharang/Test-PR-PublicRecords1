// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_MBS\n'
    + 'FILENAME:SourceGcExclusion\n'
    + 'NAMESCOPE:SourceGcExclusion\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + 'FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LENGTHS(0,4..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_alphanumeric:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=\'!+&,./#()_)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( -:)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0. If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:gc_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:product_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:company_id:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:status:TYPE(UNSIGNED3):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:date_added:TYPE(STRING20):0,0\n'
    + 'FIELD:user_added:TYPE(STRING30):0,0\n'
    + 'FIELD:date_changed:TYPE(STRING20):0,0\n'
    + 'FIELD:user_changed:TYPE(STRING30):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;
 
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
