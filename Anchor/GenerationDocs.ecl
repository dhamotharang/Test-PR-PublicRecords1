﻿Generated by SALT V3.11.4
Command line options: -MAnchor -eC:\Users\LuceroSD\AppData\Local\Temp\TFR1FB.tmp 
File being processed :-
//SALT:  _spc;
OPTIONS:-gn
MODULE:Anchor
FILENAME:Anchor
 
RIDFIELD:RCID:GENERATE
INGESTFILE:Anchor_update:NAMED(Anchor.prep_ingest_file)
 
FIELD:firstname:TYPE(STRING):0,0
FIELD:lastname:TYPE(STRING):0,0
FIELD:address_1:DERIVED:TYPE(STRING):0,0
FIELD:address_2:DERIVED:TYPE(STRING):0,0
FIELD:city:TYPE(STRING):0,0
FIELD:state:TYPE(STRING):0,0
FIELD:zipcode:TYPE(STRING):0,0
FIELD:sourceurl:DERIVED:TYPE(STRING):0,0
FIELD:ipaddress:DERIVED:TYPE(STRING):0,0
FIELD:optindate:DERIVED:TYPE(STRING):0,0
FIELD:emailaddress:TYPE(STRING):0,0
FIELD:anchorinternalcode:DERIVED:TYPE(STRING):0,0
FIELD:addresstype:DERIVED:TYPE(STRING):0,0
FIELD:dob:TYPE(STRING):0,0
FIELD:latitude:DERIVED:TYPE(STRING):0,0
FIELD:longitude:DERIVED:TYPE(STRING):0,0
FIELD:persistent_record_id:DERIVED:TYPE(UNSIGNED8):0,0
FIELD:did:DERIVED:TYPE(UNSIGNED8):0,0
FIELD:did_score:DERIVED:TYPE(UNSIGNED8):0,0
FIELD:clean_title:DERIVED:TYPE(STRING5):0,0
FIELD:clean_fname:DERIVED:TYPE(STRING20):0,0
FIELD:clean_mname:DERIVED:TYPE(STRING20):0,0
FIELD:clean_lname:DERIVED:TYPE(STRING20):0,0
FIELD:clean_name_suffix:DERIVED:TYPE(STRING5):0,0
FIELD:clean_name_score:DERIVED:TYPE(STRING3):0,0
FIELD:rawaid:DERIVED:TYPE(UNSIGNED8):0,0
FIELD:append_prep_address_situs:DERIVED:TYPE(STRING77):0,0
FIELD:append_prep_address_last_situs:DERIVED:TYPE(STRING54):0,0
FIELD:prim_range:DERIVED:TYPE(STRING10):0,0
FIELD:predir:DERIVED:TYPE(STRING2):0,0
FIELD:prim_name:DERIVED:TYPE(STRING28):0,0
FIELD:addr_suffix:DERIVED:TYPE(STRING4):0,0
FIELD:postdir:DERIVED:TYPE(STRING2):0,0
FIELD:unit_desig:DERIVED:TYPE(STRING10):0,0
FIELD:sec_range:DERIVED:TYPE(STRING8):0,0
FIELD:p_city_name:DERIVED:TYPE(STRING25):0,0
FIELD:v_city_name:DERIVED:TYPE(STRING25):0,0
FIELD:st:DERIVED:TYPE(STRING2):0,0
FIELD:zip:DERIVED:TYPE(STRING5):0,0
FIELD:zip4:DERIVED:TYPE(STRING4):0,0
FIELD:cart:DERIVED:TYPE(STRING4):0,0
FIELD:cr_sort_sz:DERIVED:TYPE(STRING1):0,0
FIELD:lot:DERIVED:TYPE(STRING4):0,0
FIELD:lot_order:DERIVED:TYPE(STRING1):0,0
FIELD:dbpc:DERIVED:TYPE(STRING2):0,0
FIELD:chk_digit:DERIVED:TYPE(STRING1):0,0
FIELD:rec_type:DERIVED:TYPE(STRING2):0,0
FIELD:county:DERIVED:TYPE(STRING5):0,0
FIELD:geo_lat:DERIVED:TYPE(STRING10):0,0
FIELD:geo_long:DERIVED:TYPE(STRING11):0,0
FIELD:msa:DERIVED:TYPE(STRING4):0,0
FIELD:geo_blk:DERIVED:TYPE(STRING7):0,0
FIELD:geo_match:DERIVED:TYPE(STRING1):0,0
FIELD:err_stat:DERIVED:TYPE(STRING4):0,0
FIELD:process_date:TYPE(STRING8):RECORDDATE(LAST):0,0
FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0
FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0
FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0
FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0
FIELD:clean_cname:DERIVED:TYPE(STRING):0,0
FIELD:current_rec:DERIVED:TYPE(BOOLEAN1):0,0
 
//BIP addition
FIELD:dotid:DERIVED:TYPE(UNSIGNED6):0,0
FIELD:dotscore:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:dotweight:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:empid:DERIVED:TYPE(UNSIGNED6):0,0
FIELD:empscore:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:empweight:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:powid:DERIVED:TYPE(UNSIGNED6):0,0
FIELD:powscore:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:powweight:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:proxid:DERIVED:TYPE(UNSIGNED6):0,0
FIELD:proxscore:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:proxweight:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:seleid:DERIVED:TYPE(UNSIGNED6):0,0
FIELD:selescore:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:seleweight:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:orgid:DERIVED:TYPE(UNSIGNED6):0,0
FIELD:orgscore:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:orgweight:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:ultid:DERIVED:TYPE(UNSIGNED6):0,0
FIELD:ultscore:DERIVED:TYPE(UNSIGNED2):0,0
FIELD:ultweight:DERIVED:TYPE(UNSIGNED2):0,0
 
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
 
