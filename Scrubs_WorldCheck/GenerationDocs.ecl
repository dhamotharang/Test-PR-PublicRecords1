﻿Generated by SALT V3.11.9
Command line options: -MScrubs_WorldCheck -eC:\Users\granjo01\AppData\Local\Temp\TFR68EE.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_WorldCheck
FILENAME:WorldCheck
 
FIELDTYPE:Invalid_No:ALLOW(0123456789)
FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz )
FIELDTYPE:Invalid_AlphaCaps:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )
FIELDTYPE:Invalid_AlphaChar:CUSTOM(Scrubs_WorldCheck.Fn_Valid.Chars > 0, 'AlphaChar')
FIELDTYPE:Invalid_Keywords:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -~0123456789)
FIELDTYPE:Invalid_Ind:ENUM(I|E|)
FIELDTYPE:Invalid_SSN:ALLOW(0123456789-):LENGTHS(0,9,11)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_WorldCheck.Fn_Valid.Date > 0)
 
FIELD:uid:TYPE(STRING):LIKE(Invalid_No):0,0
FIELD:key:TYPE(UNSIGNED8):0,0
FIELD:name_orig:TYPE(STRING255):LIKE(Invalid_AlphaChar):0,0
FIELD:name_type:TYPE(STRING1):LIKE(Invalid_No):0,0
FIELD:last_name:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:first_name:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:category:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:title:TYPE(STRING):LIKE(Invalid_Alpha):0,0
FIELD:sub_category:TYPE(STRING):LIKE(Invalid_AlphaCaps):0,0
FIELD:position:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:age:TYPE(STRING):LIKE(Invalid_No):0,0
FIELD:date_of_birth:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:places_of_birth:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:date_of_death:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:passports:TYPE(STRING):0,0
FIELD:social_security_number:TYPE(STRING):LIKE(Invalid_SSN):0,0
FIELD:location:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:countries:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:companies:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:e_i_ind:TYPE(STRING):LIKE(Invalid_Ind):0,0
FIELD:linked_tos:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:keywords:TYPE(STRING):LIKE(Invalid_Keywords):0,0
FIELD:entered:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:updated:TYPE(STRING):LIKE(Invalid_Date):0,0
FIELD:editor:TYPE(STRING):LIKE(Invalid_AlphaChar):0,0
FIELD:age_as_of_date:TYPE(STRING):LIKE(Invalid_Date):0,0
 
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
 
