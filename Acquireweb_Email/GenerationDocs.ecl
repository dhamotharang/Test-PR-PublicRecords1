﻿Generated by SALT V3.11.4
Command line options: -MAcquireweb_Email -eC:\Users\LuceroSD\AppData\Local\Temp\TFR5578.tmp 
File being processed :-
//SALT:  _SPC;
OPTIONS:-gn
MODULE:Acquireweb_Email
FILENAME:Acquireweb
 
//IDFIELD:EXISTS:AWID
RIDFIELD:RCID:GENERATE
INGESTFILE:Individual_update:NAMED(Acquireweb_Email.prep_ingest)
 
FIELD:awid:TYPE(STRING):0,0
FIELD:firstname:TYPE(STRING):0,0
FIELD:lastname:TYPE(STRING):0,0
FIELD:address1:DERIVED:TYPE(STRING):0,0
FIELD:address2:DERIVED:TYPE(STRING):0,0
FIELD:city:TYPE(STRING):0,0
FIELD:state:TYPE(STRING):0,0
FIELD:zip:TYPE(STRING):0,0
FIELD:zip4:TYPE(STRING):0,0
FIELD:emailid:DERIVED:TYPE(STRING):0,0
FIELD:email:TYPE(STRING):0,0
FIELD:activecode:DERIVED:TYPE(STRING):0,0
FIELD:did:DERIVED:TYPE(UNSIGNED8):0,0
FIELD:did_score:DERIVED:TYPE(UNSIGNED8):0,0
FIELD:aid:DERIVED:TYPE(UNSIGNED8):0,0
FIELD:clean_title:DERIVED:TYPE(STRING5):0,0
FIELD:clean_fname:DERIVED:TYPE(STRING20):0,0
FIELD:clean_mname:DERIVED:TYPE(STRING20):0,0
FIELD:clean_lname:DERIVED:TYPE(STRING20):0,0
FIELD:clean_name_suffix:DERIVED:TYPE(STRING5):0,0
FIELD:clean_prim_range:DERIVED:TYPE(STRING10):0,0
FIELD:clean_predir:DERIVED:TYPE(STRING2):0,0
FIELD:clean_prim_name:DERIVED:TYPE(STRING28):0,0
FIELD:clean_addr_suffix:DERIVED:TYPE(STRING4):0,0
FIELD:clean_postdir:DERIVED:TYPE(STRING2):0,0
FIELD:clean_unit_desig:DERIVED:TYPE(STRING10):0,0
FIELD:clean_sec_range:DERIVED:TYPE(STRING8):0,0
FIELD:clean_p_city_name:DERIVED:TYPE(STRING25):0,0
FIELD:clean_v_city_name:DERIVED:TYPE(STRING25):0,0
FIELD:clean_st:DERIVED:TYPE(STRING2):0,0
FIELD:clean_zip:DERIVED:TYPE(STRING5):0,0
FIELD:clean_zip4:DERIVED:TYPE(STRING4):0,0
FIELD:clean_cart:DERIVED:TYPE(STRING4):0,0
FIELD:clean_cr_sort_sz:DERIVED:TYPE(STRING1):0,0
FIELD:clean_lot:DERIVED:TYPE(STRING4):0,0
FIELD:clean_lot_order:DERIVED:TYPE(STRING1):0,0
FIELD:clean_dbpc:DERIVED:TYPE(STRING2):0,0
FIELD:clean_chk_digit:DERIVED:TYPE(STRING1):0,0
FIELD:clean_rec_type:DERIVED:TYPE(STRING2):0,0
FIELD:clean_county:DERIVED:TYPE(STRING5):0,0
FIELD:clean_geo_lat:DERIVED:TYPE(STRING10):0,0
FIELD:clean_geo_long:DERIVED:TYPE(STRING11):0,0
FIELD:clean_msa:DERIVED:TYPE(STRING4):0,0
FIELD:clean_geo_blk:DERIVED:TYPE(STRING7):0,0
FIELD:clean_geo_match:DERIVED:TYPE(STRING1):0,0
FIELD:clean_err_stat:DERIVED:TYPE(STRING4):0,0
FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0
FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0
FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0
FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0
FIELD:current_rec:DERIVED:TYPE(BOOLEAN1):0,0
 
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
 
