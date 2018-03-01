IMPORT ut, RiskWise, Risk_Indicators, business_risk, easi, std;

export CDN1508_1_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
									dataset(RiskWise.Layout_CD2I) indata,
									boolean isBusiness,
									dataset(business_risk.layout_biid_btst_output) biid) := 

FUNCTION  //cheated

 /************************************************************************************
 * Build Easi census data                                                            *
 ************************************************************************************/

//saving time by using the address input rather than re-clean address
	layout_cd2iPlus := RECORD
		RiskWise.Layout_CD2I;
		string3 county := '';
		string7 geo_blk := '';
		string3 county2 := '';
		string7 geo_blk2 := '';
	END;

	layout_ineasi := record
		layout_cd2iPlus cd2i;
		recordof(EASI.Key_Easi_Census) easi;
		recordof(EASI.Key_Easi_Census) easi2;
	END;
	layout_model_in := RECORD
		Risk_Indicators.Layout_BocaShell_BtSt_Out bs;
		layout_cd2iPlus cd2i;
		recordof(EASI.Key_Easi_Census) easi;
		recordof(EASI.Key_Easi_Census) easi2;
	END;
	layout_model_in join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
		SELF.bs := le;
		SELF.easi := ri;	
		self.cd2i.county := le.bill_to_out.shell_input.county;
		self.cd2i.state := le.bill_to_out.shell_input.st;
		self.cd2i.geo_blk := le.bill_to_out.shell_input.geo_blk;
		self.cd2i := le;
		self	:= [];
	END;	

	clam_with_bt_easi := join(clam, Easi.Key_Easi_Census,
				 keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 join2recs(left,right),
				 left outer,
				 ATMOST(keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 RiskWise.max_atmost),keep(1));		

	layout_model_in joinEm(clam_with_bt_easi le, Easi.Key_Easi_Census ri) := TRANSFORM
		self.easi2 := ri;
		self.cd2i.county2 := le.bs.ship_to_out.shell_input.county;
		self.cd2i.state := le.bs.ship_to_out.shell_input.st;
		self.cd2i.geo_blk2 := le.bs.ship_to_out.shell_input.geo_blk;
		self.cd2i := le;
		self := le;
	END;

	with_census_tmp := join(clam_with_bt_easi, Easi.Key_Easi_Census,
				keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				joinEm(left,right),
				left outer,
				ATMOST(keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				RiskWise.max_atmost),keep(1));

	with_census := join(indata, with_census_tmp,
		(left.seq*2) = right.bs.bill_to_out.seq,
		transform(layout_model_in, 
			self.cd2i.seq 			 := left.seq,
			self.cd2i.pymtmethod := left.pymtmethod,
			self.cd2i.avscode    := left.avscode ,
			self.cd2i.cidcode    := left.cidcode ,
			self.cd2i.shipmode   := left.shipmode,
			self.cd2i.orderamt   := left.orderamt,
			self.cd2i.ordertype  := left.ordertype,
			self.cd2i.prodcode   := left.prodcode,
			self.cd2i.channel    := left.channel,
			self := right), right outer);

/* ================================================================================================================================ */

	// MODEL_DEBUG := TRUE;
	MODEL_DEBUG := false;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			UNSIGNED SEQ;

			/* Additional Model Variables */
			STRING pymtmethod;		//pay_code_1
			STRING avscode;			//avs_response_code
			STRING cidcode;			//cid_response_code
			STRING shipmode;			//local_ship_code
			STRING orderamt;			//order_amt
			STRING ordertype;		//us_business_consumer_flag
			STRING prodcode;			//base_sku_product_desc
			STRING channel;			//acquisition_channel

			/* Intermediate Variables */
			INTEGER sysdate;
			REAL bt_cen_blue_col;
			REAL bt_cen_business;
			REAL bt_cen_civ_emp;
			REAL bt_cen_easiqlife;
			REAL bt_cen_families;
			REAL bt_cen_health;
			REAL bt_cen_high_ed;
			REAL bt_cen_high_hval;
			REAL bt_cen_incollege;
			REAL bt_cen_lar_fam;
			REAL bt_cen_low_hval;
			REAL bt_cen_med_hval;
			REAL bt_cen_med_rent;
			REAL bt_cen_no_move;
			REAL bt_cen_ownocc_p;
			REAL bt_cen_pop_0_5_p;
			REAL bt_cen_rental;
			REAL bt_cen_retired2;
			REAL bt_cen_span_lang;
			REAL bt_cen_totcrime;
			REAL bt_cen_trailer;
			REAL bt_cen_unemp;
			REAL bt_cen_urban_p;
			REAL bt_cen_vacant_p;
			REAL bt_cen_very_rich;
			REAL st_cen_blue_col;
			REAL st_cen_business;
			REAL st_cen_civ_emp;
			REAL ST_cen_easiqlife;
			REAL st_cen_families;
			REAL st_cen_health;
			REAL st_cen_high_ed;
			REAL st_cen_high_hval;
			REAL st_cen_incollege;
			REAL st_cen_lar_fam;
			REAL st_cen_low_hval;
			REAL st_cen_med_hhinc;
			REAL st_cen_med_hval;
			REAL st_cen_med_rent;
			REAL st_cen_mil_emp;
			REAL st_cen_no_move;
			REAL st_cen_ownocc_p;
			REAL st_cen_pop_0_5_p;
			REAL st_cen_rental;
			REAL st_cen_retired2;
			REAL st_cen_span_lang;
			REAL st_cen_totcrime;
			REAL st_cen_trailer;
			REAL st_cen_unemp;
			REAL ST_cen_urban_p;
			REAL st_cen_vacant_p;
			REAL st_cen_very_rich;
			REAL _bureau_adl_fseen_en;
			INTEGER _bureau_adl_fseen_en_s;
			REAL _bureau_adl_fseen_eq;
			INTEGER _bureau_adl_fseen_eq_s;
			REAL _bureau_adl_fseen_tn;
			INTEGER _bureau_adl_fseen_tn_s;
			REAL _bureau_adl_fseen_ts;
			INTEGER _bureau_adl_fseen_ts_s;
			REAL _bureau_adl_fseen_tu;
			INTEGER _bureau_adl_fseen_tu_s;
			BOOLEAN _bureauonly;
			BOOLEAN _bureauonly_s;
			REAL _credit_source_cnt;
			INTEGER _credit_source_cnt_s;
			BOOLEAN _deceased;
			BOOLEAN _deceased_s;
			BOOLEAN _derog;
			BOOLEAN _derog_s;
			INTEGER _foreclosure_last_date_s;
			REAL _header_first_seen;
			INTEGER _header_first_seen_s;
			REAL _hh_strikes;
			INTEGER _hh_strikes_s;
			REAL _in_dob;
			INTEGER _in_dob_s;
			BOOLEAN _inputmiskeys;
			BOOLEAN _inputmiskeys_s;
			REAL _liens_rel_ot_last_seen;
			INTEGER _liens_rel_ot_last_seen_s;
			REAL _liens_unrel_ot_first_seen;
			INTEGER _liens_unrel_ot_last_seen_s;
			INTEGER _liens_unrel_sc_first_seen_s;
			REAL _liens_unrel_st_first_seen;
			REAL _liens_unrel_st_last_seen;
			BOOLEAN _multiplessns;
			BOOLEAN _multiplessns_s;
			REAL _src_bureau_adl_fseen;
			REAL _src_bureau_adl_fseen_all;
			REAL _src_bureau_adl_fseen_notu;
			INTEGER _src_bureau_adl_fseen_notu_s;
			INTEGER _src_bureau_adl_fseen_s;
			BOOLEAN _ssnpriortodob;
			BOOLEAN _ssnpriortodob_s;
			REAL _ver_src_cnt;
			INTEGER _ver_src_cnt_s;
			BOOLEAN _ver_src_de;
			BOOLEAN _ver_src_de_s;
			BOOLEAN _ver_src_ds;
			BOOLEAN _ver_src_ds_s;
			BOOLEAN _ver_src_en;
			BOOLEAN _ver_src_en_s;
			BOOLEAN _ver_src_eq;
			BOOLEAN _ver_src_eq_s;
			BOOLEAN _ver_src_tn;
			BOOLEAN _ver_src_tn_s;
			BOOLEAN _ver_src_tu;
			BOOLEAN _ver_src_tu_s;
			REAL add_curr_nhood_prop_sum;
			INTEGER add_curr_nhood_prop_sum_s;
			STRING add_ec1_s;
			STRING add_ec3_s;
			STRING add_ec4_s;
			REAL add_input_nhood_prop_sum;
			INTEGER add_input_nhood_prop_sum_s;
			INTEGER addr_match;
			REAL b_a46_curr_avm_autoval_d;
			REAL b_a49_curr_avm_chg_1yr_i;
			REAL b_a49_curr_avm_chg_1yr_pct_i;
			REAL b_a50_pb_average_dollars_d;
			REAL b_a50_pb_total_dollars_d;
			REAL b_a50_pb_total_orders_d;
			REAL b_add_curr_mobility_index_i;
			REAL b_add_curr_nhood_bus_pct_i;
			REAL b_add_curr_nhood_mfd_pct_i;
			REAL b_add_curr_nhood_sfd_pct_d;
			REAL b_add_curr_nhood_vac_pct_i;
			REAL b_add_input_mobility_index_i;
			REAL b_add_input_nhood_bus_pct_i;
			REAL b_add_input_nhood_mfd_pct_i;
			REAL b_add_input_nhood_sfd_pct_d;
			REAL b_add_input_nhood_vac_pct_i;
			REAL b_addrchangecrimediff_i;
			REAL b_addrchangeecontrajindex_d;
			REAL b_addrchangeincomediff_d;
			REAL b_addrchangevaluediff_d;
			REAL b_adl_per_email_i;
			REAL b_bus_name_nover_i;
			REAL b_bus_phone_match_d;
			REAL b_c10_m_hdr_fs_d;
			REAL b_c12_source_profile_d;
			REAL b_c13_curr_addr_lres_d;
			REAL b_c13_max_lres_d;
			REAL b_c14_addr_stability_v2_d;
			REAL b_c14_addrs_10yr_i;
			REAL b_c14_addrs_15yr_i;
			REAL b_c14_addrs_5yr_i;
			REAL b_c18_invalid_addrs_per_adl_i;
			REAL b_c20_email_count_i;
			INTEGER b_c20_email_verification_d;
			REAL b_c21_m_bureau_adl_fs_d;
			REAL b_c23_inp_addr_occ_index_d;
			REAL b_comb_age_d;
			REAL b_componentcharrisktype_i;
			REAL b_corrphonelastnamecount_d;
			REAL b_crim_rel_under100miles_cnt_i;
			REAL b_curraddractivephonelist_d;
			REAL b_curraddrburglaryindex_i;
			INTEGER b_curraddrcrimeindex_i;
			REAL b_curraddrmedianincome_d;
			REAL b_curraddrmedianvalue_d;
			REAL b_curraddrmurderindex_i;
			INTEGER b_d31_bk_disposed_hist_count_i;
			REAL b_divaddrsuspidcountnew_i;
			REAL b_divrisktype_i;
			INTEGER b_divsrchaddrsuspidcount_i;
			REAL b_e57_br_source_count_d;
			REAL b_estimated_income_d;
			REAL b_f01_inp_addr_address_score_d;
			REAL b_f03_address_match_d;
			REAL b_f04_curr_add_occ_index_d;
			INTEGER b_fp_prevaddrburglaryindex_i;
			INTEGER b_fp_prevaddrcrimeindex_i;
			REAL b_hh_age_18_plus_d;
			REAL b_hh_age_30_plus_d;
			REAL b_hh_age_65_plus_d;
			REAL b_hh_bankruptcies_i;
			REAL b_hh_members_ct_d;
			REAL b_i60_inq_auto_recency_d;
			REAL b_i60_inq_count12_i;
			REAL b_i60_inq_mortgage_recency_d;
			REAL b_i60_inq_recency_d;
			REAL b_i60_inq_retail_recency_d;
			INTEGER b_i60_inq_retpymt_recency_d;
			REAL b_i61_inq_collection_count12_i;
			REAL b_inq_adls_per_addr_i;
			REAL b_inq_adls_per_phone_i;
			REAL b_inq_collection_count24_i;
			REAL b_inq_count24_i;
			INTEGER b_inq_highriskcredit_count24_i;
			REAL b_inq_lnames_per_addr_i;
			REAL b_inq_other_count24_i;
			REAL b_inq_per_addr_i;
			REAL b_inq_per_phone_i;
			INTEGER b_inq_retail_count_week_i;
			REAL b_inq_retail_count24_i;
			REAL b_inq_ssns_per_addr_i;
			REAL b_l71_add_business_i;
			INTEGER b_l75_add_drop_delivery_i;
			REAL b_l79_adls_per_addr_c6_i;
			REAL b_l79_adls_per_addr_curr_i;
			REAL b_l80_inp_avm_autoval_d;
			REAL b_liens_rel_ot_total_amt_i;
			REAL b_liens_unrel_st_total_amt_i;
			REAL b_m_bureau_adl_fs_all_d;
			REAL b_m_bureau_adl_fs_notu_d;
			REAL b_mos_liens_rel_ot_lseen_d;
			REAL b_mos_liens_unrel_ot_fseen_d;
			INTEGER b_mos_liens_unrel_st_fseen_d;
			INTEGER b_mos_liens_unrel_st_lseen_d;
			INTEGER b_nap_contradictory_i;
			INTEGER b_nap_phn_verd_d;
			REAL b_p85_phn_invalid_i;
			REAL b_p85_phn_not_issued_i;
			REAL b_p88_phn_dst_to_inp_add_i;
			REAL b_pb_order_freq_d;
			REAL b_phone_ver_experian_d;
			REAL b_phone_ver_insurance_d;
			REAL b_phones_per_addr_c6_i;
			REAL b_phones_per_addr_curr_i;
			REAL b_prevaddrageoldest_d;
			REAL b_prevaddrlenofres_d;
			REAL b_prevaddrmedianincome_d;
			REAL b_prevaddrmedianvalue_d;
			REAL b_prevaddrmurderindex_i;
			REAL b_property_owners_ct_d;
			REAL b_rel_ageover30_count_d;
			REAL b_rel_ageover40_count_d;
			REAL b_rel_count_i;
			REAL b_rel_educationover12_count_d;
			REAL b_rel_felony_count_i;
			REAL b_rel_homeover300_count_d;
			REAL b_rel_homeover50_count_d;
			REAL b_rel_homeover500_count_d;
			REAL b_rel_incomeover100_count_d;
			REAL b_rel_incomeover25_count_d;
			REAL b_rel_incomeover50_count_d;
			REAL b_rel_incomeover75_count_d;
			REAL b_rel_under100miles_cnt_d;
			INTEGER b_sourcerisktype_i;
			INTEGER b_srchaddrsrchcountmo_i;
			INTEGER b_srchaddrsrchcountwk_i;
			REAL b_srchcountwk_i;
			REAL b_srchunvrfdphonecount_i;
			REAL b_srchunvrfdssncount_i;
			INTEGER b_srchvelocityrisktype_i;
			INTEGER b_util_add_input_conv_n;
			INTEGER b_util_add_input_inf_n;
			REAL b_vardobcountnew_i;
			REAL b_varmsrcssncount_i;
			INTEGER b_varmsrcssnunrelcount_i;
			REAL b_varrisktype_i;
			STRING bf_seg_fraudpoint_3_0;
			INTEGER bs_segment2;
			INTEGER btst_are_relatives;
			REAL btst_distaddraddr2_i;
			REAL btst_distphone2addr2_i;
			REAL btst_distphoneaddr_i;
			REAL btst_distphoneaddr2_i;
			INTEGER btst_email_last_score_d;
			STRING btst_email_topleveldomain_n;
			INTEGER btst_firstscore_d;
			INTEGER btst_lastscore_d;
			INTEGER btst_relatives_in_common;
			STRING btst_relatives_lvl_d;
			REAL bureau_adl_en_fseen_pos;
			INTEGER bureau_adl_en_fseen_pos_s;
			REAL bureau_adl_eq_fseen_pos;
			INTEGER bureau_adl_eq_fseen_pos_s;
			STRING bureau_adl_fseen_en;
			STRING bureau_adl_fseen_en_s;
			STRING bureau_adl_fseen_eq;
			STRING bureau_adl_fseen_eq_s;
			STRING bureau_adl_fseen_tn;
			STRING bureau_adl_fseen_tn_s;
			STRING bureau_adl_fseen_ts;
			STRING bureau_adl_fseen_ts_s;
			STRING bureau_adl_fseen_tu;
			STRING bureau_adl_fseen_tu_s;
			REAL bureau_adl_tn_fseen_pos;
			INTEGER bureau_adl_tn_fseen_pos_s;
			REAL bureau_adl_ts_fseen_pos;
			INTEGER bureau_adl_ts_fseen_pos_s;
			REAL bureau_adl_tu_fseen_pos;
			INTEGER bureau_adl_tu_fseen_pos_s;
			INTEGER dell_segmentation2;
			INTEGER dell_segmentation3;
			INTEGER did_match;
			STRING email_topleveldomain;
			STRING final_model_segment;
			INTEGER fname_match;
			INTEGER lname_match;
			STRING pf_acquisition_channel;
			INTEGER pf_avs_addr;
			INTEGER pf_avs_error;
			INTEGER pf_avs_intl;
			INTEGER pf_avs_invalid;
			INTEGER pf_avs_name;
			INTEGER pf_avs_no_match;
			INTEGER pf_avs_not_supp;
			STRING pf_avs_result;
			INTEGER pf_avs_unavail;
			INTEGER pf_avs_zip;
			INTEGER pf_business_flag;
			STRING pf_cid_result;
			INTEGER pf_order_amt_c;
			STRING pf_pmt_type;
			INTEGER pf_pmt_x_avs_lvl;
			INTEGER pf_product_desc;
			STRING pf_ship_method;
			REAL s_a41_prop_owner_d;
			REAL s_a46_curr_avm_autoval_d;
			REAL s_a49_curr_avm_chg_1yr_i;
			REAL s_a50_pb_average_dollars_d;
			REAL s_a50_pb_total_dollars_d;
			REAL s_a50_pb_total_orders_d;
			REAL s_add_curr_mobility_index_i;
			REAL s_add_curr_nhood_bus_pct_i;
			REAL s_add_curr_nhood_mfd_pct_i;
			REAL s_add_curr_nhood_sfd_pct_d;
			REAL s_add_curr_nhood_vac_pct_i;
			REAL s_add_input_mobility_index_i;
			REAL s_add_input_nhood_bus_pct_i;
			REAL s_add_input_nhood_mfd_pct_i;
			REAL s_add_input_nhood_sfd_pct_d;
			REAL s_add_input_nhood_vac_pct_i;
			REAL s_addrchangecrimediff_i;
			REAL s_addrchangeecontrajindex_d;
			REAL s_addrchangeincomediff_d;
			REAL s_addrchangevaluediff_d;
			REAL s_assoccredbureaucount_i;
			INTEGER s_assocrisktype_i;
			REAL s_assocsuspicousidcount_i;
			REAL s_bus_name_nover_i;
			REAL s_bus_phone_match_d;
			REAL s_c10_m_hdr_fs_d;
			REAL s_c12_nonderog_recency_i;
			REAL s_c12_source_profile_d;
			REAL s_c12_source_profile_index_d;
			REAL s_c13_curr_addr_lres_d;
			REAL s_c14_addrs_10yr_i;
			REAL s_c14_addrs_15yr_i;
			INTEGER s_c17_inv_phn_per_adl_i;
			INTEGER s_c18_inv_add_per_adl_c6_i;
			REAL s_c18_invalid_addrs_per_adl_i;
			REAL s_c20_email_count_i;
			INTEGER s_c20_email_verification_d;
			REAL s_c21_m_bureau_adl_fs_d;
			REAL s_comb_age_d;
			REAL s_corrrisktype_i;
			REAL s_curraddrburglaryindex_i;
			REAL s_curraddrcartheftindex_i;
			REAL s_curraddrcrimeindex_i;
			REAL s_curraddrmedianincome_d;
			REAL s_curraddrmedianvalue_d;
			REAL s_curraddrmurderindex_i;
			REAL s_d34_unrel_liens_ct_i;
			REAL s_divaddrsuspidcountnew_i;
			REAL s_e57_br_source_count_d;
			REAL s_estimated_income_d;
			REAL s_f01_inp_addr_address_score_d;
			REAL s_fp_prevaddrburglaryindex_i;
			REAL s_fp_prevaddrcrimeindex_i;
			INTEGER s_has_pb_record_d;
			REAL s_hh_age_30_plus_d;
			REAL s_hh_collections_ct_i;
			INTEGER s_i60_credit_seeking_i;
			REAL s_i60_inq_auto_count12_i;
			REAL s_i60_inq_comm_recency_d;
			REAL s_i60_inq_count12_i;
			INTEGER s_i60_inq_hiriskcred_count12_i;
			REAL s_i60_inq_hiriskcred_recency_d;
			INTEGER s_i60_inq_prepaidcards_recency_d;
			REAL s_i60_inq_recency_d;
			REAL s_i60_inq_retail_recency_d;
			REAL s_i61_inq_collection_count12_i;
			REAL s_idrisktype_i;
			INTEGER s_inf_contradictory_i;
			REAL s_inq_adls_per_addr_i;
			REAL s_inq_adls_per_phone_i;
			INTEGER s_inq_communications_count24_i;
			REAL s_inq_count24_i;
			INTEGER s_inq_highriskcredit_count24_i;
			REAL s_inq_lnames_per_addr_i;
			REAL s_inq_per_addr_i;
			REAL s_inq_per_phone_i;
			REAL s_inq_ssns_per_addr_i;
			REAL s_l70_add_invalid_i;
			REAL s_l70_add_standardized_i;
			REAL s_l71_add_business_i;
			REAL s_l79_adls_per_addr_c6_i;
			REAL s_l79_adls_per_addr_curr_i;
			REAL s_l80_inp_avm_autoval_d;
			REAL s_liens_rel_ot_total_amt_i;
			INTEGER s_liens_unrel_st_total_amt_i;
			REAL s_m_bureau_adl_fs_notu_d;
			INTEGER s_mos_foreclosure_lseen_d;
			INTEGER s_mos_liens_rel_ot_lseen_d;
			INTEGER s_mos_liens_unrel_ot_lseen_d;
			INTEGER s_mos_liens_unrel_sc_fseen_d;
			INTEGER s_nap_addr_verd_d;
			INTEGER s_nap_contradictory_i;
			INTEGER s_nap_lname_verd_d;
			INTEGER s_nap_nothing_found_i;
			INTEGER s_nap_phn_verd_d;
			INTEGER s_p85_phn_invalid_i;	
			REAL s_p85_phn_not_issued_i;
			REAL s_p88_phn_dst_to_inp_add_i;
			REAL s_pb_order_freq_d;
			REAL s_phone_ver_experian_d;
			REAL s_phone_ver_insurance_d;
			REAL s_phones_per_addr_c6_i;
			REAL s_prevaddrageoldest_d;
			REAL s_prevaddrcartheftindex_i;
			REAL s_prevaddrlenofres_d;
			REAL s_prevaddrmedianvalue_d;
			REAL s_prevaddrmurderindex_i;
			REAL s_prevaddrstatus_i;
			INTEGER s_recent_disconnects_i;
			REAL s_rel_ageover40_count_d;
			REAL s_rel_count_i;
			INTEGER s_rel_criminal_count_i;
			REAL s_rel_educationover12_count_d;
			INTEGER s_rel_felony_count_i;
			INTEGER s_rel_homeover300_count_d;
			REAL s_rel_homeover50_count_d;
			REAL s_rel_homeover500_count_d;
			REAL s_rel_incomeover50_count_d;
			REAL s_rel_incomeover75_count_d;
			REAL s_rel_under100miles_cnt_d;
			REAL s_rel_under25miles_cnt_d;
			REAL s_rel_under500miles_cnt_d;
			INTEGER s_srchaddrsrchcountmo_i;
			INTEGER s_srchaddrsrchcountwk_i;
			INTEGER s_srchcomponentrisktype_i;
			INTEGER s_srchphonesrchcountwk_i;
			REAL s_srchunvrfdaddrcount_i;
			REAL s_srchvelocityrisktype_i;
			INTEGER s_util_add_input_conv_n;
			REAL s_util_add_input_inf_n;
			INTEGER s_util_add_input_misc_n;
			REAL s_util_adl_count_n;
			REAL s_validationrisktype_i;
			REAL s_varmsrcssnunrelcount_i;
			REAL s_varrisktype_i;
			STRING sf_seg_fraudpoint_3_0;
			REAL yr_in_dob;
			REAL yr_in_dob_int;
			INTEGER yr_in_dob_int_s;
			REAL yr_in_dob_s;
			real final_score_0;
			real final_score_1;
			real final_score_2;
			real final_score_3;
			real final_score_4;
			real final_score_5;
			real final_score_6;
			real final_score_7;
			real final_score_8;
			real final_score_9;
			real final_score_10;
			real final_score_11;
			real final_score_12;
			real final_score_13;
			real final_score_14;
			real final_score_15;
			real final_score_16;
			real final_score_17;
			real final_score_18;
			real final_score_19;
			real final_score_20;
			real final_score_21;
			real final_score_22;
			real final_score_23;
			real final_score_24;
			real final_score_25;
			real final_score_26;
			real final_score_27;
			real final_score_28;
			real final_score_29;
			real final_score_30;
			real final_score_31;
			real final_score_32;
			real final_score_33;
			real final_score_34;
			real final_score_35;
			real final_score_36;
			real final_score_37;
			real final_score_38;
			real final_score_39;
			real final_score_40;
			real final_score_41;
			real final_score_42;
			real final_score_43;
			real final_score_44;
			real final_score_45;
			real final_score_46;
			real final_score_47;
			real final_score_48;
			real final_score_49;
			real final_score_50;
			real final_score_51;
			real final_score_52;
			real final_score_53;
			real final_score_54;
			real final_score_55;
			real final_score_56;
			real final_score_57;
			real final_score_58;
			real final_score_59;
			real final_score_60;
			real final_score_61;
			real final_score_62;
			real final_score_63;
			real final_score_64;
			real final_score_65;
			real final_score_66;
			real final_score_67;
			real final_score_68;
			real final_score_69;
			real final_score_70;
			real final_score_71;
			real final_score_72;
			real final_score_73;
			real final_score_74;
			real final_score_75;
			real final_score_76;
			real final_score_77;
			real final_score_78;
			real final_score_79;
			real final_score_80;
			real final_score_81;
			real final_score_82;
			real final_score_83;
			real final_score_84;
			real final_score_85;
			real final_score_86;
			real final_score_87;
			real final_score_88;
			real final_score_89;
			real final_score_90;
			real final_score_91;
			real final_score_92;
			real final_score_93;
			real final_score_94;
			real final_score_95;
			real final_score_96;
			real final_score_97;
			real final_score_98;
			real final_score_99;
			real final_score_100;
			real final_score_101;
			real final_score_102;
			real final_score_103;
			real final_score_104;
			real final_score_105;
			real final_score_106;
			real final_score_107;
			real final_score_108;
			real final_score_109;
			real final_score_110;
			real final_score_111;
			real final_score_112;
			real final_score_113;
			real final_score_114;
			real final_score_115;
			real final_score_116;
			real final_score_117;
			real final_score_118;
			real final_score_119;
			real final_score_120;
			real final_score_121;
			real final_score_122;
			real final_score_123;
			real final_score_124;
			real final_score_125;
			real final_score_126;
			real final_score_127;
			real final_score_128;
			real final_score_129;
			real final_score_130;
			real final_score_131;
			real final_score_132;
			real final_score_133;
			real final_score_134;
			real final_score_135;
			real final_score_136;
			real final_score_137;
			real final_score_138;
			real final_score_139;
			real final_score_140;
			real final_score_141;
			real final_score_142;
			real final_score_143;
			real final_score_144;
			real final_score_145;
			real final_score_146;
			real final_score_147;
			real final_score_148;
			real final_score_149;
			real final_score_150;
			real final_score_151;
			real final_score_152;
			real final_score_153;
			real final_score_154;
			real final_score_155;
			real final_score_156;
			real final_score_157;
			real final_score_158;
			real final_score_159;
			real final_score_160;
			real final_score_161;
			real final_score_162;
			real final_score_163;
			real final_score_164;
			real final_score_165;
			real final_score_166;
			real final_score_167;
			real final_score_168;
			real final_score_169;
			real final_score_170;
			real final_score_171;
			real final_score_172;
			real final_score_173;
			real final_score_174;
			real final_score_175;
			real final_score_176;
			real final_score_177;
			real final_score_178;
			real final_score_179;
			real final_score_180;
			real final_score_181;
			real final_score_182;
			real final_score_183;
			real final_score_184;
			real final_score_185;
			real final_score_186;
			real final_score_187;
			real final_score_188;
			real final_score_189;
			real final_score_190;
			real final_score_191;
			real final_score_192;
			real final_score_193;
			real final_score_194;
			real final_score_195;
			real final_score_196;
			real final_score_197;
			real final_score_198;
			real final_score_199;
			real final_score_200;
			real final_score_201;
			real final_score_202;
			real final_score_203;
			real final_score_204;
			real final_score_205;
			real final_score_206;
			real final_score_207;
			real final_score_208;
			real final_score_209;
			real final_score_210;
			real final_score_211;
			real final_score_212;
			real final_score_213;
			real final_score_214;
			real final_score_215;
			real final_score_216;
			real final_score_217;
			real final_score_218;
			real final_score_219;
			real final_score_220;
			real final_score_221;
			real final_score_222;
			real final_score_223;
			real final_score_224;
			real final_score_225;
			real final_score_226;
			real final_score_227;
			real final_score_228;
			real final_score_229;
			real final_score_230;
			real final_score_231;
			real final_score_232;
			real final_score_233;
			real final_score_234;
			real final_score_235;
			real final_score_236;
			real final_score_237;
			real final_score_238;
			real final_score_239;
			real final_score_240;
			real final_score_241;
			real final_score_242;
			real final_score_243;
			real final_score_244;
			real final_score_245;
			real final_score_246;
			real final_score_247;
			real final_score_248;
			real final_score_249;
			real final_score_250;
			real final_score_251;
			real final_score_252;
			real final_score_253;
			real final_score_254;
			real final_score_255;
			real final_score_256;
			real final_score_257;
			real final_score_258;
			real final_score_259;
			real final_score_260;
			real final_score_261;
			real final_score_262;
			real final_score_263;
			real final_score_264;
			real final_score_265;
			real final_score_266;
			real final_score_267;
			real final_score_268;
			real final_score_269;
			real final_score_270;
			real final_score_271;
			real final_score_272;
			real final_score_273;
			real final_score_274;
			real final_score_275;
			real final_score_276;
			real final_score_277;
			real final_score_278;
			real final_score_279;
			real final_score_280;
			real final_score_281;
			real final_score_282;
			real final_score_283;
			real final_score_284;
			real final_score_285;
			real final_score_286;
			real final_score_287;
			real final_score_288;
			real final_score_289;
			real final_score_290;
			real final_score_291;
			real final_score_292;
			real final_score_293;
			real final_score_294;
			real final_score_295;
			real final_score_296;
			real final_score_297;
			real final_score_298;
			real final_score_299;
			real final_score_300;
			real final_score_301;
			real final_score_302;
			real final_score_303;
			real final_score_304;
			real final_score_305;
			real final_score_306;
			real final_score_307;
			real final_score_308;
			real final_score_309;
			real final_score_310;
			real final_score_311;
			real final_score_312;
			real final_score_313;
			real final_score_314;
			real final_score_315;
			real final_score_316;
			real final_score_317;
			real final_score_318;
			real final_score_319;
			real final_score_320;
			real final_score_321;
			real final_score_322;
			real final_score_323;
			real final_score_324;
			real final_score_325;
			real final_score_326;
			real final_score_327;
			real final_score_328;
			real final_score_329;
			real final_score_330;
			real final_score_331;
			real final_score_332;
			real final_score_333;
			real final_score_334;
			real final_score_335;
			real final_score_336;
			real final_score_337;
			real final_score_338;
			real final_score_339;
			real final_score_340;
			real final_score_341;
			real final_score_342;
			real final_score_343;
			real final_score_344;
			real final_score_345;
			real final_score_346;
			real final_score_347;
			real final_score_348;
			real final_score_349;
			real final_score_350;
			real final_score_351;
			real final_score_352;
			real final_score_353;
			real final_score_354;
			real final_score_355;
			real final_score_356;
			real final_score_357;
			real final_score_358;
			real final_score_359;
			real final_score_360;
			real final_score_361;
			real final_score_362;
			real final_score_363;
			real final_score_364;
			real final_score_365;
			real final_score_366;
			real final_score_367;
			real final_score_368;
			real final_score_369;
			real final_score_370;
			real final_score_371;
			real final_score_372;
			real final_score_373;
			real final_score_374;
			real final_score_375;
			real final_score_376;
			real final_score_377;
			real final_score_378;
			real final_score_379;
			real final_score_380;
			real final_score_381;
			real final_score_382;
			real final_score_383;
			real final_score_384;
			real final_score_385;
			real final_score_386;
			real final_score_387;
			real final_score_388;
			real final_score_389;
			real final_score_390;
			real final_score_391;
			real final_score_392;
			real final_score_393;
			real final_score_394;
			real final_score_395;
			real final_score_396;
			real final_score_397;
			real final_score_398;
			real final_score_399;
			real final_score_400;
			real final_score_401;
			real final_score_402;
			real final_score_403;
			real final_score_404;
			real final_score_405;
			real final_score_406;
			real final_score_407;
			real final_score_408;
			real final_score_409;
			real final_score_410;
			real final_score_411;
			real final_score_412;
			real final_score_413;
			real final_score_414;
			real final_score_415;
			real final_score_416;
			real final_score_417;
			real final_score_418;
			real final_score_419;
			real final_score_420;
			real final_score_421;
			real final_score_422;
			real final_score_423;
			real final_score_424;
			real final_score_425;
			real final_score_426;
			real final_score_427;
			real final_score_428;
			real final_score_429;
			real final_score_430;
			real final_score_431;
			real final_score_432;
			real final_score_433;
			real final_score_434;
			real final_score_435;
			real final_score_436;
			real final_score_437;
			real final_score_438;
			real final_score_439;
			real final_score_440;
			real final_score_441;
			real final_score_442;
			real final_score_443;
			real final_score_444;
			real final_score_445;
			real final_score_446;
			real final_score_447;
			real final_score_448;
			real final_score_449;
			real final_score_450;
			real final_score_451;
			real final_score_452;
			real final_score_453;
			real final_score_454;
			real final_score_455;
			real final_score_456;
			real final_score_457;
			real final_score_458;
			real final_score_459;
			real final_score_460;
			real final_score_461;
			real final_score_462;
			real final_score_463;
			real final_score_464;
			real final_score_465;
			real final_score_466;
			real final_score_467;
			real final_score_468;
			real final_score_469;
			real final_score_470;
			real final_score_471;
			real final_score_472;
			real final_score_473;
			real final_score_474;
			real final_score_475;
			real final_score_476;
			real final_score_477;
			real final_score_478;
			real final_score_479;
			real final_score_480;
			real final_score_481;
			real final_score_482;
			real final_score_483;
			real final_score_484;
			real final_score_485;
			real final_score_486;
			real final_score_487;
			real final_score_488;
			real final_score_489;
			real final_score_490;
			real final_score_491;
			real final_score_492;
			real final_score_493;
			real final_score_494;
			real final_score_495;
			real final_score_496;
			real final_score_497;
			real final_score_498;
			real final_score_499;
			real final_score_500;
			real final_score;
			real pbr;
			real sbr;
			real offset;
			real base;
			real pts;
			real lgt;
			integer CDN1508_1_0;
			integer attr_segment;
			integer attr_relation;
			integer CDN1508_1_0_custom_attribute;

string rc1;
string rc2;
string rc3;
string rc4;

			Risk_Indicators.Layout_BocaShell_BtSt_Out clam;

			/* Additional Variables */ //I'm altering this after having built my round 2 files to alphabetize the extra variables.
INTEGER add_curr_avm_auto_val;
INTEGER add_curr_avm_auto_val_2;
INTEGER add_curr_avm_auto_val_2_s;
INTEGER add_curr_avm_auto_val_s;
BOOLEAN add_curr_isbestmatch;
INTEGER add_curr_lres;
INTEGER add_curr_lres_s;
INTEGER add_curr_naprop_s;
INTEGER add_curr_nhood_bus_ct;
INTEGER add_curr_nhood_bus_ct_s;
INTEGER add_curr_nhood_mfd_ct;
INTEGER add_curr_nhood_mfd_ct_s;
INTEGER add_curr_nhood_sfd_ct;
INTEGER add_curr_nhood_sfd_ct_s;
INTEGER add_curr_nhood_vac_prop;
INTEGER add_curr_nhood_vac_prop_s;
INTEGER add_curr_occ_index;
INTEGER add_curr_occupants_1yr;
INTEGER add_curr_occupants_1yr_s;
BOOLEAN add_curr_pop;
BOOLEAN add_curr_pop_s;
INTEGER add_curr_turnover_1yr_in;
INTEGER add_curr_turnover_1yr_in_s;
INTEGER add_curr_turnover_1yr_out;
INTEGER add_curr_turnover_1yr_out_s;
INTEGER add_input_address_score;
INTEGER add_input_address_score_s;
STRING add_input_advo_drop;
STRING add_input_advo_res_or_bus;
STRING add_input_advo_res_or_bus_s;
INTEGER add_input_avm_auto_val;
INTEGER add_input_avm_auto_val_s;
BOOLEAN add_input_house_number_match;
BOOLEAN add_input_house_number_match_s;
BOOLEAN add_input_isbestmatch;
INTEGER add_input_naprop_s;
INTEGER add_input_nhood_bus_ct;
INTEGER add_input_nhood_bus_ct_s;
INTEGER add_input_nhood_mfd_ct;
INTEGER add_input_nhood_mfd_ct_s;
INTEGER add_input_nhood_sfd_ct;
INTEGER add_input_nhood_sfd_ct_s;
INTEGER add_input_nhood_vac_prop;
INTEGER add_input_nhood_vac_prop_s;
INTEGER add_input_occ_index;
INTEGER add_input_occupants_1yr;
INTEGER add_input_occupants_1yr_s;
BOOLEAN add_input_pop;
BOOLEAN add_input_pop_s;
INTEGER add_input_turnover_1yr_in;
INTEGER add_input_turnover_1yr_in_s;
INTEGER add_input_turnover_1yr_out;
INTEGER add_input_turnover_1yr_out_s;
INTEGER add_prev_naprop_s;
STRING addr_stability_v2;
BOOLEAN addrpop;
BOOLEAN addrpop_s;
INTEGER addrs_10yr;
INTEGER addrs_10yr_s;
INTEGER addrs_15yr;
INTEGER addrs_15yr_s;
INTEGER addrs_5yr;
BOOLEAN addrs_prison_history;
BOOLEAN addrs_prison_history_s;
STRING addrscore;
INTEGER adl_per_email;
INTEGER adls_per_addr_c6;
INTEGER adls_per_addr_c6_s;
INTEGER adls_per_addr_curr;
INTEGER adls_per_addr_curr_s;
INTEGER attr_eviction_count;
INTEGER attr_eviction_count_s;
INTEGER attr_num_nonderogs_s;
INTEGER attr_num_nonderogs12_s;
INTEGER attr_num_nonderogs180_s;
INTEGER attr_num_nonderogs24_s;
INTEGER attr_num_nonderogs36_s;
INTEGER attr_num_nonderogs60_s;
INTEGER attr_num_nonderogs90_s;
INTEGER attr_num_unrel_liens60;
INTEGER attr_num_unrel_liens60_s;
INTEGER bk_disposed_historical_count;
INTEGER br_source_count;
INTEGER br_source_count_s;
INTEGER bus_name_match;
INTEGER bus_name_match_s;
INTEGER bus_phone_match;
INTEGER bus_phone_match_s;
INTEGER crim_rel_within100miles;
INTEGER crim_rel_within25miles;
INTEGER did;
INTEGER did_s;
STRING distaddraddr2;
STRING distphone2addr2;
STRING distphoneaddr;
STRING distphoneaddr2;
STRING elastscore;
INTEGER email_count;
INTEGER email_count_s;
STRING email_verification;
STRING email_verification_s;
BOOLEAN emailpop;
BOOLEAN emailpop_s;
INTEGER estimated_income;
INTEGER estimated_income_s;
INTEGER felony_count;
INTEGER felony_count_s;
STRING firstscore;
BOOLEAN fnamepop;
BOOLEAN fnamepop_s;
STRING foreclosure_last_date_s;
REAL fp_addrchangecrimediff;
REAL fp_addrchangecrimediff_s;
STRING fp_addrchangeecontrajindex;
STRING fp_addrchangeecontrajindex_s;
REAL fp_addrchangeincomediff;
REAL fp_addrchangeincomediff_s;
REAL fp_addrchangevaluediff;
REAL fp_addrchangevaluediff_s;
STRING fp_assoccredbureaucount_s;
STRING fp_assocrisktype_s;
STRING fp_assocsuspicousidcount_s;
STRING fp_componentcharrisktype;
INTEGER fp_corrphonelastnamecount;
STRING fp_corrrisktype_s;
STRING fp_curraddractivephonelist;
STRING fp_curraddrburglaryindex;
STRING fp_curraddrburglaryindex_s;
STRING fp_curraddrcartheftindex_s;
STRING fp_curraddrcrimeindex;
STRING fp_curraddrcrimeindex_s;
REAL fp_curraddrmedianincome;
REAL fp_curraddrmedianincome_s;
REAL fp_curraddrmedianvalue;
REAL fp_curraddrmedianvalue_s;
STRING fp_curraddrmurderindex;
STRING fp_curraddrmurderindex_s;
INTEGER fp_divaddrsuspidcountnew;
INTEGER fp_divaddrsuspidcountnew_s;
STRING fp_divrisktype;
INTEGER fp_divsrchaddrsuspidcount;
STRING fp_idrisktype_s;
INTEGER fp_prevaddrageoldest;
INTEGER fp_prevaddrageoldest_s;
STRING fp_prevaddrburglaryindex;
STRING fp_prevaddrburglaryindex_s;
STRING fp_prevaddrcartheftindex_s;
STRING fp_prevaddrcrimeindex;
STRING fp_prevaddrcrimeindex_s;
INTEGER fp_prevaddrlenofres;
INTEGER fp_prevaddrlenofres_s;
REAL fp_prevaddrmedianincome;
STRING fp_prevaddrmedianvalue;
REAL fp_prevaddrmedianvalue_s;
STRING fp_prevaddrmurderindex;
STRING fp_prevaddrmurderindex_s;
STRING fp_prevaddrstatus_s;
STRING fp_sourcerisktype;
INTEGER fp_srchaddrsrchcountmo;
INTEGER fp_srchaddrsrchcountmo_s;
INTEGER fp_srchaddrsrchcountwk;
STRING fp_srchaddrsrchcountwk_s;
STRING fp_srchcomponentrisktype_s;
INTEGER fp_srchcountwk;
STRING fp_srchfraudsrchcountyr;
STRING fp_srchfraudsrchcountyr_s;
STRING fp_srchphonesrchcountmo;
STRING fp_srchphonesrchcountmo_s;
STRING fp_srchphonesrchcountwk_s;
STRING fp_srchssnsrchcountmo;
STRING fp_srchssnsrchcountmo_s;
STRING fp_srchunvrfdaddrcount_s;
INTEGER fp_srchunvrfdphonecount;
INTEGER fp_srchunvrfdssncount;
STRING fp_srchvelocityrisktype;
STRING fp_srchvelocityrisktype_s;
STRING fp_validationrisktype_s;
INTEGER fp_vardobcountnew;
INTEGER fp_varmsrcssncount;
INTEGER fp_varmsrcssnunrelcount;
STRING fp_varmsrcssnunrelcount_s;
STRING fp_varrisktype;
STRING fp_varrisktype_s;
DECIMAL4_1 hdr_source_profile;
DECIMAL4_1 hdr_source_profile_index_s;
DECIMAL4_1 hdr_source_profile_s;
INTEGER header_first_seen;
INTEGER header_first_seen_s;
INTEGER hh_age_18_to_30;
INTEGER hh_age_30_to_65;
INTEGER hh_age_30_to_65_s;
INTEGER hh_age_65_plus;
INTEGER hh_age_65_plus_s;
INTEGER hh_bankruptcies;
INTEGER hh_collections_ct_s;
INTEGER hh_criminals;
INTEGER hh_criminals_s;
INTEGER hh_members_ct;
INTEGER hh_members_ct_s;
INTEGER hh_members_w_derog;
INTEGER hh_members_w_derog_s;
INTEGER hh_payday_loan_users;
INTEGER hh_payday_loan_users_s;
INTEGER hh_property_owners_ct;
BOOLEAN hphnpop;
BOOLEAN hphnpop_s;
STRING in_dob;
STRING in_dob_s;
STRING in_email_address;
STRING in_fname;
STRING in_fname_s;
INTEGER inferred_age;
INTEGER inferred_age_s;
INTEGER infutor_nap_s;
INTEGER inq_adlsperaddr;
INTEGER inq_adlsperaddr_s;
INTEGER inq_adlsperphone;
INTEGER inq_adlsperphone_s;
INTEGER inq_auto_count;
INTEGER inq_auto_count01;
INTEGER inq_auto_count03;
INTEGER inq_auto_count03_s;
INTEGER inq_auto_count06;
INTEGER inq_auto_count12;
INTEGER inq_auto_count12_s;
INTEGER inq_auto_count24;
INTEGER inq_banking_count03_s;
INTEGER inq_collection_count12;
INTEGER inq_collection_count12_s;
INTEGER inq_collection_count24;
INTEGER inq_communications_count_s;
INTEGER inq_communications_count01_s;
INTEGER inq_communications_count03_s;
INTEGER inq_communications_count06_s;
INTEGER inq_communications_count12_s;
INTEGER inq_communications_count24_s;
INTEGER inq_count;
INTEGER inq_count_s;
INTEGER inq_count01;
INTEGER inq_count01_s;
INTEGER inq_count03;
INTEGER inq_count03_s;
INTEGER inq_count06;
INTEGER inq_count06_s;
INTEGER inq_count12;
INTEGER inq_count12_s;
INTEGER inq_count24;
INTEGER inq_count24_s;
INTEGER inq_highriskcredit_count_s;
INTEGER inq_highriskcredit_count01_s;
INTEGER inq_highriskcredit_count03_s;
INTEGER inq_highriskcredit_count06_s;
INTEGER inq_highriskcredit_count12;
INTEGER inq_highriskcredit_count12_s;
INTEGER inq_highriskcredit_count24;
INTEGER inq_highriskcredit_count24_s;
INTEGER inq_lnamesperaddr;
INTEGER inq_lnamesperaddr_s;
INTEGER inq_mortgage_count;
INTEGER inq_mortgage_count01;
INTEGER inq_mortgage_count03;
INTEGER inq_mortgage_count03_s;
INTEGER inq_mortgage_count06;
INTEGER inq_mortgage_count12;
INTEGER inq_mortgage_count24;
INTEGER inq_other_count24;
INTEGER inq_peraddr;
INTEGER inq_peraddr_s;
INTEGER inq_perphone;
INTEGER inq_perphone_s;
INTEGER inq_prepaidcards_count_s;
INTEGER inq_prepaidcards_count01_s;
INTEGER inq_prepaidcards_count03_s;
INTEGER inq_prepaidcards_count06_s;
INTEGER inq_prepaidcards_count12_s;
INTEGER inq_prepaidcards_count24_s;
INTEGER inq_retail_count;
INTEGER inq_retail_count_s;
INTEGER inq_retail_count_week;
INTEGER inq_retail_count01;
INTEGER inq_retail_count01_s;
INTEGER inq_retail_count03;
INTEGER inq_retail_count03_s;
INTEGER inq_retail_count06;
INTEGER inq_retail_count06_s;
INTEGER inq_retail_count12;
INTEGER inq_retail_count12_s;
INTEGER inq_retail_count24;
INTEGER inq_retail_count24_s;
INTEGER inq_retailpayments_count;
INTEGER inq_retailpayments_count01;
INTEGER inq_retailpayments_count03;
INTEGER inq_retailpayments_count06;
INTEGER inq_retailpayments_count12;
INTEGER inq_retailpayments_count24;
INTEGER inq_ssnsperaddr;
INTEGER inq_ssnsperaddr_s;
INTEGER invalid_addrs_per_adl;
INTEGER invalid_addrs_per_adl_c6_s;
INTEGER invalid_addrs_per_adl_s;
INTEGER invalid_phones_per_adl_c6_s;
INTEGER invalid_phones_per_adl_s;
INTEGER invalid_ssns_per_adl;
INTEGER invalid_ssns_per_adl_s;
STRING lastscore;
INTEGER liens_historical_unreleased_ct_s;
INTEGER liens_recent_unreleased_count_s;
INTEGER liens_rel_ot_last_seen;
INTEGER liens_rel_ot_last_seen_s;
INTEGER liens_rel_ot_total_amount;
INTEGER liens_rel_ot_total_amount_s;
INTEGER liens_unrel_ot_first_seen;
INTEGER liens_unrel_ot_last_seen_s;
INTEGER liens_unrel_sc_first_seen_s;
INTEGER liens_unrel_st_first_seen;
INTEGER liens_unrel_st_last_seen;
INTEGER liens_unrel_st_total_amount;
INTEGER liens_unrel_st_total_amount_s;
BOOLEAN lnamepop;
BOOLEAN lnamepop_s;
INTEGER lnames_per_adl_c6;
INTEGER lnames_per_adl_c6_s;
INTEGER max_lres;
INTEGER nap_summary;
INTEGER nap_summary_s;
STRING nap_type;
STRING nap_type_s;
INTEGER nas_summary;
INTEGER nas_summary_s;
STRING out_addr_status_s;
INTEGER pb_average_days_bt_orders;
INTEGER pb_average_days_bt_orders_s;
INTEGER pb_average_dollars;
INTEGER pb_average_dollars_s;
INTEGER pb_number_of_sources;
INTEGER pb_number_of_sources_s;
INTEGER pb_total_dollars;
INTEGER pb_total_dollars_s;
INTEGER pb_total_orders;
INTEGER pb_total_orders_s;
STRING phone_ver_experian;
STRING phone_ver_experian_s;
STRING phone_ver_insurance;
STRING phone_ver_insurance_s;
INTEGER phones_per_addr_c6;
INTEGER phones_per_addr_c6_s;
INTEGER phones_per_addr_curr;
INTEGER property_owned_total_s;
BOOLEAN rc_addrmiskeyflag;
BOOLEAN rc_addrmiskeyflag_s;
STRING rc_addrvalflag_s;
STRING rc_decsflag;
STRING rc_decsflag_s;
INTEGER rc_disthphoneaddr;
INTEGER rc_disthphoneaddr_s;
STRING rc_hphonevalflag;
STRING rc_hphonevalflag_s;
STRING rc_phonetype;
STRING rc_phonetype_s;
STRING rc_phonevalflag;
STRING rc_phonevalflag_s;
STRING rc_pwphonezipflag;
STRING rc_pwphonezipflag_s;
STRING rc_pwssndobflag;
STRING rc_pwssndobflag_s;
STRING rc_ssndobflag;
STRING rc_ssndobflag_s;
INTEGER rc_ssndod;
INTEGER rc_ssndod_s;
BOOLEAN rc_ssnmiskeyflag;
BOOLEAN rc_ssnmiskeyflag_s;
INTEGER recent_disconnects_s;
INTEGER rel_ageover70_count;
INTEGER rel_ageover70_count_s;
INTEGER rel_ageunder40_count;
INTEGER rel_ageunder50_count;
INTEGER rel_ageunder50_count_s;
INTEGER rel_ageunder60_count;
INTEGER rel_ageunder60_count_s;
INTEGER rel_ageunder70_count;
INTEGER rel_ageunder70_count_s;
INTEGER rel_count;
INTEGER rel_count_s;
INTEGER rel_criminal_count_s;
INTEGER rel_educationover12_count;
INTEGER rel_educationover12_count_s;
INTEGER rel_felony_count;
INTEGER rel_felony_count_s;
INTEGER rel_homeover500_count;
INTEGER rel_homeover500_count_s;
INTEGER rel_homeunder100_count;
INTEGER rel_homeunder100_count_s;
INTEGER rel_homeunder150_count;
INTEGER rel_homeunder150_count_s;
INTEGER rel_homeunder200_count;
INTEGER rel_homeunder200_count_s;
INTEGER rel_homeunder300_count;
INTEGER rel_homeunder300_count_s;
INTEGER rel_homeunder500_count;
INTEGER rel_homeunder500_count_s;
INTEGER rel_incomeover100_count;
INTEGER rel_incomeover100_count_s;
INTEGER rel_incomeunder100_count;
INTEGER rel_incomeunder100_count_s;
INTEGER rel_incomeunder50_count;
INTEGER rel_incomeunder75_count;
INTEGER rel_incomeunder75_count_s;
INTEGER rel_within100miles_count;
INTEGER rel_within100miles_count_s;
INTEGER rel_within25miles_count;
INTEGER rel_within25miles_count_s;
INTEGER rel_within500miles_count_s;
STRING ssnlength;
STRING ssnlength_s;
INTEGER ssns_per_adl;
INTEGER ssns_per_adl_c6;
INTEGER ssns_per_adl_c6_s;
INTEGER ssns_per_adl_s;
INTEGER stl_inq_count;
INTEGER stl_inq_count_s;
BOOLEAN truedid;
BOOLEAN truedid_s;
STRING util_add_input_type_list;
STRING util_add_input_type_list_s;
INTEGER util_adl_count_s;
STRING ver_sources;
STRING ver_sources_first_seen;
STRING ver_sources_first_seen_s;
STRING ver_sources_s;

END;

		Layout_Debug doModel(with_census le, biid rt) := TRANSFORM
	#else
		Layout_ModelOut doModel( with_census le, biid rt ) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */

	NULL  := -999999999;
	sNULL := (string)NULL;

/* Custom Inputs for DELL */
	pay_code_1                   := trim(le.cd2i.pymtmethod);  //string2
	avs_response_code            := trim(le.cd2i.avscode);  //string1
	cid_response_code            := trim(le.cd2i.cidcode);  //string4
	local_ship_code              := trim(le.cd2i.shipmode);  //string2
	order_amt                    := trim(le.cd2i.orderamt);  //string6
	us_business_consumer_flag    := trim(le.cd2i.ordertype);  //string1
	base_sku_product_desc        := trim(le.cd2i.prodcode);  //string2
	acquisition_channel1         := trim(le.cd2i.channel);  //string1
	
/* Taken from CDN1506_1_0 */
addrscore                        := le.bs.eddo.addrscore;
firstscore                       := le.bs.eddo.firstscore;
lastscore                        := le.bs.eddo.lastscore;
elastscore                       := le.bs.eddo.elastscore;
distphoneaddr                    := IF(le.bs.eddo.distphoneaddr = '',sNULL,le.bs.eddo.distphoneaddr);
distphone2addr2                  := IF(le.bs.eddo.distphone2addr2 = '',sNULL,le.bs.eddo.distphone2addr2);
distphoneaddr2                   := IF(le.bs.eddo.distphoneaddr2 = '',sNULL,le.bs.eddo.distphoneaddr2);
distaddraddr2                    := IF(le.bs.eddo.distaddraddr2 = '',sNULL,le.bs.eddo.distaddraddr2);
did                              := le.bs.Bill_To_Out.did;
truedid                          := le.bs.Bill_To_Out.truedid;
in_dob                           := le.bs.Bill_To_Out.shell_input.dob;
in_email_address                 := le.bs.Bill_To_Out.shell_input.email_address;
nas_summary                      := le.bs.Bill_To_Out.iid.nas_summary;
nap_summary                      := le.bs.Bill_To_Out.iid.nap_summary;
nap_type                         := le.bs.Bill_To_Out.iid.nap_type;
rc_ssndod                        := le.bs.Bill_To_Out.ssn_verification.validation.deceasedDate;
rc_phonevalflag                  := le.bs.Bill_To_Out.iid.phonevalflag;
rc_hphonevalflag                 := le.bs.Bill_To_Out.iid.hphonevalflag;
rc_pwphonezipflag                := le.bs.Bill_To_Out.iid.pwphonezipflag;
rc_decsflag                      := le.bs.Bill_To_Out.iid.decsflag;
rc_ssndobflag                    := le.bs.Bill_To_Out.iid.socsdobflag;
rc_pwssndobflag                  := le.bs.Bill_To_Out.iid.pwsocsdobflag;
rc_ssnmiskeyflag                 := le.bs.Bill_To_Out.iid.socsmiskeyflag;
rc_addrmiskeyflag                := le.bs.Bill_To_Out.iid.addrmiskeyflag;
rc_disthphoneaddr                := le.bs.Bill_To_Out.iid.disthphoneaddr;
rc_phonetype                     := le.bs.Bill_To_Out.iid.phonetype;
hdr_source_profile               := le.bs.Bill_To_Out.source_profile;
ver_sources                      := le.bs.Bill_To_Out.header_summary.ver_sources;
ver_sources_first_seen           := le.bs.Bill_To_Out.header_summary.ver_sources_first_seen_date;
bus_name_match                   := le.bs.Bill_To_Out.business_header_address_summary.bus_name_match;
bus_phone_match                  := le.bs.Bill_To_Out.business_header_address_summary.bus_phone_match;
fnamepop                         := le.bs.Bill_To_Out.input_validation.firstname;
lnamepop                         := le.bs.Bill_To_Out.input_validation.lastname;
addrpop                          := le.bs.Bill_To_Out.input_validation.address;
ssnlength                        := le.bs.Bill_To_Out.input_validation.ssn_length;
emailpop                         := le.bs.Bill_To_Out.input_validation.email;
hphnpop                          := le.bs.Bill_To_Out.input_validation.homephone;
util_add_input_type_list         := le.bs.Bill_To_Out.utility.utili_addr1_type;//
add_input_address_score          := le.bs.Bill_To_Out.address_verification.input_address_information.address_score;
add_input_house_number_match     := le.bs.Bill_To_Out.address_verification.input_address_information.house_number_match;
add_input_isbestmatch            := le.bs.Bill_To_Out.address_verification.input_address_information.isbestmatch;
add_input_occ_index              := le.bs.Bill_To_Out.address_verification.inputaddr_occupancy_index;
add_input_advo_res_or_bus        := le.bs.Bill_To_Out.advo_input_addr.Residential_or_Business_Ind;
add_input_avm_auto_val           := le.bs.Bill_To_Out.avm.input_address_information.avm_automated_valuation;
add_input_occupants_1yr          := le.bs.Bill_To_Out.addr_risk_summary.occupants_1yr ;
add_input_turnover_1yr_in        := le.bs.Bill_To_Out.addr_risk_summary.turnover_1yr_in ;
add_input_turnover_1yr_out       := le.bs.Bill_To_Out.addr_risk_summary.turnover_1yr_out ;
add_input_nhood_vac_prop         := le.bs.Bill_To_Out.addr_risk_summary.N_Vacant_Properties;
add_input_nhood_bus_ct           := le.bs.Bill_To_Out.addr_risk_summary.N_Business_Count ;
add_input_nhood_sfd_ct           := le.bs.Bill_To_Out.addr_risk_summary.N_SFD_Count ;
add_input_nhood_mfd_ct           := le.bs.Bill_To_Out.addr_risk_summary.N_MFD_Count;
add_input_pop                    := le.bs.Bill_To_Out.addrPop;
add_curr_isbestmatch             := le.bs.Bill_To_Out.address_verification.address_history_1.isbestmatch;
add_curr_lres                    := le.bs.Bill_To_Out.lres2;
add_curr_occ_index               := le.bs.Bill_To_Out.address_verification.currAddr_occupancy_index;
add_curr_avm_auto_val            := le.bs.Bill_To_Out.avm.address_history_1.avm_automated_valuation;
add_curr_avm_auto_val_2          := le.bs.Bill_To_Out.avm.address_history_1.avm_automated_valuation2;
add_curr_occupants_1yr           := le.bs.Bill_To_Out.addr_risk_summary2.occupants_1yr ;
add_curr_turnover_1yr_in         := le.bs.Bill_To_Out.addr_risk_summary2.turnover_1yr_in ;
add_curr_turnover_1yr_out        := le.bs.Bill_To_Out.addr_risk_summary2.turnover_1yr_out ;
add_curr_nhood_vac_prop          := le.bs.Bill_To_Out.addr_risk_summary2.N_Vacant_Properties;
add_curr_nhood_bus_ct            := le.bs.Bill_To_Out.addr_risk_summary2.N_Business_Count ;
add_curr_nhood_sfd_ct            := le.bs.Bill_To_Out.addr_risk_summary2.N_SFD_Count ;
add_curr_nhood_mfd_ct            := le.bs.Bill_To_Out.addr_risk_summary2.N_MFD_Count;
add_curr_pop                     := le.bs.Bill_To_Out.addrPop2;
max_lres                         := le.bs.Bill_To_Out.other_address_info.max_lres;
addrs_5yr                        := le.bs.Bill_To_Out.other_address_info.addrs_last_5years;
addrs_10yr                       := le.bs.Bill_To_Out.other_address_info.addrs_last_10years;
addrs_15yr                       := le.bs.Bill_To_Out.other_address_info.addrs_last_15years;
addrs_prison_history             := le.bs.Bill_To_Out.other_address_info.isprison;
phone_ver_insurance              := le.bs.Bill_To_Out.insurance_phones_summary.Insurance_Phone_Verification;
phone_ver_experian               := le.bs.Bill_To_Out.Experian_Phone_Verification;
header_first_seen                := le.bs.Bill_To_Out.ssn_verification.header_first_seen;
ssns_per_adl                     := le.bs.Bill_To_Out.velocity_counters.ssns_per_adl;
adls_per_addr_curr               := le.bs.Bill_To_Out.velocity_counters.adls_per_addr_current;
phones_per_addr_curr             := le.bs.Bill_To_Out.velocity_counters.phones_per_addr_current;
ssns_per_adl_c6                  := le.bs.Bill_To_Out.velocity_counters.ssns_per_adl_created_6months;
lnames_per_adl_c6                := le.bs.Bill_To_Out.velocity_counters.lnames_per_adl180;
adls_per_addr_c6                 := le.bs.Bill_To_Out.velocity_counters.adls_per_addr_created_6months;
phones_per_addr_c6               := le.bs.Bill_To_Out.velocity_counters.phones_per_addr_created_6months ;
invalid_ssns_per_adl             := le.bs.Bill_To_Out.velocity_counters.invalid_ssns_per_adl;
invalid_addrs_per_adl            := le.bs.Bill_To_Out.velocity_counters.invalid_addrs_per_adl;
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
inq_collection_count12           := le.bs.Bill_To_Out.acc_logs.collection.count12;
inq_collection_count24           := le.bs.Bill_To_Out.acc_logs.collection.count24;
inq_highriskcredit_count12       := le.bs.Bill_To_Out.acc_logs.highriskcredit.count12;
inq_highriskcredit_count24       := le.bs.Bill_To_Out.acc_logs.highriskcredit.count24;
inq_mortgage_count               := le.bs.Bill_To_Out.acc_logs.mortgage.counttotal;
inq_mortgage_count01             := le.bs.Bill_To_Out.acc_logs.mortgage.count01;
inq_mortgage_count03             := le.bs.Bill_To_Out.acc_logs.mortgage.count03;
inq_mortgage_count06             := le.bs.Bill_To_Out.acc_logs.mortgage.count06;
inq_mortgage_count12             := le.bs.Bill_To_Out.acc_logs.mortgage.count12;
inq_mortgage_count24             := le.bs.Bill_To_Out.acc_logs.mortgage.count24;
inq_other_count24                := le.bs.Bill_To_Out.acc_logs.other.count24;
inq_retail_count                 := le.bs.Bill_To_Out.acc_logs.retail.counttotal;
inq_retail_count01               := le.bs.Bill_To_Out.acc_logs.retail.count01;
inq_retail_count03               := le.bs.Bill_To_Out.acc_logs.retail.count03;
inq_retail_count06               := le.bs.Bill_To_Out.acc_logs.retail.count06;
inq_retail_count12               := le.bs.Bill_To_Out.acc_logs.retail.count12;
inq_retail_count24               := le.bs.Bill_To_Out.acc_logs.retail.count24;
inq_retailpayments_count         := le.bs.Bill_To_Out.acc_logs.retailpayments.counttotal;
inq_retailpayments_count24       := le.bs.Bill_To_Out.acc_logs.retailpayments.count24;
inq_peraddr                      := le.bs.Bill_To_Out.acc_logs.inquiryPerAddr ;
inq_adlsperaddr                  := le.bs.Bill_To_Out.acc_logs.inquiryADLsPerAddr ;
inq_lnamesperaddr                := le.bs.Bill_To_Out.acc_logs.inquiryLNamesPerAddr ;
inq_ssnsperaddr                  := le.bs.Bill_To_Out.acc_logs.inquirySSNsPerAddr ;
inq_perphone                     := le.bs.Bill_To_Out.acc_logs.inquiryPerPhone ;
inq_adlsperphone                 := le.bs.Bill_To_Out.acc_logs.inquiryADLsPerPhone ;
pb_number_of_sources             := IF(le.bs.Bill_To_Out.ibehavior.number_of_sources = '',NULL,(integer)le.bs.Bill_To_Out.ibehavior.number_of_sources);
pb_average_days_bt_orders        := IF(le.bs.Bill_To_Out.ibehavior.average_days_between_orders = '',NULL,(integer)le.bs.Bill_To_Out.ibehavior.average_days_between_orders);
pb_average_dollars               := IF(le.bs.Bill_To_Out.ibehavior.average_amount_per_order = '',NULL,(integer)le.bs.Bill_To_Out.ibehavior.average_amount_per_order);
pb_total_dollars                 := IF(le.bs.Bill_To_Out.ibehavior.total_dollars = '',NULL,(integer)le.bs.Bill_To_Out.ibehavior.total_dollars);
pb_total_orders                  := IF(le.bs.Bill_To_Out.ibehavior.total_number_of_orders = '',NULL,(integer)le.bs.Bill_To_Out.ibehavior.total_number_of_orders);
br_source_count                  := le.bs.Bill_To_Out.employment.source_ct;
stl_inq_count                    := le.bs.Bill_To_Out.impulse.count;
email_count                      := le.bs.Bill_To_Out.email_summary.email_ct;
email_verification               := le.bs.Bill_To_Out.email_summary.identity_email_verification_level;
adl_per_email                    := le.bs.Bill_To_Out.email_summary.reverse_email.adls_per_email;
attr_num_unrel_liens60           := le.bs.Bill_To_Out.bjl.liens_unreleased_count60;
attr_eviction_count              := le.bs.Bill_To_Out.bjl.eviction_count;
fp_sourcerisktype                := le.bs.Bill_To_Out.fdattributesv2.sourcerisklevel;
fp_varrisktype                   := le.bs.Bill_To_Out.fdattributesv2.variationrisklevel;
fp_varmsrcssncount               := IF(le.bs.Bill_To_Out.fdattributesv2.variationmsourcesssncount = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.variationmsourcesssncount);
fp_vardobcountnew                := IF(le.bs.Bill_To_Out.fdattributesv2.VariationDOBCountNew = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.VariationDOBCountNew);
fp_srchvelocityrisktype          := IF(le.bs.Bill_To_Out.fdattributesv2.searchvelocityrisklevel = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.searchvelocityrisklevel);
fp_srchcountwk                   := IF(le.bs.Bill_To_Out.fdattributesv2.searchcountweek = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.searchcountweek);
fp_srchunvrfdssncount            := IF(le.bs.Bill_To_Out.fdattributesv2.searchunverifiedssncountyear = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.searchunverifiedssncountyear);
fp_srchunvrfdphonecount          := IF(le.bs.Bill_To_Out.fdattributesv2.searchunverifiedphonecountyear = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.searchunverifiedphonecountyear);
fp_srchfraudsrchcountyr          := le.bs.Bill_To_Out.fdattributesv2.searchfraudsearchcountyear;
fp_corrphonelastnamecount        := IF(le.bs.Bill_To_Out.fdattributesv2.correlationphonelastnamecount = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.correlationphonelastnamecount);
fp_divrisktype                   := le.bs.Bill_To_Out.fdattributesv2.divrisklevel;
fp_divaddrsuspidcountnew         := IF(le.bs.Bill_To_Out.fdattributesv2.divaddrsuspidentitycountnew = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.divaddrsuspidentitycountnew);
fp_srchssnsrchcountmo            := le.bs.Bill_To_Out.fdattributesv2.searchssnsearchcountmonth;
fp_srchaddrsrchcountmo           := IF(le.bs.Bill_To_Out.fdattributesv2.searchaddrsearchcountmonth = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.searchaddrsearchcountmonth);
fp_srchphonesrchcountmo          := le.bs.Bill_To_Out.fdattributesv2.searchphonesearchcountmonth;
fp_componentcharrisktype         := IF(le.bs.Bill_To_Out.fdattributesv2.componentcharrisklevel = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.componentcharrisklevel);
fp_addrchangeincomediff          := (real)IF(le.bs.Bill_To_Out.fdattributesv2.addrchangeincomediff = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.addrchangeincomediff);
fp_addrchangevaluediff           := (real)IF(le.bs.Bill_To_Out.fdattributesv2.addrchangevaluediff = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.addrchangevaluediff);
fp_addrchangecrimediff           := (real)IF(le.bs.Bill_To_Out.fdattributesv2.addrchangecrimediff = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.addrchangecrimediff);
fp_addrchangeecontrajindex       := IF(le.bs.Bill_To_Out.fdattributesv2.addrchangeecontrajectoryindex = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.addrchangeecontrajectoryindex);
fp_curraddractivephonelist       := le.bs.Bill_To_Out.fdattributesv2.curraddractivephonelist;
fp_curraddrmedianincome          := (real)IF(le.bs.Bill_To_Out.fdattributesv2.curraddrmedianincome = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.curraddrmedianincome);
fp_curraddrmedianvalue           := (real)IF(le.bs.Bill_To_Out.fdattributesv2.curraddrmedianvalue = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.curraddrmedianvalue);
fp_curraddrmurderindex           := le.bs.Bill_To_Out.fdattributesv2.curraddrmurderindex;
fp_curraddrburglaryindex         := le.bs.Bill_To_Out.fdattributesv2.curraddrburglaryindex;
fp_curraddrcrimeindex            := le.bs.Bill_To_Out.fdattributesv2.curraddrcrimeindex;
fp_prevaddrageoldest             := (integer)IF(le.bs.Bill_To_Out.fdattributesv2.prevaddrageoldest = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.prevaddrageoldest);
fp_prevaddrlenofres              := (integer)IF(le.bs.Bill_To_Out.fdattributesv2.prevaddrlenofres = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.prevaddrlenofres);
fp_prevaddrmedianincome          := (real)IF(le.bs.Bill_To_Out.fdattributesv2.prevaddrmedianincome = '',sNULL,le.bs.Bill_To_Out.fdattributesv2.prevaddrmedianincome);
fp_prevaddrmedianvalue           := le.bs.Bill_To_Out.fdattributesv2.prevaddrmedianvalue;
fp_prevaddrmurderindex           := le.bs.Bill_To_Out.fdattributesv2.prevaddrmurderindex;
fp_prevaddrburglaryindex         := le.bs.Bill_To_Out.fdattributesv2.prevaddrburglaryindex;
fp_prevaddrcrimeindex            := le.bs.Bill_To_Out.fdattributesv2.prevaddrcrimeindex;
liens_unrel_ot_first_seen        := le.bs.Bill_To_Out.liens.liens_unreleased_other_tax.earliest_filing_date;
liens_rel_ot_last_seen           := le.bs.Bill_To_Out.liens.liens_released_other_tax.most_recent_filing_date;
liens_rel_ot_total_amount        := le.bs.Bill_To_Out.liens.liens_released_other_tax.total_amount;
liens_unrel_st_total_amount      := le.bs.Bill_To_Out.liens.liens_unreleased_suits.total_amount;
felony_count                     := le.bs.Bill_To_Out.bjl.felony_count;
hh_members_ct                    := le.bs.Bill_To_Out.hhid_summary.hh_members_ct;
hh_property_owners_ct            := le.bs.Bill_To_Out.hhid_summary.hh_property_owners_ct;
hh_age_65_plus                   := le.bs.Bill_To_Out.hhid_summary.hh_age_65_plus;
hh_age_30_to_65                  := le.bs.Bill_To_Out.hhid_summary.hh_age_31_to_65;
hh_age_18_to_30                  := le.bs.Bill_To_Out.hhid_summary.hh_age_18_to_30;
hh_payday_loan_users             := le.bs.Bill_To_Out.hhid_summary.hh_payday_loan_users;
hh_members_w_derog               := le.bs.Bill_To_Out.hhid_summary.hh_members_w_derog;
hh_bankruptcies                  := le.bs.Bill_To_Out.hhid_summary.hh_bankruptcies;
hh_criminals                     := le.bs.Bill_To_Out.hhid_summary.hh_criminals;
rel_count                        := le.bs.Bill_To_Out.relatives.relative_count;
rel_felony_count                 := le.bs.Bill_To_Out.relatives.relative_felony_count;
crim_rel_within25miles           := le.bs.Bill_To_Out.relatives.criminal_relative_within25miles;
crim_rel_within100miles          := le.bs.Bill_To_Out.relatives.criminal_relative_within100miles;
rel_within25miles_count          := le.bs.Bill_To_Out.relatives.relative_within25miles_count;
rel_within100miles_count         := le.bs.Bill_To_Out.relatives.relative_within100miles_count;
rel_incomeunder50_count          := le.bs.Bill_To_Out.relatives.relative_incomeunder50_count;
rel_incomeunder75_count          := le.bs.Bill_To_Out.relatives.relative_incomeunder75_count;
rel_incomeunder100_count         := le.bs.Bill_To_Out.relatives.relative_incomeunder100_count;
rel_incomeover100_count          := le.bs.Bill_To_Out.relatives.relative_incomeover100_count;
rel_homeunder100_count           := le.bs.Bill_To_Out.relatives.relative_homeunder100_count;
rel_homeunder150_count           := le.bs.Bill_To_Out.relatives.relative_homeunder150_count;
rel_homeunder200_count           := le.bs.Bill_To_Out.relatives.relative_homeunder200_count;
rel_homeunder300_count           := le.bs.Bill_To_Out.relatives.relative_homeunder300_count;
rel_homeunder500_count           := le.bs.Bill_To_Out.relatives.relative_homeunder500_count;
rel_homeover500_count            := le.bs.Bill_To_Out.relatives.relative_homeover500_count;
rel_educationover12_count        := le.bs.Bill_To_Out.relatives.relative_educationover12_count;
rel_ageunder40_count             := le.bs.Bill_To_Out.relatives.relative_ageunder40_count;
rel_ageunder50_count             := le.bs.Bill_To_Out.relatives.relative_ageunder50_count;
rel_ageunder60_count             := le.bs.Bill_To_Out.relatives.relative_ageunder60_count;
rel_ageunder70_count             := le.bs.Bill_To_Out.relatives.relative_ageunder70_count;
rel_ageover70_count              := le.bs.Bill_To_Out.relatives.relative_ageover70_count;
inferred_age                     := le.bs.Bill_To_Out.inferred_age;
addr_stability_v2                := le.bs.Bill_To_Out.addr_stability;
estimated_income                 := le.bs.Bill_To_Out.estimated_income;
did_s                            := le.bs.Ship_To_Out.did;
truedid_s                        := le.bs.Ship_To_Out.truedid;
out_addr_status_s                := le.bs.Ship_To_Out.shell_input.addr_status;
in_dob_s                         := le.bs.Ship_To_Out.shell_input.dob;
nas_summary_s                    := le.bs.Ship_To_Out.iid.nas_summary;
nap_summary_s                    := le.bs.Ship_To_Out.iid.nap_summary;
nap_type_s                       := le.bs.Ship_To_Out.iid.nap_type;
rc_ssndod_s                      := le.bs.Ship_To_Out.ssn_verification.validation.deceasedDate;
rc_pwphonezipflag_s              := le.bs.Ship_To_Out.iid.pwphonezipflag;
rc_decsflag_s                    := le.bs.Ship_To_Out.iid.decsflag;
rc_ssndobflag_s                  := le.bs.Ship_To_Out.iid.socsdobflag;
rc_pwssndobflag_s                := le.bs.Ship_To_Out.iid.pwsocsdobflag;
rc_addrvalflag_s                 := le.bs.Ship_To_Out.iid.addrvalflag;
rc_ssnmiskeyflag_s               := le.bs.Ship_To_Out.iid.socsmiskeyflag;
rc_addrmiskeyflag_s              := le.bs.Ship_To_Out.iid.addrmiskeyflag;
rc_disthphoneaddr_s              := le.bs.Ship_To_Out.iid.disthphoneaddr;
hdr_source_profile_s             := le.bs.Ship_To_Out.source_profile;
hdr_source_profile_index_s       := le.bs.Ship_To_Out.source_profile_index;
ver_sources_s                    := le.bs.Ship_To_Out.header_summary.ver_sources;
ver_sources_first_seen_s         := le.bs.Ship_To_Out.header_summary.ver_sources_first_seen_date;
bus_name_match_s                 := le.bs.Ship_To_Out.business_header_address_summary.bus_name_match;
bus_phone_match_s                := le.bs.Ship_To_Out.business_header_address_summary.bus_phone_match;
fnamepop_s                       := le.bs.Ship_To_Out.input_validation.firstname;
lnamepop_s                       := le.bs.Ship_To_Out.input_validation.lastname;
addrpop_s                        := le.bs.Ship_To_Out.input_validation.address;
ssnlength_s                      := le.bs.Ship_To_Out.input_validation.ssn_length;
hphnpop_s                        := le.bs.Ship_To_Out.input_validation.homephone;
util_adl_count_s                 := le.bs.Ship_To_Out.utility.utili_adl_count;
util_add_input_type_list_s       := le.bs.Ship_To_Out.utility.utili_addr1_type;
add_input_address_score_s        := le.bs.Ship_To_Out.address_verification.input_address_information.address_score;
add_input_house_number_match_s   := le.bs.Ship_To_Out.address_verification.input_address_information.house_number_match;
add_input_advo_res_or_bus_s      := le.bs.Ship_To_Out.advo_input_addr.Residential_or_Business_Ind;
add_input_avm_auto_val_s         := le.bs.Ship_To_Out.avm.input_address_information.avm_automated_valuation;
add_input_naprop_s               := le.bs.Ship_To_Out.address_verification.input_address_information.naprop;
add_input_occupants_1yr_s        := le.bs.Ship_To_Out.addr_risk_summary.occupants_1yr ;
add_input_turnover_1yr_in_s      := le.bs.Ship_To_Out.addr_risk_summary.turnover_1yr_in ;
add_input_turnover_1yr_out_s     := le.bs.Ship_To_Out.addr_risk_summary.turnover_1yr_out ;
add_input_nhood_vac_prop_s       := le.bs.Ship_To_Out.addr_risk_summary.N_Vacant_Properties;
add_input_nhood_bus_ct_s         := le.bs.Ship_To_Out.addr_risk_summary.N_Business_Count ;
add_input_nhood_sfd_ct_s         := le.bs.Ship_To_Out.addr_risk_summary.N_SFD_Count ;
add_input_nhood_mfd_ct_s         := le.bs.Ship_To_Out.addr_risk_summary.N_MFD_Count;
add_input_pop_s                  := le.bs.Ship_To_Out.addrPop;
property_owned_total_s           := le.bs.Ship_To_Out.address_verification.owned.property_total;
add_curr_lres_s                  := le.bs.Ship_To_Out.lres2;
add_curr_avm_auto_val_s          := le.bs.Ship_To_Out.avm.address_history_1.avm_automated_valuation;
add_curr_avm_auto_val_2_s        := le.bs.Ship_To_Out.avm.address_history_1.avm_automated_valuation2;
add_curr_naprop_s                := le.bs.Ship_To_Out.address_verification.address_history_1.naprop;
add_curr_occupants_1yr_s         := le.bs.Ship_To_Out.addr_risk_summary2.occupants_1yr ;
add_curr_turnover_1yr_in_s       := le.bs.Ship_To_Out.addr_risk_summary2.turnover_1yr_in ;
add_curr_turnover_1yr_out_s      := le.bs.Ship_To_Out.addr_risk_summary2.turnover_1yr_out ;
add_curr_nhood_vac_prop_s        := le.bs.Ship_To_Out.addr_risk_summary2.N_Vacant_Properties;
add_curr_nhood_bus_ct_s          := le.bs.Ship_To_Out.addr_risk_summary2.N_Business_Count ;
add_curr_nhood_sfd_ct_s          := le.bs.Ship_To_Out.addr_risk_summary2.N_SFD_Count ;
add_curr_nhood_mfd_ct_s          := le.bs.Ship_To_Out.addr_risk_summary2.N_MFD_Count;
add_curr_pop_s                   := le.bs.Ship_To_Out.addrPop2;
add_prev_naprop_s                := le.bs.Ship_To_Out.address_verification.address_history_2.naprop;
addrs_10yr_s                     := le.bs.Ship_To_Out.other_address_info.addrs_last_10years;
addrs_15yr_s                     := le.bs.Ship_To_Out.other_address_info.addrs_last_15years;
addrs_prison_history_s           := le.bs.Ship_To_Out.other_address_info.isprison;
phone_ver_insurance_s            := le.bs.Ship_To_Out.insurance_phones_summary.Insurance_Phone_Verification;
phone_ver_experian_s             := le.bs.Ship_To_Out.Experian_Phone_Verification;
header_first_seen_s              := le.bs.Ship_To_Out.ssn_verification.header_first_seen;
ssns_per_adl_s                   := le.bs.Ship_To_Out.velocity_counters.ssns_per_adl;
adls_per_addr_curr_s             := le.bs.Ship_To_Out.velocity_counters.adls_per_addr_current;
ssns_per_adl_c6_s                := le.bs.Ship_To_Out.velocity_counters.ssns_per_adl_created_6months;
lnames_per_adl_c6_s              := le.bs.Ship_To_Out.velocity_counters.lnames_per_adl180;
adls_per_addr_c6_s               := le.bs.Ship_To_Out.velocity_counters.adls_per_addr_created_6months;
phones_per_addr_c6_s             := le.bs.Ship_To_Out.velocity_counters.phones_per_addr_created_6months ;
invalid_ssns_per_adl_s           := le.bs.Ship_To_Out.velocity_counters.invalid_ssns_per_adl;
invalid_addrs_per_adl_s          := le.bs.Ship_To_Out.velocity_counters.invalid_addrs_per_adl;
inq_count_s                      := le.bs.Ship_To_Out.acc_logs.inquiries.counttotal;
inq_count01_s                    := le.bs.Ship_To_Out.acc_logs.inquiries.count01;
inq_count03_s                    := le.bs.Ship_To_Out.acc_logs.inquiries.count03;
inq_count06_s                    := le.bs.Ship_To_Out.acc_logs.inquiries.count06;
inq_count12_s                    := le.bs.Ship_To_Out.acc_logs.inquiries.count12;
inq_count24_s                    := le.bs.Ship_To_Out.acc_logs.inquiries.count24;
inq_auto_count03_s               := le.bs.Ship_To_Out.acc_logs.auto.count03;
inq_auto_count12_s               := le.bs.Ship_To_Out.acc_logs.auto.count12;
inq_banking_count03_s            := le.bs.Ship_To_Out.acc_logs.banking.count03;
inq_collection_count12_s         := le.bs.Ship_To_Out.acc_logs.collection.count12;
inq_communications_count_s       := le.bs.Ship_To_Out.acc_logs.communications.counttotal;
inq_communications_count01_s     := le.bs.Ship_To_Out.acc_logs.communications.count01;
inq_communications_count03_s     := le.bs.Ship_To_Out.acc_logs.communications.count03;
inq_communications_count06_s     := le.bs.Ship_To_Out.acc_logs.communications.count06;
inq_communications_count12_s     := le.bs.Ship_To_Out.acc_logs.communications.count12;
inq_communications_count24_s     := le.bs.Ship_To_Out.acc_logs.communications.count24;
inq_highriskcredit_count_s       := le.bs.Ship_To_Out.acc_logs.highriskcredit.counttotal;
inq_highriskcredit_count01_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count01;
inq_highriskcredit_count03_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count03;
inq_highriskcredit_count06_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count06;
inq_highriskcredit_count12_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count12;
inq_highriskcredit_count24_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count24;
inq_retail_count_s               := le.bs.Ship_To_Out.acc_logs.retail.counttotal;
inq_retail_count01_s             := le.bs.Ship_To_Out.acc_logs.retail.count01;
inq_retail_count03_s             := le.bs.Ship_To_Out.acc_logs.retail.count03;
inq_retail_count06_s             := le.bs.Ship_To_Out.acc_logs.retail.count06;
inq_retail_count12_s             := le.bs.Ship_To_Out.acc_logs.retail.count12;
inq_retail_count24_s             := le.bs.Ship_To_Out.acc_logs.retail.count24;
inq_peraddr_s                    := le.bs.Ship_To_Out.acc_logs.inquiryPerAddr ;
inq_adlsperaddr_s                := le.bs.Ship_To_Out.acc_logs.inquiryADLsPerAddr ;
inq_lnamesperaddr_s              := le.bs.Ship_To_Out.acc_logs.inquiryLNamesPerAddr ;
inq_ssnsperaddr_s                := le.bs.Ship_To_Out.acc_logs.inquirySSNsPerAddr ;
inq_perphone_s                   := le.bs.Ship_To_Out.acc_logs.inquiryPerPhone ;
inq_adlsperphone_s               := le.bs.Ship_To_Out.acc_logs.inquiryADLsPerPhone ;
pb_number_of_sources_s           := IF(le.bs.Ship_To_Out.ibehavior.number_of_sources = '',NULL,(integer)le.bs.Ship_To_Out.ibehavior.number_of_sources);
pb_average_days_bt_orders_s      := IF(le.bs.Ship_To_Out.ibehavior.average_days_between_orders = '',NULL,(integer)le.bs.Ship_To_Out.ibehavior.average_days_between_orders);
pb_average_dollars_s             := IF(le.bs.Ship_To_Out.ibehavior.average_amount_per_order = '',NULL,(integer)le.bs.Ship_To_Out.ibehavior.average_amount_per_order);
pb_total_dollars_s               := IF(le.bs.Ship_To_Out.ibehavior.total_dollars = '',NULL,(integer)le.bs.Ship_To_Out.ibehavior.total_dollars);
pb_total_orders_s                := IF(le.bs.Ship_To_Out.ibehavior.total_number_of_orders = '',NULL,(integer)le.bs.Ship_To_Out.ibehavior.total_number_of_orders);
br_source_count_s                := le.bs.Ship_To_Out.employment.source_ct;
infutor_nap_s                    := le.bs.Ship_To_Out.infutor_phone.infutor_nap;
stl_inq_count_s                  := le.bs.Ship_To_Out.impulse.count;
email_count_s                    := le.bs.Ship_To_Out.email_summary.email_ct;
attr_num_unrel_liens60_s         := le.bs.Ship_To_Out.bjl.liens_unreleased_count60;
attr_eviction_count_s            := le.bs.Ship_To_Out.bjl.eviction_count;
attr_num_nonderogs_s             := le.bs.Ship_To_Out.source_verification.num_nonderogs;
attr_num_nonderogs90_s           := le.bs.Ship_To_Out.source_verification.num_nonderogs90;
attr_num_nonderogs180_s          := le.bs.Ship_To_Out.source_verification.num_nonderogs180;
attr_num_nonderogs12_s           := le.bs.Ship_To_Out.source_verification.num_nonderogs12;
attr_num_nonderogs24_s           := le.bs.Ship_To_Out.source_verification.num_nonderogs24;
attr_num_nonderogs36_s           := le.bs.Ship_To_Out.source_verification.num_nonderogs36;
attr_num_nonderogs60_s           := le.bs.Ship_To_Out.source_verification.num_nonderogs60;
fp_idrisktype_s                  := le.bs.Ship_To_Out.fdattributesv2.identityrisklevel;
fp_varrisktype_s                 := IF(le.bs.Ship_To_Out.fdattributesv2.variationrisklevel = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.variationrisklevel);
fp_varmsrcssnunrelcount_s        := le.bs.Ship_To_Out.fdattributesv2.variationmsourcesssnunrelcount;
fp_srchvelocityrisktype_s        := IF(le.bs.Ship_To_Out.fdattributesv2.searchvelocityrisklevel = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.searchvelocityrisklevel);
fp_srchunvrfdaddrcount_s         := le.bs.Ship_To_Out.fdattributesv2.searchunverifiedaddrcountyear;
fp_srchfraudsrchcountyr_s        := le.bs.Ship_To_Out.fdattributesv2.searchfraudsearchcountyear;
fp_assocsuspicousidcount_s       := le.bs.Ship_To_Out.fdattributesv2.assocsuspicousidentitiescount;
fp_assoccredbureaucount_s        := le.bs.Ship_To_Out.fdattributesv2.assoccreditbureauonlycount;
fp_validationrisktype_s          := le.bs.Ship_To_Out.fdattributesv2.validationrisklevel;
fp_corrrisktype_s                := le.bs.Ship_To_Out.fdattributesv2.correlationrisklevel;
fp_divaddrsuspidcountnew_s       := IF(le.bs.Ship_To_Out.fdattributesv2.divaddrsuspidentitycountnew = '',NULL,(integer)le.bs.Ship_To_Out.fdattributesv2.divaddrsuspidentitycountnew);
fp_srchssnsrchcountmo_s          := le.bs.Ship_To_Out.fdattributesv2.searchssnsearchcountmonth;
fp_srchaddrsrchcountmo_s         := IF(le.bs.Ship_To_Out.fdattributesv2.searchaddrsearchcountmonth = '',NULL,(integer)le.bs.Ship_To_Out.fdattributesv2.searchaddrsearchcountmonth);
fp_srchphonesrchcountmo_s        := le.bs.Ship_To_Out.fdattributesv2.searchphonesearchcountmonth;
fp_addrchangeincomediff_s        := (real)IF(le.bs.Ship_To_Out.fdattributesv2.addrchangeincomediff = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.addrchangeincomediff);
fp_addrchangevaluediff_s         := (real)IF(le.bs.Ship_To_Out.fdattributesv2.addrchangevaluediff = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.addrchangevaluediff);
fp_addrchangecrimediff_s         := (real)IF(le.bs.Ship_To_Out.fdattributesv2.addrchangecrimediff = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.addrchangecrimediff);
fp_addrchangeecontrajindex_s     := IF(le.bs.Ship_To_Out.fdattributesv2.addrchangeecontrajectoryindex = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.addrchangeecontrajectoryindex);
fp_curraddrmedianincome_s        := (real)IF(le.bs.Ship_To_Out.fdattributesv2.curraddrmedianincome = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.curraddrmedianincome);
fp_curraddrmedianvalue_s         := (real)IF(le.bs.Ship_To_Out.fdattributesv2.curraddrmedianvalue = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.curraddrmedianvalue);
fp_curraddrmurderindex_s         := le.bs.Ship_To_Out.fdattributesv2.curraddrmurderindex;
fp_curraddrcartheftindex_s       := le.bs.Ship_To_Out.fdattributesv2.curraddrcartheftindex;
fp_curraddrburglaryindex_s       := le.bs.Ship_To_Out.fdattributesv2.curraddrburglaryindex;
fp_curraddrcrimeindex_s          := le.bs.Ship_To_Out.fdattributesv2.curraddrcrimeindex;
fp_prevaddrageoldest_s           := (integer)IF(le.bs.Ship_To_Out.fdattributesv2.prevaddrageoldest = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.prevaddrageoldest);
fp_prevaddrlenofres_s            := (integer)IF(le.bs.Ship_To_Out.fdattributesv2.prevaddrlenofres = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.prevaddrlenofres);
fp_prevaddrstatus_s              := le.bs.Ship_To_Out.fdattributesv2.prevaddrstatus;
fp_prevaddrmedianvalue_s         := (real)IF(le.bs.Ship_To_Out.fdattributesv2.prevaddrmedianvalue = '',sNULL,le.bs.Ship_To_Out.fdattributesv2.prevaddrmedianvalue);
fp_prevaddrmurderindex_s         := le.bs.Ship_To_Out.fdattributesv2.prevaddrmurderindex;
fp_prevaddrcartheftindex_s       := le.bs.Ship_To_Out.fdattributesv2.prevaddrcartheftindex;
fp_prevaddrburglaryindex_s       := le.bs.Ship_To_Out.fdattributesv2.prevaddrburglaryindex;
fp_prevaddrcrimeindex_s          := le.bs.Ship_To_Out.fdattributesv2.prevaddrcrimeindex;
liens_recent_unreleased_count_s  := le.bs.Ship_To_Out.bjl.liens_recent_unreleased_count;
liens_historical_unreleased_ct_s := le.bs.Ship_To_Out.bjl.liens_historical_unreleased_count;
liens_rel_ot_total_amount_s      := le.bs.Ship_To_Out.liens.liens_released_other_tax.total_amount;
felony_count_s                   := le.bs.Ship_To_Out.bjl.felony_count;
hh_members_ct_s                  := le.bs.Ship_To_Out.hhid_summary.hh_members_ct;
hh_age_65_plus_s                 := le.bs.Ship_To_Out.hhid_summary.hh_age_65_plus;
hh_age_30_to_65_s                := le.bs.Ship_To_Out.hhid_summary.hh_age_31_to_65;
hh_collections_ct_s              := le.bs.Ship_To_Out.hhid_summary.hh_collections_ct;
hh_payday_loan_users_s           := le.bs.Ship_To_Out.hhid_summary.hh_payday_loan_users;
hh_members_w_derog_s             := le.bs.Ship_To_Out.hhid_summary.hh_members_w_derog;
hh_criminals_s                   := le.bs.Ship_To_Out.hhid_summary.hh_criminals;
rel_count_s                      := le.bs.Ship_To_Out.relatives.relative_count;
rel_felony_count_s               := le.bs.Ship_To_Out.relatives.relative_felony_count;
rel_within25miles_count_s        := le.bs.Ship_To_Out.relatives.relative_within25miles_count;
rel_within100miles_count_s       := le.bs.Ship_To_Out.relatives.relative_within100miles_count;
rel_within500miles_count_s       := le.bs.Ship_To_Out.relatives.relative_within500miles_count;
rel_incomeunder75_count_s        := le.bs.Ship_To_Out.relatives.relative_incomeunder75_count;
rel_incomeunder100_count_s       := le.bs.Ship_To_Out.relatives.relative_incomeunder100_count;
rel_incomeover100_count_s        := le.bs.Ship_To_Out.relatives.relative_incomeover100_count;
rel_homeunder100_count_s         := le.bs.Ship_To_Out.relatives.relative_homeunder100_count;
rel_homeunder150_count_s         := le.bs.Ship_To_Out.relatives.relative_homeunder150_count;
rel_homeunder200_count_s         := le.bs.Ship_To_Out.relatives.relative_homeunder200_count;
rel_homeunder300_count_s         := le.bs.Ship_To_Out.relatives.relative_homeunder300_count;
rel_homeunder500_count_s         := le.bs.Ship_To_Out.relatives.relative_homeunder500_count;
rel_homeover500_count_s          := le.bs.Ship_To_Out.relatives.relative_homeover500_count;
rel_educationover12_count_s      := le.bs.Ship_To_Out.relatives.relative_educationover12_count;
rel_ageunder50_count_s           := le.bs.Ship_To_Out.relatives.relative_ageunder50_count;
rel_ageunder60_count_s           := le.bs.Ship_To_Out.relatives.relative_ageunder60_count;
rel_ageunder70_count_s           := le.bs.Ship_To_Out.relatives.relative_ageunder70_count;
rel_ageover70_count_s            := le.bs.Ship_To_Out.relatives.relative_ageover70_count;
inferred_age_s                   := le.bs.Ship_To_Out.inferred_age;
estimated_income_s               := le.bs.Ship_To_Out.estimated_income;

/* Census Variables */
BT_cen_blue_col_RAW := (real)IF(le.easi.blue_col  in [''], sNULL, le.easi.blue_col );
BT_cen_business_RAW := (real)IF(le.easi.business  in [''], sNULL, le.easi.business );
BT_cen_civ_emp_RAW := (real)IF(le.easi.civ_emp  in [''], sNULL, le.easi.civ_emp );
BT_cen_easiqlife_RAW := (real)IF(le.easi.easiqlife  in [''], sNULL, le.easi.easiqlife );
BT_cen_families_RAW := (real)IF(le.easi.families  in [''], sNULL, le.easi.families );
BT_cen_health_RAW := (real)IF(le.easi.health  in [''], sNULL, le.easi.health );
BT_cen_high_ed_RAW := (real)IF(le.easi.high_ed  in [''], sNULL, le.easi.high_ed );
BT_cen_high_hval_RAW := (real)IF(le.easi.high_hval  in [''], sNULL, le.easi.high_hval );
BT_cen_incollege_RAW := (real)IF(le.easi.incollege  in [''], sNULL, le.easi.incollege );
BT_cen_lar_fam_RAW := (real)IF(le.easi.lar_fam  in [''], sNULL, le.easi.lar_fam );
BT_cen_low_hval_RAW := (real)IF(le.easi.low_hval  in [''], sNULL, le.easi.low_hval );
BT_cen_med_hval_RAW := (real)IF(le.easi.med_hval  in [''], sNULL, le.easi.med_hval );
BT_cen_med_rent_RAW := (real)IF(le.easi.med_rent  in [''], sNULL, le.easi.med_rent );
BT_cen_no_move_RAW := (real)IF(le.easi.no_move  in [''], sNULL, le.easi.no_move );
BT_cen_ownocc_p_RAW := (real)IF(le.easi.OWNOCP  in [''], sNULL, le.easi.OWNOCP );
BT_cen_pop_0_5_p_RAW := (real)IF(le.easi.pop_0_5_p  in [''], sNULL, le.easi.pop_0_5_p );
BT_cen_rental_RAW := (real)IF(le.easi.rental  in [''], sNULL, le.easi.rental );
BT_cen_retired2_RAW := (real)IF(le.easi.retired2  in [''], sNULL, le.easi.retired2 );
BT_cen_span_lang_RAW := (real)IF(le.easi.span_lang  in [''], sNULL, le.easi.span_lang );
BT_cen_totcrime_RAW := (real)IF(le.easi.totcrime  in [''], sNULL, le.easi.totcrime );
BT_cen_trailer_RAW := (real)IF(le.easi.trailer  in [''], sNULL, le.easi.trailer );
BT_cen_unemp_RAW := (real)IF(le.easi.unemp  in [''], sNULL, le.easi.unemp );
BT_cen_urban_p_RAW := (real)IF(le.easi.urban_p  in [''], sNULL, le.easi.urban_p );
BT_cen_vacant_p_RAW := (real)IF(le.easi.vacant_p  in [''], sNULL, le.easi.vacant_p );
BT_cen_very_rich_RAW := (real)IF(le.easi.very_rich  in [''], sNULL, le.easi.very_rich );
ST_cen_blue_col_RAW := (real)IF(le.easi2.blue_col  in [''], sNULL, le.easi2.blue_col );
ST_cen_business_RAW := (real)IF(le.easi2.business  in [''], sNULL, le.easi2.business );
ST_cen_civ_emp_RAW := (real)IF(le.easi2.civ_emp  in [''], sNULL, le.easi2.civ_emp );
ST_cen_easiqlife_RAW := (real)IF(le.easi2.easiqlife  in [''], sNULL, le.easi2.easiqlife );
ST_cen_families_RAW := (real)IF(le.easi2.families  in [''], sNULL, le.easi2.families );
ST_cen_health_RAW := (real)IF(le.easi2.health  in [''], sNULL, le.easi2.health );
ST_cen_high_ed_RAW := (real)IF(le.easi2.high_ed  in [''], sNULL, le.easi2.high_ed );
ST_cen_high_hval_RAW := (real)IF(le.easi2.high_hval  in [''], sNULL, le.easi2.high_hval );
ST_cen_incollege_RAW := (real)IF(le.easi2.incollege  in [''], sNULL, le.easi2.incollege );
ST_cen_lar_fam_RAW := (real)IF(le.easi2.lar_fam  in [''], sNULL, le.easi2.lar_fam );
ST_cen_low_hval_RAW := (real)IF(le.easi2.low_hval  in [''], sNULL, le.easi2.low_hval );
ST_cen_med_hhinc_RAW := (real)IF(le.easi2.med_hhinc  in [''], sNULL, le.easi2.med_hhinc );
ST_cen_med_hval_RAW := (real)IF(le.easi2.med_hval  in [''], sNULL, le.easi2.med_hval );
ST_cen_med_rent_RAW := (real)IF(le.easi2.med_rent  in [''], sNULL, le.easi2.med_rent );
ST_cen_mil_emp_RAW := (real)IF(le.easi2.mil_emp  in [''], sNULL, le.easi2.mil_emp );
ST_cen_no_move_RAW := (real)IF(le.easi2.no_move  in [''], sNULL, le.easi2.no_move );
ST_cen_ownocc_p_RAW := (real)IF(le.easi2.OWNOCP  in [''], sNULL, le.easi2.OWNOCP );
ST_cen_pop_0_5_p_RAW := (real)IF(le.easi2.pop_0_5_p  in [''], sNULL, le.easi2.pop_0_5_p );
ST_cen_rental_RAW := (real)IF(le.easi2.rental  in [''], sNULL, le.easi2.rental );
ST_cen_retired2_RAW := (real)IF(le.easi2.retired2  in [''], sNULL, le.easi2.retired2 );
ST_cen_span_lang_RAW := (real)IF(le.easi2.span_lang  in [''], sNULL, le.easi2.span_lang );
ST_cen_totcrime_RAW := (real)IF(le.easi2.totcrime  in [''], sNULL, le.easi2.totcrime );
ST_cen_trailer_RAW := (real)IF(le.easi2.trailer  in [''], sNULL, le.easi2.trailer );
ST_cen_unemp_RAW := (real)IF(le.easi2.unemp  in [''], sNULL, le.easi2.unemp );
ST_cen_urban_p_RAW := (real)IF(le.easi2.urban_p  in [''], sNULL, le.easi2.urban_p );
ST_cen_vacant_p_RAW := (real)IF(le.easi2.vacant_p  in [''], sNULL, le.easi2.vacant_p );
ST_cen_very_rich_RAW := (real)IF(le.easi2.very_rich  in [''], sNULL, le.easi2.very_rich );

/*   Taken from OSN1504_0_0   */
btst_are_relatives               := (integer)le.bs.eddo.btst_are_relatives;
btst_relatives_in_common         := (integer)le.bs.eddo.btst_relatives_in_common;

/* Taken from sas ecl mapping (missed originally) */
add_input_advo_drop              := le.bs.Bill_To_Out.advo_input_addr.Drop_Indicator;
bk_disposed_historical_count     := le.bs.Bill_To_Out.bjl.bk_disposed_historical_count;
fp_varmsrcssnunrelcount          := IF(le.bs.Bill_To_Out.fdattributesv2.variationmsourcesssnunrelcount = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.variationmsourcesssnunrelcount);
fp_divsrchaddrsuspidcount        := IF(le.bs.Bill_To_Out.fdattributesv2.divsearchaddrsuspidentitycount = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.divsearchaddrsuspidentitycount);
fp_srchaddrsrchcountwk           := IF(le.bs.Bill_To_Out.fdattributesv2.searchaddrsearchcountweek = '',NULL,(integer)le.bs.Bill_To_Out.fdattributesv2.searchaddrsearchcountweek);
inq_retail_count_week            := le.bs.Bill_To_Out.acc_logs.retail.countweek;
inq_retailpayments_count01       := le.bs.Bill_To_Out.acc_logs.retailpayments.count01;
inq_retailpayments_count03       := le.bs.Bill_To_Out.acc_logs.retailpayments.count03;
inq_retailpayments_count06       := le.bs.Bill_To_Out.acc_logs.retailpayments.count06;
inq_retailpayments_count12       := le.bs.Bill_To_Out.acc_logs.retailpayments.count12;
in_fname                         := le.bs.Bill_To_Out.shell_input.fname;
in_fname_s                       := le.bs.Ship_To_Out.shell_input.fname;
liens_unrel_st_first_seen        := le.bs.Bill_To_Out.liens.liens_unreleased_suits.earliest_filing_date;
liens_unrel_st_last_seen         := le.bs.Bill_To_Out.liens.liens_unreleased_suits.most_recent_filing_date;
rc_phonevalflag_s                := le.bs.Ship_To_Out.iid.phonevalflag;
rc_hphonevalflag_s               := le.bs.Ship_To_Out.iid.hphonevalflag;
rc_phonetype_s                   := le.bs.Ship_To_Out.iid.phonetype;
emailpop_s                       := le.bs.Ship_To_Out.input_validation.email;
recent_disconnects_s             := le.bs.Ship_To_Out.phone_verification.recent_disconnects;
invalid_phones_per_adl_s         := le.bs.Ship_To_Out.velocity_counters.invalid_phones_per_adl;
invalid_phones_per_adl_c6_s      := le.bs.Ship_To_Out.velocity_counters.invalid_phones_per_adl_created_6months;
invalid_addrs_per_adl_c6_s       := le.bs.Ship_To_Out.velocity_counters.invalid_addrs_per_adl_created_6months;
inq_mortgage_count03_s           := le.bs.Ship_To_Out.acc_logs.mortgage.count03;
inq_prepaidcards_count_s         := le.bs.Ship_To_Out.acc_logs.prepaidcards.counttotal;
inq_prepaidcards_count01_s       := le.bs.Ship_To_Out.acc_logs.prepaidcards.count01;
inq_prepaidcards_count03_s       := le.bs.Ship_To_Out.acc_logs.prepaidcards.count03;
inq_prepaidcards_count06_s       := le.bs.Ship_To_Out.acc_logs.prepaidcards.count06;
inq_prepaidcards_count12_s       := le.bs.Ship_To_Out.acc_logs.prepaidcards.count12;
inq_prepaidcards_count24_s       := le.bs.Ship_To_Out.acc_logs.prepaidcards.count24;
email_verification_s             := le.bs.Ship_To_Out.email_summary.identity_email_verification_level;
fp_assocrisktype_s               := le.bs.Ship_To_Out.fdattributesv2.assocrisklevel;
fp_srchcomponentrisktype_s       := le.bs.Ship_To_Out.fdattributesv2.searchcomponentrisklevel;
fp_srchaddrsrchcountwk_s         := le.bs.Ship_To_Out.fdattributesv2.searchaddrsearchcountweek;
fp_srchphonesrchcountwk_s        := le.bs.Ship_To_Out.fdattributesv2.searchphonesearchcountweek;
liens_unrel_ot_last_seen_s       := le.bs.Ship_To_Out.liens.liens_unreleased_other_tax.most_recent_filing_date;
liens_rel_ot_last_seen_s         := le.bs.Ship_To_Out.liens.liens_released_other_tax.most_recent_filing_date;
liens_unrel_sc_first_seen_s      := le.bs.Ship_To_Out.liens.liens_unreleased_small_claims.earliest_filing_date;
liens_unrel_st_total_amount_s    := le.bs.Ship_To_Out.liens.liens_unreleased_suits.total_amount;
foreclosure_last_date_s          := le.bs.Ship_To_Out.bjl.last_foreclosure_date;
rel_criminal_count_s             := le.bs.Ship_To_Out.relatives.relative_criminal_count;


/* ******************************************************************
	 ******************************************************************
	 ****************************************************************** */


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

STRING getEmailDomain(STRING input, STRING delimiters = './@') := FUNCTION
  ReplaceDelim := STD.str.SubstituteIncluded(input,delimiters,' ');
	lWordNum := StringLib.StringWordCount(ReplaceDelim);
	RETURN Std.Str.GetNthWord(ReplaceDelim, lWordNum);
END;

sysdate := common.sas_date(if(le.bs.Bill_To_Out.historydate=999999, (STRING)Std.Date.Today(), (string6)le.bs.Bill_To_Out.historydate+'01'));
// sysdate := common.sas_date('20160525');
	
pf_pmt_type := map(
    Pay_Code_1 = 'A' => 'American Express',
    Pay_Code_1 = 'C' => 'Diners Club     ',
    Pay_Code_1 = 'D' => 'Discover        ',
    Pay_Code_1 = 'M' => 'Mastercard      ',
    Pay_Code_1 = 'O' => 'Credit Terms    ',
    Pay_Code_1 = 'P' => 'Prepaid Check   ',
    Pay_Code_1 = 'R' => 'Dell Credit Card',
    Pay_Code_1 = 'V' => 'Visa            ',
    Pay_Code_1 = '8' => 'Gift Card       ',
                        'Other');

pf_avs_addr := (integer)(AVS_RESPONSE_CODE in ['A', 'O', 'Y', 'M']);

pf_avs_zip := (integer)(AVS_RESPONSE_CODE in ['F', 'L', 'M', 'W', 'Y', 'Z']);

pf_avs_name := (integer)(AVS_RESPONSE_CODE in ['K', 'L', 'M', 'O']);

pf_avs_error := (integer)(AVS_RESPONSE_CODE in ['', '*', '+', 'R']);

pf_avs_invalid := (integer)(AVS_RESPONSE_CODE in ['0', 'D', 'E']);

pf_avs_unavail := (integer)(AVS_RESPONSE_CODE in ['U', 'X']);

pf_avs_no_match := (integer)(AVS_RESPONSE_CODE in ['N']);

pf_avs_intl := (integer)(AVS_RESPONSE_CODE in ['G', 'P']);

pf_avs_not_supp := (integer)(AVS_RESPONSE_CODE in ['S']);

pf_avs_result := map(
    (boolean)pf_avs_addr and (boolean)pf_avs_zip 	=> 'Full Match   ',
    (boolean)pf_avs_addr                					=> 'Addr Only    ',
    (boolean)pf_avs_zip                 					=> 'Zip Only     ',
    (boolean)pf_avs_no_match            					=> 'No Match     ',
    (boolean)pf_avs_intl                					=> 'International',
    (boolean)pf_avs_unavail             					=> 'Unavailable  ',
    (boolean)pf_avs_not_supp            					=> 'Not Supported',
																										 'Error/Inval');

pf_pmt_x_avs_lvl := map(
    (pf_pmt_type in ['Credit Terms', 'Dell Credit Card', 'Other'])                                   => 8,
    pf_pmt_type = 'American Express' and pf_avs_result = 'Full Match' and (boolean)pf_avs_name       => 7,
    (pf_pmt_type in ['Diners Club', 'Gift Card'])                                                    => 6,
    pf_pmt_type = 'American Express' and pf_avs_result = 'Full Match'                                => 6,
    pf_pmt_type = 'American Express' and (pf_avs_result in ['Addr Only', 'Error/Inval', 'Zip Only']) => 6,
    pf_pmt_type = 'Mastercard' and (pf_avs_result in ['Full Match', 'Unavailable', 'Zip Only'])      => 5,
    pf_pmt_type = 'Visa' and (pf_avs_result in ['Full Match', 'Zip Only'])                           => 5,
    pf_pmt_type = 'Discover' and (pf_avs_result in ['Full Match', 'Zip Only'])                       => 4,
    (pf_pmt_type in ['Visa', 'Mastercard']) and (pf_avs_result in ['Addr Only'])                     => 4,
    pf_pmt_type = 'Discover' and (pf_avs_result in ['Addr Only', 'Error/Inval'])                     => 3,
    pf_pmt_type = 'Visa' and (pf_avs_result in ['Error/Inval'])                                      => 3,
    pf_pmt_type = 'Prepaid Check'                                                                    => 3,
    (pf_pmt_type in ['Visa', 'Mastercard']) and (pf_avs_result in ['No Match', 'Unavailable'])       => 2,
    (pf_pmt_type in ['Discover']) and (pf_avs_result in ['Unavailable'])                             => 2,
    pf_pmt_type = 'Mastercard' and pf_avs_result = 'Error/Inval'                                     => 1,
    pf_pmt_type = 'American Express' and pf_avs_result = 'No Match'                                  => 1,
    (pf_avs_result in ['International', 'No Match', 'Unavailable', 'Not Supported'])                 => 0,
                                                                                                        -1);

pf_cid_result := map(
    (CID_RESPONSE_CODE in ['', '**']) => 'Null    ',
    (CID_RESPONSE_CODE in ['I'])      => 'Invalid ',
    (CID_RESPONSE_CODE in ['M', 'Y']) => 'Match   ',
    (CID_RESPONSE_CODE in ['N'])      => 'No Match',
                                         'Other');

pf_ship_method := map(
    Local_Ship_Code = '2' => 'Next Day',
    Local_Ship_Code = '7' => '2nd Day ',
    Local_Ship_Code = 'E' => '3rd Day ',
    Local_Ship_Code = 'L' => 'Ground  ',
                             'Other');

pf_order_amt_c := min(if(max((integer)Order_Amt, 250) = NULL, -NULL, max((integer)Order_Amt, 250)), 20000);

acquisition_channel := map(acquisition_channel1 = 'De'  => '01',  //This map statement should be redundant as everything should already be in ['01','02',' ']. // cleanup/cheated
													 acquisition_channel1 = 'Ot'  => '02',
																													 acquisition_channel1);

pf_product_desc := (integer)BASE_SKU_PRODUCT_DESC;  // cleanup/cheated

pf_business_flag := if(US_business_consumer_flag = '0', 1, 0);

pf_acquisition_channel := map(
(integer)Acquisition_Channel = 1 		 => 'WEB',
                                        'OTH');

addr_match := (integer)(addrscore = '100' or not(addrpop_s));

fname_match := (integer)(firstscore = '100');

lname_match := (integer)(lastscore = '100');

did_match := (integer)(truedid and truedid_s and did = did_s);

bs_segment2 := map(
    (boolean)addr_match and (boolean)did_match                      => 1,
    (boolean)addr_match and (boolean)btst_are_relatives             => 1,
    (boolean)addr_match and (boolean)btst_relatives_in_common      	=> 1,
    (boolean)addr_match                                            	=> 2,
    not((boolean)addr_match) and (boolean)did_match              	  => 3,
    not((boolean)addr_match) and (boolean)btst_are_relatives        => 3,
    not((boolean)addr_match) and (boolean)btst_relatives_in_common  => 3,
    not((boolean)addr_match) and (boolean)lname_match               => 4,
                                                                       5);

dell_segmentation2 := map(
    US_business_consumer_flag = '1' => bs_segment2,
    (boolean)addr_match             => 8,
                                       9);

dell_segmentation3 := if((integer)Acquisition_Channel = 1, dell_segmentation2, dell_segmentation2 + 10);

final_model_segment := map(
    dell_segmentation3 = 1  => 'CONS ADDR+ ID/RELS WEB',
    dell_segmentation3 = 2  => 'CONS ADDR+ DIFF    WEB',
    dell_segmentation3 = 3  => 'CONS ADDR- ID/RELS WEB',
    dell_segmentation3 = 4  => 'CONS ADDR- LNAME   WEB',
    dell_segmentation3 = 5  => 'CONS ADDR- DIFF    WEB',
    dell_segmentation3 = 8  => 'BUS  ADDR+         WEB',
    dell_segmentation3 = 9  => 'BUS  ADDR-         WEB',
    dell_segmentation3 = 11 => 'CONS ADDR+ ID/RELS OTH',
    dell_segmentation3 = 12 => 'CONS ADDR+ DIFF    OTH',
    dell_segmentation3 = 13 => 'CONS ADDR- ID/RELS OTH',
    dell_segmentation3 = 14 => 'CONS ADDR- LNAME   OTH',
    dell_segmentation3 = 15 => 'CONS ADDR- DIFF    OTH',
    dell_segmentation3 = 18 => 'BUS  ADDR+         OTH',
                               'BUS  ADDR-         OTH');

btst_relatives_lvl_d_2 := map(
    not(truedid) and not(truedid_s) 					=> '1. BOTH DID 0         ',
    not(truedid)                    					=> '2. BILLTO DID 0       ',
    not(truedid_s)                  					=> '3. SHIPTO DID 0       ',
    did = did_s                     					=> '4. DIDS EQUAL         ',
    (boolean)btst_are_relatives               => '5. RELATIVES          ',
    (boolean)btst_relatives_in_common         => '6. RELATIVES IN COMMON',
																								 '7. NO RELATION');

btst_firstscore_d_2 := firstscore;

btst_lastscore_d_2 := lastscore;

btst_email_last_score_d_2 := elastscore;

btst_distphoneaddr_i := (integer)if(not(hphnpop) and not(addrpop), sNULL, distphoneaddr);

btst_distphone2addr2_i := (integer)if(not(hphnpop_s) and not(addrpop_s), sNULL, distphone2addr2);

btst_distphoneaddr2_i := (integer)if(not(hphnpop) and not(addrpop_s), sNULL, distphoneaddr2);

btst_distaddraddr2_i := (integer)if(not(addrpop) and not(addrpop_s), sNULL, distaddraddr2);

email_topleveldomain := getEmailDomain(in_email_address);

btst_email_topleveldomain_n := map(
    in_email_address = ''                                                             => ' ',
    (email_topleveldomain in ['COM', 'NET', 'EDU', 'ORG', 'US', 'GOV', 'BIZ', 'MIL']) => email_topleveldomain,
                                                                                         'OTH');

b_nap_phn_verd_d := (integer)(nap_summary in [4, 6, 7, 9, 10, 11, 12]);

b_nap_contradictory_i := (integer)(nap_summary in [1]);

b_p88_phn_dst_to_inp_add_i := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

b_p85_phn_not_issued_i := map(
    not(hphnpop)                 => NULL,
    (rc_pwphonezipflag in ['4']) => 1,
                                    0);

b_p85_phn_invalid_i := map(
    not(hphnpop)                                                          => NULL,
    rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' => 1,
                                                                             0);

b_l75_add_drop_delivery_i := map(
    not(add_input_pop)                                       => NULL,
    trim(trim(add_input_advo_drop, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                0);

b_l71_add_business_i := map(
    not(add_input_pop)                                                       => NULL,
    (trim(trim(add_input_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => 1,
                                                                                0);

b_f01_inp_addr_address_score_d_1 := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

b_d31_bk_disposed_hist_count_i_1 := if(not(truedid), NULL, min(if(bk_disposed_historical_count = NULL, -NULL, bk_disposed_historical_count), 999));

bureau_adl_eq_fseen_pos_2 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_2 := if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_2, ','));

_bureau_adl_fseen_eq_2 := common.sas_date((string)(bureau_adl_fseen_eq_2));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999);

b_c21_m_bureau_adl_fs_d_1 := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

bureau_adl_eq_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_1 := if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos_1, ','));

_bureau_adl_fseen_eq_1 := common.sas_date((string)(bureau_adl_fseen_eq_1));

bureau_adl_en_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en_1 := if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos_1, ','));

_bureau_adl_fseen_en_1 := common.sas_date((string)(bureau_adl_fseen_en_1));

bureau_adl_ts_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts_1 := if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos_1, ','));

_bureau_adl_fseen_ts_1 := common.sas_date((string)(bureau_adl_fseen_ts_1));

bureau_adl_tu_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu_1 := if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos_1, ','));

_bureau_adl_fseen_tu_1 := common.sas_date((string)(bureau_adl_fseen_tu_1));

bureau_adl_tn_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn_1 := if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos_1, ','));

_bureau_adl_fseen_tn_1 := common.sas_date((string)(bureau_adl_fseen_tn_1));

_src_bureau_adl_fseen_all := min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, _bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = NULL, -NULL, _bureau_adl_fseen_eq_1), 999999);

b_m_bureau_adl_fs_all_d_1 := map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
                                          min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));

_bureau_adl_fseen_en := common.sas_date((string)(bureau_adl_fseen_en));

bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));

_bureau_adl_fseen_ts := common.sas_date((string)(bureau_adl_fseen_ts));

bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));

_bureau_adl_fseen_tu := common.sas_date((string)(bureau_adl_fseen_tu));

bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));

_bureau_adl_fseen_tn := common.sas_date((string)(bureau_adl_fseen_tn));

_src_bureau_adl_fseen_notu := min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

b_m_bureau_adl_fs_notu_d_1 := map(
    not(truedid)                        => NULL,
    _src_bureau_adl_fseen_notu = 999999 => 1000,
                                           min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

b_c10_m_hdr_fs_d_1 := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

b_comb_age_d_1 := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

b_f03_address_match_d_1 := map(
    not(truedid)                                => NULL,
    add_input_isbestmatch                       => 4,
    not(add_input_pop) and add_curr_isbestmatch => 3,
    add_input_pop and add_curr_isbestmatch      => 2,
    add_curr_pop                                => 1,
    add_input_pop                               => 0,
                                                   NULL);

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

b_c13_curr_addr_lres_d_1 := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

b_c14_addr_stability_v2_d_1 := map(
    not(truedid)          	=> sNULL,
    addr_stability_v2 = ' ' => sNULL,
    addr_stability_v2 = '0' => sNULL,
                               addr_stability_v2);

b_c13_max_lres_d_1 := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

b_c14_addrs_5yr_i_1 := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

b_c14_addrs_10yr_i_1 := if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

b_c14_addrs_15yr_i_1 := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

b_c20_email_count_i_1 := if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999));

b_l79_adls_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

b_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

b_c18_invalid_addrs_per_adl_i_1 := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

b_a50_pb_average_dollars_d_1 := map(
    not(truedid)              => NULL,
    pb_average_dollars = NULL => 5000,
                                 min(if(pb_average_dollars = NULL, -NULL, pb_average_dollars), 5000));

b_a50_pb_total_dollars_d_1 := map(
    not(truedid)            => NULL,
    pb_total_dollars = NULL => 10001,
                               min(if(pb_total_dollars = NULL, -NULL, pb_total_dollars), 10000));

b_a50_pb_total_orders_d_1 := map(
    not(truedid)           => NULL,
    pb_total_orders = NULL => -1,
                              pb_total_orders);

b_pb_order_freq_d_1 := map(
    not(truedid)                     => NULL,
    pb_number_of_sources = NULL      => NULL,
    pb_average_days_bt_orders = NULL => -1,
                                        min(if(pb_average_days_bt_orders = NULL, -NULL, pb_average_days_bt_orders), 999));

b_i60_inq_count12_i_1 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

b_i60_inq_recency_d_1 := map(
    not(truedid) 					=> NULL,
    (boolean)inq_count01  => 1,
    (boolean)inq_count03  => 3,
    (boolean)inq_count06  => 6,
    (boolean)inq_count12  => 12,
    (boolean)inq_count24  => 24,
    (boolean)inq_count    => 99,
														 999);

b_i61_inq_collection_count12_i_1 := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999));

b_i60_inq_auto_recency_d_1 := map(
    not(truedid)     					=> NULL,
    (boolean)inq_auto_count01 => 1,
    (boolean)inq_auto_count03 => 3,
    (boolean)inq_auto_count06 => 6,
    (boolean)inq_auto_count12 => 12,
    (boolean)inq_auto_count24 => 24,
    (boolean)inq_auto_count   => 99,
																 999);

b_i60_inq_mortgage_recency_d_1 := map(
    not(truedid)         					=> NULL,
    (boolean)inq_mortgage_count01 => 1,
    (boolean)inq_mortgage_count03 => 3,
    (boolean)inq_mortgage_count06 => 6,
    (boolean)inq_mortgage_count12 => 12,
    (boolean)inq_mortgage_count24 => 24,
    (boolean)inq_mortgage_count   => 99,
																		 999);

b_i60_inq_retail_recency_d_1 := map(
    not(truedid)       				  => NULL,
    (boolean)inq_retail_count01 => 1,
    (boolean)inq_retail_count03 => 3,
    (boolean)inq_retail_count06 => 6,
    (boolean)inq_retail_count12 => 12,
    (boolean)inq_retail_count24 => 24,
    (boolean)inq_retail_count   => 99,
																	 999);

b_bus_name_nover_i := if(not(addrpop), NULL, (integer)(bus_name_match = 1));

b_bus_phone_match_d := if(not(addrpop), NULL, (integer)(bus_phone_match = 3));

b_util_add_input_inf_n_1 := if(contains_i(util_add_input_type_list, '1') > 0, 1, 0);

b_util_add_input_conv_n_1 := if(contains_i(util_add_input_type_list, '2') > 0, 1, 0);

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

b_inq_count24_i_1 := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

b_inq_collection_count24_i_1 := if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999));

b_inq_highriskcredit_count24_i_1 := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));

b_inq_other_count24_i_1 := if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999));

b_inq_retail_count24_i_1 := if(not(truedid), NULL, min(if(inq_Retail_count24 = NULL, -NULL, inq_Retail_count24), 999));

b_inq_per_addr_i_1 := if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

b_inq_adls_per_addr_i_1 := if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

b_inq_lnames_per_addr_i_1 := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

b_inq_ssns_per_addr_i_1 := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

b_inq_per_phone_i_1 := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

b_inq_adls_per_phone_i_1 := if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999));

_liens_unrel_ot_first_seen := common.sas_date((string)(liens_unrel_OT_first_seen));

b_mos_liens_unrel_ot_fseen_d_1 := map(
    not(truedid)                      => NULL,
    _liens_unrel_ot_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)))), 999));

_liens_rel_ot_last_seen := common.sas_date((string)(liens_rel_OT_last_seen));

b_mos_liens_rel_ot_lseen_d_1 := map(
    not(truedid)                   => NULL,
    _liens_rel_ot_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)))), 999)));

b_liens_rel_ot_total_amt_i_1 := if(not(truedid), NULL, liens_rel_OT_total_amount);

b_estimated_income_d_1 := if(not(truedid), NULL, estimated_income);

b_rel_count_i_1 := if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999));

b_rel_incomeover25_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count, rel_incomeunder50_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count))));

b_rel_incomeover50_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count))));

b_rel_incomeover75_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count))));

b_rel_incomeover100_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_incomeover100_count);

b_rel_homeover50_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

b_rel_homeover300_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

b_rel_homeover500_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_homeover500_count);

b_rel_ageover30_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

b_rel_ageover40_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

b_rel_educationover12_count_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_educationover12_count);

b_crim_rel_under100miles_cnt_i_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles))));

b_rel_under100miles_cnt_d_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count))));

b_rel_felony_count_i_1 := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_felony_count = NULL, -NULL, rel_felony_count), 999));


b_sourcerisktype_i_1 := map(
    not(truedid)             => sNULL,
    fp_sourcerisktype = ''   => sNULL,
                                fp_sourcerisktype);

b_varrisktype_i_1 := map(
    not(truedid)          => sNULL,
                             fp_varrisktype);

b_varmsrcssncount_i_1 := if(not(truedid), NULL, min(if(fp_varmsrcssncount = NULL, -NULL, fp_varmsrcssncount), 999));

b_varmsrcssnunrelcount_i_1 := if(not(truedid), NULL, min(if(fp_varmsrcssnunrelcount = NULL, -NULL, fp_varmsrcssnunrelcount), 999));

b_vardobcountnew_i_1 := if(not(truedid), NULL, min(if(fp_vardobcountnew = NULL, -NULL, fp_vardobcountnew), 999));

b_srchvelocityrisktype_i_1 := map(
    not(truedid)                   					=> (string)NULL,
    (integer)fp_srchvelocityrisktype = NULL => (string)NULL,
																							 fp_srchvelocityrisktype);

b_srchcountwk_i_1 := if(not(truedid), NULL, min(if(fp_srchcountwk = NULL, -NULL, fp_srchcountwk), 999));

b_srchunvrfdssncount_i_1 := if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = NULL, -NULL, fp_srchunvrfdssncount), 999));

b_srchunvrfdphonecount_i_1 := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = NULL, -NULL, fp_srchunvrfdphonecount), 999));

b_corrphonelastnamecount_d_1 := if(not(truedid), NULL, min(if(fp_corrphonelastnamecount = NULL, -NULL, fp_corrphonelastnamecount), 999));

b_divrisktype_i_1 := map(
    not(truedid)          				 => sNULL,
    fp_divrisktype = '' 					 => sNULL,
																			fp_divrisktype);

b_divaddrsuspidcountnew_i_1 := if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = NULL, -NULL, fp_divaddrsuspidcountnew), 999)); //6 errors

b_divsrchaddrsuspidcount_i_1 := if(not(truedid), NULL, min(if(fp_divsrchaddrsuspidcount = NULL, -NULL, fp_divsrchaddrsuspidcount), 999));

b_srchaddrsrchcountmo_i_1 := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = NULL, -NULL, fp_srchaddrsrchcountmo), 999));

b_srchaddrsrchcountwk_i_1 := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountwk = NULL, -NULL, fp_srchaddrsrchcountwk), 999));

b_componentcharrisktype_i_1 := map(
    not(truedid)                    				 => (string)NULL,
    (integer)fp_componentcharrisktype = NULL => (string)NULL,
																								fp_componentcharrisktype);
																								
    // if not truedid
        // then b_addrchangeincomediff_d = .;
    // if fp_addrchangeincomediff = -1
        // then b_addrchangeincomediff_d = .;
    // else b_addrchangeincomediff_d = fp_addrchangeincomediff;
// b_addrchangeincomediff_d_2 := if(not(truedid), NULL, NULL);
// b_addrchangeincomediff_d_1 := if(fp_addrchangeincomediff = -1, NULL, fp_addrchangeincomediff);

b_addrchangeincomediff_d_1 := map(
    not(truedid)                 => NULL,
    fp_addrchangeincomediff = -1 => NULL,
                                   fp_addrchangeincomediff);

b_addrchangevaluediff_d_1 := map(
    not(truedid)                => NULL,
    fp_addrchangevaluediff = -1 => NULL,
                                   fp_addrchangevaluediff);

b_addrchangecrimediff_i_1 := map(
    not(truedid)                => NULL,
    fp_addrchangecrimediff = -1 => NULL,
                                   fp_addrchangecrimediff);

b_addrchangeecontrajindex_d_1 := if(not(truedid) or fp_addrchangeecontrajindex = '' or fp_addrchangeecontrajindex = '-1', NULL, (integer)fp_addrchangeecontrajindex);

b_curraddractivephonelist_d_1 := map(
    not(add_curr_pop)                 => sNULL,
    fp_curraddractivephonelist = '-1' => sNULL,
                                         fp_curraddractivephonelist);

b_curraddrmedianincome_d_1 := if(not(add_curr_pop), NULL, fp_curraddrmedianincome);

b_curraddrmedianvalue_d_1 := if(not(add_curr_pop), NULL, fp_curraddrmedianvalue);

b_curraddrmurderindex_i_1 := if(not(add_curr_pop), sNULL, fp_curraddrmurderindex);

b_curraddrburglaryindex_i_1 := if(not(add_curr_pop), sNULL, fp_curraddrburglaryindex);

b_curraddrcrimeindex_i_1 := if(not(add_curr_pop), sNULL, fp_curraddrcrimeindex);

b_prevaddrageoldest_d_1 := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = NULL, -NULL, fp_prevaddrageoldest), 999));

b_prevaddrlenofres_d_1 := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = NULL, -NULL, fp_prevaddrlenofres), 999));

b_prevaddrmedianincome_d_1 := if(not(truedid), NULL, fp_prevaddrmedianincome);

b_prevaddrmedianvalue_d_1 := if(not(truedid), sNULL, fp_prevaddrmedianvalue);

b_prevaddrmurderindex_i_1 := if(not(truedid), sNULL, fp_prevaddrmurderindex);

b_fp_prevaddrburglaryindex_i_1 := if(not(truedid), sNULL, fp_prevaddrburglaryindex);

b_fp_prevaddrcrimeindex_i_1 := if(not(truedid), sNULL, fp_prevaddrcrimeindex);

b_c12_source_profile_d_1 := if(not(truedid), NULL, hdr_source_profile);

b_c23_inp_addr_occ_index_d_1 := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

b_f04_curr_add_occ_index_d_1 := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);

b_e57_br_source_count_d_1 := if(not(truedid), NULL, br_source_count);

b_i60_inq_retpymt_recency_d_1 := map(
    not(truedid)               					=> NULL,
    (boolean)inq_retailpayments_count01 => 1,
    (boolean)inq_retailpayments_count03 => 3,
    (boolean)inq_retailpayments_count06 => 6,
    (boolean)inq_retailpayments_count12 => 12,
    (boolean)inq_retailpayments_count24 => 24,
    (boolean)inq_retailpayments_count   => 99,
																					 999);

b_phone_ver_insurance_d_1 := if(not(truedid) or phone_ver_insurance = '-1', NULL, (integer)phone_ver_insurance);

b_phone_ver_experian_d_1 := if(not(truedid) or phone_ver_experian = '-1', NULL, (integer)phone_ver_experian);

b_phones_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));

b_phones_per_addr_c6_i := if(not(addrpop), NULL, min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 999));

b_inq_retail_count_week_i_1 := if(not(truedid), NULL, min(if(inq_Retail_count_week = NULL, -NULL, inq_Retail_count_week), 999));

b_adl_per_email_i_1 := if(not(emailpop), NULL, min(if(adl_per_email = NULL, -NULL, adl_per_email), 999));

b_c20_email_verification_d_1 := if(not(emailpop), sNULL, email_verification);

_liens_unrel_st_first_seen := common.sas_date((string)(liens_unrel_ST_first_seen));

b_mos_liens_unrel_st_fseen_d_1 := map(
    not(truedid)                      => NULL,
    _liens_unrel_st_first_seen = NULL => 1000,
                                         min(if(if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_st_last_seen := common.sas_date((string)(liens_unrel_ST_last_seen));

b_mos_liens_unrel_st_lseen_d_1 := map(
    not(truedid)                     => NULL,
    _liens_unrel_st_last_seen = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999)));

b_liens_unrel_st_total_amt_i_1 := if(not(truedid), NULL, liens_unrel_ST_total_amount);

b_hh_members_ct_d_1 := if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999));

b_property_owners_ct_d_1 := if(not(truedid), NULL, min(if(hh_property_owners_ct = NULL, -NULL, hh_property_owners_ct), 999));

b_hh_age_65_plus_d_1 := if(not(truedid), NULL, min(if(hh_age_65_plus = NULL, -NULL, hh_age_65_plus), 999));

b_hh_age_30_plus_d_1 := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65)))), 999));

b_hh_age_18_plus_d_1 := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999));

b_hh_bankruptcies_i_1 := if(not(truedid), NULL, min(if(hh_bankruptcies = NULL, -NULL, hh_bankruptcies), 999));

_ver_src_ds := (integer)(Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0);

_ver_src_de := (integer)(Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0);

_ver_src_eq := (integer)(Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0);

_ver_src_en := (integer)(Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0);

_ver_src_tn := (integer)(Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0);

_ver_src_tu := (integer)(Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0);

_credit_source_cnt := if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu));

_ver_src_cnt := Models.Common.countw((string)(ver_sources), ',');

_bureauonly := (integer)(_credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

_derog := (integer)(felony_count > 0 OR addrs_prison_history OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2);

_deceased := (integer)(rc_decsflag = '1' OR rc_ssndod != 0 OR (boolean)_ver_src_ds OR (boolean)_ver_src_de);

_ssnpriortodob := (integer)(rc_ssndobflag = '1' OR rc_pwssndobflag = '1');

_inputmiskeys := (integer)(rc_ssnmiskeyflag or rc_addrmiskeyflag or not(add_input_house_number_match));

_multiplessns := (integer)(ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1);

_hh_strikes := sum((integer)(hh_members_w_derog>0), (integer)(hh_criminals>0), (integer)(hh_payday_loan_users>0));

bf_seg_fraudpoint_3_0_1 := map(
    (boolean)addrpop and (nas_summary in [4, 7, 9]) or (boolean)fnamepop and (boolean)lnamepop and (boolean)addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' or (boolean)_deceased or (boolean)_ssnpriortodob or
    ((boolean)_inputmiskeys and ((boolean)_multiplessns or lnames_per_adl_c6 > 1))                                                                                                                               																							=> '1: Stolen/Manip ID  ',
    (boolean)fnamepop and (boolean)lnamepop and (boolean)addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or (boolean)_bureauonly or not((boolean)add_curr_pop)                       	 									=> '2: Synth ID         ',
    (boolean)_derog                                                                                                                                                                                     																											=> '3: Derog            ',
    Inq_count03 > 0 or Inq_count12 >= 4 or (integer)fp_srchfraudsrchcountyr >= 1 or (integer)fp_srchssnsrchcountmo >= 1 or (integer)fp_srchaddrsrchcountmo >= 1 or (integer)fp_srchphonesrchcountmo >= 1                           														=> '4: Recent Activity  ',
    0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70 or
    (hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2))                                                                                           																																=> '5: Vuln Vic/Friendly',
																																																																																																																																 '6: Other            ');

s_nap_phn_verd_d := (integer)(nap_summary_s in [4, 6, 7, 9, 10, 11, 12]);

s_nap_addr_verd_d := (integer)(nap_summary_s in [3, 5, 6, 8, 10, 11, 12]);

s_nap_lname_verd_d := (integer)(nap_summary_s in [2, 5, 7, 8, 9, 11, 12]);

s_nap_nothing_found_i := (integer)(nap_summary_s in [0]);

s_nap_contradictory_i := (integer)(nap_summary_s in [1]);

s_inf_contradictory_i := (integer)(infutor_nap_s in [1]);

s_p88_phn_dst_to_inp_add_i := if(rc_disthphoneaddr_s = 9999, NULL, rc_disthphoneaddr_s);

s_p85_phn_not_issued_i := map(
    not(hphnpop_s)                 => NULL,
    (rc_pwphonezipflag_s in ['4']) => 1,
                                      0);

s_p85_phn_invalid_i := map(
    not(hphnpop_s)                                                        			=> NULL,
    rc_phonevalflag_s = '0' or rc_hphonevalflag_s = '0' or rc_phonetype_s = '5' => 1,
																																									 0);

s_c17_inv_phn_per_adl_i_1 := map(
    not(truedid_s)                                                  => NULL,
    invalid_phones_per_adl_s > 0 or invalid_phones_per_adl_c6_s > 0 => 1,
                                                                       0);

s_l70_add_invalid_i := map(
    not(addrpop_s)                                        => NULL,
    trim(trim(rc_addrvalflag_s, LEFT), LEFT, RIGHT) = 'N' => 1,
                                                             0);

s_l71_add_business_i := map(
    not(add_input_pop_s)                                                       => NULL,
    (trim(trim(add_input_advo_res_or_bus_s, LEFT), LEFT, RIGHT) in ['B', 'D']) => 1,
                                                                                  0);

add_ec1_s := (StringLib.StringToUpperCase(trim(out_addr_status_s, LEFT)))[1..1];

add_ec3_s := (StringLib.StringToUpperCase(trim(out_addr_status_s, LEFT)))[3..3];

add_ec4_s := (StringLib.StringToUpperCase(trim(out_addr_status_s, LEFT)))[4..4];

s_l70_add_standardized_i := map(
    not(addrpop_s)                                             => NULL,
    trim(trim(add_ec1_s, LEFT), LEFT, RIGHT) = 'E'             => 2,
    add_ec1_s = 'S' and (add_ec3_s != '0' or add_ec4_s != '0') => 1,
                                                                  0);

s_c18_inv_add_per_adl_c6_i_1 := if(not(truedid_s), NULL, min(if(invalid_addrs_per_adl_c6_s = NULL, -NULL, invalid_addrs_per_adl_c6_s), 999));

s_f01_inp_addr_address_score_d_1 := if(not(truedid_s and add_input_pop_s) or add_input_address_score_s = 255, NULL, min(if(add_input_address_score_s = NULL, -NULL, add_input_address_score_s), 999));

s_d34_unrel_liens_ct_i_1 := if(not(truedid_s), NULL, min(if(if(max(liens_recent_unreleased_count_s, liens_historical_unreleased_ct_s) = NULL, NULL, sum(if(liens_recent_unreleased_count_s = NULL, 0, liens_recent_unreleased_count_s), if(liens_historical_unreleased_ct_s = NULL, 0, liens_historical_unreleased_ct_s))) = NULL, -NULL, if(max(liens_recent_unreleased_count_s, liens_historical_unreleased_ct_s) = NULL, NULL, sum(if(liens_recent_unreleased_count_s = NULL, 0, liens_recent_unreleased_count_s), if(liens_historical_unreleased_ct_s = NULL, 0, liens_historical_unreleased_ct_s)))), 999));

bureau_adl_eq_fseen_pos_s_1 := Models.Common.findw_cpp(ver_sources_s, 'EQ' , ',' , 'E');

bureau_adl_fseen_eq_s_1 := if(bureau_adl_eq_fseen_pos_s_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_eq_fseen_pos_s_1, ','));

_bureau_adl_fseen_eq_s_1 := common.sas_date((string)(bureau_adl_fseen_eq_s_1));

_src_bureau_adl_fseen_s := min(if(_bureau_adl_fseen_eq_s_1 = NULL, -NULL, _bureau_adl_fseen_eq_s_1), 999999);

s_c21_m_bureau_adl_fs_d_1 := map(
    not(truedid_s)                   => NULL,
    _src_bureau_adl_fseen_s = 999999 => 1000,
                                        min(if(if ((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12)))), 999));

bureau_adl_eq_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'EQ' , ',' , 'E');

bureau_adl_fseen_eq_s := if(bureau_adl_eq_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_eq_fseen_pos_s, ','));

_bureau_adl_fseen_eq_s := common.sas_date((string)(bureau_adl_fseen_eq_s));

bureau_adl_en_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'EN' , ',', 'E');

bureau_adl_fseen_en_s := if(bureau_adl_en_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_en_fseen_pos_s, ','));

_bureau_adl_fseen_en_s := common.sas_date((string)(bureau_adl_fseen_en_s));

bureau_adl_ts_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'TS' , ',', 'E');

bureau_adl_fseen_ts_s := if(bureau_adl_ts_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_ts_fseen_pos_s, ','));

_bureau_adl_fseen_ts_s := common.sas_date((string)(bureau_adl_fseen_ts_s));

bureau_adl_tu_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'TU' , ',', 'E');

bureau_adl_fseen_tu_s := if(bureau_adl_tu_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_tu_fseen_pos_s, ','));

_bureau_adl_fseen_tu_s := common.sas_date((string)(bureau_adl_fseen_tu_s));

bureau_adl_tn_fseen_pos_s := Models.Common.findw_cpp(ver_sources_s, 'TN' , ',', 'E');

bureau_adl_fseen_tn_s := if(bureau_adl_tn_fseen_pos_s = 0, '       0', Models.Common.getw(ver_sources_first_seen_s, bureau_adl_tn_fseen_pos_s, ','));

_bureau_adl_fseen_tn_s := common.sas_date((string)(bureau_adl_fseen_tn_s));

_src_bureau_adl_fseen_notu_s := min(if(_bureau_adl_fseen_en_s = NULL, -NULL, _bureau_adl_fseen_en_s), if(_bureau_adl_fseen_eq_s = NULL, -NULL, _bureau_adl_fseen_eq_s), 999999);

s_m_bureau_adl_fs_notu_d_1 := map(
    not(truedid_s)                        => NULL,
    _src_bureau_adl_fseen_notu_s = 999999 => 1000,
                                             min(if(if ((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu_s) / (365.25 / 12)))), 999));

_header_first_seen_s := common.sas_date((string)(header_first_seen_s));

s_c10_m_hdr_fs_d_1 := map(
    not(truedid_s)              => NULL,
    _header_first_seen_s = NULL => 1000,
                                   min(if(if ((sysdate - _header_first_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen_s) / (365.25 / 12)), roundup((sysdate - _header_first_seen_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen_s) / (365.25 / 12)), roundup((sysdate - _header_first_seen_s) / (365.25 / 12)))), 999));

s_c12_nonderog_recency_i_1 := map(
    not(truedid_s)            				 => NULL,
    (boolean)attr_num_nonderogs90_s    => 3,
    (boolean)attr_num_nonderogs180_s   => 6,
    (boolean)attr_num_nonderogs12_s    => 12,
    (boolean)attr_num_nonderogs24_s    => 24,
    (boolean)attr_num_nonderogs36_s    => 36,
    (boolean)attr_num_nonderogs60_s    => 60,
    attr_num_nonderogs_s >= 1 				 => 99,
																					999);

_in_dob_s := common.sas_date((string)(in_dob_s));

yr_in_dob_s := if(_in_dob_s = NULL, NULL, (sysdate - _in_dob_s) / 365.25);

yr_in_dob_int_s := if (yr_in_dob_s >= 0, roundup(yr_in_dob_s), truncate(yr_in_dob_s));

s_comb_age_d_1 := map(
    yr_in_dob_int_s > 0              => yr_in_dob_int_s,
    inferred_age_s > 0 and truedid_s => inferred_age_s,
                                        NULL);

s_l80_inp_avm_autoval_d := map(
    not(add_input_pop_s)         => NULL,
    add_input_avm_auto_val_s = 0 => NULL,
                                    min(add_input_avm_auto_val_s, 300000));

s_a46_curr_avm_autoval_d := map(
    not(add_curr_pop_s)         => NULL,
    add_curr_avm_auto_val_s = 0 => NULL,
                                   min(add_curr_avm_auto_val_s, 300000));

s_a49_curr_avm_chg_1yr_i := map(
    not(add_curr_pop_s)                                           => NULL,
    add_curr_lres_s < 12                                          => NULL,
    add_curr_avm_auto_val_s > 0 and add_curr_avm_auto_val_2_s > 0 => add_curr_avm_auto_val_s - add_curr_avm_auto_val_2_s,
                                                                     NULL);

s_c13_curr_addr_lres_d_1 := if(not(truedid_s and add_curr_pop_s), NULL, min(if(add_curr_lres_s = NULL, -NULL, add_curr_lres_s), 999));

s_c14_addrs_10yr_i_1 := if(not(truedid_s), NULL, min(if(addrs_10yr_s = NULL, -NULL, addrs_10yr_s), 999));

s_c14_addrs_15yr_i_1 := if(not(truedid_s), NULL, min(if(addrs_15yr_s = NULL, -NULL, addrs_15yr_s), 999));

s_a41_prop_owner_d_1 := map(
    not(truedid_s)                                                                                         => NULL,
    add_input_naprop_s = 4 or add_curr_naprop_s = 4 or add_prev_naprop_s = 4 or property_owned_total_s > 0 => 1,
                                                                                                              0);

s_c20_email_count_i_1 := if(not(truedid_s), NULL, min(if(email_count_s = NULL, -NULL, email_count_s), 999));

s_l79_adls_per_addr_curr_i := if(not(add_curr_pop_s), NULL, min(if(adls_per_addr_curr_s = NULL, -NULL, adls_per_addr_curr_s), 999));

s_l79_adls_per_addr_c6_i := if(not(addrpop_s), NULL, min(if(adls_per_addr_c6_s = NULL, -NULL, adls_per_addr_c6_s), 999));

s_c18_invalid_addrs_per_adl_i_1 := if(not(truedid_s), NULL, min(if(invalid_addrs_per_adl_s = NULL, -NULL, invalid_addrs_per_adl_s), 999));

s_has_pb_record_d_1 := if(pb_number_of_sources_s > 0, 1, 0);

s_a50_pb_average_dollars_d_1 := map(
    not(truedid_s)              => NULL,
    pb_average_dollars_s = NULL => 5000,
                                   min(if(pb_average_dollars_s = NULL, -NULL, pb_average_dollars_s), 5000));

s_a50_pb_total_dollars_d_1 := map(
    not(truedid_s)            => NULL,
    pb_total_dollars_s = NULL => 10001,
                                 min(if(pb_total_dollars_s = NULL, -NULL, pb_total_dollars_s), 10000));

s_a50_pb_total_orders_d_1 := map(
    not(truedid_s)           => NULL,
    pb_total_orders_s = NULL => -1,
                                pb_total_orders_s);

s_pb_order_freq_d_1 := map(
    not(truedid_s)                     => NULL,
    pb_number_of_sources_s = NULL      => NULL,
    pb_average_days_bt_orders_s = NULL => -1,
                                          min(if(pb_average_days_bt_orders_s = NULL, -NULL, pb_average_days_bt_orders_s), 999));

s_i60_inq_count12_i_1 := if(not(truedid_s), NULL, min(if(inq_count12_s = NULL, -NULL, inq_count12_s), 999));

s_i60_credit_seeking_i_1 := if(not(truedid_s), NULL, if(max(min(2, if(inq_auto_count03_s = NULL, -NULL, inq_auto_count03_s)), min(2, if(inq_banking_count03_s = NULL, -NULL, inq_banking_count03_s)), min(2, if(inq_mortgage_count03_s = NULL, -NULL, inq_mortgage_count03_s)), min(2, if(inq_retail_count03_s = NULL, -NULL, inq_retail_count03_s)), min(2, if(inq_communications_count03_s = NULL, -NULL, inq_communications_count03_s))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03_s = NULL, -NULL, inq_auto_count03_s)) = NULL, 0, min(2, if(inq_auto_count03_s = NULL, -NULL, inq_auto_count03_s))), if(min(2, if(inq_banking_count03_s = NULL, -NULL, inq_banking_count03_s)) = NULL, 0, min(2, if(inq_banking_count03_s = NULL, -NULL, inq_banking_count03_s))), if(min(2, if(inq_mortgage_count03_s = NULL, -NULL, inq_mortgage_count03_s)) = NULL, 0, min(2, if(inq_mortgage_count03_s = NULL, -NULL, inq_mortgage_count03_s))), if(min(2, if(inq_retail_count03_s = NULL, -NULL, inq_retail_count03_s)) = NULL, 0, min(2, if(inq_retail_count03_s = NULL, -NULL, inq_retail_count03_s))), if(min(2, if(inq_communications_count03_s = NULL, -NULL, inq_communications_count03_s)) = NULL, 0, min(2, if(inq_communications_count03_s = NULL, -NULL, inq_communications_count03_s))))));

s_i60_inq_recency_d_1 := map(
    not(truedid_s) 					=> NULL,
    (boolean)inq_count01_s  => 1,
    (boolean)inq_count03_s  => 3,
    (boolean)inq_count06_s  => 6,
    (boolean)inq_count12_s  => 12,
    (boolean)inq_count24_s  => 24,
    (boolean)inq_count_s    => 99,
															 999);

s_i61_inq_collection_count12_i_1 := if(not(truedid_s), NULL, min(if(inq_collection_count12_s = NULL, -NULL, inq_collection_count12_s), 999));

s_i60_inq_auto_count12_i_1 := if(not(truedid_s), NULL, min(if(inq_auto_count12_s = NULL, -NULL, inq_auto_count12_s), 999));

s_i60_inq_hiriskcred_count12_i_1 := if(not(truedid_s), NULL, min(if(inq_highRiskCredit_count12_s = NULL, -NULL, inq_highRiskCredit_count12_s), 999));

s_i60_inq_hiriskcred_recency_d_1 := map(
    not(truedid_s)               					=> NULL,
    (boolean)inq_highRiskCredit_count01_s => 1,
    (boolean)inq_highRiskCredit_count03_s => 3,
    (boolean)inq_highRiskCredit_count06_s => 6,
    (boolean)inq_highRiskCredit_count12_s => 12,
    (boolean)inq_highRiskCredit_count24_s => 24,
    (boolean)inq_highRiskCredit_count_s   => 99,
																						 999);

s_i60_inq_retail_recency_d_1 := map(
    not(truedid_s)       					=> NULL,
    (boolean)inq_retail_count01_s => 1,
    (boolean)inq_retail_count03_s => 3,
    (boolean)inq_retail_count06_s => 6,
    (boolean)inq_retail_count12_s => 12,
    (boolean)inq_retail_count24_s => 24,
    (boolean)inq_retail_count_s   => 99,
																		 999);

s_i60_inq_comm_recency_d_1 := map(
    not(truedid_s)               					=> NULL,
    (boolean)inq_communications_count01_s => 1,
    (boolean)inq_communications_count03_s => 3,
    (boolean)inq_communications_count06_s => 6,
    (boolean)inq_communications_count12_s => 12,
    (boolean)inq_communications_count24_s => 24,
    (boolean)inq_communications_count_s   => 99,
																						 999);

s_bus_name_nover_i := if(not(addrpop_s), NULL, (integer)(bus_name_match_s = 1));

s_bus_phone_match_d := if(not(addrpop_s), NULL, (integer)(bus_phone_match_s = 3));

s_util_adl_count_n_1 := if(not(truedid_s), NULL, util_adl_count_s);

s_util_add_input_inf_n_1 := if(contains_i(util_add_input_type_list_s, '1') > 0, 1, 0);

s_util_add_input_conv_n_1 := if(contains_i(util_add_input_type_list_s, '2') > 0, 1, 0);

s_util_add_input_misc_n_1 := if(contains_i(util_add_input_type_list_s, 'Z') > 0, 1, 0);

s_add_input_mobility_index_i := map(
    not(addrpop_s)                 => NULL,
    add_input_occupants_1yr_s <= 0 => NULL,
                                      if(max(add_input_turnover_1yr_in_s, add_input_turnover_1yr_out_s) = NULL, NULL, sum(if(add_input_turnover_1yr_in_s = NULL, 0, add_input_turnover_1yr_in_s), if(add_input_turnover_1yr_out_s = NULL, 0, add_input_turnover_1yr_out_s))) / add_input_occupants_1yr_s);

add_input_nhood_prop_sum_s_3 := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));

s_add_input_nhood_bus_pct_i := map(
    not(addrpop_s)               => NULL,
    add_input_nhood_BUS_ct_s = 0 => NULL,
                                    add_input_nhood_BUS_ct_s / add_input_nhood_prop_sum_s_3);

add_input_nhood_prop_sum_s_2 := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));

s_add_input_nhood_mfd_pct_i := map(
    not(addrpop_s)               => NULL,
    add_input_nhood_MFD_ct_s = 0 => NULL,
                                    add_input_nhood_MFD_ct_s / add_input_nhood_prop_sum_s_2);

add_input_nhood_prop_sum_s_1 := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));

s_add_input_nhood_sfd_pct_d := map(
    not(addrpop_s)               => NULL,
    add_input_nhood_SFD_ct_s = 0 => -1,
                                    add_input_nhood_SFD_ct_s / add_input_nhood_prop_sum_s_1);

add_input_nhood_prop_sum_s := if(max(add_input_nhood_BUS_ct_s, add_input_nhood_SFD_ct_s, add_input_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_input_nhood_BUS_ct_s = NULL, 0, add_input_nhood_BUS_ct_s), if(add_input_nhood_SFD_ct_s = NULL, 0, add_input_nhood_SFD_ct_s), if(add_input_nhood_MFD_ct_s = NULL, 0, add_input_nhood_MFD_ct_s)));

s_add_input_nhood_vac_pct_i := map(
    not(addrpop_s)                 => NULL,
    add_input_nhood_prop_sum_s = 0 => -1,
                                      add_input_nhood_VAC_prop_s / add_input_nhood_prop_sum_s);

s_add_curr_mobility_index_i := map(
    not(add_curr_pop_s)           => NULL,
    add_curr_occupants_1yr_s <= 0 => NULL,
                                     if(max(add_curr_turnover_1yr_in_s, add_curr_turnover_1yr_out_s) = NULL, NULL, sum(if(add_curr_turnover_1yr_in_s = NULL, 0, add_curr_turnover_1yr_in_s), if(add_curr_turnover_1yr_out_s = NULL, 0, add_curr_turnover_1yr_out_s))) / add_curr_occupants_1yr_s);

add_curr_nhood_prop_sum_s_3 := if(max(add_curr_nhood_BUS_ct_s, add_curr_nhood_SFD_ct_s, add_curr_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct_s = NULL, 0, add_curr_nhood_BUS_ct_s), if(add_curr_nhood_SFD_ct_s = NULL, 0, add_curr_nhood_SFD_ct_s), if(add_curr_nhood_MFD_ct_s = NULL, 0, add_curr_nhood_MFD_ct_s)));

s_add_curr_nhood_bus_pct_i := map(
    not(add_curr_pop_s)         => NULL,
    add_curr_nhood_BUS_ct_s = 0 => NULL,
                                   add_curr_nhood_BUS_ct_s / add_curr_nhood_prop_sum_s_3);

add_curr_nhood_prop_sum_s_2 := if(max(add_curr_nhood_BUS_ct_s, add_curr_nhood_SFD_ct_s, add_curr_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct_s = NULL, 0, add_curr_nhood_BUS_ct_s), if(add_curr_nhood_SFD_ct_s = NULL, 0, add_curr_nhood_SFD_ct_s), if(add_curr_nhood_MFD_ct_s = NULL, 0, add_curr_nhood_MFD_ct_s)));

s_add_curr_nhood_mfd_pct_i := map(
    not(add_curr_pop_s)         => NULL,
    add_curr_nhood_MFD_ct_s = 0 => NULL,
                                   add_curr_nhood_MFD_ct_s / add_curr_nhood_prop_sum_s_2);

add_curr_nhood_prop_sum_s_1 := if(max(add_curr_nhood_BUS_ct_s, add_curr_nhood_SFD_ct_s, add_curr_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct_s = NULL, 0, add_curr_nhood_BUS_ct_s), if(add_curr_nhood_SFD_ct_s = NULL, 0, add_curr_nhood_SFD_ct_s), if(add_curr_nhood_MFD_ct_s = NULL, 0, add_curr_nhood_MFD_ct_s)));

s_add_curr_nhood_sfd_pct_d := map(
    not(add_curr_pop_s)         => NULL,
    add_curr_nhood_SFD_ct_s = 0 => -1,
                                   add_curr_nhood_SFD_ct_s / add_curr_nhood_prop_sum_s_1);

add_curr_nhood_prop_sum_s := if(max(add_curr_nhood_BUS_ct_s, add_curr_nhood_SFD_ct_s, add_curr_nhood_MFD_ct_s) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct_s = NULL, 0, add_curr_nhood_BUS_ct_s), if(add_curr_nhood_SFD_ct_s = NULL, 0, add_curr_nhood_SFD_ct_s), if(add_curr_nhood_MFD_ct_s = NULL, 0, add_curr_nhood_MFD_ct_s)));

s_add_curr_nhood_vac_pct_i := map(
    not(add_curr_pop_s)           => NULL,
    add_curr_nhood_prop_sum_s = 0 => -1,
                                     add_curr_nhood_VAC_prop_s / add_curr_nhood_prop_sum_s);

s_recent_disconnects_i := if(not(hphnpop_s), NULL, min(if(recent_disconnects_s = NULL, -NULL, recent_disconnects_s), 999));

s_inq_count24_i_1 := if(not(truedid_s), NULL, min(if(inq_count24_s = NULL, -NULL, inq_count24_s), 999));

s_inq_communications_count24_i_1 := if(not(truedid_s), NULL, min(if(inq_Communications_count24_s = NULL, -NULL, inq_Communications_count24_s), 999));

s_inq_highriskcredit_count24_i_1 := if(not(truedid_s), NULL, min(if(inq_HighRiskCredit_count24_s = NULL, -NULL, inq_HighRiskCredit_count24_s), 999));

s_inq_per_addr_i_1 := if(not(addrpop_s), NULL, min(if(inq_peraddr_s = NULL, -NULL, inq_peraddr_s), 999));

s_inq_adls_per_addr_i_1 := if(not(addrpop_s), NULL, min(if(inq_adlsperaddr_s = NULL, -NULL, inq_adlsperaddr_s), 999));

s_inq_lnames_per_addr_i_1 := if(not(addrpop_s), NULL, min(if(inq_lnamesperaddr_s = NULL, -NULL, inq_lnamesperaddr_s), 999));

s_inq_ssns_per_addr_i_1 := if(not(addrpop_s), NULL, min(if(inq_ssnsperaddr_s = NULL, -NULL, inq_ssnsperaddr_s), 999));

s_inq_per_phone_i_1 := if(not(hphnpop_s), NULL, min(if(inq_perphone_s = NULL, -NULL, inq_perphone_s), 999));

s_inq_adls_per_phone_i_1 := if(not(hphnpop_s), NULL, min(if(inq_adlsperphone_s = NULL, -NULL, inq_adlsperphone_s), 999));

_liens_unrel_ot_last_seen_s := common.sas_date((string)(liens_unrel_OT_last_seen_s));

s_mos_liens_unrel_ot_lseen_d_1 := map(
    not(truedid_s)                     => NULL,
    _liens_unrel_ot_last_seen_s = NULL => 1000,
                                          max(3, min(if(if ((sysdate - _liens_unrel_ot_last_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_ot_last_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen_s) / (365.25 / 12)))), 999)));

_liens_rel_ot_last_seen_s := common.sas_date((string)(liens_rel_OT_last_seen_s));

s_mos_liens_rel_ot_lseen_d_1 := map(
    not(truedid_s)                   => NULL,
    _liens_rel_ot_last_seen_s = NULL => 1000,
                                        max(3, min(if(if ((sysdate - _liens_rel_ot_last_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_rel_ot_last_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen_s) / (365.25 / 12)))), 999)));

s_liens_rel_ot_total_amt_i_1 := if(not(truedid_s), NULL, liens_rel_OT_total_amount_s);

_liens_unrel_sc_first_seen_s := common.sas_date((string)(liens_unrel_SC_first_seen_s));

s_mos_liens_unrel_sc_fseen_d_1 := map(
    not(truedid_s)                      => NULL,
    _liens_unrel_sc_first_seen_s = NULL => 1000,
                                           min(if(if ((sysdate - _liens_unrel_sc_first_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _liens_unrel_sc_first_seen_s) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen_s) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen_s) / (365.25 / 12)))), 999));

_foreclosure_last_date_s := common.sas_date((string)(foreclosure_last_date_s));

s_mos_foreclosure_lseen_d_1 := map(
    not(truedid_s)                  => NULL,
    _foreclosure_last_date_s = NULL => 1000,
                                       max(3, min(if(if ((sysdate - _foreclosure_last_date_s) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date_s) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date_s) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date_s) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date_s) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date_s) / (365.25 / 12)))), 999)));

s_estimated_income_d_1 := if(not(truedid_s), NULL, estimated_income_s);

s_rel_count_i_1 := if(not(truedid_s), NULL, min(if(rel_count_s = NULL, -NULL, rel_count_s), 999));

s_rel_incomeover50_count_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       if(max(rel_incomeover100_count_s, rel_incomeunder100_count_s, rel_incomeunder75_count_s) = NULL, NULL, sum(if(rel_incomeover100_count_s = NULL, 0, rel_incomeover100_count_s), if(rel_incomeunder100_count_s = NULL, 0, rel_incomeunder100_count_s), if(rel_incomeunder75_count_s = NULL, 0, rel_incomeunder75_count_s))));

s_rel_incomeover75_count_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       if(max(rel_incomeover100_count_s, rel_incomeunder100_count_s) = NULL, NULL, sum(if(rel_incomeover100_count_s = NULL, 0, rel_incomeover100_count_s), if(rel_incomeunder100_count_s = NULL, 0, rel_incomeunder100_count_s))));

s_rel_homeover50_count_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       if(max(rel_homeunder100_count_s, rel_homeunder150_count_s, rel_homeunder200_count_s, rel_homeunder300_count_s, rel_homeunder500_count_s, rel_homeover500_count_s) = NULL, NULL, sum(if(rel_homeunder100_count_s = NULL, 0, rel_homeunder100_count_s), if(rel_homeunder150_count_s = NULL, 0, rel_homeunder150_count_s), if(rel_homeunder200_count_s = NULL, 0, rel_homeunder200_count_s), if(rel_homeunder300_count_s = NULL, 0, rel_homeunder300_count_s), if(rel_homeunder500_count_s = NULL, 0, rel_homeunder500_count_s), if(rel_homeover500_count_s = NULL, 0, rel_homeover500_count_s))));

s_rel_homeover300_count_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       if(max(rel_homeunder500_count_s, rel_homeover500_count_s) = NULL, NULL, sum(if(rel_homeunder500_count_s = NULL, 0, rel_homeunder500_count_s), if(rel_homeover500_count_s = NULL, 0, rel_homeover500_count_s))));

s_rel_homeover500_count_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       rel_homeover500_count_s);

s_rel_ageover40_count_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       if(max(rel_ageunder50_count_s, rel_ageunder60_count_s, rel_ageunder70_count_s, rel_ageover70_count_s) = NULL, NULL, sum(if(rel_ageunder50_count_s = NULL, 0, rel_ageunder50_count_s), if(rel_ageunder60_count_s = NULL, 0, rel_ageunder60_count_s), if(rel_ageunder70_count_s = NULL, 0, rel_ageunder70_count_s), if(rel_ageover70_count_s = NULL, 0, rel_ageover70_count_s))));

s_rel_educationover12_count_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       rel_educationover12_count_s);

s_rel_under25miles_cnt_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       rel_within25miles_count_s);

s_rel_under100miles_cnt_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       if(max(rel_within25miles_count_s, rel_within100miles_count_s) = NULL, NULL, sum(if(rel_within25miles_count_s = NULL, 0, rel_within25miles_count_s), if(rel_within100miles_count_s = NULL, 0, rel_within100miles_count_s))));

s_rel_under500miles_cnt_d_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => NULL,
                       if(max(rel_within25miles_count_s, rel_within100miles_count_s, rel_within500miles_count_s) = NULL, NULL, sum(if(rel_within25miles_count_s = NULL, 0, rel_within25miles_count_s), if(rel_within100miles_count_s = NULL, 0, rel_within100miles_count_s), if(rel_within500miles_count_s = NULL, 0, rel_within500miles_count_s))));

s_rel_criminal_count_i_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => -1,
                       min(if(rel_criminal_count_s = NULL, -NULL, rel_criminal_count_s), 999));

s_rel_felony_count_i_1 := map(
    not(truedid_s)  => NULL,
    rel_count_s = 0 => -1,
                       min(if(rel_felony_count_s = NULL, -NULL, rel_felony_count_s), 999));

s_idrisktype_i_1 := if(not(truedid_s) or fp_idrisktype_s = '', NULL, (integer)fp_idrisktype_s);

s_varrisktype_i_1 := map(
    not(truedid_s)          => NULL,
    fp_varrisktype_s = ''   => NULL,
                               (integer)fp_varrisktype_s);

s_varmsrcssnunrelcount_i_1 := if(not(truedid_s), NULL, min(if(fp_varmsrcssnunrelcount_s = '', -NULL, (integer)fp_varmsrcssnunrelcount_s), 999));

s_srchvelocityrisktype_i_1 := map(
    not(truedid_s)                 => NULL,
    fp_srchvelocityrisktype_s = '' => NULL,
																			(integer)fp_srchvelocityrisktype_s);

s_srchunvrfdaddrcount_i_1 := if(not(truedid_s), NULL, min(if(fp_srchunvrfdaddrcount_s = '', -NULL, (integer)fp_srchunvrfdaddrcount_s), 999));

s_assocrisktype_i_1 := map(
    not(truedid_s)            => NULL,
    fp_assocrisktype_s = ''   => NULL,
                                 (integer)fp_assocrisktype_s);

s_assocsuspicousidcount_i_1 := if(not(truedid_s), NULL, min(if(fp_assocsuspicousidcount_s = '', -NULL, (integer)fp_assocsuspicousidcount_s), 999));

s_assoccredbureaucount_i_1 := if(not(truedid_s), NULL, min(if(fp_assoccredbureaucount_s = '', -NULL, (integer)fp_assoccredbureaucount_s), 999));

s_validationrisktype_i_1 := map(
    not(truedid_s)                 => NULL,
    fp_validationrisktype_s = ''   => NULL,
                                      (integer)fp_validationrisktype_s);

s_corrrisktype_i_1 := map(
    not(truedid_s)           => NULL,
    fp_corrrisktype_s = ''   => NULL,
                                (integer)fp_corrrisktype_s);

s_divaddrsuspidcountnew_i_1 := if(not(truedid_s), NULL, min(if(fp_divaddrsuspidcountnew_s = NULL, -NULL, fp_divaddrsuspidcountnew_s), 999));

s_srchcomponentrisktype_i_1 := map(
    not(truedid_s)                    => NULL,
    fp_srchcomponentrisktype_s = ''   => NULL,
                                         (integer)fp_srchcomponentrisktype_s);

s_srchaddrsrchcountmo_i_1 := if(not(truedid_s), NULL, min(if(fp_srchaddrsrchcountmo_s = NULL, -NULL, fp_srchaddrsrchcountmo_s), 999));

s_srchaddrsrchcountwk_i_1 := if(not(truedid_s), NULL, min(if(fp_srchaddrsrchcountwk_s = '', -NULL, (integer)fp_srchaddrsrchcountwk_s), 999));

s_srchphonesrchcountwk_i_1 := if(not(truedid_s), NULL, min(if(fp_srchphonesrchcountwk_s = '', -NULL, (integer)fp_srchphonesrchcountwk_s), 999));

s_addrchangeincomediff_d_1 := map(
    not(truedid_s)                 	=> NULL,
    fp_addrchangeincomediff_s = -1  => NULL,
                                       fp_addrchangeincomediff_s);

s_addrchangevaluediff_d_1 := map(
    not(truedid_s)                => NULL,
    fp_addrchangevaluediff_s = -1 => NULL,
                                     fp_addrchangevaluediff_s);

s_addrchangecrimediff_i_1 := map(
    not(truedid_s)                => NULL,
    fp_addrchangecrimediff_s = -1 => NULL,
                                     fp_addrchangecrimediff_s);

s_addrchangeecontrajindex_d_1 := if(not(truedid_s) or fp_addrchangeecontrajindex_s = '' or fp_addrchangeecontrajindex_s = '-1', NULL, (integer)fp_addrchangeecontrajindex_s);

s_curraddrmedianincome_d_1 := if(not(add_curr_pop_s), NULL, fp_curraddrmedianincome_s);

s_curraddrmedianvalue_d_1 := if(not(add_curr_pop_s), NULL, fp_curraddrmedianvalue_s);

s_curraddrmurderindex_i_1 := if(not(add_curr_pop_s), NULL, (integer)fp_curraddrmurderindex_s);

s_curraddrcartheftindex_i_1 := if(not(add_curr_pop_s), NULL, (integer)fp_curraddrcartheftindex_s);

s_curraddrburglaryindex_i_1 := if(not(add_curr_pop_s), NULL, (integer)fp_curraddrburglaryindex_s);

s_curraddrcrimeindex_i_1 := if(not(add_curr_pop_s), NULL, (integer)fp_curraddrcrimeindex_s);

s_prevaddrageoldest_d_1 := if(not(truedid_s), NULL, min(if(fp_prevaddrageoldest_s = NULL, -NULL, fp_prevaddrageoldest_s), 999));

s_prevaddrlenofres_d_1 := if(not(truedid_s), NULL, min(if(fp_prevaddrlenofres_s = NULL, -NULL, fp_prevaddrlenofres_s), 999));

s_prevaddrstatus_i_1 := map(
    not(truedid_s)            => NULL,
    fp_prevaddrstatus_s = '0' => 1,
    fp_prevaddrstatus_s = 'U' => 2,
    fp_prevaddrstatus_s = 'R' => 3,
                                 NULL);

s_prevaddrmedianvalue_d_1 := if(not(truedid_s), NULL, (integer)fp_prevaddrmedianvalue_s);

s_prevaddrmurderindex_i_1 := if(not(truedid_s), NULL, (integer)fp_prevaddrmurderindex_s);

s_prevaddrcartheftindex_i_1 := if(not(truedid_s), NULL, (integer)fp_prevaddrcartheftindex_s);

s_fp_prevaddrburglaryindex_i_1 := if(not(truedid_s), NULL, (integer)fp_prevaddrburglaryindex_s);

s_fp_prevaddrcrimeindex_i_1 := if(not(truedid_s), NULL, (integer)fp_prevaddrcrimeindex_s);

s_c12_source_profile_d_1 := if(not(truedid_s), NULL, hdr_source_profile_s);

s_c12_source_profile_index_d_1 := if(not(truedid_s), NULL, hdr_source_profile_index_s);

s_e57_br_source_count_d_1 := if(not(truedid_s), NULL, br_source_count_s);

s_i60_inq_prepaidcards_recency_d_1 := map(
    not(truedid_s)             					=> NULL,
    (boolean)inq_PrepaidCards_count01_s => 1,
    (boolean)inq_PrepaidCards_count03_s => 3,
    (boolean)inq_PrepaidCards_count06_s => 6,
    (boolean)inq_PrepaidCards_count12_s => 12,
    (boolean)inq_PrepaidCards_count24_s => 24,
    (boolean)inq_PrepaidCards_count_s   => 99,
																					 999);

s_phone_ver_insurance_d_1 := if(not(truedid_s) or phone_ver_insurance_s = '-1', NULL, (integer)phone_ver_insurance_s);

s_phone_ver_experian_d_1 := if(not(truedid_s) or phone_ver_experian_s = '-1', NULL, (integer)phone_ver_experian_s);

s_phones_per_addr_c6_i := if(not(addrpop_s), NULL, min(if(phones_per_addr_c6_s = NULL, -NULL, phones_per_addr_c6_s), 999));

s_c20_email_verification_d_1 := if(not(emailpop_s), sNULL, email_verification_s);  //cheated?
// s_c20_email_verification_d_1  :=  b_C20_email_verification_d;

s_liens_unrel_st_total_amt_i_1 := if(not(truedid_s), NULL, liens_unrel_ST_total_amount_s);

s_hh_age_30_plus_d_1 := if(not(truedid_s), NULL, min(if(if(max(hh_age_65_plus_s, hh_age_30_to_65_s) = NULL, NULL, sum(if(hh_age_65_plus_s = NULL, 0, hh_age_65_plus_s), if(hh_age_30_to_65_s = NULL, 0, hh_age_30_to_65_s))) = NULL, -NULL, if(max(hh_age_65_plus_s, hh_age_30_to_65_s) = NULL, NULL, sum(if(hh_age_65_plus_s = NULL, 0, hh_age_65_plus_s), if(hh_age_30_to_65_s = NULL, 0, hh_age_30_to_65_s)))), 999));

s_hh_collections_ct_i_1 := if(not(truedid_s), NULL, min(if(hh_collections_ct_s = NULL, -NULL, hh_collections_ct_s), 999));

_ver_src_ds_s := Models.Common.findw_cpp(ver_sources_s, 'DS' , ',', '') > 0;

_ver_src_de_s := Models.Common.findw_cpp(ver_sources_s, 'DE' , ',', '') > 0;

_ver_src_eq_s := Models.Common.findw_cpp(ver_sources_s, 'EQ' , ',', '') > 0;

_ver_src_en_s := Models.Common.findw_cpp(ver_sources_s, 'EN' , ',', '') > 0;

_ver_src_tn_s := Models.Common.findw_cpp(ver_sources_s, 'TN' , ',', '') > 0;

_ver_src_tu_s := Models.Common.findw_cpp(ver_sources_s, 'TU' , ',', '') > 0;

_credit_source_cnt_s := if(max((integer)_ver_src_eq_s, (integer)_ver_src_en_s, (integer)_ver_src_tn_s, (integer)_ver_src_tu_s) = NULL, NULL, sum((integer)_ver_src_eq_s, (integer)_ver_src_en_s, (integer)_ver_src_tn_s, (integer)_ver_src_tu_s));

_ver_src_cnt_s := Models.Common.countw((string)(ver_sources_s), ',');

_bureauonly_s := _credit_source_cnt_s > 0 AND _credit_source_cnt_s = _ver_src_cnt_s AND (StringLib.StringToUpperCase(nap_type_s) = 'U' or (nap_summary_s in [0, 1, 2, 3, 4, 6]));

_derog_s := felony_count_s > 0 OR addrs_prison_history_s OR attr_num_unrel_liens60_s > 0 OR attr_eviction_count_s > 0 OR stl_inq_count_s > 0 OR inq_highriskcredit_count12_s > 0 OR inq_collection_count12_s >= 2;

_deceased_s := rc_decsflag_s = '1' OR rc_ssndod_s != 0 OR _ver_src_ds_s OR _ver_src_de_s;

_ssnpriortodob_s := rc_ssndobflag_s = '1' OR rc_pwssndobflag_s = '1';

_inputmiskeys_s := rc_ssnmiskeyflag_s or rc_addrmiskeyflag_s or not(add_input_house_number_match_s);

_multiplessns_s := ssns_per_adl_s >= 2 OR ssns_per_adl_c6_s >= 1 OR invalid_ssns_per_adl_s >= 1;

_hh_strikes_s := sum((integer)(hh_members_w_derog_s>0), (integer)(hh_criminals_s>0), (integer)(hh_payday_loan_users_s>0));

sf_seg_fraudpoint_3_0_1 := map(
    addrpop_s and (nas_summary_s in [4, 7, 9]) or fnamepop_s and lnamepop_s and addrpop_s and 1 <= nas_summary_s AND nas_summary_s <= 9 and inq_count03_s > 0 and ssnlength_s = '9' or _deceased_s or _ssnpriortodob_s or
    (_inputmiskeys_s and (_multiplessns_s or lnames_per_adl_c6_s > 1))                                                                                                                                               		=> '1: Stolen/Manip ID  ',
    fnamepop_s and lnamepop_s and addrpop_s and ssnlength_s = '9' and hphnpop_s and nap_summary_s <= 4 and nas_summary_s <= 4 or _ver_src_cnt_s = 0 or _bureauonly_s or not(add_curr_pop_s)                             => '2: Synth ID         ',
    _derog_s                                                                                                                                                                                                         		=> '3: Derog            ',
    Inq_count03_s > 0 or Inq_count12_s >= 4 or (integer)fp_srchfraudsrchcountyr_s >= 1 or (integer)fp_srchssnsrchcountmo_s >= 1 or (integer)fp_srchaddrsrchcountmo_s >= 1 or (integer)fp_srchphonesrchcountmo_s >= 1    => '4: Recent Activity  ',
    0 < inferred_age_s AND inferred_age_s <= 17 or inferred_age_s >= 70 or
    (hh_members_ct_s > 1 and (hh_payday_loan_users_s > 0 or _hh_strikes_s >= 2 or rel_felony_count_s >= 2))                                                                                                          		=> '5: Vuln Vic/Friendly',
																																																																																																													 '6: Other            ');

b_rel_incomeover75_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_incomeover75_count_d_1);

b_c14_addrs_5yr_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c14_addrs_5yr_i_1);

b_rel_incomeover25_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_incomeover25_count_d_1);

b_property_owners_ct_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_property_owners_ct_d_1);

b_inq_per_phone_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_per_phone_i_1);

b_pb_order_freq_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_pb_order_freq_d_1);

b_c20_email_verification_d := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_c20_email_verification_d_1);

b_c14_addrs_10yr_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c14_addrs_10yr_i_1);

b_varmsrcssnunrelcount_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_varmsrcssnunrelcount_i_1);

b_hh_age_30_plus_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_hh_age_30_plus_d_1);

b_rel_felony_count_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_felony_count_i_1);

b_c21_m_bureau_adl_fs_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c21_m_bureau_adl_fs_d_1);

b_inq_lnames_per_addr_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_lnames_per_addr_i_1);

b_i60_inq_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_i60_inq_recency_d_1);

b_divaddrsuspidcountnew_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_divaddrsuspidcountnew_i_1);

b_m_bureau_adl_fs_all_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_m_bureau_adl_fs_all_d_1);

b_c12_source_profile_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c12_source_profile_d_1);

b_hh_bankruptcies_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_hh_bankruptcies_i_1);

b_componentcharrisktype_i := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_componentcharrisktype_i_1);

b_inq_ssns_per_addr_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_ssns_per_addr_i_1);

b_fp_prevaddrcrimeindex_i := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_fp_prevaddrcrimeindex_i_1);

b_inq_per_addr_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_per_addr_i_1);

b_inq_collection_count24_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_collection_count24_i_1);

b_curraddractivephonelist_d := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_curraddractivephonelist_d_1);

b_rel_count_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_count_i_1);

b_rel_incomeover50_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_incomeover50_count_d_1);

b_srchaddrsrchcountmo_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_srchaddrsrchcountmo_i_1);

b_e57_br_source_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_e57_br_source_count_d_1);

b_addrchangeecontrajindex_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_addrchangeecontrajindex_d_1);

b_rel_educationover12_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_educationover12_count_d_1);

b_comb_age_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_comb_age_d_1);

b_addrchangecrimediff_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_addrchangecrimediff_i_1);

b_prevaddrageoldest_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_prevaddrageoldest_d_1);

b_estimated_income_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_estimated_income_d_1);

b_m_bureau_adl_fs_notu_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_m_bureau_adl_fs_notu_d_1);

b_rel_ageover30_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_ageover30_count_d_1);

b_i60_inq_retpymt_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_i60_inq_retpymt_recency_d_1);

b_curraddrburglaryindex_i := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_curraddrburglaryindex_i_1);

b_curraddrcrimeindex_i := (integer)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_curraddrcrimeindex_i_1);

b_varrisktype_i := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_varrisktype_i_1);


b_sourcerisktype_i := (integer)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_sourcerisktype_i_1);


b_inq_adls_per_addr_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_adls_per_addr_i_1);

b_rel_under100miles_cnt_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_under100miles_cnt_d_1);

b_rel_homeover500_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_homeover500_count_d_1);

b_vardobcountnew_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_vardobcountnew_i_1);

b_mos_liens_rel_ot_lseen_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_mos_liens_rel_ot_lseen_d_1);

b_prevaddrmedianvalue_d := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_prevaddrmedianvalue_d_1);

b_prevaddrmurderindex_i := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_prevaddrmurderindex_i_1);

b_c23_inp_addr_occ_index_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c23_inp_addr_occ_index_d_1);

b_liens_unrel_st_total_amt_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_liens_unrel_st_total_amt_i_1);

b_curraddrmurderindex_i := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_curraddrmurderindex_i_1);

b_c13_curr_addr_lres_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c13_curr_addr_lres_d_1);

b_f04_curr_add_occ_index_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_f04_curr_add_occ_index_d_1);

b_a50_pb_total_dollars_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_a50_pb_total_dollars_d_1);

b_hh_members_ct_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_hh_members_ct_d_1);

b_curraddrmedianvalue_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_curraddrmedianvalue_d_1);

b_mos_liens_unrel_st_lseen_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_mos_liens_unrel_st_lseen_d_1);

b_srchunvrfdphonecount_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_srchunvrfdphonecount_i_1);

b_rel_incomeover100_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_incomeover100_count_d_1);

b_corrphonelastnamecount_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_corrphonelastnamecount_d_1);

b_mos_liens_unrel_ot_fseen_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_mos_liens_unrel_ot_fseen_d_1);

b_fp_prevaddrburglaryindex_i := (integer)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_fp_prevaddrburglaryindex_i_1);

b_varmsrcssncount_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_varmsrcssncount_i_1);

b_c13_max_lres_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c13_max_lres_d_1);

b_phone_ver_insurance_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_phone_ver_insurance_d_1);

b_crim_rel_under100miles_cnt_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_crim_rel_under100miles_cnt_i_1);

b_i60_inq_retail_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_i60_inq_retail_recency_d_1);

b_inq_count24_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_count24_i_1);

b_addrchangeincomediff_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_addrchangeincomediff_d_1);

b_i60_inq_mortgage_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_i60_inq_mortgage_recency_d_1);

b_d31_bk_disposed_hist_count_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_d31_bk_disposed_hist_count_i_1);

btst_relatives_lvl_d_1 := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, btst_relatives_lvl_d_2);

b_inq_adls_per_phone_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_adls_per_phone_i_1);

b_a50_pb_total_orders_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_a50_pb_total_orders_d_1);

b_prevaddrmedianincome_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_prevaddrmedianincome_d_1);

b_hh_age_18_plus_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_hh_age_18_plus_d_1);

b_srchcountwk_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_srchcountwk_i_1);

b_f03_address_match_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_f03_address_match_d_1);

b_util_add_input_conv_n := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_util_add_input_conv_n_1);

b_rel_ageover40_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_ageover40_count_d_1);

b_i60_inq_count12_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_i60_inq_count12_i_1);

b_f01_inp_addr_address_score_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_f01_inp_addr_address_score_d_1);

b_c20_email_count_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c20_email_count_i_1);

b_c14_addr_stability_v2_d := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_c14_addr_stability_v2_d_1);

b_addrchangevaluediff_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_addrchangevaluediff_d_1);

b_c14_addrs_15yr_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c14_addrs_15yr_i_1);

b_inq_retail_count_week_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_retail_count_week_i_1);

b_inq_retail_count24_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_retail_count24_i_1);

b_i61_inq_collection_count12_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_i61_inq_collection_count12_i_1);

b_srchaddrsrchcountwk_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_srchaddrsrchcountwk_i_1);

b_srchvelocityrisktype_i := (integer)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_srchvelocityrisktype_i_1);

b_util_add_input_inf_n := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_util_add_input_inf_n_1);

b_liens_rel_ot_total_amt_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_liens_rel_ot_total_amt_i_1);

b_inq_other_count24_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_other_count24_i_1);

b_adl_per_email_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_adl_per_email_i_1);

b_rel_homeover50_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_homeover50_count_d_1);

b_a50_pb_average_dollars_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_a50_pb_average_dollars_d_1);

b_divrisktype_i := (real)if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, b_divrisktype_i_1);

b_phone_ver_experian_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_phone_ver_experian_d_1);

b_c18_invalid_addrs_per_adl_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c18_invalid_addrs_per_adl_i_1);

b_c10_m_hdr_fs_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_c10_m_hdr_fs_d_1);

b_i60_inq_auto_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_i60_inq_auto_recency_d_1);

b_prevaddrlenofres_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_prevaddrlenofres_d_1);

btst_firstscore_d_1 := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, btst_firstscore_d_2);

btst_lastscore_d_1 := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, btst_lastscore_d_2);

b_rel_homeover300_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_rel_homeover300_count_d_1);

b_hh_age_65_plus_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_hh_age_65_plus_d_1);

b_curraddrmedianincome_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_curraddrmedianincome_d_1);

b_mos_liens_unrel_st_fseen_d := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_mos_liens_unrel_st_fseen_d_1);

b_divsrchaddrsuspidcount_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_divsrchaddrsuspidcount_i_1);

btst_email_last_score_d_1 := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, sNULL, btst_email_last_score_d_2);

b_srchunvrfdssncount_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_srchunvrfdssncount_i_1);

b_inq_highriskcredit_count24_i := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, b_inq_highriskcredit_count24_i_1);

s_srchphonesrchcountwk_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_srchphonesrchcountwk_i_1);

s_curraddrmedianincome_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_curraddrmedianincome_d_1);

s_phone_ver_experian_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_phone_ver_experian_d_1);

s_liens_unrel_st_total_amt_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_liens_unrel_st_total_amt_i_1);

s_prevaddrcartheftindex_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_prevaddrcartheftindex_i_1);

s_prevaddrmurderindex_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_prevaddrmurderindex_i_1);

s_rel_homeover50_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_homeover50_count_d_1);

s_c10_m_hdr_fs_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c10_m_hdr_fs_d_1);

s_curraddrmurderindex_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_curraddrmurderindex_i_1);

s_i60_inq_comm_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i60_inq_comm_recency_d_1);

s_c14_addrs_15yr_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c14_addrs_15yr_i_1);

s_c12_source_profile_index_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c12_source_profile_index_d_1);

s_c12_source_profile_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c12_source_profile_d_1);

s_srchvelocityrisktype_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_srchvelocityrisktype_i_1);

s_inq_per_phone_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_inq_per_phone_i_1);

s_fp_prevaddrburglaryindex_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_fp_prevaddrburglaryindex_i_1);

btst_email_last_score_d := (integer)if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, sNULL, btst_email_last_score_d_1);

s_inq_count24_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_inq_count24_i_1);

s_a50_pb_total_orders_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_a50_pb_total_orders_d_1);

s_rel_ageover40_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_ageover40_count_d_1);

s_curraddrcrimeindex_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_curraddrcrimeindex_i_1);

s_i60_inq_hiriskcred_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i60_inq_hiriskcred_recency_d_1);

btst_firstscore_d := (integer)if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, sNULL, btst_firstscore_d_1);

s_prevaddrmedianvalue_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_prevaddrmedianvalue_d_1);

btst_lastscore_d := (integer)if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, sNULL, btst_lastscore_d_1);

s_m_bureau_adl_fs_notu_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_m_bureau_adl_fs_notu_d_1);

s_rel_homeover300_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_homeover300_count_d_1);

s_hh_age_30_plus_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_hh_age_30_plus_d_1);

s_inq_per_addr_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_inq_per_addr_i_1);

s_prevaddrageoldest_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_prevaddrageoldest_d_1);

s_divaddrsuspidcountnew_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_divaddrsuspidcountnew_i_1);

s_e57_br_source_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_e57_br_source_count_d_1);

s_i60_credit_seeking_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i60_credit_seeking_i_1);

s_addrchangecrimediff_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_addrchangecrimediff_i_1);

s_addrchangeecontrajindex_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_addrchangeecontrajindex_d_1);
		
s_assocrisktype_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_assocrisktype_i_1);

s_inq_highriskcredit_count24_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_inq_highriskcredit_count24_i_1);

s_c20_email_count_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c20_email_count_i_1);

s_rel_under25miles_cnt_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_under25miles_cnt_d_1);

s_inq_adls_per_phone_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_inq_adls_per_phone_i_1);

s_i60_inq_auto_count12_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i60_inq_auto_count12_i_1);

s_c12_nonderog_recency_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c12_nonderog_recency_i_1);

s_comb_age_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_comb_age_d_1);

s_varrisktype_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_varrisktype_i_1);

s_curraddrmedianvalue_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_curraddrmedianvalue_d_1);

s_srchcomponentrisktype_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_srchcomponentrisktype_i_1);

s_mos_liens_rel_ot_lseen_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_mos_liens_rel_ot_lseen_d_1);

s_i61_inq_collection_count12_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i61_inq_collection_count12_i_1);

btst_relatives_lvl_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, sNULL, btst_relatives_lvl_d_1);

s_curraddrcartheftindex_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_curraddrcartheftindex_i_1);

s_has_pb_record_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_has_pb_record_d_1);

s_c18_inv_add_per_adl_c6_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c18_inv_add_per_adl_c6_i_1);

s_assocsuspicousidcount_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_assocsuspicousidcount_i_1);

s_estimated_income_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_estimated_income_d_1);

s_rel_under500miles_cnt_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_under500miles_cnt_d_1);

s_c18_invalid_addrs_per_adl_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c18_invalid_addrs_per_adl_i_1);

s_inq_adls_per_addr_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_inq_adls_per_addr_i_1);

s_f01_inp_addr_address_score_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_f01_inp_addr_address_score_d_1);

s_prevaddrlenofres_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_prevaddrlenofres_d_1);

s_c14_addrs_10yr_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c14_addrs_10yr_i_1);

s_validationrisktype_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_validationrisktype_i_1);

s_liens_rel_ot_total_amt_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_liens_rel_ot_total_amt_i_1);

s_srchaddrsrchcountwk_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_srchaddrsrchcountwk_i_1);

s_inq_communications_count24_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_inq_communications_count24_i_1);

s_varmsrcssnunrelcount_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_varmsrcssnunrelcount_i_1);

s_i60_inq_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i60_inq_recency_d_1);

s_rel_criminal_count_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_criminal_count_i_1);

s_addrchangeincomediff_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_addrchangeincomediff_d_1);
// s_addrchangeincomediff_d := s_addrchangeincomediff_d_1;

s_srchunvrfdaddrcount_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_srchunvrfdaddrcount_i_1);

s_rel_educationover12_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_educationover12_count_d_1);

s_inq_lnames_per_addr_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_inq_lnames_per_addr_i_1);

s_util_add_input_misc_n := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_util_add_input_misc_n_1);

s_util_add_input_inf_n := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_util_add_input_inf_n_1);

// s_c20_email_verification_d := (integer)if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, sNULL, s_c20_email_verification_d_1);
s_c20_email_verification_d := b_C20_email_verification_d;

s_rel_count_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_count_i_1);

s_assoccredbureaucount_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_assoccredbureaucount_i_1);

s_pb_order_freq_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_pb_order_freq_d_1);

s_fp_prevaddrcrimeindex_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_fp_prevaddrcrimeindex_i_1);

s_c17_inv_phn_per_adl_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c17_inv_phn_per_adl_i_1);

s_rel_incomeover75_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_incomeover75_count_d_1);

s_i60_inq_prepaidcards_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i60_inq_prepaidcards_recency_d_1);

s_rel_incomeover50_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_incomeover50_count_d_1);

s_util_add_input_conv_n := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_util_add_input_conv_n_1);

s_i60_inq_retail_recency_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i60_inq_retail_recency_d_1);

s_mos_foreclosure_lseen_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_mos_foreclosure_lseen_d_1);

sf_seg_fraudpoint_3_0 := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, '', sf_seg_fraudpoint_3_0_1);

s_d34_unrel_liens_ct_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_d34_unrel_liens_ct_i_1);

s_i60_inq_hiriskcred_count12_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i60_inq_hiriskcred_count12_i_1);

s_a41_prop_owner_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_a41_prop_owner_d_1);

s_rel_homeover500_count_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_homeover500_count_d_1);

s_corrrisktype_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_corrrisktype_i_1);

s_util_adl_count_n := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_util_adl_count_n_1);

s_mos_liens_unrel_ot_lseen_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_mos_liens_unrel_ot_lseen_d_1);

s_inq_ssns_per_addr_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_inq_ssns_per_addr_i_1);

s_idrisktype_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_idrisktype_i_1);

s_mos_liens_unrel_sc_fseen_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_mos_liens_unrel_sc_fseen_d_1);

s_i60_inq_count12_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_i60_inq_count12_i_1);

s_hh_collections_ct_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_hh_collections_ct_i_1);

s_curraddrburglaryindex_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_curraddrburglaryindex_i_1);

s_c21_m_bureau_adl_fs_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c21_m_bureau_adl_fs_d_1);

s_addrchangevaluediff_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_addrchangevaluediff_d_1);

s_a50_pb_total_dollars_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_a50_pb_total_dollars_d_1);

s_phone_ver_insurance_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_phone_ver_insurance_d_1);

s_rel_under100miles_cnt_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_under100miles_cnt_d_1);

s_rel_felony_count_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_rel_felony_count_i_1);

s_prevaddrstatus_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_prevaddrstatus_i_1);

s_srchaddrsrchcountmo_i := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_srchaddrsrchcountmo_i_1);

s_a50_pb_average_dollars_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_a50_pb_average_dollars_d_1);

s_c13_curr_addr_lres_d := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, s_c13_curr_addr_lres_d_1);

/* ================================================================================================================
   ============================= BLANK OUT =========================================================================
   ================================================================================================================ */


BT_cen_blue_col := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_blue_col_RAW);
BT_cen_business := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_business_RAW);
BT_cen_civ_emp := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_civ_emp_RAW);
BT_cen_easiqlife := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_easiqlife_RAW);
BT_cen_families := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_families_RAW);
BT_cen_health := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_health_RAW);
BT_cen_high_ed := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_high_ed_RAW);
BT_cen_high_hval := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_high_hval_RAW);
BT_cen_incollege := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_incollege_RAW);
BT_cen_lar_fam := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_lar_fam_RAW);
BT_cen_low_hval := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_low_hval_RAW);
BT_cen_med_hval := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_med_hval_RAW);
BT_cen_med_rent := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_med_rent_RAW);
BT_cen_no_move := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_no_move_RAW);
BT_cen_ownocc_p := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_ownocc_p_RAW);
BT_cen_pop_0_5_p := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_pop_0_5_p_RAW);
BT_cen_rental := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_rental_RAW);
BT_cen_retired2 := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_retired2_RAW);
BT_cen_span_lang := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_span_lang_RAW);
BT_cen_totcrime := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_totcrime_RAW);
BT_cen_trailer := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_trailer_RAW);
BT_cen_unemp := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_unemp_RAW);
BT_cen_urban_p := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_urban_p_RAW);
BT_cen_vacant_p := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_vacant_p_RAW);
BT_cen_very_rich := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, NULL, BT_cen_very_rich_RAW);

bf_seg_fraudpoint_3_0 := if(contains_i(StringLib.StringToUpperCase(in_fname), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname), 'RECEIVABLE') > 0, ' ', bf_seg_fraudpoint_3_0_1);

ST_cen_blue_col := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_blue_col_RAW);
ST_cen_business := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_business_RAW);
ST_cen_civ_emp := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_civ_emp_RAW);
ST_cen_easiqlife := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_easiqlife_RAW);
ST_cen_families := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_families_RAW);
ST_cen_health := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_health_RAW);
ST_cen_high_ed := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_high_ed_RAW);
ST_cen_high_hval := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_high_hval_RAW);
ST_cen_incollege := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_incollege_RAW);
ST_cen_lar_fam := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_lar_fam_RAW);
ST_cen_low_hval := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_low_hval_RAW);
ST_cen_med_hhinc := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_med_hhinc_RAW);
ST_cen_med_hval := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_med_hval_RAW);
ST_cen_med_rent := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_med_rent_RAW);
ST_cen_mil_emp := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_mil_emp_RAW);
ST_cen_no_move := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_no_move_RAW);
ST_cen_ownocc_p := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_ownocc_p_RAW);
ST_cen_pop_0_5_p := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_pop_0_5_p_RAW);
ST_cen_rental := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_rental_RAW);
ST_cen_retired2 := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_retired2_RAW);
ST_cen_span_lang := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_span_lang_RAW);
ST_cen_totcrime := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_totcrime_RAW);
ST_cen_trailer := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_trailer_RAW);
ST_cen_unemp := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_unemp_RAW);
ST_cen_urban_p := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_urban_p_RAW);
ST_cen_vacant_p := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_vacant_p_RAW);
ST_cen_very_rich := if(contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCOUNT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'ACCT') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'PAYABLE') > 0 or contains_i(StringLib.StringToUpperCase(in_fname_s), 'RECEIVABLE') > 0, NULL, ST_cen_very_rich_RAW);


//--------------------------------------------------------------------------------------------------
//  NOTE:  This is the beginning of the tree code.  You probably want to replace code from here 
//         until the end of the tree code with the tree code that was generated by R.
//--------------------------------------------------------------------------------------------------

   final_score_0 :=  -4.2402632260;

// Tree: 1 
final_score_1 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0216816171,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 0.0690416281,
      (pf_ship_method in ['Next Day']) => 
         map(
         (NULL < s_add_input_nhood_VAC_pct_i and s_add_input_nhood_VAC_pct_i <= 0.08493709225) => 0.1797331261,
         (s_add_input_nhood_VAC_pct_i > 0.08493709225) => 0.8710930745,
         (s_add_input_nhood_VAC_pct_i = NULL) => 0.3333686702, 0.3333686702),
      (pf_ship_method = '') => 0.0934370117, 0.0934370117),
   (final_model_segment = '') => 0.0004941055, 0.0004941055),
(s_inq_ssns_per_addr_i > 5.5) => 1.0439330616,
(s_inq_ssns_per_addr_i = NULL) => -0.0507201900, 0.0022823910);

// Tree: 2 
final_score_2 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0212375789,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (pf_ship_method in ['2nd Day','3rd Day','Ground']) => 0.0262430066,
      (pf_ship_method in ['Next Day','Other']) => 
         map(
         (NULL < (real)BT_cen_med_hval and (real)BT_cen_med_hval <= 320766.5) => 0.4150491247,
         ((real)BT_cen_med_hval > 320766.5) => 0.0627471830,
         ((real)BT_cen_med_hval = NULL) => 0.2667738967, 0.2667738967),
      (pf_ship_method = '') => 0.0465873582, 0.0465873582),
   (final_model_segment = '') => -0.0047827270, -0.0047827270),
(s_inq_ssns_per_addr_i > 5.5) => 0.3813220187,
(s_inq_ssns_per_addr_i = NULL) => -0.0506845727, -0.0054369368);

// Tree: 3 
final_score_3 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0216546663,
   (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 0.0382208594,
      (pf_ship_method in ['Next Day']) => 0.1918970787,
      (pf_ship_method = '') => 0.0508778262, 0.0508778262),
   (final_model_segment = '') => -0.0084648211, -0.0084648211),
(s_inq_ssns_per_addr_i > 3.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.1249153132,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 0.6635723685,
   (final_model_segment = '') => 0.2666671699, 0.2666671699),
(s_inq_ssns_per_addr_i = NULL) => -0.0506507401, -0.0070739495);

// Tree: 4 
final_score_4 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0219210226,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < b_phone_ver_experian_d and b_phone_ver_experian_d <= 0.5) => 0.1245301199,
      (b_phone_ver_experian_d > 0.5) => -0.0093260061,
      (b_phone_ver_experian_d = NULL) => 0.0549466491, 0.0445149127),
   (final_model_segment = '') => -0.0062143420, -0.0062143420),
(s_inq_ssns_per_addr_i > 3.5) => 
   map(
   (NULL < s_estimated_income_d and s_estimated_income_d <= 38500) => 0.3604002840,
   (s_estimated_income_d > 38500) => 0.0222631878,
   (s_estimated_income_d = NULL) => 0.1533240778, 0.1533240778),
(s_inq_ssns_per_addr_i = NULL) => -0.0506186004, -0.0065333643);

// Tree: 5 
final_score_5 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0235018865,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (pf_ship_method in ['2nd Day','3rd Day','Ground']) => 0.0352469049,
      (pf_ship_method in ['Next Day','Other']) => 0.1554994965,
      (pf_ship_method = '') => 0.0454528444, 0.0454528444),
   (final_model_segment = '') => -0.0103304106, -0.0103304106),
(s_inq_ssns_per_addr_i > 3.5) => 
   map(
   (NULL < s_estimated_income_d and s_estimated_income_d <= 38500) => 0.2453577841,
   (s_estimated_income_d > 38500) => 0.0163478076,
   (s_estimated_income_d = NULL) => 0.1075939701, 0.1075939701),
(s_inq_ssns_per_addr_i = NULL) => -0.0505880670, -0.0108621033);

// Tree: 6 
final_score_6 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0194520839,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0399085165,
   (final_model_segment = '') => -0.0095097432, -0.0095097432),
(s_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 35.5) => 
      map(
      (pf_avs_result in ['Addr Only','Error/Inval','Full Match','Not Supported','Zip Only']) => 0.0072033326,
      (pf_avs_result in ['International','No Match','Unavailable']) => 0.2779652181,
      (pf_avs_result = '') => 0.0522031952, 0.0522031952),
   (btst_distaddraddr2_i > 35.5) => 0.4241277733,
   (btst_distaddraddr2_i = NULL) => 0.0989227851, 0.0989227851),
(s_inq_ssns_per_addr_i = NULL) => -0.0505590578, -0.0084901092);

// Tree: 7 
final_score_7 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0184382318,
(final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
   map(
   (NULL < b_phone_ver_experian_d and b_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 60.45) => 
         map(
         (NULL < (real)BT_cen_civ_emp and (real)BT_cen_civ_emp <= 59.95) => 0.1564151671,
         ((real)BT_cen_civ_emp > 59.95) => 0.5144356675,
         ((real)BT_cen_civ_emp = NULL) => 0.2377123987, 0.2377123987),
      ((real)ST_cen_civ_emp > 60.45) => 0.0404117331,
      ((real)ST_cen_civ_emp = NULL) => 0.1033391041, 0.1033391041),
   (b_phone_ver_experian_d > 0.5) => -0.0076355140,
   (b_phone_ver_experian_d = NULL) => 0.0602922662, 0.0424595457),
(final_model_segment = '') => -0.0078800000, -0.0078800000);

// Tree: 8 
final_score_8 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0169775740,
(final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
      map(
      (NULL < b_phone_ver_experian_d and b_phone_ver_experian_d <= 0.5) => 
         map(
         (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 60.45) => 0.2277261783,
         ((real)ST_cen_civ_emp > 60.45) => 0.0429064692,
         ((real)ST_cen_civ_emp = NULL) => 0.1033097856, 0.1033097856),
      (b_phone_ver_experian_d > 0.5) => -0.0059307864,
      (b_phone_ver_experian_d = NULL) => 0.0488412421, 0.0405068512),
   (s_inq_ssns_per_addr_i > 3.5) => 0.1324395991,
   (s_inq_ssns_per_addr_i = NULL) => 0.0419953996, 0.0419953996),
(final_model_segment = '') => -0.0058170356, -0.0058170356);

// Tree: 9 
final_score_9 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 1.5) => -0.0417966865,
   (pf_product_desc > 1.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0031839251,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0626001926,
      (final_model_segment = '') => 0.0156971656, 0.0156971656),
   (pf_product_desc = NULL) => -0.0061495386, -0.0061495386),
(s_inq_ssns_per_addr_i > 3.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 10) => 0.0377092389,
   (btst_distaddraddr2_i > 10) => 0.1861343310,
   (btst_distaddraddr2_i = NULL) => 0.0832384082, 0.0832384082),
(s_inq_ssns_per_addr_i = NULL) => -0.0505161846, -0.0071629102);

// Tree: 10 
final_score_10 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 2.5) => 
   map(
	 ((real)BT_cen_span_lang = NULL) => -0.0475159277,
   (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 198.5) => 
      map(
      (NULL < btst_distphoneaddr_i and btst_distphoneaddr_i <= 145.5) => -0.0310958838,
      (btst_distphoneaddr_i > 145.5) => 0.3536357936,
      (btst_distphoneaddr_i = NULL) => 0.0085289726, -0.0045588624),
   ((real)BT_cen_span_lang > 198.5) => 0.4642811130, -0.0059205628),
(s_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 28.5) => 0.0260962552,
   (btst_distaddraddr2_i > 28.5) => 0.1917728848,
   (btst_distaddraddr2_i = NULL) => 0.0483688210, 0.0483688210),
(s_inq_ssns_per_addr_i = NULL) => -0.0504915504, -0.0064370424);

// Tree: 11 
final_score_11 := map(
(NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0227274816,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (pf_avs_result in ['Error/Inval','Full Match','Unavailable','Zip Only']) => 0.0194655278,
      (pf_avs_result in ['Addr Only','International','No Match','Not Supported']) => 0.1771331951,
      (pf_avs_result = '') => 0.0313849828, 0.0313849828),
   (final_model_segment = '') => -0.0097434244, -0.0097434244),
(s_P85_Phn_Invalid_i > 0.5) => 
   map(
   (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 0.3435891164,
   (s_L71_Add_Business_i > 0.5) => -0.0141973677,
   (s_L71_Add_Business_i = NULL) => 0.1502398548, 0.1502398548),
(s_P85_Phn_Invalid_i = NULL) => -0.0506227237, -0.0096939949);

// Tree: 12 
final_score_12 := map(
((real)ST_cen_span_lang = NULL) => -0.0314201809,
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 155.5) => -0.0144728433,
((real)ST_cen_span_lang > 155.5) => 
   map(
   (NULL < s_srchcomponentrisktype_i and s_srchcomponentrisktype_i <= 2.5) => 
      map(
      (NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 549) => -0.0214529983,
      (b_I60_inq_retail_recency_d > 549) => 0.1300985310,
      (b_I60_inq_retail_recency_d = NULL) => -0.0508333236, 0.0236973100),
   (s_srchcomponentrisktype_i > 2.5) => 0.3183665319,
   (s_srchcomponentrisktype_i = NULL) => 
      map(
      (pf_avs_result in ['Error/Inval','Full Match','Not Supported','Unavailable','Zip Only']) => 0.0459614347,
      (pf_avs_result in ['Addr Only','International','No Match']) => 0.4265557751,
      (pf_avs_result = '') => 0.0929797672, 0.0929797672), 0.0418203190), -0.0040195709);

// Tree: 13 
final_score_13 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0184718408,
(final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
   map(
   (pf_ship_method in ['2nd Day','3rd Day','Ground']) => 
      map(
      (NULL < b_phone_ver_experian_d and b_phone_ver_experian_d <= 0.5) => 0.0676878488,
      (b_phone_ver_experian_d > 0.5) => -0.0091921501,
      (b_phone_ver_experian_d = NULL) => 0.0187676819, 0.0190326839),
   (pf_ship_method in ['Next Day','Other']) => 
      map(
      (NULL < s_C12_source_profile_d and s_C12_source_profile_d <= 72.15) => -0.0152670023,
      (s_C12_source_profile_d > 72.15) => 0.1683410105,
      (s_C12_source_profile_d = NULL) => 0.1561626594, 0.0781458816),
   (pf_ship_method = '') => 0.0241832186, 0.0241832186),
(final_model_segment = '') => -0.0106718065, -0.0106718065);

// Tree: 14 
final_score_14 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
   map(
   (NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => -0.0072574135,
   (s_srchaddrsrchcountwk_i > 0.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- ID/RELS OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => -0.0506402527,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.4682577345,
      (final_model_segment = '') => 0.1953558301, 0.1953558301),
   (s_srchaddrsrchcountwk_i = NULL) => 0.0148365609, -0.0021249851),
(s_inq_ssns_per_addr_i > 3.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 6.5) => 0.0173251772,
   (btst_distaddraddr2_i > 6.5) => 0.1198929087,
   (btst_distaddraddr2_i = NULL) => 0.0489818845, 0.0489818845),
(s_inq_ssns_per_addr_i = NULL) => -0.0504275086, -0.0036483023);

// Tree: 15 
final_score_15 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
   map(
   (NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 549) => -0.0266314488,
   (b_I60_inq_retail_recency_d > 549) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 181.5) => 0.0214376236,
      ((real)ST_cen_span_lang > 181.5) => 0.2363799628,
      ((real)ST_cen_span_lang = NULL) => 0.0349578062, 0.0349578062),
   (b_I60_inq_retail_recency_d = NULL) => -0.0025393454, -0.0045650581),
(s_inq_ssns_per_addr_i > 3.5) => 
   map(
   (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 11.65) => 0.0055311530,
   ((real)ST_cen_blue_col > 11.65) => 0.1259555862,
   ((real)ST_cen_blue_col = NULL) => 0.0551977272, 0.0551977272),
(s_inq_ssns_per_addr_i = NULL) => -0.0504042878, -0.0058257113);

// Tree: 16 
final_score_16 := map(
(NULL < s_srchaddrsrchcountmo_i and s_srchaddrsrchcountmo_i <= 1.5) => -0.0114199116,
(s_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 2.5) => 0.0300239885,
   (s_inq_ssns_per_addr_i > 2.5) => 0.2243190776,
   (s_inq_ssns_per_addr_i = NULL) => 0.0864076614, 0.0864076614),
(s_srchaddrsrchcountmo_i = NULL) => 
   map(
   (pf_avs_result in ['Error/Inval','Full Match','Not Supported','Unavailable','Zip Only']) => -0.0046757711,
   (pf_avs_result in ['Addr Only','International','No Match']) => 
      map(
      (NULL < (real)ST_cen_business and (real)ST_cen_business <= 17.5) => 0.3255055073,
      ((real)ST_cen_business > 17.5) => 0.0860966756,
      ((real)ST_cen_business = NULL) => 0.1595408192, 0.1595408192),
   (pf_avs_result = '') => 0.0102159197, 0.0102159197), -0.0056662380);

// Tree: 17 
final_score_17 := map(
(NULL < s_util_add_input_inf_n and s_util_add_input_inf_n <= 0.5) => 
   map(
   (NULL < s_srchaddrsrchcountmo_i and s_srchaddrsrchcountmo_i <= 1.5) => -0.0144295033,
   (s_srchaddrsrchcountmo_i > 1.5) => 
      map(
      (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 2.5) => 0.0403686786,
      (s_inq_ssns_per_addr_i > 2.5) => 0.1414980412,
      (s_inq_ssns_per_addr_i = NULL) => 0.0658873028, 0.0658873028),
   (s_srchaddrsrchcountmo_i = NULL) => 0.0018461680, -0.0107448583),
(s_util_add_input_inf_n > 0.5) => 
   map(
   (NULL < b_phone_ver_insurance_d and b_phone_ver_insurance_d <= 3.5) => 0.2623750135,
   (b_phone_ver_insurance_d > 3.5) => 0.0219655909,
   (b_phone_ver_insurance_d = NULL) => 0.1062419568, 0.1062419568),
(s_util_add_input_inf_n = NULL) => -0.0503907428, -0.0102814981);

// Tree: 18 
final_score_18 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0188409111,
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < s_nap_phn_verd_d and s_nap_phn_verd_d <= 0.5) => 0.0687102109,
      (s_nap_phn_verd_d > 0.5) => -0.0033016705,
      (s_nap_phn_verd_d = NULL) => 0.0283684762, 0.0283684762),
   (final_model_segment = '') => -0.0117724556, -0.0117724556),
(s_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 36) => 0.0050475945,
   (btst_distaddraddr2_i > 36) => 0.1243708681,
   (btst_distaddraddr2_i = NULL) => 0.0230476991, 0.0230476991),
(s_inq_ssns_per_addr_i = NULL) => -0.0503703547, -0.0126039074);

// Tree: 19 
final_score_19 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0316163372,
   (pf_product_desc > 2.5) => 
      map(
      (NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 0.0188046237,
      (s_P85_Phn_Invalid_i > 0.5) => 0.2764457470,
      (s_P85_Phn_Invalid_i = NULL) => 0.0003170596, 0.0215348422),
   (pf_product_desc = NULL) => -0.0038128156, -0.0038128156),
(s_inq_ssns_per_addr_i > 3.5) => 
   map(
   (pf_ship_method in ['Ground']) => 0.0072278526,
   (pf_ship_method in ['2nd Day','3rd Day','Next Day','Other']) => 0.1192176984,
   (pf_ship_method = '') => 0.0454361529, 0.0454361529),
(s_inq_ssns_per_addr_i = NULL) => -0.0503516917, -0.0053215661);

// Tree: 20 
final_score_20 := map(
(NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0350876392,
(pf_product_desc > 2.5) => 
   map(
   (NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
      map(
      (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 2.5) => 0.0128598572,
      (s_inq_ssns_per_addr_i > 2.5) => 
         map(
         (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 18.3) => 0.1750246969,
         ((real)ST_cen_high_ed > 18.3) => 0.0226703569,
         ((real)ST_cen_high_ed = NULL) => 0.0625267665, 0.0625267665),
      (s_inq_ssns_per_addr_i = NULL) => -0.0503866066, 0.0136935360),
   (s_P85_Phn_Invalid_i > 0.5) => 0.2029224765,
   (s_P85_Phn_Invalid_i = NULL) => -0.0391870831, 0.0122039825),
(pf_product_desc = NULL) => -0.0095149622, -0.0095149622);

// Tree: 21 
final_score_21 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 378.5) => -0.0250948799,
   (btst_distphone2addr2_i > 378.5) => 
      map(
      (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.0338431328) => 0.0096496279,
      (b_add_curr_nhood_BUS_pct_i > 0.0338431328) => 0.1372104552,
      (b_add_curr_nhood_BUS_pct_i = NULL) => 0.0715723596, 0.0715723596),
   (btst_distphone2addr2_i = NULL) => 
      map(
      (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 57148) => 0.2386429340,
      (s_L80_Inp_AVM_AutoVal_d > 57148) => 0.0175660604,
      (s_L80_Inp_AVM_AutoVal_d = NULL) => 0.0044941042, 0.0120228640), -0.0011812726),
(b_inq_lnames_per_addr_i > 8.5) => 0.1254288549,
(b_inq_lnames_per_addr_i = NULL) => -0.0507993563, -0.0058869632);

// Tree: 22 
final_score_22 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 44) => 
      map(
      (NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => -0.0118092431,
      (s_srchaddrsrchcountwk_i > 0.5) => 
         map(
         (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 13.55) => -0.0139335085,
         ((real)ST_cen_blue_col > 13.55) => 0.1858078859,
         ((real)ST_cen_blue_col = NULL) => 0.0614655609, 0.0614655609),
      (s_srchaddrsrchcountwk_i = NULL) => 0.0024458029, -0.0084590262),
   (b_L79_adls_per_addr_c6_i > 44) => 0.1773499102,
   (b_L79_adls_per_addr_c6_i = NULL) => -0.0074823993, -0.0074823993),
(final_model_segment in ['CONS ADDR- LNAME   OTH']) => 0.1682870354,
(final_model_segment = '') => -0.0066059037, -0.0066059037);

// Tree: 23 
final_score_23 := map(
(NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0196368401,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0264118338,
   (final_model_segment = '') => -0.0097643804, -0.0097643804),
(s_P85_Phn_Not_Issued_i > 0.5) => 
   map(
   (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB']) => 0.0338335772,
      (final_model_segment in ['BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.4362175491,
      (final_model_segment = '') => 0.2310806222, 0.2310806222),
   (s_L71_Add_Business_i > 0.5) => -0.0508208873,
   (s_L71_Add_Business_i = NULL) => 0.0908242062, 0.0908242062),
(s_P85_Phn_Not_Issued_i = NULL) => -0.0324494655, -0.0095710686);

// Tree: 24 
final_score_24 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 7.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0347885315,
   (pf_product_desc > 2.5) => 
      map(
      (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 0.0034581602,
      (pf_ship_method in ['Next Day']) => 0.0855786854,
      (pf_ship_method = '') => 0.0122192255, 0.0122192255),
   (pf_product_desc = NULL) => -0.0096834312, -0.0096834312),
(b_inq_lnames_per_addr_i > 7.5) => 
   map(
   (NULL < (real)BT_cen_vacant_p and (real)BT_cen_vacant_p <= 6.1) => 0.0249779478,
   ((real)BT_cen_vacant_p > 6.1) => 0.2252203770,
   ((real)BT_cen_vacant_p = NULL) => 0.1250991624, 0.1250991624),
(b_inq_lnames_per_addr_i = NULL) => -0.0508423278, -0.0131682121);

// Tree: 25 
final_score_25 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => -0.0092708110,
   (s_srchaddrsrchcountwk_i > 0.5) => 0.0872165178,
   (s_srchaddrsrchcountwk_i = NULL) => 
      map(
      (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.35) => 0.0008625719,
      ((real)ST_cen_pop_0_5_p > 12.35) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0462787294,
         (final_model_segment in ['BUS  ADDR-         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.3638673567,
         (final_model_segment = '') => 0.1441303605, 0.1441303605),
      ((real)ST_cen_pop_0_5_p = NULL) => -0.0397102539, -0.0002914911), -0.0066449512),
(final_model_segment in ['CONS ADDR- LNAME   OTH']) => 0.1276471727,
(final_model_segment = '') => -0.0060732868, -0.0060732868);

// Tree: 26 
final_score_26 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
      map(
      (NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => -0.0015485822,
      (s_P85_Phn_Not_Issued_i > 0.5) => 0.1251554181,
      (s_P85_Phn_Not_Issued_i = NULL) => -0.0505559898, -0.0004974139),
   (b_inq_lnames_per_addr_i > 8.5) => 0.0847369303,
   (b_inq_lnames_per_addr_i = NULL) => -0.0507382225, -0.0053309877),
(final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 
   map(
   (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 12.65) => 0.0245106892,
   ((real)ST_cen_blue_col > 12.65) => 0.2058970117,
   ((real)ST_cen_blue_col = NULL) => 0.0730635937, 0.0730635937),
(final_model_segment = '') => -0.0043107712, -0.0043107712);

// Tree: 27 
final_score_27 := map(
(NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 549) => -0.0243250686,
   (b_I60_inq_retail_recency_d > 549) => 
      map(
      (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 4.5) => 0.0199491104,
      (s_inq_per_phone_i > 4.5) => 0.2483768162,
      (s_inq_per_phone_i = NULL) => 0.0255707107, 0.0255707107),
   (b_I60_inq_retail_recency_d = NULL) => 0.0017850507, -0.0052360254),
(s_P85_Phn_Not_Issued_i > 0.5) => 
   map(
   (NULL < b_prevaddrlenofres_d and b_prevaddrlenofres_d <= 71) => 0.0272103666,
   (b_prevaddrlenofres_d > 71) => 0.2945976836,
   (b_prevaddrlenofres_d = NULL) => 0.0098766604, 0.0863236822),
(s_P85_Phn_Not_Issued_i = NULL) => -0.0505343479, -0.0061882822);

// Tree: 28 
final_score_28 := map(
(NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => -0.0071909415,
   (s_srchaddrsrchcountwk_i > 0.5) => 
      map(
      (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 4.55) => -0.0055572056,
      ((real)ST_cen_unemp > 4.55) => 0.1988497827,
      ((real)ST_cen_unemp = NULL) => 0.0613617489, 0.0613617489),
   (s_srchaddrsrchcountwk_i = NULL) => 0.0136990084, -0.0030648452),
(s_P85_Phn_Invalid_i > 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR+ DIFF    WEB']) => 0.0044904231,
   (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.1685635120,
   (final_model_segment = '') => 0.0605983188, 0.0605983188),
(s_P85_Phn_Invalid_i = NULL) => -0.0393550465, -0.0039882636);

// Tree: 29 
final_score_29 := map(
(NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 549) => -0.0236320722,
(b_I60_inq_retail_recency_d > 549) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_nap_phn_verd_d and s_nap_phn_verd_d <= 0.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0620421568,
         (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 0.1176563094,
         (final_model_segment = '') => 0.0770375958, 0.0770375958),
      (s_nap_phn_verd_d > 0.5) => -0.0133493767,
      (s_nap_phn_verd_d = NULL) => 0.0246350276, 0.0246350276),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 0.1837345464,
   (final_model_segment = '') => 0.0264689281, 0.0264689281),
(b_I60_inq_retail_recency_d = NULL) => -0.0007070740, -0.0051562699);

// Tree: 30 
final_score_30 := map(
(NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
   map(
   (NULL < s_C12_source_profile_index_d and s_C12_source_profile_index_d <= 0.5) => 
      map(
      (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 1.5) => 0.0766543740,
      (s_inq_ssns_per_addr_i > 1.5) => 0.1667243854,
      (s_inq_ssns_per_addr_i = NULL) => 0.0821751238, 0.0821751238),
   (s_C12_source_profile_index_d > 0.5) => 0.0050436481,
   (s_C12_source_profile_index_d = NULL) => 
      map(
      (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 1.5) => 0.0105006884,
      (s_inq_ssns_per_addr_i > 1.5) => 0.1245379693,
      (s_inq_ssns_per_addr_i = NULL) => -0.0503829572, 0.0146583251), 0.0134769786),
(s_L71_Add_Business_i > 0.5) => -0.0332923536,
(s_L71_Add_Business_i = NULL) => -0.0067322735, -0.0067322735);

// Tree: 31 
final_score_31 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 2.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 1.5) => -0.0385036153,
   (pf_product_desc > 1.5) => 0.0112554960,
   (pf_product_desc = NULL) => -0.0078901059, -0.0078901059),
(s_inq_ssns_per_addr_i > 2.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 43) => 
      map(
      (NULL < b_rel_count_i and b_rel_count_i <= 20.5) => -0.0351883391,
      (b_rel_count_i > 20.5) => 0.1235630416,
      (b_rel_count_i = NULL) => 0.0086175189, -0.0046144821),
   (btst_distaddraddr2_i > 43) => 0.1125180427,
   (btst_distaddraddr2_i = NULL) => 0.0108883520, 0.0108883520),
(s_inq_ssns_per_addr_i = NULL) => -0.0502486543, -0.0091989985);

// Tree: 32 
final_score_32 := map(
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','Unavailable','Zip Only']) => -0.0064300287,
(pf_avs_result in ['International','No Match','Not Supported']) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH']) => -0.0038788623,
   (final_model_segment in ['CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < (real)BT_cen_easiqlife and (real)BT_cen_easiqlife <= 133.5) => 0.0487926594,
      ((real)BT_cen_easiqlife > 133.5) => 
         map(
         (NULL < (real)BT_cen_high_hval and (real)BT_cen_high_hval <= 31) => 0.3597918551,
         ((real)BT_cen_high_hval > 31) => 0.0152570924,
         ((real)BT_cen_high_hval = NULL) => 0.2434554417, 0.2434554417),
      ((real)BT_cen_easiqlife = NULL) => 0.1231799261, 0.1231799261),
   (final_model_segment = '') => 0.0412099527, 0.0412099527),
(pf_avs_result = '') => -0.0029766805, -0.0029766805);

// Tree: 33 
final_score_33 := map(
(NULL < b_inq_adls_per_phone_i and b_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
      map(
      (pf_ship_method in ['2nd Day','Ground']) => -0.0123436301,
      (pf_ship_method in ['3rd Day','Next Day','Other']) => 0.0398506976,
      (pf_ship_method = '') => -0.0055340476, -0.0055340476),
   (s_P85_Phn_Invalid_i > 0.5) => 
      map(
      (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 0.1359590266,
      (s_L71_Add_Business_i > 0.5) => -0.0183292850,
      (s_L71_Add_Business_i = NULL) => 0.0526433383, 0.0526433383),
   (s_P85_Phn_Invalid_i = NULL) => -0.0514098775, -0.0051056107),
(b_inq_adls_per_phone_i > 2.5) => 0.1654750325,
(b_inq_adls_per_phone_i = NULL) => -0.0455381298, -0.0095201997);

// Tree: 34 
final_score_34 := map(
(NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
   map(
   (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 0.0205721514,
   (pf_ship_method in ['Next Day']) => 
      map(
      (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
         map(
         (NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 55388.5) => 0.4645455032,
         (s_curraddrmedianincome_d > 55388.5) => 0.0912150249,
         (s_curraddrmedianincome_d = NULL) => 0.2435338600, 0.2435338600),
      (s_L71_Add_Business_i > 0.5) => 0.0026121660,
      (s_L71_Add_Business_i = NULL) => 0.1259706966, 0.1259706966),
   (pf_ship_method = '') => 0.0305887996, 0.0305887996),
(s_C20_email_verification_d > 0.5) => -0.0170797225,
(s_C20_email_verification_d = NULL) => -0.0061013005, -0.0041309637);

// Tree: 35 
final_score_35 := map(
(NULL < s_bus_phone_match_d and s_bus_phone_match_d <= 0.5) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 2.5) => 
      map(
      (pf_ship_method in ['2nd Day','Ground','Other']) => -0.0004857017,
      (pf_ship_method in ['3rd Day','Next Day']) => 0.0668256944,
      (pf_ship_method = '') => 0.0071903321, 0.0071903321),
   (s_inq_ssns_per_addr_i > 2.5) => 
      map(
      (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 12.5) => 0.0336708678,
      (btst_distaddraddr2_i > 12.5) => 0.1031440204,
      (btst_distaddraddr2_i = NULL) => 0.0468506620, 0.0468506620),
   (s_inq_ssns_per_addr_i = NULL) => -0.0502349550, 0.0051787489),
(s_bus_phone_match_d > 0.5) => -0.0401999246,
(s_bus_phone_match_d = NULL) => -0.0093808401, -0.0093808401);

// Tree: 36 
final_score_36 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 1.5) => -0.0383637096,
   (pf_product_desc > 1.5) => 
      map(
      (NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
         map(
         (NULL < b_inq_adls_per_phone_i and b_inq_adls_per_phone_i <= 2.5) => 0.0099721275,
         (b_inq_adls_per_phone_i > 2.5) => 0.1767307236,
         (b_inq_adls_per_phone_i = NULL) => -0.0511256758, 0.0100023382),
      (s_P85_Phn_Not_Issued_i > 0.5) => 0.0825939151,
      (s_P85_Phn_Not_Issued_i = NULL) => 0.0039539796, 0.0107159839),
   (pf_product_desc = NULL) => -0.0078951430, -0.0078951430),
(b_inq_lnames_per_addr_i > 8.5) => 0.0748616894,
(b_inq_lnames_per_addr_i = NULL) => -0.0506546856, -0.0118951967);

// Tree: 37 
final_score_37 := map(
(NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 549) => -0.0212019011,
(b_I60_inq_retail_recency_d > 549) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 313) => 0.0172563899,
   (btst_distaddraddr2_i > 313) => 
      map(
      (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 0.5) => 0.0448025992,
      (s_inq_ssns_per_addr_i > 0.5) => 0.1831803617,
      (s_inq_ssns_per_addr_i = NULL) => 0.0780766413, 0.0780766413),
   (btst_distaddraddr2_i = NULL) => 0.0207718586, 0.0207718586),
(b_I60_inq_retail_recency_d = NULL) => 
   map(
   (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 193913) => 0.1908589201,
   (s_L80_Inp_AVM_AutoVal_d > 193913) => 0.0044937947,
   (s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0108173467, -0.0028548189), -0.0057979563);

// Tree: 38 
final_score_38 := map(
(NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
   map(
   (NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
      map(
      (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 754) => 0.0032328032,
      (btst_distphone2addr2_i > 754) => 0.1736241505,
      (btst_distphone2addr2_i = NULL) => 0.0121355992, 0.0106053805),
   (s_P85_Phn_Not_Issued_i > 0.5) => 
      map(
      (NULL < s_add_input_nhood_VAC_pct_i and s_add_input_nhood_VAC_pct_i <= 0.0317064955) => 0.1253855796,
      (s_add_input_nhood_VAC_pct_i > 0.0317064955) => 0.0095483256,
      (s_add_input_nhood_VAC_pct_i = NULL) => 0.0686026119, 0.0686026119),
   (s_P85_Phn_Not_Issued_i = NULL) => 0.0654919984, 0.0117642461),
(s_L71_Add_Business_i > 0.5) => -0.0340551299,
(s_L71_Add_Business_i = NULL) => -0.0080416928, -0.0080416928);

// Tree: 39 
final_score_39 := map(
(NULL < b_inq_adls_per_phone_i and b_inq_adls_per_phone_i <= 2.5) => 
   map(
   (pf_avs_result in ['Addr Only','Error/Inval','Full Match','Unavailable','Zip Only']) => -0.0068697793,
   (pf_avs_result in ['International','No Match','Not Supported']) => 
      map(
      (NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 3.5) => 
         map(
         (NULL < b_nap_contradictory_i and b_nap_contradictory_i <= 0.5) => 0.0038720736,
         (b_nap_contradictory_i > 0.5) => 0.2175886386,
         (b_nap_contradictory_i = NULL) => 0.0152559710, 0.0152559710),
      (s_L79_adls_per_addr_c6_i > 3.5) => 0.1814803604,
      (s_L79_adls_per_addr_c6_i = NULL) => 0.0304362806, 0.0304362806),
   (pf_avs_result = '') => -0.0039952360, -0.0039952360),
(b_inq_adls_per_phone_i > 2.5) => 0.1201856738,
(b_inq_adls_per_phone_i = NULL) => -0.0479786677, -0.0090475476);

// Tree: 40 
final_score_40 := map(
(NULL < s_util_add_input_inf_n and s_util_add_input_inf_n <= 0.5) => 
   map(
   (NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 2.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0071075090,
      (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.1164183307,
      (final_model_segment = '') => 0.0333850083, 0.0333850083),
   (pf_pmt_x_avs_lvl > 2.5) => -0.0096339063,
   (pf_pmt_x_avs_lvl = NULL) => -0.0062281494, -0.0062281494),
(s_util_add_input_inf_n > 0.5) => 
   map(
   (NULL < b_nap_phn_verd_d and b_nap_phn_verd_d <= 0.5) => 0.2177582013,
   (b_nap_phn_verd_d > 0.5) => 0.0107677550,
   (b_nap_phn_verd_d = NULL) => 0.0773003985, 0.0773003985),
(s_util_add_input_inf_n = NULL) => -0.0501873076, -0.0065028459);

// Tree: 41 
final_score_41 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => -0.0083069947,
      (s_srchaddrsrchcountwk_i > 0.5) => 0.0823959629,
      (s_srchaddrsrchcountwk_i = NULL) => 0.0141119631, -0.0044581673),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 12.65) => 0.0055889575,
      ((real)ST_cen_blue_col > 12.65) => 0.1983249847,
      ((real)ST_cen_blue_col = NULL) => 0.0505606972, 0.0505606972),
   (final_model_segment = '') => -0.0033199237, -0.0033199237),
(b_inq_lnames_per_addr_i > 8.5) => 0.0703397438,
(b_inq_lnames_per_addr_i = NULL) => -0.0506341579, -0.0079415456);

// Tree: 42 
final_score_42 := map(
(pf_pmt_type in ['American Express','Credit Terms','Dell Credit Card','Diners Club','Discover','Gift Card','Mastercard']) => -0.0189927582,
(pf_pmt_type in ['Other','Prepaid Check','Visa']) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
         map(
         (pf_avs_result in ['Addr Only','Full Match','No Match','Unavailable','Zip Only']) => 0.0095405792,
         (pf_avs_result in ['Error/Inval','International','Not Supported']) => 0.1983224562,
         (pf_avs_result = '') => 0.0135071058, 0.0135071058),
      (s_P85_Phn_Invalid_i > 0.5) => 0.1013996623,
      (s_P85_Phn_Invalid_i = NULL) => 0.0143643154, 0.0143643154),
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 0.0895868931,
   (final_model_segment = '') => 0.0151447571, 0.0151447571),
(pf_pmt_type = '') => -0.0059867053, -0.0059867053);

// Tree: 43 
final_score_43 := map(
(NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
   map(
   (NULL < b_corrphonelastnamecount_d and b_corrphonelastnamecount_d <= 0.5) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 155.5) => 0.0273769113,
      ((real)ST_cen_span_lang > 155.5) => 
         map(
         (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 13.5) => 0.0805064573,
         (btst_distaddraddr2_i > 13.5) => 0.2598750615,
         (btst_distaddraddr2_i = NULL) => 0.1031739183, 0.1031739183),
      ((real)ST_cen_span_lang = NULL) => 0.0764363002, 0.0415573759),
   (b_corrphonelastnamecount_d > 0.5) => -0.0224299079,
   (b_corrphonelastnamecount_d = NULL) => 0.0228935796, 0.0111144079),
(s_L71_Add_Business_i > 0.5) => -0.0330263731,
(s_L71_Add_Business_i = NULL) => -0.0079321442, -0.0079321442);

// Tree: 44 
final_score_44 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < s_I60_inq_hiRiskCred_recency_d and s_I60_inq_hiRiskCred_recency_d <= 9) => 0.1360667589,
   (s_I60_inq_hiRiskCred_recency_d > 9) => -0.0075888543,
   (s_I60_inq_hiRiskCred_recency_d = NULL) => 
      map(
      (NULL < (real)ST_cen_business and (real)ST_cen_business <= 7.5) => 
         map(
         (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 229) => 0.0354846145,
         (btst_distaddraddr2_i > 229) => 0.1986717181,
         (btst_distaddraddr2_i = NULL) => 0.0628650010, 0.0628650010),
      ((real)ST_cen_business > 7.5) => -0.0034545290,
      ((real)ST_cen_business = NULL) => -0.0532828794, 0.0049593773), -0.0052696079),
(b_inq_lnames_per_addr_i > 8.5) => 0.0727529368,
(b_inq_lnames_per_addr_i = NULL) => -0.0506126754, -0.0097402612);

// Tree: 45 
final_score_45 := map(
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 181.5) => -0.0023000373,
((real)ST_cen_span_lang > 181.5) => 
   map(
   (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
      map(
      (NULL < s_phone_ver_experian_d and s_phone_ver_experian_d <= 0.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0712972817,
         (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.5140777335,
         (final_model_segment = '') => 0.2684255650, 0.2684255650),
      (s_phone_ver_experian_d > 0.5) => -0.0331704631,
      (s_phone_ver_experian_d = NULL) => 0.1148677043, 0.1139645298),
   (s_L71_Add_Business_i > 0.5) => -0.0157300704,
   (s_L71_Add_Business_i = NULL) => 0.0378088828, 0.0378088828),
((real)ST_cen_span_lang = NULL) => -0.0159513796, -0.0005058995);

// Tree: 46 
final_score_46 := map(
(NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.8419082633) => 
   map(
   (NULL < s_srchaddrsrchcountmo_i and s_srchaddrsrchcountmo_i <= 2.5) => -0.0070790117,
   (s_srchaddrsrchcountmo_i > 2.5) => 0.0732705815,
   (s_srchaddrsrchcountmo_i = NULL) => -0.0042054846, -0.0058958029),
(s_add_input_nhood_MFD_pct_i > 0.8419082633) => 
   map(
   (NULL < s_divaddrsuspidcountnew_i and s_divaddrsuspidcountnew_i <= 0.5) => 0.0155587610,
   (s_divaddrsuspidcountnew_i > 0.5) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 5.45) => 0.0133080457,
      ((real)ST_cen_blue_col > 5.45) => 0.2820244991,
      ((real)ST_cen_blue_col = NULL) => 0.1574973621, 0.1574973621),
   (s_divaddrsuspidcountnew_i = NULL) => 0.0611047248, 0.0486911741),
(s_add_input_nhood_MFD_pct_i = NULL) => -0.0064125367, -0.0037547028);

// Tree: 47 
final_score_47 := map(
(NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 46) => -0.0195580569,
(btst_distphone2addr2_i > 46) => 
   map(
   (btst_relatives_lvl_d in ['3. SHIPTO DID 0','4. DIDS EQUAL','5. RELATIVES','6. RELATIVES IN COMMON']) => 0.0352763845,
   (btst_relatives_lvl_d in ['1. BOTH DID 0','2. BILLTO DID 0','7. NO RELATION']) => 0.2504736329,
   ((integer)btst_relatives_lvl_d = NULL) => -0.0506687858, 0.0586606135),
(btst_distphone2addr2_i = NULL) => 
   map(
   (NULL < b_inq_count24_i and b_inq_count24_i <= 6.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0165095458,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 0.1207486323,
      (final_model_segment = '') => 0.0179570564, 0.0179570564),
   (b_inq_count24_i > 6.5) => -0.0370031093,
   (b_inq_count24_i = NULL) => -0.0039229136, -0.0001728304), -0.0057402310);

// Tree: 48 
final_score_48 := map(
(NULL < b_inq_adls_per_phone_i and b_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
      map(
      (NULL < s_nap_phn_verd_d and s_nap_phn_verd_d <= 0.5) => 0.0179578299,
      (s_nap_phn_verd_d > 0.5) => -0.0234809536,
      (s_nap_phn_verd_d = NULL) => -0.0064593402, -0.0064593402),
   (s_P85_Phn_Invalid_i > 0.5) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.08632612365) => 0.0823270495,
      (s_add_input_nhood_BUS_pct_i > 0.08632612365) => 0.0395192344,
      (s_add_input_nhood_BUS_pct_i = NULL) => 0.0544588746, 0.0544588746),
   (s_P85_Phn_Invalid_i = NULL) => -0.0518747572, -0.0060179816),
(b_inq_adls_per_phone_i > 2.5) => 0.0984807807,
(b_inq_adls_per_phone_i = NULL) => -0.0475508112, -0.0107712299);

// Tree: 49 
final_score_49 := map(
(NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 1.5) => 0.0181793011,
   (s_inq_ssns_per_addr_i > 1.5) => 
      map(
      (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 10.55) => 
         map(
         (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 28.6) => 0.1236973631,
         ((real)ST_cen_high_ed > 28.6) => -0.0310362821,
         ((real)ST_cen_high_ed = NULL) => 0.0223201473, 0.0223201473),
      ((real)ST_cen_pop_0_5_p > 10.55) => 0.2888562582,
      ((real)ST_cen_pop_0_5_p = NULL) => 0.0799495767, 0.0799495767),
   (s_inq_ssns_per_addr_i = NULL) => 0.0233465464, 0.0233465464),
(s_C20_email_verification_d > 0.5) => -0.0174319315,
(s_C20_email_verification_d = NULL) => -0.0020877459, -0.0040346432);

// Tree: 50 
final_score_50 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 549) => -0.0206582291,
   (b_I60_inq_retail_recency_d > 549) => 
      map(
      (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 0.0799472929,
      (s_C20_email_verification_d > 0.5) => -0.0108995927,
      (s_C20_email_verification_d = NULL) => 
         map(
         (NULL < pf_order_amt_c and pf_order_amt_c <= 558.125) => 0.1335094733,
         (pf_order_amt_c > 558.125) => -0.0024116537,
         (pf_order_amt_c = NULL) => 0.0284292820, 0.0284292820), 0.0190325849),
   (b_I60_inq_retail_recency_d = NULL) => 0.0112662990, -0.0049703554),
(b_inq_lnames_per_addr_i > 8.5) => 0.0592363582,
(b_inq_lnames_per_addr_i = NULL) => -0.0505623801, -0.0094948164);

// Tree: 51 
final_score_51 := map(
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 166.5) => -0.0073216092,
((real)ST_cen_span_lang > 166.5) => 
   map(
   (NULL < s_P88_Phn_Dst_to_Inp_Add_i and s_P88_Phn_Dst_to_Inp_Add_i <= 731) => 
      map(
      (NULL < b_inq_per_addr_i and b_inq_per_addr_i <= 10.5) => -0.0082591927,
      (b_inq_per_addr_i > 10.5) => 0.1730342580,
      (b_inq_per_addr_i = NULL) => -0.0504398780, -0.0013423994),
   (s_P88_Phn_Dst_to_Inp_Add_i > 731) => 0.1768149968,
   (s_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.0198906066) => 0.2636871842,
      (b_add_input_nhood_BUS_pct_i > 0.0198906066) => 0.0575537471,
      (b_add_input_nhood_BUS_pct_i = NULL) => 0.0814289087, 0.0814289087), 0.0274132009),
((real)ST_cen_span_lang = NULL) => -0.0402127000, -0.0045142315);

// Tree: 52 
final_score_52 := map(
(NULL < s_mos_liens_rel_OT_lseen_d and s_mos_liens_rel_OT_lseen_d <= 29.5) => 0.3688226881,
(s_mos_liens_rel_OT_lseen_d > 29.5) => -0.0058524571,
(s_mos_liens_rel_OT_lseen_d = NULL) => 
   map(
   (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.75) => 
      map(
      (pf_avs_result in ['Addr Only','Error/Inval','Full Match','Not Supported','Unavailable','Zip Only']) => -0.0236740769,
      (pf_avs_result in ['International','No Match']) => 0.0594979276,
      (pf_avs_result = '') => -0.0155641701, -0.0155641701),
   ((real)ST_cen_pop_0_5_p > 12.75) => 
      map(
      (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 60.2) => 0.2761103135,
      ((real)ST_cen_civ_emp > 60.2) => 0.0353641177,
      ((real)ST_cen_civ_emp = NULL) => 0.1166757468, 0.1166757468),
   ((real)ST_cen_pop_0_5_p = NULL) => -0.0513115662, -0.0172726786), -0.0068759918);

// Tree: 53 
final_score_53 := map(
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 167.5) => -0.0042405614,
((real)ST_cen_span_lang > 167.5) => 
   map(
   (NULL < s_inq_lnames_per_addr_i and s_inq_lnames_per_addr_i <= 3.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => -0.0036298274,
      (final_model_segment in ['CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 
         map(
         (NULL < s_C12_source_profile_index_d and s_C12_source_profile_index_d <= 0.5) => 0.3435641295,
         (s_C12_source_profile_index_d > 0.5) => 0.0458783599,
         (s_C12_source_profile_index_d = NULL) => 0.0953748598, 0.0837498820),
      (final_model_segment = '') => 0.0220983995, 0.0220983995),
   (s_inq_lnames_per_addr_i > 3.5) => 0.1458663173,
   (s_inq_lnames_per_addr_i = NULL) => 0.0265208166, 0.0265208166),
((real)ST_cen_span_lang = NULL) => -0.0401993883, -0.0021682712);

// Tree: 54 
final_score_54 := map(
(NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
   map(
   (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.81281361365) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.74632833175) => 0.0051896850,
      (s_add_input_nhood_BUS_pct_i > 0.74632833175) => 0.1366161401,
      (s_add_input_nhood_BUS_pct_i = NULL) => 0.0078894890, 0.0078894890),
   (s_add_input_nhood_MFD_pct_i > 0.81281361365) => 
      map(
      (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 33.05) => 0.2409143479,
      ((real)ST_cen_high_ed > 33.05) => 0.0037663047,
      ((real)ST_cen_high_ed = NULL) => 0.0920918514, 0.0920918514),
   (s_add_input_nhood_MFD_pct_i = NULL) => 0.0419218630, 0.0182612081),
(s_C20_email_verification_d > 0.5) => -0.0199709859,
(s_C20_email_verification_d = NULL) => -0.0005900861, -0.0055838606);

// Tree: 55 
final_score_55 := map(
(pf_pmt_type in ['American Express','Credit Terms','Dell Credit Card','Diners Club','Discover','Gift Card','Mastercard','Other']) => -0.0177472425,
(pf_pmt_type in ['Prepaid Check','Visa']) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0271092853,
   (pf_product_desc > 2.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0322328953,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH']) => 
         map(
         (NULL < pf_order_amt_c and pf_order_amt_c <= 542.065) => 0.1934189464,
         (pf_order_amt_c > 542.065) => 0.0269950593,
         (pf_order_amt_c = NULL) => 0.0830567214, 0.0830567214),
      (final_model_segment = '') => 0.0405832603, 0.0405832603),
   (pf_product_desc = NULL) => 0.0101189178, 0.0101189178),
(pf_pmt_type = '') => -0.0071135672, -0.0071135672);

// Tree: 56 
final_score_56 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1449) => -0.0104251772,
   (b_P88_Phn_Dst_to_Inp_Add_i > 1449) => 0.1236008639,
   (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
         map(
         (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 4.65) => 0.2007709450,
         ((real)ST_cen_high_ed > 4.65) => 0.0040594526,
         ((real)ST_cen_high_ed = NULL) => 0.0089556391, 0.0089556391),
      (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 0.0867816875,
      (final_model_segment = '') => 0.0104605190, 0.0104605190), -0.0027691606),
(s_inq_ssns_per_addr_i > 5.5) => -0.0354202352,
(s_inq_ssns_per_addr_i = NULL) => -0.0501483402, -0.0048741747);

// Tree: 57 
final_score_57 := map(
(pf_pmt_type in ['American Express','Credit Terms','Dell Credit Card','Diners Club','Discover','Gift Card','Mastercard','Prepaid Check']) => -0.0197939416,
(pf_pmt_type in ['Other','Visa']) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS WEB']) => 0.0017279821,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 9.5) => 0.0024869182,
      (b_P88_Phn_Dst_to_Inp_Add_i > 9.5) => 0.0493420612,
      (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
         map(
         (NULL < (real)BT_cen_urban_p and (real)BT_cen_urban_p <= 86) => 0.2899797245,
         ((real)BT_cen_urban_p > 86) => 0.0643593511,
         ((real)BT_cen_urban_p = NULL) => 0.1161910585, 0.1161910585), 0.0380037601),
   (final_model_segment = '') => 0.0089854527, 0.0089854527),
(pf_pmt_type = '') => -0.0088240290, -0.0088240290);

// Tree: 58 
final_score_58 := map(
(NULL < s_inq_adls_per_phone_i and s_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 60) => 
      map(
      (NULL < b_inq_Retail_count24_i and b_inq_Retail_count24_i <= 0.5) => 0.0104820682,
      (b_inq_Retail_count24_i > 0.5) => -0.0308229946,
      (b_inq_Retail_count24_i = NULL) => -0.0048401004, -0.0061011774),
   (s_L79_adls_per_addr_c6_i > 60) => 0.1125002398,
   (s_L79_adls_per_addr_c6_i = NULL) => -0.0054954031, -0.0054954031),
(s_inq_adls_per_phone_i > 2.5) => 
   map(
   (NULL < pf_avs_zip and pf_avs_zip <= 0.5) => 0.1913340718,
   (pf_avs_zip > 0.5) => -0.0270458545,
   (pf_avs_zip = NULL) => 0.0810840119, 0.0810840119),
(s_inq_adls_per_phone_i = NULL) => -0.0147712430, -0.0054461088);

// Tree: 59 
final_score_59 := map(
(NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
   map(
   (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
      map(
      (NULL < s_C12_source_profile_index_d and s_C12_source_profile_index_d <= 0.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB']) => 0.0437233078,
         (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.2450615995,
         (final_model_segment = '') => 0.1276142627, 0.1276142627),
      (s_C12_source_profile_index_d > 0.5) => 0.0385881808,
      (s_C12_source_profile_index_d = NULL) => 0.0216219505, 0.0461304761),
   (s_L71_Add_Business_i > 0.5) => -0.0257495511,
   (s_L71_Add_Business_i = NULL) => 0.0157527457, 0.0157527457),
(s_C20_email_verification_d > 0.5) => -0.0220918872,
(s_C20_email_verification_d = NULL) => -0.0028136858, -0.0078122272);

// Tree: 60 
final_score_60 := map(
(NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 46) => -0.0266633649,
(btst_distphone2addr2_i > 46) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB']) => 0.0176712134,
   (final_model_segment in ['CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.2070803364,
   (final_model_segment = '') => 0.0488398032, 0.0488398032),
(btst_distphone2addr2_i = NULL) => 
   map(
   (pf_ship_method in ['Ground','Other']) => -0.0115754100,
   (pf_ship_method in ['2nd Day','3rd Day','Next Day']) => 
      map(
      (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 433.5) => 0.0174367711,
      (btst_distaddraddr2_i > 433.5) => 0.1268778922,
      (btst_distaddraddr2_i = NULL) => 0.0272374685, 0.0272374685),
   (pf_ship_method = '') => -0.0008535382, -0.0008535382), -0.0088262455);

// Tree: 61 
final_score_61 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 45.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 1.5) => -0.0322319464,
   (pf_product_desc > 1.5) => 
      map(
      (NULL < b_mos_liens_unrel_ST_lseen_d and b_mos_liens_unrel_ST_lseen_d <= 78.5) => 0.2163939257,
      (b_mos_liens_unrel_ST_lseen_d > 78.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0076395489,
         (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.1465727093,
         (final_model_segment = '') => 0.0085171301, 0.0085171301),
      (b_mos_liens_unrel_ST_lseen_d = NULL) => -0.0020874898, 0.0074269788),
   (pf_product_desc = NULL) => -0.0072209828, -0.0072209828),
(s_L79_adls_per_addr_c6_i > 45.5) => 0.0780649278,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0067075247, -0.0067075247);

// Tree: 62 
final_score_62 := map(
(NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 193.5) => 
   map(
   (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 0.0227445680,
   (s_C20_email_verification_d > 0.5) => -0.0131921784,
   (s_C20_email_verification_d = NULL) => -0.0126609575, -0.0060377459),
((real)BT_cen_very_rich > 193.5) => 
   map(
   (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 251393.5) => 0.5013823238,
   (s_L80_Inp_AVM_AutoVal_d > 251393.5) => -0.0123549226,
   (s_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < s_prevaddrlenofres_d and s_prevaddrlenofres_d <= 154.5) => -0.0509246206,
      (s_prevaddrlenofres_d > 154.5) => 0.2609733083,
      (s_prevaddrlenofres_d = NULL) => -0.0180860088, 0.0393387003), 0.0834903754),
((real)BT_cen_very_rich = NULL) => -0.0411871593, -0.0073693577);

// Tree: 63 
final_score_63 := map(
(NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 184.5) => 
   map(
   (NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 0.0022272366,
   (s_P85_Phn_Invalid_i > 0.5) => 0.0701990450,
   (s_P85_Phn_Invalid_i = NULL) => -0.0509241709, 0.0024286805),
((real)BT_cen_span_lang > 184.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => -0.0058923772,
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < b_inq_count24_i and b_inq_count24_i <= 2.5) => 0.2026720863,
      (b_inq_count24_i > 2.5) => -0.0539281301,
      (b_inq_count24_i = NULL) => 0.0961587889, 0.0961587889),
   (final_model_segment = '') => 0.0213591164, 0.0213591164),
((real)BT_cen_span_lang = NULL) => -0.0408844921, -0.0017244590);

// Tree: 64 
final_score_64 := map(
(NULL < b_inq_Retail_count24_i and b_inq_Retail_count24_i <= 0.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 19.5) => 0.0059506166,
   (btst_distaddraddr2_i > 19.5) => 
      map(
      (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 14.55) => 
         map(
         (NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 71.1) => 0.0618750487,
         ((real)BT_cen_ownocc_p > 71.1) => 0.2435191508,
         ((real)BT_cen_ownocc_p = NULL) => 0.1371908959, 0.1371908959),
      ((real)ST_cen_high_ed > 14.55) => 0.0341911909,
      ((real)ST_cen_high_ed = NULL) => 0.0524368529, 0.0524368529),
   (btst_distaddraddr2_i = NULL) => 0.0102859318, 0.0102859318),
(b_inq_Retail_count24_i > 0.5) => -0.0300076320,
(b_inq_Retail_count24_i = NULL) => -0.0053446897, -0.0062449181);

// Tree: 65 
final_score_65 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 85) => 
      map(
      (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.85937480185) => -0.0072045413,
      (s_add_input_nhood_MFD_pct_i > 0.85937480185) => 
         map(
         (NULL < (real)ST_cen_families and (real)ST_cen_families <= 572) => 0.0211398335,
         ((real)ST_cen_families > 572) => 0.2485688984,
         ((real)ST_cen_families = NULL) => 0.0437676832, 0.0437676832),
      (s_add_input_nhood_MFD_pct_i = NULL) => -0.0096265880, -0.0056105059),
   (s_inq_per_phone_i > 85) => 0.1261190482,
   (s_inq_per_phone_i = NULL) => 0.0465334904, -0.0046649591),
(s_inq_ssns_per_addr_i > 5.5) => -0.0312030353,
(s_inq_ssns_per_addr_i = NULL) => -0.0501040242, -0.0067190842);

// Tree: 66 
final_score_66 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0089047310,
(final_model_segment in ['CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
   map(
   (NULL < s_C12_source_profile_index_d and s_C12_source_profile_index_d <= 0.5) => 
      map(
      (NULL < b_prevaddrageoldest_d and b_prevaddrageoldest_d <= 85.5) => 0.1912692444,
      (b_prevaddrageoldest_d > 85.5) => 0.0032757510,
      (b_prevaddrageoldest_d = NULL) => 0.0885405595, 0.0885405595),
   (s_C12_source_profile_index_d > 0.5) => 0.0108525841,
   (s_C12_source_profile_index_d = NULL) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 11.95) => -0.0208138082,
      ((real)ST_cen_blue_col > 11.95) => 0.0922729307,
      ((real)ST_cen_blue_col = NULL) => 0.0201596479, 0.0201596479), 0.0180618490),
(final_model_segment = '') => -0.0051313121, -0.0051313121);

// Tree: 67 
final_score_67 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => -0.0060921368,
   (pf_ship_method in ['Next Day']) => 
      map(
      (NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 4.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => 0.0012821292,
         (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0625332630,
         (final_model_segment = '') => 0.0180792193, 0.0180792193),
      (s_L79_adls_per_addr_c6_i > 4.5) => 0.1023248535,
      (s_L79_adls_per_addr_c6_i = NULL) => 0.0223944788, 0.0223944788),
   (pf_ship_method = '') => -0.0027478697, -0.0027478697),
(b_inq_lnames_per_addr_i > 8.5) => 0.0585618834,
(b_inq_lnames_per_addr_i = NULL) => -0.0505235588, -0.0075687379);

// Tree: 68 
final_score_68 := map(
(NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 198.5) => 
      map(
      (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 53.5) => -0.0234432102,
      (btst_distphone2addr2_i > 53.5) => 0.0648747422,
      (btst_distphone2addr2_i = NULL) => 0.0020422285, -0.0063383580),
   ((real)BT_cen_span_lang > 198.5) => 0.0817271890,
   ((real)BT_cen_span_lang = NULL) => -0.0506156847, -0.0094104405),
(s_P85_Phn_Not_Issued_i > 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB']) => -0.0174606023,
   (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0984914592,
   (final_model_segment = '') => 0.0228952622, 0.0228952622),
(s_P85_Phn_Not_Issued_i = NULL) => -0.0283134801, -0.0098568755);

// Tree: 69 
final_score_69 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
      map(
      (NULL < s_util_add_input_inf_n and s_util_add_input_inf_n <= 0.5) => -0.0012875811,
      (s_util_add_input_inf_n > 0.5) => 
         map(
         (NULL < b_nap_phn_verd_d and b_nap_phn_verd_d <= 0.5) => 0.1458648983,
         (b_nap_phn_verd_d > 0.5) => -0.0110893489,
         (b_nap_phn_verd_d = NULL) => 0.0285509729, 0.0285509729),
      (s_util_add_input_inf_n = NULL) => -0.0006853011, -0.0006853011),
   (b_inq_lnames_per_addr_i > 8.5) => 0.0772320317,
   (b_inq_lnames_per_addr_i = NULL) => -0.0505201134, -0.0038966985),
(s_inq_ssns_per_addr_i > 5.5) => -0.0367651762,
(s_inq_ssns_per_addr_i = NULL) => -0.0500994759, -0.0059862300);

// Tree: 70 
final_score_70 := map(
(NULL < s_mos_liens_rel_OT_lseen_d and s_mos_liens_rel_OT_lseen_d <= 37.5) => 0.2450524367,
(s_mos_liens_rel_OT_lseen_d > 37.5) => -0.0022163720,
(s_mos_liens_rel_OT_lseen_d = NULL) => 
   map(
   (pf_avs_result in ['Error/Inval','Full Match','Not Supported','Unavailable','Zip Only']) => -0.0127156012,
   (pf_avs_result in ['Addr Only','International','No Match']) => 
      map(
      (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 60.1) => 0.1359120581,
      ((real)ST_cen_civ_emp > 60.1) => 
         map(
         (NULL < pf_order_amt_c and pf_order_amt_c <= 855.05) => 0.0633396210,
         (pf_order_amt_c > 855.05) => -0.0411007271,
         (pf_order_amt_c = NULL) => 0.0005472645, 0.0005472645),
      ((real)ST_cen_civ_emp = NULL) => 0.0472997635, 0.0472997635),
   (pf_avs_result = '') => -0.0071794747, -0.0071794747), -0.0022041809);

// Tree: 71 
final_score_71 := map(
(NULL < b_inq_adls_per_phone_i and b_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < (real)ST_cen_vacant_p and (real)ST_cen_vacant_p <= 3.05) => -0.0463922346,
   ((real)ST_cen_vacant_p > 3.05) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 22608) => 0.1014413882,
      (b_L80_Inp_AVM_AutoVal_d > 22608) => 
         map(
         (NULL < s_mos_liens_rel_OT_lseen_d and s_mos_liens_rel_OT_lseen_d <= 80.5) => 0.4001090076,
         (s_mos_liens_rel_OT_lseen_d > 80.5) => 0.0155068171,
         (s_mos_liens_rel_OT_lseen_d = NULL) => 0.0535682762, 0.0231332878),
      (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0100860196, 0.0023349985),
   ((real)ST_cen_vacant_p = NULL) => 0.0026640781, -0.0037794144),
(b_inq_adls_per_phone_i > 2.5) => 0.0735212551,
(b_inq_adls_per_phone_i = NULL) => -0.0360795731, -0.0075829891);

// Tree: 72 
final_score_72 := map(
(NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 2316.5) => -0.0114845971,
(b_P88_Phn_Dst_to_Inp_Add_i > 2316.5) => 0.1166085520,
(b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
   map(
   (NULL < s_util_add_input_inf_n and s_util_add_input_inf_n <= 0.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0055487637,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH']) => 
         map(
         (NULL < b_I60_inq_mortgage_recency_d and b_I60_inq_mortgage_recency_d <= 549) => 0.1791648151,
         (b_I60_inq_mortgage_recency_d > 549) => 0.0286840900,
         (b_I60_inq_mortgage_recency_d = NULL) => -0.0094253718, 0.0465711209),
      (final_model_segment = '') => 0.0087538969, 0.0087538969),
   (s_util_add_input_inf_n > 0.5) => 0.1775898821,
   (s_util_add_input_inf_n = NULL) => -0.0501216881, 0.0041284058), -0.0058008972);

// Tree: 73 
final_score_73 := map(
(NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 3.5) => 
   map(
   (NULL < b_nap_contradictory_i and b_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.84160647075) => 0.0021916348,
      (b_add_input_nhood_MFD_pct_i > 0.84160647075) => 0.1949397928,
      (b_add_input_nhood_MFD_pct_i = NULL) => 
         map(
         (NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 3.5) => -0.0522435457,
         (b_phones_per_addr_curr_i > 3.5) => 0.0397614163,
         (b_phones_per_addr_curr_i = NULL) => -0.0125291736, -0.0125291736), 0.0089711869),
   (b_nap_contradictory_i > 0.5) => 0.1300278353,
   (b_nap_contradictory_i = NULL) => 0.0147833591, 0.0147833591),
(pf_pmt_x_avs_lvl > 3.5) => -0.0071762791,
(pf_pmt_x_avs_lvl = NULL) => -0.0053961649, -0.0053961649);

// Tree: 74 
final_score_74 := map(
(NULL < pf_product_desc and pf_product_desc <= 1.5) => -0.0337830584,
(pf_product_desc > 1.5) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.85842580035) => 
      map(
      (NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => 0.0043596298,
      (s_srchaddrsrchcountwk_i > 0.5) => 0.0628860861,
      (s_srchaddrsrchcountwk_i = NULL) => 0.0162221190, 0.0074843669),
   (s_add_input_nhood_BUS_pct_i > 0.85842580035) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => -0.0533997947,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.2200306510,
      (final_model_segment = '') => 0.0676610133, 0.0676610133),
   (s_add_input_nhood_BUS_pct_i = NULL) => 0.0049996104, 0.0081824654),
(pf_product_desc = NULL) => -0.0073083355, -0.0073083355);

// Tree: 75 
final_score_75 := map(
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 186.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0145305745,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 0.0206549827,
   (final_model_segment = '') => -0.0089867556, -0.0089867556),
((real)ST_cen_span_lang > 186.5) => 
   map(
   (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 5.5) => 
      map(
      (NULL < s_addrchangevaluediff_d and s_addrchangevaluediff_d <= -185389.5) => 0.1616865820,
      (s_addrchangevaluediff_d > -185389.5) => -0.0137986531,
      (s_addrchangevaluediff_d = NULL) => -0.0080169399, 0.0033612093),
   (s_inq_per_addr_i > 5.5) => 0.1422562520,
   (s_inq_per_addr_i = NULL) => 0.0216058971, 0.0216058971),
((real)ST_cen_span_lang = NULL) => -0.0033657423, -0.0073889418);

// Tree: 76 
final_score_76 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 0.5) => 
      map(
      (NULL < pf_avs_no_match and pf_avs_no_match <= 0.5) => 0.0194070694,
      (pf_avs_no_match > 0.5) => 
         map(
         (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0348658434) => 0.2413559345,
         (s_add_input_nhood_BUS_pct_i > 0.0348658434) => 0.0461926722,
         (s_add_input_nhood_BUS_pct_i = NULL) => 0.0920056446, 0.0920056446),
      (pf_avs_no_match = NULL) => 0.0243062200, 0.0243062200),
   (b_C20_email_verification_d > 0.5) => -0.0121501519,
   (b_C20_email_verification_d = NULL) => -0.0013244410, -0.0008346198),
(s_inq_ssns_per_addr_i > 5.5) => -0.0328294996,
(s_inq_ssns_per_addr_i = NULL) => -0.0501148789, -0.0029595662);

// Tree: 77 
final_score_77 := map(
(pf_ship_method in ['2nd Day','Ground','Other']) => -0.0044325352,
(pf_ship_method in ['3rd Day','Next Day']) => 
   map(
   (NULL < s_P88_Phn_Dst_to_Inp_Add_i and s_P88_Phn_Dst_to_Inp_Add_i <= 695) => 0.0019777552,
   (s_P88_Phn_Dst_to_Inp_Add_i > 695) => 0.0482278129,
   (s_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < s_L79_adls_per_addr_curr_i and s_L79_adls_per_addr_curr_i <= 2.5) => 0.0186022499,
      (s_L79_adls_per_addr_curr_i > 2.5) => 
         map(
         (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.2907163276) => 0.0441934862,
         (b_add_input_mobility_index_i > 0.2907163276) => 0.2580227505,
         (b_add_input_mobility_index_i = NULL) => 0.1350709235, 0.1350709235),
      (s_L79_adls_per_addr_curr_i = NULL) => 0.0831075657, 0.0539810725), 0.0209884595),
(pf_ship_method = '') => -0.0012819644, -0.0012819644);

// Tree: 78 
final_score_78 := map(
(NULL < s_varrisktype_i and s_varrisktype_i <= 5.5) => -0.0032708163,
(s_varrisktype_i > 5.5) => 
   map(
   (NULL < s_rel_ageover40_count_d and s_rel_ageover40_count_d <= 1.5) => -0.0301032340,
   (s_rel_ageover40_count_d > 1.5) => 0.1178508084,
   (s_rel_ageover40_count_d = NULL) => 0.0562032907, 0.0562032907),
(s_varrisktype_i = NULL) => 
   map(
   (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.75) => -0.0099143681,
   ((real)ST_cen_pop_0_5_p > 12.75) => 
      map(
      (NULL < (real)BT_cen_pop_0_5_p and (real)BT_cen_pop_0_5_p <= 12.85) => 0.1713051439,
      ((real)BT_cen_pop_0_5_p > 12.85) => -0.0196385251,
      ((real)BT_cen_pop_0_5_p = NULL) => 0.0721893463, 0.0721893463),
   ((real)ST_cen_pop_0_5_p = NULL) => -0.0526186861, -0.0155540555), -0.0050609858);

// Tree: 79 
final_score_79 := map(
(NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 184.5) => -0.0059490125,
((real)BT_cen_span_lang > 184.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < s_idrisktype_i and s_idrisktype_i <= 2) => -0.0345922972,
      (s_idrisktype_i > 2) => 0.1529140939,
      (s_idrisktype_i = NULL) => -0.0597778798, -0.0216465680),
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (pf_avs_result in ['Addr Only','Full Match','Not Supported']) => 0.0140556055,
      (pf_avs_result in ['Error/Inval','International','No Match','Unavailable','Zip Only']) => 0.1990424013,
      (pf_avs_result = '') => 0.0855711194, 0.0855711194),
   (final_model_segment = '') => 0.0061984539, 0.0061984539),
((real)BT_cen_span_lang = NULL) => -0.0327866346, -0.0084246651);

// Tree: 80 
final_score_80 := map(
(NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
      map(
      (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 0.0238659159, //Hits
      (s_C20_email_verification_d > 0.5) => -0.0180949409, //Hits
      (s_C20_email_verification_d = NULL) => 0.0041634798, -0.0024450909),
   (s_inq_ssns_per_addr_i > 5.5) => -0.0242135459,
   (s_inq_ssns_per_addr_i = NULL) => -0.0501134522, -0.0029564125),
(s_P85_Phn_Invalid_i > 0.5) => 
   map(
   (NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 61.5) => -0.0535415219,
   (b_I60_inq_retail_recency_d > 61.5) => 0.1043365244,
   (b_I60_inq_retail_recency_d = NULL) => 0.0689783570, 0.0406850266),
(s_P85_Phn_Invalid_i = NULL) => -0.0237221367, -0.0033536846);

// Tree: 81 
final_score_81 := map(
(NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => -0.0075451789,
(s_C14_addrs_15yr_i > 11.5) => 
   map(
   (NULL < s_I60_credit_seeking_i and s_I60_credit_seeking_i <= 0.5) => 0.3178701117,
   (s_I60_credit_seeking_i > 0.5) => -0.0509252112,
   (s_I60_credit_seeking_i = NULL) => 0.1027395066, 0.1027395066),
(s_C14_addrs_15yr_i = NULL) => 
   map(
   (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 194227.5) => 
      map(
      (NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 0.5) => -0.0206834529,
      (s_L79_adls_per_addr_c6_i > 0.5) => 0.1194275697,
      (s_L79_adls_per_addr_c6_i = NULL) => 0.0537899735, 0.0537899735),
   (s_L80_Inp_AVM_AutoVal_d > 194227.5) => 0.0108220874,
   (s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0072912978, -0.0039501095), -0.0058916224);

// Tree: 82 
final_score_82 := map(
(NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 3.5) => 
   map(
   (NULL < s_P88_Phn_Dst_to_Inp_Add_i and s_P88_Phn_Dst_to_Inp_Add_i <= 345.5) => 0.0074682103,
   (s_P88_Phn_Dst_to_Inp_Add_i > 345.5) => 0.1760265320,
   (s_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 5.45) => -0.0046104231,
      ((real)ST_cen_unemp > 5.45) => 
         map(
         (NULL < pf_order_amt_c and pf_order_amt_c <= 913.43) => 0.1491215998,
         (pf_order_amt_c > 913.43) => 0.0032757459,
         (pf_order_amt_c = NULL) => 0.0689720765, 0.0689720765),
      ((real)ST_cen_unemp = NULL) => 0.0131068382, 0.0131068382), 0.0164678751),
(pf_pmt_x_avs_lvl > 3.5) => -0.0064879466,
(pf_pmt_x_avs_lvl = NULL) => -0.0046187028, -0.0046187028);

// Tree: 83 
final_score_83 := map(
(NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 2403.5) => 
   map(
   (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 64.5) => -0.0230306162,
   (btst_distphone2addr2_i > 64.5) => 
      map(
      (bf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => -0.0135956558,
      (bf_seg_FraudPoint_3_0 in ['2: Synth ID','6: Other']) => 0.1967584529,
      (bf_seg_FraudPoint_3_0 = '') => -0.0504460178, 0.0224291393),
   (btst_distphone2addr2_i = NULL) => -0.0032444372, -0.0096629968),
(btst_distaddraddr2_i > 2403.5) => 
   map(
   (NULL < b_I60_Inq_Count12_i and b_I60_Inq_Count12_i <= 1.5) => 0.1751987641,
   (b_I60_Inq_Count12_i > 1.5) => -0.0507572201,
   (b_I60_Inq_Count12_i = NULL) => 0.0673098707, 0.0673098707),
(btst_distaddraddr2_i = NULL) => -0.0089698007, -0.0089698007);

// Tree: 84 
final_score_84 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 23.5) => 
   map(
   (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
      map(
      (NULL < s_phone_ver_experian_d and s_phone_ver_experian_d <= 0.5) => 0.0380270461,
      (s_phone_ver_experian_d > 0.5) => -0.0110669042,
      (s_phone_ver_experian_d = NULL) => -0.0072164472, 0.0046778182),
   (s_L71_Add_Business_i > 0.5) => -0.0308006785,
   (s_L71_Add_Business_i = NULL) => -0.0105431167, -0.0105431167),
(s_L79_adls_per_addr_c6_i > 23.5) => 
   map(
   (NULL < s_recent_disconnects_i and s_recent_disconnects_i <= 0.5) => 0.1256275655,
   (s_recent_disconnects_i > 0.5) => -0.0515362965,
   (s_recent_disconnects_i = NULL) => 0.0385470232, 0.0385470232),
(s_L79_adls_per_addr_c6_i = NULL) => -0.0101789111, -0.0101789111);

// Tree: 85 
final_score_85 := map(
(NULL < s_liens_rel_OT_total_amt_i and s_liens_rel_OT_total_amt_i <= 17778) => 
   map(
   (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 53.5) => -0.0161632011,
   (btst_distphone2addr2_i > 53.5) => 0.1006854193,
   (btst_distphone2addr2_i = NULL) => -0.0062408481, -0.0083878999),
(s_liens_rel_OT_total_amt_i > 17778) => 0.3308945147,
(s_liens_rel_OT_total_amt_i = NULL) => 
   map(
   (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.35) => -0.0106726551,
   ((real)ST_cen_pop_0_5_p > 12.35) => 
      map(
      (NULL < b_add_input_nhood_SFD_pct_d and b_add_input_nhood_SFD_pct_d <= 0.771995772) => 0.0234246862,
      (b_add_input_nhood_SFD_pct_d > 0.771995772) => 0.1551975878,
      (b_add_input_nhood_SFD_pct_d = NULL) => 0.0573867742, 0.0573867742),
   ((real)ST_cen_pop_0_5_p = NULL) => -0.0171909939, -0.0080370635), -0.0072873787);

// Tree: 86 
final_score_86 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < s_I60_inq_hiRiskCred_count12_i and s_I60_inq_hiRiskCred_count12_i <= 1.5) => -0.0015536298,
   (s_I60_inq_hiRiskCred_count12_i > 1.5) => 0.1455429492,
   (s_I60_inq_hiRiskCred_count12_i = NULL) => 
      map(
      (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.35) => -0.0083021232,
      ((real)ST_cen_pop_0_5_p > 12.35) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH']) => -0.0175639151,
         (final_model_segment in ['BUS  ADDR-         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.1223005076,
         (final_model_segment = '') => 0.0283055999, 0.0283055999),
      ((real)ST_cen_pop_0_5_p = NULL) => -0.0055330965, -0.0055330965), -0.0017158786),
(s_inq_ssns_per_addr_i > 5.5) => -0.0404290129,
(s_inq_ssns_per_addr_i = NULL) => -0.0500682569, -0.0038242596);

// Tree: 87 
final_score_87 := map(
(NULL < pf_product_desc and pf_product_desc <= 1.5) => -0.0344312780,
(pf_product_desc > 1.5) => 
   map(
   (pf_ship_method in ['2nd Day','Ground','Other']) => 0.0051291817,
   (pf_ship_method in ['3rd Day','Next Day']) => 
      map(
      (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 8.55) => 0.1486226758,
      ((real)ST_cen_high_ed > 8.55) => 
         map(
         (NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 1.5) => 0.0698011743,
         (b_C20_email_verification_d > 1.5) => 0.0027541956,
         (b_C20_email_verification_d = NULL) => 0.0138837997, 0.0229579965),
      ((real)ST_cen_high_ed = NULL) => 0.0321298313, 0.0321298313),
   (pf_ship_method = '') => 0.0083072686, 0.0083072686),
(pf_product_desc = NULL) => -0.0076248216, -0.0076248216);

// Tree: 88 
final_score_88 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => -0.0010994825,
      (s_srchaddrsrchcountwk_i > 0.5) => 
         map(
         (NULL < b_phone_ver_insurance_d and b_phone_ver_insurance_d <= 3.5) => 0.0499911436,
         (b_phone_ver_insurance_d > 3.5) => -0.0275918491,
         (b_phone_ver_insurance_d = NULL) => 0.0168177260, 0.0168177260),
      (s_srchaddrsrchcountwk_i = NULL) => -0.0033548737, -0.0012078350),
   (final_model_segment in ['CONS ADDR+ DIFF    OTH']) => 0.0549918353,
   (final_model_segment = '') => -0.0008707136, -0.0008707136),
(b_inq_lnames_per_addr_i > 8.5) => 0.0627225357,
(b_inq_lnames_per_addr_i = NULL) => -0.0503974343, -0.0058078532);

// Tree: 89 
final_score_89 := map(
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 157.5) => -0.0107305272,
((real)ST_cen_span_lang > 157.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 12.5) => 0.0132933544,
   (btst_distaddraddr2_i > 12.5) => 
      map(
      (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.1886846773) => 0.2230328126,
      (b_add_input_mobility_index_i > 0.1886846773) => 
         map(
         (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 5.5) => 0.0142573545,
         (s_inq_per_addr_i > 5.5) => 0.1403948830,
         (s_inq_per_addr_i = NULL) => 0.0332916212, 0.0332916212),
      (b_add_input_mobility_index_i = NULL) => 0.0562108542, 0.0562108542),
   (btst_distaddraddr2_i = NULL) => 0.0203434007, 0.0203434007),
((real)ST_cen_span_lang = NULL) => 0.0190950636, -0.0033195409);

// Tree: 90 
final_score_90 := map(
(NULL < s_curraddrmedianvalue_d and s_curraddrmedianvalue_d <= 931876) => -0.0055144164,
(s_curraddrmedianvalue_d > 931876) => 0.2657068984,
(s_curraddrmedianvalue_d = NULL) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 10.15) => 
         map(
         (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 194227.5) => 0.0733354930,
         (s_L80_Inp_AVM_AutoVal_d > 194227.5) => -0.0056102323,
         (s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0250488081, -0.0190569530),
      ((real)ST_cen_unemp > 10.15) => 0.0923744455,
      ((real)ST_cen_unemp = NULL) => -0.0201366148, -0.0169886489),
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH']) => 0.0821228742,
   (final_model_segment = '') => -0.0152439433, -0.0152439433), -0.0063911657);

// Tree: 91 
final_score_91 := map(
(NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (NULL < s_prevaddrmurderindex_i and s_prevaddrmurderindex_i <= 196.5) => -0.0068318916,
   (s_prevaddrmurderindex_i > 196.5) => 
      map(
      (NULL < (real)BT_cen_civ_emp and (real)BT_cen_civ_emp <= 62.1) => 0.3342757898,
      ((real)BT_cen_civ_emp > 62.1) => -0.0515512676,
      ((real)BT_cen_civ_emp = NULL) => 0.1394893142, 0.1394893142),
   (s_prevaddrmurderindex_i = NULL) => 0.0006230433, -0.0045868217),
(s_P85_Phn_Invalid_i > 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => -0.0113491057,
   (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0933050565,
   (final_model_segment = '') => 0.0237154332, 0.0237154332),
(s_P85_Phn_Invalid_i = NULL) => -0.0508347966, -0.0063538248);

// Tree: 92 
final_score_92 := map(
(NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 0.5) => 
   map(
   (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 0.0115011681,
   (pf_ship_method in ['Next Day']) => 
      map(
      (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 26.2) => 
         map(
         (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.10625882095) => 0.1935491898,
         (s_add_input_nhood_BUS_pct_i > 0.10625882095) => 0.0706848205,
         (s_add_input_nhood_BUS_pct_i = NULL) => 0.1321170051, 0.1321170051),
      ((real)ST_cen_high_ed > 26.2) => -0.0007068406,
      ((real)ST_cen_high_ed = NULL) => 0.0486825316, 0.0486825316),
   (pf_ship_method = '') => 0.0148030336, 0.0148030336),
(b_C20_email_verification_d > 0.5) => -0.0197838050,
(b_C20_email_verification_d = NULL) => -0.0012633242, -0.0059675529);

// Tree: 93 
final_score_93 := map(
(NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0270832958,
(pf_product_desc > 2.5) => 
   map(
   (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
      map(
      (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 1.5) => 
         map(
         (pf_ship_method in ['2nd Day','3rd Day','Ground']) => 0.0435982647,
         (pf_ship_method in ['Next Day','Other']) => 0.0967076991,
         (pf_ship_method = '') => 0.0480628736, 0.0480628736),
      (s_C20_email_verification_d > 1.5) => -0.0048832967,
      (s_C20_email_verification_d = NULL) => 0.0305342306, 0.0188217280),
   (s_L71_Add_Business_i > 0.5) => -0.0175746467,
   (s_L71_Add_Business_i = NULL) => 0.0048569683, 0.0048569683),
(pf_product_desc = NULL) => -0.0098622802, -0.0098622802);

// Tree: 94 
final_score_94 := map(
(NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => -0.0017730054,
(s_srchaddrsrchcountwk_i > 0.5) => 
   map(
   (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 4.65) => -0.0222228223,
   ((real)ST_cen_unemp > 4.65) => 0.1584676425,
   ((real)ST_cen_unemp = NULL) => 0.0368919594, 0.0368919594),
(s_srchaddrsrchcountwk_i = NULL) => 
   map(
   (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.75) => -0.0067337688,
   ((real)ST_cen_pop_0_5_p > 12.75) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 0.0215177646,
      (final_model_segment in ['BUS  ADDR-         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.1232827527,
      (final_model_segment = '') => 0.0570658084, 0.0570658084),
   ((real)ST_cen_pop_0_5_p = NULL) => -0.0533796144, -0.0142977435), -0.0038454000);

// Tree: 95 
final_score_95 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0019658545,
(final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
   map(
   (NULL < b_phone_ver_experian_d and b_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 587.695) => 
         map(
         (NULL < s_util_add_input_conv_n and s_util_add_input_conv_n <= 0.5) => 0.0384475249,
         (s_util_add_input_conv_n > 0.5) => 0.1833097542,
         (s_util_add_input_conv_n = NULL) => 0.1079136232, 0.1079136232),
      (pf_order_amt_c > 587.695) => 0.0056246842,
      (pf_order_amt_c = NULL) => 0.0455594069, 0.0455594069),
   (b_phone_ver_experian_d > 0.5) => -0.0031214959,
   (b_phone_ver_experian_d = NULL) => 0.0098397219, 0.0123675262),
(final_model_segment = '') => -0.0004369838, -0.0004369838);

// Tree: 96 
final_score_96 := map(
(NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (NULL < b_inq_Retail_count24_i and b_inq_Retail_count24_i <= 0.5) => 
      map(
      (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 45) => -0.0006245081,
      (btst_distaddraddr2_i > 45) => 0.0534729953,
      (btst_distaddraddr2_i = NULL) => 0.0034320954, 0.0034320954),
   (b_inq_Retail_count24_i > 0.5) => -0.0338902741,
   (b_inq_Retail_count24_i = NULL) => -0.0034824751, -0.0105633639),
(s_P85_Phn_Invalid_i > 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR+ DIFF    WEB']) => -0.0518861362,
   (final_model_segment in ['BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0707268360,
   (final_model_segment = '') => 0.0131054392, 0.0131054392),
(s_P85_Phn_Invalid_i = NULL) => -0.0504672701, -0.0120908324);

// Tree: 97 
final_score_97 := map(
(NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 17.5) => 
   map(
   (NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 18.5) => 0.1114722509,
   (s_mos_liens_unrel_OT_lseen_d > 18.5) => -0.0047367417,
   (s_mos_liens_unrel_OT_lseen_d = NULL) => 
      map(
      (NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 168.5) => -0.0056154697,
      ((real)BT_cen_trailer > 168.5) => 
         map(
         (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.13679597505) => 0.1408280297,
         (b_add_input_nhood_BUS_pct_i > 0.13679597505) => -0.0517405955,
         (b_add_input_nhood_BUS_pct_i = NULL) => 0.0709229808, 0.0709229808),
      ((real)BT_cen_trailer = NULL) => -0.0512776702, -0.0185967695), -0.0069602030),
(b_phones_per_addr_c6_i > 17.5) => 0.1190663592,
(b_phones_per_addr_c6_i = NULL) => -0.0064467161, -0.0064467161);

// Tree: 98 
final_score_98 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 7.5) => 
      map(
      (NULL < b_P85_Phn_Invalid_i and b_P85_Phn_Invalid_i <= 0.5) => -0.0019522393,
      (b_P85_Phn_Invalid_i > 0.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB']) => -0.0311241271,
         (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0933276743,
         (final_model_segment = '') => 0.0182905587, 0.0182905587),
      (b_P85_Phn_Invalid_i = NULL) => 0.0137434214, -0.0012943644),
   (b_inq_lnames_per_addr_i > 7.5) => 0.0446220498,
   (b_inq_lnames_per_addr_i = NULL) => -0.0505095266, -0.0043925300),
(s_inq_ssns_per_addr_i > 5.5) => -0.0275537779,
(s_inq_ssns_per_addr_i = NULL) => -0.0500650734, -0.0064003314);

// Tree: 99 
final_score_99 := map(
(NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.8419082633) => 
   map(
   (NULL < s_rel_homeover300_count_d and s_rel_homeover300_count_d <= 27.5) => -0.0087582441,
   (s_rel_homeover300_count_d > 27.5) => 0.1424656184,
   (s_rel_homeover300_count_d = NULL) => 0.0027563258, -0.0049299949),
(s_add_input_nhood_MFD_pct_i > 0.8419082633) => 
   map(
   (NULL < (real)ST_cen_families and (real)ST_cen_families <= 571) => 
      map(
      (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 7.5) => -0.0033927988,
      (s_inq_per_addr_i > 7.5) => 0.1039782550,
      (s_inq_per_addr_i = NULL) => 0.0081179820, 0.0081179820),
   ((real)ST_cen_families > 571) => 0.2210701662,
   ((real)ST_cen_families = NULL) => 0.0305516241, 0.0305516241),
(s_add_input_nhood_MFD_pct_i = NULL) => -0.0135312645, -0.0048511541);

// Tree: 100 
final_score_100 := map(
(NULL < s_I60_inq_hiRiskCred_count12_i and s_I60_inq_hiRiskCred_count12_i <= 1.5) => 0.0006170454,
(s_I60_inq_hiRiskCred_count12_i > 1.5) => 0.1247785739,
(s_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 0.5) => -0.0085539081,
   (s_inq_ssns_per_addr_i > 0.5) => 
      map(
      (pf_pmt_type in ['American Express','Credit Terms','Dell Credit Card','Diners Club','Gift Card']) => -0.0309885873,
      (pf_pmt_type in ['Discover','Mastercard','Other','Prepaid Check','Visa']) => 
         map(
         (NULL < (real)BT_cen_rental and (real)BT_cen_rental <= 105) => 0.1265170627,
         ((real)BT_cen_rental > 105) => 0.0143210445,
         ((real)BT_cen_rental = NULL) => 0.0634855918, 0.0634855918),
      (pf_pmt_type = '') => 0.0127979340, 0.0127979340),
   (s_inq_ssns_per_addr_i = NULL) => -0.0500934920, -0.0146528255), -0.0018866232);

// Tree: 101 
final_score_101 := map(
(NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => 
   map(
   (NULL < b_P85_Phn_Not_Issued_i and b_P85_Phn_Not_Issued_i <= 0.5) => -0.0020765032,
   (b_P85_Phn_Not_Issued_i > 0.5) => 0.0477550126,
   (b_P85_Phn_Not_Issued_i = NULL) => -0.0509328516, -0.0030556636),
(s_srchaddrsrchcountwk_i > 0.5) => 
   map(
   (NULL < s_phone_ver_insurance_d and s_phone_ver_insurance_d <= 3.5) => 
      map(
      (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 28.65) => 0.1017815587,
      ((real)ST_cen_high_ed > 28.65) => -0.0225818509,
      ((real)ST_cen_high_ed = NULL) => 0.0360801347, 0.0360801347),
   (s_phone_ver_insurance_d > 3.5) => -0.0123754605,
   (s_phone_ver_insurance_d = NULL) => 0.0201327236, 0.0201327236),
(s_srchaddrsrchcountwk_i = NULL) => -0.0039696860, -0.0030073185);

// Tree: 102 
final_score_102 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 57) => 
   map(
   (NULL < b_inq_adls_per_phone_i and b_inq_adls_per_phone_i <= 2.5) => 
      map(
      (pf_pmt_type in ['American Express','Dell Credit Card','Diners Club','Discover','Gift Card','Other','Prepaid Check']) => -0.0269484094,
      (pf_pmt_type in ['Credit Terms','Mastercard','Visa']) => 
         map(
         (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0252424876,
         (pf_product_desc > 2.5) => 0.0238924280,
         (pf_product_desc = NULL) => 0.0014463643, 0.0014463643),
      (pf_pmt_type = '') => -0.0085351696, -0.0085351696),
   (b_inq_adls_per_phone_i > 2.5) => 0.0502876520,
   (b_inq_adls_per_phone_i = NULL) => -0.0438809414, -0.0127837780),
(s_L79_adls_per_addr_c6_i > 57) => 0.0679097540,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0123470397, -0.0123470397);

// Tree: 103 
final_score_103 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => -0.0053357369,
   (s_C14_addrs_15yr_i > 11.5) => 0.1352046767,
   (s_C14_addrs_15yr_i = NULL) => 
      map(
      (NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 168.5) => -0.0017459372,
      ((real)BT_cen_trailer > 168.5) => 
         map(
         (NULL < b_L71_Add_Business_i and b_L71_Add_Business_i <= 0.5) => 0.2042163131,
         (b_L71_Add_Business_i > 0.5) => -0.0512595363,
         (b_L71_Add_Business_i = NULL) => 0.0585152427, 0.0585152427),
      ((real)BT_cen_trailer = NULL) => 0.0021418809, 0.0021418809), -0.0030067703),
(b_inq_lnames_per_addr_i > 8.5) => 0.0449037078,
(b_inq_lnames_per_addr_i = NULL) => -0.0504022865, -0.0077025629);

// Tree: 104 
final_score_104 := map(
(NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.84160647075) => 
   map(
   (NULL < s_curraddrcrimeindex_i and s_curraddrcrimeindex_i <= 194.5) => 0.0004171244,
   (s_curraddrcrimeindex_i > 194.5) => 0.1928042783,
   (s_curraddrcrimeindex_i = NULL) => -0.0091365055, -0.0006181330),
(s_add_input_nhood_MFD_pct_i > 0.84160647075) => 
   map(
   (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 157.5) => 
      map(
      (NULL < pf_avs_no_match and pf_avs_no_match <= 0.5) => 0.0165078226,
      (pf_avs_no_match > 0.5) => 0.0979342987,
      (pf_avs_no_match = NULL) => 0.0231134025, 0.0231134025),
   ((real)ST_cen_easiqlife > 157.5) => 0.1615774385,
   ((real)ST_cen_easiqlife = NULL) => 0.0336877453, 0.0336877453),
(s_add_input_nhood_MFD_pct_i = NULL) => -0.0083267959, -0.0003223252);

// Tree: 105 
final_score_105 := map(
(NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 5.5) => 
   map(
   (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
      map(
      (NULL < (real)BT_cen_easiqlife and (real)BT_cen_easiqlife <= 134.5) => -0.0019909029,
      ((real)BT_cen_easiqlife > 134.5) => 
         map(
         (NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 3.5) => 0.0773920507,
         (pf_pmt_x_avs_lvl > 3.5) => 0.0223962348,
         (pf_pmt_x_avs_lvl = NULL) => 0.0273682931, 0.0273682931),
      ((real)BT_cen_easiqlife = NULL) => -0.0236445802, 0.0054451327),
   (s_L71_Add_Business_i > 0.5) => -0.0264406072,
   (s_L71_Add_Business_i = NULL) => -0.0074233687, -0.0074233687),
(s_inq_adls_per_addr_i > 5.5) => -0.0348686286,
(s_inq_adls_per_addr_i = NULL) => -0.0500571074, -0.0093823023);

// Tree: 106 
final_score_106 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 1.5) => -0.0373145433,
   (pf_product_desc > 1.5) => 
      map(
      (NULL < (real)BT_cen_families and (real)BT_cen_families <= 964.5) => 0.0080271824,
      ((real)BT_cen_families > 964.5) => 
         map(
         (NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 89.65) => 0.0471177147,
         ((real)BT_cen_ownocc_p > 89.65) => 0.2122186562,
         ((real)BT_cen_ownocc_p = NULL) => 0.0703060492, 0.0703060492),
      ((real)BT_cen_families = NULL) => -0.0107057480, 0.0102307633),
   (pf_product_desc = NULL) => -0.0079014595, -0.0079014595),
(s_inq_ssns_per_addr_i > 5.5) => -0.0305493414,
(s_inq_ssns_per_addr_i = NULL) => -0.0500785530, -0.0096802982);

// Tree: 107 
final_score_107 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 193.5) => 0.0012728314,
   ((real)ST_cen_very_rich > 193.5) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0771244181) => 
         map(
         (NULL < (real)ST_cen_families and (real)ST_cen_families <= 352.5) => 0.0209609558,
         ((real)ST_cen_families > 352.5) => 0.2822272334,
         ((real)ST_cen_families = NULL) => 0.1488725709, 0.1488725709),
      (s_add_input_nhood_BUS_pct_i > 0.0771244181) => -0.0509959227,
      (s_add_input_nhood_BUS_pct_i = NULL) => 0.0350461194, 0.0350461194),
   ((real)ST_cen_very_rich = NULL) => 0.0475928199, 0.0026231785),
(s_inq_ssns_per_addr_i > 5.5) => -0.0386564746,
(s_inq_ssns_per_addr_i = NULL) => -0.0500490268, 0.0002044853);

// Tree: 108 
final_score_108 := map(
(NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 30177) => 0.0983170085,
(b_L80_Inp_AVM_AutoVal_d > 30177) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 35.5) => 0.0037680036,
   (btst_distaddraddr2_i > 35.5) => 
      map(
      (NULL < (real)ST_cen_health and (real)ST_cen_health <= 2.15) => 
         map(
         (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 59.9) => 0.2070339049,
         ((real)ST_cen_civ_emp > 59.9) => 0.0770772215,
         ((real)ST_cen_civ_emp = NULL) => 0.1343809559, 0.1343809559),
      ((real)ST_cen_health > 2.15) => 0.0318561460,
      ((real)ST_cen_health = NULL) => 0.0575379031, 0.0575379031),
   (btst_distaddraddr2_i = NULL) => 0.0084385011, 0.0084385011),
(b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0070386884, -0.0009600232);

// Tree: 109 
final_score_109 := map(
(NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 130.5) => -0.0084229518,
((real)BT_cen_trailer > 130.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.0033469896,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < b_fp_prevaddrburglaryindex_i and b_fp_prevaddrburglaryindex_i <= 30.5) => 0.1648348008,
      (b_fp_prevaddrburglaryindex_i > 30.5) => 0.0206168960,
      (b_fp_prevaddrburglaryindex_i = NULL) => 
         map(
         (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.14229754065) => 0.0972223966,
         (b_add_input_nhood_BUS_pct_i > 0.14229754065) => -0.0070175772,
         (b_add_input_nhood_BUS_pct_i = NULL) => 0.0411605620, 0.0411605620), 0.0418317583),
   (final_model_segment = '') => 0.0120079667, 0.0120079667),
((real)BT_cen_trailer = NULL) => -0.0432750172, -0.0079726681);

// Tree: 110 
final_score_110 := map(
(NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 1.22597271145) => 
   map(
   (NULL < s_srchaddrsrchcountmo_i and s_srchaddrsrchcountmo_i <= 1.5) => -0.0074958801,
   (s_srchaddrsrchcountmo_i > 1.5) => 
      map(
      (NULL < b_add_curr_nhood_VAC_pct_i and b_add_curr_nhood_VAC_pct_i <= 0.00994965775) => -0.0100833840,
      (b_add_curr_nhood_VAC_pct_i > 0.00994965775) => 
         map(
         (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 2.5) => 0.0696840065,
         (s_inq_per_phone_i > 2.5) => -0.0201565153,
         (s_inq_per_phone_i = NULL) => 0.0280505939, 0.0280505939),
      (b_add_curr_nhood_VAC_pct_i = NULL) => 0.0102985697, 0.0102985697),
   (s_srchaddrsrchcountmo_i = NULL) => -0.0077876346, -0.0072862350),
(s_add_input_mobility_index_i > 1.22597271145) => 0.0714967358,
(s_add_input_mobility_index_i = NULL) => 0.0485424957, -0.0065428529);

// Tree: 111 
final_score_111 := map(
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (btst_email_topleveldomain_n in ['BIZ','COM','EDU','GOV','NET','ORG','US']) => -0.0078029182,
   (btst_email_topleveldomain_n in ['MIL','OTH']) => 0.1122119238,
   (btst_email_topleveldomain_n = '') => 
      map(
      (NULL < b_I60_inq_auto_recency_d and b_I60_inq_auto_recency_d <= 4.5) => 0.1631826594,
      (b_I60_inq_auto_recency_d > 4.5) => 
         map(
         (NULL < s_add_curr_mobility_index_i and s_add_curr_mobility_index_i <= 0.69175660535) => -0.0176313690,
         (s_add_curr_mobility_index_i > 0.69175660535) => 0.0849352610,
         (s_add_curr_mobility_index_i = NULL) => -0.0028050374, -0.0143536038),
      (b_I60_inq_auto_recency_d = NULL) => -0.0310620079, -0.0170753064), -0.0106496201),
(pf_avs_result in ['International','Not Supported']) => 0.0615591531,
(pf_avs_result = '') => -0.0104212781, -0.0104212781);

// Tree: 112 
final_score_112 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (pf_pmt_type in ['American Express','Credit Terms','Dell Credit Card','Diners Club','Discover','Gift Card','Mastercard','Prepaid Check']) => -0.0124372571,
   (pf_pmt_type in ['Other','Visa']) => 
      map(
      (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0281284959,
      (pf_product_desc > 2.5) => 
         map(
         (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 192.5) => 0.0302984382,
         ((real)BT_cen_very_rich > 192.5) => 0.1960503934,
         ((real)BT_cen_very_rich = NULL) => 0.0150383852, 0.0348042387),
      (pf_product_desc = NULL) => 0.0063084901, 0.0063084901),
   (pf_pmt_type = '') => -0.0049888609, -0.0049888609),
(s_inq_ssns_per_addr_i > 5.5) => -0.0412130740,
(s_inq_ssns_per_addr_i = NULL) => -0.0500468464, -0.0069903102);

// Tree: 113 
final_score_113 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 59) => 
   map(
   (NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 549) => -0.0179419661,
   (b_I60_inq_retail_recency_d > 549) => 
      map(
      (NULL < b_nap_phn_verd_d and b_nap_phn_verd_d <= 0.5) => 
         map(
         (NULL < s_prevaddrmurderindex_i and s_prevaddrmurderindex_i <= 191.5) => 0.0325581182,
         (s_prevaddrmurderindex_i > 191.5) => 0.1838249898,
         (s_prevaddrmurderindex_i = NULL) => 0.0462241856, 0.0377300599),
      (b_nap_phn_verd_d > 0.5) => -0.0096686110,
      (b_nap_phn_verd_d = NULL) => 0.0108176854, 0.0108176854),
   (b_I60_inq_retail_recency_d = NULL) => -0.0099097579, -0.0081669021),
(b_L79_adls_per_addr_c6_i > 59) => 0.0642462248,
(b_L79_adls_per_addr_c6_i = NULL) => -0.0077705763, -0.0077705763);

// Tree: 114 
final_score_114 := map(
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 167.5) => -0.0079098680,
((real)ST_cen_span_lang > 167.5) => 
   map(
   (NULL < btst_lastscore_d and btst_lastscore_d <= 31.5) => -0.0610706801,
   (btst_lastscore_d > 31.5) => 
      map(
      (NULL < s_C12_source_profile_index_d and s_C12_source_profile_index_d <= 0.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0666360313,
         (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.1996041717,
         (final_model_segment = '') => 0.1025917019, 0.1025917019),
      (s_C12_source_profile_index_d > 0.5) => 0.0151026568,
      (s_C12_source_profile_index_d = NULL) => 0.0498386645, 0.0307140785),
   (btst_lastscore_d = NULL) => -0.0503261282, 0.0096201462),
((real)ST_cen_span_lang = NULL) => -0.0295450099, -0.0068183814);

// Tree: 115 
final_score_115 := map(
(NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 18.5) => 0.1329429585,
(s_mos_liens_unrel_OT_lseen_d > 18.5) => 
   map(
   (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 796) => -0.0071259716,
   (btst_distphone2addr2_i > 796) => 0.1285529866,
   (btst_distphone2addr2_i = NULL) => -0.0005763337, -0.0025301191),
(s_mos_liens_unrel_OT_lseen_d = NULL) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.87633312) => 
      map(
      (NULL < (real)ST_cen_mil_emp and (real)ST_cen_mil_emp <= 2.65) => -0.0066995624,
      ((real)ST_cen_mil_emp > 2.65) => 0.1073378869,
      ((real)ST_cen_mil_emp = NULL) => -0.0500854998, -0.0146863011),
   (s_add_input_nhood_BUS_pct_i > 0.87633312) => 0.0910804620,
   (s_add_input_nhood_BUS_pct_i = NULL) => -0.0121025318, -0.0121025318), -0.0036916542);

// Tree: 116 
final_score_116 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (NULL < s_util_add_input_inf_n and s_util_add_input_inf_n <= 0.5) => 0.0022142378,
   (s_util_add_input_inf_n > 0.5) => 
      map(
      (NULL < (real)ST_cen_business and (real)ST_cen_business <= 12.5) => 0.1538154601,
      ((real)ST_cen_business > 12.5) => 
         map(
         (NULL < b_C12_source_profile_d and b_C12_source_profile_d <= 43.8) => 0.1770966428,
         (b_C12_source_profile_d > 43.8) => -0.0533519589,
         (b_C12_source_profile_d = NULL) => 0.0084278790, 0.0084278790),
      ((real)ST_cen_business = NULL) => 0.0323403101, 0.0323403101),
   (s_util_add_input_inf_n = NULL) => 0.0028057384, 0.0028057384),
(s_inq_ssns_per_addr_i > 4.5) => -0.0413988950,
(s_inq_ssns_per_addr_i = NULL) => -0.0500576468, 0.0002582418);

// Tree: 117 
final_score_117 := map(
(NULL < b_mos_liens_unrel_ST_fseen_d and b_mos_liens_unrel_ST_fseen_d <= 62.5) => 0.2250871319,
(b_mos_liens_unrel_ST_fseen_d > 62.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < b_inq_adls_per_phone_i and b_inq_adls_per_phone_i <= 2.5) => 
         map(
         (NULL < btst_distphoneaddr_i and btst_distphoneaddr_i <= 108.5) => -0.0101483558,
         (btst_distphoneaddr_i > 108.5) => 0.1034042477,
         (btst_distphoneaddr_i = NULL) => -0.0011395982, -0.0040867700),
      (b_inq_adls_per_phone_i > 2.5) => 0.0674834786,
      (b_inq_adls_per_phone_i = NULL) => 0.0040319061, -0.0034273523),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0689752942,
   (final_model_segment = '') => -0.0029928484, -0.0029928484),
(b_mos_liens_unrel_ST_fseen_d = NULL) => 0.0005419133, -0.0015094444);

// Tree: 118 
final_score_118 := map(
(NULL < s_liens_rel_OT_total_amt_i and s_liens_rel_OT_total_amt_i <= 18694) => -0.0056122588,
(s_liens_rel_OT_total_amt_i > 18694) => 0.1747220975,
(s_liens_rel_OT_total_amt_i = NULL) => 
   map(
   (NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 171.5) => 
      map(
      (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 194227.5) => 0.0676678609,
      (s_L80_Inp_AVM_AutoVal_d > 194227.5) => -0.0121138433,
      (s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0159429736, -0.0116697050),
   ((real)BT_cen_trailer > 171.5) => 
      map(
      (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 0.1446839635,
      (s_L71_Add_Business_i > 0.5) => -0.0550649419,
      (s_L71_Add_Business_i = NULL) => 0.0314929171, 0.0314929171),
   ((real)BT_cen_trailer = NULL) => -0.0505720900, -0.0242124134), -0.0086699440);

// Tree: 119 
final_score_119 := map(
(NULL < b_varmsrcssnunrelcount_i and b_varmsrcssnunrelcount_i <= 1.5) => 
   map(
   (NULL < s_mos_liens_rel_OT_lseen_d and s_mos_liens_rel_OT_lseen_d <= 38.5) => 0.1143399848,
   (s_mos_liens_rel_OT_lseen_d > 38.5) => 
      map(
      (NULL < b_inq_ssns_per_addr_i and b_inq_ssns_per_addr_i <= 4.5) => 0.0006995945,
      (b_inq_ssns_per_addr_i > 4.5) => -0.0568329026,
      (b_inq_ssns_per_addr_i = NULL) => 0.0004317345, 0.0004317345),
   (s_mos_liens_rel_OT_lseen_d = NULL) => 
      map(
      (pf_pmt_type in ['American Express','Credit Terms','Dell Credit Card','Gift Card','Mastercard','Other','Prepaid Check','Visa']) => -0.0180075568,
      (pf_pmt_type in ['Diners Club','Discover']) => 0.1048178767,
      (pf_pmt_type = '') => -0.0116963686, -0.0116963686), -0.0000620643),
(b_varmsrcssnunrelcount_i > 1.5) => 0.1601097737,
(b_varmsrcssnunrelcount_i = NULL) => -0.0039408641, -0.0002643647);

// Tree: 120 
final_score_120 := map(
(NULL < b_util_add_input_inf_n and b_util_add_input_inf_n <= 0.5) => 
   map(
   (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 75) => -0.0105924238,
   (btst_distphone2addr2_i > 75) => 0.0716508014,
   (btst_distphone2addr2_i = NULL) => -0.0029886971, -0.0048307585),
(b_util_add_input_inf_n > 0.5) => 
   map(
   (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.110508819) => 
      map(
      (NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 0.34347785095) => -0.0391957244,
      (s_add_input_mobility_index_i > 0.34347785095) => 0.0662865408,
      (s_add_input_mobility_index_i = NULL) => -0.0118186479, -0.0118186479),
   (b_add_input_nhood_BUS_pct_i > 0.110508819) => 0.1706272207,
   (b_add_input_nhood_BUS_pct_i = NULL) => 0.0300802580, 0.0300802580),
(b_util_add_input_inf_n = NULL) => -0.0502783042, -0.0089000760);

// Tree: 121 
final_score_121 := map(
(NULL < (real)BT_cen_families and (real)BT_cen_families <= 2670.5) => 
   map(
   (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
      map(
      (NULL < btst_distphoneaddr_i and btst_distphoneaddr_i <= 59.5) => -0.0020825765,
      (btst_distphoneaddr_i > 59.5) => 0.0938129395,
      (btst_distphoneaddr_i = NULL) => 
         map(
         (pf_pmt_type in ['American Express','Dell Credit Card','Diners Club','Discover','Gift Card','Mastercard','Other','Prepaid Check']) => -0.0169620889,
         (pf_pmt_type in ['Credit Terms','Visa']) => 0.0307998103,
         (pf_pmt_type = '') => 0.0046741144, 0.0046741144), 0.0031442349),
   (s_L71_Add_Business_i > 0.5) => -0.0312879707,
   (s_L71_Add_Business_i = NULL) => -0.0102902345, -0.0102902345),
((real)BT_cen_families > 2670.5) => 0.1996744038,
((real)BT_cen_families = NULL) => -0.0215546977, -0.0107617659);

// Tree: 122 
final_score_122 := map(
(NULL < b_inq_adls_per_phone_i and b_inq_adls_per_phone_i <= 2.5) => 
   map(
   (NULL < s_corrrisktype_i and s_corrrisktype_i <= 8.5) => -0.0161926414,
   (s_corrrisktype_i > 8.5) => 
      map(
      (NULL < s_rel_under25miles_cnt_d and s_rel_under25miles_cnt_d <= 0.5) => 
         map(
         (NULL < s_A46_Curr_AVM_AutoVal_d and s_A46_Curr_AVM_AutoVal_d <= 230843.5) => 0.0203843353,
         (s_A46_Curr_AVM_AutoVal_d > 230843.5) => 0.2087686953,
         (s_A46_Curr_AVM_AutoVal_d = NULL) => 0.0179493505, 0.0698356703),
      (s_rel_under25miles_cnt_d > 0.5) => 0.0103826055,
      (s_rel_under25miles_cnt_d = NULL) => -0.0250263775, 0.0149640881),
   (s_corrrisktype_i = NULL) => 0.0078539495, -0.0050228059),
(b_inq_adls_per_phone_i > 2.5) => 0.0571073807,
(b_inq_adls_per_phone_i = NULL) => -0.0256209942, -0.0073519230);

// Tree: 123 
final_score_123 := map(
(NULL < b_C14_addrs_10yr_i and b_C14_addrs_10yr_i <= 10.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0041682776,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0697013182,
   (final_model_segment = '') => -0.0037223279, -0.0037223279),
(b_C14_addrs_10yr_i > 10.5) => 0.1818425301,
(b_C14_addrs_10yr_i = NULL) => 
   map(
   (pf_avs_result in ['Error/Inval','Full Match','International','Unavailable','Zip Only']) => -0.0138908877,
   (pf_avs_result in ['Addr Only','No Match','Not Supported']) => 
      map(
      (NULL < (real)BT_cen_business and (real)BT_cen_business <= 26.5) => 0.0881967120,
      ((real)BT_cen_business > 26.5) => 0.0019042131,
      ((real)BT_cen_business = NULL) => -0.0505569240, 0.0073490828),
   (pf_avs_result = '') => -0.0119897594, -0.0119897594), -0.0048094471);

// Tree: 124 
final_score_124 := map(
(NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 5.5) => 
   map(
   (NULL < b_mos_liens_unrel_ST_lseen_d and b_mos_liens_unrel_ST_lseen_d <= 78.5) => 0.1296079405,
   (b_mos_liens_unrel_ST_lseen_d > 78.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0001244043,
      (final_model_segment in ['CONS ADDR- DIFF    OTH']) => 0.0728771993,
      (final_model_segment = '') => 0.0005292425, 0.0005292425),
   (b_mos_liens_unrel_ST_lseen_d = NULL) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 173600.5) => -0.0384227185,
      (b_L80_Inp_AVM_AutoVal_d > 173600.5) => 0.0681242281,
      (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0115420877, -0.0036835579), 0.0006711612),
(s_inq_adls_per_addr_i > 5.5) => -0.0442327033,
(s_inq_adls_per_addr_i = NULL) => -0.0500518749, -0.0016837565);

// Tree: 125 
final_score_125 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < s_inf_contradictory_i and s_inf_contradictory_i <= 0.5) => -0.0082940964,
   (s_inf_contradictory_i > 0.5) => 
      map(
      (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 184.5) => 0.0173910703,
      ((real)BT_cen_span_lang > 184.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH']) => 0.0394492605,
         (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.1333445556,
         (final_model_segment = '') => 0.0683401206, 0.0683401206),
      ((real)BT_cen_span_lang = NULL) => -0.0505424565, 0.0114215392),
   (s_inf_contradictory_i = NULL) => -0.0029044451, -0.0029044451),
(s_inq_ssns_per_addr_i > 5.5) => -0.0401260514,
(s_inq_ssns_per_addr_i = NULL) => -0.0500476013, -0.0049630343);

// Tree: 126 
final_score_126 := map(
(NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 198.5) => 
   map(
   (NULL < b_bus_phone_match_d and b_bus_phone_match_d <= 0.5) => 
      map(
      (NULL < b_phone_ver_experian_d and b_phone_ver_experian_d <= 0.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0271737500,
         (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 0.0704537499,
         (final_model_segment = '') => 0.0279383083, 0.0279383083),
      (b_phone_ver_experian_d > 0.5) => -0.0135208687,
      (b_phone_ver_experian_d = NULL) => 0.0076932672, 0.0031912286),
   (b_bus_phone_match_d > 0.5) => -0.0319221785,
   (b_bus_phone_match_d = NULL) => -0.0087653852, -0.0087653852),
((real)ST_cen_very_rich > 198.5) => 0.1320207302,
((real)ST_cen_very_rich = NULL) => 0.0220836422, -0.0068421317);

// Tree: 127 
final_score_127 := map(
(NULL < s_mos_liens_unrel_SC_fseen_d and s_mos_liens_unrel_SC_fseen_d <= 196.5) => 
   map(
   (NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 46222.5) => 0.2827121013,
   (s_curraddrmedianincome_d > 46222.5) => 0.0164993832,
   (s_curraddrmedianincome_d = NULL) => 0.0645522204, 0.0645522204),
(s_mos_liens_unrel_SC_fseen_d > 196.5) => 0.0009977265,
(s_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.8742175183) => 
      map(
      (NULL < (real)ST_cen_urban_p and (real)ST_cen_urban_p <= 16.95) => 0.1356508447,
      ((real)ST_cen_urban_p > 16.95) => -0.0137111388,
      ((real)ST_cen_urban_p = NULL) => -0.0569447279, -0.0187946645),
   (s_add_input_nhood_BUS_pct_i > 0.8742175183) => 0.0840249911,
   (s_add_input_nhood_BUS_pct_i = NULL) => -0.0158504894, -0.0158504894), -0.0012134290);

// Tree: 128 
final_score_128 := map(
(NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 147946) => -0.0075171937,
(b_L80_Inp_AVM_AutoVal_d > 147946) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 36.5) => 0.0098584590,
   (btst_distaddraddr2_i > 36.5) => 
      map(
      (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 33.3) => 
         map(
         (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 1.5) => 0.0534746218,
         (s_inq_per_addr_i > 1.5) => 0.1722813984,
         (s_inq_per_addr_i = NULL) => 0.0967730915, 0.0967730915),
      ((real)ST_cen_high_ed > 33.3) => -0.0138841589,
      ((real)ST_cen_high_ed = NULL) => 0.0432210735, 0.0432210735),
   (btst_distaddraddr2_i = NULL) => 0.0130413126, 0.0130413126),
(b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0066609714, -0.0011449992);

// Tree: 129 
final_score_129 := map(
(NULL < s_I60_inq_auto_count12_i and s_I60_inq_auto_count12_i <= 3.5) => -0.0047248512,
(s_I60_inq_auto_count12_i > 3.5) => 
   map(
   (NULL < (real)ST_cen_med_hval and (real)ST_cen_med_hval <= 254849.5) => 0.2099173045,
   ((real)ST_cen_med_hval > 254849.5) => -0.0535059131,
   ((real)ST_cen_med_hval = NULL) => 0.0756727802, 0.0756727802),
(s_I60_inq_auto_count12_i = NULL) => 
   map(
   (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 52.85) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.0142727034,
      (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0893779111,
      (final_model_segment = '') => 0.0350315962, 0.0350315962),
   ((real)ST_cen_civ_emp > 52.85) => -0.0005045719,
   ((real)ST_cen_civ_emp = NULL) => 0.0074347477, 0.0050351046), -0.0023798636);

// Tree: 130 
final_score_130 := map(
(NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 184.5) => -0.0031230354,
((real)BT_cen_span_lang > 184.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => -0.0210122429,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 0.0959219909,
      (s_C20_email_verification_d > 0.5) => 
         map(
         (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.2987190935) => -0.0541206861,
         (s_add_input_nhood_MFD_pct_i > 0.2987190935) => 0.1447029910,
         (s_add_input_nhood_MFD_pct_i = NULL) => 0.0452911524, 0.0452911524),
      (s_C20_email_verification_d = NULL) => 0.0611961279, 0.0611961279),
   (final_model_segment = '') => 0.0010785091, 0.0010785091),
((real)BT_cen_span_lang = NULL) => -0.0298500466, -0.0058932774);

// Tree: 131 
final_score_131 := map(
(NULL < b_inq_count24_i and b_inq_count24_i <= 9.5) => 
   map(
   (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 4.5) => 
      map(
      (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 46.5) => -0.0078825091,
      (btst_distaddraddr2_i > 46.5) => 0.0357329594,
      (btst_distaddraddr2_i = NULL) => -0.0049064461, -0.0049064461),
   (s_inq_per_phone_i > 4.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB']) => 0.0019924165,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.1675168110,
      (final_model_segment = '') => 0.0651226506, 0.0651226506),
   (s_inq_per_phone_i = NULL) => -0.0510647681, -0.0039169489),
(b_inq_count24_i > 9.5) => -0.0469388229,
(b_inq_count24_i = NULL) => 0.0008961326, -0.0101380852);

// Tree: 132 
final_score_132 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 1.5) => -0.0355341747,
   (pf_product_desc > 1.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0063139906,
      (final_model_segment in ['CONS ADDR- ID/RELS OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
         map(
         (NULL < pf_order_amt_c and pf_order_amt_c <= 426.61) => 0.1326782048,
         (pf_order_amt_c > 426.61) => 0.0130210902,
         (pf_order_amt_c = NULL) => 0.0292990270, 0.0292990270),
      (final_model_segment = '') => 0.0094812994, 0.0094812994),
   (pf_product_desc = NULL) => -0.0074779329, -0.0074779329),
(b_inq_lnames_per_addr_i > 8.5) => 0.0463819440,
(b_inq_lnames_per_addr_i = NULL) => -0.0502859130, -0.0117966357);

// Tree: 133 
final_score_133 := map(
(NULL < s_srchphonesrchcountwk_i and s_srchphonesrchcountwk_i <= 0.5) => 0.0003811455,
(s_srchphonesrchcountwk_i > 0.5) => 0.0858410842,
(s_srchphonesrchcountwk_i = NULL) => 
   map(
   (NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 4.5) => 
      map(
      (pf_ship_method in ['2nd Day','Ground','Other']) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0212721125,
         (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH']) => 0.1108777854,
         (final_model_segment = '') => 0.0087957013, 0.0087957013),
      (pf_ship_method in ['3rd Day','Next Day']) => 0.0931835579,
      (pf_ship_method = '') => 0.0224963180, 0.0224963180),
   (pf_pmt_x_avs_lvl > 4.5) => -0.0037730108,
   (pf_pmt_x_avs_lvl = NULL) => -0.0003271883, -0.0003271883), 0.0006521461);

// Tree: 134 
final_score_134 := map(
(NULL < b_varmsrcssnunrelcount_i and b_varmsrcssnunrelcount_i <= 1.5) => 
   map(
   (NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 23.5) => -0.0045755215,
   (s_L79_adls_per_addr_c6_i > 23.5) => 0.0878134817,
   (s_L79_adls_per_addr_c6_i = NULL) => -0.0042243661, -0.0042243661),
(b_varmsrcssnunrelcount_i > 1.5) => 0.1180371767,
(b_varmsrcssnunrelcount_i = NULL) => 
   map(
   (NULL < (real)BT_cen_low_hval and (real)BT_cen_low_hval <= 41.25) => 
      map(
      (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 10.5) => -0.0165751222,
      (btst_distphone2addr2_i > 10.5) => 0.0895718981,
      (btst_distphone2addr2_i = NULL) => -0.0074568906, -0.0061843760),
   ((real)BT_cen_low_hval > 41.25) => 0.1177119998,
   ((real)BT_cen_low_hval = NULL) => -0.0507218649, -0.0275495830), -0.0084116048);

// Tree: 135 
final_score_135 := map(
(NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.84160647075) => -0.0009703728,
(s_add_input_nhood_MFD_pct_i > 0.84160647075) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 3.5) => 0.1078559750,
      (pf_pmt_x_avs_lvl > 3.5) => 
         map(
         (NULL < s_corrrisktype_i and s_corrrisktype_i <= 5.5) => 0.2933923379,
         (s_corrrisktype_i > 5.5) => -0.0231669461,
         (s_corrrisktype_i = NULL) => -0.0510762209, 0.0077289085),
      (pf_pmt_x_avs_lvl = NULL) => 0.0169910614, 0.0169910614),
   (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH']) => 0.0988572591,
   (final_model_segment = '') => 0.0239227979, 0.0239227979),
(s_add_input_nhood_MFD_pct_i = NULL) => -0.0082074004, -0.0010191398);

// Tree: 136 
final_score_136 := map(
(NULL < s_liens_rel_OT_total_amt_i and s_liens_rel_OT_total_amt_i <= 21084) => -0.0003764347,
(s_liens_rel_OT_total_amt_i > 21084) => 0.1921540638,
(s_liens_rel_OT_total_amt_i = NULL) => 
   map(
   (pf_avs_result in ['Error/Inval','Full Match','Unavailable','Zip Only']) => 
      map(
      (NULL < (real)ST_cen_med_rent and (real)ST_cen_med_rent <= 62.5) => 0.2199127176,
      ((real)ST_cen_med_rent > 62.5) => -0.0146388932,
      ((real)ST_cen_med_rent = NULL) => -0.0508770890, -0.0183684046),
   (pf_avs_result in ['Addr Only','International','No Match','Not Supported']) => 
      map(
      (NULL < (real)ST_cen_business and (real)ST_cen_business <= 17.5) => 0.0786041026,
      ((real)ST_cen_business > 17.5) => 0.0145200071,
      ((real)ST_cen_business = NULL) => 0.0324635539, 0.0324635539),
   (pf_avs_result = '') => -0.0136638303, -0.0136638303), -0.0023403856);

// Tree: 137 
final_score_137 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 43.5) => 
   map(
   (NULL < b_inq_ssns_per_addr_i and b_inq_ssns_per_addr_i <= 4.5) => 
      map(
      (NULL < (real)BT_cen_health and (real)BT_cen_health <= 82.95) => 
         map(
         (NULL < s_mos_liens_rel_OT_lseen_d and s_mos_liens_rel_OT_lseen_d <= 30.5) => 0.0840053821,
         (s_mos_liens_rel_OT_lseen_d > 30.5) => -0.0043030766,
         (s_mos_liens_rel_OT_lseen_d = NULL) => 0.0015507801, -0.0032029707),
      ((real)BT_cen_health > 82.95) => 0.1965177312,
      ((real)BT_cen_health = NULL) => -0.0138100845, -0.0025802396),
   (b_inq_ssns_per_addr_i > 4.5) => -0.0369242177,
   (b_inq_ssns_per_addr_i = NULL) => -0.0502166458, -0.0078503874),
(b_L79_adls_per_addr_c6_i > 43.5) => 0.0644126511,
(b_L79_adls_per_addr_c6_i = NULL) => -0.0074241216, -0.0074241216);

// Tree: 138 
final_score_138 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 10.5) => 
   map(
   (pf_pmt_type in ['Dell Credit Card','Diners Club','Discover','Gift Card','Mastercard','Other']) => -0.0223866192,
   (pf_pmt_type in ['American Express','Credit Terms','Prepaid Check','Visa']) => 
      map(
      (NULL < s_assocrisktype_i and s_assocrisktype_i <= 6.5) => 0.0019596711,
      (s_assocrisktype_i > 6.5) => 
         map(
         (NULL < (real)ST_cen_health and (real)ST_cen_health <= 30.05) => 0.0363923566,
         ((real)ST_cen_health > 30.05) => 0.2335140309,
         ((real)ST_cen_health = NULL) => 0.0501004007, 0.0501004007),
      (s_assocrisktype_i = NULL) => 0.0121781703, 0.0067584877),
   (pf_pmt_type = '') => -0.0013794188, -0.0013794188),
(b_inq_lnames_per_addr_i > 10.5) => -0.0422699984,
(b_inq_lnames_per_addr_i = NULL) => -0.0502421676, -0.0066171559);

// Tree: 139 
final_score_139 := map(
(NULL < b_mos_liens_unrel_ST_lseen_d and b_mos_liens_unrel_ST_lseen_d <= 78.5) => 0.1228052646,
(b_mos_liens_unrel_ST_lseen_d > 78.5) => -0.0027849000,
(b_mos_liens_unrel_ST_lseen_d = NULL) => 
   map(
   (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 143.5) => -0.0087920304,
   ((real)BT_cen_span_lang > 143.5) => 
      map(
      (pf_ship_method in ['2nd Day','Ground','Other']) => 
         map(
         (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.1626908741) => 0.0390640791,
         (b_add_input_nhood_BUS_pct_i > 0.1626908741) => -0.0106124732,
         (b_add_input_nhood_BUS_pct_i = NULL) => 0.0106592813, 0.0106592813),
      (pf_ship_method in ['3rd Day','Next Day']) => 0.1091780506,
      (pf_ship_method = '') => 0.0279104582, 0.0279104582),
   ((real)BT_cen_span_lang = NULL) => -0.0508250895, -0.0256879830), -0.0063809173);

// Tree: 140 
final_score_140 := map(
(NULL < (real)BT_cen_med_hval and (real)BT_cen_med_hval <= 737171) => 
   map(
   (NULL < s_curraddrcartheftindex_i and s_curraddrcartheftindex_i <= 120.5) => -0.0141391440,
   (s_curraddrcartheftindex_i > 120.5) => 0.0320235497,
   (s_curraddrcartheftindex_i = NULL) => 0.0018443186, -0.0019415309),
((real)BT_cen_med_hval > 737171) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0108362023,
   (final_model_segment in ['CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < s_prevaddrageoldest_d and s_prevaddrageoldest_d <= 159) => 0.0634599336,
      (s_prevaddrageoldest_d > 159) => 0.4230804930,
      (s_prevaddrageoldest_d = NULL) => 0.1849533658, 0.1849533658),
   (final_model_segment = '') => 0.0418433684, 0.0418433684),
((real)BT_cen_med_hval = NULL) => -0.0223667875, -0.0017150474);

// Tree: 141 
final_score_141 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0079681510,
(final_model_segment in ['CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
   map(
   (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 193.5) => 
      map(
      (NULL < s_curraddrcrimeindex_i and s_curraddrcrimeindex_i <= 1.5) => 
         map(
         (NULL < (real)BT_cen_med_rent and (real)BT_cen_med_rent <= 820) => -0.0259660091,
         ((real)BT_cen_med_rent > 820) => 0.3349608752,
         ((real)BT_cen_med_rent = NULL) => 0.1673876789, 0.1673876789),
      (s_curraddrcrimeindex_i > 1.5) => 0.0068873574,
      (s_curraddrcrimeindex_i = NULL) => 0.0239641575, 0.0162784433),
   ((real)ST_cen_very_rich > 193.5) => 0.1600287258,
   ((real)ST_cen_very_rich = NULL) => 0.0207955501, 0.0207955501),
(final_model_segment = '') => -0.0041129334, -0.0041129334);

// Tree: 142 
final_score_142 := map(
(pf_avs_result in ['International','Not Supported']) => -0.0513889105,
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < s_srchaddrsrchcountmo_i and s_srchaddrsrchcountmo_i <= 1.5) => -0.0049779687,
   (s_srchaddrsrchcountmo_i > 1.5) => 
      map(
      (NULL < s_rel_criminal_count_i and s_rel_criminal_count_i <= 1.5) => -0.0260212323,
      (s_rel_criminal_count_i > 1.5) => 0.1150646947,
      (s_rel_criminal_count_i = NULL) => 0.0138508775, 0.0138508775),
   (s_srchaddrsrchcountmo_i = NULL) => 
      map(
      (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    WEB']) => -0.0308289236,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0162520240,
      (final_model_segment = '') => 0.0090202948, 0.0090202948), -0.0020218376),
(pf_avs_result = '') => -0.0021959614, -0.0021959614);

// Tree: 143 
final_score_143 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 58.5) => 
   map(
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => 
      map(
      (NULL < (real)BT_cen_retired2 and (real)BT_cen_retired2 <= 159.5) => 
         map(
         (pf_ship_method in ['Next Day']) => -0.0427372652,
         (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => -0.0219528430,
         (pf_ship_method = '') => -0.0236729331, -0.0236729331),
      ((real)BT_cen_retired2 > 159.5) => 0.0560044302,
      ((real)BT_cen_retired2 = NULL) => -0.0519694563, -0.0209015635),
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0047881771,
   (final_model_segment = '') => 0.0027898069, 0.0027898069),
(b_L79_adls_per_addr_c6_i > 58.5) => 0.0582960765,
(b_L79_adls_per_addr_c6_i = NULL) => 0.0031003503, 0.0031003503);

// Tree: 144 
final_score_144 := map(
(NULL < b_comb_age_d and b_comb_age_d <= 16.5) => 0.2036679917,
(b_comb_age_d > 16.5) => -0.0055689897,
(b_comb_age_d = NULL) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0106874215) => 0.0788989041,
   (s_add_input_nhood_BUS_pct_i > 0.0106874215) => 
      map(
      (NULL < b_inq_adls_per_addr_i and b_inq_adls_per_addr_i <= 2.5) => 
         map(
         (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 4.75) => -0.0199290550,
         ((real)ST_cen_unemp > 4.75) => 0.0434552957,
         ((real)ST_cen_unemp = NULL) => 0.0045967717, 0.0045967717),
      (b_inq_adls_per_addr_i > 2.5) => -0.0528246287,
      (b_inq_adls_per_addr_i = NULL) => -0.0502212361, -0.0255411380),
   (s_add_input_nhood_BUS_pct_i = NULL) => -0.0224899377, -0.0224899377), -0.0082497140);

// Tree: 145 
final_score_145 := map(
(NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 198.5) => 
   map(
   (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 12.35) => 
      map(
      (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 49.5) => 0.1063137011, /**GET**/
      ((real)ST_cen_easiqlife > 49.5) => -0.0069305241, //WANT
      ((real)ST_cen_easiqlife = NULL) => -0.0056246500, -0.0056246500),
   ((real)ST_cen_unemp > 12.35) => 
      map(
      (NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 0.5) => -0.0519510064,
      (s_inq_adls_per_addr_i > 0.5) => 0.1721653632,
      (s_inq_adls_per_addr_i = NULL) => 0.0237246509, 0.0237246509),
   ((real)ST_cen_unemp = NULL) => -0.0053347339, -0.0053347339),
((real)ST_cen_very_rich > 198.5) => 0.1272873907,
((real)ST_cen_very_rich = NULL) => 0.0047911800, -0.0043991451);

// Tree: 146 
final_score_146 := map(
(NULL < b_curraddrmedianvalue_d and b_curraddrmedianvalue_d <= 930012.5) => -0.0022153861,
(b_curraddrmedianvalue_d > 930012.5) => 0.1422401953,
(b_curraddrmedianvalue_d = NULL) => 
   map(
   (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 186.5) => 
      map(
      (pf_avs_result in ['Error/Inval','Full Match','Not Supported','Unavailable','Zip Only']) => -0.0089866526,
      (pf_avs_result in ['Addr Only','International','No Match']) => 
         map(
         (pf_ship_method in ['Ground']) => 0.0025006652,
         (pf_ship_method in ['2nd Day','3rd Day','Next Day','Other']) => 0.1054535151,
         (pf_ship_method = '') => 0.0340411337, 0.0340411337),
      (pf_avs_result = '') => -0.0036961003, -0.0036961003),
   ((real)BT_cen_span_lang > 186.5) => 0.0727283169,
   ((real)BT_cen_span_lang = NULL) => -0.0506421380, -0.0267211708), -0.0062172726);

// Tree: 147 
final_score_147 := map(
(NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 18.5) => 0.0928553469,
(s_mos_liens_unrel_OT_lseen_d > 18.5) => -0.0036297552,
(s_mos_liens_unrel_OT_lseen_d = NULL) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < (real)BT_cen_unemp and (real)BT_cen_unemp <= 4.95) => -0.0241687101,
      ((real)BT_cen_unemp > 4.95) => 0.0267870097,
      ((real)BT_cen_unemp = NULL) => -0.0503773805, -0.0227691499),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.06623419065) => 0.0556533031,
      (s_add_input_nhood_BUS_pct_i > 0.06623419065) => 0.0356301844,
      (s_add_input_nhood_BUS_pct_i = NULL) => 0.0447316020, 0.0447316020),
   (final_model_segment = '') => -0.0204594755, -0.0204594755), -0.0065039187);

// Tree: 148 
final_score_148 := map(
(NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
   map(
   (NULL < s_addrchangeincomediff_d and s_addrchangeincomediff_d <= -3316) => 
      map(
      (NULL < (real)ST_cen_lar_fam and (real)ST_cen_lar_fam <= 157.5) => 
         map(
         (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 14.5) => 0.1822267241,
         ((real)BT_cen_no_move > 14.5) => 0.0176591033,
         ((real)BT_cen_no_move = NULL) => -0.0502114716, 0.0337255431),
      ((real)ST_cen_lar_fam > 157.5) => 0.2082096039,
      ((real)ST_cen_lar_fam = NULL) => 0.0449825793, 0.0449825793),
   (s_addrchangeincomediff_d > -3316) => 0.0024657830,
   (s_addrchangeincomediff_d = NULL) => 0.0110835046, 0.0080551189),
(s_L71_Add_Business_i > 0.5) => -0.0238792619,
(s_L71_Add_Business_i = NULL) => -0.0056124225, -0.0056124225);

// Tree: 149 
final_score_149 := map(
(NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1844.5) => -0.0055088695,
   (b_P88_Phn_Dst_to_Inp_Add_i > 1844.5) => 0.0867009345,
   (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0081125231,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH']) => 0.0349824477,
      (final_model_segment = '') => -0.0029750655, -0.0029750655), -0.0042587304),
(s_P85_Phn_Not_Issued_i > 0.5) => 
   map(
   (NULL < s_fp_prevaddrburglaryindex_i and s_fp_prevaddrburglaryindex_i <= 63.5) => -0.0521418302,
   (s_fp_prevaddrburglaryindex_i > 63.5) => 0.1135761498,
   (s_fp_prevaddrburglaryindex_i = NULL) => 0.0181012038, 0.0321697601),
(s_P85_Phn_Not_Issued_i = NULL) => -0.0507932915, -0.0059090379);

// Tree: 150 
final_score_150 := map(
(NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 549) => -0.0109329213,
(b_I60_inq_retail_recency_d > 549) => 
   map(
   (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.9617311716) => 
      map(
      (NULL < s_mos_liens_unrel_SC_fseen_d and s_mos_liens_unrel_SC_fseen_d <= 194) => 0.1559812143,
      (s_mos_liens_unrel_SC_fseen_d > 194) => 0.0165797242,
      (s_mos_liens_unrel_SC_fseen_d = NULL) => 
         map(
         (NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 0.5) => -0.0338099091,
         (s_inq_adls_per_addr_i > 0.5) => 0.0796542070,
         (s_inq_adls_per_addr_i = NULL) => -0.0015452315, -0.0015452315), 0.0182114128),
   (s_add_input_nhood_MFD_pct_i > 0.9617311716) => 0.1311496033,
   (s_add_input_nhood_MFD_pct_i = NULL) => 0.0067881309, 0.0177895208),
(b_I60_inq_retail_recency_d = NULL) => -0.0091695449, -0.0026338166);

// Tree: 151 
final_score_151 := map(
(NULL < s_varrisktype_i and s_varrisktype_i <= 7.5) => -0.0013345226,
(s_varrisktype_i > 7.5) => 0.1315638093,
(s_varrisktype_i = NULL) => 
   map(
   (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 179534) => 
      map(
      (NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 0.5) => -0.0561475496,
      (s_inq_adls_per_addr_i > 0.5) => 0.0735060666,
      (s_inq_adls_per_addr_i = NULL) => -0.0104741167, -0.0104741167),
   (b_L80_Inp_AVM_AutoVal_d > 179534) => 
      map(
      (NULL < (real)BT_cen_high_hval and (real)BT_cen_high_hval <= 9.45) => 0.1495080884,
      ((real)BT_cen_high_hval > 9.45) => 0.0048141428,
      ((real)BT_cen_high_hval = NULL) => 0.0522307398, 0.0522307398),
   (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0099934641, -0.0035127408), -0.0013279448);

// Tree: 152 
final_score_152 := map(
(NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 1.5) => 
   map(
   (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 0.0209338509,
   (pf_ship_method in ['Next Day']) => 
      map(
      (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 14.8) => 0.1158325588,
      ((real)ST_cen_high_ed > 14.8) => 
         map(
         (NULL < b_rel_homeover300_count_d and b_rel_homeover300_count_d <= 0.5) => 0.1179938068,
         (b_rel_homeover300_count_d > 0.5) => 0.0220216343,
         (b_rel_homeover300_count_d = NULL) => -0.0229230373, 0.0248638621),
      ((real)ST_cen_high_ed = NULL) => 0.0382416116, 0.0382416116),
   (pf_ship_method = '') => 0.0224926244, 0.0224926244),
(s_C20_email_verification_d > 1.5) => -0.0077278092,
(s_C20_email_verification_d = NULL) => -0.0063444596, 0.0004835942);

// Tree: 153 
final_score_153 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 7.5) => 
   map(
   (NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => -0.0001427335,
   (s_C14_addrs_15yr_i > 11.5) => 
      map(
      (NULL < b_A50_pb_total_dollars_d and b_A50_pb_total_dollars_d <= 151) => 0.2030678841,
      (b_A50_pb_total_dollars_d > 151) => -0.0523194376,
      (b_A50_pb_total_dollars_d = NULL) => 0.0509222456, 0.0509222456),
   (s_C14_addrs_15yr_i = NULL) => 
      map(
      (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.35) => 0.0007184583,
      ((real)ST_cen_pop_0_5_p > 12.35) => 0.0783999799,
      ((real)ST_cen_pop_0_5_p = NULL) => -0.0523643466, 0.0039376107), 0.0009246516),
(b_inq_lnames_per_addr_i > 7.5) => 0.0548808105,
(b_inq_lnames_per_addr_i = NULL) => -0.0501720800, -0.0042294055);

// Tree: 154 
final_score_154 := map(
(NULL < b_phone_ver_insurance_d and b_phone_ver_insurance_d <= 3.5) => 
   map(
   (NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 26.95) => 
         map(
         (NULL < b_L75_Add_Drop_Delivery_i and b_L75_Add_Drop_Delivery_i <= 0.5) => 0.0040853627,
         (b_L75_Add_Drop_Delivery_i > 0.5) => 0.1849147490,
         (b_L75_Add_Drop_Delivery_i = NULL) => 0.0056934050, 0.0056934050),
      ((real)ST_cen_blue_col > 26.95) => 0.1513160996,
      ((real)ST_cen_blue_col = NULL) => 0.1136033860, 0.0083043502),
   (s_P85_Phn_Not_Issued_i > 0.5) => 0.0548701617,
   (s_P85_Phn_Not_Issued_i = NULL) => 0.0088737521, 0.0088737521),
(b_phone_ver_insurance_d > 3.5) => -0.0217315466,
(b_phone_ver_insurance_d = NULL) => 0.0066922121, -0.0014719485);

// Tree: 155 
final_score_155 := map(
(NULL < b_corrphonelastnamecount_d and b_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < s_util_add_input_inf_n and s_util_add_input_inf_n <= 0.5) => 
      map(
      (NULL < b_add_input_nhood_SFD_pct_d and b_add_input_nhood_SFD_pct_d <= 0.9920962814) => -0.0007026613,
      (b_add_input_nhood_SFD_pct_d > 0.9920962814) => 0.1049542497,
      (b_add_input_nhood_SFD_pct_d = NULL) => 0.0039624956, 0.0039624956),
   (s_util_add_input_inf_n > 0.5) => 
      map(
      (NULL < (real)BT_cen_vacant_p and (real)BT_cen_vacant_p <= 8.25) => -0.0238775185,
      ((real)BT_cen_vacant_p > 8.25) => 0.1048830235,
      ((real)BT_cen_vacant_p = NULL) => 0.0341227257, 0.0341227257),
   (s_util_add_input_inf_n = NULL) => 0.0043936310, 0.0043936310),
(b_corrphonelastnamecount_d > 0.5) => -0.0269252412,
(b_corrphonelastnamecount_d = NULL) => -0.0035456024, -0.0072395634);

// Tree: 156 
final_score_156 := map(
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 18.5) => 
      map(
      (NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => 0.0001176851,
      (s_C14_addrs_15yr_i > 11.5) => 
         map(
         (NULL < s_I60_inq_recency_d and s_I60_inq_recency_d <= 2) => -0.0823880646,
         (s_I60_inq_recency_d > 2) => 0.1612987813,
         (s_I60_inq_recency_d = NULL) => 0.0277222880, 0.0277222880),
      (s_C14_addrs_15yr_i = NULL) => -0.0055706090, -0.0007326019),
   (b_phones_per_addr_c6_i > 18.5) => 0.1285088807,
   (b_phones_per_addr_c6_i = NULL) => -0.0002830252, -0.0002830252),
(pf_avs_result in ['International','Not Supported']) => 0.0496265216,
(pf_avs_result = '') => -0.0001069881, -0.0001069881);

// Tree: 157 
final_score_157 := map(
(NULL < s_C14_addrs_10yr_i and s_C14_addrs_10yr_i <= 8.5) => -0.0047112681,
(s_C14_addrs_10yr_i > 8.5) => 
   map(
   (NULL < s_inq_count24_i and s_inq_count24_i <= 9.5) => 0.1470975167,
   (s_inq_count24_i > 9.5) => -0.0092292982,
   (s_inq_count24_i = NULL) => 0.0494924495, 0.0494924495),
(s_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 193.5) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 159.5) => -0.0130347562,
      ((real)ST_cen_span_lang > 159.5) => 0.0383353063,
      ((real)ST_cen_span_lang = NULL) => -0.0034755325, -0.0034755325),
   ((real)ST_cen_span_lang > 193.5) => -0.0695259466,
   ((real)ST_cen_span_lang = NULL) => -0.0507765175, -0.0157501369), -0.0061979835);

// Tree: 158 
final_score_158 := map(
(NULL < s_C14_addrs_10yr_i and s_C14_addrs_10yr_i <= 9.5) => -0.0043426170,
(s_C14_addrs_10yr_i > 9.5) => 0.1106182293,
(s_C14_addrs_10yr_i = NULL) => 
   map(
   (NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 67.85) => -0.0199109560,
   ((real)BT_cen_ownocc_p > 67.85) => 
      map(
      (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 0.5) => 0.0179977157,
      (s_inq_ssns_per_addr_i > 0.5) => 
         map(
         (NULL < btst_firstscore_d and btst_firstscore_d <= 95) => 0.0104893426,
         (btst_firstscore_d > 95) => 0.1174975706,
         (btst_firstscore_d = NULL) => 0.0548779409, 0.0548779409),
      (s_inq_ssns_per_addr_i = NULL) => 0.0252029695, 0.0252029695),
   ((real)BT_cen_ownocc_p = NULL) => -0.0121092714, -0.0069817979), -0.0041682083);

// Tree: 159 
final_score_159 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => -0.0024192849,
   (s_P85_Phn_Not_Issued_i > 0.5) => 
      map(
      (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 47.3) => 
         map(
         (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.1963995148) => 0.0211173536,
         (s_add_input_nhood_MFD_pct_i > 0.1963995148) => 0.0021489000,
         (s_add_input_nhood_MFD_pct_i = NULL) => 0.0116331268, 0.0116331268),
      ((real)BT_cen_high_ed > 47.3) => 0.1108574664,
      ((real)BT_cen_high_ed = NULL) => 0.0432608850, 0.0432608850),
   (s_P85_Phn_Not_Issued_i = NULL) => 0.0154155067, -0.0016073152),
(s_inq_ssns_per_addr_i > 4.5) => -0.0294818372,
(s_inq_ssns_per_addr_i = NULL) => -0.0500397479, -0.0036620915);

// Tree: 160 
final_score_160 := map(
(NULL < b_fp_prevaddrcrimeindex_i and b_fp_prevaddrcrimeindex_i <= 194.5) => -0.0042173065,
(b_fp_prevaddrcrimeindex_i > 194.5) => 
   map(
   (NULL < b_L79_adls_per_addr_curr_i and b_L79_adls_per_addr_curr_i <= 1.5) => -0.0520476963,
   (b_L79_adls_per_addr_curr_i > 1.5) => 0.2299534685,
   (b_L79_adls_per_addr_curr_i = NULL) => 0.0722992740, 0.0722992740),
(b_fp_prevaddrcrimeindex_i = NULL) => 
   map(
   (NULL < (real)BT_cen_pop_0_5_p and (real)BT_cen_pop_0_5_p <= 2.35) => -0.0611016779,
   ((real)BT_cen_pop_0_5_p > 2.35) => 
      map(
      (pf_avs_result in ['Error/Inval','Full Match','Not Supported','Unavailable','Zip Only']) => 0.0021202578,
      (pf_avs_result in ['Addr Only','International','No Match']) => 0.0506194607,
      (pf_avs_result = '') => 0.0081731410, 0.0081731410),
   ((real)BT_cen_pop_0_5_p = NULL) => -0.0505318461, -0.0281569333), -0.0083577943);

// Tree: 161 
final_score_161 := map(
(NULL < s_liens_unrel_ST_total_amt_i and s_liens_unrel_ST_total_amt_i <= 235) => 0.0002570127,
(s_liens_unrel_ST_total_amt_i > 235) => 
   map(
   (NULL < s_phone_ver_insurance_d and s_phone_ver_insurance_d <= 2.5) => 0.0855487897,
   (s_phone_ver_insurance_d > 2.5) => 0.0935829388,
   (s_phone_ver_insurance_d = NULL) => 0.0894966043, 0.0894966043),
(s_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 186209.5) => -0.0381360552,
   (b_L80_Inp_AVM_AutoVal_d > 186209.5) => 
      map(
      (NULL < (real)ST_cen_med_hhinc and (real)ST_cen_med_hhinc <= 77017.5) => 0.0823797274,
      ((real)ST_cen_med_hhinc > 77017.5) => -0.0350862097,
      ((real)ST_cen_med_hhinc = NULL) => 0.0243459609, 0.0243459609),
   (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0043526415, -0.0028786782), 0.0002863290);

// Tree: 162 
final_score_162 := map(
(NULL < b_rel_ageover40_count_d and b_rel_ageover40_count_d <= 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0000046561,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < (real)ST_cen_health and (real)ST_cen_health <= 11.45) => 0.0019711846,
      ((real)ST_cen_health > 11.45) => 
         map(
         (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 34.05) => 0.2426128574,
         ((real)ST_cen_high_ed > 34.05) => -0.0164325006,
         ((real)ST_cen_high_ed = NULL) => 0.0963775746, 0.0963775746),
      ((real)ST_cen_health = NULL) => 0.0325361777, 0.0325361777),
   (final_model_segment = '') => 0.0054289306, 0.0054289306),
(b_rel_ageover40_count_d > 0.5) => -0.0119581278,
(b_rel_ageover40_count_d = NULL) => 0.0041303475, -0.0056809545);

// Tree: 163 
final_score_163 := map(
(NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
   map(
   (NULL < s_addrchangeincomediff_d and s_addrchangeincomediff_d <= -3322) => 
      map(
      (NULL < (real)BT_cen_families and (real)BT_cen_families <= 659.5) => 
         map(
         (NULL < (real)ST_cen_lar_fam and (real)ST_cen_lar_fam <= 149.5) => 0.0277348213,
         ((real)ST_cen_lar_fam > 149.5) => 0.1605383597,
         ((real)ST_cen_lar_fam = NULL) => 0.0409717753, 0.0409717753),
      ((real)BT_cen_families > 659.5) => 0.2021507830,
      ((real)BT_cen_families = NULL) => -0.0501956496, 0.0480823267),
   (s_addrchangeincomediff_d > -3322) => 0.0050327509,
   (s_addrchangeincomediff_d = NULL) => 0.0136429452, 0.0106341391),
(s_L71_Add_Business_i > 0.5) => -0.0201974122,
(s_L71_Add_Business_i = NULL) => -0.0026196336, -0.0026196336);

// Tree: 164 
final_score_164 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 13.5) => 
   map(
   (NULL < s_nap_contradictory_i and s_nap_contradictory_i <= 0.5) => -0.0069322256,
   (s_nap_contradictory_i > 0.5) => 
      map(
      (NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 153.5) => 
         map(
         (NULL < (real)ST_cen_totcrime and (real)ST_cen_totcrime <= 97.5) => -0.0225988731,
         ((real)ST_cen_totcrime > 97.5) => 0.0876992059,
         ((real)ST_cen_totcrime = NULL) => 0.0129985509, 0.0129985509),
      ((real)BT_cen_trailer > 153.5) => 0.1760820329,
      ((real)BT_cen_trailer = NULL) => -0.0502492640, 0.0215858852),
   (s_nap_contradictory_i = NULL) => -0.0059941530, -0.0059941530),
(s_L79_adls_per_addr_c6_i > 13.5) => -0.0491826380,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0065456965, -0.0065456965);

// Tree: 165 
final_score_165 := map(
(NULL < (real)BT_cen_health and (real)BT_cen_health <= 79.1) => 
   map(
   (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1002.5) => -0.0064128806,
   (b_P88_Phn_Dst_to_Inp_Add_i > 1002.5) => 
      map(
      (NULL < s_C13_Curr_Addr_LRes_d and s_C13_Curr_Addr_LRes_d <= 25.5) => -0.0527495287,
      (s_C13_Curr_Addr_LRes_d > 25.5) => 0.1851014359,
      (s_C13_Curr_Addr_LRes_d = NULL) => 0.0745509876, 0.0745509876),
   (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 0.5) => -0.0683556209,
      (pf_pmt_x_avs_lvl > 0.5) => 0.0086604946,
      (pf_pmt_x_avs_lvl = NULL) => 0.0076873988, 0.0076873988), -0.0012517597),
((real)BT_cen_health > 79.1) => 0.2001953608,
((real)BT_cen_health = NULL) => -0.0058373842, -0.0011464869);

// Tree: 166 
final_score_166 := map(
(pf_cid_result in ['Invalid','Match','Null']) => 
   map(
   (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 152.5) => -0.0063821084,
   ((real)ST_cen_easiqlife > 152.5) => 
      map(
      (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.8414407205) => 0.0296314591,
      (s_add_input_nhood_MFD_pct_i > 0.8414407205) => 0.0892209944,
      (s_add_input_nhood_MFD_pct_i = NULL) => 0.0109231254, 0.0288431154),
   ((real)ST_cen_easiqlife = NULL) => 0.0432669598, 0.0005296004),
(pf_cid_result in ['No Match','Other']) => 
   map(
   (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 1.5) => 0.2137407906,
   (s_C20_email_verification_d > 1.5) => 0.0109903491,
   (s_C20_email_verification_d = NULL) => -0.0344250849, 0.0556037491),
(pf_cid_result = '') => 0.0011994392, 0.0011994392);

// Tree: 167 
final_score_167 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 45.5) => 
   map(
   (NULL < s_add_input_nhood_SFD_pct_d and s_add_input_nhood_SFD_pct_d <= 0.99735973485) => -0.0056464187,
   (s_add_input_nhood_SFD_pct_d > 0.99735973485) => 
      map(
      (NULL < s_C12_source_profile_d and s_C12_source_profile_d <= 53.95) => 
         map(
         (NULL < (real)ST_cen_med_rent and (real)ST_cen_med_rent <= 1307.5) => 0.2261577417,
         ((real)ST_cen_med_rent > 1307.5) => 0.0461302732,
         ((real)ST_cen_med_rent = NULL) => 0.1304674657, 0.1304674657),
      (s_C12_source_profile_d > 53.95) => -0.0177008638,
      (s_C12_source_profile_d = NULL) => 0.0260850278, 0.0260850278),
   (s_add_input_nhood_SFD_pct_d = NULL) => -0.0048760307, -0.0048760307),
(s_L79_adls_per_addr_c6_i > 45.5) => 0.0682704200,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0044667949, -0.0044667949);

// Tree: 168 
final_score_168 := map(
(NULL < b_varmsrcssnunrelcount_i and b_varmsrcssnunrelcount_i <= 1.5) => -0.0053480204,
(b_varmsrcssnunrelcount_i > 1.5) => 0.0979513216,
(b_varmsrcssnunrelcount_i = NULL) => 
   map(
   (NULL < btst_email_last_score_d and btst_email_last_score_d <= 0.5) => -0.0034058803,
   (btst_email_last_score_d > 0.5) => 
      map(
      (NULL < btst_distphoneaddr2_i and btst_distphoneaddr2_i <= 0.5) => -0.0017107288,
      (btst_distphoneaddr2_i > 0.5) => 0.2439237311,
      (btst_distphoneaddr2_i = NULL) => 
         map(
         (NULL < (real)BT_cen_civ_emp and (real)BT_cen_civ_emp <= 57.3) => 0.1288934624,
         ((real)BT_cen_civ_emp > 57.3) => -0.0210103635,
         ((real)BT_cen_civ_emp = NULL) => 0.0215623231, 0.0215623231), 0.0489568452),
   (btst_email_last_score_d = NULL) => -0.0501542667, -0.0219260931), -0.0082513288);

// Tree: 169 
final_score_169 := map(
(NULL < s_I61_inq_collection_count12_i and s_I61_inq_collection_count12_i <= 8.5) => 0.0045314613,
(s_I61_inq_collection_count12_i > 8.5) => 0.3048629071,
(s_I61_inq_collection_count12_i = NULL) => 
   map(
   (NULL < (real)ST_cen_mil_emp and (real)ST_cen_mil_emp <= 2.45) => 
      map(
      (NULL < (real)BT_cen_blue_col and (real)BT_cen_blue_col <= 17.75) => -0.0207438116,
      ((real)BT_cen_blue_col > 17.75) => 
         map(
         (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 0.0863184880,
         (s_L71_Add_Business_i > 0.5) => -0.0424989156,
         (s_L71_Add_Business_i = NULL) => 0.0086668755, 0.0086668755),
      ((real)BT_cen_blue_col = NULL) => -0.0508083078, -0.0238920517),
   ((real)ST_cen_mil_emp > 2.45) => 0.1066542320,
   ((real)ST_cen_mil_emp = NULL) => -0.0546610557, -0.0286925484), -0.0007840208);

// Tree: 170 
final_score_170 := map(
(NULL < s_bus_name_nover_i and s_bus_name_nover_i <= 0.5) => 
   map(
   (NULL < s_I60_inq_PrepaidCards_recency_d and s_I60_inq_PrepaidCards_recency_d <= 549) => 0.2076418968,
   (s_I60_inq_PrepaidCards_recency_d > 549) => 0.0083923298,
   (s_I60_inq_PrepaidCards_recency_d = NULL) => 
      map(
      (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 11.4) => -0.0014928726,
      ((real)ST_cen_pop_0_5_p > 11.4) => 0.0564145455,
      ((real)ST_cen_pop_0_5_p = NULL) => 0.0042897247, 0.0042897247), 0.0096261835),
(s_bus_name_nover_i > 0.5) => 
   map(
   (NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 6.5) => -0.0148344410,
   (s_inq_adls_per_addr_i > 6.5) => -0.0493900377,
   (s_inq_adls_per_addr_i = NULL) => -0.0500243866, -0.0172981082),
(s_bus_name_nover_i = NULL) => -0.0075396079, -0.0075396079);

// Tree: 171 
final_score_171 := map(
(NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 26613) => 0.1066763744,
(s_L80_Inp_AVM_AutoVal_d > 26613) => 
   map(
   (NULL < (real)BT_cen_health and (real)BT_cen_health <= 59.1) => 
      map(
      (NULL < s_nap_nothing_found_i and s_nap_nothing_found_i <= 0.5) => -0.0054562270,
      (s_nap_nothing_found_i > 0.5) => 0.0482373122,
      (s_nap_nothing_found_i = NULL) => -0.0020604139, -0.0020604139),
   ((real)BT_cen_health > 59.1) => 0.1829312297,
   ((real)BT_cen_health = NULL) => 0.0516838208, 0.0012545614),
(s_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 204227) => -0.0044492122,
   (s_curraddrmedianincome_d > 204227) => 0.2749746367,
   (s_curraddrmedianincome_d = NULL) => -0.0106062131, -0.0045606125), -0.0023247562);

// Tree: 172 
final_score_172 := map(
(NULL < b_inq_count24_i and b_inq_count24_i <= 10.5) => 
   map(
   (NULL < b_srchunvrfdphonecount_i and b_srchunvrfdphonecount_i <= 1.5) => 
      map(
      (NULL < b_inq_per_phone_i and b_inq_per_phone_i <= 5.5) => 0.0011652584,
      (b_inq_per_phone_i > 5.5) => 0.0638151080,
      (b_inq_per_phone_i = NULL) => 0.0571556063, 0.0035551377),
   (b_srchunvrfdphonecount_i > 1.5) => 
      map(
      (NULL < b_add_curr_nhood_VAC_pct_i and b_add_curr_nhood_VAC_pct_i <= 0.0165289708) => 0.2408030542,
      (b_add_curr_nhood_VAC_pct_i > 0.0165289708) => -0.0326630211,
      (b_add_curr_nhood_VAC_pct_i = NULL) => 0.0977592609, 0.0977592609),
   (b_srchunvrfdphonecount_i = NULL) => 0.0047065608, 0.0047065608),
(b_inq_count24_i > 10.5) => -0.0513613029,
(b_inq_count24_i = NULL) => -0.0113432207, -0.0071751769);

// Tree: 173 
final_score_173 := map(
(NULL < s_varrisktype_i and s_varrisktype_i <= 7.5) => 
   map(
   (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1844.5) => -0.0006552454,
   (b_P88_Phn_Dst_to_Inp_Add_i > 1844.5) => 0.1369928308,
   (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 137.5) => -0.0111394981,
      ((real)BT_cen_lar_fam > 137.5) => 
         map(
         (NULL < b_curraddrcrimeindex_i and b_curraddrcrimeindex_i <= 130) => 0.0276533017,
         (b_curraddrcrimeindex_i > 130) => 0.2209252868,
         (b_curraddrcrimeindex_i = NULL) => 0.0507832147, 0.0507832147),
      ((real)BT_cen_lar_fam = NULL) => -0.0604606897, -0.0069978257), -0.0018090921),
(s_varrisktype_i > 7.5) => 0.1395667162,
(s_varrisktype_i = NULL) => -0.0076673340, -0.0025230588);

// Tree: 174 
final_score_174 := map(
(NULL < b_varmsrcssnunrelcount_i and b_varmsrcssnunrelcount_i <= 1.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 82.5) => -0.0063211540,
   (btst_distaddraddr2_i > 82.5) => 
      map(
      (NULL < b_inq_count24_i and b_inq_count24_i <= 6.5) => 
         map(
         (NULL < b_F01_inp_addr_address_score_d and b_F01_inp_addr_address_score_d <= 70) => -0.0045436496,
         (b_F01_inp_addr_address_score_d > 70) => 0.0806583295,
         (b_F01_inp_addr_address_score_d = NULL) => -0.0462516306, 0.0371846502),
      (b_inq_count24_i > 6.5) => -0.0435808224,
      (b_inq_count24_i = NULL) => -0.0017498312, -0.0017498312),
   (btst_distaddraddr2_i = NULL) => -0.0059020520, -0.0059020520),
(b_varmsrcssnunrelcount_i > 1.5) => 0.1193084799,
(b_varmsrcssnunrelcount_i = NULL) => -0.0086948550, -0.0060603124);

// Tree: 175 
final_score_175 := map(
(NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 14.5) => 
   map(
   (NULL < s_phones_per_addr_c6_i and s_phones_per_addr_c6_i <= 1.5) => 
      map(
      (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 7.5) => 0.0041902775,
      (b_inq_lnames_per_addr_i > 7.5) => 0.0463523835,
      (b_inq_lnames_per_addr_i = NULL) => -0.0501494311, -0.0012566576),
   (s_phones_per_addr_c6_i > 1.5) => 
      map(
      (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => -0.0551363788,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0224605147,
      (final_model_segment = '') => -0.0272697547, -0.0272697547),
   (s_phones_per_addr_c6_i = NULL) => -0.0047239047, -0.0047239047),
(b_phones_per_addr_c6_i > 14.5) => 0.0691364258,
(b_phones_per_addr_c6_i = NULL) => -0.0043600829, -0.0043600829);

// Tree: 176 
final_score_176 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (btst_relatives_lvl_d in ['2. BILLTO DID 0','3. SHIPTO DID 0','5. RELATIVES','6. RELATIVES IN COMMON','7. NO RELATION']) => -0.0236332647,
   (btst_relatives_lvl_d in ['1. BOTH DID 0','4. DIDS EQUAL']) => 
      map(
      (NULL < s_corrrisktype_i and s_corrrisktype_i <= 8.5) => -0.0112649564,
      (s_corrrisktype_i > 8.5) => 
         map(
         (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 156.5) => 0.0218397011,
         ((real)BT_cen_lar_fam > 156.5) => 0.1440988109,
         ((real)BT_cen_lar_fam = NULL) => 0.0284046709, 0.0284046709),
      (s_corrrisktype_i = NULL) => 0.0060112797, -0.0010366026),
   ((integer)btst_relatives_lvl_d = NULL) => -0.0501488614, -0.0101955370),
(s_inq_ssns_per_addr_i > 4.5) => -0.0269083374,
(s_inq_ssns_per_addr_i = NULL) => -0.0500212260, -0.0119559338);

// Tree: 177 
final_score_177 := map(
(NULL < b_corrphonelastnamecount_d and b_corrphonelastnamecount_d <= 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_I60_inq_comm_recency_d and s_I60_inq_comm_recency_d <= 9) => 0.1283220977,
      (s_I60_inq_comm_recency_d > 9) => 
         map(
         (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1114.5) => 0.0077249390,
         (b_P88_Phn_Dst_to_Inp_Add_i > 1114.5) => 0.1659723192,
         (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0091978186, 0.0094833360),
      (s_I60_inq_comm_recency_d = NULL) => -0.0087261916, 0.0086558887),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0790486539,
   (final_model_segment = '') => 0.0091114186, 0.0091114186),
(b_corrphonelastnamecount_d > 0.5) => -0.0239434458,
(b_corrphonelastnamecount_d = NULL) => 0.0057516551, -0.0022433550);

// Tree: 178 
final_score_178 := map(
(NULL < s_mos_liens_rel_OT_lseen_d and s_mos_liens_rel_OT_lseen_d <= 27.5) => 0.0782319579,
(s_mos_liens_rel_OT_lseen_d > 27.5) => -0.0019356395,
(s_mos_liens_rel_OT_lseen_d = NULL) => 
   map(
   (NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 168.5) => 
      map(
      (final_model_segment in ['CONS ADDR+ DIFF    OTH']) => -0.0471533603,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0028799128,
      (final_model_segment = '') => -0.0046471302, -0.0046471302),
   ((real)BT_cen_trailer > 168.5) => 
      map(
      (NULL < s_nap_addr_verd_d and s_nap_addr_verd_d <= 0.5) => 0.1021180474,
      (s_nap_addr_verd_d > 0.5) => -0.0584592513,
      (s_nap_addr_verd_d = NULL) => 0.0381285976, 0.0381285976),
   ((real)BT_cen_trailer = NULL) => -0.0507662543, -0.0194742230), -0.0050829457);

// Tree: 179 
final_score_179 := map(
(NULL < b_adl_per_email_i and b_adl_per_email_i <= 0.5) => 
   map(
   (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 184.5) => 0.0072847366,
   ((real)BT_cen_span_lang > 184.5) => 
      map(
      (NULL < s_add_curr_nhood_MFD_pct_i and s_add_curr_nhood_MFD_pct_i <= 0.3262532909) => -0.0191761785,
      (s_add_curr_nhood_MFD_pct_i > 0.3262532909) => 0.1833227235,
      (s_add_curr_nhood_MFD_pct_i = NULL) => 
         map(
         (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.3144828698) => -0.0295983670,
         (b_add_input_nhood_BUS_pct_i > 0.3144828698) => 0.1029578660,
         (b_add_input_nhood_BUS_pct_i = NULL) => 0.0306544662, 0.0306544662), 0.0611423584),
   ((real)BT_cen_span_lang = NULL) => -0.0506975550, 0.0094129610),
(b_adl_per_email_i > 0.5) => -0.0225992639,
(b_adl_per_email_i = NULL) => -0.0067375698, -0.0043640772);

// Tree: 180 
final_score_180 := map(
(NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 26.95) => 
   map(
   (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 140.5) => -0.0081342222,
   ((real)ST_cen_easiqlife > 140.5) => 
      map(
      (NULL < s_L70_Add_Invalid_i and s_L70_Add_Invalid_i <= 0.5) => 0.0166570337,
      (s_L70_Add_Invalid_i > 0.5) => 0.1231963704,
      (s_L70_Add_Invalid_i = NULL) => 0.0188766033, 0.0188766033),
   ((real)ST_cen_easiqlife = NULL) => -0.0004799283, -0.0004799283),
((real)ST_cen_blue_col > 26.95) => 
   map(
   (NULL < (real)ST_cen_trailer and (real)ST_cen_trailer <= 114.5) => 0.2374336900,
   ((real)ST_cen_trailer > 114.5) => 0.0005001778,
   ((real)ST_cen_trailer = NULL) => 0.0910141039, 0.0910141039),
((real)ST_cen_blue_col = NULL) => 0.0016167462, 0.0006190929);

// Tree: 181 
final_score_181 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 43.5) => 
   map(
   (NULL < s_L71_Add_Business_i and s_L71_Add_Business_i <= 0.5) => 
      map(
      (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
         map(
         (pf_avs_result in ['Error/Inval','Full Match','International','Not Supported','Unavailable','Zip Only']) => 0.0195883789,
         (pf_avs_result in ['Addr Only','No Match']) => 0.0999190727,
         (pf_avs_result = '') => 0.0241812773, 0.0241812773),
      (s_C20_email_verification_d > 0.5) => -0.0016341572,
      (s_C20_email_verification_d = NULL) => 0.0084135737, 0.0064025151),
   (s_L71_Add_Business_i > 0.5) => -0.0255770895,
   (s_L71_Add_Business_i = NULL) => -0.0073013508, -0.0073013508),
(b_L79_adls_per_addr_c6_i > 43.5) => 0.0418720515,
(b_L79_adls_per_addr_c6_i = NULL) => -0.0070262381, -0.0070262381);

// Tree: 182 
final_score_182 := map(
(NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 0.5) => 
   map(
   (NULL < b_mos_liens_unrel_OT_fseen_d and b_mos_liens_unrel_OT_fseen_d <= 127) => 0.1970665221,
   (b_mos_liens_unrel_OT_fseen_d > 127) => 0.0199762391,
   (b_mos_liens_unrel_OT_fseen_d = NULL) => 0.0186618461, 0.0232804919),
(b_C20_email_verification_d > 0.5) => 
   map(
   (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 176.5) => -0.0192153067,
   ((real)ST_cen_span_lang > 176.5) => 
      map(
      (NULL < s_estimated_income_d and s_estimated_income_d <= 32500) => 0.1161971457,
      (s_estimated_income_d > 32500) => 0.0037041640,
      (s_estimated_income_d = NULL) => 0.0565999858, 0.0337401972),
   ((real)ST_cen_span_lang = NULL) => 0.2898300323, -0.0130360514),
(b_C20_email_verification_d = NULL) => -0.0049657443, -0.0028691216);

// Tree: 183 
final_score_183 := map(
(NULL < (real)BT_cen_vacant_p and (real)BT_cen_vacant_p <= 2.25) => -0.0517545223,
((real)BT_cen_vacant_p > 2.25) => 
   map(
   (NULL < s_I60_inq_retail_recency_d and s_I60_inq_retail_recency_d <= 549) => -0.0124148984,
   (s_I60_inq_retail_recency_d > 549) => 
      map(
      (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 41.5) => 0.0191731411,
      (btst_distphone2addr2_i > 41.5) => 0.1224010934,
      (btst_distphone2addr2_i = NULL) => 
         map(
         (NULL < b_C21_M_Bureau_ADL_FS_d and b_C21_M_Bureau_ADL_FS_d <= 771) => 0.0055796461,
         (b_C21_M_Bureau_ADL_FS_d > 771) => 0.1259007627,
         (b_C21_M_Bureau_ADL_FS_d = NULL) => 0.0497046197, 0.0119736933), 0.0160245189),
   (s_I60_inq_retail_recency_d = NULL) => -0.0031629201, -0.0012877516),
((real)BT_cen_vacant_p = NULL) => -0.0152903941, -0.0059283563);

// Tree: 184 
final_score_184 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.00103573975) => 0.1526217208,
   (b_add_curr_nhood_BUS_pct_i > 0.00103573975) => -0.0016466426,
   (b_add_curr_nhood_BUS_pct_i = NULL) => 
      map(
      (NULL < (real)BT_cen_easiqlife and (real)BT_cen_easiqlife <= 68.5) => 
         map(
         (NULL < b_add_input_nhood_SFD_pct_d and b_add_input_nhood_SFD_pct_d <= 0.80499176475) => -0.0308788730,
         (b_add_input_nhood_SFD_pct_d > 0.80499176475) => 0.1973213607,
         (b_add_input_nhood_SFD_pct_d = NULL) => 0.0370378632, 0.0370378632),
      ((real)BT_cen_easiqlife > 68.5) => 0.0045545401,
      ((real)BT_cen_easiqlife = NULL) => 0.0206092291, 0.0086221349), 0.0005912716),
(s_inq_ssns_per_addr_i > 4.5) => -0.0330177389,
(s_inq_ssns_per_addr_i = NULL) => -0.0500203216, -0.0018097837);

// Tree: 185 
final_score_185 := map(
(NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 186.5) => -0.0028684319,
((real)BT_cen_very_rich > 186.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < b_srchvelocityrisktype_i and b_srchvelocityrisktype_i <= 2.5) => 0.0280884596,
      (b_srchvelocityrisktype_i > 2.5) => -0.0588242929,
      (b_srchvelocityrisktype_i = NULL) => 0.1569102389, 0.0164879595),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < b_rel_under100miles_cnt_d and b_rel_under100miles_cnt_d <= 4.5) => 0.2061095745,
      (b_rel_under100miles_cnt_d > 4.5) => -0.0534437714,
      (b_rel_under100miles_cnt_d = NULL) => 0.0763329016, 0.0763329016),
   (final_model_segment = '') => 0.0250946146, 0.0250946146),
((real)BT_cen_very_rich = NULL) => -0.0213827253, -0.0032216333);

// Tree: 186 
final_score_186 := map(
(btst_email_topleveldomain_n in ['BIZ','COM','EDU','GOV','MIL','NET','ORG','US']) => 
   map(
   (NULL < s_inf_contradictory_i and s_inf_contradictory_i <= 0.5) => -0.0125680230,
   (s_inf_contradictory_i > 0.5) => 
      map(
      (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 169.5) => 
         map(
         (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.75605471155) => 0.0198333881,
         (s_add_input_nhood_BUS_pct_i > 0.75605471155) => 0.1107885451,
         (s_add_input_nhood_BUS_pct_i = NULL) => 0.0217314506, 0.0217314506),
      ((real)BT_cen_lar_fam > 169.5) => 0.1378673052,
      ((real)BT_cen_lar_fam = NULL) => 0.0321583782, 0.0255694745),
   (s_inf_contradictory_i = NULL) => -0.0025655336, -0.0025655336),
(btst_email_topleveldomain_n in ['OTH']) => 0.1219597927,
(btst_email_topleveldomain_n = '') => 0.0007275030, -0.0008202819);

// Tree: 187 
final_score_187 := map(
(NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 4.5) => -0.0267605199,
(btst_distphone2addr2_i > 4.5) => 
   map(
   (NULL < b_C21_M_Bureau_ADL_FS_d and b_C21_M_Bureau_ADL_FS_d <= 135.5) => 0.1745590241,
   (b_C21_M_Bureau_ADL_FS_d > 135.5) => 
      map(
      (NULL < b_A50_pb_total_orders_d and b_A50_pb_total_orders_d <= 9.5) => -0.0211157395,
      (b_A50_pb_total_orders_d > 9.5) => 0.1607316604,
      (b_A50_pb_total_orders_d = NULL) => 0.0065370883, 0.0065370883),
   (b_C21_M_Bureau_ADL_FS_d = NULL) => 
      map(
      (NULL < (real)BT_cen_business and (real)BT_cen_business <= 45.5) => 0.1087354792,
      ((real)BT_cen_business > 45.5) => -0.0230224843,
      ((real)BT_cen_business = NULL) => -0.0501581675, -0.0093029376), 0.0128875181),
(btst_distphone2addr2_i = NULL) => -0.0011096543, -0.0080403531);

// Tree: 188 
final_score_188 := map(
(NULL < b_adl_per_email_i and b_adl_per_email_i <= 0.5) => 
   map(
   (NULL < btst_distphoneaddr2_i and btst_distphoneaddr2_i <= 710) => 
      map(
      (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 10.5) => -0.0000732782,
      (s_inq_per_addr_i > 10.5) => 0.1675175934,
      (s_inq_per_addr_i = NULL) => 0.0049676701, 0.0049676701),
   (btst_distphoneaddr2_i > 710) => 0.0836574844,
   (btst_distphoneaddr2_i = NULL) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 7164.025) => 0.0021862801,
      (pf_order_amt_c > 7164.025) => 0.2144837244,
      (pf_order_amt_c = NULL) => 0.0048794899, 0.0048794899), 0.0058609764),
(b_adl_per_email_i > 0.5) => -0.0279070651,
(b_adl_per_email_i = NULL) => -0.0071892578, -0.0070964460);

// Tree: 189 
final_score_189 := map(
(NULL < b_D31_bk_disposed_hist_count_i and b_D31_bk_disposed_hist_count_i <= 1.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < b_C18_invalid_addrs_per_adl_i and b_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0165296560,
      (b_C18_invalid_addrs_per_adl_i > 0.5) => -0.0160027255,
      (b_C18_invalid_addrs_per_adl_i = NULL) => -0.0058432530, -0.0058432530),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0434797021,
   (final_model_segment = '') => -0.0055484491, -0.0055484491),
(b_D31_bk_disposed_hist_count_i > 1.5) => 
   map(
   (NULL < b_crim_rel_under100miles_cnt_i and b_crim_rel_under100miles_cnt_i <= 0.5) => 0.1977454771,
   (b_crim_rel_under100miles_cnt_i > 0.5) => -0.0512091452,
   (b_crim_rel_under100miles_cnt_i = NULL) => 0.0599313112, 0.0599313112),
(b_D31_bk_disposed_hist_count_i = NULL) => 0.0048517450, -0.0030233792);

// Tree: 190 
final_score_190 := map(
(NULL < b_hh_age_30_plus_d and b_hh_age_30_plus_d <= 6.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0019210061,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0605850839,
   (final_model_segment = '') => 0.0022536352, 0.0022536352),
(b_hh_age_30_plus_d > 6.5) => 
   map(
   (NULL < (real)ST_cen_retired2 and (real)ST_cen_retired2 <= 90.5) => 0.2424902244,
   ((real)ST_cen_retired2 > 90.5) => -0.0351998612,
   ((real)ST_cen_retired2 = NULL) => 0.0959315681, 0.0959315681),
(b_hh_age_30_plus_d = NULL) => 
   map(
   (NULL < (real)BT_cen_low_hval and (real)BT_cen_low_hval <= 16.2) => -0.0153247760,
   ((real)BT_cen_low_hval > 16.2) => 0.0738234753,
   ((real)BT_cen_low_hval = NULL) => -0.0505668619, -0.0300720720), -0.0035734582);

// Tree: 191 
final_score_191 := map(
(NULL < s_varrisktype_i and s_varrisktype_i <= 7.5) => 0.0045726709,
(s_varrisktype_i > 7.5) => 0.1309450067,
(s_varrisktype_i = NULL) => 
   map(
   (NULL < (real)BT_cen_med_hval and (real)BT_cen_med_hval <= 99583.5) => 
      map(
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => -0.0585817284,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0205968426,
      (final_model_segment = '') => -0.0310995760, -0.0310995760),
   ((real)BT_cen_med_hval > 99583.5) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.01539252555) => 0.0525185533,
      (s_add_input_nhood_BUS_pct_i > 0.01539252555) => -0.0039825433,
      (s_add_input_nhood_BUS_pct_i = NULL) => -0.0009012550, -0.0009012550),
   ((real)BT_cen_med_hval = NULL) => 0.0012366579, -0.0021832932), 0.0036870418);

// Tree: 192 
final_score_192 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 45.5) => 
   map(
   (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 159998) => 
      map(
      (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.697686023) => -0.0073432298,
      (s_add_input_nhood_MFD_pct_i > 0.697686023) => 0.0860040694,
      (s_add_input_nhood_MFD_pct_i = NULL) => -0.0433549715, -0.0085095491),
   (b_L80_Inp_AVM_AutoVal_d > 159998) => 
      map(
      (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 37.5) => 0.0098274200,
      (btst_distaddraddr2_i > 37.5) => 0.0540198269,
      (btst_distaddraddr2_i = NULL) => 0.0138645090, 0.0138645090),
   (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0100421253, -0.0033241962),
(s_L79_adls_per_addr_c6_i > 45.5) => 0.0414202459,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0030575363, -0.0030575363);

// Tree: 193 
final_score_193 := map(
(NULL < s_curraddrmurderindex_i and s_curraddrmurderindex_i <= 197.5) => -0.0037252733,
(s_curraddrmurderindex_i > 197.5) => 0.0807597312,
(s_curraddrmurderindex_i = NULL) => 
   map(
   (NULL < b_inq_per_addr_i and b_inq_per_addr_i <= 30.5) => 
      map(
      (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.35) => 0.0000570056,
      ((real)ST_cen_pop_0_5_p > 12.35) => 
         map(
         (NULL < s_bus_phone_match_d and s_bus_phone_match_d <= 0.5) => 0.0837713359,
         (s_bus_phone_match_d > 0.5) => 0.0017702731,
         (s_bus_phone_match_d = NULL) => 0.0413569931, 0.0413569931),
      ((real)ST_cen_pop_0_5_p = NULL) => -0.0601199247, 0.0005911935),
   (b_inq_per_addr_i > 30.5) => 0.0832078898,
   (b_inq_per_addr_i = NULL) => -0.0501275905, -0.0154635834), -0.0057252522);

// Tree: 194 
final_score_194 := map(
(NULL < b_I61_inq_collection_count12_i and b_I61_inq_collection_count12_i <= 8.5) => -0.0005036798,
(b_I61_inq_collection_count12_i > 8.5) => 0.2118728264,
(b_I61_inq_collection_count12_i = NULL) => 
   map(
   (NULL < (real)BT_cen_urban_p and (real)BT_cen_urban_p <= 52.1) => 
      map(
      (NULL < b_L71_Add_Business_i and b_L71_Add_Business_i <= 0.5) => 0.1862719724,
      (b_L71_Add_Business_i > 0.5) => -0.0604761003,
      (b_L71_Add_Business_i = NULL) => 0.0540150054, 0.0540150054),
   ((real)BT_cen_urban_p > 52.1) => 
      map(
      (NULL < s_add_input_nhood_VAC_pct_i and s_add_input_nhood_VAC_pct_i <= 0.03915112395) => 0.0269041550,
      (s_add_input_nhood_VAC_pct_i > 0.03915112395) => -0.0228775041,
      (s_add_input_nhood_VAC_pct_i = NULL) => -0.0016097939, -0.0016097939),
   ((real)BT_cen_urban_p = NULL) => -0.0166833644, -0.0075719299), -0.0012518864);

// Tree: 195 
final_score_195 := map(
(NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => 
   map(
   (NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 204227) => -0.0025065045,
   (s_curraddrmedianincome_d > 204227) => 0.1416550259,
   (s_curraddrmedianincome_d = NULL) => -0.0015665850, -0.0015665850),
(s_srchaddrsrchcountwk_i > 0.5) => 
   map(
   (NULL < s_phone_ver_insurance_d and s_phone_ver_insurance_d <= 2.5) => 0.0818432680,
   (s_phone_ver_insurance_d > 2.5) => 0.0038146234,
   (s_phone_ver_insurance_d = NULL) => 0.0387929813, 0.0387929813),
(s_srchaddrsrchcountwk_i = NULL) => 
   map(
   (NULL < b_hh_age_30_plus_d and b_hh_age_30_plus_d <= 3.5) => -0.0100546838,
   (b_hh_age_30_plus_d > 3.5) => 0.0971732321,
   (b_hh_age_30_plus_d = NULL) => -0.0018636325, -0.0020261003), -0.0012986755);

// Tree: 196 
final_score_196 := map(
(NULL < b_liens_rel_OT_total_amt_i and b_liens_rel_OT_total_amt_i <= 22346) => 
   map(
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => 
      map(
      (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 62.7) => -0.0603071657,
      ((real)ST_cen_civ_emp > 62.7) => -0.0010787745,
      ((real)ST_cen_civ_emp = NULL) => -0.0315271728, -0.0315271728),
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 14.5) => -0.0071668551,
      (b_phones_per_addr_c6_i > 14.5) => 0.0620886317,
      (b_phones_per_addr_c6_i = NULL) => -0.0067391211, -0.0067391211),
   (final_model_segment = '') => -0.0070154060, -0.0070154060),
(b_liens_rel_OT_total_amt_i > 22346) => 0.1474885145,
(b_liens_rel_OT_total_amt_i = NULL) => -0.0069096205, -0.0065244209);

// Tree: 197 
final_score_197 := map(
(final_model_segment in ['CONS ADDR+ DIFF    OTH']) => -0.0481387433,
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < (real)BT_cen_vacant_p and (real)BT_cen_vacant_p <= 2.65) => -0.0397379645,
   ((real)BT_cen_vacant_p > 2.65) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.8581919916) => 0.0077498125,
      (s_add_input_nhood_BUS_pct_i > 0.8581919916) => 
         map(
         (NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 198.5) => 0.1407248555,
         ((real)ST_cen_no_move > 198.5) => -0.0519007179,
         ((real)ST_cen_no_move = NULL) => 0.0407077309, 0.0407077309),
      (s_add_input_nhood_BUS_pct_i = NULL) => -0.0004342567, 0.0078766043),
   ((real)BT_cen_vacant_p = NULL) => -0.0341682239, -0.0008781175),
(final_model_segment = '') => -0.0012661122, -0.0012661122);

// Tree: 198 
final_score_198 := map(
(NULL < b_add_input_nhood_SFD_pct_d and b_add_input_nhood_SFD_pct_d <= 0.9920962814) => -0.0049924217,
(b_add_input_nhood_SFD_pct_d > 0.9920962814) => 
   map(
   (NULL < s_L70_Add_Standardized_i and s_L70_Add_Standardized_i <= 0.5) => 
      map(
      (NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 127252.5) => -0.0031450729,
      (s_curraddrmedianincome_d > 127252.5) => 
         map(
         (NULL < s_rel_incomeover75_count_d and s_rel_incomeover75_count_d <= 4.5) => 0.2627951738,
         (s_rel_incomeover75_count_d > 4.5) => -0.0157873489,
         (s_rel_incomeover75_count_d = NULL) => 0.1204085511, 0.1204085511),
      (s_curraddrmedianincome_d = NULL) => 0.0243785006, 0.0243785006),
   (s_L70_Add_Standardized_i > 0.5) => 0.1904973125,
   (s_L70_Add_Standardized_i = NULL) => 0.0338294615, 0.0338294615),
(b_add_input_nhood_SFD_pct_d = NULL) => -0.0028346012, -0.0028346012);

// Tree: 199 
final_score_199 := map(
(NULL < b_curraddrmedianvalue_d and b_curraddrmedianvalue_d <= 930012.5) => -0.0002523948,
(b_curraddrmedianvalue_d > 930012.5) => 0.0996911388,
(b_curraddrmedianvalue_d = NULL) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < (real)BT_cen_urban_p and (real)BT_cen_urban_p <= 0.05) => 0.1139876461,
      ((real)BT_cen_urban_p > 0.05) => 
         map(
         (NULL < s_C12_source_profile_d and s_C12_source_profile_d <= 42.95) => 0.1941725190,
         (s_C12_source_profile_d > 42.95) => -0.0400170692,
         (s_C12_source_profile_d = NULL) => -0.0079181666, -0.0051953006),
      ((real)BT_cen_urban_p = NULL) => -0.0505162631, -0.0275882661),
   (final_model_segment in ['CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB']) => 0.0626569637,
   (final_model_segment = '') => -0.0252406890, -0.0252406890), -0.0048081993);

// Tree: 200 
final_score_200 := map(
(NULL < b_divrisktype_i and b_divrisktype_i <= 4.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_F01_inp_addr_address_score_d and s_F01_inp_addr_address_score_d <= 16) => 
         map(
         (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0113243013) => 0.0937970769,
         (s_add_input_nhood_BUS_pct_i > 0.0113243013) => 0.0185119789,
         (s_add_input_nhood_BUS_pct_i = NULL) => 0.0213626668, 0.0213626668),
      (s_F01_inp_addr_address_score_d > 16) => -0.0078807966,
      (s_F01_inp_addr_address_score_d = NULL) => -0.0182065560, -0.0013110994),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0415196314,
   (final_model_segment = '') => -0.0010339633, -0.0010339633),
(b_divrisktype_i > 4.5) => -0.0545418159,
(b_divrisktype_i = NULL) => -0.0014307430, -0.0017279334);

// Tree: 201 
final_score_201 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 4.5) => 
      map(
      (NULL < (real)ST_cen_families and (real)ST_cen_families <= 504.5) => -0.0115113138,
      ((real)ST_cen_families > 504.5) => 
         map(
         (NULL < btst_distphoneaddr_i and btst_distphoneaddr_i <= 38.5) => 0.0028144747,
         (btst_distphoneaddr_i > 38.5) => 0.0899549013,
         (btst_distphoneaddr_i = NULL) => 0.0119034871, 0.0094585443),
      ((real)ST_cen_families = NULL) => -0.0001451534, -0.0047239446),
   (s_inq_adls_per_addr_i > 4.5) => 0.0629562299,
   (s_inq_adls_per_addr_i = NULL) => -0.0043403288, -0.0043403288),
(s_inq_ssns_per_addr_i > 5.5) => -0.0383856720,
(s_inq_ssns_per_addr_i = NULL) => -0.0500235830, -0.0063599310);

// Tree: 202 
final_score_202 := map(
(NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 2522) => 
   map(
   (NULL < b_divaddrsuspidcountnew_i and b_divaddrsuspidcountnew_i <= 9.5) => 
      map(
      (NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 549) => -0.0171519747,
      (b_I60_inq_retail_recency_d > 549) => 0.0129460821,
      (b_I60_inq_retail_recency_d = NULL) => -0.0064248493, -0.0064248493),
   (b_divaddrsuspidcountnew_i > 9.5) => -0.0749228736,
   (b_divaddrsuspidcountnew_i = NULL) => 0.0063849868, -0.0040922034),
(btst_distaddraddr2_i > 2522) => 
   map(
   (NULL < s_has_pb_record_d and s_has_pb_record_d <= 0.5) => 0.1634543790,
   (s_has_pb_record_d > 0.5) => -0.0079241114,
   (s_has_pb_record_d = NULL) => 0.0716444735, 0.0716444735),
(btst_distaddraddr2_i = NULL) => -0.0035760474, -0.0035760474);

// Tree: 203 
final_score_203 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0035945615,
(final_model_segment in ['CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
   map(
   (NULL < pf_order_amt_c and pf_order_amt_c <= 428.075) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 377.76) => -0.0427866212,
      (pf_order_amt_c > 377.76) => 0.1600082938,
      (pf_order_amt_c = NULL) => 0.0570822314, 0.0570822314),
   (pf_order_amt_c > 428.075) => 
      map(
      (NULL < (real)ST_cen_rental and (real)ST_cen_rental <= 186.5) => 0.0015384129,
      ((real)ST_cen_rental > 186.5) => 0.1171595138,
      ((real)ST_cen_rental = NULL) => 0.0071601844, 0.0071601844),
   (pf_order_amt_c = NULL) => 0.0139786383, 0.0139786383),
(final_model_segment = '') => -0.0020375101, -0.0020375101);

// Tree: 204 
final_score_204 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0006283612,
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < b_A49_Curr_AVM_Chg_1yr_Pct_i and b_A49_Curr_AVM_Chg_1yr_Pct_i <= 83.45) => 0.1451529773,
      (b_A49_Curr_AVM_Chg_1yr_Pct_i > 83.45) => 0.0058702391,
      (b_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
         map(
         (NULL < (real)BT_cen_high_hval and (real)BT_cen_high_hval <= 68.15) => 0.0096688278,
         ((real)BT_cen_high_hval > 68.15) => 0.1091963575,
         ((real)BT_cen_high_hval = NULL) => 0.0177643685, 0.0177643685), 0.0170144034),
   (final_model_segment = '') => 0.0020789528, 0.0020789528),
(s_inq_ssns_per_addr_i > 5.5) => -0.0335628472,
(s_inq_ssns_per_addr_i = NULL) => -0.0500161262, -0.0002925605);

// Tree: 205 
final_score_205 := map(
(NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 71.5) => -0.0044318176,
(b_phones_per_addr_curr_i > 71.5) => 0.1015620155,
(b_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < s_rel_incomeover50_count_d and s_rel_incomeover50_count_d <= 2.5) => 0.1502031039,
   (s_rel_incomeover50_count_d > 2.5) => -0.0269770593,
   (s_rel_incomeover50_count_d = NULL) => 
      map(
      (NULL < (real)ST_cen_med_hval and (real)ST_cen_med_hval <= 317091) => -0.0189163392,
      ((real)ST_cen_med_hval > 317091) => 
         map(
         (NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.0648457681) => 0.0510501650,
         (b_add_input_nhood_MFD_pct_i > 0.0648457681) => 0.0057243063,
         (b_add_input_nhood_MFD_pct_i = NULL) => 0.1092842937, 0.0280558333),
      ((real)ST_cen_med_hval = NULL) => -0.0025484675, -0.0025484675), -0.0025592067), -0.0037416295);

// Tree: 206 
final_score_206 := map(
(NULL < btst_firstscore_d and btst_firstscore_d <= 96.5) => -0.0259069748,
(btst_firstscore_d > 96.5) => 
   map(
   (pf_cid_result in ['Match','No Match','Null']) => 
      map(
      (NULL < (real)ST_cen_ownocc_p and (real)ST_cen_ownocc_p <= 9.95) => -0.0389123368,
      ((real)ST_cen_ownocc_p > 9.95) => 
         map(
         (NULL < s_addrchangeincomediff_d and s_addrchangeincomediff_d <= -30746.5) => 0.0979151518,
         (s_addrchangeincomediff_d > -30746.5) => 0.0064068060,
         (s_addrchangeincomediff_d = NULL) => 0.0052639892, 0.0116740343),
      ((real)ST_cen_ownocc_p = NULL) => 0.1128787775, 0.0096390493),
   (pf_cid_result in ['Invalid','Other']) => 0.0950062527,
   (pf_cid_result = '') => 0.0102240163, 0.0102240163),
(btst_firstscore_d = NULL) => -0.0501083020, -0.0038395227);

// Tree: 207 
final_score_207 := map(
(NULL < (real)BT_cen_families and (real)BT_cen_families <= 2670.5) => 
   map(
   (pf_pmt_type in ['American Express','Dell Credit Card','Diners Club','Discover','Gift Card','Mastercard','Other']) => -0.0117599825,
   (pf_pmt_type in ['Credit Terms','Prepaid Check','Visa']) => 
      map(
      (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0158608735,
      (pf_product_desc > 2.5) => 
         map(
         (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0831013103) => 0.0545222395,
         (s_add_input_nhood_BUS_pct_i > 0.0831013103) => -0.0008579083,
         (s_add_input_nhood_BUS_pct_i = NULL) => 0.0017805850, 0.0280077051),
      (pf_product_desc = NULL) => 0.0070476258, 0.0070476258),
   (pf_pmt_type = '') => -0.0029830123, -0.0029830123),
((real)BT_cen_families > 2670.5) => 0.1525244247,
((real)BT_cen_families = NULL) => -0.0291294129, -0.0054314689);

// Tree: 208 
final_score_208 := map(
(NULL < b_inq_count24_i and b_inq_count24_i <= 5.5) => 
   map(
   (NULL < b_srchcountwk_i and b_srchcountwk_i <= 1.5) => 
      map(
      (NULL < b_I61_inq_collection_count12_i and b_I61_inq_collection_count12_i <= 1.5) => 
         map(
         (NULL < b_C14_addrs_15yr_i and b_C14_addrs_15yr_i <= 11.5) => 0.0012369169,
         (b_C14_addrs_15yr_i > 11.5) => 0.1114608698,
         (b_C14_addrs_15yr_i = NULL) => 0.0018400246, 0.0018400246),
      (b_I61_inq_collection_count12_i > 1.5) => 0.1713656947,
      (b_I61_inq_collection_count12_i = NULL) => 0.0036206407, 0.0036206407),
   (b_srchcountwk_i > 1.5) => 0.1228173796,
   (b_srchcountwk_i = NULL) => 0.0042625187, 0.0042625187),
(b_inq_count24_i > 5.5) => -0.0355883091,
(b_inq_count24_i = NULL) => 0.0015149688, -0.0056679422);

// Tree: 209 
final_score_209 := map(
(final_model_segment in ['CONS ADDR- LNAME   OTH']) => -0.0377896016,
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < b_inq_ssns_per_addr_i and b_inq_ssns_per_addr_i <= 4.5) => 
      map(
      (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 172.5) => -0.0078835683,
      ((real)BT_cen_very_rich > 172.5) => 
         map(
         (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 18.5) => 0.0213777644,
         (btst_distphone2addr2_i > 18.5) => 0.1230198064,
         (btst_distphone2addr2_i = NULL) => 0.0116623732, 0.0175181179),
      ((real)BT_cen_very_rich = NULL) => 0.0910406865, -0.0023460686),
   (b_inq_ssns_per_addr_i > 4.5) => -0.0429769395,
   (b_inq_ssns_per_addr_i = NULL) => -0.0500980877, -0.0077013353),
(final_model_segment = '') => -0.0078422254, -0.0078422254);

// Tree: 210 
final_score_210 := map(
(NULL < b_C12_source_profile_d and b_C12_source_profile_d <= 57.6) => 
   map(
   (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 5.5) => 
      map(
      (NULL < (real)BT_cen_easiqlife and (real)BT_cen_easiqlife <= 49.5) => 0.1777888136,
      ((real)BT_cen_easiqlife > 49.5) => 
         map(
         (NULL < (real)ST_cen_families and (real)ST_cen_families <= 1369.5) => 0.0063616523,
         ((real)ST_cen_families > 1369.5) => 0.1431105003,
         ((real)ST_cen_families = NULL) => 0.0093898902, 0.0093898902),
      ((real)BT_cen_easiqlife = NULL) => 0.0113624086, 0.0113624086),
   (b_inq_lnames_per_addr_i > 5.5) => 0.0997458013,
   (b_inq_lnames_per_addr_i = NULL) => 0.0125943714, 0.0125943714),
(b_C12_source_profile_d > 57.6) => -0.0113415804,
(b_C12_source_profile_d = NULL) => 0.0044173095, -0.0017515011);

// Tree: 211 
final_score_211 := map(
(NULL < (real)ST_cen_vacant_p and (real)ST_cen_vacant_p <= 2.95) => -0.0393955911,
((real)ST_cen_vacant_p > 2.95) => 
   map(
   (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 64.5) => -0.0044991938,
   (btst_distphone2addr2_i > 64.5) => 
      map(
      (bf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => -0.0015148514,
      (bf_seg_FraudPoint_3_0 in ['2: Synth ID','6: Other']) => 0.1244667983,
      (bf_seg_FraudPoint_3_0 = '') => -0.0500850291, 0.0125616735),
   (btst_distphone2addr2_i = NULL) => 
      map(
      (NULL < s_rel_homeover500_count_d and s_rel_homeover500_count_d <= 9.5) => 0.0074295409,
      (s_rel_homeover500_count_d > 9.5) => 0.0890082096,
      (s_rel_homeover500_count_d = NULL) => 0.0065396228, 0.0092956250), 0.0044297097),
((real)ST_cen_vacant_p = NULL) => 0.0213803997, 0.0005238398);

// Tree: 212 
final_score_212 := map(
(NULL < b_addrchangecrimediff_i and b_addrchangecrimediff_i <= 21.5) => 
   map(
   (NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 0.5) => 0.0263781706,
   (b_C20_email_verification_d > 0.5) => -0.0198487868,
   (b_C20_email_verification_d = NULL) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 523.88) => 
         map(
         (NULL < s_phone_ver_experian_d and s_phone_ver_experian_d <= 0.5) => 0.1268143562,
         (s_phone_ver_experian_d > 0.5) => 0.0229104172,
         (s_phone_ver_experian_d = NULL) => 0.0479099561, 0.0571784901),
      (pf_order_amt_c > 523.88) => -0.0000982150,
      (pf_order_amt_c = NULL) => 0.0133468091, 0.0133468091), -0.0013970930),
(b_addrchangecrimediff_i > 21.5) => -0.0333428108,
(b_addrchangecrimediff_i = NULL) => -0.0113360786, -0.0080720207);

// Tree: 213 
final_score_213 := map(
(NULL < (real)BT_cen_families and (real)BT_cen_families <= 2658.5) => 
   map(
   (NULL < s_comb_age_d and s_comb_age_d <= 16.5) => 0.1719116441,
   (s_comb_age_d > 16.5) => 0.0002183987,
   (s_comb_age_d = NULL) => 
      map(
      (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.35) => -0.0107816447,
      ((real)ST_cen_pop_0_5_p > 12.35) => 
         map(
         (NULL < (real)ST_cen_rental and (real)ST_cen_rental <= 102.5) => 0.0779534799,
         ((real)ST_cen_rental > 102.5) => -0.0203228900,
         ((real)ST_cen_rental = NULL) => 0.0259248135, 0.0259248135),
      ((real)ST_cen_pop_0_5_p = NULL) => -0.0083200677, -0.0083200677), -0.0003722764),
((real)BT_cen_families > 2658.5) => 0.1213963485,
((real)BT_cen_families = NULL) => -0.0086246116, -0.0009294331);

// Tree: 214 
final_score_214 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 45.5) => 
   map(
   (NULL < s_mos_liens_rel_OT_lseen_d and s_mos_liens_rel_OT_lseen_d <= 26.5) => 0.0858733409,
   (s_mos_liens_rel_OT_lseen_d > 26.5) => -0.0061212895,
   (s_mos_liens_rel_OT_lseen_d = NULL) => 
      map(
      (NULL < (real)ST_cen_urban_p and (real)ST_cen_urban_p <= 15.6) => 
         map(
         (final_model_segment in ['BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => -0.0379375486,
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.1597161402,
         (final_model_segment = '') => 0.0743297466, 0.0743297466),
      ((real)ST_cen_urban_p > 15.6) => -0.0170030023,
      ((real)ST_cen_urban_p = NULL) => -0.0613554233, -0.0237623296), -0.0091801971),
(s_L79_adls_per_addr_c6_i > 45.5) => 0.0501661093,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0088409516, -0.0088409516);

// Tree: 215 
final_score_215 := map(
(pf_avs_result in ['International','Not Supported']) => -0.0362456014,
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < s_mos_foreclosure_lseen_d and s_mos_foreclosure_lseen_d <= 52.5) => 
      map(
      (NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 44.5) => 0.1571359195,
      ((real)ST_cen_no_move > 44.5) => -0.0056745586,
      ((real)ST_cen_no_move = NULL) => 0.0517879631, 0.0517879631),
   (s_mos_foreclosure_lseen_d > 52.5) => -0.0058404649,
   (s_mos_foreclosure_lseen_d = NULL) => 
      map(
      (NULL < s_add_input_nhood_SFD_pct_d and s_add_input_nhood_SFD_pct_d <= 0.9497967755) => 0.0104220879,
      (s_add_input_nhood_SFD_pct_d > 0.9497967755) => -0.0599775822,
      (s_add_input_nhood_SFD_pct_d = NULL) => 0.0060993012, 0.0060993012), -0.0029738606),
(pf_avs_result = '') => -0.0030810974, -0.0030810974);

// Tree: 216 
final_score_216 := map(
(NULL < b_sourcerisktype_i and b_sourcerisktype_i <= 8.5) => 0.0004689466,
(b_sourcerisktype_i > 8.5) => 0.1122504700,
(b_sourcerisktype_i = NULL) => 
   map(
   (NULL < (real)BT_cen_urban_p and (real)BT_cen_urban_p <= 51.65) => 
      map(
      (NULL < b_L71_Add_Business_i and b_L71_Add_Business_i <= 0.5) => 0.1689341385,
      (b_L71_Add_Business_i > 0.5) => -0.0596206141,
      (b_L71_Add_Business_i = NULL) => 0.0546567622, 0.0546567622),
   ((real)BT_cen_urban_p > 51.65) => 
      map(
      (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 6.5) => -0.0265923850,
      (btst_distphone2addr2_i > 6.5) => 0.0924882258,
      (btst_distphone2addr2_i = NULL) => -0.0064040889, -0.0085483380),
   ((real)BT_cen_urban_p = NULL) => -0.0086485315, -0.0061384992), -0.0004766404);

// Tree: 217 
final_score_217 := map(
(NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1853.5) => -0.0063967590,
(b_P88_Phn_Dst_to_Inp_Add_i > 1853.5) => 0.0696720903,
(b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
   map(
   (NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 0.5) => -0.0621359260,
   (pf_pmt_x_avs_lvl > 0.5) => 
      map(
      (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 12.25) => 
         map(
         (NULL < s_C12_source_profile_d and s_C12_source_profile_d <= 84.8) => -0.0068327074,
         (s_C12_source_profile_d > 84.8) => 0.1257623607,
         (s_C12_source_profile_d = NULL) => 0.0081755341, 0.0001564226),
      ((real)ST_cen_unemp > 12.25) => 0.1273219120,
      ((real)ST_cen_unemp = NULL) => 0.0589673006, 0.0082013144),
   (pf_pmt_x_avs_lvl = NULL) => 0.0074509171, 0.0074509171), -0.0013045289);

// Tree: 218 
final_score_218 := map(
(NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 18.5) => 
   map(
   (NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 51.5) => 
      map(
      (NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 4.5) => 
         map(
         (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 0.0380262890,
         (s_C20_email_verification_d > 0.5) => -0.0038437846,
         (s_C20_email_verification_d = NULL) => -0.0059203194, 0.0035485858),
      (s_inq_adls_per_addr_i > 4.5) => 0.0674498300,
      (s_inq_adls_per_addr_i = NULL) => 0.0041251944, 0.0041251944),
   ((real)ST_cen_no_move > 51.5) => -0.0154450566,
   ((real)ST_cen_no_move = NULL) => 0.0088032355, -0.0060566476),
(b_phones_per_addr_c6_i > 18.5) => 0.0711443380,
(b_phones_per_addr_c6_i = NULL) => -0.0057374024, -0.0057374024);

// Tree: 219 
final_score_219 := map(
(NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 18.5) => 
   map(
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => 
      map(
      (NULL < b_pb_order_freq_d and b_pb_order_freq_d <= 246) => -0.0208273312,
      (b_pb_order_freq_d > 246) => 0.0893820577,
      (b_pb_order_freq_d = NULL) => 
         map(
         (pf_ship_method in ['Next Day']) => -0.0391517459,
         (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => -0.0177653231,
         (pf_ship_method = '') => -0.0198068675, -0.0198068675), -0.0143951804),
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0020430344,
   (final_model_segment = '') => 0.0007885919, 0.0007885919),
(b_phones_per_addr_c6_i > 18.5) => 0.0731078454,
(b_phones_per_addr_c6_i = NULL) => 0.0010700582, 0.0010700582);

// Tree: 220 
final_score_220 := map(
(NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0827882985) => 
   map(
   (NULL < s_corrrisktype_i and s_corrrisktype_i <= 8.5) => -0.0027787951,
   (s_corrrisktype_i > 8.5) => 
      map(
      (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0360197275,
      (pf_product_desc > 2.5) => 
         map(
         (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 3.15) => 0.0070095163,
         ((real)ST_cen_unemp > 3.15) => 0.0841704641,
         ((real)ST_cen_unemp = NULL) => 0.0543690648, 0.0543690648),
      (pf_product_desc = NULL) => 0.0183334446, 0.0183334446),
   (s_corrrisktype_i = NULL) => 0.0027828058, 0.0018070648),
(s_add_input_nhood_BUS_pct_i > 0.0827882985) => -0.0123691887,
(s_add_input_nhood_BUS_pct_i = NULL) => -0.0348723198, -0.0066204371);

// Tree: 221 
final_score_221 := map(
(pf_avs_result in ['International','Not Supported']) => -0.0412024063,
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 7.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
         map(
         (NULL < b_A49_Curr_AVM_Chg_1yr_Pct_i and b_A49_Curr_AVM_Chg_1yr_Pct_i <= 84.15) => 0.0821335395,
         (b_A49_Curr_AVM_Chg_1yr_Pct_i > 84.15) => -0.0175460206,
         (b_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0224586580, -0.0174648363),
      (final_model_segment in ['BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.0034397181,
      (final_model_segment = '') => -0.0021531042, -0.0021531042),
   (b_inq_lnames_per_addr_i > 7.5) => 0.0305545472,
   (b_inq_lnames_per_addr_i = NULL) => -0.0500916822, -0.0070285016),
(pf_avs_result = '') => -0.0071344898, -0.0071344898);

// Tree: 222 
final_score_222 := map(
(NULL < b_curraddrcrimeindex_i and b_curraddrcrimeindex_i <= 194.5) => -0.0053176608,
(b_curraddrcrimeindex_i > 194.5) => 0.0894676132,
(b_curraddrcrimeindex_i = NULL) => 
   map(
   (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 17.65) => -0.0158652435,
   ((real)ST_cen_blue_col > 17.65) => 
      map(
      (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 24.4) => 
         map(
         (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 94.5) => 0.0847119225,
         ((real)ST_cen_easiqlife > 94.5) => -0.0342335146,
         ((real)ST_cen_easiqlife = NULL) => 0.0081875853, 0.0081875853),
      ((real)BT_cen_high_ed > 24.4) => 0.2352505894,
      ((real)BT_cen_high_ed = NULL) => -0.0500837278, 0.0133980521),
   ((real)ST_cen_blue_col = NULL) => -0.0505541327, -0.0197600643), -0.0076400083);

// Tree: 223 
final_score_223 := map(
(NULL < btst_firstscore_d and btst_firstscore_d <= 96.5) => -0.0301329723,
(btst_firstscore_d > 96.5) => 
   map(
   (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
      map(
      (NULL < s_C12_source_profile_index_d and s_C12_source_profile_index_d <= 0.5) => 
         map(
         (NULL < (real)ST_cen_med_hval and (real)ST_cen_med_hval <= 836480.5) => 0.0211156639,
         ((real)ST_cen_med_hval > 836480.5) => 0.1814282782,
         ((real)ST_cen_med_hval = NULL) => 0.0272251385, 0.0272251385),
      (s_C12_source_profile_index_d > 0.5) => -0.0052629890,
      (s_C12_source_profile_index_d = NULL) => -0.0021118871, -0.0011256244),
   (b_inq_lnames_per_addr_i > 8.5) => 0.0367554315,
   (b_inq_lnames_per_addr_i = NULL) => -0.0009457143, -0.0009457143),
(btst_firstscore_d = NULL) => -0.0500851303, -0.0120035619);

// Tree: 224 
final_score_224 := map(
(final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => 
   map(
   (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.20511827155) => 
      map(
      (NULL < b_add_curr_mobility_index_i and b_add_curr_mobility_index_i <= 0.1818604823) => -0.0022512557,
      (b_add_curr_mobility_index_i > 0.1818604823) => -0.0546755715,
      (b_add_curr_mobility_index_i = NULL) => -0.0256472313, -0.0256472313),
   (b_add_input_mobility_index_i > 0.20511827155) => 
      map(
      (NULL < b_vardobcountnew_i and b_vardobcountnew_i <= 0.5) => -0.0512253898,
      (b_vardobcountnew_i > 0.5) => 0.0292909125,
      (b_vardobcountnew_i = NULL) => -0.0199512886, -0.0284608799),
   (b_add_input_mobility_index_i = NULL) => -0.0280317664, -0.0280317664),
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0030628687,
(final_model_segment = '') => 0.0009639241, 0.0009639241);

// Tree: 225 
final_score_225 := map(
(NULL < s_I60_inq_auto_count12_i and s_I60_inq_auto_count12_i <= 3.5) => 
   map(
   (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 140.5) => -0.0096430520,
   ((real)ST_cen_easiqlife > 140.5) => 0.0255883586,
   ((real)ST_cen_easiqlife = NULL) => 0.0306846576, 0.0008080708),
(s_I60_inq_auto_count12_i > 3.5) => 
   map(
   (NULL < (real)ST_cen_med_hval and (real)ST_cen_med_hval <= 259122.5) => 0.1651788396,
   ((real)ST_cen_med_hval > 259122.5) => -0.0524961487,
   ((real)ST_cen_med_hval = NULL) => 0.0511586076, 0.0511586076),
(s_I60_inq_auto_count12_i = NULL) => 
   map(
   (NULL < (real)ST_cen_mil_emp and (real)ST_cen_mil_emp <= 2.65) => -0.0082311346,
   ((real)ST_cen_mil_emp > 2.65) => 0.0801276039,
   ((real)ST_cen_mil_emp = NULL) => -0.0597604084, -0.0182724992), -0.0025382486);

// Tree: 226 
final_score_226 := map(
(NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 77.5) => 
   map(
   (NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 16.35) => -0.0404380775,
   ((real)BT_cen_ownocc_p > 16.35) => 
      map(
      (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 31.5) => -0.0028073123,
      (btst_distaddraddr2_i > 31.5) => 
         map(
         (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 11.95) => 0.1755828467,
         ((real)BT_cen_high_ed > 11.95) => 0.0160347757,
         ((real)BT_cen_high_ed = NULL) => 0.0253335897, 0.0253335897),
      (btst_distaddraddr2_i = NULL) => 0.0000296213, 0.0000296213),
   ((real)BT_cen_ownocc_p = NULL) => -0.0137902604, -0.0047682136),
(s_inq_per_phone_i > 77.5) => 0.0814295709,
(s_inq_per_phone_i = NULL) => 0.0042375768, -0.0040304332);

// Tree: 227 
final_score_227 := map(
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < s_srchunvrfdaddrcount_i and s_srchunvrfdaddrcount_i <= 0.5) => -0.0048014134,
   (s_srchunvrfdaddrcount_i > 0.5) => 
      map(
      (pf_cid_result in ['Match','No Match']) => 
         map(
         (NULL < s_curraddrburglaryindex_i and s_curraddrburglaryindex_i <= 112) => -0.0512254461,
         (s_curraddrburglaryindex_i > 112) => 0.1582568368,
         (s_curraddrburglaryindex_i = NULL) => -0.0119750815, -0.0119750815),
      (pf_cid_result in ['Invalid','Null','Other']) => 0.3084856014,
      (pf_cid_result = '') => 0.0228968127, 0.0228968127),
   (s_srchunvrfdaddrcount_i = NULL) => -0.0084808823, -0.0046064833),
(pf_avs_result in ['International','Not Supported']) => 0.0517564908,
(pf_avs_result = '') => -0.0044213945, -0.0044213945);

// Tree: 228 
final_score_228 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 43.5) => 
   map(
   (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 57) => 
      map(
      (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 161.5) => -0.0017989283,
      ((real)ST_cen_easiqlife > 161.5) => 
         map(
         (NULL < s_bus_name_nover_i and s_bus_name_nover_i <= 0.5) => 0.1147701815,
         (s_bus_name_nover_i > 0.5) => -0.0063317378,
         (s_bus_name_nover_i = NULL) => 0.0295571288, 0.0295571288),
      ((real)ST_cen_easiqlife = NULL) => -0.0546562924, -0.0008353546),
   (s_inq_per_phone_i > 57) => 0.0857492834,
   (s_inq_per_phone_i = NULL) => 0.0722881012, 0.0033726811),
(b_L79_adls_per_addr_c6_i > 43.5) => 0.0502591419,
(b_L79_adls_per_addr_c6_i = NULL) => 0.0035979323, 0.0035979323);

// Tree: 229 
final_score_229 := map(
(NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 5.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 29.65) => -0.0006903062,
      ((real)ST_cen_blue_col > 29.65) => 0.1024542913,
      ((real)ST_cen_blue_col = NULL) => 0.0521737323, 0.0001506068),
   (final_model_segment in ['CONS ADDR+ DIFF    OTH']) => 
      map(
      (NULL < b_add_input_nhood_VAC_pct_i and b_add_input_nhood_VAC_pct_i <= 0.0422418597) => 0.1657810213,
      (b_add_input_nhood_VAC_pct_i > 0.0422418597) => -0.0063507276,
      (b_add_input_nhood_VAC_pct_i = NULL) => 0.0636215280, 0.0636215280),
   (final_model_segment = '') => 0.0006483703, 0.0006483703),
(s_inq_adls_per_addr_i > 5.5) => -0.0327049613,
(s_inq_adls_per_addr_i = NULL) => -0.0500193611, -0.0016028117);

// Tree: 230 
final_score_230 := map(
(NULL < s_I61_inq_collection_count12_i and s_I61_inq_collection_count12_i <= 8.5) => 0.0011415521,
(s_I61_inq_collection_count12_i > 8.5) => 0.1778819035,
(s_I61_inq_collection_count12_i = NULL) => 
   map(
   (NULL < b_inq_adls_per_phone_i and b_inq_adls_per_phone_i <= 0.5) => 
      map(
      (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 2.5) => 0.0035513168,
      (s_inq_per_addr_i > 2.5) => 
         map(
         (NULL < b_C23_inp_addr_occ_index_d and b_C23_inp_addr_occ_index_d <= 2) => 0.1204914745,
         (b_C23_inp_addr_occ_index_d > 2) => 0.0367433378,
         (b_C23_inp_addr_occ_index_d = NULL) => 0.0392756892, 0.0504516493),
      (s_inq_per_addr_i = NULL) => 0.0147476827, 0.0147476827),
   (b_inq_adls_per_phone_i > 0.5) => -0.0399608625,
   (b_inq_adls_per_phone_i = NULL) => -0.0503452156, -0.0167275714), -0.0016897095);

// Tree: 231 
final_score_231 := map(
(NULL < b_mos_liens_unrel_ST_lseen_d and b_mos_liens_unrel_ST_lseen_d <= 78.5) => 
   map(
   (NULL < b_M_Bureau_ADL_FS_all_d and b_M_Bureau_ADL_FS_all_d <= 308.5) => 0.1483492121,
   (b_M_Bureau_ADL_FS_all_d > 308.5) => -0.0127879566,
   (b_M_Bureau_ADL_FS_all_d = NULL) => 0.0626997260, 0.0626997260),
(b_mos_liens_unrel_ST_lseen_d > 78.5) => 
   map(
   (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
      map(
      (NULL < (real)BT_cen_families and (real)BT_cen_families <= 608.5) => 0.0002559245,
      ((real)BT_cen_families > 608.5) => 0.0643100326,
      ((real)BT_cen_families = NULL) => 0.0144157957, 0.0144157957),
   (s_C20_email_verification_d > 0.5) => -0.0170765941,
   (s_C20_email_verification_d = NULL) => 0.0020071166, -0.0051159586),
(b_mos_liens_unrel_ST_lseen_d = NULL) => -0.0051358320, -0.0046621906);

// Tree: 232 
final_score_232 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (NULL < b_sourcerisktype_i and b_sourcerisktype_i <= 8.5) => 
      map(
      (NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 4.5) => 0.0410460203,
      ((real)ST_cen_no_move > 4.5) => -0.0026089890,
      ((real)ST_cen_no_move = NULL) => -0.0598456024, -0.0001314502),
   (b_sourcerisktype_i > 8.5) => 0.1136321029,
   (b_sourcerisktype_i = NULL) => 
      map(
      (NULL < (real)ST_cen_mil_emp and (real)ST_cen_mil_emp <= 2.45) => -0.0072559377,
      ((real)ST_cen_mil_emp > 2.45) => 0.1024405296,
      ((real)ST_cen_mil_emp = NULL) => -0.0049037717, -0.0049037717), -0.0005430571),
(s_inq_ssns_per_addr_i > 4.5) => -0.0290247236,
(s_inq_ssns_per_addr_i = NULL) => -0.0500135150, -0.0028662795);

// Tree: 233 
final_score_233 := map(
(NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 18.5) => 0.0899217245,
(s_mos_liens_unrel_OT_lseen_d > 18.5) => -0.0014169717,
(s_mos_liens_unrel_OT_lseen_d = NULL) => 
   map(
   (NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.115483141) => -0.0241334904,
   (b_add_input_nhood_MFD_pct_i > 0.115483141) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.0675810005) => -0.0267117263,
      (b_add_input_nhood_BUS_pct_i > 0.0675810005) => -0.0026245310,
      (b_add_input_nhood_BUS_pct_i = NULL) => -0.0077908344, -0.0077908344),
   (b_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 9.6) => 0.0010958971,
      ((real)ST_cen_pop_0_5_p > 9.6) => 0.0971465701,
      ((real)ST_cen_pop_0_5_p = NULL) => 0.0222204437, 0.0222204437), -0.0084887399), -0.0024274701);

// Tree: 234 
final_score_234 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 129626) => -0.0130401710,
   (b_L80_Inp_AVM_AutoVal_d > 129626) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 152.5) => 0.0069344771,
      ((real)ST_cen_span_lang > 152.5) => 
         map(
         (NULL < s_C10_M_Hdr_FS_d and s_C10_M_Hdr_FS_d <= 58.5) => 0.1542993108,
         (s_C10_M_Hdr_FS_d > 58.5) => 0.0317886080,
         (s_C10_M_Hdr_FS_d = NULL) => 0.0646117974, 0.0414715193),
      ((real)ST_cen_span_lang = NULL) => 0.0137793365, 0.0137793365),
   (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0045872751, 0.0006486658),
(s_inq_ssns_per_addr_i > 4.5) => -0.0408099314,
(s_inq_ssns_per_addr_i = NULL) => -0.0500170519, -0.0016638698);

// Tree: 235 
final_score_235 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < (real)ST_cen_vacant_p and (real)ST_cen_vacant_p <= 3.55) => -0.0325321956,
   ((real)ST_cen_vacant_p > 3.55) => 
      map(
      (NULL < (real)ST_cen_vacant_p and (real)ST_cen_vacant_p <= 3.65) => 
         map(
         (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.0376732727) => -0.0509102692,
         (b_add_input_nhood_BUS_pct_i > 0.0376732727) => 0.1988108533,
         (b_add_input_nhood_BUS_pct_i = NULL) => 0.0920335458, 0.0920335458),
      ((real)ST_cen_vacant_p > 3.65) => 0.0026869785,
      ((real)ST_cen_vacant_p = NULL) => 0.0037938080, 0.0037938080),
   ((real)ST_cen_vacant_p = NULL) => -0.0303223157, -0.0029137507),
(b_inq_lnames_per_addr_i > 8.5) => 0.0316479965,
(b_inq_lnames_per_addr_i = NULL) => -0.0500725598, -0.0076756068);

// Tree: 236 
final_score_236 := map(
(NULL < s_srchaddrsrchcountwk_i and s_srchaddrsrchcountwk_i <= 0.5) => -0.0012119552,
(s_srchaddrsrchcountwk_i > 0.5) => 
   map(
   (NULL < b_prevaddrlenofres_d and b_prevaddrlenofres_d <= 44) => -0.0592033356,
   (b_prevaddrlenofres_d > 44) => 0.0750993841,
   (b_prevaddrlenofres_d = NULL) => 0.0115294301, 0.0115294301),
(s_srchaddrsrchcountwk_i = NULL) => 
   map(
   (bf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','6: Other']) => 
      map(
      (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0252468751,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH']) => 0.0165575592,
      (final_model_segment = '') => 0.0051196962, 0.0051196962),
   (bf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly']) => 0.0987246236,
   (bf_seg_FraudPoint_3_0 = '') => -0.0500741583, -0.0117959055), -0.0031025499);

// Tree: 237 
final_score_237 := map(
(NULL < s_I60_inq_auto_count12_i and s_I60_inq_auto_count12_i <= 1.5) => -0.0049606374,
(s_I60_inq_auto_count12_i > 1.5) => 
   map(
   (NULL < (real)ST_cen_families and (real)ST_cen_families <= 667.5) => 0.0216162469,
   ((real)ST_cen_families > 667.5) => 0.1902865481,
   ((real)ST_cen_families = NULL) => 0.0515703807, 0.0515703807),
(s_I60_inq_auto_count12_i = NULL) => 
   map(
   (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 12.85) => -0.0104745436,
   ((real)ST_cen_pop_0_5_p > 12.85) => 
      map(
      (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0221572811,
      (pf_product_desc > 2.5) => 0.0807637146,
      (pf_product_desc = NULL) => 0.0207264671, 0.0207264671),
   ((real)ST_cen_pop_0_5_p = NULL) => 0.0707600814, 0.0090407972), -0.0006012432);

// Tree: 238 
final_score_238 := map(
(NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 83.5) => 
   map(
   (NULL < (real)ST_cen_vacant_p and (real)ST_cen_vacant_p <= 2.95) => -0.0388056851,
   ((real)ST_cen_vacant_p > 2.95) => 
      map(
      (NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 74.55) => -0.0074812222,
      ((real)BT_cen_ownocc_p > 74.55) => 
         map(
         (NULL < btst_distphoneaddr2_i and btst_distphoneaddr2_i <= 428) => -0.0067938349,
         (btst_distphoneaddr2_i > 428) => 0.0759635619,
         (btst_distphoneaddr2_i = NULL) => 0.0347061381, 0.0190016698),
      ((real)BT_cen_ownocc_p = NULL) => -0.0505228565, -0.0028576281),
   ((real)ST_cen_vacant_p = NULL) => -0.0399035208, -0.0074464521),
(s_inq_per_phone_i > 83.5) => 0.0694752706,
(s_inq_per_phone_i = NULL) => 0.0054202212, -0.0065506061);

// Tree: 239 
final_score_239 := map(
(pf_avs_result in ['International','Not Supported']) => -0.0421638667,
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < s_prevaddrstatus_i and s_prevaddrstatus_i <= 2.5) => -0.0234060272,
   (s_prevaddrstatus_i > 2.5) => 
      map(
      (NULL < (real)ST_cen_business and (real)ST_cen_business <= 3.5) => 
         map(
         (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 143.5) => -0.0107683436,
         ((real)BT_cen_span_lang > 143.5) => 0.2133827075,
         ((real)BT_cen_span_lang = NULL) => 0.0704458054, 0.0704458054),
      ((real)ST_cen_business > 3.5) => 0.0156079979,
      ((real)ST_cen_business = NULL) => 0.0190398925, 0.0190398925),
   (s_prevaddrstatus_i = NULL) => 0.0020498384, -0.0006645692),
(pf_avs_result = '') => -0.0008033712, -0.0008033712);

// Tree: 240 
final_score_240 := map(
(NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 2403) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
      map(
      (NULL < b_A49_Curr_AVM_Chg_1yr_i and b_A49_Curr_AVM_Chg_1yr_i <= -363553) => 0.2506180839,
      (b_A49_Curr_AVM_Chg_1yr_i > -363553) => 0.0012702389,
      (b_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0048533364, -0.0012315967),
   (s_inq_ssns_per_addr_i > 5.5) => -0.0334388317,
   (s_inq_ssns_per_addr_i = NULL) => -0.0500155061, -0.0033915540),
(btst_distaddraddr2_i > 2403) => 
   map(
   (NULL < b_I60_Inq_Count12_i and b_I60_Inq_Count12_i <= 1.5) => 0.1276428696,
   (b_I60_Inq_Count12_i > 1.5) => -0.0505901176,
   (b_I60_Inq_Count12_i = NULL) => 0.0402401547, 0.0402401547),
(btst_distaddraddr2_i = NULL) => -0.0029959400, -0.0029959400);

// Tree: 241 
final_score_241 := map(
(NULL < s_E57_br_source_count_d and s_E57_br_source_count_d <= 0.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 3.5) => 0.0107325270,
   (pf_product_desc > 3.5) => 
      map(
      (NULL < pf_product_desc and pf_product_desc <= 6.5) => 
         map(
         (pf_pmt_type in ['American Express','Dell Credit Card','Diners Club','Discover']) => -0.0306978560,
         (pf_pmt_type in ['Credit Terms','Gift Card','Mastercard','Other','Prepaid Check','Visa']) => 0.1872380290,
         (pf_pmt_type = '') => 0.1029694868, 0.1029694868),
      (pf_product_desc > 6.5) => -0.0538171062,
      (pf_product_desc = NULL) => 0.0371615745, 0.0371615745),
   (pf_product_desc = NULL) => 0.0135821240, 0.0135821240),
(s_E57_br_source_count_d > 0.5) => -0.0124856328,
(s_E57_br_source_count_d = NULL) => 0.0009673382, -0.0022811663);

// Tree: 242 
final_score_242 := map(
(NULL < s_inq_Communications_count24_i and s_inq_Communications_count24_i <= 1.5) => -0.0028473648,
(s_inq_Communications_count24_i > 1.5) => 
   map(
   (NULL < s_rel_incomeover75_count_d and s_rel_incomeover75_count_d <= 1.5) => -0.0493643858,
   (s_rel_incomeover75_count_d > 1.5) => 0.1229267917,
   (s_rel_incomeover75_count_d = NULL) => 0.0359607688, 0.0359607688),
(s_inq_Communications_count24_i = NULL) => 
   map(
   (NULL < b_inq_count24_i and b_inq_count24_i <= 2.5) => 
      map(
      (NULL < b_F03_address_match_d and b_F03_address_match_d <= 3) => -0.0125790110,
      (b_F03_address_match_d > 3) => 0.0748780430,
      (b_F03_address_match_d = NULL) => 0.0127971290, 0.0127971290),
   (b_inq_count24_i > 2.5) => -0.0459783383,
   (b_inq_count24_i = NULL) => -0.0020097306, -0.0089544795), -0.0037752477);

// Tree: 243 
final_score_243 := map(
(NULL < s_rel_felony_count_i and s_rel_felony_count_i <= 3.5) => -0.0021449764,
(s_rel_felony_count_i > 3.5) => 0.1088336371,
(s_rel_felony_count_i = NULL) => 
   map(
   (NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.00626645695) => -0.0421025798,
   (b_add_input_nhood_MFD_pct_i > 0.00626645695) => 
      map(
      (NULL < b_estimated_income_d and b_estimated_income_d <= 127500) => -0.0304708223,
      (b_estimated_income_d > 127500) => 0.1274693542,
      (b_estimated_income_d = NULL) => -0.0001463826, -0.0068373763),
   (b_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0883004574) => 0.1174560024,
      (s_add_input_nhood_BUS_pct_i > 0.0883004574) => 0.0023284988,
      (s_add_input_nhood_BUS_pct_i = NULL) => 0.0389074715, 0.0389074715), -0.0045034944), -0.0022063411);

// Tree: 244 
final_score_244 := map(
(NULL < b_prevaddrmurderindex_i and b_prevaddrmurderindex_i <= 195.5) => -0.0052856750,
(b_prevaddrmurderindex_i > 195.5) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.1320056075) => 0.0265277706,
   (s_add_input_nhood_BUS_pct_i > 0.1320056075) => 0.1293583035,
   (s_add_input_nhood_BUS_pct_i = NULL) => 0.0687146559, 0.0687146559),
(b_prevaddrmurderindex_i = NULL) => 
   map(
   (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 298509.5) => 
      map(
      (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 4.95) => 0.0143267753,
      ((real)ST_cen_unemp > 4.95) => 0.1353250943,
      ((real)ST_cen_unemp = NULL) => 0.0501530932, 0.0501530932),
   (s_L80_Inp_AVM_AutoVal_d > 298509.5) => -0.0408635333,
   (s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0059509496, -0.0043762689), -0.0043994726);

// Tree: 245 
final_score_245 := map(
(NULL < b_C14_addrs_15yr_i and b_C14_addrs_15yr_i <= 3.5) => -0.0115603056,
(b_C14_addrs_15yr_i > 3.5) => 0.0178172378,
(b_C14_addrs_15yr_i = NULL) => 
   map(
   (NULL < s_bus_name_nover_i and s_bus_name_nover_i <= 0.5) => 
      map(
      (NULL < (real)BT_cen_health and (real)BT_cen_health <= 14.65) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => 0.0003111597,
         (final_model_segment in ['BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.1566019635,
         (final_model_segment = '') => 0.0425210848, 0.0425210848),
      ((real)BT_cen_health > 14.65) => 0.0807513404,
      ((real)BT_cen_health = NULL) => -0.0513607755, 0.0126687801),
   (s_bus_name_nover_i > 0.5) => -0.0154150022,
   (s_bus_name_nover_i = NULL) => -0.0105445399, -0.0105445399), -0.0041404572);

// Tree: 246 
final_score_246 := map(
(NULL < b_liens_unrel_ST_total_amt_i and b_liens_unrel_ST_total_amt_i <= 1647) => -0.0046845715,
(b_liens_unrel_ST_total_amt_i > 1647) => 0.1154593456,
(b_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (NULL < (real)BT_cen_blue_col and (real)BT_cen_blue_col <= 18.45) => 
      map(
      (NULL < (real)ST_cen_high_hval and (real)ST_cen_high_hval <= 5.85) => -0.0357279366,
      ((real)ST_cen_high_hval > 5.85) => 0.0214210346,
      ((real)ST_cen_high_hval = NULL) => -0.0061177021, -0.0061177021),
   ((real)BT_cen_blue_col > 18.45) => 
      map(
      (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 76.5) => 0.1423833624,
      ((real)BT_cen_no_move > 76.5) => -0.0344331736,
      ((real)BT_cen_no_move = NULL) => 0.0468766203, 0.0468766203),
   ((real)BT_cen_blue_col = NULL) => 0.0056499688, 0.0022860964), -0.0026974996);

// Tree: 247 
final_score_247 := map(
(NULL < b_C10_M_Hdr_FS_d and b_C10_M_Hdr_FS_d <= 610.5) => -0.0007509093,
(b_C10_M_Hdr_FS_d > 610.5) => 0.1378563961,
(b_C10_M_Hdr_FS_d = NULL) => 
   map(
   (NULL < (real)BT_cen_unemp and (real)BT_cen_unemp <= 4.95) => -0.0280931915,
   ((real)BT_cen_unemp > 4.95) => 
      map(
      (NULL < (real)BT_cen_totcrime and (real)BT_cen_totcrime <= 43) => 0.1427721400,
      ((real)BT_cen_totcrime > 43) => 
         map(
         (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 0.5) => -0.0048217154,
         (s_inq_ssns_per_addr_i > 0.5) => 0.0645973213,
         (s_inq_ssns_per_addr_i = NULL) => 0.0038556642, 0.0038556642),
      ((real)BT_cen_totcrime = NULL) => 0.0248293282, 0.0248293282),
   ((real)BT_cen_unemp = NULL) => -0.0505553117, -0.0315292283), -0.0063788078);

// Tree: 248 
final_score_248 := map(
(NULL < b_varmsrcssnunrelcount_i and b_varmsrcssnunrelcount_i <= 1.5) => -0.0004364701,
(b_varmsrcssnunrelcount_i > 1.5) => 0.0837516779,
(b_varmsrcssnunrelcount_i = NULL) => 
   map(
   (NULL < s_bus_name_nover_i and s_bus_name_nover_i <= 0.5) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 17.75) => 
         map(
         (NULL < b_add_input_nhood_VAC_pct_i and b_add_input_nhood_VAC_pct_i <= 0.34337939655) => -0.0056701096,
         (b_add_input_nhood_VAC_pct_i > 0.34337939655) => 0.1269636035,
         (b_add_input_nhood_VAC_pct_i = NULL) => 0.0118109028, 0.0118109028),
      ((real)ST_cen_blue_col > 17.75) => 0.1267480941,
      ((real)ST_cen_blue_col = NULL) => 0.0259407960, 0.0259407960),
   (s_bus_name_nover_i > 0.5) => -0.0146274592,
   (s_bus_name_nover_i = NULL) => -0.0077029621, -0.0077029621), -0.0016304446);

// Tree: 249 
final_score_249 := map(
(NULL < s_rel_homeover500_count_d and s_rel_homeover500_count_d <= 4.5) => -0.0048873599,
(s_rel_homeover500_count_d > 4.5) => 
   map(
   (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.1539738492) => -0.0519301409,
   (b_add_input_mobility_index_i > 0.1539738492) => 
      map(
      (NULL < s_validationrisktype_i and s_validationrisktype_i <= 1.5) => 0.0312088645,
      (s_validationrisktype_i > 1.5) => 0.2683448968,
      (s_validationrisktype_i = NULL) => 0.0403949088, 0.0403949088),
   (b_add_input_mobility_index_i = NULL) => 0.0320236225, 0.0320236225),
(s_rel_homeover500_count_d = NULL) => 
   map(
   (NULL < (real)ST_cen_mil_emp and (real)ST_cen_mil_emp <= 2.65) => -0.0034753705,
   ((real)ST_cen_mil_emp > 2.65) => 0.1213566871,
   ((real)ST_cen_mil_emp = NULL) => -0.0543159656, -0.0110116257), -0.0029285832);

// Tree: 250 
final_score_250 := map(
(NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 49.5) => 
   map(
   (NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 166) => 0.0002562649, //MODEL
   ((real)ST_cen_no_move > 166) => 0.3112547280,
   ((real)ST_cen_no_move = NULL) => 0.0902821358, 0.0902821358),
((real)ST_cen_easiqlife > 49.5) => 
   map(
   (NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 18.5) => -0.0037938564, //SAS
   (b_phones_per_addr_c6_i > 18.5) => 0.0784407649,
   (b_phones_per_addr_c6_i = NULL) => -0.0034798619, -0.0034798619),
((real)ST_cen_easiqlife = NULL) => 
   map(
   (NULL < b_hh_members_ct_d and b_hh_members_ct_d <= 2.5) => 0.1902583384,
   (b_hh_members_ct_d > 2.5) => -0.0651829064,
   (b_hh_members_ct_d = NULL) => -0.0502681071, -0.0346820485), -0.0039182817);

// Tree: 251 
final_score_251 := map(
(NULL < btst_firstscore_d and btst_firstscore_d <= 96.5) => -0.0257202720,
(btst_firstscore_d > 96.5) => 
   map(
   (NULL < s_phone_ver_experian_d and s_phone_ver_experian_d <= 0.5) => 
      map(
      (NULL < s_curraddrcartheftindex_i and s_curraddrcartheftindex_i <= 123) => 0.0151514540,
      (s_curraddrcartheftindex_i > 123) => 
         map(
         (NULL < (real)ST_cen_totcrime and (real)ST_cen_totcrime <= 134) => 0.1241849605,
         ((real)ST_cen_totcrime > 134) => -0.0078788509,
         ((real)ST_cen_totcrime = NULL) => 0.0662415956, 0.0662415956),
      (s_curraddrcartheftindex_i = NULL) => 0.0266941364, 0.0266941364),
   (s_phone_ver_experian_d > 0.5) => -0.0060405927,
   (s_phone_ver_experian_d = NULL) => 0.0004266821, 0.0068633408),
(btst_firstscore_d = NULL) => -0.0500713305, -0.0060204363);

// Tree: 252 
final_score_252 := map(
(NULL < s_srchaddrsrchcountmo_i and s_srchaddrsrchcountmo_i <= 1.5) => -0.0013118767,
(s_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (final_model_segment in ['BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.053090883) => 
         map(
         (NULL < b_rel_homeover500_count_d and b_rel_homeover500_count_d <= 0.5) => -0.0952142249,
         (b_rel_homeover500_count_d > 0.5) => -0.0167208836,
         (b_rel_homeover500_count_d = NULL) => -0.0544580669, -0.0544580669),
      (b_add_input_nhood_BUS_pct_i > 0.053090883) => 0.0089238857,
      (b_add_input_nhood_BUS_pct_i = NULL) => -0.0268721394, -0.0268721394),
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH']) => 0.1017607846,
   (final_model_segment = '') => 0.0008018761, 0.0008018761),
(s_srchaddrsrchcountmo_i = NULL) => 0.0066831766, 0.0002538585);

// Tree: 253 
final_score_253 := map(
(NULL < s_addrchangevaluediff_d and s_addrchangevaluediff_d <= -315386.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < s_F01_inp_addr_address_score_d and s_F01_inp_addr_address_score_d <= 16) => 0.0088394329,
      (s_F01_inp_addr_address_score_d > 16) => -0.0510055582,
      (s_F01_inp_addr_address_score_d = NULL) => -0.0096581098, -0.0096581098),
   (final_model_segment in ['CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.1252824481,
   (final_model_segment = '') => 0.0168619998, 0.0168619998),
(s_addrchangevaluediff_d > -315386.5) => -0.0012178850,
(s_addrchangevaluediff_d = NULL) => 
   map(
   (pf_avs_result in ['Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 0.0048798661,
   (pf_avs_result in ['Addr Only','International','Not Supported']) => 0.0569485699,
   (pf_avs_result = '') => 0.0054269021, 0.0054269021), 0.0014702699);

// Tree: 254 
final_score_254 := map(
(NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 18.5) => 
   map(
   (NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 45.5) => 
      map(
      (btst_email_topleveldomain_n in ['BIZ','COM','EDU','GOV','NET','ORG']) => -0.0013327818,
      (btst_email_topleveldomain_n in ['MIL','OTH','US']) => 
         map(
         (NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 0.3407076246) => -0.0533291935,
         (s_add_input_mobility_index_i > 0.3407076246) => 0.2523468560,
         (s_add_input_mobility_index_i = NULL) => 0.0900409890, 0.0900409890),
      (btst_email_topleveldomain_n = '') => -0.0067706336, -0.0027079020),
   (s_L79_adls_per_addr_c6_i > 45.5) => 0.0482536312,
   (s_L79_adls_per_addr_c6_i = NULL) => -0.0023967625, -0.0023967625),
(b_phones_per_addr_c6_i > 18.5) => 0.0842775267,
(b_phones_per_addr_c6_i = NULL) => -0.0020541556, -0.0020541556);

// Tree: 255 
final_score_255 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 5.5) => 
   map(
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB']) => 
      map(
      (NULL < b_inq_per_phone_i and b_inq_per_phone_i <= 10.5) => -0.0332013654,
      (b_inq_per_phone_i > 10.5) => 0.0027388252,
      (b_inq_per_phone_i = NULL) => -0.0295353351, -0.0295353351),
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0025398054,
   (final_model_segment = '') => -0.0035618996, -0.0035618996),
(b_inq_lnames_per_addr_i > 5.5) => 
   map(
   (NULL < (real)ST_cen_business and (real)ST_cen_business <= 43) => -0.0281256398,
   ((real)ST_cen_business > 43) => 0.1050778671,
   ((real)ST_cen_business = NULL) => 0.0377599657, 0.0377599657),
(b_inq_lnames_per_addr_i = NULL) => -0.0500788377, -0.0079122811);

// Tree: 256 
final_score_256 := map(
(NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 5.5) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
      map(
      (NULL < b_divrisktype_i and b_divrisktype_i <= 4.5) => -0.0002646779,
      (b_divrisktype_i > 4.5) => -0.0729168028,
      (b_divrisktype_i = NULL) => -0.0026790579, -0.0014432358),
   (s_inq_ssns_per_addr_i > 3.5) => 
      map(
      (NULL < s_nap_phn_verd_d and s_nap_phn_verd_d <= 0.5) => 0.0700227723,
      (s_nap_phn_verd_d > 0.5) => -0.0530312454,
      (s_nap_phn_verd_d = NULL) => 0.0030022805, 0.0030022805),
   (s_inq_ssns_per_addr_i = NULL) => -0.0014114314, -0.0014114314),
(s_inq_adls_per_addr_i > 5.5) => -0.0385002090,
(s_inq_adls_per_addr_i = NULL) => -0.0500137145, -0.0036909065);

// Tree: 257 
final_score_257 := map(
(NULL < b_util_add_input_inf_n and b_util_add_input_inf_n <= 0.5) => 
   map(
   (NULL < s_addrchangeecontrajindex_d and s_addrchangeecontrajindex_d <= 1.5) => 0.0435296761,
   (s_addrchangeecontrajindex_d > 1.5) => -0.0021648142,
   (s_addrchangeecontrajindex_d = NULL) => -0.0022221513, 0.0003216804),
(b_util_add_input_inf_n > 0.5) => 
   map(
   (NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 0.3434512407) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.12406156155) => -0.0374955069,
      (b_add_input_nhood_BUS_pct_i > 0.12406156155) => 0.1087322248,
      (b_add_input_nhood_BUS_pct_i = NULL) => -0.0088234026, -0.0088234026),
   (s_add_input_mobility_index_i > 0.3434512407) => 0.1239247099,
   (s_add_input_mobility_index_i = NULL) => 0.0217802042, 0.0217802042),
(b_util_add_input_inf_n = NULL) => -0.0500665740, -0.0044617660);

// Tree: 258 
final_score_258 := map(
(NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0218901811,
(pf_product_desc > 2.5) => 
   map(
   (NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
      map(
      (NULL < s_nap_phn_verd_d and s_nap_phn_verd_d <= 0.5) => 0.0245769284,
      (s_nap_phn_verd_d > 0.5) => 
         map(
         (NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 20.5) => -0.0016173960,
         (b_phones_per_addr_curr_i > 20.5) => 0.1818651821,
         (b_phones_per_addr_curr_i = NULL) => -0.0391522365, -0.0020163789),
      (s_nap_phn_verd_d = NULL) => 0.0098836431, 0.0098836431),
   (s_P85_Phn_Invalid_i > 0.5) => 0.0402085264,
   (s_P85_Phn_Invalid_i = NULL) => -0.0515613948, 0.0061336058),
(pf_product_desc = NULL) => -0.0069068963, -0.0069068963);

// Tree: 259 
final_score_259 := map(
(NULL < s_srchunvrfdaddrcount_i and s_srchunvrfdaddrcount_i <= 0.5) => 
   map(
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB']) => -0.0413355053,
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0026221397,
   (final_model_segment = '') => 0.0017186406, 0.0017186406),
(s_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < b_fp_prevaddrburglaryindex_i and b_fp_prevaddrburglaryindex_i <= 140.5) => 
      map(
      (NULL < s_rel_under25miles_cnt_d and s_rel_under25miles_cnt_d <= 5.5) => 0.0290246219,
      (s_rel_under25miles_cnt_d > 5.5) => -0.0739771230,
      (s_rel_under25miles_cnt_d = NULL) => -0.0017258990, -0.0017258990),
   (b_fp_prevaddrburglaryindex_i > 140.5) => 0.2884669737,
   (b_fp_prevaddrburglaryindex_i = NULL) => 0.0242186550, 0.0316564158),
(s_srchunvrfdaddrcount_i = NULL) => -0.0026794011, 0.0018323448);

// Tree: 260 
final_score_260 := map(
(NULL < s_add_input_nhood_SFD_pct_d and s_add_input_nhood_SFD_pct_d <= 0.9991892155) => 
   map(
   (pf_pmt_type in ['Dell Credit Card','Diners Club','Gift Card','Other','Prepaid Check']) => -0.0470302442,
   (pf_pmt_type in ['American Express','Credit Terms','Discover','Mastercard','Visa']) => 
      map(
      (NULL < (real)ST_cen_vacant_p and (real)ST_cen_vacant_p <= 4.35) => -0.0204802579,
      ((real)ST_cen_vacant_p > 4.35) => 0.0125581818,
      ((real)ST_cen_vacant_p = NULL) => -0.0280669365, 0.0021085207),
   (pf_pmt_type = '') => -0.0011357504, -0.0011357504),
(s_add_input_nhood_SFD_pct_d > 0.9991892155) => 
   map(
   (NULL < s_A50_pb_average_dollars_d and s_A50_pb_average_dollars_d <= 143) => -0.0198191918,
   (s_A50_pb_average_dollars_d > 143) => 0.3139066922,
   (s_A50_pb_average_dollars_d = NULL) => 0.0698920673, 0.0698920673),
(s_add_input_nhood_SFD_pct_d = NULL) => -0.0003064302, -0.0003064302);

// Tree: 261 
final_score_261 := map(
(NULL < s_inq_lnames_per_addr_i and s_inq_lnames_per_addr_i <= 12.5) => 
   map(
   (NULL < b_divrisktype_i and b_divrisktype_i <= 3.5) => 
      map(
      (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 5.5) => -0.0027066845,
      (b_inq_lnames_per_addr_i > 5.5) => 0.1062763345,
      (b_inq_lnames_per_addr_i = NULL) => -0.0021828102, -0.0021828102),
   (b_divrisktype_i > 3.5) => -0.0567633648,
   (b_divrisktype_i = NULL) => 
      map(
      (NULL < btst_email_last_score_d and btst_email_last_score_d <= 0.5) => -0.0076514122,
      (btst_email_last_score_d > 0.5) => 0.0546672297,
      (btst_email_last_score_d = NULL) => -0.0500610200, -0.0158302417), -0.0053886584),
(s_inq_lnames_per_addr_i > 12.5) => -0.0513806182,
(s_inq_lnames_per_addr_i = NULL) => -0.0500106843, -0.0077937304);

// Tree: 262 
final_score_262 := map(
(NULL < s_I60_inq_auto_count12_i and s_I60_inq_auto_count12_i <= 2.5) => -0.0036555877,
(s_I60_inq_auto_count12_i > 2.5) => 
   map(
   (NULL < s_rel_criminal_count_i and s_rel_criminal_count_i <= 0.5) => 0.1739681340,
   (s_rel_criminal_count_i > 0.5) => -0.0167899093,
   (s_rel_criminal_count_i = NULL) => 0.0391219310, 0.0391219310),
(s_I60_inq_auto_count12_i = NULL) => 
   map(
   (NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.85885048535) => -0.0114125337,
   (b_add_input_nhood_MFD_pct_i > 0.85885048535) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.0138559544) => 0.0530417210,
      (b_add_input_nhood_BUS_pct_i > 0.0138559544) => 0.0207920918,
      (b_add_input_nhood_BUS_pct_i = NULL) => 0.0344260814, 0.0344260814),
   (b_add_input_nhood_MFD_pct_i = NULL) => 0.0311152299, -0.0052674374), -0.0035154326);

// Tree: 263 
final_score_263 := map(
(NULL < b_mos_liens_unrel_ST_fseen_d and b_mos_liens_unrel_ST_fseen_d <= 63) => 0.1038041389,
(b_mos_liens_unrel_ST_fseen_d > 63) => 
   map(
   (NULL < (real)ST_cen_health and (real)ST_cen_health <= 21.45) => -0.0036646785,
   ((real)ST_cen_health > 21.45) => 0.0338383150,
   ((real)ST_cen_health = NULL) => -0.0085924093, 0.0009347512),
(b_mos_liens_unrel_ST_fseen_d = NULL) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0132461822) => 
      map(
      (NULL < (real)ST_cen_med_hhinc and (real)ST_cen_med_hhinc <= 72583) => 0.0825254827,
      ((real)ST_cen_med_hhinc > 72583) => -0.0379444997,
      ((real)ST_cen_med_hhinc = NULL) => 0.0194221586, 0.0194221586),
   (s_add_input_nhood_BUS_pct_i > 0.0132461822) => -0.0050751996,
   (s_add_input_nhood_BUS_pct_i = NULL) => -0.0042578642, -0.0042578642), 0.0002994341);

// Tree: 264 
final_score_264 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < s_hh_age_30_plus_d and s_hh_age_30_plus_d <= 6.5) => -0.0027852940,
   (s_hh_age_30_plus_d > 6.5) => 
      map(
      (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.26486361535) => 0.0407946437,
      (b_add_input_mobility_index_i > 0.26486361535) => 0.1166290284,
      (b_add_input_mobility_index_i = NULL) => 0.0763206618, 0.0763206618),
   (s_hh_age_30_plus_d = NULL) => -0.0008359506, -0.0018710822),
(final_model_segment in ['CONS ADDR+ DIFF    OTH']) => 
   map(
   (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.38734199735) => 0.0987696385,
   (b_add_input_mobility_index_i > 0.38734199735) => -0.0429740899,
   (b_add_input_mobility_index_i = NULL) => 0.0345124816, 0.0345124816),
(final_model_segment = '') => -0.0015391962, -0.0015391962);

// Tree: 265 
final_score_265 := map(
(NULL < btst_distphoneaddr_i and btst_distphoneaddr_i <= 819.5) => -0.0067175389,
(btst_distphoneaddr_i > 819.5) => -0.0650305411,
(btst_distphoneaddr_i = NULL) => 
   map(
   (NULL < (real)BT_cen_urban_p and (real)BT_cen_urban_p <= 44.6) => 
      map(
      (NULL < (real)BT_cen_unemp and (real)BT_cen_unemp <= 6.05) => 0.0286543839,
      ((real)BT_cen_unemp > 6.05) => 
         map(
         (NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 0.24814241575) => 0.1991813159,
         (s_add_input_mobility_index_i > 0.24814241575) => 0.0315110699,
         (s_add_input_mobility_index_i = NULL) => 0.1153461929, 0.1153461929),
      ((real)BT_cen_unemp = NULL) => 0.0378710920, 0.0378710920),
   ((real)BT_cen_urban_p > 44.6) => 0.0007019273,
   ((real)BT_cen_urban_p = NULL) => 0.0317893957, 0.0078024668), 0.0020612520);

// Tree: 266 
final_score_266 := map(
(NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 26.95) => 
   map(
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH']) => 
      map(
      (pf_ship_method in ['Next Day']) => -0.0498266277,
      (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => -0.0141565242,
      (pf_ship_method = '') => -0.0173763925, -0.0173763925),
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0020897527,
   (final_model_segment = '') => 0.0011966831, 0.0011966831),
((real)ST_cen_blue_col > 26.95) => 
   map(
   (NULL < s_inq_lnames_per_addr_i and s_inq_lnames_per_addr_i <= 0.5) => -0.0099000119,
   (s_inq_lnames_per_addr_i > 0.5) => 0.1343251356,
   (s_inq_lnames_per_addr_i = NULL) => 0.0454977269, 0.0454977269),
((real)ST_cen_blue_col = NULL) => 0.0326310845, 0.0032073205);

// Tree: 267 
final_score_267 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 10.5) => 
   map(
   (NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 1.5) => 0.0177476696,
   (b_C20_email_verification_d > 1.5) => -0.0169862125,
   (b_C20_email_verification_d = NULL) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 229221) => 
         map(
         (NULL < b_prevaddrmedianvalue_d and b_prevaddrmedianvalue_d <= 210141) => -0.0018090604,
         (b_prevaddrmedianvalue_d > 210141) => 0.1059690274,
         (b_prevaddrmedianvalue_d = NULL) => 0.0426817343, 0.0426817343),
      (b_L80_Inp_AVM_AutoVal_d > 229221) => -0.0031815823,
      (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0136352782, -0.0035403789), -0.0029672014),
(b_inq_lnames_per_addr_i > 10.5) => -0.0367677200,
(b_inq_lnames_per_addr_i = NULL) => -0.0500581506, -0.0080548977);

// Tree: 268 
final_score_268 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < s_assoccredbureaucount_i and s_assoccredbureaucount_i <= 4.5) => -0.0056934088,
   (s_assoccredbureaucount_i > 4.5) => -0.0605517437,
   (s_assoccredbureaucount_i = NULL) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 179534) => -0.0173455682,
      (b_L80_Inp_AVM_AutoVal_d > 179534) => 
         map(
         (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.1650682925) => 0.1248970996,
         (s_add_input_nhood_MFD_pct_i > 0.1650682925) => 0.0098572027,
         (s_add_input_nhood_MFD_pct_i = NULL) => 0.0401308598, 0.0401308598),
      (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0032055946, 0.0022590097), -0.0053323929),
(b_inq_lnames_per_addr_i > 8.5) => 0.0383758385,
(b_inq_lnames_per_addr_i = NULL) => -0.0500597612, -0.0096780689);

// Tree: 269 
final_score_269 := map(
(NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 48.5) => 
   map(
   (NULL < s_phone_ver_experian_d and s_phone_ver_experian_d <= 0.5) => 0.0615491731,
   (s_phone_ver_experian_d > 0.5) => -0.0507200046,
   (s_phone_ver_experian_d = NULL) => 0.0024601322, 0.0024601322),
((real)ST_cen_easiqlife > 48.5) => 
   map(
   (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 38.05) => -0.0466121223,
   ((real)ST_cen_civ_emp > 38.05) => 0.0021985399,
   ((real)ST_cen_civ_emp = NULL) => 0.0006930316, 0.0006930316),
((real)ST_cen_easiqlife = NULL) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => -0.0596024179,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS WEB']) => 0.1990896328,
   (final_model_segment = '') => -0.0431430197, -0.0431430197), -0.0015118720);

// Tree: 270 
final_score_270 := map(
(NULL < b_corrphonelastnamecount_d and b_corrphonelastnamecount_d <= 0.5) => 
   map(
   (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1001.5) => 0.0127452565,
   (b_P88_Phn_Dst_to_Inp_Add_i > 1001.5) => 0.0945694057,
   (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < b_util_add_input_conv_n and b_util_add_input_conv_n <= 0.5) => -0.0136958787,
      (b_util_add_input_conv_n > 0.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0258031149,
         (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 0.0536217470,
         (final_model_segment = '') => 0.0297337883, 0.0297337883),
      (b_util_add_input_conv_n = NULL) => 0.0034833010, 0.0034833010), 0.0094592423),
(b_corrphonelastnamecount_d > 0.5) => -0.0204225760,
(b_corrphonelastnamecount_d = NULL) => -0.0043631928, -0.0029516714);

// Tree: 271 
final_score_271 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 5.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 6.5) => 
      map(
      (NULL < pf_product_desc and pf_product_desc <= 3.5) => 0.0010906088,
      (pf_product_desc > 3.5) => 
         map(
         (NULL < b_I60_inq_recency_d and b_I60_inq_recency_d <= 549) => 0.0475277227,
         (b_I60_inq_recency_d > 549) => 0.1968586551,
         (b_I60_inq_recency_d = NULL) => -0.0478868210, 0.0471907262),
      (pf_product_desc = NULL) => 0.0031744241, 0.0031744241),
   (pf_product_desc > 6.5) => -0.0528360453,
   (pf_product_desc = NULL) => -0.0002335449, -0.0002335449),
(s_inq_ssns_per_addr_i > 5.5) => -0.0309537489,
(s_inq_ssns_per_addr_i = NULL) => -0.0500104970, -0.0023832952);

// Tree: 272 
final_score_272 := map(
(NULL < s_liens_rel_OT_total_amt_i and s_liens_rel_OT_total_amt_i <= 18619.5) => 0.0004586199,
(s_liens_rel_OT_total_amt_i > 18619.5) => 0.1043015066,
(s_liens_rel_OT_total_amt_i = NULL) => 
   map(
   (NULL < b_C20_email_count_i and b_C20_email_count_i <= 4.5) => -0.0337504449,
   (b_C20_email_count_i > 4.5) => 
      map(
      (NULL < (real)ST_cen_retired2 and (real)ST_cen_retired2 <= 73.5) => 0.1517365134,
      ((real)ST_cen_retired2 > 73.5) => -0.0309831062,
      ((real)ST_cen_retired2 = NULL) => 0.0234636491, 0.0234636491),
   (b_C20_email_count_i = NULL) => 
      map(
      (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 236448) => 0.0492881343,
      (s_L80_Inp_AVM_AutoVal_d > 236448) => -0.0150142308,
      (s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0066840690, -0.0046630308), -0.0106157308), -0.0013995570);

// Tree: 273 
final_score_273 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 43.5) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 435.995) => 
         map(
         (NULL < (real)BT_cen_med_hval and (real)BT_cen_med_hval <= 832389) => 0.0188429086,
         ((real)BT_cen_med_hval > 832389) => 0.1888914956,
         ((real)BT_cen_med_hval = NULL) => 0.0249130191, 0.0249130191),
      (pf_order_amt_c > 435.995) => -0.0054880773,
      (pf_order_amt_c = NULL) => -0.0015276391, -0.0015276391),
   (b_L79_adls_per_addr_c6_i > 43.5) => 0.0420616685,
   (b_L79_adls_per_addr_c6_i = NULL) => -0.0012550842, -0.0012550842),
(s_inq_ssns_per_addr_i > 4.5) => -0.0279373697,
(s_inq_ssns_per_addr_i = NULL) => -0.0500088361, -0.0034174880);

// Tree: 274 
final_score_274 := map(
(NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 186.5) => -0.0077286665,
((real)BT_cen_very_rich > 186.5) => 
   map(
   (NULL < (real)ST_cen_med_rent and (real)ST_cen_med_rent <= 433.5) => 
      map(
      (sf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity']) => -0.0527946373,
      (sf_seg_FraudPoint_3_0 in ['5: Vuln Vic/Friendly','6: Other']) => 0.1746431614,
      (sf_seg_FraudPoint_3_0 = '') => 0.0677279569, 0.0677279569),
   ((real)ST_cen_med_rent > 433.5) => 
      map(
      (NULL < (real)BT_cen_civ_emp and (real)BT_cen_civ_emp <= 69.45) => -0.0298054216,
      ((real)BT_cen_civ_emp > 69.45) => 0.1121391985,
      ((real)BT_cen_civ_emp = NULL) => 0.0149147651, 0.0149147651),
   ((real)ST_cen_med_rent = NULL) => 0.0208165258, 0.0208165258),
((real)BT_cen_very_rich = NULL) => 0.0115645994, -0.0037025175);

// Tree: 275 
final_score_275 := map(
(NULL < s_liens_rel_OT_total_amt_i and s_liens_rel_OT_total_amt_i <= 19226) => 
   map(
   (NULL < s_inq_lnames_per_addr_i and s_inq_lnames_per_addr_i <= 5.5) => -0.0023943418,
   (s_inq_lnames_per_addr_i > 5.5) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 144) => -0.0081943098,
      ((real)ST_cen_span_lang > 144) => 0.1094022604,
      ((real)ST_cen_span_lang = NULL) => 0.0172319756, 0.0172319756),
   (s_inq_lnames_per_addr_i = NULL) => -0.0020100358, -0.0020100358),
(s_liens_rel_OT_total_amt_i > 19226) => 0.0887444633,
(s_liens_rel_OT_total_amt_i = NULL) => 
   map(
   (NULL < (real)BT_cen_retired2 and (real)BT_cen_retired2 <= 183.5) => -0.0076697639,
   ((real)BT_cen_retired2 > 183.5) => 0.1115955491,
   ((real)BT_cen_retired2 = NULL) => -0.0510172428, -0.0210514975), -0.0054013386);

// Tree: 276 
final_score_276 := map(
(NULL < s_D34_unrel_liens_ct_i and s_D34_unrel_liens_ct_i <= 0.5) => 0.0045382040,
(s_D34_unrel_liens_ct_i > 0.5) => -0.0312569252,
(s_D34_unrel_liens_ct_i = NULL) => 
   map(
   (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 82000) => 0.0984896363,
   (b_L80_Inp_AVM_AutoVal_d > 82000) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 1710.31) => -0.0239537625,
      (pf_order_amt_c > 1710.31) => 
         map(
         (pf_avs_result in ['Error/Inval','No Match','Unavailable','Zip Only']) => -0.0224397667,
         (pf_avs_result in ['Addr Only','Full Match','International','Not Supported']) => 0.1467304018,
         (pf_avs_result = '') => 0.0504784094, 0.0504784094),
      (pf_order_amt_c = NULL) => -0.0058148298, -0.0058148298),
   (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0012945065, -0.0003358255), 0.0000162077);

// Tree: 277 
final_score_277 := map(
(final_model_segment in ['CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
   map(
   (NULL < s_inq_HighRiskCredit_count24_i and s_inq_HighRiskCredit_count24_i <= 0.5) => -0.0161773837,
   (s_inq_HighRiskCredit_count24_i > 0.5) => -0.0764507163,
   (s_inq_HighRiskCredit_count24_i = NULL) => 
      map(
      (NULL < b_L71_Add_Business_i and b_L71_Add_Business_i <= 0.5) => -0.0286272243,
      (b_L71_Add_Business_i > 0.5) => 
         map(
         (NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 0.2942281918) => -0.0077954402,
         (s_add_input_mobility_index_i > 0.2942281918) => 0.0457364019,
         (s_add_input_mobility_index_i = NULL) => 0.0186973592, 0.0186973592),
      (b_L71_Add_Business_i = NULL) => -0.0149280028, -0.0149280028), -0.0168994260),
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.0037538753,
(final_model_segment = '') => -0.0001044889, -0.0001044889);

// Tree: 278 
final_score_278 := map(
(NULL < b_A50_pb_total_orders_d and b_A50_pb_total_orders_d <= 8.5) => -0.0048531703,
(b_A50_pb_total_orders_d > 8.5) => 
   map(
   (NULL < s_P88_Phn_Dst_to_Inp_Add_i and s_P88_Phn_Dst_to_Inp_Add_i <= 239) => -0.0004166567,
   (s_P88_Phn_Dst_to_Inp_Add_i > 239) => 0.1130031152,
   (s_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 442.46) => 0.1838181795,
      (pf_order_amt_c > 442.46) => 
         map(
         (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 21) => -0.0024967895,
         (btst_distaddraddr2_i > 21) => 0.0977594694,
         (btst_distaddraddr2_i = NULL) => 0.0120565384, 0.0120565384),
      (pf_order_amt_c = NULL) => 0.0319576198, 0.0319576198), 0.0099854882),
(b_A50_pb_total_orders_d = NULL) => 0.0024471922, -0.0012261022);

// Tree: 279 
final_score_279 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (btst_email_topleveldomain_n in ['BIZ','COM','EDU','GOV','NET','ORG','US']) => -0.0054869129,
   (btst_email_topleveldomain_n in ['MIL','OTH']) => 0.0744676375,
   (btst_email_topleveldomain_n = '') => 
      map(
      (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 189.5) => -0.0050803803,
      ((real)BT_cen_very_rich > 189.5) => 
         map(
         (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.2236931943) => 0.1389922381,
         (s_add_input_nhood_MFD_pct_i > 0.2236931943) => -0.0114243329,
         (s_add_input_nhood_MFD_pct_i = NULL) => 0.0608281685, 0.0608281685),
      ((real)BT_cen_very_rich = NULL) => -0.0014329317, -0.0014329317), -0.0037610573),
(b_inq_lnames_per_addr_i > 8.5) => 0.0349052076,
(b_inq_lnames_per_addr_i = NULL) => -0.0500559972, -0.0085097015);

// Tree: 280 
final_score_280 := map(
(NULL < s_I60_inq_recency_d and s_I60_inq_recency_d <= 549) => -0.0030484720,
(s_I60_inq_recency_d > 549) => 
   map(
   (NULL < s_prevaddrmedianvalue_d and s_prevaddrmedianvalue_d <= 624393) => 
      map(
      (NULL < b_comb_age_d and b_comb_age_d <= 21.5) => 
         map(
         (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 108.5) => -0.0134021947,
         ((real)BT_cen_lar_fam > 108.5) => 0.2296987960,
         ((real)BT_cen_lar_fam = NULL) => 0.0630446578, 0.0630446578),
      (b_comb_age_d > 21.5) => -0.0091197604,
      (b_comb_age_d = NULL) => 0.0686886115, 0.0070375160),
   (s_prevaddrmedianvalue_d > 624393) => 0.2422037470,
   (s_prevaddrmedianvalue_d = NULL) => 0.0177416341, 0.0177416341),
(s_I60_inq_recency_d = NULL) => 0.0135692795, 0.0019700641);

// Tree: 281 
final_score_281 := map(
(NULL < (real)BT_cen_health and (real)BT_cen_health <= 69.45) => 
   map(
   (NULL < b_curraddrmedianvalue_d and b_curraddrmedianvalue_d <= 930012.5) => -0.0034679560,
   (b_curraddrmedianvalue_d > 930012.5) => 0.0770001153,
   (b_curraddrmedianvalue_d = NULL) => 
      map(
      (pf_ship_method in ['2nd Day','Ground','Other']) => -0.0141929487,
      (pf_ship_method in ['3rd Day','Next Day']) => 
         map(
         (NULL < s_inf_contradictory_i and s_inf_contradictory_i <= 0.5) => -0.0032221588,
         (s_inf_contradictory_i > 0.5) => 0.0830670303,
         (s_inf_contradictory_i = NULL) => 0.0328495514, 0.0328495514),
      (pf_ship_method = '') => -0.0068255738, -0.0068255738), -0.0033961113),
((real)BT_cen_health > 69.45) => 0.1167169594,
((real)BT_cen_health = NULL) => -0.0282307253, -0.0056306937);

// Tree: 282 
final_score_282 := map(
(NULL < b_inq_count24_i and b_inq_count24_i <= 10.5) => 
   map(
   (NULL < b_inq_Retail_count_week_i and b_inq_Retail_count_week_i <= 0.5) => 0.0017841817,
   (b_inq_Retail_count_week_i > 0.5) => 
      map(
      (NULL < s_inf_contradictory_i and s_inf_contradictory_i <= 0.5) => 
         map(
         (NULL < (real)ST_cen_med_hhinc and (real)ST_cen_med_hhinc <= 50312.5) => 0.0878226800,
         ((real)ST_cen_med_hhinc > 50312.5) => -0.0533200141,
         ((real)ST_cen_med_hhinc = NULL) => -0.0134491966, -0.0134491966),
      (s_inf_contradictory_i > 0.5) => 0.1476160122,
      (s_inf_contradictory_i = NULL) => 0.0249323000, 0.0249323000),
   (b_inq_Retail_count_week_i = NULL) => 0.0023029998, 0.0023029998),
(b_inq_count24_i > 10.5) => -0.0514102611,
(b_inq_count24_i = NULL) => 0.0006417899, -0.0066873362);

// Tree: 283 
final_score_283 := map(
(NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => -0.0030318896,
(s_C14_addrs_15yr_i > 11.5) => 
   map(
   (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.17731236505) => 0.0121432468,
   (s_add_input_nhood_MFD_pct_i > 0.17731236505) => 0.1572969769,
   (s_add_input_nhood_MFD_pct_i = NULL) => 0.0729052734, 0.0729052734),
(s_C14_addrs_15yr_i = NULL) => 
   map(
   (NULL < (real)ST_cen_incollege and (real)ST_cen_incollege <= 16.75) => 
      map(
      (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.8723422777) => 0.0039763851,
      (s_add_input_nhood_MFD_pct_i > 0.8723422777) => 0.1128290294,
      (s_add_input_nhood_MFD_pct_i = NULL) => 0.0338466552, 0.0102753516),
   ((real)ST_cen_incollege > 16.75) => -0.0574846339,
   ((real)ST_cen_incollege = NULL) => -0.0542409833, -0.0093292716), -0.0035812050);

// Tree: 284 
final_score_284 := map(
(pf_pmt_type in ['American Express','Dell Credit Card','Discover','Gift Card','Mastercard','Other']) => -0.0116176824,
(pf_pmt_type in ['Credit Terms','Diners Club','Prepaid Check','Visa']) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0061701664,
   (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 1.5) => -0.0240652664,
      (b_phones_per_addr_curr_i > 1.5) => 
         map(
         (NULL < pf_order_amt_c and pf_order_amt_c <= 417.735) => 0.1147497172,
         (pf_order_amt_c > 417.735) => 0.0342885934,
         (pf_order_amt_c = NULL) => 0.0433581513, 0.0433581513),
      (b_phones_per_addr_curr_i = NULL) => 0.0380066763, 0.0232838440),
   (final_model_segment = '') => 0.0092802482, 0.0092802482),
(pf_pmt_type = '') => -0.0010441734, -0.0010441734);

// Tree: 285 
final_score_285 := map(
(NULL < b_mos_liens_rel_OT_lseen_d and b_mos_liens_rel_OT_lseen_d <= 28.5) => 0.0885641749,
(b_mos_liens_rel_OT_lseen_d > 28.5) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 0.0017646846,
   (s_inq_ssns_per_addr_i > 4.5) => -0.0331343852,
   (s_inq_ssns_per_addr_i = NULL) => 0.0015729900, 0.0015729900),
(b_mos_liens_rel_OT_lseen_d = NULL) => 
   map(
   (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 134.5) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 17.55) => 0.0031853690,
      ((real)ST_cen_blue_col > 17.55) => 0.0789497401,
      ((real)ST_cen_blue_col = NULL) => 0.0105343380, 0.0105343380),
   ((real)BT_cen_lar_fam > 134.5) => -0.0407342178,
   ((real)BT_cen_lar_fam = NULL) => -0.0501427970, -0.0251720342), -0.0034544968);

// Tree: 286 
final_score_286 := map(
(NULL < b_I61_inq_collection_count12_i and b_I61_inq_collection_count12_i <= 8.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 195.5) => -0.0051240523,
      ((real)ST_cen_very_rich > 195.5) => 
         map(
         (NULL < b_comb_age_d and b_comb_age_d <= 37.5) => 0.2274026059,
         (b_comb_age_d > 37.5) => 0.0000622807,
         (b_comb_age_d = NULL) => 0.0591707653, 0.0591707653),
      ((real)ST_cen_very_rich = NULL) => -0.0303306434, -0.0041551886),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0505850193,
   (final_model_segment = '') => -0.0038341439, -0.0038341439),
(b_I61_inq_collection_count12_i > 8.5) => 0.1282514905,
(b_I61_inq_collection_count12_i = NULL) => -0.0005781587, -0.0027703679);

// Tree: 287 
final_score_287 := map(
(NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 14.5) => -0.0607010936,
(s_mos_liens_unrel_OT_lseen_d > 14.5) => 0.0024657269,
(s_mos_liens_unrel_OT_lseen_d = NULL) => 
   map(
   (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 193.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0017120723,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH']) => 
         map(
         (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 36.45) => 0.0954086269,
         ((real)ST_cen_high_ed > 36.45) => -0.0391946265,
         ((real)ST_cen_high_ed = NULL) => 0.0268606738, 0.0268606738),
      (final_model_segment = '') => 0.0028619660, 0.0028619660),
   ((real)ST_cen_span_lang > 193.5) => -0.0511091572,
   ((real)ST_cen_span_lang = NULL) => -0.0620248882, -0.0133751830), -0.0008107853);

// Tree: 288 
final_score_288 := map(
(NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => 0.0023302695,
(s_C14_addrs_15yr_i > 11.5) => 
   map(
   (NULL < (real)BT_cen_families and (real)BT_cen_families <= 368.5) => 0.1447891720,
   ((real)BT_cen_families > 368.5) => -0.0532256194,
   ((real)BT_cen_families = NULL) => 0.0358042868, 0.0358042868),
(s_C14_addrs_15yr_i = NULL) => 
   map(
   (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 76.5) => 
      map(
      (pf_avs_result in ['Error/Inval','Full Match','International','Unavailable','Zip Only']) => 0.0028113304,
      (pf_avs_result in ['Addr Only','No Match','Not Supported']) => 0.0526270833,
      (pf_avs_result = '') => 0.0091609629, 0.0091609629),
   ((real)BT_cen_lar_fam > 76.5) => -0.0212319677,
   ((real)BT_cen_lar_fam = NULL) => -0.0513802849, -0.0241113347), -0.0025049736);

// Tree: 289 
final_score_289 := map(
(NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < btst_firstscore_d and btst_firstscore_d <= 28.5) => -0.0327387446,
   (btst_firstscore_d > 28.5) => 
      map(
      (pf_cid_result in ['Match','Null']) => 0.0037433495,
      (pf_cid_result in ['Invalid','No Match','Other']) => 0.0695282351,
      (pf_cid_result = '') => 0.0048863407, 0.0048863407),
   (btst_firstscore_d = NULL) => -0.0500400322, -0.0048110300),
(s_P85_Phn_Not_Issued_i > 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB']) => -0.0196976136,
   (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0741960897,
   (final_model_segment = '') => 0.0149708307, 0.0149708307),
(s_P85_Phn_Not_Issued_i = NULL) => 0.0392826581, -0.0026002229);

// Tree: 290 
final_score_290 := map(
(NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 14.5) => -0.0599372372,
(s_mos_liens_unrel_OT_lseen_d > 14.5) => 
   map(
   (NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 27.5) => 0.1518228636,
   (s_mos_liens_unrel_OT_lseen_d > 27.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS WEB']) => -0.0152482040,
      (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
         map(
         (NULL < (real)ST_cen_rental and (real)ST_cen_rental <= 195.5) => 0.0098827003,
         ((real)ST_cen_rental > 195.5) => 0.1344488897,
         ((real)ST_cen_rental = NULL) => 0.0125359647, 0.0125359647),
      (final_model_segment = '') => -0.0094679164, -0.0094679164),
   (s_mos_liens_unrel_OT_lseen_d = NULL) => -0.0088462076, -0.0088462076),
(s_mos_liens_unrel_OT_lseen_d = NULL) => -0.0078692370, -0.0088326343);

// Tree: 291 
final_score_291 := map(
(NULL < b_I60_inq_auto_recency_d and b_I60_inq_auto_recency_d <= 4.5) => 
   map(
   (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 1.5) => 
      map(
      (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 22) => 0.2783488185,
      ((real)BT_cen_no_move > 22) => -0.0422543328,
      ((real)BT_cen_no_move = NULL) => 0.0478027322, 0.0478027322),
   (s_inq_per_phone_i > 1.5) => 0.0141194562,
   (s_inq_per_phone_i = NULL) => 0.0367860216, 0.0367860216),
(b_I60_inq_auto_recency_d > 4.5) => -0.0016442055,
(b_I60_inq_auto_recency_d = NULL) => 
   map(
   (pf_avs_result in ['Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => -0.0035953680,
   (pf_avs_result in ['Addr Only','International','Not Supported']) => 0.0566587365,
   (pf_avs_result = '') => -0.0026884730, -0.0026884730), -0.0012311786);

// Tree: 292 
final_score_292 := map(
(NULL < b_C10_M_Hdr_FS_d and b_C10_M_Hdr_FS_d <= 359.5) => 
   map(
   (NULL < s_I60_inq_auto_count12_i and s_I60_inq_auto_count12_i <= 3.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0026516398,
      (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
         map(
         (NULL < pf_order_amt_c and pf_order_amt_c <= 567.04) => 0.0801377359,
         (pf_order_amt_c > 567.04) => -0.0024163054,
         (pf_order_amt_c = NULL) => 0.0304646440, 0.0304646440),
      (final_model_segment = '') => 0.0058245727, 0.0058245727),
   (s_I60_inq_auto_count12_i > 3.5) => 0.0989399938,
   (s_I60_inq_auto_count12_i = NULL) => -0.0286361099, 0.0037722172),
(b_C10_M_Hdr_FS_d > 359.5) => -0.0285465473,
(b_C10_M_Hdr_FS_d = NULL) => 0.0101476704, -0.0030685117);

// Tree: 293 
final_score_293 := map(
(NULL < b_I60_inq_auto_recency_d and b_I60_inq_auto_recency_d <= 4.5) => 
   map(
   (NULL < (real)BT_cen_civ_emp and (real)BT_cen_civ_emp <= 68.55) => -0.0148773328,
   ((real)BT_cen_civ_emp > 68.55) => 0.2714478731,
   ((real)BT_cen_civ_emp = NULL) => 0.0614023553, 0.0614023553),
(b_I60_inq_auto_recency_d > 4.5) => -0.0045313716,
(b_I60_inq_auto_recency_d = NULL) => 
   map(
   (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 17.25) => -0.0176785917,
   ((real)ST_cen_blue_col > 17.25) => 
      map(
      (NULL < (real)BT_cen_med_hval and (real)BT_cen_med_hval <= 198712) => 0.0062407833,
      ((real)BT_cen_med_hval > 198712) => 0.1246423963,
      ((real)BT_cen_med_hval = NULL) => -0.0500415380, -0.0005631219),
   ((real)ST_cen_blue_col = NULL) => 0.0573112409, 0.0002032139), -0.0025387573);

// Tree: 294 
final_score_294 := map(
(NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 189458) => -0.0085538617,
(s_curraddrmedianincome_d > 189458) => 
   map(
   (NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 51.5) => 0.2650797198,
   ((real)ST_cen_no_move > 51.5) => -0.0070665367,
   ((real)ST_cen_no_move = NULL) => 0.0847224373, 0.0847224373),
(s_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 171.5) => 0.0045441035,
   ((real)BT_cen_trailer > 171.5) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.09217312165) => 0.0774911172,
      (b_add_input_nhood_BUS_pct_i > 0.09217312165) => 0.0346838365,
      (b_add_input_nhood_BUS_pct_i = NULL) => 0.0545020220, 0.0545020220),
   ((real)BT_cen_trailer = NULL) => -0.0512512151, -0.0132120975), -0.0084821785);

// Tree: 295 
final_score_295 := map(
(NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 866) => -0.0043084863,
(btst_distaddraddr2_i > 866) => 
   map(
   (NULL < (real)ST_cen_med_hval and (real)ST_cen_med_hval <= 100803.5) => 
      map(
      (NULL < (real)ST_cen_retired2 and (real)ST_cen_retired2 <= 97.5) => 0.1787781273,
      ((real)ST_cen_retired2 > 97.5) => 0.0016548566,
      ((real)ST_cen_retired2 = NULL) => 0.0877790158, 0.0877790158),
   ((real)ST_cen_med_hval > 100803.5) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.10899415895) => -0.0185588080,
      (b_add_input_nhood_BUS_pct_i > 0.10899415895) => 0.0336598554,
      (b_add_input_nhood_BUS_pct_i = NULL) => 0.0044673590, 0.0044673590),
   ((real)ST_cen_med_hval = NULL) => 0.0160060764, 0.0160060764),
(btst_distaddraddr2_i = NULL) => -0.0032923873, -0.0032923873);

// Tree: 296 
final_score_296 := map(
(NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 262493.5) => 
   map(
   (NULL < (real)BT_cen_health and (real)BT_cen_health <= 29.25) => 
      map(
      (NULL < b_varmsrcssncount_i and b_varmsrcssncount_i <= 0.5) => 0.1566432173,
      (b_varmsrcssncount_i > 0.5) => 0.0061677967,
      (b_varmsrcssncount_i = NULL) => 0.0117874484, 0.0109824001),
   ((real)BT_cen_health > 29.25) => 
      map(
      (NULL < b_M_Bureau_ADL_FS_noTU_d and b_M_Bureau_ADL_FS_noTU_d <= 250.5) => 0.2235372665,
      (b_M_Bureau_ADL_FS_noTU_d > 250.5) => 0.0144222508,
      (b_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0823167364, 0.0823167364),
   ((real)BT_cen_health = NULL) => -0.0504488700, 0.0132394868),
(s_L80_Inp_AVM_AutoVal_d > 262493.5) => -0.0258180168,
(s_L80_Inp_AVM_AutoVal_d = NULL) => 0.0001877791, -0.0019951212);

// Tree: 297 
final_score_297 := map(
(NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 5.05) => -0.0236433097,
((real)ST_cen_blue_col > 5.05) => 
   map(
   (NULL < s_addrchangevaluediff_d and s_addrchangevaluediff_d <= -176247) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.02546600565) => 0.1196395797,
      (s_add_input_nhood_BUS_pct_i > 0.02546600565) => 
         map(
         (NULL < s_A50_pb_total_dollars_d and s_A50_pb_total_dollars_d <= 47.5) => 0.1873222539,
         (s_A50_pb_total_dollars_d > 47.5) => -0.0099513570,
         (s_A50_pb_total_dollars_d = NULL) => 0.0160627455, 0.0160627455),
      (s_add_input_nhood_BUS_pct_i = NULL) => 0.0263178776, 0.0263178776),
   (s_addrchangevaluediff_d > -176247) => 0.0054426153,
   (s_addrchangevaluediff_d = NULL) => 0.0060488617, 0.0065000615),
((real)ST_cen_blue_col = NULL) => -0.0283841382, -0.0014211853);

// Tree: 298 
final_score_298 := map(
(NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 81.5) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 2.5) => -0.0033548747,
   (s_inq_ssns_per_addr_i > 2.5) => 
      map(
      (NULL < b_rel_homeover50_count_d and b_rel_homeover50_count_d <= 16.5) => 
         map(
         (NULL < (real)ST_cen_rental and (real)ST_cen_rental <= 161.5) => -0.0266420969,
         ((real)ST_cen_rental > 161.5) => 0.0442087738,
         ((real)ST_cen_rental = NULL) => -0.0119832961, -0.0119832961),
      (b_rel_homeover50_count_d > 16.5) => 0.0827225395,
      (b_rel_homeover50_count_d = NULL) => 0.0374096362, 0.0084412128),
   (s_inq_ssns_per_addr_i = NULL) => -0.0030429095, -0.0030429095),
(s_inq_per_phone_i > 81.5) => 0.0608701587,
(s_inq_per_phone_i = NULL) => -0.0504603528, -0.0054042953);

// Tree: 299 
final_score_299 := map(
(NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.82973546615) => -0.0025618884,
(s_add_input_nhood_MFD_pct_i > 0.82973546615) => 
   map(
   (NULL < (real)ST_cen_high_hval and (real)ST_cen_high_hval <= 3.7) => -0.0217405192,
   ((real)ST_cen_high_hval > 3.7) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0351204672,
      (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH']) => 
         map(
         (NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 63.5) => 0.2266380279,
         ((real)ST_cen_no_move > 63.5) => 0.0399695955,
         ((real)ST_cen_no_move = NULL) => 0.1333038117, 0.1333038117),
      (final_model_segment = '') => 0.0558780453, 0.0558780453),
   ((real)ST_cen_high_hval = NULL) => 0.0272109221, 0.0272109221),
(s_add_input_nhood_MFD_pct_i = NULL) => 0.0042911542, -0.0001480266);

// Tree: 300 
final_score_300 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 5.5) => 
   map(
   (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 41.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0007714643,
      (final_model_segment in ['CONS ADDR+ DIFF    OTH']) => 0.0313937991,
      (final_model_segment = '') => -0.0006320357, -0.0006320357),
   (s_inq_per_phone_i > 41.5) => 0.0631464794,
   (s_inq_per_phone_i = NULL) => 0.0745332194, 0.0005872321),
(b_inq_lnames_per_addr_i > 5.5) => 
   map(
   (NULL < (real)BT_cen_vacant_p and (real)BT_cen_vacant_p <= 8.5) => -0.0229206065,
   ((real)BT_cen_vacant_p > 8.5) => 0.0817972669,
   ((real)BT_cen_vacant_p = NULL) => 0.0166678579, 0.0166678579),
(b_inq_lnames_per_addr_i = NULL) => -0.0500497787, -0.0045787084);

// Tree: 301 
final_score_301 := map(
(NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 177.5) => -0.0027637343,
((real)BT_cen_very_rich > 177.5) => 
   map(
   (NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.89105829905) => 0.0180874554,
   (b_add_input_nhood_MFD_pct_i > 0.89105829905) => 0.1199826615,
   (b_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < s_rel_incomeover50_count_d and s_rel_incomeover50_count_d <= 4.5) => 
         map(
         (NULL < s_comb_age_d and s_comb_age_d <= 49.5) => 0.2522576273,
         (s_comb_age_d > 49.5) => 0.0455434869,
         (s_comb_age_d = NULL) => 0.1478772198, 0.1478772198),
      (s_rel_incomeover50_count_d > 4.5) => 0.0106270755,
      (s_rel_incomeover50_count_d = NULL) => 0.0538354543, 0.0538354543), 0.0279305403),
((real)BT_cen_very_rich = NULL) => -0.0198555241, -0.0010529472);

// Tree: 302 
final_score_302 := map(
(NULL < s_comb_age_d and s_comb_age_d <= 16.5) => 0.1147665516,
(s_comb_age_d > 16.5) => 
   map(
   (NULL < b_inq_adls_per_addr_i and b_inq_adls_per_addr_i <= 3.5) => 0.0053316425,
   (b_inq_adls_per_addr_i > 3.5) => 
      map(
      (NULL < s_rel_under500miles_cnt_d and s_rel_under500miles_cnt_d <= 10.5) => -0.0588824281,
      (s_rel_under500miles_cnt_d > 10.5) => 0.0195222710,
      (s_rel_under500miles_cnt_d = NULL) => -0.0337337510, -0.0337337510),
   (b_inq_adls_per_addr_i = NULL) => -0.0500526036, 0.0023299009),
(s_comb_age_d = NULL) => 
   map(
   (NULL < (real)ST_cen_incollege and (real)ST_cen_incollege <= 63.05) => 0.0014287212,
   ((real)ST_cen_incollege > 63.05) => -0.0715508265,
   ((real)ST_cen_incollege = NULL) => -0.0503950579, -0.0107983810), 0.0001395766);

// Tree: 303 
final_score_303 := map(
(NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
   map(
   (NULL < b_mos_liens_unrel_OT_fseen_d and b_mos_liens_unrel_OT_fseen_d <= 127.5) => 0.1276899271,
   (b_mos_liens_unrel_OT_fseen_d > 127.5) => 
      map(
      (NULL < (real)BT_cen_low_hval and (real)BT_cen_low_hval <= 35.8) => 0.0143313847,
      ((real)BT_cen_low_hval > 35.8) => 0.1217830477,
      ((real)BT_cen_low_hval = NULL) => 0.0184590198, 0.0184590198),
   (b_mos_liens_unrel_OT_fseen_d = NULL) => 
      map(
      (NULL < (real)BT_cen_retired2 and (real)BT_cen_retired2 <= 159.5) => -0.0223388405,
      ((real)BT_cen_retired2 > 159.5) => 0.1168645181,
      ((real)BT_cen_retired2 = NULL) => -0.0502478478, -0.0190205033), 0.0133641155),
(s_C20_email_verification_d > 0.5) => -0.0013427816,
(s_C20_email_verification_d = NULL) => -0.0096565135, -0.0016682857);

// Tree: 304 
final_score_304 := map(
(NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 76.15) => -0.0061481901,
((real)BT_cen_ownocc_p > 76.15) => 
   map(
   (NULL < b_addrchangeincomediff_d and b_addrchangeincomediff_d <= -30515.5) => 0.3200716700,
   (b_addrchangeincomediff_d > -30515.5) => 
      map(
      (NULL < s_mos_liens_rel_OT_lseen_d and s_mos_liens_rel_OT_lseen_d <= 83.5) => 0.1674313925,
      (s_mos_liens_rel_OT_lseen_d > 83.5) => 0.0220860844,
      (s_mos_liens_rel_OT_lseen_d = NULL) => 
         map(
         (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 0.5) => 0.0278619692,
         (s_inq_per_phone_i > 0.5) => -0.0074685547,
         (s_inq_per_phone_i = NULL) => 0.0142733062, 0.0142733062), 0.0237133546),
   (b_addrchangeincomediff_d = NULL) => 0.0024877926, 0.0221197769),
((real)BT_cen_ownocc_p = NULL) => 0.0217411514, 0.0051296277);

// Tree: 305 
final_score_305 := map(
(NULL < b_hh_age_30_plus_d and b_hh_age_30_plus_d <= 6.5) => -0.0002240589,
(b_hh_age_30_plus_d > 6.5) => 
   map(
   (NULL < s_prevaddrageoldest_d and s_prevaddrageoldest_d <= 109) => -0.0521888180,
   (s_prevaddrageoldest_d > 109) => 0.1607182173,
   (s_prevaddrageoldest_d = NULL) => 0.0552595923, 0.0552595923),
(b_hh_age_30_plus_d = NULL) => 
   map(
   (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 186.5) => -0.0051242764,
   ((real)BT_cen_very_rich > 186.5) => 
      map(
      (NULL < (real)BT_cen_civ_emp and (real)BT_cen_civ_emp <= 67.85) => -0.0536727799,
      ((real)BT_cen_civ_emp > 67.85) => 0.2627761860,
      ((real)BT_cen_civ_emp = NULL) => 0.0942005686, 0.0942005686),
   ((real)BT_cen_very_rich = NULL) => 0.0571156248, 0.0312359742), 0.0064606300);

// Tree: 306 
final_score_306 := map(
(NULL < (real)BT_cen_incollege and (real)BT_cen_incollege <= 5.25) => 
   map(
   (NULL < b_add_curr_nhood_MFD_pct_i and b_add_curr_nhood_MFD_pct_i <= 0.04882069615) => -0.0228324211,
   (b_add_curr_nhood_MFD_pct_i > 0.04882069615) => 
      map(
      (NULL < s_A50_pb_total_orders_d and s_A50_pb_total_orders_d <= 19.5) => 0.0322824154,
      (s_A50_pb_total_orders_d > 19.5) => 
         map(
         (NULL < b_componentcharrisktype_i and b_componentcharrisktype_i <= 2.5) => 0.3457240511,
         (b_componentcharrisktype_i > 2.5) => 0.0657804032,
         (b_componentcharrisktype_i = NULL) => 0.1788345687, 0.1788345687),
      (s_A50_pb_total_orders_d = NULL) => -0.0037133428, 0.0379542532),
   (b_add_curr_nhood_MFD_pct_i = NULL) => 0.0122473174, 0.0152675548),
((real)BT_cen_incollege > 5.25) => -0.0070132795,
((real)BT_cen_incollege = NULL) => -0.0552341226, -0.0044533989);

// Tree: 307 
final_score_307 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 45.5) => 
   map(
   (NULL < s_E57_br_source_count_d and s_E57_br_source_count_d <= 11.5) => -0.0022181398,
   (s_E57_br_source_count_d > 11.5) => 0.1285622112,
   (s_E57_br_source_count_d = NULL) => 
      map(
      (NULL < (real)ST_cen_incollege and (real)ST_cen_incollege <= 1.35) => 
         map(
         (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.2891126187) => 0.0005187111,
         (s_add_input_nhood_BUS_pct_i > 0.2891126187) => 0.0984297804,
         (s_add_input_nhood_BUS_pct_i = NULL) => 0.0440347419, 0.0440347419),
      ((real)ST_cen_incollege > 1.35) => -0.0151131218,
      ((real)ST_cen_incollege = NULL) => -0.0501671399, -0.0204856636), -0.0051151040),
(s_L79_adls_per_addr_c6_i > 45.5) => 0.0382953616,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0048247154, -0.0048247154);

// Tree: 308 
final_score_308 := map(
(NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 48.5) => 
   map(
   (NULL < s_phone_ver_experian_d and s_phone_ver_experian_d <= 0.5) => 0.0625744479,
   (s_phone_ver_experian_d > 0.5) => -0.0511683943,
   (s_phone_ver_experian_d = NULL) => -0.0038513719, -0.0038513719),
((real)ST_cen_easiqlife > 48.5) => 
   map(
   (NULL < b_addrchangeecontrajindex_d and b_addrchangeecontrajindex_d <= 1.5) => 0.0390491691,
   (b_addrchangeecontrajindex_d > 1.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0038038119,
      (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 0.0552098997,
      (final_model_segment = '') => 0.0041071414, 0.0041071414),
   (b_addrchangeecontrajindex_d = NULL) => -0.0079195469, 0.0016201449),
((real)ST_cen_easiqlife = NULL) => 0.0268367648, 0.0028101580);

// Tree: 309 
final_score_309 := map(
(NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 5.5) => 
   map(
   (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.27454717435) => 
      map(
      (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 41.5) => 0.0082174225,
      (btst_distaddraddr2_i > 41.5) => 
         map(
         (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 9.85) => 0.1420080043,
         ((real)ST_cen_high_ed > 9.85) => 0.0441272454,
         ((real)ST_cen_high_ed = NULL) => 0.0533692055, 0.0533692055),
      (btst_distaddraddr2_i = NULL) => 0.0126085575, 0.0126085575),
   (b_add_input_mobility_index_i > 0.27454717435) => -0.0098591910,
   (b_add_input_mobility_index_i = NULL) => -0.0017730005, 0.0006620543),
(s_inq_adls_per_addr_i > 5.5) => -0.0348975981,
(s_inq_adls_per_addr_i = NULL) => -0.0500080073, -0.0017003399);

// Tree: 310 
final_score_310 := map(
(NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 2.5) => 
   map(
   (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 5.5) => 0.0052246911,
   (b_inq_lnames_per_addr_i > 5.5) => 0.0746509503,
   (b_inq_lnames_per_addr_i = NULL) => -0.0500385709, 0.0019221649),
(s_inq_adls_per_addr_i > 2.5) => 
   map(
   (NULL < b_rel_incomeover100_count_d and b_rel_incomeover100_count_d <= 1.5) => 
      map(
      (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.0431265067) => -0.0713320224,
      (b_add_curr_nhood_BUS_pct_i > 0.0431265067) => -0.0331946730,
      (b_add_curr_nhood_BUS_pct_i = NULL) => -0.0520612063, -0.0520612063),
   (b_rel_incomeover100_count_d > 1.5) => 0.0046442935,
   (b_rel_incomeover100_count_d = NULL) => 0.0096961581, -0.0217492112),
(s_inq_adls_per_addr_i = NULL) => -0.0500066060, -0.0011265428);

// Tree: 311 
final_score_311 := map(
(NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 48.5) => 
   map(
   (NULL < s_phone_ver_experian_d and s_phone_ver_experian_d <= 0.5) => 0.0648155968,
   (s_phone_ver_experian_d > 0.5) => -0.0508216773,
   (s_phone_ver_experian_d = NULL) => 0.0060000867, 0.0060000867),
((real)ST_cen_easiqlife > 48.5) => 
   map(
   (pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
      map(
      (NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 94.5) => -0.0021595703,
      (b_L79_adls_per_addr_c6_i > 94.5) => -0.0577977223,
      (b_L79_adls_per_addr_c6_i = NULL) => -0.0023976331, -0.0023976331),
   (pf_avs_result in ['International','Not Supported']) => 0.0322127397,
   (pf_avs_result = '') => -0.0022635277, -0.0022635277),
((real)ST_cen_easiqlife = NULL) => -0.0347905437, -0.0037958304);

// Tree: 312 
final_score_312 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 23) => 
   map(
   (pf_avs_result in ['International','Not Supported']) => -0.0357745704,
   (pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
      map(
      (NULL < s_srchaddrsrchcountmo_i and s_srchaddrsrchcountmo_i <= 1.5) => -0.0023843215,
      (s_srchaddrsrchcountmo_i > 1.5) => 0.0351039346,
      (s_srchaddrsrchcountmo_i = NULL) => -0.0047922374, -0.0023663295),
   (pf_avs_result = '') => -0.0024728622, -0.0024728622),
(s_L79_adls_per_addr_c6_i > 23) => 
   map(
   (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 174.5) => 0.0580171089,
   ((real)ST_cen_very_rich > 174.5) => 0.0079931390,
   ((real)ST_cen_very_rich = NULL) => 0.0289334055, 0.0289334055),
(s_L79_adls_per_addr_c6_i = NULL) => -0.0022112070, -0.0022112070);

// Tree: 313 
final_score_313 := map(
(NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 2521.5) => 
   map(
   (NULL < s_inq_HighRiskCredit_count24_i and s_inq_HighRiskCredit_count24_i <= 0.5) => -0.0014771416,
   (s_inq_HighRiskCredit_count24_i > 0.5) => -0.0655352988,
   (s_inq_HighRiskCredit_count24_i = NULL) => 
      map(
      (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 6.5) => 
         map(
         (NULL < (real)ST_cen_lar_fam and (real)ST_cen_lar_fam <= 67.5) => 0.0388550662,
         ((real)ST_cen_lar_fam > 67.5) => -0.0111394081,
         ((real)ST_cen_lar_fam = NULL) => 0.0028018498, 0.0028018498),
      (b_inq_lnames_per_addr_i > 6.5) => 0.0442141196,
      (b_inq_lnames_per_addr_i = NULL) => -0.0500244224, -0.0149356414), -0.0051239044),
(btst_distaddraddr2_i > 2521.5) => 0.0945869497,
(btst_distaddraddr2_i = NULL) => -0.0045170215, -0.0045170215);

// Tree: 314 
final_score_314 := map(
(final_model_segment in ['CONS ADDR+ DIFF    WEB']) => 
   map(
   (NULL < (real)BT_cen_med_hval and (real)BT_cen_med_hval <= 304846) => -0.0492312108,
   ((real)BT_cen_med_hval > 304846) => 
      map(
      (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 42.35) => 0.0449581632,
      ((real)BT_cen_high_ed > 42.35) => -0.0422026230,
      ((real)BT_cen_high_ed = NULL) => -0.0064909120, -0.0064909120),
   ((real)BT_cen_med_hval = NULL) => -0.0334905381, -0.0334905381),
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 41) => 0.0023555936,
   (s_inq_per_phone_i > 41) => 0.0863920758,
   (s_inq_per_phone_i = NULL) => 0.0157663811, 0.0034777571),
(final_model_segment = '') => 0.0025178044, 0.0025178044);

// Tree: 315 
final_score_315 := map(
(NULL < (real)BT_cen_families and (real)BT_cen_families <= 2671.5) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
      map(
      (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 48.5) => 0.0702727828,
      ((real)ST_cen_easiqlife > 48.5) => 0.0006758722,
      ((real)ST_cen_easiqlife = NULL) => 0.0013942669, 0.0013942669),
   (s_inq_ssns_per_addr_i > 3.5) => 
      map(
      (final_model_segment in ['BUS  ADDR+         OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => -0.0561232223,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => -0.0075481907,
      (final_model_segment = '') => -0.0250720945, -0.0250720945),
   (s_inq_ssns_per_addr_i = NULL) => 0.0011064702, 0.0011064702),
((real)BT_cen_families > 2671.5) => 0.1173114823,
((real)BT_cen_families = NULL) => 0.0080030587, 0.0022580252);

// Tree: 316 
final_score_316 := map(
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 158.5) => -0.0044820437,
((real)ST_cen_span_lang > 158.5) => 
   map(
   (NULL < b_inq_count24_i and b_inq_count24_i <= 2.5) => 
      map(
      (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.1885330003) => 0.1338829773,
      (b_add_input_mobility_index_i > 0.1885330003) => 
         map(
         (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 71.5) => 0.0148009264,
         (b_P88_Phn_Dst_to_Inp_Add_i > 71.5) => 0.1133310780,
         (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0289034892, 0.0235072717),
      (b_add_input_mobility_index_i = NULL) => 0.0291938579, 0.0291938579),
   (b_inq_count24_i > 2.5) => -0.0174696551,
   (b_inq_count24_i = NULL) => 0.0114402169, 0.0068290752),
((real)ST_cen_span_lang = NULL) => 0.0068256430, -0.0018793619);

// Tree: 317 
final_score_317 := map(
(NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 88.5) => -0.0014273299,
(b_phones_per_addr_curr_i > 88.5) => 0.0864575774,
(b_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 192.5) => 
      map(
      (NULL < (real)BT_cen_urban_p and (real)BT_cen_urban_p <= 0.05) => 0.1185661258,
      ((real)BT_cen_urban_p > 0.05) => 
         map(
         (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 4.75) => -0.0345770751,
         ((real)ST_cen_unemp > 4.75) => 0.0201158660,
         ((real)ST_cen_unemp = NULL) => -0.0135620534, -0.0135620534),
      ((real)BT_cen_urban_p = NULL) => -0.0501635419, -0.0138371005),
   ((real)ST_cen_span_lang > 192.5) => 0.0659413989,
   ((real)ST_cen_span_lang = NULL) => -0.0114195702, -0.0114195702), -0.0022241049);

// Tree: 318 
final_score_318 := map(
(NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 48.5) => 
   map(
   (NULL < s_phone_ver_experian_d and s_phone_ver_experian_d <= 0.5) => 0.0421176176,
   (s_phone_ver_experian_d > 0.5) => -0.0507722750,
   (s_phone_ver_experian_d = NULL) => -0.0094011464, -0.0094011464),
((real)ST_cen_easiqlife > 48.5) => 
   map(
   (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 184.5) => -0.0055164469,
   ((real)BT_cen_span_lang > 184.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => -0.0099968648,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS WEB']) => 0.0829089832,
      (final_model_segment = '') => 0.0099024778, 0.0099024778),
   ((real)BT_cen_span_lang = NULL) => -0.0508598759, -0.0079382738),
((real)ST_cen_easiqlife = NULL) => 0.0075404800, -0.0071875484);

// Tree: 319 
final_score_319 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < btst_distphoneaddr_i and btst_distphoneaddr_i <= 597.5) => -0.0023912929,
   (btst_distphoneaddr_i > 597.5) => -0.0665089046,
   (btst_distphoneaddr_i = NULL) => 
      map(
      (NULL < (real)BT_cen_health and (real)BT_cen_health <= 59.55) => 
         map(
         (NULL < b_liens_unrel_ST_total_amt_i and b_liens_unrel_ST_total_amt_i <= 1647) => -0.0010264269,
         (b_liens_unrel_ST_total_amt_i > 1647) => 0.1094317697,
         (b_liens_unrel_ST_total_amt_i = NULL) => -0.0045410670, -0.0007584138),
      ((real)BT_cen_health > 59.55) => 0.1113021881,
      ((real)BT_cen_health = NULL) => -0.0594759710, -0.0002937704), -0.0013803671),
(b_inq_lnames_per_addr_i > 8.5) => 0.0415438065,
(b_inq_lnames_per_addr_i = NULL) => -0.0500482456, -0.0063059180);

// Tree: 320 
final_score_320 := map(
(NULL < b_C14_addrs_5yr_i and b_C14_addrs_5yr_i <= 5.5) => 0.0002479637,
(b_C14_addrs_5yr_i > 5.5) => -0.0721101284,
(b_C14_addrs_5yr_i = NULL) => 
   map(
   (pf_ship_method in ['2nd Day','Ground','Other']) => -0.0080979761,
   (pf_ship_method in ['3rd Day','Next Day']) => 
      map(
      (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 143.5) => -0.0005527194,
      ((real)BT_cen_span_lang > 143.5) => 
         map(
         (NULL < (real)BT_cen_vacant_p and (real)BT_cen_vacant_p <= 8.5) => 0.0182502084,
         ((real)BT_cen_vacant_p > 8.5) => 0.1283725862,
         ((real)BT_cen_vacant_p = NULL) => 0.0738565576, 0.0738565576),
      ((real)BT_cen_span_lang = NULL) => -0.0500730993, -0.0040512525),
   (pf_ship_method = '') => -0.0075751878, -0.0075751878), -0.0018342110);

// Tree: 321 
final_score_321 := map(
(NULL < s_curraddrmedianvalue_d and s_curraddrmedianvalue_d <= 124080.5) => 
   map(
   (NULL < s_mos_liens_unrel_SC_fseen_d and s_mos_liens_unrel_SC_fseen_d <= 193.5) => 0.1504195915,
   (s_mos_liens_unrel_SC_fseen_d > 193.5) => 
      map(
      (NULL < s_util_adl_count_n and s_util_adl_count_n <= 11.5) => 
         map(
         (NULL < s_L79_adls_per_addr_curr_i and s_L79_adls_per_addr_curr_i <= 2.5) => -0.0059760958,
         (s_L79_adls_per_addr_curr_i > 2.5) => 0.0471963146,
         (s_L79_adls_per_addr_curr_i = NULL) => 0.0061307329, 0.0061307329),
      (s_util_adl_count_n > 11.5) => 0.1186466764,
      (s_util_adl_count_n = NULL) => 0.0084773437, 0.0084773437),
   (s_mos_liens_unrel_SC_fseen_d = NULL) => 0.0120109691, 0.0120109691),
(s_curraddrmedianvalue_d > 124080.5) => -0.0083770863,
(s_curraddrmedianvalue_d = NULL) => 0.0067659385, -0.0018988147);

// Tree: 322 
final_score_322 := map(
(NULL < b_add_curr_nhood_SFD_pct_d and b_add_curr_nhood_SFD_pct_d <= 0.9921031845) => -0.0081735503,
(b_add_curr_nhood_SFD_pct_d > 0.9921031845) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 406) => 
      map(
      (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 162.5) => 0.0068170311,
      ((real)ST_cen_easiqlife > 162.5) => 0.1355623035,
      ((real)ST_cen_easiqlife = NULL) => 0.0146778743, 0.0146778743),
   (btst_distaddraddr2_i > 406) => 0.1030185024,
   (btst_distaddraddr2_i = NULL) => 0.0192302465, 0.0192302465),
(b_add_curr_nhood_SFD_pct_d = NULL) => 
   map(
   (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 193913) => 0.0617870582,
   (s_L80_Inp_AVM_AutoVal_d > 193913) => -0.0162075641,
   (s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0142746413, -0.0119669394), -0.0061780657);

// Tree: 323 
final_score_323 := map(
(NULL < b_prevaddrlenofres_d and b_prevaddrlenofres_d <= 459.5) => -0.0084120754,
(b_prevaddrlenofres_d > 459.5) => 0.1765205360,
(b_prevaddrlenofres_d = NULL) => 
   map(
   (NULL < b_inq_per_addr_i and b_inq_per_addr_i <= 2.5) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 236448) => 0.0880074528,
      (b_L80_Inp_AVM_AutoVal_d > 236448) => 0.0292268354,
      (b_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 19.45) => 0.0084534774,
         ((real)ST_cen_blue_col > 19.45) => 0.0913645808,
         ((real)ST_cen_blue_col = NULL) => 0.0144564849, 0.0144564849), 0.0194263595),
   (b_inq_per_addr_i > 2.5) => -0.0201995228,
   (b_inq_per_addr_i = NULL) => -0.0500407035, -0.0227555527), -0.0101747354);

// Tree: 324 
final_score_324 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 59) => 
   map(
   (NULL < s_mos_foreclosure_lseen_d and s_mos_foreclosure_lseen_d <= 52.5) => 
      map(
      (NULL < (real)ST_cen_low_hval and (real)ST_cen_low_hval <= 0.15) => 0.1427595797,
      ((real)ST_cen_low_hval > 0.15) => -0.0057287342,
      ((real)ST_cen_low_hval = NULL) => 0.0492669376, 0.0492669376),
   (s_mos_foreclosure_lseen_d > 52.5) => -0.0024064202,
   (s_mos_foreclosure_lseen_d = NULL) => 
      map(
      (NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 168.5) => -0.0130501901,
      ((real)BT_cen_trailer > 168.5) => 0.0512727181,
      ((real)BT_cen_trailer = NULL) => -0.0502032845, -0.0240153627), -0.0060430741),
(s_L79_adls_per_addr_c6_i > 59) => 0.0422136954,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0057877628, -0.0057877628);

// Tree: 325 
final_score_325 := map(
(NULL < s_rel_under25miles_cnt_d and s_rel_under25miles_cnt_d <= 0.5) => 
   map(
   (NULL < s_A46_Curr_AVM_AutoVal_d and s_A46_Curr_AVM_AutoVal_d <= 249492) => 
      map(
      (NULL < b_M_Bureau_ADL_FS_all_d and b_M_Bureau_ADL_FS_all_d <= 358) => -0.0506071277,
      (b_M_Bureau_ADL_FS_all_d > 358) => 0.1073805738,
      (b_M_Bureau_ADL_FS_all_d = NULL) => 0.1501753058, 0.0205023994),
   (s_A46_Curr_AVM_AutoVal_d > 249492) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0133314947,
      (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.1419774916,
      (final_model_segment = '') => 0.0608854624, 0.0608854624),
   (s_A46_Curr_AVM_AutoVal_d = NULL) => -0.0224658250, 0.0096746287),
(s_rel_under25miles_cnt_d > 0.5) => -0.0007769932,
(s_rel_under25miles_cnt_d = NULL) => -0.0045670141, -0.0009816012);

// Tree: 326 
final_score_326 := map(
(NULL < s_srchcomponentrisktype_i and s_srchcomponentrisktype_i <= 4.5) => 
   map(
   (NULL < b_I60_inq_retpymt_recency_d and b_I60_inq_retpymt_recency_d <= 9) => 
      map(
      (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.08428340205) => 0.0144033887,
      (b_add_curr_nhood_BUS_pct_i > 0.08428340205) => 0.1995518039,
      (b_add_curr_nhood_BUS_pct_i = NULL) => 0.0618773413, 0.0618773413),
   (b_I60_inq_retpymt_recency_d > 9) => -0.0044742637,
   (b_I60_inq_retpymt_recency_d = NULL) => 0.0165119154, -0.0015873138),
(s_srchcomponentrisktype_i > 4.5) => 
   map(
   (pf_pmt_type in ['American Express','Credit Terms','Dell Credit Card','Gift Card','Other']) => -0.0517555544,
   (pf_pmt_type in ['Diners Club','Discover','Mastercard','Prepaid Check','Visa']) => 0.0815722683,
   (pf_pmt_type = '') => -0.0028423887, -0.0028423887),
(s_srchcomponentrisktype_i = NULL) => 0.0007732537, -0.0011409900);

// Tree: 327 
final_score_327 := map(
(NULL < b_comb_age_d and b_comb_age_d <= 21.5) => 
   map(
   (NULL < s_hh_age_30_plus_d and s_hh_age_30_plus_d <= 2.5) => 
      map(
      (NULL < (real)ST_cen_business and (real)ST_cen_business <= 196) => 
         map(
         (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.12397931775) => -0.0574691444,
         (s_add_input_nhood_BUS_pct_i > 0.12397931775) => 0.0324792054,
         (s_add_input_nhood_BUS_pct_i = NULL) => -0.0185089580, -0.0185089580),
      ((real)ST_cen_business > 196) => 0.1832169937,
      ((real)ST_cen_business = NULL) => 0.0069614904, 0.0069614904),
   (s_hh_age_30_plus_d > 2.5) => 0.1878380406,
   (s_hh_age_30_plus_d = NULL) => 0.0280770348, 0.0280770348),
(b_comb_age_d > 21.5) => -0.0004891664,
(b_comb_age_d = NULL) => 0.0080554851, 0.0020795786);

// Tree: 328 
final_score_328 := map(
(NULL < s_mos_liens_rel_OT_lseen_d and s_mos_liens_rel_OT_lseen_d <= 34.5) => -0.0582887396,
(s_mos_liens_rel_OT_lseen_d > 34.5) => 0.0015008560,
(s_mos_liens_rel_OT_lseen_d = NULL) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.91742957745) => 
      map(
      (NULL < b_hh_age_30_plus_d and b_hh_age_30_plus_d <= 3.5) => -0.0150001152,
      (b_hh_age_30_plus_d > 3.5) => 0.0693251296,
      (b_hh_age_30_plus_d = NULL) => 
         map(
         (NULL < (real)BT_cen_retired2 and (real)BT_cen_retired2 <= 120.5) => 0.0196329406,
         ((real)BT_cen_retired2 > 120.5) => -0.0494897445,
         ((real)BT_cen_retired2 = NULL) => -0.0500346499, -0.0273876725), -0.0210863406),
   (s_add_input_nhood_BUS_pct_i > 0.91742957745) => 0.0949680629,
   (s_add_input_nhood_BUS_pct_i = NULL) => -0.0190035002, -0.0190035002), -0.0027000691);

// Tree: 329 
final_score_329 := map(
(NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 218707) => 
   map(
   (NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 0.5) => 
      map(
      (NULL < (real)BT_cen_health and (real)BT_cen_health <= 20.95) => 
         map(
         (NULL < b_rel_ageover40_count_d and b_rel_ageover40_count_d <= 0.5) => 0.0991989923,
         (b_rel_ageover40_count_d > 0.5) => -0.0489110642,
         (b_rel_ageover40_count_d = NULL) => -0.0193983592, -0.0193983592),
      ((real)BT_cen_health > 20.95) => 0.1690738142,
      ((real)BT_cen_health = NULL) => 0.0070724517, 0.0070724517),
   (b_C20_email_verification_d > 0.5) => -0.0157402743,
   (b_C20_email_verification_d = NULL) => 0.0215863814, 0.0007643452),
(s_L80_Inp_AVM_AutoVal_d > 218707) => -0.0215691626,
(s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0007501765, -0.0046294759);

// Tree: 330 
final_score_330 := map(
(NULL < (real)ST_cen_ownocc_p and (real)ST_cen_ownocc_p <= 18.25) => 
   map(
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => -0.0534656235,
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0233829207,
   (final_model_segment = '') => -0.0257522028, -0.0257522028),
((real)ST_cen_ownocc_p > 18.25) => 
   map(
   (NULL < (real)ST_cen_ownocc_p and (real)ST_cen_ownocc_p <= 31.55) => 0.0367410012,
   ((real)ST_cen_ownocc_p > 31.55) => -0.0018982317,
   ((real)ST_cen_ownocc_p = NULL) => 0.0018494605, 0.0018494605),
((real)ST_cen_ownocc_p = NULL) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => -0.0586160040,
   (final_model_segment in ['CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS WEB']) => 0.1519418430,
   (final_model_segment = '') => -0.0448130462, -0.0448130462), -0.0033445453);

// Tree: 331 
final_score_331 := map(
(btst_relatives_lvl_d in ['2. BILLTO DID 0','3. SHIPTO DID 0','4. DIDS EQUAL','5. RELATIVES','6. RELATIVES IN COMMON','7. NO RELATION']) => 0.0014308607,
(btst_relatives_lvl_d in ['1. BOTH DID 0']) => 
   map(
   (pf_avs_result in ['Error/Inval','Full Match','Unavailable','Zip Only']) => 
      map(
      (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 186.5) => -0.0036505315,
      ((real)BT_cen_span_lang > 186.5) => 0.0984622414,
      ((real)BT_cen_span_lang = NULL) => 0.0025788363, 0.0025788363),
   (pf_avs_result in ['Addr Only','International','No Match','Not Supported']) => 
      map(
      (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 4.75) => 0.0086969682,
      ((real)ST_cen_unemp > 4.75) => 0.0653100222,
      ((real)ST_cen_unemp = NULL) => 0.0308786911, 0.0308786911),
   (pf_avs_result = '') => 0.0073093105, 0.0073093105),
((integer)btst_relatives_lvl_d = NULL) => -0.0500361738, -0.0037714137);

// Tree: 332 
final_score_332 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 1.5) => -0.0061921824,
(s_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < (real)ST_cen_business and (real)ST_cen_business <= 26.5) => 
      map(
      (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 71.65) => 
         map(
         (NULL < s_srchaddrsrchcountmo_i and s_srchaddrsrchcountmo_i <= 1.5) => 0.0226927756,
         (s_srchaddrsrchcountmo_i > 1.5) => 0.0751037572,
         (s_srchaddrsrchcountmo_i = NULL) => 0.0184126761, 0.0281166373),
      ((real)ST_cen_civ_emp > 71.65) => 0.1702117924,
      ((real)ST_cen_civ_emp = NULL) => 0.0414612258, 0.0414612258),
   ((real)ST_cen_business > 26.5) => -0.0150683515,
   ((real)ST_cen_business = NULL) => 0.0105056115, 0.0105056115),
(s_inq_ssns_per_addr_i = NULL) => -0.0500057369, -0.0067082875);

// Tree: 333 
final_score_333 := map(
(pf_cid_result in ['Match','Null']) => 
   map(
   (NULL < b_srchaddrsrchcountmo_i and b_srchaddrsrchcountmo_i <= 0.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0015621660,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0404047606,
      (final_model_segment = '') => -0.0013159138, -0.0013159138),
   (b_srchaddrsrchcountmo_i > 0.5) => -0.0347466920,
   (b_srchaddrsrchcountmo_i = NULL) => 0.0068159795, -0.0013565295),
(pf_cid_result in ['Invalid','No Match','Other']) => 
   map(
   (NULL < b_rel_incomeover75_count_d and b_rel_incomeover75_count_d <= 1.5) => 0.1147479339,
   (b_rel_incomeover75_count_d > 1.5) => -0.0002210085,
   (b_rel_incomeover75_count_d = NULL) => 0.0285162226, 0.0340766247),
(pf_cid_result = '') => -0.0007100963, -0.0007100963);

// Tree: 334 
final_score_334 := map(
(NULL < s_C17_Inv_Phn_Per_ADL_i and s_C17_Inv_Phn_Per_ADL_i <= 0.5) => -0.0064308278,
(s_C17_Inv_Phn_Per_ADL_i > 0.5) => 
   map(
   (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 91) => 0.2275017057,
   ((real)ST_cen_span_lang > 91) => -0.0509561656,
   ((real)ST_cen_span_lang = NULL) => 0.0816428207, 0.0816428207),
(s_C17_Inv_Phn_Per_ADL_i = NULL) => 
   map(
   (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 186.5) => 0.0035694776,
   ((real)ST_cen_span_lang > 186.5) => 
      map(
      (NULL < (real)BT_cen_incollege and (real)BT_cen_incollege <= 6.5) => -0.0270477776,
      ((real)BT_cen_incollege > 6.5) => 0.1237927456,
      ((real)BT_cen_incollege = NULL) => 0.0444714360, 0.0444714360),
   ((real)ST_cen_span_lang = NULL) => 0.0550284895, 0.0167965441), -0.0013331637);

// Tree: 335 
final_score_335 := map(
(NULL < pf_product_desc and pf_product_desc <= 6.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 3.5) => 0.0007238795,
   (pf_product_desc > 3.5) => 
      map(
      (NULL < (real)ST_cen_families and (real)ST_cen_families <= 684) => 
         map(
         (bf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity']) => -0.0486179651,
         (bf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','5: Vuln Vic/Friendly','6: Other']) => 0.0479642605,
         (bf_seg_FraudPoint_3_0 = '') => 0.0031973512, 0.0031973512),
      ((real)ST_cen_families > 684) => 0.2206891999,
      ((real)ST_cen_families = NULL) => 0.0357518635, 0.0357518635),
   (pf_product_desc = NULL) => 0.0021874317, 0.0021874317),
(pf_product_desc > 6.5) => -0.0505912645,
(pf_product_desc = NULL) => -0.0008905767, -0.0008905767);

// Tree: 336 
final_score_336 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 45.5) => 
   map(
   (NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 72) => 0.0018738988,
   (b_phones_per_addr_curr_i > 72) => 0.0814478287,
   (b_phones_per_addr_curr_i = NULL) => 
      map(
      (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 186.5) => 
         map(
         (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0299653178,
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB']) => 0.0152335071,
         (final_model_segment = '') => -0.0008805688, -0.0008805688),
      ((real)BT_cen_span_lang > 186.5) => 0.0394940462,
      ((real)BT_cen_span_lang = NULL) => 0.1526129952, 0.0220432796), 0.0043137787),
(s_L79_adls_per_addr_c6_i > 45.5) => 0.0431506636,
(s_L79_adls_per_addr_c6_i = NULL) => 0.0044979965, 0.0044979965);

// Tree: 337 
final_score_337 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < (real)BT_cen_health and (real)BT_cen_health <= 79.85) => -0.0066584855,
   ((real)BT_cen_health > 79.85) => 0.0799929220,
   ((real)BT_cen_health = NULL) => 0.0455325623, -0.0004395186),
(final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 
   map(
   (NULL < (real)BT_cen_civ_emp and (real)BT_cen_civ_emp <= 56.35) => -0.0341675239,
   ((real)BT_cen_civ_emp > 56.35) => 
      map(
      (NULL < (real)ST_cen_totcrime and (real)ST_cen_totcrime <= 60) => 0.0007382415,
      ((real)ST_cen_totcrime > 60) => 0.0823323833,
      ((real)ST_cen_totcrime = NULL) => 0.0386212359, 0.0386212359),
   ((real)BT_cen_civ_emp = NULL) => -0.0502628939, -0.0008374486),
(final_model_segment = '') => -0.0004448182, -0.0004448182);

// Tree: 338 
final_score_338 := map(
(NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 1.5) => 
   map(
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => -0.0751466527,
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0355723308,
   (final_model_segment = '') => -0.0432782219, -0.0432782219),
((real)BT_cen_no_move > 1.5) => 
   map(
   (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 1017.5) => 
      map(
      (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 18.5) => 0.0006582326,
      (s_inq_per_addr_i > 18.5) => 0.0822250316,
      (s_inq_per_addr_i = NULL) => 0.0014398761, 0.0014398761),
   (btst_distphone2addr2_i > 1017.5) => 0.0563323909,
   (btst_distphone2addr2_i = NULL) => 0.0051975557, 0.0040015510),
((real)BT_cen_no_move = NULL) => 0.0099664340, 0.0037861981);

// Tree: 339 
final_score_339 := map(
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 193.5) => 
   map(
   (NULL < s_phones_per_addr_c6_i and s_phones_per_addr_c6_i <= 31) => 0.0063646922,
   (s_phones_per_addr_c6_i > 31) => -0.0620447444,
   (s_phones_per_addr_c6_i = NULL) => 0.0061318242, 0.0061318242),
((real)ST_cen_span_lang > 193.5) => 
   map(
   (pf_avs_result in ['International','No Match','Not Supported','Unavailable']) => -0.0551209211,
   (pf_avs_result in ['Addr Only','Error/Inval','Full Match','Zip Only']) => 
      map(
      (NULL < s_C10_M_Hdr_FS_d and s_C10_M_Hdr_FS_d <= 360.5) => -0.0553239589,
      (s_C10_M_Hdr_FS_d > 360.5) => 0.0945592962,
      (s_C10_M_Hdr_FS_d = NULL) => -0.0363028824, -0.0277682371),
   (pf_avs_result = '') => -0.0321181249, -0.0321181249),
((real)ST_cen_span_lang = NULL) => -0.0170168251, 0.0041468933);

// Tree: 340 
final_score_340 := map(
(NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => 0.0002219180,
(s_C14_addrs_15yr_i > 11.5) => 
   map(
   (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 50) => -0.0520734441,
   ((real)BT_cen_no_move > 50) => 0.1012999421,
   ((real)BT_cen_no_move = NULL) => 0.0140142752, 0.0140142752),
(s_C14_addrs_15yr_i = NULL) => 
   map(
   (final_model_segment in ['CONS ADDR- ID/RELS OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 67.9) => -0.0588060581,
      ((real)BT_cen_ownocc_p > 67.9) => 0.0086795253,
      ((real)BT_cen_ownocc_p = NULL) => -0.0306512446, -0.0306512446),
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.0053578314,
   (final_model_segment = '') => 0.0013964876, 0.0013964876), 0.0005534731);

// Tree: 341 
final_score_341 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < btst_distphoneaddr2_i and btst_distphoneaddr2_i <= 37.5) => -0.0039819429,
   (btst_distphoneaddr2_i > 37.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.0046202790,
      (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.0853630810,
      (final_model_segment = '') => 0.0202666114, 0.0202666114),
   (btst_distphoneaddr2_i = NULL) => 
      map(
      (NULL < b_mos_liens_unrel_ST_fseen_d and b_mos_liens_unrel_ST_fseen_d <= 72.5) => 0.0759535943,
      (b_mos_liens_unrel_ST_fseen_d > 72.5) => -0.0022564554,
      (b_mos_liens_unrel_ST_fseen_d = NULL) => -0.0109209075, -0.0027260870), -0.0025104040),
(b_inq_lnames_per_addr_i > 8.5) => 0.0395909013,
(b_inq_lnames_per_addr_i = NULL) => -0.0500333659, -0.0073035346);

// Tree: 342 
final_score_342 := map(
(NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 1.5) => -0.0633264337,
((real)BT_cen_no_move > 1.5) => 
   map(
   (NULL < b_A50_pb_average_dollars_d and b_A50_pb_average_dollars_d <= 7.5) => 
      map(
      (NULL < s_add_input_nhood_SFD_pct_d and s_add_input_nhood_SFD_pct_d <= 0.5303866924) => 0.1373549388,
      (s_add_input_nhood_SFD_pct_d > 0.5303866924) => 0.0000371409,
      (s_add_input_nhood_SFD_pct_d = NULL) => 0.0394962782, 0.0394962782),
   (b_A50_pb_average_dollars_d > 7.5) => 0.0004274582,
   (b_A50_pb_average_dollars_d = NULL) => 
      map(
      (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 10.5) => 0.0127751972,
      (btst_distphone2addr2_i > 10.5) => 0.0598004944,
      (btst_distphone2addr2_i = NULL) => 0.0012752703, 0.0072629743), 0.0015867085),
((real)BT_cen_no_move = NULL) => -0.0009994633, 0.0000710634);

// Tree: 343 
final_score_343 := map(
(btst_email_topleveldomain_n in ['BIZ','COM','EDU','GOV','NET','ORG','US']) => 0.0042561154,
(btst_email_topleveldomain_n in ['MIL','OTH']) => 0.0857111987,
(btst_email_topleveldomain_n = '') => 
   map(
   (NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 189568.5) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 567.895) => 
         map(
         (NULL < b_A49_Curr_AVM_Chg_1yr_i and b_A49_Curr_AVM_Chg_1yr_i <= -13995) => 0.1719215175,
         (b_A49_Curr_AVM_Chg_1yr_i > -13995) => 0.0025304982,
         (b_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0151951071, 0.0235812806),
      (pf_order_amt_c > 567.895) => -0.0236745534,
      (pf_order_amt_c = NULL) => -0.0113237233, -0.0113237233),
   (s_curraddrmedianincome_d > 189568.5) => 0.1586895403,
   (s_curraddrmedianincome_d = NULL) => 0.0071839817, -0.0042412989), 0.0014417670);

// Tree: 344 
final_score_344 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 94.5) => 
   map(
   (NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 22.5) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 30177) => 0.0803554500,
      (b_L80_Inp_AVM_AutoVal_d > 30177) => 
         map(
         (NULL < s_A50_pb_total_orders_d and s_A50_pb_total_orders_d <= 49.5) => 0.0042585281,
         (s_A50_pb_total_orders_d > 49.5) => 0.1937692410,
         (s_A50_pb_total_orders_d = NULL) => 0.0103916053, 0.0073900066),
      (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0056046569, -0.0006693681),
   (b_L79_adls_per_addr_c6_i > 22.5) => 0.0660437604,
   (b_L79_adls_per_addr_c6_i = NULL) => -0.0004613993, -0.0004613993),
(s_L79_adls_per_addr_c6_i > 94.5) => -0.0628755543,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0007802262, -0.0007802262);

// Tree: 345 
final_score_345 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 2521.5) => 
      map(
      (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 178.5) => 0.0002061165,
      ((real)BT_cen_span_lang > 178.5) => -0.0239761051,
      ((real)BT_cen_span_lang = NULL) => -0.0273325173, -0.0034474321),
   (btst_distaddraddr2_i > 2521.5) => 
      map(
      (NULL < s_add_input_nhood_SFD_pct_d and s_add_input_nhood_SFD_pct_d <= 0.575532987) => 0.1061415011,
      (s_add_input_nhood_SFD_pct_d > 0.575532987) => 0.0109720651,
      (s_add_input_nhood_SFD_pct_d = NULL) => 0.0519933738, 0.0519933738),
   (btst_distaddraddr2_i = NULL) => -0.0030359185, -0.0030359185),
(s_inq_ssns_per_addr_i > 4.5) => -0.0280004395,
(s_inq_ssns_per_addr_i = NULL) => -0.0500060172, -0.0052093220);

// Tree: 346 
final_score_346 := map(
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 68.5) => -0.0017756720,
   (b_phones_per_addr_curr_i > 68.5) => 0.0821514746,
   (b_phones_per_addr_curr_i = NULL) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 17.65) => -0.0122442558,
      ((real)ST_cen_blue_col > 17.65) => 
         map(
         (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 23.9) => 0.0106046195,
         ((real)BT_cen_high_ed > 23.9) => 0.1230670201,
         ((real)BT_cen_high_ed = NULL) => 0.0429214013, 0.0429214013),
      ((real)ST_cen_blue_col = NULL) => -0.0059595607, -0.0059595607), -0.0018357838),
(pf_avs_result in ['International','Not Supported']) => 0.0358958019,
(pf_avs_result = '') => -0.0017004053, -0.0017004053);

// Tree: 347 
final_score_347 := map(
(NULL < s_C21_M_Bureau_ADL_FS_d and s_C21_M_Bureau_ADL_FS_d <= 38.5) => -0.0473487306,
(s_C21_M_Bureau_ADL_FS_d > 38.5) => 0.0052894605,
(s_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 171.5) => 
      map(
      (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => -0.0090255690,
      (pf_ship_method in ['Next Day']) => 0.0268347184,
      (pf_ship_method = '') => -0.0041028458, -0.0041028458),
   ((real)BT_cen_trailer > 171.5) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.07968959675) => 0.0711865304,
      (b_add_input_nhood_BUS_pct_i > 0.07968959675) => -0.0017718463,
      (b_add_input_nhood_BUS_pct_i = NULL) => 0.0314502717, 0.0314502717),
   ((real)BT_cen_trailer = NULL) => -0.0508392961, -0.0197015966), -0.0014097489);

// Tree: 348 
final_score_348 := map(
(final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 
   map(
   (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 91.5) => 0.0333339817,
   ((real)ST_cen_easiqlife > 91.5) => 
      map(
      (NULL < (real)BT_cen_blue_col and (real)BT_cen_blue_col <= 11.4) => -0.0605960036,
      ((real)BT_cen_blue_col > 11.4) => -0.0376831730,
      ((real)BT_cen_blue_col = NULL) => -0.0508871771, -0.0508871771),
   ((real)ST_cen_easiqlife = NULL) => -0.0256208294, -0.0256208294),
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < s_varrisktype_i and s_varrisktype_i <= 5.5) => -0.0031125733,
   (s_varrisktype_i > 5.5) => 0.0552685611,
   (s_varrisktype_i = NULL) => -0.0068045702, -0.0032102821),
(final_model_segment = '') => -0.0034937529, -0.0034937529);

// Tree: 349 
final_score_349 := map(
(final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB']) => 
   map(
   (NULL < s_prevaddrmedianvalue_d and s_prevaddrmedianvalue_d <= 554761.5) => -0.0373129792,
   (s_prevaddrmedianvalue_d > 554761.5) => 0.0622035058,
   (s_prevaddrmedianvalue_d = NULL) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 166.5) => -0.0198412191,
      ((real)ST_cen_span_lang > 166.5) => -0.0479349838,
      ((real)ST_cen_span_lang = NULL) => -0.0227315241, -0.0227315241), -0.0250852743),
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < s_nap_contradictory_i and s_nap_contradictory_i <= 0.5) => -0.0015683629,
   (s_nap_contradictory_i > 0.5) => 0.0635702847,
   (s_nap_contradictory_i = NULL) => 0.0000891638, 0.0000891638),
(final_model_segment = '') => -0.0019224642, -0.0019224642);

// Tree: 350 
final_score_350 := map(
(NULL < b_hh_age_30_plus_d and b_hh_age_30_plus_d <= 6.5) => 
   map(
   (NULL < b_rel_ageover30_count_d and b_rel_ageover30_count_d <= 2.5) => -0.0379826545,
   (b_rel_ageover30_count_d > 2.5) => 
      map(
      (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 31.5) => -0.0039575706,
      (btst_distaddraddr2_i > 31.5) => 0.0252068737,
      (btst_distaddraddr2_i = NULL) => -0.0011034911, -0.0011034911),
   (b_rel_ageover30_count_d = NULL) => 
      map(
      (NULL < b_A46_Curr_AVM_AutoVal_d and b_A46_Curr_AVM_AutoVal_d <= 207885) => 0.1177776127,
      (b_A46_Curr_AVM_AutoVal_d > 207885) => -0.0536686448,
      (b_A46_Curr_AVM_AutoVal_d = NULL) => -0.0054408500, -0.0022005855), -0.0059406371),
(b_hh_age_30_plus_d > 6.5) => 0.0759739768,
(b_hh_age_30_plus_d = NULL) => -0.0008112250, -0.0044318151);

// Tree: 351 
final_score_351 := map(
(pf_avs_result in ['International','Not Supported']) => -0.0350595322,
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < s_srchcomponentrisktype_i and s_srchcomponentrisktype_i <= 6.5) => 
      map(
      (pf_ship_method in ['2nd Day','3rd Day','Ground','Next Day']) => -0.0010038886,
      (pf_ship_method in ['Other']) => 0.2798226505,
      (pf_ship_method = '') => 0.0010332391, 0.0010332391),
   (s_srchcomponentrisktype_i > 6.5) => 0.0450855729,
   (s_srchcomponentrisktype_i = NULL) => 
      map(
      (NULL < s_nap_lname_verd_d and s_nap_lname_verd_d <= 0.5) => 0.0036693620,
      (s_nap_lname_verd_d > 0.5) => -0.0488095704,
      (s_nap_lname_verd_d = NULL) => -0.0006496096, -0.0006496096), 0.0009714964),
(pf_avs_result = '') => 0.0008531751, 0.0008531751);

// Tree: 352 
final_score_352 := map(
(NULL < b_phone_ver_experian_d and b_phone_ver_experian_d <= 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_rel_incomeover75_count_d and s_rel_incomeover75_count_d <= 12.5) => 0.0101390444,
      (s_rel_incomeover75_count_d > 12.5) => 0.0966675745,
      (s_rel_incomeover75_count_d = NULL) => 0.0129281442, 0.0143859072),
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR+ DIFF    OTH']) => 
      map(
      (NULL < b_add_input_nhood_VAC_pct_i and b_add_input_nhood_VAC_pct_i <= 0.0352350389) => 0.1432882906,
      (b_add_input_nhood_VAC_pct_i > 0.0352350389) => 0.0110502784,
      (b_add_input_nhood_VAC_pct_i = NULL) => 0.0746262458, 0.0746262458),
   (final_model_segment = '') => 0.0156014670, 0.0156014670),
(b_phone_ver_experian_d > 0.5) => -0.0039536789,
(b_phone_ver_experian_d = NULL) => -0.0069232686, 0.0012891133);

// Tree: 353 
final_score_353 := map(
(final_model_segment in ['CONS ADDR- LNAME   OTH']) => -0.0414618699,
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0002427472,
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 567.04) => 
         map(
         (NULL < s_fp_prevaddrcrimeindex_i and s_fp_prevaddrcrimeindex_i <= 26) => 0.1533441862,
         (s_fp_prevaddrcrimeindex_i > 26) => 0.0261225348,
         (s_fp_prevaddrcrimeindex_i = NULL) => 0.0559271733, 0.0559271733),
      (pf_order_amt_c > 567.04) => -0.0081619140,
      (pf_order_amt_c = NULL) => 0.0133933085, 0.0133933085),
   (final_model_segment = '') => 0.0009601159, 0.0009601159),
(final_model_segment = '') => 0.0007975894, 0.0007975894);

// Tree: 354 
final_score_354 := map(
(NULL < b_L79_adls_per_addr_curr_i and b_L79_adls_per_addr_curr_i <= 3.5) => 0.0056633194,
(b_L79_adls_per_addr_curr_i > 3.5) => -0.0221789113,
(b_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 246480.5) => 0.0442888548,
   (s_L80_Inp_AVM_AutoVal_d > 246480.5) => -0.0549648307,
   (s_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (pf_ship_method in ['Ground','Other']) => -0.0163540509,
      (pf_ship_method in ['2nd Day','3rd Day','Next Day']) => 
         map(
         (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 4.95) => -0.0045034758,
         ((real)ST_cen_unemp > 4.95) => 0.0689198683,
         ((real)ST_cen_unemp = NULL) => 0.0245474951, 0.0245474951),
      (pf_ship_method = '') => -0.0061013238, -0.0061013238), -0.0069867427), 0.0006030546);

// Tree: 355 
final_score_355 := map(
(NULL < b_C20_email_count_i and b_C20_email_count_i <= 2.5) => 
   map(
   (NULL < b_varrisktype_i and b_varrisktype_i <= 7.5) => -0.0154811974,
   (b_varrisktype_i > 7.5) => 0.1366564010,
   (b_varrisktype_i = NULL) => -0.0143150729, -0.0143150729),
(b_C20_email_count_i > 2.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0056410150,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 
      map(
      (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1.5) => -0.0558695723,
      (b_P88_Phn_Dst_to_Inp_Add_i > 1.5) => 0.0642408156,
      (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => -0.0054415469, -0.0054415469),
   (final_model_segment = '') => 0.0053173816, 0.0053173816),
(b_C20_email_count_i = NULL) => 0.0022879224, -0.0040036106);

// Tree: 356 
final_score_356 := map(
(NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 71.5) => 0.0020945672,
(b_phones_per_addr_curr_i > 71.5) => 0.0850037842,
(b_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < s_C12_NonDerog_Recency_i and s_C12_NonDerog_Recency_i <= 4.5) => -0.0339433543,
   (s_C12_NonDerog_Recency_i > 4.5) => 0.1183380333,
   (s_C12_NonDerog_Recency_i = NULL) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 233000) => -0.0341742381,
      (b_L80_Inp_AVM_AutoVal_d > 233000) => 0.0459759949,
      (b_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 21.45) => -0.0155814350,
         ((real)ST_cen_blue_col > 21.45) => 0.1227456597,
         ((real)ST_cen_blue_col = NULL) => -0.0079198134, -0.0079198134), -0.0057090297), -0.0106839508), 0.0010401672);

// Tree: 357 
final_score_357 := map(
(NULL < b_A50_pb_average_dollars_d and b_A50_pb_average_dollars_d <= 755) => 
   map(
   (NULL < s_assocsuspicousidcount_i and s_assocsuspicousidcount_i <= 8.5) => 0.0054715795,
   (s_assocsuspicousidcount_i > 8.5) => 
      map(
      (NULL < b_comb_age_d and b_comb_age_d <= 42.5) => 0.1695018022,
      (b_comb_age_d > 42.5) => -0.0234345481,
      (b_comb_age_d = NULL) => 0.0355567820, 0.0355567820),
   (s_assocsuspicousidcount_i = NULL) => -0.0044111764, 0.0055855801),
(b_A50_pb_average_dollars_d > 755) => 
   map(
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => -0.0391564385,
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS WEB']) => -0.0131882300,
   (final_model_segment = '') => -0.0180899977, -0.0180899977),
(b_A50_pb_average_dollars_d = NULL) => -0.0043886756, -0.0007416474);

// Tree: 358 
final_score_358 := map(
(NULL < s_rel_homeover500_count_d and s_rel_homeover500_count_d <= 4.5) => -0.0049249808,
(s_rel_homeover500_count_d > 4.5) => 
   map(
   (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.1630825144) => -0.0350152657,
   (b_add_input_mobility_index_i > 0.1630825144) => 
      map(
      (NULL < b_estimated_income_d and b_estimated_income_d <= 78500) => 
         map(
         (NULL < b_L79_adls_per_addr_curr_i and b_L79_adls_per_addr_curr_i <= 1.5) => 0.0234779660,
         (b_L79_adls_per_addr_curr_i > 1.5) => 0.1596349806,
         (b_L79_adls_per_addr_curr_i = NULL) => 0.0653724320, 0.0653724320),
      (b_estimated_income_d > 78500) => 0.0090383685,
      (b_estimated_income_d = NULL) => -0.0536717013, 0.0165312849),
   (b_add_input_mobility_index_i = NULL) => 0.0102882765, 0.0102882765),
(s_rel_homeover500_count_d = NULL) => -0.0002506306, -0.0023744268);

// Tree: 359 
final_score_359 := map(
(NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 6.5) => 
   map(
   (NULL < b_rel_incomeover25_count_d and b_rel_incomeover25_count_d <= 32.5) => 
      map(
      (NULL < b_L75_Add_Drop_Delivery_i and b_L75_Add_Drop_Delivery_i <= 0.5) => -0.0037801203,
      (b_L75_Add_Drop_Delivery_i > 0.5) => 0.1144752247,
      (b_L75_Add_Drop_Delivery_i = NULL) => -0.0028315997, -0.0028315997),
   (b_rel_incomeover25_count_d > 32.5) => -0.0706159799,
   (b_rel_incomeover25_count_d = NULL) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 193.5) => 0.0028672337,
      ((real)ST_cen_span_lang > 193.5) => -0.0471385984,
      ((real)ST_cen_span_lang = NULL) => 0.0016475792, 0.0016475792), -0.0028251808),
(s_inq_adls_per_addr_i > 6.5) => 0.0259665794,
(s_inq_adls_per_addr_i = NULL) => -0.0500065739, -0.0047062572);

// Tree: 360 
final_score_360 := map(
(NULL < b_inq_adls_per_addr_i and b_inq_adls_per_addr_i <= 2.5) => 
   map(
   (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 5.5) => 
      map(
      (NULL < s_bus_name_nover_i and s_bus_name_nover_i <= 0.5) => 0.0160690996,
      (s_bus_name_nover_i > 0.5) => -0.0130251064,
      (s_bus_name_nover_i = NULL) => -0.0016992737, -0.0016992737),
   (b_inq_lnames_per_addr_i > 5.5) => 0.0775261026,
   (b_inq_lnames_per_addr_i = NULL) => -0.0013671036, -0.0013671036),
(b_inq_adls_per_addr_i > 2.5) => 
   map(
   (pf_pmt_type in ['American Express','Dell Credit Card','Discover','Gift Card','Mastercard','Other','Visa']) => -0.0498522837,
   (pf_pmt_type in ['Credit Terms','Diners Club','Prepaid Check']) => 0.0667335998,
   (pf_pmt_type = '') => -0.0394688534, -0.0394688534),
(b_inq_adls_per_addr_i = NULL) => -0.0500300438, -0.0079755525);

// Tree: 361 
final_score_361 := map(
(NULL < s_srchunvrfdaddrcount_i and s_srchunvrfdaddrcount_i <= 0.5) => -0.0064708576,
(s_srchunvrfdaddrcount_i > 0.5) => 
   map(
   (NULL < s_A46_Curr_AVM_AutoVal_d and s_A46_Curr_AVM_AutoVal_d <= 175762.5) => 0.1900876263,
   (s_A46_Curr_AVM_AutoVal_d > 175762.5) => 
      map(
      (NULL < b_add_curr_mobility_index_i and b_add_curr_mobility_index_i <= 0.2572529317) => -0.0068682832,
      (b_add_curr_mobility_index_i > 0.2572529317) => 0.1656418138,
      (b_add_curr_mobility_index_i = NULL) => 0.0502542655, 0.0502542655),
   (s_A46_Curr_AVM_AutoVal_d = NULL) => -0.0129655496, 0.0304028192),
(s_srchunvrfdaddrcount_i = NULL) => 
   map(
   (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 187.5) => 0.0034246607,
   ((real)BT_cen_span_lang > 187.5) => 0.0599247030,
   ((real)BT_cen_span_lang = NULL) => -0.0508258092, -0.0149905506), -0.0069692924);

// Tree: 362 
final_score_362 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 103) => 
   map(
   (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 198.5) => 
      map(
      (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.0191288755) => 
         map(
         (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 171.5) => -0.0213526481,
         ((real)ST_cen_easiqlife > 171.5) => 0.0841701645,
         ((real)ST_cen_easiqlife = NULL) => -0.0197288473, -0.0197288473),
      (b_add_curr_nhood_BUS_pct_i > 0.0191288755) => 0.0116685989,
      (b_add_curr_nhood_BUS_pct_i = NULL) => 0.0124233808, 0.0029586175),
   ((real)ST_cen_very_rich > 198.5) => 0.0830179905,
   ((real)ST_cen_very_rich = NULL) => 0.0236490971, 0.0042314012),
(s_L79_adls_per_addr_c6_i > 103) => -0.0634539791,
(s_L79_adls_per_addr_c6_i = NULL) => 0.0038732993, 0.0038732993);

// Tree: 363 
final_score_363 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 
   map(
   (NULL < s_prevaddrageoldest_d and s_prevaddrageoldest_d <= 35.5) => -0.0247550702,
   (s_prevaddrageoldest_d > 35.5) => 
      map(
      (NULL < b_comb_age_d and b_comb_age_d <= 25.5) => 
         map(
         (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 70.5) => 0.1900860016,
         ((real)ST_cen_easiqlife > 70.5) => 0.0278742476,
         ((real)ST_cen_easiqlife = NULL) => 0.0548197217, 0.0548197217),
      (b_comb_age_d > 25.5) => 0.0014298493,
      (b_comb_age_d = NULL) => -0.0395535744, -0.0004515426),
   (s_prevaddrageoldest_d = NULL) => 0.0033860825, -0.0050008782),
(s_inq_ssns_per_addr_i > 4.5) => -0.0271204884,
(s_inq_ssns_per_addr_i = NULL) => -0.0500063105, -0.0070213903);

// Tree: 364 
final_score_364 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 3.5) => 
   map(
   (NULL < s_hh_age_30_plus_d and s_hh_age_30_plus_d <= 6.5) => -0.0010623389,
   (s_hh_age_30_plus_d > 6.5) => 
      map(
      (NULL < (real)BT_cen_incollege and (real)BT_cen_incollege <= 5.85) => 0.1371840341,
      ((real)BT_cen_incollege > 5.85) => -0.0042748396,
      ((real)BT_cen_incollege = NULL) => 0.0664545973, 0.0664545973),
   (s_hh_age_30_plus_d = NULL) => 0.0000306080, -0.0004464387),
(s_inq_ssns_per_addr_i > 3.5) => 
   map(
   (NULL < s_C12_source_profile_d and s_C12_source_profile_d <= 63.65) => -0.0486102700,
   (s_C12_source_profile_d > 63.65) => 0.0238756271,
   (s_C12_source_profile_d = NULL) => -0.0180898923, -0.0180898923),
(s_inq_ssns_per_addr_i = NULL) => -0.0500061844, -0.0027256583);

// Tree: 365 
final_score_365 := map(
(NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 18.5) => 0.0669303648,
   (s_mos_liens_unrel_OT_lseen_d > 18.5) => -0.0005617163,
   (s_mos_liens_unrel_OT_lseen_d = NULL) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 263228) => -0.0108322014,
      (b_L80_Inp_AVM_AutoVal_d > 263228) => 0.0511075860,
      (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0067815993, -0.0017832059), -0.0005188729),
(s_P85_Phn_Not_Issued_i > 0.5) => 
   map(
   (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 43.2) => -0.0103996571,
   ((real)BT_cen_high_ed > 43.2) => 0.0845580233,
   ((real)BT_cen_high_ed = NULL) => -0.0719432806, 0.0072634336),
(s_P85_Phn_Not_Issued_i = NULL) => 0.0039911720, -0.0002237584);

// Tree: 366 
final_score_366 := map(
(NULL < (real)BT_cen_families and (real)BT_cen_families <= 2671.5) => 
   map(
   (NULL < s_rel_under100miles_cnt_d and s_rel_under100miles_cnt_d <= 0.5) => 
      map(
      (NULL < s_inq_lnames_per_addr_i and s_inq_lnames_per_addr_i <= 1.5) => 0.0025954694,
      (s_inq_lnames_per_addr_i > 1.5) => 
         map(
         (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 40.25) => 0.1481107135,
         ((real)BT_cen_high_ed > 40.25) => -0.0114568227,
         ((real)BT_cen_high_ed = NULL) => 0.0593079107, 0.0593079107),
      (s_inq_lnames_per_addr_i = NULL) => 0.0128179314, 0.0128179314),
   (s_rel_under100miles_cnt_d > 0.5) => 0.0007318458,
   (s_rel_under100miles_cnt_d = NULL) => -0.0030906584, 0.0005476580),
((real)BT_cen_families > 2671.5) => 0.0878474833,
((real)BT_cen_families = NULL) => 0.0333540592, 0.0045059187);

// Tree: 367 
final_score_367 := map(
(NULL < b_rel_ageover40_count_d and b_rel_ageover40_count_d <= 0.5) => 
   map(
   (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 99.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0513811708,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
         map(
         (NULL < s_add_curr_nhood_SFD_pct_d and s_add_curr_nhood_SFD_pct_d <= 0.81939880735) => 0.0197071950,
         (s_add_curr_nhood_SFD_pct_d > 0.81939880735) => 0.2645471562,
         (s_add_curr_nhood_SFD_pct_d = NULL) => 0.1165863163, 0.1165863163),
      (final_model_segment = '') => 0.0651367768, 0.0651367768),
   ((real)ST_cen_easiqlife > 99.5) => 0.0070662808,
   ((real)ST_cen_easiqlife = NULL) => 0.0255133922, 0.0255133922),
(b_rel_ageover40_count_d > 0.5) => -0.0021818088,
(b_rel_ageover40_count_d = NULL) => 0.0012035510, 0.0025448971);

// Tree: 368 
final_score_368 := map(
(NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 140.5) => -0.0115534713,
((real)ST_cen_easiqlife > 140.5) => 
   map(
   (NULL < b_prevaddrageoldest_d and b_prevaddrageoldest_d <= 6.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.0080162436,
      (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 0.1430407348,
      (final_model_segment = '') => 0.0318211394, 0.0318211394),
   (b_prevaddrageoldest_d > 6.5) => 0.0024016863,
   (b_prevaddrageoldest_d = NULL) => 
      map(
      (NULL < (real)BT_cen_unemp and (real)BT_cen_unemp <= 5.05) => -0.0205011250,
      ((real)BT_cen_unemp > 5.05) => 0.0786275459,
      ((real)BT_cen_unemp = NULL) => -0.0500526352, -0.0187486373), 0.0011184249),
((real)ST_cen_easiqlife = NULL) => -0.0539761076, -0.0102665872);

// Tree: 369 
final_score_369 := map(
(pf_avs_result in ['International','Not Supported']) => -0.0540532247,
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
         map(
         (NULL < s_comb_age_d and s_comb_age_d <= 26.5) => 0.0287863810,
         (s_comb_age_d > 26.5) => -0.0063694593,
         (s_comb_age_d = NULL) => -0.0073374811, -0.0033080441),
      (final_model_segment in ['CONS ADDR+ DIFF    OTH']) => 0.0315883880,
      (final_model_segment = '') => -0.0030820464, -0.0030820464),
   (b_inq_lnames_per_addr_i > 8.5) => 0.0337727648,
   (b_inq_lnames_per_addr_i = NULL) => -0.0500256932, -0.0077248588),
(pf_avs_result = '') => -0.0078882646, -0.0078882646);

// Tree: 370 
final_score_370 := map(
(NULL < b_inq_adls_per_addr_i and b_inq_adls_per_addr_i <= 2.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 1.5) => -0.0296263478,
   (pf_product_desc > 1.5) => 0.0094724784,
   (pf_product_desc = NULL) => -0.0053495161, -0.0053495161),
(b_inq_adls_per_addr_i > 2.5) => 
   map(
   (NULL < b_C13_Curr_Addr_LRes_d and b_C13_Curr_Addr_LRes_d <= 6.5) => -0.1092324584,
   (b_C13_Curr_Addr_LRes_d > 6.5) => 
      map(
      (NULL < pf_avs_error and pf_avs_error <= 0.5) => -0.0314343129,
      (pf_avs_error > 0.5) => 0.0925720894,
      (pf_avs_error = NULL) => -0.0182821187, -0.0182821187),
   (b_C13_Curr_Addr_LRes_d = NULL) => -0.0582690989, -0.0305700826),
(b_inq_adls_per_addr_i = NULL) => -0.0500188591, -0.0108992112);

// Tree: 371 
final_score_371 := map(
(NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.9611101181) => -0.0048976862,
(s_add_input_nhood_MFD_pct_i > 0.9611101181) => 
   map(
   (NULL < s_rel_count_i and s_rel_count_i <= 10.5) => -0.0347782262,
   (s_rel_count_i > 10.5) => 0.1464335028,
   (s_rel_count_i = NULL) => 0.0233024562, 0.0233024562),
(s_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < s_A50_pb_total_orders_d and s_A50_pb_total_orders_d <= 35.5) => -0.0142450914,
   (s_A50_pb_total_orders_d > 35.5) => 0.3565106736,
   (s_A50_pb_total_orders_d = NULL) => 
      map(
      (NULL < (real)ST_cen_pop_0_5_p and (real)ST_cen_pop_0_5_p <= 9.65) => -0.0401573090,
      ((real)ST_cen_pop_0_5_p > 9.65) => 0.0499935402,
      ((real)ST_cen_pop_0_5_p = NULL) => -0.0140223722, -0.0140223722), -0.0068784443), -0.0049173987);

// Tree: 372 
final_score_372 := map(
(NULL < s_addrchangeincomediff_d and s_addrchangeincomediff_d <= 3584.5) => 
   map(
   (NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 26.5) => 0.0830900296,
   (s_mos_liens_unrel_OT_lseen_d > 26.5) => 
      map(
      (NULL < pf_product_desc and pf_product_desc <= 3.5) => 0.0079625163,
      (pf_product_desc > 3.5) => 
         map(
         (NULL < pf_product_desc and pf_product_desc <= 4.5) => 0.1383696024,
         (pf_product_desc > 4.5) => -0.0108529032,
         (pf_product_desc = NULL) => 0.0284797341, 0.0284797341),
      (pf_product_desc = NULL) => 0.0100489721, 0.0100489721),
   (s_mos_liens_unrel_OT_lseen_d = NULL) => 0.0104758133, 0.0104758133),
(s_addrchangeincomediff_d > 3584.5) => -0.0257806670,
(s_addrchangeincomediff_d = NULL) => -0.0081015557, -0.0007018718);

// Tree: 373 
final_score_373 := map(
(NULL < b_divrisktype_i and b_divrisktype_i <= 2.5) => -0.0015804741,
(b_divrisktype_i > 2.5) => 
   map(
   (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 180.5) => -0.0249220204,
   ((real)ST_cen_span_lang > 180.5) => -0.0952694044,
   ((real)ST_cen_span_lang = NULL) => -0.0327548174, -0.0327548174),
(b_divrisktype_i = NULL) => 
   map(
   (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 186.5) => 
      map(
      (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 10.5) => -0.0074291998,
      (btst_distphone2addr2_i > 10.5) => 0.0582304954,
      (btst_distphone2addr2_i = NULL) => -0.0067712436, -0.0042251642),
   ((real)BT_cen_span_lang > 186.5) => 0.0539079458,
   ((real)BT_cen_span_lang = NULL) => -0.0501591221, -0.0273554311), -0.0075786859);

// Tree: 374 
final_score_374 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 43) => 
   map(
   (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 198.5) => 
      map(
      (NULL < b_E57_br_source_count_d and b_E57_br_source_count_d <= 0.5) => 0.0145157755,
      (b_E57_br_source_count_d > 0.5) => -0.0087743414,
      (b_E57_br_source_count_d = NULL) => 0.0061972801, 0.0003739074),
   ((real)ST_cen_very_rich > 198.5) => 0.0730516575,
   ((real)ST_cen_very_rich = NULL) => 
      map(
      (bf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','4: Recent Activity','5: Vuln Vic/Friendly']) => -0.0619077761,
      (bf_seg_FraudPoint_3_0 in ['2: Synth ID','3: Derog','6: Other']) => 0.1553318764,
      (bf_seg_FraudPoint_3_0 = '') => -0.0500077954, -0.0380027392), -0.0012503759),
(b_L79_adls_per_addr_c6_i > 43) => 0.0389964487,
(b_L79_adls_per_addr_c6_i = NULL) => -0.0010105201, -0.0010105201);

// Tree: 375 
final_score_375 := map(
(NULL < s_A50_pb_total_orders_d and s_A50_pb_total_orders_d <= 19.5) => -0.0091529439,
(s_A50_pb_total_orders_d > 19.5) => 
   map(
   (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 409.79) => 0.1829076133,
      (pf_order_amt_c > 409.79) => 0.0021363706,
      (pf_order_amt_c = NULL) => 0.0156007115, 0.0156007115),
   (s_inq_per_addr_i > 3.5) => 0.1646176822,
   (s_inq_per_addr_i = NULL) => 0.0327040024, 0.0327040024),
(s_A50_pb_total_orders_d = NULL) => 
   map(
   (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 908) => -0.0205853788,
   (b_P88_Phn_Dst_to_Inp_Add_i > 908) => -0.0745225555,
   (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 0.0145993583, -0.0017803956), -0.0056335451);

// Tree: 376 
final_score_376 := map(
(NULL < s_A50_pb_total_orders_d and s_A50_pb_total_orders_d <= 21.5) => -0.0057620529,
(s_A50_pb_total_orders_d > 21.5) => 
   map(
   (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 3.5) => 
      map(
      (NULL < (real)ST_cen_incollege and (real)ST_cen_incollege <= 4.05) => 
         map(
         (NULL < s_C10_M_Hdr_FS_d and s_C10_M_Hdr_FS_d <= 313.5) => 0.3272934831,
         (s_C10_M_Hdr_FS_d > 313.5) => -0.0512174746,
         (s_C10_M_Hdr_FS_d = NULL) => 0.0504720364, 0.0504720364),
      ((real)ST_cen_incollege > 4.05) => -0.0362678124,
      ((real)ST_cen_incollege = NULL) => -0.0081473131, -0.0081473131),
   (s_inq_per_addr_i > 3.5) => 0.1396892604,
   (s_inq_per_addr_i = NULL) => 0.0100734411, 0.0100734411),
(s_A50_pb_total_orders_d = NULL) => -0.0033789813, -0.0046156562);

// Tree: 377 
final_score_377 := map(
(NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => -0.0004359292,
(s_C14_addrs_15yr_i > 11.5) => 
   map(
   (NULL < (real)BT_cen_families and (real)BT_cen_families <= 370) => 0.1052507824,
   ((real)BT_cen_families > 370) => -0.0521890973,
   ((real)BT_cen_families = NULL) => 0.0132090065, 0.0132090065),
(s_C14_addrs_15yr_i = NULL) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.87633312) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 193.5) => 0.0038884272,
      ((real)ST_cen_span_lang > 193.5) => -0.0399075718,
      ((real)ST_cen_span_lang = NULL) => -0.0500239119, -0.0092916978),
   (s_add_input_nhood_BUS_pct_i > 0.87633312) => 0.0542958200,
   (s_add_input_nhood_BUS_pct_i = NULL) => -0.0077914105, -0.0077914105), -0.0017129847);

// Tree: 378 
final_score_378 := map(
(NULL < b_I60_inq_auto_recency_d and b_I60_inq_auto_recency_d <= 4.5) => 
   map(
   (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 13.5) => 0.2382643648,
   ((real)BT_cen_no_move > 13.5) => 0.0007299954,
   ((real)BT_cen_no_move = NULL) => 0.0436181454, 0.0436181454),
(b_I60_inq_auto_recency_d > 4.5) => -0.0007995634,
(b_I60_inq_auto_recency_d = NULL) => 
   map(
   (NULL < s_bus_name_nover_i and s_bus_name_nover_i <= 0.5) => 
      map(
      (NULL < (real)BT_cen_health and (real)BT_cen_health <= 14.65) => 0.0081399982,
      ((real)BT_cen_health > 14.65) => 0.0712387553,
      ((real)BT_cen_health = NULL) => 0.1613919062, 0.0740643298),
   (s_bus_name_nover_i > 0.5) => -0.0196132392,
   (s_bus_name_nover_i = NULL) => -0.0038691100, -0.0038691100), -0.0006132888);

// Tree: 379 
final_score_379 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 45.5) => 
   map(
   (NULL < s_E57_br_source_count_d and s_E57_br_source_count_d <= 11.5) => -0.0002478569,
   (s_E57_br_source_count_d > 11.5) => 0.1123193799,
   (s_E57_br_source_count_d = NULL) => 
      map(
      (NULL < (real)BT_cen_retired2 and (real)BT_cen_retired2 <= 183.5) => 
         map(
         (NULL < b_C13_max_lres_d and b_C13_max_lres_d <= 279.5) => -0.0272266046,
         (b_C13_max_lres_d > 279.5) => 0.0809813410,
         (b_C13_max_lres_d = NULL) => -0.0052734073, -0.0090073457),
      ((real)BT_cen_retired2 > 183.5) => 0.1397863281,
      ((real)BT_cen_retired2 = NULL) => -0.0510140976, -0.0222813295), -0.0039518025),
(s_L79_adls_per_addr_c6_i > 45.5) => 0.0431035372,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0036685090, -0.0036685090);

// Tree: 380 
final_score_380 := map(
(NULL < s_P88_Phn_Dst_to_Inp_Add_i and s_P88_Phn_Dst_to_Inp_Add_i <= 247) => 0.0043025698,
(s_P88_Phn_Dst_to_Inp_Add_i > 247) => -0.0358238029,
(s_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
   map(
   (NULL < s_curraddrcrimeindex_i and s_curraddrcrimeindex_i <= 157.5) => -0.0040655200,
   (s_curraddrcrimeindex_i > 157.5) => 
      map(
      (NULL < b_srchunvrfdphonecount_i and b_srchunvrfdphonecount_i <= 0.5) => 
         map(
         (NULL < (real)BT_cen_incollege and (real)BT_cen_incollege <= 9.45) => -0.0329970161,
         ((real)BT_cen_incollege > 9.45) => 0.1382353610,
         ((real)BT_cen_incollege = NULL) => 0.0043011254, 0.0043011254),
      (b_srchunvrfdphonecount_i > 0.5) => 0.1606638978,
      (b_srchunvrfdphonecount_i = NULL) => 0.0287865046, 0.0287865046),
   (s_curraddrcrimeindex_i = NULL) => 0.0162546681, 0.0047228571), 0.0021646384);

// Tree: 381 
final_score_381 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 44) => 
   map(
   (NULL < b_C10_M_Hdr_FS_d and b_C10_M_Hdr_FS_d <= 623) => 
      map(
      (pf_ship_method in ['2nd Day','Ground']) => -0.0070093257,
      (pf_ship_method in ['3rd Day','Next Day','Other']) => 
         map(
         (NULL < s_C18_invalid_addrs_per_adl_i and s_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0705690558,
         (s_C18_invalid_addrs_per_adl_i > 0.5) => -0.0164515146,
         (s_C18_invalid_addrs_per_adl_i = NULL) => 0.0147776587, 0.0107152779),
      (pf_ship_method = '') => -0.0047490322, -0.0047490322),
   (b_C10_M_Hdr_FS_d > 623) => 0.0997177199,
   (b_C10_M_Hdr_FS_d = NULL) => -0.0017066757, -0.0038243208),
(b_L79_adls_per_addr_c6_i > 44) => 0.0357292195,
(b_L79_adls_per_addr_c6_i = NULL) => -0.0035958127, -0.0035958127);

// Tree: 382 
final_score_382 := map(
(pf_avs_result in ['International','No Match','Unavailable']) => 
   map(
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 0.2509444287) => -0.0068701916,
      (s_add_input_mobility_index_i > 0.2509444287) => -0.0573121951,
      (s_add_input_mobility_index_i = NULL) => -0.0359551351, -0.0359551351),
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.7588508278) => -0.0191737460,
      (s_add_input_nhood_BUS_pct_i > 0.7588508278) => 0.0681873152,
      (s_add_input_nhood_BUS_pct_i = NULL) => -0.0522479311, -0.0176029527),
   (final_model_segment = '') => -0.0201688466, -0.0201688466),
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','Not Supported','Zip Only']) => 0.0070300370,
(pf_avs_result = '') => 0.0027593293, 0.0027593293);

// Tree: 383 
final_score_383 := map(
(NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 208110) => -0.0008123166,
(s_curraddrmedianincome_d > 208110) => 0.1830270230,
(s_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < btst_email_last_score_d and btst_email_last_score_d <= 1.5) => 
      map(
      (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.2259611182) => 
         map(
         (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 273471) => 0.1005782821,
         (b_L80_Inp_AVM_AutoVal_d > 273471) => 0.0401192584,
         (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0241225013, 0.0138612764),
      (b_add_input_mobility_index_i > 0.2259611182) => -0.0205965869,
      (b_add_input_mobility_index_i = NULL) => -0.0141004324, -0.0141004324),
   (btst_email_last_score_d > 1.5) => 0.0538922895,
   (btst_email_last_score_d = NULL) => -0.0500128727, -0.0261489967), -0.0051953826);

// Tree: 384 
final_score_384 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < s_estimated_income_d and s_estimated_income_d <= 38500) => 
      map(
      (NULL < s_curraddrmedianvalue_d and s_curraddrmedianvalue_d <= 761196.5) => 
         map(
         (bf_seg_FraudPoint_3_0 in ['1: Stolen/Manip ID','2: Synth ID','3: Derog','4: Recent Activity','5: Vuln Vic/Friendly']) => -0.0001739608,
         (bf_seg_FraudPoint_3_0 in ['6: Other']) => 0.0511985563,
         (bf_seg_FraudPoint_3_0 = '') => 0.0122530844, 0.0122530844),
      (s_curraddrmedianvalue_d > 761196.5) => 0.0899309713,
      (s_curraddrmedianvalue_d = NULL) => 0.0134303350, 0.0134303350),
   (s_estimated_income_d > 38500) => -0.0103441204,
   (s_estimated_income_d = NULL) => -0.0113935116, -0.0043512995),
(b_inq_lnames_per_addr_i > 8.5) => -0.0330571007,
(b_inq_lnames_per_addr_i = NULL) => -0.0500232306, -0.0092343942);

// Tree: 385 
final_score_385 := map(
(NULL < b_inq_Retail_count24_i and b_inq_Retail_count24_i <= 0.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 51.5) => 0.0046261980,
   (btst_distaddraddr2_i > 51.5) => 
      map(
      (NULL < b_F01_inp_addr_address_score_d and b_F01_inp_addr_address_score_d <= 75) => -0.0274593011,
      (b_F01_inp_addr_address_score_d > 75) => 
         map(
         (NULL < b_curraddrmurderindex_i and b_curraddrmurderindex_i <= 87) => 0.0805527639,
         (b_curraddrmurderindex_i > 87) => -0.0075013437,
         (b_curraddrmurderindex_i = NULL) => 0.0437074281, 0.0437074281),
      (b_F01_inp_addr_address_score_d = NULL) => 0.0110384111, 0.0122989986),
   (btst_distaddraddr2_i = NULL) => 0.0051815645, 0.0051815645),
(b_inq_Retail_count24_i > 0.5) => -0.0242138202,
(b_inq_Retail_count24_i = NULL) => -0.0033798647, -0.0062653965);

// Tree: 386 
final_score_386 := map(
(pf_pmt_type in ['Dell Credit Card','Gift Card','Other','Prepaid Check']) => -0.0562928663,
(pf_pmt_type in ['American Express','Credit Terms','Diners Club','Discover','Mastercard','Visa']) => 
   map(
   (NULL < btst_firstscore_d and btst_firstscore_d <= 26.5) => -0.0278848325,
   (btst_firstscore_d > 26.5) => 
      map(
      (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0093323527,
      (pf_product_desc > 2.5) => 
         map(
         (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 41.5) => 0.0113008359,
         (btst_distphone2addr2_i > 41.5) => 0.0440669399,
         (btst_distphone2addr2_i = NULL) => 0.0173171224, 0.0159460181),
      (pf_product_desc = NULL) => 0.0044575521, 0.0044575521),
   (btst_firstscore_d = NULL) => -0.0500242244, -0.0056450415),
(pf_pmt_type = '') => -0.0070957302, -0.0070957302);

// Tree: 387 
final_score_387 := map(
(NULL < pf_product_desc and pf_product_desc <= 6.5) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 3.5) => 0.0024283338,
   (pf_product_desc > 3.5) => 
      map(
      (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 85.5) => 
         map(
         (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 2.95) => -0.0152448483,
         ((real)ST_cen_unemp > 2.95) => 0.1495869117,
         ((real)ST_cen_unemp = NULL) => 0.1028435768, 0.1028435768),
      ((real)BT_cen_very_rich > 85.5) => -0.0001989057,
      ((real)BT_cen_very_rich = NULL) => -0.0511527092, 0.0259634026),
   (pf_product_desc = NULL) => 0.0034449248, 0.0034449248),
(pf_product_desc > 6.5) => -0.0534428806,
(pf_product_desc = NULL) => 0.0001376552, 0.0001376552);

// Tree: 388 
final_score_388 := map(
(NULL < b_rel_incomeover25_count_d and b_rel_incomeover25_count_d <= 24.5) => 
   map(
   (NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 3.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0007538260,
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0454817058,
      (final_model_segment = '') => 0.0009820294, 0.0009820294),
   (s_inq_adls_per_addr_i > 3.5) => -0.0439681626,
   (s_inq_adls_per_addr_i = NULL) => 0.0003972808, 0.0003972808),
(b_rel_incomeover25_count_d > 24.5) => 
   map(
   (final_model_segment in ['CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => -0.0819557382,
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0409345658,
   (final_model_segment = '') => -0.0453204773, -0.0453204773),
(b_rel_incomeover25_count_d = NULL) => -0.0008608371, -0.0012362930);

// Tree: 389 
final_score_389 := map(
(NULL < s_util_add_input_inf_n and s_util_add_input_inf_n <= 0.5) => 
   map(
   (NULL < (real)ST_cen_vacant_p and (real)ST_cen_vacant_p <= 3.55) => -0.0324031751,
   ((real)ST_cen_vacant_p > 3.55) => 0.0052790080,
   ((real)ST_cen_vacant_p = NULL) => 0.0059353032, -0.0012688065),
(s_util_add_input_inf_n > 0.5) => 
   map(
   (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.35630592055) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 509.99) => 0.0970915539,
      (pf_order_amt_c > 509.99) => -0.0346693645,
      (pf_order_amt_c = NULL) => -0.0022970699, -0.0022970699),
   (b_add_input_mobility_index_i > 0.35630592055) => 0.0824296023,
   (b_add_input_mobility_index_i = NULL) => 0.0129716944, 0.0129716944),
(s_util_add_input_inf_n = NULL) => -0.0500045423, -0.0031419364);

// Tree: 390 
final_score_390 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 63) => 
   map(
   (NULL < b_hh_members_ct_d and b_hh_members_ct_d <= 14.5) => 0.0009750987,
   (b_hh_members_ct_d > 14.5) => 0.0986132326,
   (b_hh_members_ct_d = NULL) => 
      map(
      (NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 4.5) => 
         map(
         (NULL < b_inq_ssns_per_addr_i and b_inq_ssns_per_addr_i <= 0.5) => 0.0048041227,
         (b_inq_ssns_per_addr_i > 0.5) => 0.0619145817,
         (b_inq_ssns_per_addr_i = NULL) => -0.0500144877, 0.0012858204),
      (pf_pmt_x_avs_lvl > 4.5) => -0.0008382355,
      (pf_pmt_x_avs_lvl = NULL) => -0.0006334830, -0.0006334830), 0.0009683696),
(s_L79_adls_per_addr_c6_i > 63) => -0.0615963232,
(s_L79_adls_per_addr_c6_i = NULL) => 0.0006031172, 0.0006031172);

// Tree: 391 
final_score_391 := map(
(NULL < b_hh_bankruptcies_i and b_hh_bankruptcies_i <= 0.5) => 0.0070955062,
(b_hh_bankruptcies_i > 0.5) => -0.0351445716,
(b_hh_bankruptcies_i = NULL) => 
   map(
   (NULL < (real)BT_cen_urban_p and (real)BT_cen_urban_p <= 15.35) => 0.0769962827,
   ((real)BT_cen_urban_p > 15.35) => 
      map(
      (NULL < b_add_input_nhood_VAC_pct_i and b_add_input_nhood_VAC_pct_i <= 0.02682774105) => -0.0353068987,
      (b_add_input_nhood_VAC_pct_i > 0.02682774105) => 
         map(
         (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 191926) => 0.0085692271,
         (b_L80_Inp_AVM_AutoVal_d > 191926) => 0.0976075805,
         (b_L80_Inp_AVM_AutoVal_d = NULL) => 0.0213715467, 0.0253054957),
      (b_add_input_nhood_VAC_pct_i = NULL) => 0.0034647167, 0.0034647167),
   ((real)BT_cen_urban_p = NULL) => -0.0505857357, -0.0239309422), -0.0027506311);

// Tree: 392 
final_score_392 := map(
(NULL < s_add_curr_nhood_VAC_pct_i and s_add_curr_nhood_VAC_pct_i <= 5.02040086205) => -0.0052833039,
(s_add_curr_nhood_VAC_pct_i > 5.02040086205) => 0.1325413293,
(s_add_curr_nhood_VAC_pct_i = NULL) => 
   map(
   (NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.85885048535) => 0.0020186422,
   (b_add_input_nhood_MFD_pct_i > 0.85885048535) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.0252517955) => 0.0336601661,
      (b_add_input_nhood_BUS_pct_i > 0.0252517955) => 0.1215184225,
      (b_add_input_nhood_BUS_pct_i = NULL) => 0.0692218413, 0.0692218413),
   (b_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < (real)BT_cen_retired2 and (real)BT_cen_retired2 <= 59.5) => -0.0564575603,
      ((real)BT_cen_retired2 > 59.5) => 0.0695183573,
      ((real)BT_cen_retired2 = NULL) => -0.0513618053, -0.0001764159), 0.0051434087), -0.0032369204);

// Tree: 393 
final_score_393 := map(
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 48.5) => 
      map(
      (NULL < s_phone_ver_experian_d and s_phone_ver_experian_d <= 0.5) => 0.0288777277,
      (s_phone_ver_experian_d > 0.5) => -0.0516409796,
      (s_phone_ver_experian_d = NULL) => -0.0178095899, -0.0178095899),
   ((real)ST_cen_easiqlife > 48.5) => 
      map(
      (NULL < s_A49_Curr_AVM_Chg_1yr_i and s_A49_Curr_AVM_Chg_1yr_i <= -259157) => 0.1450041955,
      (s_A49_Curr_AVM_Chg_1yr_i > -259157) => -0.0097061097,
      (s_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0023401618, -0.0051790686),
   ((real)ST_cen_easiqlife = NULL) => -0.0611972422, -0.0079071922),
(pf_avs_result in ['International','Not Supported']) => 0.0489478733,
(pf_avs_result = '') => -0.0077343174, -0.0077343174);

// Tree: 394 
final_score_394 := map(
(final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => 
   map(
   (pf_ship_method in ['Next Day']) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.09817135745) => -0.0495977764,
      (b_add_input_nhood_BUS_pct_i > 0.09817135745) => 0.0099371486,
      (b_add_input_nhood_BUS_pct_i = NULL) => -0.0255211523, -0.0255211523),
   (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 
      map(
      (NULL < (real)ST_cen_incollege and (real)ST_cen_incollege <= 26.2) => -0.0198254548,
      ((real)ST_cen_incollege > 26.2) => 0.0774384667,
      ((real)ST_cen_incollege = NULL) => -0.0148798317, -0.0148798317),
   (pf_ship_method = '') => -0.0158661682, -0.0158661682),
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0002492164,
(final_model_segment = '') => -0.0017041647, -0.0017041647);

// Tree: 395 
final_score_395 := map(
(NULL < s_util_adl_count_n and s_util_adl_count_n <= 18.5) => -0.0039376598,
(s_util_adl_count_n > 18.5) => 0.1047730508,
(s_util_adl_count_n = NULL) => 
   map(
   (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 194227.5) => 
      map(
      (NULL < b_nap_phn_verd_d and b_nap_phn_verd_d <= 0.5) => 0.0838488728,
      (b_nap_phn_verd_d > 0.5) => -0.0262640398,
      (b_nap_phn_verd_d = NULL) => 0.0252566808, 0.0252566808),
   (s_L80_Inp_AVM_AutoVal_d > 194227.5) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 1749.52) => -0.0389971735,
      (pf_order_amt_c > 1749.52) => 0.1532507177,
      (pf_order_amt_c = NULL) => 0.0146760956, 0.0146760956),
   (s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0008179350, 0.0010503557), -0.0024914313);

// Tree: 396 
final_score_396 := map(
(NULL < b_rel_incomeover25_count_d and b_rel_incomeover25_count_d <= 24.5) => 0.0051844486,
(b_rel_incomeover25_count_d > 24.5) => -0.0545768598,
(b_rel_incomeover25_count_d = NULL) => 
   map(
   (NULL < (real)BT_cen_families and (real)BT_cen_families <= 430.5) => -0.0280696181,
   ((real)BT_cen_families > 430.5) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 17.55) => 
         map(
         (pf_avs_result in ['Addr Only','Error/Inval','Full Match','Unavailable','Zip Only']) => -0.0288549427,
         (pf_avs_result in ['International','No Match','Not Supported']) => 0.0444818954,
         (pf_avs_result = '') => -0.0209027555, -0.0209027555),
      ((real)ST_cen_blue_col > 17.55) => 0.1372256757,
      ((real)ST_cen_blue_col = NULL) => -0.0070013549, -0.0070013549),
   ((real)BT_cen_families = NULL) => -0.0502248693, -0.0337508969), -0.0059571576);

// Tree: 397 
final_score_397 := map(
(NULL < s_C18_Inv_Add_Per_ADL_c6_i and s_C18_Inv_Add_Per_ADL_c6_i <= 0.5) => 
   map(
   (NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 0.0004936794,
   (s_P85_Phn_Invalid_i > 0.5) => 
      map(
      (NULL < b_rel_ageover40_count_d and b_rel_ageover40_count_d <= 3.5) => -0.0582942775,
      (b_rel_ageover40_count_d > 3.5) => 0.0070105583,
      (b_rel_ageover40_count_d = NULL) => -0.0227264651, -0.0227264651),
   (s_P85_Phn_Invalid_i = NULL) => -0.0505816983, -0.0002681800),
(s_C18_Inv_Add_Per_ADL_c6_i > 0.5) => -0.0706217256,
(s_C18_Inv_Add_Per_ADL_c6_i = NULL) => 
   map(
   (btst_email_topleveldomain_n in ['EDU','OTH']) => -0.0659506536,
   (btst_email_topleveldomain_n in ['BIZ','COM','GOV','MIL','NET','ORG','US']) => -0.0028025023,
   (btst_email_topleveldomain_n = '') => -0.0028601383, -0.0039403749), -0.0019103020);

// Tree: 398 
final_score_398 := map(
(pf_avs_result in ['International','Not Supported']) => -0.0300352714,
(pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
   map(
   (NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => 0.0000416839,
   (s_C14_addrs_15yr_i > 11.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB']) => -0.0486077637,
      (final_model_segment in ['BUS  ADDR-         OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0896471395,
      (final_model_segment = '') => 0.0015806600, 0.0015806600),
   (s_C14_addrs_15yr_i = NULL) => 
      map(
      (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.19465864945) => 0.0596558690,
      (b_add_input_mobility_index_i > 0.19465864945) => -0.0160070866,
      (b_add_input_mobility_index_i = NULL) => -0.0086671842, -0.0086671842), -0.0016546031),
(pf_avs_result = '') => -0.0017495275, -0.0017495275);

// Tree: 399 
final_score_399 := map(
(NULL < b_util_add_input_inf_n and b_util_add_input_inf_n <= 0.5) => 
   map(
   (NULL < btst_distphoneaddr_i and btst_distphoneaddr_i <= 145.5) => -0.0027541646,
   (btst_distphoneaddr_i > 145.5) => 0.0515628745,
   (btst_distphoneaddr_i = NULL) => 
      map(
      (NULL < s_E57_br_source_count_d and s_E57_br_source_count_d <= 7.5) => 0.0001855298,
      (s_E57_br_source_count_d > 7.5) => 0.0843671883,
      (s_E57_br_source_count_d = NULL) => 0.0040446008, 0.0023643239), 0.0006916496),
(b_util_add_input_inf_n > 0.5) => 
   map(
   (NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 0.35630592055) => -0.0035477855,
   (s_add_input_mobility_index_i > 0.35630592055) => 0.0836253439,
   (s_add_input_mobility_index_i = NULL) => 0.0161276543, 0.0161276543),
(b_util_add_input_inf_n = NULL) => -0.0500179854, -0.0043711901);

// Tree: 400 
final_score_400 := map(
(NULL < b_prevaddrmurderindex_i and b_prevaddrmurderindex_i <= 195.5) => -0.0033625277,
(b_prevaddrmurderindex_i > 195.5) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.1603938578) => 0.0149576119,
   (s_add_input_nhood_BUS_pct_i > 0.1603938578) => 0.1906543794,
   (s_add_input_nhood_BUS_pct_i = NULL) => 0.0716339885, 0.0716339885),
(b_prevaddrmurderindex_i = NULL) => 
   map(
   (NULL < (real)BT_cen_pop_0_5_p and (real)BT_cen_pop_0_5_p <= 6.35) => 
      map(
      (NULL < b_bus_name_nover_i and b_bus_name_nover_i <= 0.5) => 0.0627606783,
      (b_bus_name_nover_i > 0.5) => -0.0113012523,
      (b_bus_name_nover_i = NULL) => 0.0066272842, 0.0066272842),
   ((real)BT_cen_pop_0_5_p > 6.35) => -0.0223741941,
   ((real)BT_cen_pop_0_5_p = NULL) => 0.1117253970, 0.0546257220), 0.0087357157);

// Tree: 401 
final_score_401 := map(
(NULL < s_srchaddrsrchcountmo_i and s_srchaddrsrchcountmo_i <= 1.5) => 0.0022339173,
(s_srchaddrsrchcountmo_i > 1.5) => 
   map(
   (final_model_segment in ['BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0002850675,
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH']) => 0.0718324226,
   (final_model_segment = '') => 0.0167294193, 0.0167294193),
(s_srchaddrsrchcountmo_i = NULL) => 
   map(
   (NULL < (real)BT_cen_families and (real)BT_cen_families <= 425.5) => -0.0206358087,
   ((real)BT_cen_families > 425.5) => 
      map(
      (NULL < (real)ST_cen_med_hhinc and (real)ST_cen_med_hhinc <= 75790.5) => 0.0605936977,
      ((real)ST_cen_med_hhinc > 75790.5) => -0.0263895905,
      ((real)ST_cen_med_hhinc = NULL) => 0.0239075920, 0.0239075920),
   ((real)BT_cen_families = NULL) => -0.0512170130, -0.0199698463), -0.0018642673);

// Tree: 402 
final_score_402 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 16.5) => 
   map(
   (NULL < b_prevaddrmedianvalue_d and b_prevaddrmedianvalue_d <= 296963.5) => 
      map(
      (NULL < s_rel_homeover500_count_d and s_rel_homeover500_count_d <= 7.5) => 0.0075612924,
      (s_rel_homeover500_count_d > 7.5) => 0.0895787760,
      (s_rel_homeover500_count_d = NULL) => 0.0026232435, 0.0086682860),
   (b_prevaddrmedianvalue_d > 296963.5) => -0.0195273052,
   (b_prevaddrmedianvalue_d = NULL) => 0.0039683391, -0.0010005490),
(s_L79_adls_per_addr_c6_i > 16.5) => 
   map(
   (pf_pmt_type in ['American Express','Credit Terms','Discover','Gift Card','Other']) => -0.0361379195,
   (pf_pmt_type in ['Dell Credit Card','Diners Club','Mastercard','Prepaid Check','Visa']) => 0.0761623199,
   (pf_pmt_type = '') => 0.0048113391, 0.0048113391),
(s_L79_adls_per_addr_c6_i = NULL) => -0.0009365773, -0.0009365773);

// Tree: 403 
final_score_403 := map(
(NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 129578) => -0.0325354571,
(b_L80_Inp_AVM_AutoVal_d > 129578) => 
   map(
   (NULL < (real)ST_cen_incollege and (real)ST_cen_incollege <= 5.35) => 0.0403562105,
   ((real)ST_cen_incollege > 5.35) => 
      map(
      (NULL < (real)BT_cen_easiqlife and (real)BT_cen_easiqlife <= 63.5) => 
         map(
         (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.0203106159) => 0.0279250097,
         (b_add_input_nhood_BUS_pct_i > 0.0203106159) => 0.0946551789,
         (b_add_input_nhood_BUS_pct_i = NULL) => 0.0711240140, 0.0711240140),
      ((real)BT_cen_easiqlife > 63.5) => -0.0175934164,
      ((real)BT_cen_easiqlife = NULL) => -0.0113505703, -0.0113505703),
   ((real)ST_cen_incollege = NULL) => 0.0095571871, 0.0095571871),
(b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0105650834, -0.0058049702);

// Tree: 404 
final_score_404 := map(
(NULL < s_add_input_nhood_SFD_pct_d and s_add_input_nhood_SFD_pct_d <= 0.0702134782) => 
   map(
   (pf_avs_result in ['International','No Match','Not Supported']) => 
      map(
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0589128324,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB']) => -0.0544124830,
      (final_model_segment = '') => -0.0561472545, -0.0561472545),
   (pf_avs_result in ['Addr Only','Error/Inval','Full Match','Unavailable','Zip Only']) => 
      map(
      (NULL < b_divsrchaddrsuspidcount_i and b_divsrchaddrsuspidcount_i <= 0.5) => -0.0321131014,
      (b_divsrchaddrsuspidcount_i > 0.5) => 0.1173901506,
      (b_divsrchaddrsuspidcount_i = NULL) => -0.0596398262, -0.0372310085),
   (pf_avs_result = '') => -0.0386063164, -0.0386063164),
(s_add_input_nhood_SFD_pct_d > 0.0702134782) => 0.0060894158,
(s_add_input_nhood_SFD_pct_d = NULL) => -0.0006024410, -0.0006024410);

// Tree: 405 
final_score_405 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 43.5) => 
   map(
   (pf_avs_result in ['International','Not Supported']) => -0.0477290438,
   (pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match','Unavailable','Zip Only']) => 
      map(
      (final_model_segment in ['CONS ADDR- LNAME   OTH']) => -0.0362376752,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
         map(
         (NULL < s_rel_ageover40_count_d and s_rel_ageover40_count_d <= 0.5) => 0.0283993182,
         (s_rel_ageover40_count_d > 0.5) => -0.0104232648,
         (s_rel_ageover40_count_d = NULL) => -0.0021703841, -0.0029054169),
      (final_model_segment = '') => -0.0030670055, -0.0030670055),
   (pf_avs_result = '') => -0.0032063439, -0.0032063439),
(b_L79_adls_per_addr_c6_i > 43.5) => 0.0480574929,
(b_L79_adls_per_addr_c6_i = NULL) => -0.0029039483, -0.0029039483);

// Tree: 406 
final_score_406 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < s_A41_Prop_Owner_d and s_A41_Prop_Owner_d <= 0.5) => 
      map(
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
         map(
         (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 171.5) => -0.0301856999,
         ((real)ST_cen_span_lang > 171.5) => -0.0703847499,
         ((real)ST_cen_span_lang = NULL) => -0.0345399491, -0.0345399491),
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => -0.0143407874,
      (final_model_segment = '') => -0.0184193897, -0.0184193897),
   (s_A41_Prop_Owner_d > 0.5) => 0.0077956138,
   (s_A41_Prop_Owner_d = NULL) => -0.0001664229, 0.0021009564),
(final_model_segment in ['CONS ADDR- LNAME   OTH']) => 0.0441933792,
(final_model_segment = '') => 0.0023057359, 0.0023057359);

// Tree: 407 
final_score_407 := map(
(NULL < s_rel_homeover500_count_d and s_rel_homeover500_count_d <= 4.5) => -0.0070423999,
(s_rel_homeover500_count_d > 4.5) => 
   map(
   (NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.3317277916) => 
      map(
      (NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 29.65) => 0.1213656900,
      ((real)BT_cen_ownocc_p > 29.65) => -0.0068159842,
      ((real)BT_cen_ownocc_p = NULL) => 0.0019807974, 0.0019807974),
   (b_add_input_mobility_index_i > 0.3317277916) => 
      map(
      (NULL < b_prevaddrmedianincome_d and b_prevaddrmedianincome_d <= 48037) => 0.1802448224,
      (b_prevaddrmedianincome_d > 48037) => 0.0285918805,
      (b_prevaddrmedianincome_d = NULL) => -0.0519417426, 0.0423918045),
   (b_add_input_mobility_index_i = NULL) => 0.0147213433, 0.0147213433),
(s_rel_homeover500_count_d = NULL) => 0.0020265825, -0.0028818893);

// Tree: 408 
final_score_408 := map(
(NULL < s_mos_liens_unrel_SC_fseen_d and s_mos_liens_unrel_SC_fseen_d <= 193) => 
   map(
   (NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 46259) => 0.1567860089,
   (s_curraddrmedianincome_d > 46259) => -0.0109603180,
   (s_curraddrmedianincome_d = NULL) => 0.0204528518, 0.0204528518),
(s_mos_liens_unrel_SC_fseen_d > 193) => -0.0030963661,
(s_mos_liens_unrel_SC_fseen_d = NULL) => 
   map(
   (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 194227.5) => 
      map(
      (pf_pmt_type in ['Credit Terms','Diners Club','Discover','Prepaid Check','Visa']) => -0.0042913694,
      (pf_pmt_type in ['American Express','Dell Credit Card','Gift Card','Mastercard','Other']) => 0.1030742746,
      (pf_pmt_type = '') => 0.0475716959, 0.0475716959),
   (s_L80_Inp_AVM_AutoVal_d > 194227.5) => -0.0044467240,
   (s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0058568984, -0.0037774676), -0.0028455888);

// Tree: 409 
final_score_409 := map(
(NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 0.46892371765) => 
   map(
   (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
      map(
      (NULL < b_comb_age_d and b_comb_age_d <= 20.5) => 0.0969584238,
      (b_comb_age_d > 20.5) => 
         map(
         (NULL < s_pb_order_freq_d and s_pb_order_freq_d <= 133.5) => 0.0607771181,
         (s_pb_order_freq_d > 133.5) => -0.0320141294,
         (s_pb_order_freq_d = NULL) => -0.0117846782, 0.0160139916),
      (b_comb_age_d = NULL) => 0.0036737516, 0.0160415157),
   (s_C20_email_verification_d > 0.5) => -0.0039606058,
   (s_C20_email_verification_d = NULL) => -0.0032580486, 0.0001059855),
(s_add_input_mobility_index_i > 0.46892371765) => -0.0246809596,
(s_add_input_mobility_index_i = NULL) => 0.0598243488, -0.0039095790);

// Tree: 410 
final_score_410 := map(
(NULL < b_inq_HighRiskCredit_count24_i and b_inq_HighRiskCredit_count24_i <= 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0005846806,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0400736347,
   (final_model_segment = '') => 0.0007942758, 0.0007942758),
(b_inq_HighRiskCredit_count24_i > 0.5) => -0.0586058015,
(b_inq_HighRiskCredit_count24_i = NULL) => 
   map(
   (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 186.5) => 
      map(
      (NULL < (real)ST_cen_totcrime and (real)ST_cen_totcrime <= 70) => -0.0425880058,
      ((real)ST_cen_totcrime > 70) => 0.0084921800,
      ((real)ST_cen_totcrime = NULL) => -0.0143270223, -0.0143270223),
   ((real)BT_cen_very_rich > 186.5) => 0.0708276808,
   ((real)BT_cen_very_rich = NULL) => 0.1041324884, 0.0515114816), 0.0100168217);

// Tree: 411 
final_score_411 := map(
(NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 71.65) => -0.0095601195,
((real)BT_cen_ownocc_p > 71.65) => 
   map(
   (NULL < s_addrchangeincomediff_d and s_addrchangeincomediff_d <= -29839) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB']) => -0.0277827746,
      (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.1534740985,
      (final_model_segment = '') => 0.0497856689, 0.0497856689),
   (s_addrchangeincomediff_d > -29839) => 0.0032734210,
   (s_addrchangeincomediff_d = NULL) => 
      map(
      (NULL < s_nap_contradictory_i and s_nap_contradictory_i <= 0.5) => 0.0029780958,
      (s_nap_contradictory_i > 0.5) => 0.1118506461,
      (s_nap_contradictory_i = NULL) => 0.0084837589, 0.0084837589), 0.0064601218),
((real)BT_cen_ownocc_p = NULL) => 0.0378831894, 0.0013278097);

// Tree: 412 
final_score_412 := map(
(NULL < b_I60_inq_retail_recency_d and b_I60_inq_retail_recency_d <= 61.5) => -0.0209052682,
(b_I60_inq_retail_recency_d > 61.5) => 
   map(
   (NULL < b_P85_Phn_Invalid_i and b_P85_Phn_Invalid_i <= 0.5) => 
      map(
      (NULL < s_inf_contradictory_i and s_inf_contradictory_i <= 0.5) => -0.0009876166,
      (s_inf_contradictory_i > 0.5) => 
         map(
         (NULL < b_M_Bureau_ADL_FS_all_d and b_M_Bureau_ADL_FS_all_d <= 179.5) => 0.0909220747,
         (b_M_Bureau_ADL_FS_all_d > 179.5) => 0.0104015055,
         (b_M_Bureau_ADL_FS_all_d = NULL) => 0.0275511028, 0.0275511028),
      (s_inf_contradictory_i = NULL) => 0.0057544783, 0.0057544783),
   (b_P85_Phn_Invalid_i > 0.5) => 0.0407672254,
   (b_P85_Phn_Invalid_i = NULL) => 0.0698655930, 0.0077432534),
(b_I60_inq_retail_recency_d = NULL) => -0.0028744809, -0.0038983067);

// Tree: 413 
final_score_413 := map(
(NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 72) => -0.0012207259,
(b_phones_per_addr_curr_i > 72) => 0.0647033842,
(b_phones_per_addr_curr_i = NULL) => 
   map(
   (NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.0053228034) => -0.0562958383,
   (b_add_input_nhood_MFD_pct_i > 0.0053228034) => 
      map(
      (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 135) => -0.0184779794,
      ((real)ST_cen_very_rich > 135) => 0.0401402437,
      ((real)ST_cen_very_rich = NULL) => 0.0040395035, 0.0040395035),
   (b_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (pf_avs_result in ['Error/Inval','Full Match','International']) => -0.0296093827,
      (pf_avs_result in ['Addr Only','No Match','Not Supported','Unavailable','Zip Only']) => 0.0954572116,
      (pf_avs_result = '') => 0.0047353297, 0.0047353297), 0.0000879549), -0.0007581069);

// Tree: 414 
final_score_414 := map(
(NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 144.5) => -0.0037705213,
((real)ST_cen_no_move > 144.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0154083571) => 
         map(
         (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.01142791875) => -0.0167763839,
         (b_add_curr_nhood_BUS_pct_i > 0.01142791875) => 0.2196394331,
         (b_add_curr_nhood_BUS_pct_i = NULL) => 0.0526791104, 0.0526791104),
      (s_add_input_nhood_BUS_pct_i > 0.0154083571) => 0.0131971181,
      (s_add_input_nhood_BUS_pct_i = NULL) => -0.0508284637, 0.0137732448),
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB']) => 0.0623567585,
   (final_model_segment = '') => 0.0152698933, 0.0152698933),
((real)ST_cen_no_move = NULL) => -0.0083867774, -0.0010734197);

// Tree: 415 
final_score_415 := map(
(NULL < b_mos_liens_unrel_ST_fseen_d and b_mos_liens_unrel_ST_fseen_d <= 62.5) => 0.0681869209,
(b_mos_liens_unrel_ST_fseen_d > 62.5) => 
   map(
   (NULL < (real)ST_cen_mil_emp and (real)ST_cen_mil_emp <= 7.05) => 
      map(
      (NULL < s_inq_adls_per_addr_i and s_inq_adls_per_addr_i <= 2.5) => -0.0005670140,
      (s_inq_adls_per_addr_i > 2.5) => -0.0281464542,
      (s_inq_adls_per_addr_i = NULL) => -0.0016934499, -0.0016934499),
   ((real)ST_cen_mil_emp > 7.05) => 0.0880306409,
   ((real)ST_cen_mil_emp = NULL) => 
      map(
      (NULL < b_rel_incomeover100_count_d and b_rel_incomeover100_count_d <= 0.5) => -0.0523461500,
      (b_rel_incomeover100_count_d > 0.5) => 0.0961295976,
      (b_rel_incomeover100_count_d = NULL) => 0.0224856268, 0.0224856268), -0.0008797544),
(b_mos_liens_unrel_ST_fseen_d = NULL) => -0.0047841643, -0.0014288753);

// Tree: 416 
final_score_416 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 89.5) => 
   map(
   (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 198.5) => 
      map(
      (NULL < b_curraddrburglaryindex_i and b_curraddrburglaryindex_i <= 175.5) => 0.0022593101,
      (b_curraddrburglaryindex_i > 175.5) => -0.0428236063,
      (b_curraddrburglaryindex_i = NULL) => 
         map(
         (NULL < (real)BT_cen_health and (real)BT_cen_health <= 14.65) => 0.0013252917,
         ((real)BT_cen_health > 14.65) => 0.0431310765,
         ((real)BT_cen_health = NULL) => -0.0500294206, -0.0149069602), -0.0028542417),
   ((real)ST_cen_very_rich > 198.5) => 0.0785630979,
   ((real)ST_cen_very_rich = NULL) => -0.0547840361, -0.0052066676),
(b_L79_adls_per_addr_c6_i > 89.5) => -0.0651122437,
(b_L79_adls_per_addr_c6_i = NULL) => -0.0054726070, -0.0054726070);

// Tree: 417 
final_score_417 := map(
(NULL < b_mos_liens_unrel_ST_fseen_d and b_mos_liens_unrel_ST_fseen_d <= 62.5) => 0.0704070904,
(b_mos_liens_unrel_ST_fseen_d > 62.5) => -0.0037397303,
(b_mos_liens_unrel_ST_fseen_d = NULL) => 
   map(
   (NULL < (real)BT_cen_business and (real)BT_cen_business <= 83.5) => -0.0060292879,
   ((real)BT_cen_business > 83.5) => 
      map(
      (NULL < (real)BT_cen_low_hval and (real)BT_cen_low_hval <= 10.8) => 
         map(
         (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 6.45) => -0.0100005272,
         ((real)ST_cen_unemp > 6.45) => 0.1598563288,
         ((real)ST_cen_unemp = NULL) => 0.0166228045, 0.0166228045),
      ((real)BT_cen_low_hval > 10.8) => 0.1540513870,
      ((real)BT_cen_low_hval = NULL) => 0.0358332515, 0.0358332515),
   ((real)BT_cen_business = NULL) => -0.0505033740, -0.0248483597), -0.0076326495);

// Tree: 418 
final_score_418 := map(
(NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 193.5) => 
   map(
   (NULL < b_add_curr_nhood_SFD_pct_d and b_add_curr_nhood_SFD_pct_d <= 0.00280120835) => 
      map(
      (NULL < s_C18_invalid_addrs_per_adl_i and s_C18_invalid_addrs_per_adl_i <= 0.5) => 0.1180592251,
      (s_C18_invalid_addrs_per_adl_i > 0.5) => -0.0199436857,
      (s_C18_invalid_addrs_per_adl_i = NULL) => 0.0279185955, 0.0279185955),
   (b_add_curr_nhood_SFD_pct_d > 0.00280120835) => -0.0011043738,
   (b_add_curr_nhood_SFD_pct_d = NULL) => 0.0007572462, -0.0001939674),
((real)ST_cen_span_lang > 193.5) => 
   map(
   (pf_avs_result in ['International','Not Supported','Unavailable','Zip Only']) => -0.0653127523,
   (pf_avs_result in ['Addr Only','Error/Inval','Full Match','No Match']) => -0.0253658922,
   (pf_avs_result = '') => -0.0317377840, -0.0317377840),
((real)ST_cen_span_lang = NULL) => -0.0323863068, -0.0024461639);

// Tree: 419 
final_score_419 := map(
(NULL < (real)BT_cen_easiqlife and (real)BT_cen_easiqlife <= 140.5) => -0.0072558049,
((real)BT_cen_easiqlife > 140.5) => 
   map(
   (NULL < s_C10_M_Hdr_FS_d and s_C10_M_Hdr_FS_d <= 22.5) => 
      map(
      (NULL < b_divaddrsuspidcountnew_i and b_divaddrsuspidcountnew_i <= 0.5) => 0.1966327151,
      (b_divaddrsuspidcountnew_i > 0.5) => -0.0534751899,
      (b_divaddrsuspidcountnew_i = NULL) => 0.0755487294, 0.0755487294),
   (s_C10_M_Hdr_FS_d > 22.5) => 0.0116559012,
   (s_C10_M_Hdr_FS_d = NULL) => 
      map(
      (NULL < (real)BT_cen_easiqlife and (real)BT_cen_easiqlife <= 143.5) => 0.1395956672,
      ((real)BT_cen_easiqlife > 143.5) => -0.0038157991,
      ((real)BT_cen_easiqlife = NULL) => 0.0105514698, 0.0105514698), 0.0134669390),
((real)BT_cen_easiqlife = NULL) => 0.0430162244, 0.0037208231);

// Tree: 420 
final_score_420 := map(
(btst_email_topleveldomain_n in ['BIZ','COM','EDU','GOV','NET','ORG','US']) => 
   map(
   (NULL < s_curraddrcartheftindex_i and s_curraddrcartheftindex_i <= 116.5) => -0.0156161876,
   (s_curraddrcartheftindex_i > 116.5) => 0.0327476494,
   (s_curraddrcartheftindex_i = NULL) => -0.0050328090, -0.0034750044),
(btst_email_topleveldomain_n in ['MIL','OTH']) => 0.0565707786,
(btst_email_topleveldomain_n = '') => 
   map(
   (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 191.5) => -0.0057025645,
   ((real)BT_cen_very_rich > 191.5) => 
      map(
      (NULL < (real)ST_cen_urban_p and (real)ST_cen_urban_p <= 99.95) => 0.1198970993,
      ((real)ST_cen_urban_p > 99.95) => -0.0067528499,
      ((real)ST_cen_urban_p = NULL) => 0.0274768661, 0.0274768661),
   ((real)BT_cen_very_rich = NULL) => -0.0511456685, -0.0156592351), -0.0077342899);

// Tree: 421 
final_score_421 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 10.5) => 
   map(
   (NULL < (real)ST_cen_families and (real)ST_cen_families <= 2100) => 
      map(
      (NULL < b_srchaddrsrchcountmo_i and b_srchaddrsrchcountmo_i <= 0.5) => 0.0035602528,
      (b_srchaddrsrchcountmo_i > 0.5) => -0.0357119094,
      (b_srchaddrsrchcountmo_i = NULL) => 
         map(
         (NULL < s_M_Bureau_ADL_FS_noTU_d and s_M_Bureau_ADL_FS_noTU_d <= 137.5) => 0.1954484148,
         (s_M_Bureau_ADL_FS_noTU_d > 137.5) => -0.0010672550,
         (s_M_Bureau_ADL_FS_noTU_d = NULL) => 0.0074615439, 0.0112336609), 0.0021603683),
   ((real)ST_cen_families > 2100) => -0.0794852616,
   ((real)ST_cen_families = NULL) => 0.0356431159, 0.0020275512),
(b_inq_lnames_per_addr_i > 10.5) => 0.0343385923,
(b_inq_lnames_per_addr_i = NULL) => -0.0500276766, -0.0032613005);

// Tree: 422 
final_score_422 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 44) => 
   map(
   (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
      map(
      (NULL < s_curraddrcartheftindex_i and s_curraddrcartheftindex_i <= 115.5) => 0.0117057533,
      (s_curraddrcartheftindex_i > 115.5) => 
         map(
         (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 110.5) => 0.0955578739,
         ((real)ST_cen_very_rich > 110.5) => 0.0101154035,
         ((real)ST_cen_very_rich = NULL) => 0.0552183104, 0.0552183104),
      (s_curraddrcartheftindex_i = NULL) => -0.0033339480, 0.0166718009),
   (s_C20_email_verification_d > 0.5) => -0.0007527947,
   (s_C20_email_verification_d = NULL) => 0.0004060204, 0.0028782725),
(b_L79_adls_per_addr_c6_i > 44) => 0.0448141411,
(b_L79_adls_per_addr_c6_i = NULL) => 0.0031332948, 0.0031332948);

// Tree: 423 
final_score_423 := map(
(NULL < s_comb_age_d and s_comb_age_d <= 16.5) => 0.0884467619,
(s_comb_age_d > 16.5) => -0.0007062051,
(s_comb_age_d = NULL) => 
   map(
   (NULL < s_util_add_input_misc_n and s_util_add_input_misc_n <= 0.5) => -0.0076563227,
   (s_util_add_input_misc_n > 0.5) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 233000) => 0.0145580542,
      (b_L80_Inp_AVM_AutoVal_d > 233000) => 0.1033670778,
      (b_L80_Inp_AVM_AutoVal_d = NULL) => 
         map(
         (pf_avs_result in ['Error/Inval','Full Match','International','Not Supported','Zip Only']) => -0.0051289029,
         (pf_avs_result in ['Addr Only','No Match','Unavailable']) => 0.0627864951,
         (pf_avs_result = '') => 0.0029425366, 0.0029425366), 0.0160910399),
   (s_util_add_input_misc_n = NULL) => -0.0500036819, -0.0113225388), -0.0024549816);

// Tree: 424 
final_score_424 := map(
(NULL < s_validationrisktype_i and s_validationrisktype_i <= 2.5) => 0.0045094614,
(s_validationrisktype_i > 2.5) => 0.1184697773,
(s_validationrisktype_i = NULL) => 
   map(
   (NULL < b_hh_age_65_plus_d and b_hh_age_65_plus_d <= 1.5) => -0.0108368800,
   (b_hh_age_65_plus_d > 1.5) => 0.0835440654,
   (b_hh_age_65_plus_d = NULL) => 
      map(
      (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 28.5) => 0.0902477745,
      ((real)BT_cen_span_lang > 28.5) => 
         map(
         (NULL < (real)ST_cen_med_hval and (real)ST_cen_med_hval <= 216026.5) => -0.0320615940,
         ((real)ST_cen_med_hval > 216026.5) => 0.0185227425,
         ((real)ST_cen_med_hval = NULL) => 0.0010232963, 0.0010232963),
      ((real)BT_cen_span_lang = NULL) => -0.0509522944, -0.0221343728), -0.0168435609), 0.0008166975);

// Tree: 425 
final_score_425 := map(
(NULL < s_srchcomponentrisktype_i and s_srchcomponentrisktype_i <= 7.5) => -0.0015045755,
(s_srchcomponentrisktype_i > 7.5) => 0.0526857223,
(s_srchcomponentrisktype_i = NULL) => 
   map(
   (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.0110733654) => -0.0550261614,
   (b_add_input_nhood_BUS_pct_i > 0.0110733654) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 226065.5) => -0.0120756080,
      (b_L80_Inp_AVM_AutoVal_d > 226065.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0268537945,
         (final_model_segment in ['BUS  ADDR-         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 0.0935620963,
         (final_model_segment = '') => 0.0160260105, 0.0160260105),
      (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0115910501, -0.0097052248),
   (b_add_input_nhood_BUS_pct_i = NULL) => -0.0124467014, -0.0124467014), -0.0033332341);

// Tree: 426 
final_score_426 := map(
(NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.84160647075) => -0.0032766977,
(s_add_input_nhood_MFD_pct_i > 0.84160647075) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 157.5) => 
         map(
         (NULL < s_hh_collections_ct_i and s_hh_collections_ct_i <= 1.5) => -0.0314810861,
         (s_hh_collections_ct_i > 1.5) => 0.0690466257,
         (s_hh_collections_ct_i = NULL) => 0.0015055936, -0.0084086997),
      ((real)ST_cen_easiqlife > 157.5) => 0.0996555444,
      ((real)ST_cen_easiqlife = NULL) => 0.0012713222, 0.0012713222),
   (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH']) => 0.0936045439,
   (final_model_segment = '') => 0.0092708230, 0.0092708230),
(s_add_input_nhood_MFD_pct_i = NULL) => -0.0066540497, -0.0032697048);

// Tree: 427 
final_score_427 := map(
(NULL < b_D31_bk_disposed_hist_count_i and b_D31_bk_disposed_hist_count_i <= 1.5) => 
   map(
   (NULL < b_P85_Phn_Not_Issued_i and b_P85_Phn_Not_Issued_i <= 0.5) => -0.0028422332,
   (b_P85_Phn_Not_Issued_i > 0.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => -0.0320640951,
      (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => 0.0740973226,
      (final_model_segment = '') => 0.0107429281, 0.0107429281),
   (b_P85_Phn_Not_Issued_i = NULL) => 0.0048724424, -0.0024785958),
(b_D31_bk_disposed_hist_count_i > 1.5) => 
   map(
   (NULL < b_phone_ver_insurance_d and b_phone_ver_insurance_d <= 3.5) => -0.0125274148,
   (b_phone_ver_insurance_d > 3.5) => 0.1000698823,
   (b_phone_ver_insurance_d = NULL) => 0.0350746945, 0.0350746945),
(b_D31_bk_disposed_hist_count_i = NULL) => -0.0029998062, -0.0022965883);

// Tree: 428 
final_score_428 := map(
(NULL < b_comb_age_d and b_comb_age_d <= 19.5) => 
   map(
   (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 114.5) => -0.0164601760,
   ((real)BT_cen_lar_fam > 114.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB']) => -0.0717328463,
      (final_model_segment in ['BUS  ADDR-         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.1309409895,
      (final_model_segment = '') => 0.0353712133, 0.0353712133),
   ((real)BT_cen_lar_fam = NULL) => 0.0013478153, 0.0013478153),
(b_comb_age_d > 19.5) => -0.0022724236,
(b_comb_age_d = NULL) => 
   map(
   (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 5.5) => 0.0756898344,
   ((real)BT_cen_no_move > 5.5) => -0.0046711361,
   ((real)BT_cen_no_move = NULL) => -0.0502298864, -0.0263617822), -0.0070108919);

// Tree: 429 
final_score_429 := map(
(NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 124.5) => -0.0063400036,
((real)BT_cen_lar_fam > 124.5) => 
   map(
   (NULL < (real)ST_cen_low_hval and (real)ST_cen_low_hval <= 0.55) => -0.0086361830,
   ((real)ST_cen_low_hval > 0.55) => 
      map(
      (NULL < s_addrchangecrimediff_i and s_addrchangecrimediff_i <= -35) => 
         map(
         (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.08056758215) => 0.2222106417,
         (s_add_input_nhood_BUS_pct_i > 0.08056758215) => -0.0537813711,
         (s_add_input_nhood_BUS_pct_i = NULL) => 0.0609166082, 0.0609166082),
      (s_addrchangecrimediff_i > -35) => 0.0203092262,
      (s_addrchangecrimediff_i = NULL) => 0.0281522292, 0.0255754713),
   ((real)ST_cen_low_hval = NULL) => 0.0107891584, 0.0107891584),
((real)BT_cen_lar_fam = NULL) => 0.0107294410, -0.0006103560);

// Tree: 430 
final_score_430 := map(
(NULL < s_C14_addrs_15yr_i and s_C14_addrs_15yr_i <= 11.5) => -0.0009195959,
(s_C14_addrs_15yr_i > 11.5) => 
   map(
   (NULL < s_I60_Inq_Count12_i and s_I60_Inq_Count12_i <= 3.5) => 0.1004817283,
   (s_I60_Inq_Count12_i > 3.5) => -0.0575746410,
   (s_I60_Inq_Count12_i = NULL) => 0.0044320885, 0.0044320885),
(s_C14_addrs_15yr_i = NULL) => 
   map(
   (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 16.5) => 
      map(
      (pf_ship_method in ['3rd Day','Next Day']) => -0.0794380970,
      (pf_ship_method in ['2nd Day','Ground','Other']) => -0.0238302661,
      (pf_ship_method = '') => -0.0317291058, -0.0317291058),
   ((real)BT_cen_no_move > 16.5) => 0.0128176449,
   ((real)BT_cen_no_move = NULL) => -0.0507516615, -0.0154018819), -0.0036620715);

// Tree: 431 
final_score_431 := map(
(NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.9849616397) => 
   map(
   (NULL < s_rel_homeover300_count_d and s_rel_homeover300_count_d <= 23.5) => -0.0014080975,
   (s_rel_homeover300_count_d > 23.5) => 
      map(
      (NULL < b_estimated_income_d and b_estimated_income_d <= 92500) => 0.0984322999,
      (b_estimated_income_d > 92500) => -0.0514066565,
      (b_estimated_income_d = NULL) => 0.0187014791, 0.0187014791),
   (s_rel_homeover300_count_d = NULL) => -0.0012664081, -0.0011916856),
(s_add_input_nhood_MFD_pct_i > 0.9849616397) => -0.0634884316,
(s_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 6.5) => -0.0053707616,
   (s_L79_adls_per_addr_c6_i > 6.5) => 0.0788331327,
   (s_L79_adls_per_addr_c6_i = NULL) => -0.0034762586, -0.0034762586), -0.0017496350);

// Tree: 432 
final_score_432 := map(
(NULL < b_srchaddrsrchcountwk_i and b_srchaddrsrchcountwk_i <= 1.5) => 0.0012623547,
(b_srchaddrsrchcountwk_i > 1.5) => 0.0824871101,
(b_srchaddrsrchcountwk_i = NULL) => 
   map(
   (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 79.5) => 
      map(
      (pf_avs_result in ['Error/Inval','Full Match','Unavailable']) => -0.0018064490,
      (pf_avs_result in ['Addr Only','International','No Match','Not Supported','Zip Only']) => 
         map(
         (NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 51.65) => 0.0248764440,
         ((real)BT_cen_ownocc_p > 51.65) => 0.0998924014,
         ((real)BT_cen_ownocc_p = NULL) => 0.0518484736, 0.0518484736),
      (pf_avs_result = '') => 0.0127081045, 0.0127081045),
   ((real)BT_cen_lar_fam > 79.5) => -0.0099636420,
   ((real)BT_cen_lar_fam = NULL) => 0.1054458215, 0.0561048873), 0.0124248876);

// Tree: 433 
final_score_433 := map(
(NULL < b_inq_adls_per_addr_i and b_inq_adls_per_addr_i <= 2.5) => 
   map(
   (NULL < b_C10_M_Hdr_FS_d and b_C10_M_Hdr_FS_d <= 10.5) => -0.0542761024,
   (b_C10_M_Hdr_FS_d > 10.5) => 0.0000298992,
   (b_C10_M_Hdr_FS_d = NULL) => 0.0028859988, -0.0004785355),
(b_inq_adls_per_addr_i > 2.5) => 
   map(
   (NULL < btst_distphoneaddr2_i and btst_distphoneaddr2_i <= 10.5) => -0.0490830178,
   (btst_distphoneaddr2_i > 10.5) => 0.0447730794,
   (btst_distphoneaddr2_i = NULL) => 
      map(
      (NULL < b_F04_curr_add_occ_index_d and b_F04_curr_add_occ_index_d <= 2) => -0.0324546675,
      (b_F04_curr_add_occ_index_d > 2) => -0.0783292357,
      (b_F04_curr_add_occ_index_d = NULL) => -0.0333118567, -0.0403407774), -0.0353912881),
(b_inq_adls_per_addr_i = NULL) => -0.0500195055, -0.0071050706);

// Tree: 434 
final_score_434 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 8.5) => 
   map(
   (NULL < b_property_owners_ct_d and b_property_owners_ct_d <= 2.5) => 
      map(
      (NULL < s_addrchangeincomediff_d and s_addrchangeincomediff_d <= -17933) => 
         map(
         (NULL < b_C14_Addr_Stability_v2_d and b_C14_Addr_Stability_v2_d <= 3.5) => 0.0396729876,
         (b_C14_Addr_Stability_v2_d > 3.5) => 0.0450160719,
         (b_C14_Addr_Stability_v2_d = NULL) => 0.0441052198, 0.0441052198),
      (s_addrchangeincomediff_d > -17933) => 0.0067118477,
      (s_addrchangeincomediff_d = NULL) => -0.0113354819, 0.0061067152),
   (b_property_owners_ct_d > 2.5) => -0.0357646526,
   (b_property_owners_ct_d = NULL) => -0.0036239015, -0.0014675892),
(b_inq_lnames_per_addr_i > 8.5) => 0.0334355657,
(b_inq_lnames_per_addr_i = NULL) => -0.0500208648, -0.0064013412);

// Tree: 435 
final_score_435 := map(
(NULL < b_hh_age_18_plus_d and b_hh_age_18_plus_d <= 8.5) => -0.0056889630,
(b_hh_age_18_plus_d > 8.5) => 0.0944924860,
(b_hh_age_18_plus_d = NULL) => 
   map(
   (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 122.5) => -0.0221064243,
   ((real)BT_cen_very_rich > 122.5) => 
      map(
      (NULL < (real)ST_cen_incollege and (real)ST_cen_incollege <= 16.3) => 
         map(
         (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 0.0021469173,
         (pf_ship_method in ['Next Day']) => 0.0498370108,
         (pf_ship_method = '') => 0.0084745135, 0.0084745135),
      ((real)ST_cen_incollege > 16.3) => 0.1556239460,
      ((real)ST_cen_incollege = NULL) => 0.0182588956, 0.0182588956),
   ((real)BT_cen_very_rich = NULL) => 0.1128578171, 0.0585298538), 0.0075821973);

// Tree: 436 
final_score_436 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 57) => 
   map(
   (NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 184.5) => 0.0000071311,
   ((real)BT_cen_span_lang > 184.5) => 
      map(
      (NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 1.5) => 0.0066845465,
      (b_phones_per_addr_c6_i > 1.5) => 
         map(
         (NULL < pf_order_amt_c and pf_order_amt_c <= 719.165) => 0.1550223738,
         (pf_order_amt_c > 719.165) => 0.0273138940,
         (pf_order_amt_c = NULL) => 0.0853632030, 0.0853632030),
      (b_phones_per_addr_c6_i = NULL) => 0.0180572826, 0.0180572826),
   ((real)BT_cen_span_lang = NULL) => -0.0228328782, -0.0017637191),
(b_L79_adls_per_addr_c6_i > 57) => 0.0464098505,
(b_L79_adls_per_addr_c6_i = NULL) => -0.0015234958, -0.0015234958);

// Tree: 437 
final_score_437 := map(
(NULL < (real)BT_cen_families and (real)BT_cen_families <= 2749.5) => 
   map(
   (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.05697426045) => -0.0118142589,
   (b_add_input_nhood_BUS_pct_i > 0.05697426045) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.0755762864) => 
         map(
         (NULL < s_A50_pb_average_dollars_d and s_A50_pb_average_dollars_d <= 20.5) => 0.1913169736,
         (s_A50_pb_average_dollars_d > 20.5) => 0.0285211716,
         (s_A50_pb_average_dollars_d = NULL) => 0.0499814681, 0.0467180815),
      (b_add_input_nhood_BUS_pct_i > 0.0755762864) => 0.0031094389,
      (b_add_input_nhood_BUS_pct_i = NULL) => 0.0090071039, 0.0090071039),
   (b_add_input_nhood_BUS_pct_i = NULL) => -0.0145933010, -0.0005206951),
((real)BT_cen_families > 2749.5) => 0.0919664197,
((real)BT_cen_families = NULL) => 0.0110799107, 0.0010825192);

// Tree: 438 
final_score_438 := map(
(NULL < s_P85_Phn_Invalid_i and s_P85_Phn_Invalid_i <= 0.5) => 
   map(
   (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.9846240064) => -0.0011614802,
   (s_add_input_nhood_MFD_pct_i > 0.9846240064) => -0.0639429237,
   (s_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < b_C10_M_Hdr_FS_d and b_C10_M_Hdr_FS_d <= 21) => 0.1049671988,
      (b_C10_M_Hdr_FS_d > 21) => -0.0057551566,
      (b_C10_M_Hdr_FS_d = NULL) => -0.0050219015, -0.0033686739), -0.0017225902),
(s_P85_Phn_Invalid_i > 0.5) => 
   map(
   (NULL < b_rel_educationover12_count_d and b_rel_educationover12_count_d <= 10.5) => -0.0608130081,
   (b_rel_educationover12_count_d > 10.5) => -0.0478848014,
   (b_rel_educationover12_count_d = NULL) => -0.0162208113, -0.0372389051),
(s_P85_Phn_Invalid_i = NULL) => 0.0538848805, 0.0002914941);

// Tree: 439 
final_score_439 := map(
(NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 71.25) => -0.0093659194,
((real)BT_cen_ownocc_p > 71.25) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < b_addrchangeincomediff_d and b_addrchangeincomediff_d <= -29865) => 0.1707346380,
      (b_addrchangeincomediff_d > -29865) => 0.0114221711,
      (b_addrchangeincomediff_d = NULL) => -0.0132560990, 0.0082558065),
   (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => 
      map(
      (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 10.5) => 0.0806597845,
      ((real)BT_cen_no_move > 10.5) => 0.0232432855,
      ((real)BT_cen_no_move = NULL) => 0.0332622719, 0.0332622719),
   (final_model_segment = '') => 0.0095576805, 0.0095576805),
((real)BT_cen_ownocc_p = NULL) => 0.0292795098, 0.0015101809);

// Tree: 440 
final_score_440 := map(
(NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 189397.5) => -0.0001552424,
(s_curraddrmedianincome_d > 189397.5) => 
   map(
   (NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 50.5) => 0.1732445803,
   ((real)ST_cen_no_move > 50.5) => -0.0192510219,
   ((real)ST_cen_no_move = NULL) => 0.0493255364, 0.0493255364),
(s_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 109.5) => -0.0183014409,
   ((real)BT_cen_very_rich > 109.5) => 
      map(
      (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 0.0169320134,
      (pf_ship_method in ['Next Day']) => 0.0505730816,
      (pf_ship_method = '') => 0.0215390168, 0.0215390168),
   ((real)BT_cen_very_rich = NULL) => 0.0900166431, 0.0324984259), 0.0067084048);

// Tree: 441 
final_score_441 := map(
(NULL < b_prevaddrmurderindex_i and b_prevaddrmurderindex_i <= 195.5) => -0.0016056970,
(b_prevaddrmurderindex_i > 195.5) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.1734898259) => 0.0238725105,
   (s_add_input_nhood_BUS_pct_i > 0.1734898259) => 0.1357502450,
   (s_add_input_nhood_BUS_pct_i = NULL) => 0.0621868032, 0.0621868032),
(b_prevaddrmurderindex_i = NULL) => 
   map(
   (NULL < (real)BT_cen_incollege and (real)BT_cen_incollege <= 1.45) => 0.0626589582,
   ((real)BT_cen_incollege > 1.45) => 
      map(
      (NULL < s_C21_M_Bureau_ADL_FS_d and s_C21_M_Bureau_ADL_FS_d <= 134.5) => 0.1403874134,
      (s_C21_M_Bureau_ADL_FS_d > 134.5) => -0.0090773806,
      (s_C21_M_Bureau_ADL_FS_d = NULL) => -0.0027553775, 0.0002336477),
   ((real)BT_cen_incollege = NULL) => 0.0747079619, 0.0415629577), 0.0074950741);

// Tree: 442 
final_score_442 := map(
(NULL < s_nap_contradictory_i and s_nap_contradictory_i <= 0.5) => 
   map(
   (NULL < b_C10_M_Hdr_FS_d and b_C10_M_Hdr_FS_d <= 620) => -0.0035543443,
   (b_C10_M_Hdr_FS_d > 620) => 0.0908760690,
   (b_C10_M_Hdr_FS_d = NULL) => 0.0018930599, -0.0022070321),
(s_nap_contradictory_i > 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 15.5) => 0.0715790559,
      ((real)BT_cen_no_move > 15.5) => -0.0351506565,
      ((real)BT_cen_no_move = NULL) => -0.0510519297, -0.0185451413),
   (final_model_segment in ['BUS  ADDR-         WEB','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => 0.0979383286,
   (final_model_segment = '') => 0.0032253723, 0.0032253723),
(s_nap_contradictory_i = NULL) => -0.0020355764, -0.0020355764);

// Tree: 443 
final_score_443 := map(
(NULL < (real)BT_cen_business and (real)BT_cen_business <= 415.5) => 
   map(
   (NULL < s_mos_liens_unrel_OT_lseen_d and s_mos_liens_unrel_OT_lseen_d <= 14.5) => -0.0573246471,
   (s_mos_liens_unrel_OT_lseen_d > 14.5) => 
      map(
      (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 171.5) => 0.0022712974,
      ((real)ST_cen_easiqlife > 171.5) => 0.0955467078,
      ((real)ST_cen_easiqlife = NULL) => 0.0028881363, 0.0028881363),
   (s_mos_liens_unrel_OT_lseen_d = NULL) => 
      map(
      (NULL < (real)ST_cen_lar_fam and (real)ST_cen_lar_fam <= 110.5) => 0.0209900616,
      ((real)ST_cen_lar_fam > 110.5) => -0.0249564890,
      ((real)ST_cen_lar_fam = NULL) => 0.0051368634, 0.0051368634), 0.0029639195),
((real)BT_cen_business > 415.5) => -0.0483754446,
((real)BT_cen_business = NULL) => -0.0245655127, -0.0023806653);

// Tree: 444 
final_score_444 := map(
(NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.96518660035) => 
   map(
   (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.96090935135) => 0.0003081763,
   (s_add_input_nhood_MFD_pct_i > 0.96090935135) => 0.0926478420,
   (s_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < b_C12_source_profile_d and b_C12_source_profile_d <= 30.05) => 0.1314135347,
      (b_C12_source_profile_d > 30.05) => -0.0010437348,
      (b_C12_source_profile_d = NULL) => -0.0528290923, -0.0065447004), 0.0003150218),
(b_add_input_nhood_MFD_pct_i > 0.96518660035) => -0.0538068690,
(b_add_input_nhood_MFD_pct_i = NULL) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0132584153,
   (final_model_segment in ['CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB']) => 0.0962417788,
   (final_model_segment = '') => -0.0063730076, -0.0063730076), -0.0014609839);

// Tree: 445 
final_score_445 := map(
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => -0.0080953181,
(final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
   map(
   (NULL < s_curraddrmedianvalue_d and s_curraddrmedianvalue_d <= 381306.5) => 
      map(
      (NULL < b_phones_per_addr_curr_i and b_phones_per_addr_curr_i <= 12.5) => 
         map(
         (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 169.5) => 0.0101157697,
         ((real)ST_cen_very_rich > 169.5) => 0.0639918559,
         ((real)ST_cen_very_rich = NULL) => 0.0193384348, 0.0193384348),
      (b_phones_per_addr_curr_i > 12.5) => 0.1152206669,
      (b_phones_per_addr_curr_i = NULL) => 0.0208483912, 0.0208483912),
   (s_curraddrmedianvalue_d > 381306.5) => -0.0218602554,
   (s_curraddrmedianvalue_d = NULL) => 0.0282432292, 0.0099303753),
(final_model_segment = '') => -0.0020564258, -0.0020564258);

// Tree: 446 
final_score_446 := map(
(NULL < b_hh_age_30_plus_d and b_hh_age_30_plus_d <= 6.5) => -0.0036998292,
(b_hh_age_30_plus_d > 6.5) => 
   map(
   (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.0375004935) => 0.0152268438,
   (b_add_curr_nhood_BUS_pct_i > 0.0375004935) => 0.1032707953,
   (b_add_curr_nhood_BUS_pct_i = NULL) => 0.0588373992, 0.0588373992),
(b_hh_age_30_plus_d = NULL) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 1.5) => 0.0053923074,
   (s_inq_ssns_per_addr_i > 1.5) => 
      map(
      (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.0557886243) => 0.0933375112,
      (s_add_input_nhood_BUS_pct_i > 0.0557886243) => 0.0026782760,
      (s_add_input_nhood_BUS_pct_i = NULL) => 0.0367515456, 0.0367515456),
   (s_inq_ssns_per_addr_i = NULL) => -0.0500006457, -0.0039536766), -0.0033321899);

// Tree: 447 
final_score_447 := map(
(NULL < s_prevaddrstatus_i and s_prevaddrstatus_i <= 2.5) => -0.0245124662,
(s_prevaddrstatus_i > 2.5) => 
   map(
   (NULL < (real)ST_cen_lar_fam and (real)ST_cen_lar_fam <= 169.5) => 
      map(
      (NULL < (real)BT_cen_civ_emp and (real)BT_cen_civ_emp <= 58.45) => 
         map(
         (NULL < b_F03_address_match_d and b_F03_address_match_d <= 3) => 0.0012579498,
         (b_F03_address_match_d > 3) => 0.0868364314,
         (b_F03_address_match_d = NULL) => 0.0334049266, 0.0334049266),
      ((real)BT_cen_civ_emp > 58.45) => -0.0090825423,
      ((real)BT_cen_civ_emp = NULL) => -0.0500387342, -0.0002636522),
   ((real)ST_cen_lar_fam > 169.5) => 0.0870100288,
   ((real)ST_cen_lar_fam = NULL) => 0.0016369070, 0.0016369070),
(s_prevaddrstatus_i = NULL) => -0.0019797141, -0.0059887390);

// Tree: 448 
final_score_448 := map(
(NULL < b_divaddrsuspidcountnew_i and b_divaddrsuspidcountnew_i <= 3.5) => 0.0042644811,
(b_divaddrsuspidcountnew_i > 3.5) => -0.0643321840,
(b_divaddrsuspidcountnew_i = NULL) => 
   map(
   (NULL < (real)BT_cen_low_hval and (real)BT_cen_low_hval <= 41.25) => 
      map(
      (NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 274206) => 
         map(
         (NULL < (real)ST_cen_totcrime and (real)ST_cen_totcrime <= 100.5) => 0.0671709748,
         ((real)ST_cen_totcrime > 100.5) => -0.0187566562,
         ((real)ST_cen_totcrime = NULL) => 0.0296987748, 0.0296987748),
      (s_L80_Inp_AVM_AutoVal_d > 274206) => -0.0552581872,
      (s_L80_Inp_AVM_AutoVal_d = NULL) => 0.0016882294, 0.0007703698),
   ((real)BT_cen_low_hval > 41.25) => 0.0638674397,
   ((real)BT_cen_low_hval = NULL) => -0.0506804532, -0.0254229976), -0.0025324653);

// Tree: 449 
final_score_449 := map(
(NULL < b_rel_felony_count_i and b_rel_felony_count_i <= 2.5) => 
   map(
   (NULL < b_addrchangevaluediff_d and b_addrchangevaluediff_d <= -20628.5) => -0.0230640783,
   (b_addrchangevaluediff_d > -20628.5) => 
      map(
      (NULL < s_corrrisktype_i and s_corrrisktype_i <= 8.5) => -0.0007966287,
      (s_corrrisktype_i > 8.5) => 
         map(
         (NULL < (real)ST_cen_totcrime and (real)ST_cen_totcrime <= 190.5) => 0.0197178435,
         ((real)ST_cen_totcrime > 190.5) => 0.1278033479,
         ((real)ST_cen_totcrime = NULL) => 0.0230666465, 0.0230666465),
      (s_corrrisktype_i = NULL) => 0.0195508899, 0.0059579855),
   (b_addrchangevaluediff_d = NULL) => -0.0168778340, -0.0027447627),
(b_rel_felony_count_i > 2.5) => -0.0739973551,
(b_rel_felony_count_i = NULL) => -0.0022305931, -0.0031056834);

// Tree: 450 
final_score_450 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 5.5) => 
   map(
   (NULL < s_addrchangevaluediff_d and s_addrchangevaluediff_d <= -315318.5) => 
      map(
      (NULL < s_prevaddrcartheftindex_i and s_prevaddrcartheftindex_i <= 147) => 0.0100846017,
      (s_prevaddrcartheftindex_i > 147) => 0.1313616816,
      (s_prevaddrcartheftindex_i = NULL) => 0.0307017053, 0.0307017053),
   (s_addrchangevaluediff_d > -315318.5) => -0.0040623926,
   (s_addrchangevaluediff_d = NULL) => -0.0060870471, -0.0039845532),
(b_inq_lnames_per_addr_i > 5.5) => 
   map(
   (NULL < b_prevaddrmedianvalue_d and b_prevaddrmedianvalue_d <= 216734) => 0.0945855102,
   (b_prevaddrmedianvalue_d > 216734) => -0.0170313242,
   (b_prevaddrmedianvalue_d = NULL) => 0.0025112709, 0.0198889937),
(b_inq_lnames_per_addr_i = NULL) => -0.0500184071, -0.0083657203);

// Tree: 451 
final_score_451 := map(
(NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 1.04741336625) => 
   map(
   (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 166.5) => -0.0004675225,
   ((real)ST_cen_easiqlife > 166.5) => 
      map(
      (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 58) => 0.1182931923,
      ((real)BT_cen_lar_fam > 58) => 
         map(
         (NULL < (real)BT_cen_med_hval and (real)BT_cen_med_hval <= 748108) => -0.0396065918,
         ((real)BT_cen_med_hval > 748108) => 0.1001784124,
         ((real)BT_cen_med_hval = NULL) => -0.0080621882, -0.0080621882),
      ((real)BT_cen_lar_fam = NULL) => 0.0198231371, 0.0198231371),
   ((real)ST_cen_easiqlife = NULL) => -0.0501106099, -0.0021765138),
(s_add_input_mobility_index_i > 1.04741336625) => -0.0563138020,
(s_add_input_mobility_index_i = NULL) => 0.0384897346, -0.0023242327);

// Tree: 452 
final_score_452 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 5.5) => 
   map(
   (NULL < b_curraddrmedianvalue_d and b_curraddrmedianvalue_d <= 76394) => -0.0424049411,
   (b_curraddrmedianvalue_d > 76394) => 0.0037686105,
   (b_curraddrmedianvalue_d = NULL) => -0.0008501932, -0.0004822377),
(b_inq_lnames_per_addr_i > 5.5) => 
   map(
   (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 147.5) => 
      map(
      (final_model_segment in ['BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => -0.0574380678,
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0654505667,
      (final_model_segment = '') => 0.0024572330, 0.0024572330),
   ((real)ST_cen_span_lang > 147.5) => 0.0878793779,
   ((real)ST_cen_span_lang = NULL) => 0.0280838765, 0.0280838765),
(b_inq_lnames_per_addr_i = NULL) => -0.0500234548, -0.0053911661);

// Tree: 453 
final_score_453 := map(
(NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 1.5) => -0.0036462259,
(s_inq_ssns_per_addr_i > 1.5) => 
   map(
   (NULL < s_rel_under25miles_cnt_d and s_rel_under25miles_cnt_d <= 0.5) => 0.0733965560,
   (s_rel_under25miles_cnt_d > 0.5) => 
      map(
      (NULL < b_fp_prevaddrburglaryindex_i and b_fp_prevaddrburglaryindex_i <= 135.5) => -0.0129972026,
      (b_fp_prevaddrburglaryindex_i > 135.5) => 0.0750089183,
      (b_fp_prevaddrburglaryindex_i = NULL) => 0.0251181508, 0.0044860683),
   (s_rel_under25miles_cnt_d = NULL) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH']) => -0.0298565231,
      (final_model_segment in ['CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => 0.0552332909,
      (final_model_segment = '') => -0.0025382144, -0.0025382144), 0.0070404124),
(s_inq_ssns_per_addr_i = NULL) => -0.0500029120, -0.0048007559);

// Tree: 454 
final_score_454 := map(
(NULL < b_L79_adls_per_addr_c6_i and b_L79_adls_per_addr_c6_i <= 44) => 
   map(
   (NULL < b_phones_per_addr_c6_i and b_phones_per_addr_c6_i <= 17.5) => 
      map(
      (NULL < s_C20_email_verification_d and s_C20_email_verification_d <= 0.5) => 
         map(
         (NULL < (real)ST_cen_incollege and (real)ST_cen_incollege <= 46.2) => 0.0130340608,
         ((real)ST_cen_incollege > 46.2) => 0.1420825304,
         ((real)ST_cen_incollege = NULL) => 0.0158961090, 0.0158961090),
      (s_C20_email_verification_d > 0.5) => -0.0063676797,
      (s_C20_email_verification_d = NULL) => -0.0020398950, -0.0005964809),
   (b_phones_per_addr_c6_i > 17.5) => 0.0585260165,
   (b_phones_per_addr_c6_i = NULL) => -0.0003507545, -0.0003507545),
(b_L79_adls_per_addr_c6_i > 44) => 0.0460727527,
(b_L79_adls_per_addr_c6_i = NULL) => -0.0001164349, -0.0001164349);

// Tree: 455 
final_score_455 := map(
(NULL < s_comb_age_d and s_comb_age_d <= 29.5) => 
   map(
   (NULL < (real)BT_cen_easiqlife and (real)BT_cen_easiqlife <= 53.5) => 0.1314562450,
   ((real)BT_cen_easiqlife > 53.5) => 
      map(
      (NULL < (real)BT_cen_totcrime and (real)BT_cen_totcrime <= 185.5) => 
         map(
         (NULL < s_addrchangeincomediff_d and s_addrchangeincomediff_d <= -34645) => 0.1162321440,
         (s_addrchangeincomediff_d > -34645) => 0.0095277184,
         (s_addrchangeincomediff_d = NULL) => 0.0023940769, 0.0104416332),
      ((real)BT_cen_totcrime > 185.5) => 0.1365230517,
      ((real)BT_cen_totcrime = NULL) => 0.0166040396, 0.0166040396),
   ((real)BT_cen_easiqlife = NULL) => -0.0514655826, 0.0167401076),
(s_comb_age_d > 29.5) => -0.0040217690,
(s_comb_age_d = NULL) => 0.0027538737, -0.0002437340);

// Tree: 456 
final_score_456 := map(
(NULL < s_addrchangeecontrajindex_d and s_addrchangeecontrajindex_d <= 1.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 219) => 
      map(
      (NULL < (real)BT_cen_rental and (real)BT_cen_rental <= 189.5) => 0.0071424144,
      ((real)BT_cen_rental > 189.5) => 0.1284192695,
      ((real)BT_cen_rental = NULL) => 0.0196451830, 0.0196451830),
   (btst_distaddraddr2_i > 219) => 0.0811496362,
   (btst_distaddraddr2_i = NULL) => 0.0235026051, 0.0235026051),
(s_addrchangeecontrajindex_d > 1.5) => 
   map(
   (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 998) => -0.0041764517,
   (b_P88_Phn_Dst_to_Inp_Add_i > 998) => 0.0570064670,
   (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => -0.0090230199, -0.0049198913),
(s_addrchangeecontrajindex_d = NULL) => -0.0054983781, -0.0036289879);

// Tree: 457 
final_score_457 := map(
(final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB']) => 
   map(
   (NULL < s_add_input_mobility_index_i and s_add_input_mobility_index_i <= 0.22621036785) => 
      map(
      (NULL < (real)BT_cen_unemp and (real)BT_cen_unemp <= 4.45) => -0.0154871556,
      ((real)BT_cen_unemp > 4.45) => 0.0845878343,
      ((real)BT_cen_unemp = NULL) => 0.0016489728, 0.0016489728),
   (s_add_input_mobility_index_i > 0.22621036785) => 
      map(
      (NULL < (real)BT_cen_lar_fam and (real)BT_cen_lar_fam <= 122.5) => -0.0193417115,
      ((real)BT_cen_lar_fam > 122.5) => -0.0540697876,
      ((real)BT_cen_lar_fam = NULL) => -0.0501886916, -0.0293838240),
   (s_add_input_mobility_index_i = NULL) => -0.0205860120, -0.0205860120),
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0014704388,
(final_model_segment = '') => -0.0000291424, -0.0000291424);

// Tree: 458 
final_score_458 := map(
(NULL < (real)BT_cen_ownocc_p and (real)BT_cen_ownocc_p <= 2.65) => -0.0557408988,
((real)BT_cen_ownocc_p > 2.65) => 
   map(
   (NULL < b_nap_contradictory_i and b_nap_contradictory_i <= 0.5) => 
      map(
      (NULL < (real)ST_cen_ownocc_p and (real)ST_cen_ownocc_p <= 2.75) => 0.0654969361,
      ((real)ST_cen_ownocc_p > 2.75) => -0.0002701407,
      ((real)ST_cen_ownocc_p = NULL) => -0.0561518367, 0.0001089033),
   (b_nap_contradictory_i > 0.5) => 
      map(
      (NULL < s_add_curr_nhood_BUS_pct_i and s_add_curr_nhood_BUS_pct_i <= 0.10285600785) => -0.0261438388,
      (s_add_curr_nhood_BUS_pct_i > 0.10285600785) => 0.0623580215,
      (s_add_curr_nhood_BUS_pct_i = NULL) => 0.0745498147, 0.0197044171),
   (b_nap_contradictory_i = NULL) => 0.0004962100, 0.0004962100),
((real)BT_cen_ownocc_p = NULL) => 0.0081411730, 0.0000242499);

// Tree: 459 
final_score_459 := map(
(NULL < s_liens_unrel_ST_total_amt_i and s_liens_unrel_ST_total_amt_i <= 3790) => -0.0007430382,
(s_liens_unrel_ST_total_amt_i > 3790) => 0.0807364184,
(s_liens_unrel_ST_total_amt_i = NULL) => 
   map(
   (pf_avs_result in ['Addr Only','Error/Inval','Full Match','Unavailable','Zip Only']) => -0.0042590803,
   (pf_avs_result in ['International','No Match','Not Supported']) => 
      map(
      (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 5.35) => 
         map(
         (NULL < b_add_input_nhood_MFD_pct_i and b_add_input_nhood_MFD_pct_i <= 0.25675778345) => 0.0583783393,
         (b_add_input_nhood_MFD_pct_i > 0.25675778345) => -0.0323807330,
         (b_add_input_nhood_MFD_pct_i = NULL) => 0.0110009619, 0.0110009619),
      ((real)ST_cen_unemp > 5.35) => 0.0604010967,
      ((real)ST_cen_unemp = NULL) => 0.0246901559, 0.0246901559),
   (pf_avs_result = '') => -0.0016248370, -0.0016248370), -0.0006501461);

// Tree: 460 
final_score_460 := map(
(NULL < b_C13_Curr_Addr_LRes_d and b_C13_Curr_Addr_LRes_d <= 10.5) => 
   map(
   (NULL < s_C12_source_profile_d and s_C12_source_profile_d <= 78.75) => -0.0412544554,
   (s_C12_source_profile_d > 78.75) => 
      map(
      (NULL < s_rel_homeover300_count_d and s_rel_homeover300_count_d <= 2.5) => 0.1001630047,
      (s_rel_homeover300_count_d > 2.5) => 0.0324700557,
      (s_rel_homeover300_count_d = NULL) => 0.0644703589, 0.0644703589),
   (s_C12_source_profile_d = NULL) => -0.0579725692, -0.0351280679),
(b_C13_Curr_Addr_LRes_d > 10.5) => 0.0024146061,
(b_C13_Curr_Addr_LRes_d = NULL) => 
   map(
   (NULL < b_add_input_nhood_VAC_pct_i and b_add_input_nhood_VAC_pct_i <= 0.0040270408) => -0.0471006258,
   (b_add_input_nhood_VAC_pct_i > 0.0040270408) => 0.0080663527,
   (b_add_input_nhood_VAC_pct_i = NULL) => 0.0025233379, 0.0025233379), -0.0011202272);

// Tree: 461 
final_score_461 := map(
(NULL < (real)BT_cen_retired2 and (real)BT_cen_retired2 <= 186.5) => 
   map(
   (NULL < s_addrchangevaluediff_d and s_addrchangevaluediff_d <= -298011.5) => 
      map(
      (NULL < s_F01_inp_addr_address_score_d and s_F01_inp_addr_address_score_d <= 16) => 0.0530204243,
      (s_F01_inp_addr_address_score_d > 16) => -0.0527945568,
      (s_F01_inp_addr_address_score_d = NULL) => 0.0219944268, 0.0219944268),
   (s_addrchangevaluediff_d > -298011.5) => -0.0038183740,
   (s_addrchangevaluediff_d = NULL) => -0.0060777248, -0.0039237092),
((real)BT_cen_retired2 > 186.5) => 
   map(
   (NULL < (real)ST_cen_no_move and (real)ST_cen_no_move <= 36.5) => 0.1811558108,
   ((real)ST_cen_no_move > 36.5) => 0.0026325242,
   ((real)ST_cen_no_move = NULL) => 0.0396434495, 0.0396434495),
((real)BT_cen_retired2 = NULL) => -0.0555310454, -0.0090402723);

// Tree: 462 
final_score_462 := map(
(NULL < b_C10_M_Hdr_FS_d and b_C10_M_Hdr_FS_d <= 362.5) => 
   map(
   (NULL < b_inq_count24_i and b_inq_count24_i <= 3.5) => 
      map(
      (NULL < b_inq_Retail_count_week_i and b_inq_Retail_count_week_i <= 0.5) => 
         map(
         (pf_ship_method in ['2nd Day','3rd Day','Ground']) => 0.0145932327,
         (pf_ship_method in ['Next Day','Other']) => 0.0520249243,
         (pf_ship_method = '') => 0.0189683655, 0.0189683655),
      (b_inq_Retail_count_week_i > 0.5) => 0.1746447648,
      (b_inq_Retail_count_week_i = NULL) => 0.0213976080, 0.0213976080),
   (b_inq_count24_i > 3.5) => -0.0121586487,
   (b_inq_count24_i = NULL) => 0.0068696806, 0.0068696806),
(b_C10_M_Hdr_FS_d > 362.5) => -0.0187940263,
(b_C10_M_Hdr_FS_d = NULL) => 0.0005412725, -0.0003146626);

// Tree: 463 
final_score_463 := map(
(NULL < b_inq_lnames_per_addr_i and b_inq_lnames_per_addr_i <= 5.5) => 
   map(
   (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.0210579106) => -0.0215003944,
   (b_add_curr_nhood_BUS_pct_i > 0.0210579106) => 0.0049451968,
   (b_add_curr_nhood_BUS_pct_i = NULL) => 
      map(
      (NULL < b_rel_incomeover50_count_d and b_rel_incomeover50_count_d <= 3.5) => 0.0803412812,
      (b_rel_incomeover50_count_d > 3.5) => -0.0304577461,
      (b_rel_incomeover50_count_d = NULL) => 0.0040125783, 0.0009100994), -0.0039910311),
(b_inq_lnames_per_addr_i > 5.5) => 
   map(
   (NULL < (real)ST_cen_civ_emp and (real)ST_cen_civ_emp <= 62.45) => -0.0449079676,
   ((real)ST_cen_civ_emp > 62.45) => 0.0692147906,
   ((real)ST_cen_civ_emp = NULL) => 0.0215517563, 0.0215517563),
(b_inq_lnames_per_addr_i = NULL) => -0.0500167200, -0.0085983594);

// Tree: 464 
final_score_464 := map(
(final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => 
   map(
   (pf_ship_method in ['Next Day']) => -0.0565067327,
   (pf_ship_method in ['2nd Day','3rd Day','Ground','Other']) => 
      map(
      (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.4030896965) => -0.0433256060,
      (s_add_input_nhood_MFD_pct_i > 0.4030896965) => 
         map(
         (NULL < (real)ST_cen_health and (real)ST_cen_health <= 8.2) => -0.0275506610,
         ((real)ST_cen_health > 8.2) => 0.0795924122,
         ((real)ST_cen_health = NULL) => 0.0106612043, 0.0106612043),
      (s_add_input_nhood_MFD_pct_i = NULL) => 0.0556593642, -0.0158007134),
   (pf_ship_method = '') => -0.0198510636, -0.0198510636),
(final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0011313545,
(final_model_segment = '') => 0.0003619311, 0.0003619311);

// Tree: 465 
final_score_465 := map(
(NULL < s_L80_Inp_AVM_AutoVal_d and s_L80_Inp_AVM_AutoVal_d <= 125090.5) => -0.0211529567,
(s_L80_Inp_AVM_AutoVal_d > 125090.5) => 
   map(
   (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 126564.5) => 0.1728459507,
   (b_L80_Inp_AVM_AutoVal_d > 126564.5) => 
      map(
      (NULL < s_add_curr_nhood_SFD_pct_d and s_add_curr_nhood_SFD_pct_d <= 0.0345197369) => 0.0822250676,
      (s_add_curr_nhood_SFD_pct_d > 0.0345197369) => 0.0060021775,
      (s_add_curr_nhood_SFD_pct_d = NULL) => 
         map(
         (NULL < s_nap_nothing_found_i and s_nap_nothing_found_i <= 0.5) => -0.0285866742,
         (s_nap_nothing_found_i > 0.5) => 0.0584597467,
         (s_nap_nothing_found_i = NULL) => 0.0020711848, 0.0020711848), 0.0070258606),
   (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0299586193, 0.0049566840),
(s_L80_Inp_AVM_AutoVal_d = NULL) => -0.0072756529, -0.0046812247);

// Tree: 466 
final_score_466 := map(
(NULL < b_varmsrcssnunrelcount_i and b_varmsrcssnunrelcount_i <= 1.5) => 
   map(
   (NULL < (real)ST_cen_families and (real)ST_cen_families <= 256.5) => -0.0253728161,
   ((real)ST_cen_families > 256.5) => 
      map(
      (NULL < (real)BT_cen_no_move and (real)BT_cen_no_move <= 186.5) => 
         map(
         (NULL < s_srchvelocityrisktype_i and s_srchvelocityrisktype_i <= 5.5) => 0.0111047718,
         (s_srchvelocityrisktype_i > 5.5) => -0.0476812637,
         (s_srchvelocityrisktype_i = NULL) => 0.0068719389, 0.0037713837),
      ((real)BT_cen_no_move > 186.5) => 0.1513361662,
      ((real)BT_cen_no_move = NULL) => 0.0052176494, 0.0052176494),
   ((real)ST_cen_families = NULL) => 0.0118058872, -0.0023339950),
(b_varmsrcssnunrelcount_i > 1.5) => 0.0854939782,
(b_varmsrcssnunrelcount_i = NULL) => -0.0055451856, -0.0027078535);

// Tree: 467 
final_score_467 := map(
(NULL < s_curraddrcartheftindex_i and s_curraddrcartheftindex_i <= 118) => -0.0032425863,
(s_curraddrcartheftindex_i > 118) => 
   map(
   (NULL < b_prevaddrageoldest_d and b_prevaddrageoldest_d <= 36.5) => 
      map(
      (NULL < b_A49_Curr_AVM_Chg_1yr_i and b_A49_Curr_AVM_Chg_1yr_i <= -83) => 0.1791801952,
      (b_A49_Curr_AVM_Chg_1yr_i > -83) => 
         map(
         (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 12.15) => -0.0521416617,
         ((real)ST_cen_blue_col > 12.15) => 0.1281256609,
         ((real)ST_cen_blue_col = NULL) => 0.0255597705, 0.0255597705),
      (b_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0421420789, 0.0482287596),
   (b_prevaddrageoldest_d > 36.5) => 0.0084629226,
   (b_prevaddrageoldest_d = NULL) => 0.0346478398, 0.0208448935),
(s_curraddrcartheftindex_i = NULL) => 0.0046476493, 0.0033119517);

// Tree: 468 
final_score_468 := map(
(NULL < (real)ST_cen_med_hhinc and (real)ST_cen_med_hhinc <= 31641) => -0.0357760482,
((real)ST_cen_med_hhinc > 31641) => 
   map(
   (NULL < s_validationrisktype_i and s_validationrisktype_i <= 1.5) => -0.0026106590,
   (s_validationrisktype_i > 1.5) => 
      map(
      (NULL < (real)BT_cen_blue_col and (real)BT_cen_blue_col <= 14.35) => 0.0014462306,
      ((real)BT_cen_blue_col > 14.35) => 
         map(
         (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.0717175501) => 0.0211077619,
         (b_add_curr_nhood_BUS_pct_i > 0.0717175501) => 0.1788166251,
         (b_add_curr_nhood_BUS_pct_i = NULL) => 0.0782486544, 0.0782486544),
      ((real)BT_cen_blue_col = NULL) => -0.0502243177, 0.0142660107),
   (s_validationrisktype_i = NULL) => 0.0099511576, 0.0001209183),
((real)ST_cen_med_hhinc = NULL) => -0.0553755094, -0.0053742156);

// Tree: 469 
final_score_469 := map(
(NULL < b_srchaddrsrchcountmo_i and b_srchaddrsrchcountmo_i <= 0.5) => 0.0023486330,
(b_srchaddrsrchcountmo_i > 0.5) => -0.0346774753,
(b_srchaddrsrchcountmo_i = NULL) => 
   map(
   (final_model_segment in ['CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0556524093,
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB']) => 
      map(
      (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 171.5) => -0.0068371442,
      ((real)BT_cen_very_rich > 171.5) => 
         map(
         (pf_avs_result in ['Addr Only','Error/Inval','Full Match','Not Supported','Unavailable']) => 0.0003214619,
         (pf_avs_result in ['International','No Match','Zip Only']) => 0.1018435694,
         (pf_avs_result = '') => 0.0197769180, 0.0197769180),
      ((real)BT_cen_very_rich = NULL) => -0.0507889448, -0.0281570041),
   (final_model_segment = '') => -0.0292469427, -0.0292469427), -0.0057244504);

// Tree: 470 
final_score_470 := map(
(pf_cid_result in ['Match','No Match','Null']) => 
   map(
   (NULL < b_add_curr_nhood_BUS_pct_i and b_add_curr_nhood_BUS_pct_i <= 0.04616963605) => -0.0141419033,
   (b_add_curr_nhood_BUS_pct_i > 0.04616963605) => 0.0115915093,
   (b_add_curr_nhood_BUS_pct_i = NULL) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.87633312) => 0.0091266214,
      (b_add_input_nhood_BUS_pct_i > 0.87633312) => 0.0680781705,
      (b_add_input_nhood_BUS_pct_i = NULL) => -0.0062590902, 0.0083644646), -0.0005893156),
(pf_cid_result in ['Invalid','Other']) => 
   map(
   (NULL < b_bus_name_nover_i and b_bus_name_nover_i <= 0.5) => 0.1018469105,
   (b_bus_name_nover_i > 0.5) => -0.0428376165,
   (b_bus_name_nover_i = NULL) => 0.0189933779, 0.0189933779),
(pf_cid_result = '') => -0.0004499836, -0.0004499836);

// Tree: 471 
final_score_471 := map(
(NULL < s_inq_per_phone_i and s_inq_per_phone_i <= 81.5) => 
   map(
   (NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.93986688575) => -0.0013573556,
   (s_add_input_nhood_MFD_pct_i > 0.93986688575) => -0.0461321476,
   (s_add_input_nhood_MFD_pct_i = NULL) => 
      map(
      (NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 6.5) => 
         map(
         (NULL < (real)BT_cen_business and (real)BT_cen_business <= 255.5) => -0.0177954880,
         ((real)BT_cen_business > 255.5) => 0.0843143853,
         ((real)BT_cen_business = NULL) => 0.0018135513, -0.0114177042),
      (s_L79_adls_per_addr_c6_i > 6.5) => 0.0721992084,
      (s_L79_adls_per_addr_c6_i = NULL) => -0.0094613585, -0.0094613585), -0.0033412016),
(s_inq_per_phone_i > 81.5) => 0.0454853761,
(s_inq_per_phone_i = NULL) => 0.0052327628, -0.0027610161);

// Tree: 472 
final_score_472 := map(
(NULL < s_addrchangevaluediff_d and s_addrchangevaluediff_d <= -315318.5) => 
   map(
   (NULL < s_F01_inp_addr_address_score_d and s_F01_inp_addr_address_score_d <= 16) => 
      map(
      (NULL < (real)BT_cen_low_hval and (real)BT_cen_low_hval <= 3.75) => 0.0013620810,
      ((real)BT_cen_low_hval > 3.75) => 0.1499548729,
      ((real)BT_cen_low_hval = NULL) => 0.0403492986, 0.0403492986),
   (s_F01_inp_addr_address_score_d > 16) => -0.0108550156,
   (s_F01_inp_addr_address_score_d = NULL) => 0.0260054191, 0.0260054191),
(s_addrchangevaluediff_d > -315318.5) => 
   map(
   (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 26.95) => -0.0036411377,
   ((real)ST_cen_blue_col > 26.95) => 0.0567349877,
   ((real)ST_cen_blue_col = NULL) => -0.0030282117, -0.0030282117),
(s_addrchangevaluediff_d = NULL) => -0.0004163689, -0.0015642879);

// Tree: 473 
final_score_473 := map(
(NULL < s_validationrisktype_i and s_validationrisktype_i <= 2.5) => 
   map(
   (NULL < b_inq_Collection_count24_i and b_inq_Collection_count24_i <= 10.5) => 0.0041061437,
   (b_inq_Collection_count24_i > 10.5) => 0.0951650683,
   (b_inq_Collection_count24_i = NULL) => -0.0216505962, 0.0024942899),
(s_validationrisktype_i > 2.5) => 0.1064845197,
(s_validationrisktype_i = NULL) => 
   map(
   (NULL < pf_pmt_x_avs_lvl and pf_pmt_x_avs_lvl <= 1.5) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 778.275) => -0.0231077999,
      (pf_order_amt_c > 778.275) => 0.0810813001,
      (pf_order_amt_c = NULL) => 0.0327077894, 0.0327077894),
   (pf_pmt_x_avs_lvl > 1.5) => -0.0025804743,
   (pf_pmt_x_avs_lvl = NULL) => -0.0013496161, -0.0013496161), 0.0020598901);

// Tree: 474 
final_score_474 := map(
(NULL < (real)BT_cen_families and (real)BT_cen_families <= 979.5) => 
   map(
   (NULL < s_inq_ssns_per_addr_i and s_inq_ssns_per_addr_i <= 4.5) => 0.0013380448,
   (s_inq_ssns_per_addr_i > 4.5) => -0.0381921374,
   (s_inq_ssns_per_addr_i = NULL) => 0.0011197571, 0.0011197571),
((real)BT_cen_families > 979.5) => 
   map(
   (NULL < (real)BT_cen_high_hval and (real)BT_cen_high_hval <= 0.25) => 0.1191789533,
   ((real)BT_cen_high_hval > 0.25) => 
      map(
      (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 5.5) => -0.0000208114,
      (s_inq_per_addr_i > 5.5) => 0.0859195170,
      (s_inq_per_addr_i = NULL) => 0.0083547291, 0.0083547291),
   ((real)BT_cen_high_hval = NULL) => 0.0210995149, 0.0210995149),
((real)BT_cen_families = NULL) => -0.0561476447, -0.0043335724);

// Tree: 475 
final_score_475 := map(
(NULL < btst_distphoneaddr_i and btst_distphoneaddr_i <= 343) => 
   map(
   (NULL < s_inq_per_addr_i and s_inq_per_addr_i <= 21.5) => 0.0015179728,
   (s_inq_per_addr_i > 21.5) => 0.0842897754,
   (s_inq_per_addr_i = NULL) => -0.0500016555, 0.0016681901),
(btst_distphoneaddr_i > 343) => -0.0470866753,
(btst_distphoneaddr_i = NULL) => 
   map(
   (NULL < (real)BT_cen_high_hval and (real)BT_cen_high_hval <= 98.25) => 
      map(
      (NULL < (real)BT_cen_retired2 and (real)BT_cen_retired2 <= 185.5) => -0.0000401976,
      ((real)BT_cen_retired2 > 185.5) => 0.0850061290,
      ((real)BT_cen_retired2 = NULL) => 0.0015047035, 0.0015047035),
   ((real)BT_cen_high_hval > 98.25) => -0.0708176983,
   ((real)BT_cen_high_hval = NULL) => 0.0047588127, 0.0009255460), 0.0008239360);

// Tree: 476 
final_score_476 := map(
(NULL < b_prevaddrmurderindex_i and b_prevaddrmurderindex_i <= 195.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => -0.0002138700,
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0320462960,
   (final_model_segment = '') => -0.0000202047, -0.0000202047),
(b_prevaddrmurderindex_i > 195.5) => 
   map(
   (NULL < s_add_input_nhood_BUS_pct_i and s_add_input_nhood_BUS_pct_i <= 0.1320056075) => 0.0209761431,
   (s_add_input_nhood_BUS_pct_i > 0.1320056075) => 0.0894131456,
   (s_add_input_nhood_BUS_pct_i = NULL) => 0.0501817429, 0.0501817429),
(b_prevaddrmurderindex_i = NULL) => 
   map(
   (NULL < (real)BT_cen_unemp and (real)BT_cen_unemp <= 4.95) => -0.0210393109,
   ((real)BT_cen_unemp > 4.95) => 0.0192026224,
   ((real)BT_cen_unemp = NULL) => -0.0506738182, -0.0303946991), -0.0056205029);

// Tree: 477 
final_score_477 := map(
(NULL < s_varmsrcssnunrelcount_i and s_varmsrcssnunrelcount_i <= 1.5) => 
   map(
   (NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 0.5) => 
      map(
      (NULL < (real)BT_cen_families and (real)BT_cen_families <= 622.5) => 0.0010789964,
      ((real)BT_cen_families > 622.5) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- LNAME   WEB']) => -0.0205358740,
         (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.1061889963,
         (final_model_segment = '') => 0.0372642099, 0.0372642099),
      ((real)BT_cen_families = NULL) => 0.0085557518, 0.0085557518),
   (b_C20_email_verification_d > 0.5) => -0.0118712789,
   (b_C20_email_verification_d = NULL) => -0.0100921164, -0.0073009330),
(s_varmsrcssnunrelcount_i > 1.5) => 0.0721167569,
(s_varmsrcssnunrelcount_i = NULL) => -0.0061397338, -0.0067849062);

// Tree: 478 
final_score_478 := map(
(NULL < s_P85_Phn_Not_Issued_i and s_P85_Phn_Not_Issued_i <= 0.5) => 
   map(
   (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 26.95) => -0.0028435077,
   ((real)ST_cen_blue_col > 26.95) => 
      map(
      (NULL < (real)BT_cen_vacant_p and (real)BT_cen_vacant_p <= 7.45) => 0.1105554531,
      ((real)BT_cen_vacant_p > 7.45) => -0.0524824757,
      ((real)BT_cen_vacant_p = NULL) => 0.0180516637, 0.0180516637),
   ((real)ST_cen_blue_col = NULL) => 0.0618874077, -0.0015487470),
(s_P85_Phn_Not_Issued_i > 0.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB']) => -0.0144770402,
   (final_model_segment in ['BUS  ADDR+         WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 0.0764167284,
   (final_model_segment = '') => 0.0139541860, 0.0139541860),
(s_P85_Phn_Not_Issued_i = NULL) => 0.0271481812, -0.0000706415);

// Tree: 479 
final_score_479 := map(
(NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 93.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => -0.0076133003,
   (final_model_segment in ['CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < b_pb_order_freq_d and b_pb_order_freq_d <= 81.5) => -0.0161826043,
      (b_pb_order_freq_d > 81.5) => 
         map(
         (NULL < b_C14_Addr_Stability_v2_d and b_C14_Addr_Stability_v2_d <= 4.5) => 0.0582023591,
         (b_C14_Addr_Stability_v2_d > 4.5) => 0.0429541018,
         (b_C14_Addr_Stability_v2_d = NULL) => 0.0468666228, 0.0468666228),
      (b_pb_order_freq_d = NULL) => 0.0069577595, 0.0109622776),
   (final_model_segment = '') => -0.0048213388, -0.0048213388),
(s_L79_adls_per_addr_c6_i > 93.5) => -0.0492985813,
(s_L79_adls_per_addr_c6_i = NULL) => -0.0050837015, -0.0050837015);

// Tree: 480 
final_score_480 := map(
(NULL < (real)ST_cen_low_hval and (real)ST_cen_low_hval <= 0.65) => 
   map(
   (NULL < b_hh_age_30_plus_d and b_hh_age_30_plus_d <= 6.5) => -0.0148855790,
   (b_hh_age_30_plus_d > 6.5) => 0.0724624721,
   (b_hh_age_30_plus_d = NULL) => 0.0025191388, -0.0111308952),
((real)ST_cen_low_hval > 0.65) => 
   map(
   (NULL < pf_product_desc and pf_product_desc <= 2.5) => -0.0094953492,
   (pf_product_desc > 2.5) => 
      map(
      (NULL < (real)ST_cen_blue_col and (real)ST_cen_blue_col <= 1.65) => 0.0905153511,
      ((real)ST_cen_blue_col > 1.65) => 0.0219550984,
      ((real)ST_cen_blue_col = NULL) => 0.0229640553, 0.0229640553),
   (pf_product_desc = NULL) => 0.0075538306, 0.0075538306),
((real)ST_cen_low_hval = NULL) => -0.0217294005, -0.0025338273);

// Tree: 481 
final_score_481 := map(
(NULL < b_srchaddrsrchcountwk_i and b_srchaddrsrchcountwk_i <= 1.5) => 0.0001740421,
(b_srchaddrsrchcountwk_i > 1.5) => 0.0771433440,
(b_srchaddrsrchcountwk_i = NULL) => 
   map(
   (NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 2.5) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.7032798553) => -0.0184396779,
      (b_add_input_nhood_BUS_pct_i > 0.7032798553) => 0.0696136688,
      (b_add_input_nhood_BUS_pct_i = NULL) => -0.0130836349, -0.0130836349),
   (b_C20_email_verification_d > 2.5) => 
      map(
      (NULL < s_nap_nothing_found_i and s_nap_nothing_found_i <= 0.5) => -0.0228252661,
      (s_nap_nothing_found_i > 0.5) => 0.1109116163,
      (s_nap_nothing_found_i = NULL) => 0.0451393790, 0.0451393790),
   (b_C20_email_verification_d = NULL) => 0.0038471741, 0.0010043265), 0.0006109178);

// Tree: 482 
final_score_482 := map(
(NULL < (real)BT_cen_span_lang and (real)BT_cen_span_lang <= 187.5) => 
   map(
   (NULL < b_prevaddrlenofres_d and b_prevaddrlenofres_d <= 459.5) => -0.0006613555,
   (b_prevaddrlenofres_d > 459.5) => 0.1392492811,
   (b_prevaddrlenofres_d = NULL) => -0.0093794023, -0.0005600395),
((real)BT_cen_span_lang > 187.5) => 
   map(
   (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1.5) => -0.0228138224,
      (b_P88_Phn_Dst_to_Inp_Add_i > 1.5) => -0.0492249948,
      (b_P88_Phn_Dst_to_Inp_Add_i = NULL) => -0.0554955264, -0.0410622267),
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH']) => -0.0041148096,
   (final_model_segment = '') => -0.0164306153, -0.0164306153),
((real)BT_cen_span_lang = NULL) => 0.0077452928, -0.0001123892);

// Tree: 483 
final_score_483 := map(
(NULL < s_hh_age_30_plus_d and s_hh_age_30_plus_d <= 6.5) => -0.0007454482,
(s_hh_age_30_plus_d > 6.5) => 0.0645382631,
(s_hh_age_30_plus_d = NULL) => 
   map(
   (NULL < (real)BT_cen_trailer and (real)BT_cen_trailer <= 171.5) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 186.5) => -0.0037831090,
      ((real)ST_cen_span_lang > 186.5) => 0.0284575781,
      ((real)ST_cen_span_lang = NULL) => -0.0021176031, -0.0021176031),
   ((real)BT_cen_trailer > 171.5) => 
      map(
      (NULL < b_add_input_nhood_BUS_pct_i and b_add_input_nhood_BUS_pct_i <= 0.0823246615) => 0.0608584886,
      (b_add_input_nhood_BUS_pct_i > 0.0823246615) => 0.0311482391,
      (b_add_input_nhood_BUS_pct_i = NULL) => 0.0428451877, 0.0428451877),
   ((real)BT_cen_trailer = NULL) => -0.0508658546, -0.0179227331), -0.0036409986);

// Tree: 484 
final_score_484 := map(
(NULL < s_add_input_nhood_SFD_pct_d and s_add_input_nhood_SFD_pct_d <= 0.9920962814) => -0.0033452963,
(s_add_input_nhood_SFD_pct_d > 0.9920962814) => 
   map(
   (NULL < s_corrrisktype_i and s_corrrisktype_i <= 7.5) => 
      map(
      (NULL < s_rel_homeover50_count_d and s_rel_homeover50_count_d <= 3.5) => 0.1082757694,
      (s_rel_homeover50_count_d > 3.5) => -0.0259314051,
      (s_rel_homeover50_count_d = NULL) => -0.0007225440, -0.0007225440),
   (s_corrrisktype_i > 7.5) => 
      map(
      (NULL < (real)BT_cen_urban_p and (real)BT_cen_urban_p <= 99.9) => 0.1559923019,
      ((real)BT_cen_urban_p > 99.9) => 0.0241393825,
      ((real)BT_cen_urban_p = NULL) => 0.0764619696, 0.0764619696),
   (s_corrrisktype_i = NULL) => 0.0137356502, 0.0137356502),
(s_add_input_nhood_SFD_pct_d = NULL) => -0.0025890977, -0.0025890977);

// Tree: 485 
final_score_485 := map(
(NULL < b_inq_Other_count24_i and b_inq_Other_count24_i <= 0.5) => 
   map(
   (NULL < b_inq_per_phone_i and b_inq_per_phone_i <= 0.5) => -0.0038433629,
   (b_inq_per_phone_i > 0.5) => 
      map(
      (NULL < s_C20_email_count_i and s_C20_email_count_i <= 0.5) => 
         map(
         (NULL < s_L79_adls_per_addr_curr_i and s_L79_adls_per_addr_curr_i <= 3.5) => 0.0647475603,
         (s_L79_adls_per_addr_curr_i > 3.5) => 0.1488184727,
         (s_L79_adls_per_addr_curr_i = NULL) => 0.0775147762, 0.0775147762),
      (s_C20_email_count_i > 0.5) => 0.0225842560,
      (s_C20_email_count_i = NULL) => -0.0015872579, 0.0317778897),
   (b_inq_per_phone_i = NULL) => 0.1028119061, 0.0080003653),
(b_inq_Other_count24_i > 0.5) => -0.0186096805,
(b_inq_Other_count24_i = NULL) => 0.0100230252, -0.0013296687);

// Tree: 486 
final_score_486 := map(
(NULL < b_mos_liens_rel_OT_lseen_d and b_mos_liens_rel_OT_lseen_d <= 28.5) => 0.0833773286,
(b_mos_liens_rel_OT_lseen_d > 28.5) => -0.0031924632,
(b_mos_liens_rel_OT_lseen_d = NULL) => 
   map(
   (NULL < b_C20_email_verification_d and b_C20_email_verification_d <= 2.5) => 
      map(
      (NULL < (real)BT_cen_pop_0_5_p and (real)BT_cen_pop_0_5_p <= 1.1) => 0.0818425808,
      ((real)BT_cen_pop_0_5_p > 1.1) => -0.0124305807,
      ((real)BT_cen_pop_0_5_p = NULL) => -0.0067369635, -0.0067369635),
   (b_C20_email_verification_d > 2.5) => 
      map(
      (NULL < (real)ST_cen_unemp and (real)ST_cen_unemp <= 4.95) => -0.0250384203,
      ((real)ST_cen_unemp > 4.95) => 0.0875134050,
      ((real)ST_cen_unemp = NULL) => 0.0234595207, 0.0234595207),
   (b_C20_email_verification_d = NULL) => -0.0070791281, -0.0058534263), -0.0034487431);

// Tree: 487 
final_score_487 := map(
(NULL < btst_firstscore_d and btst_firstscore_d <= 28.5) => -0.0265707217,
(btst_firstscore_d > 28.5) => 
   map(
   (NULL < b_curraddrmedianincome_d and b_curraddrmedianincome_d <= 72939.5) => 
      map(
      (NULL < s_A49_Curr_AVM_Chg_1yr_i and s_A49_Curr_AVM_Chg_1yr_i <= 4268) => -0.0179313988,
      (s_A49_Curr_AVM_Chg_1yr_i > 4268) => 0.0629137142,
      (s_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0097392696, 0.0159448989),
   (b_curraddrmedianincome_d > 72939.5) => -0.0081442237,
   (b_curraddrmedianincome_d = NULL) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 224047.5) => -0.0164328490,
      (b_L80_Inp_AVM_AutoVal_d > 224047.5) => 0.0636166989,
      (b_L80_Inp_AVM_AutoVal_d = NULL) => 0.0145771402, 0.0163794458), 0.0048660918),
(btst_firstscore_d = NULL) => -0.0500169211, -0.0058320296);

// Tree: 488 
final_score_488 := map(
(NULL < b_C21_M_Bureau_ADL_FS_d and b_C21_M_Bureau_ADL_FS_d <= 12.5) => -0.0548423971,
(b_C21_M_Bureau_ADL_FS_d > 12.5) => 0.0032457302,
(b_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 27.65) => -0.0179073107,
   ((real)BT_cen_high_ed > 27.65) => 
      map(
      (NULL < (real)BT_cen_low_hval and (real)BT_cen_low_hval <= 11.95) => 
         map(
         (NULL < (real)ST_cen_easiqlife and (real)ST_cen_easiqlife <= 138.5) => -0.0018641832,
         ((real)ST_cen_easiqlife > 138.5) => 0.0516231293,
         ((real)ST_cen_easiqlife = NULL) => 0.0135863966, 0.0135863966),
      ((real)BT_cen_low_hval > 11.95) => 0.1080848930,
      ((real)BT_cen_low_hval = NULL) => 0.0203500926, 0.0203500926),
   ((real)BT_cen_high_ed = NULL) => 0.1065244270, 0.0603819863), 0.0137910769);

// Tree: 489 
final_score_489 := map(
(NULL < s_varrisktype_i and s_varrisktype_i <= 7.5) => -0.0015718278,
(s_varrisktype_i > 7.5) => 0.0966350333,
(s_varrisktype_i = NULL) => 
   map(
   (NULL < b_F03_address_match_d and b_F03_address_match_d <= 3) => -0.0415302683,
   (b_F03_address_match_d > 3) => 
      map(
      (NULL < b_inq_count24_i and b_inq_count24_i <= 2.5) => 
         map(
         (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 31.5) => -0.0040257882,
         (btst_distaddraddr2_i > 31.5) => 0.0945871647,
         (btst_distaddraddr2_i = NULL) => 0.0412095113, 0.0412095113),
      (b_inq_count24_i > 2.5) => -0.0307793358,
      (b_inq_count24_i = NULL) => -0.0107108337, -0.0107108337),
   (b_F03_address_match_d = NULL) => 0.0030212906, -0.0077846943), -0.0024282722);

// Tree: 490 
final_score_490 := map(
(NULL < s_I60_inq_hiRiskCred_recency_d and s_I60_inq_hiRiskCred_recency_d <= 549) => 
   map(
   (NULL < (real)ST_cen_very_rich and (real)ST_cen_very_rich <= 90.5) => 
      map(
      (NULL < b_M_Bureau_ADL_FS_all_d and b_M_Bureau_ADL_FS_all_d <= 208.5) => 0.1381107999,
      (b_M_Bureau_ADL_FS_all_d > 208.5) => 0.0100595467,
      (b_M_Bureau_ADL_FS_all_d = NULL) => 0.0550197645, 0.0550197645),
   ((real)ST_cen_very_rich > 90.5) => 
      map(
      (NULL < b_L80_Inp_AVM_AutoVal_d and b_L80_Inp_AVM_AutoVal_d <= 243391.5) => -0.0433575978,
      (b_L80_Inp_AVM_AutoVal_d > 243391.5) => 0.1239457564,
      (b_L80_Inp_AVM_AutoVal_d = NULL) => -0.0261903727, -0.0066230187),
   ((real)ST_cen_very_rich = NULL) => 0.0122101752, 0.0122101752),
(s_I60_inq_hiRiskCred_recency_d > 549) => -0.0046502677,
(s_I60_inq_hiRiskCred_recency_d = NULL) => -0.0079935247, -0.0044588875);

// Tree: 491 
final_score_491 := map(
(NULL < b_srchunvrfdssncount_i and b_srchunvrfdssncount_i <= 0.5) => -0.0065774179,
(b_srchunvrfdssncount_i > 0.5) => 
   map(
   (NULL < b_curraddractivephonelist_d and b_curraddractivephonelist_d <= 0.5) => 
      map(
      (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 9.1) => 0.2334537845,
      ((real)BT_cen_high_ed > 9.1) => -0.0144412872,
      ((real)BT_cen_high_ed = NULL) => 0.0023537718, 0.0023537718),
   (b_curraddractivephonelist_d > 0.5) => 
      map(
      (NULL < (real)ST_cen_span_lang and (real)ST_cen_span_lang <= 53.5) => 0.1225613989,
      ((real)ST_cen_span_lang > 53.5) => 0.0111312585,
      ((real)ST_cen_span_lang = NULL) => 0.0313912840, 0.0313912840),
   (b_curraddractivephonelist_d = NULL) => 0.0131937891, 0.0131937891),
(b_srchunvrfdssncount_i = NULL) => -0.0018974088, -0.0042261979);

// Tree: 492 
final_score_492 := map(
(NULL < b_varmsrcssnunrelcount_i and b_varmsrcssnunrelcount_i <= 1.5) => -0.0009035480,
(b_varmsrcssnunrelcount_i > 1.5) => 0.0718710671,
(b_varmsrcssnunrelcount_i = NULL) => 
   map(
   (NULL < (real)BT_cen_very_rich and (real)BT_cen_very_rich <= 119.5) => -0.0248408518,
   ((real)BT_cen_very_rich > 119.5) => 
      map(
      (NULL < pf_order_amt_c and pf_order_amt_c <= 661.005) => -0.0377683750,
      (pf_order_amt_c > 661.005) => 
         map(
         (NULL < pf_order_amt_c and pf_order_amt_c <= 902.495) => 0.0880205534,
         (pf_order_amt_c > 902.495) => 0.0168615834,
         (pf_order_amt_c = NULL) => 0.0320215379, 0.0320215379),
      (pf_order_amt_c = NULL) => 0.0050932537, 0.0050932537),
   ((real)BT_cen_very_rich = NULL) => -0.0503103506, -0.0315414576), -0.0067282431);

// Tree: 493 
final_score_493 := map(
(NULL < b_C21_M_Bureau_ADL_FS_d and b_C21_M_Bureau_ADL_FS_d <= 19.5) => -0.0548561770,
(b_C21_M_Bureau_ADL_FS_d > 19.5) => 
   map(
   (pf_ship_method in ['2nd Day','3rd Day','Ground','Next Day']) => 
      map(
      (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
         map(
         (NULL < b_M_Bureau_ADL_FS_all_d and b_M_Bureau_ADL_FS_all_d <= 24.5) => 0.0776674777,
         (b_M_Bureau_ADL_FS_all_d > 24.5) => -0.0039697251,
         (b_M_Bureau_ADL_FS_all_d = NULL) => -0.0034434062, -0.0034434062),
      (final_model_segment in ['CONS ADDR- DIFF    OTH','CONS ADDR+ DIFF    OTH']) => 0.0325314902,
      (final_model_segment = '') => -0.0032381086, -0.0032381086),
   (pf_ship_method in ['Other']) => 0.1610458901,
   (pf_ship_method = '') => -0.0024584210, -0.0024584210),
(b_C21_M_Bureau_ADL_FS_d = NULL) => -0.0004946213, -0.0030543878);

// Tree: 494 
final_score_494 := map(
(NULL < s_add_input_nhood_MFD_pct_i and s_add_input_nhood_MFD_pct_i <= 0.8224896586) => -0.0008448957,
(s_add_input_nhood_MFD_pct_i > 0.8224896586) => 
   map(
   (NULL < s_rel_educationover12_count_d and s_rel_educationover12_count_d <= 1.5) => 0.0959255815,
   (s_rel_educationover12_count_d > 1.5) => 
      map(
      (NULL < b_C21_M_Bureau_ADL_FS_d and b_C21_M_Bureau_ADL_FS_d <= 90.5) => 0.1094927778,
      (b_C21_M_Bureau_ADL_FS_d > 90.5) => 
         map(
         (NULL < b_addrchangeecontrajindex_d and b_addrchangeecontrajindex_d <= 4.5) => -0.0135721034,
         (b_addrchangeecontrajindex_d > 4.5) => 0.1193187749,
         (b_addrchangeecontrajindex_d = NULL) => -0.0394221244, 0.0028133082),
      (b_C21_M_Bureau_ADL_FS_d = NULL) => 0.0156562735, 0.0156562735),
   (s_rel_educationover12_count_d = NULL) => -0.0012692691, 0.0177437872),
(s_add_input_nhood_MFD_pct_i = NULL) => 0.0046165271, 0.0008903315);

// Tree: 495 
final_score_495 := map(
(NULL < (real)BT_cen_families and (real)BT_cen_families <= 2649.5) => 
   map(
   (NULL < s_add_input_nhood_SFD_pct_d and s_add_input_nhood_SFD_pct_d <= 0.99689438) => -0.0051189745,
   (s_add_input_nhood_SFD_pct_d > 0.99689438) => 
      map(
      (NULL < (real)ST_cen_lar_fam and (real)ST_cen_lar_fam <= 67) => 0.1391256263,
      ((real)ST_cen_lar_fam > 67) => 
         map(
         (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    OTH','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS WEB']) => -0.0232721476,
         (final_model_segment in ['CONS ADDR+ ID/RELS OTH']) => 0.1014561537,
         (final_model_segment = '') => -0.0015957192, -0.0015957192),
      ((real)ST_cen_lar_fam = NULL) => 0.0159505833, 0.0159505833),
   (s_add_input_nhood_SFD_pct_d = NULL) => -0.0045343150, -0.0045343150),
((real)BT_cen_families > 2649.5) => 0.0706997553,
((real)BT_cen_families = NULL) => -0.0010750375, -0.0039043864);

// Tree: 496 
final_score_496 := map(
(NULL < s_curraddrmedianincome_d and s_curraddrmedianincome_d <= 189243.5) => 
   map(
   (NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 53.5) => 0.0000687969,
   (btst_distphone2addr2_i > 53.5) => 0.0406052265,
   (btst_distphone2addr2_i = NULL) => -0.0014982896, -0.0003902667),
(s_curraddrmedianincome_d > 189243.5) => 
   map(
   (NULL < b_sourcerisktype_i and b_sourcerisktype_i <= 3.5) => -0.0098990098,
   (b_sourcerisktype_i > 3.5) => 0.1429946041,
   (b_sourcerisktype_i = NULL) => 0.0407409132, 0.0407409132),
(s_curraddrmedianincome_d = NULL) => 
   map(
   (NULL < (real)ST_cen_med_rent and (real)ST_cen_med_rent <= 62.5) => 0.1004928387,
   ((real)ST_cen_med_rent > 62.5) => -0.0032682324,
   ((real)ST_cen_med_rent = NULL) => -0.0582315962, -0.0142207990), -0.0026689518);

// Tree: 497 
final_score_497 := map(
(NULL < b_inq_count24_i and b_inq_count24_i <= 6.5) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 47.5) => 0.0059253829,
   (btst_distaddraddr2_i > 47.5) => 
      map(
      (NULL < (real)ST_cen_business and (real)ST_cen_business <= 34.5) => 
         map(
         (NULL < (real)BT_cen_urban_p and (real)BT_cen_urban_p <= 74.95) => 0.1172783616,
         ((real)BT_cen_urban_p > 74.95) => 0.0389564761,
         ((real)BT_cen_urban_p = NULL) => 0.0510059969, 0.0510059969),
      ((real)ST_cen_business > 34.5) => -0.0052491483,
      ((real)ST_cen_business = NULL) => 0.0245177614, 0.0245177614),
   (btst_distaddraddr2_i = NULL) => 0.0072204034, 0.0072204034),
(b_inq_count24_i > 6.5) => -0.0256147399,
(b_inq_count24_i = NULL) => 0.0000948869, -0.0013531094);

// Tree: 498 
final_score_498 := map(
(NULL < b_P88_Phn_Dst_to_Inp_Add_i and b_P88_Phn_Dst_to_Inp_Add_i <= 1928) => -0.0008426042,
(b_P88_Phn_Dst_to_Inp_Add_i > 1928) => -0.0672795792,
(b_P88_Phn_Dst_to_Inp_Add_i = NULL) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH','CONS ADDR+ ID/RELS WEB']) => 
      map(
      (NULL < s_rel_homeover500_count_d and s_rel_homeover500_count_d <= 11.5) => 0.0010870798,
      (s_rel_homeover500_count_d > 11.5) => 0.0886316716,
      (s_rel_homeover500_count_d = NULL) => 0.0049685371, 0.0036944741),
   (final_model_segment in ['CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH']) => 
      map(
      (pf_avs_result in ['Addr Only','Error/Inval','International','No Match','Zip Only']) => -0.0027541338,
      (pf_avs_result in ['Full Match','Not Supported','Unavailable']) => 0.0612257815,
      (pf_avs_result = '') => 0.0243733503, 0.0243733503),
   (final_model_segment = '') => 0.0041551512, 0.0041551512), 0.0005960704);

// Tree: 499 
final_score_499 := map(
(NULL < b_add_input_mobility_index_i and b_add_input_mobility_index_i <= 0.27454717435) => 
   map(
   (NULL < btst_distaddraddr2_i and btst_distaddraddr2_i <= 19.5) => 0.0077330621,
   (btst_distaddraddr2_i > 19.5) => 
      map(
      (NULL < (real)ST_cen_high_ed and (real)ST_cen_high_ed <= 31.45) => 
         map(
         (NULL < (real)BT_cen_high_ed and (real)BT_cen_high_ed <= 18.25) => 0.1171998128,
         ((real)BT_cen_high_ed > 18.25) => 0.0523352600,
         ((real)BT_cen_high_ed = NULL) => 0.0623564690, 0.0623564690),
      ((real)ST_cen_high_ed > 31.45) => -0.0193593627,
      ((real)ST_cen_high_ed = NULL) => 0.0199889043, 0.0199889043),
   (btst_distaddraddr2_i = NULL) => 0.0091629103, 0.0091629103),
(b_add_input_mobility_index_i > 0.27454717435) => -0.0108750608,
(b_add_input_mobility_index_i = NULL) => -0.0573309601, -0.0023511163);

// Tree: 500 
final_score_500 := map(
(NULL < btst_distphone2addr2_i and btst_distphone2addr2_i <= 1489.5) => 
   map(
   (final_model_segment in ['BUS  ADDR-         OTH','BUS  ADDR-         WEB','BUS  ADDR+         OTH','BUS  ADDR+         WEB','CONS ADDR- DIFF    OTH','CONS ADDR- DIFF    WEB','CONS ADDR- ID/RELS OTH','CONS ADDR- ID/RELS WEB','CONS ADDR- LNAME   OTH','CONS ADDR+ DIFF    OTH','CONS ADDR+ ID/RELS WEB']) => -0.0067916385,
   (final_model_segment in ['CONS ADDR- LNAME   WEB','CONS ADDR+ DIFF    WEB','CONS ADDR+ ID/RELS OTH']) => 
      map(
      (NULL < s_A50_pb_total_dollars_d and s_A50_pb_total_dollars_d <= 1112.5) => -0.0158063266,
      (s_A50_pb_total_dollars_d > 1112.5) => 0.1436722619,
      (s_A50_pb_total_dollars_d = NULL) => 0.0134868723, 0.0339804239),
   (final_model_segment = '') => -0.0017722586, -0.0017722586),
(btst_distphone2addr2_i > 1489.5) => -0.0558247335,
(btst_distphone2addr2_i = NULL) => 
   map(
   (NULL < s_L79_adls_per_addr_c6_i and s_L79_adls_per_addr_c6_i <= 29.5) => -0.0031587060,
   (s_L79_adls_per_addr_c6_i > 29.5) => -0.0503684796,
   (s_L79_adls_per_addr_c6_i = NULL) => -0.0033923733, -0.0033923733), -0.0029947054);

// Final Score Sum 

   final_score := sum(
      final_score_0, final_score_1, final_score_2, final_score_3, final_score_4, 
      final_score_5, final_score_6, final_score_7, final_score_8, final_score_9, 
      final_score_10, final_score_11, final_score_12, final_score_13, final_score_14, 
      final_score_15, final_score_16, final_score_17, final_score_18, final_score_19, 
      final_score_20, final_score_21, final_score_22, final_score_23, final_score_24, 
      final_score_25, final_score_26, final_score_27, final_score_28, final_score_29, 
      final_score_30, final_score_31, final_score_32, final_score_33, final_score_34, 
      final_score_35, final_score_36, final_score_37, final_score_38, final_score_39, 
      final_score_40, final_score_41, final_score_42, final_score_43, final_score_44, 
      final_score_45, final_score_46, final_score_47, final_score_48, final_score_49, 
      final_score_50, final_score_51, final_score_52, final_score_53, final_score_54, 
      final_score_55, final_score_56, final_score_57, final_score_58, final_score_59, 
      final_score_60, final_score_61, final_score_62, final_score_63, final_score_64, 
      final_score_65, final_score_66, final_score_67, final_score_68, final_score_69, 
      final_score_70, final_score_71, final_score_72, final_score_73, final_score_74, 
      final_score_75, final_score_76, final_score_77, final_score_78, final_score_79, 
      final_score_80, final_score_81, final_score_82, final_score_83, final_score_84, 
      final_score_85, final_score_86, final_score_87, final_score_88, final_score_89, 
      final_score_90, final_score_91, final_score_92, final_score_93, final_score_94, 
      final_score_95, final_score_96, final_score_97, final_score_98, final_score_99, 
      final_score_100, final_score_101, final_score_102, final_score_103, final_score_104, 
      final_score_105, final_score_106, final_score_107, final_score_108, final_score_109, 
      final_score_110, final_score_111, final_score_112, final_score_113, final_score_114, 
      final_score_115, final_score_116, final_score_117, final_score_118, final_score_119, 
      final_score_120, final_score_121, final_score_122, final_score_123, final_score_124, 
      final_score_125, final_score_126, final_score_127, final_score_128, final_score_129, 
      final_score_130, final_score_131, final_score_132, final_score_133, final_score_134, 
      final_score_135, final_score_136, final_score_137, final_score_138, final_score_139, 
      final_score_140, final_score_141, final_score_142, final_score_143, final_score_144, 
      final_score_145, final_score_146, final_score_147, final_score_148, final_score_149, 
      final_score_150, final_score_151, final_score_152, final_score_153, final_score_154, 
      final_score_155, final_score_156, final_score_157, final_score_158, final_score_159, 
      final_score_160, final_score_161, final_score_162, final_score_163, final_score_164, 
      final_score_165, final_score_166, final_score_167, final_score_168, final_score_169, 
      final_score_170, final_score_171, final_score_172, final_score_173, final_score_174, 
      final_score_175, final_score_176, final_score_177, final_score_178, final_score_179, 
      final_score_180, final_score_181, final_score_182, final_score_183, final_score_184, 
      final_score_185, final_score_186, final_score_187, final_score_188, final_score_189, 
      final_score_190, final_score_191, final_score_192, final_score_193, final_score_194, 
      final_score_195, final_score_196, final_score_197, final_score_198, final_score_199, 
      final_score_200, final_score_201, final_score_202, final_score_203, final_score_204, 
      final_score_205, final_score_206, final_score_207, final_score_208, final_score_209, 
      final_score_210, final_score_211, final_score_212, final_score_213, final_score_214, 
      final_score_215, final_score_216, final_score_217, final_score_218, final_score_219, 
      final_score_220, final_score_221, final_score_222, final_score_223, final_score_224, 
      final_score_225, final_score_226, final_score_227, final_score_228, final_score_229, 
      final_score_230, final_score_231, final_score_232, final_score_233, final_score_234, 
      final_score_235, final_score_236, final_score_237, final_score_238, final_score_239, 
      final_score_240, final_score_241, final_score_242, final_score_243, final_score_244, 
      final_score_245, final_score_246, final_score_247, final_score_248, final_score_249, 
      final_score_250, final_score_251, final_score_252, final_score_253, final_score_254, 
      final_score_255, final_score_256, final_score_257, final_score_258, final_score_259, 
      final_score_260, final_score_261, final_score_262, final_score_263, final_score_264, 
      final_score_265, final_score_266, final_score_267, final_score_268, final_score_269, 
      final_score_270, final_score_271, final_score_272, final_score_273, final_score_274, 
      final_score_275, final_score_276, final_score_277, final_score_278, final_score_279, 
      final_score_280, final_score_281, final_score_282, final_score_283, final_score_284, 
      final_score_285, final_score_286, final_score_287, final_score_288, final_score_289, 
      final_score_290, final_score_291, final_score_292, final_score_293, final_score_294, 
      final_score_295, final_score_296, final_score_297, final_score_298, final_score_299, 
      final_score_300, final_score_301, final_score_302, final_score_303, final_score_304, 
      final_score_305, final_score_306, final_score_307, final_score_308, final_score_309, 
      final_score_310, final_score_311, final_score_312, final_score_313, final_score_314, 
      final_score_315, final_score_316, final_score_317, final_score_318, final_score_319, 
      final_score_320, final_score_321, final_score_322, final_score_323, final_score_324, 
      final_score_325, final_score_326, final_score_327, final_score_328, final_score_329, 
      final_score_330, final_score_331, final_score_332, final_score_333, final_score_334, 
      final_score_335, final_score_336, final_score_337, final_score_338, final_score_339, 
      final_score_340, final_score_341, final_score_342, final_score_343, final_score_344, 
      final_score_345, final_score_346, final_score_347, final_score_348, final_score_349, 
      final_score_350, final_score_351, final_score_352, final_score_353, final_score_354, 
      final_score_355, final_score_356, final_score_357, final_score_358, final_score_359, 
      final_score_360, final_score_361, final_score_362, final_score_363, final_score_364, 
      final_score_365, final_score_366, final_score_367, final_score_368, final_score_369, 
      final_score_370, final_score_371, final_score_372, final_score_373, final_score_374, 
      final_score_375, final_score_376, final_score_377, final_score_378, final_score_379, 
      final_score_380, final_score_381, final_score_382, final_score_383, final_score_384, 
      final_score_385, final_score_386, final_score_387, final_score_388, final_score_389, 
      final_score_390, final_score_391, final_score_392, final_score_393, final_score_394, 
      final_score_395, final_score_396, final_score_397, final_score_398, final_score_399, 
      final_score_400, final_score_401, final_score_402, final_score_403, final_score_404, 
      final_score_405, final_score_406, final_score_407, final_score_408, final_score_409, 
      final_score_410, final_score_411, final_score_412, final_score_413, final_score_414, 
      final_score_415, final_score_416, final_score_417, final_score_418, final_score_419, 
      final_score_420, final_score_421, final_score_422, final_score_423, final_score_424, 
      final_score_425, final_score_426, final_score_427, final_score_428, final_score_429, 
      final_score_430, final_score_431, final_score_432, final_score_433, final_score_434, 
      final_score_435, final_score_436, final_score_437, final_score_438, final_score_439, 
      final_score_440, final_score_441, final_score_442, final_score_443, final_score_444, 
      final_score_445, final_score_446, final_score_447, final_score_448, final_score_449, 
      final_score_450, final_score_451, final_score_452, final_score_453, final_score_454, 
      final_score_455, final_score_456, final_score_457, final_score_458, final_score_459, 
      final_score_460, final_score_461, final_score_462, final_score_463, final_score_464, 
      final_score_465, final_score_466, final_score_467, final_score_468, final_score_469, 
      final_score_470, final_score_471, final_score_472, final_score_473, final_score_474, 
      final_score_475, final_score_476, final_score_477, final_score_478, final_score_479, 
      final_score_480, final_score_481, final_score_482, final_score_483, final_score_484, 
      final_score_485, final_score_486, final_score_487, final_score_488, final_score_489, 
      final_score_490, final_score_491, final_score_492, final_score_493, final_score_494, 
      final_score_495, final_score_496, final_score_497, final_score_498, final_score_499, 
      final_score_500);

// final_score := 0; //temporary for variable validation
//--------------------------------------------------------------------------------------------------
//  NOTE:  This is the end of the tree code.  
//--------------------------------------------------------------------------------------------------

pbr := 0.011864045;
sbr := 0.014919982;
offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

base := 600;
pts := -30;
lgt := ln(0.0119 / 0.9881);

CDN1508_1_0 := round(max((real)250, min(999, if(base + pts * (final_score - offset - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score - offset - lgt) / ln(2)))));

attr_segment := map(
    final_model_segment = 'BUS  ADDR+         OTH' => 20,
    final_model_segment = 'BUS  ADDR-         OTH' => 21,
    final_model_segment = 'BUS  ADDR+         WEB' => 22,
    final_model_segment = 'BUS  ADDR-         WEB' => 23,
    final_model_segment = 'CONS ADDR+ ID/RELS OTH' => 10,
    final_model_segment = 'CONS ADDR+ DIFF    OTH' => 11,
    final_model_segment = 'CONS ADDR- ID/RELS OTH' => 12,
    final_model_segment = 'CONS ADDR- LNAME   OTH' => 13,
    final_model_segment = 'CONS ADDR- DIFF    OTH' => 14,
    final_model_segment = 'CONS ADDR+ ID/RELS WEB' => 15,
    final_model_segment = 'CONS ADDR+ DIFF    WEB' => 16,
    final_model_segment = 'CONS ADDR- ID/RELS WEB' => 17,
    final_model_segment = 'CONS ADDR- LNAME   WEB' => 18,
                                                      19);
attr_relation := map(
    btst_relatives_lvl_d = '1. BOTH DID 0         ' => 1,
    btst_relatives_lvl_d = '2. BILLTO DID 0       ' => 2,
    btst_relatives_lvl_d = '3. SHIPTO DID 0       ' => 3,
    btst_relatives_lvl_d = '4. DIDS EQUAL         ' => 4,
    btst_relatives_lvl_d = '5. RELATIVES          ' => 5,
    btst_relatives_lvl_d = '6. RELATIVES IN COMMON' => 6,
																											7);

CDN1508_1_0_custom_attribute := 10 * attr_segment + attr_relation;


#if(MODEL_DEBUG)
		/* Model Input Variables */	
SELF.pymtmethod := pay_code_1;
SELF.avscode := avs_response_code;
SELF.cidcode := cid_response_code;
SELF.shipmode := local_ship_code;
SELF.orderamt := order_amt;
SELF.ordertype := us_business_consumer_flag;
SELF.prodcode := base_sku_product_desc;
SELF.channel := acquisition_channel;
SELF.sysdate := sysdate;
SELF.bt_cen_blue_col := bt_cen_blue_col;
SELF.bt_cen_business := bt_cen_business;
SELF.bt_cen_civ_emp := bt_cen_civ_emp;
SELF.bt_cen_easiqlife := bt_cen_easiqlife;
SELF.bt_cen_families := bt_cen_families;
SELF.bt_cen_health := bt_cen_health;
SELF.bt_cen_high_ed := bt_cen_high_ed;
SELF.bt_cen_high_hval := bt_cen_high_hval;
SELF.bt_cen_incollege := bt_cen_incollege;
SELF.bt_cen_lar_fam := bt_cen_lar_fam;
SELF.bt_cen_low_hval := bt_cen_low_hval;
SELF.bt_cen_med_hval := bt_cen_med_hval;
SELF.bt_cen_med_rent := bt_cen_med_rent;
SELF.bt_cen_no_move := bt_cen_no_move;
SELF.bt_cen_ownocc_p := bt_cen_ownocc_p;
SELF.bt_cen_pop_0_5_p := bt_cen_pop_0_5_p;
SELF.bt_cen_rental := bt_cen_rental;
SELF.bt_cen_retired2 := bt_cen_retired2;
SELF.bt_cen_span_lang := bt_cen_span_lang;
SELF.bt_cen_totcrime := bt_cen_totcrime;
SELF.bt_cen_trailer := bt_cen_trailer;
SELF.bt_cen_unemp := bt_cen_unemp;
SELF.bt_cen_urban_p := bt_cen_urban_p;
SELF.bt_cen_vacant_p := bt_cen_vacant_p;
SELF.bt_cen_very_rich := bt_cen_very_rich;
SELF.st_cen_blue_col := st_cen_blue_col;
SELF.st_cen_business := st_cen_business;
SELF.st_cen_civ_emp := st_cen_civ_emp;
SELF.ST_cen_easiqlife := ST_cen_easiqlife;
SELF.st_cen_families := st_cen_families;
SELF.st_cen_health := st_cen_health;
SELF.st_cen_high_ed := st_cen_high_ed;
SELF.st_cen_high_hval := st_cen_high_hval;
SELF.st_cen_incollege := st_cen_incollege;
SELF.st_cen_lar_fam := st_cen_lar_fam;
SELF.st_cen_low_hval := st_cen_low_hval;
SELF.st_cen_med_hhinc := st_cen_med_hhinc;
SELF.st_cen_med_hval := st_cen_med_hval;
SELF.st_cen_med_rent := st_cen_med_rent;
SELF.st_cen_mil_emp := st_cen_mil_emp;
SELF.st_cen_no_move := st_cen_no_move;
SELF.st_cen_ownocc_p := st_cen_ownocc_p;
SELF.st_cen_pop_0_5_p := st_cen_pop_0_5_p;
SELF.st_cen_rental := st_cen_rental;
SELF.st_cen_retired2 := st_cen_retired2;
SELF.st_cen_span_lang := st_cen_span_lang;
SELF.st_cen_totcrime := st_cen_totcrime;
SELF.st_cen_trailer := st_cen_trailer;
SELF.st_cen_unemp := st_cen_unemp;
SELF.ST_cen_urban_p := ST_cen_urban_p;
SELF.st_cen_vacant_p := st_cen_vacant_p;
SELF.st_cen_very_rich := st_cen_very_rich;
SELF._bureau_adl_fseen_en := _bureau_adl_fseen_en;
SELF._bureau_adl_fseen_en_s := _bureau_adl_fseen_en_s;
SELF._bureau_adl_fseen_eq := _bureau_adl_fseen_eq;
SELF._bureau_adl_fseen_eq_s := _bureau_adl_fseen_eq_s;
SELF._bureau_adl_fseen_tn := _bureau_adl_fseen_tn;
SELF._bureau_adl_fseen_tn_s := _bureau_adl_fseen_tn_s;
SELF._bureau_adl_fseen_ts := _bureau_adl_fseen_ts;
SELF._bureau_adl_fseen_ts_s := _bureau_adl_fseen_ts_s;
SELF._bureau_adl_fseen_tu := _bureau_adl_fseen_tu;
SELF._bureau_adl_fseen_tu_s := _bureau_adl_fseen_tu_s;
SELF._bureauonly := _bureauonly;
SELF._bureauonly_s := _bureauonly_s;
SELF._credit_source_cnt := _credit_source_cnt;
SELF._credit_source_cnt_s := _credit_source_cnt_s;
SELF._deceased := _deceased;
SELF._deceased_s := _deceased_s;
SELF._derog := _derog;
SELF._derog_s := _derog_s;
SELF._foreclosure_last_date_s := _foreclosure_last_date_s;
SELF._header_first_seen := _header_first_seen;
SELF._header_first_seen_s := _header_first_seen_s;
SELF._hh_strikes := _hh_strikes;
SELF._hh_strikes_s := _hh_strikes_s;
SELF._in_dob := _in_dob;
SELF._in_dob_s := _in_dob_s;
SELF._inputmiskeys := _inputmiskeys;
SELF._inputmiskeys_s := _inputmiskeys_s;
SELF._liens_rel_ot_last_seen := _liens_rel_ot_last_seen;
SELF._liens_rel_ot_last_seen_s := _liens_rel_ot_last_seen_s;
SELF._liens_unrel_ot_first_seen := _liens_unrel_ot_first_seen;
SELF._liens_unrel_ot_last_seen_s := _liens_unrel_ot_last_seen_s;
SELF._liens_unrel_sc_first_seen_s := _liens_unrel_sc_first_seen_s;
SELF._liens_unrel_st_first_seen := _liens_unrel_st_first_seen;
SELF._liens_unrel_st_last_seen := _liens_unrel_st_last_seen;
SELF._multiplessns := _multiplessns;
SELF._multiplessns_s := _multiplessns_s;
SELF._src_bureau_adl_fseen := _src_bureau_adl_fseen;
SELF._src_bureau_adl_fseen_all := _src_bureau_adl_fseen_all;
SELF._src_bureau_adl_fseen_notu := _src_bureau_adl_fseen_notu;
SELF._src_bureau_adl_fseen_notu_s := _src_bureau_adl_fseen_notu_s;
SELF._src_bureau_adl_fseen_s := _src_bureau_adl_fseen_s;
SELF._ssnpriortodob := _ssnpriortodob;
SELF._ssnpriortodob_s := _ssnpriortodob_s;
SELF._ver_src_cnt := _ver_src_cnt;
SELF._ver_src_cnt_s := _ver_src_cnt_s;
SELF._ver_src_de := _ver_src_de;
SELF._ver_src_de_s := _ver_src_de_s;
SELF._ver_src_ds := _ver_src_ds;
SELF._ver_src_ds_s := _ver_src_ds_s;
SELF._ver_src_en := _ver_src_en;
SELF._ver_src_en_s := _ver_src_en_s;
SELF._ver_src_eq := _ver_src_eq;
SELF._ver_src_eq_s := _ver_src_eq_s;
SELF._ver_src_tn := _ver_src_tn;
SELF._ver_src_tn_s := _ver_src_tn_s;
SELF._ver_src_tu := _ver_src_tu;
SELF._ver_src_tu_s := _ver_src_tu_s;
SELF.add_curr_nhood_prop_sum := add_curr_nhood_prop_sum;
SELF.add_curr_nhood_prop_sum_s := add_curr_nhood_prop_sum_s;
SELF.add_ec1_s := add_ec1_s;
SELF.add_ec3_s := add_ec3_s;
SELF.add_ec4_s := add_ec4_s;
SELF.add_input_nhood_prop_sum := add_input_nhood_prop_sum;
SELF.add_input_nhood_prop_sum_s := add_input_nhood_prop_sum_s;
SELF.addr_match := addr_match;
SELF.b_a46_curr_avm_autoval_d := b_a46_curr_avm_autoval_d;
SELF.b_a49_curr_avm_chg_1yr_i := b_a49_curr_avm_chg_1yr_i;
SELF.b_a49_curr_avm_chg_1yr_pct_i := b_a49_curr_avm_chg_1yr_pct_i;
SELF.b_a50_pb_average_dollars_d := b_a50_pb_average_dollars_d;
SELF.b_a50_pb_total_dollars_d := b_a50_pb_total_dollars_d;
SELF.b_a50_pb_total_orders_d := b_a50_pb_total_orders_d;
SELF.b_add_curr_mobility_index_i := b_add_curr_mobility_index_i;
SELF.b_add_curr_nhood_bus_pct_i := b_add_curr_nhood_bus_pct_i;
SELF.b_add_curr_nhood_mfd_pct_i := b_add_curr_nhood_mfd_pct_i;
SELF.b_add_curr_nhood_sfd_pct_d := b_add_curr_nhood_sfd_pct_d;
SELF.b_add_curr_nhood_vac_pct_i := b_add_curr_nhood_vac_pct_i;
SELF.b_add_input_mobility_index_i := b_add_input_mobility_index_i;
SELF.b_add_input_nhood_bus_pct_i := b_add_input_nhood_bus_pct_i;
SELF.b_add_input_nhood_mfd_pct_i := b_add_input_nhood_mfd_pct_i;
SELF.b_add_input_nhood_sfd_pct_d := b_add_input_nhood_sfd_pct_d;
SELF.b_add_input_nhood_vac_pct_i := b_add_input_nhood_vac_pct_i;
SELF.b_addrchangecrimediff_i := b_addrchangecrimediff_i;
SELF.b_addrchangeecontrajindex_d := b_addrchangeecontrajindex_d;
SELF.b_addrchangeincomediff_d := b_addrchangeincomediff_d;
SELF.b_addrchangevaluediff_d := b_addrchangevaluediff_d;
SELF.b_adl_per_email_i := b_adl_per_email_i;
SELF.b_bus_name_nover_i := b_bus_name_nover_i;
SELF.b_bus_phone_match_d := b_bus_phone_match_d;
SELF.b_c10_m_hdr_fs_d := b_c10_m_hdr_fs_d;
SELF.b_c12_source_profile_d := b_c12_source_profile_d;
SELF.b_c13_curr_addr_lres_d := b_c13_curr_addr_lres_d;
SELF.b_c13_max_lres_d := b_c13_max_lres_d;
SELF.b_c14_addr_stability_v2_d := b_c14_addr_stability_v2_d;
SELF.b_c14_addrs_10yr_i := b_c14_addrs_10yr_i;
SELF.b_c14_addrs_15yr_i := b_c14_addrs_15yr_i;
SELF.b_c14_addrs_5yr_i := b_c14_addrs_5yr_i;
SELF.b_c18_invalid_addrs_per_adl_i := b_c18_invalid_addrs_per_adl_i;
SELF.b_c20_email_count_i := b_c20_email_count_i;
SELF.b_c20_email_verification_d := b_c20_email_verification_d;
SELF.b_c21_m_bureau_adl_fs_d := b_c21_m_bureau_adl_fs_d;
SELF.b_c23_inp_addr_occ_index_d := b_c23_inp_addr_occ_index_d;
SELF.b_comb_age_d := b_comb_age_d;
SELF.b_componentcharrisktype_i := b_componentcharrisktype_i;
SELF.b_corrphonelastnamecount_d := b_corrphonelastnamecount_d;
SELF.b_crim_rel_under100miles_cnt_i := b_crim_rel_under100miles_cnt_i;
SELF.b_curraddractivephonelist_d := b_curraddractivephonelist_d;
SELF.b_curraddrburglaryindex_i := b_curraddrburglaryindex_i;
SELF.b_curraddrcrimeindex_i := b_curraddrcrimeindex_i;
SELF.b_curraddrmedianincome_d := b_curraddrmedianincome_d;
SELF.b_curraddrmedianvalue_d := b_curraddrmedianvalue_d;
SELF.b_curraddrmurderindex_i := b_curraddrmurderindex_i;
SELF.b_d31_bk_disposed_hist_count_i := b_d31_bk_disposed_hist_count_i;
SELF.b_divaddrsuspidcountnew_i := b_divaddrsuspidcountnew_i;
SELF.b_divrisktype_i := b_divrisktype_i;
SELF.b_divsrchaddrsuspidcount_i := b_divsrchaddrsuspidcount_i;
SELF.b_e57_br_source_count_d := b_e57_br_source_count_d;
SELF.b_estimated_income_d := b_estimated_income_d;
SELF.b_f01_inp_addr_address_score_d := b_f01_inp_addr_address_score_d;
SELF.b_f03_address_match_d := b_f03_address_match_d;
SELF.b_f04_curr_add_occ_index_d := b_f04_curr_add_occ_index_d;
SELF.b_fp_prevaddrburglaryindex_i := b_fp_prevaddrburglaryindex_i;
SELF.b_fp_prevaddrcrimeindex_i := b_fp_prevaddrcrimeindex_i;
SELF.b_hh_age_18_plus_d := b_hh_age_18_plus_d;
SELF.b_hh_age_30_plus_d := b_hh_age_30_plus_d;
SELF.b_hh_age_65_plus_d := b_hh_age_65_plus_d;
SELF.b_hh_bankruptcies_i := b_hh_bankruptcies_i;
SELF.b_hh_members_ct_d := b_hh_members_ct_d;
SELF.b_i60_inq_auto_recency_d := b_i60_inq_auto_recency_d;
SELF.b_i60_inq_count12_i := b_i60_inq_count12_i;
SELF.b_i60_inq_mortgage_recency_d := b_i60_inq_mortgage_recency_d;
SELF.b_i60_inq_recency_d := b_i60_inq_recency_d;
SELF.b_i60_inq_retail_recency_d := b_i60_inq_retail_recency_d;
SELF.b_i60_inq_retpymt_recency_d := b_i60_inq_retpymt_recency_d;
SELF.b_i61_inq_collection_count12_i := b_i61_inq_collection_count12_i;
SELF.b_inq_adls_per_addr_i := b_inq_adls_per_addr_i;
SELF.b_inq_adls_per_phone_i := b_inq_adls_per_phone_i;
SELF.b_inq_collection_count24_i := b_inq_collection_count24_i;
SELF.b_inq_count24_i := b_inq_count24_i;
SELF.b_inq_highriskcredit_count24_i := b_inq_highriskcredit_count24_i;
SELF.b_inq_lnames_per_addr_i := b_inq_lnames_per_addr_i;
SELF.b_inq_other_count24_i := b_inq_other_count24_i;
SELF.b_inq_per_addr_i := b_inq_per_addr_i;
SELF.b_inq_per_phone_i := b_inq_per_phone_i;
SELF.b_inq_retail_count_week_i := b_inq_retail_count_week_i;
SELF.b_inq_retail_count24_i := b_inq_retail_count24_i;
SELF.b_inq_ssns_per_addr_i := b_inq_ssns_per_addr_i;
SELF.b_l71_add_business_i := b_l71_add_business_i;
SELF.b_l75_add_drop_delivery_i := b_l75_add_drop_delivery_i;
SELF.b_l79_adls_per_addr_c6_i := b_l79_adls_per_addr_c6_i;
SELF.b_l79_adls_per_addr_curr_i := b_l79_adls_per_addr_curr_i;
SELF.b_l80_inp_avm_autoval_d := b_l80_inp_avm_autoval_d;
SELF.b_liens_rel_ot_total_amt_i := b_liens_rel_ot_total_amt_i;
SELF.b_liens_unrel_st_total_amt_i := b_liens_unrel_st_total_amt_i;
SELF.b_m_bureau_adl_fs_all_d := b_m_bureau_adl_fs_all_d;
SELF.b_m_bureau_adl_fs_notu_d := b_m_bureau_adl_fs_notu_d;
SELF.b_mos_liens_rel_ot_lseen_d := b_mos_liens_rel_ot_lseen_d;
SELF.b_mos_liens_unrel_ot_fseen_d := b_mos_liens_unrel_ot_fseen_d;
SELF.b_mos_liens_unrel_st_fseen_d := b_mos_liens_unrel_st_fseen_d;
SELF.b_mos_liens_unrel_st_lseen_d := b_mos_liens_unrel_st_lseen_d;
SELF.b_nap_contradictory_i := b_nap_contradictory_i;
SELF.b_nap_phn_verd_d := b_nap_phn_verd_d;
SELF.b_p85_phn_invalid_i := b_p85_phn_invalid_i;
SELF.b_p85_phn_not_issued_i := b_p85_phn_not_issued_i;
SELF.b_p88_phn_dst_to_inp_add_i := b_p88_phn_dst_to_inp_add_i;
SELF.b_pb_order_freq_d := b_pb_order_freq_d;
SELF.b_phone_ver_experian_d := b_phone_ver_experian_d;
SELF.b_phone_ver_insurance_d := b_phone_ver_insurance_d;
SELF.b_phones_per_addr_c6_i := b_phones_per_addr_c6_i;
SELF.b_phones_per_addr_curr_i := b_phones_per_addr_curr_i;
SELF.b_prevaddrageoldest_d := b_prevaddrageoldest_d;
SELF.b_prevaddrlenofres_d := b_prevaddrlenofres_d;
SELF.b_prevaddrmedianincome_d := b_prevaddrmedianincome_d;
SELF.b_prevaddrmedianvalue_d := b_prevaddrmedianvalue_d;
SELF.b_prevaddrmurderindex_i := b_prevaddrmurderindex_i;
SELF.b_property_owners_ct_d := b_property_owners_ct_d;
SELF.b_rel_ageover30_count_d := b_rel_ageover30_count_d;
SELF.b_rel_ageover40_count_d := b_rel_ageover40_count_d;
SELF.b_rel_count_i := b_rel_count_i;
SELF.b_rel_educationover12_count_d := b_rel_educationover12_count_d;
SELF.b_rel_felony_count_i := b_rel_felony_count_i;
SELF.b_rel_homeover300_count_d := b_rel_homeover300_count_d;
SELF.b_rel_homeover50_count_d := b_rel_homeover50_count_d;
SELF.b_rel_homeover500_count_d := b_rel_homeover500_count_d;
SELF.b_rel_incomeover100_count_d := b_rel_incomeover100_count_d;
SELF.b_rel_incomeover25_count_d := b_rel_incomeover25_count_d;
SELF.b_rel_incomeover50_count_d := b_rel_incomeover50_count_d;
SELF.b_rel_incomeover75_count_d := b_rel_incomeover75_count_d;
SELF.b_rel_under100miles_cnt_d := b_rel_under100miles_cnt_d;
SELF.b_sourcerisktype_i := b_sourcerisktype_i;
SELF.b_srchaddrsrchcountmo_i := b_srchaddrsrchcountmo_i;
SELF.b_srchaddrsrchcountwk_i := b_srchaddrsrchcountwk_i;
SELF.b_srchcountwk_i := b_srchcountwk_i;
SELF.b_srchunvrfdphonecount_i := b_srchunvrfdphonecount_i;
SELF.b_srchunvrfdssncount_i := b_srchunvrfdssncount_i;
SELF.b_srchvelocityrisktype_i := b_srchvelocityrisktype_i;
SELF.b_util_add_input_conv_n := b_util_add_input_conv_n;
SELF.b_util_add_input_inf_n := b_util_add_input_inf_n;
SELF.b_vardobcountnew_i := b_vardobcountnew_i;
SELF.b_varmsrcssncount_i := b_varmsrcssncount_i;
SELF.b_varmsrcssnunrelcount_i := b_varmsrcssnunrelcount_i;
SELF.b_varrisktype_i := b_varrisktype_i;
SELF.bf_seg_fraudpoint_3_0 := bf_seg_fraudpoint_3_0;
SELF.bs_segment2 := bs_segment2;
SELF.btst_are_relatives := btst_are_relatives;
SELF.btst_distaddraddr2_i := btst_distaddraddr2_i;
SELF.btst_distphone2addr2_i := btst_distphone2addr2_i;
SELF.btst_distphoneaddr_i := btst_distphoneaddr_i;
SELF.btst_distphoneaddr2_i := btst_distphoneaddr2_i;
SELF.btst_email_last_score_d := btst_email_last_score_d;
SELF.btst_email_topleveldomain_n := btst_email_topleveldomain_n;
SELF.btst_firstscore_d := btst_firstscore_d;
SELF.btst_lastscore_d := btst_lastscore_d;
SELF.btst_relatives_in_common := btst_relatives_in_common;
SELF.btst_relatives_lvl_d := btst_relatives_lvl_d;
SELF.bureau_adl_en_fseen_pos := bureau_adl_en_fseen_pos;
SELF.bureau_adl_en_fseen_pos_s := bureau_adl_en_fseen_pos_s;
SELF.bureau_adl_eq_fseen_pos := bureau_adl_eq_fseen_pos;
SELF.bureau_adl_eq_fseen_pos_s := bureau_adl_eq_fseen_pos_s;
SELF.bureau_adl_fseen_en := bureau_adl_fseen_en;
SELF.bureau_adl_fseen_en_s := bureau_adl_fseen_en_s;
SELF.bureau_adl_fseen_eq := bureau_adl_fseen_eq;
SELF.bureau_adl_fseen_eq_s := bureau_adl_fseen_eq_s;
SELF.bureau_adl_fseen_tn := bureau_adl_fseen_tn;
SELF.bureau_adl_fseen_tn_s := bureau_adl_fseen_tn_s;
SELF.bureau_adl_fseen_ts := bureau_adl_fseen_ts;
SELF.bureau_adl_fseen_ts_s := bureau_adl_fseen_ts_s;
SELF.bureau_adl_fseen_tu := bureau_adl_fseen_tu;
SELF.bureau_adl_fseen_tu_s := bureau_adl_fseen_tu_s;
SELF.bureau_adl_tn_fseen_pos := bureau_adl_tn_fseen_pos;
SELF.bureau_adl_tn_fseen_pos_s := bureau_adl_tn_fseen_pos_s;
SELF.bureau_adl_ts_fseen_pos := bureau_adl_ts_fseen_pos;
SELF.bureau_adl_ts_fseen_pos_s := bureau_adl_ts_fseen_pos_s;
SELF.bureau_adl_tu_fseen_pos := bureau_adl_tu_fseen_pos;
SELF.bureau_adl_tu_fseen_pos_s := bureau_adl_tu_fseen_pos_s;
SELF.dell_segmentation2 := dell_segmentation2;
SELF.dell_segmentation3 := dell_segmentation3;
SELF.did_match := did_match;
SELF.email_topleveldomain := email_topleveldomain;
SELF.final_model_segment := final_model_segment;
SELF.fname_match := fname_match;
SELF.lname_match := lname_match;
SELF.pf_acquisition_channel := pf_acquisition_channel;
SELF.pf_avs_addr := pf_avs_addr;
SELF.pf_avs_error := pf_avs_error;
SELF.pf_avs_intl := pf_avs_intl;
SELF.pf_avs_invalid := pf_avs_invalid;
SELF.pf_avs_name := pf_avs_name;
SELF.pf_avs_no_match := pf_avs_no_match;
SELF.pf_avs_not_supp := pf_avs_not_supp;
SELF.pf_avs_result := pf_avs_result;
SELF.pf_avs_unavail := pf_avs_unavail;
SELF.pf_avs_zip := pf_avs_zip;
SELF.pf_business_flag := pf_business_flag;
SELF.pf_cid_result := pf_cid_result;
SELF.pf_order_amt_c := pf_order_amt_c;
SELF.pf_pmt_type := pf_pmt_type;
SELF.pf_pmt_x_avs_lvl := pf_pmt_x_avs_lvl;
SELF.pf_product_desc := pf_product_desc;
SELF.pf_ship_method := pf_ship_method;
SELF.s_a41_prop_owner_d := s_a41_prop_owner_d;
SELF.s_a46_curr_avm_autoval_d := s_a46_curr_avm_autoval_d;
SELF.s_a49_curr_avm_chg_1yr_i := s_a49_curr_avm_chg_1yr_i;
SELF.s_a50_pb_average_dollars_d := s_a50_pb_average_dollars_d;
SELF.s_a50_pb_total_dollars_d := s_a50_pb_total_dollars_d;
SELF.s_a50_pb_total_orders_d := s_a50_pb_total_orders_d;
SELF.s_add_curr_mobility_index_i := s_add_curr_mobility_index_i;
SELF.s_add_curr_nhood_bus_pct_i := s_add_curr_nhood_bus_pct_i;
SELF.s_add_curr_nhood_mfd_pct_i := s_add_curr_nhood_mfd_pct_i;
SELF.s_add_curr_nhood_sfd_pct_d := s_add_curr_nhood_sfd_pct_d;
SELF.s_add_curr_nhood_vac_pct_i := s_add_curr_nhood_vac_pct_i;
SELF.s_add_input_mobility_index_i := s_add_input_mobility_index_i;
SELF.s_add_input_nhood_bus_pct_i := s_add_input_nhood_bus_pct_i;
SELF.s_add_input_nhood_mfd_pct_i := s_add_input_nhood_mfd_pct_i;
SELF.s_add_input_nhood_sfd_pct_d := s_add_input_nhood_sfd_pct_d;
SELF.s_add_input_nhood_vac_pct_i := s_add_input_nhood_vac_pct_i;
SELF.s_addrchangecrimediff_i := s_addrchangecrimediff_i;
SELF.s_addrchangeecontrajindex_d := s_addrchangeecontrajindex_d;
SELF.s_addrchangeincomediff_d := s_addrchangeincomediff_d;
SELF.s_addrchangevaluediff_d := s_addrchangevaluediff_d;
SELF.s_assoccredbureaucount_i := s_assoccredbureaucount_i;
SELF.s_assocrisktype_i := s_assocrisktype_i;
SELF.s_assocsuspicousidcount_i := s_assocsuspicousidcount_i;
SELF.s_bus_name_nover_i := s_bus_name_nover_i;
SELF.s_bus_phone_match_d := s_bus_phone_match_d;
SELF.s_c10_m_hdr_fs_d := s_c10_m_hdr_fs_d;
SELF.s_c12_nonderog_recency_i := s_c12_nonderog_recency_i;
SELF.s_c12_source_profile_d := s_c12_source_profile_d;
SELF.s_c12_source_profile_index_d := s_c12_source_profile_index_d;
SELF.s_c13_curr_addr_lres_d := s_c13_curr_addr_lres_d;
SELF.s_c14_addrs_10yr_i := s_c14_addrs_10yr_i;
SELF.s_c14_addrs_15yr_i := s_c14_addrs_15yr_i;
SELF.s_c17_inv_phn_per_adl_i := s_c17_inv_phn_per_adl_i;
SELF.s_c18_inv_add_per_adl_c6_i := s_c18_inv_add_per_adl_c6_i;
SELF.s_c18_invalid_addrs_per_adl_i := s_c18_invalid_addrs_per_adl_i;
SELF.s_c20_email_count_i := s_c20_email_count_i;
SELF.s_c20_email_verification_d := s_c20_email_verification_d;
SELF.s_c21_m_bureau_adl_fs_d := s_c21_m_bureau_adl_fs_d;
SELF.s_comb_age_d := s_comb_age_d;
SELF.s_corrrisktype_i := s_corrrisktype_i;
SELF.s_curraddrburglaryindex_i := s_curraddrburglaryindex_i;
SELF.s_curraddrcartheftindex_i := s_curraddrcartheftindex_i;
SELF.s_curraddrcrimeindex_i := s_curraddrcrimeindex_i;
SELF.s_curraddrmedianincome_d := s_curraddrmedianincome_d;
SELF.s_curraddrmedianvalue_d := s_curraddrmedianvalue_d;
SELF.s_curraddrmurderindex_i := s_curraddrmurderindex_i;
SELF.s_d34_unrel_liens_ct_i := s_d34_unrel_liens_ct_i;
SELF.s_divaddrsuspidcountnew_i := s_divaddrsuspidcountnew_i;
SELF.s_e57_br_source_count_d := s_e57_br_source_count_d;
SELF.s_estimated_income_d := s_estimated_income_d;
SELF.s_f01_inp_addr_address_score_d := s_f01_inp_addr_address_score_d;
SELF.s_fp_prevaddrburglaryindex_i := s_fp_prevaddrburglaryindex_i;
SELF.s_fp_prevaddrcrimeindex_i := s_fp_prevaddrcrimeindex_i;
SELF.s_has_pb_record_d := s_has_pb_record_d;
SELF.s_hh_age_30_plus_d := s_hh_age_30_plus_d;
SELF.s_hh_collections_ct_i := s_hh_collections_ct_i;
SELF.s_i60_credit_seeking_i := s_i60_credit_seeking_i;
SELF.s_i60_inq_auto_count12_i := s_i60_inq_auto_count12_i;
SELF.s_i60_inq_comm_recency_d := s_i60_inq_comm_recency_d;
SELF.s_i60_inq_count12_i := s_i60_inq_count12_i;
SELF.s_i60_inq_hiriskcred_count12_i := s_i60_inq_hiriskcred_count12_i;
SELF.s_i60_inq_hiriskcred_recency_d := s_i60_inq_hiriskcred_recency_d;
SELF.s_i60_inq_prepaidcards_recency_d := s_i60_inq_prepaidcards_recency_d;
SELF.s_i60_inq_recency_d := s_i60_inq_recency_d;
SELF.s_i60_inq_retail_recency_d := s_i60_inq_retail_recency_d;
SELF.s_i61_inq_collection_count12_i := s_i61_inq_collection_count12_i;
SELF.s_idrisktype_i := s_idrisktype_i;
SELF.s_inf_contradictory_i := s_inf_contradictory_i;
SELF.s_inq_adls_per_addr_i := s_inq_adls_per_addr_i;
SELF.s_inq_adls_per_phone_i := s_inq_adls_per_phone_i;
SELF.s_inq_communications_count24_i := s_inq_communications_count24_i;
SELF.s_inq_count24_i := s_inq_count24_i;
SELF.s_inq_highriskcredit_count24_i := s_inq_highriskcredit_count24_i;
SELF.s_inq_lnames_per_addr_i := s_inq_lnames_per_addr_i;
SELF.s_inq_per_addr_i := s_inq_per_addr_i;
SELF.s_inq_per_phone_i := s_inq_per_phone_i;
SELF.s_inq_ssns_per_addr_i := s_inq_ssns_per_addr_i;
SELF.s_l70_add_invalid_i := s_l70_add_invalid_i;
SELF.s_l70_add_standardized_i := s_l70_add_standardized_i;
SELF.s_l71_add_business_i := s_l71_add_business_i;
SELF.s_l79_adls_per_addr_c6_i := s_l79_adls_per_addr_c6_i;
SELF.s_l79_adls_per_addr_curr_i := s_l79_adls_per_addr_curr_i;
SELF.s_l80_inp_avm_autoval_d := s_l80_inp_avm_autoval_d;
SELF.s_liens_rel_ot_total_amt_i := s_liens_rel_ot_total_amt_i;
SELF.s_liens_unrel_st_total_amt_i := s_liens_unrel_st_total_amt_i;
SELF.s_m_bureau_adl_fs_notu_d := s_m_bureau_adl_fs_notu_d;
SELF.s_mos_foreclosure_lseen_d := s_mos_foreclosure_lseen_d;
SELF.s_mos_liens_rel_ot_lseen_d := s_mos_liens_rel_ot_lseen_d;
SELF.s_mos_liens_unrel_ot_lseen_d := s_mos_liens_unrel_ot_lseen_d;
SELF.s_mos_liens_unrel_sc_fseen_d := s_mos_liens_unrel_sc_fseen_d;
SELF.s_nap_addr_verd_d := s_nap_addr_verd_d;
SELF.s_nap_contradictory_i := s_nap_contradictory_i;
SELF.s_nap_lname_verd_d := s_nap_lname_verd_d;
SELF.s_nap_nothing_found_i := s_nap_nothing_found_i;
SELF.s_nap_phn_verd_d := s_nap_phn_verd_d;
SELF.s_p85_phn_invalid_i := s_p85_phn_invalid_i;
SELF.s_p85_phn_not_issued_i := s_p85_phn_not_issued_i;
SELF.s_p88_phn_dst_to_inp_add_i := s_p88_phn_dst_to_inp_add_i;
SELF.s_pb_order_freq_d := s_pb_order_freq_d;
SELF.s_phone_ver_experian_d := s_phone_ver_experian_d;
SELF.s_phone_ver_insurance_d := s_phone_ver_insurance_d;
SELF.s_phones_per_addr_c6_i := s_phones_per_addr_c6_i;
SELF.s_prevaddrageoldest_d := s_prevaddrageoldest_d;
SELF.s_prevaddrcartheftindex_i := s_prevaddrcartheftindex_i;
SELF.s_prevaddrlenofres_d := s_prevaddrlenofres_d;
SELF.s_prevaddrmedianvalue_d := s_prevaddrmedianvalue_d;
SELF.s_prevaddrmurderindex_i := s_prevaddrmurderindex_i;
SELF.s_prevaddrstatus_i := s_prevaddrstatus_i;
SELF.s_recent_disconnects_i := s_recent_disconnects_i;
SELF.s_rel_ageover40_count_d := s_rel_ageover40_count_d;
SELF.s_rel_count_i := s_rel_count_i;
SELF.s_rel_criminal_count_i := s_rel_criminal_count_i;
SELF.s_rel_educationover12_count_d := s_rel_educationover12_count_d;
SELF.s_rel_felony_count_i := s_rel_felony_count_i;
SELF.s_rel_homeover300_count_d := s_rel_homeover300_count_d;
SELF.s_rel_homeover50_count_d := s_rel_homeover50_count_d;
SELF.s_rel_homeover500_count_d := s_rel_homeover500_count_d;
SELF.s_rel_incomeover50_count_d := s_rel_incomeover50_count_d;
SELF.s_rel_incomeover75_count_d := s_rel_incomeover75_count_d;
SELF.s_rel_under100miles_cnt_d := s_rel_under100miles_cnt_d;
SELF.s_rel_under25miles_cnt_d := s_rel_under25miles_cnt_d;
SELF.s_rel_under500miles_cnt_d := s_rel_under500miles_cnt_d;
SELF.s_srchaddrsrchcountmo_i := s_srchaddrsrchcountmo_i;
SELF.s_srchaddrsrchcountwk_i := s_srchaddrsrchcountwk_i;
SELF.s_srchcomponentrisktype_i := s_srchcomponentrisktype_i;
SELF.s_srchphonesrchcountwk_i := s_srchphonesrchcountwk_i;
SELF.s_srchunvrfdaddrcount_i := s_srchunvrfdaddrcount_i;
SELF.s_srchvelocityrisktype_i := s_srchvelocityrisktype_i;
SELF.s_util_add_input_conv_n := s_util_add_input_conv_n;
SELF.s_util_add_input_inf_n := s_util_add_input_inf_n;
SELF.s_util_add_input_misc_n := s_util_add_input_misc_n;
SELF.s_util_adl_count_n := s_util_adl_count_n;
SELF.s_validationrisktype_i := s_validationrisktype_i;
SELF.s_varmsrcssnunrelcount_i := s_varmsrcssnunrelcount_i;
SELF.s_varrisktype_i := s_varrisktype_i;
SELF.sf_seg_fraudpoint_3_0 := sf_seg_fraudpoint_3_0;
SELF.yr_in_dob := yr_in_dob;
SELF.yr_in_dob_int := yr_in_dob_int;
SELF.yr_in_dob_int_s := yr_in_dob_int_s;
SELF.yr_in_dob_s := yr_in_dob_s;
SELF.final_score_0 := final_score_0;
SELF.final_score_1 := final_score_1;
SELF.final_score_2 := final_score_2;
SELF.final_score_3 := final_score_3;
SELF.final_score_4 := final_score_4;
SELF.final_score_5 := final_score_5;
SELF.final_score_6 := final_score_6;
SELF.final_score_7 := final_score_7;
SELF.final_score_8 := final_score_8;
SELF.final_score_9 := final_score_9;
SELF.final_score_10 := final_score_10;
SELF.final_score_11 := final_score_11;
SELF.final_score_12 := final_score_12;
SELF.final_score_13 := final_score_13;
SELF.final_score_14 := final_score_14;
SELF.final_score_15 := final_score_15;
SELF.final_score_16 := final_score_16;
SELF.final_score_17 := final_score_17;
SELF.final_score_18 := final_score_18;
SELF.final_score_19 := final_score_19;
SELF.final_score_20 := final_score_20;
SELF.final_score_21 := final_score_21;
SELF.final_score_22 := final_score_22;
SELF.final_score_23 := final_score_23;
SELF.final_score_24 := final_score_24;
SELF.final_score_25 := final_score_25;
SELF.final_score_26 := final_score_26;
SELF.final_score_27 := final_score_27;
SELF.final_score_28 := final_score_28;
SELF.final_score_29 := final_score_29;
SELF.final_score_30 := final_score_30;
SELF.final_score_31 := final_score_31;
SELF.final_score_32 := final_score_32;
SELF.final_score_33 := final_score_33;
SELF.final_score_34 := final_score_34;
SELF.final_score_35 := final_score_35;
SELF.final_score_36 := final_score_36;
SELF.final_score_37 := final_score_37;
SELF.final_score_38 := final_score_38;
SELF.final_score_39 := final_score_39;
SELF.final_score_40 := final_score_40;
SELF.final_score_41 := final_score_41;
SELF.final_score_42 := final_score_42;
SELF.final_score_43 := final_score_43;
SELF.final_score_44 := final_score_44;
SELF.final_score_45 := final_score_45;
SELF.final_score_46 := final_score_46;
SELF.final_score_47 := final_score_47;
SELF.final_score_48 := final_score_48;
SELF.final_score_49 := final_score_49;
SELF.final_score_50 := final_score_50;
SELF.final_score_51 := final_score_51;
SELF.final_score_52 := final_score_52;
SELF.final_score_53 := final_score_53;
SELF.final_score_54 := final_score_54;
SELF.final_score_55 := final_score_55;
SELF.final_score_56 := final_score_56;
SELF.final_score_57 := final_score_57;
SELF.final_score_58 := final_score_58;
SELF.final_score_59 := final_score_59;
SELF.final_score_60 := final_score_60;
SELF.final_score_61 := final_score_61;
SELF.final_score_62 := final_score_62;
SELF.final_score_63 := final_score_63;
SELF.final_score_64 := final_score_64;
SELF.final_score_65 := final_score_65;
SELF.final_score_66 := final_score_66;
SELF.final_score_67 := final_score_67;
SELF.final_score_68 := final_score_68;
SELF.final_score_69 := final_score_69;
SELF.final_score_70 := final_score_70;
SELF.final_score_71 := final_score_71;
SELF.final_score_72 := final_score_72;
SELF.final_score_73 := final_score_73;
SELF.final_score_74 := final_score_74;
SELF.final_score_75 := final_score_75;
SELF.final_score_76 := final_score_76;
SELF.final_score_77 := final_score_77;
SELF.final_score_78 := final_score_78;
SELF.final_score_79 := final_score_79;
SELF.final_score_80 := final_score_80;
SELF.final_score_81 := final_score_81;
SELF.final_score_82 := final_score_82;
SELF.final_score_83 := final_score_83;
SELF.final_score_84 := final_score_84;
SELF.final_score_85 := final_score_85;
SELF.final_score_86 := final_score_86;
SELF.final_score_87 := final_score_87;
SELF.final_score_88 := final_score_88;
SELF.final_score_89 := final_score_89;
SELF.final_score_90 := final_score_90;
SELF.final_score_91 := final_score_91;
SELF.final_score_92 := final_score_92;
SELF.final_score_93 := final_score_93;
SELF.final_score_94 := final_score_94;
SELF.final_score_95 := final_score_95;
SELF.final_score_96 := final_score_96;
SELF.final_score_97 := final_score_97;
SELF.final_score_98 := final_score_98;
SELF.final_score_99 := final_score_99;
SELF.final_score_100 := final_score_100;
SELF.final_score_101 := final_score_101;
SELF.final_score_102 := final_score_102;
SELF.final_score_103 := final_score_103;
SELF.final_score_104 := final_score_104;
SELF.final_score_105 := final_score_105;
SELF.final_score_106 := final_score_106;
SELF.final_score_107 := final_score_107;
SELF.final_score_108 := final_score_108;
SELF.final_score_109 := final_score_109;
SELF.final_score_110 := final_score_110;
SELF.final_score_111 := final_score_111;
SELF.final_score_112 := final_score_112;
SELF.final_score_113 := final_score_113;
SELF.final_score_114 := final_score_114;
SELF.final_score_115 := final_score_115;
SELF.final_score_116 := final_score_116;
SELF.final_score_117 := final_score_117;
SELF.final_score_118 := final_score_118;
SELF.final_score_119 := final_score_119;
SELF.final_score_120 := final_score_120;
SELF.final_score_121 := final_score_121;
SELF.final_score_122 := final_score_122;
SELF.final_score_123 := final_score_123;
SELF.final_score_124 := final_score_124;
SELF.final_score_125 := final_score_125;
SELF.final_score_126 := final_score_126;
SELF.final_score_127 := final_score_127;
SELF.final_score_128 := final_score_128;
SELF.final_score_129 := final_score_129;
SELF.final_score_130 := final_score_130;
SELF.final_score_131 := final_score_131;
SELF.final_score_132 := final_score_132;
SELF.final_score_133 := final_score_133;
SELF.final_score_134 := final_score_134;
SELF.final_score_135 := final_score_135;
SELF.final_score_136 := final_score_136;
SELF.final_score_137 := final_score_137;
SELF.final_score_138 := final_score_138;
SELF.final_score_139 := final_score_139;
SELF.final_score_140 := final_score_140;
SELF.final_score_141 := final_score_141;
SELF.final_score_142 := final_score_142;
SELF.final_score_143 := final_score_143;
SELF.final_score_144 := final_score_144;
SELF.final_score_145 := final_score_145;
SELF.final_score_146 := final_score_146;
SELF.final_score_147 := final_score_147;
SELF.final_score_148 := final_score_148;
SELF.final_score_149 := final_score_149;
SELF.final_score_150 := final_score_150;
SELF.final_score_151 := final_score_151;
SELF.final_score_152 := final_score_152;
SELF.final_score_153 := final_score_153;
SELF.final_score_154 := final_score_154;
SELF.final_score_155 := final_score_155;
SELF.final_score_156 := final_score_156;
SELF.final_score_157 := final_score_157;
SELF.final_score_158 := final_score_158;
SELF.final_score_159 := final_score_159;
SELF.final_score_160 := final_score_160;
SELF.final_score_161 := final_score_161;
SELF.final_score_162 := final_score_162;
SELF.final_score_163 := final_score_163;
SELF.final_score_164 := final_score_164;
SELF.final_score_165 := final_score_165;
SELF.final_score_166 := final_score_166;
SELF.final_score_167 := final_score_167;
SELF.final_score_168 := final_score_168;
SELF.final_score_169 := final_score_169;
SELF.final_score_170 := final_score_170;
SELF.final_score_171 := final_score_171;
SELF.final_score_172 := final_score_172;
SELF.final_score_173 := final_score_173;
SELF.final_score_174 := final_score_174;
SELF.final_score_175 := final_score_175;
SELF.final_score_176 := final_score_176;
SELF.final_score_177 := final_score_177;
SELF.final_score_178 := final_score_178;
SELF.final_score_179 := final_score_179;
SELF.final_score_180 := final_score_180;
SELF.final_score_181 := final_score_181;
SELF.final_score_182 := final_score_182;
SELF.final_score_183 := final_score_183;
SELF.final_score_184 := final_score_184;
SELF.final_score_185 := final_score_185;
SELF.final_score_186 := final_score_186;
SELF.final_score_187 := final_score_187;
SELF.final_score_188 := final_score_188;
SELF.final_score_189 := final_score_189;
SELF.final_score_190 := final_score_190;
SELF.final_score_191 := final_score_191;
SELF.final_score_192 := final_score_192;
SELF.final_score_193 := final_score_193;
SELF.final_score_194 := final_score_194;
SELF.final_score_195 := final_score_195;
SELF.final_score_196 := final_score_196;
SELF.final_score_197 := final_score_197;
SELF.final_score_198 := final_score_198;
SELF.final_score_199 := final_score_199;
SELF.final_score_200 := final_score_200;
SELF.final_score_201 := final_score_201;
SELF.final_score_202 := final_score_202;
SELF.final_score_203 := final_score_203;
SELF.final_score_204 := final_score_204;
SELF.final_score_205 := final_score_205;
SELF.final_score_206 := final_score_206;
SELF.final_score_207 := final_score_207;
SELF.final_score_208 := final_score_208;
SELF.final_score_209 := final_score_209;
SELF.final_score_210 := final_score_210;
SELF.final_score_211 := final_score_211;
SELF.final_score_212 := final_score_212;
SELF.final_score_213 := final_score_213;
SELF.final_score_214 := final_score_214;
SELF.final_score_215 := final_score_215;
SELF.final_score_216 := final_score_216;
SELF.final_score_217 := final_score_217;
SELF.final_score_218 := final_score_218;
SELF.final_score_219 := final_score_219;
SELF.final_score_220 := final_score_220;
SELF.final_score_221 := final_score_221;
SELF.final_score_222 := final_score_222;
SELF.final_score_223 := final_score_223;
SELF.final_score_224 := final_score_224;
SELF.final_score_225 := final_score_225;
SELF.final_score_226 := final_score_226;
SELF.final_score_227 := final_score_227;
SELF.final_score_228 := final_score_228;
SELF.final_score_229 := final_score_229;
SELF.final_score_230 := final_score_230;
SELF.final_score_231 := final_score_231;
SELF.final_score_232 := final_score_232;
SELF.final_score_233 := final_score_233;
SELF.final_score_234 := final_score_234;
SELF.final_score_235 := final_score_235;
SELF.final_score_236 := final_score_236;
SELF.final_score_237 := final_score_237;
SELF.final_score_238 := final_score_238;
SELF.final_score_239 := final_score_239;
SELF.final_score_240 := final_score_240;
SELF.final_score_241 := final_score_241;
SELF.final_score_242 := final_score_242;
SELF.final_score_243 := final_score_243;
SELF.final_score_244 := final_score_244;
SELF.final_score_245 := final_score_245;
SELF.final_score_246 := final_score_246;
SELF.final_score_247 := final_score_247;
SELF.final_score_248 := final_score_248;
SELF.final_score_249 := final_score_249;
SELF.final_score_250 := final_score_250;
SELF.final_score_251 := final_score_251;
SELF.final_score_252 := final_score_252;
SELF.final_score_253 := final_score_253;
SELF.final_score_254 := final_score_254;
SELF.final_score_255 := final_score_255;
SELF.final_score_256 := final_score_256;
SELF.final_score_257 := final_score_257;
SELF.final_score_258 := final_score_258;
SELF.final_score_259 := final_score_259;
SELF.final_score_260 := final_score_260;
SELF.final_score_261 := final_score_261;
SELF.final_score_262 := final_score_262;
SELF.final_score_263 := final_score_263;
SELF.final_score_264 := final_score_264;
SELF.final_score_265 := final_score_265;
SELF.final_score_266 := final_score_266;
SELF.final_score_267 := final_score_267;
SELF.final_score_268 := final_score_268;
SELF.final_score_269 := final_score_269;
SELF.final_score_270 := final_score_270;
SELF.final_score_271 := final_score_271;
SELF.final_score_272 := final_score_272;
SELF.final_score_273 := final_score_273;
SELF.final_score_274 := final_score_274;
SELF.final_score_275 := final_score_275;
SELF.final_score_276 := final_score_276;
SELF.final_score_277 := final_score_277;
SELF.final_score_278 := final_score_278;
SELF.final_score_279 := final_score_279;
SELF.final_score_280 := final_score_280;
SELF.final_score_281 := final_score_281;
SELF.final_score_282 := final_score_282;
SELF.final_score_283 := final_score_283;
SELF.final_score_284 := final_score_284;
SELF.final_score_285 := final_score_285;
SELF.final_score_286 := final_score_286;
SELF.final_score_287 := final_score_287;
SELF.final_score_288 := final_score_288;
SELF.final_score_289 := final_score_289;
SELF.final_score_290 := final_score_290;
SELF.final_score_291 := final_score_291;
SELF.final_score_292 := final_score_292;
SELF.final_score_293 := final_score_293;
SELF.final_score_294 := final_score_294;
SELF.final_score_295 := final_score_295;
SELF.final_score_296 := final_score_296;
SELF.final_score_297 := final_score_297;
SELF.final_score_298 := final_score_298;
SELF.final_score_299 := final_score_299;
SELF.final_score_300 := final_score_300;
SELF.final_score_301 := final_score_301;
SELF.final_score_302 := final_score_302;
SELF.final_score_303 := final_score_303;
SELF.final_score_304 := final_score_304;
SELF.final_score_305 := final_score_305;
SELF.final_score_306 := final_score_306;
SELF.final_score_307 := final_score_307;
SELF.final_score_308 := final_score_308;
SELF.final_score_309 := final_score_309;
SELF.final_score_310 := final_score_310;
SELF.final_score_311 := final_score_311;
SELF.final_score_312 := final_score_312;
SELF.final_score_313 := final_score_313;
SELF.final_score_314 := final_score_314;
SELF.final_score_315 := final_score_315;
SELF.final_score_316 := final_score_316;
SELF.final_score_317 := final_score_317;
SELF.final_score_318 := final_score_318;
SELF.final_score_319 := final_score_319;
SELF.final_score_320 := final_score_320;
SELF.final_score_321 := final_score_321;
SELF.final_score_322 := final_score_322;
SELF.final_score_323 := final_score_323;
SELF.final_score_324 := final_score_324;
SELF.final_score_325 := final_score_325;
SELF.final_score_326 := final_score_326;
SELF.final_score_327 := final_score_327;
SELF.final_score_328 := final_score_328;
SELF.final_score_329 := final_score_329;
SELF.final_score_330 := final_score_330;
SELF.final_score_331 := final_score_331;
SELF.final_score_332 := final_score_332;
SELF.final_score_333 := final_score_333;
SELF.final_score_334 := final_score_334;
SELF.final_score_335 := final_score_335;
SELF.final_score_336 := final_score_336;
SELF.final_score_337 := final_score_337;
SELF.final_score_338 := final_score_338;
SELF.final_score_339 := final_score_339;
SELF.final_score_340 := final_score_340;
SELF.final_score_341 := final_score_341;
SELF.final_score_342 := final_score_342;
SELF.final_score_343 := final_score_343;
SELF.final_score_344 := final_score_344;
SELF.final_score_345 := final_score_345;
SELF.final_score_346 := final_score_346;
SELF.final_score_347 := final_score_347;
SELF.final_score_348 := final_score_348;
SELF.final_score_349 := final_score_349;
SELF.final_score_350 := final_score_350;
SELF.final_score_351 := final_score_351;
SELF.final_score_352 := final_score_352;
SELF.final_score_353 := final_score_353;
SELF.final_score_354 := final_score_354;
SELF.final_score_355 := final_score_355;
SELF.final_score_356 := final_score_356;
SELF.final_score_357 := final_score_357;
SELF.final_score_358 := final_score_358;
SELF.final_score_359 := final_score_359;
SELF.final_score_360 := final_score_360;
SELF.final_score_361 := final_score_361;
SELF.final_score_362 := final_score_362;
SELF.final_score_363 := final_score_363;
SELF.final_score_364 := final_score_364;
SELF.final_score_365 := final_score_365;
SELF.final_score_366 := final_score_366;
SELF.final_score_367 := final_score_367;
SELF.final_score_368 := final_score_368;
SELF.final_score_369 := final_score_369;
SELF.final_score_370 := final_score_370;
SELF.final_score_371 := final_score_371;
SELF.final_score_372 := final_score_372;
SELF.final_score_373 := final_score_373;
SELF.final_score_374 := final_score_374;
SELF.final_score_375 := final_score_375;
SELF.final_score_376 := final_score_376;
SELF.final_score_377 := final_score_377;
SELF.final_score_378 := final_score_378;
SELF.final_score_379 := final_score_379;
SELF.final_score_380 := final_score_380;
SELF.final_score_381 := final_score_381;
SELF.final_score_382 := final_score_382;
SELF.final_score_383 := final_score_383;
SELF.final_score_384 := final_score_384;
SELF.final_score_385 := final_score_385;
SELF.final_score_386 := final_score_386;
SELF.final_score_387 := final_score_387;
SELF.final_score_388 := final_score_388;
SELF.final_score_389 := final_score_389;
SELF.final_score_390 := final_score_390;
SELF.final_score_391 := final_score_391;
SELF.final_score_392 := final_score_392;
SELF.final_score_393 := final_score_393;
SELF.final_score_394 := final_score_394;
SELF.final_score_395 := final_score_395;
SELF.final_score_396 := final_score_396;
SELF.final_score_397 := final_score_397;
SELF.final_score_398 := final_score_398;
SELF.final_score_399 := final_score_399;
SELF.final_score_400 := final_score_400;
SELF.final_score_401 := final_score_401;
SELF.final_score_402 := final_score_402;
SELF.final_score_403 := final_score_403;
SELF.final_score_404 := final_score_404;
SELF.final_score_405 := final_score_405;
SELF.final_score_406 := final_score_406;
SELF.final_score_407 := final_score_407;
SELF.final_score_408 := final_score_408;
SELF.final_score_409 := final_score_409;
SELF.final_score_410 := final_score_410;
SELF.final_score_411 := final_score_411;
SELF.final_score_412 := final_score_412;
SELF.final_score_413 := final_score_413;
SELF.final_score_414 := final_score_414;
SELF.final_score_415 := final_score_415;
SELF.final_score_416 := final_score_416;
SELF.final_score_417 := final_score_417;
SELF.final_score_418 := final_score_418;
SELF.final_score_419 := final_score_419;
SELF.final_score_420 := final_score_420;
SELF.final_score_421 := final_score_421;
SELF.final_score_422 := final_score_422;
SELF.final_score_423 := final_score_423;
SELF.final_score_424 := final_score_424;
SELF.final_score_425 := final_score_425;
SELF.final_score_426 := final_score_426;
SELF.final_score_427 := final_score_427;
SELF.final_score_428 := final_score_428;
SELF.final_score_429 := final_score_429;
SELF.final_score_430 := final_score_430;
SELF.final_score_431 := final_score_431;
SELF.final_score_432 := final_score_432;
SELF.final_score_433 := final_score_433;
SELF.final_score_434 := final_score_434;
SELF.final_score_435 := final_score_435;
SELF.final_score_436 := final_score_436;
SELF.final_score_437 := final_score_437;
SELF.final_score_438 := final_score_438;
SELF.final_score_439 := final_score_439;
SELF.final_score_440 := final_score_440;
SELF.final_score_441 := final_score_441;
SELF.final_score_442 := final_score_442;
SELF.final_score_443 := final_score_443;
SELF.final_score_444 := final_score_444;
SELF.final_score_445 := final_score_445;
SELF.final_score_446 := final_score_446;
SELF.final_score_447 := final_score_447;
SELF.final_score_448 := final_score_448;
SELF.final_score_449 := final_score_449;
SELF.final_score_450 := final_score_450;
SELF.final_score_451 := final_score_451;
SELF.final_score_452 := final_score_452;
SELF.final_score_453 := final_score_453;
SELF.final_score_454 := final_score_454;
SELF.final_score_455 := final_score_455;
SELF.final_score_456 := final_score_456;
SELF.final_score_457 := final_score_457;
SELF.final_score_458 := final_score_458;
SELF.final_score_459 := final_score_459;
SELF.final_score_460 := final_score_460;
SELF.final_score_461 := final_score_461;
SELF.final_score_462 := final_score_462;
SELF.final_score_463 := final_score_463;
SELF.final_score_464 := final_score_464;
SELF.final_score_465 := final_score_465;
SELF.final_score_466 := final_score_466;
SELF.final_score_467 := final_score_467;
SELF.final_score_468 := final_score_468;
SELF.final_score_469 := final_score_469;
SELF.final_score_470 := final_score_470;
SELF.final_score_471 := final_score_471;
SELF.final_score_472 := final_score_472;
SELF.final_score_473 := final_score_473;
SELF.final_score_474 := final_score_474;
SELF.final_score_475 := final_score_475;
SELF.final_score_476 := final_score_476;
SELF.final_score_477 := final_score_477;
SELF.final_score_478 := final_score_478;
SELF.final_score_479 := final_score_479;
SELF.final_score_480 := final_score_480;
SELF.final_score_481 := final_score_481;
SELF.final_score_482 := final_score_482;
SELF.final_score_483 := final_score_483;
SELF.final_score_484 := final_score_484;
SELF.final_score_485 := final_score_485;
SELF.final_score_486 := final_score_486;
SELF.final_score_487 := final_score_487;
SELF.final_score_488 := final_score_488;
SELF.final_score_489 := final_score_489;
SELF.final_score_490 := final_score_490;
SELF.final_score_491 := final_score_491;
SELF.final_score_492 := final_score_492;
SELF.final_score_493 := final_score_493;
SELF.final_score_494 := final_score_494;
SELF.final_score_495 := final_score_495;
SELF.final_score_496 := final_score_496;
SELF.final_score_497 := final_score_497;
SELF.final_score_498 := final_score_498;
SELF.final_score_499 := final_score_499;
SELF.final_score_500 := final_score_500;
SELF.final_score := final_score;
SELF.pbr := pbr;
SELF.sbr := sbr;
SELF.offset := offset;
SELF.base := base;
SELF.pts := pts;
SELF.lgt := lgt;
SELF.CDN1508_1_0 := CDN1508_1_0;
SELF.attr_segment := attr_segment;
SELF.attr_relation := attr_relation;
SELF.CDN1508_1_0_custom_attribute := CDN1508_1_0_custom_attribute;

		SELF.rc1 := '';
		SELF.rc2 := '';
		SELF.rc3 := '';
		SELF.rc4 := '';
		
		self.seq := le.bs.bill_to_out.seq;//le.cd2i.seq;
		SELF.clam := le.BS;
		
/* Added for extra output variables */
SELF.addrscore := addrscore;
SELF.firstscore := firstscore;
SELF.lastscore := lastscore;
SELF.elastscore := elastscore;
SELF.distphoneaddr := distphoneaddr;
SELF.distphone2addr2 := distphone2addr2;
SELF.distphoneaddr2 := distphoneaddr2;
SELF.distaddraddr2 := distaddraddr2;
SELF.did := did;
SELF.truedid := truedid;
SELF.in_dob := in_dob;
SELF.in_email_address := in_email_address;
SELF.nas_summary := nas_summary;
SELF.nap_summary := nap_summary;
SELF.nap_type := nap_type;
SELF.rc_ssndod := rc_ssndod;
SELF.rc_phonevalflag := rc_phonevalflag;
SELF.rc_hphonevalflag := rc_hphonevalflag;
SELF.rc_pwphonezipflag := rc_pwphonezipflag;
SELF.rc_decsflag := rc_decsflag;
SELF.rc_ssndobflag := rc_ssndobflag;
SELF.rc_pwssndobflag := rc_pwssndobflag;
SELF.rc_ssnmiskeyflag := rc_ssnmiskeyflag;
SELF.rc_addrmiskeyflag := rc_addrmiskeyflag;
SELF.rc_disthphoneaddr := rc_disthphoneaddr;
SELF.rc_phonetype := rc_phonetype;
SELF.hdr_source_profile := hdr_source_profile;
SELF.ver_sources := ver_sources;
SELF.ver_sources_first_seen := ver_sources_first_seen;
SELF.bus_name_match := bus_name_match;
SELF.bus_phone_match := bus_phone_match;
SELF.fnamepop := fnamepop;
SELF.lnamepop := lnamepop;
SELF.addrpop := addrpop;
SELF.ssnlength := ssnlength;
SELF.emailpop := emailpop;
SELF.hphnpop := hphnpop;
SELF.util_add_input_type_list := util_add_input_type_list;
SELF.add_input_address_score := add_input_address_score;
SELF.add_input_house_number_match := add_input_house_number_match;
SELF.add_input_isbestmatch := add_input_isbestmatch;
SELF.add_input_occ_index := add_input_occ_index;
SELF.add_input_advo_res_or_bus := add_input_advo_res_or_bus;
SELF.add_input_avm_auto_val := add_input_avm_auto_val;
SELF.add_input_occupants_1yr := add_input_occupants_1yr;
SELF.add_input_turnover_1yr_in := add_input_turnover_1yr_in;
SELF.add_input_turnover_1yr_out := add_input_turnover_1yr_out;
SELF.add_input_nhood_vac_prop := add_input_nhood_vac_prop;
SELF.add_input_nhood_bus_ct := add_input_nhood_bus_ct;
SELF.add_input_nhood_sfd_ct := add_input_nhood_sfd_ct;
SELF.add_input_nhood_mfd_ct := add_input_nhood_mfd_ct;
SELF.add_input_pop := add_input_pop;
SELF.add_curr_isbestmatch := add_curr_isbestmatch;
SELF.add_curr_lres := add_curr_lres;
SELF.add_curr_occ_index := add_curr_occ_index;
SELF.add_curr_avm_auto_val := add_curr_avm_auto_val;
SELF.add_curr_avm_auto_val_2 := add_curr_avm_auto_val_2;
SELF.add_curr_occupants_1yr := add_curr_occupants_1yr;
SELF.add_curr_turnover_1yr_in := add_curr_turnover_1yr_in;
SELF.add_curr_turnover_1yr_out := add_curr_turnover_1yr_out;
SELF.add_curr_nhood_vac_prop := add_curr_nhood_vac_prop;
SELF.add_curr_nhood_bus_ct := add_curr_nhood_bus_ct;
SELF.add_curr_nhood_sfd_ct := add_curr_nhood_sfd_ct;
SELF.add_curr_nhood_mfd_ct := add_curr_nhood_mfd_ct;
SELF.add_curr_pop := add_curr_pop;
SELF.max_lres := max_lres;
SELF.addrs_5yr := addrs_5yr;
SELF.addrs_10yr := addrs_10yr;
SELF.addrs_15yr := addrs_15yr;
SELF.addrs_prison_history := addrs_prison_history;
SELF.phone_ver_insurance := phone_ver_insurance;
SELF.phone_ver_experian := phone_ver_experian;
SELF.header_first_seen := header_first_seen;
SELF.ssns_per_adl := ssns_per_adl;
SELF.adls_per_addr_curr := adls_per_addr_curr;
SELF.phones_per_addr_curr := phones_per_addr_curr;
SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
SELF.lnames_per_adl_c6 := lnames_per_adl_c6;
SELF.adls_per_addr_c6 := adls_per_addr_c6;
SELF.phones_per_addr_c6 := phones_per_addr_c6;
SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
SELF.invalid_addrs_per_adl := invalid_addrs_per_adl;
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
SELF.inq_collection_count12 := inq_collection_count12;
SELF.inq_collection_count24 := inq_collection_count24;
SELF.inq_highriskcredit_count12 := inq_highriskcredit_count12;
SELF.inq_highriskcredit_count24 := inq_highriskcredit_count24;
SELF.inq_mortgage_count := inq_mortgage_count;
SELF.inq_mortgage_count01 := inq_mortgage_count01;
SELF.inq_mortgage_count03 := inq_mortgage_count03;
SELF.inq_mortgage_count06 := inq_mortgage_count06;
SELF.inq_mortgage_count12 := inq_mortgage_count12;
SELF.inq_mortgage_count24 := inq_mortgage_count24;
SELF.inq_other_count24 := inq_other_count24;
SELF.inq_retail_count := inq_retail_count;
SELF.inq_retail_count01 := inq_retail_count01;
SELF.inq_retail_count03 := inq_retail_count03;
SELF.inq_retail_count06 := inq_retail_count06;
SELF.inq_retail_count12 := inq_retail_count12;
SELF.inq_retail_count24 := inq_retail_count24;
SELF.inq_retailpayments_count := inq_retailpayments_count;
SELF.inq_retailpayments_count24 := inq_retailpayments_count24;
SELF.inq_peraddr := inq_peraddr;
SELF.inq_adlsperaddr := inq_adlsperaddr;
SELF.inq_lnamesperaddr := inq_lnamesperaddr;
SELF.inq_ssnsperaddr := inq_ssnsperaddr;
SELF.inq_perphone := inq_perphone;
SELF.inq_adlsperphone := inq_adlsperphone;
SELF.pb_number_of_sources := pb_number_of_sources;
SELF.pb_average_days_bt_orders := pb_average_days_bt_orders;
SELF.pb_average_dollars := pb_average_dollars;
SELF.pb_total_dollars := pb_total_dollars;
SELF.pb_total_orders := pb_total_orders;
SELF.br_source_count := br_source_count;
SELF.stl_inq_count := stl_inq_count;
SELF.email_count := email_count;
SELF.email_verification := email_verification;
SELF.adl_per_email := adl_per_email;
SELF.attr_num_unrel_liens60 := attr_num_unrel_liens60;
SELF.attr_eviction_count := attr_eviction_count;
SELF.fp_sourcerisktype := fp_sourcerisktype;
SELF.fp_varrisktype := fp_varrisktype;
SELF.fp_varmsrcssncount := fp_varmsrcssncount;
SELF.fp_vardobcountnew := fp_vardobcountnew;
SELF.fp_srchvelocityrisktype := fp_srchvelocityrisktype;
SELF.fp_srchcountwk := fp_srchcountwk;
SELF.fp_srchunvrfdssncount := fp_srchunvrfdssncount;
SELF.fp_srchunvrfdphonecount := fp_srchunvrfdphonecount;
SELF.fp_srchfraudsrchcountyr := fp_srchfraudsrchcountyr;
SELF.fp_corrphonelastnamecount := fp_corrphonelastnamecount;
SELF.fp_divrisktype := fp_divrisktype;
SELF.fp_divaddrsuspidcountnew := fp_divaddrsuspidcountnew;
SELF.fp_srchssnsrchcountmo := fp_srchssnsrchcountmo;
SELF.fp_srchaddrsrchcountmo := fp_srchaddrsrchcountmo;
SELF.fp_srchphonesrchcountmo := fp_srchphonesrchcountmo;
SELF.fp_componentcharrisktype := fp_componentcharrisktype;
SELF.fp_addrchangeincomediff := fp_addrchangeincomediff;
SELF.fp_addrchangevaluediff := fp_addrchangevaluediff;
SELF.fp_addrchangecrimediff := fp_addrchangecrimediff;
SELF.fp_addrchangeecontrajindex := fp_addrchangeecontrajindex;
SELF.fp_curraddractivephonelist := fp_curraddractivephonelist;
SELF.fp_curraddrmedianincome := fp_curraddrmedianincome;
SELF.fp_curraddrmedianvalue := fp_curraddrmedianvalue;
SELF.fp_curraddrmurderindex := fp_curraddrmurderindex;
SELF.fp_curraddrburglaryindex := fp_curraddrburglaryindex;
SELF.fp_curraddrcrimeindex := fp_curraddrcrimeindex;
SELF.fp_prevaddrageoldest := fp_prevaddrageoldest;
SELF.fp_prevaddrlenofres := fp_prevaddrlenofres;
SELF.fp_prevaddrmedianincome := fp_prevaddrmedianincome;
SELF.fp_prevaddrmedianvalue := fp_prevaddrmedianvalue;
SELF.fp_prevaddrmurderindex := fp_prevaddrmurderindex;
SELF.fp_prevaddrburglaryindex := fp_prevaddrburglaryindex;
SELF.fp_prevaddrcrimeindex := fp_prevaddrcrimeindex;
SELF.liens_unrel_ot_first_seen := liens_unrel_ot_first_seen;
SELF.liens_rel_ot_last_seen := liens_rel_ot_last_seen;
SELF.liens_rel_ot_total_amount := liens_rel_ot_total_amount;
SELF.liens_unrel_st_total_amount := liens_unrel_st_total_amount;
SELF.felony_count := felony_count;
SELF.hh_members_ct := hh_members_ct;
SELF.hh_property_owners_ct := hh_property_owners_ct;
SELF.hh_age_65_plus := hh_age_65_plus;
SELF.hh_age_30_to_65 := hh_age_30_to_65;
SELF.hh_age_18_to_30 := hh_age_18_to_30;
SELF.hh_payday_loan_users := hh_payday_loan_users;
SELF.hh_members_w_derog := hh_members_w_derog;
SELF.hh_bankruptcies := hh_bankruptcies;
SELF.hh_criminals := hh_criminals;
SELF.rel_count := rel_count;
SELF.rel_felony_count := rel_felony_count;
SELF.crim_rel_within25miles := crim_rel_within25miles;
SELF.crim_rel_within100miles := crim_rel_within100miles;
SELF.rel_within25miles_count := rel_within25miles_count;
SELF.rel_within100miles_count := rel_within100miles_count;
SELF.rel_incomeunder50_count := rel_incomeunder50_count;
SELF.rel_incomeunder75_count := rel_incomeunder75_count;
SELF.rel_incomeunder100_count := rel_incomeunder100_count;
SELF.rel_incomeover100_count := rel_incomeover100_count;
SELF.rel_homeunder100_count := rel_homeunder100_count;
SELF.rel_homeunder150_count := rel_homeunder150_count;
SELF.rel_homeunder200_count := rel_homeunder200_count;
SELF.rel_homeunder300_count := rel_homeunder300_count;
SELF.rel_homeunder500_count := rel_homeunder500_count;
SELF.rel_homeover500_count := rel_homeover500_count;
SELF.rel_educationover12_count := rel_educationover12_count;
SELF.rel_ageunder40_count := rel_ageunder40_count;
SELF.rel_ageunder50_count := rel_ageunder50_count;
SELF.rel_ageunder60_count := rel_ageunder60_count;
SELF.rel_ageunder70_count := rel_ageunder70_count;
SELF.rel_ageover70_count := rel_ageover70_count;
SELF.inferred_age := inferred_age;
SELF.addr_stability_v2 := addr_stability_v2;
SELF.estimated_income := estimated_income;
SELF.did_s := did_s;
SELF.truedid_s := truedid_s;
SELF.out_addr_status_s := out_addr_status_s;
SELF.in_dob_s := in_dob_s;
SELF.nas_summary_s := nas_summary_s;
SELF.nap_summary_s := nap_summary_s;
SELF.nap_type_s := nap_type_s;
SELF.rc_ssndod_s := rc_ssndod_s;
SELF.rc_pwphonezipflag_s := rc_pwphonezipflag_s;
SELF.rc_decsflag_s := rc_decsflag_s;
SELF.rc_ssndobflag_s := rc_ssndobflag_s;
SELF.rc_pwssndobflag_s := rc_pwssndobflag_s;
SELF.rc_addrvalflag_s := rc_addrvalflag_s;
SELF.rc_ssnmiskeyflag_s := rc_ssnmiskeyflag_s;
SELF.rc_addrmiskeyflag_s := rc_addrmiskeyflag_s;
SELF.rc_disthphoneaddr_s := rc_disthphoneaddr_s;
SELF.hdr_source_profile_s := hdr_source_profile_s;
SELF.hdr_source_profile_index_s := hdr_source_profile_index_s;
SELF.ver_sources_s := ver_sources_s;
SELF.ver_sources_first_seen_s := ver_sources_first_seen_s;
SELF.bus_name_match_s := bus_name_match_s;
SELF.bus_phone_match_s := bus_phone_match_s;
SELF.fnamepop_s := fnamepop_s;
SELF.lnamepop_s := lnamepop_s;
SELF.addrpop_s := addrpop_s;
SELF.ssnlength_s := ssnlength_s;
SELF.hphnpop_s := hphnpop_s;
SELF.util_adl_count_s := util_adl_count_s;
SELF.util_add_input_type_list_s := util_add_input_type_list_s;
SELF.add_input_address_score_s := add_input_address_score_s;
SELF.add_input_house_number_match_s := add_input_house_number_match_s;
SELF.add_input_advo_res_or_bus_s := add_input_advo_res_or_bus_s;
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
SELF.add_curr_nhood_vac_prop_s := add_curr_nhood_vac_prop_s;
SELF.add_curr_nhood_bus_ct_s := add_curr_nhood_bus_ct_s;
SELF.add_curr_nhood_sfd_ct_s := add_curr_nhood_sfd_ct_s;
SELF.add_curr_nhood_mfd_ct_s := add_curr_nhood_mfd_ct_s;
SELF.add_curr_pop_s := add_curr_pop_s;
SELF.add_prev_naprop_s := add_prev_naprop_s;
SELF.addrs_10yr_s := addrs_10yr_s;
SELF.addrs_15yr_s := addrs_15yr_s;
SELF.addrs_prison_history_s := addrs_prison_history_s;
SELF.phone_ver_insurance_s := phone_ver_insurance_s;
SELF.phone_ver_experian_s := phone_ver_experian_s;
SELF.header_first_seen_s := header_first_seen_s;
SELF.ssns_per_adl_s := ssns_per_adl_s;
SELF.adls_per_addr_curr_s := adls_per_addr_curr_s;
SELF.ssns_per_adl_c6_s := ssns_per_adl_c6_s;
SELF.lnames_per_adl_c6_s := lnames_per_adl_c6_s;
SELF.adls_per_addr_c6_s := adls_per_addr_c6_s;
SELF.phones_per_addr_c6_s := phones_per_addr_c6_s;
SELF.invalid_ssns_per_adl_s := invalid_ssns_per_adl_s;
SELF.invalid_addrs_per_adl_s := invalid_addrs_per_adl_s;
SELF.inq_count_s := inq_count_s;
SELF.inq_count01_s := inq_count01_s;
SELF.inq_count03_s := inq_count03_s;
SELF.inq_count06_s := inq_count06_s;
SELF.inq_count12_s := inq_count12_s;
SELF.inq_count24_s := inq_count24_s;
SELF.inq_auto_count03_s := inq_auto_count03_s;
SELF.inq_auto_count12_s := inq_auto_count12_s;
SELF.inq_banking_count03_s := inq_banking_count03_s;
SELF.inq_collection_count12_s := inq_collection_count12_s;
SELF.inq_communications_count_s := inq_communications_count_s;
SELF.inq_communications_count01_s := inq_communications_count01_s;
SELF.inq_communications_count03_s := inq_communications_count03_s;
SELF.inq_communications_count06_s := inq_communications_count06_s;
SELF.inq_communications_count12_s := inq_communications_count12_s;
SELF.inq_communications_count24_s := inq_communications_count24_s;
SELF.inq_highriskcredit_count_s := inq_highriskcredit_count_s;
SELF.inq_highriskcredit_count01_s := inq_highriskcredit_count01_s;
SELF.inq_highriskcredit_count03_s := inq_highriskcredit_count03_s;
SELF.inq_highriskcredit_count06_s := inq_highriskcredit_count06_s;
SELF.inq_highriskcredit_count12_s := inq_highriskcredit_count12_s;
SELF.inq_highriskcredit_count24_s := inq_highriskcredit_count24_s;
SELF.inq_retail_count_s := inq_retail_count_s;
SELF.inq_retail_count01_s := inq_retail_count01_s;
SELF.inq_retail_count03_s := inq_retail_count03_s;
SELF.inq_retail_count06_s := inq_retail_count06_s;
SELF.inq_retail_count12_s := inq_retail_count12_s;
SELF.inq_retail_count24_s := inq_retail_count24_s;
SELF.inq_peraddr_s := inq_peraddr_s;
SELF.inq_adlsperaddr_s := inq_adlsperaddr_s;
SELF.inq_lnamesperaddr_s := inq_lnamesperaddr_s;
SELF.inq_ssnsperaddr_s := inq_ssnsperaddr_s;
SELF.inq_perphone_s := inq_perphone_s;
SELF.inq_adlsperphone_s := inq_adlsperphone_s;
SELF.pb_number_of_sources_s := pb_number_of_sources_s;
SELF.pb_average_days_bt_orders_s := pb_average_days_bt_orders_s;
SELF.pb_average_dollars_s := pb_average_dollars_s;
SELF.pb_total_dollars_s := pb_total_dollars_s;
SELF.pb_total_orders_s := pb_total_orders_s;
SELF.br_source_count_s := br_source_count_s;
SELF.infutor_nap_s := infutor_nap_s;
SELF.stl_inq_count_s := stl_inq_count_s;
SELF.email_count_s := email_count_s;
SELF.attr_num_unrel_liens60_s := attr_num_unrel_liens60_s;
SELF.attr_eviction_count_s := attr_eviction_count_s;
SELF.attr_num_nonderogs_s := attr_num_nonderogs_s;
SELF.attr_num_nonderogs90_s := attr_num_nonderogs90_s;
SELF.attr_num_nonderogs180_s := attr_num_nonderogs180_s;
SELF.attr_num_nonderogs12_s := attr_num_nonderogs12_s;
SELF.attr_num_nonderogs24_s := attr_num_nonderogs24_s;
SELF.attr_num_nonderogs36_s := attr_num_nonderogs36_s;
SELF.attr_num_nonderogs60_s := attr_num_nonderogs60_s;
SELF.fp_idrisktype_s := fp_idrisktype_s;
SELF.fp_varrisktype_s := fp_varrisktype_s;
SELF.fp_varmsrcssnunrelcount_s := fp_varmsrcssnunrelcount_s;
SELF.fp_srchvelocityrisktype_s := fp_srchvelocityrisktype_s;
SELF.fp_srchunvrfdaddrcount_s := fp_srchunvrfdaddrcount_s;
SELF.fp_srchfraudsrchcountyr_s := fp_srchfraudsrchcountyr_s;
SELF.fp_assocsuspicousidcount_s := fp_assocsuspicousidcount_s;
SELF.fp_assoccredbureaucount_s := fp_assoccredbureaucount_s;
SELF.fp_validationrisktype_s := fp_validationrisktype_s;
SELF.fp_corrrisktype_s := fp_corrrisktype_s;
SELF.fp_divaddrsuspidcountnew_s := fp_divaddrsuspidcountnew_s;
SELF.fp_srchssnsrchcountmo_s := fp_srchssnsrchcountmo_s;
SELF.fp_srchaddrsrchcountmo_s := fp_srchaddrsrchcountmo_s;
SELF.fp_srchphonesrchcountmo_s := fp_srchphonesrchcountmo_s;
SELF.fp_addrchangeincomediff_s := fp_addrchangeincomediff_s;
SELF.fp_addrchangevaluediff_s := fp_addrchangevaluediff_s;
SELF.fp_addrchangecrimediff_s := fp_addrchangecrimediff_s;
SELF.fp_addrchangeecontrajindex_s := fp_addrchangeecontrajindex_s;
SELF.fp_curraddrmedianincome_s := fp_curraddrmedianincome_s;
SELF.fp_curraddrmedianvalue_s := fp_curraddrmedianvalue_s;
SELF.fp_curraddrmurderindex_s := fp_curraddrmurderindex_s;
SELF.fp_curraddrcartheftindex_s := fp_curraddrcartheftindex_s;
SELF.fp_curraddrburglaryindex_s := fp_curraddrburglaryindex_s;
SELF.fp_curraddrcrimeindex_s := fp_curraddrcrimeindex_s;
SELF.fp_prevaddrageoldest_s := fp_prevaddrageoldest_s;
SELF.fp_prevaddrlenofres_s := fp_prevaddrlenofres_s;
SELF.fp_prevaddrstatus_s := fp_prevaddrstatus_s;
SELF.fp_prevaddrmedianvalue_s := fp_prevaddrmedianvalue_s;
SELF.fp_prevaddrmurderindex_s := fp_prevaddrmurderindex_s;
SELF.fp_prevaddrcartheftindex_s := fp_prevaddrcartheftindex_s;
SELF.fp_prevaddrburglaryindex_s := fp_prevaddrburglaryindex_s;
SELF.fp_prevaddrcrimeindex_s := fp_prevaddrcrimeindex_s;
SELF.liens_recent_unreleased_count_s := liens_recent_unreleased_count_s;
SELF.liens_historical_unreleased_ct_s := liens_historical_unreleased_ct_s;
SELF.liens_rel_ot_total_amount_s := liens_rel_ot_total_amount_s;
SELF.felony_count_s := felony_count_s;
SELF.hh_members_ct_s := hh_members_ct_s;
SELF.hh_age_65_plus_s := hh_age_65_plus_s;
SELF.hh_age_30_to_65_s := hh_age_30_to_65_s;
SELF.hh_collections_ct_s := hh_collections_ct_s;
SELF.hh_payday_loan_users_s := hh_payday_loan_users_s;
SELF.hh_members_w_derog_s := hh_members_w_derog_s;
SELF.hh_criminals_s := hh_criminals_s;
SELF.rel_count_s := rel_count_s;
SELF.rel_felony_count_s := rel_felony_count_s;
SELF.rel_within25miles_count_s := rel_within25miles_count_s;
SELF.rel_within100miles_count_s := rel_within100miles_count_s;
SELF.rel_within500miles_count_s := rel_within500miles_count_s;
SELF.rel_incomeunder75_count_s := rel_incomeunder75_count_s;
SELF.rel_incomeunder100_count_s := rel_incomeunder100_count_s;
SELF.rel_incomeover100_count_s := rel_incomeover100_count_s;
SELF.rel_homeunder100_count_s := rel_homeunder100_count_s;
SELF.rel_homeunder150_count_s := rel_homeunder150_count_s;
SELF.rel_homeunder200_count_s := rel_homeunder200_count_s;
SELF.rel_homeunder300_count_s := rel_homeunder300_count_s;
SELF.rel_homeunder500_count_s := rel_homeunder500_count_s;
SELF.rel_homeover500_count_s := rel_homeover500_count_s;
SELF.rel_educationover12_count_s := rel_educationover12_count_s;
SELF.rel_ageunder50_count_s := rel_ageunder50_count_s;
SELF.rel_ageunder60_count_s := rel_ageunder60_count_s;
SELF.rel_ageunder70_count_s := rel_ageunder70_count_s;
SELF.rel_ageover70_count_s := rel_ageover70_count_s;
SELF.inferred_age_s := inferred_age_s;
SELF.estimated_income_s := estimated_income_s;
SELF.add_input_advo_drop := add_input_advo_drop;
SELF.bk_disposed_historical_count := bk_disposed_historical_count;
SELF.fp_varmsrcssnunrelcount := fp_varmsrcssnunrelcount;
SELF.fp_divsrchaddrsuspidcount := fp_divsrchaddrsuspidcount;
SELF.fp_srchaddrsrchcountwk := fp_srchaddrsrchcountwk;
SELF.inq_retail_count_week := inq_retail_count_week;
SELF.inq_retailpayments_count01 := inq_retailpayments_count01;
SELF.inq_retailpayments_count03 := inq_retailpayments_count03;
SELF.inq_retailpayments_count06 := inq_retailpayments_count06;
SELF.inq_retailpayments_count12 := inq_retailpayments_count12;
SELF.in_fname := in_fname;
SELF.in_fname_s := in_fname_s;
SELF.liens_unrel_st_first_seen := liens_unrel_st_first_seen;
SELF.liens_unrel_st_last_seen := liens_unrel_st_last_seen;
SELF.rc_phonevalflag_s := rc_phonevalflag_s;
SELF.rc_hphonevalflag_s := rc_hphonevalflag_s;
SELF.rc_phonetype_s := rc_phonetype_s;
SELF.emailpop_s := emailpop_s;
SELF.recent_disconnects_s := recent_disconnects_s;
SELF.invalid_phones_per_adl_s := invalid_phones_per_adl_s;
SELF.invalid_phones_per_adl_c6_s := invalid_phones_per_adl_c6_s;
SELF.invalid_addrs_per_adl_c6_s := invalid_addrs_per_adl_c6_s;
SELF.inq_mortgage_count03_s := inq_mortgage_count03_s;
SELF.inq_prepaidcards_count_s := inq_prepaidcards_count_s;
SELF.inq_prepaidcards_count01_s := inq_prepaidcards_count01_s;
SELF.inq_prepaidcards_count03_s := inq_prepaidcards_count03_s;
SELF.inq_prepaidcards_count06_s := inq_prepaidcards_count06_s;
SELF.inq_prepaidcards_count12_s := inq_prepaidcards_count12_s;
SELF.inq_prepaidcards_count24_s := inq_prepaidcards_count24_s;
SELF.email_verification_s := email_verification_s;
SELF.fp_assocrisktype_s := fp_assocrisktype_s;
SELF.fp_srchcomponentrisktype_s := fp_srchcomponentrisktype_s;
SELF.fp_srchaddrsrchcountwk_s := fp_srchaddrsrchcountwk_s;
SELF.fp_srchphonesrchcountwk_s := fp_srchphonesrchcountwk_s;
SELF.liens_unrel_ot_last_seen_s := liens_unrel_ot_last_seen_s;
SELF.liens_rel_ot_last_seen_s := liens_rel_ot_last_seen_s;
SELF.liens_unrel_sc_first_seen_s := liens_unrel_sc_first_seen_s;
SELF.liens_unrel_st_total_amount_s := liens_unrel_st_total_amount_s;
SELF.foreclosure_last_date_s := foreclosure_last_date_s;
SELF.rel_criminal_count_s := rel_criminal_count_s;
/* Added for extra output variables */


	#else
	
	
		bt := riskwise.reasons( le.bs.bill_to_out, PrescreenOptOut:=false, isCalifornia:=false );
		
		billto_consumer_reasons :=
			if(bt.rc09, bt.makeRC('09')) &
			if(bt.rc08, bt.makeRC('08')) &
			if(bt.rc31, bt.makeRC('31')) &
			if(risk_indicators.rcSet.isCodeIF(le.bs.ip2o.countrycode), bt.makeRC('IF')) &
			if(bt.rc19, bt.makeRC('19')) &
			if(bt.rc49, bt.makeRC('49')) &
			if(bt.rc11, bt.makeRC('11')) &
			if(bt.rc16, bt.makeRC('16')) &
			if(bt.rc64, bt.makeRC('64')) &
			if(bt.rcFV, bt.makeRC('FV')) &
			if(bt.rc76, bt.makeRC('76')) &
			if(Risk_Indicators.rcSet.isCodeIE(le.bs.ip2o.ipaddr<>'', le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype), bt.makeRC('IE')) &
			if(bt.rc77, bt.makeRC('77')) &
			if(bt.rc25, bt.makeRC('25')) &
			if(Risk_Indicators.rcSet.isCodeIB(le.bs.bill_to_out.shell_input.in_state, 
				le.bs.ip2o.state, le.bs.ip2o.countrycode, le.bs.ip2o.ipaddr<>'', le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype), 
									bt.makeRC('IB')) &
			if(bt.rc37, bt.makeRC('37')) &
			if(bt.rc14, bt.makeRC('14')) &
			if(bt.rc9D, bt.makeRC('9D')) &
			if(bt.rc74, bt.makeRC('74')) &
			if(bt.rc32, bt.makeRC('32')) &
			if(bt.rcWL, bt.makeRC('WL')) &
			if(bt.rc30, bt.makeRC('30')) &
			if(bt.rc82, bt.makeRC('82')) &
			if(bt.rcMS, bt.makeRC('MS')) &
			if(bt.rc34, bt.makeRC('34')) &
			if(bt.rcSR, bt.makeRC('SR')) &
			if(bt.rc73, bt.makeRC('73')) &
			if(bt.rc40, bt.makeRC('40')) &
			if(bt.rc9K, bt.makeRC('9K')) &
			if(bt.rc97, bt.makeRC('97')) &
			if(bt.rc07, bt.makeRC('07')) &
			if(bt.rcMO, bt.makeRC('MO')) &
			if(bt.rcCO, bt.makeRC('CO')) &
			if(bt.rcBO, bt.makeRC('BO')) &
			if(bt.rc56, bt.makeRC('56')) &
			if(bt.rc27, bt.makeRC('27')) &
			if(bt.rc10, bt.makeRC('10')) &
			if(bt.rc5Q, bt.makeRC('5Q')) &
			if(bt.rc80, bt.makeRC('80')) &
			if(Risk_Indicators.rcSet.isCodeID(le.bs.ip2o.areacode, 
				le.bs.bill_to_out.shell_input.phone10, le.bs.bill_to_out.shell_input.in_state, le.bs.ip2o.state, le.bs.ip2o.countrycode, 
				le.bs.ip2o.secondleveldomain, le.bs.ip2o.ipaddr<>'', le.bs.ip2o.iptype), 
									bt.makeRC('ID')) &
			if(bt.rc57, bt.makeRC('57')) &
			if(bt.rc12, bt.makeRC('12')) &
			if(bt.rcPA, bt.makeRC('PA')) &
			if(bt.rcPO, bt.makeRC('PO')) &
			if(bt.rc15, bt.makeRC('15')) &
			if(bt.rc75, bt.makeRC('75')) &
			if(Risk_Indicators.rcSet.isCodeIC(le.bs.bill_to_out.shell_input.in_zipCode, le.bs.ip2o.zip, 
				le.bs.ip2o.countrycode, le.bs.ip2o.ipaddr<>'', le.bs.bill_to_out.shell_input.in_state, le.bs.ip2o.state, 
				le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype, le.bs.ip2o.areacode, le.bs.bill_to_out.shell_input.phone10), 
									bt.makeRC('IC')) &
			if(Risk_Indicators.rcSet.isCodeIG(le.bs.ip2o.iptype), bt.makeRC('IG')) &
			if(bt.rc55, bt.makeRC('55')) &
			if(bt.rc50, bt.makeRC('50')) &
			if(bt.rc13, bt.makeRC('13')) &
			if(bt.rc43, bt.makeRC('43')) &
			if(bt.rc78, bt.makeRC('78')) &
			if(Risk_Indicators.rcSet.isCodeIA(le.bs.bill_to_out.shell_input.ip_address, le.bs.ip2o.ipaddr<>''), bt.makeRC('IA')) &
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00');
			
		st := riskwise.reasons( le.bs.ship_to_out, PrescreenOptOut:=false, isCalifornia:=false );
		
		shipto_consumer_reasons :=
			if(st.rc02, st.makeRC('02')) &
			if(st.rc09, st.makeRC('09')) &
			if(st.rc08, st.makeRC('08')) &
			if(st.rc49, st.makeRC('49')) &
			if(st.rc16, st.makeRC('16')) &
			if(st.rc19, st.makeRC('19')) &
			if(st.rc31, st.makeRC('31')) &
			if(st.rc77, st.makeRC('77')) &
			if(st.rcFV, st.makeRC('FV')) &
			if(st.rc74, st.makeRC('74')) &
			if(st.rc97, st.makeRC('97')) &
			if(st.rc64, st.makeRC('64')) &
			if(st.rc55, st.makeRC('55')) &
			if(st.rc11, st.makeRC('11')) &
			if(st.rc76, st.makeRC('76')) &
			if(st.rcMS, st.makeRC('MS')) &
			if(st.rc9D, st.makeRC('9D')) &
			if(st.rc37, st.makeRC('37')) &
			if(st.rc25, st.makeRC('25')) &
			if(st.rc9K, st.makeRC('9K')) &
			if(bt.rc32, bt.makeRC('32')) &
			if(bt.rcWL, bt.makeRC('WL')) &
			if(st.rc34, st.makeRC('34')) &
			if(st.rc07, st.makeRC('07')) &
			if(st.rc82, st.makeRC('82')) &
			if(st.rc30, st.makeRC('30')) &
			if(st.rc73, st.makeRC('73')) &
			if(st.rcBO, st.makeRC('BO')) &
			if(st.rc14, st.makeRC('14')) &
			if(st.rc5Q, st.makeRC('5Q')) &
			if(st.rc27, st.makeRC('27')) &
			if(st.rc10, st.makeRC('10')) &
			if(bt.rcMO, bt.makeRC('MO')) &
			if(bt.rcCO, bt.makeRC('CO')) &
			if(st.rc12, st.makeRC('12')) &
			if(st.rcSR, st.makeRC('SR')) &
			if(st.rcPO, st.makeRC('PO')) &
			if(st.rc15, st.makeRC('15')) &
			if(st.rc40, st.makeRC('40')) &
			if(st.rcPA, st.makeRC('PA')) &
			if(st.rc57, st.makeRC('57')) &
			if(st.rc56, st.makeRC('56')) &
			if(st.rc75, st.makeRC('75')) &
			if(st.rc80, st.makeRC('80')) &
			if(st.rc78, st.makeRC('78')) &
			if(st.rc53, st.makeRC('53')) &
			if(st.rc50, st.makeRC('50')) &
			if(st.rc13, st.makeRC('13')) &
			if(st.rc43, st.makeRC('43')) &
			st.makeRC('00') & 
			st.makeRC('00') & 
			st.makeRC('00') & 
			st.makeRC('00') & 
			st.makeRC('00') & 
			st.makeRC('00')	 ;	
	
billto_business_reasons :=		
			if(bt.rc09, bt.makeRC('09')) &
			if(bt.rc32, bt.makeRC('32')) &
			if(Risk_Indicators.rcSet.isCodeCZ(rt.bill_to_output.statezipflag, rt.bill_to_output.cityzipflag), bt.makeRC('CZ')) &
			if(risk_indicators.rcSet.isCodeIF(le.bs.ip2o.countrycode), bt.makeRC('IF')) &
			if(bt.rc19, bt.makeRC('19')) &
			if(Risk_Indicators.rcSet.isCodeIB(le.bs.bill_to_out.shell_input.in_state, 
				le.bs.ip2o.state, le.bs.ip2o.countrycode, le.bs.ip2o.ipaddr<>'', le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype), 
									bt.makeRC('IB')) &
			if(bt.rc37, bt.makeRC('37')) &
			if(bt.rc11, bt.makeRC('11')) &
			if(bt.rc25, bt.makeRC('25')) &
			if(bt.rc27, bt.makeRC('27')) &
			if(Risk_Indicators.rcSet.isCodeIE(le.bs.ip2o.ipaddr<>'', le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype), bt.makeRC('IE')) &
			if(bt.rc40, bt.makeRC('40')) &
			if(Risk_Indicators.rcSet.isCodeA7(rt.bill_to_output.vernotrecentFlag), bt.makeRC('A7')) &
			if(bt.rc49, bt.makeRC('49')) &
			if(Risk_Indicators.rcSet.isCode70(rt.bill_to_output.resAddrFlag), bt.makeRC('70')) &
			if(bt.rc74, bt.makeRC('74')) &
			if(bt.rc10, bt.makeRC('10')) &
			if(bt.rc08, bt.makeRC('08')) &
			if(Risk_Indicators.rcSet.isCodeA6(rt.bill_to_output.bdid, rt.bill_to_output.goodstanding), bt.makeRC('A6')) &
			if(bt.rc64, bt.makeRC('64')) &
			if(Risk_Indicators.rcSet.isCode44(rt.bill_to_output.areacodesplitflag), bt.makeRC('44')) &
			if(bt.rc16, bt.makeRC('16')) &
			if(Risk_Indicators.rcSet.isCodeID(le.bs.ip2o.areacode, 
				le.bs.bill_to_out.shell_input.phone10, le.bs.bill_to_out.shell_input.in_state, le.bs.ip2o.state, le.bs.ip2o.countrycode, 
				le.bs.ip2o.secondleveldomain, le.bs.ip2o.ipaddr<>'', le.bs.ip2o.iptype), 
									bt.makeRC('ID')) &
			if(bt.rc31, bt.makeRC('31')) &
			if(bt.rc07, bt.makeRC('07')) &
			if(Risk_Indicators.rcSet.isCodeA4(rt.bill_to_output.bdid, rt.bill_to_output.goodstanding), bt.makeRC('A4')) &
			if(rt.bill_to_output.resPhoneFlag = 'Y', bt.makeRC('69')) &
			if(Risk_Indicators.rcSet.isCode86(rt.bill_to_output.company_name, rt.bill_to_output.vercmpy, rt.bill_to_output.bestCompanyName), bt.makeRC('86')) &
			if(bt.rc76, bt.makeRC('76')) &
			if(bt.rc14, bt.makeRC('14')) &
			if(bt.rc82, bt.makeRC('82')) &
			if(bt.rc30, bt.makeRC('30')) &
			if(Risk_Indicators.rcSet.isCodeIC(le.bs.bill_to_out.shell_input.in_zipCode, le.bs.ip2o.zip, 
				le.bs.ip2o.countrycode, le.bs.ip2o.ipaddr<>'', le.bs.bill_to_out.shell_input.in_state, le.bs.ip2o.state, 
				le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype, le.bs.ip2o.areacode, le.bs.bill_to_out.shell_input.phone10), 
									bt.makeRC('IC')) &
			if(bt.rcPO, bt.makeRC('PO')) &
			if(bt.rcPA, bt.makeRC('PA')) &
			if(bt.rc43, bt.makeRC('43')) &
			if(bt.rc12, bt.makeRC('12')) &
			if(rt.bill_to_output.orig_z5<>'' and rt.bill_to_output.zipscore < 100 and 
				~((rt.bill_to_output.prim_name != '' or rt.bill_to_output.z5 != '' or rt.bill_to_output.st != '') and rt.bill_to_output.addrmatchflag = 'N'), 
									bt.makeRC('ZI')) &
			if(Risk_Indicators.rcSet.isCodeA5(rt.bill_to_output.lienbdidflag), bt.makeRC('A5')) &
			if(bt.rc15, bt.makeRC('15')) &
			if(Risk_Indicators.rcSet.isCodeIG(le.bs.ip2o.iptype), bt.makeRC('IG')) &
			if(Risk_Indicators.rcSet.isCodeIA(le.bs.bill_to_out.shell_input.ip_address, le.bs.ip2o.ipaddr<>''), bt.makeRC('IA')) &
			if(bt.rc77, bt.makeRC('77')) &
			if(bt.rc53, bt.makeRC('53')) &
			if(bt.rc50, bt.makeRC('50')) &
			if(bt.rc55, bt.makeRC('55')) &
			if(bt.rc78, bt.makeRC('78')) &
			if(bt.rcCO, bt.makeRC('CO')) &
			if(bt.rcMO, bt.makeRC('MO')) &
			if(bt.rcWL, bt.makeRC('WL')) &
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00')	;	

shipto_business_reasons := 
			if(st.rc09, st.makeRC('09')) &
			if(st.rc32, st.makeRC('32')) &
			if(Risk_Indicators.rcSet.isCodeCZ(rt.ship_to_output.statezipflag, rt.ship_to_output.cityzipflag), st.makeRC('CZ')) &
			if(st.rc19, st.makeRC('19')) &
			if(st.rc37, st.makeRC('37')) &
			if(st.rc25, st.makeRC('25')) &
			if(st.rc49, st.makeRC('49')) &
			if(st.rc11, st.makeRC('11')) &
			if(st.rc27, st.makeRC('27')) &
			if(Risk_Indicators.rcSet.isCodeA7(rt.ship_to_output.vernotrecentFlag), st.makeRC('A7')) &
			if(Risk_Indicators.rcSet.isCode70(rt.ship_to_output.resAddrFlag), st.makeRC('70')) &
			if(st.rc16, st.makeRC('16')) &
			if(st.rc74, st.makeRC('74')) &
			if(Risk_Indicators.rcSet.isCodeA6(rt.ship_to_output.bdid, rt.ship_to_output.goodstanding), st.makeRC('A6')) &
			if(st.rc64, st.makeRC('64')) &
			if(st.rc10, st.makeRC('10')) &
			if(st.rc08, st.makeRC('08')) &
			if(Risk_Indicators.rcSet.isCode44(rt.ship_to_output.areacodesplitflag), st.makeRC('44')) &
			if(st.rc12, st.makeRC('12')) &
			if(Risk_Indicators.rcSet.isCodeA4(rt.ship_to_output.bdid, rt.ship_to_output.goodstanding), st.makeRC('A4')) &
			if(st.rc40, st.makeRC('40')) &
			if(st.rc07, st.makeRC('07')) &
			if(st.rcPO, st.makeRC('PO')) &
			if(st.rc14, st.makeRC('14')) &
			if(rt.ship_to_output.resPhoneFlag = 'Y', st.makeRC('69')) &
			if(st.rc43, st.makeRC('43')) &
			if(Risk_Indicators.rcSet.isCode86(rt.ship_to_output.company_name, rt.ship_to_output.vercmpy, rt.ship_to_output.bestCompanyName), st.makeRC('86')) &
			if(st.rc76, st.makeRC('76')) &
			if(st.rc31, st.makeRC('31')) &
			if(st.rc30, st.makeRC('30')) &
			if(rt.ship_to_output.orig_z5<>'' and rt.ship_to_output.zipscore < 100 and 
				~((rt.ship_to_output.prim_name != '' or rt.ship_to_output.z5 != '' or rt.ship_to_output.st != '') and rt.ship_to_output.addrmatchflag = 'N'), st.makeRC('ZI')) &
			if(st.rcPA, st.makeRC('PA')) &
			if(Risk_Indicators.rcSet.isCodeA5(rt.ship_to_output.lienbdidflag), st.makeRC('A5')) &
			if(st.rc82, st.makeRC('82')) &
			if(st.rc15, st.makeRC('15')) &
			if(st.rc77, st.makeRC('77')) &
			if(st.rc53, st.makeRC('53')) &
			if(st.rc50, st.makeRC('50')) &
			if(st.rc55, st.makeRC('55')) &
			if(st.rc78, st.makeRC('78')) &
			if(st.rcCO, st.makeRC('CO')) &
			if(st.rcMO, st.makeRC('MO')) &
			if(st.rcWL, st.makeRC('WL')) &
st.makeRC('00') & 
st.makeRC('00') & 
st.makeRC('00') & 
st.makeRC('00') & 
st.makeRC('00') & 
st.makeRC('00')	;	
		
		// return 12 reason codes, 6 billto followed by 6 shipto, and the CDxO function maps them into their respective fields
		consumer_reasons := choosen(billto_consumer_reasons, 6) + choosen(shipto_consumer_reasons, 6);
		business_reasons := choosen(billto_business_reasons, 6) + choosen(shipto_business_reasons, 6);
		self.ri := if( isBusiness, business_reasons, consumer_reasons );
		
		// position 4..6 will now be blank																			
		SELF.score := (STRING3)CDN1508_1_0 + '   ' + (STRING3)CDN1508_1_0_custom_attribute ;
		SELF.seq := le.bs.bill_to_out.seq;
	#end
	END;

	model := join(with_census, biid,
		left.bs.bill_to_out.seq=right.Bill_to_Output.seq, doModel(LEFT, right), left outer);
// output(choosen(with_census,10));
// output(choosen(with_census_tmp,10));

	RETURN(model);
END;

