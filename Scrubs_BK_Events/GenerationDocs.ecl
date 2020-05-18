﻿Generated by SALT V3.11.9
Command line options: -MScrubs_BK_Events -eC:\Users\granjo01\AppData\Local\Temp\TFR6E09.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_BK_Events
FILENAME:BK_Events
 
FIELDTYPE:Invalid_No:ALLOW(0123456789)
FIELDTYPE:Invalid_Int:ALLOW(0123456789- )
FIELDTYPE:Invalid_Float:ALLOW(0123456789., )
FIELDTYPE:Invalid_CaseNo:ALLOW(0123456789-: ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Alpha:CUSTOM(Scrubs.Fn_Allow_ws > 0, 'Alpha')
FIELDTYPE:Invalid_AlphaNum:CUSTOM(Scrubs.Fn_Allow_ws > 0, 'AlphaNum', true)
FIELDTYPE:Invalid_AlphaNumChar:CUSTOM(Scrubs.Fn_Allow_ws > 0, 'AlphaNumChar', true)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_BK_Events.Fn_Valid_Date > 0)
 
FIELD:dractivitytypecode:TYPE(QSTRING1):LIKE(Invalid_Alpha):0,0
FIELD:docketentryid:TYPE(STRING100):LIKE(Invalid_No):0,0
FIELD:courtid:TYPE(STRING10):LIKE(Invalid_No):0,0
FIELD:casekey:TYPE(STRING7):LIKE(Invalid_No):0,0
FIELD:casetype:TYPE(STRING2):LIKE(Invalid_Alpha):0,0
FIELD:bkcasenumber:TYPE(STRING24):LIKE(Invalid_CaseNo):0,0
FIELD:bkcasenumberurl:TYPE(STRING200):0,0
FIELD:proceedingscasenumber:TYPE(STRING24):LIKE(Invalid_CaseNo):0,0
FIELD:proceedingscasenumberurl:TYPE(STRING200):0,0
FIELD:caseid:TYPE(STRING10):LIKE(Invalid_No):0,0
FIELD:pacercaseid:TYPE(STRING10):LIKE(Invalid_Int):0,0
FIELD:attachmenturl:TYPE(STRING200):0,0
FIELD:entrynumber:TYPE(STRING10):LIKE(Invalid_Int):0,0
FIELD:entereddate:TYPE(STRING24):LIKE(Invalid_Date):0,0
FIELD:pacer_entereddate:TYPE(STRING24):LIKE(Invalid_Date):0,0
FIELD:fileddate:TYPE(STRING24):LIKE(Invalid_Date):0,0
FIELD:score:TYPE(STRING5):LIKE(Invalid_Float):0,0
FIELD:drcategoryeventid:TYPE(STRING5):LIKE(Invalid_No):0,0
FIELD:dockettext:TYPE(STRING5000):0,0
FIELD:court_code:TYPE(STRING5):LIKE(Invalid_AlphaNum):0,0
FIELD:district:TYPE(STRING40):LIKE(Invalid_Alpha):0,0
FIELD:boca_court:TYPE(STRING5):LIKE(Invalid_Alpha):0,0
FIELD:catevent_description:TYPE(STRING200):LIKE(Invalid_AlphaNumChar):0,0
FIELD:catevent_category:TYPE(STRING200):0,0
 
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
 
