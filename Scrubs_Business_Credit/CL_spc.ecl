MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:CL
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


FIELDTYPE:invalid_segment_identifier:ENUM(CL|CL)
FIELDTYPE:invalid_file_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_account_base_ab_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_collateral_indicator:ENUM(Y|N)
FIELDTYPE:invalid_type_of_collateral:ENUM(001|002|003|004|005|006|007|008|009|010|099|) 
FIELDTYPE:invalid_collateral_description:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_ucc_filing_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_ucc_filing_type:ALLOW(0123456789)
FIELDTYPE:invalid_ucc_filing_date:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_ucc_filing_expiration_date:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_ucc_filing_jurisdiction:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_ucc_filing_description:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)

FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_file_sequence_number):TYPE(STRING12):0,0
FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0
FIELD:account_base_number:LIKE(invalid_account_base_ab_number):TYPE(STRING12):0,0
FIELD:collateral_indicator:LIKE(invalid_collateral_indicator):TYPE(STRING1):0,0
FIELD:type_of_collateral_secured_for_this_account:LIKE(invalid_type_of_collateral):TYPE(STRING3):0,0
FIELD:collateral_description:LIKE(invalid_collateral_description):TYPE(STRING250):0,0
FIELD:ucc_filing_number:LIKE(invalid_ucc_filing_number):TYPE(STRING50):0,0
FIELD:ucc_filing_type:LIKE(invalid_ucc_filing_type):TYPE(STRING3):0,0
FIELD:ucc_filing_date:LIKE(invalid_ucc_filing_date):TYPE(STRING8):0,0
FIELD:ucc_filing_expiration_date:LIKE(invalid_ucc_filing_expiration_date):TYPE(STRING8):0,0
FIELD:ucc_filing_jurisdiction:LIKE(invalid_ucc_filing_jurisdiction):TYPE(STRING100):0,0
FIELD:ucc_filing_description:LIKE(invalid_ucc_filing_description):TYPE(STRING250):0,0

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
