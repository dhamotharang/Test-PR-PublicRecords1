import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, easi, std, Models;


EXPORT FP1705_1_0 (dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons) := FUNCTION
		
blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];
								
		//FP_DEBUG := True;
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD

	
	/* Model Intermediate Variables */
Integer   seq;
STRING inq_peraddr;
STRING inq_adlspercurraddr;
STRING addrpop;
INTEGER	  sysdate;
INTEGER   	ver_src_en_pos;
STRING   	_ver_src_fdate_en;
INTEGER   	ver_src_fdate_en;
INTEGER   	ver_src_eq_pos;
STRING   	_ver_src_fdate_eq;
INTEGER   	ver_src_fdate_eq;
INTEGER   	ver_src_tn_pos;
STRING   	_ver_src_fdate_tn;
INTEGER   	ver_src_fdate_tn;
INTEGER   	ver_src_ts_pos;
STRING   	_ver_src_fdate_ts;
INTEGER   	ver_src_fdate_ts;
INTEGER   	ver_src_tu_pos;
STRING   	_ver_src_fdate_tu;
INTEGER   	ver_src_fdate_tu;
INTEGER   	util_type_2_pos;
BOOLEAN   	util_type_2;
INTEGER   	util_type_1_pos;
BOOLEAN   	util_type_1;
INTEGER   	util_type_z_pos;
BOOLEAN   	util_type_z;
STRING   	iv_add_apt;
INTEGER   	num_dob_match_level;
INTEGER   	nas_summary_ver;
INTEGER   	nap_summary_ver;
INTEGER   	infutor_nap_ver;
INTEGER   	dob_ver;
INTEGER   	sufficiently_verified;
STRING   	add_ec1;
INTEGER   	addr_validation_problem;
INTEGER   	phn_validation_problem;
INTEGER   	validation_problem;
INTEGER   	tot_liens;
INTEGER   	tot_liens_w_type;
INTEGER   	has_derog;
STRING   	rv_6seg_riskview_5_0;
INTEGER   	_rc_ssnlowissue;
INTEGER   	ssn_years;
INTEGER   	nf_age_at_ssn_issuance;
INTEGER   	rv_f03_input_add_not_most_rec;
INTEGER   	rv_c19_add_prison_hist;
INTEGER   	rv_d30_derog_count;
INTEGER   	_felony_last_date;
INTEGER	    _criminal_last_date;
INTEGER   	rv_d32_criminal_behavior_lvl;
INTEGER   	rv_d32_criminal_count;
STRING   	rv_d32_criminal_x_felony;
STRING   	rv_d31_all_bk;
INTEGER   	rv_d33_eviction_recency;
INTEGER   	rv_d33_eviction_count;
STRING   	iv_d34_liens_unrel_x_rel;
INTEGER   	earliest_bureau_date_all;
INTEGER   	nf_m_bureau_adl_fs_all;
REAL	    _header_first_seen;
INTEGER   	rv_c10_m_hdr_fs;
REAL   	rv_c12_source_profile;
INTEGER   	yr_in_dob;
INTEGER   	yr_in_dob_int;
INTEGER   	rv_comb_age;
REAL   	rv_a49_curr_avm_chg_1yr_pct;
INTEGER   	rv_f04_curr_add_occ_index;
INTEGER   	rv_i60_inq_count12;
INTEGER   	rv_i60_inq_hiriskcred_count12;
INTEGER   	rv_i60_inq_hiriskcred_recency;
INTEGER   	rv_i60_inq_prepaidcards_recency;
INTEGER   	rv_i60_inq_comm_recency;
INTEGER   	rv_i60_inq_other_count12;
INTEGER   	nf_inq_lname_ver_count;
INTEGER   	nf_inq_addr_ver_count;
INTEGER   	nf_inq_ssn_ver_count;
INTEGER   	nf_inquiry_verification_index;
INTEGER   	nf_inq_count24;
INTEGER   	nf_inq_banking_count_day;
INTEGER   	nf_inq_collection_count24;
INTEGER   	nf_inq_communications_count24;
INTEGER   	nf_inq_highriskcredit_count24;
INTEGER   	nf_inq_other_count24;
INTEGER   	nf_inq_prepaidcards_count24;
INTEGER   	nf_inq_perbestssn_count12;
INTEGER   	rv_l79_adls_per_addr_c6;
INTEGER   	rv_l79_adls_per_sfd_addr_c6;
INTEGER   	rv_c13_attr_addrs_recency;
INTEGER   	iv_addr_non_phn_src_ct;
BOOLEAN   	mortgage_present;
String   	mortgage_type;
STRING   	iv_curr_add_mortgage_type;
REAL   	rv_a49_curr_add_avm_pct_chg_2yr;
INTEGER   	iv_prv_addr_lres;
INTEGER   	iv_prv_addr_avm_auto_val;
INTEGER   	nf_addrs_per_bestssn;
INTEGER   	nf_addrs_per_bestssn_c6;
INTEGER   	nf_adls_per_curraddr_c6;
INTEGER   	nf_ssns_per_curraddr_c6;
INTEGER   	iv_unverified_addr_count;
INTEGER   	nf_bus_addr_match_count;
STRING   	nf_util_adl_summary;
INTEGER   	nf_phones_per_addr_curr;
INTEGER   	nf_addrs_per_ssn_c6;
INTEGER   	nf_attr_arrests;
INTEGER   	iv_estimated_income;
INTEGER   	iv_wealth_index;
REAL   	nf_hh_pct_property_owners;
INTEGER   	nf_hh_collections_ct;
REAL   	nf_hh_lienholders_pct;
INTEGER   	nf_average_rel_income;
INTEGER   	nf_average_rel_age;
REAL   	nf_pct_rel_with_felony;
REAL   	nf_pct_rel_prop_owned;
REAL   	nf_pct_rel_prop_sold;
STRING   	nf_historic_x_current_ct;
INTEGER   	nf_fp_sourcerisktype;
INTEGER   	nf_fp_varrisktype;
INTEGER   	nf_fp_srchvelocityrisktype;
INTEGER   	nf_fp_srchunvrfdssncount;
INTEGER   	nf_fp_srchunvrfdaddrcount;
INTEGER   	nf_fp_srchunvrfdphonecount;
INTEGER   	nf_unvrfd_search_risk_index;
INTEGER   	nf_fp_srchfraudsrchcountyr;
INTEGER   	nf_fp_assocrisktype;
INTEGER   	nf_fp_divrisktype;
INTEGER   	nf_fp_divaddrsuspidcountnew;
INTEGER   	nf_fp_srchcomponentrisktype;
INTEGER   	nf_fp_srchaddrsrchcountmo;
INTEGER   	nf_fp_srchaddrsrchcountday;
INTEGER   	nf_fp_curraddrmedianincome;
INTEGER   	nf_fp_curraddrmedianvalue;
INTEGER   	nf_fp_curraddrcartheftindex;
INTEGER   	nf_fp_curraddrburglaryindex;
INTEGER   	nf_fp_curraddrcrimeindex;
INTEGER   	nf_fp_prevaddrcartheftindex;
INTEGER   	nf_fp_prevaddrcrimeindex;
INTEGER   	_in_dob;
INTEGER   	earliest_bureau_date;
INTEGER   	earliest_bureau_yrs;
INTEGER   	calc_dob;
INTEGER   	iv_bureau_emergence_age;
INTEGER   	vo_pos;
STRING   	vote_adl_lseen_vo;
INTEGER   	_vote_adl_lseen_vo;
INTEGER   	iv_mos_src_voter_adl_lseen;
STRING 	  nf_seg_fraudpoint_3_0;
INTEGER 	  nf_inq_per_addr;
INTEGER 	  nf_inquiry_adl_vel_risk_index;
INTEGER 	  nf_inq_lnamesperaddr_count12;
INTEGER 	  nf_inq_peraddr_count12;
INTEGER 	  nf_inq_perssn_count_week;
INTEGER 	  nf_inq_perssn_count12;
INTEGER 	  nf_inquiry_addr_vel_risk_index;
INTEGER 	  nf_inquiry_addr_vel_risk_indexv2;
INTEGER 	  nf_inq_per_sfd_addr;
INTEGER 	  nf_invbest_inq_adlsperaddr_diff;
INTEGER 	  nf_inq_adls_per_addr;
INTEGER 	  nf_inq_lnames_per_addr;
INTEGER 	  nf_inq_adls_per_apt_addr;
INTEGER 	  nf_inq_per_ssn;
INTEGER 	  nf_inq_lnamesperaddr_recency;
REAL	    final_score_tree_0;
REAL	    final_score_tree_1;
REAL	    final_score_tree_2;
REAL	    final_score_tree_3;
REAL	    final_score_tree_4;
REAL	    final_score_tree_5;
REAL	    final_score_tree_6;
REAL	    final_score_tree_7;
REAL	    final_score_tree_8;
REAL	    final_score_tree_9;
REAL	    final_score_tree_10;
REAL	    final_score_tree_11;
REAL	    final_score_tree_12;
REAL	    final_score_tree_13;
REAL	    final_score_tree_14;
REAL	    final_score_tree_15;
REAL	    final_score_tree_16;
REAL	    final_score_tree_17;
REAL	    final_score_tree_18;
REAL	    final_score_tree_19;
REAL	    final_score_tree_20;
REAL	    final_score_tree_21;
REAL	    final_score_tree_22;
REAL	    final_score_tree_23;
REAL	    final_score_tree_24;
REAL	    final_score_tree_25;
REAL	    final_score_tree_26;
REAL	    final_score_tree_27;
REAL	    final_score_tree_28;
REAL	    final_score_tree_29;
REAL	    final_score_tree_30;
REAL	    final_score_tree_31;
REAL	    final_score_tree_32;
REAL	    final_score_tree_33;
REAL	    final_score_tree_34;
REAL	    final_score_tree_35;
REAL	    final_score_tree_36;
REAL	    final_score_tree_37;
REAL	    final_score_tree_38;
REAL	    final_score_tree_39;
REAL	    final_score_tree_40;
REAL	    final_score_tree_41;
REAL	    final_score_tree_42;
REAL	    final_score_tree_43;
REAL	    final_score_tree_44;
REAL	    final_score_tree_45;
REAL	    final_score_tree_46;
REAL	    final_score_tree_47;
REAL	    final_score_tree_48;
REAL	    final_score_tree_49;
REAL	    final_score_tree_50;
REAL	    final_score_tree_51;
REAL	    final_score_tree_52;
REAL	    final_score_tree_53;
REAL	    final_score_tree_54;
REAL	    final_score_tree_55;
REAL	    final_score_tree_56;
REAL	    final_score_tree_57;
REAL	    final_score_tree_58;
REAL	    final_score_tree_59;
REAL	    final_score_tree_60;
REAL	    final_score_tree_61;
REAL	    final_score_tree_62;
REAL	    final_score_tree_63;
REAL	    final_score_tree_64;
REAL	    final_score_tree_65;
REAL	    final_score_tree_66;
REAL	    final_score_tree_67;
REAL	    final_score_tree_68;
REAL	    final_score_tree_69;
REAL	    final_score_tree_70;
REAL	    final_score_tree_71;
REAL	    final_score_tree_72;
REAL	    final_score_tree_73;
REAL	    final_score_tree_74;
REAL	    final_score_tree_75;
REAL	    final_score_tree_76;
REAL	    final_score_tree_77;
REAL	    final_score_tree_78;
REAL	    final_score_tree_79;
REAL	    final_score_tree_80;
REAL	    final_score_tree_81;
REAL	    final_score_tree_82;
REAL	    final_score_tree_83;
REAL	    final_score_tree_84;
REAL	    final_score_tree_85;
REAL	    final_score_tree_86;
REAL	    final_score_tree_87;
REAL	    final_score_tree_88;
REAL	    final_score_tree_89;
REAL	    final_score_tree_90;
REAL	    final_score_tree_91;
REAL	    final_score_tree_92;
REAL	    final_score_tree_93;
REAL	    final_score_tree_94;
REAL	    final_score_tree_95;
REAL	    final_score_tree_96;
REAL	    final_score_tree_97;
REAL	    final_score_tree_98;
REAL	    final_score_tree_99;
REAL	    final_score_tree_100;
REAL	    final_score_tree_101;
REAL	    final_score_tree_102;
REAL	    final_score_tree_103;
REAL	    final_score_tree_104;
REAL	    final_score_tree_105;
REAL	    final_score_tree_106;
REAL	    final_score_tree_107;
REAL	    final_score_tree_108;
REAL	    final_score_tree_109;
REAL	    final_score_tree_110;
REAL	    final_score_tree_111;
REAL	    final_score_gbm_logit;
REAL	  pbr;
REAL	  sbr;
REAL	  offset;
INTEGER 	base;
INTEGER	  pts;
REAL	  lgt;
INTEGER	  fp1705_1_0;
BOOLEAN	  _ver_src_ds;
BOOLEAN	  _ver_src_de;
BOOLEAN	  _ver_src_eq;
BOOLEAN 	_ver_src_en;
BOOLEAN	  _ver_src_tn;
BOOLEAN	  _ver_src_tu;
BOOLEAN	  _credit_source_cnt;
BOOLEAN	  _ver_src_cnt;
BOOLEAN	  _bureauonly;
BOOLEAN	  _derog;
BOOLEAN	  _deceased;
BOOLEAN	  _ssnpriortodob;
BOOLEAN	  _inputmiskeys;
BOOLEAN	  _multiplessns;
REAL 	    _hh_strikes;
INTEGER	  stolenid;
INTEGER	  manipulatedid;
INTEGER	  manipulatedidpt2;
BOOLEAN	  syntheticid;
INTEGER	  suspiciousactivity;
INTEGER	  vulnerablevictim;
INTEGER	  friendlyfraud;
INTEGER	  stolenc_fp1705_1_0;
INTEGER	  manip2c_fp1705_1_0;
INTEGER	  synthc_fp1705_1_0;
INTEGER	  suspactc_fp1705_1_0;
INTEGER	  vulnvicc_fp1705_1_0;
INTEGER	  friendlyc_fp1705_1_0;
INTEGER	  custstolidindex;
INTEGER	  custmanipidindex;
INTEGER	  custsynthidindex;
INTEGER	  custsuspactindex;
INTEGER	  custvulnvicindex;
INTEGER	  custfriendfrdindex;

			models.layouts.layout_fp1109;
			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
    layout_debug doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
  #else
    models.layouts.layout_fp1109 doModel( clam le, easi.Key_Easi_Census rt ) := TRANSFORM
		
  #end	

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	inq_perbestssn                   := le.best_flags.inq_perbestssn;
	best_ssn_valid                   := le.best_flags.best_ssn_valid;;
	addrs_per_bestssn                := le.best_flags.addrs_per_bestssn;
	addrs_per_bestssn_c6             := le.best_flags.addrs_per_bestssn_c6;
	adls_per_curraddr_c6             := le.best_flags.adls_per_curraddr_c6;
	ssns_per_curraddr_c6             := le.best_flags.ssns_per_curraddr_c6;
	inq_perssn_count_week            := le.acc_logs.inq_perssn_count_week;
  inq_adlspercurraddr              := le.best_flags.inq_adlspercurraddr; 
 	inq_lnamesperaddr_count01        := le.acc_logs.inq_lnamesperaddr_count01;
	inq_lnamesperaddr_count03        := le.acc_logs.inq_lnamesperaddr_count03;
	inq_lnamesperaddr_count06        := le.acc_logs.inq_lnamesperaddr_count06; 
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
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_addrcount                     := le.iid.addrcount;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	hdr_source_profile               := le.source_profile;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	voter_avail                      := le.available_sources.voter;
	bus_addr_match_count             := le.business_header_address_summary.bus_addr_match_cnt;
	fnamepop                         := le.input_validation.firstname;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	util_adl_type_list               := le.utility.utili_adl_type;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_lres                    := le.lres2;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_avm_auto_val_2          := le.avm.address_history_1.avm_automated_valuation2;
	add_curr_avm_auto_val_3          := le.avm.address_history_1.avm_automated_valuation3;
	add_curr_mortgage_date           := le.address_verification.address_history_1.mortgage_date;
	add_curr_mortgage_type           := le.address_verification.address_history_1.mortgage_type;
	add_curr_pop                     := le.addrPop2;
	add_prev_lres                    := le.lres3;
	add_prev_avm_auto_val            := le.avm.address_history_2.avm_automated_valuation;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	add_prev_pop                     := le.addrPop3;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	unverified_addr_count            := le.address_verification.unverified_addr_count;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	phones_per_addr_curr             := le.velocity_counters.phones_per_addr_current;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
  lnames_per_adl_c6                := IF(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
	addrs_per_ssn_c6                 := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn_created_6months );
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	inq_addr_ver_count               := le.acc_logs.inquiry_addr_ver_ct;
	inq_fname_ver_count              := le.acc_logs.inquiry_fname_ver_ct;
	inq_lname_ver_count              := le.acc_logs.inquiry_lname_ver_ct;
	inq_ssn_ver_count                := le.acc_logs.inquiry_ssn_ver_ct;
	inq_dob_ver_count                := le.acc_logs.inquiry_dob_ver_ct;
	inq_phone_ver_count              := le.acc_logs.inquiry_phone_ver_ct;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_banking_count_day            := if(isFCRA, 0, le.acc_logs.banking.countday);
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
	inq_other_count12                := le.acc_logs.other.count12;
	inq_other_count24                := le.acc_logs.other.count24;
	inq_prepaidcards_count           := le.acc_logs.prepaidcards.counttotal;
	inq_prepaidcards_count01         := le.acc_logs.prepaidcards.count01;
	inq_prepaidcards_count03         := le.acc_logs.prepaidcards.count03;
	inq_prepaidcards_count06         := le.acc_logs.prepaidcards.count06;
	inq_prepaidcards_count12         := le.acc_logs.prepaidcards.count12;
	inq_prepaidcards_count24         := le.acc_logs.prepaidcards.count24;
	inq_peradl                       := le.acc_logs.inquiryperadl;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_fnamesperadl                 := le.acc_logs.inquiryfnamesperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	inq_perssn                       := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
	inq_peraddr                      := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
	inq_adlsperaddr                  := if(isFCRA, 0, le.acc_logs.inquiryADLsPerAddr );
	inq_lnamesperaddr                := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	stl_inq_count24                  := le.impulse.count24;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_arrests                     := le.bjl.arrests_count;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	fp_sourcerisktype                := le.fdattributesv2.sourcerisklevel;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_srchvelocityrisktype          := le.fdattributesv2.searchvelocityrisklevel;
	fp_srchunvrfdssncount            := le.fdattributesv2.searchunverifiedssncountyear;
	fp_srchunvrfdaddrcount           := le.fdattributesv2.searchunverifiedaddrcountyear;
	fp_srchunvrfddobcount            := le.fdattributesv2.searchunverifieddobcountyear;
	fp_srchunvrfdphonecount          := le.fdattributesv2.searchunverifiedphonecountyear;
	fp_srchfraudsrchcountyr          := le.fdattributesv2.searchfraudsearchcountyear;
	fp_assocrisktype                 := le.fdattributesv2.assocrisklevel;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_divaddrsuspidcountnew         := le.fdattributesv2.divaddrsuspidentitycountnew;
	fp_srchcomponentrisktype         := le.fdattributesv2.searchcomponentrisklevel;
	fp_srchssnsrchcountmo            := le.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcountmo           := le.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchaddrsrchcountday          := le.fdattributesv2.searchaddrsearchcountday;
	fp_srchphonesrchcountmo          := le.fdattributesv2.searchphonesearchcountmonth;
	fp_curraddrmedianincome          := le.fdattributesv2.curraddrmedianincome;
	fp_curraddrmedianvalue           := le.fdattributesv2.curraddrmedianvalue;
	fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
	fp_curraddrburglaryindex         := le.fdattributesv2.curraddrburglaryindex;
	fp_curraddrcrimeindex            := le.fdattributesv2.curraddrcrimeindex;
	fp_prevaddrcartheftindex         := le.fdattributesv2.prevaddrcartheftindex;
	fp_prevaddrcrimeindex            := le.fdattributesv2.prevaddrcrimeindex;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
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
	liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
	liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
	liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
	liens_rel_o_ct                   := le.liens.liens_released_other_lj.count;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
	liens_rel_st_ct                  := le.liens.liens_released_suits.count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	felony_last_date                 := le.bjl.last_felony_date;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_property_owners_ct            := le.hhid_summary.hh_property_owners_ct;
	hh_collections_ct                := le.hhid_summary.hh_collections_ct;
	hh_payday_loan_users             := le.hhid_summary.hh_payday_loan_users;
	hh_members_w_derog               := le.hhid_summary.hh_members_w_derog;
	hh_lienholders                   := le.hhid_summary.hh_lienholders;
	hh_criminals                     := le.hhid_summary.hh_criminals;
	rel_count                        := le.relatives.relative_count;
	rel_felony_count                 := le.relatives.relative_felony_count;
	rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
	rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
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
	current_count                    := le.vehicles.current_count;
	historical_count                 := le.vehicles.historical_count;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;
  C_OWNOCC_P                       := (STRING)rt.ownocp;
  c_civ_emp                        := (STRING)rt.civ_emp;
	c_families                       := (STRING)rt.families;
	c_health                         := (STRING)rt.health;
	c_high_ed                        := (STRING)rt.high_ed;
	c_incollege                      := (STRING)rt.incollege;
	c_med_hhinc                      := (STRING)rt.med_hhinc;
	c_retired2                       := (STRING)rt.retired2;
	c_totcrime                       := (STRING)rt.totcrime;
	c_unemp                          := (STRING)rt.unemp;
	c_urban_p                        := (STRING)rt.urban_p;
	c_vacant_p                       := (STRING)rt.vacant_p;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := __common__(  (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0));

sysdate := common.sas_date(if(le.historydate=999999, (string)Std.Date.Today(), (string6)le.historydate+'01'));

ver_src_en_pos := Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie');

_ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');

ver_src_fdate_en := common.sas_date((string)(_ver_src_fdate_en));

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');

_ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq := common.sas_date((string)(_ver_src_fdate_eq));

ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');

_ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0');

ver_src_fdate_tn := common.sas_date((string)(_ver_src_fdate_tn));

ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie');

_ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');

ver_src_fdate_ts := common.sas_date((string)(_ver_src_fdate_ts));

ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie');

_ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0');

ver_src_fdate_tu := common.sas_date((string)(_ver_src_fdate_tu));

util_type_2_pos := Models.Common.findw_cpp(util_adl_type_list, '2' , '  ,', 'ie');

util_type_2 := util_type_2_pos > 0;

util_type_1_pos := Models.Common.findw_cpp(util_adl_type_list, '1' , '  ,', 'ie');

util_type_1 := util_type_1_pos > 0;

util_type_z_pos := Models.Common.findw_cpp(util_adl_type_list, 'Z' , '  ,', 'ie');

util_type_z := util_type_z_pos > 0;

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

num_dob_match_level := (integer)input_dob_match_level;

nas_summary_ver := __common__( if(ssnlength > '0' and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0));

nap_summary_ver := if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0);

infutor_nap_ver := if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0);

dob_ver := if(dobpop and num_dob_match_level >= 5, 1, 0);

sufficiently_verified := map(
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))                                        => 1,
    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
                                                                                                                               0);

add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

addr_validation_problem := __common__( if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') or rc_hriskaddrflag = '4' or rc_addrcommflag = '2' or (add_input_advo_res_or_bus in ['B', 'D']) or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') or add_input_advo_vacancy = 'Y', 1, 0));

phn_validation_problem := __common__( if(rc_hphonetypeflag = 'A' or rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' or (telcordia_type in ['02', '56', '61']) or rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' or rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1', 1, 0));

validation_problem := __common__( if(adls_per_ssn >= 5 or ssns_per_adl >= 4 or invalid_ssns_per_adl >= 1 or adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 or rc_hrisksic = '2225' or rc_hrisksicphone = '2225' or (boolean)(integer)addr_validation_problem or (boolean)(integer)phn_validation_problem, 1, 0));

tot_liens := if(max(liens_historical_unreleased_ct, liens_recent_unreleased_count, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)));

tot_liens_w_type := if(max(liens_unrel_LT_ct, liens_rel_LT_ct, liens_unrel_SC_ct, liens_rel_SC_ct, liens_unrel_CJ_ct, liens_rel_CJ_ct, liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct, liens_unrel_FC_ct, liens_rel_FC_ct, liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct), if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct), if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct), if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct), if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct), if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct)));

has_derog := if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0);

rv_6seg_riskview_5_0 := map(
    (INTEGER)truedid = 0                                                                                                     => '0 TRUEDID = 0              ',
    not((boolean)sufficiently_verified)                                                                             => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and (boolean)(integer)validation_problem                                         => '1 VER/VAL PROBLEMS         ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch) and (boolean)(integer)has_derog                   => '2 ADDR NOT CURRENT - DEROG ',
    (boolean)sufficiently_verified and not(add_input_isbestmatch)                                                   => '3 ADDR NOT CURRENT - OTHER ',
    (boolean)sufficiently_verified and add_input_isbestmatch and (boolean)(integer)has_derog                        => '4 SUFFICIENTLY VERD - DEROG',
    (boolean)sufficiently_verified and add_input_isbestmatch and (add_input_naprop = 4 or property_owned_total > 0) => '5 SUFFICIENTLY VERD - OWNER',
                                                                                                                       '6 SUFFICIENTLY VERD - OTHER');

_rc_ssnlowissue := common.sas_date((string)(rc_ssnlowissue));

_in_dob_2 := common.sas_date((string)(in_dob));

ssn_years := if(_rc_ssnlowissue = NULL or sysdate = NULL, NULL, if ((sysdate - _rc_ssnlowissue) / 365.25 >= 0, roundup((sysdate - _rc_ssnlowissue) / 365.25), truncate((sysdate - _rc_ssnlowissue) / 365.25)));

calc_dob_1 := if(_in_dob_2 = NULL or sysdate = NULL, NULL, if ((sysdate - _in_dob_2) / 365.25 >= 0, roundup((sysdate - _in_dob_2) / 365.25), truncate((sysdate - _in_dob_2) / 365.25)));

nf_age_at_ssn_issuance := map(
    not(truedid and (ssnlength in ['4', '9'])) or sysdate = NULL or ssn_years = NULL => NULL,
    (string)rc_ssnlowissue = '20110625'                                              => NULL,
    not(calc_dob_1 = NULL)                                                           => calc_dob_1 - ssn_years,
    inferred_age = 0                                                                 => NULL,
                                                                                        inferred_age - ssn_years);                                                                                                                                                                        

rv_f03_input_add_not_most_rec := __common__( if(not(truedid and add_input_pop), NULL, (Integer)rc_input_addr_not_most_recent));

rv_c19_add_prison_hist := __common__( if(not(truedid), NULL, (integer)addrs_prison_history));

rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));

_felony_last_date := common.sas_date((string)(felony_last_date));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

rv_d32_criminal_behavior_lvl := map(
    not(truedid)                                               => NULL,
    felony_count > 0 and sysdate - _felony_last_date < 365     => 6,
    criminal_count > 0 and sysdate - _criminal_last_date < 365 => 5,
    felony_count > 0                                           => 4,
      min(if(criminal_count = NULL, -NULL, criminal_count), 3));

rv_d32_criminal_count := if(not(truedid), NULL, min(if(criminal_count = NULL, -NULL, criminal_count), 999));

rv_d32_criminal_x_felony := __common__( if(not(truedid), '', trim((String)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT)));

rv_d31_all_bk := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                   => '',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS') = 1 or if(max(bk_dismissed_recent_count, bk_dismissed_historical_count) = NULL, NULL, sum(if(bk_dismissed_recent_count = NULL, 0, bk_dismissed_recent_count), if(bk_dismissed_historical_count = NULL, 0, bk_dismissed_historical_count))) > 0 => '1 - BK DISMISSED ',
    contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARG') = 1 or if(max(bk_disposed_recent_count, bk_disposed_historical_count) = NULL, NULL, sum(if(bk_disposed_recent_count = NULL, 0, bk_disposed_recent_count), if(bk_disposed_historical_count = NULL, 0, bk_disposed_historical_count))) > 0      => '2 - BK DISCHARGED',
    (Integer)bankrupt = 1 or filing_count > 0                                                                                                                                                                                                                                                                      => '3 - BK OTHER     ',
                                                                                                                                                                                                                                                                                                                      '0 - NO BK        '));
rv_d33_eviction_recency := map(
    not(truedid)                                                         => NULL,
    (boolean)attr_eviction_count90                                       => 3,
    (boolean)attr_eviction_count180                                      => 6,
    (boolean)attr_eviction_count12                                       => 12,
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2          => 24,
    (boolean)attr_eviction_count24                                       => 24,
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2          => 36,
    (boolean)attr_eviction_count36                                       => 37,
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2          => 60,
    (boolean)attr_eviction_count60                                       => 61,
    attr_eviction_count >= 2                                             => 98,
    attr_eviction_count >= 1                                             => 99,
                                                                            0);

rv_d33_eviction_count := if(not(truedid), NULL, min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 999));

iv_d34_liens_unrel_x_rel := __common__( if(not(truedid), '   ', trim((String)min(if(if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) = NULL, -NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct)))), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) = NULL, -NULL, if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count)))), 2), LEFT, RIGHT)));

earliest_bureau_date_all := if(ver_src_fdate_tn = NULL and ver_src_fdate_ts = NULL and ver_src_fdate_tu = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, if(max(ver_src_fdate_tn, ver_src_fdate_ts, ver_src_fdate_tu, ver_src_fdate_en, ver_src_fdate_eq) = NULL, NULL, min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq))));

nf_m_bureau_adl_fs_all := map(
    not(truedid)                    => NULL,
    earliest_bureau_date_all = NULL => -1,
                                       min(if(if ((sysdate - earliest_bureau_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_bureau_date_all) / (365.25 / 12)), roundup((sysdate - earliest_bureau_date_all) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - earliest_bureau_date_all) / (365.25 / 12) >= 0, truncate((sysdate - earliest_bureau_date_all) / (365.25 / 12)), roundup((sysdate - earliest_bureau_date_all) / (365.25 / 12)))), 999));

_header_first_seen := common.sas_date((string)(header_first_seen));

rv_c10_m_hdr_fs := map(
    not(truedid)              => NULL,
    _header_first_seen = NULL => -1,
                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));

rv_c12_source_profile := if(not(truedid), NULL, hdr_source_profile);

_in_dob_1 := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob_1 = NULL, -1, (sysdate - _in_dob_1) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

rv_comb_age := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

rv_a49_curr_avm_chg_1yr_pct := map(
    not(truedid)                                              => NULL,
    add_curr_lres < 12                                        => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_2 > 0 => round(100 * add_curr_avm_auto_val / add_curr_avm_auto_val_2/0.1)*0.1,
                                                                 NULL);

rv_f04_curr_add_occ_index := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);

rv_i60_inq_count12 := if(not(truedid), NULL, min(if(inq_count12 = NULL, -NULL, inq_count12), 999));

rv_i60_inq_hiriskcred_count12 := if(not(truedid), NULL, min(if(inq_highRiskCredit_count12 = NULL, -NULL, inq_highRiskCredit_count12), 999));

rv_i60_inq_hiriskcred_recency := map(
    not(truedid)               => NULL,
    (Boolean)inq_highRiskCredit_count01 => 1,
    (Boolean)inq_highRiskCredit_count03 => 3,
    (Boolean)inq_highRiskCredit_count06 => 6,
    (Boolean)inq_highRiskCredit_count12 => 12,
    (Boolean)inq_highRiskCredit_count24 => 24,
    (Boolean)inq_highRiskCredit_count   => 99,
                                  0);

rv_i60_inq_prepaidcards_recency := map(
    not(truedid)             => NULL,
    (Boolean)inq_PrepaidCards_count01 => 1,
    (Boolean)inq_PrepaidCards_count03 => 3,
    (Boolean)inq_PrepaidCards_count06 => 6,
    (Boolean)inq_PrepaidCards_count12 => 12,
    (Boolean)inq_PrepaidCards_count24 => 24,
    (Boolean)inq_PrepaidCards_count   => 99,
                                0);

rv_i60_inq_comm_recency := map(
    not(truedid)               => NULL,
    (Boolean)inq_communications_count01 => 1,
    (Boolean)inq_communications_count03 => 3,
    (Boolean)inq_communications_count06 => 6,
    (Boolean)inq_communications_count12 => 12,
    (Boolean)inq_communications_count24 => 24,
    (Boolean)inq_communications_count   => 99,
                                  0);                                  

rv_i60_inq_other_count12 := if(not(truedid), NULL, min(if(inq_other_count12 = NULL, -NULL, inq_other_count12), 999));

nf_inq_lname_ver_count := if(not(truedid), NULL, inq_lname_ver_count);

nf_inq_addr_ver_count := if(not(truedid), NULL, inq_addr_ver_count);

nf_inq_ssn_ver_count := if(not(truedid), NULL, inq_ssn_ver_count);

nf_inquiry_verification_index := __common__(  IF(NOT(truedid), NULL, 
                                    IF(MAX(POWER(2,0) * (INTEGER)(MAX(inq_fname_ver_count, inq_lname_ver_count) > 0), 
                                           POWER(2,1) * (INTEGER)(inq_phone_ver_count > 0), 
                                           POWER(2,2) * (INTEGER)(inq_addr_ver_count > 0), 
                                           POWER(2,3) * (INTEGER)(inq_dob_ver_count > 0), 
                                           POWER(2,4) * (INTEGER)(inq_ssn_ver_count > 0)) = NULL, NULL, 
                                    SUM(IF(POWER(2,0) * (INTEGER)(MAX(inq_fname_ver_count, inq_lname_ver_count) > 0) = NULL, 0, 
                                           POWER(2,0) * (INTEGER)(MAX(inq_fname_ver_count, inq_lname_ver_count) > 0)), 
                                        IF(POWER(2,1) * (INTEGER)(inq_phone_ver_count > 0) = NULL, 0, 
                                           POWER(2,1) * (INTEGER)(inq_phone_ver_count > 0)), 
                                        IF(POWER(2,2) * (INTEGER)(inq_addr_ver_count > 0) = NULL, 0, 
                                           POWER(2,2) * (INTEGER)(inq_addr_ver_count > 0)), 
                                        IF(POWER(2,3) * (INTEGER)(inq_dob_ver_count > 0) = NULL, 0, 
                                           POWER(2,3) * (INTEGER)(inq_dob_ver_count > 0)), 
                                        IF(POWER(2,4) * (INTEGER)(inq_ssn_ver_count > 0) = NULL, 0, 
                                           POWER(2,4) * (INTEGER)(inq_ssn_ver_count > 0))))));
                                           
nf_inq_count24 := if(not(truedid), NULL, min(if(inq_count24 = NULL, -NULL, inq_count24), 999));

nf_inq_banking_count_day := if(not(truedid), NULL, min(if(inq_Banking_count_day = NULL, -NULL, inq_Banking_count_day), 999));

nf_inq_collection_count24 := if(not(truedid), NULL, min(if(inq_Collection_count24 = NULL, -NULL, inq_Collection_count24), 999));

nf_inq_communications_count24 := if(not(truedid), NULL, min(if(inq_Communications_count24 = NULL, -NULL, inq_Communications_count24), 999));

nf_inq_highriskcredit_count24 := if(not(truedid), NULL, min(if(inq_HighRiskCredit_count24 = NULL, -NULL, inq_HighRiskCredit_count24), 999));

nf_inq_other_count24 := if(not(truedid), NULL, min(if(inq_Other_count24 = NULL, -NULL, inq_Other_count24), 999));

nf_inq_prepaidcards_count24 := if(not(truedid), NULL, min(if(inq_PrepaidCards_count24 = NULL, -NULL, inq_PrepaidCards_count24), 999));

nf_inq_perbestssn_count12 := if(not(truedid), NULL, min(if(inq_perbestssn = NULL, -NULL, inq_perbestssn), 999));

rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

rv_l79_adls_per_sfd_addr_c6 := map(
    not(addrpop)   => NULL,
    iv_add_apt = '1' => -1,
                      min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));                      

rv_c13_attr_addrs_recency := map(
    not(truedid)      => NULL,
    (Boolean)attr_addrs_last30 => 1,
    (Boolean)attr_addrs_last90 => 3,
    (Boolean)attr_addrs_last12 => 12,
    (Boolean)attr_addrs_last24 => 24,
    (Boolean)attr_addrs_last36 => 36,
    (Boolean)addrs_5yr         => 60,
    (Boolean)addrs_10yr        => 120,
    (Boolean)addrs_15yr        => 180,
    (INTEGER)addrs_per_adl > 0 => 999,
                         0);

iv_addr_non_phn_src_ct := if(not(truedid and add_input_pop), NULL, min(if(rc_addrcount = NULL, -NULL, rc_addrcount), 999));

mortgage_type := if(truedid and add_curr_pop, (string10)add_curr_mortgage_type, '');

mortgage_present := __common__(if(truedid and add_curr_pop, not((add_curr_mortgage_date in [0, NULL])), False));

iv_curr_add_mortgage_type := map(
    not(truedid and add_curr_pop)                         => '',
    (mortgage_type in ['CNV', 'N'])                       => 'CONVENTIONAL   ',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'GOVERNMENT     ',
    (mortgage_type in ['1', 'D'])                         => 'PIGGYBACK      ',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'EQUITY LOAN    ',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'COMMERCIAL     ',
    (mortgage_type in ['H', 'J'])                         => 'HIGH-RISK      ',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'NON-TRADITIONAL',
    (mortgage_type in ['U'])                              => 'UNKNOWN        ',
    not(mortgage_type = '')                               => 'OTHER          ',
    mortgage_present                                      => 'UNKNOWN        ',
                                                             'NO MORTGAGE');
                                                             
rv_a49_curr_add_avm_pct_chg_2yr := map(
    not(add_curr_pop)                                         => NULL,
    add_curr_lres < 12 * 2                                    => NULL,
    add_curr_avm_auto_val > 0 and add_curr_avm_auto_val_3 > 0 => round(add_curr_avm_auto_val / add_curr_avm_auto_val_3/.01)*.01,
                                                                 NULL);

iv_prv_addr_lres := if(not(truedid and add_prev_pop), NULL, min(if(add_prev_lres = NULL, -NULL, add_prev_lres), 999));

iv_prv_addr_avm_auto_val := if(not(add_prev_pop) and add_prev_naprop = 4, NULL, add_prev_avm_auto_val);

nf_addrs_per_bestssn := if(best_ssn_valid = '7' or not(truedid), NULL, min(if(addrs_per_bestssn = NULL, -NULL, addrs_per_bestssn), 999));

nf_addrs_per_bestssn_c6 := if(best_ssn_valid = '7' or not(truedid), NULL, min(if(addrs_per_bestssn_c6 = NULL, -NULL, addrs_per_bestssn_c6), 999));

nf_adls_per_curraddr_c6 := if(not(add_curr_pop) or not(truedid), NULL, min(if(adls_per_curraddr_c6 = NULL, -NULL, adls_per_curraddr_c6), 999));

nf_ssns_per_curraddr_c6 := if(not(add_curr_pop) or not(truedid), NULL, min(if(ssns_per_curraddr_c6 = NULL, -NULL, ssns_per_curraddr_c6), 999));

iv_unverified_addr_count := if(not(truedid), NULL, min(if(unverified_addr_count = NULL, -NULL, unverified_addr_count), 999));

nf_bus_addr_match_count := if(not(addrpop), NULL, bus_addr_match_count);

nf_util_adl_summary := map(
    not(truedid)                                => '',
    util_type_1 and util_type_2 and util_type_z => 'ICM',
    util_type_1 and util_type_2                 => 'IC',
    util_type_1 and util_type_z                 => 'IM',
    util_type_2 and util_type_z                 => 'CM',
    util_type_1                                 => 'I',
    util_type_2                                 => 'C',
    util_type_z                                 => 'M', 
                                                      '');

nf_phones_per_addr_curr := if(not(addrpop), NULL, min(if(phones_per_addr_curr = NULL, -NULL, phones_per_addr_curr), 999));

nf_addrs_per_ssn_c6 := __common__( if(not(ssnlength > '0'), NULL, min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 999)));

nf_attr_arrests := if(not(truedid), NULL, min(if(attr_arrests = NULL, -NULL, attr_arrests), 999));

iv_estimated_income := if(not(TrueDID), NULL, estimated_income);

iv_wealth_index := __common__( if(not(truedid), NULL, (Integer)wealth_index));

nf_hh_pct_property_owners := map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         hh_property_owners_ct / hh_members_ct);

nf_hh_collections_ct := if(not(truedid), NULL, min(if(hh_collections_ct = NULL, -NULL, hh_collections_ct), 999));

nf_hh_lienholders_pct := map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         hh_lienholders / hh_members_ct);

nf_average_rel_income := map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 => -1,
    if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     if (if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) >= 0, truncate(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count)))), roundup(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))))) * 1000);

nf_average_rel_age := map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              => -1,
    if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  if (if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))) >= 0, truncate(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count)))), roundup(if(max(rel_ageunder20_count * 20, rel_ageunder30_count * 30, rel_ageunder40_count * 40, rel_ageunder50_count * 50, rel_ageunder60_count * 60, rel_ageunder70_count * 70, rel_ageover70_count * 80) = NULL, NULL, sum(if(rel_ageunder20_count * 20 = NULL, 0, rel_ageunder20_count * 20), if(rel_ageunder30_count * 30 = NULL, 0, rel_ageunder30_count * 30), if(rel_ageunder40_count * 40 = NULL, 0, rel_ageunder40_count * 40), if(rel_ageunder50_count * 50 = NULL, 0, rel_ageunder50_count * 50), if(rel_ageunder60_count * 60 = NULL, 0, rel_ageunder60_count * 60), if(rel_ageunder70_count * 70 = NULL, 0, rel_ageunder70_count * 70), if(rel_ageover70_count * 80 = NULL, 0, rel_ageover70_count * 80))) / if(max(rel_ageunder20_count, rel_ageunder30_count, rel_ageunder40_count, rel_ageunder50_count, rel_ageunder60_count, rel_ageunder70_count, rel_ageover70_count) = NULL, NULL, sum(if(rel_ageunder20_count = NULL, 0, rel_ageunder20_count), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count), if(rel_ageover70_count = NULL, 0, rel_ageover70_count))))));

nf_pct_rel_with_felony := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_felony_count / rel_count);

nf_pct_rel_prop_owned := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_prop_owned_count / rel_count);

nf_pct_rel_prop_sold := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_prop_sold_count / rel_count);

nf_historic_x_current_ct := if(not(truedid), '', trim((String)min(if(historical_count = NULL, -NULL, historical_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((String)min(if(current_count = NULL, -NULL, current_count), 3), LEFT, RIGHT));

nf_fp_sourcerisktype := if(not(truedid), NULL, (INTEGER)fp_sourcerisktype);

nf_fp_varrisktype := if(not(truedid), NULL, (INTEGER)fp_varrisktype);

nf_fp_srchvelocityrisktype := if(not(truedid), NULL, (INTEGER)fp_srchvelocityrisktype);

nf_fp_srchunvrfdssncount :=  __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdssncount = '', -NULL, (Integer)fp_srchunvrfdssncount), 999)));

nf_fp_srchunvrfdaddrcount := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdaddrcount = '', -NULL, (Integer)fp_srchunvrfdaddrcount), 999)));

nf_fp_srchunvrfdphonecount := __common__( if(not(truedid), NULL, min(if(fp_srchunvrfdphonecount = '', -NULL, (Integer)fp_srchunvrfdphonecount), 999)));

nf_unvrfd_search_risk_index := if(not(truedid), NULL, if(max((integer)(fp_srchunvrfdphonecount > '0') +
    2 * (integer)(fp_srchunvrfddobcount > '0') +
    4 * (integer)(fp_srchunvrfdaddrcount > '0') +
    8 * (integer)(fp_srchunvrfdssncount > '0')) = NULL, NULL, sum(if((integer)(fp_srchunvrfdphonecount > '0') +
    2 * (integer)(fp_srchunvrfddobcount > '0') +
    4 * (integer)(fp_srchunvrfdaddrcount > '0') +
    8 * (integer)(fp_srchunvrfdssncount > '0') = NULL, NULL, (integer)(fp_srchunvrfdphonecount > '0') +
    2 * (integer)(fp_srchunvrfddobcount > '0') +
    4 * (integer)(fp_srchunvrfdaddrcount > '0') +
    8 * (integer)(fp_srchunvrfdssncount > '0'))))); 

nf_fp_srchfraudsrchcountyr := __common__( if(not(truedid), NULL, min(if(fp_srchfraudsrchcountyr = '', -NULL, (Integer)fp_srchfraudsrchcountyr), 999)));

nf_fp_assocrisktype := __common__( map(
    not(truedid)            => NULL,
    (integer)fp_assocrisktype = NULL => NULL,
                               (integer)fp_assocrisktype) );

nf_fp_divrisktype := __common__( map(
    not(truedid)            => NULL,
    (integer)fp_divrisktype = NULL => NULL,
                               (integer)fp_divrisktype) );

nf_fp_divaddrsuspidcountnew := __common__( if(not(truedid), NULL, min(if(fp_divaddrsuspidcountnew = '', -NULL, (Integer)fp_divaddrsuspidcountnew), 999)));

nf_fp_srchcomponentrisktype := __common__( map(
    not(truedid)            => NULL,
    (integer)fp_srchcomponentrisktype = NULL => NULL,
                               (integer)fp_srchcomponentrisktype) );
                               
nf_fp_srchaddrsrchcountmo := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountmo = '', -NULL, (Integer)fp_srchaddrsrchcountmo), 999)));

nf_fp_srchaddrsrchcountday := __common__( if(not(truedid), NULL, min(if(fp_srchaddrsrchcountday = '', -NULL, (Integer)fp_srchaddrsrchcountday), 999)));

nf_fp_curraddrmedianincome := __common__( if(not(truedid), NULL, (Integer)fp_curraddrmedianincome));

nf_fp_curraddrmedianvalue := __common__( if(not(truedid), NULL, (Integer)fp_curraddrmedianvalue));

nf_fp_curraddrcartheftindex := __common__( if(not(truedid), NULL, (Integer)fp_curraddrcartheftindex));

nf_fp_curraddrburglaryindex := __common__( if(not(truedid), NULL, (Integer)fp_curraddrburglaryindex));

nf_fp_curraddrcrimeindex := __common__( if(not(truedid), NULL, (Integer)fp_curraddrcrimeindex));

nf_fp_prevaddrcartheftindex := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrcartheftindex));

nf_fp_prevaddrcrimeindex := __common__( if(not(truedid), NULL, (Integer)fp_prevaddrcrimeindex));

_in_dob := common.sas_date((string)(in_dob));

earliest_bureau_date := if(ver_src_fdate_tn = NULL and ver_src_fdate_ts = NULL and ver_src_fdate_tu = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, if(max(ver_src_fdate_tn, ver_src_fdate_ts, ver_src_fdate_tu, ver_src_fdate_en, ver_src_fdate_eq) = NULL, NULL, min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq))));

earliest_bureau_yrs := if(earliest_bureau_date = NULL or sysdate = NULL, NULL, if ((sysdate - earliest_bureau_date) / 365.25 >= 0, roundup((sysdate - earliest_bureau_date) / 365.25), truncate((sysdate - earliest_bureau_date) / 365.25)));

calc_dob := if(_in_dob = NULL, NULL, if ((sysdate - _in_dob) / 365.25 >= 0, roundup((sysdate - _in_dob) / 365.25), truncate((sysdate - _in_dob) / 365.25)));

iv_bureau_emergence_age := map(
    not(truedid) or earliest_bureau_yrs = NULL => NULL,
    not(calc_dob = NULL)                       => calc_dob - earliest_bureau_yrs,
    inferred_age = 0                           => NULL,
                                                  inferred_age - earliest_bureau_yrs);

vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , ', ', 'E');

vote_adl_lseen_vo := if(vo_pos > 0, Models.Common.getw(ver_sources_last_seen, vo_pos, ', '), '');

_vote_adl_lseen_vo := common.sas_date((string)(vote_adl_lseen_vo));

iv_mos_src_voter_adl_lseen := map(
    not(truedid)              => NULL,
    not(voter_avail)          => -1,
    _vote_adl_lseen_vo = NULL => -1,
                                 if ((sysdate - _vote_adl_lseen_vo) / (365.25 / 12) >= 0, truncate((sysdate - _vote_adl_lseen_vo) / (365.25 / 12)), roundup((sysdate - _vote_adl_lseen_vo) / (365.25 / 12))));

_ver_src_ds_1 := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0);

_ver_src_de_1 := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0);

_ver_src_eq_1 := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0);

_ver_src_en_1 := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0);

_ver_src_tn_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0);

_ver_src_tu_1 := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0);

_credit_source_cnt_1 := if(max((integer)_ver_src_eq_1, (integer)_ver_src_en_1, (integer)_ver_src_tn_1, (integer)_ver_src_tu_1) = NULL, NULL, sum((integer)_ver_src_eq_1, (integer)_ver_src_en_1, (integer)_ver_src_tn_1, (integer)_ver_src_tu_1));

_ver_src_cnt_1 := Models.Common.countw((string)(ver_sources), ' !$%&()*+,-./;<^|');

_bureauonly_1 := _credit_source_cnt_1 > 0 AND _credit_source_cnt_1 = _ver_src_cnt_1 AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_deceased_1 := __common__( rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds_1 OR _ver_src_de_1);

_ssnpriortodob_1 := __common__( rc_ssndobflag = '1' OR rc_pwssndobflag = '1');

_inputmiskeys_1 := __common__( rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0);

_multiplessns_1 := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes_1 :=  sum((integer)(hh_members_w_derog > 0), (integer)(hh_criminals > 0), (integer)(hh_payday_loan_users > 0));

_derog := __common__(  felony_count > 0 
       OR (INTEGER)addrs_prison_history > 0 
       OR attr_num_unrel_liens60 > 0 
       OR attr_eviction_count > 0 
       OR stl_inq_count > 0 
       OR inq_highriskcredit_count12 > 0 
       OR inq_collection_count12 >= 2);

nf_seg_fraudpoint_3_0 := map(
    addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and ssnlength = '9' or _deceased_1 or _ssnpriortodob_1 				=> '1: Stolen/Manip ID  ',
    _inputmiskeys_1 and (_multiplessns_1 or lnames_per_adl_c6 > 1)                                                                                                                                 					=> '1: Stolen/Manip ID  ',
    fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt_1 = 0 or _bureauonly_1 or (not add_curr_pop)                        				=> '2: Synth ID         ',
    _derog                                                                                                                                                                                        				=> '3: Derog            ',
    Inq_count03 > 0 or Inq_count12 >= 4 or (integer)fp_srchfraudsrchcountyr >= 1 or (integer)fp_srchssnsrchcountmo >= 1 or (integer)fp_srchaddrsrchcountmo >= 1 or (integer)fp_srchphonesrchcountmo >= 1   => '4: Recent Activity  ',
    0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70                                                                                                                                 					 => '5: Vuln Vic/Friendly',
    hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes_1 >= 2 or rel_felony_count >= 2)                                                                                                					=> '5: Vuln Vic/Friendly',
																																																																																																						'6: Other            ');

nf_inq_per_addr := if(not(addrpop), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

nf_inquiry_adl_vel_risk_index := __common__(  IF(NOT(truedid), NULL, 
                                 IF(MAX(POWER(2,0) * (INTEGER)(inq_addrsperadl > 2), 
                                        POWER(2,1) * (INTEGER)(inq_fnamesperadl > 2),
                                        POWER(2,2) * (INTEGER)(inq_ssnsperadl > 2), 
                                        POWER(2,3) * (INTEGER)(inq_phonesperadl > 2), 
                                        POWER(2,4) * (INTEGER)(inq_peradl > 2)) = NULL, NULL, 
                                 SUM(IF(POWER(2,0) * (INTEGER)(inq_addrsperadl > 2) = NULL, 0, 
                                        POWER(2,0) * (INTEGER)(inq_addrsperadl > 2)), 
                                     IF(POWER(2,1) * (INTEGER)(inq_fnamesperadl > 2) = NULL, 0, 
                                        POWER(2,1) * (INTEGER)(inq_fnamesperadl > 2)), 
                                     IF(POWER(2,2) * (INTEGER)(inq_ssnsperadl > 2) = NULL, 0, 
                                        POWER(2,2) * (INTEGER)(inq_ssnsperadl > 2)), 
                                     IF(POWER(2,3) * (INTEGER)(inq_phonesperadl > 2) = NULL, 0, 
                                        POWER(2,3) * (INTEGER)(inq_phonesperadl > 2)), 
                                     IF(POWER(2,4) * (INTEGER)(inq_peradl > 2) = NULL, 0, 
                                        POWER(2,4) * (INTEGER)(inq_peradl > 2))))));
                                        
nf_inq_lnamesperaddr_count12 := if(not(truedid), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

nf_inq_peraddr_count12 := if(not(truedid), NULL, min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999));

nf_inq_perssn_count_week := if(not(truedid), NULL, min(if(inq_perssn_count_week = NULL, -NULL, inq_perssn_count_week), 999));

nf_inq_perssn_count12 := if(not(truedid), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

nf_inquiry_addr_vel_risk_index := __common__(  IF(NOT(addrpop), -1, 
                                  IF(MAX(POWER(2,0) * (INTEGER)(inq_peraddr > 2), 
                                         POWER(2,1) * (INTEGER)(inq_adlsperaddr > 2), 
                                         POWER(2,2) * (INTEGER)(inq_lnamesperaddr > 2)) = NULL, NULL, 
                                  SUM(IF(POWER(2,0) * (INTEGER)(inq_peraddr > 2) = NULL, 0, 
                                         POWER(2,0) * (INTEGER)(inq_peraddr > 2)), 
                                      IF(POWER(2,1) * (INTEGER)(inq_adlsperaddr > 2) = NULL, 0, 
                                         POWER(2,1) * (INTEGER)(inq_adlsperaddr > 2)), 
                                      IF(POWER(2,2) * (INTEGER)(inq_lnamesperaddr > 2) = NULL, 0, 
                                         POWER(2,2) * (INTEGER)(inq_lnamesperaddr > 2))))));
                                         
nf_inquiry_addr_vel_risk_indexv2 := map(
    not(addrpop)                               => -1,
    nf_inquiry_addr_vel_risk_index = 0         => 0,
    nf_inquiry_addr_vel_risk_index = 1         => 1,
    (nf_inquiry_addr_vel_risk_index in [3, 5]) => 2,
    (nf_inquiry_addr_vel_risk_index in [2, 4]) => 3,
                                                  4);
nf_inq_per_sfd_addr := __common__( map(
    not(addrpop)     => NULL,
    iv_add_apt = '1' => -1,
       min(if(inq_peraddr = NULL, -NULL, inq_peraddr), 999)));
       
nf_invbest_inq_adlsperaddr_diff := map(
                                        not(truedid) or (INTEGER)addrpop = 0    => NULL,
                                        (INTEGER)add_input_isbestmatch = 1   => -1,
                                          inq_peraddr - inq_adlspercurraddr);                                   

nf_inq_adls_per_addr := if(not(addrpop), NULL, min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));

nf_inq_lnames_per_addr := if(not(addrpop), NULL, min(if(inq_lnamesperaddr = NULL, -NULL, inq_lnamesperaddr), 999));

nf_inq_adls_per_apt_addr := map(
    not(addrpop)                      => NULL,
    not((boolean)(integer)iv_add_apt) => -1,
                                         min(if(inq_adlsperaddr = NULL, -NULL, inq_adlsperaddr), 999));
nf_inq_per_ssn := if(not(ssnlength > '0'), NULL, min(if(inq_perssn = NULL, -NULL, inq_perssn), 999));

nf_inq_lnamesperaddr_recency := map(
    not(truedid)              => NULL,
    (Boolean)inq_lnamesperaddr_count01 => 1,
    (Boolean)inq_lnamesperaddr_count03 => 3,
    (Boolean)inq_lnamesperaddr_count06 => 6,
    (Boolean)inq_lnamesperaddr         => 12,
                                 0);

final_score_tree_0 := -2.1773388359;

final_score_tree_1_c275 := map(
    NULL < nf_inquiry_verification_index AND nf_inquiry_verification_index < 30.5 => 0.0400870733,
    nf_inquiry_verification_index >= 30.5                                         => 0.1721690881,
    nf_inquiry_verification_index = NULL                                          => 0.1280060724,
                                                                                     0.1280060724);

final_score_tree_1_c274 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 3.5 => 0.0341654313,
    nf_fp_varrisktype >= 3.5                             => final_score_tree_1_c275,
    nf_fp_varrisktype = NULL                             => 0.0563198788,
                                                            0.0563198788);

final_score_tree_1 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0299751691,
    rv_i60_inq_comm_recency >= 0.5                                   => final_score_tree_1_c274,
    rv_i60_inq_comm_recency = NULL                                   => -0.0387903802,
                                                                        0.0005645307);

final_score_tree_2_c278 := map(
    c_civ_emp = ''                       => 0.0288318381,
    NULL < (REAL)c_civ_emp AND (REAL)c_civ_emp < 47.15 => 0.0886634366,
    (REAL)c_civ_emp >= 47.15                     => 0.0168594717,
    (REAL)c_civ_emp = NULL                       => 0.0288318381,
                                              0.0288318381);

final_score_tree_2_c277 := map(
    NULL < nf_inquiry_adl_vel_risk_index AND nf_inquiry_adl_vel_risk_index < 16.5 => final_score_tree_2_c278,
    nf_inquiry_adl_vel_risk_index >= 16.5                                         => 0.1252566988,
    nf_inquiry_adl_vel_risk_index = NULL                                          => 0.0437559557,
                                                                                     0.0437559557);

final_score_tree_2 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0304927593,
    rv_i60_inq_comm_recency >= 0.5                                   => final_score_tree_2_c277,
    rv_i60_inq_comm_recency = NULL                                   => -0.0301420505,
                                                                        -0.0033960956);

final_score_tree_3_c281 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '6: Other']) => 0.0569185157,
    (nf_seg_fraudpoint_3_0 in ['3: Derog', '5: Vuln Vic/Friendly'])                                    => 0.1552820807,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                       => 0.1035819539,
                                                                                                          0.1035819539);

final_score_tree_3_c280 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 3.5 => 0.0261955952,
    nf_fp_varrisktype >= 3.5                             => final_score_tree_3_c281,
    nf_fp_varrisktype = NULL                             => 0.0447392769,
                                                            0.0447392769);

final_score_tree_3 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0294735364,
    rv_i60_inq_comm_recency >= 0.5                                   => final_score_tree_3_c280,
    rv_i60_inq_comm_recency = NULL                                   => -0.0367668638,
                                                                        -0.0029865597);

final_score_tree_4_c283 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 0.5 => -0.0246374002,
    rv_i60_inq_hiriskcred_count12 >= 0.5                                         => 0.0645591080,
    rv_i60_inq_hiriskcred_count12 = NULL                                         => -0.0180324356,
                                                                                    -0.0180324356);

final_score_tree_4_c284 := map(
    NULL < nf_inq_count24 AND nf_inq_count24 < 11.5 => 0.0566567126,
    nf_inq_count24 >= 11.5                          => 0.1522185051,
    nf_inq_count24 = NULL                           => 0.0697878202,
                                                       0.0697878202);

final_score_tree_4 := map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 0.5 => final_score_tree_4_c283,
    nf_inq_communications_count24 >= 0.5                                         => final_score_tree_4_c284,
    nf_inq_communications_count24 = NULL                                         => -0.0273124242,
                                                                                    -0.0009125534);

final_score_tree_5_c287 := map(
    NULL < nf_average_rel_income AND nf_average_rel_income < 60500 => 0.0482789021,
    nf_average_rel_income >= 60500                                 => -0.0070368297,
    nf_average_rel_income = NULL                                   => 0.0253703667,
                                                                      0.0253703667);

final_score_tree_5_c286 := map(
    NULL < nf_inq_count24 AND nf_inq_count24 < 9.5 => final_score_tree_5_c287,
    nf_inq_count24 >= 9.5                          => 0.1026953540,
    nf_inq_count24 = NULL                          => 0.0363928748,
                                                      0.0363928748);

final_score_tree_5 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0290662076,
    rv_i60_inq_comm_recency >= 0.5                                   => final_score_tree_5_c286,
    rv_i60_inq_comm_recency = NULL                                   => -0.0346660174,
                                                                        -0.0056823006);

final_score_tree_6_c290 := map(
     c_totcrime = ''                      => 0.0220761971,
     NULL < (REAL)c_totcrime AND (REAL)c_totcrime < 136 => -0.0000453292,
    (REAL)c_totcrime >= 136                      => 0.0517181627,
    (REAL)c_totcrime = NULL                      => 0.0220761971,
                                              0.0220761971);

final_score_tree_6_c289 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 4.5 => final_score_tree_6_c290,
    nf_fp_varrisktype >= 4.5                             => 0.0907175154,
    nf_fp_varrisktype = NULL                             => 0.0331749177,
                                                            0.0331749177);

final_score_tree_6 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0273807660,
    rv_i60_inq_comm_recency >= 0.5                                   => final_score_tree_6_c289,
    rv_i60_inq_comm_recency = NULL                                   => -0.0266816914,
                                                                        -0.0052964829);

final_score_tree_7_c292 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 3.5 => -0.0250655458,
    nf_fp_varrisktype >= 3.5                             => 0.0401359664,
    nf_fp_varrisktype = NULL                             => -0.0187466936,
                                                            -0.0187466936);

final_score_tree_7_c293 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 0.5 => 0.0263873298,
    rv_i60_inq_hiriskcred_recency >= 0.5                                         => 0.0791801828,
    rv_i60_inq_hiriskcred_recency = NULL                                         => 0.0490028358,
                                                                                    0.0490028358);

final_score_tree_7 := map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 0.5 => final_score_tree_7_c292,
    nf_inq_communications_count24 >= 0.5                                         => final_score_tree_7_c293,
    nf_inq_communications_count24 = NULL                                         => -0.0382444427,
                                                                                    -0.0059083771);

final_score_tree_8_c296 := map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 18 => 0.0042318765,
    rv_i60_inq_prepaidcards_recency >= 18                                           => 0.0688429138,
    rv_i60_inq_prepaidcards_recency = NULL                                          => 0.0156548223,
                                                                                       0.0156548223);

final_score_tree_8_c295 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0310794721,
    rv_i60_inq_comm_recency >= 0.5                                   => final_score_tree_8_c296,
    rv_i60_inq_comm_recency = NULL                                   => -0.0159495142,
                                                                        -0.0159495142);

final_score_tree_8 := map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount < 1.5 => final_score_tree_8_c295,
    nf_fp_srchunvrfdphonecount >= 1.5                                      => 0.0654111881,
    nf_fp_srchunvrfdphonecount = NULL                                      => -0.0339581902,
                                                                              -0.0073575493);

final_score_tree_9_c298 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0287991717,
    rv_i60_inq_comm_recency >= 0.5                                   => 0.0166264021,
    rv_i60_inq_comm_recency = NULL                                   => -0.0140143060,
                                                                        -0.0140143060);

final_score_tree_9_c299 := map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 < 2.5 => 0.0387946945,
    nf_inq_other_count24 >= 2.5                                => 0.0936706862,
    nf_inq_other_count24 = NULL                                => 0.0639544452,
                                                                  0.0639544452);

final_score_tree_9 := map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount < 1.5 => final_score_tree_9_c298,
    nf_fp_srchunvrfdphonecount >= 1.5                                      => final_score_tree_9_c299,
    nf_fp_srchunvrfdphonecount = NULL                                      => -0.0263862025,
                                                                              -0.0058565887);

final_score_tree_10_c301 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0335150114,
    rv_i60_inq_comm_recency >= 0.5                                   => 0.0138972000,
    rv_i60_inq_comm_recency = NULL                                   => -0.0199426873,
                                                                        -0.0199426873);

final_score_tree_10_c302 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 2.5 => 0.0220641301,
    nf_fp_varrisktype >= 2.5                             => 0.0699230939,
    nf_fp_varrisktype = NULL                             => 0.0426911863,
                                                            0.0426911863);

final_score_tree_10 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 0.5 => final_score_tree_10_c301,
    rv_i60_inq_hiriskcred_recency >= 0.5                                         => final_score_tree_10_c302,
    rv_i60_inq_hiriskcred_recency = NULL                                         => -0.0323563275,
                                                                                    -0.0053855465);

final_score_tree_11_c304 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => -0.0273395549,
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '3: Derog'])                                                      => 0.0205104489,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                                => -0.0146682817,
                                                                                                                   -0.0146682817);

final_score_tree_11_c305 := map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 6 => 0.0267355467,
    rv_i60_inq_prepaidcards_recency >= 6                                           => 0.0797992988,
    rv_i60_inq_prepaidcards_recency = NULL                                         => 0.0383664424,
                                                                                      0.0383664424);

final_score_tree_11 := map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 0.5 => final_score_tree_11_c304,
    nf_inq_communications_count24 >= 0.5                                         => final_score_tree_11_c305,
    nf_inq_communications_count24 = NULL                                         => -0.0342370144,
                                                                                    -0.0047230384);

final_score_tree_12_c308 := map(
    NULL < nf_hh_pct_property_owners AND nf_hh_pct_property_owners < 0.21825396825 => 0.0772893749,
    nf_hh_pct_property_owners >= 0.21825396825                                     => -0.0047424776,
    nf_hh_pct_property_owners = NULL                                               => 0.0469164280,
                                                                                      0.0469164280);

final_score_tree_12_c307 := map(
    c_unemp = ''                     => -0.0121100848, 
     NULL < (REAL)c_unemp AND (REAL)c_unemp < 10.45 => -0.0185279155,
    (REAL)c_unemp >= 10.45                   => final_score_tree_12_c308,
    (REAL)c_unemp = NULL                     => -0.0121100848,
                                          -0.0121100848);

final_score_tree_12 := map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount < 1.5 => final_score_tree_12_c307,
    nf_fp_srchunvrfdphonecount >= 1.5                                      => 0.0521206897,
    nf_fp_srchunvrfdphonecount = NULL                                      => -0.0297462814,
                                                                              -0.0056107679);

final_score_tree_13_c310 := map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr < 7.5 => -0.0200501936,
    nf_inq_per_addr >= 7.5                           => 0.0576591268,
    nf_inq_per_addr = NULL                           => -0.0155901978,
                                                        -0.0155901978);

final_score_tree_13_c311 := map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 < 2.5 => 0.0210099014,
    nf_inq_other_count24 >= 2.5                                => 0.0581593105,
    nf_inq_other_count24 = NULL                                => 0.0308803987,
                                                                  0.0308803987);

final_score_tree_13 := map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 0.5 => final_score_tree_13_c310,
    nf_inq_communications_count24 >= 0.5                                         => final_score_tree_13_c311,
    nf_inq_communications_count24 = NULL                                         => -0.0305393711,
                                                                                    -0.0067975225);

final_score_tree_14_c313 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => -0.0278756667,
    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                                                                                    => 0.0172631205,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                                               => -0.0164355741,
                                                                                                                                  -0.0164355741);

final_score_tree_14_c314 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 3.5 => 0.0199339862,
    nf_fp_varrisktype >= 3.5                             => 0.0535083016,
    nf_fp_varrisktype = NULL                             => 0.0307996076,
                                                            0.0307996076);

final_score_tree_14 := map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 0.5 => final_score_tree_14_c313,
    nf_inq_communications_count24 >= 0.5                                         => final_score_tree_14_c314,
    nf_inq_communications_count24 = NULL                                         => -0.0268142850,
                                                                                    -0.0075932183);

final_score_tree_15_c316 := map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr < 17.5 => -0.0159661041,
    nf_inq_per_addr >= 17.5                           => 0.1259442963,
    nf_inq_per_addr = NULL                            => -0.0145856072,
                                                         -0.0145856072);

final_score_tree_15_c317 := map(
    NULL < nf_inquiry_addr_vel_risk_indexv2 AND nf_inquiry_addr_vel_risk_indexv2 < 3 => 0.0259442523,
    nf_inquiry_addr_vel_risk_indexv2 >= 3                                            => 0.0927780361,
    nf_inquiry_addr_vel_risk_indexv2 = NULL                                          => 0.0326987305,
                                                                                        0.0326987305);

final_score_tree_15 := map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 0.5 => final_score_tree_15_c316,
    nf_inq_communications_count24 >= 0.5                                         => final_score_tree_15_c317,
    nf_inq_communications_count24 = NULL                                         => -0.0223170915,
                                                                                    -0.0055271357);

final_score_tree_16_c319 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 30500 => 0.0091685184,
    iv_estimated_income >= 30500                               => -0.0306311474,
    iv_estimated_income = NULL                                 => -0.0174018055,
                                                                  -0.0174018055);

final_score_tree_16_c320 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 2.5 => 0.0206320092,
    rv_l79_adls_per_sfd_addr_c6 >= 2.5                                       => 0.0732398067,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                       => 0.0296221288,
                                                                                0.0296221288);

final_score_tree_16 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 0.5 => final_score_tree_16_c319,
    rv_i60_inq_hiriskcred_recency >= 0.5                                         => final_score_tree_16_c320,
    rv_i60_inq_hiriskcred_recency = NULL                                         => -0.0335794383,
                                                                                    -0.0064435589);

final_score_tree_17_c322 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0224491134,
    rv_f03_input_add_not_most_rec >= 0.5                                         => 0.0395895769,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0148168832,
                                                                                    -0.0148168832);

final_score_tree_17_c323 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 4.5 => 0.0204638953,
    nf_fp_varrisktype >= 4.5                             => 0.0544949777,
    nf_fp_varrisktype = NULL                             => 0.0279258602,
                                                            0.0279258602);

final_score_tree_17 := map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 0.5 => final_score_tree_17_c322,
    nf_inq_communications_count24 >= 0.5                                         => final_score_tree_17_c323,
    nf_inq_communications_count24 = NULL                                         => -0.0303009829,
                                                                                    -0.0067741273);

final_score_tree_18_c325 := map(
    NULL < nf_pct_rel_prop_owned AND nf_pct_rel_prop_owned < 0.42365967365 => 0.0133967720,
    nf_pct_rel_prop_owned >= 0.42365967365                                 => -0.0294255134,
    nf_pct_rel_prop_owned = NULL                                           => -0.0129599779,
                                                                              -0.0129599779);

final_score_tree_18_c326 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 15.5 => 0.0295937075,
    rv_d30_derog_count >= 15.5                              => 0.1272631984,
    rv_d30_derog_count = NULL                               => 0.0342919624,
                                                               0.0342919624);

final_score_tree_18 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 3.5 => final_score_tree_18_c325,
    nf_fp_varrisktype >= 3.5                             => final_score_tree_18_c326,
    nf_fp_varrisktype = NULL                             => -0.0210649763,
                                                            -0.0065112468);

final_score_tree_19_c329 := map(
    NULL < nf_fp_prevaddrcartheftindex AND nf_fp_prevaddrcartheftindex < 151.5 => 0.0025308608,
    nf_fp_prevaddrcartheftindex >= 151.5                                       => 0.0731555024,
    nf_fp_prevaddrcartheftindex = NULL                                         => 0.0366704477,
                                                                                  0.0366704477);

final_score_tree_19_c328 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 25500 => final_score_tree_19_c329,
    iv_estimated_income >= 25500                               => -0.0166221400,
    iv_estimated_income = NULL                                 => -0.0080165739,
                                                                  -0.0080165739);

final_score_tree_19 := map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount < 1.5 => final_score_tree_19_c328,
    nf_fp_srchunvrfdphonecount >= 1.5                                      => 0.0393487894,
    nf_fp_srchunvrfdphonecount = NULL                                      => -0.0267064660,
                                                                              -0.0032359465);

final_score_tree_20_c332 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 20500 => 0.0740525839,
    iv_estimated_income >= 20500                               => -0.0040235797,
    iv_estimated_income = NULL                                 => 0.0021870242,
                                                                  0.0021870242);

final_score_tree_20_c331 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => final_score_tree_20_c332,
    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                                                                                    => 0.0402833249,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                                               => 0.0187547697,
                                                                                                                                  0.0187547697);

final_score_tree_20 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0226228867,
    rv_i60_inq_comm_recency >= 0.5                                   => final_score_tree_20_c331,
    rv_i60_inq_comm_recency = NULL                                   => -0.0115656568,
                                                                        -0.0073864982);

final_score_tree_21_c334 := map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr < 10.5 => -0.0123127753,
    nf_inq_per_addr >= 10.5                           => 0.0499481878,
    nf_inq_per_addr = NULL                            => -0.0099572118,
                                                         -0.0099572118);

final_score_tree_21_c335 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '3-0']) => 0.0342345581,
    (rv_d32_criminal_x_felony in ['1-1', '2-2', '3-1', '3-2', '3-3']) => 0.1798119454,
    (REAL)rv_d32_criminal_x_felony = NULL                                   => 0.0437569640,
                                                                         0.0437569640);

final_score_tree_21 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_21_c334,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_21_c335,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0244505626,
                                                                                    -0.0032324161);

final_score_tree_22_c337 := map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 0.5 => -0.0173612236,
    nf_inq_highriskcredit_count24 >= 0.5                                         => 0.0259969172,
    nf_inq_highriskcredit_count24 = NULL                                         => -0.0122900960,
                                                                                    -0.0122900960);

final_score_tree_22_c338 := map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount < 1.5 => 0.0282647414,
    nf_fp_srchunvrfdphonecount >= 1.5                                      => 0.0741189054,
    nf_fp_srchunvrfdphonecount = NULL                                      => 0.0354710086,
                                                                              0.0354710086);

final_score_tree_22 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_22_c337,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_22_c338,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0351301180,
                                                                                    -0.0061329587);

final_score_tree_23_c341 := map(
    NULL < nf_fp_curraddrmedianvalue AND nf_fp_curraddrmedianvalue < 86118.5 => 0.0186761115,
    nf_fp_curraddrmedianvalue >= 86118.5                                     => -0.0207573125,
    nf_fp_curraddrmedianvalue = NULL                                         => -0.0125119231,
                                                                                -0.0125119231);

final_score_tree_23_c340 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-0', '3-2']) => final_score_tree_23_c341,
    (rv_d32_criminal_x_felony in ['2-1', '2-2', '3-1', '3-3'])               => 0.0772377380,
    (REAL)rv_d32_criminal_x_felony = NULL                                          => -0.0099955775,
                                                                                -0.0099955775);

final_score_tree_23 := map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 0.5 => final_score_tree_23_c340,
    rv_i60_inq_prepaidcards_recency >= 0.5                                           => 0.0416021340,
    rv_i60_inq_prepaidcards_recency = NULL                                           => -0.0229070943,
                                                                                        -0.0047665529);

final_score_tree_24_c344 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '3-0', '3-2']) => 0.0046667930,
    (rv_d32_criminal_x_felony in ['2-2', '3-1', '3-3'])                             => 0.0918960634,
    (REAL)rv_d32_criminal_x_felony = NULL                                                 => 0.0082650478,
                                                                                       0.0082650478);

final_score_tree_24_c343 := map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 < 2.5 => final_score_tree_24_c344,
    nf_inq_other_count24 >= 2.5                                => 0.0420743646,
    nf_inq_other_count24 = NULL                                => 0.0167531104,
                                                                  0.0167531104);

final_score_tree_24 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 1.5 => -0.0198258921,
    nf_fp_varrisktype >= 1.5                             => final_score_tree_24_c343,
    nf_fp_varrisktype = NULL                             => -0.0158542603,
                                                            -0.0051770152);

final_score_tree_25_c346 := map(
    c_unemp = ''                    => -0.0080433501,
    NULL < (REAL)c_unemp AND (REAL)c_unemp < 8.95 => -0.0145560576,
    (REAL)c_unemp >= 8.95                   => 0.0306049554,
    (REAL)c_unemp = NULL                    => -0.0080433501,
                                         -0.0080433501);

final_score_tree_25_c347 := map(
    NULL < nf_inquiry_addr_vel_risk_index AND nf_inquiry_addr_vel_risk_index < 4 => 0.0278106960,
    nf_inquiry_addr_vel_risk_index >= 4                                          => 0.0950721370,
    nf_inquiry_addr_vel_risk_index = NULL                                        => 0.0363544905,
                                                                                    0.0363544905);

final_score_tree_25 := map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 0.5 => final_score_tree_25_c346,
    rv_i60_inq_prepaidcards_recency >= 0.5                                           => final_score_tree_25_c347,
    rv_i60_inq_prepaidcards_recency = NULL                                           => -0.0184772456,
                                                                                        -0.0036191280);

final_score_tree_26_c350 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2', '3-0', '3-3']) => -0.0176311742,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1', '3-2'])               => 0.0585803574,
    (REAL)rv_d32_criminal_x_felony = NULL                                          => -0.0154882764,
                                                                                -0.0154882764);

final_score_tree_26_c349 := map(
    c_civ_emp = ''                       => -0.0095851653,
    NULL < (REAL)c_civ_emp AND (REAL)c_civ_emp < 48.95 => 0.0316275477,
    (REAL)c_civ_emp >= 48.95                     => final_score_tree_26_c350,
    (REAL)c_civ_emp = NULL                       => -0.0095851653,
                                              -0.0095851653);

final_score_tree_26 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 4.5 => final_score_tree_26_c349,
    nf_fp_varrisktype >= 4.5                             => 0.0335719536,
    nf_fp_varrisktype = NULL                             => -0.0125542800,
                                                            -0.0060763136);

final_score_tree_27_c352 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist < 0.5 => -0.0147366459,
    rv_c19_add_prison_hist >= 0.5                                  => 0.1064640665,
    rv_c19_add_prison_hist = NULL                                  => -0.0130694239,
                                                                      -0.0130694239);

final_score_tree_27_c353 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 2.5 => 0.0176444729,
    rv_l79_adls_per_sfd_addr_c6 >= 2.5                                       => 0.0581138500,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                       => 0.0243635831,
                                                                                0.0243635831);

final_score_tree_27 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 0.5 => final_score_tree_27_c352,
    rv_i60_inq_hiriskcred_recency >= 0.5                                         => final_score_tree_27_c353,
    rv_i60_inq_hiriskcred_recency = NULL                                         => -0.0252589261,
                                                                                    -0.0044244324);

final_score_tree_28_c356 := map(
    NULL < nf_fp_srchunvrfdaddrcount AND nf_fp_srchunvrfdaddrcount < 0.5 => 0.0061492472,
    nf_fp_srchunvrfdaddrcount >= 0.5                                     => 0.0568386657,
    nf_fp_srchunvrfdaddrcount = NULL                                     => 0.0112736479,
                                                                            0.0112736479);

final_score_tree_28_c355 := map(
    NULL < iv_wealth_index AND iv_wealth_index < 2.5 => final_score_tree_28_c356,
    iv_wealth_index >= 2.5                           => -0.0214942009,
    iv_wealth_index = NULL                           => -0.0099892017,
                                                        -0.0099892017);

final_score_tree_28 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_28_c355,
    rv_f03_input_add_not_most_rec >= 0.5                                         => 0.0381733180,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0126750898,
                                                                                    -0.0034434650);

final_score_tree_29_c359 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 21500 => 0.0452781040,
    iv_estimated_income >= 21500                               => -0.0136633056,
    iv_estimated_income = NULL                                 => -0.0100172696,
                                                                  -0.0100172696);

final_score_tree_29_c358 := map(
    NULL < nf_fp_srchfraudsrchcountyr AND nf_fp_srchfraudsrchcountyr < 9.5 => final_score_tree_29_c359,
    nf_fp_srchfraudsrchcountyr >= 9.5                                      => 0.0661996420,
    nf_fp_srchfraudsrchcountyr = NULL                                      => -0.0089742441,
                                                                              -0.0089742441);

final_score_tree_29 := map(
    NULL < nf_inq_peraddr_count12 AND nf_inq_peraddr_count12 < 7.5 => final_score_tree_29_c358,
    nf_inq_peraddr_count12 >= 7.5                                  => 0.0418561337,
    nf_inq_peraddr_count12 = NULL                                  => -0.0242042540,
                                                                      -0.0055840913);

final_score_tree_30_c362 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 0.5 => -0.0170054029,
    rv_i60_inq_hiriskcred_recency >= 0.5                                         => 0.0160930030,
    rv_i60_inq_hiriskcred_recency = NULL                                         => -0.0091270434,
                                                                                    -0.0091270434);

final_score_tree_30_c361 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '2-1', '3-0']) => final_score_tree_30_c362,
    (rv_d32_criminal_x_felony in ['2-2', '3-1', '3-2', '3-3'])               => 0.0642100211,
    (REAL)rv_d32_criminal_x_felony = NULL                                          => -0.0064288584,
                                                                                -0.0064288584);

final_score_tree_30 := map(
    NULL < nf_inq_lnamesperaddr_count12 AND nf_inq_lnamesperaddr_count12 < 3.5 => final_score_tree_30_c361,
    nf_inq_lnamesperaddr_count12 >= 3.5                                        => 0.0792682375,
    nf_inq_lnamesperaddr_count12 = NULL                                        => -0.0144283524,
                                                                                  -0.0048270425);

final_score_tree_31_c365 := map(
    NULL < nf_fp_srchfraudsrchcountyr AND nf_fp_srchfraudsrchcountyr < 1.5 => -0.0024996834,
    nf_fp_srchfraudsrchcountyr >= 1.5                                      => 0.0277574951,
    nf_fp_srchfraudsrchcountyr = NULL                                      => 0.0071172188,
                                                                              0.0071172188);

final_score_tree_31_c364 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 21500 => 0.0552220460,
    iv_estimated_income >= 21500                               => final_score_tree_31_c365,
    iv_estimated_income = NULL                                 => 0.0137421385,
                                                                  0.0137421385);

final_score_tree_31 := map(
    NULL < nf_average_rel_income AND nf_average_rel_income < 58500 => final_score_tree_31_c364,
    nf_average_rel_income >= 58500                                 => -0.0164786626,
    nf_average_rel_income = NULL                                   => -0.0288473056,
                                                                      -0.0052728584);

final_score_tree_32_c367 := map(
    c_med_hhinc = '' => -0.0136001418,
    NULL < (REAL)c_med_hhinc AND (REAL)c_med_hhinc < 35937 => 0.0221004742,
    (REAL)c_med_hhinc >= 35937                       => -0.0221188680,
    (REAL)c_med_hhinc = NULL                         => -0.0136001418,
                                                  -0.0136001418);
      
final_score_tree_32_c368 := map(
    (rv_6seg_riskview_5_0 in ['4 SUFFICIENTLY VERD - DEROG', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER'])       => 0.0116814434,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '3 ADDR NOT CURRENT - OTHER']) => 0.0496705767,
    (REAL)rv_6seg_riskview_5_0 = NULL                                                                                                   => 0.0219319450,
                                                                                                                                     0.0219319450);

final_score_tree_32 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => final_score_tree_32_c367,
    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                                                                                    => final_score_tree_32_c368,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                                               => -0.0032134147,
                                                                                                                                  -0.0032134147);


final_score_tree_33_c370 := map(
    c_unemp = '' => -0.0143521944,
    NULL < (REAL)c_unemp AND (REAL)c_unemp < 7.25 => -0.0238914881,
    (REAL)c_unemp >= 7.25                   => 0.0156108791,
    (REAL)c_unemp = NULL                    => -0.0143521944,
                                         -0.0143521944);

final_score_tree_33_c371 := map(
    NULL < nf_age_at_ssn_issuance AND nf_age_at_ssn_issuance < 2.5 => 0.0375636219,
    nf_age_at_ssn_issuance >= 2.5                                  => 0.0035312467,
    nf_age_at_ssn_issuance = NULL                                  => 0.0175831275,
                                                                      0.0175831275);

final_score_tree_33 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => final_score_tree_33_c370,
    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                                                                                    => final_score_tree_33_c371,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                                               => -0.0050913233,
                                                                                                                                  -0.0050913233);

final_score_tree_34_c374 := map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 4.5 => 0.0038950440,
    nf_inq_communications_count24 >= 4.5                                         => 0.0565606502,
    nf_inq_communications_count24 = NULL                                         => 0.0061822811,
                                                                                    0.0061822811);

final_score_tree_34_c373 := map(
    NULL < nf_average_rel_income AND nf_average_rel_income < 45500 => 0.0437859350,
    nf_average_rel_income >= 45500                                 => final_score_tree_34_c374,
    nf_average_rel_income = NULL                                   => 0.0115214443,
                                                                      0.0115214443);

final_score_tree_34 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 1.5 => -0.0179512924,
    nf_fp_varrisktype >= 1.5                             => final_score_tree_34_c373,
    nf_fp_varrisktype = NULL                             => -0.0110772761,
                                                            -0.0059454326);

final_score_tree_35_c377 := map(
    NULL < nf_bus_addr_match_count AND nf_bus_addr_match_count < 0.5 => 0.0175754631,
    nf_bus_addr_match_count >= 0.5                                   => 0.1031902217,
    nf_bus_addr_match_count = NULL                                   => 0.0308564229,
                                                                        0.0308564229);

final_score_tree_35_c376 := map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 1.5 => -0.0142695251,
    nf_inq_highriskcredit_count24 >= 1.5                                         => final_score_tree_35_c377,
    nf_inq_highriskcredit_count24 = NULL                                         => -0.0115932532,
                                                                                    -0.0115932532);

final_score_tree_35 := map(
    NULL < nf_fp_divrisktype AND nf_fp_divrisktype < 1.5 => final_score_tree_35_c376,
    nf_fp_divrisktype >= 1.5                             => 0.0281471161,
    nf_fp_divrisktype = NULL                             => -0.0220390703,
                                                            -0.0041709681);

final_score_tree_36_c380 := map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype < 3.5 => -0.0092405223,
    nf_fp_sourcerisktype >= 3.5                                => 0.0207171904,
    nf_fp_sourcerisktype = NULL                                => 0.0083866639,
                                                                  0.0083866639);

final_score_tree_36_c379 := map(
    NULL < nf_fp_curraddrmedianincome AND nf_fp_curraddrmedianincome < 22307 => 0.0536072688,
    nf_fp_curraddrmedianincome >= 22307                                      => final_score_tree_36_c380,
    nf_fp_curraddrmedianincome = NULL                                        => 0.0132182751,
                                                                                0.0132182751);

final_score_tree_36 := map(
    NULL < rv_i60_inq_comm_recency AND rv_i60_inq_comm_recency < 0.5 => -0.0173783881,
    rv_i60_inq_comm_recency >= 0.5                                   => final_score_tree_36_c379,
    rv_i60_inq_comm_recency = NULL                                   => -0.0090614921,
                                                                        -0.0062615585);

final_score_tree_37_c383 := map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr < 11.5 => -0.0123905388,
    nf_inq_per_addr >= 11.5                           => 0.0449143507,
    nf_inq_per_addr = NULL                            => -0.0107263707,
                                                         -0.0107263707);

final_score_tree_37_c382 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '1-1', '2-0', '3-0']) => final_score_tree_37_c383,
    (rv_d32_criminal_x_felony in ['2-1', '2-2', '3-1', '3-2', '3-3']) => 0.0539422932,
    (REAL)rv_d32_criminal_x_felony = NULL                                   => -0.0085780364,
                                                                         -0.0085780364);

final_score_tree_37 := map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 0.5 => final_score_tree_37_c382,
    rv_i60_inq_prepaidcards_recency >= 0.5                                           => 0.0326696169,
    rv_i60_inq_prepaidcards_recency = NULL                                           => -0.0142953280,
                                                                                        -0.0046227438);

final_score_tree_38_c386 := map(
    NULL < nf_fp_curraddrcrimeindex AND nf_fp_curraddrcrimeindex < 142 => 0.0206386738,
    nf_fp_curraddrcrimeindex >= 142                                    => 0.0888901878,
    nf_fp_curraddrcrimeindex = NULL                                    => 0.0435304860,
                                                                          0.0435304860);

final_score_tree_38_c385 := map(
    NULL < rv_l79_adls_per_sfd_addr_c6 AND rv_l79_adls_per_sfd_addr_c6 < 2.5 => 0.0097711209,
    rv_l79_adls_per_sfd_addr_c6 >= 2.5                                       => final_score_tree_38_c386,
    rv_l79_adls_per_sfd_addr_c6 = NULL                                       => 0.0157835742,
                                                                                0.0157835742);

final_score_tree_38 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 0.5 => -0.0108554163,
    rv_i60_inq_hiriskcred_recency >= 0.5                                         => final_score_tree_38_c385,
    rv_i60_inq_hiriskcred_recency = NULL                                         => -0.0376188815,
                                                                                    -0.0051859323);

final_score_tree_39_c388 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist < 0.5 => -0.0151290872,
    rv_c19_add_prison_hist >= 0.5                                  => 0.0884382235,
    rv_c19_add_prison_hist = NULL                                  => -0.0138734952,
                                                                      -0.0138734952);

final_score_tree_39_c389 := map(
    (nf_historic_x_current_ct in ['2-2', '3-2', '3-3'])                             => 0.0011119432,
    (nf_historic_x_current_ct in ['0-0', '1-0', '1-1', '2-0', '2-1', '3-0', '3-1']) => 0.0298031519,
    (REAL)nf_historic_x_current_ct = NULL                                                 => 0.0166214362,
                                                                                       0.0166214362);

final_score_tree_39 := map(
    NULL < nf_fp_srchvelocityrisktype AND nf_fp_srchvelocityrisktype < 5.5 => final_score_tree_39_c388,
    nf_fp_srchvelocityrisktype >= 5.5                                      => final_score_tree_39_c389,
    nf_fp_srchvelocityrisktype = NULL                                      => -0.0047692041,
                                                                              -0.0053151960);

final_score_tree_40_c391 := map(
    NULL < nf_inq_perbestssn_count12 AND nf_inq_perbestssn_count12 < 9.5 => -0.0156414884,
    nf_inq_perbestssn_count12 >= 9.5                                     => 0.0320848013,
    nf_inq_perbestssn_count12 = NULL                                     => -0.0202204908,
                                                                            -0.0136236610);

final_score_tree_40_c392 := map(
    NULL < nf_age_at_ssn_issuance AND nf_age_at_ssn_issuance < 7.5 => 0.0303279968,
    nf_age_at_ssn_issuance >= 7.5                                  => -0.0149289237,
    nf_age_at_ssn_issuance = NULL                                  => 0.0150266032,
                                                                      0.0165280142);

final_score_tree_40 := map(
    c_unemp = ''                    => -0.0053983404,
    NULL < (REAL)c_unemp AND (REAL)c_unemp < 7.15 => final_score_tree_40_c391,
    (REAL)c_unemp >= 7.15                   => final_score_tree_40_c392,
    (REAL)c_unemp = NULL                    => -0.0053983404,
                                         -0.0053983404);

final_score_tree_41_c395 := map(
    NULL < nf_average_rel_income AND nf_average_rel_income < 44500 => 0.0434721802,
    nf_average_rel_income >= 44500                                 => 0.0031490202,
    nf_average_rel_income = NULL                                   => 0.0112890226,
                                                                      0.0112890226);

final_score_tree_41_c394 := map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype < 4.5 => final_score_tree_41_c395,
    nf_fp_srchcomponentrisktype >= 4.5                                       => 0.0615369832,
    nf_fp_srchcomponentrisktype = NULL                                       => 0.0150874645,
                                                                                0.0150874645);

final_score_tree_41 := map(
    c_totcrime = ''                      => -0.0031413058,
    NULL < (REAL)c_totcrime AND (REAL)c_totcrime < 140 => -0.0112258750,
    (REAL)c_totcrime >= 140                      => final_score_tree_41_c394,
    (REAL)c_totcrime = NULL                      => -0.0031413058,
                                              -0.0031413058);

final_score_tree_42_c397 := map(
    NULL < nf_hh_pct_property_owners AND nf_hh_pct_property_owners < 0.179144385 => 0.0097673650,
    nf_hh_pct_property_owners >= 0.179144385                                     => -0.0237792382,
    nf_hh_pct_property_owners = NULL                                             => -0.0109136748,
                                                                                    -0.0109136748);

final_score_tree_42_c398 := map(
    NULL < nf_invbest_inq_adlsperaddr_diff AND nf_invbest_inq_adlsperaddr_diff < 6.5 => 0.0164434634,
    nf_invbest_inq_adlsperaddr_diff >= 6.5                                           => 0.0702897690,
    nf_invbest_inq_adlsperaddr_diff = NULL                                           => 0.0190436212,
                                                                                        0.0190436212);

final_score_tree_42 := map(
    NULL < nf_unvrfd_search_risk_index AND nf_unvrfd_search_risk_index < 3.5 => final_score_tree_42_c397,
    nf_unvrfd_search_risk_index >= 3.5                                       => final_score_tree_42_c398,
    nf_unvrfd_search_risk_index = NULL                                       => -0.0107762508,
                                                                                -0.0045633106);

final_score_tree_43_c401 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 4.5 => -0.0032450643,
    rv_i60_inq_other_count12 >= 4.5                                    => 0.0403954018,
    rv_i60_inq_other_count12 = NULL                                    => -0.0002949076,
                                                                          -0.0002949076);

final_score_tree_43_c400 := map(
    c_totcrime = ''                        => 0.0089425940,
    NULL < (REAL)c_totcrime AND (REAL)c_totcrime < 143.5 => final_score_tree_43_c401,
    (REAL)c_totcrime >= 143.5                      => 0.0263456986,
    (REAL)c_totcrime = NULL                        => 0.0089425940,
                                                0.0089425940);

final_score_tree_43 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 1.5 => -0.0163587989,
    nf_fp_varrisktype >= 1.5                             => final_score_tree_43_c400,
    nf_fp_varrisktype = NULL                             => -0.0203229881,
                                                            -0.0063877538);

final_score_tree_44_c404 := map(
    c_med_hhinc = ''                           => -0.0166109507,
    NULL < (REAL)c_med_hhinc AND (REAL)c_med_hhinc < 35200.5 => 0.0156321415,
    (REAL)c_med_hhinc >= 35200.5                       => -0.0233941407,
    (REAL)c_med_hhinc = NULL                           => -0.0166109507,
                                                    -0.0166109507);

final_score_tree_44_c403 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '2-2', '3-0']) => final_score_tree_44_c404,
    (rv_d32_criminal_x_felony in ['1-1', '3-1', '3-2', '3-3'])               => 0.0451004194,
    (REAL)rv_d32_criminal_x_felony = NULL                                          => -0.0146848243,
                                                                                -0.0146848243);

final_score_tree_44 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 0.5 => final_score_tree_44_c403,
    rv_i60_inq_hiriskcred_recency >= 0.5                                         => 0.0179679848,
    rv_i60_inq_hiriskcred_recency = NULL                                         => -0.0088829593,
                                                                                    -0.0068109755);

final_score_tree_45_c407 := map(
    NULL < nf_fp_curraddrcartheftindex AND nf_fp_curraddrcartheftindex < 163.5 => 0.0161261387,
    nf_fp_curraddrcartheftindex >= 163.5                                       => 0.1544753631,
    nf_fp_curraddrcartheftindex = NULL                                         => 0.0813852068,
                                                                                  0.0813852068);

final_score_tree_45_c406 := map(
    C_OWNOCC_P = ''                        => 0.0246091576,
    NULL < (REAL)C_OWNOCC_P AND (REAL)C_OWNOCC_P < 23.55 => final_score_tree_45_c407,
    (REAL)C_OWNOCC_P >= 23.55                      => 0.0181931009,
    (REAL)C_OWNOCC_P = NULL                        => 0.0246091576,
                                                0.0246091576);

final_score_tree_45 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0071020444,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_45_c406,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0033256552,
                                                                                    -0.0027185300);

final_score_tree_46_c410 := map(
    NULL < nf_addrs_per_bestssn AND nf_addrs_per_bestssn < 9.5 => 0.0184397094,
    nf_addrs_per_bestssn >= 9.5                                => 0.0764867034,
    nf_addrs_per_bestssn = NULL                                => 0.0419928091,
                                                                  0.0419928091);

final_score_tree_46_c409 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 17.5 => final_score_tree_46_c410,
    iv_bureau_emergence_age >= 17.5                                   => 0.0086140342,
    iv_bureau_emergence_age = NULL                                    => 0.0025529163,
                                                                         0.0145107307);

final_score_tree_46 := map(
    NULL < nf_average_rel_income AND nf_average_rel_income < 53500 => final_score_tree_46_c409,
    nf_average_rel_income >= 53500                                 => -0.0085800524,
    nf_average_rel_income = NULL                                   => -0.0086600731,
                                                                      -0.0023251948);

final_score_tree_47_c413 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 1.615 => 0.0105929239,
    rv_a49_curr_add_avm_pct_chg_2yr >= 1.615                                           => 0.0926970377,
    rv_a49_curr_add_avm_pct_chg_2yr = NULL                                             => 0.0246469467,
                                                                                          0.0241078922);

final_score_tree_47_c412 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 279.5 => final_score_tree_47_c413,
    rv_c10_m_hdr_fs >= 279.5                           => -0.0175954160,
    rv_c10_m_hdr_fs = NULL                             => 0.0118694164,
                                                          0.0118694164);

final_score_tree_47 := map(
    NULL < nf_fp_prevaddrcartheftindex AND nf_fp_prevaddrcartheftindex < 139.5 => -0.0120698239,
    nf_fp_prevaddrcartheftindex >= 139.5                                       => final_score_tree_47_c412,
    nf_fp_prevaddrcartheftindex = NULL                                         => 0.0120252432,
                                                                                  -0.0037884657);

final_score_tree_48_c416 := map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 < 2.5 => 0.0022011543,
    nf_inq_other_count24 >= 2.5                                => 0.0311549526,
    nf_inq_other_count24 = NULL                                => 0.0056087183,
                                                                  0.0056087183);

final_score_tree_48_c415 := map(
    NULL < nf_fp_sourcerisktype AND nf_fp_sourcerisktype < 3.5 => -0.0187418295,
    nf_fp_sourcerisktype >= 3.5                                => final_score_tree_48_c416,
    nf_fp_sourcerisktype = NULL                                => -0.0051619687,
                                                                  -0.0051619687);

final_score_tree_48 := map(
    NULL < nf_inq_lnamesperaddr_count12 AND nf_inq_lnamesperaddr_count12 < 3.5 => final_score_tree_48_c415,
    nf_inq_lnamesperaddr_count12 >= 3.5                                        => 0.0505331502,
    nf_inq_lnamesperaddr_count12 = NULL                                        => -0.0169589275,
                                                                                  -0.0043019222);

final_score_tree_49_c418 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => -0.0155606668,
    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                                                                                    => 0.0133900123,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                                               => -0.0074367116,
                                                                                                                                  -0.0074367116);

final_score_tree_49_c419 := map(
    (nf_historic_x_current_ct in ['1-1', '2-0', '2-2', '3-0', '3-3']) => -0.0064000454,
    (nf_historic_x_current_ct in ['0-0', '1-0', '2-1', '3-1', '3-2']) => 0.0765013992,
    (REAL)nf_historic_x_current_ct = NULL                                   => 0.0404910842,
                                                                         0.0404910842);

final_score_tree_49 := map(
    c_unemp = ''                     => -0.0054293300,
    NULL < (REAL)c_unemp AND (REAL)c_unemp < 13.75 => final_score_tree_49_c418,
    (REAL)c_unemp >= 13.75                   => final_score_tree_49_c419,
    (REAL)c_unemp = NULL                     => -0.0054293300,
                                          -0.0054293300);

final_score_tree_50_c422 := map(
    (nf_historic_x_current_ct in ['2-0', '2-1', '2-2', '3-2', '3-3']) => 0.0056668700,
    (nf_historic_x_current_ct in ['0-0', '1-0', '1-1', '3-0', '3-1']) => 0.1095865144,
    (REAL)nf_historic_x_current_ct = NULL                                   => 0.0535673311,
                                                                         0.0535673311);

final_score_tree_50_c421 := map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr < 11.5 => -0.0122324552,
    nf_inq_per_addr >= 11.5                           => final_score_tree_50_c422,
    nf_inq_per_addr = NULL                            => -0.0108451429,
                                                         -0.0108451429);

final_score_tree_50 := map(
    NULL < nf_fp_divrisktype AND nf_fp_divrisktype < 1.5 => final_score_tree_50_c421,
    nf_fp_divrisktype >= 1.5                             => 0.0211775218,
    nf_fp_divrisktype = NULL                             => -0.0099548120,
                                                            -0.0046509853);

final_score_tree_51_c425 := map(
    c_med_hhinc = ''                         => -0.0089840592,
    NULL < (REAL)c_med_hhinc AND (REAL)c_med_hhinc < 13599 => 0.0789014605,
    (REAL)c_med_hhinc >= 13599                       => -0.0098735887,
    (REAL)c_med_hhinc = NULL                         => -0.0089840592,
                                                  -0.0089840592);

final_score_tree_51_c424 := map(
    NULL < rv_i60_inq_prepaidcards_recency AND rv_i60_inq_prepaidcards_recency < 0.5 => final_score_tree_51_c425,
    rv_i60_inq_prepaidcards_recency >= 0.5                                           => 0.0219317623,
    rv_i60_inq_prepaidcards_recency = NULL                                           => -0.0059846032,
                                                                                        -0.0059846032);

final_score_tree_51 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 13.5 => final_score_tree_51_c424,
    rv_d30_derog_count >= 13.5                              => 0.0454647406,
    rv_d30_derog_count = NULL                               => -0.0079129719,
                                                               -0.0036844060);

final_score_tree_52_c428 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2.5 => 0.0685100404,
    iv_addr_non_phn_src_ct >= 2.5                                  => 0.0172026338,
    iv_addr_non_phn_src_ct = NULL                                  => 0.0231100083,
                                                                      0.0231100083);

final_score_tree_52_c427 := map(
    NULL < nf_inq_addr_ver_count AND nf_inq_addr_ver_count < 0.5 => -0.0070156415,
    nf_inq_addr_ver_count >= 0.5                                 => final_score_tree_52_c428,
    nf_inq_addr_ver_count = NULL                                 => 0.0134750798,
                                                                    0.0134750798);

final_score_tree_52 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 0.5 => -0.0088343909,
    rv_i60_inq_hiriskcred_recency >= 0.5                                         => final_score_tree_52_c427,
    rv_i60_inq_hiriskcred_recency = NULL                                         => -0.0100051844,
                                                                                    -0.0035831173);

final_score_tree_53_c430 := map(
    NULL < nf_inq_communications_count24 AND nf_inq_communications_count24 < 5.5 => -0.0067267641,
    nf_inq_communications_count24 >= 5.5                                         => 0.0482056144,
    nf_inq_communications_count24 = NULL                                         => -0.0067837690,
                                                                                    -0.0059946249);

final_score_tree_53_c431 := map(
    c_totcrime = ''                        => 0.0218978251,
    NULL < (REAL)c_totcrime AND (REAL)c_totcrime < 124.5 => 0.0012859663,
    (REAL)c_totcrime >= 124.5                      => 0.0466819805,
    (REAL)c_totcrime = NULL                        => 0.0218978251,
                                                0.0218978251);

final_score_tree_53 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2.5 => final_score_tree_53_c430,
    rv_l79_adls_per_addr_c6 >= 2.5                                   => final_score_tree_53_c431,
    rv_l79_adls_per_addr_c6 = NULL                                   => -0.0013777940,
                                                                        -0.0013777940);

final_score_tree_54_c434 := map(
    c_totcrime = ''                      => 0.0117743475,
    NULL < (REAL)c_totcrime AND (REAL)c_totcrime < 189 => 0.0061385109,
    (REAL)c_totcrime >= 189                      => 0.0677760157,
    (REAL)c_totcrime = NULL                      => 0.0117743475,
                                              0.0117743475);

final_score_tree_54_c433 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-1', '2-0', '3-0'])               => final_score_tree_54_c434,
    (rv_d32_criminal_x_felony in ['1-0', '2-1', '2-2', '3-1', '3-2', '3-3']) => 0.0711937007,
    (REAL)rv_d32_criminal_x_felony = NULL                                          => 0.0230923196,
                                                                                0.0230923196);

final_score_tree_54 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0055797407,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_54_c433,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0055713116,
                                                                                    -0.0016024008);

final_score_tree_55_c437 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1.5 => 0.0082855910,
    rv_d33_eviction_count >= 1.5                                 => 0.0633772086,
    rv_d33_eviction_count = NULL                                 => 0.0103252583,
                                                                    0.0103252583);

final_score_tree_55_c436 := map(
    NULL < rv_comb_age AND rv_comb_age < 28.5 => final_score_tree_55_c437,
    rv_comb_age >= 28.5                       => -0.0141466944,
    rv_comb_age = NULL                        => -0.0051045496,
                                                 -0.0051045496);

final_score_tree_55 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 13.5 => final_score_tree_55_c436,
    rv_d30_derog_count >= 13.5                              => 0.0377328768,
    rv_d30_derog_count = NULL                               => 0.0058332641,
                                                               -0.0030183081);

final_score_tree_56_c439 := map(
    NULL < nf_fp_curraddrburglaryindex AND nf_fp_curraddrburglaryindex < 151.5 => 0.0047893261,
    nf_fp_curraddrburglaryindex >= 151.5                                       => 0.0553383564,
    nf_fp_curraddrburglaryindex = NULL                                         => 0.0271109771,
                                                                                  0.0271109771);

final_score_tree_56_c440 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 7.5 => -0.0064270074,
    rv_l79_adls_per_addr_c6 >= 7.5                                   => 0.0819738903,
    rv_l79_adls_per_addr_c6 = NULL                                   => -0.0057376484,
                                                                        -0.0057376484);

final_score_tree_56 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 21500 => final_score_tree_56_c439,
    iv_estimated_income >= 21500                               => final_score_tree_56_c440,
    iv_estimated_income = NULL                                 => -0.0177785600,
                                                                  -0.0038433488);

final_score_tree_57_c443 := map(
    NULL < nf_fp_srchunvrfdssncount AND nf_fp_srchunvrfdssncount < 1.5 => 0.0001894611,
    nf_fp_srchunvrfdssncount >= 1.5                                    => 0.0506532386,
    nf_fp_srchunvrfdssncount = NULL                                    => 0.0009591274,
                                                                          0.0009591274);

final_score_tree_57_c442 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 320.5 => final_score_tree_57_c443,
    rv_c10_m_hdr_fs >= 320.5                           => -0.0323208517,
    rv_c10_m_hdr_fs = NULL                             => -0.0085725865,
                                                          -0.0085725865);

final_score_tree_57 := map(
    NULL < nf_fp_divrisktype AND nf_fp_divrisktype < 2.5 => final_score_tree_57_c442,
    nf_fp_divrisktype >= 2.5                             => 0.0299881575,
    nf_fp_divrisktype = NULL                             => -0.0050813720,
                                                            -0.0055772153);

final_score_tree_58_c446 := map(
    NULL < nf_inq_lname_ver_count AND nf_inq_lname_ver_count < 73.5 => 0.0039239961,
    nf_inq_lname_ver_count >= 73.5                                  => 0.0645744911,
    nf_inq_lname_ver_count = NULL                                   => 0.0062833255,
                                                                       0.0062833255);

final_score_tree_58_c445 := map(
    NULL < nf_addrs_per_bestssn_c6 AND nf_addrs_per_bestssn_c6 < 0.5 => final_score_tree_58_c446,
    nf_addrs_per_bestssn_c6 >= 0.5                                   => 0.0445413746,
    nf_addrs_per_bestssn_c6 = NULL                                   => 0.0114050230,
                                                                        0.0114050230);

final_score_tree_58 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => -0.0097268812,
    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                                                                                    => final_score_tree_58_c445,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                                               => -0.0036207708,
                                                                                                                                  -0.0036207708);

final_score_tree_59_c448 := map(
    NULL < nf_inq_adls_per_addr AND nf_inq_adls_per_addr < 4.5 => -0.0057944598,
    nf_inq_adls_per_addr >= 4.5                                => 0.0653111448,
    nf_inq_adls_per_addr = NULL                                => -0.0048660781,
                                                                  -0.0048660781);

final_score_tree_59_c449 := map(
    c_incollege = ''                         => 0.0199920726,
    NULL < (REAL)c_incollege AND (REAL)c_incollege < 10.35 => 0.0129456960,
    (REAL)c_incollege >= 10.35                       => 0.0604371286,
    (REAL)c_incollege = NULL                         => 0.0199920726,
                                                  0.0199920726);

final_score_tree_59 := map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount < 1.5 => final_score_tree_59_c448,
    nf_fp_srchunvrfdphonecount >= 1.5                                      => final_score_tree_59_c449,
    nf_fp_srchunvrfdphonecount = NULL                                      => 0.0155065932,
                                                                              -0.0017942597);

final_score_tree_60_c452 := map(
    C_OWNOCC_P = ''                        => 0.0329428939,
    NULL < (REAL)C_OWNOCC_P AND (REAL)C_OWNOCC_P < 54.55 => 0.0751361993,
    (REAL)C_OWNOCC_P >= 54.55                      => -0.0145988588,
    (REAL)C_OWNOCC_P = NULL                        => 0.0329428939,
                                                0.0329428939);

final_score_tree_60_c451 := map(
    NULL < nf_inq_lnames_per_addr AND nf_inq_lnames_per_addr < 3.5 => -0.0068159568,
    nf_inq_lnames_per_addr >= 3.5                                  => final_score_tree_60_c452,
    nf_inq_lnames_per_addr = NULL                                  => -0.0059461239,
                                                                      -0.0059461239);

final_score_tree_60 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl < 3.5 => final_score_tree_60_c451,
    rv_d32_criminal_behavior_lvl >= 3.5                                        => 0.0275634491,
    rv_d32_criminal_behavior_lvl = NULL                                        => -0.0029571390,
                                                                                  -0.0029647931);

final_score_tree_61_c455 := map(
    NULL < nf_average_rel_age AND nf_average_rel_age < 43.5 => 0.0330689297,
    nf_average_rel_age >= 43.5                              => -0.0101561049,
    nf_average_rel_age = NULL                               => 0.0223231162,
                                                               0.0223231162);

final_score_tree_61_c454 := map(
    (rv_d31_all_bk in ['2 - BK DISCHARGED', '3 - BK OTHER']) => -0.0260653057,
    (rv_d31_all_bk in ['0 - NO BK', '1 - BK DISMISSED'])     => final_score_tree_61_c455,
    (REAL)rv_d31_all_bk = NULL                                     => 0.0140051888,
                                                                0.0140051888);

final_score_tree_61 := map(
    NULL < nf_pct_rel_with_felony AND nf_pct_rel_with_felony < 0.00980392155 => -0.0080005408,
    nf_pct_rel_with_felony >= 0.00980392155                                  => final_score_tree_61_c454,
    nf_pct_rel_with_felony = NULL                                            => -0.0008089065,
                                                                                -0.0023072193);

final_score_tree_62_c458 := map(
    C_OWNOCC_P = ''                        => 0.0183911647,
    NULL < (REAL)C_OWNOCC_P AND (REAL)C_OWNOCC_P < 23.55 => 0.0747011767,
    (REAL)C_OWNOCC_P >= 23.55                      => 0.0126276693,
    (REAL)C_OWNOCC_P = NULL                        => 0.0183911647,
                                                0.0183911647);

final_score_tree_62_c457 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0086774372,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_62_c458,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0050046758,
                                                                                    -0.0050046758);

final_score_tree_62 := map(
    NULL < nf_fp_divrisktype AND nf_fp_divrisktype < 2.5 => final_score_tree_62_c457,
    nf_fp_divrisktype >= 2.5                             => 0.0309812972,
    nf_fp_divrisktype = NULL                             => 0.0122969991,
                                                            -0.0017862949);

final_score_tree_63_c461 := map(
    c_totcrime = ''                        => 0.0007942594,
    NULL < (REAL)c_totcrime AND (REAL)c_totcrime < 170.5 => -0.0037156011,
    (REAL)c_totcrime >= 170.5                      => 0.0225328008,
    (REAL)c_totcrime = NULL                        => 0.0007942594,
                                                0.0007942594);

final_score_tree_63_c460 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_63_c461,
    rv_f03_input_add_not_most_rec >= 0.5                                         => 0.0271862385,
    rv_f03_input_add_not_most_rec = NULL                                         => 0.0046895771,
                                                                                    0.0046895771);

final_score_tree_63 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 315.5 => final_score_tree_63_c460,
    rv_c10_m_hdr_fs >= 315.5                           => -0.0256205755,
    rv_c10_m_hdr_fs = NULL                             => 0.0044553142,
                                                          -0.0034960547);

final_score_tree_64_c464 := map(
    NULL < nf_inq_perssn_count_week AND nf_inq_perssn_count_week < 2.5 => -0.0066055911,
    nf_inq_perssn_count_week >= 2.5                                    => 0.0555138119,
    nf_inq_perssn_count_week = NULL                                    => -0.0054995539,
                                                                          -0.0054995539);

final_score_tree_64_c463 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 21500 => 0.0306014723,
    iv_estimated_income >= 21500                               => final_score_tree_64_c464,
    iv_estimated_income = NULL                                 => -0.0031683887,
                                                                  -0.0031683887);

final_score_tree_64 := map(
    NULL < nf_inq_peraddr_count12 AND nf_inq_peraddr_count12 < 11.5 => final_score_tree_64_c463,
    nf_inq_peraddr_count12 >= 11.5                                  => 0.0370167688,
    nf_inq_peraddr_count12 = NULL                                   => -0.0232043556,
                                                                       -0.0022460939);

final_score_tree_65_c467 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2']) => -0.0078210437,
    (rv_d32_criminal_x_felony in ['1-1', '3-3'])                                           => 0.0711569796,
    (REAL)rv_d32_criminal_x_felony = NULL                                                        => -0.0070599243,
                                                                                              -0.0070599243);

final_score_tree_65_c466 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 5.5 => final_score_tree_65_c467,
    rv_l79_adls_per_addr_c6 >= 5.5                                   => 0.0530440702,
    rv_l79_adls_per_addr_c6 = NULL                                   => -0.0057063901,
                                                                        -0.0057063901);

final_score_tree_65 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1.5 => final_score_tree_65_c466,
    rv_d33_eviction_count >= 1.5                                 => 0.0252175989,
    rv_d33_eviction_count = NULL                                 => 0.0119187584,
                                                                    -0.0022640096);

final_score_tree_66_c470 := map(
    c_unemp = ''                     => 0.0236026101,
    NULL < (REAL)c_unemp AND (REAL)c_unemp < 13.75 => 0.0187826682,
    (REAL)c_unemp >= 13.75                   => 0.0723292105,
    (REAL)c_unemp = NULL                     => 0.0236026101,
                                          0.0236026101);

final_score_tree_66_c469 := map(
    (nf_historic_x_current_ct in ['1-1', '2-0', '2-2', '3-1', '3-3']) => -0.0078186407,
    (nf_historic_x_current_ct in ['0-0', '1-0', '2-1', '3-0', '3-2']) => final_score_tree_66_c470,
    (REAL)nf_historic_x_current_ct = NULL                                   => 0.0112314091,
                                                                         0.0112314091);

final_score_tree_66 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 29500 => final_score_tree_66_c469,
    iv_estimated_income >= 29500                               => -0.0110812440,
    iv_estimated_income = NULL                                 => -0.0046539491,
                                                                  -0.0041449640);

final_score_tree_67_c472 := map(
    NULL < rv_d32_criminal_count AND rv_d32_criminal_count < 5.5 => -0.0064278931,
    rv_d32_criminal_count >= 5.5                                 => 0.0253827170,
    rv_d32_criminal_count = NULL                                 => -0.0040383008,
                                                                    -0.0040383008);

final_score_tree_67_c473 := map(
    c_totcrime = ''                      => 0.0301600800,
    NULL < (REAL)c_totcrime AND (REAL)c_totcrime < 168 => 0.0159109752,
    (REAL)c_totcrime >= 168                      => 0.0778945811,
    (REAL)c_totcrime = NULL                      => 0.0301600800,
                                              0.0301600800);

final_score_tree_67 := map(
    NULL < nf_fp_divaddrsuspidcountnew AND nf_fp_divaddrsuspidcountnew < 1.5 => final_score_tree_67_c472,
    nf_fp_divaddrsuspidcountnew >= 1.5                                       => final_score_tree_67_c473,
    nf_fp_divaddrsuspidcountnew = NULL                                       => -0.0344271481,
                                                                                -0.0027403214);

final_score_tree_68_c476 := map(
    NULL < rv_i60_inq_hiriskcred_count12 AND rv_i60_inq_hiriskcred_count12 < 1.5 => 0.0137129100,
    rv_i60_inq_hiriskcred_count12 >= 1.5                                         => 0.0547274471,
    rv_i60_inq_hiriskcred_count12 = NULL                                         => 0.0168997427,
                                                                                    0.0168997427);

final_score_tree_68_c475 := map(
    c_families = ''                        => -0.0022903441,
    NULL < (REAL)c_families AND (REAL)c_families < 203.5 => final_score_tree_68_c476,
    (REAL)c_families >= 203.5                      => -0.0064440006,
    (REAL)c_families = NULL                        => -0.0022903441,
                                                -0.0022903441);

final_score_tree_68 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2', '3-0']) => final_score_tree_68_c475,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1', '3-2', '3-3']) => 0.0353019628,
    (REAL)rv_d32_criminal_x_felony = NULL                                   => 0.0116738919,
    rv_d32_criminal_x_felony = ''                                   => 0.0116738919,
                                                                         -0.0005287693);

final_score_tree_69_c478 := map(
    NULL < nf_fp_curraddrmedianincome AND nf_fp_curraddrmedianincome < 22348.5 => 0.0284646062,
    nf_fp_curraddrmedianincome >= 22348.5                                      => -0.0105543908,
    nf_fp_curraddrmedianincome = NULL                                          => -0.0078824878,
                                                                                  -0.0078824878);

final_score_tree_69_c479 := map(
    NULL < nf_pct_rel_with_felony AND nf_pct_rel_with_felony < 0.05798319325 => 0.0078772404,
    nf_pct_rel_with_felony >= 0.05798319325                                  => 0.0415728382,
    nf_pct_rel_with_felony = NULL                                            => 0.0162298372,
                                                                                0.0162298372);

final_score_tree_69 := map(
    NULL < nf_fp_divaddrsuspidcountnew AND nf_fp_divaddrsuspidcountnew < 0.5 => final_score_tree_69_c478,
    nf_fp_divaddrsuspidcountnew >= 0.5                                       => final_score_tree_69_c479,
    nf_fp_divaddrsuspidcountnew = NULL                                       => -0.0099355998,
                                                                                -0.0027538185);



final_score_tree_70_c482 := map(
    NULL < nf_attr_arrests AND nf_attr_arrests < 0.5 => 0.0046714382,
    nf_attr_arrests >= 0.5                           => 0.0861809724,
    nf_attr_arrests = NULL                           => 0.0061859735,
                                                        0.0061859735);

final_score_tree_70_c481 := map(
    c_unemp = ''                     => 0.0086400274,
    NULL < (REAL)c_unemp AND (REAL)c_unemp < 13.75 => final_score_tree_70_c482,
    (REAL)c_unemp >= 13.75                   => 0.0570666911,
    (REAL)c_unemp = NULL                     => 0.0086400274,
                                          0.0086400274);

final_score_tree_70 := map(
    (nf_historic_x_current_ct in ['1-1', '2-0', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.0110329473,
    (nf_historic_x_current_ct in ['0-0', '1-0', '2-1'])                             => final_score_tree_70_c481,
    nf_historic_x_current_ct = ''                                                   => 0.0128958846,
                                                                                       -0.0025833775);

final_score_tree_71_c485 := map(
    c_high_ed = ''                      => 0.0098145271,
    NULL < (REAL)c_high_ed AND (REAL)c_high_ed < 9.35 => 0.0304826346,
    (REAL)c_high_ed >= 9.35                     => -0.0072359202,
    (REAL)c_high_ed = NULL                      => 0.0098145271,
                                             0.0098145271);

final_score_tree_71_c484 := map(
    NULL < nf_fp_srchcomponentrisktype AND nf_fp_srchcomponentrisktype < 6.5 => final_score_tree_71_c485,
    nf_fp_srchcomponentrisktype >= 6.5                                       => 0.0721724460,
    nf_fp_srchcomponentrisktype = NULL                                       => 0.0127572604,
                                                                                0.0127572604);

final_score_tree_71 := map(
    c_totcrime = ''                        => -0.0035517990,
    NULL < (REAL)c_totcrime AND (REAL)c_totcrime < 168.5 => -0.0070578217,
    (REAL)c_totcrime >= 168.5                      => final_score_tree_71_c484,
    (REAL)c_totcrime = NULL                        => -0.0035517990,
                                                -0.0035517990);

final_score_tree_72_c488 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 8802.5 => 0.0989533905,
    iv_prv_addr_avm_auto_val >= 8802.5                                    => 0.0166160719,
    iv_prv_addr_avm_auto_val = NULL                                       => 0.0594098098,
                                                                             0.0594098098);

final_score_tree_72_c487 := map(
    NULL < rv_i60_inq_count12 AND rv_i60_inq_count12 < 13.5 => final_score_tree_72_c488,
    rv_i60_inq_count12 >= 13.5                              => -0.0165403266,
    rv_i60_inq_count12 = NULL                               => 0.0330065435,
                                                               0.0330065435);

final_score_tree_72 := map(
    NULL < nf_inq_perssn_count12 AND nf_inq_perssn_count12 < 11.5 => -0.0012212984,
    nf_inq_perssn_count12 >= 11.5                                 => final_score_tree_72_c487,
    nf_inq_perssn_count12 = NULL                                  => 0.0014417586,
                                                                     -0.0001321693);

final_score_tree_73_c490 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1.5 => -0.0091785707,
    rv_d33_eviction_count >= 1.5                                 => 0.0191986795,
    rv_d33_eviction_count = NULL                                 => -0.0063812738,
                                                                    -0.0063812738);

final_score_tree_73_c491 := map(
    NULL < nf_adls_per_curraddr_c6 AND nf_adls_per_curraddr_c6 < 2.5 => 0.0038557999,
    nf_adls_per_curraddr_c6 >= 2.5                                   => 0.0482807831,
    nf_adls_per_curraddr_c6 = NULL                                   => 0.0209144127,
                                                                        0.0209144127);

final_score_tree_73 := map(
    NULL < nf_fp_divrisktype AND nf_fp_divrisktype < 2.5 => final_score_tree_73_c490,
    nf_fp_divrisktype >= 2.5                             => final_score_tree_73_c491,
    nf_fp_divrisktype = NULL                             => -0.0156766015,
                                                            -0.0044103234);

final_score_tree_74_c494 := map(
    NULL < nf_fp_curraddrcartheftindex AND nf_fp_curraddrcartheftindex < 124.5 => -0.0008039601,
    nf_fp_curraddrcartheftindex >= 124.5                                       => 0.0281697758,
    nf_fp_curraddrcartheftindex = NULL                                         => 0.0125336365,
                                                                                  0.0125336365);

final_score_tree_74_c493 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 9.5 => -0.0077378979,
    iv_mos_src_voter_adl_lseen >= 9.5                                      => final_score_tree_74_c494,
    iv_mos_src_voter_adl_lseen = NULL                                      => -0.0025432664,
                                                                              -0.0025432664);

final_score_tree_74 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist < 0.5 => final_score_tree_74_c493,
    rv_c19_add_prison_hist >= 0.5                                  => 0.0562562706,
    rv_c19_add_prison_hist = NULL                                  => -0.0018334692,
                                                                      -0.0017910458);

final_score_tree_75_c497 := map(
    c_retired2 = ''                       => 0.0312673458,
    NULL < (REAL)c_retired2 AND (REAL)c_retired2 < 35.5 => 0.0838170447,
    (REAL)c_retired2 >= 35.5                      => 0.0256470571,
    (REAL)c_retired2 = NULL                       => 0.0312673458,
                                               0.0312673458);

final_score_tree_75_c496 := map(
    (nf_historic_x_current_ct in ['1-0', '1-1', '2-0', '2-2', '3-3']) => -0.0066753770,
    (nf_historic_x_current_ct in ['0-0', '2-1', '3-0', '3-1', '3-2']) => final_score_tree_75_c497,
    (REAL)nf_historic_x_current_ct = NULL                                   => 0.0156607164,
                                                                         0.0156607164);

final_score_tree_75 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0050712604,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_75_c496,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0128356436,
                                                                                    -0.0023768589);

final_score_tree_76_c499 := map(
    NULL < nf_inq_perssn_count_week AND nf_inq_perssn_count_week < 3.5 => -0.0047945717,
    nf_inq_perssn_count_week >= 3.5                                    => 0.0492226219,
    nf_inq_perssn_count_week = NULL                                    => -0.0041863226,
                                                                          -0.0041863226);

final_score_tree_76_c500 := map(
    c_families = ''                        => 0.0234371954,
    NULL < (REAL)c_families AND (REAL)c_families < 153.5 => 0.0778424432,
    (REAL)c_families >= 153.5                      => 0.0169199001,
    (REAL)c_families = NULL                        => 0.0234371954,
                                                0.0234371954);

final_score_tree_76 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl < 3.5 => final_score_tree_76_c499,
    rv_d32_criminal_behavior_lvl >= 3.5                                        => final_score_tree_76_c500,
    rv_d32_criminal_behavior_lvl = NULL                                        => -0.0314322069,
                                                                                  -0.0023831701);

final_score_tree_77_c502 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 13.5 => -0.0083810549,
    rv_d30_derog_count >= 13.5                              => 0.0279266494,
    rv_d30_derog_count = NULL                               => -0.0067724505,
                                                               -0.0067724505);

final_score_tree_77_c503 := map(
    c_incollege = ''                         => 0.0171616111,
    NULL < (REAL)c_incollege AND (REAL)c_incollege < 14.05 => 0.0131669410,
    (REAL)c_incollege >= 14.05                       => 0.0883393689,
    (REAL)c_incollege = NULL                         => 0.0171616111,
                                                  0.0171616111);

final_score_tree_77 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => final_score_tree_77_c502,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_77_c503,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0028298135,
                                                                                    -0.0034653203);

final_score_tree_78_c506 := map(
    NULL < iv_unverified_addr_count AND iv_unverified_addr_count < 0.5 => 0.0051859612,
    iv_unverified_addr_count >= 0.5                                    => 0.0378595504,
    iv_unverified_addr_count = NULL                                    => 0.0246098927,
                                                                          0.0246098927);

final_score_tree_78_c505 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 55.95 => final_score_tree_78_c506,
    rv_c12_source_profile >= 55.95                                 => -0.0019418207,
    rv_c12_source_profile = NULL                                   => 0.0111205549,
                                                                      0.0111205549);

final_score_tree_78 := map(
    c_unemp = ''                    => -0.0045156867,
    NULL < (REAL)c_unemp AND (REAL)c_unemp < 7.35 => -0.0100787924,
    (REAL)c_unemp >= 7.35                   => final_score_tree_78_c505,
    (REAL)c_unemp = NULL                    => -0.0045156867,
                                         -0.0045156867);

final_score_tree_79_c509 := map(
    NULL < nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 2.5 => 0.0146815552,
    nf_fp_srchaddrsrchcountmo >= 2.5                                     => 0.0764861614,
    nf_fp_srchaddrsrchcountmo = NULL                                     => 0.0174402573,
                                                                            0.0174402573);

final_score_tree_79_c508 := map(
    c_civ_emp = ''                       => 0.0037222894,
    NULL < (REAL)c_civ_emp AND (REAL)c_civ_emp < 53.35 => final_score_tree_79_c509,
    (REAL)c_civ_emp >= 53.35                     => -0.0006245704,
    (REAL)c_civ_emp = NULL                       => 0.0037222894,
                                              0.0037222894);

final_score_tree_79 := map(
    NULL < rv_c13_attr_addrs_recency AND rv_c13_attr_addrs_recency < 90 => final_score_tree_79_c508,
    rv_c13_attr_addrs_recency >= 90                                     => -0.0232625656,
    rv_c13_attr_addrs_recency = NULL                                    => -0.0109042702,
                                                                           -0.0043979408);

final_score_tree_80_c512 := map(
    c_incollege = ''                        => 0.0315731480,
    NULL < (REAL)c_incollege AND (REAL)c_incollege < 9.45 => 0.0205917113,
    (REAL)c_incollege >= 9.45                       => 0.0891514917,
    (REAL)c_incollege = NULL                        => 0.0315731480,
                                                 0.0315731480);

final_score_tree_80_c511 := map(
    c_health = ''                      => 0.0183401497,
    NULL < (REAL)c_health AND (REAL)c_health < 13.55 => final_score_tree_80_c512,
    (REAL)c_health >= 13.55                    => -0.0091163409,
    (REAL)c_health = NULL                      => 0.0183401497,
                                            0.0183401497);

final_score_tree_80 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0072821782,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_80_c511,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0189396275,
                                                                                    -0.0040700490);

final_score_tree_81_c515 := map(
    (rv_6seg_riskview_5_0 in ['3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER'])         => -0.0013231292,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '4 SUFFICIENTLY VERD - DEROG']) => 0.0272754005,
    (REAL)rv_6seg_riskview_5_0 = NULL                                                                                                    => 0.0135407709,
                                                                                                                                      0.0135407709);

final_score_tree_81_c514 := map(
    NULL < nf_inq_addr_ver_count AND nf_inq_addr_ver_count < 0.5 => -0.0090345511,
    nf_inq_addr_ver_count >= 0.5                                 => final_score_tree_81_c515,
    nf_inq_addr_ver_count = NULL                                 => 0.0039893350,
                                                                    0.0039893350);

final_score_tree_81 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 6.5 => final_score_tree_81_c514,
    iv_addr_non_phn_src_ct >= 6.5                                  => -0.0215086865,
    iv_addr_non_phn_src_ct = NULL                                  => 0.0083515273,
                                                                      -0.0039325160);

final_score_tree_82_c518 := map(
    NULL < nf_inq_banking_count_day AND nf_inq_banking_count_day < 0.5 => 0.0055218413,
    nf_inq_banking_count_day >= 0.5                                    => 0.0690151625,
    nf_inq_banking_count_day = NULL                                    => 0.0081811323,
                                                                          0.0081811323);

final_score_tree_82_c517 := map(
    NULL < nf_inq_per_sfd_addr AND nf_inq_per_sfd_addr < 15.5 => final_score_tree_82_c518,
    nf_inq_per_sfd_addr >= 15.5                               => 0.0610370861,
    nf_inq_per_sfd_addr = NULL                                => 0.0091862031,
                                                                 0.0091862031);

final_score_tree_82 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 52.15 => final_score_tree_82_c517,
    rv_c12_source_profile >= 52.15                                 => -0.0105848013,
    rv_c12_source_profile = NULL                                   => 0.0074021346,
                                                                      -0.0026708630);

final_score_tree_83_c521 := map(
    (nf_historic_x_current_ct in ['1-1', '2-2', '3-0', '3-3'])               => -0.0103266364,
    (nf_historic_x_current_ct in ['0-0', '1-0', '2-0', '2-1', '3-1', '3-2']) => 0.0554212841,
    (REAL)nf_historic_x_current_ct = NULL                                          => 0.0395289992,
                                                                                0.0395289992);

final_score_tree_83_c520 := map(
    NULL < nf_pct_rel_prop_owned AND nf_pct_rel_prop_owned < 0.3914141414 => final_score_tree_83_c521,
    nf_pct_rel_prop_owned >= 0.3914141414                                 => -0.0021231359,
    nf_pct_rel_prop_owned = NULL                                          => 0.0171965253,
                                                                             0.0171965253);

final_score_tree_83 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 17.5 => final_score_tree_83_c520,
    iv_bureau_emergence_age >= 17.5                                   => -0.0053476045,
    iv_bureau_emergence_age = NULL                                    => 0.0010197725,
                                                                         -0.0017339527);

final_score_tree_84_c524 := map(
    (nf_historic_x_current_ct in ['1-0', '1-1', '2-0', '2-2', '3-0', '3-3']) => -0.0085657471,
    (nf_historic_x_current_ct in ['0-0', '2-1', '3-1', '3-2'])               => 0.0263755882,
    (REAL)nf_historic_x_current_ct = NULL                                          => 0.0102596450,
                                                                                0.0102596450);

final_score_tree_84_c523 := map(
    (rv_d32_criminal_x_felony in ['0-0', '1-0', '2-0', '2-2', '3-0']) => final_score_tree_84_c524,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1', '3-2', '3-3']) => 0.0581950305,
    (REAL)rv_d32_criminal_x_felony = NULL                                   => 0.0132046356,
                                                                         0.0132046356);

final_score_tree_84 := map(
    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 0.5 => -0.0055373022,
    rv_f03_input_add_not_most_rec >= 0.5                                         => final_score_tree_84_c523,
    rv_f03_input_add_not_most_rec = NULL                                         => -0.0283059220,
                                                                                    -0.0033642708);

final_score_tree_85_c527 := map(
    NULL < nf_hh_collections_ct AND nf_hh_collections_ct < 1.5 => -0.0439917711,
    nf_hh_collections_ct >= 1.5                                => 0.0291533815,
    nf_hh_collections_ct = NULL                                => 0.0017897273,
                                                                  0.0017897273);

final_score_tree_85_c526 := map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr < 4.5 => 0.0698620110,
    nf_phones_per_addr_curr >= 4.5                                   => final_score_tree_85_c527,
    nf_phones_per_addr_curr = NULL                                   => 0.0292523654,
                                                                        0.0292523654);

final_score_tree_85 := map(
    NULL < nf_inq_perssn_count12 AND nf_inq_perssn_count12 < 11.5 => -0.0025357861,
    nf_inq_perssn_count12 >= 11.5                                 => final_score_tree_85_c526,
    nf_inq_perssn_count12 = NULL                                  => -0.0196437642,
                                                                     -0.0019110827);

final_score_tree_86_c530 := map(
    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 319.5 => 0.0210003012,
    rv_c10_m_hdr_fs >= 319.5                           => -0.0168241379,
    rv_c10_m_hdr_fs = NULL                             => 0.0140686732,
                                                          0.0140686732);

final_score_tree_86_c529 := map(
    (rv_d31_all_bk in ['2 - BK DISCHARGED', '3 - BK OTHER']) => -0.0303861524,
    (rv_d31_all_bk in ['0 - NO BK', '1 - BK DISMISSED'])     => final_score_tree_86_c530,
    (REAL)rv_d31_all_bk = NULL                                     => 0.0085613856,
                                                                0.0085613856);

final_score_tree_86 := map(
    NULL < nf_fp_prevaddrcartheftindex AND nf_fp_prevaddrcartheftindex < 124.5 => -0.0102183868,
    nf_fp_prevaddrcartheftindex >= 124.5                                       => final_score_tree_86_c529,
    nf_fp_prevaddrcartheftindex = NULL                                         => 0.0015833883,
                                                                                  -0.0026204274);

final_score_tree_87_c532 := map(
    NULL < nf_inq_per_sfd_addr AND nf_inq_per_sfd_addr < 22.5 => -0.0028315434,
    nf_inq_per_sfd_addr >= 22.5                               => 0.0538382620,
    nf_inq_per_sfd_addr = NULL                                => -0.0024438106,
                                                                 -0.0024438106);

final_score_tree_87_c533 := map(
    NULL < nf_fp_prevaddrcrimeindex AND nf_fp_prevaddrcrimeindex < 137 => 0.0061714146,
    nf_fp_prevaddrcrimeindex >= 137                                    => 0.0809548769,
    nf_fp_prevaddrcrimeindex = NULL                                    => 0.0404757551,
                                                                          0.0404757551);

final_score_tree_87 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist < 0.5 => final_score_tree_87_c532,
    rv_c19_add_prison_hist >= 0.5                                  => final_score_tree_87_c533,
    rv_c19_add_prison_hist = NULL                                  => 0.0000249396,
                                                                      -0.0017873807);




// final_score_tree_88_c536 := map(
    // (nf_util_adl_summary in ['C', 'CM', 'I', 'IC']) => -0.0114661151,
    // (nf_util_adl_summary in ['ICM', 'IM', 'M'])     => 0.0631190632,
                                                       // 0.0069776671);

// final_score_tree_88_c535 := map(
    // (nf_historic_x_current_ct in ['1-1', '2-0', '2-2', '3-2', '3-3']) => final_score_tree_88_c536,
    // (nf_historic_x_current_ct in ['0-0', '1-0', '2-1', '3-0', '3-1']) => 0.0442856642,
                                                                         // 0.0196298003);

// final_score_tree_88 := map(
    // NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1.5 => -0.0035947724,
    // rv_d33_eviction_count >= 1.5                                 => final_score_tree_88_c535,
                                                                    // -0.0079875461);



final_score_tree_88_c536 := map(
    (nf_util_adl_summary in ['C', 'CM', 'I', 'IC']) => -0.0114661151,
    (nf_util_adl_summary in ['ICM', 'IM', 'M'])     => 0.0631190632,
    (REAL)nf_util_adl_summary = NULL                      => 0.0069776671,
     nf_util_adl_summary = ''                      => 0.0069776671,
                                                       0.0025106634);

final_score_tree_88_c535 := map(
    (nf_historic_x_current_ct in ['1-1', '2-0', '2-2', '3-2', '3-3']) => final_score_tree_88_c536,
    (nf_historic_x_current_ct in ['0-0', '1-0', '2-1', '3-0', '3-1']) => 0.0442856642,
    (REAL)nf_historic_x_current_ct = NULL                                   => 0.0196298003,
                                                                         0.0196298003);

final_score_tree_88 := map(
    NULL < rv_d33_eviction_count AND rv_d33_eviction_count < 1.5 => -0.0035947724,
    rv_d33_eviction_count >= 1.5                                 => final_score_tree_88_c535,
    rv_d33_eviction_count = NULL                                 => -0.0079875461,
                                                                    -0.0013459248);

final_score_tree_89_c539 := map(
    c_incollege = ''                         => 0.0222945111,
    NULL < (REAL)c_incollege AND (REAL)c_incollege < 18.05 => 0.0199637020,
    (REAL)c_incollege >= 18.05                       => 0.0897481281,
    (REAL)c_incollege = NULL                         => 0.0222945111,
                                                  0.0222945111);

final_score_tree_89_c538 := map(
    (iv_d34_liens_unrel_x_rel in ['1-1', '2-0', '2-1', '2-2', '3-1', '3-2']) => -0.0092115490,
    (iv_d34_liens_unrel_x_rel in ['0-0', '0-1', '0-2', '1-0', '1-2', '3-0']) => final_score_tree_89_c539,
    (REAL)iv_d34_liens_unrel_x_rel = NULL                                          => 0.0119565851,
                                                                                0.0119565851);

final_score_tree_89 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '2: Synth ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => -0.0080210271,
    (nf_seg_fraudpoint_3_0 in ['3: Derog'])                                                                                    => final_score_tree_89_c538,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                                               => -0.0022251650,
                                                                                                                                  -0.0022251650);

final_score_tree_90_c542 := map(
    NULL < rv_a49_curr_add_avm_pct_chg_2yr AND rv_a49_curr_add_avm_pct_chg_2yr < 0.535 => 0.0600650933,
    rv_a49_curr_add_avm_pct_chg_2yr >= 0.535                                           => -0.0095508807,
    rv_a49_curr_add_avm_pct_chg_2yr = NULL                                             => -0.0013712163,
                                                                                          -0.0038274192);

final_score_tree_90_c541 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist < 0.5 => final_score_tree_90_c542,
    rv_c19_add_prison_hist >= 0.5                                  => 0.0390700249,
    rv_c19_add_prison_hist = NULL                                  => -0.0032371925,
                                                                      -0.0032371925);

final_score_tree_90 := map(
    NULL < nf_inq_perssn_count_week AND nf_inq_perssn_count_week < 3.5 => final_score_tree_90_c541,
    nf_inq_perssn_count_week >= 3.5                                    => 0.0415197665,
    nf_inq_perssn_count_week = NULL                                    => -0.0069278872,
                                                                          -0.0028036175);

final_score_tree_91_c545 := map(
    NULL < nf_phones_per_addr_curr AND nf_phones_per_addr_curr < 4.5 => 0.0675585434,
    nf_phones_per_addr_curr >= 4.5                                   => -0.0160825325,
    nf_phones_per_addr_curr = NULL                                   => 0.0143737289,
                                                                        0.0143737289);

final_score_tree_91_c544 := map(
    c_urban_p = ''                      => 0.0303616367,
    NULL < (REAL)c_urban_p AND (REAL)c_urban_p < 95.3 => 0.0848389524,
    (REAL)c_urban_p >= 95.3                     => final_score_tree_91_c545,
    (REAL)c_urban_p = NULL                      => 0.0303616367,
                                             0.0303616367);

final_score_tree_91 := map(
    NULL < nf_inq_perssn_count12 AND nf_inq_perssn_count12 < 11.5 => -0.0030972746,
    nf_inq_perssn_count12 >= 11.5                                 => final_score_tree_91_c544,
    nf_inq_perssn_count12 = NULL                                  => 0.0032050254,
                                                                     -0.0019410160);

final_score_tree_92_c548 := map(
    c_unemp = ''                     => 0.0138750484,
    NULL < (REAL)c_unemp AND (REAL)c_unemp < 14.95 => 0.0121753920,
    (REAL)c_unemp >= 14.95                   => 0.0559887555,
    (REAL)c_unemp = NULL                     => 0.0138750484,
                                          0.0138750484);

final_score_tree_92_c547 := map(
    NULL < nf_fp_divaddrsuspidcountnew AND nf_fp_divaddrsuspidcountnew < 0.5 => -0.0073302568,
    nf_fp_divaddrsuspidcountnew >= 0.5                                       => final_score_tree_92_c548,
    nf_fp_divaddrsuspidcountnew = NULL                                       => -0.0027035931,
                                                                                -0.0027035931);

final_score_tree_92 := map(
    NULL < rv_c19_add_prison_hist AND rv_c19_add_prison_hist < 0.5 => final_score_tree_92_c547,
    rv_c19_add_prison_hist >= 0.5                                  => 0.0491169521,
    rv_c19_add_prison_hist = NULL                                  => 0.0205783416,
                                                                      -0.0015268145);

final_score_tree_93_c551 := map(
    NULL < nf_fp_srchaddrsrchcountday AND nf_fp_srchaddrsrchcountday < 0.5 => 0.0045942879,
    nf_fp_srchaddrsrchcountday >= 0.5                                      => 0.0986730001,
    nf_fp_srchaddrsrchcountday = NULL                                      => 0.0101985862,
                                                                              0.0101985862);

final_score_tree_93_c550 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 53.1 => 0.0783569188,
    rv_a49_curr_avm_chg_1yr_pct >= 53.1                                       => final_score_tree_93_c551,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                        => 0.0053579170,
                                                                                 0.0081741311);

final_score_tree_93 := map(
    NULL < nf_fp_varrisktype AND nf_fp_varrisktype < 1.5 => -0.0104783924,
    nf_fp_varrisktype >= 1.5                             => final_score_tree_93_c550,
    nf_fp_varrisktype = NULL                             => -0.0193913688,
                                                            -0.0031454989);

final_score_tree_94_c554 := map(
    NULL < rv_a49_curr_avm_chg_1yr_pct AND rv_a49_curr_avm_chg_1yr_pct < 88.55 => 0.1072999583,
    rv_a49_curr_avm_chg_1yr_pct >= 88.55                                       => 0.0565882346,
    rv_a49_curr_avm_chg_1yr_pct = NULL                                         => 0.0199892795,
                                                                                  0.0317049431);

final_score_tree_94_c553 := map(
    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 2 => 0.0031758146,
    rv_f04_curr_add_occ_index >= 2                                     => final_score_tree_94_c554,
    rv_f04_curr_add_occ_index = NULL                                   => 0.0118514081,
                                                                          0.0118514081);

final_score_tree_94 := map(
    C_OWNOCC_P = ''                        => -0.0015431303,
    NULL < (REAL)C_OWNOCC_P AND (REAL)C_OWNOCC_P < 50.95 => final_score_tree_94_c553,
    (REAL)C_OWNOCC_P >= 50.95                      => -0.0078574422,
    (REAL)C_OWNOCC_P = NULL                        => -0.0015431303,
                                                -0.0015431303);

final_score_tree_95_c557 := map(
    c_vacant_p = ''                        => 0.0090905779,
    NULL < (REAL)c_vacant_p AND (REAL)c_vacant_p < 25.15 => 0.0060130140,
    (REAL)c_vacant_p >= 25.15                      => 0.0490070405,
    (REAL)c_vacant_p = NULL                        => 0.0090905779,
                                                0.0090905779);

final_score_tree_95_c556 := map(
    NULL < nf_inq_per_addr AND nf_inq_per_addr < 11.5 => final_score_tree_95_c557,
    nf_inq_per_addr >= 11.5                           => 0.0546762682,
    nf_inq_per_addr = NULL                            => 0.0108313202,
                                                         0.0108313202);

final_score_tree_95 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 52.15 => final_score_tree_95_c556,
    rv_c12_source_profile >= 52.15                                 => -0.0079247153,
    rv_c12_source_profile = NULL                                   => 0.0015728433,
                                                                      -0.0006079077);

final_score_tree_96_c560 := map(
    NULL < nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all < 56.5 => 0.1088789962,
    nf_m_bureau_adl_fs_all >= 56.5                                  => 0.0126145982,
    nf_m_bureau_adl_fs_all = NULL                                   => 0.0337689967,
                                                                       0.0337689967);

final_score_tree_96_c559 := map(
    NULL < nf_inq_adls_per_apt_addr AND nf_inq_adls_per_apt_addr < 0.5 => -0.0112019094,
    nf_inq_adls_per_apt_addr >= 0.5                                    => final_score_tree_96_c560,
    nf_inq_adls_per_apt_addr = NULL                                    => -0.0080557327,
                                                                          -0.0080557327);

final_score_tree_96 := map(
    NULL < nf_inq_other_count24 AND nf_inq_other_count24 < 1.5 => final_score_tree_96_c559,
    nf_inq_other_count24 >= 1.5                                => 0.0119321067,
    nf_inq_other_count24 = NULL                                => -0.0088436453,
                                                                  -0.0034740090);

final_score_tree_97_c563 := map(
    NULL < nf_fp_srchunvrfdphonecount AND nf_fp_srchunvrfdphonecount < 1.5 => -0.0141612363,
    nf_fp_srchunvrfdphonecount >= 1.5                                      => 0.0450673802,
    nf_fp_srchunvrfdphonecount = NULL                                      => -0.0062329963,
                                                                              -0.0062329963);

final_score_tree_97_c562 := map(
    NULL < nf_pct_rel_prop_owned AND nf_pct_rel_prop_owned < 0.3933982684 => 0.0352645471,
    nf_pct_rel_prop_owned >= 0.3933982684                                 => final_score_tree_97_c563,
    nf_pct_rel_prop_owned = NULL                                          => 0.0118622913,
                                                                             0.0118622913);

final_score_tree_97 := map(
    NULL < iv_bureau_emergence_age AND iv_bureau_emergence_age < 17.5 => final_score_tree_97_c562,
    iv_bureau_emergence_age >= 17.5                                   => -0.0048722966,
    iv_bureau_emergence_age = NULL                                    => 0.0054049188,
                                                                         -0.0017968688);

final_score_tree_98_c566 := map(
    NULL < nf_addrs_per_bestssn_c6 AND nf_addrs_per_bestssn_c6 < 0.5 => 0.0128705719,
    nf_addrs_per_bestssn_c6 >= 0.5                                   => 0.0569130169,
    nf_addrs_per_bestssn_c6 = NULL                                   => 0.0210104297,
                                                                        0.0210104297);

final_score_tree_98_c565 := map(
    NULL < nf_inq_per_ssn AND nf_inq_per_ssn < 9.5 => -0.0074040485,
    nf_inq_per_ssn >= 9.5                          => final_score_tree_98_c566,
    nf_inq_per_ssn = NULL                          => -0.0061078451,
                                                      -0.0061078451);

final_score_tree_98 := map(
    NULL < nf_average_rel_income AND nf_average_rel_income < 45500 => 0.0164843889,
    nf_average_rel_income >= 45500                                 => final_score_tree_98_c565,
    nf_average_rel_income = NULL                                   => 0.0156704984,
                                                                      -0.0031067671);

final_score_tree_99_c568 := map(
    NULL < nf_inq_perssn_count_week AND nf_inq_perssn_count_week < 2.5 => -0.0025789463,
    nf_inq_perssn_count_week >= 2.5                                    => 0.0319174757,
    nf_inq_perssn_count_week = NULL                                    => -0.0018992822,
                                                                          -0.0018992822);

final_score_tree_99_c569 := map(
    NULL < nf_inq_lnamesperaddr_recency AND nf_inq_lnamesperaddr_recency < 2 => 0.0026589200,
    nf_inq_lnamesperaddr_recency >= 2                                        => 0.0803957918,
    nf_inq_lnamesperaddr_recency = NULL                                      => 0.0361552957,
                                                                                0.0361552957);

final_score_tree_99 := map(
    NULL < nf_inq_prepaidcards_count24 AND nf_inq_prepaidcards_count24 < 0.5 => final_score_tree_99_c568,
    nf_inq_prepaidcards_count24 >= 0.5                                       => final_score_tree_99_c569,
    nf_inq_prepaidcards_count24 = NULL                                       => -0.0157594084,
                                                                                -0.0015389823);

final_score_tree_100_c572 := map(
    NULL < nf_fp_assocrisktype AND nf_fp_assocrisktype < 3.5 => 0.0164273292,
    nf_fp_assocrisktype >= 3.5                               => 0.0508410749,
    nf_fp_assocrisktype = NULL                               => 0.0255100022,
                                                                0.0255100022);

final_score_tree_100_c571 := map(
    NULL < nf_fp_divrisktype AND nf_fp_divrisktype < 1.5 => 0.0026111928,
    nf_fp_divrisktype >= 1.5                             => final_score_tree_100_c572,
    nf_fp_divrisktype = NULL                             => 0.0079782125,
                                                            0.0079782125);

final_score_tree_100 := map(
    NULL < nf_pct_rel_prop_sold AND nf_pct_rel_prop_sold < 0.1076254826 => final_score_tree_100_c571,
    nf_pct_rel_prop_sold >= 0.1076254826                                => -0.0094743446,
    nf_pct_rel_prop_sold = NULL                                         => -0.0165165389,
                                                                           -0.0023330621);

final_score_tree_101_c574 := map(
    NULL < rv_i60_inq_other_count12 AND rv_i60_inq_other_count12 < 6.5 => -0.0043822273,
    rv_i60_inq_other_count12 >= 6.5                                    => 0.0296480168,
    rv_i60_inq_other_count12 = NULL                                    => -0.0036636677,
                                                                          -0.0036636677);

final_score_tree_101_c575 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 58 => -0.0032889551,
    iv_prv_addr_lres >= 58                            => 0.0743682025,
    iv_prv_addr_lres = NULL                           => 0.0305978045,
                                                         0.0305978045);

final_score_tree_101 := map(
    NULL < nf_inq_lnamesperaddr_count12 AND nf_inq_lnamesperaddr_count12 < 3.5 => final_score_tree_101_c574,
    nf_inq_lnamesperaddr_count12 >= 3.5                                        => final_score_tree_101_c575,
    nf_inq_lnamesperaddr_count12 = NULL                                        => -0.0089734906,
                                                                                  -0.0030008994);

final_score_tree_102_c578 := map(
    NULL < nf_inq_highriskcredit_count24 AND nf_inq_highriskcredit_count24 < 2.5 => 0.0085091393,
    nf_inq_highriskcredit_count24 >= 2.5                                         => 0.0460537020,
    nf_inq_highriskcredit_count24 = NULL                                         => 0.0125514049,
                                                                                    0.0125514049);

final_score_tree_102_c577 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency < 1.5 => -0.0051810164,
    rv_d33_eviction_recency >= 1.5                                   => final_score_tree_102_c578,
    rv_d33_eviction_recency = NULL                                   => -0.0024389625,
                                                                        -0.0024389625);

final_score_tree_102 := map(
    NULL < nf_ssns_per_curraddr_c6 AND nf_ssns_per_curraddr_c6 < 4.5 => final_score_tree_102_c577,
    nf_ssns_per_curraddr_c6 >= 4.5                                   => 0.0546476893,
    nf_ssns_per_curraddr_c6 = NULL                                   => -0.0068986640,
                                                                        -0.0020837151);

final_score_tree_103_c581 := map(
    NULL < nf_fp_curraddrburglaryindex AND nf_fp_curraddrburglaryindex < 81 => 0.0787621516,
    nf_fp_curraddrburglaryindex >= 81                                       => 0.0186941624,
    nf_fp_curraddrburglaryindex = NULL                                      => 0.0363984118,
                                                                               0.0363984118);

final_score_tree_103_c580 := map(
    NULL < nf_fp_assocrisktype AND nf_fp_assocrisktype < 1.5 => -0.0062740968,
    nf_fp_assocrisktype >= 1.5                               => final_score_tree_103_c581,
    nf_fp_assocrisktype = NULL                               => 0.0177845876,
                                                                0.0177845876);

final_score_tree_103 := map(
    NULL < rv_d32_criminal_behavior_lvl AND rv_d32_criminal_behavior_lvl < 3.5 => -0.0025293347,
    rv_d32_criminal_behavior_lvl >= 3.5                                        => final_score_tree_103_c580,
    rv_d32_criminal_behavior_lvl = NULL                                        => 0.0160074747,
                                                                                  -0.0003911170);

final_score_tree_104_c583 := map(
    NULL < rv_comb_age AND rv_comb_age < 28.5 => 0.0103477262,
    rv_comb_age >= 28.5                       => -0.0110847624,
    rv_comb_age = NULL                        => -0.0031838659,
                                                 -0.0031838659);

final_score_tree_104_c584 := map(
    NULL < iv_prv_addr_lres AND iv_prv_addr_lres < 23.5 => 0.0739061135,
    iv_prv_addr_lres >= 23.5                            => 0.0107403032,
    iv_prv_addr_lres = NULL                             => 0.0247600318,
                                                           0.0247600318);

final_score_tree_104 := map(
    NULL < rv_d30_derog_count AND rv_d30_derog_count < 12.5 => final_score_tree_104_c583,
    rv_d30_derog_count >= 12.5                              => final_score_tree_104_c584,
    rv_d30_derog_count = NULL                               => -0.0142973560,
                                                               -0.0018957474);

final_score_tree_105_c587 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 39.5 => 0.0186872036,
    nf_inq_ssn_ver_count >= 39.5                                => 0.0688867665,
    nf_inq_ssn_ver_count = NULL                                 => 0.0228647934,
                                                                   0.0228647934);

final_score_tree_105_c586 := map(
    (nf_seg_fraudpoint_3_0 in ['1: Stolen/Manip ID', '4: Recent Activity', '5: Vuln Vic/Friendly', '6: Other']) => 0.0011512983,
    (nf_seg_fraudpoint_3_0 in ['2: Synth ID', '3: Derog'])                                                      => final_score_tree_105_c587,
    (REAL)nf_seg_fraudpoint_3_0 = NULL                                                                                => 0.0091613596,
                                                                                                                   0.0091613596);

final_score_tree_105 := map(
    NULL < iv_mos_src_voter_adl_lseen AND iv_mos_src_voter_adl_lseen < 9.5 => -0.0075753800,
    iv_mos_src_voter_adl_lseen >= 9.5                                      => final_score_tree_105_c586,
    iv_mos_src_voter_adl_lseen = NULL                                      => 0.0121910063,
                                                                              -0.0028534455);

final_score_tree_106_c590 := map(
    NULL < nf_addrs_per_ssn_c6 AND nf_addrs_per_ssn_c6 < 0.5 => 0.0019432872,
    nf_addrs_per_ssn_c6 >= 0.5                               => 0.0280378079,
    nf_addrs_per_ssn_c6 = NULL                               => 0.0063469236,
                                                                0.0063469236);

final_score_tree_106_c589 := map(
    NULL < nf_inq_addr_ver_count AND nf_inq_addr_ver_count < 41.5 => final_score_tree_106_c590,
    nf_inq_addr_ver_count >= 41.5                                 => 0.0802969128,
    nf_inq_addr_ver_count = NULL                                  => 0.0086731649,
                                                                     0.0086731649);

final_score_tree_106 := map(
    NULL < nf_inq_collection_count24 AND nf_inq_collection_count24 < 0.5 => -0.0074642916,
    nf_inq_collection_count24 >= 0.5                                     => final_score_tree_106_c589,
    nf_inq_collection_count24 = NULL                                     => 0.0186534628,
                                                                            -0.0031865885);

final_score_tree_107_c593 := map(
    (rv_6seg_riskview_5_0 in ['3 ADDR NOT CURRENT - OTHER', '5 SUFFICIENTLY VERD - OWNER', '6 SUFFICIENTLY VERD - OTHER'])         => -0.0038735917,
    (rv_6seg_riskview_5_0 in ['0 TRUEDID = 0', '1 VER/VAL PROBLEMS', '2 ADDR NOT CURRENT - DEROG', '4 SUFFICIENTLY VERD - DEROG']) => 0.0306026408,
    (REAL)rv_6seg_riskview_5_0 = NULL                                                                                                    => 0.0138587434,
                                                                                                                                      0.0138587434);

final_score_tree_107_c592 := map(
    NULL < nf_inq_addr_ver_count AND nf_inq_addr_ver_count < 0.5 => -0.0063118044,
    nf_inq_addr_ver_count >= 0.5                                 => final_score_tree_107_c593,
    nf_inq_addr_ver_count = NULL                                 => 0.0051357031,
                                                                    0.0051357031);

final_score_tree_107 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 6.5 => final_score_tree_107_c592,
    iv_addr_non_phn_src_ct >= 6.5                                  => -0.0162931770,
    iv_addr_non_phn_src_ct = NULL                                  => 0.0125135334,
                                                                      -0.0015538214);

final_score_tree_108_c595 := map(
    NULL < nf_ssns_per_curraddr_c6 AND nf_ssns_per_curraddr_c6 < 4.5 => -0.0037865710,
    nf_ssns_per_curraddr_c6 >= 4.5                                   => 0.0633212825,
    nf_ssns_per_curraddr_c6 = NULL                                   => -0.0032395247,
                                                                        -0.0032395247);

final_score_tree_108_c596 := map(
    NULL < nf_inq_ssn_ver_count AND nf_inq_ssn_ver_count < 60.5 => 0.0105774949,
    nf_inq_ssn_ver_count >= 60.5                                => 0.0733952952,
    nf_inq_ssn_ver_count = NULL                                 => 0.0136289458,
                                                                   0.0136289458);

final_score_tree_108 := map(
    NULL < rv_d33_eviction_recency AND rv_d33_eviction_recency < 1.5 => final_score_tree_108_c595,
    rv_d33_eviction_recency >= 1.5                                   => final_score_tree_108_c596,
    rv_d33_eviction_recency = NULL                                   => 0.0040896896,
                                                                        -0.0004904407);

final_score_tree_109_c599 := map(
    (nf_historic_x_current_ct in ['0-0', '1-1', '2-0', '2-2', '3-0', '3-3']) => 0.0071503628,
    (nf_historic_x_current_ct in ['1-0', '2-1', '3-1', '3-2'])               => 0.0776895212,
    (REAL)nf_historic_x_current_ct = NULL                                          => 0.0257986461,
                                                                                0.0257986461);

final_score_tree_109_c598 := map(
    c_unemp = ''                     => 0.0033079755,
    NULL < (REAL)c_unemp AND (REAL)c_unemp < 13.75 => 0.0021554004,
    (REAL)c_unemp >= 13.75                   => final_score_tree_109_c599,
    (REAL)c_unemp = NULL                     => 0.0033079755,
                                          0.0033079755);

final_score_tree_109 := map(
    (iv_curr_add_mortgage_type in ['CONVENTIONAL', 'NON-TRADITIONAL', 'UNKNOWN']) => -0.0214313373,
    (iv_curr_add_mortgage_type in ['GOVERNMENT', 'NO MORTGAGE'])                  => final_score_tree_109_c598,
    (REAL)iv_curr_add_mortgage_type = NULL                                              => -0.0106400921,
    iv_curr_add_mortgage_type = ''                                              => -0.0106400921,
                                                                                     -0.0039839604);

final_score_tree_110_c602 := map(
    NULL < nf_hh_lienholders_pct AND nf_hh_lienholders_pct < 0.5277777778 => -0.0096497302,
    nf_hh_lienholders_pct >= 0.5277777778                                 => 0.0634579808,
    nf_hh_lienholders_pct = NULL                                          => 0.0036843806,
                                                                             0.0036843806);

final_score_tree_110_c601 := map(
    c_totcrime = ''                        => 0.0189123963,
    NULL < (REAL)c_totcrime AND (REAL)c_totcrime < 170.5 => final_score_tree_110_c602,
    (REAL)c_totcrime >= 170.5                      => 0.0709823858,
    (REAL)c_totcrime = NULL                        => 0.0189123963,
                                                0.0189123963);

final_score_tree_110 := map(
    NULL < nf_fp_divaddrsuspidcountnew AND nf_fp_divaddrsuspidcountnew < 1.5 => -0.0022337934,
    nf_fp_divaddrsuspidcountnew >= 1.5                                       => final_score_tree_110_c601,
    nf_fp_divaddrsuspidcountnew = NULL                                       => -0.0073432917,
                                                                                -0.0012046773);

final_score_tree_111_c604 := map(
    NULL < rv_c12_source_profile AND rv_c12_source_profile < 50.65 => 0.0092814434,
    rv_c12_source_profile >= 50.65                                 => -0.0102488340,
    rv_c12_source_profile = NULL                                   => 0.0109307825,
                                                                      -0.0031203831);

final_score_tree_111_c605 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1.5 => 0.0082851203,
    iv_addr_non_phn_src_ct >= 1.5                                  => 0.0989477255,
    iv_addr_non_phn_src_ct = NULL                                  => 0.0475897179,
                                                                      0.0475897179);

final_score_tree_111 := map(
    NULL < nf_addrs_per_ssn_c6 AND nf_addrs_per_ssn_c6 < 1.5 => final_score_tree_111_c604,
    nf_addrs_per_ssn_c6 >= 1.5                               => final_score_tree_111_c605,
    nf_addrs_per_ssn_c6 = NULL                               => -0.0019617464,
                                                                -0.0019617464);

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
    final_score_tree_111;

pbr := 0.008268463;

sbr := 0.101804000;

offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

base := 700;

pts := -50;

lgt := ln(0.0083 / 0.9917);

fp1705_1_0 := round(max((real)300, min(999, if(base + pts * (final_score_gbm_logit - offset - lgt) / ln(2) = NULL, -NULL, base + pts * (final_score_gbm_logit - offset - lgt) / ln(2)))));

_ver_src_ds := __common__( Models.Common.findw_cpp(ver_sources, 'DS' , ',', '') > 0);

_ver_src_de := __common__( Models.Common.findw_cpp(ver_sources, 'DE' , ',', '') > 0);

_ver_src_eq := __common__( Models.Common.findw_cpp(ver_sources, 'EQ' , ',', '') > 0);

_ver_src_en := __common__( Models.Common.findw_cpp(ver_sources, 'EN' , ',', '') > 0);

_ver_src_tn := __common__( Models.Common.findw_cpp(ver_sources, 'TN' , ',', '') > 0);

_ver_src_tu := __common__( Models.Common.findw_cpp(ver_sources, 'TU' , ',', '') > 0);

_credit_source_cnt := if(max((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu) = NULL, NULL, sum((integer)_ver_src_eq, (integer)_ver_src_en, (integer)_ver_src_tn, (integer)_ver_src_tu));

_ver_src_cnt := Models.Common.countw((string)(ver_sources), ' !$%&()*+,-./;<^|');

_bureauonly := _credit_source_cnt > 0 AND _credit_source_cnt = _ver_src_cnt AND (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6]));

_deceased := rc_decsflag = '1' OR rc_ssndod != 0 OR _ver_src_ds OR _ver_src_de;

_ssnpriortodob := rc_ssndobflag = '1' OR rc_pwssndobflag = '1';

_inputmiskeys := rc_ssnmiskeyflag or rc_addrmiskeyflag or (Integer)add_input_house_number_match = 0;

_multiplessns := ssns_per_adl >= 2 OR ssns_per_adl_c6 >= 1 OR invalid_ssns_per_adl >= 1;

_hh_strikes := if((integer)max((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0) = NULL, NULL, (integer)sum((integer)hh_members_w_derog > 0, (integer)hh_criminals > 0, (integer)hh_payday_loan_users > 0));

stolenid := if(addrpop and (nas_summary in [4, 7, 9]) or fnamepop and lnamepop and addrpop and 1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9 or _deceased or _ssnpriortodob, 1, 0);

manipulatedid := if(_inputmiskeys and (_multiplessns or lnames_per_adl_c6 > 1), 1, 0);

manipulatedidpt2 := if(1 <= nas_summary AND nas_summary <= 9 and inq_count03 > 0 and (integer)ssnlength = 9, 1, 0);

syntheticid := __common__( if(fnamepop and lnamepop and addrpop and ssnlength = '9' and hphnpop and nap_summary <= 4 and nas_summary <= 4 or _ver_src_cnt = 0 or _bureauonly or (Integer)add_curr_pop = 0, 1, 0));

suspiciousactivity := if(_derog, 1, 0);

vulnerablevictim := if(0 < inferred_age AND inferred_age <= 17 or inferred_age >= 70, 1, 0);

friendlyfraud := if(hh_members_ct > 1 and (hh_payday_loan_users > 0 or _hh_strikes >= 2 or rel_felony_count >= 2), 1, 0);

stolenc_fp1705_1_0 := __common__( IF((BOOLEAN) stolenid, fp1705_1_0, 299));

manip2c_fp1705_1_0 := if((boolean)(integer)manipulatedid or (boolean)(integer)manipulatedidpt2, fp1705_1_0, 299);

synthc_fp1705_1_0 := __common__(IF((BOOLEAN) syntheticid, fp1705_1_0, 299));

suspactc_fp1705_1_0 := __common__(IF((BOOLEAN) suspiciousactivity, fp1705_1_0, 299));

vulnvicc_fp1705_1_0 := __common__(IF((BOOLEAN) vulnerablevictim, fp1705_1_0, 299));

friendlyc_fp1705_1_0 := __common__(IF((BOOLEAN) friendlyfraud, fp1705_1_0, 299));

custstolidindex := map(
    stolenc_fp1705_1_0 = 299                                => 1,
    300 <= stolenc_fp1705_1_0 AND stolenc_fp1705_1_0 <= 560 => 9,
    560 < stolenc_fp1705_1_0 AND stolenc_fp1705_1_0 <= 600  => 8,
    600 < stolenc_fp1705_1_0 AND stolenc_fp1705_1_0 <= 640  => 7,
    640 < stolenc_fp1705_1_0 AND stolenc_fp1705_1_0 <= 690  => 6,
    690 < stolenc_fp1705_1_0 AND stolenc_fp1705_1_0 <= 720  => 5,
    720 < stolenc_fp1705_1_0 AND stolenc_fp1705_1_0 <= 760  => 4,
    760 < stolenc_fp1705_1_0 AND stolenc_fp1705_1_0 <= 780  => 3,
    780 < stolenc_fp1705_1_0 AND stolenc_fp1705_1_0 <= 999  => 2,
                                                               99);

custmanipidindex := map(
    manip2c_fp1705_1_0 = 299                                => 1,
    300 <= manip2c_fp1705_1_0 AND manip2c_fp1705_1_0 <= 560 => 9,
    560 < manip2c_fp1705_1_0 AND manip2c_fp1705_1_0 <= 600  => 8,
    600 < manip2c_fp1705_1_0 AND manip2c_fp1705_1_0 <= 650  => 7,
    650 < manip2c_fp1705_1_0 AND manip2c_fp1705_1_0 <= 690  => 6,
    690 < manip2c_fp1705_1_0 AND manip2c_fp1705_1_0 <= 720  => 5,
    720 < manip2c_fp1705_1_0 AND manip2c_fp1705_1_0 <= 750  => 4,
    750 < manip2c_fp1705_1_0 AND manip2c_fp1705_1_0 <= 770  => 3,
    770 < manip2c_fp1705_1_0 AND manip2c_fp1705_1_0 <= 999  => 2,
                                                               99);

custsynthidindex := map(
    synthc_fp1705_1_0 = 299                               => 1,
    300 <= synthc_fp1705_1_0 AND synthc_fp1705_1_0 <= 640 => 9,
    640 < synthc_fp1705_1_0 AND synthc_fp1705_1_0 <= 710  => 8,
    710 < synthc_fp1705_1_0 AND synthc_fp1705_1_0 <= 730  => 7,
    730 < synthc_fp1705_1_0 AND synthc_fp1705_1_0 <= 760  => 6,
    760 < synthc_fp1705_1_0 AND synthc_fp1705_1_0 <= 770  => 5,
    770 < synthc_fp1705_1_0 AND synthc_fp1705_1_0 <= 780  => 4,
    780 < synthc_fp1705_1_0 AND synthc_fp1705_1_0 <= 790  => 3,
    790 < synthc_fp1705_1_0 AND synthc_fp1705_1_0 <= 999  => 2,
                                                             99);

custsuspactindex := map(
    suspactc_fp1705_1_0 = 299                                 => 1,
    300 <= suspactc_fp1705_1_0 AND suspactc_fp1705_1_0 <= 530 => 9,
    530 < suspactc_fp1705_1_0 AND suspactc_fp1705_1_0 <= 560  => 8,
    560 < suspactc_fp1705_1_0 AND suspactc_fp1705_1_0 <= 600  => 7,
    600 < suspactc_fp1705_1_0 AND suspactc_fp1705_1_0 <= 640  => 6,
    640 < suspactc_fp1705_1_0 AND suspactc_fp1705_1_0 <= 670  => 5,
    670 < suspactc_fp1705_1_0 AND suspactc_fp1705_1_0 <= 710  => 4,
    710 < suspactc_fp1705_1_0 AND suspactc_fp1705_1_0 <= 760  => 3,
    760 < suspactc_fp1705_1_0 AND suspactc_fp1705_1_0 <= 999  => 2,
                                                                 99);

custvulnvicindex := map(
    vulnvicc_fp1705_1_0 = 299                                 => 1,
    300 <= vulnvicc_fp1705_1_0 AND vulnvicc_fp1705_1_0 <= 630 => 9,
    630 < vulnvicc_fp1705_1_0 AND vulnvicc_fp1705_1_0 <= 680  => 8,
    680 < vulnvicc_fp1705_1_0 AND vulnvicc_fp1705_1_0 <= 720  => 7,
    720 < vulnvicc_fp1705_1_0 AND vulnvicc_fp1705_1_0 <= 750  => 6,
    750 < vulnvicc_fp1705_1_0 AND vulnvicc_fp1705_1_0 <= 770  => 5,
    770 < vulnvicc_fp1705_1_0 AND vulnvicc_fp1705_1_0 <= 780  => 4,
    780 < vulnvicc_fp1705_1_0 AND vulnvicc_fp1705_1_0 <= 800  => 3,
    800 < vulnvicc_fp1705_1_0 AND vulnvicc_fp1705_1_0 <= 999  => 2,
                                                                 99);

custfriendfrdindex := map(
    friendlyc_fp1705_1_0 = 299                                  => 1,
    300 <= friendlyc_fp1705_1_0 AND friendlyc_fp1705_1_0 <= 540 => 9,
    540 < friendlyc_fp1705_1_0 AND friendlyc_fp1705_1_0 <= 580  => 8,
    580 < friendlyc_fp1705_1_0 AND friendlyc_fp1705_1_0 <= 620  => 7,
    620 < friendlyc_fp1705_1_0 AND friendlyc_fp1705_1_0 <= 650  => 6,
    650 < friendlyc_fp1705_1_0 AND friendlyc_fp1705_1_0 <= 710  => 5,
    710 < friendlyc_fp1705_1_0 AND friendlyc_fp1705_1_0 <= 750  => 4,
    750 < friendlyc_fp1705_1_0 AND friendlyc_fp1705_1_0 <= 780  => 3,
    780 < friendlyc_fp1705_1_0 AND friendlyc_fp1705_1_0 <= 999  => 2,
                                                                   99);





																																	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
                    self.sysdate                          := sysdate;
                    self.ver_src_en_pos                   := ver_src_en_pos;
                    self._ver_src_fdate_en                := _ver_src_fdate_en;
                    self.ver_src_fdate_en                 := ver_src_fdate_en;
                    self.ver_src_eq_pos                   := ver_src_eq_pos;
                    self._ver_src_fdate_eq                := _ver_src_fdate_eq;
                    self.ver_src_fdate_eq                 := ver_src_fdate_eq;
                    self.ver_src_tn_pos                   := ver_src_tn_pos;
                    self._ver_src_fdate_tn                := _ver_src_fdate_tn;
                    self.ver_src_fdate_tn                 := ver_src_fdate_tn;
                    self.ver_src_ts_pos                   := ver_src_ts_pos;
                    self._ver_src_fdate_ts                := _ver_src_fdate_ts;
                    self.ver_src_fdate_ts                 := ver_src_fdate_ts;
                    self.ver_src_tu_pos                   := ver_src_tu_pos;
                    self._ver_src_fdate_tu                := _ver_src_fdate_tu;
                    self.ver_src_fdate_tu                 := ver_src_fdate_tu;
                    self.util_type_2_pos                  := util_type_2_pos;
                    self.util_type_2                      := util_type_2;
                    self.util_type_1_pos                  := util_type_1_pos;
                    self.util_type_1                      := util_type_1;
                    self.util_type_z_pos                  := util_type_z_pos;
                    self.util_type_z                      := util_type_z;
                    self.iv_add_apt                       := iv_add_apt;
                    self.num_dob_match_level              := num_dob_match_level;
                    self.nas_summary_ver                  := nas_summary_ver;
                    self.nap_summary_ver                  := nap_summary_ver;
                    self.infutor_nap_ver                  := infutor_nap_ver;
                    self.dob_ver                          := dob_ver;
                    self.sufficiently_verified            := sufficiently_verified;
                    self.add_ec1                          := add_ec1;
                    self.addr_validation_problem          := addr_validation_problem;
                    self.phn_validation_problem           := phn_validation_problem;
                    self.validation_problem               := validation_problem;
                    self.tot_liens                        := tot_liens;
                    self.tot_liens_w_type                 := tot_liens_w_type;
                    self.has_derog                        := has_derog;
                    self.rv_6seg_riskview_5_0             := rv_6seg_riskview_5_0;
                    self._rc_ssnlowissue                  := _rc_ssnlowissue;
                    self.ssn_years                        := ssn_years;
                    self.nf_age_at_ssn_issuance           := nf_age_at_ssn_issuance;
                    self.rv_f03_input_add_not_most_rec    := rv_f03_input_add_not_most_rec;
                    self.rv_c19_add_prison_hist           := rv_c19_add_prison_hist;
                    self.rv_d30_derog_count               := rv_d30_derog_count;
                    self._felony_last_date                := _felony_last_date;
                    self._criminal_last_date              := _criminal_last_date;
                    self.rv_d32_criminal_behavior_lvl     := rv_d32_criminal_behavior_lvl;
                    self.rv_d32_criminal_count            := rv_d32_criminal_count;
                    self.rv_d32_criminal_x_felony         := rv_d32_criminal_x_felony;
                    self.rv_d31_all_bk                    := rv_d31_all_bk;
                    self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
                    self.rv_d33_eviction_count            := rv_d33_eviction_count;
                    self.iv_d34_liens_unrel_x_rel         := iv_d34_liens_unrel_x_rel;
                    self.earliest_bureau_date_all         := earliest_bureau_date_all;
                    self.nf_m_bureau_adl_fs_all           := nf_m_bureau_adl_fs_all;
                    self._header_first_seen               := _header_first_seen;
                    self.rv_c10_m_hdr_fs                  := rv_c10_m_hdr_fs;
                    self.rv_c12_source_profile            := rv_c12_source_profile;
                    self.yr_in_dob                        := yr_in_dob;
                    self.yr_in_dob_int                    := yr_in_dob_int;
                    self.rv_comb_age                      := rv_comb_age;
                    self.rv_a49_curr_avm_chg_1yr_pct      := rv_a49_curr_avm_chg_1yr_pct;
                    self.rv_f04_curr_add_occ_index        := rv_f04_curr_add_occ_index;
                    self.rv_i60_inq_count12               := rv_i60_inq_count12;
                    self.rv_i60_inq_hiriskcred_count12    := rv_i60_inq_hiriskcred_count12;
                    self.rv_i60_inq_hiriskcred_recency    := rv_i60_inq_hiriskcred_recency;
                    self.rv_i60_inq_prepaidcards_recency  := rv_i60_inq_prepaidcards_recency;
                    self.rv_i60_inq_comm_recency          := rv_i60_inq_comm_recency;
                    self.rv_i60_inq_other_count12         := rv_i60_inq_other_count12;
                    self.nf_inq_lname_ver_count           := nf_inq_lname_ver_count;
                    self.nf_inq_addr_ver_count            := nf_inq_addr_ver_count;
                    self.nf_inq_ssn_ver_count             := nf_inq_ssn_ver_count;
                    self.nf_inquiry_verification_index    := nf_inquiry_verification_index;
                    self.nf_inq_count24                   := nf_inq_count24;
                    self.nf_inq_banking_count_day         := nf_inq_banking_count_day;
                    self.nf_inq_collection_count24        := nf_inq_collection_count24;
                    self.nf_inq_communications_count24    := nf_inq_communications_count24;
                    self.nf_inq_highriskcredit_count24    := nf_inq_highriskcredit_count24;
                    self.nf_inq_other_count24             := nf_inq_other_count24;
                    self.nf_inq_prepaidcards_count24      := nf_inq_prepaidcards_count24;
                    self.nf_inq_perbestssn_count12        := nf_inq_perbestssn_count12;
                    self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
                    self.rv_l79_adls_per_sfd_addr_c6      := rv_l79_adls_per_sfd_addr_c6;
                    self.rv_c13_attr_addrs_recency        := rv_c13_attr_addrs_recency;
                    self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
                    self.mortgage_present                 := mortgage_present;
                    self.mortgage_type                    := mortgage_type;
                    self.iv_curr_add_mortgage_type        := iv_curr_add_mortgage_type;
                    self.rv_a49_curr_add_avm_pct_chg_2yr  := rv_a49_curr_add_avm_pct_chg_2yr;
                    self.iv_prv_addr_lres                 := iv_prv_addr_lres;
                    self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
                    self.nf_addrs_per_bestssn             := nf_addrs_per_bestssn;
                    self.nf_addrs_per_bestssn_c6          := nf_addrs_per_bestssn_c6;
                    self.nf_adls_per_curraddr_c6          := nf_adls_per_curraddr_c6;
                    self.nf_ssns_per_curraddr_c6          := nf_ssns_per_curraddr_c6;
                    self.iv_unverified_addr_count         := iv_unverified_addr_count;
                    self.nf_bus_addr_match_count          := nf_bus_addr_match_count;
                    self.nf_util_adl_summary              := nf_util_adl_summary;
                    self.nf_phones_per_addr_curr          := nf_phones_per_addr_curr;
                    self.nf_addrs_per_ssn_c6              := nf_addrs_per_ssn_c6;
                    self.nf_attr_arrests                  := nf_attr_arrests;
                    self.iv_estimated_income              := iv_estimated_income;
                    self.iv_wealth_index                  := iv_wealth_index;
                    self.nf_hh_pct_property_owners        := nf_hh_pct_property_owners;
                    self.nf_hh_collections_ct             := nf_hh_collections_ct;
                    self.nf_hh_lienholders_pct            := nf_hh_lienholders_pct;
                    self.nf_average_rel_income            := nf_average_rel_income;
                    self.nf_average_rel_age               := nf_average_rel_age;
                    self.nf_pct_rel_with_felony           := nf_pct_rel_with_felony;
                    self.nf_pct_rel_prop_owned            := nf_pct_rel_prop_owned;
                    self.nf_pct_rel_prop_sold             := nf_pct_rel_prop_sold;
                    self.nf_historic_x_current_ct         := nf_historic_x_current_ct;
                    self.nf_fp_sourcerisktype             := nf_fp_sourcerisktype;
                    self.nf_fp_varrisktype                := nf_fp_varrisktype;
                    self.nf_fp_srchvelocityrisktype       := nf_fp_srchvelocityrisktype;
                    self.nf_fp_srchunvrfdssncount         := nf_fp_srchunvrfdssncount;
                    self.nf_fp_srchunvrfdaddrcount        := nf_fp_srchunvrfdaddrcount;
                    self.nf_fp_srchunvrfdphonecount       := nf_fp_srchunvrfdphonecount;
                    self.nf_unvrfd_search_risk_index      := nf_unvrfd_search_risk_index;
                    self.nf_fp_srchfraudsrchcountyr       := nf_fp_srchfraudsrchcountyr;
                    self.nf_fp_assocrisktype              := nf_fp_assocrisktype;
                    self.nf_fp_divrisktype                := nf_fp_divrisktype;
                    self.nf_fp_divaddrsuspidcountnew      := nf_fp_divaddrsuspidcountnew;
                    self.nf_fp_srchcomponentrisktype      := nf_fp_srchcomponentrisktype;
                    self.nf_fp_srchaddrsrchcountmo        := nf_fp_srchaddrsrchcountmo;
                    self.nf_fp_srchaddrsrchcountday       := nf_fp_srchaddrsrchcountday;
                    self.nf_fp_curraddrmedianincome       := nf_fp_curraddrmedianincome;
                    self.nf_fp_curraddrmedianvalue        := nf_fp_curraddrmedianvalue;
                    self.nf_fp_curraddrcartheftindex      := nf_fp_curraddrcartheftindex;
                    self.nf_fp_curraddrburglaryindex      := nf_fp_curraddrburglaryindex;
                    self.nf_fp_curraddrcrimeindex         := nf_fp_curraddrcrimeindex;
                    self.nf_fp_prevaddrcartheftindex      := nf_fp_prevaddrcartheftindex;
                    self.nf_fp_prevaddrcrimeindex         := nf_fp_prevaddrcrimeindex;
                    self._in_dob                          := _in_dob;
                    self.earliest_bureau_date             := earliest_bureau_date;
                    self.earliest_bureau_yrs              := earliest_bureau_yrs;
                    self.calc_dob                         := calc_dob;
                    self.iv_bureau_emergence_age          := iv_bureau_emergence_age;
                    self.vo_pos                           := vo_pos;
                    self.vote_adl_lseen_vo                := vote_adl_lseen_vo;
                    self._vote_adl_lseen_vo               := _vote_adl_lseen_vo;
                    self.iv_mos_src_voter_adl_lseen       := iv_mos_src_voter_adl_lseen;
                    self.nf_seg_fraudpoint_3_0            := nf_seg_fraudpoint_3_0;
                    self.nf_inq_per_addr                  := nf_inq_per_addr;
                    self.nf_inquiry_adl_vel_risk_index    := nf_inquiry_adl_vel_risk_index;
                    self.nf_inq_lnamesperaddr_count12     := nf_inq_lnamesperaddr_count12;
                    self.nf_inq_peraddr_count12           := nf_inq_peraddr_count12;
                    self.nf_inq_perssn_count_week         := nf_inq_perssn_count_week;
                    self.nf_inq_perssn_count12            := nf_inq_perssn_count12;
                    self.nf_inquiry_addr_vel_risk_index   := nf_inquiry_addr_vel_risk_index;
                    self.nf_inquiry_addr_vel_risk_indexv2 := nf_inquiry_addr_vel_risk_indexv2;
                    self.nf_inq_per_sfd_addr              := nf_inq_per_sfd_addr;
                    self.nf_invbest_inq_adlsperaddr_diff  := nf_invbest_inq_adlsperaddr_diff;
                    self.nf_inq_adls_per_addr             := nf_inq_adls_per_addr;
                    self.nf_inq_lnames_per_addr           := nf_inq_lnames_per_addr;
                    self.nf_inq_adls_per_apt_addr         := nf_inq_adls_per_apt_addr;
                    self.nf_inq_per_ssn                   := nf_inq_per_ssn;
                    self.nf_inq_lnamesperaddr_recency     := nf_inq_lnamesperaddr_recency;
                    self.final_score_tree_0               := final_score_tree_0;
                    self.final_score_tree_1               := final_score_tree_1;
                    self.final_score_tree_2               := final_score_tree_2;
                    self.final_score_tree_3               := final_score_tree_3;
                    self.final_score_tree_4               := final_score_tree_4;
                    self.final_score_tree_5               := final_score_tree_5;
                    self.final_score_tree_6               := final_score_tree_6;
                    self.final_score_tree_7               := final_score_tree_7;
                    self.final_score_tree_8               := final_score_tree_8;
                    self.final_score_tree_9               := final_score_tree_9;
                    self.final_score_tree_10              := final_score_tree_10;
                    self.final_score_tree_11              := final_score_tree_11;
                    self.final_score_tree_12              := final_score_tree_12;
                    self.final_score_tree_13              := final_score_tree_13;
                    self.final_score_tree_14              := final_score_tree_14;
                    self.final_score_tree_15              := final_score_tree_15;
                    self.final_score_tree_16              := final_score_tree_16;
                    self.final_score_tree_17              := final_score_tree_17;
                    self.final_score_tree_18              := final_score_tree_18;
                    self.final_score_tree_19              := final_score_tree_19;
                    self.final_score_tree_20              := final_score_tree_20;
                    self.final_score_tree_21              := final_score_tree_21;
                    self.final_score_tree_22              := final_score_tree_22;
                    self.final_score_tree_23              := final_score_tree_23;
                    self.final_score_tree_24              := final_score_tree_24;
                    self.final_score_tree_25              := final_score_tree_25;
                    self.final_score_tree_26              := final_score_tree_26;
                    self.final_score_tree_27              := final_score_tree_27;
                    self.final_score_tree_28              := final_score_tree_28;
                    self.final_score_tree_29              := final_score_tree_29;
                    self.final_score_tree_30              := final_score_tree_30;
                    self.final_score_tree_31              := final_score_tree_31;
                    self.final_score_tree_32              := final_score_tree_32;
                    self.final_score_tree_33              := final_score_tree_33;
                    self.final_score_tree_34              := final_score_tree_34;
                    self.final_score_tree_35              := final_score_tree_35;
                    self.final_score_tree_36              := final_score_tree_36;
                    self.final_score_tree_37              := final_score_tree_37;
                    self.final_score_tree_38              := final_score_tree_38;
                    self.final_score_tree_39              := final_score_tree_39;
                    self.final_score_tree_40              := final_score_tree_40;
                    self.final_score_tree_41              := final_score_tree_41;
                    self.final_score_tree_42              := final_score_tree_42;
                    self.final_score_tree_43              := final_score_tree_43;
                    self.final_score_tree_44              := final_score_tree_44;
                    self.final_score_tree_45              := final_score_tree_45;
                    self.final_score_tree_46              := final_score_tree_46;
                    self.final_score_tree_47              := final_score_tree_47;
                    self.final_score_tree_48              := final_score_tree_48;
                    self.final_score_tree_49              := final_score_tree_49;
                    self.final_score_tree_50              := final_score_tree_50;
                    self.final_score_tree_51              := final_score_tree_51;
                    self.final_score_tree_52              := final_score_tree_52;
                    self.final_score_tree_53              := final_score_tree_53;
                    self.final_score_tree_54              := final_score_tree_54;
                    self.final_score_tree_55              := final_score_tree_55;
                    self.final_score_tree_56              := final_score_tree_56;
                    self.final_score_tree_57              := final_score_tree_57;
                    self.final_score_tree_58              := final_score_tree_58;
                    self.final_score_tree_59              := final_score_tree_59;
                    self.final_score_tree_60              := final_score_tree_60;
                    self.final_score_tree_61              := final_score_tree_61;
                    self.final_score_tree_62              := final_score_tree_62;
                    self.final_score_tree_63              := final_score_tree_63;
                    self.final_score_tree_64              := final_score_tree_64;
                    self.final_score_tree_65              := final_score_tree_65;
                    self.final_score_tree_66              := final_score_tree_66;
                    self.final_score_tree_67              := final_score_tree_67;
                    self.final_score_tree_68              := final_score_tree_68;
                    self.final_score_tree_69              := final_score_tree_69;
                    self.final_score_tree_70              := final_score_tree_70;
                    self.final_score_tree_71              := final_score_tree_71;
                    self.final_score_tree_72              := final_score_tree_72;
                    self.final_score_tree_73              := final_score_tree_73;
                    self.final_score_tree_74              := final_score_tree_74;
                    self.final_score_tree_75              := final_score_tree_75;
                    self.final_score_tree_76              := final_score_tree_76;
                    self.final_score_tree_77              := final_score_tree_77;
                    self.final_score_tree_78              := final_score_tree_78;
                    self.final_score_tree_79              := final_score_tree_79;
                    self.final_score_tree_80              := final_score_tree_80;
                    self.final_score_tree_81              := final_score_tree_81;
                    self.final_score_tree_82              := final_score_tree_82;
                    self.final_score_tree_83              := final_score_tree_83;
                    self.final_score_tree_84              := final_score_tree_84;
                    self.final_score_tree_85              := final_score_tree_85;
                    self.final_score_tree_86              := final_score_tree_86;
                    self.final_score_tree_87              := final_score_tree_87;
                    self.final_score_tree_88              := final_score_tree_88;
                    self.final_score_tree_89              := final_score_tree_89;
                    self.final_score_tree_90              := final_score_tree_90;
                    self.final_score_tree_91              := final_score_tree_91;
                    self.final_score_tree_92              := final_score_tree_92;
                    self.final_score_tree_93              := final_score_tree_93;
                    self.final_score_tree_94              := final_score_tree_94;
                    self.final_score_tree_95              := final_score_tree_95;
                    self.final_score_tree_96              := final_score_tree_96;
                    self.final_score_tree_97              := final_score_tree_97;
                    self.final_score_tree_98              := final_score_tree_98;
                    self.final_score_tree_99              := final_score_tree_99;
                    self.final_score_tree_100             := final_score_tree_100;
                    self.final_score_tree_101             := final_score_tree_101;
                    self.final_score_tree_102             := final_score_tree_102;
                    self.final_score_tree_103             := final_score_tree_103;
                    self.final_score_tree_104             := final_score_tree_104;
                    self.final_score_tree_105             := final_score_tree_105;
                    self.final_score_tree_106             := final_score_tree_106;
                    self.final_score_tree_107             := final_score_tree_107;
                    self.final_score_tree_108             := final_score_tree_108;
                    self.final_score_tree_109             := final_score_tree_109;
                    self.final_score_tree_110             := final_score_tree_110;
                    self.final_score_tree_111             := final_score_tree_111;
                    self.final_score_gbm_logit            := final_score_gbm_logit;
                    self.pbr                              := pbr;
                    self.sbr                              := sbr;
                    self.offset                           := offset;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.fp1705_1_0                       := fp1705_1_0;
                    self._ver_src_ds                      := _ver_src_ds;
                    self._ver_src_de                      := _ver_src_de;
                    self._ver_src_eq                      := _ver_src_eq;
                    self._ver_src_en                      := _ver_src_en;
                    self._ver_src_tn                      := _ver_src_tn;
                    self._ver_src_tu                      := _ver_src_tu;
                    self._credit_source_cnt               := _credit_source_cnt;
                    self._ver_src_cnt                     := _ver_src_cnt;
                    self._bureauonly                      := _bureauonly;
                    self._derog                           := _derog;
                    self._deceased                        := _deceased;
                    self._ssnpriortodob                   := _ssnpriortodob;
                    self._inputmiskeys                    := _inputmiskeys;
                    self._multiplessns                    := _multiplessns;
                    self._hh_strikes                      := _hh_strikes;
                    self.stolenid                         := stolenid;
                    self.manipulatedid                    := manipulatedid;
                    self.manipulatedidpt2                 := manipulatedidpt2;
                    self.syntheticid                      := syntheticid;
                    self.suspiciousactivity               := suspiciousactivity;
                    self.vulnerablevictim                 := vulnerablevictim;
                    self.friendlyfraud                    := friendlyfraud;
                    self.stolenc_fp1705_1_0               := stolenc_fp1705_1_0;
                    self.manip2c_fp1705_1_0               := manip2c_fp1705_1_0;
                    self.synthc_fp1705_1_0                := synthc_fp1705_1_0;
                    self.suspactc_fp1705_1_0              := suspactc_fp1705_1_0;
                    self.vulnvicc_fp1705_1_0              := vulnvicc_fp1705_1_0;
                    self.friendlyc_fp1705_1_0             := friendlyc_fp1705_1_0;
                    self.custstolidindex                  := custstolidindex;
                    self.custmanipidindex                 := custmanipidindex;
                    self.custsynthidindex                 := custsynthidindex;
                    self.custsuspactindex                 := custsuspactindex;
                    self.custvulnvicindex                 := custvulnvicindex;
                    self.custfriendfrdindex               := custfriendfrdindex;
                    SELF.addrpop                          := (STRING)addrpop;
                    SELF.inq_adlspercurraddr              := (STRING)inq_adlspercurraddr;
                    SELF.inq_peraddr                      := (STRING)inq_peraddr;
                    // self.seq 															:= le.seq;
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
	reasons := Models.Common.checkFraudPointRC34(FP1705_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1705_1_0;
	self := [];
 

END;
 
model :=   join(clam, Easi.Key_Easi_Census,
		(left.shell_input.st<>'' 
      and left.shell_input.county <>''	
      and left.shell_input.geo_blk <> '' 
      and left.addrpop 
      and keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk)) 
    or
		 //to match the modeler's code, search by current address as well but only if the input geo link fields are all blank
		 //(left.shell_input.st= '' and left.shell_input.county =''	and left.shell_input.geo_blk = '' and
		(left.addrpop2 
      and ~left.addrpop 
      and left.Address_Verification.Address_History_1.st<>'' 
      and left.Address_Verification.Address_History_1.county <>''	
      and left.Address_Verification.Address_History_1.geo_blk <> '' 
      and keyed(right.geolink=left.Address_Verification.Address_History_1.st+left.Address_Verification.Address_History_1.county+left.Address_Verification.Address_History_1.geo_blk)), 
		doModel(left, right), left outer,
		atmost(RiskWise.max_atmost)
		,keep(1));
	
	return model;

  
END;


