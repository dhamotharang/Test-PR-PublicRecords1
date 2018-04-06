Generated by SALT V3.10.0
Command line options: -gh 
File being processed :-
MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:DeactGHMain

FIELDTYPE:Invalid_Action_Code:ENUM(DE|RE):Lengths(1..)
FIELDTYPE:Invalid_Deact_Code:ENUM(DE| )
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 )
FIELDTYPE:Invalid_Filename:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.:)
FIELDTYPE:Invalid_IS:ALLOW(YNP)

FIELD:groupid:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:vendor_first_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:vendor_last_reported_dt:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:action_code:LIKE(Invalid_Action_Code):TYPE(STRING2):0,0
FIELD:timestamp:LIKE(Invalid_Num_Blank):TYPE(STRING14):0,0
FIELD:phone:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:phone_swap:LIKE(Invalid_Num_Blank):TYPE(STRING10):0,0
FIELD:filename:LIKE(Invalid_Filename):TYPE(STRING255):0,0
FIELD:carrier_name:TYPE(STRING60):0,0
FIELD:filedate:LIKE(Invalid_Num):TYPE(STRING):0,0
FIELD:swap_start_dt:TYPE(UNSIGNED8):0,0
FIELD:swap_end_dt:TYPE(UNSIGNED8):0,0
FIELD:deact_code:LIKE(Invalid_Deact_Code):TYPE(STRING2):0,0
FIELD:deact_start_dt:LIKE(Invalid_Num_Blank):TYPE(UNSIGNED8):0,0
FIELD:deact_end_dt:LIKE(Invalid_Num_Blank):TYPE(UNSIGNED8):0,0
FIELD:react_start_dt:LIKE(Invalid_Num_Blank):TYPE(UNSIGNED8):0,0
FIELD:react_end_dt:LIKE(Invalid_Num_Blank):TYPE(UNSIGNED8):0,0
FIELD:is_react:LIKE(Invalid_IS):TYPE(STRING2):0,0
FIELD:is_deact:LIKE(Invalid_IS):TYPE(STRING2):0,0
FIELD:porting_dt:LIKE(Invalid_Num_Blank):TYPE(UNSIGNED8):0,0
FIELD:pk_carrier_name:TYPE(STRING):0,0
FIELD:days_apart:LIKE(Invalid_Num):TYPE(INTEGER8):0,0

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


