MODULE:Scrubs_Business_Credit
FILENAME:Business_Credit
NAMESCOPE:AB
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
//****

FIELDTYPE:invalid_segment_identifier:ENUM(AB|AB)
FIELDTYPE:invalid_file_segment_num:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_parent_sequence_number:ALLOW(0123456789):LENGTHS(1..)
FIELDTYPE:invalid_accholder_businessname:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.'-/#`+"!*@():;):LENGTHS(1..)
FIELDTYPE:invalid_dba:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,&.'-/#`+"!*@():;)
FIELDTYPE:invalid_comp_website:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789. /:-)
FIELDTYPE:invalid_legal_busi_structure:ENUM(001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|050|051|052|053|070|071|080|)
FIELDTYPE:invalid_busi_established_date:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_contractacc_num:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789- _):LENGTHS(1..)
FIELDTYPE:invalid_accounttypereported:ENUM(001|002|003|004|005|006|099)
FIELDTYPE:invalid_acc_status1:ENUM(001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|017|018|019|020|021|022|)
FIELDTYPE:invalid_acc_status2:ENUM(001|002|003|004|005|006|007|008|009|010|011|012|013|014|015|016|017|018|019|020|021|022|)
FIELDTYPE:invalid_dateaccopened:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_dateaccclosed:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_accountcloseurebasis:ENUM(V|X|F|B|P|O|)
FIELDTYPE:invalid_accexpirationdate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:invalid_lastactivitydate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_lastactivitytype:ALLOW(0123456789)
FIELDTYPE:invalid_recentactivityindicator:ENUM(Y|N|)
FIELDTYPE:invalid_origcreditlimit:ALLOW(0123456789)
FIELDTYPE:invalid_highestcreditused:ALLOW(0123456789)
FIELDTYPE:invalid_currentcreditlimit:ALLOW(0123456789-)
FIELDTYPE:invalid_reporterindicatorlength:ENUM(001|002|003|999|)
FIELDTYPE:invalid_paymentinterval:ENUM(A|Q|S|SA|SM|SP|BM|BW|D|M|W|)
FIELDTYPE:invalid_paymentstatuscategory:ENUM(000|001|002|003|004|005|006|007|)
FIELDTYPE:invalid_termofacc_months:ALLOW(0123456789)
FIELDTYPE:invalid_firstpymtduedate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:invalid_finalpymtduedate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:invalid_origrate:ALLOW(.0123456789)
FIELDTYPE:invalid_floatingrate:ALLOW(0123456789)
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
FIELDTYPE:invalid_balloonpymtduedate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:invalid_delinquencydate:ALLOW(0123456789):LENGTHS(8,6,4,0):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_daysdelinquent:ALLOW(0123456789)
FIELDTYPE:invalid_pastdueamt:ALLOW(0123456789-)
FIELDTYPE:invalid_maximum_num_bucket:ENUM(001|002|003|004|005|006|007|)
FIELDTYPE:invalid_past_due_aging_bucket_type:ALLOW(0123456789)
FIELDTYPE:invalid_past_due_aging_amount_bucket_1:ALLOW(0123456789-)
FIELDTYPE:invalid_past_due_aging_amount_bucket_2:ALLOW(0123456789-)
FIELDTYPE:invalid_past_due_aging_amount_bucket_3:ALLOW(0123456789-)
FIELDTYPE:invalid_past_due_aging_amount_bucket_4:ALLOW(0123456789-)
FIELDTYPE:invalid_past_due_aging_amount_bucket_5:ALLOW(0123456789-)
FIELDTYPE:invalid_past_due_aging_amount_bucket_6:ALLOW(0123456789-)
FIELDTYPE:invalid_past_due_aging_amount_bucket_7:ALLOW(0123456789-)
FIELDTYPE:invalid_maximum_num_tracking:ENUM(000|001|002|003|004|005|006|007|)
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


FIELD:segment_identifier:LIKE(invalid_segment_identifier):TYPE(STRING2):0,0
FIELD:file_sequence_number:LIKE(invalid_file_segment_num):TYPE(STRING12):0,0
FIELD:parent_sequence_number:LIKE(invalid_parent_sequence_number):TYPE(STRING12):0,0
FIELD:account_holder_business_name:LIKE(invalid_accholder_businessname):TYPE(STRING250):0,0
FIELD:dba:LIKE(invalid_dba):TYPE(STRING250):0,0
FIELD:company_website:LIKE(invalid_comp_website):TYPE(STRING250):0,0
FIELD:legal_business_structure:LIKE(invalid_legal_busi_structure):TYPE(STRING3):0,0
FIELD:business_established_date:LIKE(invalid_busi_established_date):TYPE(STRING8):0,0
FIELD:contract_account_number:LIKE(invalid_contractacc_num):TYPE(STRING50):0,0
FIELD:account_type_reported:LIKE(invalid_accounttypereported):TYPE(STRING3):0,0
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
FIELD:floating_rate:LIKE(invalid_floatingrate):TYPE(STRING10):0,0
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
FIELD:maximum_number_of_past_due_aging_amounts_buckets_provided:LIKE(invalid_maximum_num_bucket):TYPE(STRING3):0,0
FIELD:past_due_aging_bucket_type:LIKE(invalid_past_due_aging_bucket_type):TYPE(STRING3):0,0
FIELD:past_due_aging_amount_bucket_1:LIKE(invalid_past_due_aging_amount_bucket_1):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_2:LIKE(invalid_past_due_aging_amount_bucket_2):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_3:LIKE(invalid_past_due_aging_amount_bucket_3):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_4:LIKE(invalid_past_due_aging_amount_bucket_4):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_5:LIKE(invalid_past_due_aging_amount_bucket_5):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_6:LIKE(invalid_past_due_aging_amount_bucket_6):TYPE(STRING12):0,0
FIELD:past_due_aging_amount_bucket_7:LIKE(invalid_past_due_aging_amount_bucket_7):TYPE(STRING12):0,0
FIELD:maximum_number_of_payment_tracking_cycle_periods_provided:LIKE(invalid_maximum_num_tracking):TYPE(STRING3):0,0
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



//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
