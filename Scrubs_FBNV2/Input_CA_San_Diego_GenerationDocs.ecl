﻿Generated by SALT V3.11.4
Command line options: -MScrubs_FBNV2 -eC:\Users\oneillbw\AppData\Local\Temp\TFR5FEE.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_FBNV2
FILENAME:FBNV2
NAMESCOPE:Input_CA_San_Diego
//-------------------------
//FIELDTYPE DEFINITIONS
//-------------------------
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_past_date:CUSTOM(Scrubs.fn_valid_pastDate > 0)
 
//--------------------------------------------------------------- 
//FIELDS -- Commented out fields are not being scrubbed
//---------------------------------------------------------------
// FIELD:process_date:TYPE(STRING):0,0
// FIELD:TYPE_OF_RECORD:TYPE(STRING):0,0	       //exists only in old layout
// FIELD:OWNER_NAME:TYPE(STRING):0,0	           //exists only in old layout
// FIELD:fbn_type:TYPE(STRING):0,0	             //exists only in old layout
// FIELD:PNAME:TYPE(STRING):0,0                 //exists only in old layout
FIELD:FILE_NUMBER:TYPE(STRING20):LIKE(invalid_mandatory):0,0
FIELD:FILE_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0
// FIELD:EXPIRATION_DATE:TYPE(STRING):0,0
FIELD:PREV_FILE_NUMBER:TYPE(STRING20):LIKE(invalid_mandatory):0,0
FIELD:PREV_FILE_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0
FIELD:FILING_TYPE:TYPE(STRING48):LIKE(invalid_mandatory):0,0
// FIELD:BUSINESS_START_DATE:TYPE(STRING):0,0
// FIELD:OWNERSHIP_TYPE:TYPE(STRING):0,0
FIELD:BUSINESS_NAME:TYPE(STRING192):LIKE(invalid_mandatory):0,0
// FIELD:TYPE_OF_NAME:TYPE(STRING):0,0
// FIELD:TYPE_OF_NAME_SEQ_NUM:TYPE(STRING):0,0
// FIELD:STREET_ADDRESS1:TYPE(STRING):0,0
// FIELD:STREET_ADDRESS2:TYPE(STRING):0,0
// FIELD:CITY:TYPE(STRING):0,0
// FIELD:STATE:TYPE(STRING):0,0
// FIELD:ZIP_CODE:TYPE(STRING):0,0
// FIELD:COUNTRY:TYPE(STRING):0,0
// FIELD:MAILING_ADDRESS1:TYPE(STRING):0,0
// FIELD:MAILING_ADDRESS2:TYPE(STRING):0,0
// FIELD:MAILING_CITY:TYPE(STRING):0,0
// FIELD:MAILING_STATE:TYPE(STRING):0,0
// FIELD:MAILING_ZIP_CODE:TYPE(STRING):0,0
// FIELD:MAILING_COUNTRY:TYPE(STRING):0,0
FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0
FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0
// FIELD:prep_mail_addr_line1:TYPE(STRING):0,0
// FIELD:prep_mail_addr_line_last:TYPE(STRING):0,0
 
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
 
