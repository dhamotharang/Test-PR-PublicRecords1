MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:LinkID
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking

FIELDTYPE:invalid_process_date:ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrztuvwxyz)
FIELDTYPE:invalid_timestamp:ALLOW(0123456789)
FIELDTYPE:invalid_invalid_record_type:ALLOW(ABCDFHILMNPSTZ)
FIELDTYPE:invalid_did:ALLOW(0123456789)
FIELDTYPE:invalid_did_score:ALLOW(0123456789)
FIELDTYPE:invalid_dt_first_seen:ALLOW(0123456789)
FIELDTYPE:invalid_dt_last_seen:ALLOW(0123456789)
FIELDTYPE:invalid_dt_vendor_first_reported:ALLOW(0123456789)
FIELDTYPE:invalid_dt_vendor_last_reported:ALLOW(0123456789)
FIELDTYPE:invalid_dt_datawarehouse_first_reported:ALLOW(0123456789)
FIELDTYPE:invalid_dt_datawarehouse_last_reported:ALLOW(0123456789)
FIELDTYPE:invalid_sbfe_contributor_num:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _):LENGTHS(1..):CUSTOM(scrubs_business_credit.fn_invalid_SBFEContributorNum>0)
FIELDTYPE:invalid_contractacc_num:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _):LENGTHS(1..)
FIELDTYPE:invalid_extracted_date:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_cycleend_date:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_accholder_businessname:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.'-/#`+"!*@():;)
FIELDTYPE:invalid_cln_accholder_businessname:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.'-/#`+"!*@():;)
FIELDTYPE:invalid_dba:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.'-/#`+"!*@():;)
FIELDTYPE:invalid_cln_dba:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.'-/#`+"!*@():;)
FIELDTYPE:invalid_business_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.'-/#`+"!*@():;)
FIELDTYPE:invalid_cln_business_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.'-/#`+"!*@():;)
FIELDTYPE:invalid_comp_website:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789. /:-)
FIELDTYPE:invalid_first_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/')
FIELDTYPE:invalid_middle_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/')
FIELDTYPE:invalid_last_name:TYPE(STRING50):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/')
FIELDTYPE:invalid_suffix:TYPE(STRING5):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ.)
FIELDTYPE:invalid_e_mail_address:TYPE(STRING100):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@._-;)
FIELDTYPE:invalid_guarantor_owner_indicator:ENUM(001|002|003|01|02|03|1|2|3||)
FIELDTYPE:invalid_relationship_to_business_indicator:ALLOW(0123456789)
FIELDTYPE:invalid_business_title:TYPE(STRING150):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_cln_title:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/'):
FIELDTYPE:invalid_cln_fname:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/')
FIELDTYPE:invalid_cln_mname:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/'):
FIELDTYPE:invalid_cln_lname:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/')
FIELDTYPE:invalid_cln_suffix:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -/'):
FIELDTYPE:invalid_orig_address_line_1:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .:-#/',&#)
FIELDTYPE:invalid_orig_address_line_2:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 \':&-.#/,)
FIELDTYPE:invalid_orig_city:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ -.')
FIELDTYPE:invalid_orig_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_orig_zip_code_or_ca_postal_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_orig_postal_code:ALLOW(0123456789')
FIELDTYPE:invalid_orig_country_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_prim_range:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.')
FIELDTYPE:invalid_predir:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.')
FIELDTYPE:invalid_prim_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.')
FIELDTYPE:invalid_addr_suffix:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.')
FIELDTYPE:invalid_postdir:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.')
FIELDTYPE:invalid_unit_desig:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.')
FIELDTYPE:invalid_sec_range:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.')
FIELDTYPE:invalid_p_city_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.')
FIELDTYPE:invalid_v_city_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/ -.')
FIELDTYPE:invalid_st:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_zip:ALLOW(0123456789')
FIELDTYPE:invalid_zip4:ALLOW(0123456789')
//FIELDTYPE:invalid_cart:TYPE(STRING4):0,0
//FIELDTYPE:invalid_cr_sort_sz:TYPE(STRING1):0,0
//FIELDTYPE:invalid_lot:TYPE(STRING4):0,0
//FIELDTYPE:invalid_lot_order:TYPE(STRING1):0,0
//FIELDTYPE:invalid_dbpc:TYPE(STRING2):0,0
//FIELDTYPE:invalid_chk_digit:TYPE(STRING1):0,0
//FIELDTYPE:invalid_rec_type:TYPE(STRING2):0,0
//FIELDTYPE:invalid_fips_state:TYPE(STRING2):0,0
//FIELDTYPE:invalid_fips_county:TYPE(STRING3):0,0
//FIELDTYPE:invalid_geo_lat:TYPE(STRING10):0,0
//FIELDTYPE:invalid_geo_long:TYPE(STRING11):0,0
//FIELDTYPE:invalid_msa:TYPE(STRING4):0,0
//FIELDTYPE:invalid_geo_blk:TYPE(STRING7):0,0
//FIELDTYPE:invalid_geo_match:TYPE(STRING1):0,0
//FIELDTYPE:invalid_err_stat:TYPE(STRING4):0,0
//FIELDTYPE:invalid_rawaid:TYPE(UNSIGNED8):0,0
FIELDTYPE:invalid_orig_area_code:ALLOW(0123456789 )
FIELDTYPE:invalid_orig_telephone_number:ALLOW(0123456789)
FIELDTYPE:invalid_telephone_extension:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 )
FIELDTYPE:invalid_primary_telephone_indicator:ENUM(Y|N|)
FIELDTYPE:invalid_published_unlisted_indicator:ENUM(001|002|)
FIELDTYPE:invalid_phonetype:ENUM(001|002|003|004|)
FIELDTYPE:invalid_phonenumber:ALLOW(0123456789 )
FIELDTYPE:invalid_federal_tax_id_ssn:ALLOW(0123456789X)
FIELDTYPE:invalid_federal_tax_id_ssn_identifier:ENUM(001|002|)
FIELDTYPE:invalid_dotid:ALLOW(0123456789)
FIELDTYPE:invalid_dotscore:ALLOW(0123456789)
FIELDTYPE:invalid_dotweight:ALLOW(0123456789)
FIELDTYPE:invalid_empid:ALLOW(0123456789)
FIELDTYPE:invalid_empscore:ALLOW(0123456789)
FIELDTYPE:invalid_empweight:ALLOW(0123456789)
FIELDTYPE:invalid_powid:ALLOW(0123456789)
FIELDTYPE:invalid_powscore:ALLOW(0123456789)
FIELDTYPE:invalid_powweight:ALLOW(0123456789)
FIELDTYPE:invalid_proxid:ALLOW(0123456789)
FIELDTYPE:invalid_proxscore:ALLOW(0123456789)
FIELDTYPE:invalid_proxweight:ALLOW(0123456789)
FIELDTYPE:invalid_seleid:ALLOW(0123456789)
FIELDTYPE:invalid_selescore:ALLOW(0123456789)
FIELDTYPE:invalid_seleweight:ALLOW(0123456789)
FIELDTYPE:invalid_orgid:ALLOW(0123456789)
FIELDTYPE:invalid_orgscore:ALLOW(0123456789)
FIELDTYPE:invalid_orgweight:ALLOW(0123456789)
FIELDTYPE:invalid_ultid:ALLOW(0123456789)
FIELDTYPE:invalid_ultscore:ALLOW(0123456789)
FIELDTYPE:invalid_ultweight:ALLOW(0123456789)
FIELDTYPE:invalid_sbfe_id:ALLOW(0123456789)
//FIELDTYPE:invalid_source:TYPE(STRING2):0,0
//FIELDTYPE:invalid_active:TYPE(BOOLEAN1):0,0
FIELDTYPE:invalid_legal_busi_structure:ENUM(001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|050|051|052|053|070|071|080|)
FIELDTYPE:invalid_busi_established_date:ALLOW(0123456789):LENGTHS(8,6,4,0)
FIELDTYPE:invalid_accounttypereported:ENUM(001|002|003|004|005|006|099)
FIELDTYPE:invalid_acc_status1:ENUM(001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|017|018|019|020|021|022|)
FIELDTYPE:invalid_acc_status2:ENUM(001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|017|018|019|020|021|022|)
FIELDTYPE:invalid_dateaccopened:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_dateaccclosed:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_accountcloseurebasis:ENUM(V|X|F|B|P|O|)
FIELDTYPE:invalid_accexpirationdate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0,'F')
FIELDTYPE:invalid_lastactivitydate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_lastactivitytype:ALLOW(0123456789)
FIELDTYPE:invalid_recentactivityindicator:ENUM(Y|N|)
FIELDTYPE:invalid_origcreditlimit:ALLOW(0123456789)
FIELDTYPE:invalid_highestcreditused:ALLOW(0123456789)
FIELDTYPE:invalid_currentcreditlimit:ALLOW(0123456789-)
FIELDTYPE:invalid_reporterindicatorlength:ENUM(001|002|003|999|)
FIELDTYPE:invalid_paymentinterval:ENUM(A|Q|S|SA|SM|SP|BM|BW|D|M|W|)
FIELDTYPE:invalid_paymentstatuscategory:ENUM(000|001|002|003|004|005|006|007|00|01|02|03|04|05|06|07|0|1|2|3|4|5|6|7|)
FIELDTYPE:invalid_termofacc_months:ALLOW(0123456789)
FIELDTYPE:invalid_firstpymtduedate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0,'F')
FIELDTYPE:invalid_finalpymtduedate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0,'F')
FIELDTYPE:invalid_origrate:ALLOW(0123456789.)
FIELDTYPE:invalid_graceperiod:ALLOW(0123456789)
FIELDTYPE:invalid_paymentcategory:ENUM(001|002|003|004|005|006|007|008|009|099|)
FIELDTYPE:invalid_pymthistprofile12:ALLOW(0123456LBDEGHJK)
FIELDTYPE:invalid_pymthistprofile13_24:ALLOW(0123456LBDEGHJK)
FIELDTYPE:invalid_pymthistprofile25_36:ALLOW(0123456LBDEGHJK)
FIELDTYPE:invalid_pymthistprofile37_48:ALLOW(0123456LBDEGHJK)
FIELDTYPE:invalid_pymthistlength:ALLOW(0123456789)
FIELDTYPE:invalid_ytd_purchasescount:ALLOW(0123456789)
FIELDTYPE:invalid_ltd_purchasescount:ALLOW(0123456789)
FIELDTYPE:invalid_ytd_purchasessumamt:ALLOW(0123456789)
FIELDTYPE:invalid_ltd_purchasessumamt:ALLOW(0123456789)
FIELDTYPE:invalid_pymtamtscheduled:ALLOW(0123456789)
FIELDTYPE:invalid_recentpymtamt:ALLOW(0123456789-)
FIELDTYPE:invalid_recentpaymentdate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_remainingbalance:ALLOW(0123456789-)
FIELDTYPE:invalid_carriedoveramt:ALLOW(0123456789-)
FIELDTYPE:invalid_newappliedcharges:ALLOW(0123456789)
FIELDTYPE:invalid_balloonpymtdue:ALLOW(0123456789)
FIELDTYPE:invalid_balloonpymtduedate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0,'F')
FIELDTYPE:invalid_delinquencydate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_daysdelinquent:ALLOW(0123456789)
FIELDTYPE:invalid_pastdueamt:ALLOW(0123456789-)
FIELDTYPE:invalid_maximum_number_bucket:ENUM(001|002|003|004|005|006|007|)
FIELDTYPE:invalid_past_due_aging_bucket_type:ALLOW(0123456789)
FIELDTYPE:invalid_past_due_aging_amount_bucket:ALLOW(0123456789-)
FIELDTYPE:invalid_maximum_number_tracking:ENUM(000|001|002|003|004|005|006|007|)
FIELDTYPE:invalid_payment_tracking_cycle_type:ALLOW(0123456789)
FIELDTYPE:invalid_num:ALLOW(0123456789)
FIELDTYPE:invalid_date_account_was_charged_off:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_amount_charged_off_by_creditor:ALLOW(0123456789)
FIELDTYPE:invalid_charge_off_type_indicator:ENUM(001|002|003|)
FIELDTYPE:invalid_total_charge_off_recoveries_to_date:ALLOW(0123456789-)
FIELDTYPE:invalid_government_guarantee_flag:ENUM(Y|N|)
FIELDTYPE:invalid_government_guarantee_category:ENUM(001|002|003|004|005|006|007|100|200|300|400|500|600|700|800|810|)
FIELDTYPE:invalid_guarantors_indicator:ENUM(Y|N|)
FIELDTYPE:invalid_number_of_guarantors:ALLOW(0123456789)
FIELDTYPE:invalid_owners_indicator:ENUM(Y|N|)
FIELDTYPE:invalid_number_of_principals:ALLOW(0123456789)
FIELDTYPE:invalid_account_update_deletion_indicator:ENUM(000|001|002|003|080|090|0||)
FIELDTYPE:invalid_percent:ALLOW(0123456789)


FIELD:timestamp:LIKE(invalid_timestamp):TYPE(STRING12):0,0
FIELD:process_date:LIKE(invalid_process_date):TYPE(STRING8):0,0
FIELD:record_type:LIKE(invalid_invalid_record_type):TYPE(STRING2):0,0
FIELD:did:LIKE(invalid_did):TYPE(UNSIGNED6):0,0
FIELD:did_score:LIKE(invalid_did_score):TYPE(UNSIGNED1):0,0
FIELD:dt_first_seen:LIKE(invalid_dt_first_seen):TYPE(UNSIGNED4):0,0
FIELD:dt_last_seen:LIKE(invalid_dt_last_seen):TYPE(UNSIGNED4):0,0
FIELD:dt_vendor_first_reported:LIKE(invalid_dt_vendor_first_reported):TYPE(UNSIGNED4):0,0
FIELD:dt_vendor_last_reported:LIKE(invalid_dt_vendor_last_reported):TYPE(UNSIGNED4):0,0
FIELD:dt_datawarehouse_first_reported:LIKE(invalid_dt_datawarehouse_first_reported):TYPE(UNSIGNED4):0,0
FIELD:dt_datawarehouse_last_reported:LIKE(invalid_dt_datawarehouse_last_reported):TYPE(UNSIGNED4):0,0
FIELD:sbfe_contributor_number:LIKE(invalid_sbfe_contributor_num):TYPE(STRING30):0,0
FIELD:contract_account_number:LIKE(invalid_contractacc_num):TYPE(STRING50):0,0
FIELD:account_type_reported:TYPE(STRING3):0,0
FIELD:extracted_date:LIKE(invalid_extracted_date):TYPE(STRING8):0,0
FIELD:cycle_end_date:LIKE(invalid_cycleend_date):TYPE(STRING8):0,0
FIELD:account_holder_business_name:LIKE(invalid_accholder_businessname):TYPE(STRING250):0,0
FIELD:clean_account_holder_business_name:LIKE(invalid_cln_accholder_businessname):TYPE(STRING250):0,0
FIELD:dba:LIKE(invalid_dba):TYPE(STRING250):0,0
FIELD:clean_dba:LIKE(invalid_cln_dba):TYPE(STRING250):0,0
FIELD:business_name:LIKE(invalid_business_name):TYPE(STRING250):0,0
FIELD:clean_business_name:LIKE(invalid_cln_business_name):TYPE(STRING250):0,0
FIELD:company_website:LIKE(invalid_comp_website):TYPE(STRING250):0,0
FIELD:original_fname:LIKE(invalid_first_name):TYPE(STRING50):0,0
FIELD:original_mname:LIKE(invalid_middle_name):TYPE(STRING50):0,0
FIELD:original_lname:LIKE(invalid_last_name):TYPE(STRING50):0,0
FIELD:original_suffix:LIKE(invalid_suffix):TYPE(STRING5):0,0
FIELD:e_mail_address:LIKE(invalid_e_mail_address):TYPE(STRING100):0,0
FIELD:guarantor_owner_indicator:LIKE(invalid_guarantor_owner_indicator):TYPE(STRING3):0,0
FIELD:relationship_to_business_indicator:LIKE(invalid_relationship_to_business_indicator):TYPE(STRING3):0,0
FIELD:business_title:LIKE(invalid_business_title):TYPE(STRING150):0,0
FIELD:clean_title:LIKE(invalid_cln_title):TYPE(STRING5):0,0
FIELD:clean_fname:LIKE(invalid_cln_fname):TYPE(STRING20):0,0
FIELD:clean_mname:LIKE(invalid_cln_mname):TYPE(STRING20):0,0
FIELD:clean_lname:LIKE(invalid_cln_lname):TYPE(STRING20):0,0
FIELD:clean_suffix:LIKE(invalid_cln_suffix):TYPE(STRING5):0,0
FIELD:original_address_line_1:LIKE(invalid_orig_address_line_1):TYPE(STRING100):0,0
FIELD:original_address_line_2:LIKE(invalid_orig_address_line_2):TYPE(STRING100):0,0
FIELD:original_city:LIKE(invalid_orig_city):TYPE(STRING50):0,0
FIELD:original_state:LIKE(invalid_orig_state):TYPE(STRING2):0,0
FIELD:original_zip_code_or_ca_postal_code:LIKE(invalid_orig_zip_code_or_ca_postal_code):TYPE(STRING6):0,0
FIELD:original_postal_code:LIKE(invalid_orig_postal_code):TYPE(STRING4):0,0
FIELD:original_country_code:LIKE(invalid_orig_country_code):TYPE(STRING2):0,0
FIELD:prim_range:LIKE(invalid_prim_range):TYPE(STRING10):0,0
FIELD:predir:LIKE(invalid_predir):TYPE(STRING2):0,0
FIELD:prim_name:LIKE(invalid_prim_name):TYPE(STRING28):0,0
FIELD:addr_suffix:LIKE(invalid_addr_suffix):TYPE(STRING4):0,0
FIELD:postdir:LIKE(invalid_postdir):TYPE(STRING2):0,0
FIELD:unit_desig:LIKE(invalid_unit_desig):TYPE(STRING10):0,0
FIELD:sec_range:LIKE(invalid_sec_range):TYPE(STRING8):0,0
FIELD:p_city_name:LIKE(invalid_p_city_name):TYPE(STRING25):0,0
FIELD:v_city_name:LIKE(invalid_v_city_name):TYPE(STRING25):0,0
FIELD:st:LIKE(invalid_st):TYPE(STRING2):0,0
FIELD:zip:LIKE(invalid_zip):TYPE(STRING5):0,0
FIELD:zip4:LIKE(invalid_zip4):TYPE(STRING4):0,0
FIELD:cart:TYPE(STRING4):0,0:
FIELD:cr_sort_sz:TYPE(STRING1):0,0:
FIELD:lot:TYPE(STRING4):0,0:
FIELD:lot_order:TYPE(STRING1):0,0:
FIELD:dbpc:TYPE(STRING2):0,0:
FIELD:chk_digit:TYPE(STRING1):0,0:
FIELD:rec_type:TYPE(STRING2):0,0:
FIELD:fips_state:TYPE(STRING2):0,0:
FIELD:fips_county:TYPE(STRING3):0,0:
FIELD:geo_lat:TYPE(STRING10):0,0:
FIELD:geo_long:TYPE(STRING11):0,0:
FIELD:msa:TYPE(STRING4):0,0:
FIELD:geo_blk:TYPE(STRING7):0,0:
FIELD:geo_match:TYPE(STRING1):0,0:
FIELD:err_stat:TYPE(STRING4):0,0:
FIELD:rawaid:TYPE(UNSIGNED8):0,0:
FIELD:original_area_code:LIKE(invalid_orig_area_code):TYPE(STRING3):0,0
FIELD:original_phone_number:LIKE(invalid_orig_telephone_number):TYPE(STRING7):0,0
FIELD:phone_extension:LIKE(invalid_telephone_extension):TYPE(STRING10):0,0
FIELD:primary_phone_indicator:LIKE(invalid_primary_telephone_indicator):TYPE(STRING1):0,0
FIELD:published_unlisted_indicator:LIKE(invalid_published_unlisted_indicator):TYPE(STRING3):0,0
FIELD:phone_type:LIKE(invalid_phonetype):TYPE(STRING3):0,0
FIELD:phone_number:LIKE(invalid_phonenumber):TYPE(STRING10):0,0
FIELD:federal_taxid_ssn:LIKE(invalid_federal_tax_id_ssn):TYPE(STRING9):0,0
FIELD:federal_taxid_ssn_identifier:LIKE(invalid_federal_tax_id_ssn_identifier):TYPE(STRING3):0,0
FIELD:dotid:LIKE(invalid_dotid):TYPE(UNSIGNED6):0,0
FIELD:dotscore:LIKE(invalid_dotscore):TYPE(UNSIGNED2):0,0
FIELD:dotweight:LIKE(invalid_dotweight):TYPE(UNSIGNED2):0,0
FIELD:empid:LIKE(invalid_empid):TYPE(UNSIGNED6):0,0
FIELD:empscore:LIKE(invalid_empscore):TYPE(UNSIGNED2):0,0
FIELD:empweight:LIKE(invalid_empweight):TYPE(UNSIGNED2):0,0
FIELD:powid:LIKE(invalid_powid):TYPE(UNSIGNED6):0,0
FIELD:powscore:LIKE(invalid_powscore):TYPE(UNSIGNED2):0,0
FIELD:powweight:LIKE(invalid_powweight):TYPE(UNSIGNED2):0,0
FIELD:proxid:LIKE(invalid_proxid):TYPE(UNSIGNED6):0,0
FIELD:proxscore:LIKE(invalid_proxscore):TYPE(UNSIGNED2):0,0
FIELD:proxweight:LIKE(invalid_proxweight):TYPE(UNSIGNED2):0,0
FIELD:seleid:LIKE(invalid_seleid):TYPE(UNSIGNED6):0,0
FIELD:selescore:LIKE(invalid_selescore):TYPE(UNSIGNED2):0,0
FIELD:seleweight:LIKE(invalid_seleweight):TYPE(UNSIGNED2):0,0
FIELD:orgid:LIKE(invalid_orgid):TYPE(UNSIGNED6):0,0
FIELD:orgscore:LIKE(invalid_orgscore):TYPE(UNSIGNED2):0,0
FIELD:orgweight:LIKE(invalid_orgweight):TYPE(UNSIGNED2):0,0
FIELD:ultid:LIKE(invalid_ultid):TYPE(UNSIGNED6):0,0
FIELD:ultscore:LIKE(invalid_ultscore):TYPE(UNSIGNED2):0,0
FIELD:ultweight:LIKE(invalid_ultweight):TYPE(UNSIGNED2):0,0
FIELD:persistent_record_id:TYPE(UNSIGNED8):0,0
FIELD:sbfe_id:LIKE(invalid_sbfe_id):TYPE(UNSIGNED8):0,0
FIELD:source:TYPE(STRING2):0,0:
FIELD:active:TYPE(BOOLEAN1):0,0:
FIELD:legal_business_structure:LIKE(invalid_legal_busi_structure):TYPE(STRING3):0,0
FIELD:business_established_date:LIKE(invalid_busi_established_date):TYPE(STRING8):0,0
FIELD:account_status_1:LIKE(invalid_acc_status1):TYPE(STRING3):0,0
FIELD:account_status_2:LIKE(invalid_acc_status2):TYPE(STRING3):0,0
FIELD:date_account_opened:LIKE(invalid_dateaccopened):TYPE(STRING8):0,0
FIELD:date_account_closed:LIKE(invalid_dateaccclosed):TYPE(STRING8):0,0
FIELD:account_closure_basis:LIKE(invalid_accountcloseurebasis):TYPE(STRING2):0,0
FIELD:account_expiration_date:LIKE(invalid_accexpirationdate):TYPE(STRING8):0,0
FIELD:last_activity_date:LIKE(invalid_lastactivitydate):TYPE(STRING8):0,0
FIELD:last_activity_type:LIKE(invalid_lastactivitytype):TYPE(STRING3):0,0
FIELD:recent_activity_indicator:LIKE(invalid_recentactivityindicator):TYPE(STRING1):0,0
FIELD:original_credit_limit:LIKE(invalid_origcreditlimit):TYPE(STRING12):0,0
FIELD:highest_credit_used:LIKE(invalid_highestcreditused):TYPE(STRING12):0,0
FIELD:current_credit_limit:LIKE(invalid_currentcreditlimit):TYPE(STRING12):0,0
FIELD:reporting_indicator_length:LIKE(invalid_reporterindicatorlength):TYPE(STRING3):0,0
FIELD:payment_interval:LIKE(invalid_paymentinterval):TYPE(STRING2):0,0
FIELD:payment_status_category:LIKE(invalid_paymentstatuscategory):TYPE(STRING3):0,0
FIELD:term_of_account_in_months:LIKE(invalid_termofacc_months):TYPE(STRING3):0,0
FIELD:first_payment_due_date:LIKE(invalid_firstpymtduedate):TYPE(STRING8):0,0
FIELD:final_payment_due_date:LIKE(invalid_finalpymtduedate):TYPE(STRING8):0,0
FIELD:original_rate:LIKE(invalid_origrate):TYPE(STRING10):0,0
FIELD:floating_rate:LIKE(invalid_origrate):TYPE(STRING10):0,0::
FIELD:grace_period:LIKE(invalid_graceperiod):TYPE(STRING4):0,0
FIELD:payment_category:LIKE(invalid_paymentcategory):TYPE(STRING3):0,0
FIELD:payment_history_profile_12_months:LIKE(invalid_pymthistprofile12):TYPE(STRING12):0,0
FIELD:payment_history_profile_13_24_months:LIKE(invalid_pymthistprofile13_24):TYPE(STRING12):0,0
FIELD:payment_history_profile_25_36_months:LIKE(invalid_pymthistprofile25_36):TYPE(STRING12):0,0
FIELD:payment_history_profile_37_48_months:LIKE(invalid_pymthistprofile37_48):TYPE(STRING12):0,0
FIELD:payment_history_length:LIKE(invalid_pymthistlength):TYPE(STRING4):0,0
FIELD:year_to_date_purchases_count:LIKE(invalid_ytd_purchasescount):TYPE(STRING12):0,0
FIELD:lifetime_to_date_purchases_count:LIKE(invalid_ltd_purchasescount):TYPE(STRING12):0,0
FIELD:year_to_date_purchases_sum_amount:LIKE(invalid_ytd_purchasessumamt):TYPE(STRING20):0,0
FIELD:lifetime_to_date_purchases_sum_amount:LIKE(invalid_ltd_purchasessumamt):TYPE(STRING20):0,0
FIELD:payment_amount_scheduled:LIKE(invalid_pymtamtscheduled):TYPE(STRING12):0,0
FIELD:recent_payment_amount:LIKE(invalid_recentpymtamt):TYPE(STRING12):0,0
FIELD:recent_payment_date:LIKE(invalid_recentpaymentdate):TYPE(STRING8):0,0
FIELD:remaining_balance:LIKE(invalid_remainingbalance):TYPE(STRING12):0,0
FIELD:carried_over_amount:LIKE(invalid_carriedoveramt):TYPE(STRING12):0,0
FIELD:new_applied_charges:LIKE(invalid_newappliedcharges):TYPE(STRING12):0,0
FIELD:balloon_payment_due:LIKE(invalid_balloonpymtdue):TYPE(STRING12):0,0
FIELD:balloon_payment_due_date:LIKE(invalid_balloonpymtduedate):TYPE(STRING8):0,0
FIELD:delinquency_date:LIKE(invalid_delinquencydate):TYPE(STRING8):0,0
FIELD:days_delinquent:LIKE(invalid_daysdelinquent):TYPE(STRING8):0,0
FIELD:past_due_amount:LIKE(invalid_pastdueamt):TYPE(STRING12):0,0
FIELD:maximum_number_of_past_due_aging_amounts_buckets_provided:LIKE(invalid_maximum_number_bucket):TYPE(STRING3):0,0
FIELD:past_due_aging_bucket_type:LIKE(invalid_past_due_aging_bucket_type):TYPE(STRING3):0,0
FIELD:past_due_aging_amount_bucket_1:LIKE(invalid_past_due_aging_amount_bucket):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_2:LIKE(invalid_past_due_aging_amount_bucket):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_3:LIKE(invalid_past_due_aging_amount_bucket):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_4:LIKE(invalid_past_due_aging_amount_bucket):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_5:LIKE(invalid_past_due_aging_amount_bucket):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_6:LIKE(invalid_past_due_aging_amount_bucket):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_7:LIKE(invalid_past_due_aging_amount_bucket):TYPE(STRING12):0,0
FIELD:maximum_number_of_payment_tracking_cycle_periods_provided:LIKE(invalid_maximum_number_tracking):TYPE(STRING3):0,0
FIELD:payment_tracking_cycle_type:LIKE(invalid_payment_tracking_cycle_type):TYPE(STRING3):0,0
FIELD:payment_tracking_cycle_0_current:LIKE(invalid_num):TYPE(STRING4):0,0
FIELD:payment_tracking_cycle_1_1_to_30_days:LIKE(invalid_num):TYPE(STRING4):0,0
FIELD:payment_tracking_cycle_2_31_to_60_days:LIKE(invalid_num):TYPE(STRING4):0,0
FIELD:payment_tracking_cycle_3_61_to_90_days:LIKE(invalid_num):TYPE(STRING4):0,0
FIELD:payment_tracking_cycle_4_91_to_120_days:LIKE(invalid_num):TYPE(STRING4):0,0
FIELD:payment_tracking_cycle_5_121_to_150days:LIKE(invalid_num):TYPE(STRING4):0,0
FIELD:payment_tracking_number_of_times_cycle_6_151_to_180_days:LIKE(invalid_num):TYPE(STRING4):0,0
FIELD:payment_tracking_number_of_times_cycle_7_181_or_greater_days:LIKE(invalid_num):TYPE(STRING4):0,0
FIELD:date_account_was_charged_off:LIKE(invalid_date_account_was_charged_off):TYPE(STRING8):0,0
FIELD:amount_charged_off_by_creditor:LIKE(invalid_amount_charged_off_by_creditor):TYPE(STRING12):0,0
FIELD:charge_off_type_indicator:LIKE(invalid_charge_off_type_indicator):TYPE(STRING3):0,0
FIELD:total_charge_off_recoveries_to_date:LIKE(invalid_total_charge_off_recoveries_to_date):TYPE(STRING12):0,0
FIELD:government_guarantee_flag:LIKE(invalid_government_guarantee_flag):TYPE(STRING1):0,0
FIELD:government_guarantee_category:LIKE(invalid_government_guarantee_category):TYPE(STRING3):0,0
FIELD:portion_of_account_guaranteed_by_government:LIKE(invalid_num):TYPE(STRING3):0,0
FIELD:guarantors_indicator:LIKE(invalid_guarantors_indicator):TYPE(STRING1):0,0
FIELD:number_of_guarantors:LIKE(invalid_number_of_guarantors):TYPE(STRING2):0,0
FIELD:owners_indicator:LIKE(invalid_owners_indicator):TYPE(STRING1):0,0
FIELD:number_of_principals:LIKE(invalid_number_of_principals):TYPE(STRING2):0,0
FIELD:account_update_deletion_indicator:LIKE(invalid_account_update_deletion_indicator):TYPE(STRING3):0,0
FIELD:percent_of_liability:LIKE(invalid_percent):TYPE(STRING3):0,0
FIELD:percent_of_ownership:LIKE(invalid_percent):TYPE(STRING3):0,0

//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
