﻿Generated by SALT V3.11.4
Command line options: -MScrubs_Official_Records -eC:\Users\dittda01\AppData\Local\Temp\TFR6CC8.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Official_Records
FILENAME:Official_Records
NAMESCOPE:Party
 
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_State:ENUM(FL|CA)
FIELDTYPE:Invalid_County:CUSTOM(Scrubs_Official_Records.fnValidCounty>0)
FIELDTYPE:Invalid_NonBlank:LENGTHS(1..)
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -')
 
FIELD:process_date:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:vendor:LIKE(Invalid_Num):TYPE(STRING2):0,0
FIELD:state_origin:LIKE(Invalid_State):TYPE(STRING2):0,0
FIELD:county_name:LIKE(Invalid_County):TYPE(STRING30):0,0
FIELD:official_record_key:LIKE(Invalid_NonBlank):TYPE(STRING60):0,0
FIELD:doc_instrument_or_clerk_filing_num:TYPE(STRING25):0,0
FIELD:doc_filed_dt:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:doc_type_desc:LIKE(Invalid_NonBlank):TYPE(STRING60):0,0
FIELD:entity_sequence:TYPE(STRING5):0,0
FIELD:entity_type_cd:LIKE(Invalid_NonBlank):TYPE(STRING15):0,0
FIELD:entity_type_desc:TYPE(STRING50):0,0
FIELD:entity_nm:TYPE(STRING80):0,0
FIELD:entity_nm_format:TYPE(STRING1):0,0
FIELD:entity_dob:TYPE(STRING8):0,0
FIELD:entity_ssn:TYPE(STRING9):0,0
FIELD:title1:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:fname1:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:mname1:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:lname1:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:suffix1:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:pname1_score:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:cname1:LIKE(Invalid_Char):TYPE(STRING70):0,0
FIELD:title2:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:fname2:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:mname2:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:lname2:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:suffix2:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:pname2_score:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:cname2:LIKE(Invalid_Char):TYPE(STRING70):0,0
FIELD:title3:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:fname3:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:mname3:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:lname3:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:suffix3:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:pname3_score:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:cname3:LIKE(Invalid_Char):TYPE(STRING70):0,0
FIELD:title4:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:fname4:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:mname4:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:lname4:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:suffix4:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:pname4_score:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:cname4:LIKE(Invalid_Char):TYPE(STRING70):0,0
FIELD:title5:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:fname5:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:mname5:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:lname5:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:suffix5:LIKE(Invalid_Char):TYPE(STRING5):0,0
FIELD:pname5_score:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:cname5:LIKE(Invalid_Char):TYPE(STRING70):0,0
FIELD:master_party_type_cd:TYPE(STRING1):0,0
// CONCEPT statements should be used to group together interellated fields; such as address
// RELATIONSHIP is used to find non-obvious relationships between the clusters
// SOURCEFIELD is used if a field of the file denotes a source of the records in that file
// LINKPATH is used to define access paths for external linking
 
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
 
