import risk_indicators, riskwise, riskwisefcra, ut, easi, Models, std;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1506_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons,
									boolean isFCRA=false) := FUNCTION
	
	FP_DEBUG := false;

	#if(FP_DEBUG)
    layout_debug := record
				integer sysdate;
				string r_d31_bk_chapter_n;
				boolean k_nap_contradictory_i;
				boolean k_inf_contradictory_i;
				real r_p88_phn_dst_to_inp_add_i;
				real r_p85_phn_not_issued_i;
				real r_p85_phn_disconnected_i;
				real r_phn_cell_n;
				real r_phn_pcs_n;
				real r_f03_input_add_not_most_rec_i;
				integer r_f00_ssn_score_d;
				integer r_f00_dob_score_d;
				integer r_f01_inp_addr_address_score_d;
				real r_l70_inp_addr_dirty_i;
				real r_f00_input_dob_match_level_d;
				real r_d30_derog_count_i;
				real r_d32_criminal_count_i;
				integer _criminal_last_date;
				real r_d32_mos_since_crim_ls_d;
				integer4 _felony_last_date;
				real r_d32_mos_since_fel_ls_d;
				real r_d31_bk_disposed_hist_count_i;
				integer4 _header_first_seen;
				real r_c10_m_hdr_fs_d;
				integer4 _in_dob;
				real yr_in_dob;
				integer yr_in_dob_int;
				real k_comb_age_d;
				real r_a44_curr_add_naprop_d;
				real r_c13_curr_addr_lres_d;
				real r_c13_max_lres_d;
				real r_c14_addrs_5yr_i;
				real r_c14_addrs_10yr_i;
				real r_c14_addrs_15yr_i;
				real r_a41_prop_owner_inp_only_d;
				real r_prop_owner_history_d;
				real r_c20_email_count_i;
				real r_c20_email_domain_free_count_i;
				real r_c20_email_domain_isp_count_i;
				real r_l79_adls_per_addr_c6_i;
				real r_a50_pb_total_dollars_d;
				real r_a50_pb_total_orders_d;
				real r_pb_order_freq_d;
				integer r_i60_inq_banking_recency_d;
				integer r_i60_inq_mortgage_recency_d;
				real r_i60_inq_hiriskcred_count12_i;
				real r_i60_inq_hiriskcred_recency_d;
				real f_bus_addr_match_count_d;
				real f_bus_phone_match_d;
				real f_add_input_mobility_index_i;
				real f_add_input_nhood_bus_pct_i;
				real f_add_input_nhood_mfd_pct_i;
				real add_input_nhood_prop_sum;
				real f_add_input_nhood_sfd_pct_d;
				real f_add_curr_mobility_index_i;
				real f_add_curr_nhood_bus_pct_i;
				real f_add_curr_nhood_mfd_pct_i;
				real add_curr_nhood_prop_sum;
				real f_add_curr_nhood_sfd_pct_d;
				real f_inq_count_i;
				real f_inq_count24_i;
				real f_inq_banking_count_i;
				real f_inq_collection_count_i;
				real f_inq_communications_count_i;
				real f_inq_highriskcredit_count_i;
				real f_inq_highriskcredit_count24_i;
				real f_inq_other_count_i;
				real f_inq_other_count24_i;
				real f_inq_retail_count_i;
				real k_inq_dobs_per_ssn_i;
				real k_inq_ssns_per_addr_i;
				real k_inq_per_phone_i;
				real k_inq_adls_per_phone_i;
				integer4 _inq_banko_cm_first_seen;
				real f_mos_inq_banko_cm_fseen_d;
				integer4 _inq_banko_cm_last_seen;
				real f_mos_inq_banko_cm_lseen_d;
				integer4 _inq_banko_om_first_seen;
				real f_mos_inq_banko_om_fseen_d;
				real f_liens_unrel_cj_total_amt_i;
				integer4 _foreclosure_last_date;
				real f_mos_foreclosure_lseen_d;
				real k_estimated_income_d;
				real r_wealth_index_d;
				real f_rel_incomeover50_count_d;
				real f_rel_homeover50_count_d;
				real f_rel_homeover200_count_d;
				real f_rel_ageover30_count_d;
				real f_rel_ageover40_count_d;
				real f_rel_ageover50_count_d;
				real f_rel_educationover12_count_d;
				real f_crim_rel_under100miles_cnt_i;
				real f_rel_under25miles_cnt_d;
				real f_rel_under100miles_cnt_d;
				real f_rel_under500miles_cnt_d;
				real f_rel_bankrupt_count_i;
				real f_rel_criminal_count_i;
				real f_historical_count_d;
				real f_idverrisktype_i;
				real f_sourcerisktype_i;
				real f_varrisktype_i;
				real f_srchvelocityrisktype_i;
				real f_srchunvrfdaddrcount_i;
				real f_srchunvrfdphonecount_i;
				real f_srchfraudsrchcount_i;
				real f_srchfraudsrchcountyr_i;
				real f_srchfraudsrchcountmo_i;
				real f_srchfraudsrchcountwk_i;
				real f_validationrisktype_i;
				real f_corrrisktype_i;
				real f_corrssnaddrcount_d;
				real f_corraddrnamecount_d;
				real f_corraddrphonecount_d;
				real f_corrphonelastnamecount_d;
				real f_divrisktype_i;
				real f_srchssnsrchcount_i;
				real f_srchssnsrchcountwk_i;
				real f_srchaddrsrchcount_i;
				real f_srchphonesrchcount_i;
				real f_srchphonesrchcountday_i;
				real f_componentcharrisktype_i;
				real f_addrchangeincomediff_d;
				real f_addrchangevaluediff_d;
				real f_addrchangecrimediff_i;
				real f_curraddractivephonelist_d;
				real f_curraddrmedianincome_d;
				real f_curraddrmedianvalue_d;
				real f_curraddrmurderindex_i;
				real f_curraddrburglaryindex_i;
				real f_prevaddrageoldest_d;
				real f_prevaddrlenofres_d;
				real f_prevaddrdwelltype_sfd_n;
				real f_prevaddroccupantowned_i;
				real f_prevaddrmedianincome_d;
				real f_prevaddrmedianvalue_d;
				real f_prevaddrcartheftindex_i;
				real f_fp_prevaddrburglaryindex_i;
				real r_c12_source_profile_d;
				real r_c12_source_profile_index_d;
				real r_c23_inp_addr_occ_index_d;
				real r_c23_inp_addr_owned_not_occ_d;
				real r_e57_br_source_count_d;
				real r_i60_inq_prepaidcards_recency_d;
				real f_phone_ver_insurance_d;
				real f_phone_ver_experian_d;
				real f_phones_per_addr_curr_i;
				real f_adls_per_phone_c6_i;
				real f_dl_addrs_per_adl_i;
				real f_inq_email_ver_count_i;
				real f_inq_other_count_week_i;
				real f_inq_prepaidcards_count_i;
				boolean f_nae_email_verd_d;
				boolean f_nae_lname_verd_d;
				boolean f_nae_nothing_found_i;
				real f_adl_per_email_i;
				real r_c20_email_verification_d;
				real f_vf_hi_risk_ct_i;
				real f_vf_altlexid_phn_hi_risk_ct_i;
				real f_vf_altlexid_addr_hi_risk_ct_i;
				real f_vf_altlexid_addr_lo_risk_ct_d;
				real f_vf_lexid_ssn_hi_risk_ct_i;
				real f_hh_members_ct_d;
				real f_property_owners_ct_d;
				real f_hh_age_18_plus_d;
				real f_hh_collections_ct_i;
				real f_hh_members_w_derog_i;
				real f_hh_bankruptcies_i;
				real f_hh_lienholders_i;
				real f_hh_college_attendees_d;
				real all4wfdn_0;
				real all4wfdn_1;
				real all4wfdn_2;
				real all4wfdn_3;
				real all4wfdn_4;
				real all4wfdn_5;
				real all4wfdn_6;
				real all4wfdn_7;
				real all4wfdn_8;
				real all4wfdn_9;
				real all4wfdn_10;
				real all4wfdn_11;
				real all4wfdn_12;
				real all4wfdn_13;
				real all4wfdn_14;
				real all4wfdn_15;
				real all4wfdn_16;
				real all4wfdn_17;
				real all4wfdn_18;
				real all4wfdn_19;
				real all4wfdn_20;
				real all4wfdn_21;
				real all4wfdn_22;
				real all4wfdn_23;
				real all4wfdn_24;
				real all4wfdn_25;
				real all4wfdn_26;
				real all4wfdn_27;
				real all4wfdn_28;
				real all4wfdn_29;
				real all4wfdn_30;
				real all4wfdn_31;
				real all4wfdn_32;
				real all4wfdn_33;
				real all4wfdn_34;
				real all4wfdn_35;
				real all4wfdn_36;
				real all4wfdn_37;
				real all4wfdn_38;
				real all4wfdn_39;
				real all4wfdn_40;
				real all4wfdn_41;
				real all4wfdn_42;
				real all4wfdn_43;
				real all4wfdn_44;
				real all4wfdn_45;
				real all4wfdn_46;
				real all4wfdn_47;
				real all4wfdn_48;
				real all4wfdn_49;
				real all4wfdn_50;
				real all4wfdn_51;
				real all4wfdn_52;
				real all4wfdn_53;
				real all4wfdn_54;
				real all4wfdn_55;
				real all4wfdn_56;
				real all4wfdn_57;
				real all4wfdn_58;
				real all4wfdn_59;
				real all4wfdn_60;
				real all4wfdn_61;
				real all4wfdn_62;
				real all4wfdn_63;
				real all4wfdn_64;
				real all4wfdn_65;
				real all4wfdn_66;
				real all4wfdn_67;
				real all4wfdn_68;
				real all4wfdn_69;
				real all4wfdn_70;
				real all4wfdn_71;
				real all4wfdn_72;
				real all4wfdn_73;
				real all4wfdn_74;
				real all4wfdn_75;
				real all4wfdn_76;
				real all4wfdn_77;
				real all4wfdn_78;
				real all4wfdn_79;
				real all4wfdn_80;
				real all4wfdn_81;
				real all4wfdn_82;
				real all4wfdn_83;
				real all4wfdn_84;
				real all4wfdn_85;
				real all4wfdn_86;
				real all4wfdn_87;
				real all4wfdn_88;
				real all4wfdn_89;
				real all4wfdn_90;
				real all4wfdn_91;
				real all4wfdn_92;
				real all4wfdn_93;
				real all4wfdn_94;
				real all4wfdn_95;
				real all4wfdn_96;
				real all4wfdn_97;
				real all4wfdn_98;
				real all4wfdn_99;
				real all4wfdn_100;
				real all4wfdn_101;
				real all4wfdn_102;
				real all4wfdn_103;
				real all4wfdn_104;
				real all4wfdn_105;
				real all4wfdn_106;
				real all4wfdn_107;
				real all4wfdn_108;
				real all4wfdn_109;
				real all4wfdn_110;
				real all4wfdn_111;
				real all4wfdn_112;
				real all4wfdn_113;
				real all4wfdn_114;
				real all4wfdn_115;
				real all4wfdn_116;
				real all4wfdn_117;
				real all4wfdn_118;
				real all4wfdn_119;
				real all4wfdn_120;
				real all4wfdn_121;
				real all4wfdn_122;
				real all4wfdn_123;
				real all4wfdn_124;
				real all4wfdn_125;
				real all4wfdn_126;
				real all4wfdn_127;
				real all4wfdn_128;
				real all4wfdn_129;
				real all4wfdn_130;
				real all4wfdn_131;
				real all4wfdn_132;
				real all4wfdn_133;
				real all4wfdn_134;
				real all4wfdn_135;
				real all4wfdn_136;
				real all4wfdn_137;
				real all4wfdn_138;
				real all4wfdn_139;
				real all4wfdn_140;
				real all4wfdn_141;
				real all4wfdn_142;
				real all4wfdn_143;
				real all4wfdn_144;
				real all4wfdn_145;
				real all4wfdn_146;
				real all4wfdn_147;
				real all4wfdn_148;
				real all4wfdn_149;
				real all4wfdn_150;
				real all4wfdn_151;
				real all4wfdn_152;
				real all4wfdn_153;
				real all4wfdn_154;
				real all4wfdn;
				integer base;
				integer pts;
				real lgt;
				real offset;
				boolean or_testfraud;
				boolean or_contrfraud;
				integer fp1506_1_0;
				models.layout_modelout;
				risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le, easi.Key_Easi_Census ri ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri ) := TRANSFORM
  #end

	tf_lexid_ct                      := le.Test_Fraud.tf_Lexid_count;
	tf_ssn_ct                        := le.Test_Fraud.tf_ssn_count;
	tf_phone_ct                      := le.Test_Fraud.tf_phone_count;
	tf_addr_ct                       := le.Test_Fraud.tf_addr_count;
	cf_lexid_ct                      := le.Contributory_Fraud.cf_Lexid_count;
	cf_ssn_ct                        := le.Contributory_Fraud.cf_ssn_count;
	cf_phone_ct                      := le.Contributory_Fraud.cf_phone_count;
	cf_addr_ct                       := le.Contributory_Fraud.cf_addr_count;
	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	combo_dobscore                   := le.iid.combo_dobscore;
	hdr_source_profile               := le.source_profile;
	hdr_source_profile_index         := le.source_profile_index;
	ver_sources                      := le.header_summary.ver_sources;
	bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
	bus_phone_match                  := le.business_header_address_summary.bus_phone_match;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	emailpop                         := le.input_validation.email;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_dirty_address          := le.address_verification.inputaddr_dirty;
	add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_occupants_1yr          := le.addr_risk_summary.occupants_1yr ;
	add_input_turnover_1yr_in        := le.addr_risk_summary.turnover_1yr_in ;
	add_input_turnover_1yr_out       := le.addr_risk_summary.turnover_1yr_out ;
	add_input_nhood_bus_ct           := le.addr_risk_summary.N_Business_Count ;
	add_input_nhood_sfd_ct           := le.addr_risk_summary.N_SFD_Count ;
	add_input_nhood_mfd_ct           := le.addr_risk_summary.N_MFD_Count;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_lres                    := le.lres2;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_occupants_1yr           := le.addr_risk_summary2.occupants_1yr ;
	add_curr_turnover_1yr_in         := le.addr_risk_summary2.turnover_1yr_in ;
	add_curr_turnover_1yr_out        := le.addr_risk_summary2.turnover_1yr_out ;
	add_curr_nhood_bus_ct            := le.addr_risk_summary2.N_Business_Count ;
	add_curr_nhood_sfd_ct            := le.addr_risk_summary2.N_SFD_Count ;
	add_curr_nhood_mfd_ct            := le.addr_risk_summary2.N_MFD_Count;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	max_lres                         := le.other_address_info.max_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	telcordia_type                   := le.phone_verification.telcordia_type;
	phone_ver_insurance              := le.insurance_phones_summary.Insurance_Phone_Verification;
	phone_ver_experian               := le.Experian_Phone_Verification;
	header_first_seen                := le.ssn_verification.header_first_seen;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	adls_per_phone_c6                := if(isFCRA, 0, le.velocity_counters.adls_per_phone_created_6months );
	dl_addrs_per_adl                 := le.velocity_counters.dl_addrs_per_adl;
	inq_email_ver_count              := le.acc_logs.inquiry_email_ver_ct;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_banking_count                := le.acc_logs.banking.counttotal;
	inq_banking_count01              := le.acc_logs.banking.count01;
	inq_banking_count03              := le.acc_logs.banking.count03;
	inq_banking_count06              := le.acc_logs.banking.count06;
	inq_banking_count12              := le.acc_logs.banking.count12;
	inq_banking_count24              := le.acc_logs.banking.count24;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_communications_count         := le.acc_logs.communications.counttotal;
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
	inq_other_count                  := le.acc_logs.other.counttotal;
	inq_other_count_week             := if(isFCRA, 0, le.acc_logs.other.countweek);
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_retail_count                 := le.acc_logs.retail.counttotal;
	inq_dobsperssn                   := if(isFCRA, 0, le.acc_logs.inquiryDOBsPerSSN );
	inq_ssnsperaddr                  := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
	inq_perphone                     := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
	inq_adlsperphone                 := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );
	inq_banko_cm_first_seen          := le.acc_logs.cm_first_seen_date;
	inq_banko_cm_last_seen           := le.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.acc_logs.om_first_seen_date;
	pb_number_of_sources             := le.ibehavior.number_of_sources;
	pb_average_days_bt_orders        := le.ibehavior.average_days_between_orders;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	email_count                      := le.email_summary.email_ct;
	email_domain_free_count          := le.email_summary.email_domain_free_ct;
	email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
	email_name_addr_verification     := le.email_summary.reverse_email.verification_level;
	email_verification               := le.email_summary.identity_email_verification_level;
	adl_per_email                    := le.email_summary.reverse_email.adls_per_email;
	attr_total_number_derogs         := le.total_number_derogs;
	vf_hi_risk_ct                    := le.virtual_fraud.hi_risk_ct;
	vf_altlexid_phone_hi_risk_ct     := le.virtual_fraud.altlexid_phone_hi_risk_ct;
	vf_altlexid_addr_hi_risk_ct      := le.virtual_fraud.altlexid_addr_hi_risk_ct;
	vf_altlexid_addr_lo_risk_ct      := le.virtual_fraud.altlexid_addr_lo_risk_ct;
	vf_lexid_ssn_hi_risk_ct          := le.virtual_fraud.lexid_ssn_hi_risk_ct;
	fp_idverrisktype                 := le.fdattributesv2.idverrisklevel;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcount            := le.fdattributesv2.searchfraudsearchcount;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_srchfraudsrchcountmo          := le.fdattributesv2.searchfraudsearchcountmonth;
	fp_srchfraudsrchcountwk          := le.fdattributesv2.searchfraudsearchcountweek;
	fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
	fp_corrrisktype                  := le.fdattributesv2.correlationrisklevel;
	fp_corrssnaddrcount              := le.fdattributesv2.correlationssnaddrcount;
	fp_corraddrnamecount             := le.fdattributesv2.correlationaddrnamecount;
	fp_corraddrphonecount            := le.fdattributesv2.correlationaddrphonecount;
	fp_corrphonelastnamecount        := le.fdattributesv2.correlationphonelastnamecount;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_srchssnsrchcount              := le.fdattributesv2.searchssnsearchcount;
	fp_srchssnsrchcountwk            := le.fdattributesv2.searchssnsearchcountweek;
	fp_srchaddrsrchcount             := le.fdattributesv2.searchaddrsearchcount;
	fp_srchphonesrchcount            := le.fdattributesv2.searchphonesearchcount;
	fp_srchphonesrchcountday         := le.fdattributesv2.searchphonesearchcountday;
	fp_componentcharrisktype         := le.fdattributesv2.componentcharrisklevel;
	fp_addrchangeincomediff          := le.fdattributesv2.addrchangeincomediff;
	fp_addrchangevaluediff           := le.fdattributesv2.addrchangevaluediff;
	fp_addrchangecrimediff           := le.fdattributesv2.addrchangecrimediff;
	fp_curraddractivephonelist       := le.fdattributesv2.curraddractivephonelist;
	fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
	fp_curraddrmurderindex           := le.fdattributesv2.curraddrmurderindex;
	fp_curraddrburglaryindex         := le.fdattributesv2.curraddrburglaryindex;
	fp_prevaddrageoldest             := le.fdattributesv2.prevaddrageoldest;
	fp_prevaddrlenofres              := le.fdattributesv2.prevaddrlenofres;
	fp_prevaddrdwelltype             := le.fdattributesv2.prevaddrdwelltype;
	fp_prevaddroccupantowned         := le.fdattributesv2.prevaddroccupantowned;
	fp_prevaddrmedianincome          := le.fdattributesv2.prevaddrmedianincome;
	fp_prevaddrmedianvalue           := le.fdattributesv2.prevaddrmedianvalue;
	fp_prevaddrcartheftindex         := le.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrburglaryindex         := le.fdattributesv2.prevaddrburglaryindex;
	bk_chapter                       := le.bjl.bk_chapter;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_last_date                 := le.bjl.last_felony_date;
	foreclosure_last_date            := le.bjl.last_foreclosure_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_property_owners_ct            := le.hhid_summary.hh_property_owners_ct;
	hh_age_65_plus                   := le.hhid_summary.hh_age_65_plus;
	hh_age_30_to_65                  := le.hhid_summary.hh_age_31_to_65;
	hh_age_18_to_30                  := le.hhid_summary.hh_age_18_to_30;
	hh_collections_ct                := le.hhid_summary.hh_collections_ct;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_bankruptcies                  := le.hhid_summary.hh_bankruptcies;
	hh_lienholders                   := le.hhid_summary.hh_lienholders;
	hh_college_attendees             := le.hhid_summary.hh_college_attendees;
	rel_count                        := le.relatives.relative_count;
	rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
	rel_criminal_count               := le.relatives.relative_criminal_count;
	crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.relatives.relative_within500miles_count;
	rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
	rel_homeunder100_count           := le.relatives.relative_homeunder100_count;
	rel_homeunder150_count           := le.relatives.relative_homeunder150_count;
	rel_homeunder200_count           := le.relatives.relative_homeunder200_count;
	rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.relatives.relative_homeover500_count;
	rel_educationover12_count        := le.relatives.relative_educationover12_count;
	rel_ageunder40_count             := le.relatives.relative_ageunder40_count;
	rel_ageunder50_count             := le.relatives.relative_ageunder50_count;
	rel_ageunder60_count             := le.relatives.relative_ageunder60_count;
	rel_ageunder70_count             := le.relatives.relative_ageunder70_count;
	rel_ageover70_count              := le.relatives.relative_ageover70_count;
	historical_count                 := le.vehicles.historical_count;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;
	
	C_INC_100K_P                     := ri.in100k_p;
	C_INC_15K_P                      := ri.in15k_p;
	C_INC_200K_P                     := ri.in200k_p;
	C_INC_201K_P                     := ri.in201k_p;
	C_INC_35K_P                      := ri.in35k_p;
	C_OWNOCC_P                       := ri.ownocp;
	C_RENTOCC_P                      := ri.rentocp;
	c_assault                        := ri.assault;
	c_bargains                       := ri.bargains;
	c_bigapt_p                       := ri.bigapt_p;
	c_blue_col                       := ri.blue_col;
	c_born_usa                       := ri.born_usa;
	c_burglary                       := ri.burglary;
	c_business                       := ri.business;
	c_cartheft                       := ri.cartheft;
	c_civ_emp                        := ri.civ_emp;
	c_construction                   := ri.construction;
	c_easiqlife                      := ri.easiqlife;
	c_employees                      := ri.employees;
	c_families                       := ri.families;
	c_fammar18_p                     := ri.fammar18_p;
	c_fammar_p                       := ri.fammar_p;
	c_famotf18_p                     := ri.famotf18_p;
	c_femdiv_p                       := ri.femdiv_p;
	c_finance                        := ri.finance;
	c_food                           := ri.food;
	c_for_sale                       := ri.for_sale;
	c_health                         := ri.health;
	c_hh00                           := ri.hh00;
	c_hh1_p                          := ri.hh1_p;
	c_hh2_p                          := ri.hh2_p;
	c_hh4_p                          := ri.hh4_p;
	c_hhsize                         := ri.hhsize;
	c_highinc                        := ri.highinc;
	c_housingcpi                     := ri.housingcpi;
	c_hval_100k_p                    := ri.hval_100k_p;
	c_hval_125k_p                    := ri.hval_125k_p;
	c_hval_150k_p                    := ri.hval_150k_p;
	c_hval_200k_p                    := ri.hval_200k_p;
	c_hval_250k_p                    := ri.hval_250k_p;
	c_hval_300k_p                    := ri.hval_300k_p;
	c_hval_400k_p                    := ri.hval_400k_p;
	c_hval_750k_p                    := ri.hval_750k_p;
	c_hval_80k_p                     := ri.hval_80k_p;
	c_lar_fam                        := ri.lar_fam;
	c_larceny                        := ri.larceny;
	c_low_ed                         := ri.low_ed;
	c_low_hval                       := ri.low_hval;
	c_lowinc                         := ri.lowinc;
	c_lowrent                        := ri.lowrent;
	c_lux_prod                       := ri.lux_prod;
	c_many_cars                      := ri.many_cars;
	c_med_age                        := ri.med_age;
	c_med_hhinc                      := ri.med_hhinc;
	c_med_rent                       := ri.med_rent;
	c_mil_emp                        := ri.mil_emp;
	c_mort_indx                      := ri.mort_indx;
	c_murders                        := ri.murders;
	c_new_homes                      := ri.new_homes;
	c_newhouse                       := ri.newhouse;
	c_no_car                         := ri.no_car;
	c_no_labfor                      := ri.no_labfor;
	c_old_homes                      := ri.old_homes;
	c_pop00                          := ri.pop00;
	c_pop_0_5_p                      := ri.pop_0_5_p;
	c_pop_12_17_p                    := ri.pop_12_17_p;
	c_pop_18_24_p                    := ri.pop_18_24_p;
	c_pop_35_44_p                    := ri.pop_35_44_p;
	c_pop_45_54_p                    := ri.pop_45_54_p;
	c_pop_55_64_p                    := ri.pop_55_64_p;
	c_pop_65_74_p                    := ri.pop_65_74_p;
	c_pop_75_84_p                    := ri.pop_75_84_p;
	c_popover18                      := ri.popover18;
	c_preschl                        := ri.preschl;
	c_professional                   := ri.professional;
	c_rape                           := ri.rape;
	c_rental                         := ri.rental;
	c_rest_indx                      := ri.rest_indx;
	c_retail                         := ri.retail;
	c_retired                        := ri.retired;
	c_retired2                       := ri.retired2;
	c_rich_asian                     := ri.rich_asian;
	c_rich_fam                       := ri.rich_fam;
	c_rich_nfam                      := ri.rich_nfam;
	c_rich_old                       := ri.rich_old;
	c_rich_wht                       := ri.rich_wht;
	c_rnt1000_p                      := ri.rnt1000_p;
	c_rnt1250_p                      := ri.rnt1250_p;
	c_rnt2001_p                      := ri.rnt2001_p;
	c_rnt250_p                       := ri.rnt250_p;
	c_rnt500_p                       := ri.rnt500_p;
	c_rnt750_p                       := ri.rnt750_p;
	c_rural_p                        := ri.rural_p;
	c_serv_empl                      := ri.serv_empl;
	c_span_lang                      := ri.span_lang;
	c_totcrime                       := ri.totcrime;
	c_totsales                       := ri.totsales;
	c_unempl                         := ri.unempl;
	c_vacant_p                       := ri.vacant_p;
	c_very_rich                      := ri.very_rich;
	c_work_home                      := ri.work_home;
	c_young                          := ri.young;

NULL := -999999999;

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

r_d31_bk_chapter_n := map(
    not(truedid)                                 => '',
    not((bk_chapter in ['7', '11', '12', '13'])) => '',
                                                    trim(bk_chapter, LEFT));

k_nap_contradictory_i := (nap_summary in [1]);

k_inf_contradictory_i := (infutor_nap in [1]);

r_p88_phn_dst_to_inp_add_i := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

r_p85_phn_not_issued_i := map(
    not(hphnpop)                 => NULL,
    (rc_pwphonezipflag in ['4']) => 1,
                                    0);

r_p85_phn_disconnected_i := map(
    not(hphnpop)                                                             => NULL,
    rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D' => 1,
                                                                                0);

r_phn_cell_n_1 := if(not(hphnpop), NULL, NULL);

r_phn_cell_n := if(rc_hriskphoneflag = '1' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '1' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '04' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '55' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '60', 1, 0);

r_phn_pcs_n := map(
    not(hphnpop)                                                                                                                                                                                                                                                                                                                                                            => NULL,
    rc_hriskphoneflag = '3' or trim(trim(rc_hphonetypeflag, LEFT), LEFT, RIGHT) = '3' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '64' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '65' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '66' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '67' or trim(trim(telcordia_type, LEFT), LEFT, RIGHT) = '68' => 1,
                                                                                                                                                                                                                                                                                                                                                                               0);

r_f03_input_add_not_most_rec_i := if(not(truedid and add_input_pop), NULL, (integer)rc_input_addr_not_most_recent);

r_f00_ssn_score_d := if(not(truedid and (integer)ssnlength > 0) or combo_ssnscore = 255, NULL, min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 999));

r_f00_dob_score_d := if(not(truedid and dobpop) or combo_dobscore = 255, NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));

r_f01_inp_addr_address_score_d := if(not(truedid and add_input_pop) or add_input_address_score = 255, NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

r_l70_inp_addr_dirty_i := if(not(add_input_pop and truedid), NULL, (integer)add_input_dirty_address);

r_f00_input_dob_match_level_d := if(not(truedid and dobpop), NULL, (integer)input_dob_match_level);

r_d30_derog_count_i := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

r_d32_criminal_count_i := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

r_d32_mos_since_crim_ls_d := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => 241,
                                  max(3, min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240)));

_felony_last_date := common.sas_date((string)(felony_last_date));

r_d32_mos_since_fel_ls_d := map(
    not(truedid)             => NULL,
    _felony_last_date = NULL => 241,
                                max(3, min(if(if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _felony_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _felony_last_date) / (365.25 / 12)), roundup((sysdate - _felony_last_date) / (365.25 / 12)))), 240)));

r_d31_bk_disposed_hist_count_i := if(not(truedid), NULL, min(if(bk_disposed_historical_count = NULL, -NULL, bk_disposed_historical_count), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

r_c10_m_hdr_fs_d := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => 1000,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, NULL, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

k_comb_age_d := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

r_a44_curr_add_naprop_d := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);

r_c13_curr_addr_lres_d := if(not(truedid and add_curr_pop), NULL, min(if(add_curr_lres = NULL, -NULL, add_curr_lres), 999));

r_c13_max_lres_d := if(not(truedid), NULL, min(if(max_lres = NULL, -NULL, max_lres), 999));

r_c14_addrs_5yr_i := if(not(truedid), NULL, min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 999));

r_c14_addrs_10yr_i := if(not(truedid), NULL, min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 999));

r_c14_addrs_15yr_i := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

r_a41_prop_owner_inp_only_d := map(
    not(truedid)                                => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 => 1,
                                                   0);

r_prop_owner_history_d := map(
    not(truedid)                                                                     => NULL,
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 2,
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 1,
                                                                                        0);

r_c20_email_count_i := if(not(truedid), NULL, min(if(email_count = NULL, -NULL, email_count), 999));

r_c20_email_domain_free_count_i := if(not(truedid), NULL, min(if(email_domain_free_count = NULL, -NULL, email_domain_free_count), 999));

r_c20_email_domain_isp_count_i := if(not(truedid), NULL, min(if(email_domain_ISP_count = NULL, -NULL, email_domain_ISP_count), 999));

r_l79_adls_per_addr_c6_i := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

r_a50_pb_total_dollars_d := map(
    not(truedid)            => NULL,
    pb_total_dollars = '' => 10001,
                               min(if(pb_total_dollars = '', -NULL, (integer)pb_total_dollars), 10000));

r_a50_pb_total_orders_d := map(
    not(truedid)           => NULL,
    pb_total_orders = '' => -1,
                              (integer)pb_total_orders);

r_pb_order_freq_d := map(
    not(truedid)                     => NULL,
    pb_number_of_sources = ''      => NULL,
    pb_average_days_bt_orders = '' => -1,
                                        min(if(pb_average_days_bt_orders = '', -NULL, (integer)pb_average_days_bt_orders), 999));

r_i60_inq_banking_recency_d := map(
    not(truedid)        => NULL,
    inq_banking_count01 > 0 => 1,
    inq_banking_count03 > 0 => 3,
    inq_banking_count06 > 0 => 6,
    inq_banking_count12 > 0 => 12,
    inq_banking_count24 > 0 => 24,
    inq_banking_count   > 0 => 99,
                           999);

r_i60_inq_mortgage_recency_d := map(
    not(truedid)         => NULL,
    inq_mortgage_count01 > 0 => 1,
    inq_mortgage_count03 > 0 => 3,
    inq_mortgage_count06 > 0 => 6,
    inq_mortgage_count12 > 0 => 12,
    inq_mortgage_count24 > 0 => 24,
    inq_mortgage_count   > 0 => 99,
                            999);

r_i60_inq_hiriskcred_count12_i := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

r_i60_inq_hiriskcred_recency_d := map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 > 0 => 1,
    inq_highRiskCredit_count03 > 0 => 3,
    inq_highRiskCredit_count06 > 0 => 6,
    inq_highRiskCredit_count12 > 0 => 12,
    inq_highRiskCredit_count24 > 0 => 24,
    inq_highRiskCredit_count   > 0 => 99,
                                  999);

f_bus_addr_match_count_d := if(not(addrpop), NULL, bus_addr_match_count);

f_bus_phone_match_d := if(not(addrpop), NULL, (integer)(bus_phone_match = 3));

f_add_input_mobility_index_i := map(
    not(addrpop)                 => NULL,
    add_input_occupants_1yr <= 0 => NULL,
                                    if(max(add_input_turnover_1yr_in, add_input_turnover_1yr_out) = NULL, NULL, sum(if(add_input_turnover_1yr_in = NULL, 0, add_input_turnover_1yr_in), if(add_input_turnover_1yr_out = NULL, 0, add_input_turnover_1yr_out))) / add_input_occupants_1yr);

add_input_nhood_prop_sum_2 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_bus_pct_i := map(
    not(addrpop)               => NULL,
    add_input_nhood_BUS_ct = 0 => NULL,
                                  add_input_nhood_BUS_ct / add_input_nhood_prop_sum_2);

add_input_nhood_prop_sum_1 := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_mfd_pct_i := map(
    not(addrpop)               => NULL,
    add_input_nhood_MFD_ct = 0 => NULL,
                                  add_input_nhood_MFD_ct / add_input_nhood_prop_sum_1);

add_input_nhood_prop_sum := if(max(add_input_nhood_BUS_ct, add_input_nhood_SFD_ct, add_input_nhood_MFD_ct) = NULL, NULL, sum(if(add_input_nhood_BUS_ct = NULL, 0, add_input_nhood_BUS_ct), if(add_input_nhood_SFD_ct = NULL, 0, add_input_nhood_SFD_ct), if(add_input_nhood_MFD_ct = NULL, 0, add_input_nhood_MFD_ct)));

f_add_input_nhood_sfd_pct_d := map(
    not(addrpop)               => NULL,
    add_input_nhood_SFD_ct = 0 => -1,
                                  add_input_nhood_SFD_ct / add_input_nhood_prop_sum);

f_add_curr_mobility_index_i := map(
    not(add_curr_pop)           => NULL,
    add_curr_occupants_1yr <= 0 => NULL,
                                   if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr);

add_curr_nhood_prop_sum_2 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));

f_add_curr_nhood_bus_pct_i := map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_BUS_ct = 0 => NULL,
                                 add_curr_nhood_BUS_ct / add_curr_nhood_prop_sum_2);

add_curr_nhood_prop_sum_1 := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));

f_add_curr_nhood_mfd_pct_i := map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_MFD_ct = 0 => NULL,
                                 add_curr_nhood_MFD_ct / add_curr_nhood_prop_sum_1);

add_curr_nhood_prop_sum := if(max(add_curr_nhood_BUS_ct, add_curr_nhood_SFD_ct, add_curr_nhood_MFD_ct) = NULL, NULL, sum(if(add_curr_nhood_BUS_ct = NULL, 0, add_curr_nhood_BUS_ct), if(add_curr_nhood_SFD_ct = NULL, 0, add_curr_nhood_SFD_ct), if(add_curr_nhood_MFD_ct = NULL, 0, add_curr_nhood_MFD_ct)));

f_add_curr_nhood_sfd_pct_d := map(
    not(add_curr_pop)         => NULL,
    add_curr_nhood_SFD_ct = 0 => -1,
                                 add_curr_nhood_SFD_ct / add_curr_nhood_prop_sum);

f_inq_count_i := if(not(truedid), NULL, min(if(inq_count = NULL, -NULL, inq_count), 999));

f_inq_count24_i := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

f_inq_banking_count_i := if(not(truedid), NULL, min(if(inq_Banking_count = NULL, -NULL, inq_Banking_count), 999));

f_inq_collection_count_i := if(not(truedid), NULL, min(if(inq_Collection_count = NULL, -NULL, inq_Collection_count), 999));

f_inq_communications_count_i := if(not(truedid), NULL, min(if(inq_Communications_count = NULL, -NULL, inq_Communications_count), 999));

f_inq_highriskcredit_count_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count = NULL, -NULL, inq_HighRiskCredit_count), 999));

f_inq_highriskcredit_count24_i := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));

f_inq_other_count_i := if(not(truedid), NULL, min(if(inq_Other_count = NULL, -NULL, inq_Other_count), 999));

f_inq_other_count24_i := if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999));

f_inq_retail_count_i := if(not(truedid), NULL, min(if(inq_Retail_count = NULL, -NULL, inq_Retail_count), 999));

k_inq_dobs_per_ssn_i := if(not((integer)ssnlength > 0), NULL, min(if(inq_dobsperssn = NULL, -NULL, inq_dobsperssn), 999));

k_inq_ssns_per_addr_i := if(not(addrpop), NULL, min(if(inq_ssnsperaddr = NULL, -NULL, inq_ssnsperaddr), 999));

k_inq_per_phone_i := if(not(hphnpop), NULL, min(if(inq_perphone = NULL, -NULL, inq_perphone), 999));

k_inq_adls_per_phone_i := if(not(hphnpop), NULL, min(if(inq_adlsperphone = NULL, -NULL, inq_adlsperphone), 999));

_inq_banko_cm_first_seen := common.sas_date((string)(Inq_banko_cm_first_seen));

f_mos_inq_banko_cm_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_cm_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_first_seen) / (365.25 / 12)))), 999));

_inq_banko_cm_last_seen := common.sas_date((string)(Inq_banko_cm_last_seen));

f_mos_inq_banko_cm_lseen_d := map(
    not(truedid)                   => NULL,
    _inq_banko_cm_last_seen = NULL => 1000,
                                      max(3, min(if(if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_cm_last_seen) / (365.25 / 12)))), 999)));

_inq_banko_om_first_seen := common.sas_date((string)(Inq_banko_om_first_seen));

f_mos_inq_banko_om_fseen_d := map(
    not(truedid)                    => NULL,
    _inq_banko_om_first_seen = NULL => 1000,
                                       min(if(if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _inq_banko_om_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)), roundup((sysdate - _inq_banko_om_first_seen) / (365.25 / 12)))), 999));

f_liens_unrel_cj_total_amt_i := if(not(truedid), NULL, liens_unrel_CJ_total_amount);

_foreclosure_last_date := common.sas_date((string)(foreclosure_last_date));

f_mos_foreclosure_lseen_d := map(
    not(truedid)                  => NULL,
    _foreclosure_last_date = NULL => 1000,
                                     max(3, min(if(if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _foreclosure_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _foreclosure_last_date) / (365.25 / 12)), roundup((sysdate - _foreclosure_last_date) / (365.25 / 12)))), 999)));

k_estimated_income_d := if(not(truedid), NULL, estimated_income);

r_wealth_index_d := if(not(truedid), NULL, (integer)wealth_index);

f_rel_incomeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count))));

f_rel_homeover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder100_count, rel_homeunder150_count, rel_homeunder200_count, rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_homeover200_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_homeunder300_count, rel_homeunder500_count, rel_homeover500_count) = NULL, NULL, sum(if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count), if(rel_homeover500_count = NULL, 0, rel_homeover500_count))));

f_rel_ageover30_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_ageover40_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_ageover50_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))));

f_rel_educationover12_count_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_educationover12_count);

f_crim_rel_under100miles_cnt_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(crim_rel_within25miles, crim_rel_within100miles) = NULL, NULL, sum(if(crim_rel_within25miles = NULL, 0, crim_rel_within25miles), if(crim_rel_within100miles = NULL, 0, crim_rel_within100miles))));

f_rel_under25miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     rel_within25miles_count);

f_rel_under100miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count))));

f_rel_under500miles_cnt_d := map(
    not(truedid)  => NULL,
    rel_count = 0 => NULL,
                     if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count))));

f_rel_bankrupt_count_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count), 999));

f_rel_criminal_count_i := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     min(if(rel_criminal_count = NULL, -NULL, rel_criminal_count), 999));

f_historical_count_d := if(not(truedid), NULL, min(if(historical_count = NULL, -NULL, historical_count), 999));

f_idverrisktype_i := if(not(truedid) or fp_idverrisktype = '', NULL, (integer)fp_idverrisktype);

f_sourcerisktype_i := map(
    not(truedid)             => NULL,
    fp_sourcerisktype = '' => NULL,
                                (integer)fp_sourcerisktype);

f_varrisktype_i := map(
    not(truedid)          => NULL,
    fp_varrisktype = '' => NULL,
                             (integer)fp_varrisktype);

f_srchvelocityrisktype_i := map(
    not(truedid)                   => NULL,
    fp_srchvelocityrisktype = '' => NULL,
                                      (integer)fp_srchvelocityrisktype);

f_srchunvrfdaddrcount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (integer)fp_srchunvrfdaddrcount), 999));

f_srchunvrfdphonecount_i := if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (integer)fp_srchunvrfdphonecount), 999));

f_srchfraudsrchcount_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcount = '', -NULL, (integer)fp_srchfraudsrchcount), 999));

f_srchfraudsrchcountyr_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (integer)fp_srchfraudsrchcountyr), 999));

f_srchfraudsrchcountmo_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountmo = '', -NULL, (integer)fp_srchfraudsrchcountmo), 999));

f_srchfraudsrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchfraudsrchcountwk = '', -NULL, (integer)fp_srchfraudsrchcountwk), 999));

f_validationrisktype_i := map(
    not(truedid)                 => NULL,
    fp_validationrisktype = '' => NULL,
                                    (integer)fp_validationrisktype);

f_corrrisktype_i := map(
    not(truedid)           => NULL,
    fp_corrrisktype = '' => NULL,
                              (integer)fp_corrrisktype);

f_corrssnaddrcount_d := if(not(truedid), NULL, min(if(fp_corrssnaddrcount = '', -NULL, (integer)fp_corrssnaddrcount), 999));

f_corraddrnamecount_d := if(not(truedid), NULL, min(if(fp_corraddrnamecount = '', -NULL, (integer)fp_corraddrnamecount), 999));

f_corraddrphonecount_d := if(not(truedid), NULL, min(if(fp_corraddrphonecount = '', -NULL, (integer)fp_corraddrphonecount), 999));

f_corrphonelastnamecount_d := if(not(truedid), NULL, min(if(fp_corrphonelastnamecount = '', -NULL, (integer)fp_corrphonelastnamecount), 999));

f_divrisktype_i := map(
    not(truedid)          => NULL,
    fp_divrisktype = '' => NULL,
                             (integer)fp_divrisktype);

f_srchssnsrchcount_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcount = '', -NULL, (integer)fp_srchssnsrchcount), 999));

f_srchssnsrchcountwk_i := if(not(truedid), NULL, min(if(fp_srchssnsrchcountwk = '', -NULL, (integer)fp_srchssnsrchcountwk), 999));

f_srchaddrsrchcount_i := if(not(truedid), NULL, min(if(fp_srchaddrsrchcount = '', -NULL, (integer)fp_srchaddrsrchcount), 999));

f_srchphonesrchcount_i := if(not(truedid), NULL, min(if(fp_srchphonesrchcount = '', -NULL, (integer)fp_srchphonesrchcount), 999));

f_srchphonesrchcountday_i := if(not(truedid), NULL, min(if(fp_srchphonesrchcountday = '', -NULL, (integer)fp_srchphonesrchcountday), 999));

f_componentcharrisktype_i := map(
    not(truedid)                    => NULL,
    fp_componentcharrisktype = '' => NULL,
                                       (integer)fp_componentcharrisktype);

f_addrchangeincomediff_d_1 := if(not(truedid), NULL, NULL);

f_addrchangeincomediff_d := if((integer)fp_addrchangeincomediff = -1, NULL, (integer)fp_addrchangeincomediff);

f_addrchangevaluediff_d := map(
    not(truedid)                => NULL,
    (integer)fp_addrchangevaluediff = -1 => NULL,
                                   (integer)fp_addrchangevaluediff);

f_addrchangecrimediff_i := map(
    not(truedid)                => NULL,
    (integer)fp_addrchangecrimediff = -1 => NULL,
                                   (integer)fp_addrchangecrimediff);

f_curraddractivephonelist_d := map(
    not(add_curr_pop)               => NULL,
    (integer)fp_curraddractivephonelist = -1 => NULL,
                                       (integer)fp_curraddractivephonelist);

f_curraddrmedianincome_d := if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianincome);

f_curraddrmedianvalue_d := if(not(add_curr_pop), NULL, (integer)fp_curraddrmedianvalue);

f_curraddrmurderindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrmurderindex);

f_curraddrburglaryindex_i := if(not(add_curr_pop), NULL, (integer)fp_curraddrburglaryindex);

f_prevaddrageoldest_d := if(not(truedid), NULL, min(if(fp_prevaddrageoldest = '', -NULL, (integer)fp_prevaddrageoldest), 999));

f_prevaddrlenofres_d := if(not(truedid), NULL, min(if(fp_prevaddrlenofres = '', -NULL, (integer)fp_prevaddrlenofres), 999));

f_prevaddrdwelltype_sfd_n := if(not(truedid), NULL, (integer)(fp_prevaddrdwelltype = 'S'));

f_prevaddroccupantowned_i := map(
    not(truedid)                    => NULL,
    fp_prevaddroccupantowned = '' => NULL,
                                       (integer)fp_prevaddroccupantowned);

f_prevaddrmedianincome_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianincome);

f_prevaddrmedianvalue_d := if(not(truedid), NULL, (integer)fp_prevaddrmedianvalue);

f_prevaddrcartheftindex_i := if(not(truedid), NULL, (integer)fp_prevaddrcartheftindex);

f_fp_prevaddrburglaryindex_i := if(not(truedid), NULL, (integer)fp_prevaddrburglaryindex);

r_c12_source_profile_d := if(not(truedid), NULL, hdr_source_profile);

r_c12_source_profile_index_d := if(not(truedid), NULL, hdr_source_profile_index);

r_c23_inp_addr_occ_index_d := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

r_c23_inp_addr_owned_not_occ_d := if(not(add_input_pop and truedid), NULL, (integer)add_input_owned_not_occ);

r_e57_br_source_count_d := if(not(truedid), NULL, br_source_count);

r_i60_inq_prepaidcards_recency_d := map(
    not(truedid)             => NULL,
    inq_PrepaidCards_count01 > 0 => 1,
    inq_PrepaidCards_count03 > 0 => 3,
    inq_PrepaidCards_count06 > 0 => 6,
    inq_PrepaidCards_count12 > 0 => 12,
    inq_PrepaidCards_count24 > 0 => 24,
    inq_PrepaidCards_count   > 0 => 99,
                                999);

f_phone_ver_insurance_d := if(not(truedid) or phone_ver_insurance = '-1', NULL, (integer)phone_ver_insurance);

f_phone_ver_experian_d := if(not(truedid) or phone_ver_experian = '-1', NULL, (integer)phone_ver_experian);

f_phones_per_addr_curr_i := if(not(add_curr_pop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));

f_adls_per_phone_c6_i := if(not(hphnpop), NULL, min(if(adls_per_phone_c6 = NULL, -NULL, adls_per_phone_c6), 999));

f_dl_addrs_per_adl_i := if(not(truedid), NULL, min(if(dl_addrs_per_adl = NULL, -NULL, dl_addrs_per_adl), 999));

f_inq_email_ver_count_i := if(not(truedid), NULL, min(if(inq_email_ver_count = NULL, -NULL, inq_email_ver_count), 999));

f_inq_other_count_week_i := if(not(truedid), NULL, min(if(inq_Other_count_week = NULL, -NULL, inq_Other_count_week), 999));

f_inq_prepaidcards_count_i := if(not(truedid), NULL, min(if(inq_PrepaidCards_count = NULL, -NULL, inq_PrepaidCards_count), 999));

f_nae_email_verd_d := ((integer)email_name_addr_verification in [2, 3, 4, 5, 6, 7, 8]);

f_nae_lname_verd_d := ((integer)email_name_addr_verification in [4, 5, 7, 8]);

f_nae_nothing_found_i := (integer)email_name_addr_verification = 0;

f_adl_per_email_i := if(not(emailpop), NULL, min(if(adl_per_email = NULL, -NULL, adl_per_email), 999));

r_c20_email_verification_d := if(not(emailpop), NULL, (integer)email_verification);

f_vf_hi_risk_ct_i := if(not(truedid), NULL, min(if(vf_hi_risk_ct = NULL, -NULL, vf_hi_risk_ct), 999));

f_vf_altlexid_phn_hi_risk_ct_i := if(not(truedid), NULL, min(if(vf_AltLexID_phone_hi_risk_ct = NULL, -NULL, vf_AltLexID_phone_hi_risk_ct), 999));

f_vf_altlexid_addr_hi_risk_ct_i := if(not(truedid), NULL, min(if(vf_AltLexID_addr_hi_risk_ct = NULL, -NULL, vf_AltLexID_addr_hi_risk_ct), 999));

f_vf_altlexid_addr_lo_risk_ct_d := if(not(truedid), NULL, min(if(vf_AltLexID_addr_lo_risk_ct = NULL, -NULL, vf_AltLexID_addr_lo_risk_ct), 999));

f_vf_lexid_ssn_hi_risk_ct_i := if(not(truedid), NULL, min(if(vf_LexID_ssn_hi_risk_ct = NULL, -NULL, vf_LexID_ssn_hi_risk_ct), 999));

f_hh_members_ct_d := if(not(truedid), NULL, min(if(hh_members_ct = NULL, -NULL, hh_members_ct), 999));

f_property_owners_ct_d := if(not(truedid), NULL, min(if(hh_property_owners_ct = NULL, -NULL, hh_property_owners_ct), 999));

f_hh_age_18_plus_d := if(not(truedid), NULL, min(if(if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30))) = NULL, -NULL, if(max(hh_age_65_plus, hh_age_30_to_65, hh_age_18_to_30) = NULL, NULL, sum(if(hh_age_65_plus = NULL, 0, hh_age_65_plus), if(hh_age_30_to_65 = NULL, 0, hh_age_30_to_65), if(hh_age_18_to_30 = NULL, 0, hh_age_18_to_30)))), 999));

f_hh_collections_ct_i := if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999));

f_hh_members_w_derog_i := if(not(truedid), NULL, min(if(hh_members_w_derog = NULL, -NULL, hh_members_w_derog), 999));

f_hh_bankruptcies_i := if(not(truedid), NULL, min(if(hh_bankruptcies = NULL, -NULL, hh_bankruptcies), 999));

f_hh_lienholders_i := if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999));

f_hh_college_attendees_d := if(not(truedid), NULL, min(if(hh_college_attendees = NULL, -NULL, hh_college_attendees), 999));

all4wfdn_0 := -2.5340737990;

all4wfdn_1_c159 := map(
    NULL < f_hh_bankruptcies_i AND f_hh_bankruptcies_i <= 0.5 => 1.0827247118,
    f_hh_bankruptcies_i > 0.5                                 => 0.5036571911,
    f_hh_bankruptcies_i = NULL                                => 0.9310932272,
                                                                 0.9310932272);

all4wfdn_1_c158 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => 0.1773446617,
    r_a41_prop_owner_inp_only_d > 0.5                                         => all4wfdn_1_c159,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.7357423109,
                                                                                 0.7357423109);

all4wfdn_1_c157 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_1_c158,
    r_phn_cell_n > 0.5                          => 0.1355131736,
    r_phn_cell_n = NULL                         => 0.4801539288,
                                                   0.4801539288);

all4wfdn_1_c156 := map(
    NULL < r_c12_source_profile_index_d AND r_c12_source_profile_index_d <= 5.5 => 0.0106046839,
    r_c12_source_profile_index_d > 5.5                                          => all4wfdn_1_c157,
    r_c12_source_profile_index_d = NULL                                         => 0.1458877427,
                                                                                   0.1458877427);

all4wfdn_1 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 549 => -0.0535503574,
    r_i60_inq_hiriskcred_recency_d > 549                                            => all4wfdn_1_c156,
    r_i60_inq_hiriskcred_recency_d = NULL                                           => -0.0036320082,
                                                                                       -0.0036320082);

all4wfdn_2_c163 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => 0.3322137559,
    r_phn_pcs_n > 0.5                         => -0.0148670514,
    r_phn_pcs_n = NULL                        => 0.1429041739,
                                                 0.1429041739);

all4wfdn_2_c162 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_2_c163,
    r_phn_cell_n > 0.5                          => -0.0260731188,
    r_phn_cell_n = NULL                         => 0.0324076948,
                                                   0.0324076948);

all4wfdn_2_c164 := map(
    trim(c_lux_prod) = ''                         => 0.3650528389,
    NULL < (real)c_lux_prod AND (real)c_lux_prod <= 125.5 => 0.1955794961,
    (real)c_lux_prod > 125.5                        => 0.5401264023,
                                                 0.3650528389);

all4wfdn_2_c161 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 9.5 => all4wfdn_2_c162,
    f_corraddrnamecount_d > 9.5                                   => all4wfdn_2_c164,
    f_corraddrnamecount_d = NULL                                  => 0.0893807915,
                                                                     0.0893807915);

all4wfdn_2 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 0.5 => all4wfdn_2_c161,
    f_inq_highriskcredit_count_i > 0.5                                          => -0.0456273171,
    f_inq_highriskcredit_count_i = NULL                                         => -0.0123256376,
                                                                                   -0.0123256376);

all4wfdn_3_c167 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 69.3 => -0.0199404868,
    r_c12_source_profile_d > 69.3                                    => 0.1352368451,
    r_c12_source_profile_d = NULL                                    => 0.0132138473,
                                                                        0.0132138473);

all4wfdn_3_c169 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 49.5 => 0.2161601801,
    k_comb_age_d > 49.5                          => 0.3823546734,
    k_comb_age_d = NULL                          => 0.3159721620,
                                                    0.3159721620);

all4wfdn_3_c168 := map(
    NULL < (integer)f_nae_lname_verd_d AND (real)f_nae_lname_verd_d <= 0.5 => all4wfdn_3_c169,
    (real)f_nae_lname_verd_d > 0.5                                => -0.0716140360,
    (integer)f_nae_lname_verd_d = NULL                               => 0.2389594373,
                                                               0.2389594373);

all4wfdn_3_c166 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 9.5 => all4wfdn_3_c167,
    f_corraddrnamecount_d > 9.5                                   => all4wfdn_3_c168,
    f_corraddrnamecount_d = NULL                                  => 0.0515051312,
                                                                     0.0515051312);

all4wfdn_3 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 0.5 => all4wfdn_3_c166,
    f_inq_highriskcredit_count_i > 0.5                                          => -0.0441334829,
    f_inq_highriskcredit_count_i = NULL                                         => -0.0203362554,
                                                                                   -0.0203362554);

all4wfdn_4_c172 := map(
    NULL < (integer)f_nae_email_verd_d AND (real)f_nae_email_verd_d <= 0.5 => 0.2688280623,
    (real)f_nae_email_verd_d > 0.5                                => -0.0305600930,
    (integer)f_nae_email_verd_d = NULL                               => 0.2019790324,
                                                               0.2019790324);

all4wfdn_4_c174 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => 0.2077430178,
    r_phn_pcs_n > 0.5                         => -0.0239441149,
    r_phn_pcs_n = NULL                        => 0.0871166880,
                                                 0.0871166880);

all4wfdn_4_c173 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_4_c174,
    r_phn_cell_n > 0.5                          => -0.0273626481,
    r_phn_cell_n = NULL                         => 0.0132036031,
                                                   0.0132036031);

all4wfdn_4_c171 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 2.5 => all4wfdn_4_c172,
    f_sourcerisktype_i > 2.5                                => all4wfdn_4_c173,
    f_sourcerisktype_i = NULL                               => 0.0437585419,
                                                               0.0437585419);

all4wfdn_4 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 0.5 => all4wfdn_4_c171,
    f_inq_highriskcredit_count_i > 0.5                                          => -0.0415988970,
    f_inq_highriskcredit_count_i = NULL                                         => -0.0201699909,
                                                                                   -0.0201699909);

all4wfdn_5_c177 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 66500 => 0.0915303356,
    k_estimated_income_d > 66500                                  => 0.2816085679,
    k_estimated_income_d = NULL                                   => 0.1689615973,
                                                                     0.1689615973);

all4wfdn_5_c179 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 85.5 => -0.0165943971,
    f_mos_inq_banko_cm_lseen_d > 85.5                                        => 0.1914247213,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0983363381,
                                                                                0.0983363381);

all4wfdn_5_c178 := map(
    NULL < (integer)f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 114.5 => -0.0216253682,
    f_prevaddrageoldest_d > 114.5                                   => (real)all4wfdn_5_c179,
    f_prevaddrageoldest_d = NULL                                    => 0.0068601117,
                                                                       0.0068601117);

all4wfdn_5_c176 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 2.5 => all4wfdn_5_c177,
    f_sourcerisktype_i > 2.5                                => all4wfdn_5_c178,
    f_sourcerisktype_i = NULL                               => 0.0346797177,
                                                               0.0346797177);

all4wfdn_5 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 0.5 => all4wfdn_5_c176,
    f_inq_highriskcredit_count_i > 0.5                                          => -0.0388146822,
    f_inq_highriskcredit_count_i = NULL                                         => -0.0205455334,
                                                                                   -0.0205455334);

all4wfdn_6_c182 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.0959789400,
    r_phn_cell_n > 0.5                          => -0.0212125790,
    r_phn_cell_n = NULL                         => 0.0177534447,
                                                   0.0177534447);

all4wfdn_6_c181 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_6_c182,
    f_phone_ver_experian_d > 0.5                                    => -0.0591088055,
    f_phone_ver_experian_d = NULL                                   => -0.0175820955,
                                                                       -0.0223885513);

all4wfdn_6_c184 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.2878399640,
    f_phone_ver_experian_d > 0.5                                    => 0.0701340941,
    f_phone_ver_experian_d = NULL                                   => 0.1881745385,
                                                                       0.1881745385);

all4wfdn_6_c183 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => all4wfdn_6_c184,
    f_inq_highriskcredit_count_i > 1.5                                          => -0.0468762035,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0630949777,
                                                                                   0.0630949777);

all4wfdn_6 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 4.5 => all4wfdn_6_c181,
    r_wealth_index_d > 4.5                              => all4wfdn_6_c183,
    r_wealth_index_d = NULL                             => -0.0143612859,
                                                           -0.0143612859);

all4wfdn_7_c189 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 33.5 => -0.0121037623,
    k_comb_age_d > 33.5                          => 0.2306592247,
    k_comb_age_d = NULL                          => 0.1988827413,
                                                    0.1988827413);

all4wfdn_7_c188 := map(
    NULL < (integer)f_nae_email_verd_d AND (real)f_nae_email_verd_d <= 0.5 => all4wfdn_7_c189,
    (real)f_nae_email_verd_d > 0.5                                => -0.0374694876,
    (integer)f_nae_email_verd_d = NULL                               => 0.1528948270,
                                                               0.1528948270);

all4wfdn_7_c187 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 84.5 => 0.0333959453,
    f_mos_inq_banko_cm_lseen_d > 84.5                                        => all4wfdn_7_c188,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0956173610,
                                                                                0.0956173610);

all4wfdn_7_c186 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 3.5 => all4wfdn_7_c187,
    f_sourcerisktype_i > 3.5                                => -0.0035565339,
    f_sourcerisktype_i = NULL                               => 0.0285825537,
                                                               0.0285825537);

all4wfdn_7 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 0.5 => all4wfdn_7_c186,
    f_inq_highriskcredit_count_i > 0.5                                          => -0.0344245700,
    f_inq_highriskcredit_count_i = NULL                                         => -0.0187982392,
                                                                                   -0.0187982392);

all4wfdn_8_c194 := map(
    NULL < r_prop_owner_history_d AND r_prop_owner_history_d <= 1.5 => 0.0807087182,
    r_prop_owner_history_d > 1.5                                    => 0.2254481863,
    r_prop_owner_history_d = NULL                                   => 0.1891239169,
                                                                       0.1891239169);

all4wfdn_8_c193 := map(
    NULL < (integer)f_nae_email_verd_d AND (real)f_nae_email_verd_d <= 0.5 => all4wfdn_8_c194,
    (real)f_nae_email_verd_d > 0.5                                => -0.0484765911,
    (integer)f_nae_email_verd_d = NULL                               => 0.1507022431,
                                                               0.1507022431);

all4wfdn_8_c192 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => all4wfdn_8_c193,
    f_inq_highriskcredit_count_i > 1.5                                          => 0.0213691785,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0824630910,
                                                                                   0.0824630910);

all4wfdn_8_c191 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => all4wfdn_8_c192,
    r_phn_pcs_n > 0.5                         => -0.0325583335,
    r_phn_pcs_n = NULL                        => 0.0164854942,
                                                 0.0164854942);

all4wfdn_8 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_8_c191,
    r_phn_cell_n > 0.5                          => -0.0396666239,
    r_phn_cell_n = NULL                         => -0.0201185583,
                                                   -0.0201185583);

all4wfdn_9_c199 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => 0.2071740049,
    r_phn_pcs_n > 0.5                         => 0.1105261394,
    r_phn_pcs_n = NULL                        => 0.1751719003,
                                                 0.1751719003);

all4wfdn_9_c198 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_9_c199,
    r_phn_cell_n > 0.5                          => 0.0883204352,
    r_phn_cell_n = NULL                         => 0.1308656919,
                                                   0.1308656919);

all4wfdn_9_c197 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => all4wfdn_9_c198,
    f_inq_highriskcredit_count_i > 1.5                                          => 0.0237642261,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0746758885,
                                                                                   0.0746758885);

all4wfdn_9_c196 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => -0.0150029436,
    r_a41_prop_owner_inp_only_d > 0.5                                         => all4wfdn_9_c197,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.0220254314,
                                                                                 0.0220254314);

all4wfdn_9 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_9_c196,
    f_phone_ver_experian_d > 0.5                                    => -0.0474776488,
    f_phone_ver_experian_d = NULL                                   => 0.0070630206,
                                                                       -0.0134136276);

all4wfdn_10_c204 := map(
    NULL < (integer)f_nae_lname_verd_d AND (real)f_nae_lname_verd_d <= 0.5 => 0.1625053103,
    (real)f_nae_lname_verd_d > 0.5                                => -0.0800329443,
    (integer)f_nae_lname_verd_d = NULL                               => 0.0926103644,
                                                               0.0926103644);

all4wfdn_10_c203 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 6.5 => all4wfdn_10_c204,
    f_srchaddrsrchcount_i > 6.5                                   => -0.0231150953,
    f_srchaddrsrchcount_i = NULL                                  => 0.0234251127,
                                                                     0.0234251127);

all4wfdn_10_c202 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 10.5 => -0.0310264299,
    f_corraddrnamecount_d > 10.5                                   => all4wfdn_10_c203,
    f_corraddrnamecount_d = NULL                                   => -0.0250075295,
                                                                      -0.0250075295);

all4wfdn_10_c201 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => all4wfdn_10_c202,
    f_validationrisktype_i > 1.5                                    => 0.1415946540,
    f_validationrisktype_i = NULL                                   => -0.0189128285,
                                                                       -0.0189128285);

all4wfdn_10 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => all4wfdn_10_c201,
    r_wealth_index_d > 5.5                              => 0.1762596266,
    r_wealth_index_d = NULL                             => -0.0160401357,
                                                           -0.0160401357);

all4wfdn_11_c209 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 84.5 => 0.0303029783,
    f_mos_inq_banko_cm_lseen_d > 84.5                                        => 0.1638900467,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.1181158248,
                                                                                0.1181158248);

all4wfdn_11_c208 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => all4wfdn_11_c209,
    f_inq_highriskcredit_count_i > 1.5                                          => -0.0120576385,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0491253351,
                                                                                   0.0491253351);

all4wfdn_11_c207 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 9.5 => -0.0083885780,
    f_corraddrnamecount_d > 9.5                                   => all4wfdn_11_c208,
    f_corraddrnamecount_d = NULL                                  => -0.0000286017,
                                                                     -0.0000286017);

all4wfdn_11_c206 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => all4wfdn_11_c207,
    f_adl_per_email_i > 0.5                               => -0.0661073004,
    f_adl_per_email_i = NULL                              => -0.0247264131,
                                                             -0.0247264131);

all4wfdn_11 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => all4wfdn_11_c206,
    f_validationrisktype_i > 1.5                                    => 0.1283509661,
    f_validationrisktype_i = NULL                                   => -0.0185647301,
                                                                       -0.0185647301);

all4wfdn_12_c214 := map(
    NULL < (integer)f_nae_email_verd_d AND (real)f_nae_email_verd_d <= 0.5 => 0.1675767662,
    (real)f_nae_email_verd_d > 0.5                                => -0.0914546956,
    (integer)f_nae_email_verd_d = NULL                               => 0.0994162326,
                                                               0.0994162326);

all4wfdn_12_c213 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 88.5 => -0.0000164994,
    f_prevaddrageoldest_d > 88.5                                   => all4wfdn_12_c214,
    f_prevaddrageoldest_d = NULL                                   => 0.0284247921,
                                                                      0.0284247921);

all4wfdn_12_c212 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 2.5 => 0.1831233187,
    f_sourcerisktype_i > 2.5                                => all4wfdn_12_c213,
    f_sourcerisktype_i = NULL                               => 0.0532085354,
                                                               0.0532085354);

all4wfdn_12_c211 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 133 => -0.0077940668,
    f_mos_inq_banko_cm_fseen_d > 133                                        => all4wfdn_12_c212,
    f_mos_inq_banko_cm_fseen_d = NULL                                       => 0.0152165493,
                                                                               0.0152165493);

all4wfdn_12 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_12_c211,
    f_phone_ver_experian_d > 0.5                                    => -0.0505368184,
    f_phone_ver_experian_d = NULL                                   => -0.0091441995,
                                                                       -0.0190488506);

all4wfdn_13_c219 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 34500 => 0.0617818889,
    k_estimated_income_d > 34500                                  => 0.1979993569,
    k_estimated_income_d = NULL                                   => 0.1563911121,
                                                                     0.1563911121);

all4wfdn_13_c218 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 4.5 => all4wfdn_13_c219,
    r_c20_email_verification_d > 4.5                                        => -0.0214845975,
    r_c20_email_verification_d = NULL                                       => 0.1140162893,
                                                                               0.1140162893);

all4wfdn_13_c217 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => all4wfdn_13_c218,
    r_phn_pcs_n > 0.5                         => -0.0020396819,
    r_phn_pcs_n = NULL                        => 0.0478819610,
                                                 0.0478819610);

all4wfdn_13_c216 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_13_c217,
    r_phn_cell_n > 0.5                          => -0.0098745770,
    r_phn_cell_n = NULL                         => 0.0106791893,
                                                   0.0106791893);

all4wfdn_13 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => -0.0476634767,
    f_idverrisktype_i > 1.5                               => all4wfdn_13_c216,
    f_idverrisktype_i = NULL                              => -0.0164751830,
                                                             -0.0164751830);

all4wfdn_14_c222 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => -0.0152592395,
    r_a41_prop_owner_inp_only_d > 0.5                                         => 0.1015453423,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.0331885395,
                                                                                 0.0331885395);

all4wfdn_14_c221 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => all4wfdn_14_c222,
    r_c20_email_verification_d > 0.5                                        => -0.0296579057,
    r_c20_email_verification_d = NULL                                       => -0.0164141587,
                                                                               -0.0164141587);

all4wfdn_14_c224 := map(
    trim(c_newhouse) = ''                         => 0.2016909092,
    NULL < (integer)c_newhouse AND (real)c_newhouse <= 35.65 => 0.1207012234,
    (real)c_newhouse > 35.65                        => 0.3765867391,
                                                 0.2016909092);

all4wfdn_14_c223 := map(
    trim(c_serv_empl) = ''                         => 0.0947370088,
    NULL < (integer)c_serv_empl AND (real)c_serv_empl <= 62.5 => all4wfdn_14_c224,
    (real)c_serv_empl > 62.5                         => 0.0470791310,
                                                  0.0947370088);

all4wfdn_14 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => all4wfdn_14_c221,
    f_validationrisktype_i > 1.5                                    => all4wfdn_14_c223,
    f_validationrisktype_i = NULL                                   => -0.0119957607,
                                                                       -0.0119957607);

all4wfdn_15_c229 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => 0.1728210523,
    r_phn_pcs_n > 0.5                         => 0.0057569978,
    r_phn_pcs_n = NULL                        => 0.1349648930,
                                                 0.1349648930);

all4wfdn_15_c228 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_15_c229,
    r_phn_cell_n > 0.5                          => 0.0763888407,
    r_phn_cell_n = NULL                         => 0.1079106993,
                                                   0.1079106993);

all4wfdn_15_c227 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 85.5 => 0.0131819002,
    f_mos_inq_banko_cm_fseen_d > 85.5                                        => all4wfdn_15_c228,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => 0.0549471248,
                                                                                0.0549471248);

all4wfdn_15_c226 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 115.5 => -0.0035161609,
    f_prevaddrageoldest_d > 115.5                                   => all4wfdn_15_c227,
    f_prevaddrageoldest_d = NULL                                    => 0.0108807557,
                                                                       0.0108807557);

all4wfdn_15 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 4.5 => all4wfdn_15_c226,
    r_c20_email_verification_d > 4.5                                        => -0.0597333794,
    r_c20_email_verification_d = NULL                                       => -0.0149443838,
                                                                               -0.0149443838);

all4wfdn_16_c234 := map(
    NULL < (integer)f_nae_nothing_found_i AND (real)f_nae_nothing_found_i <= 0.5 => -0.0320920304,
    (real)f_nae_nothing_found_i > 0.5                                   => 0.1820568341,
    (integer)f_nae_nothing_found_i = NULL                                  => 0.1325187835,
                                                                     0.1325187835);

all4wfdn_16_c233 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 85.5 => 0.0156038314,
    f_mos_inq_banko_cm_lseen_d > 85.5                                        => all4wfdn_16_c234,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0578040533,
                                                                                0.0578040533);

all4wfdn_16_c232 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 53.5 => 0.0041686383,
    k_comb_age_d > 53.5                          => all4wfdn_16_c233,
    k_comb_age_d = NULL                          => 0.0138385302,
                                                    0.0138385302);

all4wfdn_16_c231 := map(
    trim(c_highinc) = ''                        => 0.1246157407,
    NULL < (integer)c_highinc AND (real)c_highinc <= 41.45 => all4wfdn_16_c232,
    (real)c_highinc > 41.45                       => 0.1735482714,
                                               0.0211318544);

all4wfdn_16 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_16_c231,
    f_phone_ver_experian_d > 0.5                                    => -0.0377886983,
    f_phone_ver_experian_d = NULL                                   => -0.0219074559,
                                                                       -0.0110008125);

all4wfdn_17_c237 := map(
    NULL < f_inq_banking_count_i AND f_inq_banking_count_i <= 2.5 => 0.0655441957,
    f_inq_banking_count_i > 2.5                                   => 0.3166685004,
    f_inq_banking_count_i = NULL                                  => 0.1041651386,
                                                                     0.1041651386);

all4wfdn_17_c238 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 59.5 => -0.0318880273,
    k_comb_age_d > 59.5                          => 0.0436954172,
    k_comb_age_d = NULL                          => -0.0249420356,
                                                    -0.0249420356);

all4wfdn_17_c236 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -1060.5 => all4wfdn_17_c237,
    f_addrchangevaluediff_d > -1060.5                                     => all4wfdn_17_c238,
    f_addrchangevaluediff_d = NULL                                        => 0.0034449744,
                                                                             -0.0130173223);

all4wfdn_17_c239 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => 0.1534710482,
    f_inq_highriskcredit_count_i > 1.5                                          => -0.0309395087,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0825139206,
                                                                                   0.0825139206);

all4wfdn_17 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => all4wfdn_17_c236,
    r_wealth_index_d > 5.5                              => all4wfdn_17_c239,
    r_wealth_index_d = NULL                             => -0.0115550779,
                                                           -0.0115550779);

all4wfdn_18_c244 := map(
    NULL < f_srchphonesrchcount_i AND f_srchphonesrchcount_i <= 3.5 => 0.1489457531,
    f_srchphonesrchcount_i > 3.5                                    => -0.0013538147,
    f_srchphonesrchcount_i = NULL                                   => 0.1168716899,
                                                                       0.1168716899);

all4wfdn_18_c243 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => all4wfdn_18_c244,
    r_phn_pcs_n > 0.5                         => 0.0067197560,
    r_phn_pcs_n = NULL                        => 0.0689429858,
                                                 0.0689429858);

all4wfdn_18_c242 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_18_c243,
    r_phn_cell_n > 0.5                          => 0.0028442052,
    r_phn_cell_n = NULL                         => 0.0300290527,
                                                   0.0300290527);

all4wfdn_18_c241 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => -0.0180863975,
    r_a41_prop_owner_inp_only_d > 0.5                                         => all4wfdn_18_c242,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.0021173079,
                                                                                 0.0021173079);

all4wfdn_18 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 3.5 => all4wfdn_18_c241,
    r_c20_email_verification_d > 3.5                                        => -0.0533597652,
    r_c20_email_verification_d = NULL                                       => -0.0206294495,
                                                                               -0.0206294495);

all4wfdn_19_c248 := map(
    NULL < (integer)f_nae_nothing_found_i AND (real)f_nae_nothing_found_i <= 0.5 => -0.0438104464,
    (real)f_nae_nothing_found_i > 0.5                                   => 0.1387762650,
    (integer)f_nae_nothing_found_i = NULL                                  => 0.0809323624,
                                                                     0.0809323624);

all4wfdn_19_c247 := map(
    trim(c_lowinc) = ''                       => 0.1048398856,
    NULL < (integer)c_lowinc AND (real)c_lowinc <= 11.25 => all4wfdn_19_c248,
    (real)c_lowinc > 11.25                      => 0.0058518444,
                                             0.0132673364);

all4wfdn_19_c249 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => 0.1785107782,
    f_inq_highriskcredit_count_i > 1.5                                          => 0.0387486913,
    f_inq_highriskcredit_count_i = NULL                                         => 0.1111373145,
                                                                                   0.1111373145);

all4wfdn_19_c246 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 3.5 => all4wfdn_19_c247,
    r_e57_br_source_count_d > 3.5                                     => all4wfdn_19_c249,
    r_e57_br_source_count_d = NULL                                    => 0.0176585378,
                                                                         0.0176585378);

all4wfdn_19 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => -0.0446358107,
    f_idverrisktype_i > 1.5                               => all4wfdn_19_c246,
    f_idverrisktype_i = NULL                              => -0.0115103033,
                                                             -0.0115103033);

all4wfdn_20_c254 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 6.5 => 0.2467088388,
    f_srchaddrsrchcount_i > 6.5                                   => 0.0951064624,
    f_srchaddrsrchcount_i = NULL                                  => 0.1993981855,
                                                                     0.1993981855);

all4wfdn_20_c253 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 48.5 => 0.0613208143,
    f_mos_inq_banko_cm_lseen_d > 48.5                                        => all4wfdn_20_c254,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.1394445463,
                                                                                0.1394445463);

all4wfdn_20_c252 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 43500 => 0.0435748041,
    k_estimated_income_d > 43500                                  => all4wfdn_20_c253,
    k_estimated_income_d = NULL                                   => 0.0741559953,
                                                                     0.0741559953);

all4wfdn_20_c251 := map(
    trim(c_housingcpi) = ''                            => 0.0336371081,
    NULL < (integer)c_housingcpi AND (real)c_housingcpi <= 188.05 => all4wfdn_20_c252,
    (real)c_housingcpi > 188.05                          => 0.0062537369,
                                                      0.0180603481);

all4wfdn_20 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => -0.0425653646,
    f_idverrisktype_i > 1.5                               => all4wfdn_20_c251,
    f_idverrisktype_i = NULL                              => -0.0100569910,
                                                             -0.0100569910);

all4wfdn_21_c257 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0163969390,
    f_phone_ver_experian_d > 0.5                                    => -0.0390708591,
    f_phone_ver_experian_d = NULL                                   => -0.0004923824,
                                                                       -0.0126435185);

all4wfdn_21_c258 := map(
    NULL < f_inq_highriskcredit_count24_i AND f_inq_highriskcredit_count24_i <= 1.5 => 0.1474226883,
    f_inq_highriskcredit_count24_i > 1.5                                            => -0.0546480143,
    f_inq_highriskcredit_count24_i = NULL                                           => 0.0827246125,
                                                                                       0.0827246125);

all4wfdn_21_c256 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 5.5 => all4wfdn_21_c257,
    r_wealth_index_d > 5.5                              => all4wfdn_21_c258,
    r_wealth_index_d = NULL                             => -0.0112230890,
                                                           -0.0112230890);

all4wfdn_21_c259 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => 0.2406193863,
    r_c20_email_verification_d > 1.5                                        => 0.0771167569,
    r_c20_email_verification_d = NULL                                       => 0.1460010125,
                                                                               0.1460010125);

all4wfdn_21 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => all4wfdn_21_c256,
    r_p85_phn_disconnected_i > 0.5                                      => all4wfdn_21_c259,
    r_p85_phn_disconnected_i = NULL                                     => -0.0096261191,
                                                                           -0.0096261191);

all4wfdn_22_c264 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 7.5 => 0.1761306726,
    f_inq_highriskcredit_count_i > 7.5                                          => -0.0690821360,
    f_inq_highriskcredit_count_i = NULL                                         => 0.1342726900,
                                                                                   0.1342726900);

all4wfdn_22_c263 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 37500 => 0.0220844113,
    k_estimated_income_d > 37500                                  => all4wfdn_22_c264,
    k_estimated_income_d = NULL                                   => 0.0957607628,
                                                                     0.0957607628);

all4wfdn_22_c262 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => all4wfdn_22_c263,
    f_hh_lienholders_i > 0.5                                => 0.0235446343,
    f_hh_lienholders_i = NULL                               => 0.0526878975,
                                                               0.0526878975);

all4wfdn_22_c261 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => all4wfdn_22_c262,
    r_phn_pcs_n > 0.5                         => -0.0143069973,
    r_phn_pcs_n = NULL                        => 0.0135605744,
                                                 0.0135605744);

all4wfdn_22 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_22_c261,
    r_phn_cell_n > 0.5                          => -0.0252187568,
    r_phn_cell_n = NULL                         => -0.0118071483,
                                                   -0.0118071483);

all4wfdn_23_c267 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => 0.1526214024,
    f_inq_highriskcredit_count_i > 1.5                                          => -0.0191542462,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0823336115,
                                                                                   0.0823336115);

all4wfdn_23_c266 := map(
    trim(c_med_hhinc) = ''                             => 0.0051151877,
    NULL < (integer)c_med_hhinc AND (real)c_med_hhinc <= 123406.5 => -0.0088626007,
    (real)c_med_hhinc > 123406.5                         => all4wfdn_23_c267,
                                                      -0.0072510392);

all4wfdn_23_c269 := map(
    NULL < f_componentcharrisktype_i AND f_componentcharrisktype_i <= 4.5 => 0.2058087954,
    f_componentcharrisktype_i > 4.5                                       => 0.0550041489,
    f_componentcharrisktype_i = NULL                                      => 0.1268446330,
                                                                             0.1268446330);

all4wfdn_23_c268 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_23_c269,
    r_phn_cell_n > 0.5                          => 0.0058784923,
    r_phn_cell_n = NULL                         => 0.0681566084,
                                                   0.0681566084);

all4wfdn_23 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => all4wfdn_23_c266,
    f_validationrisktype_i > 1.5                                    => all4wfdn_23_c268,
    f_validationrisktype_i = NULL                                   => -0.0042901912,
                                                                       -0.0042901912);

all4wfdn_24_c274 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 34500 => 0.0119838233,
    k_estimated_income_d > 34500                                  => 0.1406779969,
    k_estimated_income_d = NULL                                   => 0.1144138798,
                                                                     0.1144138798);

all4wfdn_24_c273 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => 0.0275502917,
    r_a41_prop_owner_inp_only_d > 0.5                                         => all4wfdn_24_c274,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.0795967135,
                                                                                 0.0795967135);

all4wfdn_24_c272 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => all4wfdn_24_c273,
    f_adl_per_email_i > 0.5                               => -0.0265060793,
    f_adl_per_email_i = NULL                              => 0.0465234596,
                                                             0.0465234596);

all4wfdn_24_c271 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => all4wfdn_24_c272,
    r_phn_pcs_n > 0.5                         => -0.0231568005,
    r_phn_pcs_n = NULL                        => 0.0061143979,
                                                 0.0061143979);

all4wfdn_24 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_24_c271,
    r_phn_cell_n > 0.5                          => -0.0225015428,
    r_phn_cell_n = NULL                         => -0.0124008194,
                                                   -0.0124008194);

all4wfdn_25_c279 := map(
    trim(c_highinc) = ''                       => 0.1367993740,
    NULL < (integer)c_highinc AND (real)c_highinc <= 5.55 => 0.0263713286,
    (real)c_highinc > 5.55                       => 0.1687932046,
                                              0.1367993740);

all4wfdn_25_c278 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 3.5 => all4wfdn_25_c279,
    f_sourcerisktype_i > 3.5                                => 0.0446378467,
    f_sourcerisktype_i = NULL                               => 0.0918019245,
                                                               0.0918019245);

all4wfdn_25_c277 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 85.5 => 0.0043265961,
    f_mos_inq_banko_cm_fseen_d > 85.5                                        => all4wfdn_25_c278,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => 0.0412405270,
                                                                                0.0412405270);

all4wfdn_25_c276 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 110.5 => -0.0035271146,
    f_prevaddrageoldest_d > 110.5                                   => all4wfdn_25_c277,
    f_prevaddrageoldest_d = NULL                                    => 0.0071656654,
                                                                       0.0071656654);

all4wfdn_25 := map(
    NULL < (integer)f_nae_email_verd_d AND (real)f_nae_email_verd_d <= 0.5 => all4wfdn_25_c276,
    (real)f_nae_email_verd_d > 0.5                                => -0.0506347527,
    (integer)f_nae_email_verd_d = NULL                               => -0.0131478132,
                                                               -0.0131478132);

all4wfdn_26_c282 := map(
    NULL < f_vf_altlexid_phn_hi_risk_ct_i AND f_vf_altlexid_phn_hi_risk_ct_i <= 0.5 => -0.0070709005,
    f_vf_altlexid_phn_hi_risk_ct_i > 0.5                                            => 0.3120423551,
    f_vf_altlexid_phn_hi_risk_ct_i = NULL                                           => 0.0009497896,
                                                                                       0.0009497896);

all4wfdn_26_c284 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 1.5 => 0.1272533795,
    f_hh_members_w_derog_i > 1.5                                    => -0.0033163772,
    f_hh_members_w_derog_i = NULL                                   => 0.0665141804,
                                                                       0.0665141804);

all4wfdn_26_c283 := map(
    NULL < f_inq_email_ver_count_i AND f_inq_email_ver_count_i <= 0.5 => 0.2348758632,
    f_inq_email_ver_count_i > 0.5                                     => all4wfdn_26_c284,
    f_inq_email_ver_count_i = NULL                                    => 0.0867606060,
                                                                         0.0867606060);

all4wfdn_26_c281 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 114.5 => all4wfdn_26_c282,
    f_prevaddrageoldest_d > 114.5                                   => all4wfdn_26_c283,
    f_prevaddrageoldest_d = NULL                                    => 0.0184005028,
                                                                       0.0184005028);

all4wfdn_26 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 0.5 => all4wfdn_26_c281,
    f_inq_collection_count_i > 0.5                                      => -0.0186507019,
    f_inq_collection_count_i = NULL                                     => -0.0108056718,
                                                                           -0.0108056718);

all4wfdn_27_c289 := map(
    NULL < r_f01_inp_addr_address_score_d AND r_f01_inp_addr_address_score_d <= 16 => 0.2251964029,
    r_f01_inp_addr_address_score_d > 16                                            => 0.0631809224,
    r_f01_inp_addr_address_score_d = NULL                                          => 0.0803403422,
                                                                                      0.0803403422);

all4wfdn_27_c288 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => all4wfdn_27_c289,
    r_c20_email_verification_d > 1.5                                        => 0.0110132545,
    r_c20_email_verification_d = NULL                                       => 0.0338707982,
                                                                               0.0338707982);

all4wfdn_27_c287 := map(
    trim(c_blue_col) = ''                        => 0.0420099581,
    NULL < (integer)c_blue_col AND (real)c_blue_col <= 5.15 => 0.1832716639,
    (real)c_blue_col > 5.15                        => all4wfdn_27_c288,
                                                0.0420099581);

all4wfdn_27_c286 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_27_c287,
    f_phone_ver_experian_d > 0.5                                    => -0.0191879364,
    f_phone_ver_experian_d = NULL                                   => 0.0001774981,
                                                                       0.0160680788);

all4wfdn_27 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => -0.0365834774,
    f_idverrisktype_i > 1.5                               => all4wfdn_27_c286,
    f_idverrisktype_i = NULL                              => -0.0086910385,
                                                             -0.0086910385);

all4wfdn_28_c292 := map(
    trim(c_pop_35_44_p) = ''                            => 0.2462522315,
    NULL < (integer)c_pop_35_44_p AND (real)c_pop_35_44_p <= 14.15 => 0.0846669442,
    (real)c_pop_35_44_p > 14.15                           => 0.4234748048,
                                                       0.2462522315);

all4wfdn_28_c291 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => all4wfdn_28_c292,
    r_c20_email_verification_d > 0.5                                        => 0.0467862281,
    r_c20_email_verification_d = NULL                                       => 0.0922784745,
                                                                               0.0922784745);

all4wfdn_28_c293 := map(
    trim(c_lux_prod) = ''                         => -0.0098701801,
    NULL < (integer)c_lux_prod AND (real)c_lux_prod <= 156.5 => -0.0190577754,
    (real)c_lux_prod > 156.5                        => 0.0451577535,
                                                 -0.0098701801);

all4wfdn_28_c294 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 5.5 => -0.0046712151,
    r_e57_br_source_count_d > 5.5                                     => 0.1627390680,
    r_e57_br_source_count_d = NULL                                    => -0.0008338070,
                                                                         -0.0008338070);

all4wfdn_28 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -7783 => all4wfdn_28_c291,
    f_addrchangevaluediff_d > -7783                                     => all4wfdn_28_c293,
    f_addrchangevaluediff_d = NULL                                      => all4wfdn_28_c294,
                                                                           -0.0037889600);

all4wfdn_29_c297 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => 0.0318105045,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0258704394,
    f_corrphonelastnamecount_d = NULL                                       => 0.0050556122,
                                                                               0.0050556122);

all4wfdn_29_c299 := map(
    NULL < f_inq_banking_count_i AND f_inq_banking_count_i <= 1.5 => 0.1001545983,
    f_inq_banking_count_i > 1.5                                   => 0.2627002386,
    f_inq_banking_count_i = NULL                                  => 0.1348837547,
                                                                     0.1348837547);

all4wfdn_29_c298 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 83.5 => -0.0133383872,
    f_mos_inq_banko_cm_lseen_d > 83.5                                        => all4wfdn_29_c299,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0616600897,
                                                                                0.0616600897);

all4wfdn_29_c296 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 61.5 => all4wfdn_29_c297,
    k_comb_age_d > 61.5                          => all4wfdn_29_c298,
    k_comb_age_d = NULL                          => 0.0093137676,
                                                    0.0093137676);

all4wfdn_29 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => all4wfdn_29_c296,
    f_adl_per_email_i > 0.5                               => -0.0471742845,
    f_adl_per_email_i = NULL                              => -0.0116558083,
                                                             -0.0116558083);

all4wfdn_30_c303 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 1.5 => 0.2292788701,
    f_rel_under100miles_cnt_d > 1.5                                       => 0.0635529121,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0864049299,
                                                                             0.0864049299);

all4wfdn_30_c302 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 1285 => -0.0092727348,
    f_addrchangeincomediff_d > 1285                                      => all4wfdn_30_c303,
    f_addrchangeincomediff_d = NULL                                      => 0.0202439069,
                                                                            0.0039981504);

all4wfdn_30_c304 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 6.5 => 0.1220752655,
    f_srchaddrsrchcount_i > 6.5                                   => 0.0149704162,
    f_srchaddrsrchcount_i = NULL                                  => 0.0705464143,
                                                                     0.0705464143);

all4wfdn_30_c301 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 10.5 => all4wfdn_30_c302,
    f_corraddrnamecount_d > 10.5                                   => all4wfdn_30_c304,
    f_corraddrnamecount_d = NULL                                   => 0.0113793971,
                                                                      0.0113793971);

all4wfdn_30 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_30_c301,
    f_phone_ver_experian_d > 0.5                                    => -0.0345089392,
    f_phone_ver_experian_d = NULL                                   => 0.0070482328,
                                                                       -0.0115755012);

all4wfdn_31_c307 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -2664 => 0.1428224700,
    f_addrchangevaluediff_d > -2664                                     => 0.0031375340,
    f_addrchangevaluediff_d = NULL                                      => 0.0300205754,
                                                                           0.0155556297);

all4wfdn_31_c309 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => 0.0556196351,
    r_a41_prop_owner_inp_only_d > 0.5                                         => 0.2098526441,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.1648236967,
                                                                                 0.1648236967);

all4wfdn_31_c308 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => all4wfdn_31_c309,
    f_inq_highriskcredit_count_i > 1.5                                          => 0.0253038260,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0947842424,
                                                                                   0.0947842424);

all4wfdn_31_c306 := map(
    NULL < r_a50_pb_total_orders_d AND r_a50_pb_total_orders_d <= 4.5 => all4wfdn_31_c307,
    r_a50_pb_total_orders_d > 4.5                                     => all4wfdn_31_c308,
    r_a50_pb_total_orders_d = NULL                                    => 0.0259939696,
                                                                         0.0259939696);

all4wfdn_31 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => all4wfdn_31_c306,
    r_c20_email_verification_d > 0.5                                        => -0.0145979594,
    r_c20_email_verification_d = NULL                                       => -0.0058779684,
                                                                               -0.0058779684);

all4wfdn_32_c313 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 185 => 0.0035919541,
    r_c13_max_lres_d > 185                              => 0.1252132925,
    r_c13_max_lres_d = NULL                             => 0.0395831452,
                                                           0.0395831452);

all4wfdn_32_c312 := map(
    trim(C_INC_201K_P) = ''                           => 0.0503874849,
    NULL < (integer)C_INC_201K_P AND (real)C_INC_201K_P <= 11.65 => -0.0165275874,
    (real)C_INC_201K_P > 11.65                          => all4wfdn_32_c313,
                                                     -0.0118937280);

all4wfdn_32_c311 := map(
    NULL < f_adls_per_phone_c6_i AND f_adls_per_phone_c6_i <= 1.5 => all4wfdn_32_c312,
    f_adls_per_phone_c6_i > 1.5                                   => 0.1768386522,
    f_adls_per_phone_c6_i = NULL                                  => -0.0101880180,
                                                                     -0.0101880180);

all4wfdn_32_c314 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 10.5 => 0.0283807872,
    f_corraddrnamecount_d > 10.5                                   => 0.1401161514,
    f_corraddrnamecount_d = NULL                                   => 0.0572524395,
                                                                      0.0572524395);

all4wfdn_32 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 8.5 => all4wfdn_32_c311,
    f_historical_count_d > 8.5                                  => all4wfdn_32_c314,
    f_historical_count_d = NULL                                 => -0.0054706265,
                                                                   -0.0054706265);

all4wfdn_33_c318 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 31.5 => 0.0251854804,
    k_comb_age_d > 31.5                          => 0.1526545804,
    k_comb_age_d = NULL                          => 0.1018093640,
                                                    0.1018093640);

all4wfdn_33_c319 := map(
    trim(C_INC_201K_P) = ''                           => 0.0224125662,
    NULL < (integer)C_INC_201K_P AND (real)C_INC_201K_P <= 11.05 => 0.0132276478,
    (real)C_INC_201K_P > 11.05                          => 0.1105656342,
                                                     0.0224125662);

all4wfdn_33_c317 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 0.5 => all4wfdn_33_c318,
    f_hh_collections_ct_i > 0.5                                   => all4wfdn_33_c319,
    f_hh_collections_ct_i = NULL                                  => 0.0313006380,
                                                                     0.0313006380);

all4wfdn_33_c316 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => -0.0186881976,
    r_a41_prop_owner_inp_only_d > 0.5                                         => all4wfdn_33_c317,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.0017485349,
                                                                                 0.0017485349);

all4wfdn_33 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => all4wfdn_33_c316,
    f_adl_per_email_i > 0.5                               => -0.0448656225,
    f_adl_per_email_i = NULL                              => -0.0153771224,
                                                             -0.0153771224);

all4wfdn_34_c324 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => -0.0325421150,
    f_idverrisktype_i > 1.5                               => 0.1783889694,
    f_idverrisktype_i = NULL                              => 0.1238614038,
                                                             0.1238614038);

all4wfdn_34_c323 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 7.5 => 0.0334145016,
    f_corraddrnamecount_d > 7.5                                   => all4wfdn_34_c324,
    f_corraddrnamecount_d = NULL                                  => 0.0603347807,
                                                                     0.0603347807);

all4wfdn_34_c322 := map(
    trim(c_housingcpi) = ''                           => -0.0072900971,
    NULL < (integer)c_housingcpi AND (real)c_housingcpi <= 186.4 => all4wfdn_34_c323,
    (real)c_housingcpi > 186.4                          => 0.0010355679,
                                                     0.0088114049);

all4wfdn_34_c321 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => all4wfdn_34_c322,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0328054201,
    f_corrphonelastnamecount_d = NULL                                       => -0.0115328744,
                                                                               -0.0115328744);

all4wfdn_34 := map(
    NULL < r_p85_phn_disconnected_i AND r_p85_phn_disconnected_i <= 0.5 => all4wfdn_34_c321,
    r_p85_phn_disconnected_i > 0.5                                      => 0.1142675236,
    r_p85_phn_disconnected_i = NULL                                     => -0.0102315400,
                                                                           -0.0102315400);

all4wfdn_35_c329 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 3.5 => 0.1729956185,
    f_inq_highriskcredit_count_i > 3.5                                          => 0.0469016281,
    f_inq_highriskcredit_count_i = NULL                                         => 0.1358669471,
                                                                                   0.1358669471);

all4wfdn_35_c328 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 40.5 => 0.0249107166,
    f_prevaddrageoldest_d > 40.5                                   => all4wfdn_35_c329,
    f_prevaddrageoldest_d = NULL                                   => 0.0865725585,
                                                                      0.0865725585);

all4wfdn_35_c327 := map(
    trim(c_housingcpi) = ''                           => 0.0341827238,
    NULL < (integer)c_housingcpi AND (real)c_housingcpi <= 186.4 => all4wfdn_35_c328,
    (real)c_housingcpi > 186.4                          => 0.0254083109,
                                                     0.0341827238);

all4wfdn_35_c326 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_35_c327,
    f_phone_ver_experian_d > 0.5                                    => -0.0304268254,
    f_phone_ver_experian_d = NULL                                   => 0.0274464857,
                                                                       0.0114072905);

all4wfdn_35 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => all4wfdn_35_c326,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0239080175,
    f_corrphonelastnamecount_d = NULL                                       => -0.0058443153,
                                                                               -0.0058443153);

all4wfdn_36_c333 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 5.5 => 0.0873202976,
    f_srchvelocityrisktype_i > 5.5                                      => 0.0110193067,
    f_srchvelocityrisktype_i = NULL                                     => 0.0361692276,
                                                                           0.0361692276);

all4wfdn_36_c332 := map(
    trim(C_OWNOCC_P) = ''                         => -0.0019530912,
    NULL < (integer)C_OWNOCC_P AND (real)C_OWNOCC_P <= 71.15 => -0.0196823712,
    (real)C_OWNOCC_P > 71.15                        => all4wfdn_36_c333,
                                                 -0.0019530912);

all4wfdn_36_c334 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => 0.1279752775,
    f_inq_highriskcredit_count_i > 1.5                                          => 0.0316025076,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0809724178,
                                                                                   0.0809724178);

all4wfdn_36_c331 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 1.5 => all4wfdn_36_c332,
    r_e57_br_source_count_d > 1.5                                     => all4wfdn_36_c334,
    r_e57_br_source_count_d = NULL                                    => 0.0058629551,
                                                                         0.0058629551);

all4wfdn_36 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => all4wfdn_36_c331,
    f_hh_lienholders_i > 0.5                                => -0.0207861212,
    f_hh_lienholders_i = NULL                               => -0.0103575657,
                                                               -0.0103575657);

all4wfdn_37_c337 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 2.5 => 0.2511988520,
    f_inq_collection_count_i > 2.5                                      => 0.0595006308,
    f_inq_collection_count_i = NULL                                     => 0.1580573434,
                                                                           0.1580573434);

all4wfdn_37_c336 := map(
    trim(c_med_hhinc) = ''                          => 0.0750134776,
    NULL < (integer)c_med_hhinc AND (integer)c_med_hhinc <= 61943 => 0.0295064675,
    (integer)c_med_hhinc > 61943                         => all4wfdn_37_c337,
                                                   0.0750134776);

all4wfdn_37_c339 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 106436 => -0.0069669394,
    f_curraddrmedianincome_d > 106436                                      => 0.0642351443,
    f_curraddrmedianincome_d = NULL                                        => -0.0039330098,
                                                                              -0.0039330098);

all4wfdn_37_c338 := map(
    NULL < f_adls_per_phone_c6_i AND f_adls_per_phone_c6_i <= 1.5 => all4wfdn_37_c339,
    f_adls_per_phone_c6_i > 1.5                                   => 0.1415677035,
    f_adls_per_phone_c6_i = NULL                                  => -0.0027282423,
                                                                     -0.0027282423);

all4wfdn_37 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 95 => all4wfdn_37_c336,
    r_f00_dob_score_d > 95                               => all4wfdn_37_c338,
    r_f00_dob_score_d = NULL                             => 0.0229479576,
                                                            -0.0004976574);

all4wfdn_38_c344 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.33478693765 => 0.0168234049,
    f_add_curr_mobility_index_i > 0.33478693765                                         => 0.0727326001,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0352799153,
                                                                                           0.0352799153);

all4wfdn_38_c343 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 227.5 => all4wfdn_38_c344,
    r_c13_max_lres_d > 227.5                              => 0.1723534050,
    r_c13_max_lres_d = NULL                               => 0.0651456643,
                                                             0.0651456643);

all4wfdn_38_c342 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => all4wfdn_38_c343,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.2235822507,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.1041716638,
                                                                                       0.1041716638);

all4wfdn_38_c341 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => all4wfdn_38_c342,
    f_phone_ver_insurance_d > 3.5                                     => 0.0060931980,
    f_phone_ver_insurance_d = NULL                                    => 0.0385532000,
                                                                         0.0385532000);

all4wfdn_38 := map(
    NULL < f_inq_email_ver_count_i AND f_inq_email_ver_count_i <= 0.5 => all4wfdn_38_c341,
    f_inq_email_ver_count_i > 0.5                                     => -0.0113705738,
    f_inq_email_ver_count_i = NULL                                    => -0.0070556045,
                                                                         -0.0070556045);

all4wfdn_39_c347 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.0741925074,
    r_f00_dob_score_d > 98                               => -0.0067653527,
    r_f00_dob_score_d = NULL                             => 0.0148638117,
                                                            -0.0043815360);

all4wfdn_39_c348 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 0.5 => 0.1853704367,
    f_srchunvrfdphonecount_i > 0.5                                      => 0.0300691994,
    f_srchunvrfdphonecount_i = NULL                                     => 0.0888656402,
                                                                           0.0888656402);

all4wfdn_39_c346 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 15.5 => all4wfdn_39_c347,
    f_bus_addr_match_count_d > 15.5                                      => all4wfdn_39_c348,
    f_bus_addr_match_count_d = NULL                                      => -0.0030559275,
                                                                            -0.0030559275);

all4wfdn_39_c349 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.2604273989,
    f_phone_ver_experian_d > 0.5                                    => 0.0352156190,
    f_phone_ver_experian_d = NULL                                   => 0.1414953354,
                                                                       0.1414953354);

all4wfdn_39 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => all4wfdn_39_c346,
    k_inq_adls_per_phone_i > 2.5                                    => all4wfdn_39_c349,
    k_inq_adls_per_phone_i = NULL                                   => -0.0014910490,
                                                                       -0.0014910490);

all4wfdn_40_c354 := map(
    trim(c_employees) = ''                        => 0.1480304343,
    NULL < (integer)c_employees AND (integer)c_employees <= 319 => 0.3146770146,
    (integer)c_employees > 319                         => 0.0178033053,
                                                 0.1480304343);

all4wfdn_40_c353 := map(
    trim(c_civ_emp) = ''                        => 0.0219790969,
    NULL < (integer)c_civ_emp AND (real)c_civ_emp <= 69.15 => 0.0025142233,
    (real)c_civ_emp > 69.15                       => all4wfdn_40_c354,
                                               0.0219790969);

all4wfdn_40_c352 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => 0.1599790609,
    f_rel_under100miles_cnt_d > 0.5                                       => all4wfdn_40_c353,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0356737498,
                                                                             0.0356737498);

all4wfdn_40_c351 := map(
    NULL < f_corrrisktype_i AND f_corrrisktype_i <= 8.5 => -0.0104236752,
    f_corrrisktype_i > 8.5                              => all4wfdn_40_c352,
    f_corrrisktype_i = NULL                             => -0.0069352785,
                                                           -0.0069352785);

all4wfdn_40 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 121500 => all4wfdn_40_c351,
    k_estimated_income_d > 121500                                  => 0.1191290914,
    k_estimated_income_d = NULL                                    => -0.0054477271,
                                                                      -0.0054477271);

all4wfdn_41_c357 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 1.5 => 0.2155065536,
    f_hh_members_w_derog_i > 1.5                                    => -0.0336596029,
    f_hh_members_w_derog_i = NULL                                   => 0.0955206369,
                                                                       0.0955206369);

all4wfdn_41_c356 := map(
    NULL < f_adls_per_phone_c6_i AND f_adls_per_phone_c6_i <= 1.5 => -0.0090832954,
    f_adls_per_phone_c6_i > 1.5                                   => all4wfdn_41_c357,
    f_adls_per_phone_c6_i = NULL                                  => -0.0076523179,
                                                                     -0.0076523179);

all4wfdn_41_c359 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => 0.0193107408,
    f_curraddractivephonelist_d > 0.5                                         => 0.1527243156,
    f_curraddractivephonelist_d = NULL                                        => 0.0477940345,
                                                                                 0.0477940345);

all4wfdn_41_c358 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 221.5 => all4wfdn_41_c359,
    r_c13_max_lres_d > 221.5                              => 0.1933981301,
    r_c13_max_lres_d = NULL                               => 0.0691300802,
                                                             0.0691300802);

all4wfdn_41 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 126 => all4wfdn_41_c356,
    r_p88_phn_dst_to_inp_add_i > 126                                        => all4wfdn_41_c358,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => 0.0097725214,
                                                                               0.0005421942);

all4wfdn_42_c364 := map(
    trim(c_rnt500_p) = ''                         => 0.1393618947,
    NULL < (integer)c_rnt500_p AND (real)c_rnt500_p <= 38.05 => 0.1063696448,
    (real)c_rnt500_p > 38.05                        => 0.2884988075,
                                                 0.1393618947);

all4wfdn_42_c363 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 2.5 => all4wfdn_42_c364,
    f_inq_highriskcredit_count_i > 2.5                                          => 0.0290040661,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0905354062,
                                                                                   0.0905354062);

all4wfdn_42_c362 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 1.5 => 0.0107606484,
    r_c20_email_count_i > 1.5                                 => all4wfdn_42_c363,
    r_c20_email_count_i = NULL                                => 0.0463822770,
                                                                 0.0463822770);

all4wfdn_42_c361 := map(
    NULL < f_idverrisktype_i AND f_idverrisktype_i <= 1.5 => -0.0160561951,
    f_idverrisktype_i > 1.5                               => all4wfdn_42_c362,
    f_idverrisktype_i = NULL                              => 0.0200782085,
                                                             0.0200782085);

all4wfdn_42 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => all4wfdn_42_c361,
    r_c20_email_verification_d > 1.5                                        => -0.0161737058,
    r_c20_email_verification_d = NULL                                       => -0.0060967235,
                                                                               -0.0060967235);

all4wfdn_43_c367 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 74.6 => 0.0134797332,
    r_c12_source_profile_d > 74.6                                    => -0.0642290816,
    r_c12_source_profile_d = NULL                                    => 0.0034491393,
                                                                        0.0034491393);

all4wfdn_43_c369 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.2893199824 => 0.1639824416,
    f_add_curr_mobility_index_i > 0.2893199824                                         => 0.2143044289,
    f_add_curr_mobility_index_i = NULL                                                 => 0.1896936757,
                                                                                          0.1896936757);

all4wfdn_43_c368 := map(
    NULL < r_i60_inq_hiriskcred_recency_d AND r_i60_inq_hiriskcred_recency_d <= 61.5 => 0.0142018657,
    r_i60_inq_hiriskcred_recency_d > 61.5                                            => all4wfdn_43_c369,
    r_i60_inq_hiriskcred_recency_d = NULL                                            => 0.0805402591,
                                                                                        0.0805402591);

all4wfdn_43_c366 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 7.5 => all4wfdn_43_c367,
    f_historical_count_d > 7.5                                  => all4wfdn_43_c368,
    f_historical_count_d = NULL                                 => 0.0117562451,
                                                                   0.0117562451);

all4wfdn_43 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 124.5 => -0.0016901072,
    f_addrchangecrimediff_i > 124.5                                     => 0.2057643117,
    f_addrchangecrimediff_i = NULL                                      => all4wfdn_43_c366,
                                                                           0.0020326108);

all4wfdn_44_c374 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 133.5 => 0.0363447527,
    r_c13_curr_addr_lres_d > 133.5                                    => 0.1609418830,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0867138054,
                                                                         0.0867138054);

all4wfdn_44_c373 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 38500 => -0.0381387054,
    k_estimated_income_d > 38500                                  => all4wfdn_44_c374,
    k_estimated_income_d = NULL                                   => 0.0303434887,
                                                                     0.0303434887);

all4wfdn_44_c372 := map(
    trim(c_rnt1250_p) = ''                         => 0.0762476724,
    NULL < (integer)c_rnt1250_p AND (real)c_rnt1250_p <= 2.25 => all4wfdn_44_c373,
    (real)c_rnt1250_p > 2.25                         => 0.1763027373,
                                                  0.0762476724);

all4wfdn_44_c371 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 3.5 => all4wfdn_44_c372,
    f_srchfraudsrchcount_i > 3.5                                    => 0.0197985804,
    f_srchfraudsrchcount_i = NULL                                   => 0.0341743863,
                                                                       0.0341743863);

all4wfdn_44 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 6.5 => -0.0088564304,
    f_historical_count_d > 6.5                                  => all4wfdn_44_c371,
    f_historical_count_d = NULL                                 => -0.0033018887,
                                                                   -0.0033018887);

all4wfdn_45_c379 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => 0.0755690285,
    f_srchunvrfdaddrcount_i > 0.5                                     => 0.2847190626,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0909282359,
                                                                         0.0909282359);

all4wfdn_45_c378 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 73.5 => 0.0064267996,
    f_prevaddrageoldest_d > 73.5                                   => all4wfdn_45_c379,
    f_prevaddrageoldest_d = NULL                                   => 0.0456206182,
                                                                      0.0456206182);

all4wfdn_45_c377 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 38.5 => 0.0171631142,
    r_pb_order_freq_d > 38.5                               => all4wfdn_45_c378,
    r_pb_order_freq_d = NULL                               => -0.0125497446,
                                                              0.0103853742);

all4wfdn_45_c376 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 4.5 => all4wfdn_45_c377,
    r_c20_email_verification_d > 4.5                                        => -0.0341665612,
    r_c20_email_verification_d = NULL                                       => -0.0060441282,
                                                                               -0.0060441282);

all4wfdn_45 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 80 => 0.1480038300,
    r_f00_dob_score_d > 80                               => all4wfdn_45_c376,
    r_f00_dob_score_d = NULL                             => 0.0075903024,
                                                            -0.0050041168);

all4wfdn_46_c382 := map(
    trim(c_civ_emp) = ''                       => 0.0985381645,
    NULL < (integer)c_civ_emp AND (real)c_civ_emp <= 70.6 => 0.0702060777,
    (real)c_civ_emp > 70.6                       => 0.2206237024,
                                              0.0985381645);

all4wfdn_46_c381 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => all4wfdn_46_c382,
    f_phone_ver_insurance_d > 3.5                                     => -0.0010000168,
    f_phone_ver_insurance_d = NULL                                    => 0.0317079758,
                                                                         0.0317079758);

all4wfdn_46_c384 := map(
    trim(c_rich_old) = ''                         => 0.0316419976,
    NULL < (integer)c_rich_old AND (real)c_rich_old <= 175.5 => 0.0216883668,
    (real)c_rich_old > 175.5                        => 0.1813215623,
                                                 0.0316419976);

all4wfdn_46_c383 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => -0.0182213933,
    f_srchunvrfdphonecount_i > 1.5                                      => all4wfdn_46_c384,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0075499259,
                                                                           -0.0075499259);

all4wfdn_46 := map(
    NULL < f_inq_email_ver_count_i AND f_inq_email_ver_count_i <= 0.5 => all4wfdn_46_c381,
    f_inq_email_ver_count_i > 0.5                                     => all4wfdn_46_c383,
    f_inq_email_ver_count_i = NULL                                    => -0.0040603064,
                                                                         -0.0040603064);

all4wfdn_47_c388 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 39500 => -0.0223866361,
    k_estimated_income_d > 39500                                  => 0.1129167313,
    k_estimated_income_d = NULL                                   => 0.0441055593,
                                                                     0.0441055593);

all4wfdn_47_c389 := map(
    trim(C_INC_15K_P) = ''                         => 0.0861998307,
    NULL < (integer)C_INC_15K_P AND (real)C_INC_15K_P <= 4.65 => 0.1566390824,
    (real)C_INC_15K_P > 4.65                         => 0.0576990258,
                                                  0.0861998307);

all4wfdn_47_c387 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 10.5 => all4wfdn_47_c388,
    r_pb_order_freq_d > 10.5                               => all4wfdn_47_c389,
    r_pb_order_freq_d = NULL                               => -0.0062063257,
                                                              0.0379318624);

all4wfdn_47_c386 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 1.5 => all4wfdn_47_c387,
    f_inq_collection_count_i > 1.5                                      => -0.0045029737,
    f_inq_collection_count_i = NULL                                     => 0.0104366515,
                                                                           0.0104366515);

all4wfdn_47 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 43.5 => -0.0214178808,
    f_prevaddrageoldest_d > 43.5                                   => all4wfdn_47_c386,
    f_prevaddrageoldest_d = NULL                                   => -0.0050138184,
                                                                      -0.0050138184);

all4wfdn_48_c394 := map(
    trim(c_femdiv_p) = ''                        => 0.1011424160,
    NULL < (integer)c_femdiv_p AND (real)c_femdiv_p <= 1.75 => 0.2218787367,
    (real)c_femdiv_p > 1.75                        => 0.0823785845,
                                                0.1011424160);

all4wfdn_48_c393 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 3.5 => all4wfdn_48_c394,
    f_inq_highriskcredit_count_i > 3.5                                          => -0.0250114833,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0686021308,
                                                                                   0.0686021308);

all4wfdn_48_c392 := map(
    NULL < (integer)f_nae_email_verd_d AND (real)f_nae_email_verd_d <= 0.5 => all4wfdn_48_c393,
    (real)f_nae_email_verd_d > 0.5                                => -0.0556001659,
    (integer)f_nae_email_verd_d = NULL                               => 0.0326338100,
                                                               0.0326338100);

all4wfdn_48_c391 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 49.5 => 0.0095504670,
    k_comb_age_d > 49.5                          => all4wfdn_48_c392,
    k_comb_age_d = NULL                          => 0.0141039614,
                                                    0.0141039614);

all4wfdn_48 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => all4wfdn_48_c391,
    f_hh_lienholders_i > 0.5                                => -0.0172332226,
    f_hh_lienholders_i = NULL                               => -0.0049076531,
                                                               -0.0049076531);

all4wfdn_49_c399 := map(
    NULL < r_wealth_index_d AND r_wealth_index_d <= 3.5 => 0.0411574509,
    r_wealth_index_d > 3.5                              => 0.1986380996,
    r_wealth_index_d = NULL                             => 0.0929074658,
                                                           0.0929074658);

all4wfdn_49_c398 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => all4wfdn_49_c399,
    r_f03_input_add_not_most_rec_i > 0.5                                            => 0.2854342784,
    r_f03_input_add_not_most_rec_i = NULL                                           => 0.1434030039,
                                                                                       0.1434030039);

all4wfdn_49_c397 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 3.5 => all4wfdn_49_c398,
    f_inq_highriskcredit_count_i > 3.5                                          => -0.0074922276,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0748846900,
                                                                                   0.0748846900);

all4wfdn_49_c396 := map(
    NULL < r_a50_pb_total_dollars_d AND r_a50_pb_total_dollars_d <= 2145.5 => all4wfdn_49_c397,
    r_a50_pb_total_dollars_d > 2145.5                                      => -0.0327407867,
    r_a50_pb_total_dollars_d = NULL                                        => 0.0324293206,
                                                                              0.0324293206);

all4wfdn_49 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -931.5 => all4wfdn_49_c396,
    f_addrchangevaluediff_d > -931.5                                     => -0.0117539604,
    f_addrchangevaluediff_d = NULL                                       => 0.0085939744,
                                                                            -0.0055387551);

all4wfdn_50_c403 := map(
    trim(c_bargains) = ''                       => 0.1411351127,
    NULL < (integer)c_bargains AND (integer)c_bargains <= 121 => 0.0744588184,
    (integer)c_bargains > 121                        => 0.2539197596,
                                               0.1411351127);

all4wfdn_50_c404 := map(
    trim(c_new_homes) = ''                          => 0.0289022929,
    NULL < (integer)c_new_homes AND (real)c_new_homes <= 141.5 => -0.0122760887,
    (real)c_new_homes > 141.5                         => 0.0815747956,
                                                   0.0289022929);

all4wfdn_50_c402 := map(
    NULL < r_c14_addrs_10yr_i AND r_c14_addrs_10yr_i <= 0.5 => all4wfdn_50_c403,
    r_c14_addrs_10yr_i > 0.5                                => all4wfdn_50_c404,
    r_c14_addrs_10yr_i = NULL                               => 0.0460997748,
                                                               0.0460997748);

all4wfdn_50_c401 := map(
    NULL < f_inq_email_ver_count_i AND f_inq_email_ver_count_i <= 0.5 => all4wfdn_50_c402,
    f_inq_email_ver_count_i > 0.5                                     => -0.0042877186,
    f_inq_email_ver_count_i = NULL                                    => 0.0000224082,
                                                                         0.0000224082);

all4wfdn_50 := map(
    NULL < f_vf_altlexid_phn_hi_risk_ct_i AND f_vf_altlexid_phn_hi_risk_ct_i <= 1.5 => all4wfdn_50_c401,
    f_vf_altlexid_phn_hi_risk_ct_i > 1.5                                            => 0.1937749858,
    f_vf_altlexid_phn_hi_risk_ct_i = NULL                                           => 0.0013182127,
                                                                                       0.0013182127);

all4wfdn_51_c407 := map(
    NULL < r_i60_inq_banking_recency_d AND r_i60_inq_banking_recency_d <= 18 => 0.1363125061,
    r_i60_inq_banking_recency_d > 18                                         => 0.0133662393,
    r_i60_inq_banking_recency_d = NULL                                       => 0.0336724235,
                                                                                0.0336724235);

all4wfdn_51_c408 := map(
    trim(c_rich_old) = ''                         => 0.0020669825,
    NULL < (integer)c_rich_old AND (real)c_rich_old <= 181.5 => -0.0036360551,
    (real)c_rich_old > 181.5                        => 0.1370937489,
                                                 0.0020669825);

all4wfdn_51_c406 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -931.5 => all4wfdn_51_c407,
    f_addrchangevaluediff_d > -931.5                                     => -0.0134242670,
    f_addrchangevaluediff_d = NULL                                       => all4wfdn_51_c408,
                                                                            -0.0080227340);

all4wfdn_51_c409 := map(
    trim(c_rich_asian) = ''                           => 0.0478610978,
    NULL < (integer)c_rich_asian AND (real)c_rich_asian <= 126.5 => 0.1875037143,
    (real)c_rich_asian > 126.5                          => 0.0068919477,
                                                     0.0478610978);

all4wfdn_51 := map(
    trim(c_med_hhinc) = ''                           => -0.0245321989,
    NULL < (integer)c_med_hhinc AND (integer)c_med_hhinc <= 112301 => all4wfdn_51_c406,
    (integer)c_med_hhinc > 112301                         => all4wfdn_51_c409,
                                                    -0.0063743493);

all4wfdn_52_c414 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 0.5 => -0.0283565440,
    r_c20_email_count_i > 0.5                                 => 0.0803132564,
    r_c20_email_count_i = NULL                                => 0.0458831291,
                                                                 0.0458831291);

all4wfdn_52_c413 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 3.5 => all4wfdn_52_c414,
    r_c20_email_verification_d > 3.5                                        => -0.0244380815,
    r_c20_email_verification_d = NULL                                       => 0.0217551509,
                                                                               0.0217551509);

all4wfdn_52_c412 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => all4wfdn_52_c413,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0312284914,
    f_corrphonelastnamecount_d = NULL                                       => 0.0047115039,
                                                                               0.0047115039);

all4wfdn_52_c411 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_52_c412,
    f_phone_ver_experian_d > 0.5                                    => -0.0299473132,
    f_phone_ver_experian_d = NULL                                   => -0.0088625480,
                                                                       -0.0134969493);

all4wfdn_52 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 8.5 => all4wfdn_52_c411,
    f_varrisktype_i > 8.5                             => 0.2408818118,
    f_varrisktype_i = NULL                            => -0.0119834265,
                                                         -0.0119834265);

all4wfdn_53_c418 := map(
    trim(C_INC_100K_P) = ''                          => 0.1218801891,
    NULL < (integer)C_INC_100K_P AND (real)C_INC_100K_P <= 18.1 => 0.0873647211,
    (real)C_INC_100K_P > 18.1                          => 0.2501815395,
                                                    0.1218801891);

all4wfdn_53_c419 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 4.5 => 0.0166266195,
    r_d32_criminal_count_i > 4.5                                    => 0.2367591141,
    r_d32_criminal_count_i = NULL                                   => 0.0282229289,
                                                                       0.0282229289);

all4wfdn_53_c417 := map(
    NULL < f_hh_members_w_derog_i AND f_hh_members_w_derog_i <= 0.5 => all4wfdn_53_c418,
    f_hh_members_w_derog_i > 0.5                                    => all4wfdn_53_c419,
    f_hh_members_w_derog_i = NULL                                   => 0.0477618571,
                                                                       0.0477618571);

all4wfdn_53_c416 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 7.5 => 0.0024333038,
    f_corraddrnamecount_d > 7.5                                   => all4wfdn_53_c417,
    f_corraddrnamecount_d = NULL                                  => 0.0132883552,
                                                                     0.0132883552);

all4wfdn_53 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => all4wfdn_53_c416,
    f_phone_ver_insurance_d > 3.5                                     => -0.0226520433,
    f_phone_ver_insurance_d = NULL                                    => -0.0089722244,
                                                                         -0.0089722244);

all4wfdn_54_c424 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 0.5 => -0.0009633626,
    r_c20_email_count_i > 0.5                                 => 0.1471512498,
    r_c20_email_count_i = NULL                                => 0.1120039601,
                                                                 0.1120039601);

all4wfdn_54_c423 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 3.5 => all4wfdn_54_c424,
    f_inq_highriskcredit_count_i > 3.5                                          => 0.0130490146,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0813590846,
                                                                                   0.0813590846);

all4wfdn_54_c422 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_54_c423,
    r_phn_cell_n > 0.5                          => 0.0052135324,
    r_phn_cell_n = NULL                         => 0.0389023334,
                                                   0.0389023334);

all4wfdn_54_c421 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => all4wfdn_54_c422,
    f_adl_per_email_i > 0.5                               => -0.0238154998,
    f_adl_per_email_i = NULL                              => 0.0142325139,
                                                             0.0142325139);

all4wfdn_54 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 1.5 => -0.0060027895,
    f_bus_addr_match_count_d > 1.5                                      => all4wfdn_54_c421,
    f_bus_addr_match_count_d = NULL                                     => -0.0029414371,
                                                                           -0.0029414371);

all4wfdn_55_c428 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 7.5 => 0.0264960319,
    f_corraddrnamecount_d > 7.5                                   => 0.1087211252,
    f_corraddrnamecount_d = NULL                                  => 0.0504575026,
                                                                     0.0504575026);

all4wfdn_55_c427 := map(
    trim(r_d31_bk_chapter_n) = ''                             => all4wfdn_55_c428,
    NULL < (integer)r_d31_bk_chapter_n AND (integer)r_d31_bk_chapter_n <= 9 => -0.0622677459,
    (integer)r_d31_bk_chapter_n > 9                                => 0.0242491252,
                                                             0.0295125385);

all4wfdn_55_c426 := map(
    trim(C_INC_201K_P) = ''                          => 0.0179135520,
    NULL < (integer)C_INC_201K_P AND (real)C_INC_201K_P <= 8.15 => -0.0081937824,
    (real)C_INC_201K_P > 8.15                          => all4wfdn_55_c427,
                                                    -0.0032275760);

all4wfdn_55_c429 := map(
    trim(c_low_ed) = ''                      => 0.1365527439,
    NULL < (integer)c_low_ed AND (real)c_low_ed <= 41.9 => 0.2497772244,
    (real)c_low_ed > 41.9                      => 0.0450095469,
                                            0.1365527439);

all4wfdn_55 := map(
    NULL < f_adls_per_phone_c6_i AND f_adls_per_phone_c6_i <= 1.5 => all4wfdn_55_c426,
    f_adls_per_phone_c6_i > 1.5                                   => all4wfdn_55_c429,
    f_adls_per_phone_c6_i = NULL                                  => -0.0020526856,
                                                                     -0.0020526856);

all4wfdn_56_c434 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 2.5 => 0.1808638844,
    f_inq_highriskcredit_count_i > 2.5                                          => 0.0075480603,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0873578837,
                                                                                   0.0873578837);

all4wfdn_56_c433 := map(
    NULL < r_f03_input_add_not_most_rec_i AND r_f03_input_add_not_most_rec_i <= 0.5 => -0.0028211631,
    r_f03_input_add_not_most_rec_i > 0.5                                            => all4wfdn_56_c434,
    r_f03_input_add_not_most_rec_i = NULL                                           => -0.0004641873,
                                                                                       -0.0004641873);

all4wfdn_56_c432 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -68.5 => 0.1343903754,
    f_addrchangecrimediff_i > -68.5                                     => all4wfdn_56_c433,
    f_addrchangecrimediff_i = NULL                                      => 0.0054061850,
                                                                           0.0024745083);

all4wfdn_56_c431 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 0.5 => -0.0339873528,
    r_c20_email_count_i > 0.5                                 => all4wfdn_56_c432,
    r_c20_email_count_i = NULL                                => -0.0042270492,
                                                                 -0.0042270492);

all4wfdn_56 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 2.5 => all4wfdn_56_c431,
    f_validationrisktype_i > 2.5                                    => 0.1072406300,
    f_validationrisktype_i = NULL                                   => -0.0035849272,
                                                                       -0.0035849272);

all4wfdn_57_c439 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 3.5 => 0.0965290815,
    f_inq_highriskcredit_count_i > 3.5                                          => -0.0363499576,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0633938504,
                                                                                   0.0633938504);

all4wfdn_57_c438 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 83.5 => -0.0087999412,
    f_mos_inq_banko_cm_lseen_d > 83.5                                        => all4wfdn_57_c439,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0276388581,
                                                                                0.0276388581);

all4wfdn_57_c437 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 45.5 => -0.0042027803,
    k_comb_age_d > 45.5                          => all4wfdn_57_c438,
    k_comb_age_d = NULL                          => 0.0039850320,
                                                    0.0039850320);

all4wfdn_57_c436 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => all4wfdn_57_c437,
    f_hh_lienholders_i > 0.5                                => -0.0194693521,
    f_hh_lienholders_i = NULL                               => -0.0102351986,
                                                               -0.0102351986);

all4wfdn_57 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 8.5 => all4wfdn_57_c436,
    f_varrisktype_i > 8.5                             => 0.2281853981,
    f_varrisktype_i = NULL                            => -0.0088176792,
                                                         -0.0088176792);

all4wfdn_58_c444 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => 0.1500657272,
    r_phn_cell_n > 0.5                          => -0.0681941742,
    r_phn_cell_n = NULL                         => 0.0473316710,
                                                   0.0473316710);

all4wfdn_58_c443 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.30132796425 => all4wfdn_58_c444,
    f_add_curr_mobility_index_i > 0.30132796425                                         => 0.1660279035,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0870898488,
                                                                                           0.0870898488);

all4wfdn_58_c442 := map(
    NULL < f_property_owners_ct_d AND f_property_owners_ct_d <= 1.5 => -0.0010973560,
    f_property_owners_ct_d > 1.5                                    => all4wfdn_58_c443,
    f_property_owners_ct_d = NULL                                   => 0.0168247685,
                                                                       0.0168247685);

all4wfdn_58_c441 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 0.5 => all4wfdn_58_c442,
    f_hh_collections_ct_i > 0.5                                   => -0.0241090361,
    f_hh_collections_ct_i = NULL                                  => -0.0191250166,
                                                                     -0.0191250166);

all4wfdn_58 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 2.5 => all4wfdn_58_c441,
    f_inq_count24_i > 2.5                             => 0.0200401105,
    f_inq_count24_i = NULL                            => -0.0012465661,
                                                         -0.0012465661);

all4wfdn_59_c449 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 3.5 => 0.1261448045,
    f_inq_highriskcredit_count_i > 3.5                                          => -0.0176155311,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0993666685,
                                                                                   0.0993666685);

all4wfdn_59_c448 := map(
    trim(c_food) = ''                    => 0.0753799325,
    NULL < (integer)c_food AND (real)c_food <= 3.25 => -0.0805753517,
    (real)c_food > 3.25                    => all4wfdn_59_c449,
                                        0.0753799325);

all4wfdn_59_c447 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 100.5 => 0.0040809033,
    f_mos_inq_banko_cm_fseen_d > 100.5                                        => all4wfdn_59_c448,
    f_mos_inq_banko_cm_fseen_d = NULL                                         => 0.0409608660,
                                                                                 0.0409608660);

all4wfdn_59_c446 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 50.5 => 0.0064736268,
    k_comb_age_d > 50.5                          => all4wfdn_59_c447,
    k_comb_age_d = NULL                          => 0.0125109137,
                                                    0.0125109137);

all4wfdn_59 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => all4wfdn_59_c446,
    f_hh_lienholders_i > 0.5                                => -0.0130732885,
    f_hh_lienholders_i = NULL                               => -0.0029931568,
                                                               -0.0029931568);

all4wfdn_60_c452 := map(
    trim(c_murders) = ''                       => 0.0849765361,
    NULL < (integer)c_murders AND (real)c_murders <= 80.5 => 0.1888758878,
    (real)c_murders > 80.5                       => -0.0043470073,
                                              0.0849765361);

all4wfdn_60_c451 := map(
    NULL < f_adls_per_phone_c6_i AND f_adls_per_phone_c6_i <= 1.5 => -0.0038267507,
    f_adls_per_phone_c6_i > 1.5                                   => all4wfdn_60_c452,
    f_adls_per_phone_c6_i = NULL                                  => -0.0030485187,
                                                                     -0.0030485187);

all4wfdn_60_c454 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => -0.0502683117,
    f_curraddractivephonelist_d > 0.5                                         => 0.0564733448,
    f_curraddractivephonelist_d = NULL                                        => 0.0132415657,
                                                                                 0.0132415657);

all4wfdn_60_c453 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => 0.2045498218,
    f_hh_lienholders_i > 0.5                                => all4wfdn_60_c454,
    f_hh_lienholders_i = NULL                               => 0.0756719940,
                                                               0.0756719940);

all4wfdn_60 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 12.5 => all4wfdn_60_c451,
    f_bus_addr_match_count_d > 12.5                                      => all4wfdn_60_c453,
    f_bus_addr_match_count_d = NULL                                      => -0.0015937249,
                                                                            -0.0015937249);

all4wfdn_61_c458 := map(
    trim(c_many_cars) = ''                       => 0.1187486778,
    NULL < (integer)c_many_cars AND (integer)c_many_cars <= 89 => 0.0046832571,
    (integer)c_many_cars > 89                         => 0.2428786944,
                                                0.1187486778);

all4wfdn_61_c459 := map(
    trim(c_housingcpi) = ''                           => -0.0086302035,
    NULL < (integer)c_housingcpi AND (real)c_housingcpi <= 186.4 => 0.0603847189,
    (real)c_housingcpi > 186.4                          => 0.0037191383,
                                                     0.0111954352);

all4wfdn_61_c457 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 18 => all4wfdn_61_c458,
    r_i60_inq_prepaidcards_recency_d > 18                                              => all4wfdn_61_c459,
    r_i60_inq_prepaidcards_recency_d = NULL                                            => 0.0131574805,
                                                                                          0.0131574805);

all4wfdn_61_c456 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 0.5 => 0.1434097003,
    f_rel_under500miles_cnt_d > 0.5                                       => all4wfdn_61_c457,
    f_rel_under500miles_cnt_d = NULL                                      => -0.0364519709,
                                                                             0.0145474585);

all4wfdn_61 := map(
    NULL < f_corrphonelastnamecount_d AND f_corrphonelastnamecount_d <= 0.5 => all4wfdn_61_c456,
    f_corrphonelastnamecount_d > 0.5                                        => -0.0207539634,
    f_corrphonelastnamecount_d = NULL                                       => -0.0025573777,
                                                                               -0.0025573777);

all4wfdn_62_c463 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 4.5 => 0.0166609585,
    r_c20_email_verification_d > 4.5                                        => -0.0325447101,
    r_c20_email_verification_d = NULL                                       => -0.0055957331,
                                                                               -0.0055957331);

all4wfdn_62_c462 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 0.5 => -0.0304691038,
    r_c20_email_count_i > 0.5                                 => all4wfdn_62_c463,
    r_c20_email_count_i = NULL                                => -0.0102635044,
                                                                 -0.0102635044);

all4wfdn_62_c461 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 38.5 => all4wfdn_62_c462,
    f_bus_addr_match_count_d > 38.5                                      => 0.1423467826,
    f_bus_addr_match_count_d = NULL                                      => -0.0095499875,
                                                                            -0.0095499875);

all4wfdn_62_c464 := map(
    NULL < f_corraddrphonecount_d AND f_corraddrphonecount_d <= 0.5 => 0.2970294283,
    f_corraddrphonecount_d > 0.5                                    => 0.0106744272,
    f_corraddrphonecount_d = NULL                                   => 0.1470982721,
                                                                       0.1470982721);

all4wfdn_62 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => all4wfdn_62_c461,
    k_inq_adls_per_phone_i > 2.5                                    => all4wfdn_62_c464,
    k_inq_adls_per_phone_i = NULL                                   => -0.0079381921,
                                                                       -0.0079381921);

all4wfdn_63_c466 := map(
    trim(c_rnt2001_p) = ''                         => 0.0055592875,
    NULL < (integer)c_rnt2001_p AND (real)c_rnt2001_p <= 61.3 => -0.0076718619,
    (real)c_rnt2001_p > 61.3                         => -0.1757757524,
                                                  -0.0083034399);

all4wfdn_63_c468 := map(
    trim(c_hval_100k_p) = ''                           => 0.0168762335,
    NULL < (integer)c_hval_100k_p AND (real)c_hval_100k_p <= 3.25 => -0.0414992963,
    (real)c_hval_100k_p > 3.25                           => 0.0573856028,
                                                      0.0168762335);

all4wfdn_63_c469 := map(
    trim(c_mort_indx) = ''                         => 0.1306722277,
    NULL < (integer)c_mort_indx AND (real)c_mort_indx <= 86.5 => 0.0080237946,
    (real)c_mort_indx > 86.5                         => 0.2193564793,
                                                  0.1306722277);

all4wfdn_63_c467 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 239.5 => all4wfdn_63_c468,
    r_c13_max_lres_d > 239.5                              => all4wfdn_63_c469,
    r_c13_max_lres_d = NULL                               => 0.0302268156,
                                                             0.0302268156);

all4wfdn_63 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => all4wfdn_63_c466,
    f_srchunvrfdaddrcount_i > 0.5                                     => all4wfdn_63_c467,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0046005614,
                                                                         -0.0046005614);

all4wfdn_64_c471 := map(
    NULL < f_srchfraudsrchcountwk_i AND f_srchfraudsrchcountwk_i <= 0.5 => -0.0289628877,
    f_srchfraudsrchcountwk_i > 0.5                                      => 0.0528547339,
    f_srchfraudsrchcountwk_i = NULL                                     => -0.0157439959,
                                                                           -0.0157439959);

all4wfdn_64_c474 := map(
    trim(c_pop_55_64_p) = ''                           => -0.0031802874,
    NULL < (integer)c_pop_55_64_p AND (real)c_pop_55_64_p <= 8.65 => 0.1045017311,
    (real)c_pop_55_64_p > 8.65                           => -0.0631610609,
                                                      -0.0031802874);

all4wfdn_64_c473 := map(
    NULL < f_add_curr_nhood_sfd_pct_d AND f_add_curr_nhood_sfd_pct_d <= 0.9208962111 => all4wfdn_64_c474,
    f_add_curr_nhood_sfd_pct_d > 0.9208962111                                        => 0.1848681371,
    f_add_curr_nhood_sfd_pct_d = NULL                                                => 0.0669749996,
                                                                                        0.0669749996);

all4wfdn_64_c472 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => 0.0108521564,
    f_validationrisktype_i > 1.5                                    => all4wfdn_64_c473,
    f_validationrisktype_i = NULL                                   => 0.0128286351,
                                                                       0.0128286351);

all4wfdn_64 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => all4wfdn_64_c471,
    f_dl_addrs_per_adl_i > 0.5                                  => all4wfdn_64_c472,
    f_dl_addrs_per_adl_i = NULL                                 => -0.0004187640,
                                                                   -0.0004187640);

all4wfdn_65_c478 := map(
    trim(c_professional) = ''                            => 0.0429820334,
    NULL < (integer)c_professional AND (real)c_professional <= 7.15 => 0.0091945672,
    (real)c_professional > 7.15                            => 0.1212882051,
                                                        0.0429820334);

all4wfdn_65_c477 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.0365827364 => -0.0862509238,
    f_add_curr_nhood_mfd_pct_i > 0.0365827364                                        => all4wfdn_65_c478,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => 0.0179638208,
                                                                                        0.0161031939);

all4wfdn_65_c479 := map(
    trim(c_hh00) = ''                     => 0.1247359784,
    NULL < (integer)c_hh00 AND (real)c_hh00 <= 630.5 => 0.0265422231,
    (real)c_hh00 > 630.5                    => 0.1969024733,
                                         0.1247359784);

all4wfdn_65_c476 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 4.5 => all4wfdn_65_c477,
    f_bus_addr_match_count_d > 4.5                                      => all4wfdn_65_c479,
    f_bus_addr_match_count_d = NULL                                     => 0.0276585926,
                                                                           0.0276585926);

all4wfdn_65 := map(
    NULL < f_inq_email_ver_count_i AND f_inq_email_ver_count_i <= 0.5 => all4wfdn_65_c476,
    f_inq_email_ver_count_i > 0.5                                     => -0.0045530724,
    f_inq_email_ver_count_i = NULL                                    => -0.0017285859,
                                                                         -0.0017285859);

all4wfdn_66_c483 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 14.5 => 0.0164493776,
    r_p88_phn_dst_to_inp_add_i > 14.5                                        => 0.1425978752,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => -0.0301183919,
                                                                                0.0173348127);

all4wfdn_66_c482 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.01908665105 => 0.1960896635,
    f_add_curr_nhood_mfd_pct_i > 0.01908665105                                        => all4wfdn_66_c483,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => 0.0613916238,
                                                                                         0.0454689984);

all4wfdn_66_c481 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 9834.5 => -0.0125141480,
    f_addrchangeincomediff_d > 9834.5                                      => all4wfdn_66_c482,
    f_addrchangeincomediff_d = NULL                                        => -0.0002862788,
                                                                              -0.0080207772);

all4wfdn_66_c484 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 109.5 => 0.0557288604,
    f_prevaddrageoldest_d > 109.5                                   => 0.1682506413,
    f_prevaddrageoldest_d = NULL                                    => 0.0824758411,
                                                                       0.0824758411);

all4wfdn_66 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 1.5 => all4wfdn_66_c481,
    f_srchunvrfdaddrcount_i > 1.5                                     => all4wfdn_66_c484,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0065950815,
                                                                         -0.0065950815);

all4wfdn_67_c487 := map(
    trim(c_construction) = ''                            => 0.1056753543,
    NULL < (integer)c_construction AND (real)c_construction <= 8.45 => 0.2115452732,
    (real)c_construction > 8.45                            => -0.0414588242,
                                                        0.1056753543);

all4wfdn_67_c486 := map(
    trim(c_rich_nfam) = ''                          => -0.0195189849,
    NULL < (integer)c_rich_nfam AND (real)c_rich_nfam <= 197.5 => -0.0002428773,
    (real)c_rich_nfam > 197.5                         => all4wfdn_67_c487,
                                                   0.0006619846);

all4wfdn_67_c489 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 9.5 => 0.2322726658,
    f_rel_ageover30_count_d > 9.5                                     => 0.0496233510,
    f_rel_ageover30_count_d = NULL                                    => 0.1326457668,
                                                                         0.1326457668);

all4wfdn_67_c488 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 2.5 => all4wfdn_67_c489,
    r_c20_email_verification_d > 2.5                                        => 0.0078628152,
    r_c20_email_verification_d = NULL                                       => 0.0623676121,
                                                                               0.0623676121);

all4wfdn_67 := map(
    NULL < f_vf_altlexid_phn_hi_risk_ct_i AND f_vf_altlexid_phn_hi_risk_ct_i <= 0.5 => all4wfdn_67_c486,
    f_vf_altlexid_phn_hi_risk_ct_i > 0.5                                            => all4wfdn_67_c488,
    f_vf_altlexid_phn_hi_risk_ct_i = NULL                                           => 0.0021794590,
                                                                                       0.0021794590);

all4wfdn_68_c492 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 16.5 => -0.0066754430,
    f_historical_count_d > 16.5                                  => 0.1180115870,
    f_historical_count_d = NULL                                  => -0.0057153806,
                                                                    -0.0057153806);

all4wfdn_68_c493 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 9.5 => 0.0758085000,
    f_rel_under500miles_cnt_d > 9.5                                       => -0.0684188827,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0019091363,
                                                                             0.0019091363);

all4wfdn_68_c491 := map(
    trim(C_RENTOCC_P) = ''                          => all4wfdn_68_c493,
    NULL < (integer)C_RENTOCC_P AND (real)C_RENTOCC_P <= 93.05 => all4wfdn_68_c492,
    (real)C_RENTOCC_P > 93.05                         => 0.2184911985,
                                                   -0.0047129705);

all4wfdn_68_c494 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 5.5 => 0.0453214056,
    r_c14_addrs_5yr_i > 5.5                               => 0.3153715451,
    r_c14_addrs_5yr_i = NULL                              => 0.0708248168,
                                                             0.0708248168);

all4wfdn_68 := map(
    NULL < f_inq_communications_count_i AND f_inq_communications_count_i <= 4.5 => all4wfdn_68_c491,
    f_inq_communications_count_i > 4.5                                          => all4wfdn_68_c494,
    f_inq_communications_count_i = NULL                                         => -0.0019407396,
                                                                                   -0.0019407396);

all4wfdn_69_c498 := map(
    NULL < (integer)f_nae_email_verd_d AND (real)f_nae_email_verd_d <= 0.5 => 0.1027408441,
    (real)f_nae_email_verd_d > 0.5                                => -0.0298822976,
    (integer)f_nae_email_verd_d = NULL                               => 0.0577757869,
                                                               0.0577757869);

all4wfdn_69_c497 := map(
    trim(c_famotf18_p) = ''                           => 0.0218543149,
    NULL < (integer)c_famotf18_p AND (real)c_famotf18_p <= 11.35 => all4wfdn_69_c498,
    (real)c_famotf18_p > 11.35                          => -0.0145016910,
                                                     0.0218543149);

all4wfdn_69_c496 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 60.5 => -0.0083689463,
    k_comb_age_d > 60.5                          => all4wfdn_69_c497,
    k_comb_age_d = NULL                          => -0.0058981129,
                                                    -0.0058981129);

all4wfdn_69_c499 := map(
    trim(C_INC_200K_P) = ''                          => 0.0934694036,
    NULL < (integer)C_INC_200K_P AND (real)C_INC_200K_P <= 3.25 => 0.0016560951,
    (real)C_INC_200K_P > 3.25                          => 0.2002023747,
                                                    0.0934694036);

all4wfdn_69 := map(
    NULL < f_adls_per_phone_c6_i AND f_adls_per_phone_c6_i <= 1.5 => all4wfdn_69_c496,
    f_adls_per_phone_c6_i > 1.5                                   => all4wfdn_69_c499,
    f_adls_per_phone_c6_i = NULL                                  => -0.0050409152,
                                                                     -0.0050409152);

all4wfdn_70_c503 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => 0.2123719225,
    r_c20_email_verification_d > 0.5                                        => 0.0715601047,
    r_c20_email_verification_d = NULL                                       => 0.1083356997,
                                                                               0.1083356997);

all4wfdn_70_c502 := map(
    trim(c_unempl) = ''                       => 0.0563479897,
    NULL < (integer)c_unempl AND (real)c_unempl <= 132.5 => all4wfdn_70_c503,
    (real)c_unempl > 132.5                      => -0.0632442919,
                                             0.0563479897);

all4wfdn_70_c504 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 98 => 0.1537266142,
    r_f00_dob_score_d > 98                               => 0.0113675929,
    r_f00_dob_score_d = NULL                             => 0.0150387424,
                                                            0.0150387424);

all4wfdn_70_c501 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -381.5 => all4wfdn_70_c502,
    f_addrchangevaluediff_d > -381.5                                     => -0.0040443499,
    f_addrchangevaluediff_d = NULL                                       => all4wfdn_70_c504,
                                                                            0.0014360561);

all4wfdn_70 := map(
    NULL < r_l70_inp_addr_dirty_i AND r_l70_inp_addr_dirty_i <= 0.5 => all4wfdn_70_c501,
    r_l70_inp_addr_dirty_i > 0.5                                    => -0.0458068477,
    r_l70_inp_addr_dirty_i = NULL                                   => -0.0015473600,
                                                                       -0.0015473600);

all4wfdn_71_c509 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 2.5 => 0.1567101920,
    f_inq_collection_count_i > 2.5                                      => -0.0260623548,
    f_inq_collection_count_i = NULL                                     => 0.0775715635,
                                                                           0.0775715635);

all4wfdn_71_c508 := map(
    trim(c_femdiv_p) = ''                        => 0.1168500035,
    NULL < (integer)c_femdiv_p AND (real)c_femdiv_p <= 2.85 => 0.2293819052,
    (real)c_femdiv_p > 2.85                        => all4wfdn_71_c509,
                                                0.1168500035);

all4wfdn_71_c507 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 0.5 => all4wfdn_71_c508,
    k_inq_per_phone_i > 0.5                               => 0.0401667264,
    k_inq_per_phone_i = NULL                              => 0.0622436648,
                                                             0.0622436648);

all4wfdn_71_c506 := map(
    NULL < f_mos_inq_banko_om_fseen_d AND f_mos_inq_banko_om_fseen_d <= 60.5 => -0.0184660080,
    f_mos_inq_banko_om_fseen_d > 60.5                                        => all4wfdn_71_c507,
    f_mos_inq_banko_om_fseen_d = NULL                                        => 0.0260931811,
                                                                                0.0260931811);

all4wfdn_71 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 0.5 => -0.0081226092,
    f_srchunvrfdaddrcount_i > 0.5                                     => all4wfdn_71_c506,
    f_srchunvrfdaddrcount_i = NULL                                    => -0.0049081151,
                                                                         -0.0049081151);

all4wfdn_72_c514 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 71.35 => 0.1822045984,
    r_c12_source_profile_d > 71.35                                    => 0.0701583821,
    r_c12_source_profile_d = NULL                                     => 0.1176053882,
                                                                         0.1176053882);

all4wfdn_72_c513 := map(
    NULL < r_d31_bk_disposed_hist_count_i AND r_d31_bk_disposed_hist_count_i <= 0.5 => all4wfdn_72_c514,
    r_d31_bk_disposed_hist_count_i > 0.5                                            => -0.0011339604,
    r_d31_bk_disposed_hist_count_i = NULL                                           => 0.0842293922,
                                                                                       0.0842293922);

all4wfdn_72_c512 := map(
    NULL < r_c14_addrs_15yr_i AND r_c14_addrs_15yr_i <= 7.5 => all4wfdn_72_c513,
    r_c14_addrs_15yr_i > 7.5                                => -0.0605802524,
    r_c14_addrs_15yr_i = NULL                               => 0.0565960945,
                                                               0.0565960945);

all4wfdn_72_c511 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 4.5 => all4wfdn_72_c512,
    r_c20_email_verification_d > 4.5                                        => -0.0349858928,
    r_c20_email_verification_d = NULL                                       => 0.0210300646,
                                                                               0.0210300646);

all4wfdn_72 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 2.5 => -0.0060611709,
    r_e57_br_source_count_d > 2.5                                     => all4wfdn_72_c511,
    r_e57_br_source_count_d = NULL                                    => -0.0042007815,
                                                                         -0.0042007815);

all4wfdn_73_c517 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.1957512739 => 0.0316268429,
    f_add_curr_mobility_index_i > 0.1957512739                                         => -0.0359214388,
    f_add_curr_mobility_index_i = NULL                                                 => -0.0306158115,
                                                                                          -0.0306158115);

all4wfdn_73_c519 := map(
    NULL < f_mos_inq_banko_cm_lseen_d AND f_mos_inq_banko_cm_lseen_d <= 69.5 => 0.0010558400,
    f_mos_inq_banko_cm_lseen_d > 69.5                                        => 0.0626317920,
    f_mos_inq_banko_cm_lseen_d = NULL                                        => 0.0277952108,
                                                                                0.0277952108);

all4wfdn_73_c518 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => all4wfdn_73_c519,
    r_c20_email_verification_d > 1.5                                        => -0.0062557968,
    r_c20_email_verification_d = NULL                                       => 0.0015276458,
                                                                               0.0015276458);

all4wfdn_73_c516 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 0.5 => all4wfdn_73_c517,
    r_c20_email_count_i > 0.5                                 => all4wfdn_73_c518,
    r_c20_email_count_i = NULL                                => -0.0046363478,
                                                                 -0.0046363478);

all4wfdn_73 := map(
    trim(C_RENTOCC_P) = ''                          => 0.0234268474,
    NULL < (integer)C_RENTOCC_P AND (real)C_RENTOCC_P <= 93.55 => all4wfdn_73_c516,
    (real)C_RENTOCC_P > 93.55                         => 0.2370721778,
                                                   -0.0034757164);

all4wfdn_74_c524 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 1.5 => 0.0105216478,
    r_c20_email_count_i > 1.5                                 => 0.1877254079,
    r_c20_email_count_i = NULL                                => 0.1342117950,
                                                                 0.1342117950);

all4wfdn_74_c523 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => all4wfdn_74_c524,
    f_adl_per_email_i > 0.5                               => -0.0322056491,
    f_adl_per_email_i = NULL                              => 0.0852529937,
                                                             0.0852529937);

all4wfdn_74_c522 := map(
    trim(c_rich_fam) = ''                         => 0.0491471142,
    NULL < (integer)c_rich_fam AND (real)c_rich_fam <= 150.5 => all4wfdn_74_c523,
    (real)c_rich_fam > 150.5                        => -0.0419606363,
                                                 0.0491471142);

all4wfdn_74_c521 := map(
    NULL < f_srchphonesrchcount_i AND f_srchphonesrchcount_i <= 0.5 => all4wfdn_74_c522,
    f_srchphonesrchcount_i > 0.5                                    => 0.0089773618,
    f_srchphonesrchcount_i = NULL                                   => 0.0212767314,
                                                                       0.0212767314);

all4wfdn_74 := map(
    NULL < r_e57_br_source_count_d AND r_e57_br_source_count_d <= 1.5 => -0.0047419438,
    r_e57_br_source_count_d > 1.5                                     => all4wfdn_74_c521,
    r_e57_br_source_count_d = NULL                                    => -0.0017102450,
                                                                         -0.0017102450);

all4wfdn_75_c528 := map(
    trim(c_pop_12_17_p) = ''                           => 0.0046893823,
    NULL < (integer)c_pop_12_17_p AND (real)c_pop_12_17_p <= 3.35 => -0.0792138200,
    (real)c_pop_12_17_p > 3.35                           => 0.0098211291,
                                                      0.0046893823);

all4wfdn_75_c529 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 36500 => -0.0430868576,
    k_estimated_income_d > 36500                                  => 0.2216814519,
    k_estimated_income_d = NULL                                   => 0.0898289604,
                                                                     0.0898289604);

all4wfdn_75_c527 := map(
    trim(c_hh1_p) = ''                     => 0.0658086060,
    NULL < (integer)c_hh1_p AND (real)c_hh1_p <= 60.9 => all4wfdn_75_c528,
    (real)c_hh1_p > 60.9                     => all4wfdn_75_c529,
                                          0.0068375307);

all4wfdn_75_c526 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_75_c527,
    f_phone_ver_experian_d > 0.5                                    => -0.0249636861,
    f_phone_ver_experian_d = NULL                                   => 0.0187966233,
                                                                       -0.0078557715);

all4wfdn_75 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 51.5 => all4wfdn_75_c526,
    f_phones_per_addr_curr_i > 51.5                                      => 0.1623566516,
    f_phones_per_addr_curr_i = NULL                                      => -0.0066264427,
                                                                            -0.0066264427);

all4wfdn_76_c531 := map(
    trim(C_OWNOCC_P) = ''                         => 0.0117393841,
    NULL < (integer)C_OWNOCC_P AND (real)C_OWNOCC_P <= 96.95 => -0.0015079830,
    (real)C_OWNOCC_P > 96.95                        => 0.1331076440,
                                                 -0.0008139634);

all4wfdn_76_c534 := map(
    trim(c_pop_18_24_p) = ''                            => 0.0894707714,
    NULL < (integer)c_pop_18_24_p AND (real)c_pop_18_24_p <= 10.85 => 0.0100582996,
    (real)c_pop_18_24_p > 10.85                           => 0.2416060774,
                                                       0.0894707714);

all4wfdn_76_c533 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.4825937862 => all4wfdn_76_c534,
    f_add_curr_nhood_mfd_pct_i > 0.4825937862                                        => -0.0184416809,
    f_add_curr_nhood_mfd_pct_i = NULL                                                => 0.0532993732,
                                                                                        0.0532993732);

all4wfdn_76_c532 := map(
    trim(c_no_car) = ''                       => 0.0876645705,
    NULL < (integer)c_no_car AND (real)c_no_car <= 170.5 => all4wfdn_76_c533,
    (real)c_no_car > 170.5                      => 0.2783657700,
                                             0.0876645705);

all4wfdn_76 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 14.5 => all4wfdn_76_c531,
    f_phones_per_addr_curr_i > 14.5                                      => all4wfdn_76_c532,
    f_phones_per_addr_curr_i = NULL                                      => 0.0023563380,
                                                                            0.0023563380);

all4wfdn_77_c539 := map(
    trim(c_med_rent) = ''                       => 0.0858519442,
    NULL < (integer)c_med_rent AND (integer)c_med_rent <= 753 => 0.2016224252,
    (integer)c_med_rent > 753                        => 0.0034161543,
                                               0.0858519442);

all4wfdn_77_c538 := map(
    trim(c_pop_75_84_p) = ''                           => 0.1250193388,
    NULL < (integer)c_pop_75_84_p AND (real)c_pop_75_84_p <= 5.15 => all4wfdn_77_c539,
    (real)c_pop_75_84_p > 5.15                           => 0.2512732116,
                                                      0.1250193388);

all4wfdn_77_c537 := map(
    trim(c_lux_prod) = ''                         => 0.0531517617,
    NULL < (integer)c_lux_prod AND (real)c_lux_prod <= 140.5 => 0.0286649661,
    (real)c_lux_prod > 140.5                        => all4wfdn_77_c538,
                                                 0.0531517617);

all4wfdn_77_c536 := map(
    NULL < f_hh_college_attendees_d AND f_hh_college_attendees_d <= 0.5 => 0.0025780322,
    f_hh_college_attendees_d > 0.5                                      => all4wfdn_77_c537,
    f_hh_college_attendees_d = NULL                                     => 0.0149821418,
                                                                           0.0149821418);

all4wfdn_77 := map(
    NULL < f_srchphonesrchcount_i AND f_srchphonesrchcount_i <= 0.5 => all4wfdn_77_c536,
    f_srchphonesrchcount_i > 0.5                                    => -0.0119193339,
    f_srchphonesrchcount_i = NULL                                   => -0.0038059073,
                                                                       -0.0038059073);

all4wfdn_78_c544 := map(
    NULL < r_c20_email_domain_isp_count_i AND r_c20_email_domain_isp_count_i <= 1.5 => 0.0511395801,
    r_c20_email_domain_isp_count_i > 1.5                                            => 0.1397533066,
    r_c20_email_domain_isp_count_i = NULL                                           => 0.0673610448,
                                                                                       0.0673610448);

all4wfdn_78_c543 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 3.5 => all4wfdn_78_c544,
    r_c20_email_verification_d > 3.5                                        => 0.0121701730,
    r_c20_email_verification_d = NULL                                       => 0.0494547920,
                                                                               0.0494547920);

all4wfdn_78_c542 := map(
    trim(c_pop_45_54_p) = ''                            => 0.0280444024,
    NULL < (integer)c_pop_45_54_p AND (real)c_pop_45_54_p <= 13.25 => 0.0025935607,
    (real)c_pop_45_54_p > 13.25                           => all4wfdn_78_c543,
                                                       0.0280444024);

all4wfdn_78_c541 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 10.5 => -0.0360998469,
    f_prevaddrageoldest_d > 10.5                                   => all4wfdn_78_c542,
    f_prevaddrageoldest_d = NULL                                   => 0.0152048613,
                                                                      0.0152048613);

all4wfdn_78 := map(
    NULL < f_srchphonesrchcount_i AND f_srchphonesrchcount_i <= 0.5 => all4wfdn_78_c541,
    f_srchphonesrchcount_i > 0.5                                    => -0.0079779541,
    f_srchphonesrchcount_i = NULL                                   => -0.0007631761,
                                                                       -0.0007631761);

all4wfdn_79_c549 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 231 => 0.1017775615,
    r_pb_order_freq_d > 231                               => 0.0323193250,
    r_pb_order_freq_d = NULL                              => -0.0261999897,
                                                             0.0542240072);

all4wfdn_79_c548 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 87303 => 0.0008854906,
    f_curraddrmedianincome_d > 87303                                      => all4wfdn_79_c549,
    f_curraddrmedianincome_d = NULL                                       => 0.0068061597,
                                                                             0.0068061597);

all4wfdn_79_c547 := map(
    trim(c_rnt1000_p) = ''                         => 0.0086053495,
    NULL < (integer)c_rnt1000_p AND (real)c_rnt1000_p <= 79.1 => all4wfdn_79_c548,
    (real)c_rnt1000_p > 79.1                         => 0.2201216743,
                                                  0.0086053495);

all4wfdn_79_c546 := map(
    NULL < f_bus_phone_match_d AND f_bus_phone_match_d <= 0.5 => all4wfdn_79_c547,
    f_bus_phone_match_d > 0.5                                 => 0.1372935347,
    f_bus_phone_match_d = NULL                                => 0.0108960149,
                                                                 0.0108960149);

all4wfdn_79 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 1.5 => all4wfdn_79_c546,
    f_rel_bankrupt_count_i > 1.5                                    => -0.0171985659,
    f_rel_bankrupt_count_i = NULL                                   => -0.0038151507,
                                                                       -0.0038151507);

all4wfdn_80_c553 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.24730275085 => 0.0268890924,
    f_add_curr_mobility_index_i > 0.24730275085                                         => -0.0025790260,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0046882701,
                                                                                           0.0046882701);

all4wfdn_80_c552 := map(
    trim(c_hval_750k_p) = ''                            => -0.0014313158,
    NULL < (integer)c_hval_750k_p AND (real)c_hval_750k_p <= 21.05 => all4wfdn_80_c553,
    (real)c_hval_750k_p > 21.05                           => -0.0407187208,
                                                       -0.0006607051);

all4wfdn_80_c551 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 472 => all4wfdn_80_c552,
    r_c13_max_lres_d > 472                              => -0.1378251932,
    r_c13_max_lres_d = NULL                             => -0.0015645231,
                                                           -0.0015645231);

all4wfdn_80_c554 := map(
    trim(c_work_home) = ''                          => 0.0962160034,
    NULL < (integer)c_work_home AND (real)c_work_home <= 102.5 => 0.0185446050,
    (real)c_work_home > 102.5                         => 0.2353892896,
                                                   0.0962160034);

all4wfdn_80 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => all4wfdn_80_c551,
    k_inq_adls_per_phone_i > 2.5                                    => all4wfdn_80_c554,
    k_inq_adls_per_phone_i = NULL                                   => -0.0003532564,
                                                                       -0.0003532564);

all4wfdn_81_c559 := map(
    trim(c_hval_250k_p) = ''                           => 0.0732477289,
    NULL < (integer)c_hval_250k_p AND (real)c_hval_250k_p <= 1.15 => 0.0130730846,
    (real)c_hval_250k_p > 1.15                           => 0.1061463913,
                                                      0.0732477289);

all4wfdn_81_c558 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 12.5 => all4wfdn_81_c559,
    f_srchaddrsrchcount_i > 12.5                                   => -0.0178023738,
    f_srchaddrsrchcount_i = NULL                                   => 0.0459359417,
                                                                      0.0459359417);

all4wfdn_81_c557 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 30.5 => -0.0183886255,
    f_prevaddrageoldest_d > 30.5                                   => all4wfdn_81_c558,
    f_prevaddrageoldest_d = NULL                                   => 0.0225730488,
                                                                      0.0225730488);

all4wfdn_81_c556 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => all4wfdn_81_c557,
    r_c20_email_verification_d > 1.5                                        => -0.0081157066,
    r_c20_email_verification_d = NULL                                       => 0.0000145957,
                                                                               0.0000145957);

all4wfdn_81 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => -0.0198480744,
    f_dl_addrs_per_adl_i > 0.5                                  => all4wfdn_81_c556,
    f_dl_addrs_per_adl_i = NULL                                 => -0.0091507891,
                                                                   -0.0091507891);

all4wfdn_82_c562 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 369.5 => -0.0225426865,
    r_c13_max_lres_d > 369.5                              => -0.1383376981,
    r_c13_max_lres_d = NULL                               => -0.0250642378,
                                                             -0.0250642378);

all4wfdn_82_c564 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 1.5 => 0.0445786066,
    f_inq_collection_count_i > 1.5                                      => 0.0028159797,
    f_inq_collection_count_i = NULL                                     => 0.0170887811,
                                                                           0.0170887811);

all4wfdn_82_c563 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 3.5 => all4wfdn_82_c564,
    r_c20_email_verification_d > 3.5                                        => -0.0144803102,
    r_c20_email_verification_d = NULL                                       => 0.0009922072,
                                                                               0.0009922072);

all4wfdn_82_c561 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 0.5 => all4wfdn_82_c562,
    r_c20_email_count_i > 0.5                                 => all4wfdn_82_c563,
    r_c20_email_count_i = NULL                                => -0.0038166090,
                                                                 -0.0038166090);

all4wfdn_82 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 80 => 0.1213684457,
    r_f00_dob_score_d > 80                               => all4wfdn_82_c561,
    r_f00_dob_score_d = NULL                             => -0.0237477009,
                                                            -0.0033061414);

all4wfdn_83_c567 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 283 => -0.0073808386,
    r_p88_phn_dst_to_inp_add_i > 283                                        => 0.0706863624,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => 0.0038153709,
                                                                               -0.0020525127);

all4wfdn_83_c568 := map(
    trim(c_rnt500_p) = ''                        => 0.1065194157,
    NULL < (integer)c_rnt500_p AND (real)c_rnt500_p <= 22.7 => -0.0101237224,
    (real)c_rnt500_p > 22.7                        => 0.4302858830,
                                                0.1065194157);

all4wfdn_83_c566 := map(
    trim(c_rnt250_p) = ''                         => -0.0060484405,
    NULL < (integer)c_rnt250_p AND (real)c_rnt250_p <= 57.95 => all4wfdn_83_c567,
    (real)c_rnt250_p > 57.95                        => all4wfdn_83_c568,
                                                 -0.0006536191);

all4wfdn_83_c569 := map(
    NULL < f_corrssnaddrcount_d AND f_corrssnaddrcount_d <= 3.5 => 0.2057334971,
    f_corrssnaddrcount_d > 3.5                                  => -0.0158302213,
    f_corrssnaddrcount_d = NULL                                 => 0.0736021749,
                                                                   0.0736021749);

all4wfdn_83 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => all4wfdn_83_c566,
    k_inq_adls_per_phone_i > 2.5                                    => all4wfdn_83_c569,
    k_inq_adls_per_phone_i = NULL                                   => 0.0001439004,
                                                                       0.0001439004);

all4wfdn_84_c574 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 116.5 => 0.0965777341,
    f_curraddrburglaryindex_i > 116.5                                       => -0.0490810599,
    f_curraddrburglaryindex_i = NULL                                        => 0.0300286331,
                                                                               0.0300286331);

all4wfdn_84_c573 := map(
    NULL < r_c23_inp_addr_occ_index_d AND r_c23_inp_addr_occ_index_d <= 2 => -0.0524823585,
    r_c23_inp_addr_occ_index_d > 2                                        => all4wfdn_84_c574,
    r_c23_inp_addr_occ_index_d = NULL                                     => -0.0294503630,
                                                                             -0.0294503630);

all4wfdn_84_c572 := map(
    trim(c_pop_75_84_p) = ''                           => -0.0172074843,
    NULL < (integer)c_pop_75_84_p AND (real)c_pop_75_84_p <= 7.65 => all4wfdn_84_c573,
    (real)c_pop_75_84_p > 7.65                           => 0.0710455952,
                                                      -0.0172074843);

all4wfdn_84_c571 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 213 => all4wfdn_84_c572,
    r_pb_order_freq_d > 213                               => 0.0380200763,
    r_pb_order_freq_d = NULL                              => -0.0586686146,
                                                             -0.0293328344);

all4wfdn_84 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => all4wfdn_84_c571,
    f_srchvelocityrisktype_i > 2.5                                      => 0.0051012002,
    f_srchvelocityrisktype_i = NULL                                     => -0.0008589010,
                                                                           -0.0008589010);

all4wfdn_85_c577 := map(
    NULL < f_inq_retail_count_i AND f_inq_retail_count_i <= 0.5 => 0.0255540418,
    f_inq_retail_count_i > 0.5                                  => 0.1897948432,
    f_inq_retail_count_i = NULL                                 => 0.0448054781,
                                                                   0.0448054781);

all4wfdn_85_c576 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 5136 => -0.0036123895,
    f_addrchangeincomediff_d > 5136                                      => all4wfdn_85_c577,
    f_addrchangeincomediff_d = NULL                                      => 0.0015434593,
                                                                            -0.0004537171);

all4wfdn_85_c579 := map(
    trim(c_retail) = ''                      => 0.1959928362,
    NULL < (integer)c_retail AND (real)c_retail <= 6.75 => 0.0328819622,
    (real)c_retail > 6.75                      => 0.4132163225,
                                            0.1959928362);

all4wfdn_85_c578 := map(
    NULL < f_add_input_nhood_sfd_pct_d AND f_add_input_nhood_sfd_pct_d <= 0.93413042265 => 0.0385557649,
    f_add_input_nhood_sfd_pct_d > 0.93413042265                                         => all4wfdn_85_c579,
    f_add_input_nhood_sfd_pct_d = NULL                                                  => 0.0741707965,
                                                                                           0.0741707965);

all4wfdn_85 := map(
    NULL < r_c14_addrs_5yr_i AND r_c14_addrs_5yr_i <= 5.5 => all4wfdn_85_c576,
    r_c14_addrs_5yr_i > 5.5                               => all4wfdn_85_c578,
    r_c14_addrs_5yr_i = NULL                              => 0.0022023338,
                                                             0.0022023338);

all4wfdn_86_c583 := map(
    trim(c_business) = ''                       => 0.0269886475,
    NULL < (integer)c_business AND (integer)c_business <= 130 => 0.0073531674,
    (integer)c_business > 130                        => 0.2148524309,
                                               0.0269886475);

all4wfdn_86_c582 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 60500 => all4wfdn_86_c583,
    k_estimated_income_d > 60500                                  => 0.2000601785,
    k_estimated_income_d = NULL                                   => 0.0380817962,
                                                                     0.0380817962);

all4wfdn_86_c581 := map(
    trim(c_hval_125k_p) = ''                            => 0.0351645144,
    NULL < (integer)c_hval_125k_p AND (real)c_hval_125k_p <= 28.55 => -0.0165949681,
    (real)c_hval_125k_p > 28.55                           => all4wfdn_86_c582,
                                                       -0.0119549804);

all4wfdn_86_c584 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 9.5 => 0.0542884193,
    f_rel_under25miles_cnt_d > 9.5                                      => -0.0119355236,
    f_rel_under25miles_cnt_d = NULL                                     => 0.0281236598,
                                                                           0.0281236598);

all4wfdn_86 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => all4wfdn_86_c581,
    f_srchunvrfdphonecount_i > 1.5                                      => all4wfdn_86_c584,
    f_srchunvrfdphonecount_i = NULL                                     => -0.0032931301,
                                                                           -0.0032931301);

all4wfdn_87_c588 := map(
    trim(c_hval_125k_p) = ''                           => 0.1446502652,
    NULL < (integer)c_hval_125k_p AND (real)c_hval_125k_p <= 4.85 => 0.2473689860,
    (real)c_hval_125k_p > 4.85                           => 0.0096017478,
                                                      0.1446502652);

all4wfdn_87_c587 := map(
    trim(c_bargains) = ''                        => 0.0371920981,
    NULL < (integer)c_bargains AND (real)c_bargains <= 18.5 => all4wfdn_87_c588,
    (real)c_bargains > 18.5                        => 0.0189900005,
                                                0.0371920981);

all4wfdn_87_c586 := map(
    trim(c_med_rent) = ''                         => 0.0011521220,
    NULL < (integer)c_med_rent AND (real)c_med_rent <= 296.5 => all4wfdn_87_c587,
    (real)c_med_rent > 296.5                        => -0.0033178954,
                                                 -0.0006186894);

all4wfdn_87_c589 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 3.5 => 0.1927418247,
    f_inq_highriskcredit_count_i > 3.5                                          => -0.0450070240,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0601721901,
                                                                                   0.0601721901);

all4wfdn_87 := map(
    NULL < f_inq_retail_count_i AND f_inq_retail_count_i <= 4.5 => all4wfdn_87_c586,
    f_inq_retail_count_i > 4.5                                  => all4wfdn_87_c589,
    f_inq_retail_count_i = NULL                                 => 0.0000220330,
                                                                   0.0000220330);

all4wfdn_88_c591 := map(
    trim(c_health) = ''                       => 0.0683452443,
    NULL < (integer)c_health AND (real)c_health <= 12.25 => 0.0062844272,
    (real)c_health > 12.25                      => 0.1938219182,
                                             0.0683452443);

all4wfdn_88_c594 := map(
    NULL < f_srchphonesrchcount_i AND f_srchphonesrchcount_i <= 1.5 => 0.0586193919,
    f_srchphonesrchcount_i > 1.5                                    => -0.0121512108,
    f_srchphonesrchcount_i = NULL                                   => 0.0175040503,
                                                                       0.0175040503);

all4wfdn_88_c593 := map(
    trim(c_housingcpi) = ''                           => -0.0035381981,
    NULL < (integer)c_housingcpi AND (real)c_housingcpi <= 186.4 => all4wfdn_88_c594,
    (real)c_housingcpi > 186.4                          => -0.0114098516,
                                                     -0.0071396704);

all4wfdn_88_c592 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 838723.5 => all4wfdn_88_c593,
    f_prevaddrmedianvalue_d > 838723.5                                     => 0.1838649267,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0062828390,
                                                                              -0.0062828390);

all4wfdn_88 := map(
    NULL < r_f00_input_dob_match_level_d AND r_f00_input_dob_match_level_d <= 4.5 => all4wfdn_88_c591,
    r_f00_input_dob_match_level_d > 4.5                                           => all4wfdn_88_c592,
    r_f00_input_dob_match_level_d = NULL                                          => -0.0054229349,
                                                                                     -0.0054229349);

all4wfdn_89_c597 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 12.5 => -0.0114798508,
    f_bus_addr_match_count_d > 12.5                                      => 0.0610591880,
    f_bus_addr_match_count_d = NULL                                      => -0.0100156682,
                                                                            -0.0100156682);

all4wfdn_89_c598 := map(
    trim(c_old_homes) = ''                       => 0.0758652221,
    NULL < (integer)c_old_homes AND (integer)c_old_homes <= 80 => 0.1797410009,
    (integer)c_old_homes > 80                         => -0.0745897749,
                                                0.0758652221);

all4wfdn_89_c596 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => all4wfdn_89_c597,
    k_inq_adls_per_phone_i > 2.5                                    => all4wfdn_89_c598,
    k_inq_adls_per_phone_i = NULL                                   => -0.0090958616,
                                                                       -0.0090958616);

all4wfdn_89_c599 := map(
    NULL < f_vf_lexid_ssn_hi_risk_ct_i AND f_vf_lexid_ssn_hi_risk_ct_i <= 1.5 => 0.0514389536,
    f_vf_lexid_ssn_hi_risk_ct_i > 1.5                                         => 0.2082001861,
    f_vf_lexid_ssn_hi_risk_ct_i = NULL                                        => 0.0665301102,
                                                                                 0.0665301102);

all4wfdn_89 := map(
    NULL < f_inq_prepaidcards_count_i AND f_inq_prepaidcards_count_i <= 1.5 => all4wfdn_89_c596,
    f_inq_prepaidcards_count_i > 1.5                                        => all4wfdn_89_c599,
    f_inq_prepaidcards_count_i = NULL                                       => -0.0051890526,
                                                                               -0.0051890526);

all4wfdn_90_c603 := map(
    trim(c_span_lang) = ''                          => 0.0519753508,
    NULL < (integer)c_span_lang AND (real)c_span_lang <= 141.5 => 0.0084852172,
    (real)c_span_lang > 141.5                         => 0.1365859634,
                                                   0.0519753508);

all4wfdn_90_c602 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 9181 => -0.0169081166,
    f_addrchangeincomediff_d > 9181                                      => all4wfdn_90_c603,
    f_addrchangeincomediff_d = NULL                                      => 0.0005332446,
                                                                            -0.0108120945);

all4wfdn_90_c601 := map(
    NULL < f_srchssnsrchcountwk_i AND f_srchssnsrchcountwk_i <= 0.5 => all4wfdn_90_c602,
    f_srchssnsrchcountwk_i > 0.5                                    => 0.0363260275,
    f_srchssnsrchcountwk_i = NULL                                   => -0.0035802189,
                                                                       -0.0035802189);

all4wfdn_90_c604 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => 0.1313597015,
    f_inq_highriskcredit_count_i > 1.5                                          => -0.0247046698,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0398974397,
                                                                                   0.0398974397);

all4wfdn_90 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 13.5 => all4wfdn_90_c601,
    f_historical_count_d > 13.5                                  => all4wfdn_90_c604,
    f_historical_count_d = NULL                                  => -0.0027830898,
                                                                    -0.0027830898);

all4wfdn_91_c607 := map(
    NULL < f_inq_other_count_week_i AND f_inq_other_count_week_i <= 0.5 => 0.0360535761,
    f_inq_other_count_week_i > 0.5                                      => 0.2167694555,
    f_inq_other_count_week_i = NULL                                     => 0.0438725683,
                                                                           0.0438725683);

all4wfdn_91_c606 := map(
    trim(c_med_age) = ''                        => 0.0123018507,
    NULL < (integer)c_med_age AND (real)c_med_age <= 37.25 => -0.0054938377,
    (real)c_med_age > 37.25                       => all4wfdn_91_c607,
                                               0.0123018507);

all4wfdn_91_c609 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => -0.0537408273,
    f_adl_per_email_i > 0.5                               => -0.0301060395,
    f_adl_per_email_i = NULL                              => -0.0462390647,
                                                             -0.0462390647);

all4wfdn_91_c608 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => all4wfdn_91_c609,
    f_srchvelocityrisktype_i > 2.5                                      => -0.0082305220,
    f_srchvelocityrisktype_i = NULL                                     => -0.0130030825,
                                                                           -0.0130030825);

all4wfdn_91 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 1.5 => all4wfdn_91_c606,
    f_inq_collection_count_i > 1.5                                      => all4wfdn_91_c608,
    f_inq_collection_count_i = NULL                                     => -0.0040605993,
                                                                           -0.0040605993);

all4wfdn_92_c614 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 39500 => 0.0583749937,
    k_estimated_income_d > 39500                                  => 0.2235852685,
    k_estimated_income_d = NULL                                   => 0.1390485117,
                                                                     0.1390485117);

all4wfdn_92_c613 := map(
    trim(c_hval_150k_p) = ''                           => 0.0892859069,
    NULL < (integer)c_hval_150k_p AND (real)c_hval_150k_p <= 0.85 => -0.0427484498,
    (real)c_hval_150k_p > 0.85                           => all4wfdn_92_c614,
                                                      0.0892859069);

all4wfdn_92_c612 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 0.5 => all4wfdn_92_c613,
    f_hh_collections_ct_i > 0.5                                   => 0.0286102394,
    f_hh_collections_ct_i = NULL                                  => 0.0349455208,
                                                                     0.0349455208);

all4wfdn_92_c611 := map(
    NULL < f_prevaddrdwelltype_sfd_n AND f_prevaddrdwelltype_sfd_n <= 0.5 => -0.0324238807,
    f_prevaddrdwelltype_sfd_n > 0.5                                       => all4wfdn_92_c612,
    f_prevaddrdwelltype_sfd_n = NULL                                      => 0.0178736391,
                                                                             0.0178736391);

all4wfdn_92 := map(
    trim(c_unempl) = ''                      => -0.0014253769,
    NULL < (integer)c_unempl AND (real)c_unempl <= 62.5 => all4wfdn_92_c611,
    (real)c_unempl > 62.5                      => -0.0059619582,
                                            -0.0009725937);

all4wfdn_93_c618 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 146.5 => 0.3393964228,
    r_c13_max_lres_d > 146.5                              => -0.0284623328,
    r_c13_max_lres_d = NULL                               => 0.1739877115,
                                                             0.1739877115);

all4wfdn_93_c619 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 0.5 => 0.1524818602,
    f_rel_under500miles_cnt_d > 0.5                                       => 0.0109734467,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0124495520,
                                                                             0.0124495520);

all4wfdn_93_c617 := map(
    NULL < r_f00_ssn_score_d AND r_f00_ssn_score_d <= 95 => all4wfdn_93_c618,
    r_f00_ssn_score_d > 95                               => all4wfdn_93_c619,
    r_f00_ssn_score_d = NULL                             => 0.0152806230,
                                                            0.0152806230);

all4wfdn_93_c616 := map(
    NULL < f_dl_addrs_per_adl_i AND f_dl_addrs_per_adl_i <= 0.5 => -0.0149861629,
    f_dl_addrs_per_adl_i > 0.5                                  => all4wfdn_93_c617,
    f_dl_addrs_per_adl_i = NULL                                 => 0.0013668265,
                                                                   0.0013668265);

all4wfdn_93 := map(
    trim(c_retired2) = ''                         => 0.0656622696,
    NULL < (integer)c_retired2 AND (real)c_retired2 <= 187.5 => all4wfdn_93_c616,
    (real)c_retired2 > 187.5                        => -0.1333591453,
                                                 0.0010741106);

all4wfdn_94_c622 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.24908497575 => -0.0115796675,
    f_add_input_nhood_bus_pct_i > 0.24908497575                                         => 0.1257760204,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0465378389,
                                                                                           -0.0068507384);

all4wfdn_94_c624 := map(
    NULL < f_curraddractivephonelist_d AND f_curraddractivephonelist_d <= 0.5 => 0.2626376480,
    f_curraddractivephonelist_d > 0.5                                         => 0.0991108604,
    f_curraddractivephonelist_d = NULL                                        => 0.2038628026,
                                                                                 0.2038628026);

all4wfdn_94_c623 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.29806750705 => all4wfdn_94_c624,
    f_add_curr_mobility_index_i > 0.29806750705                                         => -0.0085709652,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0981050695,
                                                                                           0.0981050695);

all4wfdn_94_c621 := map(
    trim(c_hval_250k_p) = ''                            => -0.0021008804,
    NULL < (integer)c_hval_250k_p AND (real)c_hval_250k_p <= 19.05 => all4wfdn_94_c622,
    (real)c_hval_250k_p > 19.05                           => all4wfdn_94_c623,
                                                       0.0046127457);

all4wfdn_94 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 123.5 => -0.0019657618,
    f_addrchangecrimediff_i > 123.5                                     => 0.1153746894,
    f_addrchangecrimediff_i = NULL                                      => all4wfdn_94_c621,
                                                                           -0.0001247230);

all4wfdn_95_c628 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 50.5 => 0.0003572303,
    k_comb_age_d > 50.5                          => 0.0569283492,
    k_comb_age_d = NULL                          => 0.0120267213,
                                                    0.0120267213);

all4wfdn_95_c629 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 55.7 => 0.0391262446,
    r_c12_source_profile_d > 55.7                                    => 0.4111468207,
    r_c12_source_profile_d = NULL                                    => 0.2156381350,
                                                                        0.2156381350);

all4wfdn_95_c627 := map(
    NULL < f_srchfraudsrchcountmo_i AND f_srchfraudsrchcountmo_i <= 5.5 => all4wfdn_95_c628,
    f_srchfraudsrchcountmo_i > 5.5                                      => all4wfdn_95_c629,
    f_srchfraudsrchcountmo_i = NULL                                     => 0.0178984457,
                                                                           0.0178984457);

all4wfdn_95_c626 := map(
    NULL < (integer)k_inf_contradictory_i AND (real)k_inf_contradictory_i <= 0.5 => -0.0091962839,
    (real)k_inf_contradictory_i > 0.5                                   => all4wfdn_95_c627,
    (integer)k_inf_contradictory_i = NULL                                  => -0.0019358139,
                                                                     -0.0019358139);

all4wfdn_95 := map(
    trim(C_INC_35K_P) = ''                         => -0.0127057423,
    NULL < (integer)C_INC_35K_P AND (real)C_INC_35K_P <= 0.25 => 0.1272974423,
    (real)C_INC_35K_P > 0.25                         => all4wfdn_95_c626,
                                                  -0.0015141336);

all4wfdn_96_c632 := map(
    NULL < f_adls_per_phone_c6_i AND f_adls_per_phone_c6_i <= 1.5 => -0.0047785298,
    f_adls_per_phone_c6_i > 1.5                                   => 0.0963214752,
    f_adls_per_phone_c6_i = NULL                                  => -0.0039273162,
                                                                     -0.0039273162);

all4wfdn_96_c631 := map(
    trim(c_totcrime) = ''                       => -0.0381590975,
    NULL < (integer)c_totcrime AND (integer)c_totcrime <= 192 => all4wfdn_96_c632,
    (integer)c_totcrime > 192                        => 0.0726740653,
                                               -0.0015043313);

all4wfdn_96_c634 := map(
    NULL < f_crim_rel_under100miles_cnt_i AND f_crim_rel_under100miles_cnt_i <= 1.5 => 0.2469217373,
    f_crim_rel_under100miles_cnt_i > 1.5                                            => 0.0445491564,
    f_crim_rel_under100miles_cnt_i = NULL                                           => 0.1290782443,
                                                                                       0.1290782443);

all4wfdn_96_c633 := map(
    trim(c_serv_empl) = ''                          => 0.0509553830,
    NULL < (integer)c_serv_empl AND (real)c_serv_empl <= 115.5 => all4wfdn_96_c634,
    (real)c_serv_empl > 115.5                         => -0.0699419726,
                                                   0.0509553830);

all4wfdn_96 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 12.5 => all4wfdn_96_c631,
    f_historical_count_d > 12.5                                  => all4wfdn_96_c633,
    f_historical_count_d = NULL                                  => -0.0003402404,
                                                                    -0.0003402404);

all4wfdn_97_c639 := map(
    NULL < k_inq_dobs_per_ssn_i AND k_inq_dobs_per_ssn_i <= 0.5 => 0.1405320846,
    k_inq_dobs_per_ssn_i > 0.5                                  => 0.0426165840,
    k_inq_dobs_per_ssn_i = NULL                                 => 0.0729382791,
                                                                   0.0729382791);

all4wfdn_97_c638 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 28.5 => -0.0155209691,
    f_prevaddrlenofres_d > 28.5                                  => all4wfdn_97_c639,
    f_prevaddrlenofres_d = NULL                                  => 0.0324741500,
                                                                    0.0324741500);

all4wfdn_97_c637 := map(
    trim(C_INC_35K_P) = ''                         => 0.0035601358,
    NULL < (integer)C_INC_35K_P AND (real)C_INC_35K_P <= 8.35 => all4wfdn_97_c638,
    (real)C_INC_35K_P > 8.35                         => -0.0131894308,
                                                  0.0035601358);

all4wfdn_97_c636 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 124.5 => 0.0006023778,
    f_addrchangecrimediff_i > 124.5                                     => 0.0901652177,
    f_addrchangecrimediff_i = NULL                                      => all4wfdn_97_c637,
                                                                           0.0015914770);

all4wfdn_97 := map(
    trim(c_med_rent) = ''                        => -0.0038050630,
    NULL < (integer)c_med_rent AND (integer)c_med_rent <= 1988 => all4wfdn_97_c636,
    (integer)c_med_rent > 1988                        => -0.1132561532,
                                                0.0003772714);

all4wfdn_98_c643 := map(
    trim(c_fammar_p) = ''                         => 0.0999840556,
    NULL < (integer)c_fammar_p AND (real)c_fammar_p <= 74.65 => 0.0400279859,
    (real)c_fammar_p > 74.65                        => 0.2256391135,
                                                 0.0999840556);

all4wfdn_98_c642 := map(
    NULL < f_rel_criminal_count_i AND f_rel_criminal_count_i <= 0.5 => all4wfdn_98_c643,
    f_rel_criminal_count_i > 0.5                                    => 0.0208607525,
    f_rel_criminal_count_i = NULL                                   => 0.0295886199,
                                                                       0.0295886199);

all4wfdn_98_c641 := map(
    NULL < f_vf_hi_risk_ct_i AND f_vf_hi_risk_ct_i <= 0.5 => -0.0030393804,
    f_vf_hi_risk_ct_i > 0.5                               => all4wfdn_98_c642,
    f_vf_hi_risk_ct_i = NULL                              => 0.0008792322,
                                                             0.0008792322);

all4wfdn_98_c644 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 1.5 => 0.1457557070,
    f_rel_bankrupt_count_i > 1.5                                    => -0.1067962531,
    f_rel_bankrupt_count_i = NULL                                   => 0.0159259939,
                                                                       0.0159259939);

all4wfdn_98 := map(
    trim(c_retired2) = ''                         => all4wfdn_98_c644,
    NULL < (integer)c_retired2 AND (real)c_retired2 <= 188.5 => all4wfdn_98_c641,
    (real)c_retired2 > 188.5                        => -0.1638284078,
                                                 0.0003430758);

all4wfdn_99_c648 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 2.5 => 0.1233057370,
    f_srchvelocityrisktype_i > 2.5                                      => 0.0218313103,
    f_srchvelocityrisktype_i = NULL                                     => 0.0408797540,
                                                                           0.0408797540);

all4wfdn_99_c647 := map(
    NULL < r_c23_inp_addr_owned_not_occ_d AND r_c23_inp_addr_owned_not_occ_d <= 0.5 => -0.0020678311,
    r_c23_inp_addr_owned_not_occ_d > 0.5                                            => all4wfdn_99_c648,
    r_c23_inp_addr_owned_not_occ_d = NULL                                           => -0.0006461733,
                                                                                       -0.0006461733);

all4wfdn_99_c649 := map(
    trim(c_easiqlife) = ''                          => 0.0751451182,
    NULL < (integer)c_easiqlife AND (real)c_easiqlife <= 125.5 => 0.1720065835,
    (real)c_easiqlife > 125.5                         => -0.0047925968,
                                                   0.0751451182);

all4wfdn_99_c646 := map(
    NULL < f_adls_per_phone_c6_i AND f_adls_per_phone_c6_i <= 1.5 => all4wfdn_99_c647,
    f_adls_per_phone_c6_i > 1.5                                   => all4wfdn_99_c649,
    f_adls_per_phone_c6_i = NULL                                  => -0.0000226302,
                                                                     -0.0000226302);

all4wfdn_99 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 424.5 => all4wfdn_99_c646,
    r_c13_curr_addr_lres_d > 424.5                                    => -0.1103423873,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0004870292,
                                                                         -0.0004870292);

all4wfdn_100_c653 := map(
    NULL < r_i60_inq_hiriskcred_count12_i AND r_i60_inq_hiriskcred_count12_i <= 2.5 => 0.1233748257,
    r_i60_inq_hiriskcred_count12_i > 2.5                                            => -0.0615530536,
    r_i60_inq_hiriskcred_count12_i = NULL                                           => 0.0760152468,
                                                                                       0.0760152468);

all4wfdn_100_c652 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 74.05 => 0.0122299601,
    r_c12_source_profile_d > 74.05                                    => all4wfdn_100_c653,
    r_c12_source_profile_d = NULL                                     => 0.0234962897,
                                                                         0.0234962897);

all4wfdn_100_c654 := map(
    NULL < f_hh_lienholders_i AND f_hh_lienholders_i <= 0.5 => 0.0547746980,
    f_hh_lienholders_i > 0.5                                => -0.0134544737,
    f_hh_lienholders_i = NULL                               => 0.0115335670,
                                                               0.0115335670);

all4wfdn_100_c651 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.0126249377 => all4wfdn_100_c652,
    f_add_input_nhood_mfd_pct_i > 0.0126249377                                         => -0.0077630950,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => all4wfdn_100_c654,
                                                                                          -0.0014512091);

all4wfdn_100 := map(
    NULL < r_l70_inp_addr_dirty_i AND r_l70_inp_addr_dirty_i <= 0.5 => all4wfdn_100_c651,
    r_l70_inp_addr_dirty_i > 0.5                                    => -0.0415621443,
    r_l70_inp_addr_dirty_i = NULL                                   => -0.0039667803,
                                                                       -0.0039667803);

all4wfdn_101_c657 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 39678.5 => 0.0005036667,
    f_addrchangeincomediff_d > 39678.5                                      => 0.1133399222,
    f_addrchangeincomediff_d = NULL                                         => 0.0106201174,
                                                                               0.0029883400);

all4wfdn_101_c659 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= -0.5 => -0.0737922764,
    r_pb_order_freq_d > -0.5                               => 0.0876685695,
    r_pb_order_freq_d = NULL                               => -0.0067816844,
                                                              0.0056853115);

all4wfdn_101_c658 := map(
    trim(c_serv_empl) = ''                         => 0.0522384601,
    NULL < (integer)c_serv_empl AND (real)c_serv_empl <= 64.5 => 0.1321580284,
    (real)c_serv_empl > 64.5                         => all4wfdn_101_c659,
                                                  0.0522384601);

all4wfdn_101_c656 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => all4wfdn_101_c657,
    f_validationrisktype_i > 1.5                                    => all4wfdn_101_c658,
    f_validationrisktype_i = NULL                                   => 0.0040900121,
                                                                       0.0040900121);

all4wfdn_101 := map(
    NULL < r_l70_inp_addr_dirty_i AND r_l70_inp_addr_dirty_i <= 0.5 => all4wfdn_101_c656,
    r_l70_inp_addr_dirty_i > 0.5                                    => -0.0424219113,
    r_l70_inp_addr_dirty_i = NULL                                   => 0.0010668803,
                                                                       0.0010668803);

all4wfdn_102_c663 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 4.5 => 0.1850656360,
    f_srchaddrsrchcount_i > 4.5                                   => 0.0072449011,
    f_srchaddrsrchcount_i = NULL                                  => 0.0921592970,
                                                                     0.0921592970);

all4wfdn_102_c662 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 361.5 => -0.0044694265,
    r_c13_curr_addr_lres_d > 361.5                                    => all4wfdn_102_c663,
    r_c13_curr_addr_lres_d = NULL                                     => -0.0036191103,
                                                                         -0.0036191103);

all4wfdn_102_c661 := map(
    NULL < r_c13_max_lres_d AND r_c13_max_lres_d <= 430 => all4wfdn_102_c662,
    r_c13_max_lres_d > 430                              => -0.1065841193,
    r_c13_max_lres_d = NULL                             => -0.0044138039,
                                                           -0.0044138039);

all4wfdn_102_c664 := map(
    trim(c_very_rich) = ''                          => 0.0908193922,
    NULL < (integer)c_very_rich AND (real)c_very_rich <= 123.5 => 0.0188547773,
    (real)c_very_rich > 123.5                         => 0.2295866032,
                                                   0.0908193922);

all4wfdn_102 := map(
    NULL < f_divrisktype_i AND f_divrisktype_i <= 5.5 => all4wfdn_102_c661,
    f_divrisktype_i > 5.5                             => all4wfdn_102_c664,
    f_divrisktype_i = NULL                            => -0.0033375921,
                                                         -0.0033375921);

all4wfdn_103_c666 := map(
    trim(c_rest_indx) = ''                          => 0.0893672809,
    NULL < (integer)c_rest_indx AND (real)c_rest_indx <= 104.5 => 0.1835282747,
    (real)c_rest_indx > 104.5                         => -0.0128187977,
                                                   0.0893672809);

all4wfdn_103_c668 := map(
    NULL < f_srchunvrfdaddrcount_i AND f_srchunvrfdaddrcount_i <= 1.5 => 0.0022765871,
    f_srchunvrfdaddrcount_i > 1.5                                     => 0.0813189044,
    f_srchunvrfdaddrcount_i = NULL                                    => 0.0034451257,
                                                                         0.0034451257);

all4wfdn_103_c669 := map(
    NULL < f_sourcerisktype_i AND f_sourcerisktype_i <= 3.5 => 0.1345351827,
    f_sourcerisktype_i > 3.5                                => -0.1009925034,
    f_sourcerisktype_i = NULL                               => 0.0255240577,
                                                               0.0255240577);

all4wfdn_103_c667 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.4526363332 => all4wfdn_103_c668,
    f_add_input_mobility_index_i > 0.4526363332                                          => -0.0350365984,
    f_add_input_mobility_index_i = NULL                                                  => all4wfdn_103_c669,
                                                                                            -0.0015598566);

all4wfdn_103 := map(
    NULL < r_i60_inq_mortgage_recency_d AND r_i60_inq_mortgage_recency_d <= 18 => all4wfdn_103_c666,
    r_i60_inq_mortgage_recency_d > 18                                          => all4wfdn_103_c667,
    r_i60_inq_mortgage_recency_d = NULL                                        => -0.0004718346,
                                                                                  -0.0004718346);

all4wfdn_104_c674 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 3.5 => 0.0859465583,
    f_phones_per_addr_curr_i > 3.5                                      => 0.2171288810,
    f_phones_per_addr_curr_i = NULL                                     => 0.1464922457,
                                                                           0.1464922457);

all4wfdn_104_c673 := map(
    NULL < r_a41_prop_owner_inp_only_d AND r_a41_prop_owner_inp_only_d <= 0.5 => 0.0294629684,
    r_a41_prop_owner_inp_only_d > 0.5                                         => all4wfdn_104_c674,
    r_a41_prop_owner_inp_only_d = NULL                                        => 0.0845761664,
                                                                                 0.0845761664);

all4wfdn_104_c672 := map(
    trim(c_pop_75_84_p) = ''                           => 0.0295322168,
    NULL < (integer)c_pop_75_84_p AND (real)c_pop_75_84_p <= 6.05 => 0.0165864732,
    (real)c_pop_75_84_p > 6.05                           => all4wfdn_104_c673,
                                                      0.0295322168);

all4wfdn_104_c671 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 0.5 => all4wfdn_104_c672,
    r_c20_email_verification_d > 0.5                                        => 0.0019762105,
    r_c20_email_verification_d = NULL                                       => 0.0078330944,
                                                                               0.0078330944);

all4wfdn_104 := map(
    NULL < f_rel_bankrupt_count_i AND f_rel_bankrupt_count_i <= 1.5 => all4wfdn_104_c671,
    f_rel_bankrupt_count_i > 1.5                                    => -0.0141059864,
    f_rel_bankrupt_count_i = NULL                                   => -0.0035719582,
                                                                       -0.0035719582);

all4wfdn_105_c676 := map(
    trim(c_femdiv_p) = ''                       => 0.1018280846,
    NULL < (integer)c_femdiv_p AND (real)c_femdiv_p <= 5.5 => -0.0139743474,
    (real)c_femdiv_p > 5.5                        => 0.3015281970,
                                               0.1018280846);

all4wfdn_105_c679 := map(
    trim(c_pop00) = ''                       => 0.0575371872,
    NULL < (integer)c_pop00 AND (real)c_pop00 <= 1285.5 => -0.0654857827,
    (real)c_pop00 > 1285.5                     => 0.1746415262,
                                            0.0575371872);

all4wfdn_105_c678 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 4.5 => -0.0425196351,
    f_rel_ageover40_count_d > 4.5                                     => all4wfdn_105_c679,
    f_rel_ageover40_count_d = NULL                                    => -0.0137834291,
                                                                         -0.0137834291);

all4wfdn_105_c677 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0012019248 => 0.1510300150,
    f_add_curr_nhood_bus_pct_i > 0.0012019248                                        => -0.0010368493,
    f_add_curr_nhood_bus_pct_i = NULL                                                => all4wfdn_105_c678,
                                                                                        -0.0004324104);

all4wfdn_105 := map(
    NULL < r_d32_mos_since_fel_ls_d AND r_d32_mos_since_fel_ls_d <= 103.5 => all4wfdn_105_c676,
    r_d32_mos_since_fel_ls_d > 103.5                                      => all4wfdn_105_c677,
    r_d32_mos_since_fel_ls_d = NULL                                       => 0.0009097690,
                                                                             0.0009097690);

all4wfdn_106_c682 := map(
    trim(c_mort_indx) = ''                          => -0.0080977747,
    NULL < (integer)c_mort_indx AND (real)c_mort_indx <= 183.5 => -0.0076374274,
    (real)c_mort_indx > 183.5                         => -0.1120700012,
                                                   -0.0080977747);

all4wfdn_106_c681 := map(
    NULL < f_vf_altlexid_phn_hi_risk_ct_i AND f_vf_altlexid_phn_hi_risk_ct_i <= 1.5 => all4wfdn_106_c682,
    f_vf_altlexid_phn_hi_risk_ct_i > 1.5                                            => 0.1012214417,
    f_vf_altlexid_phn_hi_risk_ct_i = NULL                                           => -0.0074283512,
                                                                                       -0.0074283512);

all4wfdn_106_c683 := map(
    trim(c_popover18) = ''                        => 0.0973665844,
    NULL < (integer)c_popover18 AND (integer)c_popover18 <= 622 => 0.3024904250,
    (integer)c_popover18 > 622                         => 0.0396385370,
                                                 0.0973665844);

all4wfdn_106_c684 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 3.5 => -0.0601627230,
    f_rel_incomeover50_count_d > 3.5                                        => 0.1180169081,
    f_rel_incomeover50_count_d = NULL                                       => 0.0290955043,
                                                                               0.0290955043);

all4wfdn_106 := map(
    trim(c_burglary) = ''                         => all4wfdn_106_c684,
    NULL < (integer)c_burglary AND (real)c_burglary <= 196.5 => all4wfdn_106_c681,
    (real)c_burglary > 196.5                        => all4wfdn_106_c683,
                                                 -0.0052331713);

all4wfdn_107_c689 := map(
    NULL < f_prevaddrmedianincome_d AND f_prevaddrmedianincome_d <= 51946 => 0.1955206531,
    f_prevaddrmedianincome_d > 51946                                      => -0.0164748332,
    f_prevaddrmedianincome_d = NULL                                       => 0.0907274298,
                                                                             0.0907274298);

all4wfdn_107_c688 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 60.5 => 0.0149344721,
    k_comb_age_d > 60.5                          => all4wfdn_107_c689,
    k_comb_age_d = NULL                          => 0.0204980313,
                                                    0.0204980313);

all4wfdn_107_c687 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.05447277255 => -0.0380025145,
    f_add_curr_nhood_mfd_pct_i > 0.05447277255                                        => all4wfdn_107_c688,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => -0.0256243503,
                                                                                         -0.0022691649);

all4wfdn_107_c686 := map(
    NULL < r_l79_adls_per_addr_c6_i AND r_l79_adls_per_addr_c6_i <= 4.5 => all4wfdn_107_c687,
    r_l79_adls_per_addr_c6_i > 4.5                                      => 0.1566492789,
    r_l79_adls_per_addr_c6_i = NULL                                     => 0.0029380847,
                                                                           0.0029380847);

all4wfdn_107 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 124.5 => -0.0015521108,
    f_addrchangecrimediff_i > 124.5                                     => 0.0795711251,
    f_addrchangecrimediff_i = NULL                                      => all4wfdn_107_c686,
                                                                           -0.0002927936);

all4wfdn_108_c693 := map(
    trim(c_rape) = ''                     => 0.1124569699,
    NULL < (integer)c_rape AND (real)c_rape <= 103.5 => -0.0136913789,
    (real)c_rape > 103.5                    => 0.2794484317,
                                         0.1124569699);

all4wfdn_108_c692 := map(
    trim(c_pop_65_74_p) = ''                           => -0.0025558513,
    NULL < (integer)c_pop_65_74_p AND (real)c_pop_65_74_p <= 0.15 => all4wfdn_108_c693,
    (real)c_pop_65_74_p > 0.15                           => -0.0036482939,
                                                      -0.0025558513);

all4wfdn_108_c694 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 1.5 => 0.0251171713,
    k_inq_ssns_per_addr_i > 1.5                                   => 0.3058929736,
    k_inq_ssns_per_addr_i = NULL                                  => 0.1177731860,
                                                                     0.1177731860);

all4wfdn_108_c691 := map(
    NULL < f_srchphonesrchcountday_i AND f_srchphonesrchcountday_i <= 1.5 => all4wfdn_108_c692,
    f_srchphonesrchcountday_i > 1.5                                       => all4wfdn_108_c694,
    f_srchphonesrchcountday_i = NULL                                      => -0.0011741429,
                                                                             -0.0011741429);

all4wfdn_108 := map(
    trim(c_hval_80k_p) = ''                           => -0.0355355746,
    NULL < (integer)c_hval_80k_p AND (real)c_hval_80k_p <= 61.15 => all4wfdn_108_c691,
    (real)c_hval_80k_p > 61.15                          => 0.2311467421,
                                                     -0.0003669650);

all4wfdn_109_c698 := map(
    NULL < f_rel_under500miles_cnt_d AND f_rel_under500miles_cnt_d <= 0.5 => 0.1039725012,
    f_rel_under500miles_cnt_d > 0.5                                       => 0.0034231244,
    f_rel_under500miles_cnt_d = NULL                                      => 0.0043762607,
                                                                             0.0043762607);

all4wfdn_109_c699 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 27.5 => -0.0384032895,
    f_inq_count_i > 27.5                           => 0.2184396661,
    f_inq_count_i = NULL                           => -0.0338693516,
                                                      -0.0338693516);

all4wfdn_109_c697 := map(
    trim(c_young) = ''                      => -0.0043932688,
    NULL < (integer)c_young AND (real)c_young <= 30.25 => all4wfdn_109_c698,
    (real)c_young > 30.25                     => all4wfdn_109_c699,
                                           -0.0043932688);

all4wfdn_109_c696 := map(
    trim(c_mil_emp) = ''                        => -0.0285621560,
    NULL < (integer)c_mil_emp AND (real)c_mil_emp <= 16.75 => all4wfdn_109_c697,
    (real)c_mil_emp > 16.75                       => 0.1986331550,
                                               -0.0037142182);

all4wfdn_109 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 52.5 => all4wfdn_109_c696,
    f_phones_per_addr_curr_i > 52.5                                      => 0.1025846491,
    f_phones_per_addr_curr_i = NULL                                      => -0.0029123262,
                                                                            -0.0029123262);

all4wfdn_110_c704 := map(
    NULL < f_curraddrburglaryindex_i AND f_curraddrburglaryindex_i <= 136.5 => -0.0692132075,
    f_curraddrburglaryindex_i > 136.5                                       => 0.1354463687,
    f_curraddrburglaryindex_i = NULL                                        => 0.0224315425,
                                                                               0.0224315425);

all4wfdn_110_c703 := map(
    trim(c_rape) = ''                    => 0.0891570749,
    NULL < (integer)c_rape AND (real)c_rape <= 92.5 => 0.1840979754,
    (real)c_rape > 92.5                    => all4wfdn_110_c704,
                                        0.0891570749);

all4wfdn_110_c702 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 1.5 => all4wfdn_110_c703,
    r_c20_email_verification_d > 1.5                                        => 0.0210789817,
    r_c20_email_verification_d = NULL                                       => 0.0431471098,
                                                                               0.0431471098);

all4wfdn_110_c701 := map(
    trim(c_med_age) = ''                        => 0.0077749486,
    NULL < (integer)c_med_age AND (real)c_med_age <= 44.75 => 0.0036443879,
    (real)c_med_age > 44.75                       => all4wfdn_110_c702,
                                               0.0077749486);

all4wfdn_110 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 85.5 => -0.0159474128,
    f_mos_inq_banko_cm_fseen_d > 85.5                                        => all4wfdn_110_c701,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => -0.0062600698,
                                                                                -0.0062600698);

all4wfdn_111_c708 := map(
    trim(c_larceny) = ''                     => 0.1290694123,
    NULL < (integer)c_larceny AND (integer)c_larceny <= 66 => 0.0755957243,
    (integer)c_larceny > 66                       => 0.2108207117,
                                            0.1290694123);

all4wfdn_111_c707 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 138 => all4wfdn_111_c708,
    f_fp_prevaddrburglaryindex_i > 138                                          => -0.0409630014,
    f_fp_prevaddrburglaryindex_i = NULL                                         => 0.0827417402,
                                                                                   0.0827417402);

all4wfdn_111_c706 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 385.5 => 0.0043420462,
    r_c10_m_hdr_fs_d > 385.5                              => all4wfdn_111_c707,
    r_c10_m_hdr_fs_d = NULL                               => 0.0079550157,
                                                             0.0079550157);

all4wfdn_111_c709 := map(
    trim(c_highinc) = ''                        => 0.0085992498,
    NULL < (integer)c_highinc AND (real)c_highinc <= 33.85 => -0.0073547853,
    (real)c_highinc > 33.85                       => -0.0612971512,
                                               -0.0105765877);

all4wfdn_111 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => all4wfdn_111_c706,
    r_d30_derog_count_i > 0.5                                 => all4wfdn_111_c709,
    r_d30_derog_count_i = NULL                                => -0.0038428108,
                                                                 -0.0038428108);

all4wfdn_112_c714 := map(
    trim(c_hh1_p) = ''                     => 0.0092512391,
    NULL < (integer)c_hh1_p AND (real)c_hh1_p <= 7.55 => 0.1831713572,
    (real)c_hh1_p > 7.55                     => -0.0023923323,
                                          0.0092512391);

all4wfdn_112_c713 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= 27 => all4wfdn_112_c714,
    f_addrchangecrimediff_i > 27                                     => 0.1496192382,
    f_addrchangecrimediff_i = NULL                                   => -0.0032150837,
                                                                        0.0124675645);

all4wfdn_112_c712 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.1839323714 => 0.1296122785,
    f_add_curr_mobility_index_i > 0.1839323714                                         => all4wfdn_112_c713,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0179593610,
                                                                                          0.0179593610);

all4wfdn_112_c711 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 10.5 => all4wfdn_112_c712,
    f_corraddrnamecount_d > 10.5                                   => 0.1148339885,
    f_corraddrnamecount_d = NULL                                   => 0.0263269146,
                                                                      0.0263269146);

all4wfdn_112 := map(
    NULL < f_hh_collections_ct_i AND f_hh_collections_ct_i <= 0.5 => all4wfdn_112_c711,
    f_hh_collections_ct_i > 0.5                                   => -0.0135824198,
    f_hh_collections_ct_i = NULL                                  => -0.0094887584,
                                                                     -0.0094887584);

all4wfdn_113_c717 := map(
    NULL < r_phn_pcs_n AND r_phn_pcs_n <= 0.5 => 0.0454410537,
    r_phn_pcs_n > 0.5                         => -0.0060999420,
    r_phn_pcs_n = NULL                        => 0.0166752268,
                                                 0.0166752268);

all4wfdn_113_c716 := map(
    NULL < r_phn_cell_n AND r_phn_cell_n <= 0.5 => all4wfdn_113_c717,
    r_phn_cell_n > 0.5                          => -0.0040448345,
    r_phn_cell_n = NULL                         => 0.0031841927,
                                                   0.0031841927);

all4wfdn_113_c718 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 11.5 => -0.0239439241,
    f_corraddrnamecount_d > 11.5                                   => -0.1765756448,
    f_corraddrnamecount_d = NULL                                   => -0.0294084067,
                                                                      -0.0294084067);

all4wfdn_113_c719 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 6.5 => 0.0673183630,
    f_rel_under25miles_cnt_d > 6.5                                      => -0.0740659954,
    f_rel_under25miles_cnt_d = NULL                                     => -0.0009936082,
                                                                           -0.0009936082);

all4wfdn_113 := map(
    trim(c_housingcpi) = ''                            => all4wfdn_113_c719,
    NULL < (integer)c_housingcpi AND (real)c_housingcpi <= 215.95 => all4wfdn_113_c716,
    (real)c_housingcpi > 215.95                          => all4wfdn_113_c718,
                                                      -0.0013797294);

all4wfdn_114_c723 := map(
    trim(C_RENTOCC_P) = ''                          => -0.0018923033,
    NULL < (integer)C_RENTOCC_P AND (real)C_RENTOCC_P <= 93.05 => -0.0025970086,
    (real)C_RENTOCC_P > 93.05                         => 0.1750591912,
                                                   -0.0018923033);

all4wfdn_114_c724 := map(
    NULL < f_rel_ageover30_count_d AND f_rel_ageover30_count_d <= 8.5 => 0.0068758417,
    f_rel_ageover30_count_d > 8.5                                     => -0.0682172142,
    f_rel_ageover30_count_d = NULL                                    => -0.0298430073,
                                                                         -0.0298430073);

all4wfdn_114_c722 := map(
    trim(c_pop_0_5_p) = ''                         => all4wfdn_114_c724,
    NULL < (integer)c_pop_0_5_p AND (real)c_pop_0_5_p <= 0.55 => -0.1189412356,
    (real)c_pop_0_5_p > 0.55                         => all4wfdn_114_c723,
                                                  -0.0026403917);

all4wfdn_114_c721 := map(
    NULL < f_srchfraudsrchcountmo_i AND f_srchfraudsrchcountmo_i <= 9.5 => all4wfdn_114_c722,
    f_srchfraudsrchcountmo_i > 9.5                                      => 0.1965512437,
    f_srchfraudsrchcountmo_i = NULL                                     => -0.0015669832,
                                                                           -0.0015669832);

all4wfdn_114 := map(
    NULL < k_inq_per_phone_i AND k_inq_per_phone_i <= 21.5 => all4wfdn_114_c721,
    k_inq_per_phone_i > 21.5                               => 0.1702574901,
    k_inq_per_phone_i = NULL                               => -0.0009564662,
                                                              -0.0009564662);

all4wfdn_115_c727 := map(
    NULL < f_phone_ver_insurance_d AND f_phone_ver_insurance_d <= 3.5 => 0.0312279576,
    f_phone_ver_insurance_d > 3.5                                     => -0.0049787801,
    f_phone_ver_insurance_d = NULL                                    => 0.0083723289,
                                                                         0.0083723289);

all4wfdn_115_c726 := map(
    trim(c_for_sale) = ''                         => -0.0040423405,
    NULL < (integer)c_for_sale AND (real)c_for_sale <= 119.5 => -0.0128523909,
    (real)c_for_sale > 119.5                        => all4wfdn_115_c727,
                                                 -0.0040423405);

all4wfdn_115_c728 := map(
    trim(c_rental) = ''                     => 0.1154204351,
    NULL < (integer)c_rental AND (integer)c_rental <= 149 => 0.2377981808,
    (integer)c_rental > 149                      => -0.0000488894,
                                           0.1154204351);

all4wfdn_115_c729 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 7.5 => 0.0446384354,
    f_rel_under25miles_cnt_d > 7.5                                      => -0.0626289972,
    f_rel_under25miles_cnt_d = NULL                                     => -0.0051248065,
                                                                           -0.0051248065);

all4wfdn_115 := map(
    trim(C_RENTOCC_P) = ''                          => all4wfdn_115_c729,
    NULL < (integer)C_RENTOCC_P AND (real)C_RENTOCC_P <= 90.45 => all4wfdn_115_c726,
    (real)C_RENTOCC_P > 90.45                         => all4wfdn_115_c728,
                                                   -0.0031223461);

all4wfdn_116_c732 := map(
    NULL < r_c23_inp_addr_owned_not_occ_d AND r_c23_inp_addr_owned_not_occ_d <= 0.5 => 0.0145130423,
    r_c23_inp_addr_owned_not_occ_d > 0.5                                            => 0.0884600795,
    r_c23_inp_addr_owned_not_occ_d = NULL                                           => 0.0175925696,
                                                                                       0.0175925696);

all4wfdn_116_c731 := map(
    trim(c_bargains) = ''                         => 0.0031956096,
    NULL < (integer)c_bargains AND (real)c_bargains <= 112.5 => all4wfdn_116_c732,
    (real)c_bargains > 112.5                        => -0.0082448766,
                                                 0.0031956096);

all4wfdn_116_c734 := map(
    NULL < f_prevaddrcartheftindex_i AND f_prevaddrcartheftindex_i <= 69.5 => 0.2140207953,
    f_prevaddrcartheftindex_i > 69.5                                       => -0.0025765976,
    f_prevaddrcartheftindex_i = NULL                                       => 0.0425616377,
                                                                              0.0425616377);

all4wfdn_116_c733 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 57.5 => -0.0812261944,
    r_pb_order_freq_d > 57.5                               => all4wfdn_116_c734,
    r_pb_order_freq_d = NULL                               => -0.0771146925,
                                                              -0.0452142233);

all4wfdn_116 := map(
    trim(c_no_labfor) = ''                          => -0.0718210188,
    NULL < (integer)c_no_labfor AND (real)c_no_labfor <= 162.5 => all4wfdn_116_c731,
    (real)c_no_labfor > 162.5                         => all4wfdn_116_c733,
                                                   -0.0011201177);

all4wfdn_117_c738 := map(
    trim(c_hh1_p) = ''                      => 0.0330956407,
    NULL < (integer)c_hh1_p AND (real)c_hh1_p <= 10.05 => 0.1557353476,
    (real)c_hh1_p > 10.05                     => 0.0208160272,
                                           0.0330956407);

all4wfdn_117_c737 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 219 => -0.0077633375,
    f_addrchangeincomediff_d > 219                                      => all4wfdn_117_c738,
    f_addrchangeincomediff_d = NULL                                     => -0.0067514777,
                                                                           -0.0052162249);

all4wfdn_117_c739 := map(
    trim(c_pop_0_5_p) = ''                        => 0.0078171139,
    NULL < (integer)c_pop_0_5_p AND (real)c_pop_0_5_p <= 8.2 => 0.1492803032,
    (real)c_pop_0_5_p > 8.2                         => -0.0919717845,
                                                 0.0078171139);

all4wfdn_117_c736 := map(
    NULL < r_f00_dob_score_d AND r_f00_dob_score_d <= 80 => 0.0691155836,
    r_f00_dob_score_d > 80                               => all4wfdn_117_c737,
    r_f00_dob_score_d = NULL                             => all4wfdn_117_c739,
                                                            -0.0045391906);

all4wfdn_117 := map(
    NULL < f_vf_altlexid_addr_hi_risk_ct_i AND f_vf_altlexid_addr_hi_risk_ct_i <= 4.5 => all4wfdn_117_c736,
    f_vf_altlexid_addr_hi_risk_ct_i > 4.5                                             => 0.1512811065,
    f_vf_altlexid_addr_hi_risk_ct_i = NULL                                            => -0.0035989652,
                                                                                         -0.0035989652);

all4wfdn_118_c743 := map(
    trim(c_assault) = ''                        => -0.0045047365,
    NULL < (integer)c_assault AND (real)c_assault <= 194.5 => 0.0003052407,
    (real)c_assault > 194.5                       => 0.0872979613,
                                               0.0021124253);

all4wfdn_118_c744 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 52.5 => -0.0060641561,
    f_prevaddrageoldest_d > 52.5                                   => 0.1761031355,
    f_prevaddrageoldest_d = NULL                                   => 0.0532576214,
                                                                      0.0532576214);

all4wfdn_118_c742 := map(
    NULL < (integer)k_nap_contradictory_i AND (real)k_nap_contradictory_i <= 0.5 => all4wfdn_118_c743,
    (real)k_nap_contradictory_i > 0.5                                   => all4wfdn_118_c744,
    (integer)k_nap_contradictory_i = NULL                                  => 0.0027276569,
                                                                     0.0027276569);

all4wfdn_118_c741 := map(
    NULL < f_vf_altlexid_addr_lo_risk_ct_d AND f_vf_altlexid_addr_lo_risk_ct_d <= 7.5 => all4wfdn_118_c742,
    f_vf_altlexid_addr_lo_risk_ct_d > 7.5                                             => -0.1169151921,
    f_vf_altlexid_addr_lo_risk_ct_d = NULL                                            => 0.0022278891,
                                                                                         0.0022278891);

all4wfdn_118 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 79.5 => all4wfdn_118_c741,
    k_comb_age_d > 79.5                          => -0.1064197159,
    k_comb_age_d = NULL                          => 0.0017293284,
                                                    0.0017293284);

all4wfdn_119_c748 := map(
    NULL < r_c10_m_hdr_fs_d AND r_c10_m_hdr_fs_d <= 380.5 => -0.0370195308,
    r_c10_m_hdr_fs_d > 380.5                              => -0.1818218710,
    r_c10_m_hdr_fs_d = NULL                               => -0.0585373610,
                                                             -0.0585373610);

all4wfdn_119_c747 := map(
    trim(c_rnt2001_p) = ''                          => -0.0148040461,
    NULL < (integer)c_rnt2001_p AND (real)c_rnt2001_p <= 20.65 => 0.0005950021,
    (real)c_rnt2001_p > 20.65                         => all4wfdn_119_c748,
                                                   -0.0012232924);

all4wfdn_119_c746 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => all4wfdn_119_c747,
    r_p85_phn_not_issued_i > 0.5                                    => 0.0836699728,
    r_p85_phn_not_issued_i = NULL                                   => -0.0006666927,
                                                                       -0.0006666927);

all4wfdn_119_c749 := map(
    NULL < f_inq_count24_i AND f_inq_count24_i <= 5.5 => 0.0138687905,
    f_inq_count24_i > 5.5                             => 0.2146274705,
    f_inq_count24_i = NULL                            => 0.0863074895,
                                                         0.0863074895);

all4wfdn_119 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 5.5 => all4wfdn_119_c746,
    k_inq_ssns_per_addr_i > 5.5                                   => all4wfdn_119_c749,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0002882794,
                                                                     0.0002882794);

all4wfdn_120_c754 := map(
    NULL < f_srchfraudsrchcountyr_i AND f_srchfraudsrchcountyr_i <= 1.5 => 0.2111680664,
    f_srchfraudsrchcountyr_i > 1.5                                      => 0.0644903303,
    f_srchfraudsrchcountyr_i = NULL                                     => 0.0815372114,
                                                                           0.0815372114);

all4wfdn_120_c753 := map(
    trim(c_totsales) = ''                       => 0.0568944924,
    NULL < (integer)c_totsales AND (integer)c_totsales <= 480 => -0.0736485769,
    (integer)c_totsales > 480                        => all4wfdn_120_c754,
                                               0.0568944924);

all4wfdn_120_c752 := map(
    trim(c_lowrent) = ''                        => 0.0284326348,
    NULL < (integer)c_lowrent AND (real)c_lowrent <= 42.15 => all4wfdn_120_c753,
    (real)c_lowrent > 42.15                       => -0.0465475276,
                                               0.0284326348);

all4wfdn_120_c751 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -25227 => 0.1541065715,
    f_addrchangevaluediff_d > -25227                                     => all4wfdn_120_c752,
    f_addrchangevaluediff_d = NULL                                       => -0.0077457490,
                                                                            0.0233708171);

all4wfdn_120 := map(
    NULL < f_srchssnsrchcountwk_i AND f_srchssnsrchcountwk_i <= 0.5 => -0.0078326787,
    f_srchssnsrchcountwk_i > 0.5                                    => all4wfdn_120_c751,
    f_srchssnsrchcountwk_i = NULL                                   => -0.0030458591,
                                                                       -0.0030458591);

all4wfdn_121_c756 := map(
    trim(c_rental) = ''                       => -0.0264588987,
    NULL < (integer)c_rental AND (real)c_rental <= 180.5 => -0.0365916876,
    (real)c_rental > 180.5                      => 0.0491942363,
                                             -0.0264588987);

all4wfdn_121_c759 := map(
    trim(c_very_rich) = ''                        => 0.1083311944,
    NULL < (integer)c_very_rich AND (integer)c_very_rich <= 171 => -0.0181388291,
    (integer)c_very_rich > 171                         => 0.2496177897,
                                                 0.1083311944);

all4wfdn_121_c758 := map(
    trim(c_rich_nfam) = ''                          => 0.0449323996,
    NULL < (integer)c_rich_nfam AND (real)c_rich_nfam <= 197.5 => -0.0002497217,
    (real)c_rich_nfam > 197.5                         => all4wfdn_121_c759,
                                                   0.0012093787);

all4wfdn_121_c757 := map(
    NULL < r_p85_phn_not_issued_i AND r_p85_phn_not_issued_i <= 0.5 => all4wfdn_121_c758,
    r_p85_phn_not_issued_i > 0.5                                    => 0.1061093396,
    r_p85_phn_not_issued_i = NULL                                   => 0.0017872077,
                                                                       0.0017872077);

all4wfdn_121 := map(
    NULL < r_c20_email_count_i AND r_c20_email_count_i <= 0.5 => all4wfdn_121_c756,
    r_c20_email_count_i > 0.5                                 => all4wfdn_121_c757,
    r_c20_email_count_i = NULL                                => -0.0034774896,
                                                                 -0.0034774896);

all4wfdn_122_c762 := map(
    trim(c_fammar18_p) = ''                           => -0.0078255881,
    NULL < (integer)c_fammar18_p AND (real)c_fammar18_p <= 68.35 => -0.0087543050,
    (real)c_fammar18_p > 68.35                          => 0.1409081032,
                                                     -0.0078255881);

all4wfdn_122_c761 := map(
    trim(c_low_hval) = ''                        => 0.0448452277,
    NULL < (integer)c_low_hval AND (real)c_low_hval <= 85.9 => all4wfdn_122_c762,
    (real)c_low_hval > 85.9                        => 0.2146379930,
                                                -0.0058303055);

all4wfdn_122_c764 := map(
    trim(c_professional) = ''                            => 0.0597305814,
    NULL < (integer)c_professional AND (real)c_professional <= 8.75 => 0.0373616937,
    (real)c_professional > 8.75                            => 0.1657296520,
                                                        0.0597305814);

all4wfdn_122_c763 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 0.5 => all4wfdn_122_c764,
    k_inq_adls_per_phone_i > 0.5                                    => 0.0174992066,
    k_inq_adls_per_phone_i = NULL                                   => 0.0262596892,
                                                                       0.0262596892);

all4wfdn_122 := map(
    NULL < f_srchunvrfdphonecount_i AND f_srchunvrfdphonecount_i <= 1.5 => all4wfdn_122_c761,
    f_srchunvrfdphonecount_i > 1.5                                      => all4wfdn_122_c763,
    f_srchunvrfdphonecount_i = NULL                                     => 0.0012304712,
                                                                           0.0012304712);

all4wfdn_123_c768 := map(
    trim(c_lar_fam) = ''                       => 0.0199703552,
    NULL < (integer)c_lar_fam AND (real)c_lar_fam <= 61.5 => 0.1834027242,
    (real)c_lar_fam > 61.5                       => -0.0016858031,
                                              0.0199703552);

all4wfdn_123_c767 := map(
    NULL < f_addrchangecrimediff_i AND f_addrchangecrimediff_i <= -7.5 => 0.0855884740,
    f_addrchangecrimediff_i > -7.5                                     => 0.0035557143,
    f_addrchangecrimediff_i = NULL                                     => all4wfdn_123_c768,
                                                                          0.0099573560);

all4wfdn_123_c769 := map(
    trim(c_mort_indx) = ''                          => 0.0129801374,
    NULL < (integer)c_mort_indx AND (real)c_mort_indx <= 166.5 => 0.0083010477,
    (real)c_mort_indx > 166.5                         => 0.1817992135,
                                                   0.0129801374);

all4wfdn_123_c766 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 956 => all4wfdn_123_c767,
    r_p88_phn_dst_to_inp_add_i > 956                                        => 0.1286681038,
    r_p88_phn_dst_to_inp_add_i = NULL                                       => all4wfdn_123_c769,
                                                                               0.0117675197);

all4wfdn_123 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 33.5 => -0.0135108635,
    f_prevaddrageoldest_d > 33.5                                   => all4wfdn_123_c766,
    f_prevaddrageoldest_d = NULL                                   => 0.0011123169,
                                                                      0.0011123169);

all4wfdn_124_c774 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 46500 => 0.0314223173,
    k_estimated_income_d > 46500                                  => 0.1006954871,
    k_estimated_income_d = NULL                                   => 0.0504669585,
                                                                     0.0504669585);

all4wfdn_124_c773 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 3.5 => all4wfdn_124_c774,
    f_inq_highriskcredit_count_i > 3.5                                          => 0.0079383023,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0328124866,
                                                                                   0.0328124866);

all4wfdn_124_c772 := map(
    NULL < f_prevaddrlenofres_d AND f_prevaddrlenofres_d <= 8.5 => -0.0321524730,
    f_prevaddrlenofres_d > 8.5                                  => all4wfdn_124_c773,
    f_prevaddrlenofres_d = NULL                                 => 0.0207602884,
                                                                   0.0207602884);

all4wfdn_124_c771 := map(
    NULL < f_adl_per_email_i AND f_adl_per_email_i <= 0.5 => all4wfdn_124_c772,
    f_adl_per_email_i > 0.5                               => -0.0217377564,
    f_adl_per_email_i = NULL                              => 0.0048649515,
                                                             0.0048649515);

all4wfdn_124 := map(
    trim(c_hval_150k_p) = ''                           => 0.0389215966,
    NULL < (integer)c_hval_150k_p AND (real)c_hval_150k_p <= 3.65 => -0.0147430740,
    (real)c_hval_150k_p > 3.65                           => all4wfdn_124_c771,
                                                      -0.0035011062);

all4wfdn_125_c777 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 31.5 => 0.0076360984,
    f_inq_count_i > 31.5                           => 0.2031963216,
    f_inq_count_i = NULL                           => 0.0096012480,
                                                      0.0096012480);

all4wfdn_125_c778 := map(
    trim(c_work_home) = ''                          => 0.1060152426,
    NULL < (integer)c_work_home AND (real)c_work_home <= 117.5 => 0.1919060364,
    (real)c_work_home > 117.5                         => 0.0303940002,
                                                   0.1060152426);

all4wfdn_125_c776 := map(
    NULL < f_curraddrmedianincome_d AND f_curraddrmedianincome_d <= 103302.5 => all4wfdn_125_c777,
    f_curraddrmedianincome_d > 103302.5                                      => all4wfdn_125_c778,
    f_curraddrmedianincome_d = NULL                                          => 0.0115949076,
                                                                                0.0115949076);

all4wfdn_125_c779 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 6.5 => 0.0139093226,
    f_rel_under25miles_cnt_d > 6.5                                      => -0.1236346588,
    f_rel_under25miles_cnt_d = NULL                                     => -0.0550038837,
                                                                           -0.0550038837);

all4wfdn_125 := map(
    trim(c_rnt750_p) = ''                         => all4wfdn_125_c779,
    NULL < (integer)c_rnt750_p AND (real)c_rnt750_p <= 28.35 => -0.0118352165,
    (real)c_rnt750_p > 28.35                        => all4wfdn_125_c776,
                                                 -0.0026546831);

all4wfdn_126_c782 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.08632694375 => 0.0217528433,
    f_add_curr_nhood_bus_pct_i > 0.08632694375                                        => 0.3403840059,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => 0.0883705686,
                                                                                         0.0883705686);

all4wfdn_126_c784 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 68.5 => -0.0284934014,
    k_comb_age_d > 68.5                          => -0.1254990453,
    k_comb_age_d = NULL                          => -0.0332616694,
                                                    -0.0332616694);

all4wfdn_126_c783 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 3.5 => all4wfdn_126_c784,
    f_rel_homeover50_count_d > 3.5                                      => 0.0053862248,
    f_rel_homeover50_count_d = NULL                                     => -0.0621506947,
                                                                           0.0015721457);

all4wfdn_126_c781 := map(
    NULL < r_d32_mos_since_crim_ls_d AND r_d32_mos_since_crim_ls_d <= 9.5 => all4wfdn_126_c782,
    r_d32_mos_since_crim_ls_d > 9.5                                       => all4wfdn_126_c783,
    r_d32_mos_since_crim_ls_d = NULL                                      => 0.0033017605,
                                                                             0.0033017605);

all4wfdn_126 := map(
    NULL < f_curraddrmedianvalue_d AND f_curraddrmedianvalue_d <= 563434 => all4wfdn_126_c781,
    f_curraddrmedianvalue_d > 563434                                     => -0.0603921817,
    f_curraddrmedianvalue_d = NULL                                       => 0.0004639524,
                                                                            0.0004639524);

all4wfdn_127_c786 := map(
    trim(c_professional) = ''                            => -0.0124598039,
    NULL < (integer)c_professional AND (real)c_professional <= 4.45 => -0.0162126609,
    (real)c_professional > 4.45                            => 0.0117588764,
                                                        -0.0059702467);

all4wfdn_127_c789 := map(
    NULL < r_c20_email_verification_d AND r_c20_email_verification_d <= 3.5 => 0.0303016833,
    r_c20_email_verification_d > 3.5                                        => 0.1320986837,
    r_c20_email_verification_d = NULL                                       => 0.0698755783,
                                                                               0.0698755783);

all4wfdn_127_c788 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.34577715205 => all4wfdn_127_c789,
    f_add_curr_mobility_index_i > 0.34577715205                                         => 0.2258782524,
    f_add_curr_mobility_index_i = NULL                                                  => 0.1192764251,
                                                                                           0.1192764251);

all4wfdn_127_c787 := map(
    trim(c_larceny) = ''                        => 0.0534040261,
    NULL < (integer)c_larceny AND (real)c_larceny <= 113.5 => -0.0122495278,
    (real)c_larceny > 113.5                       => all4wfdn_127_c788,
                                               0.0534040261);

all4wfdn_127 := map(
    NULL < r_d32_criminal_count_i AND r_d32_criminal_count_i <= 5.5 => all4wfdn_127_c786,
    r_d32_criminal_count_i > 5.5                                    => all4wfdn_127_c787,
    r_d32_criminal_count_i = NULL                                   => -0.0036095018,
                                                                       -0.0036095018);

all4wfdn_128_c793 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 3.5 => 0.2564551255,
    f_inq_count_i > 3.5                           => 0.0515783297,
    f_inq_count_i = NULL                          => 0.1202159415,
                                                     0.1202159415);

all4wfdn_128_c792 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.40055620265 => all4wfdn_128_c793,
    f_add_input_mobility_index_i > 0.40055620265                                          => -0.0435827696,
    f_add_input_mobility_index_i = NULL                                                   => 0.0603184176,
                                                                                             0.0603184176);

all4wfdn_128_c794 := map(
    trim(c_hval_300k_p) = ''                           => 0.0252777604,
    NULL < (integer)c_hval_300k_p AND (real)c_hval_300k_p <= 40.2 => 0.0005624160,
    (real)c_hval_300k_p > 40.2                           => 0.2248361193,
                                                      0.0017778584);

all4wfdn_128_c791 := map(
    NULL < f_rel_under100miles_cnt_d AND f_rel_under100miles_cnt_d <= 0.5 => all4wfdn_128_c792,
    f_rel_under100miles_cnt_d > 0.5                                       => all4wfdn_128_c794,
    f_rel_under100miles_cnt_d = NULL                                      => 0.0031235943,
                                                                             0.0031235943);

all4wfdn_128 := map(
    NULL < f_rel_homeover50_count_d AND f_rel_homeover50_count_d <= 3.5 => -0.0376747113,
    f_rel_homeover50_count_d > 3.5                                      => all4wfdn_128_c791,
    f_rel_homeover50_count_d = NULL                                     => -0.0281411608,
                                                                           -0.0008410848);

all4wfdn_129_c798 := map(
    trim(c_fammar18_p) = ''                           => -0.0076968172,
    NULL < (integer)c_fammar18_p AND (real)c_fammar18_p <= 69.85 => -0.0086731199,
    (real)c_fammar18_p > 69.85                          => 0.1709276980,
                                                     -0.0076968172);

all4wfdn_129_c797 := map(
    NULL < f_inq_other_count_i AND f_inq_other_count_i <= 2.5 => all4wfdn_129_c798,
    f_inq_other_count_i > 2.5                                 => 0.0234317314,
    f_inq_other_count_i = NULL                                => 0.0021099295,
                                                                 0.0021099295);

all4wfdn_129_c799 := map(
    NULL < f_rel_incomeover50_count_d AND f_rel_incomeover50_count_d <= 3.5 => -0.0314015445,
    f_rel_incomeover50_count_d > 3.5                                        => 0.0460712824,
    f_rel_incomeover50_count_d = NULL                                       => 0.0068222888,
                                                                               0.0068222888);

all4wfdn_129_c796 := map(
    trim(c_retired2) = ''                         => all4wfdn_129_c799,
    NULL < (integer)c_retired2 AND (real)c_retired2 <= 187.5 => all4wfdn_129_c797,
    (real)c_retired2 > 187.5                        => -0.1216571426,
                                                 0.0015132721);

all4wfdn_129 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 424.5 => all4wfdn_129_c796,
    r_c13_curr_addr_lres_d > 424.5                                    => -0.0951243805,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0011269967,
                                                                         0.0011269967);

all4wfdn_130_c802 := map(
    NULL < f_srchvelocityrisktype_i AND f_srchvelocityrisktype_i <= 3.5 => 0.1306519861,
    f_srchvelocityrisktype_i > 3.5                                      => -0.0346538168,
    f_srchvelocityrisktype_i = NULL                                     => 0.0062544269,
                                                                           0.0062544269);

all4wfdn_130_c803 := map(
    trim(c_pop_12_17_p) = ''                           => 0.0657494912,
    NULL < (integer)c_pop_12_17_p AND (real)c_pop_12_17_p <= 6.65 => 0.1891822987,
    (real)c_pop_12_17_p > 6.65                           => -0.0388146069,
                                                      0.0657494912);

all4wfdn_130_c801 := map(
    NULL < r_pb_order_freq_d AND r_pb_order_freq_d <= 199.5 => all4wfdn_130_c802,
    r_pb_order_freq_d > 199.5                               => 0.1770828442,
    r_pb_order_freq_d = NULL                                => all4wfdn_130_c803,
                                                               0.0457107527);

all4wfdn_130_c804 := map(
    NULL < f_rel_under25miles_cnt_d AND f_rel_under25miles_cnt_d <= 6.5 => 0.0254892080,
    f_rel_under25miles_cnt_d > 6.5                                      => -0.0792515245,
    f_rel_under25miles_cnt_d = NULL                                     => -0.0254213571,
                                                                           -0.0254213571);

all4wfdn_130 := map(
    trim(c_work_home) = ''                          => all4wfdn_130_c804,
    NULL < (integer)c_work_home AND (real)c_work_home <= 188.5 => -0.0038039097,
    (real)c_work_home > 188.5                         => all4wfdn_130_c801,
                                                   -0.0024801194);

all4wfdn_131_c809 := map(
    NULL < k_inq_adls_per_phone_i AND k_inq_adls_per_phone_i <= 2.5 => -0.0000559173,
    k_inq_adls_per_phone_i > 2.5                                    => 0.0772586553,
    k_inq_adls_per_phone_i = NULL                                   => 0.0006615569,
                                                                       0.0006615569);

all4wfdn_131_c808 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 78.5 => all4wfdn_131_c809,
    k_comb_age_d > 78.5                          => -0.0936916032,
    k_comb_age_d = NULL                          => 0.0001975588,
                                                    0.0001975588);

all4wfdn_131_c807 := map(
    trim(c_hh2_p) = ''                      => 0.0205660196,
    NULL < (integer)c_hh2_p AND (real)c_hh2_p <= 60.75 => all4wfdn_131_c808,
    (real)c_hh2_p > 60.75                     => 0.1486545437,
                                           0.0010664772);

all4wfdn_131_c806 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.21325587935 => all4wfdn_131_c807,
    f_add_curr_nhood_bus_pct_i > 0.21325587935                                        => -0.0475078436,
    f_add_curr_nhood_bus_pct_i = NULL                                                 => -0.0347519943,
                                                                                         -0.0030072816);

all4wfdn_131 := map(
    NULL < f_mos_foreclosure_lseen_d AND f_mos_foreclosure_lseen_d <= 24.5 => -0.1235952201,
    f_mos_foreclosure_lseen_d > 24.5                                       => all4wfdn_131_c806,
    f_mos_foreclosure_lseen_d = NULL                                       => -0.0041476990,
                                                                              -0.0041476990);

all4wfdn_132_c814 := map(
    trim(c_finance) = ''                        => 0.0499784366,
    NULL < (integer)c_finance AND (real)c_finance <= 11.15 => 0.0338988111,
    (real)c_finance > 11.15                       => 0.2257479206,
                                               0.0499784366);

all4wfdn_132_c813 := map(
    NULL < f_varrisktype_i AND f_varrisktype_i <= 5.5 => -0.0035836778,
    f_varrisktype_i > 5.5                             => all4wfdn_132_c814,
    f_varrisktype_i = NULL                            => -0.0011697911,
                                                         -0.0011697911);

all4wfdn_132_c812 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 829392.5 => all4wfdn_132_c813,
    f_prevaddrmedianvalue_d > 829392.5                                     => 0.1951930794,
    f_prevaddrmedianvalue_d = NULL                                         => -0.0002748495,
                                                                              -0.0002748495);

all4wfdn_132_c811 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 386.5 => all4wfdn_132_c812,
    f_prevaddrageoldest_d > 386.5                                   => -0.1115904305,
    f_prevaddrageoldest_d = NULL                                    => -0.0010157374,
                                                                       -0.0010157374);

all4wfdn_132 := map(
    NULL < f_add_curr_nhood_bus_pct_i AND f_add_curr_nhood_bus_pct_i <= 0.0012019248 => 0.1164339902,
    f_add_curr_nhood_bus_pct_i > 0.0012019248                                        => all4wfdn_132_c811,
    f_add_curr_nhood_bus_pct_i = NULL                                                => -0.0554717016,
                                                                                        -0.0021600776);

all4wfdn_133_c817 := map(
    trim(c_pop_45_54_p) = ''                            => -0.0248401251,
    NULL < (integer)c_pop_45_54_p AND (real)c_pop_45_54_p <= 22.35 => -0.0347549429,
    (real)c_pop_45_54_p > 22.35                           => 0.2634712559,
                                                       -0.0248401251);

all4wfdn_133_c818 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 0.5 => -0.1394839871,
    f_inq_highriskcredit_count_i > 0.5                                          => -0.0879217832,
    f_inq_highriskcredit_count_i = NULL                                         => -0.1039216128,
                                                                                   -0.1039216128);

all4wfdn_133_c816 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 75.05 => all4wfdn_133_c817,
    r_c12_source_profile_d > 75.05                                    => all4wfdn_133_c818,
    r_c12_source_profile_d = NULL                                     => -0.0326501579,
                                                                         -0.0326501579);

all4wfdn_133_c819 := map(
    trim(c_larceny) = ''                        => -0.0253687214,
    NULL < (integer)c_larceny AND (real)c_larceny <= 154.5 => -0.0048377382,
    (real)c_larceny > 154.5                       => 0.0286827281,
                                               0.0041485255);

all4wfdn_133 := map(
    NULL < f_mos_inq_banko_om_fseen_d AND f_mos_inq_banko_om_fseen_d <= 28.5 => all4wfdn_133_c816,
    f_mos_inq_banko_om_fseen_d > 28.5                                        => all4wfdn_133_c819,
    f_mos_inq_banko_om_fseen_d = NULL                                        => -0.0006491547,
                                                                                -0.0006491547);

all4wfdn_134_c823 := map(
    trim(c_unempl) = ''                      => 0.0230637519,
    NULL < (integer)c_unempl AND (real)c_unempl <= 29.5 => 0.1778689489,
    (real)c_unempl > 29.5                      => 0.0154136318,
                                            0.0230637519);

all4wfdn_134_c824 := map(
    trim(c_work_home) = ''                         => 0.1134234561,
    NULL < (integer)c_work_home AND (real)c_work_home <= 75.5 => 0.0268269962,
    (real)c_work_home > 75.5                         => 0.2032489365,
                                                  0.1134234561);

all4wfdn_134_c822 := map(
    NULL < f_bus_addr_match_count_d AND f_bus_addr_match_count_d <= 5.5 => all4wfdn_134_c823,
    f_bus_addr_match_count_d > 5.5                                      => all4wfdn_134_c824,
    f_bus_addr_match_count_d = NULL                                     => 0.0280168879,
                                                                           0.0280168879);

all4wfdn_134_c821 := map(
    trim(c_hval_100k_p) = ''                            => 0.0006006253,
    NULL < (integer)c_hval_100k_p AND (real)c_hval_100k_p <= 18.85 => -0.0054074877,
    (real)c_hval_100k_p > 18.85                           => all4wfdn_134_c822,
                                                       0.0006006253);

all4wfdn_134 := map(
    trim(c_pop_55_64_p) = ''                           => -0.0398676852,
    NULL < (integer)c_pop_55_64_p AND (real)c_pop_55_64_p <= 1.25 => 0.1561985608,
    (real)c_pop_55_64_p > 1.25                           => all4wfdn_134_c821,
                                                      0.0013864689);

all4wfdn_135_c826 := map(
    NULL < f_rel_ageover50_count_d AND f_rel_ageover50_count_d <= 0.5 => 0.0181562927,
    f_rel_ageover50_count_d > 0.5                                     => 0.1749713022,
    f_rel_ageover50_count_d = NULL                                    => 0.0520463573,
                                                                         0.0520463573);

all4wfdn_135_c829 := map(
    NULL < f_curraddrmurderindex_i AND f_curraddrmurderindex_i <= 114 => 0.1541527190,
    f_curraddrmurderindex_i > 114                                     => -0.0383429717,
    f_curraddrmurderindex_i = NULL                                    => 0.0610348849,
                                                                         0.0610348849);

all4wfdn_135_c828 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => all4wfdn_135_c829,
    f_phone_ver_experian_d > 0.5                                    => 0.0030898281,
    f_phone_ver_experian_d = NULL                                   => 0.0335807029,
                                                                       0.0335807029);

all4wfdn_135_c827 := map(
    trim(c_rnt750_p) = ''                         => 0.0224957218,
    NULL < (integer)c_rnt750_p AND (real)c_rnt750_p <= 63.25 => -0.0105897275,
    (real)c_rnt750_p > 63.25                        => all4wfdn_135_c828,
                                                 -0.0058472966);

all4wfdn_135 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= -14275 => all4wfdn_135_c826,
    f_addrchangeincomediff_d > -14275                                      => 0.0020982341,
    f_addrchangeincomediff_d = NULL                                        => all4wfdn_135_c827,
                                                                              0.0017573180);

all4wfdn_136_c832 := map(
    trim(c_burglary) = ''                         => 0.0021408190,
    NULL < (integer)c_burglary AND (real)c_burglary <= 195.5 => 0.0000302912,
    (real)c_burglary > 195.5                        => 0.0999617915,
                                                 0.0021408190);

all4wfdn_136_c833 := map(
    NULL < f_rel_educationover12_count_d AND f_rel_educationover12_count_d <= 8.5 => 0.0352204512,
    f_rel_educationover12_count_d > 8.5                                           => -0.0378543299,
    f_rel_educationover12_count_d = NULL                                          => 0.0011365696,
                                                                                     0.0011365696);

all4wfdn_136_c831 := map(
    trim(c_pop_35_44_p) = ''                           => all4wfdn_136_c833,
    NULL < (integer)c_pop_35_44_p AND (real)c_pop_35_44_p <= 1.55 => -0.1881603748,
    (real)c_pop_35_44_p > 1.55                           => all4wfdn_136_c832,
                                                      0.0012994140);

all4wfdn_136_c834 := map(
    trim(c_bigapt_p) = ''                        => 0.0783654886,
    NULL < (integer)c_bigapt_p AND (real)c_bigapt_p <= 1.15 => 0.0043568853,
    (real)c_bigapt_p > 1.15                        => 0.2064879093,
                                                0.0783654886);

all4wfdn_136 := map(
    NULL < f_corraddrnamecount_d AND f_corraddrnamecount_d <= 15.5 => all4wfdn_136_c831,
    f_corraddrnamecount_d > 15.5                                   => all4wfdn_136_c834,
    f_corraddrnamecount_d = NULL                                   => 0.0022519244,
                                                                      0.0022519244);

all4wfdn_137_c836 := map(
    NULL < f_hh_members_ct_d AND f_hh_members_ct_d <= 6.5 => -0.0380267104,
    f_hh_members_ct_d > 6.5                               => 0.0592833341,
    f_hh_members_ct_d = NULL                              => -0.0294189706,
                                                             -0.0294189706);

all4wfdn_137_c839 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.0452821485 => 0.0070219913,
    f_add_input_nhood_bus_pct_i > 0.0452821485                                         => 0.1814083640,
    f_add_input_nhood_bus_pct_i = NULL                                                 => 0.0836896216,
                                                                                          0.0836896216);

all4wfdn_137_c838 := map(
    trim(c_hval_125k_p) = ''                          => 0.0409136104,
    NULL < (integer)c_hval_125k_p AND (real)c_hval_125k_p <= 1.4 => -0.0363774364,
    (real)c_hval_125k_p > 1.4                           => all4wfdn_137_c839,
                                                     0.0409136104);

all4wfdn_137_c837 := map(
    NULL < f_validationrisktype_i AND f_validationrisktype_i <= 1.5 => 0.0028656099,
    f_validationrisktype_i > 1.5                                    => all4wfdn_137_c838,
    f_validationrisktype_i = NULL                                   => 0.0037173773,
                                                                       0.0037173773);

all4wfdn_137 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 1.5 => all4wfdn_137_c836,
    f_phones_per_addr_curr_i > 1.5                                      => all4wfdn_137_c837,
    f_phones_per_addr_curr_i = NULL                                     => -0.0037589508,
                                                                           -0.0037589508);

all4wfdn_138_c844 := map(
    NULL < f_phone_ver_experian_d AND f_phone_ver_experian_d <= 0.5 => 0.0910700144,
    f_phone_ver_experian_d > 0.5                                    => 0.0083024911,
    f_phone_ver_experian_d = NULL                                   => 0.0100389095,
                                                                       0.0453014756);

all4wfdn_138_c843 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.4246951809 => all4wfdn_138_c844,
    f_add_curr_mobility_index_i > 0.4246951809                                         => -0.0569030568,
    f_add_curr_mobility_index_i = NULL                                                 => 0.0302446443,
                                                                                          0.0302446443);

all4wfdn_138_c842 := map(
    NULL < f_srchssnsrchcount_i AND f_srchssnsrchcount_i <= 1.5 => all4wfdn_138_c843,
    f_srchssnsrchcount_i > 1.5                                  => -0.0072916823,
    f_srchssnsrchcount_i = NULL                                 => 0.0015826994,
                                                                   0.0015826994);

all4wfdn_138_c841 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => all4wfdn_138_c842,
    r_d30_derog_count_i > 0.5                                 => -0.0141772827,
    r_d30_derog_count_i = NULL                                => -0.0083897172,
                                                                 -0.0083897172);

all4wfdn_138 := map(
    trim(c_hval_80k_p) = ''                          => -0.0217168858,
    NULL < (integer)c_hval_80k_p AND (real)c_hval_80k_p <= 61.5 => all4wfdn_138_c841,
    (real)c_hval_80k_p > 61.5                          => 0.1625867897,
                                                    -0.0077628992);

all4wfdn_139_c848 := map(
    NULL < k_estimated_income_d AND k_estimated_income_d <= 124500 => 0.0059141716,
    k_estimated_income_d > 124500                                  => 0.1547648916,
    k_estimated_income_d = NULL                                    => 0.0080506336,
                                                                      0.0080506336);

all4wfdn_139_c847 := map(
    NULL < r_c13_curr_addr_lres_d AND r_c13_curr_addr_lres_d <= 369.5 => all4wfdn_139_c848,
    r_c13_curr_addr_lres_d > 369.5                                    => 0.1063534901,
    r_c13_curr_addr_lres_d = NULL                                     => 0.0093766576,
                                                                         0.0093766576);

all4wfdn_139_c849 := map(
    trim(c_retail) = ''                      => 0.0886563620,
    NULL < (integer)c_retail AND (real)c_retail <= 6.05 => 0.1946115732,
    (real)c_retail > 6.05                      => 0.0001248966,
                                            0.0886563620);

all4wfdn_139_c846 := map(
    NULL < r_c23_inp_addr_owned_not_occ_d AND r_c23_inp_addr_owned_not_occ_d <= 0.5 => all4wfdn_139_c847,
    r_c23_inp_addr_owned_not_occ_d > 0.5                                            => all4wfdn_139_c849,
    r_c23_inp_addr_owned_not_occ_d = NULL                                           => 0.0120281957,
                                                                                       0.0120281957);

all4wfdn_139 := map(
    NULL < f_mos_inq_banko_cm_fseen_d AND f_mos_inq_banko_cm_fseen_d <= 85.5 => -0.0116266693,
    f_mos_inq_banko_cm_fseen_d > 85.5                                        => all4wfdn_139_c846,
    f_mos_inq_banko_cm_fseen_d = NULL                                        => -0.0021719970,
                                                                                -0.0021719970);

all4wfdn_140_c852 := map(
    trim(c_hh4_p) = ''                      => 0.0422089522,
    NULL < (integer)c_hh4_p AND (real)c_hh4_p <= 27.35 => 0.2085774445,
    (real)c_hh4_p > 27.35                     => 0.0254680635,
                                           0.0422089522);

all4wfdn_140_c851 := map(
    trim(c_hh4_p) = ''                      => 0.0111220133,
    NULL < (integer)c_hh4_p AND (real)c_hh4_p <= 26.85 => -0.0029527902,
    (real)c_hh4_p > 26.85                     => all4wfdn_140_c852,
                                           0.0000572118);

all4wfdn_140_c854 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 4.5 => 0.2003556992,
    f_inq_highriskcredit_count_i > 4.5                                          => -0.0589373228,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0726809983,
                                                                                   0.0726809983);

all4wfdn_140_c853 := map(
    trim(c_hval_200k_p) = ''                           => 0.0177977101,
    NULL < (integer)c_hval_200k_p AND (real)c_hval_200k_p <= 3.55 => all4wfdn_140_c854,
    (real)c_hval_200k_p > 3.55                           => -0.0292962697,
                                                      0.0177977101);

all4wfdn_140 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 13.5 => all4wfdn_140_c851,
    f_historical_count_d > 13.5                                  => all4wfdn_140_c853,
    f_historical_count_d = NULL                                  => 0.0003917430,
                                                                    0.0003917430);

all4wfdn_141_c859 := map(
    NULL < r_a44_curr_add_naprop_d AND r_a44_curr_add_naprop_d <= 1.5 => 0.0420719756,
    r_a44_curr_add_naprop_d > 1.5                                     => 0.1300354027,
    r_a44_curr_add_naprop_d = NULL                                    => 0.0758633423,
                                                                         0.0758633423);

all4wfdn_141_c858 := map(
    NULL < f_add_curr_mobility_index_i AND f_add_curr_mobility_index_i <= 0.22556115935 => 0.0076136159,
    f_add_curr_mobility_index_i > 0.22556115935                                         => all4wfdn_141_c859,
    f_add_curr_mobility_index_i = NULL                                                  => 0.0591530798,
                                                                                           0.0591530798);

all4wfdn_141_c857 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 2.5 => all4wfdn_141_c858,
    f_inq_collection_count_i > 2.5                                      => -0.0169576451,
    f_inq_collection_count_i = NULL                                     => 0.0187470410,
                                                                           0.0187470410);

all4wfdn_141_c856 := map(
    trim(c_rich_wht) = ''                         => 0.0294537548,
    NULL < (integer)c_rich_wht AND (real)c_rich_wht <= 157.5 => -0.0051286697,
    (real)c_rich_wht > 157.5                        => all4wfdn_141_c857,
                                                 -0.0004635642);

all4wfdn_141 := map(
    NULL < f_inq_count_i AND f_inq_count_i <= 42.5 => all4wfdn_141_c856,
    f_inq_count_i > 42.5                           => 0.1517052896,
    f_inq_count_i = NULL                           => 0.0001470613,
                                                      0.0001470613);

all4wfdn_142_c863 := map(
    trim(c_pop_75_84_p) = ''                           => 0.0225454617,
    NULL < (integer)c_pop_75_84_p AND (real)c_pop_75_84_p <= 7.85 => 0.0127468848,
    (real)c_pop_75_84_p > 7.85                           => 0.1186758798,
                                                      0.0225454617);

all4wfdn_142_c862 := map(
    NULL < f_inq_other_count24_i AND f_inq_other_count24_i <= 1.5 => -0.0076336324,
    f_inq_other_count24_i > 1.5                                   => all4wfdn_142_c863,
    f_inq_other_count24_i = NULL                                  => 0.0015165560,
                                                                     0.0015165560);

all4wfdn_142_c861 := map(
    trim(c_rnt2001_p) = ''                         => 0.0002354349,
    NULL < (integer)c_rnt2001_p AND (real)c_rnt2001_p <= 47.1 => all4wfdn_142_c862,
    (real)c_rnt2001_p > 47.1                         => -0.1292329012,
                                                  0.0002354349);

all4wfdn_142_c864 := map(
    NULL < f_rel_ageover40_count_d AND f_rel_ageover40_count_d <= 2.5 => 0.0065163310,
    f_rel_ageover40_count_d > 2.5                                     => -0.0595623610,
    f_rel_ageover40_count_d = NULL                                    => -0.0257860780,
                                                                         -0.0257860780);

all4wfdn_142 := map(
    trim(c_retired2) = ''                         => all4wfdn_142_c864,
    NULL < (integer)c_retired2 AND (real)c_retired2 <= 186.5 => all4wfdn_142_c861,
    (real)c_retired2 > 186.5                        => -0.1222889595,
                                                 -0.0008572643);

all4wfdn_143_c868 := map(
    NULL < f_add_input_mobility_index_i AND f_add_input_mobility_index_i <= 0.211790498 => 0.1492991728,
    f_add_input_mobility_index_i > 0.211790498                                          => 0.0306674565,
    f_add_input_mobility_index_i = NULL                                                 => 0.0487604501,
                                                                                           0.0487604501);

all4wfdn_143_c867 := map(
    trim(r_d31_bk_chapter_n) = ''                              => all4wfdn_143_c868,
    NULL < (integer)r_d31_bk_chapter_n AND (integer)r_d31_bk_chapter_n <= 10 => -0.0754109721,
    (integer)r_d31_bk_chapter_n > 10                                => -0.0105457063,
                                                              0.0084349250);

all4wfdn_143_c869 := map(
    trim(c_hhsize) = ''                       => 0.0222338569,
    NULL < (integer)c_hhsize AND (real)c_hhsize <= 2.515 => 0.1147659099,
    (real)c_hhsize > 2.515                      => -0.0342283767,
                                             0.0222338569);

all4wfdn_143_c866 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 28.5 => all4wfdn_143_c867,
    r_p88_phn_dst_to_inp_add_i > 28.5                                        => 0.1551655157,
    r_p88_phn_dst_to_inp_add_i = NULL                                        => all4wfdn_143_c869,
                                                                                0.0212172916);

all4wfdn_143 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 61.5 => -0.0031404999,
    k_comb_age_d > 61.5                          => all4wfdn_143_c866,
    k_comb_age_d = NULL                          => -0.0013394538,
                                                    -0.0013394538);

all4wfdn_144_c872 := map(
    trim(C_RENTOCC_P) = ''                          => 0.0508348760,
    NULL < (integer)C_RENTOCC_P AND (real)C_RENTOCC_P <= 15.15 => 0.1804451254,
    (real)C_RENTOCC_P > 15.15                         => 0.0172477039,
                                                   0.0508348760);

all4wfdn_144_c871 := map(
    NULL < r_p88_phn_dst_to_inp_add_i AND r_p88_phn_dst_to_inp_add_i <= 327.5 => -0.0022806629,
    r_p88_phn_dst_to_inp_add_i > 327.5                                        => all4wfdn_144_c872,
    r_p88_phn_dst_to_inp_add_i = NULL                                         => -0.0021927771,
                                                                                 -0.0011541184);

all4wfdn_144_c874 := map(
    NULL < r_c12_source_profile_d AND r_c12_source_profile_d <= 64.3 => -0.0513328418,
    r_c12_source_profile_d > 64.3                                    => -0.1261735090,
    r_c12_source_profile_d = NULL                                    => -0.0747484641,
                                                                        -0.0747484641);

all4wfdn_144_c873 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 0.5 => all4wfdn_144_c874,
    f_inq_highriskcredit_count_i > 0.5                                          => -0.0321680447,
    f_inq_highriskcredit_count_i = NULL                                         => -0.0440942223,
                                                                                   -0.0440942223);

all4wfdn_144 := map(
    NULL < f_hh_age_18_plus_d AND f_hh_age_18_plus_d <= 6.5 => all4wfdn_144_c871,
    f_hh_age_18_plus_d > 6.5                                => all4wfdn_144_c873,
    f_hh_age_18_plus_d = NULL                               => -0.0040622519,
                                                               -0.0040622519);

all4wfdn_145_c879 := map(
    NULL < r_d30_derog_count_i AND r_d30_derog_count_i <= 0.5 => 0.1168482773,
    r_d30_derog_count_i > 0.5                                 => 0.0268246543,
    r_d30_derog_count_i = NULL                                => 0.0694817442,
                                                                 0.0694817442);

all4wfdn_145_c878 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 26.5 => -0.0134504039,
    k_comb_age_d > 26.5                          => all4wfdn_145_c879,
    k_comb_age_d = NULL                          => 0.0449852398,
                                                    0.0449852398);

all4wfdn_145_c877 := map(
    NULL < f_srchssnsrchcount_i AND f_srchssnsrchcount_i <= 2.5 => all4wfdn_145_c878,
    f_srchssnsrchcount_i > 2.5                                  => 0.0145080499,
    f_srchssnsrchcount_i = NULL                                 => 0.0260157059,
                                                                   0.0260157059);

all4wfdn_145_c876 := map(
    NULL < f_inq_collection_count_i AND f_inq_collection_count_i <= 2.5 => all4wfdn_145_c877,
    f_inq_collection_count_i > 2.5                                      => -0.0013255799,
    f_inq_collection_count_i = NULL                                     => 0.0113515045,
                                                                           0.0113515045);

all4wfdn_145 := map(
    trim(c_pop_18_24_p) = ''                           => -0.0334795001,
    NULL < (integer)c_pop_18_24_p AND (real)c_pop_18_24_p <= 9.75 => all4wfdn_145_c876,
    (real)c_pop_18_24_p > 9.75                           => -0.0102349903,
                                                      0.0017207699);

all4wfdn_146_c883 := map(
    trim(c_hval_400k_p) = ''                           => 0.1053507282,
    NULL < (integer)c_hval_400k_p AND (real)c_hval_400k_p <= 1.35 => 0.2558883341,
    (real)c_hval_400k_p > 1.35                           => 0.0066933141,
                                                      0.1053507282);

all4wfdn_146_c882 := map(
    trim(c_rural_p) = ''                      => 0.0195345716,
    NULL < (integer)c_rural_p AND (real)c_rural_p <= 0.5 => -0.0263070582,
    (real)c_rural_p > 0.5                       => all4wfdn_146_c883,
                                             0.0195345716);

all4wfdn_146_c881 := map(
    NULL < f_inq_retail_count_i AND f_inq_retail_count_i <= 0.5 => all4wfdn_146_c882,
    f_inq_retail_count_i > 0.5                                  => 0.2086169891,
    f_inq_retail_count_i = NULL                                 => 0.0439260083,
                                                                   0.0439260083);

all4wfdn_146_c884 := map(
    trim(c_mort_indx) = ''                          => 0.0445884174,
    NULL < (integer)c_mort_indx AND (real)c_mort_indx <= 146.5 => -0.0047832307,
    (real)c_mort_indx > 146.5                         => 0.0370739383,
                                                   -0.0007092977);

all4wfdn_146 := map(
    NULL < r_i60_inq_prepaidcards_recency_d AND r_i60_inq_prepaidcards_recency_d <= 61.5 => all4wfdn_146_c881,
    r_i60_inq_prepaidcards_recency_d > 61.5                                              => all4wfdn_146_c884,
    r_i60_inq_prepaidcards_recency_d = NULL                                              => 0.0006909746,
                                                                                            0.0006909746);

all4wfdn_147_c886 := map(
    trim(c_pop_55_64_p) = ''                           => -0.0284271102,
    NULL < (integer)c_pop_55_64_p AND (real)c_pop_55_64_p <= 8.45 => -0.0249939661,
    (real)c_pop_55_64_p > 8.45                           => 0.0061293631,
                                                      -0.0074959733);

all4wfdn_147_c889 := map(
    NULL < f_inq_highriskcredit_count_i AND f_inq_highriskcredit_count_i <= 1.5 => 0.1444478370,
    f_inq_highriskcredit_count_i > 1.5                                          => 0.0200813802,
    f_inq_highriskcredit_count_i = NULL                                         => 0.0616640298,
                                                                                   0.0616640298);

all4wfdn_147_c888 := map(
    trim(c_born_usa) = ''                        => 0.0149768665,
    NULL < (integer)c_born_usa AND (real)c_born_usa <= 76.5 => all4wfdn_147_c889,
    (real)c_born_usa > 76.5                        => 0.0001389281,
                                                0.0149768665);

all4wfdn_147_c887 := map(
    trim(c_pop_55_64_p) = ''                           => 0.0302573445,
    NULL < (integer)c_pop_55_64_p AND (real)c_pop_55_64_p <= 4.75 => 0.2317733079,
    (real)c_pop_55_64_p > 4.75                           => all4wfdn_147_c888,
                                                      0.0302573445);

all4wfdn_147 := map(
    NULL < f_historical_count_d AND f_historical_count_d <= 7.5 => all4wfdn_147_c886,
    f_historical_count_d > 7.5                                  => all4wfdn_147_c887,
    f_historical_count_d = NULL                                 => -0.0038944352,
                                                                   -0.0038944352);

all4wfdn_148_c893 := map(
    NULL < f_srchfraudsrchcount_i AND f_srchfraudsrchcount_i <= 3.5 => 0.1524680056,
    f_srchfraudsrchcount_i > 3.5                                    => 0.0203484791,
    f_srchfraudsrchcount_i = NULL                                   => 0.0898150981,
                                                                       0.0898150981);

all4wfdn_148_c894 := map(
    trim(c_rich_nfam) = ''                          => -0.0155503576,
    NULL < (integer)c_rich_nfam AND (real)c_rich_nfam <= 161.5 => -0.0423792146,
    (real)c_rich_nfam > 161.5                         => 0.1262735629,
                                                   -0.0155503576);

all4wfdn_148_c892 := map(
    NULL < f_fp_prevaddrburglaryindex_i AND f_fp_prevaddrburglaryindex_i <= 88.5 => all4wfdn_148_c893,
    f_fp_prevaddrburglaryindex_i > 88.5                                          => all4wfdn_148_c894,
    f_fp_prevaddrburglaryindex_i = NULL                                          => 0.0181445488,
                                                                                    0.0181445488);

all4wfdn_148_c891 := map(
    trim(c_retired) = ''                        => -0.0207940836,
    NULL < (integer)c_retired AND (real)c_retired <= 18.55 => -0.0264328929,
    (real)c_retired > 18.55                       => all4wfdn_148_c892,
                                               -0.0207940836);

all4wfdn_148 := map(
    NULL < r_c20_email_domain_free_count_i AND r_c20_email_domain_free_count_i <= 0.5 => all4wfdn_148_c891,
    r_c20_email_domain_free_count_i > 0.5                                             => 0.0103992570,
    r_c20_email_domain_free_count_i = NULL                                            => 0.0003810057,
                                                                                         0.0003810057);

all4wfdn_149_c897 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.20296498425 => -0.0187446399,
    f_add_input_nhood_bus_pct_i > 0.20296498425                                         => 0.0867883922,
    f_add_input_nhood_bus_pct_i = NULL                                                  => -0.0325096280,
                                                                                           -0.0125900223);

all4wfdn_149_c898 := map(
    trim(c_hh2_p) = ''                     => 0.0850387616,
    NULL < (integer)c_hh2_p AND (real)c_hh2_p <= 27.7 => -0.0490775106,
    (real)c_hh2_p > 27.7                     => 0.1994523855,
                                          0.0850387616);

all4wfdn_149_c899 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 0.5 => -0.0999327963,
    f_rel_homeover200_count_d > 0.5                                       => 0.0735318201,
    f_rel_homeover200_count_d = NULL                                      => -0.0133556443,
                                                                             -0.0133556443);

all4wfdn_149_c896 := map(
    trim(c_hval_125k_p) = ''                            => all4wfdn_149_c899,
    NULL < (integer)c_hval_125k_p AND (real)c_hval_125k_p <= 32.85 => all4wfdn_149_c897,
    (real)c_hval_125k_p > 32.85                           => all4wfdn_149_c898,
                                                       -0.0071603716);

all4wfdn_149 := map(
    NULL < f_addrchangevaluediff_d AND f_addrchangevaluediff_d <= -131966 => -0.0751289376,
    f_addrchangevaluediff_d > -131966                                     => 0.0037143240,
    f_addrchangevaluediff_d = NULL                                        => all4wfdn_149_c896,
                                                                             0.0007913528);

all4wfdn_150_c903 := map(
    trim(c_hval_250k_p) = ''                            => 0.0699460041,
    NULL < (integer)c_hval_250k_p AND (real)c_hval_250k_p <= 21.65 => 0.0475366724,
    (real)c_hval_250k_p > 21.65                           => 0.2303071819,
                                                       0.0699460041);

all4wfdn_150_c902 := map(
    trim(c_construction) = ''                             => 0.0135710078,
    NULL < (integer)c_construction AND (real)c_construction <= 22.05 => 0.0049625590,
    (real)c_construction > 22.05                            => all4wfdn_150_c903,
                                                         0.0135710078);

all4wfdn_150_c904 := map(
    trim(c_lar_fam) = ''                       => 0.0930205185,
    NULL < (integer)c_lar_fam AND (real)c_lar_fam <= 93.5 => 0.2340913511,
    (real)c_lar_fam > 93.5                       => 0.0334530757,
                                              0.0930205185);

all4wfdn_150_c901 := map(
    trim(c_hh4_p) = ''                      => 0.0186944462,
    NULL < (integer)c_hh4_p AND (real)c_hh4_p <= 26.85 => all4wfdn_150_c902,
    (real)c_hh4_p > 26.85                     => all4wfdn_150_c904,
                                           0.0186944462);

all4wfdn_150 := map(
    NULL < (integer)k_inf_contradictory_i AND (real)k_inf_contradictory_i <= 0.5 => -0.0022436404,
    (real)k_inf_contradictory_i > 0.5                                   => all4wfdn_150_c901,
    (integer)k_inf_contradictory_i = NULL                                  => 0.0033672061,
                                                                     0.0033672061);

all4wfdn_151_c908 := map(
    NULL < f_add_input_nhood_bus_pct_i AND f_add_input_nhood_bus_pct_i <= 0.01305088355 => 0.2254598079,
    f_add_input_nhood_bus_pct_i > 0.01305088355                                         => 0.0314329557,
    f_add_input_nhood_bus_pct_i = NULL                                                  => 0.0691397809,
                                                                                           0.0691397809);

all4wfdn_151_c907 := map(
    NULL < f_liens_unrel_cj_total_amt_i AND f_liens_unrel_cj_total_amt_i <= 1911.5 => all4wfdn_151_c908,
    f_liens_unrel_cj_total_amt_i > 1911.5                                          => 0.3697096298,
    f_liens_unrel_cj_total_amt_i = NULL                                            => 0.1107461084,
                                                                                      0.1107461084);

all4wfdn_151_c909 := map(
    NULL < f_add_curr_nhood_mfd_pct_i AND f_add_curr_nhood_mfd_pct_i <= 0.00195313245 => -0.1149346094,
    f_add_curr_nhood_mfd_pct_i > 0.00195313245                                        => 0.0206245599,
    f_add_curr_nhood_mfd_pct_i = NULL                                                 => 0.0147207637,
                                                                                         0.0161205071);

all4wfdn_151_c906 := map(
    trim(c_pop00) = ''                    => 0.0228731473,
    NULL < (integer)c_pop00 AND (integer)c_pop00 <= 908 => all4wfdn_151_c907,
    (integer)c_pop00 > 908                     => all4wfdn_151_c909,
                                         0.0228731473);

all4wfdn_151 := map(
    trim(c_cartheft) = ''                      => 0.0039038250,
    NULL < (integer)c_cartheft AND (integer)c_cartheft <= 82 => all4wfdn_151_c906,
    (integer)c_cartheft > 82                        => -0.0087939943,
                                              0.0033728897);

all4wfdn_152_c911 := map(
    trim(c_vacant_p) = ''                        => 0.0224131216,
    NULL < (integer)c_vacant_p AND (real)c_vacant_p <= 1.55 => -0.1010221735,
    (real)c_vacant_p > 1.55                        => -0.0035395885,
                                                -0.0042076045);

all4wfdn_152_c913 := map(
    NULL < f_prevaddrageoldest_d AND f_prevaddrageoldest_d <= 27 => -0.0432893077,
    f_prevaddrageoldest_d > 27                                   => 0.3232391387,
    f_prevaddrageoldest_d = NULL                                 => 0.1551416099,
                                                                    0.1551416099);

all4wfdn_152_c914 := map(
    NULL < f_addrchangeincomediff_d AND f_addrchangeincomediff_d <= 8510.5 => 0.0049547222,
    f_addrchangeincomediff_d > 8510.5                                      => 0.1300548990,
    f_addrchangeincomediff_d = NULL                                        => 0.0300861436,
                                                                              0.0161523531);

all4wfdn_152_c912 := map(
    trim(c_families) = ''                         => 0.0303449181,
    NULL < (integer)c_families AND (real)c_families <= 211.5 => all4wfdn_152_c913,
    (real)c_families > 211.5                        => all4wfdn_152_c914,
                                                 0.0303449181);

all4wfdn_152 := map(
    NULL < f_prevaddroccupantowned_i AND f_prevaddroccupantowned_i <= 0.5 => all4wfdn_152_c911,
    f_prevaddroccupantowned_i > 0.5                                       => all4wfdn_152_c912,
    f_prevaddroccupantowned_i = NULL                                      => -0.0010058652,
                                                                             -0.0010058652);

all4wfdn_153_c917 := map(
    NULL < f_phones_per_addr_curr_i AND f_phones_per_addr_curr_i <= 51.5 => 0.0032780241,
    f_phones_per_addr_curr_i > 51.5                                      => 0.0937999558,
    f_phones_per_addr_curr_i = NULL                                      => 0.0038633797,
                                                                            0.0038633797);

all4wfdn_153_c918 := map(
    NULL < f_srchaddrsrchcount_i AND f_srchaddrsrchcount_i <= 27.5 => 0.2353990611,
    f_srchaddrsrchcount_i > 27.5                                   => 0.0189678288,
    f_srchaddrsrchcount_i = NULL                                   => 0.0990270307,
                                                                      0.0990270307);

all4wfdn_153_c916 := map(
    NULL < k_inq_ssns_per_addr_i AND k_inq_ssns_per_addr_i <= 5.5 => all4wfdn_153_c917,
    k_inq_ssns_per_addr_i > 5.5                                   => all4wfdn_153_c918,
    k_inq_ssns_per_addr_i = NULL                                  => 0.0048632876,
                                                                     0.0048632876);

all4wfdn_153_c919 := map(
    NULL < f_add_input_nhood_mfd_pct_i AND f_add_input_nhood_mfd_pct_i <= 0.0580819014 => -0.1698791716,
    f_add_input_nhood_mfd_pct_i > 0.0580819014                                         => -0.0404982581,
    f_add_input_nhood_mfd_pct_i = NULL                                                 => -0.0817545400,
                                                                                          -0.0817545400);

all4wfdn_153 := map(
    NULL < k_comb_age_d AND k_comb_age_d <= 71.5 => all4wfdn_153_c916,
    k_comb_age_d > 71.5                          => all4wfdn_153_c919,
    k_comb_age_d = NULL                          => 0.0034504533,
                                                    0.0034504533);

all4wfdn_154_c922 := map(
    trim(c_hval_100k_p) = ''                            => 0.0037990084,
    NULL < (integer)c_hval_100k_p AND (real)c_hval_100k_p <= 16.15 => -0.0033311562,
    (real)c_hval_100k_p > 16.15                           => 0.0284982283,
                                                       0.0037990084);

all4wfdn_154_c923 := map(
    NULL < f_rel_homeover200_count_d AND f_rel_homeover200_count_d <= 0.5 => -0.1042386006,
    f_rel_homeover200_count_d > 0.5                                       => -0.0025860077,
    f_rel_homeover200_count_d = NULL                                      => -0.0518441607,
                                                                             -0.0518441607);

all4wfdn_154_c921 := map(
    trim(c_preschl) = ''                       => all4wfdn_154_c923,
    NULL < (integer)c_preschl AND (real)c_preschl <= 16.5 => -0.0502262409,
    (real)c_preschl > 16.5                       => all4wfdn_154_c922,
                                              0.0008896158);

all4wfdn_154_c924 := map(
    trim(c_lux_prod) = ''                         => 0.0916173473,
    NULL < (integer)c_lux_prod AND (real)c_lux_prod <= 180.5 => 0.2299617432,
    (real)c_lux_prod > 180.5                        => 0.0028886117,
                                                 0.0916173473);

all4wfdn_154 := map(
    NULL < f_prevaddrmedianvalue_d AND f_prevaddrmedianvalue_d <= 738628.5 => all4wfdn_154_c921,
    f_prevaddrmedianvalue_d > 738628.5                                     => all4wfdn_154_c924,
    f_prevaddrmedianvalue_d = NULL                                         => 0.0018097039,
                                                                              0.0018097039);

all4wfdn := all4wfdn_0 +
    all4wfdn_1 +
    all4wfdn_2 +
    all4wfdn_3 +
    all4wfdn_4 +
    all4wfdn_5 +
    all4wfdn_6 +
    all4wfdn_7 +
    all4wfdn_8 +
    all4wfdn_9 +
    all4wfdn_10 +
    all4wfdn_11 +
    all4wfdn_12 +
    all4wfdn_13 +
    all4wfdn_14 +
    all4wfdn_15 +
    all4wfdn_16 +
    all4wfdn_17 +
    all4wfdn_18 +
    all4wfdn_19 +
    all4wfdn_20 +
    all4wfdn_21 +
    all4wfdn_22 +
    all4wfdn_23 +
    all4wfdn_24 +
    all4wfdn_25 +
    all4wfdn_26 +
    all4wfdn_27 +
    all4wfdn_28 +
    all4wfdn_29 +
    all4wfdn_30 +
    all4wfdn_31 +
    all4wfdn_32 +
    all4wfdn_33 +
    all4wfdn_34 +
    all4wfdn_35 +
    all4wfdn_36 +
    all4wfdn_37 +
    all4wfdn_38 +
    all4wfdn_39 +
    all4wfdn_40 +
    all4wfdn_41 +
    all4wfdn_42 +
    all4wfdn_43 +
    all4wfdn_44 +
    all4wfdn_45 +
    all4wfdn_46 +
    all4wfdn_47 +
    all4wfdn_48 +
    all4wfdn_49 +
    all4wfdn_50 +
    all4wfdn_51 +
    all4wfdn_52 +
    all4wfdn_53 +
    all4wfdn_54 +
    all4wfdn_55 +
    all4wfdn_56 +
    all4wfdn_57 +
    all4wfdn_58 +
    all4wfdn_59 +
    all4wfdn_60 +
    all4wfdn_61 +
    all4wfdn_62 +
    all4wfdn_63 +
    all4wfdn_64 +
    all4wfdn_65 +
    all4wfdn_66 +
    all4wfdn_67 +
    all4wfdn_68 +
    all4wfdn_69 +
    all4wfdn_70 +
    all4wfdn_71 +
    all4wfdn_72 +
    all4wfdn_73 +
    all4wfdn_74 +
    all4wfdn_75 +
    all4wfdn_76 +
    all4wfdn_77 +
    all4wfdn_78 +
    all4wfdn_79 +
    all4wfdn_80 +
    all4wfdn_81 +
    all4wfdn_82 +
    all4wfdn_83 +
    all4wfdn_84 +
    all4wfdn_85 +
    all4wfdn_86 +
    all4wfdn_87 +
    all4wfdn_88 +
    all4wfdn_89 +
    all4wfdn_90 +
    all4wfdn_91 +
    all4wfdn_92 +
    all4wfdn_93 +
    all4wfdn_94 +
    all4wfdn_95 +
    all4wfdn_96 +
    all4wfdn_97 +
    all4wfdn_98 +
    all4wfdn_99 +
    all4wfdn_100 +
    all4wfdn_101 +
    all4wfdn_102 +
    all4wfdn_103 +
    all4wfdn_104 +
    all4wfdn_105 +
    all4wfdn_106 +
    all4wfdn_107 +
    all4wfdn_108 +
    all4wfdn_109 +
    all4wfdn_110 +
    all4wfdn_111 +
    all4wfdn_112 +
    all4wfdn_113 +
    all4wfdn_114 +
    all4wfdn_115 +
    all4wfdn_116 +
    all4wfdn_117 +
    all4wfdn_118 +
    all4wfdn_119 +
    all4wfdn_120 +
    all4wfdn_121 +
    all4wfdn_122 +
    all4wfdn_123 +
    all4wfdn_124 +
    all4wfdn_125 +
    all4wfdn_126 +
    all4wfdn_127 +
    all4wfdn_128 +
    all4wfdn_129 +
    all4wfdn_130 +
    all4wfdn_131 +
    all4wfdn_132 +
    all4wfdn_133 +
    all4wfdn_134 +
    all4wfdn_135 +
    all4wfdn_136 +
    all4wfdn_137 +
    all4wfdn_138 +
    all4wfdn_139 +
    all4wfdn_140 +
    all4wfdn_141 +
    all4wfdn_142 +
    all4wfdn_143 +
    all4wfdn_144 +
    all4wfdn_145 +
    all4wfdn_146 +
    all4wfdn_147 +
    all4wfdn_148 +
    all4wfdn_149 +
    all4wfdn_150 +
    all4wfdn_151 +
    all4wfdn_152 +
    all4wfdn_153 +
    all4wfdn_154;

base := 700;

pts := -50;

lgt := ln(1 / 200);

offset := ln(((1 - 0.0255) * 0.10) / (0.0255 * (1 - 0.10)));

fp1506_1_0_1 := min(if(max(round(base + pts * (all4wfdn - offset - lgt) / ln(2)), 300) = NULL, -NULL, max(round(base + pts * (all4wfdn - offset - lgt) / ln(2)), 300)), 999);

or_testfraud := tf_LexID_ct > 0 or tf_ssn_ct > 0 or tf_phone_ct > 0 or tf_addr_ct > 0;

or_contrfraud := cf_LexID_ct > 0 or cf_ssn_ct > 0 or cf_phone_ct > 0 or cf_addr_ct > 0;

fp1506_1_0 := if(or_testfraud or or_contrfraud, min(if(fp1506_1_0_1 = NULL, -NULL, fp1506_1_0_1), 301), fp1506_1_0_1);

//Intermediate variables

#if(FP_DEBUG)
	self.clam															:= le;
	self.sysdate                          := sysdate;
	self.r_d31_bk_chapter_n               := r_d31_bk_chapter_n;
	self.k_nap_contradictory_i            := k_nap_contradictory_i;
	self.k_inf_contradictory_i            := k_inf_contradictory_i;
	self.r_p88_phn_dst_to_inp_add_i       := r_p88_phn_dst_to_inp_add_i;
	self.r_p85_phn_not_issued_i           := r_p85_phn_not_issued_i;
	self.r_p85_phn_disconnected_i         := r_p85_phn_disconnected_i;
	self.r_phn_cell_n                     := r_phn_cell_n;
	self.r_phn_pcs_n                      := r_phn_pcs_n;
	self.r_f03_input_add_not_most_rec_i   := r_f03_input_add_not_most_rec_i;
	self.r_f00_ssn_score_d                := r_f00_ssn_score_d;
	self.r_f00_dob_score_d                := r_f00_dob_score_d;
	self.r_f01_inp_addr_address_score_d   := r_f01_inp_addr_address_score_d;
	self.r_l70_inp_addr_dirty_i           := r_l70_inp_addr_dirty_i;
	self.r_f00_input_dob_match_level_d    := r_f00_input_dob_match_level_d;
	self.r_d30_derog_count_i              := r_d30_derog_count_i;
	self.r_d32_criminal_count_i           := r_d32_criminal_count_i;
	self._criminal_last_date              := _criminal_last_date;
	self.r_d32_mos_since_crim_ls_d        := r_d32_mos_since_crim_ls_d;
	self._felony_last_date                := _felony_last_date;
	self.r_d32_mos_since_fel_ls_d         := r_d32_mos_since_fel_ls_d;
	self.r_d31_bk_disposed_hist_count_i   := r_d31_bk_disposed_hist_count_i;
	self._header_first_seen               := _header_first_seen;
	self.r_c10_m_hdr_fs_d                 := r_c10_m_hdr_fs_d;
	self._in_dob                          := _in_dob;
	self.yr_in_dob                        := yr_in_dob;
	self.yr_in_dob_int                    := yr_in_dob_int;
	self.k_comb_age_d                     := k_comb_age_d;
	self.r_a44_curr_add_naprop_d          := r_a44_curr_add_naprop_d;
	self.r_c13_curr_addr_lres_d           := r_c13_curr_addr_lres_d;
	self.r_c13_max_lres_d                 := r_c13_max_lres_d;
	self.r_c14_addrs_5yr_i                := r_c14_addrs_5yr_i;
	self.r_c14_addrs_10yr_i               := r_c14_addrs_10yr_i;
	self.r_c14_addrs_15yr_i               := r_c14_addrs_15yr_i;
	self.r_a41_prop_owner_inp_only_d      := r_a41_prop_owner_inp_only_d;
	self.r_prop_owner_history_d           := r_prop_owner_history_d;
	self.r_c20_email_count_i              := r_c20_email_count_i;
	self.r_c20_email_domain_free_count_i  := r_c20_email_domain_free_count_i;
	self.r_c20_email_domain_isp_count_i   := r_c20_email_domain_isp_count_i;
	self.r_l79_adls_per_addr_c6_i         := r_l79_adls_per_addr_c6_i;
	self.r_a50_pb_total_dollars_d         := r_a50_pb_total_dollars_d;
	self.r_a50_pb_total_orders_d          := r_a50_pb_total_orders_d;
	self.r_pb_order_freq_d                := r_pb_order_freq_d;
	self.r_i60_inq_banking_recency_d      := r_i60_inq_banking_recency_d;
	self.r_i60_inq_mortgage_recency_d     := r_i60_inq_mortgage_recency_d;
	self.r_i60_inq_hiriskcred_count12_i   := r_i60_inq_hiriskcred_count12_i;
	self.r_i60_inq_hiriskcred_recency_d   := r_i60_inq_hiriskcred_recency_d;
	self.f_bus_addr_match_count_d         := f_bus_addr_match_count_d;
	self.f_bus_phone_match_d              := f_bus_phone_match_d;
	self.f_add_input_mobility_index_i     := f_add_input_mobility_index_i;
	self.f_add_input_nhood_bus_pct_i      := f_add_input_nhood_bus_pct_i;
	self.f_add_input_nhood_mfd_pct_i      := f_add_input_nhood_mfd_pct_i;
	self.add_input_nhood_prop_sum         := add_input_nhood_prop_sum;
	self.f_add_input_nhood_sfd_pct_d      := f_add_input_nhood_sfd_pct_d;
	self.f_add_curr_mobility_index_i      := f_add_curr_mobility_index_i;
	self.f_add_curr_nhood_bus_pct_i       := f_add_curr_nhood_bus_pct_i;
	self.f_add_curr_nhood_mfd_pct_i       := f_add_curr_nhood_mfd_pct_i;
	self.add_curr_nhood_prop_sum          := add_curr_nhood_prop_sum;
	self.f_add_curr_nhood_sfd_pct_d       := f_add_curr_nhood_sfd_pct_d;
	self.f_inq_count_i                    := f_inq_count_i;
	self.f_inq_count24_i                  := f_inq_count24_i;
	self.f_inq_banking_count_i            := f_inq_banking_count_i;
	self.f_inq_collection_count_i         := f_inq_collection_count_i;
	self.f_inq_communications_count_i     := f_inq_communications_count_i;
	self.f_inq_highriskcredit_count_i     := f_inq_highriskcredit_count_i;
	self.f_inq_highriskcredit_count24_i   := f_inq_highriskcredit_count24_i;
	self.f_inq_other_count_i              := f_inq_other_count_i;
	self.f_inq_other_count24_i            := f_inq_other_count24_i;
	self.f_inq_retail_count_i             := f_inq_retail_count_i;
	self.k_inq_dobs_per_ssn_i             := k_inq_dobs_per_ssn_i;
	self.k_inq_ssns_per_addr_i            := k_inq_ssns_per_addr_i;
	self.k_inq_per_phone_i                := k_inq_per_phone_i;
	self.k_inq_adls_per_phone_i           := k_inq_adls_per_phone_i;
	self._inq_banko_cm_first_seen         := _inq_banko_cm_first_seen;
	self.f_mos_inq_banko_cm_fseen_d       := f_mos_inq_banko_cm_fseen_d;
	self._inq_banko_cm_last_seen          := _inq_banko_cm_last_seen;
	self.f_mos_inq_banko_cm_lseen_d       := f_mos_inq_banko_cm_lseen_d;
	self._inq_banko_om_first_seen         := _inq_banko_om_first_seen;
	self.f_mos_inq_banko_om_fseen_d       := f_mos_inq_banko_om_fseen_d;
	self.f_liens_unrel_cj_total_amt_i     := f_liens_unrel_cj_total_amt_i;
	self._foreclosure_last_date           := _foreclosure_last_date;
	self.f_mos_foreclosure_lseen_d        := f_mos_foreclosure_lseen_d;
	self.k_estimated_income_d             := k_estimated_income_d;
	self.r_wealth_index_d                 := r_wealth_index_d;
	self.f_rel_incomeover50_count_d       := f_rel_incomeover50_count_d;
	self.f_rel_homeover50_count_d         := f_rel_homeover50_count_d;
	self.f_rel_homeover200_count_d        := f_rel_homeover200_count_d;
	self.f_rel_ageover30_count_d          := f_rel_ageover30_count_d;
	self.f_rel_ageover40_count_d          := f_rel_ageover40_count_d;
	self.f_rel_ageover50_count_d          := f_rel_ageover50_count_d;
	self.f_rel_educationover12_count_d    := f_rel_educationover12_count_d;
	self.f_crim_rel_under100miles_cnt_i   := f_crim_rel_under100miles_cnt_i;
	self.f_rel_under25miles_cnt_d         := f_rel_under25miles_cnt_d;
	self.f_rel_under100miles_cnt_d        := f_rel_under100miles_cnt_d;
	self.f_rel_under500miles_cnt_d        := f_rel_under500miles_cnt_d;
	self.f_rel_bankrupt_count_i           := f_rel_bankrupt_count_i;
	self.f_rel_criminal_count_i           := f_rel_criminal_count_i;
	self.f_historical_count_d             := f_historical_count_d;
	self.f_idverrisktype_i                := f_idverrisktype_i;
	self.f_sourcerisktype_i               := f_sourcerisktype_i;
	self.f_varrisktype_i                  := f_varrisktype_i;
	self.f_srchvelocityrisktype_i         := f_srchvelocityrisktype_i;
	self.f_srchunvrfdaddrcount_i          := f_srchunvrfdaddrcount_i;
	self.f_srchunvrfdphonecount_i         := f_srchunvrfdphonecount_i;
	self.f_srchfraudsrchcount_i           := f_srchfraudsrchcount_i;
	self.f_srchfraudsrchcountyr_i         := f_srchfraudsrchcountyr_i;
	self.f_srchfraudsrchcountmo_i         := f_srchfraudsrchcountmo_i;
	self.f_srchfraudsrchcountwk_i         := f_srchfraudsrchcountwk_i;
	self.f_validationrisktype_i           := f_validationrisktype_i;
	self.f_corrrisktype_i                 := f_corrrisktype_i;
	self.f_corrssnaddrcount_d             := f_corrssnaddrcount_d;
	self.f_corraddrnamecount_d            := f_corraddrnamecount_d;
	self.f_corraddrphonecount_d           := f_corraddrphonecount_d;
	self.f_corrphonelastnamecount_d       := f_corrphonelastnamecount_d;
	self.f_divrisktype_i                  := f_divrisktype_i;
	self.f_srchssnsrchcount_i             := f_srchssnsrchcount_i;
	self.f_srchssnsrchcountwk_i           := f_srchssnsrchcountwk_i;
	self.f_srchaddrsrchcount_i            := f_srchaddrsrchcount_i;
	self.f_srchphonesrchcount_i           := f_srchphonesrchcount_i;
	self.f_srchphonesrchcountday_i        := f_srchphonesrchcountday_i;
	self.f_componentcharrisktype_i        := f_componentcharrisktype_i;
	self.f_addrchangeincomediff_d         := f_addrchangeincomediff_d;
	self.f_addrchangevaluediff_d          := f_addrchangevaluediff_d;
	self.f_addrchangecrimediff_i          := f_addrchangecrimediff_i;
	self.f_curraddractivephonelist_d      := f_curraddractivephonelist_d;
	self.f_curraddrmedianincome_d         := f_curraddrmedianincome_d;
	self.f_curraddrmedianvalue_d          := f_curraddrmedianvalue_d;
	self.f_curraddrmurderindex_i          := f_curraddrmurderindex_i;
	self.f_curraddrburglaryindex_i        := f_curraddrburglaryindex_i;
	self.f_prevaddrageoldest_d            := f_prevaddrageoldest_d;
	self.f_prevaddrlenofres_d             := f_prevaddrlenofres_d;
	self.f_prevaddrdwelltype_sfd_n        := f_prevaddrdwelltype_sfd_n;
	self.f_prevaddroccupantowned_i        := f_prevaddroccupantowned_i;
	self.f_prevaddrmedianincome_d         := f_prevaddrmedianincome_d;
	self.f_prevaddrmedianvalue_d          := f_prevaddrmedianvalue_d;
	self.f_prevaddrcartheftindex_i        := f_prevaddrcartheftindex_i;
	self.f_fp_prevaddrburglaryindex_i     := f_fp_prevaddrburglaryindex_i;
	self.r_c12_source_profile_d           := r_c12_source_profile_d;
	self.r_c12_source_profile_index_d     := r_c12_source_profile_index_d;
	self.r_c23_inp_addr_occ_index_d       := r_c23_inp_addr_occ_index_d;
	self.r_c23_inp_addr_owned_not_occ_d   := r_c23_inp_addr_owned_not_occ_d;
	self.r_e57_br_source_count_d          := r_e57_br_source_count_d;
	self.r_i60_inq_prepaidcards_recency_d := r_i60_inq_prepaidcards_recency_d;
	self.f_phone_ver_insurance_d          := f_phone_ver_insurance_d;
	self.f_phone_ver_experian_d           := f_phone_ver_experian_d;
	self.f_phones_per_addr_curr_i         := f_phones_per_addr_curr_i;
	self.f_adls_per_phone_c6_i            := f_adls_per_phone_c6_i;
	self.f_dl_addrs_per_adl_i             := f_dl_addrs_per_adl_i;
	self.f_inq_email_ver_count_i          := f_inq_email_ver_count_i;
	self.f_inq_other_count_week_i         := f_inq_other_count_week_i;
	self.f_inq_prepaidcards_count_i       := f_inq_prepaidcards_count_i;
	self.f_nae_email_verd_d               := f_nae_email_verd_d;
	self.f_nae_lname_verd_d               := f_nae_lname_verd_d;
	self.f_nae_nothing_found_i            := f_nae_nothing_found_i;
	self.f_adl_per_email_i                := f_adl_per_email_i;
	self.r_c20_email_verification_d       := r_c20_email_verification_d;
	self.f_vf_hi_risk_ct_i                := f_vf_hi_risk_ct_i;
	self.f_vf_altlexid_phn_hi_risk_ct_i   := f_vf_altlexid_phn_hi_risk_ct_i;
	self.f_vf_altlexid_addr_hi_risk_ct_i  := f_vf_altlexid_addr_hi_risk_ct_i;
	self.f_vf_altlexid_addr_lo_risk_ct_d  := f_vf_altlexid_addr_lo_risk_ct_d;
	self.f_vf_lexid_ssn_hi_risk_ct_i      := f_vf_lexid_ssn_hi_risk_ct_i;
	self.f_hh_members_ct_d                := f_hh_members_ct_d;
	self.f_property_owners_ct_d           := f_property_owners_ct_d;
	self.f_hh_age_18_plus_d               := f_hh_age_18_plus_d;
	self.f_hh_collections_ct_i            := f_hh_collections_ct_i;
	self.f_hh_members_w_derog_i           := f_hh_members_w_derog_i;
	self.f_hh_bankruptcies_i              := f_hh_bankruptcies_i;
	self.f_hh_lienholders_i               := f_hh_lienholders_i;
	self.f_hh_college_attendees_d         := f_hh_college_attendees_d;
	self.all4wfdn_0                       := all4wfdn_0;
	self.all4wfdn_1                       := all4wfdn_1;
	self.all4wfdn_2                       := all4wfdn_2;
	self.all4wfdn_3                       := all4wfdn_3;
	self.all4wfdn_4                       := all4wfdn_4;
	self.all4wfdn_5                       := all4wfdn_5;
	self.all4wfdn_6                       := all4wfdn_6;
	self.all4wfdn_7                       := all4wfdn_7;
	self.all4wfdn_8                       := all4wfdn_8;
	self.all4wfdn_9                       := all4wfdn_9;
	self.all4wfdn_10                      := all4wfdn_10;
	self.all4wfdn_11                      := all4wfdn_11;
	self.all4wfdn_12                      := all4wfdn_12;
	self.all4wfdn_13                      := all4wfdn_13;
	self.all4wfdn_14                      := all4wfdn_14;
	self.all4wfdn_15                      := all4wfdn_15;
	self.all4wfdn_16                      := all4wfdn_16;
	self.all4wfdn_17                      := all4wfdn_17;
	self.all4wfdn_18                      := all4wfdn_18;
	self.all4wfdn_19                      := all4wfdn_19;
	self.all4wfdn_20                      := all4wfdn_20;
	self.all4wfdn_21                      := all4wfdn_21;
	self.all4wfdn_22                      := all4wfdn_22;
	self.all4wfdn_23                      := all4wfdn_23;
	self.all4wfdn_24                      := all4wfdn_24;
	self.all4wfdn_25                      := all4wfdn_25;
	self.all4wfdn_26                      := all4wfdn_26;
	self.all4wfdn_27                      := all4wfdn_27;
	self.all4wfdn_28                      := all4wfdn_28;
	self.all4wfdn_29                      := all4wfdn_29;
	self.all4wfdn_30                      := all4wfdn_30;
	self.all4wfdn_31                      := all4wfdn_31;
	self.all4wfdn_32                      := all4wfdn_32;
	self.all4wfdn_33                      := all4wfdn_33;
	self.all4wfdn_34                      := all4wfdn_34;
	self.all4wfdn_35                      := all4wfdn_35;
	self.all4wfdn_36                      := all4wfdn_36;
	self.all4wfdn_37                      := all4wfdn_37;
	self.all4wfdn_38                      := all4wfdn_38;
	self.all4wfdn_39                      := all4wfdn_39;
	self.all4wfdn_40                      := all4wfdn_40;
	self.all4wfdn_41                      := all4wfdn_41;
	self.all4wfdn_42                      := all4wfdn_42;
	self.all4wfdn_43                      := all4wfdn_43;
	self.all4wfdn_44                      := all4wfdn_44;
	self.all4wfdn_45                      := all4wfdn_45;
	self.all4wfdn_46                      := all4wfdn_46;
	self.all4wfdn_47                      := all4wfdn_47;
	self.all4wfdn_48                      := all4wfdn_48;
	self.all4wfdn_49                      := all4wfdn_49;
	self.all4wfdn_50                      := all4wfdn_50;
	self.all4wfdn_51                      := all4wfdn_51;
	self.all4wfdn_52                      := all4wfdn_52;
	self.all4wfdn_53                      := all4wfdn_53;
	self.all4wfdn_54                      := all4wfdn_54;
	self.all4wfdn_55                      := all4wfdn_55;
	self.all4wfdn_56                      := all4wfdn_56;
	self.all4wfdn_57                      := all4wfdn_57;
	self.all4wfdn_58                      := all4wfdn_58;
	self.all4wfdn_59                      := all4wfdn_59;
	self.all4wfdn_60                      := all4wfdn_60;
	self.all4wfdn_61                      := all4wfdn_61;
	self.all4wfdn_62                      := all4wfdn_62;
	self.all4wfdn_63                      := all4wfdn_63;
	self.all4wfdn_64                      := all4wfdn_64;
	self.all4wfdn_65                      := all4wfdn_65;
	self.all4wfdn_66                      := all4wfdn_66;
	self.all4wfdn_67                      := all4wfdn_67;
	self.all4wfdn_68                      := all4wfdn_68;
	self.all4wfdn_69                      := all4wfdn_69;
	self.all4wfdn_70                      := all4wfdn_70;
	self.all4wfdn_71                      := all4wfdn_71;
	self.all4wfdn_72                      := all4wfdn_72;
	self.all4wfdn_73                      := all4wfdn_73;
	self.all4wfdn_74                      := all4wfdn_74;
	self.all4wfdn_75                      := all4wfdn_75;
	self.all4wfdn_76                      := all4wfdn_76;
	self.all4wfdn_77                      := all4wfdn_77;
	self.all4wfdn_78                      := all4wfdn_78;
	self.all4wfdn_79                      := all4wfdn_79;
	self.all4wfdn_80                      := all4wfdn_80;
	self.all4wfdn_81                      := all4wfdn_81;
	self.all4wfdn_82                      := all4wfdn_82;
	self.all4wfdn_83                      := all4wfdn_83;
	self.all4wfdn_84                      := all4wfdn_84;
	self.all4wfdn_85                      := all4wfdn_85;
	self.all4wfdn_86                      := all4wfdn_86;
	self.all4wfdn_87                      := all4wfdn_87;
	self.all4wfdn_88                      := all4wfdn_88;
	self.all4wfdn_89                      := all4wfdn_89;
	self.all4wfdn_90                      := all4wfdn_90;
	self.all4wfdn_91                      := all4wfdn_91;
	self.all4wfdn_92                      := all4wfdn_92;
	self.all4wfdn_93                      := all4wfdn_93;
	self.all4wfdn_94                      := all4wfdn_94;
	self.all4wfdn_95                      := all4wfdn_95;
	self.all4wfdn_96                      := all4wfdn_96;
	self.all4wfdn_97                      := all4wfdn_97;
	self.all4wfdn_98                      := all4wfdn_98;
	self.all4wfdn_99                      := all4wfdn_99;
	self.all4wfdn_100                     := all4wfdn_100;
	self.all4wfdn_101                     := all4wfdn_101;
	self.all4wfdn_102                     := all4wfdn_102;
	self.all4wfdn_103                     := all4wfdn_103;
	self.all4wfdn_104                     := all4wfdn_104;
	self.all4wfdn_105                     := all4wfdn_105;
	self.all4wfdn_106                     := all4wfdn_106;
	self.all4wfdn_107                     := all4wfdn_107;
	self.all4wfdn_108                     := all4wfdn_108;
	self.all4wfdn_109                     := all4wfdn_109;
	self.all4wfdn_110                     := all4wfdn_110;
	self.all4wfdn_111                     := all4wfdn_111;
	self.all4wfdn_112                     := all4wfdn_112;
	self.all4wfdn_113                     := all4wfdn_113;
	self.all4wfdn_114                     := all4wfdn_114;
	self.all4wfdn_115                     := all4wfdn_115;
	self.all4wfdn_116                     := all4wfdn_116;
	self.all4wfdn_117                     := all4wfdn_117;
	self.all4wfdn_118                     := all4wfdn_118;
	self.all4wfdn_119                     := all4wfdn_119;
	self.all4wfdn_120                     := all4wfdn_120;
	self.all4wfdn_121                     := all4wfdn_121;
	self.all4wfdn_122                     := all4wfdn_122;
	self.all4wfdn_123                     := all4wfdn_123;
	self.all4wfdn_124                     := all4wfdn_124;
	self.all4wfdn_125                     := all4wfdn_125;
	self.all4wfdn_126                     := all4wfdn_126;
	self.all4wfdn_127                     := all4wfdn_127;
	self.all4wfdn_128                     := all4wfdn_128;
	self.all4wfdn_129                     := all4wfdn_129;
	self.all4wfdn_130                     := all4wfdn_130;
	self.all4wfdn_131                     := all4wfdn_131;
	self.all4wfdn_132                     := all4wfdn_132;
	self.all4wfdn_133                     := all4wfdn_133;
	self.all4wfdn_134                     := all4wfdn_134;
	self.all4wfdn_135                     := all4wfdn_135;
	self.all4wfdn_136                     := all4wfdn_136;
	self.all4wfdn_137                     := all4wfdn_137;
	self.all4wfdn_138                     := all4wfdn_138;
	self.all4wfdn_139                     := all4wfdn_139;
	self.all4wfdn_140                     := all4wfdn_140;
	self.all4wfdn_141                     := all4wfdn_141;
	self.all4wfdn_142                     := all4wfdn_142;
	self.all4wfdn_143                     := all4wfdn_143;
	self.all4wfdn_144                     := all4wfdn_144;
	self.all4wfdn_145                     := all4wfdn_145;
	self.all4wfdn_146                     := all4wfdn_146;
	self.all4wfdn_147                     := all4wfdn_147;
	self.all4wfdn_148                     := all4wfdn_148;
	self.all4wfdn_149                     := all4wfdn_149;
	self.all4wfdn_150                     := all4wfdn_150;
	self.all4wfdn_151                     := all4wfdn_151;
	self.all4wfdn_152                     := all4wfdn_152;
	self.all4wfdn_153                     := all4wfdn_153;
	self.all4wfdn_154                     := all4wfdn_154;
	self.all4wfdn                         := all4wfdn;
	self.base                             := base;
	self.pts                              := pts;
	self.lgt                              := lgt;
	self.offset                           := offset;
	self.or_testfraud                     := or_testfraud;
	self.or_contrfraud                    := or_contrfraud;
	self.fp1506_1_0                       := fp1506_1_0;
#end
	self.seq := le.seq;
	ritmp :=  Models.fraudpoint_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1506_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1506_1_0;
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
