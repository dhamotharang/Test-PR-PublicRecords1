﻿Generated by SALT V3.11.11
Command line options: -MScrubs_PhoneFinder -eC:\Users\taojx\AppData\Local\Temp\TFR231D.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_PhoneFinder
FILENAME:PhoneFinder
NAMESCOPE:Identities
 
FIELDTYPE:Invalid_No:ALLOW(0123456789\\N)
FIELDTYPE:Invalid_ID:ALLOW(0123456789R\\N)
FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\\ ):LENGTHS(0,2)
FIELDTYPE:Invalid_AlphaChar:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ&\| .,/-\\')
FIELDTYPE:Invalid_AlphaNumChar:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ&#\| .,/-\\')
FIELDTYPE:Invalid_Zip:LIKE(Invalid_No):LENGTHS(0,2,5)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_PhoneFinder.Functions.Split_Date > 0)
FIELDTYPE:Invalid_File:CUSTOM(Scrubs_PhoneFinder.Functions.Check_File > 0)
 
FIELD:transaction_id:TYPE(STRING16):LIKE(Invalid_ID):0,0R
FIELD:sequence_number:TYPE(INTEGER5):LIKE(Invalid_No):0,0
FIELD:lexid:TYPE(STRING32):LIKE(Invalid_No):0,0
FIELD:full_name:TYPE(STRING128):LIKE(Invalid_AlphaChar):0,0
FIELD:full_address:TYPE(STRING128):LIKE(Invalid_AlphaNumChar):0,0
FIELD:city:TYPE(STRING64):LIKE(Invalid_AlphaChar):0,0
FIELD:state:TYPE(STRING16):LIKE(Invalid_State):0,0
FIELD:zip:TYPE(STRING10):LIKE(Invalid_Zip):0,0
FIELD:verified_carrier:TYPE(INTEGER1):LIKE(Invalid_No):0,0
FIELD:date_added:TYPE(STRING20):LIKE(Invalid_Date):0,0
FIELD:filename:TYPE(STRING255):LIKE(Invalid_File):0,0
 
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
 
