MODULE:Scrubs_Death_Master_SSA
FILENAME:Death_Master_SSA

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

SOURCEFIELD:rec_type

FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(8,0)
FIELDTYPE:invalid_rec_type:ENUM(A|C|D|):LENGTHS(1,0)
FIELDTYPE:invalid_ssn:ALLOW(0123456789):LENGTHS(9,4,0)
FIELDTYPE:invalid_vorp_code:ENUM(V|P|):LENGTHS(1,0)
FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©'):SPACES( -.()):LENGTHS(0..)
FIELDTYPE:invalid_st_country_code:ALLOW(0123456789):LENGTHS(2,0)
FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(5,0)
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_fipscounty:ALLOW(0123456789):LENGTHS(3,0)
FIELDTYPE:invalid_name_score:ALLOW(0123456789)

FIELD:filedate:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:rec_type:LIKE(invalid_rec_type):TYPE(STRING1):0,0
FIELD:rec_type_orig:LIKE(invalid_rec_type):TYPE(STRING1):0,0
FIELD:ssn:LIKE(invalid_ssn):TYPE(STRING9):0,0
FIELD:lname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:name_suffix:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:fname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:mname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:vorp_code:LIKE(invalid_vorp_code):TYPE(STRING1):0,0
FIELD:dod8:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:dob8:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:st_country_code:LIKE(invalid_st_country_code):TYPE(STRING2):0,0
FIELD:zip_lastres:LIKE(invalid_zip):TYPE(STRING5):0,0
FIELD:zip_lastpayment:LIKE(invalid_zip):TYPE(STRING5):0,0
FIELD:state:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:fipscounty:LIKE(invalid_fipscounty):TYPE(STRING3):0,0
FIELD:clean_title:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:clean_fname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:clean_mname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:clean_lname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:clean_name_suffix:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:clean_name_score:LIKE(invalid_name_score):TYPE(STRING3):0,0
FIELD:crlf:TYPE(STRING2):0,0

// RECORDTYPE:Name:[TAG(field,value)]:[NOTAG]:[FAIL]:CONDITION(field,operator,field)*:VALID(fieldlist)
// â€¢	If a TAG is present then the recordtype only applies to records for which field=value.
// â€¢	If NOTAG is present then only records that have NOT been measured using a TAGed recordtype are processed.
// â€¢	Condition is of the form CONDITION(field1,>=,field2) - field1 and 2 have to be present in the spc file. 
// â€¢	Valid(fieldlist) specifies that every field in the list of fields has to be valid

RECORDTYPE:invalid_dob8_dates:CONDITION(dob8,<,filedate):VALID(dob8,filedate)
RECORDTYPE:invalid_dod8_dates:CONDITION(dod8,<,filedate):VALID(dod8,filedate)

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
