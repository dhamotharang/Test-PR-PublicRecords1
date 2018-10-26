﻿Generated by SALT V3.8.2
Command line options: -gh 
File being processed :-
MODULE:Scrubs_OKC_Probate
 FILENAME:OKC_Probate_Profile
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>

//FIELDTYPE DEFINITIONS
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
FIELDTYPE:invalid_alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( -):LENGTHS(0..)
FIELDTYPE:invalid_Num:ALLOW(0123456789):LENGTHS(0..)
FIELDTYPE:invalid_date:LIKE(nums):SPACES( -/):LENGTHS(0,8,9,10)
FIELDTYPE:invalid_name:LIKE(allupperandnums):SPACES( -,./'):LENGTHS(0..)
FIELDTYPE:invalid_company:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -,&\/.:#;()"):LENGTHS(0..)
FIELDTYPE:invalid_address:CAPS:LIKE(allupperandnums):SPACES( -&/\#%.;,'):LENGTHS(0..)
FIELDTYPE:invalid_city:LIKE(uppercase):SPACES( -,&\/.:#;()"):LENGTHS(0..)
FIELDTYPE:invalid_state:LIKE(uppercase):LENGTHS(0,2)
FIELDTYPE:invalid_zip:LIKE(nums):SPACES( -):LENGTHS(0..)
FIELDTYPE:invalid_phone:LIKE(nums):SPACES( ()-+):LENGTHS(0..15)
FIELDTYPE:invalid_casenumber:LIKE(alphasandnums):SPACES( +.-):LENGTHS(0..)

FIELDTYPE:predir:SPACES( ):ALLOW(ENSW):LENGTHS(0,1,2)
FIELDTYPE:prim_name:LIKE(uppercaseandnums):SPACES( /-):LENGTHS(0..)
FIELDTYPE:addr_suffix:LIKE(uppercase):SPACES( ):LENGTHS(2,3,0,4)
FIELDTYPE:postdir:SPACES( ):ALLOW(ENSW):ONFAIL(CLEAN)
FIELDTYPE:unit_desig:LIKE(uppercase):SPACES( #):ONFAIL(CLEAN)
FIELDTYPE:sec_range:LIKE(uppercaseandnums):SPACES( -):LENGTHS(0..)
FIELDTYPE:p_city_name:LIKE(uppercase):SPACES( ):LENGTHS(0..)
FIELDTYPE:v_city_name:LIKE(uppercase):SPACES( ):LENGTHS(0..)
FIELDTYPE:st:LIKE(uppercase):SPACES( -):LENGTHS(0,2)
FIELDTYPE:zip:LIKE(invalid_Num):SPACES( ):LENGTHS(5,0)
FIELDTYPE:zip4:LIKE(invalid_Num):SPACES( ):LENGTHS(4,0)
FIELDTYPE:cart:SPACES( ):ALLOW(0123456789BCHR):LENGTHS(4,0)
FIELDTYPE:cr_sort_sz:SPACES( ):ALLOW(BCD):LENGTHS(0,1)
FIELDTYPE:lot:LIKE(invalid_Num):SPACES( ):LENGTHS(4,0)
FIELDTYPE:lot_order:SPACES( ):ALLOW(AD):LENGTHS(1,0)
FIELDTYPE:dbpc:LIKE(invalid_Num):SPACES( ):LENGTHS(2,0)
FIELDTYPE:chk_digit:LIKE(invalid_Num):SPACES( ):LENGTHS(0,1)
FIELDTYPE:rec_type:SPACES( ):ALLOW(DFHMPRS):LENGTHS(0,1,2)
FIELDTYPE:fips_county:LIKE(invalid_Num):SPACES( ):LENGTHS(3,0)
FIELDTYPE:geo_lat:LIKE(invalid_Num):SPACES( .):LENGTHS(9,0)
FIELDTYPE:geo_long:LIKE(invalid_Num):SPACES( -.):LENGTHS(10,11,0)
FIELDTYPE:msa:LIKE(invalid_Num):SPACES( ):LENGTHS(4,0)
FIELDTYPE:geo_blk:LIKE(invalid_Num):SPACES( ):LENGTHS(7,0)
FIELDTYPE:geo_match:SPACES( ):ALLOW(0145):LENGTHS(1)
FIELDTYPE:err_stat:SPACES( ):ALLOW(0123456789ABCDEFS):LENGTHS(4)
FIELDTYPE:rawaid:LIKE(invalid_Num):SPACES( ):LENGTHS(1,13)

FIELD:name_score:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:filedate:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:dod:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:dob:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:masterid:LIKE(alphasandnums):TYPE(STRING):0,0
FIELD:debtorfirstname:LIKE(invalid_name):TYPE(STRING):0,0
FIELD:debtorlastname:LIKE(invalid_name):TYPE(STRING):0,0
FIELD:debtoraddress1:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:debtoraddress2:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:debtoraddresscity:LIKE(invalid_city):TYPE(STRING):0,0
FIELD:debtoraddressstate:LIKE(invalid_state):TYPE(STRING):0,0
FIELD:debtoraddresszipcode:LIKE(invalid_zip):TYPE(STRING):0,0
FIELD:dateofdeath:LIKE(invalid_date):TYPE(STRING):0,0
FIELD:dateofbirth:LIKE(invalid_date):TYPE(STRING):0,0
FIELD:isprobatelocated:TYPE(STRING):0,0
FIELD:casenumber:LIKE(invalid_casenumber):TYPE(STRING):0,0
FIELD:filingdate:LIKE(invalid_date):TYPE(STRING):0,0
FIELD:lastdatetofileclaim:LIKE(invalid_date):TYPE(STRING):0,0
FIELD:issubjecttocreditorsclaim:TYPE(STRING):0,0
FIELD:publicationstartdate:LIKE(invalid_date):TYPE(STRING):0,0
FIELD:isestateopen:TYPE(STRING):0,0
FIELD:executorfirstname:LIKE(invalid_name):TYPE(STRING):0,0
FIELD:executorlastname:LIKE(invalid_name):TYPE(STRING):0,0
FIELD:executoraddress1:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:executoraddress2:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:executoraddresscity:LIKE(invalid_city):TYPE(STRING):0,0
FIELD:executoraddressstate:LIKE(invalid_state):TYPE(STRING):0,0
FIELD:executoraddresszipcode:LIKE(invalid_zip):TYPE(STRING):0,0
FIELD:executorphone:LIKE(invalid_phone):TYPE(STRING):0,0
FIELD:attorneyfirstname:LIKE(invalid_name):TYPE(STRING):0,0
FIELD:attorneylastname:LIKE(invalid_name):TYPE(STRING):0,0
FIELD:firm:TYPE(STRING):0,0
FIELD:attorneyaddress1:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:attorneyaddress2:LIKE(invalid_address):TYPE(STRING):0,0
FIELD:attorneyaddresscity:LIKE(invalid_city):TYPE(STRING):0,0
FIELD:attorneyaddressstate:LIKE(invalid_state):TYPE(STRING):0,0
FIELD:attorneyaddresszipcode:LIKE(invalid_zip):TYPE(STRING):0,0
FIELD:attorneyphone:LIKE(invalid_phone):TYPE(STRING):0,0
FIELD:attorneyemail:TYPE(STRING):0,0
FIELD:documenttypes:TYPE(STRING):0,0
FIELD:corr_dateofdeath:TYPE(STRING):0,0
FIELD:pdid:TYPE(STRING20):0,0
FIELD:pfrd_address_ind:TYPE(STRING20):0,0
FIELD:nid:TYPE(UNSIGNED8):0,0
FIELD:cln_title:TYPE(STRING25):0,0
FIELD:cln_fname:LIKE(invalid_name):TYPE(STRING30):0,00,0
FIELD:cln_mname:LIKE(invalid_name):TYPE(STRING30):0,00,0
FIELD:cln_lname:LIKE(invalid_name):TYPE(STRING30):0,00,0
FIELD:cln_suffix:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:cln_title2:TYPE(STRING25):0,0
FIELD:cln_fname2:LIKE(invalid_name):TYPE(STRING30):0,00,0
FIELD:cln_mname2:LIKE(invalid_name):TYPE(STRING30):0,00,0
FIELD:cln_lname2:LIKE(invalid_name):TYPE(STRING30):0,00,0
FIELD:cln_suffix2:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:persistent_record_id:TYPE(UNSIGNED8):0,0
FIELD:cname:LIKE(invalid_company):TYPE(STRING100):0,0
FIELD:cleanaid:TYPE(Unsigned8):0,0
FIELD:addresstype:TYPE(STRING5):0,0
FIELD:prim_range:TYPE(STRING10):0,0
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
FIELD:geo_lat:LIKE(geo_lat):TYPE(STRING10):0,0
FIELD:geo_long:LIKE(geo_long):TYPE(STRING11):0,0
FIELD:msa:LIKE(msa):TYPE(STRING4):0,0
FIELD:geo_blk:LIKE(geo_blk):TYPE(STRING7):0,0
FIELD:geo_match:LIKE(geo_match):TYPE(STRING1):0,0
FIELD:err_stat:LIKE(err_stat):TYPE(STRING4):0,0
FIELD:rawaid:LIKE(rawaid):TYPE(UNSIGNED8):0,0

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


