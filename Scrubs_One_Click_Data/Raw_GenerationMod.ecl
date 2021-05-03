// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Raw_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.7';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_One_Click_Data';
  EXPORT spc_NAMESCOPE := 'Raw';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'One_Click_Data';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,ssn,firstname,lastname,dob,homeaddress,homecity,homestate,homezip,homephone,mobilephone,emailaddress,workname,workaddress,workcity,workstate,workzip,workphone,ref1firstname,ref1lastname,ref1phone,lastinquirydate,ip';
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
    ' OPTIONS:-gh\n'
    + 'MODULE:Scrubs_One_Click_Data\n'
    + 'FILENAME:One_Click_Data\n'
    + 'NAMESCOPE:Raw \n'
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
    + 'FIELDTYPE:Invalid_SSN:CUSTOM(Scrubs_One_Click_Data.functions.fn_numeric>0)\n'
    + 'FIELDTYPE:Invalid_fName:CUSTOM(Scrubs.functions.fn_populated_strings>0,lastname)\n'
    + 'FIELDTYPE:Invalid_Dob:CUSTOM(Scrubs.functions.fn_dob>0)\n'
    + 'FIELDTYPE:Invalid_mandatory_Alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0):LENGTHS(1..)\n'
    + 'FIELDTYPE:Invalid_Alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0) \n'
    + 'FIELDTYPE:Invalid_Zip:CUSTOM(Scrubs.functions.fn_valid_Zip>0)\n'
    + 'FIELDTYPE:Invalid_State:CUSTOM(Scrubs.Functions.fn_verify_state > 0)\n'
    + 'FIELDTYPE:Invalid_Phone:CUSTOM(Scrubs.functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:Invalid_pastDate:CUSTOM(Scrubs.functions.fn_valid_pastDate>0)\n'
    + '\n'
    + 'FIELD:ssn:TYPE(STRING):LIKE(Invalid_SSN):0,0\t\n'
    + 'FIELD:firstname:TYPE(STRING):LIKE(Invalid_fName):0,0\n'
    + 'FIELD:lastname:TYPE(STRING):0,0\n'
    + 'FIELD:dob:TYPE(STRING):LIKE(Invalid_Dob):0,0\t\n'
    + 'FIELD:homeaddress:TYPE(STRING):LIKE(Invalid_mandatory_Alpha):0,0\n'
    + 'FIELD:homecity:TYPE(STRING):LIKE(Invalid_Alpha):0,0\t\n'
    + 'FIELD:homestate:TYPE(STRING):LIKE(Invalid_State):0,0\t\n'
    + 'FIELD:homezip:TYPE(STRING):LIKE(Invalid_Zip):0,0\n'
    + 'FIELD:homephone:TYPE(STRING):LIKE(Invalid_Phone):0,0\t\n'
    + 'FIELD:mobilephone:TYPE(STRING):LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:emailaddress:TYPE(STRING):0,0\n'
    + 'FIELD:workname:TYPE(STRING):LIKE(Invalid_mandatory_Alpha):0,0\t\n'
    + 'FIELD:workaddress:TYPE(STRING):0,0\n'
    + 'FIELD:workcity:TYPE(STRING):0,0\t\n'
    + 'FIELD:workstate:TYPE(STRING):0,0\t\n'
    + 'FIELD:workzip:TYPE(STRING):0,0\n'
    + 'FIELD:workphone:TYPE(STRING):LIKE(Invalid_Phone):0,0\t\n'
    + 'FIELD:ref1firstname:TYPE(STRING):0,0\n'
    + 'FIELD:ref1lastname:TYPE(STRING):0,0\n'
    + 'FIELD:ref1phone:TYPE(STRING):LIKE(Invalid_Phone):0,0\t\n'
    + 'FIELD:lastinquirydate:LIKE(Invalid_pastDate):0,0\t\n'
    + 'FIELD:ip:TYPE(STRING):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

