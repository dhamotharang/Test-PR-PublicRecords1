// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT39;
EXPORT NAC_GenerationMod := MODULE(SALT39.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.9.0';
  EXPORT salt_MODULE := 'SALT39'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_FraudGov';
  EXPORT spc_NAMESCOPE := 'NAC';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'NAC';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,SearchAddress1StreetAddress1,SearchAddress1StreetAddress2,SearchAddress1City,SearchAddress1State,SearchAddress1Zip,SearchAddress2StreetAddress1,SearchAddress2StreetAddress2,SearchAddress2City,SearchAddress2State,SearchAddress2Zip,SearchCaseId,enduserip,CaseID,ClientFirstName,ClientMiddleName,ClientLastName,ClientPhone,ClientEmail';
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
    + 'FILENAME:NAC\n'
    + 'NAMESCOPE:NAC \n'
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
    + 'FIELDTYPE:invalid_alphanumeric:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_)\n'
    + 'FIELDTYPE:invalid_email:ALLOW(-_.0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,8):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_numeric:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(-0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,5..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,2):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_ssn:ALLOW(0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,9):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_phone:ALLOW(0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:LENGTHS(0,10..):ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_ip:ALLOW(.0123456789):SPACES( <>{}[]-^=\'`!+&,./#()_):LEFTTRIM:ONFAIL(BLANK)\n'
    + 'FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:SPACES( <>{}[]-^=\'`!+&,./#()_)\n'
    + '// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.\n'
    + '// If the actual specificity for a field is <1, round it up to 1 rather than down to 0. If your cluster is running\n'
    + '// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.\n'
    + 'FIELD:SearchAddress1StreetAddress1:TYPE(string70):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:SearchAddress1StreetAddress2:TYPE(string70):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:SearchAddress1City:TYPE(string30):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:SearchAddress1State:TYPE(string2):LIKE(invalid_state):0,0 \n'
    + 'FIELD:SearchAddress1Zip:TYPE(string9):LIKE(invalid_zip):0,0\n'
    + 'FIELD:SearchAddress2StreetAddress1:TYPE(string70):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:SearchAddress2StreetAddress2:TYPE(string70):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:SearchAddress2City:TYPE(string30):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:SearchAddress2State:TYPE(string2):LIKE(invalid_state):0,0\n'
    + 'FIELD:SearchAddress2Zip:TYPE(string9):LIKE(invalid_zip):0,0\n'
    + 'FIELD:SearchCaseId:TYPE(string20):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:enduserip:TYPE(string15):LIKE(invalid_ip):0,0\n'
    + 'FIELD:CaseID:TYPE(string20):LIKE(invalid_alphanumeric):0,0\n'
    + 'FIELD:ClientFirstName:TYPE(string25):LIKE(invalid_name):0,0\n'
    + 'FIELD:ClientMiddleName:TYPE(string25):LIKE(invalid_name):0,0\n'
    + 'FIELD:ClientLastName:TYPE(string30):LIKE(invalid_name):0,0\n'
    + 'FIELD:ClientPhone:TYPE(string10):LIKE(invalid_phone):0,0\n'
    + 'FIELD:ClientEmail:TYPE(string256):LIKE(invalid_email):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

