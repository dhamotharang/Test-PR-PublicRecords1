IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, Riskview;

EXPORT RVC1602_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, 
dataset(riskview.layouts.Layout_Custom_Inputs) custom_inputs) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	 Integer seq;
   Integer sysdate;
   String	 fin_class;
   String	 client_type;
   String	 pat_type;
	 String _service;
   Real	 _in_dob;
   Real	 yr_in_dob;
   Real	 yr_in_dob_int;
   Real	 k_comb_age_d;
   Real	 k_estimated_income_d;
   Integer	 k_nap_addr_verd_d;
   Integer	 k_nap_fname_verd_d;
   Integer	 k_nap_lname_verd_d;
   Real	 r_a41_prop_owner_d;
   Integer	 r_a41_prop_owner_inp_only_d;
   Integer	 r_a43_watercraft_cnt_d;
   Integer	 r_a44_curr_add_naprop_d;
   Integer	 r_a46_curr_avm_autoval_d;
   Integer	 r_a49_curr_avm_chg_1yr_i;
   Real	 r_a49_curr_avm_chg_1yr_pct_i;
   Real	 _header_first_seen;
   Real	 r_c10_m_hdr_fs_d;
   Real	 r_c12_nonderog_recency_i;
   Real	 r_c12_num_nonderogs_d;
   Real	 r_c12_source_profile_d;
   Real	 r_c13_curr_addr_lres_d;
   Real	 r_c13_max_lres_d;
   Real	 r_c14_addr_stability_v2_d;
   Real	 r_c14_addrs_10yr_i;
   Real	 r_c14_addrs_15yr_i;
   Real	 r_c14_addrs_5yr_i;
   Integer	 r_c18_invalid_addrs_per_adl_i;
   Integer	 bureau_adl_eq_fseen_pos;
   String	 bureau_adl_fseen_eq;
   Integer	 _bureau_adl_fseen_eq;
   Integer	 _src_bureau_adl_fseen;
   Integer	 r_c21_m_bureau_adl_fs_d;
   Real	 r_c23_inp_addr_occ_index_d;
   Real	 r_c23_inp_addr_owned_not_occ_d;
   Real	 r_d30_derog_count_i;
   Real	 r_d31_attr_bankruptcy_recency_d;
   String r_D31_bk_chapter_n;
   Integer	 r_d31_bk_dism_hist_count_i;
   Integer	 r_d31_bk_disposed_hist_count_i;
   Real	 r_d31_mostrec_bk_i;
   Real	 _criminal_last_date;
   Real	 r_d32_mos_since_crim_ls_d;
   Real	 r_d32_criminal_count_i;
   Real	 r_d33_eviction_count_i;
   Real	 r_d33_eviction_recency_d;
   Real	 r_d34_unrel_lien60_count_i;
   Real	 r_d34_unrel_liens_ct_i;
   Integer	 r_e55_college_ind_d;
   Integer	 r_e57_br_source_count_d;
   Integer	 r_e57_prof_license_flag_d;
   Integer	 r_ever_asset_owner_d;
   Integer	 r_f00_addr_not_ver_w_ssn_i;
   Integer	 r_f00_nas_ssn_no_addr_verd_i;
   Integer	 r_f01_inp_addr_address_score_d;
   Real	 r_f03_address_match_d;
   Integer	 r_f03_input_add_not_most_rec_i;
   Real	 r_f04_curr_add_occ_index_d;
   Real	 r_i60_inq_auto_count12_i;
   Real	 r_i60_inq_auto_recency_d;
   Real	 r_i60_inq_comm_recency_d;
   Real	 r_i60_inq_count12_i;
   Real	 r_i60_inq_hiriskcred_count12_i;
   Real	 r_i60_inq_hiriskcred_recency_d;
   Real	 r_i60_inq_recency_d;
   Real	 r_i61_inq_collection_count12_i;
   Real	 r_i61_inq_collection_recency_d;
   String	 add_ec1;
   String	 add_ec3;
   String	 add_ec4;
   Real	 r_l70_add_standardized_i;
   Real	 r_l72_add_vacant_i;
   Real	 r_l77_add_po_box_i;
   Real	 r_l78_no_phone_at_addr_vel_i;
   Real	 r_l79_adls_per_addr_c6_i;
   Real	 r_l79_adls_per_addr_curr_i;
   Real	 r_l80_inp_avm_autoval_d;
   Real	 r_prop_owner_history_d;
   Real	 r_s66_adlperssn_count_i;
   Real	 r_wealth_index_d;
   Real	 b_final_score_0;
   Real	 b_final_score_1;
   Real	 b_final_score_2;
   Real	 b_final_score_3;
   Real	 b_final_score_4;
   Real	 b_final_score_5;
   Real	 b_final_score_6;
   Real	 b_final_score_7;
   Real	 b_final_score_8;
   Real	 b_final_score_9;
   Real	 b_final_score_10;
   Real	 b_final_score_11;
   Real	 b_final_score_12;
   Real	 b_final_score_13;
   Real	 b_final_score_14;
   Real	 b_final_score_15;
   Real	 b_final_score_16;
   Real	 b_final_score_17;
   Real	 b_final_score_18;
   Real	 b_final_score_19;
   Real	 b_final_score_20;
   Real	 b_final_score_21;
   Real	 b_final_score_22;
   Real	 b_final_score_23;
   Real	 b_final_score_24;
   Real	 b_final_score_25;
   Real	 b_final_score_26;
   Real	 b_final_score_27;
   Real	 b_final_score_28;
   Real	 b_final_score_29;
   Real	 b_final_score_30;
   Real	 b_final_score_31;
   Real	 b_final_score_32;
   Real	 b_final_score_33;
   Real	 b_final_score_34;
   Real	 b_final_score_35;
   Real	 b_final_score_36;
   Real	 b_final_score_37;
   Real	 b_final_score_38;
   Real	 b_final_score_39;
   Real	 b_final_score_40;
   Real	 b_final_score_41;
   Real	 b_final_score_42;
   Real	 b_final_score_43;
   Real	 b_final_score_44;
   Real	 b_final_score_45;
   Real	 b_final_score_46;
   Real	 b_final_score_47;
   Real	 b_final_score_48;
   Real	 b_final_score_49;
   Real	 b_final_score_50;
   Real	 b_final_score_51;
   Real	 b_final_score_52;
   Real	 b_final_score_53;
   Real	 b_final_score_54;
   Real	 b_final_score_55;
   Real	 b_final_score_56;
   Real	 b_final_score_57;
   Real	 b_final_score_58;
   Real	 b_final_score_59;
   Real	 b_final_score_60;
   Real	 b_final_score_61;
   Real	 b_final_score_62;
   Real	 b_final_score_63;
   Real	 b_final_score_64;
   Real	 b_final_score_65;
   Real	 b_final_score_66;
   Real	 b_final_score_67;
   Real	 b_final_score_68;
   Real	 b_final_score_69;
   Real	 b_final_score_70;
   Real	 b_final_score_71;
   Real	 b_final_score_72;
   Real	 b_final_score_73;
   Real	 b_final_score_74;
   Real	 b_final_score_75;
   Real	 b_final_score_76;
   Real	 b_final_score_77;
   Real	 b_final_score_78;
   Real	 b_final_score_79;
   Real	 b_final_score_80;
   Real	 b_final_score_81;
   Real	 b_final_score_82;
   Real	 b_final_score_83;
   Real	 b_final_score_84;
   Real	 b_final_score_85;
   Real	 b_final_score_86;
   Real	 b_final_score_87;
   Real	 b_final_score_88;
   Real	 b_final_score_89;
   Real	 b_final_score_90;
   Real	 b_final_score_91;
   Real	 b_final_score_92;
   Real	 b_final_score_93;
   Real	 b_final_score_94;
   Real	 b_final_score_95;
   Real	 b_final_score_96;
   Real	 b_final_score_97;
   Real	 b_final_score_98;
   Real	 b_final_score_99;
   Real	 b_final_score_100;
   Real	 b_final_score_101;
   Real	 b_final_score_102;
   Real	 b_final_score_103;
   Real	 b_final_score_104;
   Real	 b_final_score_105;
   Real	 b_final_score_106;
   Real	 b_final_score_107;
   Real	 b_final_score_108;
   Real	 b_final_score_109;
   Real	 b_final_score_110;
   Real	 b_final_score_111;
   Real	 b_final_score_112;
   Real	 b_final_score_113;
   Real	 b_final_score_114;
   Real	 b_final_score_115;
   Real	 b_final_score_116;
   Real	 b_final_score_117;
   Real	 b_final_score_118;
   Real	 b_final_score_119;
   Real	 b_final_score_120;
   Real	 b_final_score_121;
   Real	 b_final_score_122;
   Real	 b_final_score_123;
   Real	 b_final_score_124;
   Real	 b_final_score_125;
   Real	 b_final_score;
   Real	 e_final_score_0;
   Real	 e_final_score_1;
   Real	 e_final_score_2;
   Real	 e_final_score_3;
   Real	 e_final_score_4;
   Real	 e_final_score_5;
   Real	 e_final_score_6;
   Real	 e_final_score_7;
   Real	 e_final_score_8;
   Real	 e_final_score_9;
   Real	 e_final_score_10;
   Real	 e_final_score_11;
   Real	 e_final_score_12;
   Real	 e_final_score_13;
   Real	 e_final_score_14;
   Real	 e_final_score_15;
   Real	 e_final_score_16;
   Real	 e_final_score_17;
   Real	 e_final_score_18;
   Real	 e_final_score_19;
   Real	 e_final_score_20;
   Real	 e_final_score_21;
   Real	 e_final_score_22;
   Real	 e_final_score_23;
   Real	 e_final_score_24;
   Real	 e_final_score_25;
   Real	 e_final_score_26;
   Real	 e_final_score_27;
   Real	 e_final_score_28;
   Real	 e_final_score_29;
   Real	 e_final_score_30;
   Real	 e_final_score_31;
   Real	 e_final_score_32;
   Real	 e_final_score_33;
   Real	 e_final_score_34;
   Real	 e_final_score_35;
   Real	 e_final_score_36;
   Real	 e_final_score_37;
   Real	 e_final_score_38;
   Real	 e_final_score_39;
   Real	 e_final_score_40;
   Real	 e_final_score_41;
   Real	 e_final_score_42;
   Real	 e_final_score_43;
   Real	 e_final_score_44;
   Real	 e_final_score_45;
   Real	 e_final_score_46;
   Real	 e_final_score_47;
   Real	 e_final_score_48;
   Real	 e_final_score_49;
   Real	 e_final_score_50;
   Real	 e_final_score_51;
   Real	 e_final_score_52;
   Real	 e_final_score_53;
   Real	 e_final_score_54;
   Real	 e_final_score_55;
   Real	 e_final_score_56;
   Real	 e_final_score_57;
   Real	 e_final_score_58;
   Real	 e_final_score_59;
   Real	 e_final_score_60;
   Real	 e_final_score_61;
   Real	 e_final_score_62;
   Real	 e_final_score_63;
   Real	 e_final_score_64;
   Real	 e_final_score_65;
   Real	 e_final_score_66;
   Real	 e_final_score_67;
   Real	 e_final_score_68;
   Real	 e_final_score_69;
   Real	 e_final_score_70;
   Real	 e_final_score_71;
   Real	 e_final_score_72;
   Real	 e_final_score_73;
   Real	 e_final_score_74;
   Real	 e_final_score_75;
   Real	 e_final_score_76;
   Real	 e_final_score_77;
   Real	 e_final_score_78;
   Real	 e_final_score_79;
   Real	 e_final_score_80;
   Real	 e_final_score_81;
   Real	 e_final_score_82;
   Real	 e_final_score_83;
   Real	 e_final_score_84;
   Real	 e_final_score_85;
   Real	 e_final_score_86;
   Real	 e_final_score_87;
   Real	 e_final_score_88;
   Real	 e_final_score_89;
   Real	 e_final_score_90;
   Real	 e_final_score_91;
   Real	 e_final_score_92;
   Real	 e_final_score_93;
   Real	 e_final_score_94;
   Real	 e_final_score_95;
   Real	 e_final_score_96;
   Real	 e_final_score_97;
   Real	 e_final_score_98;
   Real	 e_final_score_99;
   Real	 e_final_score_100;
   Real	 e_final_score_101;
   Real	 e_final_score_102;
   Real	 e_final_score_103;
   Real	 e_final_score_104;
   Real	 e_final_score_105;
   Real	 e_final_score_106;
   Real	 e_final_score_107;
   Real	 e_final_score_108;
   Real	 e_final_score_109;
   Real	 e_final_score_110;
   Real	 e_final_score_111;
   Real	 e_final_score_112;
   Real	 e_final_score_113;
   Real	 e_final_score_114;
   Real	 e_final_score_115;
   Real	 e_final_score_116;
   Real	 e_final_score_117;
   Real	 e_final_score_118;
   Real	 e_final_score_119;
   Real	 e_final_score_120;
   Real	 e_final_score_121;
   Real	 e_final_score_122;
   Real	 e_final_score_123;
   Real	 e_final_score_124;
   Real	 e_final_score_125;
   Real	 e_final_score_126;
   Real	 e_final_score_127;
   Real	 e_final_score_128;
   Real	 e_final_score;
   Boolean	 exception_score;
   Real	 b_pbr;
   Real	 b_sbr;
   Real	 b_offset;
   Integer	 b_base;
   Integer	 b_pts;
   Real	 b_lgt;
   Real	 bad_debt_score;
   Real	 e_pbr;
   Real	 e_sbr;
   Real	 e_offset;
   Integer	 e_base;
   Integer	 e_pts;
   Real	 e_lgt;
   Integer	 early_out_score;
   Integer	 rvc1602_1_0;
   Real	 rc1v;
   Real	 rc2v;
   Real	 rc3v;
   Real	 rc4v;
   String	 _rc_inq;
   String	 rc5;
   String	 rc4;
   String	 rc2;
   String	 rc3;
   String	 rc1;

			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le, custom_inputs rt) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le, custom_inputs rt) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	fin_class_       := stringlib.stringtouppercase(trim(rt.Custom_Inputs(stringlib.stringtolowercase(OptionName)='custom_input1')[1].OptionValue));
	client_type_     := stringlib.stringtouppercase(trim(rt.Custom_Inputs(stringlib.stringtolowercase(OptionName)='custom_input2')[1].OptionValue));
	pat_type_        := stringlib.stringtouppercase(trim(rt.Custom_Inputs(stringlib.stringtolowercase(OptionName)='custom_input3')[1].OptionValue));
	service_         := stringlib.stringtouppercase(trim(rt.Custom_Inputs(stringlib.stringtolowercase(OptionName)='custom_input4')[1].OptionValue));
	truedid         := le.truedid;
	out_z5          := le.shell_input.z5;
	out_addr_type   := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob          := le.shell_input.dob;
	nas_summary     := le.iid.nas_summary;
	nap_summary     := le.iid.nap_summary;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_dwelltype    := le.iid.dwelltype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	rc_zipclass     := le.iid.zipclass;
	hdr_source_profile               := le.source_profile;
	ver_sources     := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	fnamepop        := le.input_validation.firstname;
	lnamepop        := le.input_validation.lastname;
	addrpop         := le.input_validation.address;
	ssnlength       := le.input_validation.ssn_length;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop   := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_lres   := le.lres2;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop    := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	max_lres        := le.other_address_info.max_lres;
	addrs_5yr       := le.other_address_info.addrs_last_5years;
	addrs_10yr      := le.other_address_info.addrs_last_10years;
	addrs_15yr      := le.other_address_info.addrs_last_15years;
	header_first_seen                := le.ssn_verification.header_first_seen;
	adls_per_ssn    := le.SSN_Verification.adlPerSSN_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_count       := le.acc_logs.inquiries.counttotal;
	inq_count01     := le.acc_logs.inquiries.count01;
	inq_count03     := le.acc_logs.inquiries.count03;
	inq_count06     := le.acc_logs.inquiries.count06;
	inq_count12     := le.acc_logs.inquiries.count12;
	inq_count24     := le.acc_logs.inquiries.count24;
	inq_auto_count                   := le.acc_logs.auto.counttotal;
	inq_auto_count01                 := le.acc_logs.auto.count01;
	inq_auto_count03                 := le.acc_logs.auto.count03;
	inq_auto_count06                 := le.acc_logs.auto.count06;
	inq_auto_count12                 := le.acc_logs.auto.count12;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_collection_count01           := le.acc_logs.collection.count01;
	inq_collection_count03           := le.acc_logs.collection.count03;
	inq_collection_count06           := le.acc_logs.collection.count06;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_collection_count24           := le.acc_logs.collection.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	br_source_count                  := le.employment.source_ct;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_bankruptcy_count30          := le.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_bankruptcy_count180         := le.bjl.bk_count180;
	attr_bankruptcy_count12          := le.bjl.bk_count12;
	attr_bankruptcy_count24          := le.bjl.bk_count24;
	attr_bankruptcy_count36          := le.bjl.bk_count36;
	attr_bankruptcy_count60          := le.bjl.bk_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
	attr_num_nonderogs180            := le.source_verification.num_nonderogs180;
	attr_num_nonderogs12             := le.source_verification.num_nonderogs12;
	attr_num_nonderogs24             := le.source_verification.num_nonderogs24;
	attr_num_nonderogs36             := le.source_verification.num_nonderogs36;
	attr_num_nonderogs60             := le.source_verification.num_nonderogs60;
	bankrupt        := le.bjl.bankrupt;
	disposition     := le.bjl.disposition;
	filing_count    := le.bjl.filing_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	bk_chapter      := le.bjl.bk_chapter;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	watercraft_count                 := le.watercraft.watercraft_count;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	prof_license_flag                := le.professional_license.professional_license_flag;
	wealth_index    := le.wealth_indicator;
	inferred_age    := le.inferred_age;
	addr_stability_v2                := le.addr_stability;
	estimated_income                 := le.estimated_income;


	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

//sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));
sysdate := (common.sas_date('20150501'));

fin_class := map(
    Fin_Class_ = 'TSP' => 'TSP',
    Fin_Class_ = 'BAI' => 'BAI',
    Fin_Class_ = 'UNK' => 'UNK',
    Fin_Class_ = ''  => 'UNK',
                         'UNK');

client_type := map(
    Client_Type_ = 'F'  => 'F',
    Client_Type_ = 'G'  => 'G',
    Client_Type_ = 'P'  => 'P',
    Client_Type_ = '' => 'F',
                          'F');

pat_type := map(
    pat_type_ = 'E'  => 'E',
    pat_type_ = 'I'  => 'I',
    pat_type_ = 'O'  => 'O',
    pat_type_ = 'S'  => 'S',
    pat_type_ = '' => 'NA',
                       'NA');

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

k_comb_age_d := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

k_estimated_income_d := if(not(truedid), NULL, estimated_income);

k_nap_addr_verd_d := (Integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]);

k_nap_fname_verd_d := (Integer)(nap_summary in [2, 3, 4, 8, 9, 10, 12]);

k_nap_lname_verd_d := (Integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]);

r_a41_prop_owner_d := map(
    not(truedid)                                                                                   => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                                                                                                      0);

r_a41_prop_owner_inp_only_d := map(
    not(truedid)                                => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 => 1,
                                                   0);

r_a43_watercraft_cnt_d := if(not(truedid), NULL, watercraft_count);

r_a44_curr_add_naprop_d := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);

r_a46_curr_avm_autoval_d := map(
    not(add_curr_pop)         => NULL,
    add_curr_avm_auto_val = 0 => NULL,
                                 min(if(add_curr_avm_auto_val = NULL, -NULL, add_curr_avm_auto_val), 300000));

r_a49_curr_avm_chg_1yr_i := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => add_curr_avm_auto_val - add_curr_avm_auto_val_2,
                                                                 NULL);

r_a49_curr_avm_chg_1yr_pct_i := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL);

_header_first_seen := common.sas_date((string)(header_first_seen));

r_c10_m_hdr_fs_d := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

r_c12_nonderog_recency_i := map(
    not(truedid)            => NULL,
    (Boolean)attr_num_nonderogs90    => 3,
    (Boolean)attr_num_nonderogs180   => 6,
    (Boolean)attr_num_nonderogs12    => 12,
    (Boolean)attr_num_nonderogs24    => 24,
    (Boolean)attr_num_nonderogs36    => 36,
    (Boolean)attr_num_nonderogs60    => 60,
    (Integer)attr_num_nonderogs >= 1 => 99,
                               999);

r_c12_num_nonderogs_d := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 999));

r_c12_source_profile_d := if(not(truedid), NULL, hdr_source_profile);

r_c13_curr_addr_lres_d := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

r_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

r_c14_addr_stability_v2_d := map(
    not(truedid)          => NULL,
    addr_stability_v2 = '0' => NULL,
                             (Integer)addr_stability_v2);

r_c14_addrs_10yr_i := if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

r_c14_addrs_5yr_i := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

r_c18_invalid_addrs_per_adl_i := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

r_c21_m_bureau_adl_fs_d := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

r_c23_inp_addr_occ_index_d := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

r_c23_inp_addr_owned_not_occ_d := if(not(add_input_pop and truedid), NULL, (Integer)add_input_owned_not_occ);

r_d30_derog_count_i := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

r_d31_attr_bankruptcy_recency_d := map(
    not(truedid)             => NULL,
    (Boolean)attr_bankruptcy_count30  => 1,
    (Boolean)attr_bankruptcy_count90  => 3,
    (Boolean)attr_bankruptcy_count180 => 6,
    (Boolean)attr_bankruptcy_count12  => 12,
    (Boolean)attr_bankruptcy_count24  => 24,
    (Boolean)attr_bankruptcy_count36  => 36,
    (Boolean)attr_bankruptcy_count60  => 60,
    bankrupt                 => 99,
    filing_count > 0         => 99,
                                0);

r_D31_bk_chapter_n := map(
    not(truedid)                                 => '',
    not((bk_chapter in ['7', '11', '12', '13'])) => '',
                                                    trim(bk_chapter, LEFT));

r_d31_bk_dism_hist_count_i := if(not(truedid), NULL, min(if(bk_dismissed_historical_count = NULL, -NULL, bk_dismissed_historical_count), 999));

r_d31_bk_disposed_hist_count_i := if(not(truedid), NULL, min(if(bk_disposed_historical_count = NULL, -NULL, bk_disposed_historical_count), 999));

r_d31_mostrec_bk_i := map(
    not(truedid)                                    => NULL,
    contains_i(Stringlib.stringtouppercase(disposition), 'DISMISS') = 1  => 1,
    contains_i(Stringlib.stringtouppercase(disposition), 'DISCHARG') = 1 => 2,
    (integer)bankrupt = 1 or (integer)filing_count > 0                => 3,
                                                       0);


_criminal_last_date := common.sas_date((string)(criminal_last_date));

r_d32_mos_since_crim_ls_d := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

r_d32_criminal_count_i := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

r_d33_eviction_count_i := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

r_d33_eviction_recency_d := map(
    not(truedid)             => NULL,
    (Boolean)attr_eviction_count90    => 3,
    (Boolean)attr_eviction_count180   => 6,
    (Boolean)attr_eviction_count12    => 12,
    (Boolean)attr_eviction_count24    => 24,
    (Boolean)attr_eviction_count36    => 36,
    (Boolean)attr_eviction_count60    => 60,
    (Integer)attr_eviction_count >= 1 => 99,
                                999);

r_d34_unrel_lien60_count_i := if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 999));

r_d34_unrel_liens_ct_i := if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 999));

r_e55_college_ind_d := map(
    not(truedid)                           => NULL,
    (college_file_type in ['H', 'C', 'A']) => 1,
    college_attendance                     => 1,
                                              0);

r_e57_br_source_count_d := if(not(truedid), NULL, br_source_count);

r_e57_prof_license_flag_d := if(not(truedid), NULL, (Integer)prof_license_flag);

r_ever_asset_owner_d := map(
    not(truedid)                                                                                                                                                                                                 => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => 1,
                                                                                                                                                                                                                    0);

r_f00_addr_not_ver_w_ssn_i := if(not(truedid and ssnlength > '0'), NULL, (Integer)(nas_summary in [4, 7, 9]));

r_f00_nas_ssn_no_addr_verd_i := (Integer)(nas_summary in [4, 7, 9]);

r_f01_inp_addr_address_score_d := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

r_f03_address_match_d := map(
    not(truedid)                                => NULL,
    add_input_isbestmatch                       => 4,
    not(add_input_pop) and add_curr_isbestmatch => 3,
    add_input_pop and add_curr_isbestmatch      => 2,
    add_curr_pop                                => 1,
    add_input_pop                               => 0,
                                                   NULL);

r_f03_input_add_not_most_rec_i := if(not(truedid and add_input_pop), NULL, (Integer)rc_input_addr_not_most_recent);

r_f04_curr_add_occ_index_d := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);

r_i60_inq_auto_count12_i := if(not(truedid), NULL, min(if(inq_auto_count12 = NULL, -NULL, inq_auto_count12), 999));

r_i60_inq_auto_recency_d := map(
    not(truedid)     => NULL,
    (Boolean)inq_auto_count01 => 1,
    (Boolean)inq_auto_count03 => 3,
    (Boolean)inq_auto_count06 => 6,
    (Boolean)inq_auto_count12 => 12,
    (Boolean)inq_auto_count24 => 24,
    (Boolean)inq_auto_count   => 99,
                        999);

r_i60_inq_comm_recency_d := map(
    not(truedid)               => NULL,
    (Boolean)inq_communications_count01 => 1,
    (Boolean)inq_communications_count03 => 3,
    (Boolean)inq_communications_count06 => 6,
    (Boolean)inq_communications_count12 => 12,
    (Boolean)inq_communications_count24 => 24,
    (Boolean)inq_communications_count   => 99,
                                  999);

r_i60_inq_count12_i := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

r_i60_inq_hiriskcred_count12_i := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

r_i60_inq_hiriskcred_recency_d :=  map(
    not(truedid)               => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
                                  999);

r_i60_inq_recency_d := map(
    not(truedid) => NULL,
    (Boolean)inq_count01  => 1,
    (Boolean)inq_count03  => 3,
    (Boolean)inq_count06  => 6,
    (Boolean)inq_count12  => 12,
    (Boolean)inq_count24  => 24,
    (Boolean)inq_count    => 99,
                    999);

r_i61_inq_collection_count12_i := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999));

r_i61_inq_collection_recency_d := map(
    not(truedid)           => NULL,
    (Boolean)inq_collection_count01 => 1,
    (Boolean)inq_collection_count03 => 3,
    (Boolean)inq_collection_count06 => 6,
    (Boolean)inq_collection_count12 => 12,
    (Boolean)inq_collection_count24 => 24,
    (Boolean)inq_collection_count   => 99,
                              999);


add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

r_l70_add_standardized_i := map(
    not(addrpop)                                         => NULL,
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => 2,
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => 1,
                                                            0);

r_l72_add_vacant_i := map(
    not(add_input_pop)                                          => NULL,
    trim(trim(add_input_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => 1,
                                                                   0);

r_l77_add_po_box_i := map(
    not(addrpop or not(out_z5 = ''))                                                                                                                                                                                                                           => NULL,
    rc_hriskaddrflag = '1' or rc_ziptypeflag = '1' or StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'E' or StringLib.StringToUpperCase(trim(rc_zipclass, LEFT, RIGHT)) = 'P' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'P' => 1,
                                                                                                                                                                                                                                                                    0);

r_l78_no_phone_at_addr_vel_i := map(
    not(addrpop)             => NULL,
    phones_per_addr_curr = 0 => 1,
                                0);

r_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

r_l79_adls_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

r_l80_inp_avm_autoval_d := map(
    not(add_input_pop)         => NULL,
    add_input_avm_auto_val = 0 => NULL,
                                  min(if(add_input_avm_auto_val = NULL, -NULL, add_input_avm_auto_val), 300000));

r_prop_owner_history_d := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

r_s66_adlperssn_count_i := map(
    not(ssnlength > '0') => NULL,
    adls_per_ssn = 0   => 1,
                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

r_wealth_index_d := if(not(truedid), NULL, (Integer)wealth_index);

b_final_score_0 :=  -1.8824292695;

// Tree: 1 
b_final_score_1 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 36500) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3.5) => 
      map(
      (Fin_Class in ['TSP','UNK']) => -0.0689682162,
      (Fin_Class in ['BAI']) => 0.0042604090,
      (Fin_Class = '') => -0.0413834024, -0.0413834024),
   (r_A44_curr_add_naprop_d > 3.5) => 0.0467276789,
   (r_A44_curr_add_naprop_d = NULL) => -0.0239932787, -0.0239932787),
(k_estimated_income_d > 36500) => 0.1519557576,
(k_estimated_income_d = NULL) => -0.0703677137, -0.0013679312);

// Tree: 2 
b_final_score_2 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 36500) => 
   map(
   (Fin_Class in ['TSP']) => -0.0836475344,
   (Fin_Class in ['BAI','UNK']) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => -0.0234806613,
      (r_A44_curr_add_naprop_d > 2.5) => 0.0501079303,
      (r_A44_curr_add_naprop_d = NULL) => 0.0023104623, 0.0023104623),
   (Fin_Class = '') => -0.0219475223, -0.0219475223),
(k_estimated_income_d > 36500) => 0.1294857658,
(k_estimated_income_d = NULL) => -0.0342724436, -0.0017009265);

// Tree: 3 
b_final_score_3 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0575850546,
   (Fin_Class in ['BAI']) => 0.0138974042,
   (Fin_Class = '') => -0.0317464104, -0.0317464104),
(k_estimated_income_d > 30500) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0060696972,
   (r_F03_address_match_d > 3.5) => 0.1000511340,
   (r_F03_address_match_d = NULL) => 0.0708649868, 0.0708649868),
(k_estimated_income_d = NULL) => -0.0424271611, -0.0022729094);

// Tree: 4 
b_final_score_4 := map(
(NULL < r_wealth_index_d and r_wealth_index_d <= 3.5) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0507213766,
   (Fin_Class in ['BAI']) => 0.0239535856,
   (Fin_Class = '') => -0.0216212663, -0.0216212663),
(r_wealth_index_d > 3.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 226357) => 0.0539714591,
   (r_L80_Inp_AVM_AutoVal_d > 226357) => 0.1908129754,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0556919867, 0.0873417178),
(r_wealth_index_d = NULL) => -0.0422917584, -0.0064652198);

// Tree: 5 
b_final_score_5 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0627561539,
   (Fin_Class in ['BAI']) => 0.0073261915,
   (Fin_Class = '') => -0.0370701594, -0.0370701594),
(k_estimated_income_d > 30500) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3.5) => 0.0205385566,
   (r_A44_curr_add_naprop_d > 3.5) => 0.0993293943,
   (r_A44_curr_add_naprop_d = NULL) => 0.0600655860, 0.0600655860),
(k_estimated_income_d = NULL) => -0.0301927815, -0.0090452942);

// Tree: 6 
b_final_score_6 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3.5) => 
   map(
   (Fin_Class in ['TSP']) => -0.0709603341,
   (Fin_Class in ['BAI','UNK']) => -0.0071180882,
   (Fin_Class = '') => -0.0279232636, -0.0279232636),
(r_A44_curr_add_naprop_d > 3.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 173884.5) => 0.0377396727,
   (r_A46_Curr_AVM_AutoVal_d > 173884.5) => 0.1220419503,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0560537256, 0.0625032746),
(r_A44_curr_add_naprop_d = NULL) => -0.0492489841, -0.0072097174);

// Tree: 7 
b_final_score_7 := map(
(NULL < r_wealth_index_d and r_wealth_index_d <= 3.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (Fin_Class in ['TSP','UNK']) => -0.0320161007,
      (Fin_Class in ['BAI']) => 0.0324481742,
      (Fin_Class = '') => -0.0055397021, -0.0055397021),
   (r_D30_Derog_Count_i > 0.5) => -0.0597766218,
   (r_D30_Derog_Count_i = NULL) => -0.0231830374, -0.0231830374),
(r_wealth_index_d > 3.5) => 0.0645320628,
(r_wealth_index_d = NULL) => -0.0190632768, -0.0108157438);

// Tree: 8 
b_final_score_8 := map(
(NULL < r_wealth_index_d and r_wealth_index_d <= 2.5) => -0.0225065076,
(r_wealth_index_d > 2.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 258793) => 0.0557408570,
      (r_A46_Curr_AVM_AutoVal_d > 258793) => 0.1641062997,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0642769219, 0.0729324325),
   (r_D30_Derog_Count_i > 0.5) => -0.0043884201,
   (r_D30_Derog_Count_i = NULL) => 0.0499729783, 0.0499729783),
(r_wealth_index_d = NULL) => -0.0310877217, -0.0053764782);

// Tree: 9 
b_final_score_9 := map(
(NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0652216637,
   (r_F03_address_match_d > 3.5) => -0.0030782412,
   (r_F03_address_match_d = NULL) => -0.0299580580, -0.0299580580),
(r_A41_Prop_Owner_d > 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 187550.5) => 0.0223926725,
   (r_L80_Inp_AVM_AutoVal_d > 187550.5) => 0.0874603570,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0245994494, 0.0336048359),
(r_A41_Prop_Owner_d = NULL) => -0.0323722923, -0.0072029772);

// Tree: 10 
b_final_score_10 := map(
(NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => -0.0242977019,
(r_A41_Prop_Owner_d > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 271372) => 0.0462639120,
      (r_A46_Curr_AVM_AutoVal_d > 271372) => 0.1183299016,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0280962856, 0.0455507264),
   (r_D30_Derog_Count_i > 0.5) => -0.0221729625,
   (r_D30_Derog_Count_i = NULL) => 0.0251866709, 0.0251866709),
(r_A41_Prop_Owner_d = NULL) => -0.0378338111, -0.0064127867);

// Tree: 11 
b_final_score_11 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => -0.0235167065,
(r_A44_curr_add_naprop_d > 2.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 187048.5) => 0.0117395212,
   (r_A46_Curr_AVM_AutoVal_d > 187048.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 0.1078195868,
      (r_L79_adls_per_addr_c6_i > 0.5) => 0.0088246382,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0723898157, 0.0723898157),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0269169344, 0.0269913902),
(r_A44_curr_add_naprop_d = NULL) => -0.0142440856, -0.0060151559);

// Tree: 12 
b_final_score_12 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => -0.0226413362,
(k_estimated_income_d > 30500) => 
   map(
   (Fin_Class in ['TSP']) => -0.0377347737,
   (Fin_Class in ['BAI','UNK']) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => -0.0177661470,
      (r_F01_inp_addr_address_score_d > 95) => 0.0528202396,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0440085357, 0.0440085357),
   (Fin_Class = '') => 0.0312417826, 0.0312417826),
(k_estimated_income_d = NULL) => -0.0614524301, -0.0079722792);

// Tree: 13 
b_final_score_13 := map(
(Fin_Class in ['TSP']) => -0.0525930934,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => 0.0094394543,
      (k_estimated_income_d > 30500) => 0.0436864711,
      (k_estimated_income_d = NULL) => 0.0213884003, 0.0213884003),
   (r_D30_Derog_Count_i > 1.5) => -0.0469793310,
   (r_D30_Derog_Count_i = NULL) => 0.0114959136, 0.0114959136),
(Fin_Class = '') => -0.0065844062, -0.0065844062);

// Tree: 14 
b_final_score_14 := map(
(Fin_Class in ['TSP']) => -0.0573190859,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 163958) => -0.0052437260,
   (r_A46_Curr_AVM_AutoVal_d > 163958) => 0.0546555439,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 312.5) => 0.0032042694,
      (r_C13_max_lres_d > 312.5) => 0.0941474488,
      (r_C13_max_lres_d = NULL) => 0.0114195521, 0.0114195521), 0.0112197555),
(Fin_Class = '') => -0.0072300651, -0.0072300651);

// Tree: 15 
b_final_score_15 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => -0.0234994560,
(r_A44_curr_add_naprop_d > 2.5) => 
   map(
   (NULL < r_I60_inq_auto_recency_d and r_I60_inq_auto_recency_d <= 505.5) => -0.0491794194,
   (r_I60_inq_auto_recency_d > 505.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 137489) => 0.0025476398,
      (r_A46_Curr_AVM_AutoVal_d > 137489) => 0.0450885621,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0335772149, 0.0237213637),
   (r_I60_inq_auto_recency_d = NULL) => 0.0170786929, 0.0170786929),
(r_A44_curr_add_naprop_d = NULL) => -0.0091508555, -0.0091115160);

// Tree: 16 
b_final_score_16 := map(
(Fin_Class in ['TSP','UNK']) => -0.0218589159,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.0394411016,
      (k_nap_fname_verd_d > 0.5) => 0.1291949816,
      (k_nap_fname_verd_d = NULL) => 0.0671625531, 0.0671625531),
   (r_C14_addrs_15yr_i > 1.5) => 0.0049517128,
   (r_C14_addrs_15yr_i = NULL) => 0.0250033504, 0.0250033504),
(Fin_Class = '') => -0.0032994544, -0.0032994544);

// Tree: 17 
b_final_score_17 := map(
(Fin_Class in ['TSP']) => -0.0460362939,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0434347956,
   (r_I60_inq_recency_d > 505.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0282085210,
      (r_D30_Derog_Count_i > 1.5) => -0.0410200458,
      (r_D30_Derog_Count_i = NULL) => 0.0183475819, 0.0183475819),
   (r_I60_inq_recency_d = NULL) => 0.0083711571, 0.0083711571),
(Fin_Class = '') => -0.0063441181, -0.0063441181);

// Tree: 18 
b_final_score_18 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 0.5) => 0.0373094934,
   (r_C14_addrs_15yr_i > 0.5) => -0.0221055767,
   (r_C14_addrs_15yr_i = NULL) => -0.0146596147, -0.0146596147),
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0865051482,
   (r_D30_Derog_Count_i > 0.5) => -0.0281348366,
   (r_D30_Derog_Count_i = NULL) => 0.0533711804, 0.0533711804),
(r_E55_College_Ind_d = NULL) => -0.0059929463, -0.0074010766);

// Tree: 19 
b_final_score_19 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0334750141,
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (Fin_Class in ['TSP','UNK']) => -0.0159897020,
      (Fin_Class in ['BAI']) => 0.0311820700,
      (Fin_Class = '') => 0.0037481450, 0.0037481450),
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0506995427,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0097585079, 0.0097585079),
(r_F03_address_match_d = NULL) => -0.0089792820, -0.0061614820);

// Tree: 20 
b_final_score_20 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 85918) => -0.0364203185,
   (r_L80_Inp_AVM_AutoVal_d > 85918) => 0.0329197608,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 37500) => 0.0040086338,
      (k_estimated_income_d > 37500) => 0.0856169651,
      (k_estimated_income_d = NULL) => 0.0085642481, 0.0085642481), 0.0085908350),
(r_D30_Derog_Count_i > 0.5) => -0.0374211255,
(r_D30_Derog_Count_i = NULL) => 0.0078855997, -0.0056209475);

// Tree: 21 
b_final_score_21 := map(
(NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => -0.0259728201,
(r_Ever_Asset_Owner_d > 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 101098) => -0.0035220453,
      (r_A46_Curr_AVM_AutoVal_d > 101098) => 0.0553192077,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0428599059, 0.0376047262),
   (r_L79_adls_per_addr_curr_i > 2.5) => -0.0091913414,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0206266769, 0.0206266769),
(r_Ever_Asset_Owner_d = NULL) => -0.0548845452, -0.0062453710);

// Tree: 22 
b_final_score_22 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 77500) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0260852502,
   (Fin_Class in ['BAI']) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0232446233,
      (r_D30_Derog_Count_i > 0.5) => -0.0249971907,
      (r_D30_Derog_Count_i = NULL) => 0.0087801261, 0.0087801261),
   (Fin_Class = '') => -0.0121553648, -0.0121553648),
(k_estimated_income_d > 77500) => 0.0802095642,
(k_estimated_income_d = NULL) => -0.0306485877, -0.0108677152);

// Tree: 23 
b_final_score_23 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 59500) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 299.5) => -0.0136022713,
   (r_C13_Curr_Addr_LRes_d > 299.5) => 0.0553024280,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0106162424, -0.0106162424),
(k_estimated_income_d > 59500) => 
   map(
   (Client_Type in ['F']) => 0.0048766318,
   (Client_Type in ['G','P']) => 0.1143449377,
   (Client_Type = '') => 0.0408906347, 0.0408906347),
(k_estimated_income_d = NULL) => -0.0469151379, -0.0090603631);

// Tree: 24 
b_final_score_24 := map(
(Fin_Class in ['TSP']) => -0.0467672158,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 62962) => -0.0290432536,
   (r_L80_Inp_AVM_AutoVal_d > 62962) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0390911111,
      (r_D30_Derog_Count_i > 1.5) => -0.0471446052,
      (r_D30_Derog_Count_i = NULL) => 0.0265119981, 0.0265119981),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0047287726, 0.0092230348),
(Fin_Class = '') => -0.0057505826, -0.0057505826);

// Tree: 25 
b_final_score_25 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 342.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0123486296,
   (r_E55_College_Ind_d > 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 139438) => -0.0325202113,
      (r_A46_Curr_AVM_AutoVal_d > 139438) => 0.0537506051,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0670484350, 0.0367730058),
   (r_E55_College_Ind_d = NULL) => -0.0068246001, -0.0068246001),
(r_C13_max_lres_d > 342.5) => 0.0611535266,
(r_C13_max_lres_d = NULL) => -0.0429459551, -0.0034483460);

// Tree: 26 
b_final_score_26 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0256364110,
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0170672217,
      (r_D30_Derog_Count_i > 0.5) => -0.0249102952,
      (r_D30_Derog_Count_i = NULL) => 0.0047279062, 0.0047279062),
   (r_E57_br_source_count_d > 0.5) => 0.0634973615,
   (r_E57_br_source_count_d = NULL) => 0.0100416001, 0.0100416001),
(r_F03_address_match_d = NULL) => -0.0182524218, -0.0034055900);

// Tree: 27 
b_final_score_27 := map(
(NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
      map(
			(r_D31_bk_chapter_n = '') => -0.0219544327,
      (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0674742993,
      ((Integer)r_D31_bk_chapter_n > 10) => -0.0336218078,
       -0.0183504088),
   (r_E55_College_Ind_d > 0.5) => 0.0327680391,
   (r_E55_College_Ind_d = NULL) => -0.0216346123, -0.0130889024),
(k_nap_fname_verd_d > 0.5) => 0.0301400316,
(k_nap_fname_verd_d = NULL) => -0.0061082607, -0.0061082607);

// Tree: 28 
b_final_score_28 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 28500) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 317) => -0.0161967921,
   (r_C13_Curr_Addr_LRes_d > 317) => 0.0899188089,
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0127793615, -0.0127793615),
(k_estimated_income_d > 28500) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 0.0293358469,
   (r_I60_Inq_Count12_i > 1.5) => -0.0711233543,
   (r_I60_Inq_Count12_i = NULL) => 0.0220208565, 0.0220208565),
(k_estimated_income_d = NULL) => 0.0404184710, 0.0023056540);

// Tree: 29 
b_final_score_29 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0078174174,
   (r_E55_College_Ind_d > 0.5) => 0.0359758470,
   (r_E55_College_Ind_d = NULL) => 0.0126828625, -0.0026376466),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 45.5) => -0.0027380537,
   (k_comb_age_d > 45.5) => 0.1369592748,
   (k_comb_age_d = NULL) => 0.0629405410, 0.0629405410),
((Integer)r_D31_bk_chapter_n > 10) => -0.0420808961,
 -0.0007459598);

// Tree: 30 
b_final_score_30 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0037595891,
   (Fin_Class in ['BAI']) => 0.0345835920,
   (Fin_Class = '') => 0.0116535862, 0.0116535862),
(r_S66_adlperssn_count_i > 1.5) => -0.0193878485,
(r_S66_adlperssn_count_i = NULL) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 106.5) => -0.0198756267,
   (r_C13_max_lres_d > 106.5) => 0.0793262478,
   (r_C13_max_lres_d = NULL) => -0.0753927602, 0.0026751964), -0.0023184948);

// Tree: 31 
b_final_score_31 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0018706643,
      (r_D30_Derog_Count_i > 0.5) => -0.0388000248,
      (r_D30_Derog_Count_i = NULL) => -0.0091324123, -0.0091324123),
   (r_L79_adls_per_addr_curr_i > 4.5) => -0.0651575835,
   (r_L79_adls_per_addr_curr_i = NULL) => -0.0399554825, -0.0144544991),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0618700624,
((Integer)r_D31_bk_chapter_n > 10) => 0.0022910394,
 -0.0107146510);

// Tree: 32 
b_final_score_32 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 74307) => -0.0402455380,
(r_A46_Curr_AVM_AutoVal_d > 74307) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0247257018,
   (r_L79_adls_per_addr_curr_i > 2.5) => -0.0144670150,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0077102373, 0.0077102373),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 44500) => -0.0056791714,
   (k_estimated_income_d > 44500) => 0.0863158513,
   (k_estimated_income_d = NULL) => 0.0306877719, -0.0006378476), -0.0035887026);

// Tree: 33 
b_final_score_33 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 302) => 0.0316941949,
      (r_C13_Curr_Addr_LRes_d > 302) => 0.0941015166,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0461373402, 0.0461373402),
   (r_D30_Derog_Count_i > 0.5) => -0.0426683936,
   (r_D30_Derog_Count_i = NULL) => 0.0286955501, 0.0286955501),
(r_C14_addrs_15yr_i > 0.5) => -0.0051595030,
(r_C14_addrs_15yr_i = NULL) => 0.0141869370, -0.0006981080);

// Tree: 34 
b_final_score_34 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 80458) => -0.0204049669,
   (r_L80_Inp_AVM_AutoVal_d > 80458) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0332620012,
      (r_D30_Derog_Count_i > 1.5) => -0.0566905704,
      (r_D30_Derog_Count_i = NULL) => 0.0219205784, 0.0219205784),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0061172515, 0.0006419703),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0750086210,
((Integer)r_D31_bk_chapter_n > 10) => -0.0515628021,
 0.0026935889);

// Tree: 35 
b_final_score_35 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 79.5) => 
   map(
   (NULL < r_D32_criminal_count_i and r_D32_criminal_count_i <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0098217218,
      (r_L79_adls_per_addr_curr_i > 2.5) => -0.0193918258,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0005579852, -0.0005579852),
   (r_D32_criminal_count_i > 0.5) => -0.0874268162,
   (r_D32_criminal_count_i = NULL) => -0.0066443365, -0.0066443365),
(k_comb_age_d > 79.5) => 0.0867335587,
(k_comb_age_d = NULL) => -0.0094388243, -0.0049610226);

// Tree: 36 
b_final_score_36 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 0.0062592745,
      (r_L79_adls_per_addr_curr_i > 3.5) => -0.0338232864,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0014725068, -0.0014725068),
   (r_I60_Inq_Count12_i > 1.5) => -0.0630956045,
   (r_I60_Inq_Count12_i = NULL) => -0.0068971917, -0.0068971917),
(k_comb_age_d > 70.5) => 0.0467296201,
(k_comb_age_d = NULL) => 0.0096016388, -0.0029735587);

// Tree: 37 
b_final_score_37 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 46500) => 
   map(
   (NULL < r_E57_prof_license_flag_d and r_E57_prof_license_flag_d <= 0.5) => -0.0091436311,
   (r_E57_prof_license_flag_d > 0.5) => 0.0576487570,
   (r_E57_prof_license_flag_d = NULL) => -0.0066319396, -0.0066319396),
(k_estimated_income_d > 46500) => 
   map(
   (Client_Type in ['F']) => 0.0067206871,
   (Client_Type in ['G','P']) => 0.0889219005,
   (Client_Type = '') => 0.0343494283, 0.0343494283),
(k_estimated_income_d = NULL) => 0.0044614540, -0.0039892851);

// Tree: 38 
b_final_score_38 := map(
(Fin_Class in ['TSP','UNK']) => 
   map(
   (Client_Type in ['F','G']) => -0.0439796984,
   (Client_Type in ['P']) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 57500) => 0.0062126734,
      (k_estimated_income_d > 57500) => 0.0694247601,
      (k_estimated_income_d = NULL) => 0.0115121761, 0.0115121761),
   (Client_Type = '') => -0.0241548501, -0.0241548501),
(Fin_Class in ['BAI']) => 0.0125498024,
(Fin_Class = '') => -0.0094835314, -0.0094835314);

// Tree: 39 
b_final_score_39 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 3259.5) => 0.0109433453,
   (r_A49_Curr_AVM_Chg_1yr_i > 3259.5) => -0.0254163737,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 144615) => -0.0320038964,
      (r_L80_Inp_AVM_AutoVal_d > 144615) => 0.0767960615,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0008111222, -0.0005231556), -0.0036725105),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0423262173,
((Integer)r_D31_bk_chapter_n > 10) => -0.0556912272,
 -0.0029933057);

// Tree: 40 
b_final_score_40 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < (Integer)k_nap_lname_verd_d and (Integer)k_nap_lname_verd_d <= 0.5) => -0.0155468024,
   ((Integer)k_nap_lname_verd_d > 0.5) => 0.0142222759,
   ((Integer)k_nap_lname_verd_d = NULL) => -0.0084193034, -0.0084193034),
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 129949) => -0.0253863848,
   (r_A46_Curr_AVM_AutoVal_d > 129949) => 0.0401848669,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0604596317, 0.0314799631),
(r_E55_College_Ind_d = NULL) => -0.0035390799, -0.0041360574);

// Tree: 41 
b_final_score_41 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0080866047,
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (Fin_Class in ['BAI','TSP']) => 0.0301585245,
      (Fin_Class in ['UNK']) => 0.0977716163,
      (Fin_Class = '') => 0.0509205244, 0.0509205244),
   (r_D30_Derog_Count_i > 0.5) => -0.0441611926,
   (r_D30_Derog_Count_i = NULL) => 0.0244473350, 0.0244473350),
(r_E55_College_Ind_d = NULL) => 0.0124623560, -0.0039745083);

// Tree: 42 
b_final_score_42 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 65) => -0.0339964109,
(r_F01_inp_addr_address_score_d > 65) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 32950) => -0.0712681838,
      (r_A46_Curr_AVM_AutoVal_d > 32950) => 0.0113183051,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0149676597, 0.0093352843),
   (r_I60_Inq_Count12_i > 1.5) => -0.0515920706,
   (r_I60_Inq_Count12_i = NULL) => 0.0039927737, 0.0039927737),
(r_F01_inp_addr_address_score_d = NULL) => -0.0330943160, -0.0047067316);

// Tree: 43 
b_final_score_43 := map(
(NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 99.05) => 0.0162718897,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 99.05) => -0.0239674361,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0046862236, -0.0017946989),
   (r_E57_br_source_count_d > 0.5) => 0.0367534744,
   (r_E57_br_source_count_d = NULL) => 0.0011856611, 0.0011856611),
(r_I61_inq_collection_count12_i > 0.5) => -0.0918891280,
(r_I61_inq_collection_count12_i = NULL) => 0.0319337712, -0.0010695181);

// Tree: 44 
b_final_score_44 := map(
(Client_Type in ['F']) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0361814216,
   (Fin_Class in ['BAI']) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 0.0288704831,
      (r_C14_addrs_15yr_i > 1.5) => -0.0018481667,
      (r_C14_addrs_15yr_i = NULL) => 0.0079853540, 0.0079853540),
   (Fin_Class = '') => -0.0139578362, -0.0139578362),
(Client_Type in ['G','P']) => 0.0250241259,
(Client_Type = '') => -0.0053490863, -0.0053490863);

// Tree: 45 
b_final_score_45 := map(
(NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 303) => 
   map(
   (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => -0.0163781937,
   (r_Ever_Asset_Owner_d > 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 11115) => 0.0026422569,
      (r_A49_Curr_AVM_Chg_1yr_i > 11115) => -0.0232578619,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0297894582, 0.0112787237),
   (r_Ever_Asset_Owner_d = NULL) => -0.0043629527, -0.0043629527),
(r_C13_Curr_Addr_LRes_d > 303) => 0.0428549633,
(r_C13_Curr_Addr_LRes_d = NULL) => -0.0066787039, -0.0023233107);

// Tree: 46 
b_final_score_46 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 359.5) => -0.0023618279,
   (r_C13_max_lres_d > 359.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0815225908,
      (r_L79_adls_per_addr_curr_i > 2.5) => -0.0393736190,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0361865121, 0.0361865121),
   (r_C13_max_lres_d = NULL) => -0.0001885974, -0.0001885974),
(r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0826890027,
(r_I60_inq_hiRiskCred_count12_i = NULL) => -0.0309518836, -0.0048114937);

// Tree: 47 
b_final_score_47 := map(
(NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 0.0197461370,
      (r_C14_addrs_10yr_i > 0.5) => -0.0086416719,
      (r_C14_addrs_10yr_i = NULL) => -0.0027696433, -0.0027696433),
   (r_L79_adls_per_addr_curr_i > 4.5) => -0.0393985845,
   (r_L79_adls_per_addr_curr_i = NULL) => -0.0059564379, -0.0059564379),
(r_C23_inp_addr_occ_index_d > 4.5) => 0.0596384249,
(r_C23_inp_addr_occ_index_d = NULL) => -0.0090129801, -0.0029344536);

// Tree: 48 
b_final_score_48 := map(
(Fin_Class in ['TSP']) => -0.0356067018,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 9) => -0.0428219957,
   (r_I60_inq_recency_d > 9) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => -0.0231297354,
      (r_C12_Num_NonDerogs_d > 1.5) => 0.0136570736,
      (r_C12_Num_NonDerogs_d = NULL) => 0.0065454994, 0.0065454994),
   (r_I60_inq_recency_d = NULL) => 0.0024834760, 0.0024834760),
(Fin_Class = '') => -0.0082075441, -0.0082075441);

// Tree: 49 
b_final_score_49 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_E57_prof_license_flag_d and r_E57_prof_license_flag_d <= 0.5) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0042881651,
      (r_C18_invalid_addrs_per_adl_i > 0.5) => -0.0203914602,
      (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0071143888, -0.0071143888),
   (r_E57_prof_license_flag_d > 0.5) => 0.0342052601,
   (r_E57_prof_license_flag_d = NULL) => 0.0350188923, -0.0039694089),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0553114059,
((Integer)r_D31_bk_chapter_n > 10) => -0.0311456815,
 -0.0020867815);

// Tree: 50 
b_final_score_50 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 84500) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 67.15) => 0.0750842054,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 67.15) => -0.0082514214,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0090680444, 0.0039783300),
   (r_D30_Derog_Count_i > 0.5) => -0.0255911326,
   (r_D30_Derog_Count_i = NULL) => -0.0056345843, -0.0056345843),
(k_estimated_income_d > 84500) => 0.0460162271,
(k_estimated_income_d = NULL) => -0.0023802717, -0.0047179817);

// Tree: 51 
b_final_score_51 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 70500) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 505.5) => -0.0807552573,
      (r_I61_inq_collection_recency_d > 505.5) => 0.0057134472,
      (r_I61_inq_collection_recency_d = NULL) => 0.0028556373, 0.0028556373),
   (r_D33_eviction_count_i > 0.5) => -0.0647347121,
   (r_D33_eviction_count_i = NULL) => -0.0030029528, -0.0030029528),
(k_estimated_income_d > 70500) => 0.0399402042,
(k_estimated_income_d = NULL) => -0.0060088216, -0.0019694897);

// Tree: 52 
b_final_score_52 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 162) => -0.0843762470,
(r_D32_Mos_Since_Crim_LS_d > 162) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 105.85) => 0.0128146502,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 105.85) => -0.0158815342,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 144800) => -0.0176073406,
      (r_L80_Inp_AVM_AutoVal_d > 144800) => 0.0523236459,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0018685780, 0.0025267636), 0.0008688487),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0310327866, -0.0037052562);

// Tree: 53 
b_final_score_53 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 69330) => -0.0415229911,
      (r_A46_Curr_AVM_AutoVal_d > 69330) => 0.0181971619,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0007331708, -0.0004857321),
   (r_E55_College_Ind_d > 0.5) => 0.0400573858,
   (r_E55_College_Ind_d = NULL) => 0.0040829483, 0.0040829483),
(r_L79_adls_per_addr_curr_i > 2.5) => -0.0179929604,
(r_L79_adls_per_addr_curr_i = NULL) => 0.0072782510, -0.0036832366);

// Tree: 54 
b_final_score_54 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 73373) => -0.0351905025,
(r_A46_Curr_AVM_AutoVal_d > 73373) => 0.0044986398,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 78.5) => -0.0326743399,
   (r_C13_max_lres_d > 78.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0846005567,
      (r_I60_inq_hiRiskCred_recency_d > 505.5) => 0.0205097453,
      (r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0155898843, 0.0155898843),
   (r_C13_max_lres_d = NULL) => -0.0101120858, 0.0022668982), -0.0023465741);

// Tree: 55 
b_final_score_55 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0031835215,
   (Fin_Class in ['BAI']) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 0.0400086830,
      (r_L79_adls_per_addr_c6_i > 0.5) => -0.0107505586,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0263728456, 0.0263728456),
   (Fin_Class = '') => 0.0092136443, 0.0092136443),
(r_C14_addrs_15yr_i > 1.5) => -0.0120099198,
(r_C14_addrs_15yr_i = NULL) => -0.0225025690, -0.0059753790);

// Tree: 56 
b_final_score_56 := map(
(NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 0.0204702677,
(r_C14_addrs_15yr_i > 1.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 113994.5) => -0.0365894323,
   (r_A46_Curr_AVM_AutoVal_d > 113994.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 14014.5) => 0.0193900981,
      (r_A49_Curr_AVM_Chg_1yr_i > 14014.5) => -0.0206504419,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0552028313, 0.0133773862),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0020869967, -0.0047113001),
(r_C14_addrs_15yr_i = NULL) => 0.0225323301, 0.0035871193);

// Tree: 57 
b_final_score_57 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0044311055,
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => 0.0144583029,
      (r_C23_inp_addr_occ_index_d > 2) => 0.0984092307,
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0394068433, 0.0394068433),
   (r_D30_Derog_Count_i > 0.5) => -0.0263156325,
   (r_D30_Derog_Count_i = NULL) => 0.0212588274, 0.0212588274),
(r_E55_College_Ind_d = NULL) => 0.0112163136, -0.0014040058);

// Tree: 58 
b_final_score_58 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 69.601) => 0.0749463267,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 69.601) => -0.0094749772,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 
      map(
      (Fin_Class in ['TSP']) => -0.0333204836,
      (Fin_Class in ['BAI','UNK']) => 0.0131846426,
      (Fin_Class = '') => -0.0000786072, -0.0000786072),
   (r_D30_Derog_Count_i > 1.5) => -0.0524759923,
   (r_D30_Derog_Count_i = NULL) => 0.0340087350, -0.0077865820), -0.0063896517);

// Tree: 59 
b_final_score_59 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 295694) => 0.0027762738,
(r_L80_Inp_AVM_AutoVal_d > 295694) => 
   map(
   (Fin_Class in ['TSP','UNK']) => 0.0240959074,
   (Fin_Class in ['BAI']) => 0.0765274192,
   (Fin_Class = '') => 0.0483735334, 0.0483735334),
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 9) => -0.0029230350,
   (r_D31_attr_bankruptcy_recency_d > 9) => 0.0729169124,
   (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0183900676, 0.0011906628), 0.0038170347);

// Tree: 60 
b_final_score_60 := map(
(NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 79.5) => -0.0669021209,
   (r_D33_Eviction_Recency_d > 79.5) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 3.5) => 0.0059270632,
      (r_I60_Inq_Count12_i > 3.5) => -0.0648935991,
      (r_I60_Inq_Count12_i = NULL) => 0.0038101059, 0.0038101059),
   (r_D33_Eviction_Recency_d = NULL) => -0.0011235858, -0.0011235858),
(r_I61_inq_collection_count12_i > 0.5) => -0.0680172397,
(r_I61_inq_collection_count12_i = NULL) => 0.0222144458, -0.0032436563);

// Tree: 61 
b_final_score_61 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.2) => -0.0344368883,
   (r_C12_source_profile_d > 78.2) => 0.0226537797,
   (r_C12_source_profile_d = NULL) => -0.0221994699, -0.0221994699),
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 3.5) => 0.0127891700,
   (r_D30_Derog_Count_i > 3.5) => -0.0724100169,
   (r_D30_Derog_Count_i = NULL) => 0.0084077455, 0.0084077455),
(r_F03_address_match_d = NULL) => 0.0206419369, -0.0020790910);

// Tree: 62 
b_final_score_62 := map(
(Fin_Class in ['TSP']) => -0.0283816882,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0172827365,
      (r_L79_adls_per_addr_curr_i > 2.5) => 0.0007975730,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0114050293, 0.0114050293),
   (r_D33_eviction_count_i > 0.5) => -0.0499685266,
   (r_D33_eviction_count_i = NULL) => 0.0065396285, 0.0065396285),
(Fin_Class = '') => -0.0033455503, -0.0033455503);

// Tree: 63 
b_final_score_63 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0214299304,
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 7405.5) => 0.0202767935,
   (r_A49_Curr_AVM_Chg_1yr_i > 7405.5) => -0.0127653221,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 135243) => -0.0174678890,
      (r_A46_Curr_AVM_AutoVal_d > 135243) => 0.0622964202,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0035579649, 0.0053465170), 0.0050041248),
(r_F03_address_match_d = NULL) => 0.0585801261, -0.0029610753);

// Tree: 64 
b_final_score_64 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 384.5) => 0.0087945633,
      (r_C10_M_Hdr_FS_d > 384.5) => 0.0530553607,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0103351472, 0.0103351472),
   (r_L79_adls_per_addr_curr_i > 5.5) => -0.0492256885,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0078025853, 0.0078025853),
(r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0245399059,
(r_C18_invalid_addrs_per_adl_i = NULL) => -0.0294888039, 0.0022864003);

// Tree: 65 
b_final_score_65 := map(
(NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => -0.0009251117,
   (r_L79_adls_per_addr_curr_i > 5.5) => -0.0386932075,
   (r_L79_adls_per_addr_curr_i = NULL) => -0.0025144966, -0.0025144966),
(r_E57_br_source_count_d > 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 165760.5) => 0.0186801530,
   (r_L80_Inp_AVM_AutoVal_d > 165760.5) => 0.0671633228,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0056825641, 0.0241140298),
(r_E57_br_source_count_d = NULL) => 0.0163699142, 0.0000638672);

// Tree: 66 
b_final_score_66 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0151676424,
   (r_D30_Derog_Count_i > 0.5) => -0.0335032041,
   (r_D30_Derog_Count_i = NULL) => 0.0007145106, 0.0007145106),
(r_C18_invalid_addrs_per_adl_i > 0.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 30) => -0.0207568096,
   (r_D31_attr_bankruptcy_recency_d > 30) => 0.0350392994,
   (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0163710034, -0.0163710034),
(r_C18_invalid_addrs_per_adl_i = NULL) => 0.0142507645, -0.0066376014);

// Tree: 67 
b_final_score_67 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0117893730,
   (r_S66_adlperssn_count_i > 1.5) => -0.0152899487,
   (r_S66_adlperssn_count_i = NULL) => 0.0065124140, 0.0001031574),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0940430456,
   (r_D30_Derog_Count_i > 1.5) => -0.0010536497,
   (r_D30_Derog_Count_i = NULL) => 0.0527555124, 0.0527555124),
((Integer)r_D31_bk_chapter_n > 10) => -0.0207874533,
 0.0019139697);

// Tree: 68 
b_final_score_68 := map(
(Fin_Class in ['TSP','UNK']) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 47500) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0180221674,
      (r_C23_inp_addr_occ_index_d > 4.5) => 0.0767441224,
      (r_C23_inp_addr_occ_index_d = NULL) => -0.0136670470, -0.0136670470),
   (k_estimated_income_d > 47500) => 0.0409323793,
   (k_estimated_income_d = NULL) => -0.0154949090, -0.0111720425),
(Fin_Class in ['BAI']) => 0.0106805743,
(Fin_Class = '') => -0.0023814813, -0.0023814813);

// Tree: 69 
b_final_score_69 := map(
(NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0026741603,
   (r_C23_inp_addr_occ_index_d > 4.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 297.5) => -0.0385577240,
      (r_C10_M_Hdr_FS_d > 297.5) => 0.0780953772,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0227274198, 0.0227274198),
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0014791993, -0.0014791993),
(r_I60_inq_auto_count12_i > 1.5) => -0.0826777496,
(r_I60_inq_auto_count12_i = NULL) => 0.0017038424, -0.0035985123);

// Tree: 70 
b_final_score_70 := map(
(NULL < (Integer)k_nap_lname_verd_d and (Integer)k_nap_lname_verd_d <= 0.5) => -0.0069277269,
((Integer)k_nap_lname_verd_d > 0.5) => 
   map(
   (NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 0.5) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => -0.0249465739,
      (r_F03_address_match_d > 3) => 0.0311118149,
      (r_F03_address_match_d = NULL) => 0.0212020849, 0.0212020849),
   (r_D31_MostRec_Bk_i > 0.5) => -0.0487750635,
   (r_D31_MostRec_Bk_i = NULL) => 0.0158928139, 0.0158928139),
((Integer)k_nap_lname_verd_d = NULL) => -0.0015639713, -0.0015639713);

// Tree: 71 
b_final_score_71 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 183285) => 0.0086207862,
      (r_L80_Inp_AVM_AutoVal_d > 183285) => 0.0386692225,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0065423512, 0.0107551330),
   (r_L79_adls_per_addr_curr_i > 3.5) => -0.0202071860,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0048316440, 0.0048316440),
(r_D30_Derog_Count_i > 0.5) => -0.0226463309,
(r_D30_Derog_Count_i = NULL) => 0.0087458146, -0.0038131166);

// Tree: 72 
b_final_score_72 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 77500) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 505.5) => -0.0830731737,
   (r_I61_inq_collection_recency_d > 505.5) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 0.0057370309,
      (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0233157307,
      (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0018195777, 0.0018195777),
   (r_I61_inq_collection_recency_d = NULL) => -0.0012924934, -0.0012924934),
(k_estimated_income_d > 77500) => 0.0556465287,
(k_estimated_income_d = NULL) => 0.0151605004, 0.0002454936);

// Tree: 73 
b_final_score_73 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 439.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0178988913,
      (r_F03_address_match_d > 3.5) => 0.0136740171,
      (r_F03_address_match_d = NULL) => 0.0000496387, 0.0000496387),
   (r_L79_adls_per_addr_curr_i > 2.5) => -0.0081266937,
   (r_L79_adls_per_addr_curr_i = NULL) => -0.0028989785, -0.0028989785),
(r_C13_max_lres_d > 439.5) => 0.0401173212,
(r_C13_max_lres_d = NULL) => -0.0691575361, -0.0036660132);

// Tree: 74 
b_final_score_74 := map(
(NULL < r_D32_Mos_Since_Crim_LS_d and r_D32_Mos_Since_Crim_LS_d <= 162) => -0.0899441813,
(r_D32_Mos_Since_Crim_LS_d > 162) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 88669.5) => -0.0162538796,
      (r_A46_Curr_AVM_AutoVal_d > 88669.5) => 0.0173568517,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0098478239, 0.0071846224),
   (r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0629744786,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0037477537, 0.0037477537),
(r_D32_Mos_Since_Crim_LS_d = NULL) => 0.0191041202, -0.0020750038);

// Tree: 75 
b_final_score_75 := map(
(NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 1.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 20892.5) => 0.0016146583,
   (r_A49_Curr_AVM_Chg_1yr_i > 20892.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => -0.0027345038,
      (r_L79_adls_per_addr_c6_i > 0.5) => -0.0972464846,
      (r_L79_adls_per_addr_c6_i = NULL) => -0.0316329040, -0.0316329040),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0111146057, 0.0036451997),
(r_C14_addrs_5yr_i > 1.5) => -0.0283253951,
(r_C14_addrs_5yr_i = NULL) => 0.0045355620, -0.0055336086);

// Tree: 76 
b_final_score_76 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 61) => 0.0678560798,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 61) => -0.0085852120,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 254.5) => -0.0028012122,
      (r_C13_Curr_Addr_LRes_d > 254.5) => 0.0611317044,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0183051217, -0.0011066686), -0.0024206788),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0287260472,
((Integer)r_D31_bk_chapter_n > 10) => -0.0351254377,
 -0.0019100340);

// Tree: 77 
b_final_score_77 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0211592713,
   (r_C18_invalid_addrs_per_adl_i > 0.5) => -0.0032040815,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0102207852, 0.0102207852),
(r_S66_adlperssn_count_i > 1.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 0.5) => -0.0249522811,
   (r_D31_attr_bankruptcy_recency_d > 0.5) => 0.0391980580,
   (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0196956524, -0.0196956524),
(r_S66_adlperssn_count_i = NULL) => -0.0055201141, -0.0037729199);

// Tree: 78 
b_final_score_78 := map(
(Fin_Class in ['TSP']) => -0.0365396413,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 2.5) => 0.0125129790,
      (r_I60_Inq_Count12_i > 2.5) => -0.0573944551,
      (r_I60_Inq_Count12_i = NULL) => 0.0088932321, 0.0088932321),
   (r_D33_eviction_count_i > 0.5) => -0.0746591463,
   (r_D33_eviction_count_i = NULL) => 0.0021803802, 0.0021803802),
(Fin_Class = '') => -0.0086688870, -0.0086688870);

// Tree: 79 
b_final_score_79 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0611909188,
(r_I60_inq_hiRiskCred_recency_d > 505.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
      map(
			      (r_D31_bk_chapter_n = '') => 0.0060304791,
      (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0409818372,
      ((Integer)r_D31_bk_chapter_n > 10) => 0.0019200750,
 0.0073978234),
   (r_I60_Inq_Count12_i > 0.5) => -0.0191132569,
   (r_I60_Inq_Count12_i = NULL) => 0.0033430268, 0.0033430268),
(r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0350988532, -0.0006165636);

// Tree: 80 
b_final_score_80 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 70.3) => 0.0596201829,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 70.3) => -0.0032115657,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 166103.5) => -0.0295292923,
   (r_L80_Inp_AVM_AutoVal_d > 166103.5) => 
      map(
      (NULL < r_L78_No_Phone_At_Addr_Vel_i and r_L78_No_Phone_At_Addr_Vel_i <= 0.5) => 0.0934823230,
      (r_L78_No_Phone_At_Addr_Vel_i > 0.5) => -0.0035016632,
      (r_L78_No_Phone_At_Addr_Vel_i = NULL) => 0.0447804079, 0.0447804079),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0021460968, -0.0042424322), -0.0021649540);

// Tree: 81 
b_final_score_81 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0136249259,
(r_S66_adlperssn_count_i > 1.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 119.5) => -0.0195761481,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 119.5) => -0.0794458261,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0030757731, -0.0137905187),
(r_S66_adlperssn_count_i = NULL) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => -0.0446102344,
   (r_C12_Num_NonDerogs_d > 2.5) => 0.0565583782,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0141438389, -0.0085351793), 0.0005727522);

// Tree: 82 
b_final_score_82 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0227534806,
   (r_C23_inp_addr_occ_index_d > 4.5) => 0.0318301242,
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0153408923, -0.0153408923),
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 4.5) => 0.0153294372,
   (r_D30_Derog_Count_i > 4.5) => -0.0939631972,
   (r_D30_Derog_Count_i = NULL) => 0.0119735874, 0.0119735874),
(r_F03_address_match_d = NULL) => -0.0000474770, 0.0018210883);

// Tree: 83 
b_final_score_83 := map(
(NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 30) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 80.5) => -0.0053241591,
   (k_comb_age_d > 80.5) => 0.0393541021,
   (k_comb_age_d = NULL) => -0.0306825242, -0.0052100252),
(r_D31_attr_bankruptcy_recency_d > 30) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 2.5) => 0.0713258556,
   (r_C14_addrs_15yr_i > 2.5) => 0.0052677198,
   (r_C14_addrs_15yr_i = NULL) => 0.0302459524, 0.0302459524),
(r_D31_attr_bankruptcy_recency_d = NULL) => 0.0092926538, -0.0030038866);

// Tree: 84 
b_final_score_84 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 66.5) => 0.0444265251,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 66.5) => -0.0076807091,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0100979172, 0.0044238563),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 40.5) => -0.0149363502,
   (k_comb_age_d > 40.5) => 0.0682399009,
   (k_comb_age_d = NULL) => 0.0367009507, 0.0367009507),
((Integer)r_D31_bk_chapter_n > 10) => -0.0248426151,
 0.0050878564);

// Tree: 85 
b_final_score_85 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 67500) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 77.5) => 0.0313201324,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 77.5) => -0.0110650930,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 261.5) => -0.0073073843,
      (r_C13_Curr_Addr_LRes_d > 261.5) => 0.0279707874,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0058019710, -0.0058019710), -0.0061652166),
(k_estimated_income_d > 67500) => 0.0264300078,
(k_estimated_income_d = NULL) => -0.0325750433, -0.0057697576);

// Tree: 86 
b_final_score_86 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 41179) => 0.0072684495,
(r_A49_Curr_AVM_Chg_1yr_i > 41179) => -0.0392863617,
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 30500) => -0.0013864040,
      (k_estimated_income_d > 30500) => 0.0263711667,
      (k_estimated_income_d = NULL) => 0.0045723031, 0.0045723031),
   (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0276294456,
   (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0069828306, -0.0003473857), 0.0011005996);

// Tree: 87 
b_final_score_87 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 0.0104440533,
(r_L79_adls_per_addr_c6_i > 0.5) => 
   map(
   (Fin_Class in ['BAI']) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 11817) => -0.0567421424,
      (r_A49_Curr_AVM_Chg_1yr_i > 11817) => -0.0576148622,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0165183805, -0.0318311456),
   (Fin_Class in ['TSP','UNK']) => -0.0087240841,
   (Fin_Class = '') => -0.0175690948, -0.0175690948),
(r_L79_adls_per_addr_c6_i = NULL) => 0.0005666372, 0.0005666372);

// Tree: 88 
b_final_score_88 := map(
(Client_Type in ['F','G']) => -0.0098502122,
(Client_Type in ['P']) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
      map(
      (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 5.5) => -0.0068054825,
      (r_C14_Addr_Stability_v2_d > 5.5) => 0.0133208348,
      (r_C14_Addr_Stability_v2_d = NULL) => 0.0030927063, 0.0030927063),
   (r_E55_College_Ind_d > 0.5) => 0.0685232917,
   (r_E55_College_Ind_d = NULL) => 0.0100228998, 0.0100228998),
(Client_Type = '') => -0.0054329081, -0.0054329081);

// Tree: 89 
b_final_score_89 := map(
(NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 0.0064523897,
   (r_F03_input_add_not_most_rec_i > 0.5) => -0.0196492330,
   (r_F03_input_add_not_most_rec_i = NULL) => 0.0022073006, 0.0022073006),
(r_C23_inp_addr_occ_index_d > 4.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0965898652,
   (r_S66_adlperssn_count_i > 1.5) => -0.0133864866,
   (r_S66_adlperssn_count_i = NULL) => 0.0445580429, 0.0445580429),
(r_C23_inp_addr_occ_index_d = NULL) => -0.0603242977, 0.0019088154);

// Tree: 90 
b_final_score_90 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 
   map(
   (Client_Type in ['F']) => -0.0060454319,
   (Client_Type in ['G','P']) => 0.0242466125,
   (Client_Type = '') => 0.0000736526, 0.0000736526),
(r_C18_invalid_addrs_per_adl_i > 2.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => -0.0334969614,
   (r_C23_inp_addr_occ_index_d > 3.5) => 0.0484705205,
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0208320229, -0.0208320229),
(r_C18_invalid_addrs_per_adl_i = NULL) => 0.0154887907, -0.0022341088);

// Tree: 91 
b_final_score_91 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 65) => -0.0303270285,
      (r_F01_inp_addr_address_score_d > 65) => 0.0072064964,
      (r_F01_inp_addr_address_score_d = NULL) => -0.0010195923, -0.0010195923),
   (r_C23_inp_addr_occ_index_d > 4.5) => 0.0572714963,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0029220678, 0.0029220678),
(r_L79_adls_per_addr_curr_i > 2.5) => -0.0154917980,
(r_L79_adls_per_addr_curr_i = NULL) => 0.0435912404, -0.0024590376);

// Tree: 92 
b_final_score_92 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 
      map(
      (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 0.0038934988,
      (r_E55_College_Ind_d > 0.5) => 0.0538924590,
      (r_E55_College_Ind_d = NULL) => 0.0092619499, 0.0092619499),
   (r_C18_invalid_addrs_per_adl_i > 0.5) => -0.0066209794,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0018115050, 0.0018115050),
(r_I60_Inq_Count12_i > 1.5) => -0.0521931725,
(r_I60_Inq_Count12_i = NULL) => 0.0003796557, -0.0024942746);

// Tree: 93 
b_final_score_93 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 74201) => -0.0208239413,
(r_A46_Curr_AVM_AutoVal_d > 74201) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 150.35) => 0.0055940776,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 150.35) => -0.0492070967,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => -0.0016495553,
      (r_A44_curr_add_naprop_d > 1.5) => 0.0874916421,
      (r_A44_curr_add_naprop_d = NULL) => 0.0285473273, 0.0285473273), 0.0070574313),
(r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0123498644, -0.0072874991);

// Tree: 94 
b_final_score_94 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0625433654,
(r_I60_inq_hiRiskCred_recency_d > 505.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => -0.0207845512,
   (r_F01_inp_addr_address_score_d > 75) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0135859841,
      (r_L79_adls_per_addr_curr_i > 2.5) => -0.0067602938,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0053308044, 0.0053308044),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0575588802, -0.0010835469),
(r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0042025771, -0.0038459347);

// Tree: 95 
b_final_score_95 := map(
(NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 75) => -0.0353932018,
   (r_F01_inp_addr_address_score_d > 75) => -0.0005439439,
   (r_F01_inp_addr_address_score_d = NULL) => -0.0069248805, -0.0069248805),
(r_C23_inp_addr_occ_index_d > 4.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.1076841492,
   (r_S66_adlperssn_count_i > 1.5) => -0.0025203199,
   (r_S66_adlperssn_count_i = NULL) => 0.0461842769, 0.0461842769),
(r_C23_inp_addr_occ_index_d = NULL) => -0.0157337136, -0.0048583404);

// Tree: 96 
b_final_score_96 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 62795.5) => -0.0244682453,
   (r_L80_Inp_AVM_AutoVal_d > 62795.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0188408343,
      (r_D30_Derog_Count_i > 0.5) => -0.0323176844,
      (r_D30_Derog_Count_i = NULL) => 0.0040203371, 0.0040203371),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0023537436, -0.0026608568),
(r_L79_adls_per_addr_c6_i > 2.5) => -0.0595533503,
(r_L79_adls_per_addr_c6_i = NULL) => -0.0049611170, -0.0049611170);

// Tree: 97 
b_final_score_97 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 64.8) => 0.0458491323,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 64.8) => -0.0067425249,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3.5) => -0.0032497617,
      (r_A44_curr_add_naprop_d > 3.5) => 0.0180183988,
      (r_A44_curr_add_naprop_d = NULL) => -0.0006773856, -0.0006773856),
   (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0279316955,
   (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0093327007, -0.0048362061), -0.0042708081);

// Tree: 98 
b_final_score_98 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 1.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 73281) => -0.0199244421,
   (r_A46_Curr_AVM_AutoVal_d > 73281) => 0.0129977682,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0095176879, -0.0035407394),
(r_C18_invalid_addrs_per_adl_i > 1.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 6553) => -0.0164984028,
   (r_A49_Curr_AVM_Chg_1yr_i > 6553) => -0.0492316898,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0030638124, -0.0146503775),
(r_C18_invalid_addrs_per_adl_i = NULL) => 0.0335734037, -0.0053857939);

// Tree: 99 
b_final_score_99 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 2.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 20439.5) => 0.0054443153,
   (r_A49_Curr_AVM_Chg_1yr_i > 20439.5) => -0.0215416724,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 35500) => -0.0010301189,
      (k_estimated_income_d > 35500) => 0.0306577868,
      (k_estimated_income_d = NULL) => 0.0020515414, 0.0020515414), 0.0011461447),
(r_I60_Inq_Count12_i > 2.5) => -0.0742465950,
(r_I60_Inq_Count12_i = NULL) => 0.0395004812, -0.0015050132);

// Tree: 100 
b_final_score_100 := map(
(Client_Type in ['F']) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 99.15) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 78.15) => 0.0003495254,
      (r_C12_source_profile_d > 78.15) => 0.0672105761,
      (r_C12_source_profile_d = NULL) => 0.0170647881, 0.0170647881),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 99.15) => -0.0152724155,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0100874473, -0.0078650325),
(Client_Type in ['G','P']) => 0.0158003418,
(Client_Type = '') => -0.0026614445, -0.0026614445);

// Tree: 101 
b_final_score_101 := map(
(Fin_Class in ['TSP','UNK']) => -0.0131149339,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 17270) => 
      map(
      (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 0.0273868534,
      (r_F03_input_add_not_most_rec_i > 0.5) => -0.0535138510,
      (r_F03_input_add_not_most_rec_i = NULL) => 0.0155351579, 0.0155351579),
   (r_A49_Curr_AVM_Chg_1yr_i > 17270) => -0.0250299541,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0106647557, 0.0085813154),
(Fin_Class = '') => -0.0042245608, -0.0042245608);

// Tree: 102 
b_final_score_102 := map(
(NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 299.5) => 0.0044041694,
   (r_C13_Curr_Addr_LRes_d > 299.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 86104.5) => -0.0031283723,
      (r_A46_Curr_AVM_AutoVal_d > 86104.5) => 0.0115040458,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0042235256, 0.0042235256),
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0043955805, 0.0043955805),
(r_I61_inq_collection_count12_i > 0.5) => -0.0754145355,
(r_I61_inq_collection_count12_i = NULL) => -0.0176414008, 0.0009772873);

// Tree: 103 
b_final_score_103 := map(
(NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 30) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0038316929,
   (r_L79_adls_per_addr_curr_i > 2.5) => -0.0092684490,
   (r_L79_adls_per_addr_curr_i = NULL) => -0.0008400824, -0.0008400824),
(r_D31_attr_bankruptcy_recency_d > 30) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 40.5) => -0.0086242803,
   (k_comb_age_d > 40.5) => 0.0397781312,
   (k_comb_age_d = NULL) => 0.0237331329, 0.0237331329),
(r_D31_attr_bankruptcy_recency_d = NULL) => -0.0045876041, 0.0004869841);

// Tree: 104 
b_final_score_104 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 397) => 
   map(
   (NULL < r_I60_inq_comm_recency_d and r_I60_inq_comm_recency_d <= 9) => -0.0790029948,
   (r_I60_inq_comm_recency_d > 9) => 
      map(
			      (r_D31_bk_chapter_n = '') => -0.0015808576,
      (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0222109900,
      ((Integer)r_D31_bk_chapter_n > 10) => 0.0116997227,
 -0.0001711540),
   (r_I60_inq_comm_recency_d = NULL) => -0.0018777551, -0.0018777551),
(r_C21_M_Bureau_ADL_FS_d > 397) => 0.0526318396,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0100736142, -0.0006922373);

// Tree: 105 
b_final_score_105 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (Client_Type in ['F']) => -0.0024258734,
   (Client_Type in ['G','P']) => 0.0163402152,
   (Client_Type = '') => 0.0017092462, 0.0017092462),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 67.65) => -0.0148990616,
   (r_C12_source_profile_d > 67.65) => 0.0709250448,
   (r_C12_source_profile_d = NULL) => 0.0312662519, 0.0312662519),
((Integer)r_D31_bk_chapter_n > 10) => 0.0006844796,
 0.0029875342);

// Tree: 106 
b_final_score_106 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 2.5) => -0.0345006338,
   (r_C13_Curr_Addr_LRes_d > 2.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => -0.0005591396,
      (r_S66_adlperssn_count_i > 3.5) => -0.0462824878,
      (r_S66_adlperssn_count_i = NULL) => 0.0129832495, -0.0015213120),
   (r_C13_Curr_Addr_LRes_d = NULL) => -0.0035246439, -0.0035246439),
(r_E55_College_Ind_d > 0.5) => 0.0222511303,
(r_E55_College_Ind_d = NULL) => 0.0414524558, 0.0003309246);

// Tree: 107 
b_final_score_107 := map(
(NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.05) => -0.0040758836,
(r_C12_source_profile_d > 81.05) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 162201.5) => -0.0039786031,
   (r_L80_Inp_AVM_AutoVal_d > 162201.5) => 0.0120290494,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 0.0600817926,
      (r_C18_invalid_addrs_per_adl_i > 2.5) => 0.0034282740,
      (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0425569709, 0.0425569709), 0.0211500306),
(r_C12_source_profile_d = NULL) => 0.0431265097, 0.0004109430);

// Tree: 108 
b_final_score_108 := map(
(NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 286931.5) => -0.0037993958,
   (r_A46_Curr_AVM_AutoVal_d > 286931.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 143) => -0.0061646254,
      (r_C13_max_lres_d > 143) => 0.0412361932,
      (r_C13_max_lres_d = NULL) => 0.0183530394, 0.0183530394),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0043265175, 0.0013248198),
(r_I61_inq_collection_count12_i > 0.5) => -0.0722182829,
(r_I61_inq_collection_count12_i = NULL) => 0.0057446623, -0.0011963618);

// Tree: 109 
b_final_score_109 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 25945.5) => -0.0748056803,
(r_L80_Inp_AVM_AutoVal_d > 25945.5) => -0.0010296160,
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 4.5) => -0.0093126857,
   (r_D31_attr_bankruptcy_recency_d > 4.5) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 71.35) => 0.0094937886,
      (r_C12_source_profile_d > 71.35) => 0.1022862706,
      (r_C12_source_profile_d = NULL) => 0.0565141943, 0.0565141943),
   (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0255130936, -0.0054117550), -0.0053901279);

// Tree: 110 
b_final_score_110 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
   map(
   (NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 0.0080765546,
   (r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => -0.0331409967,
   (r_F00_Addr_Not_Ver_w_SSN_i = NULL) => -0.0004566637, -0.0004566637),
(r_S66_adlperssn_count_i > 1.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => -0.0194752658,
   (r_E57_br_source_count_d > 0.5) => 0.0244445688,
   (r_E57_br_source_count_d = NULL) => -0.0157644464, -0.0157644464),
(r_S66_adlperssn_count_i = NULL) => -0.0137924897, -0.0078640555);

// Tree: 111 
b_final_score_111 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 19898.5) => 
   map(
   (Client_Type in ['P']) => -0.0270737994,
   (Client_Type in ['F','G']) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => -0.0166588338,
      (r_A44_curr_add_naprop_d > 2.5) => 0.0216263481,
      (r_A44_curr_add_naprop_d = NULL) => 0.0042451863, 0.0042451863),
   (Client_Type = '') => -0.0032009469, -0.0032009469),
(r_A49_Curr_AVM_Chg_1yr_i > 19898.5) => -0.0284692392,
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0069673943, 0.0008753407);

// Tree: 112 
b_final_score_112 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 4.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -22525) => 0.0328644723,
   (r_A49_Curr_AVM_Chg_1yr_i > -22525) => 0.0000091565,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 196250) => -0.0163776568,
      (r_L80_Inp_AVM_AutoVal_d > 196250) => 0.0346326735,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0012384402, -0.0028724788), -0.0006580545),
(r_L79_adls_per_addr_curr_i > 4.5) => -0.0338624813,
(r_L79_adls_per_addr_curr_i = NULL) => 0.0522918120, -0.0018578464);

// Tree: 113 
b_final_score_113 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 279615.5) => -0.0379208563,
   (r_A46_Curr_AVM_AutoVal_d > 279615.5) => 0.0483239467,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0197585555, -0.0230780590),
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0190486269,
   (r_C18_invalid_addrs_per_adl_i > 0.5) => -0.0080859797,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0059046404, 0.0059046404),
(r_F03_address_match_d = NULL) => -0.0274776592, -0.0054081806);

// Tree: 114 
b_final_score_114 := map(
(Fin_Class in ['TSP','UNK']) => -0.0063454836,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 346.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0067444662,
      (r_S66_adlperssn_count_i > 1.5) => -0.0003318075,
      (r_S66_adlperssn_count_i = NULL) => 0.0592180461, 0.0060018256),
   (r_C13_max_lres_d > 346.5) => 0.0412587990,
   (r_C13_max_lres_d = NULL) => 0.0085079756, 0.0085079756),
(Fin_Class = '') => -0.0003894053, -0.0003894053);

// Tree: 115 
b_final_score_115 := map(
(Client_Type in ['F','G']) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => -0.0067279924,
   (k_comb_age_d > 73.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 152) => 0.0123787087,
      (r_C13_Curr_Addr_LRes_d > 152) => 0.0365977171,
      (r_C13_Curr_Addr_LRes_d = NULL) => 0.0246654251, 0.0246654251),
   (k_comb_age_d = NULL) => -0.0144003351, -0.0058217520),
(Client_Type in ['P']) => 0.0112311659,
(Client_Type = '') => -0.0021510346, -0.0021510346);

// Tree: 116 
b_final_score_116 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0048072723,
(r_S66_adlperssn_count_i > 1.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => -0.0155776134,
   (r_E57_br_source_count_d > 0.5) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 3.5) => -0.0221971705,
      (r_A44_curr_add_naprop_d > 3.5) => 0.0611663563,
      (r_A44_curr_add_naprop_d = NULL) => 0.0168240548, 0.0168240548),
   (r_E57_br_source_count_d = NULL) => -0.0126868040, -0.0126868040),
(r_S66_adlperssn_count_i = NULL) => -0.0199483920, -0.0045524304);

// Tree: 117 
b_final_score_117 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 5.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0096040767,
   (r_C18_invalid_addrs_per_adl_i > 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 6337) => 0.0003083036,
      (r_A49_Curr_AVM_Chg_1yr_i > 6337) => -0.0276309647,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0010452532, -0.0045781646),
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0029099237, 0.0029099237),
(r_L79_adls_per_addr_curr_i > 5.5) => -0.0571956527,
(r_L79_adls_per_addr_curr_i = NULL) => -0.0181184465, 0.0001734079);

// Tree: 118 
b_final_score_118 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 83014.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 324.5) => -0.0338791304,
   (r_C10_M_Hdr_FS_d > 324.5) => 0.0239314847,
   (r_C10_M_Hdr_FS_d = NULL) => -0.0161374402, -0.0161374402),
(r_A46_Curr_AVM_AutoVal_d > 83014.5) => 0.0109896677,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 113603.5) => -0.0236748268,
   (r_L80_Inp_AVM_AutoVal_d > 113603.5) => 0.0529373416,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0009715787, 0.0007369720), 0.0010167960);

// Tree: 119 
b_final_score_119 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 31430) => -0.0417998656,
(r_A46_Curr_AVM_AutoVal_d > 31430) => -0.0032715954,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 3.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 0.5) => 0.0345678638,
      (r_L79_adls_per_addr_curr_i > 0.5) => 0.0080415332,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0126411383, 0.0126411383),
   (r_C14_addrs_10yr_i > 3.5) => -0.0206953003,
   (r_C14_addrs_10yr_i = NULL) => 0.0341684083, 0.0054985423), -0.0005134022);

// Tree: 120 
b_final_score_120 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 9) => -0.0920053453,
(r_I61_inq_collection_recency_d > 9) => 
   map(
   (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 15.5) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => -0.0184880903,
      (r_A44_curr_add_naprop_d > 2.5) => 0.0527866613,
      (r_A44_curr_add_naprop_d = NULL) => -0.0099920992, -0.0099920992),
   (r_C13_Curr_Addr_LRes_d > 15.5) => 0.0085384286,
   (r_C13_Curr_Addr_LRes_d = NULL) => 0.0042079416, 0.0042079416),
(r_I61_inq_collection_recency_d = NULL) => -0.0292191586, 0.0017058429);

// Tree: 121 
b_final_score_121 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0010581552,
   (r_C23_inp_addr_occ_index_d > 4.5) => 
      map(
      (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => -0.0147012574,
      (r_F04_curr_add_occ_index_d > 2) => 0.0867824279,
      (r_F04_curr_add_occ_index_d = NULL) => 0.0299818578, 0.0299818578),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0006763641, 0.0003565044),
(r_L79_adls_per_addr_c6_i > 3.5) => -0.0885700327,
(r_L79_adls_per_addr_c6_i = NULL) => -0.0013367877, -0.0013367877);

// Tree: 122 
b_final_score_122 := map(
(Client_Type in ['F','G']) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => 0.0031760634,
   (r_S66_adlperssn_count_i > 3.5) => -0.0532173919,
   (r_S66_adlperssn_count_i = NULL) => 0.0001990314, 0.0009055481),
(Client_Type in ['P']) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => -0.0166475334,
   (r_C12_Num_NonDerogs_d > 1.5) => 0.0237629406,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0152684312, 0.0152684312),
(Client_Type = '') => 0.0039765970, 0.0039765970);

// Tree: 123 
b_final_score_123 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 40083) => -0.0463990448,
(r_A46_Curr_AVM_AutoVal_d > 40083) => 0.0037950282,
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 42500) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 0.5) => 0.0025195309,
      (r_L79_adls_per_addr_curr_i > 0.5) => -0.0112578322,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0086544174, -0.0086544174),
   (k_estimated_income_d > 42500) => 0.0395804818,
   (k_estimated_income_d = NULL) => 0.0119660082, -0.0058152794), -0.0042161027);

// Tree: 124 
b_final_score_124 := map(
(Fin_Class in ['TSP','UNK']) => -0.0032463018,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 2.5) => -0.0055897721,
      (r_F03_address_match_d > 2.5) => 0.0292136413,
      (r_F03_address_match_d = NULL) => 0.0189773433, 0.0189773433),
   (r_S66_adlperssn_count_i > 1.5) => -0.0016982507,
   (r_S66_adlperssn_count_i = NULL) => 0.0475879308, 0.0112109127),
(Fin_Class = '') => 0.0025762624, 0.0025762624);

// Tree: 125 
b_final_score_125 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 2.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 1.5) => 0.0044327791,
   (r_C18_invalid_addrs_per_adl_i > 1.5) => -0.0143526282,
   (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0003117968, -0.0003117968),
(r_D30_Derog_Count_i > 2.5) => 
   map(
   (NULL < r_D31_MostRec_Bk_i and r_D31_MostRec_Bk_i <= 0.5) => -0.0460912120,
   (r_D31_MostRec_Bk_i > 0.5) => -0.0979021891,
   (r_D31_MostRec_Bk_i = NULL) => -0.0573833480, -0.0573833480),
(r_D30_Derog_Count_i = NULL) => -0.0803959972, -0.0074564244);

// Final Score Sum 

   b_final_score := sum(
      b_final_score_0, b_final_score_1, b_final_score_2, b_final_score_3, b_final_score_4, 
      b_final_score_5, b_final_score_6, b_final_score_7, b_final_score_8, b_final_score_9, 
      b_final_score_10, b_final_score_11, b_final_score_12, b_final_score_13, b_final_score_14, 
      b_final_score_15, b_final_score_16, b_final_score_17, b_final_score_18, b_final_score_19, 
      b_final_score_20, b_final_score_21, b_final_score_22, b_final_score_23, b_final_score_24, 
      b_final_score_25, b_final_score_26, b_final_score_27, b_final_score_28, b_final_score_29, 
      b_final_score_30, b_final_score_31, b_final_score_32, b_final_score_33, b_final_score_34, 
      b_final_score_35, b_final_score_36, b_final_score_37, b_final_score_38, b_final_score_39, 
      b_final_score_40, b_final_score_41, b_final_score_42, b_final_score_43, b_final_score_44, 
      b_final_score_45, b_final_score_46, b_final_score_47, b_final_score_48, b_final_score_49, 
      b_final_score_50, b_final_score_51, b_final_score_52, b_final_score_53, b_final_score_54, 
      b_final_score_55, b_final_score_56, b_final_score_57, b_final_score_58, b_final_score_59, 
      b_final_score_60, b_final_score_61, b_final_score_62, b_final_score_63, b_final_score_64, 
      b_final_score_65, b_final_score_66, b_final_score_67, b_final_score_68, b_final_score_69, 
      b_final_score_70, b_final_score_71, b_final_score_72, b_final_score_73, b_final_score_74, 
      b_final_score_75, b_final_score_76, b_final_score_77, b_final_score_78, b_final_score_79, 
      b_final_score_80, b_final_score_81, b_final_score_82, b_final_score_83, b_final_score_84, 
      b_final_score_85, b_final_score_86, b_final_score_87, b_final_score_88, b_final_score_89, 
      b_final_score_90, b_final_score_91, b_final_score_92, b_final_score_93, b_final_score_94, 
      b_final_score_95, b_final_score_96, b_final_score_97, b_final_score_98, b_final_score_99, 
      b_final_score_100, b_final_score_101, b_final_score_102, b_final_score_103, b_final_score_104, 
      b_final_score_105, b_final_score_106, b_final_score_107, b_final_score_108, b_final_score_109, 
      b_final_score_110, b_final_score_111, b_final_score_112, b_final_score_113, b_final_score_114, 
      b_final_score_115, b_final_score_116, b_final_score_117, b_final_score_118, b_final_score_119, 
      b_final_score_120, b_final_score_121, b_final_score_122, b_final_score_123, b_final_score_124, 
      b_final_score_125);

e_final_score_0 :=  -0.5843849876;

// Tree: 1 
e_final_score_1 := map(
(Fin_Class in ['TSP','UNK']) => -0.1218602487,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 1.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0057158882,
      (r_D30_Derog_Count_i > 0.5) => -0.0861234838,
      (r_D30_Derog_Count_i = NULL) => -0.0190925863, -0.0190925863),
   (r_Prop_Owner_History_d > 1.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 155520) => 0.1112918844,
         (r_L80_Inp_AVM_AutoVal_d > 155520) => 0.1927907218,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.1214638032, 0.1433067927),
      (r_D30_Derog_Count_i > 0.5) => -0.0114597223,
      (r_D30_Derog_Count_i = NULL) => 0.1178675463, 0.1178675463),
   (r_Prop_Owner_History_d = NULL) => -0.0226451707, 0.0549976392),
(Fin_Class = '') => 0.0008994838, 0.0008994838);

// Tree: 2 
e_final_score_2 := map(
(Fin_Class in ['TSP','UNK']) => -0.1148204830,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 33500) => 
      map(
      (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => -0.0356587178,
      (r_A44_curr_add_naprop_d > 2.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0680728848,
         (r_D30_Derog_Count_i > 0.5) => -0.0263327666,
         (r_D30_Derog_Count_i = NULL) => 0.0495780393, 0.0495780393),
      (r_A44_curr_add_naprop_d = NULL) => -0.0007989589, -0.0007989589),
   (k_estimated_income_d > 33500) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.1452742106,
      (r_D30_Derog_Count_i > 0.5) => -0.0026308463,
      (r_D30_Derog_Count_i = NULL) => 0.1245067198, 0.1245067198),
   (k_estimated_income_d = NULL) => 0.0264138987, 0.0455314944),
(Fin_Class = '') => -0.0046929986, -0.0046929986);

// Tree: 3 
e_final_score_3 := map(
(NULL < r_A41_Prop_Owner_Inp_Only_d and r_A41_Prop_Owner_Inp_Only_d <= 0.5) => 
   map(
   (Fin_Class in ['TSP']) => -0.1185029153,
   (Fin_Class in ['BAI','UNK']) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 35500) => -0.0269403173,
      (k_estimated_income_d > 35500) => 0.0709639680,
      (k_estimated_income_d = NULL) => -0.0132200244, -0.0132200244),
   (Fin_Class = '') => -0.0520505257, -0.0520505257),
(r_A41_Prop_Owner_Inp_Only_d > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (Fin_Class in ['TSP']) => -0.0360359289,
      (Fin_Class in ['BAI','UNK']) => 0.1193440036,
      (Fin_Class = '') => 0.1067245958, 0.1067245958),
   (r_D30_Derog_Count_i > 0.5) => -0.0218177831,
   (r_D30_Derog_Count_i = NULL) => 0.0863652789, 0.0863652789),
(r_A41_Prop_Owner_Inp_Only_d = NULL) => -0.0782129400, -0.0033316962);

// Tree: 4 
e_final_score_4 := map(
(Fin_Class in ['TSP','UNK']) => -0.1026930659,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 0.0290162827,
      (r_C14_addrs_15yr_i > 1.5) => -0.0427850053,
      (r_C14_addrs_15yr_i = NULL) => -0.0215246466, -0.0215246466),
   (r_A41_Prop_Owner_d > 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 43500) => 0.0756929938,
         (k_estimated_income_d > 43500) => 0.1420483515,
         (k_estimated_income_d = NULL) => 0.0943225238, 0.0943225238),
      (r_D30_Derog_Count_i > 0.5) => -0.0094263417,
      (r_D30_Derog_Count_i = NULL) => 0.0764818098, 0.0764818098),
   (r_A41_Prop_Owner_d = NULL) => 0.0127102938, 0.0350249530),
(Fin_Class = '') => -0.0079173006, -0.0079173006);

// Tree: 5 
e_final_score_5 := map(
(Fin_Class in ['TSP']) => -0.1043195956,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => 
      map(
      (pat_type in ['E','I']) => -0.0512934425,
      (pat_type in ['NA','O','S']) => 
         map(
         (NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => -0.0151141601,
         (r_Prop_Owner_History_d > 0.5) => 0.0559929483,
         (r_Prop_Owner_History_d = NULL) => 0.0150181847, 0.0150181847),
      (pat_type = '') => -0.0163847103, -0.0163847103),
   (r_A44_curr_add_naprop_d > 1.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 140458) => 0.0227779677,
      (r_L80_Inp_AVM_AutoVal_d > 140458) => 0.1115864491,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0749155622, 0.0746868316),
   (r_A44_curr_add_naprop_d = NULL) => 0.0168510297, 0.0311719867),
(Fin_Class = '') => -0.0073959448, -0.0073959448);

// Tree: 6 
e_final_score_6 := map(
(NULL < r_A41_Prop_Owner_Inp_Only_d and r_A41_Prop_Owner_Inp_Only_d <= 0.5) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.1024629575,
   (Fin_Class in ['BAI']) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0096938760,
      (r_D30_Derog_Count_i > 0.5) => -0.0656930932,
      (r_D30_Derog_Count_i = NULL) => -0.0118608888, -0.0118608888),
   (Fin_Class = '') => -0.0479148752, -0.0479148752),
(r_A41_Prop_Owner_Inp_Only_d > 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 39500) => 
      map(
      (pat_type in ['E','I']) => -0.0084173487,
      (pat_type in ['NA','O','S']) => 0.0633414170,
      (pat_type = '') => 0.0353821263, 0.0353821263),
   (k_estimated_income_d > 39500) => 0.1114542123,
   (k_estimated_income_d = NULL) => 0.0623739407, 0.0623739407),
(r_A41_Prop_Owner_Inp_Only_d = NULL) => -0.0526776025, -0.0093395713);

// Tree: 7 
e_final_score_7 := map(
(NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => 
   map(
   (Fin_Class in ['TSP']) => -0.1073299697,
   (Fin_Class in ['BAI','UNK']) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 159030.5) => -0.0563800633,
      (r_A46_Curr_AVM_AutoVal_d > 159030.5) => 0.0538861998,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0320076322, -0.0254189882),
   (Fin_Class = '') => -0.0608781129, -0.0608781129),
(r_Ever_Asset_Owner_d > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (Fin_Class in ['TSP']) => -0.0335387010,
      (Fin_Class in ['BAI','UNK']) => 0.0728681423,
      (Fin_Class = '') => 0.0614321491, 0.0614321491),
   (r_D30_Derog_Count_i > 0.5) => -0.0249358393,
   (r_D30_Derog_Count_i = NULL) => 0.0433281238, 0.0433281238),
(r_Ever_Asset_Owner_d = NULL) => -0.0463260474, -0.0052593964);

// Tree: 8 
e_final_score_8 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 31500) => 
   map(
   (pat_type in ['E','I']) => -0.0685212663,
   (pat_type in ['NA','O','S']) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0255308193,
      (r_D30_Derog_Count_i > 0.5) => -0.0488452352,
      (r_D30_Derog_Count_i = NULL) => 0.0057374352, 0.0057374352),
   (pat_type = '') => -0.0370156382, -0.0370156382),
(k_estimated_income_d > 31500) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (pat_type in ['E','I']) => 0.0343610440,
      (pat_type in ['NA','O','S']) => 0.0931439795,
      (pat_type = '') => 0.0717217569, 0.0717217569),
   (r_D30_Derog_Count_i > 0.5) => -0.0313574191,
   (r_D30_Derog_Count_i = NULL) => 0.0545527538, 0.0545527538),
(k_estimated_income_d = NULL) => -0.0534781466, -0.0063282282);

// Tree: 9 
e_final_score_9 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 34500) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0890356328,
   (Fin_Class in ['BAI']) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 278.5) => -0.0131307857,
      (r_C13_max_lres_d > 278.5) => 0.0519897800,
      (r_C13_max_lres_d = NULL) => -0.0004014886, -0.0004014886),
   (Fin_Class = '') => -0.0322621234, -0.0322621234),
(k_estimated_income_d > 34500) => 
   map(
   (NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 0.5) => 
      map(
      (pat_type in ['E','I']) => 0.0336999784,
      (pat_type in ['NA','O','S']) => 0.0900042310,
      (pat_type = '') => 0.0696080523, 0.0696080523),
   (r_I60_inq_auto_count12_i > 0.5) => -0.0944386225,
   (r_I60_inq_auto_count12_i = NULL) => 0.0632166234, 0.0632166234),
(k_estimated_income_d = NULL) => -0.0451322767, -0.0080723382);

// Tree: 10 
e_final_score_10 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 33500) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0851051540,
   (Fin_Class in ['BAI']) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0497192345,
         (r_D30_Derog_Count_i > 0.5) => -0.0389216921,
         (r_D30_Derog_Count_i = NULL) => 0.0361910215, 0.0361910215),
      (r_C14_addrs_15yr_i > 1.5) => -0.0265189958,
      (r_C14_addrs_15yr_i = NULL) => -0.0021689122, -0.0021689122),
   (Fin_Class = '') => -0.0327523816, -0.0327523816),
(k_estimated_income_d > 33500) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0740066316,
   (r_D30_Derog_Count_i > 0.5) => -0.0147283555,
   (r_D30_Derog_Count_i = NULL) => 0.0600753073, 0.0600753073),
(k_estimated_income_d = NULL) => -0.0354380377, -0.0069667974);

// Tree: 11 
e_final_score_11 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
   map(
   (pat_type in ['E','I']) => -0.0669630589,
   (pat_type in ['NA','O','S']) => -0.0040254118,
   (pat_type = '') => -0.0414161305, -0.0414161305),
(r_A44_curr_add_naprop_d > 2.5) => 
   map(
   (Fin_Class in ['TSP']) => -0.0491933478,
   (Fin_Class in ['BAI','UNK']) => 
      map(
      (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 104071) => 0.0054027191,
         (r_A46_Curr_AVM_AutoVal_d > 104071) => 0.0667996110,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0571278426, 0.0521147482),
      (r_D34_unrel_liens_ct_i > 0.5) => -0.0446517756,
      (r_D34_unrel_liens_ct_i = NULL) => 0.0443391139, 0.0443391139),
   (Fin_Class = '') => 0.0319686915, 0.0319686915),
(r_A44_curr_add_naprop_d = NULL) => -0.0320010399, -0.0092301151);

// Tree: 12 
e_final_score_12 := map(
(NULL < r_A41_Prop_Owner_d and r_A41_Prop_Owner_d <= 0.5) => 
   map(
   (pat_type in ['E','I']) => -0.0626808861,
   (pat_type in ['NA','O','S']) => -0.0080198002,
   (pat_type = '') => -0.0420871535, -0.0420871535),
(r_A41_Prop_Owner_d > 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 42500) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 24500) => -0.0576794457,
         (k_estimated_income_d > 24500) => 0.0386041048,
         (k_estimated_income_d = NULL) => 0.0321405345, 0.0321405345),
      (r_D30_Derog_Count_i > 0.5) => -0.0294124536,
      (r_D30_Derog_Count_i = NULL) => 0.0181441403, 0.0181441403),
   (k_estimated_income_d > 42500) => 0.0779192609,
   (k_estimated_income_d = NULL) => 0.0337686112, 0.0337686112),
(r_A41_Prop_Owner_d = NULL) => -0.0273050165, -0.0066225997);

// Tree: 13 
e_final_score_13 := map(
(NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 1.5) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0838643144,
   (Fin_Class in ['BAI']) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0674282043,
         (r_I60_inq_recency_d > 505.5) => 0.0148975046,
         (r_I60_inq_recency_d = NULL) => 0.0047224170, 0.0047224170),
      (r_D30_Derog_Count_i > 0.5) => -0.0576622490,
      (r_D30_Derog_Count_i = NULL) => -0.0136272796, -0.0136272796),
   (Fin_Class = '') => -0.0425484116, -0.0425484116),
(r_A44_curr_add_naprop_d > 1.5) => 
   map(
   (pat_type in ['E','I']) => -0.0008546703,
   (pat_type in ['NA','O','S']) => 0.0516043574,
   (pat_type = '') => 0.0308873117, 0.0308873117),
(r_A44_curr_add_naprop_d = NULL) => -0.0321417734, -0.0101310831);

// Tree: 14 
e_final_score_14 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 29500) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => -0.0440824427,
   (k_comb_age_d > 71.5) => 0.0488595977,
   (k_comb_age_d = NULL) => -0.0381072966, -0.0373802565),
(k_estimated_income_d > 29500) => 
   map(
   (pat_type in ['E','I']) => 
      map(
      (Fin_Class in ['TSP']) => -0.0785286684,
      (Fin_Class in ['BAI','UNK']) => 0.0161765759,
      (Fin_Class = '') => -0.0070414840, -0.0070414840),
   (pat_type in ['NA','O','S']) => 
      map(
      (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 0.0628979841,
      (r_D34_unrel_liens_ct_i > 0.5) => -0.0307626314,
      (r_D34_unrel_liens_ct_i = NULL) => 0.0550321142, 0.0550321142),
   (pat_type = '') => 0.0301061875, 0.0301061875),
(k_estimated_income_d = NULL) => -0.0374264583, -0.0093047895);

// Tree: 15 
e_final_score_15 := map(
(Fin_Class in ['TSP']) => -0.0761316875,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 35500) => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 
            map(
            (pat_type in ['E','I']) => -0.0037062669,
            (pat_type in ['NA','O','S']) => 0.0329621781,
            (pat_type = '') => 0.0169164900, 0.0169164900),
         (r_D30_Derog_Count_i > 1.5) => -0.0548568817,
         (r_D30_Derog_Count_i = NULL) => 0.0093881961, 0.0093881961),
      (r_I60_Inq_Count12_i > 0.5) => -0.0523903603,
      (r_I60_Inq_Count12_i = NULL) => 0.0011067793, 0.0011067793),
   (k_estimated_income_d > 35500) => 0.0522984979,
   (k_estimated_income_d = NULL) => 0.0666990842, 0.0172576348),
(Fin_Class = '') => -0.0095774518, -0.0095774518);

// Tree: 16 
e_final_score_16 := map(
(NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 250691) => -0.0501796822,
   (r_A46_Curr_AVM_AutoVal_d > 250691) => 0.0473015937,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0407831434, -0.0396919735),
(r_Prop_Owner_History_d > 0.5) => 
   map(
   (pat_type in ['E','I']) => -0.0003615233,
   (pat_type in ['NA','O','S']) => 
      map(
      (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 
         map(
         (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 0.0525122887,
         (r_I60_Inq_Count12_i > 0.5) => -0.0375386176,
         (r_I60_Inq_Count12_i = NULL) => 0.0478437509, 0.0478437509),
      (r_D34_unrel_liens_ct_i > 0.5) => -0.0234388708,
      (r_D34_unrel_liens_ct_i = NULL) => 0.0409007989, 0.0409007989),
   (pat_type = '') => 0.0242135798, 0.0242135798),
(r_Prop_Owner_History_d = NULL) => -0.0266640589, -0.0059227841);

// Tree: 17 
e_final_score_17 := map(
(NULL < r_wealth_index_d and r_wealth_index_d <= 1) => 
   map(
   (pat_type in ['E','I']) => -0.0505441445,
   (pat_type in ['NA','O','S']) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 82254) => -0.0721680382,
      (r_A46_Curr_AVM_AutoVal_d > 82254) => 0.0281680899,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0039544810, 0.0007327827),
   (pat_type = '') => -0.0300654342, -0.0300654342),
(r_wealth_index_d > 1) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0474104874,
   (r_I60_inq_recency_d > 505.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 187276.5) => 0.0124170459,
      (r_L80_Inp_AVM_AutoVal_d > 187276.5) => 0.0662806059,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0339816489, 0.0349520049),
   (r_I60_inq_recency_d = NULL) => 0.0281062358, 0.0281062358),
(r_wealth_index_d = NULL) => -0.0179116132, -0.0054609043);

// Tree: 18 
e_final_score_18 := map(
(Fin_Class in ['TSP']) => -0.0723284780,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 112096.5) => -0.0004453317,
         (r_A46_Curr_AVM_AutoVal_d > 112096.5) => 0.0468120840,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 
            map(
            (NULL < k_estimated_income_d and k_estimated_income_d <= 37500) => 0.0137930060,
            (k_estimated_income_d > 37500) => 0.0706176656,
            (k_estimated_income_d = NULL) => 0.0230270132, 0.0230270132), 0.0277199113),
      (r_D30_Derog_Count_i > 1.5) => -0.0456776645,
      (r_D30_Derog_Count_i = NULL) => 0.0206582575, 0.0206582575),
   (r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => -0.0376729556,
   (r_F00_Addr_Not_Ver_w_SSN_i = NULL) => 0.0443535169, 0.0152234880),
(Fin_Class = '') => -0.0094246835, -0.0094246835);

// Tree: 19 
e_final_score_19 := map(
(Fin_Class in ['TSP','UNK']) => -0.0603329145,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0465826492,
   (r_I60_inq_recency_d > 505.5) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0103148655,
      (r_F03_address_match_d > 3.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0405066395,
         (r_D30_Derog_Count_i > 0.5) => 
            map(
            (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 30) => -0.0366609685,
            (r_D31_attr_bankruptcy_recency_d > 30) => 0.0623941873,
            (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0059678216, -0.0059678216),
         (r_D30_Derog_Count_i = NULL) => 0.0320281171, 0.0320281171),
      (r_F03_address_match_d = NULL) => 0.0218651999, 0.0218651999),
   (r_I60_inq_recency_d = NULL) => 0.0685667798, 0.0156592759),
(Fin_Class = '') => -0.0079132100, -0.0079132100);

// Tree: 20 
e_final_score_20 := map(
(NULL < r_wealth_index_d and r_wealth_index_d <= 3.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => -0.0016938401,
      (k_nap_fname_verd_d > 0.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0854172185,
         (r_L79_adls_per_addr_curr_i > 2.5) => 0.0111422935,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0560712297, 0.0560712297),
      (k_nap_fname_verd_d = NULL) => 0.0140756376, 0.0140756376),
   (r_C14_addrs_15yr_i > 1.5) => 
      map(
      (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0378189623,
      (r_E55_College_Ind_d > 0.5) => 0.0223216969,
      (r_E55_College_Ind_d = NULL) => -0.0300352708, -0.0300352708),
   (r_C14_addrs_15yr_i = NULL) => -0.0147700374, -0.0147700374),
(r_wealth_index_d > 3.5) => 0.0394705146,
(r_wealth_index_d = NULL) => -0.0131027963, -0.0028023152);

// Tree: 21 
e_final_score_21 := map(
(NULL < r_Prop_Owner_History_d and r_Prop_Owner_History_d <= 0.5) => 
   map(
   (pat_type in ['E','I','S']) => -0.0499177003,
   (pat_type in ['NA','O']) => 0.0004411931,
   (pat_type = '') => -0.0329455167, -0.0329455167),
(r_Prop_Owner_History_d > 0.5) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 505.5) => -0.1120610008,
   (r_I61_inq_collection_recency_d > 505.5) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.0109735504,
      (k_nap_fname_verd_d > 0.5) => 0.0442194326,
      (k_nap_fname_verd_d = NULL) => 0.0214718814, 0.0214718814),
   (r_I61_inq_collection_recency_d = NULL) => 0.0189602046, 0.0189602046),
(r_Prop_Owner_History_d = NULL) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0839475558,
   (Fin_Class in ['BAI']) => 0.0953990314,
   (Fin_Class = '') => -0.0318994203, -0.0318994203), -0.0058471050);

// Tree: 22 
e_final_score_22 := map(
(Fin_Class in ['TSP','UNK']) => -0.0501133804,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => 
         map(
         (NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 
            map(
            (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 0.0232670071,
            (r_I61_inq_collection_count12_i > 0.5) => -0.1009492427,
            (r_I61_inq_collection_count12_i = NULL) => 0.0206881230, 0.0206881230),
         (r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => -0.0195740418,
         (r_F00_Addr_Not_Ver_w_SSN_i = NULL) => 0.0688250857, 0.0186927175),
      (r_D34_UnRel_Lien60_Count_i > 0.5) => -0.0491797573,
      (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0126253464, 0.0126253464),
   (r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.1036453831,
   (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0390503570, 0.0096331922),
(Fin_Class = '') => -0.0089386029, -0.0089386029);

// Tree: 23 
e_final_score_23 := map(
(pat_type in ['E','I']) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
      map(
      (NULL < k_nap_addr_verd_d and k_nap_addr_verd_d <= 0.5) => -0.0122330388,
      (k_nap_addr_verd_d > 0.5) => 0.0486533792,
      (k_nap_addr_verd_d = NULL) => 0.0099489696, 0.0099489696),
   (r_C14_addrs_15yr_i > 1.5) => -0.0375970934,
   (r_C14_addrs_15yr_i = NULL) => -0.0639204166, -0.0254752892),
(pat_type in ['NA','O','S']) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => -0.0336424820,
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 63829) => -0.0281063448,
      (r_A46_Curr_AVM_AutoVal_d > 63829) => 0.0341049797,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0282825053, 0.0259734699),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0460163665, 0.0175787149),
(pat_type = '') => -0.0047974877, -0.0047974877);

// Tree: 24 
e_final_score_24 := map(
(Fin_Class in ['TSP','UNK']) => -0.0498169246,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => -0.0800409317,
   (r_D33_Eviction_Recency_d > 549) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 76852) => -0.0294048890,
      (r_A46_Curr_AVM_AutoVal_d > 76852) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 130.55) => 0.0289585407,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 130.55) => -0.0607648562,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0245656933, 0.0224799509),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 393.5) => 0.0098726831,
         (r_C13_max_lres_d > 393.5) => 0.0952210937,
         (r_C13_max_lres_d = NULL) => 0.0135286233, 0.0135286233), 0.0123487681),
   (r_D33_Eviction_Recency_d = NULL) => 0.0380787165, 0.0087786692),
(Fin_Class = '') => -0.0094416680, -0.0094416680);

// Tree: 25 
e_final_score_25 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 143126.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 58.5) => -0.0324094830,
   (k_comb_age_d > 58.5) => 0.0189124289,
   (k_comb_age_d = NULL) => -0.0471937146, -0.0201129583),
(r_L80_Inp_AVM_AutoVal_d > 143126.5) => 0.0321037703,
(r_L80_Inp_AVM_AutoVal_d = NULL) => 
   map(
   (pat_type in ['E','I']) => -0.0312876857,
   (pat_type in ['NA','O','S']) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 
         map(
         (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0567270014,
         (r_I60_inq_recency_d > 505.5) => 0.0326315799,
         (r_I60_inq_recency_d = NULL) => 0.0248249786, 0.0248249786),
      (r_D30_Derog_Count_i > 1.5) => -0.0596038150,
      (r_D30_Derog_Count_i = NULL) => 0.0196228388, 0.0151777397),
   (pat_type = '') => -0.0102331956, -0.0102331956), -0.0028636920);

// Tree: 26 
e_final_score_26 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 45500) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 61.5) => 0.0056624812,
      (k_comb_age_d > 61.5) => 0.0370377716,
      (k_comb_age_d = NULL) => 0.0168240640, 0.0168240640),
   (r_C14_addrs_15yr_i > 1.5) => 
      map(
      (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0287925434,
      (r_E55_College_Ind_d > 0.5) => 0.0209099506,
      (r_E55_College_Ind_d = NULL) => -0.0220843500, -0.0220843500),
   (r_C14_addrs_15yr_i = NULL) => -0.0085458402, -0.0085458402),
(k_estimated_income_d > 45500) => 0.0486907169,
(k_estimated_income_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 127169) => -0.0607229803,
   (r_L80_Inp_AVM_AutoVal_d > 127169) => 0.1121971868,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0334615818, -0.0079195295), -0.0017706684);

// Tree: 27 
e_final_score_27 := map(
(pat_type in ['E','I']) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 405.5) => -0.0250266615,
   (r_C13_max_lres_d > 405.5) => 0.0650840027,
   (r_C13_max_lres_d = NULL) => -0.0556024997, -0.0241087613),
(pat_type in ['NA','O','S']) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 
      map(
			      (r_D31_bk_chapter_n = '') => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 92761.5) => -0.0240562906,
         (r_L80_Inp_AVM_AutoVal_d > 92761.5) => 0.0315897513,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0193640030, 0.0185305382),
      (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0940410372,
      ((Integer)r_D31_bk_chapter_n > 10) => -0.0473538178,
 0.0206513696),
   (r_D30_Derog_Count_i > 1.5) => -0.0442045019,
   (r_D30_Derog_Count_i = NULL) => 0.0910256131, 0.0160470460),
(pat_type = '') => -0.0045805222, -0.0045805222);

// Tree: 28 
e_final_score_28 := map(
(Fin_Class in ['TSP']) => -0.0520559365,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 69894.5) => -0.0292887931,
      (r_A46_Curr_AVM_AutoVal_d > 69894.5) => 0.0224874743,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0205382041, 0.0168143298),
   (r_D30_Derog_Count_i > 0.5) => 
      map(
			(r_D31_bk_chapter_n = '') => -0.0415028378,
      (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 12) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 2.5) => 0.0645679167,
         (r_D30_Derog_Count_i > 2.5) => -0.0540492439,
         (r_D30_Derog_Count_i = NULL) => 0.0344912007, 0.0344912007),
      ((Integer)r_D31_bk_chapter_n > 12) => -0.0378889844,
       -0.0219422642),
   (r_D30_Derog_Count_i = NULL) => 0.0498825006, 0.0091978931),
(Fin_Class = '') => -0.0081919093, -0.0081919093);

// Tree: 29 
e_final_score_29 := map(
(Fin_Class in ['TSP']) => -0.0417165595,
(Fin_Class in ['BAI','UNK']) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 1.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 2.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
            map(
            (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => 0.0143459348,
            (r_D34_UnRel_Lien60_Count_i > 0.5) => -0.0440023055,
            (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0093005772, 0.0093005772),
         (k_comb_age_d > 68.5) => 0.0420400043,
         (k_comb_age_d = NULL) => 0.0644663925, 0.0154278549),
      (r_S66_adlperssn_count_i > 2.5) => -0.0217487173,
      (r_S66_adlperssn_count_i = NULL) => 0.0447078186, 0.0128888637),
   (r_I60_Inq_Count12_i > 1.5) => -0.0671004719,
   (r_I60_Inq_Count12_i = NULL) => 0.0535888526, 0.0096488196),
(Fin_Class = '') => -0.0049558226, -0.0049558226);

// Tree: 30 
e_final_score_30 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 158008) => -0.0155051465,
(r_A46_Curr_AVM_AutoVal_d > 158008) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 87.9) => 0.1090352500,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 87.9) => 0.0141952505,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0298970221, 0.0219296159),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 76.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 352.5) => 
         map(
         (pat_type in ['E','I','O']) => -0.0254932004,
         (pat_type in ['NA','S']) => 0.0130950425,
         (pat_type = '') => -0.0163223559, -0.0163223559),
      (r_C13_Curr_Addr_LRes_d > 352.5) => 0.0903857192,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0144025704, -0.0144025704),
   (k_comb_age_d > 76.5) => 0.0508703203,
   (k_comb_age_d = NULL) => -0.0177938213, -0.0113844207), -0.0055689526);

// Tree: 31 
e_final_score_31 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0309519125,
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 53.5) => -0.0138785692,
      (k_comb_age_d > 53.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 0.0296993001,
         (r_L79_adls_per_addr_curr_i > 3.5) => -0.0226789412,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0205530996, 0.0205530996),
      (k_comb_age_d = NULL) => 0.0055489983, 0.0001931467),
   (r_E55_College_Ind_d > 0.5) => 
      map(
      (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0432208438,
      (r_I60_inq_recency_d > 505.5) => 0.0546116792,
      (r_I60_inq_recency_d = NULL) => 0.0427788038, 0.0427788038),
   (r_E55_College_Ind_d = NULL) => 0.0066125377, 0.0066125377),
(r_F03_address_match_d = NULL) => -0.0190577538, -0.0057060070);

// Tree: 32 
e_final_score_32 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0352646691,
   (r_C23_inp_addr_occ_index_d > 4.5) => 0.0315730274,
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0262627192, -0.0262627192),
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 2.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 54.5) => 0.0109781515,
         (k_comb_age_d > 54.5) => 0.0421598532,
         (k_comb_age_d = NULL) => 0.0667704832, 0.0236866135),
      (r_S66_adlperssn_count_i > 2.5) => -0.0177339146,
      (r_S66_adlperssn_count_i = NULL) => 0.0571014057, 0.0206076190),
   (r_L79_adls_per_addr_curr_i > 3.5) => -0.0252104846,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0122086270, 0.0122086270),
(r_F03_address_match_d = NULL) => -0.0196614470, -0.0005600665);

// Tree: 33 
e_final_score_33 := map(
(NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 1.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 140.5) => 0.0252909323,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 140.5) => -0.0608777079,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0236781050, 0.0212343375),
   (r_C14_addrs_15yr_i > 1.5) => 
      map(
			      (r_D31_bk_chapter_n = '') => 
         map(
         (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0188216165,
         (r_E55_College_Ind_d > 0.5) => 0.0296147515,
         (r_E55_College_Ind_d = NULL) => -0.0105288033, -0.0105288033),
      (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 9) => 0.0663136615,
      ((Integer)r_D31_bk_chapter_n > 9) => -0.0215600242,
 -0.0069781837),
   (r_C14_addrs_15yr_i = NULL) => 0.0034961407, 0.0034961407),
(r_I60_Inq_Count12_i > 0.5) => -0.0431279406,
(r_I60_Inq_Count12_i = NULL) => -0.0199594475, -0.0028303945);

// Tree: 34 
e_final_score_34 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 339.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 157874.5) => -0.0237054646,
   (r_A46_Curr_AVM_AutoVal_d > 157874.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 125.25) => 0.0225074546,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 125.25) => -0.0679920818,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0206013313, 0.0157187505),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 5.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0034194827,
         (r_S66_adlperssn_count_i > 1.5) => -0.0302315038,
         (r_S66_adlperssn_count_i = NULL) => 0.0100409005, -0.0098805397),
      (r_C23_inp_addr_occ_index_d > 5.5) => 0.0848775029,
      (r_C23_inp_addr_occ_index_d = NULL) => -0.0078548893, -0.0078548893), -0.0074447243),
(r_C13_max_lres_d > 339.5) => 0.0368700745,
(r_C13_max_lres_d = NULL) => -0.0118510080, -0.0037236498);

// Tree: 35 
e_final_score_35 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 67500) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 0.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 0.0184401769,
         (r_L79_adls_per_addr_curr_i > 3.5) => -0.0292409303,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0101735567, 0.0101735567),
      (r_C14_addrs_10yr_i > 0.5) => -0.0215285516,
      (r_C14_addrs_10yr_i = NULL) => -0.0127790998, -0.0127790998),
   (k_estimated_income_d > 67500) => 0.0445391408,
   (k_estimated_income_d = NULL) => -0.0095770462, -0.0095770462),
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < r_I60_inq_auto_recency_d and r_I60_inq_auto_recency_d <= 505.5) => -0.0659064458,
   (r_I60_inq_auto_recency_d > 505.5) => 0.0394533559,
   (r_I60_inq_auto_recency_d = NULL) => 0.0302586254, 0.0302586254),
(r_E55_College_Ind_d = NULL) => 0.0076095099, -0.0036660768);

// Tree: 36 
e_final_score_36 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => -0.0264795570,
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0253239335,
         (r_D30_Derog_Count_i > 1.5) => -0.0351917895,
         (r_D30_Derog_Count_i = NULL) => 0.0193924733, 0.0193924733),
      (r_L79_adls_per_addr_curr_i > 2.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0078350721,
         (r_S66_adlperssn_count_i > 1.5) => -0.0282569273,
         (r_S66_adlperssn_count_i = NULL) => -0.0347157658, -0.0090439527),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0084517588, 0.0084517588),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0022894828, 0.0007280885),
(r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0871208407,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0102613168, -0.0021845688);

// Tree: 37 
e_final_score_37 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 290688.5) => -0.0333322167,
   (r_A46_Curr_AVM_AutoVal_d > 290688.5) => 0.0539279323,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0181913399, -0.0198865241),
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 505.5) => -0.0965814341,
      (r_I61_inq_collection_recency_d > 505.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 54994) => -0.0259202695,
         (r_L80_Inp_AVM_AutoVal_d > 54994) => 0.0192193623,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0242549167, 0.0178755325),
      (r_I61_inq_collection_recency_d = NULL) => 0.0160791772, 0.0160791772),
   (r_D30_Derog_Count_i > 0.5) => -0.0150939210,
   (r_D30_Derog_Count_i = NULL) => 0.0089226080, 0.0089226080),
(r_F03_address_match_d = NULL) => -0.0034221912, -0.0003740050);

// Tree: 38 
e_final_score_38 := map(
(Fin_Class in ['TSP','UNK']) => -0.0316237507,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 86.5) => 
      map(
      (NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 5.5) => 
            map(
            (NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 0.0099855499,
            (r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => -0.0198296591,
            (r_F00_Addr_Not_Ver_w_SSN_i = NULL) => 0.0241672707, 0.0073656996),
         (r_C23_inp_addr_occ_index_d > 5.5) => 0.0882864933,
         (r_C23_inp_addr_occ_index_d = NULL) => 0.0084111528, 0.0084111528),
      (r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0828484188,
      (r_I60_inq_hiRiskCred_count12_i = NULL) => 0.0059286071, 0.0059286071),
   (k_comb_age_d > 86.5) => 0.0803574195,
   (k_comb_age_d = NULL) => 0.0492680558, 0.0086612440),
(Fin_Class = '') => -0.0036265912, -0.0036265912);

// Tree: 39 
e_final_score_39 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
      map(
      (NULL < r_wealth_index_d and r_wealth_index_d <= 3.5) => -0.0174426867,
      (r_wealth_index_d > 3.5) => 0.0164766732,
      (r_wealth_index_d = NULL) => -0.0118680413, -0.0118680413),
   (k_nap_fname_verd_d > 0.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 1.5) => 0.0286649429,
      (r_C14_addrs_10yr_i > 1.5) => -0.0205079913,
      (r_C14_addrs_10yr_i = NULL) => 0.0166900298, 0.0166900298),
   (k_nap_fname_verd_d = NULL) => -0.0058810707, -0.0058810707),
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 0.0394913463,
   (r_D34_unrel_liens_ct_i > 0.5) => -0.0577555780,
   (r_D34_unrel_liens_ct_i = NULL) => 0.0307580061, 0.0307580061),
(r_E55_College_Ind_d = NULL) => -0.0211811523, -0.0015030394);

// Tree: 40 
e_final_score_40 := map(
(pat_type in ['E','I']) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0204771545,
   (r_E55_College_Ind_d > 0.5) => 0.0301446052,
   (r_E55_College_Ind_d = NULL) => -0.0556419318, -0.0165532583),
(pat_type in ['NA','O','S']) => 
   map(
   (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 3.5) => 
      map(
      (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 450.5) => 
         map(
         (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => -0.0037706963,
         (r_E57_br_source_count_d > 0.5) => 0.0424072491,
         (r_E57_br_source_count_d = NULL) => 0.0011544258, 0.0011544258),
      (r_C10_M_Hdr_FS_d > 450.5) => 0.0846473522,
      (r_C10_M_Hdr_FS_d = NULL) => 0.0032382759, 0.0032382759),
   (r_C12_Num_NonDerogs_d > 3.5) => 0.0368054491,
   (r_C12_Num_NonDerogs_d = NULL) => 0.0266848015, 0.0094723826),
(pat_type = '') => -0.0040313289, -0.0040313289);

// Tree: 41 
e_final_score_41 := map(
(NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 505.5) => -0.0982014709,
(r_I61_inq_collection_recency_d > 505.5) => 
   map(
   (NULL < r_A44_curr_add_naprop_d and r_A44_curr_add_naprop_d <= 2.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 246.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0053057479,
         (r_S66_adlperssn_count_i > 1.5) => -0.0408110506,
         (r_S66_adlperssn_count_i = NULL) => -0.0197881456, -0.0211078209),
      (r_C13_max_lres_d > 246.5) => 0.0235272225,
      (r_C13_max_lres_d = NULL) => -0.0158734735, -0.0158734735),
   (r_A44_curr_add_naprop_d > 2.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -1674.5) => 0.0300229785,
      (r_A49_Curr_AVM_Chg_1yr_i > -1674.5) => -0.0021278757,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0193242992, 0.0120333922),
   (r_A44_curr_add_naprop_d = NULL) => -0.0034136251, -0.0034136251),
(r_I61_inq_collection_recency_d = NULL) => -0.0054852125, -0.0061726056);

// Tree: 42 
e_final_score_42 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 2.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 0.0185350371,
         (r_L79_adls_per_addr_c6_i > 0.5) => -0.0100941801,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0121031069, 0.0121031069),
      (r_L79_adls_per_addr_curr_i > 3.5) => -0.0281851363,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0047665783, 0.0047665783),
   (r_C14_addrs_15yr_i > 2.5) => -0.0204137213,
   (r_C14_addrs_15yr_i = NULL) => -0.0068523545, -0.0068523545),
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0411965716,
   (r_S66_adlperssn_count_i > 1.5) => -0.0025237160,
   (r_S66_adlperssn_count_i = NULL) => 0.0794659962, 0.0290699643),
(r_E55_College_Ind_d = NULL) => -0.0057441855, -0.0021163082);

// Tree: 43 
e_final_score_43 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 68.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 290563) => 
      map(
			(r_D31_bk_chapter_n = '') => -0.0106167826,
      (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0609441629,
      ((Integer)r_D31_bk_chapter_n > 10) => -0.0387521974,
       -0.0072166737),
   (r_A46_Curr_AVM_AutoVal_d > 290563) => 0.0382247916,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0086285569, -0.0040180462),
(k_comb_age_d > 68.5) => 0.0299062466,
(k_comb_age_d = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 98524) => -0.0703894869,
   (r_L80_Inp_AVM_AutoVal_d > 98524) => 
      map(
      (pat_type in ['E']) => 0.0075584037,
      (pat_type in ['I','NA','O','S']) => 0.1532835725,
      (pat_type = '') => 0.0749103725, 0.0749103725),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0210212821, -0.0050076701), -0.0002461195);

// Tree: 44 
e_final_score_44 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0223223920,
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0173936555,
   (r_L79_adls_per_addr_curr_i > 2.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 39355) => 
            map(
            (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 54942) => -0.0671371190,
            (r_L80_Inp_AVM_AutoVal_d > 54942) => 0.0214666683,
            (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0087550454, 0.0087550454),
         (r_A49_Curr_AVM_Chg_1yr_i > 39355) => -0.0881700236,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0207861227, 0.0082141893),
      (r_S66_adlperssn_count_i > 1.5) => -0.0307629165,
      (r_S66_adlperssn_count_i = NULL) => -0.0272494256, -0.0096374351),
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0065538438, 0.0065538438),
(r_F03_address_match_d = NULL) => -0.0147414803, -0.0030243743);

// Tree: 45 
e_final_score_45 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 337.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 199538) => -0.0205860776,
   (r_L80_Inp_AVM_AutoVal_d > 199538) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 1.5) => 0.0743313999,
      (r_L79_adls_per_addr_curr_i > 1.5) => 0.0096059034,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0227853032, 0.0227853032),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0090051978, -0.0089276771),
(r_C21_M_Bureau_ADL_FS_d > 337.5) => 
   map(
   (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 81.5) => 0.0175151650,
      (k_comb_age_d > 81.5) => 0.0736000622,
      (k_comb_age_d = NULL) => 0.0216954057, 0.0216954057),
   (r_D34_unrel_liens_ct_i > 0.5) => -0.0369151160,
   (r_D34_unrel_liens_ct_i = NULL) => 0.0151417515, 0.0151417515),
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0062049944, -0.0027193172);

// Tree: 46 
e_final_score_46 := map(
(NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 505.5) => -0.0381955660,
(r_I60_inq_recency_d > 505.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
      map(
      (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => 
            map(
            (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0047224875,
            (r_L79_adls_per_addr_curr_i > 2.5) => -0.0274405643,
            (r_L79_adls_per_addr_curr_i = NULL) => -0.0074455941, -0.0074455941),
         (r_C12_Num_NonDerogs_d > 2.5) => 0.0121612150,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0015259426, 0.0015259426),
      (r_F03_input_add_not_most_rec_i > 0.5) => -0.0358575961,
      (r_F03_input_add_not_most_rec_i = NULL) => -0.0033173902, -0.0033173902),
   (r_C23_inp_addr_occ_index_d > 4.5) => 0.0394267170,
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0014553896, -0.0014553896),
(r_I60_inq_recency_d = NULL) => -0.0008952521, -0.0059319125);

// Tree: 47 
e_final_score_47 := map(
(NULL < r_D33_eviction_count_i and r_D33_eviction_count_i <= 0.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 30) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 83357) => -0.0273312879,
         (r_A46_Curr_AVM_AutoVal_d > 83357) => 0.0070029670,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0072176175, 0.0024338587),
      (r_D30_Derog_Count_i > 0.5) => -0.0346198810,
      (r_D30_Derog_Count_i = NULL) => -0.0033145786, -0.0033145786),
   (r_D31_attr_bankruptcy_recency_d > 30) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 46.5) => -0.0114273015,
      (k_comb_age_d > 46.5) => 0.0683781915,
      (k_comb_age_d = NULL) => 0.0355974511, 0.0355974511),
   (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0014086265, -0.0014086265),
(r_D33_eviction_count_i > 0.5) => -0.0695799126,
(r_D33_eviction_count_i = NULL) => -0.0132227448, -0.0060550937);

// Tree: 48 
e_final_score_48 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 180214.5) => 0.0026236958,
      (r_L80_Inp_AVM_AutoVal_d > 180214.5) => 0.0334065595,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0003453749, 0.0069103146),
   (r_S66_adlperssn_count_i > 1.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 265.5) => -0.0251188919,
      (r_C13_max_lres_d > 265.5) => 0.0112606554,
      (r_C13_max_lres_d = NULL) => -0.0178184619, -0.0178184619),
   (r_S66_adlperssn_count_i = NULL) => 0.0099142570, -0.0022421983),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 12) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 3.5) => 0.0593929808,
   (r_D30_Derog_Count_i > 3.5) => -0.0525916319,
   (r_D30_Derog_Count_i = NULL) => 0.0424587223, 0.0424587223),
((Integer)r_D31_bk_chapter_n > 12) => -0.0143633276,
 -0.0005281272);

// Tree: 49 
e_final_score_49 := map(
(pat_type in ['E','I','O']) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 263688) => -0.0166252893,
   (r_A46_Curr_AVM_AutoVal_d > 263688) => 0.0193362329,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0015966359, -0.0060825927),
(pat_type in ['NA','S']) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 30) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 491.5) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => -0.0029492617,
         (r_C12_Num_NonDerogs_d > 2.5) => 0.0271083123,
         (r_C12_Num_NonDerogs_d = NULL) => 0.0112479730, 0.0112479730),
      (r_C13_max_lres_d > 491.5) => 0.1083310110,
      (r_C13_max_lres_d = NULL) => 0.0133835435, 0.0133835435),
   (r_D31_attr_bankruptcy_recency_d > 30) => 0.0755754772,
   (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0060806963, 0.0166900207),
(pat_type = '') => -0.0000396767, -0.0000396767);

// Tree: 50 
e_final_score_50 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 3.5) => 
      map(
      (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
         map(
         (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 0.0118246953,
         (r_L72_Add_Vacant_i > 0.5) => -0.0993757112,
         (r_L72_Add_Vacant_i = NULL) => 0.0108548739, 0.0108548739),
      (r_I61_inq_collection_count12_i > 0.5) => -0.0908870147,
      (r_I61_inq_collection_count12_i = NULL) => 0.0087029989, 0.0087029989),
   (r_I60_Inq_Count12_i > 3.5) => -0.1172501528,
   (r_I60_Inq_Count12_i = NULL) => 0.0065739479, 0.0065739479),
(r_D30_Derog_Count_i > 0.5) => 
   map(
	    (r_D31_bk_chapter_n = '') => -0.0414989456,
   (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 12) => 0.0210417348,
   ((Integer)r_D31_bk_chapter_n > 12) => -0.0354569864,
 -0.0297458468),
(r_D30_Derog_Count_i = NULL) => -0.0099841169, -0.0029440510);

// Tree: 51 
e_final_score_51 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 
   map(
	    (r_D31_bk_chapter_n = '') => 
      map(
      (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 2.5) => 
         map(
         (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 0.0069875301,
         (r_L79_adls_per_addr_c6_i > 0.5) => -0.0089597728,
         (r_L79_adls_per_addr_c6_i = NULL) => 0.0021026125, 0.0021026125),
      (r_I60_Inq_Count12_i > 2.5) => -0.0805043466,
      (r_I60_Inq_Count12_i = NULL) => -0.0002865266, -0.0002865266),
   (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 105.7) => 0.0718024357,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 105.7) => -0.0272547362,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0734088999, 0.0482942439),
   ((Integer)r_D31_bk_chapter_n > 10) => -0.0115879840,
 0.0011934971),
(r_D30_Derog_Count_i > 1.5) => -0.0447948660,
(r_D30_Derog_Count_i = NULL) => -0.0059620560, -0.0045692346);

// Tree: 52 
e_final_score_52 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0738710632,
(r_I60_inq_hiRiskCred_recency_d > 505.5) => 
   map(
   (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
      map(
      (Fin_Class in ['TSP','UNK']) => -0.0248909756,
      (Fin_Class in ['BAI']) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 84.65) => 0.0391471620,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 84.65) => -0.0007339302,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0071892236, 0.0057184646),
      (Fin_Class = '') => -0.0030141111, -0.0030141111),
   (r_I61_inq_collection_count12_i > 0.5) => -0.0717048994,
   (r_I61_inq_collection_count12_i = NULL) => -0.0048012789, -0.0048012789),
(r_I60_inq_hiRiskCred_recency_d = NULL) => 
   map(
   (Fin_Class in ['TSP']) => -0.0370099632,
   (Fin_Class in ['BAI','UNK']) => 0.0671481416,
   (Fin_Class = '') => -0.0035940525, -0.0035940525), -0.0072719407);

// Tree: 53 
e_final_score_53 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 2.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 79.05) => 0.0631441715,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 79.05) => 0.0025255240,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
         map(
         (NULL < r_wealth_index_d and r_wealth_index_d <= 2.5) => 0.0036679482,
         (r_wealth_index_d > 2.5) => 0.0423011298,
         (r_wealth_index_d = NULL) => 0.0124883093, 0.0124883093), 0.0101281861),
   (r_C14_addrs_15yr_i > 2.5) => -0.0084708166,
   (r_C14_addrs_15yr_i = NULL) => 0.0008088300, 0.0008088300),
(r_L79_adls_per_addr_curr_i > 3.5) => -0.0228394983,
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 132750) => 0.0224620476,
   (r_L80_Inp_AVM_AutoVal_d > 132750) => 0.0942979406,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0464795551, -0.0118724432), -0.0033776274);

// Tree: 54 
e_final_score_54 := map(
(NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 9) => -0.0483776582,
   (r_I60_inq_recency_d > 9) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0026179897,
      (r_C23_inp_addr_occ_index_d > 4.5) => 0.0284233289,
      (r_C23_inp_addr_occ_index_d = NULL) => -0.0012408870, -0.0012408870),
   (r_I60_inq_recency_d = NULL) => -0.0044715365, -0.0044715365),
(r_E57_br_source_count_d > 0.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 3.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 65454.5) => -0.0534247060,
      (r_A46_Curr_AVM_AutoVal_d > 65454.5) => 0.0462182480,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0315649620, 0.0334536359),
   (r_C18_invalid_addrs_per_adl_i > 3.5) => -0.0417915433,
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0268667767, 0.0268667767),
(r_E57_br_source_count_d = NULL) => 0.0196149392, -0.0003454648);

// Tree: 55 
e_final_score_55 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 4.5) => 0.0093129204,
   (r_C18_invalid_addrs_per_adl_i > 4.5) => -0.0561164858,
   (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0160246210, 0.0073605559),
(r_S66_adlperssn_count_i > 1.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -7802.5) => 
      map(
      (pat_type in ['E','I','NA']) => 0.0065608455,
      (pat_type in ['O','S']) => 0.1033594775,
      (pat_type = '') => 0.0295895523, 0.0295895523),
   (r_A49_Curr_AVM_Chg_1yr_i > -7802.5) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 82500) => -0.0256801690,
      (k_estimated_income_d > 82500) => 0.0698760047,
      (k_estimated_income_d = NULL) => -0.0210824381, -0.0210824381),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0113917207, -0.0119263627),
(r_S66_adlperssn_count_i = NULL) => 0.0188249795, 0.0008244211);

// Tree: 56 
e_final_score_56 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 155660.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 54.5) => -0.0228447884,
   (k_comb_age_d > 54.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 26057) => 0.0186767324,
      (r_A49_Curr_AVM_Chg_1yr_i > 26057) => -0.0593830692,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
         map(
         (NULL < r_wealth_index_d and r_wealth_index_d <= 2.5) => -0.0087967321,
         (r_wealth_index_d > 2.5) => 0.1169860480,
         (r_wealth_index_d = NULL) => 0.0393215126, 0.0393215126), 0.0162812710),
   (k_comb_age_d = NULL) => -0.0101041258, -0.0099433887),
(r_L80_Inp_AVM_AutoVal_d > 155660.5) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => -0.0135208853,
   (r_F03_address_match_d > 3) => 0.0210560747,
   (r_F03_address_match_d = NULL) => 0.0156686275, 0.0156686275),
(r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0001994163, 0.0003975001);

// Tree: 57 
e_final_score_57 := map(
(pat_type in ['E','I','O','S']) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 73.5) => -0.0104403913,
   (k_comb_age_d > 73.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 
            map(
            (pat_type in ['I','O','S']) => 0.0313862386,
            (pat_type in ['E','NA']) => 0.1051094782,
            (pat_type = '') => 0.0573164815, 0.0573164815),
         (r_L79_adls_per_addr_curr_i > 2.5) => -0.0220552679,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0382007722, 0.0382007722),
      (r_L79_adls_per_addr_c6_i > 0.5) => -0.0245194532,
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0217336860, 0.0217336860),
   (k_comb_age_d = NULL) => -0.0260426904, -0.0088863643),
(pat_type in ['NA']) => 0.0163106902,
(pat_type = '') => -0.0031642050, -0.0031642050);

// Tree: 58 
e_final_score_58 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 5.5) => 
         map(
         (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => -0.0095537545,
         (r_F03_address_match_d > 3) => 
            map(
            (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 340.5) => 0.0063945697,
            (r_C21_M_Bureau_ADL_FS_d > 340.5) => 0.0291536245,
            (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0136279083, 0.0136279083),
         (r_F03_address_match_d = NULL) => 0.0062688205, 0.0062688205),
      (r_C23_inp_addr_occ_index_d > 5.5) => 0.0695424792,
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0072011530, 0.0072011530),
   (r_I60_Inq_Count12_i > 0.5) => -0.0318337480,
   (r_I60_Inq_Count12_i = NULL) => 0.0025950034, 0.0025950034),
(r_L79_adls_per_addr_curr_i > 3.5) => -0.0206966670,
(r_L79_adls_per_addr_curr_i = NULL) => -0.0247619455, -0.0020400193);

// Tree: 59 
e_final_score_59 := map(
(NULL < k_comb_age_d and k_comb_age_d <= 84.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 108863) => 
      map(
      (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 48) => -0.0196328216,
      (r_D31_attr_bankruptcy_recency_d > 48) => 0.0696277590,
      (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0150698166, -0.0150698166),
   (r_A46_Curr_AVM_AutoVal_d > 108863) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0217668634,
      (r_C18_invalid_addrs_per_adl_i > 0.5) => -0.0067054031,
      (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0091567938, 0.0091567938),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 39500) => -0.0069014738,
      (k_estimated_income_d > 39500) => 0.0322533514,
      (k_estimated_income_d = NULL) => -0.0036409007, -0.0036409007), -0.0020177799),
(k_comb_age_d > 84.5) => 0.0423683197,
(k_comb_age_d = NULL) => 0.0038707675, -0.0007250882);

// Tree: 60 
e_final_score_60 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 44492.5) => -0.0392101689,
(r_A46_Curr_AVM_AutoVal_d > 44492.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 79.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 0.0084689056,
      (r_D30_Derog_Count_i > 0.5) => -0.0293553877,
      (r_D30_Derog_Count_i = NULL) => 0.0009097880, 0.0009097880),
   (r_D31_attr_bankruptcy_recency_d > 79.5) => 0.0708684955,
   (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0025516055, 0.0025516055),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 401.5) => 
      map(
      (NULL < r_wealth_index_d and r_wealth_index_d <= 2.5) => -0.0100251839,
      (r_wealth_index_d > 2.5) => 0.0191046778,
      (r_wealth_index_d = NULL) => -0.0044690983, -0.0044690983),
   (r_C13_max_lres_d > 401.5) => 0.0639957193,
   (r_C13_max_lres_d = NULL) => -0.0132532237, -0.0032569295), -0.0029585968);

// Tree: 61 
e_final_score_61 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 
   map(
   (pat_type in ['E','I']) => -0.0092832770,
   (pat_type in ['NA','O','S']) => 
      map(
      (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 505.5) => -0.1096220559,
      (r_I61_inq_collection_recency_d > 505.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 434) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 86.7) => 0.0461500051,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i > 86.7) => 0.0020254567,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0106342729, 0.0099339113),
         (r_C21_M_Bureau_ADL_FS_d > 434) => 0.0976689132,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0113735783, 0.0113735783),
      (r_I61_inq_collection_recency_d = NULL) => 0.0177103289, 0.0091538541),
   (pat_type = '') => -0.0003441246, -0.0003441246),
(r_L79_adls_per_addr_c6_i > 2.5) => -0.0445322436,
(r_L79_adls_per_addr_c6_i = NULL) => -0.0019962847, -0.0019962847);

// Tree: 62 
e_final_score_62 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 56894.5) => -0.0303392412,
(r_A46_Curr_AVM_AutoVal_d > 56894.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 0.0087836920,
   (r_L79_adls_per_addr_c6_i > 2.5) => -0.0444682897,
   (r_L79_adls_per_addr_c6_i = NULL) => 0.0070025486, 0.0070025486),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 390) => 
         map(
         (pat_type in ['E','I','O']) => -0.0005115448,
         (pat_type in ['NA','S']) => 0.0227731496,
         (pat_type = '') => 0.0055005800, 0.0055005800),
      (r_C21_M_Bureau_ADL_FS_d > 390) => 0.0798706882,
      (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0071768586, 0.0071768586),
   (r_D30_Derog_Count_i > 0.5) => -0.0271280214,
   (r_D30_Derog_Count_i = NULL) => 0.0046273627, -0.0020144377), -0.0007150893);

// Tree: 63 
e_final_score_63 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 
      map(
      (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 0.0070663869,
      (r_E55_College_Ind_d > 0.5) => 0.0463511681,
      (r_E55_College_Ind_d = NULL) => 0.0132949729, 0.0132949729),
   (r_C18_invalid_addrs_per_adl_i > 0.5) => 
      map(
      (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => 0.0024417037,
      (r_C14_addrs_10yr_i > 2.5) => -0.0458089091,
      (r_C14_addrs_10yr_i = NULL) => -0.0113024103, -0.0113024103),
   (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0832590348, 0.0037596901),
(r_S66_adlperssn_count_i > 1.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 50347.5) => -0.0150251939,
   (r_A49_Curr_AVM_Chg_1yr_i > 50347.5) => -0.0890732836,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0063256470, -0.0119134675),
(r_S66_adlperssn_count_i = NULL) => 0.0206477499, -0.0007998447);

// Tree: 64 
e_final_score_64 := map(
(NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => -0.0090593252,
(r_C12_Num_NonDerogs_d > 2.5) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 505.5) => -0.0861882035,
   (r_I61_inq_collection_recency_d > 505.5) => 
      map(
			      (r_D31_bk_chapter_n = '') => 
         map(
         (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
            map(
            (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 3.5) => 0.0135967779,
            (r_C14_Addr_Stability_v2_d > 3.5) => 0.0156876262,
            (r_C14_Addr_Stability_v2_d = NULL) => 0.0151351438, 0.0151351438),
         (r_D30_Derog_Count_i > 0.5) => -0.0257868359,
         (r_D30_Derog_Count_i = NULL) => 0.0087350237, 0.0087350237),
      (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 9) => 0.0496155426,
      ((Integer)r_D31_bk_chapter_n > 9) => -0.0237104159,
 0.0102752229),
   (r_I61_inq_collection_recency_d = NULL) => 0.0079484669, 0.0079484669),
(r_C12_Num_NonDerogs_d = NULL) => -0.0104808491, -0.0018104995);

// Tree: 65 
e_final_score_65 := map(
(NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => -0.0042881973,
(r_E57_br_source_count_d > 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 280738.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 18905.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0472763258,
         (r_L79_adls_per_addr_curr_i > 2.5) => -0.0268912345,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0204183056, 0.0204183056),
      (r_A49_Curr_AVM_Chg_1yr_i > 18905.5) => -0.0563030026,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0262724543, -0.0004761196),
   (r_A46_Curr_AVM_AutoVal_d > 280738.5) => 0.0410432140,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0383991085, 0.0217379526),
(r_E57_br_source_count_d = NULL) => 
   map(
   (Fin_Class in ['TSP','UNK']) => -0.0559969772,
   (Fin_Class in ['BAI']) => 0.0446619694,
   (Fin_Class = '') => -0.0240472091, -0.0240472091), -0.0020256927);

// Tree: 66 
e_final_score_66 := map(
(NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 1.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 5.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 88.5) => 
         map(
         (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0027883878,
         (r_E55_College_Ind_d > 0.5) => 0.0177237059,
         (r_E55_College_Ind_d = NULL) => 0.0000969638, 0.0000969638),
      (k_comb_age_d > 88.5) => 
         map(
         (pat_type in ['I','O']) => -0.0242010338,
         (pat_type in ['E','NA','S']) => 0.0991329990,
         (pat_type = '') => 0.0424660109, 0.0424660109),
      (k_comb_age_d = NULL) => 0.0414077940, 0.0014277526),
   (r_C23_inp_addr_occ_index_d > 5.5) => 0.0540641637,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0021272596, 0.0021272596),
(r_I60_inq_auto_count12_i > 1.5) => -0.0882651126,
(r_I60_inq_auto_count12_i = NULL) => -0.0143960135, -0.0000179039);

// Tree: 67 
e_final_score_67 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0129341580,
(r_F03_address_match_d > 3.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 87.5) => 
      map(
      (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => -0.0178148995,
      (r_C12_Num_NonDerogs_d > 1.5) => 
         map(
         (pat_type in ['I']) => -0.0207431848,
         (pat_type in ['E','NA','O','S']) => 
            map(
            (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 336.5) => 0.0058511043,
            (r_C10_M_Hdr_FS_d > 336.5) => 0.0270447292,
            (r_C10_M_Hdr_FS_d = NULL) => 0.0130377114, 0.0130377114),
         (pat_type = '') => 0.0102712014, 0.0102712014),
      (r_C12_Num_NonDerogs_d = NULL) => 0.0056429022, 0.0056429022),
   (k_comb_age_d > 87.5) => 0.0644835247,
   (k_comb_age_d = NULL) => 0.0595617891, 0.0070087784),
(r_F03_address_match_d = NULL) => 0.0054950490, 0.0009389291);

// Tree: 68 
e_final_score_68 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0723030583,
(r_I60_inq_hiRiskCred_recency_d > 505.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 2.5) => 
      map(
      (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 3.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 27950) => -0.0469219079,
         (r_A46_Curr_AVM_AutoVal_d > 27950) => 0.0043966846,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 
            map(
            (NULL < k_estimated_income_d and k_estimated_income_d <= 41500) => 0.0000986765,
            (k_estimated_income_d > 41500) => 0.0418945155,
            (k_estimated_income_d = NULL) => 0.0028126920, 0.0028126920), 0.0020081465),
      (r_D34_unrel_liens_ct_i > 3.5) => -0.0839750203,
      (r_D34_unrel_liens_ct_i = NULL) => 0.0008597496, 0.0008597496),
   (r_S66_adlperssn_count_i > 2.5) => -0.0200349394,
   (r_S66_adlperssn_count_i = NULL) => 0.0061160336, -0.0013472069),
(r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0081047372, -0.0040450376);

// Tree: 69 
e_final_score_69 := map(
(pat_type in ['E','I','O','S']) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 
      map(
      (Fin_Class in ['TSP']) => -0.0346517498,
      (Fin_Class in ['BAI','UNK']) => 0.0041187993,
      (Fin_Class = '') => -0.0080573061, -0.0080573061),
   (r_L79_adls_per_addr_c6_i > 2.5) => -0.0471186290,
   (r_L79_adls_per_addr_c6_i = NULL) => -0.0094395761, -0.0094395761),
(pat_type in ['NA']) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 72500) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 20357.5) => 0.0125490295,
      (r_A49_Curr_AVM_Chg_1yr_i > 20357.5) => -0.0387792999,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0209856664, 0.0112483101),
   (k_estimated_income_d > 72500) => 0.0636058287,
   (k_estimated_income_d = NULL) => 0.0718926377, 0.0178913821),
(pat_type = '') => -0.0033830499, -0.0033830499);

// Tree: 70 
e_final_score_70 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0105144783,
   (r_L79_adls_per_addr_curr_i > 2.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0065552278,
      (r_S66_adlperssn_count_i > 1.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 285006) => -0.0395113086,
         (r_A46_Curr_AVM_AutoVal_d > 285006) => 0.0400638676,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0241707597, -0.0248445480),
      (r_S66_adlperssn_count_i = NULL) => -0.0194651878, -0.0074443933),
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0041886989, 0.0041886989),
(r_D30_Derog_Count_i > 0.5) => 
   map(
	    (r_D31_bk_chapter_n = '') => -0.0322634585,
   (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 9) => 0.0162852098,
   ((Integer)r_D31_bk_chapter_n > 9) => -0.0223529491,
 -0.0226310026),
(r_D30_Derog_Count_i = NULL) => 0.0089936637, -0.0021990430);

// Tree: 71 
e_final_score_71 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 79950) => -0.0005952978,
(r_A49_Curr_AVM_Chg_1yr_i > 79950) => -0.0647413841,
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 51928.5) => -0.0544038341,
   (r_L80_Inp_AVM_AutoVal_d > 51928.5) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3) => -0.0270565559,
      (r_F03_address_match_d > 3) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 198) => 0.0183191502,
         (r_C13_max_lres_d > 198) => 0.0877703667,
         (r_C13_max_lres_d = NULL) => 0.0330592745, 0.0330592745),
      (r_F03_address_match_d = NULL) => 0.0310505443, 0.0079982813),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (pat_type in ['E','I','O']) => -0.0085812610,
      (pat_type in ['NA','S']) => 0.0155907951,
      (pat_type = '') => -0.0027769402, -0.0027769402), -0.0029431760), -0.0026870933);

// Tree: 72 
e_final_score_72 := map(
(NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 
   map(
   (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
      map(
			      (r_D31_bk_chapter_n = '') => -0.0098725049,
      (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 72.101) => -0.0065363388,
         (r_C12_source_profile_d > 72.101) => 0.0636628009,
         (r_C12_source_profile_d = NULL) => 0.0257510993, 0.0257510993),
      ((Integer)r_D31_bk_chapter_n > 10) => -0.0126266402,
 -0.0082714125),
   (r_L72_Add_Vacant_i > 0.5) => -0.1153297856,
   (r_L72_Add_Vacant_i = NULL) => -0.0094239897, -0.0094239897),
(k_nap_fname_verd_d > 0.5) => 
   map(
   (NULL < r_C14_addrs_10yr_i and r_C14_addrs_10yr_i <= 2.5) => 0.0172529105,
   (r_C14_addrs_10yr_i > 2.5) => -0.0350523799,
   (r_C14_addrs_10yr_i = NULL) => 0.0102898372, 0.0102898372),
(k_nap_fname_verd_d = NULL) => -0.0053592612, -0.0053592612);

// Tree: 73 
e_final_score_73 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 
   map(
   (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 7.5) => 0.0065526107,
      (r_L79_adls_per_addr_curr_i > 7.5) => -0.0778765389,
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0055439824, 0.0055439824),
   (r_I61_inq_collection_count12_i > 0.5) => -0.0975205329,
   (r_I61_inq_collection_count12_i = NULL) => 0.0023759314, 0.0023759314),
(r_C18_invalid_addrs_per_adl_i > 0.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0125705861,
   (r_C23_inp_addr_occ_index_d > 4.5) => 
      map(
      (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => -0.0574003991,
      (r_F01_inp_addr_address_score_d > 25) => 0.0477707376,
      (r_F01_inp_addr_address_score_d = NULL) => 0.0254370985, 0.0254370985),
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0100795354, -0.0100795354),
(r_C18_invalid_addrs_per_adl_i = NULL) => -0.0191545278, -0.0036344647);

// Tree: 74 
e_final_score_74 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 76052.5) => 0.0010508235,
   (r_A49_Curr_AVM_Chg_1yr_i > 76052.5) => 
      map(
      (pat_type in ['NA','O']) => -0.1259851523,
      (pat_type in ['E','I','S']) => 0.0181667170,
      (pat_type = '') => -0.0579889875, -0.0579889875),
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < r_C23_inp_addr_owned_not_occ_d and r_C23_inp_addr_owned_not_occ_d <= 0.5) => 
         map(
         (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 0.0009185971,
         (r_E57_br_source_count_d > 0.5) => 0.0357828610,
         (r_E57_br_source_count_d = NULL) => 0.0039434226, 0.0039434226),
      (r_C23_inp_addr_owned_not_occ_d > 0.5) => 0.0798865019,
      (r_C23_inp_addr_owned_not_occ_d = NULL) => 0.0050425765, 0.0050425765), 0.0025233721),
(r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0232543512,
(r_C18_invalid_addrs_per_adl_i = NULL) => -0.0096121566, -0.0006964318);

// Tree: 75 
e_final_score_75 := map(
(NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 2.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 104282.5) => -0.0132973518,
      (r_A46_Curr_AVM_AutoVal_d > 104282.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 18545.5) => 0.0261797883,
         (r_A49_Curr_AVM_Chg_1yr_i > 18545.5) => -0.0045172479,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0056739006, 0.0131778324),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 0.0048447804, 0.0040789808),
   (r_L79_adls_per_addr_c6_i > 0.5) => -0.0110803873,
   (r_L79_adls_per_addr_c6_i = NULL) => -0.0008333358, -0.0008333358),
(r_E57_br_source_count_d > 2.5) => 0.1055740531,
(r_E57_br_source_count_d = NULL) => 
   map(
   (pat_type in ['E','I']) => -0.0483090216,
   (pat_type in ['NA','O','S']) => 0.0579323343,
   (pat_type = '') => -0.0173074457, -0.0173074457), -0.0007211761);

// Tree: 76 
e_final_score_76 := map(
(NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 1.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => -0.0005989995,
   (r_C14_Addr_Stability_v2_d > 1.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0075622832,
      (r_L79_adls_per_addr_curr_i > 2.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0055407520,
         (r_S66_adlperssn_count_i > 1.5) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 32923.5) => -0.0169931581,
            (r_A49_Curr_AVM_Chg_1yr_i > 32923.5) => -0.0819822088,
            (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0011996360, -0.0148043281),
         (r_S66_adlperssn_count_i = NULL) => -0.0524667764, -0.0058966582),
      (r_L79_adls_per_addr_curr_i = NULL) => 0.0027611299, 0.0027611299),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0022901983, 0.0022901983),
(r_I60_inq_auto_count12_i > 1.5) => -0.0812882529,
(r_I60_inq_auto_count12_i = NULL) => 0.0040073796, 0.0006760518);

// Tree: 77 
e_final_score_77 := map(
(NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => -0.0221218314,
(r_C12_Num_NonDerogs_d > 1.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 95) => -0.0171132560,
   (r_F01_inp_addr_address_score_d > 95) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -2888.5) => 0.0228889489,
      (r_A49_Curr_AVM_Chg_1yr_i > -2888.5) => -0.0010001830,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
         map(
				          (r_D31_bk_chapter_n = '') => 
            map(
            (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 0.5) => 0.0381306125,
            (r_C14_addrs_15yr_i > 0.5) => 0.0012205577,
            (r_C14_addrs_15yr_i = NULL) => 0.0066250947, 0.0066250947),
         (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 10) => 0.0641719094,
         ((Integer)r_D31_bk_chapter_n > 10) => 0.0103150759,
 0.0099203845), 0.0077941789),
   (r_F01_inp_addr_address_score_d = NULL) => -0.0273876140, 0.0030416951),
(r_C12_Num_NonDerogs_d = NULL) => 0.0204189423, -0.0014728262);

// Tree: 78 
e_final_score_78 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0705261552,
(r_I60_inq_hiRiskCred_recency_d > 505.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 5.5) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0052829969,
         (r_S66_adlperssn_count_i > 1.5) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 24064.5) => -0.0023167059,
            (r_A49_Curr_AVM_Chg_1yr_i > 24064.5) => -0.0564147036,
            (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0114739431, -0.0119787783),
         (r_S66_adlperssn_count_i = NULL) => -0.0093607042, -0.0023496370),
      (r_E57_br_source_count_d > 0.5) => 0.0208345551,
      (r_E57_br_source_count_d = NULL) => 0.0002999075, 0.0002999075),
   (r_C23_inp_addr_occ_index_d > 5.5) => 0.0486251258,
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0009743425, 0.0009743425),
(r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0005187115, -0.0014669413);

// Tree: 79 
e_final_score_79 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 9) => -0.0783216009,
(r_I60_inq_hiRiskCred_recency_d > 9) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 
      map(
      (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 6.5) => 
         map(
         (Fin_Class in ['TSP','UNK']) => -0.0176458636,
         (Fin_Class in ['BAI']) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 85.75) => 0.0198090904,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i > 85.75) => -0.0043489612,
            (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0151451849, 0.0071418556),
         (Fin_Class = '') => 0.0003536873, 0.0003536873),
      (r_L79_adls_per_addr_curr_i > 6.5) => -0.0659628609,
      (r_L79_adls_per_addr_curr_i = NULL) => -0.0008458831, -0.0008458831),
   (r_F03_input_add_not_most_rec_i > 0.5) => -0.0134257399,
   (r_F03_input_add_not_most_rec_i = NULL) => -0.0027677457, -0.0027677457),
(r_I60_inq_hiRiskCred_recency_d = NULL) => 0.0004986335, -0.0044642701);

// Tree: 80 
e_final_score_80 := map(
(NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 3.5) => 
   map(
   (NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
      map(
      (NULL < r_D33_Eviction_Recency_d and r_D33_Eviction_Recency_d <= 549) => -0.0502142061,
      (r_D33_Eviction_Recency_d > 549) => 0.0038302264,
      (r_D33_Eviction_Recency_d = NULL) => -0.0000379247, -0.0000379247),
   (r_L72_Add_Vacant_i > 0.5) => -0.0851710762,
   (r_L72_Add_Vacant_i = NULL) => -0.0009043038, -0.0009043038),
(r_L79_adls_per_addr_curr_i > 3.5) => -0.0213301972,
(r_L79_adls_per_addr_curr_i = NULL) => 
   map(
   (pat_type in ['E','S']) => -0.0567197188,
   (pat_type in ['I','NA','O']) => 
      map(
      (Fin_Class in ['TSP','UNK']) => -0.0025705860,
      (Fin_Class in ['BAI']) => 0.0852499625,
      (Fin_Class = '') => 0.0389194369, 0.0389194369),
   (pat_type = '') => -0.0152652042, -0.0152652042), -0.0046601331);

// Tree: 81 
e_final_score_81 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 345.5) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 7.5) => -0.0008397143,
      (r_C14_addrs_15yr_i > 7.5) => -0.0328118199,
      (r_C14_addrs_15yr_i = NULL) => -0.0032631528, -0.0032631528),
   (r_C13_max_lres_d > 345.5) => 
      map(
      (pat_type in ['I','NA','O','S']) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0302554516,
         (r_L79_adls_per_addr_curr_i > 2.5) => -0.0348250837,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0065898024, 0.0065898024),
      (pat_type in ['E']) => 0.0602567453,
      (pat_type = '') => 0.0192388230, 0.0192388230),
   (r_C13_max_lres_d = NULL) => 0.0011531964, -0.0013226971),
(r_L72_Add_Vacant_i > 0.5) => -0.0577550832,
(r_L72_Add_Vacant_i = NULL) => -0.0019141548, -0.0019141548);

// Tree: 82 
e_final_score_82 := map(
(r_D31_bk_chapter_n = '') => 
   map(
   (NULL < r_I60_Inq_Count12_i and r_I60_Inq_Count12_i <= 0.5) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 5.5) => 0.0015651488,
      (r_C23_inp_addr_occ_index_d > 5.5) => 0.0441737547,
      (r_C23_inp_addr_occ_index_d = NULL) => 0.0022314515, 0.0022314515),
   (r_I60_Inq_Count12_i > 0.5) => -0.0251879450,
   (r_I60_Inq_Count12_i = NULL) => -0.0037851581, -0.0010800871),
(NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 9) => 
   map(
   (pat_type in ['E','I']) => -0.0072870903,
   (pat_type in ['NA','O','S']) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 77.8001) => 0.0242972289,
      (r_C12_source_profile_d > 77.8001) => 0.1067418175,
      (r_C12_source_profile_d = NULL) => 0.0496647946, 0.0496647946),
   (pat_type = '') => 0.0223938475, 0.0223938475),
((Integer)r_D31_bk_chapter_n > 9) => -0.0222936985,
 -0.0003327835);

// Tree: 83 
e_final_score_83 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 7.5) => 0.0044330143,
   (r_L79_adls_per_addr_curr_i > 7.5) => -0.1214935522,
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0031527523, 0.0031527523),
(r_C18_invalid_addrs_per_adl_i > 0.5) => 
   map(
	    (r_D31_bk_chapter_n = '') => -0.0114974450,
   (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 12) => 
      map(
      (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
         map(
         (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 67.15) => -0.0142627996,
         (r_C12_source_profile_d > 67.15) => 0.0649539248,
         (r_C12_source_profile_d = NULL) => 0.0424442545, 0.0424442545),
      (r_L70_Add_Standardized_i > 0.5) => -0.0363467722,
      (r_L70_Add_Standardized_i = NULL) => 0.0247496595, 0.0247496595),
   ((Integer)r_D31_bk_chapter_n > 12) => -0.0174132634,
 -0.0095350494),
(r_C18_invalid_addrs_per_adl_i = NULL) => -0.0048755767, -0.0026508298);

// Tree: 84 
e_final_score_84 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 2.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 86.55) => 0.0255973174,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 86.55) => -0.0058159999,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0044500684, 0.0020554897),
(r_S66_adlperssn_count_i > 2.5) => -0.0214420578,
(r_S66_adlperssn_count_i = NULL) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 0.5) => 
      map(
      (pat_type in ['E','I']) => 0.0289787076,
      (pat_type in ['NA','O','S']) => 0.1561029991,
      (pat_type = '') => 0.0912945367, 0.0912945367),
   (r_L79_adls_per_addr_curr_i > 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 6850.5) => 0.0628678337,
      (r_A49_Curr_AVM_Chg_1yr_i > 6850.5) => -0.0465564862,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0146883599, 0.0103641837),
   (r_L79_adls_per_addr_curr_i = NULL) => 0.0183951946, 0.0233629531), 0.0009243018);

// Tree: 85 
e_final_score_85 := map(
(NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 265185.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0031420506,
   (r_C23_inp_addr_occ_index_d > 4.5) => 0.0500630297,
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0019714218, -0.0019714218),
(r_A46_Curr_AVM_AutoVal_d > 265185.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -33106) => 0.1123091469,
   (r_A49_Curr_AVM_Chg_1yr_i > -33106) => 0.0108886941,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0327056839, 0.0227412189),
(r_A46_Curr_AVM_AutoVal_d = NULL) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0086679803,
   (r_C18_invalid_addrs_per_adl_i > 0.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 2.5) => -0.0097187087,
      (r_S66_adlperssn_count_i > 2.5) => -0.0361221011,
      (r_S66_adlperssn_count_i = NULL) => 0.0766072667, -0.0114395385),
   (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0082695677, -0.0011400006), 0.0009065562);

// Tree: 86 
e_final_score_86 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 
   map(
   (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 3.5) => 
      map(
      (pat_type in ['I']) => -0.0228796781,
      (pat_type in ['E','NA','O','S']) => 0.0070228301,
      (pat_type = '') => 0.0041513447, 0.0041513447),
   (r_C14_addrs_15yr_i > 3.5) => 
      map(
      (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 4.5) => -0.0157781532,
      (r_D31_attr_bankruptcy_recency_d > 4.5) => 0.0268695994,
      (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0118802403, -0.0118802403),
   (r_C14_addrs_15yr_i = NULL) => -0.0074385812, -0.0015545425),
(r_L79_adls_per_addr_c6_i > 2.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 80.6) => -0.0476902481,
   (r_C12_source_profile_d > 80.6) => 0.0523401633,
   (r_C12_source_profile_d = NULL) => -0.0321575755, -0.0321575755),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0026982722, -0.0026982722);

// Tree: 87 
e_final_score_87 := map(
(NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 2.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 10714) => -0.1173312978,
   (r_A46_Curr_AVM_AutoVal_d > 10714) => -0.0018184688,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 336.5) => -0.0081164672,
      (r_C21_M_Bureau_ADL_FS_d > 336.5) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => 0.0106416765,
         (k_comb_age_d > 70.5) => 
            map(
            (pat_type in ['I','O']) => 0.0020094547,
            (pat_type in ['E','NA','S']) => 0.0861411698,
            (pat_type = '') => 0.0437440850, 0.0437440850),
         (k_comb_age_d = NULL) => 0.0187185370, 0.0187185370),
      (r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0015981460, -0.0015981460), -0.0024368082),
(r_E57_br_source_count_d > 2.5) => 0.0892395019,
(r_E57_br_source_count_d = NULL) => 0.0067375536, -0.0015591627);

// Tree: 88 
e_final_score_88 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 3.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => 
         map(
         (NULL < k_estimated_income_d and k_estimated_income_d <= 65500) => 0.0025173079,
         (k_estimated_income_d > 65500) => 0.0339520361,
         (k_estimated_income_d = NULL) => 0.0046872176, 0.0046872176),
      (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0150035140,
      (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0162873466, 0.0021430311),
   (r_S66_adlperssn_count_i > 3.5) => -0.0348650536,
   (r_S66_adlperssn_count_i = NULL) => 0.0003780935, 0.0007934482),
(r_L79_adls_per_addr_c6_i > 3.5) => 
   map(
   (pat_type in ['I','NA','O','S']) => -0.0922541365,
   (pat_type in ['E']) => 0.0104582204,
   (pat_type = '') => -0.0371764958, -0.0371764958),
(r_L79_adls_per_addr_c6_i = NULL) => 0.0002269777, 0.0002269777);

// Tree: 89 
e_final_score_89 := map(
(NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 39961) => -0.0362892089,
   (r_L80_Inp_AVM_AutoVal_d > 39961) => 
      map(
      (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 21344.5) => 0.0169107802,
         (r_A49_Curr_AVM_Chg_1yr_i > 21344.5) => -0.0084730125,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0316466754, 0.0138478866),
      (r_F03_input_add_not_most_rec_i > 0.5) => -0.0322493850,
      (r_F03_input_add_not_most_rec_i = NULL) => 0.0435962989, 0.0096312542),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0015571432, 0.0032973493),
(r_L79_adls_per_addr_c6_i > 0.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 79.5) => -0.0101931372,
   (r_D31_attr_bankruptcy_recency_d > 79.5) => 0.0672431495,
   (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0498996863, -0.0095054638),
(r_L79_adls_per_addr_c6_i = NULL) => -0.0008006020, -0.0008006020);

// Tree: 90 
e_final_score_90 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 435.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 78901) => -0.0124733964,
      (r_A46_Curr_AVM_AutoVal_d > 78901) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 0.0008316069,
         (r_F04_curr_add_occ_index_d > 2) => 0.0367192667,
         (r_F04_curr_add_occ_index_d = NULL) => 0.0068055759, 0.0068055759),
      (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0069332006, -0.0024172868),
   (r_C23_inp_addr_occ_index_d > 4.5) => 0.0247676586,
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0013471102, -0.0013471102),
(r_C21_M_Bureau_ADL_FS_d > 435.5) => 0.0576962778,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 
   map(
   (pat_type in ['E','I','S']) => -0.0120274223,
   (pat_type in ['NA','O']) => 0.0688210721,
   (pat_type = '') => 0.0146442460, 0.0146442460), -0.0000691647);

// Tree: 91 
e_final_score_91 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_I61_inq_collection_recency_d and r_I61_inq_collection_recency_d <= 505.5) => -0.0490229606,
   (r_I61_inq_collection_recency_d > 505.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 71.5) => 0.0000437636,
      (k_comb_age_d > 71.5) => 
         map(
         (pat_type in ['I','NA','O']) => 
            map(
            (NULL < r_C14_addrs_5yr_i and r_C14_addrs_5yr_i <= 0.5) => 0.0160019221,
            (r_C14_addrs_5yr_i > 0.5) => -0.0437536448,
            (r_C14_addrs_5yr_i = NULL) => 0.0022379994, 0.0022379994),
         (pat_type in ['E','S']) => 0.0450294415,
         (pat_type = '') => 0.0166435656, 0.0166435656),
      (k_comb_age_d = NULL) => 0.0462758290, 0.0023668650),
   (r_I61_inq_collection_recency_d = NULL) => -0.0130604128, 0.0002922288),
(r_L72_Add_Vacant_i > 0.5) => -0.0432171102,
(r_L72_Add_Vacant_i = NULL) => -0.0000701137, -0.0000701137);

// Tree: 92 
e_final_score_92 := map(
(NULL < r_D31_bk_dism_hist_count_i and r_D31_bk_dism_hist_count_i <= 0.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => -0.0002015919,
   (r_C23_inp_addr_occ_index_d > 3.5) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 265.5) => 
         map(
         (pat_type in ['E','O','S']) => -0.0069815954,
         (pat_type in ['I','NA']) => 0.0366599813,
         (pat_type = '') => 0.0072729314, 0.0072729314),
      (r_C13_max_lres_d > 265.5) => 
         map(
         (NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 0.1007190835,
         (r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => 0.0430576892,
         (r_F00_Addr_Not_Ver_w_SSN_i = NULL) => 0.0711491377, 0.0711491377),
      (r_C13_max_lres_d = NULL) => 0.0155044013, 0.0155044013),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0015169432, 0.0015169432),
(r_D31_bk_dism_hist_count_i > 0.5) => -0.0879571312,
(r_D31_bk_dism_hist_count_i = NULL) => -0.0075006346, 0.0002572592);

// Tree: 93 
e_final_score_93 := map(
(NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 1.5) => -0.0157158255,
(r_C12_Num_NonDerogs_d > 1.5) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 83.95) => 0.0296395651,
   (r_A49_Curr_AVM_Chg_1yr_Pct_i > 83.95) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 2.5) => 0.0056209137,
      (r_S66_adlperssn_count_i > 2.5) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 121829.5) => -0.0861512980,
         (r_L80_Inp_AVM_AutoVal_d > 121829.5) => 
            map(
            (pat_type in ['I','O']) => -0.0683267356,
            (pat_type in ['E','NA','S']) => 0.0371501419,
            (pat_type = '') => 0.0053303017, 0.0053303017),
         (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0340009593, -0.0340009593),
      (r_S66_adlperssn_count_i = NULL) => -0.0238326391, -0.0008099330),
   (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0071378634, 0.0050373170),
(r_C12_Num_NonDerogs_d = NULL) => -0.0096680473, 0.0003361170);

// Tree: 94 
e_final_score_94 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 352.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0015408353,
   (r_C23_inp_addr_occ_index_d > 4.5) => 
      map(
      (pat_type in ['E','I','O','S']) => -0.0018304192,
      (pat_type in ['NA']) => 0.0757098595,
      (pat_type = '') => 0.0174399459, 0.0174399459),
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0007695557, -0.0007695557),
(r_C13_max_lres_d > 352.5) => 
   map(
   (pat_type in ['I','O']) => 0.0035235800,
   (pat_type in ['E','NA','S']) => 
      map(
      (NULL < k_nap_fname_verd_d and k_nap_fname_verd_d <= 0.5) => 0.0095425680,
      (k_nap_fname_verd_d > 0.5) => 0.0874540628,
      (k_nap_fname_verd_d = NULL) => 0.0484983154, 0.0484983154),
   (pat_type = '') => 0.0279663710, 0.0279663710),
(r_C13_max_lres_d = NULL) => 0.0089708967, 0.0015284533);

// Tree: 95 
e_final_score_95 := map(
(NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 2.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 89.5) => 
      map(
      (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => -0.0025182432,
      (r_F03_input_add_not_most_rec_i > 0.5) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 32746.5) => -0.1246816268,
         (r_A46_Curr_AVM_AutoVal_d > 32746.5) => 
            map(
            (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0242976869,
            (r_C18_invalid_addrs_per_adl_i > 0.5) => -0.0314540081,
            (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0010959714, 0.0010959714),
         (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0135763939, -0.0129635815),
      (r_F03_input_add_not_most_rec_i = NULL) => -0.0041334020, -0.0041334020),
   (k_comb_age_d > 89.5) => 0.0273108174,
   (k_comb_age_d = NULL) => 0.0258863857, -0.0032736942),
(r_E57_br_source_count_d > 2.5) => 0.0719302928,
(r_E57_br_source_count_d = NULL) => -0.0110689307, -0.0030491982);

// Tree: 96 
e_final_score_96 := map(
(Fin_Class in ['TSP','UNK']) => -0.0144012921,
(Fin_Class in ['BAI']) => 
   map(
   (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0041325285,
   (r_F03_address_match_d > 3.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 84.45) => 
         map(
         (NULL < k_comb_age_d and k_comb_age_d <= 45.5) => -0.0183951174,
         (k_comb_age_d > 45.5) => 
            map(
            (pat_type in ['I','NA']) => 0.0245161482,
            (pat_type in ['E','O','S']) => 0.1058385585,
            (pat_type = '') => 0.0602416001, 0.0602416001),
         (k_comb_age_d = NULL) => 0.0298465568, 0.0298465568),
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 84.45) => -0.0019416542,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0140480312, 0.0076093863),
   (r_F03_address_match_d = NULL) => 0.0503268430, 0.0054538319),
(Fin_Class = '') => -0.0006709110, -0.0006709110);

// Tree: 97 
e_final_score_97 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 416) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
      map(
      (NULL < r_C13_Curr_Addr_LRes_d and r_C13_Curr_Addr_LRes_d <= 305.5) => -0.0041068024,
      (r_C13_Curr_Addr_LRes_d > 305.5) => 0.0160363797,
      (r_C13_Curr_Addr_LRes_d = NULL) => -0.0029233157, -0.0029233157),
   (r_C23_inp_addr_occ_index_d > 4.5) => 
      map(
      (pat_type in ['E','I','O']) => 
         map(
         (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 211.5) => -0.0202765884,
         (r_C13_max_lres_d > 211.5) => 0.0538876508,
         (r_C13_max_lres_d = NULL) => -0.0013109241, -0.0013109241),
      (pat_type in ['NA','S']) => 0.0746067740,
      (pat_type = '') => 0.0226735183, 0.0226735183),
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0018104099, -0.0018104099),
(r_C21_M_Bureau_ADL_FS_d > 416) => 0.0530024309,
(r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0147355921, -0.0004435138);

// Tree: 98 
e_final_score_98 := map(
(NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => -0.0020496726,
(r_C23_inp_addr_occ_index_d > 4.5) => 
   map(
   (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => -0.0318459109,
   (r_F01_inp_addr_address_score_d > 25) => 
      map(
      (NULL < r_Ever_Asset_Owner_d and r_Ever_Asset_Owner_d <= 0.5) => -0.0051741382,
      (r_Ever_Asset_Owner_d > 0.5) => 
         map(
         (pat_type in ['E']) => -0.0026804872,
         (pat_type in ['I','NA','O','S']) => 0.0817674170,
         (pat_type = '') => 0.0571177585, 0.0571177585),
      (r_Ever_Asset_Owner_d = NULL) => 0.0365794882, 0.0365794882),
   (r_F01_inp_addr_address_score_d = NULL) => 0.0194731384, 0.0194731384),
(r_C23_inp_addr_occ_index_d = NULL) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0059784472,
   (r_S66_adlperssn_count_i > 1.5) => -0.1220793495,
   (r_S66_adlperssn_count_i = NULL) => 0.0120271334, -0.0129788231), -0.0015966502);

// Tree: 99 
e_final_score_99 := map(
(NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 
   map(
   (NULL < r_A43_watercraft_cnt_d and r_A43_watercraft_cnt_d <= 1.5) => -0.0042623348,
   (r_A43_watercraft_cnt_d > 1.5) => 0.0553815502,
   (r_A43_watercraft_cnt_d = NULL) => -0.0037775503, -0.0037775503),
(r_E55_College_Ind_d > 0.5) => 
   map(
   (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 1.5) => 0.0208815030,
   (r_D30_Derog_Count_i > 1.5) => -0.0534166848,
   (r_D30_Derog_Count_i = NULL) => 0.0142934864, 0.0142934864),
(r_E55_College_Ind_d = NULL) => 
   map(
   (Fin_Class in ['TSP']) => -0.0511507759,
   (Fin_Class in ['BAI','UNK']) => 
      map(
      (pat_type in ['E','I','S']) => 0.0050146908,
      (pat_type in ['NA','O']) => 0.0808723628,
      (pat_type = '') => 0.0425890517, 0.0425890517),
   (Fin_Class = '') => -0.0186907061, -0.0186907061), -0.0019018920);

// Tree: 100 
e_final_score_100 := map(
(NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 85) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 201713) => -0.0223894521,
   (r_L80_Inp_AVM_AutoVal_d > 201713) => 
      map(
      (NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 112.5) => -0.0058949205,
      (r_C13_max_lres_d > 112.5) => 0.0774923681,
      (r_C13_max_lres_d = NULL) => 0.0441374527, 0.0441374527),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 79.5) => -0.0245397961,
      (k_comb_age_d > 79.5) => 0.0415439363,
      (k_comb_age_d = NULL) => -0.0213357363, -0.0213357363), -0.0164561003),
(r_F01_inp_addr_address_score_d > 85) => 
   map(
   (NULL < r_I61_inq_collection_count12_i and r_I61_inq_collection_count12_i <= 0.5) => 0.0063414113,
   (r_I61_inq_collection_count12_i > 0.5) => -0.0496710186,
   (r_I61_inq_collection_count12_i = NULL) => 0.0047912518, 0.0047912518),
(r_F01_inp_addr_address_score_d = NULL) => -0.0051056699, 0.0002327591);

// Tree: 101 
e_final_score_101 := map(
(NULL < r_C13_max_lres_d and r_C13_max_lres_d <= 457.5) => 
   map(
   (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 
      map(
      (NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => -0.0138867885,
      (r_F03_address_match_d > 3.5) => 0.0110134563,
      (r_F03_address_match_d = NULL) => 0.0014807474, 0.0014807474),
   (r_L79_adls_per_addr_curr_i > 2.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 260848) => -0.0169709018,
      (r_L80_Inp_AVM_AutoVal_d > 260848) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 5095.5) => 0.0614699451,
         (r_A49_Curr_AVM_Chg_1yr_i > 5095.5) => -0.0115085980,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0807973550, 0.0249050485),
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0138808375, -0.0106340245),
   (r_L79_adls_per_addr_curr_i = NULL) => -0.0028022947, -0.0028022947),
(r_C13_max_lres_d > 457.5) => 0.0386762242,
(r_C13_max_lres_d = NULL) => 0.0007358248, -0.0017508598);

// Tree: 102 
e_final_score_102 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => 0.0061410575,
   (r_E55_College_Ind_d > 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -19400.5) => 0.0594261134,
      (r_A49_Curr_AVM_Chg_1yr_i > -19400.5) => -0.0005042455,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0438158219, 0.0260412517),
   (r_E55_College_Ind_d = NULL) => 0.0091274934, 0.0091274934),
(r_C18_invalid_addrs_per_adl_i > 0.5) => 
   map(
   (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 2) => 
      map(
      (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => -0.0108722360,
      (r_C23_inp_addr_occ_index_d > 3.5) => 0.0177597814,
      (r_C23_inp_addr_occ_index_d = NULL) => -0.0074123386, -0.0074123386),
   (r_D31_attr_bankruptcy_recency_d > 2) => 0.0296398437,
   (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0040681134, -0.0040681134),
(r_C18_invalid_addrs_per_adl_i = NULL) => -0.0161238865, 0.0026057026);

// Tree: 103 
e_final_score_103 := map(
(NULL < r_C23_inp_addr_owned_not_occ_d and r_C23_inp_addr_owned_not_occ_d <= 0.5) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 12230.5) => -0.0739002027,
   (r_A46_Curr_AVM_AutoVal_d > 12230.5) => -0.0006919914,
   (r_A46_Curr_AVM_AutoVal_d = NULL) => 
      map(
      (Fin_Class in ['TSP','UNK']) => -0.0182852312,
      (Fin_Class in ['BAI']) => 
         map(
         (pat_type in ['O','S']) => -0.0065196155,
         (pat_type in ['E','I','NA']) => 0.0203083620,
         (pat_type = '') => 0.0107924554, 0.0107924554),
      (Fin_Class = '') => 0.0006811205, 0.0006811205), -0.0005861150),
(r_C23_inp_addr_owned_not_occ_d > 0.5) => 
   map(
   (NULL < r_C10_M_Hdr_FS_d and r_C10_M_Hdr_FS_d <= 288.5) => -0.0142082125,
   (r_C10_M_Hdr_FS_d > 288.5) => 0.0925802562,
   (r_C10_M_Hdr_FS_d = NULL) => 0.0360451845, 0.0360451845),
(r_C23_inp_addr_owned_not_occ_d = NULL) => -0.0236220351, -0.0008660203);

// Tree: 104 
e_final_score_104 := map(
(NULL < r_A43_watercraft_cnt_d and r_A43_watercraft_cnt_d <= 1.5) => 
   map(
   (NULL < r_I60_inq_recency_d and r_I60_inq_recency_d <= 9) => -0.0327234574,
   (r_I60_inq_recency_d > 9) => 
      map(
      (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 
         map(
         (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 79.5) => 0.0004026138,
         (r_D31_attr_bankruptcy_recency_d > 79.5) => 
            map(
            (pat_type in ['E','I','O']) => 0.0046900825,
            (pat_type in ['NA','S']) => 0.0904182037,
            (pat_type = '') => 0.0327647888, 0.0327647888),
         (r_D31_attr_bankruptcy_recency_d = NULL) => 0.0011633963, 0.0011633963),
      (r_D34_unrel_liens_ct_i > 0.5) => -0.0254948788,
      (r_D34_unrel_liens_ct_i = NULL) => -0.0021375802, -0.0021375802),
   (r_I60_inq_recency_d = NULL) => -0.0042534549, -0.0042534549),
(r_A43_watercraft_cnt_d > 1.5) => 0.0578717291,
(r_A43_watercraft_cnt_d = NULL) => -0.0148160874, -0.0041294210);

// Tree: 105 
e_final_score_105 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 4.5) => 
      map(
      (pat_type in ['E','I','NA','O']) => -0.0042125014,
      (pat_type in ['S']) => 
         map(
         (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 98579) => -0.0140549039,
         (r_A46_Curr_AVM_AutoVal_d > 98579) => 0.0618261127,
         (r_A46_Curr_AVM_AutoVal_d = NULL) => 
            map(
            (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 347) => -0.0162242066,
            (r_C21_M_Bureau_ADL_FS_d > 347) => 0.0785511579,
            (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0140590460, 0.0140590460), 0.0262048825),
      (pat_type = '') => -0.0028687899, -0.0028687899),
   (r_C18_invalid_addrs_per_adl_i > 4.5) => -0.0328073615,
   (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0126749834, -0.0040671090),
(r_L72_Add_Vacant_i > 0.5) => -0.0154518044,
(r_L72_Add_Vacant_i = NULL) => -0.0041790856, -0.0041790856);

// Tree: 106 
e_final_score_106 := map(
(NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0081521417,
(r_C18_invalid_addrs_per_adl_i > 0.5) => 
   map(
   (NULL < k_comb_age_d and k_comb_age_d <= 83.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 0.5) => 
         map(
				          (r_D31_bk_chapter_n = '') => 
            map(
            (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 32250) => -0.0727856074,
            (r_L80_Inp_AVM_AutoVal_d > 32250) => 0.0105060627,
            (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0116831090, -0.0032742009),
         (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 12) => 0.0479547216,
         ((Integer)r_D31_bk_chapter_n > 12) => -0.0508986009,
 -0.0018163841),
      (r_L79_adls_per_addr_c6_i > 0.5) => -0.0208466030,
      (r_L79_adls_per_addr_c6_i = NULL) => -0.0077178252, -0.0077178252),
   (k_comb_age_d > 83.5) => 0.0550966448,
   (k_comb_age_d = NULL) => -0.0061857649, -0.0061857649),
(r_C18_invalid_addrs_per_adl_i = NULL) => -0.0127687917, 0.0011007552);

// Tree: 107 
e_final_score_107 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 1.5) => 
      map(
      (NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 18) => -0.0014473067,
      (r_D31_attr_bankruptcy_recency_d > 18) => 
         map(
         (NULL < r_C12_Num_NonDerogs_d and r_C12_Num_NonDerogs_d <= 2.5) => -0.0049481888,
         (r_C12_Num_NonDerogs_d > 2.5) => 
            map(
            (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 15833.5) => 0.0774775530,
            (r_A49_Curr_AVM_Chg_1yr_i > 15833.5) => -0.0034523169,
            (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0236910691, 0.0365717626),
         (r_C12_Num_NonDerogs_d = NULL) => 0.0186951169, 0.0186951169),
      (r_D31_attr_bankruptcy_recency_d = NULL) => -0.0002839121, -0.0002839121),
   (r_I60_inq_auto_count12_i > 1.5) => -0.0783035876,
   (r_I60_inq_auto_count12_i = NULL) => -0.0178564385, -0.0022636566),
(r_L72_Add_Vacant_i > 0.5) => -0.0114917093,
(r_L72_Add_Vacant_i = NULL) => -0.0023464238, -0.0023464238);

// Tree: 108 
e_final_score_108 := map(
(NULL < r_I60_inq_hiRiskCred_recency_d and r_I60_inq_hiRiskCred_recency_d <= 505.5) => -0.0597861084,
(r_I60_inq_hiRiskCred_recency_d > 505.5) => 
   map(
   (NULL < r_C23_inp_addr_owned_not_occ_d and r_C23_inp_addr_owned_not_occ_d <= 0.5) => 
      map(
      (NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
         map(
         (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0130064769,
         (r_C18_invalid_addrs_per_adl_i > 0.5) => -0.0037521031,
         (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0057017247, 0.0057017247),
      (r_D30_Derog_Count_i > 0.5) => -0.0120899432,
      (r_D30_Derog_Count_i = NULL) => 0.0012831946, 0.0012831946),
   (r_C23_inp_addr_owned_not_occ_d > 0.5) => 
      map(
      (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0177902499,
      (r_S66_adlperssn_count_i > 1.5) => -0.0099335007,
      (r_S66_adlperssn_count_i = NULL) => 0.0054445172, 0.0054445172),
   (r_C23_inp_addr_owned_not_occ_d = NULL) => 0.0013531855, 0.0013531855),
(r_I60_inq_hiRiskCred_recency_d = NULL) => -0.0044549658, -0.0010010502);

// Tree: 109 
e_final_score_109 := map(
(NULL < r_F03_address_match_d and r_F03_address_match_d <= 3.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 4.5) => 
      map(
      (pat_type in ['NA','O','S']) => -0.0265398624,
      (pat_type in ['E','I']) => 0.0017947481,
      (pat_type = '') => -0.0084250656, -0.0084250656),
   (r_C23_inp_addr_occ_index_d > 4.5) => 
      map(
      (pat_type in ['E','I','O']) => 
         map(
         (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 25) => -0.0726915405,
         (r_F01_inp_addr_address_score_d > 25) => 0.0050665399,
         (r_F01_inp_addr_address_score_d = NULL) => -0.0118736133, -0.0118736133),
      (pat_type in ['NA','S']) => 0.0526197634,
      (pat_type = '') => 0.0069234513, 0.0069234513),
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0062426041, -0.0062426041),
(r_F03_address_match_d > 3.5) => 0.0063044778,
(r_F03_address_match_d = NULL) => -0.0009467028, 0.0022618645);

// Tree: 110 
e_final_score_110 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 140454) => -0.0066660025,
(r_L80_Inp_AVM_AutoVal_d > 140454) => 
   map(
   (NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 2.5) => 0.0306129831,
      (r_C14_addrs_15yr_i > 2.5) => 
         map(
         (NULL < r_D34_unrel_liens_ct_i and r_D34_unrel_liens_ct_i <= 0.5) => 0.0071926516,
         (r_D34_unrel_liens_ct_i > 0.5) => -0.0629461931,
         (r_D34_unrel_liens_ct_i = NULL) => -0.0027369145, -0.0027369145),
      (r_C14_addrs_15yr_i = NULL) => 0.0164606781, 0.0164606781),
   (r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => -0.0148048919,
   (r_F00_Addr_Not_Ver_w_SSN_i = NULL) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 63500) => -0.0739863074,
      (k_estimated_income_d > 63500) => 0.0178060708,
      (k_estimated_income_d = NULL) => -0.0368322495, -0.0368322495), 0.0088360518),
(r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0057425989, -0.0024870585);

// Tree: 111 
e_final_score_111 := map(
(pat_type in ['E','I','S']) => -0.0062177054,
(pat_type in ['NA','O']) => 
   map(
   (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 74919.5) => 
      map(
      (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 0.5) => -0.0053625091,
      (r_E57_br_source_count_d > 0.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 104.05) => 0.0835574521,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i > 104.05) => -0.0119101318,
         (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 0.0339294621, 0.0339294621),
      (r_E57_br_source_count_d = NULL) => 0.0002762020, 0.0002762020),
   (r_A49_Curr_AVM_Chg_1yr_i > 74919.5) => -0.0504812851,
   (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
      map(
      (NULL < k_estimated_income_d and k_estimated_income_d <= 60500) => 0.0085954155,
      (k_estimated_income_d > 60500) => 0.0553408401,
      (k_estimated_income_d = NULL) => 0.0500479154, 0.0142891605), 0.0072273467),
(pat_type = '') => -0.0002777110, -0.0002777110);

// Tree: 112 
e_final_score_112 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 134.05) => 0.0006874509,
(r_A49_Curr_AVM_Chg_1yr_Pct_i > 134.05) => -0.0475650602,
(r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => 
   map(
   (NULL < (Integer)k_nap_lname_verd_d and (Integer)k_nap_lname_verd_d <= 0.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 70.5) => -0.0090626084,
      (k_comb_age_d > 70.5) => 
         map(
         (pat_type in ['NA','O']) => -0.0137538757,
         (pat_type in ['E','I','S']) => 0.0601767742,
         (pat_type = '') => 0.0244334435, 0.0244334435),
      (k_comb_age_d = NULL) => -0.0018463838, -0.0065286233),
   ((Integer)k_nap_lname_verd_d > 0.5) => 
      map(
      (pat_type in ['I','S']) => -0.0292197725,
      (pat_type in ['E','NA','O']) => 0.0333147828,
      (pat_type = '') => 0.0236687866, 0.0236687866),
   ((Integer)k_nap_lname_verd_d = NULL) => -0.0001539249, -0.0001539249), -0.0015241483);

// Tree: 113 
e_final_score_113 := map(
(NULL < r_D31_bk_dism_hist_count_i and r_D31_bk_dism_hist_count_i <= 0.5) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 200732.5) => -0.0031626621,
   (r_L80_Inp_AVM_AutoVal_d > 200732.5) => 
      map(
      (pat_type in ['NA','S']) => 
         map(
         (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 2) => -0.0227496215,
         (r_C23_inp_addr_occ_index_d > 2) => 0.0594680676,
         (r_C23_inp_addr_occ_index_d = NULL) => -0.0099329336, -0.0099329336),
      (pat_type in ['E','I','O']) => 0.0281252773,
      (pat_type = '') => 0.0115195601, 0.0115195601),
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0012782552, 0.0013428437),
(r_D31_bk_dism_hist_count_i > 0.5) => -0.0688530047,
(r_D31_bk_dism_hist_count_i = NULL) => 
   map(
   (pat_type in ['E','NA','S']) => -0.0060231404,
   (pat_type in ['I','O']) => 0.0785058336,
   (pat_type = '') => 0.0147757869, 0.0147757869), 0.0011435771);

// Tree: 114 
e_final_score_114 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= -86846) => 0.0849316441,
(r_A49_Curr_AVM_Chg_1yr_i > -86846) => -0.0022769376,
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
   map(
   (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 60122.5) => -0.0359224125,
   (r_A46_Curr_AVM_AutoVal_d > 60122.5) => 
      map(
      (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 1.5) => 
         map(
         (NULL < r_F00_Addr_Not_Ver_w_SSN_i and r_F00_Addr_Not_Ver_w_SSN_i <= 0.5) => 0.0417938759,
         (r_F00_Addr_Not_Ver_w_SSN_i > 0.5) => -0.0074056363,
         (r_F00_Addr_Not_Ver_w_SSN_i = NULL) => 0.0319100453, 0.0319100453),
      (r_L79_adls_per_addr_c6_i > 1.5) => 
         map(
         (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => 0.0258166230,
         (r_S66_adlperssn_count_i > 1.5) => -0.0832201763,
         (r_S66_adlperssn_count_i = NULL) => -0.0163442728, -0.0163442728),
      (r_L79_adls_per_addr_c6_i = NULL) => 0.0191368435, 0.0191368435),
   (r_A46_Curr_AVM_AutoVal_d = NULL) => -0.0053276412, -0.0034163175), -0.0024815274);

// Tree: 115 
e_final_score_115 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 3.5) => 0.0019883173,
   (r_S66_adlperssn_count_i > 3.5) => 
      map(
      (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 121829.5) => -0.0863243793,
      (r_L80_Inp_AVM_AutoVal_d > 121829.5) => 0.0330225873,
      (r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0453132236, -0.0334762802),
   (r_S66_adlperssn_count_i = NULL) => 
      map(
      (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
         map(
         (NULL < r_L79_adls_per_addr_curr_i and r_L79_adls_per_addr_curr_i <= 2.5) => 0.0408278012,
         (r_L79_adls_per_addr_curr_i > 2.5) => -0.0228864283,
         (r_L79_adls_per_addr_curr_i = NULL) => 0.0105067506, 0.0152284578),
      (r_L70_Add_Standardized_i > 0.5) => -0.0332655705,
      (r_L70_Add_Standardized_i = NULL) => 0.0003544973, 0.0003544973), 0.0006311389),
(r_L72_Add_Vacant_i > 0.5) => -0.0318360522,
(r_L72_Add_Vacant_i = NULL) => 0.0002942186, 0.0002942186);

// Tree: 116 
e_final_score_116 := map(
(NULL < r_C12_NonDerog_Recency_i and r_C12_NonDerog_Recency_i <= 48) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 66500) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 76508) => 0.0018317714,
      (r_A49_Curr_AVM_Chg_1yr_i > 76508) => -0.0576439173,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0007585364, -0.0001602853),
   (k_estimated_income_d > 66500) => 
      map(
      (pat_type in ['I','S']) => -0.0504534460,
      (pat_type in ['E','NA','O']) => 0.0376171747,
      (pat_type = '') => 0.0276091496, 0.0276091496),
   (k_estimated_income_d = NULL) => 0.0019097200, 0.0019097200),
(r_C12_NonDerog_Recency_i > 48) => -0.0687866184,
(r_C12_NonDerog_Recency_i = NULL) => 
   map(
   (pat_type in ['E','NA','S']) => -0.0107966347,
   (pat_type in ['I','O']) => 0.0879367199,
   (pat_type = '') => 0.0136574470, 0.0136574470), 0.0015491020);

// Tree: 117 
e_final_score_117 := map(
(NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 2.5) => 
   map(
   (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 
      map(
      (pat_type in ['I','NA']) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 21343.5) => 0.0030461590,
         (r_A49_Curr_AVM_Chg_1yr_i > 21343.5) => -0.0335170535,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0096131710, -0.0079987939),
      (pat_type in ['E','O','S']) => 
         map(
         (Fin_Class in ['TSP']) => -0.0172115387,
         (Fin_Class in ['BAI','UNK']) => 0.0124666458,
         (Fin_Class = '') => 0.0034072401, 0.0034072401),
      (pat_type = '') => -0.0003713146, -0.0003713146),
   (r_F03_input_add_not_most_rec_i > 0.5) => -0.0119726137,
   (r_F03_input_add_not_most_rec_i = NULL) => -0.0022338965, -0.0022338965),
(r_E57_br_source_count_d > 2.5) => 0.0782873477,
(r_E57_br_source_count_d = NULL) => 0.0206160511, -0.0010241751);

// Tree: 118 
e_final_score_118 := map(
(NULL < r_D31_attr_bankruptcy_recency_d and r_D31_attr_bankruptcy_recency_d <= 79.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => -0.0004844267,
   (r_C23_inp_addr_occ_index_d > 3.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 6996.5) => 0.0325902509,
      (r_A49_Curr_AVM_Chg_1yr_i > 6996.5) => -0.0569078143,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0163809815, 0.0106201162),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0007354195, 0.0007354195),
(r_D31_attr_bankruptcy_recency_d > 79.5) => 
   map(
   (pat_type in ['E','I','O']) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 0.5) => 0.0737877364,
      (r_C18_invalid_addrs_per_adl_i > 0.5) => -0.0092665270,
      (r_C18_invalid_addrs_per_adl_i = NULL) => 0.0220966214, 0.0220966214),
   (pat_type in ['NA','S']) => 0.0963902346,
   (pat_type = '') => 0.0469763430, 0.0469763430),
(r_D31_attr_bankruptcy_recency_d = NULL) => -0.0243994654, 0.0009671487);

// Tree: 119 
e_final_score_119 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 72630.5) => 0.0025970196,
(r_A49_Curr_AVM_Chg_1yr_i > 72630.5) => 
   map(
   (NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 1.5) => -0.0053701057,
   (r_S66_adlperssn_count_i > 1.5) => -0.0189327382,
   (r_S66_adlperssn_count_i = NULL) => -0.0120303270, -0.0120303270),
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
   map(
   (NULL < r_E55_College_Ind_d and r_E55_College_Ind_d <= 0.5) => -0.0090920223,
   (r_E55_College_Ind_d > 0.5) => 
      map(
      (NULL < r_L70_Add_Standardized_i and r_L70_Add_Standardized_i <= 0.5) => 
         map(
         (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 85) => -0.0452280940,
         (r_F01_inp_addr_address_score_d > 85) => 0.0266426601,
         (r_F01_inp_addr_address_score_d = NULL) => 0.0174021346, 0.0174021346),
      (r_L70_Add_Standardized_i > 0.5) => -0.0100159362,
      (r_L70_Add_Standardized_i = NULL) => 0.0119007741, 0.0119007741),
   (r_E55_College_Ind_d = NULL) => 0.0025438607, -0.0061149162), -0.0027817604);

// Tree: 120 
e_final_score_120 := map(
(NULL < r_L72_Add_Vacant_i and r_L72_Add_Vacant_i <= 0.5) => 
   map(
   (NULL < r_E57_br_source_count_d and r_E57_br_source_count_d <= 2.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 84.5) => 
         map(
         (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 74207) => -0.0020832277,
         (r_A49_Curr_AVM_Chg_1yr_i > 74207) => -0.0533682899,
         (r_A49_Curr_AVM_Chg_1yr_i = NULL) => -0.0045524641, -0.0042192377),
      (k_comb_age_d > 84.5) => 
         map(
         (NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 298.5) => -0.0483109504,
         (r_C21_M_Bureau_ADL_FS_d > 298.5) => 0.0546508388,
         (r_C21_M_Bureau_ADL_FS_d = NULL) => 0.0269504590, 0.0269504590),
      (k_comb_age_d = NULL) => 0.0036661887, -0.0033723353),
   (r_E57_br_source_count_d > 2.5) => 0.0667882586,
   (r_E57_br_source_count_d = NULL) => -0.0030565321, -0.0029259850),
(r_L72_Add_Vacant_i > 0.5) => -0.0674756096,
(r_L72_Add_Vacant_i = NULL) => -0.0035961952, -0.0035961952);

// Tree: 121 
e_final_score_121 := map(
(NULL < r_C21_M_Bureau_ADL_FS_d and r_C21_M_Bureau_ADL_FS_d <= 508.5) => 
   map(
   (NULL < r_C14_Addr_Stability_v2_d and r_C14_Addr_Stability_v2_d <= 1.5) => 
      map(
      (pat_type in ['E']) => -0.0281171164,
      (pat_type in ['I','NA','O','S']) => 
         map(
         (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 107005.5) => -0.0552145835,
         (r_L80_Inp_AVM_AutoVal_d > 107005.5) => 0.0122144766,
         (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0379775466, 0.0180438365),
      (pat_type = '') => -0.0065704106, -0.0065704106),
   (r_C14_Addr_Stability_v2_d > 1.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 89423) => 0.0005804631,
      (r_A49_Curr_AVM_Chg_1yr_i > 89423) => -0.0556906300,
      (r_A49_Curr_AVM_Chg_1yr_i = NULL) => 0.0032887891, 0.0013996698),
   (r_C14_Addr_Stability_v2_d = NULL) => 0.0002778949, 0.0002778949),
(r_C21_M_Bureau_ADL_FS_d > 508.5) => 0.0561821423,
(r_C21_M_Bureau_ADL_FS_d = NULL) => -0.0217388199, -0.0000514708);

// Tree: 122 
e_final_score_122 := map(
(NULL < r_S66_adlperssn_count_i and r_S66_adlperssn_count_i <= 4.5) => 
   map(
   (NULL < r_L79_adls_per_addr_c6_i and r_L79_adls_per_addr_c6_i <= 2.5) => 
      map(
      (NULL < r_A46_Curr_AVM_AutoVal_d and r_A46_Curr_AVM_AutoVal_d <= 224417.5) => 
         map(
         (NULL < r_F00_nas_ssn_no_addr_verd_i and r_F00_nas_ssn_no_addr_verd_i <= 0.5) => -0.0005902320,
         (r_F00_nas_ssn_no_addr_verd_i > 0.5) => -0.0500020969,
         (r_F00_nas_ssn_no_addr_verd_i = NULL) => -0.0079980461, -0.0079980461),
      (r_A46_Curr_AVM_AutoVal_d > 224417.5) => 0.0147773354,
      (r_A46_Curr_AVM_AutoVal_d = NULL) => 
         map(
         (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 4.5) => 0.0036870201,
         (r_C18_invalid_addrs_per_adl_i > 4.5) => -0.0485807805,
         (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0274124041, 0.0009457153), -0.0007710764),
   (r_L79_adls_per_addr_c6_i > 2.5) => -0.0174878052,
   (r_L79_adls_per_addr_c6_i = NULL) => -0.0013265153, -0.0013265153),
(r_S66_adlperssn_count_i > 4.5) => -0.0686005762,
(r_S66_adlperssn_count_i = NULL) => 0.0157054952, -0.0005587867);

// Tree: 123 
e_final_score_123 := map(
(NULL < r_I60_inq_hiRiskCred_count12_i and r_I60_inq_hiRiskCred_count12_i <= 0.5) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => 0.0008214659,
   (r_C23_inp_addr_occ_index_d > 3.5) => 
      map(
      (NULL < r_C14_addrs_15yr_i and r_C14_addrs_15yr_i <= 2.5) => 
         map(
         (Fin_Class in ['TSP']) => -0.0034720150,
         (Fin_Class in ['BAI','UNK']) => 0.0498460073,
         (Fin_Class = '') => 0.0314639843, 0.0314639843),
      (r_C14_addrs_15yr_i > 2.5) => -0.0075772425,
      (r_C14_addrs_15yr_i = NULL) => 0.0141123280, 0.0141123280),
   (r_C23_inp_addr_occ_index_d = NULL) => 0.0022739771, 0.0022739771),
(r_I60_inq_hiRiskCred_count12_i > 0.5) => -0.0528855338,
(r_I60_inq_hiRiskCred_count12_i = NULL) => 
   map(
   (NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 144208) => -0.0320947127,
   (r_L80_Inp_AVM_AutoVal_d > 144208) => 0.1048194127,
   (r_L80_Inp_AVM_AutoVal_d = NULL) => 0.0078628731, 0.0159233068), 0.0009257581);

// Tree: 124 
e_final_score_124 := map(
(NULL < r_L80_Inp_AVM_AutoVal_d and r_L80_Inp_AVM_AutoVal_d <= 56322.5) => -0.0156185483,
(r_L80_Inp_AVM_AutoVal_d > 56322.5) => 
   map(
   (NULL < r_D31_bk_disposed_hist_count_i and r_D31_bk_disposed_hist_count_i <= 0.5) => 
      map(
      (NULL < r_F03_input_add_not_most_rec_i and r_F03_input_add_not_most_rec_i <= 0.5) => 
         map(
         (NULL < r_F04_curr_add_occ_index_d and r_F04_curr_add_occ_index_d <= 2) => 0.0062440707,
         (r_F04_curr_add_occ_index_d > 2) => 0.0294973280,
         (r_F04_curr_add_occ_index_d = NULL) => 0.0092097878, 0.0092097878),
      (r_F03_input_add_not_most_rec_i > 0.5) => -0.0254143049,
      (r_F03_input_add_not_most_rec_i = NULL) => 0.0051672840, 0.0051672840),
   (r_D31_bk_disposed_hist_count_i > 0.5) => 
      map(
      (NULL < r_A49_Curr_AVM_Chg_1yr_Pct_i and r_A49_Curr_AVM_Chg_1yr_Pct_i <= 105.7) => 0.0222278167,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i > 105.7) => -0.0786194838,
      (r_A49_Curr_AVM_Chg_1yr_Pct_i = NULL) => -0.0344124480, -0.0344124480),
   (r_D31_bk_disposed_hist_count_i = NULL) => 0.0536455433, 0.0043023762),
(r_L80_Inp_AVM_AutoVal_d = NULL) => -0.0040138125, -0.0014431648);

// Tree: 125 
e_final_score_125 := map(
(NULL < k_estimated_income_d and k_estimated_income_d <= 64500) => 
   map(
   (NULL < r_C23_inp_addr_occ_index_d and r_C23_inp_addr_occ_index_d <= 3.5) => -0.0025284067,
   (r_C23_inp_addr_occ_index_d > 3.5) => 
      map(
      (NULL < k_comb_age_d and k_comb_age_d <= 56.5) => 
         map(
         (NULL < r_F01_inp_addr_address_score_d and r_F01_inp_addr_address_score_d <= 11) => -0.0419572060,
         (r_F01_inp_addr_address_score_d > 11) => 0.0055709146,
         (r_F01_inp_addr_address_score_d = NULL) => -0.0000292981, -0.0000292981),
      (k_comb_age_d > 56.5) => 
         map(
         (pat_type in ['E','I']) => -0.0101188197,
         (pat_type in ['NA','O','S']) => 0.0624812226,
         (pat_type = '') => 0.0320905072, 0.0320905072),
      (k_comb_age_d = NULL) => 0.0088527060, 0.0088527060),
   (r_C23_inp_addr_occ_index_d = NULL) => -0.0011952971, -0.0011952971),
(k_estimated_income_d > 64500) => 0.0233980561,
(k_estimated_income_d = NULL) => 0.0021230480, 0.0007950822);

// Tree: 126 
e_final_score_126 := map(
(NULL < r_A49_Curr_AVM_Chg_1yr_i and r_A49_Curr_AVM_Chg_1yr_i <= 77836) => 
   map(
   (pat_type in ['I','NA']) => -0.0150648121,
   (pat_type in ['E','O','S']) => 0.0049278795,
   (pat_type = '') => -0.0021195975, -0.0021195975),
(r_A49_Curr_AVM_Chg_1yr_i > 77836) => 
   map(
   (pat_type in ['NA','O']) => -0.1000027085,
   (pat_type in ['E','I','S']) => 0.0165305181,
   (pat_type = '') => -0.0397269016, -0.0397269016),
(r_A49_Curr_AVM_Chg_1yr_i = NULL) => 
   map(
   (NULL < (Integer)k_nap_lname_verd_d and (Integer)k_nap_lname_verd_d <= 0.5) => 
      map(
      (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 4.5) => -0.0020586153,
      (r_C18_invalid_addrs_per_adl_i > 4.5) => -0.0429343711,
      (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0289528313, -0.0047873801),
   ((Integer)k_nap_lname_verd_d > 0.5) => 0.0187879599,
   ((Integer)k_nap_lname_verd_d = NULL) => 0.0001143369, 0.0001143369), -0.0012881465);

// Tree: 127 
e_final_score_127 := map(
(NULL < r_D30_Derog_Count_i and r_D30_Derog_Count_i <= 0.5) => 
   map(
   (NULL < r_I60_inq_auto_count12_i and r_I60_inq_auto_count12_i <= 1.5) => 
      map(
      (pat_type in ['I']) => 
         map(
         (NULL < r_C18_invalid_addrs_per_adl_i and r_C18_invalid_addrs_per_adl_i <= 2.5) => -0.0066229300,
         (r_C18_invalid_addrs_per_adl_i > 2.5) => -0.0719251038,
         (r_C18_invalid_addrs_per_adl_i = NULL) => -0.0157500225, -0.0157500225),
      (pat_type in ['E','NA','O','S']) => 0.0040399856,
      (pat_type = '') => 0.0022216406, 0.0022216406),
   (r_I60_inq_auto_count12_i > 1.5) => -0.1026192725,
   (r_I60_inq_auto_count12_i = NULL) => 0.0007207535, 0.0007207535),
(r_D30_Derog_Count_i > 0.5) => 
   map(
   (NULL < k_estimated_income_d and k_estimated_income_d <= 70500) => -0.0209853646,
   (k_estimated_income_d > 70500) => 0.0520070023,
   (k_estimated_income_d = NULL) => -0.0191769250, -0.0191769250),
(r_D30_Derog_Count_i = NULL) => -0.0048668107, -0.0044810489);

// Tree: 128 
e_final_score_128 := map(
(NULL < r_L77_Add_PO_Box_i and r_L77_Add_PO_Box_i <= 0.5) => 
   map(
	    (r_D31_bk_chapter_n = '') => 0.0040245691,
   (NULL < (Integer)r_D31_bk_chapter_n and (Integer)r_D31_bk_chapter_n <= 12) => 
      map(
      (NULL < r_D34_UnRel_Lien60_Count_i and r_D34_UnRel_Lien60_Count_i <= 0.5) => 0.0362986870,
      (r_D34_UnRel_Lien60_Count_i > 0.5) => -0.0138577312,
      (r_D34_UnRel_Lien60_Count_i = NULL) => 0.0219863757, 0.0219863757),
   ((Integer)r_D31_bk_chapter_n > 12) => 
      map(
      (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 74.6) => -0.0480031989,
      (r_C12_source_profile_d > 74.6) => 0.0563267953,
      (r_C12_source_profile_d = NULL) => -0.0015018300, -0.0015018300),
 0.0047201838),
(r_L77_Add_PO_Box_i > 0.5) => 
   map(
   (NULL < r_C12_source_profile_d and r_C12_source_profile_d <= 81.05) => -0.0299252634,
   (r_C12_source_profile_d > 81.05) => 0.0200296239,
   (r_C12_source_profile_d = NULL) => -0.0197402863, -0.0197402863),
(r_L77_Add_PO_Box_i = NULL) => 0.0036051013, 0.0036051013);

// Final Score Sum 

   e_final_score := sum(
      e_final_score_0, e_final_score_1, e_final_score_2, e_final_score_3, e_final_score_4, 
      e_final_score_5, e_final_score_6, e_final_score_7, e_final_score_8, e_final_score_9, 
      e_final_score_10, e_final_score_11, e_final_score_12, e_final_score_13, e_final_score_14, 
      e_final_score_15, e_final_score_16, e_final_score_17, e_final_score_18, e_final_score_19, 
      e_final_score_20, e_final_score_21, e_final_score_22, e_final_score_23, e_final_score_24, 
      e_final_score_25, e_final_score_26, e_final_score_27, e_final_score_28, e_final_score_29, 
      e_final_score_30, e_final_score_31, e_final_score_32, e_final_score_33, e_final_score_34, 
      e_final_score_35, e_final_score_36, e_final_score_37, e_final_score_38, e_final_score_39, 
      e_final_score_40, e_final_score_41, e_final_score_42, e_final_score_43, e_final_score_44, 
      e_final_score_45, e_final_score_46, e_final_score_47, e_final_score_48, e_final_score_49, 
      e_final_score_50, e_final_score_51, e_final_score_52, e_final_score_53, e_final_score_54, 
      e_final_score_55, e_final_score_56, e_final_score_57, e_final_score_58, e_final_score_59, 
      e_final_score_60, e_final_score_61, e_final_score_62, e_final_score_63, e_final_score_64, 
      e_final_score_65, e_final_score_66, e_final_score_67, e_final_score_68, e_final_score_69, 
      e_final_score_70, e_final_score_71, e_final_score_72, e_final_score_73, e_final_score_74, 
      e_final_score_75, e_final_score_76, e_final_score_77, e_final_score_78, e_final_score_79, 
      e_final_score_80, e_final_score_81, e_final_score_82, e_final_score_83, e_final_score_84, 
      e_final_score_85, e_final_score_86, e_final_score_87, e_final_score_88, e_final_score_89, 
      e_final_score_90, e_final_score_91, e_final_score_92, e_final_score_93, e_final_score_94, 
      e_final_score_95, e_final_score_96, e_final_score_97, e_final_score_98, e_final_score_99, 
      e_final_score_100, e_final_score_101, e_final_score_102, e_final_score_103, e_final_score_104, 
      e_final_score_105, e_final_score_106, e_final_score_107, e_final_score_108, e_final_score_109, 
      e_final_score_110, e_final_score_111, e_final_score_112, e_final_score_113, e_final_score_114, 
      e_final_score_115, e_final_score_116, e_final_score_117, e_final_score_118, e_final_score_119, 
      e_final_score_120, e_final_score_121, e_final_score_122, e_final_score_123, e_final_score_124, 
      e_final_score_125, e_final_score_126, e_final_score_127, e_final_score_128); 

exception_score := not(fnamepop and lnamepop and addrpop OR (Integer)ssnlength = 9) or 
  riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

b_pbr := 0.1324;

b_sbr := 0.1324;

b_offset := log(((1 - b_pbr) * b_sbr) / (b_pbr * (1 - b_sbr)));
//b_offset :=  0;

b_base := 700;

b_pts := 50;

b_lgt := ln(0.1324 / 0.8676);

bad_debt_score := round(max((real)501, min(900, if(b_base + b_pts * (b_final_score - b_offset - b_lgt) / ln(2) = NULL, -NULL, b_base + b_pts * (b_final_score - b_offset - b_lgt) / ln(2)))));

e_pbr := 0.3444;

e_sbr := 0.3444;

e_offset := log(((1 - e_pbr) * e_sbr) / (e_pbr * (1 - e_sbr)));
//e_offset := 0;

e_base := 710;

e_pts := 45;

e_lgt := ln(0.3444 / 0.6556);

early_out_score := round(max((real)501, min(900, if(e_base + e_pts * (e_final_score - e_offset - e_lgt) / ln(2) = NULL, -NULL, e_base + e_pts * (e_final_score - e_offset - e_lgt) / ln(2)))));

rvc1602_1_0 := map(
    (Integer)exception_score = 1 => 222,
    service_ = 'E'       => early_out_score,
                           bad_debt_score);

rcvalued33_c1086 := if(r_d33_eviction_count_i > 0, 24, NULL);

rcvaluei61_c1087 := if(r_i61_inq_collection_count12_i > 0, 23, NULL);

rcvaluel72_c1088 := if(r_l72_add_vacant_i = 1, 22, NULL);

rcvalued34_c1089 := if(r_d34_unrel_lien60_count_i > 0, 21, NULL);

rcvaluei60_c1090 := if(r_i60_inq_auto_count12_i > 0 or r_i60_inq_count12_i > 0 or r_i60_inq_hiriskcred_count12_i > 0, 20, NULL);

rcvaluef00_c1091 := if(r_f00_addr_not_ver_w_ssn_i = 1, 19, NULL);

rcvalued30_c1092 := if(r_d30_derog_count_i > 0, 18, NULL);

rcvaluef01_c1093 := if(r_f01_inp_addr_address_score_d < 100, 17, NULL);

rcvaluea41_c1094 := if(r_a41_prop_owner_d = 0, 16, NULL);

rcvaluec14_c1095 := if(r_c14_addrs_10yr_i >= 4 or r_c14_addrs_5yr_i >= 2, 15, NULL);

rcvaluef03_c1096 := if(r_f03_input_add_not_most_rec_i != 0, 14, NULL);

rcvaluea44_c1097 := if(r_a44_curr_add_naprop_d != 4, 13, NULL);

rcvaluec10_c1098 := if(r_c10_m_hdr_fs_d <= 192, 12, NULL);

rcvaluec20_c1099 := if(r_c21_m_bureau_adl_fs_d <= 192, 11, NULL);

rcvaluef04_c1100 := if(r_f04_curr_add_occ_index_d != 1, 10, NULL);

rcvaluec12_c1101 := if(r_c12_num_nonderogs_d <= 2, 9, NULL);

rcvalued31_c1102 := if((r_d31_attr_bankruptcy_recency_d in [1, 3, 6, 12, 24, 36]), 8, NULL);

rcvaluec13_c1103 := if(r_c13_curr_addr_lres_d <= 48, 7, NULL);

rcvaluel80_c1104 := if(r_l80_inp_avm_autoval_d <= 100000, 6, NULL);

rcvaluea46_c1105 := if(r_a46_curr_avm_autoval_d <= 100000, 5, NULL);

rcvaluel79_c1106 := if(r_l79_adls_per_addr_c6_i >= 1 or r_l79_adls_per_addr_curr_i >= 4, 4, NULL);

rcvalues66_c1107 := if(r_s66_adlperssn_count_i >= 3, 3, NULL);

rcvaluee55_c1108 := if(r_e55_college_ind_d != 1, 2, NULL);

rcvaluee57_c1109 := if(r_e57_br_source_count_d = 0, 1, NULL);

rcvalued32_c1110 := if(r_d32_criminal_count_i > 0, 25, NULL);

rcvalued33_c1111 := if(r_d33_eviction_count_i > 0, 24, NULL);

rcvaluei61_c1112 := if(r_i61_inq_collection_count12_i > 0, 23, NULL);

rcvaluef00_c1113 := if(r_f00_addr_not_ver_w_ssn_i = 1, 22, NULL);

rcvaluef01_c1114 := if(r_f01_inp_addr_address_score_d < 100, 21, NULL);

rcvaluei60_c1115 := if(r_i60_inq_auto_count12_i > 0 or r_i60_inq_count12_i > 0 or r_i60_inq_hiriskcred_count12_i > 0, 20, NULL);

rcvalued30_c1116 := if(r_d30_derog_count_i > 0, 19, NULL);

rcvaluea41_c1117 := if(r_a41_prop_owner_d = 0, 18, NULL);

rcvaluef03_c1118 := if(r_f03_input_add_not_most_rec_i != 0, 17, NULL);

rcvaluec14_c1119 := if(r_c14_addrs_10yr_i >= 4 or r_c14_addrs_5yr_i >= 2, 16, NULL);

rcvaluea44_c1120 := if(r_a44_curr_add_naprop_d != 4, 15, NULL);

rcvaluef04_c1121 := if(r_f04_curr_add_occ_index_d != 1, 14, NULL);

rcvaluec12_c1122 := if(r_c12_num_nonderogs_d <= 2, 13, NULL);

rcvaluec10_c1123 := if(r_c10_m_hdr_fs_d <= 192, 12, NULL);

rcvaluec20_c1124 := if(r_c21_m_bureau_adl_fs_d <= 192, 11, NULL);

rcvaluec13_c1125 := if(r_c13_curr_addr_lres_d <= 48, 10, NULL);

rcvaluel80_c1126 := if(r_l80_inp_avm_autoval_d <= 100000, 9, NULL);

rcvaluea46_c1127 := if(r_a46_curr_avm_autoval_d <= 100000, 8, NULL);

rcvaluel79_c1128 := if(r_l79_adls_per_addr_c6_i >= 1 or r_l79_adls_per_addr_curr_i >= 4, 7, NULL);

rcvaluee55_c1129 := if(r_e55_college_ind_d != 1, 6, NULL);

rcvaluel78_c1130 := if(r_l78_no_phone_at_addr_vel_i = 1, 5, NULL);

rcvalues66_c1131 := if(r_s66_adlperssn_count_i >= 3, 4, NULL);

rcvaluec18_c1132 := if(r_c18_invalid_addrs_per_adl_i >= 6, 3, NULL);

rcvaluee57_c1133 := if(r_e57_br_source_count_d = 0, 2, NULL);

rcvalued31_c1134 := if((r_d31_attr_bankruptcy_recency_d in [1, 3, 6, 12, 24, 36]), 1, NULL);

rcvaluee57 := if(service_ = 'E', rcvaluee57_c1109, rcvaluee57_c1133);

rcvaluec12 := if(service_ = 'E', rcvaluec12_c1101, rcvaluec12_c1122);

rcvaluef01 := if(service_ = 'E', rcvaluef01_c1093, rcvaluef01_c1114);

rcvaluec20 := if(service_ = 'E', rcvaluec20_c1099, rcvaluec20_c1124);

rcvaluef00 := if(service_ = 'E', rcvaluef00_c1091, rcvaluef00_c1113);

rcvalued34 := if(service_ = 'E', rcvalued34_c1089, NULL);

rcvaluel72 := if(service_ = 'E', rcvaluel72_c1088, NULL);

rcvaluel79 := if(service_ = 'E', rcvaluel79_c1106, rcvaluel79_c1128);

rcvaluea46 := if(service_ = 'E', rcvaluea46_c1105, rcvaluea46_c1127);

rcvaluea44 := if(service_ = 'E', rcvaluea44_c1097, rcvaluea44_c1120);

rcvaluel80 := if(service_ = 'E', rcvaluel80_c1104, rcvaluel80_c1126);

rcvaluec13 := if(service_ = 'E', rcvaluec13_c1103, rcvaluec13_c1125);

rcvaluee55 := if(service_ = 'E', rcvaluee55_c1108, rcvaluee55_c1129);

rcvaluef03 := if(service_ = 'E', rcvaluef03_c1096, rcvaluef03_c1118);

rcvaluei61 := if(service_ = 'E', rcvaluei61_c1087, rcvaluei61_c1112);

rcvaluef04 := if(service_ = 'E', rcvaluef04_c1100, rcvaluef04_c1121);

rcvaluec14 := if(service_ = 'E', rcvaluec14_c1095, rcvaluec14_c1119);

rcvaluec18 := if(service_ = 'E', NULL, rcvaluec18_c1132);

rcvalues66 := if(service_ = 'E', rcvalues66_c1107, rcvalues66_c1131);

rcvalued33 := if(service_ = 'E', rcvalued33_c1086, rcvalued33_c1111);

rcvaluea41 := if(service_ = 'E', rcvaluea41_c1094, rcvaluea41_c1117);

rcvalued31 := if(service_ = 'E', rcvalued31_c1102, rcvalued31_c1134);

rcvaluec10 := if(service_ = 'E', rcvaluec10_c1098, rcvaluec10_c1123);

rcvaluel78 := if(service_ = 'E', NULL, rcvaluel78_c1130);

rcvalued32 := if(service_ = 'E', NULL, rcvalued32_c1110);

rcvaluei60 := if(service_ = 'E', rcvaluei60_c1090, rcvaluei60_c1115);

rcvalued30 := if(service_ = 'E', rcvalued30_c1092, rcvalued30_c1116);

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

 
//*************************************************************************************//
rc_dataset_t := DATASET([
    {'A41', RCValueA41},
    {'A44', RCValueA44},
    {'A46', RCValueA46},
    {'C10', RCValueC10},
    {'C12', RCValueC12},
    {'C13', RCValueC13},
    {'C14', RCValueC14},
    {'C18', RCValueC18},
    {'C20', RCValueC20},
    {'D30', RCValueD30},
    {'D31', RCValueD31},
    {'D32', RCValueD32},
    {'D33', RCValueD33},
    {'D34', RCValueD34},
    {'E55', RCValueE55},
    {'E57', RCValueE57},
    {'F00', RCValueF00},
    {'F01', RCValueF01},
    {'F03', RCValueF03},
    {'F04', RCValueF04},
    {'I60', RCValueI60},
    {'I61', RCValueI61},
    {'L72', RCValueL72},
    {'L78', RCValueL78},
    {'L79', RCValueL79},
    {'L80', RCValueL80},
    {'S66', RCValueS66}
    ], ds_layout) (Value > 0); 

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue > 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_t_sorted := sort(rc_dataset_t, -rc_dataset_t.value);

rc1_3 := rc_dataset_t_sorted[1].rc;
rc2_2 := rc_dataset_t_sorted[2].rc;
rc3_2 := rc_dataset_t_sorted[3].rc;
rc4_2 := rc_dataset_t_sorted[4].rc;
rc5_3 := '';

rc1v := rc_dataset_t_sorted[1].value;
rc2v := rc_dataset_t_sorted[2].value;
rc3v := rc_dataset_t_sorted[3].value;
rc4v := rc_dataset_t_sorted[4].value;
//*************************************************************************************//

_rc_inq := map(
    r_i60_inq_auto_count12_i > 0       => 'I60',
    r_i60_inq_count12_i > 0            => 'I60',
    r_i60_inq_hiriskcred_count12_i > 0 => 'I60',
    r_i61_inq_collection_count12_i > 0 => 'I61',
                                          '   ');

rc5_c1137 := map(
    _rc_inq = 'I60' => 'I60',
    _rc_inq = 'I61' => 'I61',
                       ' ');

rc5_2 := if(not((rc1_3 in ['I60', 'I61'])) and not((rc2_2 in ['I60', 'I61'])) and not((rc3_2 in ['I60', 'I61'])) and not((rc4_2 in ['I60', 'I61'])), rc5_c1137, rc5_3);

rc1_2 := if(rc1_3 = ' ', 'C12', rc1_3);

rc2_1 := if(rvc1602_1_0 = 900, '', rc2_2);

rc3_1 := if(rvc1602_1_0 = 900, '', rc3_2);

rc1_1 := if(rvc1602_1_0 = 900, '', rc1_2);

rc4_1 := if(rvc1602_1_0 = 900, '', rc4_2);

rc5_1 := if(rvc1602_1_0 = 900, '', rc5_2);

rc2 := if(rvc1602_1_0 = 222, '', rc2_1);

rc1 := if(rvc1602_1_0 = 222, '', rc1_1);

rc3 := if(rvc1602_1_0 = 222, '', rc3_1);

rc5 := if(rvc1602_1_0 = 222, '', rc5_1);

rc4 := if(rvc1602_1_0 = 222, '', rc4_1);


//*************************************************************************************//
//     RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVC1602_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVC1602_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVC1602_1_0 = 900 => DATASET([{'00'}], HRILayout),
																							 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI NOT IN ['', '00']);
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
	 self.seq															 := le.seq;
   self.sysdate                          := sysdate;
   self.fin_class                        := fin_class;
   self.client_type                      := client_type;
   self.pat_type                         := pat_type;
	 self._service												 := service_;
   self._in_dob                          := _in_dob;
   self.yr_in_dob                        := yr_in_dob;
   self.yr_in_dob_int                    := yr_in_dob_int;
   self.k_comb_age_d                     := k_comb_age_d;
   self.k_estimated_income_d             := k_estimated_income_d;
   self.k_nap_addr_verd_d                := k_nap_addr_verd_d;
   self.k_nap_fname_verd_d               := k_nap_fname_verd_d;
   self.k_nap_lname_verd_d               := k_nap_lname_verd_d;
   self.r_a41_prop_owner_d               := r_a41_prop_owner_d;
   self.r_a41_prop_owner_inp_only_d      := r_a41_prop_owner_inp_only_d;
   self.r_a43_watercraft_cnt_d           := r_a43_watercraft_cnt_d;
   self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
   self.r_a46_curr_avm_autoval_d         := r_a46_curr_avm_autoval_d;
   self.r_a49_curr_avm_chg_1yr_i         := r_a49_curr_avm_chg_1yr_i;
   self.r_a49_curr_avm_chg_1yr_pct_i     := r_a49_curr_avm_chg_1yr_pct_i;
   self._header_first_seen               := _header_first_seen;
   self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
   self.r_c12_nonderog_recency_i         := r_c12_nonderog_recency_i;
   self.r_c12_num_nonderogs_d            := r_c12_num_nonderogs_d;
   self.r_c12_source_profile_d           := r_c12_source_profile_d;
   self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
   self.r_c13_max_lres_d                 := r_c13_max_lres_d;
   self.r_c14_addr_stability_v2_d        := r_c14_addr_stability_v2_d;
   self.r_c14_addrs_10yr_i               := r_c14_addrs_10yr_i;
   self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
   self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
   self.r_c18_invalid_addrs_per_adl_i    := r_c18_invalid_addrs_per_adl_i;
   self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
   self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
   self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
   self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
   self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
   self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
   self.r_c23_inp_addr_owned_not_occ_d   := r_c23_inp_addr_owned_not_occ_d;
   self.r_d30_derog_count_i              := r_d30_derog_count_i;
   self.r_d31_attr_bankruptcy_recency_d  := r_d31_attr_bankruptcy_recency_d;
   self.r_D31_bk_chapter_n               := r_D31_bk_chapter_n;
   self.r_d31_bk_dism_hist_count_i       := r_d31_bk_dism_hist_count_i;
   self.r_d31_bk_disposed_hist_count_i   := r_d31_bk_disposed_hist_count_i;
   self.r_d31_mostrec_bk_i               := r_d31_mostrec_bk_i;
   self._criminal_last_date              := _criminal_last_date;
   self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
   self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
   self.r_d33_eviction_count_i           := r_d33_eviction_count_i;
   self.r_d33_eviction_recency_d         := r_d33_eviction_recency_d;
   self.r_d34_unrel_lien60_count_i       := r_d34_unrel_lien60_count_i;
   self.r_d34_unrel_liens_ct_i           := r_d34_unrel_liens_ct_i;
   self.r_e55_college_ind_d              := r_e55_college_ind_d;
   self.r_e57_br_source_count_d          := r_e57_br_source_count_d;
   self.r_e57_prof_license_flag_d        := r_e57_prof_license_flag_d;
   self.r_ever_asset_owner_d             := r_ever_asset_owner_d;
   self.r_f00_addr_not_ver_w_ssn_i       := r_f00_addr_not_ver_w_ssn_i;
   self.r_f00_nas_ssn_no_addr_verd_i     := r_f00_nas_ssn_no_addr_verd_i;
   self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
   self.r_f03_address_match_d            := r_f03_address_match_d;
   self.r_f03_input_add_not_most_rec_i   := r_f03_input_add_not_most_rec_i;
   self.r_f04_curr_add_occ_index_d       := r_f04_curr_add_occ_index_d;
   self.r_i60_inq_auto_count12_i         := r_i60_inq_auto_count12_i;
   self.r_i60_inq_auto_recency_d         := r_i60_inq_auto_recency_d;
   self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
   self.r_i60_inq_count12_i              := r_i60_inq_count12_i;
   self.r_i60_inq_hiriskcred_count12_i   := r_i60_inq_hiriskcred_count12_i;
   self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
   self.r_i60_inq_recency_d              := r_i60_inq_recency_d;
   self.r_i61_inq_collection_count12_i   := r_i61_inq_collection_count12_i;
   self.r_i61_inq_collection_recency_d   := r_i61_inq_collection_recency_d;
   self.add_ec1                          := add_ec1;
   self.add_ec3                          := add_ec3;
   self.add_ec4                          := add_ec4;
   self.r_l70_add_standardized_i         := r_l70_add_standardized_i;
   self.r_l72_add_vacant_i               := r_l72_add_vacant_i;
   self.r_l77_add_po_box_i               := r_l77_add_po_box_i;
   self.r_l78_no_phone_at_addr_vel_i     := r_l78_no_phone_at_addr_vel_i;
   self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
   self.r_l79_adls_per_addr_curr_i       := r_l79_adls_per_addr_curr_i;
   self.r_l80_inp_avm_autoval_d          := r_l80_inp_avm_autoval_d;
   self.r_prop_owner_history_d           := r_prop_owner_history_d;
   self.r_s66_adlperssn_count_i          := r_s66_adlperssn_count_i;
   self.r_wealth_index_d                 := r_wealth_index_d;
   self.b_final_score_0                  := b_final_score_0;
   self.b_final_score_1                  := b_final_score_1;
   self.b_final_score_2                  := b_final_score_2;
   self.b_final_score_3                  := b_final_score_3;
   self.b_final_score_4                  := b_final_score_4;
   self.b_final_score_5                  := b_final_score_5;
   self.b_final_score_6                  := b_final_score_6;
   self.b_final_score_7                  := b_final_score_7;
   self.b_final_score_8                  := b_final_score_8;
   self.b_final_score_9                  := b_final_score_9;
   self.b_final_score_10                 := b_final_score_10;
   self.b_final_score_11                 := b_final_score_11;
   self.b_final_score_12                 := b_final_score_12;
   self.b_final_score_13                 := b_final_score_13;
   self.b_final_score_14                 := b_final_score_14;
   self.b_final_score_15                 := b_final_score_15;
   self.b_final_score_16                 := b_final_score_16;
   self.b_final_score_17                 := b_final_score_17;
   self.b_final_score_18                 := b_final_score_18;
   self.b_final_score_19                 := b_final_score_19;
   self.b_final_score_20                 := b_final_score_20;
   self.b_final_score_21                 := b_final_score_21;
   self.b_final_score_22                 := b_final_score_22;
   self.b_final_score_23                 := b_final_score_23;
   self.b_final_score_24                 := b_final_score_24;
   self.b_final_score_25                 := b_final_score_25;
   self.b_final_score_26                 := b_final_score_26;
   self.b_final_score_27                 := b_final_score_27;
   self.b_final_score_28                 := b_final_score_28;
   self.b_final_score_29                 := b_final_score_29;
   self.b_final_score_30                 := b_final_score_30;
   self.b_final_score_31                 := b_final_score_31;
   self.b_final_score_32                 := b_final_score_32;
   self.b_final_score_33                 := b_final_score_33;
   self.b_final_score_34                 := b_final_score_34;
   self.b_final_score_35                 := b_final_score_35;
   self.b_final_score_36                 := b_final_score_36;
   self.b_final_score_37                 := b_final_score_37;
   self.b_final_score_38                 := b_final_score_38;
   self.b_final_score_39                 := b_final_score_39;
   self.b_final_score_40                 := b_final_score_40;
   self.b_final_score_41                 := b_final_score_41;
   self.b_final_score_42                 := b_final_score_42;
   self.b_final_score_43                 := b_final_score_43;
   self.b_final_score_44                 := b_final_score_44;
   self.b_final_score_45                 := b_final_score_45;
   self.b_final_score_46                 := b_final_score_46;
   self.b_final_score_47                 := b_final_score_47;
   self.b_final_score_48                 := b_final_score_48;
   self.b_final_score_49                 := b_final_score_49;
   self.b_final_score_50                 := b_final_score_50;
   self.b_final_score_51                 := b_final_score_51;
   self.b_final_score_52                 := b_final_score_52;
   self.b_final_score_53                 := b_final_score_53;
   self.b_final_score_54                 := b_final_score_54;
   self.b_final_score_55                 := b_final_score_55;
   self.b_final_score_56                 := b_final_score_56;
   self.b_final_score_57                 := b_final_score_57;
   self.b_final_score_58                 := b_final_score_58;
   self.b_final_score_59                 := b_final_score_59;
   self.b_final_score_60                 := b_final_score_60;
   self.b_final_score_61                 := b_final_score_61;
   self.b_final_score_62                 := b_final_score_62;
   self.b_final_score_63                 := b_final_score_63;
   self.b_final_score_64                 := b_final_score_64;
   self.b_final_score_65                 := b_final_score_65;
   self.b_final_score_66                 := b_final_score_66;
   self.b_final_score_67                 := b_final_score_67;
   self.b_final_score_68                 := b_final_score_68;
   self.b_final_score_69                 := b_final_score_69;
   self.b_final_score_70                 := b_final_score_70;
   self.b_final_score_71                 := b_final_score_71;
   self.b_final_score_72                 := b_final_score_72;
   self.b_final_score_73                 := b_final_score_73;
   self.b_final_score_74                 := b_final_score_74;
   self.b_final_score_75                 := b_final_score_75;
   self.b_final_score_76                 := b_final_score_76;
   self.b_final_score_77                 := b_final_score_77;
   self.b_final_score_78                 := b_final_score_78;
   self.b_final_score_79                 := b_final_score_79;
   self.b_final_score_80                 := b_final_score_80;
   self.b_final_score_81                 := b_final_score_81;
   self.b_final_score_82                 := b_final_score_82;
   self.b_final_score_83                 := b_final_score_83;
   self.b_final_score_84                 := b_final_score_84;
   self.b_final_score_85                 := b_final_score_85;
   self.b_final_score_86                 := b_final_score_86;
   self.b_final_score_87                 := b_final_score_87;
   self.b_final_score_88                 := b_final_score_88;
   self.b_final_score_89                 := b_final_score_89;
   self.b_final_score_90                 := b_final_score_90;
   self.b_final_score_91                 := b_final_score_91;
   self.b_final_score_92                 := b_final_score_92;
   self.b_final_score_93                 := b_final_score_93;
   self.b_final_score_94                 := b_final_score_94;
   self.b_final_score_95                 := b_final_score_95;
   self.b_final_score_96                 := b_final_score_96;
   self.b_final_score_97                 := b_final_score_97;
   self.b_final_score_98                 := b_final_score_98;
   self.b_final_score_99                 := b_final_score_99;
   self.b_final_score_100                := b_final_score_100;
   self.b_final_score_101                := b_final_score_101;
   self.b_final_score_102                := b_final_score_102;
   self.b_final_score_103                := b_final_score_103;
   self.b_final_score_104                := b_final_score_104;
   self.b_final_score_105                := b_final_score_105;
   self.b_final_score_106                := b_final_score_106;
   self.b_final_score_107                := b_final_score_107;
   self.b_final_score_108                := b_final_score_108;
   self.b_final_score_109                := b_final_score_109;
   self.b_final_score_110                := b_final_score_110;
   self.b_final_score_111                := b_final_score_111;
   self.b_final_score_112                := b_final_score_112;
   self.b_final_score_113                := b_final_score_113;
   self.b_final_score_114                := b_final_score_114;
   self.b_final_score_115                := b_final_score_115;
   self.b_final_score_116                := b_final_score_116;
   self.b_final_score_117                := b_final_score_117;
   self.b_final_score_118                := b_final_score_118;
   self.b_final_score_119                := b_final_score_119;
   self.b_final_score_120                := b_final_score_120;
   self.b_final_score_121                := b_final_score_121;
   self.b_final_score_122                := b_final_score_122;
   self.b_final_score_123                := b_final_score_123;
   self.b_final_score_124                := b_final_score_124;
   self.b_final_score_125                := b_final_score_125;
   self.b_final_score                    := b_final_score;
   self.e_final_score_0                  := e_final_score_0;
   self.e_final_score_1                  := e_final_score_1;
   self.e_final_score_2                  := e_final_score_2;
   self.e_final_score_3                  := e_final_score_3;
   self.e_final_score_4                  := e_final_score_4;
   self.e_final_score_5                  := e_final_score_5;
   self.e_final_score_6                  := e_final_score_6;
   self.e_final_score_7                  := e_final_score_7;
   self.e_final_score_8                  := e_final_score_8;
   self.e_final_score_9                  := e_final_score_9;
   self.e_final_score_10                 := e_final_score_10;
   self.e_final_score_11                 := e_final_score_11;
   self.e_final_score_12                 := e_final_score_12;
   self.e_final_score_13                 := e_final_score_13;
   self.e_final_score_14                 := e_final_score_14;
   self.e_final_score_15                 := e_final_score_15;
   self.e_final_score_16                 := e_final_score_16;
   self.e_final_score_17                 := e_final_score_17;
   self.e_final_score_18                 := e_final_score_18;
   self.e_final_score_19                 := e_final_score_19;
   self.e_final_score_20                 := e_final_score_20;
   self.e_final_score_21                 := e_final_score_21;
   self.e_final_score_22                 := e_final_score_22;
   self.e_final_score_23                 := e_final_score_23;
   self.e_final_score_24                 := e_final_score_24;
   self.e_final_score_25                 := e_final_score_25;
   self.e_final_score_26                 := e_final_score_26;
   self.e_final_score_27                 := e_final_score_27;
   self.e_final_score_28                 := e_final_score_28;
   self.e_final_score_29                 := e_final_score_29;
   self.e_final_score_30                 := e_final_score_30;
   self.e_final_score_31                 := e_final_score_31;
   self.e_final_score_32                 := e_final_score_32;
   self.e_final_score_33                 := e_final_score_33;
   self.e_final_score_34                 := e_final_score_34;
   self.e_final_score_35                 := e_final_score_35;
   self.e_final_score_36                 := e_final_score_36;
   self.e_final_score_37                 := e_final_score_37;
   self.e_final_score_38                 := e_final_score_38;
   self.e_final_score_39                 := e_final_score_39;
   self.e_final_score_40                 := e_final_score_40;
   self.e_final_score_41                 := e_final_score_41;
   self.e_final_score_42                 := e_final_score_42;
   self.e_final_score_43                 := e_final_score_43;
   self.e_final_score_44                 := e_final_score_44;
   self.e_final_score_45                 := e_final_score_45;
   self.e_final_score_46                 := e_final_score_46;
   self.e_final_score_47                 := e_final_score_47;
   self.e_final_score_48                 := e_final_score_48;
   self.e_final_score_49                 := e_final_score_49;
   self.e_final_score_50                 := e_final_score_50;
   self.e_final_score_51                 := e_final_score_51;
   self.e_final_score_52                 := e_final_score_52;
   self.e_final_score_53                 := e_final_score_53;
   self.e_final_score_54                 := e_final_score_54;
   self.e_final_score_55                 := e_final_score_55;
   self.e_final_score_56                 := e_final_score_56;
   self.e_final_score_57                 := e_final_score_57;
   self.e_final_score_58                 := e_final_score_58;
   self.e_final_score_59                 := e_final_score_59;
   self.e_final_score_60                 := e_final_score_60;
   self.e_final_score_61                 := e_final_score_61;
   self.e_final_score_62                 := e_final_score_62;
   self.e_final_score_63                 := e_final_score_63;
   self.e_final_score_64                 := e_final_score_64;
   self.e_final_score_65                 := e_final_score_65;
   self.e_final_score_66                 := e_final_score_66;
   self.e_final_score_67                 := e_final_score_67;
   self.e_final_score_68                 := e_final_score_68;
   self.e_final_score_69                 := e_final_score_69;
   self.e_final_score_70                 := e_final_score_70;
   self.e_final_score_71                 := e_final_score_71;
   self.e_final_score_72                 := e_final_score_72;
   self.e_final_score_73                 := e_final_score_73;
   self.e_final_score_74                 := e_final_score_74;
   self.e_final_score_75                 := e_final_score_75;
   self.e_final_score_76                 := e_final_score_76;
   self.e_final_score_77                 := e_final_score_77;
   self.e_final_score_78                 := e_final_score_78;
   self.e_final_score_79                 := e_final_score_79;
   self.e_final_score_80                 := e_final_score_80;
   self.e_final_score_81                 := e_final_score_81;
   self.e_final_score_82                 := e_final_score_82;
   self.e_final_score_83                 := e_final_score_83;
   self.e_final_score_84                 := e_final_score_84;
   self.e_final_score_85                 := e_final_score_85;
   self.e_final_score_86                 := e_final_score_86;
   self.e_final_score_87                 := e_final_score_87;
   self.e_final_score_88                 := e_final_score_88;
   self.e_final_score_89                 := e_final_score_89;
   self.e_final_score_90                 := e_final_score_90;
   self.e_final_score_91                 := e_final_score_91;
   self.e_final_score_92                 := e_final_score_92;
   self.e_final_score_93                 := e_final_score_93;
   self.e_final_score_94                 := e_final_score_94;
   self.e_final_score_95                 := e_final_score_95;
   self.e_final_score_96                 := e_final_score_96;
   self.e_final_score_97                 := e_final_score_97;
   self.e_final_score_98                 := e_final_score_98;
   self.e_final_score_99                 := e_final_score_99;
   self.e_final_score_100                := e_final_score_100;
   self.e_final_score_101                := e_final_score_101;
   self.e_final_score_102                := e_final_score_102;
   self.e_final_score_103                := e_final_score_103;
   self.e_final_score_104                := e_final_score_104;
   self.e_final_score_105                := e_final_score_105;
   self.e_final_score_106                := e_final_score_106;
   self.e_final_score_107                := e_final_score_107;
   self.e_final_score_108                := e_final_score_108;
   self.e_final_score_109                := e_final_score_109;
   self.e_final_score_110                := e_final_score_110;
   self.e_final_score_111                := e_final_score_111;
   self.e_final_score_112                := e_final_score_112;
   self.e_final_score_113                := e_final_score_113;
   self.e_final_score_114                := e_final_score_114;
   self.e_final_score_115                := e_final_score_115;
   self.e_final_score_116                := e_final_score_116;
   self.e_final_score_117                := e_final_score_117;
   self.e_final_score_118                := e_final_score_118;
   self.e_final_score_119                := e_final_score_119;
   self.e_final_score_120                := e_final_score_120;
   self.e_final_score_121                := e_final_score_121;
   self.e_final_score_122                := e_final_score_122;
   self.e_final_score_123                := e_final_score_123;
   self.e_final_score_124                := e_final_score_124;
   self.e_final_score_125                := e_final_score_125;
   self.e_final_score_126                := e_final_score_126;
   self.e_final_score_127                := e_final_score_127;
   self.e_final_score_128                := e_final_score_128;
   self.e_final_score                    := e_final_score;
   self.exception_score                  := exception_score;
   self.b_pbr                            := b_pbr;
   self.b_sbr                            := b_sbr;
   self.b_offset                         := b_offset;
   self.b_base                           := b_base;
   self.b_pts                            := b_pts;
   self.b_lgt                            := b_lgt;
   self.bad_debt_score                   := bad_debt_score;
   self.e_pbr                            := e_pbr;
   self.e_sbr                            := e_sbr;
   self.e_offset                         := e_offset;
   self.e_base                           := e_base;
   self.e_pts                            := e_pts;
   self.e_lgt                            := e_lgt;
   self.early_out_score                  := early_out_score;
   self.rvc1602_1_0                      := rvc1602_1_0;
   self.rc1v                             := rc1v;
   self.rc2v                             := rc2v;
   self.rc3v                             := rc3v;
   self.rc4v                             := rc4v;
   self._rc_inq                          := _rc_inq;
   self.rc5                              := rc5;
   self.rc4                              := rc4;
   self.rc2                              := rc2;
   self.rc3                              := rc3;
   self.rc1                              := rc1;


		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvc1602_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := join(clam, custom_inputs, left.seq=right.seq, doModel(LEFT, right));
	

	RETURN(model);
END;



