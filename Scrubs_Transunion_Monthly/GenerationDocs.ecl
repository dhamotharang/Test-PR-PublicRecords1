Generated by SALT V3.2.0RC1
Command line options: -MScrubs_Transunion_Monthly -eC:\Users\marcga01\AppData\Local\Temp\TFR5637.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Transunion_Monthly
FILENAME:File
 
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
 
FIELDTYPE:record_type:SPACES( ):ALLOW(0123):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:first_name:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(5,6,7,4,8,9,3,1,10,11,2,12):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:middle_name:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWYZ):LEFTTRIM:LENGTHS(1,0,5,4,6,3,7,8,2,9,10):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:last_name:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(6,7,5,8,4,9,10,3,11,12,13,2,14,15,16,17):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:name_prefix:SPACES( ):ALLOW(DLMNRSV):LEFTTRIM:LENGTHS(0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:name_suffix_:SPACES( ):ALLOW( DIJRSV):LENGTHS(0,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:perm_id:SPACES( ):ALLOW(0123456789ABCDEF):LEFTTRIM:LENGTHS(12):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:ssn:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(9,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:aka1:SPACES( ):ALLOW(,ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(0,15,16,14,17,13,18,19,12,20,11,21,22,10,23,24,9,25,8,26,7,27,29):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:aka2:SPACES( ):ALLOW(,ABCDEFGHIJKLMNOPQRSTUVWYZ):LEFTTRIM:LENGTHS(0,15,14,16,13,17,18,12,19,20,11,21,22,10,23,9,24,25,8,26,7,29):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:aka3:SPACES( ):ALLOW(,ABCDEFGHIJKLMNOPQRSTUVWYZ):LEFTTRIM:LENGTHS(0,15,14,16,17,13,18,12,19,20,11,21,22,10,23,24,9,25,8,26):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:new_subject_flag:SPACES( ):ALLOW(NY):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:name_change_flag:SPACES( ):ALLOW(NY):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:address_change_flag:SPACES( ):ALLOW(NY):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:ssn_change_flag:SPACES( ):ALLOW(NY):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:file_since_date_change_flag:SPACES( ):ALLOW(NY):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:deceased_indicator_flag:SPACES( ):ALLOW(NY):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dob_change_flag:SPACES( ):ALLOW(NY):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:phone_change_flag:SPACES( ):ALLOW(NY):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:filler2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:gender:SPACES( ):ALLOW(FIMU):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:mfdu_indicator:SPACES( ):ALLOW(MSU):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:file_since_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:house_number:SPACES( ):ALLOW( 0123456789):LENGTHS(10,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:street_direction:SPACES( ):ALLOW(ENSW):LEFTTRIM:LENGTHS(0,1,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:street_name:SPACES( ):ALLOW( 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(6,7,8,4,5,9,10,11,12,3,13,14,15,16,17,1,18,2,19,20,21,27,22,23):WORDS(1,2,3,4,5):ONFAIL(CLEAN)
FIELDTYPE:street_type:SPACES( ):ALLOW(ABCDEHIKLNOPQRSTVWYZ):LEFTTRIM:LENGTHS(2,0,3,4):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:street_post_direction:SPACES( ):ALLOW(ENSW):LEFTTRIM:LENGTHS(0,2,1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:unit_type:SPACES( ):ALLOW( #ABCEFILNOPRSTUX):LENGTHS(0,3,1,4):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:unit_number:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWY):LEFTTRIM:LENGTHS(0,1,3,2,4,5):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:cty:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXY):LEFTTRIM:LENGTHS(7,8,9,6,10,11,12,5,13,14,4,15,16,17,3,18,19,20):WORDS(1,2,3):ONFAIL(CLEAN)
FIELDTYPE:state:SPACES( ):ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:zip_code:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(5):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:zp4:SPACES( ):ALLOW(0123456789):LENGTHS(4,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:address_standardization_indicator:SPACES( ):ALLOW(NY):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:date_address_reported:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:party_id:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(15):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:deceased_indicator:SPACES( ):ALLOW(Y):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:date_of_birth:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:date_of_birth_estimated_ind:SPACES( ):ALLOW(E):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:phone:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,10):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:filler3:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:prepped_name:SPACES( ):ALLOW( ,ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(15,16,14,17,13,18,12,19,20,11,21,10,22,23,9,24,25,8,26,7,27,28,29,6):WORDS(2,1,3,4):ONFAIL(CLEAN)
FIELDTYPE:prepped_addr1:SPACES( ):ALLOW( #0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(15,16,14,17,13,18,19,12,20,11,21,10,22,23,24,25,9,26,27,28,8,29,30,31,4,32,7,6,33,34,5):WORDS(3,4,5,6,2,7,8):ONFAIL(CLEAN)
FIELDTYPE:prepped_addr2:SPACES( ):ALLOW( ,0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(17,18,19,16,20,21,22,15,23,24,14,25,26,27,13,28,29,30):WORDS(3,4,5):ONFAIL(CLEAN)
FIELDTYPE:prepped_rec_type:SPACES( ):ALLOW(123ABCD):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:isupdating:SPACES( ):ALLOW(1):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:iscurrent:SPACES( ):ALLOW(1):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:did:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(10,9,12,11,0,8,7):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:did_score:SPACES( ):ALLOW(0145789):LEFTTRIM:LENGTHS(3,0,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dt_first_seen:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dt_last_seen:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,8):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dt_vendor_last_reported:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dt_vendor_first_reported:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:clean_phone:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(0,10):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:clean_ssn:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(9,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:clean_dob:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(8,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:title:SPACES( ):ALLOW(MRS):LEFTTRIM:LENGTHS(2,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:fname:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(5,6,7,4,8,1,9,3,10,11,0,2,12):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:mname:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWYZ):LEFTTRIM:LENGTHS(1,0,5,4,6,3,7,8,9,2,10):WORDS(1,2):ONFAIL(CLEAN)
FIELDTYPE:lname:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:LENGTHS(6,7,5,8,4,9,10,3,11,12,13,14,15,16,2,17,18,20):WORDS(1,2):ONFAIL(CLEAN)
FIELDTYPE:name_suffix:SPACES( ):ALLOW( ACDEIJLNRSTVXY):LEFTTRIM:LENGTHS(0,2,3,1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:name_score:SPACES( ):ALLOW(012789):LEFTTRIM:LENGTHS(2,0,3):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:prim_range:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(4,3,5,2,0,1,6):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:predir:SPACES( ):ALLOW(ENSW):LEFTTRIM:LENGTHS(0,1,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:prim_name:SPACES( ):ALLOW( 0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(7,6,8,4,5,9,10,11,12,3,13,14,15,16,17,1,18,19,20,2,21,22,27,23,24):WORDS(1,2,3,4,5):ONFAIL(CLEAN)
FIELDTYPE:addr_suffix:SPACES( ):ALLOW(ABCDEGHIKLNOPQRSTUVWXY):LEFTTRIM:LENGTHS(2,3,0,4):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:postdir:SPACES( ):ALLOW(ENSW):LEFTTRIM:LENGTHS(0,1,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:unit_desig:SPACES( ):ALLOW(#ABCEFILMNOPRSTUX):LEFTTRIM:LENGTHS(0,3,1,4):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:sec_range:SPACES( ):ALLOW( -0123456789ABCDEFGHIJKLMNOPRSTUVWY):LEFTTRIM:LENGTHS(0,1,3,2,4,5):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:p_city_name:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXY):LEFTTRIM:LENGTHS(7,8,9,6,10,11,12,5,13,4,14,15,16,3,17,18,19,20):WORDS(1,2,3):ONFAIL(CLEAN)
FIELDTYPE:v_city_name:SPACES( ):ALLOW( ABCDEFGHIJKLMNOPQRSTUVWXY):LEFTTRIM:LENGTHS(7,8,9,6,10,11,12,5,13,14,4,15,16,17,3,18,19,20,22):WORDS(1,2,3):ONFAIL(CLEAN)
FIELDTYPE:st:SPACES( ):ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:zip:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(5):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:zip4:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(4,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:cart:SPACES( ):ALLOW(0123456789BCHR):LEFTTRIM:LENGTHS(4,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:cr_sort_sz:SPACES( ):ALLOW(BCD):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:lot:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(4,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:lot_order:SPACES( ):ALLOW(AD):LEFTTRIM:LENGTHS(1,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:dbpc:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(2,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:chk_digit:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:rec_type:SPACES( ):ALLOW(DFHMPRS):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:fips_county:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:county:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(3,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:geo_lat:SPACES( ):ALLOW(.0123456789):LEFTTRIM:LENGTHS(9,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:geo_long:SPACES( ):ALLOW(-.0123456789):LEFTTRIM:LENGTHS(10,11,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:msa:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(4,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:geo_blk:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(7,0):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:geo_match:SPACES( ):ALLOW(0145):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:err_stat:SPACES( ):ALLOW(0123456789ABCES):LEFTTRIM:LENGTHS(4):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:rawaid:SPACES( ):ALLOW(0123456789):LEFTTRIM:LENGTHS(13):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:isdelete:SPACES( ):ALLOW(1):LEFTTRIM:LENGTHS(0,1):WORDS(1):ONFAIL(CLEAN)
 
FIELD:record_type:LIKE(record_type):TYPE(STRING2):0,0
FIELD:first_name:LIKE(first_name):TYPE(STRING20):0,0
FIELD:middle_name:LIKE(middle_name):TYPE(STRING20):0,0
FIELD:last_name:LIKE(last_name):TYPE(STRING32):0,0
FIELD:name_prefix:LIKE(name_prefix):TYPE(STRING3):0,0
FIELD:name_suffix_:LIKE(name_suffix_):TYPE(STRING3):0,0
FIELD:perm_id:LIKE(perm_id):TYPE(STRING12):0,0
FIELD:ssn:LIKE(ssn):TYPE(STRING9):0,0
FIELD:aka1:LIKE(aka1):TYPE(STRING32):0,0
FIELD:aka2:LIKE(aka2):TYPE(STRING32):0,0
FIELD:aka3:LIKE(aka3):TYPE(STRING32):0,0
FIELD:new_subject_flag:LIKE(new_subject_flag):TYPE(STRING1):0,0
FIELD:name_change_flag:LIKE(name_change_flag):TYPE(STRING1):0,0
FIELD:address_change_flag:LIKE(address_change_flag):TYPE(STRING1):0,0
FIELD:ssn_change_flag:LIKE(ssn_change_flag):TYPE(STRING1):0,0
FIELD:file_since_date_change_flag:LIKE(file_since_date_change_flag):TYPE(STRING1):0,0
FIELD:deceased_indicator_flag:LIKE(deceased_indicator_flag):TYPE(STRING1):0,0
FIELD:dob_change_flag:LIKE(dob_change_flag):TYPE(STRING1):0,0
FIELD:phone_change_flag:LIKE(phone_change_flag):TYPE(STRING1):0,0
FIELD:filler2:LIKE(filler2):TYPE(STRING27):0,0
FIELD:gender:LIKE(gender):TYPE(STRING1):0,0
FIELD:mfdu_indicator:LIKE(mfdu_indicator):TYPE(STRING1):0,0
FIELD:file_since_date:LIKE(file_since_date):TYPE(STRING8):0,0
FIELD:house_number:LIKE(house_number):TYPE(STRING10):0,0
FIELD:street_direction:LIKE(street_direction):TYPE(STRING2):0,0
FIELD:street_name:LIKE(street_name):TYPE(STRING28):0,0
FIELD:street_type:LIKE(street_type):TYPE(STRING4):0,0
FIELD:street_post_direction:LIKE(street_post_direction):TYPE(STRING2):0,0
FIELD:unit_type:LIKE(unit_type):TYPE(STRING4):0,0
FIELD:unit_number:LIKE(unit_number):TYPE(STRING10):0,0
FIELD:cty:LIKE(cty):TYPE(STRING28):0,0
FIELD:state:LIKE(state):TYPE(STRING2):0,0
FIELD:zip_code:LIKE(zip_code):TYPE(STRING5):0,0
FIELD:zp4:LIKE(zp4):TYPE(STRING4):0,0
FIELD:address_standardization_indicator:LIKE(address_standardization_indicator):TYPE(STRING1):0,0
FIELD:date_address_reported:LIKE(date_address_reported):TYPE(STRING8):0,0
FIELD:party_id:LIKE(party_id):TYPE(STRING15):0,0
FIELD:deceased_indicator:LIKE(deceased_indicator):TYPE(STRING1):0,0
FIELD:date_of_birth:LIKE(date_of_birth):TYPE(STRING8):0,0
FIELD:date_of_birth_estimated_ind:LIKE(date_of_birth_estimated_ind):TYPE(STRING1):0,0
FIELD:phone:LIKE(phone):TYPE(STRING10):0,0
FIELD:filler3:LIKE(filler3):TYPE(STRING15):0,0
FIELD:prepped_name:LIKE(prepped_name):TYPE(STRING75):0,0
FIELD:prepped_addr1:LIKE(prepped_addr1):TYPE(STRING60):0,0
FIELD:prepped_addr2:LIKE(prepped_addr2):TYPE(STRING35):0,0
FIELD:prepped_rec_type:LIKE(prepped_rec_type):TYPE(STRING2):0,0
FIELD:isupdating:LIKE(isupdating):TYPE(BOOLEAN1):0,0
FIELD:iscurrent:LIKE(iscurrent):TYPE(BOOLEAN1):0,0
FIELD:did:LIKE(did):TYPE(UNSIGNED6):0,0
FIELD:did_score:LIKE(did_score):TYPE(UNSIGNED8):0,0
FIELD:dt_first_seen:LIKE(dt_first_seen):TYPE(UNSIGNED4):0,0
FIELD:dt_last_seen:LIKE(dt_last_seen):TYPE(UNSIGNED4):0,0
FIELD:dt_vendor_last_reported:LIKE(dt_vendor_last_reported):TYPE(UNSIGNED4):0,0
FIELD:dt_vendor_first_reported:LIKE(dt_vendor_first_reported):TYPE(UNSIGNED4):0,0
FIELD:clean_phone:LIKE(clean_phone):TYPE(STRING10):0,0
FIELD:clean_ssn:LIKE(clean_ssn):TYPE(STRING9):0,0
FIELD:clean_dob:LIKE(clean_dob):TYPE(INTEGER4):0,0
FIELD:title:LIKE(title):TYPE(STRING5):0,0
FIELD:fname:LIKE(fname):TYPE(STRING20):0,0
FIELD:mname:LIKE(mname):TYPE(STRING20):0,0
FIELD:lname:LIKE(lname):TYPE(STRING20):0,0
FIELD:name_suffix:LIKE(name_suffix):TYPE(STRING5):0,0
FIELD:name_score:LIKE(name_score):TYPE(STRING3):0,0
FIELD:prim_range:LIKE(prim_range):TYPE(STRING10):0,0
FIELD:predir:LIKE(predir):TYPE(STRING2):0,0
FIELD:prim_name:LIKE(prim_name):TYPE(STRING28):0,0
FIELD:addr_suffix:LIKE(addr_suffix):TYPE(STRING4):0,0
FIELD:postdir:LIKE(postdir):TYPE(STRING2):0,0
FIELD:unit_desig:LIKE(unit_desig):TYPE(STRING10):0,0
FIELD:sec_range:LIKE(sec_range):TYPE(STRING8):0,0
FIELD:p_city_name:LIKE(p_city_name):TYPE(STRING25):0,0
FIELD:v_city_name:LIKE(v_city_name):TYPE(STRING25):0,0
FIELD:st:LIKE(st):TYPE(STRING2):0,0
FIELD:zip:LIKE(zip):TYPE(STRING5):0,0
FIELD:zip4:LIKE(zip4):TYPE(STRING4):0,0
FIELD:cart:LIKE(cart):TYPE(STRING4):0,0
FIELD:cr_sort_sz:LIKE(cr_sort_sz):TYPE(STRING1):0,0
FIELD:lot:LIKE(lot):TYPE(STRING4):0,0
FIELD:lot_order:LIKE(lot_order):TYPE(STRING1):0,0
FIELD:dbpc:LIKE(dbpc):TYPE(STRING2):0,0
FIELD:chk_digit:LIKE(chk_digit):TYPE(STRING1):0,0
FIELD:rec_type:LIKE(rec_type):TYPE(STRING2):0,0
FIELD:fips_county:LIKE(fips_county):TYPE(STRING2):0,0
FIELD:county:LIKE(county):TYPE(STRING3):0,0
FIELD:geo_lat:LIKE(geo_lat):TYPE(STRING10):0,0
FIELD:geo_long:LIKE(geo_long):TYPE(STRING11):0,0
FIELD:msa:LIKE(msa):TYPE(STRING4):0,0
FIELD:geo_blk:LIKE(geo_blk):TYPE(STRING7):0,0
FIELD:geo_match:LIKE(geo_match):TYPE(STRING1):0,0
FIELD:err_stat:LIKE(err_stat):TYPE(STRING4):0,0
FIELD:rawaid:LIKE(rawaid):TYPE(UNSIGNED8):0,0
FIELD:isdelete:LIKE(isdelete):TYPE(BOOLEAN1):0,0
 
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
 
Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3
 
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
 
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
 
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
 
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
 
