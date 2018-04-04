﻿Generated by SALT V3.8.0
Command line options: -MScrubs_UCCV2 -eC:\Users\wolfkg\AppData\Local\Temp\TFRA084.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_UCCV2
FILENAME:UCCV2
NAMESCOPE:IL_Party
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
FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0)
FIELDTYPE:invalid_empty:LENGTHS(0)
FIELDTYPE:invalid_zero_integer:ENUM(0|)
FIELDTYPE:invalid_boolean_yn:ENUM(N|Y)
FIELDTYPE:invalid_pastdate8:CUSTOM(Scrubs_UCCV2.Functions.fn_past_yyyymmdd>0)
FIELDTYPE:invalid_pastdate6:CUSTOM(Scrubs_UCCV2.Functions.fn_past_yyyymm>0)
 
FIELDTYPE:invalid_tmsid:CUSTOM(Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid>0,'IL')
FIELDTYPE:invalid_rmsid:CUSTOM(Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid>0,'IL')
FIELDTYPE:invalid_orig_name:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,orig_lname,orig_fname)
FIELDTYPE:invalid_orig_lname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,orig_name,orig_fname)
FIELDTYPE:invalid_orig_fname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,orig_name,orig_lname)
FIELDTYPE:invalid_orig_address1:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,orig_city,orig_state)
FIELDTYPE:invalid_orig_state:CUSTOM(Scrubs_UCCV2.Functions.fn_verify_state>0)
FIELDTYPE:invalid_orig_zip5:CUSTOM(Scrubs_UCCV2.Functions.fn_verify_zip5>0)
FIELDTYPE:invalid_party_type:ENUM(D|S)
FIELDTYPE:invalid_fname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,mname,lname,company_name)
FIELDTYPE:invalid_mname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,fname,lname,company_name)
FIELDTYPE:invalid_lname:CUSTOM(Scrubs_UCCV2.Functions.fn_populated_strings>0,fname,mname,company_name)
FIELDTYPE:invalid_company_name:CUSTOM(Scrubs_UCCV2.Functions.fn_company_xor_person>0,fname,mname,lname)
 
//FIELD DEFINITIONS
FIELD:tmsid:TYPE(STRING31):LIKE(invalid_tmsid):0,0
FIELD:rmsid:TYPE(STRING23):LIKE(invalid_rmsid):0,0
FIELD:orig_name:TYPE(STRING120):LIKE(invalid_orig_name):0,0
FIELD:orig_lname:TYPE(STRING25):LIKE(invalid_orig_lname):0,0
FIELD:orig_fname:TYPE(STRING25):LIKE(invalid_orig_fname):0,0
FIELD:orig_mname:TYPE(STRING35):0,0
FIELD:orig_suffix:TYPE(STRING10):0,0
FIELD:duns_number:TYPE(STRING9):LIKE(invalid_empty):0,0
FIELD:hq_duns_number:TYPE(STRING9):LIKE(invalid_empty):0,0
FIELD:ssn:TYPE(STRING9):LIKE(invalid_empty):0,0
FIELD:fein:TYPE(STRING10):LIKE(invalid_empty):0,0
FIELD:incorp_state:TYPE(STRING45):LIKE(invalid_empty):0,0
FIELD:corp_number:TYPE(STRING30):LIKE(invalid_empty):0,0
FIELD:corp_type:TYPE(STRING30):LIKE(invalid_empty):0,0
FIELD:orig_address1:TYPE(STRING60):LIKE(invalid_mandatory):0,0
FIELD:orig_address2:TYPE(STRING60):0,0
FIELD:orig_city:TYPE(STRING30):LIKE(invalid_mandatory):0,0
FIELD:orig_state:TYPE(STRING2):LIKE(invalid_orig_state):0,0
FIELD:orig_zip5:TYPE(STRING5):LIKE(invalid_orig_zip5):0,0
FIELD:orig_zip4:TYPE(STRING4):0,0
FIELD:orig_country:TYPE(STRING30):0,0
FIELD:orig_province:TYPE(STRING30):0,0
FIELD:orig_postal_code:TYPE(STRING9):0,0
FIELD:foreign_indc:TYPE(STRING1):LIKE(invalid_boolean_yn):0,0
FIELD:party_type:TYPE(STRING1):LIKE(invalid_party_type):0,0
FIELD:dt_first_seen:TYPE(UNSIGNED6):LIKE(invalid_pastdate6):0,0
FIELD:dt_last_seen:TYPE(UNSIGNED6):LIKE(invalid_pastdate6):0,0
FIELD:dt_vendor_last_reported:TYPE(UNSIGNED6):LIKE(invalid_pastdate6):0,0
FIELD:dt_vendor_first_reported:TYPE(UNSIGNED6):LIKE(invalid_pastdate6):0,0
FIELD:process_date:TYPE(STRING8):LIKE(invalid_pastdate8):0,0
FIELD:title:TYPE(STRING5):0,0
FIELD:fname:TYPE(STRING20):LIKE(invalid_fname):0,0
FIELD:mname:TYPE(STRING20):LIKE(invalid_mname):0,0
FIELD:lname:TYPE(STRING20):LIKE(invalid_lname):0,0
FIELD:name_suffix:TYPE(STRING5):0,0
FIELD:name_score:TYPE(STRING3):0,0
FIELD:company_name:TYPE(STRING60):LIKE(invalid_company_name):0,0
FIELD:prim_range:TYPE(STRING10):LIKE(invalid_empty):0,0
FIELD:predir:TYPE(STRING2):LIKE(invalid_empty):0,0
FIELD:prim_name:TYPE(STRING28):LIKE(invalid_empty):0,0
FIELD:suffix:TYPE(STRING4):LIKE(invalid_empty):0,0
FIELD:postdir:TYPE(STRING2):LIKE(invalid_empty):0,0
FIELD:unit_desig:TYPE(STRING10):LIKE(invalid_empty):0,0
FIELD:sec_range:TYPE(STRING8):LIKE(invalid_empty):0,0
FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_empty):0,0
FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_empty):0,0
FIELD:st:TYPE(STRING2):LIKE(invalid_empty):0,0
FIELD:zip5:TYPE(STRING5):LIKE(invalid_empty):0,0
FIELD:zip4:TYPE(STRING4):LIKE(invalid_empty):0,0
FIELD:county:TYPE(STRING3):LIKE(invalid_empty):0,0
FIELD:cart:TYPE(STRING4):LIKE(invalid_empty):0,0
FIELD:cr_sort_sz:TYPE(STRING1):LIKE(invalid_empty):0,0
FIELD:lot:TYPE(STRING4):LIKE(invalid_empty):0,0
FIELD:lot_order:TYPE(STRING1):LIKE(invalid_empty):0,0
FIELD:dpbc:TYPE(STRING2):LIKE(invalid_empty):0,0
FIELD:chk_digit:TYPE(STRING1):LIKE(invalid_empty):0,0
FIELD:rec_type:TYPE(STRING2):LIKE(invalid_empty):0,0
FIELD:ace_fips_st:TYPE(STRING2):LIKE(invalid_empty):0,0
FIELD:ace_fips_county:TYPE(STRING3):LIKE(invalid_empty):0,0
FIELD:geo_lat:TYPE(STRING10):LIKE(invalid_empty):0,0
FIELD:geo_long:TYPE(STRING11):LIKE(invalid_empty):0,0
FIELD:msa:TYPE(STRING4):LIKE(invalid_empty):0,0
FIELD:geo_blk:TYPE(STRING7):LIKE(invalid_empty):0,0
FIELD:geo_match:TYPE(STRING1):LIKE(invalid_empty):0,0
FIELD:err_stat:TYPE(STRING4):LIKE(invalid_empty):0,0
FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:did_score:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:bdid_score:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_zero_integer):0,0
FIELD:dotid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:dotscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:dotweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:empid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:empscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:empweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:powscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:powweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:proxscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:proxweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:selescore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:seleweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:orgscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:orgweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_zero_integer):0,0
FIELD:ultscore:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:ultweight:TYPE(UNSIGNED2):LIKE(invalid_zero_integer):0,0
FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0
FIELD:prep_addr_last_line:TYPE(STRING50):LIKE(invalid_mandatory):0,0
FIELD:rawaid:TYPE(UNSIGNED8):LIKE(invalid_zero_integer):0,0
FIELD:aceaid:TYPE(UNSIGNED8):LIKE(invalid_zero_integer):0,0
FIELD:persistent_record_id:TYPE(UNSIGNED8):LIKE(invalid_zero_integer):0,0
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
 
