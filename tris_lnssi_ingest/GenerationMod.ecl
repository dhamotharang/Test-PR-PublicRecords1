// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-gn\n'
    + 'MODULE:tris_lnssi_ingest\n'
    + 'FILENAME:basefile\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + 'RIDFIELD:rcid:GENERATE \n'
    + '\n'
    + 'INGESTFILE:tris_lnssi_input_file:NAMED(tris_lnssi_build.file_input)\n'
    + '// RECORDS:<NumberOfRecordsInDataFile> \n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:contrib_risk_field:TYPE(STRING):0,0\n'
    + 'FIELD:Contrib_Risk_Value:TYPE(STRING):0,0\n'
    + 'FIELD:Contrib_Risk_Attr:TYPE(STRING):0,0\n'
    + 'FIELD:contrib_state_excl:TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
