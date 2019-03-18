// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)

  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE

  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Cortera_Tradeline';
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
  EXPORT spc_FILENAME := 'Cortera_Tradeline';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,link_id,account_key,segment_id,ar_date,total_ar,current_ar,aging_1to30,aging_31to60,aging_61to90,aging_91plus,credit_limit,first_sale_date,last_sale_date';
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
    + 'MODULE:Scrubs_Cortera_Tradeline\n'
    + 'FILENAME:Cortera_Tradeline\n'
    + '// Uncomment up to NINES for internal or external adl\n'
    + '// IDFIELD:EXISTS:<NameOfIDField>\n'
    + '// RIDFIELD:<NameOfRidField>\n'
    + '// RECORDS:<NumberOfRecordsInDataFile>\n'
    + 'RECORDS:1000000\n'
    + '// POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + 'NINES:3\n'
    + '// Uncomment Process if doing external adl\n'
    + '// PROCESS:<ProcessName>\n'
    + '// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '// FUZZY can be used to create new types of FUZZY linking\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELDTYPE:numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:number:ALLOW(0123456789-):LENGTHS(0,1..)\n'
    + 'FIELDTYPE:date:ALLOW(0123456789):LENGTHS(0,8)\n'
    + 'FIELD:link_id:LIKE(numeric):0,0\n'
    + 'FIELD:account_key:TYPE(STRING32):0,0\n'
    + 'FIELD:segment_id:TYPE(STRING2):0,0\n'
    + 'FIELD:ar_date:TYPE(STRING8):LIKE(date):0,0\n'
    + 'FIELD:total_ar:TYPE(STRING20):LIKE(number):0,0\n'
    + 'FIELD:current_ar:TYPE(STRING20):LIKE(number):0,0\n'
    + 'FIELD:aging_1to30:TYPE(STRING20):LIKE(number):0,0\n'
    + 'FIELD:aging_31to60:TYPE(STRING20):LIKE(number):0,0\n'
    + 'FIELD:aging_61to90:TYPE(STRING20):LIKE(number):0,0\n'
    + 'FIELD:aging_91plus:TYPE(STRING):LIKE(number):0,0\n'
    + 'FIELD:credit_limit:TYPE(STRING20):LIKE(number):0,0\n'
    + 'FIELD:first_sale_date:TYPE(STRING8):LIKE(date):0,0\n'
    + 'FIELD:last_sale_date:TYPE(STRING8):LIKE(date):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;

  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});

END;
