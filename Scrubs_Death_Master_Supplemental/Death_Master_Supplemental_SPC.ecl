MODULE:Scrubs_Death_Master_Supplemental
FILENAME:Death_Master_Supplemental
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

SOURCEFIELD:source_state

FIELDTYPE:invalid_process_date:ALLOW(0123456789):LENGTHS(8)
FIELDTYPE:invalid_source_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2)
FIELDTYPE:invalid_certificate_vol_no:ALLOW(0123456789):LENGTHS(3,0)
FIELDTYPE:invalid_certificate_vol_year:ALLOW(0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_publication:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( )
FIELDTYPE:invalid_decedent_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃÃ“Ã¶Ã©'):SPACES( ,-.()):LENGTHS(1..)
FIELDTYPE:invalid_decedent_race:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ,-/.();')
FIELDTYPE:invalid_decedent_origin:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ,-.()/;'&)
FIELDTYPE:invalid_decedent_sex:ENUM(MALE|FEMALE|UNDETERMINED|UNKNOWN|)
FIELDTYPE:invalid_decedent_age:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( )
FIELDTYPE:invalid_education:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( ,;.-()+/')
FIELDTYPE:invalid_occupation:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ,-)
FIELDTYPE:invalid_where_worked:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( (),.-)
FIELDTYPE:invalid_cause:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ,;-())
FIELDTYPE:invalid_ssn:ALLOW(0123456789):LENGTHS(9,4,0)
FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( )
FIELDTYPE:invalid_birthplace:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©):SPACES( ,./-()')
FIELDTYPE:invalid_marital_status:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ()-/',)
FIELDTYPE:invalid_parent_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ“Ã¶Ã©):SPACES( (),-.')
FIELDTYPE:invalid_year:ALLOW(0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_county_residence:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ()'-.&)
FIELDTYPE:invalid_county_death:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ()'-.&)
FIELDTYPE:invalid_address:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘Ã0123456789):SPACES( ,-.()':;"&#/)
FIELDTYPE:invalid_autopsy:ENUM(NO|YES|UNK|UNKNOWN|)
FIELDTYPE:invalid_autopsy_findings:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( /)
FIELDTYPE:invalid_primary_cause_of_death:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( ):LENGTHS(0..4)
FIELDTYPE:invalid_underlying_cause_of_death:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( ;,)
FIELDTYPE:invalid_med_exam:ENUM(NO|YES|UNK|)
FIELDTYPE:invalid_est_lic_no:ALLOW(0123456789):LENGTHS(6,0)
FIELDTYPE:invalid_disposition:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ./-)
FIELDTYPE:invalid_work_injury:ENUM(NO|YES|UNKNOWN|UNK|REG CERT|)
FIELDTYPE:invalid_injury_date:ALLOW(0123456789NOIJURY):SPACES( ):LENGTHS(8)
FIELDTYPE:invalid_injury_type:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ./)
FIELDTYPE:invalid_injury_location:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( ,-./)
FIELDTYPE:invalid_surg_performed:ENUM(NO|YES|UNKNOWN|UNK|)
FIELDTYPE:invalid_hospital_status:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -,/().')
FIELDTYPE:invalid_pregnancy:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( -)
FIELDTYPE:invalid_facility_death:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( -,/().'&)
FIELDTYPE:invalid_embalmer_lic_no:ALLOW(0123456789):LENGTHS(6,0)
FIELDTYPE:invalid_death_type:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( )
FIELDTYPE:invalid_time_death:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( /)
FIELDTYPE:invalid_birth_cert:ALLOW(0123456789):SPACES( ,)
FIELDTYPE:invalid_certifier:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( .,)
FIELDTYPE:invalid_cert_number:ALLOW(0123456789):LENGTHS(7,6,5,0)
FIELDTYPE:invalid_local_file_no:ALLOW(0123456789):LENGTHS(5,0)
FIELDTYPE:invalid_vdi:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES(-,.)
FIELDTYPE:invalid_cite_id:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( )
FIELDTYPE:invalid_file_id:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(5,0)
FIELDTYPE:invalid_amendment_code:ALLOW(1A):LENGTHS(1,0)
FIELDTYPE:invalid_amendment_year:ALLOW(0123456789):LENGTHS(2,0)
FIELDTYPE:invalid__on_lexis:ALLOW(0123456789):SPACES(/):LENGTHS(10,0)
FIELDTYPE:invalid__fs_profile:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(9,0)
FIELDTYPE:invalid_us_armed_forces:ENUM(NO|YES|UNK|)
FIELDTYPE:invalid_place_of_death:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( -/\.,&()')
FIELDTYPE:invalid_state_death_id:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(16)
FIELDTYPE:invalid_state_death_flag:ENUM(Y|N):LENGTHS(1)
FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©):SPACES( -.()')
FIELDTYPE:invalid_name_score:ALLOW(0123456789)
FIELDTYPE:invalid_prim_range:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( ./\Â½-)
FIELDTYPE:invalid_predir:ALLOW(NSEW):LENGTHS(0..2)
FIELDTYPE:invalid_prim_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Ã‘):SPACES( -/\')
FIELDTYPE:invalid_addr_suffix:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_postdir:ALLOW(NSEW):LENGTHS(0..2)
FIELDTYPE:invalid_unit_desig:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -.'#)
FIELDTYPE:invalid_sec_range:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( -.'#/)
FIELDTYPE:invalid_p_city_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( -.')
FIELDTYPE:invalid_v_city_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( -.')
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
// This accounts for Canadian Zip Codes
FIELDTYPE:invalid_zip:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(5,0)
// Canadian Zip codes have a length of 6, so we throw that extra digit into ZIP4
FIELDTYPE:invalid_zip4:ALLOW(0123456789):LENGTHS(4,1,0)
FIELDTYPE:invalid_cart:ALLOW(RCHBG0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_cr_sort_sz:ALLOW(ABCD):LENGTHS(1,0)
FIELDTYPE:invalid_lot:ALLOW(0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_lot_order:ALLOW(AD):LENGTHS(1,0)
FIELDTYPE:invalid_dpbc:ALLOW(0123456789):LENGTHS(2,0)
FIELDTYPE:invalid_chk_digit:ALLOW(0123456789):LENGTHS(1,0)
FIELDTYPE:invalid_rec_type:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0..2)
FIELDTYPE:invalid_fipsstate:ALLOW(0123456789):LENGTHS(2,0)
FIELDTYPE:invalid_fipscounty:ALLOW(0123456789):LENGTHS(3,0)
FIELDTYPE:invalid_geo_lat:ALLOW(0123456789.):LENGTHS(9,0)
FIELDTYPE:invalid_geo_long:ALLOW(0123456789.-):LENGTHS(11,10,0)
FIELDTYPE:invalid_msa:ALLOW(0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_geo_blk:ALLOW(0123456789):LENGTHS(7,0)
FIELDTYPE:invalid_geo_match:ALLOW(0123456789):LENGTHS(1,0)
FIELDTYPE:invalid_err_stat:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_rawaid:ALLOW(0):LENGTHS(1)
FIELDTYPE:invalid_statefn:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_lf:LENGTHS(1,0)

FIELD:process_date:LIKE(invalid_process_date):TYPE(STRING8):0,0
FIELD:source_state:LIKE(invalid_source_state):TYPE(STRING2):0,0
FIELD:certificate_vol_no:LIKE(invalid_certificate_vol_no):TYPE(STRING3):0,0
FIELD:certificate_vol_year:LIKE(invalid_certificate_vol_year):TYPE(STRING4):0,0
FIELD:publication:LIKE(invalid_publication):TYPE(STRING28):0,0
FIELD:decedent_name:LIKE(invalid_decedent_name):TYPE(STRING44):0,0
FIELD:decedent_race:LIKE(invalid_decedent_race):TYPE(STRING93):0,0
FIELD:decedent_origin:LIKE(invalid_decedent_origin):TYPE(STRING69):0,0
FIELD:decedent_sex:LIKE(invalid_decedent_sex):TYPE(STRING12):0,0
FIELD:decedent_age:LIKE(invalid_decedent_age):TYPE(STRING34):0,0
FIELD:education:LIKE(invalid_education):TYPE(STRING26):0,0
FIELD:occupation:LIKE(invalid_occupation):TYPE(STRING74):0,0
FIELD:where_worked:LIKE(invalid_where_worked):TYPE(STRING62):0,0
FIELD:cause:LIKE(invalid_cause):TYPE(STRING289):0,0
FIELD:ssn:LIKE(invalid_ssn):TYPE(STRING9):0,0
FIELD:dob:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:dod:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:birthplace:LIKE(invalid_birthplace):TYPE(STRING35):0,0
FIELD:marital_status:LIKE(invalid_marital_status):TYPE(STRING38):0,0
FIELD:father:LIKE(invalid_parent_name):TYPE(STRING44):0,0
FIELD:mother:LIKE(invalid_parent_name):TYPE(STRING44):0,0
FIELD:filed_date:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:year:LIKE(invalid_year):TYPE(STRING4):0,0
FIELD:county_residence:LIKE(invalid_county_residence):TYPE(STRING77):0,0
FIELD:county_death:LIKE(invalid_county_death):TYPE(STRING23):0,0
FIELD:address:LIKE(invalid_address):TYPE(STRING76):0,0
FIELD:autopsy:LIKE(invalid_autopsy):TYPE(STRING7):0,0
FIELD:autopsy_findings:LIKE(invalid_autopsy_findings):TYPE(STRING44):0,0
FIELD:primary_cause_of_death:LIKE(invalid_primary_cause_of_death):TYPE(STRING4):0,0
FIELD:underlying_cause_of_death:LIKE(invalid_underlying_cause_of_death):TYPE(STRING50):0,0
FIELD:med_exam:LIKE(invalid_med_exam):TYPE(STRING3):0,0
FIELD:est_lic_no:LIKE(invalid_est_lic_no):TYPE(STRING6):0,0
FIELD:disposition:LIKE(invalid_disposition):TYPE(STRING22):0,0
FIELD:disposition_date:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:work_injury:LIKE(invalid_work_injury):TYPE(STRING9):0,0
FIELD:injury_date:LIKE(invalid_injury_date):TYPE(STRING8):0,0
FIELD:injury_type:LIKE(invalid_injury_type):TYPE(STRING23):0,0
FIELD:injury_location:LIKE(invalid_injury_location):TYPE(STRING50):0,0
FIELD:surg_performed:LIKE(invalid_surg_performed):TYPE(STRING7):0,0
FIELD:surgery_date:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:hospital_status:LIKE(invalid_hospital_status):TYPE(STRING120):0,0
FIELD:pregnancy:LIKE(invalid_pregnancy):TYPE(STRING14):0,0
FIELD:facility_death:LIKE(invalid_facility_death):TYPE(STRING70):0,0
FIELD:embalmer_lic_no:LIKE(invalid_embalmer_lic_no):TYPE(STRING6):0,0
FIELD:death_type:LIKE(invalid_death_type):TYPE(STRING21):0,0
FIELD:time_death:LIKE(invalid_time_death):TYPE(STRING5):0,0
FIELD:birth_cert:LIKE(invalid_birth_cert):TYPE(STRING12):0,0
FIELD:certifier:LIKE(invalid_certifier):TYPE(STRING31):0,0
FIELD:cert_number:LIKE(invalid_cert_number):TYPE(STRING20):0,0
FIELD:birth_vol_year:LIKE(invalid_year):TYPE(STRING4):0,0
FIELD:local_file_no:LIKE(invalid_local_file_no):TYPE(STRING5):0,0
FIELD:vdi:LIKE(invalid_vdi):TYPE(STRING39):0,0
FIELD:cite_id:LIKE(invalid_cite_id):TYPE(STRING28):0,0
FIELD:file_id:LIKE(invalid_file_id):TYPE(STRING5):0,0
FIELD:date_last_trans:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:amendment_code:LIKE(invalid_amendment_code):TYPE(STRING1):0,0
FIELD:amendment_year:LIKE(invalid_amendment_year):TYPE(STRING2):0,0
FIELD:_on_lexis:LIKE(invalid__on_lexis):TYPE(STRING10):0,0
FIELD:_fs_profile:LIKE(invalid__fs_profile):TYPE(STRING9):0,0
FIELD:us_armed_forces:LIKE(invalid_us_armed_forces):TYPE(STRING3):0,0
FIELD:place_of_death:LIKE(invalid_place_of_death):TYPE(STRING49):0,0
FIELD:state_death_id:LIKE(invalid_state_death_id):TYPE(STRING16):0,0
FIELD:state_death_flag:LIKE(invalid_state_death_flag):TYPE(STRING1):0,0
FIELD:title:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:fname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:mname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:lname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:name_suffix:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:name_score:LIKE(invalid_name_score):TYPE(STRING3):0,0
FIELD:prim_range:LIKE(invalid_prim_range):TYPE(STRING10):0,0
FIELD:predir:LIKE(invalid_predir):TYPE(STRING2):0,0
FIELD:prim_name:LIKE(invalid_prim_name):TYPE(STRING28):0,0
FIELD:addr_suffix:LIKE(invalid_addr_suffix):TYPE(STRING4):0,0
FIELD:postdir:LIKE(invalid_postdir):TYPE(STRING2):0,0
FIELD:unit_desig:LIKE(invalid_unit_desig):TYPE(STRING10):0,0
FIELD:sec_range:LIKE(invalid_sec_range):TYPE(STRING8):0,0
FIELD:p_city_name:LIKE(invalid_p_city_name):TYPE(STRING25):0,0
FIELD:v_city_name:LIKE(invalid_v_city_name):TYPE(STRING25):0,0
FIELD:state:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:zip5:LIKE(invalid_zip):TYPE(STRING5):0,0
FIELD:zip4:LIKE(invalid_zip4):TYPE(STRING4):0,0
FIELD:cart:LIKE(invalid_cart):TYPE(STRING4):0,0
FIELD:cr_sort_sz:LIKE(invalid_cr_sort_sz):TYPE(STRING1):0,0
FIELD:lot:LIKE(invalid_lot):TYPE(STRING4):0,0
FIELD:lot_order:LIKE(invalid_lot_order):TYPE(STRING1):0,0
FIELD:dpbc:LIKE(invalid_dpbc):TYPE(STRING2):0,0
FIELD:chk_digit:LIKE(invalid_chk_digit):TYPE(STRING1):0,0
FIELD:rec_type:LIKE(invalid_rec_type):TYPE(STRING2):0,0
FIELD:fips_state:LIKE(invalid_fipsstate):TYPE(STRING2):0,0
FIELD:fips_county:LIKE(invalid_fipscounty):TYPE(STRING3):0,0
FIELD:geo_lat:LIKE(invalid_geo_lat):TYPE(STRING10):0,0
FIELD:geo_long:LIKE(invalid_geo_long):TYPE(STRING11):0,0
FIELD:msa:LIKE(invalid_msa):TYPE(STRING4):0,0
FIELD:geo_blk:LIKE(invalid_geo_blk):TYPE(STRING7):0,0
FIELD:geo_match:LIKE(invalid_geo_match):TYPE(STRING1):0,0
FIELD:err_stat:LIKE(invalid_err_stat):TYPE(STRING4):0,0
FIELD:rawaid:LIKE(invalid_rawaid):TYPE(UNSIGNED8):0,0
FIELD:orig_address1:LIKE(invalid_address):TYPE(STRING76):0,0
FIELD:orig_address2:LIKE(invalid_address):TYPE(STRING76):0,0
FIELD:statefn:LIKE(invalid_statefn):TYPE(STRING16):0,0
FIELD:lf:LIKE(invalid_lf):TYPE(STRING1):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking


// RECORDTYPE:Name:[TAG(field,value)]:[NOTAG]:[FAIL]:CONDITION(field,operator,field)*:VALID(fieldlist)
// â€¢	If a TAG is present then the recordtype only applies to records for which field=value.
// â€¢	If NOTAG is present then only records that have NOT been measured using a TAGed recordtype are processed.
// â€¢	Condition is of the form CONDITION(field1,>=,field2) - field1 and 2 have to be present in the spc file. 
// â€¢	Valid(fieldlist) specifies that every field in the list of fields has to be valid
RECORDTYPE:invalid_dob_dates:CONDITION(dob,<,process_date):VALID(dob,process_date)
RECORDTYPE:invalid_dod_dates:CONDITION(dod,<,process_date):VALID(dod,process_date)
RECORDTYPE:invalid_age_dates:TAG(dob,'00000000'):TAG(dob,''):TAG(dod,'00000000'):TAG(dod,''):NOTAG:CONDITION(dob,<,dod):VALID(dob,dod)
