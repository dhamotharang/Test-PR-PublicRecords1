﻿Generated by SALT V3.9.0
Command line options: -MScrubs_PhonesInfo -eC:\Users\dittda01\AppData\Local\Temp\TFRF876.tmp 
File being processed :-
options:-gh 
MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:iConectivMain
 
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 )
FIELDTYPE:Invalid_DCT:ALLOW(ECTBN)
FIELDTYPE:Invalid_TOS:ALLOW(MGOU)
FIELDTYPE:Invalid_Port_Date:ALLOW(0123456789 /:-)
FIELDTYPE:Invalid_ISO2:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)
 
FIELD:country_code:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING12):0,0
FIELD:dial_type:LIKE(Invalid_DCT):TYPE(STRING1):0,0
FIELD:spid:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:service_provider:TYPE(STRING):0,0
FIELD:service_type:LIKE(Invalid_TOS):TYPE(STRING1):0,0
FIELD:routing_code:LIKE(Invalid_Num_Blank):TYPE(STRING10):0,0
FIELD:porting_dt:LIKE(Invalid_Port_Date):TYPE(STRING):0,0
FIELD:country_abbr:LIKE(Invalid_ISO2):TYPE(STRING2):0,0
FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0
FIELD:file_dt_time:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:vendor_first_reported_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:vendor_last_reported_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:port_start_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:port_end_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:remove_port_dt:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:is_ported:TYPE(BOOLEAN1):0,0
 
 
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
 
