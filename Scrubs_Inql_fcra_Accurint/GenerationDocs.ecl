﻿Generated by SALT V3.9.0
Command line options: -MScrubs_Inql_fcra_Accurint -eC:\Users\kumade01\AppData\Local\Temp\TFR80F8.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Inql_fcra_Accurint
FILENAME:FILE
 
FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("')
FIELDTYPE:ALPHA:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):
FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-,'.):
FIELDTYPE:NUMBER:ALLOW(0123456789):
FIELDTYPE:ALPHANUM:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):
FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789<>{}[]-^=!+&,./:|#_@$;):SPACES( ):ONFAIL(CLEAN):
 
FIELDTYPE:orig_end_user_id:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_loginid:SPACES( ):LIKE(WORDBAG):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_billing_code:SPACES( ):LIKE(WORDBAG):LEFTTRIM:WORDS(1,2):ONFAIL(CLEAN)
FIELDTYPE:orig_transaction_id:SPACES( ):ALLOW(0123456789ABR):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_transaction_type:SPACES( ):ALLOW(I):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_neighbors:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_relatives:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_associates:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_property:SPACES( ):ALLOW(01):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_company_id:SPACES( ):LIKE(NUMBER):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_reference_code:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)
FIELDTYPE:orig_fname:SPACES( ):LIKE(NAME):WORDS(1,0,2):ONFAIL(CLEAN)
FIELDTYPE:orig_mname:SPACES( ):LIKE(NAME):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_lname:SPACES( ):LIKE(NAME):WORDS(1,0,2,3):ONFAIL(CLEAN)
FIELDTYPE:orig_address:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)
FIELDTYPE:orig_city:SPACES( ):LIKE(ALPHA):WORDS(0,1,2,3):ONFAIL(CLEAN)
FIELDTYPE:orig_state:SPACES( ):LIKE(ALPHA):LEFTTRIM:LENGTHS(0,2):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_zip:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,5):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_zip4:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,4):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_phone:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_ssn:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(9,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_free:SPACES( ):ALLOW(04):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_record_count:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_price:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(9,8):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_bankruptcy:SPACES( ):ALLOW(01):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_transaction_code:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,3):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_dateadded:SPACES( ):ALLOW( 0123456789:AMOPct):LEFTTRIM:LENGTHS(26):WORDS(4):ONFAIL(CLEAN)
FIELDTYPE:orig_full_name:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_billingdate:SPACES( ):ALLOW( 0123456789:AMOPct):LEFTTRIM:LENGTHS(26,0):WORDS(4,0):ONFAIL(CLEAN)
FIELDTYPE:orig_business_name:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_pricing_error_code:SPACES( ):ALLOW(-012):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_dl_purpose:SPACES( ):ALLOW(0134):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_result_format:SPACES( ):ALLOW(0cn):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_dob:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,8):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_unique_id:SPACES( ):LIKE(ALPHANUM):LEFTTRIM:WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_dls:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_mvs:SPACES( ):ALLOW(0):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_function_name:SPACES( ):LIKE(WORDBAG):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_response_time:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:LENGTHS(4):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_data_source:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_glb_purpose:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_report_options:SPACES( ):LIKE(WORDBAG):LEFTTRIM:WORDS(1,4):ONFAIL(CLEAN)
FIELDTYPE:orig_unused:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_login_history_id:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(1,10,9):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_aseid:SPACES( ):ALLOW(38):LEFTTRIM:LENGTHS(1):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_years:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_ip_address:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_source_code:SPACES( ):ALLOW(012):LEFTTRIM:LENGTHS(1,3):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_retail_price:SPACES( ):TYPE(NUMBERFIELD):LEFTTRIM:WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:inquiry_type:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:lex_id:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:reprice_batch_number:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:user_changed:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:date_changed:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:fcra_purpose:SPACES( ):ALLOW(01235):LEFTTRIM:LENGTHS(1,2):WORDS(1):ONFAIL(CLEAN)
FIELDTYPE:orig_address_2:SPACES( ):LIKE(WORDBAG):LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_city_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_state_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_zip_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_zip4_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_jobid:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(8,0):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_acctno:SPACES( ):LIKE(NUMBER):WORDS(1,0):ONFAIL(CLEAN)
FIELDTYPE:orig_end_user_name:SPACES( ):LIKE(NAME):LEFTTRIM:WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_end_user_address_1:SPACES( ):LIKE(WORDBAG):ONFAIL(CLEAN)
FIELDTYPE:orig_end_user_address_2:SPACES( ):ALLOW():LEFTTRIM:LENGTHS(0):WORDS(0):ONFAIL(CLEAN)
FIELDTYPE:orig_end_user_city:SPACES( ):LIKE(ALPHA):LEFTTRIM:WORDS(0,1,2):ONFAIL(CLEAN)
FIELDTYPE:orig_end_user_state:SPACES( ):LIKE(ALPHA):LEFTTRIM:LENGTHS(0,2):WORDS(0,1):ONFAIL(CLEAN)
FIELDTYPE:orig_end_user_zip:SPACES( ):LIKE(NUMBER):LEFTTRIM:LENGTHS(0,5):WORDS(0,1):ONFAIL(CLEAN)
 
FIELD:orig_end_user_id:LIKE(orig_end_user_id):TYPE(STRING):0,0
FIELD:orig_loginid:LIKE(orig_loginid):TYPE(STRING):0,0
FIELD:orig_billing_code:LIKE(orig_billing_code):TYPE(STRING):0,0
FIELD:orig_transaction_id:LIKE(orig_transaction_id):TYPE(STRING):0,0
FIELD:orig_transaction_type:LIKE(orig_transaction_type):TYPE(STRING):0,0
FIELD:orig_neighbors:LIKE(orig_neighbors):TYPE(STRING):0,0
FIELD:orig_relatives:LIKE(orig_relatives):TYPE(STRING):0,0
FIELD:orig_associates:LIKE(orig_associates):TYPE(STRING):0,0
FIELD:orig_property:LIKE(orig_property):TYPE(STRING):0,0
FIELD:orig_company_id:LIKE(orig_company_id):TYPE(STRING):0,0
FIELD:orig_reference_code:LIKE(orig_reference_code):TYPE(STRING):0,0
FIELD:orig_fname:LIKE(orig_fname):TYPE(STRING):0,0
FIELD:orig_mname:LIKE(orig_mname):TYPE(STRING):0,0
FIELD:orig_lname:LIKE(orig_lname):TYPE(STRING):0,0
FIELD:orig_address:LIKE(orig_address):TYPE(STRING):0,0
FIELD:orig_city:LIKE(orig_city):TYPE(STRING):0,0
FIELD:orig_state:LIKE(orig_state):TYPE(STRING):0,0
FIELD:orig_zip:LIKE(orig_zip):TYPE(STRING):0,0
FIELD:orig_zip4:LIKE(orig_zip4):TYPE(STRING):0,0
FIELD:orig_phone:LIKE(orig_phone):TYPE(STRING):0,0
FIELD:orig_ssn:LIKE(orig_ssn):TYPE(STRING):0,0
FIELD:orig_free:LIKE(orig_free):TYPE(STRING):0,0
FIELD:orig_record_count:LIKE(orig_record_count):TYPE(STRING):0,0
FIELD:orig_price:LIKE(orig_price):TYPE(STRING):0,0
FIELD:orig_bankruptcy:LIKE(orig_bankruptcy):TYPE(STRING):0,0
FIELD:orig_transaction_code:LIKE(orig_transaction_code):TYPE(STRING):0,0
FIELD:orig_dateadded:LIKE(orig_dateadded):TYPE(STRING):0,0
FIELD:orig_full_name:LIKE(orig_full_name):TYPE(STRING):0,0
FIELD:orig_billingdate:LIKE(orig_billingdate):TYPE(STRING):0,0
FIELD:orig_business_name:LIKE(orig_business_name):TYPE(STRING):0,0
FIELD:orig_pricing_error_code:LIKE(orig_pricing_error_code):TYPE(STRING):0,0
FIELD:orig_dl_purpose:LIKE(orig_dl_purpose):TYPE(STRING):0,0
FIELD:orig_result_format:LIKE(orig_result_format):TYPE(STRING):0,0
FIELD:orig_dob:LIKE(orig_dob):TYPE(STRING):0,0
FIELD:orig_unique_id:LIKE(orig_unique_id):TYPE(STRING):0,0
FIELD:orig_dls:LIKE(orig_dls):TYPE(STRING):0,0
FIELD:orig_mvs:LIKE(orig_mvs):TYPE(STRING):0,0
FIELD:orig_function_name:LIKE(orig_function_name):TYPE(STRING):0,0
FIELD:orig_response_time:LIKE(orig_response_time):TYPE(STRING):0,0
FIELD:orig_data_source:LIKE(orig_data_source):TYPE(STRING):0,0
FIELD:orig_glb_purpose:LIKE(orig_glb_purpose):TYPE(STRING):0,0
FIELD:orig_report_options:LIKE(orig_report_options):TYPE(STRING):0,0
FIELD:orig_unused:LIKE(orig_unused):TYPE(STRING):0,0
FIELD:orig_login_history_id:LIKE(orig_login_history_id):TYPE(STRING):0,0
FIELD:orig_aseid:LIKE(orig_aseid):TYPE(STRING):0,0
FIELD:orig_years:LIKE(orig_years):TYPE(STRING):0,0
FIELD:orig_ip_address:LIKE(orig_ip_address):TYPE(STRING):0,0
FIELD:orig_source_code:LIKE(orig_source_code):TYPE(STRING):0,0
FIELD:orig_retail_price:LIKE(orig_retail_price):TYPE(STRING):0,0
FIELD:inquiry_type:LIKE(inquiry_type):TYPE(STRING):0,0
FIELD:lex_id:LIKE(lex_id):TYPE(STRING):0,0
FIELD:reprice_batch_number:LIKE(reprice_batch_number):TYPE(STRING):0,0
FIELD:user_changed:LIKE(user_changed):TYPE(STRING):0,0
FIELD:date_changed:LIKE(date_changed):TYPE(STRING):0,0
FIELD:fcra_purpose:LIKE(fcra_purpose):TYPE(STRING):0,0
FIELD:orig_address_2:LIKE(orig_address_2):TYPE(STRING):0,0
FIELD:orig_city_2:LIKE(orig_city_2):TYPE(STRING):0,0
FIELD:orig_state_2:LIKE(orig_state_2):TYPE(STRING):0,0
FIELD:orig_zip_2:LIKE(orig_zip_2):TYPE(STRING):0,0
FIELD:orig_zip4_2:LIKE(orig_zip4_2):TYPE(STRING):0,0
FIELD:orig_jobid:LIKE(orig_jobid):TYPE(STRING):0,0
FIELD:orig_acctno:LIKE(orig_acctno):TYPE(STRING):0,0
FIELD:orig_end_user_name:LIKE(orig_end_user_name):TYPE(STRING):0,0
FIELD:orig_end_user_address_1:LIKE(orig_end_user_address_1):TYPE(STRING):0,0
FIELD:orig_end_user_address_2:LIKE(orig_end_user_address_2):TYPE(STRING):0,0
FIELD:orig_end_user_city:LIKE(orig_end_user_city):TYPE(STRING):0,0
FIELD:orig_end_user_state:LIKE(orig_end_user_state):TYPE(STRING):0,0
FIELD:orig_end_user_zip:LIKE(orig_end_user_zip):TYPE(STRING):0,0
 
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
 
