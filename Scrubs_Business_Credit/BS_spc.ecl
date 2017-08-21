MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:BS
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

FIELDTYPE:invalid_segment_identifier:ENUM(BS|BS)
FIELDTYPE:invalid_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_account_base_ab_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_business_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.'-/#`+"!*@():;):LENGTHS(1..)
FIELDTYPE:invalid_web_address:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789./)
FIELDTYPE:invalid_guarantor_owner_indicator:ENUM(001|002|003)
FIELDTYPE:invalid_relationship_to_business_indicator:ALLOW(0123456789)
FIELDTYPE:invalid_percent_of_liability:ALLOW(0123456789)
FIELDTYPE:invalid_percent_of_ownership_if_owner_principal:ALLOW(0123456789)

FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_file_sequence_number):TYPE(STRING12):0,0
FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0
FIELD:account_base_number:LIKE(invalid_account_base_ab_number):TYPE(STRING12):0,0
FIELD:business_name:LIKE(invalid_business_name):TYPE(STRING250):0,0
FIELD:web_address:LIKE(invalid_web_address):TYPE(STRING250):0,0
FIELD:guarantor_owner_indicator:LIKE(invalid_guarantor_owner_indicator):TYPE(STRING3):0,0
FIELD:relationship_to_business_indicator:LIKE(invalid_relationship_to_business_indicator):TYPE(STRING3):0,0
FIELD:percent_of_liability:LIKE(invalid_percent_of_liability):TYPE(STRING3):0,0
FIELD:percent_of_ownership_if_owner_principal:LIKE(invalid_percent_of_ownership_if_owner_principal):TYPE(STRING3):0,0

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
