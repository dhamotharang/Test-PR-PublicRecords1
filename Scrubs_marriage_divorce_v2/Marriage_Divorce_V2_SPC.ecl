MODULE:Scrubs_Marriage_Divorce_V2
FILENAME:Marriage_Divorce_V2_Profile
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
FIELDTYPE:nums:ALLOW(0123456789)
FIELDTYPE:lowercase:ALLOW(abcdefghijklmnopqrstuvwxyz)
FIELDTYPE:uppercase:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:alphas:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)
FIELDTYPE:lowercaseandnums:ALLOW(abcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:uppercaseandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:alphasandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:allupper:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:allupperandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:allalphaandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)

FIELDTYPE:blank:LENGTHS(0)
FIELDTYPE:invalid_blank:LIKE(blank)
FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -):LENGTHS(0..)
FIELDTYPE:invalid_Num:ALLOW(0123456789):LENGTHS(0..)
FIELDTYPE:invalid_date:LIKE(nums):SPACES( -/):LENGTHS(0,1,6,7,8,9,10)
FIELDTYPE:invalid_name:LIKE(allalphaandnums):SPACES( -,./\#:;&*"'`_()[]{}!?):LENGTHS(0..)
FIELDTYPE:invalid_vendor:LIKE(uppercaseandnums):SPACES( -):LENGTHS(0..)
FIELDTYPE:invalid_source_file:LIKE(uppercase):SPACES( -_/):LENGTHS(0..)
FIELDTYPE:invalid_party_type:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,1)
FIELDTYPE:invalid_filing_type:LIKE(invalid_Num):LENGTHS(0..)
FIELDTYPE:invalid_name_format:ENUM(L|F|)
FIELDTYPE:invalid_age:LIKE(Nums):LENGTHS(0,1,2,3)
FIELDTYPE:invalid_race:LIKE(uppercase):SPACES( -,/&):LENGTHS(0..)
FIELDTYPE:invalid_address:CAPS:LIKE(allupperandnums):SPACES( -&/\#%.;,'_"*()%?=@):LENGTHS(0..)
FIELDTYPE:invalid_city:LIKE(alphas):SPACES( -,&\/.:#;'):LENGTHS(0..)
FIELDTYPE:invalid_county:LIKE(alphas):SPACES( -,&\/.:#();):LENGTHS(0..)
FIELDTYPE:invalid_state:LIKE(uppercase):LENGTHS(0,2)
FIELDTYPE:invalid_filing_number:LIKE(allalphaandnums):SPACES( -.*/):LENGTHS(0..)
FIELDTYPE:invalid_docket_volume:LIKE(allalphaandnums):SPACES( -/,*()#."):LENGTHS(0..)

FIELD:dt_first_seen:LIKE(invalid_date):TYPE(unsigned3):0,0
FIELD:dt_last_seen:LIKE(invalid_date):TYPE(unsigned3):0,0
FIELD:dt_vendor_first_reported:LIKE(invalid_date):TYPE(unsigned3):0,0
FIELD:dt_vendor_last_reported:LIKE(invalid_date):TYPE(unsigned3):0,0
FIELD:record_id:LIKE(invalid_Num):TYPE(unsigned6):0,0
FIELD:filing_type:LIKE(invalid_filing_type):TYPE(STRING1):0,0
FIELD:filing_subtype:TYPE(STRING25):0,0
FIELD:vendor:LIKE(invalid_vendor):TYPE(STRING5):0,0
FIELD:source_file:LIKE(invalid_source_file):TYPE(STRING25):0,0
FIELD:process_date:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:state_origin:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:party1_type:LIKE(invalid_party_type):TYPE(STRING1):0,0
FIELD:party1_name_format:LIKE(invalid_name_format):TYPE(STRING1):0,0
FIELD:party1_name:LIKE(invalid_name):TYPE(STRING70):0,0
FIELD:party1_alias:LIKE(invalid_name):TYPE(STRING70):0,0
FIELD:party1_dob:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:party1_birth_state:LIKE(invalid_state):TYPE(STRING2):0,0
// FIELD:party1_age:LIKE(invalid_age):TYPE(STRING3):0,0
FIELD:party1_age:TYPE(STRING3):0,0
FIELD:party1_race:LIKE(invalid_race):TYPE(STRING30):0,0
FIELD:party1_addr1:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:party1_csz:TYPE(STRING50):0,0
FIELD:party1_county:LIKE(invalid_county):TYPE(STRING35):0,0
FIELD:party1_previous_marital_status:TYPE(STRING20):0,0
FIELD:party1_how_marriage_ended:TYPE(STRING20):0,0
FIELD:party1_times_married:TYPE(STRING2):0,0
FIELD:party1_last_marriage_end_dt:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:party2_type:LIKE(invalid_party_type):TYPE(STRING1):0,0
FIELD:party2_name_format:LIKE(invalid_name_format):TYPE(STRING1):0,0
FIELD:party2_name:LIKE(invalid_name):TYPE(STRING70):0,0
FIELD:party2_alias:TYPE(STRING70):0,0
FIELD:party2_dob:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:party2_birth_state:LIKE(invalid_state):TYPE(STRING2):0,0
// FIELD:party2_age:LIKE(invalid_age):TYPE(STRING3):0,0
FIELD:party2_age:TYPE(STRING3):0,0
FIELD:party2_race:TYPE(STRING30):0,0
FIELD:party2_addr1:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:party2_csz:TYPE(STRING50):0,0
FIELD:party2_county:LIKE(invalid_county):TYPE(STRING35):0,0
FIELD:party2_previous_marital_status:TYPE(STRING20):0,0
FIELD:party2_how_marriage_ended:TYPE(STRING20):0,0
FIELD:party2_times_married:TYPE(STRING2):0,0
FIELD:party2_last_marriage_end_dt:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:number_of_children:TYPE(STRING2):0,0
FIELD:marriage_filing_dt:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:marriage_dt:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:marriage_city:LIKE(invalid_city):TYPE(STRING30):0,0
FIELD:marriage_county:LIKE(invalid_county):TYPE(STRING35):0,0
FIELD:place_of_marriage:TYPE(STRING10):0,0
FIELD:type_of_ceremony:TYPE(STRING10):0,0
FIELD:marriage_filing_number:LIKE(invalid_filing_number):TYPE(STRING25):0,0
FIELD:marriage_docket_volume:LIKE(invalid_docket_volume):TYPE(STRING30):0,0
FIELD:divorce_filing_dt:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:divorce_dt:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:divorce_docket_volume:LIKE(invalid_docket_volume):TYPE(STRING30):0,0
FIELD:divorce_filing_number:LIKE(invalid_filing_number):TYPE(STRING25):0,0
FIELD:divorce_city:LIKE(invalid_city):TYPE(STRING30):0,0
FIELD:divorce_county:LIKE(invalid_county):TYPE(STRING35):0,0
FIELD:grounds_for_divorce:TYPE(STRING50):0,0
FIELD:marriage_duration_cd:TYPE(STRING1):0,0
FIELD:marriage_duration:TYPE(STRING3):0,0
FIELD:persistent_record_id:TYPE(UNSIGNED8):0,0