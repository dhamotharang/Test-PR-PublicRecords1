﻿Generated by SALT V3.11.9
Command line options: -MScrubs_LaborActions_EBSA -eC:\Users\granjo01\AppData\Local\Temp\TFRE4E7.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_LaborActions_EBSA
FILENAME:LaborActions_EBSA
 
FIELDTYPE:Invalid_No:ALLOW(0123456789)
FIELDTYPE:Invalid_Float:ALLOW(0123456789 .,-/)
FIELDTYPE:Invalid_Alpha:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ )
FIELDTYPE:Invalid_AlphaNumChar:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789_.,-/&\(\))
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.Fn_Valid_Date > 0)
FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)
 
FIELD:dart_id:TYPE(STRING):LIKE(Invalid_No):0,0
FIELD:date_added:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:date_updated:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:website:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:state:TYPE(STRING):LIKE(Invalid_State):0,0
FIELD:casetype:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:plan_ein:TYPE(STRING):LIKE(Invalid_Float):0,0
FIELD:plan_no:TYPE(STRING):LIKE(Invalid_No):0,0
FIELD:plan_year:TYPE(STRING):LIKE(Invalid_Float):0,0
FIELD:plan_name:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0
FIELD:plan_administrator:TYPE(STRING):LIKE(Invalid_AlphaNumChar):0,0
FIELD:admin_state:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:admin_zip_code:TYPE(STRING):LIKE(Invalid_No):0,0
FIELD:admin_zip_code4:TYPE(STRING):LIKE(Invalid_No):0,0
FIELD:closing_reason:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:closing_date:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:penalty_amount:TYPE(STRING):0,0
 
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
 
