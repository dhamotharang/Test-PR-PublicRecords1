﻿Generated by SALT V3.11.6
Command line options: -MScrubs_BKForeclosure_Reo -eC:\Users\LuceroSD\AppData\Local\Temp\TFRDB12.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_BKForeclosure_Reo
FILENAME:BKForeclosure_Reo
 
FIELDTYPE:invalid_number:ALLOW(0123456789):
FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):SPACES( )
FIELDTYPE:invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'):SPACES( -.,)
FIELDTYPE:invalid_apn:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( ()-,'=&_.\/:*#~)
FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0,8,10)
FIELDTYPE:invalid_addr:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'):SPACES( <>{}[]-^=!+&,.()#/;:!")
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):LENGTHS(0,2)
FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(0,1,4,5)
FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'):SPACES( -,.()[]%;'*+\/"&#<>:!)
FIELDTYPE:invalid_document_code:CUSTOM(Scrubs_BKForeclosure_Reo.fn_valid_codes > 0,'DOCUMENT_TYPE') 
FIELDTYPE:invalid_property_code:CUSTOM(Scrubs_BKForeclosure_Reo.fn_valid_codes > 0,'PROPERTY_USE') 
FIELDTYPE:invalid_land_use_code:CUSTOM(Scrubs_BKForeclosure_Reo.fn_valid_codes > 0,'LAND_USE')
 
FIELD:foreclosure_id:TYPE(STRING70):0,0
FIELD:ln_filedate:LIKE(invalid_date):0,0
FIELD:bk_infile_type:TYPE(STRING30):0,0
FIELD:fips_cd:LIKE(invalid_number):0,0
FIELD:prop_full_addr:LIKE(invalid_addr):0,0
FIELD:prop_addr_city:LIKE(invalid_AlphaNum):0,0
FIELD:prop_addr_state:LIKE(invalid_state):0,0
FIELD:prop_addr_zip5:LIKE(invalid_zip):0,0
FIELD:prop_addr_zip4:LIKE(invalid_zip):0,0
FIELD:prop_addr_unit_type:TYPE(STRING4):0,0
FIELD:prop_addr_unit_no:TYPE(STRING11):0,0
FIELD:prop_addr_house_no:TYPE(STRING13):0,0
FIELD:prop_addr_predir:TYPE(STRING2):0,0
FIELD:prop_addr_street:TYPE(STRING40):0,0
FIELD:prop_addr_suffix:TYPE(STRING4):0,0
FIELD:prop_addr_postdir:TYPE(STRING2):0,0
FIELD:prop_addr_carrier_rt:TYPE(STRING4):0,0
FIELD:recording_date:LIKE(invalid_date):0,0
FIELD:recording_book_num:TYPE(STRING10):0,0
FIELD:recording_page_num:TYPE(STRING10):0,0
FIELD:recording_doc_num:TYPE(STRING20):0,0
FIELD:doc_type_cd:LIKE(invalid_document_code):0,0
FIELD:apn:LIKE(invalid_apn):0,0
FIELD:multi_apn:TYPE(STRING1):0,0
FIELD:partial_interest_trans:TYPE(STRING2):0,0
FIELD:seller1_fname:LIKE(invalid_name):0,0
FIELD:seller1_lname:LIKE(invalid_name):0,0
FIELD:seller1_id:TYPE(STRING2):0,0
FIELD:seller2_fname:LIKE(invalid_name):0,0
FIELD:seller2_lname:LIKE(invalid_name):0,0
FIELD:buyer1_fname:LIKE(invalid_name):0,0
FIELD:buyer1_lname:LIKE(invalid_name):0,0
FIELD:buyer1_id_cd:TYPE(STRING2):0,0
FIELD:buyer2_fname:LIKE(invalid_name):0,0
FIELD:buyer2_lname:LIKE(invalid_name):0,0
FIELD:buyer_vesting_cd:TYPE(STRING2):0,0
FIELD:concurrent_doc_num:TYPE(STRING19):0,0
FIELD:buyer_mail_city:LIKE(invalid_AlphaNum):0,0
FIELD:buyer_mail_state:LIKE(invalid_state):0,0
FIELD:buyer_mail_zip5:LIKE(invalid_zip):0,0
FIELD:buyer_mail_zip4:LIKE(invalid_zip):0,0
FIELD:legal_lot_cd:TYPE(STRING2):0,0
FIELD:legal_lot_num:TYPE(STRING10):0,0
FIELD:legal_block:TYPE(STRING7):0,0
FIELD:legal_section:TYPE(STRING7):0,0
FIELD:legal_district:TYPE(STRING7):0,0
FIELD:legal_land_lot:TYPE(STRING7):0,0
FIELD:legal_unit:TYPE(STRING6):0,0
FIELD:legacl_city:TYPE(STRING30):0,0
FIELD:legal_subdivision:TYPE(STRING50):0,0
FIELD:legal_phase_num:TYPE(STRING7):0,0
FIELD:legal_tract_num:TYPE(STRING10):0,0
FIELD:legal_brief_desc:TYPE(STRING100):0,0
FIELD:legal_township:TYPE(STRING30):0,0
FIELD:recorder_map_ref:TYPE(STRING20):0,0
FIELD:prop_buyer_mail_addr_cd:TYPE(STRING1):0,0
FIELD:property_use_cd:LIKE(invalid_property_code):0,0
FIELD:orig_contract_date:LIKE(invalid_date):0,0
FIELD:sales_price:TYPE(STRING10):0,0
FIELD:sales_price_cd:TYPE(STRING1):0,0
FIELD:city_xfer_tax:TYPE(STRING7):0,0
FIELD:county_xfer_tax:TYPE(STRING7):0,0
FIELD:total_xfer_tax:TYPE(STRING7):0,0
FIELD:concurrent_lender_name:TYPE(STRING40):0,0
FIELD:concurrent_lender_type:TYPE(STRING1):0,0
FIELD:concurrent_loan_amt:TYPE(STRING10):0,0
FIELD:concurrent_loan_type:TYPE(STRING1):0,0
FIELD:concurrent_type_fin:TYPE(STRING4):0,0
FIELD:concurrent_interest_rate:TYPE(STRING4):0,0
FIELD:concurrent_due_dt:LIKE(invalid_date):0,0
FIELD:concurrent_2nd_loan_amt:TYPE(STRING10):0,0
FIELD:buyer_mail_full_addr:LIKE(invalid_addr):0,0
FIELD:buyer_mail_unit_type:TYPE(STRING4):0,0
FIELD:buyer_mail_unit_no:TYPE(STRING11):0,0
FIELD:lps_internal_pid:TYPE(STRING10):0,0
FIELD:buyer_mail_careof:TYPE(STRING40):0,0
FIELD:title_co_name:TYPE(STRING28):0,0
FIELD:legal_desc_cd:TYPE(STRING1):0,0
FIELD:adj_rate_rider:TYPE(STRING1):0,0
FIELD:adj_rate_index:TYPE(STRING15):0,0
FIELD:change_index:TYPE(STRING4):0,0
FIELD:rate_change_freq:TYPE(STRING1):0,0
FIELD:int_rate_ngt:TYPE(STRING4):0,0
FIELD:int_rate_nlt:TYPE(STRING4):0,0
FIELD:max_int_rate:TYPE(STRING4):0,0
FIELD:int_only_period:TYPE(STRING2):0,0
FIELD:fixed_rate_rider:TYPE(STRING1):0,0
FIELD:first_chg_dt_yy:TYPE(STRING2):0,0
FIELD:first_chg_dt_mmdd:TYPE(STRING4):0,0
FIELD:prepayment_rider:TYPE(STRING1):0,0
FIELD:prepayment_term:TYPE(STRING2):0,0
FIELD:asses_land_use:LIKE(invalid_land_use_code):0,0
FIELD:res_indicator:TYPE(STRING1):0,0
FIELD:construction_loan:TYPE(STRING1):0,0
FIELD:inter_family:TYPE(STRING1):0,0
FIELD:cash_purchase:TYPE(STRING1):0,0
FIELD:stand_alone_refi:TYPE(STRING1):0,0
FIELD:equity_credit_line:TYPE(STRING1):0,0
FIELD:reo_flag:TYPE(STRING1):0,0
FIELD:distressedsaleflag:TYPE(STRING1):0,0
 
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
 
