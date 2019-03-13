﻿Generated by SALT V3.7.1
Command line options: -MScrubs_ALC_LAWYERS -eC:\Users\metzmaaj\AppData\Local\Temp\TFRF1E4.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_ALC_LAWYERS
FILENAME:ALC_LAWYERS
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
FIELDTYPE:invalid_addr_type:ALLOW(#BCDHLPUXY)
FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)
FIELDTYPE:invalid_alphanumeric:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:invalid_alphanumericpound:ALLOW(#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:invalid_alphanumericpoundspacequote:ALLOW( '#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:invalid_alphapound:ALLOW(#ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)
FIELDTYPE:invalid_alphaspacequote:ALLOW( 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)
FIELDTYPE:invalid_business_ind:ENUM(1|2| )
FIELDTYPE:invalid_gender:ENUM(M|F|B|I|U| )
FIELDTYPE:invalid_number_of_lawyers_range:ENUM(01|02|03|04|05|06|07|08|09| )
FIELDTYPE:invalid_numeric:ALLOW(0123456789)
FIELDTYPE:invalid_numericpound:ALLOW(#0123456789)
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking
FIELD:fname:TYPE(STRING25):LIKE(invalid_alphaspacequote):0,0
FIELD:lname:TYPE(STRING35):LIKE(invalid_alphaspacequote):0,0
FIELD:title:TYPE(STRING40):LIKE(invalid_alphanumericpoundspacequote):0,0
FIELD:company:TYPE(STRING60):0,0
FIELD:address1:TYPE(STRING40):0,0
FIELD:address2:TYPE(STRING40):0,0
FIELD:city:TYPE(STRING25):0,0
FIELD:state:TYPE(STRING2):LIKE(invalid_alpha):0,0
FIELD:zip:TYPE(STRING5):LIKE(invalid_numeric):0,0
FIELD:zip4:TYPE(STRING4):LIKE(invalid_numeric):0,0
FIELD:cart:TYPE(STRING4):LIKE(invalid_alphanumeric):0,0
FIELD:bar:TYPE(STRING3):LIKE(invalid_numeric):0,0
FIELD:gender:TYPE(STRING1):LIKE(invalid_gender):0,0
FIELD:country:TYPE(STRING22):0,0
FIELD:postal_cd:TYPE(STRING20):0,0
FIELD:dpv:TYPE(STRING1):0,0
FIELD:addr_type:TYPE(STRING15):LIKE(invalid_addr_type):0,0
FIELD:business_ind:TYPE(STRING15):LIKE(invalid_business_ind):0,0
FIELD:county_cd:TYPE(STRING15):LIKE(invalid_alphanumeric):0,0
FIELD:msa:TYPE(STRING4):LIKE(invalid_numeric):0,0
FIELD:nielsen_county_cd:TYPE(STRING1):LIKE(invalid_alphanumeric):0,0
FIELD:number_of_lawyers_range:TYPE(STRING10):LIKE(invalid_number_of_lawyers_range):0,0
FIELD:practice_area:TYPE(STRING254):LIKE(invalid_alphanumericpound):0,0
FIELD:title_cd:TYPE(STRING50):LIKE(invalid_numericpound):0,0
FIELD:phone:TYPE(STRING20):LIKE(invalid_numeric):0,0
FIELD:list_id:TYPE(STRING10):LIKE(invalid_numeric):0,0
FIELD:scno:TYPE(STRING10):LIKE(invalid_numeric):0,0
FIELD:keycode:TYPE(STRING35):0,0
FIELD:custno:TYPE(STRING16):LIKE(invalid_alphanumeric):0,0
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
 
