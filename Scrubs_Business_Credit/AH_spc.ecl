MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:AH
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

FIELDTYPE:invalid_segment_identifier:ENUM(AH|AH)
FIELDTYPE:invalid_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_account_base_ab_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_previous_member_id:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_previous_account_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-)
FIELDTYPE:invalid_previous_account_type:ENUM(001|002|003|004|005|006|099|)
FIELDTYPE:invalid_type_of_conversion_maintenance:ENUM(001|002|003|004|005|006|)
FIELDTYPE:invalid_date_account_converted:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)

FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_file_sequence_number):TYPE(STRING12):0,0
FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0
FIELD:account_base_number:LIKE(invalid_account_base_ab_number):TYPE(STRING12):0,0
FIELD:previous_member_id:LIKE(invalid_previous_member_id):TYPE(STRING30):0,0
FIELD:previous_account_number:LIKE(invalid_previous_account_number):TYPE(STRING50):0,0
FIELD:previous_account_type:LIKE(invalid_previous_account_number):TYPE(STRING3):0,0
FIELD:type_of_conversion_maintenance:LIKE(invalid_type_of_conversion_maintenance):TYPE(STRING3):0,0
FIELD:date_account_converted:LIKE(invalid_date_account_converted):TYPE(STRING8):0,0



//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
