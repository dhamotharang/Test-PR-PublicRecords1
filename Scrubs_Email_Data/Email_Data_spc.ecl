﻿MODULE:Scrubs_Email_Data
FILENAME:Email_Data
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

SOURCEFIELD:email_src

FIELDTYPE:invalid_alpha:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓӔҪØËÈÉâãáåäïöøéüᴁҫ):SPACES( -'/.):LENGTHS(0..)
FIELDTYPE:invalid_alnum:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -/):LENGTHS(0..)
FIELDTYPE:invalid_name:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓӔҪØËÈÉâãáåäïöøéüᴁҫ0123456789'):SPACES( -`,&\/.:;_+):LENGTHS(0..)
FIELDTYPE:invalid_numeric:ALLOW(0123456789):SPACES( -):LENGTHS(0..)
FIELDTYPE:invalid_address:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZÂÃÁÅÄÑÚÜÍÏÎÔÖÓøØËÈÉäïöéüӔ0123456789'):SPACES( -&/\#.;,):LENGTHS(0..)
FIELDTYPE:invalid_dir:ENUM(N|NW|NE|S|SE|SW|E|W| )
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_zip:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -):LENGTHS(5,0)
FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( ):LENGTHS(8,6,4,1,0)
FIELDTYPE:invalid_dob:ALLOW(0123456789):SPACES( ):LENGTHS(8,4,1,0)
FIELDTYPE:invalid_ssn:ALLOW(0123456789):LENGTHS(9,0)
FIELDTYPE:invalid_activecode:ENUM(A|I| ):LENGTHS(1,0)
FIELDTYPE:invalid_source:ENUM(T$|TM|SC|IB|M1|IM|!I|DG|W@|AW|AO|ET|AN|RS)
FIELDTYPE:invalid_email:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -@&._!?/):LENGTHS(1..)
FIELDTYPE:invalid_blank:LENGTHS(1..)

FIELD:clean_email:TYPE(STRING200):0,0
FIELD:append_email_username:TYPE(STRING100):0,0
FIELD:append_domain:TYPE(STRING120):0,0
FIELD:append_domain_type:TYPE(STRING12):0,0
FIELD:append_domain_root:TYPE(STRING100):0,0
FIELD:append_domain_ext:TYPE(STRING20):0,0
FIELD:append_is_tld_state:TYPE(BOOLEAN1):0,0
FIELD:append_is_tld_generic:TYPE(BOOLEAN1):0,0
FIELD:append_is_tld_country:TYPE(BOOLEAN1):0,0
FIELD:append_is_valid_domain_ext:TYPE(BOOLEAN1):0,0
FIELD:email_rec_key:LIKE(invalid_numeric):TYPE(UNSIGNED8):0,0
FIELD:email_src:LIKE(invalid_source):TYPE(STRING2):0,0
FIELD:rec_src_all:TYPE(UNSIGNED8):0,0
FIELD:email_src_all:TYPE(UNSIGNED8):0,0
FIELD:email_src_num:TYPE(UNSIGNED8):0,0
FIELD:num_email_per_did:TYPE(UNSIGNED8):0,0
FIELD:num_did_per_email:TYPE(UNSIGNED8):0,0
FIELD:orig_pmghousehold_id:TYPE(STRING):0,0
FIELD:orig_pmgindividual_id:TYPE(STRING):0,0
FIELD:orig_first_name:TYPE(STRING):0,0
FIELD:orig_last_name:TYPE(STRING):0,0
FIELD:orig_address:TYPE(STRING):0,0
FIELD:orig_city:TYPE(STRING):0,0
FIELD:orig_state:TYPE(STRING):0,0
FIELD:orig_zip:TYPE(STRING):0,0
FIELD:orig_zip4:TYPE(STRING):0,0
FIELD:orig_email:TYPE(STRING):0,0
FIELD:orig_ip:TYPE(STRING):0,0
FIELD:orig_login_date:LIKE(invalid_date):TYPE(STRING):0,0
FIELD:orig_site:TYPE(STRING):0,0
FIELD:orig_e360_id:TYPE(STRING):0,0
FIELD:orig_teramedia_id:TYPE(STRING):0,0
FIELD:did:TYPE(UNSIGNED6):0,0
FIELD:did_score:TYPE(UNSIGNED8):0,0
FIELD:did_type:TYPE(STRING10):0,0
FIELD:is_did_prop:TYPE(BOOLEAN1):0,0
FIELD:hhid:TYPE(UNSIGNED8):0,0
FIELD:title:LIKE(invalid_alpha):TYPE(STRING5):0,0
FIELD:fname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:mname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:lname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:name_suffix:LIKE(invalid_alnum):TYPE(STRING5):0,0
FIELD:name_score:TYPE(STRING3):0,0
FIELD:prim_range:TYPE(STRING10):0,0
FIELD:predir:LIKE(invalid_dir):TYPE(STRING2):0,0
FIELD:prim_name:LIKE(invalid_address):TYPE(STRING28):0,0
FIELD:addr_suffix:TYPE(STRING4):0,0
FIELD:postdir:LIKE(invalid_dir):TYPE(STRING2):0,0
FIELD:unit_desig:TYPE(STRING10):0,0
FIELD:sec_range:TYPE(STRING8):0,0
FIELD:p_city_name:LIKE(invalid_alpha):TYPE(STRING25):0,0
FIELD:v_city_name:LIKE(invalid_alpha):TYPE(STRING25):0,0
FIELD:st:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:zip:LIKE(invalid_zip):TYPE(STRING5):0,0
FIELD:zip4:LIKE(invalid_numeric):TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dbpc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:county:TYPE(STRING5):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0
FIELD:append_rawaid:TYPE(UNSIGNED8):0,0
FIELD:best_ssn:LIKE(invalid_ssn):TYPE(STRING9):0,0
FIELD:best_dob:LIKE(invalid_dob):TYPE(UNSIGNED4):0,0
FIELD:process_date:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:activecode:LIKE(invalid_activecode):TYPE(STRING1):0,0
FIELD:date_first_seen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_last_seen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_vendor_first_reported:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_vendor_last_reported:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:current_rec:TYPE(BOOLEAN1):0,0

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
