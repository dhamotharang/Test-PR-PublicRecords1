IMPORT EASI, Std, RiskWise, Risk_Indicators, Models, Ut;



/*  Custom Model for Vivid Seats  */  

EXPORT osn1608_1_0 (GROUPED DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) btstclam,  
										      BOOLEAN IBICID = TRUE,
										      BOOLEAN WantstoSeeBillToShipToDifferenceFlag = TRUE,
										      BOOLEAN isFCRA = False,
													BOOLEAN WantstoSeeEA = FALSE) := FUNCTION

	MODEL_DEBUG        := FALSE;                   //round 1 and round 2 set to TRUE  - Set to FALSE before moving to PROD and for creating TEST SEEDS
	ROUND1_VALIDATION  := FALSE;                   //round 1 set to TRUE              - Set to FALSE for round 2 and before moving to PROD and for creating TEST SEEDS
	
	Layout_ModelOut_TMP := RECORD
		Layout_ModelOut;
		Risk_Indicators.Layout_BocaShell_BtSt.Layout_Int_For_Codes;
  END;
	
	clam_with_easi     := Models.OrderScore_Get_Census_Data (btstclam);
	
#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			/* Model Input Variables */
			unsigned4 seq;
			BOOLEAN truedid;
			STRING out_st;
			STRING out_lat;
			STRING out_long;
			STRING in_dob;
			STRING in_email_address;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING nap_type;
			INTEGER rc_ssndod;
			STRING rc_decsflag;
			STRING rc_ssndobflag;
			STRING rc_pwssndobflag;
			BOOLEAN rc_ssnmiskeyflag;
			BOOLEAN rc_addrmiskeyflag;
			DECIMAL4_1 hdr_source_profile;
			STRING ver_sources;
			STRING ver_sources_first_seen;
			BOOLEAN fnamepop;
			BOOLEAN lnamepop;
			BOOLEAN addrpop;
			STRING ssnlength;
			BOOLEAN emailpop;
			BOOLEAN hphnpop;
			INTEGER add_input_address_score;
			BOOLEAN add_input_house_number_match;
			BOOLEAN add_input_addr_not_verified;
			INTEGER add_input_occ_index;
			INTEGER add_input_avm_auto_val;
			INTEGER add_input_occupants_1yr;
			INTEGER add_input_turnover_1yr_in;
			INTEGER add_input_turnover_1yr_out;
			INTEGER add_input_nhood_vac_prop;
			INTEGER add_input_nhood_bus_ct;
			INTEGER add_input_nhood_sfd_ct;
			INTEGER add_input_nhood_mfd_ct;
			BOOLEAN add_input_pop;
			INTEGER add_curr_lres;
			INTEGER add_curr_avm_auto_val;
			INTEGER add_curr_avm_auto_val_2;
			INTEGER add_curr_naprop;
			INTEGER add_curr_occupants_1yr;
			INTEGER add_curr_turnover_1yr_in;
			INTEGER add_curr_turnover_1yr_out;
			INTEGER add_curr_nhood_vac_prop;
			INTEGER add_curr_nhood_bus_ct;
			INTEGER add_curr_nhood_sfd_ct;
			INTEGER add_curr_nhood_mfd_ct;
			BOOLEAN add_curr_pop;
			INTEGER max_lres;
			INTEGER addrs_15yr;
			BOOLEAN addrs_prison_history;
			INTEGER ssns_per_adl;
			INTEGER phones_per_addr_curr;
			INTEGER ssns_per_adl_c6;
			INTEGER lnames_per_adl_c6;
			INTEGER adls_per_addr_c6;
			INTEGER phones_per_addr_c6;
			INTEGER invalid_ssns_per_adl;
			INTEGER invalid_addrs_per_adl;
			INTEGER inq_email_ver_count;
			INTEGER inq_count;
			INTEGER inq_count01;
			INTEGER inq_count03;
			INTEGER inq_count06;
			INTEGER inq_count12;
			INTEGER inq_count24;
			INTEGER inq_auto_count;
			INTEGER inq_auto_count01;
			INTEGER inq_auto_count03;
			INTEGER inq_auto_count06;
			INTEGER inq_auto_count12;
			INTEGER inq_auto_count24;
			INTEGER inq_collection_count;
			INTEGER inq_collection_count01;
			INTEGER inq_collection_count03;
			INTEGER inq_collection_count06;
			INTEGER inq_collection_count12;
			INTEGER inq_collection_count24;
			INTEGER inq_highriskcredit_count12;
			INTEGER inq_prepaidcards_count;
			INTEGER inq_prepaidcards_count01;
			INTEGER inq_prepaidcards_count03;
			INTEGER inq_prepaidcards_count06;
			INTEGER inq_prepaidcards_count12;
			INTEGER inq_prepaidcards_count24;
			INTEGER inq_retail_count;
			INTEGER inq_retail_count01;
			INTEGER inq_retail_count03;
			INTEGER inq_retail_count06;
			INTEGER inq_retail_count12;
			INTEGER inq_retail_count24;
			INTEGER inq_retailpayments_count;
			INTEGER inq_retailpayments_count01;
			INTEGER inq_retailpayments_count03;
			INTEGER inq_retailpayments_count06;
			INTEGER inq_retailpayments_count12;
			INTEGER inq_retailpayments_count24;
			INTEGER stl_inq_count;
			INTEGER email_count;
			STRING email_verification;
			STRING email_name_addr_verification;
			INTEGER adl_per_email;
			INTEGER attr_total_number_derogs;
			INTEGER attr_num_unrel_liens60;
			INTEGER attr_eviction_count;
			UNSIGNED1 attr_eviction_count90;
			UNSIGNED1 attr_eviction_count180;
			UNSIGNED1 attr_eviction_count12;
			UNSIGNED1 attr_eviction_count24;
			UNSIGNED1 attr_eviction_count36;
			UNSIGNED1 attr_eviction_count60;
			STRING fp_srchunvrfdphonecount;
			STRING fp_srchfraudsrchcountyr;
			STRING fp_srchfraudsrchcountwk;
			STRING fp_divaddrsuspidcountnew;
			STRING fp_srchssnsrchcountmo;
			STRING fp_srchaddrsrchcountmo;
			STRING fp_srchphonesrchcountmo;
			STRING fp_componentcharrisktype;
			STRING fp_addrchangeincomediff;
			STRING fp_addrchangevaluediff;
			STRING fp_addrchangecrimediff;
			STRING fp_curraddrmedianincome;
			STRING fp_curraddrmedianvalue;
			STRING fp_curraddrmurderindex;
			STRING fp_curraddrcartheftindex;
			STRING fp_curraddrburglaryindex;
			STRING fp_curraddrcrimeindex;
			STRING fp_prevaddrageoldest;
			STRING fp_prevaddrlenofres;
			STRING fp_prevaddrdwelltype;
			STRING fp_prevaddrmedianincome;
			STRING fp_prevaddrmurderindex;
			STRING fp_prevaddrcartheftindex;
			STRING fp_prevaddrburglaryindex;
			STRING fp_prevaddrcrimeindex;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_unrel_cj_last_seen;
			INTEGER criminal_last_date;
			INTEGER felony_count;
			STRING foreclosure_last_date;
			INTEGER hh_members_ct;
			INTEGER hh_payday_loan_users;
			INTEGER hh_members_w_derog;
			INTEGER hh_criminals;
			INTEGER rel_count;
			INTEGER rel_bankrupt_count;
			INTEGER rel_criminal_count;
			INTEGER rel_felony_count;
			INTEGER rel_within25miles_count;
			INTEGER rel_within100miles_count;
			INTEGER rel_within500miles_count;
			INTEGER rel_homeunder200_count;
			INTEGER rel_homeunder300_count;
			INTEGER rel_homeunder500_count;
			INTEGER rel_homeover500_count;
			INTEGER rel_ageunder40_count;
			INTEGER rel_ageunder50_count;
			INTEGER rel_ageunder60_count;
			INTEGER rel_ageunder70_count;
			INTEGER rel_ageover70_count;
			INTEGER acc_last_seen;
			INTEGER inferred_age;
			STRING addr_stability_v2;
			INTEGER estimated_income;
			BOOLEAN truedid_s;
			STRING out_z5_s;
			STRING out_addr_type_s;
			STRING in_dob_s;
			INTEGER nap_summary_s;
			STRING rc_hriskaddrflag_s;
			STRING rc_dwelltype_s;
			STRING rc_ziptypeflag_s;
			STRING rc_zipclass_s;
			DECIMAL4_1 hdr_source_profile_s;
			STRING ver_sources_s;
			STRING ver_sources_first_seen_s;
			BOOLEAN addrpop_s;
			BOOLEAN emailpop_s;
			STRING util_adl_type_list_s;
			INTEGER add_input_address_score_s;
			BOOLEAN add_input_dirty_address_s;
			BOOLEAN add_input_addr_not_verified_s;
			INTEGER add_input_avm_auto_val_s;
			INTEGER add_input_naprop_s;
			INTEGER add_input_occupants_1yr_s;
			INTEGER add_input_turnover_1yr_in_s;
			INTEGER add_input_turnover_1yr_out_s;
			INTEGER add_input_nhood_vac_prop_s;
			INTEGER add_input_nhood_bus_ct_s;
			INTEGER add_input_nhood_sfd_ct_s;
			INTEGER add_input_nhood_mfd_ct_s;
			BOOLEAN add_input_pop_s;
			INTEGER property_owned_total_s;
			INTEGER add_curr_lres_s;
			INTEGER add_curr_avm_auto_val_s;
			INTEGER add_curr_avm_auto_val_2_s;
			INTEGER add_curr_naprop_s;
			INTEGER add_curr_occupants_1yr_s;
			INTEGER add_curr_turnover_1yr_in_s;
			INTEGER add_curr_turnover_1yr_out_s;
			INTEGER add_curr_nhood_bus_ct_s;
			INTEGER add_curr_nhood_sfd_ct_s;
			INTEGER add_curr_nhood_mfd_ct_s;
			BOOLEAN add_curr_pop_s;
			INTEGER add_prev_naprop_s;
			INTEGER max_lres_s;
			INTEGER addrs_10yr_s;
			INTEGER adls_per_addr_curr_s;
			INTEGER phones_per_addr_curr_s;
			INTEGER adls_per_addr_c6_s;
			INTEGER invalid_addrs_per_adl_s;
			INTEGER inq_count24_s;
			INTEGER inq_auto_count24_s;
			INTEGER inq_banking_count24_s;
			INTEGER inq_communications_count_s;
			INTEGER inq_communications_count01_s;
			INTEGER inq_communications_count03_s;
			INTEGER inq_communications_count06_s;
			INTEGER inq_communications_count12_s;
			INTEGER inq_communications_count24_s;
			INTEGER inq_retailpayments_count_s;
			INTEGER inq_retailpayments_count01_s;
			INTEGER inq_retailpayments_count03_s;
			INTEGER inq_retailpayments_count06_s;
			INTEGER inq_retailpayments_count12_s;
			INTEGER inq_retailpayments_count24_s;
			INTEGER inq_peraddr_s;
			INTEGER inq_ssnsperaddr_s;
			INTEGER br_source_count_s;
			INTEGER email_count_s;
			STRING email_verification_s;
			STRING email_name_addr_verification_s;
			INTEGER attr_total_number_derogs_s;
			STRING fp_varrisktype_s;
			STRING fp_srchvelocityrisktype_s;
			STRING fp_validationrisktype_s;
			STRING fp_componentcharrisktype_s;
			STRING fp_addrchangeincomediff_s;
			STRING fp_addrchangevaluediff_s;
			STRING fp_addrchangecrimediff_s;
			STRING fp_addrchangeecontrajindex_s;
			STRING fp_curraddrmedianincome_s;
			STRING fp_curraddrmedianvalue_s;
			STRING fp_curraddrcartheftindex_s;
			STRING fp_curraddrburglaryindex_s;
			STRING fp_curraddrcrimeindex_s;
			STRING fp_prevaddrageoldest_s;
			STRING fp_prevaddrmedianincome_s;
			STRING fp_prevaddrmedianvalue_s;
			STRING fp_prevaddrmurderindex_s;
			STRING fp_prevaddrcartheftindex_s;
			STRING fp_prevaddrburglaryindex_s;
			STRING fp_prevaddrcrimeindex_s;
			INTEGER liens_rel_cj_total_amount_s;
			INTEGER liens_unrel_ft_first_seen_s;
			INTEGER liens_unrel_ot_first_seen_s;
			INTEGER criminal_last_date_s;
			INTEGER rel_count_s;
			INTEGER rel_bankrupt_count_s;
			INTEGER crim_rel_within25miles_s;
			INTEGER crim_rel_within100miles_s;
			INTEGER crim_rel_within500miles_s;
			INTEGER rel_within25miles_count_s;
			INTEGER rel_within100miles_count_s;
			INTEGER rel_incomeunder100_count_s;
			INTEGER rel_incomeover100_count_s;
			INTEGER rel_homeunder300_count_s;
			INTEGER rel_homeunder500_count_s;
			INTEGER rel_homeover500_count_s;
			INTEGER acc_damage_amt_total_s;
			STRING wealth_index_s;
			INTEGER inferred_age_s;
			STRING addr_stability_v2_s;
			INTEGER estimated_income_s;
			STRING BT_cen_blue_col;
			STRING BT_cen_business;
			STRING BT_cen_civ_emp;
			STRING BT_cen_easiqlife;
			STRING BT_cen_families;
			STRING BT_cen_health;
			STRING BT_cen_high_ed;
			STRING BT_cen_high_hval;
			STRING BT_cen_incollege;
			STRING BT_cen_lar_fam;
			STRING BT_cen_low_hval;
			STRING BT_cen_med_hhinc;
			STRING BT_cen_med_hval;
			STRING BT_cen_med_rent;
			STRING BT_cen_mil_emp;
			STRING BT_cen_no_move;
			STRING BT_cen_ownocc_p;
			STRING BT_cen_pop_0_5_p;
			STRING BT_cen_rental;
			STRING BT_cen_retired2;
			STRING BT_cen_span_lang;
			STRING BT_cen_totcrime;
			STRING BT_cen_trailer;
			STRING BT_cen_unemp;
			STRING BT_cen_urban_p;
			STRING BT_cen_vacant_p;
			STRING BT_cen_very_rich;
			STRING ST_cen_blue_col;
			STRING ST_cen_business;
			STRING ST_cen_civ_emp;
			STRING ST_cen_easiqlife;
			STRING ST_cen_families;
			STRING ST_cen_health;
			STRING ST_cen_high_ed;
			STRING ST_cen_high_hval;
			STRING ST_cen_incollege;
			STRING ST_cen_lar_fam;
			STRING ST_cen_low_hval;
			STRING ST_cen_med_hhinc;
			STRING ST_cen_med_hval;
			STRING ST_cen_med_rent;
			STRING ST_cen_mil_emp;
			STRING ST_cen_no_move;
			STRING ST_cen_ownocc_p;
			STRING ST_cen_pop_0_5_p;
			STRING ST_cen_rental;
			STRING ST_cen_retired2;
			STRING ST_cen_span_lang;
			STRING ST_cen_totcrime;
			STRING ST_cen_trailer;
			STRING ST_cen_unemp;
			STRING ST_cen_urban_p;
			STRING ST_cen_vacant_p;
			STRING ST_cen_very_rich;
			STRING addrscore;
			STRING continent;
			STRING distaddraddr2;
			STRING efirstscore;
			STRING elastscore;
			STRING ipaddr;
			STRING ipconnection;
			STRING ipdma;
			STRING iproutingmethod;
			STRING iptimezone;
			STRING lastscore;
			STRING latitude;
			STRING longitude;
			STRING state;
			STRING topleveldomain;

			/* Model Intermediate Variables */

			INTEGER sysdate;
			BOOLEAN b_nap_addr_verd_d;
			BOOLEAN b_nap_lname_verd_d;
			BOOLEAN b_nap_nothing_found_i;
			INTEGER b_f01_inp_addr_address_score_d;
			INTEGER b_d30_derog_count_i;
			INTEGER _criminal_last_date;
			INTEGER b_d32_mos_since_crim_ls_d;
			INTEGER b_d33_eviction_recency_d;
			INTEGER b_d33_eviction_count_i;
			INTEGER b_d34_unrel_liens_ct_i;
			INTEGER bureau_adl_eq_fseen_pos_2;
			STRING bureau_adl_fseen_eq_2;
			INTEGER _bureau_adl_fseen_eq_2;
			INTEGER _src_bureau_adl_fseen;
			INTEGER b_c21_m_bureau_adl_fs_d;
			INTEGER bureau_adl_eq_fseen_pos_1;
			STRING bureau_adl_fseen_eq_1;
			INTEGER _bureau_adl_fseen_eq_1;
			INTEGER bureau_adl_en_fseen_pos_1;
			STRING bureau_adl_fseen_en_1;
			INTEGER _bureau_adl_fseen_en_1;
			INTEGER bureau_adl_ts_fseen_pos_1;
			STRING bureau_adl_fseen_ts_1;
			INTEGER _bureau_adl_fseen_ts_1;
			INTEGER bureau_adl_tu_fseen_pos_1;
			STRING bureau_adl_fseen_tu_1;
			INTEGER _bureau_adl_fseen_tu_1;
			INTEGER bureau_adl_tn_fseen_pos_1;
			STRING bureau_adl_fseen_tn_1;
			INTEGER _bureau_adl_fseen_tn_1;
			INTEGER _src_bureau_adl_fseen_all;
			INTEGER b_m_bureau_adl_fs_all_d;
			INTEGER bureau_adl_eq_fseen_pos;
			STRING bureau_adl_fseen_eq;
			INTEGER _bureau_adl_fseen_eq;
			INTEGER bureau_adl_en_fseen_pos;
			STRING bureau_adl_fseen_en;
			INTEGER _bureau_adl_fseen_en;
			INTEGER bureau_adl_ts_fseen_pos;
			STRING bureau_adl_fseen_ts;
			INTEGER _bureau_adl_fseen_ts;
			INTEGER bureau_adl_tu_fseen_pos;
			STRING bureau_adl_fseen_tu;
			INTEGER _bureau_adl_fseen_tu;
			INTEGER bureau_adl_tn_fseen_pos;
			STRING bureau_adl_fseen_tn;
			INTEGER _bureau_adl_fseen_tn;
			INTEGER _src_bureau_adl_fseen_notu;
			INTEGER b_m_bureau_adl_fs_notu_d;
			INTEGER _in_dob;
			REAL yr_in_dob;
			REAL yr_in_dob_int;
			INTEGER b_comb_age_d;
			INTEGER b_a44_curr_add_naprop_d;
			INTEGER b_l80_inp_avm_autoval_d;
			INTEGER b_a46_curr_avm_autoval_d;
			INTEGER b_a49_curr_avm_chg_1yr_i;
			REAL b_a49_curr_avm_chg_1yr_pct_i;
			INTEGER b_c13_curr_addr_lres_d;
			INTEGER b_c14_addr_stability_v2_d;
			INTEGER b_c13_max_lres_d;
			INTEGER b_c14_addrs_15yr_i;
			INTEGER b_c20_email_count_i;
			INTEGER b_l79_adls_per_addr_c6_i;
			INTEGER b_c18_invalid_addrs_per_adl_i;
			INTEGER b_l78_no_phone_at_addr_vel_i;
			INTEGER b_i60_inq_recency_d;
			INTEGER b_i61_inq_collection_recency_d;
			INTEGER b_i60_inq_auto_recency_d;
			INTEGER b_i60_inq_hiriskcred_count12_i;
			INTEGER b_i60_inq_retail_recency_d;
			REAL    b_add_input_mobility_index_i;
			INTEGER add_input_nhood_prop_sum_3;
			REAL    b_add_input_nhood_bus_pct_i;
			INTEGER add_input_nhood_prop_sum_2;
			REAL    b_add_input_nhood_mfd_pct_i;
			INTEGER add_input_nhood_prop_sum_1;
			REAL    b_add_input_nhood_sfd_pct_d;
			INTEGER add_input_nhood_prop_sum;
			REAL    b_add_input_nhood_vac_pct_i;
			REAL    b_add_curr_mobility_index_i;
			INTEGER add_curr_nhood_prop_sum_3;
			REAL    b_add_curr_nhood_bus_pct_i;
			INTEGER add_curr_nhood_prop_sum_2;
			REAL    b_add_curr_nhood_mfd_pct_i;
			INTEGER add_curr_nhood_prop_sum_1;
			REAL    b_add_curr_nhood_sfd_pct_d;
			INTEGER add_curr_nhood_prop_sum;
			REAL    b_add_curr_nhood_vac_pct_i;
			INTEGER b_inq_count24_i;
			INTEGER b_inq_collection_count24_i;
			INTEGER b_inq_retail_count24_i;
			INTEGER _liens_unrel_cj_last_seen;
			INTEGER b_mos_liens_unrel_cj_lseen_d;
			INTEGER _foreclosure_last_date;
			INTEGER b_mos_foreclosure_lseen_d;
			INTEGER b_estimated_income_d;
			INTEGER b_rel_count_i;
			INTEGER b_rel_homeover150_count_d;
			INTEGER b_rel_homeover200_count_d;
			INTEGER b_rel_ageover30_count_d;
			INTEGER b_rel_ageover40_count_d;
			INTEGER b_rel_ageover50_count_d;
			INTEGER b_rel_under25miles_cnt_d;
			INTEGER b_rel_under500miles_cnt_d;
			INTEGER b_rel_bankrupt_count_i;
			INTEGER b_rel_criminal_count_i;
			INTEGER _acc_last_seen;
			INTEGER b_mos_acc_lseen_d;
			INTEGER b_srchunvrfdphonecount_i;
			INTEGER b_srchfraudsrchcountyr_i;
			INTEGER b_srchfraudsrchcountwk_i;
			INTEGER b_divaddrsuspidcountnew_i;
			INTEGER b_componentcharrisktype_i;
			INTEGER b_addrchangeincomediff_d_1;
			INTEGER b_addrchangeincomediff_d;
			INTEGER b_addrchangevaluediff_d;
			INTEGER b_addrchangecrimediff_i;
			INTEGER b_curraddrmedianincome_d;
			INTEGER b_curraddrmedianvalue_d;
			INTEGER b_curraddrmurderindex_i;
			INTEGER b_curraddrcartheftindex_i;
			INTEGER b_curraddrburglaryindex_i;
			INTEGER b_curraddrcrimeindex_i;
			INTEGER b_prevaddrageoldest_d;
			INTEGER b_prevaddrlenofres_d;
			INTEGER b_prevaddrdwelltype_sfd_n;
			INTEGER b_prevaddrmedianincome_d;
			INTEGER b_prevaddrmurderindex_i;
			INTEGER b_prevaddrcartheftindex_i;
			INTEGER b_fp_prevaddrburglaryindex_i;
			INTEGER b_fp_prevaddrcrimeindex_i;
			DECIMAL21_1 b_c12_source_profile_d;
			INTEGER b_f01_inp_addr_not_verified_i;
			INTEGER b_c23_inp_addr_occ_index_d;
			INTEGER b_i60_inq_prepaidcards_recency_d;
			INTEGER b_i60_inq_retpymt_recency_d;
			INTEGER b_phones_per_addr_curr_i;
			INTEGER b_phones_per_addr_c6_i;
			INTEGER b_inq_email_ver_count_i;
			BOOLEAN b_nae_email_verd_d;
			BOOLEAN b_nae_contradictory_i;
			INTEGER b_adl_per_email_i;
			INTEGER b_c20_email_verification_d;
			BOOLEAN _ver_src_ds;
			BOOLEAN _ver_src_de;
			BOOLEAN _ver_src_eq;
			BOOLEAN _ver_src_en;
			BOOLEAN _ver_src_tn;
			BOOLEAN _ver_src_tu;
			INTEGER _credit_source_cnt;
			INTEGER _ver_src_cnt;
			STRING _bureauonly;
			STRING _derog;
			STRING _deceased;
			STRING _ssnpriortodob;
			STRING _inputmiskeys;
			STRING _multiplessns;
			STRING _hh_strikes;
		  
			BOOLEAN s_nap_addr_verd_d;
			BOOLEAN s_nap_lname_verd_d;
			BOOLEAN s_nap_nothing_found_i;
			INTEGER s_l77_add_po_box_i;
			INTEGER s_f01_inp_addr_address_score_d;
		  REAL    s_l70_inp_addr_dirty_i;
			INTEGER s_d30_derog_count_i;
			INTEGER _criminal_last_date_s;
			INTEGER s_d32_mos_since_crim_ls_d;
			INTEGER bureau_adl_eq_fseen_pos_s_1;
			STRING  bureau_adl_fseen_eq_s_1;
			INTEGER _bureau_adl_fseen_eq_s_1;
			INTEGER _src_bureau_adl_fseen_s;
			INTEGER s_c21_m_bureau_adl_fs_d;
			INTEGER bureau_adl_eq_fseen_pos_s;
			STRING bureau_adl_fseen_eq_s;
			INTEGER _bureau_adl_fseen_eq_s;
			INTEGER bureau_adl_en_fseen_pos_s;
			STRING  bureau_adl_fseen_en_s;
			INTEGER _bureau_adl_fseen_en_s;
			INTEGER bureau_adl_ts_fseen_pos_s;
			STRING  bureau_adl_fseen_ts_s;
			INTEGER _bureau_adl_fseen_ts_s;
			INTEGER bureau_adl_tu_fseen_pos_s;
			STRING  bureau_adl_fseen_tu_s;
			INTEGER _bureau_adl_fseen_tu_s;
			INTEGER bureau_adl_tn_fseen_pos_s;
			STRING  bureau_adl_fseen_tn_s;
			INTEGER _bureau_adl_fseen_tn_s;
			INTEGER _src_bureau_adl_fseen_notu_s;
			INTEGER s_m_bureau_adl_fs_notu_d;
			INTEGER _in_dob_s;
			REAL yr_in_dob_s;
			INTEGER yr_in_dob_int_s;
			Integer s_comb_age_d;
      Integer s_a44_curr_add_naprop_d;
			Integer s_l80_inp_avm_autoval_d;
			Real s_a49_curr_avm_chg_1yr_pct_i;
			Integer s_c13_curr_addr_lres_d;
			Integer s_c14_addr_stability_v2_d;
			Integer s_c13_max_lres_d;
			Integer s_c14_addrs_10yr_i;
			Integer s_a41_prop_owner_d;
			Integer s_c20_email_count_i;
			Integer s_l79_adls_per_addr_curr_i;
			Integer s_l79_adls_per_addr_c6_i;
			Integer s_c18_invalid_addrs_per_adl_i;
			Integer s_i60_inq_comm_recency_d;
			STRING  s_adl_util_misc_n;
			Real    s_add_input_mobility_index_i;
			Integer add_input_nhood_prop_sum_s_3;
			Real   s_add_input_nhood_bus_pct_i;
			Integer add_input_nhood_prop_sum_s_2;
			Real   s_add_input_nhood_mfd_pct_i;
			Integer add_input_nhood_prop_sum_s_1;
			Real   s_add_input_nhood_sfd_pct_d;
			Integer add_input_nhood_prop_sum_s;
			Real   s_add_input_nhood_vac_pct_i;
			Real   s_add_curr_mobility_index_i;
			Integer add_curr_nhood_prop_sum_s_2;
			Real   s_add_curr_nhood_bus_pct_i;
			Integer add_curr_nhood_prop_sum_s_1;
			Real   s_add_curr_nhood_mfd_pct_i;
			Integer add_curr_nhood_prop_sum_s;
			Real   s_add_curr_nhood_sfd_pct_d;
			INTEGER s_inq_count24_i;
			INTEGER s_inq_auto_count24_i;
			INTEGER s_inq_banking_count24_i;
			INTEGER s_inq_per_addr_i;
			INTEGER s_inq_ssns_per_addr_i;
			INTEGER s_liens_rel_cj_total_amt_i;
			INTEGER _liens_unrel_ft_first_seen_s;
			INTEGER s_mos_liens_unrel_ft_fseen_d;
			INTEGER _liens_unrel_ot_first_seen_s;
			INTEGER s_mos_liens_unrel_ot_fseen_d;
			INTEGER s_estimated_income_d;
			INTEGER s_wealth_index_d;
			INTEGER s_rel_incomeover75_count_d;
			INTEGER s_rel_incomeover100_count_d;
			INTEGER s_rel_homeover200_count_d;
			INTEGER s_rel_homeover300_count_d;
			INTEGER s_crim_rel_under500miles_cnt_i;
			INTEGER s_rel_under25miles_cnt_d;
			INTEGER s_rel_under100miles_cnt_d;
			INTEGER s_rel_bankrupt_count_i;
			INTEGER s_acc_damage_amt_total_i;
			INTEGER s_varrisktype_i;
			INTEGER s_srchvelocityrisktype_i;
			INTEGER s_validationrisktype_i;
			INTEGER s_componentcharrisktype_i;
			INTEGER s_addrchangeincomediff_d_1;
			INTEGER s_addrchangeincomediff_d;
			INTEGER s_addrchangevaluediff_d;
			INTEGER s_addrchangecrimediff_i;
			INTEGER s_addrchangeecontrajindex_d;
			INTEGER s_curraddrmedianincome_d;
			INTEGER s_curraddrmedianvalue_d;
			INTEGER s_curraddrcartheftindex_i;
			INTEGER s_curraddrburglaryindex_i;
			INTEGER s_curraddrcrimeindex_i;
			INTEGER s_prevaddrageoldest_d;
			INTEGER s_prevaddrmedianincome_d;
			INTEGER s_prevaddrmedianvalue_d;
			INTEGER s_prevaddrmurderindex_i;
			INTEGER s_prevaddrcartheftindex_i;
			INTEGER s_fp_prevaddrburglaryindex_i;
			INTEGER s_fp_prevaddrcrimeindex_i;
			DECIMAL21_1 s_c12_source_profile_d;
			INTEGER s_f01_inp_addr_not_verified_i;
			INTEGER s_e57_br_source_count_d;
			INTEGER s_i60_inq_retpymt_recency_d;
			INTEGER s_phones_per_addr_curr_i;
			BOOLEAN s_nae_email_verd_d;
			INTEGER s_c20_email_verification_d;
			BOOLEAN btst_addr_match_d;
			REAL    num_inp_lat;
			REAL8   num_inp_long;
			REAL    num_ip_lat;
			REAL    num_ip_long;
			REAL   d_lat;
			REAL   d_long;
			REAL   a;
			REAL   c;
			REAL   dist;
			REAL   btst_dist_inp_addr_to_ip_addr_i;
			STRING btst_lastscore_d;
			STRING btst_addrscore_d;
			STRING btst_email_first_score_d;
			STRING btst_email_last_score_d;
			REAL   btst_distaddraddr2_i;
			STRING email_topleveldomain;
			STRING btst_email_topleveldomain_n;
			STRING ip_continent_n;
			STRING ip_state_match_d;
			STRING ip_topleveldomain_lvl_n;
			STRING ip_routingmethod_n;
			STRING ip_dma_lvl_n;
			STRING num_ip_time_zone;
			STRING ip_non_us_time_zone_i;
			STRING ip_connection_n;
			REAL   final_score_tree_0;
			REAL   final_score_tree_1_c198;
			REAL   final_score_tree_1_c199;
			REAL   final_score_tree_1_c197;
			REAL   final_score_tree_1_c196;
			REAL   final_score_tree_1;
			REAL   final_score_tree_2_c203;
			REAL   final_score_tree_2_c202;
			REAL   final_score_tree_2_c201;
			REAL   final_score_tree_2_c204;
			REAL   final_score_tree_2;
			REAL   final_score_tree_3_c208;
			REAL   final_score_tree_3_c207;
			REAL   final_score_tree_3_c206;
			REAL   final_score_tree_3_c209;
			REAL   final_score_tree_3;
			REAL   final_score_tree_4_c213;
			REAL   final_score_tree_4_c212;
			REAL   final_score_tree_4_c211;
			REAL   final_score_tree_4_c214;
			REAL   final_score_tree_4;
			REAL   final_score_tree_5_c218;
			REAL   final_score_tree_5_c217;
			REAL   final_score_tree_5_c216;
			REAL   final_score_tree_5_c219;
			REAL   final_score_tree_5;
			REAL   final_score_tree_6_c224;
			REAL   final_score_tree_6_c223;
			REAL   final_score_tree_6_c222;
			REAL   final_score_tree_6_c221;
			REAL   final_score_tree_6;
			REAL   final_score_tree_7_c229;
			REAL   final_score_tree_7_c228;
			REAL   final_score_tree_7_c227;
			REAL   final_score_tree_7_c226;
			REAL   final_score_tree_7;
			REAL   final_score_tree_8_c233;
			REAL   final_score_tree_8_c232;
			REAL   final_score_tree_8_c231;
			REAL   final_score_tree_8_c234;
			REAL   final_score_tree_8;
			REAL   final_score_tree_9_c239;
			REAL   final_score_tree_9_c238;
			REAL   final_score_tree_9_c237;
			REAL   final_score_tree_9_c236;
			REAL   final_score_tree_9;
			REAL   final_score_tree_10_c242;
			REAL   final_score_tree_10_c241;
			REAL   final_score_tree_10_c244;
			REAL   final_score_tree_10_c243;
			REAL   final_score_tree_10;
			REAL   final_score_tree_11_c249;
			REAL   final_score_tree_11_c248;
			REAL   final_score_tree_11_c247;
			REAL   final_score_tree_11_c246;
			REAL   final_score_tree_11;
			REAL   final_score_tree_12_c252;
			REAL   final_score_tree_12_c254;
			REAL   final_score_tree_12_c253;
			REAL   final_score_tree_12_c251;
			REAL   final_score_tree_12;
			REAL   final_score_tree_13_c256;
			REAL   final_score_tree_13_c259;
			REAL   final_score_tree_13_c258;
			REAL   final_score_tree_13_c257;
			REAL   final_score_tree_13;
			REAL   final_score_tree_14_c263;
			REAL   final_score_tree_14_c264;
			REAL   final_score_tree_14_c262;
			REAL   final_score_tree_14_c261;
			REAL   final_score_tree_14;
			REAL   final_score_tree_15_c268;
			REAL   final_score_tree_15_c269;
			REAL   final_score_tree_15_c267;
			REAL   final_score_tree_15_c266;
			REAL   final_score_tree_15;
			REAL   final_score_tree_16_c272;
			REAL   final_score_tree_16_c273;
			REAL   final_score_tree_16_c271;
			REAL   final_score_tree_16_c274;
			REAL   final_score_tree_16;
			REAL   final_score_tree_17_c277;
			REAL   final_score_tree_17_c276;
			REAL   final_score_tree_17_c279;
			REAL   final_score_tree_17_c278;
			REAL   final_score_tree_17;
			REAL   final_score_tree_18_c282;
			REAL   final_score_tree_18_c281;
			REAL   final_score_tree_18_c284;
			REAL   final_score_tree_18_c283;
			REAL   final_score_tree_18;
			REAL   final_score_tree_19_c287;
			REAL   final_score_tree_19_c286;
			REAL   final_score_tree_19_c289;
			REAL   final_score_tree_19_c288;
			REAL   final_score_tree_19;
			REAL   final_score_tree_20_c293;
			REAL   final_score_tree_20_c292;
			REAL   final_score_tree_20_c291;
			REAL   final_score_tree_20_c294;
			REAL   final_score_tree_20;
			REAL   final_score_tree_21_c298;
			REAL   final_score_tree_21_c297;
			REAL   final_score_tree_21_c299;
			REAL   final_score_tree_21_c296;
			REAL   final_score_tree_21;
			REAL   final_score_tree_22_c301;
			REAL   final_score_tree_22_c304;
			REAL   final_score_tree_22_c303;
			REAL   final_score_tree_22_c302;
			REAL   final_score_tree_22;
			REAL   final_score_tree_23_c306;
			REAL   final_score_tree_23_c309;
			REAL   final_score_tree_23_c308;
			REAL   final_score_tree_23_c307;
			REAL   final_score_tree_23;
			REAL   final_score_tree_24_c314;
			REAL   final_score_tree_24_c313;
			REAL   final_score_tree_24_c312;
			REAL   final_score_tree_24_c311;
			REAL   final_score_tree_24;
			REAL   final_score_tree_25_c318;
			REAL   final_score_tree_25_c317;
			REAL   final_score_tree_25_c319;
			REAL   final_score_tree_25_c316;
			REAL   final_score_tree_25;
			REAL   final_score_tree_26_c324;
			REAL   final_score_tree_26_c323;
			REAL   final_score_tree_26_c322;
			REAL   final_score_tree_26_c321;
			REAL   final_score_tree_26;
			REAL   final_score_tree_27_c327;
			REAL   final_score_tree_27_c328;
			REAL   final_score_tree_27_c329;
			REAL   final_score_tree_27_c326;
			REAL   final_score_tree_27;
			REAL   final_score_tree_28_c333;
			REAL   final_score_tree_28_c332;
			REAL   final_score_tree_28_c334;
			REAL   final_score_tree_28_c331;
			REAL   final_score_tree_28;
			REAL   final_score_tree_29_c337;
			REAL   final_score_tree_29_c336;
			REAL   final_score_tree_29_c339;
			REAL   final_score_tree_29_c338;
			REAL   final_score_tree_29;
			REAL   final_score_tree_30_c342;
			REAL   final_score_tree_30_c343;
			REAL   final_score_tree_30_c344;
			REAL   final_score_tree_30_c341;
			REAL   final_score_tree_30;
			REAL   final_score_tree_31_c346;
			REAL   final_score_tree_31_c348;
			REAL   final_score_tree_31_c349;
			REAL   final_score_tree_31_c347;
			REAL   final_score_tree_31;
			REAL   final_score_tree_32_c352;
			REAL   final_score_tree_32_c354;
			REAL   final_score_tree_32_c353;
			REAL   final_score_tree_32_c351;
			REAL   final_score_tree_32;
			REAL   final_score_tree_33_c358;
			REAL   final_score_tree_33_c357;
			REAL   final_score_tree_33_c356;
			REAL   final_score_tree_33_c359;
			REAL   final_score_tree_33;
			REAL   final_score_tree_34_c362;
			REAL   final_score_tree_34_c363;
			REAL   final_score_tree_34_c364;
			REAL   final_score_tree_34_c361;
			REAL   final_score_tree_34;
			REAL   final_score_tree_35_c368;
			REAL   final_score_tree_35_c367;
			REAL   final_score_tree_35_c366;
			REAL   final_score_tree_35_c369;
			REAL   final_score_tree_35;
			REAL   final_score_tree_36_c374;
			REAL   final_score_tree_36_c373;
			REAL   final_score_tree_36_c372;
			REAL   final_score_tree_36_c371;
			REAL   final_score_tree_36;
			REAL   final_score_tree_37_c377;
			REAL   final_score_tree_37_c378;
			REAL   final_score_tree_37_c376;
			REAL   final_score_tree_37_c379;
			REAL   final_score_tree_37;
			REAL   final_score_tree_38_c383;
			REAL   final_score_tree_38_c382;
			REAL   final_score_tree_38_c384;
			REAL   final_score_tree_38_c381;
			REAL   final_score_tree_38;
			REAL   final_score_tree_39_c389;
			REAL   final_score_tree_39_c388;
			REAL   final_score_tree_39_c387;
			REAL   final_score_tree_39_c386;
			REAL   final_score_tree_39;
			REAL   final_score_tree_40_c393;
			REAL   final_score_tree_40_c392;
			REAL   final_score_tree_40_c394;
			REAL   final_score_tree_40_c391;
			REAL   final_score_tree_40;
			REAL   final_score_tree_41_c399;
			REAL   final_score_tree_41_c398;
			REAL   final_score_tree_41_c397;
			REAL   final_score_tree_41_c396;
			REAL   final_score_tree_41;
			REAL   final_score_tree_42_c404;
			REAL   final_score_tree_42_c403;
			REAL   final_score_tree_42_c402;
			REAL   final_score_tree_42_c401;
			REAL   final_score_tree_42;
			REAL   final_score_tree_43_c407;
			REAL   final_score_tree_43_c409;
			REAL   final_score_tree_43_c408;
			REAL   final_score_tree_43_c406;
			REAL   final_score_tree_43;
			REAL   final_score_tree_44_c412;
			REAL   final_score_tree_44_c411;
			REAL   final_score_tree_44_c414;
			REAL   final_score_tree_44_c413;
			REAL   final_score_tree_44;
			REAL   final_score_tree_45_c418;
			REAL   final_score_tree_45_c417;
			REAL   final_score_tree_45_c416;
			REAL   final_score_tree_45_c419;
			REAL   final_score_tree_45;
			REAL   final_score_tree_46_c423;
			REAL   final_score_tree_46_c422;
			REAL   final_score_tree_46_c421;
			REAL   final_score_tree_46_c424;
			REAL   final_score_tree_46;
			REAL   final_score_tree_47_c426;
			REAL   final_score_tree_47_c429;
			REAL   final_score_tree_47_c428;
			REAL   final_score_tree_47_c427;
			REAL   final_score_tree_47;
			REAL   final_score_tree_48_c432;
			REAL   final_score_tree_48_c431;
			REAL   final_score_tree_48_c434;
			REAL   final_score_tree_48_c433;
			REAL   final_score_tree_48;
			REAL   final_score_tree_49_c439;
			REAL   final_score_tree_49_c438;
			REAL   final_score_tree_49_c437;
			REAL   final_score_tree_49_c436;
			REAL   final_score_tree_49;
			REAL   final_score_tree_50_c443;
			REAL   final_score_tree_50_c442;
			REAL   final_score_tree_50_c444;
			REAL   final_score_tree_50_c441;
			REAL   final_score_tree_50;
			REAL   final_score_tree_51_c449;
			REAL   final_score_tree_51_c448;
			REAL   final_score_tree_51_c447;
			REAL   final_score_tree_51_c446;
			REAL   final_score_tree_51;
			REAL   final_score_tree_52_c454;
			REAL   final_score_tree_52_c453;
			REAL   final_score_tree_52_c452;
			REAL   final_score_tree_52_c451;
			REAL   final_score_tree_52;
			REAL   final_score_tree_53_c459;
			REAL   final_score_tree_53_c458;
			REAL   final_score_tree_53_c457;
			REAL   final_score_tree_53_c456;
			REAL   final_score_tree_53;
			REAL   final_score_tree_54_c462;
			REAL   final_score_tree_54_c461;
			REAL   final_score_tree_54_c464;
			REAL   final_score_tree_54_c463;
			REAL   final_score_tree_54;
			REAL   final_score_tree_55_c469;
			REAL   final_score_tree_55_c468;
			REAL   final_score_tree_55_c467;
			REAL   final_score_tree_55_c466;
			REAL   final_score_tree_55;
			REAL   final_score_tree_56_c474;
			REAL   final_score_tree_56_c473;
			REAL   final_score_tree_56_c472;
			REAL   final_score_tree_56_c471;
			REAL   final_score_tree_56;
			REAL   final_score_tree_57_c478;
			REAL   final_score_tree_57_c477;
			REAL   final_score_tree_57_c476;
			REAL   final_score_tree_57_c479;
			REAL   final_score_tree_57;
			REAL   final_score_tree_58_c484;
			REAL   final_score_tree_58_c483;
			REAL   final_score_tree_58_c482;
			REAL   final_score_tree_58_c481;
			REAL   final_score_tree_58;
			REAL   final_score_tree_59_c488;
			REAL   final_score_tree_59_c487;
			REAL   final_score_tree_59_c486;
			REAL   final_score_tree_59_c489;
			REAL   final_score_tree_59;
			REAL   final_score_tree_60_c492;
			REAL   final_score_tree_60_c491;
			REAL   final_score_tree_60_c494;
			REAL   final_score_tree_60_c493;
			REAL   final_score_tree_60;
			REAL   final_score_tree_61_c497;
			REAL   final_score_tree_61_c499;
			REAL   final_score_tree_61_c498;
			REAL   final_score_tree_61_c496;
			REAL   final_score_tree_61;
			REAL   final_score_tree_62_c503;
			REAL   final_score_tree_62_c502;
			REAL   final_score_tree_62_c501;
			REAL   final_score_tree_62_c504;
			REAL   final_score_tree_62;
			REAL   final_score_tree_63_c509;
			REAL   final_score_tree_63_c508;
			REAL   final_score_tree_63_c507;
			REAL   final_score_tree_63_c506;
			REAL   final_score_tree_63;
			REAL   final_score_tree_64_c512;
			REAL   final_score_tree_64_c514;
			REAL   final_score_tree_64_c513;
			REAL   final_score_tree_64_c511;
			REAL   final_score_tree_64;
			REAL   final_score_tree_65_c519;
			REAL   final_score_tree_65_c518;
			REAL   final_score_tree_65_c517;
			REAL   final_score_tree_65_c516;
			REAL   final_score_tree_65;
			REAL   final_score_tree_66_c524;
			REAL   final_score_tree_66_c523;
			REAL   final_score_tree_66_c522;
			REAL   final_score_tree_66_c521;
			REAL   final_score_tree_66;
			REAL   final_score_tree_67_c528;
			REAL   final_score_tree_67_c527;
			REAL   final_score_tree_67_c526;
			REAL   final_score_tree_67_c529;
			REAL   final_score_tree_67;
			REAL   final_score_tree_68_c534;
			REAL   final_score_tree_68_c533;
			REAL   final_score_tree_68_c532;
			REAL   final_score_tree_68_c531;
			REAL   final_score_tree_68;
			REAL   final_score_tree_69_c538;
			REAL   final_score_tree_69_c537;
			REAL   final_score_tree_69_c536;
			REAL   final_score_tree_69_c539;
			REAL   final_score_tree_69;
			REAL   final_score_tree_70_c541;
			REAL   final_score_tree_70_c544;
			REAL   final_score_tree_70_c543;
			REAL   final_score_tree_70_c542;
			REAL   final_score_tree_70;
			REAL   final_score_tree_71_c549;
			REAL   final_score_tree_71_c548;
			REAL   final_score_tree_71_c547;
			REAL   final_score_tree_71_c546;
			REAL   final_score_tree_71;
			REAL   final_score_tree_72_c553;
			REAL   final_score_tree_72_c552;
			REAL   final_score_tree_72_c551;
			REAL   final_score_tree_72_c554;
			REAL   final_score_tree_72;
			REAL   final_score_tree_73_c559;
			REAL   final_score_tree_73_c558;
			REAL   final_score_tree_73_c557;
			REAL   final_score_tree_73_c556;
			REAL   final_score_tree_73;
			REAL   final_score_tree_74_c563;
			REAL   final_score_tree_74_c562;
			REAL   final_score_tree_74_c564;
			REAL   final_score_tree_74_c561;
			REAL   final_score_tree_74;
			REAL   final_score_tree_75_c568;
			REAL   final_score_tree_75_c567;
			REAL   final_score_tree_75_c566;
			REAL   final_score_tree_75_c569;
			REAL   final_score_tree_75;
			REAL   final_score_tree_76_c573;
			REAL   final_score_tree_76_c572;
			REAL   final_score_tree_76_c574;
			REAL   final_score_tree_76_c571;
			REAL   final_score_tree_76;
			REAL   final_score_tree_77_c576;
			REAL   final_score_tree_77_c579;
			REAL   final_score_tree_77_c578;
			REAL   final_score_tree_77_c577;
			REAL   final_score_tree_77;
			REAL   final_score_tree_78_c581;
			REAL   final_score_tree_78_c584;
			REAL   final_score_tree_78_c583;
			REAL   final_score_tree_78_c582;
			REAL   final_score_tree_78;
			REAL   final_score_tree_79_c589;
			REAL   final_score_tree_79_c588;
			REAL   final_score_tree_79_c587;
			REAL   final_score_tree_79_c586;
			REAL   final_score_tree_79;
			REAL   final_score_tree_80_c591;
			REAL   final_score_tree_80_c593;
			REAL   final_score_tree_80_c592;
			REAL   final_score_tree_80_c594;
			REAL   final_score_tree_80;
			REAL   final_score_tree_81_c599;
			REAL   final_score_tree_81_c598;
			REAL   final_score_tree_81_c597;
			REAL   final_score_tree_81_c596;
			REAL   final_score_tree_81;
			REAL   final_score_tree_82_c601;
			REAL   final_score_tree_82_c604;
			REAL   final_score_tree_82_c603;
			REAL   final_score_tree_82_c602;
			REAL   final_score_tree_82;
			REAL   final_score_tree_83_c606;
			REAL   final_score_tree_83_c607;
			REAL   final_score_tree_83_c609;
			REAL   final_score_tree_83_c608;
			REAL   final_score_tree_83;
			REAL   final_score_tree_84_c613;
			REAL   final_score_tree_84_c612;
			REAL   final_score_tree_84_c614;
			REAL   final_score_tree_84_c611;
			REAL   final_score_tree_84;
			REAL   final_score_tree_85_c619;
			REAL   final_score_tree_85_c618;
			REAL   final_score_tree_85_c617;
			REAL   final_score_tree_85_c616;
			REAL   final_score_tree_85;
			REAL   final_score_tree_86_c622;
			REAL   final_score_tree_86_c621;
			REAL   final_score_tree_86_c624;
			REAL   final_score_tree_86_c623;
			REAL   final_score_tree_86;
			REAL   final_score_tree_87_c627;
			REAL   final_score_tree_87_c628;
			REAL   final_score_tree_87_c626;
			REAL   final_score_tree_87_c629;
			REAL   final_score_tree_87;
			REAL   final_score_tree_88_c633;
			REAL   final_score_tree_88_c632;
			REAL   final_score_tree_88_c631;
			REAL   final_score_tree_88_c634;
			REAL   final_score_tree_88;
			REAL   final_score_tree_89_c639;
			REAL   final_score_tree_89_c638;
			REAL   final_score_tree_89_c637;
			REAL   final_score_tree_89_c636;
			REAL   final_score_tree_89;
			REAL   final_score_tree_90_c643;
			REAL   final_score_tree_90_c644;
			REAL   final_score_tree_90_c642;
			REAL   final_score_tree_90_c641;
			REAL   final_score_tree_90;
			REAL   final_score_tree_91_c647;
			REAL   final_score_tree_91_c649;
			REAL   final_score_tree_91_c648;
			REAL   final_score_tree_91_c646;
			REAL   final_score_tree_91;
			REAL   final_score_tree_92_c653;
			REAL   final_score_tree_92_c652;
			REAL   final_score_tree_92_c651;
			REAL   final_score_tree_92_c654;
			REAL   final_score_tree_92;
			REAL   final_score_tree_93_c657;
			REAL   final_score_tree_93_c656;
			REAL   final_score_tree_93_c659;
			REAL   final_score_tree_93_c658;
			REAL   final_score_tree_93;
			REAL   final_score_tree_94_c661;
			REAL   final_score_tree_94_c664;
			REAL   final_score_tree_94_c663;
			REAL   final_score_tree_94_c662;
			REAL   final_score_tree_94;
			REAL   final_score_tree_95_c666;
			REAL   final_score_tree_95_c668;
			REAL   final_score_tree_95_c667;
			REAL   final_score_tree_95_c669;
			REAL   final_score_tree_95;
			REAL   final_score_tree_96_c674;
			REAL   final_score_tree_96_c673;
			REAL   final_score_tree_96_c672;
			REAL   final_score_tree_96_c671;
			REAL   final_score_tree_96;
			REAL   final_score_tree_97_c677;
			REAL   final_score_tree_97_c679;
			REAL   final_score_tree_97_c678;
			REAL   final_score_tree_97_c676;
			REAL   final_score_tree_97;
			REAL   final_score_tree_98_c681;
			REAL   final_score_tree_98_c684;
			REAL   final_score_tree_98_c683;
			REAL   final_score_tree_98_c682;
			REAL   final_score_tree_98;
			REAL   final_score_tree_99_c686;
			REAL   final_score_tree_99_c689;
			REAL   final_score_tree_99_c688;
			REAL   final_score_tree_99_c687;
			REAL   final_score_tree_99;
			REAL   final_score_tree_100_c692;
			REAL   final_score_tree_100_c691;
			REAL   final_score_tree_100_c694;
			REAL   final_score_tree_100_c693;
			REAL   final_score_tree_100;
			REAL   final_score_tree_101_c697;
			REAL   final_score_tree_101_c696;
			REAL   final_score_tree_101_c699;
			REAL   final_score_tree_101_c698;
			REAL   final_score_tree_101;
			REAL   final_score_tree_102_c704;
			REAL   final_score_tree_102_c703;
			REAL   final_score_tree_102_c702;
			REAL   final_score_tree_102_c701;
			REAL   final_score_tree_102;
			REAL   final_score_tree_103_c706;
			REAL   final_score_tree_103_c709;
			REAL   final_score_tree_103_c708;
			REAL   final_score_tree_103_c707;
			REAL   final_score_tree_103;
			REAL   final_score_tree_104_c711;
			REAL   final_score_tree_104_c713;
			REAL   final_score_tree_104_c714;
			REAL   final_score_tree_104_c712;
			REAL   final_score_tree_104;
			REAL   final_score_tree_105_c717;
			REAL   final_score_tree_105_c716;
			REAL   final_score_tree_105_c718;
			REAL   final_score_tree_105_c719;
			REAL   final_score_tree_105;
			REAL   final_score_tree_106_c722;
			REAL   final_score_tree_106_c721;
			REAL   final_score_tree_106_c724;
			REAL   final_score_tree_106_c723;
			REAL   final_score_tree_106;
			REAL   final_score_tree_107_c727;
			REAL   final_score_tree_107_c729;
			REAL   final_score_tree_107_c728;
			REAL   final_score_tree_107_c726;
			REAL   final_score_tree_107;
			REAL   final_score_tree_108_c732;
			REAL   final_score_tree_108_c734;
			REAL   final_score_tree_108_c733;
			REAL   final_score_tree_108_c731;
			REAL   final_score_tree_108;
			REAL   final_score_tree_109_c737;
			REAL   final_score_tree_109_c739;
			REAL   final_score_tree_109_c738;
			REAL   final_score_tree_109_c736;
			REAL   final_score_tree_109;
			REAL   final_score_tree_110_c742;
			REAL   final_score_tree_110_c744;
			REAL   final_score_tree_110_c743;
			REAL   final_score_tree_110_c741;
			REAL   final_score_tree_110;
			REAL   final_score_tree_111_c749;
			REAL   final_score_tree_111_c748;
			REAL   final_score_tree_111_c747;
			REAL   final_score_tree_111_c746;
			REAL   final_score_tree_111;
			REAL   final_score_tree_112_c752;
			REAL   final_score_tree_112_c751;
			REAL   final_score_tree_112_c754;
			REAL   final_score_tree_112_c753;
			REAL   final_score_tree_112;
			REAL   final_score_tree_113_c759;
			REAL   final_score_tree_113_c758;
			REAL   final_score_tree_113_c757;
			REAL   final_score_tree_113_c756;
			REAL   final_score_tree_113;
			REAL   final_score_tree_114_c762;
			REAL   final_score_tree_114_c761;
			REAL   final_score_tree_114_c764;
			REAL   final_score_tree_114_c763;
			REAL   final_score_tree_114;
			REAL   final_score_tree_115_c766;
			REAL   final_score_tree_115_c769;
			REAL   final_score_tree_115_c768;
			REAL   final_score_tree_115_c767;
			REAL   final_score_tree_115;
			REAL   final_score_tree_116_c772;
			REAL   final_score_tree_116_c771;
			REAL   final_score_tree_116_c774;
			REAL   final_score_tree_116_c773;
			REAL   final_score_tree_116;
			REAL   final_score_tree_117_c777;
			REAL   final_score_tree_117_c779;
			REAL   final_score_tree_117_c778;
			REAL   final_score_tree_117_c776;
			REAL   final_score_tree_117;
			REAL   final_score_tree_118_c782;
			REAL   final_score_tree_118_c784;
			REAL   final_score_tree_118_c783;
			REAL   final_score_tree_118_c781;
			REAL   final_score_tree_118;
			REAL   final_score_tree_119_c788;
			REAL   final_score_tree_119_c787;
			REAL   final_score_tree_119_c786;
			REAL   final_score_tree_119_c789;
			REAL   final_score_tree_119;
			REAL   final_score_tree_120_c792;
			REAL   final_score_tree_120_c793;
			REAL   final_score_tree_120_c791;
			REAL   final_score_tree_120_c794;
			REAL   final_score_tree_120;
			REAL   final_score_tree_121_c799;
			REAL   final_score_tree_121_c798;
			REAL   final_score_tree_121_c797;
			REAL   final_score_tree_121_c796;
			REAL   final_score_tree_121;
			REAL   final_score_tree_122_c801;
			REAL   final_score_tree_122_c803;
			REAL   final_score_tree_122_c804;
			REAL   final_score_tree_122_c802;
			REAL   final_score_tree_122;
			REAL   final_score_tree_123_c809;
			REAL   final_score_tree_123_c808;
			REAL   final_score_tree_123_c807;
			REAL   final_score_tree_123_c806;
			REAL   final_score_tree_123;
			REAL   final_score_tree_124_c812;
			REAL   final_score_tree_124_c811;
			REAL   final_score_tree_124_c814;
			REAL   final_score_tree_124_c813;
			REAL   final_score_tree_124;
			REAL   final_score_tree_125_c817;
			REAL   final_score_tree_125_c816;
			REAL   final_score_tree_125_c819;
			REAL   final_score_tree_125_c818;
			REAL   final_score_tree_125;
			REAL   final_score_tree_126_c822;
			REAL   final_score_tree_126_c823;
			REAL   final_score_tree_126_c821;
			REAL   final_score_tree_126_c824;
			REAL   final_score_tree_126;
			REAL   final_score_tree_127_c827;
			REAL   final_score_tree_127_c826;
			REAL   final_score_tree_127_c829;
			REAL   final_score_tree_127_c828;
			REAL   final_score_tree_127;
			REAL   final_score_tree_128_c832;
			REAL   final_score_tree_128_c834;
			REAL   final_score_tree_128_c833;
			REAL   final_score_tree_128_c831;
			REAL   final_score_tree_128;
			REAL   final_score_tree_129_c838;
			REAL   final_score_tree_129_c837;
			REAL   final_score_tree_129_c836;
			REAL   final_score_tree_129_c839;
			REAL   final_score_tree_129;
			REAL   final_score_tree_130_c843;
			REAL   final_score_tree_130_c842;
			REAL   final_score_tree_130_c841;
			REAL   final_score_tree_130_c844;
			REAL   final_score_tree_130;
			REAL   final_score_tree_131_c848;
			REAL   final_score_tree_131_c847;
			REAL   final_score_tree_131_c849;
			REAL   final_score_tree_131_c846;
			REAL   final_score_tree_131;
			REAL   final_score_tree_132_c854;
			REAL   final_score_tree_132_c853;
			REAL   final_score_tree_132_c852;
			REAL   final_score_tree_132_c851;
			REAL   final_score_tree_132;
			REAL   final_score_tree_133_c857;
			REAL   final_score_tree_133_c859;
			REAL   final_score_tree_133_c858;
			REAL   final_score_tree_133_c856;
			REAL   final_score_tree_133;
			REAL   final_score_tree_134_c863;
			REAL   final_score_tree_134_c862;
			REAL   final_score_tree_134_c864;
			REAL   final_score_tree_134_c861;
			REAL   final_score_tree_134;
			REAL   final_score_tree_135_c869;
			REAL   final_score_tree_135_c868;
			REAL   final_score_tree_135_c867;
			REAL   final_score_tree_135_c866;
			REAL   final_score_tree_135;
			REAL   final_score_tree_136_c873;
			REAL   final_score_tree_136_c872;
			REAL   final_score_tree_136_c874;
			REAL   final_score_tree_136_c871;
			REAL   final_score_tree_136;
			REAL   final_score_tree_137_c879;
			REAL   final_score_tree_137_c878;
			REAL   final_score_tree_137_c877;
			REAL   final_score_tree_137_c876;
			REAL   final_score_tree_137;
			REAL   final_score_tree_138_c882;
			REAL   final_score_tree_138_c884;
			REAL   final_score_tree_138_c883;
			REAL   final_score_tree_138_c881;
			REAL   final_score_tree_138;
			REAL   final_score_tree_139_c889;
			REAL   final_score_tree_139_c888;
			REAL   final_score_tree_139_c887;
			REAL   final_score_tree_139_c886;
			REAL   final_score_tree_139;
			REAL   final_score_tree_140_c892;
			REAL   final_score_tree_140_c891;
			REAL   final_score_tree_140_c894;
			REAL   final_score_tree_140_c893;
			REAL   final_score_tree_140;
			REAL   final_score_tree_141_c899;
			REAL   final_score_tree_141_c898;
			REAL   final_score_tree_141_c897;
			REAL   final_score_tree_141_c896;
			REAL   final_score_tree_141;
			REAL   final_score_tree_142_c902;
			REAL   final_score_tree_142_c904;
			REAL   final_score_tree_142_c903;
			REAL   final_score_tree_142_c901;
			REAL   final_score_tree_142;
			REAL   final_score_tree_143_c908;
			REAL   final_score_tree_143_c909;
			REAL   final_score_tree_143_c907;
			REAL   final_score_tree_143_c906;
			REAL   final_score_tree_143;
			REAL   final_score_tree_144_c914;
			REAL   final_score_tree_144_c913;
			REAL   final_score_tree_144_c912;
			REAL   final_score_tree_144_c911;
			REAL   final_score_tree_144;
			REAL   final_score_tree_145_c917;
			REAL   final_score_tree_145_c919;
			REAL   final_score_tree_145_c918;
			REAL   final_score_tree_145_c916;
			REAL   final_score_tree_145;
			REAL   final_score_tree_146_c924;
			REAL   final_score_tree_146_c923;
			REAL   final_score_tree_146_c922;
			REAL   final_score_tree_146_c921;
			REAL   final_score_tree_146;
			REAL   final_score_tree_147_c929;
			REAL   final_score_tree_147_c928;
			REAL   final_score_tree_147_c927;
			REAL   final_score_tree_147_c926;
			REAL   final_score_tree_147;
			REAL   final_score_tree_148_c932;
			REAL   final_score_tree_148_c933;
			REAL   final_score_tree_148_c934;
			REAL   final_score_tree_148_c931;
			REAL   final_score_tree_148;
			REAL   final_score_tree_149_c936;
			REAL   final_score_tree_149_c939;
			REAL   final_score_tree_149_c938;
			REAL   final_score_tree_149_c937;
			REAL   final_score_tree_149;
			REAL   final_score_tree_150_c942;
			REAL   final_score_tree_150_c941;
			REAL   final_score_tree_150_c944;
			REAL   final_score_tree_150_c943;
			REAL   final_score_tree_150;
			REAL   final_score_tree_151_c947;
			REAL   final_score_tree_151_c946;
			REAL   final_score_tree_151_c949;
			REAL   final_score_tree_151_c948;
			REAL   final_score_tree_151;
			REAL   final_score_tree_152_c953;
			REAL   final_score_tree_152_c954;
			REAL   final_score_tree_152_c952;
			REAL   final_score_tree_152_c951;
			REAL   final_score_tree_152;
			REAL   final_score_tree_153_c958;
			REAL   final_score_tree_153_c957;
			REAL   final_score_tree_153_c959;
			REAL   final_score_tree_153_c956;
			REAL   final_score_tree_153;
			REAL   final_score_tree_154_c961;
			REAL   final_score_tree_154_c963;
			REAL   final_score_tree_154_c964;
			REAL   final_score_tree_154_c962;
			REAL   final_score_tree_154;
			REAL   final_score_tree_155_c966;
			REAL   final_score_tree_155_c967;
			REAL   final_score_tree_155_c969;
			REAL   final_score_tree_155_c968;
			REAL   final_score_tree_155;
			REAL   final_score_tree_156_c971;
			REAL   final_score_tree_156_c974;
			REAL   final_score_tree_156_c973;
			REAL   final_score_tree_156_c972;
			REAL   final_score_tree_156;
			REAL   final_score_tree_157_c979;
			REAL   final_score_tree_157_c978;
			REAL   final_score_tree_157_c977;
			REAL   final_score_tree_157_c976;
			REAL   final_score_tree_157;
			REAL   final_score_tree_158_c982;
			REAL   final_score_tree_158_c981;
			REAL   final_score_tree_158_c984;
			REAL   final_score_tree_158_c983;
			REAL   final_score_tree_158;
			REAL   final_score_tree_159_c989;
			REAL   final_score_tree_159_c988;
			REAL   final_score_tree_159_c987;
			REAL   final_score_tree_159_c986;
			REAL   final_score_tree_159;
			REAL   final_score_tree_160_c992;
			REAL   final_score_tree_160_c994;
			REAL   final_score_tree_160_c993;
			REAL   final_score_tree_160_c991;
			REAL   final_score_tree_160;
			REAL   final_score_tree_161_c997;
			REAL   final_score_tree_161_c998;
			REAL   final_score_tree_161_c996;
			REAL   final_score_tree_161_c999;
			REAL   final_score_tree_161;
			REAL   final_score_tree_162_c1002;
			REAL   final_score_tree_162_c1001;
			REAL   final_score_tree_162_c1004;
			REAL   final_score_tree_162_c1003;
			REAL   final_score_tree_162;
			REAL   final_score_tree_163_c1006;
			REAL   final_score_tree_163_c1008;
			REAL   final_score_tree_163_c1009;
			REAL   final_score_tree_163_c1007;
			REAL   final_score_tree_163;
			REAL   final_score_tree_164_c1014;
			REAL   final_score_tree_164_c1013;
			REAL   final_score_tree_164_c1012;
			REAL   final_score_tree_164_c1011;
			REAL   final_score_tree_164;
			REAL   final_score_tree_165_c1017;
			REAL   final_score_tree_165_c1016;
			REAL   final_score_tree_165_c1019;
			REAL   final_score_tree_165_c1018;
			REAL   final_score_tree_165;
			REAL   final_score_tree_166_c1021;
			REAL   final_score_tree_166_c1023;
			REAL   final_score_tree_166_c1024;
			REAL   final_score_tree_166_c1022;
			REAL   final_score_tree_166;
			REAL   final_score_tree_167_c1029;
			REAL   final_score_tree_167_c1028;
			REAL   final_score_tree_167_c1027;
			REAL   final_score_tree_167_c1026;
			REAL   final_score_tree_167;
			REAL   final_score_tree_168_c1031;
			REAL   final_score_tree_168_c1034;
			REAL   final_score_tree_168_c1033;
			REAL   final_score_tree_168_c1032;
			REAL   final_score_tree_168;
			REAL   final_score_tree_169_c1039;
			REAL   final_score_tree_169_c1038;
			REAL   final_score_tree_169_c1037;
			REAL   final_score_tree_169_c1036;
			REAL   final_score_tree_169;
			REAL   final_score_tree_170_c1044;
			REAL   final_score_tree_170_c1043;
			REAL   final_score_tree_170_c1042;
			REAL   final_score_tree_170_c1041;
			REAL   final_score_tree_170;
			REAL   final_score_tree_171_c1049;
			REAL   final_score_tree_171_c1048;
			REAL   final_score_tree_171_c1047;
			REAL   final_score_tree_171_c1046;
			REAL   final_score_tree_171;
			REAL   final_score_tree_172_c1053;
			REAL   final_score_tree_172_c1052;
			REAL   final_score_tree_172_c1051;
			REAL   final_score_tree_172_c1054;
			REAL   final_score_tree_172;
			REAL   final_score_gbm_logit;
			REAL   pbr;
			REAL   sbr;
			REAL   offset;
			REAL   base;
			REAL   pts;
			Real   lgt;
			STRING osn1608_1_0;
			
			Layout_ModelOut_TMP;
			
			Risk_Indicators.Layout_BocaShell_BtSt_Out btstclam;
		END;
		Layout_Debug            doModel(clam_with_easi le)    := TRANSFORM
	#else
		Layout_ModelOut_TMP     doModel( clam_with_easi le)   := TRANSFORM  
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.bs.Bill_To_Out.truedid;
	out_st                           := le.bs.Bill_To_Out.shell_input.st;
	out_lat                          := le.bs.Bill_To_Out.shell_input.lat;
	out_long                         := le.bs.Bill_To_Out.shell_input.long;
	in_dob                           := le.bs.Bill_To_Out.shell_input.dob;
	in_email_address                 := le.bs.Bill_To_Out.shell_input.email_address;
	nas_summary                      := le.bs.Bill_To_Out.iid.nas_summary;
	nap_summary                      := le.bs.Bill_To_Out.iid.nap_summary;
	nap_type                         := le.bs.Bill_To_Out.iid.nap_type;
	rc_ssndod                        := le.bs.Bill_To_Out.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.bs.Bill_To_Out.iid.decsflag;
	rc_ssndobflag                    := le.bs.Bill_To_Out.iid.socsdobflag;
	rc_pwssndobflag                  := le.bs.Bill_To_Out.iid.pwsocsdobflag;
	rc_ssnmiskeyflag                 := le.bs.Bill_To_Out.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.bs.Bill_To_Out.iid.addrmiskeyflag;
	hdr_source_profile               := le.bs.Bill_To_Out.source_profile;
	ver_sources                      := le.bs.Bill_To_Out.header_summary.ver_sources;
	ver_sources_first_seen           := le.bs.Bill_To_Out.header_summary.ver_sources_first_seen_date;
	fnamepop                         := le.bs.Bill_To_Out.input_validation.firstname;
	lnamepop                         := le.bs.Bill_To_Out.input_validation.lastname;
	addrpop                          := le.bs.Bill_To_Out.input_validation.address;
	ssnlength                        := le.bs.Bill_To_Out.input_validation.ssn_length;
	emailpop                         := le.bs.Bill_To_Out.input_validation.email;
	hphnpop                          := le.bs.Bill_To_Out.input_validation.homephone;
	add_input_address_score          := le.bs.Bill_To_Out.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.bs.Bill_To_Out.address_verification.input_address_information.house_number_match;
	add_input_addr_not_verified      := le.bs.Bill_To_Out.address_verification.inputAddr_not_verified;
	add_input_occ_index              := le.bs.Bill_To_Out.address_verification.inputaddr_occupancy_index;
	add_input_avm_auto_val           := le.bs.Bill_To_Out.avm.input_address_information.avm_automated_valuation;
	add_input_occupants_1yr          := le.bs.Bill_To_Out.addr_risk_summary.occupants_1yr;
	add_input_turnover_1yr_in        := le.bs.Bill_To_Out.addr_risk_summary.turnover_1yr_in;
	add_input_turnover_1yr_out       := le.bs.Bill_To_Out.addr_risk_summary.turnover_1yr_out;
	add_input_nhood_vac_prop         := le.bs.Bill_To_Out.addr_risk_summary.N_Vacant_Properties;
	add_input_nhood_bus_ct           := le.bs.Bill_To_Out.addr_risk_summary.N_Business_Count;
	add_input_nhood_sfd_ct           := le.bs.Bill_To_Out.addr_risk_summary.N_SFD_Count;
	add_input_nhood_mfd_ct           := le.bs.Bill_To_Out.addr_risk_summary.N_MFD_Count;
	add_input_pop                    := le.bs.Bill_To_Out.addrPop;
	add_curr_lres                    := le.bs.Bill_To_Out.lres2;
	add_curr_avm_auto_val            := le.bs.Bill_To_Out.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.bs.Bill_To_Out.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := le.bs.Bill_To_Out.address_verification.address_history_1.naprop;
	add_curr_occupants_1yr           := le.bs.Bill_To_Out.addr_risk_summary2.occupants_1yr;
	add_curr_turnover_1yr_in         := le.bs.Bill_To_Out.addr_risk_summary2.turnover_1yr_in;
	add_curr_turnover_1yr_out        := le.bs.Bill_To_Out.addr_risk_summary2.turnover_1yr_out;
	add_curr_nhood_vac_prop          := le.bs.Bill_To_Out.addr_risk_summary2.N_Vacant_Properties;
	add_curr_nhood_bus_ct            := le.bs.Bill_To_Out.addr_risk_summary2.N_Business_Count;
	add_curr_nhood_sfd_ct            := le.bs.Bill_To_Out.addr_risk_summary2.N_SFD_Count;
	add_curr_nhood_mfd_ct            := le.bs.Bill_To_Out.addr_risk_summary2.N_MFD_Count;
	add_curr_pop                     := le.bs.Bill_To_Out.addrPop2;
	max_lres                         := le.bs.Bill_To_Out.other_address_info.max_lres;
	addrs_15yr                       := le.bs.Bill_To_Out.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.bs.Bill_To_Out.other_address_info.isprison;
	ssns_per_adl                     := le.bs.Bill_To_Out.velocity_counters.ssns_per_adl;
	phones_per_addr_curr             := le.bs.Bill_To_Out.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.bs.Bill_To_Out.velocity_counters.ssns_per_adl_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.bs.Bill_To_Out.velocity_counters.lnames_per_adl180);   
	adls_per_addr_c6                 := le.bs.Bill_To_Out.velocity_counters.adls_per_addr_created_6months;
	phones_per_addr_c6               := if(isFCRA, 0, le.bs.Bill_To_Out.velocity_counters.phones_per_addr_created_6months );
	invalid_ssns_per_adl             := le.bs.Bill_To_Out.velocity_counters.invalid_ssns_per_adl;
	invalid_addrs_per_adl            := le.bs.Bill_To_Out.velocity_counters.invalid_addrs_per_adl;
	inq_email_ver_count              := le.bs.Bill_To_Out.acc_logs.inquiry_email_ver_ct;
	
	inq_count_day                    := if(isFCRA, 0, le.bs.Bill_To_Out.acc_logs.inquiries.countday);
	inq_count_week                   := if(isFCRA, 0, le.bs.Bill_To_Out.acc_logs.inquiries.countweek);
			
	inq_count                        := le.bs.Bill_To_Out.acc_logs.inquiries.counttotal;
	inq_count01                      := le.bs.Bill_To_Out.acc_logs.inquiries.count01;
	inq_count03                      := le.bs.Bill_To_Out.acc_logs.inquiries.count03;
	inq_count06                      := le.bs.Bill_To_Out.acc_logs.inquiries.count06;
	inq_count12                      := le.bs.Bill_To_Out.acc_logs.inquiries.count12;
	inq_count24                      := le.bs.Bill_To_Out.acc_logs.inquiries.count24;
	inq_auto_count                   := le.bs.Bill_To_Out.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.bs.Bill_To_Out.acc_logs.auto.count01;
	inq_auto_count03                 := le.bs.Bill_To_Out.acc_logs.auto.count03;
	inq_auto_count06                 := le.bs.Bill_To_Out.acc_logs.auto.count06;
	inq_auto_count12                 := le.bs.Bill_To_Out.acc_logs.auto.count12;
	inq_auto_count24                 := le.bs.Bill_To_Out.acc_logs.auto.count24;
	inq_collection_count             := le.bs.Bill_To_Out.acc_logs.collection.counttotal;
	inq_collection_count01           := le.bs.Bill_To_Out.acc_logs.collection.count01;
	inq_collection_count03           := le.bs.Bill_To_Out.acc_logs.collection.count03;
	inq_collection_count06           := le.bs.Bill_To_Out.acc_logs.collection.count06;
	inq_collection_count12           := le.bs.Bill_To_Out.acc_logs.collection.count12;
	inq_collection_count24           := le.bs.Bill_To_Out.acc_logs.collection.count24;
	inq_highriskcredit_count12       := le.bs.Bill_To_Out.acc_logs.highriskcredit.count12;
	inq_prepaidcards_count           := le.bs.Bill_To_Out.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.bs.Bill_To_Out.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.bs.Bill_To_Out.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.bs.Bill_To_Out.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.bs.Bill_To_Out.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.bs.Bill_To_Out.acc_logs.prepaidcards.count24;
	inq_retail_count                 := le.bs.Bill_To_Out.acc_logs.retail.counttotal;
	inq_retail_count01               := le.bs.Bill_To_Out.acc_logs.retail.count01;
	inq_retail_count03               := le.bs.Bill_To_Out.acc_logs.retail.count03;
	inq_retail_count06               := le.bs.Bill_To_Out.acc_logs.retail.count06;
	inq_retail_count12               := le.bs.Bill_To_Out.acc_logs.retail.count12;
	inq_retail_count24               := le.bs.Bill_To_Out.acc_logs.retail.count24;
	inq_retailpayments_count         := le.bs.Bill_To_Out.acc_logs.retailpayments.counttotal;
	inq_retailpayments_count01       := le.bs.Bill_To_Out.acc_logs.retailpayments.count01;
	inq_retailpayments_count03       := le.bs.Bill_To_Out.acc_logs.retailpayments.count03;
	inq_retailpayments_count06       := le.bs.Bill_To_Out.acc_logs.retailpayments.count06;
	inq_retailpayments_count12       := le.bs.Bill_To_Out.acc_logs.retailpayments.count12;
	inq_retailpayments_count24       := le.bs.Bill_To_Out.acc_logs.retailpayments.count24;
	stl_inq_count                    := le.bs.Bill_To_Out.impulse.count;
	email_count                      := le.bs.Bill_To_Out.email_summary.email_ct;
	email_verification               := le.bs.Bill_To_Out.email_summary.identity_email_verification_level;
	email_name_addr_verification     := le.bs.Bill_To_Out.email_summary.reverse_email.verification_level;
	adl_per_email                    := le.bs.Bill_To_Out.email_summary.reverse_email.adls_per_email;
	attr_total_number_derogs         := le.bs.Bill_To_Out.total_number_derogs;
	attr_num_unrel_liens60           := le.bs.Bill_To_Out.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bs.Bill_To_Out.bjl.eviction_count;
	attr_eviction_count90            := le.bs.Bill_To_Out.bjl.eviction_count90;
	attr_eviction_count180           := le.bs.Bill_To_Out.bjl.eviction_count180;
	attr_eviction_count12            := le.bs.Bill_To_Out.bjl.eviction_count12;
	attr_eviction_count24            := le.bs.Bill_To_Out.bjl.eviction_count24;
	attr_eviction_count36            := le.bs.Bill_To_Out.bjl.eviction_count36;
	attr_eviction_count60            := le.bs.Bill_To_Out.bjl.eviction_count60;
	fp_srchunvrfdphonecount          := le.bs.Bill_To_Out.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.bs.Bill_To_Out.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountwk          := le.bs.Bill_To_Out.fdattributesv2.searchfraudsearchcountweek;
	fp_divaddrsuspidcountnew         := le.bs.Bill_To_Out.fdattributesv2.divaddrsuspidentitycountnew;
	fp_srchssnsrchcountmo            := le.bs.Bill_To_Out.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcountmo           := le.bs.Bill_To_Out.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchphonesrchcountmo          := le.bs.Bill_To_Out.fdattributesv2.searchphonesearchcountmonth;
	fp_componentcharrisktype         := le.bs.Bill_To_Out.fdattributesv2.componentcharrisklevel;
	fp_addrchangeincomediff          := le.bs.Bill_To_Out.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.bs.Bill_To_Out.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.bs.Bill_To_Out.fdattributesv2.addrchangecrimediff;
	fp_curraddrmedianincome          := le.bs.Bill_To_Out.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.bs.Bill_To_Out.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.bs.Bill_To_Out.fdattributesv2.curraddrmurderindex;
	fp_curraddrcartheftindex         := le.bs.Bill_To_Out.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.bs.Bill_To_Out.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.bs.Bill_To_Out.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest             := le.bs.Bill_To_Out.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.bs.Bill_To_Out.fdattributesv2.prevaddrlenofres;
	fp_prevaddrdwelltype             := le.bs.Bill_To_Out.fdattributesv2.prevaddrdwelltype;
	fp_prevaddrmedianincome          := le.bs.Bill_To_Out.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmurderindex           := le.bs.Bill_To_Out.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex         := le.bs.Bill_To_Out.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.bs.Bill_To_Out.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex            := le.bs.Bill_To_Out.fdattributesv2.prevaddrcrimeindex;
	
	liens_recent_unreleased_count    := le.bs.Bill_To_Out.bjl.liens_recent_unreleased_count;

	liens_historical_unreleased_ct   := le.bs.Bill_To_Out.bjl.liens_historical_unreleased_count;
	
	liens_unrel_cj_last_seen         := le.bs.Bill_To_Out.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	criminal_last_date               := le.bs.Bill_To_Out.bjl.last_criminal_date;
	felony_count                     := le.bs.Bill_To_Out.bjl.felony_count;
	foreclosure_last_date            := le.bs.Bill_To_Out.bjl.last_foreclosure_date;
	hh_members_ct                    := le.bs.Bill_To_Out.hhid_summary.hh_members_ct;
	hh_payday_loan_users             := le.bs.Bill_To_Out.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.bs.Bill_To_Out.hhid_summary.hh_members_w_derog;
	hh_criminals                     := le.bs.Bill_To_Out.hhid_summary.hh_criminals;
	rel_count                        := le.bs.Bill_To_Out.relatives.relative_count;
	rel_bankrupt_count               := le.bs.Bill_To_Out.relatives.relative_bankrupt_count;
	rel_criminal_count               := le.bs.Bill_To_Out.relatives.relative_criminal_count;
	rel_felony_count                 := le.bs.Bill_To_Out.relatives.relative_felony_count;
	rel_within25miles_count          := le.bs.Bill_To_Out.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.bs.Bill_To_Out.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.bs.Bill_To_Out.relatives.relative_within500miles_count;
	rel_homeunder200_count           := le.bs.Bill_To_Out.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.bs.Bill_To_Out.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.bs.Bill_To_Out.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.bs.Bill_To_Out.relatives.relative_homeover500_count;
	rel_ageunder40_count             := le.bs.Bill_To_Out.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.bs.Bill_To_Out.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.bs.Bill_To_Out.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.bs.Bill_To_Out.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.bs.Bill_To_Out.relatives.relative_ageover70_count;
	acc_last_seen                    := le.bs.Bill_To_Out.accident_data.acc.datelastaccident;
	inferred_age                     := le.bs.Bill_To_Out.inferred_age;
	addr_stability_v2                := le.bs.Bill_To_Out.addr_stability;
	estimated_income                 := le.bs.Bill_To_Out.estimated_income;
	
	
	/*    SHIP TO ATTRIBUTES                     */ 
	truedid_s                        := le.bs.Ship_To_Out.truedid;
	out_z5_s                         := le.bs.Ship_To_Out.shell_input.z5;
	out_addr_type_s                  := le.bs.Ship_To_Out.shell_input.addr_type;
	in_dob_s                         := le.bs.Ship_To_Out.shell_input.dob;
	nas_summary_s                    := le.bs.Ship_To_Out.iid.nas_summary;
	nap_summary_s                    := le.bs.Ship_To_Out.iid.nap_summary;
	rc_hriskaddrflag_s               := le.bs.Ship_To_Out.iid.hriskaddrflag;
	rc_dwelltype_s                   := le.bs.Ship_To_Out.iid.dwelltype;
	rc_ziptypeflag_s                 := le.bs.Ship_To_Out.iid.ziptypeflag;
	rc_zipclass_s                    := le.bs.Ship_To_Out.iid.zipclass;
	hdr_source_profile_s             := le.bs.Ship_To_Out.source_profile;
	ver_sources_s                    := le.bs.Ship_To_Out.header_summary.ver_sources;
	ver_sources_first_seen_s         := le.bs.Ship_To_Out.header_summary.ver_sources_first_seen_date;
	
	fnamepop_s                       := le.bs.Ship_To_Out.input_validation.firstname;
	lnamepop_s                       := le.bs.Ship_To_Out.input_validation.lastname;
	addrpop_s                        := le.bs.Ship_To_Out.input_validation.address;
	ssnlength_s                      := le.bs.Ship_To_Out.input_validation.ssn_length;	
	
	emailpop_s                       := le.bs.Ship_To_Out.input_validation.email;
	util_adl_type_list_s             := le.bs.Ship_To_Out.utility.utili_adl_type;
	add_input_address_score_s        := le.bs.Ship_To_Out.address_verification.input_address_information.address_score;
	add_input_dirty_address_s        := le.bs.Ship_To_Out.address_verification.inputaddr_dirty;
	add_input_addr_not_verified_s    := le.bs.Ship_To_Out.address_verification.inputAddr_not_verified;
	add_input_avm_auto_val_s         := le.bs.Ship_To_Out.avm.input_address_information.avm_automated_valuation;
	add_input_naprop_s               := le.bs.Ship_To_Out.address_verification.input_address_information.naprop;
	add_input_occupants_1yr_s        := le.bs.Ship_To_Out.addr_risk_summary.occupants_1yr;
	add_input_turnover_1yr_in_s      := le.bs.Ship_To_Out.addr_risk_summary.turnover_1yr_in;
	add_input_turnover_1yr_out_s     := le.bs.Ship_To_Out.addr_risk_summary.turnover_1yr_out;
	add_input_nhood_vac_prop_s       := le.bs.Ship_To_Out.addr_risk_summary.N_Vacant_Properties;
	add_input_nhood_bus_ct_s         := le.bs.Ship_To_Out.addr_risk_summary.N_Business_Count;
	add_input_nhood_sfd_ct_s         := le.bs.Ship_To_Out.addr_risk_summary.N_SFD_Count;
	add_input_nhood_mfd_ct_s         := le.bs.Ship_To_Out.addr_risk_summary.N_MFD_Count;
	add_input_pop_s                  := le.bs.Ship_To_Out.addrPop;
	property_owned_total_s           := le.bs.Ship_To_Out.address_verification.owned.property_total;
	add_curr_lres_s                  := le.bs.Ship_To_Out.lres2;
	add_curr_avm_auto_val_s          := le.bs.Ship_To_Out.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2_s        := le.bs.Ship_To_Out.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop_s                := le.bs.Ship_To_Out.address_verification.address_history_1.naprop;
	add_curr_occupants_1yr_s         := le.bs.Ship_To_Out.addr_risk_summary2.occupants_1yr;
	add_curr_turnover_1yr_in_s       := le.bs.Ship_To_Out.addr_risk_summary2.turnover_1yr_in;
	add_curr_turnover_1yr_out_s      := le.bs.Ship_To_Out.addr_risk_summary2.turnover_1yr_out;
	add_curr_nhood_bus_ct_s          := le.bs.Ship_To_Out.addr_risk_summary2.N_Business_Count;
	add_curr_nhood_sfd_ct_s          := le.bs.Ship_To_Out.addr_risk_summary2.N_SFD_Count;
	add_curr_nhood_mfd_ct_s          := le.bs.Ship_To_Out.addr_risk_summary2.N_MFD_Count;
	add_curr_pop_s                   := le.bs.Ship_To_Out.addrPop2;
	add_prev_naprop_s                := le.bs.Ship_To_Out.address_verification.address_history_2.naprop;
	max_lres_s                       := le.bs.Ship_To_Out.other_address_info.max_lres;
	addrs_10yr_s                     := le.bs.Ship_To_Out.other_address_info.addrs_last_10years;
	adls_per_addr_curr_s             := le.bs.Ship_To_Out.velocity_counters.adls_per_addr_current;
	phones_per_addr_curr_s           := le.bs.Ship_To_Out.velocity_counters.phones_per_addr_current;
	adls_per_addr_c6_s               := le.bs.Ship_To_Out.velocity_counters.adls_per_addr_created_6months;
	invalid_addrs_per_adl_s          := le.bs.Ship_To_Out.velocity_counters.invalid_addrs_per_adl;
	
	inq_count_day_s                  := if(isFCRA, 0, le.bs.Ship_To_Out.acc_logs.inquiries.countday);
	inq_count_week_s                 := if(isFCRA, 0, le.bs.Ship_To_Out.acc_logs.inquiries.countweek);
	
	inq_count24_s                    := le.bs.Ship_To_Out.acc_logs.inquiries.count24;
	inq_auto_count24_s               := le.bs.Ship_To_Out.acc_logs.auto.count24;
	inq_banking_count24_s            := le.bs.Ship_To_Out.acc_logs.banking.count24;
	inq_communications_count_s       := le.bs.Ship_To_Out.acc_logs.communications.counttotal;
	inq_communications_count01_s     := le.bs.Ship_To_Out.acc_logs.communications.count01;
	inq_communications_count03_s     := le.bs.Ship_To_Out.acc_logs.communications.count03;
	inq_communications_count06_s     := le.bs.Ship_To_Out.acc_logs.communications.count06;
	inq_communications_count12_s     := le.bs.Ship_To_Out.acc_logs.communications.count12;
	inq_communications_count24_s     := le.bs.Ship_To_Out.acc_logs.communications.count24;
	inq_retailpayments_count_s       := le.bs.Ship_To_Out.acc_logs.retailpayments.counttotal;
	inq_retailpayments_count01_s     := le.bs.Ship_To_Out.acc_logs.retailpayments.count01;
	inq_retailpayments_count03_s     := le.bs.Ship_To_Out.acc_logs.retailpayments.count03;
	inq_retailpayments_count06_s     := le.bs.Ship_To_Out.acc_logs.retailpayments.count06;
	inq_retailpayments_count12_s     := le.bs.Ship_To_Out.acc_logs.retailpayments.count12;
	inq_retailpayments_count24_s     := le.bs.Ship_To_Out.acc_logs.retailpayments.count24;
	inq_peraddr_s                    := if(isFCRA, 0, le.bs.Ship_To_Out.acc_logs.inquiryPerAddr );
	inq_ssnsperaddr_s                := if(isFCRA, 0, le.bs.Ship_To_Out.acc_logs.inquirySSNsPerAddr );
	br_source_count_s                := le.bs.Ship_To_Out.employment.source_ct;
	email_count_s                    := le.bs.Ship_To_Out.email_summary.email_ct;
	email_verification_s             := le.bs.Ship_To_Out.email_summary.identity_email_verification_level;
	email_name_addr_verification_s   := le.bs.Ship_To_Out.email_summary.reverse_email.verification_level;
	attr_total_number_derogs_s       := le.bs.Ship_To_Out.total_number_derogs;
	fp_varrisktype_s                 := le.bs.Ship_To_Out.fdattributesv2.variationrisklevel;
	fp_srchvelocityrisktype_s        := le.bs.Ship_To_Out.fdattributesv2.searchvelocityrisklevel;
	fp_validationrisktype_s          := le.bs.Ship_To_Out.fdattributesv2.validationrisklevel;
	fp_componentcharrisktype_s       := le.bs.Ship_To_Out.fdattributesv2.componentcharrisklevel;
	fp_addrchangeincomediff_s        := le.bs.Ship_To_Out.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff_s         := le.bs.Ship_To_Out.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff_s         := le.bs.Ship_To_Out.fdattributesv2.addrchangecrimediff;
	fp_addrchangeecontrajindex_s     := le.bs.Ship_To_Out.fdattributesv2.addrchangeecontrajectoryindex;
	fp_curraddrmedianincome_s        := le.bs.Ship_To_Out.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue_s         := le.bs.Ship_To_Out.fdattributesv2.curraddrmedianvalue;
	fp_curraddrcartheftindex_s       := le.bs.Ship_To_Out.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex_s       := le.bs.Ship_To_Out.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex_s          := le.bs.Ship_To_Out.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrageoldest_s           := le.bs.Ship_To_Out.fdattributesv2.prevaddrageoldest;
	fp_prevaddrmedianincome_s        := le.bs.Ship_To_Out.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue_s         := le.bs.Ship_To_Out.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex_s         := le.bs.Ship_To_Out.fdattributesv2.prevaddrmurderindex;
	fp_prevaddrcartheftindex_s       := le.bs.Ship_To_Out.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex_s       := le.bs.Ship_To_Out.fdattributesv2.prevaddrburglaryindex;
	fp_prevaddrcrimeindex_s          := le.bs.Ship_To_Out.fdattributesv2.prevaddrcrimeindex;
	liens_rel_cj_total_amount_s      := le.bs.Ship_To_Out.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_ft_first_seen_s      := le.bs.Ship_To_Out.liens.liens_unreleased_federal_tax.earliest_filing_date;
	liens_unrel_ot_first_seen_s      := le.bs.Ship_To_Out.liens.liens_unreleased_other_tax.earliest_filing_date;
	criminal_last_date_s             := le.bs.Ship_To_Out.bjl.last_criminal_date;
	rel_count_s                      := le.bs.Ship_To_Out.relatives.relative_count;
	rel_bankrupt_count_s             := le.bs.Ship_To_Out.relatives.relative_bankrupt_count;
	crim_rel_within25miles_s         := le.bs.Ship_To_Out.relatives.criminal_relative_within25miles;
	crim_rel_within100miles_s        := le.bs.Ship_To_Out.relatives.criminal_relative_within100miles;
	crim_rel_within500miles_s        := le.bs.Ship_To_Out.relatives.criminal_relative_within500miles;
	rel_within25miles_count_s        := le.bs.Ship_To_Out.relatives.relative_within25miles_count;
	rel_within100miles_count_s       := le.bs.Ship_To_Out.relatives.relative_within100miles_count;
	rel_incomeunder100_count_s       := le.bs.Ship_To_Out.relatives.relative_incomeunder100_count;
	rel_incomeover100_count_s        := le.bs.Ship_To_Out.relatives.relative_incomeover100_count;
	rel_homeunder300_count_s         := le.bs.Ship_To_Out.relatives.relative_homeunder300_count;
	rel_homeunder500_count_s         := le.bs.Ship_To_Out.relatives.relative_homeunder500_count;
	rel_homeover500_count_s          := le.bs.Ship_To_Out.relatives.relative_homeover500_count;
	acc_damage_amt_total_s           := le.bs.Ship_To_Out.accident_data.acc.dmgamtaccidents;
	wealth_index_s                   := le.bs.Ship_To_Out.wealth_indicator;
	inferred_age_s                   := le.bs.Ship_To_Out.inferred_age;
	addr_stability_v2_s              := le.bs.Ship_To_Out.addr_stability;
	estimated_income_s               := le.bs.Ship_To_Out.estimated_income;
	
	/*  add these fields to support the FD3 reason codes   */ 
	nap_type_s									   := le.bs.Ship_To_Out.iid.nap_type;
	attr_num_unrel_liens60_s       := le.bs.Ship_To_Out.bjl.liens_unreleased_count60;
	attr_eviction_count_s	       	 := le.bs.Ship_To_Out.bjl.eviction_count;
	stl_inq_count_s		      			 := le.bs.Ship_To_Out.impulse.count;
	rc_decsflag_s		      			   := le.bs.Ship_To_Out.iid.decsflag;
	rc_ssndod_s                    := le.bs.Ship_To_out.ssn_verification.validation.deceasedDate;
	rc_ssndobflag_s		       			 := (integer) le.bs.Ship_To_Out.iid.socsdobflag;
	rc_pwssndobflag_s              := (integer) le.bs.Ship_To_Out.iid.pwsocsdobflag;
	rc_ssnmiskeyflag_s             := le.bs.Ship_To_Out.iid.socsmiskeyflag;
	rc_addrmiskeyflag_s            := le.bs.Ship_To_Out.iid.addrmiskeyflag;
	add_input_house_number_match_s := (integer)le.bs.Ship_To_out.address_verification.input_address_information.house_number_match;
	ssns_per_adl_s                 := le.bs.Ship_To_out.velocity_counters.ssns_per_adl;
	adls_per_ssn_s                 := le.bs.Ship_To_out.ssn_verification.adlperssn_count;	 
	invalid_ssns_per_adl_s         := le.bs.Ship_To_out.velocity_counters.invalid_ssns_per_adl;
	hh_payday_loan_users_s         := le.bs.Ship_To_out.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog_s           := le.bs.Ship_To_Out.hhid_summary.hh_members_w_derog;
	ssns_per_adl_c6_s              := le.bs.Ship_To_out.velocity_counters.ssns_per_adl_created_6months;
	lnames_per_adl_c6_s            := if(isFCRA, 0, le.bs.Ship_To_out.velocity_counters.lnames_per_adl180);
	fp_srchssnsrchcountmo_s        := le.bs.Ship_To_out.fdattributesv2.searchssnsearchcountmonth;
	inq_collection_count12_s       := le.bs.Ship_To_Out.acc_logs.collection.count12;
	hh_criminals_s                 := le.bs.Ship_To_Out.hhid_summary.hh_criminals;
	inq_count03_s                  := le.bs.Ship_To_Out.acc_logs.inquiries.count03;
	fp_srchaddrsrchcountmo_s			 := le.bs.Ship_To_Out.fdattributesv2.searchaddrsearchcountmonth;
	hphnpop_s                      := le.bs.Ship_To_Out.input_validation.homephone;
	felony_count_s                 := le.bs.Ship_To_Out.bjl.felony_count;
	addrs_prison_history_s         := le.bs.Ship_To_Out.other_address_info.isprison;
	inq_highriskcredit_count12_s   := le.bs.Ship_To_Out.acc_logs.highriskcredit.count12;
	fp_srchfraudsrchcountyr_s      := le.bs.Ship_To_Out.fdattributesv2.searchfraudsearchcountyear;
	fp_srchphonesrchcountmo_s      := le.bs.Ship_To_Out.fdattributesv2.searchphonesearchcountmonth;
  hh_members_ct_s                := le.bs.Ship_To_Out.hhid_summary.hh_members_ct;
	rel_felony_count_s             := le.bs.Ship_To_Out.relatives.relative_felony_count;
	inq_count12_s                  := le.bs.Ship_To_Out.acc_logs.inquiries.count12;
	
	BT_cen_blue_col                  := le.BT_Census.easi.blue_col;
	BT_cen_business                  := le.BT_Census.easi.business;
	BT_cen_civ_emp                   := le.BT_Census.easi.civ_emp;
	BT_cen_easiqlife                 := le.BT_Census.easi.easiqlife;
	BT_cen_families                  := le.BT_Census.easi.families;
	BT_cen_health                    := le.BT_Census.easi.health;
	BT_cen_high_ed                   := le.BT_Census.easi.high_ed;
	BT_cen_high_hval                 := le.BT_Census.easi.high_hval;
	BT_cen_incollege                 := le.BT_Census.easi.incollege;
	BT_cen_lar_fam                   := le.BT_Census.easi.lar_fam;
	BT_cen_low_hval                  := le.BT_Census.easi.low_hval;
	BT_cen_med_hhinc                 := le.BT_Census.easi.med_hhinc;
	BT_cen_med_hval                  := le.BT_Census.easi.med_hval;
	BT_cen_med_rent                  := le.BT_Census.easi.med_rent;
	BT_cen_mil_emp                   := le.BT_Census.easi.mil_emp;
	BT_cen_no_move                   := le.BT_Census.easi.no_move;
	BT_cen_ownocc_p                  := le.BT_Census.easi.ownocp;
	BT_cen_pop_0_5_p                 := le.BT_Census.easi.pop_0_5_p;
	BT_cen_rental                    := le.BT_Census.easi.rental;
	BT_cen_retired2                  := le.BT_Census.easi.retired2;
	BT_cen_span_lang                 := le.BT_Census.easi.span_lang;
	BT_cen_totcrime                  := le.BT_Census.easi.totcrime;
	BT_cen_trailer                   := le.BT_Census.easi.trailer;
  BT_cen_unemp                     := le.BT_Census.easi.unemp;
	BT_cen_urban_p                   := le.BT_Census.easi.urban_p;
	BT_cen_vacant_p                  := le.BT_Census.easi.vacant_p;
	BT_cen_very_rich                 := le.BT_Census.easi.very_rich;
	
	/*  Ship to data                                  */  
	ST_cen_blue_col                  := le.ST_Census.easi.blue_col;
	ST_cen_business                  := le.ST_Census.easi.business;
	ST_cen_civ_emp                   := le.ST_Census.easi.civ_emp;
	ST_cen_easiqlife                 := le.ST_Census.easi.easiqlife;
	ST_cen_families                  := le.ST_Census.easi.families;
	ST_cen_health                    := le.ST_Census.easi.health;
	ST_cen_high_ed                   := le.ST_Census.easi.high_ed;
	ST_cen_high_hval                 := le.ST_Census.easi.high_hval;
	ST_cen_incollege                 := le.ST_Census.easi.incollege;
	ST_cen_lar_fam                   := le.ST_Census.easi.lar_fam;
	ST_cen_low_hval                  := le.ST_Census.easi.low_hval;
	ST_cen_med_hhinc                 := le.ST_Census.easi.med_hhinc;
	ST_cen_med_hval                  := le.ST_Census.easi.med_hval;
	ST_cen_med_rent                  := le.ST_Census.easi.med_rent;
	ST_cen_mil_emp                   := le.ST_Census.easi.mil_emp;
	ST_cen_no_move                   := le.ST_Census.easi.no_move;
	ST_cen_ownocc_p                  := le.ST_Census.easi.ownocp;
	ST_cen_pop_0_5_p                 := le.ST_Census.easi.pop_0_5_p;
	ST_cen_rental                    := le.ST_Census.easi.rental;
	ST_cen_retired2                  := le.ST_Census.easi.retired2;
	ST_cen_span_lang                 := le.ST_Census.easi.span_lang;
	ST_cen_totcrime                  := le.ST_Census.easi.totcrime;
	ST_cen_trailer                   := le.ST_Census.easi.trailer;
	ST_cen_unemp                     := le.ST_Census.easi.unemp;
	ST_cen_urban_p                   := le.ST_Census.easi.urban_p;
	ST_cen_vacant_p                  := le.ST_Census.easi.vacant_p;
	ST_cen_very_rich                 := le.ST_Census.easi.very_rich;
	
	
	addrscore                        := le.bs.eddo.addrscore;
	continent                        := le.bs.ip2o.continent;
	distaddraddr2                    := le.bs.eddo.distaddraddr2;
	efirstscore                      := le.bs.eddo.efirstscore;
	elastscore                       := le.bs.eddo.elastscore;
	ipaddr                           := le.bs.ip2o.ipaddr;
	ipconnection                     := le.bs.ip2o.ipconnection;
	ipdma                            := trim(le.bs.ip2o.ipdma);
	iproutingmethod                  := le.bs.ip2o.iproutingmethod;
	iptimezone                       := le.bs.ip2o.iptimezone;
	lastscore                        := le.bs.eddo.lastscore;
	latitude                         := le.bs.ip2o.latitude;
	longitude                        := le.bs.ip2o.longitude;
	state                            := le.bs.ip2o.state;
	topleveldomain                   := le.bs.ip2o.topleveldomain;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	
	
	/*  Round 1 validation will alway use a hard coded date so that it is run in "archive mode"  */  	
#if(ROUND1_VALIDATION)
       sysdate := common.sas_date('20150511');
#else
       /*  if the history date is all 9's run the model in    CURRENT mode        ELSE    run in ARCHIVE mode          */   	     
			 sysdate := common.sas_date(if(le.bs.Bill_To_Out.historydate=999999, (string8)Std.Date.Today(), (string6)le.bs.Bill_To_Out.historydate + '01'));
#end
	
	b_nap_addr_verd_d     := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);
	b_nap_lname_verd_d    := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);
	b_nap_nothing_found_i := (nap_summary in [0]);
	
	b_f01_inp_addr_address_score_d := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));
	
	b_d30_derog_count_i := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));
	
	_criminal_last_date := Common.SAS_Date((STRING)(criminal_last_date));
	
	b_d32_mos_since_crim_ls_d := map(
	    not(truedid)               => NULL,
	    _criminal_last_date = NULL => 241,
	                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));
	
	
	b_d33_eviction_recency_d := map(
	    not(truedid)                 => NULL,
	    attr_eviction_count90 > 0    => 3,                  // if there are any evictions assign these values accordingly
	    attr_eviction_count180 > 0   => 6,
	    attr_eviction_count12  > 0   => 12,
	    attr_eviction_count24  > 0   => 24,
	    attr_eviction_count36  > 0   => 36,
	    attr_eviction_count60  > 0   => 60,
	    attr_eviction_count   >= 1   => 99,
	                                    999);
	
	b_d33_eviction_count_i := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));
	
	b_d34_unrel_liens_ct_i := if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999));
	
	/*  Use the Models.Common.findw_cpp to locate the value 'EQ' in the comma delimted list in ver_sources on the Bill To Ship To  */ 
	bureau_adl_eq_fseen_pos_2 := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', 'E');
	
	bureau_adl_fseen_eq_2 := if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ','));
	
	_bureau_adl_fseen_eq_2 := Common.SAS_Date((STRING)(bureau_adl_fseen_eq_2));
	
	_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999);
	
	b_c21_m_bureau_adl_fs_d := map(
	    not(truedid)                   => NULL,
	    _src_bureau_adl_fseen = 999999 => 1000,
	                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));
	
	/*  Use the Models.Common.findw_cpp to locate the value 'EQ' in the comma delimted list in ver_sources  on the Bill To Ship To */ 	
	bureau_adl_eq_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', 'E');
	
	bureau_adl_fseen_eq_1 := if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ','));
	
	_bureau_adl_fseen_eq_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_eq_1));
	
	/*  Use the Models.Common.findw_cpp to locate the value 'EN' in the comma delimted list in ver_sources  on the Bill To Ship To */ 
	bureau_adl_en_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');
	
	bureau_adl_fseen_en_1 := if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ','));
	
	_bureau_adl_fseen_en_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_en_1));
	
	/*  Use the Models.Common.findw_cpp to locate the value 'TS' in the comma delimted list in ver_sources on the Bill To Ship To  */ 
	bureau_adl_ts_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');
	
	bureau_adl_fseen_ts_1 := if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ','));
	
	_bureau_adl_fseen_ts_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_ts_1));
	
	/*  Use the Models.Common.findw_cpp to locate the value 'TU' in the comma delimted list in ver_sources on the Bill To Ship To  */ 
	bureau_adl_tu_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');
	
	bureau_adl_fseen_tu_1 := if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ','));
	
	_bureau_adl_fseen_tu_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_tu_1));
	
	/*  Use the Models.Common.findw_cpp to locate the value 'TN' in the comma delimted list in ver_sources on the Bill To Ship To  */ 
	bureau_adl_tn_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');
	
	bureau_adl_fseen_tn_1 := if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ','));
	
	_bureau_adl_fseen_tn_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_tn_1));
	
	_src_bureau_adl_fseen_all := min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, _bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999);
	
	b_m_bureau_adl_fs_all_d := map(
	    not(truedid)                       => NULL,
	    _src_bureau_adl_fseen_all = 999999 => 1000,
	                                          min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999));
	
	bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', 'E');
	
	bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));
	
	_bureau_adl_fseen_eq := Common.SAS_Date((STRING)(bureau_adl_fseen_eq));
	
	bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');
	
	bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));
	
	_bureau_adl_fseen_en := Common.SAS_Date((STRING)(bureau_adl_fseen_en));
	
	bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');
	
	bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));
	
	_bureau_adl_fseen_ts := Common.SAS_Date((STRING)(bureau_adl_fseen_ts));
	
	bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');
	
	bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));
	
	_bureau_adl_fseen_tu := Common.SAS_Date((STRING)(bureau_adl_fseen_tu));
	
	bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');
	
	bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));
	
	_bureau_adl_fseen_tn := Common.SAS_Date((STRING)(bureau_adl_fseen_tn));
	
	_src_bureau_adl_fseen_notu := min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);
	
	b_m_bureau_adl_fs_notu_d := map(
	    not(truedid)                        => NULL,
	    _src_bureau_adl_fseen_notu = 999999 => 1000,
	                                           min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999));
	
	_in_dob := Common.SAS_Date((STRING)(in_dob));
	
	yr_in_dob := if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25);
	
	yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));
	
	b_comb_age_d := map(
	    yr_in_dob_int > 0            => yr_in_dob_int,
	    inferred_age > 0 and truedid => inferred_age,
	                                    NULL);
	
	b_a44_curr_add_naprop_d := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);
	
	b_l80_inp_avm_autoval_d := map(
	    not(add_input_pop)         => NULL,
	    add_input_avm_auto_val = 0 => NULL,
	                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000));
	
	b_a46_curr_avm_autoval_d := map(
	    not(add_curr_pop)         => NULL,
	    add_curr_avm_auto_val = 0 => NULL,
	                                 min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000));
	
	b_a49_curr_avm_chg_1yr_i := map(
	    not(add_curr_pop)                                         => NULL,
	    add_curr_lres < 12                                        => NULL,
	    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
	                                                                 NULL);
	
	b_a49_curr_avm_chg_1yr_pct_i := map(
	    not(add_curr_pop)                                         => NULL,
	    add_curr_lres < 12                                        => NULL,
	    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
	                                                                 NULL);
	
	b_c13_curr_addr_lres_d := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));
	
	b_c14_addr_stability_v2_d := map(
	    not(truedid)            => NULL,
	    addr_stability_v2 = '0' => NULL,
	                             (integer)addr_stability_v2);
	
	b_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));
	
	b_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));
	
	b_c20_email_count_i := if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999));
	
	b_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));
	
	b_c18_invalid_addrs_per_adl_i := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));
	
	b_l78_no_phone_at_addr_vel_i := map(
	    not(addrpop)             => NULL,
	    phones_per_addr_curr = 0 => 1,
	                                0);
																	
/*  Inquiries                   */ 	
	b_i60_inq_recency_d := map(
	    not(truedid)          => NULL,
	    (Boolean)inq_count01  => 1,
	    (Boolean)inq_count03  => 3,
	    (Boolean)inq_count06  => 6,
	    (Boolean)inq_count12  => 12,
	    (Boolean)inq_count24  => 24,
	    (Boolean)inq_count    => 99,
	                             999);
	
	b_i61_inq_collection_recency_d := map(
	    not(truedid)                    => NULL,
	    (Boolean)inq_collection_count01 => 1,
	    (Boolean)inq_collection_count03 => 3,
	    (Boolean)inq_collection_count06 => 6,
	    (Boolean)inq_collection_count12 => 12,
	    (Boolean)inq_collection_count24 => 24,
	    (Boolean)inq_collection_count   => 99,
	                                      999);
	
	b_i60_inq_auto_recency_d := map(
	    not(truedid)     => NULL,
	    (Boolean)inq_auto_count01 => 1,
	    (Boolean)inq_auto_count03 => 3,
	    (Boolean)inq_auto_count06 => 6,
	    (Boolean)inq_auto_count12 => 12,
	    (Boolean)inq_auto_count24 => 24,
	    (Boolean)inq_auto_count   => 99,
	                        999);
	
	b_i60_inq_hiriskcred_count12_i := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));
	
	b_i60_inq_retail_recency_d := map(
	    not(truedid)       => NULL,
	    (Boolean)inq_retail_count01 => 1,
	    (Boolean)inq_retail_count03 => 3,
	    (Boolean)inq_retail_count06 => 6,
	    (Boolean)inq_retail_count12 => 12,
	    (Boolean)inq_retail_count24 => 24,
	    (Boolean)inq_retail_count   => 99,
	                                  999);
	
	b_add_input_mobility_index_i := map(
	    not(addrpop)                 => NULL,
	    add_input_occupants_1yr <= 0 => NULL,
	                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr);
	
	add_input_nhood_prop_sum_3 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));
	
	b_add_input_nhood_bus_pct_i := map(
	    not(addrpop)               => NULL,
	    add_input_nhood_BUS_ct = 0 => NULL,
	                                  add_input_nhood_BUS_ct / add_input_nhood_prop_sum_3);
	
	add_input_nhood_prop_sum_2 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));
	
	b_add_input_nhood_mfd_pct_i := map(
	    not(addrpop)               => NULL,
	    add_input_nhood_MFD_ct = 0 => NULL,
	                                  add_input_nhood_MFD_ct / add_input_nhood_prop_sum_2);
	
	add_input_nhood_prop_sum_1 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));
	
	b_add_input_nhood_sfd_pct_d := map(
	    not(addrpop)               => NULL,
	    add_input_nhood_SFD_ct = 0 => -1,
	                                  add_input_nhood_SFD_ct / add_input_nhood_prop_sum_1);
	
	add_input_nhood_prop_sum := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));
	
	b_add_input_nhood_vac_pct_i := map(
	    not(addrpop)                 => NULL,
	    add_input_nhood_prop_sum = 0 => -1,
	                                    add_input_nhood_VAC_prop / add_input_nhood_prop_sum);
	
	b_add_curr_mobility_index_i := map(
	    not(add_curr_pop)           => NULL,
	    add_curr_occupants_1yr <= 0 => NULL,
	                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr);
	
	add_curr_nhood_prop_sum_3 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	b_add_curr_nhood_bus_pct_i := map(
	    not(add_curr_pop)         => NULL,
	    add_curr_nhood_BUS_ct = 0 => NULL,
	                                 add_curr_nhood_BUS_ct / add_curr_nhood_prop_sum_3);
	
	add_curr_nhood_prop_sum_2 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	b_add_curr_nhood_mfd_pct_i := map(
	    not(add_curr_pop)         => NULL,
	    add_curr_nhood_MFD_ct = 0 => NULL,
	                                 add_curr_nhood_MFD_ct / add_curr_nhood_prop_sum_2);
	
	add_curr_nhood_prop_sum_1 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	b_add_curr_nhood_sfd_pct_d := map(
	    not(add_curr_pop)         => NULL,
	    add_curr_nhood_SFD_ct = 0 => -1,
	                                 add_curr_nhood_SFD_ct / add_curr_nhood_prop_sum_1);
	
	add_curr_nhood_prop_sum := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));
	
	b_add_curr_nhood_vac_pct_i := map(
	    not(add_curr_pop)           => NULL,
	    add_curr_nhood_prop_sum = 0 => -1,
	                                   add_curr_nhood_VAC_prop / add_curr_nhood_prop_sum);
	
	b_inq_count24_i := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));
	
	b_inq_collection_count24_i := if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999));
	
	b_inq_retail_count24_i := if(not(truedid), NULL, min(if(inq_Retail_count24 = NULL, -NULL, inq_Retail_count24), 999));
	
	_liens_unrel_cj_last_seen := Common.SAS_Date((STRING)(liens_unrel_CJ_last_seen));
	
	b_mos_liens_unrel_cj_lseen_d := map(
	    not(truedid)                     => NULL,
	    _liens_unrel_cj_last_seen = NULL => 1000,
	                                        max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999)));
	
	_foreclosure_last_date := Common.SAS_Date((STRING)(foreclosure_last_date));
	
	b_mos_foreclosure_lseen_d := map(
	    not(truedid)                  => NULL,
	    _foreclosure_last_date = NULL => 1000,
	                                     max(3, min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999)));
	
	b_estimated_income_d := if(not(truedid), NULL, estimated_income);
	
	b_rel_count_i := if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999));
	
	b_rel_homeover150_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));
	
	b_rel_homeover200_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));
	
	b_rel_ageover30_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));
	
	b_rel_ageover40_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));
	
	b_rel_ageover50_count_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));
	
	b_rel_under25miles_cnt_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     rel_within25miles_count);
	
	b_rel_under500miles_cnt_d := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => NULL,
	                     if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count))));
	
	b_rel_bankrupt_count_i := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999));
	
	b_rel_criminal_count_i := map(
	    not(truedid)  => NULL,
	    rel_count = 0 => -1,
	                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999));
	
	_acc_last_seen := Common.SAS_Date((STRING)(acc_last_seen));
	
	b_mos_acc_lseen_d := map(
	    not(truedid)          => NULL,
	    _acc_last_seen = NULL => 1000,
	                             max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12)))), 999)));
	
	b_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (Integer)fp_srchunvrfdphonecount), 999));
	
	b_srchfraudsrchcountyr_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (Integer)fp_srchfraudsrchcountyr), 999));
	
	b_srchfraudsrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (Integer)fp_srchfraudsrchcountwk), 999));
	
	b_divaddrsuspidcountnew_i := if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (Integer)fp_divaddrsuspidcountnew), 999));
	
	b_componentcharrisktype_i := map(
	    not(truedid)                    => NULL,
	    fp_componentcharrisktype = ''   => NULL,
	                                       (Integer)fp_componentcharrisktype);
	
	b_addrchangeincomediff_d_1 := if(not(truedid), NULL, NULL);
	
	b_addrchangeincomediff_d := if((Integer)fp_addrchangeincomediff = -1, NULL, (Integer)fp_addrchangeincomediff);
	
	b_addrchangevaluediff_d := map(
	    not(truedid)                         => NULL,
	    (Integer)fp_addrchangevaluediff = -1 => NULL,
	                                            (Integer)fp_addrchangevaluediff);
	
	b_addrchangecrimediff_i := map(
	    not(truedid)                           => NULL,
	    (integer)fp_addrchangecrimediff = -1   => NULL,
	                                              (Integer)fp_addrchangecrimediff);
	
	b_curraddrmedianincome_d := if(not(add_curr_pop), NULL, (Integer)fp_curraddrmedianincome);
	
	b_curraddrmedianvalue_d := if(not(add_curr_pop), NULL, (Integer)fp_curraddrmedianvalue);
	
	b_curraddrmurderindex_i := if(not(add_curr_pop), NULL, (Integer)fp_curraddrmurderindex);
	
	b_curraddrcartheftindex_i := if(not(add_curr_pop), NULL, (Integer)fp_curraddrcartheftindex);
	
	b_curraddrburglaryindex_i := if(not(add_curr_pop), NULL, (Integer)fp_curraddrburglaryindex);
	
	b_curraddrcrimeindex_i := if(not(add_curr_pop), NULL, (Integer)fp_curraddrcrimeindex);
	
	b_prevaddrageoldest_d := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (Integer)fp_prevaddrageoldest), 999));
	
	b_prevaddrlenofres_d := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (Integer)fp_prevaddrlenofres), 999));
	
	b_prevaddrdwelltype_sfd_n := if(not(truedid), NULL, (Integer)(fp_prevaddrdwelltype = 'S'));
	
	b_prevaddrmedianincome_d := if(not(truedid), NULL, (Integer)fp_prevaddrmedianincome);
	
	b_prevaddrmurderindex_i := if(not(truedid), NULL, (Integer)fp_prevaddrmurderindex);
	
	b_prevaddrcartheftindex_i := if(not(truedid), NULL, (Integer)fp_prevaddrcartheftindex);
	
	b_fp_prevaddrburglaryindex_i := if(not(truedid), NULL, (Integer)fp_prevaddrburglaryindex);
	
	b_fp_prevaddrcrimeindex_i := if(not(truedid), NULL, (Integer)fp_prevaddrcrimeindex);
	
	b_c12_source_profile_d := if(not(truedid), NULL, hdr_source_profile);
	
	b_f01_inp_addr_not_verified_i := if(not(add_input_pop and truedid), NULL, (Integer)add_input_addr_not_verified);
	
	b_c23_inp_addr_occ_index_d := if(not(add_input_pop and truedid), NULL, add_input_occ_index);
	
	b_i60_inq_prepaidcards_recency_d := map(
	    not(truedid)                      => NULL,
	    (Boolean)inq_PrepaidCards_count01 => 1,
	    (Boolean)inq_PrepaidCards_count03 => 3,
	    (Boolean)inq_PrepaidCards_count06 => 6,
	    (Boolean)inq_PrepaidCards_count12 => 12,
	    (Boolean)inq_PrepaidCards_count24 => 24,
	    (Boolean)inq_PrepaidCards_count   => 99,
	                                        999);
	
	b_i60_inq_retpymt_recency_d := map(
	    not(truedid)               => NULL,
	    (Boolean)inq_retailpayments_count01 => 1,
	    (Boolean)inq_retailpayments_count03 => 3,
	    (Boolean)inq_retailpayments_count06 => 6,
	    (Boolean)inq_retailpayments_count12 => 12,
	    (Boolean)inq_retailpayments_count24 => 24,
	    (Boolean)inq_retailpayments_count   => 99,
	                                           999);
	
	b_phones_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));
	
	b_phones_per_addr_c6_i := if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999));
	
	b_inq_email_ver_count_i := if(not(truedid), NULL, min(if(inq_email_ver_count = NULL, -NULL, inq_email_ver_count), 999));
	
	b_nae_email_verd_d := ((integer)email_name_addr_verification in [2, 3, 4, 5, 6, 7, 8]);
	
	b_nae_contradictory_i := (integer)email_name_addr_verification = 1;
	
	b_adl_per_email_i := if(not(emailpop), NULL, min(if(adl_per_email = NULL, -NULL, adl_per_email), 999));
	
	b_c20_email_verification_d := if(not(emailpop), NULL, (Integer)email_verification);
	
/* Look up ver sources for the Bill To   */ 
	_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;
	_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;
	_ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0;
	_ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0;
	_ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0;
	_ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0;
	
	/* Look up ver sources for the Ship To   */ 
  _ver_src_ds_s := Models.Common.findw_cpp(ver_sources_s, 'DS' , ',', '') > 0;
  _ver_src_de_s := Models.Common.findw_cpp(ver_sources_s, 'DE' , ',', '') > 0;
	_ver_src_eq_s := Models.Common.findw_cpp(ver_sources_s, 'EQ' , ',', '') > 0;
  _ver_src_en_s := Models.Common.findw_cpp(ver_sources_s, 'EN' , ',', '') > 0;
  _ver_src_tn_s := Models.Common.findw_cpp(ver_sources_s, 'TN' , ',', '') > 0;
	_ver_src_tu_s := Models.Common.findw_cpp(ver_sources_s, 'TU' , ',', '') > 0;

	
  bt_inq_count_day := if(not(truedid),   NULL, min(if(inq_count_day   = NULL, -NULL, inq_count_day),   999));	
	st_inq_count_day := if(not(truedid_s), NULL, min(if(inq_count_day_s = NULL, -NULL, inq_count_day_s), 999));
	
	bt_inq_count_week := if(not(truedid),   NULL, min(if(inq_count_week   = NULL, -NULL, inq_count_week),   999));
	st_inq_count_week := if(not(truedid_s), NULL, min(if(inq_count_week_s = NULL, -NULL, inq_count_week_s), 999));
	
	_credit_source_cnt   := if(max((integer)_ver_src_eq,   (integer)_ver_src_en,   
	                        (integer)_ver_src_tn,   (integer)_ver_src_tu)   = NULL, NULL, sum((integer)_ver_src_eq, 
													(integer)_ver_src_en,   (integer)_ver_src_tn,   (integer)_ver_src_tu));
  _credit_source_cnt_s := if(max((integer)_ver_src_eq_s, (integer)_ver_src_en_s, 
	                        (integer)_ver_src_tn_s, (integer)_ver_src_tu_s) = NULL, NULL, sum((integer)_ver_src_eq_s, 
	                        (integer)_ver_src_en_s, (integer)_ver_src_tn_s, (integer)_ver_src_tu));
	
	_ver_src_cnt   := Models.Common.countw((string)(ver_sources));
	_ver_src_cnt_s := Models.Common.countw((string)(StringLib.StringToUpperCase(trim(ver_sources_s, ALL))), ',');	 
	
	_bureauonly   := _credit_source_cnt > 0   AND _credit_source_cnt   = _ver_src_cnt   AND 
	                (StringLib.StringToUpperCase(nap_type)   = 'U' or (nap_summary   in [0, 1, 2, 3, 4, 6]));
  _bureauonly_s := _credit_source_cnt_s > 0 AND _credit_source_cnt_s = _ver_src_cnt_s AND 
	                (StringLib.StringToUpperCase(nap_type_s) = 'U' or (nap_summary_s in [0, 1, 2, 3, 4, 6]));
	
	_derog   := felony_count   > 0 OR addrs_prison_history   OR 
	            attr_num_unrel_liens60   > 0 OR attr_eviction_count   > 0 OR stl_inq_count   > 0 OR 
							inq_highriskcredit_count12   > 0 OR inq_collection_count12   >= 2;
	_derog_s := felony_count_s > 0 OR addrs_prison_history_s OR 
	            attr_num_unrel_liens60_s > 0 OR attr_eviction_count_s > 0 OR stl_inq_count_s > 0 OR 
	            inq_highriskcredit_count12_s > 0 OR inq_collection_count12_s >= 2;

	_deceased    := rc_decsflag    = '1'  OR rc_ssndod   != 0 OR _ver_src_ds   OR _ver_src_de;
	_deceased_s  := rc_decsflag_s  = '1'  OR rc_ssndod_s != 0 OR _ver_src_ds_s OR _ver_src_de_s;
	
	_ssnpriortodob   := (Integer)rc_ssndobflag   = 1 OR (Integer)rc_pwssndobflag   = 1;
	_ssnpriortodob_s := (Integer)rc_ssndobflag_s = 1 OR (Integer)rc_pwssndobflag_s = 1;
	
	_inputmiskeys   := rc_ssnmiskeyflag   or rc_addrmiskeyflag   or (Integer)add_input_house_number_match   = 0;
	_inputmiskeys_s := rc_ssnmiskeyflag_s or rc_addrmiskeyflag_s or (Integer)add_input_house_number_match_s = 0;
	
	_multiplessns   := ssns_per_adl   >= 2 OR ssns_per_adl_c6   >= 1 OR invalid_ssns_per_adl   >= 1;
	_multiplessns_s := ssns_per_adl_s >= 2 OR ssns_per_adl_c6_s >= 1 OR invalid_ssns_per_adl_s >= 1;
	
	_hh_strikes := if(max((integer)(hh_members_w_derog > 0), (integer)(hh_criminals > 0), 
	     (integer)(hh_payday_loan_users > 0)) = 0, NULL, sum((integer)(hh_members_w_derog > 0), 
			 (integer)(hh_criminals > 0), (integer)(hh_payday_loan_users > 0)));
			 
	_hh_strikes_s := if(max((integer)(hh_members_w_derog_s > 0), (integer)(hh_criminals_s > 0), 
		(integer)(hh_payday_loan_users_s > 0)) = 0, NULL, sum((integer)(hh_members_w_derog_s > 0), 
		(integer)(hh_criminals_s > 0), (integer)(hh_payday_loan_users_s > 0)));
	
	bf_seg_fraudpoint_3_0_BT := map(
	    addrpop and (nas_summary in [4, 7, 9])    
			    or (fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 
					and (Integer) ssnlength = 9) or _deceased or _ssnpriortodob                                              => '1: Stolen/Manip ID  ',
	    _inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1)                                                   => '1: Stolen/Manip ID  ',
	    (fnamepop and lnamepop and addrpop and (Integer) ssnlength = 9)  
			     and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly 
					 or (Integer)add_curr_pop = 0                                                                            => '2: Synth ID         ',
	    _derog                                                                                                       => '3: Derog            ',
	    Inq_count03 > 0 or Inq_count12 >= 4 or (Integer)fp_srchfraudsrchcountyr >= 1 
			    or (Integer)fp_srchssnsrchcountmo >= 1  
			    or (Integer)fp_srchaddrsrchcountmo >= 1 or (Integer)fp_srchphonesrchcountmo >= 1                         => '4: Recent Activity  ', 
	    0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70                                                => '5: Vuln Vic/Friendly',
	    hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2)                => '5: Vuln Vic/Friendly',
	                                                                                                                    '6: Other            ');
																																																											
	/*  I took this from the flagship code   */ 
	/*  I had to add this to support the Risk Indicator for this model  */  
  bf_seg_fraudpoint_3_0_ST := map(
    (addrpop_s and nas_summary_s in [4, 7, 9]) or 
		(fnamepop_s and lnamepop_s and addrpop_s and 1 <= nas_summary_s AND nas_summary_s <= 9 and 
		inq_count03_s > 0 and (integer) ssnlength_s = 9) or _deceased_s or _ssnpriortodob_s  		                      => '1: Stolen/Manip ID  ',
    _inputmiskeys_s and (_multiplessns or lnames_per_adl_c6 > 1)   										                            => '2: Synth ID         ',	
    (fnamepop_s and lnamepop_s and addrpop_s and (integer) ssnlength_s =9 and hphnpop_s and nap_summary_s <= 4 and 
		nas_summary_s <= 4) or _ver_src_cnt_s = 0 or _bureauonly_s or ~add_curr_pop_s                                 => '2: Synth ID         ',
    _derog_s                                                           								                            => '3: Derog            ',
    Inq_count03_s > 0 or Inq_count12_s >= 4 or (integer)fp_srchfraudsrchcountyr_s >= 1 or 
		(integer)fp_srchssnsrchcountmo_s >= 1 or (integer)fp_srchaddrsrchcountmo_s >= 1 or 
		(integer)fp_srchphonesrchcountmo_s >= 1 																				                              => '4: Recent Activity  ',
    0 < inferred_age_s AND inferred_age_s <= 17 or inferred_age_s >= 70 								                          => '5: Vuln Vic/Friendly',
    hh_members_ct_s > 1 and (hh_payday_loan_users_s > 0 or _hh_strikes_s >= 2 or rel_felony_count_s >= 2)         => '5: Vuln Vic/Friendly',
																																							                                       '6: Other            ');																																																											
																																																											
																																																											
	
	s_nap_addr_verd_d := (nap_summary_s in [3, 5, 6, 8, 10, 11, 12]);
	
	s_nap_lname_verd_d := (nap_summary_s in [2, 5, 7, 8, 9, 11, 12]);
	
	s_nap_nothing_found_i := (nap_summary_s in [0]);
	
	s_l77_add_po_box_i := map(
	    not(addrpop_s or not(out_z5_s = ''))                                                                                                                                                                                                                                       => NULL,
	    (integer)rc_hriskaddrflag_s = 1 or (Integer)rc_ziptypeflag_s = 1 or StringLib.StringToUpperCase(trim((string)rc_dwelltype_s, LEFT, RIGHT)) = 'E' or StringLib.StringToUpperCase(trim((string)rc_zipclass_s, LEFT, RIGHT)) = 'P' or StringLib.StringToUpperCase(trim((string)out_addr_type_s, LEFT, RIGHT)) = 'P' => 1,
	                                                                                                                                                                                                                                                                                                      0);
	
	s_f01_inp_addr_address_score_d := if(not((boolean)(integer)truedid_s and (boolean)(integer)add_input_pop_s) or add_input_address_score_s = 255, NULL, min(if(add_input_address_score_s = NULL, -NULL, add_input_address_score_s), 999));
	
	s_l70_inp_addr_dirty_i := if(not((boolean)(integer)add_input_pop_s and (boolean)(integer)truedid_s), NULL, (Integer)add_input_dirty_address_s);
	
	s_d30_derog_count_i := if(not((boolean)(integer)truedid_s), NULL, min(if(attr_total_number_derogs_s = NULL, -NULL, attr_total_number_derogs_s), 999));
	
	_criminal_last_date_s := Common.SAS_Date((STRING)(criminal_last_date_s));
	
	s_d32_mos_since_crim_ls_d := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    _criminal_last_date_s = NULL     => 241,
	                                        max(3, min(if(if ((sysdate - _criminal_last_date_s) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date_s) / (365.25 / 12)), roundup((sysdate - _criminal_last_date_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date_s) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date_s) / (365.25 / 12)), roundup((sysdate - _criminal_last_date_s) / (365.25 / 12)))), 240)));
	
	bureau_adl_eq_fseen_pos_s_1 := Models.Common.findw_cpp(ver_sources_s, 'EQ' , ',', 'E');
	
	bureau_adl_fseen_eq_s_1 := if(bureau_adl_eq_fseen_pos_s_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_eq_fseen_pos_s_1, ','));
	
	_bureau_adl_fseen_eq_s_1 := Common.SAS_Date((STRING)(bureau_adl_fseen_eq_s_1));
	
	_src_bureau_adl_fseen_s := min(if(_bureau_adl_fseen_eq_s_1 = NULL, -NULL, _bureau_adl_fseen_eq_s_1), 999999);
	
	s_c21_m_bureau_adl_fs_d := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    _src_bureau_adl_fseen_s = 999999 => 1000,
	                                        min(if(if ((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12)))), 999));
	
	bureau_adl_eq_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'EQ' , ',', 'E');
	
	bureau_adl_fseen_eq_s := if(bureau_adl_eq_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_eq_fseen_pos_s, ','));
	
	_bureau_adl_fseen_eq_s := Common.SAS_Date((STRING)(bureau_adl_fseen_eq_s));
	
	bureau_adl_en_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'EN' , ',', 'E');
	
	bureau_adl_fseen_en_s := if(bureau_adl_en_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_en_fseen_pos_s, ','));
	
	_bureau_adl_fseen_en_s := Common.SAS_Date((STRING)(bureau_adl_fseen_en_s));
	
	bureau_adl_ts_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'TS' , ',', 'E');
	
	bureau_adl_fseen_ts_s := if(bureau_adl_ts_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_ts_fseen_pos_s, ','));
	
	_bureau_adl_fseen_ts_s := Common.SAS_Date((STRING)(bureau_adl_fseen_ts_s));
	
	bureau_adl_tu_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'TU' , ',', 'E');
	
	bureau_adl_fseen_tu_s := if(bureau_adl_tu_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_tu_fseen_pos_s, ','));
	
	_bureau_adl_fseen_tu_s := Common.SAS_Date((STRING)(bureau_adl_fseen_tu_s));
	
	bureau_adl_tn_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'TN' , ',', 'E');
	
	bureau_adl_fseen_tn_s := if(bureau_adl_tn_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_tn_fseen_pos_s, ','));
	
	_bureau_adl_fseen_tn_s := Common.SAS_Date((STRING)(bureau_adl_fseen_tn_s));
	
	_src_bureau_adl_fseen_notu_s := min(if(_bureau_adl_fseen_en_s = NULL, -NULL, _bureau_adl_fseen_en_s), if(_bureau_adl_fseen_eq_s = NULL, -NULL, _bureau_adl_fseen_eq_s), 999999);
	
	s_m_bureau_adl_fs_notu_d := map(
	    not((boolean)(integer)truedid_s)      => NULL,
	    _src_bureau_adl_fseen_notu_s = 999999 => 1000,
	                                             min(if(if ((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12)))), 999));
	
	_in_dob_s := Common.SAS_Date((STRING)(in_dob_s));
	
	yr_in_dob_s := if(_in_dob_s = NULL, NULL, (sysdate - _in_dob_s) / 365.25);
	
	yr_in_dob_int_s := if (yr_in_dob_s >= 0, roundup(yr_in_dob_s), truncate(yr_in_dob_s));
	
	s_comb_age_d := map(
	    yr_in_dob_int_s > 0                                => yr_in_dob_int_s,
	    inferred_age_s > 0 and (boolean)(integer)truedid_s => inferred_age_s,
	                                                          NULL);
	
	s_a44_curr_add_naprop_d := if(not((boolean)(integer)truedid_s and (boolean)(integer)add_curr_pop_s), NULL, add_curr_naprop_s);
	
	s_l80_inp_avm_autoval_d := map(
	    not((boolean)(integer)add_input_pop_s) => NULL,
	    add_input_avm_auto_val_s = 0           => NULL,
	                                              min(if(add_input_avm_auto_val_s = NULL, -NULL, add_input_avm_auto_val_s), 300000));
	
	s_a49_curr_avm_chg_1yr_pct_i := map(
	    not((boolean)(integer)add_curr_pop_s)                         => NULL,
	    add_curr_lres_s < 12                                          => NULL,
	    add_curr_avm_auto_val_s > 0 and add_curr_avm_auto_val_2_s > 0 => round(100 * add_curr_avm_auto_val_s / add_curr_avm_auto_val_2_s/0.1)*0.1,
	                                                                     NULL);
	
	s_c13_curr_addr_lres_d := if(not((boolean)(integer)truedid_s and (boolean)(integer)add_curr_pop_s), NULL, min(if(add_curr_lres_s = NULL, -NULL, add_curr_lres_s), 999));
	
	s_c14_addr_stability_v2_d := map(
	    not((boolean)(integer)truedid_s)          => NULL,
	    (Integer)addr_stability_v2_s = 0          => NULL,
	                                                 (Integer)addr_stability_v2_s);
	
	s_c13_max_lres_d := if(not((boolean)(integer)truedid_s), NULL, min(if(max_lres_s = NULL, -NULL, max_lres_s), 999));
	
	s_c14_addrs_10yr_i := if(not((boolean)(integer)truedid_s), NULL, min(if(addrs_10yr_s = NULL, -NULL, addrs_10yr_s), 999));
	
	s_a41_prop_owner_d := map(
	    not((boolean)(integer)truedid_s)                                                                       => NULL,
	    add_input_naprop_s = 4 or add_curr_naprop_s = 4 or add_prev_naprop_s = 4 or property_owned_total_s > 0 => 1,
	                                                                                                              0);
	
	s_c20_email_count_i := if(not((boolean)(integer)truedid_s), NULL, min(if(email_count_s = NULL, -NULL, email_count_s), 999));
	
	s_l79_adls_per_addr_curr_i := if(not((boolean)(integer)add_curr_pop_s), NULL, min(if(adls_per_addr_curr_s = NULL, -NULL, adls_per_addr_curr_s), 999));
	
	s_l79_adls_per_addr_c6_i := if(not((boolean)(integer)addrpop_s), NULL, min(if(adls_per_addr_c6_s = NULL, -NULL, adls_per_addr_c6_s), 999));
	
	s_c18_invalid_addrs_per_adl_i := if(not((boolean)(integer)truedid_s), NULL, min(if(invalid_addrs_per_adl_s = NULL, -NULL, invalid_addrs_per_adl_s), 999));
	
	s_i60_inq_comm_recency_d := map(
	    not((boolean)(integer)truedid_s)          => NULL,
	    (boolean)inq_communications_count01_s     => 1,
	    (boolean)inq_communications_count03_s     => 3,
	    (boolean)inq_communications_count06_s     => 6,
	    (boolean)inq_communications_count12_s     => 12,
	    (boolean)inq_communications_count24_s     => 24,
	    (boolean)inq_communications_count_s       => 99,
	                                                 999);
	
	s_adl_util_misc_n := if(contains_i(StringLib.StringToUpperCase(util_adl_type_list_s), 'Z') > 0, 1, 0);
	
	s_add_input_mobility_index_i := map(
	    not((boolean)(integer)addrpop_s) => NULL,
	    add_input_occupants_1yr_s <= 0   => NULL,
	                                        if(max(add_input_turnover_1yr_in_s, add_input_turnover_1yr_out_s) = NULL, NULL, sum(if(add_input_turnover_1yr_in_s = NULL, 0, add_input_turnover_1yr_in_s), if(add_input_turnover_1yr_out_s = NULL, 0, add_input_turnover_1yr_out_s))) / add_input_occupants_1yr_s);
	
	add_input_nhood_prop_sum_s_3 := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));
	
	s_add_input_nhood_bus_pct_i := map(
	    not((boolean)(integer)addrpop_s) => NULL,
	    add_input_nhood_BUS_ct_s = 0     => NULL,
	                                        add_input_nhood_BUS_ct_s / add_input_nhood_prop_sum_s_3);
	
	add_input_nhood_prop_sum_s_2 := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));
	
	s_add_input_nhood_mfd_pct_i := map(
	    not((boolean)(integer)addrpop_s) => NULL,
	    add_input_nhood_MFD_ct_s = 0     => NULL,
	                                        add_input_nhood_MFD_ct_s / add_input_nhood_prop_sum_s_2);
	
	add_input_nhood_prop_sum_s_1 := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));
	
	s_add_input_nhood_sfd_pct_d := map(
	    not((boolean)(integer)addrpop_s) => NULL,
	    add_input_nhood_SFD_ct_s = 0     => -1,
	                                        add_input_nhood_SFD_ct_s / add_input_nhood_prop_sum_s_1);
	
	add_input_nhood_prop_sum_s := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));
	
	s_add_input_nhood_vac_pct_i := map(
	    not((boolean)(integer)addrpop_s) => NULL,
	    add_input_nhood_prop_sum_s = 0   => -1,
	                                        add_input_nhood_VAC_prop_s / add_input_nhood_prop_sum_s);
	
	s_add_curr_mobility_index_i := map(
	    not((boolean)(integer)add_curr_pop_s) => NULL,
	    add_curr_occupants_1yr_s <= 0         => NULL,
	                                             if(max(add_curr_turnover_1yr_in_s, add_curr_turnover_1yr_out_s) = NULL, NULL, sum(if(add_curr_turnover_1yr_in_s = NULL, 0, add_curr_turnover_1yr_in_s), if(add_curr_turnover_1yr_out_s = NULL, 0, add_curr_turnover_1yr_out_s))) / add_curr_occupants_1yr_s);
	
	add_curr_nhood_prop_sum_s_2 := if(max(add_curr_nhood_BUS_ct_s, add_curr_nhood_SFD_ct_s, add_curr_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct_s = NULL, 0, add_curr_nhood_BUS_ct_s), if(add_curr_nhood_SFD_ct_s = NULL, 0, add_curr_nhood_SFD_ct_s), if(add_curr_nhood_MFD_ct_s = NULL, 0, add_curr_nhood_MFD_ct_s)));
	
	s_add_curr_nhood_bus_pct_i := map(
	    not((boolean)(integer)add_curr_pop_s) => NULL,
	    add_curr_nhood_BUS_ct_s = 0           => NULL,
	                                             add_curr_nhood_BUS_ct_s / add_curr_nhood_prop_sum_s_2);
	
	add_curr_nhood_prop_sum_s_1 := if(max(add_curr_nhood_BUS_ct_s, add_curr_nhood_SFD_ct_s, add_curr_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct_s = NULL, 0, add_curr_nhood_BUS_ct_s), if(add_curr_nhood_SFD_ct_s = NULL, 0, add_curr_nhood_SFD_ct_s), if(add_curr_nhood_MFD_ct_s = NULL, 0, add_curr_nhood_MFD_ct_s)));
	
	s_add_curr_nhood_mfd_pct_i := map(
	    not((boolean)(integer)add_curr_pop_s) => NULL,
	    add_curr_nhood_MFD_ct_s = 0           => NULL,
	                                             add_curr_nhood_MFD_ct_s / add_curr_nhood_prop_sum_s_1);
	
	add_curr_nhood_prop_sum_s := if(max(add_curr_nhood_BUS_ct_s, add_curr_nhood_SFD_ct_s, add_curr_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct_s = NULL, 0, add_curr_nhood_BUS_ct_s), if(add_curr_nhood_SFD_ct_s = NULL, 0, add_curr_nhood_SFD_ct_s), if(add_curr_nhood_MFD_ct_s = NULL, 0, add_curr_nhood_MFD_ct_s)));
	
	s_add_curr_nhood_sfd_pct_d := map(
	    not((boolean)(integer)add_curr_pop_s) => NULL,
	    add_curr_nhood_SFD_ct_s = 0           => -1,
	                                             add_curr_nhood_SFD_ct_s / add_curr_nhood_prop_sum_s);
	
	s_inq_count24_i := if(not((boolean)(integer)truedid_s), NULL, min(if(inq_count24_s = NULL, -NULL, inq_count24_s), 999));
	
	s_inq_auto_count24_i := if(not((boolean)(integer)truedid_s), NULL, min(if(inq_Auto_count24_s = NULL, -NULL, inq_Auto_count24_s), 999));
	
	s_inq_banking_count24_i := if(not((boolean)(integer)truedid_s), NULL, min(if(inq_Banking_count24_s = NULL, -NULL, inq_Banking_count24_s), 999));
	
	s_inq_per_addr_i := if(not((boolean)(integer)addrpop_s), NULL, min(if(inq_peraddr_s = NULL, -NULL, inq_peraddr_s), 999));
	
	s_inq_ssns_per_addr_i := if(not((boolean)(integer)addrpop_s), NULL, min(if(inq_ssnsperaddr_s = NULL, -NULL, inq_ssnsperaddr_s), 999));
	
	s_liens_rel_cj_total_amt_i := if(not((boolean)(integer)truedid_s), NULL, liens_rel_CJ_total_amount_s);
	
	_liens_unrel_ft_first_seen_s := Common.SAS_Date((STRING)(liens_unrel_FT_first_seen_s));
	
	s_mos_liens_unrel_ft_fseen_d := map(
	    not((boolean)(integer)truedid_s)    => NULL,
	    _liens_unrel_ft_first_seen_s = NULL => 1000,
	                                           min(if(if ((sysdate - _liens_unrel_ft_first_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ft_first_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_first_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_first_seen_s) / (365.25 / 12)))), 999));
	
	_liens_unrel_ot_first_seen_s := Common.SAS_Date((STRING)(liens_unrel_OT_first_seen_s));
	
	s_mos_liens_unrel_ot_fseen_d := map(
	    not((boolean)(integer)truedid_s)    => NULL,
	    _liens_unrel_ot_first_seen_s = NULL => 1000,
	                                           min(if(if ((sysdate - _liens_unrel_ot_first_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_first_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen_s) / (365.25 / 12)))), 999));
	
	s_estimated_income_d := if(not((boolean)(integer)truedid_s), NULL, estimated_income_s);
	
	s_wealth_index_d := if(not((boolean)(integer)truedid_s), NULL, (Integer)wealth_index_s);
	
	s_rel_incomeover75_count_d := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => NULL,
	                                        if(max(rel_incomeover100_count_s, rel_incomeunder100_count_s) = NULL, NULL, sum(if(rel_incomeover100_count_s = NULL, 0, rel_incomeover100_count_s), if(rel_incomeunder100_count_s = NULL, 0, rel_incomeunder100_count_s))));
	
	s_rel_incomeover100_count_d := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => NULL,
	                                        rel_incomeover100_count_s);
	
	s_rel_homeover200_count_d := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => NULL,
	                                        if(max(rel_homeunder300_count_s, rel_homeunder500_count_s, rel_homeover500_count_s) = NULL, NULL, sum(if(rel_homeunder300_count_s = NULL, 0, rel_homeunder300_count_s), if(rel_homeunder500_count_s = NULL, 0, rel_homeunder500_count_s), if(rel_homeover500_count_s = NULL, 0, rel_homeover500_count_s))));
	
	s_rel_homeover300_count_d := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => NULL,
	                                        if(max(rel_homeunder500_count_s, rel_homeover500_count_s) = NULL, NULL, sum(if(rel_homeunder500_count_s = NULL, 0, rel_homeunder500_count_s), if(rel_homeover500_count_s = NULL, 0, rel_homeover500_count_s))));
	
	s_crim_rel_under500miles_cnt_i := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => NULL,
	                                        if(max(crim_rel_within25miles_s, crim_rel_within100miles_s, crim_rel_within500miles_s) = NULL, NULL, sum(if(crim_rel_within25miles_s = NULL, 0, crim_rel_within25miles_s), if(crim_rel_within100miles_s = NULL, 0, crim_rel_within100miles_s), if(crim_rel_within500miles_s = NULL, 0, crim_rel_within500miles_s))));
	
	s_rel_under25miles_cnt_d := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => NULL,
	                                        rel_within25miles_count_s);
	
	s_rel_under100miles_cnt_d := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => NULL,
	                                        if(max(rel_within25miles_count_s, rel_within100miles_count_s) = NULL, NULL, sum(if(rel_within25miles_count_s = NULL, 0, rel_within25miles_count_s), if(rel_within100miles_count_s = NULL, 0, rel_within100miles_count_s))));
	
	s_rel_bankrupt_count_i := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => -1,
	                                        min(if(rel_bankrupt_count_s = NULL, -NULL, rel_bankrupt_count_s), 999));
	
	s_acc_damage_amt_total_i := if(not((boolean)(integer)truedid_s), NULL, acc_damage_amt_total_s);
	
	s_varrisktype_i := map(
	    not((boolean)(integer)truedid_s)          => NULL,
	    (Integer)fp_varrisktype_s = NULL          => NULL,
	                                              (Integer)fp_varrisktype_s);
	
	s_srchvelocityrisktype_i := map(
	    not((boolean)(integer)truedid_s)          => NULL,
	    (Integer)fp_srchvelocityrisktype_s = NULL => NULL,
	                                                 (Integer)fp_srchvelocityrisktype_s);
	
	s_validationrisktype_i := map(
	    not((boolean)(integer)truedid_s)          => NULL,
	    (Integer)fp_validationrisktype_s = NULL   => NULL,
	                                                 (Integer)fp_validationrisktype_s);
	
	s_componentcharrisktype_i := map(
	    not((boolean)(integer)truedid_s)           => NULL,
	    (Integer)fp_componentcharrisktype_s = NULL => NULL,
	                                                  (Integer)fp_componentcharrisktype_s);
	
	s_addrchangeincomediff_d_1 := if(not((boolean)(integer)truedid_s), NULL, NULL);
	
	s_addrchangeincomediff_d := if((Integer)fp_addrchangeincomediff_s = -1, NULL, (Integer)fp_addrchangeincomediff_s);
	
	s_addrchangevaluediff_d := map(
	    not((boolean)(integer)truedid_s)          => NULL,
	    (Integer)fp_addrchangevaluediff_s = -1    => NULL,
	                                                 (Integer)fp_addrchangevaluediff_s);
	
	s_addrchangecrimediff_i := map(
	    not((boolean)(integer)truedid_s)          => NULL,
	    (Integer)fp_addrchangecrimediff_s = -1    => NULL,
	                                                 (Integer)fp_addrchangecrimediff_s);
	
	s_addrchangeecontrajindex_d := if(not((boolean)(integer)truedid_s) or (Integer)fp_addrchangeecontrajindex_s = NULL or (Integer)fp_addrchangeecontrajindex_s = -1, NULL, (Integer)fp_addrchangeecontrajindex_s);
	s_curraddrmedianincome_d    := if(not((boolean)(integer)add_curr_pop_s), NULL, (Integer)fp_curraddrmedianincome_s);
	s_curraddrmedianvalue_d     := if(not((boolean)(integer)add_curr_pop_s), NULL, (Integer)fp_curraddrmedianvalue_s);
	s_curraddrcartheftindex_i   := if(not((boolean)(integer)add_curr_pop_s), NULL, (Integer)fp_curraddrcartheftindex_s);
	s_curraddrburglaryindex_i   := if(not((boolean)(integer)add_curr_pop_s), NULL, (Integer)fp_curraddrburglaryindex_s);
	s_curraddrcrimeindex_i      := if(not((boolean)(integer)add_curr_pop_s), NULL, (Integer)fp_curraddrcrimeindex_s);
	
	s_prevaddrageoldest_d := if(not((boolean)(integer)truedid_s), NULL, min(if((Integer)fp_prevaddrageoldest_s = NULL, -NULL, (Integer)fp_prevaddrageoldest_s), 999));
	
	s_prevaddrmedianincome_d := if(not((boolean)(integer)truedid_s), NULL, (Integer)fp_prevaddrmedianincome_s);
	
	s_prevaddrmedianvalue_d := if(not((boolean)(integer)truedid_s), NULL, (Integer)fp_prevaddrmedianvalue_s);
	
	s_prevaddrmurderindex_i := if(not((boolean)(integer)truedid_s), NULL, (Integer)fp_prevaddrmurderindex_s);
	
	s_prevaddrcartheftindex_i := if(not((boolean)(integer)truedid_s), NULL, (Integer)fp_prevaddrcartheftindex_s);
	
	s_fp_prevaddrburglaryindex_i := if(not((boolean)(integer)truedid_s), NULL, (Integer)fp_prevaddrburglaryindex_s);
	
	s_fp_prevaddrcrimeindex_i := if(not((boolean)(integer)truedid_s), NULL, (Integer)fp_prevaddrcrimeindex_s);
	
	s_c12_source_profile_d := if(not((boolean)(integer)truedid_s), NULL, hdr_source_profile_s);
	
	s_f01_inp_addr_not_verified_i := if(not((boolean)(integer)add_input_pop_s and (boolean)(integer)truedid_s), NULL, (Integer)add_input_addr_not_verified_s);
	
	s_e57_br_source_count_d := if(not((boolean)(integer)truedid_s), NULL, br_source_count_s);
	
	s_i60_inq_retpymt_recency_d := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    (Boolean)inq_retailpayments_count01_s     => 1,
	    (Boolean)inq_retailpayments_count03_s     => 3,
	    (Boolean)inq_retailpayments_count06_s     => 6,
	    (Boolean)inq_retailpayments_count12_s     => 12,
	    (Boolean)inq_retailpayments_count24_s     => 24,
	    (Boolean)inq_retailpayments_count_s       => 99,
	                                                 999);
	
	s_phones_per_addr_curr_i := if(not((boolean)(integer)add_curr_pop_s), NULL, min(if(phones_per_addr_curr_s = NULL, -NULL, phones_per_addr_curr_s), 999));
	
	s_nae_email_verd_d := ((integer)email_name_addr_verification_s in [2, 3, 4, 5, 6, 7, 8]);
	
	s_c20_email_verification_d := if(not((boolean)(integer)emailpop_s), NULL, (Integer)email_verification_s);
	
	btst_addr_match_d := (Integer)addrscore = 100 or not((boolean)(integer)addrpop_s);
	
	num_inp_lat  := (Real)StringLib.StringFilterOut(out_lat, '<>');
	num_inp_long := (Real)StringLib.StringFilterOut(out_long, '<>');
	num_ip_lat   := (REAL)StringLib.StringFilterOut((string)latitude, '<>');
	num_ip_long  := (REAL)StringLib.StringFilterOut((string)longitude, '<>');
	
  d_lat  := if(num_inp_lat=NULL or num_ip_lat=NULL, NULL, if(num_inp_lat=0 or num_ip_lat=0, null, num_inp_lat - num_ip_lat));
	
	d_long := if(num_inp_long=NULL or num_ip_long=NULL, NULL,  if(num_inp_long=0 or num_ip_long=0, null, num_inp_long - num_ip_long));
	
	a := if(num_inp_lat=0 or num_ip_lat=0 or d_lat=null or d_long=null, null,
		power(sin(d_lat / 2), 2) + power(sin(d_long / 2), 2) * cos(num_inp_lat) * cos(num_ip_lat));
		
	c := if(a=null, null, 2 * atan2(sqrt(a), sqrt(1 - a)));
	
	dist := if(c=null, null, 3959 * c);
	
	btst_dist_inp_addr_to_ip_addr_i := if(dist = null, null, round(dist));
	
	btst_lastscore_d := lastscore;
	
	btst_addrscore_d := addrscore;
	
	btst_email_first_score_d := efirstscore;
	
	btst_email_last_score_d := elastscore;
	
	btst_distaddraddr2_i := if((not(addrpop) and not(addrpop_s)) or distaddraddr2 = '', NULL, (integer)distaddraddr2);
	
	email_domain := TRIM(StringLib.StringToUpperCase(in_email_address [(StringLib.StringFind(in_email_address, '@', StringLib.StringFindCount(in_email_address, '@')) + 1)..]));
	email_topleveldomain :=TRIM(email_domain [(StringLib.StringFind(email_domain, '.', StringLib.StringFindCount(email_domain, '.')) + 1)..]);
	
	btst_email_topleveldomain_n := map(
	    in_email_address = ''                                                             => ' ',
	    (email_topleveldomain in ['COM', 'NET', 'EDU', 'ORG', 'US', 'GOV', 'BIZ', 'MIL']) => email_topleveldomain,
	                                                                                         'OTH');
	
	ip_continent_n := map(
	    (integer)continent = 1 => 'AFRICA   ',
	    (integer)continent = 2 => 'ASIA     ',
	    (integer)continent = 3 => 'AUSTRALIA',
	    (integer)continent = 4 => 'EUROPE   ',
	    (integer)continent = 7 => 'S AMERICA',
	    (integer)continent = 5 => 'N AMERICA',
	                              'Other');
	
  ip_state_does_match    :=  STD.Str.ToUpperCase(out_st) = STD.Str.ToUpperCase(state);	
	ip_state_match_d       := if(out_st = '' or state = '', NULL, (integer)ip_state_does_match);
	
	ip_topleveldomain_lvl_n := map(
	    ipaddr = ''                                                                        => '',
	    topleveldomain = ''                                                                => '-1',
	    (STD.Str.ToUpperCase(topleveldomain) in ['COM', 'EDU', 'GOV', 'NET', 'ORG', 'US']) => STD.Str.ToUpperCase(topleveldomain),
	    contains_i(topleveldomain, '.') > 0                                                => 'DOT',
	    length(trim((string)topleveldomain, ALL)) < 3                                      => 'TWO',
	                                                                                           '');
	
	ip_routingmethod_n := map(
	    ipaddr = ''            => '  ',
	    iproutingmethod = ''   => '-1',
	                              iproutingmethod);
	
	ip_dma_lvl_n := map(
	    ipaddr = ''        => '               ',
	    ipdma = ''         => '1. Missing DMA ',
	    ipdma = '-1'       => '2. DMA: -1     ',
	    ipdma = '0'        => '3. DMA: 0      ',
	    length(ipdma) = 3  => '4. DMA: US Code',
	    length(ipdma) != 3 => '5. DMA: Unkown ',
	                          '6. Other');
	
	num_ip_time_zone        := (integer)iptimezone;
	ip_time_zone_condition  := num_ip_time_zone < -800 or num_ip_time_zone > -400;  
	
	ip_non_us_time_zone_i := map(
	    ipaddr = ''                              => NULL,
	    iptimezone = '' or iptimezone = '9999'   => -1,
	                                                (Integer)ip_time_zone_condition);
	
	ip_connection_n := map(
	    ipaddr = ''         => ' ',
	    ipconnection = ''   => '-1',
	                           STD.Str.ToUpperCase(ipconnection));
	
final_score_tree_0 := -2.2154089891;
	
	final_score_tree_1_c198 := map(
	    NULL < b_c23_inp_addr_occ_index_d AND (Real)b_c23_inp_addr_occ_index_d < 3.5 => 0.0028661050,
	    b_c23_inp_addr_occ_index_d >= 3.5                                      => 0.2648979678,
	                                                                              0.5333328648);
	
	final_score_tree_1_c199 := map(
	    NULL < (integer)btst_email_first_score_d AND (real)btst_email_first_score_d < 0.5        => 0.4218291383,
	    (real)btst_email_first_score_d >= 0.5                                                    => -0.0280118758,
	                                                                                                0.3321247719);
	
	final_score_tree_1_c197 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 913 => final_score_tree_1_c198,
	    btst_dist_inp_addr_to_ip_addr_i >= 913                                           => final_score_tree_1_c199,
	                                                                                        0.2824890206);
	
	final_score_tree_1_c196 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_1_c197,
	    b_adl_per_email_i >= 0.5                             => -0.0442456650,
	                                                            0.1017509936);
	
	final_score_tree_1 := map(
	    NULL < (integer)btst_email_last_score_d AND (real)btst_email_last_score_d < 0.5   => final_score_tree_1_c196,
	    (real)btst_email_last_score_d >= 0.5                                              => -0.0689671834,
	                                                                                         -0.0026977251);
	
	final_score_tree_2_c203 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 756  => -0.0027301516,
	    btst_dist_inp_addr_to_ip_addr_i >= 756                                            => 0.1941665529,
	                                                                                        0.0879528894);
	
	final_score_tree_2_c202 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5  => final_score_tree_2_c203,
	    (Real)btst_email_last_score_d >= 0.5                                             => -0.0904664352,
	                                                                                         0.0264990817);
	
	final_score_tree_2_c201 := map(
	    NULL < (integer)s_c20_email_verification_d AND s_c20_email_verification_d < 0.5 => final_score_tree_2_c202,
	    s_c20_email_verification_d >= 0.5                                      => -0.0811450866,
	                                                                              -0.0410464918);
	
	final_score_tree_2_c204 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5 => 0.3017137154,
	    b_c20_email_verification_d >= 0.5                                      => 0.0705379286,
	                                                                              0.1569637388);
	
	final_score_tree_2 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => 0.2011826356,
	    b_estimated_income_d >= 9999.5                                => final_score_tree_2_c201,
	                                                                     final_score_tree_2_c204);
	
	final_score_tree_3_c208 := map(
	    (ip_connection_n in ['BROADBAND', 'DIALUP', 'MOBILE', 'SATELLITE', 'T1', 'XDSL']) => 0.1384017050,
	    (ip_connection_n in ['-1', 'CABLE', 'T3', 'WIRELESS'])                            => 0.3299931459,
	                                                                                         0.1829902585);
	
	final_score_tree_3_c207 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5         => final_score_tree_3_c208,
	    (Real)btst_email_last_score_d >= 0.5                                                    => -0.0369987399,
	                                                                                                0.1224836184);
	
	final_score_tree_3_c206 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 715 => -0.0195777454,
	    btst_dist_inp_addr_to_ip_addr_i >= 715                                           => final_score_tree_3_c207,
	                                                                                        0.1418691061);
	
	final_score_tree_3_c209 := map(
	    NULL < (integer)s_estimated_income_d AND s_estimated_income_d < 22500 => 0.0251772567,
	    s_estimated_income_d >= 22500                                => -0.0799191531,
	                                                                    0.0574796680);
	
	final_score_tree_3 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5 => final_score_tree_3_c206,
	    b_c20_email_verification_d >= 0.5                                      => final_score_tree_3_c209,
	                                                                              -0.0166541456);
	
	final_score_tree_4_c213 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => 0.1573589775,
	    b_adl_per_email_i >= 0.5                             => -0.0047724182,
	                                                            0.0937780380);
	
	final_score_tree_4_c212 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 1940 => -0.0235027539,
	    btst_dist_inp_addr_to_ip_addr_i >= 1940                                           => final_score_tree_4_c213,
	                                                                                         0.0123595525);
	
	final_score_tree_4_c211 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5 => final_score_tree_4_c212,
	    (Real)btst_email_last_score_d >= 0.5                                            => -0.0794708114,
	                                                                                       -0.0443733425);
	
	final_score_tree_4_c214 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5 => 0.1712872170,
	    (Real)btst_email_last_score_d >= 0.5                                                  => 0.0215560197,
	                                                                                       0.0842263172);
	
	final_score_tree_4 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => 0.1395162694,
	    b_estimated_income_d >= 9999.5                                => final_score_tree_4_c211,
	                                                                     final_score_tree_4_c214);
	
	final_score_tree_5_c218 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 764 => 0.0315342970,
	    btst_dist_inp_addr_to_ip_addr_i >= 764                                           => 0.1129806378,
	                                                                                        0.0706625652);
	
	final_score_tree_5_c217 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_5_c218,
	    b_adl_per_email_i >= 0.5                             => -0.0559312523,
	                                                            0.0086574301);
	
	final_score_tree_5_c216 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5 => final_score_tree_5_c217,
	    b_c20_email_verification_d >= 0.5                                      => -0.0738972551,
	                                                                              -0.0435567594);
	
	final_score_tree_5_c219 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5 => 0.1532635670,
	    b_c20_email_verification_d >= 0.5                                      => 0.0345145704,
	                                                                              0.0790284800);
	
	final_score_tree_5 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => 0.1144113858,
	    b_estimated_income_d >= 9999.5                                => final_score_tree_5_c216,
	                                                                     final_score_tree_5_c219);
	
	final_score_tree_6_c224 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 2452.5 => 0.0146746477,
	    btst_dist_inp_addr_to_ip_addr_i >= 2452.5                                           => 0.1083120537,
	                                                                                           0.0459156470);
	
	final_score_tree_6_c223 := map(
	    NULL < (integer)s_c20_email_verification_d AND s_c20_email_verification_d < 0.5 => final_score_tree_6_c224,
	    s_c20_email_verification_d >= 0.5                                      => -0.0540164859,
	                                                                              -0.0187178777);
	
	final_score_tree_6_c222 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_6_c223,
	    b_adl_per_email_i >= 0.5                             => -0.0917850769,
	                                                            -0.0536908425);
	
	final_score_tree_6_c221 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_6_c222,
	    (Real)b_nae_contradictory_i >= 0.5                                 => 0.1653876808,
	                                                                    -0.0462861736);
	
	final_score_tree_6 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => 0.1147966626,
	    b_estimated_income_d >= 9999.5                                => final_score_tree_6_c221,
	                                                                     0.0727724282);
	
	final_score_tree_7_c229 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 678 => 0.0303991441,
	    btst_dist_inp_addr_to_ip_addr_i >= 678                                           => 0.1912674591,
	                                                                                        0.1182352179);
	
	final_score_tree_7_c228 := map(
	    NULL < (integer)s_comb_age_d AND (real)s_comb_age_d < 50.5            => 0.0228512952,
	    s_comb_age_d >= 50.5                                                  => final_score_tree_7_c229,
	                                                                             0.0483809822);
	
	final_score_tree_7_c227 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_7_c228,
	    b_adl_per_email_i >= 0.5                             => -0.0551922535,
	                                                            0.0002533235);
	
	final_score_tree_7_c226 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5   => final_score_tree_7_c227,
	    (Real)btst_email_last_score_d >= 0.5                                              => -0.0730204727,
	                                                                                         -0.0452128320);
	
	final_score_tree_7 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => 0.0912294584,
	    b_estimated_income_d >= 9999.5                                => final_score_tree_7_c226,
	                                                                     0.0636225963);
	
	final_score_tree_8_c233 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 413.5 => -0.0198557018,
	    btst_dist_inp_addr_to_ip_addr_i >= 413.5                                           => 0.0696197831,
	                                                                                          0.0290947802);
	
	final_score_tree_8_c232 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 0.5 => final_score_tree_8_c233,
	    (Real)btst_email_first_score_d >= 0.5                                    => -0.0823741852,
	                                                                          0.0005928316);
	
	final_score_tree_8_c231 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5   => final_score_tree_8_c232,
	    (Real)btst_email_last_score_d >= 0.5                                              => -0.0679570484,
	                                                                                         -0.0417424928);
	
	final_score_tree_8_c234 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 303.5 => 0.0291742881,
	    btst_dist_inp_addr_to_ip_addr_i >= 303.5                                           => 0.1643291845,
	                                                                                          0.0295244468);
	
	final_score_tree_8 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => 0.0924472110,
	    b_estimated_income_d >= 9999.5                                => final_score_tree_8_c231,
	                                                                     final_score_tree_8_c234);
	
	final_score_tree_9_c239 := map(
	    NULL < (integer)s_comb_age_d AND s_comb_age_d < 61.5         => 0.0707785845,
	    s_comb_age_d >= 61.5                                         => 0.2318335331,
	                                                                    0.0899203612);
	
	final_score_tree_9_c238 := map(
	    NULL < (integer)s_c20_email_count_i AND s_c20_email_count_i < 0.5 => 0.0138045129,
	    s_c20_email_count_i >= 0.5                               => final_score_tree_9_c239,
	                                                                0.0646763412);
	
	final_score_tree_9_c237 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'NET', 'ORG']) => final_score_tree_9_c238,
	    (ip_topleveldomain_lvl_n in ['-1', 'TWO', 'US'])                        => 0.1508332438,
	                                                                               0.0569697434);
	
	final_score_tree_9_c236 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 0.5 => final_score_tree_9_c237,
	    (Real)btst_email_first_score_d >= 0.5                                    => -0.0617973763,
	                                                                          0.0203789911);
	
	final_score_tree_9 := map(
	
	    NULL < (integer)s_c20_email_verification_d AND s_c20_email_verification_d < 0.5 => final_score_tree_9_c236,
	    s_c20_email_verification_d >= 0.5                                      => -0.0412247554,
	                                                                              -0.0182489992);
	
	final_score_tree_10_c242 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => 0.0042271134,
	    b_adl_per_email_i >= 0.5                             => -0.0886610602,
	                                                            -0.0384062563);
	
	final_score_tree_10_c241 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_10_c242,
	    (Real)b_nae_contradictory_i >= 0.5                                 => 0.1219063214,
	                                                                    -0.0335893281);
	
	final_score_tree_10_c244 := map(
	    BT_cen_med_hhinc = ''                                                     => 0.0564179492,
	    NULL < (Integer)BT_cen_med_hhinc AND (Integer)BT_cen_med_hhinc < 72362    => 0.1935620005,
	    (Integer)BT_cen_med_hhinc >= 72362                                        => 0.0447593687,
	                                                                                 0.0564179492);
	
	final_score_tree_10_c243 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5 => final_score_tree_10_c244,
	    b_c20_email_verification_d >= 0.5                                      => 0.0111871048,
	                                                                              0.0366502479);
	
	final_score_tree_10 := map(
	    NULL < (integer)b_f01_inp_addr_not_verified_i AND (Real)b_f01_inp_addr_not_verified_i < 0.5 => final_score_tree_10_c241,
	    b_f01_inp_addr_not_verified_i >= 0.5                                         => 0.0720171648,
	                                                                                    final_score_tree_10_c243);
	
	final_score_tree_11_c249 := map(
	    NULL < (Integer) s_nae_email_verd_d AND (Real)s_nae_email_verd_d < 0.5 => 0.1569790292,
	    (Real)s_nae_email_verd_d >= 0.5                              => -0.0530746963,
	                                                              0.1137824969);
	
	final_score_tree_11_c248 := map(
	    (ip_connection_n in ['BROADBAND', 'DIALUP', 'MOBILE', 'SATELLITE', 'T1', 'XDSL']) => 0.0189908719,
	    (ip_connection_n in ['-1', 'CABLE', 'T3', 'WIRELESS'])                            => final_score_tree_11_c249,
	                                                                                         0.0399243741);
	
	final_score_tree_11_c247 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5  => final_score_tree_11_c248,
	    (Real)btst_email_last_score_d >= 0.5                                             => -0.0400786346,
	                                                                                        -0.0083766661);
	
	final_score_tree_11_c246 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 642.5 => -0.0680862664,
	    btst_dist_inp_addr_to_ip_addr_i >= 642.5                                           => final_score_tree_11_c247,
	                                                                                          -0.0406337993);
	
	final_score_tree_11 := map(
	    NULL < (integer)b_f01_inp_addr_not_verified_i AND (Real)b_f01_inp_addr_not_verified_i < 0.5 => final_score_tree_11_c246,
	    b_f01_inp_addr_not_verified_i >= 0.5                                         => 0.0765229259,
	                                                                                    0.0466658805);
	
	final_score_tree_12_c252 := map(
	    NULL < (integer)s_curraddrcartheftindex_i AND s_curraddrcartheftindex_i < 165.5 => -0.0180592546,
	    s_curraddrcartheftindex_i >= 165.5                                     => 0.1430083125,
	                                                                              0.0781452478);
	
	final_score_tree_12_c254 := map(
	    NULL < (integer)s_prevaddrmedianvalue_d AND s_prevaddrmedianvalue_d < 343873.5 => 0.1008117436,
	    s_prevaddrmedianvalue_d >= 343873.5                                   => 0.2753898644,
	                                                                             0.1546815637);
	
	final_score_tree_12_c253 := map(
	    NULL < (Integer) ip_routingmethod_n AND(Real) ip_routingmethod_n < 13.5 => 0.0528209474,
	   (Real) ip_routingmethod_n >= 13.5                              => final_score_tree_12_c254,
	                                                               0.0777088058);
	
	final_score_tree_12_c251 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 2232.5 => final_score_tree_12_c252,
	    btst_dist_inp_addr_to_ip_addr_i >= 2232.5                                           => final_score_tree_12_c253,
	                                                                                           0.0361300472);
	
	final_score_tree_12 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5       => final_score_tree_12_c251,
	    (Real)btst_email_last_score_d >= 0.5                                                  => -0.0419094320,
	                                                                                             -0.0162579447);
	
	final_score_tree_13_c256 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => -0.0317610698,
	    (Real)b_nae_contradictory_i >= 0.5                                 => 0.0989874537,
	                                                                    -0.0284912446);
	
	final_score_tree_13_c259 := map(
	    NULL < (integer)b_add_input_nhood_sfd_pct_d AND (Real)b_add_input_nhood_sfd_pct_d < 0.07970565855 => 0.0337278154,
	    b_add_input_nhood_sfd_pct_d >= 0.07970565855                                       => 0.1618422480,
	                                                                                          0.0638723878);
	
	final_score_tree_13_c258 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => 0.1360158386,
	    b_estimated_income_d >= 9999.5                                => 0.0216782880,
	                                                                     final_score_tree_13_c259);
	
	final_score_tree_13_c257 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5 => final_score_tree_13_c258,
	    b_c20_email_verification_d >= 0.5                                      => 0.0040324625,
	                                                                              0.0256534877);
	
	final_score_tree_13 := map(
	    NULL < (Integer)s_nap_nothing_found_i AND (Real)s_nap_nothing_found_i < 0.5 => final_score_tree_13_c256,
	    (Real)s_nap_nothing_found_i >= 0.5                                 => final_score_tree_13_c257,
	                                                                    -0.0179859935);
	
	final_score_tree_14_c263 := map(
	    NULL < (integer)s_wealth_index_d AND s_wealth_index_d < 5.5 => 0.0524365402,
	    s_wealth_index_d >= 5.5                            => 0.1579392354,
	                                                          0.0630974418);
	
	final_score_tree_14_c264 := map(
	    NULL < (integer)b_add_input_nhood_vac_pct_i AND (Real)b_add_input_nhood_vac_pct_i < 0.0012 => 0.0179008824,
	    b_add_input_nhood_vac_pct_i >= 0.0012                                       => 0.1333767893,
	                                                                                   0.0457604543);
	
	final_score_tree_14_c262 := map(
	    NULL < (integer)b_m_bureau_adl_fs_notu_d AND (Real)b_m_bureau_adl_fs_notu_d < 55.5 => -0.0581077469,
	    b_m_bureau_adl_fs_notu_d >= 55.5                                    => final_score_tree_14_c263,
	                                                                           final_score_tree_14_c264);
	
	final_score_tree_14_c261 := map(
	    NULL < (integer)s_c20_email_verification_d AND s_c20_email_verification_d < 0.5 => final_score_tree_14_c262,
	    s_c20_email_verification_d >= 0.5                                      => -0.0083837240,
	                                                                              0.0110875191);
	
	final_score_tree_14 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_14_c261,
	    b_adl_per_email_i >= 0.5                             => -0.0657189573,
	                                                            -0.0211811006);
	
	final_score_tree_15_c268 := map(
	    NULL < (integer)b_rel_ageover30_count_d AND (Real)b_rel_ageover30_count_d < 8.5 => 0.0469476947,
	    b_rel_ageover30_count_d >= 8.5                                   => 0.1246350108,
	                                                                        0.0835717151);
	
	final_score_tree_15_c269 := map(
	    NULL < (integer)s_comb_age_d AND s_comb_age_d < 50.5    => -0.0125860982,
	    s_comb_age_d >= 50.5                                    =>  0.0738284099,
	                                                                0.0134841015);
	
	final_score_tree_15_c267 := map(
	    NULL < (integer)s_f01_inp_addr_address_score_d AND s_f01_inp_addr_address_score_d < 95 => final_score_tree_15_c268,
	    s_f01_inp_addr_address_score_d >= 95                                          => final_score_tree_15_c269,
	                                                                                     0.0481623574);
	
	final_score_tree_15_c266 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5 => final_score_tree_15_c267,
	    b_c20_email_verification_d >= 0.5                                      => -0.0048004681,
	                                                                              0.0086059262);
	
	final_score_tree_15 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_15_c266,
	    b_adl_per_email_i >= 0.5                             => -0.0566812227,
	                                                            -0.0187872831);
	
	final_score_tree_16_c272 := map(
	    NULL < (integer)s_comb_age_d AND s_comb_age_d < 62.5    => 0.0488274469,
	    s_comb_age_d >= 62.5                                    => 0.1784134767,
	                                                               0.0999492820);
	
	final_score_tree_16_c273 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => -0.0656770863,
	    (Real)b_nae_contradictory_i >= 0.5                                 => 0.1324831611,
	                                                                    -0.0481463219);
	
	final_score_tree_16_c271 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_16_c272,
	    b_adl_per_email_i >= 0.5                             => final_score_tree_16_c273,
	                                                            0.0184439635);
	
	final_score_tree_16_c274 := map(
	    NULL < (integer)s_add_input_nhood_mfd_pct_i AND s_add_input_nhood_mfd_pct_i < 0.9669213563 => -0.0231499980,
	    s_add_input_nhood_mfd_pct_i >= 0.9669213563                                       => 0.2421553117,
	                                                                                         -0.0483161489);
	
	final_score_tree_16 := map(
	    NULL < (integer)ip_state_match_d AND ip_state_match_d < 0.5 => final_score_tree_16_c271,
	    ip_state_match_d >= 0.5                            => final_score_tree_16_c274,
	                                                          0.0022402417);
	/* TREE 17 */  
	final_score_tree_17_c277 := map(
	    ST_cen_high_ed = ''                                                          => 0.1219608825,
	    NULL < (integer)ST_cen_high_ed AND (Real)ST_cen_high_ed < 27.45              => 0.0209140177,
	    (Real)ST_cen_high_ed >= 27.45                                                => 0.2132682905,
	                                                                                    0.1219608825);
	final_score_tree_17_c276 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5  => -0.0283793060,
	    (Real)b_nae_contradictory_i >= 0.5                                           => final_score_tree_17_c277,
	                                                                                    -0.0243387228);
	final_score_tree_17_c279 := map(
	    BT_cen_low_hval = ''                                                         =>  0.0130719962,
	    NULL < (integer)BT_cen_low_hval AND (Real)bT_cen_low_hval < 31.15            =>  0.0635048016,              //ECL
	    (Real)BT_cen_low_hval >= 31.15                                               => -0.0801635929,              
	                                                                                     0.0130719962);             // SAS    - when the values are empty  - use
	final_score_tree_17_c278 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'NET', 'ORG', 'TWO']) => final_score_tree_17_c279,
	    (ip_topleveldomain_lvl_n in ['-1', 'US'])                                      => 0.1326871440,
	                                                                                      0.0434437776);
	final_score_tree_17 := map(
	    NULL < (Integer)b_nap_nothing_found_i AND (Real)b_nap_nothing_found_i < 0.5  => final_score_tree_17_c276,    
	    (Real)b_nap_nothing_found_i >= 0.5                                           => final_score_tree_17_c278,    
	                                                                                   -0.0115406284);
	
	/* TREE 18  */  
	final_score_tree_18_c282 := map(
	    NULL < (integer)b_add_curr_nhood_sfd_pct_d AND (Real)b_add_curr_nhood_sfd_pct_d < 0.4008145953 => 0.0975521134,
	    b_add_curr_nhood_sfd_pct_d >= 0.4008145953                                                     => -0.0343156282,
	                                                                                                       0.0049641246);
	final_score_tree_18_c281 := map(
	    NULL < (integer)ip_state_match_d AND ip_state_match_d < 0.5 => 0.1396844984,
	    ip_state_match_d >= 0.5                            => final_score_tree_18_c282,
	                                                          0.0479394410);
	final_score_tree_18_c284 := map(
	    NULL < (Integer)s_nap_nothing_found_i AND (Real)s_nap_nothing_found_i < 0.5 => 0.0160474077,
	    (Real)s_nap_nothing_found_i >= 0.5                                 => 0.1518673463,
	                                                                    0.1083449350);
	final_score_tree_18_c283 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 305 => 0.0057468617,
	    btst_dist_inp_addr_to_ip_addr_i >= 305                                           => final_score_tree_18_c284,
	                                                                                        0.0112781617);
	final_score_tree_18 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => final_score_tree_18_c281,
	    b_estimated_income_d >= 9999.5                                => -0.0227895151,
	                                                                     final_score_tree_18_c283);
	
	/*  TREE 19 */ 
	final_score_tree_19_c287 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 178.5 => -0.0723099225,
	    btst_dist_inp_addr_to_ip_addr_i >= 178.5                                           => 0.1473595553,
	                                                                                          0.0814587119);
	final_score_tree_19_c286 := map(
	    NULL < (integer)s_comb_age_d AND s_comb_age_d < 61.5     => 0.0037668621,
	    s_comb_age_d >= 61.5                                     => final_score_tree_19_c287,
	                                                                0.0281162595);
	final_score_tree_19_c289 := map(
	    NULL < (integer)s_curraddrmedianincome_d AND s_curraddrmedianincome_d < 53947 => -0.0460234872,
	    s_curraddrmedianincome_d >= 53947                                    => 0.1635723581,
	                                                                            0.0874691047);
	final_score_tree_19_c288 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => -0.0833956369,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_19_c289,
	                                                                    -0.0732486050);
	final_score_tree_19 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_19_c286,
	    b_adl_per_email_i >= 0.5                             => final_score_tree_19_c288,
	                                                            -0.0228024048);

  /*  TREE 20  */ 	
	final_score_tree_20_c293 := map(
	    NULL < (integer)s_c20_email_count_i AND s_c20_email_count_i < 1.5 => -0.0097709339,
	    s_c20_email_count_i >= 1.5                               => 0.0550056692,
	                                                                0.0022510597);	
	final_score_tree_20_c292 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => 0.0853941828,
	    b_estimated_income_d >= 9999.5                                => final_score_tree_20_c293,
	                                                                     0.0125027850);
	final_score_tree_20_c291 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5 => final_score_tree_20_c292,
	    b_c20_email_verification_d >= 0.5                                      => -0.0456990025,
	                                                                              -0.0256330082);
	final_score_tree_20_c294 := map(
	    (ip_connection_n in ['BROADBAND', 'DIALUP', 'MOBILE', 'SATELLITE', 'XDSL']) => 0.0440613013,
	    (ip_connection_n in ['-1', 'CABLE', 'T1', 'T3', 'WIRELESS'])                => 0.1938778676,
	                                                                                   0.0549379139);
	final_score_tree_20 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'EDU', 'GOV', 'NET', 'ORG']) => final_score_tree_20_c291,
	    (ip_topleveldomain_lvl_n in ['-1', 'DOT', 'TWO', 'US'])          => final_score_tree_20_c294,
	                                                                        -0.0161788219);
	
	/*  TREE 21  */  
	final_score_tree_21_c298 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 =>  0.0743861187,
	    b_adl_per_email_i >= 0.5                                            => -0.0080238782,
	                                                                            0.0364729796);
	
	final_score_tree_21_c297 := map(
	    NULL < (integer)b_m_bureau_adl_fs_all_d AND (Real)b_m_bureau_adl_fs_all_d < 87.5  => -0.0682296021,
	    b_m_bureau_adl_fs_all_d >= 87.5                                                   => final_score_tree_21_c298,
	                                                                                          0.0197496506);
	
	final_score_tree_21_c299 := map(
	    BT_cen_vacant_p = ''                                                => 0.0928640723,
	    NULL < (integer)BT_cen_vacant_p AND (Real)bT_cen_vacant_p < 12.15   => 0.0697872610,                                               
	    (Real)BT_cen_vacant_p >= 12.15                                      => 0.1681902678,
	                                                                           0.0928640723);
	
	final_score_tree_21_c296 := map(
	    NULL < (integer)s_rel_homeover200_count_d AND s_rel_homeover200_count_d < 0.5 => -0.0346329537,
	    s_rel_homeover200_count_d >= 0.5                                              => final_score_tree_21_c297,
	                                                                                     final_score_tree_21_c299);
	
	final_score_tree_21 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 2183.5 => -0.0257527232,
	    btst_dist_inp_addr_to_ip_addr_i >= 2183.5                                                          => final_score_tree_21_c296,
	                                                                                                           0.0139251475);               
	
	/*  TREE 22  */  
	final_score_tree_22_c301 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 2382.5 => -0.0305372902,
	    btst_dist_inp_addr_to_ip_addr_i >= 2382.5                                                          =>  0.0215121120,               
	                                                                                                          -0.0059557671);              
	final_score_tree_22_c304 := map(
	    NULL < (integer)s_rel_incomeover100_count_d AND s_rel_incomeover100_count_d < 0.5        => 0.0760242012,
	    s_rel_incomeover100_count_d >= 0.5                                                       => 0.2424340084,
	                                                                                                0.1403693266);
	final_score_tree_22_c303 := map(
	    NULL < (integer)s_adl_util_misc_n AND s_adl_util_misc_n < 0.5        => final_score_tree_22_c304,
	    s_adl_util_misc_n >= 0.5                                             => 0.0112306873,
	                                                                            0.0838711719);
	final_score_tree_22_c302 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 1452   => -0.0041834548,
	    btst_dist_inp_addr_to_ip_addr_i >= 1452                                                      => final_score_tree_22_c303,
	                                                                                                     0.1126348785);
	final_score_tree_22 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'NET', 'ORG', 'TWO'])      => final_score_tree_22_c301,
	    (ip_topleveldomain_lvl_n in ['-1', 'US'])                                           => final_score_tree_22_c302,
	                                                                                          -0.0099072202);
	
	/*  TREE 23 */  
	final_score_tree_23_c306 := map(
	    NULL < (integer)s_prevaddrcartheftindex_i AND s_prevaddrcartheftindex_i < 100 => -0.0212547896,
	    s_prevaddrcartheftindex_i >= 100                                     => 0.1682468194,
	                                                                            0.0828541191);
	
	final_score_tree_23_c309 := map(
	    ST_cen_span_lang = ''                                                 =>  0.0545360069,
	    NULL < (integer)ST_cen_span_lang AND  (Integer)ST_cen_span_lang < 131 =>  0.1227173558,
	    (Integer)ST_cen_span_lang >= 131                                      => -0.0286683510,
	                                                                              0.0545360069);
	
	final_score_tree_23_c308 := map(
	    NULL < (integer)b_curraddrcrimeindex_i AND (Real)b_curraddrcrimeindex_i < 154.5 => 0.0343114323,
	    b_curraddrcrimeindex_i >= 154.5                                  => 0.2369713683,
	                                                                        final_score_tree_23_c309);
	
	final_score_tree_23_c307 := map(
	    NULL < (integer)s_add_input_nhood_mfd_pct_i AND s_add_input_nhood_mfd_pct_i < 0.16993064055 => -0.0137986000,
	    s_add_input_nhood_mfd_pct_i >= 0.16993064055                                       => final_score_tree_23_c308,
	                                                                                          0.0017798224);
	
	final_score_tree_23 := map(
	    NULL < (integer)s_addrchangevaluediff_d AND s_addrchangevaluediff_d < 45448.5 => -0.0155250724,
	    s_addrchangevaluediff_d >= 45448.5                                   => final_score_tree_23_c306,
	                                                                            final_score_tree_23_c307);
	
	final_score_tree_24_c314 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'GOV', 'NET', 'ORG', 'US']) => 0.0305539399,
	    (ip_topleveldomain_lvl_n in ['-1', 'EDU', 'TWO'])                      => 0.1011629673,
	                                                                              0.0399262592);
	
	final_score_tree_24_c313 := map(
	    NULL < (integer)b_c13_max_lres_d AND (Real)b_c13_max_lres_d < 73.5 => -0.0268601035,
	    b_c13_max_lres_d >= 73.5                            => final_score_tree_24_c314,
	                                                           0.0363065236);
	
	final_score_tree_24_c312 := map(
	    NULL < (integer)s_c20_email_verification_d AND s_c20_email_verification_d < 0.5 => final_score_tree_24_c313,
	    s_c20_email_verification_d >= 0.5                                      => -0.0462936400,
	                                                                              -0.0051588176);
	
	final_score_tree_24_c311 := map(
	    NULL < (integer)s_l79_adls_per_addr_c6_i AND s_l79_adls_per_addr_c6_i < 4.5 => final_score_tree_24_c312,
	    s_l79_adls_per_addr_c6_i >= 4.5                                    => 0.1537050242,
	                                                                          -0.0006169670);
	
	final_score_tree_24 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 0.5 => final_score_tree_24_c311,
	    (Real)btst_email_first_score_d >= 0.5                                    => -0.0363018790,
	                                                                          -0.0208545641);
	
	final_score_tree_25_c318 := map(
	    NULL < (integer)s_addrchangeecontrajindex_d AND s_addrchangeecontrajindex_d < 2.5 => -0.0261674297,
	    s_addrchangeecontrajindex_d >= 2.5                                       => 0.0504317083,
	                                                                                0.0377870374);
	
	final_score_tree_25_c317 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_25_c318,
	    b_adl_per_email_i >= 0.5                             => -0.0641596114,
	                                                            -0.0078838182);
	
	final_score_tree_25_c319 := map(
	    NULL < (integer)b_i61_inq_collection_recency_d AND (Integer)b_i61_inq_collection_recency_d < 549 => 0.0007072563,
	    b_i61_inq_collection_recency_d >= 549                                          => 0.1806041411,
	                                                                                      0.1000103367);
	
	final_score_tree_25_c316 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_25_c317,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_25_c319,
	                                                                    -0.0037877502);
	
	final_score_tree_25 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 419.5 => -0.0400245568,
	    btst_dist_inp_addr_to_ip_addr_i >= 419.5                                           => final_score_tree_25_c316,
	                                                                                          0.0095655240);
	
	final_score_tree_26_c324 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5  =>  0.1461612550,
	    (Real)btst_email_last_score_d >= 0.5                                             => -0.0084275242,
	                                                                                         0.1077805926);
	
	final_score_tree_26_c323 := map(
	    BT_cen_mil_emp = ''                                             =>  0.0799520890,
	    NULL < (integer)BT_cen_mil_emp AND (Real)bT_cen_mil_emp < 0.25  => final_score_tree_26_c324,
	    (Real)BT_cen_mil_emp >= 0.25                                    => -0.0248565607,
	                                                                        0.0799520890);
	
	final_score_tree_26_c322 := map(
	    NULL < (integer)s_rel_bankrupt_count_i AND s_rel_bankrupt_count_i < 1.5 => final_score_tree_26_c323,
	    s_rel_bankrupt_count_i >= 1.5                                  => -0.0451513933,
	                                                                      0.0323878420);
	
	final_score_tree_26_c321 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 0.5 => final_score_tree_26_c322,
	    (Real)btst_email_first_score_d >= 0.5                                    => 0.0025210703,
	                                                                          0.0196172773);
	
	final_score_tree_26 := map(
	    NULL < (integer)s_add_input_nhood_sfd_pct_d AND s_add_input_nhood_sfd_pct_d < 0.42197644335 => final_score_tree_26_c321,
	    s_add_input_nhood_sfd_pct_d >= 0.42197644335                                       => -0.0202258720,
	                                                                                          -0.0102075712);
	
	final_score_tree_27_c327 := map(
	    NULL < (integer)s_add_curr_nhood_sfd_pct_d AND s_add_curr_nhood_sfd_pct_d < 0.3860242135 => 0.0773514268,
	    s_add_curr_nhood_sfd_pct_d >= 0.3860242135                                      => -0.0114757306,
	                                                                                       0.0036181653);
	
	final_score_tree_27_c328 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 3809 => 0.0530258574,
	    btst_dist_inp_addr_to_ip_addr_i >= 3809                                           => 0.1673059459,
	                                                                                         0.0821474244);
	
	final_score_tree_27_c329 := map(
	    NULL < (integer)s_add_input_mobility_index_i AND s_add_input_mobility_index_i < 0.2505152498 => -0.0293107159,
	    s_add_input_mobility_index_i >= 0.2505152498                                        => 0.0771018015,
	                                                                                           0.0026533983);
	
	final_score_tree_27_c326 := map(
	    NULL < (integer)s_comb_age_d AND s_comb_age_d < 61.5      => final_score_tree_27_c327,
	    s_comb_age_d >= 61.5                                      => final_score_tree_27_c328,
	                                                                 final_score_tree_27_c329);
	
	final_score_tree_27 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_27_c326,
	    b_adl_per_email_i >= 0.5                             => -0.0503057892,
	                                                            -0.0148884151);
	/*   TREE 28                          */   
	final_score_tree_28_c333 := map(
	    NULL < (integer)b_comb_age_d AND (Real)b_comb_age_d < 68.5          => -0.0020731860,
	    b_comb_age_d >= 68.5                                                =>  0.0953645047,
	                                                                            0.0122309044);
	final_score_tree_28_c332 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_28_c333,
	    b_adl_per_email_i >= 0.5                                            => -0.0671535997,
	                                                                           -0.0251402458);
	final_score_tree_28_c334 := map(
	    NULL < (integer)s_prevaddrmedianincome_d AND s_prevaddrmedianincome_d < 74925.5  => 0.0035864112,
	    s_prevaddrmedianincome_d >= 74925.5                                              => 0.1796677783,
	                                                                                        0.0628980296);
	final_score_tree_28_c331 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5      => final_score_tree_28_c332,
	    (Real)b_nae_contradictory_i >= 0.5                                               => final_score_tree_28_c334,
	                                                                                       -0.0226490596);
	
	final_score_tree_28 := map(
	    ip_routingmethod_n = ''                                                          => -0.0204190437,                    // use this value when the ip routing method is not populated
	    NULL < (Integer) ip_routingmethod_n AND(Real) ip_routingmethod_n < 10.5          =>  0.1151583655,
	   (Real) ip_routingmethod_n >= 10.5                                                 => final_score_tree_28_c331,
	                                                                                        -0.0204190437);
	
	/*   TREE 29                       */ 
	final_score_tree_29_c337 := map(
	    NULL < (integer)b_estimated_income_d AND (Integer)b_estimated_income_d < 34500 => 0.2000004279,
	    b_estimated_income_d >= 34500                                => 0.0488863365,
	                                                                    0.0912197167);
	
	final_score_tree_29_c336 := map(
	    ST_cen_med_rent = ''                                               =>  0.0488606295, 
	    NULL < (integer)ST_cen_med_rent AND (Integer)ST_cen_med_rent < 695 => -0.0340925828,
	    (Integer)ST_cen_med_rent >= 695                           => final_score_tree_29_c337,
	                                                        0.0488606295);
	
	final_score_tree_29_c339 := map(
	    NULL < (integer)s_nap_addr_verd_d AND (Real)s_nap_addr_verd_d < 0.5 => 0.0911286752,
	    (Real)s_nap_addr_verd_d >= 0.5                             => -0.0113544469,
	                                                            0.0542347512);
	
	final_score_tree_29_c338 := map(
	    ST_cen_med_hhinc = ''                                                  => -0.0059272066, 
	    NULL < (integer)ST_cen_med_hhinc AND (Integer)ST_cen_med_hhinc < 74251 =>  final_score_tree_29_c339,
	    (Integer)ST_cen_med_hhinc >= 74251                                     => -0.0434550681,
	                                                                              -0.0059272066);
	
	final_score_tree_29 := map(
	    NULL < (integer)b_rel_count_i AND (Real)b_rel_count_i < 0.5 => final_score_tree_29_c336,
	    b_rel_count_i >= 0.5                         => -0.0138616019,
	                                                    final_score_tree_29_c338);
	
	final_score_tree_30_c342 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 0.5 => 0.1760060079,
	    (Real)btst_email_first_score_d >= 0.5                                    => 0.0333385022,
	                                                                          0.1090911601);
	
	final_score_tree_30_c343 := map(
	    NULL < (integer)b_c20_email_count_i AND (Real)b_c20_email_count_i < 0.5 => -0.0121216105,
	    b_c20_email_count_i >= 0.5                               => 0.0344901386,
	                                                                0.0021282671);
	
	final_score_tree_30_c344 := map(
	    BT_cen_blue_col = ''                                              =>  0.0041737715,    
	    NULL < (integer)BT_cen_blue_col AND (Real)bT_cen_blue_col < 14.75 =>  0.0538214524,
	    (Real)BT_cen_blue_col >= 14.75                                    => -0.0604803821,
	                                                                          0.0041737715);
	
	final_score_tree_30_c341 := map(
	    NULL < (integer)s_rel_under25miles_cnt_d AND (Real)s_rel_under25miles_cnt_d < 0.5 => final_score_tree_30_c342,
	    (Real)s_rel_under25miles_cnt_d >= 0.5                                    => final_score_tree_30_c343,
	                                                                          final_score_tree_30_c344);
	
	final_score_tree_30 := map(
	    NULL < (integer)s_c20_email_verification_d AND (Real)s_c20_email_verification_d < 0.5 => final_score_tree_30_c341,
	    (Real)s_c20_email_verification_d >= 0.5                                      => -0.0261257983,
	                                                                              -0.0132786679);
	/*  TREE 31  */  
	final_score_tree_31_c346 := map(
	    NULL < (integer)s_f01_inp_addr_not_verified_i AND (Real)s_f01_inp_addr_not_verified_i < 0.5 => -0.0040109131,            /*  TRUE Condition  */  
	    (Real)s_f01_inp_addr_not_verified_i >= 0.5                                                  =>  0.1346510188,            /*  FALSE Condition */ 
	                                                                                                    0.0576166122);
	final_score_tree_31_c348 := map(
	    BT_cen_urban_p = ''                                                                         => -0.0197652790,           //ECL handles empty this way
	    NULL < (integer)BT_cen_urban_p AND (Real)bT_cen_urban_p < 98.95                             => -0.0628888182,                
	    (Real)BT_cen_urban_p >= 98.95                                                               =>  0.0250050659,
	                                                                                                   -0.0197652790);          // SAS handles empty this was
	final_score_tree_31_c349 := map(
	    NULL < (integer)ip_state_match_d AND ip_state_match_d < 0.5                                 => 0.1488795733,
	    ip_state_match_d >= 0.5                                                                     => 0.0128407084,
	                                                                                                   0.0670436936);
	final_score_tree_31_c347 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'NET', 'ORG', 'TWO'])              => final_score_tree_31_c348,
	    (ip_topleveldomain_lvl_n in ['-1', 'US'])                                                   => final_score_tree_31_c349,
	                                                                                                   -0.0010299777);
	final_score_tree_31 := map(
	    NULL < (integer)b_addrchangeincomediff_d AND (Real)b_addrchangeincomediff_d < -20126.5      => final_score_tree_31_c346,
	    b_addrchangeincomediff_d >= -20126.5                                                        => -0.0188310709,
	                                                                                                   final_score_tree_31_c347);
	
	/*  TREE 32   */
	final_score_tree_32_c352 := map(
	    NULL < (integer)b_add_curr_nhood_sfd_pct_d AND (Real)b_add_curr_nhood_sfd_pct_d < 0.81004290275 => 0.1276740546,
	    b_add_curr_nhood_sfd_pct_d >= 0.81004290275                                      => -0.0607350834,
	                                                                                        -0.0106736662);
	
	final_score_tree_32_c354 := map(
	    NULL < (integer)s_c13_max_lres_d AND s_c13_max_lres_d < 76 => 0.0166177500,
	    s_c13_max_lres_d >= 76                            => 0.2086748043,
	                                                         0.0835640239);
	
	final_score_tree_32_c353 := map(
	    NULL < (integer)s_inq_per_addr_i AND (Real)s_inq_per_addr_i < 1.5 => final_score_tree_32_c354,
	    (Real)s_inq_per_addr_i >= 1.5                            => 0.0040753174,
	                                                          0.0827174549);
	
	final_score_tree_32_c351 := map(
	    (ip_connection_n in ['BROADBAND', 'DIALUP', 'XDSL'])                                => final_score_tree_32_c352,
	    (ip_connection_n in ['-1', 'CABLE', 'MOBILE', 'SATELLITE', 'T1', 'T3', 'WIRELESS']) => final_score_tree_32_c353,
	                                                                                           0.0428373101);
	
	final_score_tree_32 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'NET', 'ORG', 'US']) => -0.0044621447,
	    (ip_topleveldomain_lvl_n in ['-1', 'TWO'])                                    => final_score_tree_32_c351,
	                                                                                     0.0006864490);
	
	final_score_tree_33_c358 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 4395.5 => 0.0160909738,
	    btst_dist_inp_addr_to_ip_addr_i >= 4395.5                                           => 0.0898197456,
	                                                                                           0.0315418697);
	
	final_score_tree_33_c357 := map(
	    NULL < (integer)b_comb_age_d AND (Real)b_comb_age_d < 40.5 => -0.0208341337,
	    b_comb_age_d >= 40.5                        => final_score_tree_33_c358,
	                                                   0.0090213447);
	
	final_score_tree_33_c356 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_33_c357,
	    b_adl_per_email_i >= 0.5                             => -0.0635120161,
	                                                            -0.0238724926);
	
	final_score_tree_33_c359 := map(
	    NULL < (integer)b_prevaddrcartheftindex_i AND (Integer)b_prevaddrcartheftindex_i < 38 => 0.1739652318,
	    b_prevaddrcartheftindex_i >= 38                                     => 0.0367910824,
	                                                                           0.0774352748);
	
	final_score_tree_33 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_33_c356,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_33_c359,
	                                                                    -0.0210664911);
	/*  TREE 34  */     
	final_score_tree_34_c362 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'ORG', 'US']) => -0.0229558444,
	    (ip_topleveldomain_lvl_n in ['-1', 'NET', 'TWO'])                      => 0.0297850029,
	                                                                              0.0086715681);
	
	final_score_tree_34_c363 := map(
	    NULL < (integer)s_c20_email_verification_d AND (Real)s_c20_email_verification_d < 0.5 => 0.1510383054,
	    (Real)s_c20_email_verification_d >= 0.5                                               => 0.0222188312,
	                                                                                             0.0762399010);
	
	final_score_tree_34_c364 := map(
	    ST_cen_span_lang = ''                                                                 =>  0.0621440100,
	    NULL < (integer)ST_cen_span_lang AND (Real)ST_cen_span_lang < 147.5                   =>  0.1000498913,
	    (Real)ST_cen_span_lang >= 147.5                                                       => -0.0238731823,
	                                                                                              0.0621440100);
	
	final_score_tree_34_c361 := map(
	    NULL < (integer)s_curraddrmedianincome_d AND s_curraddrmedianincome_d < 129965 => final_score_tree_34_c362,
	    s_curraddrmedianincome_d >= 129965                                    => final_score_tree_34_c363,
	                                                                             final_score_tree_34_c364);
	
	final_score_tree_34 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 409.5 => -0.0374314840,
	    btst_dist_inp_addr_to_ip_addr_i >= 409.5                                           => final_score_tree_34_c361,
	                                                                                          -0.0076908954);
	
	final_score_tree_35_c368 := map(
	    NULL < (integer)b_add_curr_nhood_sfd_pct_d AND (Real)b_add_curr_nhood_sfd_pct_d < 0.89832576795 => 0.0233629087,
	    b_add_curr_nhood_sfd_pct_d >= 0.89832576795                                      => -0.0189995546,
	                                                                                        0.0357579106);
	
	final_score_tree_35_c367 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 10200.5 => final_score_tree_35_c368,
	    btst_dist_inp_addr_to_ip_addr_i >= 10200.5                                           => 0.1084083980,
	                                                                                            -0.0038918175);
	
	final_score_tree_35_c366 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_35_c367,
	    b_adl_per_email_i >= 0.5                             => -0.0624505366,
	                                                            -0.0205550277);
	
	final_score_tree_35_c369 := map(
	    ST_cen_med_hhinc = ''                                                 => 0.0554600800,
	    NULL < (integer)ST_cen_med_hhinc AND (Real)ST_cen_med_hhinc < 91711.5 => 0.0194077805,
	    (Real)ST_cen_med_hhinc >= 91711.5                                     => 0.1520530332,
	                                                                             0.0554600800);
	
	final_score_tree_35 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_35_c366,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_35_c369,
	                                                                    -0.0184912691);
	
	final_score_tree_36_c374 := map(
	    NULL < (integer)b_comb_age_d AND (Real)b_comb_age_d < 36.5 => 0.0670187682,
	    b_comb_age_d >= 36.5                        => 0.1584385687,
	                                                   0.1017142346);
	
	final_score_tree_36_c373 := map(
	    NULL < b_i60_inq_auto_recency_d AND (Integer)b_i60_inq_auto_recency_d < 549 => -0.0203556993,
	    b_i60_inq_auto_recency_d >= 549                                    => final_score_tree_36_c374,
	                                                                          0.0604365265);
	
	final_score_tree_36_c372 := map(
	    (ip_connection_n in ['BROADBAND', 'DIALUP', 'SATELLITE', 'XDSL'])      => 0.0079890692,
	    (ip_connection_n in ['-1', 'CABLE', 'MOBILE', 'T1', 'T3', 'WIRELESS']) => final_score_tree_36_c373,
	                                                                              0.0310752949);
	
	final_score_tree_36_c371 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'EDU', 'GOV', 'NET', 'ORG']) => -0.0057794269,
	    (ip_topleveldomain_lvl_n in ['-1', 'DOT', 'TWO', 'US'])          => final_score_tree_36_c372,
	                                                                        -0.0016515756);
	
	final_score_tree_36 := map(
	    ip_routingmethod_n = ''                                                  => -0.0006035462, 
	    NULL < (Integer) ip_routingmethod_n AND(Real) ip_routingmethod_n < 4     =>  0.1373171179,
	   (Real) ip_routingmethod_n >= 4                                            => final_score_tree_36_c371,
	                                                                                -0.0006035462);
	
	final_score_tree_37_c377 := map(
	    NULL < (integer)b_prevaddrcartheftindex_i AND (Integer)b_prevaddrcartheftindex_i < 84 => -0.0961585758,
	    b_prevaddrcartheftindex_i >= 84                                     => 0.0530256479,
	                                                                           -0.0169366088);
	
	final_score_tree_37_c378 := map(
	    NULL < (integer)s_l79_adls_per_addr_curr_i AND (Real)s_l79_adls_per_addr_curr_i < 1.5 => 0.0346041067,
	    (Real)s_l79_adls_per_addr_curr_i >= 1.5                                      => 0.1668154721,
	                                                                              0.0981072035);
	
	final_score_tree_37_c376 := map(
	    NULL < (integer)s_add_curr_nhood_bus_pct_i AND (Real)s_add_curr_nhood_bus_pct_i < 0.05195573415 => final_score_tree_37_c377,
	    (Real)s_add_curr_nhood_bus_pct_i >= 0.05195573415                                      => final_score_tree_37_c378,
	                                                                                        0.0367787006);
	
	final_score_tree_37_c379 := map(
	    ST_cen_very_rich = ''                                                     =>  0.0090926144,  
	    NULL < (integer)ST_cen_very_rich AND (Real)ST_cen_very_rich < 95.5        => -0.0284365198,
	    (Real)ST_cen_very_rich >= 95.5                                            =>  0.0659523876,
	                                                                                  0.0090926144);
	
	final_score_tree_37 := map(
	    NULL < (integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => final_score_tree_37_c376,
	    b_estimated_income_d >= 9999.5                                => -0.0110060956,
	                                                                     final_score_tree_37_c379);
	
	final_score_tree_38_c383 := map(
	    NULL < (integer)s_comb_age_d AND (Real)s_comb_age_d < 50.5           => 0.0131093257,
	    (Real)s_comb_age_d >= 50.5                                           => 0.0654081828,
	                                                                            0.0386439496);
	
	final_score_tree_38_c382 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_38_c383,
	    b_adl_per_email_i >= 0.5                             => -0.0514265240,
	                                                            -0.0038153199);
	
	final_score_tree_38_c384 := map(
	    NULL < (integer)b_c13_max_lres_d AND (Integer)b_c13_max_lres_d < 184 => 0.0141979734,
	    b_c13_max_lres_d >= 184                            => 0.1533371435,
	                                                          0.0817798560);
	
	final_score_tree_38_c381 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_38_c382,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_38_c384,
	                                                                    -0.0007290234);
	
	final_score_tree_38 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 684 => -0.0240743783,
	    btst_dist_inp_addr_to_ip_addr_i >= 684                                           => final_score_tree_38_c381,
	                                                                                        -0.0098005139);
	
	final_score_tree_39_c389 := map(
	    NULL < (integer)b_c20_email_count_i AND (Real)b_c20_email_count_i < 0.5 => 0.0463046163,
	    b_c20_email_count_i >= 0.5                               => 0.1452060807,
	                                                                0.0790676401);
	
	final_score_tree_39_c388 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 1.5 => final_score_tree_39_c389,
	    b_c20_email_verification_d >= 1.5                                      => 0.0029607021,
	                                                                              0.0389527094);
	
	final_score_tree_39_c387 := map(
	    NULL < (integer)s_estimated_income_d AND s_estimated_income_d < 84500 => -0.0133468121,
	    s_estimated_income_d >= 84500                                => final_score_tree_39_c388,
	                                                                    0.0103562888);
	
	final_score_tree_39_c386 := map(
	    NULL < (integer)b_a49_curr_avm_chg_1yr_pct_i AND (Real)b_a49_curr_avm_chg_1yr_pct_i < 78.75 => 0.1711521136,
	    b_a49_curr_avm_chg_1yr_pct_i >= 78.75                                        => final_score_tree_39_c387,
	                                                                                    -0.0002227689);
	
	final_score_tree_39 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 412.5 => -0.0332838926,
	    btst_dist_inp_addr_to_ip_addr_i >= 412.5                                           => final_score_tree_39_c386,
	                                                                                          0.0051109613);
	
	final_score_tree_40_c393 := map(
	    NULL < (integer)b_c14_addr_stability_v2_d AND (Real)b_c14_addr_stability_v2_d < 5.5 => 0.0242625172,
	    b_c14_addr_stability_v2_d >= 5.5                                     => -0.0500199949,
	                                                                            -0.0027493054);
	
	final_score_tree_40_c392 := map(
	    ST_cen_med_hhinc  = ''                                                => 0.0340705497, 
	    NULL < (integer)ST_cen_med_hhinc AND (Real)ST_cen_med_hhinc < 47038.5 => 0.1453052699,
	    (Real)ST_cen_med_hhinc >= 47038.5                            => final_score_tree_40_c393,
	                                                              0.0340705497);
	
	final_score_tree_40_c394 := map(
	    NULL < (integer)b_addrchangecrimediff_i AND (Real)b_addrchangecrimediff_i < -26.5 => 0.1871280422,
	    b_addrchangecrimediff_i >= -26.5                                   => -0.0062050621,
	                                                                          -0.0156204045);
	
	final_score_tree_40_c391 := map(
	    NULL < (integer)b_f01_inp_addr_address_score_d AND (Integer)b_f01_inp_addr_address_score_d < 55 => final_score_tree_40_c392,
	    b_f01_inp_addr_address_score_d >= 55                                          => final_score_tree_40_c394,
	                                                                                     -0.0117680942);
	
	final_score_tree_40 := map(
	    ip_routingmethod_n = ''                                                                      => -0.0035592561,
	    NULL < (Integer) ip_routingmethod_n AND(Real) ip_routingmethod_n < 4                         =>  0.1247859764,
	   (Real) ip_routingmethod_n >= 4                                                                => final_score_tree_40_c391,
	                                                                                                    -0.0035592561);
	
	final_score_tree_41_c399 := map(
	    NULL < (integer)b_c13_max_lres_d AND (Real)b_c13_max_lres_d < 110.5 => 0.1209801699,
	    b_c13_max_lres_d >= 110.5                            => 0.0168727545,
	                                                            0.0674392134);
	
	final_score_tree_41_c398 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5  => final_score_tree_41_c399,
	    (Real)btst_email_last_score_d >= 0.5                                             => -0.0050912200,
	                                                                                         0.0269641883);
	
	final_score_tree_41_c397 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 136.5 => -0.0630789497,
	    btst_dist_inp_addr_to_ip_addr_i >= 136.5                                           => final_score_tree_41_c398,
	                                                                                          0.0022160236);
	
	final_score_tree_41_c396 := map(
	    BT_cen_civ_emp = ''                                             => 0.0143545737, 
	    NULL < (integer)BT_cen_civ_emp AND (Real)bT_cen_civ_emp < 46.05 => 0.2326277737,
	    (Real)BT_cen_civ_emp >= 46.05                                   => final_score_tree_41_c397,
	                                                                       0.0143545737);
	
	final_score_tree_41 := map(
	    NULL < (integer)s_f01_inp_addr_address_score_d AND s_f01_inp_addr_address_score_d < 95 => final_score_tree_41_c396,
	    s_f01_inp_addr_address_score_d >= 95                                          => -0.0086228766,
	                                                                                     -0.0086125485);
	
	final_score_tree_42_c404 := map(
	    ST_cen_easiqlife = ''                                               =>  0.0562269971,
	    NULL < (integer)ST_cen_easiqlife AND (Real)ST_cen_easiqlife < 127.5 => -0.0010601917,
	    (Real)ST_cen_easiqlife >= 127.5                                     => 0.1276397940,
	                                                                           0.0562269971);
	
	final_score_tree_42_c403 := map(
	    NULL < (integer)b_f01_inp_addr_not_verified_i AND (Real)b_f01_inp_addr_not_verified_i < 0.5 => 0.0105594311,
	    b_f01_inp_addr_not_verified_i >= 0.5                                         => final_score_tree_42_c404,
	                                                                                    0.0239838473);
	
	final_score_tree_42_c402 := map(
	    (btst_email_topleveldomain_n in ['EDU', 'GOV', 'ORG', 'OTH'])       => -0.0576746835,
	    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'MIL', 'NET', 'US']) => final_score_tree_42_c403,
	                                                                           0.0106334016);
	
	final_score_tree_42_c401 := map(
	    NULL < (integer)s_add_input_nhood_sfd_pct_d AND (Real)s_add_input_nhood_sfd_pct_d < 0.80075354375 => final_score_tree_42_c402,
	    (Real)s_add_input_nhood_sfd_pct_d >= 0.80075354375                                       => -0.0175634845,
	                                                                                          -0.0036570970);
	
	final_score_tree_42 := map(
	    NULL < (integer)ip_non_us_time_zone_i AND ip_non_us_time_zone_i < 0.5 => final_score_tree_42_c401,
	    ip_non_us_time_zone_i >= 0.5                                 => -0.1067532507,
	                                                                    -0.0048588486);
	
	final_score_tree_43_c407 := map(
	    NULL < (integer)s_add_curr_nhood_bus_pct_i AND (Real)s_add_curr_nhood_bus_pct_i < 0.05789175725 => -0.0229430979,
	    (Real)s_add_curr_nhood_bus_pct_i >= 0.05789175725                                      => 0.0238889560,
	                                                                                        0.0088430271);
	
	final_score_tree_43_c409 := map(
	    NULL < (integer)s_curraddrcrimeindex_i AND s_curraddrcrimeindex_i < 64.5 => 0.0577458187,
	    (Real)s_curraddrcrimeindex_i >= 64.5                                  => -0.0512435880,
	                                                                       -0.0061151618);
	
	final_score_tree_43_c408 := map(
	    BT_cen_easiqlife = ''                                               =>  0.0428979123,
	    NULL < (integer)BT_cen_easiqlife AND (Real)bT_cen_easiqlife < 92.5 => 0.1473520048,
	    (Real)BT_cen_easiqlife >= 92.5                            => final_score_tree_43_c409,
	                                                           0.0428979123);
	
	final_score_tree_43_c406 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_43_c407,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_43_c408,
	                                                                    -0.0031400547);
	
	final_score_tree_43 := map(
	    ip_routingmethod_n = ''                                                   => -0.0020677717,
	    NULL < (Integer) ip_routingmethod_n AND(Real) ip_routingmethod_n < 4      =>  0.1390251785,
	   (Real) ip_routingmethod_n >= 4                                             => final_score_tree_43_c406,
	                                                                                 -0.0020677717);
	
	final_score_tree_44_c412 := map(
	    NULL < (integer)s_c20_email_count_i AND (Real)s_c20_email_count_i < 1.5 => 0.2297536345,
	    (Real)s_c20_email_count_i >= 1.5                               => -0.0342355296,
	                                                                0.0954020064);
	
	final_score_tree_44_c411 := map(
	    NULL < (integer)b_d33_eviction_count_i AND (Real)b_d33_eviction_count_i < 1.5 => -0.0052553928,
	    b_d33_eviction_count_i >= 1.5                                  => final_score_tree_44_c412,
	                                                                      -0.0009508448);
	
	final_score_tree_44_c414 := map(
	    NULL < (integer)s_e57_br_source_count_d AND (Real)s_e57_br_source_count_d < 0.5 => 0.0325320905,
	    (Real)s_e57_br_source_count_d >= 0.5                                   => 0.1801552640,
	                                                                        0.0872073399);
	
	final_score_tree_44_c413 := map(
	    NULL < (integer)b_rel_bankrupt_count_i AND (Real)b_rel_bankrupt_count_i < 1.5 => final_score_tree_44_c414,
	    b_rel_bankrupt_count_i >= 1.5                                  => -0.0454181337,
	                                                                      0.0507177916);
	
	final_score_tree_44 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_44_c411,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_44_c413,
	                                                                    -0.0016691324);
	
	final_score_tree_45_c418 := map(
	    ST_cen_ownocc_p = ''                                                       => 0.0562358556,
	    NULL < (integer)ST_cen_ownocc_p AND (Real)ST_cen_ownocc_p < 66.75          => 0.0233394360,               
	    (Real)ST_cen_ownocc_p >= 66.75                                             => 0.1161014119,
	                                                                                  0.0562358556);
	
	final_score_tree_45_c417 := map(
	    NULL < (integer)b_addrchangeincomediff_d AND (Integer)b_addrchangeincomediff_d < 1755  => -0.0235503441,
	    b_addrchangeincomediff_d >= 1755                                                       =>  0.1056175341,
	                                                                                               final_score_tree_45_c418);
	
	final_score_tree_45_c416 := map(
	    NULL < (Integer)s_nap_nothing_found_i AND (Real)s_nap_nothing_found_i < 0.5     => -0.0122239058,
	    (Real)s_nap_nothing_found_i >= 0.5                                              => final_score_tree_45_c417,
	                                                                                       -0.0080127861);
	
	final_score_tree_45_c419 := map(
	    NULL < (integer)b_rel_ageover40_count_d AND (Real)b_rel_ageover40_count_d < 3.5  => 0.1628425921,
	    b_rel_ageover40_count_d >= 3.5                                                   => 0.0048778737,
	                                                                                        0.0630034194);
	
	final_score_tree_45 := map(
	    BT_cen_med_hval = ''                                                             => -0.0062503963,
	    NULL < (integer)BT_cen_med_hval AND (Integer)BT_cen_med_hval < 818568            => final_score_tree_45_c416,
	    (Integer)BT_cen_med_hval >= 818568                                               => final_score_tree_45_c419,
	                                                                                        -0.0062503963);
	
	
	final_score_tree_46_c423 := map(
	    ST_cen_civ_emp = ''                                                             =>  0.0735341780,
	    NULL < (integer)ST_cen_civ_emp AND (Real)ST_cen_civ_emp < 66.45                 =>  0.1279123803,            
	    (Real)ST_cen_civ_emp >= 66.45                                                   => -0.0181623984,
	                                                                                        0.0735341780);
	
	final_score_tree_46_c422 := map(
	    NULL < (integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5 => final_score_tree_46_c423,
	    (Real)s_nap_lname_verd_d >= 0.5                              => -0.0594649322,
	                                                              0.0318478897);
	
	final_score_tree_46_c421 := map(
	    NULL < (integer)s_curraddrcartheftindex_i AND (Real)s_curraddrcartheftindex_i < 193.5 => 0.0001367860,
	    (Real)s_curraddrcartheftindex_i >= 193.5                                              => 0.1336697515,
	                                                                                             final_score_tree_46_c422);
	
	final_score_tree_46_c424 := map(
	    (btst_email_topleveldomain_n in ['EDU', 'NET', 'ORG', 'OTH'])            => -0.0634043994,
	    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'GOV', 'MIL', 'US'])      =>  0.0133781224,                    
	                                                                                -0.0010615757);
	
	final_score_tree_46 := map(
	    BT_cen_mil_emp = ''                                                      => final_score_tree_46_c424,       //Use this value when the Census data is not populated.  
	    NULL < (integer)BT_cen_mil_emp AND (Real)BT_cen_mil_emp < 0.25           => final_score_tree_46_c421,
	    (Real)BT_cen_mil_emp >= 0.25                                             => -0.0388690138,
	                                                                                final_score_tree_46_c424);        
	
	final_score_tree_47_c426 := map(
	    NULL < (integer)btst_addrscore_d AND (Integer)btst_addrscore_d < 85 => -0.0912132799,
	    (Integer)btst_addrscore_d >= 85                                     => -0.0106059265,
	                                                         -0.0140213801);
	
	final_score_tree_47_c429 := map(
	    NULL < (integer)s_comb_age_d AND (Real)s_comb_age_d < 58.5   => -0.0024766592,
	    (Real)s_comb_age_d >= 58.5                                   => 0.0595525668,
	                                                                    0.0038313976);
	
	final_score_tree_47_c428 := map(
	    NULL < (integer)s_prevaddrmedianincome_d AND (integer)s_prevaddrmedianincome_d < 20607 => 0.1228299042,
	    (integer)s_prevaddrmedianincome_d >= 20607                                    => final_score_tree_47_c429,
	                                                                            0.0115514120);
	
	final_score_tree_47_c427 := map(
	    ST_cen_totcrime = ''                                               => 0.0215854425,
	    NULL < (integer)ST_cen_totcrime AND (Real)ST_cen_totcrime < 185.5  => final_score_tree_47_c428,
	    (Real)ST_cen_totcrime >= 185.5                                     => 0.2380889480,
	                                                                          0.0215854425);
	
	final_score_tree_47 := map(
	    NULL < (integer)s_l79_adls_per_addr_c6_i AND (Real)s_l79_adls_per_addr_c6_i < 1.5  => final_score_tree_47_c426,
	    (Real)s_l79_adls_per_addr_c6_i >= 1.5                                              => final_score_tree_47_c427,
	                                                                                          -0.0082248068);
	
	final_score_tree_48_c432 := map(
	    NULL < (integer)s_i60_inq_retpymt_recency_d AND (integer)s_i60_inq_retpymt_recency_d < 549  => 0.1860274340,
	    (integer)s_i60_inq_retpymt_recency_d >= 549                                                 => 0.0210740995,
	                                                                                                   0.0450785027);
	
	final_score_tree_48_c431 := map(
	    NULL < (integer)b_c14_addrs_15yr_i AND (Real)b_c14_addrs_15yr_i < 0.5   => final_score_tree_48_c432,
	    b_c14_addrs_15yr_i >= 0.5                                               => -0.0184291862,
	                                                                               -0.0192205736);
	
	final_score_tree_48_c434 := map(
	    NULL < (integer)s_phones_per_addr_curr_i AND (Real)s_phones_per_addr_curr_i < 0.5 => 0.1124616508,
	    (Real)s_phones_per_addr_curr_i >= 0.5                                             => 0.0018526120,
	                                                                                         0.0138833399);
	
	final_score_tree_48_c433 := map(
	    NULL < (integer)s_inq_count24_i AND (Real)s_inq_count24_i < 6.5 => final_score_tree_48_c434,
	    (Real)s_inq_count24_i >= 6.5                           => 0.1894519249,
	                                                        0.0739093000);
	
	final_score_tree_48 := map(
	    NULL < (integer)b_add_input_nhood_mfd_pct_i AND (Real)b_add_input_nhood_mfd_pct_i < 0.507754206 => final_score_tree_48_c431,
	    (Real)b_add_input_nhood_mfd_pct_i >= 0.507754206                                                => final_score_tree_48_c433,
	                                                                                                       -0.0084256775);
	
	final_score_tree_49_c439 := map(
	    (ip_connection_n in ['MOBILE', 'SATELLITE', 'XDSL'])                                => -0.0219988360,
	    (ip_connection_n in ['-1', 'BROADBAND', 'CABLE', 'DIALUP', 'T1', 'T3', 'WIRELESS']) => 0.0533224581,
	                                                                                           0.0312732759);
	
	final_score_tree_49_c438 := map(
	    (btst_email_topleveldomain_n in ['NET', 'ORG', 'OTH'])                     => -0.0351914612,
	    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'EDU', 'GOV', 'MIL', 'US']) => final_score_tree_49_c439,
	                                                                                  0.0153044754);
	
	final_score_tree_49_c437 := map(
	    BT_cen_incollege = ''                                                     => final_score_tree_49_c438,
	    NULL < (integer)BT_cen_incollege AND (Real)bT_cen_incollege < 5.95        =>  0.1165533437,
	    (Real)BT_cen_incollege >= 5.95                                            => -0.0120990018,
	                                                                                 final_score_tree_49_c438);
	
	final_score_tree_49_c436 := map(
	    NULL < (integer)s_add_input_nhood_sfd_pct_d AND (Real)s_add_input_nhood_sfd_pct_d < 0.43614142665  => final_score_tree_49_c437,
	    (Real)s_add_input_nhood_sfd_pct_d >= 0.43614142665                                                 => -0.0150862660,
	                                                                                                          -0.0027270921);
	
	final_score_tree_49 := map(
	    NULL < (integer)b_add_curr_nhood_mfd_pct_i AND (Real)b_add_curr_nhood_mfd_pct_i < 0.9720569641 => -0.0103935583,
	    (Real)b_add_curr_nhood_mfd_pct_i >= 0.9720569641                                               => 0.1751815361,
	                                                                                                      final_score_tree_49_c436);
	
	final_score_tree_50_c443 := map(
	    ST_cen_rental = ''                                                   => -0.0293637729,  
	    NULL < (integer)ST_cen_rental AND (Integer)ST_cen_rental < 130       =>  0.0221455949,
	    (Integer)ST_cen_rental >= 130                                        => -0.1016750008,
	                                                                            -0.0293637729);
	
	final_score_tree_50_c442 := map(
	    ST_cen_incollege = ''                                                => -0.0012331452,
	    NULL < (integer)ST_cen_incollege AND (Real)ST_cen_incollege < 9.95   => final_score_tree_50_c443,
	    (Real)ST_cen_incollege >= 9.95                                       =>  0.0604568278,
	                                                                            -0.0012331452);
	
	final_score_tree_50_c444 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 2.5   => -0.0017591016,
	    (Real)btst_email_first_score_d >= 2.5                                               => -0.0912513141,
	                                                                                           -0.0154651161);
	
	final_score_tree_50_c441 := map(
	    BT_cen_incollege = ''                                                              => final_score_tree_50_c444, 
	    NULL < (integer)BT_cen_incollege AND (Real)bT_cen_incollege < 3.85                 => 0.1205950962,
	    (Real)BT_cen_incollege >= 3.85                                                     => final_score_tree_50_c442,
	                                                                                          final_score_tree_50_c444);
	
	final_score_tree_50 := map(
	    NULL < (integer)b_srchfraudsrchcountyr_i AND (Real)b_srchfraudsrchcountyr_i < 6.5  => -0.0097944101,
	    (Real)b_srchfraudsrchcountyr_i >= 6.5                                              => 0.1720368894,
	                                                                                         final_score_tree_50_c441);
	
	final_score_tree_51_c449 := map(
	    NULL < (integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5        => 0.1314584774,
	    (Real)b_c20_email_verification_d >= 0.5                                                      => -0.0361323774,
	                                                                                                     0.0851035602);
	
	final_score_tree_51_c448 := map(
	    (ip_connection_n in ['BROADBAND', 'DIALUP', 'MOBILE', 'SATELLITE', 'T1']) => 0.0090587683,
	    (ip_connection_n in ['-1', 'CABLE', 'T3', 'WIRELESS', 'XDSL'])            => final_score_tree_51_c449,
	                                                                                 0.0329498460);
	
	final_score_tree_51_c447 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 473  => -0.0000140758,
	    (Integer)btst_dist_inp_addr_to_ip_addr_i >= 473                                                     => final_score_tree_51_c448,
	                                                                                                            0.0168051694);
	
	final_score_tree_51_c446 := map(
	    NULL < (integer)s_addrchangeecontrajindex_d AND (Real)s_addrchangeecontrajindex_d < 2.5             => -0.0272985044,
	    (Real)s_addrchangeecontrajindex_d >= 2.5                                                            => final_score_tree_51_c447,
	                                                                                                           0.0105796902);
	
	final_score_tree_51 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5 => final_score_tree_51_c446,
	    (Real)btst_email_last_score_d >= 0.5                                            => -0.0224454145,
	                                                                                       -0.0113797315);
	
	final_score_tree_52_c454 := map(
	    NULL < (integer)b_i60_inq_auto_recency_d AND (Integer)b_i60_inq_auto_recency_d < 549 => -0.0146023819,
	    (Integer)b_i60_inq_auto_recency_d >= 549                                             =>  0.1619126818,
	                                                                                             0.0859131405);
	
	final_score_tree_52_c453 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 5848.5  => 0.0181223151,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 5848.5                                                     => final_score_tree_52_c454,
	                                                                                                           0.0285405422);
	
	final_score_tree_52_c452 := map(
	    NULL < (integer)s_prevaddrageoldest_d AND (Integer)s_prevaddrageoldest_d < 340        => final_score_tree_52_c453,
	    (Integer)s_prevaddrageoldest_d >= 340                                                 => 0.2291130603,
	                                                                                             0.0390863167);
	
	final_score_tree_52_c451 := map(
	    NULL < (integer)b_c20_email_count_i AND (Real)b_c20_email_count_i < 1.5   => -0.0014157538,
	    (Real)b_c20_email_count_i >= 1.5                                          => final_score_tree_52_c452,
	                                                                                 0.0063022413);
	
	final_score_tree_52 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5             => final_score_tree_52_c451,
	    (Real)b_adl_per_email_i >= 0.5                                                  => -0.0317219002,
	                                                                                       -0.0077346110);
	
	final_score_tree_53_c459 := map(
	    NULL < (integer)s_curraddrcrimeindex_i AND (Real)s_curraddrcrimeindex_i < 154.5 => 0.0582145954,
	    (Real)s_curraddrcrimeindex_i >= 154.5                                           => 0.2317296211,
	                                                                                       0.0460548530);
	
	final_score_tree_53_c458 := map(
	    NULL < (integer)b_add_input_nhood_vac_pct_i AND (Real)b_add_input_nhood_vac_pct_i < 0.112794865  => final_score_tree_53_c459,
	    (Real)b_add_input_nhood_vac_pct_i >= 0.112794865                                                 => -0.0571697798,
	                                                                                                         0.0443829308);
	
	final_score_tree_53_c457 := map(
	    NULL < (integer)s_addrchangecrimediff_i AND (Real)s_addrchangecrimediff_i < -20.5   => 0.1042051468,
	    (Real)s_addrchangecrimediff_i >= -20.5                                              => 0.0169644924,
	                                                                                           final_score_tree_53_c458);
	
	final_score_tree_53_c456 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5    => final_score_tree_53_c457,
	    (Real)b_adl_per_email_i >= 0.5                                         => -0.0226754561,
	                                                                               0.0046092999);
	
	final_score_tree_53 := map(
	    NULL < (integer)b_add_input_nhood_vac_pct_i AND (Real)b_add_input_nhood_vac_pct_i < 0.0016090115  => -0.0203210252,
	    (Real)b_add_input_nhood_vac_pct_i >= 0.0016090115                                                 => final_score_tree_53_c456,
	                                                                                                         -0.0030103950);
	
	final_score_tree_54_c462 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (integer)btst_dist_inp_addr_to_ip_addr_i < 721 => 0.0106387674,
	    (integer)btst_dist_inp_addr_to_ip_addr_i >= 721                                                    => 0.0970683621,
	                                                                                                          0.0462001391);
	
	final_score_tree_54_c461 := map(
	    NULL < (integer)b_add_curr_nhood_sfd_pct_d AND (Real)b_add_curr_nhood_sfd_pct_d < 0.9710214898 => final_score_tree_54_c462,
	    (Real)b_add_curr_nhood_sfd_pct_d >= 0.9710214898                                               => -0.0573927200,
	                                                                                                       0.0282706058);
	
	final_score_tree_54_c464 := map(
	    ST_cen_vacant_p = ''                                              =>  0.0372784748,
	    NULL < (integer)ST_cen_vacant_p AND (Real)ST_cen_vacant_p < 4.85  => -0.0471731121,
	    (Real)ST_cen_vacant_p >= 4.85                                     =>  0.0924968201,
	                                                                          0.0372784748);
	
	final_score_tree_54_c463 := map(
	    BT_cen_unemp = ''                                           => -0.0107224062,
	    NULL < (integer)BT_cen_unemp AND (Real)bT_cen_unemp < 4.05  => final_score_tree_54_c464,
	    (Real)BT_cen_unemp >= 4.05                                  => -0.0511082686,
	                                                                   -0.0107224062);
	
	final_score_tree_54 := map(
	    NULL < (integer)b_rel_count_i AND (Real)b_rel_count_i < 2.5   => final_score_tree_54_c461,
	    (Real)b_rel_count_i >= 2.5                                    => -0.0068423075,
	                                                                     final_score_tree_54_c463);
	
	/*  TREE 55  */  
	final_score_tree_55_c469 := map(
	    NULL < (integer)BT_cen_med_rent AND (Integer)BT_cen_med_rent < 872   =>  0.0788758606,
	    (Integer)BT_cen_med_rent >= 872                                      => -0.0160004232,
	                                                                             0.0385180384);
	
	final_score_tree_55_c468 := map(
	    NULL < (Integer)b_nap_nothing_found_i AND (Real)b_nap_nothing_found_i < 0.5 => -0.0911266261,
	    (Real)b_nap_nothing_found_i >= 0.5                                 => final_score_tree_55_c469,
	                                                                    -0.0145962955);
	
	final_score_tree_55_c467 := map(
	    NULL < (integer)s_c21_m_bureau_adl_fs_d AND (Real)s_c21_m_bureau_adl_fs_d < 34.5 => 0.1246817700,
	    (Real)s_c21_m_bureau_adl_fs_d >= 34.5                                   => -0.0219504808,
	                                                                         final_score_tree_55_c468);
	
	final_score_tree_55_c466 := map(
	    BT_cen_ownocc_p = ''                                                    => -0.0065931204,                     
	    NULL < (integer)BT_cen_ownocc_p AND (Real)bT_cen_ownocc_p < 8.35        =>  0.1068549572,                     
	    (Real)BT_cen_ownocc_p >= 8.35                                           => final_score_tree_55_c467,
	                                                                               -0.0065931204);                    
	
	final_score_tree_55 := map(
	    NULL < (integer)b_addrchangevaluediff_d AND (Real)b_addrchangevaluediff_d < 144824.5 => -0.0031997685,
	    b_addrchangevaluediff_d >= 144824.5                                   => 0.1077779231,
	                                                                             final_score_tree_55_c466);
	
	final_score_tree_56_c474 := map(
	    NULL < (integer)s_curraddrcrimeindex_i AND (Real)s_curraddrcrimeindex_i < 105.5 => 0.0617557589,
	    (Real)s_curraddrcrimeindex_i >= 105.5                                  => -0.0554944072,
	                                                                        0.0144302950);
	
	final_score_tree_56_c473 := map(
	    NULL < (integer)b_addrchangecrimediff_i AND (Integer)b_addrchangecrimediff_i < -16 => 0.1127862908,
	    b_addrchangecrimediff_i >= -16                                   => final_score_tree_56_c474,
	                                                                        0.0256444040);
	
	final_score_tree_56_c472 := map(
	    NULL < (integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5 => final_score_tree_56_c473,
	    (Real)s_nap_lname_verd_d >= 0.5                              => -0.0095567642,
	                                                              -0.0046498541);
	
	final_score_tree_56_c471 := map(
	    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'EDU', 'GOV', 'MIL', 'NET', 'ORG']) => final_score_tree_56_c472,
	    (btst_email_topleveldomain_n in ['OTH', 'US'])                                     => 0.1299612069,
	                                                                                          -0.0035489619);
	
	final_score_tree_56 := map(
	    NULL < (integer)b_add_input_nhood_bus_pct_i AND (Real)b_add_input_nhood_bus_pct_i < 0.33034066355 => final_score_tree_56_c471,
	    b_add_input_nhood_bus_pct_i >= 0.33034066355                                       => -0.1035260616,
	                                                                                          -0.0035445363);
	
	final_score_tree_57_c478 := map(
	    NULL < (integer)s_curraddrmedianvalue_d AND s_curraddrmedianvalue_d < 349711 => 0.0117644960,
	    s_curraddrmedianvalue_d >= 349711                                   => 0.0591885039,
	                                                                           0.0259840121);
	
	final_score_tree_57_c477 := map(
	    NULL < (integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_57_c478,
	    b_adl_per_email_i >= 0.5                             => -0.0252969828,
	                                                            -0.0009136141);
	
	final_score_tree_57_c476 := map(
	    NULL < (integer)s_comb_age_d AND (Real)s_comb_age_d < 24.5       => -0.0443332668,
	    (Real)s_comb_age_d >= 24.5                                       => final_score_tree_57_c477,
	                                                                        -0.0055530340);
	
	final_score_tree_57_c479 := map(
	    (ip_connection_n in ['MOBILE', 'XDSL'])                                                          => -0.0038414797,
	    (ip_connection_n in ['-1', 'BROADBAND', 'CABLE', 'DIALUP', 'SATELLITE', 'T1', 'T3', 'WIRELESS']) => 0.1438501481,
	                                                                                                        0.0575233516);
	
	final_score_tree_57 := map(
	    (ip_topleveldomain_lvl_n in ['-1', 'COM', 'DOT', 'EDU', 'GOV', 'NET', 'ORG', 'US']) => final_score_tree_57_c476,
	    (ip_topleveldomain_lvl_n in ['TWO'])                                                => final_score_tree_57_c479,
	                                                                                           -0.0072683039);
	
	final_score_tree_58_c484 := map(
	    NULL < (integer)s_curraddrburglaryindex_i AND (Real)s_curraddrburglaryindex_i < 140.5 => 0.0184115601,
	    (Real)s_curraddrburglaryindex_i >= 140.5                                     => -0.1262509082,
	                                                                              -0.0014052164);
	
	final_score_tree_58_c483 := map(
	    ST_cen_med_rent = ''                                                       => -0.0124268955,
	    NULL < (integer)ST_cen_med_rent AND (Real)ST_cen_med_rent < 650.5          =>  0.0985597735,
	    (Real)ST_cen_med_rent >= 650.5                                             =>  final_score_tree_58_c484,
	                                                                                  -0.0124268955);
	
	final_score_tree_58_c482 := map(
	    (ip_connection_n in ['BROADBAND', 'MOBILE', 'SATELLITE', 'WIRELESS', 'XDSL']) => final_score_tree_58_c483,
	    (ip_connection_n in ['-1', 'CABLE', 'DIALUP', 'T1', 'T3'])                    => 0.1060664688,
	                                                                                     0.0257855792);
	
	final_score_tree_58_c481 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'NET', 'ORG', 'US']) => -0.0068254836,
	    (ip_topleveldomain_lvl_n in ['-1', 'TWO'])                                    => final_score_tree_58_c482,
	                                                                                     -0.0035566807);
	
	final_score_tree_58 := map(
	    (ip_continent_n in ['AFRICA', 'AUSTRALIA', 'EUROPE', 'Other', 'S AMERICA']) => -0.0963718701,
	    (ip_continent_n in ['ASIA', 'N AMERICA'])                                   => final_score_tree_58_c481,
	                                                                                   -0.0044857235);
	
	final_score_tree_59_c488 := map(
	    NULL < (integer)b_nap_lname_verd_d AND (Real)b_nap_lname_verd_d < 0.5  =>  0.0620426163,
	    (Real)b_nap_lname_verd_d >= 0.5                                        => -0.0480638304,
	                                                                               0.0274800545);
	
	final_score_tree_59_c487 := map(
	    NULL < (integer)b_curraddrcartheftindex_i AND (Real)b_curraddrcartheftindex_i < 168.5  => -0.0020159061,
	    (Real)b_curraddrcartheftindex_i >= 168.5                                               => 0.0649011543,
	                                                                                              final_score_tree_59_c488);
	
	final_score_tree_59_c486 := map(
	     BT_cen_incollege = ''                                                        => -0.0042184542,
	    NULL < (integer)BT_cen_incollege AND (Real)bT_cen_incollege < 14.75           => final_score_tree_59_c487,
	    (Real)BT_cen_incollege >= 14.75                                               => -0.0598102858,
	                                                                                     -0.0042184542);
	
	final_score_tree_59_c489 := map(
	    ST_cen_span_lang = ''                                                 =>  0.0722091636,
	    NULL < (integer)ST_cen_span_lang AND (Real)ST_cen_span_lang < 148.5   => -0.0065972652,
	    (Real)ST_cen_span_lang >= 148.5                                       =>  0.1924223600,
	                                                                              0.0722091636);
	
	final_score_tree_59 := map(
	    NULL < (integer)s_l79_adls_per_addr_c6_i AND (Real)s_l79_adls_per_addr_c6_i < 6.5 => final_score_tree_59_c486,
	    (Real)s_l79_adls_per_addr_c6_i >= 6.5                                    => final_score_tree_59_c489,
	                                                                          0.0013608890);
	
	final_score_tree_60_c492 := map(
	    NULL < (integer)b_componentcharrisktype_i AND (Real)b_componentcharrisktype_i < 2.5  =>  0.1479778330,
	    (Real)b_componentcharrisktype_i >= 2.5                                               => -0.0083774524,
	                                                                                             0.0326928299);
	
	final_score_tree_60_c491 := map(
	    NULL < (integer)s_add_curr_nhood_mfd_pct_i AND (Real)s_add_curr_nhood_mfd_pct_i < 0.87568569155 => final_score_tree_60_c492,
	    (Real)s_add_curr_nhood_mfd_pct_i >= 0.87568569155                                      => 0.1831258043,
	                                                                                        -0.0003974165);
	
	final_score_tree_60_c494 := map(
	    BT_cen_incollege = ''                                                  =>  0.0105504796,
	    NULL < (integer)BT_cen_incollege AND (Real)BT_cen_incollege < 7.7      =>  0.0936405165,              
	    (Real)BT_cen_incollege >= 7.7                                          => -0.0135001134,
	                                                                               0.0105504796);            
	
	final_score_tree_60_c493 := map(
	    NULL < (integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5  => final_score_tree_60_c494,
	    (Real)s_nap_lname_verd_d >= 0.5                                        => -0.0742672894,
	                                                                              0.0093832616);
	
	final_score_tree_60 := map(
	    NULL < (integer)s_l79_adls_per_addr_curr_i AND (Real)s_l79_adls_per_addr_curr_i < 5.5 => -0.0164934481,
	    (Real)s_l79_adls_per_addr_curr_i >= 5.5                                      => final_score_tree_60_c491,
	                                                                              final_score_tree_60_c493);
	
	final_score_tree_61_c497 := map(
	    NULL < (integer)s_componentcharrisktype_i AND (Real)s_componentcharrisktype_i < 3.5 => 0.0380545923,
	    (Real)s_componentcharrisktype_i >= 3.5                                     => -0.0323193760,
	                                                                            0.0130928856);
	
	final_score_tree_61_c499 := map(
	    NULL < (integer)s_m_bureau_adl_fs_notu_d AND s_m_bureau_adl_fs_notu_d < 232 => 0.1973823678,
	    s_m_bureau_adl_fs_notu_d >= 232                                    => 0.0212686555,
	                                                                          0.1093255117);
	
	final_score_tree_61_c498 := map(
	    NULL < (integer)b_f01_inp_addr_address_score_d AND (Integer)b_f01_inp_addr_address_score_d < 95 => final_score_tree_61_c499,
	   (Integer)b_f01_inp_addr_address_score_d >= 95                                          => -0.0008526882,
	                                                                                     0.0047373099);
	
	final_score_tree_61_c496 := map(
	    NULL < (integer)b_addrchangecrimediff_i AND (Integer)b_addrchangecrimediff_i < 5 => final_score_tree_61_c497,
	    (Integer)b_addrchangecrimediff_i >= 5                                   => 0.0965528014,
	                                                                      final_score_tree_61_c498);
	
	final_score_tree_61 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5 => final_score_tree_61_c496,
	    (Real)btst_email_last_score_d >= 0.5                                   => -0.0133930663,
	                                                                        -0.0016619731);
	
	final_score_tree_62_c503 := map(
	    BT_cen_unemp = ''                                                        => 0.1133645520,                     //use this value when the census data is empty
	    NULL < (integer)BT_cen_unemp AND (Real)bT_cen_unemp < 3.55               => 0.1695291471,
	    (Real)BT_cen_unemp >= 3.55                                               => 0.0618252765,
	                                                                                0.1133645520);
	
	final_score_tree_62_c502 := map(
	    NULL < (integer)b_nae_email_verd_d AND (Real)b_nae_email_verd_d < 0.5 => final_score_tree_62_c503,
	    (Real)b_nae_email_verd_d >= 0.5                              => -0.0633725610,
	                                                              0.0576700836);
	
	final_score_tree_62_c501 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 1096 => 0.0061999525,
	    (Integer)btst_dist_inp_addr_to_ip_addr_i >= 1096                                           => final_score_tree_62_c502,
	                                                                                         0.0250749775);
	
	final_score_tree_62_c504 := map(
	    ST_cen_low_hval = ''                                                             => -0.0090555635,
	    NULL < (integer)ST_cen_low_hval AND (Real)ST_cen_low_hval < 2.05                 =>  0.0236499393,
	    (Real)ST_cen_low_hval >= 2.05                                                    => -0.0685292493,
	                                                                                        -0.0090555635);
	
	final_score_tree_62 := map(
	    NULL < (integer)b_comb_age_d AND (Real)b_comb_age_d < 61.5 => -0.0025065194,
	    b_comb_age_d >= 61.5                        => final_score_tree_62_c501,
	                                                   final_score_tree_62_c504);
	
	final_score_tree_63_c509 := map(
	    BT_cen_med_rent = ''                                                     => 0.0675099493, 
	    NULL < (integer)BT_cen_med_rent AND (Real)bT_cen_med_rent < 424.5        => 0.1842040895,
	    (Real)BT_cen_med_rent >= 424.5                                           => 0.0529231818,
	                                                                                0.0675099493);
	
	final_score_tree_63_c508 := map(
	    ST_cen_health = ''                                                       =>  0.0537744358,
	    NULL < (integer)ST_cen_health AND (Real)ST_cen_health < 25.55            => final_score_tree_63_c509,
	    (Real)ST_cen_health >= 25.55                                             => -0.0650905849,
	                                                                                 0.0537744358);
	
	final_score_tree_63_c507 := map(
	    NULL < (integer)s_add_input_nhood_vac_pct_i AND (Real)s_add_input_nhood_vac_pct_i < 0.00051755955 => -0.0594953954,
	    (Real)s_add_input_nhood_vac_pct_i >= 0.00051755955                                                =>  final_score_tree_63_c508,
	                                                                                                          0.0362309603);
	
	final_score_tree_63_c506 := map(
	    NULL < (integer)b_rel_ageover50_count_d AND (Real)b_rel_ageover50_count_d < 4.5  => -0.0009031248,
	    b_rel_ageover50_count_d >= 4.5                                                   =>  0.1194713942,
	                                                                                         final_score_tree_63_c507);
	
	final_score_tree_63 := map(
	    BT_cen_span_lang = ''                                                           =>  0.0024017441, 
	    NULL < (integer)BT_cen_span_lang AND (Real)BT_cen_span_lang < 186.5             => final_score_tree_63_c506,
	    (Real)BT_cen_span_lang >= 186.5                                                 => -0.0620591004,
	                                                                                        0.0024017441);
	
	final_score_tree_64_c512 := map(
	    NULL < (integer)s_f01_inp_addr_address_score_d AND (Integer)s_f01_inp_addr_address_score_d < 85 => 0.1631776269,
	    (Integer)s_f01_inp_addr_address_score_d >= 85                                                   => 0.0525909755,
	                                                                                                       0.0039596209);
	
	final_score_tree_64_c514 := map(
	    NULL < (integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5 => 0.1040130113,
	    (Real)s_nap_lname_verd_d >= 0.5                              => -0.0789365628,
	                                                              0.0313712686);
	
	final_score_tree_64_c513 := map(
	    NULL < (integer)b_add_input_mobility_index_i AND (Real)b_add_input_mobility_index_i < 0.3748215369 => final_score_tree_64_c514,
	    b_add_input_mobility_index_i >= 0.3748215369                                        => -0.0758869485,
	                                                                                           -0.0025848504);
	
	final_score_tree_64_c511 := map(
	    NULL < (integer)s_curraddrmedianincome_d AND (Integer)s_curraddrmedianincome_d < 30973 => final_score_tree_64_c512,
	    (Integer)s_curraddrmedianincome_d >= 30973                                    => -0.0052163716,
	                                                                            final_score_tree_64_c513);
	
	final_score_tree_64 := map(
	    ST_cen_mil_emp = ''                                               =>  0.0225591913,
	    NULL < (integer)ST_cen_mil_emp AND (Real)ST_cen_mil_emp < 0.05    => final_score_tree_64_c511,
	    (Real)ST_cen_mil_emp >= 0.05                                      => -0.0411099806,
	                                                                          0.0225591913);
	
	final_score_tree_65_c519 := map(
	    NULL < (integer)s_rel_incomeover75_count_d AND (Real)s_rel_incomeover75_count_d < 3.5 => 0.1906281427,
	    (Real)s_rel_incomeover75_count_d >= 3.5                                      => 0.0242371356,
	                                                                              0.0790160680);
	
	final_score_tree_65_c518 := map(
	    NULL < (integer)s_c20_email_count_i AND (Real)s_c20_email_count_i < 1.5 => 0.0132067027,
	    (Real)s_c20_email_count_i >= 1.5                               => final_score_tree_65_c519,
	                                                                0.0255428117);
	
	final_score_tree_65_c517 := map(
	    NULL < (integer)s_c20_email_verification_d AND (Real)s_c20_email_verification_d < 0.5 => final_score_tree_65_c518,
	    (Real)s_c20_email_verification_d >= 0.5                                      => -0.0315459347,
	                                                                              -0.0102858581);
	
	final_score_tree_65_c516 := map(
	    NULL < (integer)b_curraddrmedianincome_d AND (Integer)b_curraddrmedianincome_d < 67046 => -0.0133489112,
	    (Integer)b_curraddrmedianincome_d >= 67046                                    => final_score_tree_65_c517,
	                                                                            -0.0116613514);
	
	final_score_tree_65 := map(
	    NULL < (integer)b_i60_inq_retpymt_recency_d AND (Real)b_i60_inq_retpymt_recency_d < 4.5 => 0.1611952463,
	    b_i60_inq_retpymt_recency_d >= 4.5                                       => final_score_tree_65_c516,
	                                                                                0.0030499592);
	
  /*  TREE 66   */	
	final_score_tree_66_c524 := map(
	    NULL < (integer)b_add_input_nhood_mfd_pct_i AND (Real)b_add_input_nhood_mfd_pct_i < 0.21826912245  => 0.0055983753,
	    b_add_input_nhood_mfd_pct_i >= 0.21826912245                                                       => 0.1349437769,
	                                                                                                          0.0941591908);
	final_score_tree_66_c523 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 906.5  => -0.0124908735,
	    btst_dist_inp_addr_to_ip_addr_i >= 906.5                                                           => final_score_tree_66_c524,
	                                                                                                           0.0337435806);
	final_score_tree_66_c522 := map(
	    NULL < (integer)b_add_curr_nhood_vac_pct_i AND (Real)b_add_curr_nhood_vac_pct_i < 0.1188100197     => final_score_tree_66_c523,
	    b_add_curr_nhood_vac_pct_i >= 0.1188100197                                                         => 0.2286809634,
	                                                                                                          0.0563450163);
	final_score_tree_66_c521 := map(
	    ST_cen_urban_p = ''                                                                                => 0.0320435516,
	    NULL < (integer)ST_cen_urban_p AND (Real)ST_cen_urban_p < 99.95                                    => -0.0403957427,
	    (Real)ST_cen_urban_p >= 99.95                                                                      => final_score_tree_66_c522,
	                                                                                                          0.0320435516);
	final_score_tree_66 := map(
	    NULL < (integer)s_curraddrmedianincome_d AND (Real)s_curraddrmedianincome_d < 39571.5              => final_score_tree_66_c521,
	    (Real)s_curraddrmedianincome_d >= 39571.5                                                          => -0.0055881080,
	                                                                                                           0.0123346576);
	
	/*  TREE 67   */	
	final_score_tree_67_c528 := map(
	    (ip_connection_n in ['BROADBAND', 'XDSL'])                                                    => -0.0058770847,
	    (ip_connection_n in ['-1', 'CABLE', 'DIALUP', 'MOBILE', 'SATELLITE', 'T1', 'T3', 'WIRELESS']) => 0.0956128553,
	                                                                                                     0.0330115839);
	
	final_score_tree_67_c527 := map(
	    NULL < (integer)b_a44_curr_add_naprop_d AND (Real)b_a44_curr_add_naprop_d < 0.5 => -0.0277430740,
	    b_a44_curr_add_naprop_d >= 0.5                                   => 0.1835005103,
	                                                                        final_score_tree_67_c528);
	
	final_score_tree_67_c526 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'NET', 'ORG']) => 0.0120833872,
	    (ip_topleveldomain_lvl_n in ['-1', 'TWO', 'US'])                        => final_score_tree_67_c527,
	                                                                               0.0186933824);
	
	final_score_tree_67_c529 := map(
	    NULL < (integer)s_liens_rel_cj_total_amt_i AND s_liens_rel_cj_total_amt_i < 2539 => -0.0089293907,
	    (Integer)s_liens_rel_cj_total_amt_i >= 2539                                      => 0.1793739460,
	                                                                               -0.0392546461);
	
	final_score_tree_67 := map(
	    NULL < (integer)s_add_input_nhood_sfd_pct_d AND (Real)s_add_input_nhood_sfd_pct_d < 0.4722946356 => final_score_tree_67_c526,
	    (Real)s_add_input_nhood_sfd_pct_d >= 0.4722946356                                       => final_score_tree_67_c529,
	                                                                                         -0.0006084584);
	
	final_score_tree_68_c534 := map(
	    NULL < (integer)b_add_input_nhood_bus_pct_i AND (Real)b_add_input_nhood_bus_pct_i < 0.08737226065 => 0.1143483702,
	    b_add_input_nhood_bus_pct_i >= 0.08737226065                                       => -0.0154122336,
	                                                                                          0.0746695079);
	
	final_score_tree_68_c533 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5 => final_score_tree_68_c534,
	    (Real)btst_email_last_score_d >= 0.5                                   => 0.0498591397,
	                                                                        0.0606761168);
	
	final_score_tree_68_c532 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 683.5 => -0.0093905811,
	    btst_dist_inp_addr_to_ip_addr_i >= 683.5                                           => final_score_tree_68_c533,
	                                                                                          0.0387642406);
	
	final_score_tree_68_c531 := map(
	    (ip_connection_n in ['-1', 'BROADBAND', 'DIALUP', 'MOBILE', 'SATELLITE', 'T3', 'XDSL']) => -0.0111894637,
	    (ip_connection_n in ['CABLE', 'T1', 'WIRELESS'])                                        => final_score_tree_68_c532,
	                                                                                               -0.0034070188);
	
	final_score_tree_68 := map(
	    ip_routingmethod_n = ''                                                                 => -0.0028077581,
	    NULL < (Integer) ip_routingmethod_n AND (Integer)ip_routingmethod_n < 4                 =>  0.0806392820,
	    (Integer)ip_routingmethod_n >= 4                                                        => final_score_tree_68_c531,
	                                                                                               -0.0028077581);
	
	final_score_tree_69_c538 := map(
	    BT_cen_high_hval = ''                                                                 =>  0.0168598050,
	    NULL < (integer)BT_cen_high_hval AND (Real)bT_cen_high_hval < 1.85                    =>  0.0951923828,
	    (Real)BT_cen_high_hval >= 1.85                                                        => -0.0219334716,
	                                                                                              0.0168598050);
	
	final_score_tree_69_c537 := map(
	    ST_cen_very_rich = ''                                                                 => -0.0109715843, 
	    NULL < (integer)ST_cen_very_rich AND (Real)ST_cen_very_rich < 83.5                    => -0.0950719463,
	    (Real)ST_cen_very_rich >= 83.5                                                        => final_score_tree_69_c538,
	                                                                                             -0.0109715843);
	
	final_score_tree_69_c536 := map(
	    NULL < (integer)b_rel_bankrupt_count_i AND (Real)b_rel_bankrupt_count_i < 4.5 => -0.0032288603,
	    b_rel_bankrupt_count_i >= 4.5                                  => -0.0727012052,
	                                                                      final_score_tree_69_c537);
	
	final_score_tree_69_c539 := map(
	    NULL < (integer)b_add_curr_nhood_vac_pct_i AND (Real)b_add_curr_nhood_vac_pct_i < 0.0120724468 => -0.0941689496,
	    b_add_curr_nhood_vac_pct_i >= 0.0120724468                                      => 0.1315394227,
	                                                                                       0.0424061802);
	
	final_score_tree_69 := map(
	    NULL < (integer)s_l79_adls_per_addr_c6_i AND (Real)s_l79_adls_per_addr_c6_i < 5.5 => final_score_tree_69_c536,
	    (Real)s_l79_adls_per_addr_c6_i >= 5.5                                    => final_score_tree_69_c539,
	                                                                          -0.0068625966);
	
	final_score_tree_70_c541 := map(
	    BT_cen_no_move = ''                                                        =>  0.0554670542,
	    NULL < (integer)BT_cen_no_move AND (Real)bT_cen_no_move < 56.5             =>  0.1483405564,
	    (Real)BT_cen_no_move >= 56.5                                               => -0.0266902746,
	                                                                                   0.0554670542);
	
	final_score_tree_70_c544 := map(
	    NULL < (integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 2963  =>  0.0485289403,
	    (Integer)btst_dist_inp_addr_to_ip_addr_i >= 2963                                                     => -0.0633070711,
	                                                                                                             0.0057681124);
	
	final_score_tree_70_c543 := map(
	    BT_cen_vacant_p = ''                                                       => -0.0046097347,
	    NULL < (integer)BT_cen_vacant_p AND (Real)bT_cen_vacant_p < 11.65          =>  final_score_tree_70_c544,
	    (Real)BT_cen_vacant_p >= 11.65                                             =>  0.1052935044,
	                                                                                  -0.0046097347);
	
	final_score_tree_70_c542 := map(
	    NULL < (integer)b_curraddrcartheftindex_i AND (Integer)b_curraddrcartheftindex_i < 153 => -0.0285762388,
	    (Integer)b_curraddrcartheftindex_i >= 153                                     => 0.0808608655,
	                                                                            final_score_tree_70_c543);
	
	final_score_tree_70 := map(
	    NULL < (integer)b_addrchangecrimediff_i AND (Real)b_addrchangecrimediff_i < 21.5 => -0.0004593635,
	    b_addrchangecrimediff_i >= 21.5                                   => final_score_tree_70_c541,
	                                                                         final_score_tree_70_c542);
	
	final_score_tree_71_c549 := map(
	    ST_cen_pop_0_5_p = ''                                                =>  0.0293777928,
	    NULL < (integer)ST_cen_pop_0_5_p AND (Real)ST_cen_pop_0_5_p < 4.45   => -0.0758776717,
	    (Real)ST_cen_pop_0_5_p >= 4.45                                       =>  0.0520110138,
	                                                                             0.0293777928);
	
	final_score_tree_71_c548 := map(
	    ST_cen_families = ''                                                 => 0.0444066320,
	    NULL < (integer)ST_cen_families AND (Integer)ST_cen_families < 245   => 0.1676007787,
	    (Integer)ST_cen_families >= 245                                      => final_score_tree_71_c549,
	                                                                            0.0444066320);
	
	final_score_tree_71_c547 := map(
	    NULL < (integer)s_c20_email_verification_d AND (Real)s_c20_email_verification_d < 0.5 => final_score_tree_71_c548,
	    (Real)s_c20_email_verification_d >= 0.5                                      => -0.0326440656,
	                                                                              -0.0040076936);
	
	final_score_tree_71_c546 := map(
	    NULL < (integer)b_add_input_mobility_index_i AND (Real)b_add_input_mobility_index_i < 0.1978102799 => final_score_tree_71_c547,
	    b_add_input_mobility_index_i >= 0.1978102799                                        => -0.0149762145,
	                                                                                           -0.0120095133);
	
	final_score_tree_71 := map(
	    ST_cen_easiqlife = ''                                                 => 0.0025075283,
	    NULL < (integer)ST_cen_easiqlife AND (Real)ST_cen_easiqlife < 49.5    => 0.1901884135,
	    (Real)ST_cen_easiqlife >= 49.5                                        => final_score_tree_71_c546,
	                                                                             0.0025075283);
	
	final_score_tree_72_c553 := map(
	    ST_cen_families = ''                                                  =>  0.0132282101, 
	    NULL < (integer)ST_cen_families AND (Real)ST_cen_families < 320.5     => -0.0504237320,
	    (Real)ST_cen_families >= 320.5                                        =>  0.0585190151,
	                                                                              0.0132282101);
	
	final_score_tree_72_c552 := map(
	    NULL < (integer)s_varrisktype_i AND (Real)s_varrisktype_i < 5.5       => -0.0076857185,
	    (Real)s_varrisktype_i >= 5.5                                          =>  0.1266120114,
	                                                                              final_score_tree_72_c553);
	
	final_score_tree_72_c551 := map(
	    NULL < (integer)b_add_input_mobility_index_i AND (Real)b_add_input_mobility_index_i < 0.82495523395 => final_score_tree_72_c552,
	    b_add_input_mobility_index_i >= 0.82495523395                                        => -0.1020623279,
	                                                                                            -0.0061216004);
	
	final_score_tree_72_c554 := map(
	    (ip_dma_lvl_n in ['2. DMA: -1', '3. DMA: 0', '5. DMA: Unkown']) => -0.0225877934,
	    (ip_dma_lvl_n in ['1. Missing DMA', '4. DMA: US Code'])         =>  0.0522761520,
	                                                                       -0.0082039491);
	
	final_score_tree_72 := map(
	    ST_cen_easiqlife = ''                                               => final_score_tree_72_c554,          
	    NULL <  (Integer)ST_cen_easiqlife AND (Real)ST_cen_easiqlife < 49.5 => 0.1224178731,
	    (Real)ST_cen_easiqlife >= 49.5                                      => final_score_tree_72_c551,
	                                                                           final_score_tree_72_c554);
	
	final_score_tree_73_c559 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 472.5 => 0.0061582887,
	    btst_dist_inp_addr_to_ip_addr_i >= 472.5                                           => 0.0514653846,
	                                                                                          0.0288295902);
	
	final_score_tree_73_c558 := map(
	    ST_cen_blue_col = ''                                                     =>  0.0148191170,
	    NULL <  (Integer)ST_cen_blue_col AND (Real)ST_cen_blue_col < 17.55       => final_score_tree_73_c559,
	    (Real)ST_cen_blue_col >= 17.55                                           => -0.0358448180,
	                                                                                 0.0148191170);
	
	final_score_tree_73_c557 := map(
	    BT_cen_totcrime = ''                                                     =>  0.0023787224,
	    NULL <  (Integer)BT_cen_totcrime AND (Real)bT_cen_totcrime < 50.5        => -0.0230080905,
	    (Real)BT_cen_totcrime >= 50.5                                            => final_score_tree_73_c558,
	                                                                                 0.0023787224);
	
	final_score_tree_73_c556 := map(
	    NULL <  (Integer)b_add_input_nhood_mfd_pct_i AND (Real)b_add_input_nhood_mfd_pct_i < 0.97857482545 => final_score_tree_73_c557,
	    b_add_input_nhood_mfd_pct_i >= 0.97857482545                                       => 0.1317444130,
	                                                                                          -0.0102006629);
	
	final_score_tree_73 := map(
	    NULL <  (Integer)s_add_input_nhood_vac_pct_i AND (Real)s_add_input_nhood_vac_pct_i < 0.201641843 => final_score_tree_73_c556,
	    (Real)s_add_input_nhood_vac_pct_i >= 0.201641843                                       => -0.0407922607,
	                                                                                        -0.0028671116);
  /*  *************************TREE 74 ******************************************* */  
	final_score_tree_74_c563 := map(
	    BT_cen_very_rich = ''                                                 =>  0.0437903391,
	    NULL <  (Integer)BT_cen_very_rich AND (Real)bT_cen_very_rich < 125.5  =>  0.0986770839,
	    (Real)BT_cen_very_rich >= 125.5                                       => -0.0229885338,
	                                                                              0.0437903391);
	
	final_score_tree_74_c562 := map(
	    NULL <  (Integer)s_l79_adls_per_addr_c6_i AND (Real)s_l79_adls_per_addr_c6_i < 0.5 => final_score_tree_74_c563,
	    (Real)s_l79_adls_per_addr_c6_i >= 0.5                                    => -0.0707219204,
	                                                                                 0.0036296415);
	
	final_score_tree_74_c564 := map(
	    (ip_dma_lvl_n in ['3. DMA: 0', '5. DMA: Unkown'])                     => -0.0245920569,
	    (ip_dma_lvl_n in ['1. Missing DMA', '2. DMA: -1', '4. DMA: US Code']) =>  0.0467605594,
	                                                                             -0.0116601042);
	
	final_score_tree_74_c561 := map(
	    ST_cen_blue_col = ''                                                 => final_score_tree_74_c564,
	    NULL <  (Integer)ST_cen_blue_col AND (Real)ST_cen_blue_col < 15.95   => final_score_tree_74_c562,
	    (Real)ST_cen_blue_col >= 15.95                                       => -0.0998589834,
	                                                                            final_score_tree_74_c564);
	
	final_score_tree_74 := map(
	    NULL <  (Integer)s_acc_damage_amt_total_i AND (Integer)s_acc_damage_amt_total_i < 2400 => -0.0038829826,
	    (Integer)s_acc_damage_amt_total_i >= 2400                                    => 0.1467440621,
	                                                                           final_score_tree_74_c561);
	
	final_score_tree_75_c568 := map(
	    NULL <  (Integer)s_l79_adls_per_addr_curr_i AND (Real)s_l79_adls_per_addr_curr_i < 1.5 => 0.0885515640,
	    (Real)s_l79_adls_per_addr_curr_i >= 1.5                                      => 0.0200543397,
	                                                                              0.0340972810);
	
	final_score_tree_75_c567 := map(
	    NULL <  (Integer)b_curraddrmedianvalue_d AND (Real)b_curraddrmedianvalue_d < 188008.5 => final_score_tree_75_c568,
	    (Real)b_curraddrmedianvalue_d >= 188008.5                                   => -0.0054764977,
	                                                                             0.0128253715);
	
	final_score_tree_75_c566 := map(
	    NULL <  (Integer)ip_state_match_d AND (Real)ip_state_match_d < 0.5 => final_score_tree_75_c567,
	    (Real)ip_state_match_d >= 0.5                            => -0.0202527940,
	                                                          -0.0125279529);
	
	final_score_tree_75_c569 := map(
	    BT_cen_incollege = ''                                                   => 0.0076399156,
	    NULL <  (Integer)BT_cen_incollege AND (Real)bT_cen_incollege < 5.35     => 0.0760520910,
	    (Real)BT_cen_incollege >= 5.35                                          => -0.0438884511,
	                                                                               0.0076399156);
	
	final_score_tree_75 := map(
	    NULL <  (Integer)b_prevaddrageoldest_d AND (Real)b_prevaddrageoldest_d < 449.5 => final_score_tree_75_c566,
	    (Real)b_prevaddrageoldest_d >= 449.5                                 => 0.1756265854,
	                                                                      final_score_tree_75_c569);
	
	final_score_tree_76_c573 := map(
	    NULL <  (Integer)b_l80_inp_avm_autoval_d AND (Integer)b_l80_inp_avm_autoval_d < 193475 => -0.0131558215,
	    (Integer)b_l80_inp_avm_autoval_d >= 193475                                   => 0.0615621909,
	                                                                           0.0066954537);
	
	final_score_tree_76_c572 := map(
	    BT_cen_easiqlife  = ''                                                    => 0.0279766197, 
	    NULL <  (Integer)BT_cen_easiqlife AND (Real)bT_cen_easiqlife < 52.5       => 0.1635396315,
	    (Real)BT_cen_easiqlife >= 52.5                                            => final_score_tree_76_c573,
	                                                                                 0.0279766197);
	
	final_score_tree_76_c574 := map(
	    (ip_dma_lvl_n in ['5. DMA: Unkown'])                                               => -0.0010628450,
	    (ip_dma_lvl_n in ['1. Missing DMA', '2. DMA: -1', '3. DMA: 0', '4. DMA: US Code']) => 0.0689561208,
	                                                                                          0.0164418964);
	
	final_score_tree_76_c571 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 301.5 => -0.0198088162,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 301.5                                           => final_score_tree_76_c572,
	                                                                                          final_score_tree_76_c574);
	
	final_score_tree_76 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'EDU', 'GOV', 'ORG', 'US']) => -0.0175240429,
	    (ip_topleveldomain_lvl_n in ['-1', 'DOT', 'NET', 'TWO'])        => final_score_tree_76_c571,
	                                                                       -0.0006828232);
																																				 
	/*  *************************TREE 77 ******************************************* */  
	final_score_tree_77_c576 := map(
	    NULL <  (Integer)b_curraddrmedianincome_d AND (Integer)b_curraddrmedianincome_d < 38530 => 0.1586977943,
	    (Integer)b_curraddrmedianincome_d >= 38530                                              => 0.0113847537,
	                                                                                               0.0389277018);
	
	final_score_tree_77_c579 := map(
	    NULL <  (Integer)b_nap_lname_verd_d AND (Real)b_nap_lname_verd_d < 0.5 => 0.1280568915,
	    (Real)b_nap_lname_verd_d >= 0.5                              => -0.0126801637,
	                                                              0.0610932926);
	
	final_score_tree_77_c578 := map(
	    BT_cen_incollege = ''                                               =>  0.0282140364,
	    NULL <  (Integer)BT_cen_incollege AND (Real)bT_cen_incollege < 7.55 => final_score_tree_77_c579,
	    (Real)BT_cen_incollege >= 7.55                                      => -0.0240555504,
	                                                                            0.0282140364);
	
	final_score_tree_77_c577 := map(
	    ST_cen_blue_col = ''                                               =>  0.0096294597,
	    NULL <  (Integer)ST_cen_blue_col AND (Real)ST_cen_blue_col < 15.95 => final_score_tree_77_c578,
	    (Real)ST_cen_blue_col >= 15.95                                     => -0.0883536713,
	                                                                           0.0096294597);
	
	final_score_tree_77 := map(
	    NULL <  (Integer)s_i60_inq_comm_recency_d AND (Integer)s_i60_inq_comm_recency_d < 549 => final_score_tree_77_c576,
	    (Integer)s_i60_inq_comm_recency_d >= 549                                    => -0.0174379987,
	                                                                          final_score_tree_77_c577);
	
	/*  *************************TREE 78 ******************************************* */  
	final_score_tree_78_c581 := map(
	    NULL <  (Integer)b_add_input_nhood_sfd_pct_d AND (Real)b_add_input_nhood_sfd_pct_d < 0.36735300545 => -0.0838535253,
	    (Real)b_add_input_nhood_sfd_pct_d >= 0.36735300545                                                 =>  0.0002728113,
	                                                                                                          -0.0382951367);
	
	final_score_tree_78_c584 := map(
	    NULL <  (Integer)b_inq_count24_i AND (Real)b_inq_count24_i < 8.5      => 0.0335493851,
	    (Real)b_inq_count24_i >= 8.5                                          => 0.2183418326,
	                                                                             0.0222572959);
	
	final_score_tree_78_c583 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 1.5 => final_score_tree_78_c584,
	    (Real)btst_email_first_score_d >= 1.5                                             => -0.0566610845,
	                                                                                          0.0186010605);
	
	final_score_tree_78_c582 := map(
	    ST_cen_vacant_p = ''                                              =>  0.0155108036,
	    NULL <  (Integer)ST_cen_vacant_p AND (Real)ST_cen_vacant_p < 7.55 => -0.0129004992,
	    (Real)ST_cen_vacant_p >= 7.55                                     => final_score_tree_78_c583,
	                                                                          0.0155108036);
	
	final_score_tree_78 := map(
	    (btst_email_topleveldomain_n in ['BIZ', 'EDU', 'MIL', 'ORG', 'OTH']) => final_score_tree_78_c581,
	    (btst_email_topleveldomain_n in ['COM', 'GOV', 'NET', 'US'])         => final_score_tree_78_c582,
	                                                                            -0.0017879950);

  /*  *************************TREE 79 ******************************************* */  	
	final_score_tree_79_c589 := map(
	    NULL <  (Integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => 0.1365340446,
	    (Real)b_adl_per_email_i >= 0.5                             => 0.0520590286,
	                                                            0.1026830454);
	
	final_score_tree_79_c588 := map(
	    ST_cen_easiqlife = ''                                                => 0.0654052047,
	    NULL <  (Integer)ST_cen_easiqlife AND (Real)ST_cen_easiqlife < 144.5 => final_score_tree_79_c589,
	    (Real)ST_cen_easiqlife >= 144.5                                      => -0.0007868586,
	                                                                             0.0654052047);
	
	final_score_tree_79_c587 := map(
	    NULL <  (Integer)b_c21_m_bureau_adl_fs_d AND (Real)b_c21_m_bureau_adl_fs_d < 56.5 => -0.0590612855,
	    (Real)b_c21_m_bureau_adl_fs_d >= 56.5                                             => final_score_tree_79_c588,
	                                                                                          0.0477989428);
	
	final_score_tree_79_c586 := map(
	    NULL <  (Integer)s_d32_mos_since_crim_ls_d AND (Real)s_d32_mos_since_crim_ls_d < 98.5 => -0.0926549411,
	    (Real)s_d32_mos_since_crim_ls_d >= 98.5                                               => final_score_tree_79_c587,
	                                                                                              0.0180524096);
	
	final_score_tree_79 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'EDU', 'GOV', 'NET', 'ORG', 'US']) => 0.0002862029,
	    (ip_topleveldomain_lvl_n in ['-1', 'DOT', 'TWO'])                      => final_score_tree_79_c586,
	                                                                              0.0033458755);
																																								
																																								
	/*  *************************TREE 80 ******************************************* */  	
	final_score_tree_80_c591 := map(
	    NULL <  (Integer)s_f01_inp_addr_address_score_d AND (Integer)s_f01_inp_addr_address_score_d < 95 => 0.0796829613,
	    (Integer)s_f01_inp_addr_address_score_d >= 95                                                    => 0.0573953355,
	                                                                                                        0.0641069501);
	
	final_score_tree_80_c593 := map(
	    ST_cen_high_hval = ''                                                 => 0.0493032247,
	    NULL <  (Integer)ST_cen_high_hval AND (Real)ST_cen_high_hval < 34.95  => 0.0156035274,
	    (Real)ST_cen_high_hval >= 34.95                                       => 0.1340554484,
	                                                                             0.0493032247);
	
	final_score_tree_80_c592 := map(
	    NULL <  (Integer)b_inq_email_ver_count_i AND (Real)b_inq_email_ver_count_i < 0.5 => final_score_tree_80_c593,
	    b_inq_email_ver_count_i >= 0.5                                   => -0.0121405818,
	                                                                        -0.0027749903);
	
	final_score_tree_80_c594 := map(
	    BT_cen_totcrime = ''                                               => -0.0010972744,
	    NULL <  (Integer)BT_cen_totcrime AND (Integer)BT_cen_totcrime < 39 => -0.0821378652,
	    (Integer)BT_cen_totcrime >= 39                                     =>  0.0240373785,
	                                                                          -0.0010972744);
	
	final_score_tree_80 := map(
	    NULL <  (Integer)b_i60_inq_prepaidcards_recency_d AND (Integer)b_i60_inq_prepaidcards_recency_d < 549 => final_score_tree_80_c591,
	    (Integer)b_i60_inq_prepaidcards_recency_d >= 549                                                      => final_score_tree_80_c592,
	                                                                                                             final_score_tree_80_c594);

/*  *************************TREE 81 ******************************************* */	
	final_score_tree_81_c599 := map(
	    NULL <  (Integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5 => 0.0878595880,
	    (Real)s_nap_lname_verd_d >= 0.5                              => -0.0100689513,
	                                                              0.0432995120);
	
	final_score_tree_81_c598 := map(
	    BT_cen_urban_p = ''                                              =>  0.0212518364,
	    NULL <  (Integer)BT_cen_urban_p AND (Real)bT_cen_urban_p < 83.1  => -0.0573710067,
	    (Real)BT_cen_urban_p >= 83.1                                     => final_score_tree_81_c599,
	                                                                         0.0212518364);
	
	final_score_tree_81_c597 := map(
	    NULL <  (Integer)b_add_curr_nhood_bus_pct_i AND (Real)b_add_curr_nhood_bus_pct_i < 0.0523283428 => -0.0508913060,
	    (Real)b_add_curr_nhood_bus_pct_i >= 0.0523283428                                                => 0.0606390009,
	                                                                                                       final_score_tree_81_c598);
	
	final_score_tree_81_c596 := map(
	    ST_cen_blue_col = ''                                                    => -0.0095707263,
	    NULL <  (Integer)ST_cen_blue_col AND (Real)ST_cen_blue_col < 6.55       => -0.0560323774,
	    (Real)ST_cen_blue_col >= 6.55                                           => final_score_tree_81_c597,
	                                                                               -0.0095707263);
	
	final_score_tree_81 := map(
	    NULL <  (Integer)b_addrchangevaluediff_d AND (Real)b_addrchangevaluediff_d < 138443.5 => 0.0027779023,
	    (Real)b_addrchangevaluediff_d >= 138443.5                                   => 0.0700820645,
	                                                                             final_score_tree_81_c596);
	
	final_score_tree_82_c601 := map(
	    NULL <  (Integer)b_addrchangeincomediff_d AND (Integer)b_addrchangeincomediff_d < -23216 => 0.0766566207,
	    (Integer)b_addrchangeincomediff_d >= -23216                                    => -0.0038304174,
	                                                                             0.0051827128);
	
	final_score_tree_82_c604 := map(
	    NULL <  (Integer)s_prevaddrmedianincome_d AND (Integer)s_prevaddrmedianincome_d < 48780 => -0.1526560634,
	    (Integer)s_prevaddrmedianincome_d >= 48780                                    => -0.0406292152,
	                                                                            -0.0890044451);
	
	final_score_tree_82_c603 := map(
	    NULL <  (Integer)b_c14_addr_stability_v2_d AND (Real)b_c14_addr_stability_v2_d < 3.5 => -0.0203252111,
	    b_c14_addr_stability_v2_d >= 3.5                                     => final_score_tree_82_c604,
	                                                                            -0.0626040710);
	
	final_score_tree_82_c602 := map(
	    NULL <  (Integer)b_add_curr_nhood_sfd_pct_d AND (Real)b_add_curr_nhood_sfd_pct_d < 0.75917090225 => final_score_tree_82_c603,
	    b_add_curr_nhood_sfd_pct_d >= 0.75917090225                                      => 0.0060095021,
	                                                                                        -0.0505387208);
	
	final_score_tree_82 := map(
	    NULL <  (Integer)s_add_input_nhood_vac_pct_i AND (Real)s_add_input_nhood_vac_pct_i < 0.08080234075 => final_score_tree_82_c601,
	    (Real)s_add_input_nhood_vac_pct_i >= 0.08080234075                                       => final_score_tree_82_c602,
	                                                                                          -0.0033498873);
	


  /*  *************************TREE 83 ******************************************* */	
	final_score_tree_83_c606 := map(
	    NULL <  (Integer)b_addrchangecrimediff_i AND (Real)b_addrchangecrimediff_i < -65.5 => -0.1007573738,
	    b_addrchangecrimediff_i >= -65.5                                   => 0.0058705721,
	                                                                          -0.0090888384);
	
	final_score_tree_83_c607 := map(
	    NULL <  (Integer)s_a44_curr_add_naprop_d AND (Real)s_a44_curr_add_naprop_d < 0.5 => -0.1402078783,
	    (Real)s_a44_curr_add_naprop_d >= 0.5                                   => -0.0302214226,
	                                                                        -0.0580533611);
	
	final_score_tree_83_c609 := map(
	    NULL <  (Integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5 => 0.0688323340,
	    (Real)s_nap_lname_verd_d >= 0.5                              => -0.0844800739,
	                                                              0.0128143388);
	
	final_score_tree_83_c608 := map(
	    ST_cen_span_lang = ''                                                =>  0.0045679320,
	    NULL <  (Integer)ST_cen_span_lang AND (Real)ST_cen_span_lang < 126.5 => final_score_tree_83_c609,
	    (Real)ST_cen_span_lang >= 126.5                                      => -0.0663336343,
	                                                                             0.0045679320);
	
	final_score_tree_83 := map(
	    NULL <  (Integer)s_validationrisktype_i AND (Real)s_validationrisktype_i < 1.5 => final_score_tree_83_c606,
	    (Real)s_validationrisktype_i >= 1.5                                  => final_score_tree_83_c607,
	                                                                      final_score_tree_83_c608);
	
	final_score_tree_84_c613 := map(
	    NULL <  (Integer)s_c13_max_lres_d AND (Real)s_c13_max_lres_d < 107.5 => 0.0880249261,
	    (Real)s_c13_max_lres_d >= 107.5                            => -0.0767561032,
	                                                            -0.0102819380);
	
	final_score_tree_84_c612 := map(
	    NULL <  (Integer)b_prevaddrcartheftindex_i AND (Integer)b_prevaddrcartheftindex_i < 147 => final_score_tree_84_c613,
	    b_prevaddrcartheftindex_i >= 147                                     => 0.1559137569,
	                                                                            0.0355415664);
	
	final_score_tree_84_c614 := map(
	    BT_cen_retired2 = ''                                                     => -0.0013279043,
	    NULL <  (Integer)BT_cen_retired2 AND (Real)bT_cen_retired2 < 173.5       => -0.0079614563,
	    (Real)BT_cen_retired2 >= 173.5                                           =>  0.1449929451,
	                                                                                -0.0013279043);
	
	final_score_tree_84_c611 := map(
	    NULL <  (Integer)s_addrchangevaluediff_d AND s_addrchangevaluediff_d < 7385 => -0.0039586945,
	    s_addrchangevaluediff_d >= 7385                                   => final_score_tree_84_c612,
	                                                                         final_score_tree_84_c614);
	
	final_score_tree_84 := map(
	    NULL <  (Integer)s_add_input_mobility_index_i AND (Real)s_add_input_mobility_index_i < 0.76489763915 => final_score_tree_84_c611,
	    (Real)s_add_input_mobility_index_i >= 0.76489763915                                        => -0.0938358673,
	                                                                                            0.0087359517);
	
	
	/*  *************************TREE 85 ******************************************* */	
	final_score_tree_85_c619 := map(
	    NULL <  (Integer)b_c21_m_bureau_adl_fs_d AND (Real)b_c21_m_bureau_adl_fs_d < 241.5 => -0.0246747874,
	    b_c21_m_bureau_adl_fs_d >= 241.5                                   => 0.1077400314,
	                                                                          0.0274368509);
	
	final_score_tree_85_c618 := map(
	    NULL <  (Integer)s_d30_derog_count_i AND (Real)s_d30_derog_count_i < 1.5 => final_score_tree_85_c619,
	    (Real)s_d30_derog_count_i >= 1.5                               => -0.0549600290,
	                                                                0.0077705210);
	
	final_score_tree_85_c617 := map(
	    BT_cen_totcrime = ''                                                => 0.0157945282,
	    NULL <  (Integer)BT_cen_totcrime AND (Integer)BT_cen_totcrime < 182 => final_score_tree_85_c618,
	    (Integer)BT_cen_totcrime >= 182                                     => 0.1239275785,
	                                                                           0.0157945282);
	
	final_score_tree_85_c616 := map(
	    NULL <  (Integer)s_add_input_nhood_mfd_pct_i AND (Real)s_add_input_nhood_mfd_pct_i < 0.89299594955 => final_score_tree_85_c617,
	    (Real)s_add_input_nhood_mfd_pct_i >= 0.89299594955                                       => 0.1428279961,
	                                                                                          0.0212878351);
	
	final_score_tree_85 := map(
	    NULL <  (Integer)s_l79_adls_per_addr_c6_i AND (Real)s_l79_adls_per_addr_c6_i < 1.5 => -0.0073160331,
	    (Real)s_l79_adls_per_addr_c6_i >= 1.5                                    => final_score_tree_85_c616,
	                                                                          -0.0022234647);
	
	final_score_tree_86_c622 := map(
	    NULL <  (Integer)s_curraddrcartheftindex_i AND s_curraddrcartheftindex_i < 82 => -0.0262854077,
	    s_curraddrcartheftindex_i >= 82                                     => 0.1974982739,
	                                                                           0.0816386373);
	
	final_score_tree_86_c621 := map(
	    NULL <  (Integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5 => final_score_tree_86_c622,
	    (Real)s_nap_lname_verd_d >= 0.5                              => 0.0168354449,
	                                                              0.0212622285);
	
	final_score_tree_86_c624 := map(
	    NULL <  (Integer)b_f01_inp_addr_address_score_d AND (Integer)b_f01_inp_addr_address_score_d < 95 => 0.0694350809,
	    b_f01_inp_addr_address_score_d >= 95                                          => 0.0416406445,
	                                                                                     0.0550120220);
	
	final_score_tree_86_c623 := map(
	    NULL <  (Integer)b_a49_curr_avm_chg_1yr_i AND (Integer)b_a49_curr_avm_chg_1yr_i < 18470 => final_score_tree_86_c624,
	    b_a49_curr_avm_chg_1yr_i >= 18470                                    => -0.0509227077,
	                                                                            -0.0101945654);
	
	final_score_tree_86 := map(
	    NULL <  (Integer)s_l80_inp_avm_autoval_d AND (Real)s_l80_inp_avm_autoval_d < 207818.5 => -0.0153986566,
	    (Real)s_l80_inp_avm_autoval_d >= 207818.5                                   => final_score_tree_86_c621,
	                                                                             final_score_tree_86_c623);
  
	/*  *************************TREE 87 ******************************************* */
	final_score_tree_87_c627 := map(
	    NULL <  (Integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 2.5 => -0.1113520024,
	    b_c20_email_verification_d >= 2.5                                      => 0.1221956949,
	                                                                              -0.0355248279);
	
	final_score_tree_87_c628 := map(
	    NULL <  (Integer)b_divaddrsuspidcountnew_i AND (Real)b_divaddrsuspidcountnew_i < 0.5 => 0.0015236597,
	    b_divaddrsuspidcountnew_i >= 0.5                                     => 0.0996440546,
	                                                                            0.0215506485);
	
	final_score_tree_87_c626 := map(
	    NULL <  (Integer)s_addrchangeincomediff_d AND (Real)s_addrchangeincomediff_d < -4125.5 => final_score_tree_87_c627,
	    (Real)s_addrchangeincomediff_d >= -4125.5                                    => 0.0093178789,
	                                                                              final_score_tree_87_c628);
	
	final_score_tree_87_c629 := map(
	    BT_cen_med_hval = ''                                                    =>  0.0165650284,
	    NULL <  (Integer)BT_cen_med_hval AND (Real)bT_cen_med_hval < 508026.5   => -0.0061295218,
	    (Real)BT_cen_med_hval >= 508026.5                                       =>  0.0978993361,
	                                                                                0.0165650284);
	
	final_score_tree_87 := map(
	    NULL <  (Integer)s_d30_derog_count_i AND (Real)s_d30_derog_count_i < 1.5 => final_score_tree_87_c626,
	    (Real)s_d30_derog_count_i >= 1.5                               => -0.0389503467,
	                                                                final_score_tree_87_c629);
	
	
	/*  *************************TREE 88 ******************************************* */
	final_score_tree_88_c633 := map(
	    NULL <  (Integer)s_add_input_nhood_bus_pct_i AND (Real)s_add_input_nhood_bus_pct_i < 0.2042236142 =>  0.0561151405,
	    (Real)s_add_input_nhood_bus_pct_i >= 0.2042236142                                                 => -0.1268124468,
	                                                                                                          0.0437581503);
	
	final_score_tree_88_c632 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 3598 => 0.0000786561,
	    btst_dist_inp_addr_to_ip_addr_i >= 3598                                           => final_score_tree_88_c633,
	                                                                                         0.0092479341);
	
	final_score_tree_88_c631 := map(
	    NULL <  (Integer)s_c14_addr_stability_v2_d AND (Real)s_c14_addr_stability_v2_d < 3.5 => -0.0229866888,
	    (Real)s_c14_addr_stability_v2_d >= 3.5                                     => final_score_tree_88_c632,
	                                                                            -0.0174810087);
	
	final_score_tree_88_c634 := map(
	    (btst_email_topleveldomain_n in ['NET', 'OTH'])                                   => -0.0579457671,
	    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'EDU', 'GOV', 'MIL', 'ORG', 'US']) => 0.0107441272,
	                                                                                         -0.0024387818);
	
	final_score_tree_88 := map(
	    BT_cen_easiqlife = ''                                                    => final_score_tree_88_c634,
	    NULL <  (Integer)BT_cen_easiqlife AND (Real)bT_cen_easiqlife < 49.5      => 0.1079441770,
	    (Real)BT_cen_easiqlife >= 49.5                                           => final_score_tree_88_c631,
	                                                                                final_score_tree_88_c634);
																																									
	/*  *************************TREE 89 ******************************************* */
	final_score_tree_89_c639 := map(
	    BT_cen_pop_0_5_p = ''                                                  => 0.0073491827,   
	    NULL <  (Integer)BT_cen_pop_0_5_p AND (Real)bT_cen_pop_0_5_p < 13.25   => 0.0147775691,
	    (Real)BT_cen_pop_0_5_p >= 13.25                                        => 0.1440591503,
	                                                                              0.0073491827);
	
	final_score_tree_89_c638 := map(
	    NULL <  (Integer)b_rel_ageover50_count_d AND (Real)b_rel_ageover50_count_d < 4.5 => 0.0057219653,
	    b_rel_ageover50_count_d >= 4.5                                                   => 0.1419260211,
	                                                                                        final_score_tree_89_c639);
	
	final_score_tree_89_c637 := map(
	    (ip_topleveldomain_lvl_n in ['DOT', 'EDU', 'GOV', 'US'])        => -0.0808328489,
	    (ip_topleveldomain_lvl_n in ['-1', 'COM', 'NET', 'ORG', 'TWO']) => final_score_tree_89_c638,
	                                                                       0.0078572688);
	
	final_score_tree_89_c636 := map(
	    NULL <  (Integer)s_inq_ssns_per_addr_i AND (Real)s_inq_ssns_per_addr_i < 3.5   => final_score_tree_89_c637,
	    (Real)s_inq_ssns_per_addr_i >= 3.5                                             => -0.0803531348,
	                                                                                       0.0050869642);
	
	final_score_tree_89 := map(
	    ip_routingmethod_n = ''                                                       => 0.0056997167,
	    NULL < (Integer) ip_routingmethod_n AND (Integer)ip_routingmethod_n < 4       => 0.0910254928,
	    (Integer)ip_routingmethod_n >= 4                                              => final_score_tree_89_c636,
	                                                                                     0.0056997167);
	
	final_score_tree_90_c643 := map(
	    NULL <  (Integer)s_rel_homeover200_count_d AND (Real)s_rel_homeover200_count_d < 7.5 => -0.0062559511,
	    (Real)s_rel_homeover200_count_d >= 7.5                                     => 0.1431954677,
	                                                                            0.0399381238);
	
	final_score_tree_90_c644 := map(
	    BT_cen_health = ''                                                                   => -0.0043520735,
	    NULL <  (Integer)BT_cen_health AND (Real)bT_cen_health < 18.85                       => -0.0214373561,
	    (Real)BT_cen_health >= 18.85                                                         =>  0.0673347260,
	                                                                                            -0.0043520735);
	
	final_score_tree_90_c642 := map(
	    NULL <  (Integer)s_addrchangeincomediff_d AND (Real)s_addrchangeincomediff_d < -92.5 => final_score_tree_90_c643,
	    (Real)s_addrchangeincomediff_d >= -92.5                                    => -0.0048497166,
	                                                                            final_score_tree_90_c644);
	
	final_score_tree_90_c641 := map(
	    (ip_topleveldomain_lvl_n in ['DOT', 'GOV'])                                  => -0.0948497213,
	    (ip_topleveldomain_lvl_n in ['-1', 'COM', 'EDU', 'NET', 'ORG', 'TWO', 'US']) => final_score_tree_90_c642,
	                                                                                    -0.0043785332);
	
	final_score_tree_90 := map(
	    NULL <  (Integer)s_add_input_nhood_vac_pct_i AND (Real)s_add_input_nhood_vac_pct_i < 1.4625400641 => final_score_tree_90_c641,
	    (Real)s_add_input_nhood_vac_pct_i >= 1.4625400641                                       => 0.0897071760,
	                                                                                         -0.0036411641);
	
	final_score_tree_91_c647 := map(
	    BT_cen_business = ''                                                  => -0.0342926454,
	    NULL <  (Integer)BT_cen_business AND (Real)bT_cen_business < 35.5     =>  0.0112203010,
	    (Real)BT_cen_business >= 35.5                                         => -0.0963557541,
	                                                                             -0.0342926454);
	
	final_score_tree_91_c649 := map(
	    (btst_email_topleveldomain_n in ['EDU', 'NET', 'ORG', 'OTH'])       => -0.0579060714,
	    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'GOV', 'MIL', 'US']) => 0.0203014039,
	                                                                           0.0028443782);
	
	final_score_tree_91_c648 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'NET', 'TWO'])      => final_score_tree_91_c649,
	    (ip_topleveldomain_lvl_n in ['-1', 'EDU', 'GOV', 'ORG', 'US']) => 0.1084624143,
	                                                                      0.0118184597);
	
	final_score_tree_91_c646 := map(
	    ST_cen_civ_emp = ''                                                 => final_score_tree_91_c648,
	    NULL <  (Integer)ST_cen_civ_emp AND (Real)ST_cen_civ_emp < 61.4     => 0.0397646064,
	    (Real)ST_cen_civ_emp >= 61.4                                        => final_score_tree_91_c647,
	                                                                           final_score_tree_91_c648);
	
	final_score_tree_91 := map(
	    NULL <  (Integer)b_inq_retail_count24_i AND (Real)b_inq_retail_count24_i < 2.5 => -0.0015058507,
	    b_inq_retail_count24_i >= 2.5                                  => 0.1885098561,
	                                                                      final_score_tree_91_c646);
	
	final_score_tree_92_c653 := map(
	    BT_cen_med_hhinc = ''                                                  =>  0.0227660040,
	    NULL <  (Integer)BT_cen_med_hhinc AND (Real)bT_cen_med_hhinc < 61086.5 =>  0.0822416990,
	    (Real)BT_cen_med_hhinc >= 61086.5                                      => -0.0279345884,
	                                                                               0.0227660040);
	
	final_score_tree_92_c652 := map(
	    NULL <  (Integer)b_f01_inp_addr_address_score_d AND (Integer)b_f01_inp_addr_address_score_d < 55 => final_score_tree_92_c653,
	    b_f01_inp_addr_address_score_d >= 55                                          => -0.0078896467,
	                                                                                     -0.0245888940);
	
	final_score_tree_92_c651 := map(
	    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'EDU', 'GOV', 'MIL', 'NET', 'ORG']) => final_score_tree_92_c652,
	    (btst_email_topleveldomain_n in ['OTH', 'US'])                                     => 0.1366321282,
	                                                                                          -0.0061342245);
	
	final_score_tree_92_c654 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'GOV', 'NET', 'TWO', 'US']) => -0.0013312436,
	    (ip_topleveldomain_lvl_n in ['-1', 'EDU', 'ORG'])                      => 0.0760663890,
	                                                                              0.0045873988);
	
	final_score_tree_92 := map(
	    NULL <  (Integer)b_add_input_mobility_index_i AND (Real)b_add_input_mobility_index_i < 0.65788076105 => final_score_tree_92_c651,
	    b_add_input_mobility_index_i >= 0.65788076105                                        => -0.0696495489,
	                                                                                            final_score_tree_92_c654);
	
	final_score_tree_93_c657 := map(
	    ST_cen_med_hval = ''                                                       => -0.0098105230,
	    NULL <  (Integer)ST_cen_med_hval AND (Integer)ST_cen_med_hval < 405368     => -0.0353873744,
	    (Integer)ST_cen_med_hval >= 405368                                         =>  0.0510313813,
	                                                                                  -0.0098105230);
	
	final_score_tree_93_c656 := map(
	    NULL <  (Integer)b_d33_eviction_count_i AND (Real)b_d33_eviction_count_i < 2.5 => -0.0055935521,
	    b_d33_eviction_count_i >= 2.5                                                  =>  0.1548683236,
	                                                                                      final_score_tree_93_c657);
	
	final_score_tree_93_c659 := map(
	    ST_cen_high_ed = ''                                                     =>  0.0474938710,
	    NULL <  (Integer)ST_cen_high_ed AND (Real)ST_cen_high_ed < 10.25        => -0.1065300967,
	    (Real)ST_cen_high_ed >= 10.25                                           =>  0.0798271467,
	                                                                                0.0474938710);
	
	final_score_tree_93_c658 := map(
	    NULL <  (Integer)b_prevaddrmedianincome_d AND (Integer)b_prevaddrmedianincome_d < 31648 => 0.2166963920,
	    b_prevaddrmedianincome_d >= 31648                                    => final_score_tree_93_c659,
	                                                                            0.0704833440);
	
	final_score_tree_93 := map(
	    BT_cen_pop_0_5_p = ''                                                => -0.0173910413,
	    NULL <  (Integer)BT_cen_pop_0_5_p AND (Real)bT_cen_pop_0_5_p < 13.85 => final_score_tree_93_c656,
	    (Real)BT_cen_pop_0_5_p >= 13.85                                      => final_score_tree_93_c658,
	                                                                           -0.0173910413);
	
	final_score_tree_94_c661 := map(
	    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'EDU', 'MIL', 'NET', 'ORG']) => -0.0008710731,
	    (btst_email_topleveldomain_n in ['GOV', 'OTH', 'US'])                       => 0.1380897215,
	                                                                                   0.0002547411);
	
	final_score_tree_94_c664 := map(
	    BT_cen_span_lang = ''                                                       => 0.0652019249,
	    NULL <  (Integer)BT_cen_span_lang AND (Real)bT_cen_span_lang < 116.5        => 0.1190564235,
	    (Real)BT_cen_span_lang >= 116.5                                             => 0.0096644732,
	                                                                                   0.0652019249);
	
	final_score_tree_94_c663 := map(
	    BT_cen_unemp = ''                                                           =>  0.0333601908,
	    NULL <  (Integer)BT_cen_unemp AND (Real)bT_cen_unemp < 2.7                  => -0.0419020900,
	    (Real)BT_cen_unemp >= 2.7                                                   => final_score_tree_94_c664,
	                                                                                    0.0333601908);
	
	final_score_tree_94_c662 := map(
	    BT_cen_blue_col = ''                                                        => 0.0023781540,
	    NULL <  (Integer)BT_cen_blue_col AND (Real)bT_cen_blue_col < 12.65          => final_score_tree_94_c663,
	    (Real)BT_cen_blue_col >= 12.65                                              => -0.0576499254,
	                                                                                   0.0023781540);
	
	final_score_tree_94 := map(
	    NULL <  (Integer)b_d33_eviction_recency_d AND (Real)b_d33_eviction_recency_d < 79.5 => 0.1471057987,
	    b_d33_eviction_recency_d >= 79.5                                    => final_score_tree_94_c661,
	                                                                           final_score_tree_94_c662);
	
	final_score_tree_95_c666 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 6611 => -0.0136332720,
	    btst_dist_inp_addr_to_ip_addr_i >= 6611                                           => -0.0513218992,
	                                                                                         -0.0187322458);
	
	final_score_tree_95_c668 := map(
	    NULL <  (Integer)b_add_curr_nhood_vac_pct_i AND (Real)b_add_curr_nhood_vac_pct_i < 0.00698494835 => 0.2184113804,
	    b_add_curr_nhood_vac_pct_i >= 0.00698494835                                      => -0.0374820117,
	                                                                                        0.0937879752);
	
	final_score_tree_95_c667 := map(
	    NULL <  (Integer)s_prevaddrageoldest_d AND (Real)s_prevaddrageoldest_d < 353.5 => 0.0112848031,
	    (Real)s_prevaddrageoldest_d >= 353.5                                 => final_score_tree_95_c668,
	                                                                      0.0149087302);
	
	final_score_tree_95_c669 := map(
	    ST_cen_unemp = ''                                                      =>  0.0072548856,
	    NULL <  (Integer)ST_cen_unemp AND (Real)ST_cen_unemp < 2.85            => -0.0848955780,
	    (Real)ST_cen_unemp >= 2.85                                             =>  0.0193182090,
	                                                                               0.0072548856);
	
	final_score_tree_95 := map(
	    NULL <  (Integer)b_curraddrmedianincome_d AND (Real)b_curraddrmedianincome_d < 67157.5 => final_score_tree_95_c666,
	    b_curraddrmedianincome_d >= 67157.5                                    => final_score_tree_95_c667,
	                                                                              final_score_tree_95_c669);
	
	final_score_tree_96_c674 := map(
	    NULL <  (Integer)s_add_curr_nhood_mfd_pct_i AND (Real)s_add_curr_nhood_mfd_pct_i < 0.5319892295 => 0.0554455681,
	    (Real)s_add_curr_nhood_mfd_pct_i >= 0.5319892295                                      => -0.0635766204,
	                                                                                       -0.0065831639);
	
	final_score_tree_96_c673 := map(
	    NULL <  (Integer)b_prevaddrlenofres_d AND (Real)b_prevaddrlenofres_d < 6.5 => 0.1127631976,
	    b_prevaddrlenofres_d >= 6.5                                => final_score_tree_96_c674,
	                                                                  0.0051264420);
	
	final_score_tree_96_c672 := map(
	    (ip_connection_n in ['BROADBAND', 'MOBILE', 'SATELLITE', 'XDSL'])      => final_score_tree_96_c673,
	    (ip_connection_n in ['-1', 'CABLE', 'DIALUP', 'T1', 'T3', 'WIRELESS']) => 0.0919998815,
	                                                                              0.0306017390);
	
	final_score_tree_96_c671 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'NET', 'ORG']) => -0.0006673324,
	    (ip_topleveldomain_lvl_n in ['-1', 'TWO', 'US'])                        => final_score_tree_96_c672,
	                                                                               0.0028272169);
	
	final_score_tree_96 := map(
	    (ip_continent_n in ['AFRICA', 'AUSTRALIA', 'EUROPE', 'Other']) => -0.0826641766,
	    (ip_continent_n in ['ASIA', 'N AMERICA', 'S AMERICA'])         => final_score_tree_96_c671,
	                                                                      0.0021824854);
	
	final_score_tree_97_c677 := map(
	    NULL <  (Integer)b_nap_addr_verd_d AND (Real)b_nap_addr_verd_d < 0.5 => 0.1361441687,
	    (Real)b_nap_addr_verd_d >= 0.5                             => 0.0108416176,
	                                                            0.0668712136);
	
	final_score_tree_97_c679 := map(
	    BT_cen_span_lang = ''                                                   =>  0.0182259513,
	    NULL <  (Integer)BT_cen_span_lang AND (Real)bT_cen_span_lang < 130.5    =>  0.0592529526,
	    (Real)BT_cen_span_lang >= 130.5                                         => -0.0499205934,
	                                                                                0.0182259513);
	
	final_score_tree_97_c678 := map(
	    NULL <  (Integer)b_c13_curr_addr_lres_d AND (Real)b_c13_curr_addr_lres_d < 3.5 => 0.1948056517,
	    (Real)b_c13_curr_addr_lres_d >= 3.5                                  => 0.0186383586,
	                                                                      final_score_tree_97_c679);
	
	final_score_tree_97_c676 := map(
	    NULL <  (Integer)s_addrchangecrimediff_i AND (Real)s_addrchangecrimediff_i < -20.5 => final_score_tree_97_c677,
	    (Real)s_addrchangecrimediff_i >= -20.5                                   => 0.0023430551,
	                                                                          final_score_tree_97_c678);
	
	final_score_tree_97 := map(
	    ST_cen_no_move = ''                                             => -0.0049865472,
	    NULL <  (Integer)ST_cen_no_move AND (Real)ST_cen_no_move < 27.5 => -0.0311607119,
	    (Real)ST_cen_no_move >= 27.5                                    => final_score_tree_97_c676,
	                                                                       -0.0049865472);
	
	
	final_score_tree_98_c681 := map(
	    NULL <  (Integer)b_comb_age_d AND (Real)b_comb_age_d < 59.5 => -0.0447884230,
	    (Real)b_comb_age_d >= 59.5                        => 0.0823014883,
	                                                   -0.0066914643);
	
	final_score_tree_98_c684 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 0.5 => 0.0526011810,
	    (Real)btst_email_first_score_d >= 0.5                                    => -0.0310738675,
	                                                                          0.0262424190);
	
	final_score_tree_98_c683 := map(
	    BT_cen_mil_emp = ''                                                      =>  0.0059464560,
	    NULL <  (Integer)BT_cen_mil_emp AND (Real)bT_cen_mil_emp < 0.25 => final_score_tree_98_c684,
	    (Real)BT_cen_mil_emp >= 0.25                          => -0.0355544813,
	                                                       0.0059464560);
	
	final_score_tree_98_c682 := map(
	    NULL <  (Integer)s_c20_email_verification_d AND (Real)s_c20_email_verification_d < 0.5 => final_score_tree_98_c683,
	    (Real)s_c20_email_verification_d >= 0.5                                      => -0.0214916101,
	                                                                              -0.0092824021);
	
	final_score_tree_98 := map(
	    (ip_connection_n in ['DIALUP', 'MOBILE', 'SATELLITE'])                            => final_score_tree_98_c681,
	    (ip_connection_n in ['-1', 'BROADBAND', 'CABLE', 'T1', 'T3', 'WIRELESS', 'XDSL']) => final_score_tree_98_c682,
	                                                                                         -0.0140153615);
	
	final_score_tree_99_c686 := map(
	    NULL <  (Integer)b_fp_prevaddrcrimeindex_i AND (Real)b_fp_prevaddrcrimeindex_i < 83.5 => 0.1363370976,
	    (Real)b_fp_prevaddrcrimeindex_i >= 83.5                                     => 0.0046418513,
	                                                                             0.0434449150);
	
	final_score_tree_99_c689 := map(
	    (ip_topleveldomain_lvl_n in ['-1', 'COM', 'DOT', 'EDU'])        => -0.0980750685,
	    (ip_topleveldomain_lvl_n in ['GOV', 'NET', 'ORG', 'TWO', 'US']) => 0.0123324384,
	                                                                       -0.0327635855);
	
	final_score_tree_99_c688 := map(
	    BT_cen_incollege = ''                                                    => -0.0037329301,
	    NULL <  (Integer)BT_cen_incollege AND (Real)bT_cen_incollege < 5.05      =>  0.0392082477,
	    (Real)BT_cen_incollege >= 5.05                                           =>  final_score_tree_99_c689,
	                                                                                -0.0037329301);
	
	final_score_tree_99_c687 := map(
	    NULL <  (Integer)b_d33_eviction_count_i AND (Real)b_d33_eviction_count_i < 2.5 => -0.0078163835,
	    (Real)b_d33_eviction_count_i >= 2.5                                  => 0.1474228085,
	                                                                      final_score_tree_99_c688);
	
	final_score_tree_99 := map(
	    BT_cen_ownocc_p = ''                                               =>  0.0012830986,
	    NULL <  (Integer)BT_cen_ownocc_p AND (Real)bT_cen_ownocc_p < 13.45 => final_score_tree_99_c686,
	    (Real)BT_cen_ownocc_p >= 13.45                                     => final_score_tree_99_c687,
	                                                                          0.0012830986);
	
	final_score_tree_100_c692 := map(
	    NULL <  (Integer)b_rel_count_i AND (Real)b_rel_count_i < 2.5 => 0.0549486700,
	    (Real)b_rel_count_i >= 2.5                         => 0.0070337694,
	                                                    0.0132490801);
	
	final_score_tree_100_c691 := map(
	    ST_cen_ownocc_p = ''                                                     => -0.0064213805, 
	    NULL <  (Integer)ST_cen_ownocc_p AND (Real)ST_cen_ownocc_p < 73.95       => final_score_tree_100_c692,
	    (Real)ST_cen_ownocc_p >= 73.95                                           => -0.0304383672,
	                                                                                -0.0064213805);
	
	final_score_tree_100_c694 := map(
	    BT_cen_high_ed = ''                                                      =>  0.0114854502,
	    NULL <  (Integer)BT_cen_high_ed AND (Real)bT_cen_high_ed < 32.4          =>  0.0547511046,
	    (Real)BT_cen_high_ed >= 32.4                                             => -0.0393809273,
	                                                                                 0.0114854502);
	
	final_score_tree_100_c693 := map(
	    NULL <  (Integer)s_add_input_mobility_index_i AND (Real)s_add_input_mobility_index_i < 0.25306678945 => -0.0759993382,
	    (Real)s_add_input_mobility_index_i >= 0.25306678945                                        => final_score_tree_100_c694,
	                                                                                            0.0022494337);
	
	final_score_tree_100 := map(
	    NULL <  (Integer)s_acc_damage_amt_total_i AND (Integer)s_acc_damage_amt_total_i < 2400 => final_score_tree_100_c691,
	    (Integer)s_acc_damage_amt_total_i >= 2400                                    => 0.1388144601,
	                                                                           final_score_tree_100_c693);
	
	final_score_tree_101_c697 := map(
	    NULL <  (Integer)b_add_input_mobility_index_i AND (Real)b_add_input_mobility_index_i < 0.23186333245 => 0.1191587657,
	    (Real)b_add_input_mobility_index_i >= 0.23186333245                                        => -0.0142941338,
	                                                                                            0.0419724941);
	
	final_score_tree_101_c696 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => -0.0126710523,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_101_c697,
	                                                                    -0.0110590460);
	
	final_score_tree_101_c699 := map(
	    ST_cen_vacant_p = ''                                              =>  0.0094714884,
	    NULL <  (Integer)ST_cen_vacant_p AND (Real)ST_cen_vacant_p < 10.2 => -0.0195190905,
	    (Real)ST_cen_vacant_p >= 10.2                                     =>  0.0968060838,
	                                                                          0.0094714884);
	
	final_score_tree_101_c698 := map(
	    NULL <  (Integer)s_l80_inp_avm_autoval_d AND (Real)s_l80_inp_avm_autoval_d < 237805.5 => -0.0618832938,
	    (Real)s_l80_inp_avm_autoval_d >= 237805.5                                   => 0.0588673518,
	                                                                             final_score_tree_101_c699);
	
	final_score_tree_101 := map(
	    NULL <  (Integer)s_varrisktype_i AND (Real)s_varrisktype_i < 5.5 => final_score_tree_101_c696,
	    (Real)s_varrisktype_i >= 5.5                           => 0.1043390449,
	                                                        final_score_tree_101_c698);
	
	final_score_tree_102_c704 := map(
	    NULL <  (Integer)s_inq_count24_i AND (Real)s_inq_count24_i < 17.5 => 0.0084897112,
	    (Real)s_inq_count24_i >= 17.5                           => -0.1154521739,
	                                                         -0.0156652221);
	
	final_score_tree_102_c703 := map(
	    (ip_dma_lvl_n in ['4. DMA: US Code'])                                             => final_score_tree_102_c704,
	    (ip_dma_lvl_n in ['1. Missing DMA', '2. DMA: -1', '3. DMA: 0', '5. DMA: Unkown']) => 0.0850248053,
	                                                                                         0.0071575225);
	
	final_score_tree_102_c702 := map(
	    BT_cen_span_lang = ''                                                =>  0.0056367487,
	    NULL <  (Integer)BT_cen_span_lang AND (Real)bT_cen_span_lang < 197.5 => final_score_tree_102_c703,
	    (Real)BT_cen_span_lang >= 197.5                                      => -0.1039458651,
	                                                                             0.0056367487);
	
	final_score_tree_102_c701 := map(
	    NULL <  (Integer)b_add_input_nhood_mfd_pct_i AND (Real)b_add_input_nhood_mfd_pct_i < 0.9611341999 => final_score_tree_102_c702,
	    (Real)b_add_input_nhood_mfd_pct_i >= 0.9611341999                                       => 0.1252234386,
	                                                                                         -0.0035670987);
	
	final_score_tree_102 := map(
	    NULL <  (Integer)b_phones_per_addr_c6_i AND (Real)b_phones_per_addr_c6_i < 3.5 => final_score_tree_102_c701,
	    (Real)b_phones_per_addr_c6_i >= 3.5                                  => -0.0519534083,
	                                                                      0.0027429763);
	
	final_score_tree_103_c706 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 6731 => -0.0365695218,
	    (Integer)btst_dist_inp_addr_to_ip_addr_i >= 6731                                           => -0.1292218021,
	                                                                                         -0.0486906983);
	
	final_score_tree_103_c709 := map(
	    BT_cen_mil_emp = ''                                                 =>  0.0172624692,
	    NULL <  (Integer)BT_cen_mil_emp AND (Real)bT_cen_mil_emp < 0.15     => 0.0452268364,
	    (Real)BT_cen_mil_emp >= 0.15                                        => -0.0560587375,
	                                                                        0.0172624692);
	
	final_score_tree_103_c708 := map(
	    NULL <  (Integer)b_rel_homeover200_count_d AND (Real)b_rel_homeover200_count_d < 14.5 => 0.0028831623,
	    (Real)b_rel_homeover200_count_d >= 14.5                                     => -0.0635298060,
	                                                                             final_score_tree_103_c709);
	
	final_score_tree_103_c707 := map(
	    ST_cen_blue_col = ''                                               => 0.0019320718,
	    NULL <  (Integer)ST_cen_blue_col AND (Real)ST_cen_blue_col < 25.55 => final_score_tree_103_c708,
	    (Real)ST_cen_blue_col >= 25.55                           => 0.1633671799,
	                                                          0.0019320718);
	
	final_score_tree_103 := map(
	    BT_cen_high_ed = ''                                              => -0.0043349094,
	    NULL <  (Integer)BT_cen_high_ed AND (Real)bT_cen_high_ed < 9.85 => final_score_tree_103_c706,
	    (Real)BT_cen_high_ed >= 9.85                          => final_score_tree_103_c707,
	                                                       -0.0043349094);
	
	final_score_tree_104_c711 := map(
	    BT_cen_pop_0_5_p = ''                                               => -0.0982852033,
	    NULL <  (Integer)BT_cen_pop_0_5_p AND (Real)bT_cen_pop_0_5_p < 0.95 =>  0.1118419398,
	    (Real)BT_cen_pop_0_5_p >= 0.95                                      => -0.0015314867,
	                                                                           -0.0982852033);
	
	final_score_tree_104_c713 := map(
	    BT_cen_med_hval = ''                                                  =>  0.0042414607, 
	    NULL <  (Integer)BT_cen_med_hval AND (Real)bT_cen_med_hval < 243360.5 => -0.0495833143,
	    (Real)BT_cen_med_hval >= 243360.5                                     =>  0.0378281202,
	                                                                              0.0042414607);
	
	final_score_tree_104_c714 := map(
	    (ip_dma_lvl_n in ['2. DMA: -1', '3. DMA: 0', '5. DMA: Unkown']) => -0.0168715814,
	    (ip_dma_lvl_n in ['1. Missing DMA', '4. DMA: US Code'])         => 0.0568110108,
	                                                                       -0.0057003496);
	
	final_score_tree_104_c712 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 4847.5 => final_score_tree_104_c713,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 4847.5                                           => -0.0764482670,
	                                                                                           final_score_tree_104_c714);
	
	final_score_tree_104 := map(
	    NULL <  (Integer)s_add_curr_nhood_sfd_pct_d AND (Real)s_add_curr_nhood_sfd_pct_d < 0.00060521955 => -0.0977298709,
	    (Real)s_add_curr_nhood_sfd_pct_d >= 0.00060521955                                      => final_score_tree_104_c711,
	                                                                                        final_score_tree_104_c712);
	
	final_score_tree_105_c717 := map(
	    NULL <  (Integer)b_add_curr_nhood_bus_pct_i AND (Real)b_add_curr_nhood_bus_pct_i < 0.0231125356 => 0.0526931270,
	    (Real)b_add_curr_nhood_bus_pct_i >= 0.0231125356                                      => -0.0004874548,
	                                                                                       0.0598687927);
	
	final_score_tree_105_c716 := map(
	    ST_cen_vacant_p = ''                                              =>  0.0006886372,
	    NULL <  (Integer)ST_cen_vacant_p AND (Real)ST_cen_vacant_p < 7.55 => -0.0105744034,
	    (Real)ST_cen_vacant_p >= 7.55                                     => final_score_tree_105_c717,
	                                                                          0.0006886372);
	
	final_score_tree_105_c718 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5 => 0.1348999273,
	    (Real)btst_email_last_score_d >= 0.5                                   => 0.0237997233,
	                                                                        0.0664135002);
	
	final_score_tree_105_c719 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'NET', 'TWO'])      => -0.0043344769,
	    (ip_topleveldomain_lvl_n in ['-1', 'EDU', 'GOV', 'ORG', 'US']) => 0.0644158284,
	                                                                      0.0014190947);
	
	final_score_tree_105 := map(
	    BT_cen_med_hval = ''                                                  =>  final_score_tree_105_c719,
	    NULL <  (Integer)BT_cen_med_hval AND (Real)bT_cen_med_hval < 998417.5 => final_score_tree_105_c716,
	    (Real)BT_cen_med_hval >= 998417.5                           => final_score_tree_105_c718,
	                                                             final_score_tree_105_c719);
	
	final_score_tree_106_c722 := map(
	    NULL <  (Integer)b_fp_prevaddrburglaryindex_i AND (Real)b_fp_prevaddrburglaryindex_i < 189.5 => -0.0403250879,
	    (Real)b_fp_prevaddrburglaryindex_i >= 189.5                                        => 0.1571285172,
	                                                                                    -0.0182698610);
	
	final_score_tree_106_c721 := map(
	    (btst_email_topleveldomain_n in ['COM', 'EDU', 'GOV', 'NET', 'ORG']) => final_score_tree_106_c722,
	    (btst_email_topleveldomain_n in ['BIZ', 'MIL', 'OTH', 'US'])         => 0.0905225953,
	                                                                            -0.0304571399);
	
	final_score_tree_106_c724 := map(
	    NULL <  (Integer)s_l79_adls_per_addr_c6_i AND (Real)s_l79_adls_per_addr_c6_i < 4.5 => 0.0173203352,
	    (Real)s_l79_adls_per_addr_c6_i >= 4.5                                    => 0.1200370555,
	                                                                          0.0201985158);
	
	final_score_tree_106_c723 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 2.5 => final_score_tree_106_c724,
	    (Real)btst_email_first_score_d >= 2.5                                    => -0.0549029960,
	                                                                          0.0053015835);
	
	final_score_tree_106 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'ORG']) => final_score_tree_106_c721,
	    (ip_topleveldomain_lvl_n in ['-1', 'NET', 'TWO', 'US'])          => final_score_tree_106_c723,
	                                                                        -0.0065262642);
	
	final_score_tree_107_c727 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 10501.5 => 0.0133375456,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 10501.5                                           => 0.0923345583,
	                                                                                            0.0151401834);
	
	final_score_tree_107_c729 := map(
	    ST_cen_high_ed = ''                                               => -0.0416098347,
	    NULL <  (Integer)ST_cen_high_ed AND (Real)ST_cen_high_ed < 36.25  => -0.0004894472,
	    (Real)ST_cen_high_ed >= 36.25                                     => -0.0921767977,
	                                                                         -0.0416098347);
	
	final_score_tree_107_c728 := map(
	    (ip_connection_n in ['BROADBAND', 'MOBILE', 'T1', 'WIRELESS', 'XDSL']) => final_score_tree_107_c729,
	    (ip_connection_n in ['-1', 'CABLE', 'DIALUP', 'SATELLITE', 'T3'])      => 0.0429471285,
	                                                                              -0.0137679078);
	
	final_score_tree_107_c726 := map(
	    NULL <  (Integer)b_d30_derog_count_i AND (Real)b_d30_derog_count_i < 1.5 => final_score_tree_107_c727,
	    (Real)b_d30_derog_count_i >= 1.5                               => -0.0220019626,
	                                                                final_score_tree_107_c728);
	
	final_score_tree_107 := map(
	    ST_cen_vacant_p = ''                                               => 0.0006558202,
	    NULL <  (Integer)ST_cen_vacant_p AND (Real)ST_cen_vacant_p < 37.15 => final_score_tree_107_c726,
	    (Real)ST_cen_vacant_p >= 37.15                           => -0.1076385765,
	                                                          0.0006558202);
	
	final_score_tree_108_c732 := map(
	    (ip_connection_n in ['-1', 'BROADBAND', 'CABLE', 'DIALUP', 'MOBILE', 'SATELLITE', 'XDSL']) => 0.0029787285,
	    (ip_connection_n in ['T1', 'T3', 'WIRELESS'])                                              => 0.1688319573,
	                                                                                                  0.0043724531);
	
	final_score_tree_108_c734 := map(
	    NULL <  (Integer)s_curraddrburglaryindex_i AND (Integer)s_curraddrburglaryindex_i < 75 => 0.1488882702,
	    (Integer)s_curraddrburglaryindex_i >= 75                                     => 0.0199023263,
	                                                                           0.0860489642);
	
	final_score_tree_108_c733 := map(
	    (ip_connection_n in ['MOBILE', 'SATELLITE', 'WIRELESS', 'XDSL'])        => -0.0409964720,
	    (ip_connection_n in ['-1', 'BROADBAND', 'CABLE', 'DIALUP', 'T1', 'T3']) => final_score_tree_108_c734,
	                                                                               0.0471275300);
	
	final_score_tree_108_c731 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_108_c732,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_108_c733,
	                                                                    0.0055802631);
	
	final_score_tree_108 := map(
	    NULL <  (Integer)b_componentcharrisktype_i AND (Real)b_componentcharrisktype_i < 6.5 => final_score_tree_108_c731,
	    (Real)b_componentcharrisktype_i >= 6.5                                     => -0.0692112537,
	                                                                            0.0012970241);
	
	final_score_tree_109_c737 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 1997 => 0.0411249096,
	    (Integer)btst_dist_inp_addr_to_ip_addr_i >= 1997                                           => -0.1330070691,
	                                                                                         -0.0077290014);
	
	final_score_tree_109_c739 := map(
	    BT_cen_families = ''                                                         =>  0.0339601125,
	    NULL <  (Integer)BT_cen_families AND (Real)BT_cen_families < 565.5           => -0.0032257322,
	    (Real)BT_cen_families >= 565.5                                               =>  0.1252937663,
	                                                                                     0.0339601125);
	
	final_score_tree_109_c738 := map(
	    NULL <  (Integer)s_inq_auto_count24_i AND (Real)s_inq_auto_count24_i < 1.5 => 0.0294574679,
	    (Real)s_inq_auto_count24_i >= 1.5                                => -0.0445357164,
	                                                                  final_score_tree_109_c739);
	
	final_score_tree_109_c736 := map(
	    NULL <  (Integer)b_add_input_nhood_sfd_pct_d AND (Real)b_add_input_nhood_sfd_pct_d < 0.0216480992 => final_score_tree_109_c737,
	    (Real)b_add_input_nhood_sfd_pct_d >= 0.0216480992                                       => final_score_tree_109_c738,
	                                                                                         0.0159416547);
	
	final_score_tree_109 := map(
	    NULL <  (Integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_109_c736,
	    b_adl_per_email_i >= 0.5                             => -0.0305644433,
	                                                            -0.0036925528);
	
	final_score_tree_110_c742 := map(
	    NULL <  (Integer)b_i60_inq_retail_recency_d AND (Real)b_i60_inq_retail_recency_d < 61.5 => 0.0902339181,
	    b_i60_inq_retail_recency_d >= 61.5                                      => -0.0364753598,
	                                                                               -0.0276693096);
	
	final_score_tree_110_c744 := map(
	    NULL <  (Integer)s_c20_email_verification_d AND (Real)s_c20_email_verification_d < 0.5 => 0.0582574612,
	    (Real)s_c20_email_verification_d >= 0.5                                      => 0.0315903066,
	                                                                              0.0417405051);
	
	final_score_tree_110_c743 := map(
	    NULL <  (Integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => final_score_tree_110_c744,
	    b_adl_per_email_i >= 0.5                             => -0.0202758276,
	                                                            0.0083319880);
	
	final_score_tree_110_c741 := map(
	    NULL <  (Integer)s_c12_source_profile_d AND (Real)s_c12_source_profile_d < 55.85 => final_score_tree_110_c742,
	    (Real)s_c12_source_profile_d >= 55.85                                  => final_score_tree_110_c743,
	                                                                        0.0247806549);
	
	final_score_tree_110 := map(
	    NULL <  (Integer)b_add_input_nhood_sfd_pct_d AND (Real)b_add_input_nhood_sfd_pct_d < 0.65121424795 => -0.0129939091,
	    b_add_input_nhood_sfd_pct_d >= 0.65121424795                                       => final_score_tree_110_c741,
	                                                                                          -0.0070222956);
	
	final_score_tree_111_c749 := map(
	    NULL <  (Integer)s_add_input_nhood_mfd_pct_i AND (Real)s_add_input_nhood_mfd_pct_i < 0.1883542952 => 0.1621531746,
	    (Real)s_add_input_nhood_mfd_pct_i >= 0.1883542952                                       => 0.0316667839,
	                                                                                         0.0718971725);
	
	final_score_tree_111_c748 := map(
	    (bf_seg_fraudpoint_3_0_BT in ['3: Derog', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => 0.0139168232,
	    (bf_seg_fraudpoint_3_0_BT in ['1: Stolen/Manip ID', '2: Synth ID'])                                  => final_score_tree_111_c749,
	                                                                                                         0.0203773965);
	
	final_score_tree_111_c747 := map(
	    BT_cen_incollege = ''                                                => -0.0031733877,  
	    NULL <  (Integer)BT_cen_incollege AND (Real)bT_cen_incollege < 14.35 => final_score_tree_111_c748,
	    (Real)BT_cen_incollege >= 14.35                            => -0.0457704828,
	                                                            -0.0031733877);
	
	final_score_tree_111_c746 := map(
	    NULL <  (Integer)b_add_input_nhood_sfd_pct_d AND (Real)b_add_input_nhood_sfd_pct_d < 0.89681759 => final_score_tree_111_c747,
	    b_add_input_nhood_sfd_pct_d >= 0.89681759                                       => -0.0192182144,
	                                                                                       0.0002956720);
	
	final_score_tree_111 := map(
	    (ip_continent_n in ['AFRICA', 'ASIA', 'AUSTRALIA', 'EUROPE']) => -0.0786325229,
	    (ip_continent_n in ['N AMERICA', 'Other', 'S AMERICA'])       => final_score_tree_111_c746,
	                                                                     -0.0003969654);
	
	final_score_tree_112_c752 := map(
	    NULL <  (Integer)s_add_curr_mobility_index_i AND (Real)s_add_curr_mobility_index_i < 0.2735870838 => 0.0496485804,
	    (Real)s_add_curr_mobility_index_i >= 0.2735870838                                       => 0.2095270735,
	                                                                                         0.1019165493);
	
	final_score_tree_112_c751 := map(
	    NULL <  (Integer)b_c14_addr_stability_v2_d AND (Real)b_c14_addr_stability_v2_d < 4.5 => -0.0314877395,
	    b_c14_addr_stability_v2_d >= 4.5                                     => final_score_tree_112_c752,
	                                                                            0.0458427686);
	
	final_score_tree_112_c754 := map(
	    (ip_connection_n in ['BROADBAND', 'SATELLITE', 'XDSL'])                          => -0.0203480714,
	    (ip_connection_n in ['-1', 'CABLE', 'DIALUP', 'MOBILE', 'T1', 'T3', 'WIRELESS']) => 0.0523346364,
	                                                                                        0.0176898076);
	
	final_score_tree_112_c753 := map(
	    (ip_topleveldomain_lvl_n in ['DOT', 'NET', 'US'])                      => -0.0320401393,
	    (ip_topleveldomain_lvl_n in ['-1', 'COM', 'EDU', 'GOV', 'ORG', 'TWO']) => final_score_tree_112_c754,
	                                                                              -0.0002161009);
	
	final_score_tree_112 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 8958 => 0.0001286649,
	    btst_dist_inp_addr_to_ip_addr_i >= 8958                                           => final_score_tree_112_c751,
	                                                                                         final_score_tree_112_c753);
	
	final_score_tree_113_c759 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 1494.5 => 0.0264719921,
	    btst_dist_inp_addr_to_ip_addr_i >= 1494.5                                           => 0.0999717334,
	                                                                                           0.0540052285);
	
	final_score_tree_113_c758 := map(
	    BT_cen_ownocc_p = ''                                               =>  0.0145970225,
	    NULL <  (Integer)BT_cen_ownocc_p AND (Real)bT_cen_ownocc_p < 70.75 => final_score_tree_113_c759,
	    (Real)BT_cen_ownocc_p >= 70.75                                     => -0.0052965430,
	                                                                           0.0145970225);
	
	final_score_tree_113_c757 := map(
	    NULL <  (Integer)s_f01_inp_addr_not_verified_i AND (Real)s_f01_inp_addr_not_verified_i < 0.5 => final_score_tree_113_c758,
	    (Real)s_f01_inp_addr_not_verified_i >= 0.5                                         => -0.0510360903,
	                                                                                    0.0212128752);
	
	final_score_tree_113_c756 := map(
	    BT_cen_rental = ''                                            => -0.0036673502,
	    NULL <  (Integer)BT_cen_rental AND (Real)bT_cen_rental < 94.5 => final_score_tree_113_c757,
	    (Real)BT_cen_rental >= 94.5                                   => -0.0189260764,
	                                                                     -0.0036673502);
	
	final_score_tree_113 := map(
	    ST_cen_span_lang = ''                                                => -0.0027182317,
	    NULL <  (Integer)ST_cen_span_lang AND (Real)ST_cen_span_lang < 186.5 => final_score_tree_113_c756,
	    (Real)ST_cen_span_lang >= 186.5                            => -0.0563687037,
	                                                            -0.0027182317);
	
	final_score_tree_114_c762 := map(
	    NULL <  (Integer)btst_distaddraddr2_i AND (Real)btst_distaddraddr2_i < 60.5 => 0.0101938566,
	    btst_distaddraddr2_i >= 60.5                                => -0.0913092481,
	                                                                   0.0089443313);
	
	final_score_tree_114_c761 := map(
	    ST_cen_families = ''                                               => -0.0019599417,
	    NULL <  (Integer)ST_cen_families AND (Real)ST_cen_families < 620.5 => final_score_tree_114_c762,
	    (Real)ST_cen_families >= 620.5                           => -0.0387731903,
	                                                          -0.0019599417);
	
	final_score_tree_114_c764 := map(
	    NULL <  (Integer)b_nap_lname_verd_d AND (Real)b_nap_lname_verd_d < 0.5 => 0.1069567284,
	    (Real)b_nap_lname_verd_d >= 0.5                              => -0.0574104990,
	                                                              0.0371006568);
	
	final_score_tree_114_c763 := map(
	    BT_cen_families = ''                                               =>  0.0038160033,
	    NULL <  (Integer)BT_cen_families AND (Real)bT_cen_families < 356.5 => -0.0496052053,
	    (Real)BT_cen_families >= 356.5                           => final_score_tree_114_c764,
	                                                          0.0038160033);
	
	final_score_tree_114 := map(
	    NULL <  (Integer)b_d33_eviction_recency_d AND (Integer)b_d33_eviction_recency_d < 48 => 0.1511840018,
	    (Integer)b_d33_eviction_recency_d >= 48                                    => final_score_tree_114_c761,
	                                                                         final_score_tree_114_c763);
	
	final_score_tree_115_c766 := map(
	    NULL <  (Integer)s_add_input_nhood_sfd_pct_d AND (Real)s_add_input_nhood_sfd_pct_d < 0.46550757835 => 0.0245438486,
	    (Real)s_add_input_nhood_sfd_pct_d >= 0.46550757835                                       => -0.0104921063,
	                                                                                          -0.0033658767);
	
	final_score_tree_115_c769 := map(
	    (ip_connection_n in ['BROADBAND', 'SATELLITE', 'XDSL'])                          => -0.0431386798,
	    (ip_connection_n in ['-1', 'CABLE', 'DIALUP', 'MOBILE', 'T1', 'T3', 'WIRELESS']) => 0.0115995417,
	                                                                                        -0.0135041169);
	
	final_score_tree_115_c768 := map(
	    (ip_dma_lvl_n in ['5. DMA: Unkown'])                                               => final_score_tree_115_c769,
	    (ip_dma_lvl_n in ['1. Missing DMA', '2. DMA: -1', '3. DMA: 0', '4. DMA: US Code']) => 0.0411801672,
	                                                                                          0.0023186807);
	
	final_score_tree_115_c767 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'NET', 'TWO'])      => final_score_tree_115_c768,
	    (ip_topleveldomain_lvl_n in ['-1', 'EDU', 'GOV', 'ORG', 'US']) => 0.0758950215,
	                                                                      0.0077366734);
	
	final_score_tree_115 := map(
	    ST_cen_families = ''                                              => final_score_tree_115_c767,
	    NULL <  (Integer)ST_cen_families AND (Real)ST_cen_families < 89.5 => -0.1271622200,
	    (Real)ST_cen_families >= 89.5                           => final_score_tree_115_c766,
	                                                         final_score_tree_115_c767);
	
	final_score_tree_116_c772 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 598.5 => 0.0424111879,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 598.5                                           => -0.0550025460,
	                                                                                          -0.0091106444);
	
	final_score_tree_116_c771 := map(
	    NULL <  (Integer)b_mos_foreclosure_lseen_d AND (Real)b_mos_foreclosure_lseen_d < 49.5 => 0.1761314817,
	    (Real)b_mos_foreclosure_lseen_d >= 49.5                                     => -0.0140678528,
	                                                                             final_score_tree_116_c772);
	
	final_score_tree_116_c774 := map(
	    BT_cen_ownocc_p = ''                                               => 0.0822467798,
	    NULL <  (Integer)BT_cen_ownocc_p AND (Real)BT_cen_ownocc_p < 73.45 => 0.1706427133,
	    (Real)BT_cen_ownocc_p >= 73.45                           => 0.0229284559,
	                                                          0.0822467798);
	
	final_score_tree_116_c773 := map(
	    ST_cen_ownocc_p = ''                                              =>  0.0350503387,
	    NULL <  (Integer)ST_cen_ownocc_p AND (Real)ST_cen_ownocc_p < 56.1 => -0.0665420005,
	    (Real)ST_cen_ownocc_p >= 56.1                           => final_score_tree_116_c774,
	                                                         0.0350503387);
	
	final_score_tree_116 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_116_c771,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_116_c773,
	                                                                    -0.0108850070);
	
	final_score_tree_117_c777 := map(
	    (ip_dma_lvl_n in ['2. DMA: -1', '5. DMA: Unkown'])                   => -0.0491930362,
	    (ip_dma_lvl_n in ['1. Missing DMA', '3. DMA: 0', '4. DMA: US Code']) => 0.0352447407,
	                                                                            -0.0213530446);
	
	final_score_tree_117_c779 := map(
	    (ip_connection_n in ['MOBILE', 'SATELLITE', 'XDSL'])                                => 0.0060025763,
	    (ip_connection_n in ['-1', 'BROADBAND', 'CABLE', 'DIALUP', 'T1', 'T3', 'WIRELESS']) => 0.0721300497,
	                                                                                           0.0472736235);
	
	final_score_tree_117_c778 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5 => final_score_tree_117_c779,
	    (Real)btst_email_last_score_d >= 0.5                                   => -0.0196220444,
	                                                                        0.0041968677);
	
	final_score_tree_117_c776 := map(
	    (ip_topleveldomain_lvl_n in ['-1', 'GOV', 'NET'])                      => final_score_tree_117_c777,
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'ORG', 'TWO', 'US']) => final_score_tree_117_c778,
	                                                                              -0.0062968463);
	
	final_score_tree_117 := map(
	    ST_cen_pop_0_5_p = ''                                                => final_score_tree_117_c776,
	    NULL <  (Integer)ST_cen_pop_0_5_p AND (Real)ST_cen_pop_0_5_p < 17.55 => -0.0065433201,
	    (Real)ST_cen_pop_0_5_p >= 17.55                            => 0.1525913798,
	                                                            final_score_tree_117_c776);
	
	final_score_tree_118_c782 := map(
	    NULL <  (Integer)b_curraddrmurderindex_i AND (Real)b_curraddrmurderindex_i < 92.5 => 0.1340089270,
	    (Real)b_curraddrmurderindex_i >= 92.5                                   => -0.0433585197,
	                                                                         0.0650326977);
	
	final_score_tree_118_c784 := map(
	    NULL <  (Integer)s_add_input_nhood_vac_pct_i AND (Real)s_add_input_nhood_vac_pct_i < 0.01593878875 => -0.0268820413,
	    (Real)s_add_input_nhood_vac_pct_i >= 0.01593878875                                       => 0.0495163985,
	                                                                                          0.0165087750);
	
	final_score_tree_118_c783 := map(
	    BT_cen_trailer = ''                                              => -0.0068557633,
	    NULL <  (Integer)BT_cen_trailer AND (Real)bT_cen_trailer < 116.5 => final_score_tree_118_c784,
	    (Real)BT_cen_trailer >= 116.5                          => -0.0530568277,
	                                                        -0.0068557633);
	
	final_score_tree_118_c781 := map(
	    NULL <  (Integer)s_addrchangeincomediff_d AND (Real)s_addrchangeincomediff_d < -13995.5 => final_score_tree_118_c782,
	    (Real)s_addrchangeincomediff_d >= -13995.5                                    => -0.0109598506,
	                                                                               final_score_tree_118_c783);
	
	final_score_tree_118 := map(
	    NULL <  (Integer)b_add_input_nhood_mfd_pct_i AND (Real)b_add_input_nhood_mfd_pct_i < 0.97880873885 => final_score_tree_118_c781,
	    (Real)b_add_input_nhood_mfd_pct_i >= 0.97880873885                                       => 0.1069867639,
	                                                                                          -0.0077813633);
	
	final_score_tree_119_c788 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 695.5 => -0.0131199771,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 695.5                                           => 0.0243338117,
	                                                                                          0.0029802687);
	
	final_score_tree_119_c787 := map(
	    NULL <  (Integer)s_rel_under100miles_cnt_d AND (Real)s_rel_under100miles_cnt_d < 13.5 => final_score_tree_119_c788,
	    (Real)s_rel_under100miles_cnt_d >= 13.5                                     => -0.0414148012,
	                                                                             0.0006437819);
	
	final_score_tree_119_c786 := map(
	    (btst_email_topleveldomain_n in ['BIZ', 'EDU', 'GOV', 'ORG'])       => -0.1131179590,
	    (btst_email_topleveldomain_n in ['COM', 'MIL', 'NET', 'OTH', 'US']) => final_score_tree_119_c787,
	                                                                           -0.0054663715);
	
	final_score_tree_119_c789 := map(
	    (ip_connection_n in ['BROADBAND', 'MOBILE'])                                                => -0.0115520001,
	    (ip_connection_n in ['-1', 'CABLE', 'DIALUP', 'SATELLITE', 'T1', 'T3', 'WIRELESS', 'XDSL']) => 0.0904065138,
	                                                                                                   0.0481439174);
	
	final_score_tree_119 := map(
	    (ip_topleveldomain_lvl_n in ['-1', 'COM', 'EDU', 'GOV', 'NET', 'ORG', 'US']) => final_score_tree_119_c786,
	    (ip_topleveldomain_lvl_n in ['DOT', 'TWO'])                                  => final_score_tree_119_c789,
	                                                                                    -0.0040447191);
	
	final_score_tree_120_c792 := map(
	    NULL <  (Integer)s_c13_curr_addr_lres_d AND (Real)s_c13_curr_addr_lres_d < 23.5 => -0.0217265277,
	    (Real)s_c13_curr_addr_lres_d >= 23.5                                  => 0.0101131813,
	                                                                       0.0022408695);
	
	final_score_tree_120_c793 := map(
	    ST_cen_business = ''                                                =>  0.0200618453,
	    NULL <  (Integer)ST_cen_business AND (Real)ST_cen_business < 49.5   => -0.0086748321,
	    (Real)ST_cen_business >= 49.5                                       =>  0.0740615357,
	                                                                            0.0200618453);
	
	final_score_tree_120_c791 := map(
	    NULL <  (Integer)s_prevaddrmurderindex_i AND (Real)s_prevaddrmurderindex_i < 195.5 => final_score_tree_120_c792,
	    (Real)s_prevaddrmurderindex_i >= 195.5                                   => 0.1354980338,
	                                                                          final_score_tree_120_c793);
	
	final_score_tree_120_c794 := map(
	    NULL <  (Integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 1.5 => -0.0190610497,
	    (Real)b_c20_email_verification_d >= 1.5                                      => 0.0331746429,
	                                                                              0.0095570322);
	
	final_score_tree_120 := map(
	    BT_cen_med_hval = ''                                                  =>  final_score_tree_120_c794,
	    NULL <  (Integer)BT_cen_med_hval AND (Integer)BT_cen_med_hval < 63934 => -0.0880273562,
	    (Integer)BT_cen_med_hval >= 63934                                      => final_score_tree_120_c791,
	                                                                              final_score_tree_120_c794);
	
	final_score_tree_121_c799 := map(
	    BT_cen_families = ''                                                  =>  0.0255467082,
	    NULL <  (Integer)BT_cen_families AND (Integer)BT_cen_families < 493   => -0.0103034049,
	    (Integer)BT_cen_families >= 493                                       =>  0.1213434519,
	                                                                              0.0255467082);
	
	final_score_tree_121_c798 := map(
	    (ip_topleveldomain_lvl_n in ['-1', 'DOT', 'EDU'])                      => -0.0349460418,
	    (ip_topleveldomain_lvl_n in ['COM', 'GOV', 'NET', 'ORG', 'TWO', 'US']) => final_score_tree_121_c799,
	                                                                              0.0195036857);
	
	final_score_tree_121_c797 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 2.5 => final_score_tree_121_c798,
	    (Real)btst_email_first_score_d >= 2.5                                    => -0.0836754445,
	                                                                          0.0049695697);
	
	final_score_tree_121_c796 := map(
	    NULL <  (Integer)s_varrisktype_i AND (Real)s_varrisktype_i < 5.5 => 0.0076094627,
	    (Real)s_varrisktype_i >= 5.5                           => 0.1411146260,
	                                                        final_score_tree_121_c797);
	
	final_score_tree_121 := map(
	    NULL <  (Integer)s_add_input_nhood_vac_pct_i AND (Real)s_add_input_nhood_vac_pct_i < 0.03858542545 => final_score_tree_121_c796,
	    (Real)s_add_input_nhood_vac_pct_i >= 0.03858542545                                       => -0.0213859557,
	                                                                                          0.0015723032);
	
	final_score_tree_122_c801 := map(
	    NULL <  (Integer)s_add_input_mobility_index_i AND (Real)s_add_input_mobility_index_i < 0.31990252435 => -0.0019700489,
	    (Real)s_add_input_mobility_index_i >= 0.31990252435                                        => 0.0344990282,
	                                                                                            0.0032661886);
	
	final_score_tree_122_c803 := map(
	     BT_cen_lar_fam = ''                                             =>  0.0519860571, 
	    NULL <  (Integer)BT_cen_lar_fam AND (Real)bT_cen_lar_fam < 107.5 => -0.0358991436,
	    (Real)BT_cen_lar_fam >= 107.5                          => 0.1763519072,
	                                                        0.0519860571);
	
	final_score_tree_122_c804 := map(
	    NULL <  (Integer)b_f01_inp_addr_address_score_d AND (Integer)b_f01_inp_addr_address_score_d < 65 => -0.0829625181,
	    (Integer)b_f01_inp_addr_address_score_d >= 65                                          => -0.0495806218,
	                                                                                     -0.0529929935);
	
	final_score_tree_122_c802 := map(
	    NULL <  (Integer)b_d32_mos_since_crim_ls_d AND (Integer)b_d32_mos_since_crim_ls_d < 84 => final_score_tree_122_c803,
	    (Integer)b_d32_mos_since_crim_ls_d >= 84                                     => final_score_tree_122_c804,
	                                                                           0.0164009151);
	
	final_score_tree_122 := map(
	    NULL <  (Integer)s_add_input_nhood_vac_pct_i AND (Real)s_add_input_nhood_vac_pct_i < 0.0679838162 => final_score_tree_122_c801,
	    (Real)s_add_input_nhood_vac_pct_i >= 0.0679838162                                       => final_score_tree_122_c802,
	                                                                                         -0.0008109700);
	
	final_score_tree_123_c809 := map(
	    NULL <  (Integer)b_rel_bankrupt_count_i AND (Real)b_rel_bankrupt_count_i < 1.5 => -0.0156997926,
	    (Real)b_rel_bankrupt_count_i >= 1.5                                  => 0.1369334044,
	                                                                      0.0403992822);
	
	final_score_tree_123_c808 := map(
	    BT_cen_incollege = ''                                               => 0.0063656436,
	    NULL <  (Integer)BT_cen_incollege AND (Real)bT_cen_incollege < 7.05 => final_score_tree_123_c809,
	    (Real)BT_cen_incollege >= 7.05                            => -0.0419736602,
	                                                           0.0063656436);
	
	final_score_tree_123_c807 := map(
	    NULL <  (Integer)s_rel_homeover300_count_d AND (Real)s_rel_homeover300_count_d < 7.5 => final_score_tree_123_c808,
	    (Real)s_rel_homeover300_count_d >= 7.5                                     => 0.1252582990,
	                                                                            0.1557584343);
	
	final_score_tree_123_c806 := map(
	    NULL <  (Integer)b_curraddrcartheftindex_i AND (Real)b_curraddrcartheftindex_i < 151.5 => -0.0031603384,
	    (Real)b_curraddrcartheftindex_i >= 151.5                                     => final_score_tree_123_c807,
	                                                                              0.0020093573);
	
	final_score_tree_123 := map(
	    NULL <  (Integer)b_phones_per_addr_c6_i AND (Real)b_phones_per_addr_c6_i < 3.5 => final_score_tree_123_c806,
	    (Real)b_phones_per_addr_c6_i >= 3.5                                  => -0.0827285800,
	                                                                      -0.0011649071);
	
	final_score_tree_124_c812 := map(
	    NULL <  (Integer)s_addrchangecrimediff_i AND (Real)s_addrchangecrimediff_i < -29.5 => 0.0487235739,
	    (Real)s_addrchangecrimediff_i >= -29.5                                   => -0.0044461137,
	                                                                          0.0075306350);
	
	final_score_tree_124_c811 := map(
	    NULL <  (Integer)s_inq_per_addr_i AND (Real)s_inq_per_addr_i < 11.5 => final_score_tree_124_c812,
	    (Real)s_inq_per_addr_i >= 11.5                            => 0.1368324750,
	                                                           0.0009571071);
	
	final_score_tree_124_c814 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 590 => -0.0735400401,
	    (Integer)btst_dist_inp_addr_to_ip_addr_i >= 590                                           => -0.1565631826,
	                                                                                        -0.1086885238);
	
	final_score_tree_124_c813 := map(
	    NULL <  (Integer)b_i60_inq_recency_d AND (Integer)b_i60_inq_recency_d < 18 => final_score_tree_124_c814,
	    (Integer)b_i60_inq_recency_d >= 18                               => 0.0609014262,
	                                                               -0.0383884163);
	
	final_score_tree_124 := map(
	    NULL <  (Integer)s_inq_ssns_per_addr_i AND (Real)s_inq_ssns_per_addr_i < 3.5 => final_score_tree_124_c811,
	    (Real)s_inq_ssns_per_addr_i >= 3.5                                 => final_score_tree_124_c813,
	                                                                    -0.0003466563);
	
	final_score_tree_125_c817 := map(
	    (ip_connection_n in ['CABLE', 'MOBILE', 'SATELLITE', 'T1', 'WIRELESS', 'XDSL']) => -0.0125222712,
	    (ip_connection_n in ['-1', 'BROADBAND', 'DIALUP', 'T3'])                        => 0.0302987789,
	                                                                                       0.0006884783);
	
	final_score_tree_125_c816 := map(
	    NULL <  (Integer)s_addrchangevaluediff_d AND (Integer)s_addrchangevaluediff_d < -16078 => -0.0603407722,
	    (Integer)s_addrchangevaluediff_d >= -16078                                   => 0.0008494577,
	                                                                           final_score_tree_125_c817);
	
	final_score_tree_125_c819 := map(
	    NULL <  (Integer)s_curraddrmedianincome_d AND (Real)s_curraddrmedianincome_d < 77577.5 => 0.0140342771,
	    (Real)s_curraddrmedianincome_d >= 77577.5                                    => 0.1307412147,
	                                                                              0.0537146359);
	
	final_score_tree_125_c818 := map(
	    NULL <  (Integer)s_c20_email_verification_d AND (Real)s_c20_email_verification_d < 0.5 => final_score_tree_125_c819,
	    (Real)s_c20_email_verification_d >= 0.5                                      => -0.0805168981,
	                                                                              0.0212915600);
	
	final_score_tree_125 := map(
	    NULL < (Integer)b_nae_contradictory_i AND (Real)b_nae_contradictory_i < 0.5 => final_score_tree_125_c816,
	    (Real)b_nae_contradictory_i >= 0.5                                 => final_score_tree_125_c818,
	                                                                    -0.0003234387);
	
	final_score_tree_126_c822 := map(
	    NULL <  (Integer)s_c13_curr_addr_lres_d AND (Real)s_c13_curr_addr_lres_d < 22.5 => -0.0745640510,
	    (Real)s_c13_curr_addr_lres_d >= 22.5                                  => 0.0223363561,
	                                                                       -0.0188824738);
	
	final_score_tree_126_c823 := map(
	    NULL <  (Integer)b_c20_email_count_i AND (Real)b_c20_email_count_i < 0.5 => 0.1377510833,
	    (Real)b_c20_email_count_i >= 0.5                               => 0.0093112198,
	                                                                0.0744108767);
	
	final_score_tree_126_c821 := map(
	    ST_cen_very_rich = ''                                                => 0.0294183389, 
	    NULL <  (Integer)ST_cen_very_rich AND (Integer)ST_cen_very_rich < 99 => final_score_tree_126_c822,
	    (Integer)ST_cen_very_rich >= 99                            => final_score_tree_126_c823,
	                                                         0.0294183389);
	
	final_score_tree_126_c824 := map(
	    ST_cen_easiqlife = ''                                               => 0.0012126020, 
	    NULL <  (Integer)ST_cen_easiqlife AND (Real)ST_cen_easiqlife < 82.5 => 0.0803427629,
	    (Real)ST_cen_easiqlife >= 82.5                            => -0.0154592901,
	                                                           0.0012126020);
	
	final_score_tree_126 := map(
	    NULL <  (Integer)b_estimated_income_d AND (Real)b_estimated_income_d < 9999.5 => final_score_tree_126_c821,
	    (Real)b_estimated_income_d >= 9999.5                                => 0.0033041290,
	                                                                     final_score_tree_126_c824);
	
	final_score_tree_127_c827 := map(
	    ip_routingmethod_n = ''                                                      => 0.0077401088,
	    NULL < (Integer) ip_routingmethod_n AND (Integer)ip_routingmethod_n < 8      => 0.1307098711,
	    (Integer)ip_routingmethod_n >= 8                                             => 0.0064311317,
	                                                                                    0.0077401088);
	
	final_score_tree_127_c826 := map(
	    NULL <  (Integer)btst_distaddraddr2_i AND (Real)btst_distaddraddr2_i < 9.5 => final_score_tree_127_c827,
	    (Real)btst_distaddraddr2_i >= 9.5                                => -0.0418576856,
	                                                                  0.0070214410);
	
	final_score_tree_127_c829 := map(
	    ST_cen_families = ''                                               => -0.0062440200, 
	    NULL <  (Integer)ST_cen_families AND (Real)ST_cen_families < 382.5 => 0.0225944844,
	    (Real)ST_cen_families >= 382.5                           => -0.0381744879,
	                                                          -0.0062440200);
	
	final_score_tree_127_c828 := map(
	    NULL <  (Integer)s_add_input_nhood_mfd_pct_i AND (Real)s_add_input_nhood_mfd_pct_i < 0.8810546775 => final_score_tree_127_c829,
	    (Real)s_add_input_nhood_mfd_pct_i >= 0.8810546775                                       => -0.1006433239,
	                                                                                         -0.0023227358);
	
	final_score_tree_127 := map(
	    NULL <  (Integer)s_addrchangevaluediff_d AND s_addrchangevaluediff_d < -16078 => -0.0472346314,
	    s_addrchangevaluediff_d >= -16078                                   => final_score_tree_127_c826,
	                                                                           final_score_tree_127_c828);
	
	final_score_tree_128_c832 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 65.5 => -0.0835279393,
	    btst_dist_inp_addr_to_ip_addr_i >= 65.5                                           => 0.0181090616,
	                                                                                         0.0072902974);
	
	final_score_tree_128_c834 := map(
	    BT_cen_families = ''                                               =>  0.0251365051, 
	    NULL <  (Integer)BT_cen_families AND (Real)bT_cen_families < 348.5 => -0.0284061275,
	    (Real)BT_cen_families >= 348.5                           => 0.0884952871,
	                                                          0.0251365051);
	
	final_score_tree_128_c833 := map(
	    NULL <  (Integer)b_add_input_mobility_index_i AND (Real)b_add_input_mobility_index_i < 0.2505152498 => -0.0689120890,
	    b_add_input_mobility_index_i >= 0.2505152498                                        => final_score_tree_128_c834,
	                                                                                           -0.0105217296);
	
	final_score_tree_128_c831 := map(
	    NULL <  (Integer)b_c12_source_profile_d AND (Real)b_c12_source_profile_d < 89.45 => final_score_tree_128_c832,
	    b_c12_source_profile_d >= 89.45                                  => 0.1470189970,
	                                                                        final_score_tree_128_c833);
	
	final_score_tree_128 := map(
	    ST_cen_high_ed = ''                                              => 0.0097555731,
	    NULL <  (Integer)ST_cen_high_ed AND (Real)ST_cen_high_ed < 62.85 => final_score_tree_128_c831,
	    (Real)ST_cen_high_ed >= 62.85                          => -0.0432482651,
	                                                        0.0097555731);
	
	final_score_tree_129_c838 := map(
	    NULL < (Integer) s_nae_email_verd_d AND (Real)s_nae_email_verd_d < 0.5 => 0.0768499490,
	    (Real)s_nae_email_verd_d >= 0.5                              => -0.0710297085,
	                                                              0.0271575944);
	
	final_score_tree_129_c837 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 1081 => 0.0050961573,
	    btst_dist_inp_addr_to_ip_addr_i >= 1081                                           => final_score_tree_129_c838,
	                                                                                         0.0136371839);
	
	final_score_tree_129_c836 := map(
	    NULL <  (Integer)b_comb_age_d AND (Real)b_comb_age_d < 61.5 => -0.0102671530,
	    b_comb_age_d >= 61.5                        => final_score_tree_129_c837,
	                                                   -0.0019328046);
	
	final_score_tree_129_c839 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 0.5 => 0.1092853197,
	    (Real)btst_email_first_score_d >= 0.5                                    => -0.0218576327,
	                                                                          0.0359995522);
	
	final_score_tree_129 := map(
	    NULL <  (Integer)s_l79_adls_per_addr_c6_i AND (Real)s_l79_adls_per_addr_c6_i < 5.5 => final_score_tree_129_c836,
	    (Real)s_l79_adls_per_addr_c6_i >= 5.5                                    => final_score_tree_129_c839,
	                                                                          -0.0060249660);
	
	final_score_tree_130_c843 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND btst_dist_inp_addr_to_ip_addr_i < 3547 => -0.0479831504,
	    btst_dist_inp_addr_to_ip_addr_i >= 3547                                           => 0.0704082653,
	                                                                                         -0.0287813586);
	
	final_score_tree_130_c842 := map(
	    NULL <  (Integer)b_a46_curr_avm_autoval_d AND (Integer)b_a46_curr_avm_autoval_d < 299898 => final_score_tree_130_c843,
	    b_a46_curr_avm_autoval_d >= 299898                                    => 0.0233610620,
	                                                                             -0.0020157577);
	
	final_score_tree_130_c841 := map(
	    NULL <  (Integer)s_a49_curr_avm_chg_1yr_pct_i AND (Real)s_a49_curr_avm_chg_1yr_pct_i < 129.9 => final_score_tree_130_c842,
	    (Real)s_a49_curr_avm_chg_1yr_pct_i >= 129.9                                        => -0.0834544115,
	                                                                                    -0.0298380055);
	
	final_score_tree_130_c844 := map(
	    NULL <  (Integer)s_mos_liens_unrel_ft_fseen_d AND (Real)s_mos_liens_unrel_ft_fseen_d < 274.5 => -0.1144776903,
	    (Real)s_mos_liens_unrel_ft_fseen_d >= 274.5                                        => 0.0241635856,
	                                                                                    0.0094631267);
	
	final_score_tree_130 := map(
	    BT_cen_vacant_p  = ''                                              => -0.0148406329,
	    NULL <  (Integer)BT_cen_vacant_p  AND (Real)BT_cen_vacant_p < 7.15 => final_score_tree_130_c841,
	    (Real)BT_cen_vacant_p >= 7.15                           => final_score_tree_130_c844,
	                                                         -0.0148406329);
	
	final_score_tree_131_c848 := map(
	    ST_cen_lar_fam = ''                                             =>  0.0119655271,  
	    NULL <  (Integer)ST_cen_lar_fam AND (Real)ST_cen_lar_fam < 99.5 => -0.0199909015,
	    (Real)ST_cen_lar_fam >= 99.5                          => 0.0807947578,
	                                                       0.0119655271);
	
	final_score_tree_131_c847 := map(
	    BT_cen_unemp = ''                                            => -0.0127107108, 
	    NULL <  (Integer)BT_cen_unemp AND  (Real)BT_cen_unemp < 4.85 => final_score_tree_131_c848,
	    (Real)BT_cen_unemp >= 4.85                        => -0.0617658825,
	                                                    -0.0127107108);
	
	final_score_tree_131_c849 := map(
	    NULL <  (Integer)btst_addr_match_d AND (Real)btst_addr_match_d < 0.5 => 0.0041931942,
	    (Real)btst_addr_match_d >= 0.5                             => 0.0651777747,
	                                                            0.0092015897);
	
	final_score_tree_131_c846 := map(
	     BT_cen_lar_fam = ''                                              => final_score_tree_131_c849,
	    NULL <  (Integer)BT_cen_lar_fam  AND (Real)BT_cen_lar_fam < 134.5 => final_score_tree_131_c847,
	    (Real)BT_cen_lar_fam >= 134.5                          => 0.0876864330,
	                                                        final_score_tree_131_c849);
	
	final_score_tree_131 := map(
	    NULL <  (Integer)s_c14_addr_stability_v2_d AND (Real)s_c14_addr_stability_v2_d < 1.5 => -0.0612887677,
	    (Real)s_c14_addr_stability_v2_d >= 1.5                                     => 0.0008599444,
	                                                                            final_score_tree_131_c846);
	
	final_score_tree_132_c854 := map(
	    ST_cen_high_ed = ''                                                      => 0.0650063760,
	    NULL <  (Integer)ST_cen_high_ed AND (Real)ST_cen_high_ed < 33.8          => 0.1155956184,
	    (Real)ST_cen_high_ed >= 33.8                                             => 0.0149035687,
	                                                                                0.0650063760);
	
	final_score_tree_132_c853 := map(
	    NULL <  (Integer)b_nap_lname_verd_d AND (Real)b_nap_lname_verd_d < 0.5 => final_score_tree_132_c854,
	    (Real)b_nap_lname_verd_d >= 0.5                              => -0.0038608415,
	                                                              0.0204589908);
	
	final_score_tree_132_c852 := map(
	    NULL <  (Integer)b_add_input_mobility_index_i AND (Real)b_add_input_mobility_index_i < 0.546600251 => final_score_tree_132_c853,
	    b_add_input_mobility_index_i >= 0.546600251                                        => -0.0919692175,
	                                                                                          0.0001729630);
	
	final_score_tree_132_c851 := map(
	    NULL <  (Integer)b_rel_homeover150_count_d AND (Real)b_rel_homeover150_count_d < 7.5 => -0.0210871250,
	    b_rel_homeover150_count_d >= 7.5                                     => 0.0198583512,
	                                                                            final_score_tree_132_c852);
	
	final_score_tree_132 := map(
	    NULL <  (Integer)s_add_input_nhood_vac_pct_i AND (Real)s_add_input_nhood_vac_pct_i < 1.6294385599 => final_score_tree_132_c851,
	    (Real)s_add_input_nhood_vac_pct_i >= 1.6294385599                                       => 0.1235507272,
	                                                                                         -0.0030219902);
	
	final_score_tree_133_c857 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 6444.5 => -0.0148549444,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 6444.5                                           => -0.0498324350,
	                                                                                           -0.0202755398);
	
	final_score_tree_133_c859 := map(
	    BT_cen_med_rent = ''                                                => 0.0240967025, 
	    NULL <  (Integer)BT_cen_med_rent AND  (Real)BT_cen_med_rent < 804.5 => 0.0957838362,
	    (Real)BT_cen_med_rent >= 804.5                           => -0.0218387424,
	                                                          0.0240967025);
	
	final_score_tree_133_c858 := map(
	    ST_cen_blue_col = ''                                               => -0.0023860539, 
	    NULL <  (Integer)ST_cen_blue_col AND (Real)ST_cen_blue_col < 12.65 => final_score_tree_133_c859,
	    (Real)ST_cen_blue_col >= 12.65                           => -0.0761856454,
	                                                          -0.0023860539);
	
	final_score_tree_133_c856 := map(
	    NULL <  (Integer)s_estimated_income_d AND (Integer)s_estimated_income_d < 44500 => final_score_tree_133_c857,
	    (Integer)s_estimated_income_d >= 44500                                => 0.0141104611,
	                                                                    final_score_tree_133_c858);
	
	final_score_tree_133 := map(
	    NULL <  (Integer)ip_non_us_time_zone_i AND (Real)ip_non_us_time_zone_i < 0.5 => final_score_tree_133_c856,
	    (Real)ip_non_us_time_zone_i >= 0.5                                 => -0.0796262074,
	                                                                    0.0017135426);
	
	final_score_tree_134_c863 := map(
	    NULL <  (Integer)b_rel_criminal_count_i AND (Real)b_rel_criminal_count_i < 2.5 => 0.0133406292,
	    (Real)b_rel_criminal_count_i >= 2.5                                  => -0.0308336943,
	                                                                      -0.0095883725);
	
	final_score_tree_134_c862 := map(
	    ST_cen_span_lang = ''                                                => -0.0035268998,
	    NULL <  (Integer)ST_cen_span_lang AND (Real)ST_cen_span_lang < 189.5 => final_score_tree_134_c863,
	    (Real)ST_cen_span_lang >= 189.5                            => -0.0729011029,
	                                                            -0.0035268998);
	
	final_score_tree_134_c864 := map(
	    ST_cen_high_ed = ''                                              => 0.0630309472,
	    NULL <  (Integer)ST_cen_high_ed AND (Real)ST_cen_high_ed < 31.55 => 0.1478661475,
	    (Real)ST_cen_high_ed >= 31.55                          => -0.0161485730,
	                                                        0.0630309472);
	
	final_score_tree_134_c861 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 10684.5 => final_score_tree_134_c862,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 10684.5                                           => final_score_tree_134_c864,
	                                                                                            0.0108729924);
	
	final_score_tree_134 := map(
	    ip_routingmethod_n = ''                                                   => 0.0000212282, 
	    NULL < (Integer) ip_routingmethod_n AND (Real)ip_routingmethod_n < 10.5   => 0.0746213780,
	   (Real) ip_routingmethod_n >= 10.5                                          => final_score_tree_134_c861,
	                                                                                 0.0000212282);
	
	final_score_tree_135_c869 := map(
	     ST_cen_incollege = ''                                              =>  0.0129042822, 
	    NULL <  (Integer)ST_cen_incollege AND (Real)ST_cen_incollege < 10.9 => -0.0081432803,
	    (Real)ST_cen_incollege >= 10.9                            => 0.1522008772,
	                                                           0.0129042822);
	
	final_score_tree_135_c868 := map(
	    BT_cen_families = ''                                                =>  -0.0038001929,
	    NULL <  (Integer)BT_cen_families AND  (Real)BT_cen_families < 263.5 => -0.0530901579,
	    (Real)BT_cen_families >= 263.5                           => final_score_tree_135_c869,
	                                                          -0.0038001929);
	
	final_score_tree_135_c867 := map(
	    ST_cen_med_rent = ''                                                =>  0.0044365850,
	    NULL <  (Integer)ST_cen_med_rent AND (Integer)ST_cen_med_rent < 517 => 0.0693437161,
	    (Integer)ST_cen_med_rent >= 517                           => final_score_tree_135_c868,
	                                                        0.0044365850);
	
	final_score_tree_135_c866 := map(
	    NULL <  (Integer)s_crim_rel_under500miles_cnt_i AND (Real)s_crim_rel_under500miles_cnt_i < 4.5 => 0.0006201229,
	    (Real)s_crim_rel_under500miles_cnt_i >= 4.5                                          => -0.0522863285,
	                                                                                      final_score_tree_135_c867);
	
	final_score_tree_135 := map(
	    NULL <  (Integer)s_inq_per_addr_i AND (Real)s_inq_per_addr_i < 21.5 => final_score_tree_135_c866,
	    (Real)s_inq_per_addr_i >= 21.5                            => -0.1699488071,
	                                                           -0.0047663542);
	
	final_score_tree_136_c873 := map(
	    ST_cen_lar_fam = ''                                                 => 0.0613121840,
	    NULL <  (Integer)ST_cen_lar_fam AND (Integer)ST_cen_lar_fam < 82    => 0.1129418294,
	    (Integer)ST_cen_lar_fam >= 82                                       => 0.0182874795,
	                                                                           0.0613121840);
	
	final_score_tree_136_c872 := map(
	    BT_cen_business = ''                                                =>  0.0203865139,
	    NULL <  (Integer)BT_cen_business AND  (Real)BT_cen_business < 10.5  => -0.0448573081,
	    (Real)BT_cen_business >= 10.5                                       => final_score_tree_136_c873,
	                                                                            0.0203865139);
	
	final_score_tree_136_c874 := map(
	    NULL <  (Integer)btst_addr_match_d AND (Real)btst_addr_match_d < 0.5 => -0.0063604675,
	    (Real)btst_addr_match_d >= 0.5                             => 0.0665275874,
	                                                            -0.0001425291);
	
	final_score_tree_136_c871 := map(
	    BT_cen_business = ''                                                   => final_score_tree_136_c874,
	    NULL <  (Integer)BT_cen_business AND  (Real)BT_cen_business < 36.5     => final_score_tree_136_c872,
	    (Real)BT_cen_business >= 36.5                                          => -0.0435675639,
	                                                                              final_score_tree_136_c874);
	
	final_score_tree_136 := map(
	    NULL <  (Integer)b_srchfraudsrchcountwk_i AND (Real)b_srchfraudsrchcountwk_i < 0.5 => -0.0000752682,
	    (Real)b_srchfraudsrchcountwk_i >= 0.5                                    => 0.2046644983,
	                                                                          final_score_tree_136_c871);
	
	final_score_tree_137_c879 := map(
	    NULL <  (Integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => 0.0325908805,
	    (Real)b_adl_per_email_i >= 0.5                             => -0.0061083599,
	                                                            0.0127218074);
	
	final_score_tree_137_c878 := map(
	    NULL <  (Integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 0.5 => final_score_tree_137_c879,
	    (Real)b_c20_email_verification_d >= 0.5                                      => -0.0131860941,
	                                                                              -0.0036368614);
	
	final_score_tree_137_c877 := map(
	    ST_cen_span_lang  = ''                                                    => -0.0065802111,
	    NULL <  (Integer)ST_cen_span_lang AND (Real)ST_cen_span_lang < 186.5      => final_score_tree_137_c878,
	    (Real)ST_cen_span_lang >= 186.5                                           => -0.0568555251,
	                                                                                 -0.0065802111);
	
	final_score_tree_137_c876 := map(
	    NULL <  (Integer)s_mos_liens_unrel_ot_fseen_d AND (Real)s_mos_liens_unrel_ot_fseen_d < 63.5 => 0.1654865872,
	    (Real)s_mos_liens_unrel_ot_fseen_d >= 63.5                                        => final_score_tree_137_c877,
	                                                                                   -0.0045617352);
	
	final_score_tree_137 := map(
	    NULL <  (Integer)b_addrchangevaluediff_d AND (Integer)b_addrchangevaluediff_d < -105465 => 0.0852533775,
	    (Integer)b_addrchangevaluediff_d >= -105465                                   => final_score_tree_137_c876,
	                                                                            0.0009992218);
	
	final_score_tree_138_c882 := map(
	    NULL <  (Integer)b_add_input_mobility_index_i AND (Real)b_add_input_mobility_index_i < 0.2606578977 => 0.0130206665,
	    (Real)b_add_input_mobility_index_i >= 0.2606578977                                        => -0.0217016230,
	                                                                                           -0.0055453862);
	
	final_score_tree_138_c884 := map(
	    NULL <  (Integer)s_add_input_nhood_bus_pct_i AND (Real)s_add_input_nhood_bus_pct_i < 0.05684977265 => -0.0368660808,
	    (Real)s_add_input_nhood_bus_pct_i >= 0.05684977265                                       => 0.0136354792,
	                                                                                          -0.0116153008);
	
	final_score_tree_138_c883 := map(
	    NULL <  (Integer)s_curraddrmedianincome_d AND (Real)s_curraddrmedianincome_d < 45656.5 => 0.1326257430,
	    (Real)s_curraddrmedianincome_d >= 45656.5                                    => final_score_tree_138_c884,
	                                                                              0.0271360244);
	
	final_score_tree_138_c881 := map(
	    NULL <  (Integer)s_l79_adls_per_addr_c6_i AND (Real)s_l79_adls_per_addr_c6_i < 4.5 => final_score_tree_138_c882,
	    (Real)s_l79_adls_per_addr_c6_i >= 4.5                                    => final_score_tree_138_c883,
	                                                                          -0.0016154559);
	
	final_score_tree_138 := map(
	    (ip_continent_n in ['AFRICA', 'AUSTRALIA', 'EUROPE', 'S AMERICA']) => -0.0785201630,
	    (ip_continent_n in ['ASIA', 'N AMERICA', 'Other'])                 => final_score_tree_138_c881,
	                                                                          -0.0023114261);
	
	final_score_tree_139_c889 := map(
	    NULL <  (Integer)s_curraddrcrimeindex_i AND (Integer)s_curraddrcrimeindex_i < 46 => 0.0916337071,
	    (Integer)s_curraddrcrimeindex_i >= 46                                  => -0.0811757351,
	                                                                     0.0055875119);
	
	final_score_tree_139_c888 := map(
	    ST_cen_retired2 = ''                                               => 0.0651509498, 
	    NULL <  (Integer)ST_cen_retired2 AND (Real)ST_cen_retired2 < 114.5 => final_score_tree_139_c889,
	    (Real)ST_cen_retired2 >= 114.5                                     => 0.1567580094,
	                                                                          0.0651509498);
	
	final_score_tree_139_c887 := map(
	    NULL <  (Integer)b_c14_addrs_15yr_i AND (Real)b_c14_addrs_15yr_i < 0.5 => final_score_tree_139_c888,
	    (Real)b_c14_addrs_15yr_i >= 0.5                              => 0.0040473000,
	                                                              0.0143911064);
	
	final_score_tree_139_c886 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 371.5 => -0.0068808334,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 371.5                                           => final_score_tree_139_c887,
	                                                                                          0.0051852029);
	
	final_score_tree_139 := map(
	    BT_cen_business = ''                                               => 0.0044826136,
	    NULL <  (Integer)BT_cen_business AND  (Real)BT_cen_business < 37.5 => final_score_tree_139_c886,
	    (Real)BT_cen_business >= 37.5                           => -0.0316100990,
	                                                         0.0044826136);
	
	final_score_tree_140_c892 := map(
	    NULL <  (Integer)b_prevaddrlenofres_d AND (Real)b_prevaddrlenofres_d < 42.5 => 0.1842091980,
	    (Real)b_prevaddrlenofres_d >= 42.5                                => 0.0209833756,
	                                                                   0.0699295601);
	
	final_score_tree_140_c891 := map(
	    NULL <  (Integer)s_curraddrburglaryindex_i AND (Real)s_curraddrburglaryindex_i < 107.5 => final_score_tree_140_c892,
	    (Real)s_curraddrburglaryindex_i >= 107.5                                     => -0.0459620797,
	                                                                              0.0363362049);
	
	final_score_tree_140_c894 := map(
	    BT_cen_unemp = ''                                                     =>  0.0236516140,
	    NULL <  (Integer)BT_cen_unemp  AND (Real)BT_cen_unemp < 4.85          =>  0.0602774911,
	    (Real)BT_cen_unemp >= 4.85                                            => -0.0427715869,
	                                                                              0.0236516140);
	
	final_score_tree_140_c893 := map(
	    ST_cen_health = ''                                                    => -0.0073803593,
	    NULL <  (Integer)ST_cen_health AND (Real)ST_cen_health < 10.35        => final_score_tree_140_c894,
	    (Real)ST_cen_health >= 10.35                                          => -0.0656716345,
	                                                                             -0.0073803593);
	
	final_score_tree_140 := map(
	    NULL <  (Integer)b_i60_inq_retpymt_recency_d AND (Integer)b_i60_inq_retpymt_recency_d < 549 => final_score_tree_140_c891,
	    (Integer)b_i60_inq_retpymt_recency_d >= 549                                       => -0.0099781827,
	                                                                                final_score_tree_140_c893);
	
	final_score_tree_141_c899 := map(
	    NULL <  (Integer)b_l78_no_phone_at_addr_vel_i AND (Real)b_l78_no_phone_at_addr_vel_i < 0.5 => 0.0449490406,
	   (Real)b_l78_no_phone_at_addr_vel_i >= 0.5                                        => 0.0061089939,
	                                                                                  0.0193859486);
	
	final_score_tree_141_c898 := map(
	    (ip_topleveldomain_lvl_n in ['DOT', 'EDU', 'ORG', 'TWO'])      => -0.0448913059,
	    (ip_topleveldomain_lvl_n in ['-1', 'COM', 'GOV', 'NET', 'US']) => final_score_tree_141_c899,
	                                                                      0.0049112997);
	
	final_score_tree_141_c897 := map(
	    (ip_connection_n in ['BROADBAND', 'MOBILE', 'SATELLITE', 'XDSL'])      => final_score_tree_141_c898,
	    (ip_connection_n in ['-1', 'CABLE', 'DIALUP', 'T1', 'T3', 'WIRELESS']) => 0.0658039316,
	                                                                              0.0271605306);
	
	final_score_tree_141_c896 := map(
	    NULL < (Integer)btst_email_first_score_d AND (Real)btst_email_first_score_d < 0.5 => final_score_tree_141_c897,
	    (Real)btst_email_first_score_d >= 0.5                                    => -0.0098486470,
	                                                                          0.0069957927);
	
	final_score_tree_141 := map(
	    NULL <  (Integer)s_inq_auto_count24_i AND (Real)s_inq_auto_count24_i < 1.5 => 0.0053568174,
	    (Real)s_inq_auto_count24_i >= 1.5                                => -0.0502274422,
	                                                                  final_score_tree_141_c896);
	
	final_score_tree_142_c902 := map(
	    NULL <  (Integer)s_srchvelocityrisktype_i AND (Integer)s_srchvelocityrisktype_i < 3 => 0.0069028153,
	    (Integer)s_srchvelocityrisktype_i >= 3                                    => 0.1380472672,
	                                                                        0.0538667068);
	
	final_score_tree_142_c904 := map(
	    BT_cen_high_ed = ''                                                 =>  0.0183745314,
	    NULL <  (Integer)BT_cen_high_ed AND  (Real)BT_cen_high_ed < 44.75   => -0.0081765689,
	    (Real)BT_cen_high_ed >= 44.75                                       =>  0.0787652694,
	                                                                            0.0183745314);
	
	final_score_tree_142_c903 := map(
	    NULL <  (Integer)s_add_input_nhood_bus_pct_i AND (Real)s_add_input_nhood_bus_pct_i < 0.01160499365 => -0.0866320951,
	    (Real)s_add_input_nhood_bus_pct_i >= 0.01160499365                                       => final_score_tree_142_c904,
	                                                                                          0.0073251029);
	
	final_score_tree_142_c901 := map(
	    NULL <  (Integer)b_i60_inq_prepaidcards_recency_d AND (Integer)b_i60_inq_prepaidcards_recency_d < 549 => final_score_tree_142_c902,
	    (Integer)b_i60_inq_prepaidcards_recency_d >= 549                                            => -0.0033894224,
	                                                                                          final_score_tree_142_c903);
	
	final_score_tree_142 := map(
	    NULL <  (Integer)s_l77_add_po_box_i AND (Real)s_l77_add_po_box_i < 0.5 => final_score_tree_142_c901,
	    (Real)s_l77_add_po_box_i >= 0.5                              => -0.0528709432,
	                                                              -0.0025526758);
	
	final_score_tree_143_c908 := map(
	    BT_cen_lar_fam = ''                                              =>  0.0478820158,
	    NULL <  (Integer)BT_cen_lar_fam  AND (Real)BT_cen_lar_fam < 97.5 => -0.0374730903,
	    (Real)BT_cen_lar_fam >= 97.5                          => 0.1519085513,
	                                                       0.0478820158);
	
	final_score_tree_143_c909 := map(
	    NULL <  (Integer)b_mos_acc_lseen_d AND (Real)b_mos_acc_lseen_d < 19.5 => 0.1611107289,
	    (Real)b_mos_acc_lseen_d >= 19.5                             => -0.0050490990,
	                                                             -0.0002338891);
	
	final_score_tree_143_c907 := map(
	    NULL <  (Integer)b_addrchangecrimediff_i AND (Real)b_addrchangecrimediff_i < 21.5 => 0.0010834151,
	    (Real)b_addrchangecrimediff_i >= 21.5                                   => final_score_tree_143_c908,
	                                                                         final_score_tree_143_c909);
	
	final_score_tree_143_c906 := map(
	    NULL <  (Integer)s_inq_per_addr_i AND (Real)s_inq_per_addr_i < 15.5 => final_score_tree_143_c907,
	    (Real)s_inq_per_addr_i >= 15.5                            => -0.0896158642,
	                                                           0.0012711815);
	
	final_score_tree_143 := map(
	    ip_routingmethod_n = ''                                                  => 0.0022821256,
	    NULL < (Integer) ip_routingmethod_n AND (Integer)ip_routingmethod_n < 8  => 0.0957944587,
	    (Integer)ip_routingmethod_n >= 8                                         => final_score_tree_143_c906,
	                                                                                0.0022821256);
	
	final_score_tree_144_c914 := map(
	    NULL <  (Integer)s_comb_age_d AND (Real)s_comb_age_d < 36.5  => 0.0077161957,
	    (Real)s_comb_age_d >= 36.5                                   => 0.0545346763,
	                                                                    0.0341459831);
	
	final_score_tree_144_c913 := map(
	    NULL <  (Integer)s_rel_homeover300_count_d AND (Real)s_rel_homeover300_count_d < 9.5 => final_score_tree_144_c914,
	    (Real)s_rel_homeover300_count_d >= 9.5                                     => -0.0758589491,
	                                                                            0.0381752765);
	
	final_score_tree_144_c912 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 426.5 => -0.0030011936,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 426.5                                           => final_score_tree_144_c913,
	                                                                                          0.0129647609);
	
	final_score_tree_144_c911 := map(
	    ST_cen_retired2 = ''                                               => -0.0020731996,
	    NULL <  (Integer)ST_cen_retired2 AND (Real)ST_cen_retired2 < 118.5 => -0.0091813159,
	    (Real)ST_cen_retired2 >= 118.5                           => final_score_tree_144_c912,
	                                                          -0.0020731996);
	
	final_score_tree_144 := map(
	    BT_cen_rental = ''                                              =>  -0.0027352873,
	    NULL <  (Integer)BT_cen_rental  AND (Real)BT_cen_rental < 197.5 => final_score_tree_144_c911,
	    (Real)BT_cen_rental >= 197.5                         => 0.1217773734,
	                                                      -0.0027352873);
	
	final_score_tree_145_c917 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 627.5 => -0.0402982833,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 627.5                                           => 0.0176690491,
	                                                                                          -0.0136012969);
	
	final_score_tree_145_c919 := map(
	    ST_cen_high_hval = ''                                                     => -0.0018902131,
	    NULL <  (Integer)ST_cen_high_hval AND (Real)ST_cen_high_hval < 15.35      => -0.0278382123,
	    (Real)ST_cen_high_hval >= 15.35                                           =>  0.0885274560,
	                                                                                 -0.0018902131);
	
	final_score_tree_145_c918 := map(
	    NULL <  (Integer)b_l79_adls_per_addr_c6_i AND (Real)b_l79_adls_per_addr_c6_i < 0.5 => final_score_tree_145_c919,
	    (Real)b_l79_adls_per_addr_c6_i >= 0.5                                    => -0.0639803667,
	                                                                          -0.0046284718);
	
	final_score_tree_145_c916 := map(
	    NULL <  (Integer)b_prevaddrdwelltype_sfd_n AND (Real)b_prevaddrdwelltype_sfd_n < 0.5 => -0.0351920667,
	    (Real)b_prevaddrdwelltype_sfd_n >= 0.5                                     => final_score_tree_145_c917,
	                                                                            final_score_tree_145_c918);
	
	final_score_tree_145 := map(
	    NULL <  (Integer)btst_lastscore_d AND (Real)btst_lastscore_d < 80.5 => 0.0813687213,
	    (Real)btst_lastscore_d >= 80.5                            => final_score_tree_145_c916,
	                                                           -0.0151971404);
	
	final_score_tree_146_c924 := map(
	    NULL <  (Integer)s_c18_invalid_addrs_per_adl_i AND (Real)s_c18_invalid_addrs_per_adl_i < 2.5 => 0.1810511286,
	    (Real)s_c18_invalid_addrs_per_adl_i >= 2.5                                         => 0.0586567827,
	                                                                                    0.1299334900);
	
	final_score_tree_146_c923 := map(
	    NULL <  (Integer)b_comb_age_d AND (Real)b_comb_age_d < 39.5 => 0.0495612371,
	    (Real)b_comb_age_d >= 39.5                        => final_score_tree_146_c924,
	                                                   0.0967902929);
	
	final_score_tree_146_c922 := map(
	    (ip_connection_n in ['BROADBAND', 'DIALUP', 'MOBILE', 'SATELLITE', 'T1', 'WIRELESS']) => -0.0032882660,
	    (ip_connection_n in ['-1', 'CABLE', 'T3', 'XDSL'])                                    => final_score_tree_146_c923,
	                                                                                             0.0173494029);
	
	final_score_tree_146_c921 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 2071.5 => -0.0225129292,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 2071.5                                           => final_score_tree_146_c922,
	                                                                                           -0.0116539330);
	
	final_score_tree_146 := map(
	    NULL <  (Integer)b_addrchangevaluediff_d AND (Real)b_addrchangevaluediff_d < 101720.5 => final_score_tree_146_c921,
	    (Real)b_addrchangevaluediff_d >= 101720.5                                   => -0.0545589261,
	                                                                             -0.0015112647);
	
	final_score_tree_147_c929 := map(
	    ST_cen_easiqlife = ''                                                      => -0.0163972732,
	    NULL <  (Integer)ST_cen_easiqlife AND (Integer)ST_cen_easiqlife < 107      =>  0.0293201099,
	    (Integer)ST_cen_easiqlife >= 107                                           => -0.0677587777,
	                                                                                  -0.0163972732);
	
	final_score_tree_147_c928 := map(
	    BT_cen_no_move = ''                                                        => -0.0093729206,
	    NULL <  (Integer)BT_cen_no_move  AND (Real)BT_cen_no_move < 28.5           =>  0.0743781659,
	    (Real)BT_cen_no_move >= 28.5                                               => final_score_tree_147_c929,
	                                                                                  -0.0093729206);
	
	final_score_tree_147_c927 := map(
	    NULL <  (Integer)s_varrisktype_i AND (Real)s_varrisktype_i < 5.5 => 0.0071977423,
	    (Real)s_varrisktype_i >= 5.5                           => 0.1079732615,
	                                                        final_score_tree_147_c928);
	
	final_score_tree_147_c926 := map(
	    NULL <  (Integer)b_add_input_nhood_vac_pct_i AND (Real)b_add_input_nhood_vac_pct_i < 0.53460770745 => final_score_tree_147_c927,
	    (Real)b_add_input_nhood_vac_pct_i >= 0.53460770745                                       => -0.0728160662,
	                                                                                          0.0042264020);
	
	final_score_tree_147 := map(
	    (ip_dma_lvl_n in ['1. Missing DMA', '3. DMA: 0', '4. DMA: US Code', '5. DMA: Unkown']) => final_score_tree_147_c926,
	    (ip_dma_lvl_n in ['2. DMA: -1'])                                                       => 0.0642483907,
	                                                                                              0.0048271980);
	
	final_score_tree_148_c932 := map(
	    NULL <  (Integer)b_c18_invalid_addrs_per_adl_i AND (Real)b_c18_invalid_addrs_per_adl_i < 0.5 => 0.2425910956,
	    (Real)b_c18_invalid_addrs_per_adl_i >= 0.5                                         => -0.0157851689,
	                                                                                    0.0946320381);
	
	final_score_tree_148_c933 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 6707 => 0.0132145090,
	    (Integer)btst_dist_inp_addr_to_ip_addr_i >= 6707                                           => -0.0349586523,
	                                                                                         0.0088727219);
	
	final_score_tree_148_c934 := map(
	    BT_cen_med_rent = ''                                                       =>  0.0299256295,
	    NULL <  (Integer)BT_cen_med_rent AND (Integer)BT_cen_med_rent < 815        => -0.0273091628,
	    (Integer)BT_cen_med_rent >= 815                                            =>  0.0731437380,
	                                                                                   0.0299256295);
	
	final_score_tree_148_c931 := map(
	    NULL <  (Integer)b_i60_inq_prepaidcards_recency_d AND (Integer)b_i60_inq_prepaidcards_recency_d < 549 => final_score_tree_148_c932,
	    (Integer)b_i60_inq_prepaidcards_recency_d >= 549                                            => final_score_tree_148_c933,
	                                                                                          final_score_tree_148_c934);
	
	final_score_tree_148 := map(
	    ST_cen_trailer = ''                                                         => -0.0183854522,
	    NULL <  (Integer)ST_cen_trailer AND (Integer)ST_cen_trailer < 85            => final_score_tree_148_c931,
	    (Integer)ST_cen_trailer >= 85                                               => -0.0166863926,
	                                                                                   -0.0183854522);
	
	final_score_tree_149_c936 := map(
	    (ip_continent_n in ['AFRICA', 'ASIA', 'AUSTRALIA', 'EUROPE']) => -0.1039927940,
	    (ip_continent_n in ['N AMERICA', 'Other', 'S AMERICA'])       => -0.0107995157,
	                                                                     -0.0118634126);
	
	final_score_tree_149_c939 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 771.5 => -0.0020473364,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 771.5                                           => 0.0320694228,
	                                                                                          0.0049820993);
	
	final_score_tree_149_c938 := map(
	    BT_cen_med_hval = ''                                                  => -0.0125588141,
	    NULL <  (Integer)BT_cen_med_hval AND (Real)BT_cen_med_hval < 998958.5 => final_score_tree_149_c939,
	    (Real)BT_cen_med_hval >= 998958.5                                     =>  0.1300008842,
	                                                                             -0.0125588141);
	
	final_score_tree_149_c937 := map(
	    (ip_topleveldomain_lvl_n in ['-1', 'COM', 'GOV', 'NET'])        => final_score_tree_149_c938,
	    (ip_topleveldomain_lvl_n in ['DOT', 'EDU', 'ORG', 'TWO', 'US']) => 0.1033569849,
	                                                                       0.0086797030);
	
	final_score_tree_149 := map(
	    (ip_connection_n in ['BROADBAND', 'DIALUP', 'MOBILE', 'SATELLITE', 'T3', 'WIRELESS', 'XDSL']) => final_score_tree_149_c936,
	    (ip_connection_n in ['-1', 'CABLE', 'T1'])                                                    => final_score_tree_149_c937,
	                                                                                                     -0.0041509417);
	
	final_score_tree_150_c942 := map(
	    NULL <  (Integer)b_curraddrcartheftindex_i AND (Real)b_curraddrcartheftindex_i < 168.5 => -0.0103230123,          
	    (Real)b_curraddrcartheftindex_i >= 168.5                                               =>  0.0438174373,
	                                                                                              -0.0056072308);
	
	final_score_tree_150_c941 := map(
	    NULL <  (Integer)btst_distaddraddr2_i AND (Real)btst_distaddraddr2_i < 17.5 => final_score_tree_150_c942,
	    (Real)btst_distaddraddr2_i >= 17.5                                          => -0.0703760382,
	                                                                                   -0.0066040037);                    
	
	final_score_tree_150_c944 := map(
	    ip_routingmethod_n = ''                                                       => -0.0366097346,
	    NULL < (Integer) ip_routingmethod_n AND (Real)ip_routingmethod_n < 13.5       => -0.0827793117,
	   (Real) ip_routingmethod_n >= 13.5                                              =>  0.0156705219,
	                                                                                     -0.0366097346);
	
	final_score_tree_150_c943 := map(
	    ST_cen_high_ed  = ''                                                          => 0.0011800073,                                         
	    NULL <  (Integer)ST_cen_high_ed AND (Real)ST_cen_high_ed < 32.4               => 0.0383019824,
	    (Real)ST_cen_high_ed >= 32.4                                                  => final_score_tree_150_c944,
	                                                                                     0.0011800073);
	
	final_score_tree_150 := map(
	    NULL <  (Integer)b_inq_collection_count24_i AND (Real)b_inq_collection_count24_i < 1.5    => final_score_tree_150_c941,
	    (Real)b_inq_collection_count24_i >= 1.5                                                   => -0.0751379197,
	                                                                                                 final_score_tree_150_c943);
	
	final_score_tree_151_c947 := map(
	    NULL <  (Integer)s_c20_email_verification_d AND (Real)s_c20_email_verification_d < 0.5 => -0.1117025151,
	    (Real)s_c20_email_verification_d >= 0.5                                      => -0.0611637262,
	                                                                              -0.0783278432);
	
	final_score_tree_151_c946 := map(
	    NULL <  (Integer)b_add_input_nhood_sfd_pct_d AND (Real)b_add_input_nhood_sfd_pct_d < 0.37031864405 => final_score_tree_151_c947,
	    (Real)b_add_input_nhood_sfd_pct_d >= 0.37031864405                                       => -0.0177151167,
	                                                                                          -0.0434149127);
	
	final_score_tree_151_c949 := map(
	    NULL <  (Integer)b_curraddrmedianincome_d AND (Real)b_curraddrmedianincome_d < 183562.5 => 0.0022511155,
	    (Real)b_curraddrmedianincome_d >= 183562.5                                    => 0.1557921995,
	                                                                               -0.0237881769);
	
	final_score_tree_151_c948 := map(
	    ST_cen_med_hhinc = ''                                                   => 0.0098543357,
	    NULL <  (Integer)ST_cen_med_hhinc AND (Integer)ST_cen_med_hhinc < 21796 => 0.0950696593,
	    (Integer)ST_cen_med_hhinc >= 21796                                      => final_score_tree_151_c949,
	                                                                               0.0098543357);
	
	final_score_tree_151 := map(
	    (btst_email_topleveldomain_n in ['BIZ', 'EDU', 'ORG', 'OTH', 'US']) => final_score_tree_151_c946,
	    (btst_email_topleveldomain_n in ['COM', 'GOV', 'MIL', 'NET'])       => final_score_tree_151_c948,
	                                                                           0.0024954695);
	
	final_score_tree_152_c953 := map(
	    BT_cen_incollege = ''                                               => -0.0128674212,
	    NULL <  (Integer)BT_cen_incollege AND (Real)BT_cen_incollege < 6.95 => 0.0416607600,
	    (Real)BT_cen_incollege >= 6.95                            => -0.0892068750,
	                                                           -0.0128674212);
	
	final_score_tree_152_c954 := map(
	    NULL <  (Integer)b_curraddrburglaryindex_i AND (Real)b_curraddrburglaryindex_i < 90.5 => 0.1366138381,
	    (Real)b_curraddrburglaryindex_i >= 90.5                                     => 0.0075253844,
	                                                                             0.0750856966);
	
	final_score_tree_152_c952 := map(
	    BT_cen_rental = ''                                              => 0.0287945819,
	    NULL <  (Integer)BT_cen_rental AND (Integer)BT_cen_rental < 125 => final_score_tree_152_c953,
	    (Integer)BT_cen_rental >= 125                         => final_score_tree_152_c954,
	                                                    0.0287945819);
	
	final_score_tree_152_c951 := map(
	    NULL <  (Integer)b_f01_inp_addr_not_verified_i AND (Real)b_f01_inp_addr_not_verified_i < 0.5 => -0.0031155470,
	    (Real)b_f01_inp_addr_not_verified_i >= 0.5                                         => final_score_tree_152_c952,
	                                                                                    -0.0094303766);
	
	final_score_tree_152 := map(
	    ST_cen_families = ''                                               =>  0.0098573395,
	    NULL <  (Integer)ST_cen_families AND (Integer)ST_cen_families < 72 => -0.1075796927,
	    (Integer)ST_cen_families >= 72                                     => final_score_tree_152_c951,
	                                                                          0.0098573395);
	
	final_score_tree_153_c958 := map(
	    ST_cen_blue_col = ''                                              => 0.0432988096,
	    NULL <  (Integer)ST_cen_blue_col AND (Real)ST_cen_blue_col < 6.75 => -0.0341541826,
	    (Real)ST_cen_blue_col >= 6.75                           => 0.0825486367,
	                                                         0.0432988096);
	
	final_score_tree_153_c957 := map(
	    NULL <  (Integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5 => final_score_tree_153_c958,
	    (Real)s_nap_lname_verd_d >= 0.5                              => -0.0181062687,
	                                                              -0.0078027830);
	
	final_score_tree_153_c959 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Integer)btst_dist_inp_addr_to_ip_addr_i < 1163 => 0.0029442252,
	    (Integer)btst_dist_inp_addr_to_ip_addr_i >= 1163                                           => -0.1091311382,
	                                                                                         -0.0385171809);
	
	final_score_tree_153_c956 := map(
	    BT_cen_span_lang = ''                                                => -0.0148368913,
	    NULL <  (Integer)BT_cen_span_lang AND (Real)BT_cen_span_lang < 172.5 => final_score_tree_153_c957,
	    (Real)BT_cen_span_lang >= 172.5                                      => final_score_tree_153_c959,
	                                                                            -0.0148368913);
	
	final_score_tree_153 := map(
	    NULL <  (Integer)b_add_curr_nhood_mfd_pct_i AND (Real)b_add_curr_nhood_mfd_pct_i < 0.98062404785 => 0.0064433843,
	    (Real)b_add_curr_nhood_mfd_pct_i >= 0.98062404785                                      => 0.1338171016,
	                                                                                        final_score_tree_153_c956);
	
	final_score_tree_154_c961 := map(
	    NULL <  (Integer)b_l80_inp_avm_autoval_d AND (Real)b_l80_inp_avm_autoval_d < 103794.5 => 0.0603154269,
	    (Real)b_l80_inp_avm_autoval_d >= 103794.5                                   => 0.0196613971,
	                                                                             -0.0075759909);
	
	final_score_tree_154_c963 := map(
	    NULL <  (Integer)s_add_input_mobility_index_i AND (Real)s_add_input_mobility_index_i < 0.2510130621 => -0.0265917971,
	    (Real)s_add_input_mobility_index_i >= 0.2510130621                                        => 0.0944915363,
	                                                                                           0.0322835852);
	
	final_score_tree_154_c964 := map(
	     ST_cen_high_ed = ''                                                        => -0.0353690911,
	    NULL <  (Integer)ST_cen_high_ed AND (Real)ST_cen_high_ed < 27.65            => -0.0952439397,
	    (Real)ST_cen_high_ed >= 27.65                                               => -0.0039196757,
	                                                                                   -0.0353690911);
	
	final_score_tree_154_c962 := map(
	    NULL <  (Integer)s_add_input_nhood_bus_pct_i AND (Real)s_add_input_nhood_bus_pct_i < 0.0269081868 => final_score_tree_154_c963,
	    (Real)s_add_input_nhood_bus_pct_i >= 0.0269081868                                       => final_score_tree_154_c964,
	                                                                                         0.0028740035);
	
	final_score_tree_154 := map(
	    NULL <  (Integer)s_l70_inp_addr_dirty_i AND (Real)s_l70_inp_addr_dirty_i < 0.5 => final_score_tree_154_c961,
	    (Real)s_l70_inp_addr_dirty_i >= 0.5                                  => -0.1050969415,
	                                                                      final_score_tree_154_c962);
	
	final_score_tree_155_c966 := map(
	    BT_cen_med_hhinc = ''                                                  => -0.0078932748, 
	    NULL <  (Integer)BT_cen_med_hhinc AND (Real)BT_cen_med_hhinc < 30287.5 => -0.0804620058,
	    (Real)BT_cen_med_hhinc >= 30287.5                            => -0.0048281895,
	                                                              -0.0078932748);
	
	final_score_tree_155_c967 := map(
	    NULL <  (Integer)b_mos_liens_unrel_cj_lseen_d AND (Real)b_mos_liens_unrel_cj_lseen_d < 115.5 => 0.1763834436,
	    (Real)b_mos_liens_unrel_cj_lseen_d >= 115.5                                        => 0.0214078784,
	                                                                                    0.0309332058);
	
	final_score_tree_155_c969 := map(
	    (ip_dma_lvl_n in ['3. DMA: 0', '5. DMA: Unkown'])                     => -0.0259865133,
	    (ip_dma_lvl_n in ['1. Missing DMA', '2. DMA: -1', '4. DMA: US Code']) => 0.0420588646,
	                                                                             -0.0126614152);
	
	final_score_tree_155_c968 := map(
	    ST_cen_high_ed = ''                                              => final_score_tree_155_c969,
	    NULL <  (Integer)ST_cen_high_ed AND (Real)ST_cen_high_ed < 47.15 => -0.0370581816,
	    (Real)ST_cen_high_ed >= 47.15                                    =>  0.0379094964,
	                                                                        final_score_tree_155_c969);
	
	final_score_tree_155 := map(
	    NULL <  (Integer)s_c14_addrs_10yr_i AND (Real)s_c14_addrs_10yr_i < 3.5 => final_score_tree_155_c966,
	    (Real)s_c14_addrs_10yr_i >= 3.5                              => final_score_tree_155_c967,
	                                                              final_score_tree_155_c968);
	
	final_score_tree_156_c971 := map(
	    BT_cen_easiqlife = ''                                                 =>  0.1056075910,
			NULL <  (Integer)BT_cen_easiqlife AND (Integer)BT_cen_easiqlife < 124 =>  0.2186159564,
	    (Integer)BT_cen_easiqlife >= 124                                      => -0.0156195645,
	                                                                              0.1056075910);
	
	final_score_tree_156_c974 := map(
	    ST_cen_health = ''                                            => 0.0016883037,
			NULL <  (Integer)ST_cen_health AND (Real)ST_cen_health < 9.55 => 0.0631374975,
	    (Real)ST_cen_health >= 9.55                         => -0.0435451306,
	                                                     0.0016883037);
	
	final_score_tree_156_c973 := map(
	    BT_cen_health = ''                                            =>  -0.0276222261,
	    NULL <  (Integer)BT_cen_health AND (Real)BT_cen_health < 2.85 => -0.0994617599,
	    (Real)BT_cen_health >= 2.85                         => final_score_tree_156_c974,
	                                                     -0.0276222261);
	
	final_score_tree_156_c972 := map(
	    ST_cen_totcrime = ''                                                => 0.0075981137,
	    NULL <  (Integer)ST_cen_totcrime AND (Integer)ST_cen_totcrime < 121 => final_score_tree_156_c973,
	    (Integer)ST_cen_totcrime >= 121                                     => 0.0444984580,
	                                                                           0.0075981137);
	
	final_score_tree_156 := map(
	    NULL <  (Integer)b_mos_foreclosure_lseen_d AND (Integer)b_mos_foreclosure_lseen_d < 90 => final_score_tree_156_c971,
	    (Integer)b_mos_foreclosure_lseen_d >= 90                                     => -0.0042722663,
	                                                                           final_score_tree_156_c972);
	
	final_score_tree_157_c979 := map(
	    NULL <  (Integer)b_phones_per_addr_curr_i AND (Real)b_phones_per_addr_curr_i < 6.5 => -0.0343963878,
	    (Real)b_phones_per_addr_curr_i >= 6.5                                    => -0.1137323209,
	                                                                          -0.0469409584);
	
	final_score_tree_157_c978 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 585.5 => 0.0969414117,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 585.5                                           => final_score_tree_157_c979,
	                                                                                          -0.0317954458);
	
	final_score_tree_157_c977 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5 => final_score_tree_157_c978,
	    (Real)btst_email_last_score_d >= 0.5                                   => 0.0042258596,
	                                                                        -0.0102126386);
	
	final_score_tree_157_c976 := map(
	    (ip_connection_n in ['DIALUP', 'MOBILE', 'SATELLITE', 'T1', 'T3'])    => final_score_tree_157_c977,
	    (ip_connection_n in ['-1', 'BROADBAND', 'CABLE', 'WIRELESS', 'XDSL']) => 0.0027603137,
	                                                                             0.0001479695);
	
	final_score_tree_157 := map(
	    NULL <  (Integer)b_l79_adls_per_addr_c6_i AND (Real)b_l79_adls_per_addr_c6_i < 6.5 => final_score_tree_157_c976,
	    (Real)b_l79_adls_per_addr_c6_i >= 6.5                                    => 0.0746713149,
	                                                                          0.0012752478);
	
	final_score_tree_158_c982 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 9041.5 => 0.0014611581,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 9041.5                                           => -0.0795293662,
	                                                                                           -0.0020684034);
	
	final_score_tree_158_c981 := map(
	    NULL <  (Integer)b_addrchangeincomediff_d AND (Real)b_addrchangeincomediff_d < 14733.5 => final_score_tree_158_c982,
	    (Real)b_addrchangeincomediff_d >= 14733.5                                    => -0.0768103110,
	                                                                              -0.0013610268);
	
	final_score_tree_158_c984 := map(
	    NULL <  (Integer)b_add_curr_mobility_index_i AND (Real)b_add_curr_mobility_index_i < 0.32347007625 => 0.0168450915,
	    (REal)b_add_curr_mobility_index_i >= 0.32347007625                                       => 0.1384307082,
	                                                                                          0.0426632718);
	
	final_score_tree_158_c983 := map(
	    NULL <  (Integer)b_prevaddrmurderindex_i AND (Integer)b_prevaddrmurderindex_i < 129 => final_score_tree_158_c984,
	    (Integer)b_prevaddrmurderindex_i >= 129                                   => -0.0394176264,
	                                                                        0.0252455372);
	
	final_score_tree_158 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'EDU', 'GOV', 'NET', 'ORG', 'US']) => final_score_tree_158_c981,
	    (ip_topleveldomain_lvl_n in ['-1', 'DOT', 'TWO'])                      => final_score_tree_158_c983,
	                                                                              -0.0007377781);
	
	final_score_tree_159_c989 := map(
	    BT_cen_unemp = ''                                             =>  0.0298521224,
	    NULL <  (Integer)BT_cen_unemp AND (Real)BT_cen_unemp < 5.25   =>  0.0649964372,
	    (Real)BT_cen_unemp >= 5.25                                    => -0.0793802072,
	                                                                      0.0298521224);
	
	final_score_tree_159_c988 := map(
	    NULL <  (Integer)b_curraddrmedianvalue_d AND (Integer)b_curraddrmedianvalue_d < 354557 => final_score_tree_159_c989,
	    (Integer)b_curraddrmedianvalue_d >= 354557                                   => 0.1703733997,
	                                                                           0.0629774856);
	
	final_score_tree_159_c987 := map(
	    NULL <  (Integer)s_a44_curr_add_naprop_d AND (Real)s_a44_curr_add_naprop_d < 0.5 => -0.0781714610,
	    (Real)s_a44_curr_add_naprop_d >= 0.5                                   => final_score_tree_159_c988,
	                                                                        0.0426424679);
	
	final_score_tree_159_c986 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 1394.5 => -0.0012674276,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 1394.5                                           => final_score_tree_159_c987,
	                                                                                           0.0072205274);
	
	final_score_tree_159 := map(
	    (ip_connection_n in ['BROADBAND', 'DIALUP', 'MOBILE', 'SATELLITE', 'T1', 'T3']) => -0.0177343184,
	    (ip_connection_n in ['-1', 'CABLE', 'WIRELESS', 'XDSL'])                        => final_score_tree_159_c986,
	                                                                                       -0.0058772420);
	
	final_score_tree_160_c992 := map(
	    BT_cen_ownocc_p = ''                                               => -0.0385236292,
	    NULL <  (Integer)BT_cen_ownocc_p AND (Real)BT_cen_ownocc_p < 64.15 => -0.1155387971,
	    (Real)BT_cen_ownocc_p >= 64.15                                     =>  0.0059740234,
	                                                                          -0.0385236292);
	
	final_score_tree_160_c994 := map(
	    NULL < (Integer)btst_email_last_score_d AND (Real)btst_email_last_score_d < 0.5 => 0.0282203045,
	    (Real)btst_email_last_score_d >= 0.5                                   => -0.0051199175,
	                                                                        0.0073368688);
	
	final_score_tree_160_c993 := map(
	    ip_routingmethod_n = ''                                                       => 0.0166089833,
	    NULL < (Integer) ip_routingmethod_n AND (Integer)ip_routingmethod_n < 12      => 0.0618105416,
	    (Integer)ip_routingmethod_n >= 12                                             => final_score_tree_160_c994,
	                                                                                     0.0166089833);
	
	final_score_tree_160_c991 := map(
	    NULL <  (Integer)s_add_input_nhood_mfd_pct_i AND (Real)s_add_input_nhood_mfd_pct_i < 0.48095815755 => final_score_tree_160_c992,
	    (Real)s_add_input_nhood_mfd_pct_i >= 0.48095815755                                       => 0.0472359752,
	                                                                                          final_score_tree_160_c993);
	
	final_score_tree_160 := map(
	    NULL <  (Integer)s_inq_banking_count24_i AND (Real)s_inq_banking_count24_i < 2.5 => 0.0008074169,
	    (Real)s_inq_banking_count24_i >= 2.5                                   => -0.0943379033,
	                                                                        final_score_tree_160_c991);
	
	final_score_tree_161_c997 := map(
	    NULL <  (Integer)b_add_curr_nhood_sfd_pct_d AND (Real)b_add_curr_nhood_sfd_pct_d < 0.67752852735 => 0.0878508868,
	    (Real)b_add_curr_nhood_sfd_pct_d >= 0.67752852735                                      => -0.0873018858,
	                                                                                        -0.0071666304);
	
	final_score_tree_161_c998 := map(
	    NULL <  (Integer)b_adl_per_email_i AND (Real)b_adl_per_email_i < 0.5 => 0.1324707432,
	    (Real)b_adl_per_email_i >= 0.5                             => -0.0317548544,
	                                                            0.0617776052);
	
	final_score_tree_161_c996 := map(
	    NULL <  (Integer)s_crim_rel_under500miles_cnt_i AND (Real)s_crim_rel_under500miles_cnt_i < 0.5 => final_score_tree_161_c997,
	    (Real)s_crim_rel_under500miles_cnt_i >= 0.5                                          => final_score_tree_161_c998,
	                                                                                      0.0269664174);
	
	final_score_tree_161_c999 := map(
	    (ip_dma_lvl_n in ['5. DMA: Unkown'])                                               => -0.0217888522,
	    (ip_dma_lvl_n in ['1. Missing DMA', '2. DMA: -1', '3. DMA: 0', '4. DMA: US Code']) => 0.0223485863,
	                                                                                          -0.0076596869);
	
	final_score_tree_161 := map(
	    BT_cen_easiqlife = ''                                               => final_score_tree_161_c999,
	    NULL <  (Integer)BT_cen_easiqlife AND (Real)BT_cen_easiqlife < 56.5 => final_score_tree_161_c996,
	    (Real)BT_cen_easiqlife >= 56.5                            => -0.0070570135,
	                                                           final_score_tree_161_c999);
	
	final_score_tree_162_c1002 := map(
	    ST_cen_easiqlife = ''                                                => 0.0825677963,
	    NULL <  (Integer)ST_cen_easiqlife AND (Real)ST_cen_easiqlife < 138.5 => 0.0390852283,
	    (Real)ST_cen_easiqlife >= 138.5                                      => 0.1585091825,
	                                                                            0.0825677963);
	
	final_score_tree_162_c1001 := map(
	    NULL <  (Integer)s_fp_prevaddrburglaryindex_i AND (Real)s_fp_prevaddrburglaryindex_i < 24.5 => -0.0739602087,
	    (Real)s_fp_prevaddrburglaryindex_i >= 24.5                                        => final_score_tree_162_c1002,
	                                                                                   0.0481316352);
	
	final_score_tree_162_c1004 := map(
	    ST_cen_easiqlife = ''                                                    =>  0.0043708024,
	    NULL <  (Integer)ST_cen_easiqlife AND (Real)ST_cen_easiqlife < 119.5     => -0.0220585531,
	    (Real)ST_cen_easiqlife >= 119.5                                          =>  0.0368270389,
	                                                                                 0.0043708024);
	
	final_score_tree_162_c1003 := map(
	    BT_cen_med_hval = ''                                                  =>  0.0157240810,
	    NULL <  (Integer)BT_cen_med_hval AND (Real)BT_cen_med_hval < 757826.5 => final_score_tree_162_c1004,
	    (Real)BT_cen_med_hval >= 757826.5                                     => 0.1238069151,
	                                                                              0.0157240810);
	
	final_score_tree_162 := map(
	    NULL <  (Integer)s_addrchangecrimediff_i AND (Real)s_addrchangecrimediff_i < 2.5 => 0.0050354829,
	    (Real)s_addrchangecrimediff_i >= 2.5                                   => final_score_tree_162_c1001,
	                                                                        final_score_tree_162_c1003);
	
	final_score_tree_163_c1006 := map(
	    NULL <  (Integer)s_a41_prop_owner_d AND (Real)s_a41_prop_owner_d < 0.5 => 0.2230007760,
	    (Real)s_a41_prop_owner_d >= 0.5                              => 0.0189673596,
	                                                              0.0956607715);
	
	final_score_tree_163_c1008 := map(
	    NULL <  (Integer)s_add_input_nhood_bus_pct_i AND (Real)s_add_input_nhood_bus_pct_i < 0.0700030023 => -0.0608965348,
	    (Real)s_add_input_nhood_bus_pct_i >= 0.0700030023                                       => -0.0214571706,
	                                                                                         -0.0432746912);
	
	final_score_tree_163_c1009 := map(
	    NULL <  (Integer)b_add_input_mobility_index_i AND (Real)b_add_input_mobility_index_i < 0.26490702785 => -0.0131283470,
	    (Real)b_add_input_mobility_index_i >= 0.26490702785                                        => 0.0722296981,
	                                                                                            0.0275563287);
	
	final_score_tree_163_c1007 := map(
	    BT_cen_lar_fam = ''                                                   => -0.0103905842,
	    NULL <  (Integer)BT_cen_lar_fam AND (Real)BT_cen_lar_fam < 103.5      => final_score_tree_163_c1008,
	    (Real)BT_cen_lar_fam >= 103.5                                         => final_score_tree_163_c1009,
	                                                                             -0.0103905842);
	
	final_score_tree_163 := map(
	    NULL <  (Integer)b_i60_inq_hiriskcred_count12_i AND (Real)b_i60_inq_hiriskcred_count12_i < 0.5  => -0.0051852092,
	    (Real)b_i60_inq_hiriskcred_count12_i >= 0.5                                                     => final_score_tree_163_c1006,
	                                                                                                       final_score_tree_163_c1007);
	
	final_score_tree_164_c1014 := map(
	    NULL <  (Integer)b_srchunvrfdphonecount_i AND (Real)b_srchunvrfdphonecount_i < 0.5 => -0.0134484622,
	    (Real)b_srchunvrfdphonecount_i >= 0.5                                    => 0.1209205221,
	                                                                          0.0187196737);
	
	final_score_tree_164_c1013 := map(
	    ST_cen_business = ''                                                   => 0.0358670344,
	    NULL <  (Integer)ST_cen_business AND (Real)ST_cen_business < 5.5       => 0.1766732466,
	    (Real)ST_cen_business >= 5.5                                           => final_score_tree_164_c1014,
	                                                                              0.0358670344);
	
	final_score_tree_164_c1012 := map(
	    NULL <  (Integer)b_add_input_nhood_mfd_pct_i AND (Real)b_add_input_nhood_mfd_pct_i < 0.7415285859 => -0.0049715517,
	    (Real)b_add_input_nhood_mfd_pct_i >= 0.7415285859                                       => final_score_tree_164_c1013,
	                                                                                         -0.0146284472);
	
	final_score_tree_164_c1011 := map(
	    (btst_email_topleveldomain_n in ['BIZ', 'COM', 'EDU', 'GOV', 'MIL', 'NET', 'ORG']) => final_score_tree_164_c1012,
	    (btst_email_topleveldomain_n in ['OTH', 'US'])                                     => 0.0887523651,
	                                                                                          -0.0029707314);
	
	final_score_tree_164 := map(
	    BT_cen_low_hval = ''                                               => -0.0052072007,
	    NULL <  (Integer)BT_cen_low_hval AND (Real)BT_cen_low_hval < 68.75 => final_score_tree_164_c1011,
	    (Real)BT_cen_low_hval >= 68.75                                     =>  0.1383116126,
	                                                                          -0.0052072007);
	
	final_score_tree_165_c1017 := map(
	    NULL <  (Integer)b_add_curr_nhood_vac_pct_i AND (Real)b_add_curr_nhood_vac_pct_i < 0.0202837018 => -0.0148089164,
	    (Real)b_add_curr_nhood_vac_pct_i >= 0.0202837018                                      => 0.0813947161,
	                                                                                       0.0237666232);
	
	final_score_tree_165_c1016 := map(
	    NULL <  (Integer)b_rel_under500miles_cnt_d AND (Real)b_rel_under500miles_cnt_d < 33.5 => -0.0058052696,
	    (Real)b_rel_under500miles_cnt_d >= 33.5                                     => 0.1260892303,
	                                                                             final_score_tree_165_c1017);
	
	final_score_tree_165_c1019 := map(
	    BT_cen_very_rich = ''                                                =>  0.0166624902,
	    NULL <  (Integer)BT_cen_very_rich AND (Real)BT_cen_very_rich < 121.5 =>  0.0640276960,
	    (Real)BT_cen_very_rich >= 121.5                                      => -0.0259661951,
	                                                                             0.0166624902);
	
	final_score_tree_165_c1018 := map(
	    BT_cen_blue_col = ''                                               =>  -0.0057774569,
	    NULL <  (Integer)BT_cen_blue_col AND (Real)BT_cen_blue_col < 13.05 => final_score_tree_165_c1019,
	    (Real)BT_cen_blue_col >= 13.05                                     =>  -0.0649097728,
	                                                                           -0.0057774569);
	
	final_score_tree_165 := map(
	    NULL <  (Integer)b_inq_retail_count24_i AND (Real)b_inq_retail_count24_i < 2.5 => final_score_tree_165_c1016,
	    (Real)b_inq_retail_count24_i >= 2.5                                  => 0.1278182001,
	                                                                      final_score_tree_165_c1018);
	
	final_score_tree_166_c1021 := map(
	    NULL <  (Integer)s_rel_incomeover75_count_d AND (Real)s_rel_incomeover75_count_d < 3.5 => 0.1678765269,
	    (Real)s_rel_incomeover75_count_d >= 3.5                                      => -0.0467224016,
	                                                                              0.0630723990);
	
	final_score_tree_166_c1023 := map(
	    BT_cen_health = ''                                            => 0.0056816521,
	    NULL <  (Integer)BT_cen_health AND (Real)BT_cen_health < 0.55 => -0.0696928971,
	    (Real)BT_cen_health >= 0.55                                   => 0.0254334165,
	                                                                     0.0056816521);
	
	final_score_tree_166_c1024 := map(
	    NULL <  (Integer)btst_addr_match_d AND (Real)btst_addr_match_d < 0.5 => 0.0071274740,
	    (Real)btst_addr_match_d >= 0.5                             => 0.0827678710,
	                                                            0.0144362854);
	
	final_score_tree_166_c1022 := map(
	    ST_cen_med_rent = ''                                                => final_score_tree_166_c1024,
	    NULL <  (Integer)ST_cen_med_rent AND (Integer)ST_cen_med_rent < 517 => 0.1197393395,
	    (Integer)ST_cen_med_rent >= 517                                     => final_score_tree_166_c1023,
	                                                                           final_score_tree_166_c1024);
	
	final_score_tree_166 := map(
	    NULL <  (Integer)s_add_curr_nhood_bus_pct_i AND (Real)s_add_curr_nhood_bus_pct_i < 0.31789395695 => -0.0055995830,
	    (Real)s_add_curr_nhood_bus_pct_i >= 0.31789395695                                      => final_score_tree_166_c1021,
	                                                                                        final_score_tree_166_c1022);
	
	final_score_tree_167_c1029 := map(
	    NULL <  (Integer)s_c20_email_verification_d AND (Real)s_c20_email_verification_d < 0.5 => -0.0724251131,
	    (Real)s_c20_email_verification_d >= 0.5                                      => -0.0046786814,
	                                                                              -0.0286859121);
	
	final_score_tree_167_c1028 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'ORG', 'TWO'])      => final_score_tree_167_c1029,
	    (ip_topleveldomain_lvl_n in ['-1', 'EDU', 'GOV', 'NET', 'US']) => 0.0164108741,
	                                                                      -0.0129876637);
	
	final_score_tree_167_c1027 := map(
	    (ip_connection_n in ['BROADBAND', 'XDSL'])                                                    => final_score_tree_167_c1028,
	    (ip_connection_n in ['-1', 'CABLE', 'DIALUP', 'MOBILE', 'SATELLITE', 'T1', 'T3', 'WIRELESS']) => 0.0185122327,
	                                                                                                     0.0001661392);
	
	final_score_tree_167_c1026 := map(
	    ip_routingmethod_n = ''                                                                       => 0.0078935437,
	    NULL < (Integer) ip_routingmethod_n AND (Integer)ip_routingmethod_n < 12                      => 0.0484624174,
	    (Integer)ip_routingmethod_n >= 12                                                             => final_score_tree_167_c1027,
	                                                                                                     0.0078935437);
	
	final_score_tree_167 := map( 
	    NULL <  (Integer)btst_distaddraddr2_i AND (Real)btst_distaddraddr2_i < 16.5             =>  0.0023701086,
	    (Real)btst_distaddraddr2_i >= 16.5                                                      => -0.0863372163,
	                                                                                               final_score_tree_167_c1026);
	
	final_score_tree_168_c1031 := map(
	    ST_cen_business = ''                                              => -0.0010337254,
	    NULL <  (Integer)ST_cen_business AND (Real)ST_cen_business < 41.5 =>  0.0102221033,
	    (Real)ST_cen_business >= 41.5                                     => -0.0237767407,
	                                                                         -0.0010337254);
	
	final_score_tree_168_c1034 := map(
	    BT_cen_high_ed = ''                                             => 0.0616922687,
	    NULL <  (Integer)BT_cen_high_ed AND (Real)BT_cen_high_ed < 27.5 => 0.0204899012,
	    (Real)BT_cen_high_ed >= 27.5                          => 0.0990319141,
	                                                       0.0616922687);
	
	final_score_tree_168_c1033 := map(
	    NULL <  (Integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5 => final_score_tree_168_c1034,
	    (Real)s_nap_lname_verd_d >= 0.5                              => -0.0525311085,
	                                                              0.0204776480);
	
	final_score_tree_168_c1032 := map(
	    ST_cen_blue_col = ''                                    => 0.0073699592,
	    NULL <  (Integer)ST_cen_blue_col AND (Real)ST_cen_blue_col < 5.55 => -0.0693635496,
	    (Real)ST_cen_blue_col >= 5.55                           => final_score_tree_168_c1033,
	                                                         0.0073699592);
	
	final_score_tree_168 := map(
	    NULL <  (Integer)s_fp_prevaddrcrimeindex_i AND (Real)s_fp_prevaddrcrimeindex_i < 194.5 => final_score_tree_168_c1031,
	    (Real)s_fp_prevaddrcrimeindex_i >= 194.5                                     => -0.1267494612,
	                                                                              final_score_tree_168_c1032);
	
	final_score_tree_169_c1039 := map(
	    NULL <  (Integer)s_nap_lname_verd_d AND (Real)s_nap_lname_verd_d < 0.5 => 0.1067138654,
	    (Real)s_nap_lname_verd_d >= 0.5                              => 0.0320834190,
	                                                              0.0600096506);
	
	final_score_tree_169_c1038 := map(
	    NULL <  (Integer)b_c23_inp_addr_occ_index_d AND (Real)b_c23_inp_addr_occ_index_d < 3.5 => 0.0136296164,
	    (Real)b_c23_inp_addr_occ_index_d >= 3.5                                      => final_score_tree_169_c1039,
	                                                                              0.0159943879);
	
	final_score_tree_169_c1037 := map(
	    NULL <  (Integer)b_prevaddrcartheftindex_i AND (Real)b_prevaddrcartheftindex_i < 171.5 => final_score_tree_169_c1038,
	    (Real)b_prevaddrcartheftindex_i >= 171.5                                     => -0.0645646826,
	                                                                              0.0117293483);
	
	final_score_tree_169_c1036 := map(
	    NULL <  (Integer)s_add_curr_nhood_sfd_pct_d AND (Real)s_add_curr_nhood_sfd_pct_d < 0.07197962715 => 0.1183247418,
	    (Real)s_add_curr_nhood_sfd_pct_d >= 0.07197962715                                      => final_score_tree_169_c1037,
	                                                                                        0.0374959871);
	
	final_score_tree_169 := map(
	    BT_cen_lar_fam = ''                                             => -0.0107683704,
	    NULL <  (Integer)BT_cen_lar_fam AND (Real)BT_cen_lar_fam < 99.5 => -0.0171189359,
	    (Real)BT_cen_lar_fam >= 99.5                          => final_score_tree_169_c1036,
	                                                       -0.0107683704);
	
	final_score_tree_170_c1044 := map(
	    NULL <  (Integer)s_add_curr_nhood_bus_pct_i AND (Real)s_add_curr_nhood_bus_pct_i < 0.0432457287 => 0.0321347803,
	    (Real)s_add_curr_nhood_bus_pct_i >= 0.0432457287                                      => -0.0646634420,
	                                                                                       -0.0219807613);
	
	final_score_tree_170_c1043 := map(
	    NULL <  (Integer)s_c18_invalid_addrs_per_adl_i AND (Real)s_c18_invalid_addrs_per_adl_i < 2.5 => final_score_tree_170_c1044,
	    (Real)s_c18_invalid_addrs_per_adl_i >= 2.5                                         => 0.2027800866,
	                                                                                    0.0411543083);
	
	final_score_tree_170_c1042 := map(
	    BT_cen_med_hhinc = ''                                                   => -0.0400406127,
	    NULL <  (Integer)BT_cen_med_hhinc AND (Integer)BT_cen_med_hhinc < 38432 => final_score_tree_170_c1043,
	    (Integer)BT_cen_med_hhinc >= 38432                            => -0.0494683335,
	                                                            -0.0400406127);
	
	final_score_tree_170_c1041 := map(
	    NULL <  (Integer)b_i60_inq_retpymt_recency_d AND (Integer)b_i60_inq_retpymt_recency_d < 549 => 0.0362037304,
	    (Integer)b_i60_inq_retpymt_recency_d >= 549                                       => final_score_tree_170_c1042,
	                                                                                -0.0230119368);
	
	final_score_tree_170 := map(
	    (ip_topleveldomain_lvl_n in ['COM', 'DOT', 'EDU', 'GOV', 'ORG', 'TWO']) => final_score_tree_170_c1041,
	    (ip_topleveldomain_lvl_n in ['-1', 'NET', 'US'])                        => 0.0133825980,
	                                                                               -0.0004938790);
	
	final_score_tree_171_c1049 := map(
	    NULL <  (Integer)b_curraddrmedianvalue_d AND (Integer)b_curraddrmedianvalue_d < 383568 => 0.0036975101,
	    (Integer)b_curraddrmedianvalue_d >= 383568                                             => 0.0464454549,
	                                                                                              0.0144035293);
	
	final_score_tree_171_c1048 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 97.5 => -0.0463840812,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 97.5                                                     => final_score_tree_171_c1049,
	                                                                                                          0.0033904789);
	
	final_score_tree_171_c1047 := map(
	    NULL <  (Integer)b_d34_unrel_liens_ct_i AND (Real)b_d34_unrel_liens_ct_i < 0.5 => final_score_tree_171_c1048,
	    (REal)b_d34_unrel_liens_ct_i >= 0.5                                  => -0.0354828144,
	                                                                      -0.0000159473);
	
	final_score_tree_171_c1046 := map(
	    ip_routingmethod_n = ''                                                               => -0.0010168744,  
	    NULL < (Integer) ip_routingmethod_n AND (Integer)ip_routingmethod_n < 4               =>  0.0662769245,
	    (Integer)ip_routingmethod_n >= 4                                                      => final_score_tree_171_c1047,
	                                                                                             -0.0010168744);
	
	final_score_tree_171 := map(
	    (ip_dma_lvl_n in ['4. DMA: US Code', '5. DMA: Unkown'])         => final_score_tree_171_c1046,
	    (ip_dma_lvl_n in ['1. Missing DMA', '2. DMA: -1', '3. DMA: 0']) => 0.0486520480,
	                                                                       -0.0002132363);
	
	final_score_tree_172_c1053 := map(
	    NULL <  (Integer)b_rel_under25miles_cnt_d AND (Real)b_rel_under25miles_cnt_d < 5.5 => -0.0064117136,
	    (Real)b_rel_under25miles_cnt_d >= 5.5                                    => -0.0911300119,
	                                                                          -0.0711616670);
	
	final_score_tree_172_c1052 := map(
	    NULL <  (Integer)b_c20_email_verification_d AND (Real)b_c20_email_verification_d < 2.5 => final_score_tree_172_c1053,
	    (Real)b_c20_email_verification_d >= 2.5                                      => 0.0379862222,
	                                                                              -0.0188212233);
	
	final_score_tree_172_c1051 := map(
	    NULL <  (Integer)s_estimated_income_d AND (Integer)s_estimated_income_d < 27500 => final_score_tree_172_c1052,
	    (Integer)s_estimated_income_d >= 27500                                => 0.0052990884,
	                                                                    -0.0083030886);
	
	final_score_tree_172_c1054 := map(
	    NULL <  (Integer)s_prevaddrageoldest_d AND (Real)s_prevaddrageoldest_d < 65.5 => 0.0169135730,
	    (Real)s_prevaddrageoldest_d >= 65.5                                 => 0.1345425843,
	                                                                     0.0757280786);
	
	final_score_tree_172 := map(
	    NULL <  (Integer)btst_dist_inp_addr_to_ip_addr_i AND (Real)btst_dist_inp_addr_to_ip_addr_i < 10745.5 => final_score_tree_172_c1051,
	    (Real)btst_dist_inp_addr_to_ip_addr_i >= 10745.5                                           => final_score_tree_172_c1054,
	                                                                                            -0.0088250604);
	
	final_score_gbm_logit := final_score_tree_0 +
	    final_score_tree_1 +
	    final_score_tree_2 +
	    final_score_tree_3 +
	    final_score_tree_4 +
	    final_score_tree_5 +
	    final_score_tree_6 +
	    final_score_tree_7 +
	    final_score_tree_8 +
	    final_score_tree_9 +
	    final_score_tree_10 +
	    final_score_tree_11 +
	    final_score_tree_12 +
	    final_score_tree_13 +
	    final_score_tree_14 +
	    final_score_tree_15 +
	    final_score_tree_16 +
	    final_score_tree_17 +
	    final_score_tree_18 +
	    final_score_tree_19 +
	    final_score_tree_20 +
	    final_score_tree_21 +
	    final_score_tree_22 +
	    final_score_tree_23 +
	    final_score_tree_24 +
	    final_score_tree_25 +
	    final_score_tree_26 +
	    final_score_tree_27 +
	    final_score_tree_28 +
	    final_score_tree_29 +
	    final_score_tree_30 +
	    final_score_tree_31 +
	    final_score_tree_32 +
	    final_score_tree_33 +
	    final_score_tree_34 +
	    final_score_tree_35 +
	    final_score_tree_36 +
	    final_score_tree_37 +
	    final_score_tree_38 +
	    final_score_tree_39 +
	    final_score_tree_40 +
	    final_score_tree_41 +
	    final_score_tree_42 +
	    final_score_tree_43 +
	    final_score_tree_44 +
	    final_score_tree_45 +
	    final_score_tree_46 +
	    final_score_tree_47 +
	    final_score_tree_48 +
	    final_score_tree_49 +
	    final_score_tree_50 +
	    final_score_tree_51 +
	    final_score_tree_52 +
	    final_score_tree_53 +
	    final_score_tree_54 +
	    final_score_tree_55 +
	    final_score_tree_56 +
	    final_score_tree_57 +
	    final_score_tree_58 +
	    final_score_tree_59 +
	    final_score_tree_60 +
	    final_score_tree_61 +
	    final_score_tree_62 +
	    final_score_tree_63 +
	    final_score_tree_64 +
	    final_score_tree_65 +
	    final_score_tree_66 +
	    final_score_tree_67 +
	    final_score_tree_68 +
	    final_score_tree_69 +
	    final_score_tree_70 +
	    final_score_tree_71 +
	    final_score_tree_72 +
	    final_score_tree_73 +
	    final_score_tree_74 +
	    final_score_tree_75 +
	    final_score_tree_76 +
	    final_score_tree_77 +
	    final_score_tree_78 +
	    final_score_tree_79 +
	    final_score_tree_80 +
	    final_score_tree_81 +
	    final_score_tree_82 +
	    final_score_tree_83 +
	    final_score_tree_84 +
	    final_score_tree_85 +
	    final_score_tree_86 +
	    final_score_tree_87 +
	    final_score_tree_88 +
	    final_score_tree_89 +
	    final_score_tree_90 +
	    final_score_tree_91 +
	    final_score_tree_92 +
	    final_score_tree_93 +
	    final_score_tree_94 +
	    final_score_tree_95 +
	    final_score_tree_96 +
	    final_score_tree_97 +
	    final_score_tree_98 +
	    final_score_tree_99 +
	    final_score_tree_100 +
	    final_score_tree_101 +
	    final_score_tree_102 +
	    final_score_tree_103 +
	    final_score_tree_104 +
	    final_score_tree_105 +
	    final_score_tree_106 +
	    final_score_tree_107 +
	    final_score_tree_108 +
	    final_score_tree_109 +
	    final_score_tree_110 +
	    final_score_tree_111 +
	    final_score_tree_112 +
	    final_score_tree_113 +
	    final_score_tree_114 +
	    final_score_tree_115 +
	    final_score_tree_116 +
	    final_score_tree_117 +
	    final_score_tree_118 +
	    final_score_tree_119 +
	    final_score_tree_120 +
	    final_score_tree_121 +
	    final_score_tree_122 +
	    final_score_tree_123 +
	    final_score_tree_124 +
	    final_score_tree_125 +
	    final_score_tree_126 +
	    final_score_tree_127 +
	    final_score_tree_128 +
	    final_score_tree_129 +
	    final_score_tree_130 +
	    final_score_tree_131 +
	    final_score_tree_132 +
	    final_score_tree_133 +
	    final_score_tree_134 +
	    final_score_tree_135 +
	    final_score_tree_136 +
	    final_score_tree_137 +
	    final_score_tree_138 +
	    final_score_tree_139 +
	    final_score_tree_140 +
	    final_score_tree_141 +
	    final_score_tree_142 +
	    final_score_tree_143 +
	    final_score_tree_144 +
	    final_score_tree_145 +
	    final_score_tree_146 +
	    final_score_tree_147 +
	    final_score_tree_148 +
	    final_score_tree_149 +
	    final_score_tree_150 +
	    final_score_tree_151 +
	    final_score_tree_152 +
	    final_score_tree_153 +
	    final_score_tree_154 +
	    final_score_tree_155 +
	    final_score_tree_156 +
	    final_score_tree_157 +
	    final_score_tree_158 +
	    final_score_tree_159 +
	    final_score_tree_160 +
	    final_score_tree_161 +
	    final_score_tree_162 +
	    final_score_tree_163 +
	    final_score_tree_164 +
	    final_score_tree_165 +
	    final_score_tree_166 +
	    final_score_tree_167 +
	    final_score_tree_168 +
	    final_score_tree_169 +
	    final_score_tree_170 +
	    final_score_tree_171 +
	    final_score_tree_172;
			
	pbr := 0.006410217;
	
	sbr := 0.100000000;
	
	offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));
	
	base := 700;
	
	pts := -50;
	
	lgt := ln(0.0064 / 0.9936);
	
	osn1608_1_0 := round(max((real)300, min(999, if(base + pts * (final_score_gbm_logit - offset - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score_gbm_logit - offset - lgt) / ln(2)))));
	


//*************************************************************************************//
//                   Finish the model by populating the output
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.seq := le.bs.Bill_To_Out.seq;
		SELF.truedid := truedid;
		SELF.out_st := out_st;
		SELF.out_lat := out_lat;
		SELF.out_long := out_long;
		SELF.in_dob := in_dob;
		SELF.in_email_address := in_email_address;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.nap_type := nap_type;
		SELF.rc_ssndod := rc_ssndod;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssndobflag := rc_ssndobflag;
		SELF.rc_pwssndobflag := rc_pwssndobflag;
		SELF.rc_ssnmiskeyflag := rc_ssnmiskeyflag;
		SELF.rc_addrmiskeyflag := rc_addrmiskeyflag;
		SELF.hdr_source_profile := hdr_source_profile;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_first_seen := ver_sources_first_seen;
		SELF.fnamepop := fnamepop;
		SELF.lnamepop := lnamepop;
		SELF.addrpop := addrpop;
		SELF.ssnlength := ssnlength;
		SELF.emailpop := emailpop;
		SELF.hphnpop := hphnpop;
		SELF.add_input_address_score := add_input_address_score;
		SELF.add_input_house_number_match := add_input_house_number_match;
		SELF.add_input_addr_not_verified := add_input_addr_not_verified;
		SELF.add_input_occ_index := add_input_occ_index;
		SELF.add_input_avm_auto_val := add_input_avm_auto_val;
		SELF.add_input_occupants_1yr := add_input_occupants_1yr;
		SELF.add_input_turnover_1yr_in := add_input_turnover_1yr_in;
		SELF.add_input_turnover_1yr_out := add_input_turnover_1yr_out;
		SELF.add_input_nhood_vac_prop := add_input_nhood_vac_prop;
		SELF.add_input_nhood_bus_ct := add_input_nhood_bus_ct;
		SELF.add_input_nhood_sfd_ct := add_input_nhood_sfd_ct;
		SELF.add_input_nhood_mfd_ct := add_input_nhood_mfd_ct;
		SELF.add_input_pop := add_input_pop;
		SELF.add_curr_lres := add_curr_lres;
		SELF.add_curr_avm_auto_val := add_curr_avm_auto_val;
		SELF.add_curr_avm_auto_val_2 := add_curr_avm_auto_val_2;
		SELF.add_curr_naprop := add_curr_naprop;
		SELF.add_curr_occupants_1yr := add_curr_occupants_1yr;
		SELF.add_curr_turnover_1yr_in := add_curr_turnover_1yr_in;
		SELF.add_curr_turnover_1yr_out := add_curr_turnover_1yr_out;
		SELF.add_curr_nhood_vac_prop := add_curr_nhood_vac_prop;
		SELF.add_curr_nhood_bus_ct := add_curr_nhood_bus_ct;
		SELF.add_curr_nhood_sfd_ct := add_curr_nhood_sfd_ct;
		SELF.add_curr_nhood_mfd_ct := add_curr_nhood_mfd_ct;
		SELF.add_curr_pop := add_curr_pop;
		SELF.max_lres := max_lres;
		SELF.addrs_15yr := addrs_15yr;
		SELF.addrs_prison_history := addrs_prison_history;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.phones_per_addr_curr := phones_per_addr_curr;
		SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
		SELF.lnames_per_adl_c6 := lnames_per_adl_c6;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.phones_per_addr_c6 := phones_per_addr_c6;
		SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
		SELF.invalid_addrs_per_adl := invalid_addrs_per_adl;
		SELF.inq_email_ver_count := inq_email_ver_count;
		SELF.inq_count := inq_count;
		SELF.inq_count01 := inq_count01;
		SELF.inq_count03 := inq_count03;
		SELF.inq_count06 := inq_count06;
		SELF.inq_count12 := inq_count12;
		SELF.inq_count24 := inq_count24;
		SELF.inq_auto_count := inq_auto_count;
		SELF.inq_auto_count01 := inq_auto_count01;
		SELF.inq_auto_count03 := inq_auto_count03;
		SELF.inq_auto_count06 := inq_auto_count06;
		SELF.inq_auto_count12 := inq_auto_count12;
		SELF.inq_auto_count24 := inq_auto_count24;
		SELF.inq_collection_count := inq_collection_count;
		SELF.inq_collection_count01 := inq_collection_count01;
		SELF.inq_collection_count03 := inq_collection_count03;
		SELF.inq_collection_count06 := inq_collection_count06;
		SELF.inq_collection_count12 := inq_collection_count12;
		SELF.inq_collection_count24 := inq_collection_count24;
		SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
		SELF.inq_prepaidcards_count := inq_prepaidcards_count;
		SELF.inq_prepaidcards_count01 := inq_prepaidcards_count01;
		SELF.inq_prepaidcards_count03 := inq_prepaidcards_count03;
		SELF.inq_prepaidcards_count06 := inq_prepaidcards_count06;
		SELF.inq_prepaidcards_count12 := inq_prepaidcards_count12;
		SELF.inq_prepaidcards_count24 := inq_prepaidcards_count24;
		SELF.inq_retail_count := inq_retail_count;
		SELF.inq_retail_count01 := inq_retail_count01;
		SELF.inq_retail_count03 := inq_retail_count03;
		SELF.inq_retail_count06 := inq_retail_count06;
		SELF.inq_retail_count12 := inq_retail_count12;
		SELF.inq_retail_count24 := inq_retail_count24;
		SELF.inq_retailpayments_count := inq_retailpayments_count;
		SELF.inq_retailpayments_count01 := inq_retailpayments_count01;
		SELF.inq_retailpayments_count03 := inq_retailpayments_count03;
		SELF.inq_retailpayments_count06 := inq_retailpayments_count06;
		SELF.inq_retailpayments_count12 := inq_retailpayments_count12;
		SELF.inq_retailpayments_count24 := inq_retailpayments_count24;
		SELF.stl_inq_count := stl_inq_count;
		SELF.email_count := email_count;
		SELF.email_verification := email_verification;
		SELF.email_name_addr_verification := email_name_addr_verification;
		SELF.adl_per_email := adl_per_email;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_num_unrel_liens60 := attr_num_unrel_liens60;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_eviction_count90 := attr_eviction_count90;
		SELF.attr_eviction_count180 := attr_eviction_count180;
		SELF.attr_eviction_count12 := attr_eviction_count12;
		SELF.attr_eviction_count24 := attr_eviction_count24;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.attr_eviction_count60 := attr_eviction_count60;
		SELF.fp_srchunvrfdphonecount := fp_srchunvrfdphonecount;
		SELF.fp_srchfraudsrchcountyr := fp_srchfraudsrchcountyr;
		SELF.fp_srchfraudsrchcountwk := fp_srchfraudsrchcountwk;
		SELF.fp_divaddrsuspidcountnew := fp_divaddrsuspidcountnew;
		SELF.fp_srchssnsrchcountmo := fp_srchssnsrchcountmo;
		SELF.fp_srchaddrsrchcountmo := fp_srchaddrsrchcountmo;
		SELF.fp_srchphonesrchcountmo := fp_srchphonesrchcountmo;
		SELF.fp_componentcharrisktype := fp_componentcharrisktype;
		SELF.fp_addrchangeincomediff := fp_addrchangeincomediff;
		SELF.fp_addrchangevaluediff := fp_addrchangevaluediff;
		SELF.fp_addrchangecrimediff := fp_addrchangecrimediff;
		SELF.fp_curraddrmedianincome := fp_curraddrmedianincome;
		SELF.fp_curraddrmedianvalue := fp_curraddrmedianvalue;
		SELF.fp_curraddrmurderindex := fp_curraddrmurderindex;
		SELF.fp_curraddrcartheftindex := fp_curraddrcartheftindex;
		SELF.fp_curraddrburglaryindex := fp_curraddrburglaryindex;
		SELF.fp_curraddrcrimeindex := fp_curraddrcrimeindex;
		SELF.fp_prevaddrageoldest := fp_prevaddrageoldest;
		SELF.fp_prevaddrlenofres := fp_prevaddrlenofres;
		SELF.fp_prevaddrdwelltype := fp_prevaddrdwelltype;
		SELF.fp_prevaddrmedianincome := fp_prevaddrmedianincome;
		SELF.fp_prevaddrmurderindex := fp_prevaddrmurderindex;
		SELF.fp_prevaddrcartheftindex := fp_prevaddrcartheftindex;
		SELF.fp_prevaddrburglaryindex := fp_prevaddrburglaryindex;
		SELF.fp_prevaddrcrimeindex := fp_prevaddrcrimeindex;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_unrel_cj_last_seen := liens_unrel_cj_last_seen;
		SELF.criminal_last_date := criminal_last_date;
		SELF.felony_count := felony_count;
		SELF.foreclosure_last_date := foreclosure_last_date;
		SELF.hh_members_ct := hh_members_ct;
		SELF.hh_payday_loan_users := hh_payday_loan_users;
		SELF.hh_members_w_derog := hh_members_w_derog;
		SELF.hh_criminals := hh_criminals;
		SELF.rel_count := rel_count;
		SELF.rel_bankrupt_count := rel_bankrupt_count;
		SELF.rel_criminal_count := rel_criminal_count;
		SELF.rel_felony_count := rel_felony_count;
		SELF.rel_within25miles_count := rel_within25miles_count;
		SELF.rel_within100miles_count := rel_within100miles_count;
		SELF.rel_within500miles_count := rel_within500miles_count;
		SELF.rel_homeunder200_count := rel_homeunder200_count;
		SELF.rel_homeunder300_count := rel_homeunder300_count;
		SELF.rel_homeunder500_count := rel_homeunder500_count;
		SELF.rel_homeover500_count := rel_homeover500_count;
		SELF.rel_ageunder40_count := rel_ageunder40_count;
		SELF.rel_ageunder50_count := rel_ageunder50_count;
		SELF.rel_ageunder60_count := rel_ageunder60_count;
		SELF.rel_ageunder70_count := rel_ageunder70_count;
		SELF.rel_ageover70_count := rel_ageover70_count;
		SELF.acc_last_seen := acc_last_seen;
		SELF.inferred_age := inferred_age;
		SELF.addr_stability_v2 := addr_stability_v2;
		SELF.estimated_income := estimated_income;
		SELF.truedid_s := truedid_s;
		SELF.out_z5_s := out_z5_s;
		SELF.out_addr_type_s := out_addr_type_s;
		SELF.in_dob_s := in_dob_s;
		SELF.nap_summary_s := nap_summary_s;
		SELF.rc_hriskaddrflag_s := rc_hriskaddrflag_s;
		SELF.rc_dwelltype_s := rc_dwelltype_s;
		SELF.rc_ziptypeflag_s := rc_ziptypeflag_s;
		SELF.rc_zipclass_s := rc_zipclass_s;
		SELF.hdr_source_profile_s := hdr_source_profile_s;
		SELF.ver_sources_s := ver_sources_s;
		SELF.ver_sources_first_seen_s := ver_sources_first_seen_s;
		SELF.addrpop_s := addrpop_s;
		SELF.emailpop_s := emailpop_s;
		SELF.util_adl_type_list_s := util_adl_type_list_s;
		SELF.add_input_address_score_s := add_input_address_score_s;
		SELF.add_input_dirty_address_s := add_input_dirty_address_s;
		SELF.add_input_addr_not_verified_s := add_input_addr_not_verified_s;
		SELF.add_input_avm_auto_val_s := add_input_avm_auto_val_s;
		SELF.add_input_naprop_s := add_input_naprop_s;
		SELF.add_input_occupants_1yr_s := add_input_occupants_1yr_s;
		SELF.add_input_turnover_1yr_in_s := add_input_turnover_1yr_in_s;
		SELF.add_input_turnover_1yr_out_s := add_input_turnover_1yr_out_s;
		SELF.add_input_nhood_vac_prop_s := add_input_nhood_vac_prop_s;
		SELF.add_input_nhood_bus_ct_s := add_input_nhood_bus_ct_s;
		SELF.add_input_nhood_sfd_ct_s := add_input_nhood_sfd_ct_s;
		SELF.add_input_nhood_mfd_ct_s := add_input_nhood_mfd_ct_s;
		SELF.add_input_pop_s := add_input_pop_s;
		SELF.property_owned_total_s := property_owned_total_s;
		SELF.add_curr_lres_s := add_curr_lres_s;
		SELF.add_curr_avm_auto_val_s := add_curr_avm_auto_val_s;
		SELF.add_curr_avm_auto_val_2_s := add_curr_avm_auto_val_2_s;
		SELF.add_curr_naprop_s := add_curr_naprop_s;
		SELF.add_curr_occupants_1yr_s := add_curr_occupants_1yr_s;
		SELF.add_curr_turnover_1yr_in_s := add_curr_turnover_1yr_in_s;
		SELF.add_curr_turnover_1yr_out_s := add_curr_turnover_1yr_out_s;
		SELF.add_curr_nhood_bus_ct_s := add_curr_nhood_bus_ct_s;
		SELF.add_curr_nhood_sfd_ct_s := add_curr_nhood_sfd_ct_s;
		SELF.add_curr_nhood_mfd_ct_s := add_curr_nhood_mfd_ct_s;
		SELF.add_curr_pop_s := add_curr_pop_s;
		SELF.add_prev_naprop_s := add_prev_naprop_s;
		SELF.max_lres_s := max_lres_s;
		SELF.addrs_10yr_s := addrs_10yr_s;
		SELF.adls_per_addr_curr_s := adls_per_addr_curr_s;
		SELF.phones_per_addr_curr_s := phones_per_addr_curr_s;
		SELF.adls_per_addr_c6_s := adls_per_addr_c6_s;
		SELF.invalid_addrs_per_adl_s := invalid_addrs_per_adl_s;
		SELF.inq_count24_s := inq_count24_s;
		SELF.inq_auto_count24_s := inq_auto_count24_s;
		SELF.inq_banking_count24_s := inq_banking_count24_s;
		SELF.inq_communications_count_s := inq_communications_count_s;
		SELF.inq_communications_count01_s := inq_communications_count01_s;
		SELF.inq_communications_count03_s := inq_communications_count03_s;
		SELF.inq_communications_count06_s := inq_communications_count06_s;
		SELF.inq_communications_count12_s := inq_communications_count12_s;
		SELF.inq_communications_count24_s := inq_communications_count24_s;
		SELF.inq_retailpayments_count_s := inq_retailpayments_count_s;
		SELF.inq_retailpayments_count01_s := inq_retailpayments_count01_s;
		SELF.inq_retailpayments_count03_s := inq_retailpayments_count03_s;
		SELF.inq_retailpayments_count06_s := inq_retailpayments_count06_s;
		SELF.inq_retailpayments_count12_s := inq_retailpayments_count12_s;
		SELF.inq_retailpayments_count24_s := inq_retailpayments_count24_s;
		SELF.inq_peraddr_s := inq_peraddr_s;
		SELF.inq_ssnsperaddr_s := inq_ssnsperaddr_s;
		SELF.br_source_count_s := br_source_count_s;
		SELF.email_count_s := email_count_s;
		SELF.email_verification_s := email_verification_s;
		SELF.email_name_addr_verification_s := email_name_addr_verification_s;
		SELF.attr_total_number_derogs_s := attr_total_number_derogs_s;
		SELF.fp_varrisktype_s := fp_varrisktype_s;
		SELF.fp_srchvelocityrisktype_s := fp_srchvelocityrisktype_s;
		SELF.fp_validationrisktype_s := fp_validationrisktype_s;
		SELF.fp_componentcharrisktype_s := fp_componentcharrisktype_s;
		SELF.fp_addrchangeincomediff_s := fp_addrchangeincomediff_s;
		SELF.fp_addrchangevaluediff_s := fp_addrchangevaluediff_s;
		SELF.fp_addrchangecrimediff_s := fp_addrchangecrimediff_s;
		SELF.fp_addrchangeecontrajindex_s := fp_addrchangeecontrajindex_s;
		SELF.fp_curraddrmedianincome_s := fp_curraddrmedianincome_s;
		SELF.fp_curraddrmedianvalue_s := fp_curraddrmedianvalue_s;
		SELF.fp_curraddrcartheftindex_s := fp_curraddrcartheftindex_s;
		SELF.fp_curraddrburglaryindex_s := fp_curraddrburglaryindex_s;
		SELF.fp_curraddrcrimeindex_s := fp_curraddrcrimeindex_s;
		SELF.fp_prevaddrageoldest_s := fp_prevaddrageoldest_s;
		SELF.fp_prevaddrmedianincome_s := fp_prevaddrmedianincome_s;
		SELF.fp_prevaddrmedianvalue_s := fp_prevaddrmedianvalue_s;
		SELF.fp_prevaddrmurderindex_s := fp_prevaddrmurderindex_s;
		SELF.fp_prevaddrcartheftindex_s := fp_prevaddrcartheftindex_s;
		SELF.fp_prevaddrburglaryindex_s := fp_prevaddrburglaryindex_s;
		SELF.fp_prevaddrcrimeindex_s := fp_prevaddrcrimeindex_s;
		SELF.liens_rel_cj_total_amount_s := liens_rel_cj_total_amount_s;
		SELF.liens_unrel_ft_first_seen_s := liens_unrel_ft_first_seen_s;
		SELF.liens_unrel_ot_first_seen_s := liens_unrel_ot_first_seen_s;
		SELF.criminal_last_date_s := criminal_last_date_s;
		SELF.rel_count_s := rel_count_s;
		SELF.rel_bankrupt_count_s := rel_bankrupt_count_s;
		SELF.crim_rel_within25miles_s := crim_rel_within25miles_s;
		SELF.crim_rel_within100miles_s := crim_rel_within100miles_s;
		SELF.crim_rel_within500miles_s := crim_rel_within500miles_s;
		SELF.rel_within25miles_count_s := rel_within25miles_count_s;
		SELF.rel_within100miles_count_s := rel_within100miles_count_s;
		SELF.rel_incomeunder100_count_s := rel_incomeunder100_count_s;
		SELF.rel_incomeover100_count_s := rel_incomeover100_count_s;
		SELF.rel_homeunder300_count_s := rel_homeunder300_count_s;
		SELF.rel_homeunder500_count_s := rel_homeunder500_count_s;
		SELF.rel_homeover500_count_s := rel_homeover500_count_s;
		SELF.acc_damage_amt_total_s := acc_damage_amt_total_s;
		SELF.wealth_index_s := wealth_index_s;
		SELF.inferred_age_s := inferred_age_s;
		SELF.addr_stability_v2_s := addr_stability_v2_s;
		SELF.estimated_income_s := estimated_income_s;
		SELF.BT_cen_blue_col := BT_cen_blue_col;
		SELF.BT_cen_business := BT_cen_business;
		SELF.BT_cen_civ_emp := BT_cen_civ_emp;
		SELF.BT_cen_easiqlife := BT_cen_easiqlife;
		SELF.BT_cen_families := BT_cen_families;
		SELF.BT_cen_health := BT_cen_health;
		SELF.BT_cen_high_ed := BT_cen_high_ed;
		SELF.BT_cen_high_hval := BT_cen_high_hval;
		SELF.BT_cen_incollege := BT_cen_incollege;
		SELF.BT_cen_lar_fam := BT_cen_lar_fam;
		SELF.BT_cen_low_hval := BT_cen_low_hval;
		SELF.BT_cen_med_hhinc := BT_cen_med_hhinc;
		SELF.BT_cen_med_hval := BT_cen_med_hval;
		SELF.BT_cen_med_rent := BT_cen_med_rent;
		SELF.BT_cen_mil_emp := BT_cen_mil_emp;
		SELF.BT_cen_no_move := BT_cen_no_move;
		SELF.BT_cen_ownocc_p := BT_cen_ownocc_p;
		SELF.BT_cen_pop_0_5_p := BT_cen_pop_0_5_p;
		SELF.BT_cen_rental := BT_cen_rental;
		SELF.BT_cen_retired2 := BT_cen_retired2;
		SELF.BT_cen_span_lang := BT_cen_span_lang;
		SELF.BT_cen_totcrime := BT_cen_totcrime;
		SELF.BT_cen_trailer := BT_cen_trailer;
		SELF.BT_cen_unemp := BT_cen_unemp;
		SELF.BT_cen_urban_p := BT_cen_urban_p;
		SELF.BT_cen_vacant_p := BT_cen_vacant_p;
		SELF.BT_cen_very_rich := BT_cen_very_rich;
		SELF.ST_cen_blue_col := ST_cen_blue_col;
		SELF.ST_cen_business := ST_cen_business;
		SELF.ST_cen_civ_emp := ST_cen_civ_emp;
		SELF.ST_cen_easiqlife := ST_cen_easiqlife;
		SELF.ST_cen_families := ST_cen_families;
		SELF.ST_cen_health := ST_cen_health;
		SELF.ST_cen_high_ed := ST_cen_high_ed;
		SELF.ST_cen_high_hval := ST_cen_high_hval;
		SELF.ST_cen_incollege := ST_cen_incollege;
		SELF.ST_cen_lar_fam := ST_cen_lar_fam;
		SELF.ST_cen_low_hval := ST_cen_low_hval;
		SELF.ST_cen_med_hhinc := ST_cen_med_hhinc;
		SELF.ST_cen_med_hval := ST_cen_med_hval;
		SELF.ST_cen_med_rent := ST_cen_med_rent;
		SELF.ST_cen_mil_emp := ST_cen_mil_emp;
		SELF.ST_cen_no_move := ST_cen_no_move;
		SELF.ST_cen_ownocc_p := ST_cen_ownocc_p;
		SELF.ST_cen_pop_0_5_p := ST_cen_pop_0_5_p;
		SELF.ST_cen_rental := ST_cen_rental;
		SELF.ST_cen_retired2 := ST_cen_retired2;
		SELF.ST_cen_span_lang := ST_cen_span_lang;
		SELF.ST_cen_totcrime := ST_cen_totcrime;
		SELF.ST_cen_trailer := ST_cen_trailer;
		SELF.ST_cen_unemp := ST_cen_unemp;
		SELF.ST_cen_urban_p := ST_cen_urban_p;
		SELF.ST_cen_vacant_p := ST_cen_vacant_p;
		SELF.ST_cen_very_rich := ST_cen_very_rich;
		SELF.addrscore := addrscore;
		SELF.continent := continent;
		SELF.distaddraddr2 := distaddraddr2;
		SELF.efirstscore := efirstscore;
		SELF.elastscore := elastscore;
		SELF.ipaddr := ipaddr;
		SELF.ipconnection := ipconnection;
		SELF.ipdma := ipdma;
		SELF.iproutingmethod := iproutingmethod;
		SELF.iptimezone := iptimezone;
		SELF.lastscore := lastscore;
		SELF.latitude := latitude;
		SELF.longitude := longitude;
		SELF.state := state;
		SELF.topleveldomain := topleveldomain;

		/* Model Intermediate Variables */
		
		SELF.sysdate := sysdate;
		SELF.b_nap_addr_verd_d := b_nap_addr_verd_d;
		SELF.b_nap_lname_verd_d := b_nap_lname_verd_d;
		SELF.b_nap_nothing_found_i := b_nap_nothing_found_i;
		SELF.b_f01_inp_addr_address_score_d := b_f01_inp_addr_address_score_d;
		SELF.b_d30_derog_count_i := b_d30_derog_count_i;
		SELF._criminal_last_date := _criminal_last_date;
		SELF.b_d32_mos_since_crim_ls_d := b_d32_mos_since_crim_ls_d;
		SELF.b_d33_eviction_recency_d := b_d33_eviction_recency_d;
		SELF.b_d33_eviction_count_i := b_d33_eviction_count_i;
		SELF.b_d34_unrel_liens_ct_i := b_d34_unrel_liens_ct_i;
		SELF.bureau_adl_eq_fseen_pos_2 := bureau_adl_eq_fseen_pos_2;
		SELF.bureau_adl_fseen_eq_2 := bureau_adl_fseen_eq_2;
		SELF._bureau_adl_fseen_eq_2 := _bureau_adl_fseen_eq_2;
		SELF._src_bureau_adl_fseen := _src_bureau_adl_fseen;
		SELF.b_c21_m_bureau_adl_fs_d := b_c21_m_bureau_adl_fs_d;
		SELF.bureau_adl_eq_fseen_pos_1 := bureau_adl_eq_fseen_pos_1;
		SELF.bureau_adl_fseen_eq_1 := bureau_adl_fseen_eq_1;
		SELF._bureau_adl_fseen_eq_1 := _bureau_adl_fseen_eq_1;
		SELF.bureau_adl_en_fseen_pos_1 := bureau_adl_en_fseen_pos_1;
		SELF.bureau_adl_fseen_en_1 := bureau_adl_fseen_en_1;
		SELF._bureau_adl_fseen_en_1 := _bureau_adl_fseen_en_1;
		SELF.bureau_adl_ts_fseen_pos_1 := bureau_adl_ts_fseen_pos_1;
		SELF.bureau_adl_fseen_ts_1 := bureau_adl_fseen_ts_1;
		SELF._bureau_adl_fseen_ts_1 := _bureau_adl_fseen_ts_1;
		SELF.bureau_adl_tu_fseen_pos_1 := bureau_adl_tu_fseen_pos_1;
		SELF.bureau_adl_fseen_tu_1 := bureau_adl_fseen_tu_1;
		SELF._bureau_adl_fseen_tu_1 := _bureau_adl_fseen_tu_1;
		SELF.bureau_adl_tn_fseen_pos_1 := bureau_adl_tn_fseen_pos_1;
		SELF.bureau_adl_fseen_tn_1 := bureau_adl_fseen_tn_1;
		SELF._bureau_adl_fseen_tn_1 := _bureau_adl_fseen_tn_1;
		SELF._src_bureau_adl_fseen_all := _src_bureau_adl_fseen_all;
		SELF.b_m_bureau_adl_fs_all_d := b_m_bureau_adl_fs_all_d;
		SELF.bureau_adl_eq_fseen_pos := bureau_adl_eq_fseen_pos;
		SELF.bureau_adl_fseen_eq := bureau_adl_fseen_eq;
		SELF._bureau_adl_fseen_eq := _bureau_adl_fseen_eq;
		SELF.bureau_adl_en_fseen_pos := bureau_adl_en_fseen_pos;
		SELF.bureau_adl_fseen_en := bureau_adl_fseen_en;
		SELF._bureau_adl_fseen_en := _bureau_adl_fseen_en;
		SELF.bureau_adl_ts_fseen_pos := bureau_adl_ts_fseen_pos;
		SELF.bureau_adl_fseen_ts := bureau_adl_fseen_ts;
		SELF._bureau_adl_fseen_ts := _bureau_adl_fseen_ts;
		SELF.bureau_adl_tu_fseen_pos := bureau_adl_tu_fseen_pos;
		SELF.bureau_adl_fseen_tu := bureau_adl_fseen_tu;
		SELF._bureau_adl_fseen_tu := _bureau_adl_fseen_tu;
		SELF.bureau_adl_tn_fseen_pos := bureau_adl_tn_fseen_pos;
		SELF.bureau_adl_fseen_tn := bureau_adl_fseen_tn;
		SELF._bureau_adl_fseen_tn := _bureau_adl_fseen_tn;
		SELF._src_bureau_adl_fseen_notu := _src_bureau_adl_fseen_notu;
		SELF.b_m_bureau_adl_fs_notu_d := b_m_bureau_adl_fs_notu_d;
		SELF._in_dob := _in_dob;
		SELF.yr_in_dob := yr_in_dob;
		SELF.yr_in_dob_int := yr_in_dob_int;
		SELF.b_comb_age_d := b_comb_age_d;
		SELF.b_a44_curr_add_naprop_d := b_a44_curr_add_naprop_d;
		SELF.b_l80_inp_avm_autoval_d := b_l80_inp_avm_autoval_d;
		SELF.b_a46_curr_avm_autoval_d := b_a46_curr_avm_autoval_d;
		SELF.b_a49_curr_avm_chg_1yr_i := b_a49_curr_avm_chg_1yr_i;
		SELF.b_a49_curr_avm_chg_1yr_pct_i := b_a49_curr_avm_chg_1yr_pct_i;
		SELF.b_c13_curr_addr_lres_d := b_c13_curr_addr_lres_d;
		SELF.b_c14_addr_stability_v2_d := b_c14_addr_stability_v2_d;
		SELF.b_c13_max_lres_d := b_c13_max_lres_d;
		SELF.b_c14_addrs_15yr_i := b_c14_addrs_15yr_i;
		SELF.b_c20_email_count_i := b_c20_email_count_i;
		SELF.b_l79_adls_per_addr_c6_i := b_l79_adls_per_addr_c6_i;
		SELF.b_c18_invalid_addrs_per_adl_i := b_c18_invalid_addrs_per_adl_i;
		SELF.b_l78_no_phone_at_addr_vel_i := b_l78_no_phone_at_addr_vel_i;
		SELF.b_i60_inq_recency_d := b_i60_inq_recency_d;
		SELF.b_i61_inq_collection_recency_d := b_i61_inq_collection_recency_d;
		SELF.b_i60_inq_auto_recency_d := b_i60_inq_auto_recency_d;
		SELF.b_i60_inq_hiriskcred_count12_i := b_i60_inq_hiriskcred_count12_i;
		SELF.b_i60_inq_retail_recency_d := b_i60_inq_retail_recency_d;
		SELF.b_add_input_mobility_index_i := b_add_input_mobility_index_i;
		SELF.add_input_nhood_prop_sum_3 := add_input_nhood_prop_sum_3;
		SELF.b_add_input_nhood_bus_pct_i := b_add_input_nhood_bus_pct_i;
		SELF.add_input_nhood_prop_sum_2 := add_input_nhood_prop_sum_2;
		SELF.b_add_input_nhood_mfd_pct_i := b_add_input_nhood_mfd_pct_i;
		SELF.add_input_nhood_prop_sum_1 := add_input_nhood_prop_sum_1;
		SELF.b_add_input_nhood_sfd_pct_d := b_add_input_nhood_sfd_pct_d;
		SELF.add_input_nhood_prop_sum := add_input_nhood_prop_sum;
		SELF.b_add_input_nhood_vac_pct_i := b_add_input_nhood_vac_pct_i;
		SELF.b_add_curr_mobility_index_i := b_add_curr_mobility_index_i;
		SELF.add_curr_nhood_prop_sum_3 := add_curr_nhood_prop_sum_3;
		SELF.b_add_curr_nhood_bus_pct_i := b_add_curr_nhood_bus_pct_i;
		SELF.add_curr_nhood_prop_sum_2 := add_curr_nhood_prop_sum_2;
		SELF.b_add_curr_nhood_mfd_pct_i := b_add_curr_nhood_mfd_pct_i;
		SELF.add_curr_nhood_prop_sum_1 := add_curr_nhood_prop_sum_1;
		SELF.b_add_curr_nhood_sfd_pct_d := b_add_curr_nhood_sfd_pct_d;
		SELF.add_curr_nhood_prop_sum := add_curr_nhood_prop_sum;
		SELF.b_add_curr_nhood_vac_pct_i := b_add_curr_nhood_vac_pct_i;
		SELF.b_inq_count24_i := b_inq_count24_i;
		SELF.b_inq_collection_count24_i := b_inq_collection_count24_i;
		SELF.b_inq_retail_count24_i := b_inq_retail_count24_i;
		SELF._liens_unrel_cj_last_seen := _liens_unrel_cj_last_seen;
		SELF.b_mos_liens_unrel_cj_lseen_d := b_mos_liens_unrel_cj_lseen_d;
		SELF._foreclosure_last_date := _foreclosure_last_date;
		SELF.b_mos_foreclosure_lseen_d := b_mos_foreclosure_lseen_d;
		SELF.b_estimated_income_d := b_estimated_income_d;
		SELF.b_rel_count_i := b_rel_count_i;
		SELF.b_rel_homeover150_count_d := b_rel_homeover150_count_d;
		SELF.b_rel_homeover200_count_d := b_rel_homeover200_count_d;
		SELF.b_rel_ageover30_count_d := b_rel_ageover30_count_d;
		SELF.b_rel_ageover40_count_d := b_rel_ageover40_count_d;
		SELF.b_rel_ageover50_count_d := b_rel_ageover50_count_d;
		SELF.b_rel_under25miles_cnt_d := b_rel_under25miles_cnt_d;
		SELF.b_rel_under500miles_cnt_d := b_rel_under500miles_cnt_d;
		SELF.b_rel_bankrupt_count_i := b_rel_bankrupt_count_i;
		SELF.b_rel_criminal_count_i := b_rel_criminal_count_i;
		SELF._acc_last_seen := _acc_last_seen;
		SELF.b_mos_acc_lseen_d := b_mos_acc_lseen_d;
		SELF.b_srchunvrfdphonecount_i := b_srchunvrfdphonecount_i;
		SELF.b_srchfraudsrchcountyr_i := b_srchfraudsrchcountyr_i;
		SELF.b_srchfraudsrchcountwk_i := b_srchfraudsrchcountwk_i;
		SELF.b_divaddrsuspidcountnew_i := b_divaddrsuspidcountnew_i;
		SELF.b_componentcharrisktype_i := b_componentcharrisktype_i;
		SELF.b_addrchangeincomediff_d_1 := b_addrchangeincomediff_d_1;
		SELF.b_addrchangeincomediff_d := b_addrchangeincomediff_d;
		SELF.b_addrchangevaluediff_d := b_addrchangevaluediff_d;
		SELF.b_addrchangecrimediff_i := b_addrchangecrimediff_i;
		SELF.b_curraddrmedianincome_d := b_curraddrmedianincome_d;
		SELF.b_curraddrmedianvalue_d := b_curraddrmedianvalue_d;
		SELF.b_curraddrmurderindex_i := b_curraddrmurderindex_i;
		SELF.b_curraddrcartheftindex_i := b_curraddrcartheftindex_i;
		SELF.b_curraddrburglaryindex_i := b_curraddrburglaryindex_i;
		SELF.b_curraddrcrimeindex_i := b_curraddrcrimeindex_i;
		SELF.b_prevaddrageoldest_d := b_prevaddrageoldest_d;
		SELF.b_prevaddrlenofres_d := b_prevaddrlenofres_d;
		SELF.b_prevaddrdwelltype_sfd_n := b_prevaddrdwelltype_sfd_n;
		SELF.b_prevaddrmedianincome_d := b_prevaddrmedianincome_d;
		SELF.b_prevaddrmurderindex_i := b_prevaddrmurderindex_i;
		SELF.b_prevaddrcartheftindex_i := b_prevaddrcartheftindex_i;
		SELF.b_fp_prevaddrburglaryindex_i := b_fp_prevaddrburglaryindex_i;
		SELF.b_fp_prevaddrcrimeindex_i := b_fp_prevaddrcrimeindex_i;
		SELF.b_c12_source_profile_d := b_c12_source_profile_d;
		SELF.b_f01_inp_addr_not_verified_i := b_f01_inp_addr_not_verified_i;
		SELF.b_c23_inp_addr_occ_index_d := b_c23_inp_addr_occ_index_d;
		SELF.b_i60_inq_prepaidcards_recency_d := b_i60_inq_prepaidcards_recency_d;
		SELF.b_i60_inq_retpymt_recency_d := b_i60_inq_retpymt_recency_d;
		SELF.b_phones_per_addr_curr_i := b_phones_per_addr_curr_i;
		SELF.b_phones_per_addr_c6_i := b_phones_per_addr_c6_i;
		SELF.b_inq_email_ver_count_i := b_inq_email_ver_count_i;
		SELF.b_nae_email_verd_d := b_nae_email_verd_d;
		SELF.b_nae_contradictory_i := b_nae_contradictory_i;
		SELF.b_adl_per_email_i := b_adl_per_email_i;
		SELF.b_c20_email_verification_d := b_c20_email_verification_d;
		SELF._ver_src_ds := _ver_src_ds;
		SELF._ver_src_de := _ver_src_de;
		SELF._ver_src_eq := _ver_src_eq;
		SELF._ver_src_en := _ver_src_en;
		SELF._ver_src_tn := _ver_src_tn;
		SELF._ver_src_tu := _ver_src_tu;
		SELF._credit_source_cnt := _credit_source_cnt;
		SELF._ver_src_cnt := _ver_src_cnt;
		SELF._bureauonly := (STRING)_bureauonly;
		SELF._derog := (STRING)_derog;
		SELF._deceased := (STRING)_deceased;
		SELF._ssnpriortodob := (STRING)_ssnpriortodob;
		SELF._inputmiskeys := (STRING)_inputmiskeys;
		SELF._multiplessns := (STRING)_multiplessns;
		SELF._hh_strikes := (STRING)_hh_strikes;
		
		SELF.s_nap_addr_verd_d := s_nap_addr_verd_d;
		SELF.s_nap_lname_verd_d := s_nap_lname_verd_d;
		SELF.s_nap_nothing_found_i := s_nap_nothing_found_i;
		SELF.s_l77_add_po_box_i := s_l77_add_po_box_i;
		SELF.s_f01_inp_addr_address_score_d := s_f01_inp_addr_address_score_d;
		SELF.s_l70_inp_addr_dirty_i := s_l70_inp_addr_dirty_i;
		SELF.s_d30_derog_count_i := s_d30_derog_count_i;
		SELF._criminal_last_date_s := _criminal_last_date_s;
		SELF.s_d32_mos_since_crim_ls_d := s_d32_mos_since_crim_ls_d;
		SELF.bureau_adl_eq_fseen_pos_s_1 := bureau_adl_eq_fseen_pos_s_1;
		SELF.bureau_adl_fseen_eq_s_1 := bureau_adl_fseen_eq_s_1;
		SELF._bureau_adl_fseen_eq_s_1 := _bureau_adl_fseen_eq_s_1;
		SELF._src_bureau_adl_fseen_s := _src_bureau_adl_fseen_s;
		SELF.s_c21_m_bureau_adl_fs_d := s_c21_m_bureau_adl_fs_d;
		SELF.bureau_adl_eq_fseen_pos_s := bureau_adl_eq_fseen_pos_s;
		SELF.bureau_adl_fseen_eq_s := bureau_adl_fseen_eq_s;
		SELF._bureau_adl_fseen_eq_s := _bureau_adl_fseen_eq_s;
		SELF.bureau_adl_en_fseen_pos_s := bureau_adl_en_fseen_pos_s;
		SELF.bureau_adl_fseen_en_s := bureau_adl_fseen_en_s;
		SELF._bureau_adl_fseen_en_s := _bureau_adl_fseen_en_s;
		SELF.bureau_adl_ts_fseen_pos_s := bureau_adl_ts_fseen_pos_s;
		SELF.bureau_adl_fseen_ts_s := bureau_adl_fseen_ts_s;
		SELF._bureau_adl_fseen_ts_s := _bureau_adl_fseen_ts_s;
		SELF.bureau_adl_tu_fseen_pos_s := bureau_adl_tu_fseen_pos_s;
		SELF.bureau_adl_fseen_tu_s := bureau_adl_fseen_tu_s;
		SELF._bureau_adl_fseen_tu_s := _bureau_adl_fseen_tu_s;
		SELF.bureau_adl_tn_fseen_pos_s := bureau_adl_tn_fseen_pos_s;
		SELF.bureau_adl_fseen_tn_s := bureau_adl_fseen_tn_s;
		SELF._bureau_adl_fseen_tn_s := _bureau_adl_fseen_tn_s;
		SELF._src_bureau_adl_fseen_notu_s := _src_bureau_adl_fseen_notu_s;
		SELF.s_m_bureau_adl_fs_notu_d := s_m_bureau_adl_fs_notu_d;
		SELF._in_dob_s :=_in_dob_s;
		SELF.yr_in_dob_s := yr_in_dob_s;
		SELF.yr_in_dob_int_s := yr_in_dob_int_s;
		SELF.s_comb_age_d := s_comb_age_d;
		SELF.s_a44_curr_add_naprop_d := s_a44_curr_add_naprop_d;
		SELF.s_l80_inp_avm_autoval_d := s_l80_inp_avm_autoval_d;
		SELF.s_a49_curr_avm_chg_1yr_pct_i := s_a49_curr_avm_chg_1yr_pct_i;
		SELF.s_c13_curr_addr_lres_d := s_c13_curr_addr_lres_d;
		SELF.s_c14_addr_stability_v2_d := s_c14_addr_stability_v2_d;
		SELF.s_c13_max_lres_d := s_c13_max_lres_d;
		SELF.s_c14_addrs_10yr_i := s_c14_addrs_10yr_i;
		SELF.s_a41_prop_owner_d := s_a41_prop_owner_d;
		SELF.s_c20_email_count_i := s_c20_email_count_i;
		SELF.s_l79_adls_per_addr_curr_i := s_l79_adls_per_addr_curr_i;
		SELF.s_l79_adls_per_addr_c6_i := s_l79_adls_per_addr_c6_i;
		SELF.s_c18_invalid_addrs_per_adl_i := s_c18_invalid_addrs_per_adl_i;
		SELF.s_i60_inq_comm_recency_d := s_i60_inq_comm_recency_d;
		SELF.s_adl_util_misc_n := (STRING)s_adl_util_misc_n;
		SELF.s_add_input_mobility_index_i := s_add_input_mobility_index_i;
		SELF.add_input_nhood_prop_sum_s_3 := add_input_nhood_prop_sum_s_3;
		SELF.s_add_input_nhood_bus_pct_i := s_add_input_nhood_bus_pct_i;
		SELF.add_input_nhood_prop_sum_s_2 := add_input_nhood_prop_sum_s_2;
		SELF.s_add_input_nhood_mfd_pct_i := s_add_input_nhood_mfd_pct_i;
		SELF.add_input_nhood_prop_sum_s_1 := add_input_nhood_prop_sum_s_1;
		SELF.s_add_input_nhood_sfd_pct_d := s_add_input_nhood_sfd_pct_d;
		SELF.add_input_nhood_prop_sum_s := add_input_nhood_prop_sum_s;
		SELF.s_add_input_nhood_vac_pct_i := s_add_input_nhood_vac_pct_i;
		SELF.s_add_curr_mobility_index_i := s_add_curr_mobility_index_i;
		SELF.add_curr_nhood_prop_sum_s_2 := add_curr_nhood_prop_sum_s_2;
		SELF.s_add_curr_nhood_bus_pct_i := s_add_curr_nhood_bus_pct_i;
		SELF.add_curr_nhood_prop_sum_s_1 := add_curr_nhood_prop_sum_s_1;
		SELF.s_add_curr_nhood_mfd_pct_i := s_add_curr_nhood_mfd_pct_i;
		SELF.add_curr_nhood_prop_sum_s := add_curr_nhood_prop_sum_s;
		SELF.s_add_curr_nhood_sfd_pct_d := s_add_curr_nhood_sfd_pct_d;
		SELF.s_inq_count24_i := s_inq_count24_i;
		SELF.s_inq_auto_count24_i := s_inq_auto_count24_i;
		SELF.s_inq_banking_count24_i := s_inq_banking_count24_i;
		SELF.s_inq_per_addr_i := s_inq_per_addr_i;
		SELF.s_inq_ssns_per_addr_i := s_inq_ssns_per_addr_i;
		SELF.s_liens_rel_cj_total_amt_i := s_liens_rel_cj_total_amt_i;
		SELF._liens_unrel_ft_first_seen_s := _liens_unrel_ft_first_seen_s;
		SELF.s_mos_liens_unrel_ft_fseen_d := s_mos_liens_unrel_ft_fseen_d;
		SELF._liens_unrel_ot_first_seen_s := _liens_unrel_ot_first_seen_s;
		SELF.s_mos_liens_unrel_ot_fseen_d := s_mos_liens_unrel_ot_fseen_d;
		SELF.s_estimated_income_d := s_estimated_income_d;
		SELF.s_wealth_index_d := s_wealth_index_d;
		SELF.s_rel_incomeover75_count_d := s_rel_incomeover75_count_d;
		SELF.s_rel_incomeover100_count_d := s_rel_incomeover100_count_d;
		SELF.s_rel_homeover200_count_d := s_rel_homeover200_count_d;
		SELF.s_rel_homeover300_count_d := s_rel_homeover300_count_d;
		SELF.s_crim_rel_under500miles_cnt_i := s_crim_rel_under500miles_cnt_i;
		SELF.s_rel_under25miles_cnt_d := s_rel_under25miles_cnt_d;
		SELF.s_rel_under100miles_cnt_d := s_rel_under100miles_cnt_d;
		SELF.s_rel_bankrupt_count_i := s_rel_bankrupt_count_i;
		SELF.s_acc_damage_amt_total_i := s_acc_damage_amt_total_i;
		SELF.s_varrisktype_i := s_varrisktype_i;
		SELF.s_srchvelocityrisktype_i := s_srchvelocityrisktype_i;
		SELF.s_validationrisktype_i := s_validationrisktype_i;
		SELF.s_componentcharrisktype_i := s_componentcharrisktype_i;
		SELF.s_addrchangeincomediff_d_1 := s_addrchangeincomediff_d_1;
		SELF.s_addrchangeincomediff_d := s_addrchangeincomediff_d;
		SELF.s_addrchangevaluediff_d := s_addrchangevaluediff_d;
		SELF.s_addrchangecrimediff_i := s_addrchangecrimediff_i;
		SELF.s_addrchangeecontrajindex_d := s_addrchangeecontrajindex_d;
		SELF.s_curraddrmedianincome_d := s_curraddrmedianincome_d;
		SELF.s_curraddrmedianvalue_d := s_curraddrmedianvalue_d;
		SELF.s_curraddrcartheftindex_i := s_curraddrcartheftindex_i;
		SELF.s_curraddrburglaryindex_i := s_curraddrburglaryindex_i;
		SELF.s_curraddrcrimeindex_i := s_curraddrcrimeindex_i;
		SELF.s_prevaddrageoldest_d := s_prevaddrageoldest_d;
		SELF.s_prevaddrmedianincome_d := s_prevaddrmedianincome_d;
		SELF.s_prevaddrmedianvalue_d := s_prevaddrmedianvalue_d;
		SELF.s_prevaddrmurderindex_i := s_prevaddrmurderindex_i;
		SELF.s_prevaddrcartheftindex_i := s_prevaddrcartheftindex_i;
		SELF.s_fp_prevaddrburglaryindex_i := s_fp_prevaddrburglaryindex_i;
		SELF.s_fp_prevaddrcrimeindex_i := s_fp_prevaddrcrimeindex_i;
		SELF.s_c12_source_profile_d := s_c12_source_profile_d;
		SELF.s_f01_inp_addr_not_verified_i := s_f01_inp_addr_not_verified_i;
		SELF.s_e57_br_source_count_d := s_e57_br_source_count_d;
		SELF.s_i60_inq_retpymt_recency_d := s_i60_inq_retpymt_recency_d;
		SELF.s_phones_per_addr_curr_i := s_phones_per_addr_curr_i;
		SELF.s_nae_email_verd_d := s_nae_email_verd_d;
		SELF.s_c20_email_verification_d := s_c20_email_verification_d;
		SELF.btst_addr_match_d := btst_addr_match_d;
		SELF.num_inp_lat  := num_inp_lat;
		SELF.num_inp_long := num_inp_long;
		SELF.num_ip_lat   := num_ip_lat;
		SELF.num_ip_long  := num_ip_long;
		SELF.d_lat        := d_lat;
		SELF.d_long       := d_long;
		SELF.a            := a;
		SELF.c            := c;
		SELF.dist         := dist;
		SELF.btst_dist_inp_addr_to_ip_addr_i := btst_dist_inp_addr_to_ip_addr_i;
		SELF.btst_lastscore_d := (STRING)btst_lastscore_d;
		SELF.btst_addrscore_d := (STRING)btst_addrscore_d;
		SELF.btst_email_first_score_d := (STRING)btst_email_first_score_d;
		SELF.btst_email_last_score_d := (STRING)btst_email_last_score_d;
		SELF.btst_distaddraddr2_i := btst_distaddraddr2_i;
		SELF.email_topleveldomain := email_topleveldomain;
		SELF.btst_email_topleveldomain_n := btst_email_topleveldomain_n;
		SELF.ip_continent_n := ip_continent_n;
		SELF.ip_state_match_d := (STRING)ip_state_match_d;
		SELF.ip_topleveldomain_lvl_n := ip_topleveldomain_lvl_n;
		SELF.ip_routingmethod_n := ip_routingmethod_n;
		SELF.ip_dma_lvl_n := ip_dma_lvl_n;
		SELF.num_ip_time_zone := (STRING)num_ip_time_zone;
		SELF.ip_non_us_time_zone_i := (STRING)ip_non_us_time_zone_i;
		SELF.ip_connection_n := ip_connection_n;
		SELF.final_score_tree_0 := final_score_tree_0;
		SELF.final_score_tree_1_c198 := final_score_tree_1_c198;
		SELF.final_score_tree_1_c199 := final_score_tree_1_c199;
		SELF.final_score_tree_1_c197 := final_score_tree_1_c197;
		SELF.final_score_tree_1_c196 := final_score_tree_1_c196;
		SELF.final_score_tree_1 := final_score_tree_1;
		SELF.final_score_tree_2_c203 := final_score_tree_2_c203;
		SELF.final_score_tree_2_c202 := final_score_tree_2_c202;
		SELF.final_score_tree_2_c201 := final_score_tree_2_c201;
		SELF.final_score_tree_2_c204 := final_score_tree_2_c204;
		SELF.final_score_tree_2 := final_score_tree_2;
		SELF.final_score_tree_3_c208 := final_score_tree_3_c208;
		SELF.final_score_tree_3_c207 := final_score_tree_3_c207;
		SELF.final_score_tree_3_c206 := final_score_tree_3_c206;
		SELF.final_score_tree_3_c209 := final_score_tree_3_c209;
		SELF.final_score_tree_3 := final_score_tree_3;
		SELF.final_score_tree_4_c213 := final_score_tree_4_c213;
		SELF.final_score_tree_4_c212 := final_score_tree_4_c212;
		SELF.final_score_tree_4_c211 := final_score_tree_4_c211;
		SELF.final_score_tree_4_c214 := final_score_tree_4_c214;
		SELF.final_score_tree_4 := final_score_tree_4;
		SELF.final_score_tree_5_c218 := final_score_tree_5_c218;
		SELF.final_score_tree_5_c217 := final_score_tree_5_c217;
		SELF.final_score_tree_5_c216 := final_score_tree_5_c216;
		SELF.final_score_tree_5_c219 := final_score_tree_5_c219;
		SELF.final_score_tree_5 := final_score_tree_5;
		SELF.final_score_tree_6_c224 := final_score_tree_6_c224;
		SELF.final_score_tree_6_c223 := final_score_tree_6_c223;
		SELF.final_score_tree_6_c222 := final_score_tree_6_c222;
		SELF.final_score_tree_6_c221 := final_score_tree_6_c221;
		SELF.final_score_tree_6 := final_score_tree_6;
		SELF.final_score_tree_7_c229 := final_score_tree_7_c229;
		SELF.final_score_tree_7_c228 := final_score_tree_7_c228;
		SELF.final_score_tree_7_c227 := final_score_tree_7_c227;
		SELF.final_score_tree_7_c226 := final_score_tree_7_c226;
		SELF.final_score_tree_7 := final_score_tree_7;
		SELF.final_score_tree_8_c233 := final_score_tree_8_c233;
		SELF.final_score_tree_8_c232 := final_score_tree_8_c232;
		SELF.final_score_tree_8_c231 := final_score_tree_8_c231;
		SELF.final_score_tree_8_c234 := final_score_tree_8_c234;
		SELF.final_score_tree_8 := final_score_tree_8;
		SELF.final_score_tree_9_c239 := final_score_tree_9_c239;
		SELF.final_score_tree_9_c238 := final_score_tree_9_c238;
		SELF.final_score_tree_9_c237 := final_score_tree_9_c237;
		SELF.final_score_tree_9_c236 := final_score_tree_9_c236;
		SELF.final_score_tree_9 := final_score_tree_9;
		SELF.final_score_tree_10_c242 := final_score_tree_10_c242;
		SELF.final_score_tree_10_c241 := final_score_tree_10_c241;
		SELF.final_score_tree_10_c244 := final_score_tree_10_c244;
		SELF.final_score_tree_10_c243 := final_score_tree_10_c243;
		SELF.final_score_tree_10 := final_score_tree_10;
		SELF.final_score_tree_11_c249 := final_score_tree_11_c249;
		SELF.final_score_tree_11_c248 := final_score_tree_11_c248;
		SELF.final_score_tree_11_c247 := final_score_tree_11_c247;
		SELF.final_score_tree_11_c246 := final_score_tree_11_c246;
		SELF.final_score_tree_11 := final_score_tree_11;
		SELF.final_score_tree_12_c252 := final_score_tree_12_c252;
		SELF.final_score_tree_12_c254 := final_score_tree_12_c254;
		SELF.final_score_tree_12_c253 := final_score_tree_12_c253;
		SELF.final_score_tree_12_c251 := final_score_tree_12_c251;
		SELF.final_score_tree_12 := final_score_tree_12;
		SELF.final_score_tree_13_c256 := final_score_tree_13_c256;
		SELF.final_score_tree_13_c259 := final_score_tree_13_c259;
		SELF.final_score_tree_13_c258 := final_score_tree_13_c258;
		SELF.final_score_tree_13_c257 := final_score_tree_13_c257;
		SELF.final_score_tree_13 := final_score_tree_13;
		SELF.final_score_tree_14_c263 := final_score_tree_14_c263;
		SELF.final_score_tree_14_c264 := final_score_tree_14_c264;
		SELF.final_score_tree_14_c262 := final_score_tree_14_c262;
		SELF.final_score_tree_14_c261 := final_score_tree_14_c261;
		SELF.final_score_tree_14 := final_score_tree_14;
		SELF.final_score_tree_15_c268 := final_score_tree_15_c268;
		SELF.final_score_tree_15_c269 := final_score_tree_15_c269;
		SELF.final_score_tree_15_c267 := final_score_tree_15_c267;
		SELF.final_score_tree_15_c266 := final_score_tree_15_c266;
		SELF.final_score_tree_15 := final_score_tree_15;
		SELF.final_score_tree_16_c272 := final_score_tree_16_c272;
		SELF.final_score_tree_16_c273 := final_score_tree_16_c273;
		SELF.final_score_tree_16_c271 := final_score_tree_16_c271;
		SELF.final_score_tree_16_c274 := final_score_tree_16_c274;
		SELF.final_score_tree_16 := final_score_tree_16;
		SELF.final_score_tree_17_c277 := final_score_tree_17_c277;
		SELF.final_score_tree_17_c276 := final_score_tree_17_c276;
		SELF.final_score_tree_17_c279 := final_score_tree_17_c279;
		SELF.final_score_tree_17_c278 := final_score_tree_17_c278;
		SELF.final_score_tree_17 := final_score_tree_17;
		SELF.final_score_tree_18_c282 := final_score_tree_18_c282;
		SELF.final_score_tree_18_c281 := final_score_tree_18_c281;
		SELF.final_score_tree_18_c284 := final_score_tree_18_c284;
		SELF.final_score_tree_18_c283 := final_score_tree_18_c283;
		SELF.final_score_tree_18 := final_score_tree_18;
		SELF.final_score_tree_19_c287 := final_score_tree_19_c287;
		SELF.final_score_tree_19_c286 := final_score_tree_19_c286;
		SELF.final_score_tree_19_c289 := final_score_tree_19_c289;
		SELF.final_score_tree_19_c288 := final_score_tree_19_c288;
		SELF.final_score_tree_19 := final_score_tree_19;
		SELF.final_score_tree_20_c293 := final_score_tree_20_c293;
		SELF.final_score_tree_20_c292 := final_score_tree_20_c292;
		SELF.final_score_tree_20_c291 := final_score_tree_20_c291;
		SELF.final_score_tree_20_c294 := final_score_tree_20_c294;
		SELF.final_score_tree_20 := final_score_tree_20;
		SELF.final_score_tree_21_c298 := final_score_tree_21_c298;
		SELF.final_score_tree_21_c297 := final_score_tree_21_c297;
		SELF.final_score_tree_21_c299 := final_score_tree_21_c299;
		SELF.final_score_tree_21_c296 := final_score_tree_21_c296;
		SELF.final_score_tree_21 := final_score_tree_21;
		SELF.final_score_tree_22_c301 := final_score_tree_22_c301;
		SELF.final_score_tree_22_c304 := final_score_tree_22_c304;
		SELF.final_score_tree_22_c303 := final_score_tree_22_c303;
		SELF.final_score_tree_22_c302 := final_score_tree_22_c302;
		SELF.final_score_tree_22 := final_score_tree_22;
		SELF.final_score_tree_23_c306 := final_score_tree_23_c306;
		SELF.final_score_tree_23_c309 := final_score_tree_23_c309;
		SELF.final_score_tree_23_c308 := final_score_tree_23_c308;
		SELF.final_score_tree_23_c307 := final_score_tree_23_c307;
		SELF.final_score_tree_23 := final_score_tree_23;
		SELF.final_score_tree_24_c314 := final_score_tree_24_c314;
		SELF.final_score_tree_24_c313 := final_score_tree_24_c313;
		SELF.final_score_tree_24_c312 := final_score_tree_24_c312;
		SELF.final_score_tree_24_c311 := final_score_tree_24_c311;
		SELF.final_score_tree_24 := final_score_tree_24;
		SELF.final_score_tree_25_c318 := final_score_tree_25_c318;
		SELF.final_score_tree_25_c317 := final_score_tree_25_c317;
		SELF.final_score_tree_25_c319 := final_score_tree_25_c319;
		SELF.final_score_tree_25_c316 := final_score_tree_25_c316;
		SELF.final_score_tree_25 := final_score_tree_25;
		SELF.final_score_tree_26_c324 := final_score_tree_26_c324;
		SELF.final_score_tree_26_c323 := final_score_tree_26_c323;
		SELF.final_score_tree_26_c322 := final_score_tree_26_c322;
		SELF.final_score_tree_26_c321 := final_score_tree_26_c321;
		SELF.final_score_tree_26 := final_score_tree_26;
		SELF.final_score_tree_27_c327 := final_score_tree_27_c327;
		SELF.final_score_tree_27_c328 := final_score_tree_27_c328;
		SELF.final_score_tree_27_c329 := final_score_tree_27_c329;
		SELF.final_score_tree_27_c326 := final_score_tree_27_c326;
		SELF.final_score_tree_27 := final_score_tree_27;
		SELF.final_score_tree_28_c333 := final_score_tree_28_c333;
		SELF.final_score_tree_28_c332 := final_score_tree_28_c332;
		SELF.final_score_tree_28_c334 := final_score_tree_28_c334;
		SELF.final_score_tree_28_c331 := final_score_tree_28_c331;
		SELF.final_score_tree_28 := final_score_tree_28;
		SELF.final_score_tree_29_c337 := final_score_tree_29_c337;
		SELF.final_score_tree_29_c336 := final_score_tree_29_c336;
		SELF.final_score_tree_29_c339 := final_score_tree_29_c339;
		SELF.final_score_tree_29_c338 := final_score_tree_29_c338;
		SELF.final_score_tree_29 := final_score_tree_29;
		SELF.final_score_tree_30_c342 := final_score_tree_30_c342;
		SELF.final_score_tree_30_c343 := final_score_tree_30_c343;
		SELF.final_score_tree_30_c344 := final_score_tree_30_c344;
		SELF.final_score_tree_30_c341 := final_score_tree_30_c341;
		SELF.final_score_tree_30 := final_score_tree_30;
		SELF.final_score_tree_31_c346 := final_score_tree_31_c346;
		SELF.final_score_tree_31_c348 := final_score_tree_31_c348;
		SELF.final_score_tree_31_c349 := final_score_tree_31_c349;
		SELF.final_score_tree_31_c347 := final_score_tree_31_c347;
		SELF.final_score_tree_31 := final_score_tree_31;
		SELF.final_score_tree_32_c352 := final_score_tree_32_c352;
		SELF.final_score_tree_32_c354 := final_score_tree_32_c354;
		SELF.final_score_tree_32_c353 := final_score_tree_32_c353;
		SELF.final_score_tree_32_c351 := final_score_tree_32_c351;
		SELF.final_score_tree_32 := final_score_tree_32;
		SELF.final_score_tree_33_c358 := final_score_tree_33_c358;
		SELF.final_score_tree_33_c357 := final_score_tree_33_c357;
		SELF.final_score_tree_33_c356 := final_score_tree_33_c356;
		SELF.final_score_tree_33_c359 := final_score_tree_33_c359;
		SELF.final_score_tree_33 := final_score_tree_33;
		SELF.final_score_tree_34_c362 := final_score_tree_34_c362;
		SELF.final_score_tree_34_c363 := final_score_tree_34_c363;
		SELF.final_score_tree_34_c364 := final_score_tree_34_c364;
		SELF.final_score_tree_34_c361 := final_score_tree_34_c361;
		SELF.final_score_tree_34 := final_score_tree_34;
		SELF.final_score_tree_35_c368 := final_score_tree_35_c368;
		SELF.final_score_tree_35_c367 := final_score_tree_35_c367;
		SELF.final_score_tree_35_c366 := final_score_tree_35_c366;
		SELF.final_score_tree_35_c369 := final_score_tree_35_c369;
		SELF.final_score_tree_35 := final_score_tree_35;
		SELF.final_score_tree_36_c374 := final_score_tree_36_c374;
		SELF.final_score_tree_36_c373 := final_score_tree_36_c373;
		SELF.final_score_tree_36_c372 := final_score_tree_36_c372;
		SELF.final_score_tree_36_c371 := final_score_tree_36_c371;
		SELF.final_score_tree_36 := final_score_tree_36;
		SELF.final_score_tree_37_c377 := final_score_tree_37_c377;
		SELF.final_score_tree_37_c378 := final_score_tree_37_c378;
		SELF.final_score_tree_37_c376 := final_score_tree_37_c376;
		SELF.final_score_tree_37_c379 := final_score_tree_37_c379;
		SELF.final_score_tree_37 := final_score_tree_37;
		SELF.final_score_tree_38_c383 := final_score_tree_38_c383;
		SELF.final_score_tree_38_c382 := final_score_tree_38_c382;
		SELF.final_score_tree_38_c384 := final_score_tree_38_c384;
		SELF.final_score_tree_38_c381 := final_score_tree_38_c381;
		SELF.final_score_tree_38 := final_score_tree_38;
		SELF.final_score_tree_39_c389 := final_score_tree_39_c389;
		SELF.final_score_tree_39_c388 := final_score_tree_39_c388;
		SELF.final_score_tree_39_c387 := final_score_tree_39_c387;
		SELF.final_score_tree_39_c386 := final_score_tree_39_c386;
		SELF.final_score_tree_39 := final_score_tree_39;
		SELF.final_score_tree_40_c393 := final_score_tree_40_c393;
		SELF.final_score_tree_40_c392 := final_score_tree_40_c392;
		SELF.final_score_tree_40_c394 := final_score_tree_40_c394;
		SELF.final_score_tree_40_c391 := final_score_tree_40_c391;
		SELF.final_score_tree_40 := final_score_tree_40;
		SELF.final_score_tree_41_c399 := final_score_tree_41_c399;
		SELF.final_score_tree_41_c398 := final_score_tree_41_c398;
		SELF.final_score_tree_41_c397 := final_score_tree_41_c397;
		SELF.final_score_tree_41_c396 := final_score_tree_41_c396;
		SELF.final_score_tree_41 := final_score_tree_41;
		SELF.final_score_tree_42_c404 := final_score_tree_42_c404;
		SELF.final_score_tree_42_c403 := final_score_tree_42_c403;
		SELF.final_score_tree_42_c402 := final_score_tree_42_c402;
		SELF.final_score_tree_42_c401 := final_score_tree_42_c401;
		SELF.final_score_tree_42 := final_score_tree_42;
		SELF.final_score_tree_43_c407 := final_score_tree_43_c407;
		SELF.final_score_tree_43_c409 := final_score_tree_43_c409;
		SELF.final_score_tree_43_c408 := final_score_tree_43_c408;
		SELF.final_score_tree_43_c406 := final_score_tree_43_c406;
		SELF.final_score_tree_43 := final_score_tree_43;
		SELF.final_score_tree_44_c412 := final_score_tree_44_c412;
		SELF.final_score_tree_44_c411 := final_score_tree_44_c411;
		SELF.final_score_tree_44_c414 := final_score_tree_44_c414;
		SELF.final_score_tree_44_c413 := final_score_tree_44_c413;
		SELF.final_score_tree_44 := final_score_tree_44;
		SELF.final_score_tree_45_c418 := final_score_tree_45_c418;
		SELF.final_score_tree_45_c417 := final_score_tree_45_c417;
		SELF.final_score_tree_45_c416 := final_score_tree_45_c416;
		SELF.final_score_tree_45_c419 := final_score_tree_45_c419;
		SELF.final_score_tree_45 := final_score_tree_45;
		SELF.final_score_tree_46_c423 := final_score_tree_46_c423;
		SELF.final_score_tree_46_c422 := final_score_tree_46_c422;
		SELF.final_score_tree_46_c421 := final_score_tree_46_c421;
		SELF.final_score_tree_46_c424 := final_score_tree_46_c424;
		SELF.final_score_tree_46 := final_score_tree_46;
		SELF.final_score_tree_47_c426 := final_score_tree_47_c426;
		SELF.final_score_tree_47_c429 := final_score_tree_47_c429;
		SELF.final_score_tree_47_c428 := final_score_tree_47_c428;
		SELF.final_score_tree_47_c427 := final_score_tree_47_c427;
		SELF.final_score_tree_47 := final_score_tree_47;
		SELF.final_score_tree_48_c432 := final_score_tree_48_c432;
		SELF.final_score_tree_48_c431 := final_score_tree_48_c431;
		SELF.final_score_tree_48_c434 := final_score_tree_48_c434;
		SELF.final_score_tree_48_c433 := final_score_tree_48_c433;
		SELF.final_score_tree_48 := final_score_tree_48;
		SELF.final_score_tree_49_c439 := final_score_tree_49_c439;
		SELF.final_score_tree_49_c438 := final_score_tree_49_c438;
		SELF.final_score_tree_49_c437 := final_score_tree_49_c437;
		SELF.final_score_tree_49_c436 := final_score_tree_49_c436;
		SELF.final_score_tree_49 := final_score_tree_49;
		SELF.final_score_tree_50_c443 := final_score_tree_50_c443;
		SELF.final_score_tree_50_c442 := final_score_tree_50_c442;
		SELF.final_score_tree_50_c444 := final_score_tree_50_c444;
		SELF.final_score_tree_50_c441 := final_score_tree_50_c441;
		SELF.final_score_tree_50 := final_score_tree_50;
		SELF.final_score_tree_51_c449 := final_score_tree_51_c449;
		SELF.final_score_tree_51_c448 := final_score_tree_51_c448;
		SELF.final_score_tree_51_c447 := final_score_tree_51_c447;
		SELF.final_score_tree_51_c446 := final_score_tree_51_c446;
		SELF.final_score_tree_51 := final_score_tree_51;
		SELF.final_score_tree_52_c454 := final_score_tree_52_c454;
		SELF.final_score_tree_52_c453 := final_score_tree_52_c453;
		SELF.final_score_tree_52_c452 := final_score_tree_52_c452;
		SELF.final_score_tree_52_c451 := final_score_tree_52_c451;
		SELF.final_score_tree_52 := final_score_tree_52;
		SELF.final_score_tree_53_c459 := final_score_tree_53_c459;
		SELF.final_score_tree_53_c458 := final_score_tree_53_c458;
		SELF.final_score_tree_53_c457 := final_score_tree_53_c457;
		SELF.final_score_tree_53_c456 := final_score_tree_53_c456;
		SELF.final_score_tree_53 := final_score_tree_53;
		SELF.final_score_tree_54_c462 := final_score_tree_54_c462;
		SELF.final_score_tree_54_c461 := final_score_tree_54_c461;
		SELF.final_score_tree_54_c464 := final_score_tree_54_c464;
		SELF.final_score_tree_54_c463 := final_score_tree_54_c463;
		SELF.final_score_tree_54 := final_score_tree_54;
		SELF.final_score_tree_55_c469 := final_score_tree_55_c469;
		SELF.final_score_tree_55_c468 := final_score_tree_55_c468;
		SELF.final_score_tree_55_c467 := final_score_tree_55_c467;
		SELF.final_score_tree_55_c466 := final_score_tree_55_c466;
		SELF.final_score_tree_55 := final_score_tree_55;
		SELF.final_score_tree_56_c474 := final_score_tree_56_c474;
		SELF.final_score_tree_56_c473 := final_score_tree_56_c473;
		SELF.final_score_tree_56_c472 := final_score_tree_56_c472;
		SELF.final_score_tree_56_c471 := final_score_tree_56_c471;
		SELF.final_score_tree_56 := final_score_tree_56;
		SELF.final_score_tree_57_c478 := final_score_tree_57_c478;
		SELF.final_score_tree_57_c477 := final_score_tree_57_c477;
		SELF.final_score_tree_57_c476 := final_score_tree_57_c476;
		SELF.final_score_tree_57_c479 := final_score_tree_57_c479;
		SELF.final_score_tree_57 := final_score_tree_57;
		SELF.final_score_tree_58_c484 := final_score_tree_58_c484;
		SELF.final_score_tree_58_c483 := final_score_tree_58_c483;
		SELF.final_score_tree_58_c482 := final_score_tree_58_c482;
		SELF.final_score_tree_58_c481 := final_score_tree_58_c481;
		SELF.final_score_tree_58 := final_score_tree_58;
		SELF.final_score_tree_59_c488 := final_score_tree_59_c488;
		SELF.final_score_tree_59_c487 := final_score_tree_59_c487;
		SELF.final_score_tree_59_c486 := final_score_tree_59_c486;
		SELF.final_score_tree_59_c489 := final_score_tree_59_c489;
		SELF.final_score_tree_59 := final_score_tree_59;
		SELF.final_score_tree_60_c492 := final_score_tree_60_c492;
		SELF.final_score_tree_60_c491 := final_score_tree_60_c491;
		SELF.final_score_tree_60_c494 := final_score_tree_60_c494;
		SELF.final_score_tree_60_c493 := final_score_tree_60_c493;
		SELF.final_score_tree_60 := final_score_tree_60;
		SELF.final_score_tree_61_c497 := final_score_tree_61_c497;
		SELF.final_score_tree_61_c499 := final_score_tree_61_c499;
		SELF.final_score_tree_61_c498 := final_score_tree_61_c498;
		SELF.final_score_tree_61_c496 := final_score_tree_61_c496;
		SELF.final_score_tree_61 := final_score_tree_61;
		SELF.final_score_tree_62_c503 := final_score_tree_62_c503;
		SELF.final_score_tree_62_c502 := final_score_tree_62_c502;
		SELF.final_score_tree_62_c501 := final_score_tree_62_c501;
		SELF.final_score_tree_62_c504 := final_score_tree_62_c504;
		SELF.final_score_tree_62 := final_score_tree_62;
		SELF.final_score_tree_63_c509 := final_score_tree_63_c509;
		SELF.final_score_tree_63_c508 := final_score_tree_63_c508;
		SELF.final_score_tree_63_c507 := final_score_tree_63_c507;
		SELF.final_score_tree_63_c506 := final_score_tree_63_c506;
		SELF.final_score_tree_63 := final_score_tree_63;
		SELF.final_score_tree_64_c512 := final_score_tree_64_c512;
		SELF.final_score_tree_64_c514 := final_score_tree_64_c514;
		SELF.final_score_tree_64_c513 := final_score_tree_64_c513;
		SELF.final_score_tree_64_c511 := final_score_tree_64_c511;
		SELF.final_score_tree_64 := final_score_tree_64;
		SELF.final_score_tree_65_c519 := final_score_tree_65_c519;
		SELF.final_score_tree_65_c518 := final_score_tree_65_c518;
		SELF.final_score_tree_65_c517 := final_score_tree_65_c517;
		SELF.final_score_tree_65_c516 := final_score_tree_65_c516;
		SELF.final_score_tree_65 := final_score_tree_65;
		SELF.final_score_tree_66_c524 := final_score_tree_66_c524;
		SELF.final_score_tree_66_c523 := final_score_tree_66_c523;
		SELF.final_score_tree_66_c522 := final_score_tree_66_c522;
		SELF.final_score_tree_66_c521 := final_score_tree_66_c521;
		SELF.final_score_tree_66 := final_score_tree_66;
		SELF.final_score_tree_67_c528 := final_score_tree_67_c528;
		SELF.final_score_tree_67_c527 := final_score_tree_67_c527;
		SELF.final_score_tree_67_c526 := final_score_tree_67_c526;
		SELF.final_score_tree_67_c529 := final_score_tree_67_c529;
		SELF.final_score_tree_67 := final_score_tree_67;
		SELF.final_score_tree_68_c534 := final_score_tree_68_c534;
		SELF.final_score_tree_68_c533 := final_score_tree_68_c533;
		SELF.final_score_tree_68_c532 := final_score_tree_68_c532;
		SELF.final_score_tree_68_c531 := final_score_tree_68_c531;
		SELF.final_score_tree_68 := final_score_tree_68;
		SELF.final_score_tree_69_c538 := final_score_tree_69_c538;
		SELF.final_score_tree_69_c537 := final_score_tree_69_c537;
		SELF.final_score_tree_69_c536 := final_score_tree_69_c536;
		SELF.final_score_tree_69_c539 := final_score_tree_69_c539;
		SELF.final_score_tree_69 := final_score_tree_69;
		SELF.final_score_tree_70_c541 := final_score_tree_70_c541;
		SELF.final_score_tree_70_c544 := final_score_tree_70_c544;
		SELF.final_score_tree_70_c543 := final_score_tree_70_c543;
		SELF.final_score_tree_70_c542 := final_score_tree_70_c542;
		SELF.final_score_tree_70 := final_score_tree_70;
		SELF.final_score_tree_71_c549 := final_score_tree_71_c549;
		SELF.final_score_tree_71_c548 := final_score_tree_71_c548;
		SELF.final_score_tree_71_c547 := final_score_tree_71_c547;
		SELF.final_score_tree_71_c546 := final_score_tree_71_c546;
		SELF.final_score_tree_71 := final_score_tree_71;
		SELF.final_score_tree_72_c553 := final_score_tree_72_c553;
		SELF.final_score_tree_72_c552 := final_score_tree_72_c552;
		SELF.final_score_tree_72_c551 := final_score_tree_72_c551;
		SELF.final_score_tree_72_c554 := final_score_tree_72_c554;
		SELF.final_score_tree_72 := final_score_tree_72;
		SELF.final_score_tree_73_c559 := final_score_tree_73_c559;
		SELF.final_score_tree_73_c558 := final_score_tree_73_c558;
		SELF.final_score_tree_73_c557 := final_score_tree_73_c557;
		SELF.final_score_tree_73_c556 := final_score_tree_73_c556;
		SELF.final_score_tree_73 := final_score_tree_73;
		SELF.final_score_tree_74_c563 := final_score_tree_74_c563;
		SELF.final_score_tree_74_c562 := final_score_tree_74_c562;
		SELF.final_score_tree_74_c564 := final_score_tree_74_c564;
		SELF.final_score_tree_74_c561 := final_score_tree_74_c561;
		SELF.final_score_tree_74 := final_score_tree_74;
		SELF.final_score_tree_75_c568 := final_score_tree_75_c568;
		SELF.final_score_tree_75_c567 := final_score_tree_75_c567;
		SELF.final_score_tree_75_c566 := final_score_tree_75_c566;
		SELF.final_score_tree_75_c569 := final_score_tree_75_c569;
		SELF.final_score_tree_75 := final_score_tree_75;
		SELF.final_score_tree_76_c573 := final_score_tree_76_c573;
		SELF.final_score_tree_76_c572 := final_score_tree_76_c572;
		SELF.final_score_tree_76_c574 := final_score_tree_76_c574;
		SELF.final_score_tree_76_c571 := final_score_tree_76_c571;
		SELF.final_score_tree_76 := final_score_tree_76;
		SELF.final_score_tree_77_c576 := final_score_tree_77_c576;
		SELF.final_score_tree_77_c579 := final_score_tree_77_c579;
		SELF.final_score_tree_77_c578 := final_score_tree_77_c578;
		SELF.final_score_tree_77_c577 := final_score_tree_77_c577;
		SELF.final_score_tree_77 := final_score_tree_77;
		SELF.final_score_tree_78_c581 := final_score_tree_78_c581;
		SELF.final_score_tree_78_c584 := final_score_tree_78_c584;
		SELF.final_score_tree_78_c583 := final_score_tree_78_c583;
		SELF.final_score_tree_78_c582 := final_score_tree_78_c582;
		SELF.final_score_tree_78 := final_score_tree_78;
		SELF.final_score_tree_79_c589 := final_score_tree_79_c589;
		SELF.final_score_tree_79_c588 := final_score_tree_79_c588;
		SELF.final_score_tree_79_c587 := final_score_tree_79_c587;
		SELF.final_score_tree_79_c586 := final_score_tree_79_c586;
		SELF.final_score_tree_79 := final_score_tree_79;
		SELF.final_score_tree_80_c591 := final_score_tree_80_c591;
		SELF.final_score_tree_80_c593 := final_score_tree_80_c593;
		SELF.final_score_tree_80_c592 := final_score_tree_80_c592;
		SELF.final_score_tree_80_c594 := final_score_tree_80_c594;
		SELF.final_score_tree_80 := final_score_tree_80;
		SELF.final_score_tree_81_c599 := final_score_tree_81_c599;
		SELF.final_score_tree_81_c598 := final_score_tree_81_c598;
		SELF.final_score_tree_81_c597 := final_score_tree_81_c597;
		SELF.final_score_tree_81_c596 := final_score_tree_81_c596;
		SELF.final_score_tree_81 := final_score_tree_81;
		SELF.final_score_tree_82_c601 := final_score_tree_82_c601;
		SELF.final_score_tree_82_c604 := final_score_tree_82_c604;
		SELF.final_score_tree_82_c603 := final_score_tree_82_c603;
		SELF.final_score_tree_82_c602 := final_score_tree_82_c602;
		SELF.final_score_tree_82 := final_score_tree_82;
		SELF.final_score_tree_83_c606 := final_score_tree_83_c606;
		SELF.final_score_tree_83_c607 := final_score_tree_83_c607;
		SELF.final_score_tree_83_c609 := final_score_tree_83_c609;
		SELF.final_score_tree_83_c608 := final_score_tree_83_c608;
		SELF.final_score_tree_83 := final_score_tree_83;
		SELF.final_score_tree_84_c613 := final_score_tree_84_c613;
		SELF.final_score_tree_84_c612 := final_score_tree_84_c612;
		SELF.final_score_tree_84_c614 := final_score_tree_84_c614;
		SELF.final_score_tree_84_c611 := final_score_tree_84_c611;
		SELF.final_score_tree_84 := final_score_tree_84;
		SELF.final_score_tree_85_c619 := final_score_tree_85_c619;
		SELF.final_score_tree_85_c618 := final_score_tree_85_c618;
		SELF.final_score_tree_85_c617 := final_score_tree_85_c617;
		SELF.final_score_tree_85_c616 := final_score_tree_85_c616;
		SELF.final_score_tree_85 := final_score_tree_85;
		SELF.final_score_tree_86_c622 := final_score_tree_86_c622;
		SELF.final_score_tree_86_c621 := final_score_tree_86_c621;
		SELF.final_score_tree_86_c624 := final_score_tree_86_c624;
		SELF.final_score_tree_86_c623 := final_score_tree_86_c623;
		SELF.final_score_tree_86 := final_score_tree_86;
		SELF.final_score_tree_87_c627 := final_score_tree_87_c627;
		SELF.final_score_tree_87_c628 := final_score_tree_87_c628;
		SELF.final_score_tree_87_c626 := final_score_tree_87_c626;
		SELF.final_score_tree_87_c629 := final_score_tree_87_c629;
		SELF.final_score_tree_87 := final_score_tree_87;
		SELF.final_score_tree_88_c633 := final_score_tree_88_c633;
		SELF.final_score_tree_88_c632 := final_score_tree_88_c632;
		SELF.final_score_tree_88_c631 := final_score_tree_88_c631;
		SELF.final_score_tree_88_c634 := final_score_tree_88_c634;
		SELF.final_score_tree_88 := final_score_tree_88;
		SELF.final_score_tree_89_c639 := final_score_tree_89_c639;
		SELF.final_score_tree_89_c638 := final_score_tree_89_c638;
		SELF.final_score_tree_89_c637 := final_score_tree_89_c637;
		SELF.final_score_tree_89_c636 := final_score_tree_89_c636;
		SELF.final_score_tree_89 := final_score_tree_89;
		SELF.final_score_tree_90_c643 := final_score_tree_90_c643;
		SELF.final_score_tree_90_c644 := final_score_tree_90_c644;
		SELF.final_score_tree_90_c642 := final_score_tree_90_c642;
		SELF.final_score_tree_90_c641 := final_score_tree_90_c641;
		SELF.final_score_tree_90 := final_score_tree_90;
		SELF.final_score_tree_91_c647 := final_score_tree_91_c647;
		SELF.final_score_tree_91_c649 := final_score_tree_91_c649;
		SELF.final_score_tree_91_c648 := final_score_tree_91_c648;
		SELF.final_score_tree_91_c646 := final_score_tree_91_c646;
		SELF.final_score_tree_91 := final_score_tree_91;
		SELF.final_score_tree_92_c653 := final_score_tree_92_c653;
		SELF.final_score_tree_92_c652 := final_score_tree_92_c652;
		SELF.final_score_tree_92_c651 := final_score_tree_92_c651;
		SELF.final_score_tree_92_c654 := final_score_tree_92_c654;
		SELF.final_score_tree_92 := final_score_tree_92;
		SELF.final_score_tree_93_c657 := final_score_tree_93_c657;
		SELF.final_score_tree_93_c656 := final_score_tree_93_c656;
		SELF.final_score_tree_93_c659 := final_score_tree_93_c659;
		SELF.final_score_tree_93_c658 := final_score_tree_93_c658;
		SELF.final_score_tree_93 := final_score_tree_93;
		SELF.final_score_tree_94_c661 := final_score_tree_94_c661;
		SELF.final_score_tree_94_c664 := final_score_tree_94_c664;
		SELF.final_score_tree_94_c663 := final_score_tree_94_c663;
		SELF.final_score_tree_94_c662 := final_score_tree_94_c662;
		SELF.final_score_tree_94 := final_score_tree_94;
		SELF.final_score_tree_95_c666 := final_score_tree_95_c666;
		SELF.final_score_tree_95_c668 := final_score_tree_95_c668;
		SELF.final_score_tree_95_c667 := final_score_tree_95_c667;
		SELF.final_score_tree_95_c669 := final_score_tree_95_c669;
		SELF.final_score_tree_95 := final_score_tree_95;
		SELF.final_score_tree_96_c674 := final_score_tree_96_c674;
		SELF.final_score_tree_96_c673 := final_score_tree_96_c673;
		SELF.final_score_tree_96_c672 := final_score_tree_96_c672;
		SELF.final_score_tree_96_c671 := final_score_tree_96_c671;
		SELF.final_score_tree_96 := final_score_tree_96;
		SELF.final_score_tree_97_c677 := final_score_tree_97_c677;
		SELF.final_score_tree_97_c679 := final_score_tree_97_c679;
		SELF.final_score_tree_97_c678 := final_score_tree_97_c678;
		SELF.final_score_tree_97_c676 := final_score_tree_97_c676;
		SELF.final_score_tree_97 := final_score_tree_97;
		SELF.final_score_tree_98_c681 := final_score_tree_98_c681;
		SELF.final_score_tree_98_c684 := final_score_tree_98_c684;
		SELF.final_score_tree_98_c683 := final_score_tree_98_c683;
		SELF.final_score_tree_98_c682 := final_score_tree_98_c682;
		SELF.final_score_tree_98 := final_score_tree_98;
		SELF.final_score_tree_99_c686 := final_score_tree_99_c686;
		SELF.final_score_tree_99_c689 := final_score_tree_99_c689;
		SELF.final_score_tree_99_c688 := final_score_tree_99_c688;
		SELF.final_score_tree_99_c687 := final_score_tree_99_c687;
		SELF.final_score_tree_99 := final_score_tree_99;
		SELF.final_score_tree_100_c692 := final_score_tree_100_c692;
		SELF.final_score_tree_100_c691 := final_score_tree_100_c691;
		SELF.final_score_tree_100_c694 := final_score_tree_100_c694;
		SELF.final_score_tree_100_c693 := final_score_tree_100_c693;
		SELF.final_score_tree_100 := final_score_tree_100;
		SELF.final_score_tree_101_c697 := final_score_tree_101_c697;
		SELF.final_score_tree_101_c696 := final_score_tree_101_c696;
		SELF.final_score_tree_101_c699 := final_score_tree_101_c699;
		SELF.final_score_tree_101_c698 := final_score_tree_101_c698;
		SELF.final_score_tree_101 := final_score_tree_101;
		SELF.final_score_tree_102_c704 := final_score_tree_102_c704;
		SELF.final_score_tree_102_c703 := final_score_tree_102_c703;
		SELF.final_score_tree_102_c702 := final_score_tree_102_c702;
		SELF.final_score_tree_102_c701 := final_score_tree_102_c701;
		SELF.final_score_tree_102 := final_score_tree_102;
		SELF.final_score_tree_103_c706 := final_score_tree_103_c706;
		SELF.final_score_tree_103_c709 := final_score_tree_103_c709;
		SELF.final_score_tree_103_c708 := final_score_tree_103_c708;
		SELF.final_score_tree_103_c707 := final_score_tree_103_c707;
		SELF.final_score_tree_103 := final_score_tree_103;
		SELF.final_score_tree_104_c711 := final_score_tree_104_c711;
		SELF.final_score_tree_104_c713 := final_score_tree_104_c713;
		SELF.final_score_tree_104_c714 := final_score_tree_104_c714;
		SELF.final_score_tree_104_c712 := final_score_tree_104_c712;
		SELF.final_score_tree_104 := final_score_tree_104;
		SELF.final_score_tree_105_c717 := final_score_tree_105_c717;
		SELF.final_score_tree_105_c716 := final_score_tree_105_c716;
		SELF.final_score_tree_105_c718 := final_score_tree_105_c718;
		SELF.final_score_tree_105_c719 := final_score_tree_105_c719;
		SELF.final_score_tree_105 := final_score_tree_105;
		SELF.final_score_tree_106_c722 := final_score_tree_106_c722;
		SELF.final_score_tree_106_c721 := final_score_tree_106_c721;
		SELF.final_score_tree_106_c724 := final_score_tree_106_c724;
		SELF.final_score_tree_106_c723 := final_score_tree_106_c723;
		SELF.final_score_tree_106 := final_score_tree_106;
		SELF.final_score_tree_107_c727 := final_score_tree_107_c727;
		SELF.final_score_tree_107_c729 := final_score_tree_107_c729;
		SELF.final_score_tree_107_c728 := final_score_tree_107_c728;
		SELF.final_score_tree_107_c726 := final_score_tree_107_c726;
		SELF.final_score_tree_107 := final_score_tree_107;
		SELF.final_score_tree_108_c732 := final_score_tree_108_c732;
		SELF.final_score_tree_108_c734 := final_score_tree_108_c734;
		SELF.final_score_tree_108_c733 := final_score_tree_108_c733;
		SELF.final_score_tree_108_c731 := final_score_tree_108_c731;
		SELF.final_score_tree_108 := final_score_tree_108;
		SELF.final_score_tree_109_c737 := final_score_tree_109_c737;
		SELF.final_score_tree_109_c739 := final_score_tree_109_c739;
		SELF.final_score_tree_109_c738 := final_score_tree_109_c738;
		SELF.final_score_tree_109_c736 := final_score_tree_109_c736;
		SELF.final_score_tree_109 := final_score_tree_109;
		SELF.final_score_tree_110_c742 := final_score_tree_110_c742;
		SELF.final_score_tree_110_c744 := final_score_tree_110_c744;
		SELF.final_score_tree_110_c743 := final_score_tree_110_c743;
		SELF.final_score_tree_110_c741 := final_score_tree_110_c741;
		SELF.final_score_tree_110 := final_score_tree_110;
		SELF.final_score_tree_111_c749 := final_score_tree_111_c749;
		SELF.final_score_tree_111_c748 := final_score_tree_111_c748;
		SELF.final_score_tree_111_c747 := final_score_tree_111_c747;
		SELF.final_score_tree_111_c746 := final_score_tree_111_c746;
		SELF.final_score_tree_111 := final_score_tree_111;
		SELF.final_score_tree_112_c752 := final_score_tree_112_c752;
		SELF.final_score_tree_112_c751 := final_score_tree_112_c751;
		SELF.final_score_tree_112_c754 := final_score_tree_112_c754;
		SELF.final_score_tree_112_c753 := final_score_tree_112_c753;
		SELF.final_score_tree_112 := final_score_tree_112;
		SELF.final_score_tree_113_c759 := final_score_tree_113_c759;
		SELF.final_score_tree_113_c758 := final_score_tree_113_c758;
		SELF.final_score_tree_113_c757 := final_score_tree_113_c757;
		SELF.final_score_tree_113_c756 := final_score_tree_113_c756;
		SELF.final_score_tree_113 := final_score_tree_113;
		SELF.final_score_tree_114_c762 := final_score_tree_114_c762;
		SELF.final_score_tree_114_c761 := final_score_tree_114_c761;
		SELF.final_score_tree_114_c764 := final_score_tree_114_c764;
		SELF.final_score_tree_114_c763 := final_score_tree_114_c763;
		SELF.final_score_tree_114 := final_score_tree_114;
		SELF.final_score_tree_115_c766 := final_score_tree_115_c766;
		SELF.final_score_tree_115_c769 := final_score_tree_115_c769;
		SELF.final_score_tree_115_c768 := final_score_tree_115_c768;
		SELF.final_score_tree_115_c767 := final_score_tree_115_c767;
		SELF.final_score_tree_115 := final_score_tree_115;
		SELF.final_score_tree_116_c772 := final_score_tree_116_c772;
		SELF.final_score_tree_116_c771 := final_score_tree_116_c771;
		SELF.final_score_tree_116_c774 := final_score_tree_116_c774;
		SELF.final_score_tree_116_c773 := final_score_tree_116_c773;
		SELF.final_score_tree_116 := final_score_tree_116;
		SELF.final_score_tree_117_c777 := final_score_tree_117_c777;
		SELF.final_score_tree_117_c779 := final_score_tree_117_c779;
		SELF.final_score_tree_117_c778 := final_score_tree_117_c778;
		SELF.final_score_tree_117_c776 := final_score_tree_117_c776;
		SELF.final_score_tree_117 := final_score_tree_117;
		SELF.final_score_tree_118_c782 := final_score_tree_118_c782;
		SELF.final_score_tree_118_c784 := final_score_tree_118_c784;
		SELF.final_score_tree_118_c783 := final_score_tree_118_c783;
		SELF.final_score_tree_118_c781 := final_score_tree_118_c781;
		SELF.final_score_tree_118 := final_score_tree_118;
		SELF.final_score_tree_119_c788 := final_score_tree_119_c788;
		SELF.final_score_tree_119_c787 := final_score_tree_119_c787;
		SELF.final_score_tree_119_c786 := final_score_tree_119_c786;
		SELF.final_score_tree_119_c789 := final_score_tree_119_c789;
		SELF.final_score_tree_119 := final_score_tree_119;
		SELF.final_score_tree_120_c792 := final_score_tree_120_c792;
		SELF.final_score_tree_120_c793 := final_score_tree_120_c793;
		SELF.final_score_tree_120_c791 := final_score_tree_120_c791;
		SELF.final_score_tree_120_c794 := final_score_tree_120_c794;
		SELF.final_score_tree_120 := final_score_tree_120;
		SELF.final_score_tree_121_c799 := final_score_tree_121_c799;
		SELF.final_score_tree_121_c798 := final_score_tree_121_c798;
		SELF.final_score_tree_121_c797 := final_score_tree_121_c797;
		SELF.final_score_tree_121_c796 := final_score_tree_121_c796;
		SELF.final_score_tree_121 := final_score_tree_121;
		SELF.final_score_tree_122_c801 := final_score_tree_122_c801;
		SELF.final_score_tree_122_c803 := final_score_tree_122_c803;
		SELF.final_score_tree_122_c804 := final_score_tree_122_c804;
		SELF.final_score_tree_122_c802 := final_score_tree_122_c802;
		SELF.final_score_tree_122 := final_score_tree_122;
		SELF.final_score_tree_123_c809 := final_score_tree_123_c809;
		SELF.final_score_tree_123_c808 := final_score_tree_123_c808;
		SELF.final_score_tree_123_c807 := final_score_tree_123_c807;
		SELF.final_score_tree_123_c806 := final_score_tree_123_c806;
		SELF.final_score_tree_123 := final_score_tree_123;
		SELF.final_score_tree_124_c812 := final_score_tree_124_c812;
		SELF.final_score_tree_124_c811 := final_score_tree_124_c811;
		SELF.final_score_tree_124_c814 := final_score_tree_124_c814;
		SELF.final_score_tree_124_c813 := final_score_tree_124_c813;
		SELF.final_score_tree_124 := final_score_tree_124;
		SELF.final_score_tree_125_c817 := final_score_tree_125_c817;
		SELF.final_score_tree_125_c816 := final_score_tree_125_c816;
		SELF.final_score_tree_125_c819 := final_score_tree_125_c819;
		SELF.final_score_tree_125_c818 := final_score_tree_125_c818;
		SELF.final_score_tree_125 := final_score_tree_125;
		SELF.final_score_tree_126_c822 := final_score_tree_126_c822;
		SELF.final_score_tree_126_c823 := final_score_tree_126_c823;
		SELF.final_score_tree_126_c821 := final_score_tree_126_c821;
		SELF.final_score_tree_126_c824 := final_score_tree_126_c824;
		SELF.final_score_tree_126 := final_score_tree_126;
		SELF.final_score_tree_127_c827 := final_score_tree_127_c827;
		SELF.final_score_tree_127_c826 := final_score_tree_127_c826;
		SELF.final_score_tree_127_c829 := final_score_tree_127_c829;
		SELF.final_score_tree_127_c828 := final_score_tree_127_c828;
		SELF.final_score_tree_127 := final_score_tree_127;
		SELF.final_score_tree_128_c832 := final_score_tree_128_c832;
		SELF.final_score_tree_128_c834 := final_score_tree_128_c834;
		SELF.final_score_tree_128_c833 := final_score_tree_128_c833;
		SELF.final_score_tree_128_c831 := final_score_tree_128_c831;
		SELF.final_score_tree_128 := final_score_tree_128;
		SELF.final_score_tree_129_c838 := final_score_tree_129_c838;
		SELF.final_score_tree_129_c837 := final_score_tree_129_c837;
		SELF.final_score_tree_129_c836 := final_score_tree_129_c836;
		SELF.final_score_tree_129_c839 := final_score_tree_129_c839;
		SELF.final_score_tree_129 := final_score_tree_129;
		SELF.final_score_tree_130_c843 := final_score_tree_130_c843;
		SELF.final_score_tree_130_c842 := final_score_tree_130_c842;
		SELF.final_score_tree_130_c841 := final_score_tree_130_c841;
		SELF.final_score_tree_130_c844 := final_score_tree_130_c844;
		SELF.final_score_tree_130 := final_score_tree_130;
		SELF.final_score_tree_131_c848 := final_score_tree_131_c848;
		SELF.final_score_tree_131_c847 := final_score_tree_131_c847;
		SELF.final_score_tree_131_c849 := final_score_tree_131_c849;
		SELF.final_score_tree_131_c846 := final_score_tree_131_c846;
		SELF.final_score_tree_131 := final_score_tree_131;
		SELF.final_score_tree_132_c854 := final_score_tree_132_c854;
		SELF.final_score_tree_132_c853 := final_score_tree_132_c853;
		SELF.final_score_tree_132_c852 := final_score_tree_132_c852;
		SELF.final_score_tree_132_c851 := final_score_tree_132_c851;
		SELF.final_score_tree_132 := final_score_tree_132;
		SELF.final_score_tree_133_c857 := final_score_tree_133_c857;
		SELF.final_score_tree_133_c859 := final_score_tree_133_c859;
		SELF.final_score_tree_133_c858 := final_score_tree_133_c858;
		SELF.final_score_tree_133_c856 := final_score_tree_133_c856;
		SELF.final_score_tree_133 := final_score_tree_133;
		SELF.final_score_tree_134_c863 := final_score_tree_134_c863;
		SELF.final_score_tree_134_c862 := final_score_tree_134_c862;
		SELF.final_score_tree_134_c864 := final_score_tree_134_c864;
		SELF.final_score_tree_134_c861 := final_score_tree_134_c861;
		SELF.final_score_tree_134 := final_score_tree_134;
		SELF.final_score_tree_135_c869 := final_score_tree_135_c869;
		SELF.final_score_tree_135_c868 := final_score_tree_135_c868;
		SELF.final_score_tree_135_c867 := final_score_tree_135_c867;
		SELF.final_score_tree_135_c866 := final_score_tree_135_c866;
		SELF.final_score_tree_135 := final_score_tree_135;
		SELF.final_score_tree_136_c873 := final_score_tree_136_c873;
		SELF.final_score_tree_136_c872 := final_score_tree_136_c872;
		SELF.final_score_tree_136_c874 := final_score_tree_136_c874;
		SELF.final_score_tree_136_c871 := final_score_tree_136_c871;
		SELF.final_score_tree_136 := final_score_tree_136;
		SELF.final_score_tree_137_c879 := final_score_tree_137_c879;
		SELF.final_score_tree_137_c878 := final_score_tree_137_c878;
		SELF.final_score_tree_137_c877 := final_score_tree_137_c877;
		SELF.final_score_tree_137_c876 := final_score_tree_137_c876;
		SELF.final_score_tree_137 := final_score_tree_137;
		SELF.final_score_tree_138_c882 := final_score_tree_138_c882;
		SELF.final_score_tree_138_c884 := final_score_tree_138_c884;
		SELF.final_score_tree_138_c883 := final_score_tree_138_c883;
		SELF.final_score_tree_138_c881 := final_score_tree_138_c881;
		SELF.final_score_tree_138 := final_score_tree_138;
		SELF.final_score_tree_139_c889 := final_score_tree_139_c889;
		SELF.final_score_tree_139_c888 := final_score_tree_139_c888;
		SELF.final_score_tree_139_c887 := final_score_tree_139_c887;
		SELF.final_score_tree_139_c886 := final_score_tree_139_c886;
		SELF.final_score_tree_139 := final_score_tree_139;
		SELF.final_score_tree_140_c892 := final_score_tree_140_c892;
		SELF.final_score_tree_140_c891 := final_score_tree_140_c891;
		SELF.final_score_tree_140_c894 := final_score_tree_140_c894;
		SELF.final_score_tree_140_c893 := final_score_tree_140_c893;
		SELF.final_score_tree_140 := final_score_tree_140;
		SELF.final_score_tree_141_c899 := final_score_tree_141_c899;
		SELF.final_score_tree_141_c898 := final_score_tree_141_c898;
		SELF.final_score_tree_141_c897 := final_score_tree_141_c897;
		SELF.final_score_tree_141_c896 := final_score_tree_141_c896;
		SELF.final_score_tree_141 := final_score_tree_141;
		SELF.final_score_tree_142_c902 := final_score_tree_142_c902;
		SELF.final_score_tree_142_c904 := final_score_tree_142_c904;
		SELF.final_score_tree_142_c903 := final_score_tree_142_c903;
		SELF.final_score_tree_142_c901 := final_score_tree_142_c901;
		SELF.final_score_tree_142 := final_score_tree_142;
		SELF.final_score_tree_143_c908 := final_score_tree_143_c908;
		SELF.final_score_tree_143_c909 := final_score_tree_143_c909;
		SELF.final_score_tree_143_c907 := final_score_tree_143_c907;
		SELF.final_score_tree_143_c906 := final_score_tree_143_c906;
		SELF.final_score_tree_143 := final_score_tree_143;
		SELF.final_score_tree_144_c914 := final_score_tree_144_c914;
		SELF.final_score_tree_144_c913 := final_score_tree_144_c913;
		SELF.final_score_tree_144_c912 := final_score_tree_144_c912;
		SELF.final_score_tree_144_c911 := final_score_tree_144_c911;
		SELF.final_score_tree_144 := final_score_tree_144;
		SELF.final_score_tree_145_c917 := final_score_tree_145_c917;
		SELF.final_score_tree_145_c919 := final_score_tree_145_c919;
		SELF.final_score_tree_145_c918 := final_score_tree_145_c918;
		SELF.final_score_tree_145_c916 := final_score_tree_145_c916;
		SELF.final_score_tree_145 := final_score_tree_145;
		SELF.final_score_tree_146_c924 := final_score_tree_146_c924;
		SELF.final_score_tree_146_c923 := final_score_tree_146_c923;
		SELF.final_score_tree_146_c922 := final_score_tree_146_c922;
		SELF.final_score_tree_146_c921 := final_score_tree_146_c921;
		SELF.final_score_tree_146 := final_score_tree_146;
		SELF.final_score_tree_147_c929 := final_score_tree_147_c929;
		SELF.final_score_tree_147_c928 := final_score_tree_147_c928;
		SELF.final_score_tree_147_c927 := final_score_tree_147_c927;
		SELF.final_score_tree_147_c926 := final_score_tree_147_c926;
		SELF.final_score_tree_147 := final_score_tree_147;
		SELF.final_score_tree_148_c932 := final_score_tree_148_c932;
		SELF.final_score_tree_148_c933 := final_score_tree_148_c933;
		SELF.final_score_tree_148_c934 := final_score_tree_148_c934;
		SELF.final_score_tree_148_c931 := final_score_tree_148_c931;
		SELF.final_score_tree_148 := final_score_tree_148;
		SELF.final_score_tree_149_c936 := final_score_tree_149_c936;
		SELF.final_score_tree_149_c939 := final_score_tree_149_c939;
		SELF.final_score_tree_149_c938 := final_score_tree_149_c938;
		SELF.final_score_tree_149_c937 := final_score_tree_149_c937;
		SELF.final_score_tree_149 := final_score_tree_149;
		SELF.final_score_tree_150_c942 := final_score_tree_150_c942;
		SELF.final_score_tree_150_c941 := final_score_tree_150_c941;
		SELF.final_score_tree_150_c944 := final_score_tree_150_c944;
		SELF.final_score_tree_150_c943 := final_score_tree_150_c943;
		SELF.final_score_tree_150 := final_score_tree_150;
		SELF.final_score_tree_151_c947 := final_score_tree_151_c947;
		SELF.final_score_tree_151_c946 := final_score_tree_151_c946;
		SELF.final_score_tree_151_c949 := final_score_tree_151_c949;
		SELF.final_score_tree_151_c948 := final_score_tree_151_c948;
		SELF.final_score_tree_151 := final_score_tree_151;
		SELF.final_score_tree_152_c953 := final_score_tree_152_c953;
		SELF.final_score_tree_152_c954 := final_score_tree_152_c954;
		SELF.final_score_tree_152_c952 := final_score_tree_152_c952;
		SELF.final_score_tree_152_c951 := final_score_tree_152_c951;
		SELF.final_score_tree_152 := final_score_tree_152;
		SELF.final_score_tree_153_c958 := final_score_tree_153_c958;
		SELF.final_score_tree_153_c957 := final_score_tree_153_c957;
		SELF.final_score_tree_153_c959 := final_score_tree_153_c959;
		SELF.final_score_tree_153_c956 := final_score_tree_153_c956;
		SELF.final_score_tree_153 := final_score_tree_153;
		SELF.final_score_tree_154_c961 := final_score_tree_154_c961;
		SELF.final_score_tree_154_c963 := final_score_tree_154_c963;
		SELF.final_score_tree_154_c964 := final_score_tree_154_c964;
		SELF.final_score_tree_154_c962 := final_score_tree_154_c962;
		SELF.final_score_tree_154 := final_score_tree_154;
		SELF.final_score_tree_155_c966 := final_score_tree_155_c966;
		SELF.final_score_tree_155_c967 := final_score_tree_155_c967;
		SELF.final_score_tree_155_c969 := final_score_tree_155_c969;
		SELF.final_score_tree_155_c968 := final_score_tree_155_c968;
		SELF.final_score_tree_155 := final_score_tree_155;
		SELF.final_score_tree_156_c971 := final_score_tree_156_c971;
		SELF.final_score_tree_156_c974 := final_score_tree_156_c974;
		SELF.final_score_tree_156_c973 := final_score_tree_156_c973;
		SELF.final_score_tree_156_c972 := final_score_tree_156_c972;
		SELF.final_score_tree_156 := final_score_tree_156;
		SELF.final_score_tree_157_c979 := final_score_tree_157_c979;
		SELF.final_score_tree_157_c978 := final_score_tree_157_c978;
		SELF.final_score_tree_157_c977 := final_score_tree_157_c977;
		SELF.final_score_tree_157_c976 := final_score_tree_157_c976;
		SELF.final_score_tree_157 := final_score_tree_157;
		SELF.final_score_tree_158_c982 := final_score_tree_158_c982;
		SELF.final_score_tree_158_c981 := final_score_tree_158_c981;
		SELF.final_score_tree_158_c984 := final_score_tree_158_c984;
		SELF.final_score_tree_158_c983 := final_score_tree_158_c983;
		SELF.final_score_tree_158 := final_score_tree_158;
		SELF.final_score_tree_159_c989 := final_score_tree_159_c989;
		SELF.final_score_tree_159_c988 := final_score_tree_159_c988;
		SELF.final_score_tree_159_c987 := final_score_tree_159_c987;
		SELF.final_score_tree_159_c986 := final_score_tree_159_c986;
		SELF.final_score_tree_159 := final_score_tree_159;
		SELF.final_score_tree_160_c992 := final_score_tree_160_c992;
		SELF.final_score_tree_160_c994 := final_score_tree_160_c994;
		SELF.final_score_tree_160_c993 := final_score_tree_160_c993;
		SELF.final_score_tree_160_c991 := final_score_tree_160_c991;
		SELF.final_score_tree_160 := final_score_tree_160;
		SELF.final_score_tree_161_c997 := final_score_tree_161_c997;
		SELF.final_score_tree_161_c998 := final_score_tree_161_c998;
		SELF.final_score_tree_161_c996 := final_score_tree_161_c996;
		SELF.final_score_tree_161_c999 := final_score_tree_161_c999;
		SELF.final_score_tree_161 := final_score_tree_161;
		SELF.final_score_tree_162_c1002 := final_score_tree_162_c1002;
		SELF.final_score_tree_162_c1001 := final_score_tree_162_c1001;
		SELF.final_score_tree_162_c1004 := final_score_tree_162_c1004;
		SELF.final_score_tree_162_c1003 := final_score_tree_162_c1003;
		SELF.final_score_tree_162 := final_score_tree_162;
		SELF.final_score_tree_163_c1006 := final_score_tree_163_c1006;
		SELF.final_score_tree_163_c1008 := final_score_tree_163_c1008;
		SELF.final_score_tree_163_c1009 := final_score_tree_163_c1009;
		SELF.final_score_tree_163_c1007 := final_score_tree_163_c1007;
		SELF.final_score_tree_163 := final_score_tree_163;
		SELF.final_score_tree_164_c1014 := final_score_tree_164_c1014;
		SELF.final_score_tree_164_c1013 := final_score_tree_164_c1013;
		SELF.final_score_tree_164_c1012 := final_score_tree_164_c1012;
		SELF.final_score_tree_164_c1011 := final_score_tree_164_c1011;
		SELF.final_score_tree_164 := final_score_tree_164;
		SELF.final_score_tree_165_c1017 := final_score_tree_165_c1017;
		SELF.final_score_tree_165_c1016 := final_score_tree_165_c1016;
		SELF.final_score_tree_165_c1019 := final_score_tree_165_c1019;
		SELF.final_score_tree_165_c1018 := final_score_tree_165_c1018;
		SELF.final_score_tree_165 := final_score_tree_165;
		SELF.final_score_tree_166_c1021 := final_score_tree_166_c1021;
		SELF.final_score_tree_166_c1023 := final_score_tree_166_c1023;
		SELF.final_score_tree_166_c1024 := final_score_tree_166_c1024;
		SELF.final_score_tree_166_c1022 := final_score_tree_166_c1022;
		SELF.final_score_tree_166 := final_score_tree_166;
		SELF.final_score_tree_167_c1029 := final_score_tree_167_c1029;
		SELF.final_score_tree_167_c1028 := final_score_tree_167_c1028;
		SELF.final_score_tree_167_c1027 := final_score_tree_167_c1027;
		SELF.final_score_tree_167_c1026 := final_score_tree_167_c1026;
		SELF.final_score_tree_167 := final_score_tree_167;
		SELF.final_score_tree_168_c1031 := final_score_tree_168_c1031;
		SELF.final_score_tree_168_c1034 := final_score_tree_168_c1034;
		SELF.final_score_tree_168_c1033 := final_score_tree_168_c1033;
		SELF.final_score_tree_168_c1032 := final_score_tree_168_c1032;
		SELF.final_score_tree_168 := final_score_tree_168;
		SELF.final_score_tree_169_c1039 := final_score_tree_169_c1039;
		SELF.final_score_tree_169_c1038 := final_score_tree_169_c1038;
		SELF.final_score_tree_169_c1037 := final_score_tree_169_c1037;
		SELF.final_score_tree_169_c1036 := final_score_tree_169_c1036;
		SELF.final_score_tree_169 := final_score_tree_169;
		SELF.final_score_tree_170_c1044 := final_score_tree_170_c1044;
		SELF.final_score_tree_170_c1043 := final_score_tree_170_c1043;
		SELF.final_score_tree_170_c1042 := final_score_tree_170_c1042;
		SELF.final_score_tree_170_c1041 := final_score_tree_170_c1041;
		SELF.final_score_tree_170 := final_score_tree_170;
		SELF.final_score_tree_171_c1049 := final_score_tree_171_c1049;
		SELF.final_score_tree_171_c1048 := final_score_tree_171_c1048;
		SELF.final_score_tree_171_c1047 := final_score_tree_171_c1047;
		SELF.final_score_tree_171_c1046 := final_score_tree_171_c1046;
		SELF.final_score_tree_171 := final_score_tree_171;
		SELF.final_score_tree_172_c1053 := final_score_tree_172_c1053;
		SELF.final_score_tree_172_c1052 := final_score_tree_172_c1052;
		SELF.final_score_tree_172_c1051 := final_score_tree_172_c1051;
		SELF.final_score_tree_172_c1054 := final_score_tree_172_c1054;
		SELF.final_score_tree_172 := final_score_tree_172;
		SELF.final_score_gbm_logit := final_score_gbm_logit;
		SELF.pbr := pbr;
		SELF.sbr := sbr;
		SELF.offset := offset;
		SELF.base := base;
		SELF.pts := pts;
		SELF.lgt := lgt;
		SELF.osn1608_1_0 := (STRING)osn1608_1_0;
		
		/*  The risk indicators will get populated before the model is returned */ 
		SELF.ri                               := [];  
		
		SELF.score                            := (STRING3)osn1608_1_0;
		
		self.nf_seg_fraudpoint_3_0_BT					:= bf_seg_fraudpoint_3_0_BT;
		self.nf_seg_fraudpoint_3_0_ST					:= bf_seg_fraudpoint_3_0_ST; 
		SELF.btstclam := le.bs;
		
	#else	
	 
		self.nf_seg_fraudpoint_3_0_BT					:= bf_seg_fraudpoint_3_0_BT;
		self.nf_seg_fraudpoint_3_0_ST					:= bf_seg_fraudpoint_3_0_ST; 
		
		/*  The risk indicators will get populated before the model is returned */ 
		SELF.ri                               := [];
		
		SELF.score                            := (STRING3)osn1608_1_0;
		SELF.seq                              := le.bs.Bill_To_Out.seq;
	#end
	END;

	model := PROJECT(clam_with_easi, doModel(LEFT));
	
	
	
	/*  Format the Risk Indicators for this model   */
  
	/* populate the BillTo boca shell results into layout.output */  
	Risk_Indicators.Layout_BocaShell_BtSt.Layout_OutputWithInt into_layout_output(clam_with_easi le, model mob) := TRANSFORM
		SELF.seq                     := le.bs.Bill_To_Out.seq;
		SELF.socllowissue            := (STRING)le.bs.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
		SELF.soclhighissue           := (STRING)le.bs.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
		SELF.socsverlevel            := le.bs.Bill_To_Out.iid.NAS_summary;
		SELF.nxx_type                := le.bs.Bill_To_Out.phone_verification.telcordia_type;
		
		SELF.nf_seg_fraudpoint_3_0_BT := mob.nf_seg_fraudpoint_3_0_BT;	
		
		SELF.isShipToBillToDifferent := le.bs.isShipToBillToDifferent;
		SELF.email_verification      := (integer)le.bs.Bill_To_Out.email_summary.identity_email_verification_level;
		SELF                         := le.bs;                                              //BTST fields
		SELF                         := le.bs.Bill_To_Out.iid;
		SELF                         := le.bs.Bill_To_Out.shell_input;
		SELF                         := le.bs.bill_to_out;
		SELF.lastscore               := 0;  
		SELF.addrscore               := 0;  
		SELF                         := mob;
	END;
	
	iidBT := JOIN(clam_with_easi, model,
		LEFT.bs.Bill_To_Out.seq = RIGHT.SEQ,
		into_layout_output(LEFT, RIGHT), LEFT OUTER);
			
		
		
  /*  get the ip information from the clam   */ 
	 
	RiskWise.Layout_IP2O fill_ip(clam_with_easi le) := TRANSFORM
		SELF.countrycode := le.bs.ip2o.countrycode[1..2];
		SELF             := le.bs.ip2o;              /*  when the IP20 was populate it had seq # of the Bill To  */                
	END;
	
	ipInfo := PROJECT(clam_with_easi, fill_ip(LEFT));


 /*  join the IP information to Bill To section  */  
	Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
		SELF.seq := le.seq;                                                         //This is the Bill To Seq # (the even #'s in the record)
		output_layout := project(le, transform(Risk_Indicators.Layout_Output, self := left));
		/*  Populate BillTo Risk Indicators with charge back defender reason codes  */   
		SELF.ri := RiskWise.cdReasonCodes(output_layout, 
		                                              6, 
																								 rt, 
																							 TRUE, 
																						 IBICID, 
							 WantstoSeeBillToShipToDifferenceFlag, 
							                         WantsToSeeEA, 
																			         TRUE,                          //getBTSTfields
				                        le.btst_did_summary,                          // This is a field that represents information related to both the BT and ST.
													le.btst_cbd_inq_ver_count,                          // This is a field that represents information related to both the BT and ST. 
												le.btst_economic_trajectory,                          // This is a field that represents information related to both the BT and ST.  
				                        le.bt_inq_count_day,                          // This relates only to the BILL TO
				                        le.st_inq_count_day,                          // This relates only to the SHIP TO
																le.bt_inq_count_week,                                    // This relates only to the BILL TO 
																le.st_inq_count_week,                                    // This relates only to the SHIP TO 
                                nf_seg_fraudpoint_3_0 := le.nf_seg_fraudpoint_3_0_BT);   // This relates only to the BILL TO
		SELF := [];
	END;
	
	BTReasons := JOIN(iidBT, ipInfo, LEFT.seq = RIGHT.seq, addBTReasons(LEFT, RIGHT), LEFT OUTER);             //This seq # has the Bill To.

	#if(MODEL_DEBUG)
	 Layout_debug fillReasons(layout_debug le, BTreasons rt) := TRANSFORM
		SELF.ri := rt.ri;
		
	#else	
	Layout_ModelOut fillReasons(model le, BTreasons rt) := TRANSFORM
		SELF.ri := rt.ri;
	#end
		SELF := le;
	END;
	
	BTrecord := JOIN(model, BTReasons, LEFT.seq = RIGHT.seq, fillReasons(LEFT, RIGHT), LEFT OUTER);
	
	
	
	

	/* populate the shipto boca shell results into layout.output */   
	Risk_Indicators.Layout_BocaShell_BtSt.Layout_OutputWithInt into_layout_output2(clam_with_easi le, model mos) := TRANSFORM
		SELF.seq                       := le.bs.Ship_To_Out.seq;
		SELF.socllowissue              := (string)le.bs.Ship_To_Out.SSN_Verification.Validation.low_issue_date;
		SELF.soclhighissue             := (string)le.bs.Ship_To_Out.SSN_Verification.Validation.high_issue_date;
		SELF.socsverlevel              := le.bs.Ship_To_Out.iid.NAS_summary;
		SELF                           := le.bs.Ship_To_Out.iid;
		SELF                           := le.bs.Ship_To_Out.shell_input;
		SELF                           := le.bs.ship_to_out;
		SELF                           := le.bs;                 //BTST fields
		SELF.nf_seg_fraudpoint_3_0_ST  := mos.nf_seg_fraudpoint_3_0_ST;
		SELF.lastscore                 := 0;  
		SELF.addrscore                 := 0;
		SELF.email_verification        := (integer)le.bs.Ship_To_Out.email_summary.identity_email_verification_level;
		SELF                           := mos;
	END;

	iidST := JOIN(clam_with_easi, model,
		LEFT.bs.Bill_To_Out.seq = RIGHT.SEQ,                    //join using bill to seq # (that is the even #)  to get the ship to info
		into_layout_output2(LEFT, RIGHT), LEFT OUTER);
		
	Layout_ModelOut addSTReasons(iidST le, ipInfo rt) := TRANSFORM
		SELF.seq := le.seq;
		output_layout := project(le, transform(Risk_Indicators.Layout_Output, self := left));
		/*  Populate ShipTo Risk Indicators with charge back defender reason codes  */ 
		SELF.ri := RiskWise.cdReasonCodes(output_layout, 
		                                              6, 
																								 rt, 
																							false, 
																						 IBICID, 
																						  false, 
																							false, 
																							 TRUE,         //getBTSTfields
				                        le.btst_did_summary, 
													le.btst_cbd_inq_ver_count, 
												le.btst_economic_trajectory,
																le.bt_inq_count_day,                          // This relates only to the BILL TO
				                        le.st_inq_count_day,                          // This relates only to the SHIP TO
																le.bt_inq_count_week,                                    // This relates only to the BILL TO 
																le.st_inq_count_week,                                    // This relates only to the SHIP TO 
				                        nf_seg_fraudpoint_3_0 := le.nf_seg_fraudpoint_3_0_ST);
		SELF := [];
	END;
	STReasons := JOIN(iidST, ipInfo, LEFT.seq=((RIGHT.seq)-1), addSTReasons(LEFT, RIGHT), LEFT OUTER);	   
		

	#if(MODEL_DEBUG)
	 layout_debug fillReasons2(layout_debug le, STreasons rt) := TRANSFORM
		SELF.ri := le.ri + rt.ri;

	#else
	 Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := TRANSFORM
		SELF.ri := le.ri + rt.ri;
  #end
		SELF := le;
	END;

	STRecord := JOIN(BTRecord, STReasons, ((LEFT.seq)+1) = RIGHT.seq, fillReasons2(LEFT, RIGHT), LEFT OUTER);

    // OUTPUT(iidBT,            named('iidBT'));
    // OUTPUT(BTReasons,        named('BTReasons'));
	  // OUTPUT(BTRecord,         named('BTRecord'));
		// OUTPUT(ipInfo,           named('ipInfo'));  
  
    // OUTPUT(iidST,            named('iidST'));
    // OUTPUT(STReasons,        named('STReasons'));
	  // OUTPUT(STRecord,         named('STRecord')); 
		

	RETURN(STRecord);
END;
