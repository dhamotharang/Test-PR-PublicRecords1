﻿Generated by SALT V3.9.0
Command line options: -MScrubs_PhonesInfo -eC:\Users\dittda01\AppData\Local\Temp\TFR8CDA.tmp 
File being processed :-
options:-gh 
MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:LIDBReceived
 
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 \(\)&-.,/-#@')
FIELDTYPE:Invalid_AccOwn:ALLOW(ABHGCDFE0123456789 )
FIELDTYPE:Invalid_RefID:ALLOW(MGP0123456789 )
 
FIELD:reference_id:LIKE(Invalid_RefID):TYPE(STRING):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:reply_code:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:local_routing_number:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:account_owner:LIKE(Invalid_AccOwn):TYPE(STRING4):0,0
FIELD:carrier_name:LIKE(Invalid_Char):TYPE(STRING55):0,0
FIELD:carrier_category:LIKE(Invalid_Char):TYPE(STRING10):0,0
FIELD:local_area_transport_area:TYPE(STRING5):0,0
FIELD:point_code:TYPE(STRING9):0,0
 
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
 
