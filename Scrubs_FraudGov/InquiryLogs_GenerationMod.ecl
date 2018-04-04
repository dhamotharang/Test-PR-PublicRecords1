﻿// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT InquiryLogs_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FraudGov';
  EXPORT spc_NAMESCOPE := 'InquiryLogs';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'InquiryLogs';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,Customer_Account_Number,Customer_County,Customer_State,Customer_Agency_Vertical_Type,Customer_Program,LexID,raw_Full_Name,raw_First_name,raw_Last_Name,SSN,Drivers_License_State,Drivers_License_Number,Street_1,City,State,Zip,did';
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
    + 'MODULE:Scrubs_FraudGov\n'
    + 'FILENAME:InquiryLogs\n'
    + 'NAMESCOPE:InquiryLogs \n'
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
    + 'FIELD:Customer_Account_Number:TYPE(string20):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:Customer_County:TYPE(string3):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:Customer_State:TYPE(string2):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:Customer_Agency_Vertical_Type:TYPE(string):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:Customer_Program:TYPE(string1):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:LexID:TYPE(unsigned6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:raw_Full_Name:TYPE(string60):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:raw_First_name:TYPE(string100):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:raw_Last_Name:TYPE(string100):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:SSN:TYPE(string9):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:Drivers_License_State:TYPE(string2):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:Drivers_License_Number:TYPE(string25):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:Street_1:TYPE(string70):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:City:TYPE(string30):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:State:TYPE(string2):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:Zip:TYPE(string9):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

