import risk_indicators, riskwise, ut, easi, std;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1303_2_0(  dataset(risk_indicators.Layout_Boca_Shell) clam , integer1 num_reasons, boolean criminal) := FUNCTION

FP_DEBUG := false;

#if(FP_DEBUG)
	layout_debug := record

				integer sysdate	;
				boolean ssnpop	;
				boolean ver_src_ds	;
				boolean ver_src_eq	;
				boolean ver_src_en	;
				boolean ver_src_tn	;
				boolean ver_src_tu	;
				integer ver_src_cnt	;
				integer credit_source_cnt	;
				boolean bureauonly2	;
				boolean _derog	;
				integer iv_vp090_phn_dst_to_inp_add	;
				integer iv_vp091_phnzip_mismatch	;
				integer iv_vp010_phn_nongeo	;
				integer iv_vp001_phn_not_issued	;
				integer iv_vp002_phn_disconnected	;
				integer iv_vp003_phn_invalid	;
				integer iv_vp004_phn_hirisk	;
				integer iv_vp005_phn_cell	;
				integer iv_vp006_phn_pager	;
				integer iv_vp007_phn_pcs	;
				integer iv_vp008_phn_pay_phone	;
				string iv_vp100_phn_prob	;
				integer iv_va060_dist_add_in_bst	;
				integer iv_va002_add_invalid	;
				integer iv_va003_add_hirisk_comm	;
				integer iv_va004_add_military_zip	;
				integer iv_va005_add_corp_zip	;
				string iv_va006_add_zip_prob	;
				integer iv_va007_add_vacant	;
				integer iv_va008_add_throwback	;
				integer iv_va009_add_college	;
				integer iv_va010_add_drop_delivery	;
				integer iv_va011_add_business	;
				string iv_va012_add_curbside_del	;
				string add_ec1	;
				string add_ec3	;
				string add_ec4	;
				string iv_va020_add_standardized	;
				string iv_va100_add_problem	;
				integer _felony_last_date	;
				string iv_db001_bankruptcy	;
				integer src_liens_adl_lseen	;
				integer _src_liens_adl_lseen	;
				integer iv_dl001_lien_last_seen	;
				integer src_bureau_adl_fseen	;
				integer _src_bureau_adl_fseen	;
				integer iv_sr001_m_bureau_adl_fs	;
				integer src_bureau_vo_fseen	;
				integer _src_bureau_vo_fseen	;
				integer mth_ver_src_fdate_vo	;
				integer src_bureau_vo_lseen	;
				integer _src_bureau_vo_lseen	;
				integer mth_ver_src_ldate_vo	;
				boolean mth_ver_src_fdate_vo60	;
				boolean mth_ver_src_ldate_vo0	;
				integer src_bureau_w_lseen	;
				integer _src_bureau_w_lseen	;
				integer mth_ver_src_ldate_w	;
				boolean mth_ver_src_ldate_w0	;
				integer src_bureau_wp_lseen	;
				integer _src_bureau_wp_lseen	;
				integer mth_ver_src_ldate_wp	;
				boolean mth_ver_src_ldate_wp0	;
				integer _paw_first_seen	;
				integer mth_paw_first_seen	;
				integer mth_paw_first_seen2	;
				boolean ver_src_am	;
				boolean ver_src_e1	;
				boolean ver_src_e2	;
				boolean ver_src_e3	;
				boolean ver_src_pl	;
				boolean ver_src_w	;
				boolean paw_dead_business_count_gt3	;
				boolean paw_active_phone_count_0	;
				integer _infutor_first_seen	;
				integer mth_infutor_first_seen	;
				integer _infutor_last_seen	;
				integer mth_infutor_last_seen	;
				integer infutor_i	;
				real infutor_im	;
				integer src_white_pages_adl_fseen	;
				integer _src_white_pages_adl_fseen	;
				integer iv_sr001_m_wp_adl_fs	;
				integer src_m_wp_adl_fs	;
				integer _header_first_seen	;
				integer iv_sr001_m_hdr_fs	;
				integer src_m_hdr_fs	;
				real source_mod6	;
				real  source_mod6_1	;
				real iv_sr001_source_profile	;
				integer _in_dob	;
				string in_dob	;
				integer yr_in_dob	;
				integer yr_in_dob_int	;
				integer age_estimate	;
				integer iv_ag001_age	;
				integer iv_pl001_bst_addr_lres	;
				string iv_pl001_addr_stability_v2	;
				integer iv_pl002_avg_mo_per_addr	;
				integer iv_pl002_addrs_15yr	;
				integer src_vehicles_adl_fseen	;
				integer _src_vehicles_adl_fseen	;
				integer iv_po001_m_snc_veh_adl_fs	;
				string iv_in001_wealth_index	;
				string iv_in001_college_income	;
				integer bst_addr_avm_auto_val_2	;
				integer iv_pv001_bst_avm_chg_1yr	;
				real iv_pv001_bst_avm_chg_1yr_pct	;
				boolean iv_pots_phone	;
				boolean iv_add_apt	;
				integer iv_nas_summary	;
				string iv_dl_val_flag	;
				integer iv_src_bureau_adl_count	;
				integer src_bureau_lname_fseen	;
				integer _src_bureau_lname_fseen	;
				integer iv_mos_src_bureau_lname_fseen	;
				integer src_bureau_dob_fseen	;
				integer _src_bureau_dob_fseen	;
				integer iv_mos_src_bureau_dob_fseen	;
				integer iv_src_experian_adl_count	;
				integer src_experian_adl_fseen	;
				integer _src_experian_adl_fseen	;
				integer iv_mos_src_experian_adl_fseen	;
				integer iv_src_equifax_adl_count	;
				integer src_equifax_adl_lseen	;
				integer _src_equifax_adl_lseen	;
				integer iv_mos_src_equifax_adl_lseen	;
				integer src_property_adl_lseen	;
				integer _src_property_adl_lseen	;
				integer iv_mos_src_property_adl_lseen	;
				integer iv_src_drivers_lic_adl_count	;
				integer src_drivers_lic_adl_fseen	;
				integer _src_drivers_lic_adl_fseen	;
				integer iv_mos_src_drivers_lic_adl_fseen	;
				integer src_drivers_lic_adl_lseen	;
				integer _src_drivers_lic_adl_lseen	;
				integer iv_mos_src_drivers_lic_adl_lseen	;
				integer src_emerge_adl_fseen	;
				integer _src_emerge_adl_fseen	;
				integer iv_mos_src_emerge_adl_fseen	;
				integer iv_lname_score	;
				integer _lname_change_date	;
				integer iv_mos_since_lname_change	;
				string iv_input_dob_match_level	;
				string1 iv_phn_miskey	;
				string1 iv_addr_miskey	;
				string iv_adl_util_convenience	;
				string iv_adl_util_infrastructure	;
				string iv_add1_util_infrastructure	;
				string iv_inp_own_prop_x_addr_naprop	;
				integer iv_inp_addr_mortgage_amount	;
				string iv_inp_addr_mortgage_term	;
				string iv_inp_addr_mortgage_type	;
				string iv_inp_addr_financing_type	;
				integer iv_inp_addr_assessed_total_val	;
				integer inp_addr_fips_fall	;
				integer inp_addr_avm_auto_val	;
				real iv_inp_addr_fips_ratio	;
				integer iv_inp_addr_building_area	;
				integer iv_inp_nhood_num_vacant	;
				integer iv_inp_nhood_num_sfd	;
				real iv_inp_addr_avm_pct_change_2yr	;
				integer iv_inp_addr_avm_change_2yr	;
				integer iv_inp_addr_avm_change_3yr	;
				real iv_inp_addr_avm_pct_change_3yr	;
				string iv_bst_own_prop_x_addr_naprop	;
				integer bst_addr_avm_auto_val	;
				integer bst_addr_mortgage_amount	;
				real iv_bst_addr_mtg_avm_pct_diff	;
				integer _add1_mortgage_due_date	;
				integer _add1_mortgage_date	;
				integer iv_bst_addr_mortgage_term	;
				string iv_bst_addr_mortgage_type	;
				string iv_bst_addr_financing_type	;
				integer bst_addr_avm_auto_val_3	;
				real iv_bst_addr_avm_pct_change_2yr	;
				integer bst_addr_avm_auto_val_4	;
				integer bst_addr_avm_auto_val_1	;
				real iv_bst_addr_avm_pct_change_3yr	;
				integer iv_prv_addr_source_count	;
				string iv_prv_own_prop_x_addr_naprop	;
				integer _add2_mortgage_due_date	;
				integer mortgage_date_diff	;
				integer _add3_mortgage_date	;
				integer _add3_mortgage_due_date	;
				integer _add2_mortgage_date	;
				string iv_prv_addr_mortgage_term	;
				string mortgage_type	;
				boolean mortgage_present	;
				string iv_prv_addr_mortgage_type	;
				string iv_prv_addr_financing_type	;
				integer iv_prop_sold_assessed_total	;
				integer iv_prop_sold_assessed_count	;
				integer iv_purch_sold_val_diff	;
				integer _prop1_sale_date	;
				integer iv_mos_since_prop1_sale	;
				integer iv_prop1_purch_sale_diff	;
				integer iv_dist_inp_addr_to_prv_addr	;
				integer iv_avg_lres	;
				integer iv_addr_lres_12mo_count	;
				integer iv_phones_per_apt_addr	;
				integer iv_phones_per_addr_c6	;
				integer iv_adls_per_pots_phone_c6	;
				integer iv_credit_seeking	;
				integer iv_inq_addr_ver_count	;
				integer iv_inq_lname_ver_count	;
				integer iv_inq_ssn_ver_count	;
				integer iv_inq_dob_ver_count	;
				integer iv_inq_phone_ver_count	;
				integer iv_inq_highriskcredit_recency	;
				integer iv_inq_num_diff_names_per_adl	;
				integer iv_inq_adls_per_ssn	;
				integer iv_inq_per_addr	;
				string iv_paw_dead_bus_x_active_phn	;
				integer iv_infutor_nap	;
				boolean ver_phn_inf	;
				boolean ver_phn_nap	;
				integer inf_phn_ver_lvl	;
				integer nap_phn_ver_lvl	;
				string iv_num_purch_x_num_sold_60	;
				string iv_rec_vehx_level	;
				integer iv_derog_ratio	;
				string iv_liens_unrel_x_rel	;
				string iv_liens_unrel_x_rel_cj	;
				string iv_liens_unrel_x_rel_ft	;
				string iv_liens_unrel_x_rel_fc	;
				string iv_liens_unrel_x_rel_o	;
				string iv_liens_unrel_x_rel_ot	;
				string iv_liens_unrel_x_rel_sc	;
				string iv_criminal_x_felony	;
				integer iv_average_rel_income	;
				integer iv_average_rel_age	;
				integer iv_oldest_rel_age	;
				integer iv_average_rel_distance	;
				integer iv_closest_rel_distance	;
				integer iv_pct_rel_prop_owned	;
				integer iv_pct_rel_prop_sold	;
				integer iv_accident_count	;
				integer iv_accident_recency	;
				boolean ams_major_medical	;
				boolean ams_major_science	;
				boolean ams_major_liberal	;
				boolean ams_major_business	;
				boolean ams_major_unknown	;
				string iv_ams_college_major	;
				string iv_ams_college_tier	;
				string iv_prof_license_category	;
				string iv_pb_order_freq	;
				integer iv_pb_average_dollars	;
				string iv_fp_idrisktype	;
				string iv_fp_idverrisktype	;
				string iv_fp_sourcerisktype	;
				string iv_fp_varrisktype	;
				string iv_fp_srchvelocityrisktype	;
				integer iv_fp_srchfraudsrchcount	;
				string iv_fp_assocrisktype	;
				string iv_fp_validationrisktype	;
				string iv_fp_corrrisktype	;
				integer iv_fp_corrssnnamecount	;
				integer iv_fp_corraddrnamecount	;
				string iv_fp_divrisktype	;
				string iv_fp_srchcomponentrisktype	;
				integer iv_fp_srchssnsrchcount	;
				integer iv_fp_srchaddrsrchcount	;
				integer iv_fp_srchaddrsrchcountmo	;
				integer iv_fp_srchaddrsrchcountwk	;
				integer iv_fp_srchphonesrchcountmo	;
				string iv_fp_componentcharrisktype	;
				integer iv_fp_addrchangeincomediff	;
				integer iv_fp_addrchangecrimediff	;
				string iv_fp_addrchangeecontrajindex	;
				integer iv_fp_curraddrmedianvalue	;
				integer iv_fp_curraddrburglaryindex	;
				integer iv_fp_prevaddrageoldest	;
				string iv_fp_prevaddrdwelltype	;
				integer iv_fp_prevaddrmedianvalue	;
				integer iv_fp_prevaddrmurderindex	;
				string fp_segment	;
				string iv_phnpop_x_nap_summary	;
				string iv_fname_eda_sourced_type	;
				string iv_nap_phn_ver_x_inf_phn_ver	;
				integer iv_df001_mos_since_fel_ls	;
		//Treenet score calculation variables
				real class_threshold    ; 
				real score0;
				real score1 ;
				real expsum ;
				real prob0 ;
				real prob1 ;
				integer base ;
				integer point ;
				real odds ;
				integer fp1303_2_0;
				integer pred ;		
    // Treenet variables
				real N0_1                             ;   //N0_1;
				real N1_1                             ;   //N1_1;
				real N2_1                             ;   //N2_1;
				real N3_1                             ;   //N3_1;
				real N4_1                             ;   //N4_1;
				real N5_1                             ;   //N5_1;
				real N6_1                             ;   //N6_1;
				real N7_1                             ;   //N7_1;
				real N8_1                             ;   //N8_1;
				real N9_1                             ;   //N9_1;
				real N10_1                            ;   //N10_1;
				real N11_1                            ;   //N11_1;
				real N12_1                            ;   //N12_1;
				real N13_1                            ;   //N13_1;
				real N14_1                            ;   //N14_1;
				real N15_1                            ;   //N15_1;
				real N16_1                            ;   //N16_1;
				real N17_1                            ;   //N17_1;
				real N18_1                            ;   //N18_1;
				real N19_1                            ;   //N19_1;
				real N20_1                            ;   //N20_1;
				real N21_1                            ;   //N21_1;
				real N22_1                            ;   //N22_1;
				real N23_1                            ;   //N23_1;
				real N24_1                            ;   //N24_1;
				real N25_1                            ;   //N25_1;
				real N26_1                            ;   //N26_1;
				real N27_1                            ;   //N27_1;
				real N28_1                            ;   //N28_1;
				real N29_1                            ;   //N29_1;
				real N30_1                            ;   //N30_1;
				real N31_1                            ;   //N31_1;
				real N32_1                            ;   //N32_1;
				real N33_1                            ;   //N33_1;
				real N34_1                            ;   //N34_1;
				real N35_1                            ;   //N35_1;
				real N36_1                            ;   //N36_1;
				real N37_1                            ;   //N37_1;
				real N38_1                            ;   //N38_1;
				real N39_1                            ;   //N39_1;
				real N40_1                            ;   //N40_1;
				real N41_1                            ;   //N41_1;
				real N42_1                            ;   //N42_1;
				real N43_1                            ;   //N43_1;
				real N44_1                            ;   //N44_1;
				real N45_1                            ;   //N45_1;
				real N46_1                            ;   //N46_1;
				real N47_1                            ;   //N47_1;
				real N48_1                            ;   //N48_1;
				real N49_1                            ;   //N49_1;
				real N50_1                            ;   //N50_1;
				real N51_1                            ;   //N51_1;
				real N52_1                            ;   //N52_1;
				real N53_1                            ;   //N53_1;
				real N54_1                            ;   //N54_1;
				real N55_1                            ;   //N55_1;
				real N56_1                            ;   //N56_1;
				real N57_1                            ;   //N57_1;
				real N58_1                            ;   //N58_1;
				real N59_1                            ;   //N59_1;
				real N60_1                            ;   //N60_1;
				real N61_1                            ;   //N61_1;
				real N62_1                            ;   //N62_1;
				real N63_1                            ;   //N63_1;
				real N64_1                            ;   //N64_1;
				real N65_1                            ;   //N65_1;
				real N66_1                            ;   //N66_1;
				real N67_1                            ;   //N67_1;
				real N68_1                            ;   //N68_1;
				real N69_1                            ;   //N69_1;
				real N70_1                            ;   //N70_1;
				real N71_1                            ;   //N71_1;
				real N72_1                            ;   //N72_1;
				real N73_1                            ;   //N73_1;
				real N74_1                            ;   //N74_1;
				real N75_1                            ;   //N75_1;
				real N76_1                            ;   //N76_1;
				real N77_1                            ;   //N77_1;
				real N78_1                            ;   //N78_1;
				models.layout_modelout;
				risk_indicators.Layout_Boca_Shell clam;
				string200 errorcode;

		END;


		layout_debug doModel( clam le, easi.Key_Easi_Census ri ) :=  TRANSFORM
#else
		models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri  ) := TRANSFORM
#end
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_z5                           := le.shell_input.z5;
	out_addr_type                    := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	nap_status                       := le.iid.nap_status;
	rc_dl_val_flag                   := le.iid.drlcvalflag;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_phonezipflag                  := le.iid.phonezipflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_hphonemiskeyflag              := le.iid.hphonemiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	rc_statezipflag                  := le.iid.statezipflag;
	rc_cityzipflag                   := le.iid.cityzipflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_lname_sources_first_seen     := le.header_summary.ver_lname_sources_first_seen_date;
	ver_dob_sources                  := le.header_summary.ver_dob_sources;
	ver_dob_sources_first_seen       := le.header_summary.ver_dob_sources_first_seen_date;
	dl_avail                         := le.available_sources.dl;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	lname_score                      := le.name_verification.lname_score;
	lname_change_date                := le.name_verification.lname_change_date;
	fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
	util_adl_type_list               := le.utility.utili_adl_type;
	util_add1_type_list              := le.utility.utili_addr1_type;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_lres                        := le.lres;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_advo_throw_back             := le.advo_input_addr.throw_back_indicator;
	add1_advo_seasonal_delivery      := le.advo_input_addr.seasonal_delivery_indicator;
	add1_advo_college                := le.advo_input_addr.college_indicator;
	add1_advo_drop                   := le.advo_input_addr.drop_indicator;
	add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
	add1_advo_mixed_address_usage    := le.advo_input_addr.mixed_address_usage;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
	add1_avm_automated_valuation_3   := le.avm.input_address_information.avm_automated_valuation3;
	add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
	add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_financing_type              := le.address_verification.input_address_information.type_financing;
	add1_mortgage_due_date           := le.address_verification.input_address_information.first_td_due_date;
	add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
	add1_building_area               := le.address_verification.input_address_information.building_area;
	add1_nhood_vacant_properties     := le.addr_risk_summary.n_vacant_properties;
	add1_nhood_sfd_count             := le.addr_risk_summary.n_sfd_count;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
	property_sold_purchase_total     := le.address_verification.sold.property_owned_purchase_total;
	property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
	property_sold_assessed_count     := le.address_verification.sold.property_owned_assessed_count;
	prop1_sale_price                 := le.address_verification.recent_property_sales.sale_price1;
	prop1_sale_date                  := le.address_verification.recent_property_sales.sale_date1;
	prop1_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price1;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	add2_lres                        := le.lres2;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_avm_automated_valuation_2   := le.avm.address_history_1.avm_automated_valuation2;
	add2_avm_automated_valuation_3   := le.avm.address_history_1.avm_automated_valuation3;
	add2_avm_automated_valuation_4   := le.avm.address_history_1.avm_automated_valuation4;
	add2_source_count                := le.address_verification.address_history_1.source_count;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add2_mortgage_amount             := le.address_verification.address_history_1.mortgage_amount;
	add2_mortgage_date               := le.address_verification.address_history_1.mortgage_date;
	add2_mortgage_type               := le.address_verification.address_history_1.mortgage_type;
	add2_financing_type              := le.address_verification.address_history_1.type_financing;
	add2_mortgage_due_date           := le.address_verification.address_history_1.first_td_due_date;
	add3_source_count                := le.address_verification.address_history_2.source_count;
	add3_naprop                      := le.address_verification.address_history_2.naprop;
	add3_mortgage_date               := le.address_verification.address_history_2.mortgage_date;
	add3_mortgage_type               := le.address_verification.address_history_2.mortgage_type;
	add3_financing_type              := le.address_verification.address_history_2.type_financing;
	add3_mortgage_due_date           := le.address_verification.address_history_2.first_td_due_date;
	avg_lres                         := le.other_address_info.avg_lres;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
	addr_lres_12mo_count             := le.address_history_summary.lres_12mo_count;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen                := le.ssn_verification.header_first_seen;
	phones_per_addr                  := le.velocity_counters.phones_per_addr;
	phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
	adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
	inq_addr_ver_count               := le.acc_logs.inquiry_addr_ver_ct;
	inq_lname_ver_count              := le.acc_logs.inquiry_lname_ver_ct;
	inq_ssn_ver_count                := le.acc_logs.inquiry_ssn_ver_ct;
	inq_dob_ver_count                := le.acc_logs.inquiry_dob_ver_ct;
	inq_phone_ver_count              := le.acc_logs.inquiry_phone_ver_ct;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_lnamesperadl                 := le.acc_logs.inquirylnamesperadl;
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_adlsperssn                   := le.acc_logs.inquiryadlsperssn;
	inq_peraddr                      := le.acc_logs.inquiryperaddr;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.ibehavior.average_days_between_orders;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	paw_first_seen                   := le.employment.first_seen_date;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_last_seen                := le.infutor_phone.infutor_date_last_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	attr_num_purchase60              := le.other_address_info.num_purchase60;
	attr_num_sold60                  := le.other_address_info.num_sold60;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	fp_idrisktype                    := le.fdattributesv2.identityrisklevel;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchfraudsrchcount            := le.fdattributesv2.searchfraudsearchcount;
	fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
	fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
	fp_corrrisktype                  := le.fdattributesv2.correlationrisklevel;
	fp_corrssnnamecount              := le.fdattributesv2.correlationssnnamecount;
	fp_corraddrnamecount             := le.fdattributesv2.correlationaddrnamecount;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcount              := le.fdattributesv2.searchssnsearchcount;
	fp_srchaddrsrchcount             := le.fdattributesv2.searchaddrsearchcount;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountwk           := le.fdattributesv2.searchaddrsearchcountweek;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_componentcharrisktype         := le.fdattributesv2.componentcharrisklevel;
	fp_addrchangeincomediff          := le.fdattributesv2.addrchangeincomediff;
	fp_addrchangecrimediff           := le.fdattributesv2.addrchangecrimediff;
	fp_addrchangeecontrajindex       := le.fdattributesv2.addrchangeecontrajectoryindex;
	fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
	fp_curraddrburglaryindex         := le.fdattributesv2.curraddrburglaryindex;
	fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
	fp_prevaddrdwelltype             := le.fdattributesv2.prevaddrdwelltype;
	fp_prevaddrmedianvalue           := le.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrmurderindex           := le.fdattributesv2.prevaddrmurderindex;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
	liens_unrel_fc_ct                := le.liens.liens_unreleased_foreclosure.count;
	liens_rel_fc_ct                  := le.liens.liens_released_foreclosure.count;
	liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
	liens_rel_o_ct                   := le.liens.liens_released_other_lj.count;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	rel_count                        := le.relatives.relative_count;
	rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
	rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.relatives.relative_within500miles_count;
	rel_withinother_count            := le.relatives.relative_withinother_count;
	rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
	rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
	rel_ageunder20_count             := le.relatives.relative_ageunder20_count;
	rel_ageunder30_count             := le.relatives.relative_ageunder30_count;
	rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.relatives.relative_ageover70_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	acc_count                        := le.accident_data.acc.num_accidents;
	acc_count_30                     := le.accident_data.acc.numaccidents30;
	acc_count_90                     := le.accident_data.acc.numaccidents90;
	acc_count_180                    := le.accident_data.acc.numaccidents180;
	acc_count_12                     := le.accident_data.acc.numaccidents12;
	acc_count_24                     := le.accident_data.acc.numaccidents24;
	acc_count_36                     := le.accident_data.acc.numaccidents36;
	acc_count_60                     := le.accident_data.acc.numaccidents60;
	ams_date_first_seen              := le.student.date_first_seen;
	ams_college_code                 := le.student.college_code;
	ams_income_level_code            := le.student.income_level_code;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	prof_license_category            := le.professional_license.plcategory;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	addr_stability_v2                := le.addr_stability;
	c_armforce                       := ri.armforce;
	c_bel_edu                        := ri.bel_edu;
	c_bigapt_p                       := ri.bigapt_p;
	c_blue_col                       := ri.blue_col;
	c_born_usa                       := ri.born_usa;
	c_burglary                       := ri.burglary;
	c_construction                   := ri.construction;
	c_cpiall                         := ri.cpiall;
	c_easiqlife                      := ri.easiqlife;
	c_employees                      := ri.employees;
	c_exp_prod                       := ri.exp_prod;
	c_fammar18_p                     := ri.fammar18_p;
	c_fammar_p                       := ri.fammar_p;
	c_femdiv_p                       := ri.femdiv_p;
	c_finance                        := ri.finance;
	c_hh1_p                          := ri.hh1_p;
	c_high_ed                        := ri.high_ed;
	c_high_hval                      := ri.high_hval;
	c_hval_100k_p                    := ri.hval_100k_p;
	c_hval_125k_p                    := ri.hval_125k_p;
	c_hval_150k_p                    := ri.hval_150k_p;
	c_hval_175k_p                    := ri.hval_175k_p;
	c_hval_250k_p                    := ri.hval_250k_p;
	c_hval_300k_p                    := ri.hval_300k_p;
	c_hval_40k_p                     := ri.hval_40k_p;
	c_hval_750k_p                    := ri.hval_750k_p;
	c_hval_80k_p                     := ri.hval_80k_p;
	c_inc_100k_p                     := ri.in100k_p;
	c_inc_125k_p                     := ri.in125k_p;
	c_inc_150k_p                     := ri.in150k_p;
	c_inc_201k_p                     := ri.in201k_p;
	c_incollege                      := ri.incollege;
	c_lowrent                        := ri.lowrent;
	c_many_cars                      := ri.many_cars;
	c_med_age                        := ri.med_age;
	c_mining                         := ri.mining;
	c_murders                        := ri.murders;
	c_oldhouse                       := ri.oldhouse;
	c_pop_0_5_p                      := ri.pop_0_5_p;
	c_pop_18_24_p                    := ri.pop_18_24_p;
	c_pop_35_44_p                    := ri.pop_35_44_p;
	c_pop_45_54_p                    := ri.pop_45_54_p;
	c_pop_55_64_p                    := ri.pop_55_64_p;
	c_pop_85p_p                      := ri.pop_85p_p;
	c_popover25                      := ri.popover25;
	c_professional                   := ri.professional;
	c_retail                         := ri.retail;
	c_retired                        := ri.retired;
	c_retired2                       := ri.retired2;
	c_rich_fam                       := ri.rich_fam;
	c_rich_old                       := ri.rich_old;
	c_rnt1000_p                      := ri.rnt1000_p;
	c_rnt2000_p                      := ri.rnt2000_p;
	c_rnt250_p                       := ri.rnt250_p;
	c_robbery                        := ri.robbery;
	c_trailer                        := ri.trailer;
	c_transport                      := ri.transport;
	c_unempl                         := ri.unempl;
	c_very_rich                      := ri.very_rich;
	c_white_col                      := ri.white_col;
	c_young                          := ri.young;

	 



NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := __common__(common.sas_date1800s(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')));

ssnpop := __common__((integer)ssnlength > 0);

ver_src_ds := __common__(Models.Common.findw_cpp(ver_sources, 'DS' , ', ', 'E') > 0);

ver_src_eq := __common__(Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E') > 0);

ver_src_en := __common__(Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E') > 0);

ver_src_tn := __common__(Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E') > 0);

ver_src_tu := __common__(Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E') > 0);

// # warning:  engineer intervention needed -- function countc not implemented
// ver_src_cnt := countc(ver_sources, ',');
 // __common__
ver_src_cnt := __common__(  __common__(  (Models.Common.countw((string)(StringLib.StringToUpperCase(trim(ver_sources, ALL))), ',') )));

credit_source_cnt := __common__(  __common__(  if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu))));

bureauonly2 := __common__(  credit_source_cnt > 0 and credit_source_cnt = ver_src_cnt and (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

_derog := __common__(  felony_count > 0 or addrs_prison_history or attr_num_unrel_liens60 > 0 or attr_eviction_count > 0 or impulse_count > 0);

fp_segment_1 := __common__(  map(
    not ssnpop                                                                    			=> '0 No SSN         ',
    ver_src_ds or rc_decsflag = '1' or rc_ssndobflag = '1' or rc_pwssndobflag = '1' 		=> '1 SSN Prob       ',
    (nas_summary in [4, 7, 9])                                                    			=> '2 NAS 479        ',
    nap_summary <= 4 and nas_summary <= 4 or ver_src_cnt = 0                      			=> '3 New DID        ',
    bureauonly2                                                                   			=> '4 Bureau Only    ',
    _derog                                                                        			=> '5 Derog          ',
    Inq_count03 > 0                                                               			=> '6 Recent Activity',
																																													 '7 Other          '));

iv_vp090_phn_dst_to_inp_add := __common__(  if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr));

iv_vp091_phnzip_mismatch := __common__(  map(
    not(hphnpop and not(out_z5 = ''))          				=> NULL,
    rc_phonezipflag = '1' or rc_pwphonezipflag = '1' 	=> 1,
    rc_phonezipflag = '0' or rc_pwphonezipflag = '0' 	=> 0,
																											NULL));

iv_vp001_phn_not_issued_1 := __common__(  map(
    not(hphnpop)                 => Null,
    (rc_pwphonezipflag in ['4']) => 1,
                                    0));

iv_vp002_phn_disconnected_1 := __common__(  map(
    not(hphnpop)                                                             => NULL,
    rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => 1,
                                                                                0));

iv_vp010_phn_nongeo := __common__(  map(
    not(hphnpop)                                           => NULL,
    trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '7' => 1,
                                                              0));

iv_vp001_phn_not_issued := __common__(  map(
    not(hphnpop)                 => NULL,
    (rc_pwphonezipflag in ['4']) => 1,
                                    0));

iv_vp002_phn_disconnected := __common__(  map(
    not(hphnpop)                                                             => NULL,
    rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => 1,
                                                                                0));

iv_vp003_phn_invalid := __common__(  map(
    not(hphnpop)                                                    					=> NULL,
    rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5'		 	=> 1,
																																								0));

iv_vp004_phn_hirisk := __common__( map(
    not(hphnpop)                                                                                    					 => NULL,
    rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1'			 => 1,
																																																									0));

iv_vp005_phn_cell := __common__(  map(
    not(hphnpop)                                                                                                                                                                                                                                            	=> NULL,
    rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60' => 1,
                                                                                                                                                                                                                                                               0));

iv_vp006_phn_pager := __common__(  map(
    not(hphnpop)                                                                                                                                                                                                                                           		 	=> NULL,
    rc_hriskphoneflag = '2' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '2' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '02' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '56' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '61' 	=> 1,
																																																																																																																																0));

iv_vp007_phn_pcs := __common__(  map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            	=> NULL,
    rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => 1,
                                                                                                                                                                                                                                                                                                                                                                               0));

iv_vp008_phn_pay_phone := __common__(  map(
    not(hphnpop)                                           => NULL,
    trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = 'A' => 1,
                                                              0));

iv_vp100_phn_prob := __common__(  map(
    not(hphnpop)              					=> '                   ',
    iv_VP008_Phn_Pay_Phone   = 1  			=> '8 Pay_Phone        ',
    iv_VP007_Phn_PCS = 1         				=> '7 PCS              ',
    iv_VP006_Phn_Pager = 1       				=> '6 Pager            ',
    iv_VP005_Phn_Cell  = 1       				=> '5 Cell             ',
    iv_VP003_Phn_Invalid  = 1    				=> '4 Invalid          ',
    iv_VP001_Phn_Not_Issued  = 1 				=> '3 Not_Issued       ',
    iv_VP002_Phn_Disconnected = 1				=> '2 Disconnected     ',
    iv_VP004_Phn_HiRisk  = 1     				=> '1 HiRisk           ',
																						'0 No Phone Problems'));

iv_va007_add_vacant_1 := __common__(  map(
    not(add1_pop)                                                  => NULL,
    trim(trim(add1_advo_address_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                      0));

iv_va060_dist_add_in_bst := __common__(  map(
    not(truedid)       => NULL,
    add1_isbestmatch   => 0,
    dist_a1toa2 = 9999 => NULL,
                          dist_a1toa2));

iv_va002_add_invalid := __common__(  map(
    not(add1_pop)                                       => NULL,
    trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N' => 1,
                                                           0));

iv_va003_add_hirisk_comm := __common__(  map(
    not(add1_pop)                               		 => NULL,
    rc_hriskaddrflag = '4' or rc_addrcommflag = '2'	 => 1,
																											0));

iv_va004_add_military_zip := __common__(  map(
    not(add1_pop or not(out_z5 = ''))        		 		=> NULL,
    rc_hriskaddrflag = '3' or rc_ziptypeflag = '3' 	=> 1,
																										0));

iv_va005_add_corp_zip := __common__(  map(
    not(add1_pop or not(out_z5 = ''))        				=> NULL,
    rc_hriskaddrflag = '2' or rc_ziptypeflag = '2' 	=> 1,
																											0));

iv_va006_add_zip_prob := __common__(  map(
    not(add1_pop or not(out_z5 = '')) 		=> '                        ',
    rc_statezipflag = '1'                		=> '2 - Zip/State Mismatch  ',
    rc_cityzipflag = '1'                  	=> '1 - Zip/City  Mismatch  ',
																								'0 - Zip/City/State Match'));

iv_va007_add_vacant := __common__(  map(
    not(add1_pop)                                                  => NULL,
    trim(trim(add1_advo_address_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                      0));

iv_va008_add_throwback := __common__(  map(
    not(add1_pop)                                             => NULL,
    trim(trim(add1_advo_throw_back, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                 0));

iv_va009_add_college := __common__(  map(
    not(add1_pop)                                                                                                              => NULL,
    trim(trim(add1_advo_seasonal_delivery, LEFT), LEFT, RIGHT) = 'E' or trim(trim(add1_advo_college, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                                                                                  0));

iv_va010_add_drop_delivery := __common__(  map(
    not(add1_pop)                                       => NULL,
    trim(trim(add1_advo_drop, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                           0));

iv_va011_add_business := __common__(  map(
    not(add1_pop)                                                            => NULL,
    (trim(trim(add1_advo_res_or_business, LEFT), LEFT, RIGHT) in ['B', 'D']) => 1,
                                                                                0));

iv_va012_add_curbside_del := __common__(  map(
    not(add1_pop)                                                               => '                   ',
    (trim(trim(add1_advo_mixed_address_usage, LEFT), LEFT, RIGHT) in ['A', '']) => '0 Curbside Delivery',
                                                                                   '1 Not Curb Delivery'));

add_ec1 := __common__(  (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);

add_ec3 := __common__(  (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);

add_ec4 := __common__(  (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

iv_va020_add_standardized := __common__(  map(
    not(add1_pop)                                        => '                          ',
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => '2 Standarization Error    ',
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => '1 Address was Standardized',
                                                            '0 Address is Standard     '));

iv_va100_add_problem := __common__(  map(
    not(add1_pop)                                            => '                        ',
    iv_va006_add_zip_prob = '2 - Zip/State Mismatch  '       => '14 Zip/State Mismatch   ',
    iv_va007_add_vacant = 1                                  => '13 Vacant               ',
    iv_va009_add_college = 1                                 => '12 College              ',
    iv_va008_add_throwback = 1                               => '11 Throw Back           ',
    iv_va006_add_zip_prob = '1 - Zip/City  Mismatch  '       => '10 Zip/City Mismatch    ',
    iv_va005_add_corp_zip = 1                                => '09 Corporate Zip Code   ',
    iv_va004_add_military_zip = 1                            => '08 Military Zip         ',
    iv_va011_add_business = 1                                => '07 Busines              ',
    iv_va002_add_invalid = 1                                 => '06 Invalid Address      ',
    iv_va010_add_drop_delivery = 1                           => '05 Drop Delivery        ',
    iv_va003_add_hirisk_comm = 1                             => '04 HiRisk Commercial    ',
    iv_va020_add_standardized = '2 Standarization Error    ' => '03 Standarization Error ',
    iv_va020_add_standardized = '1 Address was Standardized' => '02 Address Standardized ',
    iv_va012_add_curbside_del = '1 Not Curb Delivery'        => '01 Not Curbside Delivery',
                                                                '00 No Address Problems  '));

_felony_last_date := __common__(  common.sas_date1800s((string)(felony_last_date)));

iv_df001_mos_since_fel_ls_2 := __common__(  if(not(truedid), NULL, NULL));

iv_df001_mos_since_fel_ls_1 := __common__(  if(_felony_last_date = NULL, -1, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));

iv_db001_bankruptcy := __common__(  map(
    not(truedid or (integer)ssnlength > 0)                                                                                              => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             					=> '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                              					=> '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 					=> '3 - BK Other     ',
																																																																							'0 - No BK        '));

src_liens_adl_lseen := __common__(  max((integer)if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E'), ',') in ['','0'], NULL,  
												(integer) Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E'), ',')), 
												(integer)if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E'), ',')), NULL));

_src_liens_adl_lseen := __common__(  common.sas_date1800s((string)(src_liens_adl_lseen)));

iv_dl001_lien_last_seen := __common__(  map(
    not(truedid)                => NULL,
    _src_liens_adl_lseen = NULL => -1,
                                   if ((sysdate - _src_liens_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_liens_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_liens_adl_lseen) / (365.25 / 12)))));

src_bureau_adl_fseen := __common__(  if(max(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ',')), 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ',')), 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ',')), 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',')), 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
													min(if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ',') in ['','0'], NULL,(integer) Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ','))), 
													if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ','))), 
													if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ','))), 
													if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ','))), 
													if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ','))), 
													if(NULL = NULL, -NULL, NULL))));

_src_bureau_adl_fseen := __common__(  common.sas_date1800s((string)(src_bureau_adl_fseen)));

iv_sr001_m_bureau_adl_fs := __common__(  map(
    not(truedid)                 => NULL,
    _src_bureau_adl_fseen = NULL => -1,
                                    if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))));

_header_first_seen_1 := __common__(  common.sas_date1800s((string)(header_first_seen)));

iv_sr001_m_hdr_fs_1 := __common__(  map(
    not(truedid)                     => NULL,
    not(_header_first_seen_1 = NULL) => if ((sysdate - _header_first_seen_1) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen_1) / (365.25 / 12)), roundup((sysdate - _header_first_seen_1) / (365.25 / 12))),
                                        -1));

src_bureau_vo_fseen := __common__(  if(max(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
												min(if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') in ['','0'], NULL, (integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') in ['','0'], NULL,(integer) Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ','))), if(NULL = NULL, -NULL, NULL))));

_src_bureau_vo_fseen := __common__(  common.sas_date1800s((string)(src_bureau_vo_fseen)));

mth_ver_src_fdate_vo := __common__(  map(
    not(truedid)                => NULL,
    _src_bureau_vo_fseen = NULL => -1,
                                   if ((sysdate - _src_bureau_vo_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_vo_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_vo_fseen) / (365.25 / 12)))));

src_bureau_vo_lseen := __common__(  if(max(if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
												min(if(if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E'), ','))), if(NULL = NULL, -NULL, NULL))));
												
_src_bureau_vo_lseen := __common__(  common.sas_date1800s((string)(src_bureau_vo_lseen)));

mth_ver_src_ldate_vo := __common__(  map(
    not(truedid)                => NULL,
    _src_bureau_vo_lseen = NULL => -1,
                                   if ((sysdate - _src_bureau_vo_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_vo_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_vo_lseen) / (365.25 / 12)))));

mth_ver_src_fdate_vo60 := __common__(  mth_ver_src_fdate_vo > 60);

mth_ver_src_ldate_vo0 := __common__(  mth_ver_src_ldate_vo = 0);

src_bureau_w_lseen := __common__(  if(max(if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
												min(if(if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ','))), if(NULL = NULL, -NULL, NULL))));

_src_bureau_w_lseen := __common__(  common.sas_date1800s((string)(src_bureau_w_lseen)));

mth_ver_src_ldate_w := __common__(  map(
    not(truedid)               => NULL,
    _src_bureau_w_lseen = NULL => -1,
                                  if ((sysdate - _src_bureau_w_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_w_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_w_lseen) / (365.25 / 12)))));

mth_ver_src_ldate_w0 := __common__(  mth_ver_src_ldate_w = 0);

src_bureau_wp_lseen := __common__(  if(max(if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
												min(if(if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ','))), if(NULL = NULL, -NULL, NULL))));

_src_bureau_wp_lseen := __common__(  common.sas_date1800s((string)(src_bureau_wp_lseen)));

mth_ver_src_ldate_wp := __common__(  map(
    not(truedid)                => NULL,
    _src_bureau_wp_lseen = NULL => -1,
                                   if ((sysdate - _src_bureau_wp_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_wp_lseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_wp_lseen) / (365.25 / 12)))));

mth_ver_src_ldate_wp0 := __common__(  mth_ver_src_ldate_wp = 0);

_paw_first_seen := __common__(  common.sas_date1800s((string)(PAW_first_seen)));

mth_paw_first_seen := __common__(  map(
    not(truedid)           => NULL,
    _paw_first_seen = NULL => -1,
                              if ((sysdate - _paw_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _paw_first_seen) / (365.25 / 12)), roundup((sysdate - _paw_first_seen) / (365.25 / 12)))));

mth_paw_first_seen2 := __common__(  if(mth_paw_first_seen = NULL or mth_paw_first_seen < 6, 6, min(360, if(mth_paw_first_seen = NULL, -NULL, mth_paw_first_seen))));

ver_src_am := __common__(  Models.Common.findw_cpp(ver_sources, 'AM' , ', ', 'E') > 0);

ver_src_e1 := __common__(  Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E') > 0);

ver_src_e2 := __common__(  Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E') > 0);

ver_src_e3 := __common__(  Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E') > 0);

ver_src_pl := __common__(  Models.Common.findw_cpp(ver_sources, 'PL' , ', ', 'E') > 0);

ver_src_w := __common__(  Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E') > 0);

paw_dead_business_count_gt3 := __common__(  paw_dead_business_count > 3);

paw_active_phone_count_0 := __common__(  paw_active_phone_count <= 0);

_infutor_first_seen := __common__(  common.sas_date1800s((string)(infutor_first_seen)));

mth_infutor_first_seen := __common__(  map(
    not(truedid)               => NULL,
    _infutor_first_seen = NULL => NULL,
                                  if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12)))));

_infutor_last_seen := __common__(  common.sas_date1800s((string)(infutor_last_seen)));

mth_infutor_last_seen := __common__(  map(
    not(truedid)              => NULL,
    _infutor_last_seen = NULL => NULL,
                                 if ((sysdate - _infutor_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_last_seen) / (365.25 / 12)), roundup((sysdate - _infutor_last_seen) / (365.25 / 12)))));

infutor_i := __common__(  map(
    infutor_nap = 12 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 1,
    infutor_nap = 12                                                                 => 4,
    infutor_nap = 11 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 3,
    infutor_nap = 11                                                                 => 5,
    infutor_nap >= 7 and (mth_infutor_first_seen >= 36 or mth_infutor_last_seen = 0) => 6,
    infutor_nap >= 7                                                                 => 7,
    (infutor_nap in [1, 6])                                                          => 8,
    (infutor_nap in [0])                                                             => 2,
                                                                                        7));

infutor_im := __common__(  map(
    infutor_i = 1 => 7.77,
    infutor_i = 2 => 8.06,
    infutor_i = 3 => 8.38,
    infutor_i = 4 => 8.96,
    infutor_i = 5 => 9.35,
    infutor_i = 6 => 10.19,
    infutor_i = 7 => 13.13,
    infutor_i = 8 => 14.77,
                     9.03));

src_white_pages_adl_fseen := __common__(  if(max(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') in ['','0'], NULL, 
															(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
															min(if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') in ['','0'], NULL, 
															(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',')) = NULL, -NULL, 
															if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ',') in ['','0'], NULL, 
															(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'WP' , ', ', 'E'), ','))), if(NULL = NULL, -NULL, NULL))));

_src_white_pages_adl_fseen := __common__(  common.sas_date1800s((string)(src_white_pages_adl_fseen)));

iv_sr001_m_wp_adl_fs := __common__(  map(
    not(truedid)                      => NULL,
    _src_white_pages_adl_fseen = NULL => -1,
                                         if ((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_white_pages_adl_fseen) / (365.25 / 12)))));

src_m_wp_adl_fs := __common__(  map(
    iv_sr001_m_wp_adl_fs = NULL => -1,
    iv_sr001_m_wp_adl_fs = -1   => 10,
    iv_sr001_m_wp_adl_fs >= 24  => 24,
                                   iv_sr001_m_wp_adl_fs));

_header_first_seen := __common__(  common.sas_date1800s((string)(header_first_seen)));

iv_sr001_m_hdr_fs := __common__(  map(
    not(truedid)                   => NULL,
    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
                                      -1));

src_m_hdr_fs := __common__(  map(
    iv_sr001_m_hdr_fs = NULL => 15,
    iv_sr001_m_hdr_fs = -1   => 40,
    iv_sr001_m_hdr_fs >= 260 => 260,
                                iv_sr001_m_hdr_fs));

source_mod6_1 := __common__(  -2.350792319 +
    (integer)ver_src_am * -0.611853123 +
    (integer)ver_src_e1 * -0.208450798 +
    (integer)ver_src_e2 * -0.23159296 +
    (integer)ver_src_e3 * -0.415443106 +
    (integer)ver_src_pl * -0.275168358 +
    (integer)mth_ver_src_fdate_vo60 * -0.119660071 +
    (integer)mth_ver_src_ldate_vo0 * -0.322346162 +
    (integer)ver_src_w * -0.232332713 +
    (integer)mth_ver_src_ldate_w0 * -0.371580672 +
    (integer)mth_ver_src_ldate_wp0 * -0.149556634 +
    mth_paw_first_seen2 * -0.002615342 +
    (integer)paw_dead_business_count_gt3 * 1.3423068152 +
    (integer)paw_active_phone_count_0 * 0.3754685927 +
    infutor_im * 0.061827139 +
    src_m_wp_adl_fs * -0.006650973 +
    src_m_hdr_fs * -0.004903484);

source_mod6 := __common__(  exp(source_mod6_1) / (1 + exp(source_mod6_1)));

iv_sr001_source_profile := __common__(  if(not(truedid), NULL, max((real)0, round((100 - 500 * source_mod6)/0.1)*0.1)));


_in_dob := __common__(  if(common.sas_date1800s(in_dob) = NULL, NULL, common.sas_date1800s(in_dob)));

// yr_in_dob := __common__(  if(in_dob = '', -1, roundup(sysdate - _in_dob) / 365.25));
yr_in_dob := __common__(  map(
								in_dob = ''  => -1, 
								in_dob = '0' => 0, 
								(sysdate - _in_dob) / 365.25));   

yr_in_dob_int := __common__(  if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob)));

age_estimate := __common__(  map(
    yr_in_dob_int > 0 => yr_in_dob_int,
    inferred_age > 0  => inferred_age,
                         -1));

iv_ag001_age := __common__(  if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate))));


iv_pl001_bst_addr_lres := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_lres,
                        add2_lres));

iv_pl001_addr_stability_v2 := __common__(  if(not(truedid), ' ', addr_stability_v2));

iv_pl002_avg_mo_per_addr := __common__(  map(
    not(truedid)            => NULL,
    avg_mo_per_addr = -9999 => -1,
    unique_addr_count = 0   => -1,
                               avg_mo_per_addr));

iv_pl002_addrs_15yr := __common__(  if(not(truedid), NULL, addrs_15yr));

src_vehicles_adl_fseen := __common__(  if(max(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'AR' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'AR' , ', ', 'E'), ',')), 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EB' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EB' , ', ', 'E'), ',')), 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'V' , ', ', 'E'), ',')in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'V' , ', ', 'E'), ',')), 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
													min(if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'AR' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'AR' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'AR' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'AR' , ', ', 'E'), ','))), 
													if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EB' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EB' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EB' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EB' , ', ', 'E'), ','))), 
													if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'V' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'V' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'V' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'V' , ', ', 'E'), ','))), 
													if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'W' , ', ', 'E'), ','))), 
													if(NULL = NULL, -NULL, NULL))));

_src_vehicles_adl_fseen := __common__(  common.sas_date1800s((string)(src_vehicles_adl_fseen)));

iv_po001_m_snc_veh_adl_fs := __common__(  map(
    not(truedid)                   => NULL,
    _src_vehicles_adl_fseen = NULL => -1,
                                      if ((sysdate - _src_vehicles_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_vehicles_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_vehicles_adl_fseen) / (365.25 / 12)))));

iv_in001_wealth_index := __common__(  if(not(truedid), ' ', wealth_index));

iv_in001_college_income := __common__(  map(
    not(truedid)                 => '  ',
    ams_income_level_code = ''   => '-1',
                                    ams_income_level_code));

bst_addr_avm_auto_val_2 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation_2,
                        add2_avm_automated_valuation_2));

iv_pv001_bst_avm_chg_1yr_1 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL));

iv_pv001_bst_avm_chg_1yr_pct_1 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL));

bst_addr_avm_auto_val_1_2 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation));

iv_pv001_bst_avm_chg_1yr := __common__(  if(bst_addr_avm_auto_val_1_2 > 0 and bst_addr_avm_auto_val_2 > 0, bst_addr_avm_auto_val_1_2 - bst_addr_avm_auto_val_2, NULL));

iv_pv001_bst_avm_chg_1yr_pct := __common__(  if(bst_addr_avm_auto_val_1_2 > 0 and bst_addr_avm_auto_val_2 > 0, round(100 * bst_addr_avm_auto_val_1_2 / bst_addr_avm_auto_val_2/0.1)*0.1, NULL));

iv_pots_phone := __common__(  (telcordia_type in ['00', '50', '51', '52', '54']));

iv_add_apt := __common__(  StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ');

iv_phnpop_x_nap_summary_1 := __common__(  map(
    not(hphnpop or addrpop) => '   ',
    hphnpop                 => (string3)(nap_summary + 100),
                               (string3)intformat(nap_summary,3,1)));

iv_nas_summary := __common__(  if(not(truedid or (integer)ssnlength > 0), NULL, nas_summary));

iv_dl_val_flag := __common__(  map(
    not(truedid)       => '         ',
    not(dl_avail)      => 'Not Avail',
    rc_dl_val_flag = '0' => 'Valid    ',
    rc_dl_val_flag = '2' => 'Empty    ',
                          'Invalid  '));

iv_src_bureau_adl_count := __common__(  if(not(truedid), NULL, max(if(max((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ','), 
														(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ','), 
														(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ','), 
														(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ','), 
														(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')) = NULL, NULL, 
														sum(if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ',') = NULL, 0, 
														(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'TN' , ', ', 'E'), ',')), 
														if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ',') = NULL, 0, 
														(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'TS' , ', ', 'E'), ',')), 
														if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ',') = NULL, 0, 
														(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'TU' , ', ', 'E'), ',')), 
														if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',') = NULL, 0, 
														(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',')), 
														if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',') = NULL, 0, 
														(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')))), 0)));

src_bureau_lname_fseen := __common__(  if(max(if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TN' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TN' , ', ', 'E'), ',')), 
														if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TS' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TS' , ', ', 'E'), ',')), 
														if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TU' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TU' , ', ', 'E'), ',')), 
														if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EN' , ', ', 'E'), ',')), 
														if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EQ' , ', ', 'E'), ','))) = NULL, NULL, 
														min(if(if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TN' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TN' , ', ', 'E'), ',')) = NULL, -NULL, 
														if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TN' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TN' , ', ', 'E'), ','))), 
														if(if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TS' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TS' , ', ', 'E'), ',')) = NULL, -NULL, 
														if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TS' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TS' , ', ', 'E'), ','))), 
														if(if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TU' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TU' , ', ', 'E'), ',')) = NULL, -NULL, 
														if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TU' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'TU' , ', ', 'E'), ','))), 
														if(if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EN' , ', ', 'E'), ',')) = NULL, -NULL, 
														if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EN' , ', ', 'E'), ','))), 
														if(if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EQ' , ', ', 'E'), ',')) = NULL, -NULL, 
														if(Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL, 
														(integer)Models.Common.getw(ver_lname_sources_first_seen, Models.Common.findw_cpp(ver_lname_sources, 'EQ' , ', ', 'E'), ','))))));

_src_bureau_lname_fseen := __common__(  common.sas_date1800s((string)(src_bureau_lname_fseen)));

iv_mos_src_bureau_lname_fseen := __common__(  map(
    not(truedid)                   => NULL,
    _src_bureau_lname_fseen = NULL => -1,
                                      if ((sysdate - _src_bureau_lname_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_lname_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_lname_fseen) / (365.25 / 12)))));

src_bureau_dob_fseen := __common__(  if(max(if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TN' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TN' , ', ', 'E'), ',')), 
												if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TS' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TS' , ', ', 'E'), ',')), 
												if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TU' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TU' , ', ', 'E'), ',')), 
												if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EN' , ', ', 'E'), ',')), 
												if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EQ' , ', ', 'E'), ','))) = NULL, NULL, 
												min(if(if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TN' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TN' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TN' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TN' , ', ', 'E'), ','))), 
												if(if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TS' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TS' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TS' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TS' , ', ', 'E'), ','))), 
												if(if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TU' , ', ', 'E'), ',') in ['','0'], NULL,
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TU' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TU' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'TU' , ', ', 'E'), ','))), 
												if(if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EN' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EN' , ', ', 'E'), ','))), 
												if(if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EQ' , ', ', 'E'), ',')) = NULL, -NULL,
												if(Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL,
												(integer)Models.Common.getw(ver_dob_sources_first_seen, Models.Common.findw_cpp(ver_dob_sources, 'EQ' , ', ', 'E'), ','))))));

_src_bureau_dob_fseen := __common__(  common.sas_date1800s((string)(src_bureau_dob_fseen)));

iv_mos_src_bureau_dob_fseen := __common__(  map(
    not(truedid)                 => NULL,
    _src_bureau_dob_fseen = NULL => -1,
                                    if ((sysdate - _src_bureau_dob_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_dob_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_dob_fseen) / (365.25 / 12)))));

iv_src_experian_adl_count := __common__(  if(not(truedid), NULL, max(if(max((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',')) = NULL, NULL, 
															sum(if((integer)Models.Common.getw(ver_sources_count, (integer)Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',') = NULL, 0, 
															(integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',')))), 0)));

src_experian_adl_fseen := __common__(  if(max(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
													min(if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',')) = NULL, -NULL, 
													if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EN' , ', ', 'E'), ','))), 
													if(NULL = NULL, -NULL, NULL))));

_src_experian_adl_fseen := __common__(  common.sas_date1800s((string)(src_experian_adl_fseen)));

iv_mos_src_experian_adl_fseen := __common__(  map(
    not(truedid)                   => NULL,
    _src_experian_adl_fseen = NULL => -1,
                                      if ((sysdate - _src_experian_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_experian_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_experian_adl_fseen) / (365.25 / 12)))));

iv_src_equifax_adl_count := __common__(  if(not(truedid), NULL, max(if(max((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')) = NULL, NULL, sum(if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',') = NULL, 0, (integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')))), 0)));

src_equifax_adl_lseen := __common__(  max((real)if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',') in ['','0'], NULL, 
													(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E'), ',')), NULL));

_src_equifax_adl_lseen := __common__(  common.sas_date1800s((string)(src_equifax_adl_lseen)));

iv_mos_src_equifax_adl_lseen := __common__(  map(
    not(truedid)                  => NULL,
    _src_equifax_adl_lseen = NULL => -1,
                                     if ((sysdate - _src_equifax_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_equifax_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_equifax_adl_lseen) / (365.25 / 12)))));

src_property_adl_lseen := __common__(  max((real)if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',') in ['','0'], NULL,
													(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E'), ',')), NULL));

_src_property_adl_lseen := __common__(  common.sas_date1800s((string)(src_property_adl_lseen)));

iv_mos_src_property_adl_lseen := __common__(  map(
    not(truedid)                   => NULL,
    _src_property_adl_lseen = NULL => -1,
                                      if ((sysdate - _src_property_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_property_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_property_adl_lseen) / (365.25 / 12)))));

iv_src_drivers_lic_adl_count := __common__(  map(
    not(truedid)  => NULL,
    not(dl_avail) => -1,
                     max(if(max((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ','), 
										 (integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',')) = NULL, NULL, 
										 sum(if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ',') = NULL, 0, 
										 (integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ',')), 
										 if((integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',') = NULL, 0, 
										 (integer)Models.Common.getw(ver_sources_count, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',')))), 0)));

src_drivers_lic_adl_fseen := __common__(  if(max(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ',') in ['','0'], NULL, 
															(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ',')), 
															if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',') in ['','0'], NULL, 
															(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
															min(if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ',') in ['','0'], NULL, 
															(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ',')) = NULL, -NULL, 
															if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ',') in ['','0'], NULL, 
															(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ','))), 
															if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',') in ['','0'], NULL,
															(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',')) = NULL, -NULL, 
															if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',') in ['','0'], NULL, 
															(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ','))), if(NULL = NULL, -NULL, NULL))));

_src_drivers_lic_adl_fseen := __common__(  common.sas_date1800s((string)(src_drivers_lic_adl_fseen)));

iv_mos_src_drivers_lic_adl_fseen := __common__(  map(
    not(truedid)                      => NULL,
    not(dl_avail)                     => -1,
    _src_drivers_lic_adl_fseen = NULL => -1,
                                         if ((sysdate - _src_drivers_lic_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_drivers_lic_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_drivers_lic_adl_fseen) / (365.25 / 12)))));

src_drivers_lic_adl_lseen := __common__(  max((real)if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ',') in ['','0'], NULL, 
																(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'D' , ', ', 'E'), ',')), 
																(real)if(Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',') in ['','0'], NULL, 
																(integer)Models.Common.getw(ver_sources_last_seen, Models.Common.findw_cpp(ver_sources, 'DL' , ', ', 'E'), ',')), NULL));

_src_drivers_lic_adl_lseen := __common__(  common.sas_date1800s((string)(src_drivers_lic_adl_lseen)));

iv_mos_src_drivers_lic_adl_lseen := __common__(  map(
    not(truedid)                      => NULL,
    not(dl_avail)                     => -1,
    _src_drivers_lic_adl_lseen = NULL => -1,
                                         if ((sysdate - _src_drivers_lic_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_drivers_lic_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_drivers_lic_adl_lseen) / (365.25 / 12)))));

src_emerge_adl_fseen := __common__(  if(max(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E'), ',')), 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E'), ',')), 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E'), ',')), 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E'), ',')), 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E'), ',') = '0', NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E'), ',')), NULL) = NULL, NULL, 
												min(if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'EM' , ', ', 'E'), ','))), 
												if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E1' , ', ', 'E'), ','))), 
												if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E2' , ', ', 'E'), ','))), 
												if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E3' , ', ', 'E'), ','))), 
												if(if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E'), ',')) = NULL, -NULL, 
												if(Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E'), ',') in ['','0'], NULL, 
												(integer)Models.Common.getw(ver_sources_first_seen, Models.Common.findw_cpp(ver_sources, 'E4' , ', ', 'E'), ','))), 
												if(NULL = NULL, -NULL, NULL))));

_src_emerge_adl_fseen := __common__(  common.sas_date1800s((string)(src_emerge_adl_fseen)));

iv_mos_src_emerge_adl_fseen := __common__(  map(
    not(truedid)                 => NULL,
    _src_emerge_adl_fseen = NULL => -1,
                                    if ((sysdate - _src_emerge_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_emerge_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_emerge_adl_fseen) / (365.25 / 12)))));

iv_lname_score := __common__(  if(not(truedid and lnamepop), NULL, lname_score));

_lname_change_date := __common__(  common.sas_date1800s((string)(lname_change_date)));

iv_mos_since_lname_change := __common__(  map(
    not((integer)ssnlength > 0)       => NULL,
    _lname_change_date = NULL 				=> 	-1,
    if ((sysdate - _lname_change_date) / (365.25 / 12) >= 0, truncate((sysdate - _lname_change_date) / (365.25 / 12)), roundup((sysdate - _lname_change_date) / (365.25 / 12)))));

iv_fname_eda_sourced_type_1 := __common__(  map(
    not((hphnpop or addrpop) and fnamepop) => '  ',
    fname_eda_sourced_type = ''            => '-1',
                                              fname_eda_sourced_type));

iv_input_dob_match_level := __common__(  if(not(truedid and dobpop), '', input_dob_match_level));

iv_phn_miskey := __common__(  if(not(truedid and (hphnpop or addrpop)), '', if(rc_hphonemiskeyflag, '1', '0')));

iv_addr_miskey := __common__(  if(not(truedid and (hphnpop or addrpop)), '', if(rc_addrmiskeyflag, '1', '0')));

iv_adl_util_convenience := __common__(  if(not(truedid), '', if(contains_i(util_adl_type_list, '2') > 0, '1', '0')));

iv_adl_util_infrastructure := __common__(  if(not(truedid), '', if(contains_i(util_adl_type_list, '1') > 0, '1', '0')));

iv_add1_util_infrastructure := __common__(  if(not(add1_pop), '', if(contains_i(util_add1_type_list, '1') > 0, '1', '0')));

iv_inp_own_prop_x_addr_naprop := __common__(  map(
    not(add1_pop)            => '  ',
property_owned_total > 0 		 => (string2)(add1_naprop + 10),
                                (string2)intformat(add1_naprop,2,1)) );

iv_inp_addr_mortgage_amount := __common__(  if(not(add1_pop), NULL, add1_mortgage_amount));

_add1_mortgage_date_1 := __common__(  common.sas_date1800s((string)(add1_mortgage_date)));

_add1_mortgage_due_date_1 := __common__(  common.sas_date1800s((string)(add1_mortgage_due_date)));

mortgage_date_diff_2 := __common__(  if(not(_add1_mortgage_date_1 = NULL) and not(_add1_mortgage_due_date_1 = NULL), round((_add1_mortgage_due_date_1 - _add1_mortgage_date_1) / 365.25), NULL));

iv_inp_addr_mortgage_term := __common__(  map(
    not(add1_pop)              => '  ',
    mortgage_date_diff_2 >= 40 => '40',
    mortgage_date_diff_2 >= 30 => '30',
    mortgage_date_diff_2 >= 25 => '25',
    mortgage_date_diff_2 >= 20 => '20',
    mortgage_date_diff_2 >= 15 => '15',
    mortgage_date_diff_2 >= 10 => '10',
    mortgage_date_diff_2 >= 5  => ' 5',
    mortgage_date_diff_2 >= 0  => ' 0',
                                  '-1'));

mortgage_type_2 := __common__(  add1_mortgage_type);

mortgage_present_2 := __common__(  not((add1_mortgage_date in [0,NULL])));

iv_inp_addr_mortgage_type := __common__(  map(
    not(add1_pop)                                           => '               ',
    (mortgage_type_2 in ['CNV', 'N'])                       => 'Conventional   ',
    (mortgage_type_2 in ['FHA', 'G', 'VA'])                 => 'Government     ',
    (mortgage_type_2 in ['1', 'D'])                         => 'Piggyback      ',
    (mortgage_type_2 in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
    (mortgage_type_2 in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
    (mortgage_type_2 in ['H', 'J'])                         => 'High-Risk      ',
    (mortgage_type_2 in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
    (mortgage_type_2 in ['U'])                              => 'Unknown        ',
    not(mortgage_type_2 = ''  )                             => 'Other          ',
    mortgage_present_2                                      => 'Unknown        ',
                                                               'No Mortgage'));

iv_inp_addr_financing_type := __common__(  map(
    not(add1_pop)              => '     ',
    add1_financing_type = ''   => 'NONE ',
                                  add1_financing_type));

iv_inp_addr_assessed_total_val := __common__(  if(not(add1_pop), NULL, add1_assessed_total_value));

inp_addr_fips_fall := __common__(  map(
    add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
    add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
    add1_avm_med_fips > 0  => add1_avm_med_fips,
                              0));

inp_addr_avm_auto_val := __common__(  add1_avm_automated_valuation);

iv_inp_addr_fips_ratio := __common__(  map(
    not(add1_pop)          => NULL,
    inp_addr_fips_fall > 0 => inp_addr_avm_auto_val / inp_addr_fips_fall,
                              -1));

iv_inp_addr_building_area := __common__(  if(not(add1_pop), NULL, add1_building_area));

iv_inp_nhood_num_vacant := __common__(  if(not(add1_pop), NULL, add1_nhood_vacant_properties));

iv_inp_nhood_num_sfd := __common__(  if(not(add1_pop), NULL, add1_nhood_sfd_count));

iv_inp_addr_avm_change_2yr_1 := __common__(  map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_3 > 0 => add1_avm_automated_valuation - add1_avm_automated_valuation_3,
                                                                               NULL));

iv_inp_addr_avm_pct_change_2yr := __common__(  map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_3 > 0 => add1_avm_automated_valuation / add1_avm_automated_valuation_3,
                                                                               NULL));

iv_inp_addr_avm_change_2yr := __common__(  map(
    not(add1_pop)                                                           => iv_inp_addr_avm_change_2yr_1,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_3 > 0 => iv_inp_addr_avm_change_2yr_1,
                                                                               NULL));

iv_inp_addr_avm_change_3yr := __common__(  map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_4 > 0 => NULL,
                                                                               NULL));

iv_inp_addr_avm_pct_change_3yr := __common__(  map(
    not(add1_pop)                                                           => NULL,
    add1_avm_automated_valuation > 0 and add1_avm_automated_valuation_4 > 0 => add1_avm_automated_valuation / add1_avm_automated_valuation_4,
                                                                               NULL));


iv_bst_own_prop_x_addr_naprop_c105 := __common__(  if(property_owned_total > 0, (string2)(add1_naprop + 10), (string2)intformat(add1_naprop, 2,1)) );

iv_bst_own_prop_x_addr_naprop_c106 := __common__(  if(property_owned_total > 0, (string2)(add2_naprop + 10), (string2)intformat(add2_naprop,2,1)));

iv_bst_own_prop_x_addr_naprop := __common__(  map(
    not(truedid)     => '  ',
    add1_isbestmatch => iv_bst_own_prop_x_addr_naprop_c105,
                        iv_bst_own_prop_x_addr_naprop_c106));

bst_addr_avm_auto_val := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation));

bst_addr_mortgage_amount := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_mortgage_amount,
                        add2_mortgage_amount));

iv_bst_addr_mtg_avm_pct_diff := __common__(  if(bst_addr_mortgage_amount <= 0 or bst_addr_avm_auto_val <= 0, NULL, bst_addr_avm_auto_val / bst_addr_mortgage_amount));

_add1_mortgage_date_c110_b2 := __common__(  common.sas_date1800s((string)(add1_mortgage_date)));

_add1_mortgage_due_date_c110_b2 := __common__(  common.sas_date1800s((string)(add1_mortgage_due_date)));

mortgage_date_diff_c111 := __common__(  if(not(_add1_mortgage_date_c110_b2 = NULL) and not(_add1_mortgage_due_date_c110_b2 = NULL), round((_add1_mortgage_due_date_c110_b2 - _add1_mortgage_date_c110_b2) / 365.25), NULL));

_add2_mortgage_date_c110_b3 := __common__(  common.sas_date1800s((string)(add2_mortgage_date)));

_add2_mortgage_due_date_c110_b3 := __common__(  common.sas_date1800s((string)(add2_mortgage_due_date)));

mortgage_date_diff_c112 := __common__(  if(not(_add2_mortgage_date_c110_b3 = NULL) and not(_add2_mortgage_due_date_c110_b3 = NULL), round((_add2_mortgage_due_date_c110_b3 - _add2_mortgage_date_c110_b3) / 365.25), NULL));

// iv_bst_addr_mortgage_term_1 := __common__(  map(       //variable not used MLW
    // not(truedid)     => '',
    // add1_isbestmatch => NULL,
                        // NULL));

_add1_mortgage_due_date := __common__(  map(
    not(truedid)     => _add1_mortgage_due_date_1,
    add1_isbestmatch => common.sas_date1800s((string)(add1_mortgage_due_date)),
                        _add1_mortgage_due_date_1));

_add1_mortgage_date := __common__(  map(
    not(truedid)     => _add1_mortgage_date_1,
    add1_isbestmatch => common.sas_date1800s((string)(add1_mortgage_date)),
                        _add1_mortgage_date_1));

mortgage_date_diff_1 := __common__(  map(
    not(truedid)     => mortgage_date_diff_2,
    add1_isbestmatch => mortgage_date_diff_c111,
                        mortgage_date_diff_c112));

_add2_mortgage_due_date_1 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        common.sas_date1800s((string)(add2_mortgage_due_date))));

_add2_mortgage_date_1 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        common.sas_date1800s((string)(add2_mortgage_date))));

iv_bst_addr_mortgage_term := __common__(  map(
    not(truedid)               => NULL,
    mortgage_date_diff_1 >= 40 => 40,
    mortgage_date_diff_1 >= 30 => 30,
    mortgage_date_diff_1 >= 25 => 25,
    mortgage_date_diff_1 >= 20 => 20,
    mortgage_date_diff_1 >= 15 => 15,
    mortgage_date_diff_1 >= 10 => 10,
    mortgage_date_diff_1 >= 5  => 5,
    mortgage_date_diff_1 >= 0  => 0,
                                  -1));

mortgage_type_1 := __common__(  if(add1_isbestmatch, add1_mortgage_type, add2_mortgage_type));

mortgage_present_1 := __common__(  if(add1_isbestmatch, not((add1_mortgage_date in [0, NULL])), not((add2_mortgage_date in [0, NULL]))));

iv_bst_addr_mortgage_type := __common__(  map(
    not(truedid)                                            => '               ',
    (mortgage_type_1 in ['CNV', 'N'])                       => 'Conventional   ',
    (mortgage_type_1 in ['FHA', 'G', 'VA'])                 => 'Government     ',
    (mortgage_type_1 in ['1', 'D'])                         => 'Piggyback      ',
    (mortgage_type_1 in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
    (mortgage_type_1 in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
    (mortgage_type_1 in ['H', 'J'])                         => 'High-Risk      ',
    (mortgage_type_1 in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
    (mortgage_type_1 in ['U'])                              => 'Unknown        ',
    not(mortgage_type_1 = '')                               => 'Other          ',
    mortgage_present_1                                      => 'Unknown        ',
                                                               'No Mortgage'));

iv_bst_addr_financing_type_c117 := __common__(  if(add1_financing_type = '', 'NONE ', add1_financing_type));

iv_bst_addr_financing_type_c118 := __common__(  if(add2_financing_type = '', 'NONE ', add2_financing_type));

iv_bst_addr_financing_type := __common__(  map(
    not(truedid)     => '     ',
    add1_isbestmatch => iv_bst_addr_financing_type_c117,
                        iv_bst_addr_financing_type_c118));

iv_bst_addr_avm_pct_change_2yr_1 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL));

bst_addr_avm_auto_val_3 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation_3,
                        add2_avm_automated_valuation_3));

bst_addr_avm_auto_val_1_1 := __common__(  map(
    not(truedid)     => bst_addr_avm_auto_val_1_2,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation));

iv_bst_addr_avm_pct_change_2yr := __common__(  if(bst_addr_avm_auto_val_1_1 > 0 and bst_addr_avm_auto_val_3 > 0, bst_addr_avm_auto_val_1_1 / bst_addr_avm_auto_val_3, NULL));

bst_addr_avm_auto_val_4 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation_4,
                        add2_avm_automated_valuation_4));

iv_bst_addr_avm_pct_change_3yr_1 := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        NULL));

bst_addr_avm_auto_val_1 := __common__(  map(
    not(truedid)     => bst_addr_avm_auto_val_1_1,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation));

iv_bst_addr_avm_pct_change_3yr := __common__(  if(bst_addr_avm_auto_val_1 > 0 and bst_addr_avm_auto_val_4 > 0, bst_addr_avm_auto_val_1 / bst_addr_avm_auto_val_4, NULL));

iv_prv_addr_source_count := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_source_count,
                        add3_source_count));


iv_prv_own_prop_x_addr_naprop_c125 := __common__(  if(property_owned_total > 0, (string2)(add2_naprop + 10), (string2)intformat(add2_naprop,2,1)));


iv_prv_own_prop_x_addr_naprop_c126 := __common__(  if(property_owned_total > 0, (string2)(add3_naprop + 10), (string2)intformat(add3_naprop, 2,1)));

iv_prv_own_prop_x_addr_naprop := __common__(  map(
    not(truedid)     => '  ',
    add1_isbestmatch => iv_prv_own_prop_x_addr_naprop_c125,
                        iv_prv_own_prop_x_addr_naprop_c126));

_add2_mortgage_date_c127_b2 := __common__(  common.sas_date1800s((string)(add2_mortgage_date)));

_add2_mortgage_due_date_c127_b2 := __common__(  common.sas_date1800s((string)(add2_mortgage_due_date)));

mortgage_date_diff_c128 := __common__(  if(not(_add2_mortgage_date_c127_b2 = NULL) and not(_add2_mortgage_due_date_c127_b2 = NULL), round((_add2_mortgage_due_date_c127_b2 - _add2_mortgage_date_c127_b2) / 365.25), NULL));

_add3_mortgage_date_c127_b3 := __common__(  common.sas_date1800s((string)(add3_mortgage_date)));

_add3_mortgage_due_date_c127_b3 := __common__(  common.sas_date1800s((string)(add3_mortgage_due_date)));

mortgage_date_diff_c129 := __common__(  if(not(_add3_mortgage_date_c127_b3 = NULL) and not(_add3_mortgage_due_date_c127_b3 = NULL), round((_add3_mortgage_due_date_c127_b3 - _add3_mortgage_date_c127_b3) / 365.25), NULL));

// iv_prv_addr_mortgage_term_1 := __common__(  map(
    // not(truedid)     => '',
    // add1_isbestmatch => NULL,
                        // NULL));

_add2_mortgage_due_date := __common__(  map(
    not(truedid)     => _add2_mortgage_due_date_1,
    add1_isbestmatch => common.sas_date1800s((string)(add2_mortgage_due_date)),
                        _add2_mortgage_due_date_1));

mortgage_date_diff := __common__(  map(
    not(truedid)     => mortgage_date_diff_1,
    add1_isbestmatch => mortgage_date_diff_c128,
                        mortgage_date_diff_c129));

_add3_mortgage_date := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        common.sas_date1800s((string)(add3_mortgage_date))));

_add3_mortgage_due_date := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => NULL,
                        common.sas_date1800s((string)(add3_mortgage_due_date))));

_add2_mortgage_date := __common__(  map(
    not(truedid)     => _add2_mortgage_date_1,
    add1_isbestmatch => common.sas_date1800s((string)(add2_mortgage_date)),
                        _add2_mortgage_date_1));

iv_prv_addr_mortgage_term := __common__(  map(
    not(truedid)             => '  ',
    mortgage_date_diff >= 40 => '40',
    mortgage_date_diff >= 30 => '30',
    mortgage_date_diff >= 25 => '25',
    mortgage_date_diff >= 20 => '20',
    mortgage_date_diff >= 15 => '15',
    mortgage_date_diff >= 10 => '10',
    mortgage_date_diff >= 5  => ' 5',
    mortgage_date_diff >= 0  => ' 0',
                                '-1'));

mortgage_type := __common__(  if(add1_isbestmatch, add2_mortgage_type, add3_mortgage_type));

mortgage_present := __common__(  if(add1_isbestmatch, not((add2_mortgage_date in [0, NULL])), not((add3_mortgage_date in [0, NULL]))));

iv_prv_addr_mortgage_type := __common__(  map(
    not(truedid)                                          => '               ',
    (mortgage_type in ['CNV', 'N'])                       => 'Conventional   ',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'Government     ',
    (mortgage_type in ['1', 'D'])                         => 'Piggyback      ',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'Equity Loan    ',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'Commercial     ',
    (mortgage_type in ['H', 'J'])                         => 'High-Risk      ',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'Non-Traditional',
    (mortgage_type in ['U'])                              => 'Unknown        ',
    not(mortgage_type = '')                               => 'Other          ',
    mortgage_present                                      => 'Unknown        ',
                                                             'No Mortgage'));

iv_prv_addr_financing_type_c134 := __common__(  if(add2_financing_type = '', 'NONE ', add2_financing_type));

iv_prv_addr_financing_type_c135 := __common__(  if(add3_financing_type = '', 'NONE ', add3_financing_type));

iv_prv_addr_financing_type := __common__(  map(
    not(truedid)     => '     ',
    add1_isbestmatch => iv_prv_addr_financing_type_c134,
                        iv_prv_addr_financing_type_c135));

iv_prop_sold_assessed_total := __common__(  if(not(truedid or add1_pop), NULL, property_sold_assessed_total));

iv_prop_sold_assessed_count := __common__(  if(not(truedid or add1_pop), NULL, property_sold_assessed_count));

iv_purch_sold_val_diff := __common__(  map(
    not(truedid or add1_pop)          => NULL,
    property_owned_purchase_total = 0 => NULL,
    property_sold_purchase_total = 0  => NULL,
                                         property_owned_purchase_total - property_sold_purchase_total));

_prop1_sale_date := __common__(  common.sas_date1800s((string)(prop1_sale_date)));

iv_mos_since_prop1_sale := __common__(  map(
    not(truedid)                 => NULL,
    not(_prop1_sale_date = NULL) => if ((sysdate - _prop1_sale_date) / (365.25 / 12) >= 0, truncate((sysdate - _prop1_sale_date) / (365.25 / 12)), roundup((sysdate - _prop1_sale_date) / (365.25 / 12))),
                                    -1));

iv_prop1_purch_sale_diff := __common__(  map(
    not(truedid)                                           => NULL,
    prop1_prev_purchase_price > 0 and prop1_sale_price > 0 => prop1_sale_price - prop1_prev_purchase_price,
                                                              NULL));

iv_dist_inp_addr_to_prv_addr := __common__(  map(
    not(truedid)     => NULL,
    add1_isbestmatch => dist_a1toa2,
                        dist_a1toa3));

iv_avg_lres := __common__(  if(not(truedid), NULL, avg_lres));

iv_addr_lres_12mo_count := __common__(  map(
    not(truedid)                 => NULL,
    addr_lres_12mo_count = -9999 => -1,
                                    addr_lres_12mo_count));

iv_phones_per_apt_addr := __common__(  map(
    not(add1_pop)   => NULL,
    not(iv_add_apt) => -1,
                       phones_per_addr));

iv_phones_per_addr_c6 := __common__(  if(not(add1_pop), NULL, phones_per_addr_c6));

iv_adls_per_pots_phone_c6 := __common__(  map(
    not(hphnpop)       => NULL,
    not(iv_pots_phone) => -1,
                          adls_per_phone_c6));

iv_credit_seeking := __common__(  if(not(truedid), NULL, if(max(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)), min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)), min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)), min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)), min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03))) = NULL, NULL, sum(if(min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03)) = NULL, 0, min(2, if(inq_auto_count03 = NULL, -NULL, inq_auto_count03))), if(min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03)) = NULL, 0, min(2, if(inq_banking_count03 = NULL, -NULL, inq_banking_count03))), if(min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03)) = NULL, 0, min(2, if(inq_mortgage_count03 = NULL, -NULL, inq_mortgage_count03))), if(min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03)) = NULL, 0, min(2, if(inq_retail_count03 = NULL, -NULL, inq_retail_count03))), if(min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)) = NULL, 0, min(2, if(inq_communications_count03 = NULL, -NULL, inq_communications_count03)))))));

iv_inq_addr_ver_count := __common__(  if(not(truedid and add1_pop), NULL, inq_addr_ver_count));

iv_inq_lname_ver_count := __common__(  if(not(truedid and lnamepop), NULL, inq_lname_ver_count));

iv_inq_ssn_ver_count := __common__(  if(not(truedid and (integer)ssnlength > 0), NULL, inq_ssn_ver_count));

iv_inq_dob_ver_count := __common__(  if(not(truedid and dobpop), NULL, inq_dob_ver_count));

iv_inq_phone_ver_count := __common__(  if(not(truedid and hphnpop), NULL, inq_phone_ver_count));

iv_inq_highriskcredit_recency := __common__(  map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 > 0 => 1,
    inq_highRiskCredit_count03 > 0 => 3,
    inq_highRiskCredit_count06 > 0 => 6,
    inq_highRiskCredit_count12 > 0 => 12,
    inq_highRiskCredit_count24 > 0 => 24,
    inq_highRiskCredit_count   > 0 => 99,
                                  0));

iv_inq_num_diff_names_per_adl := __common__(  if(not(truedid), NULL, max(inq_fnamesperadl, inq_lnamesperadl)));

iv_inq_adls_per_ssn := __common__(  if(not((integer)ssnlength > 0), NULL, inq_adlsperssn));

iv_inq_per_addr := __common__(  if(not(add1_pop), NULL, inq_peraddr));

iv_paw_dead_bus_x_active_phn := __common__(  if(not(truedid), '   ', trim((string)min(paw_dead_business_count,3), all) + trim(' - ', LEFT, RIGHT) + trim((string)min(paw_active_phone_count,3),all)));

iv_infutor_nap := __common__(  if(not(hphnpop), NULL, infutor_nap));

ver_phn_inf := __common__(  (infutor_nap in [4, 6, 7, 9, 10, 11, 12]));

ver_phn_nap := __common__(  (nap_summary in [4, 6, 7, 9, 10, 11, 12]));

inf_phn_ver_lvl := __common__(  map(
    ver_phn_inf     => 3,
    infutor_nap = 1 => 1,
    infutor_nap = 0 => 0,
                       2));

nap_phn_ver_lvl := __common__(  map(
    ver_phn_nap     => 3,
    nap_summary = 1 => 1,
    nap_summary = 0 => 0,
                       2));

iv_nap_phn_ver_x_inf_phn_ver_1 := __common__(  map(
    not(addrpop or hphnpop) => '   ',
    not(hphnpop)            => ' -1',
                               trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT)));

iv_num_purch_x_num_sold_60 := __common__(  if(not(truedid), '   ', trim((string)min(if(attr_num_purchase60 = NULL, -NULL, attr_num_purchase60), 2), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(attr_num_sold60 = NULL, -NULL, attr_num_sold60), 2), LEFT, RIGHT)));

iv_rec_vehx_level := __common__(  map(
    not(truedid)                                   => '  ',
    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
    attr_num_aircraft > 0                          => 'AO',
    watercraft_count > 0                           => 'W' + trim((string)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
                                                      'XX'));

iv_derog_ratio := __common__(  map(
    not(truedid)                                            => NULL,
    attr_num_nonderogs = 0 and attr_total_number_derogs = 0 => -1,
    attr_num_nonderogs > 0 and attr_total_number_derogs = 0 => 100 + 10 * min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 10),
                                                               if (attr_total_number_derogs / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) * 10 >= 0, roundup(attr_total_number_derogs / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) * 10), truncate(attr_total_number_derogs / if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs))) * 10)) * 10));

iv_liens_unrel_x_rel := __common__(  if(not(truedid), '   ', trim((string)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, 
												sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), 
												if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, 
												if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, 
												sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), 
												if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + 
												trim(' - ', LEFT, RIGHT) + trim((string)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, 
												sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), 
												if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, 
												if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, 
												sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), 
												if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT)));

iv_liens_unrel_x_rel_cj := __common__(  if(not(truedid), '   ', trim((string)min(if(liens_unrel_CJ_ct = NULL, -NULL, liens_unrel_CJ_ct), 3), LEFT, RIGHT) + 
														'-' + trim((string)min(if(liens_rel_CJ_ct = NULL, -NULL, liens_rel_CJ_ct), 2), LEFT, RIGHT)));

iv_liens_unrel_x_rel_ft := __common__(  if(not(truedid), '   ', trim((string)min(if(liens_unrel_FT_ct = NULL, -NULL, liens_unrel_FT_ct), 3), LEFT, RIGHT) + 
														'-' + trim((string)min(if(liens_rel_FT_ct = NULL, -NULL, liens_rel_FT_ct), 2), LEFT, RIGHT)));

iv_liens_unrel_x_rel_fc := __common__(  if(not(truedid), '   ', trim((string)min(if(liens_unrel_FC_ct = NULL, -NULL, liens_unrel_FC_ct), 3), LEFT, RIGHT) + 
														'-' + trim((string)min(if(liens_rel_FC_ct = NULL, -NULL, liens_rel_FC_ct), 2), LEFT, RIGHT)));

iv_liens_unrel_x_rel_o := __common__(  if(not(truedid), '   ', trim((string)min(if(liens_unrel_O_ct = NULL, -NULL, liens_unrel_O_ct), 3), LEFT, RIGHT) + 
													'-' + trim((string)min(if(liens_rel_O_ct = NULL, -NULL, liens_rel_O_ct), 2), LEFT, RIGHT)));

iv_liens_unrel_x_rel_ot := __common__(  if(not(truedid), '   ', trim((string)min(if(liens_unrel_OT_ct = NULL, -NULL, liens_unrel_OT_ct), 3), LEFT, RIGHT) + 
													'-' + trim((string)min(if(liens_rel_OT_ct = NULL, -NULL, liens_rel_OT_ct), 2), LEFT, RIGHT)));

iv_liens_unrel_x_rel_sc := __common__(  if(not(truedid), '   ', trim((string)min(if(liens_unrel_SC_ct = NULL, -NULL, liens_unrel_SC_ct), 3), LEFT, RIGHT) + 
													'-' + trim((string)min(if(liens_rel_SC_ct = NULL, -NULL, liens_rel_SC_ct), 2), LEFT, RIGHT)));

iv_criminal_x_felony := __common__(  if(not(truedid), '   ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + 
												'-' + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT)));

iv_average_rel_income := __common__(  map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 => -1,
    if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     if (if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) >= 0, truncate(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count)))), roundup(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))))) * 1000));

iv_average_rel_age := __common__(  map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              => -1,
    if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  if (if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) >= 0, truncate(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))), roundup(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))))));

iv_oldest_rel_age := __common__(  map(
    not(truedid)             => NULL,
    rel_count = 0            => -1,
    rel_ageover70_count > 0  => 80,
    rel_ageunder70_count > 0 => 70,
    rel_ageunder60_count > 0 => 60,
    rel_ageunder50_count > 0 => 50,
    rel_ageunder40_count > 0 => 40,
    rel_ageunder30_count > 0 => 30,
    rel_ageunder20_count > 0 => 20,
                                0));

iv_average_rel_distance := __common__(  map(
    not(truedid)                                             => NULL,
    rel_count = 0                                            => -1,
    if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, 
							sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), 
									if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) = 0 				=> 0,
                                                                                                                                                                                                                                                                                                                                                                                                         if (if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) >= 0, truncate(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))), roundup(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))))));

iv_closest_rel_distance := __common__(  map(
    not(truedid)                 => NULL,
    rel_count = 0                => -1,
    rel_within25miles_count > 0  => 25,
    rel_within100miles_count > 0 => 100,
    rel_within500miles_count > 0 => 500,
    rel_withinOther_count > 0    => 1000,
                                    0));

iv_pct_rel_prop_owned := __common__(  map(
    not(truedid)  => NULL,
    rel_count > 0 => min(if(truncate(rel_prop_owned_count / rel_count * 10) * 10 = NULL, -NULL, truncate(rel_prop_owned_count / rel_count * 10) * 10), 100),
                     -1));

iv_pct_rel_prop_sold := __common__(  map(
    not(truedid)  => NULL,
    rel_count > 0 => min(if(truncate(rel_prop_sold_count / rel_count * 10) * 10 = NULL, -NULL, truncate(rel_prop_sold_count / rel_count * 10) * 10), 100),
                     -1));

iv_accident_count := __common__(  if(not(truedid), NULL, acc_count));

iv_accident_recency := __common__(  map(
    not(truedid)  			=> NULL,
    acc_count_30 > 0  	=> 1,
    acc_count_90 > 0  	=> 3,
    acc_count_180 > 0  	=> 6,
    acc_count_12 > 0  	=> 12,
    acc_count_24 > 0   	=> 24,
    acc_count_36 > 0  	=> 36,
    acc_count_60 > 0  	=> 60,
    acc_count > 0     	=> 99,
                     0));

ams_major_medical := __common__(  StringLib.StringToUpperCase(trim(ams_college_major, all)) in ['A','E','L','Q','T','V']);

ams_major_science := __common__(  StringLib.StringToUpperCase(trim(ams_college_major, all)) in ['D','H','M','N']);

ams_major_liberal := __common__(  StringLib.StringToUpperCase(trim(ams_college_major, all)) in ['C','F','I','J','K','O','W','Y']);

ams_major_business := __common__(  StringLib.StringToUpperCase(trim(ams_college_major, all)) in ['B','G','P','R','S','Z'] );

ams_major_unknown := __common__(  StringLib.StringToUpperCase(trim(ams_college_major,all)) = 'U' );

iv_ams_college_major := __common__(  map(
    not(truedid)                             => '                ',
    ams_major_medical                        => 'Medical         ',
    ams_major_science                        => 'Science         ',
    ams_major_liberal                        => 'Liberal Arts    ',
    ams_major_business                       => 'Business        ',
    ams_major_unknown                        => 'Unclassified    ',
    not(ams_college_code = '')               => 'Unclassified    ',
    not((ams_date_first_seen in ['0', ' '])) => 'No College Found',
                                                'No AMS Found'));

iv_ams_college_tier := __common__(  map(
    not(truedid)            => '  ',
    ams_college_tier = ''   => '-1',
                               ams_college_tier));

iv_prof_license_category := __common__(  map(
    not(truedid)                 => '  ',
    prof_license_category = ''   => '-1',
                                    prof_license_category));

iv_pb_order_freq := __common__(  map(
    not(truedid)                     					=> '                ',
		(integer)pb_number_of_sources = 0      		=> '0 No Purch Data ',
             pb_average_days_bt_orders = ''   => '1 Cant Calculate',
    (integer)pb_average_days_bt_orders <= 7   => '2 Weekly        ',
    (integer)pb_average_days_bt_orders <= 30  => '3 Monthly       ',
    (integer)pb_average_days_bt_orders <= 60  => '4 Semi-monthly  ',
    (integer)pb_average_days_bt_orders <= 90  => '5 Quarterly     ',
    (integer)pb_average_days_bt_orders <= 180 => '6 Semi-yearly   ',
    (integer)pb_average_days_bt_orders <= 365 => '7 Yearly        ',
																								 '8 Rarely        '));

iv_pb_average_dollars := __common__(  map(
    not(truedid)              => NULL,
    pb_average_dollars = ''   => -1,
                                 (integer)pb_average_dollars));

iv_fp_idrisktype := __common__(  if(not(truedid), '', trim((string)fp_idrisktype, all)));

iv_fp_idverrisktype := __common__(  if(not(truedid), '', trim((string)fp_idverrisktype, all)));

iv_fp_sourcerisktype := __common__(  if(not(truedid), '', trim((string)fp_sourcerisktype, all)));

iv_fp_varrisktype := __common__(  if(not(truedid), '', trim((string)fp_varrisktype, all)));

iv_fp_srchvelocityrisktype := __common__(  if(not(truedid), '', trim((string)fp_srchvelocityrisktype, all)));

iv_fp_srchfraudsrchcount := __common__(  if(not(truedid), NULL, (integer)fp_srchfraudsrchcount));

iv_fp_assocrisktype := __common__(  if(not(truedid), '', trim((string)fp_assocrisktype, all)));

iv_fp_validationrisktype := __common__(  if(not(truedid), '', trim((string)fp_validationrisktype, all)));

iv_fp_corrrisktype := __common__(  if(not(truedid), '', trim((string)fp_corrrisktype, all)));

iv_fp_corrssnnamecount := __common__(  if(not(truedid), NULL, (integer)fp_corrssnnamecount));

iv_fp_corraddrnamecount := __common__(  if(not(truedid), NULL, (integer)fp_corraddrnamecount));

iv_fp_divrisktype := __common__(  if(not(truedid), '', trim((string)fp_divrisktype, all)));

iv_fp_srchcomponentrisktype := __common__(  if(not(truedid), '', trim((string)fp_srchcomponentrisktype, all)));

iv_fp_srchssnsrchcount := __common__(  if(not(truedid), NULL, (integer)fp_srchssnsrchcount));

iv_fp_srchaddrsrchcount := __common__(  if(not(truedid), NULL, (integer)fp_srchaddrsrchcount));

iv_fp_srchaddrsrchcountmo := __common__(  if(not(truedid), NULL, (integer)fp_srchaddrsrchcountmo));

iv_fp_srchaddrsrchcountwk := __common__(  if(not(truedid), NULL, (integer)fp_srchaddrsrchcountwk));

iv_fp_srchphonesrchcountmo := __common__(  if(not(truedid), NULL, (integer)fp_srchphonesrchcountmo));

iv_fp_componentcharrisktype := __common__(  if(not(truedid), '', trim((string)fp_componentcharrisktype, all)));

iv_fp_addrchangeincomediff := __common__(  if(not(truedid), NULL, (integer)fp_addrchangeincomediff));

iv_fp_addrchangecrimediff := __common__(  if(not(truedid), NULL, (integer)fp_addrchangecrimediff));

iv_fp_addrchangeecontrajindex := __common__(  if(not(truedid), '', trim((string)fp_addrchangeecontrajindex, all)));

iv_fp_curraddrmedianvalue := __common__(  if(not(truedid), NULL, (integer)fp_curraddrmedianvalue));

iv_fp_curraddrburglaryindex := __common__(  if(not(truedid), NULL, (integer)fp_curraddrburglaryindex));

iv_fp_prevaddrageoldest := __common__(  if(not(truedid), NULL, (integer)fp_prevaddrageoldest));

iv_fp_prevaddrdwelltype := __common__(  if(not(truedid), '', fp_prevaddrdwelltype));

iv_fp_prevaddrmedianvalue := __common__(  if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue));

iv_fp_prevaddrmurderindex := __common__(  if(not(truedid), NULL, (integer)fp_prevaddrmurderindex));

fp_segment := __common__(  if(fp_segment_1 = '', '2 NAS 479', fp_segment_1));

iv_phnpop_x_nap_summary := __common__(  if(iv_phnpop_x_nap_summary_1 = '', '100', iv_phnpop_x_nap_summary_1));

iv_fname_eda_sourced_type := __common__(  if(iv_fname_eda_sourced_type_1 = '', '-1', iv_fname_eda_sourced_type_1));

iv_nap_phn_ver_x_inf_phn_ver := __common__(  if(iv_nap_phn_ver_x_inf_phn_ver_1 = '', '0-0', iv_nap_phn_ver_x_inf_phn_ver_1));

iv_df001_mos_since_fel_ls := __common__(  if(iv_df001_mos_since_fel_ls_1 <= NULL, -1, iv_df001_mos_since_fel_ls_1));
//treenet variable

N0_8 := __common__(  if(((real)iv_mos_src_bureau_dob_fseen < 316.5), -1.971114, -1.745263));

N0_7 := __common__(  if(((real)iv_mos_src_bureau_dob_fseen > NULL), N0_8, -2.1563901));

N0_6 := __common__(  if(((real)iv_ag001_age < 22.5), -1.69067, N0_7));

N0_5 := __common__(  if(((real)iv_ag001_age > NULL), N0_6, -2.1563902));

N0_4 := __common__(  if(((real)c_employees < 70.5), -2.0674055, N0_5));

N0_3 := __common__(  if(trim(C_EMPLOYEES) != '', N0_4, -1.991012));

N0_2 := __common__(  map((iv_vp100_phn_prob in ['1 HiRisk', '5 Cell', '7 PCS'])                                                                  => -2.0839764,
            (iv_vp100_phn_prob in ['0 No Phone Problems', '2 Disconnected', '3 Not_Issued', '4 Invalid', '6 Pager', '8 Pay_Phone']) => N0_3,
                                                                                                                                       N0_3));

N0_1 := __common__(  map((fp_segment in ['0 No SSN', '1 SSN Prob', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => -2.152054,
            (fp_segment in ['2 NAS 479', '3 New DID'])                                                             => N0_2,
                                                                                                                      -2.152054));

N1_7 :=  __common__(  map(((real)iv_ag001_age <= NULL) => 0.061159017,
													((real)iv_ag001_age < 20.5)  => 0.20906356,
																													0.061159017));

N1_6 := __common__(  map(trim(C_HVAL_750K_P) = ''     => 0.49666625,
            ((real)c_hval_750k_p < 68.8) => -0.023207442,
                                            0.49666625));

N1_5 := __common__(  if(((real)c_easiqlife < 134.5), N1_6, N1_7));

N1_4 := __common__(  if(trim(C_EASIQLIFE) != '', N1_5, -0.050836546));

N1_3 := __common__(  if(((real)iv_va060_dist_add_in_bst < 716.5), N1_4, 0.16864793));

N1_2 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N1_3, 0.062258075));

N1_1 := __common__(  map((fp_segment in ['0 No SSN', '1 SSN Prob', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => -0.045901842,
													(fp_segment in ['2 NAS 479', '3 New DID'])                                                             => N1_2,
                                                                                                                      -0.045901842));

N2_8 := __common__(  map((iv_prv_own_prop_x_addr_naprop in ['00', '01', '04', '10', '11', '13', '14']) => 0.35644256,
            (iv_prv_own_prop_x_addr_naprop in ['02', '03', '12'])                         => 1,
                                                                                             0.35644256));

N2_7 := __common__(  map(((real)iv_pl002_addrs_15yr <= NULL) => 0.064936353,
            ((real)iv_pl002_addrs_15yr < 5.5)   => N2_8,
                                                   0.064936353));

N2_6 := __common__(  map((iv_fp_validationrisktype in ['1', '3', '4', '5', '6', '7', '8', '9']) => 0.087775406,
            (iv_fp_validationrisktype in ['2'])                                           => N2_7,
                                                                                              0.087775406));

N2_5 := __common__(  if(((real)c_femdiv_p < 13.85), N2_6, 0.47455423));

N2_4 := __common__(  if(trim(C_FEMDIV_P) != '', N2_5, 0.11148719));

N2_3 := __common__(  map((real)iv_average_rel_distance = NULL => N2_4,
											((real)iv_average_rel_distance < 837.5) => 0.023569961, 
												N2_4));


N2_2 := __common__(  if(((real)iv_fp_corraddrnamecount < 0.5), N2_3, -0.047269612));

N2_1 := __common__(  if(((real)iv_fp_corraddrnamecount > NULL), N2_2, 0.0018806155));

N3_8 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-3', '3-1']) => 0.06994901,
            (iv_paw_dead_bus_x_active_phn in ['2-2', '3-0', '3-2', '3-3'])                                                         => 0.57662976,
                                                                                                                                      0.06994901));

N3_7 := __common__(  map(trim(C_CPIALL) = ''       => -0.044334345,
            ((real)c_cpiall < 225.85) => 0.098723074,
                                         -0.044334345));

N3_6 := __common__(  map((iv_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N3_7,
            (iv_fp_srchcomponentrisktype in ['7'])                                           => 0.481133,
                                                                                                 N3_7));

N3_5 := __common__(  if(((real)c_cpiall < 222.95), -0.0086309483, N3_6));

N3_4 := __common__(  if(trim(C_CPIALL) != '', N3_5, 0.015257244));

N3_3 :=  __common__(  map(((integer)iv_closest_rel_distance <= NULL)  => N3_8,
													((integer)iv_closest_rel_distance < 300) => N3_4,
																																		N3_8));

N3_2 := __common__(  if(((real)iv_fp_corraddrnamecount < 0.5), N3_3, -0.049290918));

N3_1 := __common__(  if(((real)iv_fp_corraddrnamecount > NULL), N3_2, -0.0044149987));

N4_8 := __common__(  if(((real)c_murders < 30.5), 0.30534938, 0.089486069));

N4_7 := __common__(  if(trim(C_MURDERS) != '', N4_8, -0.051052617));

N4_6 := __common__(  map((iv_fp_idrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => 0.08086168,
            (iv_fp_idrisktype in ['7', '-1'])                                     => 0.80797923,
                                                                                      0.08086168));

N4_5 := __common__(  if(((real)iv_inp_addr_avm_pct_change_3yr > NULL), N4_6, N4_7));

N4_4 := __common__( map(((real)iv_ag001_age <= NULL) => 0.0063636659,
												((real)iv_ag001_age < 19.5)  => N4_5,
																												0.0063636659));

N4_3 := __common__(  if(((real)iv_ag001_age < 57.5), N4_4, 0.072450554));

N4_2 := __common__(  if(((real)iv_ag001_age > NULL), N4_3, -0.050754793));

N4_1 := __common__(  map((fp_segment in ['0 No SSN', '1 SSN Prob', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => -0.047663256,
            (fp_segment in ['2 NAS 479', '3 New DID'])                                                             => N4_2,
                                                                                                                      -0.047663256));

N5_7 := __common__(  map((iv_rec_vehx_level in ['AO', 'AW', 'W1', 'W3', 'XX']) => 0.11167668,
            (iv_rec_vehx_level in ['W2'])                         => 1,
                                                                     0.11167668));

N5_6 := __common__(  map((iv_input_dob_match_level in ['0', '1', '2', '3', '5', '6', '8']) => N5_7,
            (iv_input_dob_match_level in ['4', '7'])                          => 0.71978203,
                                                                                 N5_7));

N5_5 := __common__(  map((iv_fp_srchcomponentrisktype in ['1', '2', '3', '4', '6', '8']) => N5_6,
            (iv_fp_srchcomponentrisktype in ['5', '7', '9'])                   => 0.78749674,
                                                                                     N5_6));

N5_4 := __common__(  map((iv_bst_own_prop_x_addr_naprop in ['00', '01', '02', '04', '10', '11', '12', '13', '14']) => 0.049028921,
            (iv_bst_own_prop_x_addr_naprop in ['03'])                                                 => N5_5,
                                                                                                         0.049028921));

N5_3 := __common__(  map((iv_nas_summary in [1, 2, 3, 5, 6, 8, 10, 11, 12]) => -0.025128788,
            (iv_nas_summary in [0, 4, 7, 9])                    => N5_4,
                                                               -0.025128788));

N5_2 := __common__(  if(((integer)iv_closest_rel_distance < 300), -0.020956543, N5_3));

N5_1 := __common__(  if(((real)iv_closest_rel_distance > NULL), N5_2, -0.0023081678));

N6_5 := __common__(  map((iv_prof_license_category in ['-1', '1', '2', '5']) => 0.087206239,
            (iv_prof_license_category in ['0', '3', '4'])       => 0.47066092,
                                                                   0.087206239));

N6_4 := __common__(  map((iv_liens_unrel_x_rel_ft in ['0-0', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => 0.048300599,
            (iv_liens_unrel_x_rel_ft in ['0-1', '1-2'])                                                         => 0.72756414,
                                                                                                                   0.048300599));

N6_3 := __common__(  map((real)iv_ag001_age <= NULL  	 =>  N6_4,
													((real)iv_ag001_age < 59.5)  => 0.0088297693, 
																													N6_4));

N6_2 := __common__(  map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '3 Not_Issued', '5 Cell', '6 Pager', '7 PCS', '8 Pay_Phone']) => N6_3,
            (iv_vp100_phn_prob in ['4 Invalid'])                                                                                                      => N6_5,
                                                                                                                                                         N6_3));

N6_1 := __common__(  map((fp_segment in ['0 No SSN', '1 SSN Prob', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => -0.047919939,
            (fp_segment in ['2 NAS 479', '3 New DID'])                                                             => N6_2,
                                                                                                                      -0.047919939));

N7_8 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '1-0', '1-2'])                      => 0.056733911,
            (iv_num_purch_x_num_sold_60 in ['0-1', '0-2', '1-1', '2-0', '2-1', '2-2']) => 1,
                                                                                          1));

N7_7 := __common__(  map(trim(C_FAMMAR18_P) = ''      => 0.069343216,
            ((real)c_fammar18_p < 22.55) => 0.39766257,
                                            0.069343216));

N7_6 := __common__(  if(((integer)c_robbery < 45), N7_7, N7_8));

N7_5 := __common__(  if(trim(C_ROBBERY) != '', N7_6, -0.05073693));

N7_4 := __common__(  map(((real)iv_ag001_age <= NULL)  => 0.029652099,
													((real)iv_ag001_age < 20.5)  => N7_5,
																													0.029652099));

N7_3 := __common__(  map((iv_va100_add_problem in ['02 Address Standardized', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '08 Military Zip', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College']) => -0.013672597,
            (iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '03 Standarization Error', '07 Busines', '13 Vacant', '14 Zip/State Mismatch'])                                                            => N7_4,
                                                                                                                                                                                                                                          -0.013672597));

N7_2 := __common__(  if(((real)iv_fp_corraddrnamecount < 0.5), N7_3, -0.048396781));

N7_1 := __common__(  if(((real)iv_fp_corraddrnamecount > NULL), N7_2, 0.00031405051));

N8_6 := __common__(  map((iv_prv_own_prop_x_addr_naprop in ['01', '11', '13'])                         => 0.0030151679,
            (iv_prv_own_prop_x_addr_naprop in ['00', '02', '03', '04', '10', '12', '14']) => 0.13266119,
                                                                                             0.0030151679));

N8_5 := __common__(  if(((real)iv_va060_dist_add_in_bst < 1874.5), 0.036968984, 0.13474981));

N8_4 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N8_5, 0.1488983));

N8_3 := __common__(  map((iv_bst_own_prop_x_addr_naprop in ['00', '01', '02', '04'])             => 0.0016531285,
            (iv_bst_own_prop_x_addr_naprop in ['03', '10', '11', '12', '13', '14']) => N8_4,
                                                                                       0.0016531285));

N8_2 := __common__(  map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '3 Not_Issued', '5 Cell', '6 Pager', '7 PCS', '8 Pay_Phone']) => N8_3,
            (iv_vp100_phn_prob in ['4 Invalid'])                                                                                                      => N8_6,
                                                                                                                                                         N8_3));

N8_1 := __common__(  map((iv_nas_summary in [2, 3, 4, 5, 6, 8, 10, 11, 12]) => -0.036837396,
            (iv_nas_summary in [0, 1, 7, 9])                   => N8_2,
                                                               -0.036837396));

N9_8 := __common__(  map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-1', '0-3', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1']) => 0.012433132,
            (iv_nap_phn_ver_x_inf_phn_ver in ['3-3'])                                                                              => 0.56492094,
                                                                                                                                      0.012433132));

N9_7 := __common__( map(((integer)iv_inp_addr_mortgage_amount <= NULL)     => 0.29074783,
												((integer)iv_inp_addr_mortgage_amount < 147476) => N9_8,
																																						0.29074783));


N9_6 := __common__(  map((iv_fp_idverrisktype in ['2', '3', '4', '6', '7', '8', '9']) => 0.038123483,
            (iv_fp_idverrisktype in ['1', '5'])                               => 0.42690334,
                                                                                   0.038123483));

N9_5 := __common__( map(((real)iv_pl002_avg_mo_per_addr <= NULL) => N9_6,
												((real)iv_pl002_avg_mo_per_addr < 34.5)  => 0.0057547768,
																																		N9_6));

N9_4 := __common__(  if(((real)c_inc_125k_p < 16.45), N9_5, N9_7));

N9_3 := __common__(  if(trim(C_INC_125K_P) != '', N9_4, 0.0046434169));

N9_2 := __common__(  if(((real)iv_closest_rel_distance < 62.5), -0.016544268, N9_3));

N9_1 := __common__(  if(((real)iv_closest_rel_distance > NULL), N9_2, -0.0041998699));

N10_8 := __common__(  map(trim(C_WHITE_COL) = ''      => 0.039599849,
             ((real)c_white_col < 43.95) => 0.18881519,
                                            0.039599849));

N10_7 := __common__(  if(((real)c_inc_201k_p < 5.35), 0.028449932, N10_8));

N10_6 := __common__(  if(trim(C_INC_201K_P) != '', N10_7, 0.15434904));

N10_5 := __common__(  if(((integer)iv_va060_dist_add_in_bst < 922), 0.023560229, N10_6));

N10_4 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N10_5, -0.052060295));

N10_3 := __common__(  if(((real)iv_inq_highriskcredit_recency < 0.5), N10_4, -0.00949233));

N10_2 := __common__(  if(((real)iv_inq_highriskcredit_recency > NULL), N10_3, 0.021269039));

N10_1 := __common__(  map((fp_segment in ['0 No SSN', '1 SSN Prob', '4 Bureau Only', '5 Derog', '6 Recent Activity', '7 Other']) => -0.046510343,
             (fp_segment in ['2 NAS 479', '3 New DID'])                                                             => N10_2,
                                                                                                                       -0.046510343));

N11_9 := __common__( map(((real)iv_fp_srchfraudsrchcount <= NULL) => 0.01067206,
													((real)iv_fp_srchfraudsrchcount < 1.5)   => 0.041334927,
																																			0.01067206));

N11_8 := __common__(  map(trim(C_FEMDIV_P) = ''      => 0.13652301,
             ((real)c_femdiv_p < 13.85) => N11_9,
                                           0.13652301));

N11_7 := __common__(  if(((real)c_hval_750k_p < 58.75), N11_8, 0.15822871));

N11_6 := __common__(  if(trim(C_HVAL_750K_P) != '', N11_7, 0.11401857));

N11_5 := __common__(  if(((real)iv_va060_dist_add_in_bst < 14.5), -0.0011693602, N11_6));

N11_4 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N11_5, 0.30119078));

N11_3 := __common__(  map((iv_input_dob_match_level in ['1', '2', '3', '5', '6', '7']) => -0.028830573,
             (iv_input_dob_match_level in ['0', '4', '8'])                => N11_4,
                                                                             -0.028830573));

N11_2 := __common__(  if(((real)iv_fp_corraddrnamecount < 0.5), N11_3, -0.048148375));

N11_1 := __common__(  if(((real)iv_fp_corraddrnamecount > NULL), N11_2, -0.0039685759));

N12_8 := __common__(  map((iv_prof_license_category in ['-1', '1', '2', '3', '4']) => 0.013662692,
             (iv_prof_license_category in ['0', '5'])                 => 0.47503743,
                                                                         0.013662692));

N12_7 := __common__(  if(((real)iv_inq_adls_per_ssn < 0.5), 0.11925709, N12_8));

N12_6 := __common__(  if(((real)iv_inq_adls_per_ssn > NULL), N12_7, -0.050501613));

N12_5 := __common__(  if(((real)iv_inq_addr_ver_count < 0.5), N12_6, -0.021599926));

N12_4 := __common__(  if(((real)iv_inq_addr_ver_count > NULL), N12_5, 0.08343221));

N12_3 := __common__(  if(((real)iv_ag001_age < 54.5), 0.01236257, N12_4));

N12_2 := __common__(  if(((real)iv_ag001_age > NULL), N12_3, 0.017565043));

N12_1 := __common__(  map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-3', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => -0.016930534,
             (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1'])                                                  => N12_2,
                                                                                                                         -0.016930534));

N13_8 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-3', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-0', '3-1', '3-3']) => 0.02682787,
             (iv_paw_dead_bus_x_active_phn in ['0-2', '2-0', '3-2'])                                                                       => 0.12082221,
                                                                                                                                              0.02682787));

N13_7 := __common__(  map((iv_ams_college_tier in ['-1', '0', '1', '2', '4', '5', '6']) => N13_8,
             (iv_ams_college_tier in ['3'])                                => 0.80196023,
                                                                              N13_8));

N13_6 := __common__(  if(((real)iv_va060_dist_add_in_bst < 2173.5), 0.02873089, 0.16878764));

N13_5 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N13_6, 0.61088032));

N13_4 := __common__( map(((real)iv_ag001_age <= NULL) => -0.007928269,
													((real)iv_ag001_age < 24.5)  => N13_5,
																													-0.007928269));

N13_3 := __common__( map(((real)iv_ag001_age <= NULL) => N13_7,
													((real)iv_ag001_age < 54.5)  => N13_4,
																													N13_7));

N13_2 := __common__(  if(((real)iv_fp_corraddrnamecount < 0.5), N13_3, -0.042763856));

N13_1 := __common__(  if(((real)iv_fp_corraddrnamecount > NULL), N13_2, -0.0050137398));

N14_9 := __common__(  map(trim(C_HVAL_80K_P) = ''     => 0.1442144,
             ((real)c_hval_80k_p < 1.05) => -0.030844229,
                                            0.1442144));

N14_8 := __common__(  map((iv_pb_order_freq in ['0 No Purch Data', '1 Cant Calculate', '3 Monthly', '4 Semi-monthly', '5 Quarterly', '7 Yearly', '8 Rarely']) => N14_9,
             (iv_pb_order_freq in ['2 Weekly', '6 Semi-yearly'])                                                                                 => 0.91393812,
                                                                                                                                                    N14_9));

N14_7 := __common__(  map((iv_fp_componentcharrisktype in ['1', '3', '4', '5', '6', '7', '8', '9']) => N14_8,
             (iv_fp_componentcharrisktype in ['2'])                                           => 0.32963273,
                                                                                                  N14_8));

N14_6 := __common__(  if(((real)iv_phones_per_apt_addr < 2.5), N14_7, 0.20402484));

N14_5 := __common__(  if(((real)iv_phones_per_apt_addr > NULL), N14_6, -0.050961193));

N14_4 := __common__(  if(((real)c_hval_250k_p < 14.55), 0.014470193, N14_5));

N14_3 := __common__(  if(trim(C_HVAL_250K_P) != '', N14_4, -0.051453958));

N14_2 := __common__(  if(((real)iv_ag001_age < 19.5), N14_3, -0.0058669716));

N14_1 := __common__(  if(((real)iv_ag001_age > NULL), N14_2, -0.050410982));

N15_6 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '1-1', '1-2', '2-0', '2-2']) => 0.039977517,
             (iv_num_purch_x_num_sold_60 in ['0-2', '1-0', '2-1'])                      => 0.14048544,
                                                                                           0.039977517));

N15_5 := __common__(  map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-3', '1-0', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => 0.012442397,
             (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-1'])                                                                => N15_6,
                                                                                                                                0.012442397));

N15_4 := __common__(  map((iv_liens_unrel_x_rel_ft in ['0-0', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N15_5,
             (iv_liens_unrel_x_rel_ft in ['0-1', '0-2', '1-2'])                                           => 0.17715508,
                                                                                                             N15_5));

N15_3 := __common__(  if(((real)iv_fp_srchssnsrchcount < 1.5), N15_4, -0.00664282));

N15_2 := __common__(  if(((real)iv_fp_srchssnsrchcount > NULL), N15_3, 0.027185817));

N15_1 := __common__(  map((iv_nas_summary in [1, 2, 3, 4, 5, 6, 8, 11, 12]) => -0.028539077,
             (iv_nas_summary in [0, 7, 9, 10])                  => N15_2,
                                                              -0.028539077));

N16_6 := __common__(  map((iv_vp100_phn_prob in ['1 HiRisk', '2 Disconnected', '3 Not_Issued', '5 Cell', '6 Pager', '7 PCS', '8 Pay_Phone']) => 0.017376752,
             (iv_vp100_phn_prob in ['0 No Phone Problems', '4 Invalid'])                                                        => 0.060460834,
                                                                                                                                   0.060460834));

N16_5 := __common__(  map(trim(C_RETAIL) = ''      => 0.22039862,
             ((real)c_retail < 41.25) => N16_6,
                                         0.22039862));

N16_4 := __common__( map(((real)iv_src_bureau_adl_count <= NULL) => 0.01435107,
												((real)iv_src_bureau_adl_count < 15.5)  => N16_5,
																																		0.01435107));

N16_3 := __common__(  if(((real)c_easiqlife < 133.5), -0.0086971275, N16_4));

N16_2 := __common__(  if(trim(C_EASIQLIFE) != '', N16_3, -0.013722107));

N16_1 := __common__(  map((iv_fp_corrrisktype in ['1', '2', '3', '4', '5', '6', '7', '8']) => -0.031908107,
             (iv_fp_corrrisktype in ['9'])                                           =>  N16_2,
                                                                                         -0.031908107));

N17_8 := __common__(  map(trim(C_RICH_FAM) = ''      => 0.25866174,
             ((real)c_rich_fam < 153.5) => 0.074483566,
                                           0.25866174));

N17_7 := __common__(  map((iv_fp_addrchangeecontrajindex in ['1', '4', '5', '6', '-1']) => 0.031319188,
             (iv_fp_addrchangeecontrajindex in ['2', '3'])                   => N17_8,
                                                                                  0.031319188));

N17_6 := __common__(  if(((real)c_hval_125k_p < 9.15), N17_7, -0.0093936313));

N17_5 := __common__(  if(trim(C_HVAL_125K_P) != '', N17_6, 0.08591228));

N17_4 := __common__(  map((iv_liens_unrel_x_rel_fc in ['0-0'])                                                  => N17_5,
             (iv_liens_unrel_x_rel_fc in ['0-1', '1-0', '1-1', '2-0', '2-1', '3-0', '3-1', '3-2']) => 0.62726492,
                                                                                                      0.62726492));

N17_3 := __common__( map(((real)iv_src_bureau_adl_count <= NULL)  => -0.011690932,
													((real)iv_src_bureau_adl_count < 37.5)  => N17_4,
																																		 -0.011690932));

N17_2 := __common__(  if(((real)iv_va060_dist_add_in_bst < 1024.5), -0.0074685933, N17_3));

N17_1 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N17_2, 0.015534562));

N18_9 := __common__(  if(((real)c_rich_old < 195.5), 0.0015287833, 0.2658809));

N18_8 := __common__(  if(trim(C_RICH_OLD) != '', N18_9, -0.050697875));

N18_7 := __common__( map(((real)iv_src_bureau_adl_count <= NULL)  => 0.0023008146,
													((real)iv_src_bureau_adl_count < 12.5)  => 0.12341731,
																																		0.0023008146));

N18_6 := __common__(  map(trim(C_POP_45_54_P) = ''      => 0.18649126,
             ((real)c_pop_45_54_p < 24.65) => N18_7,
                                              0.18649126));

N18_5 := __common__(  if(((real)c_pop_35_44_p < 5.65), 0.21268079, N18_6));

N18_4 := __common__(  if(trim(C_POP_35_44_P) != '', N18_5, 0.15749616));

N18_3 := __common__(  map((iv_prof_license_category in ['-1', '1', '2', '3', '4']) => N18_4,
             (iv_prof_license_category in ['0', '5'])                 => 0.23626842,
                                                                         N18_4));

N18_2 := __common__(  if(((real)iv_mos_src_drivers_lic_adl_fseen < 122.5), -0.008369036, N18_3));

N18_1 := __common__(  if(((real)iv_mos_src_drivers_lic_adl_fseen > NULL), N18_2, N18_8));

N19_8 := __common__(  map((iv_fp_idrisktype in ['1', '2', '4', '5', '6', '8', '9']) => 0.057780775,
             (iv_fp_idrisktype in ['3', '7', '-1'])                         => 0.18066809,
                                                                                 0.057780775));

N19_7 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-0', '2-2']) => N19_8,
             (iv_num_purch_x_num_sold_60 in ['2-1'])                                                  => 0.34554183,
                                                                                                         N19_8));

N19_6 := __common__(  map((iv_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => 0.0073632267,
             (iv_fp_srchcomponentrisktype in ['7'])                                           => 0.13502893,
                                                                                                  0.0073632267));

N19_5 := __common__(  map(trim(C_HVAL_100K_P) = ''     => N19_7,
             ((real)c_hval_100k_p < 2.25) => N19_6,
                                             N19_7));

N19_4 := __common__(  if(((real)c_cpiall < 222.95), 0.0019238014, N19_5));

N19_3 := __common__(  if(trim(C_CPIALL) != '', N19_4, 0.0064703078));

N19_2 := __common__(  if(((real)iv_va060_dist_add_in_bst < 6.5), -0.036896905, N19_3));

N19_1 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N19_2, -0.0018593847));

N20_9 := __common__(  map(trim(C_ARMFORCE) = ''      => -0.028888199,
             ((real)c_armforce < 126.5) => 0.020760423,
                                           -0.028888199));

N20_8 := __common__(  if(((real)iv_fp_addrchangecrimediff < -126.5), 0.10127169, N20_9));

N20_7 := __common__(  if(((real)iv_fp_addrchangecrimediff > NULL), N20_8, -0.012435564));

N20_6 := __common__(  map((iv_inp_addr_mortgage_type in ['Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => N20_7,
             (iv_inp_addr_mortgage_type in ['Commercial'])                                                                                                                => 0.74119985,
                                                                                                                                                                             N20_7));

N20_5 := __common__(  map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K']) => N20_6,
             (iv_in001_college_income in ['I'])                                                    => 0.77228111,
                                                                                                      N20_6));

N20_4 := __common__(  if(((real)c_rnt1000_p < 66.65), N20_5, 0.1478622));

N20_3 := __common__(  if(trim(C_RNT1000_P) != '', N20_4, 0.017024035));

N20_2 := __common__(  if(((real)iv_ag001_age < 59.5), -0.0036129988, N20_3));

N20_1 := __common__(  if(((real)iv_ag001_age > NULL), N20_2, -0.031879689));

N21_9 := __common__(  map((iv_fp_srchcomponentrisktype in ['1', '2', '3', '6', '7', '8', '9']) => 0.056281085,
             (iv_fp_srchcomponentrisktype in ['4', '5'])                               => 0.4572405,
                                                                                            0.056281085));

N21_8 := __common__(  map((iv_fp_srchvelocityrisktype in ['1', '2', '3', '4', '6', '7', '8', '9']) => N21_9,
             (iv_fp_srchvelocityrisktype in ['5'])                                           => 0.47607565,
                                                                                                 N21_9));

N21_7 := __common__(  map((iv_liens_unrel_x_rel_cj in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-0', '2-1', '3-0', '3-1', '3-2']) => 0.024133891,
             (iv_liens_unrel_x_rel_cj in ['2-2'])                                                                       => 1,
                                                                                                                           0.024133891));

N21_6 := __common__(  if(((real)c_very_rich < 187.5), N21_7, N21_8));

N21_5 := __common__(  if(trim(C_VERY_RICH) != '', N21_6, 0.051521207));

N21_4 := __common__(  if(((real)iv_dist_inp_addr_to_prv_addr < 1979.5), -0.0082070228, N21_5));

N21_3 := __common__(  if(((real)iv_dist_inp_addr_to_prv_addr > NULL), N21_4, 0.0074122285));

N21_2 := __common__(  if(((real)iv_ag001_age < 59.5), N21_3, 0.023780186));

N21_1 := __common__(  if(((real)iv_ag001_age > NULL), N21_2, -0.0318434));

N22_8 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1', '3-3']) => 0.11305502,
             (iv_paw_dead_bus_x_active_phn in ['0-2', '0-3', '3-2'])                                                                       => 0.51395488,
                                                                                                                                              0.11305502));

N22_7 := __common__(  map(trim(C_UNEMPL) = ''      => N22_8,
             ((real)c_unempl < 183.5) => 0.0041662589,
                                         N22_8));

N22_6 := __common__(  map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '08 Military Zip', '09 Corporate Zip Code', '12 College', '13 Vacant']) => N22_7,
             (iv_va100_add_problem in ['10 Zip/City Mismatch', '11 Throw Back', '14 Zip/State Mismatch'])                                                                                                                                                                                                  => 0.20105411,
                                                                                                                                                                                                                                                                                                              N22_7));

N22_5 := __common__(  if(trim(C_FINANCE) != '', N22_6, 0.16607545));

N22_4 := __common__(  map((iv_prv_addr_financing_type in ['ADJ', 'CNV', 'NONE']) => N22_5,
             (iv_prv_addr_financing_type in ['OTH'])                => 0.23380381,
                                                                       N22_5));

N22_3 := __common__(  map(((real)iv_fp_addrchangecrimediff <= NULL)  => N22_4,
													((real)iv_fp_addrchangecrimediff < -128.5) => 0.17521572,
																																				N22_4));

N22_2 := __common__(  if(((real)iv_po001_m_snc_veh_adl_fs < 120.5), -0.0053828664, N22_3));

N22_1 := __common__(  if(((real)iv_po001_m_snc_veh_adl_fs > NULL), N22_2, 0.01028849));

N23_8 := __common__(  map((iv_fp_componentcharrisktype in ['1', '3', '4', '5', '6', '7', '8', '9']) => -0.036602117,
             (iv_fp_componentcharrisktype in ['2'])                                           => 0.31287429,
                                                                                                  -0.036602117));

N23_7 := __common__(  if(((integer)iv_fp_prevaddrmedianvalue < 457910), 0.02663472, 0.20153774));

N23_6 := __common__(  if(((real)iv_fp_prevaddrmedianvalue > NULL), N23_7, 0.35707316));

N23_5 := __common__(  map(trim(C_HVAL_100K_P) = ''     => N23_6,
             ((real)c_hval_100k_p < 6.85) => 0.0089901901,
                                             N23_6));

N23_4 := __common__(  map((iv_fp_idrisktype in ['1', '2', '4', '6', '8', '9', '-1']) => N23_5,
             (iv_fp_idrisktype in ['3', '5', '7'])                         => 0.098786343,
                                                                                 N23_5));

N23_3 := __common__(  map(trim(C_CPIALL) = ''       => N23_4,
             ((real)c_cpiall < 222.95) => 0.00044812721,
                                          N23_4));

N23_2 := __common__(  if(((real)c_easiqlife < 133.5), -0.017319867, N23_3));

N23_1 := __common__(  if(trim(C_EASIQLIFE) != '', N23_2, N23_8));

N24_8 := __common__(  map((iv_liens_unrel_x_rel_sc in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-1', '2-2', '3-0', '3-1', '3-2']) => -0.0069257681,
             (iv_liens_unrel_x_rel_sc in ['2-0'])                                                                       => 0.48722705,
                                                                                                                           -0.0069257681));

N24_7 := __common__(  map((iv_input_dob_match_level in ['0', '1', '2', '3', '4', '6', '7', '8']) => N24_8,
             (iv_input_dob_match_level in ['5'])                                    => 0.61476755,
                                                                                       N24_8));

N24_6 := __common__(  if(((real)c_popover25 < 630.5), 0.25542962, N24_7));

N24_5 := __common__(  if(trim(C_POPOVER25) != '', N24_6, -0.050267167));

N24_4 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-0', '2-1']) => N24_5,
             (iv_num_purch_x_num_sold_60 in ['0-2', '2-2'])                                    => 0.39575306,
                                                                                                  N24_5));

N24_3 := __common__(  map((iv_vp010_phn_nongeo = 0) => N24_4,
             (iv_vp010_phn_nongeo = 1) => 0.86691999,
                                               N24_4));

N24_2 := __common__(  if(((real)iv_mos_src_drivers_lic_adl_lseen < 92.5), 0.0006423061, N24_3));

N24_1 := __common__(  if(((real)iv_mos_src_drivers_lic_adl_lseen > NULL), N24_2, -0.0090077494));

N25_8 := __common__(  if(((real)iv_purch_sold_val_diff > NULL), 0.27529728, -0.010002446));

N25_7 := __common__(  map(trim(C_HVAL_250K_P) = ''      => 0.05393459,
             ((real)c_hval_250k_p < 14.85) => -0.013589054,
                                              0.05393459));

N25_6 := __common__(  map(trim(C_POP_0_5_P) = ''     => 0.15506374,
             ((real)c_pop_0_5_p < 15.9) => N25_7,
                                           0.15506374));

N25_5 := __common__(  map(trim(C_BIGAPT_P) = ''      => 0.15731303,
             ((real)c_bigapt_p < 43.35) => N25_6,
                                           0.15731303));

N25_4 := __common__(  if(((real)iv_ag001_age < 20.5), N25_5, 0.011225807));

N25_3 := __common__(  if(((real)iv_ag001_age > NULL), N25_4, 0.0070985124));

N25_2 := __common__(  if(((real)c_easiqlife < 134.5), -0.014798613, N25_3));

N25_1 := __common__(  if(trim(C_EASIQLIFE) != '', N25_2, N25_8));

N26_8 := __common__(  map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'I', 'K']) => 0.027468479,
             (iv_in001_college_income in ['H', 'J'])                                          => 0.661852,
                                                                                                 0.027468479));

N26_7 := __common__(  map((iv_addr_miskey in ['0']) => 0.014579251,
             (iv_addr_miskey in ['1']) => 1,
                                          0.014579251));

N26_6 := __common__(  map((iv_liens_unrel_x_rel_cj in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '3-1', '3-2']) => 0.058888779,
             (iv_liens_unrel_x_rel_cj in ['3-0'])                                                                       => 0.73473374,
                                                                                                                           0.058888779));

N26_5 := __common__(  map((iv_fp_srchvelocityrisktype in ['1', '2', '4', '6', '7', '8', '9']) => N26_6,
             (iv_fp_srchvelocityrisktype in ['3', '5'])                               => 0.24553754,
                                                                                           N26_6));

N26_4 := __common__(  if(((real)iv_inp_addr_avm_pct_change_3yr < 0.482065), N26_5, N26_7));

N26_3 := __common__(  if(((real)iv_inp_addr_avm_pct_change_3yr > NULL), N26_4, N26_8));

N26_2 := __common__(  if(((real)iv_inp_addr_fips_ratio < 1.27983), -0.0012125002, N26_3));

N26_1 := __common__(  if(((real)iv_inp_addr_fips_ratio > NULL), N26_2, -0.050918657));

N27_6 := __common__( map(((integer)iv_inp_addr_assessed_total_val <= NULL)     => -0.0063658226,
												 ((integer)iv_inp_addr_assessed_total_val < 145469) => 0.10387219,
																																							 -0.0063658226));

N27_5 := __common__(  map((iv_in001_college_income in ['-1', 'C', 'D', 'F', 'K'])          => N27_6,
             (iv_in001_college_income in ['A', 'B', 'E', 'G', 'H', 'I', 'J']) => 0.31972977,
                                                                                 0.31972977));

N27_4 := __common__(  map((iv_fp_assocrisktype in ['2', '4', '5', '9'])       => 0.010108878,
             (iv_fp_assocrisktype in ['1', '3', '6', '7', '8']) => N27_5,
                                                                        0.010108878));

N27_3 := __common__(  if(((real)iv_inp_addr_building_area < 1557.5), 0.007604437, N27_4));

N27_2 := __common__(  if(((real)iv_inp_addr_building_area > NULL), N27_3, -0.05069178));

N27_1 := __common__(  map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-3', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => -0.0082293398,
             (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1'])                                                  => N27_2,
                                                                                                                         -0.0082293398));

N28_9 := __common__(  map((iv_prv_addr_mortgage_term in [' 0', ' 5', '-1', '10', '15', '20', '30', '40']) => 0.0015340259,
             (iv_prv_addr_mortgage_term in ['25'])                                           => 1,
                                                                                                0.0015340259));

N28_8 := __common__(  map((iv_liens_unrel_x_rel_ft in ['0-0', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N28_9,
             (iv_liens_unrel_x_rel_ft in ['0-1', '0-2'])                                                         => 0.43041376,
                                                                                                                    N28_9));

N28_7 := __common__(  if(((real)c_oldhouse < 142.9), 0.0031443837, 0.1330814));

N28_6 := __common__(  if(trim(C_OLDHOUSE) != '', N28_7, -0.05031199));

N28_5 := __common__(  if(((real)iv_inp_addr_avm_change_2yr > NULL), N28_6, N28_8));

N28_4 := __common__(  map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'No Mortgage', 'Non-Traditional', 'Other', 'Unknown']) => N28_5,
             (iv_bst_addr_mortgage_type in ['High-Risk', 'Piggyback'])                                                                                        => 0.60988698,
                                                                                                                                                                 N28_5));

N28_3 := __common__(  map((iv_bst_addr_mortgage_term in [0, 5, -1, 15, 20, 30, 40]) => N28_4,
             (iv_bst_addr_mortgage_term in [10, 25])                               => 0.61840051,
                                                                                          N28_4));

N28_2 := __common__(  if(((integer)iv_prop_sold_assessed_total < 278560), 0.0001338368, N28_3));

N28_1 := __common__(  if(((real)iv_prop_sold_assessed_total > NULL), N28_2, -0.050670952));

N29_8 := __common__(  if(((real)c_professional < 6.95), -0.013204328, 0.22179723));

N29_7 := __common__(  if(trim(C_PROFESSIONAL) != '', N29_8, 0.18877153));

N29_6 := __common__(  map((iv_inp_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Other', 'Unknown']) => N29_7,
             (iv_inp_addr_mortgage_type in ['Non-Traditional', 'Piggyback'])                                                                            => 1,
                                                                                                                                                           N29_7));

N29_5 := __common__(  map((iv_fp_varrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => 0.061781238,
             (iv_fp_varrisktype in ['8', '-1'])                                     => 0.70615516,
                                                                                        0.061781238));

N29_4 := __common__(  map((iv_phnpop_x_nap_summary in ['000', '002', '003', '005', '008', '100', '101', '102', '104', '105', '106', '108', '109', '110', '111', '112']) => N29_5,
             (iv_phnpop_x_nap_summary in ['103', '107'])                                                                                                   => 0.50146312,
                                                                                                                                                              N29_5));

N29_3 := __common__( map(((real)iv_inp_addr_avm_pct_change_3yr <= NULL)    	=> 0.00080134892,
													((real)iv_inp_addr_avm_pct_change_3yr < 0.185732) => N29_4,
																																								0.00080134892));

N29_2 := __common__(  map((iv_fp_sourcerisktype in ['2', '3', '4', '5', '6', '7', '8', '9']) => N29_3,
             (iv_fp_sourcerisktype in ['1'])                                           => N29_6,
                                                                                           N29_3));

N29_1 := __common__(  if(((real)iv_inp_addr_avm_pct_change_3yr > NULL), N29_2, -0.0064147175));

N30_7 := __common__(  map((iv_adl_util_convenience in ['0']) => -0.014248367,
             (iv_adl_util_convenience in ['1']) => 0.44350032,
                                                   -0.014248367));

N30_6 := __common__(  map((iv_fp_addrchangeecontrajindex in ['1', '2', '3', '4', '6', '-1']) => 0.021673432,
             (iv_fp_addrchangeecontrajindex in ['5'])                               => 0.85088915,
                                                                                        0.021673432));

N30_5 := __common__(  map((iv_fp_divrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N30_6,
             (iv_fp_divrisktype in ['7'])                                           => 0.88370907,
                                                                                        N30_6));

N30_4 := __common__(  map((iv_phn_miskey in ['0']) => N30_5,
             (iv_phn_miskey in ['1']) => 1,
                                         N30_5));

N30_3 := __common__(  map((iv_fp_validationrisktype in ['1', '3', '4', '5', '6', '7', '8', '9']) => N30_4,
             (iv_fp_validationrisktype in ['2'])                                           => 0.31029008,
                                                                                               N30_4));

N30_2 := __common__(  if(((real)c_retired < 40.7), -0.0016740823, N30_3));

N30_1 := __common__(  if(trim(C_RETIRED) != '', N30_2, N30_7));

N31_7 := __common__(  map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '08 Military Zip', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College', '13 Vacant', '14 Zip/State Mismatch']) => -0.012239456,
             (iv_va100_add_problem in ['03 Standarization Error'])                                                                                                                                                                                                                                                                                => 0.74769849,
                                                                                                                                                                                                                                                                                                                                                     -0.012239456));

N31_6 := __common__(  map((iv_rec_vehx_level in ['AO', 'AW', 'W1', 'W3', 'XX']) => -0.011286219,
             (iv_rec_vehx_level in ['W2'])                         => 0.65088254,
                                                                      -0.011286219));

N31_5 := __common__(  map((iv_inp_addr_mortgage_type in ['Conventional', 'No Mortgage', 'Non-Traditional', 'Unknown'])                  => N31_6,
             (iv_inp_addr_mortgage_type in ['Commercial', 'Equity Loan', 'Government', 'High-Risk', 'Other', 'Piggyback']) => 0.24995139,
                                                                                                                              0.24995139));

N31_4 := __common__(  map((iv_ams_college_major in ['Business', 'Liberal Arts', 'No AMS Found', 'No College Found', 'Science', 'Unclassified']) => N31_5,
             (iv_ams_college_major in ['Medical'])                                                                                 => 1,
                                                                                                                                      N31_5));

N31_3 := __common__(  map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Piggyback', 'Unknown']) => N31_4,
             (iv_bst_addr_mortgage_type in ['Non-Traditional', 'Other'])                                                                                    => 0.27947429,
                                                                                                                                                               N31_4));

N31_2 := __common__(  if(((real)c_pop_55_64_p < 26.15), -0.0028866855, N31_3));

N31_1 := __common__(  if(trim(C_POP_55_64_P) != '', N31_2, N31_7));

N32_9 := __common__(  if(((real)c_retired2 < 69.5), -0.010283874, 0.17734222));

N32_8 := __common__(  if(trim(C_RETIRED2) != '', N32_9, -0.052309722));

N32_7 := __common__(  map((iv_prv_addr_mortgage_type in ['Conventional', 'Government', 'High-Risk', 'Unknown'])                                => -0.0063730322,
             (iv_prv_addr_mortgage_type in ['Commercial', 'Equity Loan', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback']) => N32_8,
                                                                                                                                     N32_8));

N32_6 := __common__( map(((real)iv_inp_addr_avm_pct_change_3yr <= NULL)     => -0.027553383,
													((real)iv_inp_addr_avm_pct_change_3yr < 0.631967) => 0.12468162,
																																								-0.027553383));

N32_5 := __common__( map(((integer)iv_dl001_lien_last_seen <= NULL) 	=> 0.16797877,
													((integer)iv_dl001_lien_last_seen < 41) => N32_6,
																																			0.16797877));

N32_4 := __common__(  if(((real)iv_inp_addr_avm_pct_change_3yr > NULL), N32_5, N32_7));

N32_3 := __common__(  map(((integer)iv_average_rel_distance <= NULL)  => N32_4,
													((integer)iv_average_rel_distance < 917) => 0.019941961,
																																			N32_4));

N32_2 := __common__(  if(((integer)iv_accident_recency < 9), -0.008313719, N32_3));

N32_1 := __common__(  if(((real)iv_accident_recency > NULL), N32_2, -0.006552337));

N33_8 := __common__(  map((iv_va007_add_vacant = 0  ) => 0.064217192,
             (iv_va007_add_vacant = 1) => 0.42483739,
                                               0.42483739));

N33_7 := __common__(  map((iv_bst_addr_mortgage_term in [0,  5, -1, 10, 15, 20, 25, 40]) => N33_8,
             (iv_bst_addr_mortgage_term in [30])                                           => 0.23936465,
                                                                                                N33_8));

N33_6 := __common__(  map((iv_in001_wealth_index in ['2', '3', '4', '5', '6']) => N33_7,
             (iv_in001_wealth_index in ['1'])                     => 1,
                                                                     N33_7));

N33_5 := __common__(  map((iv_fp_sourcerisktype in ['1', '3', '5', '6', '7', '8']) => -0.0020568913,
             (iv_fp_sourcerisktype in ['2', '4', '9'])                   => N33_6,
                                                                               N33_6));

N33_4 := __common__(  if(((real)iv_phones_per_addr_c6 < 3.5), N33_5, 0.13116274));

N33_3 := __common__(  if(((real)iv_phones_per_addr_c6 > NULL), N33_4, -0.050659813));

N33_2 := __common__(  if(((real)iv_ag001_age < 19.5), N33_3, -0.0022279419));

N33_1 := __common__(  if(((real)iv_ag001_age > NULL), N33_2, -0.029595987));

N34_8 := __common__( map(((real)iv_pl002_avg_mo_per_addr <= NULL) => 0.15324473,
													((real)iv_pl002_avg_mo_per_addr < 34.5)  => 0.055687115,
																																			0.15324473));

N34_7 := __common__( map(((integer)iv_inp_addr_building_area <= NULL)  => N34_8,
													((integer)iv_inp_addr_building_area < 861) => -0.0054519585,
																																				N34_8));

N34_6 := __common__( map(((real)iv_src_equifax_adl_count <= NULL) => -0.009120367,
													((real)iv_src_equifax_adl_count < 3.5)   => 0.046083247,
																																			-0.009120367));

N34_5 := __common__(  if(((real)c_mining < 3.3), N34_6, 0.12638679));

N34_4 := __common__(  if(trim(C_MINING) != '', N34_5, 0.013020832));

N34_3 := __common__(  map((iv_fp_sourcerisktype in ['2', '3', '5', '6', '7', '8', '9']) => N34_4,
             (iv_fp_sourcerisktype in ['1', '4'])                               => N34_7,
                                                                                     N34_4));

N34_2 := __common__(  if(((real)iv_va060_dist_add_in_bst < 1036.5), -0.0018255487, N34_3));

N34_1 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N34_2, -0.0073117567));

N35_8 := __common__(  map((iv_inp_addr_mortgage_type in ['Conventional', 'Equity Loan', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Unknown']) => 0.0049403465,
             (iv_inp_addr_mortgage_type in ['Commercial', 'Government', 'Piggyback'])                                                          => 0.2024628,
                                                                                                                                                  0.0049403465));

N35_7 := __common__(  map((iv_prv_addr_mortgage_term in [' 0', ' 5', '-1', '10', '20', '25', '30', '40']) => N35_8,
             (iv_prv_addr_mortgage_term in ['15'])                                           => 0.39920274,
                                                                                                N35_8));

N35_6 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-3', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-0', '3-1', '3-3']) => N35_7,
             (iv_paw_dead_bus_x_active_phn in ['0-2', '2-0', '3-2'])                                                                       => 0.19050988,
                                                                                                                                              N35_7));

N35_5 := __common__(  map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'No Mortgage', 'Non-Traditional', 'Piggyback', 'Unknown']) => N35_6,
             (iv_bst_addr_mortgage_type in ['High-Risk', 'Other'])                                                                                                => 0.32575119,
                                                                                                                                                                     N35_6));

N35_4 := __common__(  map((iv_prof_license_category in ['-1', '1', '2', '5']) => 0.0021444257,
             (iv_prof_license_category in ['0', '3', '4'])       => N35_5,
                                                                    0.0021444257));

N35_3 := __common__(  if(((real)iv_inq_ssn_ver_count > NULL), N35_4, -0.041686768));
// N35_3 := __common__(  if(((real)iv_inq_ssn_ver_count in [NULL, 0]), N35_4, -0.041686768));

N35_2 := __common__(  if(((real)iv_prv_addr_source_count < 12.5), N35_3, 0.090964611));

N35_1 := __common__(  if(((real)iv_prv_addr_source_count > NULL ), N35_2, -0.0011839924));

N36_8 := __common__(  map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '08 Military Zip', '09 Corporate Zip Code', '10 Zip/City Mismatch', '12 College', '13 Vacant', '14 Zip/State Mismatch']) => 0.016436573,
             (iv_va100_add_problem in ['11 Throw Back'])                                                                                                                                                                                                                                                                                                    => 0.9114666,
                                                                                                                                                                                                                                                                                                                                                               0.016436573));

N36_7 := __common__(  map((iv_fp_idverrisktype in ['2', '3', '4', '5', '6', '7', '8', '9']) => 0.050923687,
             (iv_fp_idverrisktype in ['1'])                                    => 1,
                                                                              0.050923687));

N36_6 := __common__(  map((iv_inp_addr_financing_type in ['NONE'])              => N36_7,
             (iv_inp_addr_financing_type in ['ADJ', 'CNV', 'OTH']) => 0.57130027,
                                                                      0.57130027));

N36_5 := __common__(  map((iv_bst_own_prop_x_addr_naprop in ['00', '01', '02', '03', '11', '12', '13', '14']) => N36_6,
             (iv_bst_own_prop_x_addr_naprop in ['04', '10'])                                     => 0.38707265,
                                                                                                    N36_6));

N36_4 := __common__(  if(((real)c_exp_prod < 10.5), N36_5, N36_8));

N36_3 := __common__(  if(trim(C_EXP_PROD) != '', N36_4, -0.010293565));

N36_2 := __common__(  if(((real)iv_inq_ssn_ver_count < 2.5), N36_3, -0.0048860125));
//  changed NULL to 0
N36_1 := __common__(  if(((real)iv_inq_ssn_ver_count > NULL), N36_2, -0.019440047));

N37_9 := __common__(  map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-1', '0-3', '1-0', '1-3', '2-1', '2-3', '3-0', '3-1', '3-3']) => -0.024706185,
             (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '1-1', '2-0'])                                                  => 0.17846666,
                                                                                                                         -0.024706185));

N37_8 := __common__(  map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-3']) => N37_9,
             (iv_criminal_x_felony in ['3-1', '3-2'])                                           => 0.84556341,
                                                                                                   N37_9));

N37_7 := __common__(  map(((real)iv_lname_score <= NULL) => 0.025309568,
													((real)iv_lname_score < 90.5)  => N37_8,
																														0.025309568));

N37_6 := __common__(  map((iv_prof_license_category in ['-1', '1', '2', '4', '5']) => N37_7,
             (iv_prof_license_category in ['0', '3'])                 => 0.21352348,
                                                                         N37_7));

N37_5 := __common__(  if(((real)iv_dist_inp_addr_to_prv_addr < 344.5), 0.0060000034, N37_6));

N37_4 := __common__(  if(((real)iv_dist_inp_addr_to_prv_addr > NULL), N37_5, 0.055498941));

N37_3 := __common__(  if(((real)iv_mos_since_lname_change > NULL), N37_4, -0.032772281));

N37_2 := __common__(  if(((real)c_incollege < 8.45), -0.0022929121, N37_3));

N37_1 := __common__(  if(trim(C_INCOLLEGE) != '', N37_2, 0.00021008309));

N38_10 := __common__(  map(((integer)iv_average_rel_income <= NULL)    => 0.0032587048,
														((integer)iv_average_rel_income < 32500) => 0.11615682,
																																				0.0032587048));

N38_9 := __common__(  if(((real)iv_pv001_bst_avm_chg_1yr > NULL), 0.018531906, N38_10));

N38_8 := __common__(  map(trim(C_FEMDIV_P) = ''      => 0.12123112,
             ((integer)c_femdiv_p < 12) => N38_9,
                                           0.12123112));

N38_7 := __common__(  map((iv_bst_own_prop_x_addr_naprop in ['03', '04', '10', '11', '12', '13', '14']) => -0.014295399,
             (iv_bst_own_prop_x_addr_naprop in ['00', '01', '02'])                         => 0.20344876,
                                                                                              -0.014295399));

N38_6 := __common__(  if(((real)c_pop_0_5_p < 2.35), N38_7, N38_8));

N38_5 := __common__(  if(trim(C_POP_0_5_P) != '', N38_6, 0.028669159));

N38_4 := __common__(  if(((real)iv_va060_dist_add_in_bst < 196.5), -0.006054221, N38_5));

N38_3 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N38_4, 0.033849731));

N38_2 := __common__(  if(((real)iv_inp_nhood_num_sfd < 423.5), -0.009374608, N38_3));

N38_1 := __common__(  if(((real)iv_inp_nhood_num_sfd > NULL), N38_2, -0.050744265));

N39_8 := __common__(  map((iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '0-3', '1-0', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => 0.052075786,
             (iv_nap_phn_ver_x_inf_phn_ver in [' -1', '1-1'])                                                                => 0.34706716,
                                                                                                                                0.052075786));

N39_7 := __common__(  if(((real)iv_inp_addr_avm_pct_change_3yr > NULL), N39_8, 0.035957398));

N39_6 := __common__(  map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-1', '2-2', '3-0', '3-1', '3-2']) => N39_7,
             (iv_liens_unrel_x_rel in ['2-0'])                                                                       => 0.75872988,
                                                                                                                        N39_7));

N39_5 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-2', '1-0', '1-1', '1-2', '2-0', '2-2']) => N39_6,
             (iv_num_purch_x_num_sold_60 in ['0-1', '2-1'])                                    => 0.40008461,
                                                                                                  N39_6));

N39_4 := __common__( map(((real)iv_src_bureau_adl_count <= NULL) => 0.011016839,
												((real)iv_src_bureau_adl_count < 13.5)  => N39_5,
																																		0.011016839));

N39_3 := __common__( map(((integer)iv_fp_curraddrmedianvalue <= NULL)      => N39_4,
													((integer)iv_fp_curraddrmedianvalue < 220033) => 0.0010413598,
																																					N39_4));

N39_2 := __common__(  map((iv_dl_val_flag in ['Not Avail', 'Valid']) => -0.013135622,
             (iv_dl_val_flag in ['Empty'])              => N39_3,
                                                           -0.013135622));

N39_1 := __common__(  if(((real)iv_src_drivers_lic_adl_count > NULL), N39_2, 0.00090408307));

N40_7 := __common__(  map((iv_in001_wealth_index in ['1', '2', '3', '4', '5']) => -0.053108735,
             (iv_in001_wealth_index in ['6'])                     => 0.17939436,
                                                                     -0.053108735));

N40_6 := __common__(  map((iv_vp001_phn_not_issued = 0) => 0.017036592,
             (iv_vp001_phn_not_issued = 1) => 0.20623223,
                                                   0.017036592));

N40_5 := __common__(  if(((real)iv_prop1_purch_sale_diff > NULL), 1, N40_6));

N40_4 := __common__(  map((iv_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N40_5,
             (iv_fp_srchcomponentrisktype in ['7'])                                           => 0.18072503,
                                                                                                  N40_5));

N40_3 := __common__(  map((iv_bst_addr_financing_type in ['ADJ', 'NONE']) => -0.0025871023,
             (iv_bst_addr_financing_type in ['CNV', 'OTH'])  => 0.065735789,
                                                                -0.0025871023));

N40_2 := __common__(  if(((real)c_hval_750k_p < 68.25), N40_3, N40_4));

N40_1 := __common__(  if(trim(C_HVAL_750K_P) != '', N40_2, N40_7));

N41_7 := __common__(  if(((real)iv_purch_sold_val_diff > NULL), 0.093871295, -0.052386745));

N41_6 := __common__(  map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'I', 'J', 'K']) => N41_7,
             (iv_in001_college_income in ['H'])                                                    => 0.15484326,
                                                                                                      N41_7));

N41_5 := __common__(  map(iv_prop_sold_assessed_total = NULL 						=> 0.025960121,
						((integer)iv_prop_sold_assessed_total < 259576) => -0.002029439, 
																																0.025960121));
																																

N41_4 := __common__(  map((iv_fp_varrisktype in ['1', '2', '3', '4', '5', '6', '7', '9', '-1']) => -0.041247999,
             (iv_fp_varrisktype in ['8'])                                                 => 0.37843272,
                                                                                              -0.041247999));

N41_3 := __common__(  map((iv_prv_own_prop_x_addr_naprop in ['01', '02', '03', '04', '10', '11', '12']) => N41_4,
             (iv_prv_own_prop_x_addr_naprop in ['00', '13', '14'])                         => 0.16529242,
                                                                                              N41_4));

N41_2 := __common__(  if(((real)c_murders < 1.5), N41_3, N41_5));

N41_1 := __common__(  if(trim(C_MURDERS) != '', N41_2, N41_6));

N42_10 := __common__(   map(((real)iv_average_rel_distance <= NULL) => -0.054980222,
														((real)iv_average_rel_distance < 964.5) => 0.00099116691,
																																			-0.054980222));

N42_9 :=  __common__(  map(((real)iv_pb_average_dollars <= NULL) => N42_10,
														((real)iv_pb_average_dollars < 47.5)  => 0.019684309,
																																		N42_10));

N42_8 := __common__(  if(((integer)iv_sr001_m_hdr_fs < 107), 0.15082292, N42_9));

N42_7 := __common__(  if(((real)iv_sr001_m_hdr_fs > NULL), N42_8, 0.050957505));

N42_6 := __common__(  if(((real)c_born_usa < 3.5), 0.10454827, N42_7));

N42_5 := __common__(  if(trim(C_BORN_USA) != '', N42_6, -0.051093847));

N42_4 := __common__(  map((iv_bst_addr_mortgage_term in [0, 5, -1, 10, 15, 20, 30, 40]) => N42_5,
             (iv_bst_addr_mortgage_term in [25])                           => 1,
                                                                           N42_5));

N42_3 := __common__(  if(((real)iv_ag001_age < 57.5), -0.009489143, N42_4));

N42_2 := __common__(  if(((real)iv_ag001_age > NULL), N42_3, -0.0026401243));

N42_1 := __common__(  if(((real)iv_bst_addr_avm_pct_change_2yr > NULL), -0.0031153286, N42_2));

N43_9 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2']) => -0.0019777153,
             (iv_num_purch_x_num_sold_60 in ['1-2'])                                                  => 0.33503065,
                                                                                                         -0.0019777153));

N43_8 := __common__(  map((iv_fp_idverrisktype in ['1', '2', '3', '4', '7', '8', '9']) => 0.0013444235,
             (iv_fp_idverrisktype in ['5', '6'])                               => 0.059902541,
                                                                                    0.0013444235));

N43_7 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N43_8, -0.052009679));

N43_6 := __common__(  map((iv_liens_unrel_x_rel_o in ['0-0', '0-1', '0-2', '1-1', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N43_7,
             (iv_liens_unrel_x_rel_o in ['1-0'])                                                                       => 0.56497449,
                                                                                                                          N43_7));

N43_5 := __common__(  map((iv_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-2', '3-0', '3-1', '3-2']) => N43_6,
             (iv_liens_unrel_x_rel in ['1-2', '2-1'])                                                         => 0.31809487,
                                                                                                                 N43_6));

N43_4 := __common__(  if(((real)iv_addr_lres_12mo_count < 0.5), N43_5, 0.0070832455));

N43_3 := __common__(  if(((real)iv_addr_lres_12mo_count > NULL), N43_4, 0.024828414));

N43_2 := __common__(  if(((real)c_incollege < 8.35), -0.0051040269, N43_3));

N43_1 := __common__(  if(trim(C_INCOLLEGE) != '', N43_2, N43_9));

N44_6 := __common__(  map(((real)iv_sr001_source_profile <= NULL) => 0.1491704,
													((real)iv_sr001_source_profile < 33.1)  => 0.0094970569,
																																		0.1491704));

N44_5 := __common__(  map(((real)iv_ag001_age <= NULL) => 0.0083112498,
													((real)iv_ag001_age < 19.5)  => N44_6,
																													0.0083112498));

N44_4 := __common__(  map(((real)iv_inq_ssn_ver_count <= NULL) => -0.0090178886,
														((real)iv_inq_ssn_ver_count < 3.5)   => N44_5,
																																-0.0090178886));

N44_3 := __common__(  map(((real)iv_accident_count <= NULL) => 0.072428083,
													((real)iv_accident_count < 6.5)   => N44_4,
																															0.072428083));

N44_2 := __common__(  if(((real)iv_inq_ssn_ver_count > NULL), N44_3, -0.0082969268));

// N44_1 := __common__(  if(((real)iv_prop_sold_assessed_count < 3.5), N44_2, 0.08688347));
N44_1 := __common__(  MAP((real)iv_prop_sold_assessed_count = NULL  =>  0.08688347,
													(real)iv_prop_sold_assessed_count < 3.5    =>  N44_2, 
																																					0.08688347));  

N45_8 := __common__(  map((iv_fp_addrchangeecontrajindex in ['2', '4', '-1'])       => 0.014628067,
             (iv_fp_addrchangeecontrajindex in ['1', '3', '5', '6']) => 0.27292797,
                                                                            0.27292797));

N45_7 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '0-2', '1-0', '1-2', '2-0', '2-1', '2-2']) => N45_8,
             (iv_num_purch_x_num_sold_60 in ['1-1'])                                                  => 0.73235464,
                                                                                                         N45_8));

N45_6 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => 0.012391566,
             (iv_paw_dead_bus_x_active_phn in ['0-3'])                                                                                                   => 0.36675116,
                                                                                                                                                            0.012391566));

N45_5 := __common__(  if(((real)c_pop_85p_p < 2.25), N45_6, N45_7));

N45_4 := __common__(  if(trim(C_POP_85P_P) != '', N45_5, -0.065343812));

N45_3 := __common__(  map((iv_ams_college_tier in ['-1', '0', '1', '2', '6']) => N45_4,
             (iv_ams_college_tier in ['3', '4', '5'])            => 0.43142953,
                                                                    N45_4));

N45_2 := __common__(  if(((integer)iv_inp_nhood_num_sfd < 1151), -0.0025364736, N45_3));

N45_1 := __common__(  if(((real)iv_inp_nhood_num_sfd > NULL), N45_2, -0.050605923));

N46_9 := __common__(  map((iv_fname_eda_sourced_type in ['-1', 'AP', 'P']) => 0.039055905,
             (iv_fname_eda_sourced_type in ['A'])             => 1,
                                                                 0.039055905));

N46_8 := __common__(  if(((real)iv_inp_addr_avm_pct_change_3yr > NULL), N46_9, 0.038947043));

N46_7 := __common__(  map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'No Mortgage', 'Other', 'Piggyback', 'Unknown']) => N46_8,
             (iv_bst_addr_mortgage_type in ['High-Risk', 'Non-Traditional'])                                                                            => 0.34621627,
                                                                                                                                                           N46_8));

N46_6 := __common__( map(((real)iv_inq_lname_ver_count <= NULL) => 0.0058748711,
													((real)iv_inq_lname_ver_count < 4.5)   => N46_7,
																																		0.0058748711));

N46_5 := __common__(  if(((real)iv_inq_ssn_ver_count > NULL), N46_6, -0.050403831));

N46_4 := __common__(  map((iv_fp_prevaddrdwelltype in ['-1', 'F', 'H', 'M', 'P', 'R', 'S', 'U']) => N46_5,
             (iv_fp_prevaddrdwelltype in ['G'])                                     => 0.49439135,
                                                                                       N46_5));

N46_3 := __common__(  map((iv_liens_unrel_x_rel_ot in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N46_4,
             (iv_liens_unrel_x_rel_ot in ['1-2'])                                                                       => 1,
                                                                                                                           N46_4));

N46_2 := __common__(  if(((real)iv_fp_addrchangeincomediff < 24078.5), -0.0038178397, N46_3));

N46_1 := __common__(  if(((real)iv_fp_addrchangeincomediff > NULL), N46_2, 0.0051952622));

N47_8 := __common__(  map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '2 Disconnected', '3 Not_Issued', '5 Cell', '6 Pager', '7 PCS', '8 Pay_Phone']) => 0.036449968,
             (iv_vp100_phn_prob in ['4 Invalid'])                                                                                                      => 0.13768943,
                                                                                                                                                          0.036449968));

N47_7 := __common__(  map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '08 Military Zip', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College']) => -0.0049971692,
             (iv_va100_add_problem in ['03 Standarization Error', '13 Vacant', '14 Zip/State Mismatch'])                                                                                                                                                                                                    => N47_8,
                                                                                                                                                                                                                                                                                                               -0.0049971692));

N47_6 := __common__(  map((iv_fp_prevaddrdwelltype in ['-1', 'F', 'H', 'M', 'P', 'R', 'S', 'U']) => N47_7,
             (iv_fp_prevaddrdwelltype in ['G'])                                     => 0.21532665,
                                                                                       N47_7));

N47_5 :=  __common__( map(((real)iv_bst_addr_avm_pct_change_2yr <= NULL)   => 0.18788074,
													((real)iv_bst_addr_avm_pct_change_2yr < 2.55963) => -0.0062799604,
																																							0.18788074));

N47_4 := __common__(  map(trim(C_YOUNG) = ''     => N47_5,
             ((real)c_young < 4.45) => 0.077516276,
                                       N47_5));

N47_3 := __common__(  if(((real)c_inc_100k_p < 0.95), 0.22922908, N47_4));

N47_2 := __common__(  if(trim(C_INC_100K_P) != '', N47_3, -0.033605333));

N47_1 := __common__(  if(((real)iv_bst_addr_avm_pct_change_3yr > NULL), N47_2, N47_6));

N48_5 := __common__( map(((integer)iv_mos_since_prop1_sale <= NULL) => 0.13003034,
												((integer)iv_mos_since_prop1_sale < 7)  => 0.029285,
																																		0.13003034));


N48_4 := __common__(  map((iv_inp_addr_mortgage_term in [' 0', ' 5', '-1', '10', '15', '30', '40']) => N48_5,
             (iv_inp_addr_mortgage_term in ['20', '25'])                               => 0.51722592,
                                                                                          N48_5));

N48_3 := __common__(  map((iv_fp_assocrisktype in ['1', '2', '4', '5', '7', '8', '9']) => 0.0057367648,
             (iv_fp_assocrisktype in ['3', '6'])                               => N48_4,
                                                                                    0.0057367648));


N48_2 := __common__( map(((integer)iv_df001_mos_since_fel_ls <= NULL)  => 0.13675713,
													((integer)iv_df001_mos_since_fel_ls < 182) => N48_3,
																																				0.13675713));

N48_1 := __common__(  map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-3', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => -0.0076118384,
             (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1'])                                                  => N48_2,
                                                                                                                         -0.0076118384));

N49_9 := __common__(  map((iv_pb_order_freq in ['0 No Purch Data', '1 Cant Calculate', '2 Weekly', '3 Monthly', '5 Quarterly', '6 Semi-yearly', '7 Yearly', '8 Rarely']) => -0.0007153653,
             (iv_pb_order_freq in ['4 Semi-monthly'])                                                                                                       => 0.50966725,
                                                                                                                                                               -0.0007153653));

N49_8 := __common__(  map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'J', 'K']) => N49_9,
             (iv_in001_college_income in ['H', 'I'])                                          => 0.2610192,
                                                                                                 N49_9));

N49_7 := __common__(  map((iv_inp_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Other', 'Piggyback', 'Unknown']) => N49_8,
             (iv_inp_addr_mortgage_type in ['Non-Traditional'])                                                                                                      => 0.15970112,
                                                                                                                                                                        N49_8));

N49_6 := __common__(  if(((real)c_femdiv_p < 0.65), 0.09882027, 0.014379506));

N49_5 := __common__(  if(trim(C_FEMDIV_P) != '', N49_6, -0.050674766));

N49_4 := __common__( map(((real)iv_inp_addr_avm_pct_change_2yr <= NULL)   => -0.010325677,
													((real)iv_inp_addr_avm_pct_change_2yr < 0.83024) => N49_5,
																																								-0.010325677));

N49_3 := __common__(  if(((real)iv_fp_srchaddrsrchcountmo < 6.5), N49_4, N49_7));

N49_2 := __common__(  if(((real)iv_fp_srchaddrsrchcountmo > NULL), N49_3, 0.0082786435));

N49_1 := __common__(  if(((real)iv_inp_addr_avm_pct_change_2yr > NULL), N49_2, -0.0016709225));


N50_8 := __common__( map(((real)iv_src_experian_adl_count <= NULL) => 0.032865097,
												((real)iv_src_experian_adl_count < 18.5)  => 0.18097375,
																																			0.032865097));

N50_7 := __common__(  map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '3-0', '3-1', '3-2']) => 0.0040327304,
             (iv_criminal_x_felony in ['2-2', '3-3'])                                           => 0.22662099,
                                                                                                   0.0040327304));

N50_6 := __common__(  map(trim(C_PROFESSIONAL) = ''      => N50_8,
             ((real)c_professional < 10.45) => N50_7,
                                               N50_8));

N50_5 := __common__(  map(trim(C_INC_125K_P) = ''     => -0.024447313,
             ((real)c_inc_125k_p < 3.85) => 0.035375118,
                                            -0.024447313));

N50_4 := __common__(  if(((real)c_many_cars < 81.5), N50_5, N50_6));

N50_3 := __common__(  if(trim(C_MANY_CARS) != '', N50_4, 0.10344378));

N50_2 := __common__(  if(((real)iv_po001_m_snc_veh_adl_fs < 117.5), -0.0062539285, N50_3));

N50_1 := __common__(  if(((real)iv_po001_m_snc_veh_adl_fs > NULL), N50_2, 0.001935259));

N51_7 := __common__(  map((iv_fp_srchvelocityrisktype in ['1', '2', '3', '4', '6', '7', '8', '9']) => -0.019263871,
             (iv_fp_srchvelocityrisktype in ['5'])                                           => 0.1364823,
                                                                                                 0.1364823));

N51_6 := __common__(  map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'I', 'K']) => N51_7,
             (iv_in001_college_income in ['H', 'J'])                                          => 0.28509408,
                                                                                                 N51_7));

N51_5 := __common__(  map((iv_ams_college_major in ['Business', 'Liberal Arts', 'No AMS Found', 'No College Found', 'Science', 'Unclassified']) => N51_6,
             (iv_ams_college_major in ['Medical'])                                                                                 => 1,
                                                                                                                                      N51_6));

N51_4 := __common__(  map((iv_fp_validationrisktype in ['1', '2', '3', '4', '6', '7', '8', '9']) => N51_5,
             (iv_fp_validationrisktype in ['5'])                                           => 1,
                                                                                               N51_5));

N51_3 := __common__(  map((iv_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '8', '9']) => N51_4,
             (iv_fp_srchcomponentrisktype in ['7'])                                           => 0.11590569,
                                                                                                  N51_4));

N51_2 := __common__(  if(((real)c_transport < 48.35), -0.0031420602, N51_3));

N51_1 := __common__(  if(trim(C_TRANSPORT) != '', N51_2, -0.013406869));

N52_7 := __common__(  map(trim(C_RNT250_P) = ''     => 0.22984398,
             ((real)c_rnt250_p < 2.05) => 0.022993578,
                                          0.22984398));

N52_6 := __common__(  map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '06 Invalid Address', '07 Busines', '08 Military Zip', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College', '13 Vacant', '14 Zip/State Mismatch']) => 0.0069099023,
             (iv_va100_add_problem in ['05 Drop Delivery'])                                                                                                                                                                                                                                                                                              => 0.45336394,
                                                                                                                                                                                                                                                                                                                                                            0.0069099023));

N52_5 := __common__( map(((real)iv_pl001_bst_addr_lres <= NULL) => N52_7,
													((real)iv_pl001_bst_addr_lres < 113.5) => N52_6,
																																		N52_7));

N52_4 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-2']) => N52_5,
             (iv_num_purch_x_num_sold_60 in ['2-0', '2-1'])                                    => 0.22076023,
                                                                                                  N52_5));

N52_3 := __common__( map(((real)iv_fp_srchaddrsrchcountwk <= NULL) => N52_4,
													((real)iv_fp_srchaddrsrchcountwk < 0.5)   => 0.00097368905,
																																				N52_4));

N52_2 := __common__(  if(((real)iv_mos_src_experian_adl_fseen < 278.5), N52_3, -0.034777066));

N52_1 := __common__(  if(((real)iv_mos_src_experian_adl_fseen > NULL), N52_2, -0.0040064757));

N53_8 := __common__(  map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'I', 'J', 'K']) => 0.012574505,
             (iv_in001_college_income in ['H'])                                                    => 0.13754933,
                                                                                                      0.012574505));

N53_7 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2']) => N53_8,
             (iv_num_purch_x_num_sold_60 in ['1-2'])                                                  => 0.21277754,
                                                                                                         N53_8));

N53_6 := __common__(  map((iv_liens_unrel_x_rel_ft in ['0-0', '0-1', '1-0', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => -0.029405855,
             (iv_liens_unrel_x_rel_ft in ['0-2', '1-1'])                                                         => 0.65488879,
                                                                                                                    -0.029405855));

N53_5 := __common__(  map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'I']) => -0.0014193339,
             (iv_in001_college_income in ['H', 'J', 'K'])                                => 0.051731141,
                                                                                            -0.0014193339));

N53_4 := __common__(  if(((integer)iv_pct_rel_prop_owned < 45), N53_5, N53_6));

N53_3 := __common__(  if(((real)iv_pct_rel_prop_owned > NULL), N53_4, 0.0030768559));

N53_2 := __common__(  if(((real)c_many_cars < 193.5), N53_3, 0.12066136));

N53_1 := __common__(  if(trim(C_MANY_CARS) != '', N53_2, N53_7));

N54_8 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2']) => -0.022454903,
             (iv_num_purch_x_num_sold_60 in ['1-2'])                                                  => 0.15635996,
                                                                                                         -0.022454903));

N54_7 := __common__(  if(((real)iv_inq_phone_ver_count < 137.5), -0.011284344, 0.0941327));

N54_6 := __common__(  if(((real)iv_inq_phone_ver_count > NULL), N54_7, 0.046356589));

N54_5 := __common__(  map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Unknown']) => N54_6,
             (iv_bst_addr_mortgage_type in ['Piggyback'])                                                                                                                  => 0.58407187,
                                                                                                                                                                              N54_6));

N54_4 := __common__(  map((iv_bst_own_prop_x_addr_naprop in ['00', '01', '02', '03', '10', '11', '12', '13', '14']) => N54_5,
             (iv_bst_own_prop_x_addr_naprop in ['04'])                                                 => 0.17196085,
                                                                                                          N54_5));

N54_3 := __common__(  map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '08 Military Zip', '09 Corporate Zip Code', '11 Throw Back', '12 College', '14 Zip/State Mismatch']) => N54_4,
             (iv_va100_add_problem in ['10 Zip/City Mismatch', '13 Vacant'])                                                                                                                                                                                                                                                            => 0.28343111,
                                                                                                                                                                                                                                                                                                                                           N54_4));

N54_2 := __common__(  if(((real)c_fammar18_p < 2.15), N54_3, -0.0012564954));

N54_1 := __common__(  if(trim(C_FAMMAR18_P) != '', N54_2, N54_8));

N55_7 := __common__(  map(((real)iv_mos_src_equifax_adl_lseen <= NULL) => 0.10492149,
													((real)iv_mos_src_equifax_adl_lseen < 31.5)  => -0.00013261661,
																																						0.10492149));

N55_6 := __common__(  map((iv_fp_divrisktype in ['1', '2', '4', '6', '7', '8']) => N55_7,
             (iv_fp_divrisktype in ['3', '5', '9'])                   => 0.14463801,
                                                                            N55_7));

N55_5 := __common__(  map((iv_bst_own_prop_x_addr_naprop in ['00', '01', '02', '03', '04', '10', '11', '13', '14']) => N55_6,
             (iv_bst_own_prop_x_addr_naprop in ['12'])                                                 => 0.73626083,
                                                                                                          N55_6));

N55_4 := __common__(  map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Unknown']) => N55_5,
             (iv_bst_addr_mortgage_type in ['Piggyback'])                                                                                                                  => 0.20749374,
                                                                                                                                                                              N55_5));

N55_3 := __common__(  map((iv_vp100_phn_prob in ['0 No Phone Problems', '1 HiRisk', '3 Not_Issued', '5 Cell', '6 Pager', '7 PCS', '8 Pay_Phone']) => -0.006653067,
             (iv_vp100_phn_prob in ['2 Disconnected', '4 Invalid'])                                                                  => N55_4,
                                                                                                                                        -0.006653067));

N55_2 := __common__(  if(((real)iv_mos_src_property_adl_lseen < 208.5), N55_3, 0.17142294));

N55_1 := __common__(  if(((real)iv_mos_src_property_adl_lseen > NULL), N55_2, -0.0059042981));

N56_8 := __common__(  map((iv_pl001_addr_stability_v2 in ['0', '1', '2', '3', '4', '6']) => -0.011620999,
             (iv_pl001_addr_stability_v2 in ['5'])                          => 0.19037656,
                                                                               -0.011620999));

N56_7 := __common__(  map((iv_prof_license_category in ['-1', '1', '3', '4', '5']) => 0.011870223,
             (iv_prof_license_category in ['0', '2'])                 => 0.36099811,
                                                                         0.011870223));

N56_6 := __common__(  if(((real)c_inc_125k_p < 15.05), N56_7, 0.11533285));

N56_5 := __common__(  if(trim(C_INC_125K_P) != '', N56_6, -0.019975722));

N56_4 := __common__( map(((integer)iv_va060_dist_add_in_bst <= NULL)    => N56_5,
													((integer)iv_va060_dist_add_in_bst < 1874) => 0.0025647657,
																																				N56_5));

N56_3 := __common__(  map((iv_inp_addr_mortgage_type in ['Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Non-Traditional', 'Other', 'Piggyback', 'Unknown']) => N56_4,
             (iv_inp_addr_mortgage_type in ['Commercial'])                                                                                                                => 0.16660139,
                                                                                                                                                                             N56_4));

N56_2 := __common__(  map((iv_liens_unrel_x_rel in ['0-2', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => -0.027398124,
             (iv_liens_unrel_x_rel in ['0-0', '0-1', '1-0', '1-1'])                             => N56_3,
                                                                                                   -0.027398124));

N56_1 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N56_2, N56_8));

N57_7 := __common__(  map((iv_inp_addr_mortgage_term in [' 0', ' 5', '-1', '10', '15', '20', '30', '40']) => 0.018337677,
             (iv_inp_addr_mortgage_term in ['25'])                                           => 1,
                                                                                                0.018337677));

N57_6 := __common__(  map(trim(C_MED_AGE) = ''      => 0.14909805,
             ((real)c_med_age < 49.35) => 0.022028418,
                                          0.14909805));

N57_5 := __common__(  map(trim(C_HVAL_150K_P) = ''     => N57_6,
             ((real)c_hval_150k_p < 1.85) => -0.011919414,
                                             N57_6));

N57_4 := __common__(  if(((real)iv_derog_ratio > NULL), N57_5, N57_7));

N57_3 := __common__(  if(((integer)c_blue_col < 26), N57_4, 0.15509171));

N57_2 := __common__(  if(trim(C_BLUE_COL) != '', N57_3, 0.022472172));

N57_1 := __common__(  map((iv_vp091_phnzip_mismatch = 0) => -0.004061711,
             (iv_vp091_phnzip_mismatch = 1) => N57_2,
                                                    -0.004061711));

N58_9 := __common__(  map((iv_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '6', '8']) => 0.04920985,
             (iv_fp_srchcomponentrisktype in ['7', '9'])                               => 0.32263133,
                                                                                            0.04920985));

N58_8 := __common__( map(((real)iv_inp_addr_avm_pct_change_3yr <= NULL)    => 6.3530037e-006,
													((real)iv_inp_addr_avm_pct_change_3yr < 0.249215) => N58_9,
																																								6.3530037e-006));

N58_7 := __common__(  map(trim(C_TRAILER) = ''      => 0.13154526,
             ((real)c_trailer < 195.5) => N58_8,
                                          0.13154526));

N58_6 := __common__(  map(trim(C_HH1_P) = ''     => N58_7,
             ((real)c_hh1_p < 2.65) => 0.17352106,
                                       N58_7));

N58_5 := __common__(  if(((real)iv_inp_addr_avm_pct_change_3yr > NULL), N58_6, 0.0010732738));

N58_4 := __common__(  if(((real)c_rnt2000_p < 72.25), N58_5, 0.12254791));

N58_3 := __common__(  if(trim(C_RNT2000_P) != '', N58_4, -0.010446365));

N58_2 := __common__(  if(((real)iv_credit_seeking < 0.5), N58_3, -0.022332301));

N58_1 := __common__(  if(((real)iv_credit_seeking > NULL), N58_2, 0.0046703701));

N59_7 := __common__(  map((iv_fp_idrisktype in ['1', '3', '5', '6', '7', '9', '-1']) => 0.003264105,
             (iv_fp_idrisktype in ['2', '4', '8'])                         => 0.17875336,
                                                                                 0.003264105));

N59_6 := __common__(  map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-1', '0-3', '1-0', '1-1', '1-3', '2-0', '2-3', '3-0', '3-1', '3-3']) => N59_7,
             (iv_nap_phn_ver_x_inf_phn_ver in ['2-1'])                                                                              => 0.43165585,
                                                                                                                                       N59_7));

N59_5 := __common__(  if(((real)iv_inq_per_addr < 0.5), 0.027204016, -0.021610039));

N59_4 := __common__(  if(((real)iv_inq_per_addr > NULL), N59_5, -0.050366189));

N59_3 := __common__(  if(((real)iv_vp090_phn_dst_to_inp_add > NULL), N59_4, -0.0024860644));

N59_2 := __common__(  map((iv_nas_summary in [0, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12]) => N59_3,
             (iv_nas_summary in [7])                                                                   => N59_6,
                                                                                                             N59_3));

N59_1 := __common__(  map((iv_liens_unrel_x_rel_ft in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N59_2,
             (iv_liens_unrel_x_rel_ft in ['0-2', '1-2'])                                                         => 0.10733276,
                                                                                                                    N59_2));

N60_6 := __common__(  if(((real)c_high_ed < 10.6), 0.11344246, -0.011818846));

N60_5 := __common__(  if(trim(C_HIGH_ED) != '', N60_6, 0.036812392));

N60_4 := __common__(  map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'High-Risk', 'No Mortgage', 'Other', 'Unknown']) => N60_5,
             (iv_prv_addr_mortgage_type in ['Non-Traditional', 'Piggyback'])                                                                            => 0.27956222,
                                                                                                                                                           N60_5));

N60_3 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-3', '1-0', '1-1', '1-2', '1-3', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2', '3-3']) => N60_4,
             (iv_paw_dead_bus_x_active_phn in ['0-2', '2-0'])                                                                                     => 0.23205219,
                                                                                                                                                     N60_4));

N60_2 := __common__(  map((iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '2 - BK Dismissed']) => N60_3,
             (iv_db001_bankruptcy in ['3 - BK Other'])                                       => 0.60700047,
                                                                                                N60_3));

N60_1 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '0-2', '1-0', '1-1', '2-0', '2-1']) => -0.00064203621,
             (iv_num_purch_x_num_sold_60 in ['0-1', '1-2', '2-2'])                      => N60_2,
                                                                                           -0.00064203621));

N61_7 := __common__(  map((iv_fp_sourcerisktype in ['2', '3', '4', '5', '6', '7', '8', '9']) => -0.014527496,
             (iv_fp_sourcerisktype in ['1'])                                           => 0.11064214,
                                                                                           -0.014527496));

N61_6 := __common__(  map((iv_fp_assocrisktype in ['1', '2', '3', '4', '5', '6', '7', '9']) => 0.021355992,
             (iv_fp_assocrisktype in ['8'])                                           => 0.25053382,
                                                                                          0.021355992));

N61_5 := __common__(  map((iv_inp_own_prop_x_addr_naprop in ['00', '01', '02', '03', '04', '10', '11', '12', '14']) => N61_6,
             (iv_inp_own_prop_x_addr_naprop in ['13'])                                                 => 0.47324729,
                                                                                                          N61_6));

N61_4 := __common__(  map((iv_fp_idrisktype in ['1', '2', '3', '4', '6', '7', '8', '9', '-1']) => N61_5,
             (iv_fp_idrisktype in ['5'])                                                 => 1,
                                                                                             N61_5));

N61_3 := __common__(  map((iv_nas_summary in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]) => N61_4,
             (iv_nas_summary in [0])                                                                   => 0.5750349,
                                                                                                             N61_4));

N61_2 := __common__(  if(((real)c_inc_150k_p < 15.85), -0.00289728, N61_3));

N61_1 := __common__(  if(trim(C_INC_150K_P) != '', N61_2, N61_7));

N62_8 := __common__(  map((iv_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-3']) => 0.053972708,
             (iv_criminal_x_felony in ['3-2'])                                                         => 0.45494392,
                                                                                                          0.053972708));

N62_7 := __common__(  map((iv_fp_srchcomponentrisktype in ['1', '2', '3', '4', '5', '7', '8', '9']) => N62_8,
             (iv_fp_srchcomponentrisktype in ['6'])                                           => 0.30602303,
                                                                                                  N62_8));

N62_6 := __common__(  map(trim(C_RNT1000_P) = ''      => N62_7,
             ((real)c_rnt1000_p < 33.75) => 0.010274601,
                                            N62_7));

N62_5 := __common__( map(((real)iv_src_experian_adl_count <= NULL) => 0.00225701,
												((real)iv_src_experian_adl_count < 6.5)   => N62_6,
																																			0.00225701));

N62_4 := __common__( map(((real)iv_inq_addr_ver_count <= NULL) => -0.016732232,
													((real)iv_inq_addr_ver_count < 0.5)   => N62_5,
																																		-0.016732232));

N62_3 := __common__(  if(((real)c_fammar_p < 89.35), N62_4, -0.026522806));

N62_2 := __common__(  if(trim(C_FAMMAR_P) != '', N62_3, 0.020115789));

N62_1 := __common__(  if(((real)iv_inq_addr_ver_count > NULL), N62_2, -0.017416103));

N63_8 := __common__(  map((iv_inp_addr_mortgage_term in [' 0', ' 5', '-1', '10', '15', '30']) => 0.064448717,
             (iv_inp_addr_mortgage_term in ['20', '25', '40'])                   => 0.32622044,
                                                                                    0.064448717));

N63_7 := __common__(  if(((real)c_hval_175k_p < 5.25), -0.015222522, N63_8));

N63_6 := __common__(  if(trim(C_HVAL_175K_P) != '', N63_7, 0.1110351));

N63_5 := __common__(  map((iv_input_dob_match_level in ['0', '1', '2', '3', '4', '6', '7', '8']) => N63_6,
             (iv_input_dob_match_level in ['5'])                                    => 1,
                                                                                       N63_6));

N63_4 := __common__(  map((iv_fp_addrchangeecontrajindex in ['1', '2', '3', '4', '5', '-1']) => N63_5,
             (iv_fp_addrchangeecontrajindex in ['6'])                               => 0.30512273,
                                                                                        N63_5));


N63_3 := __common__( map(((real)iv_mos_since_prop1_sale <= NULL) => N63_4,
													((real)iv_mos_since_prop1_sale < 108.5) => 0.0031667299,
																																			N63_4));

N63_2 := __common__(  if(((real)iv_sr001_m_bureau_adl_fs < 364.5), N63_3, -0.025705874));

N63_1 := __common__(  if(((real)iv_sr001_m_bureau_adl_fs > NULL), N63_2, 0.0011755365));

N64_8 := __common__(  map((iv_prv_own_prop_x_addr_naprop in ['00', '01', '02', '03', '04', '11', '13', '14']) => 0.024384808,
             (iv_prv_own_prop_x_addr_naprop in ['10', '12'])                                     => 0.24672231,
                                                                                                    0.24672231));


N64_7 := __common__( map(((real)iv_src_experian_adl_count <= NULL) => -0.053022945,
													((real)iv_src_experian_adl_count < 14.5)  => 0.13759794,
																																			-0.053022945));

N64_6 := __common__(  map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '05 Drop Delivery', '06 Invalid Address', '08 Military Zip', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College', '13 Vacant', '14 Zip/State Mismatch']) => -0.0044744949,
             (iv_va100_add_problem in ['03 Standarization Error', '04 HiRisk Commercial', '07 Busines'])                                                                                                                                                                                                    => 0.059686761,
                                                                                                                                                                                                                                                                                                               -0.0044744949));

N64_5 := __common__( map(((real)iv_mos_src_bureau_dob_fseen <= NULL) => 0.062750078,
													((real)iv_mos_src_bureau_dob_fseen < 380.5) => N64_6,
																																				0.062750078));

N64_4 := __common__(  map(trim(C_POP_85P_P) = ''     => N64_7,
             ((real)c_pop_85p_p < 6.55) => N64_5,
                                           N64_7));

N64_3 := __common__(  if(((real)iv_bst_addr_mtg_avm_pct_diff > NULL), N64_4, -0.0014191712));

N64_2 := __common__(  if(((real)c_inc_150k_p < 15.85), N64_3, N64_8));

N64_1 := __common__(  if(trim(C_INC_150K_P) != '', N64_2, 0.0031226602));

N65_7 := __common__(  map((iv_nas_summary in [  0 ,   1 ,   3 ,   4 ,   5 ,   6 ,   7 ,   8 ,   9 ,  10 ,  11 ,  12 ]) => 0.036638382, 
             (iv_nas_summary in [  2 ])                                                                   => 1,
                                                                                                             0.036638382));

N65_6 := __common__(  map((iv_inp_own_prop_x_addr_naprop in ['00', '01', '03', '04', '11', '12', '13', '14']) => 0.057109053,
             (iv_inp_own_prop_x_addr_naprop in ['02', '10'])                                     => 0.41603155,
                                                                                                    0.057109053));

N65_5 := __common__(  if(((real)c_femdiv_p < 0.35), N65_6, 0.0061486358));

N65_4 := __common__(  if(trim(C_FEMDIV_P) != '', N65_5, 0.028485826));

N65_3 := __common__(  if(((integer)iv_fp_prevaddrageoldest < 380), N65_4, 0.10031989));

N65_2 := __common__(  if(((real)iv_fp_prevaddrageoldest > NULL), N65_3, N65_7));

N65_1 := __common__(  map((iv_nap_phn_ver_x_inf_phn_ver in [' -1', '0-0', '0-3', '1-0', '1-3', '2-0', '2-1', '2-3', '3-0', '3-1', '3-3']) => -0.0089888609,
             (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-1'])                                                                => N65_2,
                                                                                                                                -0.0089888609));

N66_9 := __common__(  if(((real)c_hval_175k_p < 17.65), 0.0062066478, 0.10108629));

N66_8 := __common__(  if(trim(C_HVAL_175K_P) != '', N66_9, -0.050266534));

N66_7 := __common__(  map((iv_vp002_phn_disconnected =  0 ) => N66_8,
             (iv_vp002_phn_disconnected = 1 ) => 1,
                                                     N66_8));

N66_6 := __common__(  map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Government', 'No Mortgage', 'Non-Traditional', 'Piggyback', 'Unknown']) => N66_7,
             (iv_bst_addr_mortgage_type in ['Equity Loan', 'High-Risk', 'Other'])                                                                  => 0.21496853,
                                                                                                                                                      N66_7));

N66_5 := __common__( map(((real)iv_mos_src_drivers_lic_adl_lseen <= NULL) => N66_6,
													((real)iv_mos_src_drivers_lic_adl_lseen < 87.5)  => 0.0002380917,
																																							N66_6));

N66_4 := __common__( map(((real)iv_adls_per_pots_phone_c6 <= NULL) => 0.12090178,
													((real)iv_adls_per_pots_phone_c6 < 1.5)   => -0.012681882,
																																				0.12090178));

N66_3 := __common__(  if(((real)iv_vp090_phn_dst_to_inp_add < 228.5), N66_4, 0.048176316));

N66_2 := __common__(  if(((real)iv_vp090_phn_dst_to_inp_add > NULL), N66_3, N66_5));

N66_1 := __common__(  if(((real)iv_mos_src_drivers_lic_adl_lseen > NULL), N66_2, 0.0094391951));

N67_7 := __common__( map(((real)iv_fp_prevaddrmurderindex <= NULL) => 0.00084617602,
													((real)iv_fp_prevaddrmurderindex < 46.5)  => 0.13565387,
																																				0.00084617602));

N67_6 := __common__(  map((iv_prv_addr_mortgage_type in ['Commercial', 'Conventional', 'Government', 'High-Risk', 'Non-Traditional', 'Other', 'Unknown']) => -0.0036331609,
             (iv_prv_addr_mortgage_type in ['Equity Loan', 'No Mortgage', 'Piggyback'])                                                      => 0.020536827,
                                                                                                                                                -0.0036331609));

N67_5 := __common__(  map((iv_prof_license_category in ['-1', '1', '2', '4']) => N67_6,
             (iv_prof_license_category in ['0', '3', '5'])       => N67_7,
                                                                    N67_6));

N67_4 := __common__(  map((iv_input_dob_match_level in ['0', '1', '2', '6', '7']) => -0.018636503,
             (iv_input_dob_match_level in ['3', '4', '5', '8'])      => N67_5,
                                                                        -0.018636503));

N67_3 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), -0.02233842, 0.14195919));

N67_2 := __common__(  map((iv_liens_unrel_x_rel in ['0-2', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N67_3,
             (iv_liens_unrel_x_rel in ['0-0', '0-1', '1-0', '1-1'])                             => N67_4,
                                                                                                   N67_3));

N67_1 := __common__(  if(((real)iv_fp_srchfraudsrchcount > NULL), N67_2, 0.0022547554));

N68_9 := __common__(  if(((real)iv_inq_dob_ver_count < 2.5), 0.092420724, -0.031083276));

N68_8 := __common__(  if(((real)iv_inq_dob_ver_count > NULL), N68_9, -0.050347995));

N68_7 := __common__(  if(trim(C_BEL_EDU) != '', N68_8, -0.061200321));

N68_6 := __common__(  map((iv_prv_own_prop_x_addr_naprop in ['00', '01', '02', '03', '10', '11', '13', '14']) => N68_7,
             (iv_prv_own_prop_x_addr_naprop in ['04', '12'])                                     => 0.38465789,
                                                                                                    N68_7));

N68_5 := __common__(  map((iv_liens_unrel_x_rel_sc in ['0-0', '0-1', '0-2', '1-0', '1-1', '1-2', '2-0', '2-2', '3-0', '3-1', '3-2']) => N68_6,
             (iv_liens_unrel_x_rel_sc in ['2-1'])                                                                       => 1,
                                                                                                                           N68_6));

N68_4 := __common__(  map((iv_nas_summary in [  0 ,   1 ,   2 ,   3 ,   5 ,   6 ,   7 ,   8 ,   9 ,  10 ,  11 ,  12 ]) => N68_5,
             (iv_nas_summary in [  4 ])                                                                   => 0.3596582,
                                                                                                             N68_5));

N68_3 := __common__(  map((iv_liens_unrel_x_rel_ft in ['0-0', '0-1', '0-2', '1-0', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N68_4,
             (iv_liens_unrel_x_rel_ft in ['1-1'])                                                                       => 0.28439733,
                                                                                                                           N68_4));

N68_2 := __common__(  map((iv_fp_assocrisktype in ['1', '2', '4', '6', '7', '8', '9']) => -0.0074986111,
             (iv_fp_assocrisktype in ['3', '5'])                               => N68_3,
                                                                                    -0.0074986111));

N68_1 := __common__(  if(((real)iv_vp090_phn_dst_to_inp_add > NULL), N68_2, -0.0036077678));

N69_8 := __common__(  map((iv_liens_unrel_x_rel_ot in ['0-0', '0-1', '0-2', '1-0', '1-1', '2-0', '2-1', '2-2', '3-1', '3-2']) => 0.021309607,
             (iv_liens_unrel_x_rel_ot in ['1-2', '3-0'])                                                         => 0.20075178,
                                                                                                                    0.021309607));

N69_7 := __common__( map(((integer)iv_fp_curraddrmedianvalue <= NULL)     => 0.13538431,
													((integer)iv_fp_curraddrmedianvalue < 512515) => N69_8,
																																						0.13538431));

N69_6 := __common__(  map((iv_vp091_phnzip_mismatch = 0) => 0.0047342059,
             (iv_vp091_phnzip_mismatch = 1) => N69_7,
                                                    0.0047342059));

N69_5 := __common__(  if(((real)iv_inp_nhood_num_vacant < 10.5), -0.01340483, N69_6));

N69_4 := __common__(  if(((real)iv_inp_nhood_num_vacant > NULL), N69_5, -0.050562328));

N69_3 := __common__( map(((real)iv_fp_srchphonesrchcountmo <= NULL) => 0.14833787,
													((real)iv_fp_srchphonesrchcountmo < 5.5)   => N69_4,
																																				0.14833787));

N69_2 := __common__(  if(((real)iv_credit_seeking < 0.5), N69_3, -0.017889346));

N69_1 := __common__(  if(((real)iv_credit_seeking > NULL), N69_2, 0.010443504));

N70_7 := __common__(  map((iv_liens_unrel_x_rel_cj in ['0-0', '0-2', '1-0', '1-1', '1-2', '2-0', '2-1', '3-0', '3-1', '3-2']) => -0.036366741,
             (iv_liens_unrel_x_rel_cj in ['0-1', '2-2'])                                                         => 0.25363132,
                                                                                                                    -0.036366741));

N70_6 := __common__( map(((real)iv_fp_curraddrburglaryindex <= NULL) => 0.073590878,
													((real)iv_fp_curraddrburglaryindex < 170.5) => N70_7,
																																					0.073590878));

N70_5 := __common__(  map((iv_liens_unrel_x_rel in ['0-0', '0-1', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => N70_6,
             (iv_liens_unrel_x_rel in ['0-2'])                                                                       => 0.37988532,
                                                                                                                        N70_6));

N70_4 := __common__(  if(((integer)iv_pct_rel_prop_sold < 25), 0.0029621719, N70_5));

N70_3 := __common__(  if(((real)iv_pct_rel_prop_sold > NULL), N70_4, -0.0019199139));

N70_2 := __common__(  if(trim(C_RNT1000_P) != '', N70_3, -0.013370431));

N70_1 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['1-3', '2-1', '2-3', '3-0', '3-2'])                                           => -0.047084662,
             (iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '2-0', '2-2', '3-1', '3-3']) => N70_2,
                                                                                                                                N70_2));

N71_6 := __common__(  map(trim(C_HVAL_100K_P) = ''     => 0.050492733,
             ((real)c_hval_100k_p < 5.25) => 0.012915335,
                                             0.050492733));

N71_5 := __common__(  map(trim(C_CPIALL) = ''       => N71_6,
             ((real)c_cpiall < 222.95) => 0.0032610376,
                                          N71_6));

N71_4 := __common__(  if(((real)c_construction < 3.05), -0.0095113206, N71_5));

N71_3 := __common__(  if(trim(C_CONSTRUCTION) != '', N71_4, -0.0095906715));

N71_2 := __common__(  map((iv_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.034709571,
             (iv_criminal_x_felony in ['1-1'])                                                         => 0.7938537,
                                                                                                          -0.034709571));

N71_1 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['0-3', '1-1', '2-0', '2-1', '2-2', '2-3', '3-0', '3-2', '3-3']) => N71_2,
             (iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '1-0', '1-2', '1-3', '3-1'])               => N71_3,
                                                                                                                  N71_3));

N72_8 := __common__(  map((iv_inp_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'No Mortgage', 'Non-Traditional', 'Piggyback', 'Unknown']) => 0.098496731,
             (iv_inp_addr_mortgage_type in ['Government', 'High-Risk', 'Other'])                                                                    => 0.29605314,
                                                                                                                                                       0.098496731));

N72_7 := __common__(  map((iv_adl_util_infrastructure in ['1']) => -0.055939883,
             (iv_adl_util_infrastructure in ['0']) => N72_8,
                                                      N72_8));

N72_6 := __common__(  map((iv_liens_unrel_x_rel_ft in ['0-0', '0-2', '1-0', '1-1', '2-1', '2-2', '3-0', '3-1', '3-2']) => 0.008473577,
             (iv_liens_unrel_x_rel_ft in ['0-1', '1-2', '2-0'])                                           => 0.1049564,
                                                                                                             0.008473577));

N72_5 := __common__( map(((real)iv_fp_corrssnnamecount <= NULL) => N72_7,
													((real)iv_fp_corrssnnamecount < 8.5)   => N72_6,
																																		N72_7));

N72_4 := __common__(  if(((real)iv_pl002_addrs_15yr < 4.5), N72_5, -0.0031120714));

N72_3 := __common__(  if(((real)iv_pl002_addrs_15yr > NULL), N72_4, 0.014926434));

N72_2 := __common__(  if(((real)iv_inq_per_addr < 10.5), N72_3, -0.020877903));

N72_1 := __common__(  if(((real)iv_inq_per_addr > NULL), N72_2, -0.050465266));

N73_7 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-1', '0-2', '0-3', '1-0', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-1', '3-2']) => -0.048992786,
             (iv_paw_dead_bus_x_active_phn in ['3-3'])                                                                                                   => 0.14690958,
                                                                                                                                                            -0.048992786));

N73_6 := __common__(  map((iv_paw_dead_bus_x_active_phn in ['0-0', '0-2', '0-3', '1-1', '1-2', '1-3', '2-0', '2-1', '2-2', '2-3', '3-0', '3-2', '3-3']) => 0.098605926,
             (iv_paw_dead_bus_x_active_phn in ['0-1', '1-0', '3-1'])                                                                       => 0.38117387,
                                                                                                                                              0.098605926));

N73_5 := __common__(  map((integer)iv_inp_nhood_num_sfd <= NULL  				=> -0.0096923479,
														(integer)iv_inp_nhood_num_sfd < 593  				=> 	N73_6,   
																																						-0.0096923479));


N73_4 := __common__(   map((real)iv_fp_srchaddrsrchcount <= NULL  =>  0.0069495957,
														(real)iv_fp_srchaddrsrchcount < 1.5   =>  N73_5,   
																																			0.0069495957));


N73_3 := __common__(  map((trim(iv_add1_util_infrastructure, all) in ['0']) => -0.0025188057,
             (trim(iv_add1_util_infrastructure, all) in ['1']) => N73_4,
																																	N73_4));

N73_2 := __common__(  map((real)iv_avg_lres <= NULL    => N73_7,
														(real)iv_avg_lres < 287.5  => N73_3,      
																					  N73_7));	


N73_1 := __common__(  if(((real)iv_bst_addr_mtg_avm_pct_diff > NULL), N73_2, -0.0047942247));

N74_8 := __common__(  map((iv_prv_addr_mortgage_term in [' 0', ' 5', '-1', '10 ', '15', '20', '30', '40']) => -0.0015757009,
             (iv_prv_addr_mortgage_term in ['25'])                                           => 0.22192939,
                                                                                                -0.0015757009));

N74_7 := __common__(  map((iv_fp_addrchangeecontrajindex in ['1', '2', '3', '4', '6', '-1']) => N74_8,
             (iv_fp_addrchangeecontrajindex in ['5'])                               => 0.23651569,
                                                                                        N74_8));

N74_6 := __common__(  map(trim(C_BURGLARY) = ''      => N74_7,
             ((integer)c_burglary < 39) => 0.063267923,
                                           N74_7));

N74_5 := __common__(  if(((real)c_hval_250k_p < 29.85), N74_6, 0.10423726));

N74_4 := __common__(  if(trim(C_HVAL_250K_P) != '', N74_5, -0.050327674));

N74_3 := __common__(  map((iv_pb_order_freq in ['0 No Purch Data', '1 Cant Calculate', '3 Monthly', '4 Semi-monthly', '5 Quarterly', '6 Semi-yearly', '7 Yearly', '8 Rarely']) => N74_4,
             (iv_pb_order_freq in ['2 Weekly'])                                                                                                                   => 0.25032139,
                                                                                                                                                                     N74_4));

N74_2 := __common__(  if(((real)iv_ag001_age < 19.5), N74_3, -0.0048003945));

N74_1 := __common__(  if(((real)iv_ag001_age > NULL), N74_2, -0.035437285));

N75_8 := __common__(  map((iv_in001_college_income in ['-1', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'I', 'J', 'K']) => 0.00056296822,
             (iv_in001_college_income in ['H'])                                                    => 0.13113821,
                                                                                                      0.00056296822));

N75_7 := __common__(  map(trim(C_HVAL_40K_P) = ''      => 0.10945789,
             ((real)c_hval_40k_p < 20.25) => -0.02160384,
                                             0.10945789));

N75_6 := __common__(  map((iv_bst_addr_mortgage_type in ['Commercial', 'Conventional', 'Equity Loan', 'Government', 'No Mortgage', 'Other', 'Unknown']) => 0.011336171,
             (iv_bst_addr_mortgage_type in ['High-Risk', 'Non-Traditional', 'Piggyback'])                                                  => 0.14015154,
                                                                                                                                              0.011336171));

N75_5 := __common__(  map(trim(C_LOWRENT) = ''     => -0.0077599542,
             ((real)c_lowrent < 4.15) => N75_6,
                                         -0.0077599542));

N75_4 := __common__(  if(((real)iv_mos_src_bureau_lname_fseen < 341.5), N75_5, N75_7));

N75_3 := __common__(  if(((real)iv_mos_src_bureau_lname_fseen > NULL), N75_4, -0.0017381027));

N75_2 := __common__(  if(((real)c_pop_18_24_p < 1.85), -0.045837528, N75_3));

N75_1 := __common__(  if(trim(C_POP_18_24_P) != '', N75_2, N75_8));

N76_9 := __common__(  map((iv_prv_own_prop_x_addr_naprop in ['00', '01', '02', '10', '12', '14']) => 0.019145944,
             (iv_prv_own_prop_x_addr_naprop in ['03', '04', '11', '13'])             => 0.13890832,
                                                                                        0.019145944));

N76_8 := __common__(  map((iv_va100_add_problem in ['00 No Address Problems', '01 Not Curbside Delivery', '02 Address Standardized', '03 Standarization Error', '05 Drop Delivery', '06 Invalid Address', '07 Busines', '08 Military Zip', '09 Corporate Zip Code', '10 Zip/City Mismatch', '11 Throw Back', '12 College', '13 Vacant']) => N76_9,
             (iv_va100_add_problem in ['04 HiRisk Commercial', '14 Zip/State Mismatch'])                                                                                                                                                                                                                                    => 0.28440931,
                                                                                                                                                                                                                                                                                                                               N76_9));

N76_7 := __common__(  if(((integer)iv_mos_since_lname_change < 81), N76_8, 0.20659662));

N76_6 := __common__(  if(((real)iv_mos_since_lname_change > NULL), N76_7, -0.050413175));

N76_5 := __common__(  if(((real)c_incollege < 8.55), 0.015454404, N76_6));

N76_4 := __common__(  if(trim(C_INCOLLEGE) != '', N76_5, 0.097712599));

N76_3 := __common__(  map((iv_fp_assocrisktype in ['1', '5', '7', '9'])       => 0.0024706912,
             (iv_fp_assocrisktype in ['2', '3', '4', '6', '8']) => N76_4,
                                                                        N76_4));

N76_2 := __common__(  if(((real)iv_inq_num_diff_names_per_adl < 0.5), N76_3, -0.0056732306));

N76_1 := __common__(  if(((real)iv_inq_num_diff_names_per_adl > NULL), N76_2, -0.0013174262));

N77_9 := __common__(  map(trim(C_HIGH_HVAL) = ''    => 0.083368977,
             ((real)c_high_hval < 3.7) => -0.039927576,
                                          0.083368977));

N77_8 := __common__(  map((iv_fp_varrisktype in ['1', '2', '3', '5', '6', '7', '8', '-1']) => N77_9,
             (iv_fp_varrisktype in ['4', '9'])                                     => 0.26403123,
                                                                                        N77_9));

N77_7 := __common__(  if(trim(C_POP_45_54_P) != '', N77_8, 0.047296579));

N77_6 := __common__( map(((real)iv_mos_src_emerge_adl_fseen <= NULL) => 0.15498185,
													((real)iv_mos_src_emerge_adl_fseen < 12.5)  => 0.0078237479,
																																					0.15498185));

N77_5 := __common__(  if(((integer)iv_va060_dist_add_in_bst < 1755), N77_6, N77_7));

N77_4 := __common__(  if(((real)iv_va060_dist_add_in_bst > NULL), N77_5, -0.065239613));

N77_3 := __common__(  map((iv_num_purch_x_num_sold_60 in ['0-0', '1-0', '1-1', '1-2', '2-0', '2-1', '2-2']) => N77_4,
             (iv_num_purch_x_num_sold_60 in ['0-1', '0-2'])                                    => 0.21646023,
                                                                                                  N77_4));

N77_2 := __common__(  if(((real)iv_src_bureau_adl_count < 15.5), N77_3, -0.0031342466));

N77_1 := __common__(  if(((real)iv_src_bureau_adl_count > NULL), N77_2, 0.0071850868));

N78_8 := __common__(  map((iv_va100_add_problem in ['00 No Address Problems', '02 Address Standardized', '03 Standarization Error', '04 HiRisk Commercial', '05 Drop Delivery', '06 Invalid Address', '08 Military Zip', '09 Corporate Zip Code', '11 Throw Back', '12 College', '14 Zip/State Mismatch']) => 0.085292188,
             (iv_va100_add_problem in ['01 Not Curbside Delivery', '07 Busines', '10 Zip/City Mismatch', '13 Vacant'])                                                                                                                                                                        => 0.32362678,
                                                                                                                                                                                                                                                                                                 0.085292188));

N78_7 := __common__(  map((iv_infutor_nap in [0,   1 ,   4 ,   7 ,   9 ,  10 ,  11 ,  12 ]) => -0.0065584892,
             (iv_infutor_nap in [  6 ])                                           => 0.37331924,
                                                                                     -0.0065584892));

N78_6 := __common__( map(((real)iv_average_rel_age <= NULL) => N78_8,
												((real)iv_average_rel_age < 39.5)  => N78_7,
																															N78_8));

N78_5 := __common__(  map(trim(C_FAMMAR18_P) = ''    => 0.0084308163,
             ((real)c_fammar18_p < 4.9) => 0.10206817,
                                           0.0084308163));

N78_4 := __common__(  map(trim(C_HVAL_300K_P) = ''      => N78_6,
             ((real)c_hval_300k_p < 16.05) => N78_5,
                                              N78_6));

N78_3 := __common__(  if(((real)c_construction < 20.45), -0.0020447313, N78_4));

N78_2 := __common__(  if(trim(C_CONSTRUCTION) != '', N78_3, 0.00016092213));

N78_1 := __common__(  if(((real)iv_oldest_rel_age > NULL), N78_2, 0.00098655423));


tnscore := __common__(  sum(N0_1, N1_1, N2_1, N3_1, N4_1, N5_1, N6_1, N7_1, N8_1, N9_1, N10_1, N11_1, N12_1, N13_1, N14_1, N15_1, N16_1, N17_1, N18_1, N19_1, N20_1, N21_1, N22_1, N23_1, N24_1, N25_1, N26_1, N27_1, N28_1, N29_1, N30_1, N31_1, N32_1, N33_1, N34_1, N35_1, N36_1, N37_1, N38_1, N39_1, N40_1, N41_1, N42_1, N43_1, N44_1, N45_1, N46_1, N47_1, N48_1, N49_1, N50_1, N51_1, N52_1, N53_1, N54_1, N55_1, N56_1, N57_1, N58_1, N59_1, N60_1, N61_1, N62_1, N63_1, N64_1, N65_1, N66_1, N67_1, N68_1, N69_1, N70_1, N71_1, N72_1, N73_1, N74_1, N75_1, N76_1, N77_1, N78_1));

expsum_2 := __common__(  0.0);

class_threshold := __common__(  0.5);

score0 := __common__(  exp(-tnscore));

expsum_1 := __common__(  expsum_2 + score0);

score1 := __common__(  exp(tnscore));

expsum := __common__(  expsum_1 + score1);

prob0 := __common__(  score0 / expsum);

prob1 := __common__(  score1 / expsum);

base := __common__(  600);

point := __common__(  -50);

odds := __common__(  .0260 / (1 - .0260));

fp1303_2_0 := __common__(  min(if(max(round(point * (ln(prob1 / (1 - prob1)) - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(point * (ln(prob1 / (1 - prob1)) - ln(odds)) / ln(2) + base), 300)), 999));

pred_1 := __common__(  0);

pred := __common__(  if(prob1 > class_threshold, 1, pred_1));

//Intermediate variables

#if(FP_DEBUG)
            
            self.clam															:= le;
						self.sysdate                          := sysdate;
						self.ssnpop                           := ssnpop;
						self.ver_src_ds                       := ver_src_ds;
						self.ver_src_eq                       := ver_src_eq;
						self.ver_src_en                       := ver_src_en;
						self.ver_src_tn                       := ver_src_tn;
						self.ver_src_tu                       := ver_src_tu;
						self.ver_src_cnt                      := ver_src_cnt;
						self.credit_source_cnt                := credit_source_cnt;
						self.bureauonly2                      := bureauonly2;
						self._derog                           := _derog;
						self.iv_vp090_phn_dst_to_inp_add      := iv_vp090_phn_dst_to_inp_add;
						self.iv_vp091_phnzip_mismatch         := iv_vp091_phnzip_mismatch;
						self.iv_vp010_phn_nongeo              := iv_vp010_phn_nongeo;
						self.iv_vp001_phn_not_issued          := iv_vp001_phn_not_issued;
						self.iv_vp002_phn_disconnected        := iv_vp002_phn_disconnected;
						self.iv_vp003_phn_invalid             := iv_vp003_phn_invalid;
						self.iv_vp004_phn_hirisk              := iv_vp004_phn_hirisk;
						self.iv_vp005_phn_cell                := iv_vp005_phn_cell;
						self.iv_vp006_phn_pager               := iv_vp006_phn_pager;
						self.iv_vp007_phn_pcs                 := iv_vp007_phn_pcs;
						self.iv_vp008_phn_pay_phone           := iv_vp008_phn_pay_phone;
						self.iv_vp100_phn_prob                := iv_vp100_phn_prob;
						self.iv_va060_dist_add_in_bst         := iv_va060_dist_add_in_bst;
						self.iv_va002_add_invalid             := iv_va002_add_invalid;
						self.iv_va003_add_hirisk_comm         := iv_va003_add_hirisk_comm;
						self.iv_va004_add_military_zip        := iv_va004_add_military_zip;
						self.iv_va005_add_corp_zip            := iv_va005_add_corp_zip;
						self.iv_va006_add_zip_prob            := iv_va006_add_zip_prob;
						self.iv_va007_add_vacant              := iv_va007_add_vacant;
						self.iv_va008_add_throwback           := iv_va008_add_throwback;
						self.iv_va009_add_college             := iv_va009_add_college;
						self.iv_va010_add_drop_delivery       := iv_va010_add_drop_delivery;
						self.iv_va011_add_business            := iv_va011_add_business;
						self.iv_va012_add_curbside_del        := iv_va012_add_curbside_del;
						self.add_ec1                          := add_ec1;
						self.add_ec3                          := add_ec3;
						self.add_ec4                          := add_ec4;
						self.iv_va020_add_standardized        := iv_va020_add_standardized;
						self.iv_va100_add_problem             := iv_va100_add_problem;
						self._felony_last_date                := _felony_last_date;
						self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
						self.src_liens_adl_lseen              := src_liens_adl_lseen;
						self._src_liens_adl_lseen             := _src_liens_adl_lseen;
						self.iv_dl001_lien_last_seen          := iv_dl001_lien_last_seen;
						self.src_bureau_adl_fseen             := src_bureau_adl_fseen;
						self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
						self.iv_sr001_m_bureau_adl_fs         := iv_sr001_m_bureau_adl_fs;
						self.src_bureau_vo_fseen              := src_bureau_vo_fseen;
						self._src_bureau_vo_fseen             := _src_bureau_vo_fseen;
						self.mth_ver_src_fdate_vo             := mth_ver_src_fdate_vo;
						self.src_bureau_vo_lseen              := src_bureau_vo_lseen;
						self._src_bureau_vo_lseen             := _src_bureau_vo_lseen;
						self.mth_ver_src_ldate_vo             := mth_ver_src_ldate_vo;
						self.mth_ver_src_fdate_vo60           := mth_ver_src_fdate_vo60;
						self.mth_ver_src_ldate_vo0            := mth_ver_src_ldate_vo0;
						self.src_bureau_w_lseen               := src_bureau_w_lseen;
						self._src_bureau_w_lseen              := _src_bureau_w_lseen;
						self.mth_ver_src_ldate_w              := mth_ver_src_ldate_w;
						self.mth_ver_src_ldate_w0             := mth_ver_src_ldate_w0;
						self.src_bureau_wp_lseen              := src_bureau_wp_lseen;
						self._src_bureau_wp_lseen             := _src_bureau_wp_lseen;
						self.mth_ver_src_ldate_wp             := mth_ver_src_ldate_wp;
						self.mth_ver_src_ldate_wp0            := mth_ver_src_ldate_wp0;
						self._paw_first_seen                  := _paw_first_seen;
						self.mth_paw_first_seen               := mth_paw_first_seen;
						self.mth_paw_first_seen2              := mth_paw_first_seen2;
						self.ver_src_am                       := ver_src_am;
						self.ver_src_e1                       := ver_src_e1;
						self.ver_src_e2                       := ver_src_e2;
						self.ver_src_e3                       := ver_src_e3;
						self.ver_src_pl                       := ver_src_pl;
						self.ver_src_w                        := ver_src_w;
						self.paw_dead_business_count_gt3      := paw_dead_business_count_gt3;
						self.paw_active_phone_count_0         := paw_active_phone_count_0;
						self._infutor_first_seen              := _infutor_first_seen;
						self.mth_infutor_first_seen           := mth_infutor_first_seen;
						self._infutor_last_seen               := _infutor_last_seen;
						self.mth_infutor_last_seen            := mth_infutor_last_seen;
						self.infutor_i                        := infutor_i;
						self.infutor_im                       := infutor_im;
						self.src_white_pages_adl_fseen        := src_white_pages_adl_fseen;
						self._src_white_pages_adl_fseen       := _src_white_pages_adl_fseen;
						self.iv_sr001_m_wp_adl_fs             := iv_sr001_m_wp_adl_fs;
						self.src_m_wp_adl_fs                  := src_m_wp_adl_fs;
						self._header_first_seen               := _header_first_seen;
						self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;
						self.src_m_hdr_fs                     := src_m_hdr_fs;
						// added variable
						self.source_mod6_1                    := source_mod6_1;
						self.source_mod6                      := source_mod6;
						self.iv_sr001_source_profile          := iv_sr001_source_profile;
						self._in_dob                          := _in_dob;
						self.in_dob                          	:= in_dob;
						self.yr_in_dob                        := yr_in_dob;
						self.yr_in_dob_int                    := yr_in_dob_int;
						self.age_estimate                     := age_estimate;
						self.iv_ag001_age                     := iv_ag001_age;
						self.iv_pl001_bst_addr_lres           := iv_pl001_bst_addr_lres;
						self.iv_pl001_addr_stability_v2       := iv_pl001_addr_stability_v2;
						self.iv_pl002_avg_mo_per_addr         := iv_pl002_avg_mo_per_addr;
						self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;
						self.src_vehicles_adl_fseen           := src_vehicles_adl_fseen;
						self._src_vehicles_adl_fseen          := _src_vehicles_adl_fseen;
						self.iv_po001_m_snc_veh_adl_fs        := iv_po001_m_snc_veh_adl_fs;
						self.iv_in001_wealth_index            := iv_in001_wealth_index;
						self.iv_in001_college_income          := iv_in001_college_income;
						self.bst_addr_avm_auto_val_2          := bst_addr_avm_auto_val_2;
						self.iv_pv001_bst_avm_chg_1yr         := iv_pv001_bst_avm_chg_1yr;
						self.iv_pv001_bst_avm_chg_1yr_pct     := iv_pv001_bst_avm_chg_1yr_pct;
						self.iv_pots_phone                    := iv_pots_phone;
						self.iv_add_apt                       := iv_add_apt;
						self.iv_nas_summary                   := iv_nas_summary;
						self.iv_dl_val_flag                   := iv_dl_val_flag;
						self.iv_src_bureau_adl_count          := iv_src_bureau_adl_count;
						self.src_bureau_lname_fseen           := src_bureau_lname_fseen;
						self._src_bureau_lname_fseen          := _src_bureau_lname_fseen;
						self.iv_mos_src_bureau_lname_fseen    := iv_mos_src_bureau_lname_fseen;
						self.src_bureau_dob_fseen             := src_bureau_dob_fseen;
						self._src_bureau_dob_fseen            := _src_bureau_dob_fseen;
						self.iv_mos_src_bureau_dob_fseen      := iv_mos_src_bureau_dob_fseen;
						self.iv_src_experian_adl_count        := iv_src_experian_adl_count;
						self.src_experian_adl_fseen           := src_experian_adl_fseen;
						self._src_experian_adl_fseen          := _src_experian_adl_fseen;
						self.iv_mos_src_experian_adl_fseen    := iv_mos_src_experian_adl_fseen;
						self.iv_src_equifax_adl_count         := iv_src_equifax_adl_count;
						self.src_equifax_adl_lseen            := src_equifax_adl_lseen;
						self._src_equifax_adl_lseen           := _src_equifax_adl_lseen;
						self.iv_mos_src_equifax_adl_lseen     := iv_mos_src_equifax_adl_lseen;
						self.src_property_adl_lseen           := src_property_adl_lseen;
						self._src_property_adl_lseen          := _src_property_adl_lseen;
						self.iv_mos_src_property_adl_lseen    := iv_mos_src_property_adl_lseen;
						self.iv_src_drivers_lic_adl_count     := iv_src_drivers_lic_adl_count;
						self.src_drivers_lic_adl_fseen        := src_drivers_lic_adl_fseen;
						self._src_drivers_lic_adl_fseen       := _src_drivers_lic_adl_fseen;
						self.iv_mos_src_drivers_lic_adl_fseen := iv_mos_src_drivers_lic_adl_fseen;
						self.src_drivers_lic_adl_lseen        := src_drivers_lic_adl_lseen;
						self._src_drivers_lic_adl_lseen       := _src_drivers_lic_adl_lseen;
						self.iv_mos_src_drivers_lic_adl_lseen := iv_mos_src_drivers_lic_adl_lseen;
						self.src_emerge_adl_fseen             := src_emerge_adl_fseen;
						self._src_emerge_adl_fseen            := _src_emerge_adl_fseen;
						self.iv_mos_src_emerge_adl_fseen      := iv_mos_src_emerge_adl_fseen;
						self.iv_lname_score                   := iv_lname_score;
						self._lname_change_date               := _lname_change_date;
						self.iv_mos_since_lname_change        := iv_mos_since_lname_change;
						self.iv_input_dob_match_level         := iv_input_dob_match_level;
						self.iv_phn_miskey                    := iv_phn_miskey;
						self.iv_addr_miskey                   := iv_addr_miskey;
						self.iv_adl_util_convenience          := iv_adl_util_convenience;
						self.iv_adl_util_infrastructure       := iv_adl_util_infrastructure;
						self.iv_add1_util_infrastructure      := iv_add1_util_infrastructure;
						self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;
						self.iv_inp_addr_mortgage_amount      := iv_inp_addr_mortgage_amount;
						self.iv_inp_addr_mortgage_term        := iv_inp_addr_mortgage_term;
						self.iv_inp_addr_mortgage_type        := iv_inp_addr_mortgage_type;
						self.iv_inp_addr_financing_type       := iv_inp_addr_financing_type;
						self.iv_inp_addr_assessed_total_val   := iv_inp_addr_assessed_total_val;
						self.inp_addr_fips_fall               := inp_addr_fips_fall;
						self.inp_addr_avm_auto_val            := inp_addr_avm_auto_val;
						self.iv_inp_addr_fips_ratio           := iv_inp_addr_fips_ratio;
						self.iv_inp_addr_building_area        := iv_inp_addr_building_area;
						self.iv_inp_nhood_num_vacant          := iv_inp_nhood_num_vacant;
						self.iv_inp_nhood_num_sfd             := iv_inp_nhood_num_sfd;
						self.iv_inp_addr_avm_pct_change_2yr   := iv_inp_addr_avm_pct_change_2yr;
						self.iv_inp_addr_avm_change_2yr       := iv_inp_addr_avm_change_2yr;
						self.iv_inp_addr_avm_change_3yr       := iv_inp_addr_avm_change_3yr;
						self.iv_inp_addr_avm_pct_change_3yr   := iv_inp_addr_avm_pct_change_3yr;
						self.iv_bst_own_prop_x_addr_naprop    := iv_bst_own_prop_x_addr_naprop;
						self.bst_addr_avm_auto_val            := bst_addr_avm_auto_val;
						self.bst_addr_mortgage_amount         := bst_addr_mortgage_amount;
						self.iv_bst_addr_mtg_avm_pct_diff     := iv_bst_addr_mtg_avm_pct_diff;
						self._add1_mortgage_due_date          := _add1_mortgage_due_date;
						self._add1_mortgage_date              := _add1_mortgage_date;
						self.iv_bst_addr_mortgage_term        := iv_bst_addr_mortgage_term;
						self.iv_bst_addr_mortgage_type        := iv_bst_addr_mortgage_type;
						self.iv_bst_addr_financing_type       := iv_bst_addr_financing_type;
						self.bst_addr_avm_auto_val_3          := bst_addr_avm_auto_val_3;
						self.iv_bst_addr_avm_pct_change_2yr   := iv_bst_addr_avm_pct_change_2yr;
						self.bst_addr_avm_auto_val_4          := bst_addr_avm_auto_val_4;
						self.bst_addr_avm_auto_val_1          := bst_addr_avm_auto_val_1;
						self.iv_bst_addr_avm_pct_change_3yr   := iv_bst_addr_avm_pct_change_3yr;
						self.iv_prv_addr_source_count         := iv_prv_addr_source_count;
						self.iv_prv_own_prop_x_addr_naprop    := iv_prv_own_prop_x_addr_naprop;
						self._add2_mortgage_due_date          := _add2_mortgage_due_date;
						self.mortgage_date_diff               := mortgage_date_diff;
						self._add3_mortgage_date              := _add3_mortgage_date;
						self._add3_mortgage_due_date          := _add3_mortgage_due_date;
						self._add2_mortgage_date              := _add2_mortgage_date;
						self.iv_prv_addr_mortgage_term        := iv_prv_addr_mortgage_term;
						self.mortgage_type                    := mortgage_type;
						self.mortgage_present                 := mortgage_present;
						self.iv_prv_addr_mortgage_type        := iv_prv_addr_mortgage_type;
						self.iv_prv_addr_financing_type       := iv_prv_addr_financing_type;
						self.iv_prop_sold_assessed_total      := iv_prop_sold_assessed_total;
						self.iv_prop_sold_assessed_count      := iv_prop_sold_assessed_count;
						self.iv_purch_sold_val_diff           := iv_purch_sold_val_diff;
						self._prop1_sale_date                 := _prop1_sale_date;
						self.iv_mos_since_prop1_sale          := iv_mos_since_prop1_sale;
						self.iv_prop1_purch_sale_diff         := iv_prop1_purch_sale_diff;
						self.iv_dist_inp_addr_to_prv_addr     := iv_dist_inp_addr_to_prv_addr;
						self.iv_avg_lres                      := iv_avg_lres;
						self.iv_addr_lres_12mo_count          := iv_addr_lres_12mo_count;
						self.iv_phones_per_apt_addr           := iv_phones_per_apt_addr;
						self.iv_phones_per_addr_c6            := iv_phones_per_addr_c6;
						self.iv_adls_per_pots_phone_c6        := iv_adls_per_pots_phone_c6;
						self.iv_credit_seeking                := iv_credit_seeking;
						self.iv_inq_addr_ver_count            := iv_inq_addr_ver_count;
						self.iv_inq_lname_ver_count           := iv_inq_lname_ver_count;
						self.iv_inq_ssn_ver_count             := iv_inq_ssn_ver_count;
						self.iv_inq_dob_ver_count             := iv_inq_dob_ver_count;
						self.iv_inq_phone_ver_count           := iv_inq_phone_ver_count;
						self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
						self.iv_inq_num_diff_names_per_adl    := iv_inq_num_diff_names_per_adl;
						self.iv_inq_adls_per_ssn              := iv_inq_adls_per_ssn;
						self.iv_inq_per_addr                  := iv_inq_per_addr;
						self.iv_paw_dead_bus_x_active_phn     := iv_paw_dead_bus_x_active_phn;
						self.iv_infutor_nap                   := iv_infutor_nap;
						self.ver_phn_inf                      := ver_phn_inf;
						self.ver_phn_nap                      := ver_phn_nap;
						self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
						self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
						self.iv_num_purch_x_num_sold_60       := iv_num_purch_x_num_sold_60;
						self.iv_rec_vehx_level                := iv_rec_vehx_level;
						self.iv_derog_ratio                   := iv_derog_ratio;
						self.iv_liens_unrel_x_rel             := iv_liens_unrel_x_rel;
						self.iv_liens_unrel_x_rel_cj          := iv_liens_unrel_x_rel_cj;
						self.iv_liens_unrel_x_rel_ft          := iv_liens_unrel_x_rel_ft;
						self.iv_liens_unrel_x_rel_fc          := iv_liens_unrel_x_rel_fc;
						self.iv_liens_unrel_x_rel_o           := iv_liens_unrel_x_rel_o;
						self.iv_liens_unrel_x_rel_ot          := iv_liens_unrel_x_rel_ot;
						self.iv_liens_unrel_x_rel_sc          := iv_liens_unrel_x_rel_sc;
						self.iv_criminal_x_felony             := iv_criminal_x_felony;
						self.iv_average_rel_income            := iv_average_rel_income;
						self.iv_average_rel_age               := iv_average_rel_age;
						self.iv_oldest_rel_age                := iv_oldest_rel_age;
						self.iv_average_rel_distance          := iv_average_rel_distance;
						self.iv_closest_rel_distance          := iv_closest_rel_distance;
						self.iv_pct_rel_prop_owned            := iv_pct_rel_prop_owned;
						self.iv_pct_rel_prop_sold             := iv_pct_rel_prop_sold;
						self.iv_accident_count                := iv_accident_count;
						self.iv_accident_recency              := iv_accident_recency;
						self.ams_major_medical                := ams_major_medical;
						self.ams_major_science                := ams_major_science;
						self.ams_major_liberal                := ams_major_liberal;
						self.ams_major_business               := ams_major_business;
						self.ams_major_unknown                := ams_major_unknown;
						self.iv_ams_college_major             := iv_ams_college_major;
						self.iv_ams_college_tier              := iv_ams_college_tier;
						self.iv_prof_license_category         := iv_prof_license_category;
						self.iv_pb_order_freq                 := iv_pb_order_freq;
						self.iv_pb_average_dollars            := iv_pb_average_dollars;
						self.iv_fp_idrisktype                 := iv_fp_idrisktype;
						self.iv_fp_idverrisktype              := iv_fp_idverrisktype;
						self.iv_fp_sourcerisktype             := iv_fp_sourcerisktype;
						self.iv_fp_varrisktype                := iv_fp_varrisktype;
						self.iv_fp_srchvelocityrisktype       := iv_fp_srchvelocityrisktype;
						self.iv_fp_srchfraudsrchcount         := iv_fp_srchfraudsrchcount;
						self.iv_fp_assocrisktype              := iv_fp_assocrisktype;
						self.iv_fp_validationrisktype         := iv_fp_validationrisktype;
						self.iv_fp_corrrisktype               := iv_fp_corrrisktype;
						self.iv_fp_corrssnnamecount           := iv_fp_corrssnnamecount;
						self.iv_fp_corraddrnamecount          := iv_fp_corraddrnamecount;
						self.iv_fp_divrisktype                := iv_fp_divrisktype;
						self.iv_fp_srchcomponentrisktype      := iv_fp_srchcomponentrisktype;
						self.iv_fp_srchssnsrchcount           := iv_fp_srchssnsrchcount;
						self.iv_fp_srchaddrsrchcount          := iv_fp_srchaddrsrchcount;
						self.iv_fp_srchaddrsrchcountmo        := iv_fp_srchaddrsrchcountmo;
						self.iv_fp_srchaddrsrchcountwk        := iv_fp_srchaddrsrchcountwk;
						self.iv_fp_srchphonesrchcountmo       := iv_fp_srchphonesrchcountmo;
						self.iv_fp_componentcharrisktype      := iv_fp_componentcharrisktype;
						self.iv_fp_addrchangeincomediff       := iv_fp_addrchangeincomediff;
						self.iv_fp_addrchangecrimediff        := iv_fp_addrchangecrimediff;
						self.iv_fp_addrchangeecontrajindex    := iv_fp_addrchangeecontrajindex;
						self.iv_fp_curraddrmedianvalue        := iv_fp_curraddrmedianvalue;
						self.iv_fp_curraddrburglaryindex      := iv_fp_curraddrburglaryindex;
						self.iv_fp_prevaddrageoldest          := iv_fp_prevaddrageoldest;
						self.iv_fp_prevaddrdwelltype          := iv_fp_prevaddrdwelltype;
						self.iv_fp_prevaddrmedianvalue        := iv_fp_prevaddrmedianvalue;
						self.iv_fp_prevaddrmurderindex        := iv_fp_prevaddrmurderindex;
						self.fp_segment                       := fp_segment;
						self.iv_phnpop_x_nap_summary          := iv_phnpop_x_nap_summary;
						self.iv_fname_eda_sourced_type        := iv_fname_eda_sourced_type;
						self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
						self.iv_df001_mos_since_fel_ls        := iv_df001_mos_since_fel_ls;
						//Treenet score calculation variables
						self.class_threshold                  := class_threshold;
						self.score0                           := score0;
						self.score1                           := score1;
						self.expsum                           := expsum;
						self.prob0                            := prob0;
						self.prob1                            := prob1;
						self.base                             := base;
						self.point                            := point;
						self.odds                             := odds;
						self.fp1303_2_0                       := fp1303_2_0;
						self.pred                             := pred;
						
						//treenet final variables
						self.N0_1                             := N0_1;
						self.N1_1                             := N1_1;
						self.N2_1                             := N2_1;
						self.N3_1                             := N3_1;
						self.N4_1                             := N4_1;
						self.N5_1                             := N5_1;
						self.N6_1                             := N6_1;
						self.N7_1                             := N7_1;
						self.N8_1                             := N8_1;
						self.N9_1                             := N9_1;
						self.N10_1                            := N10_1;
						self.N11_1                            := N11_1;
						self.N12_1                            := N12_1;
						self.N13_1                            := N13_1;
						self.N14_1                            := N14_1;
						self.N15_1                            := N15_1;
						self.N16_1                            := N16_1;
						self.N17_1                            := N17_1;
						self.N18_1                            := N18_1;
						self.N19_1                            := N19_1;
						self.N20_1                            := N20_1;
						self.N21_1                            := N21_1;
						self.N22_1                            := N22_1;
						self.N23_1                            := N23_1;
						self.N24_1                            := N24_1;
						self.N25_1                            := N25_1;
						self.N26_1                            := N26_1;
						self.N27_1                            := N27_1;
						self.N28_1                            := N28_1;
						self.N29_1                            := N29_1;
						self.N30_1                            := N30_1;
						self.N31_1                            := N31_1;
						self.N32_1                            := N32_1;
						self.N33_1                            := N33_1;
						self.N34_1                            := N34_1;
						self.N35_1                            := N35_1;
						self.N36_1                            := N36_1;
						self.N37_1                            := N37_1;
						self.N38_1                            := N38_1;
						self.N39_1                            := N39_1;
						self.N40_1                            := N40_1;
						self.N41_1                            := N41_1;
						self.N42_1                            := N42_1;
						self.N43_1                            := N43_1;
						self.N44_1                            := N44_1;
						self.N45_1                            := N45_1;
						self.N46_1                            := N46_1;
						self.N47_1                            := N47_1;
						self.N48_1                            := N48_1;
						self.N49_1                            := N49_1;
						self.N50_1                            := N50_1;
						self.N51_1                            := N51_1;
						self.N52_1                            := N52_1;
						self.N53_1                            := N53_1;
						self.N54_1                            := N54_1;
						self.N55_1                            := N55_1;
						self.N56_1                            := N56_1;
						self.N57_1                            := N57_1;
						self.N58_1                            := N58_1;
						self.N59_1                            := N59_1;
						self.N60_1                            := N60_1;
						self.N61_1                            := N61_1;
						self.N62_1                            := N62_1;
						self.N63_1                            := N63_1;
						self.N64_1                            := N64_1;
						self.N65_1                            := N65_1;
						self.N66_1                            := N66_1;
						self.N67_1                            := N67_1;
						self.N68_1                            := N68_1;
						self.N69_1                            := N69_1;
						self.N70_1                            := N70_1;
						self.N71_1                            := N71_1;
						self.N72_1                            := N72_1;
						self.N73_1                            := N73_1;
						self.N74_1                            := N74_1;
						self.N75_1                            := N75_1;
						self.N76_1                            := N76_1;
						self.N77_1                            := N77_1;
						self.N78_1                            := N78_1;



#end
		self.seq := le.seq;
		ritmp :=    __common__(Models.fraudpoint_reasons(le, blank_ip, num_reasons, criminal ));
		reasons :=  __common__(Models.Common.checkFraudPointRC34(FP1303_2_0, ritmp, num_reasons));
		self.ri := reasons;
		self.score			:= (string)FP1303_2_0;	
		self := [];
END;

model :=   join(clam, Easi.Key_Easi_Census,
	left.shell_input.st<>''
		and left.shell_input.county <>''
		and left.shell_input.geo_blk <> ''
		and keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
	doModel(left, right), left outer,
	atmost(RiskWise.max_atmost)
	,keep(1)
);

return model;

END;
