// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT Base_History_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Voters';
  EXPORT spc_NAMESCOPE := 'Base_History';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Voters';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,vtid,voted_year,primary,special_1,other,special_2,general,pres,vote_date';
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
    + 'MODULE:Scrubs_Voters\n'
    + 'FILENAME:Voters\n'
    + 'NAMESCOPE:Base_History\n'
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
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + '\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Voters.Functions.fn_numeric>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_voted_year:CUSTOM(Scrubs_Voters.Functions.fn_valid_year>0)\n'
    + 'FIELDTYPE:invalid_pres:CUSTOM(Scrubs_Voters.Functions.fn_populated_strings>0,primary,special_1,other,special_2,general)\n'
    + 'FIELDTYPE:invalid_vote_date:CUSTOM(Scrubs_Voters.Functions.fn_valid_generic_date>0)\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:vtid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:voted_year:TYPE(STRING4):LIKE(invalid_voted_year):0,0\n'
    + 'FIELD:primary:TYPE(STRING2):0,0\n'
    + 'FIELD:special_1:TYPE(STRING2):0,0\n'
    + 'FIELD:other:TYPE(STRING2):0,0\n'
    + 'FIELD:special_2:TYPE(STRING2):0,0\n'
    + 'FIELD:general:TYPE(STRING2):0,0\n'
    + 'FIELD:pres:TYPE(STRING2):LIKE(invalid_pres):0,0\n'
    + 'FIELD:vote_date:TYPE(STRING8):LIKE(invalid_vote_date):0,0\n'
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

