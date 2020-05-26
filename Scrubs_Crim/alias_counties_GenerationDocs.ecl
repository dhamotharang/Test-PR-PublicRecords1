﻿Generated by SALT V3.11.9
Command line options: -MScrubs_Crim -eC:\Users\granjo01\AppData\Local\Temp\TFRB71A.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Crim
FILENAME:crim
NAMESCOPE:alias_counties
SOURCEFIELD:vendor
 
FIELDTYPE:Invalid_Record_ID:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_ )
FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:AKA_Search:CUSTOM(Scrubs_Crim.fn_FindAKA>0)
 
FIELD:recordid:LIKE(Invalid_Record_ID):TYPE(STRING40):0,0
FIELD:statecode:LIKE(Invalid_State):TYPE(STRING2):0,0
FIELD:akaname:LIKE(AKA_Search):TYPE(STRING115):0,0
FIELD:akalastname:LIKE(AKA_Search):TYPE(STRING50):0,0
FIELD:akafirstname:LIKE(AKA_Search):TYPE(STRING50):0,0
FIELD:akamiddlename:LIKE(AKA_Search):TYPE(STRING40):0,0
FIELD:akasuffix:TYPE(STRING15):0,0
FIELD:akadob:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:sourcename:TYPE(STRING100):0,0
FIELD:vendor:TYPE(STRING10):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
 
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
 
