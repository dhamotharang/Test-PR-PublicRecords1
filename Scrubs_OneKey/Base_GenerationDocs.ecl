﻿Generated by SALT V3.11.11
Command line options: -MScrubs_OneKey -eC:\Users\wolfkg\AppData\Local\Temp\TFR8B41.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_OneKey
FILENAME:OneKey
NAMESCOPE:Base
// Uncomment up to NINES for internal or external adl
// IDFIELD:EXISTS:<NameOfIDField>
// RIDFIELD:<NameOfRidField>
// RECORDS:<NumberOfRecordsInDataFile>
// POPULATION:<ExpectedNumberOfEntitiesInDataFile>
// NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
// Uncomment Process if doing external adl
// PROCESS:<ProcessName>
// FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
// BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
// FUZZY can be used to create new types of FUZZY linking
// Remember to generate specificities and update the 0,0 placeholders below before running any sort of linking.
// If the actual specificity for a field is <1, round it up to 1 rather than down to 0.  If your cluster is running
// a shared repository, calling SALTTOOLS30.mac_Patch_SPC from the bottom of BWR_Specificities may be a convenience.
 
//FIELDTYPE DEFINITIONS
FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_OneKey.Functions.fn_numeric>0)
FIELDTYPE:invalid_numeric_nonzero:CUSTOM(Scrubs_OneKey.Functions.fn_numeric_nonzero>0)
FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_OneKey.Functions.fn_past_yyyymmdd>0)
FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0)
 
FIELDTYPE:invalid_source:ENUM(SK|09)
FIELDTYPE:invalid_record_type:ENUM(C|H)
FIELDTYPE:invalid_frst_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0,mid_nm,last_nm)
FIELDTYPE:invalid_mid_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0,frst_nm,last_nm)
FIELDTYPE:invalid_last_nm:CUSTOM(Scrubs_OneKey.Functions.fn_populated_strings>0,frst_nm,mid_nm)
FIELDTYPE:invalid_prim_prfsn_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_prfsn_desc)
FIELDTYPE:invalid_prim_prfsn_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_prfsn_cd)
FIELDTYPE:invalid_prim_spcl_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_spcl_desc)
FIELDTYPE:invalid_prim_spcl_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,prim_spcl_cd)
FIELDTYPE:invalid_sec_spcl_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,sec_spcl_desc)
FIELDTYPE:invalid_sec_spcl_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,sec_spcl_cd)
FIELDTYPE:invalid_tert_spcl_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,tert_spcl_desc)
FIELDTYPE:invalid_tert_spcl_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,tert_spcl_cd)
FIELDTYPE:invalid_sub_spcl_cd:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,sub_spcl_desc)
FIELDTYPE:invalid_sub_spcl_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,sub_spcl_cd)
FIELDTYPE:invalid_titl_typ_id:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,titl_typ_desc)
FIELDTYPE:invalid_titl_typ_desc:CUSTOM(Scrubs_OneKey.Functions.fn_str1_xor_str2>0,titl_typ_id)
FIELDTYPE:invalid_ok_wkp_id:CUSTOM(Scrubs_OneKey.Functions.fn_onekey_id>0)
 
//FIELD DEFINITIONS
FIELD:source:TYPE(STRING2):LIKE(invalid_source):0,0
FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:bdid_score:TYPE(UNSIGNED1):0,0
FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_numeric_nonzero):0,0
FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0
FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate8):0,0
FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0
FIELD:hcp_hce_id:TYPE(STRING15):LIKE(invalid_numeric_nonzero):0,0
FIELD:ok_indv_id:TYPE(STRING32):0,0
FIELD:ska_uid:TYPE(STRING15):0,0
FIELD:frst_nm:TYPE(STRING40):LIKE(invalid_frst_nm):0,0
FIELD:mid_nm:TYPE(STRING40):LIKE(invalid_mid_nm):0,0
FIELD:last_nm:TYPE(STRING40):LIKE(invalid_last_nm):0,0
FIELD:sfx_cd:TYPE(STRING10):0,0
FIELD:gender_cd:TYPE(STRING10):0,0
FIELD:prim_prfsn_cd:TYPE(STRING10):LIKE(invalid_prim_prfsn_cd):0,0
FIELD:prim_prfsn_desc:TYPE(STRING50):LIKE(invalid_prim_prfsn_desc):0,0
FIELD:prim_spcl_cd:TYPE(STRING10):LIKE(invalid_prim_spcl_cd):0,0
FIELD:prim_spcl_desc:TYPE(STRING75):LIKE(invalid_prim_spcl_desc):0,0
FIELD:sec_spcl_cd:TYPE(STRING10):LIKE(invalid_sec_spcl_cd):0,0
FIELD:sec_spcl_desc:TYPE(STRING75):LIKE(invalid_sec_spcl_desc):0,0
FIELD:tert_spcl_cd:TYPE(STRING10):LIKE(invalid_tert_spcl_cd):0,0
FIELD:tert_spcl_desc:TYPE(STRING75):LIKE(invalid_tert_spcl_desc):0,0
FIELD:sub_spcl_cd:TYPE(STRING10):LIKE(invalid_sub_spcl_cd):0,0
FIELD:sub_spcl_desc:TYPE(STRING50):LIKE(invalid_sub_spcl_desc):0,0
FIELD:titl_typ_id:TYPE(STRING10):LIKE(invalid_titl_typ_id):0,0
FIELD:titl_typ_desc:TYPE(STRING50):LIKE(invalid_titl_typ_desc):0,0
FIELD:hco_hce_id:TYPE(STRING15):LIKE(invalid_numeric_nonzero):0,0
FIELD:ok_wkp_id:TYPE(STRING35):LIKE(invalid_ok_wkp_id):0,0
FIELD:ska_id:TYPE(STRING15):LIKE(invalid_numeric_nonzero):0,0
FIELD:bus_nm:TYPE(STRING150):LIKE(invalid_mandatory):0,0
FIELD:dba_nm:TYPE(STRING150):0,0
FIELD:addr_id:TYPE(STRING10):0,0
FIELD:str_front_id:TYPE(STRING10):0,0
FIELD:addr_ln_1_txt:TYPE(STRING80):0,0
FIELD:addr_ln_2_txt:TYPE(STRING80):0,0
FIELD:city_nm:TYPE(STRING50):0,0
FIELD:st_cd:TYPE(STRING2):0,0
FIELD:zip5_cd:TYPE(STRING5):0,0
FIELD:zip4_cd:TYPE(STRING4):0,0
FIELD:fips_cnty_cd:TYPE(STRING10):0,0
FIELD:fips_cnty_desc:TYPE(STRING50):0,0
FIELD:telephn_nbr:TYPE(STRING15):0,0
FIELD:cot_id:TYPE(STRING15):0,0
FIELD:cot_clas_id:TYPE(STRING15):0,0
FIELD:cot_clas_desc:TYPE(STRING50):0,0
FIELD:cot_fclt_typ_id:TYPE(STRING15):0,0
FIELD:cot_fclt_typ_desc:TYPE(STRING50):0,0
FIELD:cot_spcl_id:TYPE(STRING15):0,0
FIELD:cot_spcl_desc:TYPE(STRING50):0,0
FIELD:email_ind_flag:TYPE(STRING1):0,0
FIELD:ims_id:TYPE(STRING7):0,0
FIELD:hce_prfsnl_stat_cd:TYPE(STRING10):0,0
FIELD:hce_prfsnl_stat_desc:TYPE(STRING50):0,0
FIELD:excld_rsn_desc:TYPE(STRING150):0,0
FIELD:npi:TYPE(STRING25):0,0
FIELD:deactv_dt:TYPE(STRING10):0,0
FIELD:cleaned_deactv_dt:TYPE(STRING10):0,0
FIELD:xref_hce_id:TYPE(STRING15):0,0
FIELD:title:TYPE(STRING5):0,0
FIELD:fname:TYPE(STRING20):0,0
FIELD:mname:TYPE(STRING20):0,0
FIELD:lname:TYPE(STRING20):0,0
FIELD:name_suffix:TYPE(STRING5):0,0
FIELD:name_score:TYPE(STRING3):0,0
FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0
FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0
FIELD:prim_range:TYPE(STRING10):0,0
FIELD:predir:TYPE(STRING2):0,0
FIELD:prim_name:TYPE(STRING28):0,0
FIELD:addr_suffix:TYPE(STRING4):0,0
FIELD:postdir:TYPE(STRING2):0,0
FIELD:unit_desig:TYPE(STRING10):0,0
FIELD:sec_range:TYPE(STRING8):0,0
FIELD:p_city_name:TYPE(STRING25):0,0
FIELD:v_city_name:TYPE(STRING25):0,0
FIELD:st:TYPE(STRING2):0,0
FIELD:zip:TYPE(STRING5):0,0
FIELD:zip4:TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0
FIELD:cr_sort_sz:TYPE(STRING1):0,0
FIELD:lot:TYPE(STRING4):0,0
FIELD:lot_order:TYPE(STRING1):0,0
FIELD:dbpc:TYPE(STRING2):0,0
FIELD:chk_digit:TYPE(STRING1):0,0
FIELD:rec_type:TYPE(STRING2):0,0
FIELD:fips_state:TYPE(STRING2):0,0
FIELD:fips_county:TYPE(STRING3):0,0
FIELD:geo_lat:TYPE(STRING10):0,0
FIELD:geo_long:TYPE(STRING11):0,0
FIELD:msa:TYPE(STRING4):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:geo_match:TYPE(STRING1):0,0
FIELD:err_stat:TYPE(STRING4):0,0
FIELD:raw_aid:TYPE(UNSIGNED8):0,0
FIELD:ace_aid:TYPE(UNSIGNED8):0,0
FIELD:dotid:TYPE(UNSIGNED6):0,0
FIELD:dotscore:TYPE(UNSIGNED2):0,0
FIELD:dotweight:TYPE(UNSIGNED2):0,0
FIELD:empid:TYPE(UNSIGNED6):0,0
FIELD:empscore:TYPE(UNSIGNED2):0,0
FIELD:empweight:TYPE(UNSIGNED2):0,0
FIELD:powid:TYPE(UNSIGNED6):0,0
FIELD:powscore:TYPE(UNSIGNED2):0,0
FIELD:powweight:TYPE(UNSIGNED2):0,0
FIELD:proxid:TYPE(UNSIGNED6):0,0
FIELD:proxscore:TYPE(UNSIGNED2):0,0
FIELD:proxweight:TYPE(UNSIGNED2):0,0
FIELD:seleid:TYPE(UNSIGNED6):0,0
FIELD:selescore:TYPE(UNSIGNED2):0,0
FIELD:seleweight:TYPE(UNSIGNED2):0,0
FIELD:orgid:TYPE(UNSIGNED6):0,0
FIELD:orgscore:TYPE(UNSIGNED2):0,0
FIELD:orgweight:TYPE(UNSIGNED2):0,0
FIELD:ultid:TYPE(UNSIGNED6):0,0
FIELD:ultscore:TYPE(UNSIGNED2):0,0
FIELD:ultweight:TYPE(UNSIGNED2):0,0
// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking
 
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
 
