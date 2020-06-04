﻿Generated by SALT V3.11.7
Command line options: -MHealthcareNoMatchHeader_Ingest -eC:\Users\garrke01\AppData\Local\Temp\TFRA0D4.tmp 
File being processed :-
OPTIONS:-gn -gh
MODULE:HealthCareNoMatchHeader_Ingest
 
FILENAME:Base
IDFIELD:EXISTS:nomatch_id
RIDFIELD:RID:GENERATE
SOURCEFIELD:src
INGESTFILE:RAW_ALL:NAMED(HealthCareNoMatchHeader_Ingest.In_Ingest)
 
// Source fields may seem special, but still need to be FIELDs to be used in the comparison
 
FIELD:src:0,0
 
// RECORDDATE fields are not considered for matching, and will be rolled up
 
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
FIELD:dt_vendor_first_reported:RECORDDATE(FIRST):0,0
FIELD:dt_vendor_last_reported:RECORDDATE(LAST):0,0
 
// Fields DERIVED are not considered for matching, and will receive their "new" value 
// Record defining fields will be considered in dedup all other fileds gets existing base value  
 
FIELD:source_rid:0,0
FIELD:ssn:0,0
FIELD:dob:0,0
FIELD:title:DERIVED:0,0
FIELD:fname:0,0
FIELD:mname:DERIVED:0,0
FIELD:lname:DERIVED:0,0
FIELD:suffix:DERIVED:0,0
FIELD:home_phone:DERIVED:0,0
FIELD:gender:DERIVED:0,0
 
FIELD:prim_range:DERIVED:0,0
FIELD:predir:DERIVED:0,0
FIELD:prim_name:DERIVED:0,0
FIELD:addr_suffix:DERIVED:0,0 
FIELD:postdir:DERIVED:0,0
FIELD:unit_desig:DERIVED:DERIVED:0,0  
FIELD:sec_range:DERIVED:0,0
FIELD:city_name:DERIVED:0,0
FIELD:st:DERIVED:0,0
FIELD:zip:DERIVED:0,0
FIELD:zip4:DERIVED:0,0
 
FIELD:lexid:DERIVED:0,0
 
// FIELD:member_id:DERIVED:0,0
// FIELD:customer_id:DERIVED:0,0
// FIELD:account_id:DERIVED:0,0
// FIELD:subscriber_id:DERIVED:0,0
// FIELD:group_id:DERIVED:0,0
 
 
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
 
