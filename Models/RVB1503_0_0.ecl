IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, std, riskview;

EXPORT RVB1503_0_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN lexIDOnlyOnInput = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			/* Model Input Variables for RVB1503_0*/
			STRING15 model_name;
			unsigned4 seq;
			BOOLEAN truedid;
		  STRING5 out_z5;															 
			STRING out_addr_status;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING nap_status;
			INTEGER rc_ssndod;
			BOOLEAN rc_input_addr_not_most_recent;
			STRING1 rc_hriskphoneflag;                
			STRING1 rc_hphonetypeflag;                
			STRING1 rc_phonevalflag;
			STRING rc_hphonevalflag;
			STRING1 rc_hriskaddrflag;                 
			STRING1 rc_decsflag;                       
			STRING rc_ssndobflag;
			STRING rc_pwssndobflag;
			STRING rc_addrvalflag;
			STRING rc_addrcommflag;
			STRING rc_hrisksic;
			STRING rc_hrisksicphone;
			STRING rc_phonetype;
			STRING rc_ziptypeflag;
			INTEGER combo_dobscore;
			DECIMAL14_1 hdr_source_profile;         
			QSTRING100 ver_sources;                
		  STRING1 ssnlength;
			BOOLEAN dobpop;
			BOOLEAN hphnpop;                       
			INTEGER add_input_address_score;
			BOOLEAN add_input_isbestmatch;
			BOOLEAN add_input_addr_not_verified;    
			BOOLEAN add_input_owned_not_occ;        
			STRING add_input_advo_vacancy;
			STRING add_input_advo_res_or_bus;
			INTEGER add_input_avm_auto_val;
			INTEGER add_input_naprop;
			BOOLEAN add_input_pop;
			INTEGER property_owned_total;
			BOOLEAN add_curr_isbestmatch;          
			INTEGER1 add_curr_occ_index;           
			INTEGER add_curr_avm_auto_val;
			INTEGER add_curr_naprop;
			BOOLEAN add_curr_pop;
			INTEGER add_prev_naprop;
			INTEGER addrs_15yr;
			STRING telcordia_type;
			INTEGER header_first_seen;
			INTEGER ssns_per_adl;
			INTEGER adls_per_ssn;
			INTEGER adls_per_addr_curr;
			INTEGER ssns_per_addr_curr;
			INTEGER invalid_ssns_per_adl;
			unsigned1 invalid_addrs_per_adl;      
			STRING9 pb_total_dollars;            
			STRING4 pb_total_orders;              
			INTEGER br_source_count;
			INTEGER infutor_nap;
			INTEGER stl_inq_count12;
			INTEGER attr_total_number_derogs;
			UNSIGNED1 attr_num_unrel_liens30;             
			UNSIGNED1 attr_num_unrel_liens90;           
			UNSIGNED1 attr_num_unrel_liens180;          
			UNSIGNED1 attr_num_unrel_liens12;           
			UNSIGNED1 attr_num_unrel_liens24;           
			UNSIGNED1 attr_num_unrel_liens36;           
			UNSIGNED1 attr_num_unrel_liens60;           
			UNSIGNED1 attr_num_rel_liens30;             
			UNSIGNED1 attr_num_rel_liens90;             
			UNSIGNED1 attr_num_rel_liens180;             
			UNSIGNED1 attr_num_rel_liens12;              
			UNSIGNED1 attr_num_rel_liens24;              
			UNSIGNED1 attr_num_rel_liens36;              
			UNSIGNED1 attr_num_rel_liens60;              
			INTEGER attr_eviction_count;
			INTEGER attr_eviction_count90;
			INTEGER attr_eviction_count180;
			INTEGER attr_eviction_count12;
			INTEGER attr_eviction_count24;
			INTEGER attr_eviction_count36;
			INTEGER attr_eviction_count60;
			INTEGER attr_num_nonderogs;
			BOOLEAN bankrupt;
			STRING disposition;
			INTEGER filing_count;
			INTEGER bk_dismissed_recent_count;
			INTEGER bk_dismissed_historical_count;
			UNSIGNED1 bk_disposed_recent_count;          
			UNSIGNED1 bk_disposed_historical_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_recent_released_count;
			INTEGER liens_historical_released_count;
			INTEGER liens_unrel_cj_ct;
			INTEGER liens_rel_cj_ct;
			INTEGER liens_unrel_ft_ct;
			INTEGER liens_rel_ft_ct;
			INTEGER liens_unrel_fc_ct;
			INTEGER liens_rel_fc_ct;
			INTEGER liens_unrel_lt_ct;
			INTEGER liens_rel_lt_ct;
			INTEGER liens_unrel_o_ct;
			INTEGER liens_rel_o_ct;
			INTEGER liens_unrel_ot_ct;
			INTEGER liens_rel_ot_ct;
			INTEGER liens_unrel_sc_ct;
			INTEGER liens_rel_sc_ct;
			INTEGER liens_unrel_st_ct;
			INTEGER liens_rel_st_ct;
			INTEGER criminal_count;
			INTEGER felony_count;
			STRING college_file_type;
			BOOLEAN college_attendance;
			BOOLEAN prof_license_flag;
			STRING1 input_dob_match_level;

			/* Model Intermediate Variables */
			INTEGER num_dob_match_level;
      INTEGER nas_summary_ver;
			INTEGER nap_summary_ver;
			INTEGER infutor_nap_ver;
			INTEGER dob_ver;
			INTEGER sufficiently_verified;
			STRING add_ec1;
 
			INTEGER addr_validation_problem;
			INTEGER phn_validation_problem;
			INTEGER validation_problem;
			INTEGER tot_liens;
			INTEGER tot_liens_w_type;
			INTEGER has_derog;
			STRING18 rv_4seg_riskview_5_0;
			BOOLEAN verprob_seg;
			BOOLEAN derog_seg;
			BOOLEAN propowner_seg;
			BOOLEAN other_seg;
			INTEGER sysdate;
			STRING iv_rv5_unscorable;
			STRING rv_a44_prop_owner_inp_only;
			INTEGER rv_a44_curr_add_naprop;
			STRING rv_prop_owner_history;
			INTEGER rv_a47_curr_avm_autoval;
			INTEGER rv_a50_pb_total_orders;
			INTEGER rv_a50_pb_total_dollars;
			INTEGER _header_first_seen;
			
			INTEGER rv_c10_m_hdr_fs;
			DECIMAL21_1 rv_c12_source_profile;
			INTEGER rv_c12_num_nonderogs;
			INTEGER rv_c14_addrs_15yr;
			INTEGER rv_c18_invalid_addrs_per_adl;
			INTEGER rv_c22_inp_addr_owned_not_occ;
			INTEGER rv_d30_derog_count;
			STRING rv_d31_all_bk;
			INTEGER rv_d31_bk_filing_count;
			STRING rv_d32_criminal_x_felony;
			STRING rv_d33_eviction_recency;
			INTEGER rv_d34_unrel_liens_ct;
			INTEGER rv_d34_attr_liens_recency;
			STRING rv_e55_college_ind;
			INTEGER rv_e57_prof_license_br_flag;
			INTEGER rv_f00_addr_not_ver_w_ssn;
			INTEGER rv_f00_dob_score;
			INTEGER rv_f01_inp_addr_address_score;
			INTEGER rv_f01_inp_addr_not_verified;
			STRING26 rv_f03_address_match;
			INTEGER rv_f03_input_add_not_most_rec;
			INTEGER rv_f04_curr_add_occ_index;
			INTEGER rv_s66_adlperssn_count;
			INTEGER rv_l80_inp_avm_autoval;
			STRING rv_p85_phn_disconnected;
			
			real verprob_subscore0;
			real verprob_subscore1;
			real verprob_subscore2;
			real verprob_subscore3;
			real verprob_subscore4;
			real verprob_subscore5;
			real verprob_subscore6;
			real verprob_subscore7;
			real verprob_subscore8;
			real verprob_subscore9;
			real verprob_subscore10;
			real verprob_rawscore;
			real verprob_lnoddsscore;
			real verprob_probscore;
			STRING verprob_aacd_0;
			REAL verprob_dist_0_1;
			STRING verprob_aacd_1;
			REAL verprob_dist_1;
			STRING verprob_aacd_2;
			REAL verprob_dist_2;
			STRING verprob_aacd_3;
			REAL verprob_dist_3;
			STRING verprob_aacd_4;
			REAL verprob_dist_4;
			STRING verprob_aacd_5;
			REAL verprob_dist_5;
			STRING verprob_aacd_6;
			REAL verprob_dist_6;
			STRING verprob_aacd_7;
			REAL verprob_dist_7;
			STRING verprob_aacd_8_1;
			REAL verprob_dist_8_1;
			REAL verprob_dist_8;
			STRING verprob_aacd_8;
			REAL verprob_dist_0;
			STRING verprob_aacd_9;
			REAL verprob_dist_9;
			STRING verprob_aacd_10;
			REAL verprob_dist_10;
			
			REAL derog_subscore0;
			REAL derog_subscore1;
			REAL derog_subscore2;
			REAL derog_subscore3;
			REAL derog_subscore4;
			REAL derog_subscore5;
			REAL derog_subscore6;
			REAL derog_subscore7;
			REAL derog_subscore8;
			REAL derog_subscore9;
			REAL derog_rawscore;
			REAL derog_lnoddsscore;
			REAL derog_probscore;
			STRING derog_aacd_0;
			REAL derog_dist_0;
			STRING derog_aacd_1;
			REAL derog_dist_1;
			STRING derog_aacd_2;
			REAL derog_dist_2;
			STRING derog_aacd_3;
			REAL derog_dist_3;
			STRING derog_aacd_4;
			REAL derog_dist_4;
			STRING derog_aacd_5;
			REAL derog_dist_5;
			STRING derog_aacd_6;
			REAL derog_dist_6;
			STRING derog_aacd_7;
			REAL derog_dist_7;
			STRING derog_aacd_8;
			REAL derog_dist_8;
			STRING derog_aacd_9;
			REAL derog_dist_9;
			
			REAL propowner_subscore0;
			REAL propowner_subscore1;
			REAL propowner_subscore2;
			REAL propowner_subscore3;
			REAL propowner_subscore4;
			REAL propowner_subscore5;
			REAL propowner_subscore6;
			REAL propowner_subscore7;
			REAL propowner_subscore8;
			REAL propowner_subscore9;
			REAL propowner_subscore10;
			REAL propowner_subscore11;
			REAL propowner_subscore12;
			REAL propowner_subscore13;
			REAL propowner_subscore14;
			REAL propowner_rawscore;
			REAL propowner_lnoddsscore;
			REAL propowner_probscore;
			STRING propowner_aacd_0;
			REAL propowner_dist_0;
			STRING propowner_aacd_1;
			REAL propowner_dist_1;
			STRING propowner_aacd_2;
			REAL propowner_dist_2;
			STRING propowner_aacd_3;
			REAL propowner_dist_3;
			STRING propowner_aacd_4;
			REAL propowner_dist_4;
			STRING propowner_aacd_5;
			REAL propowner_dist_5;
			STRING propowner_aacd_6;
			REAL propowner_dist_6;
			STRING propowner_aacd_7;
			REAL propowner_dist_7;
			STRING propowner_aacd_8;
			REAL propowner_dist_8;
			STRING propowner_aacd_9;
			REAL propowner_dist_9;
			STRING propowner_aacd_10;
			REAL propowner_dist_10;
			STRING propowner_aacd_11;
			REAL propowner_dist_11;
			STRING propowner_aacd_12;
			REAL propowner_dist_12;
			STRING propowner_aacd_13;
			REAL propowner_dist_13;
			STRING propowner_aacd_14;
			REAL propowner_dist_14;
			
			REAL other_subscore0;
			REAL other_subscore1;
			REAL other_subscore2;
			REAL other_subscore3;
			REAL other_subscore4;
			REAL other_subscore5;
			REAL other_subscore6;
			REAL other_subscore7;
			REAL other_subscore8;
			REAL other_subscore9;
			REAL other_subscore10;
			REAL other_subscore11;
			REAL other_rawscore;
			REAL other_lnoddsscore;
			REAL other_probscore;
			STRING other_aacd_0;
			REAL other_dist_0;
			STRING other_aacd_1;
			REAL other_dist_1;
			STRING other_aacd_2;
			REAL other_dist_2;
			STRING other_aacd_3;
			REAL other_dist_3;
			STRING other_aacd_4;
			REAL other_dist_4;
			STRING other_aacd_5;
			REAL other_dist_5;
			STRING other_aacd_6;
			REAL other_dist_6;
			STRING other_aacd_7;
			REAL other_dist_7;
			STRING other_aacd_8;
			REAL other_dist_8;
			STRING other_aacd_9;
			REAL other_dist_9;
			STRING other_aacd_10;
			REAL other_dist_10;
			STRING other_aacd_11;
			REAL other_dist_11;
			
			INTEGER base;
			INTEGER points;
			INTEGER odds;
			REAL lnoddsscore;
			INTEGER score_lnodds;
			INTEGER score_lnodds_capped;
			BOOLEAN ov_ssnprior;
			BOOLEAN ov_corrections;
			INTEGER deceased;
			INTEGER _ov_pts_lost_c142_b3;
			
//  The final score is returned back to the customer			
			INTEGER rvb1503_0_1;
			
			REAL _ov_pts_lost_raw;
			STRING _rc_seg_c145;
			STRING _rc_seg_c146;
			STRING _rc_seg_c144;
			STRING _rc_seg_c147;
			STRING _rc_seg;
			
			REAL verprob_dist_11;
			STRING verprob_aacd_11;
			
			REAL verprob_rcvaluea47;
			REAL verprob_rcvaluel73;
			REAL verprob_rcvaluel80;
			REAL verprob_rcvalued30;
			REAL verprob_rcvaluea50;
			REAL verprob_rcvaluef01;
			REAL verprob_rcvaluef00;
			REAL verprob_rcvaluea41;
			REAL verprob_rcvaluee55;
			REAL verprob_rcvaluec12;
			REAL verprob_rcvalues66;
			REAL verprob_rcvalueS65;
			REAL verprob_rcvaluec14;
			
			REAL derog_dist_10;
			STRING derog_aacd_10;
			
			REAL derog_rcvaluea50;
			REAL derog_rcvaluef04;
			REAL derog_rcvaluel73;
			REAL derog_rcvalueS65;
			REAL derog_rcvalued32;
			REAL derog_rcvalued33;
			REAL derog_rcvaluea47;
			REAL derog_rcvaluea42;
			REAL derog_rcvaluec12;
			REAL derog_rcvaluee55;
			REAL derog_rcvaluef01;
			REAL derog_rcvaluee57;
			
			REAL propowner_dist_15;
			STRING propowner_aacd_15;
			
			REAL propowner_rcvaluec22;
			REAL propowner_rcvaluea50;
			REAL propowner_rcvaluel73;
			REAL propowner_rcvalued34;
			REAL propowner_rcvaluep85;
			REAL propowner_rcvalued31;
			REAL propowner_rcvaluea47;
			REAL propowner_rcvaluea44;
			REAL propowner_rcvaluef01;
			REAL propowner_rcvaluef03;
			REAL propowner_rcvalueS65;
			REAL propowner_rcvaluee55;
			REAL propowner_rcvaluec12;
			REAL propowner_rcvalues66;
			REAL propowner_rcvaluec14;
			
			REAL other_dist_12;
			STRING other_aacd_12;
			REAL other_rcvaluea47;
			REAL other_rcvaluel73;
			REAL other_rcvalued34;
			REAL other_rcvalueS65;
			REAL other_rcvaluec12;
			REAL other_rcvalued31;
			REAL other_rcvaluea50;
			REAL other_rcvaluea44;
			REAL other_rcvaluec18;
			REAL other_rcvaluef01;
			REAL other_rcvaluef03;
			REAL other_rcvaluea41;
			REAL other_rcvaluee55;
			REAL other_rcvaluec10;
			REAL other_rcvaluec14;
			 
			STRING propowner_rc1;
			STRING propowner_rc2;
			STRING propowner_rc3;
			STRING propowner_rc4;
			REAL propowner_vl1;
			REAL propowner_vl2;
			REAL propowner_vl3;
			REAL propowner_vl4;
			
			STRING other_rc1;
			STRING other_rc2;
			STRING other_rc3;
			STRING other_rc4;
			REAL other_vl1;
			REAL other_vl2;
			REAL other_vl3;
			REAL other_vl4;
			
			STRING verprob_rc1;
			STRING verprob_rc2;
			STRING verprob_rc3;
			STRING verprob_rc4;
			REAL verprob_vl1;
			REAL verprob_vl2;
			REAL verprob_vl3;
			REAL verprob_vl4;
			
			STRING derog_rc1;
			STRING derog_rc2;
			STRING derog_rc3;
			STRING derog_rc4;
			REAL derog_vl1;
			REAL derog_vl2;
			REAL derog_vl3;
			REAL derog_vl4;
			
			STRING rc1_2;
			STRING rc3_1;
			STRING rc2_1;
			STRING rc4_1;
			STRING rc1_1;
			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
			STRING4 rc5;
			 
			Models.Layout_ModelOut; 
		  Risk_Indicators.Layout_Boca_Shell clam;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	seq                              := le.seq;
	out_z5                           := le.shell_input.z5;
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
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
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	hdr_source_profile               := le.source_profile;
	ver_sources                      := le.header_summary.ver_sources;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_addr_not_verified      := le.address_verification.inputAddr_not_verified;
	add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
	add_input_advo_vacancy           := le.advo_input_addr.Address_Vacancy_Indicator	;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind	;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_occ_index               := le.address_verification.currAddr_occupancy_index;
	add_curr_avm_auto_val            := le.avm.address_history_1.avm_automated_valuation;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	telcordia_type                   := le.phone_verification.telcordia_type;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
  adls_per_ssn                     := le.SSN_Verification.adlperssn_count;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	ssns_per_addr_curr               := le.velocity_counters.ssns_per_addr_current;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
  stl_inq_count12                  := le.impulse.count12;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
	attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_num_rel_liens30             := le.bjl.liens_released_count30;
	attr_num_rel_liens90             := le.bjl.liens_released_count90;
	attr_num_rel_liens180            := le.bjl.liens_released_count180;
	attr_num_rel_liens12             := le.bjl.liens_released_count12;
	attr_num_rel_liens24             := le.bjl.liens_released_count24;
	attr_num_rel_liens36             := le.bjl.liens_released_count36;
	attr_num_rel_liens60             := le.bjl.liens_released_count60;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
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
	felony_count                     := le.bjl.felony_count;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	prof_license_flag                := le.professional_license.professional_license_flag;
	input_dob_match_level            := le.dobmatchlevel;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
//==============================================================
//=             Start populating/setting the                   =
//=             intermediate variables and risk indicators     =
//==============================================================

	NULL := -999999999;
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

//====================================================================
//===   Determine if this consumer has been sufficiently verified   ===
//====================================================================	
	num_dob_match_level := (integer)input_dob_match_level; 
	nas_summary_ver := if((integer)ssnlength > 0 and (nas_summary in [8, 9, 10, 11, 12]) or (nas_summary in [2, 4, 7]) and add_input_isbestmatch, 1, 0);
	nap_summary_ver := if(hphnpop and (nap_summary in [9, 10, 11, 12]), 1, 0);
	infutor_nap_ver := if(hphnpop and (infutor_nap in [9, 10, 11, 12]), 1, 0);
	dob_ver := if(dobpop and num_dob_match_level >= 5, 1, 0);
	
	sufficiently_verified := map(
	    (boolean)(integer)nas_summary_ver and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver)          => 1,
	    (boolean)(integer)nas_summary_ver and ((boolean)(integer)dob_ver or not(dobpop))                                        => 1,
	    ((boolean)(integer)dob_ver or not(dobpop)) and ((boolean)(integer)nap_summary_ver or (boolean)(integer)infutor_nap_ver) => 1,
	                                                                                                                               0);
//====================================================================
//===   Determine if this consumer has any address problems        ===
//====================================================================			
	add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];
 
	addr_validation_problem := if(add_ec1 = 'E' and not(rc_addrvalflag = 'N') 
	                             or rc_hriskaddrflag = '4' 
															 or rc_addrcommflag = '2' 
															 or (add_input_advo_res_or_bus in ['B', 'D']) 
															 or not(out_z5 = '') and (rc_hriskaddrflag = '2' or rc_ziptypeflag = '2') 
															 or add_input_advo_vacancy = 'Y', 1, 0);

//====================================================================
//===   Determine if this consumer has any phone problems          ===
//====================================================================		
	phn_validation_problem := if(rc_hphonetypeflag = 'A' 
	                             or (integer)rc_hriskphoneflag = 2 
															 or rc_hphonetypeflag = '2' 
															 or (telcordia_type in ['02', '56', '61']) 
	                             or (integer)rc_phonevalflag = 0 
															 or (integer)rc_hphonevalflag = 0 
															 or (integer)rc_phonetype = 5 
															 or (integer)rc_hriskphoneflag = 6 
															 or rc_hphonetypeflag = '5' 
															 or (integer)rc_hphonevalflag = 3 
															 or (integer)rc_addrcommflag = 1, 1, 0);

//====================================================================
//===   Determine if this consumer has any validation problems     ===
//====================================================================	
	validation_problem := if(adls_per_ssn >= 5 
	                         or ssns_per_adl >= 4 
													 or invalid_ssns_per_adl >= 1 
													 or adls_per_addr_curr >= 8 
													 or ssns_per_addr_curr >= 7 
													 or (integer)rc_hrisksic = 2225 
													 or (integer)rc_hrisksicphone = 2225 
													 or (boolean)(integer)addr_validation_problem 
													 or (boolean)(integer)phn_validation_problem 
													 or (integer)rc_ssndobflag = 1 
													 or (integer)rc_pwssndobflag = 1, 1, 0);

//====================================================================
//===   Determine if this consumer has any liens                   ===
//====================================================================		
	tot_liens := liens_historical_unreleased_ct +
	    liens_recent_unreleased_count +
	    liens_recent_released_count +
	    liens_historical_released_count;
	
	tot_liens_w_type := liens_unrel_LT_ct +
	    liens_rel_LT_ct +
	    liens_unrel_SC_ct +
	    liens_rel_SC_ct +
	    liens_unrel_CJ_ct +
	    liens_rel_CJ_ct +
	    liens_unrel_FT_ct +
	    liens_rel_FT_ct +
	    liens_unrel_OT_ct +
	    liens_rel_OT_ct +
	    liens_unrel_ST_ct +
	    liens_rel_ST_ct +
	    liens_unrel_FC_ct +
	    liens_rel_FC_ct +
	    liens_unrel_O_ct +
	    liens_rel_O_ct;
	

//========================================================
//===   Determine if this consumer has any derog       ===
//========================================================	
	has_derog := if(felony_count > 0 
	                or criminal_count > 0 
									or stl_inq_count12 > 0 
									or attr_eviction_count > 0 
									or liens_unrel_CJ_ct > 0 
									or liens_rel_CJ_ct > 0 
									or liens_unrel_SC_ct > 0 
									or liens_rel_SC_ct > 0 
									or liens_unrel_FC_ct > 0 
									or liens_rel_FC_ct > 0 
									or liens_unrel_O_ct > 0 
									or liens_rel_O_ct > 0 
									or tot_liens - tot_liens_w_type > 0 
									or bk_dismissed_recent_count > 0 
									or bk_dismissed_historical_count > 0, 1, 0);
	
//========================================================
//===   Determine the segment this DID falls into      ===
//========================================================	
	rv_4seg_riskview_5_0 := map(
	    not(truedid)                                                            => '0 TRUEDID = 0     ',
	    not((boolean)sufficiently_verified)                                     => '1 VER/VAL PROBLEMS',
	    (boolean)sufficiently_verified and (boolean)(integer)validation_problem => '1 VER/VAL PROBLEMS',
	    (boolean)has_derog                                                      => '2 DEROG           ',
	    add_input_naprop = 4 or property_owned_total > 0                        => '3 OWNER           ',
	                                                                               '4 OTHER           ');
 
	verprob_seg   := (rv_4seg_riskview_5_0[1..1] in ['0', '1']);
	derog_seg     :=  rv_4seg_riskview_5_0[1..1]  = '2';
	propowner_seg :=  rv_4seg_riskview_5_0[1..1]  = '3';
	other_seg     :=  rv_4seg_riskview_5_0[1..1]  = '4';

//========================================================================================  
//===   for round 1 validation set the sysdate to the same value seen in the validation file 
//               sysdate := common.sas_date('20150501');	
//===   for round 2 validation set the sysdate to the archive date
//========================================================================================  
       sysdate := common.sas_date(if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));
 
//==============================================================
//=             Based on the information collected above       =
//=             Set the Risk View indicators for this          =
//=             consumer.  These are all of the components     =
//=             That go into the score for this model          =
//==============================================================	 
	
	iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');
	
	rv_a44_prop_owner_inp_only := map(
	    not(truedid)                                => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 => '1',
	                                                   '0');
	
	rv_a44_curr_add_naprop := if(not(truedid and add_curr_pop), NULL, add_curr_naprop);
	
	rv_prop_owner_history := map(
	    not(truedid)                                                                        => '',
	    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0             => 'CURRENT',
	    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0    => 'HISTORICAL',
	                                                                                        'NEVER');
	
	rv_a47_curr_avm_autoval := if(not(truedid), NULL, add_curr_avm_auto_val);
	
	rv_a50_pb_total_orders := map(
	    not(truedid)                                => NULL,
	    pb_total_orders = ''                        => -1,
	                                                // (integer)pb_total_orders);
	                                                -1); // reason code edit for iBehavior removal
	
	rv_a50_pb_total_dollars := map(
	    not(truedid)                               => NULL,
	    pb_total_dollars = ''                      => -1,
	                                               // (integer)pb_total_dollars);
																								 -1); // reason code edit for iBehavior removal
	
	_header_first_seen := Common.SAS_Date((STRING)(header_first_seen));
	
	rv_c10_m_hdr_fs := map(
	    not(truedid)              => NULL,
	    _header_first_seen = NULL => -1,
	                                 min(if(if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12)))), 999));
	
	rv_c12_source_profile := if(not(truedid), NULL, hdr_source_profile);
	
	rv_c12_num_nonderogs := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 4));
	
	rv_c14_addrs_15yr := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));
	
	rv_c18_invalid_addrs_per_adl := if(not(truedid), NULL, min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 999));
	
	rv_c22_inp_addr_owned_not_occ := if(not(add_input_pop and truedid), NULL, (integer)add_input_owned_not_occ);
	
	rv_d30_derog_count := if(not(truedid), NULL, min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 999));
	
	rv_d31_all_bk := map(
	    not(truedid)                                                                                                                => '',
	    StringLib.StringToUpperCase(disposition)[1..7] = 'DISMISS' or bk_dismissed_recent_count + bk_dismissed_historical_count > 0 => '1 - BK DISMISSED ',
	    StringLib.StringToUpperCase(disposition)[1..8] = 'DISCHARG' or bk_disposed_recent_count + bk_disposed_historical_count > 0  => '2 - BK DISCHARGED',
	    bankrupt or filing_count > 0                                                                                                => '3 - BK OTHER     ',
	                                                                                                                                   '0 - NO BK        ');
	
	rv_d31_bk_filing_count := if(not(truedid), NULL, min(if(filing_count = NULL, -NULL, filing_count), 999));
	
	rv_d32_criminal_x_felony := if(not(truedid), '', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));
	
	rv_d33_eviction_recency := map(
	    not(truedid)                                                         => '  ',
	    (boolean)attr_eviction_count90                                       => '03',
	    (boolean)attr_eviction_count180                                      => '06',
	    (boolean)attr_eviction_count12                                       => '12',
	    (boolean)attr_eviction_count24 and attr_eviction_count >= 2          => '24',
	    (boolean)attr_eviction_count24                                       => '25',
	    (boolean)attr_eviction_count36 and attr_eviction_count >= 2          => '36',
	    (boolean)attr_eviction_count36                                       => '37',
	    (boolean)attr_eviction_count60 and attr_eviction_count >= 2          => '60',
	    (boolean)attr_eviction_count60                                       => '61',
	    attr_eviction_count >= 2                                             => '98',
	    attr_eviction_count >= 1                                             => '99',
	                                                                            '00');
	
	rv_d34_unrel_liens_ct := if(not(truedid), NULL, min(if(liens_recent_unreleased_count + liens_historical_unreleased_ct = NULL, -NULL, liens_recent_unreleased_count + liens_historical_unreleased_ct), 999));
	
	rv_d34_attr_liens_recency := map(
	    not(truedid)                                                              => NULL,
	    (boolean)attr_num_rel_liens30 or (boolean)attr_num_unrel_liens30          => 1,
	    (boolean)attr_num_rel_liens90 or (boolean)attr_num_unrel_liens90          => 3,
	    (boolean)attr_num_rel_liens180 or (boolean)attr_num_unrel_liens180        => 6,
	    (boolean)attr_num_rel_liens12 or (boolean)attr_num_unrel_liens12          => 12,
	    (boolean)attr_num_rel_liens24 or (boolean)attr_num_unrel_liens24          => 24,
	    (boolean)attr_num_rel_liens36 or (boolean)attr_num_unrel_liens36          => 36,
	    (boolean)attr_num_rel_liens60 or (boolean)attr_num_unrel_liens60          => 60,
	    liens_historical_released_count > 0 or liens_historical_unreleased_ct > 0 => 99,
	                                                                                 0);
	
	rv_e55_college_ind := map(
	    not(truedid)                           => ' ',
	    (college_file_type in ['H', 'C', 'A']) => '1',
	    college_attendance                     => '1',
	                                              '0');
	
	rv_e57_prof_license_br_flag := if(not(truedid), NULL, (integer)(((integer)prof_license_flag + (integer)br_source_count) > 0));
	
	rv_f00_addr_not_ver_w_ssn := if(not(truedid and (integer)ssnlength > 0), NULL, (integer)(nas_summary in [4, 7, 9]));
	
	rv_f00_dob_score := if(not(truedid and dobpop), NULL, min(if(combo_dobscore = NULL, -NULL, combo_dobscore), 999));
	
	rv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));
	
	rv_f01_inp_addr_not_verified := if(not(add_input_pop and truedid), NULL, (integer)add_input_addr_not_verified);
	
	rv_f03_address_match := map(
	    not(truedid)                                => '                          ',
	    add_input_isbestmatch                       => '4 INPUT=CURR              ',
	    not(add_input_pop) and add_curr_isbestmatch => '3 CURRAVAIL + NOINPUTPOP  ',
	    add_input_pop and add_curr_isbestmatch      => '2 CURRAVAIL + INPUTNOTCURR',
	    add_curr_pop                                => '1 CURR ONHDRONLY          ',
	    add_input_pop                               => '0 INPUTPOP NOHISTAVAIL    ',
	                                                   '');
	
	rv_f03_input_add_not_most_rec := if(not(truedid and add_input_pop), NULL, (integer)rc_input_addr_not_most_recent);
	
	rv_f04_curr_add_occ_index := if(not(truedid and add_curr_pop), NULL, add_curr_occ_index);
	
	rv_s66_adlperssn_count := map(
	    not((integer)ssnlength > 0) => NULL,
	    adls_per_ssn = 0   => 1,
	                          min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));
	
	rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);
	
	rv_p85_phn_disconnected := map(
	    not(hphnpop)                                                                        => ' ',
	    (integer)rc_hriskphoneflag = 5 or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D'   => '1',
	                                                                                           '0');


//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the verprob seqment                  =
//==============================================================
	verprob_subscore0 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0       => 0.078839,
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 88900       => -0.471166,
	    88900 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 213958 => -0.1242,
	    213958 <= rv_a47_curr_avm_autoval                                     => 0.080768,
	                                                                             0);
	
	verprob_subscore1 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => -0.020142,
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 6   => 0.010437,
	    6 <= rv_a50_pb_total_orders                                  => 0.178883,
	                                                                    0);
	
	verprob_subscore2 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2 => 0.080995,
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3   => -0.024619,
	    3 <= rv_c14_addrs_15yr                             => -0.095396,
	                                                          0);
	
	verprob_subscore3 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 0.041776,
	    1 <= rv_d30_derog_count                              => -0.824752,
	                                                            0);
	
	verprob_subscore4 := map(
	    rv_e55_college_ind = '0'                                            => -0.023163,
	    rv_e55_college_ind = '1'                                            =>  0.175853,
	                                                                                   0);
	
	verprob_subscore5 := map(
	    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn < 1 => 0.067213,
	    1 <= rv_f00_addr_not_ver_w_ssn                                     => -0.257597,
	    not(truedid)                                                       => 0,
	    not((integer)ssnlength > 0)                                        => 0.067213,
	                                                                          0);
	
	verprob_subscore6 := map(
	    NULL < rv_f00_dob_score AND rv_f00_dob_score < 100 => -0.426162,
	    100 <= rv_f00_dob_score                            => 0.030083,
	    not(truedid)                                       => 0,
	    not(dobpop)                                        => 0.030083,
	                                                          0);
	
	verprob_subscore7 := map(
	    NULL < rv_f01_inp_addr_not_verified AND rv_f01_inp_addr_not_verified < 1 => 0.060314,
	    1 <= rv_f01_inp_addr_not_verified                                        => -0.23956,
	    not(truedid)                                                             => 0,
	    (integer)add_input_pop = 0                                               => 0.060314,
	                                                                                0);
	
	verprob_subscore8 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0            => -0.050436,
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 116662           => -0.195837,
	    116662 <= rv_l80_inp_avm_autoval                                         => 0.150648,
	    (integer)add_input_pop = 0                                               => 0.150648,
	                                                                                0);
	
	verprob_subscore9 := map(
	    (rv_prop_owner_history in [' ', 'CURRENT', 'HISTORICAL'])                => 0.313613,
	    (rv_prop_owner_history in ['NEVER'])                                     => -0.174473,
	                                                                                0);
	
	verprob_subscore10 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2             => 0.071967,
	    2 <= rv_s66_adlperssn_count                                              => -0.150807,
	    not((integer)ssnlength > 0)                                              => 0.071967,
	                                                                                0);
	
	verprob_rawscore := verprob_subscore0 +
	    verprob_subscore1 +
	    verprob_subscore2 +
	    verprob_subscore3 +
	    verprob_subscore4 +
	    verprob_subscore5 +
	    verprob_subscore6 +
	    verprob_subscore7 +
	    verprob_subscore8 +
	    verprob_subscore9 +
	    verprob_subscore10;
	
	verprob_lnoddsscore := verprob_rawscore + 3.053919;
	
	verprob_probscore := exp(verprob_lnoddsscore) / (1 + exp(verprob_lnoddsscore));
	
	verprob_aacd_0 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0       => 'A47',
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 88900       => 'A47',
	    88900 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 213958 => 'A47',
	    213958 <= rv_a47_curr_avm_autoval                                     => 'A47',
	                                                                             'C12');
	
	verprob_dist_0_1 := verprob_subscore0 - 0.080768;
	
	verprob_aacd_1 := 'C12';
	// map(
	    // NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1 => 'A50',
	    // 1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 6   => 'A50',
	    // 6 <= rv_a50_pb_total_orders                                  => 'A50',
	                                                                    // 'C12');
	
	verprob_dist_1 := if(rv_a50_pb_total_orders=null, verprob_subscore1 - 0.178883, 0);
	
	verprob_aacd_2 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2 => 'C14',
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3   => 'C14',
	    3 <= rv_c14_addrs_15yr                             => 'C14',
	                                                          'C12');
	
	verprob_dist_2 := verprob_subscore2 - 0.080995;
	
	verprob_aacd_3 := map(
	    NULL < rv_d30_derog_count AND rv_d30_derog_count < 1 => 'D30',
	    1 <= rv_d30_derog_count                              => 'D30',
	                                                            'C12');
	
	verprob_dist_3 := verprob_subscore3 - 0.041776;
	
 	
	verprob_aacd_4 := map(
	    rv_e55_college_ind = '0'                                                 => 'E55',
	    rv_e55_college_ind = '1'                                                 => 'E55',
	                                                                                'C12');
	
	verprob_dist_4 := verprob_subscore4 - 0.175853;
	
	verprob_aacd_5 := map(
	    NULL < rv_f00_addr_not_ver_w_ssn AND rv_f00_addr_not_ver_w_ssn < 1 => 'F00',
	    1 <= rv_f00_addr_not_ver_w_ssn                                     => 'F00',
			not(truedid)                                                       => 'C12',
	                                                                          '');
	
	verprob_dist_5 := verprob_subscore5 - 0.067213;
	
	verprob_aacd_6 := map(
	    NULL < rv_f00_dob_score AND rv_f00_dob_score < 100                 => 'F00',
	    100 <= rv_f00_dob_score                                            => 'F00',
	    not(truedid)                                                       => 'C12',
	                                                                          '');
	
	verprob_dist_6 := verprob_subscore6 - 0.030083;
	
	verprob_aacd_7 := map(
	    NULL < rv_f01_inp_addr_not_verified AND rv_f01_inp_addr_not_verified < 1 => 'F01',
	    1 <= rv_f01_inp_addr_not_verified                                        => 'F01',
	    not(truedid)                                                             => 'C12',
	                                                                                '');
	
	verprob_dist_7 := verprob_subscore7 - 0.060314;
	
	verprob_aacd_8_1 := map(
	    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval <= 0  => 'L80',
	    0 < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 116662 => 'L80',
	    116662 <= rv_l80_inp_avm_autoval                               => 'L80',
	                                                                      '');
	
	verprob_dist_8_1 := verprob_subscore8 - 0.150648;
	
	verprob_dist_8 := if(verprob_dist_0_1 != 0, 0, verprob_dist_8_1);
	
	verprob_aacd_8 := if(verprob_dist_0_1 != 0, '', verprob_aacd_8_1);
	
	verprob_dist_0 := if(verprob_dist_0_1 != 0, verprob_dist_0_1 + verprob_dist_8_1, verprob_dist_0_1);
	
	verprob_aacd_9 := map(
	    (rv_prop_owner_history in [' ', 'CURRENT', 'HISTORICAL']) => '',
	    (rv_prop_owner_history in ['NEVER'])                      => 'A41',
	                                                                 '');
	
	verprob_dist_9 := verprob_subscore9 - 0.313613;
	
	verprob_aacd_10 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	verprob_dist_10 := verprob_subscore10 - 0.071967;


//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the derog seqment                    =
//==============================================================
	
	derog_subscore0 := map(
	    (rv_d32_criminal_x_felony in ['0-0', '1-0'])                             => 0.053985,
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.883727,
	    (rv_d32_criminal_x_felony in ['2-0', '3-0'])                             => -0.030833,
	                                                                                0);
	
	derog_subscore1 := map(
	    (rv_prop_owner_history in ['CURRENT'])             => 0.185245,
	    (rv_prop_owner_history in ['HISTORICAL', 'NEVER']) => -0.204998,
	                                                          0);
	
	derog_subscore2 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0       => 0.068528,
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 81670       => -0.418271,
	    81670 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 220900 => -0.094255,
	    220900 <= rv_a47_curr_avm_autoval                                     => 0.224916,
	                                                                             0);
	
	derog_subscore3 := map(
	    NULL < rv_f01_inp_addr_not_verified AND rv_f01_inp_addr_not_verified < 1     => 0.062455,
	    1 <= rv_f01_inp_addr_not_verified                                            => -0.484208,
	    not(truedid)                                                                 => 0,
	    (integer)add_input_pop = 0                                                   => 0.062455,
	                                                                                    0);
	
 derog_subscore4 := map(
      rv_d33_eviction_recency = ' '                                                          =>  0, 	    
			NULL < (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 3       =>  0.072692,
	    3 <= (integer)rv_d33_eviction_recency                                                  => -0.300635,
	                                                                                               0);																																														
	
	
	derog_subscore5 := map(
	    NULL < rv_e57_prof_license_br_flag AND rv_e57_prof_license_br_flag < 1 => -0.06298,
	    1 <= rv_e57_prof_license_br_flag                                       => 0.216633,
	                                                                              0);

	derog_subscore6 := map(
	    rv_e55_college_ind = '0'                                            => -0.041739,
	    rv_e55_college_ind = '1'                                            =>  0.237737,
	                                                                            0);
	
	derog_subscore7 := map(
	    NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 1   => -0.123377,
	    1 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 100   => 0.021174,
	    100 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 308 => 0.10534,
	    308 <= rv_a50_pb_total_dollars                                   => 0.222716,
	                                                                        0);
	
	derog_subscore8 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 58.8  => -0.100643,
	    58.8 <= rv_c12_source_profile AND rv_c12_source_profile < 70.5 => -0.098111,
	    70.5 <= rv_c12_source_profile                                  => 0.181647,
	                                                                      0);
	
	derog_subscore9 := map(
	    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 3 => 0.039001,
	    3 <= rv_f04_curr_add_occ_index                                     => -0.10554,
	                                                                          0);
	
	derog_rawscore := derog_subscore0 +
	    derog_subscore1 +
	    derog_subscore2 +
	    derog_subscore3 +
	    derog_subscore4 +
	    derog_subscore5 +
	    derog_subscore6 +
	    derog_subscore7 +
	    derog_subscore8 +
	    derog_subscore9;
	
	derog_lnoddsscore := derog_rawscore + 2.505384;
	
	derog_probscore := exp(derog_lnoddsscore) / (1 + exp(derog_lnoddsscore));
	
	derog_aacd_0 := map(
	    (rv_d32_criminal_x_felony in ['0-0', '1-0'])                             => 'D32',
	    (rv_d32_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 'D32',
	    (rv_d32_criminal_x_felony in ['2-0', '3-0'])                             => 'D32',
	                                                                                '');
	
	derog_dist_0 := derog_subscore0 - 0.053985;
	
	derog_aacd_1 := map(
	    (rv_prop_owner_history in ['CURRENT'])             => '',
	    (rv_prop_owner_history in ['HISTORICAL', 'NEVER']) => 'A42',
	                                                          '');
	
	derog_dist_1 := derog_subscore1 - 0.185245;
	
	derog_aacd_2 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0       => 'A47',
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 81670       => 'A47',
	    81670 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 220900 => 'A47',
	    220900 <= rv_a47_curr_avm_autoval                                     => 'A47',
	                                                                             '');
	
	derog_dist_2 := derog_subscore2 - 0.224916;
	
	derog_aacd_3 := map(
	    NULL < rv_f01_inp_addr_not_verified AND rv_f01_inp_addr_not_verified < 1 => 'F01',
	    1 <= rv_f01_inp_addr_not_verified                                        => 'F01',
	    not(truedid)                                                             => 'C12',
	                                                                                '');
	
	derog_dist_3 := derog_subscore3 - 0.062455;
	
  derog_aacd_4 := map(
      rv_d33_eviction_recency = ' '                                                            => '',
	    NULL < (integer)rv_d33_eviction_recency AND (integer)rv_d33_eviction_recency < 3         => 'D33',
	    3 <= (integer)rv_d33_eviction_recency                                                    => 'D33',
	                                                                                                '');
	
	derog_dist_4 := derog_subscore4 - 0.072692;
	
	derog_aacd_5 := map(
	    NULL < rv_e57_prof_license_br_flag AND rv_e57_prof_license_br_flag < 1                  => 'E57',
	    1 <= (integer)rv_e57_prof_license_br_flag                                               => 'E57',
	                                                                                               '');
	
	derog_dist_5 := derog_subscore5 - 0.216633;
	
	derog_aacd_6 := map(
	    rv_e55_college_ind = '0'                                       => 'E55',
	    rv_e55_college_ind = '1'                                       => 'E55',
	                                                                      '');
	
	derog_dist_6 := derog_subscore6 - 0.237737;
	
	derog_aacd_7 := '';
	// map(
	    // NULL < rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 1   => 'A50',
	    // 1 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 100   => 'A50',
	    // 100 <= rv_a50_pb_total_dollars AND rv_a50_pb_total_dollars < 308 => 'A50',
	    // 308 <= rv_a50_pb_total_dollars                                   => 'A50',
	                                                                        // '');
	
	derog_dist_7 := if(rv_a50_pb_total_dollars=null, derog_subscore7 - 0.222716, 0);
	
	derog_aacd_8 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 58.8  => 'C12',
	    58.8 <= rv_c12_source_profile AND rv_c12_source_profile < 70.5 => 'C12',
	    70.5 <= rv_c12_source_profile                                  => 'C12',
	                                                                      '');
	
	derog_dist_8 := derog_subscore8 - 0.181647;
	
	derog_aacd_9 := map(
	    NULL < rv_f04_curr_add_occ_index AND rv_f04_curr_add_occ_index < 3     => 'F04',
	    3 <= rv_f04_curr_add_occ_index                                         => 'F04',
	    not(truedid)                                                           => 'C12', 
			(integer)add_curr_pop = 0                                              => 'F04', 
			                                                                          '');
	
	derog_dist_9 := derog_subscore9 - 0.039001;


//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the propowner seqment                =
//==============================================================
	
	propowner_subscore0 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0        => 0.000079,
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 53551        => -0.610632,
	    53551 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 99970   => -0.334627,
	    99970 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 182061  => -0.147768,
	    182061 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 212799 => -0.061449,
	    212799 <= rv_a47_curr_avm_autoval                                      => 0.272045,
	                                                                              0);
	
	propowner_subscore1 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2                     => 0.193162,
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 4                       => -0.062936,
	    4 <= rv_c14_addrs_15yr                                                 => -0.209568,
	                                                                              0);
	
	propowner_subscore2 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 40   => -0.783466,
	    40 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100   => -0.088689,
	    100 <= rv_f01_inp_addr_address_score                                          => 0.032283,
	    not(truedid)                                                                  => 0,
	    (integer)add_input_pop = 0                                                    => 0.032283,
	                                                                                     0);
	
	propowner_subscore3 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 53.1       => -0.24965,
	    53.1 <= rv_c12_source_profile AND rv_c12_source_profile < 63.9      => -0.098615,
	    63.9 <= rv_c12_source_profile                                       => 0.081808,
	                                                                           0);
	
  propowner_subscore4 := map(
	     rv_e55_college_ind = '0'                                          => -0.02807,
	     rv_e55_college_ind = '1'                                          =>  0.164483,
	                                                                           0);
	
	propowner_subscore5 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2       => -0.083651,
	    2 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 5         => 0.006173,
	    5 <= rv_a50_pb_total_orders                                        => 0.114236,
	                                                                          0);
	
	propowner_subscore6 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3           => -0.074546,
	    3 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 4             => 0.009496,
	    4 <= rv_c12_num_nonderogs                                          => 0.133817,
	                                                                          0);
	
	propowner_subscore7 := map(
	    rv_a44_prop_owner_inp_only = ''                                                           => 0,
	    NULL < (integer)rv_a44_prop_owner_inp_only AND (integer)rv_a44_prop_owner_inp_only < 1    => -0.158484,
	    1 <= (integer)rv_a44_prop_owner_inp_only                                                  => 0.029949,
	                                                                                                 0);
	
	propowner_subscore8 := map(
	    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 1 => 0.025927,
	    1 <= rv_f03_input_add_not_most_rec                                         => -0.114379,
	    not(truedid)                                                               => 0,
	    (integer)add_input_pop = 0                                                 => 0.025927,
	                                                                                  0);
	
	propowner_subscore9 := map(
	    NULL < rv_c22_inp_addr_owned_not_occ AND rv_c22_inp_addr_owned_not_occ < 1  => 0.010641,
	    1 <= rv_c22_inp_addr_owned_not_occ                                          => -0.270558,
	    not(truedid)                                                                => 0,
	    (integer)add_input_pop = 0                                                  => 0.010641,
	                                                                                  0);
	
	propowner_subscore10 := map(
	    NULL < rv_d34_unrel_liens_ct AND rv_d34_unrel_liens_ct < 1    => 0.005438,
	    1 <= rv_d34_unrel_liens_ct                                    => -0.452038,
	                                                                     0);
	
	propowner_subscore11 := map(
	    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1  => 0.015345,
	    1 <= rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 4    => -0.128797,
	    4 <= rv_a44_curr_add_naprop                                   => 0.01849,
	                                                                     0);
	
	propowner_subscore12 := map(
	    rv_p85_phn_disconnected = '0'                                 =>  0.006115,
	    rv_p85_phn_disconnected = '1'                                 => -0.253873,
	    not(hphnpop)                                                  =>  0.006115,
	                                                                      0);
	
	propowner_subscore13 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.030918,
	    2 <= rv_s66_adlperssn_count                                  => -0.046309,
	    not((integer)ssnlength > 0)                                  => 0.030918,
	                                                                    0);
	
	propowner_subscore14 := map(
	    (rv_d31_all_bk in ['0 - NO BK'])                            => 0.003229,
	    (rv_d31_all_bk in ['2 - BK DISCHARGED', '3 - BK OTHER'])    => -0.362231,
	                                                                   0);
	
	propowner_rawscore := propowner_subscore0 +
	    propowner_subscore1 +
	    propowner_subscore2 +
	    propowner_subscore3 +
	    propowner_subscore4 +
	    propowner_subscore5 +
	    propowner_subscore6 +
	    propowner_subscore7 +
	    propowner_subscore8 +
	    propowner_subscore9 +
	    propowner_subscore10 +
	    propowner_subscore11 +
	    propowner_subscore12 +
	    propowner_subscore13 +
	    propowner_subscore14;
	
	propowner_lnoddsscore := propowner_rawscore + 3.838949;
	
	propowner_probscore := exp(propowner_lnoddsscore) / (1 + exp(propowner_lnoddsscore));
	
	propowner_aacd_0 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0        => 'A47',
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 53551        => 'A47',
	    53551 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 99970   => 'A47',
	    99970 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 182061  => 'A47',
	    182061 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 212799 => 'A47',
	    212799 <= rv_a47_curr_avm_autoval                                      => 'A47',
	                                                                              '');
	
	propowner_dist_0 := propowner_subscore0 - 0.272045;
	
	propowner_aacd_1 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2    => 'C14',
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 4      => 'C14',
	    4 <= rv_c14_addrs_15yr                                => 'C14',
	                                                             '');
	
	propowner_dist_1 := propowner_subscore1 - 0.193162;
	
	propowner_aacd_2 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 40    => 'F01',
	    40 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100    => 'F01',
	    100 <= rv_f01_inp_addr_address_score                                           => 'F01',
	    not(truedid)                                                                   => 'C12',
	                                                                                      '');
	
	propowner_dist_2 := propowner_subscore2 - 0.032283;
	
	propowner_aacd_3 := map(
	    NULL < rv_c12_source_profile AND rv_c12_source_profile < 53.1       => 'C12',
	    53.1 <= rv_c12_source_profile AND rv_c12_source_profile < 63.9      => 'C12',
	    63.9 <= rv_c12_source_profile                                       => 'C12',
	                                                                           '');
	
	propowner_dist_3 := propowner_subscore3 - 0.081808;
	
  propowner_aacd_4 := map(
	     rv_e55_college_ind = '0'                                      => 'E55',
	     rv_e55_college_ind = '1'                                      => 'E55',
	                                                                      '');
	
	propowner_dist_4 := propowner_subscore4 - 0.164483;
	
	propowner_aacd_5 := '';
	// map(
	    // NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 2   => 'A50',
	    // 2 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 5     => 'A50',
	    // 5 <= rv_a50_pb_total_orders                                    => 'A50',
	                                                                      // '');
	
	propowner_dist_5 := if(rv_a50_pb_total_dollars=null, propowner_subscore5 - 0.114236, 0);
	
	propowner_aacd_6 := map(
	    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3   => 'C12',
	    3 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 4     => 'C12',
	    4 <= rv_c12_num_nonderogs                                  => 'C12',
	                                                                  '');
	
	propowner_dist_6 := propowner_subscore6 - 0.133817;
	
	propowner_aacd_7 := map(
	    rv_a44_prop_owner_inp_only = ''                                                           => '',
	    NULL < (integer)rv_a44_prop_owner_inp_only AND (integer)rv_a44_prop_owner_inp_only < 1    => 'A44',
	    1 <= (integer)rv_a44_prop_owner_inp_only                                                  => 'A44',
	                                                                                                 '');
	
	propowner_dist_7 := propowner_subscore7 - 0.029949;
	
	propowner_aacd_8 := map(
	    NULL < rv_f03_input_add_not_most_rec AND rv_f03_input_add_not_most_rec < 1 => 'F03',
	    1 <= rv_f03_input_add_not_most_rec                                         => 'F03',
	    not(truedid)                                                               => 'C12',
	                                                                                  '');
	
	propowner_dist_8 := propowner_subscore8 - 0.025927;
	
	propowner_aacd_9 := map(
	    NULL < rv_c22_inp_addr_owned_not_occ AND rv_c22_inp_addr_owned_not_occ < 1 => 'C22',
	    1 <= rv_c22_inp_addr_owned_not_occ                                         => 'C22',
	    not(truedid)                                                               => 'C12',
	                                                                                  '');
	
	propowner_dist_9 := propowner_subscore9 - 0.010641;
	
	propowner_aacd_10 := map(
	    NULL < rv_d34_unrel_liens_ct AND rv_d34_unrel_liens_ct < 1    => 'D34',
	    1 <= rv_d34_unrel_liens_ct                                    => 'D34',
	                                                                     '');
	
	propowner_dist_10 := propowner_subscore10 - 0.005438;
	
	propowner_aacd_11 := map(
	    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1 => 'A44',
	    1 <= rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 4   => 'A44',
	    4 <= rv_a44_curr_add_naprop                                  => 'A44',
	    not(truedid)                                                 => 'C12', 
			(integer)add_curr_pop = 0                                    => 'A44',
																					                            '');
	
	propowner_dist_11 := propowner_subscore11 - 0.01849;
	

  propowner_aacd_12 := map(
	     rv_p85_phn_disconnected = '0'                               => 'P85',
	     rv_p85_phn_disconnected = '1'                               => 'P85',
	                                                                     '');	
	
	propowner_dist_12 := propowner_subscore12 - 0.006115;
	
	propowner_aacd_13 := map(
	    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
	    2 <= rv_s66_adlperssn_count                                  => 'S66',
	                                                                    '');
	
	propowner_dist_13 := propowner_subscore13 - 0.030918;
	
	propowner_aacd_14 := map(
	    (rv_d31_all_bk in ['0 - NO BK'])                            => 'D31',
	    (rv_d31_all_bk in ['2 - BK DISCHARGED', '3 - BK OTHER'])    => 'D31',
	                                                                   '');
	
	propowner_dist_14 := propowner_subscore14 - 0.003229;
	
	
//==============================================================
//=             Start the scoring process  and reason code     =
//=             logic for the other seqment                    =
//==============================================================	

	other_subscore0 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 35             => -0.585867,
	    35 <= rv_c10_m_hdr_fs                                       => 0.069321,
	                                                                   0);
	
	other_subscore1 := map(
	    NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1   => -0.086189,
	    1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 4     => 0.042691,
	    4 <= rv_a50_pb_total_orders                                    => 0.161762,
	                                                                      0);
	
	other_subscore2 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0       => -0.016578,
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 74527       => -0.481422,
	    74527 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 144829 => -0.183709,
	    144829 <= rv_a47_curr_avm_autoval                                     => 0.170647,
	                                                                             0);
	
	other_subscore3 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => -0.198817,
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])                                 => 0.106717,
	                                                                                                              0);
	
	other_subscore4 := map(
	    rv_e55_college_ind = '0'                                 => -0.046754,
	    rv_e55_college_ind = '1'                                 =>  0.184922,
	                                                                 0);
	
	other_subscore5 := map(
	    (rv_prop_owner_history in ['CURRENT', 'HISTORICAL'])    => 0.250695,
	    (rv_prop_owner_history in ['NEVER'])                    => -0.066531,
	                                                               0);
	
	other_subscore6 := map(
	    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1   => -0.00292,
	    1 <= rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 3     => -0.136135,
	    3 <= rv_a44_curr_add_naprop                                    => 0.138345,
	                                                                      0);
	
	other_subscore7 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2   => 0.116195,
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3     => -0.046158,
	    3 <= rv_c14_addrs_15yr                               => -0.093434,
	                                                            0);
	
	other_subscore8 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100   => -0.212268,
	    100 <= rv_f01_inp_addr_address_score                                           => 0.045596,
	    not(truedid)                                                                   => 0,
	    (integer)add_input_pop = 0                                                     => 0.045596,
	                                                                                     0);
	
	other_subscore9 := map(
	    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 1   => 0.061628,
	    1 <= rv_c18_invalid_addrs_per_adl                                          => -0.117694,
	                                                                                  0);
	
	other_subscore10 := map(
	    NULL < rv_d34_attr_liens_recency AND rv_d34_attr_liens_recency < 1   => 0.008448,
	    1 <= rv_d34_attr_liens_recency                                       => -0.644926,
	                                                                            0);
	
	other_subscore11 := map(
	    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count < 1   => 0.006657,
	    1 <= rv_d31_bk_filing_count                                    => -0.440119,
	                                                                      0);
	
	other_rawscore := other_subscore0 +
	    other_subscore1 +
	    other_subscore2 +
	    other_subscore3 +
	    other_subscore4 +
	    other_subscore5 +
	    other_subscore6 +
	    other_subscore7 +
	    other_subscore8 +
	    other_subscore9 +
	    other_subscore10 +
	    other_subscore11;
	
	other_lnoddsscore := other_rawscore + 3.233733;
	
	other_probscore := exp(other_lnoddsscore) / (1 + exp(other_lnoddsscore));
	
	other_aacd_0 := map(
	    NULL < rv_c10_m_hdr_fs AND rv_c10_m_hdr_fs < 35 => 'C10',
	    35 <= rv_c10_m_hdr_fs                           => 'C10',
	                                                       '');
	
	other_dist_0 := other_subscore0 - 0.069321;
	
	other_aacd_1 := '';
	// map(
	    // NULL < rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 1   => 'A50',
	    // 1 <= rv_a50_pb_total_orders AND rv_a50_pb_total_orders < 4     => 'A50',
	    // 4 <= rv_a50_pb_total_orders                                    => 'A50',
	                                                                      // '');
	
	other_dist_1 := if(rv_a50_pb_total_dollars=null, other_subscore1 - 0.161762, 0);
	
	other_aacd_2 := map(
	    NULL < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval <= 0         => 'A47',
	    0 < rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 74527         => 'A47',
	    74527 <= rv_a47_curr_avm_autoval AND rv_a47_curr_avm_autoval < 144829   => 'A47',
	    144829 <= rv_a47_curr_avm_autoval                                       => 'A47',
	                                                                               '');
	
	other_dist_2 := other_subscore2 - 0.170647;
	
	other_aacd_3 := map(
	    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR']) => 'F03',
	    (rv_f03_address_match in ['3 CURRAVAIL + NOINPUTPOP', '4 INPUT=CURR'])                                 => 'F03',
	                                                                                                              '');
	
	other_dist_3 := other_subscore3 - 0.106717;
	
  other_aacd_4 := map(
	     rv_e55_college_ind = '0'                           => 'E55',
	     rv_e55_college_ind = '1'                           => 'E55',
	                                                           '');
	
	other_dist_4 := other_subscore4 - 0.184922;
	
	other_aacd_5 := map(
	    (rv_prop_owner_history in ['CURRENT', 'HISTORICAL']) => '',
	    (rv_prop_owner_history in ['NEVER'])                 => 'A41',
	                                                            '');
	
	other_dist_5 := other_subscore5 - 0.250695;
	
	other_aacd_6 := map(
	    NULL < rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 1 => 'A44',
	    1 <= rv_a44_curr_add_naprop AND rv_a44_curr_add_naprop < 3   => 'A44',
	    3 <= rv_a44_curr_add_naprop                                  => 'A44',
			not(truedid)                                                 => 'C12', 
			(integer)add_curr_pop = 0                                    => 'A44',
																					                            '');
	
	other_dist_6 := other_subscore6 - 0.138345;
	
	other_aacd_7 := map(
	    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2 => 'C14',
	    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 3   => 'C14',
	    3 <= rv_c14_addrs_15yr                             => 'C14',
	                                                          '');
	
	other_dist_7 := other_subscore7 - 0.116195;
	
	other_aacd_8 := map(
	    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100 => 'F01',
	    100 <= rv_f01_inp_addr_address_score                                         => 'F01',
			not(truedid)                                                                 => 'C12', 
																					                                           '');
	
	other_dist_8 := other_subscore8 - 0.045596;
	
	other_aacd_9 := map(
	    NULL < rv_c18_invalid_addrs_per_adl AND rv_c18_invalid_addrs_per_adl < 1 => 'C18',
	    1 <= rv_c18_invalid_addrs_per_adl                                        => 'C18',
	                                                                                '');
	
	other_dist_9 := other_subscore9 - 0.061628;
	
	other_aacd_10 := map(
	    NULL < rv_d34_attr_liens_recency AND rv_d34_attr_liens_recency < 1 => 'D34',
	    1 <= rv_d34_attr_liens_recency                                     => 'D34',
	                                                                          '');
	
	other_dist_10 := other_subscore10 - 0.008448;
	
	other_aacd_11 := map(
	    NULL < rv_d31_bk_filing_count AND rv_d31_bk_filing_count < 1 => 'D31',
	    1 <= rv_d31_bk_filing_count                                  => 'D31',
	                                                                    '');
	
	other_dist_11 := other_subscore11 - 0.006657;
	
	base   := 750;
	points := 50;
	odds   := 20;
	
	lnoddsscore := (integer)verprob_seg * verprob_lnoddsscore +
	    (integer)derog_seg * derog_lnoddsscore +
	    (integer)propowner_seg * propowner_lnoddsscore +
	    (integer)other_seg * other_lnoddsscore;
	
	score_lnodds := round(points * (lnoddsscore - ln(odds)) / ln(2) + base);
	
	score_lnodds_capped := min(900, if(max(501, score_lnodds) = NULL, -NULL, max(501, score_lnodds)));
	
	ov_ssnprior := (integer)rc_ssndobflag = 1 or (integer)rc_pwssndobflag = 1;
	
	ov_corrections := (integer)rc_hrisksic = 2225;
	
//==============================================================
//=             Some logic for high risk phones               =
//=             and high risk addresses                       =
//=             Additional logic for deceased                 =
//==============================================================
	deceased := map(
	    (integer)rc_decsflag = 1                                                  => 1,
	    rc_ssndod != 0                                                            => 1,
	    contains_i(ver_sources, 'DE') > 0 
			or contains_i(ver_sources, 'DS') > 0                                      => 2,
	    rc_decsflag = '0'                                                         => 0,
	                                                                                 NULL);
	
	_ov_pts_lost_c142_b3 := 550 - score_lnodds_capped;
	
	rvb1503_0_1 := map(
	    deceased > 0                                                    => 200,
	    (integer)iv_rv5_unscorable = 1                                  => 222,
	    score_lnodds_capped > 550 and (ov_ssnprior or ov_corrections)   => 550,
	                                                                     score_lnodds_capped);
	
	_ov_pts_lost_raw := map(
	    deceased > 0                                                  => NULL,
	    (integer)iv_rv5_unscorable = 1                                => NULL,
	    score_lnodds_capped > 550 and (ov_ssnprior or ov_corrections) => ln(2) * _ov_pts_lost_c142_b3 / points,
	                                                                     0);
	
	_rc_seg_c145 := map(
	    add_ec1 = 'E' and not(rc_addrvalflag = 'N') or out_z5 = ''           => 'L70',
	    rc_hrisksic = '2225'                                                 => 'L73',
	    rc_hrisksicphone = '2225'                                            => 'P87',
	    rc_hriskaddrflag = '2' 
			  or (integer)rc_ziptypeflag = 2  
				or (add_input_advo_res_or_bus in ['B', 'D']) 
			  or rc_hriskaddrflag = '4' 
				or (integer)rc_addrcommflag = 2                                    => 'L71',
	                                                                            'L72');
	
	_rc_seg_c146 := map(
	    rc_hriskphoneflag = '2' or rc_hphonetypeflag = '2' 
			or (telcordia_type in ['02', '56', '61']) or rc_hphonetypeflag = 'A'           => 'P86',
	                                                                                      'P85');
	
	_rc_seg_c144 := map(
	    sufficiently_verified = 0                          => 'F00',
	    adls_per_ssn >= 5 or ssns_per_adl >= 4             => 'S66',
	    invalid_ssns_per_adl >= 1                          => 'S65',
	    (integer)rc_ssndobflag = 1                         => 'S65',
	    (integer)rc_pwssndobflag = 1                       => 'S65',
	    adls_per_addr_curr >= 8 or ssns_per_addr_curr >= 7 => 'L79',
	    addr_validation_problem = 1                        => _rc_seg_c145,
	    Phn_Validation_Problem = 1                         => _rc_seg_c146,
	                                                          'C12');
	
	_rc_seg_c147 := map(
	    felony_count > 0 or criminal_count > 0           => 'D32',
	    stl_inq_count12 > 0                              => 'C21',
	    attr_eviction_count > 0                          => 'D33',
	    liens_unrel_CJ_ct > 0 
			or liens_rel_CJ_ct > 0 
			or liens_unrel_SC_ct > 0 
			or liens_rel_SC_ct > 0 
			or liens_unrel_FC_ct > 0 
			or liens_rel_FC_ct > 0 
			or liens_unrel_O_ct > 0 
			or liens_rel_O_ct > 0 
			or tot_liens - tot_liens_w_type > 0             => 'D34',
	                                                       'D31');
	
	_rc_seg := map(
	    VerProb_seg => _rc_seg_c144,
	    Derog_seg   => _rc_seg_c147,
	    Other_seg   => 'A41',
	                   '');
//=========================================================
//==  start calculating the RC values for verprob segment =
//=========================================================		
	
	verprob_dist_11 := _ov_pts_lost_raw;
	
	verprob_aacd_11 := map(
	    ov_corrections => 'L73',
	    ov_ssnprior    => 'S65',
			                   '');
	
	verprob_rcvaluea47 := (integer)(verprob_aacd_0 = 'A47') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'A47') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'A47') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'A47') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'A47') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'A47') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'A47') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'A47') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'A47') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'A47') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'A47') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'A47') * verprob_dist_11;
	
	verprob_rcvaluel73 := (integer)(verprob_aacd_0 = 'L73') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'L73') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'L73') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'L73') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'L73') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'L73') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'L73') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'L73') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'L73') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'L73') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'L73') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'L73') * verprob_dist_11;
	
	verprob_rcvaluel80 := (integer)(verprob_aacd_0 = 'L80') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'L80') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'L80') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'L80') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'L80') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'L80') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'L80') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'L80') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'L80') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'L80') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'L80') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'L80') * verprob_dist_11;
	
	verprob_rcvalued30 := (integer)(verprob_aacd_0 = 'D30') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'D30') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'D30') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'D30') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'D30') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'D30') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'D30') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'D30') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'D30') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'D30') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'D30') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'D30') * verprob_dist_11;
	
	verprob_rcvaluea50 := (integer)(verprob_aacd_0 = 'A50') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'A50') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'A50') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'A50') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'A50') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'A50') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'A50') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'A50') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'A50') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'A50') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'A50') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'A50') * verprob_dist_11;
	
	verprob_rcvaluef01 := (integer)(verprob_aacd_0 = 'F01') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'F01') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'F01') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'F01') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'F01') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'F01') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'F01') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'F01') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'F01') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'F01') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'F01') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'F01') * verprob_dist_11;
	
	verprob_rcvaluef00 := (integer)(verprob_aacd_0 = 'F00') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'F00') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'F00') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'F00') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'F00') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'F00') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'F00') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'F00') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'F00') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'F00') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'F00') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'F00') * verprob_dist_11;
	
	verprob_rcvaluea41 := (integer)(verprob_aacd_0 = 'A41') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'A41') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'A41') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'A41') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'A41') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'A41') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'A41') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'A41') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'A41') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'A41') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'A41') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'A41') * verprob_dist_11;
	
	verprob_rcvaluee55 := (integer)(verprob_aacd_0 = 'E55') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'E55') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'E55') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'E55') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'E55') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'E55') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'E55') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'E55') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'E55') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'E55') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'E55') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'E55') * verprob_dist_11;
	
	verprob_rcvaluec12 := (integer)(verprob_aacd_0 = 'C12') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'C12') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C12') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C12') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C12') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C12') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C12') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C12') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C12') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C12') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C12') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C12') * verprob_dist_11;
	
	verprob_rcvalues66 := (integer)(verprob_aacd_0 = 'S66') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'S66') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'S66') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'S66') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'S66') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'S66') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'S66') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'S66') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'S66') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'S66') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'S66') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'S66') * verprob_dist_11;
	
	verprob_rcvalueS65 := (integer)(verprob_aacd_0 = 'S65') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'S65') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'S65') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'S65') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'S65') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'S65') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'S65') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'S65') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'S65') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'S65') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'S65') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'S65') * verprob_dist_11;
	
	verprob_rcvaluec14 := (integer)(verprob_aacd_0 = 'C14') * verprob_dist_0 +
	    (integer)(verprob_aacd_1 = 'C14') * verprob_dist_1 +
	    (integer)(verprob_aacd_2 = 'C14') * verprob_dist_2 +
	    (integer)(verprob_aacd_3 = 'C14') * verprob_dist_3 +
	    (integer)(verprob_aacd_4 = 'C14') * verprob_dist_4 +
	    (integer)(verprob_aacd_5 = 'C14') * verprob_dist_5 +
	    (integer)(verprob_aacd_6 = 'C14') * verprob_dist_6 +
	    (integer)(verprob_aacd_7 = 'C14') * verprob_dist_7 +
	    (integer)(verprob_aacd_8 = 'C14') * verprob_dist_8 +
	    (integer)(verprob_aacd_9 = 'C14') * verprob_dist_9 +
	    (integer)(verprob_aacd_10 = 'C14') * verprob_dist_10 +
	    (integer)(verprob_aacd_11 = 'C14') * verprob_dist_11;

//=========================================================
//==  start calculating the RC values for derog segment   =
//=========================================================
	
	derog_dist_10 := _ov_pts_lost_raw;
	
	derog_aacd_10 := map(
	    ov_corrections               => 'L73',
	    ov_ssnprior                  => 'S65',
			                                '');
	
	derog_rcvaluea50 := (integer)(derog_aacd_0 = 'A50') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'A50') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'A50') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'A50') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'A50') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'A50') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'A50') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'A50') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'A50') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'A50') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'A50') * derog_dist_10;
	
	derog_rcvaluef04 := (integer)(derog_aacd_0 = 'F04') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'F04') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'F04') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'F04') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'F04') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'F04') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'F04') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'F04') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'F04') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'F04') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'F04') * derog_dist_10;
	
	derog_rcvaluel73 := (integer)(derog_aacd_0 = 'L73') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'L73') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'L73') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'L73') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'L73') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'L73') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'L73') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'L73') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'L73') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'L73') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'L73') * derog_dist_10;
	
	derog_rcvalueS65 := (integer)(derog_aacd_0 = 'S65') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'S65') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'S65') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'S65') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'S65') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'S65') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'S65') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'S65') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'S65') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'S65') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'S65') * derog_dist_10;
	
	derog_rcvalued32 := (integer)(derog_aacd_0 = 'D32') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'D32') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'D32') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'D32') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'D32') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'D32') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'D32') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'D32') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'D32') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'D32') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'D32') * derog_dist_10;
	
	derog_rcvalued33 := (integer)(derog_aacd_0 = 'D33') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'D33') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'D33') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'D33') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'D33') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'D33') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'D33') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'D33') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'D33') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'D33') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'D33') * derog_dist_10;
	
	derog_rcvaluea47 := (integer)(derog_aacd_0 = 'A47') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'A47') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'A47') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'A47') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'A47') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'A47') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'A47') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'A47') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'A47') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'A47') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'A47') * derog_dist_10;
	
	derog_rcvaluea42 := (integer)(derog_aacd_0 = 'A42') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'A42') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'A42') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'A42') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'A42') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'A42') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'A42') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'A42') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'A42') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'A42') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'A42') * derog_dist_10;
	
	derog_rcvaluec12 := (integer)(derog_aacd_0 = 'C12') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'C12') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'C12') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'C12') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'C12') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'C12') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'C12') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'C12') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'C12') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'C12') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'C12') * derog_dist_10;
	
	derog_rcvaluee55 := (integer)(derog_aacd_0 = 'E55') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'E55') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'E55') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'E55') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'E55') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'E55') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'E55') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'E55') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'E55') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'E55') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'E55') * derog_dist_10;
	
	derog_rcvaluef01 := (integer)(derog_aacd_0 = 'F01') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'F01') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'F01') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'F01') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'F01') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'F01') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'F01') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'F01') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'F01') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'F01') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'F01') * derog_dist_10;
	
	derog_rcvaluee57 := (integer)(derog_aacd_0 = 'E57') * derog_dist_0 +
	    (integer)(derog_aacd_1 = 'E57') * derog_dist_1 +
	    (integer)(derog_aacd_2 = 'E57') * derog_dist_2 +
	    (integer)(derog_aacd_3 = 'E57') * derog_dist_3 +
	    (integer)(derog_aacd_4 = 'E57') * derog_dist_4 +
	    (integer)(derog_aacd_5 = 'E57') * derog_dist_5 +
	    (integer)(derog_aacd_6 = 'E57') * derog_dist_6 +
	    (integer)(derog_aacd_7 = 'E57') * derog_dist_7 +
	    (integer)(derog_aacd_8 = 'E57') * derog_dist_8 +
	    (integer)(derog_aacd_9 = 'E57') * derog_dist_9 +
	    (integer)(derog_aacd_10 = 'E57') * derog_dist_10;
	

//=========================================================
//==  start calculating the RC values for propowner segment =
//=========================================================	

	propowner_dist_15 := _ov_pts_lost_raw;
	
	propowner_aacd_15 := map(
	    ov_corrections              => 'L73',
	    ov_ssnprior                 => 'S65',
			                               '');
	
	propowner_rcvaluec22 := (integer)(propowner_aacd_0 = 'C22') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'C22') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'C22') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'C22') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'C22') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'C22') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'C22') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'C22') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'C22') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'C22') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'C22') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'C22') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'C22') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'C22') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'C22') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'C22') * propowner_dist_15;
	
	propowner_rcvaluea50 := (integer)(propowner_aacd_0 = 'A50') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'A50') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'A50') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'A50') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'A50') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'A50') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'A50') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'A50') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'A50') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'A50') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'A50') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'A50') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'A50') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'A50') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'A50') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'A50') * propowner_dist_15;
	
	propowner_rcvaluel73 := (integer)(propowner_aacd_0 = 'L73') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'L73') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'L73') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'L73') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'L73') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'L73') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'L73') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'L73') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'L73') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'L73') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'L73') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'L73') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'L73') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'L73') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'L73') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'L73') * propowner_dist_15;
	
	propowner_rcvalued34 := (integer)(propowner_aacd_0 = 'D34') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'D34') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'D34') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'D34') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'D34') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'D34') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'D34') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'D34') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'D34') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'D34') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'D34') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'D34') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'D34') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'D34') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'D34') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'D34') * propowner_dist_15;
	
	propowner_rcvaluep85 := (integer)(propowner_aacd_0 = 'P85') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'P85') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'P85') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'P85') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'P85') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'P85') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'P85') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'P85') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'P85') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'P85') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'P85') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'P85') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'P85') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'P85') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'P85') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'P85') * propowner_dist_15;
	
	propowner_rcvalued31 := (integer)(propowner_aacd_0 = 'D31') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'D31') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'D31') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'D31') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'D31') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'D31') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'D31') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'D31') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'D31') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'D31') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'D31') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'D31') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'D31') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'D31') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'D31') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'D31') * propowner_dist_15;
	
	propowner_rcvaluea47 := (integer)(propowner_aacd_0 = 'A47') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'A47') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'A47') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'A47') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'A47') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'A47') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'A47') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'A47') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'A47') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'A47') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'A47') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'A47') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'A47') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'A47') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'A47') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'A47') * propowner_dist_15;
	
	propowner_rcvaluea44 := (integer)(propowner_aacd_0 = 'A44') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'A44') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'A44') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'A44') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'A44') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'A44') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'A44') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'A44') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'A44') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'A44') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'A44') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'A44') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'A44') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'A44') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'A44') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'A44') * propowner_dist_15;
	
	propowner_rcvaluef01 := (integer)(propowner_aacd_0 = 'F01') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'F01') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'F01') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'F01') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'F01') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'F01') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'F01') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'F01') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'F01') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'F01') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'F01') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'F01') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'F01') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'F01') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'F01') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'F01') * propowner_dist_15;
	
	propowner_rcvaluef03 := (integer)(propowner_aacd_0 = 'F03') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'F03') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'F03') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'F03') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'F03') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'F03') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'F03') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'F03') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'F03') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'F03') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'F03') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'F03') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'F03') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'F03') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'F03') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'F03') * propowner_dist_15;
	
	propowner_rcvalueS65 := (integer)(propowner_aacd_0 = 'S65') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'S65') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'S65') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'S65') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'S65') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'S65') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'S65') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'S65') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'S65') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'S65') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'S65') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'S65') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'S65') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'S65') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'S65') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'S65') * propowner_dist_15;
	
	propowner_rcvaluee55 := (integer)(propowner_aacd_0 = 'E55') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'E55') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'E55') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'E55') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'E55') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'E55') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'E55') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'E55') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'E55') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'E55') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'E55') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'E55') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'E55') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'E55') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'E55') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'E55') * propowner_dist_15;
	
	propowner_rcvaluec12 := (integer)(propowner_aacd_0 = 'C12') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'C12') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'C12') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'C12') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'C12') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'C12') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'C12') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'C12') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'C12') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'C12') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'C12') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'C12') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'C12') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'C12') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'C12') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'C12') * propowner_dist_15;
	
	propowner_rcvalues66 := (integer)(propowner_aacd_0 = 'S66') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'S66') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'S66') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'S66') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'S66') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'S66') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'S66') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'S66') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'S66') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'S66') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'S66') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'S66') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'S66') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'S66') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'S66') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'S66') * propowner_dist_15;
	
	propowner_rcvaluec14 := (integer)(propowner_aacd_0 = 'C14') * propowner_dist_0 +
	    (integer)(propowner_aacd_1 = 'C14') * propowner_dist_1 +
	    (integer)(propowner_aacd_2 = 'C14') * propowner_dist_2 +
	    (integer)(propowner_aacd_3 = 'C14') * propowner_dist_3 +
	    (integer)(propowner_aacd_4 = 'C14') * propowner_dist_4 +
	    (integer)(propowner_aacd_5 = 'C14') * propowner_dist_5 +
	    (integer)(propowner_aacd_6 = 'C14') * propowner_dist_6 +
	    (integer)(propowner_aacd_7 = 'C14') * propowner_dist_7 +
	    (integer)(propowner_aacd_8 = 'C14') * propowner_dist_8 +
	    (integer)(propowner_aacd_9 = 'C14') * propowner_dist_9 +
	    (integer)(propowner_aacd_10 = 'C14') * propowner_dist_10 +
	    (integer)(propowner_aacd_11 = 'C14') * propowner_dist_11 +
	    (integer)(propowner_aacd_12 = 'C14') * propowner_dist_12 +
	    (integer)(propowner_aacd_13 = 'C14') * propowner_dist_13 +
	    (integer)(propowner_aacd_14 = 'C14') * propowner_dist_14 +
	    (integer)(propowner_aacd_15 = 'C14') * propowner_dist_15;


//=========================================================
//==  start calculating the RC values for other segment   =
//=========================================================
	
	other_dist_12 := _ov_pts_lost_raw;
	
	other_aacd_12 := map(
	    ov_corrections       => 'L73',
	    ov_ssnprior          => 'S65',
			                        '');
	
	other_rcvaluea47 := (integer)(other_aacd_0 = 'A47') * other_dist_0 +
	    (integer)(other_aacd_1 = 'A47') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A47') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A47') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A47') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A47') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A47') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A47') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A47') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A47') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A47') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A47') * other_dist_11 +
	    (integer)(other_aacd_12 = 'A47') * other_dist_12;
	
	other_rcvaluel73 := (integer)(other_aacd_0 = 'L73') * other_dist_0 +
	    (integer)(other_aacd_1 = 'L73') * other_dist_1 +
	    (integer)(other_aacd_2 = 'L73') * other_dist_2 +
	    (integer)(other_aacd_3 = 'L73') * other_dist_3 +
	    (integer)(other_aacd_4 = 'L73') * other_dist_4 +
	    (integer)(other_aacd_5 = 'L73') * other_dist_5 +
	    (integer)(other_aacd_6 = 'L73') * other_dist_6 +
	    (integer)(other_aacd_7 = 'L73') * other_dist_7 +
	    (integer)(other_aacd_8 = 'L73') * other_dist_8 +
	    (integer)(other_aacd_9 = 'L73') * other_dist_9 +
	    (integer)(other_aacd_10 = 'L73') * other_dist_10 +
	    (integer)(other_aacd_11 = 'L73') * other_dist_11 +
	    (integer)(other_aacd_12 = 'L73') * other_dist_12;
	
	other_rcvalued34 := (integer)(other_aacd_0 = 'D34') * other_dist_0 +
	    (integer)(other_aacd_1 = 'D34') * other_dist_1 +
	    (integer)(other_aacd_2 = 'D34') * other_dist_2 +
	    (integer)(other_aacd_3 = 'D34') * other_dist_3 +
	    (integer)(other_aacd_4 = 'D34') * other_dist_4 +
	    (integer)(other_aacd_5 = 'D34') * other_dist_5 +
	    (integer)(other_aacd_6 = 'D34') * other_dist_6 +
	    (integer)(other_aacd_7 = 'D34') * other_dist_7 +
	    (integer)(other_aacd_8 = 'D34') * other_dist_8 +
	    (integer)(other_aacd_9 = 'D34') * other_dist_9 +
	    (integer)(other_aacd_10 = 'D34') * other_dist_10 +
	    (integer)(other_aacd_11 = 'D34') * other_dist_11 +
	    (integer)(other_aacd_12 = 'D34') * other_dist_12;
	
	other_rcvalueS65 := (integer)(other_aacd_0 = 'S65') * other_dist_0 +
	    (integer)(other_aacd_1 = 'S65') * other_dist_1 +
	    (integer)(other_aacd_2 = 'S65') * other_dist_2 +
	    (integer)(other_aacd_3 = 'S65') * other_dist_3 +
	    (integer)(other_aacd_4 = 'S65') * other_dist_4 +
	    (integer)(other_aacd_5 = 'S65') * other_dist_5 +
	    (integer)(other_aacd_6 = 'S65') * other_dist_6 +
	    (integer)(other_aacd_7 = 'S65') * other_dist_7 +
	    (integer)(other_aacd_8 = 'S65') * other_dist_8 +
	    (integer)(other_aacd_9 = 'S65') * other_dist_9 +
	    (integer)(other_aacd_10 = 'S65') * other_dist_10 +
	    (integer)(other_aacd_11 = 'S65') * other_dist_11 +
	    (integer)(other_aacd_12 = 'S65') * other_dist_12;
	
	other_rcvalueC12 := 
    (integer)(other_aacd_0 = 'C12') * other_dist_0 +
    (integer)(other_aacd_1 = 'C12') * other_dist_1 +
    (integer)(other_aacd_2 = 'C12') * other_dist_2 +
    (integer)(other_aacd_3 = 'C12') * other_dist_3 +
    (integer)(other_aacd_4 = 'C12') * other_dist_4 +
    (integer)(other_aacd_5 = 'C12') * other_dist_5 +
    (integer)(other_aacd_6 = 'C12') * other_dist_6 +
    (integer)(other_aacd_7 = 'C12') * other_dist_7 +
    (integer)(other_aacd_8 = 'C12') * other_dist_8 +
    (integer)(other_aacd_9 = 'C12') * other_dist_9 +
    (integer)(other_aacd_10 = 'C12') * other_dist_10 +
    (integer)(other_aacd_11 = 'C12') * other_dist_11 +
    (integer)(other_aacd_12 = 'C12') * other_dist_12;

	
	other_rcvalued31 := (integer)(other_aacd_0 = 'D31') * other_dist_0 +
	    (integer)(other_aacd_1 = 'D31') * other_dist_1 +
	    (integer)(other_aacd_2 = 'D31') * other_dist_2 +
	    (integer)(other_aacd_3 = 'D31') * other_dist_3 +
	    (integer)(other_aacd_4 = 'D31') * other_dist_4 +
	    (integer)(other_aacd_5 = 'D31') * other_dist_5 +
	    (integer)(other_aacd_6 = 'D31') * other_dist_6 +
	    (integer)(other_aacd_7 = 'D31') * other_dist_7 +
	    (integer)(other_aacd_8 = 'D31') * other_dist_8 +
	    (integer)(other_aacd_9 = 'D31') * other_dist_9 +
	    (integer)(other_aacd_10 = 'D31') * other_dist_10 +
	    (integer)(other_aacd_11 = 'D31') * other_dist_11 +
	    (integer)(other_aacd_12 = 'D31') * other_dist_12;
	
	other_rcvaluea50 := (integer)(other_aacd_0 = 'A50') * other_dist_0 +
	    (integer)(other_aacd_1 = 'A50') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A50') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A50') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A50') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A50') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A50') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A50') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A50') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A50') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A50') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A50') * other_dist_11 +
	    (integer)(other_aacd_12 = 'A50') * other_dist_12;
	
	other_rcvaluea44 := (integer)(other_aacd_0 = 'A44') * other_dist_0 +
	    (integer)(other_aacd_1 = 'A44') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A44') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A44') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A44') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A44') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A44') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A44') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A44') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A44') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A44') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A44') * other_dist_11 +
	    (integer)(other_aacd_12 = 'A44') * other_dist_12;
	
	other_rcvaluec18 := (integer)(other_aacd_0 = 'C18') * other_dist_0 +
	    (integer)(other_aacd_1 = 'C18') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C18') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C18') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C18') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C18') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C18') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C18') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C18') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C18') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C18') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C18') * other_dist_11 +
	    (integer)(other_aacd_12 = 'C18') * other_dist_12;
	
	other_rcvaluef01 := (integer)(other_aacd_0 = 'F01') * other_dist_0 +
	    (integer)(other_aacd_1 = 'F01') * other_dist_1 +
	    (integer)(other_aacd_2 = 'F01') * other_dist_2 +
	    (integer)(other_aacd_3 = 'F01') * other_dist_3 +
	    (integer)(other_aacd_4 = 'F01') * other_dist_4 +
	    (integer)(other_aacd_5 = 'F01') * other_dist_5 +
	    (integer)(other_aacd_6 = 'F01') * other_dist_6 +
	    (integer)(other_aacd_7 = 'F01') * other_dist_7 +
	    (integer)(other_aacd_8 = 'F01') * other_dist_8 +
	    (integer)(other_aacd_9 = 'F01') * other_dist_9 +
	    (integer)(other_aacd_10 = 'F01') * other_dist_10 +
	    (integer)(other_aacd_11 = 'F01') * other_dist_11 +
	    (integer)(other_aacd_12 = 'F01') * other_dist_12;
	
	other_rcvaluef03 := (integer)(other_aacd_0 = 'F03') * other_dist_0 +
	    (integer)(other_aacd_1 = 'F03') * other_dist_1 +
	    (integer)(other_aacd_2 = 'F03') * other_dist_2 +
	    (integer)(other_aacd_3 = 'F03') * other_dist_3 +
	    (integer)(other_aacd_4 = 'F03') * other_dist_4 +
	    (integer)(other_aacd_5 = 'F03') * other_dist_5 +
	    (integer)(other_aacd_6 = 'F03') * other_dist_6 +
	    (integer)(other_aacd_7 = 'F03') * other_dist_7 +
	    (integer)(other_aacd_8 = 'F03') * other_dist_8 +
	    (integer)(other_aacd_9 = 'F03') * other_dist_9 +
	    (integer)(other_aacd_10 = 'F03') * other_dist_10 +
	    (integer)(other_aacd_11 = 'F03') * other_dist_11 +
	    (integer)(other_aacd_12 = 'F03') * other_dist_12;
	
	other_rcvaluea41 := (integer)(other_aacd_0 = 'A41') * other_dist_0 +
	    (integer)(other_aacd_1 = 'A41') * other_dist_1 +
	    (integer)(other_aacd_2 = 'A41') * other_dist_2 +
	    (integer)(other_aacd_3 = 'A41') * other_dist_3 +
	    (integer)(other_aacd_4 = 'A41') * other_dist_4 +
	    (integer)(other_aacd_5 = 'A41') * other_dist_5 +
	    (integer)(other_aacd_6 = 'A41') * other_dist_6 +
	    (integer)(other_aacd_7 = 'A41') * other_dist_7 +
	    (integer)(other_aacd_8 = 'A41') * other_dist_8 +
	    (integer)(other_aacd_9 = 'A41') * other_dist_9 +
	    (integer)(other_aacd_10 = 'A41') * other_dist_10 +
	    (integer)(other_aacd_11 = 'A41') * other_dist_11 +
	    (integer)(other_aacd_12 = 'A41') * other_dist_12;
	
	other_rcvaluee55 := (integer)(other_aacd_0 = 'E55') * other_dist_0 +
	    (integer)(other_aacd_1 = 'E55') * other_dist_1 +
	    (integer)(other_aacd_2 = 'E55') * other_dist_2 +
	    (integer)(other_aacd_3 = 'E55') * other_dist_3 +
	    (integer)(other_aacd_4 = 'E55') * other_dist_4 +
	    (integer)(other_aacd_5 = 'E55') * other_dist_5 +
	    (integer)(other_aacd_6 = 'E55') * other_dist_6 +
	    (integer)(other_aacd_7 = 'E55') * other_dist_7 +
	    (integer)(other_aacd_8 = 'E55') * other_dist_8 +
	    (integer)(other_aacd_9 = 'E55') * other_dist_9 +
	    (integer)(other_aacd_10 = 'E55') * other_dist_10 +
	    (integer)(other_aacd_11 = 'E55') * other_dist_11 +
	    (integer)(other_aacd_12 = 'E55') * other_dist_12;
	
	other_rcvaluec10 := (integer)(other_aacd_0 = 'C10') * other_dist_0 +
	    (integer)(other_aacd_1 = 'C10') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C10') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C10') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C10') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C10') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C10') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C10') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C10') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C10') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C10') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C10') * other_dist_11 +
	    (integer)(other_aacd_12 = 'C10') * other_dist_12;
	
	other_rcvaluec14 := (integer)(other_aacd_0 = 'C14') * other_dist_0 +
	    (integer)(other_aacd_1 = 'C14') * other_dist_1 +
	    (integer)(other_aacd_2 = 'C14') * other_dist_2 +
	    (integer)(other_aacd_3 = 'C14') * other_dist_3 +
	    (integer)(other_aacd_4 = 'C14') * other_dist_4 +
	    (integer)(other_aacd_5 = 'C14') * other_dist_5 +
	    (integer)(other_aacd_6 = 'C14') * other_dist_6 +
	    (integer)(other_aacd_7 = 'C14') * other_dist_7 +
	    (integer)(other_aacd_8 = 'C14') * other_dist_8 +
	    (integer)(other_aacd_9 = 'C14') * other_dist_9 +
	    (integer)(other_aacd_10 = 'C14') * other_dist_10 +
	    (integer)(other_aacd_11 = 'C14') * other_dist_11 +
	    (integer)(other_aacd_12 = 'C14') * other_dist_12;
	
	
	//*************************************************************************************//
	//   reason code logic   
	//*************************************************************************************//
	
	ds_layout := {STRING rc, REAL value};
	 
//=======================
//===   PropOwner     ===
//======================= 
	rc_dataset_propowner := DATASET([
	    {'C22', propowner_rcvalueC22},
	    {'A50', propowner_rcvalueA50},
	    {'L73', propowner_rcvalueL73},
	    {'D34', propowner_rcvalueD34},
	    {'P85', propowner_rcvalueP85},
	    {'D31', propowner_rcvalueD31},
	    {'A47', propowner_rcvalueA47},
	    {'A44', propowner_rcvalueA44},
	    {'F01', propowner_rcvalueF01},
	    {'F03', propowner_rcvalueF03},
	    {'S65', propowner_rcvalueS65},
	    {'E55', propowner_rcvalueE55},
	    {'C12', propowner_rcvalueC12},
	    {'S66', propowner_rcvalueS66},
	    {'C14', propowner_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.   
	//*************************************************************************************//
	rc_dataset_propowner_sorted := sort(rc_dataset_propowner, rc_dataset_propowner.value);
	
	//output((rc_dataset_propowner_sorted), NAMED('propowner_rc_table'));
	
	propowner_rc1 := rc_dataset_propowner_sorted[1].rc;
	propowner_rc2 := rc_dataset_propowner_sorted[2].rc;
	propowner_rc3 := rc_dataset_propowner_sorted[3].rc;
	propowner_rc4 := rc_dataset_propowner_sorted[4].rc;
	
	propowner_vl1 := rc_dataset_propowner_sorted[1].value;
	propowner_vl2 := rc_dataset_propowner_sorted[2].value;
	propowner_vl3 := rc_dataset_propowner_sorted[3].value;
	propowner_vl4 := rc_dataset_propowner_sorted[4].value;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_other := DATASET([
	    {'A47', other_rcvalueA47},
	    {'L73', other_rcvalueL73},
	    {'D34', other_rcvalueD34},
	    {'S65', other_rcvalueS65},
			{'C12', other_rcvalueC12},
	    {'D31', other_rcvalueD31},
	    {'A50', other_rcvalueA50},
	    {'A44', other_rcvalueA44},
	    {'C18', other_rcvalueC18},
	    {'F01', other_rcvalueF01},
	    {'F03', other_rcvalueF03},
	    {'A41', other_rcvalueA41},
	    {'E55', other_rcvalueE55},
	    {'C10', other_rcvalueC10},
	    {'C14', other_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.   
	//*************************************************************************************//
	rc_dataset_other_sorted := sort(rc_dataset_other, rc_dataset_other.value);
	
	other_rc1 := rc_dataset_other_sorted[1].rc;
	other_rc2 := rc_dataset_other_sorted[2].rc;
	other_rc3 := rc_dataset_other_sorted[3].rc;
	other_rc4 := rc_dataset_other_sorted[4].rc;
	
	other_vl1 := rc_dataset_other_sorted[1].value;
	other_vl2 := rc_dataset_other_sorted[2].value;
	other_vl3 := rc_dataset_other_sorted[3].value;
	other_vl4 := rc_dataset_other_sorted[4].value;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_verprob := DATASET([
	    {'A47', verprob_rcvalueA47},
	    {'L73', verprob_rcvalueL73},
	    {'L80', verprob_rcvalueL80},
	    {'D30', verprob_rcvalueD30},
	    {'A50', verprob_rcvalueA50},
	    {'F01', verprob_rcvalueF01},
	    {'F00', verprob_rcvalueF00},
	    {'A41', verprob_rcvalueA41},
	    {'E55', verprob_rcvalueE55},
	    {'C12', verprob_rcvalueC12},
	    {'S66', verprob_rcvalueS66},
	    {'S65', verprob_rcvalueS65},
	    {'C14', verprob_rcvalueC14}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.   
	//*************************************************************************************//
	rc_dataset_verprob_sorted := sort(rc_dataset_verprob, rc_dataset_verprob.value);
	
	verprob_rc1 := rc_dataset_verprob_sorted[1].rc;
	verprob_rc2 := rc_dataset_verprob_sorted[2].rc;
	verprob_rc3 := rc_dataset_verprob_sorted[3].rc;
	verprob_rc4 := rc_dataset_verprob_sorted[4].rc;
	
	verprob_vl1 := rc_dataset_verprob_sorted[1].value;
	verprob_vl2 := rc_dataset_verprob_sorted[2].value;
	verprob_vl3 := rc_dataset_verprob_sorted[3].value;
	verprob_vl4 := rc_dataset_verprob_sorted[4].value;
	//*************************************************************************************//
	
	 
	//*************************************************************************************//
	rc_dataset_derog := DATASET([
	    {'A50', derog_rcvalueA50},
	    {'F04', derog_rcvalueF04},
	    {'L73', derog_rcvalueL73},
	    {'S65', derog_rcvalueS65},
	    {'D32', derog_rcvalueD32},
	    {'D33', derog_rcvalueD33},
	    {'A47', derog_rcvalueA47},
	    {'A42', derog_rcvalueA42},
	    {'C12', derog_rcvalueC12},
	    {'E55', derog_rcvalueE55},
	    {'F01', derog_rcvalueF01},
	    {'E57', derog_rcvalueE57}
	    ], ds_layout)(value < 0);
	
	//*************************************************************************************//
	// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.   
	//*************************************************************************************//
	rc_dataset_derog_sorted := sort(rc_dataset_derog, rc_dataset_derog.value);
	
	derog_rc1 := rc_dataset_derog_sorted[1].rc;
	derog_rc2 := rc_dataset_derog_sorted[2].rc;
	derog_rc3 := rc_dataset_derog_sorted[3].rc;
	derog_rc4 := rc_dataset_derog_sorted[4].rc;
	
	derog_vl1 := rc_dataset_derog_sorted[1].value;
	derog_vl2 := rc_dataset_derog_sorted[2].value;
	derog_vl3 := rc_dataset_derog_sorted[3].value;
	derog_vl4 := rc_dataset_derog_sorted[4].value;
	//*************************************************************************************//
	
	
//=======================================================================
//==   After calculating the reason codes and scores for each segment 
//==   Choose the reason code based on segment this consumer falls into
//=======================================================================

	rc1_2 := map(
	    VerProb_seg   => verprob_rc1,
	    Derog_seg     => derog_rc1,
	    PropOwner_seg => propowner_rc1,
	                     other_rc1);
	
	rc3_1 := map(
	    VerProb_seg   => verprob_rc3,
	    Derog_seg     => derog_rc3,
	    PropOwner_seg => propowner_rc3,
	                     other_rc3);
	
	rc2_1 := map(
	    VerProb_seg   => verprob_rc2,
	    Derog_seg     => derog_rc2,
	    PropOwner_seg => propowner_rc2,
	                     other_rc2);
	
	rc4_1 := map(
	    VerProb_seg   => verprob_rc4,
	    Derog_seg     => derog_rc4,
	    PropOwner_seg => propowner_rc4,
	                     other_rc4);
	
	rc1_1 := if(trim(rc1_2, ALL) = '', _rc_seg, rc1_2);
	
	rc4 := if((rvb1503_0_1 in [200, 222]), '', rc4_1);
	
	rc5 := '';
	
	rc1 := if((rvb1503_0_1 in [200, 222]), '', rc1_1);
	
	rc3 := if((rvb1503_0_1 in [200, 222]), '', rc3_1);
	
	rc2 := if((rvb1503_0_1 in [200, 222]), '', rc2_1);


	//*************************************************************************************//
	//                     RiskView Version 5 - RVB1503 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Lex ID Only On Input = 222 (FLAGSHIP MODELS ONLY)
	// SSNPrior OR Corrections = 550
	// Score Range: 501 - 900
	//*************************************************************************************//


//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
HRILayout     := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
		// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
								rvb1503_0_1 = 200      => DATASET([{'00'}], HRILayout),
								rvb1503_0_1 = 222      => DATASET([{'00'}], HRILayout),
								rvb1503_0_1 = 900      => DATASET([{'00'}], HRILayout),
																          DATASET([], HRILayout)
													                             );
													
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI NOT IN ['', '00']);
										
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);

// Keep up to 5 reason codes
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5);      
//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
			/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.seq     := seq;
		SELF.out_z5 := out_z5;
		SELF.out_addr_status := out_addr_status;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.nap_status := nap_status;
		SELF.rc_ssndod := rc_ssndod;
		SELF.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := rc_hphonetypeflag;
		SELF.rc_phonevalflag := rc_phonevalflag;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_hriskaddrflag := rc_hriskaddrflag;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssndobflag := rc_ssndobflag;
		SELF.rc_pwssndobflag := rc_pwssndobflag;
		SELF.rc_addrvalflag := rc_addrvalflag;
		SELF.rc_addrcommflag := rc_addrcommflag;
		SELF.rc_hrisksic := rc_hrisksic;
		SELF.rc_hrisksicphone := rc_hrisksicphone;
		SELF.rc_phonetype := rc_phonetype;
		SELF.rc_ziptypeflag := rc_ziptypeflag;
		SELF.combo_dobscore := combo_dobscore;
		SELF.hdr_source_profile := hdr_source_profile;
		SELF.ver_sources := ver_sources;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.add_input_address_score := add_input_address_score;
		SELF.add_input_isbestmatch := add_input_isbestmatch;
		SELF.add_input_addr_not_verified := add_input_addr_not_verified;
		SELF.add_input_owned_not_occ := add_input_owned_not_occ;
		SELF.add_input_advo_vacancy := add_input_advo_vacancy;
		SELF.add_input_advo_res_or_bus := add_input_advo_res_or_bus;
		SELF.add_input_avm_auto_val := add_input_avm_auto_val;
		SELF.add_input_naprop := add_input_naprop;
		SELF.add_input_pop := add_input_pop;
		SELF.property_owned_total := property_owned_total;
		SELF.add_curr_isbestmatch := add_curr_isbestmatch;
		SELF.add_curr_occ_index := add_curr_occ_index;
		SELF.add_curr_avm_auto_val := add_curr_avm_auto_val;
		SELF.add_curr_naprop := add_curr_naprop;
		SELF.add_curr_pop := add_curr_pop;
		SELF.add_prev_naprop := add_prev_naprop;
		SELF.addrs_15yr := addrs_15yr;
		SELF.telcordia_type := telcordia_type;
		SELF.header_first_seen := header_first_seen;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.adls_per_ssn := adls_per_ssn;
		SELF.adls_per_addr_curr := adls_per_addr_curr;
		SELF.ssns_per_addr_curr := ssns_per_addr_curr;
		SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
		SELF.invalid_addrs_per_adl := invalid_addrs_per_adl;
		SELF.pb_total_dollars := pb_total_dollars;
		SELF.pb_total_orders := pb_total_orders;
		SELF.br_source_count := br_source_count;
		SELF.infutor_nap := infutor_nap;
		SELF.stl_inq_count12 := stl_inq_count12;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_num_unrel_liens30 := attr_num_unrel_liens30;
		SELF.attr_num_unrel_liens90 := attr_num_unrel_liens90;
		SELF.attr_num_unrel_liens180 := attr_num_unrel_liens180;
		SELF.attr_num_unrel_liens12 := attr_num_unrel_liens12;
		SELF.attr_num_unrel_liens24 := attr_num_unrel_liens24;
		SELF.attr_num_unrel_liens36 := attr_num_unrel_liens36;
		SELF.attr_num_unrel_liens60 := attr_num_unrel_liens60;
		SELF.attr_num_rel_liens30 := attr_num_rel_liens30;
		SELF.attr_num_rel_liens90 := attr_num_rel_liens90;
		SELF.attr_num_rel_liens180 := attr_num_rel_liens180;
		SELF.attr_num_rel_liens12 := attr_num_rel_liens12;
		SELF.attr_num_rel_liens24 := attr_num_rel_liens24;
		SELF.attr_num_rel_liens36 := attr_num_rel_liens36;
		SELF.attr_num_rel_liens60 := attr_num_rel_liens60;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_eviction_count90 := attr_eviction_count90;
		SELF.attr_eviction_count180 := attr_eviction_count180;
		SELF.attr_eviction_count12 := attr_eviction_count12;
		SELF.attr_eviction_count24 := attr_eviction_count24;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.attr_eviction_count60 := attr_eviction_count60;
		SELF.attr_num_nonderogs := attr_num_nonderogs;
		SELF.bankrupt := bankrupt;
		SELF.disposition := disposition;
		SELF.filing_count := filing_count;
		SELF.bk_dismissed_recent_count := bk_dismissed_recent_count;
		SELF.bk_dismissed_historical_count := bk_dismissed_historical_count;
		SELF.bk_disposed_recent_count := bk_disposed_recent_count;
		SELF.bk_disposed_historical_count := bk_disposed_historical_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_recent_released_count := liens_recent_released_count;
		SELF.liens_historical_released_count := liens_historical_released_count;
		SELF.liens_unrel_cj_ct := liens_unrel_cj_ct;
		SELF.liens_rel_cj_ct := liens_rel_cj_ct;
		SELF.liens_unrel_ft_ct := liens_unrel_ft_ct;
		SELF.liens_rel_ft_ct := liens_rel_ft_ct;
		SELF.liens_unrel_fc_ct := liens_unrel_fc_ct;
		SELF.liens_rel_fc_ct := liens_rel_fc_ct;
		SELF.liens_unrel_lt_ct := liens_unrel_lt_ct;
		SELF.liens_rel_lt_ct := liens_rel_lt_ct;
		SELF.liens_unrel_o_ct := liens_unrel_o_ct;
		SELF.liens_rel_o_ct := liens_rel_o_ct;
		SELF.liens_unrel_ot_ct := liens_unrel_ot_ct;
		SELF.liens_rel_ot_ct := liens_rel_ot_ct;
		SELF.liens_unrel_sc_ct := liens_unrel_sc_ct;
		SELF.liens_rel_sc_ct := liens_rel_sc_ct;
		SELF.liens_unrel_st_ct := liens_unrel_st_ct;
		SELF.liens_rel_st_ct := liens_rel_st_ct;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.college_file_type := college_file_type;
		SELF.college_attendance := college_attendance;
		SELF.prof_license_flag := prof_license_flag;
		SELF.input_dob_match_level := input_dob_match_level;

		/* Model Intermediate Variables */
		
		SELF.num_dob_match_level := num_dob_match_level;
		SELF.nas_summary_ver := nas_summary_ver;
		SELF.nap_summary_ver := nap_summary_ver;
		SELF.infutor_nap_ver := infutor_nap_ver;
		SELF.dob_ver := dob_ver;
		SELF.sufficiently_verified := sufficiently_verified;
		SELF.add_ec1 := add_ec1;
		SELF.addr_validation_problem := addr_validation_problem;
		SELF.phn_validation_problem := phn_validation_problem;
		SELF.validation_problem := validation_problem;
		SELF.tot_liens := tot_liens;
		SELF.tot_liens_w_type := tot_liens_w_type;
		SELF.has_derog := has_derog;
		SELF.rv_4seg_riskview_5_0 := rv_4seg_riskview_5_0;
		SELF.verprob_seg := verprob_seg;
		SELF.derog_seg := derog_seg;
		SELF.propowner_seg := propowner_seg;
		SELF.other_seg := other_seg;
		SELF.sysdate := sysdate;
		SELF.iv_rv5_unscorable := iv_rv5_unscorable;
		SELF.rv_a44_prop_owner_inp_only := rv_a44_prop_owner_inp_only;
		SELF.rv_a44_curr_add_naprop := rv_a44_curr_add_naprop;
		SELF.rv_prop_owner_history := rv_prop_owner_history;
		SELF.rv_a47_curr_avm_autoval := rv_a47_curr_avm_autoval;
		SELF.rv_a50_pb_total_orders := rv_a50_pb_total_orders;
		SELF.rv_a50_pb_total_dollars := rv_a50_pb_total_dollars;
		SELF._header_first_seen := _header_first_seen;
		SELF.rv_c10_m_hdr_fs := rv_c10_m_hdr_fs;
		SELF.rv_c12_source_profile := rv_c12_source_profile;
		SELF.rv_c12_num_nonderogs := rv_c12_num_nonderogs;
		SELF.rv_c14_addrs_15yr := rv_c14_addrs_15yr;
		SELF.rv_c18_invalid_addrs_per_adl := rv_c18_invalid_addrs_per_adl;
		SELF.rv_c22_inp_addr_owned_not_occ := rv_c22_inp_addr_owned_not_occ;
		SELF.rv_d30_derog_count := rv_d30_derog_count;
		SELF.rv_d31_all_bk := rv_d31_all_bk;
		SELF.rv_d31_bk_filing_count := rv_d31_bk_filing_count;
		SELF.rv_d32_criminal_x_felony := rv_d32_criminal_x_felony;
		SELF.rv_d33_eviction_recency := rv_d33_eviction_recency;
		SELF.rv_d34_unrel_liens_ct := rv_d34_unrel_liens_ct;
		SELF.rv_d34_attr_liens_recency := rv_d34_attr_liens_recency;
		SELF.rv_e55_college_ind := rv_e55_college_ind;
		SELF.rv_e57_prof_license_br_flag := rv_e57_prof_license_br_flag;
		SELF.rv_f00_addr_not_ver_w_ssn := rv_f00_addr_not_ver_w_ssn;
		SELF.rv_f00_dob_score := rv_f00_dob_score;
		SELF.rv_f01_inp_addr_address_score := rv_f01_inp_addr_address_score;
		SELF.rv_f01_inp_addr_not_verified := rv_f01_inp_addr_not_verified;
		SELF.rv_f03_address_match := rv_f03_address_match;
		SELF.rv_f03_input_add_not_most_rec := rv_f03_input_add_not_most_rec;
		SELF.rv_f04_curr_add_occ_index := rv_f04_curr_add_occ_index;
		SELF.rv_s66_adlperssn_count := rv_s66_adlperssn_count;
		SELF.rv_l80_inp_avm_autoval := rv_l80_inp_avm_autoval;
		SELF.rv_p85_phn_disconnected := rv_p85_phn_disconnected;
		SELF.verprob_subscore0 := verprob_subscore0;
		SELF.verprob_subscore1 := verprob_subscore1;
		SELF.verprob_subscore2 := verprob_subscore2;
		SELF.verprob_subscore3 := verprob_subscore3;
		SELF.verprob_subscore4 := verprob_subscore4;
		SELF.verprob_subscore5 := verprob_subscore5;
		SELF.verprob_subscore6 := verprob_subscore6;
		SELF.verprob_subscore7 := verprob_subscore7;
		SELF.verprob_subscore8 := verprob_subscore8;
		SELF.verprob_subscore9 := verprob_subscore9;
		SELF.verprob_subscore10 := verprob_subscore10;
		SELF.verprob_rawscore := verprob_rawscore;
		SELF.verprob_lnoddsscore := verprob_lnoddsscore;
		SELF.verprob_probscore := verprob_probscore;
		SELF.verprob_aacd_0 := verprob_aacd_0;
		SELF.verprob_dist_0_1 := verprob_dist_0_1;
		SELF.verprob_aacd_1 := verprob_aacd_1;
		SELF.verprob_dist_1 := verprob_dist_1;
		SELF.verprob_aacd_2 := verprob_aacd_2;
		SELF.verprob_dist_2 := verprob_dist_2;
		SELF.verprob_aacd_3 := verprob_aacd_3;
		SELF.verprob_dist_3 := verprob_dist_3;
		SELF.verprob_aacd_4 := verprob_aacd_4;
		SELF.verprob_dist_4 := verprob_dist_4;
		SELF.verprob_aacd_5 := verprob_aacd_5;
		SELF.verprob_dist_5 := verprob_dist_5;
		SELF.verprob_aacd_6 := verprob_aacd_6;
		SELF.verprob_dist_6 := verprob_dist_6;
		SELF.verprob_aacd_7 := verprob_aacd_7;
		SELF.verprob_dist_7 := verprob_dist_7;
		SELF.verprob_aacd_8_1 := verprob_aacd_8_1;
		SELF.verprob_dist_8_1 := verprob_dist_8_1;
		SELF.verprob_dist_8 := verprob_dist_8;
		SELF.verprob_aacd_8 := verprob_aacd_8;
		SELF.verprob_dist_0 := verprob_dist_0;
		SELF.verprob_aacd_9 := verprob_aacd_9;
		SELF.verprob_dist_9 := verprob_dist_9;
		SELF.verprob_aacd_10 := verprob_aacd_10;
		SELF.verprob_dist_10 := verprob_dist_10;
		SELF.derog_subscore0 := derog_subscore0;
		SELF.derog_subscore1 := derog_subscore1;
		SELF.derog_subscore2 := derog_subscore2;
		SELF.derog_subscore3 := derog_subscore3;
		SELF.derog_subscore4 := derog_subscore4;
		SELF.derog_subscore5 := derog_subscore5;
		SELF.derog_subscore6 := derog_subscore6;
		SELF.derog_subscore7 := derog_subscore7;
		SELF.derog_subscore8 := derog_subscore8;
		SELF.derog_subscore9 := derog_subscore9;
		SELF.derog_rawscore := derog_rawscore;
		SELF.derog_lnoddsscore := derog_lnoddsscore;
		SELF.derog_probscore := derog_probscore;
		SELF.derog_aacd_0 := derog_aacd_0;
		SELF.derog_dist_0 := derog_dist_0;
		SELF.derog_aacd_1 := derog_aacd_1;
		SELF.derog_dist_1 := derog_dist_1;
		SELF.derog_aacd_2 := derog_aacd_2;
		SELF.derog_dist_2 := derog_dist_2;
		SELF.derog_aacd_3 := derog_aacd_3;
		SELF.derog_dist_3 := derog_dist_3;
		SELF.derog_aacd_4 := derog_aacd_4;
		SELF.derog_dist_4 := derog_dist_4;
		SELF.derog_aacd_5 := derog_aacd_5;
		SELF.derog_dist_5 := derog_dist_5;
		SELF.derog_aacd_6 := derog_aacd_6;
		SELF.derog_dist_6 := derog_dist_6;
		SELF.derog_aacd_7 := derog_aacd_7;
		SELF.derog_dist_7 := derog_dist_7;
		SELF.derog_aacd_8 := derog_aacd_8;
		SELF.derog_dist_8 := derog_dist_8;
		SELF.derog_aacd_9 := derog_aacd_9;
		SELF.derog_dist_9 := derog_dist_9;
		SELF.propowner_subscore0 := propowner_subscore0;
		SELF.propowner_subscore1 := propowner_subscore1;
		SELF.propowner_subscore2 := propowner_subscore2;
		SELF.propowner_subscore3 := propowner_subscore3;
		SELF.propowner_subscore4 := propowner_subscore4;
		SELF.propowner_subscore5 := propowner_subscore5;
		SELF.propowner_subscore6 := propowner_subscore6;
		SELF.propowner_subscore7 := propowner_subscore7;
		SELF.propowner_subscore8 := propowner_subscore8;
		SELF.propowner_subscore9 := propowner_subscore9;
		SELF.propowner_subscore10 := propowner_subscore10;
		SELF.propowner_subscore11 := propowner_subscore11;
		SELF.propowner_subscore12 := propowner_subscore12;
		SELF.propowner_subscore13 := propowner_subscore13;
		SELF.propowner_subscore14 := propowner_subscore14;
		SELF.propowner_rawscore := propowner_rawscore;
		SELF.propowner_lnoddsscore := propowner_lnoddsscore;
		SELF.propowner_probscore := propowner_probscore;
		SELF.propowner_aacd_0 := propowner_aacd_0;
		SELF.propowner_dist_0 := propowner_dist_0;
		SELF.propowner_aacd_1 := propowner_aacd_1;
		SELF.propowner_dist_1 := propowner_dist_1;
		SELF.propowner_aacd_2 := propowner_aacd_2;
		SELF.propowner_dist_2 := propowner_dist_2;
		SELF.propowner_aacd_3 := propowner_aacd_3;
		SELF.propowner_dist_3 := propowner_dist_3;
		SELF.propowner_aacd_4 := propowner_aacd_4;
		SELF.propowner_dist_4 := propowner_dist_4;
		SELF.propowner_aacd_5 := propowner_aacd_5;
		SELF.propowner_dist_5 := propowner_dist_5;
		SELF.propowner_aacd_6 := propowner_aacd_6;
		SELF.propowner_dist_6 := propowner_dist_6;
		SELF.propowner_aacd_7 := propowner_aacd_7;
		SELF.propowner_dist_7 := propowner_dist_7;
		SELF.propowner_aacd_8 := propowner_aacd_8;
		SELF.propowner_dist_8 := propowner_dist_8;
		SELF.propowner_aacd_9 := propowner_aacd_9;
		SELF.propowner_dist_9 := propowner_dist_9;
		SELF.propowner_aacd_10 := propowner_aacd_10;
		SELF.propowner_dist_10 := propowner_dist_10;
		SELF.propowner_aacd_11 := propowner_aacd_11;
		SELF.propowner_dist_11 := propowner_dist_11;
		SELF.propowner_aacd_12 := propowner_aacd_12;
		SELF.propowner_dist_12 := propowner_dist_12;
		SELF.propowner_aacd_13 := propowner_aacd_13;
		SELF.propowner_dist_13 := propowner_dist_13;
		SELF.propowner_aacd_14 := propowner_aacd_14;
		SELF.propowner_dist_14 := propowner_dist_14;
		SELF.other_subscore0 := other_subscore0;
		SELF.other_subscore1 := other_subscore1;
		SELF.other_subscore2 := other_subscore2;
		SELF.other_subscore3 := other_subscore3;
		SELF.other_subscore4 := other_subscore4;
		SELF.other_subscore5 := other_subscore5;
		SELF.other_subscore6 := other_subscore6;
		SELF.other_subscore7 := other_subscore7;
		SELF.other_subscore8 := other_subscore8;
		SELF.other_subscore9 := other_subscore9;
		SELF.other_subscore10 := other_subscore10;
		SELF.other_subscore11 := other_subscore11;
		SELF.other_rawscore := other_rawscore;
		SELF.other_lnoddsscore := other_lnoddsscore;
		SELF.other_probscore := other_probscore;
		SELF.other_aacd_0 := other_aacd_0;
		SELF.other_dist_0 := other_dist_0;
		SELF.other_aacd_1 := other_aacd_1;
		SELF.other_dist_1 := other_dist_1;
		SELF.other_aacd_2 := other_aacd_2;
		SELF.other_dist_2 := other_dist_2;
		SELF.other_aacd_3 := other_aacd_3;
		SELF.other_dist_3 := other_dist_3;
		SELF.other_aacd_4 := other_aacd_4;
		SELF.other_dist_4 := other_dist_4;
		SELF.other_aacd_5 := other_aacd_5;
		SELF.other_dist_5 := other_dist_5;
		SELF.other_aacd_6 := other_aacd_6;
		SELF.other_dist_6 := other_dist_6;
		SELF.other_aacd_7 := other_aacd_7;
		SELF.other_dist_7 := other_dist_7;
		SELF.other_aacd_8 := other_aacd_8;
		SELF.other_dist_8 := other_dist_8;
		SELF.other_aacd_9 := other_aacd_9;
		SELF.other_dist_9 := other_dist_9;
		SELF.other_aacd_10 := other_aacd_10;
		SELF.other_dist_10 := other_dist_10;
		SELF.other_aacd_11 := other_aacd_11;
		SELF.other_dist_11 := other_dist_11;
		SELF.base := base;
		SELF.points := points;
		SELF.odds := odds;
		SELF.lnoddsscore := lnoddsscore;
		SELF.score_lnodds := score_lnodds;
		SELF.score_lnodds_capped := score_lnodds_capped;
		SELF.ov_ssnprior := ov_ssnprior;
		SELF.ov_corrections := ov_corrections;
		SELF.deceased := deceased;
		SELF._ov_pts_lost_c142_b3 := _ov_pts_lost_c142_b3;
		SELF.rvb1503_0_1 := rvb1503_0_1;
		SELF._ov_pts_lost_raw := _ov_pts_lost_raw;
		SELF._rc_seg_c145 := _rc_seg_c145;
		SELF._rc_seg_c146 := _rc_seg_c146;
		SELF._rc_seg_c144 := _rc_seg_c144;
		SELF._rc_seg_c147 := _rc_seg_c147;
		SELF._rc_seg := _rc_seg;
		SELF.verprob_dist_11 := verprob_dist_11;
		SELF.verprob_aacd_11 := verprob_aacd_11;
		SELF.verprob_rcvaluea47 := verprob_rcvaluea47;
		SELF.verprob_rcvaluel73 := verprob_rcvaluel73;
		SELF.verprob_rcvaluel80 := verprob_rcvaluel80;
		SELF.verprob_rcvalued30 := verprob_rcvalued30;
		SELF.verprob_rcvaluea50 := verprob_rcvaluea50;
		SELF.verprob_rcvaluef01 := verprob_rcvaluef01;
		SELF.verprob_rcvaluef00 := verprob_rcvaluef00;
		SELF.verprob_rcvaluea41 := verprob_rcvaluea41;
		SELF.verprob_rcvaluee55 := verprob_rcvaluee55;
		SELF.verprob_rcvaluec12 := verprob_rcvaluec12;
		SELF.verprob_rcvalues66 := verprob_rcvalues66;
		SELF.verprob_rcvalueS65 := verprob_rcvalueS65;
		SELF.verprob_rcvaluec14 := verprob_rcvaluec14;
		SELF.derog_dist_10 := derog_dist_10;
		SELF.derog_aacd_10 := derog_aacd_10;
		SELF.derog_rcvaluea50 := derog_rcvaluea50;
		SELF.derog_rcvaluef04 := derog_rcvaluef04;
		SELF.derog_rcvaluel73 := derog_rcvaluel73;
		SELF.derog_rcvalueS65 := derog_rcvalueS65;
		SELF.derog_rcvalued32 := derog_rcvalued32;
		SELF.derog_rcvalued33 := derog_rcvalued33;
		SELF.derog_rcvaluea47 := derog_rcvaluea47;
		SELF.derog_rcvaluea42 := derog_rcvaluea42;
		SELF.derog_rcvaluec12 := derog_rcvaluec12;
		SELF.derog_rcvaluee55 := derog_rcvaluee55;
		SELF.derog_rcvaluef01 := derog_rcvaluef01;
		SELF.derog_rcvaluee57 := derog_rcvaluee57;
		SELF.propowner_dist_15 := propowner_dist_15;
		SELF.propowner_aacd_15 := propowner_aacd_15;
		SELF.propowner_rcvaluec22 := propowner_rcvaluec22;
		SELF.propowner_rcvaluea50 := propowner_rcvaluea50;
		SELF.propowner_rcvaluel73 := propowner_rcvaluel73;
		SELF.propowner_rcvalued34 := propowner_rcvalued34;
		SELF.propowner_rcvaluep85 := propowner_rcvaluep85;
		SELF.propowner_rcvalued31 := propowner_rcvalued31;
		SELF.propowner_rcvaluea47 := propowner_rcvaluea47;
		SELF.propowner_rcvaluea44 := propowner_rcvaluea44;
		SELF.propowner_rcvaluef01 := propowner_rcvaluef01;
		SELF.propowner_rcvaluef03 := propowner_rcvaluef03;
		SELF.propowner_rcvalueS65 := propowner_rcvalueS65;
		SELF.propowner_rcvaluee55 := propowner_rcvaluee55;
		SELF.propowner_rcvaluec12 := propowner_rcvaluec12;
		SELF.propowner_rcvalues66 := propowner_rcvalues66;
		SELF.propowner_rcvaluec14 := propowner_rcvaluec14;
		SELF.other_dist_12 := other_dist_12;
		SELF.other_aacd_12 := other_aacd_12;
		SELF.other_rcvaluea47 := other_rcvaluea47;
		SELF.other_rcvaluel73 := other_rcvaluel73;
		SELF.other_rcvalued34 := other_rcvalued34;
		SELF.other_rcvalueS65 := other_rcvalueS65;
		SELF.other_rcvaluec12 := other_rcvaluec12;
		SELF.other_rcvalued31 := other_rcvalued31;
		SELF.other_rcvaluea50 := other_rcvaluea50;
		SELF.other_rcvaluea44 := other_rcvaluea44;
		SELF.other_rcvaluec18 := other_rcvaluec18;
		SELF.other_rcvaluef01 := other_rcvaluef01;
		SELF.other_rcvaluef03 := other_rcvaluef03;
		SELF.other_rcvaluea41 := other_rcvaluea41;
		SELF.other_rcvaluee55 := other_rcvaluee55;
		SELF.other_rcvaluec10 := other_rcvaluec10;
		SELF.other_rcvaluec14 := other_rcvaluec14;
		SELF.propowner_rc1 := propowner_rc1;
		SELF.propowner_rc2 := propowner_rc2;
		SELF.propowner_rc3 := propowner_rc3;
		SELF.propowner_rc4 := propowner_rc4;
		SELF.propowner_vl1 := propowner_vl1;
		SELF.propowner_vl2 := propowner_vl2;
		SELF.propowner_vl3 := propowner_vl3;
		SELF.propowner_vl4 := propowner_vl4;
		SELF.other_rc1 := other_rc1;
		SELF.other_rc2 := other_rc2;
		SELF.other_rc3 := other_rc3;
		SELF.other_rc4 := other_rc4;
		SELF.other_vl1 := other_vl1;
		SELF.other_vl2 := other_vl2;
		SELF.other_vl3 := other_vl3;
		SELF.other_vl4 := other_vl4;
		SELF.verprob_rc1 := verprob_rc1;
		SELF.verprob_rc2 := verprob_rc2;
		SELF.verprob_rc3 := verprob_rc3;
		SELF.verprob_rc4 := verprob_rc4;
		SELF.verprob_vl1 := verprob_vl1;
		SELF.verprob_vl2 := verprob_vl2;
		SELF.verprob_vl3 := verprob_vl3;
		SELF.verprob_vl4 := verprob_vl4;
		SELF.derog_rc1 := derog_rc1;
		SELF.derog_rc2 := derog_rc2;
		SELF.derog_rc3 := derog_rc3;
		SELF.derog_rc4 := derog_rc4;
		SELF.derog_vl1 := derog_vl1;
		SELF.derog_vl2 := derog_vl2;
		SELF.derog_vl3 := derog_vl3;
		SELF.derog_vl4 := derog_vl4;
		SELF.rc1_2 := rc1_2;
		SELF.rc3_1 := rc3_1;
		SELF.rc2_1 := rc2_1;
		SELF.rc4_1 := rc4_1;
		SELF.rc1_1 := rc1_1;

		SELF.rc1 := reasonCodes[1].hri;
		SELF.rc2 := reasonCodes[2].hri;
		SELF.rc3 := reasonCodes[3].hri;
		SELF.rc4 := reasonCodes[4].hri;
		SELF.rc5 := reasonCodes[5].hri;
    
		SELF.model_name := 'RVB1503_DEBUG'; 
		
    SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvb1503_0_1;		
		
		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvb1503_0_1;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
