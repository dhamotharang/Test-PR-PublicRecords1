﻿Generated by SALT V3.11.4
Command line options: -MScrubs_EBR -eC:\Users\mireleaa\AppData\Local\Temp\TFR8B6D.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_EBR
FILENAME:EBR
NAMESCOPE:Base_5610
//--------------------------
//FIELDTYPE DEFINITIONS
//--------------------------
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_EBR.Functions.fn_numeric>0)
FIELDTYPE:invalid_numeric_or_allzeros:CUSTOM(Scrubs_EBR.Functions.fn_numeric_or_allzeros>0)
FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_EBR.Functions.fn_past_yyyymmdd>0)
FIELDTYPE:invalid_dt_first_seen:CUSTOM(Scrubs_EBR.Functions.fn_dt_first_seen>0)
FIELDTYPE:invalid_record_type:ENUM(H|C)
FIELDTYPE:invalid_segment:ENUM(5610|5610)
FIELDTYPE:invalid_file_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(9)
 
//------------------------------------------------------
//FIELDS:  Commented out fields are not being scrubbed
//------------------------------------------------------
// FIELD:dotid:TYPE(UNSIGNED6):0,0
// FIELD:dotscore:TYPE(UNSIGNED2):0,0
// FIELD:dotweight:TYPE(UNSIGNED2):0,0
// FIELD:empid:TYPE(UNSIGNED6):0,0
// FIELD:empscore:TYPE(UNSIGNED2):0,0
// FIELD:empweight:TYPE(UNSIGNED2):0,0
FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:powscore:TYPE(UNSIGNED2):0,0
// FIELD:powweight:TYPE(UNSIGNED2):0,0
FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:proxscore:TYPE(UNSIGNED2):0,0
// FIELD:proxweight:TYPE(UNSIGNED2):0,0
FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:selescore:TYPE(UNSIGNED2):0,0
// FIELD:seleweight:TYPE(UNSIGNED2):0,0
FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:orgscore:TYPE(UNSIGNED2):0,0
// FIELD:orgweight:TYPE(UNSIGNED2):0,0
FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_mandatory):0,0
// FIELD:ultscore:TYPE(UNSIGNED2):0,0
// FIELD:ultweight:TYPE(UNSIGNED2):0,0
FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
FIELD:date_first_seen:TYPE(STRING8):LIKE(invalid_dt_first_seen):0,0
FIELD:date_last_seen:TYPE(STRING8):LIKE(invalid_pastdate):0,0
FIELD:process_date_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:process_date_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0
FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0
FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0
// FIELD:did_score:TYPE(UNSIGNED1):0,0
FIELD:ssn:TYPE(UNSIGNED4):LIKE(invalid_numeric_or_allzeros):0,0
FIELD:process_date:TYPE(STRING8):LIKE(invalid_pastdate):0,0
FIELD:file_number:TYPE(STRING10):LIKE(invalid_file_number):0,0
FIELD:segment_code:TYPE(STRING4):LIKE(invalid_segment):0,0
FIELD:sequence_number:TYPE(STRING5):LIKE(invalid_numeric_or_allzeros):0,0
// FIELD:fiscal_yr_end_mm:TYPE(STRING2):0,0
// FIELD:profit_range_code:TYPE(STRING1):0,0
// FIELD:profit_range_desc:TYPE(STRING25):0,0
// FIELD:profit_range_actual:TYPE(STRING7):0,0
// FIELD:net_worth_code:TYPE(STRING1):0,0
// FIELD:net_worth_desc:TYPE(STRING25):0,0
// FIELD:net_worth_actual:TYPE(STRING7):0,0
// FIELD:in_bldng_since_yy:TYPE(STRING4):0,0
// FIELD:own_or_rent_code:TYPE(STRING1):0,0
// FIELD:bldng_square_feet:TYPE(STRING7):0,0
// FIELD:active_cust_count:TYPE(STRING7):0,0
// FIELD:ownership_code:TYPE(STRING1):0,0
// FIELD:ownership_desc:TYPE(STRING20):0,0
// FIELD:corp_name:TYPE(STRING31):0,0
// FIELD:corp_city:TYPE(STRING20):0,0
// FIELD:corp_state_code:TYPE(STRING2):0,0
// FIELD:corp_state_desc:TYPE(STRING20):0,0
// FIELD:corp_phone:TYPE(STRING10):0,0
FIELD:officer_title:TYPE(STRING10):LIKE(invalid_mandatory):0,0
FIELD:officer_first_name:TYPE(STRING10):LIKE(invalid_mandatory):0,0
FIELD:officer_m_i:TYPE(STRING1):LIKE(invalid_mandatory):0,0
FIELD:officer_last_name:TYPE(STRING20):LIKE(invalid_mandatory):0,0
FIELD:clean_officer_name_title:TYPE(STRING5):LIKE(invalid_mandatory):0,0
FIELD:clean_officer_name_fname:TYPE(STRING20):LIKE(invalid_mandatory):0,0
FIELD:clean_officer_name_mname:TYPE(STRING20):LIKE(invalid_mandatory):0,0
FIELD:clean_officer_name_lname:TYPE(STRING20):LIKE(invalid_mandatory):0,0
FIELD:clean_officer_name_name_suffix:TYPE(STRING5):LIKE(invalid_mandatory):0,0
// FIELD:clean_officer_name_name_score:TYPE(STRING3):0,0
 
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
 
