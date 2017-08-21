MODULE:Scrubs_PhoneMart
FILENAME:PhoneMart
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//SOURCEFIELD:phone
//Fieldtype
FIELDTYPE:invalid_phone:ALLOW(0123456789):LENGTHS(10)
FIELDTYPE:invalid_number:ALLOW(0123456789 )
FIELDTYPE:invalid_date:ALLOW(0123456789)
FIELDTYPE:invalid_record_type:ENUM(1|2|4):LENGTHS(1)
FIELDTYPE:invalid_ssn:ALLOW(0123456789):LENGTHS(9,4,0)
FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ,.-)
FIELDTYPE:invalid_alpha_numeric:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( ,.-)
FIELDTYPE:invalid_state:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_zip5:ALLOW(0123456789):LENGTHS(5,0)
FIELDTYPE:invalid_history_flag:ENUM(H|):LENGTHS(1,0)
//Fields
FIELD:phone:LIKE(invalid_phone):TYPE(STRING10):0,0
FIELD:did:LIKE(invalid_number):TYPE(UNSIGNED6):0,0
FIELD:dt_vendor_first_reported:LIKE(invalid_date):TYPE(UNSIGNED4):0,0
FIELD:dt_vendor_last_reported:LIKE(invalid_date):TYPE(UNSIGNED4):0,0
FIELD:dt_first_seen:LIKE(invalid_date):TYPE(UNSIGNED4):0,0
FIELD:dt_last_seen:LIKE(invalid_date):TYPE(UNSIGNED4):0,0
FIELD:record_type:LIKE(invalid_record_type):TYPE(STRING1):0,0
FIELD:cid_number:LIKE(invalid_alpha_numeric):TYPE(QSTRING18):0,0
FIELD:csd_ref_number:LIKE(invalid_number):TYPE(STRING10):0,0
FIELD:ssn:LIKE(invalid_ssn):TYPE(STRING9):0,0
FIELD:address:TYPE(STRIN80):0,0
FIELD:city:LIKE(invalid_alpha):TYPE(STRING28):0,0
FIELD:state:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:zipcode:LIKE(invalid_zip5):TYPE(STRING5):0,0
FIELD:history_flag:LIKE(invalid_history_flag):TYPE(STRING1):0,0
FIELD:title:LIKE(invalid_alpha):TYPE(STRING5):0,0
FIELD:fname:LIKE(invalid_alpha):TYPE(STRING20):0,0
FIELD:mname:LIKE(invalid_alpha):TYPE(STRING20):0,0
FIELD:lname:LIKE(invalid_alpha):TYPE(STRING20):0,0
FIELD:name_suffix:LIKE(invalid_alpha):TYPE(STRING5):0,0
