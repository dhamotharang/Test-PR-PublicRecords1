MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:MS
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

FIELDTYPE:invalid_segment_identifier:ENUM(MS|MS)
FIELDTYPE:invalid_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_account_base_ab_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_name_of_value:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_):LENGTHS(1..)
FIELDTYPE:invalid_valuenum:TYPE:ALLOW(-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .):LENGTHS(1..)
FIELDTYPE:invalid_privacy_indicator:TYPE(STRING1):ENUM(Y|N|)

FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_file_sequence_number):TYPE(STRING12):0,0
FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0
FIELD:account_base_number:LIKE(invalid_account_base_ab_number):TYPE(STRING12):0,0
FIELD:name_of_value:LIKE(invalid_name_of_value):TYPE(STRING20):0,0
FIELD:value_string:LIKE(invalid_valuenum):TYPE(STRING250):0,0
FIELD:privacy_indicator:LIKE(invalid_privacy_indicator):TYPE(STRING1):0,0


//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
