import ut, riskwise, riskwisefcra, risk_indicators, std, riskview;

export RVT1104_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia, boolean xmlPreScreenOptOut ) := FUNCTION

	RVT_DEBUG := false;

	#if(RVT_DEBUG)
		layout_debug := record
			risk_indicators.Layout_Boca_Shell clam;
			Boolean trueDID;
			String in_state;
			String out_unit_desig;
			String out_sec_range;
			String out_addr_type;
			String in_dob;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String NAP_Type;
			String rc_hriskphoneflag;
			String rc_hphonetypeflag;
			String rc_phonevalflag;
			String rc_hphonevalflag;
			String rc_decsflag;
			String rc_ssndobflag;
			String rc_pwssndobflag;
			String rc_ssnvalflag;
			String rc_pwssnvalflag;
			Integer rc_ssnlowissue;
			String rc_ssnstate;
			String rc_dwelltype;
			String rc_bansflag;
			String rc_hrisksic;
			String rc_phonetype;
			Integer combo_dobscore;
			qstring100 ver_sources;
			String ssnlength;
			Boolean dobpop;
			Integer age;
			Boolean add1_isbestmatch;
			String add1_advo_college;
			String add1_avm_sales_price;
			String add1_avm_assessed_total_value;
			Integer add1_avm_automated_valuation;
			Integer add1_avm_med_fips;
			Integer add1_avm_med_geo11;
			Integer add1_avm_med_geo12;
			Boolean add1_applicant_owned;
			Boolean add1_occupant_owned;
			Boolean add1_family_owned;
			Integer add1_naprop;
			Integer add1_mortgage_date;
			String add1_mortgage_type;
			String add1_mortgage_due_date;
			Integer add1_market_total_value;
			Integer add1_assessed_total_value;
			String add1_land_use_code;
			String add1_parking_no_of_cars;
			Integer property_owned_total;
			Integer property_sold_total;
			Integer property_sold_assessed_total;
			Integer property_sold_assessed_count;
			String add2_addr_type;
			String add2_advo_college;
			String add2_avm_assessed_total_value;
			Integer add2_avm_automated_valuation;
			Integer add2_avm_med_fips;
			Integer add2_avm_med_geo11;
			Integer add2_avm_med_geo12;
			Boolean add2_applicant_owned;
			Boolean add2_occupant_owned;
			Boolean add2_family_owned;
			Boolean addr_hist_advo_college;
			String telcordia_type;
			Integer recent_disconnects;
			String gong_did_first_seen;
			String gong_did_last_seen;
			Integer gong_did_first_ct;
			Integer gong_did_last_ct;
			Integer ssns_per_adl;
			Integer phones_per_adl;
			Integer adlPerSSN_count;
			Integer addrs_per_ssn;
			Integer adls_per_addr;
			Integer ssns_per_addr;
			Integer phones_per_addr;
			Integer adls_per_phone;
			Integer ssns_per_adl_c6;
			Integer phones_per_adl_c6;
			Integer adls_per_ssn_c6;
			Integer addrs_per_ssn_c6;
			Integer adls_per_phone_c6;
			Integer pl_addrs_per_adl;
			Integer inq_collection_count12;
			Integer inq_auto_count12;
			Integer inq_banking_count12;
			Integer inq_highriskcredit_count12;
			Integer inq_communications_count12;
			Integer inq_perssn;
			Integer inq_peraddr;
			Integer inq_perphone;
			Integer paw_first_seen;
			Integer paw_business_count;
			Integer paw_dead_business_count;
			Integer paw_active_phone_count;
			Integer infutor_nap;
			Integer impulse_count;
			Integer email_domain_edu_count;
			qstring50 email_source_list;
			Integer attr_num_purchase60;
			Integer attr_num_sold60;
			Integer attr_num_aircraft;
			Integer attr_total_number_derogs;
			Integer attr_eviction_count;
			Integer attr_eviction_count12;
			Integer attr_eviction_count36;
			Integer attr_num_nonderogs;
			Boolean Bankrupt;
			String disposition;
			Integer filing_count;
			Integer bk_recent_count;
			Integer liens_recent_unreleased_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_recent_released_count;
			Integer liens_historical_released_count;
			Integer criminal_count;
			Integer criminal_last_date;
			Integer felony_count;
			Integer watercraft_count;
			String ams_age;
			String ams_college_code;
			String ams_college_tier;
			Boolean prof_license_flag;
			String prof_license_category;
			String wealth_index;
			String input_dob_age;
			String input_dob_match_level;
			Integer inferred_age;
			Integer reported_dob;
			Integer estimated_income;
			Integer archive_date;
			Integer sysdate;
			Integer did0_nap_ver_lvl;
			Real did0_nap_ver_lvl_m;
			Boolean phn_disconnected_1;
			Boolean phn_business_1;
			Boolean phn_cellpager;
			Integer did0_phn_prob_lvl;
			Real did0_phn_prob_lvl_m;
			Integer did0_naprop_lvl;
			Real did0_naprop_lvl_m;
			Integer did0_addrs_per_ssn_lvl;
			Real did0_addrs_per_ssn_lvl_m;
			Boolean add_apt;
			Integer did0_ssns_per_addr_lvl;
			Real did0_ssns_per_addr_lvl_m;
			Integer did0_phones_per_addr_lvl;
			Real did0_phones_per_addr_lvl_m;
			Integer _in_dob;
			Integer calcd_age;
			Integer did0_age_risk_lvl;
			Real did0_age_risk_lvl_m;
			Integer did0_no_of_parking_lvl;
			Real did0_no_of_parking_lvl_m;
			Boolean did0_inq_flag;
			Boolean did0_low_income_flag;
			Integer did0_add1_assessed_tot_value_c;
			Integer med_value;
			Real income_home_ratio_1;
			Real income_home_ratio2;
			Real did0_income_home_ratio_c;
			Boolean pl_source;
			Integer did1_prof_license_lvl;
			Real did1_prof_license_lvl_m;
			Boolean inq_coll;
			Boolean inq_auto;
			Boolean inq_banking;
			Boolean inq_highrisk;
			Boolean inq_comm;
			Integer inquiry_sum;
			Boolean _inq_perssn;
			Boolean _inq_peraddr;
			Boolean _inq_perphone;
			Integer did1_inq_lvl;
			Real did1_inq_lvl_m;
			Integer _criminal_last_date;
			Integer mos_criminal_last_seen;
			Integer did1_criminal_lvl;
			Real did1_criminal_lvl_m;
			Integer did1_eviction_lvl;
			Real did1_eviction_lvl_m;
			Integer did1_bk_lvl;
			Real did1_bk_lvl_m;
			Integer total_recs;
			Integer derog_ratio_c30;
			Integer derog_ratio;
			Integer did1_derog_ratio_lvl;
			Real did1_derog_ratio_lvl_m;
			Integer did1_wealth_index_lvl_c34;
			Integer did1_wealth_index_lvl_c35;
			Integer did1_wealth_index_lvl;
			Real did1_wealth_index_lvl_m;
			String curr_addr_lvl;
			String prev_addr_lvl;
			Integer did1_curr_prev_addr_lvl;
			Real did1_curr_prev_addr_lvl_m;
			Boolean aptflag1;
			Boolean aptflag2;
			Integer econval1_c42;
			Integer econval1_c43;
			Integer econval1_1;
			String econcode1_c45;
			String econcode1_c46;
			String econcode1;
			Integer econval2_c48;
			Integer econval2_c49;
			Integer econval2;
			String econcode2_c51;
			String econcode2_c52;
			String econcode2;
			Integer did1_econcode_lvl;
			Real did1_econcode_lvl_m;
			Integer did1_college_lvl;
			Real did1_college_lvl_m;
			Integer did1_ssns_per_adl_lvl;
			Real did1_ssns_per_adl_lvl_m;
			Integer did1_phones_per_adl_lvl;
			Real did1_phones_per_adl_lvl_m;
			Integer did1_adls_per_ssn_lvl;
			Real did1_adls_per_ssn_lvl_m;
			Integer ids_per_addr_max;
			Integer did1_ids_per_addr_lvl_c64;
			Integer did1_ids_per_addr_lvl_c65;
			Integer did1_ids_per_addr_lvl;
			Real did1_ids_per_addr_lvl_m;
			Integer did1_phones_per_addr_lvl_c68;
			Integer did1_phones_per_addr_lvl_c69;
			Integer did1_phones_per_addr_lvl;
			Real did1_phones_per_addr_lvl_m;
			Integer did1_adls_per_addr_lvl;
			Real did1_adls_per_addr_lvl_m;
			Integer _paw_first_seen;
			Integer mos_paw_first_seen;
			Integer did1_paw_lvl;
			Real did1_paw_lvl_m;
			Integer liens_unr_lvl;
			Integer liens_rel_lvl;
			Boolean lien_sourced;
			Integer did1_lien_combo_lvl;
			Real did1_lien_combo_lvl_m;
			Integer did1_property_owned_lvl;
			Real did1_property_owned_lvl_m;
			Integer did1_sold_purchase_lvl;
			Real did1_sold_purchase_lvl_m;
			Integer _reported_dob;
			Integer reported_age;
			Integer applicant_age;
			Integer did1_age_lvl_c84;
			Integer did1_age_lvl_c85;
			Integer did1_age_lvl;
			Real did1_age_lvl_m;
			Boolean verfst_i;
			Boolean verlst_i;
			Boolean veradd_i;
			Boolean contrary_phn;
			Boolean verlst_p;
			Boolean veradd_p;
			Boolean verphn_p;
			Boolean contrary_ssn;
			Boolean verlst_s;
			Boolean veradd_s;
			Boolean verssn_s;
			Boolean nas_479;
			Boolean dob_verd;
			Real vermod_log;
			Real did1_vermod;
			Boolean ssn_issued18;
			Boolean ssn_statediff;
			Boolean ssn_adl_prob;
			Boolean ssn_adl_prob2;
			Integer _rc_ssnlowissue;
			Integer yr_rc_ssnlowissue;
			Real yr_reported_dob;
			Boolean neg_age_at_low_issue_f;
			Boolean non_us_ssn_state;
			Real ssnmod_log;
			Real did1_ssnmod;
			Boolean did1_rec_vehx_f;
			Real income_home_ratio;
			Real did1_income_home_ratio_c;
			Real did1_income_home_ratio_lg;
			Integer _gong_did_first_seen;
			Integer _gong_did_last_seen;
			Integer mos_since_gong_first_seen;
			Integer mos_since_gong_last_seen;
			Boolean phn_last_seen_rec;
			Boolean phn_first_seen_rec;
			Boolean phn_disconnected;
			Boolean phn_inval;
			Boolean phn_nonus;
			Boolean phn_notpots;
			Boolean phn_bad_counts;
			Real phnmod_log;
			Real did1_phnprob_mod;
			Boolean Impulse_Email;
			Boolean did1_impulse_f;
			Integer did1_add1_assessed_total_val_c;
			Integer did1_add1_avm_sales_price_c;
			Real did1_add1_avm_sales_price_lg;
			Integer did1_add1_market_total_value_c;
			Real did1_add1_market_total_value_lg;
			Integer _add1_mortgage_date;
			Integer _add1_mortgage_due_date;
			Integer mtg_term;
			Integer _mtg_term;
			Boolean mtg_15;
			Boolean mtg_25;
			Boolean mtg_30;
			Boolean mtg_40;
			Boolean mtg_typ_va;
			Boolean mtg_typ_fha;
			Real mtgmod_log;
			Real did1_mtgmod;
			Real avg_sold_assess_amt;
			Real did1_avg_sold_assess_amt_c;
			Real did1_avg_sold_assess_amt_lg;
			Boolean did1_stolen_addr;
			Real did0_log;
			Real ff_did1_log;
			Real phat;
			Integer point;
			Integer Base;
			Real odds;
			Integer sprint_ff_log;
			Integer sprint_ff_score;
			Boolean ssndead;
			Boolean ssnprior;
			Boolean ssninval;
			Boolean prisonflag;
			Integer override_1;
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
			Integer override;
			Integer _rvt1104_1_0;
			Boolean ov_criminal_flag;
			Boolean ov_impulse;
			Integer RVT1104_1_0;
			Models.Layout_ModelOut
		end;
		layout_debug doModel( clam le ) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel( clam le ) := TRANSFORM
	#end


		truedid                          := le.truedid;
		in_state                         := le.shell_input.in_state;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		nap_type                         := le.iid.nap_type;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_ssnvalflag                    := le.iid.socsvalflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
		rc_ssnstate                      := le.iid.soclstate;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_hrisksic                      := le.iid.hrisksic;
		rc_phonetype                     := le.iid.phonetype;
		combo_dobscore                   := le.iid.combo_dobscore;
		ver_sources                      := le.header_summary.ver_sources;
		ssnlength                        := le.input_validation.ssn_length;
		dobpop                           := le.input_validation.dateofbirth;
		age                              := le.name_verification.age;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_advo_college                := le.advo_input_addr.college_indicator;
		add1_avm_sales_price             := le.avm.input_address_information.avm_sales_price;
		add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		add1_mortgage_due_date           := le.address_verification.input_address_information.first_td_due_date;
		add1_market_total_value          := le.address_verification.input_address_information.assessed_amount;
		add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
		add1_land_use_code               := le.address_verification.input_address_information.standardized_land_use_code;
		add1_parking_no_of_cars          := (string)le.address_verification.input_address_information.parking_no_of_cars;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
		property_sold_assessed_count     := le.address_verification.sold.property_owned_assessed_count;
		add2_addr_type                   := le.address_verification.addr_type2;
		add2_advo_college                := le.advo_addr_hist1.college_indicator;
		add2_avm_assessed_total_value    := le.avm.address_history_1.avm_assessed_total_value;
		add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
		add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
		add2_avm_med_geo11               := le.avm.address_history_1.avm_median_geo11_level;
		add2_avm_med_geo12               := le.avm.address_history_1.avm_median_geo12_level;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		addr_hist_advo_college           := le.address_history_summary.address_history_advo_college_hit;
		telcordia_type                   := le.phone_verification.telcordia_type;
		recent_disconnects               := le.phone_verification.recent_disconnects;
		gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
		gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
		gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
		adls_per_ssn_c6                  := le.velocity_counters.adls_per_ssn_created_6months;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
		pl_addrs_per_adl                 := le.velocity_counters.pl_addrs_per_adl;
		inq_collection_count12           := le.acc_logs.collection.count12;
		inq_auto_count12                 := le.acc_logs.auto.count12;
		inq_banking_count12              := le.acc_logs.banking.count12;
		inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
		inq_communications_count12       := le.acc_logs.communications.count12;
		inq_perssn                       := le.acc_logs.inquiryperssn;
		inq_peraddr                      := le.acc_logs.inquiryperaddr;
		inq_perphone                     := le.acc_logs.inquiryperphone;
		paw_first_seen                   := le.employment.first_seen_date;
		paw_business_count               := le.employment.business_ct;
		paw_dead_business_count          := le.employment.dead_business_ct;
		paw_active_phone_count           := le.employment.business_active_phone_ct;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		email_domain_edu_count           := le.email_summary.email_domain_edu_ct;
		email_source_list                := le.email_summary.email_source_list;
		attr_num_purchase60              := le.other_address_info.num_purchase60;
		attr_num_sold60                  := le.other_address_info.num_sold60;
		attr_num_aircraft                := le.aircraft.aircraft_count;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_eviction_count12            := le.bjl.eviction_count12;
		attr_eviction_count36            := le.bjl.eviction_count36;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_recent_released_count      := le.bjl.liens_recent_released_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		felony_count                     := le.bjl.felony_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		ams_age                          := le.student.age;
		ams_college_code                 := le.student.college_code;
		ams_college_tier                 := le.student.college_tier;
		prof_license_flag                := le.professional_license.professional_license_flag;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_age                    := le.shell_input.age;
		input_dob_match_level            := le.dobmatchlevel;
		inferred_age                     := le.inferred_age;
		reported_dob                     := le.reported_dob;
		estimated_income                 := le.estimated_income;
		archive_date                     := if( le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate );





		NULL := -999999999;


		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


		BOOLEAN indexw(string source, string target, string delim) :=
			(source = target) OR
			(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
			(source[1..length(target)+1] = target + delim) OR
			(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);


		INTEGER year(integer sas_date) :=
			if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

		sysdate := models.common.sas_date((string)(archive_date));

		did0_nap_ver_lvl := map(
				nap_type = 'P' and (nap_summary in [9, 10, 11, 12])       => 3,
				nap_type = 'P' and (nap_summary in [0, 1, 2, 3, 4, 5, 6]) => 0,
				(nap_type in ['P', ' '])                                  => 2,
																																		 1);

		did0_nap_ver_lvl_m := map(
				did0_nap_ver_lvl = 0 => 0.5039539899,
				did0_nap_ver_lvl = 1 => 0.4800498753,
				did0_nap_ver_lvl = 2 => 0.4257602862,
																0.3383233533);

		phn_disconnected_1 := rc_hriskphoneflag = (string)5;

		phn_business_1 := rc_hphonevalflag = (string)1;

		phn_cellpager := (rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']);

		did0_phn_prob_lvl := map(
				phn_disconnected_1 or phn_business_1 or recent_disconnects > 0 => 2,
				phn_cellpager                                                  => 1,
																																					0);

		did0_phn_prob_lvl_m := map(
				did0_phn_prob_lvl = 0 => 0.3789795028,
				did0_phn_prob_lvl = 1 => 0.4712717883,
																 0.5396700707);

		did0_naprop_lvl := map(
				add1_naprop = 4         => 2,
				(add1_naprop in [2, 3]) => 1,
																	 0);

		did0_naprop_lvl_m := map(
				did0_naprop_lvl = 0 => 0.5142510612,
				did0_naprop_lvl = 1 => 0.3302639656,
															 0.2765957447);

		did0_addrs_per_ssn_lvl := map(
				addrs_per_ssn_c6 > 1 => 2,
				addrs_per_ssn = 1    => 0,
				addrs_per_ssn < 4    => 1,
																2);

		did0_addrs_per_ssn_lvl_m := map(
				did0_addrs_per_ssn_lvl = 0 => 0.3451720311,
				did0_addrs_per_ssn_lvl = 1 => 0.4647133758,
																			0.5224913495);

		add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

		did0_ssns_per_addr_lvl := map(
				(ssns_per_addr in [3, 4]) and not(add_apt)          => 0,
				(ssns_per_addr in [2, 5, 6, 7, 8]) and not(add_apt) => 1,
				ssns_per_addr < 15 and not(add_apt)                 => 2,
				not(add_apt)                                        => 3,
																															 4);

		did0_ssns_per_addr_lvl_m := map(
				did0_ssns_per_addr_lvl = 0 => 0.3049450549,
				did0_ssns_per_addr_lvl = 1 => 0.3707224335,
				did0_ssns_per_addr_lvl = 2 => 0.4210950081,
				did0_ssns_per_addr_lvl = 3 => 0.5060422961,
																			0.5225066196);

		did0_phones_per_addr_lvl := map(
				phones_per_addr = 1 => 0,
				phones_per_addr = 0 => 1,
															 min(if(phones_per_addr = NULL, -NULL, phones_per_addr), 4));

		did0_phones_per_addr_lvl_m := map(
				did0_phones_per_addr_lvl = 0 => 0.3971291866,
				did0_phones_per_addr_lvl = 1 => 0.404233871,
				did0_phones_per_addr_lvl = 2 => 0.5048951049,
				did0_phones_per_addr_lvl = 3 => 0.5381944444,
																				0.5554202192);

		_in_dob := models.common.sas_date((string)(in_dob));

		calcd_age := if(min(sysdate, _in_dob) = NULL, NULL, truncate((sysdate - _in_dob) / 365.25));

		did0_age_risk_lvl := map(
				calcd_age <= 20 or calcd_age >= 62 => 0,
				calcd_age <= 25                    => 4,
				calcd_age <= 30                    => 3,
				calcd_age <= 35                    => 2,
																							1);

		did0_age_risk_lvl_m := map(
				did0_age_risk_lvl = 0 => 0.4071183266,
				did0_age_risk_lvl = 1 => 0.4547368421,
				did0_age_risk_lvl = 2 => 0.5142857143,
				did0_age_risk_lvl = 3 => 0.5322939866,
																 0.540960452);

		did0_no_of_parking_lvl := min((unsigned)add1_parking_no_of_cars, 2);

		did0_no_of_parking_lvl_m := map(
				did0_no_of_parking_lvl = 0 => 0.4766760133,
				did0_no_of_parking_lvl = 1 => 0.3923444976,
																			0.3255813953);

		did0_inq_flag := inq_perSSN > 0 or inq_perAddr > 0 or inq_perPhone > 0;

		did0_low_income_flag := (estimated_income in [20000, 0]);

		did0_add1_assessed_tot_value_c := min(if(max((integer)add1_assessed_total_value, 0) = NULL, -NULL, max((integer)add1_assessed_total_value, 0)), 1000000 );

		med_value := map(
				add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
				add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
				add1_avm_med_fips > 0  => add1_avm_med_fips,
																	-1);

		income_home_ratio_1 := map(
				med_value > 0        => round(100 * estimated_income / med_value/.1)*.1,
				estimated_income = 0 => -2,
																-1);

		income_home_ratio2 := map(
				income_home_ratio_1 = -1 => 5,
				income_home_ratio_1 = -2 => 120,
																		income_home_ratio_1);

		did0_income_home_ratio_c := abs(15 - income_home_ratio2);

		pl_source := (integer)contains_i(stringlib.stringtouppercase(ver_sources), 'PL') > 0;

		did1_prof_license_lvl := map(
				(prof_license_category in ['3', '4', '5'])             => 2,
				prof_license_flag or pl_source or pl_addrs_per_adl > 0 => 1,
																																	0);

		did1_prof_license_lvl_m := map(
				did1_prof_license_lvl = 0 => 0.3096646351,
				did1_prof_license_lvl = 1 => 0.2243035543,
																		 0.0848794063);

		inq_coll := inq_collection_count12 > 0;

		inq_auto := inq_auto_count12 > 0;

		inq_banking := inq_banking_count12 > 0;

		inq_highrisk := inq_highriskcredit_count12 > 0;

		inq_comm := inq_communications_count12 > 0;

		inquiry_sum := if(max((integer)inq_coll, (integer)inq_auto, (integer)inq_banking, (integer)inq_highrisk, (integer)inq_comm) = NULL, NULL, sum((integer)inq_coll, (integer)inq_auto, (integer)inq_banking, (integer)inq_highrisk, (integer)inq_comm));

		_inq_perssn := inq_perSSN > 0;

		_inq_peraddr := inq_perAddr > 0;

		_inq_perphone := inq_perPhone > 0;

		did1_inq_lvl := map(
				inq_highrisk or inq_banking     => 4,
				inq_coll or inq_comm            => 3,
				inquiry_sum > 0 or _inq_peraddr => 2,
				_inq_perssn or _inq_perphone    => 1,
																					 0);

		did1_inq_lvl_m := map(
				did1_inq_lvl = 0 => 0.2760978551,
				did1_inq_lvl = 1 => 0.3744769874,
				did1_inq_lvl = 2 => 0.4753588517,
				did1_inq_lvl = 3 => 0.496124031,
														0.607523863);

		_criminal_last_date := models.common.sas_date((string)(criminal_last_date));

		mos_criminal_last_seen := if(min(sysdate, _criminal_last_date) = NULL, NULL, truncate((sysdate - _criminal_last_date) / (365.25 / 12)));

		did1_criminal_lvl := map(
				0 <= mos_criminal_last_seen AND mos_criminal_last_seen <= 6 or criminal_count > 2 or felony_count > 0 => 3,
				criminal_count > 1                                                                                    => 2,
				criminal_count > 0                                                                                    => 1,
																																																								 0);

		did1_criminal_lvl_m := map(
				did1_criminal_lvl = 0 => 0.285650835,
				did1_criminal_lvl = 1 => 0.5160583942,
				did1_criminal_lvl = 2 => 0.5161290323,
																 0.6964169381);

		did1_eviction_lvl := map(
				attr_eviction_count12 > 1                               => 4,
				attr_eviction_count36 > 3                               => 3,
				attr_eviction_count36 > 1 and attr_eviction_count12 > 0 => 3,
				attr_eviction_count36 > 1 or attr_eviction_count12 > 0  => 2,
				attr_eviction_count > 0                                 => 1,
																																	 0);

		did1_eviction_lvl_m := map(
				did1_eviction_lvl = 0 => 0.2745982088,
				did1_eviction_lvl = 1 => 0.5651662254,
				did1_eviction_lvl = 2 => 0.6201201201,
				did1_eviction_lvl = 3 => 0.6655290102,
																 0.6935483871);

		did1_bk_lvl := map(
				(string)stringlib.stringtouppercase(disposition) = 'DISMISSED' => 2,
				bankrupt                                  => 1,
																										 0);

		did1_bk_lvl_m := map(
				did1_bk_lvl = 0 => 0.2999097763,
				did1_bk_lvl = 1 => 0.2715303259,
													 0.4939467312);

		total_recs := if(max(attr_num_nonderogs, attr_total_number_derogs) = NULL, NULL, sum(if(attr_num_nonderogs = NULL, 0, attr_num_nonderogs), if(attr_total_number_derogs = NULL, 0, attr_total_number_derogs)));

		derog_ratio_c30 := if(attr_total_number_derogs = 0, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 10) * 10 + 100, if (attr_total_number_derogs * 100 / total_recs / 10 >= 0, roundup(attr_total_number_derogs * 100 / total_recs / 10), truncate(attr_total_number_derogs * 100 / total_recs / 10)) * 10);

		derog_ratio := if(total_recs > 0, derog_ratio_c30, 100);

		did1_derog_ratio_lvl := map(
				derog_ratio >= 170                  => 0,
				derog_ratio >= 160                  => 1,
				derog_ratio >= 150                  => 2,
				derog_ratio >= 130                  => 3,
				(derog_ratio in [10, 20, 110, 120]) => 4,
				derog_ratio <= 030                  => 5,
				derog_ratio <= 040                  => 6,
				derog_ratio <= 050                  => 7,
				derog_ratio <= 060                  => 8,
				derog_ratio <= 070                  => 9,
																							 10);

		did1_derog_ratio_lvl_m := map(
				did1_derog_ratio_lvl = 0 => 0.0572649573,
				did1_derog_ratio_lvl = 1 => 0.0851745117,
				did1_derog_ratio_lvl = 2 => 0.1322529301,
				did1_derog_ratio_lvl = 3 => 0.2302794813,
				did1_derog_ratio_lvl = 4 => 0.3285654712,
				did1_derog_ratio_lvl = 5 => 0.4262536873,
				did1_derog_ratio_lvl = 6 => 0.4786557675,
				did1_derog_ratio_lvl = 7 => 0.5338956576,
				did1_derog_ratio_lvl = 8 => 0.5432811212,
				did1_derog_ratio_lvl = 9 => 0.6044330776,
																		0.651187905);

		did1_wealth_index_lvl_c34 := map(
				estimated_income >= 40000 => 4,
				estimated_income >= 35000 => 3,
				estimated_income >= 30000 => 2,
				estimated_income > 0      => 1,
																		 0);

		did1_wealth_index_lvl_c35 := if(wealth_index >= (string)2, (unsigned1)wealth_index, 0);

		did1_wealth_index_lvl := if(wealth_index = (string)0, did1_wealth_index_lvl_c34, did1_wealth_index_lvl_c35);

		did1_wealth_index_lvl_m := map(
				did1_wealth_index_lvl = 0 => 0.5544444444,
				did1_wealth_index_lvl = 1 => 0.3997934773,
				did1_wealth_index_lvl = 2 => 0.3435485471,
				did1_wealth_index_lvl = 3 => 0.2528744158,
				did1_wealth_index_lvl = 4 => 0.1637859461,
				did1_wealth_index_lvl = 5 => 0.0739314594,
																		 0.0580235721);

		curr_addr_lvl := map(
				add1_applicant_owned => 'APP',
				add1_family_owned    => 'FAM',
				add1_occupant_owned  => 'OCC',
																'OTH');

		prev_addr_lvl := map(
				add2_applicant_owned => 'APP',
				add2_family_owned    => 'FAM',
				add2_occupant_owned  => 'OCC',
																'OTH');

		did1_curr_prev_addr_lvl := map(
				curr_addr_lvl = 'APP' and (prev_addr_lvl in ['APP', 'FAM']) => 5,
				curr_addr_lvl = 'APP' and (prev_addr_lvl in ['OCC', 'OTH']) => 4,
				curr_addr_lvl = 'FAM' and (prev_addr_lvl in ['APP', 'FAM']) => 4,
				curr_addr_lvl = 'FAM' and (prev_addr_lvl in ['OCC', 'OTH']) => 3,
				prev_addr_lvl = 'APP' and (curr_addr_lvl in ['OCC', 'OTH']) => 3,
				prev_addr_lvl = 'FAM' and (curr_addr_lvl in ['OCC', 'OTH']) => 2,
				curr_addr_lvl = 'OCC' and (prev_addr_lvl in ['OCC', 'OTH']) => 1,
																																			 0);

		did1_curr_prev_addr_lvl_m := map(
				did1_curr_prev_addr_lvl = 0 => 0.4224561143,
				did1_curr_prev_addr_lvl = 1 => 0.3895128185,
				did1_curr_prev_addr_lvl = 2 => 0.2727272727,
				did1_curr_prev_addr_lvl = 3 => 0.2285421709,
				did1_curr_prev_addr_lvl = 4 => 0.0928830848,
																			 0.0573725055);

		aptflag1 := (rc_dwelltype in ['A', 'H']);

		aptflag2 := (add2_addr_type in ['A', 'H']);

		econval1_c42 := map(
				add1_avm_automated_valuation > 0           => (integer)add1_avm_automated_valuation,
				(integer)add1_avm_assessed_total_value > 0 => (integer)add1_avm_assessed_total_value,
				add1_avm_med_geo12 > 0                     => add1_avm_med_geo12,
				add1_avm_med_geo11 > 0                     => add1_avm_med_geo11,
				add1_avm_med_fips > 0                      => add1_avm_med_fips,
																										 -1);

		econval1_c43 := map(
				add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
				add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
				add1_avm_med_fips > 0  => add1_avm_med_fips,
																	-1);

		econval1_1 := if(not(aptflag1), econval1_c42, econval1_c43);

		econcode1_c45 := map(
				econval1_1 > 650000 => 'A',
				econval1_1 > 450000 => 'B',
				econval1_1 > 250000 => 'C',
				econval1_1 > 125000 => 'D',
				econval1_1 > 75000  => 'E',
				econval1_1 > 0      => 'F',
															 'U');

		econcode1_c46 := map(
				econval1_1 > 1000000 => 'C',
				econval1_1 > 500000  => 'D',
				econval1_1 > 175000  => 'E',
				econval1_1 > 0       => 'F',
																'U');

		econcode1 := if(not(aptflag1), econcode1_c45, econcode1_c46);

		econval2_c48 := map(
				add2_avm_automated_valuation > 0          => add2_avm_automated_valuation,
				add2_avm_assessed_total_value > (string)0 => NULL,
				add2_avm_med_geo12 > 0                    => add2_avm_med_geo12,
				add2_avm_med_geo11 > 0                    => add2_avm_med_geo11,
				add2_avm_med_fips > 0                     => add2_avm_med_fips,
																										 -1);

		econval2_c49 := map(
				add2_avm_med_geo12 > 0 => add2_avm_med_geo12,
				add2_avm_med_geo11 > 0 => add2_avm_med_geo11,
				add2_avm_med_fips > 0  => add2_avm_med_fips,
																	-1);

		econval2 := if(not(aptflag2), econval2_c48, econval2_c49);

		econcode2_c51 := map(
				econval2 > 650000 => 'A',
				econval2 > 450000 => 'B',
				econval2 > 250000 => 'C',
				econval2 > 125000 => 'D',
				econval2 > 75000  => 'E',
				econval2 > 0      => 'F',
														 'U');

		econcode2_c52 := map(
				econval2 > 1000000 => 'C',
				econval2 > 500000  => 'D',
				econval2 > 175000  => 'E',
				econval2 > 0       => 'F',
															'U');

		econcode2 := if(not(aptflag2), econcode2_c51, econcode2_c52);

		did1_econcode_lvl := map(
				(econcode1 in ['A', 'B', 'C', 'U']) and (econcode2 in ['A']) => 9,
				(econcode1 in ['A']) and (econcode2 in ['U'])                => 9,
				(econcode1 in ['A']) and (econcode2 in ['B', 'C', 'D'])      => 8,
				(econcode1 in ['B']) and (econcode2 in ['U'])                => 8,
				(econcode1 in ['D']) and (econcode2 in ['A'])                => 8,
				(econcode1 in ['U']) and (econcode2 in ['B'])                => 8,
				(econcode1 in ['B']) and (econcode2 in ['B', 'C', 'D'])      => 7,
				(econcode1 in ['B', 'C', 'D']) and (econcode2 in ['B'])      => 7,
				(econcode1 in ['A', 'B']) and (econcode2 in ['E', 'F'])      => 6,
				(econcode1 in ['C']) and (econcode2 in ['C', 'D', 'U'])      => 6,
				(econcode1 in ['U']) and (econcode2 in ['C'])                => 6,
				(econcode1 in ['C']) and (econcode2 in ['E', 'F'])           => 5,
				(econcode1 in ['D']) and (econcode2 in ['C', 'D', 'E', 'U']) => 5,
				(econcode1 in ['E']) and (econcode2 in ['A', 'B', 'C'])      => 5,
				(econcode1 in ['D']) and (econcode2 in ['F'])                => 4,
				(econcode1 in ['E']) and (econcode2 in ['D', 'E', 'U'])      => 4,
				(econcode1 in ['F']) and (econcode2 in ['A', 'B', 'C'])      => 4,
				(econcode1 in ['U']) and (econcode2 in ['D'])                => 4,
				(econcode1 in ['E']) and (econcode2 in ['F'])                => 3,
				(econcode1 in ['F']) and (econcode2 in ['D'])                => 3,
				(econcode1 in ['U']) and (econcode2 in ['E'])                => 3,
				(econcode1 in ['F']) and (econcode2 in ['E', 'U'])           => 2,
				(econcode1 in ['U']) and (econcode2 in ['F'])                => 2,
				(econcode1 in ['U']) and (econcode2 in ['U'])                => 1,
				(econcode1 in ['F']) and (econcode2 in ['F'])                => 0,
																																				-1);

		did1_econcode_lvl_m := map(
				did1_econcode_lvl = 0 => 0.484236812,
				did1_econcode_lvl = 1 => 0.4184679958,
				did1_econcode_lvl = 2 => 0.3981452859,
				did1_econcode_lvl = 3 => 0.3417636826,
				did1_econcode_lvl = 4 => 0.2830378727,
				did1_econcode_lvl = 5 => 0.2101296025,
				did1_econcode_lvl = 6 => 0.1712978651,
				did1_econcode_lvl = 7 => 0.1297709924,
				did1_econcode_lvl = 8 => 0.1097826087,
																 0.1102941176);

		did1_college_lvl := map(
				(ams_college_tier in ['1', '2', '3'])                                                                                                                                                                   => 3,
				ams_college_code = (string)4                                                                                                                                                                            => 2,
				ams_college_code > (string)0 or (string)add1_advo_college = 'Y' or (string)add2_advo_college = 'Y' or email_domain_EDU_count > 0 or (ams_college_tier in ['0', '5', '6']) or addr_hist_advo_college     => 1,
																																																																																																									 0);

		did1_college_lvl_m := map(
				did1_college_lvl = 0 => 0.3211586303,
				did1_college_lvl = 1 => 0.2181616833,
				did1_college_lvl = 2 => 0.1102564103,
																0.0512152778);

		did1_ssns_per_adl_lvl := map(
				ssns_per_adl > 5                         => 6,
				ssns_per_adl > 4                         => 5,
				ssns_per_adl > 3 and ssns_per_adl_c6 > 1 => 5,
				ssns_per_adl > 3                         => 4,
				ssns_per_adl > 2 and ssns_per_adl_c6 > 1 => 4,
				ssns_per_adl > 2                         => 3,
				ssns_per_adl > 1 and ssns_per_adl_c6 > 1 => 3,
				ssns_per_adl = 2                         => 2,
				ssns_per_adl_c6 > 0                      => 1,
				ssns_per_adl = 1                         => 0,
																										3);

		did1_ssns_per_adl_lvl_m := map(
				did1_ssns_per_adl_lvl = 0 => 0.2701062665,
				did1_ssns_per_adl_lvl = 1 => 0.2856558006,
				did1_ssns_per_adl_lvl = 2 => 0.340610998,
				did1_ssns_per_adl_lvl = 3 => 0.4251824818,
				did1_ssns_per_adl_lvl = 4 => 0.4850746269,
				did1_ssns_per_adl_lvl = 5 => 0.5847750865,
																		 0.7105263158);

		did1_phones_per_adl_lvl := map(
				phones_per_adl > 2 and phones_per_adl_c6 > 0 => 4,
				phones_per_adl > 1 and phones_per_adl_c6 > 1 => 4,
				phones_per_adl > 2 or phones_per_adl_c6 > 0  => 3,
				phones_per_adl = 0                           => 2,
				phones_per_adl = 2                           => 1,
																												0);

		did1_phones_per_adl_lvl_m := map(
				did1_phones_per_adl_lvl = 0 => 0.2228012001,
				did1_phones_per_adl_lvl = 1 => 0.2472952087,
				did1_phones_per_adl_lvl = 2 => 0.3104639311,
				did1_phones_per_adl_lvl = 3 => 0.4187164264,
																			 0.5522788204);

		did1_adls_per_ssn_lvl := map(
				adlperssn_count = 0 or adlperssn_count > 2 or adls_per_ssn_c6 > 0 => 2,
				adlperssn_count = 2                                               => 1,
																																						 0);

		did1_adls_per_ssn_lvl_m := map(
				did1_adls_per_ssn_lvl = 0 => 0.2763134382,
				did1_adls_per_ssn_lvl = 1 => 0.3165110852,
																		 0.3894230769);

		ids_per_addr_max := max(adls_per_addr, ssns_per_addr);

		did1_ids_per_addr_lvl_c64 := map(
				ids_per_addr_max = 2                             => 0,
				ids_per_addr_max = 3                             => 1,
				ids_per_addr_max = 4                             => 2,
				ids_per_addr_max = 5                             => 3,
				5 < ids_per_addr_max AND ids_per_addr_max <= 10  => 4,
				0 < ids_per_addr_max AND ids_per_addr_max <= 15  => 5,
				15 < ids_per_addr_max AND ids_per_addr_max <= 20 => 6,
				20 < ids_per_addr_max AND ids_per_addr_max <= 25 => 7,
				25 < ids_per_addr_max AND ids_per_addr_max <= 45 => 8,
																														9);

		did1_ids_per_addr_lvl_c65 := map(
				(ids_per_addr_max in [2, 3]) => 5,
				(ids_per_addr_max in [0, 1]) => 6,
				ids_per_addr_max <= 20       => 7,
				ids_per_addr_max <= 30       => 8,
																				9);

		did1_ids_per_addr_lvl := if(not(add_apt), did1_ids_per_addr_lvl_c64, did1_ids_per_addr_lvl_c65);

		did1_ids_per_addr_lvl_m := map(
				did1_ids_per_addr_lvl = 0 => 0.1299781182,
				did1_ids_per_addr_lvl = 1 => 0.1728194726,
				did1_ids_per_addr_lvl = 2 => 0.1773770492,
				did1_ids_per_addr_lvl = 3 => 0.1950015427,
				did1_ids_per_addr_lvl = 4 => 0.2376194067,
				did1_ids_per_addr_lvl = 5 => 0.3052070521,
				did1_ids_per_addr_lvl = 6 => 0.348502238,
				did1_ids_per_addr_lvl = 7 => 0.3900267142,
				did1_ids_per_addr_lvl = 8 => 0.4200814762,
																		 0.4398395722);

		did1_phones_per_addr_lvl_c68 := map(
				phones_per_addr = 1 => 0,
				phones_per_addr = 0 => 1,
				phones_per_addr = 2 => 3,
				phones_per_addr = 3 => 4,
															 5);

		did1_phones_per_addr_lvl_c69 := map(
				(phones_per_addr in [2, 3]) => 2,
				phones_per_addr > 10        => 2,
																			 3);

		did1_phones_per_addr_lvl := if(not(add_apt), did1_phones_per_addr_lvl_c68, did1_phones_per_addr_lvl_c69);

		did1_phones_per_addr_lvl_m := map(
				did1_phones_per_addr_lvl = 0 => 0.252409192,
				did1_phones_per_addr_lvl = 1 => 0.2715712175,
				did1_phones_per_addr_lvl = 2 => 0.3401583402,
				did1_phones_per_addr_lvl = 3 => 0.3754930318,
				did1_phones_per_addr_lvl = 4 => 0.506993007,
																				0.5405405405);

		did1_adls_per_addr_lvl := map(
				(adls_per_phone in [1, 2]) and adls_per_phone_c6 = 0 => 0,
				adls_per_phone > 1 and adls_per_phone_c6 > 1         => 0,
				adls_per_phone > 1 and adls_per_phone_c6 = 1         => 2,
																																0);

		did1_adls_per_addr_lvl_m := map(
				did1_adls_per_addr_lvl = 0 => 0.2979019974,
																			0.4334389857);

		_paw_first_seen := models.common.sas_date((string)(PAW_first_seen));

		mos_paw_first_seen := if(min(sysdate, _paw_first_seen) = NULL, NULL, truncate((sysdate - _paw_first_seen) / (365.25 / 12)));

		did1_paw_lvl := map(
				paw_business_count > 0 and paw_active_phone_count > 0 and paw_dead_business_count = 0 => 5,
				mos_paw_first_seen >= 96                                                              => 4,
				paw_business_count > 2                                                                => 3,
				paw_business_count > 1                                                                => 2,
				paw_business_count > 0                                                                => 1,
																																																 0);

		did1_paw_lvl_m := map(
				did1_paw_lvl = 0 => 0.3151098051,
				did1_paw_lvl = 1 => 0.1688140073,
				did1_paw_lvl = 2 => 0.1533101045,
				did1_paw_lvl = 3 => 0.1358024691,
				did1_paw_lvl = 4 => 0.0903790087,
														0.061281337);

		liens_unr_lvl := map(
				liens_historical_unreleased_ct > 3 and liens_recent_unreleased_count > 0 => 4,
				liens_historical_unreleased_ct > 2 and liens_recent_unreleased_count > 1 => 4,
				liens_historical_unreleased_ct > 1 and liens_recent_unreleased_count > 2 => 4,
				liens_recent_unreleased_count > 3                                        => 4,
				liens_historical_unreleased_ct > 2                                       => 3,
				liens_historical_unreleased_ct > 1 and liens_recent_unreleased_count > 0 => 3,
				liens_recent_unreleased_count > 1                                        => 3,
				liens_historical_unreleased_ct > 1 and liens_recent_unreleased_count = 0 => 2,
				liens_historical_unreleased_ct > 0 and liens_recent_unreleased_count > 0 => 2,
				liens_historical_unreleased_ct > 0 or liens_recent_unreleased_count > 0  => 1,
																																										0);

		liens_rel_lvl := map(
				liens_historical_released_count > 1                                     => 2,
				liens_historical_released_count > 0 and liens_recent_released_count > 0 => 2,
				liens_historical_released_count > 0 or liens_recent_released_count > 0  => 1,
																																									 0);

		lien_sourced := (integer)contains_i(ver_sources, 'L2') > 0 or (integer)contains_i(ver_sources, 'LI') > 0;

		did1_lien_combo_lvl := map(
				liens_unr_lvl = 0 and liens_rel_lvl = 0 and not(lien_sourced) => 0,
				liens_unr_lvl = 0 and liens_rel_lvl = 0                       => 1,
				liens_unr_lvl < 2 and liens_rel_lvl = 1                       => 1,
				liens_unr_lvl = 2 and liens_rel_lvl = 1                       => 2,
				liens_unr_lvl < 4 and liens_rel_lvl = 2                       => 2,
				liens_unr_lvl = 1 and liens_rel_lvl = 0                       => 3,
				liens_unr_lvl = 3 and liens_rel_lvl = 1                       => 3,
				liens_unr_lvl = 2 and liens_rel_lvl = 0                       => 4,
				liens_unr_lvl = 4 and liens_rel_lvl = 2                       => 4,
				liens_unr_lvl = 3 and liens_rel_lvl = 0                       => 5,
				liens_unr_lvl = 4 and liens_rel_lvl = 1                       => 5,
																																				 6);

		did1_lien_combo_lvl_m := map(
				did1_lien_combo_lvl = 0 => 0.2458578507,
				did1_lien_combo_lvl = 1 => 0.3462811106,
				did1_lien_combo_lvl = 2 => 0.4133219471,
				did1_lien_combo_lvl = 3 => 0.4742737137,
				did1_lien_combo_lvl = 4 => 0.5249136655,
				did1_lien_combo_lvl = 5 => 0.5590379009,
																	 0.6488812392);

		did1_property_owned_lvl := min(if(property_owned_total = NULL, -NULL, property_owned_total), 3);

		did1_property_owned_lvl_m := map(
				did1_property_owned_lvl = 0 => 0.3750496386,
				did1_property_owned_lvl = 1 => 0.1294968848,
				did1_property_owned_lvl = 2 => 0.0859905907,
																			 0.0731988473);

		did1_sold_purchase_lvl := map(
				attr_num_purchase60 > 1 and attr_num_sold60 < 2 => 3,
				attr_num_purchase60 > 0                         => 2,
				attr_num_sold60 > 0                             => 1,
																													 0);

		did1_sold_purchase_lvl_m := map(
				did1_sold_purchase_lvl = 0 => 0.3370505542,
				did1_sold_purchase_lvl = 1 => 0.1757925072,
				did1_sold_purchase_lvl = 2 => 0.1069815908,
																			0.0779320988);

		_reported_dob := models.common.sas_date((string)(reported_dob));

		reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

		applicant_age := map(
				(integer)input_dob_age > 0 => (integer)input_dob_age,
				inferred_age > 0           => inferred_age,
				reported_age > 0           => reported_age,
				(integer)ams_age > 0       => (integer)ams_age,
																		 -1);

		did1_age_lvl_c84 := map(
				applicant_age > 55 => 6,
				applicant_age > 45 => 5,
				applicant_age > 35 => 4,
				applicant_age > 25 => 3,
				applicant_age > 18 => 2,
				applicant_age > -1 => 1,
															2);

		did1_age_lvl_c85 := map(
				applicant_age > 55 => 6,
				applicant_age > 35 => 5,
				applicant_age > 25 => 2,
				applicant_age > 18 => 1,
				applicant_age > -1 => 0,
															2);

		did1_age_lvl := map(
				input_dob_match_level = (string)8                         => did1_age_lvl_c84,
				input_dob_match_level = (string)0                         => did1_age_lvl_c85,
				applicant_age = -1                                        => 2,
				applicant_age <= 45 and input_dob_match_level = (string)1 => 0,
																																		 1);

		did1_age_lvl_m := map(
				did1_age_lvl = 0 => 0.4543209877,
				did1_age_lvl = 1 => 0.3792903972,
				did1_age_lvl = 2 => 0.3261611126,
				did1_age_lvl = 3 => 0.2856751011,
				did1_age_lvl = 4 => 0.2675518528,
				did1_age_lvl = 5 => 0.2345655119,
														0.1955151964);

		verfst_i := (infutor_nap in [2, 3, 4, 8, 9, 10, 12]);

		verlst_i := (infutor_nap in [2, 5, 7, 8, 9, 11, 12]);

		veradd_i := (infutor_nap in [3, 5, 6, 8, 10, 11, 12]);

		contrary_phn := (nap_summary in [1]);

		verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

		veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

		verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

		contrary_ssn := (nas_summary in [1]);

		verlst_s := (nas_summary in [2, 5, 7, 8, 9, 11, 12]);

		veradd_s := (nas_summary in [3, 5, 6, 8, 10, 11, 12]);

		verssn_s := (nas_summary in [4, 6, 7, 9, 10, 11, 12]);

		nas_479 := (nas_summary in [4, 7, 9]);

		dob_verd := dobpop and input_dob_match_level = (string)8 and combo_dobscore = 100;

		vermod_log := 0.4441 +
				(integer)verfst_i * -0.6676 +
				(integer)verlst_i * -1.0085 +
				(integer)verfst_i * (integer)verlst_i * 0.2962 +
				(integer)veradd_i * 0.1815 +
				(integer)contrary_phn * 0.5390 +
				(integer)verlst_i * (integer)contrary_phn * 1.3778 +
				(integer)verlst_p * 0.4027 +
				(integer)veradd_p * 0.3918 +
				(integer)veradd_i * (integer)veradd_p * 0.4962 +
				(integer)verphn_p * 0.2910 +
				(integer)verfst_i * (integer)verphn_p * 0.4585 +
				(integer)verlst_i * (integer)verphn_p * 1.2271 +
				(integer)veradd_i * (integer)verphn_p * -0.0106 +
				(integer)verlst_p * (integer)verphn_p * -0.4987 +
				(integer)veradd_p * (integer)verphn_p * -0.6165 +
				(integer)contrary_ssn * -0.9868 +
				(integer)verlst_s * -0.1252 +
				(integer)verlst_p * (integer)verlst_s * -0.5921 +
				(integer)veradd_s * -0.0867 +
				(integer)verphn_p * (integer)veradd_s * -0.1288 +
				(integer)verssn_s * -0.1697 +
				(integer)veradd_s * (integer)verssn_s * -0.5317 +
				(integer)add1_isbestmatch * -0.6437 +
				(integer)nas_479 * (integer)add1_isbestmatch * 0.4328 +
				(integer)dob_verd * -0.1700 +
				(integer)verlst_p * (integer)dob_verd * -0.1422;

		did1_vermod := round(100 * exp(vermod_log) / (1 + exp(vermod_log))/.1)*.1;

		ssn_issued18 := rc_pwssnvalflag = (string)5;

		ssn_statediff := StringLib.StringToUpperCase(trim(rc_ssnstate, LEFT, RIGHT)) != StringLib.StringToUpperCase(trim(in_state, LEFT, RIGHT));

		ssn_adl_prob := ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2;

		ssn_adl_prob2 := ssns_per_adl = 0 or ssns_per_adl + ssns_per_adl_c6 >= 4;

		_rc_ssnlowissue := models.common.sas_date((string)(rc_ssnlowissue));

		yr_rc_ssnlowissue := year(_rc_ssnlowissue);

		yr_reported_dob := map(
				(string)reported_dob != '0' => (real)((string)reported_dob)[1..4],
				age > 0                     => year(sysdate) - age,
				inferred_age > 0            => year(sysdate) - inferred_age,
																			 NULL);

		// neg_age_at_low_issue_f := NULL < yr_rc_ssnlowissue - yr_reported_dob AND yr_rc_ssnlowissue - yr_reported_dob <= 0;
		neg_age_at_low_issue_f := yr_rc_ssnlowissue!=NULL and yr_reported_dob!=NULL AND yr_rc_ssnlowissue - yr_reported_dob <= 0;

		non_us_ssn_state := (rc_ssnstate in ['PR', 'VI', 'PW', 'MP', 'MH', 'GU', 'FM', 'AS']);

		ssnmod_log := -0.9532 +
				(integer)ssn_issued18 * -0.3094 +
				(integer)ssn_statediff * -0.1818 +
				(integer)ssn_adl_prob * 0.7203 +
				(integer)ssn_issued18 * (integer)ssn_adl_prob * -0.2413 +
				(integer)ssn_adl_prob2 * 0.2355 +
				(integer)non_us_ssn_state * 0.8835 +
				(integer)ssn_issued18 * (integer)non_us_ssn_state * 0.8861 +
				(integer)ssn_statediff * (integer)non_us_ssn_state * -0.4125 +
				(integer)neg_age_at_low_issue_f * 0.5717 +
				(integer)ssn_adl_prob2 * (integer)neg_age_at_low_issue_f * -0.3966;

		did1_ssnmod := round(100 * exp(ssnmod_log) / (1 + exp(ssnmod_log))/.1)*.1;

		did1_rec_vehx_f := watercraft_count > 0 or attr_num_aircraft > 0;

		income_home_ratio := map(
				med_value > 0        => round(100 * estimated_income / med_value/.1)*.1,
				estimated_income = 0 => -2,
																-1);

		did1_income_home_ratio_c := map(
				(income_home_ratio in [-2, 0]) => 200,
				income_home_ratio = -1         => 70,
																					min(if(max(income_home_ratio, (real)1) = NULL, -NULL, max(income_home_ratio, (real)1)), 300));

		did1_income_home_ratio_lg := ln(did1_income_home_ratio_c);

		_gong_did_first_seen := models.common.sas_date((string)(gong_did_first_seen));

		_gong_did_last_seen := models.common.sas_date((string)(gong_did_last_seen));

		mos_since_gong_first_seen := if(min(sysdate, _gong_did_first_seen) = NULL, NULL, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)));

		mos_since_gong_last_seen := if(min(sysdate, _gong_did_last_seen) = NULL, NULL, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)));

		phn_last_seen_rec := mos_since_gong_last_seen = 0;

		phn_first_seen_rec := 0 <= mos_since_gong_first_seen AND mos_since_gong_first_seen <= 6;

		phn_disconnected := rc_hriskphoneflag = (string)5;

		phn_inval := rc_phonevalflag = (string)0 or rc_hphonevalflag = (string)0 or (rc_phonetype in ['5']);

		phn_nonus := (rc_phonetype in ['3', '4']);

		phn_notpots := not((telcordia_type in ['00', '50', '51', '52', '54']));

		phn_bad_counts := if(max(gong_did_first_ct, gong_did_last_ct) = NULL, NULL, sum(if(gong_did_first_ct = NULL, 0, gong_did_first_ct), if(gong_did_last_ct = NULL, 0, gong_did_last_ct))) >= 5 or gong_did_last_ct > 2;

		phnmod_log := -0.8151 +
				(integer)phn_last_seen_rec * -0.7231 +
				(integer)phn_first_seen_rec * 1.2020 +
				(integer)phn_disconnected * 0.3316 +
				(integer)phn_inval * 0.4399 +
				(integer)phn_nonus * 0.8817 +
				(integer)phn_notpots * -0.3177 +
				(integer)phn_cellpager * 0.4247 +
				(integer)phn_last_seen_rec * (integer)phn_cellpager * 0.2774 +
				(integer)phn_bad_counts * 1.1700;

		did1_phnprob_mod := round(100 * exp(phnmod_log) / (1 + exp(phnmod_log))/.1)*.1;

		impulse_email := (integer)contains_i(email_source_list, 'IM') > 0;

		did1_impulse_f := impulse_count > 0 or impulse_email;

		did1_add1_assessed_total_val_c := if(add1_assessed_total_value <= 0, 1, min(if(max((integer)add1_assessed_total_value, 1) = NULL, -NULL, max((integer)add1_assessed_total_value, 1)), 1000000));

		did1_add1_avm_sales_price_c := if(add1_avm_sales_price <= (string)0, 50000, min(if(max((integer)add1_avm_sales_price, 1) = NULL, -NULL, max((integer)add1_avm_sales_price, 1)), 1000000));

		did1_add1_avm_sales_price_lg := ln(did1_add1_avm_sales_price_c);

		did1_add1_market_total_value_c := if(add1_market_total_value <= 0, 75000, min(if(max((integer)add1_market_total_value, 1) = NULL, -NULL, max((integer)add1_market_total_value, 1)), 1000000));

		did1_add1_market_total_value_lg := ln(did1_add1_market_total_value_c);

		_add1_mortgage_date := models.common.sas_date((string)(add1_mortgage_date));

		_add1_mortgage_due_date := models.common.sas_date((string)(add1_mortgage_due_date));

		mtg_term := if(min(_add1_mortgage_due_date, _add1_mortgage_date) = NULL, NULL, truncate((_add1_mortgage_due_date - _add1_mortgage_date) / 365.25));

		_mtg_term := map(
				(mtg_term in [9, 10])  => 10,
				(mtg_term in [14, 15]) => 15,
				(mtg_term in [19, 20]) => 20,
				(mtg_term in [24, 25]) => 25,
				(mtg_term in [29, 30]) => 30,
				(mtg_term in [39, 40]) => 40,
				not(mtg_term = NULL)   => 0,
																	-1);

		mtg_15 := _mtg_term = 15;

		mtg_25 := _mtg_term = 25;

		mtg_30 := _mtg_term = 30;

		mtg_40 := _mtg_term = 40;

		mtg_typ_va := add1_mortgage_type = 'VA';

		mtg_typ_fha := add1_mortgage_type = 'FHA';

		mtgmod_log := -0.7409 +
				(integer)mtg_15 * -0.8846 +
				(integer)mtg_25 * -0.7887 +
				(integer)mtg_30 * -0.6646 +
				(integer)mtg_40 * -0.8832 +
				(integer)mtg_typ_va * -0.9285 +
				(integer)mtg_typ_fha * -0.2847;

		did1_mtgmod := round(100 * exp(mtgmod_log) / (1 + exp(mtgmod_log))/.1)*.1;

		avg_sold_assess_amt := if(property_sold_assessed_count > 0, property_sold_assessed_total / property_sold_assessed_count, NULL);

		did1_avg_sold_assess_amt_c := if(avg_sold_assess_amt = NULL, 1, min(if(max(avg_sold_assess_amt, (real)1) = NULL, -NULL, max(avg_sold_assess_amt, (real)1)), 1000000));

		did1_avg_sold_assess_amt_lg := ln(did1_avg_sold_assess_amt_c);

		did1_stolen_addr := (add1_naprop in [1, 2]);

		did0_log := -8.494381115 +
				did0_nap_ver_lvl_m * 2.6092775416 +
				did0_phn_prob_lvl_m * 3.0994106685 +
				did0_naprop_lvl_m * 2.122839095 +
				did0_addrs_per_ssn_lvl_m * 3.0521778362 +
				did0_ssns_per_addr_lvl_m * 1.9324657119 +
				did0_phones_per_addr_lvl_m * 1.1866076562 +
				did0_age_risk_lvl_m * 2.1556835691 +
				did0_no_of_parking_lvl_m * 1.96335706 +
				(integer)did0_inq_flag * 0.3196438893 +
				(integer)did0_low_income_flag * 0.285595619 +
				did0_add1_assessed_tot_value_c * -5.128328E-7 +
				did0_income_home_ratio_c * 0.0111979904;

		ff_did1_log := -12.96899237 +
				did1_prof_license_lvl_m * 3.1855671443 +
				did1_inq_lvl_m * 2.1498678637 +
				did1_criminal_lvl_m * 2.688495128 +
				did1_eviction_lvl_m * 0.4423859994 +
				did1_bk_lvl_m * 2.3803914634 +
				did1_derog_ratio_lvl_m * 0.0362768236 +
				did1_wealth_index_lvl_m * 0.8205930809 +
				did1_curr_prev_addr_lvl_m * 0.8211575579 +
				did1_econcode_lvl_m * 1.0661406396 +
				did1_college_lvl_m * 5.4976701765 +
				did1_ssns_per_adl_lvl_m * 1.5233157425 +
				did1_phones_per_adl_lvl_m * 1.6171242314 +
				did1_adls_per_ssn_lvl_m * 1.4217518507 +
				did1_ids_per_addr_lvl_m * 1.2838338638 +
				did1_phones_per_addr_lvl_m * 1.2050321255 +
				did1_adls_per_addr_lvl_m * 2.6403497807 +
				did1_paw_lvl_m * 2.0177368251 +
				did1_lien_combo_lvl_m * 2.6308525212 +
				did1_property_owned_lvl_m * 1.4401879282 +
				did1_sold_purchase_lvl_m * 0.9450343306 +
				did1_age_lvl_m * 0.9517830595 +
				did1_vermod * 0.0298772941 +
				did1_ssnmod * 0.0144989766 +
				(integer)did1_rec_vehx_f * -0.326422717 +
				did1_income_home_ratio_lg * 0.2145623312 +
				did1_phnprob_mod * 0.0120950788 +
				(integer)did1_impulse_f * 0.9105491351 +
				did1_add1_assessed_total_val_c * -2.71534E-7 +
				did1_add1_avm_sales_price_lg * -0.069790766 +
				did1_add1_market_total_value_lg * -0.105390165 +
				did1_mtgmod * 0.0094946263 +
				did1_avg_sold_assess_amt_lg * -0.030653358 +
				(integer)did1_stolen_addr * 0.1885520176;

		phat := if(not(truedid), exp(did0_log) / (1 + exp(did0_log)), exp(ff_did1_log) / (1 + exp(ff_did1_log)));

		point := -40;

		base := 700;

		odds := .29 / .71;

		sprint_ff_log := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

		sprint_ff_score := max(300, min(999, if(sprint_ff_log = NULL, -NULL, sprint_ff_log)));

		ssndead := ssnlength > (string)0 and rc_decsflag = (string)1;

		ssnprior := rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1;

		ssninval := rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3']);

		prisonflag := (add1_land_use_code in ['9218', '0609']) or rc_hriskphoneflag = (string)6 or rc_hphonetypeflag = '5' or rc_hrisksic = (string)2225;

		override_1 := map(
				(integer)ssndead = 1    => 202,
				(integer)ssnprior = 1   => 204,
				(integer)prisonflag = 1 => 203,
				(integer)ssninval = 1   => 201,
																	 -1);

		source_tot_ds := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'DS', ',') > 0;

		source_tot_ba := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'BA', ',') > 0;

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

		lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

		source_tot_l2 := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'L2', ',') > 0;

		source_tot_li := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'LI', ',') > 0;

		lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

		ssn_deceased := rc_decsflag = (string)1 or (integer)source_tot_ds = 1;

		scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid;

		override := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, override_1);

		_rvt1104_1_0 := if(override = -1, sprint_ff_score, override);

		ov_criminal_flag := criminal_count > 0;

		ov_impulse := impulse_count > 0;

		rvt1104_1_0 := map(
				_rvt1104_1_0 > 750 and ov_impulse       => 750,
				_rvt1104_1_0 > 790 and ov_criminal_flag => 790,
																									 _rvt1104_1_0);


		#if(RVT_DEBUG)
			self.clam := le;
			self.truedid                                       := truedid;
			self.in_state                                      := in_state;
			self.out_unit_desig                                := out_unit_desig;
			self.out_sec_range                                 := out_sec_range;
			self.out_addr_type                                 := out_addr_type;
			self.in_dob                                        := in_dob;
			self.nas_summary                                   := nas_summary;
			self.nap_summary                                   := nap_summary;
			self.nap_type                                      := nap_type;
			self.rc_hriskphoneflag                             := rc_hriskphoneflag;
			self.rc_hphonetypeflag                             := rc_hphonetypeflag;
			self.rc_phonevalflag                               := rc_phonevalflag;
			self.rc_hphonevalflag                              := rc_hphonevalflag;
			self.rc_decsflag                                   := rc_decsflag;
			self.rc_ssndobflag                                 := rc_ssndobflag;
			self.rc_pwssndobflag                               := rc_pwssndobflag;
			self.rc_ssnvalflag                                 := rc_ssnvalflag;
			self.rc_pwssnvalflag                               := rc_pwssnvalflag;
			self.rc_ssnlowissue                                := rc_ssnlowissue;
			self.rc_ssnstate                                   := rc_ssnstate;
			self.rc_dwelltype                                  := rc_dwelltype;
			self.rc_bansflag                                   := rc_bansflag;
			self.rc_hrisksic                                   := rc_hrisksic;
			self.rc_phonetype                                  := rc_phonetype;
			self.combo_dobscore                                := combo_dobscore;
			self.ver_sources                                   := ver_sources;
			self.ssnlength                                     := ssnlength;
			self.dobpop                                        := dobpop;
			self.age                                           := age;
			self.add1_isbestmatch                              := add1_isbestmatch;
			self.add1_advo_college                             := add1_advo_college;
			self.add1_avm_sales_price                          := add1_avm_sales_price;
			self.add1_avm_assessed_total_value                 := add1_avm_assessed_total_value;
			self.add1_avm_automated_valuation                  := add1_avm_automated_valuation;
			self.add1_avm_med_fips                             := add1_avm_med_fips;
			self.add1_avm_med_geo11                            := add1_avm_med_geo11;
			self.add1_avm_med_geo12                            := add1_avm_med_geo12;
			self.add1_applicant_owned                          := add1_applicant_owned;
			self.add1_occupant_owned                           := add1_occupant_owned;
			self.add1_family_owned                             := add1_family_owned;
			self.add1_naprop                                   := add1_naprop;
			self.add1_mortgage_date                            := add1_mortgage_date;
			self.add1_mortgage_type                            := add1_mortgage_type;
			self.add1_mortgage_due_date                        := add1_mortgage_due_date;
			self.add1_market_total_value                       := add1_market_total_value;
			self.add1_assessed_total_value                     := add1_assessed_total_value;
			self.add1_land_use_code                            := add1_land_use_code;
			self.add1_parking_no_of_cars                       := add1_parking_no_of_cars;
			self.property_owned_total                          := property_owned_total;
			self.property_sold_total                           := property_sold_total;
			self.property_sold_assessed_total                  := property_sold_assessed_total;
			self.property_sold_assessed_count                  := property_sold_assessed_count;
			self.add2_addr_type                                := add2_addr_type;
			self.add2_advo_college                             := add2_advo_college;
			self.add2_avm_assessed_total_value                 := add2_avm_assessed_total_value;
			self.add2_avm_automated_valuation                  := add2_avm_automated_valuation;
			self.add2_avm_med_fips                             := add2_avm_med_fips;
			self.add2_avm_med_geo11                            := add2_avm_med_geo11;
			self.add2_avm_med_geo12                            := add2_avm_med_geo12;
			self.add2_applicant_owned                          := add2_applicant_owned;
			self.add2_occupant_owned                           := add2_occupant_owned;
			self.add2_family_owned                             := add2_family_owned;
			self.addr_hist_advo_college                        := addr_hist_advo_college;
			self.telcordia_type                                := telcordia_type;
			self.recent_disconnects                            := recent_disconnects;
			self.gong_did_first_seen                           := gong_did_first_seen;
			self.gong_did_last_seen                            := gong_did_last_seen;
			self.gong_did_first_ct                             := gong_did_first_ct;
			self.gong_did_last_ct                              := gong_did_last_ct;
			self.ssns_per_adl                                  := ssns_per_adl;
			self.phones_per_adl                                := phones_per_adl;
			self.adlperssn_count                               := adlperssn_count;
			self.addrs_per_ssn                                 := addrs_per_ssn;
			self.adls_per_addr                                 := adls_per_addr;
			self.ssns_per_addr                                 := ssns_per_addr;
			self.phones_per_addr                               := phones_per_addr;
			self.adls_per_phone                                := adls_per_phone;
			self.ssns_per_adl_c6                               := ssns_per_adl_c6;
			self.phones_per_adl_c6                             := phones_per_adl_c6;
			self.adls_per_ssn_c6                               := adls_per_ssn_c6;
			self.addrs_per_ssn_c6                              := addrs_per_ssn_c6;
			self.adls_per_phone_c6                             := adls_per_phone_c6;
			self.pl_addrs_per_adl                              := pl_addrs_per_adl;
			self.inq_collection_count12                        := inq_collection_count12;
			self.inq_auto_count12                              := inq_auto_count12;
			self.inq_banking_count12                           := inq_banking_count12;
			self.inq_highriskcredit_count12                    := inq_highriskcredit_count12;
			self.inq_communications_count12                    := inq_communications_count12;
			self.inq_perssn                                    := inq_perssn;
			self.inq_peraddr                                   := inq_peraddr;
			self.inq_perphone                                  := inq_perphone;
			self.paw_first_seen                                := paw_first_seen;
			self.paw_business_count                            := paw_business_count;
			self.paw_dead_business_count                       := paw_dead_business_count;
			self.paw_active_phone_count                        := paw_active_phone_count;
			self.infutor_nap                                   := infutor_nap;
			self.impulse_count                                 := impulse_count;
			self.email_domain_edu_count                        := email_domain_edu_count;
			self.email_source_list                             := email_source_list;
			self.attr_num_purchase60                           := attr_num_purchase60;
			self.attr_num_sold60                               := attr_num_sold60;
			self.attr_num_aircraft                             := attr_num_aircraft;
			self.attr_total_number_derogs                      := attr_total_number_derogs;
			self.attr_eviction_count                           := attr_eviction_count;
			self.attr_eviction_count12                         := attr_eviction_count12;
			self.attr_eviction_count36                         := attr_eviction_count36;
			self.attr_num_nonderogs                            := attr_num_nonderogs;
			self.bankrupt                                      := bankrupt;
			self.disposition                                   := disposition;
			self.filing_count                                  := filing_count;
			self.bk_recent_count                               := bk_recent_count;
			self.liens_recent_unreleased_count                 := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct                := liens_historical_unreleased_ct;
			self.liens_recent_released_count                   := liens_recent_released_count;
			self.liens_historical_released_count               := liens_historical_released_count;
			self.criminal_count                                := criminal_count;
			self.criminal_last_date                            := criminal_last_date;
			self.felony_count                                  := felony_count;
			self.watercraft_count                              := watercraft_count;
			self.ams_age                                       := ams_age;
			self.ams_college_code                              := ams_college_code;
			self.ams_college_tier                              := ams_college_tier;
			self.prof_license_flag                             := prof_license_flag;
			self.prof_license_category                         := prof_license_category;
			self.wealth_index                                  := wealth_index;
			self.input_dob_age                                 := input_dob_age;
			self.input_dob_match_level                         := input_dob_match_level;
			self.inferred_age                                  := inferred_age;
			self.reported_dob                                  := reported_dob;
			self.estimated_income                              := estimated_income;
			self.archive_date                                  := archive_date;
			self.sysdate                                       := sysdate;
			self.did0_nap_ver_lvl                              := did0_nap_ver_lvl;
			self.did0_nap_ver_lvl_m                            := did0_nap_ver_lvl_m;
			self.phn_disconnected_1                            := phn_disconnected_1;
			self.phn_business_1                                := phn_business_1;
			self.phn_cellpager                                 := phn_cellpager;
			self.did0_phn_prob_lvl                             := did0_phn_prob_lvl;
			self.did0_phn_prob_lvl_m                           := did0_phn_prob_lvl_m;
			self.did0_naprop_lvl                               := did0_naprop_lvl;
			self.did0_naprop_lvl_m                             := did0_naprop_lvl_m;
			self.did0_addrs_per_ssn_lvl                        := did0_addrs_per_ssn_lvl;
			self.did0_addrs_per_ssn_lvl_m                      := did0_addrs_per_ssn_lvl_m;
			self.add_apt                                       := add_apt;
			self.did0_ssns_per_addr_lvl                        := did0_ssns_per_addr_lvl;
			self.did0_ssns_per_addr_lvl_m                      := did0_ssns_per_addr_lvl_m;
			self.did0_phones_per_addr_lvl                      := did0_phones_per_addr_lvl;
			self.did0_phones_per_addr_lvl_m                    := did0_phones_per_addr_lvl_m;
			self._in_dob                                       := _in_dob;
			self.calcd_age                                     := calcd_age;
			self.did0_age_risk_lvl                             := did0_age_risk_lvl;
			self.did0_age_risk_lvl_m                           := did0_age_risk_lvl_m;
			self.did0_no_of_parking_lvl                        := did0_no_of_parking_lvl;
			self.did0_no_of_parking_lvl_m                      := did0_no_of_parking_lvl_m;
			self.did0_inq_flag                                 := did0_inq_flag;
			self.did0_low_income_flag                          := did0_low_income_flag;
			self.did0_add1_assessed_tot_value_c                := did0_add1_assessed_tot_value_c;
			self.med_value                                     := med_value;
			self.income_home_ratio_1                           := income_home_ratio_1;
			self.income_home_ratio2                            := income_home_ratio2;
			self.did0_income_home_ratio_c                      := did0_income_home_ratio_c;
			self.pl_source                                     := pl_source;
			self.did1_prof_license_lvl                         := did1_prof_license_lvl;
			self.did1_prof_license_lvl_m                       := did1_prof_license_lvl_m;
			self.inq_coll                                      := inq_coll;
			self.inq_auto                                      := inq_auto;
			self.inq_banking                                   := inq_banking;
			self.inq_highrisk                                  := inq_highrisk;
			self.inq_comm                                      := inq_comm;
			self.inquiry_sum                                   := inquiry_sum;
			self._inq_perssn                                   := _inq_perssn;
			self._inq_peraddr                                  := _inq_peraddr;
			self._inq_perphone                                 := _inq_perphone;
			self.did1_inq_lvl                                  := did1_inq_lvl;
			self.did1_inq_lvl_m                                := did1_inq_lvl_m;
			self._criminal_last_date                           := _criminal_last_date;
			self.mos_criminal_last_seen                        := mos_criminal_last_seen;
			self.did1_criminal_lvl                             := did1_criminal_lvl;
			self.did1_criminal_lvl_m                           := did1_criminal_lvl_m;
			self.did1_eviction_lvl                             := did1_eviction_lvl;
			self.did1_eviction_lvl_m                           := did1_eviction_lvl_m;
			self.did1_bk_lvl                                   := did1_bk_lvl;
			self.did1_bk_lvl_m                                 := did1_bk_lvl_m;
			self.total_recs                                    := total_recs;
			self.derog_ratio_c30                               := derog_ratio_c30;
			self.derog_ratio                                   := derog_ratio;
			self.did1_derog_ratio_lvl                          := did1_derog_ratio_lvl;
			self.did1_derog_ratio_lvl_m                        := did1_derog_ratio_lvl_m;
			self.did1_wealth_index_lvl_c34                     := did1_wealth_index_lvl_c34;
			self.did1_wealth_index_lvl_c35                     := did1_wealth_index_lvl_c35;
			self.did1_wealth_index_lvl                         := did1_wealth_index_lvl;
			self.did1_wealth_index_lvl_m                       := did1_wealth_index_lvl_m;
			self.curr_addr_lvl                                 := curr_addr_lvl;
			self.prev_addr_lvl                                 := prev_addr_lvl;
			self.did1_curr_prev_addr_lvl                       := did1_curr_prev_addr_lvl;
			self.did1_curr_prev_addr_lvl_m                     := did1_curr_prev_addr_lvl_m;
			self.aptflag1                                      := aptflag1;
			self.aptflag2                                      := aptflag2;
			self.econval1_c42                                  := econval1_c42;
			self.econval1_c43                                  := econval1_c43;
			self.econval1_1                                    := econval1_1;
			self.econcode1_c45                                 := econcode1_c45;
			self.econcode1_c46                                 := econcode1_c46;
			self.econcode1                                     := econcode1;
			self.econval2_c48                                  := econval2_c48;
			self.econval2_c49                                  := econval2_c49;
			self.econval2                                      := econval2;
			self.econcode2_c51                                 := econcode2_c51;
			self.econcode2_c52                                 := econcode2_c52;
			self.econcode2                                     := econcode2;
			self.did1_econcode_lvl                             := did1_econcode_lvl;
			self.did1_econcode_lvl_m                           := did1_econcode_lvl_m;
			self.did1_college_lvl                              := did1_college_lvl;
			self.did1_college_lvl_m                            := did1_college_lvl_m;
			self.did1_ssns_per_adl_lvl                         := did1_ssns_per_adl_lvl;
			self.did1_ssns_per_adl_lvl_m                       := did1_ssns_per_adl_lvl_m;
			self.did1_phones_per_adl_lvl                       := did1_phones_per_adl_lvl;
			self.did1_phones_per_adl_lvl_m                     := did1_phones_per_adl_lvl_m;
			self.did1_adls_per_ssn_lvl                         := did1_adls_per_ssn_lvl;
			self.did1_adls_per_ssn_lvl_m                       := did1_adls_per_ssn_lvl_m;
			self.ids_per_addr_max                              := ids_per_addr_max;
			self.did1_ids_per_addr_lvl_c64                     := did1_ids_per_addr_lvl_c64;
			self.did1_ids_per_addr_lvl_c65                     := did1_ids_per_addr_lvl_c65;
			self.did1_ids_per_addr_lvl                         := did1_ids_per_addr_lvl;
			self.did1_ids_per_addr_lvl_m                       := did1_ids_per_addr_lvl_m;
			self.did1_phones_per_addr_lvl_c68                  := did1_phones_per_addr_lvl_c68;
			self.did1_phones_per_addr_lvl_c69                  := did1_phones_per_addr_lvl_c69;
			self.did1_phones_per_addr_lvl                      := did1_phones_per_addr_lvl;
			self.did1_phones_per_addr_lvl_m                    := did1_phones_per_addr_lvl_m;
			self.did1_adls_per_addr_lvl                        := did1_adls_per_addr_lvl;
			self.did1_adls_per_addr_lvl_m                      := did1_adls_per_addr_lvl_m;
			self._paw_first_seen                               := _paw_first_seen;
			self.mos_paw_first_seen                            := mos_paw_first_seen;
			self.did1_paw_lvl                                  := did1_paw_lvl;
			self.did1_paw_lvl_m                                := did1_paw_lvl_m;
			self.liens_unr_lvl                                 := liens_unr_lvl;
			self.liens_rel_lvl                                 := liens_rel_lvl;
			self.lien_sourced                                  := lien_sourced;
			self.did1_lien_combo_lvl                           := did1_lien_combo_lvl;
			self.did1_lien_combo_lvl_m                         := did1_lien_combo_lvl_m;
			self.did1_property_owned_lvl                       := did1_property_owned_lvl;
			self.did1_property_owned_lvl_m                     := did1_property_owned_lvl_m;
			self.did1_sold_purchase_lvl                        := did1_sold_purchase_lvl;
			self.did1_sold_purchase_lvl_m                      := did1_sold_purchase_lvl_m;
			self._reported_dob                                 := _reported_dob;
			self.reported_age                                  := reported_age;
			self.applicant_age                                 := applicant_age;
			self.did1_age_lvl_c84                              := did1_age_lvl_c84;
			self.did1_age_lvl_c85                              := did1_age_lvl_c85;
			self.did1_age_lvl                                  := did1_age_lvl;
			self.did1_age_lvl_m                                := did1_age_lvl_m;
			self.verfst_i                                      := verfst_i;
			self.verlst_i                                      := verlst_i;
			self.veradd_i                                      := veradd_i;
			self.contrary_phn                                  := contrary_phn;
			self.verlst_p                                      := verlst_p;
			self.veradd_p                                      := veradd_p;
			self.verphn_p                                      := verphn_p;
			self.contrary_ssn                                  := contrary_ssn;
			self.verlst_s                                      := verlst_s;
			self.veradd_s                                      := veradd_s;
			self.verssn_s                                      := verssn_s;
			self.nas_479                                       := nas_479;
			self.dob_verd                                      := dob_verd;
			self.vermod_log                                    := vermod_log;
			self.did1_vermod                                   := did1_vermod;
			self.ssn_issued18                                  := ssn_issued18;
			self.ssn_statediff                                 := ssn_statediff;
			self.ssn_adl_prob                                  := ssn_adl_prob;
			self.ssn_adl_prob2                                 := ssn_adl_prob2;
			self._rc_ssnlowissue                               := _rc_ssnlowissue;
			self.yr_rc_ssnlowissue                             := yr_rc_ssnlowissue;
			self.yr_reported_dob                               := yr_reported_dob;
			self.neg_age_at_low_issue_f                        := neg_age_at_low_issue_f;
			self.non_us_ssn_state                              := non_us_ssn_state;
			self.ssnmod_log                                    := ssnmod_log;
			self.did1_ssnmod                                   := did1_ssnmod;
			self.did1_rec_vehx_f                               := did1_rec_vehx_f;
			self.income_home_ratio                             := income_home_ratio;
			self.did1_income_home_ratio_c                      := did1_income_home_ratio_c;
			self.did1_income_home_ratio_lg                     := did1_income_home_ratio_lg;
			self._gong_did_first_seen                          := _gong_did_first_seen;
			self._gong_did_last_seen                           := _gong_did_last_seen;
			self.mos_since_gong_first_seen                     := mos_since_gong_first_seen;
			self.mos_since_gong_last_seen                      := mos_since_gong_last_seen;
			self.phn_last_seen_rec                             := phn_last_seen_rec;
			self.phn_first_seen_rec                            := phn_first_seen_rec;
			self.phn_disconnected                              := phn_disconnected;
			self.phn_inval                                     := phn_inval;
			self.phn_nonus                                     := phn_nonus;
			self.phn_notpots                                   := phn_notpots;
			self.phn_bad_counts                                := phn_bad_counts;
			self.phnmod_log                                    := phnmod_log;
			self.did1_phnprob_mod                              := did1_phnprob_mod;
			self.impulse_email                                 := impulse_email;
			self.did1_impulse_f                                := did1_impulse_f;
			self.did1_add1_assessed_total_val_c                := did1_add1_assessed_total_val_c;
			self.did1_add1_avm_sales_price_c                   := did1_add1_avm_sales_price_c;
			self.did1_add1_avm_sales_price_lg                  := did1_add1_avm_sales_price_lg;
			self.did1_add1_market_total_value_c                := did1_add1_market_total_value_c;
			self.did1_add1_market_total_value_lg               := did1_add1_market_total_value_lg;
			self._add1_mortgage_date                           := _add1_mortgage_date;
			self._add1_mortgage_due_date                       := _add1_mortgage_due_date;
			self.mtg_term                                      := mtg_term;
			self._mtg_term                                     := _mtg_term;
			self.mtg_15                                        := mtg_15;
			self.mtg_25                                        := mtg_25;
			self.mtg_30                                        := mtg_30;
			self.mtg_40                                        := mtg_40;
			self.mtg_typ_va                                    := mtg_typ_va;
			self.mtg_typ_fha                                   := mtg_typ_fha;
			self.mtgmod_log                                    := mtgmod_log;
			self.did1_mtgmod                                   := did1_mtgmod;
			self.avg_sold_assess_amt                           := avg_sold_assess_amt;
			self.did1_avg_sold_assess_amt_c                    := did1_avg_sold_assess_amt_c;
			self.did1_avg_sold_assess_amt_lg                   := did1_avg_sold_assess_amt_lg;
			self.did1_stolen_addr                              := did1_stolen_addr;
			self.did0_log                                      := did0_log;
			self.ff_did1_log                                   := ff_did1_log;
			self.phat                                          := phat;
			self.point                                         := point;
			self.base                                          := base;
			self.odds                                          := odds;
			self.sprint_ff_log                                 := sprint_ff_log;
			self.sprint_ff_score                               := sprint_ff_score;
			self.ssndead                                       := ssndead;
			self.ssnprior                                      := ssnprior;
			self.ssninval                                      := ssninval;
			self.prisonflag                                    := prisonflag;
			self.override_1                                    := override_1;
			self.source_tot_ds                                 := source_tot_ds;
			self.source_tot_ba                                 := source_tot_ba;
			self.bk_flag                                       := bk_flag;
			self.lien_rec_unrel_flag                           := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag                          := lien_hist_unrel_flag;
			self.source_tot_l2                                 := source_tot_l2;
			self.source_tot_li                                 := source_tot_li;
			self.lien_flag                                     := lien_flag;
			self.ssn_deceased                                  := ssn_deceased;
			self.scored_222s                                   := scored_222s;
			self.override                                      := override;
			self._rvt1104_1_0                                  := _rvt1104_1_0;
			self.ov_criminal_flag                              := ov_criminal_flag;
			self.ov_impulse                                    := ov_impulse;
			self.rvt1104_1_0                                   := rvt1104_1_0;
		#end
		

		
		corr := riskwisefcra.corrReasonCodes( le.consumerflags, 4 );
		r := riskwise.Reasons( le, PrescreenOptOut:=xmlPreScreenOptOut, isCalifornia:=isCalifornia );
		
		// the following reason codes are per darrin udean's direction:
			header_first_seen := le.ssn_verification.header_first_seen;
			isCode9R := header_first_seen between 0 and 11; // "header_first_seen is 0-11 months"

			add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
			isCode9O := not add1_eda_sourced and phones_per_addr=0;

			isCode9M := (wealth_index = '1') and  (watercraft_count = 0 and attr_num_aircraft=0); // "(wealth_index = 1) and  (watercraft = 0 and aircraft=0)"

			isCode9K := rc_dwelltype='A';
		//


		rvt_reasons :=
			if( r.rc02, r.makeRC('02') ) &
			if( r.rc9V, r.makeRC('9V') ) &
			if( r.rc97, r.makeRC('97') ) &
			if( r.rcEV, r.makeRC('EV') ) &
			if( r.rc9W, r.makeRC('9W') ) &
			if( r.rc98, r.makeRC('98') ) &
			if( r.rc9H, r.makeRC('9H') ) &
			if( r.rc9Q, r.makeRC('9Q') ) &
			if( r.rcMS, r.makeRC('MS') ) &
			if( r.rc9D, r.makeRC('9D') ) &
			if( r.rcPV, r.makeRC('PV') ) &
			if( r.rc9U, r.makeRC('9U') ) &
			if( r.rc9E, r.makeRC('9E') ) &
			if( r.rc9T, r.makeRC('9T') ) &
			if( isCode9R, r.makeRC('9R') ) &
			if( isCode9O, r.makeRC('9O') ) &
			if( r.rcMI, r.makeRC('MI') ) &
			if( r.rc9G, r.makeRC('9G') ) &
			if( r.rc28, r.makeRC('28') ) &
			if( r.rc99, r.makeRC('99') ) &
			if( r.rc9A, r.makeRC('9A') ) &
			if( r.rc9J, r.makeRC('9J') ) &
			if( r.rc9N, r.makeRC('9N') ) &
			// if( r.rc9X, r.makeRC('9X') ) & // 9X is only an override reason code -- "return as the only reason code for scores of 222"
			if( r.rc9C, r.makeRC('9C') ) &
			// if( r.rc36, r.makeRC('36') ) & // per darrin, "only use this as a "filler" reason code like the other RiskView 4.0 models" -- it is not included within the reason code set itself
			if( r.rc79, r.makeRC('79') ) &
			if( isCode9M, r.makeRC('9M') ) &
			if( r.rc9S, r.makeRC('9S') ) &
			if( r.rc49, r.makeRC('49') ) &
			if( isCode9K, r.makeRC('9K') ) &
			if( r.rc9L, r.makeRC('9L') ) &
			if( r.rc16, r.makeRC('16') ) &
			r.makeRC('00') &
			r.makeRC('00') &
			r.makeRC('00') &
			r.makeRC('00')
		;

		self.seq := le.seq;
		self.score := map(
			corr[1].hri in ['91','92','93','94'] => (string)((integer)corr[1].hri + 10 ),
			r.rc35 => '100',
			(string3)rvt1104_1_0
		);
		self.ri := map(
			corr[1].hri in ['91','92','93','94'] => corr,
			r.rc35          => r.makeRC('35') & r.makeRC('00') & r.makeRC('00') & r.makeRC('00'),
			rvt1104_1_0=222 => r.makeRC('9X') & r.makeRC('00') & r.makeRC('00') & r.makeRC('00'),
			choosen(rvt_reasons,4)
		);

	end;
	
	model := project( clam, doModel(left) );
	
	return model;

end;