// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT BS_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.9';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Business_Credit';
  EXPORT spc_NAMESCOPE := 'BS';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Business_Credit';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,segment_identifier,file_sequence_number,parent_sequence_number,account_base_number,business_name,web_address,guarantor_owner_indicator,relationship_to_business_indicator,percent_of_liability,percent_of_ownership_if_owner_principal';
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
    + 'MODULE:Scrubs_Business_Credit\n'
    + 'FILENAME:Business_Credit\n'
    + 'NAMESCOPE:BS\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '//FUZZY can be used to create new types of FUZZY linking\n'
    + '\n'
    + 'FIELDTYPE:invalid_segment_identifier:ENUM(BS|BS)\n'
    + 'FIELDTYPE:invalid_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_account_base_ab_number:ALLOW(0123456789):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_business_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.\'-/#`+"!*@():;):LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_web_address:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789./ )\n'
    + 'FIELDTYPE:invalid_guarantor_owner_indicator:ENUM(001|002|003)\n'
    + 'FIELDTYPE:invalid_relationship_to_business_indicator:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_percent_of_liability:ALLOW(0123456789)\n'
    + 'FIELDTYPE:invalid_percent_of_ownership_if_owner_principal:ALLOW(0123456789)\n'
    + '\n'
    + 'FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0\n'
    + 'FIELD:file_sequence_number:LIKE(invalid_file_sequence_number):TYPE(STRING12):0,0\n'
    + 'FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0\n'
    + 'FIELD:account_base_number:LIKE(invalid_account_base_ab_number):TYPE(STRING12):0,0\n'
    + 'FIELD:business_name:LIKE(invalid_business_name):TYPE(STRING250):0,0\n'
    + 'FIELD:web_address:LIKE(invalid_web_address):TYPE(STRING250):0,0\n'
    + 'FIELD:guarantor_owner_indicator:LIKE(invalid_guarantor_owner_indicator):TYPE(STRING3):0,0\n'
    + 'FIELD:relationship_to_business_indicator:LIKE(invalid_relationship_to_business_indicator):TYPE(STRING3):0,0\n'
    + 'FIELD:percent_of_liability:LIKE(invalid_percent_of_liability):TYPE(STRING3):0,0\n'
    + 'FIELD:percent_of_ownership_if_owner_principal:LIKE(invalid_percent_of_ownership_if_owner_principal):TYPE(STRING3):0,0\n'
    + '\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

