MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:BI
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking

FIELDTYPE:invalid_segment_identifier:ENUM(BI|BI)
FIELDTYPE:invalid_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_account_base_ab_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_classification_code_type:ENUM(001|002|003)
FIELDTYPE:invalid_classification_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(1..)
FIELDTYPE:invalid_primary_industry_code_indicator:ENUM(Y|N|)
FIELDTYPE:invalid_privacy_indicator:TYPE(STRING1):ENUM(Y|N|)

FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_file_sequence_number):TYPE(STRING12):0,0
FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0
FIELD:account_base_number:LIKE(invalid_account_base_ab_number):TYPE(STRING12):0,0
FIELD:classification_code_type:LIKE(invalid_classification_code_type):TYPE(STRING3):0,0
FIELD:classification_code:LIKE(invalid_classification_code):TYPE(STRING25):0,0
FIELD:primary_industry_code_indicator:LIKE(invalid_primary_industry_code_indicator):TYPE(STRING1):0,0
FIELD:privacy_indicator:LIKE(invalid_privacy_indicator):TYPE(STRING1):0,0



//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
