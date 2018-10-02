﻿IMPORT SALT39,STD;
EXPORT Delta(DATASET(Layout_File)old_s, DATASET(Layout_File) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['orig_datetime_stamp','orig_global_company_id','orig_company_id','orig_product_cd','orig_method','orig_vertical','orig_function_name','orig_transaction_type','orig_login_history_id','orig_job_id','orig_sequence_number','orig_first_name','orig_middle_name','orig_last_name','orig_ssn','orig_dob','orig_dl_num','orig_dl_state','orig_address1_addressline1','orig_address1_addressline2','orig_address1_prim_range','orig_address1_predir','orig_address1_prim_name','orig_address1_suffix','orig_address1_postdir','orig_address1_unit_desig','orig_address1_sec_range','orig_address1_city','orig_address1_st','orig_address1_z5','orig_address1_z4','orig_address2_addressline1','orig_address2_addressline2','orig_address2_prim_range','orig_address2_predir','orig_address2_prim_name','orig_address2_suffix','orig_address2_postdir','orig_address2_unit_desig','orig_address2_sec_range','orig_address2_city','orig_address2_st','orig_address2_z5','orig_address2_z4','orig_bdid','orig_bdl','orig_did','orig_company_name','orig_fein','orig_phone','orig_work_phone','orig_company_phone','orig_reference_code','orig_ip_address_initiated','orig_ip_address_executed','orig_charter_number','orig_ucc_original_filing_number','orig_email_address','orig_domain_name','orig_full_name','orig_dl_purpose','orig_glb_purpose','orig_fcra_purpose','orig_process_id','orig_suffix_name','orig_former_last_name','orig_business_title','orig_company_addressline1','orig_company_addressline2','orig_company_address_prim_range','orig_company_address_predir','orig_company_address_prim_name','orig_company_address_suffix','orig_company_address_postdir','orig_company_address_unit_desig','orig_company_address_sec_range','orig_company_address_city','orig_company_address_st','orig_company_address_zip5','orig_company_address_zip4','orig_company_fax_number','orig_company_start_date','orig_company_years_in_business','orig_company_sic_code','orig_company_naic_code','orig_company_structure','orig_company_yearly_revenue','orig_subj2_first_name','orig_subj2_middle_name','orig_subj2_last_name','orig_subj2_suffix_name','orig_subj2_full_name','orig_subj2_ssn','orig_subj2_dob','orig_subj2_dl_num','orig_subj2_dl_state','orig_subj2_former_last_name','orig_subj2_address_addressline1','orig_subj2_address_addressline2','orig_subj2_address_prim_range','orig_subj2_address_predir','orig_subj2_address_prim_name','orig_subj2_address_suffix','orig_subj2_address_postdir','orig_subj2_address_unit_desig','orig_subj2_address_sec_range','orig_subj2_address_city','orig_subj2_address_st','orig_subj2_address_z5','orig_subj2_address_z4','orig_subj2_phone','orig_subj2_work_phone','orig_subj2_business_title','orig_subj3_first_name','orig_subj3_middle_name','orig_subj3_last_name','orig_subj3_suffix_name','orig_subj3_full_name','orig_subj3_ssn','orig_subj3_dob','orig_subj3_dl_num','orig_subj3_dl_state','orig_subj3_former_last_name','orig_subj3_address_addressline1','orig_subj3_address_addressline2','orig_subj3_address_prim_range','orig_subj3_address_predir','orig_subj3_address_prim_name','orig_subj3_address_suffix','orig_subj3_address_postdir','orig_subj3_address_unit_desig','orig_subj3_address_sec_range','orig_subj3_address_city','orig_subj3_address_st','orig_subj3_address_z5','orig_subj3_address_z4','orig_subj3_phone','orig_subj3_work_phone','orig_subj3_business_title','orig_email','orig_subj2_email','orig_subj2_company_name','orig_subj2_fein','orig_subj3_email','orig_subj3_company_name','orig_subj3_fein','orig_subj4_first_name','orig_subj4_middle_name','orig_subj4_last_name','orig_subj4_suffix_name','orig_subj4_full_name','orig_subj4_ssn','orig_subj4_dob','orig_subj4_dl_num','orig_subj4_dl_state','orig_subj4_former_last_name','orig_subj4_address_addressline1','orig_subj4_address_addressline2','orig_subj4_address_prim_range','orig_subj4_address_predir','orig_subj4_address_prim_name','orig_subj4_address_suffix','orig_subj4_address_postdir','orig_subj4_address_unit_desig','orig_subj4_address_sec_range','orig_subj4_address_city','orig_subj4_address_st','orig_subj4_address_z5','orig_subj4_address_z4','orig_subj4_phone','orig_subj4_work_phone','orig_subj4_business_title','orig_subj4_email','orig_subj4_company_name','orig_subj4_fein','orig_subj5_first_name','orig_subj5_middle_name','orig_subj5_last_name','orig_subj5_suffix_name','orig_subj5_full_name','orig_subj5_ssn','orig_subj5_dob','orig_subj5_dl_num','orig_subj5_dl_state','orig_subj5_former_last_name','orig_subj5_address_addressline1','orig_subj5_address_addressline2','orig_subj5_address_prim_range','orig_subj5_address_predir','orig_subj5_address_prim_name','orig_subj5_address_suffix','orig_subj5_address_postdir','orig_subj5_address_unit_desig','orig_subj5_address_sec_range','orig_subj5_address_city','orig_subj5_address_st','orig_subj5_address_z5','orig_subj5_address_z4','orig_subj5_phone','orig_subj5_work_phone','orig_subj5_business_title','orig_subj5_email','orig_subj5_company_name','orig_subj5_fein','orig_subj6_first_name','orig_subj6_middle_name','orig_subj6_last_name','orig_subj6_suffix_name','orig_subj6_full_name','orig_subj6_ssn','orig_subj6_dob','orig_subj6_dl_num','orig_subj6_dl_state','orig_subj6_former_last_name','orig_subj6_address_addressline1','orig_subj6_address_addressline2','orig_subj6_address_prim_range','orig_subj6_address_predir','orig_subj6_address_prim_name','orig_subj6_address_suffix','orig_subj6_address_postdir','orig_subj6_address_unit_desig','orig_subj6_address_sec_range','orig_subj6_address_city','orig_subj6_address_st','orig_subj6_address_z5','orig_subj6_address_z4','orig_subj6_phone','orig_subj6_work_phone','orig_subj6_business_title','orig_subj6_email','orig_subj6_company_name','orig_subj6_fein','orig_subj7_first_name','orig_subj7_middle_name','orig_subj7_last_name','orig_subj7_suffix_name','orig_subj7_full_name','orig_subj7_ssn','orig_subj7_dob','orig_subj7_dl_num','orig_subj7_dl_state','orig_subj7_former_last_name','orig_subj7_address_addressline1','orig_subj7_address_addressline2','orig_subj7_address_prim_range','orig_subj7_address_predir','orig_subj7_address_prim_name','orig_subj7_address_suffix','orig_subj7_address_postdir','orig_subj7_address_unit_desig','orig_subj7_address_sec_range','orig_subj7_address_city','orig_subj7_address_st','orig_subj7_address_z5','orig_subj7_address_z4','orig_subj7_phone','orig_subj7_work_phone','orig_subj7_business_title','orig_subj7_email','orig_subj7_company_name','orig_subj7_fein','orig_subj8_first_name','orig_subj8_middle_name','orig_subj8_last_name','orig_subj8_suffix_name','orig_subj8_full_name','orig_subj8_ssn','orig_subj8_dob','orig_subj8_dl_num','orig_subj8_dl_state','orig_subj8_former_last_name','orig_subj8_address_addressline1','orig_subj8_address_addressline2','orig_subj8_address_prim_range','orig_subj8_address_predir','orig_subj8_address_prim_name','orig_subj8_address_suffix','orig_subj8_address_postdir','orig_subj8_address_unit_desig','orig_subj8_address_sec_range','orig_subj8_address_city','orig_subj8_address_st','orig_subj8_address_z5','orig_subj8_address_z4','orig_subj8_phone','orig_subj8_work_phone','orig_subj8_business_title','orig_subj8_email','orig_subj8_company_name','orig_subj8_fein','orig_company_alternate_name'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_File, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_File, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Inql_Nfcra_Batch, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
