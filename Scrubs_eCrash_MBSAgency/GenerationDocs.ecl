﻿Generated by SALT V3.7.0
Command line options: 
File being processed :-
ï»¿OPTIONS:-gh
MODULE:Scrubs_eCrash_MBSAgency
FILENAME:eCrash_MBSAgency
FIELDTYPE:invalid_agency_id:ALLOW(0123456789):LENGTHS(7)
FIELDTYPE:invalid_source_id:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ \N):LENGTHS(0,1,2,3)
FIELDTYPE:invalid_agency_state_abbr:CUSTOM(Scrubs.fn_Valid_StateAbbrev>0)
FIELDTYPE:invalid_agency_ori:ALLOW(0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ \N)
FIELDTYPE:invalid_allow_open_search:ALLOW(01):LENGTHS(1)
FIELDTYPE:invalid_append_overwrite_flag:ENUM(AP|OW):LENGTHS(2)
FIELDTYPE:invalid_drivers_exchange_flag:ALLOW(01):LENGTHS(1)
FIELD:agency_id:LIKE(invalid_agency_id):TYPE(STRING):0,0
FIELD:agency_name:TYPE(STRING):0,0
FIELD:source_id:LIKE(invalid_source_id):TYPE(STRING):0,0
FIELD:agency_state_abbr:LIKE(invalid_agency_state_abbr):TYPE(STRING):0,0
FIELD:agency_ori:LIKE(invalid_agency_ori):TYPE(STRING):0,0
FIELD:allow_open_search:LIKE(invalid_allow_open_search):TYPE(STRING):0,0
FIELD:append_overwrite_flag:LIKE(invalid_append_overwrite_flag):TYPE(STRING):0,0
FIELD:drivers_exchange_flag:LIKE(invalid_drivers_exchange_flag):TYPE(STRING):0,0
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
