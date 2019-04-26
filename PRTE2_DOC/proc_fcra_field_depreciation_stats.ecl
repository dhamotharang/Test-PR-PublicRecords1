﻿IMPORT strata, prte2_doc;

EXPORT proc_fcra_field_depreciation_stats := function;

// DF-22705 FCRA Consumer Data Field Depreciation
	cnt_fcra_offenders := OUTPUT(strata.macf_pops(prte2_doc.keys.key_criminal_offenders_did(true),,,,,,FALSE,
																						 ['_3g_offender','ace_fips_county,ace_fips_st','age','case_type','citizenship','clean_errors',
																							'county_of_birth','current_residence_county','dle_num','dob_alias','eye_color','fbi_num','hair_color',
																							'height','image_link','ins_num','legal_residence_county','party_status','place_of_birth','race',
																							'record_setup_date','record_type','scars_marks_tattoos_1','scars_marks_tattoos_2',
																							'scars_marks_tattoos_3','scars_marks_tattoos_4','scars_marks_tattoos_5','sex_offender',
																							'skin_color','street_address_3','street_address_4','street_address_5','violent_offender',
																							'vop_offender','weight']), named('cnt_fcra_offenders'));
	
	
	cnt_fcra_offender_key := OUTPUT(strata.macf_pops(prte2_doc.keys.key_offenses_offender_key(true),,,,,,FALSE,
																						 ['add_off_cd','add_off_desc','adj_wthd','arr_date','arr_disp_cd','arr_disp_date',
																							'arr_disp_desc_1','arr_disp_desc_2','arr_disp_desc_3','chg','chg_typ_flg','court_cd',
																							'court_county','ct_addl_desc_cd','ct_chg','ct_chg_typ_flg','ct_disp_cd','ct_disp_desc_2',
																							'ct_disp_dt','ct_dist','ct_fnl_plea','ct_fnl_plea_cd','ct_off_code','ct_off_desc_1',
																							'ct_off_desc_2','cty_conv_cd','off_of_record','record_type','stc_cd','stc_comp',
																							'stc_desc_3','stc_desc_4','total_num_of_offenses']), named('cnt_fcra_offender_key'));


	cnt_fcra_punishment_type := OUTPUT(strata.macf_pops(prte2_doc.keys.key_criminal_punishment_type(true),,,,,,FALSE,
																						 ['casepull_date,ctl_rel_dt','cur_loc_inm_cd','cur_loc_sec','cur_sec_class_dt',
																							'cur_stat_inm','gain_time','gain_time_eff_dt','inm_com_cty','inm_com_cty_cd','mutl_part_pgm_dt',
																							'office_phone','office_region','par_cty_cd','par_cur_stat','par_sch_end_dt','par_status_dt',
																							'parole_active_flag','presump_par_rel_dt','prison_status','record_type','recv_dept_code',
																							'recv_dept_date','release_type','sent_date','supv_office','supv_officer','tdcjid_admit_date',
																							'tdcjid_unit_assigned','tdcjid_unit_type']), named('cnt_fcra_punishment_type'));

	cnt_fcra_courtoffenses := OUTPUT(strata.macf_pops(prte2_doc.keys.key_correctionsfcracourt_offenses_public(true),,,,,,FALSE,
																						 ['appeal_date','appeal_final_decision','appeal_off_disp','arr_date','arr_disp_code',
																							'arr_disp_date','arr_disp_desc_1','arr_disp_desc_2','arr_off_code','arr_off_desc_1',
																							'arr_off_desc_2','arr_off_lev','arr_off_lev_mapped','arr_off_type_cd','arr_off_type_desc',
																							'arr_statute','arr_statute_desc','community_service','court_additional_statutes',
																							'court_appeal_flag','court_cd','court_county','court_disp_code','court_dt','court_off_desc_2',
																							'court_off_type_cd','court_off_type_desc','court_statute_desc','le_agency_cd','off_comp',
																							'off_delete_flag','probation_desc2','pros_act_filed','pros_assgn','pros_assgn_cd','pros_chg_rej',
																							'pros_off_code','pros_off_desc_1','pros_off_desc_2','pros_off_lev','pros_off_type_cd',
																							'pros_off_type_desc','pros_refer','pros_refer_cd','restitution','sent_addl_prov_code',
																							'sent_addl_prov_desc_1','sent_addl_prov_desc_2','sent_agency_rec_cust',
																							'sent_agency_rec_cust_ori','sent_consec','sent_court_cost','sent_susp_court_fine',
																							'sent_susp_time','traffic_dl_no','traffic_dl_st','traffic_ticket_number']), named('cnt_fcra_courtoffenses'));

	cnt_fcra_offenders_offenderkey := OUTPUT(strata.macf_pops(prte2_doc.keys.key_corrections_offenders_offenderkey(true),,,,,,FALSE,
																						 ['_3g_offender','ace_fips_county','ace_fips_st','age','case_type','citizenship',
																							'clean_errors','county_of_birth','current_residence_county','dle_num','dob_alias','eye_color',
																							'fbi_num','hair_color','height','image_link','ins_num','legal_residence_county','party_status',
																							'place_of_birth','race','record_setup_date','record_type','scars_marks_tattoos_1',
																							'scars_marks_tattoos_2','scars_marks_tattoos_3','scars_marks_tattoos_4',
																							'scars_marks_tattoos_5','sex_offender','skin_color','street_address_3','street_address_4',
																							'street_address_5','violent_offender','vop_offender','weight']), named('cnt_fcra_offenders_offenderkey'));

	RETURN SEQUENTIAL(cnt_fcra_offenders, cnt_fcra_offender_key,cnt_fcra_punishment_type,cnt_fcra_courtoffenses,cnt_fcra_offenders_offenderkey);
END;
