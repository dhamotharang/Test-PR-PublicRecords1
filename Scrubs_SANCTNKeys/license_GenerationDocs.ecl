﻿Generated by SALT V3.8.0
Command line options: -MScrubs_SANCTNKeys -eC:\Users\dittda01\AppData\Local\Temp\TFRCDF1.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_SANCTNKeys
FILENAME:SANCTNKeys
NAMESCOPE:license
 
FIELDTYPE:Invalid_Batch:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_):LENGTHS(1..)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_LicenseNumber:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz .-#)
FIELDTYPE:Invalid_ClnLicenseNumber:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_State:CUSTOM(Scrubs.fn_Valid_StateAbbrev>0)
FIELDTYPE:Invalid_LicenseType:CUSTOM(Scrubs_SANCTNKeys.fn_CodeCheck_Licence>0)
 
FIELD:batch_number:LIKE(Invalid_Batch):TYPE(STRING8):0,0
FIELD:incident_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:party_number:LIKE(Invalid_Num):TYPE(STRING8):0,0
FIELD:record_type:TYPE(STRING1):0,0
FIELD:order_number:LIKE(Invalid_Num):TYPE(STRING4):0,0
FIELD:license_number:LIKE(Invalid_LicenseNumber):TYPE(STRING50):0,0
FIELD:license_type:LIKE(Invalid_LicenseType):TYPE(STRING50):0,0
FIELD:license_state:LIKE(Invalid_State):TYPE(STRING20):0,0
FIELD:cln_license_number:LIKE(Invalid_ClnLicenseNumber):TYPE(STRING50):0,0
FIELD:std_type_desc:TYPE(STRING50):0,0
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
 
