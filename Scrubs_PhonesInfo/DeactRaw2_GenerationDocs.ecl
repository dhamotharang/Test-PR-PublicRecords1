﻿Generated by SALT V3.11.11
Command line options: -MScrubs_PhonesInfo -eC:\Users\taojx\AppData\Local\Temp\TFRC2B4.tmp 
File being processed :-
OPTIONS:-gh 
MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:DeactRaw2
 
FIELDTYPE:Invalid_Num:ALLOW(0123456789 \n)
FIELDTYPE:Invalid_TimeStamp:ALLOW(0123456789- \n) 
 
FIELD:msisdn:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:timestamp:LIKE(Invalid_TimeStamp):TYPE(STRING):0,0
FIELD:changeid:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:operatorid:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:msisdneid:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:msisdnnew:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:filename:TYPE(STRING255):0,0
 
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
 
