﻿Generated by SALT V3.11.9
Command line options: -MScrubs_CFPB -eC:\Users\granjo01\AppData\Local\Temp\TFR177C.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_CFPB
FILENAME:CFPB
 
FIELDTYPE:invalid_no:ALLOW(0123456789)
FIELDTYPE:invalid_id:LEFTTRIM:LENGTHS(1..5)
FIELDTYPE:invalid_date:LIKE(invalid_no):LEFTTRIM:LENGTHS(8)
FIELDTYPE:invalid_seqno:LEFTTRIM:LENGTHS(1..4)
FIELDTYPE:invalid_geoid10_blkgrp:LIKE(invalid_no):LEFTTRIM:LENGTHS(12)
FIELDTYPE:invalid_state_fips10:LIKE(invalid_no):LEFTTRIM:LENGTHS(2..)
FIELDTYPE:invalid_county_fips10:LIKE(invalid_no):LEFTTRIM:LENGTHS(3..)
FIELDTYPE:invalid_tract_fips10:LIKE(invalid_no):LEFTTRIM:LENGTHS(1..3)
FIELDTYPE:invalid_blkgrp_fips10:LEFTTRIM:LENGTHS(1..3)
 
FIELD:record_sid:LIKE(invalid_id):TYPE(UNSIGNED4):0,0
FIELD:global_src_id:LIKE(invalid_id):TYPE(UNSIGNED8):0,0
FIELD:dt_vendor_first_reported:LIKE(invalid_date):TYPE(UNSIGNED6):0,0
FIELD:dt_vendor_last_reported:LIKE(invalid_date):TYPE(UNSIGNED6):0,0
FIELD:is_latest:TYPE(BOOLEAN):0,0
FIELD:seqno:LIKE(invalid_seqno):TYPE(UNSIGNED2):0,0
FIELD:geoid10_blkgrp:LIKE(invalid_geoid10_blkgrp):TYPE(STRING12):0,0
FIELD:state_fips10:LIKE(invalid_state_fips10):TYPE(STRING3):0,0
FIELD:county_fips10:LIKE(invalid_county_fips10):TYPE(STRING6):0,0
FIELD:tract_fips10:LIKE(invalid_tract_fips10):TYPE(STRING1):0,0
FIELD:blkgrp_fips10:LIKE(invalid_blkgrp_fips10):TYPE(UNSIGNED2):0,0
FIELD:total_pop:TYPE(UNSIGNED2):0,0
FIELD:hispanic_total:TYPE(UNSIGNED2):0,0
FIELD:non_hispanic_total:TYPE(UNSIGNED2):0,0
FIELD:nh_white_alone:TYPE(UNSIGNED2):0,0
FIELD:nh_black_alone:TYPE(UNSIGNED2):0,0
FIELD:nh_aian_alone:TYPE(UNSIGNED2):0,0
FIELD:nh_api_alone:TYPE(UNSIGNED2):0,0
FIELD:nh_other_alone:TYPE(UNSIGNED2):0,0
FIELD:nh_mult_total:TYPE(UNSIGNED2):0,0
FIELD:nh_white_other:TYPE(UNSIGNED2):0,0
FIELD:nh_black_other:TYPE(UNSIGNED2):0,0
FIELD:nh_aian_other:TYPE(UNSIGNED2):0,0
FIELD:nh_asian_hpi:TYPE(UNSIGNED2):0,0
FIELD:nh_api_other:TYPE(UNSIGNED2):0,0
FIELD:nh_asian_hpi_other:TYPE(UNSIGNED2):0,0
 
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
 
