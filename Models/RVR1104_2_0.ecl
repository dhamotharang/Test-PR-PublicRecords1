import risk_indicators, ut, std, riskview;

export RVR1104_2_0( grouped dataset( risk_indicators.Layout_Boca_Shell ) clam, boolean isCalifornia, boolean xmlPreScreenOptOut) := FUNCTION


	rvg4 := models.RVG1103_0_0( clam, isCalifornia, xmlPreScreenOptOut ); // call rv4 money in order to get reason codes


	RVR_DEBUG := false;
	
	#if(RVR_DEBUG)
		layout_debug := record
			risk_indicators.Layout_Boca_Shell clam;
			Boolean trueDID;
			String in_state;
			String out_unit_desig;
			String out_sec_range;
			String out_addr_type;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String rc_hriskphoneflag;
			String rc_hriskaddrflag;
			String rc_decsflag;
			String rc_pwssnvalflag;
			Integer rc_ssnlowissue;
			String rc_ssnstate;
			String rc_addrvalflag;
			String rc_dwelltype;
			String rc_bansflag;
			String rc_addrcommflag;
			Integer combo_dobscore;
			Integer combo_fnamecount;
			Integer combo_lnamecount;
			Integer combo_addrcount;
			Integer combo_hphonecount;
			Integer combo_ssncount;
			Integer combo_dobcount;
			qstring100 ver_sources;
			qstring100 ver_sources_count;
			Boolean fnamepop;
			Boolean lnamepop;
			Boolean addrPop;
			String ssnlength;
			Boolean dobpop;
			Boolean hphnpop;
			Integer age;
			Boolean add1_isbestmatch;
			String add1_advo_address_vacancy;
			String add1_avm_assessed_total_value;
			Integer add1_avm_automated_valuation;
			Integer add1_avm_med_fips;
			Integer add1_avm_med_geo11;
			Integer add1_avm_med_geo12;
			Boolean add1_applicant_owned;
			Integer ADD1_NAPROP;
			Integer add1_date_last_seen;
			Integer PROPERTY_OWNED_TOTAL;
			Integer PROPERTY_SOLD_TOTAL;
			String add2_addr_type;
			String add2_avm_assessed_total_value;
			Integer add2_avm_automated_valuation;
			Integer add2_avm_med_fips;
			Integer add2_avm_med_geo11;
			Integer add2_avm_med_geo12;
			Integer avg_lres;
			Integer max_lres;
			Boolean addrs_prison_history;
			Integer avg_mo_per_addr;
			String telcordia_type;
			String gong_did_first_seen;
			String gong_did_last_seen;
			Integer gong_did_first_ct;
			Integer gong_did_last_ct;
			Integer header_last_seen;
			Integer ssns_per_adl;
			Integer adlPerSSN_count;
			Integer adls_per_addr;
			Integer ssns_per_addr;
			Integer ssns_per_adl_c6;
			Integer lnames_per_adl_c6;
			Integer adls_per_ssn_c6;
			Integer inq_collection_count12;
			Integer inq_banking_count12;
			Integer inq_highriskcredit_count12;
			Integer inq_communications_count12;
			Integer inq_perssn;
			Integer inq_peraddr;
			Integer inq_perphone;
			Integer infutor_nap;
			Integer impulse_count;
			Integer email_domain_free_count;
			qstring50 email_source_list;
			Integer attr_date_last_purchase;
			Integer attr_num_purchase60;
			Integer attr_num_sold60;
			Integer attr_total_number_derogs;
			Integer attr_date_last_eviction;
			Integer attr_num_nonderogs;
			Boolean Bankrupt;
			String disposition;
			Integer filing_count;
			Integer bk_recent_count;
			Integer bk_disposed_recent_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_unrel_cj_ct;
			Integer liens_unrel_cj_last_seen;
			Integer liens_unrel_cj_total_amount;
			Integer liens_unrel_ft_first_seen;
			Integer liens_unrel_ft_last_seen;
			Integer liens_unrel_ot_ct;
			Integer liens_rel_ot_ct;
			Integer liens_unrel_sc_ct;
			Integer liens_unrel_sc_last_seen;
			Integer liens_unrel_sc_total_amount;
			Integer liens_rel_sc_ct;
			Integer criminal_count;
			Integer criminal_last_date;
			Integer felony_count;
			String ams_age;
			String wealth_index;
			String input_dob_age;
			String input_dob_match_level;
			Integer inferred_age;
			Integer reported_dob;
			Integer estimated_income;
			Integer sysdate;
			Integer num_els_popd_1;
			Integer num_els_verd;
			Real pct_els_verd;
			Integer did1_els_verd_lvl;
			Real did1_els_verd_lvl0;
			Integer _criminal_last_date;
			Integer mos_criminal_last_seen;
			Integer did1_criminal_lvl;
			Real did1_criminal_lvl0;
			Real did1_criminal_lvl1;
			Boolean Impulse_Email;
			Integer did1_impulse_lvl;
			Real did1_impulse_lvl0;
			Real did1_impulse_lvl1;
			Integer _attr_date_last_eviction;
			Integer mos_eviction_last_seen;
			Integer did1_eviction_lvl;
			Real did1_eviction_lvl0;
			Integer did1_bk_lvl;
			Real did1_bk_lvl1;
			Real did1_bk_lvl0;
			Integer total_recs;
			Integer derog_ratio_c16;
			Integer derog_ratio;
			Boolean discharged_bk;
			Integer did1_derog_ratio_lvl;
			Real did1_derog_ratio_lvl0;
			Real did1_derog_ratio_lvl1;
			Boolean add_apt;
			Integer ids_per_addr_max;
			Integer did1_ids_per_addr_lvl_c21;
			Integer did1_ids_per_addr_lvl_c22;
			Integer did1_ids_per_addr_lvl;
			Real did1_ids_per_addr_lvl0;
			Real did1_ids_per_addr_lvl1;
			Integer did1_ssns_per_adl_lvl;
			Real did1_ssns_per_adl_lvl0;
			Real did1_ssns_per_adl_lvl1;
			Boolean inq_coll;
			Boolean inq_banking;
			Boolean inq_highrisk;
			Boolean inq_comm;
			Boolean _inq_perssn;
			Boolean _inq_peraddr;
			Boolean _inq_perphone;
			Integer inq_ele_sum;
			Integer did1_inq_lvl;
			Real did1_inq_lvl0;
			Real did1_inq_lvl1;
			Integer did1_email_lvl;
			Real did1_email_lvl0;
			Boolean aptflag1;
			Boolean aptflag2;
			Integer econval1_c34;
			Integer econval1_c35;
			Integer econval1_1;
			String econcode1_c37;
			String econcode1_c38;
			String econcode1;
			Integer econval2_c40;
			Integer econval2_c41;
			Integer econval2;
			String econcode2_c43;
			String econcode2_c44;
			String econcode2;
			Integer did1_econcode_lvl;
			Real did1_econcode_lvl0;
			Real did1_econcode_lvl1;
			Integer did1_wealth_index_lvl;
			Real did1_wealth_index_lvl0;
			Real did1_wealth_index_lvl1;
			Integer _liens_unrel_cj_last_seen;
			Integer mos_cj_unrel_last_seen;
			Integer liens_cj_lvl;
			Real liens_cj_lvl0;
			Real liens_cj_lvl1;
			Integer liens_ot_lvl;
			Real liens_ot_lvl0;
			Integer _liens_unrel_sc_last_seen;
			Integer mos_sc_unrel_last_seen;
			Integer liens_sc_lvl;
			Real liens_sc_lvl0;
			Real liens_sc_lvl1;
			Integer _reported_dob;
			Integer reported_age;
			Real applicant_age;
			Integer did1_age_lvl_c61;
			Integer did1_age_lvl_c62;
			Integer did1_age_lvl_c63;
			Integer did1_age_lvl_c64;
			Integer did1_age_lvl;
			Real did1_age_lvl0;
			Real did1_age_lvl1;
			Boolean contrary_inf;
			Boolean verfst_i;
			Boolean verlst_i;
			Boolean veradd_i;
			Boolean verfst_p;
			Boolean verlst_p;
			Boolean veradd_p;
			Boolean verphn_p;
			Boolean veradd_s;
			Boolean dob_verd;
			Real vermod_log;
			Real did1_vermod;
			Boolean mw_sourced;
			Boolean did1_mw_sourced_f;
			Integer _add1_date_last_seen;
			Integer mos_add1_date_last_seen;
			Boolean seen_recently;
			Boolean app_owned;
			Boolean stolen_addr;
			Boolean property_owner;
			Real naprop_log;
			Real did1_naprop_mod;
			Integer _gong_did_first_seen;
			Integer _gong_did_last_seen;
			Integer mos_since_gong_first_seen;
			Integer mos_since_gong_last_seen;
			Boolean phn_last_seen_rec;
			Boolean phn_first_seen_rec;
			Boolean phn_disconnected;
			Boolean phn_notpots;
			Boolean phn_bad_counts;
			Real phnmod_log;
			Real did1_phnprob_mod;
			Boolean ssn_issued18;
			Boolean ssn_statediff;
			Boolean ssn_deceased_1;
			Boolean ssn_adl_prob;
			Integer _rc_ssnlowissue;
			Integer yr_rc_ssnlowissue;
			Real yr_reported_dob;
			Boolean neg_age_at_low_issue_f;
			Real ssnmod_log;
			Real did1_ssnmod;
			Integer _header_last_seen;
			Integer mos_header_last_seen;
			Boolean did1_header_not_seen_recent_f;
			Boolean did1_lnames_per_adl_c6_f;
			Boolean did1_adls_per_ssn_f;
			Integer _liens_unrel_ft_first_seen;
			Integer _liens_unrel_ft_last_seen;
			Integer mos_ft_unrel_first_seen;
			Integer mos_ft_unrel_last_seen;
			Integer liens_ft_lvl;
			Integer _attr_date_last_purchase;
			Integer mos_attr_date_last_purchase;
			Boolean did1_recent_purchase_f;
			Integer did1_attr_sold_purch_lvl;
			Real did1_attr_sold_purch_lvl1;
			Integer did1_avg_addr_lres_lvl;
			Real did1_avg_addr_lres_lvl1;
			Boolean add_highrisk;
			Boolean add_inval;
			Boolean vacant_addr;
			Boolean prison_hist;
			Integer did1_addr_prob_lvl;
			Real did1_addr_prob_lvl1;
			Integer sl_cnt;
			Integer did1_sl_source_ct;
			Real did1_sl_source_ct1;
			Integer num_els_popd;
			Integer combo_count_avg;
			Integer did1_ele_verd_lvl;
			Real did1_ele_verd_lvl1;
			Real subpop0_log;
			Real subpop1_log;
			Boolean source_tot_DS;
			Boolean source_tot_BA;
			Boolean bk_flag;
			Boolean lien_rec_unrel_flag;
			Boolean lien_hist_unrel_flag;
			Boolean source_tot_L2;
			Boolean source_tot_LI;
			Boolean lien_flag;
			Boolean ssn_deceased;
			Boolean scored_222s;
			Boolean _222;
			Integer point;
			Integer base;
			Integer odds;
			Boolean ba_sourced;
			Real phat;
			Integer final_score;
			Integer RVR1104_2_0;
			models.layout_modelout;
		end;
		layout_debug doModel( clam le, rvg4 ri ) := TRANSFORM
	#else
		models.layout_modelout doModel( clam le, rvg4 ri ) := TRANSFORM
	#end
	

		truedid                          := le.truedid;
		in_state                         := le.shell_input.in_state;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hriskaddrflag                 := le.iid.hriskaddrflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
		rc_ssnstate                      := le.iid.soclstate;
		rc_addrvalflag                   := le.iid.addrvalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_addrcommflag                  := le.iid.addrcommflag;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_fnamecount                 := le.iid.combo_firstcount;
		combo_lnamecount                 := le.iid.combo_lastcount;
		combo_addrcount                  := le.iid.combo_addrcount;
		combo_hphonecount                := le.iid.combo_hphonecount;
		combo_ssncount                   := le.iid.combo_ssncount;
		combo_dobcount                   := le.iid.combo_dobcount;
		ver_sources                      := le.header_summary.ver_sources;
		ver_sources_count                := le.header_summary.ver_sources_recordcount;
		fnamepop                         := le.input_validation.firstname;
		lnamepop                         := le.input_validation.lastname;
		addrpop                          := le.input_validation.address;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		hphnpop                          := le.input_validation.homephone;
		age                              := le.name_verification.age;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
		add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_date_last_seen              := le.address_verification.input_address_information.date_last_seen;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		add2_addr_type                   := le.address_verification.addr_type2;
		add2_avm_assessed_total_value    := le.avm.address_history_1.avm_assessed_total_value;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
		add2_avm_med_geo11               := le.avm.address_history_1.avm_median_geo11_level;
		add2_avm_med_geo12               := le.avm.address_history_1.avm_median_geo12_level;
		avg_lres                         := le.other_address_info.avg_lres;
		max_lres                         := le.other_address_info.max_lres;
		addrs_prison_history             := le.other_address_info.isprison;
		avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
		telcordia_type                   := le.phone_verification.telcordia_type;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
		gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
		gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
		header_last_seen                 := le.ssn_verification.header_last_seen;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		lnames_per_adl_c6                := le.velocity_counters.lnames_per_adl180;
		adls_per_ssn_c6                  := le.velocity_counters.adls_per_ssn_created_6months;
		inq_collection_count12           := le.acc_logs.collection.count12;
		inq_banking_count12              := le.acc_logs.banking.count12;
		inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
		inq_communications_count12       := le.acc_logs.communications.count12;
		inq_perssn                       := le.acc_logs.inquiryperssn;
		inq_peraddr                      := le.acc_logs.inquiryperaddr;
		inq_perphone                     := le.acc_logs.inquiryperphone;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		email_domain_free_count          := le.email_summary.email_domain_free_ct;
		email_source_list                := le.email_summary.email_source_list;
		attr_date_last_purchase          := le.other_address_info.date_most_recent_purchase;
		attr_num_purchase60              := le.other_address_info.num_purchase60;
		attr_num_sold60                  := le.other_address_info.num_sold60;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_date_last_eviction          := le.bjl.last_eviction_date;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_unrel_cj_last_seen         := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
		liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
		liens_unrel_ft_first_seen        := le.liens.liens_unreleased_federal_tax.earliest_filing_date;
		liens_unrel_ft_last_seen         := le.liens.liens_unreleased_federal_tax.most_recent_filing_date;
		liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
		liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		liens_unrel_sc_last_seen         := le.liens.liens_unreleased_small_claims.most_recent_filing_date;
		liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
		liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_count                     := le.bjl.felony_count;
		ams_age                          := le.student.age;
		wealth_index                     := le.wealth_indicator;
		input_dob_age                    := le.shell_input.age;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		estimated_income                 := le.estimated_income;







		NULL := -999999999;


		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


		BOOLEAN indexw(string source, string target, string delim) :=
			(source = target) OR
			(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
			(source[1..length(target)+1] = target + delim) OR
			(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);


		INTEGER year(integer sas_date) :=
			if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

		sysdate := models.common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

		num_els_popd_1 := sum((integer)lnamepop, (integer)addrpop, (integer)(real)ssnlength = 9, (integer)dobpop, (integer)hphnpop);

		num_els_verd := sum((integer)(combo_lnamecount > 0), (integer)(combo_addrcount > 0), (integer)(combo_hphonecount > 0), (integer)(combo_ssncount > 0), (integer)(combo_dobcount > 0));

		pct_els_verd := if(num_els_popd_1 > 0, num_els_verd / num_els_popd_1, NULL);

		did1_els_verd_lvl := map(
				pct_els_verd >= 1     => 4,
				pct_els_verd >= 2 / 3 => 3,
				pct_els_verd >= 1 / 2 => 2,
				pct_els_verd >= 1 / 3 => 1,
																 0);

		did1_els_verd_lvl0 := map(
				did1_els_verd_lvl = 0 => 0.303030303,
				did1_els_verd_lvl = 1 => 0.2735191638,
				did1_els_verd_lvl = 2 => 0.1823099811,
				did1_els_verd_lvl = 3 => 0.1486768387,
																 0.1185240403);

		_criminal_last_date := models.common.sas_date((string)(criminal_last_date));

		mos_criminal_last_seen := if(min(sysdate, _criminal_last_date) = NULL, NULL, truncate((sysdate - _criminal_last_date) / (365.25 / 12)));

		did1_criminal_lvl := map(
				0 <= mos_criminal_last_seen AND mos_criminal_last_seen <= 12 or felony_count > 0 or criminal_count > 4 => 2,
				criminal_count > 0                                                                                     => 1,
																																																									0);

		did1_criminal_lvl0 := map(
				did1_criminal_lvl = 0 => 0.1426608471,
				did1_criminal_lvl = 1 => 0.1497005988,
																 0.2558139535);

		did1_criminal_lvl1 := map(
				did1_criminal_lvl = 0 => 0.0981665823,
				did1_criminal_lvl = 1 => 0.1344827586,
																 0.1985815603);

		impulse_email := (integer)contains_i(email_source_list, 'IM') > 0;

		did1_impulse_lvl := map(
				impulse_count > 1                  => 2,
				impulse_count > 0 or impulse_email => 1,
																							0);

		did1_impulse_lvl0 := map(
				did1_impulse_lvl = 0 => 0.1373518771,
				did1_impulse_lvl = 1 => 0.2652739456,
																0.402027027);

		did1_impulse_lvl1 := map(
				did1_impulse_lvl = 0 => 0.0942309952,
				did1_impulse_lvl = 1 => 0.1701030928,
																0.2610837438);

		_attr_date_last_eviction := models.common.sas_date((string)(attr_date_last_eviction));

		mos_eviction_last_seen := if(min(sysdate, _attr_date_last_eviction) = NULL, NULL, truncate((sysdate - _attr_date_last_eviction) / (365.25 / 12)));

		did1_eviction_lvl := map(
				mos_eviction_last_seen < 0  => 0,
				mos_eviction_last_seen > 24 => 1,
				mos_eviction_last_seen >= 0 => 2,
																			 1);

		did1_eviction_lvl0 := map(
				did1_eviction_lvl = 0 => 0.1415556182,
				did1_eviction_lvl = 1 => 0.1741700773,
																 0.2464228935);

		did1_bk_lvl := map(
				StringLib.StringToUpperCase(disposition) = 'DISMISSED' or bk_disposed_recent_count > 1 => 2,
				StringLib.StringToUpperCase(disposition) = 'DISCHARGED'                                => 0,
																																									 1);

		did1_bk_lvl1 := map(
				did1_bk_lvl = 0 => 0.0892290541,
				did1_bk_lvl = 1 => 0.1075693465,
													 0.1635559921);

		did1_bk_lvl0 := map(
				did1_bk_lvl = 0 => 0.0957178841,
				did1_bk_lvl = 1 => 0.1440565691,
													 0.1219512195);

		total_recs := if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs)));

		derog_ratio_c16 := if(attr_total_number_derogs = 0, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 10) * 10 + 100, if (attr_total_number_derogs * 100 / total_recs / 10 >= 0, roundup(attr_total_number_derogs * 100 / total_recs / 10), truncate(attr_total_number_derogs * 100 / total_recs / 10)) * 10);

		derog_ratio := if(total_recs > 0, derog_ratio_c16, 100);

		discharged_bk := StringLib.StringToUpperCase(disposition) = 'DISCHARGED';

		did1_derog_ratio_lvl := map(
				derog_ratio >= 140 or discharged_bk => 0,
				derog_ratio >= 130                  => 1,
				derog_ratio >= 110                  => 2,
				derog_ratio <= 20                   => 3,
				derog_ratio <= 40                   => 4,
				derog_ratio <= 50                   => 5,
				derog_ratio <= 60                   => 6,
																							 7);

		did1_derog_ratio_lvl0 := map(
				did1_derog_ratio_lvl = 0 => 0.123863065,
				did1_derog_ratio_lvl = 1 => 0.1407674213,
				did1_derog_ratio_lvl = 2 => 0.1486264557,
				did1_derog_ratio_lvl = 3 => 0.1622481442,
				did1_derog_ratio_lvl = 4 => 0.1720526631,
				did1_derog_ratio_lvl = 5 => 0.1783653846,
				did1_derog_ratio_lvl = 6 => 0.1630136986,
																		0.2123142251);

		did1_derog_ratio_lvl1 := map(
				did1_derog_ratio_lvl = 0 => 0.0900354441,
				did1_derog_ratio_lvl = 1 => 0.1071765817,
				did1_derog_ratio_lvl = 2 => 0.0966608084,
				did1_derog_ratio_lvl = 3 => 0.1236363636,
				did1_derog_ratio_lvl = 4 => 0.1298977853,
				did1_derog_ratio_lvl = 5 => 0.1431924883,
				did1_derog_ratio_lvl = 6 => 0.1951219512,
																		0.20657277);

		add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

		ids_per_addr_max := max(adls_per_addr, ssns_per_addr);

		did1_ids_per_addr_lvl_c21 := map(
				(ids_per_addr_max in [1, 2])                    => 0,
				(ids_per_addr_max in [3, 4, 5])                 => 1,
				5 < ids_per_addr_max AND ids_per_addr_max <= 15 => 2,
				ids_per_addr_max <= 20                          => 3,
																													 4);

		did1_ids_per_addr_lvl_c22 := map(
				(ids_per_addr_max in [0]) => 2,
				ids_per_addr_max <= 25    => 3,
																		 4);

		did1_ids_per_addr_lvl := if(not(add_apt), did1_ids_per_addr_lvl_c21, did1_ids_per_addr_lvl_c22);

		did1_ids_per_addr_lvl0 := map(
				did1_ids_per_addr_lvl = 0 => 0.120510397,
				did1_ids_per_addr_lvl = 1 => 0.1274534474,
				did1_ids_per_addr_lvl = 2 => 0.1394597159,
				did1_ids_per_addr_lvl = 3 => 0.1539225422,
																		 0.1651547492);

		did1_ids_per_addr_lvl1 := map(
				did1_ids_per_addr_lvl = 0 => 0.072173913,
				did1_ids_per_addr_lvl = 1 => 0.0921835174,
				did1_ids_per_addr_lvl = 2 => 0.0980896215,
				did1_ids_per_addr_lvl = 3 => 0.106817195,
																		 0.1059753954);

		did1_ssns_per_adl_lvl := map(
				ssns_per_adl = 1 and ssns_per_adl_c6 = 0            => 0,
				ssns_per_adl = 2 and ssns_per_adl_c6 = 0            => 1,
				(ssns_per_adl in [3, 4, 5]) and ssns_per_adl_c6 = 0 => 2,
				(ssns_per_adl in [1, 2]) and ssns_per_adl_c6 = 1    => 2,
				ssns_per_adl = 3 and ssns_per_adl_c6 = 1            => 3,
				(ssns_per_adl in [4, 5]) and ssns_per_adl_c6 = 1    => 4,
				ssns_per_adl = 2 and ssns_per_adl_c6 = 2            => 4,
																															 5);

		did1_ssns_per_adl_lvl0 := map(
				did1_ssns_per_adl_lvl = 0 => 0.131838143,
				did1_ssns_per_adl_lvl = 1 => 0.1405215647,
				did1_ssns_per_adl_lvl = 2 => 0.1605485452,
				did1_ssns_per_adl_lvl = 3 => 0.1761219306,
				did1_ssns_per_adl_lvl = 4 => 0.1970260223,
																		 0.2088235294);

		did1_ssns_per_adl_lvl1 := map(
				did1_ssns_per_adl_lvl = 0 => 0.0901447626,
				did1_ssns_per_adl_lvl = 1 => 0.0981764897,
				did1_ssns_per_adl_lvl = 2 => 0.1055560035,
				did1_ssns_per_adl_lvl = 3 => 0.116,
				did1_ssns_per_adl_lvl = 4 => 0.154185022,
																		 0.1920903955);

		inq_coll := inq_collection_count12 > 0;

		inq_banking := inq_banking_count12 > 0;

		inq_highrisk := inq_highriskcredit_count12 > 0;

		inq_comm := inq_communications_count12 > 0;

		_inq_perssn := inq_perSSN > 0;

		_inq_peraddr := inq_perAddr > 0;

		_inq_perphone := inq_perPhone > 0;

		inq_ele_sum := if(max((integer)_inq_perssn, (integer)_inq_peraddr, (integer)_inq_perphone) = NULL, NULL, sum((integer)_inq_perssn, (integer)_inq_peraddr, (integer)_inq_perphone));

		did1_inq_lvl := map(
				inq_highrisk or inq_coll => 3,
				inq_comm or inq_banking  => 2,
				inq_ele_sum > 0          => 1,
																		0);

		did1_inq_lvl0 := map(
				did1_inq_lvl = 0 => 0.1360013182,
				did1_inq_lvl = 1 => 0.1576905523,
				did1_inq_lvl = 2 => 0.1656654344,
														0.2534626039);

		did1_inq_lvl1 := map(
				did1_inq_lvl = 0 => 0.0903501157,
				did1_inq_lvl = 1 => 0.1085085085,
				did1_inq_lvl = 2 => 0.1309155241,
														0.2038567493);

		did1_email_lvl := map(
				email_domain_free_count > 6 => 4,
				email_domain_free_count > 2 => 3,
				email_domain_free_count > 1 => 2,
				email_domain_free_count > 0 => 1,
																			 0);

		did1_email_lvl0 := map(
				did1_email_lvl = 0 => 0.1337041349,
				did1_email_lvl = 1 => 0.1559580553,
				did1_email_lvl = 2 => 0.1887972704,
				did1_email_lvl = 3 => 0.2083665339,
															0.2336956522);

		aptflag1 := (rc_dwelltype in ['A', 'H']);

		aptflag2 := (add2_addr_type in ['A', 'H']);

		econval1_c34 := map(
				add1_avm_automated_valuation > 0        => add1_avm_automated_valuation,
				(unsigned)add1_avm_assessed_total_value > 0 => (unsigned)add1_avm_assessed_total_value,
				add1_avm_med_geo12 > 0                  => add1_avm_med_geo12,
				add1_avm_med_geo11 > 0                  => add1_avm_med_geo11,
				add1_avm_med_fips > 0                   => add1_avm_med_fips,
																									 -1);

		econval1_c35 := map(
				add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
				add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
				add1_avm_med_fips > 0  => add1_avm_med_fips,
																	-1);

		econval1_1 := if(not(aptflag1), econval1_c34, econval1_c35);

		econcode1_c37 := map(
				econval1_1 > 650000 => 'A',
				econval1_1 > 450000 => 'B',
				econval1_1 > 250000 => 'C',
				econval1_1 > 125000 => 'D',
				econval1_1 > 75000  => 'E',
				econval1_1 > 0      => 'F',
															 'U');

		econcode1_c38 := map(
				econval1_1 > 1000000 => 'C',
				econval1_1 > 500000  => 'D',
				econval1_1 > 175000  => 'E',
				econval1_1 > 0       => 'F',
																'U');

		econcode1 := if(not(aptflag1), econcode1_c37, econcode1_c38);

		econval2_c40 := map(
				add2_avm_automated_valuation > 0        => add2_avm_automated_valuation,
				(real)add2_avm_assessed_total_value > 0 => NULL,
				add2_avm_med_geo12 > 0                  => add2_avm_med_geo12,
				add2_avm_med_geo11 > 0                  => add2_avm_med_geo11,
				add2_avm_med_fips > 0                   => add2_avm_med_fips,
																									 -1);

		econval2_c41 := map(
				add2_avm_med_geo12 > 0 => add2_avm_med_geo12,
				add2_avm_med_geo11 > 0 => add2_avm_med_geo11,
				add2_avm_med_fips > 0  => add2_avm_med_fips,
																	-1);

		econval2 := if(not(aptflag2), econval2_c40, econval2_c41);

		econcode2_c43 := map(
				econval2 > 650000 => 'A',
				econval2 > 450000 => 'B',
				econval2 > 250000 => 'C',
				econval2 > 125000 => 'D',
				econval2 > 75000  => 'E',
				econval2 > 0      => 'F',
														 'U');

		econcode2_c44 := map(
				econval2 > 1000000 => 'C',
				econval2 > 500000  => 'D',
				econval2 > 175000  => 'E',
				econval2 > 0       => 'F',
															'U');

		econcode2 := if(not(aptflag2), econcode2_c43, econcode2_c44);

		did1_econcode_lvl := map(
				(econcode1 in ['A', 'B', 'C']) and (econcode2 in ['A', 'U'])      => 4,
				(econcode1 in ['U']) and (econcode2 in ['A', 'B', 'C'])           => 4,
				(econcode1 in ['A', 'B', 'C'])                                    => 3,
				(econcode1 in ['D', 'E', 'F']) and not((econcode2 in ['F', 'U'])) => 2,
				(econcode1 in ['D', 'E', 'F'])                                    => 1,
				(econcode1 in ['U']) and (econcode2 in ['D', 'E'])                => 1,
																																						 0);

		did1_econcode_lvl0 := map(
				did1_econcode_lvl = 0 => 0.1616127045,
				did1_econcode_lvl = 1 => 0.1468554969,
				did1_econcode_lvl = 2 => 0.1358216923,
				did1_econcode_lvl = 3 => 0.1189988623,
																 0.0929032258);

		did1_econcode_lvl1 := map(
				did1_econcode_lvl = 0 => 0.1158311346,
				did1_econcode_lvl = 1 => 0.1007175586,
				did1_econcode_lvl = 2 => 0.092451111,
				did1_econcode_lvl = 3 => 0.0771230503,
																 0.0664206642);

		did1_wealth_index_lvl := map(
				estimated_income > 40000 and (real)wealth_index > 1 => 3,
				estimated_income > 30000 and (real)wealth_index > 3 => 3,
				(real)wealth_index > 4                              => 3,
				estimated_income > 30000 and (real)wealth_index = 0 => 2,
				estimated_income > 40000 and (real)wealth_index = 1 => 2,
				estimated_income > 30000 and (real)wealth_index = 2 => 2,
				(real)wealth_index > 2                              => 2,
				estimated_income > 0 and (real)wealth_index = 0     => 1,
																															 0);

		did1_wealth_index_lvl0 := map(
				did1_wealth_index_lvl = 0 => 0.1607994549,
				did1_wealth_index_lvl = 1 => 0.1525075207,
				did1_wealth_index_lvl = 2 => 0.1344272166,
																		 0.1196391052);

		did1_wealth_index_lvl1 := map(
				did1_wealth_index_lvl = 0 => 0.1144010767,
				did1_wealth_index_lvl = 1 => 0.1027665013,
				did1_wealth_index_lvl = 2 => 0.0984535665,
																		 0.0790547433);

		_liens_unrel_cj_last_seen := models.common.sas_date((string)(liens_unrel_CJ_last_seen));

		mos_cj_unrel_last_seen := if(min(sysdate, _liens_unrel_cj_last_seen) = NULL, NULL, truncate((sysdate - _liens_unrel_cj_last_seen) / (365.25 / 12)));

		liens_cj_lvl := map(
				0 < liens_unrel_CJ_total_amount AND liens_unrel_CJ_total_amount <= 1000 or 0 <= mos_cj_unrel_last_seen AND mos_cj_unrel_last_seen <= 6 => 4,
				liens_unrel_CJ_ct > 3                                                                                                                  => 3,
				liens_unrel_CJ_ct > 2 or 0 < liens_unrel_CJ_total_amount AND liens_unrel_CJ_total_amount <= 3000                                       => 2,
				liens_unrel_CJ_ct > 0                                                                                                                  => 1,
																																																																									0);

		liens_cj_lvl0 := map(
				liens_cj_lvl = 0 => 0.1400018593,
				liens_cj_lvl = 1 => 0.14617737,
				liens_cj_lvl = 2 => 0.1608533695,
				liens_cj_lvl = 3 => 0.1746987952,
														0.1956425078);

		liens_cj_lvl1 := map(
				liens_cj_lvl = 0 => 0.0915089125,
				liens_cj_lvl = 1 => 0.1077632045,
				liens_cj_lvl = 2 => 0.1295487627,
				liens_cj_lvl = 3 => 0.1476407915,
														0.1600265604);

		liens_ot_lvl := map(
				liens_unrel_OT_ct > 3 or liens_rel_OT_ct > 1 => 3,
				liens_unrel_OT_ct > 1                        => 2,
				liens_unrel_OT_ct > 0 or liens_rel_OT_ct > 0 => 1,
																												0);

		liens_ot_lvl0 := map(
				liens_ot_lvl = 0 => 0.1430542325,
				liens_ot_lvl = 1 => 0.1563758389,
				liens_ot_lvl = 2 => 0.1590909091,
														0.1922005571);

		_liens_unrel_sc_last_seen := models.common.sas_date((string)(liens_unrel_SC_last_seen));

		mos_sc_unrel_last_seen := if(min(sysdate, _liens_unrel_sc_last_seen) = NULL, NULL, truncate((sysdate - _liens_unrel_sc_last_seen) / (365.25 / 12)));

		liens_sc_lvl := map(
				0 <= mos_sc_unrel_last_seen AND mos_sc_unrel_last_seen <= 12 or liens_unrel_SC_ct > 2          => 4,
				liens_rel_SC_ct > 0 or 0 < liens_unrel_SC_total_amount AND liens_unrel_SC_total_amount <= 1000 => 3,
				0 < liens_unrel_SC_total_amount AND liens_unrel_SC_total_amount <= 3000                        => 2,
				liens_unrel_SC_total_amount > 0                                                                => 1,
																																																					0);

		liens_sc_lvl0 := map(
				liens_sc_lvl = 0 => 0.1413191354,
				liens_sc_lvl = 1 => 0.1465517241,
				liens_sc_lvl = 2 => 0.1657977059,
				liens_sc_lvl = 3 => 0.1829105474,
														0.2440191388);

		liens_sc_lvl1 := map(
				liens_sc_lvl = 0 => 0.0935829684,
				liens_sc_lvl = 1 => 0.11875,
				liens_sc_lvl = 2 => 0.145631068,
				liens_sc_lvl = 3 => 0.1661016949,
														0.2032193159);

		_reported_dob := models.common.sas_date((string)(reported_dob));

		reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

		applicant_age := map(
				(real)input_dob_age > 0 => (real)input_dob_age,
				(real)inferred_age > 0  => (real)inferred_age,
				(real)reported_age > 0  => (real)reported_age,
				(real)ams_age > 0       => (real)ams_age,
																	 -1);

		did1_age_lvl_c61 := map(
				applicant_age > 55 => 7,
				applicant_age > 45 => 6,
				applicant_age > 35 => 4,
				applicant_age > 18 => 2,
				applicant_age > 0  => 0,
															4);

		did1_age_lvl_c62 := map(
				applicant_age > 65 => 7,
				applicant_age > 45 => 6,
				applicant_age > 35 => 3,
				applicant_age > 18 => 1,
				applicant_age > 0  => 0,
															4);

		did1_age_lvl_c63 := map(
				applicant_age > 55 => 7,
				applicant_age > 35 => 6,
				applicant_age > 25 => 3,
				applicant_age > 18 => 1,
				applicant_age > 0  => 0,
															4);

		did1_age_lvl_c64 := map(
				applicant_age > 45 => 5,
				applicant_age > 35 => 2,
				applicant_age > 0  => 0,
															4);

		did1_age_lvl := map(
				(real)input_dob_match_level = 8 => did1_age_lvl_c61,
				(real)input_dob_match_level = 7 => did1_age_lvl_c62,
				(real)input_dob_match_level = 0 => did1_age_lvl_c63,
																					 did1_age_lvl_c64);

		did1_age_lvl0 := map(
				did1_age_lvl = 0 => 0.2630597015,
				did1_age_lvl = 1 => 0.1929358147,
				did1_age_lvl = 2 => 0.1850526316,
				did1_age_lvl = 3 => 0.1533882784,
				did1_age_lvl = 4 => 0.1644049595,
				did1_age_lvl = 5 => 0.1523009496,
				did1_age_lvl = 6 => 0.127059531,
														0.1089732957);

		did1_age_lvl1 := map(
				did1_age_lvl = 0 => 0.1862068966,
				did1_age_lvl = 1 => 0.1234042553,
				did1_age_lvl = 2 => 0.1378723404,
				did1_age_lvl = 3 => 0.1529680365,
				did1_age_lvl = 4 => 0.1190916944,
				did1_age_lvl = 5 => 0.1008264463,
				did1_age_lvl = 6 => 0.0945772059,
														0.0727066422);

		contrary_inf := (infutor_nap in [1]);

		verfst_i := (infutor_nap in [2, 3, 4, 8, 9, 10, 12]);

		verlst_i := (infutor_nap in [2, 5, 7, 8, 9, 11, 12]);

		veradd_i := (infutor_nap in [3, 5, 6, 8, 10, 11, 12]);

		verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

		verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

		veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

		verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

		veradd_s := (nas_summary in [3, 5, 6, 8, 10, 11, 12]);

		dob_verd := dobpop and (real)input_dob_match_level = 8 and combo_dobscore = 100;

		vermod_log := -0.8521 +
				(integer)contrary_inf * 0.0404 +
				(integer)verfst_i * -0.1188 +
				(integer)verlst_i * -0.5935 +
				(integer)veradd_i * 0.0362 +
				(integer)verlst_i * (integer)veradd_i * -0.0387 +
				(integer)verfst_p * -0.0290 +
				(integer)verlst_p * 0.1638 +
				(integer)veradd_i * (integer)verlst_p * -0.3198 +
				(integer)veradd_p * 0.0180 +
				(integer)verlst_i * (integer)veradd_p * -0.2853 +
				(integer)veradd_i * (integer)veradd_p * 0.4427 +
				(integer)verfst_p * (integer)veradd_p * -0.0591 +
				(integer)verphn_p * -0.2833 +
				(integer)contrary_inf * (integer)verphn_p * 0.6174 +
				(integer)verlst_i * (integer)verphn_p * 0.9527 +
				(integer)veradd_i * (integer)verphn_p * 0.2570 +
				(integer)verfst_p * (integer)verphn_p * -0.0610 +
				(integer)verlst_p * (integer)verphn_p * -0.4279 +
				(integer)veradd_s * -0.7802 +
				(integer)verlst_i * (integer)veradd_s * 0.3325 +
				(integer)add1_isbestmatch * -0.0859 +
				(integer)dob_verd * -0.1256;

		did1_vermod := round(100 * exp(vermod_log) / (1 + exp(vermod_log))/.1)*.1;

		mw_sourced := (integer)indexw(ver_sources, 'MW', ',') > 0;

		did1_mw_sourced_f := mw_sourced;

		_add1_date_last_seen := models.common.sas_date((string)(add1_date_last_seen));

		mos_add1_date_last_seen := if(min(sysdate, _add1_date_last_seen) = NULL, NULL, truncate((sysdate - _add1_date_last_seen) / 365.25));

		seen_recently := mos_add1_date_last_seen = 0;

		app_owned := add1_naprop = 4 and add1_applicant_owned and property_owned_total > 0;

		stolen_addr := (add1_naprop in [1, 2]);

		property_owner := property_owned_total > 0;

		naprop_log := -1.2340 +
				(integer)app_owned * -0.1056 +
				(integer)stolen_addr * 0.3519 +
				(integer)property_owner * -0.2538 +
				(integer)stolen_addr * (integer)property_owner * 0.2202 +
				(integer)seen_recently * -0.6657 +
				(integer)stolen_addr * (integer)seen_recently * -0.3428;

		did1_naprop_mod := round(100 * exp(naprop_log) / (1 + exp(naprop_log))/.1)*.1;

		_gong_did_first_seen := models.common.sas_date((string)(gong_did_first_seen));

		_gong_did_last_seen := models.common.sas_date((string)(gong_did_last_seen));

		mos_since_gong_first_seen := if(min(sysdate, _gong_did_first_seen) = NULL, NULL, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)));

		mos_since_gong_last_seen := if(min(sysdate, _gong_did_last_seen) = NULL, NULL, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)));

		phn_last_seen_rec := mos_since_gong_last_seen = 0;

		phn_first_seen_rec := 0 <= mos_since_gong_first_seen AND mos_since_gong_first_seen <= 6;

		phn_disconnected := (real)rc_hriskphoneflag = 5;

		phn_notpots := not((telcordia_type in ['00', '50', '51', '52', '54']));

		phn_bad_counts := gong_did_first_ct > 2 or gong_did_last_ct > 2;

		phnmod_log := -2.0238 +
				(integer)phn_last_seen_rec * -0.1725 +
				(integer)phn_first_seen_rec * 0.4551 +
				(integer)phn_disconnected * 0.7227 +
				(integer)phn_notpots * 0.3096 +
				(integer)phn_bad_counts * 0.2538;

		did1_phnprob_mod := round(100 * exp(phnmod_log) / (1 + exp(phnmod_log))/.1)*.1;

		ssn_issued18 := (real)rc_pwssnvalflag = 5;

		ssn_statediff := StringLib.StringToUpperCase(trim(rc_ssnstate, LEFT, RIGHT)) != StringLib.StringToUpperCase(trim(in_state, LEFT, RIGHT));

		ssn_deceased_1 := (real)rc_decsflag = 1;

		ssn_adl_prob := ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2;

		_rc_ssnlowissue := models.common.sas_date((string)(rc_ssnlowissue));

		yr_rc_ssnlowissue := year(_rc_ssnlowissue);

		yr_reported_dob := map(
				reported_dob != 0         => (real)((string)reported_dob)[1..4],
				age > 0                   => year(sysdate) - age,
				inferred_age > 0          => year(sysdate) - inferred_age,
																		 NULL);

		neg_age_at_low_issue_f := NULL not in [yr_rc_ssnlowissue,yr_reported_dob] AND yr_rc_ssnlowissue - yr_reported_dob <= 0;

		ssnmod_log := -1.8733 +
				(integer)ssn_issued18 * -0.2549 +
				(integer)ssn_statediff * -0.1265 +
				(integer)ssn_deceased_1 * 1.6436 +
				(integer)ssn_adl_prob * 0.2093 +
				(integer)neg_age_at_low_issue_f * 0.3844 +
				(integer)ssn_statediff * (integer)neg_age_at_low_issue_f * -0.2903;

		did1_ssnmod := round(100 * exp(ssnmod_log) / (1 + exp(ssnmod_log))/.1)*.1;

		_header_last_seen := models.common.sas_date((string)(header_last_seen));

		mos_header_last_seen := if(min(sysdate, _header_last_seen) = NULL, NULL, truncate((sysdate - _header_last_seen) / (365.25 / 12)));

		did1_header_not_seen_recent_f := mos_header_last_seen > 1;

		did1_lnames_per_adl_c6_f := lnames_per_adl_c6 > 0;

		did1_adls_per_ssn_f := adlperssn_count = 0 or adls_per_ssn_c6 > 0;

		_liens_unrel_ft_first_seen := models.common.sas_date((string)(liens_unrel_FT_first_seen));

		_liens_unrel_ft_last_seen := models.common.sas_date((string)(liens_unrel_FT_last_seen));

		mos_ft_unrel_first_seen := if(min(sysdate, _liens_unrel_ft_first_seen) = NULL, NULL, truncate((sysdate - _liens_unrel_ft_first_seen) / (365.25 / 12)));

		mos_ft_unrel_last_seen := if(min(sysdate, _liens_unrel_ft_last_seen) = NULL, NULL, truncate((sysdate - _liens_unrel_ft_last_seen) / (365.25 / 12)));

		liens_ft_lvl := if(0 <= mos_ft_unrel_first_seen AND mos_ft_unrel_first_seen <= 12 or 0 <= mos_ft_unrel_last_seen AND mos_ft_unrel_last_seen <= 12, 1, 0);

		_attr_date_last_purchase := models.common.sas_date((string)(attr_date_last_purchase));

		mos_attr_date_last_purchase := if(min(sysdate, _attr_date_last_purchase) = NULL, NULL, truncate((sysdate - _attr_date_last_purchase) / (365.25 / 12)));

		did1_recent_purchase_f := 0 <= mos_attr_date_last_purchase AND mos_attr_date_last_purchase <= 6;

		did1_attr_sold_purch_lvl := map(
				attr_num_purchase60 = 0 and attr_num_sold60 = 0 => 0,
				attr_num_purchase60 < 5 and attr_num_sold60 = 0 => 1,
				attr_num_purchase60 < 3 and attr_num_sold60 = 1 => 1,
				attr_num_purchase60 < 1 and attr_num_sold60 = 2 => 1,
																													 2);

		did1_attr_sold_purch_lvl1 := map(
				did1_attr_sold_purch_lvl = 0 => 0.1024532475,
				did1_attr_sold_purch_lvl = 1 => 0.0827143822,
																				0.0476190476);

		did1_avg_addr_lres_lvl := map(
				avg_lres <= 6 or max_lres <= 6 or avg_mo_per_addr <= 6      => 0,
				avg_lres <= 96 or max_lres <= 96 or avg_mo_per_addr <= 24   => 1,
				avg_lres <= 192 or max_lres <= 192 or avg_mo_per_addr <= 48 => 2,
																																			 3);

		did1_avg_addr_lres_lvl1 := map(
				did1_avg_addr_lres_lvl = 0 => 0.1484375,
				did1_avg_addr_lres_lvl = 1 => 0.1048666383,
				did1_avg_addr_lres_lvl = 2 => 0.0953778888,
																			0.0842167256);

		add_highrisk := (real)rc_hriskaddrflag = 4 or (real)rc_addrcommflag = 2;

		add_inval := StringLib.StringToUpperCase(trim(rc_addrvalflag, LEFT, RIGHT)) != 'V';

		vacant_addr := add1_advo_address_vacancy = 'Y';

		prison_hist := (integer)addrs_prison_history > 0;

		did1_addr_prob_lvl := map(
				vacant_addr or prison_hist => 2,
				add_inval or add_highrisk  => 1,
																			0);

		did1_addr_prob_lvl1 := map(
				did1_addr_prob_lvl = 0 => 0.0983541989,
				did1_addr_prob_lvl = 1 => 0.1179775281,
																	0.1518518519);


		sources_zipped := models.common.zip2( ver_sources, ver_sources_count, ' ,' );
		sl_cnt := (unsigned2)( sources_zipped( str1='SL' )[1].str2 );
		did1_SL_source_ct := min(SL_cnt,5);



		did1_sl_source_ct1 := map(
				did1_sl_source_ct = 0 => 0.0959583809,
				did1_sl_source_ct = 1 => 0.1233333333,
				did1_sl_source_ct = 2 => 0.1507936508,
				did1_sl_source_ct = 3 => 0.1435897436,
				did1_sl_source_ct = 4 => 0.1527777778,
																 0.2619047619);

		num_els_popd := if(max((integer)fnamepop, (integer)lnamepop, (integer)addrpop, (integer)hphnpop, (integer)(real)ssnlength = 9, (integer)dobpop) = NULL, NULL, sum((integer)fnamepop, (integer)lnamepop, (integer)addrpop, (integer)hphnpop, (integer)(real)ssnlength = 9, (integer)dobpop));

		combo_count_avg := if (if(max(combo_fnamecount, combo_lnamecount, combo_addrcount, combo_hphonecount, combo_ssncount, combo_dobcount) = NULL, NULL, sum(if(combo_fnamecount = NULL, 0, combo_fnamecount), if(combo_lnamecount = NULL, 0, combo_lnamecount), if(combo_addrcount = NULL, 0, combo_addrcount), if(combo_hphonecount = NULL, 0, combo_hphonecount), if(combo_ssncount = NULL, 0, combo_ssncount), if(combo_dobcount = NULL, 0, combo_dobcount))) / num_els_popd >= 0, truncate(if(max(combo_fnamecount, combo_lnamecount, combo_addrcount, combo_hphonecount, combo_ssncount, combo_dobcount) = NULL, NULL, sum(if(combo_fnamecount = NULL, 0, combo_fnamecount), if(combo_lnamecount = NULL, 0, combo_lnamecount), if(combo_addrcount = NULL, 0, combo_addrcount), if(combo_hphonecount = NULL, 0, combo_hphonecount), if(combo_ssncount = NULL, 0, combo_ssncount), if(combo_dobcount = NULL, 0, combo_dobcount))) / num_els_popd), roundup(if(max(combo_fnamecount, combo_lnamecount, combo_addrcount, combo_hphonecount, combo_ssncount, combo_dobcount) = NULL, NULL, sum(if(combo_fnamecount = NULL, 0, combo_fnamecount), if(combo_lnamecount = NULL, 0, combo_lnamecount), if(combo_addrcount = NULL, 0, combo_addrcount), if(combo_hphonecount = NULL, 0, combo_hphonecount), if(combo_ssncount = NULL, 0, combo_ssncount), if(combo_dobcount = NULL, 0, combo_dobcount))) / num_els_popd));

		did1_ele_verd_lvl := map(
				combo_count_avg >= 4 => 4,
				combo_count_avg >= 3 => 3,
				combo_count_avg >= 2 => 2,
																1);

		did1_ele_verd_lvl1 := map(
				did1_ele_verd_lvl = 1 => 0.1084070796,
				did1_ele_verd_lvl = 2 => 0.1037747602,
				did1_ele_verd_lvl = 3 => 0.1001719122,
																 0.093147931);

		subpop0_log := -12.27999364 +
				did1_els_verd_lvl0 * -2.759061623 +
				did1_criminal_lvl0 * 3.4656540807 +
				did1_impulse_lvl0 * 3.8691355172 +
				did1_eviction_lvl0 * 1.9476296065 +
				did1_bk_lvl0 * 7.7170956836 +
				did1_derog_ratio_lvl0 * 1.0748586164 +
				did1_ids_per_addr_lvl0 * 4.793774036 +
				did1_ssns_per_adl_lvl0 * 3.8552161235 +
				did1_email_lvl0 * 2.2389029039 +
				did1_inq_lvl0 * 2.4828161692 +
				did1_econcode_lvl0 * 9.0699041197 +
				did1_wealth_index_lvl0 * 3.8694698044 +
				liens_cj_lvl0 * 4.0089644331 +
				liens_ot_lvl0 * 6.0628248095 +
				liens_sc_lvl0 * 4.2841014102 +
				did1_age_lvl0 * 4.2596149206 +
				did1_vermod * 0.0634247082 +
				(integer)did1_mw_sourced_f * 0.3562257554 +
				did1_naprop_mod * 0.0192537602 +
				did1_phnprob_mod * 0.0303500953 +
				did1_ssnmod * 0.0223735539 +
				(integer)did1_header_not_seen_recent_f * -0.213621644 +
				(integer)did1_lnames_per_adl_c6_f * 0.2028996189 +
				(integer)did1_adls_per_ssn_f * 0.3819605815 +
				liens_ft_lvl * 0.7616545451 +
				(integer)did1_recent_purchase_f * -0.308897801;

		subpop1_log := -11.31762067 +
				did1_criminal_lvl1 * 4.1688241933 +
				did1_impulse_lvl1 * 4.0722514611 +
				did1_bk_lvl1 * 7.1398502237 +
				did1_derog_ratio_lvl1 * 0.9709701641 +
				did1_ids_per_addr_lvl1 * 8.8404760234 +
				did1_ssns_per_adl_lvl1 * 4.0842796304 +
				did1_inq_lvl1 * 5.0506147795 +
				did1_econcode_lvl1 * 10.040142229 +
				did1_wealth_index_lvl1 * 8.3734823496 +
				liens_cj_lvl1 * 5.2440528399 +
				liens_sc_lvl1 * 5.1436449496 +
				did1_age_lvl1 * 6.7354767359 +
				did1_attr_sold_purch_lvl1 * 9.4788083294 +
				did1_avg_addr_lres_lvl1 * -6.140338535 +
				did1_addr_prob_lvl1 * 6.5738734337 +
				did1_sl_source_ct1 * 3.4107146816 +
				did1_ele_verd_lvl1 * -8.909600682 +
				did1_vermod * 0.0533768965 +
				did1_phnprob_mod * 0.0452898697 +
				did1_ssnmod * 0.0331999763 +
				liens_ft_lvl * 0.6207881192;

		source_tot_ds := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

		source_tot_ba := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') > 0;

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

		lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

		source_tot_l2 := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') > 0;

		source_tot_li := (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') > 0;

		lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

		ssn_deceased := (real)rc_decsflag = 1 or (integer)source_tot_ds = 1;

		scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 90 <= combo_dobscore AND combo_dobscore <= 100 or (real)input_dob_match_level >= 7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid;

		_222 := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

		point := -40;

		base := 700;

		odds := 1;

		ba_sourced := (integer)indexw(ver_sources, 'BA', ',') > 0;

		phat := if(BA_Sourced, exp(subpop1_log) / (1 + exp(subpop1_log)), exp(subpop0_log) / (1 + exp(subpop0_log)));

		final_score := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

		rvr1104_2_0 := if(_222, 222, max(501, min(900, final_score)));


		#if(RVR_DEBUG)
			self.clam := le;
			self.truedid                         := truedid;
			self.in_state                        := in_state;
			self.out_unit_desig                  := out_unit_desig;
			self.out_sec_range                   := out_sec_range;
			self.out_addr_type                   := out_addr_type;
			self.nas_summary                     := nas_summary;
			self.nap_summary                     := nap_summary;
			self.rc_hriskphoneflag               := rc_hriskphoneflag;
			self.rc_hriskaddrflag                := rc_hriskaddrflag;
			self.rc_decsflag                     := rc_decsflag;
			self.rc_pwssnvalflag                 := rc_pwssnvalflag;
			self.rc_ssnlowissue                  := rc_ssnlowissue;
			self.rc_ssnstate                     := rc_ssnstate;
			self.rc_addrvalflag                  := rc_addrvalflag;
			self.rc_dwelltype                    := rc_dwelltype;
			self.rc_bansflag                     := rc_bansflag;
			self.rc_addrcommflag                 := rc_addrcommflag;
			self.combo_dobscore                  := combo_dobscore;
			self.combo_fnamecount                := combo_fnamecount;
			self.combo_lnamecount                := combo_lnamecount;
			self.combo_addrcount                 := combo_addrcount;
			self.combo_hphonecount               := combo_hphonecount;
			self.combo_ssncount                  := combo_ssncount;
			self.combo_dobcount                  := combo_dobcount;
			self.ver_sources                     := ver_sources;
			self.ver_sources_count               := ver_sources_count;
			self.fnamepop                        := fnamepop;
			self.lnamepop                        := lnamepop;
			self.addrpop                         := addrpop;
			self.ssnlength                       := ssnlength;
			self.dobpop                          := dobpop;
			self.hphnpop                         := hphnpop;
			self.age                             := age;
			self.add1_isbestmatch                := add1_isbestmatch;
			self.add1_advo_address_vacancy       := add1_advo_address_vacancy;
			self.add1_avm_assessed_total_value   := add1_avm_assessed_total_value;
			self.add1_avm_automated_valuation    := add1_avm_automated_valuation;
			self.add1_avm_med_fips               := add1_avm_med_fips;
			self.add1_avm_med_geo11              := add1_avm_med_geo11;
			self.add1_avm_med_geo12              := add1_avm_med_geo12;
			self.add1_applicant_owned            := add1_applicant_owned;
			self.add1_naprop                     := add1_naprop;
			self.add1_date_last_seen             := add1_date_last_seen;
			self.property_owned_total            := property_owned_total;
			self.property_sold_total             := property_sold_total;
			self.add2_addr_type                  := add2_addr_type;
			self.add2_avm_assessed_total_value   := add2_avm_assessed_total_value;
			self.add2_avm_automated_valuation    := add2_avm_automated_valuation;
			self.add2_avm_med_fips               := add2_avm_med_fips;
			self.add2_avm_med_geo11              := add2_avm_med_geo11;
			self.add2_avm_med_geo12              := add2_avm_med_geo12;
			self.avg_lres                        := avg_lres;
			self.max_lres                        := max_lres;
			self.addrs_prison_history            := addrs_prison_history;
			self.avg_mo_per_addr                 := avg_mo_per_addr;
			self.telcordia_type                  := telcordia_type;
			self.gong_did_first_seen             := gong_did_first_seen;
			self.gong_did_last_seen              := gong_did_last_seen;
			self.gong_did_first_ct               := gong_did_first_ct;
			self.gong_did_last_ct                := gong_did_last_ct;
			self.header_last_seen                := header_last_seen;
			self.ssns_per_adl                    := ssns_per_adl;
			self.adlperssn_count                 := adlperssn_count;
			self.adls_per_addr                   := adls_per_addr;
			self.ssns_per_addr                   := ssns_per_addr;
			self.ssns_per_adl_c6                 := ssns_per_adl_c6;
			self.lnames_per_adl_c6               := lnames_per_adl_c6;
			self.adls_per_ssn_c6                 := adls_per_ssn_c6;
			self.inq_collection_count12          := inq_collection_count12;
			self.inq_banking_count12             := inq_banking_count12;
			self.inq_highriskcredit_count12      := inq_highriskcredit_count12;
			self.inq_communications_count12      := inq_communications_count12;
			self.inq_perssn                      := inq_perssn;
			self.inq_peraddr                     := inq_peraddr;
			self.inq_perphone                    := inq_perphone;
			self.infutor_nap                     := infutor_nap;
			self.impulse_count                   := impulse_count;
			self.email_domain_free_count         := email_domain_free_count;
			self.email_source_list               := email_source_list;
			self.attr_date_last_purchase         := attr_date_last_purchase;
			self.attr_num_purchase60             := attr_num_purchase60;
			self.attr_num_sold60                 := attr_num_sold60;
			self.attr_total_number_derogs        := attr_total_number_derogs;
			self.attr_date_last_eviction         := attr_date_last_eviction;
			self.attr_num_nonderogs              := attr_num_nonderogs;
			self.bankrupt                        := bankrupt;
			self.disposition                     := disposition;
			self.filing_count                    := filing_count;
			self.bk_recent_count                 := bk_recent_count;
			self.bk_disposed_recent_count        := bk_disposed_recent_count;
			self.liens_recent_unreleased_count   := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct  := liens_historical_unreleased_ct;
			self.liens_unrel_cj_ct               := liens_unrel_cj_ct;
			self.liens_unrel_cj_last_seen        := liens_unrel_cj_last_seen;
			self.liens_unrel_cj_total_amount     := liens_unrel_cj_total_amount;
			self.liens_unrel_ft_first_seen       := liens_unrel_ft_first_seen;
			self.liens_unrel_ft_last_seen        := liens_unrel_ft_last_seen;
			self.liens_unrel_ot_ct               := liens_unrel_ot_ct;
			self.liens_rel_ot_ct                 := liens_rel_ot_ct;
			self.liens_unrel_sc_ct               := liens_unrel_sc_ct;
			self.liens_unrel_sc_last_seen        := liens_unrel_sc_last_seen;
			self.liens_unrel_sc_total_amount     := liens_unrel_sc_total_amount;
			self.liens_rel_sc_ct                 := liens_rel_sc_ct;
			self.criminal_count                  := criminal_count;
			self.criminal_last_date              := criminal_last_date;
			self.felony_count                    := felony_count;
			self.ams_age                         := ams_age;
			self.wealth_index                    := wealth_index;
			self.input_dob_age                   := input_dob_age;
			self.input_dob_match_level           := input_dob_match_level;
			self.inferred_age                    := inferred_age;
			self.reported_dob                    := reported_dob;
			self.estimated_income                := estimated_income;
			self.sysdate                         := sysdate;
			self.num_els_popd_1                  := num_els_popd_1;
			self.num_els_verd                    := num_els_verd;
			self.pct_els_verd                    := pct_els_verd;
			self.did1_els_verd_lvl               := did1_els_verd_lvl;
			self.did1_els_verd_lvl0              := did1_els_verd_lvl0;
			self._criminal_last_date             := _criminal_last_date;
			self.mos_criminal_last_seen          := mos_criminal_last_seen;
			self.did1_criminal_lvl               := did1_criminal_lvl;
			self.did1_criminal_lvl0              := did1_criminal_lvl0;
			self.did1_criminal_lvl1              := did1_criminal_lvl1;
			self.impulse_email                   := impulse_email;
			self.did1_impulse_lvl                := did1_impulse_lvl;
			self.did1_impulse_lvl0               := did1_impulse_lvl0;
			self.did1_impulse_lvl1               := did1_impulse_lvl1;
			self._attr_date_last_eviction        := _attr_date_last_eviction;
			self.mos_eviction_last_seen          := mos_eviction_last_seen;
			self.did1_eviction_lvl               := did1_eviction_lvl;
			self.did1_eviction_lvl0              := did1_eviction_lvl0;
			self.did1_bk_lvl                     := did1_bk_lvl;
			self.did1_bk_lvl1                    := did1_bk_lvl1;
			self.did1_bk_lvl0                    := did1_bk_lvl0;
			self.total_recs                      := total_recs;
			self.derog_ratio_c16                 := derog_ratio_c16;
			self.derog_ratio                     := derog_ratio;
			self.discharged_bk                   := discharged_bk;
			self.did1_derog_ratio_lvl            := did1_derog_ratio_lvl;
			self.did1_derog_ratio_lvl0           := did1_derog_ratio_lvl0;
			self.did1_derog_ratio_lvl1           := did1_derog_ratio_lvl1;
			self.add_apt                         := add_apt;
			self.ids_per_addr_max                := ids_per_addr_max;
			self.did1_ids_per_addr_lvl_c21       := did1_ids_per_addr_lvl_c21;
			self.did1_ids_per_addr_lvl_c22       := did1_ids_per_addr_lvl_c22;
			self.did1_ids_per_addr_lvl           := did1_ids_per_addr_lvl;
			self.did1_ids_per_addr_lvl0          := did1_ids_per_addr_lvl0;
			self.did1_ids_per_addr_lvl1          := did1_ids_per_addr_lvl1;
			self.did1_ssns_per_adl_lvl           := did1_ssns_per_adl_lvl;
			self.did1_ssns_per_adl_lvl0          := did1_ssns_per_adl_lvl0;
			self.did1_ssns_per_adl_lvl1          := did1_ssns_per_adl_lvl1;
			self.inq_coll                        := inq_coll;
			self.inq_banking                     := inq_banking;
			self.inq_highrisk                    := inq_highrisk;
			self.inq_comm                        := inq_comm;
			self._inq_perssn                     := _inq_perssn;
			self._inq_peraddr                    := _inq_peraddr;
			self._inq_perphone                   := _inq_perphone;
			self.inq_ele_sum                     := inq_ele_sum;
			self.did1_inq_lvl                    := did1_inq_lvl;
			self.did1_inq_lvl0                   := did1_inq_lvl0;
			self.did1_inq_lvl1                   := did1_inq_lvl1;
			self.did1_email_lvl                  := did1_email_lvl;
			self.did1_email_lvl0                 := did1_email_lvl0;
			self.aptflag1                        := aptflag1;
			self.aptflag2                        := aptflag2;
			self.econval1_c34                    := econval1_c34;
			self.econval1_c35                    := econval1_c35;
			self.econval1_1                      := econval1_1;
			self.econcode1_c37                   := econcode1_c37;
			self.econcode1_c38                   := econcode1_c38;
			self.econcode1                       := econcode1;
			self.econval2_c40                    := econval2_c40;
			self.econval2_c41                    := econval2_c41;
			self.econval2                        := econval2;
			self.econcode2_c43                   := econcode2_c43;
			self.econcode2_c44                   := econcode2_c44;
			self.econcode2                       := econcode2;
			self.did1_econcode_lvl               := did1_econcode_lvl;
			self.did1_econcode_lvl0              := did1_econcode_lvl0;
			self.did1_econcode_lvl1              := did1_econcode_lvl1;
			self.did1_wealth_index_lvl           := did1_wealth_index_lvl;
			self.did1_wealth_index_lvl0          := did1_wealth_index_lvl0;
			self.did1_wealth_index_lvl1          := did1_wealth_index_lvl1;
			self._liens_unrel_cj_last_seen       := _liens_unrel_cj_last_seen;
			self.mos_cj_unrel_last_seen          := mos_cj_unrel_last_seen;
			self.liens_cj_lvl                    := liens_cj_lvl;
			self.liens_cj_lvl0                   := liens_cj_lvl0;
			self.liens_cj_lvl1                   := liens_cj_lvl1;
			self.liens_ot_lvl                    := liens_ot_lvl;
			self.liens_ot_lvl0                   := liens_ot_lvl0;
			self._liens_unrel_sc_last_seen       := _liens_unrel_sc_last_seen;
			self.mos_sc_unrel_last_seen          := mos_sc_unrel_last_seen;
			self.liens_sc_lvl                    := liens_sc_lvl;
			self.liens_sc_lvl0                   := liens_sc_lvl0;
			self.liens_sc_lvl1                   := liens_sc_lvl1;
			self._reported_dob                   := _reported_dob;
			self.reported_age                    := reported_age;
			self.applicant_age                   := applicant_age;
			self.did1_age_lvl_c61                := did1_age_lvl_c61;
			self.did1_age_lvl_c62                := did1_age_lvl_c62;
			self.did1_age_lvl_c63                := did1_age_lvl_c63;
			self.did1_age_lvl_c64                := did1_age_lvl_c64;
			self.did1_age_lvl                    := did1_age_lvl;
			self.did1_age_lvl0                   := did1_age_lvl0;
			self.did1_age_lvl1                   := did1_age_lvl1;
			self.contrary_inf                    := contrary_inf;
			self.verfst_i                        := verfst_i;
			self.verlst_i                        := verlst_i;
			self.veradd_i                        := veradd_i;
			self.verfst_p                        := verfst_p;
			self.verlst_p                        := verlst_p;
			self.veradd_p                        := veradd_p;
			self.verphn_p                        := verphn_p;
			self.veradd_s                        := veradd_s;
			self.dob_verd                        := dob_verd;
			self.vermod_log                      := vermod_log;
			self.did1_vermod                     := did1_vermod;
			self.mw_sourced                      := mw_sourced;
			self.did1_mw_sourced_f               := did1_mw_sourced_f;
			self._add1_date_last_seen            := _add1_date_last_seen;
			self.mos_add1_date_last_seen         := mos_add1_date_last_seen;
			self.seen_recently                   := seen_recently;
			self.app_owned                       := app_owned;
			self.stolen_addr                     := stolen_addr;
			self.property_owner                  := property_owner;
			self.naprop_log                      := naprop_log;
			self.did1_naprop_mod                 := did1_naprop_mod;
			self._gong_did_first_seen            := _gong_did_first_seen;
			self._gong_did_last_seen             := _gong_did_last_seen;
			self.mos_since_gong_first_seen       := mos_since_gong_first_seen;
			self.mos_since_gong_last_seen        := mos_since_gong_last_seen;
			self.phn_last_seen_rec               := phn_last_seen_rec;
			self.phn_first_seen_rec              := phn_first_seen_rec;
			self.phn_disconnected                := phn_disconnected;
			self.phn_notpots                     := phn_notpots;
			self.phn_bad_counts                  := phn_bad_counts;
			self.phnmod_log                      := phnmod_log;
			self.did1_phnprob_mod                := did1_phnprob_mod;
			self.ssn_issued18                    := ssn_issued18;
			self.ssn_statediff                   := ssn_statediff;
			self.ssn_deceased_1                  := ssn_deceased_1;
			self.ssn_adl_prob                    := ssn_adl_prob;
			self._rc_ssnlowissue                 := _rc_ssnlowissue;
			self.yr_rc_ssnlowissue               := yr_rc_ssnlowissue;
			self.yr_reported_dob                 := yr_reported_dob;
			self.neg_age_at_low_issue_f          := neg_age_at_low_issue_f;
			self.ssnmod_log                      := ssnmod_log;
			self.did1_ssnmod                     := did1_ssnmod;
			self._header_last_seen               := _header_last_seen;
			self.mos_header_last_seen            := mos_header_last_seen;
			self.did1_header_not_seen_recent_f   := did1_header_not_seen_recent_f;
			self.did1_lnames_per_adl_c6_f        := did1_lnames_per_adl_c6_f;
			self.did1_adls_per_ssn_f             := did1_adls_per_ssn_f;
			self._liens_unrel_ft_first_seen      := _liens_unrel_ft_first_seen;
			self._liens_unrel_ft_last_seen       := _liens_unrel_ft_last_seen;
			self.mos_ft_unrel_first_seen         := mos_ft_unrel_first_seen;
			self.mos_ft_unrel_last_seen          := mos_ft_unrel_last_seen;
			self.liens_ft_lvl                    := liens_ft_lvl;
			self._attr_date_last_purchase        := _attr_date_last_purchase;
			self.mos_attr_date_last_purchase     := mos_attr_date_last_purchase;
			self.did1_recent_purchase_f          := did1_recent_purchase_f;
			self.did1_attr_sold_purch_lvl        := did1_attr_sold_purch_lvl;
			self.did1_attr_sold_purch_lvl1       := did1_attr_sold_purch_lvl1;
			self.did1_avg_addr_lres_lvl          := did1_avg_addr_lres_lvl;
			self.did1_avg_addr_lres_lvl1         := did1_avg_addr_lres_lvl1;
			self.add_highrisk                    := add_highrisk;
			self.add_inval                       := add_inval;
			self.vacant_addr                     := vacant_addr;
			self.prison_hist                     := prison_hist;
			self.did1_addr_prob_lvl              := did1_addr_prob_lvl;
			self.did1_addr_prob_lvl1             := did1_addr_prob_lvl1;
			self.sl_cnt                          := sl_cnt;
			self.did1_SL_source_ct               := did1_SL_source_ct;
			self.did1_sl_source_ct1              := did1_sl_source_ct1;
			self.num_els_popd                    := num_els_popd;
			self.combo_count_avg                 := combo_count_avg;
			self.did1_ele_verd_lvl               := did1_ele_verd_lvl;
			self.did1_ele_verd_lvl1              := did1_ele_verd_lvl1;
			self.subpop0_log                     := subpop0_log;
			self.subpop1_log                     := subpop1_log;
			self.source_tot_ds                   := source_tot_ds;
			self.source_tot_ba                   := source_tot_ba;
			self.bk_flag                         := bk_flag;
			self.lien_rec_unrel_flag             := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag            := lien_hist_unrel_flag;
			self.source_tot_l2                   := source_tot_l2;
			self.source_tot_li                   := source_tot_li;
			self.lien_flag                       := lien_flag;
			self.ssn_deceased                    := ssn_deceased;
			self.scored_222s                     := scored_222s;
			self._222                            := _222;
			self.point                           := point;
			self.base                            := base;
			self.odds                            := odds;
			self.ba_sourced                      := ba_sourced;
			self.phat                            := phat;
			self.final_score                     := final_score;
			self.rvr1104_2_0                     := rvr1104_2_0;
		#end

		self.seq := le.seq;
		self.score := if( ri.score in ['101','102','103','104' /*fcra*/, '200' /*deceased*/, '222' /*prescreen*/, '100' /*incalif*/ ], ri.score, (string3)rvr1104_2_0 );
		self.ri := ri.ri; // needs more ri
		
	end;
	
	// model := project( clam, doModel(left) );
	model := join( clam, rvg4, left.seq=right.seq, doModel(left,right), keep(1) );
	return model;
end;