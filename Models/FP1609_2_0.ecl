
import Std, risk_indicators, riskwise, riskwisefcra, ut,  Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1609_2_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//   String NULL;
   Integer seq;
	 Integer	 sysdate;
   Boolean	 k_nap_phn_verd_d;
   Boolean	 k_inf_addr_verd_d;
   Boolean	 k_inf_fname_verd_d;
   Boolean	 k_inf_contradictory_i;
   Integer	 r_p88_phn_dst_to_inp_add_i;
   Integer	 r_p85_phn_not_issued_i;
   Integer	 r_p85_phn_disconnected_i;
   Integer	 r_phn_cell_n;
   Integer	 r_l70_add_invalid_i;
   Integer	 r_l77_apartment_i;
   Integer	 r_f00_dob_score_d;
   Integer	 r_f01_inp_addr_address_score_d;
   Integer	 r_d30_derog_count_i;
   Integer	 r_d32_criminal_count_i;
   Integer	 r_d32_felony_count_i;
   Integer	 _criminal_last_date;
   Integer	 r_d32_mos_since_crim_ls_d;
   Integer	 _felony_last_date;
   Integer	 r_d32_mos_since_fel_ls_d;
   Integer r_d31_mostrec_bk_i;
   Integer	 r_d31_bk_filing_count_i;
   Integer	 r_d31_bk_disposed_recent_count_i;
   Integer	 r_d33_eviction_count_i;
   Integer	 r_d34_unrel_liens_ct_i;
   Integer	 r_d34_unrel_lien60_count_i;
   Integer	 _src_bureau_adl_fseen;
   Integer	 r_c21_m_bureau_adl_fs_d;
   Integer	 _src_bureau_adl_fseen_all;
   Integer	 f_m_bureau_adl_fs_all_d;
   Integer	 bureau_adl_eq_fseen_pos;
   String	 bureau_adl_fseen_eq;
   Integer	 _bureau_adl_fseen_eq;
   Integer	 bureau_adl_en_fseen_pos;
   String	 bureau_adl_fseen_en;
   Integer	 _bureau_adl_fseen_en;
   Integer	 bureau_adl_ts_fseen_pos;
   String	 bureau_adl_fseen_ts;
   Integer	 _bureau_adl_fseen_ts;
   Integer	 bureau_adl_tu_fseen_pos;
   String	 bureau_adl_fseen_tu;
   Integer	 _bureau_adl_fseen_tu;
   Integer	 bureau_adl_tn_fseen_pos;
   String	 bureau_adl_fseen_tn;
   Integer	 _bureau_adl_fseen_tn;
   Integer	 _src_bureau_adl_fseen_notu;
   Integer	 f_m_bureau_adl_fs_notu_d;
   Integer	 _header_first_seen;
   Integer	 r_c10_m_hdr_fs_d;
   Integer	 r_c12_num_nonderogs_d;
   Integer	 r_s66_adlperssn_count_i;
   Integer	 r_a44_curr_add_naprop_d;
   Integer	 r_c13_curr_addr_lres_d;
   Integer	 r_c13_max_lres_d;
   Integer	 r_c14_addrs_15yr_i;
   Integer	 r_a41_prop_owner_d;
   Integer	 r_c20_email_count_i;
   Integer	 r_c20_email_domain_free_count_i;
   Integer	 r_c20_email_domain_isp_count_i;
   Integer	 r_l79_adls_per_addr_curr_i;
   Integer	 r_l79_adls_per_addr_c6_i;
   Integer	 r_c18_invalid_addrs_per_adl_i;
   Integer	 r_i60_inq_count12_i;
   Integer	 r_i60_inq_recency_d;
   Integer	 r_i61_inq_collection_count12_i;
   Integer	 r_i61_inq_collection_recency_d;
   Integer	 r_i60_inq_banking_recency_d;
   Integer	 r_i60_inq_mortgage_recency_d;
   Integer	 r_i60_inq_hiriskcred_count12_i;
   Integer	 r_i60_inq_hiriskcred_recency_d;
   Integer	 r_i60_inq_retail_recency_d;
   Integer	 r_i60_inq_comm_count12_i;
   Integer	 r_i60_inq_comm_recency_d;
   Integer	 f_bus_addr_match_count_d;
   Integer	 f_bus_lname_verd_d;
   Integer	 f_bus_name_nover_i;
   Integer	 f_bus_phone_match_d;
   Integer	 f_adl_util_misc_n;
   Integer	 f_util_adl_count_n;
   Integer	 f_util_add_curr_misc_n;
   Integer	 f_inq_count24_i;
   Integer	 f_inq_auto_count24_i;
   Integer	 f_inq_collection_count24_i;
   Integer	 f_inq_communications_count24_i;
   Integer	 f_inq_highriskcredit_count24_i;
   Integer	 f_inq_other_count24_i;
   Integer	 k_inq_per_ssn_i;
   Integer	 k_inq_lnames_per_ssn_i;
   Integer	 k_inq_addrs_per_ssn_i;
   Integer	 k_inq_per_addr_i;
   Integer	 k_inq_adls_per_addr_i;
   Integer	 k_inq_lnames_per_addr_i;
   Integer	 k_inq_ssns_per_addr_i;
   Integer	 k_inq_per_phone_i;
   Integer	 k_inq_adls_per_phone_i;
   Integer	 _liens_unrel_cj_first_seen;
   Integer	 f_mos_liens_unrel_cj_fseen_d;
   Integer	 _liens_unrel_cj_last_seen;
   Integer	 f_mos_liens_unrel_cj_lseen_d;
   Integer	 f_liens_unrel_cj_total_amt_i;
   Integer	 _liens_rel_cj_first_seen;
   Integer	 f_mos_liens_rel_cj_fseen_d;
   Integer	 _liens_rel_cj_last_seen;
   Integer	 f_mos_liens_rel_cj_lseen_d;
   Integer	 f_liens_rel_cj_total_amt_i;
   Integer	 _liens_unrel_ft_last_seen;
   Integer	 f_mos_liens_unrel_ft_lseen_d;
   Integer	 f_liens_rel_ft_total_amt_i;
   Integer	 _liens_unrel_fc_first_seen;
   Integer	 f_mos_liens_unrel_fc_fseen_d;
   Integer	 f_liens_unrel_fc_total_amt_i;
   Integer	 _liens_unrel_o_first_seen;
   Integer	 f_mos_liens_unrel_o_fseen_d;
   Integer	 f_liens_unrel_o_total_amt_i;
   Integer	 _liens_unrel_ot_first_seen;
   Integer	 f_mos_liens_unrel_ot_fseen_d;
   Integer	 _liens_unrel_ot_last_seen;
   Integer	 f_mos_liens_unrel_ot_lseen_d;
   Integer	 f_liens_unrel_ot_total_amt_i;
   Integer	 _liens_rel_ot_first_seen;
   Integer	 f_mos_liens_rel_ot_fseen_d;
   Integer	 _liens_rel_ot_last_seen;
   Integer	 f_mos_liens_rel_ot_lseen_d;
   Integer	 _liens_unrel_sc_first_seen;
   Integer	 f_mos_liens_unrel_sc_fseen_d;
   Integer	 f_liens_unrel_sc_total_amt_i;
   Integer	 _foreclosure_last_date;
   Integer	 f_mos_foreclosure_lseen_d;
   Integer	 f_current_count_d;
   Integer	 f_historical_count_d;
   Integer	 f_acc_damage_amt_total_i;
   Integer	 _acc_last_seen;
   Integer	 f_mos_acc_lseen_d;
   Integer	 f_accident_recency_d;
   Integer	 f_idrisktype_i;
   Integer	 f_idverrisktype_i;
   Integer	 f_varrisktype_i;
   Integer	 f_vardobcountnew_i;
   Integer	 f_srchvelocityrisktype_i;
   Integer	 f_srchcountwk_i;
   Integer	 f_srchunvrfdaddrcount_i;
   Integer	 f_srchunvrfdphonecount_i;
   Integer	 f_srchfraudsrchcountyr_i;
   Integer	 f_srchfraudsrchcountmo_i;
   Integer	 f_srchfraudsrchcountwk_i;
   Integer	 f_assocrisktype_i;
   Integer	 f_assocsuspicousidcount_i;
   Integer	 f_corrrisktype_i;
   Integer	 f_corrssnnamecount_d;
   Integer	 f_corrssnaddrcount_d;
   Integer	 f_corraddrnamecount_d;
   Integer	 f_corraddrphonecount_d;
   Integer	 f_corrphonelastnamecount_d;
   Integer	 f_divrisktype_i;
   Integer	 f_divssnidmsrcurelcount_i;
   Integer	 f_srchcomponentrisktype_i;
   Integer	 f_srchssnsrchcountmo_i;
   Integer	 f_srchaddrsrchcountmo_i;
   Integer	 f_srchaddrsrchcountday_i;
   Integer	 f_componentcharrisktype_i;
   Integer	 f_curraddractivephonelist_d;
   Integer	 f_prevaddrageoldest_d;
   Integer	 f_prevaddrlenofres_d;
   Integer	 r_d31_all_bk_i;
   String	 r_d31_bk_chapter_n;
   decimal21_1	 r_c12_source_profile_d;
  // Real r_c12_source_profile_d;
   Real	 r_c12_source_profile_index_d;
   Real	 r_c23_inp_addr_occ_index_d;
   Real	 r_e57_br_source_count_d;
   Integer	 r_i60_inq_prepaidcards_recency_d;
   Real	 r_i60_inq_retpymt_count12_i;
   Real	 r_i60_inq_retpymt_recency_d;
   Integer	 f_phone_ver_insurance_d;
   Integer	 f_phone_ver_experian_d;
   Integer	 f_addrs_per_ssn_i;
   Integer	 f_phones_per_addr_curr_i;
   Integer	 f_addrs_per_ssn_c6_i;
   Integer	 f_dl_addrs_per_adl_i;
   Integer	 f_inq_email_ver_count_i;
   Integer	 f_inq_other_count_week_i;
   Integer	 f_inq_retailpayments_cnt_week_i;
   Integer	 f_inq_retailpayments_count24_i;
   Boolean	 f_nae_email_verd_d;
   Boolean	 f_nae_lname_verd_d;
   Boolean	 f_nae_contradictory_i;
   Integer	 f_adl_per_email_i;
   Integer	 r_c20_email_verification_d;
   Integer	 _liens_unrel_st_first_seen;
   Integer	 f_mos_liens_unrel_st_fseen_d;
   Integer	 _liens_unrel_st_last_seen;
   Integer	 f_mos_liens_unrel_st_lseen_d;
   Integer	 f_liens_unrel_st_total_amt_i;
   Real	 final_score_0;
   Real	 final_score_1;
   Real	 final_score_2;
   Real	 final_score_3;
   Real	 final_score_4;
   Real	 final_score_5;
   Real	 final_score_6;
   Real	 final_score_7;
   Real	 final_score_8;
   Real	 final_score_9;
   Real	 final_score_10;
   Real	 final_score_11;
   Real	 final_score_12;
   Real	 final_score_13;
   Real	 final_score_14;
   Real	 final_score_15;
   Real	 final_score_16;
   Real	 final_score_17;
   Real	 final_score_18;
   Real	 final_score_19;
   Real	 final_score_20;
   Real	 final_score_21;
   Real	 final_score_22;
   Real	 final_score_23;
   Real	 final_score_24;
   Real	 final_score_25;
   Real	 final_score_26;
   Real	 final_score_27;
   Real	 final_score_28;
   Real	 final_score_29;
   Real	 final_score_30;
   Real	 final_score_31;
   Real	 final_score_32;
   Real	 final_score_33;
   Real	 final_score_34;
   Real	 final_score_35;
   Real	 final_score_36;
   Real	 final_score_37;
   Real	 final_score_38;
   Real	 final_score_39;
   Real	 final_score_40;
   Real	 final_score_41;
   Real	 final_score_42;
   Real	 final_score_43;
   Real	 final_score_44;
   Real	 final_score_45;
   Real	 final_score_46;
   Real	 final_score_47;
   Real	 final_score_48;
   Real	 final_score_49;
   Real	 final_score_50;
   Real	 final_score_51;
   Real	 final_score_52;
   Real	 final_score_53;
   Real	 final_score_54;
   Real	 final_score_55;
   Real	 final_score_56;
   Real	 final_score_57;
   Real	 final_score_58;
   Real	 final_score_59;
   Real	 final_score_60;
   Real	 final_score_61;
   Real	 final_score_62;
   Real	 final_score_63;
   Real	 final_score_64;
   Real	 final_score_65;
   Real	 final_score_66;
   Real	 final_score_67;
   Real	 final_score_68;
   Real	 final_score_69;
   Real	 final_score_70;
   Real	 final_score_71;
   Real	 final_score_72;
   Real	 final_score_73;
   Real	 final_score_74;
   Real	 final_score_75;
   Real	 final_score_76;
   Real	 final_score_77;
   Real	 final_score_78;
   Real	 final_score_79;
   Real	 final_score_80;
   Real	 final_score_81;
   Real	 final_score_82;
   Real	 final_score_83;
   Real	 final_score_84;
   Real	 final_score_85;
   Real	 final_score_86;
   Real	 final_score_87;
   Real	 final_score_88;
   Real	 final_score_89;
   Real	 final_score_90;
   Real	 final_score_91;
   Real	 final_score_92;
   Real	 final_score_93;
   Real	 final_score_94;
   Real	 final_score_95;
   Real	 final_score_96;
   Real	 final_score_97;
   Real	 final_score_98;
   Real	 final_score_99;
   Real	 final_score_100;
   Real	 final_score_101;
   Real	 final_score_102;
   Real	 final_score_103;
   Real	 final_score_104;
   Real	 final_score_105;
   Real	 final_score_106;
   Real	 final_score_107;
   Real	 final_score_108;
   Real	 final_score_109;
   Real	 final_score_110;
   Real	 final_score_111;
   Real	 final_score_112;
   Real	 final_score_113;
   Real	 final_score_114;
   Real	 final_score_115;
   Real	 final_score_116;
   Real	 final_score;
   Integer	 base;
   Integer	 pts;
   Real	 lgt;
   Integer	 fp1609_2_0;
   Boolean	 _ver_src_ds;
   Boolean	 _ver_src_de;
   Boolean	 _ver_src_eq;
   Boolean	 _ver_src_en;
   Boolean	 _ver_src_tn;
   Boolean	 _ver_src_tu;
   Real	 _credit_source_cnt;
   Boolean	 _ver_src_cnt;
   Boolean	 _bureauonly;
   Boolean	 _derog;
   Boolean	 _deceased;
   Boolean	 _ssnpriortodob;
   Boolean	 _inputmiskeys;
   Boolean	 _multiplessns;
   Real	 _hh_strikes;
   Integer	 stolenid;
   Integer	 manipulatedid;
   Integer	 manipulatedidpt2;
   Integer	 syntheticid;
   Integer	 suspiciousactivity;
   Integer	 vulnerablevictim;
   Integer	 friendlyfraud;
   Integer	 stolenc_fp1609_2_0;
   Integer	 manip2c_fp1609_2_0;
   Integer	 synthc_fp1609_2_0;
   Integer	 suspactc_fp1609_2_0;
   Integer	 vulnvicc_fp1609_2_0;
   Integer	 friendlyc_fp1609_2_0;
   Integer	 custstolidindex;
   Integer	 custmanipidindex;
   Integer	 custsynthidindex;
   Integer	 custsuspactindex;


			models.layouts.layout_fp1109;
			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
    layout_debug doModel( clam le) := TRANSFORM
  #else
    models.layouts.layout_fp1109 doModel( clam le ) := TRANSFORM
		
  #end	

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_type                         := le.iid.nap_type;
	nap_status                       := le.iid.nap_status;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	combo_dobscore                   := le.iid.combo_dobscore;
	hdr_source_profile               := le.source_profile;
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
	bus_name_match                   := le.business_header_address_summary.bus_name_match;
	bus_phone_match                  := le.business_header_address_summary.bus_phone_match;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	emailpop                         := le.input_validation.email;
	hphnpop                          := le.input_validation.homephone;
	util_adl_type_list               := le.utility.utili_adl_type;
	util_adl_count                   := le.utility.utili_adl_count;
	util_add_curr_type_list          := le.utility.utili_addr2_type;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_lres                    := le.lres2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	max_lres                         := le.other_address_info.max_lres;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	telcordia_type                   := le.phone_verification.telcordia_type;
	phone_ver_insurance              := le.insurance_phones_summary.Insurance_Phone_Verification;
	phone_ver_experian               := le.Experian_Phone_Verification;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	addrs_per_ssn                    := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn );
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	lnames_per_adl_c6                := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	addrs_per_ssn_c6                 := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn_created_6months );
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	dl_addrs_per_adl                 := le.velocity_counters.dl_addrs_per_adl;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	inq_email_ver_count              := le.acc_logs.inquiry_email_ver_ct;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_auto_count24                 := le.acc_logs.auto.count24;
	inq_banking_count                := le.acc_logs.banking.counttotal;
	inq_banking_count01              := le.acc_logs.banking.count01;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_banking_count06              := le.acc_logs.banking.count06;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_banking_count24              := le.acc_logs.banking.count24;
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
	inq_mortgage_count               := le.acc_logs.mortgage.counttotal;
	inq_mortgage_count01             := le.acc_logs.mortgage.count01;
	inq_mortgage_count03             := le.acc_logs.mortgage.count03;
	inq_mortgage_count06             := le.acc_logs.mortgage.count06;
	inq_mortgage_count12             := le.acc_logs.mortgage.count12;
	inq_mortgage_count24             := le.acc_logs.mortgage.count24;
	inq_other_count_week             := if(isFCRA, 0, le.acc_logs.other.countweek);
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_retail_count                 := le.acc_logs.retail.counttotal;
	inq_retail_count01               := le.acc_logs.retail.count01;
	inq_retail_count03               := le.acc_logs.retail.count03;
	inq_retail_count06               := le.acc_logs.retail.count06;
	inq_retail_count12               := le.acc_logs.retail.count12;
	inq_retail_count24               := le.acc_logs.retail.count24;
	inq_retailpayments_count         := le.acc_logs.retailpayments.counttotal;
	inq_retailpayments_count_week    := if(isFCRA, 0, le.acc_logs.retailPayments.countweek);
	inq_retailpayments_count01       := le.acc_logs.retailpayments.count01;
	inq_retailpayments_count03       := le.acc_logs.retailpayments.count03;
	inq_retailpayments_count06       := le.acc_logs.retailpayments.count06;
	inq_retailpayments_count12       := le.acc_logs.retailpayments.count12;
	inq_retailpayments_count24       := le.acc_logs.retailpayments.count24;
	inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
	inq_lnamesperssn                 := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerSSN );
	inq_addrsperssn                  := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_adlsperaddr                  := if(isFCRA, 0, le.acc_logs.inquiryADLsPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	inq_adlsperphone                 := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	email_count                      := le.email_summary.email_ct;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
	email_verification               := le.email_summary.identity_email_verification_level;
	email_name_addr_verification     := le.email_summary.reverse_email.verification_level;
	adl_per_email                    := le.email_summary.reverse_email.adls_per_email;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	fp_idrisktype                    := le.fdattributesv2.identityrisklevel;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_vardobcountnew                := le.fdattributesv2.variationdobcountnew;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchcountwk                   := le.fdattributesv2.searchcountweek;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
	fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
	fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
	fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
	fp_corrrisktype                  := le.fdattributesv2.correlationrisklevel;
	fp_corrssnnamecount              := le.fdattributesv2.correlationssnnamecount;
	fp_corrssnaddrcount              := le.fdattributesv2.correlationssnaddrcount;
	fp_corraddrnamecount             := le.fdattributesv2.correlationaddrnamecount;
	fp_corraddrphonecount            := le.fdattributesv2.correlationaddrphonecount;
	fp_corrphonelastnamecount        := le.fdattributesv2.correlationphonelastnamecount;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_divssnidmsrcurelcount         := le.fdattributesv2.divssnidentitymsourceurelcount;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountday          := le.fdattributesv2.searchaddrsearchcountday;
	fp_componentcharrisktype         := le.fdattributesv2.componentcharrisklevel;
	fp_curraddractivephonelist       := le.fdattributesv2.curraddractivephonelist;
	fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	bk_chapter                       := le.bjl.bk_chapter;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_first_seen        := le.liens.liens_unreleased_civil_judgment.earliest_filing_date;
	liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	liens_rel_cj_first_seen          := le.liens.liens_released_civil_judgment.earliest_filing_date;
	liens_rel_cj_last_seen           := le.liens.liens_released_civil_judgment.most_recent_filing_date;
	liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
	liens_unrel_ft_last_seen         := le.liens.liens_unreleased_federal_tax.most_recent_filing_date;
	liens_rel_ft_total_amount        := le.liens.liens_released_federal_tax.total_amount;
	liens_unrel_fc_first_seen        := le.liens.liens_unreleased_foreclosure.earliest_filing_date;
	liens_unrel_fc_total_amount      := le.liens.liens_unreleased_foreclosure.total_amount;
	liens_unrel_o_first_seen         := le.liens.liens_unreleased_other_lj.earliest_filing_date;
	liens_unrel_o_total_amount       := le.liens.liens_unreleased_other_lj.total_amount;
	liens_unrel_ot_first_seen        := le.liens.liens_unreleased_other_tax.earliest_filing_date;
	liens_unrel_ot_last_seen         := le.liens.liens_unreleased_other_tax.most_recent_filing_date;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	liens_rel_ot_first_seen          := le.liens.liens_released_other_tax.earliest_filing_date;
	liens_rel_ot_last_seen           := le.liens.liens_released_other_tax.most_recent_filing_date;
	liens_unrel_sc_first_seen        := le.liens.liens_unreleased_small_claims.earliest_filing_date;
	liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
	liens_unrel_st_first_seen        := le.liens.liens_unreleased_suits.earliest_filing_date;
	liens_unrel_st_last_seen         := le.liens.liens_unreleased_suits.most_recent_filing_date;
	liens_unrel_st_total_amount      := le.liens.liens_unreleased_suits.total_amount;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	foreclosure_last_date            := le.bjl.last_foreclosure_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	rel_felony_count                 := le.relatives.relative_felony_count;
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	acc_count                        := le.accident_data.acc.num_accidents;
	acc_damage_amt_total             := le.accident_data.acc.dmgamtaccidents;
	acc_last_seen                    := le.accident_data.acc.datelastaccident;
	acc_count_30                     := le.accident_data.acc.numaccidents30;
	acc_count_90                     := le.accident_data.acc.numaccidents90;
	acc_count_180                    := le.accident_data.acc.numaccidents180;
	acc_count_12                     := le.accident_data.acc.numaccidents12;
	acc_count_24                     := le.accident_data.acc.numaccidents24;
	acc_count_36                     := le.accident_data.acc.numaccidents36;
	acc_count_60                     := le.accident_data.acc.numaccidents60;
	inferred_age                     := le.inferred_age;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

NULL := -999999999;


INTEGER contains_i(    String haystack,    String needle ) := (INTEGER)(   StringLib.   StringFind(haystack, needle, 1) > 

0);

sysdate := common.sas_date(if(le.historydate=999999, (   String8)Std.Date.Today(), (   String6)le.historydate+'01'));

k_nap_phn_verd_d := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

k_inf_addr_verd_d := (infutor_nap in [3, 5, 6, 8, 10, 11, 12]);

k_inf_fname_verd_d := (infutor_nap in [2, 3, 4, 8, 9, 10, 12]);

k_inf_contradictory_i := (infutor_nap in [1]);

r_p88_phn_dst_to_inp_add_i := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

r_p85_phn_not_issued_i := map(
    not(hphnpop)                 => NULL,
    (rc_pwphonezipflag in ['4']) => 1,
                   0);

r_p85_phn_disconnected_i := map(
    not(hphnpop)          => NULL,
    rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => 1,
            0);

r_phn_cell_n_1 := if(not(hphnpop), NULL, NULL);

r_phn_cell_n := if(rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim

(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim

(telcordia_type, LEFT), LEFT, RIGHT) = '60', 1, 0);

r_l70_add_invalid_i := map(
    not(addrpop)      => NULL,
    trim(trim(rc_addrvalflag, LEFT), LEFT, RIGHT) = 'N' => 1,
                         0);

r_l77_apartment_i := map(
    not(addrpop)                                => NULL,
       StringLib.   StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or    StringLib.   StringToUpperCase(trim

(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = '') => 1,
                                  0);

r_f00_dob_score_d := if(not(truedid and dobpop) or combo_dobscore = 255, NULL, min(if(combo_dobscore = NULL, -NULL, 

combo_dobscore), 999));

r_f01_inp_addr_address_score_d := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if

(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

r_d30_derog_count_i := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 

999));

r_d32_criminal_count_i := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

r_d32_felony_count_i := if(not(truedid), NULL, min(if(felony_count = NULL, -NULL, felony_count), 999));

_criminal_last_date := common.sas_date((   String)(criminal_last_date));

r_d32_mos_since_crim_ls_d := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                 max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - 

_criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if 

((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup

((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

_felony_last_date := common.sas_date((   String)(felony_last_date));

r_d32_mos_since_fel_ls_d := map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
               max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - 

_felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - 

_felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - 

_felony_last_date) / (365.25 / 12)))), 240)));

// r_d31_mostrec_bk_i :=  __common__(map(
    // not(truedid)                                    => NULL,
    // contains_i(Stringlib.stringtouppercase(TRIM(disposition[1..7]), 'DISMISS') = 1  => 1,
    // contains_i(Stringlib.stringtouppercase(disposition), 'DISCHARG') = 1 => 2,
    // (integer)bankrupt = 1 or (integer)filing_count > 0                => 3,
 
 r_d31_mostrec_bk_i := __common__( map(
    not(truedid)                     => NULL,
    StringLib.StringToUpperCase(TRIM(disposition[1..7]))  = 'DISMISS'  => 1,
    StringLib.StringToUpperCase(TRIM(disposition[1..8])) = 'DISCHARG' => 2,
    bankrupt or filing_count > 0 => 3,
                                        0));                                              

r_d31_bk_filing_count_i := if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999));

r_d31_bk_disposed_recent_count_i := if(not(truedid), NULL, min(if(bk_disposed_recent_count = NULL, -NULL, 

bk_disposed_recent_count), 999));

r_d33_eviction_count_i := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

r_d34_unrel_liens_ct_i := if(not(truedid), NULL, min(if(if(max(liens_recent_unreleased_count, 

liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, 

liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -

NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if

(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, 

liens_historical_unreleased_ct)))), 999));

r_d34_unrel_lien60_count_i := if(not(truedid), NULL, min(if(attr_num_unrel_liens60 = NULL, -NULL, attr_num_unrel_liens60), 

999));

bureau_adl_eq_fseen_pos_2 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_2 := if(bureau_adl_eq_fseen_pos_2 = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_eq_fseen_pos_2, ','));

_bureau_adl_fseen_eq_2 := common.sas_date((   String)(bureau_adl_fseen_eq_2));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq_2 = NULL, -NULL, _bureau_adl_fseen_eq_2), 999999);

r_c21_m_bureau_adl_fs_d := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => 1000,
                     min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - 

_src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if 

((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), 

roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

bureau_adl_eq_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq_1 := if(bureau_adl_eq_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_eq_fseen_pos_1, ','));

_bureau_adl_fseen_eq_1 := common.sas_date((   String)(bureau_adl_fseen_eq_1));

bureau_adl_en_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en_1 := if(bureau_adl_en_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_en_fseen_pos_1, ','));

_bureau_adl_fseen_en_1 := common.sas_date((   String)(bureau_adl_fseen_en_1));

bureau_adl_ts_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts_1 := if(bureau_adl_ts_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_ts_fseen_pos_1, ','));

_bureau_adl_fseen_ts_1 := common.sas_date((   String)(bureau_adl_fseen_ts_1));

bureau_adl_tu_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu_1 := if(bureau_adl_tu_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_tu_fseen_pos_1, ','));

_bureau_adl_fseen_tu_1 := common.sas_date((   String)(bureau_adl_fseen_tu_1));

bureau_adl_tn_fseen_pos_1 := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn_1 := if(bureau_adl_tn_fseen_pos_1 = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_tn_fseen_pos_1, ','));

_bureau_adl_fseen_tn_1 := common.sas_date((   String)(bureau_adl_fseen_tn_1));

_src_bureau_adl_fseen_all := min(if(_bureau_adl_fseen_tn_1 = NULL, -NULL, _bureau_adl_fseen_tn_1), if

(_bureau_adl_fseen_ts_1 = NULL, -NULL, _bureau_adl_fseen_ts_1), if(_bureau_adl_fseen_tu_1 = NULL, -NULL, 

_bureau_adl_fseen_tu_1), if(_bureau_adl_fseen_en_1 = NULL, -NULL, _bureau_adl_fseen_en_1), if(_bureau_adl_fseen_eq_1 = 

NULL, -NULL, _bureau_adl_fseen_eq_1), 999999);

f_m_bureau_adl_fs_all_d := map(
    not(truedid)      => NULL,
    _src_bureau_adl_fseen_all = 999999 => 1000,
        min(if(if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - 

_src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / 

(365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)))), 999));

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((   String)(bureau_adl_fseen_eq));

bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_en_fseen_pos, ','));

_bureau_adl_fseen_en := common.sas_date((   String)(bureau_adl_fseen_en));

bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_ts_fseen_pos, ','));

_bureau_adl_fseen_ts := common.sas_date((   String)(bureau_adl_fseen_ts));

bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_tu_fseen_pos, ','));

_bureau_adl_fseen_tu := common.sas_date((   String)(bureau_adl_fseen_tu));

bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, 

bureau_adl_tn_fseen_pos, ','));

_bureau_adl_fseen_tn := common.sas_date((   String)(bureau_adl_fseen_tn));

_src_bureau_adl_fseen_notu := min(if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = 

NULL, -NULL, _bureau_adl_fseen_eq), 999999);

f_m_bureau_adl_fs_notu_d := map(
    not(truedid)       => NULL,
    _src_bureau_adl_fseen_notu = 999999 => 1000,
         min(if(if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - 

_src_bureau_adl_fseen_notu) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_notu) / 

(365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_notu) / (365.25 / 12)))), 999));

_header_first_seen := common.sas_date((   String)(header_first_seen));

r_c10_m_hdr_fs_d := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / 

(365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) 

/ (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / 

(365.25 / 12)))), 999));

r_c12_num_nonderogs_d := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 999));

r_s66_adlperssn_count_i := map(
    not(ssnlength > '0') => NULL,
    adls_per_ssn = 0   => 1,
         min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

r_a44_curr_add_naprop_d := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);

r_c13_curr_addr_lres_d := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 

999));

r_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

r_a41_prop_owner_d := map(
    not(truedid)               => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 => 1,
                 0);

r_c20_email_count_i := if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999));

r_c20_email_domain_free_count_i := if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999));

r_c20_email_domain_isp_count_i := __common__(if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999)));

r_l79_adls_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

r_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

r_c18_invalid_addrs_per_adl_i := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));

r_i60_inq_count12_i := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

r_i60_inq_recency_d := map(
    not(truedid) => NULL,
    (Boolean)inq_count01  => 1,
    (Boolean)inq_count03  => 3,
    (Boolean)inq_count06  => 6,
    (Boolean)inq_count12  => 12,
    (Boolean)inq_count24  => 24,
    (Boolean)inq_count    => 99,
   999);

r_i61_inq_collection_count12_i := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, 

inq_collection_count12), 999));

r_i61_inq_collection_recency_d :=  map(
    not(truedid)           => NULL,
    (Boolean)inq_collection_count01 => 1,
    (Boolean)inq_collection_count03 => 3,
    (Boolean)inq_collection_count06 => 6,
    (Boolean)inq_collection_count12 => 12,
    (Boolean)inq_collection_count24 => 24,
    (Boolean)inq_collection_count   => 99,
                              999);

r_i60_inq_banking_recency_d := map(
    not(truedid)        => NULL,
    (Boolean)inq_banking_count01 => 1,
    (Boolean)inq_banking_count03 => 3,
    (Boolean)inq_banking_count06 => 6,
    (Boolean)inq_banking_count12 => 12,
    (Boolean)inq_banking_count24 => 24,
    (Boolean)inq_banking_count   => 99,
          999);

r_i60_inq_mortgage_recency_d := map(
    not(truedid)         => NULL,
    (Boolean)inq_mortgage_count01 => 1,
    (Boolean)inq_mortgage_count03 => 3,
    (Boolean)inq_mortgage_count06 => 6,
    (Boolean)inq_mortgage_count12 => 12,
    (Boolean)inq_mortgage_count24 => 24,
    (Boolean)inq_mortgage_count   => 99,
           999);

r_i60_inq_hiriskcred_count12_i := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, 

inq_highRiskCredit_count12), 999));

r_i60_inq_hiriskcred_recency_d := map(
    not(truedid)               => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
                 999);

r_i60_inq_retail_recency_d := map(
    not(truedid)       => NULL,
    (Boolean)inq_retail_count01 => 1,
    (Boolean)inq_retail_count03 => 3,
    (Boolean)inq_retail_count06 => 6,
    (Boolean)inq_retail_count12 => 12,
    (Boolean)inq_retail_count24 => 24,
    (Boolean)inq_retail_count   => 99,
         999);

r_i60_inq_comm_count12_i := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, 

inq_communications_count12), 999));

r_i60_inq_comm_recency_d := map(
    not(truedid)               => NULL,
    (Boolean)inq_communications_count01 => 1,
    (Boolean)inq_communications_count03 => 3,
    (Boolean)inq_communications_count06 => 6,
    (Boolean)inq_communications_count12 => 12,
    (Boolean)inq_communications_count24 => 24,
    (Boolean)inq_communications_count   => 99,
                 999);

f_bus_addr_match_count_d := if(not(addrpop), NULL, bus_addr_match_count);

f_bus_lname_verd_d := if(not(addrpop), NULL, (Integer)(bus_name_match in [3, 4]));

f_bus_name_nover_i := if(not(addrpop), NULL, (integer)(bus_name_match = 1));

f_bus_phone_match_d := if(not(addrpop), NULL, if(bus_phone_match = 3, 1, 0));

f_adl_util_misc_n := if(contains_i(   StringLib.   StringToUpperCase(util_adl_type_list), 'Z') > 0, 1, 0);

f_util_adl_count_n := if(not(truedid), NULL, util_adl_count);

f_util_add_curr_misc_n := if(contains_i(   StringLib.   StringToUpperCase(util_add_curr_type_list), 'Z') > 0, 1, 0);

f_inq_count24_i := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

f_inq_auto_count24_i := if(not(truedid), NULL, min(if(inq_Auto_count24 = NULL, -NULL, inq_Auto_count24), 999));

f_inq_collection_count24_i := if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 

999));

f_inq_communications_count24_i := if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, 

inq_Communications_count24), 999));

f_inq_highriskcredit_count24_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, 

inq_HighRiskCredit_count24), 999));

f_inq_other_count24_i := if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999));

k_inq_per_ssn_i := if(not(ssnlength > '0'), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

k_inq_lnames_per_ssn_i := if(not(ssnlength > '0'), NULL, min(if(inq_lnamesperssn = NULL, -NULL, inq_lnamesperssn), 999));

k_inq_addrs_per_ssn_i := if(not(ssnlength > '0'), NULL, min(if(inq_addrsperssn = NULL, -NULL, inq_addrsperssn), 999));

k_inq_per_addr_i := if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

k_inq_adls_per_addr_i := if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

k_inq_lnames_per_addr_i := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

k_inq_ssns_per_addr_i := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

k_inq_per_phone_i := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

k_inq_adls_per_phone_i := if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999));

_liens_unrel_cj_first_seen := common.sas_date((   String)(liens_unrel_CJ_first_seen));

f_mos_liens_unrel_cj_fseen_d := map(
    not(truedid)     => NULL,
    _liens_unrel_cj_first_seen = NULL => 1000,
       min(if(if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_first_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_cj_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_cj_last_seen := common.sas_date((   String)(liens_unrel_CJ_last_seen));

f_mos_liens_unrel_cj_lseen_d := map(
    not(truedid)    => NULL,
    _liens_unrel_cj_last_seen = NULL => 1000,
      max(3, min(if(if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_cj_last_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)))), 999)));

f_liens_unrel_cj_total_amt_i := if(not(truedid), NULL, liens_unrel_CJ_total_amount);

_liens_rel_cj_first_seen := common.sas_date((   String)(liens_rel_CJ_first_seen));

f_mos_liens_rel_cj_fseen_d := map(
    not(truedid)   => NULL,
    _liens_rel_cj_first_seen = NULL => 1000,
                      min(if(if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_rel_cj_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12))) = NULL, -NULL, 

if ((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_first_seen) / (365.25 / 

12)), roundup((sysdate - _liens_rel_cj_first_seen) / (365.25 / 12)))), 999));

_liens_rel_cj_last_seen := common.sas_date((   String)(liens_rel_CJ_last_seen));

f_mos_liens_rel_cj_lseen_d := map(
    not(truedid)                   => NULL,
    _liens_rel_cj_last_seen = NULL => 1000,
                     max(3, min(if(if ((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_rel_cj_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12))) = NULL, -NULL, if 

((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)), 

roundup((sysdate - _liens_rel_cj_last_seen) / (365.25 / 12)))), 999)));

f_liens_rel_cj_total_amt_i := if(not(truedid), NULL, liens_rel_CJ_total_amount);

_liens_unrel_ft_last_seen := common.sas_date((   String)(liens_unrel_FT_last_seen));

f_mos_liens_unrel_ft_lseen_d := map(
    not(truedid)    => NULL,
    _liens_unrel_ft_last_seen = NULL => 1000,
      max(3, min(if(if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_ft_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ft_last_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)))), 999)));

f_liens_rel_ft_total_amt_i := if(not(truedid), NULL, liens_rel_FT_total_amount);

_liens_unrel_fc_first_seen := common.sas_date((   String)(liens_unrel_FC_first_seen));

f_mos_liens_unrel_fc_fseen_d := map(
    not(truedid)     => NULL,
    _liens_unrel_fc_first_seen = NULL => 1000,
       min(if(if ((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_fc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_fc_first_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_fc_first_seen) / (365.25 / 12)))), 999));

f_liens_unrel_fc_total_amt_i := if(not(truedid), NULL, liens_unrel_FC_total_amount);

_liens_unrel_o_first_seen := common.sas_date((   String)(liens_unrel_O_first_seen));

f_mos_liens_unrel_o_fseen_d := map(
    not(truedid)    => NULL,
    _liens_unrel_o_first_seen = NULL => 1000,
      min(if(if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_o_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_o_first_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_o_first_seen) / (365.25 / 12)))), 999));

f_liens_unrel_o_total_amt_i := if(not(truedid), NULL, liens_unrel_O_total_amount);

_liens_unrel_ot_first_seen := common.sas_date((   String)(liens_unrel_OT_first_seen));

f_mos_liens_unrel_ot_fseen_d := map(
    not(truedid)     => NULL,
    _liens_unrel_ot_first_seen = NULL => 1000,
       min(if(if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_first_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_ot_last_seen := common.sas_date((   String)(liens_unrel_OT_last_seen));

f_mos_liens_unrel_ot_lseen_d := map(
    not(truedid)    => NULL,
    _liens_unrel_ot_last_seen = NULL => 1000,
      max(3, min(if(if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_ot_last_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)))), 999)));

f_liens_unrel_ot_total_amt_i := __common__(if(not(truedid), NULL, (integer)liens_unrel_OT_total_amount));

_liens_rel_ot_first_seen := common.sas_date((   String)(liens_rel_OT_first_seen));

f_mos_liens_rel_ot_fseen_d := map(
    not(truedid)   => NULL,
    _liens_rel_ot_first_seen = NULL => -1,
                      min(if(if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_rel_ot_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12))) = NULL, -NULL, 

if ((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 

12)), roundup((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)))), 999));

_liens_rel_ot_last_seen := common.sas_date((   String)(liens_rel_OT_last_seen));

f_mos_liens_rel_ot_lseen_d := map(
    not(truedid)                   => NULL,
    _liens_rel_ot_last_seen = NULL => 1000,
                     max(3, min(if(if ((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_rel_ot_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12))) = NULL, -NULL, if 

((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)), 

roundup((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)))), 999)));

_liens_unrel_sc_first_seen := common.sas_date((   String)(liens_unrel_SC_first_seen));

f_mos_liens_unrel_sc_fseen_d := map(
    not(truedid)     => NULL,
    _liens_unrel_sc_first_seen = NULL => 1000,
       min(if(if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_sc_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_sc_first_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_sc_first_seen) / (365.25 / 12)))), 999));

f_liens_unrel_sc_total_amt_i := if(not(truedid), NULL, liens_unrel_SC_total_amount);

_foreclosure_last_date := common.sas_date((   String)(foreclosure_last_date));

f_mos_foreclosure_lseen_d := map(
    not(truedid)                  => NULL,
    _foreclosure_last_date = NULL => 1000,
                    max(3, min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - 

_foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if 

((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), 

roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999)));

f_current_count_d := if(not(truedid), NULL, min(if(current_count = NULL, -NULL, current_count), 999));

f_historical_count_d := if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999));

f_acc_damage_amt_total_i := if(not(truedid), NULL, acc_damage_amt_total);

_acc_last_seen := common.sas_date((   String)(acc_last_seen));

f_mos_acc_lseen_d := map(
    not(truedid)          => NULL,
    _acc_last_seen = NULL => 1000,
            max(3, min(if(if ((sysdate - _acc_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / 

(365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _acc_last_seen) / 

(365.25 / 12) >= 0, truncate((sysdate - _acc_last_seen) / (365.25 / 12)), roundup((sysdate - _acc_last_seen) / (365.25 / 

12)))), 999)));

f_accident_recency_d := map(
    not(truedid)  => NULL,
    (Boolean)acc_count_30  => 1,
    (Boolean)acc_count_90  => 3,
    (Boolean)acc_count_180 => 6,
    (Boolean)acc_count_12  => 12,
    (Boolean)acc_count_24  => 24,
    (Boolean)acc_count_36  => 36,
    (Boolean)acc_count_60  => 60,
    (Boolean)acc_count     => 61,
    62);

f_idrisktype_i := if(not(truedid) or fp_idrisktype = '', NULL, (Integer)fp_idrisktype);

f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = '', NULL, (Integer)fp_idverrisktype);

f_varrisktype_i := map(
    not(truedid)          => NULL,
    fp_varrisktype = '' => NULL,
            (Integer)fp_varrisktype);

f_vardobcountnew_i := if(not(truedid), NULL, min(if(fp_vardobcountnew = '', -NULL, (integer)fp_vardobcountnew), 999));

f_srchvelocityrisktype_i := map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = '' => NULL,
                     (Integer)fp_srchvelocityrisktype);

f_srchcountwk_i := if(not(truedid), NULL, min(if(fp_srchcountwk = '', -NULL, (Integer)fp_srchcountwk), 999));

f_srchunvrfdaddrcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, 

(Integer)fp_srchunvrfdaddrcount), 999));

f_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, 

(Integer)fp_srchunvrfdphonecount), 999));

f_srchfraudsrchcountyr_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, 

(Integer)fp_srchfraudsrchcountyr), 999));

f_srchfraudsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, 

(Integer)fp_srchfraudsrchcountmo), 999));

f_srchfraudsrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, 

(Integer)fp_srchfraudsrchcountwk), 999));

f_assocrisktype_i := map(
    not(truedid)            => NULL,
    fp_assocrisktype = '' => NULL,
              (Integer)fp_assocrisktype);

f_assocsuspicousidcount_i := if(not(truedid), NULL, min(if(fp_assocsuspicousidcount = '', -NULL, 

(Integer)fp_assocsuspicousidcount), 999));

f_corrrisktype_i := map(
    not(truedid)           => NULL,
    fp_corrrisktype = '' => NULL,
             (Integer)fp_corrrisktype);

f_corrssnnamecount_d := if(not(truedid), NULL, min(if(fp_corrssnnamecount = '', -NULL, (Integer)fp_corrssnnamecount), 

999));

f_corrssnaddrcount_d := if(not(truedid), NULL, min(if(fp_corrssnaddrcount = '', -NULL, (Integer)fp_corrssnaddrcount), 

999));

f_corraddrnamecount_d := if(not(truedid), NULL, min(if(fp_corraddrnamecount = '', -NULL, (Integer)fp_corraddrnamecount), 

999));

f_corraddrphonecount_d := if(not(truedid), NULL, min(if(fp_corraddrphonecount = '', -NULL, 

(Integer)fp_corraddrphonecount), 999));

f_corrphonelastnamecount_d := if(not(truedid), NULL, min(if(fp_corrphonelastnamecount = '', -NULL, 

(Integer)fp_corrphonelastnamecount), 999));

f_divrisktype_i := map(
    not(truedid)          => NULL,
    fp_divrisktype = '' => NULL,
            (Integer)fp_divrisktype);

f_divssnidmsrcurelcount_i := if(not(truedid), NULL, min(if(fp_divssnidmsrcurelcount = '', -NULL, 

(Integer)fp_divssnidmsrcurelcount), 999));

f_srchcomponentrisktype_i := map(
    not(truedid)   => NULL,
    fp_srchcomponentrisktype = '' => NULL,
                      (Integer)fp_srchcomponentrisktype);

f_srchssnsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcountmo = '', -NULL, 

(Integer)fp_srchssnsrchcountmo), 999));

f_srchaddrsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, 

(Integer)fp_srchaddrsrchcountmo), 999));

f_srchaddrsrchcountday_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcountday = '', -NULL, 

(Integer)fp_srchaddrsrchcountday), 999));

f_componentcharrisktype_i := map(
    not(truedid)   => NULL,
    fp_componentcharrisktype = '' => NULL,
                      (Integer)fp_componentcharrisktype);

f_curraddractivephonelist_d := map(
    not(add_curr_pop)               => NULL,
    fp_curraddractivephonelist = '-1' => NULL,
                      (Integer)fp_curraddractivephonelist);

f_prevaddrageoldest_d := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (Integer)fp_prevaddrageoldest), 

999));

f_prevaddrlenofres_d := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (Integer)fp_prevaddrlenofres), 

999));

r_d31_all_bk_i := map(
    not(truedid)                                                     => NULL,
    contains_i(   StringLib.   StringToUpperCase(disposition), 'DISMISS') = 1 or if(max(bk_dismissed_recent_count, 

bk_dismissed_historical_count) = NULL, NULL, sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), if

(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0 => 1,
    contains_i(   StringLib.   StringToUpperCase(disposition), 'DISCHARG') = 1 or if(max(bk_disposed_recent_count, 

bk_disposed_historical_count) = NULL, NULL, sum(if(bk_disposed_recent_count = NULL, 0, bk_disposed_recent_count), if

(bk_disposed_historical_count = NULL, 0, bk_disposed_historical_count))) > 0      => 2,
    (Integer)bankrupt = 1 or filing_count > 0                                                  => 3,
                                                       0);

r_d31_bk_chapter_n := map(
    not(truedid)                => '',
    not((bk_chapter in ['7', '11', '12', '13'])) => '',
                  trim(bk_chapter, LEFT));

r_c12_source_profile_d := if(not(truedid), NULL, round((real)hdr_source_profile,1));

r_c12_source_profile_index_d := if(not(truedid), NULL, hdr_source_profile_index);

r_c23_inp_addr_occ_index_d := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

r_e57_br_source_count_d := if(not(truedid), NULL, br_source_count);

r_i60_inq_prepaidcards_recency_d := map(
    not(truedid)             => NULL,
    (Boolean)inq_PrepaidCards_count01 => 1,
    (Boolean)inq_PrepaidCards_count03 => 3,
    (Boolean)inq_PrepaidCards_count06 => 6,
    (Boolean)inq_PrepaidCards_count12 => 12,
    (Boolean)inq_PrepaidCards_count24 => 24,
    (Boolean)inq_PrepaidCards_count   => 99,
               999);

r_i60_inq_retpymt_count12_i := if(not(truedid), NULL, min(if(inq_retailpayments_count12 = NULL, -NULL, inq_retailpayments_count12), 999));

r_i60_inq_retpymt_recency_d := map(
    not(truedid)               => NULL,
    (Boolean)inq_retailpayments_count01 => 1,
    (Boolean)inq_retailpayments_count03 => 3,
    (Boolean)inq_retailpayments_count06 => 6,
    (Boolean)inq_retailpayments_count12 => 12,
    (Boolean)inq_retailpayments_count24 => 24,
    (Boolean)inq_retailpayments_count   => 99,
                 999);

f_phone_ver_insurance_d := if(not(truedid) or phone_ver_insurance = '-1', NULL, (integer)phone_ver_insurance);

f_phone_ver_experian_d := if(not(truedid) or phone_ver_experian = '-1', NULL, (integer)phone_ver_experian);

f_addrs_per_ssn_i := if(not(ssnlength > '0'), NULL, min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 999));

f_phones_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 

999));

f_addrs_per_ssn_c6_i := if(not(ssnlength > '0'), NULL, min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 999));

f_dl_addrs_per_adl_i := if(not(truedid), NULL, min(if(dl_addrs_per_adl = NULL, -NULL, dl_addrs_per_adl), 999));

f_inq_email_ver_count_i := if(not(truedid), NULL, min(if(inq_email_ver_count = NULL, -NULL, inq_email_ver_count), 999));

f_inq_other_count_week_i := if(not(truedid), NULL, min(if(inq_Other_count_week = NULL, -NULL, inq_Other_count_week), 

999));

f_inq_retailpayments_cnt_week_i := if(not(truedid), NULL, min(if(inq_RetailPayments_count_week = NULL, -NULL, 

inq_RetailPayments_count_week), 999));

f_inq_retailpayments_count24_i := if(not(truedid), NULL, min(if(inq_RetailPayments_count24 = NULL, -NULL, 

inq_RetailPayments_count24), 999));

f_nae_email_verd_d := ((integer)email_name_addr_verification in [2, 3, 4, 5, 6, 7, 8]);

f_nae_lname_verd_d := ((integer)email_name_addr_verification in [4, 5, 7, 8]);

f_nae_contradictory_i := (integer)email_name_addr_verification = 1;

f_adl_per_email_i := if(not(emailpop), NULL, min(if(adl_per_email = NULL, -NULL, adl_per_email), 999));

r_c20_email_verification_d := if(not(emailpop), NULL, (Integer)email_verification);

_liens_unrel_st_first_seen := common.sas_date((   String)(liens_unrel_ST_first_seen));

f_mos_liens_unrel_st_fseen_d := map(
    not(truedid)     => NULL,
    _liens_unrel_st_first_seen = NULL => 1000,
       min(if(if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_st_first_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_first_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_st_first_seen) / (365.25 / 12)))), 999));

_liens_unrel_st_last_seen := common.sas_date((   String)(liens_unrel_ST_last_seen));

f_mos_liens_unrel_st_lseen_d := map(
    not(truedid)    => NULL,
    _liens_unrel_st_last_seen = NULL => 1000,
      max(3, min(if(if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - 

_liens_unrel_st_last_seen) / (365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12))) = NULL, -

NULL, if ((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _liens_unrel_st_last_seen) / 

(365.25 / 12)), roundup((sysdate - _liens_unrel_st_last_seen) / (365.25 / 12)))), 999)));

f_liens_unrel_st_total_amt_i := if(not(truedid), NULL, liens_unrel_ST_total_amount);

final_score_0 := -1.4996137748;

final_score_1_c163 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 86.5 => 0.1376869458,
    f_prevaddrlenofres_d > 86.5                 => 0.2729013959,
    f_prevaddrlenofres_d = NULL                 => 0.2367455845,
                 0.2367455845);

final_score_1_c162 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_1_c163,
    r_phn_cell_n > 0.5         => 0.0746832533,
    r_phn_cell_n = NULL        => 0.1946030806,
                 0.1946030806);

final_score_1_c161 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_1_c162,
    f_adl_per_email_i > 0.5              => -0.0558348609,
    f_adl_per_email_i = NULL             => -0.1223216355,
          0.1486198712);

final_score_1_c164 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => 0.0440239327,
    r_c20_email_verification_d > 0.5      => -0.1055636985,
    r_c20_email_verification_d = NULL                      => -0.1208675846,
                            -0.0668073699);

final_score_1 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_1_c161,
    f_phone_ver_experian_d > 0.5                   => final_score_1_c164,
    f_phone_ver_experian_d = NULL                  => -0.0016644888,
                    -0.0019053214);

final_score_2_c168 := map(
    NULL < f_corraddrphonecount_d AND f_corraddrphonecount_d <= 0.5 => 0.2141479071,
    f_corraddrphonecount_d > 0.5                   => 0.0609933826,
    f_corraddrphonecount_d = NULL                  => 0.1918602525,
                    0.1918602525);

final_score_2_c167 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_2_c168,
    r_phn_cell_n > 0.5         => 0.0575150191,
    r_phn_cell_n = NULL        => 0.1573736489,
                 0.1573736489);

final_score_2_c166 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_2_c167,
    f_adl_per_email_i > 0.5              => -0.0556280480,
    f_adl_per_email_i = NULL             => -0.1197516054,
          0.1207914792);

final_score_2_c169 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => 0.0377113690,
    r_c20_email_verification_d > 0.5      => -0.1044853970,
    r_c20_email_verification_d = NULL                      => -0.1181503851,
                            -0.0685014593);

final_score_2 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_2_c166,
    f_phone_ver_experian_d > 0.5                   => final_score_2_c169,
    f_phone_ver_experian_d = NULL                  => -0.0055036289,
                    -0.0104358675);

final_score_3_c173 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 225.5 => 0.0555029986,
    f_m_bureau_adl_fs_notu_d > 225.5                     => 0.1723861712,
    f_m_bureau_adl_fs_notu_d = NULL                      => 0.1517623663,
                          0.1517623663);

final_score_3_c172 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_3_c173,
    f_corrphonelastnamecount_d > 0.5      => 0.0286250513,
    f_corrphonelastnamecount_d = NULL                      => 0.1268861410,
                            0.1268861410);

final_score_3_c171 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => final_score_3_c172,
    (Real)f_nae_email_verd_d > 0.5               => -0.0772635150,
    (Integer)f_nae_email_verd_d = NULL              => 0.0971499071,
            0.0971499071);

final_score_3_c174 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => 0.0429840902,
    r_c20_email_verification_d > 0.5      => -0.0990461218,
    r_c20_email_verification_d = NULL                      => -0.1157297543,
                            -0.0623790121);

final_score_3 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_3_c171,
    f_phone_ver_experian_d > 0.5                   => final_score_3_c174,
    f_phone_ver_experian_d = NULL                  => -0.0108831608,
                    -0.0133759309);

final_score_4_c177 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => 0.0782370729,
    r_i61_inq_collection_recency_d > 549          => -0.0288956474,
    r_i61_inq_collection_recency_d = NULL         => 0.0276300704,
                   0.0276300704);

final_score_4_c176 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1123884760,
    f_phone_ver_experian_d > 0.5                   => final_score_4_c177,
    f_phone_ver_experian_d = NULL                  => 0.1232868796,
                    0.0690128604);

final_score_4_c179 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => 0.0910776415,
    f_corrphonelastnamecount_d > 0.5      => -0.0767454593,
    f_corrphonelastnamecount_d = NULL                      => 0.0382227403,
                            0.0382227403);

final_score_4_c178 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_4_c179,
    f_phone_ver_experian_d > 0.5                   => -0.0996558374,
    f_phone_ver_experian_d = NULL                  => -0.0493451079,
                    -0.0709105435);

final_score_4 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => final_score_4_c176,
    r_c20_email_verification_d > 1.5      => final_score_4_c178,
    r_c20_email_verification_d = NULL                      => -0.1154733740,
                            -0.0175965141);

final_score_5_c182 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 112.5 => 0.0386729609,
    f_prevaddrageoldest_d > 112.5                  => 0.1197484577,
    f_prevaddrageoldest_d = NULL                   => 0.0893772377,
                    0.0893772377);

final_score_5_c184 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 11.5 => 0.0153051450,
    f_corraddrnamecount_d > 11.5                  => 0.1366911410,
    f_corraddrnamecount_d = NULL                  => 0.0427130089,
                   0.0427130089);

final_score_5_c183 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_5_c184,
    r_c20_email_verification_d > 0.5      => -0.0784938368,
    r_c20_email_verification_d = NULL                      => -0.0189466206,
                            -0.0189466206);

final_score_5_c181 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_5_c182,
    f_phone_ver_experian_d > 0.5                   => final_score_5_c183,
    f_phone_ver_experian_d = NULL                  => 0.0433135785,
                    0.0281994456);

final_score_5 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_5_c181,
    f_adl_per_email_i > 0.5              => -0.0993958207,
    f_adl_per_email_i = NULL             => -0.1135290896,
          -0.0239341363);

final_score_6_c187 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 212.5 => 0.0018253238,
    f_m_bureau_adl_fs_notu_d > 212.5                     => 0.1005827433,
    f_m_bureau_adl_fs_notu_d = NULL                      => 0.0819845867,
                          0.0819845867);

final_score_6_c186 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => final_score_6_c187,
    (Real)f_nae_email_verd_d > 0.5               => -0.0688020918,
    (Integer)f_nae_email_verd_d = NULL              => 0.0603815712,
            0.0603815712);

final_score_6_c189 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => 0.0615933544,
    r_i61_inq_collection_recency_d > 549          => -0.0364895543,
    r_i61_inq_collection_recency_d = NULL         => 0.0168606195,
                   0.0168606195);

final_score_6_c188 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_6_c189,
    r_c20_email_verification_d > 0.5      => -0.0928787799,
    r_c20_email_verification_d = NULL                      => -0.1124510658,
                            -0.0651845576);

final_score_6 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_6_c186,
    f_phone_ver_experian_d > 0.5                   => final_score_6_c188,
    f_phone_ver_experian_d = NULL                  => 0.0094407605,
                    -0.0247736042);

final_score_7_c192 := map(
    NULL < f_mos_liens_rel_cj_fseen_d AND f_mos_liens_rel_cj_fseen_d <= 283 => 0.1751312356,
    f_mos_liens_rel_cj_fseen_d > 283      => 0.0070130149,
    f_mos_liens_rel_cj_fseen_d = NULL                      => 0.0194059441,
                            0.0194059441);

final_score_7_c191 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0811024132,
    f_phone_ver_experian_d > 0.5                   => final_score_7_c192,
    f_phone_ver_experian_d = NULL                  => 0.0819305308,
                    0.0495885975);

final_score_7_c194 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => 0.0568710270,
    f_corrphonelastnamecount_d > 0.5      => -0.0727699924,
    f_corrphonelastnamecount_d = NULL                      => 0.0179153049,
                            0.0179153049);

final_score_7_c193 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_7_c194,
    f_phone_ver_experian_d > 0.5                   => -0.0909101839,
    f_phone_ver_experian_d = NULL                  => -0.0527155028,
                    -0.0679600058);

final_score_7 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => final_score_7_c191,
    r_c20_email_verification_d > 1.5      => final_score_7_c193,
    r_c20_email_verification_d = NULL                      => -0.1128081426,
                            -0.0230742628);

final_score_8_c197 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.0825942398,
    r_phn_cell_n > 0.5         => 0.0006881481,
    r_phn_cell_n = NULL        => 0.0618343939,
                 0.0618343939);

final_score_8_c199 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 132.5 => -0.0590886484,
    f_prevaddrlenofres_d > 132.5                 => 0.0236252332,
    f_prevaddrlenofres_d = NULL                  => -0.0197194055,
                  -0.0197194055);

final_score_8_c198 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 626.5 => final_score_8_c199,
    f_liens_unrel_cj_total_amt_i > 626.5        => 0.1096315296,
    f_liens_unrel_cj_total_amt_i = NULL         => -0.0077396589,
                 -0.0077396589);

final_score_8_c196 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_8_c197,
    f_phone_ver_experian_d > 0.5                   => final_score_8_c198,
    f_phone_ver_experian_d = NULL                  => 0.0218662592,
                    0.0219709188);

final_score_8 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_8_c196,
    f_adl_per_email_i > 0.5              => -0.0906092816,
    f_adl_per_email_i = NULL             => -0.1095054753,
          -0.0237876013);

final_score_9_c203 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 170.5 => 0.1251331649,
    f_mos_liens_unrel_cj_lseen_d > 170.5        => -0.0013830783,
    f_mos_liens_unrel_cj_lseen_d = NULL         => 0.0103183545,
                 0.0103183545);

final_score_9_c202 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => 0.0739432411,
    f_corrphonelastnamecount_d > 0.5      => final_score_9_c203,
    f_corrphonelastnamecount_d = NULL                      => 0.0420420602,
                            0.0420420602);

final_score_9_c201 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 203.5 => -0.0418414802,
    f_m_bureau_adl_fs_all_d > 203.5                    => final_score_9_c202,
    f_m_bureau_adl_fs_all_d = NULL                     => 0.0195696222,
                        0.0195696222);

final_score_9_c204 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 1.5 => -0.0942178879,
    f_inq_highriskcredit_count24_i > 1.5          => 0.2292363018,
    f_inq_highriskcredit_count24_i = NULL         => -0.0885230332,
                   -0.0885230332);

final_score_9 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_9_c201,
    f_adl_per_email_i > 0.5              => final_score_9_c204,
    f_adl_per_email_i = NULL             => -0.1081227431,
          -0.0249737150);

final_score_10_c207 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.0688096557,
    r_phn_cell_n > 0.5         => 0.0056738733,
    r_phn_cell_n = NULL        => 0.0474164066,
                 0.0474164066);

final_score_10_c209 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 72.5 => -0.0483752175,
    r_c13_curr_addr_lres_d > 72.5                   => 0.0537017765,
    r_c13_curr_addr_lres_d = NULL                   => 0.0244926872,
                     0.0244926872);

final_score_10_c208 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_10_c209,
    r_c20_email_verification_d > 0.5      => -0.0685332209,
    r_c20_email_verification_d = NULL                      => -0.0221726146,
                            -0.0221726146);

final_score_10_c206 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_10_c207,
    f_corrphonelastnamecount_d > 0.5      => final_score_10_c208,
    f_corrphonelastnamecount_d = NULL                      => 0.0124545300,
                            0.0124545300);

final_score_10 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_10_c206,
    f_adl_per_email_i > 0.5              => -0.0872949246,
    f_adl_per_email_i = NULL             => -0.1092047729,
          -0.0283822626);

final_score_11_c212 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 60.5 => 0.0020343365,
    f_prevaddrageoldest_d > 60.5                  => 0.0636615715,
    f_prevaddrageoldest_d = NULL                  => 0.0512439873,
                   0.0512439873);

final_score_11_c211 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_11_c212,
    f_corrphonelastnamecount_d > 0.5      => -0.0139189521,
    f_corrphonelastnamecount_d = NULL                      => 0.0353804131,
                            0.0353804131);

final_score_11_c213 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 210 => 0.0851149175,
    f_mos_liens_unrel_cj_lseen_d > 210        => -0.0532234402,
    f_mos_liens_unrel_cj_lseen_d = NULL       => -0.0450849473,
               -0.0450849473);

final_score_11_c214 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => 0.0917293675,
    f_corrphonelastnamecount_d > 0.5      => -0.0792534086,
    f_corrphonelastnamecount_d = NULL                      => -0.1048803716,
                            0.0005445037);

final_score_11 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_11_c211,
    f_phone_ver_experian_d > 0.5                   => final_score_11_c213,
    f_phone_ver_experian_d = NULL                  => final_score_11_c214,
                    -0.0190491158);

final_score_12_c217 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => 0.0565155880,
    (Real)f_nae_email_verd_d > 0.5               => -0.1115688159,
    (Integer)f_nae_email_verd_d = NULL              => 0.0458766578,
            0.0458766578);

final_score_12_c216 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 112.5 => -0.0008187320,
    f_prevaddrageoldest_d > 112.5                  => final_score_12_c217,
    f_prevaddrageoldest_d = NULL                   => 0.0273544220,
                    0.0273544220);

final_score_12_c219 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 1213.5 => -0.0813132619,
    r_p88_phn_dst_to_inp_add_i > 1213.5      => 0.0099296870,
    r_p88_phn_dst_to_inp_add_i = NULL        => 0.0212499833,
              -0.0612713078);

final_score_12_c218 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 18 => 0.1475558715,
    r_i60_inq_hiriskcred_recency_d > 18          => final_score_12_c219,
    r_i60_inq_hiriskcred_recency_d = NULL        => -0.0551793344,
                  -0.0551793344);

final_score_12 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => final_score_12_c216,
    r_c20_email_verification_d > 1.5      => final_score_12_c218,
    r_c20_email_verification_d = NULL                      => -0.1052550101,
                            -0.0246538553);

final_score_13_c221 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0558901788,
    f_phone_ver_experian_d > 0.5                   => -0.0307489472,
    f_phone_ver_experian_d = NULL                  => 0.0435630323,
                    0.0305927696);

final_score_13_c224 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => 0.0017421770,
    f_inq_other_count24_i > 0.5                  => 0.0890905151,
    f_inq_other_count24_i = NULL                 => 0.0396950866,
                  0.0396950866);

final_score_13_c223 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 133.5 => -0.0287463542,
    f_prevaddrlenofres_d > 133.5                 => final_score_13_c224,
    f_prevaddrlenofres_d = NULL                  => 0.0081545904,
                  0.0081545904);

final_score_13_c222 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_13_c223,
    r_c20_email_verification_d > 0.5      => -0.0687317397,
    r_c20_email_verification_d = NULL                      => -0.1033958597,
                            -0.0471798654);

final_score_13 := map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_13_c221,
    (Real)k_nap_phn_verd_d > 0.5             => final_score_13_c222,
    (Integer)k_nap_phn_verd_d = NULL            => -0.0250500638,
                         -0.0250500638);

final_score_14_c227 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => 0.0504662152,
    (Real)f_nae_email_verd_d > 0.5               => -0.0622269899,
    (Integer)f_nae_email_verd_d = NULL              => 0.0398850975,
            0.0398850975);

final_score_14_c226 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_14_c227,
    r_phn_cell_n > 0.5         => -0.0101375298,
    r_phn_cell_n = NULL        => 0.0245709669,
                 0.0245709669);

final_score_14_c228 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => -0.0654447164,
    r_d30_derog_count_i > 0.5                => 0.0171485548,
    r_d30_derog_count_i = NULL               => -0.0420751917,
              -0.0420751917);

final_score_14_c229 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => 0.0716742955,
    f_corrphonelastnamecount_d > 0.5      => -0.0818093003,
    f_corrphonelastnamecount_d = NULL                      => -0.0383405530,
                            -0.0050415681);

final_score_14 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_14_c226,
    f_phone_ver_experian_d > 0.5                   => final_score_14_c228,
    f_phone_ver_experian_d = NULL                  => final_score_14_c229,
                    -0.0209117785);

final_score_15_c232 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 22.5 => -0.0373046089,
    k_inq_per_ssn_i > 22.5            => 0.1474958915,
    k_inq_per_ssn_i = NULL            => -0.0313688327,
                        -0.0313688327);

final_score_15_c234 := map(
    NULL < f_liens_unrel_st_total_amt_i AND f_liens_unrel_st_total_amt_i <= 1289.5 => 0.0049946397,
    f_liens_unrel_st_total_amt_i > 1289.5        => 0.1414393875,
    f_liens_unrel_st_total_amt_i = NULL          => 0.0087279814,
                  0.0087279814);

final_score_15_c233 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => final_score_15_c234,
    f_idverrisktype_i > 1.5              => 0.0428612945,
    f_idverrisktype_i = NULL             => 0.0252526117,
          0.0252526117);

final_score_15_c231 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 50.5 => final_score_15_c232,
    f_prevaddrageoldest_d > 50.5                  => final_score_15_c233,
    f_prevaddrageoldest_d = NULL                  => 0.0117254525,
                   0.0117254525);

final_score_15 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_15_c231,
    f_adl_per_email_i > 0.5              => -0.0789816479,
    f_adl_per_email_i = NULL             => -0.1066335085,
          -0.0262325690);

final_score_16_c237 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 0.5 => -0.0311453696,
    r_c20_email_count_i > 0.5                => 0.0333689746,
    r_c20_email_count_i = NULL               => 0.0175213744,
              0.0175213744);

final_score_16_c236 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_16_c237,
    r_c20_email_verification_d > 0.5      => -0.0449253062,
    r_c20_email_verification_d = NULL                      => -0.1058562480,
                            -0.0307648413);

final_score_16_c239 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 11.5 => 0.0239745212,
    f_corraddrnamecount_d > 11.5                  => 0.0933138227,
    f_corraddrnamecount_d = NULL                  => 0.0360266050,
                   0.0360266050);

final_score_16_c238 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 2.5 => final_score_16_c239,
    r_i60_inq_comm_count12_i > 2.5                     => 0.1784370686,
    r_i60_inq_comm_count12_i = NULL                    => 0.0414797303,
                        0.0414797303);

final_score_16 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => final_score_16_c236,
    f_srchvelocityrisktype_i > 5.5                     => final_score_16_c238,
    f_srchvelocityrisktype_i = NULL                    => -0.0704468118,
                        -0.0160665390);

final_score_17_c242 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 4.5 => 0.0088914104,
    k_inq_ssns_per_addr_i > 4.5                  => 0.1395711158,
    k_inq_ssns_per_addr_i = NULL                 => 0.0140668443,
                  0.0140668443);

final_score_17_c241 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 11.5 => final_score_17_c242,
    f_corraddrnamecount_d > 11.5                  => 0.0634585318,
    f_corraddrnamecount_d = NULL                  => 0.0236026250,
                   0.0236026250);

final_score_17_c244 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 11.5 => -0.0104970374,
    f_corraddrnamecount_d > 11.5                  => 0.0593833674,
    f_corraddrnamecount_d = NULL                  => 0.0083380417,
                   0.0083380417);

final_score_17_c243 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_17_c244,
    r_c20_email_verification_d > 0.5      => -0.0728522945,
    r_c20_email_verification_d = NULL                      => -0.1047706300,
                            -0.0525609514);

final_score_17 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_17_c241,
    f_corrphonelastnamecount_d > 0.5      => final_score_17_c243,
    f_corrphonelastnamecount_d = NULL                      => -0.0413346499,
                            -0.0228718304);

final_score_18_c248 := map(
    NULL < f_srchssnsrchcountmo_i AND f_srchssnsrchcountmo_i <= 2.5 => 0.0541845509,
    f_srchssnsrchcountmo_i > 2.5                   => -0.0865893453,
    f_srchssnsrchcountmo_i = NULL                  => 0.0355376447,
                    0.0355376447);

final_score_18_c247 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 3.5 => -0.0300631640,
    r_d30_derog_count_i > 3.5                => final_score_18_c248,
    r_d30_derog_count_i = NULL               => -0.0173213615,
              -0.0173213615);

final_score_18_c249 := map(
    NULL < f_addrs_per_ssn_c6_i AND f_addrs_per_ssn_c6_i <= 0.5 => 0.0271341556,
    f_addrs_per_ssn_c6_i > 0.5                 => 0.0873488955,
    f_addrs_per_ssn_c6_i = NULL                => 0.0316700275,
                0.0316700275);

final_score_18_c246 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 112.5 => final_score_18_c247,
    f_prevaddrageoldest_d > 112.5                  => final_score_18_c249,
    f_prevaddrageoldest_d = NULL                   => 0.0096742744,
                    0.0096742744);

final_score_18 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_18_c246,
    f_adl_per_email_i > 0.5              => -0.0721786352,
    f_adl_per_email_i = NULL             => -0.1050616255,
          -0.0245892756);

final_score_19_c252 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 3.5 => -0.0310725731,
    k_inq_adls_per_addr_i > 3.5                  => 0.0992530136,
    k_inq_adls_per_addr_i = NULL                 => -0.0239570956,
                  -0.0239570956);

final_score_19_c253 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 549 => 0.0694786156,
    r_i60_inq_mortgage_recency_d > 549        => 0.0166332560,
    r_i60_inq_mortgage_recency_d = NULL       => 0.0280177153,
               0.0280177153);

final_score_19_c251 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 249.5 => final_score_19_c252,
    f_m_bureau_adl_fs_notu_d > 249.5                     => final_score_19_c253,
    f_m_bureau_adl_fs_notu_d = NULL                      => 0.0097065390,
                          0.0097065390);

final_score_19_c254 := map(
    NULL < r_i60_inq_hiriskcred_count12_i AND r_i60_inq_hiriskcred_count12_i <= 1.5 => -0.0816458629,
    r_i60_inq_hiriskcred_count12_i > 1.5          => 0.2688416440,
    r_i60_inq_hiriskcred_count12_i = NULL         => -0.0772536023,
                   -0.0772536023);

final_score_19 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_19_c251,
    f_adl_per_email_i > 0.5              => final_score_19_c254,
    f_adl_per_email_i = NULL             => -0.0996871519,
          -0.0259036331);

final_score_20_c257 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d <= 137.5 => -0.1185999868,
    f_mos_liens_unrel_sc_fseen_d > 137.5        => 0.0708032019,
    f_mos_liens_unrel_sc_fseen_d = NULL         => 0.0507980951,
                 0.0507980951);

final_score_20_c256 := map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d <= 263.5 => final_score_20_c257,
    f_mos_liens_unrel_cj_fseen_d > 263.5        => -0.0364440751,
    f_mos_liens_unrel_cj_fseen_d = NULL         => -0.0300274414,
                 -0.0300274414);

final_score_20_c259 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 18 => 0.1192723772,
    r_i60_inq_comm_recency_d > 18                     => -0.0220432717,
    r_i60_inq_comm_recency_d = NULL                   => -0.0134283916,
                       -0.0134283916);

final_score_20_c258 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.0365735836,
    r_phn_cell_n > 0.5         => final_score_20_c259,
    r_phn_cell_n = NULL        => 0.0192338761,
                 0.0192338761);

final_score_20 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => final_score_20_c256,
    f_idverrisktype_i > 1.5              => final_score_20_c258,
    f_idverrisktype_i = NULL             => -0.0275040833,
          -0.0107647520);

final_score_21_c261 := map(
    NULL < f_liens_unrel_st_total_amt_i AND f_liens_unrel_st_total_amt_i <= 1301 => -0.0296920373,
    f_liens_unrel_st_total_amt_i > 1301        => 0.1086284289,
    f_liens_unrel_st_total_amt_i = NULL        => -0.0275894272,
                -0.0275894272);

final_score_21_c264 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 14.5 => 0.0318000222,
    f_corraddrnamecount_d > 14.5                  => 0.0914046183,
    f_corraddrnamecount_d = NULL                  => 0.0362075493,
                   0.0362075493);

final_score_21_c263 := map(
    NULL < (Integer)f_nae_lname_verd_d AND (Real)f_nae_lname_verd_d <= 0.5 => final_score_21_c264,
    (Real)f_nae_lname_verd_d > 0.5               => -0.0602663324,
    (Integer)f_nae_lname_verd_d = NULL              => 0.0216331729,
            0.0216331729);

final_score_21_c262 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_21_c263,
    r_phn_cell_n > 0.5         => -0.0166504381,
    r_phn_cell_n = NULL        => 0.0085735337,
                 0.0085735337);

final_score_21 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => final_score_21_c261,
    f_idverrisktype_i > 1.5              => final_score_21_c262,
    f_idverrisktype_i = NULL             => -0.0796171663,
          -0.0136397931);

final_score_22_c268 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 3.5 => -0.0197666945,
    f_inq_communications_count24_i > 3.5          => 0.1248857604,
    f_inq_communications_count24_i = NULL         => -0.0166145457,
                   -0.0166145457);

final_score_22_c267 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 2.5 => final_score_22_c268,
    r_d32_criminal_count_i > 2.5                   => 0.0517745080,
    r_d32_criminal_count_i = NULL                  => -0.0085280022,
                    -0.0085280022);

final_score_22_c269 := map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i <= 3.5 => 0.0277318113,
    f_inq_auto_count24_i > 3.5                 => 0.1576433110,
    f_inq_auto_count24_i = NULL                => 0.0311018660,
                0.0311018660);

final_score_22_c266 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 9.5 => final_score_22_c267,
    f_corraddrnamecount_d > 9.5                  => final_score_22_c269,
    f_corraddrnamecount_d = NULL                 => 0.0073349855,
                  0.0073349855);

final_score_22 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_22_c266,
    f_adl_per_email_i > 0.5              => -0.0648001612,
    f_adl_per_email_i = NULL             => -0.1041156898,
          -0.0231882733);

final_score_23_c271 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => -0.0297679075,
    f_srchcomponentrisktype_i > 1.5                      => 0.0583671241,
    f_srchcomponentrisktype_i = NULL                     => -0.0234984254,
                          -0.0234984254);

final_score_23_c274 := map(
    NULL < r_d31_bk_disposed_recent_count_i AND r_d31_bk_disposed_recent_count_i <= 0.5 => 0.0187851169,
    r_d31_bk_disposed_recent_count_i > 0.5            => 0.1766942953,
    r_d31_bk_disposed_recent_count_i = NULL           => 0.0212354317,
                       0.0212354317);

final_score_23_c273 := map(
    NULL < f_srchssnsrchcountmo_i AND f_srchssnsrchcountmo_i <= 3.5 => final_score_23_c274,
    f_srchssnsrchcountmo_i > 3.5                   => -0.0822833835,
    f_srchssnsrchcountmo_i = NULL                  => 0.0174286900,
                    0.0174286900);

final_score_23_c272 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 4.5 => 0.1246480488,
    r_i61_inq_collection_recency_d > 4.5          => final_score_23_c273,
    r_i61_inq_collection_recency_d = NULL         => 0.0213734607,
                   0.0213734607);

final_score_23 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => final_score_23_c271,
    r_d30_derog_count_i > 0.5                => final_score_23_c272,
    r_d30_derog_count_i = NULL               => -0.0203112573,
              -0.0086005692);

final_score_24_c278 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 18.5 => 0.0305181053,
    k_inq_per_phone_i > 18.5              => 0.1625915141,
    k_inq_per_phone_i = NULL              => 0.0335607521,
           0.0335607521);

final_score_24_c277 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 134.5 => -0.0021658736,
    f_prevaddrageoldest_d > 134.5                  => final_score_24_c278,
    f_prevaddrageoldest_d = NULL                   => 0.0141651068,
                    0.0141651068);

final_score_24_c276 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 7.5 => final_score_24_c277,
    r_l79_adls_per_addr_c6_i > 7.5                     => 0.2124203181,
    r_l79_adls_per_addr_c6_i = NULL                    => 0.0163391251,
                        0.0163391251);

final_score_24_c279 := map(
    NULL < f_mos_liens_rel_cj_fseen_d AND f_mos_liens_rel_cj_fseen_d <= 265.5 => 0.0726523690,
    f_mos_liens_rel_cj_fseen_d > 265.5      => -0.0315399075,
    f_mos_liens_rel_cj_fseen_d = NULL       => -0.0282169974,
             -0.0282169974);

final_score_24 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_24_c276,
    f_corrphonelastnamecount_d > 0.5      => final_score_24_c279,
    f_corrphonelastnamecount_d = NULL                      => -0.0768900210,
                            -0.0108836974);

final_score_25_c283 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 11.5 => 0.0270280520,
    r_i60_inq_count12_i > 11.5                => -0.0339368617,
    r_i60_inq_count12_i = NULL                => 0.0203741580,
               0.0203741580);

final_score_25_c282 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 3.5 => final_score_25_c283,
    k_inq_adls_per_addr_i > 3.5                  => 0.1026137398,
    k_inq_adls_per_addr_i = NULL                 => 0.0236250597,
                  0.0236250597);

final_score_25_c281 := map(
    NULL < f_inq_email_ver_count_i AND f_inq_email_ver_count_i <= 132.5 => -0.0218600735,
    f_inq_email_ver_count_i > 132.5                    => final_score_25_c282,
    f_inq_email_ver_count_i = NULL                     => 0.0135881843,
                        0.0135881843);

final_score_25_c284 := map(
    NULL < r_i60_inq_hiriskcred_count12_i AND r_i60_inq_hiriskcred_count12_i <= 0.5 => -0.0368751654,
    r_i60_inq_hiriskcred_count12_i > 0.5          => 0.0979969013,
    r_i60_inq_hiriskcred_count12_i = NULL         => -0.0330782333,
                   -0.0330782333);

final_score_25 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => final_score_25_c281,
    r_c20_email_verification_d > 1.5      => final_score_25_c284,
    r_c20_email_verification_d = NULL                      => -0.1035425177,
                            -0.0177279318);

final_score_26_c288 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i <= 7.5 => 0.0355099432,
    r_d34_unrel_liens_ct_i > 7.5                   => -0.0721673317,
    r_d34_unrel_liens_ct_i = NULL                  => 0.0330675075,
                    0.0330675075);

final_score_26_c287 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 2.5 => -0.0072464508,
    f_phones_per_addr_curr_i > 2.5                     => final_score_26_c288,
    f_phones_per_addr_curr_i = NULL                    => 0.0197700953,
                        0.0197700953);

final_score_26_c286 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 119.5 => -0.0228615044,
    r_c13_max_lres_d > 119.5             => final_score_26_c287,
    r_c13_max_lres_d = NULL              => -0.0077497516,
          0.0076269369);

final_score_26_c289 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 5.5 => -0.0780223075,
    f_srchfraudsrchcountyr_i > 5.5                     => 0.2150400404,
    f_srchfraudsrchcountyr_i = NULL                    => -0.0727332936,
                        -0.0727332936);

final_score_26 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => final_score_26_c286,
    (Real)f_nae_email_verd_d > 0.5               => final_score_26_c289,
    (Integer)f_nae_email_verd_d = NULL              => -0.0204714292,
            -0.0204714292);

final_score_27_c292 := map(
    NULL < f_srchfraudsrchcountwk_i AND f_srchfraudsrchcountwk_i <= 0.5 => 0.0117669991,
    f_srchfraudsrchcountwk_i > 0.5                     => 0.1247530530,
    f_srchfraudsrchcountwk_i = NULL                    => 0.0146958198,
                        0.0146958198);

final_score_27_c291 := map(
    NULL < (Integer)f_nae_contradictory_i AND (Real)f_nae_contradictory_i <= 0.5 => final_score_27_c292,
    (Real)f_nae_contradictory_i > 0.5                  => 0.2831994350,
    (Integer)f_nae_contradictory_i = NULL                 => 0.0184279708,
                  0.0184279708);

final_score_27_c294 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 5231.5 => 0.0250796545,
    f_liens_rel_cj_total_amt_i > 5231.5      => -0.1375572286,
    f_liens_rel_cj_total_amt_i = NULL        => 0.0202986412,
              0.0202986412);

final_score_27_c293 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => -0.0340198174,
    f_srchvelocityrisktype_i > 5.5                     => final_score_27_c294,
    f_srchvelocityrisktype_i = NULL                    => -0.0225491635,
                        -0.0225491635);

final_score_27 := map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_27_c291,
    (Real)k_nap_phn_verd_d > 0.5             => final_score_27_c293,
    (Integer)k_nap_phn_verd_d = NULL            => -0.0107060791,
                         -0.0107060791);

final_score_28_c298 := map(
    NULL < f_componentcharrisktype_i AND f_componentcharrisktype_i <= 2.5 => 0.0462562779,
    f_componentcharrisktype_i > 2.5                      => 0.0117352394,
    f_componentcharrisktype_i = NULL                     => 0.0252407508,
                          0.0252407508);

final_score_28_c297 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i <= 996.5 => final_score_28_c298,
    f_liens_unrel_ot_total_amt_i > 996.5        => -0.0727848592,
    f_liens_unrel_ot_total_amt_i = NULL         => 0.0207634565,
                 0.0207634565);

final_score_28_c296 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_28_c297,
    f_phone_ver_experian_d > 0.5                   => -0.0097057754,
    f_phone_ver_experian_d = NULL                  => 0.0678694852,
                    0.0125816301);

final_score_28_c299 := map(
    NULL < r_d31_bk_filing_count_i AND r_d31_bk_filing_count_i <= 2.5 => -0.0218896130,
    r_d31_bk_filing_count_i > 2.5                    => 0.1506012639,
    r_d31_bk_filing_count_i = NULL                   => -0.0206838348,
                      -0.0206838348);

final_score_28 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_28_c296,
    f_corrphonelastnamecount_d > 0.5      => final_score_28_c299,
    f_corrphonelastnamecount_d = NULL                      => -0.0605895590,
                            -0.0080170180);

final_score_29_c304 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 17.5 => 0.0227349306,
    k_inq_per_addr_i > 17.5             => -0.0706964824,
    k_inq_per_addr_i = NULL             => 0.0182634020,
         0.0182634020);

final_score_29_c303 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 4.5 => final_score_29_c304,
    k_inq_ssns_per_addr_i > 4.5                  => 0.1124373372,
    k_inq_ssns_per_addr_i = NULL                 => 0.0209305659,
                  0.0209305659);

final_score_29_c302 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 3.5 => 0.1749587170,
    f_mos_acc_lseen_d > 3.5              => final_score_29_c303,
    f_mos_acc_lseen_d = NULL             => 0.0237320388,
          0.0237320388);

final_score_29_c301 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 1.5 => -0.0142641535,
    f_assocsuspicousidcount_i > 1.5                      => final_score_29_c302,
    f_assocsuspicousidcount_i = NULL                     => -0.0053458366,
                          -0.0053458366);

final_score_29 := map(
    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 0.5 => final_score_29_c301,
    r_i61_inq_collection_count12_i > 0.5          => 0.0539773612,
    r_i61_inq_collection_count12_i = NULL         => -0.0347367304,
                   -0.0023316598);

final_score_30_c308 := map(
    NULL < k_inq_lnames_per_ssn_i AND k_inq_lnames_per_ssn_i <= 1.5 => 0.0344300670,
    k_inq_lnames_per_ssn_i > 1.5                   => 0.1361379138,
    k_inq_lnames_per_ssn_i = NULL                  => 0.0381739141,
                    0.0381739141);

final_score_30_c309 := map(
    NULL < r_c20_email_domain_isp_count_i AND r_c20_email_domain_isp_count_i <= 1.5 => -0.0115977830,
    r_c20_email_domain_isp_count_i > 1.5          => 0.0551719950,
    r_c20_email_domain_isp_count_i = NULL         => 0.0036469981,
                   0.0036469981);

final_score_30_c307 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => final_score_30_c308,
    r_i61_inq_collection_recency_d > 549          => final_score_30_c309,
    r_i61_inq_collection_recency_d = NULL         => 0.0207438681,
                   0.0207438681);

final_score_30_c306 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 74.5 => -0.0170800187,
    f_prevaddrlenofres_d > 74.5                 => final_score_30_c307,
    f_prevaddrlenofres_d = NULL                 => 0.0085356742,
                 0.0085356742);

final_score_30 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 3.5 => final_score_30_c306,
    r_c20_email_verification_d > 3.5      => -0.0596266879,
    r_c20_email_verification_d = NULL                      => -0.1032335436,
                            -0.0186498032);

final_score_31_c313 := map(
    NULL < r_d31_bk_disposed_recent_count_i AND r_d31_bk_disposed_recent_count_i <= 0.5 => -0.0096325450,
    r_d31_bk_disposed_recent_count_i > 0.5            => 0.1072940729,
    r_d31_bk_disposed_recent_count_i = NULL           => -0.0088816402,
                       -0.0088816402);

final_score_31_c312 := map(
    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 0.5 => final_score_31_c313,
    r_i61_inq_collection_count12_i > 0.5          => 0.0429224117,
    r_i61_inq_collection_count12_i = NULL         => -0.0059239694,
                   -0.0059239694);

final_score_31_c314 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => 0.1104369670,
    f_adl_per_email_i > 0.5              => -0.0497475481,
    f_adl_per_email_i = NULL             => 0.0648413747,
          0.0648413747);

final_score_31_c311 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 87.65 => final_score_31_c312,
    r_c12_source_profile_d > 87.65                   => final_score_31_c314,
    r_c12_source_profile_d = NULL                    => -0.0616577449,
                      -0.0046252151);

final_score_31 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 5.5 => final_score_31_c311,
    k_inq_ssns_per_addr_i > 5.5                  => 0.1113021545,
    k_inq_ssns_per_addr_i = NULL                 => -0.0034829004,
                  -0.0034829004);

final_score_32_c318 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.0048515879,
    r_phn_cell_n > 0.5         => -0.0326321555,
    r_phn_cell_n = NULL        => -0.0074704582,
                 -0.0074704582);

final_score_32_c317 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 87.85 => final_score_32_c318,
    r_c12_source_profile_d > 87.85                   => 0.0850683985,
    r_c12_source_profile_d = NULL                    => -0.0166647049,
                      -0.0057260310);

final_score_32_c316 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 3.5 => final_score_32_c317,
    k_inq_addrs_per_ssn_i > 3.5                  => 0.1238707649,
    k_inq_addrs_per_ssn_i = NULL                 => -0.0049297687,
                  -0.0049297687);

final_score_32_c319 := map(
    NULL < r_c20_email_domain_free_count_i AND r_c20_email_domain_free_count_i <= 5.5 => 0.0770849178,
    r_c20_email_domain_free_count_i > 5.5           => -0.1048895070,
    r_c20_email_domain_free_count_i = NULL          => 0.0546597867,
                     0.0546597867);

final_score_32 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 3.5 => final_score_32_c316,
    k_inq_ssns_per_addr_i > 3.5                  => final_score_32_c319,
    k_inq_ssns_per_addr_i = NULL                 => -0.0026847710,
                  -0.0026847710);

final_score_33_c324 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 2.5 => -0.0297066681,
    f_srchcomponentrisktype_i > 2.5                      => 0.0926758395,
    f_srchcomponentrisktype_i = NULL                     => -0.0254432173,
                          -0.0254432173);

final_score_33_c323 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => 0.0128140072,
    r_c20_email_verification_d > 0.5      => final_score_33_c324,
    r_c20_email_verification_d = NULL                      => -0.1028092287,
                            -0.0160381568);

final_score_33_c322 := map(
    NULL < f_inq_retailpayments_cnt_week_i AND f_inq_retailpayments_cnt_week_i <= 1.5 => final_score_33_c323,
    f_inq_retailpayments_cnt_week_i > 1.5           => -0.0596427221,
    f_inq_retailpayments_cnt_week_i = NULL          => -0.0169238215,
                     -0.0169238215);

final_score_33_c321 := map(
    NULL < k_inq_addrs_per_ssn_i AND k_inq_addrs_per_ssn_i <= 3.5 => final_score_33_c322,
    k_inq_addrs_per_ssn_i > 3.5                  => 0.1118038282,
    k_inq_addrs_per_ssn_i = NULL                 => -0.0161471541,
                  -0.0161471541);

final_score_33 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 4.5 => 0.0816366165,
    r_i61_inq_collection_recency_d > 4.5          => final_score_33_c321,
    r_i61_inq_collection_recency_d = NULL         => -0.0608256365,
                   -0.0147877352);

final_score_34_c327 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 3.5 => -0.0106375486,
    f_inq_communications_count24_i > 3.5          => 0.0840378403,
    f_inq_communications_count24_i = NULL         => -0.0094580643,
                   -0.0094580643);

final_score_34_c326 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_34_c327,
    r_p85_phn_not_issued_i > 0.5                   => 0.0758176024,
    r_p85_phn_not_issued_i = NULL                  => -0.0083114889,
                    -0.0083114889);

final_score_34_c329 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 3.5 => 0.0409664505,
    f_srchunvrfdphonecount_i > 3.5                     => -0.1168741911,
    f_srchunvrfdphonecount_i = NULL                    => 0.0300322384,
                        0.0300322384);

final_score_34_c328 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 132.5 => 0.1866533197,
    f_m_bureau_adl_fs_all_d > 132.5                    => final_score_34_c329,
    f_m_bureau_adl_fs_all_d = NULL                     => 0.0457730506,
                        0.0457730506);

final_score_34 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 2.5 => final_score_34_c326,
    r_d32_criminal_count_i > 2.5                   => final_score_34_c328,
    r_d32_criminal_count_i = NULL                  => -0.0872591084,
                    -0.0046274463);

final_score_35_c332 := map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 549 => -0.0399526477,
    r_i60_inq_retail_recency_d > 549      => 0.0085480678,
    r_i60_inq_retail_recency_d = NULL                      => -0.0082874663,
                            -0.0082874663);

final_score_35_c333 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 2.5 => 0.0002858318,
    f_phones_per_addr_curr_i > 2.5                     => 0.0399641804,
    f_phones_per_addr_curr_i = NULL                    => 0.0273285158,
                        0.0273285158);

final_score_35_c331 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 127.5 => final_score_35_c332,
    r_c13_curr_addr_lres_d > 127.5                   => final_score_35_c333,
    r_c13_curr_addr_lres_d = NULL                    => 0.0084198151,
                      0.0084198151);

final_score_35_c334 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 8.5 => -0.0628083175,
    k_inq_per_phone_i > 8.5              => 0.2239434123,
    k_inq_per_phone_i = NULL             => -0.0591024159,
          -0.0591024159);

final_score_35 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_35_c331,
    f_adl_per_email_i > 0.5              => final_score_35_c334,
    f_adl_per_email_i = NULL             => -0.1026139751,
          -0.0205849900);

final_score_36_c337 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 4.5 => -0.0194102474,
    f_assocrisktype_i > 4.5              => 0.0750964628,
    f_assocrisktype_i = NULL             => -0.0163822274,
          -0.0163822274);

final_score_36_c339 := map(
    NULL < f_mos_liens_rel_cj_fseen_d AND f_mos_liens_rel_cj_fseen_d <= 306 => 0.1264172157,
    f_mos_liens_rel_cj_fseen_d > 306      => 0.0359212150,
    f_mos_liens_rel_cj_fseen_d = NULL                      => 0.0424258124,
                            0.0424258124);

final_score_36_c338 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 237.5 => 0.0003389953,
    r_c13_max_lres_d > 237.5             => final_score_36_c339,
    r_c13_max_lres_d = NULL              => 0.0125549988,
          0.0125549988);

final_score_36_c336 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => final_score_36_c337,
    f_inq_other_count24_i > 0.5                  => final_score_36_c338,
    f_inq_other_count24_i = NULL                 => -0.0054624777,
                  -0.0054624777);

final_score_36 := map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 34.5 => -0.1343870708,
    f_mos_liens_rel_cj_lseen_d > 34.5      => final_score_36_c336,
    f_mos_liens_rel_cj_lseen_d = NULL      => -0.0164281994,
            -0.0060009582);

final_score_37_c341 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 2.5 => -0.0268483636,
    f_bus_addr_match_count_d > 2.5                     => 0.0260137619,
    f_bus_addr_match_count_d = NULL                    => -0.0162640535,
                        -0.0162640535);

final_score_37_c344 := map(
    NULL < (Integer)f_nae_contradictory_i AND (Real)f_nae_contradictory_i <= 0.5 => 0.0249858868,
    (Real)f_nae_contradictory_i > 0.5                  => 0.1984752956,
    (Integer)f_nae_contradictory_i = NULL                 => 0.0276268263,
                  0.0276268263);

final_score_37_c343 := map(
    NULL < r_d32_felony_count_i AND r_d32_felony_count_i <= 0.5 => final_score_37_c344,
    r_d32_felony_count_i > 0.5                 => 0.1365870354,
    r_d32_felony_count_i = NULL                => 0.0297534894,
                0.0297534894);

final_score_37_c342 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => final_score_37_c343,
    f_phone_ver_insurance_d > 3.5                    => -0.0033363279,
    f_phone_ver_insurance_d = NULL                   => 0.0192243225,
                      0.0192243225);

final_score_37 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => final_score_37_c341,
    f_idverrisktype_i > 1.5              => final_score_37_c342,
    f_idverrisktype_i = NULL             => 0.0155186361,
          -0.0023345300);

final_score_38_c349 := map(
    NULL < k_inq_lnames_per_ssn_i AND k_inq_lnames_per_ssn_i <= 1.5 => -0.0455113092,
    k_inq_lnames_per_ssn_i > 1.5                   => 0.1120194854,
    k_inq_lnames_per_ssn_i = NULL                  => -0.0334307268,
                    -0.0334307268);

final_score_38_c348 := map(
    NULL < r_i60_inq_retpymt_count12_i AND r_i60_inq_retpymt_count12_i <= 2.5 => 0.0079693760,
    r_i60_inq_retpymt_count12_i > 2.5       => final_score_38_c349,
    r_i60_inq_retpymt_count12_i = NULL      => 0.0048802403,
             0.0048802403);

final_score_38_c347 := map(
    NULL < f_accident_recency_d AND f_accident_recency_d <= 9 => 0.0988210588,
    f_accident_recency_d > 9                 => final_score_38_c348,
    f_accident_recency_d = NULL              => 0.0067040268,
              0.0067040268);

final_score_38_c346 := map(
    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i <= 2.5 => final_score_38_c347,
    f_divssnidmsrcurelcount_i > 2.5                      => 0.1123125590,
    f_divssnidmsrcurelcount_i = NULL                     => 0.0087152858,
                          0.0087152858);

final_score_38 := map(
    NULL < f_inq_email_ver_count_i AND f_inq_email_ver_count_i <= 139.5 => -0.0294408465,
    f_inq_email_ver_count_i > 139.5                    => final_score_38_c346,
    f_inq_email_ver_count_i = NULL                     => 0.0061372468,
                        -0.0030094501);

final_score_39_c353 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 5.5 => 0.1043159734,
    f_util_adl_count_n > 5.5               => -0.0620277209,
    f_util_adl_count_n = NULL              => 0.0539297092,
            0.0539297092);

final_score_39_c352 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 9 => 0.1853101369,
    r_i60_inq_hiriskcred_recency_d > 9          => final_score_39_c353,
    r_i60_inq_hiriskcred_recency_d = NULL       => 0.0783416130,
                 0.0783416130);

final_score_39_c351 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 3.5 => final_score_39_c352,
    r_c18_invalid_addrs_per_adl_i > 3.5         => -0.0373577356,
    r_c18_invalid_addrs_per_adl_i = NULL        => 0.0476224311,
                 0.0476224311);

final_score_39_c354 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => 0.0673997875,
    r_f01_inp_addr_address_score_d > 85          => -0.0068340358,
    r_f01_inp_addr_address_score_d = NULL        => -0.0051358955,
                  -0.0051358955);

final_score_39 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 9 => final_score_39_c351,
    r_i61_inq_collection_recency_d > 9          => final_score_39_c354,
    r_i61_inq_collection_recency_d = NULL       => 0.0154027794,
                 -0.0034215653);

final_score_40_c357 := map(
    NULL < f_liens_unrel_o_total_amt_i AND f_liens_unrel_o_total_amt_i <= 1229 => -0.0144430536,
    f_liens_unrel_o_total_amt_i > 1229       => 0.0594799612,
    f_liens_unrel_o_total_amt_i = NULL       => -0.0129368906,
              -0.0129368906);

final_score_40_c359 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 10.5 => 0.0085271594,
    f_corraddrnamecount_d > 10.5                  => 0.0626795183,
    f_corraddrnamecount_d = NULL                  => 0.0359486465,
                   0.0359486465);

final_score_40_c358 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => final_score_40_c359,
    (Real)f_nae_email_verd_d > 0.5               => -0.0826236916,
    (Integer)f_nae_email_verd_d = NULL              => -0.0064149516,
            -0.0064149516);

final_score_40_c356 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 1.5 => final_score_40_c357,
    r_e57_br_source_count_d > 1.5                    => final_score_40_c358,
    r_e57_br_source_count_d = NULL                   => -0.0119018048,
                      -0.0119018048);

final_score_40 := map(
    NULL < f_mos_liens_unrel_ot_fseen_d AND f_mos_liens_unrel_ot_fseen_d <= 32.5 => 0.1233747155,
    f_mos_liens_unrel_ot_fseen_d > 32.5        => final_score_40_c356,
    f_mos_liens_unrel_ot_fseen_d = NULL        => -0.0788616102,
                -0.0115245122);

final_score_41_c363 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 4.5 => -0.0113118499,
    f_inq_highriskcredit_count24_i > 4.5          => -0.0822851101,
    f_inq_highriskcredit_count24_i = NULL         => -0.0125868187,
                   -0.0125868187);

final_score_41_c362 := map(
    NULL < k_inq_lnames_per_ssn_i AND k_inq_lnames_per_ssn_i <= 1.5 => final_score_41_c363,
    k_inq_lnames_per_ssn_i > 1.5                   => 0.0578406378,
    k_inq_lnames_per_ssn_i = NULL                  => -0.0107829508,
                    -0.0107829508);

final_score_41_c361 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 9.5 => final_score_41_c362,
    r_l79_adls_per_addr_c6_i > 9.5                     => 0.1405849549,
    r_l79_adls_per_addr_c6_i = NULL                    => -0.0099937232,
                        -0.0099937232);

final_score_41_c364 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => 0.0343087748,
    f_adl_per_email_i > 0.5              => -0.0660659892,
    f_adl_per_email_i = NULL             => -0.1021048068,
          -0.0083999146);

final_score_41 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 11.5 => final_score_41_c361,
    f_corraddrnamecount_d > 11.5                  => final_score_41_c364,
    f_corraddrnamecount_d = NULL                  => -0.0275499546,
                   -0.0097326710);

final_score_42_c368 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 5.5 => -0.0296951623,
    r_c20_email_count_i > 5.5                => 0.0702988205,
    r_c20_email_count_i = NULL               => -0.0160667396,
              -0.0160667396);

final_score_42_c367 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.0212859125,
    r_phn_cell_n > 0.5         => final_score_42_c368,
    r_phn_cell_n = NULL        => 0.0069741220,
                 0.0069741220);

final_score_42_c369 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 95 => 0.1044438946,
    r_f00_dob_score_d > 95              => -0.0208095860,
    r_f00_dob_score_d = NULL            => -0.0349061549,
         -0.0187775225);

final_score_42_c366 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_42_c367,
    f_corrphonelastnamecount_d > 0.5      => final_score_42_c369,
    f_corrphonelastnamecount_d = NULL                      => 0.0298916415,
                            -0.0087272902);

final_score_42 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 5.5 => final_score_42_c366,
    k_inq_ssns_per_addr_i > 5.5                  => 0.0856034793,
    k_inq_ssns_per_addr_i = NULL                 => -0.0077977821,
                  -0.0077977821);

final_score_43_c372 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 15.5 => -0.0126867012,
    k_inq_per_phone_i > 15.5              => 0.1070111317,
    k_inq_per_phone_i = NULL              => -0.0119406536,
           -0.0119406536);

final_score_43_c374 := map(
    NULL < f_corrssnaddrcount_d AND f_corrssnaddrcount_d <= 2.5 => 0.0971971246,
    f_corrssnaddrcount_d > 2.5                 => 0.0145090100,
    f_corrssnaddrcount_d = NULL                => 0.0199046022,
                0.0199046022);

final_score_43_c373 := map(
    NULL < f_mos_liens_unrel_ot_lseen_d AND f_mos_liens_unrel_ot_lseen_d <= 66.5 => -0.0614000056,
    f_mos_liens_unrel_ot_lseen_d > 66.5        => final_score_43_c374,
    f_mos_liens_unrel_ot_lseen_d = NULL        => 0.0156449639,
                0.0156449639);

final_score_43_c371 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 4.5 => final_score_43_c372,
    f_srchvelocityrisktype_i > 4.5                     => final_score_43_c373,
    f_srchvelocityrisktype_i = NULL                    => -0.0050152440,
                        -0.0050152440);

final_score_43 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 7.5 => final_score_43_c371,
    f_inq_communications_count24_i > 7.5          => 0.1323762436,
    f_inq_communications_count24_i = NULL         => 0.0094369443,
                   -0.0044129277);

final_score_44_c379 := map(
    NULL < f_vardobcountnew_i AND f_vardobcountnew_i <= 0.5 => 0.0708492094,
    f_vardobcountnew_i > 0.5               => -0.0498267852,
    f_vardobcountnew_i = NULL              => 0.0417056329,
            0.0417056329);

final_score_44_c378 := map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d <= 263.5 => final_score_44_c379,
    f_mos_liens_unrel_cj_fseen_d > 263.5        => -0.0284846628,
    f_mos_liens_unrel_cj_fseen_d = NULL         => -0.0230794589,
                 -0.0230794589);

final_score_44_c377 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 8.5 => final_score_44_c378,
    r_d32_criminal_count_i > 8.5                   => -0.0971041803,
    r_d32_criminal_count_i = NULL                  => -0.0242338992,
                    -0.0242338992);

final_score_44_c376 := map(
    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i <= 2.5 => final_score_44_c377,
    f_divssnidmsrcurelcount_i > 2.5                      => 0.1076053186,
    f_divssnidmsrcurelcount_i = NULL                     => -0.0217947070,
                          -0.0217947070);

final_score_44 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => 0.0130233651,
    f_phone_ver_insurance_d > 3.5                    => final_score_44_c376,
    f_phone_ver_insurance_d = NULL                   => -0.0398434189,
                      -0.0071169961);

final_score_45_c381 := map(
    NULL < k_inq_lnames_per_addr_i AND k_inq_lnames_per_addr_i <= 3.5 => -0.0406760271,
    k_inq_lnames_per_addr_i > 3.5                    => 0.1055579683,
    k_inq_lnames_per_addr_i = NULL                   => -0.0367163764,
                      -0.0367163764);

final_score_45_c384 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 13.5 => 0.0149483275,
    k_inq_per_ssn_i > 13.5            => -0.0347336067,
    k_inq_per_ssn_i = NULL            => 0.0110203819,
                        0.0110203819);

final_score_45_c383 := map(
    NULL < f_bus_phone_match_d AND f_bus_phone_match_d <= 0.5 => final_score_45_c384,
    f_bus_phone_match_d > 0.5                => 0.0760761348,
    f_bus_phone_match_d = NULL               => 0.0160290389,
              0.0160290389);

final_score_45_c382 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_45_c383,
    f_adl_per_email_i > 0.5              => -0.0521797380,
    f_adl_per_email_i = NULL             => -0.0902435121,
          -0.0147412849);

final_score_45 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 204.5 => final_score_45_c381,
    f_m_bureau_adl_fs_all_d > 204.5                    => final_score_45_c382,
    f_m_bureau_adl_fs_all_d = NULL                     => 0.0393827260,
                        -0.0198715261);

final_score_46_c389 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 3575.5 => 0.0122723154,
    f_liens_rel_cj_total_amt_i > 3575.5      => -0.0992556348,
    f_liens_rel_cj_total_amt_i = NULL        => 0.0099547287,
              0.0099547287);

final_score_46_c388 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 0.5 => -0.0146148891,
    f_inq_other_count24_i > 0.5                  => final_score_46_c389,
    f_inq_other_count24_i = NULL                 => -0.0056208413,
                  -0.0056208413);

final_score_46_c387 := map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 48.5 => -0.1025391427,
    f_mos_liens_rel_cj_lseen_d > 48.5      => final_score_46_c388,
    f_mos_liens_rel_cj_lseen_d = NULL      => -0.0059955352,
            -0.0059955352);

final_score_46_c386 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 17.5 => 0.0969159732,
    f_mos_liens_unrel_cj_lseen_d > 17.5        => final_score_46_c387,
    f_mos_liens_unrel_cj_lseen_d = NULL        => -0.0053628662,
                -0.0053628662);

final_score_46 := map(
    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 2.5 => final_score_46_c386,
    r_i61_inq_collection_count12_i > 2.5          => 0.0864536808,
    r_i61_inq_collection_count12_i = NULL         => -0.0350841867,
                   -0.0048010806);

final_score_47_c394 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 16.5 => -0.0034830328,
    k_inq_per_phone_i > 16.5              => 0.0960252432,
    k_inq_per_phone_i = NULL              => -0.0024022663,
           -0.0024022663);

final_score_47_c393 := map(
    NULL < r_i60_inq_retpymt_count12_i AND r_i60_inq_retpymt_count12_i <= 8.5 => final_score_47_c394,
    r_i60_inq_retpymt_count12_i > 8.5       => -0.0851557360,
    r_i60_inq_retpymt_count12_i = NULL      => -0.0033473634,
             -0.0033473634);

final_score_47_c392 := map(
    NULL < f_mos_liens_rel_ot_lseen_d AND f_mos_liens_rel_ot_lseen_d <= 31.5 => 0.0963494906,
    f_mos_liens_rel_ot_lseen_d > 31.5      => final_score_47_c393,
    f_mos_liens_rel_ot_lseen_d = NULL      => -0.0028726529,
            -0.0028726529);

final_score_47_c391 := map(
    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 3.5 => final_score_47_c392,
    r_i61_inq_collection_count12_i > 3.5          => 0.1239468631,
    r_i61_inq_collection_count12_i = NULL         => -0.0022716585,
                   -0.0022716585);

final_score_47 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 46 => 0.1191689128,
    r_d32_mos_since_fel_ls_d > 46                     => final_score_47_c391,
    r_d32_mos_since_fel_ls_d = NULL                   => 0.0241044632,
                       -0.0016482232);

final_score_48_c399 := map(
    r_i60_inq_retpymt_count12_i = NULL      => 0.0247192667,
		  r_i60_inq_retpymt_count12_i > 3.5       => -0.1363518908,
    NULL < r_i60_inq_retpymt_count12_i AND r_i60_inq_retpymt_count12_i <= 3.5 => 0.0595740089,
    0.0247192667);

final_score_48_c398 := map(
    NULL < (Integer)k_inf_addr_verd_d AND (Real)k_inf_addr_verd_d <= 0.5 => final_score_48_c399,
    (Real)k_inf_addr_verd_d > 0.5              => 0.1529355337,
    (Integer)k_inf_addr_verd_d = NULL             => 0.0690409392,
          0.0690409392);

final_score_48_c397 := map(
    NULL < r_c20_email_domain_isp_count_i AND r_c20_email_domain_isp_count_i <= 2.5 => final_score_48_c398,
    r_c20_email_domain_isp_count_i > 2.5          => -0.0471621024,
    r_c20_email_domain_isp_count_i = NULL         => 0.0388524206,
                   0.0388524206);

final_score_48_c396 := map(
    r_d31_bk_chapter_n = ''             => -0.0018503575,
		  (Integer)r_d31_bk_chapter_n > 10               => -0.0246872451, 
		   NULL < (Integer)r_d31_bk_chapter_n AND (Integer)r_d31_bk_chapter_n <= 10 => final_score_48_c397,
           0.0001170903);

final_score_48 := map(
    f_liens_unrel_ot_total_amt_i = NULL        => -0.0581563160,
		  f_liens_unrel_ot_total_amt_i > 1462        => -0.0710384678,
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i <= 1462 => final_score_48_c396,
		  -0.0015860691);

final_score_49_c403 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 1.5 => 0.0230731604,
    f_divrisktype_i > 1.5            => 0.1423289754,
    f_divrisktype_i = NULL           => 0.0557073530,
                       0.0557073530);

final_score_49_c402 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => final_score_49_c403,
    r_f01_inp_addr_address_score_d > 85          => -0.0071908471,
    r_f01_inp_addr_address_score_d = NULL        => -0.0056625375,
                  -0.0056625375);

final_score_49_c404 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 272 => 0.1612473875,
    f_mos_liens_unrel_cj_lseen_d > 272        => 0.0305298244,
    f_mos_liens_unrel_cj_lseen_d = NULL       => 0.0424132393,
               0.0424132393);

final_score_49_c401 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => final_score_49_c402,
    r_p85_phn_disconnected_i > 0.5                     => final_score_49_c404,
    r_p85_phn_disconnected_i = NULL                    => -0.0035864008,
                        -0.0035864008);

final_score_49 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 15.5 => final_score_49_c401,
    f_corraddrnamecount_d > 15.5                  => 0.0589165337,
    f_corraddrnamecount_d = NULL                  => -0.0460915533,
                   -0.0020194141);

final_score_50_c408 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 56.5 => -0.0669401624,
    r_c13_max_lres_d > 56.5             => -0.0020383008,
    r_c13_max_lres_d = NULL             => -0.0075780065,
         -0.0075780065);

final_score_50_c407 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => 0.0597734039,
    r_f01_inp_addr_address_score_d > 85          => final_score_50_c408,
    r_f01_inp_addr_address_score_d = NULL        => -0.0059107882,
                  -0.0059107882);

final_score_50_c409 := map(
    NULL < f_bus_name_nover_i AND f_bus_name_nover_i <= 0.5 => -0.0042473420,
    f_bus_name_nover_i > 0.5               => 0.1179162183,
    f_bus_name_nover_i = NULL              => 0.0593532745,
            0.0593532745);

final_score_50_c406 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 16.5 => final_score_50_c407,
    k_inq_per_phone_i > 16.5              => final_score_50_c409,
    k_inq_per_phone_i = NULL              => -0.0049372221,
           -0.0049372221);

final_score_50 := map(
    NULL < f_srchfraudsrchcountmo_i AND f_srchfraudsrchcountmo_i <= 8.5 => final_score_50_c406,
    f_srchfraudsrchcountmo_i > 8.5                     => -0.0879114130,
    f_srchfraudsrchcountmo_i = NULL                    => 0.0068833310,
                        -0.0056633144);

final_score_51_c413 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 0.5 => 0.0433301196,
    r_p88_phn_dst_to_inp_add_i > 0.5      => -0.0140933287,
    r_p88_phn_dst_to_inp_add_i = NULL                      => 0.0183056487,
                            0.0247614026);

final_score_51_c414 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 198 => -0.0891490533,
    r_c13_max_lres_d > 198             => 0.0508263092,
    r_c13_max_lres_d = NULL            => -0.0472312977,
                         -0.0472312977);

final_score_51_c412 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 8.5 => final_score_51_c413,
    r_d32_criminal_count_i > 8.5                   => final_score_51_c414,
    r_d32_criminal_count_i = NULL                  => 0.0206904516,
                    0.0206904516);

final_score_51_c411 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 7895.5 => final_score_51_c412,
    f_liens_rel_cj_total_amt_i > 7895.5      => -0.1243603241,
    f_liens_rel_cj_total_amt_i = NULL        => 0.0183175210,
              0.0183175210);

final_score_51 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 4.5 => -0.0084869975,
    f_srchvelocityrisktype_i > 4.5                     => final_score_51_c411,
    f_srchvelocityrisktype_i = NULL                    => -0.0161566029,
                        -0.0016970393);

final_score_52_c418 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 10.5 => 0.0457315649,
    f_addrs_per_ssn_i > 10.5              => 0.1678885918,
    f_addrs_per_ssn_i = NULL              => 0.0661591613,
           0.0661591613);

final_score_52_c417 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 432.5 => 0.0116249761,
    r_c13_max_lres_d > 432.5             => final_score_52_c418,
    r_c13_max_lres_d = NULL              => 0.0149925353,
          0.0149925353);

final_score_52_c416 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 9.5 => final_score_52_c417,
    f_util_adl_count_n > 9.5               => -0.0444493492,
    f_util_adl_count_n = NULL              => 0.0109534621,
            0.0109534621);

final_score_52_c419 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 5.5 => -0.0250240955,
    r_d30_derog_count_i > 5.5                => 0.0759614078,
    r_d30_derog_count_i = NULL               => -0.0211216696,
              -0.0211216696);

final_score_52 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => final_score_52_c416,
    r_c20_email_verification_d > 1.5      => final_score_52_c419,
    r_c20_email_verification_d = NULL                      => -0.0909741891,
                            -0.0113904008);

final_score_53_c422 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 20.5 => -0.0250843156,
    r_c13_curr_addr_lres_d > 20.5                   => 0.0170235697,
    r_c13_curr_addr_lres_d = NULL                   => 0.0096645047,
                     0.0096645047);

final_score_53_c421 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 1.5 => final_score_53_c422,
    f_srchunvrfdaddrcount_i > 1.5                    => 0.1070504441,
    f_srchunvrfdaddrcount_i = NULL                   => 0.0108099970,
                      0.0108099970);

final_score_53_c424 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 1.5 => 0.0139817875,
    f_assocrisktype_i > 1.5              => 0.1773600942,
    f_assocrisktype_i = NULL             => 0.0757467571,
          0.0757467571);

final_score_53_c423 := map(
    NULL < f_accident_recency_d AND f_accident_recency_d <= 9 => final_score_53_c424,
    f_accident_recency_d > 9                 => -0.0200643995,
    f_accident_recency_d = NULL              => -0.0181107715,
              -0.0181107715);

final_score_53 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => final_score_53_c421,
    f_corrphonelastnamecount_d > 0.5      => final_score_53_c423,
    f_corrphonelastnamecount_d = NULL                      => -0.0068870314,
                            -0.0068870314);

final_score_54_c429 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 4.5 => 0.0882487591,
    r_i60_inq_hiriskcred_recency_d > 4.5          => -0.0169845823,
    r_i60_inq_hiriskcred_recency_d = NULL         => -0.0152105055,
                   -0.0152105055);

final_score_54_c428 := map(
    NULL < r_i60_inq_retpymt_count12_i AND r_i60_inq_retpymt_count12_i <= 8.5 => final_score_54_c429,
    r_i60_inq_retpymt_count12_i > 8.5       => -0.1273490283,
    r_i60_inq_retpymt_count12_i = NULL      => -0.0163845282,
             -0.0163845282);

final_score_54_c427 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0053322228,
    f_phone_ver_experian_d > 0.5                   => final_score_54_c428,
    f_phone_ver_experian_d = NULL                  => 0.0308012459,
                    -0.0079879933);

final_score_54_c426 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 221.5 => -0.1041758691,
    r_d32_mos_since_fel_ls_d > 221.5                     => final_score_54_c427,
    r_d32_mos_since_fel_ls_d = NULL                      => -0.0085105135,
                          -0.0085105135);

final_score_54 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 102.5 => 0.1003744685,
    r_d32_mos_since_fel_ls_d > 102.5                     => final_score_54_c426,
    r_d32_mos_since_fel_ls_d = NULL                      => 0.0015207424,
                          -0.0079824031);

final_score_55_c432 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i <= 457 => 0.0320290852,
    f_liens_unrel_ot_total_amt_i > 457        => -0.0615213349,
    f_liens_unrel_ot_total_amt_i = NULL       => 0.0264151397,
               0.0264151397);

final_score_55_c434 := map(
    NULL < r_l77_apartment_i AND r_l77_apartment_i <= 0.5 => 0.0138620815,
    r_l77_apartment_i > 0.5              => 0.1708589791,
    r_l77_apartment_i = NULL             => 0.0826293176,
          0.0826293176);

final_score_55_c433 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 3.5 => -0.0087775935,
    f_inq_communications_count24_i > 3.5          => final_score_55_c434,
    f_inq_communications_count24_i = NULL         => -0.0077756697,
                   -0.0077756697);

final_score_55_c431 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 170.5 => final_score_55_c432,
    r_d32_mos_since_crim_ls_d > 170.5                      => final_score_55_c433,
    r_d32_mos_since_crim_ls_d = NULL      => -0.0024582037,
                            -0.0024582037);

final_score_55 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 16.5 => final_score_55_c431,
    r_c20_email_count_i > 16.5                => -0.1235695005,
    r_c20_email_count_i = NULL                => 0.0323065357,
               -0.0028246311);

final_score_56_c439 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.0394376539,
    r_f00_dob_score_d > 98              => 0.0167568850,
    r_f00_dob_score_d = NULL            => 0.0181120253,
         0.0181120253);

final_score_56_c438 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_56_c439,
    r_c20_email_verification_d > 0.5      => -0.0085703116,
    r_c20_email_verification_d = NULL                      => -0.1018065802,
                            -0.0040146546);

final_score_56_c437 := map(
    NULL < f_adl_util_misc_n AND f_adl_util_misc_n <= 0.5 => final_score_56_c438,
    f_adl_util_misc_n > 0.5              => -0.0201706298,
    f_adl_util_misc_n = NULL             => -0.0088386294,
          -0.0088386294);

final_score_56_c436 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 61 => 0.1107571493,
    r_d32_mos_since_fel_ls_d > 61                     => final_score_56_c437,
    r_d32_mos_since_fel_ls_d = NULL                   => 0.0478228996,
                       -0.0081332276);

final_score_56 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 9.5 => final_score_56_c436,
    r_l79_adls_per_addr_c6_i > 9.5                     => 0.1316343808,
    r_l79_adls_per_addr_c6_i = NULL                    => -0.0075504653,
                        -0.0075504653);

final_score_57_c442 := map(
    NULL < f_mos_liens_rel_cj_fseen_d AND f_mos_liens_rel_cj_fseen_d <= 166.5 => 0.1128163712,
    f_mos_liens_rel_cj_fseen_d > 166.5      => -0.0248375357,
    f_mos_liens_rel_cj_fseen_d = NULL       => -0.0234066219,
             -0.0234066219);

final_score_57_c444 := map(
    NULL < f_divssnidmsrcurelcount_i AND f_divssnidmsrcurelcount_i <= 2.5 => 0.0063371368,
    f_divssnidmsrcurelcount_i > 2.5                      => 0.0816318976,
    f_divssnidmsrcurelcount_i = NULL                     => 0.0076226571,
                          0.0076226571);

final_score_57_c443 := map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d <= 75.5 => -0.0853746182,
    f_mos_liens_unrel_st_fseen_d > 75.5        => final_score_57_c444,
    f_mos_liens_unrel_st_fseen_d = NULL        => 0.0068132031,
                0.0068132031);

final_score_57_c441 := map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 549 => final_score_57_c442,
    r_i60_inq_retail_recency_d > 549      => final_score_57_c443,
    r_i60_inq_retail_recency_d = NULL                      => -0.0475996107,
                            -0.0044957398);

final_score_57 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 34.5 => final_score_57_c441,
    k_inq_per_ssn_i > 34.5            => 0.1271111522,
    k_inq_per_ssn_i = NULL            => -0.0039869888,
                        -0.0039869888);

final_score_58_c447 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 6.5 => -0.0038158932,
    k_inq_per_ssn_i > 6.5            => -0.1471683931,
    k_inq_per_ssn_i = NULL           => -0.0533616881,
                       -0.0533616881);

final_score_58_c446 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i <= 1570 => 0.0160500826,
    f_liens_unrel_ot_total_amt_i > 1570        => final_score_58_c447,
    f_liens_unrel_ot_total_amt_i = NULL        => 0.0134928069,
                0.0134928069);

final_score_58_c449 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 368.5 => 0.0157866017,
    r_c10_m_hdr_fs_d > 368.5             => 0.1212013445,
    r_c10_m_hdr_fs_d = NULL              => 0.0516172286,
          0.0516172286);

final_score_58_c448 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 0.5 => -0.0172581207,
    f_inq_highriskcredit_count24_i > 0.5          => final_score_58_c449,
    f_inq_highriskcredit_count24_i = NULL         => -0.0153256126,
                   -0.0153256126);

final_score_58 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => final_score_58_c446,
    r_i61_inq_collection_recency_d > 549          => final_score_58_c448,
    r_i61_inq_collection_recency_d = NULL         => 0.0014686606,
                   -0.0023730998);

final_score_59_c454 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 2.5 => -0.0094415791,
    f_idverrisktype_i > 2.5              => 0.0183820657,
    f_idverrisktype_i = NULL             => -0.0047670118,
          -0.0047670118);

final_score_59_c453 := map(
    NULL < r_d31_bk_filing_count_i AND r_d31_bk_filing_count_i <= 2.5 => final_score_59_c454,
    r_d31_bk_filing_count_i > 2.5                    => 0.0792044841,
    r_d31_bk_filing_count_i = NULL                   => -0.0041893177,
                      -0.0041893177);

final_score_59_c452 := map(
    NULL < r_i61_inq_collection_count12_i AND r_i61_inq_collection_count12_i <= 1.5 => final_score_59_c453,
    r_i61_inq_collection_count12_i > 1.5          => 0.0476558741,
    r_i61_inq_collection_count12_i = NULL         => -0.0027969382,
                   -0.0027969382);

final_score_59_c451 := map(
    NULL < f_mos_liens_unrel_ot_fseen_d AND f_mos_liens_unrel_ot_fseen_d <= 32.5 => 0.0992009652,
    f_mos_liens_unrel_ot_fseen_d > 32.5        => final_score_59_c452,
    f_mos_liens_unrel_ot_fseen_d = NULL        => -0.0022892916,
                -0.0022892916);

final_score_59 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i <= 12922 => final_score_59_c451,
    f_liens_unrel_ot_total_amt_i > 12922        => -0.1030496644,
    f_liens_unrel_ot_total_amt_i = NULL         => 0.0242684593,
                 -0.0026005860);

final_score_60_c457 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => -0.0066080318,
    f_inq_other_count24_i > 1.5                  => 0.0213546828,
    f_inq_other_count24_i = NULL                 => -0.0007837635,
                  -0.0007837635);

final_score_60_c459 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 1.5 => -0.1193125388,
    f_assocsuspicousidcount_i > 1.5                      => -0.0035366768,
    f_assocsuspicousidcount_i = NULL                     => -0.0785850617,
                          -0.0785850617);

final_score_60_c458 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d <= 4.5 => final_score_60_c459,
    r_i60_inq_recency_d > 4.5                => 0.0087708618,
    r_i60_inq_recency_d = NULL               => -0.0388607086,
              -0.0388607086);

final_score_60_c456 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 4218 => final_score_60_c457,
    f_liens_unrel_cj_total_amt_i > 4218        => final_score_60_c458,
    f_liens_unrel_cj_total_amt_i = NULL        => -0.0021388565,
                -0.0021388565);

final_score_60 := map(
    NULL < r_d31_bk_filing_count_i AND r_d31_bk_filing_count_i <= 2.5 => final_score_60_c456,
    r_d31_bk_filing_count_i > 2.5                    => 0.0810138640,
    r_d31_bk_filing_count_i = NULL                   => 0.0585237498,
                      -0.0012659106);

final_score_61_c461 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 10.5 => 0.0007764294,
    k_inq_per_phone_i > 10.5              => 0.0660273724,
    k_inq_per_phone_i = NULL              => 0.0017284574,
           0.0017284574);

final_score_61_c464 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 2.5 => 0.0672409197,
    r_l79_adls_per_addr_curr_i > 2.5      => -0.0302039815,
    r_l79_adls_per_addr_curr_i = NULL                      => -0.0014016832,
                            -0.0014016832);

final_score_61_c463 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => final_score_61_c464,
    r_c23_inp_addr_occ_index_d > 2      => -0.0875533623,
    r_c23_inp_addr_occ_index_d = NULL                    => -0.0183133926,
                          -0.0183133926);

final_score_61_c462 := map(
    NULL < r_d34_unrel_lien60_count_i AND r_d34_unrel_lien60_count_i <= 1.5 => final_score_61_c463,
    r_d34_unrel_lien60_count_i > 1.5      => -0.1368726008,
    r_d34_unrel_lien60_count_i = NULL                      => -0.0302906016,
                            -0.0302906016);

final_score_61 := map(
    NULL < r_i60_inq_retpymt_count12_i AND r_i60_inq_retpymt_count12_i <= 2.5 => final_score_61_c461,
    r_i60_inq_retpymt_count12_i > 2.5       => final_score_61_c462,
    r_i60_inq_retpymt_count12_i = NULL      => -0.0554319824,
             -0.0004423917);

final_score_62_c468 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => 0.0137466585,
    f_adl_per_email_i > 0.5              => -0.0486382380,
    f_adl_per_email_i = NULL             => -0.1015655968,
          -0.0144181699);

final_score_62_c469 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 7.5 => -0.0277889575,
    f_srchcomponentrisktype_i > 7.5                      => 0.0672891612,
    f_srchcomponentrisktype_i = NULL                     => -0.0245019200,
                          -0.0245019200);

final_score_62_c467 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_62_c468,
    r_phn_cell_n > 0.5         => final_score_62_c469,
    r_phn_cell_n = NULL        => -0.0177160782,
                 -0.0177160782);

final_score_62_c466 := map(
    NULL < f_liens_unrel_fc_total_amt_i AND f_liens_unrel_fc_total_amt_i <= 166.5 => final_score_62_c467,
    f_liens_unrel_fc_total_amt_i > 166.5        => -0.1062160222,
    f_liens_unrel_fc_total_amt_i = NULL         => -0.0181428614,
                 -0.0181428614);

final_score_62 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 9.5 => final_score_62_c466,
    f_assocsuspicousidcount_i > 9.5                      => -0.1029517733,
    f_assocsuspicousidcount_i = NULL                     => -0.0464372693,
                          -0.0187193788);

final_score_63_c473 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 2.5 => 0.0226177537,
    f_historical_count_d > 2.5                 => -0.0997124611,
    f_historical_count_d = NULL                => -0.0346012177,
                -0.0346012177);

final_score_63_c472 := map(
    NULL < (Integer)k_nap_phn_verd_d AND (Real)k_nap_phn_verd_d <= 0.5 => final_score_63_c473,
    (Real)k_nap_phn_verd_d > 0.5             => 0.0814638592,
    (Integer)k_nap_phn_verd_d = NULL            => 0.0212459950,
                         0.0212459950);

final_score_63_c471 := map(
    NULL < f_componentcharrisktype_i AND f_componentcharrisktype_i <= 2.5 => 0.1045112611,
    f_componentcharrisktype_i > 2.5                      => final_score_63_c472,
    f_componentcharrisktype_i = NULL                     => 0.0507264000,
                          0.0507264000);

final_score_63_c474 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 0.5 => -0.0275498694,
    r_c20_email_count_i > 0.5                => 0.0037401570,
    r_c20_email_count_i = NULL               => -0.0014864179,
              -0.0014864179);

final_score_63 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => final_score_63_c471,
    r_f00_dob_score_d > 98              => final_score_63_c474,
    r_f00_dob_score_d = NULL            => 0.0251829533,
         0.0003882600);

final_score_64_c477 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 5.5 => 0.0101734295,
    f_inq_count24_i > 5.5            => -0.1328361274,
    f_inq_count24_i = NULL           => -0.0623108665,
                       -0.0623108665);

final_score_64_c479 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => 0.0122202668,
    (Real)f_nae_email_verd_d > 0.5               => -0.0577084928,
    (Integer)f_nae_email_verd_d = NULL              => -0.0131415618,
            -0.0131415618);

final_score_64_c478 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 39.5 => -0.0271953800,
    r_c13_curr_addr_lres_d > 39.5                   => final_score_64_c479,
    r_c13_curr_addr_lres_d = NULL                   => -0.0161644998,
                     -0.0161644998);

final_score_64_c476 := map(
    NULL < f_mos_liens_unrel_ot_lseen_d AND f_mos_liens_unrel_ot_lseen_d <= 67.5 => final_score_64_c477,
    f_mos_liens_unrel_ot_lseen_d > 67.5        => final_score_64_c478,
    f_mos_liens_unrel_ot_lseen_d = NULL        => -0.0169377842,
                -0.0169377842);

final_score_64 := map(
    NULL < f_mos_liens_unrel_ot_fseen_d AND f_mos_liens_unrel_ot_fseen_d <= 31.5 => 0.0992769957,
    f_mos_liens_unrel_ot_fseen_d > 31.5        => final_score_64_c476,
    f_mos_liens_unrel_ot_fseen_d = NULL        => -0.0172675420,
                -0.0164550237);

final_score_65_c484 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 26.5 => -0.0333832260,
    f_inq_count24_i > 26.5            => 0.0578116530,
    f_inq_count24_i = NULL            => -0.0194523010,
                        -0.0194523010);

final_score_65_c483 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 1.5 => 0.0445491428,
    f_srchfraudsrchcountyr_i > 1.5                     => final_score_65_c484,
    f_srchfraudsrchcountyr_i = NULL                    => 0.0177298180,
                        0.0177298180);

final_score_65_c482 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 4.5 => 0.1510079770,
    r_c13_curr_addr_lres_d > 4.5                   => final_score_65_c483,
    r_c13_curr_addr_lres_d = NULL                  => 0.0245331952,
                    0.0245331952);

final_score_65_c481 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 2.5 => -0.0057852123,
    f_assocrisktype_i > 2.5              => final_score_65_c482,
    f_assocrisktype_i = NULL             => -0.0011257818,
          -0.0011257818);

final_score_65 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 15.5 => final_score_65_c481,
    f_corraddrnamecount_d > 15.5                  => 0.0536924070,
    f_corraddrnamecount_d = NULL                  => 0.0415308027,
                   0.0006628637);

final_score_66_c489 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 8.5 => 0.0131540146,
    f_phones_per_addr_curr_i > 8.5                     => -0.0297830759,
    f_phones_per_addr_curr_i = NULL                    => 0.0083500603,
                        0.0083500603);

final_score_66_c488 := map(
    NULL < f_bus_phone_match_d AND f_bus_phone_match_d <= 0.5 => final_score_66_c489,
    f_bus_phone_match_d > 0.5                => 0.0716973785,
    f_bus_phone_match_d = NULL               => 0.0138426750,
              0.0138426750);

final_score_66_c487 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_66_c488,
    f_adl_per_email_i > 0.5              => -0.0485423929,
    f_adl_per_email_i = NULL             => -0.0811649786,
          -0.0148316172);

final_score_66_c486 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 244.5 => -0.0232981461,
    f_m_bureau_adl_fs_notu_d > 244.5                     => final_score_66_c487,
    f_m_bureau_adl_fs_notu_d = NULL                      => 0.0521497568,
                          -0.0171309100);

final_score_66 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_66_c486,
    r_p85_phn_not_issued_i > 0.5                   => 0.0561408129,
    r_p85_phn_not_issued_i = NULL                  => -0.0160189634,
                    -0.0160189634);

final_score_67_c492 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 14.5 => -0.0183086232,
    f_srchfraudsrchcountyr_i > 14.5                     => 0.0903360530,
    f_srchfraudsrchcountyr_i = NULL                     => -0.0169570307,
                         -0.0169570307);

final_score_67_c493 := map(
    NULL < f_mos_liens_unrel_st_lseen_d AND f_mos_liens_unrel_st_lseen_d <= 33 => 0.1303608496,
    f_mos_liens_unrel_st_lseen_d > 33        => 0.0085414586,
    f_mos_liens_unrel_st_lseen_d = NULL      => 0.0095303141,
              0.0095303141);

final_score_67_c491 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 3.5 => final_score_67_c492,
    f_phones_per_addr_curr_i > 3.5                     => final_score_67_c493,
    f_phones_per_addr_curr_i = NULL                    => -0.0495219999,
                        -0.0040393250);

final_score_67_c494 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 4.5 => 0.1063469075,
    f_phones_per_addr_curr_i > 4.5                     => -0.0137386510,
    f_phones_per_addr_curr_i = NULL                    => 0.0475049838,
                        0.0475049838);

final_score_67 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_67_c491,
    r_p85_phn_not_issued_i > 0.5                   => final_score_67_c494,
    r_p85_phn_not_issued_i = NULL                  => -0.0032571062,
                    -0.0032571062);

final_score_68_c497 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d <= 9 => -0.1113992417,
    r_i60_inq_recency_d > 9                => 0.0060293543,
    r_i60_inq_recency_d = NULL             => -0.0639281071,
            -0.0639281071);

final_score_68_c499 := map(
    NULL < f_m_bureau_adl_fs_notu_d AND f_m_bureau_adl_fs_notu_d <= 281.5 => -0.0149615398,
    f_m_bureau_adl_fs_notu_d > 281.5                     => 0.0108469539,
    f_m_bureau_adl_fs_notu_d = NULL                      => 0.0013310516,
                          0.0013310516);

final_score_68_c498 := map(
    NULL < f_idrisktype_i AND f_idrisktype_i <= 7.5 => final_score_68_c499,
    f_idrisktype_i > 7.5           => 0.0944515111,
    f_idrisktype_i = NULL          => 0.0016994021,
                     0.0016994021);

final_score_68_c496 := map(
    NULL < f_mos_liens_unrel_st_fseen_d AND f_mos_liens_unrel_st_fseen_d <= 112.5 => final_score_68_c497,
    f_mos_liens_unrel_st_fseen_d > 112.5        => final_score_68_c498,
    f_mos_liens_unrel_st_fseen_d = NULL         => 0.0007562042,
                 0.0007562042);

final_score_68 := map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 6.5 => final_score_68_c496,
    f_inq_collection_count24_i > 6.5      => 0.1139134567,
    f_inq_collection_count24_i = NULL                      => 0.0438900856,
                            0.0013877636);

final_score_69_c502 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => 0.0145378876,
    (Real)f_nae_email_verd_d > 0.5               => -0.0704436238,
    (Integer)f_nae_email_verd_d = NULL              => -0.0163501580,
            -0.0163501580);

final_score_69_c503 := map(
    NULL < f_mos_liens_unrel_ot_lseen_d AND f_mos_liens_unrel_ot_lseen_d <= 26.5 => -0.1198507336,
    f_mos_liens_unrel_ot_lseen_d > 26.5        => -0.0163306576,
    f_mos_liens_unrel_ot_lseen_d = NULL        => -0.0177699172,
                -0.0177699172);

final_score_69_c501 := map(
    NULL < f_adl_util_misc_n AND f_adl_util_misc_n <= 0.5 => final_score_69_c502,
    f_adl_util_misc_n > 0.5              => final_score_69_c503,
    f_adl_util_misc_n = NULL             => -0.0167725836,
          -0.0167725836);

final_score_69_c504 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 214 => 0.1297718727,
    r_c21_m_bureau_adl_fs_d > 214                    => -0.0071197360,
    r_c21_m_bureau_adl_fs_d = NULL                   => 0.0633391802,
                      0.0633391802);

final_score_69 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 5.5 => final_score_69_c501,
    k_inq_ssns_per_addr_i > 5.5                  => final_score_69_c504,
    k_inq_ssns_per_addr_i = NULL                 => -0.0159465639,
                  -0.0159465639);

final_score_70_c508 := map(
    NULL < f_inq_retailpayments_count24_i AND f_inq_retailpayments_count24_i <= 1.5 => 0.0428155011,
    f_inq_retailpayments_count24_i > 1.5          => -0.0161926557,
    f_inq_retailpayments_count24_i = NULL         => 0.0137539838,
                   0.0137539838);

final_score_70_c507 := map(
    NULL < r_c12_num_nonderogs_d AND r_c12_num_nonderogs_d <= 1.5 => 0.1132925083,
    r_c12_num_nonderogs_d > 1.5                  => final_score_70_c508,
    r_c12_num_nonderogs_d = NULL                 => 0.0213400608,
                  0.0213400608);

final_score_70_c506 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => -0.0048891853,
    f_srchcomponentrisktype_i > 1.5                      => final_score_70_c507,
    f_srchcomponentrisktype_i = NULL                     => -0.0740049003,
                          -0.0017300741);

final_score_70_c509 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 0.5 => 0.0023382805,
    k_inq_per_ssn_i > 0.5            => 0.0960429182,
    k_inq_per_ssn_i = NULL           => 0.0507878375,
                       0.0507878375);

final_score_70 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => final_score_70_c506,
    r_p85_phn_not_issued_i > 0.5                   => final_score_70_c509,
    r_p85_phn_not_issued_i = NULL                  => -0.0010286662,
                    -0.0010286662);

final_score_71_c511 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => -0.0065344297,
    f_inq_other_count24_i > 1.5                  => 0.0215865126,
    f_inq_other_count24_i = NULL                 => -0.0012951324,
                  -0.0012951324);

final_score_71_c513 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 2.5 => -0.0944306972,
    f_inq_communications_count24_i > 2.5          => 0.0659382736,
    f_inq_communications_count24_i = NULL         => -0.0608239643,
                   -0.0608239643);

final_score_71_c514 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 3.5 => 0.0179743735,
    f_assocrisktype_i > 3.5              => -0.0996444234,
    f_assocrisktype_i = NULL             => -0.0180109808,
          -0.0180109808);

final_score_71_c512 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_71_c513,
    f_phone_ver_experian_d > 0.5                   => final_score_71_c514,
    f_phone_ver_experian_d = NULL                  => -0.0366431912,
                    -0.0366431912);

final_score_71 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 11.5 => final_score_71_c511,
    r_i60_inq_count12_i > 11.5                => final_score_71_c512,
    r_i60_inq_count12_i = NULL                => 0.0055788269,
               -0.0030385378);

final_score_72_c519 := map(
    NULL < r_a44_curr_add_naprop_d AND r_a44_curr_add_naprop_d <= 2.5 => 0.1675416381,
    r_a44_curr_add_naprop_d > 2.5                    => 0.0492465829,
    r_a44_curr_add_naprop_d = NULL                   => 0.0959419994,
                      0.0959419994);

final_score_72_c518 := map(
    NULL < (Integer)k_inf_fname_verd_d AND (Real)k_inf_fname_verd_d <= 0.5 => final_score_72_c519,
    (Real)k_inf_fname_verd_d > 0.5               => -0.0310697781,
    (Integer)k_inf_fname_verd_d = NULL              => 0.0577605448,
            0.0577605448);

final_score_72_c517 := map(
    NULL < r_d31_all_bk_i AND r_d31_all_bk_i <= 1.5 => 0.0067851766,
    r_d31_all_bk_i > 1.5           => final_score_72_c518,
    r_d31_all_bk_i = NULL          => 0.0119572806,
                     0.0119572806);

final_score_72_c516 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 4.5 => -0.0096993603,
    f_historical_count_d > 4.5                 => final_score_72_c517,
    f_historical_count_d = NULL                => -0.0042801401,
                -0.0042801401);

final_score_72 := map(
    NULL < f_srchcountwk_i AND f_srchcountwk_i <= 3.5 => final_score_72_c516,
    f_srchcountwk_i > 3.5            => -0.0479277295,
    f_srchcountwk_i = NULL           => 0.0157001234,
                       -0.0051489851);

final_score_73_c521 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 46 => 0.0853531094,
    r_d32_mos_since_fel_ls_d > 46                     => -0.0024221992,
    r_d32_mos_since_fel_ls_d = NULL                   => -0.0247734092,
                       -0.0021636040);

final_score_73_c524 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 8.5 => 0.0032502198,
    k_inq_per_addr_i > 8.5             => 0.1207449386,
    k_inq_per_addr_i = NULL            => 0.0448032301,
                         0.0448032301);

final_score_73_c523 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 9 => -0.0982589668,
    r_i60_inq_hiriskcred_recency_d > 9          => final_score_73_c524,
    r_i60_inq_hiriskcred_recency_d = NULL       => 0.0074266201,
                 0.0074266201);

final_score_73_c522 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 0.5 => final_score_73_c523,
    r_d32_criminal_count_i > 0.5                   => 0.1252816694,
    r_d32_criminal_count_i = NULL                  => 0.0406091097,
                    0.0406091097);

final_score_73 := map(
    NULL < k_inq_lnames_per_ssn_i AND k_inq_lnames_per_ssn_i <= 1.5 => final_score_73_c521,
    k_inq_lnames_per_ssn_i > 1.5                   => final_score_73_c522,
    k_inq_lnames_per_ssn_i = NULL                  => -0.0011618024,
                    -0.0011618024);

final_score_74_c528 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 74 => 0.0563928198,
    r_c13_curr_addr_lres_d > 74                   => 0.2072890177,
    r_c13_curr_addr_lres_d = NULL                 => 0.1131207138,
                   0.1131207138);

final_score_74_c529 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 342.5 => -0.0331779273,
    r_c21_m_bureau_adl_fs_d > 342.5                    => 0.1036340159,
    r_c21_m_bureau_adl_fs_d = NULL                     => -0.0031992147,
                        -0.0031992147);

final_score_74_c527 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 86.5 => final_score_74_c528,
    r_d32_mos_since_crim_ls_d > 86.5                      => final_score_74_c529,
    r_d32_mos_since_crim_ls_d = NULL                      => 0.0370886772,
                           0.0370886772);

final_score_74_c526 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i <= 1.5 => 0.0018998594,
    r_d33_eviction_count_i > 1.5                   => final_score_74_c527,
    r_d33_eviction_count_i = NULL                  => 0.0029349832,
                    0.0029349832);

final_score_74 := map(
    NULL < f_mos_liens_unrel_ft_lseen_d AND f_mos_liens_unrel_ft_lseen_d <= 65.5 => -0.0928216221,
    f_mos_liens_unrel_ft_lseen_d > 65.5        => final_score_74_c526,
    f_mos_liens_unrel_ft_lseen_d = NULL        => 0.0425050183,
                0.0025415496);

final_score_75_c534 := map(
    NULL < r_i60_inq_retpymt_recency_d AND r_i60_inq_retpymt_recency_d <= 2 => -0.1104933019,
    r_i60_inq_retpymt_recency_d > 2       => -0.0244409274,
    r_i60_inq_retpymt_recency_d = NULL                     => -0.0261697035,
                            -0.0261697035);

final_score_75_c533 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 11.5 => final_score_75_c534,
    f_srchfraudsrchcountyr_i > 11.5                     => 0.0953329267,
    f_srchfraudsrchcountyr_i = NULL                     => -0.0244986883,
                         -0.0244986883);

final_score_75_c532 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 2.5 => final_score_75_c533,
    f_phones_per_addr_curr_i > 2.5                     => 0.0045833842,
    f_phones_per_addr_curr_i = NULL                    => -0.0050604351,
                        -0.0050604351);

final_score_75_c531 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 1.5 => final_score_75_c532,
    f_srchunvrfdaddrcount_i > 1.5                    => 0.0965599062,
    f_srchunvrfdaddrcount_i = NULL                   => -0.0135813717,
                      -0.0045488249);

final_score_75 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 5.5 => final_score_75_c531,
    k_inq_ssns_per_addr_i > 5.5                  => 0.0711760452,
    k_inq_ssns_per_addr_i = NULL                 => -0.0038655843,
                  -0.0038655843);

final_score_76_c539 := map(
    NULL < f_liens_unrel_sc_total_amt_i AND f_liens_unrel_sc_total_amt_i <= 267.5 => 0.0637406829,
    f_liens_unrel_sc_total_amt_i > 267.5        => -0.0855544923,
    f_liens_unrel_sc_total_amt_i = NULL         => 0.0311816287,
                 0.0311816287);

final_score_76_c538 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 4.5 => final_score_76_c539,
    r_i60_inq_hiriskcred_recency_d > 4.5          => -0.0030548189,
    r_i60_inq_hiriskcred_recency_d = NULL         => -0.0020581556,
                   -0.0020581556);

final_score_76_c537 := map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 40.5 => -0.0900462836,
    f_mos_liens_rel_cj_lseen_d > 40.5      => final_score_76_c538,
    f_mos_liens_rel_cj_lseen_d = NULL      => -0.0024042182,
            -0.0024042182);

final_score_76_c536 := map(
    NULL < f_mos_liens_unrel_fc_fseen_d AND f_mos_liens_unrel_fc_fseen_d <= 230.5 => -0.1099303993,
    f_mos_liens_unrel_fc_fseen_d > 230.5        => final_score_76_c537,
    f_mos_liens_unrel_fc_fseen_d = NULL         => -0.0028912476,
                 -0.0028912476);

final_score_76 := map(
    NULL < f_mos_liens_unrel_ot_fseen_d AND f_mos_liens_unrel_ot_fseen_d <= 50.5 => 0.0788459321,
    f_mos_liens_unrel_ot_fseen_d > 50.5        => final_score_76_c536,
    f_mos_liens_unrel_ot_fseen_d = NULL        => 0.0236178176,
                -0.0021328868);

final_score_77_c542 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d <= 9 => 0.0726139617,
    r_i60_inq_banking_recency_d > 9       => -0.0757860477,
    r_i60_inq_banking_recency_d = NULL                     => -0.0589002698,
                            -0.0589002698);

final_score_77_c544 := map(
    NULL < r_d34_unrel_liens_ct_i AND r_d34_unrel_liens_ct_i <= 2.5 => 0.0969908213,
    r_d34_unrel_liens_ct_i > 2.5                   => -0.0386735770,
    r_d34_unrel_liens_ct_i = NULL                  => 0.0635393258,
                    0.0635393258);

final_score_77_c543 := map(
    NULL < r_c20_email_domain_isp_count_i AND r_c20_email_domain_isp_count_i <= 1.5 => final_score_77_c544,
    r_c20_email_domain_isp_count_i > 1.5          => -0.0870055141,
    r_c20_email_domain_isp_count_i = NULL         => 0.0196913142,
                   0.0196913142);

final_score_77_c541 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => final_score_77_c542,
    r_i60_inq_comm_recency_d > 549                     => final_score_77_c543,
    r_i60_inq_comm_recency_d = NULL                    => -0.0271968763,
                        -0.0271968763);

final_score_77 := map(
    NULL < r_i60_inq_retpymt_count12_i AND r_i60_inq_retpymt_count12_i <= 2.5 => 0.0029102347,
    r_i60_inq_retpymt_count12_i > 2.5       => final_score_77_c541,
    r_i60_inq_retpymt_count12_i = NULL      => -0.0261304313,
             0.0010147013);

final_score_78_c549 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => 0.0206511207,
    f_adl_per_email_i > 0.5              => -0.0495254534,
    f_adl_per_email_i = NULL             => -0.1012812587,
          -0.0123714036);

final_score_78_c548 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 9.5 => -0.0137844848,
    f_corraddrnamecount_d > 9.5                  => final_score_78_c549,
    f_corraddrnamecount_d = NULL                 => -0.0131616724,
                  -0.0131616724);

final_score_78_c547 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 85 => 0.0557948020,
    r_f01_inp_addr_address_score_d > 85          => final_score_78_c548,
    r_f01_inp_addr_address_score_d = NULL        => -0.0114829268,
                  -0.0114829268);

final_score_78_c546 := map(
    NULL < r_d31_bk_disposed_recent_count_i AND r_d31_bk_disposed_recent_count_i <= 0.5 => final_score_78_c547,
    r_d31_bk_disposed_recent_count_i > 0.5            => 0.0940164875,
    r_d31_bk_disposed_recent_count_i = NULL           => -0.0108509027,
                       -0.0108509027);

final_score_78 := map(
    NULL < f_mos_liens_unrel_ft_lseen_d AND f_mos_liens_unrel_ft_lseen_d <= 71.5 => -0.0831558447,
    f_mos_liens_unrel_ft_lseen_d > 71.5        => final_score_78_c546,
    f_mos_liens_unrel_ft_lseen_d = NULL        => -0.0316785719,
                -0.0115298099);

final_score_79_c551 := map(
    NULL < f_inq_auto_count24_i AND f_inq_auto_count24_i <= 4.5 => -0.0038951354,
    f_inq_auto_count24_i > 4.5                 => 0.0955291492,
    f_inq_auto_count24_i = NULL                => -0.0029055542,
                -0.0029055542);

final_score_79_c553 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 71.5 => -0.0172577167,
    f_prevaddrlenofres_d > 71.5                 => 0.0715356438,
    f_prevaddrlenofres_d = NULL                 => 0.0453610142,
                 0.0453610142);

final_score_79_c554 := map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 7.5 => 0.0520353131,
    f_corrssnnamecount_d > 7.5                 => -0.0760714345,
    f_corrssnnamecount_d = NULL                => -0.0312822333,
                -0.0312822333);

final_score_79_c552 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 5.5 => final_score_79_c553,
    r_c20_email_count_i > 5.5                => final_score_79_c554,
    r_c20_email_count_i = NULL               => 0.0244511641,
              0.0244511641);

final_score_79 := map(
    NULL < r_d31_mostrec_bk_i AND r_d31_mostrec_bk_i <= 1.5 => final_score_79_c551,
    r_d31_mostrec_bk_i > 1.5               => final_score_79_c552,
    r_d31_mostrec_bk_i = NULL              => 0.0766231501,
            -0.0005161013);

final_score_80_c558 := map(
    NULL < r_i60_inq_retail_recency_d AND r_i60_inq_retail_recency_d <= 61.5 => -0.0335025957,
    r_i60_inq_retail_recency_d > 61.5      => 0.0176743952,
    r_i60_inq_retail_recency_d = NULL      => 0.0125822208,
            0.0125822208);

final_score_80_c557 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 9.5 => final_score_80_c558,
    f_util_adl_count_n > 9.5               => -0.0425509232,
    f_util_adl_count_n = NULL              => 0.0087922973,
            0.0087922973);

final_score_80_c556 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 466.5 => final_score_80_c557,
    r_c13_max_lres_d > 466.5             => 0.0872006274,
    r_c13_max_lres_d = NULL              => 0.0121058165,
          0.0121058165);

final_score_80_c559 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 549 => 0.0954369060,
    r_i60_inq_prepaidcards_recency_d > 549            => -0.0176677189,
    r_i60_inq_prepaidcards_recency_d = NULL           => -0.0144138138,
                       -0.0144138138);

final_score_80 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_80_c556,
    r_c20_email_verification_d > 0.5      => final_score_80_c559,
    r_c20_email_verification_d = NULL                      => -0.1014106672,
                            -0.0090273593);

final_score_81_c563 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => 0.0023612782,
    f_corrphonelastnamecount_d > 0.5      => -0.1163580013,
    f_corrphonelastnamecount_d = NULL                      => -0.0647607760,
                            -0.0647607760);

final_score_81_c562 := map(
    NULL < r_i60_inq_retpymt_count12_i AND r_i60_inq_retpymt_count12_i <= 2.5 => -0.0124801557,
    r_i60_inq_retpymt_count12_i > 2.5       => final_score_81_c563,
    r_i60_inq_retpymt_count12_i = NULL      => -0.0153352200,
             -0.0153352200);

final_score_81_c561 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 21.5 => final_score_81_c562,
    k_inq_per_ssn_i > 21.5            => 0.0746335286,
    k_inq_per_ssn_i = NULL            => -0.0130335226,
                        -0.0130335226);

final_score_81_c564 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 4.5 => 0.0129630683,
    f_inq_highriskcredit_count24_i > 4.5          => -0.0556559277,
    f_inq_highriskcredit_count24_i = NULL         => 0.0113096996,
                   0.0113096996);

final_score_81 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => final_score_81_c561,
    f_curraddractivephonelist_d > 0.5       => final_score_81_c564,
    f_curraddractivephonelist_d = NULL      => 0.0113999517,
             0.0022951343);

final_score_82_c568 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 11.5 => -0.0083077535,
    f_corraddrnamecount_d > 11.5                  => 0.0180131534,
    f_corraddrnamecount_d = NULL                  => -0.0023170637,
                   -0.0023170637);

final_score_82_c567 := map(
    NULL < r_d31_bk_filing_count_i AND r_d31_bk_filing_count_i <= 2.5 => final_score_82_c568,
    r_d31_bk_filing_count_i > 2.5                    => 0.0751809977,
    r_d31_bk_filing_count_i = NULL                   => -0.0017417479,
                      -0.0017417479);

final_score_82_c569 := map(
    NULL < r_i60_inq_recency_d AND r_i60_inq_recency_d <= 2 => 0.1489099249,
    r_i60_inq_recency_d > 2                => 0.0198125173,
    r_i60_inq_recency_d = NULL             => 0.0527977580,
            0.0527977580);

final_score_82_c566 := map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 8.5 => final_score_82_c567,
    f_corrrisktype_i > 8.5             => final_score_82_c569,
    f_corrrisktype_i = NULL            => -0.0007911592,
                         -0.0007911592);

final_score_82 := map(
    NULL < f_liens_rel_ft_total_amt_i AND f_liens_rel_ft_total_amt_i <= 6540.5 => final_score_82_c566,
    f_liens_rel_ft_total_amt_i > 6540.5      => -0.0795718811,
    f_liens_rel_ft_total_amt_i = NULL        => 0.0172580333,
              -0.0013232593);

final_score_83_c572 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => 0.1063981971,
    f_adl_per_email_i > 0.5              => -0.0071536876,
    f_adl_per_email_i = NULL             => 0.0619924321,
          0.0619924321);

final_score_83_c571 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 428.5 => 0.0103238346,
    f_prevaddrlenofres_d > 428.5                 => final_score_83_c572,
    f_prevaddrlenofres_d = NULL                  => 0.0120636063,
                  0.0120636063);

final_score_83_c574 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 4.5 => 0.1845393009,
    f_corraddrnamecount_d > 4.5                  => 0.0119444010,
    f_corraddrnamecount_d = NULL                 => 0.0883388649,
                  0.0883388649);

final_score_83_c573 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 1.5 => -0.0141480085,
    f_inq_communications_count24_i > 1.5          => final_score_83_c574,
    f_inq_communications_count24_i = NULL         => -0.0124159960,
                   -0.0124159960);

final_score_83 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => final_score_83_c571,
    r_i61_inq_collection_recency_d > 549          => final_score_83_c573,
    r_i61_inq_collection_recency_d = NULL         => -0.0502784020,
                   -0.0016336678);

final_score_84_c578 := map(
    NULL < f_util_add_curr_misc_n AND f_util_add_curr_misc_n <= 0.5 => -0.0711081917,
    f_util_add_curr_misc_n > 0.5                   => 0.1080361820,
    f_util_add_curr_misc_n = NULL                  => 0.0168739563,
                    0.0168739563);

final_score_84_c577 := map(
    NULL < f_util_adl_count_n AND f_util_adl_count_n <= 4.5 => final_score_84_c578,
    f_util_adl_count_n > 4.5               => 0.1301821605,
    f_util_adl_count_n = NULL              => 0.0592596179,
            0.0592596179);

final_score_84_c579 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 10.5 => 0.0185740512,
    k_inq_per_ssn_i > 10.5            => -0.0966149864,
    k_inq_per_ssn_i = NULL            => -0.0108523920,
                        -0.0108523920);

final_score_84_c576 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 9.5 => final_score_84_c577,
    f_addrs_per_ssn_i > 9.5              => final_score_84_c579,
    f_addrs_per_ssn_i = NULL             => 0.0110322816,
          0.0110322816);

final_score_84 := map(
    (Integer)r_d31_bk_chapter_n > 12               => -0.0333619007,
				r_d31_bk_chapter_n = ''            => -0.0001823356,
				NULL < (Integer)r_d31_bk_chapter_n AND (Integer)r_d31_bk_chapter_n <= 12 => final_score_84_c576,
           -0.0001587757);
	

final_score_85_c583 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.0312719857,
    r_f00_dob_score_d > 98              => -0.0055340847,
    r_f00_dob_score_d = NULL            => 0.0735829336,
         -0.0035628263);

final_score_85_c584 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 1.5 => 0.0911059300,
    k_inq_adls_per_phone_i > 1.5                   => -0.0143112647,
    k_inq_adls_per_phone_i = NULL                  => 0.0413364738,
                    0.0413364738);

final_score_85_c582 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 14.5 => final_score_85_c583,
    k_inq_per_phone_i > 14.5              => final_score_85_c584,
    k_inq_per_phone_i = NULL              => -0.0026273517,
           -0.0026273517);

final_score_85_c581 := map(
    NULL < f_srchaddrsrchcountmo_i AND f_srchaddrsrchcountmo_i <= 7.5 => final_score_85_c582,
    f_srchaddrsrchcountmo_i > 7.5                    => -0.0801812325,
    f_srchaddrsrchcountmo_i = NULL                   => -0.0033998599,
                      -0.0033998599);

final_score_85 := map(
    NULL < f_mos_foreclosure_lseen_d AND f_mos_foreclosure_lseen_d <= 51.5 => -0.0987936198,
    f_mos_foreclosure_lseen_d > 51.5                      => final_score_85_c581,
    f_mos_foreclosure_lseen_d = NULL                      => 0.0472964995,
                           -0.0037732850);

final_score_86_c588 := map(
    NULL < f_addrs_per_ssn_i AND f_addrs_per_ssn_i <= 5.5 => -0.0118528513,
    f_addrs_per_ssn_i > 5.5              => 0.0194675105,
    f_addrs_per_ssn_i = NULL             => 0.0074281266,
          0.0074281266);

final_score_86_c587 := map(
    NULL < r_i60_inq_count12_i AND r_i60_inq_count12_i <= 11.5 => final_score_86_c588,
    r_i60_inq_count12_i > 11.5                => -0.0283604562,
    r_i60_inq_count12_i = NULL                => 0.0053572799,
               0.0053572799);

final_score_86_c586 := map(
    NULL < f_inq_email_ver_count_i AND f_inq_email_ver_count_i <= 139.5 => -0.0221586881,
    f_inq_email_ver_count_i > 139.5                    => final_score_86_c587,
    f_inq_email_ver_count_i = NULL                     => 0.0255285350,
                        -0.0031301606);

final_score_86_c589 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 366 => 0.0098202294,
    r_c21_m_bureau_adl_fs_d > 366                    => 0.1523119618,
    r_c21_m_bureau_adl_fs_d = NULL                   => 0.0673784661,
                      0.0673784661);

final_score_86 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 31.5 => final_score_86_c586,
    f_bus_addr_match_count_d > 31.5                     => final_score_86_c589,
    f_bus_addr_match_count_d = NULL                     => -0.0020450836,
                         -0.0020450836);

final_score_87_c592 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 0.5 => 0.1566669100,
    r_l79_adls_per_addr_c6_i > 0.5                     => 0.0016101580,
    r_l79_adls_per_addr_c6_i = NULL                    => 0.0864525317,
                        0.0864525317);

final_score_87_c591 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 1.5 => 0.0030831969,
    f_varrisktype_i > 1.5            => final_score_87_c592,
    f_varrisktype_i = NULL           => 0.0379467369,
                       0.0379467369);

final_score_87_c594 := map(
    NULL < (Integer)k_inf_contradictory_i AND (Real)k_inf_contradictory_i <= 0.5 => -0.0146876793,
    (Real)k_inf_contradictory_i > 0.5                  => -0.1235684665,
    (Integer)k_inf_contradictory_i = NULL                 => -0.0407034426,
                  -0.0407034426);

final_score_87_c593 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 8.5 => -0.0014389128,
    r_d32_criminal_count_i > 8.5                   => final_score_87_c594,
    r_d32_criminal_count_i = NULL                  => -0.0021351142,
                    -0.0021351142);

final_score_87 := map(
    NULL < f_corrssnaddrcount_d AND f_corrssnaddrcount_d <= 1.5 => final_score_87_c591,
    f_corrssnaddrcount_d > 1.5                 => final_score_87_c593,
    f_corrssnaddrcount_d = NULL                => 0.0606592643,
                -0.0006703402);

final_score_88_c599 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 8.5 => 0.0272377715,
    r_d32_criminal_count_i > 8.5                   => -0.0557049213,
    r_d32_criminal_count_i = NULL                  => 0.0215802919,
                    0.0215802919);

final_score_88_c598 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 23.5 => final_score_88_c599,
    f_bus_addr_match_count_d > 23.5                     => -0.1167713852,
    f_bus_addr_match_count_d = NULL                     => 0.0169387112,
                         0.0169387112);

final_score_88_c597 := map(
    NULL < f_srchcomponentrisktype_i AND f_srchcomponentrisktype_i <= 1.5 => -0.0056073529,
    f_srchcomponentrisktype_i > 1.5                      => final_score_88_c598,
    f_srchcomponentrisktype_i = NULL                     => -0.0026450327,
                          -0.0026450327);

final_score_88_c596 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 16.5 => final_score_88_c597,
    r_c20_email_count_i > 16.5                => -0.1032155502,
    r_c20_email_count_i = NULL                => -0.0030864032,
               -0.0030864032);

final_score_88 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 10.5 => final_score_88_c596,
    r_c18_invalid_addrs_per_adl_i > 10.5         => -0.0698136269,
    r_c18_invalid_addrs_per_adl_i = NULL         => -0.0766115043,
                  -0.0041510713);

final_score_89_c604 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 1386 => -0.0172401337,
    f_liens_rel_cj_total_amt_i > 1386      => 0.0938919763,
    f_liens_rel_cj_total_amt_i = NULL      => -0.0155102385,
            -0.0155102385);

final_score_89_c603 := map(
    NULL < r_c20_email_domain_isp_count_i AND r_c20_email_domain_isp_count_i <= 0.5 => final_score_89_c604,
    r_c20_email_domain_isp_count_i > 0.5          => 0.0080926839,
    r_c20_email_domain_isp_count_i = NULL         => -0.0031313021,
                   -0.0031313021);

final_score_89_c602 := map(
    NULL < f_mos_foreclosure_lseen_d AND f_mos_foreclosure_lseen_d <= 153.5 => 0.0802694335,
    f_mos_foreclosure_lseen_d > 153.5                      => final_score_89_c603,
    f_mos_foreclosure_lseen_d = NULL      => -0.0024672937,
                            -0.0024672937);

final_score_89_c601 := map(
    NULL < f_mos_foreclosure_lseen_d AND f_mos_foreclosure_lseen_d <= 54 => -0.0908932808,
    f_mos_foreclosure_lseen_d > 54                      => final_score_89_c602,
    f_mos_foreclosure_lseen_d = NULL                    => -0.0131827138,
                         -0.0031178239);

final_score_89 := map(
    NULL < r_l70_add_invalid_i AND r_l70_add_invalid_i <= 0.5 => final_score_89_c601,
    r_l70_add_invalid_i > 0.5                => -0.1067561645,
    r_l70_add_invalid_i = NULL               => -0.0039427823,
              -0.0039427823);

final_score_90_c607 := map(
    NULL < r_i60_inq_retpymt_recency_d AND r_i60_inq_retpymt_recency_d <= 9 => -0.1205385272,
    r_i60_inq_retpymt_recency_d > 9       => 0.0396872717,
    r_i60_inq_retpymt_recency_d = NULL                     => -0.0000208610,
                            -0.0000208610);

final_score_90_c609 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 155 => 0.0879585098,
    r_d32_mos_since_crim_ls_d > 155                      => -0.0029151971,
    r_d32_mos_since_crim_ls_d = NULL                     => 0.0235417049,
                          0.0235417049);

final_score_90_c608 := map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 5.5 => 0.1412750467,
    f_corrssnnamecount_d > 5.5                 => final_score_90_c609,
    f_corrssnnamecount_d = NULL                => 0.0511497172,
                0.0511497172);

final_score_90_c606 := map(
    NULL < r_c12_source_profile_index_d AND r_c12_source_profile_index_d <= 4.5 => final_score_90_c607,
    r_c12_source_profile_index_d > 4.5        => final_score_90_c608,
    r_c12_source_profile_index_d = NULL       => 0.0353732655,
               0.0353732655);

final_score_90 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 18 => final_score_90_c606,
    r_i61_inq_collection_recency_d > 18          => -0.0016171402,
    r_i61_inq_collection_recency_d = NULL        => 0.0197307474,
                  0.0005748110);

final_score_91_c614 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 3.5 => -0.0003093849,
    f_srchunvrfdphonecount_i > 3.5                     => -0.0555818566,
    f_srchunvrfdphonecount_i = NULL                    => -0.0009555169,
                        -0.0009555169);

final_score_91_c613 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 14.5 => final_score_91_c614,
    f_srchfraudsrchcountyr_i > 14.5                     => 0.0759930069,
    f_srchfraudsrchcountyr_i = NULL                     => -0.0002437505,
                         -0.0002437505);

final_score_91_c612 := map(
    NULL < f_srchaddrsrchcountmo_i AND f_srchaddrsrchcountmo_i <= 7.5 => final_score_91_c613,
    f_srchaddrsrchcountmo_i > 7.5                    => -0.0745289259,
    f_srchaddrsrchcountmo_i = NULL                   => -0.0009359195,
                      -0.0009359195);

final_score_91_c611 := map(
    NULL < f_mos_liens_rel_ot_lseen_d AND f_mos_liens_rel_ot_lseen_d <= 62.5 => -0.1077650187,
    f_mos_liens_rel_ot_lseen_d > 62.5      => final_score_91_c612,
    f_mos_liens_rel_ot_lseen_d = NULL      => -0.0015493627,
            -0.0015493627);

final_score_91 := map(
    NULL < f_mos_liens_rel_ot_lseen_d AND f_mos_liens_rel_ot_lseen_d <= 36 => 0.0960971524,
    f_mos_liens_rel_ot_lseen_d > 36      => final_score_91_c611,
    f_mos_liens_rel_ot_lseen_d = NULL                     => 0.0622967278,
                           -0.0007158513);

final_score_92_c619 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 133 => -0.0036779657,
    f_prevaddrageoldest_d > 133                  => 0.1349216967,
    f_prevaddrageoldest_d = NULL                 => 0.0581434665,
                  0.0581434665);

final_score_92_c618 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 41.5 => final_score_92_c619,
    f_mos_liens_unrel_cj_lseen_d > 41.5        => -0.0018695548,
    f_mos_liens_unrel_cj_lseen_d = NULL        => -0.0012262441,
                -0.0012262441);

final_score_92_c617 := map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 6.5 => final_score_92_c618,
    f_inq_collection_count24_i > 6.5      => 0.0969302507,
    f_inq_collection_count24_i = NULL                      => -0.0008492122,
                            -0.0008492122);

final_score_92_c616 := map(
    NULL < f_mos_liens_rel_cj_lseen_d AND f_mos_liens_rel_cj_lseen_d <= 47.5 => -0.0914645303,
    f_mos_liens_rel_cj_lseen_d > 47.5      => final_score_92_c617,
    f_mos_liens_rel_cj_lseen_d = NULL      => -0.0013201210,
            -0.0013201210);

final_score_92 := map(
    NULL < f_inq_communications_count24_i AND f_inq_communications_count24_i <= 7.5 => final_score_92_c616,
    f_inq_communications_count24_i > 7.5          => 0.1119820771,
    f_inq_communications_count24_i = NULL         => -0.0489975624,
                   -0.0011003212);

final_score_93_c622 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => 0.0134875685,
    (Real)f_nae_email_verd_d > 0.5               => -0.0462726090,
    (Integer)f_nae_email_verd_d = NULL              => -0.0071720460,
            -0.0071720460);

final_score_93_c621 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 40.5 => final_score_93_c622,
    f_bus_addr_match_count_d > 40.5                     => 0.1018981076,
    f_bus_addr_match_count_d = NULL                     => -0.0059608420,
                         -0.0059608420);

final_score_93_c624 := map(
    NULL < f_liens_unrel_st_total_amt_i AND f_liens_unrel_st_total_amt_i <= 1671 => -0.0252290608,
    f_liens_unrel_st_total_amt_i > 1671        => 0.1172639728,
    f_liens_unrel_st_total_amt_i = NULL        => -0.0230640194,
                -0.0230640194);

final_score_93_c623 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 18.5 => final_score_93_c624,
    k_inq_per_phone_i > 18.5              => 0.0978184409,
    k_inq_per_phone_i = NULL              => -0.0212924422,
           -0.0212924422);

final_score_93 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_93_c621,
    r_phn_cell_n > 0.5         => final_score_93_c623,
    r_phn_cell_n = NULL        => -0.0110357376,
                 -0.0110357376);

final_score_94_c626 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => -0.0214379740,
    f_srchunvrfdphonecount_i > 1.5                     => -0.1273601432,
    f_srchunvrfdphonecount_i = NULL                    => -0.0547522047,
                        -0.0547522047);

final_score_94_c629 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 28.5 => -0.0032164215,
    k_inq_per_phone_i > 28.5              => 0.0823284268,
    k_inq_per_phone_i = NULL              => -0.0028602646,
           -0.0028602646);

final_score_94_c628 := map(
    NULL < r_d31_bk_disposed_recent_count_i AND r_d31_bk_disposed_recent_count_i <= 0.5 => final_score_94_c629,
    r_d31_bk_disposed_recent_count_i > 0.5            => 0.0917598388,
    r_d31_bk_disposed_recent_count_i = NULL           => -0.0022991591,
                       -0.0022991591);

final_score_94_c627 := map(
    NULL < f_mos_liens_unrel_fc_fseen_d AND f_mos_liens_unrel_fc_fseen_d <= 230.5 => -0.1238909861,
    f_mos_liens_unrel_fc_fseen_d > 230.5        => final_score_94_c628,
    f_mos_liens_unrel_fc_fseen_d = NULL         => -0.0028563566,
                 -0.0028563566);

final_score_94 := map(
    NULL < f_mos_liens_unrel_ot_lseen_d AND f_mos_liens_unrel_ot_lseen_d <= 67.5 => final_score_94_c626,
    f_mos_liens_unrel_ot_lseen_d > 67.5        => final_score_94_c627,
    f_mos_liens_unrel_ot_lseen_d = NULL        => 0.0147916341,
                -0.0037382494);

final_score_95_c633 := map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d <= 650.5 => 0.1314284487,
    f_mos_liens_unrel_cj_fseen_d > 650.5        => 0.0316307874,
    f_mos_liens_unrel_cj_fseen_d = NULL         => 0.0421086830,
                 0.0421086830);

final_score_95_c632 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => -0.0037291114,
    r_p85_phn_disconnected_i > 0.5                     => final_score_95_c633,
    r_p85_phn_disconnected_i = NULL                    => -0.0016750925,
                        -0.0016750925);

final_score_95_c634 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 137.5 => 0.1252047536,
    f_prevaddrageoldest_d > 137.5                  => 0.0022392620,
    f_prevaddrageoldest_d = NULL                   => 0.0661425883,
                    0.0661425883);

final_score_95_c631 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => final_score_95_c632,
    k_inq_adls_per_phone_i > 2.5                   => final_score_95_c634,
    k_inq_adls_per_phone_i = NULL                  => -0.0010132549,
                    -0.0010132549);

final_score_95 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 5.5 => final_score_95_c631,
    k_inq_adls_per_phone_i > 5.5                   => -0.1070909034,
    k_inq_adls_per_phone_i = NULL                  => -0.0015443673,
                    -0.0015443673);

final_score_96_c637 := map(
    NULL < (Integer)f_nae_email_verd_d AND (Real)f_nae_email_verd_d <= 0.5 => 0.0148683605,
    (Real)f_nae_email_verd_d > 0.5               => -0.0468052542,
    (Integer)f_nae_email_verd_d = NULL              => -0.0063015916,
            -0.0063015916);

final_score_96_c636 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 10.5 => final_score_96_c637,
    r_c14_addrs_15yr_i > 10.5               => -0.0966590552,
    r_c14_addrs_15yr_i = NULL               => -0.0070535404,
             -0.0070535404);

final_score_96_c639 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 173.5 => 0.0866766235,
    f_prevaddrageoldest_d > 173.5                  => -0.0949009681,
    f_prevaddrageoldest_d = NULL                   => 0.0531448731,
                    0.0531448731);

final_score_96_c638 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 9.5 => -0.0275925356,
    f_inq_other_count24_i > 9.5                  => final_score_96_c639,
    f_inq_other_count24_i = NULL                 => -0.0222681706,
                  -0.0222681706);

final_score_96 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => final_score_96_c636,
    r_phn_cell_n > 0.5         => final_score_96_c638,
    r_phn_cell_n = NULL        => -0.0121035568,
                 -0.0121035568);

final_score_97_c644 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 1.5 => 0.0360637004,
    k_inq_per_ssn_i > 1.5            => -0.0810801968,
    k_inq_per_ssn_i = NULL           => -0.0376150404,
                       -0.0376150404);

final_score_97_c643 := map(
    NULL < f_current_count_d AND f_current_count_d <= 2.5 => final_score_97_c644,
    f_current_count_d > 2.5              => 0.0838490880,
    f_current_count_d = NULL             => -0.0041626247,
          -0.0041626247);

final_score_97_c642 := map(
    NULL < f_corrssnnamecount_d AND f_corrssnnamecount_d <= 8.5 => final_score_97_c643,
    f_corrssnnamecount_d > 8.5                 => 0.0984821664,
    f_corrssnnamecount_d = NULL                => 0.0163124518,
                0.0163124518);

final_score_97_c641 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 4.5 => 0.1349523006,
    r_i60_inq_hiriskcred_recency_d > 4.5          => final_score_97_c642,
    r_i60_inq_hiriskcred_recency_d = NULL         => 0.0315157276,
                   0.0315157276);

final_score_97 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i <= 1.5 => -0.0027853360,
    r_d33_eviction_count_i > 1.5                   => final_score_97_c641,
    r_d33_eviction_count_i = NULL                  => -0.0518000529,
                    -0.0018869336);

final_score_98_c646 := map(
    NULL < f_assocrisktype_i AND f_assocrisktype_i <= 6.5 => -0.0112789216,
    f_assocrisktype_i > 6.5              => 0.0799559776,
    f_assocrisktype_i = NULL             => -0.0101326646,
          -0.0101326646);

final_score_98_c649 := map(
    NULL < f_liens_unrel_ot_total_amt_i AND f_liens_unrel_ot_total_amt_i <= 1467.5 => 0.0273234421,
    f_liens_unrel_ot_total_amt_i > 1467.5        => -0.0737236752,
    f_liens_unrel_ot_total_amt_i = NULL          => 0.0231769615,
                  0.0231769615);

final_score_98_c648 := map(
    NULL < f_liens_rel_cj_total_amt_i AND f_liens_rel_cj_total_amt_i <= 4105.5 => final_score_98_c649,
    f_liens_rel_cj_total_amt_i > 4105.5      => -0.0884085633,
    f_liens_rel_cj_total_amt_i = NULL        => 0.0196611985,
              0.0196611985);

final_score_98_c647 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 8.5 => final_score_98_c648,
    r_d32_criminal_count_i > 8.5                   => -0.0590694105,
    r_d32_criminal_count_i = NULL                  => 0.0156230456,
                    0.0156230456);

final_score_98 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => final_score_98_c646,
    f_inq_other_count24_i > 1.5                  => final_score_98_c647,
    f_inq_other_count24_i = NULL                 => 0.0247680078,
                  -0.0042239439);

final_score_99_c654 := map(
    NULL < r_i60_inq_comm_recency_d AND r_i60_inq_comm_recency_d <= 549 => -0.0492498630,
    r_i60_inq_comm_recency_d > 549                     => 0.1394689679,
    r_i60_inq_comm_recency_d = NULL                    => 0.0831661123,
                        0.0831661123);

final_score_99_c653 := map(
    NULL < k_inq_per_ssn_i AND k_inq_per_ssn_i <= 3.5 => 0.0203941228,
    k_inq_per_ssn_i > 3.5            => final_score_99_c654,
    k_inq_per_ssn_i = NULL           => 0.0332032886,
                       0.0332032886);

final_score_99_c652 := map(
    NULL < f_bus_lname_verd_d AND f_bus_lname_verd_d <= 0.5 => 0.0031691530,
    f_bus_lname_verd_d > 0.5               => final_score_99_c653,
    f_bus_lname_verd_d = NULL              => 0.0061463857,
            0.0061463857);

final_score_99_c651 := map(
    NULL < f_inq_email_ver_count_i AND f_inq_email_ver_count_i <= 139.5 => -0.0178209415,
    f_inq_email_ver_count_i > 139.5                    => final_score_99_c652,
    f_inq_email_ver_count_i = NULL                     => -0.0013835792,
                        -0.0013835792);

final_score_99 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 220.5 => final_score_99_c651,
    f_mos_liens_rel_ot_fseen_d > 220.5      => -0.0826721733,
    f_mos_liens_rel_ot_fseen_d = NULL       => -0.0032060276,
             -0.0019092948);

final_score_100_c657 := map(
    NULL < k_inq_adls_per_addr_i AND k_inq_adls_per_addr_i <= 1.5 => -0.0157240354,
    k_inq_adls_per_addr_i > 1.5                  => 0.1262675672,
    k_inq_adls_per_addr_i = NULL                 => 0.0583585399,
                  0.0583585399);

final_score_100_c656 := map(
    NULL < f_srchaddrsrchcountday_i AND f_srchaddrsrchcountday_i <= 0.5 => -0.0012787305,
    f_srchaddrsrchcountday_i > 0.5                     => final_score_100_c657,
    f_srchaddrsrchcountday_i = NULL                    => -0.0007409101,
                        -0.0007409101);

final_score_100_c659 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 549 => -0.1016413368,
    r_i61_inq_collection_recency_d > 549          => 0.1215137943,
    r_i61_inq_collection_recency_d = NULL         => 0.0131860608,
                   0.0131860608);

final_score_100_c658 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 0.5 => 0.0261103960,
    r_p88_phn_dst_to_inp_add_i > 0.5      => final_score_100_c659,
    r_p88_phn_dst_to_inp_add_i = NULL                      => 0.0975755070,
                            0.0467084347);

final_score_100 := map(
    NULL < r_l79_adls_per_addr_curr_i AND r_l79_adls_per_addr_curr_i <= 8.5 => final_score_100_c656,
    r_l79_adls_per_addr_curr_i > 8.5      => final_score_100_c658,
    r_l79_adls_per_addr_curr_i = NULL                      => 0.0013016457,
                            0.0006214578);

final_score_101_c664 := map(
    NULL < f_componentcharrisktype_i AND f_componentcharrisktype_i <= 3.5 => 0.0658916800,
    f_componentcharrisktype_i > 3.5                      => -0.0006691037,
    f_componentcharrisktype_i = NULL                     => 0.0430185585,
                          0.0430185585);

final_score_101_c663 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 549 => final_score_101_c664,
    r_i60_inq_mortgage_recency_d > 549        => 0.0059452234,
    r_i60_inq_mortgage_recency_d = NULL       => 0.0146783646,
               0.0146783646);

final_score_101_c662 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 436.5 => final_score_101_c663,
    r_c13_curr_addr_lres_d > 436.5                   => 0.1115575061,
    r_c13_curr_addr_lres_d = NULL                    => 0.0179371415,
                      0.0179371415);

final_score_101_c661 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 3.5 => final_score_101_c662,
    r_c20_email_verification_d > 3.5      => -0.0306258751,
    r_c20_email_verification_d = NULL                      => -0.1012804894,
                            -0.0054591666);

final_score_101 := map(
    NULL < r_c20_email_domain_isp_count_i AND r_c20_email_domain_isp_count_i <= 0.5 => -0.0116757561,
    r_c20_email_domain_isp_count_i > 0.5          => final_score_101_c661,
    r_c20_email_domain_isp_count_i = NULL         => -0.0508667602,
                   -0.0086659301);

final_score_102_c669 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 61.75 => 0.1644560207,
    r_c12_source_profile_d > 61.75                   => 0.0587100076,
    r_c12_source_profile_d = NULL                    => 0.0680146509,
                      0.0680146509);

final_score_102_c668 := map(
    NULL < f_mos_liens_unrel_cj_fseen_d AND f_mos_liens_unrel_cj_fseen_d <= 229.5 => -0.0300433512,
    f_mos_liens_unrel_cj_fseen_d > 229.5        => final_score_102_c669,
    f_mos_liens_unrel_cj_fseen_d = NULL         => 0.0581564132,
                 0.0581564132);

final_score_102_c667 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 3.5 => final_score_102_c668,
    r_c20_email_verification_d > 3.5      => -0.0306272438,
    r_c20_email_verification_d = NULL                      => 0.0273830422,
                            0.0273830422);

final_score_102_c666 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 321.5 => -0.0173629934,
    r_c10_m_hdr_fs_d > 321.5             => final_score_102_c667,
    r_c10_m_hdr_fs_d = NULL              => 0.0091171485,
          0.0091171485);

final_score_102 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 549 => final_score_102_c666,
    r_i60_inq_mortgage_recency_d > 549        => -0.0022952009,
    r_i60_inq_mortgage_recency_d = NULL       => 0.0408296255,
               0.0000758113);

final_score_103_c672 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 25.5 => 0.0000836200,
    k_inq_per_phone_i > 25.5              => 0.0801975736,
    k_inq_per_phone_i = NULL              => 0.0004523107,
           0.0004523107);

final_score_103_c673 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 1.5 => 0.1277262354,
    r_d30_derog_count_i > 1.5                => 0.0028664711,
    r_d30_derog_count_i = NULL               => 0.0586980730,
              0.0586980730);

final_score_103_c671 := map(
    NULL < f_inq_other_count_week_i AND f_inq_other_count_week_i <= 0.5 => final_score_103_c672,
    f_inq_other_count_week_i > 0.5                     => final_score_103_c673,
    f_inq_other_count_week_i = NULL                    => 0.0015666720,
                        0.0015666720);

final_score_103_c674 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 2.5 => 0.0035400478,
    f_srchunvrfdphonecount_i > 2.5                     => -0.1094406897,
    f_srchunvrfdphonecount_i = NULL                    => -0.0496273581,
                        -0.0496273581);

final_score_103 := map(
    NULL < f_inq_retailpayments_cnt_week_i AND f_inq_retailpayments_cnt_week_i <= 1.5 => final_score_103_c671,
    f_inq_retailpayments_cnt_week_i > 1.5           => final_score_103_c674,
    f_inq_retailpayments_cnt_week_i = NULL          => 0.0483960120,
                     0.0007348273);

final_score_104_c678 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 1.5 => 0.0651406888,
    f_bus_addr_match_count_d > 1.5                     => -0.0417514794,
    f_bus_addr_match_count_d = NULL                    => 0.0202908281,
                        0.0202908281);

final_score_104_c677 := map(
    NULL < r_a41_prop_owner_d AND r_a41_prop_owner_d <= 0.5 => -0.0928616429,
    r_a41_prop_owner_d > 0.5               => final_score_104_c678,
    r_a41_prop_owner_d = NULL              => -0.0111404139,
            -0.0111404139);

final_score_104_c679 := map(
    NULL < f_mos_liens_unrel_cj_lseen_d AND f_mos_liens_unrel_cj_lseen_d <= 186 => 0.1369303941,
    f_mos_liens_unrel_cj_lseen_d > 186        => 0.0249832088,
    f_mos_liens_unrel_cj_lseen_d = NULL       => 0.0670205192,
               0.0670205192);

final_score_104_c676 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => final_score_104_c677,
    f_phone_ver_experian_d > 0.5                   => final_score_104_c679,
    f_phone_ver_experian_d = NULL                  => 0.0320862873,
                    0.0320862873);

final_score_104 := map(
    NULL < f_mos_liens_unrel_o_fseen_d AND f_mos_liens_unrel_o_fseen_d <= 264.5 => final_score_104_c676,
    f_mos_liens_unrel_o_fseen_d > 264.5       => -0.0039473139,
    f_mos_liens_unrel_o_fseen_d = NULL        => -0.0110625675,
               -0.0027167493);

final_score_105_c682 := map(
    NULL < f_acc_damage_amt_total_i AND f_acc_damage_amt_total_i <= 5850 => -0.0012661697,
    f_acc_damage_amt_total_i > 5850                     => -0.0961430530,
    f_acc_damage_amt_total_i = NULL                     => -0.0020111201,
                         -0.0020111201);

final_score_105_c681 := map(
    NULL < f_mos_liens_unrel_sc_fseen_d AND f_mos_liens_unrel_sc_fseen_d <= 54.5 => -0.0795213128,
    f_mos_liens_unrel_sc_fseen_d > 54.5        => final_score_105_c682,
    f_mos_liens_unrel_sc_fseen_d = NULL        => -0.0025309981,
                -0.0025309981);

final_score_105_c684 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 5.5 => 0.0940213417,
    f_historical_count_d > 5.5                 => -0.0194601666,
    f_historical_count_d = NULL                => 0.0607840799,
                0.0607840799);

final_score_105_c683 := map(
    NULL < f_m_bureau_adl_fs_all_d AND f_m_bureau_adl_fs_all_d <= 159.5 => -0.0437778216,
    f_m_bureau_adl_fs_all_d > 159.5                    => final_score_105_c684,
    f_m_bureau_adl_fs_all_d = NULL                     => 0.0365768230,
                        0.0365768230);

final_score_105 := map(
    NULL < r_i60_inq_comm_count12_i AND r_i60_inq_comm_count12_i <= 1.5 => final_score_105_c681,
    r_i60_inq_comm_count12_i > 1.5                     => final_score_105_c683,
    r_i60_inq_comm_count12_i = NULL                    => 0.0603387665,
                        -0.0013231820);

final_score_106_c689 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 368.5 => 0.0851108065,
    r_c10_m_hdr_fs_d > 368.5             => -0.0496233149,
    r_c10_m_hdr_fs_d = NULL              => 0.0056780036,
          0.0056780036);

final_score_106_c688 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 244.5 => final_score_106_c689,
    r_c13_max_lres_d > 244.5             => 0.1021481238,
    r_c13_max_lres_d = NULL              => 0.0651080203,
          0.0651080203);

final_score_106_c687 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_106_c688,
    f_adl_per_email_i > 0.5              => -0.0284054234,
    f_adl_per_email_i = NULL             => 0.0371290984,
          0.0371290984);

final_score_106_c686 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 82.25 => 0.0091541406,
    r_c12_source_profile_d > 82.25                   => final_score_106_c687,
    r_c12_source_profile_d = NULL                    => 0.0116539492,
                      0.0116539492);

final_score_106 := map(
    NULL < r_s66_adlperssn_count_i AND r_s66_adlperssn_count_i <= 1.5 => -0.0069378102,
    r_s66_adlperssn_count_i > 1.5                    => final_score_106_c686,
    r_s66_adlperssn_count_i = NULL                   => 0.0013356848,
                      0.0013356848);

final_score_107_c692 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 4265 => -0.0045612802,
    f_liens_unrel_cj_total_amt_i > 4265        => -0.0337437540,
    f_liens_unrel_cj_total_amt_i = NULL        => -0.0416110701,
                -0.0058925285);

final_score_107_c693 := map(
    NULL < f_assocsuspicousidcount_i AND f_assocsuspicousidcount_i <= 3.5 => 0.0185140457,
    f_assocsuspicousidcount_i > 3.5                      => 0.1298875187,
    f_assocsuspicousidcount_i = NULL                     => 0.0253284838,
                          0.0253284838);

final_score_107_c691 := map(
    NULL < f_bus_phone_match_d AND f_bus_phone_match_d <= 0.5 => final_score_107_c692,
    f_bus_phone_match_d > 0.5                => final_score_107_c693,
    f_bus_phone_match_d = NULL               => -0.0033800259,
              -0.0033800259);

final_score_107_c694 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.1776756223,
    f_phone_ver_experian_d > 0.5                   => 0.0132400820,
    f_phone_ver_experian_d = NULL                  => 0.0803297824,
                    0.0803297824);

final_score_107 := map(
    NULL < (Integer)f_nae_contradictory_i AND (Real)f_nae_contradictory_i <= 0.5 => final_score_107_c691,
    (Real)f_nae_contradictory_i > 0.5                  => final_score_107_c694,
    (Integer)f_nae_contradictory_i = NULL                 => -0.0025424837,
                  -0.0025424837);

final_score_108_c696 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 33.5 => -0.0017879747,
    f_inq_count24_i > 33.5            => -0.0790556291,
    f_inq_count24_i = NULL            => -0.0778419388,
                        -0.0029930059);

final_score_108_c699 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 4.5 => 0.0690644152,
    f_srchfraudsrchcountyr_i > 4.5                     => 0.1540600876,
    f_srchfraudsrchcountyr_i = NULL                    => 0.1092990530,
                        0.1092990530);

final_score_108_c698 := map(
    NULL < r_i61_inq_collection_recency_d AND r_i61_inq_collection_recency_d <= 61.5 => -0.0143247194,
    r_i61_inq_collection_recency_d > 61.5          => final_score_108_c699,
    r_i61_inq_collection_recency_d = NULL          => 0.0773086909,
                    0.0773086909);

final_score_108_c697 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 0.5 => -0.0533109128,
    r_c18_invalid_addrs_per_adl_i > 0.5         => final_score_108_c698,
    r_c18_invalid_addrs_per_adl_i = NULL        => 0.0462919957,
                 0.0462919957);

final_score_108 := map(
    NULL < k_inq_lnames_per_ssn_i AND k_inq_lnames_per_ssn_i <= 1.5 => final_score_108_c696,
    k_inq_lnames_per_ssn_i > 1.5                   => final_score_108_c697,
    k_inq_lnames_per_ssn_i = NULL                  => -0.0018760336,
                    -0.0018760336);

final_score_109_c703 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 0.5 => 0.1575320386,
    r_d32_criminal_count_i > 0.5                   => 0.0299801834,
    r_d32_criminal_count_i = NULL                  => 0.1050638996,
                    0.1050638996);

final_score_109_c702 := map(
    NULL < r_c20_email_domain_free_count_i AND r_c20_email_domain_free_count_i <= 3.5 => final_score_109_c703,
    r_c20_email_domain_free_count_i > 3.5           => -0.0896770483,
    r_c20_email_domain_free_count_i = NULL          => 0.0436165131,
                     0.0436165131);

final_score_109_c701 := map(
    NULL < f_srchaddrsrchcountmo_i AND f_srchaddrsrchcountmo_i <= 3.5 => 0.0011757752,
    f_srchaddrsrchcountmo_i > 3.5                    => final_score_109_c702,
    f_srchaddrsrchcountmo_i = NULL                   => 0.0304099216,
                      0.0020116941);

final_score_109_c704 := map(
    NULL < r_c21_m_bureau_adl_fs_d AND r_c21_m_bureau_adl_fs_d <= 257.5 => 0.0027764755,
    r_c21_m_bureau_adl_fs_d > 257.5                    => -0.0968970610,
    r_c21_m_bureau_adl_fs_d = NULL                     => -0.0472165209,
                        -0.0472165209);

final_score_109 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 18.5 => final_score_109_c701,
    k_inq_per_addr_i > 18.5             => final_score_109_c704,
    k_inq_per_addr_i = NULL             => 0.0008212005,
         0.0008212005);

final_score_110_c706 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 8.5 => 0.0007338932,
    f_inq_highriskcredit_count24_i > 8.5          => -0.0768471211,
    f_inq_highriskcredit_count24_i = NULL         => -0.0421465236,
                   -0.0003006956);

final_score_110_c709 := map(
    NULL < k_inq_per_addr_i AND k_inq_per_addr_i <= 1.5 => 0.1682518206,
    k_inq_per_addr_i > 1.5             => 0.0405991625,
    k_inq_per_addr_i = NULL            => 0.1023992589,
                         0.1023992589);

final_score_110_c708 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_110_c709,
    r_c20_email_verification_d > 0.5      => 0.0517833926,
    r_c20_email_verification_d = NULL                      => 0.0800028579,
                            0.0800028579);

final_score_110_c707 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 219 => final_score_110_c708,
    r_c13_max_lres_d > 219             => -0.0076511322,
    r_c13_max_lres_d = NULL            => 0.0283774651,
                         0.0283774651);

final_score_110 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => final_score_110_c706,
    r_p85_phn_disconnected_i > 0.5                     => final_score_110_c707,
    r_p85_phn_disconnected_i = NULL                    => 0.0009242345,
                        0.0009242345);

final_score_111_c714 := map(
    NULL < f_srchfraudsrchcountmo_i AND f_srchfraudsrchcountmo_i <= 4.5 => 0.0683560838,
    f_srchfraudsrchcountmo_i > 4.5                     => -0.0325767917,
    f_srchfraudsrchcountmo_i = NULL                    => 0.0511580240,
                        0.0511580240);

final_score_111_c713 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 2.5 => final_score_111_c714,
    r_l79_adls_per_addr_c6_i > 2.5                     => -0.0664155389,
    r_l79_adls_per_addr_c6_i = NULL                    => 0.0347655561,
                        0.0347655561);

final_score_111_c712 := map(
    NULL < r_d33_eviction_count_i AND r_d33_eviction_count_i <= 1.5 => -0.0009327248,
    r_d33_eviction_count_i > 1.5                   => final_score_111_c713,
    r_d33_eviction_count_i = NULL                  => 0.0002120859,
                    0.0002120859);

final_score_111_c711 := map(
    NULL < f_mos_liens_rel_ot_fseen_d AND f_mos_liens_rel_ot_fseen_d <= 218.5 => final_score_111_c712,
    f_mos_liens_rel_ot_fseen_d > 218.5      => -0.0821599955,
    f_mos_liens_rel_ot_fseen_d = NULL       => 0.0703508105,
             0.0000089566);

final_score_111 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 5.5 => final_score_111_c711,
    k_inq_adls_per_phone_i > 5.5                   => -0.0883994149,
    k_inq_adls_per_phone_i = NULL                  => -0.0004135045,
                    -0.0004135045);

final_score_112_c719 := map(
    NULL < r_i60_inq_hiriskcred_count12_i AND r_i60_inq_hiriskcred_count12_i <= 1.5 => 0.0389108919,
    r_i60_inq_hiriskcred_count12_i > 1.5          => -0.0736977561,
    r_i60_inq_hiriskcred_count12_i = NULL         => 0.0318343921,
                   0.0318343921);

final_score_112_c718 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => final_score_112_c719,
    f_adl_per_email_i > 0.5              => -0.0451191882,
    f_adl_per_email_i = NULL             => -0.1013464789,
          -0.0009173662);

final_score_112_c717 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 2.5 => final_score_112_c718,
    r_d32_criminal_count_i > 2.5                   => -0.0432856922,
    r_d32_criminal_count_i = NULL                  => -0.0041924442,
                    -0.0041924442);

final_score_112_c716 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 2.5 => -0.0046716544,
    f_bus_addr_match_count_d > 2.5                     => final_score_112_c717,
    f_bus_addr_match_count_d = NULL                    => -0.0045742999,
                        -0.0045742999);

final_score_112 := map(
    NULL < f_liens_unrel_st_total_amt_i AND f_liens_unrel_st_total_amt_i <= 6818 => final_score_112_c716,
    f_liens_unrel_st_total_amt_i > 6818        => 0.0883182508,
    f_liens_unrel_st_total_amt_i = NULL        => 0.0240942050,
                -0.0039114948);

final_score_113_c723 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => -0.0073946822,
    f_inq_other_count24_i > 1.5                  => 0.0135469278,
    f_inq_other_count24_i = NULL                 => -0.0027767803,
                  -0.0027767803);

final_score_113_c724 := map(
    NULL < (Integer)k_inf_contradictory_i AND (Real)k_inf_contradictory_i <= 0.5 => 0.0302881622,
    (Real)k_inf_contradictory_i > 0.5                  => 0.1311938457,
    (Integer)k_inf_contradictory_i = NULL                 => 0.0492079778,
                  0.0492079778);

final_score_113_c722 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 86.8 => final_score_113_c723,
    r_c12_source_profile_d > 86.8                   => final_score_113_c724,
    r_c12_source_profile_d = NULL                   => -0.0016278577,
                     -0.0016278577);

final_score_113_c721 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 30.5 => final_score_113_c722,
    k_inq_per_phone_i > 30.5              => 0.0882841318,
    k_inq_per_phone_i = NULL              => -0.0012841837,
           -0.0012841837);

final_score_113 := map(
    NULL < r_c18_invalid_addrs_per_adl_i AND r_c18_invalid_addrs_per_adl_i <= 13.5 => final_score_113_c721,
    r_c18_invalid_addrs_per_adl_i > 13.5         => -0.1188402837,
    r_c18_invalid_addrs_per_adl_i = NULL         => -0.0724797583,
                  -0.0020443348);

final_score_114_c729 := map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 0.5 => -0.0217935114,
    f_inq_collection_count24_i > 0.5      => 0.0458760553,
    f_inq_collection_count24_i = NULL                      => -0.0165216992,
                            -0.0165216992);

final_score_114_c728 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 1.5 => final_score_114_c729,
    r_c20_email_count_i > 1.5                => 0.0083519142,
    r_c20_email_count_i = NULL               => -0.0005334420,
              -0.0005334420);

final_score_114_c727 := map(
    NULL < f_mos_foreclosure_lseen_d AND f_mos_foreclosure_lseen_d <= 52.5 => -0.0844558533,
    f_mos_foreclosure_lseen_d > 52.5                      => final_score_114_c728,
    f_mos_foreclosure_lseen_d = NULL                      => -0.0010172004,
                           -0.0010172004);

final_score_114_c726 := map(
    NULL < f_liens_unrel_st_total_amt_i AND f_liens_unrel_st_total_amt_i <= 4659.5 => final_score_114_c727,
    f_liens_unrel_st_total_amt_i > 4659.5        => -0.0951751587,
    f_liens_unrel_st_total_amt_i = NULL          => -0.0014063722,
                  -0.0014063722);

final_score_114 := map(
    NULL < f_liens_unrel_st_total_amt_i AND f_liens_unrel_st_total_amt_i <= 6662 => final_score_114_c726,
    f_liens_unrel_st_total_amt_i > 6662        => 0.0853720643,
    f_liens_unrel_st_total_amt_i = NULL        => 0.0267199922,
                -0.0008489624);

final_score_115_c731 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 4.5 => 0.0041144332,
    f_dl_addrs_per_adl_i > 4.5                 => 0.1317187871,
    f_dl_addrs_per_adl_i = NULL                => -0.0504178966,
                0.0046748984);

final_score_115_c734 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 5.5 => -0.0170608410,
    f_inq_count24_i > 5.5            => -0.0628041175,
    f_inq_count24_i = NULL           => -0.0335945554,
                       -0.0335945554);

final_score_115_c733 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => final_score_115_c734,
    r_c20_email_verification_d > 0.5      => -0.0114346387,
    r_c20_email_verification_d = NULL                      => -0.1013930659,
                            -0.0198672998);

final_score_115_c732 := map(
    NULL < f_liens_unrel_o_total_amt_i AND f_liens_unrel_o_total_amt_i <= 1144.5 => final_score_115_c733,
    f_liens_unrel_o_total_amt_i > 1144.5       => 0.0930591086,
    f_liens_unrel_o_total_amt_i = NULL         => -0.0170925532,
                -0.0170925532);

final_score_115 := map(
    NULL < f_adl_util_misc_n AND f_adl_util_misc_n <= 0.5 => final_score_115_c731,
    f_adl_util_misc_n > 0.5              => final_score_115_c732,
    f_adl_util_misc_n = NULL             => -0.0017713560,
          -0.0017713560);

final_score_116_c738 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 67.35 => 0.1350120589,
    r_c12_source_profile_d > 67.35                   => 0.0330270466,
    r_c12_source_profile_d = NULL                    => 0.0725605626,
                      0.0725605626);

final_score_116_c737 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 55.2 => -0.0124706502,
    r_c12_source_profile_d > 55.2                   => final_score_116_c738,
    r_c12_source_profile_d = NULL                   => 0.0475910795,
                     0.0475910795);

final_score_116_c736 := map(
    NULL < f_inq_collection_count24_i AND f_inq_collection_count24_i <= 1.5 => 0.0050887284,
    f_inq_collection_count24_i > 1.5      => final_score_116_c737,
    f_inq_collection_count24_i = NULL                      => 0.0068592206,
                            0.0068592206);

final_score_116_c739 := map(
    NULL < f_mos_acc_lseen_d AND f_mos_acc_lseen_d <= 13.5 => 0.0809371459,
    f_mos_acc_lseen_d > 13.5              => -0.0415563914,
    f_mos_acc_lseen_d = NULL              => -0.0343089561,
           -0.0343089561);

final_score_116 := map(
    NULL < r_c20_email_domain_free_count_i AND r_c20_email_domain_free_count_i <= 3.5 => final_score_116_c736,
    r_c20_email_domain_free_count_i > 3.5           => final_score_116_c739,
    r_c20_email_domain_free_count_i = NULL          => -0.0421260933,
                     0.0034081128);

final_score := final_score_0 +
    final_score_1 +
    final_score_2 +
    final_score_3 +
    final_score_4 +
    final_score_5 +
    final_score_6 +
    final_score_7 +
    final_score_8 +
    final_score_9 +
    final_score_10 +
    final_score_11 +
    final_score_12 +
    final_score_13 +
    final_score_14 +
    final_score_15 +
    final_score_16 +
    final_score_17 +
    final_score_18 +
    final_score_19 +
    final_score_20 +
    final_score_21 +
    final_score_22 +
    final_score_23 +
    final_score_24 +
    final_score_25 +
    final_score_26 +
    final_score_27 +
    final_score_28 +
    final_score_29 +
    final_score_30 +
    final_score_31 +
    final_score_32 +
    final_score_33 +
    final_score_34 +
    final_score_35 +
    final_score_36 +
    final_score_37 +
    final_score_38 +
    final_score_39 +
    final_score_40 +
    final_score_41 +
    final_score_42 +
    final_score_43 +
    final_score_44 +
    final_score_45 +
    final_score_46 +
    final_score_47 +
    final_score_48 +
    final_score_49 +
    final_score_50 +
    final_score_51 +
    final_score_52 +
    final_score_53 +
    final_score_54 +
    final_score_55 +
    final_score_56 +
    final_score_57 +
    final_score_58 +
    final_score_59 +
    final_score_60 +
    final_score_61 +
    final_score_62 +
    final_score_63 +
    final_score_64 +
    final_score_65 +
    final_score_66 +
    final_score_67 +
    final_score_68 +
    final_score_69 +
    final_score_70 +
    final_score_71 +
    final_score_72 +
    final_score_73 +
    final_score_74 +
    final_score_75 +
    final_score_76 +
    final_score_77 +
    final_score_78 +
    final_score_79 +
    final_score_80 +
    final_score_81 +
    final_score_82 +
    final_score_83 +
    final_score_84 +
    final_score_85 +
    final_score_86 +
    final_score_87 +
    final_score_88 +
    final_score_89 +
    final_score_90 +
    final_score_91 +
    final_score_92 +
    final_score_93 +
    final_score_94 +
    final_score_95 +
    final_score_96 +
    final_score_97 +
    final_score_98 +
    final_score_99 +
    final_score_100 +
    final_score_101 +
    final_score_102 +
    final_score_103 +
    final_score_104 +
    final_score_105 +
    final_score_106 +
    final_score_107 +
    final_score_108 +
    final_score_109 +
    final_score_110 +
    final_score_111 +
    final_score_112 +
    final_score_113 +
    final_score_114 +
    final_score_115 +
    final_score_116;

base := 700;

pts := -50;

lgt := ln(0.2067 / 0.7933);

//fp1609_2_0 := round(max((real)300, min(999, if(base + pts * (final_score - lgt) / ln(2) = NULL, -NULL, base + pts * 
fp1609_2_0 := round(max((real)300, min(999, if(base + pts * (final_score - lgt) / ln(2) = NULL, -NULL, base + pts * 

(final_score - lgt) / ln(2)))));

_ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0;

_ver_src_de := Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0;

_ver_src_eq := Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0;

_ver_src_en := Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0;

_ver_src_tn := Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0;

_ver_src_tu := Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0;

_credit_source_cnt := if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = 

NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu));

_ver_src_cnt := Models.Common.countw((   String)(ver_sources));

_bureauonly := _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_derog := felony_count > 0 OR (Integer)addrs_prison_history > 0 OR attr_num_unrel_liens60 > 0 OR attr_eviction_count > 0 

OR stl_inq_count > 0 OR inq_highriskcredit_count12 > 0 OR inq_collection_count12 >= 2;

_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0;

_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes := if((Integer)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 

0) = NULL, NULL, 
(Integer)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0));

stolenid := if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND 

nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' 
or _deceased or _ssnpriortodob, 1, 0);

manipulatedid := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9', 1, 0);

syntheticid := if(fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary 

<= 4 or _ver_src_cnt = 0 or _bureauonly or (Integer)add_curr_pop = 0, 1, 0);

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

stolenc_fp1609_2_0 := if((Boolean)stolenid, fp1609_2_0, 299);

manip2c_fp1609_2_0 := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1609_2_0, 299);

synthc_fp1609_2_0 := if((Boolean)syntheticid, fp1609_2_0, 299);

suspactc_fp1609_2_0 := if((Boolean)suspiciousactivity, fp1609_2_0, 299);

vulnvicc_fp1609_2_0 := if((Boolean)vulnerablevictim, fp1609_2_0, 299);

friendlyc_fp1609_2_0 := if((Boolean)friendlyfraud, fp1609_2_0, 299);

custstolidindex := map(
    stolenc_fp1609_2_0 = 299               => 1,
    300 <= stolenc_fp1609_2_0 AND stolenc_fp1609_2_0 <= 540 => 9,
    540 < stolenc_fp1609_2_0 AND stolenc_fp1609_2_0 <= 620  => 8,
    620 < stolenc_fp1609_2_0 AND stolenc_fp1609_2_0 <= 680  => 7,
    680 < stolenc_fp1609_2_0 AND stolenc_fp1609_2_0 <= 720  => 6,
    720 < stolenc_fp1609_2_0 AND stolenc_fp1609_2_0 <= 760  => 5,
    760 < stolenc_fp1609_2_0 AND stolenc_fp1609_2_0 <= 810  => 4,
    810 < stolenc_fp1609_2_0 AND stolenc_fp1609_2_0 <= 860  => 3,
    860 < stolenc_fp1609_2_0 AND stolenc_fp1609_2_0 <= 999  => 2,
            99);

custmanipidindex := map(
    manip2c_fp1609_2_0 = 299               => 1,
    300 <= manip2c_fp1609_2_0 AND manip2c_fp1609_2_0 <= 630 => 9,
    630 < manip2c_fp1609_2_0 AND manip2c_fp1609_2_0 <= 670  => 8,
    670 < manip2c_fp1609_2_0 AND manip2c_fp1609_2_0 <= 710  => 7,
    710 < manip2c_fp1609_2_0 AND manip2c_fp1609_2_0 <= 750  => 6,
    750 < manip2c_fp1609_2_0 AND manip2c_fp1609_2_0 <= 800  => 5,
    800 < manip2c_fp1609_2_0 AND manip2c_fp1609_2_0 <= 840  => 4,
    840 < manip2c_fp1609_2_0 AND manip2c_fp1609_2_0 <= 870  => 3,
    870 < manip2c_fp1609_2_0 AND manip2c_fp1609_2_0 <= 999  => 2,
            99);

custsynthidindex := map(
    synthc_fp1609_2_0 = 299              => 1,
    300 <= synthc_fp1609_2_0 AND synthc_fp1609_2_0 <= 700 => 9,
    700 < synthc_fp1609_2_0 AND synthc_fp1609_2_0 <= 740  => 8,
    740 < synthc_fp1609_2_0 AND synthc_fp1609_2_0 <= 760  => 7,
    760 < synthc_fp1609_2_0 AND synthc_fp1609_2_0 <= 780  => 6,
    780 < synthc_fp1609_2_0 AND synthc_fp1609_2_0 <= 820  => 5,
    820 < synthc_fp1609_2_0 AND synthc_fp1609_2_0 <= 860  => 4,
    860 < synthc_fp1609_2_0 AND synthc_fp1609_2_0 <= 900  => 3,
    900 < synthc_fp1609_2_0 AND synthc_fp1609_2_0 <= 999  => 2,
          99);

custsuspactindex := map(
    suspactc_fp1609_2_0 = 299                => 1,
    300 <= suspactc_fp1609_2_0 AND suspactc_fp1609_2_0 <= 560 => 9,
    560 < suspactc_fp1609_2_0 AND suspactc_fp1609_2_0 <= 600  => 8,
    600 < suspactc_fp1609_2_0 AND suspactc_fp1609_2_0 <= 640  => 7,
    640 < suspactc_fp1609_2_0 AND suspactc_fp1609_2_0 <= 680  => 6,
    680 < suspactc_fp1609_2_0 AND suspactc_fp1609_2_0 <= 720  => 5,
    720 < suspactc_fp1609_2_0 AND suspactc_fp1609_2_0 <= 780  => 4,
    780 < suspactc_fp1609_2_0 AND suspactc_fp1609_2_0 <= 860  => 3,
    860 < suspactc_fp1609_2_0 AND suspactc_fp1609_2_0 <= 999  => 2,
              99);

custvulnvicindex := map(
    vulnvicc_fp1609_2_0 = 299                => 1,
    300 <= vulnvicc_fp1609_2_0 AND vulnvicc_fp1609_2_0 <= 570 => 9,
    570 < vulnvicc_fp1609_2_0 AND vulnvicc_fp1609_2_0 <= 660  => 8,
    660 < vulnvicc_fp1609_2_0 AND vulnvicc_fp1609_2_0 <= 700  => 7,
    700 < vulnvicc_fp1609_2_0 AND vulnvicc_fp1609_2_0 <= 740  => 6,
    740 < vulnvicc_fp1609_2_0 AND vulnvicc_fp1609_2_0 <= 810  => 5,
    810 < vulnvicc_fp1609_2_0 AND vulnvicc_fp1609_2_0 <= 870  => 4,
    870 < vulnvicc_fp1609_2_0 AND vulnvicc_fp1609_2_0 <= 920  => 3,
    920 < vulnvicc_fp1609_2_0 AND vulnvicc_fp1609_2_0 <= 999  => 2,
              99);

custfriendfrdindex := map(
    friendlyc_fp1609_2_0 = 299                 => 1,
    300 <= friendlyc_fp1609_2_0 AND friendlyc_fp1609_2_0 <= 560 => 9,
    560 < friendlyc_fp1609_2_0 AND friendlyc_fp1609_2_0 <= 590  => 8,
    590 < friendlyc_fp1609_2_0 AND friendlyc_fp1609_2_0 <= 630  => 7,
    630 < friendlyc_fp1609_2_0 AND friendlyc_fp1609_2_0 <= 670  => 6,
    670 < friendlyc_fp1609_2_0 AND friendlyc_fp1609_2_0 <= 720  => 5,
    720 < friendlyc_fp1609_2_0 AND friendlyc_fp1609_2_0 <= 770  => 4,
    770 < friendlyc_fp1609_2_0 AND friendlyc_fp1609_2_0 <= 870  => 3,
    870 < friendlyc_fp1609_2_0 AND friendlyc_fp1609_2_0 <= 999  => 2,
                99);
																

																

	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
   self.sysdate         								 := sysdate;
   self.k_nap_phn_verd_d                 := k_nap_phn_verd_d;
   self.k_inf_addr_verd_d                := k_inf_addr_verd_d;
   self.k_inf_fname_verd_d               := k_inf_fname_verd_d;
   self.k_inf_contradictory_i            := k_inf_contradictory_i;
   self.r_p88_phn_dst_to_inp_add_i       := r_p88_phn_dst_to_inp_add_i;
   self.r_p85_phn_not_issued_i           := r_p85_phn_not_issued_i;
   self.r_p85_phn_disconnected_i         := r_p85_phn_disconnected_i;
   self.r_phn_cell_n    								 := r_phn_cell_n;
   self.r_l70_add_invalid_i              := r_l70_add_invalid_i;
   self.r_l77_apartment_i                := r_l77_apartment_i;
   self.r_f00_dob_score_d                := r_f00_dob_score_d;
   self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
   self.r_d30_derog_count_i              := r_d30_derog_count_i;
   self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
   self.r_d32_felony_count_i             := r_d32_felony_count_i;
   self._criminal_last_date              := _criminal_last_date;
   self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
   self._felony_last_date                := _felony_last_date;
   self.r_d32_mos_since_fel_ls_d         := r_d32_mos_since_fel_ls_d;
   self.r_d31_mostrec_bk_i               := r_d31_mostrec_bk_i;
   self.r_d31_bk_filing_count_i          := r_d31_bk_filing_count_i;
   self.r_d31_bk_disposed_recent_count_i := r_d31_bk_disposed_recent_count_i;
   self.r_d33_eviction_count_i           := r_d33_eviction_count_i;
   self.r_d34_unrel_liens_ct_i           := r_d34_unrel_liens_ct_i;
   self.r_d34_unrel_lien60_count_i       := r_d34_unrel_lien60_count_i;
   self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
   self.r_c21_m_bureau_adl_fs_d          := r_c21_m_bureau_adl_fs_d;
   self._src_bureau_adl_fseen_all        := _src_bureau_adl_fseen_all;
   self.f_m_bureau_adl_fs_all_d          := f_m_bureau_adl_fs_all_d;
   self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
   self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
   self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
   self.bureau_adl_en_fseen_pos          := bureau_adl_en_fseen_pos;
   self.bureau_adl_fseen_en              := bureau_adl_fseen_en;
   self._bureau_adl_fseen_en             := _bureau_adl_fseen_en;
   self.bureau_adl_ts_fseen_pos          := bureau_adl_ts_fseen_pos;
   self.bureau_adl_fseen_ts              := bureau_adl_fseen_ts;
   self._bureau_adl_fseen_ts             := _bureau_adl_fseen_ts;
   self.bureau_adl_tu_fseen_pos          := bureau_adl_tu_fseen_pos;
   self.bureau_adl_fseen_tu              := bureau_adl_fseen_tu;
   self._bureau_adl_fseen_tu             := _bureau_adl_fseen_tu;
   self.bureau_adl_tn_fseen_pos          := bureau_adl_tn_fseen_pos;
   self.bureau_adl_fseen_tn              := bureau_adl_fseen_tn;
   self._bureau_adl_fseen_tn             := _bureau_adl_fseen_tn;
   self._src_bureau_adl_fseen_notu       := _src_bureau_adl_fseen_notu;
   self.f_m_bureau_adl_fs_notu_d         := f_m_bureau_adl_fs_notu_d;
   self._header_first_seen               := _header_first_seen;
   self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
   self.r_c12_num_nonderogs_d            := r_c12_num_nonderogs_d;
   self.r_s66_adlperssn_count_i          := r_s66_adlperssn_count_i;
   self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
   self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
   self.r_c13_max_lres_d                 := r_c13_max_lres_d;
   self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
   self.r_a41_prop_owner_d               := r_a41_prop_owner_d;
   self.r_c20_email_count_i              := r_c20_email_count_i;
   self.r_c20_email_domain_free_count_i  := r_c20_email_domain_free_count_i;
   self.r_c20_email_domain_isp_count_i   := r_c20_email_domain_isp_count_i;
   self.r_l79_adls_per_addr_curr_i       := r_l79_adls_per_addr_curr_i;
   self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
   self.r_c18_invalid_addrs_per_adl_i    := r_c18_invalid_addrs_per_adl_i;
   self.r_i60_inq_count12_i              := r_i60_inq_count12_i;
   self.r_i60_inq_recency_d              := r_i60_inq_recency_d;
   self.r_i61_inq_collection_count12_i   := r_i61_inq_collection_count12_i;
   self.r_i61_inq_collection_recency_d   := r_i61_inq_collection_recency_d;
   self.r_i60_inq_banking_recency_d      := r_i60_inq_banking_recency_d;
   self.r_i60_inq_mortgage_recency_d     := r_i60_inq_mortgage_recency_d;
   self.r_i60_inq_hiriskcred_count12_i   := r_i60_inq_hiriskcred_count12_i;
   self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
   self.r_i60_inq_retail_recency_d       := r_i60_inq_retail_recency_d;
   self.r_i60_inq_comm_count12_i         := r_i60_inq_comm_count12_i;
   self.r_i60_inq_comm_recency_d         := r_i60_inq_comm_recency_d;
   self.f_bus_addr_match_count_d         := f_bus_addr_match_count_d;
   self.f_bus_lname_verd_d               := f_bus_lname_verd_d;
   self.f_bus_name_nover_i               := f_bus_name_nover_i;
   self.f_bus_phone_match_d              := f_bus_phone_match_d;
   self.f_adl_util_misc_n                := f_adl_util_misc_n;
   self.f_util_adl_count_n               := f_util_adl_count_n;
   self.f_util_add_curr_misc_n           := f_util_add_curr_misc_n;
   self.f_inq_count24_i                  := f_inq_count24_i;
   self.f_inq_auto_count24_i             := f_inq_auto_count24_i;
   self.f_inq_collection_count24_i       := f_inq_collection_count24_i;
   self.f_inq_communications_count24_i   := f_inq_communications_count24_i;
   self.f_inq_highriskcredit_count24_i   := f_inq_highriskcredit_count24_i;
   self.f_inq_other_count24_i            := f_inq_other_count24_i;
   self.k_inq_per_ssn_i                  := k_inq_per_ssn_i;
   self.k_inq_lnames_per_ssn_i           := k_inq_lnames_per_ssn_i;
   self.k_inq_addrs_per_ssn_i            := k_inq_addrs_per_ssn_i;
   self.k_inq_per_addr_i                 := k_inq_per_addr_i;
   self.k_inq_adls_per_addr_i            := k_inq_adls_per_addr_i;
   self.k_inq_lnames_per_addr_i          := k_inq_lnames_per_addr_i;
   self.k_inq_ssns_per_addr_i            := k_inq_ssns_per_addr_i;
   self.k_inq_per_phone_i                := k_inq_per_phone_i;
   self.k_inq_adls_per_phone_i           := k_inq_adls_per_phone_i;
   self._liens_unrel_cj_first_seen       := _liens_unrel_cj_first_seen;
   self.f_mos_liens_unrel_cj_fseen_d     := f_mos_liens_unrel_cj_fseen_d;
   self._liens_unrel_cj_last_seen        := _liens_unrel_cj_last_seen;
   self.f_mos_liens_unrel_cj_lseen_d     := f_mos_liens_unrel_cj_lseen_d;
   self.f_liens_unrel_cj_total_amt_i     := f_liens_unrel_cj_total_amt_i;
   self._liens_rel_cj_first_seen         := _liens_rel_cj_first_seen;
   self.f_mos_liens_rel_cj_fseen_d       := f_mos_liens_rel_cj_fseen_d;
   self._liens_rel_cj_last_seen          := _liens_rel_cj_last_seen;
   self.f_mos_liens_rel_cj_lseen_d       := f_mos_liens_rel_cj_lseen_d;
   self.f_liens_rel_cj_total_amt_i       := f_liens_rel_cj_total_amt_i;
   self._liens_unrel_ft_last_seen        := _liens_unrel_ft_last_seen;
   self.f_mos_liens_unrel_ft_lseen_d     := f_mos_liens_unrel_ft_lseen_d;
   self.f_liens_rel_ft_total_amt_i       := f_liens_rel_ft_total_amt_i;
   self._liens_unrel_fc_first_seen       := _liens_unrel_fc_first_seen;
   self.f_mos_liens_unrel_fc_fseen_d     := f_mos_liens_unrel_fc_fseen_d;
   self.f_liens_unrel_fc_total_amt_i     := f_liens_unrel_fc_total_amt_i;
   self._liens_unrel_o_first_seen        := _liens_unrel_o_first_seen;
   self.f_mos_liens_unrel_o_fseen_d      := f_mos_liens_unrel_o_fseen_d;
   self.f_liens_unrel_o_total_amt_i      := f_liens_unrel_o_total_amt_i;
   self._liens_unrel_ot_first_seen       := _liens_unrel_ot_first_seen;
   self.f_mos_liens_unrel_ot_fseen_d     := f_mos_liens_unrel_ot_fseen_d;
   self._liens_unrel_ot_last_seen        := _liens_unrel_ot_last_seen;
   self.f_mos_liens_unrel_ot_lseen_d     := f_mos_liens_unrel_ot_lseen_d;
   self.f_liens_unrel_ot_total_amt_i     := f_liens_unrel_ot_total_amt_i;
   self._liens_rel_ot_first_seen         := _liens_rel_ot_first_seen;
   self.f_mos_liens_rel_ot_fseen_d       := f_mos_liens_rel_ot_fseen_d;
   self._liens_rel_ot_last_seen          := _liens_rel_ot_last_seen;
   self.f_mos_liens_rel_ot_lseen_d       := f_mos_liens_rel_ot_lseen_d;
   self._liens_unrel_sc_first_seen       := _liens_unrel_sc_first_seen;
   self.f_mos_liens_unrel_sc_fseen_d     := f_mos_liens_unrel_sc_fseen_d;
   self.f_liens_unrel_sc_total_amt_i     := f_liens_unrel_sc_total_amt_i;
   self._foreclosure_last_date           := _foreclosure_last_date;
   self.f_mos_foreclosure_lseen_d        := f_mos_foreclosure_lseen_d;
   self.f_current_count_d                := f_current_count_d;
   self.f_historical_count_d             := f_historical_count_d;
   self.f_acc_damage_amt_total_i         := f_acc_damage_amt_total_i;
   self._acc_last_seen                   := _acc_last_seen;
   self.f_mos_acc_lseen_d                := f_mos_acc_lseen_d;
   self.f_accident_recency_d             := f_accident_recency_d;
   self.f_idrisktype_i                   := f_idrisktype_i;
   self.f_idverrisktype_i                := f_idverrisktype_i;
   self.f_varrisktype_i                  := f_varrisktype_i;
   self.f_vardobcountnew_i               := f_vardobcountnew_i;
   self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
   self.f_srchcountwk_i                  := f_srchcountwk_i;
   self.f_srchunvrfdaddrcount_i          := f_srchunvrfdaddrcount_i;
   self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
   self.f_srchfraudsrchcountyr_i         := f_srchfraudsrchcountyr_i;
   self.f_srchfraudsrchcountmo_i         := f_srchfraudsrchcountmo_i;
   self.f_srchfraudsrchcountwk_i         := f_srchfraudsrchcountwk_i;
   self.f_assocrisktype_i                := f_assocrisktype_i;
   self.f_assocsuspicousidcount_i        := f_assocsuspicousidcount_i;
   self.f_corrrisktype_i                 := f_corrrisktype_i;
   self.f_corrssnnamecount_d             := f_corrssnnamecount_d;
   self.f_corrssnaddrcount_d             := f_corrssnaddrcount_d;
   self.f_corraddrnamecount_d            := f_corraddrnamecount_d;
   self.f_corraddrphonecount_d           := f_corraddrphonecount_d;
   self.f_corrphonelastnamecount_d       := f_corrphonelastnamecount_d;
   self.f_divrisktype_i                  := f_divrisktype_i;
   self.f_divssnidmsrcurelcount_i        := f_divssnidmsrcurelcount_i;
   self.f_srchcomponentrisktype_i        := f_srchcomponentrisktype_i;
   self.f_srchssnsrchcountmo_i           := f_srchssnsrchcountmo_i;
   self.f_srchaddrsrchcountmo_i          := f_srchaddrsrchcountmo_i;
   self.f_srchaddrsrchcountday_i         := f_srchaddrsrchcountday_i;
   self.f_componentcharrisktype_i        := f_componentcharrisktype_i;
   self.f_curraddractivephonelist_d      := f_curraddractivephonelist_d;
   self.f_prevaddrageoldest_d            := f_prevaddrageoldest_d;
   self.f_prevaddrlenofres_d             := f_prevaddrlenofres_d;
   self.r_d31_all_bk_i                   := r_d31_all_bk_i;
   self.r_d31_bk_chapter_n               := r_d31_bk_chapter_n;
   self.r_c12_source_profile_d           := r_c12_source_profile_d;
   self.r_c12_source_profile_index_d     := r_c12_source_profile_index_d;
   self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
   self.r_e57_br_source_count_d          := r_e57_br_source_count_d;
   self.r_i60_inq_prepaidcards_recency_d := r_i60_inq_prepaidcards_recency_d;
   self.r_i60_inq_retpymt_count12_i      := r_i60_inq_retpymt_count12_i;
   self.r_i60_inq_retpymt_recency_d      := r_i60_inq_retpymt_recency_d;
   self.f_phone_ver_insurance_d          := f_phone_ver_insurance_d;
   self.f_phone_ver_experian_d           := f_phone_ver_experian_d;
   self.f_addrs_per_ssn_i                := f_addrs_per_ssn_i;
   self.f_phones_per_addr_curr_i         := f_phones_per_addr_curr_i;
   self.f_addrs_per_ssn_c6_i             := f_addrs_per_ssn_c6_i;
   self.f_dl_addrs_per_adl_i             := f_dl_addrs_per_adl_i;
   self.f_inq_email_ver_count_i          := f_inq_email_ver_count_i;
   self.f_inq_other_count_week_i         := f_inq_other_count_week_i;
   self.f_inq_retailpayments_cnt_week_i  := f_inq_retailpayments_cnt_week_i;
   self.f_inq_retailpayments_count24_i   := f_inq_retailpayments_count24_i;
   self.f_nae_email_verd_d               := f_nae_email_verd_d;
   self.f_nae_lname_verd_d               := f_nae_lname_verd_d;
   self.f_nae_contradictory_i            := f_nae_contradictory_i;
   self.f_adl_per_email_i                := f_adl_per_email_i;
   self.r_c20_email_verification_d       := r_c20_email_verification_d;
   self._liens_unrel_st_first_seen       := _liens_unrel_st_first_seen;
   self.f_mos_liens_unrel_st_fseen_d     := f_mos_liens_unrel_st_fseen_d;
   self._liens_unrel_st_last_seen        := _liens_unrel_st_last_seen;
   self.f_mos_liens_unrel_st_lseen_d     := f_mos_liens_unrel_st_lseen_d;
   self.f_liens_unrel_st_total_amt_i     := f_liens_unrel_st_total_amt_i;
   self.final_score_0   								 := final_score_0;
   self.final_score_1   								 := final_score_1;
   self.final_score_2   								 := final_score_2;
   self.final_score_3   								 := final_score_3;
   self.final_score_4   								 := final_score_4;
   self.final_score_5   								 := final_score_5;
   self.final_score_6   								 := final_score_6;
   self.final_score_7   								 := final_score_7;
   self.final_score_8   								 := final_score_8;
   self.final_score_9   								 := final_score_9;
   self.final_score_10                   := final_score_10;
   self.final_score_11                   := final_score_11;
   self.final_score_12                   := final_score_12;
   self.final_score_13                   := final_score_13;
   self.final_score_14                   := final_score_14;
   self.final_score_15                   := final_score_15;
   self.final_score_16                   := final_score_16;
   self.final_score_17                   := final_score_17;
   self.final_score_18                   := final_score_18;
   self.final_score_19                   := final_score_19;
   self.final_score_20                   := final_score_20;
   self.final_score_21                   := final_score_21;
   self.final_score_22                   := final_score_22;
   self.final_score_23                   := final_score_23;
   self.final_score_24                   := final_score_24;
   self.final_score_25                   := final_score_25;
   self.final_score_26                   := final_score_26;
   self.final_score_27                   := final_score_27;
   self.final_score_28                   := final_score_28;
   self.final_score_29                   := final_score_29;
   self.final_score_30                   := final_score_30;
   self.final_score_31                   := final_score_31;
   self.final_score_32                   := final_score_32;
   self.final_score_33                   := final_score_33;
   self.final_score_34                   := final_score_34;
   self.final_score_35                   := final_score_35;
   self.final_score_36                   := final_score_36;
   self.final_score_37                   := final_score_37;
   self.final_score_38                   := final_score_38;
   self.final_score_39                   := final_score_39;
   self.final_score_40                   := final_score_40;
   self.final_score_41                   := final_score_41;
   self.final_score_42                   := final_score_42;
   self.final_score_43                   := final_score_43;
   self.final_score_44                   := final_score_44;
   self.final_score_45                   := final_score_45;
   self.final_score_46                   := final_score_46;
   self.final_score_47                   := final_score_47;
   self.final_score_48                   := final_score_48;
   self.final_score_49                   := final_score_49;
   self.final_score_50                   := final_score_50;
   self.final_score_51                   := final_score_51;
   self.final_score_52                   := final_score_52;
   self.final_score_53                   := final_score_53;
   self.final_score_54                   := final_score_54;
   self.final_score_55                   := final_score_55;
   self.final_score_56                   := final_score_56;
   self.final_score_57                   := final_score_57;
   self.final_score_58                   := final_score_58;
   self.final_score_59                   := final_score_59;
   self.final_score_60                   := final_score_60;
   self.final_score_61                   := final_score_61;
   self.final_score_62                   := final_score_62;
   self.final_score_63                   := final_score_63;
   self.final_score_64                   := final_score_64;
   self.final_score_65                   := final_score_65;
   self.final_score_66                   := final_score_66;
   self.final_score_67                   := final_score_67;
   self.final_score_68                   := final_score_68;
   self.final_score_69                   := final_score_69;
   self.final_score_70                   := final_score_70;
   self.final_score_71                   := final_score_71;
   self.final_score_72                   := final_score_72;
   self.final_score_73                   := final_score_73;
   self.final_score_74                   := final_score_74;
   self.final_score_75                   := final_score_75;
   self.final_score_76                   := final_score_76;
   self.final_score_77                   := final_score_77;
   self.final_score_78                   := final_score_78;
   self.final_score_79                   := final_score_79;
   self.final_score_80                   := final_score_80;
   self.final_score_81                   := final_score_81;
   self.final_score_82                   := final_score_82;
   self.final_score_83                   := final_score_83;
   self.final_score_84                   := final_score_84;
   self.final_score_85                   := final_score_85;
   self.final_score_86                   := final_score_86;
   self.final_score_87                   := final_score_87;
   self.final_score_88                   := final_score_88;
   self.final_score_89                   := final_score_89;
   self.final_score_90                   := final_score_90;
   self.final_score_91                   := final_score_91;
   self.final_score_92                   := final_score_92;
   self.final_score_93                   := final_score_93;
   self.final_score_94                   := final_score_94;
   self.final_score_95                   := final_score_95;
   self.final_score_96                   := final_score_96;
   self.final_score_97                   := final_score_97;
   self.final_score_98                   := final_score_98;
   self.final_score_99                   := final_score_99;
   self.final_score_100                  := final_score_100;
   self.final_score_101                  := final_score_101;
   self.final_score_102                  := final_score_102;
   self.final_score_103                  := final_score_103;
   self.final_score_104                  := final_score_104;
   self.final_score_105                  := final_score_105;
   self.final_score_106                  := final_score_106;
   self.final_score_107                  := final_score_107;
   self.final_score_108                  := final_score_108;
   self.final_score_109                  := final_score_109;
   self.final_score_110                  := final_score_110;
   self.final_score_111                  := final_score_111;
   self.final_score_112                  := final_score_112;
   self.final_score_113                  := final_score_113;
   self.final_score_114                  := final_score_114;
   self.final_score_115                  := final_score_115;
   self.final_score_116                  := final_score_116;
   self.final_score     								 := final_score;
   self.base            								 := base;
   self.pts             								 := pts;
   self.lgt             								 := lgt;
   self.fp1609_2_0      								 := fp1609_2_0;
   self._ver_src_ds     								 := _ver_src_ds;
   self._ver_src_de     								 := _ver_src_de;
   self._ver_src_eq     								 := _ver_src_eq;
   self._ver_src_en     								 := _ver_src_en;
   self._ver_src_tn     								 := _ver_src_tn;
   self._ver_src_tu     								 := _ver_src_tu;
   self._credit_source_cnt               := _credit_source_cnt;
   self._ver_src_cnt    								 := _ver_src_cnt;
   self._bureauonly     								 := _bureauonly;
   self._derog          								 := _derog;
   self._deceased       								 := _deceased;
   self._ssnpriortodob                   := _ssnpriortodob;
   self._inputmiskeys   								 := _inputmiskeys;
   self._multiplessns   								 := _multiplessns;
   self._hh_strikes     								 := _hh_strikes;
   self.stolenid        								 := stolenid;
   self.manipulatedid   								 := manipulatedid;
   self.manipulatedidpt2                 := manipulatedidpt2;
   self.syntheticid     								 := syntheticid;
   self.suspiciousactivity               := suspiciousactivity;
   self.vulnerablevictim                 := vulnerablevictim;
   self.friendlyfraud   								 := friendlyfraud;
   self.stolenc_fp1609_2_0               := stolenc_fp1609_2_0;
   self.manip2c_fp1609_2_0               := manip2c_fp1609_2_0;
   self.synthc_fp1609_2_0                := synthc_fp1609_2_0;
   self.suspactc_fp1609_2_0              := suspactc_fp1609_2_0;
   self.vulnvicc_fp1609_2_0              := vulnvicc_fp1609_2_0;
   self.friendlyc_fp1609_2_0             := friendlyc_fp1609_2_0;
   self.custstolidindex                  := custstolidindex;
   self.custmanipidindex                 := custmanipidindex;
   self.custsynthidindex                 := custsynthidindex;
   self.custsuspactindex                 := custsuspactindex;

	 SELF.clam := le;
#end

	self.seq := le.seq;
	self.StolenIdentityIndex := (string) custstolidindex;
	self.SyntheticIdentityIndex:= (string) custsynthidindex;
	self.ManipulatedIdentityIndex:= (string) custmanipidindex;
	self.VulnerableVictimIndex := (string) custvulnvicindex;
	self.FriendlyFraudIndex                := (string) custfriendfrdindex;
	self.SuspiciousActivityIndex := (string) custsuspactindex;
	ritmp :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1609_2_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (String)FP1609_2_0;
	self := [];
END;

 model :=  project(clam, doModel(left) );

		return model;
END;