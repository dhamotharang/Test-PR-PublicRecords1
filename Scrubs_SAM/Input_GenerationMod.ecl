// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Input_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_SAM';
  EXPORT spc_NAMESCOPE := 'Input';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'SAM';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,classification,name,prefix,firstname,middlename,lastname,suffix,address_1,address_2,address_3,address_4,city,state,country,zipcode,duns,exclusionprogram,excludingagency,ctcode,exclusiontype,additionalcomments,activedate,terminationdate,recordstatus,crossreference,samnumber,cage';
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
    + 'MODULE:Scrubs_SAM\n'
    + 'FILENAME:SAM\n'
    + 'NAMESCOPE:Input\n'
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
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_SAM.Functions.fn_populated_strings>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_name:CUSTOM(Scrubs_SAM.Functions.fn_populated_strings>0,firstname,lastname)\n'
    + 'FIELDTYPE:invalid_firstname:CUSTOM(Scrubs_SAM.Functions.fn_populated_strings>0,name,lastname)\n'
    + 'FIELDTYPE:invalid_middlename:CUSTOM(Scrubs_SAM.Functions.fn_populated_strings>0,name,firstname,lastname)\n'
    + 'FIELDTYPE:invalid_lastname:CUSTOM(Scrubs_SAM.Functions.fn_populated_strings>0,name,lastname)\n'
    + 'FIELDTYPE:invalid_address_2:CUSTOM(Scrubs_SAM.Functions.fn_str1_depends_str2>0,address_1)\n'
    + 'FIELDTYPE:invalid_address_3:CUSTOM(Scrubs_SAM.Functions.fn_str1_depends_str2_str3>0,address_1,address_2)\n'
    + 'FIELDTYPE:invalid_address_4:CUSTOM(Scrubs_SAM.Functions.fn_str1_depends_str2_str3_str4>0,address_1,address_2,address_3)\n'
    + 'FIELDTYPE:invalid_city:CUSTOM(Scrubs_SAM.Functions.fn_populated_strings>0,state,country,zipcode)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_SAM.Functions.fn_Valid_StateAbbrev>0,country)\n'
    + 'FIELDTYPE:invalid_country:CUSTOM(Scrubs_SAM.Functions.fn_Valid_Country3Abbrev>0)\n'
    + 'FIELDTYPE:invalid_zipcode:CUSTOM(Scrubs_SAM.Functions.fn_verify_zip059>0)\n'
    + 'FIELDTYPE:invalid_exclusionprogram:CUSTOM(Scrubs_SAM.Functions.fn_exclusion_program>0)\n'
    + 'FIELDTYPE:invalid_exclusiontype:CUSTOM(Scrubs_SAM.Functions.fn_exclusion_type>0)\n'
    + 'FIELDTYPE:invalid_activedate:CUSTOM(Scrubs_SAM.Functions.fn_Valid_Past_Date>0)\n'
    + 'FIELDTYPE:invalid_terminationdate:CUSTOM(Scrubs_SAM.Functions.fn_Valid_General_Date>0)\n'
    + 'FIELDTYPE:invalid_samnumber:CUSTOM(Scrubs_SAM.Functions.fn_alphanum>0)\n'
    + '\n'
    + '//FIELD DEFINITIONS\n'
    + 'FIELD:classification:TYPE(STRING):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:name:TYPE(STRING):LIKE(invalid_name):0,0\n'
    + 'FIELD:prefix:TYPE(STRING):0,0\n'
    + 'FIELD:firstname:TYPE(STRING):LIKE(invalid_firstname):0,0\n'
    + 'FIELD:middlename:TYPE(STRING):LIKE(invalid_middlename):0,0\n'
    + 'FIELD:lastname:TYPE(STRING):LIKE(invalid_lastname):0,0\n'
    + 'FIELD:suffix:TYPE(STRING):0,0\n'
    + 'FIELD:address_1:TYPE(STRING):0,0\n'
    + 'FIELD:address_2:TYPE(STRING):LIKE(invalid_address_2):0,0\n'
    + 'FIELD:address_3:TYPE(STRING):LIKE(invalid_address_3):0,0\n'
    + 'FIELD:address_4:TYPE(STRING):LIKE(invalid_address_4):0,0\n'
    + 'FIELD:city:TYPE(STRING):LIKE(invalid_city):0,0\n'
    + 'FIELD:state:TYPE(STRING):LIKE(invalid_state):0,0\n'
    + 'FIELD:country:TYPE(STRING):LIKE(invalid_country):0,0\n'
    + 'FIELD:zipcode:TYPE(STRING):LIKE(invalid_zipcode):0,0\n'
    + 'FIELD:duns:TYPE(STRING):0,0\n'
    + 'FIELD:exclusionprogram:TYPE(STRING):LIKE(invalid_exclusionprogram):0,0\n'
    + 'FIELD:excludingagency:TYPE(STRING):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:ctcode:TYPE(STRING):0,0\n'
    + 'FIELD:exclusiontype:TYPE(STRING):LIKE(invalid_exclusiontype):0,0\n'
    + 'FIELD:additionalcomments:TYPE(STRING):0,0\n'
    + 'FIELD:activedate:TYPE(STRING):LIKE(invalid_activedate):0,0\n'
    + 'FIELD:terminationdate:TYPE(STRING):LIKE(invalid_terminationdate):0,0\n'
    + 'FIELD:recordstatus:TYPE(STRING):0,0\n'
    + 'FIELD:crossreference:TYPE(STRING):0,0\n'
    + 'FIELD:samnumber:TYPE(STRING):LIKE(invalid_samnumber):0,0\n'
    + 'FIELD:cage:TYPE(STRING):0,0\n'
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

