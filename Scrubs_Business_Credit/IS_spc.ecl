MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:IS
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

FIELDTYPE:invalid_segment_identifier:ENUM(IS|IS)
FIELDTYPE:invalid_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_account_base_ab_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_first_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/'):LENGTHS(1..)
FIELDTYPE:invalid_middle_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/')
FIELDTYPE:invalid_last_name:TYPE(STRING50):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/'):LENGTHS(1..)
FIELDTYPE:invalid_suffix:TYPE(STRING5):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_e_mail_address:TYPE(STRING100):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-;)
FIELDTYPE:invalid_guarantor_owner_indicator:ENUM(001|002|003)
FIELDTYPE:invalid_relationship_to_business_indicator:ALLOW(0123456789)
FIELDTYPE:invalid_business_title:TYPE(STRING150):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_percent_of_liability:TYPE(STRING3):ALLOW(0123456789)
FIELDTYPE:invalid_percent_of_ownership:TYPE(STRING3):ALLOW(0123456789)  

FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_file_sequence_number):TYPE(STRING12):0,0
FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0
FIELD:account_base_number:LIKE(invalid_account_base_ab_number):TYPE(STRING12):0,0
FIELD:original_fname:LIKE(invalid_first_name):TYPE(STRING50):0,0
FIELD:original_mname:LIKE(invalid_middle_name):TYPE(STRING50):0,0
FIELD:original_lname:LIKE(invalid_last_name):TYPE(STRING50):0,0
FIELD:original_suffix:LIKE(invalid_suffix):TYPE(STRING5):0,0
FIELD:e_mail_address:LIKE(invalid_e_mail_address):TYPE(STRING100):0,0
FIELD:guarantor_owner_indicator:LIKE(invalid_guarantor_owner_indicator):TYPE(STRING3):0,0
FIELD:relationship_to_business_indicator:LIKE(invalid_relationship_to_business_indicator):TYPE(STRING3):0,0
FIELD:business_title:LIKE(invalid_business_title):TYPE(STRING150):0,0
FIELD:percent_of_liability:LIKE(invalid_percent_of_liability):TYPE(STRING3):0,0
FIELD:percent_of_ownership:LIKE(invalid_percent_of_ownership):TYPE(STRING3):0,0

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
