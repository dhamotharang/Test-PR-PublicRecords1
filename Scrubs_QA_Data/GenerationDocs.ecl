﻿Generated by SALT V3.4.3
Command line options: -MScrubs_QA_Data -eC:\Users\mireleaa\AppData\Local\Temp\TFR8981.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_QA_Data
FILENAME:QA_Data
NAMESCOPE:Base 
 
//--------------------------
//FIELDTYPE DEFINITIONS
//--------------------------
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_QA_Data.Functions.fn_past_yyyymmdd > 0)
FIELDTYPE:invalid_date_time:CUSTOM(Scrubs_QA_Data.Functions.fn_date_time > 0)
FIELDTYPE:invalid_record_type:ENUM(C|H)
FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_QA_Data.Functions.fn_numeric > 0)
FIELDTYPE:invalid_numeric_or_blank:CUSTOM(Scrubs_QA_Data.Functions.fn_numeric_or_blank > 0)
FIELDTYPE:invalid_db_match:ENUM(I|B|L| )
FIELDTYPE:invalid_home_business:ENUM(Y|N| )
FIELDTYPE:invalid_st:CUSTOM(Scrubs_QA_Data.Functions.fn_verify_state>0)
FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_QA_Data.Functions.fn_numeric>0,5)
FIELDTYPE:invalid_person_type:ENUM(AC|AP|TC|TP| )
FIELDTYPE:invalid_alphanum_specials:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº)
FIELDTYPE:invalid_phone:CUSTOM(Scrubs_QA_Data.Functions.fn_verify_optional_phone>0)
FIELDTYPE:invalid_nametype:ENUM(B| )
FIELDTYPE:invalid_src_rid:CUSTOM(Scrubs_QA_Data.Functions.fn_src_rid > 0)
 
//--------------------------------------------------------------- 
//FIELDS TO SCRUB -- Commented out fields are not being scrubbed
//---------------------------------------------------------------
// FIELD:dotid:TYPE(UNSIGNED6):0,0
// FIELD:dotscore:TYPE(UNSIGNED2):0,0
// FIELD:dotweight:TYPE(UNSIGNED2):0,0
// FIELD:empid:TYPE(UNSIGNED6):0,0
// FIELD:empscore:TYPE(UNSIGNED2):0,0
// FIELD:empweight:TYPE(UNSIGNED2):0,0
FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:powscore:TYPE(UNSIGNED2):0,0
// FIELD:powweight:TYPE(UNSIGNED2):0,0
FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:proxscore:TYPE(UNSIGNED2):0,0
// FIELD:proxweight:TYPE(UNSIGNED2):0,0
FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:selescore:TYPE(UNSIGNED2):0,0
// FIELD:seleweight:TYPE(UNSIGNED2):0,0
FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:orgscore:TYPE(UNSIGNED2):0,0
// FIELD:orgweight:TYPE(UNSIGNED2):0,0
FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:ultscore:TYPE(UNSIGNED2):0,0
// FIELD:ultweight:TYPE(UNSIGNED2):0,0
FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:did_score:TYPE(UNSIGNED1):0,0
FIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0
FIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0
FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0
FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0
FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0
FIELD:rawtrans_masteraddressid:TYPE(STRING):LIKE(invalid_numeric_or_blank):0,0
FIELD:rawtrans_date:TYPE(STRING):LIKE(invalid_date_time):0,0
FIELD:rawtrans_category:TYPE(STRING):LIKE(invalid_mandatory):0,0
// FIELD:rawtrans_subcategory:TYPE(STRING):0,0
// FIELD:rawtrans_name:TYPE(STRING):0,0
// FIELD:rawtrans_company:TYPE(STRING):0,0
// FIELD:rawtrans_addressone:TYPE(STRING):0,0
// FIELD:rawtrans_addresstwo:TYPE(STRING):0,0
// FIELD:rawtrans_city:TYPE(STRING):0,0
// FIELD:rawtrans_state:TYPE(STRING):0,0
// FIELD:rawtrans_postalcode:TYPE(STRING):0,0
// FIELD:rawaddr_firstname:TYPE(STRING):0,0
// FIELD:rawaddr_middleinitial:TYPE(STRING):0,0
// FIELD:rawaddr_lastname:TYPE(STRING):0,0
// FIELD:rawaddr_company:TYPE(STRING):0,0
// FIELD:rawaddr_other:TYPE(STRING):0,0
// FIELD:rawaddr_phone:TYPE(STRING):0,0
FIELD:rawaddr_databasematchcode:TYPE(STRING):LIKE(invalid_db_match):0,0
FIELD:rawaddr_homebusinessflag:TYPE(STRING):LIKE(invalid_home_business):0,0
// FIELD:rawaddr_addressone:TYPE(STRING):0,0
// FIELD:rawaddr_addresstwo:TYPE(STRING):0,0
// FIELD:rawaddr_streetnumber:TYPE(STRING):0,0
// FIELD:rawaddr_predirection:TYPE(STRING):0,0
// FIELD:rawaddr_streetname:TYPE(STRING):0,0
// FIELD:rawaddr_streettype:TYPE(STRING):0,0
// FIELD:rawaddr_postdirection:TYPE(STRING):0,0
// FIELD:rawaddr_extension:TYPE(STRING):0,0
// FIELD:rawaddr_extensionnumber:TYPE(STRING):0,0
// FIELD:rawaddr_village:TYPE(STRING):0,0
// FIELD:rawaddr_city:TYPE(STRING):0,0
// FIELD:rawaddr_state:TYPE(STRING):0,0
// FIELD:rawaddr_zipplus4:TYPE(STRING):0,0
// FIELD:rawaddr_zipcode:TYPE(STRING):0,0
// FIELD:rawaddr_zipaddon:TYPE(STRING):0,0
// FIELD:rawaddr_carrierroute:TYPE(STRING):0,0
// FIELD:rawaddr_pmb:TYPE(STRING):0,0
// FIELD:rawaddr_pmbdesignator:TYPE(STRING):0,0
// FIELD:rawaddr_deliverypoint:TYPE(STRING):0,0
// FIELD:rawaddr_deliverypointcheckdigit:TYPE(STRING):0,0
// FIELD:rawaddr_cmra:TYPE(STRING):0,0
// FIELD:rawaddr_dpv:TYPE(STRING):0,0
// FIELD:rawaddr_dpvfootnote:TYPE(STRING):0,0
// FIELD:rawaddr_congressdistrict:TYPE(STRING):0,0
// FIELD:rawaddr_county:TYPE(STRING):0,0
// FIELD:rawaddr_countynumber:TYPE(STRING):0,0
// FIELD:rawaddr_statenumber:TYPE(STRING):0,0
// FIELD:rawaddr_latitude:TYPE(STRING):0,0
// FIELD:rawaddr_longitude:TYPE(STRING):0,0
// FIELD:rawaddr_censustract:TYPE(STRING):0,0
// FIELD:rawaddr_blocknumber:TYPE(STRING):0,0
// FIELD:rawaddr_blockgroup:TYPE(STRING):0,0
FIELD:rawaddr_masteraddressid:TYPE(STRING):LIKE(invalid_numeric):0,0
// FIELD:trans_rawaid:TYPE(UNSIGNED8):0,0
// FIELD:trans_aceaid:TYPE(UNSIGNED8):0,0
// FIELD:addr_rawaid:TYPE(UNSIGNED8):0,0
// FIELD:addr_aceaid:TYPE(UNSIGNED8):0,0
FIELD:prep_trans_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0
FIELD:prep_trans_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0
FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0
FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0
// FIELD:trans_address_prim_range:TYPE(STRING10):0,0
// FIELD:trans_address_predir:TYPE(STRING2):0,0
FIELD:trans_address_prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0
// FIELD:trans_address_addr_suffix:TYPE(STRING4):0,0
// FIELD:trans_address_postdir:TYPE(STRING2):0,0
// FIELD:trans_address_unit_desig:TYPE(STRING10):0,0
// FIELD:trans_address_sec_range:TYPE(STRING8):0,0
FIELD:trans_address_p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0
FIELD:trans_address_v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0
FIELD:trans_address_st:TYPE(STRING2):LIKE(invalid_st):0,0
FIELD:trans_address_zip:TYPE(STRING5):LIKE(invalid_zip5):0,0
// FIELD:trans_address_zip4:TYPE(STRING4):0,0
// FIELD:trans_address_cart:TYPE(STRING4):0,0
// FIELD:trans_address_cr_sort_sz:TYPE(STRING1):0,0
// FIELD:trans_address_lot:TYPE(STRING4):0,0
// FIELD:trans_address_lot_order:TYPE(STRING1):0,0
// FIELD:trans_address_dbpc:TYPE(STRING2):0,0
// FIELD:trans_address_chk_digit:TYPE(STRING1):0,0
// FIELD:trans_address_rec_type:TYPE(STRING2):0,0
// FIELD:trans_address_fips_state:TYPE(STRING2):0,0
// FIELD:trans_address_fips_county:TYPE(STRING3):0,0
// FIELD:trans_address_geo_lat:TYPE(STRING10):0,0
// FIELD:trans_address_geo_long:TYPE(STRING11):0,0
// FIELD:trans_address_msa:TYPE(STRING4):0,0
// FIELD:trans_address_geo_blk:TYPE(STRING7):0,0
// FIELD:trans_address_geo_match:TYPE(STRING1):0,0
// FIELD:trans_address_err_stat:TYPE(STRING4):0,0
// FIELD:trans_address_fips_state_county:TYPE(STRING5):0,0
// FIELD:addr_address_prim_range:TYPE(STRING10):0,0
// FIELD:addr_address_predir:TYPE(STRING2):0,0
FIELD:addr_address_prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0
// FIELD:addr_address_addr_suffix:TYPE(STRING4):0,0
// FIELD:addr_address_postdir:TYPE(STRING2):0,0
// FIELD:addr_address_unit_desig:TYPE(STRING10):0,0
// FIELD:addr_address_sec_range:TYPE(STRING8):0,0
FIELD:addr_address_p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0
FIELD:addr_address_v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0
FIELD:addr_address_st:TYPE(STRING2):LIKE(invalid_st):0,0
FIELD:addr_address_zip:TYPE(STRING5):LIKE(invalid_zip5):0,0
// FIELD:addr_address_zip4:TYPE(STRING4):0,0
// FIELD:addr_address_cart:TYPE(STRING4):0,0
// FIELD:addr_address_cr_sort_sz:TYPE(STRING1):0,0
// FIELD:addr_address_lot:TYPE(STRING4):0,0
// FIELD:addr_address_lot_order:TYPE(STRING1):0,0
// FIELD:addr_address_dbpc:TYPE(STRING2):0,0
// FIELD:addr_address_chk_digit:TYPE(STRING1):0,0
// FIELD:addr_address_rec_type:TYPE(STRING2):0,0
// FIELD:addr_address_fips_state:TYPE(STRING2):0,0
// FIELD:addr_address_fips_county:TYPE(STRING3):0,0
// FIELD:addr_address_geo_lat:TYPE(STRING10):0,0
// FIELD:addr_address_geo_long:TYPE(STRING11):0,0
// FIELD:addr_address_msa:TYPE(STRING4):0,0
// FIELD:addr_address_geo_blk:TYPE(STRING7):0,0
// FIELD:addr_address_geo_match:TYPE(STRING1):0,0
// FIELD:addr_address_err_stat:TYPE(STRING4):0,0
// FIELD:addr_address_fips_state_county:TYPE(STRING5):0,0
FIELD:clean_person_type:TYPE(STRING2):LIKE(invalid_person_type):0,0
// FIELD:clean_person_name_title:TYPE(STRING5):0,0
FIELD:clean_person_name_fname:TYPE(STRING20):LIKE(invalid_alphanum_specials):0,0
// FIELD:clean_person_name_mname:TYPE(STRING20):0,0
FIELD:clean_person_name_lname:TYPE(STRING20):LIKE(invalid_alphanum_specials):0,0
// FIELD:clean_person_name_name_suffix:TYPE(STRING5):0,0
// FIELD:clean_person_name_name_score:TYPE(STRING3):0,0
FIELD:clean_phone:TYPE(STRING10):LIKE(invalid_phone):0,0
FIELD:clean_company:TYPE(STRING80):LIKE(invalid_mandatory):0,0
FIELD:nametype:TYPE(STRING1):LIKE(invalid_nametype):0,0
FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_src_rid):0,0
 
 
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
 
