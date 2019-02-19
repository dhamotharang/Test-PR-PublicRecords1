﻿MODULE:Scrubs_OKC_Student_List_V2
FILENAME:OKC_Student_List
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
SOURCEFIELD:cleancollegeid
FIELDTYPE:nums:ALLOW(0123456789)
FIELDTYPE:lowercase:ALLOW(abcdefghijklmnopqrstuvwxyz)
FIELDTYPE:uppercase:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:alphas:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)
FIELDTYPE:lowercaseandnums:ALLOW(abcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:uppercaseandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:alphasandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:allupper:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé)
// FIELDTYPE:allupperandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöé0123456789)
// FIELDTYPE:allalphaandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÅÉÑÕÚÜÍáãñóöéabcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:blank:LENGTHS(0)
FIELDTYPE:invalid_blank:LIKE(blank)
// FIELDTYPE:invalid_alpha:SPACES( ):ALLOW( &(),-/.'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)
FIELDTYPE:invalid_date:LIKE(nums):SPACES( ):LENGTHS(0,8)
FIELDTYPE:invalid_AttendanceDate:ALLOW( /;0123456789SPRINGUMEFALTW)
FIELDTYPE:invalid_phone:LIKE(nums):SPACES(()-+):LENGTHS(0,9..15)
FIELDTYPE:invalid_phonetyp:ENUM(HOME|CELL|OTHER|)
FIELDTYPE:invalid_name:LIKE(allupper):SPACES( -,&\/.:;`'()_+):LENGTHS(0..)
FIELDTYPE:invalid_suffix:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_address:LIKE(uppercaseandnums):SPACES( ,-.()':;"&#/)
FIELDTYPE:invalid_college:LIKE(alphasandnums):SPACES( -&/./())
FIELDTYPE:invalid_city:LIKE(uppercase):SPACES( .'-,)
FIELDTYPE:invalid_state:LIKE(uppercase):LENGTHS(0,2)
FIELDTYPE:invalid_semester:ENUM(SPRING|SUMMER|FALL|AUTUMN|WINTER|):LENGTHS(0,4,6)
// FIELDTYPE:invalid_csz:SPACES( ):ALLOW( ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_email:LIKE(alphasandnums):SPACES(.@-_)
FIELDTYPE:invalid_addresstype:ENUM(CURRENT|Permanent|DORM|HOME|)
FIELD:cleanaddr1:TYPE(STRING100):LIKE(invalid_address):0,0
FIELD:cleanaddr2:TYPE(STRING100):LIKE(invalid_address):0,0
FIELD:cleanattendancedte:0,0
FIELD:cleancity:TYPE(STRING8):LIKE(invalid_city):0,0
FIELD:cleanstate:TYPE(STRING8):LIKE(invalid_state):0,0
FIELD:cleandob:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:cleanupdatedte:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:cleanemail:TYPE(STRING80):LIKE(invalid_email):0,0
FIELD:append_email_username:0,0
FIELD:append_domain:0,0
FIELD:append_domain_type:0,0
FIELD:append_domain_root:0,0
FIELD:append_domain_ext:0,0
FIELD:append_is_tld_state:0,0
FIELD:append_is_tld_generic:0,0
FIELD:append_is_tld_country:0,0
FIELD:append_is_valid_domain_ext:0,0
FIELD:cleancollegeId:TYPE(STRING10):0,0
FIELD:cleantitle:TYPE(STRING5):0,0
FIELD:cleanfirstname:TYPE(STRING50):LIKE(invalid_name):0,0
FIELD:cleanmidname:TYPE(STRING50):LIKE(invalid_name):0,0
FIELD:cleanlastname:TYPE(STRING50):LIKE(invalid_name):0,0
FIELD:cleansuffixname:TYPE(STRING10):LIKE(invalid_name):0,0
FIELD:cleanzip:TYPE(STRING5):0,0
FIELD:cleanzip4:TYPE(STRING4):0,0
FIELD:cleanmajor:0,0
FIELD:cleanphone:TYPE(STRING10):LIKE(invalid_phone):0,0
FIELD:rcid:0,0
FIELD:did:TYPE(UNSIGNED6):0,0
FIELD:process_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:date_first_seen:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:date_last_seen:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:vendor_first_reported:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:vendor_last_reported:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:dateupdated:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:studentid:TYPE(STRING):LIKE(nums):0,0
FIELD:dartid:TYPE(STRING4):LIKE(nums):0,0
FIELD:collegeid:TYPE(STRING10):0,0
FIELD:projectsource:TYPE(STRING):0,0
FIELD:collegestate:0,0
FIELD:college:TYPE(STRING100):LIKE(invalid_college):0,0
FIELD:semester:TYPE(STRING6):LIKE(invalid_semester):0,0
FIELD:year:TYPE(STRING4):LIKE(nums):0,0
FIELD:firstname:0,0
FIELD:middlename:0,0
FIELD:lastname:0,0
FIELD:suffix:0,0
FIELD:major:0,0
FIELD:COLLEGE_MAJOR:LIKE():0,0
FIELD:NEW_COLLEGE_MAJOR:LIKE():0,0
FIELD:grade:0,0
FIELD:email:0,0
FIELD:dateofbirth:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:dob_formatted:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:attendancedate:0,0
FIELD:enrollmentstatus:0,0
FIELD:addresstype:TYPE(STRING5):LIKE(invalid_addressType):0,0
FIELD:address1:0,0
FIELD:address2:0,0
FIELD:city:0,0
FIELD:state:0,0
FIELD:zip:0,0
FIELD:zip4:0,0
FIELD:phonetyp:TYPE(STRING10):LIKE(invalid_phonetyp):0,0
FIELD:phonenumber:0,0
FIELD:tier:TYPE(STRING1):0,0
FIELD:school_size_code:TYPE(STRING1):0,0
FIELD:competitive_code:TYPE(STRING1):0,0
FIELD:tuition_code:TYPE(STRING1):0,0
FIELD:title:TYPE(STRING5):0,0
FIELD:fname:TYPE(STRING20):0,0
FIELD:mname:TYPE(STRING20):0,0
FIELD:lname:TYPE(STRING20):0,0
FIELD:name_suffix:TYPE(STRING5):LIKE(invalid_suffix):0,0
FIELD:name_score:TYPE(STRING3):0,0
FIELD:prim_range:TYPE(STRING10):LIKE(invalid_address):0,0
FIELD:predir:TYPE(STRING2):LIKE(invalid_address):0,0
FIELD:prim_name:TYPE(STRING28):LIKE(invalid_address):0,0
FIELD:addr_suffix:TYPE(STRING4):LIKE(invalid_address):0,0
FIELD:postdir:TYPE(STRING2):LIKE(invalid_address):0,0
FIELD:unit_desig:TYPE(STRING10):LIKE(invalid_address):0,0
FIELD:sec_range:TYPE(STRING8):LIKE(invalid_address):0,0
FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_city):0,0
FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_city):0,0
FIELD:st:TYPE(STRING2):0,0
FIELD:z5:TYPE(STRING5):0,0
FIELD:z4:TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dbpc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:county:TYPE(STRING5):0,0
FIELD:fips_state:TYPE(STRING2):0,0
FIELD:fips_county:TYPE(STRING3):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0
FIELD:telephone:TYPE(STRING10):LIKE(invalid_phone):0,0
FIELD:tier2:TYPE(STRING5):0,0
FIELD:source:TYPE(STRING2):0,0