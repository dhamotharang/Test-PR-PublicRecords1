
// EXPORT Phone_Shell_Tracking_Report := 'todo';
import zz_bbraaten2;

import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking,ut,sghatti,Gateway, Scoring_Project_ISS,Phone_Shell,Risk_Indicators,Business_Risk_BIP,Models;

eyeball := 10;
input_layout := Record
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus - Raw_Input - Clean_Input - Clam Phone_Shell;
	Risk_Indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements - bk_chapters Boca_Shell;
END;


   	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);

	a1:= a +'_1';
	b1:= b +'_1';
	// b1:= '20180817'+'_1';

model := 'COLLECTIONSCORE_V3';
model2 := 'PHONESCORE_V2';
ds_base := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ b1, input_layout, thor);
ds_test := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ a1, input_layout, thor);


da_newlay := record
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus - Raw_Input - Clean_Input - Clam Phone_Shell;
end;


mod_lay := record
	string hashtag;
	da_newlay;
end;

ds_mode_base := project(ds_base, transform(mod_lay, self.hashtag := trim(left.phone_shell.input_echo.acctno, left, right) + trim(left.phone_shell.gathered_phone, left, right); self := left));
ds_mod_test := project(ds_test, transform(mod_lay, self.hashtag := trim(left.phone_shell.input_echo.acctno, left, right) + trim(left.phone_shell.gathered_phone, left, right); self := left));

output(choosen(ds_mode_base, 10), named('ds_mode_base'));
count(ds_mode_base);				

output(choosen(ds_mod_test, 10), named('ds_mod_test'));
count(ds_mod_test);			

// outfile_name := '~bbraaten::phoneshell_flat';

ashirey.flatten(ds_mode_base,clean_ds_1_flat);
ashirey.flatten(ds_mod_test,clean_ds_2_flat);

output(choosen(clean_ds_1_flat, 10), named('clean_ds_1_flat'));
count(clean_ds_1_flat);				

output(choosen(clean_ds_2_flat, 10), named('clean_ds_2_flat'));
count(clean_ds_2_flat);			

ds_file_size := count(clean_ds_1_flat);


da_new := choosen(clean_ds_1_flat, ds_file_size);//without this line you will get mp link closed errors.. not sure why but this seems to fix the issue.

//must be flat.
DATASET groupbin :=
 zz_bbraaten2.Stats_Macro(da_new, 'hashtag')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__bureau__bureau_last_update')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__bureau__bureau_verified')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__did')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_address_match_best')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_avg_days_connected_indiv')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_avg_days_interrupt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_bdid')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_current_record_flag')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_days_in_service')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_days_indiv_first_seen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_days_indiv_first_seen_with_phone')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_days_phone_first_seen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_deletion_date')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_did')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_did_count')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_disc_cnt12')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_disc_cnt18')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_disc_cnt6')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_dt_first_seen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_dt_last_seen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_has_cur_discon_15_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_has_cur_discon_180_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_has_cur_discon_30_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_has_cur_discon_360_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_has_cur_discon_60_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_has_cur_discon_90_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_hhid')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_is_current_in_hist')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_is_discon_15_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_is_discon_180_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_is_discon_30_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_is_discon_360_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_is_discon_60_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_is_discon_90_days')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_listing_name')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_max_days_connected_indiv')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_max_days_interrupt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_min_days_connected_indiv')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_min_days_interrupt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_months_addr_last_seen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_interrupts_cur')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_phone_owners_cur')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_phone_owners_hist')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_phones_connected_addr')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_phones_connected_hhid')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_phones_connected_indiv')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_phones_discon_addr')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_phones_discon_hhid')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_phones_discon_indiv')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_num_phones_indiv')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_omit_locality')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__eda_characteristics__eda_pfrd_address_ind')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__experian_file_one_verification__experian_last_update')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__experian_file_one_verification__experian_phone_score_v1')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__experian_file_one_verification__experian_source')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__experian_file_one_verification__experian_type')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__experian_file_one_verification__experian_verified')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__gathered_phone')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__acctno')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_burea_enabled')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_city')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_dob')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_expgw_enabled')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_fname')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_insgw_enabled')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_lname')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_mname')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_phone10')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_processing_date')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_sname')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_ssn')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_state')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_streetaddress')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_targusgw_enabled')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_tugw_enabled')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_wphone10')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__in_zipcode')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__lexid')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__input_echo__seq')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_adl_firstseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_adl_lastseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_adl_phone_industry_list_12')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_firstseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_lastseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_num')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_num_06')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_num_addresses')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_num_addresses_06')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_num_adls')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__inquiries__inq_num_adls_06')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__internal_corroboration__internal_verification')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__internal_corroboration__internal_verification_first_seen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__internal_corroboration__internal_verification_last_seen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__internal_corroboration__internal_verification_match_types')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_date')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_first')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_last')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_last_rpc_date')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_middle')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_result')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_rp_date')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_rp_first')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_rp_last')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_rp_last_rpc_date')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_rp_middle')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_feedback__phone_feedback_rp_result')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phone_model_score')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_address1')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_address2')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_address3')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_agegroup')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_agreg_listing_type')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_best_addr_match_flag')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_best_nm_match_flag')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_coctype')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_company_type')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_dialable_ind')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_feedback_phone')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_feedback_phone_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_feedback_phone7_did')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_feedback_phone7_did_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_feedback_phone7_nm_addr')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_feedback_phone7_nm_addr_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_indiv_has_active_eda_phone_flag')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_indiv_phone_cnt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_latest_phone_owner_flag')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_nonpublished_match')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_npa_effective_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_npa_last_change_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_nxx_type')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_ocn')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_phone_type')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_phone_use')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_place_name')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_portability_indicator')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_ported_match')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_prior_area_code')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_scc')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_seen_once_ind')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_append_time_zone')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_avg_source_conf')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_bdid')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_bdid_score')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_carrier')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_city')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_cleanaid')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_company')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_confidence')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_curr_orig_conf_score')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_current_rec')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_date_nonglb_lastseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_datefirstseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_datelastseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_datevendorfirstseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_datevendorlastseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_did')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_did_score')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_did_type')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_dob')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_eda_did_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_eda_hist_did_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_eda_hist_match')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_eda_hist_nm_addr_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_eda_hist_phone_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_eda_match')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_eda_nm_addr_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_eda_phone_dt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_email')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_first_build_date')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_gender')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_glb_dppa_all')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_glb_dppa_flag')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_hhid')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_hhid_score')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_last_build_date')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_listing_name')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_listingtype')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_max_orig_conf_score')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_max_source_conf')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_min_orig_conf_score')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_min_source_conf')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_orig_lastseen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origcarriercode')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origcarriername')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origcity')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origconfscore')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origlistingtype')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origname')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origphone')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origphoneregdate')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origphonetype')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origphoneusage')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origpublishcode')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origrectype')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origstate')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_origzip')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_rawaid')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_rp_carrier')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_rp_city')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_rp_source')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_rp_state')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_rp_type')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_rules')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_source')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_src')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_src_all')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_src_cnt')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_src_rule')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_state')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_total_source_conf')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__phonesplus_characteristics__phonesplus_type')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__address_zipcode_timezone')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_business_count')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_debt_settlement')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_disconnected')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_high_risk')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_match_code')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_subject_level')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_subject_title')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_switch_type')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_timezone')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_timezone_match')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__raw_phone_characteristics__phone_zip_match')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__royalties__efxdatamart_royalty')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__royalties__lastresortphones_royalty')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__royalties__metronet_royalty')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__royalties__qsentcis_royalty')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__royalties__targuscomprehensive_royalty')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__sources__source_list')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__sources__source_list_first_seen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__sources__source_list_last_seen')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__sources__source_owner_did')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__sources__source_owner_name_first')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__sources__source_owner_name_last')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__sources__source_owner_name_middle')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__sources__source_owner_name_prefix')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__sources__source_owner_name_suffix')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__subject_level__experian_num_duplicate')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__subject_level__experian_num_insufficient_score')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__subject_level__subject_ssn_mismatch')+
 zz_bbraaten2.Stats_Macro(da_new, 'phone_shell__unique_record_sequence');
 
// OUTPUT(Choosen(groupbin, all), named('groupbin'));

OUTPUT(groupbin,, '~bbraaten::out::phoneshell_stats_' + thorlib.wuid(), THOR, expire(30));

EXPORT PhoneShell_Run_Stats_Marco := 'todo';