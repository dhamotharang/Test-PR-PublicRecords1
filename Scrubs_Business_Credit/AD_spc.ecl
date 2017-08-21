
MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:AD

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
//*

FIELDTYPE:invalid_segment_identifier:ENUM(AD|AD)
FIELDTYPE:invalid_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_account_base_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_address_line_1:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .:-#/',&#):LENGTHS(1..)
FIELDTYPE:invalid_address_line_2:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \':&-.#/,)
FIELDTYPE:invalid_city:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -.')
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_zip_code_or_ca_postal_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_postal_code:ALLOW(0123456789')
FIELDTYPE:invalid_country_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_primary_address_indicator:ENUM(Y|N|)
//FIELDTYPE:invalid_address_classification:ALLOW( ):WITHIN(Scrubs_Business_Credit.AD_valid_address_classification,address_classification)
FIELDTYPE:invalid_address_classification:ENUM(001|002|003|004|005|006|007|008|009|010|011|012|)
    
FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_file_sequence_number):TYPE(STRING12):0,0
FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0
FIELD:account_base_number:LIKE(invalid_account_base_number):TYPE(STRING12):0,0
FIELD:address_line_1:LIKE(invalid_address_line_1):TYPE(STRING100):0,0
FIELD:address_line_2:LIKE(invalid_address_line_2):TYPE(STRING100):0,0
FIELD:city:LIKE(invalid_city):TYPE(STRING50):0,0
FIELD:state:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:zip_code_or_ca_postal_code:LIKE(invalid_zip_code_or_ca_postal_code):TYPE(STRING6):0,0
FIELD:postal_code:TYPE(STRING4):LIKE(invalid_postal_code):0,0
FIELD:country_code:TYPE(STRING2):LIKE(invalid_country_code):0,0
FIELD:primary_address_indicator:LIKE(invalid_primary_address_indicator):TYPE(STRING1):0,0
FIELD:address_classification:LIKE(invalid_address_classification):TYPE(STRING3):0,0


//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

