import risk_indicators, ut, easi, riskwise, std;

bs_with_ip :=  record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;

export FP1109_0_0( dataset(bs_with_ip) clam_ip, integer1 num_reasons, boolean criminal ) :=  FUNCTION

	models.layouts.layout_fp1109 doModel( clam_ip le, easi.Key_Easi_Census ri ) :=  TRANSFORM

		did_count                        :=  le.bs.iid.didcount;
		rc_dirsaddr_lastscore            :=  le.bs.iid.dirsaddr_lastscore;
		rc_input_addr_not_most_recent    :=  le.bs.iid.inputaddrnotmostrecent;
		rc_combo_sec_rangescore          :=  le.bs.iid.combo_sec_rangescore;
		rc_fnamecount                    :=  le.bs.iid.firstcount;
		rc_lnamecount                    :=  le.bs.iid.lastcount;
		rc_addrcount                     :=  le.bs.iid.addrcount;
		rc_phonelnamecount               :=  le.bs.iid.phonelastcount;
		rc_phoneaddrcount                :=  le.bs.iid.phoneaddrcount;
		rc_phoneaddr_addrcount           :=  le.bs.iid.phoneaddr_addrcount;
		rc_lnamessnmatch                 :=  le.bs.iid.lastssnmatch;
		rc_lnamessnmatch2                :=  le.bs.iid.lastssnmatch2;
		rc_fnamessnmatch                 :=  le.bs.iid.firstssnmatch;
		combo_dobscore                   :=  le.bs.iid.combo_dobscore;
		combo_hphonecount                :=  le.bs.iid.combo_hphonecount;
		combo_dobcount                   :=  le.bs.iid.combo_dobcount;
		rc_watchlist_flag                :=  le.bs.iid.watchlisthit;
		bus_name_match                   :=  le.bs.business_header_address_summary.bus_name_match;
		bus_phone_match                  :=  le.bs.business_header_address_summary.bus_phone_match;
		source_count                     :=  le.bs.name_verification.source_count;
		fname_eda_sourced                :=  le.bs.name_verification.fname_eda_sourced;
		lname_eda_sourced                :=  le.bs.name_verification.lname_eda_sourced;
		age                              :=  le.bs.name_verification.age;
		add1_unit_count                  :=  le.bs.address_verification.input_address_information.unit_count;
		add1_lres                        :=  le.bs.lres;
		add1_avm_automated_valuation     :=  le.bs.avm.input_address_information.avm_automated_valuation;
		add1_source_count                :=  le.bs.address_verification.input_address_information.source_count;
		add1_eda_sourced                 :=  le.bs.address_verification.input_address_information.eda_sourced;
		add1_turnover_1yr_in             :=  le.bs.addr_risk_summary.turnover_1yr_in;
		add1_nhood_vacant_properties     :=  le.bs.addr_risk_summary.n_vacant_properties;
		add2_lres                        :=  le.bs.lres2;
		add2_avm_automated_valuation     :=  le.bs.avm.address_history_1.avm_automated_valuation;
		add2_source_count                :=  le.bs.address_verification.address_history_1.source_count;
		add2_eda_sourced                 :=  le.bs.address_verification.address_history_1.eda_sourced;
		add2_naprop                      :=  le.bs.address_verification.address_history_1.naprop;
		add2_turnover_1yr_in             :=  le.bs.addr_risk_summary2.turnover_1yr_in;
		add2_nhood_vacant_properties     :=  le.bs.addr_risk_summary2.n_vacant_properties;
		add3_lres                        :=  le.bs.lres3;
		add3_avm_automated_valuation     :=  le.bs.avm.address_history_2.avm_automated_valuation;
		add3_source_count                :=  le.bs.address_verification.address_history_2.source_count;
		add3_eda_sourced                 :=  le.bs.address_verification.address_history_2.eda_sourced;
		add3_naprop                      :=  le.bs.address_verification.address_history_2.naprop;
		avg_lres                         :=  le.bs.other_address_info.avg_lres;
		gong_did_phone_ct                :=  le.bs.phone_verification.gong_did.gong_did_phone_ct;
		gong_did_addr_ct                 :=  le.bs.phone_verification.gong_did.gong_did_addr_ct;
		gong_did_first_ct                :=  le.bs.phone_verification.gong_did.gong_did_first_ct;
		gong_did_last_ct                 :=  le.bs.phone_verification.gong_did.gong_did_last_ct;
		utility_sourced                  :=  le.bs.ssn_verification.utility_sourced;
		attr_total_number_derogs         :=  le.bs.total_number_derogs;
		attr_num_nonderogs30             :=  le.bs.source_verification.num_nonderogs30;
		attr_num_nonderogs90             :=  le.bs.source_verification.num_nonderogs90;
		attr_num_nonderogs180            :=  le.bs.source_verification.num_nonderogs180;
		liens_historical_unreleased_ct   :=  le.bs.bjl.liens_historical_unreleased_count;
		prof_license_category            :=  le.bs.professional_license.plcategory;
		input_dob_match_level            :=  le.bs.dobmatchlevel;
		c_ab_av_edu                      :=  ri.ab_av_edu;
		c_apt20                          :=  ri.apt20;
		c_armforce                       :=  ri.armforce;
		c_asian_lang                     :=  ri.asian_lang;
		c_assault                        :=  ri.assault;
		c_bel_edu                        :=  ri.bel_edu;
		c_bigapt_p                       :=  ri.bigapt_p;
		c_blue_col                       :=  ri.blue_col;
		c_blue_empl                      :=  ri.blue_empl;
		c_born_usa                       :=  ri.born_usa;
		c_burglary                       :=  ri.burglary;
		c_cartheft                       :=  ri.cartheft;
		c_child                          :=  ri.child;
		c_civ_emp                        :=  ri.civ_emp;
		c_easiqlife                      :=  ri.easiqlife;
		c_edu_indx                       :=  ri.edu_indx;
		c_exp_homes                      :=  ri.exp_homes;
		c_fammar18_p                     :=  ri.fammar18_p;
		c_fammar_p                       :=  ri.fammar_p;
		c_femdiv_p                       :=  ri.femdiv_p;
		c_for_sale                       :=  ri.for_sale;
		c_hhsize                         :=  ri.hhsize;
		c_high_ed                        :=  ri.high_ed;
		c_high_hval                      :=  ri.high_hval;
		c_highinc                        :=  ri.highinc;
		c_highrent                       :=  ri.highrent;
		c_hval_1000k_p                   :=  ri.hval_1000k_p;
		c_hval_1001k_p                   :=  ri.hval_1001k_p;
		c_hval_100k_p                    :=  ri.hval_100k_p;
		c_hval_20k_p                     :=  ri.hval_20k_p;
		c_hval_40k_p                     :=  ri.hval_40k_p;
		c_hval_500k_p                    :=  ri.hval_500k_p;
		c_hval_60k_p                     :=  ri.hval_60k_p;
		c_hval_750k_p                    :=  ri.hval_750k_p;
		c_hval_80k_p                     :=  ri.hval_80k_p;
		c_inc_150k_p                     :=  ri.in150k_p;
		c_inc_15k_p                      :=  ri.in15k_p;
		c_inc_201k_p                     :=  ri.in201k_p;
		c_inc_25k_p                      :=  ri.in25k_p;
		c_inc_35k_p                      :=  ri.in35k_p;
		c_inc_50k_p                      :=  ri.in50k_p;
		c_incollege                      :=  ri.incollege;
		c_lar_fam                        :=  ri.lar_fam;
		c_larceny                        :=  ri.larceny;
		c_low_ed                         :=  ri.low_ed;
		c_low_hval                       :=  ri.low_hval;
		c_lowinc                         :=  ri.lowinc;
		c_lowrent                        :=  ri.lowrent;
		c_many_cars                      :=  ri.many_cars;
		c_med_age                        :=  ri.med_age;
		c_med_hhinc                      :=  ri.med_hhinc;
		c_med_hval                       :=  ri.med_hval;
		c_med_inc                        :=  ri.med_inc;
		c_med_rent                       :=  ri.med_rent;
		c_mil_emp                        :=  ri.mil_emp;
		c_mort_indx                      :=  ri.mort_indx;
		c_murders                        :=  ri.murders;
		c_no_move                        :=  ri.no_move;
		c_ownocc_p                       :=  ri.ownocp;
		c_pop_18_24_p                    :=  ri.pop_18_24_p;
		c_pop_25_34_p                    :=  ri.pop_25_34_p;
		c_rape                           :=  ri.rape;
		c_recent_mov                     :=  ri.recent_mov;
		c_relig_indx                     :=  ri.relig_indx;
		c_rental                         :=  ri.rental;
		c_rentocc_p                      :=  ri.rentocp;
		c_retired                        :=  ri.retired;
		c_retired2                       :=  ri.retired2;
		c_rnt2001_p                      :=  ri.rnt2001_p;
		c_rnt250_p                       :=  ri.rnt250_p;
		c_rnt500_p                       :=  ri.rnt500_p;
		c_rnt750_p                       :=  ri.rnt750_p;
		c_robbery                        :=  ri.robbery;
		c_sfdu_p                         :=  ri.sfdu_p;
		c_span_lang                      :=  ri.span_lang;
		c_totcrime                       :=  ri.totcrime;
		c_totsales                       :=  ri.totsales;
		c_trailer                        :=  ri.trailer;
		c_trailer_p                      :=  ri.trailer_p;
		c_unattach                       :=  ri.unattach;
		c_unemp                          :=  ri.unemp;
		c_unempl                         :=  ri.unempl;
		c_urban_p                        :=  ri.urban_p;
		c_vacant_p                       :=  ri.vacant_p;
		c_white_col                      :=  ri.white_col;
		c_young                          :=  ri.young;
		nas_summary                      :=  le.bs.iid.nas_summary;
		nap_summary                      :=  le.bs.iid.nap_summary;
		rc_hriskphoneflag                :=  le.bs.iid.hriskphoneflag;
		rc_hphonetypeflag                :=  le.bs.iid.hphonetypeflag;
		rc_phonevalflag                  :=  le.bs.iid.phonevalflag;
		rc_hphonevalflag                 :=  le.bs.iid.hphonevalflag;
		rc_hriskaddrflag                 :=  le.bs.iid.hriskaddrflag;
		rc_decsflag                      :=  le.bs.iid.decsflag;
		rc_ssndobflag                    :=  le.bs.iid.socsdobflag;
		rc_pwssndobflag                  :=  le.bs.iid.pwsocsdobflag;
		rc_ssnvalflag                    :=  le.bs.iid.socsvalflag;
		rc_pwssnvalflag                  :=  le.bs.iid.pwsocsvalflag;
		rc_addrvalflag                   :=  le.bs.iid.addrvalflag;
		rc_ssnmiskeyflag                 :=  le.bs.iid.socsmiskeyflag;
		rc_addrmiskeyflag                :=  le.bs.iid.addrmiskeyflag;
		rc_addrcommflag                  :=  le.bs.iid.addrcommflag;
		rc_hrisksic                      :=  le.bs.iid.hrisksic;
		rc_hrisksicphone                 :=  le.bs.iid.hrisksicphone;
		ssnlength                        :=  le.bs.input_validation.ssn_length;
		dobpop                           :=  le.bs.input_validation.dateofbirth;
		hphnpop                          :=  le.bs.input_validation.homephone;
		add1_house_number_match          :=  le.bs.address_verification.input_address_information.house_number_match;
		ssns_per_adl                     :=  le.bs.velocity_counters.ssns_per_adl;
		ssns_per_adl_c6                  :=  le.bs.velocity_counters.ssns_per_adl_created_6months;
		lnames_per_adl_c6                :=  le.bs.velocity_counters.lnames_per_adl180;
		rel_felony_count                 :=  le.bs.relatives.relative_felony_count;
		rel_count_addr                   :=  le.bs.relatives.relatives_at_input_address;
		inferred_age                     :=  le.bs.inferred_age;
		adl_category                     :=  le.bs.adlcategory;
		in_state                         :=  le.bs.shell_input.in_state;
		out_unit_desig                   :=  le.bs.shell_input.unit_desig;
		out_sec_range                    :=  le.bs.shell_input.sec_range;
		out_addr_type                    :=  le.bs.shell_input.addr_type;
		out_addr_status                  :=  le.bs.shell_input.addr_status;
		in_dob                           :=  le.bs.shell_input.dob;
		nap_type                         :=  le.bs.iid.nap_type;
		nap_status                       :=  le.bs.iid.nap_status;
		did2_header_first_seen           :=  le.bs.iid.did2_headerfirstseen;
		did2_criminal_count              :=  le.bs.iid.did2_criminal_count;
		did2_felony_count                :=  le.bs.iid.did2_felony_count;
		did2_liens_hist_unrel_count      :=  le.bs.iid.did2_liens_historical_unreleased_count;
		did3_criminal_count              :=  le.bs.iid.did3_criminal_count;
		did3_felony_count                :=  le.bs.iid.did3_felony_count;
		did3_liens_hist_unrel_count      :=  le.bs.iid.did3_liens_historical_unreleased_count;
		rc_dl_val_flag                   :=  le.bs.iid.drlcvalflag;
		rc_non_us_ssn                    :=  le.bs.iid.non_us_ssn;
		rc_phonezipflag                  :=  le.bs.iid.phonezipflag;
		rc_pwphonezipflag                :=  le.bs.iid.pwphonezipflag;
		rc_ssnlowissue                   :=  (unsigned)le.bs.iid.socllowissue;
		rc_ssnstate                      :=  le.bs.iid.soclstate;
		rc_dwelltype                     :=  le.bs.iid.dwelltype;
		rc_bansflag                      :=  le.bs.iid.bansflag;
		rc_ssncount                      :=  le.bs.iid.socscount;
		rc_utiliaddr_addrcount           :=  le.bs.iid.utiliaddr_addrcount;
		rc_phonetype                     :=  le.bs.iid.phonetype;
		rc_ziptypeflag                   :=  le.bs.iid.ziptypeflag;
		rc_cityzipflag                   :=  le.bs.iid.cityzipflag;
		rc_altlname1_flag                :=  le.bs.iid.altlastpop;
		rc_altlname2_flag                :=  le.bs.iid.altlast2pop;
		combo_hphonescore                :=  le.bs.iid.combo_hphonescore;
		combo_ssnscore                   :=  le.bs.iid.combo_ssnscore;
		combo_addrcount                  :=  le.bs.iid.combo_addrcount;
		ver_sources                      :=  le.bs.header_summary.ver_sources;
		ver_sources_nas                  :=  le.bs.header_summary.ver_sources_nas;
		ver_sources_first_seen           :=  le.bs.header_summary.ver_sources_first_seen_date;
		ver_sources_count                :=  le.bs.header_summary.ver_sources_recordcount;
		bus_addr_match_count             :=  le.bs.business_header_address_summary.bus_addr_match_cnt;
		bus_addr_sources                 :=  le.bs.business_header_address_summary.bus_sources;
		fname_eda_sourced_type           :=  le.bs.name_verification.fname_eda_sourced_type;
		lname_eda_sourced_type           :=  le.bs.name_verification.lname_eda_sourced_type;
		util_adl_count                   :=  le.bs.utility.utili_adl_count;
		util_adl_nap                     :=  le.bs.utility.utili_adl_nap;
		add1_isbestmatch                 :=  le.bs.address_verification.input_address_information.isbestmatch;
		add1_advo_address_vacancy        :=  le.bs.advo_input_addr.address_vacancy_indicator;
		add1_advo_throw_back             :=  le.bs.advo_input_addr.throw_back_indicator;
		add1_advo_mixed_address_usage    :=  le.bs.advo_input_addr.mixed_address_usage;
		add1_avm_med_fips                :=  le.bs.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               :=  le.bs.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               :=  le.bs.avm.input_address_information.avm_median_geo12_level;
		add1_applicant_owned             :=  le.bs.address_verification.input_address_information.applicant_owned;
		add1_family_owned                :=  le.bs.address_verification.input_address_information.family_owned;
		add1_naprop                      :=  le.bs.address_verification.input_address_information.naprop;
		add1_mortgage_type               :=  le.bs.address_verification.input_address_information.mortgage_type;
		add1_financing_type              :=  le.bs.address_verification.input_address_information.type_financing;
		add1_building_area               :=  (string)le.bs.address_verification.input_address_information.building_area;
		property_owned_total             :=  le.bs.address_verification.owned.property_total;
		property_sold_total              :=  le.bs.address_verification.sold.property_total;
		add2_isbestmatch                 :=  le.bs.address_verification.address_history_1.isbestmatch;
		add2_advo_address_vacancy        :=  le.bs.advo_addr_hist1.address_vacancy_indicator;
		add2_avm_med_fips                :=  le.bs.avm.address_history_1.avm_median_fips_level;
		add2_avm_med_geo11               :=  le.bs.avm.address_history_1.avm_median_geo11_level;
		add2_avm_med_geo12               :=  le.bs.avm.address_history_1.avm_median_geo12_level;
		add2_building_area               :=  (string)le.bs.address_verification.address_history_1.building_area;
		add2_mortgage_type               :=  le.bs.address_verification.address_history_1.mortgage_type;
		add2_financing_type              :=  le.bs.address_verification.address_history_1.type_financing;
		add3_mortgage_type               :=  le.bs.address_verification.address_history_2.mortgage_type;
		add3_financing_type              :=  le.bs.address_verification.address_history_2.type_financing;
		addrs_5yr                        :=  le.bs.other_address_info.addrs_last_5years;
		addrs_10yr                       :=  le.bs.other_address_info.addrs_last_10years;
		addrs_15yr                       :=  le.bs.other_address_info.addrs_last_15years;
		addrs_prison_history             :=  le.bs.other_address_info.isprison;
		telcordia_type                   :=  le.bs.phone_verification.telcordia_type;
		gong_did_first_seen              :=  le.bs.phone_verification.gong_did.gong_adl_dt_first_seen_full;
		nameperssn_count                 :=  le.bs.ssn_verification.nameperssn_count;
		header_first_seen                :=  le.bs.ssn_verification.header_first_seen;
		addrs_per_adl                    :=  le.bs.velocity_counters.addrs_per_adl;
		phones_per_adl                   :=  le.bs.velocity_counters.phones_per_adl;
		lnames_per_adl                   :=  le.bs.velocity_counters.lnames_per_adl;
		adlperssn_count                  :=  le.bs.ssn_verification.adlperssn_count;
		addrs_per_ssn                    :=  le.bs.velocity_counters.addrs_per_ssn;
		adls_per_addr                    :=  le.bs.velocity_counters.adls_per_addr;
		ssns_per_addr                    :=  le.bs.velocity_counters.ssns_per_addr;
		phones_per_addr                  :=  le.bs.velocity_counters.phones_per_addr;
		adls_per_phone                   :=  le.bs.velocity_counters.adls_per_phone;
		addrs_per_adl_c6                 :=  le.bs.velocity_counters.addrs_per_adl_created_6months;
		phones_per_adl_c6                :=  le.bs.velocity_counters.phones_per_adl_created_6months;
		adls_per_ssn_c6                  :=  le.bs.velocity_counters.adls_per_ssn_created_6months;
		addrs_per_ssn_c6                 :=  le.bs.velocity_counters.addrs_per_ssn_created_6months;
		adls_per_addr_c6                 :=  le.bs.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 :=  le.bs.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6               :=  le.bs.velocity_counters.phones_per_addr_created_6months;
		adls_per_phone_c6                :=  le.bs.velocity_counters.adls_per_phone_created_6months;
		inq_count                        :=  le.bs.acc_logs.inquiries.counttotal;
		inq_count01                      :=  le.bs.acc_logs.inquiries.count01;
		inq_count03                      :=  le.bs.acc_logs.inquiries.count03;
		inq_count06                      :=  le.bs.acc_logs.inquiries.count06;
		inq_collection_count             :=  le.bs.acc_logs.collection.counttotal;
		inq_collection_count03           :=  le.bs.acc_logs.collection.count03;
		inq_highriskcredit_count         :=  le.bs.acc_logs.highriskcredit.counttotal;
		inq_highriskcredit_count12       :=  le.bs.acc_logs.highriskcredit.count12;
		inq_perssn                       :=  le.bs.acc_logs.inquiryperssn;
		inq_peraddr                      :=  le.bs.acc_logs.inquiryperaddr;
		inq_perphone                     :=  le.bs.acc_logs.inquiryperphone;
		inq_adlsperphone                 :=  le.bs.acc_logs.inquiryadlsperphone;
		paw_business_count               :=  le.bs.employment.business_ct;
		paw_dead_business_count          :=  le.bs.employment.dead_business_ct;
		paw_active_phone_count           :=  le.bs.employment.business_active_phone_ct;
		infutor_nap                      :=  le.bs.infutor_phone.infutor_nap;
		impulse_count                    :=  le.bs.impulse.count;
		email_domain_free_count          :=  le.bs.email_summary.email_domain_free_ct;
		email_domain_isp_count           :=  le.bs.email_summary.email_domain_isp_ct;
		email_domain_edu_count           :=  le.bs.email_summary.email_domain_edu_ct;
		email_domain_corp_count          :=  le.bs.email_summary.email_domain_corp_ct;
		email_source_list                :=  le.bs.email_summary.email_source_list;
		attr_addrs_last30                :=  le.bs.other_address_info.addrs_last30;
		attr_addrs_last90                :=  le.bs.other_address_info.addrs_last90;
		attr_addrs_last12                :=  le.bs.other_address_info.addrs_last12;
		attr_addrs_last24                :=  le.bs.other_address_info.addrs_last24;
		attr_addrs_last36                :=  le.bs.other_address_info.addrs_last36;
		attr_num_purchase12              :=  le.bs.other_address_info.num_purchase12;
		attr_num_purchase24              :=  le.bs.other_address_info.num_purchase24;
		attr_num_purchase36              :=  le.bs.other_address_info.num_purchase36;
		attr_num_purchase60              :=  le.bs.other_address_info.num_purchase60;
		attr_num_aircraft                :=  le.bs.aircraft.aircraft_count;
		attr_date_last_derog             :=  le.bs.date_last_derog;
		attr_arrests                     :=  le.bs.bjl.arrests_count;
		attr_num_unrel_liens60           :=  le.bs.bjl.liens_unreleased_count60;
		attr_eviction_count              :=  le.bs.bjl.eviction_count;
		attr_num_nonderogs               :=  le.bs.source_verification.num_nonderogs;
		attr_num_nonderogs12             :=  le.bs.source_verification.num_nonderogs12;
		bankrupt                         :=  le.bs.bjl.bankrupt;
		disposition                      :=  le.bs.bjl.disposition;
		filing_count                     :=  le.bs.bjl.filing_count;
		bk_recent_count                  :=  le.bs.bjl.bk_recent_count;
		liens_recent_unreleased_count    :=  le.bs.bjl.liens_recent_unreleased_count;
		liens_recent_released_count      :=  le.bs.bjl.liens_recent_released_count;
		liens_historical_released_count  :=  le.bs.bjl.liens_historical_released_count;
		criminal_count                   :=  le.bs.bjl.criminal_count;
		felony_count                     :=  le.bs.bjl.felony_count;
		foreclosure_flag                 :=  le.bs.bjl.foreclosure_flag;
		rel_count                        :=  le.bs.relatives.relative_count;
		rel_bankrupt_count               :=  le.bs.relatives.relative_bankrupt_count;
		rel_criminal_count               :=  le.bs.relatives.relative_criminal_count;
		rel_criminal_total               :=  le.bs.relatives.relative_criminal_total;
		rel_felony_total                 :=  le.bs.relatives.relative_felony_total;
		crim_rel_within25miles           :=  le.bs.relatives.criminal_relative_within25miles;
		crim_rel_within100miles          :=  le.bs.relatives.criminal_relative_within100miles;
		rel_prop_owned_count             :=  le.bs.relatives.owned.relatives_property_count;
		rel_prop_owned_total             :=  le.bs.relatives.owned.relatives_property_total;
		rel_within25miles_count          :=  le.bs.relatives.relative_within25miles_count;
		rel_within100miles_count         :=  le.bs.relatives.relative_within100miles_count;
		rel_incomeunder25_count          :=  le.bs.relatives.relative_incomeunder25_count;
		rel_incomeunder50_count          :=  le.bs.relatives.relative_incomeunder50_count;
		rel_incomeover100_count          :=  le.bs.relatives.relative_incomeover100_count;
		rel_homeunder50_count            :=  le.bs.relatives.relative_homeunder50_count;
		rel_homeunder100_count           :=  le.bs.relatives.relative_homeunder100_count;
		rel_homeover500_count            :=  le.bs.relatives.relative_homeover500_count;
		rel_educationunder8_count        :=  le.bs.relatives.relative_educationunder8_count;
		rel_educationunder12_count       :=  le.bs.relatives.relative_educationunder12_count;
		rel_vehicle_owned_count          :=  le.bs.relatives.relative_vehicle_owned_count;
		current_count                    :=  le.bs.vehicles.current_count;
		watercraft_count                 :=  le.bs.watercraft.watercraft_count;
		acc_count                        :=  le.bs.accident_data.acc.num_accidents;
		ams_file_type                    :=  le.bs.student.file_type;
		wealth_index                     :=  le.bs.wealth_indicator;
		input_dob_age                    :=  le.bs.shell_input.age;
		reported_dob                     :=  le.bs.reported_dob;
		addr_stability_v2                :=  le.bs.addr_stability;
		archive_date                     :=  le.bs.historydate;
		C_AGRICULTURE                    :=  ri.agriculture;
		C_RURAL_P                        :=  ri.rural_p;
		combo_addrscore                  :=  le.bs.iid.combo_addrscore;
		ams_income_level_code            :=  le.bs.student.income_level_code;

		add1_no_of_baths    := le.bs.address_verification.input_address_information.no_of_baths;
		add1_no_of_bedrooms := le.bs.address_verification.input_address_information.no_of_bedrooms;
		add2_no_of_bedrooms := le.bs.address_verification.address_history_1.no_of_bedrooms;
		adl_score := le.bs.name_verification.adl_score;
		ams_college_code := le.bs.student.college_code;
		ams_college_tier := le.bs.student.college_tier;

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


INTEGER year(integer sas_date) :=
	if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));


// initial transformations

sysdate :=  __common__( map(
    trim((string)archive_date, LEFT, RIGHT) = '999999'  => models.common.sas_date(if(le.bs.historydate=999999, (STRING)Std.Date.Today(), (string6)le.bs.historydate+'01')),
    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
                                                           NULL));

// input_dob_match_level :=  __common__( (real)input_dob_match_level);

in_dob2 :=  __common__( models.common.sas_date((string)(in_dob)));

yr_in_dob :=  __common__( if(min(sysdate, in_dob2) = NULL, NULL, roundup((sysdate - in_dob2) / 365.25)));

mth_in_dob :=  __common__( if(min(sysdate, in_dob2) = NULL, NULL, roundup((sysdate - in_dob2) / 30.5)));

reported_dob2 :=  __common__( models.common.sas_date((string)(reported_dob)));

yr_reported_dob :=  __common__( if(min(sysdate, reported_dob2) = NULL, NULL, roundup((sysdate - reported_dob2) / 365.25)));

mth_reported_dob :=  __common__( if(min(sysdate, reported_dob2) = NULL, NULL, roundup((sysdate - reported_dob2) / 30.5)));

did2_header_first_seen2 :=  __common__( models.common.sas_date((string)(did2_header_first_seen)));

yr_did2_header_first_seen :=  __common__( if(min(sysdate, did2_header_first_seen2) = NULL, NULL, roundup((sysdate - did2_header_first_seen2) / 365.25)));

mth_did2_header_first_seen :=  __common__( if(min(sysdate, did2_header_first_seen2) = NULL, NULL, roundup((sysdate - did2_header_first_seen2) / 30.5)));

attr_date_last_derog2 :=  __common__( models.common.sas_date((string)(attr_date_last_derog)));

yr_attr_date_last_derog :=  __common__( if(min(sysdate, attr_date_last_derog2) = NULL, NULL, roundup((sysdate - attr_date_last_derog2) / 365.25)));

mth_attr_date_last_derog :=  __common__( if(min(sysdate, attr_date_last_derog2) = NULL, NULL, roundup((sysdate - attr_date_last_derog2) / 30.5)));

header_first_seen2 :=  __common__( models.common.sas_date((string)(header_first_seen)));

yr_header_first_seen :=  __common__( if(min(sysdate, header_first_seen2) = NULL, NULL, roundup((sysdate - header_first_seen2) / 365.25)));

mth_header_first_seen :=  __common__( if(min(sysdate, header_first_seen2) = NULL, NULL, roundup((sysdate - header_first_seen2) / 30.5)));

gong_did_first_seen2 :=  __common__( models.common.sas_date((string)(gong_did_first_seen)));

yr_gong_did_first_seen :=  __common__( if(min(sysdate, gong_did_first_seen2) = NULL, NULL, roundup((sysdate - gong_did_first_seen2) / 365.25)));

mth_gong_did_first_seen :=  __common__( if(min(sysdate, gong_did_first_seen2) = NULL, NULL, roundup((sysdate - gong_did_first_seen2) / 30.5)));

rc_ssnlowissue2 :=  __common__( models.common.sas_date((string)(rc_ssnlowissue)));

yr_rc_ssnlowissue :=  __common__( if(min(sysdate, rc_ssnlowissue2) = NULL, NULL, roundup((sysdate - rc_ssnlowissue2) / 365.25)));

mth_rc_ssnlowissue :=  __common__( if(min(sysdate, rc_ssnlowissue2) = NULL, NULL, roundup((sysdate - rc_ssnlowissue2) / 30.5)));

ver_src_cnt :=  __common__( models.common.countw((string)(ver_sources), ' !$%&()*+,-./);<^|'));

ver_src_pop :=  __common__( ver_src_cnt > 0);

ver_src_fsrc :=  __common__( models.common.getw(ver_sources, 1));

ver_src_fsrc_fdate :=  __common__( models.common.getw(ver_sources_first_seen, 1));

ver_src_fsrc_fdate2 :=  __common__( models.common.sas_date((string)(ver_src_fsrc_fdate)));

yr_ver_src_fsrc_fdate :=  __common__( if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, roundup((sysdate - ver_src_fsrc_fdate2) / 365.25)));

mth_ver_src_fsrc_fdate :=  __common__( if(min(sysdate, ver_src_fsrc_fdate2) = NULL, NULL, roundup((sysdate - ver_src_fsrc_fdate2) / 30.5)));

ver_src_ak_pos :=  __common__( models.common.findw_cpp(ver_sources, 'AK' , ' ,', 'ie'));

ver_src_ak :=  __common__( ver_src_ak_pos > 0);

ver_src_fdate_ak :=  __common__( if(ver_src_ak_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_ak_pos), '0'));

ver_src_fdate_ak2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_ak)));

yr_ver_src_fdate_ak :=  __common__( if(min(sysdate, ver_src_fdate_ak2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ak2) / 365.25)));

mth_ver_src_fdate_ak :=  __common__( if(min(sysdate, ver_src_fdate_ak2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ak2) / 30.5)));

ver_src_cnt_ak :=  __common__( if(ver_src_ak_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_ak_pos), 0));

ver_src_rcnt_init :=  __common__( 0); // since ver_src_rcnt_36, _35, etc., aggregate counts, i'm assuming ver_src_rcnt should start off as zero
ver_src_rcnt_36 :=  __common__( ver_src_rcnt_init + ver_src_cnt_ak);

ver_src_am_pos :=  __common__( models.common.findw_cpp(ver_sources, 'AM' , ' ,', 'ie'));

ver_src_am :=  __common__( ver_src_am_pos > 0);

ver_src_fdate_am :=  __common__( if(ver_src_am_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_am_pos), '0'));

ver_src_fdate_am2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_am)));

yr_ver_src_fdate_am :=  __common__( if(min(sysdate, ver_src_fdate_am2) = NULL, NULL, roundup((sysdate - ver_src_fdate_am2) / 365.25)));

mth_ver_src_fdate_am :=  __common__( if(min(sysdate, ver_src_fdate_am2) = NULL, NULL, roundup((sysdate - ver_src_fdate_am2) / 30.5)));

ver_src_cnt_am :=  __common__( if(ver_src_am_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_am_pos), 0));

ver_src_rcnt_35 :=  __common__( ver_src_rcnt_36 + ver_src_cnt_am);

ver_src_ar_pos :=  __common__( models.common.findw_cpp(ver_sources, 'AR' , ' ,', 'ie'));

ver_src_ar :=  __common__( ver_src_ar_pos > 0);

ver_src_fdate_ar :=  __common__( if(ver_src_ar_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_ar_pos), '0'));

ver_src_fdate_ar2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_ar)));

yr_ver_src_fdate_ar :=  __common__( if(min(sysdate, ver_src_fdate_ar2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ar2) / 365.25)));

mth_ver_src_fdate_ar :=  __common__( if(min(sysdate, ver_src_fdate_ar2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ar2) / 30.5)));

ver_src_cnt_ar :=  __common__( if(ver_src_ar_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_ar_pos), 0));

ver_src_rcnt_34 :=  __common__( ver_src_rcnt_35 + ver_src_cnt_ar);

ver_src_ba_pos :=  __common__( models.common.findw_cpp(ver_sources, 'BA' , ' ,', 'ie'));

ver_src_ba :=  __common__( ver_src_ba_pos > 0);

ver_src_fdate_ba :=  __common__( if(ver_src_ba_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_ba_pos), '0'));

ver_src_fdate_ba2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_ba)));

yr_ver_src_fdate_ba :=  __common__( if(min(sysdate, ver_src_fdate_ba2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ba2) / 365.25)));

mth_ver_src_fdate_ba :=  __common__( if(min(sysdate, ver_src_fdate_ba2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ba2) / 30.5)));

ver_src_cnt_ba :=  __common__( if(ver_src_ba_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_ba_pos), 0));

ver_src_rcnt_33 :=  __common__( ver_src_rcnt_34 + ver_src_cnt_ba);

ver_src_cg_pos :=  __common__( models.common.findw_cpp(ver_sources, 'CG' , ' ,', 'ie'));

ver_src_cg :=  __common__( ver_src_cg_pos > 0);

ver_src_fdate_cg :=  __common__( if(ver_src_cg_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_cg_pos), '0'));

ver_src_fdate_cg2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_cg)));

yr_ver_src_fdate_cg :=  __common__( if(min(sysdate, ver_src_fdate_cg2) = NULL, NULL, roundup((sysdate - ver_src_fdate_cg2) / 365.25)));

mth_ver_src_fdate_cg :=  __common__( if(min(sysdate, ver_src_fdate_cg2) = NULL, NULL, roundup((sysdate - ver_src_fdate_cg2) / 30.5)));

ver_src_cnt_cg :=  __common__( if(ver_src_cg_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_cg_pos), 0));

ver_src_rcnt_32 :=  __common__( ver_src_rcnt_33 + ver_src_cnt_cg);

ver_src_co_pos :=  __common__( models.common.findw_cpp(ver_sources, 'CO' , ' ,', 'ie'));

ver_src_co :=  __common__( ver_src_co_pos > 0);

ver_src_fdate_co :=  __common__( if(ver_src_co_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_co_pos), '0'));

ver_src_fdate_co2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_co)));

yr_ver_src_fdate_co :=  __common__( if(min(sysdate, ver_src_fdate_co2) = NULL, NULL, roundup((sysdate - ver_src_fdate_co2) / 365.25)));

mth_ver_src_fdate_co :=  __common__( if(min(sysdate, ver_src_fdate_co2) = NULL, NULL, roundup((sysdate - ver_src_fdate_co2) / 30.5)));

ver_src_cnt_co :=  __common__( if(ver_src_co_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_co_pos), 0));

ver_src_rcnt_31 :=  __common__( ver_src_rcnt_32 + ver_src_cnt_co);

ver_src_cy_pos :=  __common__( models.common.findw_cpp(ver_sources, 'CY' , ' ,', 'ie'));

ver_src_cy :=  __common__( ver_src_cy_pos > 0);

ver_src_fdate_cy :=  __common__( if(ver_src_cy_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_cy_pos), '0'));

ver_src_fdate_cy2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_cy)));

yr_ver_src_fdate_cy :=  __common__( if(min(sysdate, ver_src_fdate_cy2) = NULL, NULL, roundup((sysdate - ver_src_fdate_cy2) / 365.25)));

mth_ver_src_fdate_cy :=  __common__( if(min(sysdate, ver_src_fdate_cy2) = NULL, NULL, roundup((sysdate - ver_src_fdate_cy2) / 30.5)));

ver_src_cnt_cy :=  __common__( if(ver_src_cy_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_cy_pos), 0));

ver_src_rcnt_30 :=  __common__( ver_src_rcnt_31 + ver_src_cnt_cy);

ver_src_da_pos :=  __common__( models.common.findw_cpp(ver_sources, 'DA' , ' ,', 'ie'));

ver_src_da :=  __common__( ver_src_da_pos > 0);

ver_src_fdate_da :=  __common__( if(ver_src_da_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_da_pos), '0'));

ver_src_fdate_da2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_da)));

yr_ver_src_fdate_da :=  __common__( if(min(sysdate, ver_src_fdate_da2) = NULL, NULL, roundup((sysdate - ver_src_fdate_da2) / 365.25)));

mth_ver_src_fdate_da :=  __common__( if(min(sysdate, ver_src_fdate_da2) = NULL, NULL, roundup((sysdate - ver_src_fdate_da2) / 30.5)));

ver_src_cnt_da :=  __common__( if(ver_src_da_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_da_pos), 0));

ver_src_rcnt_29 :=  __common__( ver_src_rcnt_30 + ver_src_cnt_da);

ver_src_d_pos :=  __common__( models.common.findw_cpp(ver_sources, 'D' , ' ,', 'ie'));

ver_src_d :=  __common__( ver_src_d_pos > 0);

ver_src_fdate_d :=  __common__( if(ver_src_d_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_d_pos), '0'));

ver_src_fdate_d2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_d)));

yr_ver_src_fdate_d :=  __common__( if(min(sysdate, ver_src_fdate_d2) = NULL, NULL, roundup((sysdate - ver_src_fdate_d2) / 365.25)));

mth_ver_src_fdate_d :=  __common__( if(min(sysdate, ver_src_fdate_d2) = NULL, NULL, roundup((sysdate - ver_src_fdate_d2) / 30.5)));

ver_src_cnt_d :=  __common__( if(ver_src_d_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_d_pos), 0));

ver_src_rcnt_28 :=  __common__( ver_src_rcnt_29 + ver_src_cnt_d);

ver_src_dl_pos :=  __common__( models.common.findw_cpp(ver_sources, 'DL' , ' ,', 'ie'));

ver_src_dl :=  __common__( ver_src_dl_pos > 0);

ver_src_fdate_dl :=  __common__( if(ver_src_dl_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_dl_pos), '0'));

ver_src_fdate_dl2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_dl)));

yr_ver_src_fdate_dl :=  __common__( if(min(sysdate, ver_src_fdate_dl2) = NULL, NULL, roundup((sysdate - ver_src_fdate_dl2) / 365.25)));

mth_ver_src_fdate_dl :=  __common__( if(min(sysdate, ver_src_fdate_dl2) = NULL, NULL, roundup((sysdate - ver_src_fdate_dl2) / 30.5)));

ver_src_cnt_dl :=  __common__( if(ver_src_dl_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_dl_pos), 0));

ver_src_rcnt_27 :=  __common__( ver_src_rcnt_28 + ver_src_cnt_dl);

ver_src_ds_pos :=  __common__( models.common.findw_cpp(ver_sources, 'DS' , ' ,', 'ie'));

ver_src_ds :=  __common__( ver_src_ds_pos > 0);

ver_src_fdate_ds :=  __common__( if(ver_src_ds_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_ds_pos), '0'));

ver_src_fdate_ds2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_ds)));

yr_ver_src_fdate_ds :=  __common__( if(min(sysdate, ver_src_fdate_ds2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ds2) / 365.25)));

mth_ver_src_fdate_ds :=  __common__( if(min(sysdate, ver_src_fdate_ds2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ds2) / 30.5)));

ver_src_cnt_ds :=  __common__( if(ver_src_ds_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_ds_pos), 0));

ver_src_rcnt_26 :=  __common__( ver_src_rcnt_27 + ver_src_cnt_ds);

ver_src_de_pos :=  __common__( models.common.findw_cpp(ver_sources, 'DE' , ' ,', 'ie'));

ver_src_de :=  __common__( ver_src_de_pos > 0);

ver_src_nas_de :=  __common__( if(ver_src_de_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_de_pos), 0));

ver_src_fdate_de :=  __common__( if(ver_src_de_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_de_pos), '0'));

ver_src_fdate_de2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_de)));

yr_ver_src_fdate_de :=  __common__( if(min(sysdate, ver_src_fdate_de2) = NULL, NULL, roundup((sysdate - ver_src_fdate_de2) / 365.25)));

mth_ver_src_fdate_de :=  __common__( if(min(sysdate, ver_src_fdate_de2) = NULL, NULL, roundup((sysdate - ver_src_fdate_de2) / 30.5)));

ver_src_cnt_de :=  __common__( if(ver_src_de_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_de_pos), 0));

ver_src_rcnt_25 :=  __common__( ver_src_rcnt_26 + ver_src_cnt_de);

ver_src_eb_pos :=  __common__( models.common.findw_cpp(ver_sources, 'EB' , ' ,', 'ie'));

ver_src_eb :=  __common__( ver_src_eb_pos > 0);

ver_src_fdate_eb :=  __common__( if(ver_src_eb_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_eb_pos), '0'));

ver_src_fdate_eb2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_eb)));

yr_ver_src_fdate_eb :=  __common__( if(min(sysdate, ver_src_fdate_eb2) = NULL, NULL, roundup((sysdate - ver_src_fdate_eb2) / 365.25)));

mth_ver_src_fdate_eb :=  __common__( if(min(sysdate, ver_src_fdate_eb2) = NULL, NULL, roundup((sysdate - ver_src_fdate_eb2) / 30.5)));

ver_src_cnt_eb :=  __common__( if(ver_src_eb_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_eb_pos), 0));

ver_src_rcnt_24 :=  __common__( ver_src_rcnt_25 + ver_src_cnt_eb);

ver_src_em_pos :=  __common__( models.common.findw_cpp(ver_sources, 'EM' , ' ,', 'ie'));

ver_src_em :=  __common__( ver_src_em_pos > 0);

ver_src_fdate_em :=  __common__( if(ver_src_em_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_em_pos), '0'));

ver_src_fdate_em2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_em)));

yr_ver_src_fdate_em :=  __common__( if(min(sysdate, ver_src_fdate_em2) = NULL, NULL, roundup((sysdate - ver_src_fdate_em2) / 365.25)));

mth_ver_src_fdate_em :=  __common__( if(min(sysdate, ver_src_fdate_em2) = NULL, NULL, roundup((sysdate - ver_src_fdate_em2) / 30.5)));

ver_src_cnt_em :=  __common__( if(ver_src_em_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_em_pos), 0));

ver_src_rcnt_23 :=  __common__( ver_src_rcnt_24 + ver_src_cnt_em);

ver_src_e1_pos :=  __common__( models.common.findw_cpp(ver_sources, 'E1' , ' ,', 'ie'));

ver_src_e1 :=  __common__( ver_src_e1_pos > 0);

ver_src_fdate_e1 :=  __common__( if(ver_src_e1_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_e1_pos), '0'));

ver_src_fdate_e12 :=  __common__( models.common.sas_date((string)(ver_src_fdate_e1)));

yr_ver_src_fdate_e1 :=  __common__( if(min(sysdate, ver_src_fdate_e12) = NULL, NULL, roundup((sysdate - ver_src_fdate_e12) / 365.25)));

mth_ver_src_fdate_e1 :=  __common__( if(min(sysdate, ver_src_fdate_e12) = NULL, NULL, roundup((sysdate - ver_src_fdate_e12) / 30.5)));

ver_src_cnt_e1 :=  __common__( if(ver_src_e1_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_e1_pos), 0));

ver_src_rcnt_22 :=  __common__( ver_src_rcnt_23 + ver_src_cnt_e1);

ver_src_e2_pos :=  __common__( models.common.findw_cpp(ver_sources, 'E2' , ' ,', 'ie'));

ver_src_e2 :=  __common__( ver_src_e2_pos > 0);

ver_src_fdate_e2 :=  __common__( if(ver_src_e2_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_e2_pos), '0'));

ver_src_fdate_e22 :=  __common__( models.common.sas_date((string)(ver_src_fdate_e2)));

yr_ver_src_fdate_e2 :=  __common__( if(min(sysdate, ver_src_fdate_e22) = NULL, NULL, roundup((sysdate - ver_src_fdate_e22) / 365.25)));

mth_ver_src_fdate_e2 :=  __common__( if(min(sysdate, ver_src_fdate_e22) = NULL, NULL, roundup((sysdate - ver_src_fdate_e22) / 30.5)));

ver_src_cnt_e2 :=  __common__( if(ver_src_e2_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_e2_pos), 0));

ver_src_rcnt_21 :=  __common__( ver_src_rcnt_22 + ver_src_cnt_e2);

ver_src_e3_pos :=  __common__( models.common.findw_cpp(ver_sources, 'E3' , ' ,', 'ie'));

ver_src_e3 :=  __common__( ver_src_e3_pos > 0);

ver_src_fdate_e3 :=  __common__( if(ver_src_e3_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_e3_pos), '0'));

ver_src_fdate_e32 :=  __common__( models.common.sas_date((string)(ver_src_fdate_e3)));

yr_ver_src_fdate_e3 :=  __common__( if(min(sysdate, ver_src_fdate_e32) = NULL, NULL, roundup((sysdate - ver_src_fdate_e32) / 365.25)));

mth_ver_src_fdate_e3 :=  __common__( if(min(sysdate, ver_src_fdate_e32) = NULL, NULL, roundup((sysdate - ver_src_fdate_e32) / 30.5)));

ver_src_cnt_e3 :=  __common__( if(ver_src_e3_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_e3_pos), 0));

ver_src_rcnt_20 :=  __common__( ver_src_rcnt_21 + ver_src_cnt_e3);

ver_src_e4_pos :=  __common__( models.common.findw_cpp(ver_sources, 'E4' , ' ,', 'ie'));

ver_src_e4 :=  __common__( ver_src_e4_pos > 0);

ver_src_fdate_e4 :=  __common__( if(ver_src_e4_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_e4_pos), '0'));

ver_src_fdate_e42 :=  __common__( models.common.sas_date((string)(ver_src_fdate_e4)));

yr_ver_src_fdate_e4 :=  __common__( if(min(sysdate, ver_src_fdate_e42) = NULL, NULL, roundup((sysdate - ver_src_fdate_e42) / 365.25)));

mth_ver_src_fdate_e4 :=  __common__( if(min(sysdate, ver_src_fdate_e42) = NULL, NULL, roundup((sysdate - ver_src_fdate_e42) / 30.5)));

ver_src_cnt_e4 :=  __common__( if(ver_src_e4_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_e4_pos), 0));

ver_src_rcnt_19 :=  __common__( ver_src_rcnt_20 + ver_src_cnt_e4);

ver_src_en_pos :=  __common__( models.common.findw_cpp(ver_sources, 'EN' , ' ,', 'ie'));

ver_src_en :=  __common__( ver_src_en_pos > 0);

ver_src_nas_en :=  __common__( if(ver_src_en_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_en_pos), 0));

ver_src_fdate_en :=  __common__( if(ver_src_en_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_en_pos), '0'));

ver_src_fdate_en2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_en)));

yr_ver_src_fdate_en :=  __common__( if(min(sysdate, ver_src_fdate_en2) = NULL, NULL, roundup((sysdate - ver_src_fdate_en2) / 365.25)));

mth_ver_src_fdate_en :=  __common__( if(min(sysdate, ver_src_fdate_en2) = NULL, NULL, roundup((sysdate - ver_src_fdate_en2) / 30.5)));

ver_src_cnt_en :=  __common__( if(ver_src_en_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_en_pos), 0));

ver_src_rcnt_18 :=  __common__( ver_src_rcnt_19 + ver_src_cnt_en);

ver_src_eq_pos :=  __common__( models.common.findw_cpp(ver_sources, 'EQ' , ' ,', 'ie'));

ver_src_eq :=  __common__( ver_src_eq_pos > 0);

ver_src_nas_eq :=  __common__( if(ver_src_eq_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_eq_pos), 0));

ver_src_fdate_eq :=  __common__( if(ver_src_eq_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_eq_pos), '0'));

ver_src_fdate_eq2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_eq)));

yr_ver_src_fdate_eq :=  __common__( if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, roundup((sysdate - ver_src_fdate_eq2) / 365.25)));

mth_ver_src_fdate_eq :=  __common__( if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, roundup((sysdate - ver_src_fdate_eq2) / 30.5)));

ver_src_cnt_eq :=  __common__( if(ver_src_eq_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_eq_pos), 0));

ver_src_rcnt_17 :=  __common__( ver_src_rcnt_18 + ver_src_cnt_eq);

ver_src_fe_pos :=  __common__( models.common.findw_cpp(ver_sources, 'FE' , ' ,', 'ie'));

ver_src_fe :=  __common__( ver_src_fe_pos > 0);

ver_src_fdate_fe :=  __common__( if(ver_src_fe_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_fe_pos), '0'));

ver_src_fdate_fe2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_fe)));

yr_ver_src_fdate_fe :=  __common__( if(min(sysdate, ver_src_fdate_fe2) = NULL, NULL, roundup((sysdate - ver_src_fdate_fe2) / 365.25)));

mth_ver_src_fdate_fe :=  __common__( if(min(sysdate, ver_src_fdate_fe2) = NULL, NULL, roundup((sysdate - ver_src_fdate_fe2) / 30.5)));

ver_src_cnt_fe :=  __common__( if(ver_src_fe_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_fe_pos), 0));

ver_src_rcnt_16 :=  __common__( ver_src_rcnt_17 + ver_src_cnt_fe);

ver_src_ff_pos :=  __common__( models.common.findw_cpp(ver_sources, 'FF' , ' ,', 'ie'));

ver_src_ff :=  __common__( ver_src_ff_pos > 0);

ver_src_fdate_ff :=  __common__( if(ver_src_ff_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_ff_pos), '0'));

ver_src_fdate_ff2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_ff)));

yr_ver_src_fdate_ff :=  __common__( if(min(sysdate, ver_src_fdate_ff2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ff2) / 365.25)));

mth_ver_src_fdate_ff :=  __common__( if(min(sysdate, ver_src_fdate_ff2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ff2) / 30.5)));

ver_src_cnt_ff :=  __common__( if(ver_src_ff_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_ff_pos), 0));

ver_src_rcnt_15 :=  __common__( ver_src_rcnt_16 + ver_src_cnt_ff);

ver_src_fr_pos :=  __common__( models.common.findw_cpp(ver_sources, 'FR' , ' ,', 'ie'));

ver_src_fr :=  __common__( ver_src_fr_pos > 0);

ver_src_fdate_fr :=  __common__( if(ver_src_fr_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_fr_pos), '0'));

ver_src_fdate_fr2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_fr)));

yr_ver_src_fdate_fr :=  __common__( if(min(sysdate, ver_src_fdate_fr2) = NULL, NULL, roundup((sysdate - ver_src_fdate_fr2) / 365.25)));

mth_ver_src_fdate_fr :=  __common__( if(min(sysdate, ver_src_fdate_fr2) = NULL, NULL, roundup((sysdate - ver_src_fdate_fr2) / 30.5)));

ver_src_cnt_fr :=  __common__( if(ver_src_fr_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_fr_pos), 0));

ver_src_rcnt_14 :=  __common__( ver_src_rcnt_15 + ver_src_cnt_fr);

ver_src_l2_pos :=  __common__( models.common.findw_cpp(ver_sources, 'L2' , ' ,', 'ie'));

ver_src_l2 :=  __common__( ver_src_l2_pos > 0);

ver_src_fdate_l2 :=  __common__( if(ver_src_l2_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_l2_pos), '0'));

ver_src_fdate_l22 :=  __common__( models.common.sas_date((string)(ver_src_fdate_l2)));

yr_ver_src_fdate_l2 :=  __common__( if(min(sysdate, ver_src_fdate_l22) = NULL, NULL, roundup((sysdate - ver_src_fdate_l22) / 365.25)));

mth_ver_src_fdate_l2 :=  __common__( if(min(sysdate, ver_src_fdate_l22) = NULL, NULL, roundup((sysdate - ver_src_fdate_l22) / 30.5)));

ver_src_cnt_l2 :=  __common__( if(ver_src_l2_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_l2_pos), 0));

ver_src_rcnt_13 :=  __common__( ver_src_rcnt_14 + ver_src_cnt_l2);

ver_src_li_pos :=  __common__( models.common.findw_cpp(ver_sources, 'LI' , ' ,', 'ie'));

ver_src_li :=  __common__( ver_src_li_pos > 0);

ver_src_fdate_li :=  __common__( if(ver_src_li_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_li_pos), '0'));

ver_src_fdate_li2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_li)));

yr_ver_src_fdate_li :=  __common__( if(min(sysdate, ver_src_fdate_li2) = NULL, NULL, roundup((sysdate - ver_src_fdate_li2) / 365.25)));

mth_ver_src_fdate_li :=  __common__( if(min(sysdate, ver_src_fdate_li2) = NULL, NULL, roundup((sysdate - ver_src_fdate_li2) / 30.5)));

ver_src_cnt_li :=  __common__( if(ver_src_li_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_li_pos), 0));

ver_src_rcnt_12 :=  __common__( ver_src_rcnt_13 + ver_src_cnt_li);

ver_src_mw_pos :=  __common__( models.common.findw_cpp(ver_sources, 'MW' , ' ,', 'ie'));

ver_src_mw :=  __common__( ver_src_mw_pos > 0);

ver_src_fdate_mw :=  __common__( if(ver_src_mw_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_mw_pos), '0'));

ver_src_fdate_mw2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_mw)));

yr_ver_src_fdate_mw :=  __common__( if(min(sysdate, ver_src_fdate_mw2) = NULL, NULL, roundup((sysdate - ver_src_fdate_mw2) / 365.25)));

mth_ver_src_fdate_mw :=  __common__( if(min(sysdate, ver_src_fdate_mw2) = NULL, NULL, roundup((sysdate - ver_src_fdate_mw2) / 30.5)));

ver_src_cnt_mw :=  __common__( if(ver_src_mw_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_mw_pos), 0));

ver_src_rcnt_11 :=  __common__( ver_src_rcnt_12 + ver_src_cnt_mw);

ver_src_nt_pos :=  __common__( models.common.findw_cpp(ver_sources, 'NT' , ' ,', 'ie'));

ver_src_nt :=  __common__( ver_src_nt_pos > 0);

ver_src_fdate_nt :=  __common__( if(ver_src_nt_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_nt_pos), '0'));

ver_src_fdate_nt2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_nt)));

yr_ver_src_fdate_nt :=  __common__( if(min(sysdate, ver_src_fdate_nt2) = NULL, NULL, roundup((sysdate - ver_src_fdate_nt2) / 365.25)));

mth_ver_src_fdate_nt :=  __common__( if(min(sysdate, ver_src_fdate_nt2) = NULL, NULL, roundup((sysdate - ver_src_fdate_nt2) / 30.5)));

ver_src_cnt_nt :=  __common__( if(ver_src_nt_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_nt_pos), 0));

ver_src_rcnt_10 :=  __common__( ver_src_rcnt_11 + ver_src_cnt_nt);

ver_src_p_pos :=  __common__( models.common.findw_cpp(ver_sources, 'P' , ' ,', 'ie'));

ver_src_p :=  __common__( ver_src_p_pos > 0);

ver_src_nas_p :=  __common__( if(ver_src_p_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_p_pos), 0));

ver_src_fdate_p :=  __common__( if(ver_src_p_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_p_pos), '0'));

ver_src_fdate_p2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_p)));

yr_ver_src_fdate_p :=  __common__( if(min(sysdate, ver_src_fdate_p2) = NULL, NULL, roundup((sysdate - ver_src_fdate_p2) / 365.25)));

mth_ver_src_fdate_p :=  __common__( if(min(sysdate, ver_src_fdate_p2) = NULL, NULL, roundup((sysdate - ver_src_fdate_p2) / 30.5)));

ver_src_cnt_p :=  __common__( if(ver_src_p_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_p_pos), 0));

ver_src_rcnt_9 :=  __common__( ver_src_rcnt_10 + ver_src_cnt_p);

ver_src_pl_pos :=  __common__( models.common.findw_cpp(ver_sources, 'PL' , ' ,', 'ie'));

ver_src_pl :=  __common__( ver_src_pl_pos > 0);

ver_src_fdate_pl :=  __common__( if(ver_src_pl_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_pl_pos), '0'));

ver_src_fdate_pl2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_pl)));

yr_ver_src_fdate_pl :=  __common__( if(min(sysdate, ver_src_fdate_pl2) = NULL, NULL, roundup((sysdate - ver_src_fdate_pl2) / 365.25)));

mth_ver_src_fdate_pl :=  __common__( if(min(sysdate, ver_src_fdate_pl2) = NULL, NULL, roundup((sysdate - ver_src_fdate_pl2) / 30.5)));

ver_src_cnt_pl :=  __common__( if(ver_src_pl_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_pl_pos), 0));

ver_src_rcnt_8 :=  __common__( ver_src_rcnt_9 + ver_src_cnt_pl);

ver_src_ts_pos :=  __common__( models.common.findw_cpp(ver_sources, 'TS' , ' ,', 'ie'));

ver_src_ts :=  __common__( ver_src_ts_pos > 0);

ver_src_fdate_ts :=  __common__( if(ver_src_ts_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_ts_pos), '0'));

ver_src_fdate_ts2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_ts)));

yr_ver_src_fdate_ts :=  __common__( if(min(sysdate, ver_src_fdate_ts2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ts2) / 365.25)));

mth_ver_src_fdate_ts :=  __common__( if(min(sysdate, ver_src_fdate_ts2) = NULL, NULL, roundup((sysdate - ver_src_fdate_ts2) / 30.5)));

ver_src_cnt_ts :=  __common__( if(ver_src_ts_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_ts_pos), 0));

ver_src_rcnt_7 :=  __common__( ver_src_rcnt_8 + ver_src_cnt_ts);

ver_src_tu_pos :=  __common__( models.common.findw_cpp(ver_sources, 'TU' , ' ,', 'ie'));

ver_src_tu :=  __common__( ver_src_tu_pos > 0);

ver_src_fdate_tu :=  __common__( if(ver_src_tu_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_tu_pos), '0'));

ver_src_fdate_tu2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_tu)));

yr_ver_src_fdate_tu :=  __common__( if(min(sysdate, ver_src_fdate_tu2) = NULL, NULL, roundup((sysdate - ver_src_fdate_tu2) / 365.25)));

mth_ver_src_fdate_tu :=  __common__( if(min(sysdate, ver_src_fdate_tu2) = NULL, NULL, roundup((sysdate - ver_src_fdate_tu2) / 30.5)));

ver_src_cnt_tu :=  __common__( if(ver_src_tu_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_tu_pos), 0));

ver_src_rcnt_6 :=  __common__( ver_src_rcnt_7 + ver_src_cnt_tu);

ver_src_sl_pos :=  __common__( models.common.findw_cpp(ver_sources, 'SL' , ' ,', 'ie'));

ver_src_sl :=  __common__( ver_src_sl_pos > 0);

ver_src_fdate_sl :=  __common__( if(ver_src_sl_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_sl_pos), '0'));

ver_src_fdate_sl2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_sl)));

yr_ver_src_fdate_sl :=  __common__( if(min(sysdate, ver_src_fdate_sl2) = NULL, NULL, roundup((sysdate - ver_src_fdate_sl2) / 365.25)));

mth_ver_src_fdate_sl :=  __common__( if(min(sysdate, ver_src_fdate_sl2) = NULL, NULL, roundup((sysdate - ver_src_fdate_sl2) / 30.5)));

ver_src_cnt_sl :=  __common__( if(ver_src_sl_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_sl_pos), 0));

ver_src_rcnt_5 :=  __common__( ver_src_rcnt_6 + ver_src_cnt_sl);

ver_src_v_pos :=  __common__( models.common.findw_cpp(ver_sources, 'V' , ' ,', 'ie'));

ver_src_v :=  __common__( ver_src_v_pos > 0);

ver_src_fdate_v :=  __common__( if(ver_src_v_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_v_pos), '0'));

ver_src_fdate_v2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_v)));

yr_ver_src_fdate_v :=  __common__( if(min(sysdate, ver_src_fdate_v2) = NULL, NULL, roundup((sysdate - ver_src_fdate_v2) / 365.25)));

mth_ver_src_fdate_v :=  __common__( if(min(sysdate, ver_src_fdate_v2) = NULL, NULL, roundup((sysdate - ver_src_fdate_v2) / 30.5)));

ver_src_cnt_v :=  __common__( if(ver_src_v_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_v_pos), 0));

ver_src_rcnt_4 :=  __common__( ver_src_rcnt_5 + ver_src_cnt_v);

ver_src_vo_pos :=  __common__( models.common.findw_cpp(ver_sources, 'VO' , ' ,', 'ie'));

ver_src_vo :=  __common__( ver_src_vo_pos > 0);

ver_src_fdate_vo :=  __common__( if(ver_src_vo_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_vo_pos), '0'));

ver_src_fdate_vo2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_vo)));

yr_ver_src_fdate_vo :=  __common__( if(min(sysdate, ver_src_fdate_vo2) = NULL, NULL, roundup((sysdate - ver_src_fdate_vo2) / 365.25)));

mth_ver_src_fdate_vo :=  __common__( if(min(sysdate, ver_src_fdate_vo2) = NULL, NULL, roundup((sysdate - ver_src_fdate_vo2) / 30.5)));

ver_src_cnt_vo :=  __common__( if(ver_src_vo_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_vo_pos), 0));

ver_src_rcnt_3 :=  __common__( ver_src_rcnt_4 + ver_src_cnt_vo);

ver_src_w_pos :=  __common__( models.common.findw_cpp(ver_sources, 'W' , ' ,', 'ie'));

ver_src_w :=  __common__( ver_src_w_pos > 0);

ver_src_fdate_w :=  __common__( if(ver_src_w_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_w_pos), '0'));

ver_src_fdate_w2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_w)));

yr_ver_src_fdate_w :=  __common__( if(min(sysdate, ver_src_fdate_w2) = NULL, NULL, roundup((sysdate - ver_src_fdate_w2) / 365.25)));

mth_ver_src_fdate_w :=  __common__( if(min(sysdate, ver_src_fdate_w2) = NULL, NULL, roundup((sysdate - ver_src_fdate_w2) / 30.5)));

ver_src_cnt_w :=  __common__( if(ver_src_w_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_w_pos), 0));

ver_src_rcnt_2 :=  __common__( ver_src_rcnt_3 + ver_src_cnt_w);

ver_src_wp_pos :=  __common__( models.common.findw_cpp(ver_sources, 'WP' , ' ,', 'ie'));

ver_src_wp :=  __common__( ver_src_wp_pos > 0);

ver_src_fdate_wp :=  __common__( if(ver_src_wp_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_wp_pos), '0'));

ver_src_fdate_wp2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_wp)));

yr_ver_src_fdate_wp :=  __common__( if(min(sysdate, ver_src_fdate_wp2) = NULL, NULL, roundup((sysdate - ver_src_fdate_wp2) / 365.25)));

mth_ver_src_fdate_wp :=  __common__( if(min(sysdate, ver_src_fdate_wp2) = NULL, NULL, roundup((sysdate - ver_src_fdate_wp2) / 30.5)));

ver_src_cnt_wp :=  __common__( if(ver_src_wp_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_wp_pos), 0));

ver_src_rcnt_1 :=  __common__( ver_src_rcnt_2 + ver_src_cnt_wp);

ver_src_tn_pos :=  __common__( models.common.findw_cpp(ver_sources, 'TN' , ' ,', 'ie'));

ver_src_tn :=  __common__( ver_src_tn_pos > 0);

ver_src_nas_tn :=  __common__( if(ver_src_tn_pos > 0, (real)models.common.getw(ver_sources_NAS, ver_src_tn_pos), 0));

ver_src_fdate_tn :=  __common__( if(ver_src_tn_pos > 0, models.common.getw(ver_sources_first_seen, ver_src_tn_pos), '0'));

ver_src_fdate_tn2 :=  __common__( models.common.sas_date((string)(ver_src_fdate_tn)));

yr_ver_src_fdate_tn :=  __common__( if(min(sysdate, ver_src_fdate_tn2) = NULL, NULL, roundup((sysdate - ver_src_fdate_tn2) / 365.25)));

mth_ver_src_fdate_tn :=  __common__( if(min(sysdate, ver_src_fdate_tn2) = NULL, NULL, roundup((sysdate - ver_src_fdate_tn2) / 30.5)));

ver_src_cnt_tn :=  __common__( if(ver_src_tn_pos > 0, (real)models.common.getw(ver_sources_count, ver_src_tn_pos), 0));

ver_src_rcnt :=  __common__( ver_src_rcnt_1 + ver_src_cnt_tn);

bus_addr_src_cnt :=  __common__( models.common.countw((string)(bus_addr_sources), ' !$%&()*+,-./);<^|'));

bus_addr_src_pop :=  __common__( bus_addr_src_cnt > 0);

bus_addr_src_fsrc :=  __common__( models.common.getw(bus_addr_sources, 1));

bus_addr_src_bb_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'BB' , ' ,', 'ie'));

bus_addr_src_bb :=  __common__( bus_addr_src_bb_pos > 0);

bus_addr_src_bk_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'BK' , ' ,', 'ie'));

bus_addr_src_bk :=  __common__( bus_addr_src_bk_pos > 0);

bus_addr_src_br_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'BR' , ' ,', 'ie'));

bus_addr_src_br :=  __common__( bus_addr_src_br_pos > 0);

bus_addr_src_cp_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'CP' , ' ,', 'ie'));

bus_addr_src_cp :=  __common__( bus_addr_src_cp_pos > 0);

bus_addr_src_db_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'DB' , ' ,', 'ie'));

bus_addr_src_db :=  __common__( bus_addr_src_db_pos > 0);

bus_addr_src_dl_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'DL' , ' ,', 'ie'));

bus_addr_src_dl :=  __common__( bus_addr_src_dl_pos > 0);

bus_addr_src_er_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'ER' , ' ,', 'ie'));

bus_addr_src_er :=  __common__( bus_addr_src_er_pos > 0);

bus_addr_src_ev_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'EV' , ' ,', 'ie'));

bus_addr_src_ev :=  __common__( bus_addr_src_ev_pos > 0);

bus_addr_src_fa_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'FA' , ' ,', 'ie'));

bus_addr_src_fa :=  __common__( bus_addr_src_fa_pos > 0);

bus_addr_src_fb_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'FB' , ' ,', 'ie'));

bus_addr_src_fb :=  __common__( bus_addr_src_fb_pos > 0);

bus_addr_src_gb_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'GB' , ' ,', 'ie'));

bus_addr_src_gb :=  __common__( bus_addr_src_gb_pos > 0);

bus_addr_src_ia_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'IA' , ' ,', 'ie'));

bus_addr_src_ia :=  __common__( bus_addr_src_ia_pos > 0);

bus_addr_src_ir_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'IR' , ' ,', 'ie'));

bus_addr_src_ir :=  __common__( bus_addr_src_ir_pos > 0);

bus_addr_src_ji_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'JI' , ' ,', 'ie'));

bus_addr_src_ji :=  __common__( bus_addr_src_ji_pos > 0);

bus_addr_src_ml_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'ML' , ' ,', 'ie'));

bus_addr_src_ml :=  __common__( bus_addr_src_ml_pos > 0);

bus_addr_src_np_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'NP' , ' ,', 'ie'));

bus_addr_src_np :=  __common__( bus_addr_src_np_pos > 0);

bus_addr_src_os_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'OS' , ' ,', 'ie'));

bus_addr_src_os :=  __common__( bus_addr_src_os_pos > 0);

bus_addr_src_pl_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'PL' , ' ,', 'ie'));

bus_addr_src_pl :=  __common__( bus_addr_src_pl_pos > 0);

bus_addr_src_pr_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'PR' , ' ,', 'ie'));

bus_addr_src_pr :=  __common__( bus_addr_src_pr_pos > 0);

bus_addr_src_l2_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'L2' , ' ,', 'ie'));

bus_addr_src_l2 :=  __common__( bus_addr_src_l2_pos > 0);

bus_addr_src_ll_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'LL' , ' ,', 'ie'));

bus_addr_src_ll :=  __common__( bus_addr_src_ll_pos > 0);

bus_addr_src_rb_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'RB' , ' ,', 'ie'));

bus_addr_src_rb :=  __common__( bus_addr_src_rb_pos > 0);

bus_addr_src_sk_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'SK' , ' ,', 'ie'));

bus_addr_src_sk :=  __common__( bus_addr_src_sk_pos > 0);

bus_addr_src_sp_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'SP' , ' ,', 'ie'));

bus_addr_src_sp :=  __common__( bus_addr_src_sp_pos > 0);

bus_addr_src_st_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'ST' , ' ,', 'ie'));

bus_addr_src_st :=  __common__( bus_addr_src_st_pos > 0);

bus_addr_src_u2_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'U2' , ' ,', 'ie'));

bus_addr_src_u2 :=  __common__( bus_addr_src_u2_pos > 0);

bus_addr_src_ut_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'UT' , ' ,', 'ie'));

bus_addr_src_ut :=  __common__( bus_addr_src_ut_pos > 0);

bus_addr_src_ve_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'VE' , ' ,', 'ie'));

bus_addr_src_ve :=  __common__( bus_addr_src_ve_pos > 0);

bus_addr_src_vi_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'VI' , ' ,', 'ie'));

bus_addr_src_vi :=  __common__( bus_addr_src_vi_pos > 0);

bus_addr_src_wc_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'WC' , ' ,', 'ie'));

bus_addr_src_wc :=  __common__( bus_addr_src_wc_pos > 0);

bus_addr_src_wi_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'WI' , ' ,', 'ie'));

bus_addr_src_wi :=  __common__( bus_addr_src_wi_pos > 0);

bus_addr_src_xx_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'XX' , ' ,', 'ie'));

bus_addr_src_xx :=  __common__( bus_addr_src_xx_pos > 0);

bus_addr_src_yp_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'YP' , ' ,', 'ie'));

bus_addr_src_yp :=  __common__( bus_addr_src_yp_pos > 0);

bus_addr_src_zm_pos :=  __common__( models.common.findw_cpp(bus_addr_sources, 'ZM' , ' ,', 'ie'));

bus_addr_src_zm :=  __common__( bus_addr_src_zm_pos > 0);

email_src_cnt :=  __common__( models.common.countw((string)(email_source_list), ' !$%&()*+,-./);<^|'));

email_src_pop :=  __common__( email_src_cnt > 0);

email_src_fsrc :=  __common__( models.common.getw(email_source_list, 1));

email_src_aw_pos :=  __common__( models.common.findw_cpp(email_source_list, 'AW' , ' ,', 'ie'));

email_src_aw :=  __common__( email_src_aw_pos > 0);

email_src_et_pos :=  __common__( models.common.findw_cpp(email_source_list, 'ET' , ' ,', 'ie'));

email_src_et :=  __common__( email_src_et_pos > 0);

email_src_im_pos :=  __common__( models.common.findw_cpp(email_source_list, 'IM' , ' ,', 'ie'));

email_src_im :=  __common__( email_src_im_pos > 0);

email_src_wa_pos :=  __common__( models.common.findw_cpp(email_source_list, 'W@' , ' ,', 'ie'));

email_src_wa :=  __common__( email_src_wa_pos > 0);

email_src_om_pos :=  __common__( models.common.findw_cpp(email_source_list, 'OM' , ' ,', 'ie'));

email_src_om :=  __common__( email_src_om_pos > 0);

email_src_m1_pos :=  __common__( models.common.findw_cpp(email_source_list, 'M1' , ' ,', 'ie'));

email_src_m1 :=  __common__( email_src_m1_pos > 0);

_derog :=  __common__( felony_count > 0 or (integer)addrs_prison_history > 0 or attr_num_unrel_liens60 > 0 or attr_eviction_count > 0 or impulse_count > 0);

credit_source_cnt :=  __common__( if(max((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu) = NULL, NULL, sum((integer)ver_src_eq, (integer)ver_src_en, (integer)ver_src_tn, (integer)ver_src_tu)));

bureauonly2 :=  __common__( credit_source_cnt > 0 and credit_source_cnt = ver_src_cnt and (StringLib.StringToUpperCase(nap_type) = 'U' or (nap_summary in [0, 1, 2, 3, 4, 6])));

ssnpop :=  __common__( (unsigned1)ssnlength > 0);

uv_segment3 :=  __common__( map(
    not ssnpop                                                                                                     => '0-noSSN',
    (integer)ver_src_ds = 1 or rc_decsflag = (string)1 or rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1 => '1-ssnprob',
    (nas_summary in [4, 7, 9])                                                                                     => '2-nas479',
    nap_summary <= 4 and nas_summary <= 4 or ver_src_cnt = 0                                                       => '3-newdid',
    bureauonly2                                                                                                    => '4-bureauonly',
    _derog                                                                                                         => '5-derog',
    Inq_count03 > 0                                                                                                => '6-recentActivity',
                                                                                                                      '7-other'));

_infutor_nap :=  __common__( map(
	infutor_nap = 12 => 1,
	infutor_nap >  0 => 3,
	2
));
ssn_lowissue_age :=  __common__( if( in_dob2 != NULL and rc_ssnlowissue2 != NULL, (rc_ssnlowissue2 - in_dob2)/365.2, NULL ));
_nas :=  __common__( map(
	nas_summary = 12 => 1,
	nas_summary = 11 => 2,
	nas_summary =  0 => 4,
	nas_summary in [4,7,9] => 5,
	nas_summary =  1 => 6,
	3
));

// add2_building_area2        :=  __common__( if( add2_building_area       = 0, NULL, add2_building_area      ));
// add2_no_of_buildings2      :=  __common__( if( add2_no_of_buildings     = 0, NULL, add2_no_of_buildings    ));
// add2_no_of_stories2        :=  __common__( if( add2_no_of_stories       = 0, NULL, add2_no_of_stories      ));
// add2_no_of_rooms2          :=  __common__( if( add2_no_of_rooms         = 0, NULL, add2_no_of_rooms        ));
add2_no_of_bedrooms2       :=  __common__( if( add2_no_of_bedrooms      = 0, NULL, add2_no_of_bedrooms     ));
// add2_no_of_baths2          :=  __common__( if( add2_no_of_baths         = 0, NULL, add2_no_of_baths        ));
// add2_no_of_partial_baths2  :=  __common__( if( add2_no_of_partial_baths = 0, NULL, add2_no_of_partial_baths));
// add2_parking_no_of_cars2   :=  __common__( if( add2_parking_no_of_cars  = 0, NULL, add2_parking_no_of_cars ));

add1_building_area2        :=  __common__( if( add1_building_area       = '0', NULL, (unsigned)add1_building_area      ));
// add1_no_of_buildings2      :=  __common__( if( add1_no_of_buildings     = 0, NULL, add1_no_of_buildings    ));
// add1_no_of_stories2        :=  __common__( if( add1_no_of_stories       = 0, NULL, add1_no_of_stories      ));
// add1_no_of_rooms2          :=  __common__( if( add1_no_of_rooms         = 0, NULL, add1_no_of_rooms        ));
add1_no_of_bedrooms2       :=  __common__( if( add1_no_of_bedrooms      = 0, NULL, add1_no_of_bedrooms     ));
add1_no_of_baths2          :=  __common__( if( add1_no_of_baths         = 0, NULL, add1_no_of_baths        ));
// add1_no_of_partial_baths2  :=  __common__( if( add1_no_of_partial_baths = 0, NULL, add1_no_of_partial_baths));
// add1_parking_no_of_cars2   :=  __common__( if( add1_parking_no_of_cars  = 0, NULL, add1_parking_no_of_cars ));

add1_avm_med :=  __common__( map(
    ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
    ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
                              ADD1_AVM_MED_FIPS));

add2_avm_med :=  __common__( map(
	add2_AVM_MED_GEO12  > 0 => add2_AVM_MED_GEO12,
	add2_AVM_MED_GEO11  > 0 => add2_AVM_MED_GEO11,
	add2_AVM_MED_FIPS
));
add1_avm_to_med_ratio :=  __common__( if( add1_avm_automated_valuation>0 and add1_AVM_MED>0, add1_avm_automated_valuation/add1_AVM_MED, NULL ));
add2_avm_to_med_ratio :=  __common__( if( add2_avm_automated_valuation>0 and add2_AVM_MED>0, add2_avm_automated_valuation/add2_AVM_MED, NULL ));



// ********** Verification - Utility **********);
_util_adl_nap :=  __common__( map(
	util_adl_nap=12 => 1,
	util_adl_nap=11 => 2,
	util_adl_nap=0  => 4,
	util_adl_nap=6  => 5,
	util_adl_nap=1  => 6,
	3
));

_adl_score :=  __common__( map(
	adl_score>100 => NULL,
	adl_score=100 => 1,
	adl_score>80  => 2,
	adl_score>50  => 3,
	4
));

_ams_level :=  __common__( map(
	ams_college_code='1' => 1,
	ams_college_code='4' => 2,
	ams_college_code='2' => 3,
	4
));

// _ams_college_tier :=  __common__( case( (unsigned1)ams_college_tier,
	// 0 => 4,
	// 1 => 1,
	// 2 => 2,
	// 3 => 3,
	// 4 => 4,
	// 5 => 5,
	// 6 => 6,
	// -1
// ));
_ams_college_tier :=  __common__( case( ams_college_tier,
	'0' => 4,
	'1' => 1,
	'2' => 2,
	'3' => 3,
	'4' => 4,
	'5' => 5,
	'6' => 6,
	-1
));



//*******************************************************************************************************//
// begin code for no SSN segment models
//*******************************************************************************************************//
add_bestmatch_level :=  __common__( map(
    add1_isbestmatch => 0,
    add2_isbestmatch => 2,
                        1));

_nap :=  __common__( map(
    nap_summary = 12 => 1,
    nap_summary = 11 => 2,
    nap_summary = 0  => 4,
    nap_summary = 6  => 5,
    nap_summary = 1  => 6,
                        3));

ver_positive_src_cnt :=  __common__( min(6, sum(ver_src_AM, ver_src_AR, ver_src_DL, ver_src_EB, ver_src_EM, ver_src_E1, ver_src_E2, ver_src_E3, ver_src_E4, ver_src_EN, ver_src_EQ, ver_src_FE, ver_src_FF, ver_src_P, ver_src_PL, ver_src_TS, ver_src_TU, ver_src_SL, ver_src_V, ver_src_VO, ver_src_W, ver_src_WP)));

_addrcount :=  __common__( min(3, if(rc_addrcount = NULL, -NULL, rc_addrcount)));

prop_owned_flag :=  __common__( property_owned_total > 0);

prop_sold_flag :=  __common__( property_sold_total > 0);

_prop_owner :=  __common__( map(
    add1_naprop = 4 and prop_owned_flag and add1_family_owned                          => 0,
    add1_naprop = 4 and prop_owned_flag                                                => 1,
    add1_naprop = 4 or (add1_naprop in [3, 0]) and (prop_owned_flag or prop_sold_flag) => 2,
    add1_naprop = 3 or prop_owned_flag or prop_sold_flag                               => 3,
    add1_naprop = 2                                                                    => 3,
    add1_naprop = 0                                                                    => 4,
                                                                                          5));

_addr_score :=  __common__( map(
    combo_addrscore > 100 => -1,
    combo_addrscore = 100 => 1,
    combo_addrscore > 80  => 2,
                             3));

_phone_score :=  __common__( map(
    combo_hphonescore > 100 => -1,
    combo_hphonescore = 100 => 1,
    combo_hphonescore > 80  => 2,
                               3));

_email_domain_free_count :=  __common__( min(4, if(email_domain_Free_count = NULL, -NULL, email_domain_Free_count)));

_adls_per_addr :=  __common__( min(8, if(adls_per_addr = NULL, -NULL, adls_per_addr)));

_ssns_per_adl_c6 :=  __common__( min(2, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6)));

_phones_per_adl_c6 :=  __common__( min(2, if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6)));

_ssns_per_addr_c6 :=  __common__( min(3, if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6)));

_inq_count03 :=  __common__( min(5, if(Inq_count03 = NULL, -NULL, Inq_count03)));

_inq_collection :=  __common__( min(5, if(Inq_Collection_count = NULL, -NULL, Inq_Collection_count)));

_inq_peraddr :=  __common__( min(5, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr)));

_ams_income_level :=  __common__( map(
    StringLib.StringToUpperCase(ams_income_level_code) = 'A' => 11,
    StringLib.StringToUpperCase(ams_income_level_code) = 'B' => 10,
    StringLib.StringToUpperCase(ams_income_level_code) = 'C' => 9,
    StringLib.StringToUpperCase(ams_income_level_code) = 'D' => 8,
    StringLib.StringToUpperCase(ams_income_level_code) = 'E' => 7,
    StringLib.StringToUpperCase(ams_income_level_code) = 'F' => 6,
    StringLib.StringToUpperCase(ams_income_level_code) = 'G' => 5,
    StringLib.StringToUpperCase(ams_income_level_code) = 'H' => 4,
    StringLib.StringToUpperCase(ams_income_level_code) = 'I' => 3,
    StringLib.StringToUpperCase(ams_income_level_code) = 'J' => 2,
    StringLib.StringToUpperCase(ams_income_level_code) = 'K' => 1,
                                                                -1));

_wealth_index :=  __common__( min(4, if(wealth_index = '', -NULL, (unsigned1)wealth_index)));

_addr_stability_v2 :=  __common__( max(0, min(6, if(addr_stability_v2 = '', -NULL, (unsigned1)addr_stability_v2))));

_crim_rel_within25miles :=  __common__( min(4, if(crim_rel_within25miles = NULL, -NULL, crim_rel_within25miles)));

add1_lres_b :=  __common__( map(
    (add1_lres in [NULL, 0]) => -1,
    add1_lres <= 4           => 5,
    add1_lres <= 10          => 4,
    add1_lres <= 17          => 3,
    add1_lres <= 24          => 2,
                                1));

add1_lres_b_m :=  __common__( map(
    add1_lres_b = -1 => 0.1043016314,
    add1_lres_b = 1  => 0.0054916564,
    add1_lres_b = 2  => 0.0065279532,
    add1_lres_b = 3  => 0.0069872438,
    add1_lres_b = 4  => 0.0087460775,
    add1_lres_b = 5  => 0.0191184069,
                        0.0127226851));

c_urban_p_b :=  __common__( map(
    (C_URBAN_P in ['', '0', '-1']) => -1,
    (real)C_URBAN_P <= 64.5      => 1,
    (real)C_URBAN_P <= 95        => 2,
    (real)C_URBAN_P <= 99.9      => 3,
                                      4));

c_urban_p_b_m :=  __common__( map(
    c_urban_p_b = -1 => 0.0066257031,
    c_urban_p_b = 1  => 0.0060247906,
    c_urban_p_b = 2  => 0.0071339693,
    c_urban_p_b = 3  => 0.0080679108,
    c_urban_p_b = 4  => 0.0156163355,
                        0.0127226851));

c_fammar_p_b :=  __common__( map(
    (C_FAMMAR_P in ['', '0', '-1']) => -1,
    (real)C_FAMMAR_P <= 62.8      => 8,
    (real)C_FAMMAR_P <= 71.1      => 7,
    (real)C_FAMMAR_P <= 76.1      => 6,
    (real)C_FAMMAR_P <= 79.6      => 5,
    (real)C_FAMMAR_P <= 82.6      => 4,
    (real)C_FAMMAR_P <= 85.2      => 3,
    (real)C_FAMMAR_P <= 87.6      => 2,
                                       1));

c_fammar_p_b_m :=  __common__( map(
    c_fammar_p_b = -1 => 0.024771999,
    c_fammar_p_b = 1  => 0.0063879497,
    c_fammar_p_b = 2  => 0.0071072305,
    c_fammar_p_b = 3  => 0.0074680502,
    c_fammar_p_b = 4  => 0.0091786622,
    c_fammar_p_b = 5  => 0.0106255106,
    c_fammar_p_b = 6  => 0.0130010347,
    c_fammar_p_b = 7  => 0.0185792475,
    c_fammar_p_b = 8  => 0.0409597287,
                         0.0127226851));

c_ownocc_p_b :=  __common__( map(
    (C_OWNOCC_P in ['', '0', '-1']) => -1,
    (real)C_OWNOCC_P <= 30.6      => 10,
    (real)C_OWNOCC_P <= 47.1      => 9,
    (real)C_OWNOCC_P <= 58.4      => 8,
    (real)C_OWNOCC_P <= 66.9      => 7,
    (real)C_OWNOCC_P <= 73.4      => 6,
    (real)C_OWNOCC_P <= 78.7      => 5,
    (real)C_OWNOCC_P <= 83.7      => 4,
    (real)C_OWNOCC_P <= 88.2      => 3,
    (real)C_OWNOCC_P <= 92.8      => 2,
                                     1));

c_ownocc_p_b_m :=  __common__( map(
    c_ownocc_p_b = -1 => 0.0334949495,
    c_ownocc_p_b = 1  => 0.0064137221,
    c_ownocc_p_b = 2  => 0.0067184584,
    c_ownocc_p_b = 3  => 0.0070896391,
    c_ownocc_p_b = 4  => 0.0073761319,
    c_ownocc_p_b = 5  => 0.0084063027,
    c_ownocc_p_b = 6  => 0.0093509129,
    c_ownocc_p_b = 7  => 0.0112101505,
    c_ownocc_p_b = 8  => 0.0136547104,
    c_ownocc_p_b = 9  => 0.0199561517,
    c_ownocc_p_b = 10 => 0.0341022668,
                         0.0127226851));

c_bigapt_p_b :=  __common__( map(
    (C_BIGAPT_P in ['', '0', '-1']) => -1,
    (real)C_BIGAPT_P <= 1         => 1,
    (real)C_BIGAPT_P <= 1.9       => 2,
    (real)C_BIGAPT_P <= 3.2       => 3,
    (real)C_BIGAPT_P <= 7.7       => 4,
    (real)C_BIGAPT_P <= 11.4      => 5,
    (real)C_BIGAPT_P <= 16.9      => 6,
    (real)C_BIGAPT_P <= 25.7      => 7,
    (real)C_BIGAPT_P <= 44.4      => 8,
                                     9));

c_bigapt_p_b_m :=  __common__( map(
    c_bigapt_p_b = -1 => 0.0095453003,
    c_bigapt_p_b = 1  => 0.0078435572,
    c_bigapt_p_b = 2  => 0.011800388,
    c_bigapt_p_b = 3  => 0.0124695981,
    c_bigapt_p_b = 4  => 0.0133244764,
    c_bigapt_p_b = 5  => 0.014858114,
    c_bigapt_p_b = 6  => 0.0166269867,
    c_bigapt_p_b = 7  => 0.0194925266,
    c_bigapt_p_b = 8  => 0.0235134612,
    c_bigapt_p_b = 9  => 0.0345915188,
                         0.0127226851));

c_highrent_b :=  __common__( map(
    (C_HIGHRENT in ['', '0', '-1']) => -1,
    (real)C_HIGHRENT <= 2.2       => 8,
    (real)C_HIGHRENT <= 3.9       => 7,
    (real)C_HIGHRENT <= 6.4       => 6,
    (real)C_HIGHRENT <= 13.9      => 5,
    (real)C_HIGHRENT <= 28.9      => 4,
    (real)C_HIGHRENT <= 41.6      => 3,
    (real)C_HIGHRENT <= 60.5      => 2,
                                       1));

c_highrent_b_m :=  __common__( map(
    c_highrent_b = -1 => 0.0130601995,
    c_highrent_b = 1  => 0.0074468673,
    c_highrent_b = 2  => 0.0086084536,
    c_highrent_b = 3  => 0.0093394119,
    c_highrent_b = 4  => 0.009968212,
    c_highrent_b = 5  => 0.0112590608,
    c_highrent_b = 6  => 0.0143263926,
    c_highrent_b = 7  => 0.016724154,
    c_highrent_b = 8  => 0.0207076986,
                         0.0127226851));

c_low_hval_b :=  __common__( map(
    (C_LOW_HVAL in ['', '0', '-1']) => -1,
    (real)C_LOW_HVAL <= 1.3       => 1,
    (real)C_LOW_HVAL <= 2.2       => 2,
    (real)C_LOW_HVAL <= 3.6       => 3,
    (real)C_LOW_HVAL <= 9.6       => 4,
    (real)C_LOW_HVAL <= 23.6      => 5,
    (real)C_LOW_HVAL <= 35.1      => 6,
    (real)C_LOW_HVAL <= 52.5      => 7,
                                       8));

c_low_hval_b_m :=  __common__( map(
    c_low_hval_b = -1 => 0.0134062951,
    c_low_hval_b = 1  => 0.0072224851,
    c_low_hval_b = 2  => 0.0079928638,
    c_low_hval_b = 3  => 0.0102951794,
    c_low_hval_b = 4  => 0.0110992603,
    c_low_hval_b = 5  => 0.0119540461,
    c_low_hval_b = 6  => 0.0131493562,
    c_low_hval_b = 7  => 0.013930576,
    c_low_hval_b = 8  => 0.0253469667,
                         0.0127226851));

c_lowinc_b :=  __common__( map(
    (C_LOWINC in ['', '0', '-1']) => -1,
    (real)C_LOWINC <= 8.7       => 1,
    (real)C_LOWINC <= 13.1      => 2,
    (real)C_LOWINC <= 17        => 3,
    (real)C_LOWINC <= 21.1      => 4,
    (real)C_LOWINC <= 25.5      => 5,
    (real)C_LOWINC <= 30.3      => 6,
    (real)C_LOWINC <= 35.6      => 7,
    (real)C_LOWINC <= 42.1      => 8,
    (real)C_LOWINC <= 51.2      => 9,
                                     10));

c_lowinc_b_m :=  __common__( map(
    c_lowinc_b = -1 => 0.0174872489,
    c_lowinc_b = 1  => 0.006406387,
    c_lowinc_b = 2  => 0.0071162337,
    c_lowinc_b = 3  => 0.0076767723,
    c_lowinc_b = 4  => 0.0085038609,
    c_lowinc_b = 5  => 0.0092642305,
    c_lowinc_b = 6  => 0.0106407,
    c_lowinc_b = 7  => 0.0120670352,
    c_lowinc_b = 8  => 0.0137529935,
    c_lowinc_b = 9  => 0.0175132351,
    c_lowinc_b = 10 => 0.0337705833,
                       0.0127226851));

c_unemp_b :=  __common__( map(
    (C_UNEMP in ['', '0', '-1']) => -1,
    (real)C_UNEMP <= 0.9       => 1,
    (real)C_UNEMP <= 1.7       => 2,
    (real)C_UNEMP <= 2.1       => 3,
    (real)C_UNEMP <= 2.5       => 4,
    (real)C_UNEMP <= 3         => 5,
    (real)C_UNEMP <= 3.6       => 6,
    (real)C_UNEMP <= 4.4       => 7,
    (real)C_UNEMP <= 5.9       => 8,
                                    9));

c_unemp_b_m :=  __common__( map(
    c_unemp_b = -1 => 0.0105373981,
    c_unemp_b = 1  => 0.0071942446,
    c_unemp_b = 2  => 0.007653689,
    c_unemp_b = 3  => 0.0087116161,
    c_unemp_b = 4  => 0.0094232537,
    c_unemp_b = 5  => 0.0100790371,
    c_unemp_b = 6  => 0.0114661132,
    c_unemp_b = 7  => 0.0140602866,
    c_unemp_b = 8  => 0.0176616621,
    c_unemp_b = 9  => 0.0341189635,
                      0.0127226851));

c_robbery_b :=  __common__( map(
    (C_ROBBERY in ['', '0', '-1']) => -1,
    (real)C_ROBBERY <= 15        => 1,
    (real)C_ROBBERY <= 31        => 2,
    (real)C_ROBBERY <= 88        => 3,
    (real)C_ROBBERY <= 133       => 4,
    (real)C_ROBBERY <= 151       => 5,
    (real)C_ROBBERY <= 175       => 6,
                                      7));

c_robbery_b_m :=  __common__( map(
    c_robbery_b = -1 => 0.0188887357,
    c_robbery_b = 1  => 0.0061621413,
    c_robbery_b = 2  => 0.0075002645,
    c_robbery_b = 3  => 0.0078273213,
    c_robbery_b = 4  => 0.0108504674,
    c_robbery_b = 5  => 0.0158123721,
    c_robbery_b = 6  => 0.0210522802,
    c_robbery_b = 7  => 0.0343682986,
                        0.0127226851));

c_larceny_b :=  __common__( map(
    (C_LARCENY in ['', '0', '-1']) => -1,
    (real)C_LARCENY <= 102       => 1,
    (real)C_LARCENY <= 151       => 2,
                                      3));

c_larceny_b_m :=  __common__( map(
    c_larceny_b = -1 => 0.0160127715,
    c_larceny_b = 1  => 0.0105529578,
    c_larceny_b = 2  => 0.0131701686,
    c_larceny_b = 3  => 0.0199672996,
                        0.0127226851));

_nap_m :=  __common__( map(
    _nap = 1 => 0.0036432566,
    _nap = 2 => 0.0035689867,
    _nap = 3 => 0.009972353,
    _nap = 4 => 0.0453153814,
    _nap = 5 => 0.0228265338,
    _nap = 6 => 0.0860392968,
                0.0127226851));

add_bestmatch_level_m :=  __common__( map(
    add_bestmatch_level = 0 => 0.0055105068,
    add_bestmatch_level = 1 => 0.0313741955,
    add_bestmatch_level = 2 => 0.0225689452,
                               0.0127226851));

ver_positive_src_cnt_m :=  __common__( map(
    ver_positive_src_cnt = 0 => 0.075883499,
    ver_positive_src_cnt = 1 => 0.1157411075,
    ver_positive_src_cnt = 2 => 0.0271060286,
    ver_positive_src_cnt = 3 => 0.0141030844,
    ver_positive_src_cnt = 4 => 0.0136428763,
    ver_positive_src_cnt = 5 => 0.0110541055,
    ver_positive_src_cnt = 6 => 0.008684483,
                                0.0127226851));

_addrcount_m :=  __common__( map(
    _addrcount = 0 => 0.1154354098,
    _addrcount = 1 => 0.0481244605,
    _addrcount = 2 => 0.0138329462,
    _addrcount = 3 => 0.0046033241,
                      0.0127226851));

_prop_owner_m :=  __common__( map(
    _prop_owner = 0 => 0.0038089067,
    _prop_owner = 1 => 0.0048386979,
    _prop_owner = 2 => 0.0176139811,
    _prop_owner = 3 => 0.0177823209,
    _prop_owner = 4 => 0.0318206553,
    _prop_owner = 5 => 0.0241993308,
                       0.0127226851));

_addr_score_m :=  __common__( map(
    _addr_score = -1 => 0.2092597437,
    _addr_score = 1  => 0.0075654009,
    _addr_score = 2  => 0.0237159507,
    _addr_score = 3  => 0.0675755725,
                        0.0127226851));

_phone_score_m :=  __common__( map(
    _phone_score = -1 => 0.023965843,
    _phone_score = 1  => 0.0068249807,
    _phone_score = 2  => 0.0121788685,
    _phone_score = 3  => 0.0148280637,
                         0.0127226851));

_email_domain_free_count_m :=  __common__( map(
    _email_domain_free_count = 0 => 0.0134380389,
    _email_domain_free_count = 1 => 0.0100465831,
    _email_domain_free_count = 2 => 0.0089187785,
    _email_domain_free_count = 3 => 0.0099900925,
    _email_domain_free_count = 4 => 0.0098277445,
                                    0.0127226851));

_adls_per_addr_m :=  __common__( map(
    _adls_per_addr = 0 => 0.0316698796,
    _adls_per_addr = 1 => 0.0190420815,
    _adls_per_addr = 2 => 0.0048719026,
    _adls_per_addr = 3 => 0.0043300789,
    _adls_per_addr = 4 => 0.0043206442,
    _adls_per_addr = 5 => 0.0050868759,
    _adls_per_addr = 6 => 0.005174994,
    _adls_per_addr = 7 => 0.0055237739,
    _adls_per_addr = 8 => 0.0128360219,
                          0.0127226851));

_ssns_per_adl_c6_m :=  __common__( map(
    _ssns_per_adl_c6 = 0 => 0.0158127857,
    _ssns_per_adl_c6 = 1 => 0.0107361119,
    _ssns_per_adl_c6 = 2 => 0.0334545455,
                            0.0127226851));

_phones_per_adl_c6_m :=  __common__( map(
    _phones_per_adl_c6 = 0 => 0.0136677454,
    _phones_per_adl_c6 = 1 => 0.0098412442,
    _phones_per_adl_c6 = 2 => 0.0133000624,
                              0.0127226851));

_ssns_per_addr_c6_m :=  __common__( map(
    _ssns_per_addr_c6 = 0 => 0.0104824909,
    _ssns_per_addr_c6 = 1 => 0.0126654523,
    _ssns_per_addr_c6 = 2 => 0.0188741847,
    _ssns_per_addr_c6 = 3 => 0.0588945878,
                             0.0127226851));

_inq_count03_m :=  __common__( map(
    _inq_count03 = 0 => 0.0119496652,
    _inq_count03 = 1 => 0.0144262831,
    _inq_count03 = 2 => 0.0192678227,
    _inq_count03 = 3 => 0.0296978246,
    _inq_count03 = 4 => 0.0360632439,
    _inq_count03 = 5 => 0.053928675,
                        0.0127226851));

_inq_collection_m :=  __common__( map(
    _inq_collection = 0 => 0.0123629078,
    _inq_collection = 1 => 0.0122251834,
    _inq_collection = 2 => 0.0125367432,
    _inq_collection = 3 => 0.0142595413,
    _inq_collection = 4 => 0.0160559762,
    _inq_collection = 5 => 0.0217332585,
                           0.0127226851));

_inq_peraddr_m :=  __common__( map(
    _inq_peraddr = 0 => 0.0115814364,
    _inq_peraddr = 1 => 0.0100346479,
    _inq_peraddr = 2 => 0.0139306556,
    _inq_peraddr = 3 => 0.0185633728,
    _inq_peraddr = 4 => 0.0224447015,
    _inq_peraddr = 5 => 0.0426207889,
                        0.0127226851));

_ams_income_level_m :=  __common__( map(
    _ams_income_level = -1 => 0.0138566366,
    _ams_income_level = 1  => 0.0078045928,
    _ams_income_level = 2  => 0.0065210476,
    _ams_income_level = 3  => 0.0065395794,
    _ams_income_level = 4  => 0.0063981287,
    _ams_income_level = 5  => 0.0060791894,
    _ams_income_level = 6  => 0.0063077634,
    _ams_income_level = 7  => 0.0068969908,
    _ams_income_level = 8  => 0.0081512698,
    _ams_income_level = 9  => 0.0101819648,
    _ams_income_level = 10 => 0.0162687513,
    _ams_income_level = 11 => 0.0178571429,
                              0.0127226851));

_wealth_index_m :=  __common__( map(
    _wealth_index = 1 => 0.0333869153,
    _wealth_index = 2 => 0.0169434281,
    _wealth_index = 3 => 0.0134254342,
    _wealth_index = 4 => 0.0101298369,
                         0.0127226851));

_addr_stability_v2_m :=  __common__( map(
    _addr_stability_v2 = 0 => 0.0661874182,
    _addr_stability_v2 = 1 => 0.0239202577,
    _addr_stability_v2 = 2 => 0.0150426032,
    _addr_stability_v2 = 3 => 0.01187116,
    _addr_stability_v2 = 4 => 0.0099871602,
    _addr_stability_v2 = 5 => 0.0097163293,
    _addr_stability_v2 = 6 => 0.009158617,
                              0.0127226851));

_crim_rel_within25miles_m :=  __common__( map(
    _crim_rel_within25miles = 0 => 0.012680269,
    _crim_rel_within25miles = 1 => 0.0113372295,
    _crim_rel_within25miles = 2 => 0.0131721456,
    _crim_rel_within25miles = 3 => 0.0149579091,
    _crim_rel_within25miles = 4 => 0.0185027883,
                                   0.0127226851));

_addrcount_m_r :=  __common__( round(_addrcount_m * power(10,10) ) * power(10,-10));

subscore0 :=  __common__( map(
    NULL < _addrcount_m_r AND _addrcount_m_r < 0.0138329462          => 0.706760,
    0.0138329462 <= _addrcount_m_r AND _addrcount_m_r < 0.0481244605 => -0.136961,
    0.0481244605 <= _addrcount_m_r AND _addrcount_m_r < 0.1154354098 => -1.100796,
    0.1154354098 <= _addrcount_m_r                                   => -1.094914,
                                                                        0.000000));

subscore1 :=  __common__( map(
    NULL < (integer)add1_house_number_match AND (integer)add1_house_number_match < 1 => -0.731620,
    1 <= (integer)add1_house_number_match                                            => 0.286466,
                                                                                        0.000000));

_nap_m_r :=  __common__( round(_nap_m * power(10,10) ) * power(10,-10));

subscore2 :=  __common__( map(
    NULL < _nap_m_r AND _nap_m_r < 0.009972353           => 0.341661,
    0.009972353 <= _nap_m_r AND _nap_m_r < 0.0228265338  => 0.205582,
    0.0228265338 <= _nap_m_r AND _nap_m_r < 0.0453153814 => -0.656664,
    0.0453153814 <= _nap_m_r AND _nap_m_r < 0.0860392968 => -0.285967,
    0.0860392968 <= _nap_m_r                             => -1.459352,
                                                            0.000000));

_phone_score_m_r :=  __common__( round(_phone_score_m * power(10,10) ) * power(10,-10));

subscore3 :=  __common__( map(
    NULL < _phone_score_m_r AND _phone_score_m_r < 0.0121788685         => 0.290035,
    0.0121788685 <= _phone_score_m_r AND _phone_score_m_r < 0.023965843 => -0.617284,
    0.023965843 <= _phone_score_m_r                                     => -0.149499,
                                                                           -0.000000));

_ssns_per_addr_c6_m_r :=  __common__( round(_ssns_per_addr_c6_m * power(10,10) ) * power(10,-10));

subscore4 :=  __common__( map(
    NULL < _ssns_per_addr_c6_m_r AND _ssns_per_addr_c6_m_r < 0.0126654523          => 0.186864,
    0.0126654523 <= _ssns_per_addr_c6_m_r AND _ssns_per_addr_c6_m_r < 0.0188741847 => -0.122624,
    0.0188741847 <= _ssns_per_addr_c6_m_r AND _ssns_per_addr_c6_m_r < 0.0588945878 => -0.443575,
    0.0588945878 <= _ssns_per_addr_c6_m_r                                          => -0.889859,
                                                                                      0.000000));

c_robbery_b_m_r :=  __common__( round(c_robbery_b_m * power(10,10) ) * power(10,-10));

subscore5 :=  __common__( map(
    NULL < c_robbery_b_m_r AND c_robbery_b_m_r < 0.0078273213          => 0.242004,
    0.0078273213 <= c_robbery_b_m_r AND c_robbery_b_m_r < 0.0108504674 => 0.242712,
    0.0108504674 <= c_robbery_b_m_r AND c_robbery_b_m_r < 0.0158123721 => -0.014856,
    0.0158123721 <= c_robbery_b_m_r AND c_robbery_b_m_r < 0.0210522802 => -0.216031,
    0.0210522802 <= c_robbery_b_m_r AND c_robbery_b_m_r < 0.0343682986 => -0.146112,
    0.0343682986 <= c_robbery_b_m_r                                    => -0.381050,
                                                                          -0.000000));

ver_positive_src_cnt_m_r :=  __common__( round(ver_positive_src_cnt_m * power(10,10) ) * power(10,-10));

subscore6 :=  __common__( map(
    NULL < ver_positive_src_cnt_m_r AND ver_positive_src_cnt_m_r < 0.0110541055          => -0.029163,
    0.0110541055 <= ver_positive_src_cnt_m_r AND ver_positive_src_cnt_m_r < 0.0141030844 => 0.024204,
    0.0141030844 <= ver_positive_src_cnt_m_r AND ver_positive_src_cnt_m_r < 0.0271060286 => 0.018796,
    0.0271060286 <= ver_positive_src_cnt_m_r AND ver_positive_src_cnt_m_r < 0.075883499  => -0.324903,
    0.075883499 <= ver_positive_src_cnt_m_r AND ver_positive_src_cnt_m_r < 0.1157411075  => 0.774466,
    0.1157411075 <= ver_positive_src_cnt_m_r                                             => -0.786625,
                                                                                            -0.000000));

_addr_score_m_r :=  __common__( round(_addr_score_m * power(10,10) ) * power(10,-10));

subscore7 :=  __common__( map(
    NULL < _addr_score_m_r AND _addr_score_m_r < 0.0237159507          => -0.000522,
    0.0237159507 <= _addr_score_m_r AND _addr_score_m_r < 0.0675755725 => 0.156722,
    0.0675755725 <= _addr_score_m_r AND _addr_score_m_r < 0.2092597437 => 0.307913,
    0.2092597437 <= _addr_score_m_r                                    => -1.211515,
                                                                          -0.000000));

_ams_income_level_m_r :=  __common__( round(_ams_income_level_m * power(10,10) ) * power(10,-10));

subscore8 :=  __common__( map(
    NULL < _ams_income_level_m_r AND _ams_income_level_m_r < 0.0063981287          => 0.665809,
    0.0063981287 <= _ams_income_level_m_r AND _ams_income_level_m_r < 0.0138566366 => 0.453469,
    0.0138566366 <= _ams_income_level_m_r                                          => -0.075467,
                                                                                      0.000000));

_crim_rel_within25miles_m_r :=  __common__( round(_crim_rel_within25miles_m * power(10,10) ) * power(10,-10));

subscore9 :=  __common__( map(
    NULL < _crim_rel_within25miles_m_r AND _crim_rel_within25miles_m_r < 0.012680269           => -0.098520,
    0.012680269 <= _crim_rel_within25miles_m_r AND _crim_rel_within25miles_m_r < 0.0131721456  => 0.083011,
    0.0131721456 <= _crim_rel_within25miles_m_r AND _crim_rel_within25miles_m_r < 0.0185027883 => -0.242969,
    0.0185027883 <= _crim_rel_within25miles_m_r                                                => -0.611068,
                                                                                                  -0.000000));

add1_lres_b_m_r :=  __common__( round(add1_lres_b_m * power(10,10) ) * power(10,-10));

subscore10 :=  __common__( map(
    NULL < add1_lres_b_m_r AND add1_lres_b_m_r < 0.0065279532          => 0.027376,
    0.0065279532 <= add1_lres_b_m_r AND add1_lres_b_m_r < 0.0087460775 => 0.312904,
    0.0087460775 <= add1_lres_b_m_r AND add1_lres_b_m_r < 0.0191184069 => 0.214850,
    0.0191184069 <= add1_lres_b_m_r AND add1_lres_b_m_r < 0.1043016314 => 0.400426,
    0.1043016314 <= add1_lres_b_m_r                                    => -0.228981,
                                                                          0.000000));

_email_domain_free_count_m_r :=  __common__( round(_email_domain_free_count_m * power(10,10) ) * power(10,-10));

subscore11 :=  __common__( map(
    NULL < _email_domain_free_count_m_r AND _email_domain_free_count_m_r < 0.0098277445          => 0.743340,
    0.0098277445 <= _email_domain_free_count_m_r AND _email_domain_free_count_m_r < 0.0134380389 => 0.199596,
    0.0134380389 <= _email_domain_free_count_m_r                                                 => -0.063224,
                                                                                                    -0.000000));

_inq_count03_m_r :=  __common__( round(_inq_count03_m * power(10,10) ) * power(10,-10));

subscore12 :=  __common__( map(
    NULL < _inq_count03_m_r AND _inq_count03_m_r < 0.0144262831          => 0.061477,
    0.0144262831 <= _inq_count03_m_r AND _inq_count03_m_r < 0.0192678227 => -0.227583,
    0.0192678227 <= _inq_count03_m_r AND _inq_count03_m_r < 0.0296978246 => -0.331968,
    0.0296978246 <= _inq_count03_m_r AND _inq_count03_m_r < 0.053928675  => -0.553853,
    0.053928675 <= _inq_count03_m_r                                      => -0.929063,
                                                                            0.000000));

_prop_owner_m_r :=  __common__( round(_prop_owner_m * power(10,10) ) * power(10,-10));

subscore13 :=  __common__( map(
    NULL < _prop_owner_m_r AND _prop_owner_m_r < 0.0048386979          => 0.145211,
    0.0048386979 <= _prop_owner_m_r AND _prop_owner_m_r < 0.0176139811 => 0.183991,
    0.0176139811 <= _prop_owner_m_r AND _prop_owner_m_r < 0.0241993308 => -0.204185,
    0.0241993308 <= _prop_owner_m_r AND _prop_owner_m_r < 0.0318206553 => 0.111819,
    0.0318206553 <= _prop_owner_m_r                                    => 0.007771,
                                                                          0.000000));

_ssns_per_adl_c6_m_r :=  __common__( round(_ssns_per_adl_c6_m * power(10,10) ) * power(10,-10));

subscore14 :=  __common__( map(
    NULL < _ssns_per_adl_c6_m_r AND _ssns_per_adl_c6_m_r < 0.0158127857          => -0.023655,
    0.0158127857 <= _ssns_per_adl_c6_m_r AND _ssns_per_adl_c6_m_r < 0.0334545455 => 0.076878,
    0.0334545455 <= _ssns_per_adl_c6_m_r                                         => -1.081092,
                                                                                    0.000000));

c_urban_p_b_m_r :=  __common__( round(c_urban_p_b_m * power(10,10) ) * power(10,-10));

subscore15 :=  __common__( map(
    NULL < c_urban_p_b_m_r AND c_urban_p_b_m_r < 0.0066257031          => 0.335032,
    0.0066257031 <= c_urban_p_b_m_r AND c_urban_p_b_m_r < 0.0071339693 => 0.379838,
    0.0071339693 <= c_urban_p_b_m_r AND c_urban_p_b_m_r < 0.0156163355 => -0.020048,
    0.0156163355 <= c_urban_p_b_m_r                                    => -0.068803,
                                                                          0.000000));

_phones_per_adl_c6_m_r :=  __common__( round(_phones_per_adl_c6_m * power(10,10) ) * power(10,-10));

subscore16 :=  __common__( map(
    NULL < _phones_per_adl_c6_m_r AND _phones_per_adl_c6_m_r < 0.0133000624          => -0.251737,
    0.0133000624 <= _phones_per_adl_c6_m_r AND _phones_per_adl_c6_m_r < 0.0136677454 => -0.213681,
    0.0136677454 <= _phones_per_adl_c6_m_r                                           => 0.076256,
                                                                                        -0.000000));

c_ownocc_p_b_m_r :=  __common__( round(c_ownocc_p_b_m * power(10,10) ) * power(10,-10));

subscore17 :=  __common__( map(
    NULL < c_ownocc_p_b_m_r AND c_ownocc_p_b_m_r < 0.0084063027          => -0.074460,
    0.0084063027 <= c_ownocc_p_b_m_r AND c_ownocc_p_b_m_r < 0.0093509129 => -0.005882,
    0.0093509129 <= c_ownocc_p_b_m_r AND c_ownocc_p_b_m_r < 0.0112101505 => -0.327623,
    0.0112101505 <= c_ownocc_p_b_m_r AND c_ownocc_p_b_m_r < 0.0136547104 => 0.137169,
    0.0136547104 <= c_ownocc_p_b_m_r AND c_ownocc_p_b_m_r < 0.0199561517 => 0.053076,
    0.0199561517 <= c_ownocc_p_b_m_r AND c_ownocc_p_b_m_r < 0.0334949495 => 0.128804,
    0.0334949495 <= c_ownocc_p_b_m_r                                     => 0.082998,
                                                                            -0.000000));

c_bigapt_p_b_m_r :=  __common__( round(c_bigapt_p_b_m * power(10,10) ) * power(10,-10));

subscore18 :=  __common__( map(
    NULL < c_bigapt_p_b_m_r AND c_bigapt_p_b_m_r < 0.0095453003          => 0.087808,
    0.0095453003 <= c_bigapt_p_b_m_r AND c_bigapt_p_b_m_r < 0.011800388  => 0.096792,
    0.011800388 <= c_bigapt_p_b_m_r AND c_bigapt_p_b_m_r < 0.0133244764  => 0.107559,
    0.0133244764 <= c_bigapt_p_b_m_r AND c_bigapt_p_b_m_r < 0.014858114  => -0.172015,
    0.014858114 <= c_bigapt_p_b_m_r AND c_bigapt_p_b_m_r < 0.0194925266  => 0.034857,
    0.0194925266 <= c_bigapt_p_b_m_r AND c_bigapt_p_b_m_r < 0.0235134612 => -0.155793,
    0.0235134612 <= c_bigapt_p_b_m_r AND c_bigapt_p_b_m_r < 0.0345915188 => -0.181396,
    0.0345915188 <= c_bigapt_p_b_m_r                                     => -0.329162,
                                                                            -0.000000));

c_highrent_b_m_r :=  __common__( round(c_highrent_b_m * power(10,10) ) * power(10,-10));

subscore19 :=  __common__( map(
    NULL < c_highrent_b_m_r AND c_highrent_b_m_r < 0.0086084536         => 0.696329,
    0.0086084536 <= c_highrent_b_m_r AND c_highrent_b_m_r < 0.009968212 => 0.152578,
    0.009968212 <= c_highrent_b_m_r AND c_highrent_b_m_r < 0.0130601995 => 0.159541,
    0.0130601995 <= c_highrent_b_m_r AND c_highrent_b_m_r < 0.016724154 => -0.063687,
    0.016724154 <= c_highrent_b_m_r AND c_highrent_b_m_r < 0.0207076986 => 0.058783,
    0.0207076986 <= c_highrent_b_m_r                                    => 0.108805,
                                                                           0.000000));

c_unemp_b_m_r :=  __common__( round(c_unemp_b_m * power(10,10) ) * power(10,-10));

subscore20 :=  __common__( map(
    NULL < c_unemp_b_m_r AND c_unemp_b_m_r < 0.0087116161          => 0.097302,
    0.0087116161 <= c_unemp_b_m_r AND c_unemp_b_m_r < 0.0094232537 => 0.316854,
    0.0094232537 <= c_unemp_b_m_r AND c_unemp_b_m_r < 0.0105373981 => 0.015438,
    0.0105373981 <= c_unemp_b_m_r AND c_unemp_b_m_r < 0.0140602866 => 0.036452,
    0.0140602866 <= c_unemp_b_m_r AND c_unemp_b_m_r < 0.0176616621 => -0.105914,
    0.0176616621 <= c_unemp_b_m_r AND c_unemp_b_m_r < 0.0341189635 => -0.031144,
    0.0341189635 <= c_unemp_b_m_r                                  => -0.228335,
                                                                      -0.000000));

c_lowinc_b_m_r :=  __common__( round(c_lowinc_b_m * power(10,10) ) * power(10,-10));

subscore21 :=  __common__( map(
    NULL < c_lowinc_b_m_r AND c_lowinc_b_m_r < 0.0071162337          => 0.065189,
    0.0071162337 <= c_lowinc_b_m_r AND c_lowinc_b_m_r < 0.0085038609 => 0.068286,
    0.0085038609 <= c_lowinc_b_m_r AND c_lowinc_b_m_r < 0.0106407    => 0.210868,
    0.0106407 <= c_lowinc_b_m_r AND c_lowinc_b_m_r < 0.0120670352    => 0.046594,
    0.0120670352 <= c_lowinc_b_m_r AND c_lowinc_b_m_r < 0.0137529935 => 0.068812,
    0.0137529935 <= c_lowinc_b_m_r AND c_lowinc_b_m_r < 0.0174872489 => -0.071960,
    0.0174872489 <= c_lowinc_b_m_r AND c_lowinc_b_m_r < 0.0337705833 => -0.060273,
    0.0337705833 <= c_lowinc_b_m_r                                   => -0.237218,
                                                                        0.000000));

add_bestmatch_level_m_r :=  __common__( round(add_bestmatch_level_m * power(10,10) ) * power(10,-10));

subscore22 :=  __common__( map(
    NULL < add_bestmatch_level_m_r AND add_bestmatch_level_m_r < 0.0225689452          => 0.078520,
    0.0225689452 <= add_bestmatch_level_m_r AND add_bestmatch_level_m_r < 0.0313741955 => -0.186624,
    0.0313741955 <= add_bestmatch_level_m_r                                            => 0.139895,
                                                                                          -0.000000));

_inq_peraddr_m_r :=  __common__( round(_inq_peraddr_m * power(10,10) ) * power(10,-10));

subscore23 :=  __common__( map(
    NULL < _inq_peraddr_m_r AND _inq_peraddr_m_r < 0.0115814364          => 0.056081,
    0.0115814364 <= _inq_peraddr_m_r AND _inq_peraddr_m_r < 0.0139306556 => 0.054981,
    0.0139306556 <= _inq_peraddr_m_r AND _inq_peraddr_m_r < 0.0185633728 => -0.024546,
    0.0185633728 <= _inq_peraddr_m_r AND _inq_peraddr_m_r < 0.0426207889 => -0.333484,
    0.0426207889 <= _inq_peraddr_m_r                                     => -0.398413,
                                                                            0.000000));

_inq_collection_m_r :=  __common__( round(_inq_collection_m * power(10,10) ) * power(10,-10));

subscore24 :=  __common__( map(
    NULL < _inq_collection_m_r AND _inq_collection_m_r < 0.0217332585 => 0.024026,
    0.0217332585 <= _inq_collection_m_r                               => -0.587060,
                                                                         0.000000));

c_fammar_p_b_m_r :=  __common__( round(c_fammar_p_b_m * power(10,10) ) * power(10,-10));

subscore25 :=  __common__( map(
    NULL < c_fammar_p_b_m_r AND c_fammar_p_b_m_r < 0.0071072305          => 0.032192,
    0.0071072305 <= c_fammar_p_b_m_r AND c_fammar_p_b_m_r < 0.0074680502 => 0.134733,
    0.0074680502 <= c_fammar_p_b_m_r AND c_fammar_p_b_m_r < 0.0091786622 => 0.073942,
    0.0091786622 <= c_fammar_p_b_m_r AND c_fammar_p_b_m_r < 0.0130010347 => 0.046850,
    0.0130010347 <= c_fammar_p_b_m_r AND c_fammar_p_b_m_r < 0.0185792475 => 0.137403,
    0.0185792475 <= c_fammar_p_b_m_r AND c_fammar_p_b_m_r < 0.024771999  => 0.080139,
    0.024771999 <= c_fammar_p_b_m_r                                      => -0.239459,
                                                                            -0.000000));

subscore26 :=  __common__( map(
    NULL < bus_phone_match AND bus_phone_match < 1 => 0.004059,
    1 <= bus_phone_match AND bus_phone_match < 2   => -0.115035,
    2 <= bus_phone_match AND bus_phone_match < 3   => -0.034031,
    3 <= bus_phone_match                           => 0.440918,
                                                      -0.000000));

c_larceny_b_m_r :=  __common__( round(c_larceny_b_m * power(10,10) ) * power(10,-10));

subscore27 :=  __common__( map(
    NULL < c_larceny_b_m_r AND c_larceny_b_m_r < 0.0131701686          => -0.081436,
    0.0131701686 <= c_larceny_b_m_r AND c_larceny_b_m_r < 0.0160127715 => 0.206529,
    0.0160127715 <= c_larceny_b_m_r AND c_larceny_b_m_r < 0.0199672996 => 0.140606,
    0.0199672996 <= c_larceny_b_m_r                                    => 0.119438,
                                                                          -0.000000));

_addr_stability_v2_m_r :=  __common__( round(_addr_stability_v2_m * power(10,10) ) * power(10,-10));

subscore28 :=  __common__( map(
    NULL < _addr_stability_v2_m_r AND _addr_stability_v2_m_r < 0.0097163293          => -0.071035,
    0.0097163293 <= _addr_stability_v2_m_r AND _addr_stability_v2_m_r < 0.01187116   => 0.050119,
    0.01187116 <= _addr_stability_v2_m_r AND _addr_stability_v2_m_r < 0.0150426032   => 0.259598,
    0.0150426032 <= _addr_stability_v2_m_r AND _addr_stability_v2_m_r < 0.0239202577 => -0.155022,
    0.0239202577 <= _addr_stability_v2_m_r AND _addr_stability_v2_m_r < 0.0661874182 => -0.022928,
    0.0661874182 <= _addr_stability_v2_m_r                                           => 0.006801,
                                                                                        0.000000));

c_low_hval_b_m_r :=  __common__( round(c_low_hval_b_m * power(10,10) ) * power(10,-10));

subscore29 :=  __common__( map(
    NULL < c_low_hval_b_m_r AND c_low_hval_b_m_r < 0.0110992603          => 0.164477,
    0.0110992603 <= c_low_hval_b_m_r AND c_low_hval_b_m_r < 0.0134062951 => 0.070561,
    0.0134062951 <= c_low_hval_b_m_r AND c_low_hval_b_m_r < 0.013930576  => -0.095987,
    0.013930576 <= c_low_hval_b_m_r AND c_low_hval_b_m_r < 0.0253469667  => -0.071815,
    0.0253469667 <= c_low_hval_b_m_r                                     => -0.106420,
                                                                            -0.000000));

_adls_per_addr_m_r :=  __common__( round(_adls_per_addr_m * power(10,10) ) * power(10,-10));

subscore30 :=  __common__( map(
    NULL < _adls_per_addr_m_r AND _adls_per_addr_m_r < 0.0050868759          => 0.328540,
    0.0050868759 <= _adls_per_addr_m_r AND _adls_per_addr_m_r < 0.0128360219 => -0.063546,
    0.0128360219 <= _adls_per_addr_m_r AND _adls_per_addr_m_r < 0.0190420815 => 0.006315,
    0.0190420815 <= _adls_per_addr_m_r AND _adls_per_addr_m_r < 0.0316698796 => -0.259025,
    0.0316698796 <= _adls_per_addr_m_r                                       => -0.102065,
                                                                                -0.000000));

_wealth_index_m_r :=  __common__( round(_wealth_index_m * power(10,10) ) * power(10,-10));

subscore31 :=  __common__( map(
    NULL < _wealth_index_m_r AND _wealth_index_m_r < 0.0134254342          => -0.074110,
    0.0134254342 <= _wealth_index_m_r AND _wealth_index_m_r < 0.0169434281 => 0.117213,
    0.0169434281 <= _wealth_index_m_r AND _wealth_index_m_r < 0.0333869153 => 0.059552,
    0.0333869153 <= _wealth_index_m_r                                      => -0.054664,
                                                                              -0.000000));

rawscore :=  __common__( subscore0 +
    subscore1 +
    subscore2 +
    subscore3 +
    subscore4 +
    subscore5 +
    subscore6 +
    subscore7 +
    subscore8 +
    subscore9 +
    subscore10 +
    subscore11 +
    subscore12 +
    subscore13 +
    subscore14 +
    subscore15 +
    subscore16 +
    subscore17 +
    subscore18 +
    subscore19 +
    subscore20 +
    subscore21 +
    subscore22 +
    subscore23 +
    subscore24 +
    subscore25 +
    subscore26 +
    subscore27 +
    subscore28 +
    subscore29 +
    subscore30 +
    subscore31);

lnoddsscore :=  __common__( rawscore * 1.000000 + 4.110609);

probscore :=  __common__( exp(lnoddsscore) / (1 + exp(lnoddsscore)));

base :=  __common__( 700);

odds :=  __common__( 1 / 200);

point :=  __common__( -50);

phat :=  __common__( 1 - probscore);

nossndob_mod01_score_xeno :=  __common__( round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base));

nossndob_mod01_score_xeno_cap :=  __common__( map(
    nossndob_mod01_score_xeno > 999 => 999,
    nossndob_mod01_score_xeno < 300 => 300,
                                       nossndob_mod01_score_xeno));

dy_transform :=  __common__( map(
    nossndob_mod01_score_xeno_cap <= 537 => (nossndob_mod01_score_xeno_cap - 300) / (537 - 300) * (568 - 300) + 300,
    nossndob_mod01_score_xeno_cap <= 599 => (nossndob_mod01_score_xeno_cap - 538) / (599 - 538) * (637 - 569) + 569,
    nossndob_mod01_score_xeno_cap <= 632 => (nossndob_mod01_score_xeno_cap - 600) / (632 - 600) * (668 - 638) + 638,
    nossndob_mod01_score_xeno_cap <= 656 => (nossndob_mod01_score_xeno_cap - 633) / (656 - 633) * (687 - 669) + 669,
    nossndob_mod01_score_xeno_cap <= 674 => (nossndob_mod01_score_xeno_cap - 657) / (674 - 657) * (701 - 688) + 688,
    nossndob_mod01_score_xeno_cap <= 689 => (nossndob_mod01_score_xeno_cap - 675) / (689 - 675) * (713 - 702) + 702,
    nossndob_mod01_score_xeno_cap <= 702 => (nossndob_mod01_score_xeno_cap - 690) / (702 - 690) * (722 - 714) + 714,
    nossndob_mod01_score_xeno_cap <= 713 => (nossndob_mod01_score_xeno_cap - 703) / (713 - 703) * (729 - 723) + 723,
    nossndob_mod01_score_xeno_cap <= 724 => (nossndob_mod01_score_xeno_cap - 714) / (724 - 714) * (736 - 730) + 730,
    nossndob_mod01_score_xeno_cap <= 734 => (nossndob_mod01_score_xeno_cap - 725) / (734 - 725) * (742 - 737) + 737,
    nossndob_mod01_score_xeno_cap <= 744 => (nossndob_mod01_score_xeno_cap - 735) / (744 - 735) * (747 - 743) + 743,
    nossndob_mod01_score_xeno_cap <= 753 => (nossndob_mod01_score_xeno_cap - 745) / (753 - 745) * (752 - 748) + 748,
    nossndob_mod01_score_xeno_cap <= 762 => (nossndob_mod01_score_xeno_cap - 754) / (762 - 754) * (757 - 753) + 753,
    nossndob_mod01_score_xeno_cap <= 771 => (nossndob_mod01_score_xeno_cap - 763) / (771 - 763) * (761 - 758) + 758,
    nossndob_mod01_score_xeno_cap <= 781 => (nossndob_mod01_score_xeno_cap - 772) / (781 - 772) * (765 - 762) + 762,
    nossndob_mod01_score_xeno_cap <= 791 => (nossndob_mod01_score_xeno_cap - 782) / (791 - 782) * (769 - 766) + 766,
    nossndob_mod01_score_xeno_cap <= 803 => (nossndob_mod01_score_xeno_cap - 792) / (803 - 792) * (774 - 770) + 770,
    nossndob_mod01_score_xeno_cap <= 818 => (nossndob_mod01_score_xeno_cap - 804) / (818 - 804) * (779 - 775) + 775,
    nossndob_mod01_score_xeno_cap <= 838 => (nossndob_mod01_score_xeno_cap - 819) / (838 - 819) * (787 - 780) + 780,
                                            (nossndob_mod01_score_xeno_cap - 839) / (999 - 839) * (999 - 788) + 788));

s_no_ssn_score :=  __common__( round(dy_transform));

//*******************************************************************************************************//
// end code for no SSN segment models
//*******************************************************************************************************//

//*******************************************************************************************************//
// begin code for segments 1 - 5 logistic models
//*******************************************************************************************************//

s1_advo_risk :=  __common__( (string)add1_advo_address_vacancy = 'Y' or (add1_advo_mixed_address_usage in ['B', 'C']));

s1_phonerisk :=  __common__( (rc_hriskphoneflag in ['1', '2', '3', '4', '5']));

s1_phoneuseunknown :=  __common__( rc_phonevalflag = (string)3);

s1_deceased :=  __common__( rc_decsflag = (string)1);

s1_adl_category_dead :=  __common__( adl_category = '1 DEAD');

s1_adl_category_inactive :=  __common__( adl_category = '5 INACTIVE');

s1_ver_src_nas_enrisk :=  __common__( (ver_src_nas_en in [1, 4, 7, 9]));

s1_ver_src_nas_eq :=  __common__( ver_src_nas_eq = 12);

s1_ver_src_nas_tn :=  __common__( ver_src_nas_tn = 12);

s1_ver_src_nas_p :=  __common__( ver_src_nas_p >= 8);

s1_acc :=  __common__( acc_count > 0);


add1_avm_med_s1 :=  __common__( map(
    (add1_avm_med in [NULL, 0]) => -1,
    add1_avm_med <= 55000       => 7,
    add1_avm_med <= 74929       => 6,
    add1_avm_med <= 111214      => 5,
    add1_avm_med <= 479000      => 4,
    add1_avm_med <= 554672      => 3,
    add1_avm_med <= 700000      => 2,
                                     1));

add1_avm_med_s1_m :=  __common__( map(
    add1_avm_med_s1 = -1 => 0.2941176471,
    add1_avm_med_s1 = 1  => 0.2331606218,
    add1_avm_med_s1 = 2  => 0.3005181347,
    add1_avm_med_s1 = 3  => 0.3556701031,
    add1_avm_med_s1 = 4  => 0.289410828,
    add1_avm_med_s1 = 5  => 0.322997416,
    add1_avm_med_s1 = 6  => 0.3769633508,
    add1_avm_med_s1 = 7  => 0.4226804124,
                            0.3038389513));

c_rural_p_s1 :=  __common__( map(
    (C_RURAL_P in ['', '0', '-1']) => -1,
    (real)C_RURAL_P <= 49.3      => 2,
                                      1));

c_rural_p_s1_m :=  __common__( map(
    c_rural_p_s1 = -1 => 0.3279752705,
    c_rural_p_s1 = 1  => 0.2581888247,
    c_rural_p_s1 = 2  => 0.1988416988,
                         0.3038389513));

c_bigapt_p_s1 :=  __common__( map(
    (C_BIGAPT_P in ['', '0', '-1']) => -1,
    (real)C_BIGAPT_P <= 13.8      => 1,
    (real)C_BIGAPT_P <= 31.8      => 2,
                                       3));

c_bigapt_p_s1_m :=  __common__( map(
    c_bigapt_p_s1 = -1 => 0.2899628253,
    c_bigapt_p_s1 = 1  => 0.2852664577,
    c_bigapt_p_s1 = 2  => 0.3476190476,
    c_bigapt_p_s1 = 3  => 0.3867924528,
                          0.3038389513));

c_span_lang_s1 :=  __common__( map(
    (C_SPAN_LANG in ['', '0', '-1']) => -1,
    (real)C_SPAN_LANG <= 30        => 1,
    (real)C_SPAN_LANG <= 106       => 2,
    (real)C_SPAN_LANG <= 126       => 3,
    (real)C_SPAN_LANG <= 143       => 4,
    (real)C_SPAN_LANG <= 174       => 5,
    (real)C_SPAN_LANG <= 188       => 6,
                                        7));

c_span_lang_s1_m :=  __common__( map(
    c_span_lang_s1 = -1 => 0.5283018868,
    c_span_lang_s1 = 1  => 0.2459016393,
    c_span_lang_s1 = 2  => 0.280381255,
    c_span_lang_s1 = 3  => 0.2686915888,
    c_span_lang_s1 = 4  => 0.3155452436,
    c_span_lang_s1 = 5  => 0.3213429257,
    c_span_lang_s1 = 6  => 0.3341121495,
    c_span_lang_s1 = 7  => 0.3640776699,
                           0.3038389513));

s1_nap :=  __common__( map(
    nap_summary = 0  => 6,
    nap_summary = 1  => 5,
    nap_summary <= 6 => 4,
    nap_summary = 11 => 2,
    nap_summary = 12 => 1,
                        3));

s1_nap_m :=  __common__( map(
    s1_nap = 1 => 0.1722797927,
    s1_nap = 2 => 0.1818181818,
    s1_nap = 3 => 0.2728297632,
    s1_nap = 4 => 0.3459268005,
    s1_nap = 5 => 0.3850931677,
    s1_nap = 6 => 0.4102564103,
                  0.3038389513));

add_bestmatch_level_1 :=  __common__( map(
    add1_isbestmatch => 0,
    add2_isbestmatch => 2,
                        1));

add_bestmatch_level_s1_m :=  __common__( map(
    add_bestmatch_level_1 = 0 => 0.2160228898,
    add_bestmatch_level_1 = 1 => 0.3199554069,
    add_bestmatch_level_1 = 2 => 0.4366197183,
                                 0.3038389513));

_ssn_score :=  __common__( map(
    combo_ssnscore > 100 => -1,
    combo_ssnscore = 100 => 1,
    combo_ssnscore > 80  => 2,
                            3));

_ssn_score_s1_m :=  __common__( map(
    _ssn_score = -1 => 0.2777777778,
    _ssn_score = 1  => 0.3089459085,
    _ssn_score = 2  => 0.2069892473,
    _ssn_score = 3  => 0.3820960699,
                         0.3038389513));

_bus_addr_src_cnt_1 :=  __common__( min(2, if(bus_addr_src_cnt = NULL, -NULL, bus_addr_src_cnt)));

_bus_addr_src_cnt_s1_m :=  __common__( map(
    _bus_addr_src_cnt_1 = 0 => 0.3227704844,
    _bus_addr_src_cnt_1 = 1 => 0.3171521036,
    _bus_addr_src_cnt_1 = 2 => 0.2692041522,
                               0.3038389513));

s1_ssns_per_addr :=  __common__( map(
    ssns_per_addr = 0  => -2,
    ssns_per_addr = 1  => -1,
    ssns_per_addr <= 4 => 1,
                          min(13, if(ssns_per_addr = NULL, -NULL, ssns_per_addr))));

s1_ssns_per_addr_m :=  __common__( map(
    s1_ssns_per_addr = -2 => 0.3365292426,
    s1_ssns_per_addr = -1 => 0.25,
    s1_ssns_per_addr = 1  => 0.1820330969,
    s1_ssns_per_addr = 5  => 0.1941176471,
    s1_ssns_per_addr = 6  => 0.2057142857,
    s1_ssns_per_addr = 7  => 0.2580645161,
    s1_ssns_per_addr = 8  => 0.2830188679,
    s1_ssns_per_addr = 9  => 0.3255813953,
    s1_ssns_per_addr = 10 => 0.26875,
    s1_ssns_per_addr = 11 => 0.2089552239,
    s1_ssns_per_addr = 12 => 0.2803030303,
    s1_ssns_per_addr = 13 => 0.362962963,
                             0.3038389513));

s1_adlperssn_count0 :=  __common__( adlperssn_count = 0);

s1_ssns_per_addr_c6 :=  __common__( min(4, if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6)));

s1_ssns_per_addr_c6_m :=  __common__( map(
    s1_ssns_per_addr_c6 = 0 => 0.2773409578,
    s1_ssns_per_addr_c6 = 1 => 0.3114446529,
    s1_ssns_per_addr_c6 = 3 => 0.4074074074,
    s1_ssns_per_addr_c6 = 4 => 0.5040650407,
                               0.3038389513));

_addr_stability_v2_1 :=  __common__( max(0, min(6, if(addr_stability_v2 = '', -NULL, (unsigned1)addr_stability_v2))));

_addr_stability_v2_s1_m :=  __common__( map(
    _addr_stability_v2_1 = 0 => 0.2723404255,
    _addr_stability_v2_1 = 1 => 0.2535211268,
    _addr_stability_v2_1 = 2 => 0.2535211268,
    _addr_stability_v2_1 = 3 => 0.2707774799,
    _addr_stability_v2_1 = 4 => 0.2803468208,
    _addr_stability_v2_1 = 5 => 0.3053892216,
    _addr_stability_v2_1 = 6 => 0.3616869192,
                                0.3038389513));

s1_rel_count :=  __common__( min(3, if(rel_count = NULL, -NULL, rel_count)));

s1_rel_count_m :=  __common__( map(
    s1_rel_count = 0 => 0.2396694215,
    s1_rel_count = 1 => 0.2719665272,
    s1_rel_count = 2 => 0.3127753304,
    s1_rel_count = 3 => 0.3177132146,
                        0.3038389513));

s1_07_logit :=  __common__( -15.3980745 +
    (integer)s1_advo_risk * 0.4731945387 +
    (integer)s1_phonerisk * 0.348182836 +
    (integer)s1_phoneuseunknown * 0.2695583629 +
    (integer)s1_deceased * 0.9801181531 +
    (integer)s1_adl_category_dead * 0.4346664672 +
    (integer)s1_adl_category_inactive * 0.3643687955 +
    (integer)ver_src_de * 0.8481469544 +
    (integer)ver_src_sl * -0.362237291 +
    (integer)s1_ver_src_nas_enrisk * 0.8739551045 +
    (integer)s1_ver_src_nas_eq * -0.461720106 +
    (integer)s1_ver_src_nas_tn * -0.215945428 +
    (integer)s1_ver_src_nas_p * -0.262405697 +
    (integer)s1_acc * -1.10031202 +
    add1_avm_med_s1_m * 3.1962111259 +
    c_rural_p_s1_m * 3.3588706531 +
    c_bigapt_p_s1_m * 3.6418690632 +
    c_span_lang_s1_m * 4.2393583633 +
    s1_nap_m * 1.9117116851 +
    add_bestmatch_level_s1_m * 1.5286321452 +
    _ssn_score_s1_m * 3.2560832522 +
    _bus_addr_src_cnt_s1_m * 5.517608025 +
    s1_ssns_per_addr_m * 2.2038698202 +
    (integer)s1_adlperssn_count0 * 1.1035877747 +
    s1_ssns_per_addr_c6_m * 3.5123941503 +
    _addr_stability_v2_s1_m * 5.0974966988 +
    s1_rel_count_m * 7.9048270968);

s2_apt :=  __common__( add1_unit_count > 4);

s2_nap0 :=  __common__( nap_summary = 0);

s2_nap1_6 :=  __common__( (nap_summary in [1, 6]));

s2_nap12 :=  __common__( nap_summary = 12);

s2_ver_src_p :=  __common__( map(
    add1_naprop = 4 and (integer)ver_src_p = 1 => 1,
    add1_naprop = 4 and (integer)ver_src_p = 0 => 2,
    add1_naprop = 3 and (integer)ver_src_p = 0 => 3,
    add1_naprop = 3 and (integer)ver_src_p = 1 => 6,
    add1_naprop = 0                            => 5,
    (integer)ver_src_p = 0                     => 6,
                                                  7));

s2_ver_src_p_m :=  __common__( map(
    s2_ver_src_p = 1 => 0.030334728,
    s2_ver_src_p = 2 => 0.0658823529,
    s2_ver_src_p = 3 => 0.0941489362,
    s2_ver_src_p = 5 => 0.1430125606,
    s2_ver_src_p = 6 => 0.1760257302,
    s2_ver_src_p = 7 => 0.376148871,
                        0.1811835894));

s2_lname_eda_sourced :=  __common__( (lname_eda_sourced_type in ['AP', 'P']));

s2_fname_eda_sourced :=  __common__( (fname_eda_sourced_type in ['AP', 'P']));

s2_name_eda :=  __common__( map(
    (integer)s2_lname_eda_sourced = 1 and (integer)s2_fname_eda_sourced = 1 => 1,
    (integer)s2_lname_eda_sourced = 1                                       => 2,
                                                                               3));

s2_name_eda_m :=  __common__( map(
    s2_name_eda = 1 => 0.0248197449,
    s2_name_eda = 2 => 0.0353581142,
    s2_name_eda = 3 => 0.2270289511,
                       0.1811835894));

s2_altlname :=  __common__( (integer)rc_altlname1_flag > 0 or (integer)rc_altlname2_flag > 0);

s2_add_bestmatch_level :=  __common__( map(
    add1_isbestmatch => 0,
    add2_isbestmatch => 2,
                        1));

s2_add_bestmatch_level_m :=  __common__( map(
    s2_add_bestmatch_level = 0 => 0.0869056898,
    s2_add_bestmatch_level = 1 => 0.1817017644,
    s2_add_bestmatch_level = 2 => 0.1945402057,
                                  0.1811835894));

s2_addmatch :=  __common__( map(
    (integer)add1_house_number_match = 1 and (integer)add1_isbestmatch = 1              => 1,
    (integer)add1_house_number_match = 1 and (integer)rc_input_addr_not_most_recent = 1 => 1,
    (integer)add1_house_number_match = 1                                                => 2,
    (integer)add1_house_number_match = 0 and (integer)add1_isbestmatch = 1              => 3,
    (integer)add1_house_number_match = 0 and (integer)rc_input_addr_not_most_recent = 1 => 3,
                                                                                           4));

s2_addmatch_m :=  __common__( map(
    s2_addmatch = 1 => 0.0094970102,
    s2_addmatch = 2 => 0.0260189502,
    s2_addmatch = 3 => 0.1420631028,
    s2_addmatch = 4 => 0.2259921545,
                       0.1811835894));

s2_add1_lres :=  __common__( map(
    (add1_lres in [NULL, 0]) => -1,
    add1_lres <= 78          => 3,
    add1_lres <= 265         => 2,
                                1));

s2_add1_lres_m :=  __common__( map(
    s2_add1_lres = -1 => 0.1970985291,
    s2_add1_lres = 1  => 0.0151515152,
    s2_add1_lres = 2  => 0.0205479452,
    s2_add1_lres = 3  => 0.0349822356,
                         0.1811835894));

s2_addrs_15yr_0 :=  __common__( addrs_15yr = 0);

s2_combo_dobscore :=  __common__( map(
    combo_dobscore = 100 => 1,
    combo_dobscore >= 90 => 2,
                            3));

s2_combo_dobscore_m :=  __common__( map(
    s2_combo_dobscore = 1 => 0.1421965837,
    s2_combo_dobscore = 2 => 0.3231882393,
    s2_combo_dobscore = 3 => 0.4922311995,
                             0.1811835894));

s2_infutor :=  __common__( map(
    infutor_nap = 12 => 2,
    infutor_nap = 6  => 5,
    infutor_nap = 1  => 4,
    infutor_nap = 0  => 3,
                        2));

s2_infutor_m :=  __common__( map(
    s2_infutor = 2 => 0.07881261,
    s2_infutor = 3 => 0.1818827479,
    s2_infutor = 4 => 0.2739505925,
    s2_infutor = 5 => 0.4139372822,
                      0.1811835894));

s2_util_adl_nap :=  __common__( map(
    util_adl_nap = 12 => 1,
    util_adl_nap = 0  => 3,
                         2));

s2_util_adl_nap_m :=  __common__( map(
    s2_util_adl_nap = 1 => 0.0728813559,
    s2_util_adl_nap = 2 => 0.1610188385,
    s2_util_adl_nap = 3 => 0.2239982602,
                           0.1811835894));

s2_ams :=  __common__( map(
    ams_file_type = 'H' => 1,
    ams_file_type = ' ' => 3,
                           2));

s2_ams_m :=  __common__( map(
    s2_ams = 1 => 0.0645065398,
    s2_ams = 2 => 0.097876576,
    s2_ams = 3 => 0.2081674949,
                  0.1811835894));

add1_avm_to_med_ratio_1 :=  __common__( if(add1_avm_automated_valuation > 0 and add1_avm_med > 0, add1_avm_automated_valuation / add1_avm_med, NULL));

s2_add1_avm_to_med_ratio :=  __common__( map(
    (add1_avm_to_med_ratio_1 in [NULL, 0])  => -1,
    add1_avm_to_med_ratio_1 <= 0.7276645199 => 6,
    add1_avm_to_med_ratio_1 <= 1.0471858883 => 5,
    add1_avm_to_med_ratio_1 <= 1.2463432759 => 3,
    add1_avm_to_med_ratio_1 <= 1.3476567208 => 2,
                                               1));

s2_add1_avm_to_med_ratio_m :=  __common__( map(
    s2_add1_avm_to_med_ratio = -1 => 0.1592094824,
    s2_add1_avm_to_med_ratio = 1  => 0.2078313253,
    s2_add1_avm_to_med_ratio = 2  => 0.2398190045,
    s2_add1_avm_to_med_ratio = 3  => 0.2504708098,
    s2_add1_avm_to_med_ratio = 5  => 0.2603381885,
    s2_add1_avm_to_med_ratio = 6  => 0.2641888498,
                                     0.1811835894));

s2_add2_building_area :=  __common__( map(
    (add2_building_area in ['', '0'])  => -1,
    (real)add2_building_area <= 1208 => 4,
    (real)add2_building_area <= 1452 => 3,
    (real)add2_building_area <= 1836 => 2,
                                          1));

s2_add2_building_area_m :=  __common__( map(
    s2_add2_building_area = -1 => 0.1595686781,
    s2_add2_building_area = 1  => 0.1955668034,
    s2_add2_building_area = 2  => 0.2069168795,
    s2_add2_building_area = 3  => 0.2157784744,
    s2_add2_building_area = 4  => 0.2218731592,
                                  0.1811835894));

s2_derog :=  __common__( felony_count > 0 or attr_arrests > 0 or impulse_count > 0 or (integer)foreclosure_flag > 0 or adl_category = '1 DEAD');

s2_adlperssn :=  __common__( max(1, min(4, if(adlperssn_count = NULL, -NULL, adlperssn_count))));

s2_adlperssn_m :=  __common__( map(
    s2_adlperssn = 1 => 0.1734820322,
    s2_adlperssn = 2 => 0.1892104886,
    s2_adlperssn = 3 => 0.1964651639,
    s2_adlperssn = 4 => 0.2491649967,
                        0.1811835894));

s2_ssns_per_addr :=  __common__( map(
    1 <= ssns_per_addr AND ssns_per_addr <= 4 => 1,
    10 <= ssns_per_addr                       => 3,
                                                 2));

s2_ssns_per_addr_m :=  __common__( map(
    s2_ssns_per_addr = 1 => 0.0797473932,
    s2_ssns_per_addr = 2 => 0.1433201183,
    s2_ssns_per_addr = 3 => 0.2975546817,
                            0.1811835894));

s2_ssns_per_adl_c6 :=  __common__( ssns_per_adl_c6 > 1);

s2_phones_per_adl_c6 :=  __common__( min(3, if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6)));

s2_phones_per_adl_c6_m :=  __common__( map(
    s2_phones_per_adl_c6 = 0 => 0.1716272289,
    s2_phones_per_adl_c6 = 1 => 0.2194364084,
    s2_phones_per_adl_c6 = 2 => 0.245017585,
    s2_phones_per_adl_c6 = 3 => 0.3333333333,
                                0.1811835894));

s2_ssns_per_addr_c6 :=  __common__( min(6, if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6)));

s2_ssns_per_addr_c6_m :=  __common__( map(
    s2_ssns_per_addr_c6 = 0 => 0.1407103825,
    s2_ssns_per_addr_c6 = 1 => 0.2348612602,
    s2_ssns_per_addr_c6 = 2 => 0.3102253033,
    s2_ssns_per_addr_c6 = 3 => 0.4048156509,
    s2_ssns_per_addr_c6 = 4 => 0.5207296849,
    s2_ssns_per_addr_c6 = 5 => 0.5667655786,
    s2_ssns_per_addr_c6 = 6 => 0.6771117166,
                               0.1811835894));

s2_phones_per_addr_c6 :=  __common__( min(2, if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6)));

s2_phones_per_addr_c6_m :=  __common__( map(
    s2_phones_per_addr_c6 = 0 => 0.1514483478,
    s2_phones_per_addr_c6 = 1 => 0.2696944211,
    s2_phones_per_addr_c6 = 2 => 0.2934919776,
                                 0.1811835894));

s2_inq_count01_1 :=  __common__( min(5, if(Inq_count01 = NULL, -NULL, Inq_count01)));

s2_inq_count01 :=  __common__( if(s2_inq_count01_1 = 3, 4, s2_inq_count01_1));

s2_inq_count01_m :=  __common__( map(
    s2_inq_count01 = 0 => 0.1749461734,
    s2_inq_count01 = 1 => 0.2395666132,
    s2_inq_count01 = 2 => 0.2724902216,
    s2_inq_count01 = 4 => 0.3279132791,
    s2_inq_count01 = 5 => 0.5100671141,
                          0.1811835894));

s2_inq_peraddr :=  __common__( min(5, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr)));

s2_inq_peraddr_m :=  __common__( map(
    s2_inq_peraddr = 0 => 0.1403115918,
    s2_inq_peraddr = 1 => 0.2394902035,
    s2_inq_peraddr = 2 => 0.3123960067,
    s2_inq_peraddr = 3 => 0.3534675615,
    s2_inq_peraddr = 4 => 0.3563218391,
    s2_inq_peraddr = 5 => 0.4166390454,
                          0.1811835894));

s2_inq_adlsperphone :=  __common__( max(1, min(6, if(Inq_ADLsPerPhone = NULL, -NULL, Inq_ADLsPerPhone))));

s2_inq_adlsperphone_m :=  __common__( map(
    s2_inq_adlsperphone = 1 => 0.1780069624,
    s2_inq_adlsperphone = 2 => 0.2663438257,
    s2_inq_adlsperphone = 3 => 0.4307692308,
    s2_inq_adlsperphone = 4 => 0.453125,
    s2_inq_adlsperphone = 5 => 0.652173913,
    s2_inq_adlsperphone = 6 => 0.7380952381,
                               0.1811835894));

s2_rel_felony :=  __common__( map(
    rel_felony_count = 0  => 1,
    rel_felony_count = 1  => 2,
    rel_felony_count <= 5 => 3,
                             4));

s2_rel_felony_m :=  __common__( map(
    s2_rel_felony = 1 => 0.1735433959,
    s2_rel_felony = 2 => 0.2416687238,
    s2_rel_felony = 3 => 0.2830687831,
    s2_rel_felony = 4 => 0.5869565217,
                         0.1811835894));

s2_c_fammar_p_b :=  __common__( map(
    (C_FAMMAR_P in ['', '0', '-1']) => -1,
    (real)C_FAMMAR_P <= 50.9      => 9,
    (real)C_FAMMAR_P <= 62.1      => 8,
    (real)C_FAMMAR_P <= 68.9      => 7,
    (real)C_FAMMAR_P <= 73.9      => 6,
    (real)C_FAMMAR_P <= 77.8      => 5,
    (real)C_FAMMAR_P <= 81.1      => 4,
    (real)C_FAMMAR_P <= 84.3      => 3,
    (real)C_FAMMAR_P <= 87.7      => 2,
                                       1));

s2_c_fammar_p_b_m :=  __common__( map(
    s2_c_fammar_p_b = -1 => 0.0891848265,
    s2_c_fammar_p_b = 1  => 0.0938566553,
    s2_c_fammar_p_b = 2  => 0.1103896104,
    s2_c_fammar_p_b = 3  => 0.11967149,
    s2_c_fammar_p_b = 4  => 0.1386530843,
    s2_c_fammar_p_b = 5  => 0.1438670233,
    s2_c_fammar_p_b = 6  => 0.1909682357,
    s2_c_fammar_p_b = 7  => 0.2376690154,
    s2_c_fammar_p_b = 8  => 0.3071646341,
    s2_c_fammar_p_b = 9  => 0.4194226725,
                            0.1811835894));

s2_c_low_hval_b :=  __common__( map(
    (C_LOW_HVAL in ['', '0', '-1']) => -1,
    (real)C_LOW_HVAL <= 1.8       => 1,
    (real)C_LOW_HVAL <= 3.2       => 2,
    (real)C_LOW_HVAL <= 22.3      => 3,
    (real)C_LOW_HVAL <= 45.9      => 4,
    (real)C_LOW_HVAL <= 65        => 5,
                                       6));

s2_c_low_hval_b_m :=  __common__( map(
    s2_c_low_hval_b = -1 => 0.1719556826,
    s2_c_low_hval_b = 1  => 0.1412809473,
    s2_c_low_hval_b = 2  => 0.148385131,
    s2_c_low_hval_b = 3  => 0.1764748047,
    s2_c_low_hval_b = 4  => 0.1875447387,
    s2_c_low_hval_b = 5  => 0.2064719359,
    s2_c_low_hval_b = 6  => 0.2879221523,
                            0.1811835894));

s2_c_high_ed_b :=  __common__( map(
    (C_HIGH_ED in ['', '0', '-1']) => -1,
    (real)C_HIGH_ED <= 6.5       => 9,
    (real)C_HIGH_ED <= 9.9       => 8,
    (real)C_HIGH_ED <= 13.3      => 7,
    (real)C_HIGH_ED <= 17.1      => 6,
    (real)C_HIGH_ED <= 21.6      => 5,
    (real)C_HIGH_ED <= 26.9      => 4,
    (real)C_HIGH_ED <= 33.5      => 3,
    (real)C_HIGH_ED <= 41.9      => 2,
                                      1));

s2_c_high_ed_b_m :=  __common__( map(
    s2_c_high_ed_b = -1 => 0.1269900037,
    s2_c_high_ed_b = 1  => 0.1171800268,
    s2_c_high_ed_b = 2  => 0.1265118065,
    s2_c_high_ed_b = 3  => 0.14066103,
    s2_c_high_ed_b = 4  => 0.1623389113,
    s2_c_high_ed_b = 5  => 0.1728536075,
    s2_c_high_ed_b = 6  => 0.1978682171,
    s2_c_high_ed_b = 7  => 0.2118867925,
    s2_c_high_ed_b = 8  => 0.2596545702,
    s2_c_high_ed_b = 9  => 0.3339701949,
                           0.1811835894));

s2_c_unemp_b :=  __common__( map(
    (C_UNEMP in ['', '0', '-1']) => -1,
    (real)C_UNEMP <= 1.1       => 1,
    (real)C_UNEMP <= 1.6       => 2,
    (real)C_UNEMP <= 2.1       => 3,
    (real)C_UNEMP <= 2.6       => 4,
    (real)C_UNEMP <= 3.1       => 5,
    (real)C_UNEMP <= 3.7       => 6,
    (real)C_UNEMP <= 4.5       => 7,
    (real)C_UNEMP <= 5.7       => 8,
    (real)C_UNEMP <= 7.8       => 9,
                                    10));

s2_c_unemp_b_m :=  __common__( map(
    s2_c_unemp_b = -1 => 0.0985106383,
    s2_c_unemp_b = 1  => 0.1051181102,
    s2_c_unemp_b = 2  => 0.1199835357,
    s2_c_unemp_b = 3  => 0.1364157432,
    s2_c_unemp_b = 4  => 0.1490188062,
    s2_c_unemp_b = 5  => 0.1596346237,
    s2_c_unemp_b = 6  => 0.1640595193,
    s2_c_unemp_b = 7  => 0.1872716785,
    s2_c_unemp_b = 8  => 0.225800079,
    s2_c_unemp_b = 9  => 0.2855116515,
    s2_c_unemp_b = 10 => 0.3550552923,
                         0.1811835894));

s2_c_burglary_b :=  __common__( map(
    (C_BURGLARY in ['', '0', '-1']) => -1,
    (real)C_BURGLARY <= 87        => 1,
    (real)C_BURGLARY <= 126       => 2,
    (real)C_BURGLARY <= 145       => 3,
    (real)C_BURGLARY <= 162       => 4,
    (real)C_BURGLARY <= 179       => 5,
                                       6));

s2_c_burglary_b_m :=  __common__( map(
    s2_c_burglary_b = -1 => 0.0731058928,
    s2_c_burglary_b = 1  => 0.144650411,
    s2_c_burglary_b = 2  => 0.1451990632,
    s2_c_burglary_b = 3  => 0.1970074813,
    s2_c_burglary_b = 4  => 0.2219709817,
    s2_c_burglary_b = 5  => 0.2741543637,
    s2_c_burglary_b = 6  => 0.2992156863,
                            0.1811835894));

s2_c_cartheft_b :=  __common__( map(
    (C_CARTHEFT in ['', '0', '-1']) => -1,
    (real)C_CARTHEFT <= 21        => 1,
    (real)C_CARTHEFT <= 98        => 2,
    (real)C_CARTHEFT <= 138       => 3,
    (real)C_CARTHEFT <= 182       => 4,
                                       5));

s2_c_cartheft_b_m :=  __common__( map(
    s2_c_cartheft_b = -1 => 0.0785525154,
    s2_c_cartheft_b = 1  => 0.0836302269,
    s2_c_cartheft_b = 2  => 0.1172609841,
    s2_c_cartheft_b = 3  => 0.1940689054,
    s2_c_cartheft_b = 4  => 0.2659800451,
    s2_c_cartheft_b = 5  => 0.350606994,
                            0.1811835894));

s2_c_agriculture_b :=  __common__( map(
    (C_AGRICULTURE in ['', '0', '-1']) => -1,
    (real)C_AGRICULTURE <= 0.1       => 2,
                                          1));

s2_c_agriculture_b_m :=  __common__( map(
    s2_c_agriculture_b = -1 => 0.1867898419,
    s2_c_agriculture_b = 1  => 0.0867138072,
    s2_c_agriculture_b = 2  => 0.1423650976,
                               0.1811835894));

s2_c_born_usa_b :=  __common__( map(
    (C_BORN_USA in ['', '0', '-1']) => -1,
    (real)C_BORN_USA <= 11        => 7,
    (real)C_BORN_USA <= 25        => 6,
    (real)C_BORN_USA <= 39        => 5,
    (real)C_BORN_USA <= 54        => 4,
    (real)C_BORN_USA <= 70        => 3,
    (real)C_BORN_USA <= 88        => 2,
                                       1));

s2_c_born_usa_b_m :=  __common__( map(
    s2_c_born_usa_b = -1 => 0.0743613139,
    s2_c_born_usa_b = 1  => 0.1364391889,
    s2_c_born_usa_b = 2  => 0.1482596425,
    s2_c_born_usa_b = 3  => 0.1524043923,
    s2_c_born_usa_b = 4  => 0.1873680169,
    s2_c_born_usa_b = 5  => 0.2225615575,
    s2_c_born_usa_b = 6  => 0.2766925849,
    s2_c_born_usa_b = 7  => 0.3228301887,
                            0.1811835894));

s2_07_logit :=  __common__( -19.01024232 +
    (integer)s2_apt * 0.3124179495 +
    (integer)s2_nap0 * 0.3252923309 +
    (integer)s2_nap1_6 * 0.3977788943 +
    (integer)s2_nap12 * -0.629393443 +
    (integer)ver_src_d * -0.106341469 +
    (integer)ver_src_em * -0.118779162 +
    s2_ver_src_p_m * 3.3024135626 +
    s2_name_eda_m * 7.0460937967 +
    (integer)s2_altlname * 0.3072450556 +
    s2_add_bestmatch_level_m * 2.1597685387 +
    s2_addmatch_m * 5.773615738 +
    s2_add1_lres_m * 1.5332699086 +
    (integer)s2_addrs_15yr_0 * 0.5731565112 +
    s2_combo_dobscore_m * 4.9835944358 +
    s2_infutor_m * 2.8156182588 +
    s2_util_adl_nap_m * 5.1233230479 +
    s2_ams_m * 6.3906972924 +
    s2_add1_avm_to_med_ratio_m * 1.455471116 +
    s2_add2_building_area_m * 4.7826062886 +
    (integer)s2_derog * 0.5678758604 +
    s2_adlperssn_m * 2.5619691078 +
    s2_ssns_per_addr_m * 1.4463793892 +
    (integer)s2_ssns_per_adl_c6 * 0.3861223496 +
    s2_phones_per_adl_c6_m * 12.073436673 +
    s2_ssns_per_addr_c6_m * 2.1753024565 +
    s2_phones_per_addr_c6_m * 1.2866357769 +
    s2_inq_count01_m * 3.4055502331 +
    s2_inq_peraddr_m * 1.2220224177 +
    s2_inq_adlsperphone_m * 2.2560154972 +
    s2_rel_felony_m * 3.6673419636 +
    s2_c_fammar_p_b_m * 2.1834139774 +
    s2_c_low_hval_b_m * 1.5989346083 +
    s2_c_high_ed_b_m * 2.4871563503 +
    s2_c_unemp_b_m * 1.1828855785 +
    s2_c_burglary_b_m * 0.9061085199 +
    s2_c_cartheft_b_m * 2.0063017229 +
    s2_c_agriculture_b_m * 2.4084738023 +
    s2_c_born_usa_b_m * 2.1242795615);

add1_building_area_s3 :=  __common__( map(
    (add1_building_area in ['', '0'])    => -1,
    (real)add1_building_area <= 1240   => 7,
    (real)add1_building_area <= 1320   => 6,
    (real)add1_building_area <= 1528   => 5,
    (real)add1_building_area <= 4290   => 4,
    (real)add1_building_area <= 17000  => 3,
    (real)add1_building_area <= 148793 => 2,
                                            1));

add1_building_area_s3_m :=  __common__( map(
    add1_building_area_s3 = -1 => 0.1502590674,
    add1_building_area_s3 = 1  => 0.0652173913,
    add1_building_area_s3 = 2  => 0.0972222222,
    add1_building_area_s3 = 3  => 0.125,
    add1_building_area_s3 = 4  => 0.1346389229,
    add1_building_area_s3 = 5  => 0.2085889571,
    add1_building_area_s3 = 6  => 0.2375,
    add1_building_area_s3 = 7  => 0.1981707317,
                                  0.1517223911));

input_dob_age_s3 :=  __common__( map(
    (input_dob_age in ['', '0']) => -1,
    (real)input_dob_age <= 17  => 9,
    (real)input_dob_age <= 18  => 8,
    (real)input_dob_age <= 19  => 7,
    (real)input_dob_age <= 23  => 6,
    (real)input_dob_age <= 28  => 5,
    (real)input_dob_age <= 31  => 4,
    (real)input_dob_age <= 42  => 3,
    (real)input_dob_age <= 64  => 2,
                                    1));

input_dob_age_s3_m :=  __common__( map(
    input_dob_age_s3 = -1 => 0.25,
    input_dob_age_s3 = 1  => 0.1041666667,
    input_dob_age_s3 = 2  => 0.0978618421,
    input_dob_age_s3 = 3  => 0.1235370611,
    input_dob_age_s3 = 4  => 0.1727748691,
    input_dob_age_s3 = 5  => 0.1793478261,
    input_dob_age_s3 = 6  => 0.2196382429,
    input_dob_age_s3 = 7  => 0.2321428571,
    input_dob_age_s3 = 8  => 0.2544987147,
    input_dob_age_s3 = 9  => 0.3166666667,
                             0.1517223911));

c_vacant_p_s3 :=  __common__( map(
    (C_VACANT_P in ['', '0', '-1']) => -1,
    (real)C_VACANT_P <= 1.7       => 1,
    (real)C_VACANT_P <= 10.5      => 2,
                                       3));

c_vacant_p_s3_m :=  __common__( map(
    c_vacant_p_s3 = -1 => 0.1977818854,
    c_vacant_p_s3 = 1  => 0.0889570552,
    c_vacant_p_s3 = 2  => 0.1401405539,
    c_vacant_p_s3 = 3  => 0.1873111782,
                          0.1517223911));

c_sfdu_p_s3 :=  __common__( map(
    (C_SFDU_P in ['', '0', '-1']) => -1,
    (real)C_SFDU_P <= 9.5       => 6,
    (real)C_SFDU_P <= 25.7      => 5,
    (real)C_SFDU_P <= 41.1      => 4,
    (real)C_SFDU_P <= 84.2      => 3,
    (real)C_SFDU_P <= 96.6      => 2,
                                     1));

c_sfdu_p_s3_m :=  __common__( map(
    c_sfdu_p_s3 = -1 => 0.1735159817,
    c_sfdu_p_s3 = 1  => 0.0853333333,
    c_sfdu_p_s3 = 2  => 0.1033557047,
    c_sfdu_p_s3 = 3  => 0.1254191818,
    c_sfdu_p_s3 = 4  => 0.179144385,
    c_sfdu_p_s3 = 5  => 0.2607526882,
    c_sfdu_p_s3 = 6  => 0.2715053763,
                        0.1517223911));

c_high_ed_s3 :=  __common__( map(
    (C_HIGH_ED in ['', '0', '-1']) => -1,
    (real)C_HIGH_ED <= 6.6       => 6,
    (real)C_HIGH_ED <= 13.9      => 5,
    (real)C_HIGH_ED <= 18.3      => 4,
    (real)C_HIGH_ED <= 34.7      => 3,
    (real)C_HIGH_ED <= 55.7      => 2,
                                      1));

c_high_ed_s3_m :=  __common__( map(
    c_high_ed_s3 = -1 => 0.2121212121,
    c_high_ed_s3 = 1  => 0.0956072351,
    c_high_ed_s3 = 2  => 0.1028277635,
    c_high_ed_s3 = 3  => 0.1337907376,
    c_high_ed_s3 = 4  => 0.1528497409,
    c_high_ed_s3 = 5  => 0.1899224806,
    c_high_ed_s3 = 6  => 0.2710997442,
                         0.1517223911));

c_cartheft_s3 :=  __common__( map(
    (C_CARTHEFT in ['', '0', '-1']) => -1,
    (real)C_CARTHEFT <= 64        => 1,
    (real)C_CARTHEFT <= 143       => 2,
    (real)C_CARTHEFT <= 181       => 3,
                                       4));

c_cartheft_s3_m :=  __common__( map(
    c_cartheft_s3 = -1 => 0.2264150943,
    c_cartheft_s3 = 1  => 0.096498719,
    c_cartheft_s3 = 2  => 0.11,
    c_cartheft_s3 = 3  => 0.2196850394,
    c_cartheft_s3 = 4  => 0.209039548,
                          0.1517223911));

c_unempl_s3 :=  __common__( map(
    (C_UNEMPL in ['', '0', '-1']) => -1,
    (real)C_UNEMPL <= 71        => 1,
    (real)C_UNEMPL <= 84        => 2,
    (real)C_UNEMPL <= 99        => 3,
    (real)C_UNEMPL <= 143       => 4,
    (real)C_UNEMPL <= 167       => 5,
                                     6));

c_unempl_s3_m :=  __common__( map(
    c_unempl_s3 = -1 => 0.2,
    c_unempl_s3 = 1  => 0.0992366412,
    c_unempl_s3 = 2  => 0.0987012987,
    c_unempl_s3 = 3  => 0.1436031332,
    c_unempl_s3 = 4  => 0.1563820795,
    c_unempl_s3 = 5  => 0.2092457421,
    c_unempl_s3 = 6  => 0.2997275204,
                        0.1517223911));

s3_phonerisk :=  __common__( (rc_hriskphoneflag in ['1', '2', '3', '5']) or rc_phonezipflag = (string)1);

s3_other_risk :=  __common__( (integer)rc_non_us_ssn = 1 or rc_ssnvalflag = (string)1 or rc_pwssnvalflag = (string)4 or (adl_category in ['1 DEAD', '2 NOISE', '5 INACTIVE']) or did2_felony_count > 0 or did3_felony_count > 0 or did3_liens_hist_unrel_count > 0 or nap_status = 'D' or (boolean)(integer)ver_src_nas_de or (integer)email_src_im > 0 or Inq_HighRiskCredit_count12 > 0 or Inq_PerAddr > 4 or Inq_PerPhone > 7 or rel_criminal_count > 2 or rel_bankrupt_count > 4 or rel_felony_count > 0);

s3_mth_rc_ssnlowissue :=  __common__( 0 < mth_rc_ssnlowissue AND mth_rc_ssnlowissue < 60);

s3_nap :=  __common__( map(
    nap_summary = 12 => 1,
    nap_summary = 11 => 1,
    nap_summary = 1  => 6,
    nap_summary = 0  => 5,
    nap_summary <= 6 => 4,
                        3));

s3_nap_m :=  __common__( map(
    s3_nap = 1 => 0.0287539936,
    s3_nap = 3 => 0.0983606557,
    s3_nap = 4 => 0.263803681,
    s3_nap = 5 => 0.1487179487,
    s3_nap = 6 => 0.2615384615,
                  0.1517223911));

s3_rc_dirsaddr_lastscore :=  __common__( map(
    rc_dirsaddr_lastscore = 100 => 1,
    rc_dirsaddr_lastscore = 255 => -1,
    rc_dirsaddr_lastscore >= 10 => 2,
                                   3));

s3_rc_dirsaddr_lastscore_m :=  __common__( map(
    s3_rc_dirsaddr_lastscore = -1 => 0.1271701389,
    s3_rc_dirsaddr_lastscore = 1  => 0.0936739659,
    s3_rc_dirsaddr_lastscore = 2  => 0.2620967742,
    s3_rc_dirsaddr_lastscore = 3  => 0.4358974359,
                                     0.1517223911));

s3_addrs_per_adl_c6_1 :=  __common__( min(4, if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6)));

s3_addrs_per_adl_c6 :=  __common__( if(s3_addrs_per_adl_c6_1 = 2, 1, s3_addrs_per_adl_c6_1));

s3_addrs_per_adl_c6_m :=  __common__( map(
    s3_addrs_per_adl_c6 = 0 => 0.1480569239,
    s3_addrs_per_adl_c6 = 1 => 0.1705069124,
    s3_addrs_per_adl_c6 = 3 => 0.2558139535,
    s3_addrs_per_adl_c6 = 4 => 0.2941176471,
                               0.1517223911));

s3_phones_per_adl_c6 :=  __common__( min(1, if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6)));

s3_05_logit :=  __common__( -9.02847362 +
    rc_utiliaddr_addrcount * 0.3838802694 +
    add1_building_area_s3_m * 5.81114544 +
    input_dob_age_s3_m * 4.2840837202 +
    c_vacant_p_s3_m * 3.9870132989 +
    c_sfdu_p_s3_m * 3.3545765569 +
    c_high_ed_s3_m * 4.2268025874 +
    c_cartheft_s3_m * 3.7967754197 +
    c_unempl_s3_m * 2.0437727879 +
    (integer)s3_phonerisk * 0.6060373954 +
    (integer)s3_other_risk * 0.6231288398 +
    (integer)s3_mth_rc_ssnlowissue * 0.6183361771 +
    s3_nap_m * 4.8558746199 +
    s3_rc_dirsaddr_lastscore_m * 3.9138745611 +
    (integer)add1_applicant_owned * -1.072779949 +
    s3_addrs_per_adl_c6_m * 4.9443378982 +
    s3_phones_per_adl_c6 * 0.9156134797);

s4_ssn_risk :=  __common__( (integer)rc_non_us_ssn = 1 or rc_decsflag = (string)1 or rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1 or rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3', '4']) or (integer)rc_ssnmiskeyflag = 1);

s4_car_current :=  __common__( current_count > 0);

input_dob_age_s4 :=  __common__( map(
    (input_dob_age in ['', '0']) => -1,
    (integer)input_dob_age <= 18  => 2,
                                    1));

input_dob_age_s4_m :=  __common__( map(
    input_dob_age_s4 = -1 => 0.625,
    input_dob_age_s4 = 1  => 0.0246156121,
    input_dob_age_s4 = 2  => 0.046018992,
                             0.025815074));

combo_dobscore_s4 :=  __common__( map(
    (combo_dobscore in [NULL, 255]) => -1,
    combo_dobscore <= 96            => 2,
                                       1));

combo_dobscore_s4_m :=  __common__( map(
    combo_dobscore_s4 = -1 => 0.0395320694,
    combo_dobscore_s4 = 1  => 0.0148959081,
    combo_dobscore_s4 = 2  => 0.0516379789,
                              0.025815074));

add1_lres_s4 :=  __common__( map(
    (add1_lres in [NULL, 0]) => -1,
    add1_lres <= 1           => 7,
    add1_lres <= 2           => 6,
    add1_lres <= 4           => 5,
    add1_lres <= 6           => 4,
    add1_lres <= 11          => 3,
    add1_lres <= 23          => 2,
                                1));

add1_lres_s4_m :=  __common__( map(
    add1_lres_s4 = -1 => 0.1096385542,
    add1_lres_s4 = 1  => 0.0166855495,
    add1_lres_s4 = 2  => 0.0174002047,
    add1_lres_s4 = 3  => 0.0223655914,
    add1_lres_s4 = 4  => 0.0314685315,
    add1_lres_s4 = 5  => 0.0365209034,
    add1_lres_s4 = 6  => 0.0405405405,
    add1_lres_s4 = 7  => 0.0623901582,
                         0.025815074));

c_fammar_p_s4 :=  __common__( map(
    (C_FAMMAR_P in ['', '0', '-1']) => -1,
    (real)C_FAMMAR_P <= 51.7      => 5,
    (real)C_FAMMAR_P <= 61.3      => 4,
    (real)C_FAMMAR_P <= 67.3      => 3,
    (real)C_FAMMAR_P <= 71.7      => 2,
                                       1));

c_fammar_p_s4_m :=  __common__( map(
    c_fammar_p_s4 = -1 => 0.0475285171,
    c_fammar_p_s4 = 1  => 0.0179970105,
    c_fammar_p_s4 = 2  => 0.025540972,
    c_fammar_p_s4 = 3  => 0.0287253142,
    c_fammar_p_s4 = 4  => 0.0318539728,
    c_fammar_p_s4 = 5  => 0.0599856322,
                          0.025815074));

c_ownocc_p_s4 :=  __common__( map(
    (C_OWNOCC_P in ['', '0', '-1']) => -1,
    (real)C_OWNOCC_P <= 9.1       => 4,
    (real)C_OWNOCC_P <= 18.8      => 3,
    (real)C_OWNOCC_P <= 88        => 2,
                                       1));

c_ownocc_p_s4_m :=  __common__( map(
    c_ownocc_p_s4 = -1 => 0.0456730769,
    c_ownocc_p_s4 = 1  => 0.0154753132,
    c_ownocc_p_s4 = 2  => 0.0221299411,
    c_ownocc_p_s4 = 3  => 0.0285609667,
    c_ownocc_p_s4 = 4  => 0.0500736377,
                          0.025815074));

c_low_hval_s4 :=  __common__( map(
    (C_LOW_HVAL in ['', '0', '-1']) => -1,
    (real)C_LOW_HVAL <= 1.5       => 1,
    (real)C_LOW_HVAL <= 3.7       => 2,
    (real)C_LOW_HVAL <= 5.7       => 3,
    (real)C_LOW_HVAL <= 8.6       => 4,
    (real)C_LOW_HVAL <= 19.7      => 5,
    (real)C_LOW_HVAL <= 31.2      => 6,
    (real)C_LOW_HVAL <= 52.2      => 7,
                                       8));

c_low_hval_s4_m :=  __common__( map(
    c_low_hval_s4 = -1 => 0.0258816407,
    c_low_hval_s4 = 1  => 0.0160359205,
    c_low_hval_s4 = 2  => 0.0178271107,
    c_low_hval_s4 = 3  => 0.0187032419,
    c_low_hval_s4 = 4  => 0.0202565834,
    c_low_hval_s4 = 5  => 0.0237076062,
    c_low_hval_s4 = 6  => 0.0230263158,
    c_low_hval_s4 = 7  => 0.0354330709,
    c_low_hval_s4 = 8  => 0.0611439842,
                          0.025815074));

c_high_ed_s4 :=  __common__( map(
    (C_HIGH_ED in ['', '0', '-1']) => -1,
    (real)C_HIGH_ED <= 7         => 6,
    (real)C_HIGH_ED <= 11        => 5,
    (real)C_HIGH_ED <= 15        => 4,
    (real)C_HIGH_ED <= 24        => 3,
    (real)C_HIGH_ED <= 29.5      => 2,
                                      1));

c_high_ed_s4_m :=  __common__( map(
    c_high_ed_s4 = -1 => 0.0396039604,
    c_high_ed_s4 = 1  => 0.0166187567,
    c_high_ed_s4 = 2  => 0.0247223217,
    c_high_ed_s4 = 3  => 0.0240617705,
    c_high_ed_s4 = 4  => 0.031462281,
    c_high_ed_s4 = 5  => 0.0316774658,
    c_high_ed_s4 = 6  => 0.0528985507,
                         0.025815074));

c_cartheft_s4 :=  __common__( map(
    (C_CARTHEFT in ['', '0', '-1']) => -1,
    (real)C_CARTHEFT <= 27        => 1,
    (real)C_CARTHEFT <= 65        => 2,
    (real)C_CARTHEFT <= 137       => 3,
    (real)C_CARTHEFT <= 181       => 4,
                                       5));

c_cartheft_s4_m :=  __common__( map(
    c_cartheft_s4 = -1 => 0.0208768267,
    c_cartheft_s4 = 1  => 0.009148487,
    c_cartheft_s4 = 2  => 0.0125692373,
    c_cartheft_s4 = 3  => 0.0207591015,
    c_cartheft_s4 = 4  => 0.0334409181,
    c_cartheft_s4 = 5  => 0.046991812,
                          0.025815074));

add_bestmatch_level_s4_m :=  __common__( map(
    add_bestmatch_level_1 = 0 => 0.0171187405,
    add_bestmatch_level_1 = 1 => 0.041322314,
    add_bestmatch_level_1 = 2 => 0.0536188285,
                                 0.025815074));

_ssn_score_s4_m :=  __common__( map(
    _ssn_score = -1 => 0.2534246575,
    _ssn_score = 1  => 0.0202442275,
    _ssn_score = 2  => 0.0555555556,
    _ssn_score = 3  => 0.478021978,
                         0.025815074));

_rel_criminal_total_1 :=  __common__( min(4, if(rel_criminal_total = NULL, -NULL, rel_criminal_total)));

_rel_criminal_total_s4_m :=  __common__( map(
    _rel_criminal_total_1 = 0 => 0.0241950238,
    _rel_criminal_total_1 = 1 => 0.0228239845,
    _rel_criminal_total_1 = 2 => 0.0167400881,
    _rel_criminal_total_1 = 3 => 0.0260336907,
    _rel_criminal_total_1 = 4 => 0.0500910747,
                                 0.025815074));

s4_nap :=  __common__( map(
    nap_summary = 12 => 1,
    nap_summary = 11 => 1,
    nap_summary = 1  => 6,
    nap_summary = 0  => 5,
    nap_summary <= 6 => 4,
                        3));

s4_nap_m :=  __common__( map(
    s4_nap = 1 => 0.0089686099,
    s4_nap = 3 => 0.0179432244,
    s4_nap = 4 => 0.024642753,
    s4_nap = 5 => 0.0344600527,
    s4_nap = 6 => 0.0743243243,
                  0.025815074));

s4_ver_src_nas_eq12 :=  __common__( ver_src_nas_eq = 12);

s4_ver_src_nas_en12 :=  __common__( ver_src_nas_en = 12);

s4_mth_header_first_seen :=  __common__( map(
    mth_header_first_seen < 6   => 5,
    mth_header_first_seen < 12  => 4,
    mth_header_first_seen < 60  => 3,
    mth_header_first_seen < 120 => 2,
                                   1));

s4_mth_header_first_seen_m :=  __common__( map(
    s4_mth_header_first_seen = 1 => 0.0310015898,
    s4_mth_header_first_seen = 2 => 0.0228613569,
    s4_mth_header_first_seen = 3 => 0.017769644,
    s4_mth_header_first_seen = 4 => 0.0364482358,
    s4_mth_header_first_seen = 5 => 0.078817734,
                                    0.025815074));

s4_ssns_per_adl :=  __common__( map(
    ssns_per_adl = 0 => 3,
    ssns_per_adl = 1 => 1,
    ssns_per_adl = 2 => 2,
                        3));

s4_ssns_per_adl_m :=  __common__( map(
    s4_ssns_per_adl = 1 => 0.0227228284,
    s4_ssns_per_adl = 2 => 0.0313293819,
    s4_ssns_per_adl = 3 => 0.1573705179,
                           0.025815074));

s4_adlperssn_count :=  __common__( if(adlperssn_count = 0, 4, min(4, if(adlperssn_count = NULL, -NULL, adlperssn_count))));

s4_adlperssn_count_m :=  __common__( map(
    s4_adlperssn_count = 1 => 0.0181740126,
    s4_adlperssn_count = 2 => 0.0305949008,
    s4_adlperssn_count = 3 => 0.0434120335,
    s4_adlperssn_count = 4 => 0.1556329849,
                              0.025815074));

s4_ssns_per_adl_c6 :=  __common__( min(2, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6)));

s4_ssns_per_adl_c6_m :=  __common__( map(
    s4_ssns_per_adl_c6 = 0 => 0.0195924251,
    s4_ssns_per_adl_c6 = 1 => 0.0317472699,
    s4_ssns_per_adl_c6 = 2 => 0.0795454545,
                              0.025815074));

s4_ssns_per_addr_c6 :=  __common__( if(ssns_per_addr_c6 <= 5, min(4, if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6)), min(7, if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6))));

s4_ssns_per_addr_c6_m :=  __common__( map(
    s4_ssns_per_addr_c6 = 0 => 0.024222026,
    s4_ssns_per_addr_c6 = 1 => 0.0197860963,
    s4_ssns_per_addr_c6 = 2 => 0.0286144578,
    s4_ssns_per_addr_c6 = 3 => 0.0292294066,
    s4_ssns_per_addr_c6 = 4 => 0.0507692308,
    s4_ssns_per_addr_c6 = 6 => 0.1052631579,
    s4_ssns_per_addr_c6 = 7 => 0.1893491124,
                               0.025815074));

s4_inq_count01 :=  __common__( min(3, if(Inq_count01 = NULL, -NULL, Inq_count01)));

s4_inq_count01_m :=  __common__( map(
    s4_inq_count01 = 0 => 0.0247803559,
    s4_inq_count01 = 1 => 0.0369733448,
    s4_inq_count01 = 2 => 0.0467980296,
    s4_inq_count01 = 3 => 0.052173913,
                          0.025815074));

s4_inq_riskcount :=  __common__( Inq_Collection_count03 > 0 or Inq_HighRiskCredit_count > 0);

s4_inq_peraddr :=  __common__( Inq_PerAddr > 4);

s4_addr_stability_v2 :=  __common__( min(2, if(addr_stability_v2 = '', -NULL, (unsigned1)addr_stability_v2)));

s4_addr_stability_v2_m :=  __common__( map(
    s4_addr_stability_v2 = 0 => 0.0449012713,
    s4_addr_stability_v2 = 1 => 0.0418300654,
    s4_addr_stability_v2 = 2 => 0.0167597765,
                                0.025815074));

s4_infutor_nap :=  __common__( map(
    infutor_nap >= 11 => 1,
    infutor_nap = 0   => 3,
    infutor_nap = 1   => 4,
                         2));

s4_infutor_nap_m :=  __common__( map(
    s4_infutor_nap = 1 => 0.0091348737,
    s4_infutor_nap = 2 => 0.0185185185,
    s4_infutor_nap = 3 => 0.0284991799,
    s4_infutor_nap = 4 => 0.032967033,
                          0.025815074));

s4_combo_addrcount :=  __common__( min(4, if(combo_addrcount = NULL, -NULL, combo_addrcount)));

s4_combo_addrcount_m :=  __common__( map(
    s4_combo_addrcount = 1 => 0.0824235808,
    s4_combo_addrcount = 2 => 0.0350787132,
    s4_combo_addrcount = 3 => 0.0211414572,
    s4_combo_addrcount = 4 => 0.01489318,
                              0.025815074));

s4_rel_criminal_count :=  __common__( max(1, min(5, if(rel_criminal_count = NULL, -NULL, rel_criminal_count))));

s4_rel_criminal_count_m :=  __common__( map(
    s4_rel_criminal_count = 1 => 0.0238898584,
    s4_rel_criminal_count = 2 => 0.0316981132,
    s4_rel_criminal_count = 3 => 0.043902439,
    s4_rel_criminal_count = 4 => 0.0524590164,
    s4_rel_criminal_count = 5 => 0.0818858561,
                                 0.025815074));

s4_rc_altlname :=  __common__( (integer)rc_altlname1_flag > 0 or (integer)rc_altlname2_flag > 0);

s4_05_logit :=  __common__( -12.0981153 +
    (integer)s4_ssn_risk * 0.3792943153 +
    (integer)lname_eda_sourced * 1.2143955074 +
    (integer)rc_input_addr_not_most_recent * 0.5850603886 +
    (integer)utility_sourced * -0.338665199 +
    (integer)s4_car_current * 0.3272089555 +
    input_dob_age_s4_m * 6.5222757421 +
    combo_dobscore_s4_m * 27.330090814 +
    add1_lres_s4_m * 7.5104427232 +
    c_fammar_p_s4_m * 8.9883276267 +
    c_ownocc_p_s4_m * 21.679526179 +
    c_low_hval_s4_m * 13.019612368 +
    c_high_ed_s4_m * 14.426078609 +
    c_cartheft_s4_m * 29.555618973 +
    add_bestmatch_level_s4_m * 21.470438275 +
    _ssn_score_s4_m * 4.9109735217 +
    _rel_criminal_total_s4_m * 21.134775199 +
    s4_nap_m * 20.361911761 +
    (integer)s4_ver_src_nas_eq12 * -1.00402561 +
    (integer)s4_ver_src_nas_en12 * -0.341403703 +
    s4_mth_header_first_seen_m * 5.3841775361 +
    s4_ssns_per_adl_m * 3.1254463833 +
    s4_adlperssn_count_m * 4.0798470183 +
    s4_ssns_per_adl_c6_m * 9.5620209253 +
    s4_ssns_per_addr_c6_m * 10.915541255 +
    s4_inq_count01_m * 18.386949133 +
    (integer)s4_inq_riskcount * 0.5783616241 +
    (integer)s4_inq_peraddr * 0.6431051936 +
    s4_addr_stability_v2_m * 12.041321014 +
    s4_infutor_nap_m * 26.295371649 +
    (integer)add1_house_number_match * 0.7958044213 +
    (integer)add1_family_owned * -0.592334691 +
    s4_combo_addrcount_m * -5.696177857 +
    s4_rel_criminal_count_m * 12.531868055 +
    (integer)s4_rc_altlname * 0.8128349418);

s5_ssn_risk :=  __common__( (integer)rc_non_us_ssn = 1 or rc_decsflag = (string)1 or rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1 or rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3', '4']) or (integer)rc_ssnmiskeyflag = 1);

input_dob_age_s5 :=  __common__( map(
    (input_dob_age in ['', '0']) => -1,
    (integer)input_dob_age <= 25  => 2,
                                    1));

input_dob_age_s5_m :=  __common__( map(
    input_dob_age_s5 = -1 => 0.9,
    input_dob_age_s5 = 1  => 0.0665473307,
    input_dob_age_s5 = 2  => 0.134529148,
                             0.0704310258));

combo_dobscore_s5 :=  __common__( map(
    (combo_dobscore in [NULL, 255]) => -1,
    combo_dobscore <= 96            => 2,
                                       1));

combo_dobscore_s5_m :=  __common__( map(
    combo_dobscore_s5 = -1 => 0.3008849558,
    combo_dobscore_s5 = 1  => 0.0569000753,
    combo_dobscore_s5 = 2  => 0.2541436464,
                              0.0704310258));

c_fammar_p_s5 :=  __common__( map(
    (C_FAMMAR_P in ['', '0', '-1']) => -1,
    (real)C_FAMMAR_P <= 52.6      => 9,
    (real)C_FAMMAR_P <= 64.9      => 8,
    (real)C_FAMMAR_P <= 71.3      => 7,
    (real)C_FAMMAR_P <= 79.7      => 6,
    (real)C_FAMMAR_P <= 82.9      => 5,
    (real)C_FAMMAR_P <= 85.8      => 4,
    (real)C_FAMMAR_P <= 88.6      => 3,
    (real)C_FAMMAR_P <= 91.6      => 2,
                                       1));

c_fammar_p_s5_m :=  __common__( map(
    c_fammar_p_s5 = -1 => 0.1147540984,
    c_fammar_p_s5 = 1  => 0.0362537764,
    c_fammar_p_s5 = 2  => 0.0379487179,
    c_fammar_p_s5 = 3  => 0.0398803589,
    c_fammar_p_s5 = 4  => 0.0450819672,
    c_fammar_p_s5 = 5  => 0.0463242699,
    c_fammar_p_s5 = 6  => 0.0635080645,
    c_fammar_p_s5 = 7  => 0.0817356206,
    c_fammar_p_s5 = 8  => 0.1038306452,
    c_fammar_p_s5 = 9  => 0.1837563452,
                          0.0704310258));

c_lowinc_s5 :=  __common__( map(
    (C_LOWINC in ['', '0', '-1']) => -1,
    (real)C_LOWINC <= 10.1      => 1,
    (real)C_LOWINC <= 23.5      => 2,
    (real)C_LOWINC <= 28.5      => 3,
    (real)C_LOWINC <= 33.6      => 4,
    (real)C_LOWINC <= 39.3      => 5,
    (real)C_LOWINC <= 46.7      => 6,
    (real)C_LOWINC <= 56.2      => 7,
                                     8));

c_lowinc_s5_m :=  __common__( map(
    c_lowinc_s5 = -1 => 0.0833333333,
    c_lowinc_s5 = 1  => 0.0400822199,
    c_lowinc_s5 = 2  => 0.0494117647,
    c_lowinc_s5 = 3  => 0.0527363184,
    c_lowinc_s5 = 4  => 0.0641547862,
    c_lowinc_s5 = 5  => 0.0664621677,
    c_lowinc_s5 = 6  => 0.0782347041,
    c_lowinc_s5 = 7  => 0.0834181078,
    c_lowinc_s5 = 8  => 0.1700404858,
                        0.0704310258));

c_cartheft_s5 :=  __common__( map(
    (C_CARTHEFT in ['', '0', '-1']) => -1,
    (real)C_CARTHEFT <= 19        => 1,
    (real)C_CARTHEFT <= 65        => 2,
    (real)C_CARTHEFT <= 98        => 3,
    (real)C_CARTHEFT <= 138       => 4,
    (real)C_CARTHEFT <= 158       => 5,
    (real)C_CARTHEFT <= 177       => 6,
                                       7));

c_cartheft_s5_m :=  __common__( map(
    c_cartheft_s5 = -1 => 0.1153846154,
    c_cartheft_s5 = 1  => 0.02672148,
    c_cartheft_s5 = 2  => 0.0510471204,
    c_cartheft_s5 = 3  => 0.0425436632,
    c_cartheft_s5 = 4  => 0.0552995392,
    c_cartheft_s5 = 5  => 0.0983188996,
    c_cartheft_s5 = 6  => 0.1087866109,
    c_cartheft_s5 = 7  => 0.1298828125,
                          0.0704310258));

c_span_lang_s5 :=  __common__( map(
    (C_SPAN_LANG in ['', '0', '-1']) => -1,
    (real)C_SPAN_LANG <= 57        => 1,
    (real)C_SPAN_LANG <= 80        => 2,
    (real)C_SPAN_LANG <= 119       => 3,
    (real)C_SPAN_LANG <= 151       => 4,
    (real)C_SPAN_LANG <= 166       => 5,
    (real)C_SPAN_LANG <= 182       => 6,
                                        7));

c_span_lang_s5_m :=  __common__( map(
    c_span_lang_s5 = -1 => 0.1041666667,
    c_span_lang_s5 = 1  => 0.042994436,
    c_span_lang_s5 = 2  => 0.0495449949,
    c_span_lang_s5 = 3  => 0.0533265617,
    c_span_lang_s5 = 4  => 0.057328016,
    c_span_lang_s5 = 5  => 0.0753564155,
    c_span_lang_s5 = 6  => 0.1241241241,
    c_span_lang_s5 = 7  => 0.1464903357,
                           0.0704310258));

lien_rec_unrel_cap_1 :=  __common__( min(3, if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count)));

lien_rec_unrel_cap_s5_m :=  __common__( map(
    lien_rec_unrel_cap_1 = 0 => 0.0639344262,
    lien_rec_unrel_cap_1 = 1 => 0.0765527203,
    lien_rec_unrel_cap_1 = 2 => 0.1162227603,
    lien_rec_unrel_cap_1 = 3 => 0.1818181818,
                                0.0704310258));

_phone_score_1 :=  __common__( map(
    combo_hphonescore > 100 => -1,
    combo_hphonescore = 100 => 1,
    combo_hphonescore > 80  => 2,
                               3));

_phone_score_s5_m :=  __common__( map(
    _phone_score_1 = -1 => 0.0953346856,
    _phone_score_1 = 1  => 0.0449873958,
    _phone_score_1 = 2  => 0.1016949153,
    _phone_score_1 = 3  => 0.1043194784,
                           0.0704310258));

s5_nas12 :=  __common__( nas_summary = 12);

s5_nap :=  __common__( map(
    nap_summary = 12 => 1,
    nap_summary = 11 => 2,
    nap_summary = 1  => 6,
    nap_summary = 0  => 5,
    nap_summary <= 6 => 4,
                        3));

s5_nap_m :=  __common__( map(
    s5_nap = 1 => 0.0322580645,
    s5_nap = 2 => 0.0340699816,
    s5_nap = 3 => 0.0671070932,
    s5_nap = 4 => 0.0864269142,
    s5_nap = 5 => 0.1390041494,
    s5_nap = 6 => 0.2741935484,
                  0.0704310258));

s5_ver_src_cnt_d :=  __common__( ver_src_cnt_d >= 4);

s5_ver_src_nas_eq12 :=  __common__( ver_src_nas_eq = 12);

s5_ver_src_nas_en12 :=  __common__( ver_src_nas_en = 12);

s5_ver_src_nas_tn12 :=  __common__( ver_src_nas_tn = 12);

s5_adls_per_addr :=  __common__( map(
    adls_per_addr = 0  => 0,
    adls_per_addr = 1  => 1,
    adls_per_addr <= 5 => 5,
    adls_per_addr <= 9 => min(8, if(adls_per_addr = NULL, -NULL, adls_per_addr)),
                          10));

s5_adls_per_addr_m :=  __common__( map(
    s5_adls_per_addr = 0  => 0.143586471,
    s5_adls_per_addr = 1  => 0.0512820513,
    s5_adls_per_addr = 5  => 0.0302325581,
    s5_adls_per_addr = 6  => 0.0351648352,
    s5_adls_per_addr = 7  => 0.0387931034,
    s5_adls_per_addr = 8  => 0.0523255814,
    s5_adls_per_addr = 10 => 0.067570147,
                             0.0704310258));

s5_ssns_per_adl_c6 :=  __common__( min(4, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6)));

s5_ssns_per_adl_c6_m :=  __common__( map(
    s5_ssns_per_adl_c6 = 0 => 0.0590753425,
    s5_ssns_per_adl_c6 = 1 => 0.0663300123,
    s5_ssns_per_adl_c6 = 2 => 0.2256809339,
    s5_ssns_per_adl_c6 = 3 => 0.5357142857,
    s5_ssns_per_adl_c6 = 4 => 0.8,
                              0.0704310258));

s5_ssns_per_addr_c6 :=  __common__( min(6, if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6)));

s5_ssns_per_addr_c6_m :=  __common__( map(
    s5_ssns_per_addr_c6 = 0 => 0.0617039343,
    s5_ssns_per_addr_c6 = 1 => 0.0582857143,
    s5_ssns_per_addr_c6 = 2 => 0.0846994536,
    s5_ssns_per_addr_c6 = 3 => 0.1724137931,
    s5_ssns_per_addr_c6 = 4 => 0.2068965517,
    s5_ssns_per_addr_c6 = 5 => 0.3529411765,
    s5_ssns_per_addr_c6 = 6 => 0.5961538462,
                               0.0704310258));

s5_inq_count01 :=  __common__( Inq_count01 > 0);

s5_inq_peraddr :=  __common__( min(4, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr)));

s5_inq_peraddr_m :=  __common__( map(
    s5_inq_peraddr = 0 => 0.0618391541,
    s5_inq_peraddr = 1 => 0.0635775862,
    s5_inq_peraddr = 2 => 0.0700389105,
    s5_inq_peraddr = 3 => 0.087628866,
    s5_inq_peraddr = 4 => 0.1566091954,
                          0.0704310258));

s5_infutor_nap :=  __common__( map(
    infutor_nap >= 11 => 1,
    infutor_nap = 0   => 3,
    infutor_nap = 1   => 4,
                         2));

s5_impulse :=  __common__( impulse_count > 0 or (integer)email_src_im > 0);

s5_combo_addrcount :=  __common__( min(5, if(max(1, combo_addrcount) = NULL, -NULL, max(1, combo_addrcount))));

s5_combo_addrcount_m :=  __common__( map(
    s5_combo_addrcount = 1 => 0.4203389831,
    s5_combo_addrcount = 2 => 0.2188139059,
    s5_combo_addrcount = 3 => 0.1154192967,
    s5_combo_addrcount = 4 => 0.0648092065,
    s5_combo_addrcount = 5 => 0.0366671868,
                              0.0704310258));

s5_avg_lres :=  __common__( map(
    avg_lres <= 0  => -1,
    avg_lres < 6   => 10,
    avg_lres < 12  => 9,
    avg_lres < 24  => 8,
    avg_lres < 36  => 7,
    avg_lres < 60  => 6,
    avg_lres < 120 => 5,
    avg_lres < 180 => 4,
    avg_lres < 240 => 3,
    avg_lres < 360 => 2,
                      1));

s5_avg_lres_m :=  __common__( map(
    s5_avg_lres = -1 => 1,
    s5_avg_lres = 1  => 0.0212765957,
    s5_avg_lres = 2  => 0.0436241611,
    s5_avg_lres = 3  => 0.0380566802,
    s5_avg_lres = 4  => 0.0588235294,
    s5_avg_lres = 5  => 0.0679387106,
    s5_avg_lres = 6  => 0.0881094953,
    s5_avg_lres = 7  => 0.1216494845,
    s5_avg_lres = 8  => 0.1242424242,
    s5_avg_lres = 9  => 0.2474226804,
    s5_avg_lres = 10 => 0.2916666667,
                        0.0704310258));

s5_mth_header_first_seen :=  __common__( map(
    mth_header_first_seen < 60  => 4,
    mth_header_first_seen < 120 => 3,
    mth_header_first_seen < 240 => 2,
                                   1));

s5_mth_header_first_seen_m :=  __common__( map(
    s5_mth_header_first_seen = 1 => 0.0605786618,
    s5_mth_header_first_seen = 2 => 0.0753570343,
    s5_mth_header_first_seen = 3 => 0.0913140312,
    s5_mth_header_first_seen = 4 => 0.1538461538,
                                    0.0704310258));

s5_rel_bankrupt_count :=  __common__( max(1, min(4, if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count))));

s5_rel_bankrupt_count_m :=  __common__( map(
    s5_rel_bankrupt_count = 1 => 0.0640265934,
    s5_rel_bankrupt_count = 2 => 0.0666666667,
    s5_rel_bankrupt_count = 3 => 0.0724043716,
    s5_rel_bankrupt_count = 4 => 0.1161228407,
                                 0.0704310258));

s5_07_logit :=  __common__( -5.899810353 +
    (integer)s5_ssn_risk * 0.8487320854 +
    input_dob_age_s5_m * 2.5756702582 +
    combo_dobscore_s5_m * 3.7433348696 +
    c_fammar_p_s5_m * 2.5696348791 +
    c_lowinc_s5_m * 4.723996299 +
    c_cartheft_s5_m * 5.1411549136 +
    c_span_lang_s5_m * 5.6926490195 +
    lien_rec_unrel_cap_s5_m * 5.4578994017 +
    _phone_score_s5_m * 6.4221853668 +
    (integer)s5_nas12 * -1.029737632 +
    s5_nap_m * 3.1104565899 +
    (integer)s5_ver_src_cnt_d * 0.6085448225 +
    (integer)s5_ver_src_nas_eq12 * -0.89898699 +
    (integer)s5_ver_src_nas_en12 * -0.384902272 +
    (integer)s5_ver_src_nas_tn12 * -0.233244775 +
    (integer)ver_src_sl * -0.404355121 +
    s5_adls_per_addr_m * 5.8577571842 +
    s5_ssns_per_adl_c6_m * 3.1189522946 +
    s5_ssns_per_addr_c6_m * 3.7369901107 +
    (integer)s5_inq_count01 * 0.3548514589 +
    s5_inq_peraddr_m * 3.5508747601 +
    s5_infutor_nap * 0.3203149869 +
    (integer)s5_impulse * 1.3507011367 +
    (integer)add1_isbestmatch * -0.37799597 +
    s5_combo_addrcount_m * 1.3979218358 +
    s5_avg_lres_m * 2.7231658843 +
    s5_mth_header_first_seen_m * -6.42820127 +
    s5_rel_bankrupt_count_m * 7.9458771511);

//*******************************************************************************************************//
// end code for segments 1 - 5 logistic models
//*******************************************************************************************************//


//*******************************************************************************************************//
// begin treenet mkIV code
//*******************************************************************************************************//
add_ec1 :=  __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1]);
add_ec2 :=  __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[2..2]);
add_ec3 :=  __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3]);
add_ec4 :=  __common__( (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4]);

add_errorcode :=  __common__( (out_addr_status in ['E412', 'E421', 'E501', 'E505', 'E600']));

_add_risk :=  __common__( (rc_hriskaddrflag in ['2', '4']) or StringLib.StringToUpperCase(rc_addrvalflag) != 'V' or rc_hrisksic = (string)2225 or rc_addrcommflag > (string)0 or rc_ziptypeflag = (string)5 or rc_cityzipflag > (string)0 or StringLib.StringToUpperCase(add1_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add2_advo_address_vacancy) = 'Y' or StringLib.StringToUpperCase(add1_advo_throw_back) = 'Y');

_add_apt :=  __common__( (StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ') and StringLib.StringToUpperCase(add1_advo_mixed_address_usage) != 'A');

// add1_avm_med :=  __common__( map(
    // ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
    // ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
                              // ADD1_AVM_MED_FIPS));

add1_mortgage_risky :=  __common__( StringLib.StringToUpperCase(add1_financing_type) = 'ADJ' and (StringLib.StringToUpperCase(add1_mortgage_type) in ['1', '2', 'G', 'H', 'J', 'N', 'R', 'U', 'VA', 'Z']) or (StringLib.StringToUpperCase(add1_mortgage_type) in ['FHA', 'S']));

// add2_avm_med :=  __common__( map(
    // add2_AVM_MED_GEO12 > 0 => add2_AVM_MED_GEO12,
    // add2_AVM_MED_GEO11 > 0 => add2_AVM_MED_GEO11,
                              // add2_AVM_MED_FIPS));

add2_mortgage_risky :=  __common__( StringLib.StringToUpperCase(add2_financing_type) = 'ADJ' and (StringLib.StringToUpperCase(add2_mortgage_type) in ['1', '2', 'G', 'H', 'J', 'N', 'R', 'U', 'VA', 'Z']) or (StringLib.StringToUpperCase(add2_mortgage_type) in ['FHA', 'S']));

add3_mortgage_risky :=  __common__( StringLib.StringToUpperCase(add3_financing_type) = 'ADJ' and (StringLib.StringToUpperCase(add3_mortgage_type) in ['1', '2', 'G', 'H', 'J', 'N', 'R', 'U', 'VA', 'Z']) or (StringLib.StringToUpperCase(add3_mortgage_type) in ['FHA', 'S']));

phn_disconnected :=  __common__( rc_hriskphoneflag = (string)5);

phn_inval :=  __common__( rc_phonevalflag = (string)0 or rc_hphonevalflag = (string)0 or (rc_phonetype in ['5']));

phn_nonus :=  __common__( (rc_phonetype in ['3', '4']));

phn_highrisk :=  __common__( rc_hriskphoneflag = (string)6 or rc_hphonetypeflag = '5' or rc_hphonevalflag = (string)3 or rc_addrcommflag = (string)1);

phn_highrisk2 :=  __common__( not((rc_hriskphoneflag in ['0', '7'])));

phn_notpots :=  __common__( not((telcordia_type in ['00', '50', '51', '52', '54'])));

phn_cellpager :=  __common__( (rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']));

phn_cell :=  __common__( (rc_hriskphoneflag in ['1', '3']) or (rc_hphonetypeflag in ['1', '3']));

phn_zipmismatch :=  __common__( rc_phonezipflag = (string)1 or rc_pwphonezipflag = (string)1);

phn_business :=  __common__( rc_hphonevalflag = (string)1);

phn_residential :=  __common__( rc_hphonevalflag = (string)2);

phn_correction :=  __common__( rc_hrisksicphone = (string)2225);

_phone_risk :=  __common__( (rc_hriskphoneflag in ['3', '6']) or (rc_hphonetypeflag in ['3', '5']) or rc_hphonevalflag = (string)3);

ssn_priordob :=  __common__( rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1);

ssn_inval :=  __common__( rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3']));

ssn_issued18 :=  __common__( rc_pwssnvalflag = (string)5);

ssn_statediff :=  __common__( StringLib.StringToUpperCase(trim(rc_ssnstate, LEFT, RIGHT)) != StringLib.StringToUpperCase(trim(in_state, LEFT, RIGHT)));

ssn_deceased :=  __common__( rc_decsflag = (string)1 or (integer)ver_src_ds = 1);

ssn_adl_prob :=  __common__( ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2);

ssn_prob :=  __common__( ssn_deceased or ssn_priordob or ssn_inval);

_ssn_risk :=  __common__( (integer)rc_non_us_ssn = 1 or rc_decsflag = (string)1 or rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1 or rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3', '4']) or (integer)rc_ssnmiskeyflag = 1);

combined_age :=  __common__( map(
	yr_in_dob != NULL => round(yr_in_dob),
	yr_reported_dob != NULL => round(yr_reported_dob),
	round(age)
));

attr_derog_flag :=  __common__( attr_total_number_derogs > 0);

attr_nonderog_flag :=  __common__( attr_num_nonderogs > 0);

bk_flag :=  __common__( (rc_bansflag in ['1', '2']) or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0);

bk_discharge :=  __common__( (integer)contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARGE') > 0);

lien_rec_unrel_flag :=  __common__( liens_recent_unreleased_count > 0);

lien_hist_unrel_flag :=  __common__( liens_historical_unreleased_ct > 0);

lien_rec_rel_flag :=  __common__( liens_recent_released_count > 0);

lien_hist_rel_flag :=  __common__( liens_historical_released_count > 0);

lien_flag :=  __common__( lien_rec_unrel_flag or lien_hist_unrel_flag);

lien_rec_unrel_cap :=  __common__( min(3, if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count)));

lien_hist_unrel_cap :=  __common__( min(5, if(liens_historical_unreleased_ct = NULL, -NULL, liens_historical_unreleased_ct)));

crime_flag :=  __common__( criminal_count > 0);

crime_cap :=  __common__( min(3, if(criminal_count = NULL, -NULL, criminal_count)));

crime_felony_flag :=  __common__( felony_count > 0);

eviction_cap :=  __common__( min(3, if(attr_eviction_count = NULL, -NULL, attr_eviction_count)));

impulse_flag :=  __common__( min(1, if(impulse_count = NULL, -NULL, impulse_count)));

lien_otherdid :=  __common__( did2_liens_hist_unrel_count > 0 or did3_liens_hist_unrel_count > 0);

crime_otherdid :=  __common__( did2_criminal_count > 0 or did3_criminal_count > 0);

contrary_ssn :=  __common__( (nas_summary in [1]));

verfst_s :=  __common__( (nas_summary in [2, 3, 4, 8, 9, 10, 12]));

verlst_s :=  __common__( (nas_summary in [2, 5, 7, 8, 9, 11, 12]));

veradd_s :=  __common__( (nas_summary in [3, 5, 6, 8, 10, 11, 12]));

verssn_s :=  __common__( (nas_summary in [4, 6, 7, 9, 10, 11, 12]));

ver_nas479 :=  __common__( (nas_summary in [4, 7, 9]));

contrary_phn :=  __common__( (nap_summary in [1]));

verfst_p :=  __common__( (nap_summary in [2, 3, 4, 8, 9, 10, 12]));

verlst_p :=  __common__( (nap_summary in [2, 5, 7, 8, 9, 11, 12]));

veradd_p :=  __common__( (nap_summary in [3, 5, 6, 8, 10, 11, 12]));

verphn_p :=  __common__( (nap_summary in [4, 6, 7, 9, 10, 11, 12]));

ver_nap6 :=  __common__( (nap_summary in [6]));

ver_phncount :=  __common__( if(max((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p) = NULL, NULL, sum((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p)));

// ver_positive_src_cnt :=  __common__( min(6, sum((integer)ver_src_am, (integer)ver_src_ar, (integer)ver_src_dl, (integer)ver_src_eb, (integer)ver_src_em, (integer)ver_src_e1, (integer)ver_src_e2, (integer)ver_src_e3, (integer)ver_src_e4, (integer)ver_src_en, (integer)ver_src_eq, (integer)ver_src_fe, (integer)ver_src_ff, (integer)ver_src_p, (integer)ver_src_pl, (integer)ver_src_ts, (integer)ver_src_tu, (integer)ver_src_sl, (integer)ver_src_v, (integer)ver_src_vo, (integer)ver_src_w, (integer)ver_src_wp)));

_nonderogs90 :=  __common__( min(3, if(attr_num_nonderogs90 = NULL, -NULL, attr_num_nonderogs90)));

_nonderogs12 :=  __common__( min(3, if(attr_num_nonderogs12 = NULL, -NULL, attr_num_nonderogs12)));

_lnamecount :=  __common__( min(3, if(rc_lnamecount = NULL, -NULL, rc_lnamecount)));

// _addrcount :=  __common__( min(3, if(rc_addrcount = NULL, -NULL, rc_addrcount)));

// prop_owned_flag :=  __common__( property_owned_total > 0);

// prop_sold_flag :=  __common__( property_sold_total > 0);

_addrs_5yr :=  __common__( min(5, if(addrs_5yr = NULL, -NULL, addrs_5yr)));

_addrs_10yr :=  __common__( min(8, if(addrs_10yr = NULL, -NULL, addrs_10yr)));

_addrs_15yr :=  __common__( min(10, if(addrs_15yr = NULL, -NULL, addrs_15yr)));

_addrs_last30 :=  __common__( min(3, if(attr_addrs_last30 = NULL, -NULL, attr_addrs_last30)));

_addrs_last90 :=  __common__( min(3, if(attr_addrs_last90 = NULL, -NULL, attr_addrs_last90)));

_addrs_last12 :=  __common__( min(3, if(attr_addrs_last12 = NULL, -NULL, attr_addrs_last12)));

_addrs_last24 :=  __common__( min(5, if(attr_addrs_last24 = NULL, -NULL, attr_addrs_last24)));

_addrs_last36 :=  __common__( min(8, if(attr_addrs_last36 = NULL, -NULL, attr_addrs_last36)));

_ssncount :=  __common__( min(3, if(rc_ssncount = NULL, -NULL, rc_ssncount)));

_bus_addr_match :=  __common__( bus_addr_match_count > 0);

_bus_addr_src_cnt :=  __common__( min(2, if(bus_addr_src_cnt = NULL, -NULL, bus_addr_src_cnt)));

_paw_business_match :=  __common__( PAW_Business_count > 0);

_paw_dead_business :=  __common__( PAW_Dead_business_count > 0);

_paw_active_phone :=  __common__( PAW_active_phone_count > 0);

_dr_valid :=  __common__( rc_dl_val_flag = '0');

// _email_domain_free_count :=  __common__( min(4, if(email_domain_Free_count = NULL, -NULL, email_domain_Free_count)));

_email_domain_isp :=  __common__( email_domain_ISP_count > 0);

_email_domain_edu :=  __common__( email_domain_EDU_count > 0);

_email_domain_corp :=  __common__( email_domain_Corp_count > 0);

_util_adl_count :=  __common__( min(5, if(util_adl_count = NULL, -NULL, util_adl_count)));

_prop_owned_total :=  __common__( min(5, if(property_owned_total = NULL, -NULL, property_owned_total)));

_property_sold_total :=  __common__( min(5, if(property_sold_total = NULL, -NULL, property_sold_total)));

_num_purchase12 :=  __common__( min(2, if(attr_num_purchase12 = NULL, -NULL, attr_num_purchase12)));

_num_purchase24 :=  __common__( min(2, if(attr_num_purchase24 = NULL, -NULL, attr_num_purchase24)));

_num_purchase36 :=  __common__( min(3, if(attr_num_purchase36 = NULL, -NULL, attr_num_purchase36)));

_num_purchase60 :=  __common__( min(4, if(attr_num_purchase60 = NULL, -NULL, attr_num_purchase60)));

_car_current :=  __common__( current_count > 0);

_boat_plane :=  __common__( watercraft_count > 0 or attr_num_aircraft > 0 or (integer)ver_src_eb > 0 or (integer)ver_src_w > 0);

_altlname :=  __common__( (integer)rc_altlname1_flag > 0 or (integer)rc_altlname2_flag > 0);

_nameperssn_count :=  __common__( min(3, if(nameperssn_count = NULL, -NULL, nameperssn_count)));

_ssns_per_adl :=  __common__( min(3, if(ssns_per_adl = NULL, -NULL, ssns_per_adl)));

_addrs_per_adl :=  __common__( min(8, if(addrs_per_adl = NULL, -NULL, addrs_per_adl)));

_phones_per_adl :=  __common__( min(3, if(phones_per_adl = NULL, -NULL, phones_per_adl)));

_lnames_per_adl :=  __common__( min(3, if(lnames_per_adl = NULL, -NULL, lnames_per_adl)));

_adlperssn_count :=  __common__( min(3, if(adlperssn_count = NULL, -NULL, adlperssn_count)));

_addrs_per_ssn :=  __common__( min(8, if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn)));

_adls_per_addr_cap10 :=  __common__( min(10, if(adls_per_addr = NULL, -NULL, adls_per_addr)));

_ssns_per_addr :=  __common__( min(10, if(ssns_per_addr = NULL, -NULL, ssns_per_addr)));

_phones_per_addr :=  __common__( min(10, if(phones_per_addr = NULL, -NULL, phones_per_addr)));

_adls_per_phone :=  __common__( min(3, if(adls_per_phone = NULL, -NULL, adls_per_phone)));

// _ssns_per_adl_c6 :=  __common__( min(2, if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6)));

_addrs_per_adl_c6 :=  __common__( min(2, if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6)));

// _phones_per_adl_c6 :=  __common__( min(2, if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6)));

_lnames_per_adl_c6 :=  __common__( min(2, if(lnames_per_adl_c6 = NULL, -NULL, lnames_per_adl_c6)));

_adls_per_ssn_c6 :=  __common__( min(2, if(adls_per_ssn_c6 = NULL, -NULL, adls_per_ssn_c6)));

_addrs_per_ssn_c6 :=  __common__( min(2, if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6)));

_adls_per_addr_c6 :=  __common__( min(5, if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6)));

_ssns_per_addr_c6_cap5 :=  __common__( min(5, if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6)));

_phones_per_addr_c6 :=  __common__( min(5, if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6)));

_adls_per_phone_c6 :=  __common__( min(2, if(adls_per_phone_c6 = NULL, -NULL, adls_per_phone_c6)));

_inq_count :=  __common__( min(5, if(Inq_count = NULL, -NULL, Inq_count)));

_inq_count01 :=  __common__( min(2, if(Inq_count01 = NULL, -NULL, Inq_count01)));

_inq_count03_cap3 :=  __common__( min(3, if(Inq_count03 = NULL, -NULL, Inq_count03)));

_inq_count06 :=  __common__( min(4, if(Inq_count06 = NULL, -NULL, Inq_count06)));

_inq_collection_count :=  __common__( min(5, if(Inq_Collection_count = NULL, -NULL, Inq_Collection_count)));

_inq_perssn :=  __common__( min(5, if(Inq_PerSSN = NULL, -NULL, Inq_PerSSN)));

_inq_peraddr_cap8 :=  __common__( min(8, if(Inq_PerAddr = NULL, -NULL, Inq_PerAddr)));

_inq_perphone :=  __common__( min(5, if(Inq_PerPhone = NULL, -NULL, Inq_PerPhone)));

//_wealth_index :=  __common__( min(4, if(wealth_index = NULL, -NULL, wealth_index)));

//_addr_stability_v2 :=  __common__( max(0, min(6, if(addr_stability_v2 = '', -NULL, (unsigned1)addr_stability_v2))));

_acc :=  __common__( acc_count > 0);

_rel_count :=  __common__( min(5, if(rel_count = NULL, -NULL, rel_count)));

_rel_bankrupt_count :=  __common__( min(5, if(rel_bankrupt_count = NULL, -NULL, rel_bankrupt_count)));

_rel_criminal_count :=  __common__( min(5, if(rel_criminal_count = NULL, -NULL, rel_criminal_count)));

_rel_felony_count :=  __common__( min(5, if(rel_felony_count = NULL, -NULL, rel_felony_count)));

_rel_criminal_total :=  __common__( min(5, if(rel_criminal_total = NULL, -NULL, rel_criminal_total)));

_rel_felony_total :=  __common__( min(5, if(rel_felony_total = NULL, -NULL, rel_felony_total)));

_crim_rel_within25miles_cap5 :=  __common__( min(5, if(crim_rel_within25miles = NULL, -NULL, crim_rel_within25miles)));

_crim_rel_within100miles :=  __common__( min(5, if(crim_rel_within100miles = NULL, -NULL, crim_rel_within100miles)));

_rel_prop_owned_count :=  __common__( min(5, if(rel_prop_owned_count = NULL, -NULL, rel_prop_owned_count)));

_rel_prop_owned_total :=  __common__( min(5, if(rel_prop_owned_total = NULL, -NULL, rel_prop_owned_total)));

_rel_within25miles_count :=  __common__( min(5, if(rel_within25miles_count = NULL, -NULL, rel_within25miles_count)));

_rel_within100miles_count :=  __common__( min(5, if(rel_within100miles_count = NULL, -NULL, rel_within100miles_count)));

_rel_incomeunder25_count :=  __common__( min(5, if(rel_incomeunder25_count = NULL, -NULL, rel_incomeunder25_count)));

_rel_incomeunder50_count :=  __common__( min(5, if(rel_incomeunder50_count = NULL, -NULL, rel_incomeunder50_count)));

_rel_incomeover100_count :=  __common__( min(5, if(rel_incomeover100_count = NULL, -NULL, rel_incomeover100_count)));

_rel_homeunder50_count :=  __common__( min(5, if(rel_homeunder50_count = NULL, -NULL, rel_homeunder50_count)));

_rel_homeunder100_count :=  __common__( min(5, if(rel_homeunder100_count = NULL, -NULL, rel_homeunder100_count)));

_rel_homeover500_count :=  __common__( min(5, if(rel_homeover500_count = NULL, -NULL, rel_homeover500_count)));

_rel_educationunder8_count :=  __common__( min(5, if(rel_educationunder8_count = NULL, -NULL, rel_educationunder8_count)));

_rel_educationunder12_count :=  __common__( min(5, if(rel_educationunder12_count = NULL, -NULL, rel_educationunder12_count)));

_rel_vehicle_owned_count :=  __common__( min(5, if(rel_vehicle_owned_count = NULL, -NULL, rel_vehicle_owned_count)));

_rel_count_addr :=  __common__( min(5, if(rel_count_addr = NULL, -NULL, rel_count_addr)));
//*******************************************************************************************************//
// end treenet mkIV code
//*******************************************************************************************************//














// start of treenet segment 6 code

// start of treenet segment 6 code

s6_N0_8 :=  __common__( if(((real)combined_age < 78.5), -1.381992, -1.3089931));

s6_N0_7 :=  __common__( if(((real)_ssncount < 1.5), -1.2371707, s6_N0_8));

s6_N0_6 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N0_7, -1.27545));

s6_N0_5 :=  __common__( if((combo_dobscore < 80), -1.2079957, s6_N0_6));

s6_N0_4 :=  __common__( if(((integer)c_cartheft < 114), -1.3152633, -1.1788753));

s6_N0_3 :=  __common__( if(trim(C_CARTHEFT) != '', s6_N0_4, -1.3967759));

s6_N0_2 :=  __common__( if(((real)age < 57.5), s6_N0_3, -1.0596391));

s6_N0_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N0_2, s6_N0_5));

s6_N1_7 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.15105223, 0.010794785));

s6_N1_6 :=  __common__( if(((real)_ssn_score < 1.5), -0.0099709883, 0.092438335));

s6_N1_5 :=  __common__( if(((real)age < 77.5), s6_N1_6, s6_N1_7));

s6_N1_4 :=  __common__( if((combo_dobscore < 65), 0.13145635, s6_N1_5));

s6_N1_3 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), 0.058847166, 0.1637358));

s6_N1_2 :=  __common__( map(trim(C_ASSAULT) = ''      => 0.20480726,
            ((real)c_assault < 171.5) => s6_N1_3,
                                         0.20480726));

s6_N1_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N1_2, s6_N1_4));

s6_N2_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), -0.0095016181, 0.069845107));

s6_N2_6 :=  __common__( if(((real)_adls_per_phone < 0.5), 0.13674347, 0.02645025));

s6_N2_5 :=  __common__( if(((real)input_dob_match_level < 4.5), s6_N2_6, s6_N2_7));

s6_N2_4 :=  __common__( map(trim(C_HIGH_ED) = ''      => 0.094391982,
            ((real)c_high_ed < 13.35) => 0.18413833,
                                         0.094391982));

s6_N2_3 :=  __common__( if(((real)add2_naprop < 3.5), 0.034036287, 0.10606001));

s6_N2_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), s6_N2_3, s6_N2_4));

s6_N2_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N2_2, s6_N2_5));

s6_N3_7 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.096328985, 0.016336468));

s6_N3_6 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), -0.011688224, 0.04787624));

s6_N3_5 :=  __common__( if(((real)age < 77.5), s6_N3_6, s6_N3_7));

s6_N3_4 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.074523667, s6_N3_5));

s6_N3_3 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), 0.081709842, 0.126638));

s6_N3_2 :=  __common__( if(((real)combined_age < 38.5), 0.032694132, s6_N3_3));

s6_N3_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N3_2, s6_N3_4));

s6_N4_8 :=  __common__( if(((real)_infutor_nap < 2.5), 0.010835567, 0.11503547));

s6_N4_7 :=  __common__( if(((real)age < 77.5), -0.0090566106, s6_N4_8));

s6_N4_6 :=  __common__( if((combo_dobscore < 65), 0.063422121, s6_N4_7));

s6_N4_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N4_6, 0.075299728));

s6_N4_4 :=  __common__( if(((real)add2_naprop < 3.5), 0.033516947, 0.08842509));

s6_N4_3 :=  __common__( if(((real)c_high_ed < 6.45), 0.11637291, s6_N4_4));

s6_N4_2 :=  __common__( if(trim(C_HIGH_ED) != '', s6_N4_3, -0.027633727));

s6_N4_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N4_2, s6_N4_5));

s6_N5_9 :=  __common__( if(((real)c_fammar_p < 58.3), 0.10515878, 0.0082053264));

s6_N5_8 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N5_9, 0.069794476));

s6_N5_7 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N5_8, -0.01102636));

s6_N5_6 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.090020466, 0.0012408956));

s6_N5_5 :=  __common__( if(((real)input_dob_match_level < 4.5), s6_N5_6, s6_N5_7));

s6_N5_4 :=  __common__( if(((real)c_robbery < 134.5), 0.043899282, 0.079985716));

s6_N5_3 :=  __common__( if(trim(C_ROBBERY) != '', s6_N5_4, -0.027973829));

s6_N5_2 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((integer)mth_ver_src_fsrc_fdate < 96), 0.0031050417, s6_N5_3));

s6_N5_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N5_2, s6_N5_5));

s6_N6_8 :=  __common__( if(((real)mth_header_first_seen < 197.5), 0.0028115051, 0.089049486));

s6_N6_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), -0.0080006213, s6_N6_8));

s6_N6_6 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.046836451, s6_N6_7));

s6_N6_5 :=  __common__( map(trim(C_MED_HVAL) = ''        => 0.059356394,
            ((real)c_med_hval < 79532.5) => 0.092406703,
                                            0.059356394));

s6_N6_4 :=  __common__( if(((real)age < 45.5), 0.010506296, 0.062013163));

s6_N6_3 :=  __common__( if(((integer)c_cartheft < 144), s6_N6_4, s6_N6_5));

s6_N6_2 :=  __common__( if(trim(C_CARTHEFT) != '', s6_N6_3, -0.027511388));

s6_N6_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N6_2, s6_N6_6));

s6_N7_9 :=  __common__( map(trim(C_YOUNG) = ''     => 0.0031110587,
            ((real)c_young < 31.2) => 0.12532128,
                                      0.0031110587));

s6_N7_8 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N7_9, 0.011800098));

s6_N7_7 :=  __common__( if(((real)c_fammar_p < 62.25), s6_N7_8, -0.010147814));

s6_N7_6 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N7_7, -0.011883565));

s6_N7_5 :=  __common__( if((combo_dobscore < 65), 0.050858385, s6_N7_6));

s6_N7_4 :=  __common__( if(((real)attr_num_nonderogs90 < 5.5), 0.019744857, 0.055321983));

s6_N7_3 :=  __common__( if(((real)c_fammar_p < 61.4), 0.069924681, s6_N7_4));

s6_N7_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N7_3, -0.027481174));

s6_N7_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N7_2, s6_N7_5));

s6_N8_8 :=  __common__( if(((real)combined_age < 44.5), 0.0024689894, 0.065173085));

s6_N8_7 :=  __common__( if(((real)add1_source_count < 2.5), s6_N8_8, -0.00939647));

s6_N8_6 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.074590206, 0.009734752));

s6_N8_5 :=  __common__( if(((real)input_dob_match_level < 3.5), s6_N8_6, s6_N8_7));

s6_N8_4 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 215.5), 0.038226563, 0.067465271));

s6_N8_3 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s6_N8_4, -0.032223187));

s6_N8_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.014397905, s6_N8_3));

s6_N8_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N8_2, s6_N8_5));

s6_N9_8 :=  __common__( if(((real)combined_age < 72.5), 0.00078120725, 0.076649842));
s6_N9_7 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s6_N9_8, -0.015523154));
s6_N9_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N9_7, 0.13143435));
s6_N9_5 :=  __common__( if(((real)avg_lres < 47.5), 0.0056746592, 0.064091109));
s6_N9_4 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0040949992, s6_N9_5));
s6_N9_3 :=  __common__( if(((real)c_unempl < 146.5), s6_N9_4, 0.068369567));
s6_N9_2 :=  __common__( if(trim(C_UNEMPL) != '', s6_N9_3, -0.027457011));
s6_N9_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N9_2, s6_N9_6));

s6_N10_9 :=  __common__( if(((real)c_fammar_p < 64.25), 0.012591835, -0.011329957));
s6_N10_8 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N10_9, 0.020682521));
s6_N10_7 :=  __common__( if((combo_dobscore < 80), 0.033791974, s6_N10_8));
s6_N10_6 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N10_7, 0.049007912));
s6_N10_5 :=  __common__( if(((real)_nas < 2.5), s6_N10_6, 0.087515737));
s6_N10_4 :=  __common__( if(((real)c_pop_18_24_p < 7.45), 0.01867092, 0.057775699));
s6_N10_3 :=  __common__( if(trim(C_POP_18_24_P) != '', s6_N10_4, -0.027268484));
s6_N10_2 :=  __common__( if(((real)combined_age < 38.5), 0.013920022, s6_N10_3));
s6_N10_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N10_2, s6_N10_5));

s6_N11_8 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), -0.0072153775, 0.039089187));
s6_N11_7 :=  __common__( map(trim(C_MANY_CARS) = ''     => 0.0059390539,
             ((real)c_many_cars < 80.5) => 0.059052643,
                                           0.0059390539));
s6_N11_6 :=  __common__( if(((real)input_dob_match_level < 4.5), s6_N11_7, s6_N11_8));
s6_N11_5 :=  __common__( if(mth_ver_src_fsrc_fdate != NULL and ((integer)mth_ver_src_fsrc_fdate < 99), -0.019766735, 0.030881739));
s6_N11_4 :=  __common__( if(((real)_phones_per_addr < 1.5), 0.032773736, 0.068322059));
s6_N11_3 :=  __common__( if(((real)c_high_ed < 15.2), s6_N11_4, s6_N11_5));
s6_N11_2 :=  __common__( if(trim(C_HIGH_ED) != '', s6_N11_3, -0.027298537));
s6_N11_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N11_2, s6_N11_6));

s6_N12_8 :=  __common__( if(((real)age < 77.5), -0.0095740372, 0.038797774));
s6_N12_7 :=  __common__( if((combo_dobscore < 80), 0.034246734, s6_N12_8));
s6_N12_6 :=  __common__( if(((real)combined_age < 36.5), 0.026350596, 0.067807538));
s6_N12_5 :=  __common__( if(((real)c_fammar_p < 55.4), 0.05705297, 0.0073811208));
s6_N12_4 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N12_5, -0.027017313));
s6_N12_3 :=  __common__( if(((real)age < 64.5), s6_N12_4, 0.062076781));
s6_N12_2 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), s6_N12_3, s6_N12_6));
s6_N12_1 :=  __common__( if(((real)add1_source_count < 2.5), s6_N12_2, s6_N12_7));

s6_N13_8 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), -0.0090048393, 0.041578195));
s6_N13_7 :=  __common__( if(((real)combined_age < 80.5), s6_N13_8, 0.046636105));
s6_N13_6 :=  __common__( if(((real)_addrs_per_adl_c6 < 1.5), 0.0058706813, 0.050094404));
s6_N13_5 :=  __common__( if((combo_dobscore < 95), s6_N13_6, s6_N13_7));
s6_N13_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N13_5, 0.11938324));
s6_N13_3 :=  __common__( if(((real)c_robbery < 164.5), 0.020982602, 0.04979094));
s6_N13_2 :=  __common__( if(trim(C_ROBBERY) != '', s6_N13_3, -0.02691724));
s6_N13_1 :=  __common__( if(((real)add1_source_count < 1.5), s6_N13_2, s6_N13_4));

s6_N14_8 :=  __common__( if(((real)input_dob_match_level < 4.5), 0.034696108, 0.0033420328));
s6_N14_7 :=  __common__( if(((real)_rel_criminal_count < 4.5), s6_N14_8, 0.062631686));
s6_N14_6 :=  __common__( if(((real)rc_addrcount < 3.5), s6_N14_7, -0.011780187));
s6_N14_5 :=  __common__( map(trim(C_CHILD) = ''     => 0.062761045,
             ((real)c_child < 30.6) => 0.034858691,
                                       0.062761045));
s6_N14_4 :=  __common__( if(((integer)c_high_ed < 27), s6_N14_5, 0.018111812));
s6_N14_3 :=  __common__( if(trim(C_HIGH_ED) != '', s6_N14_4, -0.027240558));
s6_N14_2 :=  __common__( if(((real)_inq_count01 < 0.5), 0.002024027, s6_N14_3));
s6_N14_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N14_2, s6_N14_6));

s6_N15_9 :=  __common__( if(((real)combined_age < 71.5), 0.0014802625, 0.067052221));
s6_N15_8 :=  __common__( if(((real)combo_hphonecount < 0.5), s6_N15_9, -0.014138561));
s6_N15_7 :=  __common__( if(((real)c_fammar_p < 34.55), 0.069286002, s6_N15_8));
s6_N15_6 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N15_7, -0.018418978));
s6_N15_5 :=  __common__( if(((real)_nas < 1.5), s6_N15_6, 0.082896018));
s6_N15_4 :=  __common__( if(mth_ver_src_fsrc_fdate!= null and ((real)mth_ver_src_fsrc_fdate < 87.5), -0.015041362, 0.020581732));
s6_N15_3 :=  __common__( if(((real)c_unempl < 142.5), s6_N15_4, 0.044653107));
s6_N15_2 :=  __common__( if(trim(C_UNEMPL) != '', s6_N15_3, -0.026993647));
s6_N15_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N15_2, s6_N15_5));

s6_N16_9 :=  __common__( if(((real)c_born_usa < 13.5), 0.034170611, -0.001144377));

s6_N16_8 :=  __common__( if(trim(C_BORN_USA) != '', s6_N16_9, 0.011674655));

s6_N16_7 :=  __common__( if(((real)combo_hphonecount < 0.5), s6_N16_8, -0.013733158));

s6_N16_6 :=  __common__( if((combo_dobscore < 65), 0.029328534, s6_N16_7));

s6_N16_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N16_6, 0.032348274));

s6_N16_4 :=  __common__( map(trim(C_WHITE_COL) = ''      => -0.0045845509,
             ((real)c_white_col < 37.15) => 0.029423856,
                                            -0.0045845509));

s6_N16_3 :=  __common__( if(((real)c_cartheft < 142.5), s6_N16_4, 0.037157559));

s6_N16_2 :=  __common__( if(trim(C_CARTHEFT) != '', s6_N16_3, -0.026863524));

s6_N16_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N16_2, s6_N16_5));

s6_N17_9 :=  __common__( if(((real)c_fammar_p < 34.55), 0.056548122, -0.0076187806));
s6_N17_8 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N17_9, -0.026238956));
s6_N17_7 :=  __common__( if(((real)attr_num_nonderogs30 < 3.5), 0.012370338, 0.053035434));
s6_N17_6 :=  __common__( if(((real)c_fammar_p < 58.6), s6_N17_7, 0.00052825286));
s6_N17_5 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N17_6, -0.026625842));
s6_N17_4 :=  __common__( if(((real)age < 65.5), s6_N17_5, 0.040527022));
s6_N17_3 :=  __common__( if(((real)_adls_per_addr_c6 < 4.5), s6_N17_4, 0.049519132));
s6_N17_2 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N17_3, s6_N17_8));
s6_N17_1 :=  __common__( if(((real)_nas < 1.5), s6_N17_2, 0.058475275));

s6_N18_8 :=  __common__( if(((real)_ssn_score < 1.5), -0.0084151178, 0.044348055));
s6_N18_7 :=  __common__( map(trim(C_POP_25_34_P) = ''     => 0.011221363,
             ((real)c_pop_25_34_p < 13.1) => 0.098919407,
                                             0.011221363));
s6_N18_6 :=  __common__( if(((real)c_fammar_p < 45.25), s6_N18_7, s6_N18_8));
s6_N18_5 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N18_6, -0.026233167));
s6_N18_4 :=  __common__( if(((real)_nap < 3.5), 0.027918479, 0.059136137));
s6_N18_3 :=  __common__( if(((real)_adls_per_addr_c6 < 3.5), 0.0089972718, 0.038050299));
s6_N18_2 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), s6_N18_3, s6_N18_4));
s6_N18_1 :=  __common__( if(((real)add1_source_count < 2.5), s6_N18_2, s6_N18_5));

s6_N19_9 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), 0.010942341, 0.045583055));
s6_N19_8 :=  __common__( if(((real)c_fammar_p < 62.75), s6_N19_9, -0.0076780836));
s6_N19_7 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N19_8, -0.012182776));
s6_N19_6 :=  __common__( if(((real)_nas < 1.5), s6_N19_7, 0.047246831));
s6_N19_5 :=  __common__( if(((real)rc_phoneaddr_addrcount < 0.5), 0.011780575, 0.048257779));
s6_N19_4 :=  __common__( if(((real)c_ab_av_edu < 161.5), s6_N19_5, -0.01906214));
s6_N19_3 :=  __common__( if(trim(C_AB_AV_EDU) != '', s6_N19_4, 0.05747202));
s6_N19_2 :=  __common__( if(((real)_inq_count01 < 1.5), s6_N19_3, 0.048794669));
s6_N19_1 :=  __common__( if(((real)add1_source_count < 1.5), s6_N19_2, s6_N19_6));

s6_N20_9 :=  __common__( if(((real)_phone_score < 1.5), -0.0089852789, 0.018061754));
s6_N20_8 :=  __common__( if(((real)_adls_per_addr_c6 < 4.5), s6_N20_9, 0.034400682));
s6_N20_7 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N20_8, -0.014273228));
s6_N20_6 :=  __common__( if((combo_dobscore < 80), 0.02995555, s6_N20_7));
s6_N20_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), -0.005457505, 0.030287149));
s6_N20_4 :=  __common__( if(((real)add1_unit_count < 8.5), s6_N20_5, 0.042913208));
s6_N20_3 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 87.5), -0.0062470347, s6_N20_4));
s6_N20_2 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s6_N20_3, -0.041612834));
s6_N20_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N20_2, s6_N20_6));

s6_N21_8 :=  __common__( map(trim(C_UNEMP) = ''     => 0.033657123,
             ((real)c_unemp < 2.95) => -0.010490525,
                                       0.033657123));
s6_N21_7 :=  __common__( map(trim(C_LOWINC) = ''      => 0.075761548,
             ((real)c_lowinc < 27.15) => 0.037300834,
                                         0.075761548));
s6_N21_6 :=  __common__( if(((real)add1_nhood_vacant_properties < 17.5), s6_N21_7, s6_N21_8));
s6_N21_5 :=  __common__( if(((real)c_cartheft < 142.5), 0.012193385, s6_N21_6));
s6_N21_4 :=  __common__( if(trim(C_CARTHEFT) != '', s6_N21_5, 0.02955992));
s6_N21_3 :=  __common__( if(((real)_addrs_last90 < 0.5), -0.00478615, s6_N21_4));
s6_N21_2 :=  __common__( if(((real)_adls_per_addr_c6 < 4.5), s6_N21_3, 0.046767635));
s6_N21_1 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N21_2, -0.0053196556));

s6_N22_9 :=  __common__( if(((real)input_dob_match_level < 4.5), 0.026668414, -0.0069446701));
s6_N22_8 :=  __common__( if(((real)c_lar_fam < 135.5), 0.02371969, 0.059884184));
s6_N22_7 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N22_8, -0.026626257));
s6_N22_6 :=  __common__( if(((real)add_bestmatch_level < 1.5), -0.0039594285, 0.038491121));
s6_N22_5 :=  __common__( if(((real)combined_age < 45.5), s6_N22_6, 0.052690323));
s6_N22_4 :=  __common__( if(((real)c_many_cars < 65.5), s6_N22_5, 0.00014601105));
s6_N22_3 :=  __common__( if(trim(C_MANY_CARS) != '', s6_N22_4, 0.013311327));
s6_N22_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s6_N22_3, s6_N22_7));
s6_N22_1 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N22_2, s6_N22_9));

s6_N23_8 :=  __common__( if(((real)add3_source_count < 5.5), 0.0067550725, 0.066183783));
s6_N23_7 :=  __common__( map(trim(C_BIGAPT_P) = ''      => 0.052739877,
             ((real)c_bigapt_p < 15.35) => s6_N23_8,
                                           0.052739877));
s6_N23_6 :=  __common__( if(((real)add_bestmatch_level < 0.5), 5.3491298e-005, s6_N23_7));
s6_N23_5 :=  __common__( if(((real)c_robbery < 121.5), -0.0088420297, s6_N23_6));
s6_N23_4 :=  __common__( if(trim(C_ROBBERY) != '', s6_N23_5, 0.025590315));
s6_N23_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N23_4, 0.03231264));
s6_N23_2 :=  __common__( if(((real)combined_age < 73.5), s6_N23_3, 0.048023544));
s6_N23_1 :=  __common__( if(((real)rc_addrcount < 3.5), s6_N23_2, -0.009971036));

s6_N24_8 :=  __common__( if(((real)rc_phoneaddr_addrcount < 0.5), -0.012215094, 0.030129013));

s6_N24_7 :=  __common__( if(((real)add3_lres < 125.5), s6_N24_8, 0.037791094));

s6_N24_6 :=  __common__( if(((real)add1_source_count < 1.5), s6_N24_7, -0.0062486858));

s6_N24_5 :=  __common__( if(((integer)c_med_hval < 31876), 0.042308643, s6_N24_6));

s6_N24_4 :=  __common__( if(trim(C_MED_HVAL) != '', s6_N24_5, -0.013848744));

s6_N24_3 :=  __common__( map(trim(C_UNEMP) = ''     => 0.039459196,
             ((real)c_unemp < 3.25) => 0.010254481,
                                       0.039459196));

s6_N24_2 :=  __common__( if((combo_dobscore < 80), s6_N24_3, s6_N24_4));

s6_N24_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s6_N24_2, 0.033303853));

s6_N25_8 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.0026417122, -0.011835209));

s6_N25_7 :=  __common__( if(((integer)c_fammar_p < 37), 0.035288461, s6_N25_8));

s6_N25_6 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N25_7, -0.0079579328));

s6_N25_5 :=  __common__( if(((real)_adls_per_addr_c6 < 0.5), 0.015019426, 0.043963064));

s6_N25_4 :=  __common__( if(((integer)mth_ver_src_fsrc_fdate < 138), -0.015179489, s6_N25_5));

s6_N25_3 :=  __common__( if(((real)add1_source_count < 1.5), s6_N25_4, s6_N25_6));

s6_N25_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s6_N25_3, 0.032519223));

s6_N25_1 :=  __common__( if(((real)_ssncount < 0.5), 0.050355007, s6_N25_2));

s6_N26_8 :=  __common__( map(trim(C_MANY_CARS) = ''     => 0.0032744135,
             ((real)c_many_cars < 56.5) => 0.03735622,
                                           0.0032744135));

s6_N26_7 :=  __common__( if(((integer)c_lar_fam < 139), s6_N26_8, 0.042065147));

s6_N26_6 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N26_7, -0.027006043));

s6_N26_5 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), s6_N26_6, 0.049545664));

s6_N26_4 :=  __common__( if(((real)rc_dirsaddr_lastscore < 41.5), 0.025017017, -0.0086501706));

s6_N26_3 :=  __common__( if(((integer)add2_avm_med < 720341), s6_N26_4, 0.046635495));

s6_N26_2 :=  __common__( if(((real)attr_num_nonderogs180 < 4.5), s6_N26_3, s6_N26_5));

s6_N26_1 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N26_2, -0.0062800725));

s6_N27_8 :=  __common__( if(((real)age < 56.5), 0.0057613928, 0.062525207));

s6_N27_7 :=  __common__( if(((real)_phone_score < 1.5), -0.0085763389, s6_N27_8));

s6_N27_6 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 236.5), 0.014852429, 0.043548058));

s6_N27_5 :=  __common__( if(((real)c_inc_15k_p < 38.3), 0.0054934843, 0.052226075));

s6_N27_4 :=  __common__( if(trim(C_INC_15K_P) != '', s6_N27_5, 0.013832152));

s6_N27_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s6_N27_4, s6_N27_6));

s6_N27_2 :=  __common__( if(((real)add1_source_count < 3.5), s6_N27_3, s6_N27_7));

s6_N27_1 :=  __common__( if(((real)_ssncount < 0.5), 0.042280347, s6_N27_2));

s6_N28_9 :=  __common__( if(((real)_phone_score < 1.5), -0.008521562, 0.013460195));

s6_N28_8 :=  __common__( if(((real)c_inc_150k_p < 6.85), 0.044337781, 0.014456494));

s6_N28_7 :=  __common__( if(trim(C_INC_150K_P) != '', s6_N28_8, -0.02772144));

s6_N28_6 :=  __common__( if(((real)_addrs_10yr < 6.5), 0.033406267, 0.0011118281));

s6_N28_5 :=  __common__( if(((real)_inq_count01 < 0.5), s6_N28_6, s6_N28_7));

s6_N28_4 :=  __common__( if(((integer)c_med_hhinc < 24482), 0.038329995, -0.001265809));

s6_N28_3 :=  __common__( if(trim(C_MED_HHINC) != '', s6_N28_4, 0.01332643));

s6_N28_2 :=  __common__( if(((real)attr_num_nonderogs90 < 4.5), s6_N28_3, s6_N28_5));

s6_N28_1 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N28_2, s6_N28_9));

s6_N29_9 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.047844406, 0.0001893127));

s6_N29_8 :=  __common__( if(((real)add1_source_count < 1.5), 0.035415491, s6_N29_9));

s6_N29_7 :=  __common__( if(((real)combined_age < 67.5), s6_N29_8, 0.06915052));

s6_N29_6 :=  __common__( if(((real)_addrs_last30 < 0.5), -0.0050910574, 0.056327321));

s6_N29_5 :=  __common__( map(trim(C_BORN_USA) = ''     => -0.0062037614,
             ((real)c_born_usa < 10.5) => s6_N29_6,
                                          -0.0062037614));

s6_N29_4 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), s6_N29_5, s6_N29_7));

s6_N29_3 :=  __common__( if(((real)combined_age < 59.5), 0.015829555, 0.055474118));

s6_N29_2 :=  __common__( if(((integer)c_fammar_p < 47), s6_N29_3, s6_N29_4));

s6_N29_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N29_2, -0.026710202));

s6_N30_8 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.038949479,
             ((real)c_bel_edu < 156.5) => 0.0071309187,
                                          0.038949479));

s6_N30_7 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => s6_N30_8,
             (prof_license_category in ['2'])                     => 0.3856633,
                                                                     s6_N30_8));

s6_N30_6 :=  __common__( if(((real)combined_age < 63.5), s6_N30_7, 0.075194163));

s6_N30_5 :=  __common__( if(((real)c_murders < 162.5), -0.00043806838, s6_N30_6));

s6_N30_4 :=  __common__( if(trim(C_MURDERS) != '', s6_N30_5, 0.043007765));

s6_N30_3 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.009925098, s6_N30_4));

s6_N30_2 :=  __common__( if(((real)_nas < 1.5), s6_N30_3, 0.035072739));

s6_N30_1 :=  __common__( if(((real)add1_source_count < 1.5), 0.017898884, s6_N30_2));

s6_N31_8 :=  __common__( if(((real)_inq_count01 < 1.5), 0.0058075341, 0.055082692));

s6_N31_7 :=  __common__( if(((real)_phone_score < 1.5), -0.006736184, s6_N31_8));

s6_N31_6 :=  __common__( if(((real)rc_addrcount < 1.5), 0.021449548, 0.0074430185));

s6_N31_5 :=  __common__( if(((real)_nap < 4.5), s6_N31_6, 0.069497158));

s6_N31_4 :=  __common__( if(((real)c_fammar_p < 61.75), s6_N31_5, s6_N31_7));

s6_N31_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N31_4, -0.0024411009));

s6_N31_2 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), 0.046983653, 0.011657431));

s6_N31_1 :=  __common__( if((combo_dobscore < 65), s6_N31_2, s6_N31_3));

s6_N32_9 :=  __common__( if(((real)_rel_prop_owned_count < 1.5), 0.075357664, 0.0057424646));

s6_N32_8 :=  __common__( if(((real)_inq_count01 < 1.5), -0.00020533065, s6_N32_9));

s6_N32_7 :=  __common__( if(((real)age < 52.5), -0.0092322576, s6_N32_8));

s6_N32_6 :=  __common__( if((combo_dobscore < 80), 0.019893622, s6_N32_7));

s6_N32_5 :=  __common__( map(trim(C_POP_18_24_P) = ''      => 0.079742424,
             ((real)c_pop_18_24_p < 11.95) => 0.036078058,
                                              0.079742424));

s6_N32_4 :=  __common__( if(((real)ssn_issued18 < 0.5), 0.016512558, s6_N32_5));

s6_N32_3 :=  __common__( if(((real)_addrs_per_adl_c6 < 1.5), 0.0037353756, s6_N32_4));

s6_N32_2 :=  __common__( if(((real)c_fammar_p < 62.55), s6_N32_3, s6_N32_6));

s6_N32_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N32_2, -0.026335871));

s6_N33_9 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.036060474,
             ((real)c_hhsize < 3.875) => -0.0025561592,
                                         0.036060474));

s6_N33_8 :=  __common__( map((prof_license_category in ['0', '3', '4', '5']) => 0.024289054,
             (prof_license_category in ['1', '2'])           => 0.21205544,
                                                                0.024289054));

s6_N33_7 :=  __common__( if(((real)c_sfdu_p < 3.05), s6_N33_8, s6_N33_9));

s6_N33_6 :=  __common__( if(trim(C_SFDU_P) != '', s6_N33_7, -0.010821326));

s6_N33_5 :=  __common__( if(((real)combined_age < 33.5), 0.0075647045, 0.042243675));

s6_N33_4 :=  __common__( if(((integer)c_med_hhinc < 67557), s6_N33_5, -0.0054032371));

s6_N33_3 :=  __common__( if(trim(C_MED_HHINC) != '', s6_N33_4, -0.027189267));

s6_N33_2 :=  __common__( if(((real)add1_turnover_1yr_in < 1009.5), s6_N33_3, -0.014373438));

s6_N33_1 :=  __common__( if(((real)add1_lres < 1.5), s6_N33_2, s6_N33_6));

s6_N34_10 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.0061818563, -0.01234796));

s6_N34_9 :=  __common__( if(((real)c_lar_fam < 176.5), s6_N34_10, 0.056964455));

s6_N34_8 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N34_9, 0.0094326766));

s6_N34_7 :=  __common__( if(((real)_infutor_nap < 2.5), 0.017311049, 0.099435168));

s6_N34_6 :=  __common__( map(trim(C_LOWRENT) = ''     => s6_N34_7,
             ((real)c_lowrent < 39.2) => 0.0040229197,
                                         s6_N34_7));

s6_N34_5 :=  __common__( if(((real)add1_source_count < 2.5), 0.046991345, s6_N34_6));

s6_N34_4 :=  __common__( map(trim(C_WHITE_COL) = ''     => 0.0099489833,
             ((real)c_white_col < 28.2) => 0.071049597,
                                           0.0099489833));

s6_N34_3 :=  __common__( if(((real)add1_building_area2 < 808.5), s6_N34_4, -0.0059586208));

s6_N34_2 :=  __common__( if(((real)_inq_count01 < 1.5), s6_N34_3, s6_N34_5));

s6_N34_1 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N34_2, s6_N34_8));

s6_N35_8 :=  __common__( if(((real)_altlname < 0.5), 0.0083601325, 0.042535436));

s6_N35_7 :=  __common__( if(((real)combo_hphonecount < 0.5), s6_N35_8, -0.0051458703));

s6_N35_6 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N35_7, 0.062570801));

s6_N35_5 :=  __common__( if(((real)c_inc_15k_p < 38.85), s6_N35_6, 0.054838503));

s6_N35_4 :=  __common__( if(trim(C_INC_15K_P) != '', s6_N35_5, 0.030747977));

s6_N35_3 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0075484352, s6_N35_4));

s6_N35_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s6_N35_3, 0.021820291));

s6_N35_1 :=  __common__( if(((integer)_nas < 2), s6_N35_2, 0.031726157));

s6_N36_8 :=  __common__( if(((real)_inq_count01 < 1.5), 0.016158566, 0.069492205));

s6_N36_7 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), 3.8148606e-005, s6_N36_8));

s6_N36_6 :=  __common__( if(((real)c_murders < 162.5), -0.0059307819, s6_N36_7));

s6_N36_5 :=  __common__( if(trim(C_MURDERS) != '', s6_N36_6, -0.026305171));

s6_N36_4 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => 0.0036496816,
             (prof_license_category in ['0'])                     => 0.26261151,
                                                                     0.0036496816));

s6_N36_3 :=  __common__( if(((real)_addrs_last24 < 3.5), s6_N36_4, 0.034899331));

s6_N36_2 :=  __common__( if(((real)input_dob_match_level < 4.5), s6_N36_3, s6_N36_5));

s6_N36_1 :=  __common__( if(((real)_nas < 1.5), s6_N36_2, 0.027810162));

s6_N37_8 :=  __common__( map(trim(C_BLUE_COL) = ''      => 0.056187364,
             ((real)c_blue_col < 11.15) => 0.0012269868,
                                           0.056187364));

s6_N37_7 :=  __common__( if(((real)age < 71.5), 0.0013734169, s6_N37_8));

s6_N37_6 :=  __common__( map(trim(C_BIGAPT_P) = ''     => 0.056708628,
             ((real)c_bigapt_p < 4.15) => -0.0025175481,
                                          0.056708628));

s6_N37_5 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => 0.020365795,
             ((real)c_fammar18_p < 32.85) => 0.05172658,
                                             0.020365795));

s6_N37_4 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N37_5, s6_N37_6));

s6_N37_3 :=  __common__( if(((real)c_born_usa < 23.5), s6_N37_4, s6_N37_7));

s6_N37_2 :=  __common__( if(trim(C_BORN_USA) != '', s6_N37_3, 0.0019638536));

s6_N37_1 :=  __common__( if(((real)_addrs_last30 < 0.5), -0.0057582967, s6_N37_2));

s6_N38_8 :=  __common__( if(((real)rc_addrcount < 3.5), 0.048673638, 0.029806321));

s6_N38_7 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s6_N38_8, 0.012106937));

s6_N38_6 :=  __common__( if(((real)_inq_count01 < 0.5), 0.0063757807, 0.079763589));

s6_N38_5 :=  __common__( if(((real)_inq_count01 < 1.5), -0.0055898393, 0.011658394));

s6_N38_4 :=  __common__( if(((real)c_fammar_p < 34.65), 0.028478486, s6_N38_5));

s6_N38_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N38_4, -0.0038915858));

s6_N38_2 :=  __common__( if(((real)_rel_felony_total < 2.5), s6_N38_3, s6_N38_6));

s6_N38_1 :=  __common__( if(((real)age < 72.5), s6_N38_2, s6_N38_7));

s6_N39_9 :=  __common__( if(((real)add1_lres < 2.5), 0.026741384, 0.0083519796));

s6_N39_8 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N39_9, 0.053384083));

s6_N39_7 :=  __common__( if(((real)age < 70.5), s6_N39_8, 0.053149696));

s6_N39_6 :=  __common__( if((add1_unit_count < 26), 0.0028442409, 0.056199091));

s6_N39_5 :=  __common__( if(((real)c_lar_fam < 139.5), -0.0074293024, s6_N39_6));

s6_N39_4 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N39_5, -0.02639012));

s6_N39_3 :=  __common__( map(trim(C_HHSIZE) = ''      => -0.0057804435,
             ((real)c_hhsize < 2.745) => 0.031269244,
                                         -0.0057804435));

s6_N39_2 :=  __common__( if(((real)input_dob_match_level < 4.5), s6_N39_3, s6_N39_4));

s6_N39_1 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), s6_N39_2, s6_N39_7));

s6_N40_8 :=  __common__( if(((real)_infutor_nap < 2.5), 0.012908419, 0.065575609));

s6_N40_7 :=  __common__( map(trim(C_YOUNG) = ''      => -0.012949752,
             ((real)c_young < 27.65) => 0.032540539,
                                        -0.012949752));

s6_N40_6 :=  __common__( if(((real)_property_sold_total < 0.5), s6_N40_7, 0.047124189));

s6_N40_5 :=  __common__( if(((real)add1_lres < 2.5), s6_N40_6, 0.0039786176));

s6_N40_4 :=  __common__( map(trim(C_INC_15K_P) = ''      => 0.042267498,
             ((real)c_inc_15k_p < 38.75) => s6_N40_5,
                                            0.042267498));

s6_N40_3 :=  __common__( if(((real)c_robbery < 138.5), -0.0054600167, s6_N40_4));

s6_N40_2 :=  __common__( if(trim(C_ROBBERY) != '', s6_N40_3, -0.0055935573));

s6_N40_1 :=  __common__( if(((real)combined_age < 78.5), s6_N40_2, s6_N40_8));

s6_N41_8 :=  __common__( if(((real)c_totcrime < 112.5), 0.030209046, 0.074835871));

s6_N41_7 :=  __common__( if(trim(C_TOTCRIME) != '', s6_N41_8, -0.027248481));

s6_N41_6 :=  __common__( if(((real)_adls_per_phone_c6 < 0.5), s6_N41_7, 0.0096482833));

s6_N41_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0029262447, s6_N41_6));

s6_N41_4 :=  __common__( if(((real)_add_risk < 0.5), -0.0061986683, 0.013846192));

s6_N41_3 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N41_4, 0.033423297));

s6_N41_2 :=  __common__( if(((real)combined_age < 62.5), s6_N41_3, s6_N41_5));

s6_N41_1 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N41_2, 0.046240684));

s6_N42_9 :=  __common__( if(((real)_inq_count03_cap3 < 1.5), 0.022946172, 0.062043988));

s6_N42_8 :=  __common__( map(trim(C_TOTSALES) = ''        => 0.0091553771,
             ((integer)c_totsales < 1237) => s6_N42_9,
                                             0.0091553771));

s6_N42_7 :=  __common__( map(trim(C_AB_AV_EDU) = ''      => 0.0012841871,
             ((real)c_ab_av_edu < 118.5) => 0.046916982,
                                            0.0012841871));

s6_N42_6 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s6_N42_7, -0.0030724948));

s6_N42_5 :=  __common__( if(((real)combined_age < 62.5), -0.005620388, s6_N42_6));

s6_N42_4 :=  __common__( map(trim(C_AB_AV_EDU) = ''      => 0.012128065,
             ((real)c_ab_av_edu < 123.5) => 0.054043481,
                                            0.012128065));

s6_N42_3 :=  __common__( map(trim(C_SFDU_P) = ''     => s6_N42_5,
             ((real)c_sfdu_p < 2.55) => s6_N42_4,
                                        s6_N42_5));

s6_N42_2 :=  __common__( if(((real)c_lar_fam < 164.5), s6_N42_3, s6_N42_8));

s6_N42_1 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N42_2, 0.0077081603));

s6_N43_9 :=  __common__( if(((real)age < 48.5), -0.0060969755, 0.029035213));

s6_N43_8 :=  __common__( map(trim(C_NO_MOVE) = ''      => 0.068235814,
             ((real)c_no_move < 108.5) => s6_N43_9,
                                          0.068235814));

s6_N43_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0052503023, s6_N43_8));

s6_N43_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.003756614, 0.047301838));

s6_N43_5 :=  __common__( if(((real)_ssn_score < 1.5), s6_N43_6, 0.022254242));

s6_N43_4 :=  __common__( if(((real)_inq_peraddr_cap8 < 4.5), s6_N43_5, s6_N43_7));

s6_N43_3 :=  __common__( map(trim(C_RECENT_MOV) = ''     => 0.012472126,
             ((real)c_recent_mov < 42.5) => 0.053087585,
                                            0.012472126));

s6_N43_2 :=  __common__( if(((real)c_fammar_p < 42.75), s6_N43_3, s6_N43_4));

s6_N43_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N43_2, 0.010239427));

s6_N44_9 :=  __common__( if(((real)_num_purchase60 < 0.5), 0.059240832, 0.017520565));

s6_N44_8 :=  __common__( if(((real)c_inc_201k_p < 1.45), s6_N44_9, 0.011653585));

s6_N44_7 :=  __common__( if(trim(C_INC_201K_P) != '', s6_N44_8, -0.026894634));

s6_N44_6 :=  __common__( map(trim(C_UNEMP) = ''     => 0.054177738,
             ((real)c_unemp < 8.05) => 0.014520247,
                                       0.054177738));

s6_N44_5 :=  __common__( if(((real)c_child < 32.65), -0.0022970064, s6_N44_6));

s6_N44_4 :=  __common__( if(trim(C_CHILD) != '', s6_N44_5, 0.02005034));

s6_N44_3 :=  __common__( if(((real)age < 60.5), s6_N44_4, s6_N44_7));

s6_N44_2 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s6_N44_3, -0.0098911442));

s6_N44_1 :=  __common__( if(((real)_nas < 2.5), s6_N44_2, 0.039098259));

s6_N45_7 :=  __common__( map(trim(C_INC_150K_P) = ''     => -0.0046536783,
             ((real)c_inc_150k_p < 4.45) => 0.031559867,
                                            -0.0046536783));

s6_N45_6 :=  __common__( if(((real)combined_age < 80.5), -0.0029482145, 0.023872659));

s6_N45_5 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N45_6, 0.048937397));

s6_N45_4 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N45_5, s6_N45_7));

s6_N45_3 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), 0.00049031187, 0.02788595));

s6_N45_2 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), s6_N45_3, 0.043463121));

s6_N45_1 :=  __common__( if(((real)input_dob_match_level < 6.5), s6_N45_2, s6_N45_4));

s6_N46_7 :=  __common__( if(((real)_inq_peraddr_cap8 < 0.5), -0.0021273036, 0.032926049));

s6_N46_6 :=  __common__( if(((real)add1_unit_count < 24.5), s6_N46_7, 0.052239114));

s6_N46_5 :=  __common__( if(((real)combined_age < 34.5), -0.0047036268, s6_N46_6));

s6_N46_4 :=  __common__( if(((real)add1_source_count < 2.5), s6_N46_5, 0.0053203546));

s6_N46_3 :=  __common__( if(((real)_addrs_last30 < 0.5), 0.013201838, 0.051250941));

s6_N46_2 :=  __common__( if(((real)input_dob_match_level < 6.5), s6_N46_3, s6_N46_4));

s6_N46_1 :=  __common__( if(((real)_inq_count01 < 0.5), -0.0058428324, s6_N46_2));

s6_N47_9 :=  __common__( map(trim(C_HVAL_80K_P) = ''    => 0.073525421,
             ((real)c_hval_80k_p < 4.3) => 0.019831792,
                                           0.073525421));

s6_N47_8 :=  __common__( map(trim(C_INC_201K_P) = ''     => -0.00096470723,
             ((real)c_inc_201k_p < 2.55) => 0.04178126,
                                            -0.00096470723));

s6_N47_7 :=  __common__( if(((real)rc_addrcount < 3.5), s6_N47_8, -0.0052034081));

s6_N47_6 :=  __common__( if(((real)c_robbery < 157.5), s6_N47_7, s6_N47_9));

s6_N47_5 :=  __common__( if(trim(C_ROBBERY) != '', s6_N47_6, -0.026021322));

s6_N47_4 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.045606066, -0.0045027067));

s6_N47_3 :=  __common__( if(((real)c_hhsize < 4.005), -0.0019729694, s6_N47_4));

s6_N47_2 :=  __common__( if(trim(C_HHSIZE) != '', s6_N47_3, -0.0048731884));

s6_N47_1 :=  __common__( if(((real)combined_age < 67.5), s6_N47_2, s6_N47_5));

s6_N48_10 :=  __common__( if(((real)add1_unit_count < 10.5), 0.0013415922, 0.041598315));

s6_N48_9 :=  __common__( if(((real)c_inc_15k_p < 14.75), -0.0055184657, s6_N48_10));

s6_N48_8 :=  __common__( if(trim(C_INC_15K_P) != '', s6_N48_9, -0.026693193));

s6_N48_7 :=  __common__( if(((real)_addrs_per_adl < 5.5), -0.012074208, 0.093038492));

s6_N48_6 :=  __common__( if(((real)add2_lres < 3.5), s6_N48_7, -0.0022668346));

s6_N48_5 :=  __common__( if(((real)add1_building_area2 < 878.5), 0.057599171, s6_N48_6));

s6_N48_4 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N48_5, s6_N48_8));

s6_N48_3 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N48_4, -0.0048128245));

s6_N48_2 :=  __common__( if(((real)_nas < 1.5), s6_N48_3, 0.022160944));

s6_N48_1 :=  __common__( if(((real)_rel_felony_count < 1.5), s6_N48_2, 0.04062368));

s6_N49_10 :=  __common__( if(((integer)c_relig_indx < 126), 0.068846497, -0.0065232892));

s6_N49_9 :=  __common__( if(trim(C_RELIG_INDX) != '', s6_N49_10, 0.087433949));

s6_N49_8 :=  __common__( map(trim(C_LOWINC) = ''     => 0.036211542,
             ((real)c_lowinc < 36.2) => -0.0011407681,
                                        0.036211542));

s6_N49_7 :=  __common__( if(((real)add1_lres < 1.5), s6_N49_8, -0.0054536793));

s6_N49_6 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N49_7, -0.0051625817));

s6_N49_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s6_N49_6, 0.016793532));

s6_N49_4 :=  __common__( if(((real)c_ownocc_p < 1.75), 0.035205174, s6_N49_5));

s6_N49_3 :=  __common__( if(trim(C_OWNOCC_P) != '', s6_N49_4, -0.026288655));

s6_N49_2 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N49_3, s6_N49_9));

s6_N49_1 :=  __common__( if(((real)_nas < 1.5), s6_N49_2, 0.022593676));

s6_N50_9 :=  __common__( if(((real)c_hval_60k_p < 28.05), 0.0094244577, 0.04587963));

s6_N50_8 :=  __common__( if(trim(C_HVAL_60K_P) != '', s6_N50_9, -0.026062171));

s6_N50_7 :=  __common__( if(((real)combined_age < 73.5), s6_N50_8, 0.047536683));

s6_N50_6 :=  __common__( if(((real)_rel_educationunder12_count < 3.5), 0.0086775351, 0.042579747));

s6_N50_5 :=  __common__( if(((real)combo_hphonecount < 0.5), s6_N50_6, -0.0080063212));

s6_N50_4 :=  __common__( if(((real)c_fammar_p < 74.45), s6_N50_5, -0.0072090285));

s6_N50_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N50_4, 0.0029219093));

s6_N50_2 :=  __common__( if(((real)_inq_count01 < 1.5), s6_N50_3, s6_N50_7));

s6_N50_1 :=  __common__( if(((real)_nas < 2.5), s6_N50_2, 0.027377284));

s6_N51_8 :=  __common__( if(((real)input_dob_match_level < 6.5), 0.028075737, 0.0096684553));

s6_N51_7 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), 0.15702644, s6_N51_8));

s6_N51_6 :=  __common__( if(((real)combo_hphonecount < 0.5), s6_N51_7, -0.0035098399));

s6_N51_5 :=  __common__( if(((real)c_rentocc_p < 86.4), s6_N51_6, 0.044448863));

s6_N51_4 :=  __common__( if(trim(C_RENTOCC_P) != '', s6_N51_5, 0.035755495));

s6_N51_3 :=  __common__( if(((integer)add2_avm_med < 238914), 0.024064088, 0.063928269));

s6_N51_2 :=  __common__( if(((real)_rel_within25miles_count < 0.5), s6_N51_3, s6_N51_4));

s6_N51_1 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0054985688, s6_N51_2));

s6_N52_8 :=  __common__( map(trim(C_UNEMP) = ''     => 0.045660234,
             ((real)c_unemp < 3.25) => 0.024829617,
                                       0.045660234));

s6_N52_7 :=  __common__( if(((real)c_ownocc_p < 10.8), 0.028181391, 0.00032042723));

s6_N52_6 :=  __common__( if(trim(C_OWNOCC_P) != '', s6_N52_7, -0.0260166));

s6_N52_5 :=  __common__( if(((real)add1_source_count < 1.5), 0.022377649, s6_N52_6));

s6_N52_4 :=  __common__( if(((real)age < 74.5), s6_N52_5, 0.03398024));

s6_N52_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s6_N52_4, s6_N52_8));

s6_N52_2 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), -0.0048095061, s6_N52_3));

s6_N52_1 :=  __common__( if(((real)_nas < 1.5), s6_N52_2, 0.021144378));

s6_N53_8 :=  __common__( map(trim(C_BIGAPT_P) = ''     => 0.06656086,
             ((real)c_bigapt_p < 7.25) => 0.025736763,
                                          0.06656086));

s6_N53_7 :=  __common__( map(trim(C_LOWINC) = ''     => 0.046717186,
             ((real)c_lowinc < 52.3) => -0.005413664,
                                        0.046717186));

s6_N53_6 :=  __common__( map(trim(C_RENTOCC_P) = ''     => s6_N53_7,
             ((real)c_rentocc_p < 5.05) => 0.053106398,
                                           s6_N53_7));

s6_N53_5 :=  __common__( if(((real)input_dob_match_level < 6.5), 0.039519557, s6_N53_6));

s6_N53_4 :=  __common__( if(((real)c_unempl < 137.5), s6_N53_5, s6_N53_8));

s6_N53_3 :=  __common__( if(trim(C_UNEMPL) != '', s6_N53_4, -0.026073331));

s6_N53_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0011837758, s6_N53_3));

s6_N53_1 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0037364027, s6_N53_2));

s6_N54_8 :=  __common__( if(((real)_rel_prop_owned_total < 1.5), 0.05668712, 0.0024318497));

s6_N54_7 :=  __common__( if(((real)_inq_perssn < 1.5), 0.002319204, s6_N54_8));

s6_N54_6 :=  __common__( if(((real)add1_lres < 214.5), 0.0047948967, 0.054901592));

s6_N54_5 :=  __common__( if(((real)_phone_score < 1.5), -0.0058145256, s6_N54_6));

s6_N54_4 :=  __common__( if(((real)c_unemp < 8.05), s6_N54_5, s6_N54_7));

s6_N54_3 :=  __common__( if(trim(C_UNEMP) != '', s6_N54_4, 0.015732403));

s6_N54_2 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N54_3, 0.031550809));

s6_N54_1 :=  __common__( if(((real)_nas < 2.5), s6_N54_2, 0.019705287));

s6_N55_9 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.037218998, 0.0025275366));

s6_N55_8 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N55_9, -0.0011326731));

s6_N55_7 :=  __common__( if(((real)c_unemp < 5.65), s6_N55_8, 0.056352271));

s6_N55_6 :=  __common__( if(trim(C_UNEMP) != '', s6_N55_7, -0.025903029));

s6_N55_5 :=  __common__( if(((real)_inq_perssn < 2.5), -7.3628394e-005, 0.038867415));

s6_N55_4 :=  __common__( if(((real)add1_unit_count < 42.5), s6_N55_5, 0.080053128));

s6_N55_3 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), -0.0024738837, s6_N55_4));

s6_N55_2 :=  __common__( if(((real)combined_age < 71.5), s6_N55_3, s6_N55_6));

s6_N55_1 :=  __common__( if((combo_dobscore < 65), 0.014977129, s6_N55_2));

s6_N56_8 :=  __common__( map(trim(C_HIGHINC) = ''     => 0.015064765,
             ((real)c_highinc < 9.85) => 0.072938919,
                                         0.015064765));

s6_N56_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.013398687, s6_N56_8));

s6_N56_6 :=  __common__( if(((real)combined_age < 61.5), 0.0015374553, s6_N56_7));

s6_N56_5 :=  __common__( if(((real)combo_hphonecount < 0.5), s6_N56_6, -0.0097503942));

s6_N56_4 :=  __common__( if(((real)c_hval_100k_p < 14.1), 0.036537918, 0.0028925584));

s6_N56_3 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N56_4, -0.026610097));

s6_N56_2 :=  __common__( if(((real)_inq_count03_cap3 < 1.5), 0.0015704863, s6_N56_3));

s6_N56_1 :=  __common__( if(((real)add1_source_count < 1.5), s6_N56_2, s6_N56_5));

s6_N57_7 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), 0.010999286, 0.078922234));

s6_N57_6 :=  __common__( if(((real)_phone_risk < 0.5), -0.0037300091, 0.016330914));

s6_N57_5 :=  __common__( map(trim(C_MED_RENT) = ''       => 0.042683959,
             ((integer)c_med_rent < 687) => -0.00072009123,
                                            0.042683959));

s6_N57_4 :=  __common__( if(((real)input_dob_match_level < 5.5), s6_N57_5, s6_N57_6));

s6_N57_3 :=  __common__( if(((real)_ssncount < 1.5), -0.015552844, s6_N57_4));

s6_N57_2 :=  __common__( if(((real)avg_lres < 4.5), 0.036326907, s6_N57_3));

s6_N57_1 :=  __common__( if(((real)add1_unit_count < 208.5), s6_N57_2, s6_N57_7));

s6_N58_8 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), 0.00028499086, 0.03536258));

s6_N58_7 :=  __common__( map(trim(C_TOTCRIME) = ''      => 0.052394054,
             ((real)c_totcrime < 140.5) => s6_N58_8,
                                           0.052394054));

s6_N58_6 :=  __common__( if(((integer)add2_eda_sourced < 0.5), -0.00053398272, s6_N58_7));

s6_N58_5 :=  __common__( if(((real)combined_age < 33.5), -0.010597239, s6_N58_6));

s6_N58_4 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N58_5, 0.03177639));

s6_N58_3 :=  __common__( if(((real)c_lar_fam < 184.5), s6_N58_4, 0.041876239));

s6_N58_2 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N58_3, 0.017996355));

s6_N58_1 :=  __common__( if(((real)_nas < 2.5), s6_N58_2, 0.027341709));

s6_N59_8 :=  __common__( if(((real)add1_building_area2 > NULL), 0.0091052745, 0.065949829));

s6_N59_7 :=  __common__( map(trim(C_SFDU_P) = ''     => -0.00070240441,
             ((real)c_sfdu_p < 7.45) => 0.024268216,
                                        -0.00070240441));

s6_N59_6 :=  __common__( if(((real)add1_source_count < 1.5), 0.017709742, s6_N59_7));

s6_N59_5 :=  __common__( if(((real)add2_naprop < 0.5), -0.00817953, s6_N59_6));

s6_N59_4 :=  __common__( if(((real)c_lar_fam < 181.5), s6_N59_5, s6_N59_8));

s6_N59_3 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N59_4, -0.0094166116));

s6_N59_2 :=  __common__( if(((real)age < 84.5), s6_N59_3, 0.033517129));

s6_N59_1 :=  __common__( if(((real)_ssncount < 0.5), 0.019346166, s6_N59_2));

s6_N60_8 :=  __common__( map(trim(C_ASSAULT) = ''      => 0.047742017,
             ((real)c_assault < 175.5) => 0.008569754,
                                          0.047742017));

s6_N60_7 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 351.5), s6_N60_8, 0.055325218));

s6_N60_6 :=  __common__( if(((real)c_inc_25k_p < 16.65), s6_N60_7, 0.051517662));

s6_N60_5 :=  __common__( if(trim(C_INC_25K_P) != '', s6_N60_6, -0.026164567));

s6_N60_4 :=  __common__( if(((real)_inq_perssn < 1.5), -0.0032435195, s6_N60_5));

s6_N60_3 :=  __common__( if(((real)add1_lres < 377.5), -0.0038705455, 0.0394847));

s6_N60_2 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), s6_N60_3, s6_N60_4));

s6_N60_1 :=  __common__( if(((integer)_nas < 2), s6_N60_2, 0.021978565));

s6_N61_9 :=  __common__( if(((real)c_mort_indx < 127.5), 0.047072105, -0.00094572791));

s6_N61_8 :=  __common__( if(trim(C_MORT_INDX) != '', s6_N61_9, -0.026712552));

s6_N61_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0033255555, s6_N61_8));

s6_N61_6 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => 0.05312873,
             ((real)c_asian_lang < 109.5) => 0.001828246,
                                             0.05312873));

s6_N61_5 :=  __common__( if(((real)c_retired2 < 74.5), -0.0056976232, s6_N61_6));

s6_N61_4 :=  __common__( if(trim(C_RETIRED2) != '', s6_N61_5, -0.026265973));

s6_N61_3 :=  __common__( if((combo_dobscore < 92), s6_N61_4, -0.0045157066));

s6_N61_2 :=  __common__( if(((real)age < 66.5), s6_N61_3, s6_N61_7));

s6_N61_1 :=  __common__( if(((real)_nas < 1.5), s6_N61_2, 0.024543897));

s6_N62_9 :=  __common__( map(trim(C_TRAILER_P) = ''      => 0.0020938342,
             ((real)c_trailer_p < 18.65) => 0.065140589,
                                            0.0020938342));

s6_N62_8 :=  __common__( map(trim(C_BLUE_EMPL) = ''      => -0.0076060597,
             ((real)c_blue_empl < 128.5) => 0.028973551,
                                            -0.0076060597));

s6_N62_7 :=  __common__( if(((real)_phones_per_adl < 0.5), 0.00020285904, s6_N62_8));

s6_N62_6 :=  __common__( if(((real)add1_source_count < 2.5), s6_N62_7, -0.0020013727));

s6_N62_5 :=  __common__( if((add2_avm_automated_valuation < 1.0875e+006), s6_N62_6, 0.065061266));

s6_N62_4 :=  __common__( map(trim(C_HVAL_20K_P) = ''      => s6_N62_9,
             ((real)c_hval_20k_p < 28.35) => s6_N62_5,
                                             s6_N62_9));

s6_N62_3 :=  __common__( if(((real)_rel_felony_count < 2.5), s6_N62_4, 0.055001838));

s6_N62_2 :=  __common__( if(((real)c_rentocc_p < 92.95), s6_N62_3, 0.046791862));

s6_N62_1 :=  __common__( if(trim(C_RENTOCC_P) != '', s6_N62_2, -0.0091679167));

s6_N63_7 :=  __common__( if(((real)_inq_count < 4.5), 0.012782689, 0.084573653));

s6_N63_6 :=  __common__( if(((real)add1_lres < 2.5), 0.012763836, -0.0027681981));

s6_N63_5 :=  __common__( if(((real)avg_lres < 235.5), s6_N63_6, s6_N63_7));

s6_N63_4 :=  __common__( if(((real)add3_source_count < 8.5), s6_N63_5, 0.045585403));

s6_N63_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.011080906, 0.0470426));

s6_N63_2 :=  __common__( if((combo_dobscore < 95), s6_N63_3, s6_N63_4));

s6_N63_1 :=  __common__( if(((real)_inq_count01 < 0.5), -0.0055183477, s6_N63_2));

s6_N64_8 :=  __common__( map(trim(C_BLUE_EMPL) = ''      => 0.087677416,
             ((real)c_blue_empl < 167.5) => 0.0061474047,
                                            0.087677416));
s6_N64_7 :=  __common__( map(trim(C_FAMMAR_P) = ''      => 7.0218859e-006,
             ((real)c_fammar_p < 64.15) => 0.031135735,
                                           7.0218859e-006));
s6_N64_6 :=  __common__( if(mth_header_first_seen != null and ((real)mth_header_first_seen < 245.5), s6_N64_7, 0.039704834));
s6_N64_5 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N64_6, s6_N64_8));
s6_N64_4 :=  __common__( if(((real)_inq_count01 < 0.5), -7.7554371e-005, s6_N64_5));
s6_N64_3 :=  __common__( if(((real)c_robbery < 136.5), -0.00399808, s6_N64_4));
s6_N64_2 :=  __common__( if(trim(C_ROBBERY) != '', s6_N64_3, 0.0022222729));
s6_N64_1 :=  __common__( if(((real)_ssn_score < 1.5), s6_N64_2, 0.02521947));

s6_N65_10 :=  __common__( if(((real)_inq_count01 < 0.5), 0.012241954, 0.054974352));
s6_N65_9 :=  __common__( if(((real)c_low_ed < 28.2), -0.026292838, s6_N65_10));
s6_N65_8 :=  __common__( if(trim(C_LOW_ED) != '', s6_N65_9, -0.025853649));
s6_N65_7 :=  __common__( if(((real)ssn_lowissue_age < 0.15471), -0.021646796, -0.00092010499));
s6_N65_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N65_7, 0.018699437));
s6_N65_5 :=  __common__( if(((real)age < 77.5), s6_N65_6, s6_N65_8));
s6_N65_4 :=  __common__( if(((real)c_inc_25k_p < 7.15), 0.044349302, -0.0066517786));
s6_N65_3 :=  __common__( if(trim(C_INC_25K_P) != '', s6_N65_4, -0.026555019));
s6_N65_2 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), s6_N65_3, 0.050824458));
s6_N65_1 :=  __common__( if(((real)_rel_within25miles_count < 0.5), s6_N65_2, s6_N65_5));

s6_N66_10 :=  __common__( if(((real)input_dob_match_level < 6.5), 0.025603594, 0.0067435312));

s6_N66_9 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0056619835, s6_N66_10));

s6_N66_8 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s6_N66_9, -0.014247009));

s6_N66_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s6_N66_8, 0.022303645));

s6_N66_6 :=  __common__( map(trim(C_LOWINC) = ''     => 0.063229182,
             ((real)c_lowinc < 52.8) => 0.0059661152,
                                        0.063229182));

s6_N66_5 :=  __common__( map(trim(C_LARCENY) = ''     => -0.001751631,
             ((real)c_larceny < 84.5) => s6_N66_6,
                                         -0.001751631));

s6_N66_4 :=  __common__( if(((integer)add1_building_area2 < 1091), 0.057679332, -0.00068925124));

s6_N66_3 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N66_4, s6_N66_5));

s6_N66_2 :=  __common__( if(((real)c_white_col < 21.85), s6_N66_3, s6_N66_7));

s6_N66_1 :=  __common__( if(trim(C_WHITE_COL) != '', s6_N66_2, -0.010594906));

s6_N67_10 :=  __common__( if(((real)c_born_usa < 14.5), 0.056283964, 0.010680426));

s6_N67_9 :=  __common__( if(trim(C_BORN_USA) != '', s6_N67_10, 0.10232806));

s6_N67_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.003149732, 0.027336957));

s6_N67_7 :=  __common__( if(((real)mth_header_first_seen < 295.5), 0.0030226783, -0.032337524));

s6_N67_6 :=  __common__( if(((real)mth_header_first_seen > NULL), s6_N67_7, -0.032252423));

s6_N67_5 :=  __common__( map(trim(C_RNT500_P) = ''     => 0.023156873,
             ((real)c_rnt500_p < 37.5) => s6_N67_6,
                                          0.023156873));

s6_N67_4 :=  __common__( if(((real)c_highrent < 13.85), s6_N67_5, 0.049012444));

s6_N67_3 :=  __common__( if(trim(C_HIGHRENT) != '', s6_N67_4, -0.026144937));

s6_N67_2 :=  __common__( if((combo_dobscore < 92), s6_N67_3, s6_N67_8));

s6_N67_1 :=  __common__( if((add1_unit_count < 250), s6_N67_2, s6_N67_9));

s6_N68_9 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.0064814101,
             ((real)c_incollege < 5.55) => 0.0638537,
                                           0.0064814101));
s6_N68_8 :=  __common__( map(trim(C_NO_MOVE) = ''      => 0.036456797,
             ((real)c_no_move < 160.5) => -0.0012317935,
                                          0.036456797));
s6_N68_7 :=  __common__( if(((real)_phones_per_addr < 8.5), s6_N68_8, s6_N68_9));
s6_N68_6 :=  __common__( if(((real)add2_source_count < 4.5), 4.3231025e-007, 0.061904012));
s6_N68_5 :=  __common__( map(trim(C_MED_INC) = ''     => s6_N68_6,
             ((real)c_med_inc < 66.5) => 0.053126402,
                                         s6_N68_6));
s6_N68_4 :=  __common__( if(rc_dirsaddr_lastscore != null and ((real)rc_dirsaddr_lastscore < 37.5), s6_N68_5, s6_N68_7));
s6_N68_3 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.035222855,
             ((real)c_span_lang < 190.5) => -0.0039363523,
                                            0.035222855));
s6_N68_2 :=  __common__( if(((real)c_lar_fam < 134.5), s6_N68_3, s6_N68_4));
s6_N68_1 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N68_2, -0.010837361));

s6_N69_8 :=  __common__( if(((real)_addrs_last30 < 0.5), 0.0061757401, 0.048921399));
s6_N69_7 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.015887586,
             ((integer)c_easiqlife < 87) => 0.11667531,
                                            0.015887586));
s6_N69_6 :=  __common__( map(trim(C_HVAL_20K_P) = ''      => 0.03532177,
             ((real)c_hval_20k_p < 26.45) => -0.00034377992,
                                             0.03532177));
s6_N69_5 :=  __common__( map(trim(C_SFDU_P) = ''      => s6_N69_7,
             ((real)c_sfdu_p < 96.65) => s6_N69_6,
                                         s6_N69_7));
s6_N69_4 :=  __common__( if(((real)c_born_usa < 62.5), s6_N69_5, -0.0062605492));
s6_N69_3 :=  __common__( if(trim(C_BORN_USA) != '', s6_N69_4, -0.026246212));
s6_N69_2 :=  __common__( if(((real)_nap < 5.5), s6_N69_3, 0.035474132));
s6_N69_1 :=  __common__( if(((real)_rel_felony_total < 2.5), s6_N69_2, s6_N69_8));

s6_N70_8 :=  __common__( map(trim(C_RENTOCC_P) = ''      => 0.085297591,
             ((real)c_rentocc_p < 25.05) => 0.015282313,
                                            0.085297591));
s6_N70_7 :=  __common__( if(ssn_lowissue_age != null and ((real)ssn_lowissue_age < 12.6438), 0.0042166243, 0.10079779));
s6_N70_6 :=  __common__( if(((real)c_fammar18_p < 54.15), -0.00075196434, s6_N70_7));
s6_N70_5 :=  __common__( if(trim(C_FAMMAR18_P) != '', s6_N70_6, -0.026143766));
s6_N70_4 :=  __common__( if(((real)_inq_count06 < 3.5), s6_N70_5, s6_N70_8));
s6_N70_3 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.0044048157, 0.024589546));
s6_N70_2 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N70_3, 0.025338683));
s6_N70_1 :=  __common__( if(((real)_phone_score < 1.5), s6_N70_2, s6_N70_4));

s6_N71_9 :=  __common__( if(((integer)c_med_hval < 38991), 0.043249043, 0.0046672886));
s6_N71_8 :=  __common__( if(trim(C_MED_HVAL) != '', s6_N71_9, -0.025877456));
s6_N71_7 :=  __common__( if(((real)_util_adl_count < 3.5), 0.0060109623, 0.046763124));
s6_N71_6 :=  __common__( map(trim(C_FAMMAR_P) = ''      => s6_N71_7,
             ((real)c_fammar_p < 67.15) => 0.044448137,
                                           s6_N71_7));
s6_N71_5 :=  __common__( if(((real)c_civ_emp < 65.35), -0.0015977863, 0.024344121));
s6_N71_4 :=  __common__( if(trim(C_CIV_EMP) != '', s6_N71_5, 0.075815865));
s6_N71_3 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), s6_N71_4, s6_N71_6));
s6_N71_2 :=  __common__( if(((real)add1_source_count < 3.5), s6_N71_3, s6_N71_8));
s6_N71_1 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.001351231, s6_N71_2));

s6_N72_8 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => 0.07837722,
             ((real)c_asian_lang < 145.5) => 0.0033349272,
                                             0.07837722));

s6_N72_7 :=  __common__( if(((real)age < 59.5), 0.004776162, 0.03428974));

s6_N72_6 :=  __common__( if(((real)_adls_per_addr_cap10 < 7.5), -0.015758175, s6_N72_7));

s6_N72_5 :=  __common__( if(((real)add1_unit_count < 170.5), s6_N72_6, 0.049418082));

s6_N72_4 :=  __common__( if(((real)_phone_risk < 0.5), s6_N72_5, s6_N72_8));

s6_N72_3 :=  __common__( if(((real)c_lar_fam < 131.5), -0.0040692064, s6_N72_4));

s6_N72_2 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N72_3, 0.0061117015));

s6_N72_1 :=  __common__( if(((real)_nap < 5.5), s6_N72_2, 0.036786135));

s6_N73_9 :=  __common__( if((avg_lres < 146), 0.011291229, 0.070943241));

s6_N73_8 :=  __common__( if(((real)combo_hphonecount < 0.5), s6_N73_9, 0.0018173484));

s6_N73_7 :=  __common__( if(((real)combined_age < 63.5), -0.00099710355, s6_N73_8));

s6_N73_6 :=  __common__( if(((real)input_dob_match_level < 4.5), 0.02018827, -0.003483399));

s6_N73_5 :=  __common__( if(((real)add2_avm_to_med_ratio < 1.854), s6_N73_6, 0.041470143));

s6_N73_4 :=  __common__( if(((real)c_rnt500_p < 71.95), s6_N73_5, 0.047386175));

s6_N73_3 :=  __common__( if(trim(C_RNT500_P) != '', s6_N73_4, -0.025788841));

s6_N73_2 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N73_3, s6_N73_7));

s6_N73_1 :=  __common__( if(((real)_inq_perphone < 0.5), s6_N73_2, -0.0080341687));

s6_N74_8 :=  __common__( if(((real)_rel_prop_owned_total < 1.5), 0.054481119, 0.0070394369));

s6_N74_7 :=  __common__( map(trim(C_HVAL_40K_P) = ''    => -0.0087252136,
             ((real)c_hval_40k_p < 0.5) => s6_N74_8,
                                           -0.0087252136));

s6_N74_6 :=  __common__( map(trim(C_UNEMPL) = ''      => 0.058624731,
             ((real)c_unempl < 140.5) => s6_N74_7,
                                         0.058624731));

s6_N74_5 :=  __common__( if(((real)c_for_sale < 126.5), 0.05861317, -0.0062405611));

s6_N74_4 :=  __common__( if(trim(C_FOR_SALE) != '', s6_N74_5, -0.025993401));

s6_N74_3 :=  __common__( if(((real)age < 67.5), 0.0015911242, s6_N74_4));

s6_N74_2 :=  __common__( if(((real)_inq_count01 < 1.5), s6_N74_3, s6_N74_6));

s6_N74_1 :=  __common__( if(((real)add_bestmatch_level < 1.5), -0.0042450185, s6_N74_2));

s6_N75_9 :=  __common__( if(((integer)add1_building_area2 < 1858), 0.061897104, 0.0044536493));

s6_N75_8 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N75_9, 0.020982274));

s6_N75_7 :=  __common__( if(((real)add1_avm_automated_valuation < 62965.5), s6_N75_8, 0.00099154545));

s6_N75_6 :=  __common__( map(trim(C_LOWRENT) = ''      => 0.037557618,
             ((real)c_lowrent < 87.85) => -0.012276382,
                                          0.037557618));

s6_N75_5 :=  __common__( if(((integer)add2_avm_med < 400975), s6_N75_6, 0.039483391));

s6_N75_4 :=  __common__( map(trim(C_MED_INC) = ''     => -0.0051771492,
             ((real)c_med_inc < 15.5) => s6_N75_5,
                                         -0.0051771492));

s6_N75_3 :=  __common__( if(((real)_ssn_score < 1.5), s6_N75_4, 0.018394477));

s6_N75_2 :=  __common__( if(trim(C_MED_INC) != '', s6_N75_3, 0.0083223689));

s6_N75_1 :=  __common__( if(((real)combined_age < 67.5), s6_N75_2, s6_N75_7));

s6_N76_8 :=  __common__( if(((real)_lnames_per_adl < 2.5), 0.069862896, 0.016309018));

s6_N76_7 :=  __common__( if(((real)_addrs_last90 < 0.5), -0.01245653, s6_N76_8));

s6_N76_6 :=  __common__( if(((real)c_rentocc_p < 30.65), 0.066198924, 0.00085613947));

s6_N76_5 :=  __common__( if(trim(C_RENTOCC_P) != '', s6_N76_6, -0.026367483));

s6_N76_4 :=  __common__( if(((real)add2_lres < 31.5), s6_N76_5, 0.0022107167));

s6_N76_3 :=  __common__( if(((real)_add_risk < 0.5), -0.0027592074, s6_N76_4));

s6_N76_2 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N76_3, 0.029777586));

s6_N76_1 :=  __common__( if(((real)_rel_felony_total < 2.5), s6_N76_2, s6_N76_7));

s6_N77_8 :=  __common__( if(((real)age < 48.5), -0.0036872265, 0.050032846));
s6_N77_7 :=  __common__( map(trim(C_RENTAL) = ''      => 0.027455899,
             ((real)c_rental < 101.5) => 0.094658939,
                                         0.027455899));
s6_N77_6 :=  __common__( if(((real)c_med_age < 61.5), s6_N77_7, s6_N77_8));
s6_N77_5 :=  __common__( if(trim(C_MED_AGE) != '', s6_N77_6, -0.025738249));
s6_N77_4 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.028190099, -0.00036403314));
s6_N77_3 :=  __common__( if(((real)_rel_criminal_total < 2.5), s6_N77_4, s6_N77_5));
s6_N77_2 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0080731509, 0.0037466699));
s6_N77_1 :=  __common__( if(((real)_phone_score < 1.5), s6_N77_2, s6_N77_3));

s6_N78_8 :=  __common__( map(trim(C_LARCENY) = ''     => 0.058335413,
             ((real)c_larceny < 62.5) => 0.0058011255,
                                         0.058335413));
s6_N78_7 :=  __common__( if(((real)_paw_business_match < 0.5), s6_N78_8, 0.0087785307));
s6_N78_6 :=  __common__( if(trim(C_APT20) != '', s6_N78_7, 0.31251428));
s6_N78_5 :=  __common__( if(((real)add2_lres < 2.5), 0.039129624, 0.00020018645));
s6_N78_4 :=  __common__( if(((real)add2_naprop < 3.5), s6_N78_5, 0.037089124));
s6_N78_3 :=  __common__( if(((integer)add2_avm_med < 181307), -0.013823625, s6_N78_4));
s6_N78_2 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((real)mth_ver_src_fsrc_fdate < 257.5), s6_N78_3, s6_N78_6));
s6_N78_1 :=  __common__( if(((real)rc_addrcount < 2.5), s6_N78_2, -0.00081658077));

s6_N79_9 :=  __common__( if(((real)_inq_count01 < 1.5), 0.020220587, 0.058160036));
s6_N79_8 :=  __common__( if(trim(C_RNT750_P) != '', s6_N79_9, 0.3586601));
s6_N79_7 :=  __common__( if(((real)rc_dirsaddr_lastscore < 28.5), 0.056597102, 0.0072399135));
s6_N79_6 :=  __common__( if(((real)age < 50.5), -0.0042911302, s6_N79_7));
s6_N79_5 :=  __common__( if(((integer)lname_eda_sourced < 0.5), 0.040258996, -0.013509523));
s6_N79_4 :=  __common__( if(((real)c_many_cars < 27.5), s6_N79_5, s6_N79_6));
s6_N79_3 :=  __common__( if(trim(C_MANY_CARS) != '', s6_N79_4, -0.02604981));
s6_N79_2 :=  __common__( if(((real)add3_lres < 210.5), s6_N79_3, s6_N79_8));
s6_N79_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), -0.0026247269, s6_N79_2));

s6_N80_7 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((real)mth_ver_src_fsrc_fdate < 154.5), 0.064365628, 0.005327615));
s6_N80_6 :=  __common__( if(((real)rc_addrcount < 3.5), 0.062119227, 0.021788066));
s6_N80_5 :=  __common__( if(mth_header_first_seen != null and ((real)mth_header_first_seen < 259.5), s6_N80_6, 0.0041371452));
s6_N80_4 :=  __common__( if(((integer)add3_avm_automated_valuation < 318459), 0.0019385002, s6_N80_5));
s6_N80_3 :=  __common__( if(((real)add_bestmatch_level < 1.5), -0.0042048308, s6_N80_4));
s6_N80_2 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 3.5), s6_N80_3, s6_N80_7));
s6_N80_1 :=  __common__( if(((real)add1_nhood_vacant_properties < 745.5), s6_N80_2, 0.044457078));

s6_N81_9 :=  __common__( if(((real)c_rape < 69.5), -0.0063478346, 0.049326658));
s6_N81_8 :=  __common__( if(trim(C_RAPE) != '', s6_N81_9, -0.026430223));
s6_N81_7 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.036157286,
             ((real)c_relig_indx < 122.5) => -0.0066739529,
                                             0.036157286));
s6_N81_6 :=  __common__( map(trim(C_FAMMAR18_P) = ''     => 0.078562983,
             ((real)c_fammar18_p < 47.7) => 0.0056952966,
                                            0.078562983));
s6_N81_5 :=  __common__( if(((real)c_assault < 178.5), -0.0024502187, s6_N81_6));
s6_N81_4 :=  __common__( if(trim(C_ASSAULT) != '', s6_N81_5, 0.0051017557));
s6_N81_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N81_4, s6_N81_7));
s6_N81_2 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N81_3, s6_N81_8));
s6_N81_1 :=  __common__( if((combo_dobscore < 65), 0.014279589, s6_N81_2));

s6_N82_9 :=  __common__( if(((real)rc_addrcount < 3.5), 0.0072674079, -0.0035184466));

s6_N82_8 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => 0.046678296,
             ((real)c_asian_lang < 146.5) => 0.0064020357,
                                             0.046678296));

s6_N82_7 :=  __common__( if(((real)ssn_lowissue_age < 25.4436), s6_N82_8, -0.0098756128));

s6_N82_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N82_7, 0.017248329));

s6_N82_5 :=  __common__( map(trim(C_NO_MOVE) = ''      => 0.054914027,
             ((real)c_no_move < 132.5) => s6_N82_6,
                                          0.054914027));

s6_N82_4 :=  __common__( if(((real)c_rnt750_p < 10.4), -0.0084046418, s6_N82_5));

s6_N82_3 :=  __common__( if(trim(C_RNT750_P) != '', s6_N82_4, -0.02654548));

s6_N82_2 :=  __common__( if(((real)input_dob_match_level < 7.5), s6_N82_3, s6_N82_9));

s6_N82_1 :=  __common__( if(((real)combined_age < 29.5), -0.012596336, s6_N82_2));

s6_N83_9 :=  __common__( if(((real)rc_addrcount < 4.5), 0.047148924, -0.013338809));

s6_N83_8 :=  __common__( map((prof_license_category in ['0', '2', '3', '4', '5']) => s6_N83_9,
             (prof_license_category in ['1'])                     => 0.21288621,
                                                                     s6_N83_9));

s6_N83_7 :=  __common__( map(trim(C_TOTCRIME) = ''     => -0.002227558,
             ((real)c_totcrime < 65.5) => s6_N83_8,
                                          -0.002227558));

s6_N83_6 :=  __common__( if(((real)c_blue_empl < 27.5), 0.057453014, s6_N83_7));

s6_N83_5 :=  __common__( if(trim(C_BLUE_EMPL) != '', s6_N83_6, -0.026537567));

s6_N83_4 :=  __common__( if(((real)c_hval_100k_p < 30.75), -0.0039351469, 0.011430056));

s6_N83_3 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N83_4, -0.010298729));

s6_N83_2 :=  __common__( if((add2_avm_automated_valuation < 1.1575e+006), s6_N83_3, 0.045885398));

s6_N83_1 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 2.5), s6_N83_2, s6_N83_5));

s6_N84_9 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.054786808,
             ((real)c_span_lang < 160.5) => 0.014416639,
                                            0.054786808));

s6_N84_8 :=  __common__( if(((real)c_hval_80k_p < 1.3), s6_N84_9, -0.00024463331));

s6_N84_7 :=  __common__( if(trim(C_HVAL_80K_P) != '', s6_N84_8, 0.12611112));

s6_N84_6 :=  __common__( map((prof_license_category in ['0', '1', '2']) => s6_N84_7,
             (prof_license_category in ['3', '4', '5']) => 0.11526152,
                                                           s6_N84_7));

s6_N84_5 :=  __common__( if(((real)c_inc_150k_p < 1.75), 0.042229506, 0.011251377));

s6_N84_4 :=  __common__( if(trim(C_INC_150K_P) != '', s6_N84_5, -0.027494928));

s6_N84_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), 0.0015090824, s6_N84_4));

s6_N84_2 :=  __common__( if(((real)add1_unit_count < 22.5), s6_N84_3, s6_N84_6));

s6_N84_1 :=  __common__( if(((real)add_bestmatch_level < 1.5), -0.0027786389, s6_N84_2));

s6_N85_8 :=  __common__( if(((real)add1_lres < 53.5), -0.0059494314, 0.003253178));

s6_N85_7 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N85_8, 0.022246012));

s6_N85_6 :=  __common__( map(trim(C_APT20) = ''       => 0.028715888,
             ((integer)c_apt20 < 130) => -0.010980322,
                                         0.028715888));

s6_N85_5 :=  __common__( map(trim(C_RETIRED2) = ''     => 0.045351767,
             ((real)c_retired2 < 62.5) => 0.0015745661,
                                          0.045351767));

s6_N85_4 :=  __common__( if(((real)add1_avm_to_med_ratio < 1.09864), s6_N85_5, -0.015163474));

s6_N85_3 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s6_N85_4, s6_N85_6));

s6_N85_2 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => s6_N85_3,
             (prof_license_category in ['0'])                     => 0.26977768,
                                                                     s6_N85_3));

s6_N85_1 :=  __common__( if((combo_dobscore < 92), s6_N85_2, s6_N85_7));

s6_N86_10 :=  __common__( if(((real)ssn_lowissue_age > NULL), 0.003493943, -0.10792089));

s6_N86_9 :=  __common__( map(trim(C_LOW_HVAL) = ''    => 0.046799114,
             ((real)c_low_hval < 3.5) => s6_N86_10,
                                         0.046799114));

s6_N86_8 :=  __common__( map(trim(C_SFDU_P) = ''     => -0.0056964036,
             ((real)c_sfdu_p < 3.05) => s6_N86_9,
                                        -0.0056964036));

s6_N86_7 :=  __common__( if(((real)c_hhsize < 3.695), s6_N86_8, 0.029843757));

s6_N86_6 :=  __common__( if(trim(C_HHSIZE) != '', s6_N86_7, -0.026861923));

s6_N86_5 :=  __common__( map(trim(C_LAR_FAM) = ''      => 0.029990596,
             ((real)c_lar_fam < 107.5) => -0.004464381,
                                          0.029990596));

s6_N86_4 :=  __common__( if(((real)add1_lres < 1.5), s6_N86_5, -0.0019770939));

s6_N86_3 :=  __common__( map(trim(C_FAMMAR_P) = ''     => -0.0019957422,
             ((real)c_fammar_p < 74.5) => 0.057394213,
                                          -0.0019957422));

s6_N86_2 :=  __common__( if(((real)add1_building_area2 < 780.5), s6_N86_3, s6_N86_4));

s6_N86_1 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N86_2, s6_N86_6));

s6_N87_10 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), 0.075403321, 0.014444785));

s6_N87_9 :=  __common__( map(trim(C_WHITE_COL) = ''     => 0.076332078,
             ((real)c_white_col < 58.3) => 0.0064547443,
                                           0.076332078));

s6_N87_8 :=  __common__( if(((real)c_lar_fam < 130.5), s6_N87_9, s6_N87_10));

s6_N87_7 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N87_8, -0.025671907));

s6_N87_6 :=  __common__( if(((real)c_femdiv_p < 6.75), -0.0049605794, 0.036890497));

s6_N87_5 :=  __common__( if(trim(C_FEMDIV_P) != '', s6_N87_6, -0.026080942));

s6_N87_4 :=  __common__( if(((real)add1_lres < 66.5), s6_N87_5, s6_N87_7));

s6_N87_3 :=  __common__( if(((real)c_lar_fam < 158.5), -0.0053514947, 0.009969772));

s6_N87_2 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N87_3, 0.04368624));

s6_N87_1 :=  __common__( if(((real)_phone_score < 1.5), s6_N87_2, s6_N87_4));

s6_N88_9 :=  __common__( map(trim(C_RECENT_MOV) = ''     => 0.018894158,
             ((real)c_recent_mov < 62.5) => 0.06729588,
                                            0.018894158));

s6_N88_8 :=  __common__( if(((real)_rel_bankrupt_count < 0.5), -0.0089311066, 0.064424116));

s6_N88_7 :=  __common__( map(trim(C_WHITE_COL) = ''      => -0.0056193583,
             ((real)c_white_col < 28.05) => s6_N88_8,
                                            -0.0056193583));

s6_N88_6 :=  __common__( map(trim(C_RETIRED2) = ''     => 0.074465839,
             ((real)c_retired2 < 94.5) => 0.0015700892,
                                          0.074465839));

s6_N88_5 :=  __common__( if(((real)add2_lres < 5.5), s6_N88_6, s6_N88_7));

s6_N88_4 :=  __common__( map(trim(C_RNT500_P) = ''     => s6_N88_9,
             ((real)c_rnt500_p < 39.9) => s6_N88_5,
                                          s6_N88_9));

s6_N88_3 :=  __common__( if(((real)_inq_collection_count < 1.5), -0.0021975958, s6_N88_4));
s6_N88_2 :=  __common__( if(((real)c_inc_150k_p < 0.55), -0.010324808, s6_N88_3));
s6_N88_1 :=  __common__( if(trim(C_INC_150K_P) != '', s6_N88_2, 0.00014872217));


s6_N89_9 :=  __common__( if( mth_header_first_seen != null and ((real)mth_header_first_seen < 333.5), 0.071170369, 0.026339584));
s6_N89_8 :=  __common__( if(((real)c_recent_mov < 98.5), s6_N89_9, 0.014586635));
s6_N89_7 :=  __common__( if(trim(C_RECENT_MOV) != '', s6_N89_8, -0.028667424));
s6_N89_6 :=  __common__( map(trim(C_HVAL_80K_P) = ''     => -0.019370822,
             ((real)c_hval_80k_p < 0.65) => 0.025677839,
                                            -0.019370822));
s6_N89_5 :=  __common__( if(((real)c_high_ed < 9.95), 0.036184247, s6_N89_6));
s6_N89_4 :=  __common__( if(trim(C_HIGH_ED) != '', s6_N89_5, -0.026369816));
s6_N89_3 :=  __common__( if(((real)combined_age < 63.5), s6_N89_4, s6_N89_7));
s6_N89_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.002642073, s6_N89_3));
s6_N89_1 :=  __common__( if(((real)age < 49.5), -0.0017194788, s6_N89_2));

s6_N90_9 :=  __common__( if(((real)_adls_per_addr_cap10 < 8.5), -0.010952517, 0.030958936));
s6_N90_8 :=  __common__( map(trim(C_FEMDIV_P) = ''     => 0.046369918,
             ((real)c_femdiv_p < 6.05) => s6_N90_9,
                                          0.046369918));

s6_N90_7 :=  __common__( if(((real)age < 60.5), -0.0017377633, s6_N90_8));

s6_N90_6 :=  __common__( if(((real)c_med_hval < 37171.5), 0.037578504, s6_N90_7));

s6_N90_5 :=  __common__( if(trim(C_MED_HVAL) != '', s6_N90_6, 0.034349959));

s6_N90_4 :=  __common__( if(((real)add2_avm_to_med_ratio < 1.71804), 0.0038412096, 0.045271804));

s6_N90_3 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N90_4, s6_N90_5));

s6_N90_2 :=  __common__( if(((real)rc_addrcount < 1.5), -0.015875871, -0.0055342457));

s6_N90_1 :=  __common__( if(((real)_inq_count01 < 0.5), s6_N90_2, s6_N90_3));

s6_N91_10 :=  __common__( if(((real)c_fammar_p < 77.65), 0.063716011, -0.012446857));

s6_N91_9 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N91_10, -0.025873875));

s6_N91_8 :=  __common__( if(((real)_addrs_15yr < 3.5), s6_N91_9, 0.0012317198));

s6_N91_7 :=  __common__( if(((real)add2_lres < 30.5), 0.051900123, 0.01656861));

s6_N91_6 :=  __common__( map(trim(C_RAPE) = ''     => s6_N91_7,
             ((real)c_rape < 42.5) => -0.024297126,
                                      s6_N91_7));

s6_N91_5 :=  __common__( if(((real)add1_avm_to_med_ratio < 0.742725), 0.057172513, -0.00081036192));

s6_N91_4 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s6_N91_5, s6_N91_6));

s6_N91_3 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N91_4, s6_N91_8));

s6_N91_2 :=  __common__( if(((real)_inq_collection_count < 1.5), -0.0031287534, s6_N91_3));

s6_N91_1 :=  __common__( if(((real)_ssn_score < 1.5), s6_N91_2, 0.019020489));

s6_N92_10 :=  __common__( if(((real)c_cartheft < 141.5), 0.0047678656, 0.046070835));

s6_N92_9 :=  __common__( if(trim(C_CARTHEFT) != '', s6_N92_10, 0.1130917));

s6_N92_8 :=  __common__( if(((real)ssn_lowissue_age < 15.7243), -0.0013869614, s6_N92_9));

s6_N92_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N92_8, 0.05183626));

s6_N92_6 :=  __common__( if(((real)combined_age < 68.5), s6_N92_7, 0.043831032));

s6_N92_5 :=  __common__( if(((real)add_errorcode < 0.5), -0.00013815049, -0.025475506));

s6_N92_4 :=  __common__( if(((real)c_hval_20k_p < 28.35), s6_N92_5, 0.035094762));

s6_N92_3 :=  __common__( if(trim(C_HVAL_20K_P) != '', s6_N92_4, -0.026590002));

s6_N92_2 :=  __common__( if(((real)combined_age < 31.5), -0.012001576, s6_N92_3));

s6_N92_1 :=  __common__( if(((real)_rel_felony_count < 0.5), s6_N92_2, s6_N92_6));

s6_N93_7 :=  __common__( if(((real)_rel_prop_owned_total < 1.5), 0.047237227, 0.0035189444));

s6_N93_6 :=  __common__( if(((real)_inq_perphone < 0.5), 0.00030308439, -0.0083721752));

s6_N93_5 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.014704623, 0.040477698));

s6_N93_4 :=  __common__( if(((real)input_dob_match_level < 2.5), s6_N93_5, s6_N93_6));

s6_N93_3 :=  __common__( if(((real)_nap < 5.5), s6_N93_4, 0.033086848));

s6_N93_2 :=  __common__( if((add2_avm_automated_valuation < 1.02435e+006), s6_N93_3, 0.038260539));

s6_N93_1 :=  __common__( if(((real)_rel_felony_total < 2.5), s6_N93_2, s6_N93_7));

s6_N94_9 :=  __common__( if(((real)add1_turnover_1yr_in < 243.5), -0.0048472804, 0.047025403));

s6_N94_8 :=  __common__( map(trim(C_RENTOCC_P) = ''     => -0.015750913,
             ((real)c_rentocc_p < 54.7) => s6_N94_9,
                                           -0.015750913));

s6_N94_7 :=  __common__( if(((real)add1_unit_count < 16.5), s6_N94_8, 0.039585311));

s6_N94_6 :=  __common__( map(trim(C_INC_35K_P) = ''      => s6_N94_7,
             ((real)c_inc_35k_p < 10.95) => -0.0074385694,
                                            s6_N94_7));

s6_N94_5 :=  __common__( if(((real)age < 58.5), s6_N94_6, 0.036311266));

s6_N94_4 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s6_N94_5, -0.0090392599));

s6_N94_3 :=  __common__( if(((real)_phone_score < 1.5), -0.004563656, 0.0077996188));

s6_N94_2 :=  __common__( if(((real)c_unempl < 149.5), s6_N94_3, s6_N94_4));

s6_N94_1 :=  __common__( if(trim(C_UNEMPL) != '', s6_N94_2, -0.015330011));

s6_N95_8 :=  __common__( if((add1_avm_automated_valuation < 176384), 0.042157654, -0.0057882205));

s6_N95_7 :=  __common__( if(((real)rc_addrcount < 4.5), 0.047729144, -0.0068918753));

s6_N95_6 :=  __common__( map(trim(C_CHILD) = ''      => 0.040049591,
             ((real)c_child < 25.65) => -0.0046860088,
                                        0.040049591));

s6_N95_5 :=  __common__( map(trim(C_MED_HHINC) = ''         => 0.0039898019,
             ((integer)c_med_hhinc < 25726) => s6_N95_6,
                                               0.0039898019));

s6_N95_4 :=  __common__( if(((real)_addrs_last30 < 0.5), -0.0039394185, s6_N95_5));

s6_N95_3 :=  __common__( if(((real)c_hval_100k_p < 50.75), s6_N95_4, s6_N95_7));

s6_N95_2 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N95_3, -0.0070984596));

s6_N95_1 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N95_2, s6_N95_8));

s6_N96_9 :=  __common__( map(trim(C_RETIRED2) = ''     => 0.037441147,
             ((real)c_retired2 < 32.5) => -0.0070861937,
                                          0.037441147));

s6_N96_8 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.056500617,
             ((real)c_low_ed < 25.95) => 0.001630933,
                                         0.056500617));

s6_N96_7 :=  __common__( map(trim(C_CIV_EMP) = ''     => s6_N96_8,
             ((real)c_civ_emp < 70.4) => -0.0074166096,
                                         s6_N96_8));

s6_N96_6 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), s6_N96_7, 0.023495055));

s6_N96_5 :=  __common__( if(((real)add1_source_count < 2.5), s6_N96_6, -0.00094747418));

s6_N96_4 :=  __common__( if(((real)attr_num_nonderogs180 < 2.5), -0.01553717, s6_N96_5));

s6_N96_3 :=  __common__( if(((real)_nas < 1.5), s6_N96_4, 0.013654347));

s6_N96_2 :=  __common__( if(((real)c_lar_fam < 181.5), s6_N96_3, s6_N96_9));

s6_N96_1 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N96_2, 0.01603203));

s6_N97_8 :=  __common__( if(((real)add1_lres < 238.5), -0.0061768586, 0.039656252));

s6_N97_7 :=  __common__( if(((real)add3_lres < 136.5), -0.012374753, 0.040992918));

s6_N97_6 :=  __common__( map(trim(C_HVAL_100K_P) = ''     => 0.006203308,
             ((real)c_hval_100k_p < 6.45) => 0.046364218,
                                             0.006203308));

s6_N97_5 :=  __common__( if(((real)c_fammar_p < 72.4), s6_N97_6, s6_N97_7));

s6_N97_4 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N97_5, -0.025777185));

s6_N97_3 :=  __common__( if(((real)age < 54.5), s6_N97_4, 0.04567805));

s6_N97_2 :=  __common__( if(((real)_num_purchase60 < 0.5), s6_N97_3, s6_N97_8));

s6_N97_1 :=  __common__( if(((real)_phone_score < 1.5), -0.0016238895, s6_N97_2));

s6_N98_8 :=  __common__( map(trim(C_UNEMPL) = ''       => 0.036309729,
             ((integer)c_unempl < 104) => -0.014920046,
                                          0.036309729));

s6_N98_7 :=  __common__( map(trim(C_MED_AGE) = ''      => -0.0093834418,
             ((integer)c_med_age < 73) => 0.036155204,
                                          -0.0093834418));

s6_N98_6 :=  __common__( map(trim(C_WHITE_COL) = ''      => 0.0037505235,
             ((real)c_white_col < 17.15) => 0.03579491,
                                            0.0037505235));

s6_N98_5 :=  __common__( if(((real)_phone_score < 1.5), -0.0048879797, s6_N98_6));

s6_N98_4 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N98_5, s6_N98_7));

s6_N98_3 :=  __common__( if(((real)c_hval_20k_p < 28.6), s6_N98_4, s6_N98_8));

s6_N98_2 :=  __common__( if(trim(C_HVAL_20K_P) != '', s6_N98_3, 0.0058551562));

s6_N98_1 :=  __common__( if((combo_dobscore < 55), 0.016126689, s6_N98_2));

s6_N99_8 :=  __common__( if(((real)_addrs_15yr < 5.5), 0.067731957, 0.015104491));
s6_N99_7 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), -0.0025570174, 0.026677395));
s6_N99_6 :=  __common__( if(((real)_inq_count06 < 2.5), s6_N99_7, s6_N99_8));
s6_N99_5 :=  __common__( if(((integer)add1_building_area2 < 826), 0.03371134, -0.0031477868));
s6_N99_4 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N99_5, 0.00094577601));
s6_N99_3 :=  __common__( if(((real)age < 55.5), s6_N99_4, s6_N99_6));
s6_N99_2 :=  __common__( if(((real)_ssn_score < 1.5), s6_N99_3, 0.022118947));
s6_N99_1 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s6_N99_2, -0.0080335926));

s6_N100_10 :=  __common__( if(ssn_lowissue_age != null and ((real)ssn_lowissue_age < 12.2755), 0.020316542, -0.0020734753));
s6_N100_9 :=  __common__( if(((real)add2_avm_to_med_ratio < 1.58378), 0.0028375152, 0.044049364));
s6_N100_8 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N100_9, s6_N100_10));
s6_N100_7 :=  __common__( if(((real)c_hval_20k_p < 0.05), 0.0073126413, 0.052830175));
s6_N100_6 :=  __common__( if(trim(C_HVAL_20K_P) != '', s6_N100_7, -0.025721217));
s6_N100_5 :=  __common__( if(((real)rc_dirsaddr_lastscore < 34.5), s6_N100_6, s6_N100_8));
s6_N100_4 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((real)mth_ver_src_fsrc_fdate < 13.5), 0.034130101, -0.0051622321));
s6_N100_3 :=  __common__( if(((real)mth_header_first_seen < 173.5), s6_N100_4, s6_N100_5));
s6_N100_2 :=  __common__( if(((real)mth_header_first_seen > NULL), s6_N100_3, -0.02812979));
s6_N100_1 :=  __common__( if(((real)add2_lres < 127.5), s6_N100_2, -0.0067177787));

s6_N101_9 :=  __common__( if(((real)_phones_per_addr < 1.5), -0.015683819, 0.042190561));
s6_N101_8 :=  __common__( if(((integer)add1_avm_med < 390526), s6_N101_9, 0.062554152));
s6_N101_7 :=  __common__( map(trim(C_RETIRED2) = ''     => -0.0031250966,
              ((real)c_retired2 < 38.5) => s6_N101_8,
                                           -0.0031250966));
s6_N101_6 :=  __common__( if(((real)add1_lres < 2.5), 0.022744578, -0.0036776249));
s6_N101_5 :=  __common__( if(((integer)add1_building_area2 < 1137), 0.026408202, s6_N101_6));
s6_N101_4 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N101_5, s6_N101_7));
s6_N101_3 :=  __common__( if(((real)c_lar_fam < 128.5), -0.0034207325, s6_N101_4));
s6_N101_2 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N101_3, -0.013128845));
s6_N101_1 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.03600525, s6_N101_2));

s6_N102_9 :=  __common__( map((prof_license_category in ['0', '2', '3', '4', '5']) => 0.0046002313,
              (prof_license_category in ['1'])                     => 0.19132296,
                                                                      0.0046002313));

s6_N102_8 :=  __common__( if(((real)_rel_criminal_total < 3.5), s6_N102_9, 0.053275074));

s6_N102_7 :=  __common__( map(trim(C_MURDERS) = ''       => 0.050259896,
              ((integer)c_murders < 173) => -0.001696834,
                                            0.050259896));

s6_N102_6 :=  __common__( if(((real)add1_source_count < 2.5), 0.027332291, s6_N102_7));

s6_N102_5 :=  __common__( map(trim(C_MANY_CARS) = ''     => -0.001729631,
              ((real)c_many_cars < 25.5) => 0.01510763,
                                            -0.001729631));

s6_N102_4 :=  __common__( map(trim(C_INC_150K_P) = ''     => s6_N102_5,
              ((real)c_inc_150k_p < 0.35) => -0.013525131,
                                             s6_N102_5));

s6_N102_3 :=  __common__( if(((real)_inq_perssn < 3.5), s6_N102_4, s6_N102_6));

s6_N102_2 :=  __common__( if(((real)c_rnt500_p < 71.35), s6_N102_3, s6_N102_8));

s6_N102_1 :=  __common__( if(trim(C_RNT500_P) != '', s6_N102_2, -0.012404194));

s6_N103_9 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), 0.0030536461, 0.02770731));

s6_N103_8 :=  __common__( if(((real)c_retired2 < 7.5), 0.04683589, s6_N103_9));

s6_N103_7 :=  __common__( if(trim(C_RETIRED2) != '', s6_N103_8, 0.024856798));

s6_N103_6 :=  __common__( if(((real)add3_source_count < 1.5), 0.070912712, 0.0035677761));

s6_N103_5 :=  __common__( if(((real)_ssncount < 1.5), -0.01978725, -0.0055445611));

s6_N103_4 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 3.5), s6_N103_5, s6_N103_6));

s6_N103_3 :=  __common__( if(((real)c_hhsize < 4.005), s6_N103_4, 0.028918484));

s6_N103_2 :=  __common__( if(trim(C_HHSIZE) != '', s6_N103_3, -0.027373741));

s6_N103_1 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), s6_N103_2, s6_N103_7));

s6_N104_9 :=  __common__( if((add2_avm_automated_valuation < 775319), -0.0078193922, 0.041968297));

s6_N104_8 :=  __common__( map(trim(C_LAR_FAM) = ''      => 0.028782365,
              ((real)c_lar_fam < 172.5) => s6_N104_9,
                                           0.028782365));

s6_N104_7 :=  __common__( if(((real)c_born_usa < 8.5), -0.024676508, s6_N104_8));

s6_N104_6 :=  __common__( if(trim(C_BORN_USA) != '', s6_N104_7, -0.026737014));

s6_N104_5 :=  __common__( map(trim(C_FAMMAR_P) = ''      => 0.0018033568,
              ((real)c_fammar_p < 34.05) => 0.018669482,
                                            0.0018033568));

s6_N104_4 :=  __common__( if(((real)c_hhsize < 1.515), 0.039832189, s6_N104_5));

s6_N104_3 :=  __common__( if(trim(C_HHSIZE) != '', s6_N104_4, 0.016380773));

s6_N104_2 :=  __common__( if(((real)_inq_perphone < 0.5), s6_N104_3, s6_N104_6));

s6_N104_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N104_2, 0.026327286));

s6_N105_8 :=  __common__( if(((real)_inq_perphone < 0.5), 0.072250563, 0.027883571));

s6_N105_7 :=  __common__( map(trim(C_BORN_USA) = ''     => 0.014581424,
              ((real)c_born_usa < 25.5) => s6_N105_8,
                                           0.014581424));

s6_N105_6 :=  __common__( if(((real)_rel_vehicle_owned_count < 0.5), -0.0053855643, s6_N105_7));

s6_N105_5 :=  __common__( if(((real)c_rentocc_p < 54.65), 0.0017428158, s6_N105_6));

s6_N105_4 :=  __common__( if(trim(C_RENTOCC_P) != '', s6_N105_5, 0.01883873));

s6_N105_3 :=  __common__( if(((real)add_bestmatch_level < 1.5), -0.0033380617, s6_N105_4));

s6_N105_2 :=  __common__( if(((real)avg_lres < 5.5), 0.02317802, s6_N105_3));

s6_N105_1 :=  __common__( if((combo_dobscore < 65), 0.014113001, s6_N105_2));

s6_N106_13 :=  __common__( map(trim(C_FOR_SALE) = ''      => 0.046644064,
               ((real)c_for_sale < 180.5) => 0.0020892234,
                                             0.046644064));

s6_N106_12 :=  __common__( if(((real)combined_age < 67.5), s6_N106_13, 0.03154599));

s6_N106_11 :=  __common__( if(((real)c_lar_fam < 134.5), -0.0039043091, s6_N106_12));

s6_N106_10 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N106_11, 0.0085268003));

s6_N106_9 :=  __common__( map(trim(C_SPAN_LANG) = ''       => 0.065586452,
              ((integer)c_span_lang < 144) => 0.01460131,
                                              0.065586452));

s6_N106_8 :=  __common__( if(((real)add2_nhood_vacant_properties < 13.5), -0.0057098093, s6_N106_9));

s6_N106_7 :=  __common__( if(((integer)c_cartheft < 160), -0.005318382, s6_N106_8));

s6_N106_6 :=  __common__( if(trim(C_CARTHEFT) != '', s6_N106_7, -0.026093608));

s6_N106_5 :=  __common__( if(((real)c_hval_100k_p < 40.6), -0.001397024, 0.048700499));

s6_N106_4 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N106_5, -0.025776794));

s6_N106_3 :=  __common__( if(((real)add1_building_area2 < 878.5), 0.040646427, s6_N106_4));

s6_N106_2 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N106_3, s6_N106_6));

s6_N106_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N106_2, s6_N106_10));

s6_N107_8 :=  __common__( map(trim(C_TRAILER_P) = ''      => 0.057967129,
              ((real)c_trailer_p < 14.15) => 0.0078309961,
                                             0.057967129));

s6_N107_7 :=  __common__( map(trim(C_APT20) = ''      => 0.012024509,
              ((real)c_apt20 < 121.5) => -0.013342386,
                                         0.012024509));

s6_N107_6 :=  __common__( if(((real)_ssns_per_addr < 9.5), s6_N107_7, s6_N107_8));

s6_N107_5 :=  __common__( map(trim(C_LOWRENT) = ''      => 0.038901507,
              ((integer)c_lowrent < 86) => s6_N107_6,
                                           0.038901507));

s6_N107_4 :=  __common__( if(((real)c_retired2 < 8.5), 0.050578018, s6_N107_5));

s6_N107_3 :=  __common__( if(trim(C_RETIRED2) != '', s6_N107_4, -0.025904382));

s6_N107_2 :=  __common__( if(((real)_property_sold_total < 0.5), -0.003097544, s6_N107_3));

s6_N107_1 :=  __common__( if(((real)age < 83.5), s6_N107_2, 0.023605197));

s6_N108_8 :=  __common__( if(((integer)add1_avm_med < 141613), 0.074325483, 0.010220284));

s6_N108_7 :=  __common__( map(trim(C_AB_AV_EDU) = ''      => 0.0026408946,
              ((real)c_ab_av_edu < 146.5) => -0.019956089,
                                             0.0026408946));

s6_N108_6 :=  __common__( map(trim(C_EASIQLIFE) = ''     => s6_N108_7,
              ((real)c_easiqlife < 81.5) => 0.01434067,
                                            s6_N108_7));

s6_N108_5 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N108_6, -0.0016969329));

s6_N108_4 :=  __common__( if(((real)c_ownocc_p < 92.95), s6_N108_5, s6_N108_8));

s6_N108_3 :=  __common__( if(trim(C_OWNOCC_P) != '', s6_N108_4, -0.026825583));

s6_N108_2 :=  __common__( if(((real)add2_naprop < 3.5), 0.0060583854, 0.044905475));

s6_N108_1 :=  __common__( if(((real)_rel_within25miles_count < 0.5), s6_N108_2, s6_N108_3));

s6_N109_8 :=  __common__( map(trim(C_BORN_USA) = ''      => 0.06160831,
              ((real)c_born_usa < 152.5) => -0.001186934,
                                            0.06160831));

s6_N109_7 :=  __common__( if(((real)add1_source_count < 2.5), 0.02641268, s6_N109_8));

s6_N109_6 :=  __common__( if(((real)_rel_educationunder12_count < 1.5), -0.0054461175, 0.0067592247));

s6_N109_5 :=  __common__( map(trim(C_UNEMPL) = ''      => -0.02141472,
              ((real)c_unempl < 182.5) => s6_N109_6,
                                          -0.02141472));

s6_N109_4 :=  __common__( if(((real)c_hval_100k_p < 30.75), s6_N109_5, s6_N109_7));

s6_N109_3 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N109_4, 0.020154902));

s6_N109_2 :=  __common__( if((combo_dobscore < 65), 0.010986237, s6_N109_3));

s6_N109_1 :=  __common__( if(((real)_nas < 1.5), s6_N109_2, 0.014792653));

s6_N110_7 :=  __common__( if(((real)attr_num_nonderogs90 < 5.5), 0.032855695, -0.0018069985));

s6_N110_6 :=  __common__( if((add2_avm_automated_valuation < 36706), -0.014013977, 0.029163702));

s6_N110_5 :=  __common__( if(((real)_addr_stability_v2 < 4.5), 0.055326253, s6_N110_6));

s6_N110_4 :=  __common__( if(((real)_add_risk < 0.5), 0.001425003, s6_N110_5));

s6_N110_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N110_4, s6_N110_7));

s6_N110_2 :=  __common__( if(((real)rc_addrcount < 1.5), -0.017403336, -0.0081217816));

s6_N110_1 :=  __common__( if(((real)combined_age < 31.5), s6_N110_2, s6_N110_3));

s6_N111_9 :=  __common__( map(trim(C_TOTCRIME) = ''      => 0.08791982,
              ((integer)c_totcrime < 77) => -0.0068663367,
                                            0.08791982));

s6_N111_8 :=  __common__( if(((integer)add1_avm_med < 118931), 0.070626474, 0.0010865552));

s6_N111_7 :=  __common__( map(trim(C_BURGLARY) = ''    => s6_N111_8,
              ((real)c_burglary < 7.5) => 0.061390311,
                                          s6_N111_8));

s6_N111_6 :=  __common__( map(trim(C_RENTOCC_P) = ''     => -0.0029997901,
              ((real)c_rentocc_p < 4.75) => s6_N111_7,
                                            -0.0029997901));

s6_N111_5 :=  __common__( map(trim(C_MED_HVAL) = ''         => s6_N111_6,
              ((integer)c_med_hval < 30704) => 0.020591865,
                                               s6_N111_6));

s6_N111_4 :=  __common__( map(trim(C_INC_25K_P) = ''      => -0.0169242,
              ((real)c_inc_25k_p < 19.95) => s6_N111_5,
                                             -0.0169242));

s6_N111_3 :=  __common__( if(((real)_adls_per_ssn_c6 < 0.5), s6_N111_4, 0.041808867));

s6_N111_2 :=  __common__( if(((real)c_easiqlife < 170.5), s6_N111_3, s6_N111_9));

s6_N111_1 :=  __common__( if(trim(C_EASIQLIFE) != '', s6_N111_2, 0.0076302299));

s6_N112_9 :=  __common__( if((add2_avm_automated_valuation < 988944), -0.0022291304, 0.044638114));

s6_N112_8 :=  __common__( if(((real)combined_age < 83.5), s6_N112_9, 0.026719963));

s6_N112_7 :=  __common__( map((prof_license_category in ['0', '3', '4', '5']) => 0.0023264597,
              (prof_license_category in ['1', '2'])           => 0.11333746,
                                                                 0.0023264597));

s6_N112_6 :=  __common__( if(((integer)add1_avm_med < 449665), s6_N112_7, 0.050458273));

s6_N112_5 :=  __common__( map(trim(C_CHILD) = ''      => 0.015571322,
              ((real)c_child < 28.85) => -0.00054159466,
                                         0.015571322));

s6_N112_4 :=  __common__( if(((real)_addrs_last90 < 2.5), s6_N112_5, s6_N112_6));

s6_N112_3 :=  __common__( if(((real)_rel_bankrupt_count < 4.5), s6_N112_4, 0.043108234));

s6_N112_2 :=  __common__( if(((real)c_many_cars < 63.5), s6_N112_3, s6_N112_8));

s6_N112_1 :=  __common__( if(trim(C_MANY_CARS) != '', s6_N112_2, 0.0020998377));

s6_N113_8 :=  __common__( map(trim(C_RENTOCC_P) = ''     => -0.0095628022,
              ((integer)c_rentocc_p < 4) => 0.062788094,
                                            -0.0095628022));

s6_N113_7 :=  __common__( map((prof_license_category in ['0', '2', '3']) => s6_N113_8,
              (prof_license_category in ['1', '4', '5']) => 0.14459436,
                                                            s6_N113_8));

s6_N113_6 :=  __common__( map(trim(C_RAPE) = ''     => 0.072332754,
              ((real)c_rape < 52.5) => 0.013743914,
                                       0.072332754));

s6_N113_5 :=  __common__( map(trim(C_FAMMAR_P) = ''      => s6_N113_7,
              ((real)c_fammar_p < 83.05) => s6_N113_6,
                                            s6_N113_7));

s6_N113_4 :=  __common__( if(((real)add3_lres < 99.5), -0.0094423315, 0.028667709));

s6_N113_3 :=  __common__( if(((real)c_inc_201k_p < 2.75), s6_N113_4, s6_N113_5));

s6_N113_2 :=  __common__( if(trim(C_INC_201K_P) != '', s6_N113_3, -0.026614534));

s6_N113_1 :=  __common__( if(((real)add2_lres < 5.5), s6_N113_2, -0.00095269883));

s6_N114_9 :=  __common__( if(((real)c_low_ed < 68.8), 0.010916768, -0.025004455));

s6_N114_8 :=  __common__( if(trim(C_LOW_ED) != '', s6_N114_9, -0.025777419));

s6_N114_7 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s6_N114_8, 0.0071122778));

s6_N114_6 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), 0.059928007, 0.018550747));

s6_N114_5 :=  __common__( if(((real)combo_dobcount < 5.5), s6_N114_6, -0.0017866688));

s6_N114_4 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), -0.0043469833, s6_N114_5));

s6_N114_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), s6_N114_4, s6_N114_7));

s6_N114_2 :=  __common__( if(((real)add1_lres < 424.5), s6_N114_3, 0.044153163));

s6_N114_1 :=  __common__( if(((real)_ssncount < 1.5), -0.012430263, s6_N114_2));

s6_N115_9 :=  __common__( map(trim(C_RNT750_P) = ''    => 0.10768272,
              ((real)c_rnt750_p < 6.1) => -0.014412042,
                                          0.10768272));

s6_N115_8 :=  __common__( map(trim(C_ASSAULT) = ''     => 0.0093777042,
              ((real)c_assault < 44.5) => s6_N115_9,
                                          0.0093777042));

s6_N115_7 :=  __common__( if(((real)add2_source_count < 1.5), s6_N115_8, -0.0015693968));

s6_N115_6 :=  __common__( if(((real)c_easiqlife < 42.5), 0.049451916, s6_N115_7));

s6_N115_5 :=  __common__( if(trim(C_EASIQLIFE) != '', s6_N115_6, -0.0256861));

s6_N115_4 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N115_5, 0.0036212523));

s6_N115_3 :=  __common__( if(((real)rc_phoneaddr_addrcount < 0.5), -0.0061542827, s6_N115_4));

s6_N115_2 :=  __common__( if((combo_dobscore < 65), 0.019144307, s6_N115_3));

s6_N115_1 :=  __common__( if(((real)_ssncount < 2.5), -0.0093639404, s6_N115_2));

s6_N116_7 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.042928956,
              ((real)c_span_lang < 117.5) => -0.016267004,
                                             0.042928956));

s6_N116_6 :=  __common__( if(((real)phn_cellpager < 0.5), s6_N116_7, 0.056155425));

s6_N116_5 :=  __common__( if(((integer)combined_age < 58), 0.0086891377, 0.033587192));

s6_N116_4 :=  __common__( if(((real)rc_dirsaddr_lastscore < 37.5), s6_N116_5, -0.0020901565));

s6_N116_3 :=  __common__( map((prof_license_category in ['1', '2', '4', '5']) => s6_N116_4,
              (prof_license_category in ['0', '3'])           => 0.058890462,
                                                                 s6_N116_4));

s6_N116_2 :=  __common__( if(((real)add3_lres < 259.5), s6_N116_3, s6_N116_6));

s6_N116_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), -0.0014813775, s6_N116_2));

s6_N117_8 :=  __common__( if(((real)add_bestmatch_level < 1.5), 0.010741404, 0.04692746));

s6_N117_7 :=  __common__( if(((real)add3_source_count < 7.5), 0.003117281, s6_N117_8));

s6_N117_6 :=  __common__( if(((real)c_high_ed < 5.55), -0.015620117, s6_N117_7));

s6_N117_5 :=  __common__( if(trim(C_HIGH_ED) != '', s6_N117_6, -0.00091917254));

s6_N117_4 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N117_5, 0.020110956));

s6_N117_3 :=  __common__( if(((integer)utility_sourced < 0.5), s6_N117_4, -0.0063158256));

s6_N117_2 :=  __common__( map((prof_license_category in ['1', '2', '3', '4']) => 0.017301756,
              (prof_license_category in ['0', '5'])           => 0.15120713,
                                                                 0.017301756));

s6_N117_1 :=  __common__( if(((real)avg_lres < 7.5), s6_N117_2, s6_N117_3));

s6_N118_10 :=  __common__( if(((real)_phone_score < 2.5), -0.0085241633, 0.036136096));

s6_N118_9 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s6_N118_10, -0.00069926675));

s6_N118_8 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), 0.012109754, 0.095617078));

s6_N118_7 :=  __common__( map(trim(C_VACANT_P) = ''     => s6_N118_9,
              ((real)c_vacant_p < 2.25) => s6_N118_8,
                                           s6_N118_9));

s6_N118_6 :=  __common__( if(((real)_rel_count_addr < 2.5), 0.0011762142, -0.0081190403));

s6_N118_5 :=  __common__( if(((real)_phone_risk < 0.5), s6_N118_6, s6_N118_7));

s6_N118_4 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.05052467,
              ((real)c_civ_emp < 72.35) => -0.0068446573,
                                           0.05052467));

s6_N118_3 :=  __common__( map((prof_license_category in ['0', '1', '2', '4', '5']) => s6_N118_4,
              (prof_license_category in ['3'])                     => 0.31479214,
                                                                      s6_N118_4));

s6_N118_2 :=  __common__( if(((real)c_mort_indx < 9.5), s6_N118_3, s6_N118_5));

s6_N118_1 :=  __common__( if(trim(C_MORT_INDX) != '', s6_N118_2, 0.017775225));

s6_N119_9 :=  __common__( map(trim(C_MED_RENT) = ''      => 0.018031259,
              ((real)c_med_rent < 630.5) => 0.050550623,
                                            0.018031259));

s6_N119_8 :=  __common__( map((prof_license_category in ['0', '1'])           => s6_N119_9,
              (prof_license_category in ['2', '3', '4', '5']) => 0.15391717,
                                                                 s6_N119_9));

s6_N119_7 :=  __common__( map(trim(C_YOUNG) = ''      => s6_N119_8,
              ((real)c_young < 23.45) => -0.022441524,
                                         s6_N119_8));

s6_N119_6 :=  __common__( map(trim(C_HIGH_ED) = ''     => 0.0028606248,
              ((real)c_high_ed < 15.9) => 0.05198558,
                                          0.0028606248));

s6_N119_5 :=  __common__( map(trim(C_INC_35K_P) = ''      => -0.012263526,
              ((real)c_inc_35k_p < 10.05) => s6_N119_6,
                                             -0.012263526));

s6_N119_4 :=  __common__( map(trim(C_FAMMAR_P) = ''     => s6_N119_5,
              ((real)c_fammar_p < 50.5) => 0.03134057,
                                           s6_N119_5));

s6_N119_3 :=  __common__( if(((integer)add2_avm_med < 396492), s6_N119_4, s6_N119_7));

s6_N119_2 :=  __common__( if(((real)c_rnt750_p < 50.15), -0.0033422764, s6_N119_3));

s6_N119_1 :=  __common__( if(trim(C_RNT750_P) != '', s6_N119_2, 0.0061478266));

s6_N120_9 :=  __common__( if(((real)add2_avm_to_med_ratio < 1.05364), -0.0041332638, 0.043125193));

s6_N120_8 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N120_9, 0.010783391));

s6_N120_7 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), 0.00023598626, s6_N120_8));

s6_N120_6 :=  __common__( if(((real)_addrs_last24 < 3.5), -0.028514614, -0.0017100265));

s6_N120_5 :=  __common__( if(((real)add1_nhood_vacant_properties < 9.5), 0.013153621, s6_N120_6));

s6_N120_4 :=  __common__( if(((real)c_hval_100k_p < 17.35), s6_N120_5, -0.025075832));

s6_N120_3 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N120_4, -0.026621413));

s6_N120_2 :=  __common__( if(((real)_inq_count < 1.5), 0.0093297463, s6_N120_3));

s6_N120_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N120_2, s6_N120_7));

s6_N121_8 :=  __common__( if(((real)_rel_educationunder12_count < 1.5), 0.0031806866, 0.024645519));

s6_N121_7 :=  __common__( if(((real)_addrs_last30 < 0.5), -0.0025907405, s6_N121_8));

s6_N121_6 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.046262996,
              ((real)c_hhsize < 2.865) => -0.0062121817,
                                          0.046262996));

s6_N121_5 :=  __common__( map(trim(C_HVAL_80K_P) = ''      => 0.02654229,
              ((real)c_hval_80k_p < 45.05) => -0.013692267,
                                              0.02654229));

s6_N121_4 :=  __common__( map(trim(C_ASSAULT) = ''      => s6_N121_6,
              ((real)c_assault < 182.5) => s6_N121_5,
                                           s6_N121_6));

s6_N121_3 :=  __common__( if(((real)c_highinc < 3.95), s6_N121_4, s6_N121_7));

s6_N121_2 :=  __common__( if(trim(C_HIGHINC) != '', s6_N121_3, -0.0086659233));

s6_N121_1 :=  __common__( if(((real)_nas < 1.5), s6_N121_2, 0.015091032));

s6_N122_9 :=  __common__( map(trim(C_MORT_INDX) = ''     => -0.0025698701,
              ((real)c_mort_indx < 85.5) => 0.033427543,
                                            -0.0025698701));

s6_N122_8 :=  __common__( if((combo_dobscore < 92), s6_N122_9, -0.0023210625));

s6_N122_7 :=  __common__( if(((real)input_dob_match_level < 2.5), -0.014605221, s6_N122_8));

s6_N122_6 :=  __common__( if(((real)c_rentocc_p < 4.65), 0.015499294, s6_N122_7));

s6_N122_5 :=  __common__( if(trim(C_RENTOCC_P) != '', s6_N122_6, -0.0096300789));

s6_N122_4 :=  __common__( if(((real)ssn_lowissue_age < 25.6763), s6_N122_5, -0.012831527));

s6_N122_3 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N122_4, 0.027263403));

s6_N122_2 :=  __common__( if((add2_avm_automated_valuation < 1.09075e+006), s6_N122_3, 0.03373506));

s6_N122_1 :=  __common__( if(((real)_nap < 5.5), s6_N122_2, 0.026624949));

s6_N123_8 :=  __common__( if(((real)_addrs_last30 < 1.5), -0.0069374538, 0.033135071));

s6_N123_7 :=  __common__( if(((real)ssn_lowissue_age < 2.14814), 0.049962364, s6_N123_8));

s6_N123_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N123_7, 0.012157424));

s6_N123_5 :=  __common__( if(((real)age < 56.5), s6_N123_6, 0.042414809));

s6_N123_4 :=  __common__( if((add1_unit_count < 168), -0.0017078868, 0.020591339));

s6_N123_3 :=  __common__( if(((real)_phone_score < 1.5), s6_N123_4, s6_N123_5));

s6_N123_2 :=  __common__( if(((real)combined_age < 82.5), s6_N123_3, 0.028473228));

s6_N123_1 :=  __common__( if(((real)_inq_count01 < 0.5), -0.0053996168, s6_N123_2));

s6_N124_9 :=  __common__( map(trim(C_FOR_SALE) = ''      => 0.065957805,
              ((real)c_for_sale < 145.5) => 0.0021085763,
                                            0.065957805));

s6_N124_8 :=  __common__( map(trim(C_LOW_HVAL) = ''     => 0.068720485,
              ((real)c_low_hval < 2.75) => s6_N124_9,
                                           0.068720485));

s6_N124_7 :=  __common__( map(trim(C_WHITE_COL) = ''      => s6_N124_8,
              ((real)c_white_col < 52.35) => 5.5636339e-005,
                                             s6_N124_8));

s6_N124_6 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.05469435, 0.010276256));

s6_N124_5 :=  __common__( map(trim(C_WHITE_COL) = ''      => s6_N124_7,
              ((real)c_white_col < 21.85) => s6_N124_6,
                                             s6_N124_7));

s6_N124_4 :=  __common__( if(((real)_inq_perssn < 1.5), 0.00041964529, s6_N124_5));

s6_N124_3 :=  __common__( if(((real)_inq_perphone < 0.5), s6_N124_4, -0.0067384668));

s6_N124_2 :=  __common__( if(((real)c_hval_20k_p < 35.7), s6_N124_3, 0.026627743));

s6_N124_1 :=  __common__( if(trim(C_HVAL_20K_P) != '', s6_N124_2, -0.013117944));

s6_N125_10 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), 0.076813857, 0.0037852957));

s6_N125_9 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '4']) => s6_N125_10,
              (prof_license_category in ['5'])                     => 0.35637757,
                                                                      s6_N125_10));

s6_N125_8 :=  __common__( map(trim(C_MURDERS) = ''     => 0.00023251888,
              ((real)c_murders < 84.5) => 0.033555681,
                                          0.00023251888));

s6_N125_7 :=  __common__( if(((real)rc_addrcount < 3.5), s6_N125_8, -0.0015240259));

s6_N125_6 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s6_N125_7, 0.0045161413));

s6_N125_5 :=  __common__( map(trim(C_ROBBERY) = ''      => s6_N125_6,
              ((integer)c_robbery < 72) => -0.0072170787,
                                           s6_N125_6));

s6_N125_4 :=  __common__( map(trim(C_INC_50K_P) = ''      => -0.026727313,
              ((real)c_inc_50k_p < 22.65) => s6_N125_5,
                                             -0.026727313));

s6_N125_3 :=  __common__( map(trim(C_INC_50K_P) = ''      => s6_N125_9,
              ((real)c_inc_50k_p < 24.95) => s6_N125_4,
                                             s6_N125_9));

s6_N125_2 :=  __common__( if(((real)c_ownocc_p < 12.15), -0.011814839, s6_N125_3));

s6_N125_1 :=  __common__( if(trim(C_OWNOCC_P) != '', s6_N125_2, 0.0099415417));

s6_N126_9 :=  __common__( map(trim(C_RENTOCC_P) = ''      => 0.029296461,
              ((real)c_rentocc_p < 60.75) => -0.0043483475,
                                             0.029296461));

s6_N126_8 :=  __common__( if(((real)age < 52.5), s6_N126_9, 0.057974721));

s6_N126_7 :=  __common__( map(trim(C_HIGH_ED) = ''      => 0.058782382,
              ((real)c_high_ed < 62.55) => 0.0046799235,
                                           0.058782382));

s6_N126_6 :=  __common__( if(((real)_rel_bankrupt_count < 3.5), s6_N126_7, 0.048920893));

s6_N126_5 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s6_N126_6, s6_N126_8));

s6_N126_4 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), 0.00028628389, s6_N126_5));

s6_N126_3 :=  __common__( if(((real)c_hhsize < 3.535), s6_N126_4, -0.0202666));

s6_N126_2 :=  __common__( if(trim(C_HHSIZE) != '', s6_N126_3, -0.026860549));

s6_N126_1 :=  __common__( if(((real)_inq_perphone < 0.5), s6_N126_2, -0.0073070893));

s6_N127_9 :=  __common__( map((prof_license_category in ['0', '1', '2', '4', '5']) => -0.020755418,
              (prof_license_category in ['3'])                     => 0.10601892,
                                                                      -0.020755418));

s6_N127_8 :=  __common__( if(((real)_addrs_last24 < 3.5), s6_N127_9, 0.0033586278));

s6_N127_7 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N127_8, 0.00054890291));

s6_N127_6 :=  __common__( if(((real)rc_addrcount < 1.5), 0.030506997, 0.012049337));

s6_N127_5 :=  __common__( map(trim(C_FOR_SALE) = ''       => -0.0050983494,
              ((integer)c_for_sale < 103) => 0.033470537,
                                             -0.0050983494));

s6_N127_4 :=  __common__( map(trim(C_RAPE) = ''      => s6_N127_5,
              ((integer)c_rape < 69) => -0.01575215,
                                        s6_N127_5));

s6_N127_3 :=  __common__( if(((real)rc_phoneaddr_addrcount < 0.5), s6_N127_4, s6_N127_6));

s6_N127_2 :=  __common__( if(((real)add1_lres < 1.5), s6_N127_3, s6_N127_7));

s6_N127_1 :=  __common__( if(trim(C_LOW_ED) != '', s6_N127_2, -0.011928128));

s6_N128_13 :=  __common__( map((prof_license_category in ['0', '2', '3', '4', '5']) => -0.023537532,
               (prof_license_category in ['1'])                     => 0.5,
                                                                       -0.023537532));

s6_N128_12 :=  __common__( if(((real)c_hval_1001k_p < 2.75), 0.00024086713, s6_N128_13));

s6_N128_11 :=  __common__( if(trim(C_HVAL_1001K_P) != '', s6_N128_12, 0.0098468404));

s6_N128_10 :=  __common__( map(trim(C_TOTSALES) = ''       => -0.0018602491,
               ((real)c_totsales < 4864.5) => 0.051658851,
                                              -0.0018602491));

s6_N128_9 :=  __common__( if(((integer)c_asian_lang < 167), -0.0039019631, s6_N128_10));

s6_N128_8 :=  __common__( if(trim(C_ASIAN_LANG) != '', s6_N128_9, -0.026446668));

s6_N128_7 :=  __common__( if((add1_lres < 214), s6_N128_8, 0.063773052));

s6_N128_6 :=  __common__( if(((real)c_inc_50k_p < 22.65), -0.0072035575, 0.04367231));

s6_N128_5 :=  __common__( if(trim(C_INC_50K_P) != '', s6_N128_6, -0.02565307));

s6_N128_4 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N128_5, -0.005935766));

s6_N128_3 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), s6_N128_4, s6_N128_7));

s6_N128_2 :=  __common__( if(((real)add2_avm_to_med_ratio < 2.21442), s6_N128_3, 0.045255471));

s6_N128_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N128_2, s6_N128_11));

s6_N129_8 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.0060331767,
              ((real)c_fammar_p < 69.65) => 0.049865856,
                                            -0.0060331767));

s6_N129_7 :=  __common__( if(((real)_num_purchase36 < 0.5), 0.0047249417, -0.0044568873));

s6_N129_6 :=  __common__( if((add1_avm_automated_valuation < 1.20136e+006), s6_N129_7, 0.046356407));

s6_N129_5 :=  __common__( map(trim(C_FEMDIV_P) = ''     => -0.018680706,
              ((real)c_femdiv_p < 9.55) => s6_N129_6,
                                           -0.018680706));

s6_N129_4 :=  __common__( map(trim(C_CARTHEFT) = ''      => 0.025448429,
              ((real)c_cartheft < 195.5) => s6_N129_5,
                                            0.025448429));

s6_N129_3 :=  __common__( if(((real)c_hval_100k_p < 50.7), s6_N129_4, s6_N129_8));

s6_N129_2 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N129_3, -0.010272188));

s6_N129_1 :=  __common__( if(((real)avg_lres < 5.5), 0.027652793, s6_N129_2));

s6_N130_10 :=  __common__( if(((real)c_child < 28.65), 0.019340604, -0.012447669));

s6_N130_9 :=  __common__( if(trim(C_CHILD) != '', s6_N130_10, 0.07972195));

s6_N130_8 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.065518699,
              ((real)c_hhsize < 2.985) => -8.5535918e-005,
                                          0.065518699));

s6_N130_7 :=  __common__( if(((real)_nap < 3.5), s6_N130_8, 0.040432375));

s6_N130_6 :=  __common__( map(trim(C_SFDU_P) = ''     => 0.029191288,
              ((real)c_sfdu_p < 90.9) => -0.010466893,
                                         0.029191288));

s6_N130_5 :=  __common__( if(((real)c_totsales < 8642.5), s6_N130_6, s6_N130_7));

s6_N130_4 :=  __common__( if(trim(C_TOTSALES) != '', s6_N130_5, -0.027581945));

s6_N130_3 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s6_N130_4, s6_N130_9));

s6_N130_2 :=  __common__( if(((real)add_bestmatch_level < 1.5), -0.0014792062, s6_N130_3));

s6_N130_1 :=  __common__( if(((real)_inq_perphone < 1.5), s6_N130_2, -0.01197989));

s6_N131_9 :=  __common__( if(((real)add2_lres < 26.5), -0.026786307, -0.0045473189));

s6_N131_8 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '4']) => s6_N131_9,
              (prof_license_category in ['5'])                     => 0.37643331,
                                                                      s6_N131_9));

s6_N131_7 :=  __common__( if(((real)rc_addrcount < 1.5), -0.026391992, -0.0065447152));

s6_N131_6 :=  __common__( if((add2_lres < 29), 0.040191295, 0.0049063905));

s6_N131_5 :=  __common__( if(((real)_add_risk < 0.5), 0.00083648726, s6_N131_6));

s6_N131_4 :=  __common__( if(((real)add2_nhood_vacant_properties < 87.5), s6_N131_5, s6_N131_7));

s6_N131_3 :=  __common__( map(trim(C_FAMMAR_P) = ''     => s6_N131_4,
              ((real)c_fammar_p < 34.8) => 0.019789706,
                                           s6_N131_4));

s6_N131_2 :=  __common__( if(((real)c_low_ed < 71.05), s6_N131_3, s6_N131_8));

s6_N131_1 :=  __common__( if(trim(C_LOW_ED) != '', s6_N131_2, -0.0070082213));

s6_N132_10 :=  __common__( if(((real)_adls_per_phone < 0.5), 0.0025189963, -0.0069923976));

s6_N132_9 :=  __common__( if(((real)c_low_ed < 80.05), s6_N132_10, 0.02729846));

s6_N132_8 :=  __common__( if(trim(C_LOW_ED) != '', s6_N132_9, -0.0023220223));

s6_N132_7 :=  __common__( map(trim(C_FAMMAR_P) = ''     => -0.017052156,
              ((real)c_fammar_p < 81.1) => 0.0052604754,
                                           -0.017052156));

s6_N132_6 :=  __common__( if(((real)c_unattach < 127.5), s6_N132_7, -0.028363334));

s6_N132_5 :=  __common__( if(trim(C_UNATTACH) != '', s6_N132_6, -0.026463079));

s6_N132_4 :=  __common__( if(((real)add2_naprop < 3.5), s6_N132_5, 0.014341276));

s6_N132_3 :=  __common__( if(((real)add1_avm_to_med_ratio < 1.07313), 0.001402828, -0.025507074));

s6_N132_2 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s6_N132_3, s6_N132_4));

s6_N132_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N132_2, s6_N132_8));

s6_N133_9 :=  __common__( map(trim(C_RAPE) = ''       => 0.048549072,
              ((integer)c_rape < 100) => -0.0045619163,
                                         0.048549072));

s6_N133_8 :=  __common__( if(((real)rc_fnamecount < 5.5), 0.022325223, 0.0022792943));

s6_N133_7 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 96.5), -0.0082325218, s6_N133_8));

s6_N133_6 :=  __common__( map(trim(C_URBAN_P) = ''      => s6_N133_7,
              ((real)c_urban_p < 89.65) => -0.010154361,
                                           s6_N133_7));

s6_N133_5 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s6_N133_6, -0.048138198));

s6_N133_4 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => s6_N133_5,
              ((real)c_fammar18_p < 10.35) => -0.019229995,
                                              s6_N133_5));

s6_N133_3 :=  __common__( if(((real)c_larceny < 198.5), s6_N133_4, 0.036597016));

s6_N133_2 :=  __common__( if(trim(C_LARCENY) != '', s6_N133_3, -0.026795869));

s6_N133_1 :=  __common__( if(((real)combined_age < 80.5), s6_N133_2, s6_N133_9));

s6_N134_8 :=  __common__( if(((real)_rel_homeunder50_count < 1.5), -0.0020759583, 0.066746469));

s6_N134_7 :=  __common__( if(((real)_rel_felony_total < 1.5), 0.0063241927, 0.035749476));

s6_N134_6 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), -0.0010101513, s6_N134_7));

s6_N134_5 :=  __common__( map(trim(C_BORN_USA) = ''    => s6_N134_6,
              ((real)c_born_usa < 3.5) => -0.016394246,
                                          s6_N134_6));

s6_N134_4 :=  __common__( if(((real)c_apt20 < 194.5), s6_N134_5, s6_N134_8));

s6_N134_3 :=  __common__( if(trim(C_APT20) != '', s6_N134_4, 0.015970301));

s6_N134_2 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => -0.01089138,
              (prof_license_category in ['2'])                     => 0.17716847,
                                                                      -0.01089138));

s6_N134_1 :=  __common__( if(((real)combined_age < 31.5), s6_N134_2, s6_N134_3));

s6_N135_11 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '4']) => 0.0045296178,
               (prof_license_category in ['5'])                     => 0.18527433,
                                                                       0.0045296178));

s6_N135_10 :=  __common__( map(trim(C_RETIRED2) = ''       => 0.053596038,
               ((integer)c_retired2 < 114) => s6_N135_11,
                                              0.053596038));

s6_N135_9 :=  __common__( if(((real)_rel_prop_owned_total < 2.5), 0.024444668, -0.0097273881));

s6_N135_8 :=  __common__( map(trim(C_OWNOCC_P) = ''      => s6_N135_9,
              ((real)c_ownocc_p < 86.85) => -0.0037268947,
                                            s6_N135_9));

s6_N135_7 :=  __common__( map(trim(C_INC_15K_P) = ''     => -0.0083744277,
              ((real)c_inc_15k_p < 4.65) => 0.011789138,
                                            -0.0083744277));

s6_N135_6 :=  __common__( if(((real)_rel_within25miles_count < 0.5), 0.039914968, s6_N135_7));

s6_N135_5 :=  __common__( if(((integer)add1_building_area2 < 881), 0.036495958, s6_N135_6));

s6_N135_4 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N135_5, -0.0031895833));

s6_N135_3 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N135_4, s6_N135_8));

s6_N135_2 :=  __common__( if(((real)c_hval_20k_p < 23.1), s6_N135_3, s6_N135_10));

s6_N135_1 :=  __common__( if(trim(C_HVAL_20K_P) != '', s6_N135_2, -0.026597506));

s6_N136_9 :=  __common__( if(((real)c_med_hval < 77655.5), 0.041500058, 0.007065858));

s6_N136_8 :=  __common__( if(trim(C_MED_HVAL) != '', s6_N136_9, -0.026022291));

s6_N136_7 :=  __common__( if(((real)add2_naprop < 0.5), -0.011763671, 0.031260914));

s6_N136_6 :=  __common__( if(((real)c_rnt500_p < 9.85), -0.013040146, s6_N136_7));

s6_N136_5 :=  __common__( if(trim(C_RNT500_P) != '', s6_N136_6, -0.026206223));

s6_N136_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N136_5, 0.04788113));

s6_N136_3 :=  __common__( if((avg_lres < 188), s6_N136_4, 0.069894059));

s6_N136_2 :=  __common__( if(((real)_inq_collection_count < 4.5), -0.0015956397, s6_N136_3));

s6_N136_1 :=  __common__( if(((real)add1_unit_count < 311.5), s6_N136_2, s6_N136_8));

s6_N137_9 :=  __common__( if(((real)_phones_per_adl_c6 < 0.5), -0.01983682, 0.02952872));

s6_N137_8 :=  __common__( if(((real)age < 52.5), 0.0092524207, 0.052131464));

s6_N137_7 :=  __common__( if(((real)input_dob_match_level < 4.5), 0.025181026, 0.0036689169));

s6_N137_6 :=  __common__( if(((real)add2_nhood_vacant_properties < 78.5), s6_N137_7, -0.011615129));

s6_N137_5 :=  __common__( map(trim(C_MED_HVAL) = ''        => s6_N137_6,
              ((real)c_med_hval < 41015.5) => 0.029637238,
                                              s6_N137_6));

s6_N137_4 :=  __common__( if(((real)_rel_felony_count < 0.5), s6_N137_5, s6_N137_8));

s6_N137_3 :=  __common__( if(((real)rc_addrcount < 3.5), s6_N137_4, -0.0034052778));

s6_N137_2 :=  __common__( if(((real)c_low_ed < 70.45), s6_N137_3, s6_N137_9));

s6_N137_1 :=  __common__( if(trim(C_LOW_ED) != '', s6_N137_2, 0.025300445));

s6_N138_10 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => -0.00065782591,
               (prof_license_category in ['2'])                     => 0.38996771,
                                                                       -0.00065782591));

s6_N138_9 :=  __common__( if(((real)_rel_educationunder12_count < 1.5), s6_N138_10, 0.034865894));

s6_N138_8 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '4']) => -0.030975961,
              (prof_license_category in ['5'])                     => 0.11292597,
                                                                      -0.030975961));

s6_N138_7 :=  __common__( map(trim(C_CIV_EMP) = ''      => -2.0150292e-005,
              ((real)c_civ_emp < 38.95) => s6_N138_8,
                                           -2.0150292e-005));

s6_N138_6 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), -0.0013642835, s6_N138_7));

s6_N138_5 :=  __common__( if(((integer)add2_avm_med < 240023), -0.013229786, 0.026029511));

s6_N138_4 :=  __common__( if(((real)add2_naprop < 3.5), s6_N138_5, 0.048041022));

s6_N138_3 :=  __common__( if(((real)_rel_within25miles_count < 0.5), s6_N138_4, s6_N138_6));

s6_N138_2 :=  __common__( if(((real)c_rentocc_p < 86.95), s6_N138_3, s6_N138_9));

s6_N138_1 :=  __common__( if(trim(C_RENTOCC_P) != '', s6_N138_2, -0.026567561));

s6_N139_9 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.054154873,
              ((integer)c_easiqlife < 90) => -0.010544094,
                                             0.054154873));

s6_N139_8 :=  __common__( if(((real)_inq_count < 3.5), s6_N139_9, -0.008143126));

s6_N139_7 :=  __common__( if(((real)age < 54.5), s6_N139_8, 0.039126258));

s6_N139_6 :=  __common__( if(((real)mth_gong_did_first_seen < 7.5), 0.052383423, 0.0027015861));

s6_N139_5 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s6_N139_6, 0.0035133472));

s6_N139_4 :=  __common__( if(((real)_phone_score < 1.5), s6_N139_5, s6_N139_7));

s6_N139_3 :=  __common__( if(((real)c_totsales < 85575.5), s6_N139_4, -0.013776811));

s6_N139_2 :=  __common__( if(trim(C_TOTSALES) != '', s6_N139_3, 0.061050793));

s6_N139_1 :=  __common__( if(((real)_inq_count01 < 0.5), -0.0033265699, s6_N139_2));

s6_N140_10 :=  __common__( if(((real)c_unemp < 2.55), -0.0084118203, 0.03983692));

s6_N140_9 :=  __common__( if(trim(C_UNEMP) != '', s6_N140_10, 0.080815136));

s6_N140_8 :=  __common__( if(((real)add2_lres < 49.5), 0.020910954, -0.010368515));

s6_N140_7 :=  __common__( if(((real)_inq_count01 < 1.5), s6_N140_8, 0.038894923));

s6_N140_6 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N140_7, 0.0046742871));

s6_N140_5 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => 0.056817264,
              ((real)c_fammar18_p < 50.25) => s6_N140_6,
                                              0.056817264));

s6_N140_4 :=  __common__( map(trim(C_TOTCRIME) = ''      => s6_N140_5,
              ((real)c_totcrime < 127.5) => -0.00093219537,
                                            s6_N140_5));

s6_N140_3 :=  __common__( if(((real)c_med_age < 19.5), -0.010824451, s6_N140_4));

s6_N140_2 :=  __common__( if(trim(C_MED_AGE) != '', s6_N140_3, -0.025897355));

s6_N140_1 :=  __common__( if(((real)_rel_felony_total < 2.5), s6_N140_2, s6_N140_9));

s6_N141_9 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.039890138, -0.01037686));

s6_N141_8 :=  __common__( map(trim(C_LOW_ED) = ''      => -0.023248676,
              ((real)c_low_ed < 72.95) => 0.0010440032,
                                          -0.023248676));

s6_N141_7 :=  __common__( map(trim(C_FOR_SALE) = ''      => -0.018552951,
              ((real)c_for_sale < 118.5) => 0.010929579,
                                            -0.018552951));

s6_N141_6 :=  __common__( map(trim(C_BORN_USA) = ''      => s6_N141_7,
              ((integer)c_born_usa < 75) => -0.024138886,
                                            s6_N141_7));

s6_N141_5 :=  __common__( map(trim(C_RNT750_P) = ''      => 0.019171579,
              ((real)c_rnt750_p < 23.75) => -0.012163264,
                                            0.019171579));

s6_N141_4 :=  __common__( map(trim(C_INC_25K_P) = ''     => s6_N141_6,
              ((real)c_inc_25k_p < 8.35) => s6_N141_5,
                                            s6_N141_6));

s6_N141_3 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N141_4, s6_N141_8));

s6_N141_2 :=  __common__( if(((real)c_hhsize < 4.04), s6_N141_3, s6_N141_9));

s6_N141_1 :=  __common__( if(trim(C_HHSIZE) != '', s6_N141_2, 0.026114005));

s6_N142_9 :=  __common__( map(trim(C_MED_AGE) = ''     => 0.06349051,
              ((real)c_med_age < 23.5) => 0.0021541263,
                                          0.06349051));

s6_N142_8 :=  __common__( map(trim(C_LAR_FAM) = ''      => s6_N142_9,
              ((real)c_lar_fam < 153.5) => 0.011775812,
                                           s6_N142_9));

s6_N142_7 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => -0.00058259262,
              ((real)c_asian_lang < 108.5) => s6_N142_8,
                                              -0.00058259262));

s6_N142_6 :=  __common__( if(((real)add2_lres < 46.5), s6_N142_7, -0.0029883246));

s6_N142_5 :=  __common__( if(((real)_rel_felony_total < 3.5), s6_N142_6, 0.031550627));

s6_N142_4 :=  __common__( map(trim(C_VACANT_P) = ''     => 0.0091754218,
              ((real)c_vacant_p < 3.65) => 0.065803364,
                                           0.0091754218));

s6_N142_3 :=  __common__( map(trim(C_BLUE_EMPL) = ''     => s6_N142_4,
              ((real)c_blue_empl < 29.5) => -0.0026506496,
                                            s6_N142_4));

s6_N142_2 :=  __common__( if(((real)c_sfdu_p < 2.45), s6_N142_3, s6_N142_5));

s6_N142_1 :=  __common__( if(trim(C_SFDU_P) != '', s6_N142_2, 0.010376638));

s6_N143_9 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), 0.094727415, 0.0043708098));

s6_N143_8 :=  __common__( if(((real)c_pop_25_34_p < 29.85), s6_N143_9, 0.053062916));

s6_N143_7 :=  __common__( if(trim(C_POP_25_34_P) != '', s6_N143_8, -0.025554676));

s6_N143_6 :=  __common__( map(trim(C_BIGAPT_P) = ''    => 0.019813838,
              ((real)c_bigapt_p < 9.8) => -0.0058802449,
                                          0.019813838));

s6_N143_5 :=  __common__( map(trim(C_LOWRENT) = ''      => 0.058262495,
              ((real)c_lowrent < 39.65) => s6_N143_6,
                                           0.058262495));

s6_N143_4 :=  __common__( if(((real)c_rnt750_p < 49.7), -0.0047193874, s6_N143_5));

s6_N143_3 :=  __common__( if(trim(C_RNT750_P) != '', s6_N143_4, 0.010917279));

s6_N143_2 :=  __common__( if(((real)input_dob_match_level < 2.5), -0.013749009, s6_N143_3));

s6_N143_1 :=  __common__( if(((real)_phone_score < 1.5), s6_N143_2, s6_N143_7));

s6_N144_9 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.026443106,
              ((real)c_sfdu_p < 71.55) => 0.096964828,
                                          0.026443106));

s6_N144_8 :=  __common__( if(((real)_addrs_15yr < 7.5), 0.056374817, -0.00047250596));

s6_N144_7 :=  __common__( if(((real)combo_hphonecount < 0.5), s6_N144_8, -0.015476837));

s6_N144_6 :=  __common__( if(((real)c_hval_750k_p < 0.35), s6_N144_7, s6_N144_9));

s6_N144_5 :=  __common__( if(trim(C_HVAL_750K_P) != '', s6_N144_6, -0.025672331));

s6_N144_4 :=  __common__( if(((real)c_young < 28.55), 0.0072144727, -0.011463433));

s6_N144_3 :=  __common__( if(trim(C_YOUNG) != '', s6_N144_4, 0.060403579));

s6_N144_2 :=  __common__( if(((real)add1_lres < 122.5), s6_N144_3, s6_N144_5));

s6_N144_1 :=  __common__( if(((real)_inq_collection_count < 1.5), -0.0028059225, s6_N144_2));

s6_N145_10 :=  __common__( if(((real)_inq_count01 < 1.5), -0.0064536326, 0.012513381));
s6_N145_9 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N145_10, -0.0021089934));
s6_N145_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N145_9, -0.030025646));
s6_N145_7 :=  __common__( if(((integer)add1_avm_med < 439400), 0.047062282, 0.0055725738));
s6_N145_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.016862794, 0.050559111));
s6_N145_5 :=  __common__( map(trim(C_RAPE) = ''     => s6_N145_6,
              ((real)c_rape < 58.5) => 0.029652034,
                                       s6_N145_6));
s6_N145_4 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => s6_N145_7,
              ((real)c_asian_lang < 162.5) => s6_N145_5,
                                              s6_N145_7));
s6_N145_3 :=  __common__( if(((real)_rel_within25miles_count < 0.5), s6_N145_4, s6_N145_8));
s6_N145_2 :=  __common__( if(((real)c_hval_80k_p < 59.35), s6_N145_3, 0.050585536));
s6_N145_1 :=  __common__( if(trim(C_HVAL_80K_P) != '', s6_N145_2, 0.0056937192));

s6_N146_11 :=  __common__( if(mth_did2_header_first_seen != null and ((real)mth_did2_header_first_seen > NULL), 0.080608064, 0.0046560606));
s6_N146_10 :=  __common__( if(((real)c_high_hval < 0.45), s6_N146_11, -0.010581115));
s6_N146_9 :=  __common__( if(trim(C_HIGH_HVAL) != '', s6_N146_10, -0.0019514839));
s6_N146_8 :=  __common__( if(((real)attr_num_nonderogs180 < 2.5), -0.020097736, s6_N146_9));
s6_N146_7 :=  __common__( if(((real)add2_mortgage_risky < 0.5), s6_N146_8, 0.037392752));
s6_N146_6 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => -0.017385981,
              (prof_license_category in ['2'])                     => 0.092632256,
                                                                      -0.017385981));
s6_N146_5 :=  __common__( if(((real)c_bigapt_p < 30.15), 0.00065752709, s6_N146_6));
s6_N146_4 :=  __common__( if(trim(C_BIGAPT_P) != '', s6_N146_5, -0.026393989));
s6_N146_3 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((real)mth_ver_src_fsrc_fdate < 214.5), 0.039331015, -0.00033278599));
s6_N146_2 :=  __common__( if(((real)add1_building_area2 < 836.5), s6_N146_3, s6_N146_4));
s6_N146_1 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N146_2, s6_N146_7));

s6_N147_9 :=  __common__( if(((real)c_incollege < 4.85), -0.00055803735, 0.032542659));

s6_N147_8 :=  __common__( if(trim(C_INCOLLEGE) != '', s6_N147_9, 0.068108767));

s6_N147_7 :=  __common__( map(trim(C_INC_201K_P) = ''    => 0.026685905,
              ((real)c_inc_201k_p < 0.6) => -0.021169979,
                                            0.026685905));

s6_N147_6 :=  __common__( map(trim(C_POP_25_34_P) = ''     => s6_N147_7,
              ((real)c_pop_25_34_p < 12.7) => 0.048363186,
                                              s6_N147_7));

s6_N147_5 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => 0.00028948795,
              ((real)c_fammar18_p < 10.35) => -0.019603474,
                                              0.00028948795));

s6_N147_4 :=  __common__( if(((real)c_hval_20k_p < 22.55), s6_N147_5, s6_N147_6));

s6_N147_3 :=  __common__( if(trim(C_HVAL_20K_P) != '', s6_N147_4, 0.011169924));

s6_N147_2 :=  __common__( if((combo_dobscore < 55), 0.01611774, s6_N147_3));

s6_N147_1 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s6_N147_2, s6_N147_8));

s6_N148_9 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.021737339,
              ((real)c_incollege < 3.35) => -0.022893864,
                                            0.021737339));

s6_N148_8 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => 0.048774219,
              ((real)c_fammar18_p < 44.65) => s6_N148_9,
                                              0.048774219));

s6_N148_7 :=  __common__( if(((real)add2_avm_automated_valuation < 34187.5), s6_N148_8, -0.011777905));

s6_N148_6 :=  __common__( if(((integer)add2_eda_sourced < 0.5), s6_N148_7, 0.02872933));

s6_N148_5 :=  __common__( if(((integer)add2_turnover_1yr_in < 568), s6_N148_6, -0.018054853));

s6_N148_4 :=  __common__( if(((real)_rel_felony_count < 0.5), s6_N148_5, 0.035417919));

s6_N148_3 :=  __common__( if(((real)combined_age < 63.5), -0.0027826117, s6_N148_4));

s6_N148_2 :=  __common__( if(((real)c_hval_80k_p < 57.3), s6_N148_3, 0.032903298));

s6_N148_1 :=  __common__( if(trim(C_HVAL_80K_P) != '', s6_N148_2, -0.0092502576));

s6_N149_9 :=  __common__( map(trim(C_HIGH_HVAL) = ''     => -0.0084679985,
              ((real)c_high_hval < 1.55) => 0.0012180824,
                                            -0.0084679985));

s6_N149_8 :=  __common__( map(trim(C_HVAL_1000K_P) = ''     => 0.034663707,
              ((real)c_hval_1000k_p < 18.9) => s6_N149_9,
                                               0.034663707));

s6_N149_7 :=  __common__( map(trim(C_LOW_ED) = ''      => -0.010118718,
              ((real)c_low_ed < 38.95) => 0.045197435,
                                          -0.010118718));

s6_N149_6 :=  __common__( if(((real)avg_lres < 25.5), 0.057503196, s6_N149_7));

s6_N149_5 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => -0.012706183,
              ((real)c_fammar18_p < 35.15) => s6_N149_6,
                                              -0.012706183));

s6_N149_4 :=  __common__( if(((real)_addrs_last90 < 2.5), s6_N149_5, 0.044755551));

s6_N149_3 :=  __common__( if(((real)add2_lres < 2.5), s6_N149_4, s6_N149_8));

s6_N149_2 :=  __common__( if(((real)c_inc_150k_p < 20.35), s6_N149_3, 0.055744702));

s6_N149_1 :=  __common__( if(trim(C_INC_150K_P) != '', s6_N149_2, -0.009753388));

s6_N150_9 :=  __common__( if(((real)c_no_move < 194.5), 0.0008445226, 0.053158087));

s6_N150_8 :=  __common__( if(trim(C_NO_MOVE) != '', s6_N150_9, 0.011831649));

s6_N150_7 :=  __common__( map(trim(C_MORT_INDX) = ''      => -0.030006651,
              ((integer)c_mort_indx < 37) => -0.0038378014,
                                             -0.030006651));

s6_N150_6 :=  __common__( map(trim(C_FAMMAR_P) = ''     => -0.010023245,
              ((real)c_fammar_p < 80.3) => -0.035396684,
                                           -0.010023245));

s6_N150_5 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), 0.018933952, s6_N150_6));

s6_N150_4 :=  __common__( map(trim(C_RENTAL) = ''       => 0.018244836,
              ((integer)c_rental < 126) => s6_N150_5,
                                           0.018244836));

s6_N150_3 :=  __common__( if(((real)c_young < 27.45), s6_N150_4, s6_N150_7));

s6_N150_2 :=  __common__( if(trim(C_YOUNG) != '', s6_N150_3, -0.026582835));

s6_N150_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N150_2, s6_N150_8));

s6_N151_9 :=  __common__( if(((real)rc_addrcount < 4.5), 0.060033212, -0.0060485857));

s6_N151_8 :=  __common__( map(trim(C_POP_25_34_P) = ''      => -0.0086048197,
              ((real)c_pop_25_34_p < 11.85) => 0.036611191,
                                               -0.0086048197));

s6_N151_7 :=  __common__( if(((real)ssn_lowissue_age < 24.0348), s6_N151_8, 0.037504888));

s6_N151_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N151_7, -0.10199099));

s6_N151_5 :=  __common__( if(((real)add2_naprop < 3.5), s6_N151_6, s6_N151_9));

s6_N151_4 :=  __common__( map(trim(C_LOWRENT) = ''     => 0.078008077,
              ((real)c_lowrent < 60.7) => 0.0041949381,
                                          0.078008077));

s6_N151_3 :=  __common__( if(((real)avg_lres < 269.5), -0.0015457712, s6_N151_4));

s6_N151_2 :=  __common__( if(((real)c_hval_100k_p < 32.65), s6_N151_3, s6_N151_5));

s6_N151_1 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N151_2, 0.0092022467));

s6_N152_9 :=  __common__( map(trim(C_RENTOCC_P) = ''      => 0.019274908,
              ((real)c_rentocc_p < 92.95) => -0.0020751319,
                                             0.019274908));

s6_N152_8 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), -9.146478e-005, s6_N152_9));

s6_N152_7 :=  __common__( if(((real)_ssncount < 1.5), -0.018563728, s6_N152_8));

s6_N152_6 :=  __common__( if(((integer)add1_avm_med < 150919), 0.029420686, -0.018819729));

s6_N152_5 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '5']) => s6_N152_6,
              (prof_license_category in ['4'])                     => 0.20712225,
                                                                      s6_N152_6));

s6_N152_4 :=  __common__( if(((real)_prop_owned_total < 1.5), s6_N152_5, 0.05703485));

s6_N152_3 :=  __common__( if(((real)c_retired2 < 7.5), s6_N152_4, s6_N152_7));

s6_N152_2 :=  __common__( if(trim(C_RETIRED2) != '', s6_N152_3, -0.02605132));

s6_N152_1 :=  __common__( if(((real)_nas < 2.5), s6_N152_2, 0.016083084));

s6_N153_7 :=  __common__( if(((real)add1_lres < 21.5), 0.001599041, 0.077994539));

s6_N153_6 :=  __common__( if(((real)_phone_score < 1.5), 0.00060520571, s6_N153_7));

s6_N153_5 :=  __common__( if(((real)combined_age < 36.5), s6_N153_6, 0.019905812));

s6_N153_4 :=  __common__( if(((real)add2_source_count < 2.5), -0.0016058645, s6_N153_5));

s6_N153_3 :=  __common__( if(((real)rc_addrcount < 3.5), s6_N153_4, -0.001484293));

s6_N153_2 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s6_N153_3, -0.0065095341));

s6_N153_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N153_2, 0.037960294));

s6_N154_8 :=  __common__( map(trim(C_APT20) = ''       => 0.041511545,
              ((integer)c_apt20 < 151) => 0.0008648161,
                                          0.041511545));

s6_N154_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), 0.0027608646, 0.038471468));

s6_N154_6 :=  __common__( map(trim(C_MED_HVAL) = ''         => s6_N154_7,
              ((integer)c_med_hval < 41750) => 0.027326447,
                                               s6_N154_7));

s6_N154_5 :=  __common__( map(trim(C_POP_18_24_P) = ''      => -0.012445646,
              ((real)c_pop_18_24_p < 12.75) => s6_N154_6,
                                               -0.012445646));

s6_N154_4 :=  __common__( if(((real)c_lar_fam < 112.5), -0.0055978261, s6_N154_5));

s6_N154_3 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N154_4, 0.01409984));

s6_N154_2 :=  __common__( if(((real)combined_age < 84.5), s6_N154_3, 0.016172134));

s6_N154_1 :=  __common__( if(((real)add2_mortgage_risky < 0.5), s6_N154_2, s6_N154_8));

s6_N155_10 :=  __common__( map(trim(C_INC_35K_P) = ''      => 0.03764832,
               ((real)c_inc_35k_p < 11.55) => 0.00045149756,
                                              0.03764832));

s6_N155_9 :=  __common__( if(((real)add2_source_count < 1.5), 0.012776331, -0.0030448704));

s6_N155_8 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.019756322,
              ((real)c_incollege < 4.35) => -0.013051835,
                                            0.019756322));

s6_N155_7 :=  __common__( map(trim(C_APT20) = ''       => -0.032521258,
              ((integer)c_apt20 < 124) => s6_N155_8,
                                          -0.032521258));

s6_N155_6 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N155_7, s6_N155_9));

s6_N155_5 :=  __common__( if(((real)add2_avm_to_med_ratio < 2.32438), -0.00064803616, 0.047949458));

s6_N155_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N155_5, s6_N155_6));

s6_N155_3 :=  __common__( if((combo_dobscore < 65), 0.012288398, s6_N155_4));

s6_N155_2 :=  __common__( if(((real)c_inc_15k_p < 38.75), s6_N155_3, s6_N155_10));

s6_N155_1 :=  __common__( if(trim(C_INC_15K_P) != '', s6_N155_2, -0.011673533));

s6_N156_10 :=  __common__( if(((real)add1_no_of_bedrooms2 > NULL), 0.10884095, -0.0068341076));

s6_N156_9 :=  __common__( if(((real)_inq_count06 < 2.5), -0.0076007699, 0.023345639));

s6_N156_8 :=  __common__( if(((integer)add2_eda_sourced < 0.5), s6_N156_9, 0.030626553));

s6_N156_7 :=  __common__( if(((real)age < 66.5), -0.0011218248, s6_N156_8));

s6_N156_6 :=  __common__( if(((real)ssn_lowissue_age < 43.8458), s6_N156_7, -0.025513948));

s6_N156_5 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N156_6, -0.0071668445));

s6_N156_4 :=  __common__( if(((real)_ssn_score < 1.5), s6_N156_5, 0.015793536));

s6_N156_3 :=  __common__( map(trim(C_HIGH_HVAL) = ''      => -0.017661992,
              ((real)c_high_hval < 11.35) => s6_N156_4,
                                             -0.017661992));

s6_N156_2 :=  __common__( if(((real)c_high_ed < 70.95), s6_N156_3, s6_N156_10));

s6_N156_1 :=  __common__( if(trim(C_HIGH_ED) != '', s6_N156_2, 0.013911114));

s6_N157_8 :=  __common__( if(((real)_rel_within25miles_count < 3.5), 0.0091547799, 0.054396033));

s6_N157_7 :=  __common__( if(((real)_num_purchase60 < 0.5), s6_N157_8, -0.020631012));

s6_N157_6 :=  __common__( map(trim(C_INC_50K_P) = ''      => -0.017612139,
              ((real)c_inc_50k_p < 23.05) => -0.0013846352,
                                             -0.017612139));

s6_N157_5 :=  __common__( if(((real)c_inc_150k_p < 20.45), s6_N157_6, 0.048010948));

s6_N157_4 :=  __common__( if(trim(C_INC_150K_P) != '', s6_N157_5, -0.0024813678));

s6_N157_3 :=  __common__( if(((integer)add2_avm_med < 922500), s6_N157_4, s6_N157_7));

s6_N157_2 :=  __common__( if(((real)_nap < 5.5), s6_N157_3, 0.021463886));

s6_N157_1 :=  __common__( if(((real)_rel_felony_count < 2.5), s6_N157_2, 0.024449112));

s6_N158_8 :=  __common__( if(((real)add1_no_of_baths2 > NULL), -0.0025049305, 0.0577037));

s6_N158_7 :=  __common__( if(((real)_rel_educationunder12_count < 1.5), s6_N158_8, 0.070586622));

s6_N158_6 :=  __common__( if(((real)_util_adl_nap < 3.5), -0.011180518, 0.053711756));

s6_N158_5 :=  __common__( if(((real)c_civ_emp < 62.85), s6_N158_6, s6_N158_7));

s6_N158_4 :=  __common__( if(trim(C_CIV_EMP) != '', s6_N158_5, 0.061893202));

s6_N158_3 :=  __common__( map((prof_license_category in ['0', '1', '4', '5']) => -0.0058405007,
              (prof_license_category in ['2', '3'])           => 0.16024883,
                                                                 -0.0058405007));

s6_N158_2 :=  __common__( if(((real)attr_num_nonderogs90 < 5.5), s6_N158_3, s6_N158_4));

s6_N158_1 :=  __common__( if(((real)_rel_criminal_count < 3.5), -0.0018335911, s6_N158_2));

s6_N159_10 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.012026119, -0.059254419));

s6_N159_9 :=  __common__( map(trim(C_HVAL_40K_P) = ''     => 0.040705508,
              ((real)c_hval_40k_p < 2.15) => -0.0098119382,
                                             0.040705508));

s6_N159_8 :=  __common__( if(((real)mth_gong_did_first_seen < 58.5), 0.024428954, -0.0054748072));

s6_N159_7 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s6_N159_8, s6_N159_9));

s6_N159_6 :=  __common__( if(((real)_crim_rel_within100miles < 0.5), s6_N159_7, 0.039164473));

s6_N159_5 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => s6_N159_6,
              (prof_license_category in ['2'])                     => 0.15284276,
                                                                      s6_N159_6));

s6_N159_4 :=  __common__( if(((real)age < 60.5), -0.0020264347, s6_N159_5));

s6_N159_3 :=  __common__( map(trim(C_NO_MOVE) = ''      => 0.031275961,
              ((real)c_no_move < 194.5) => s6_N159_4,
                                           0.031275961));

s6_N159_2 :=  __common__( if(((real)c_rnt750_p < 60.65), s6_N159_3, s6_N159_10));

s6_N159_1 :=  __common__( if(trim(C_RNT750_P) != '', s6_N159_2, 0.0034330119));

s6_N160_9 :=  __common__( map(trim(C_INC_150K_P) = ''    => 0.030827983,
              ((real)c_inc_150k_p < 7.3) => -0.017324021,
                                            0.030827983));

s6_N160_8 :=  __common__( map(trim(C_RETIRED2) = ''      => 0.042651599,
              ((real)c_retired2 < 126.5) => s6_N160_9,
                                            0.042651599));

s6_N160_7 :=  __common__( if((add1_unit_count < 47), s6_N160_8, 0.051089838));

s6_N160_6 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => 0.039258471,
              (prof_license_category in ['0'])                     => 0.44040847,
                                                                      0.039258471));

s6_N160_5 :=  __common__( if(((real)_phone_score < 1.5), -0.0016223345, 0.010686413));

s6_N160_4 :=  __common__( map(trim(C_HIGHINC) = ''      => s6_N160_6,
              ((real)c_highinc < 55.25) => s6_N160_5,
                                           s6_N160_6));

s6_N160_3 :=  __common__( if(((real)_add_risk < 0.5), s6_N160_4, s6_N160_7));

s6_N160_2 :=  __common__( if(((real)c_incollege < 3.65), -0.0064454787, s6_N160_3));

s6_N160_1 :=  __common__( if(trim(C_INCOLLEGE) != '', s6_N160_2, 0.0052934507));

s6_N161_11 :=  __common__( map(trim(C_BLUE_EMPL) = ''     => 0.044357431,
               ((real)c_blue_empl < 57.5) => -0.01177875,
                                             0.044357431));

s6_N161_10 :=  __common__( map(trim(C_FEMDIV_P) = ''     => -0.0025711921,
               ((real)c_femdiv_p < 1.75) => s6_N161_11,
                                            -0.0025711921));

s6_N161_9 :=  __common__( map(trim(C_EASIQLIFE) = ''     => -0.0042168169,
              ((real)c_easiqlife < 41.5) => 0.030355125,
                                            -0.0042168169));

s6_N161_8 :=  __common__( if(((real)ssn_lowissue_age < -0.454545), 0.044429133, s6_N161_9));

s6_N161_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N161_8, 0.010688136));

s6_N161_6 :=  __common__( map(trim(C_HVAL_40K_P) = ''      => -0.031577008,
              ((real)c_hval_40k_p < 32.45) => s6_N161_7,
                                              -0.031577008));

s6_N161_5 :=  __common__( if(((integer)add1_building_area2 < 702), 0.031797022, s6_N161_6));

s6_N161_4 :=  __common__( if(((real)_ssncount < 1.5), -0.020405017, s6_N161_5));

s6_N161_3 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N161_4, s6_N161_10));

s6_N161_2 :=  __common__( if(((real)c_low_ed < 80.25), s6_N161_3, 0.027705642));

s6_N161_1 :=  __common__( if(trim(C_LOW_ED) != '', s6_N161_2, 0.01390037));

s6_N162_9 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => -0.028962105,
              ((real)c_asian_lang < 108.5) => 0.030937081,
                                              -0.028962105));

s6_N162_8 :=  __common__( map(trim(C_UNATTACH) = ''       => 0.051461105,
              ((integer)c_unattach < 131) => s6_N162_9,
                                             0.051461105));

s6_N162_7 :=  __common__( if(((real)c_inc_35k_p < 13.25), -0.0053430239, s6_N162_8));

s6_N162_6 :=  __common__( if(trim(C_INC_35K_P) != '', s6_N162_7, -0.025578853));

s6_N162_5 :=  __common__( if(((real)c_rnt250_p < 1.25), 0.036730181, -0.0027397653));

s6_N162_4 :=  __common__( if(trim(C_RNT250_P) != '', s6_N162_5, -0.025974382));

s6_N162_3 :=  __common__( if(((real)add1_source_count < 2.5), s6_N162_4, s6_N162_6));

s6_N162_2 :=  __common__( if(((real)rc_dirsaddr_lastscore < 39.5), s6_N162_3, -0.0019181272));

s6_N162_1 :=  __common__( if(((real)_ssncount < 1.5), -0.012442346, s6_N162_2));

s6_N163_9 :=  __common__( map(trim(C_INC_25K_P) = ''     => -0.013250341,
              ((real)c_inc_25k_p < 11.8) => 0.04980583,
                                            -0.013250341));

s6_N163_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N163_9, 0.07062345));

s6_N163_7 :=  __common__( map(trim(C_MANY_CARS) = ''     => -0.00098077405,
              ((real)c_many_cars < 17.5) => s6_N163_8,
                                            -0.00098077405));

s6_N163_6 :=  __common__( if(((real)c_ownocc_p < 24.85), -0.011388766, s6_N163_7));

s6_N163_5 :=  __common__( if(trim(C_OWNOCC_P) != '', s6_N163_6, -0.0079339616));

s6_N163_4 :=  __common__( if(((real)add3_source_count < 2.5), 0.0051998068, 0.046093348));

s6_N163_3 :=  __common__( if(((real)c_born_usa < 33.5), s6_N163_4, 0.0016876199));

s6_N163_2 :=  __common__( if(trim(C_BORN_USA) != '', s6_N163_3, -0.025964787));

s6_N163_1 :=  __common__( if(((real)_rel_within25miles_count < 0.5), s6_N163_2, s6_N163_5));

s6_N164_9 :=  __common__( map(trim(C_POP_25_34_P) = ''     => -0.0020530323,
              ((real)c_pop_25_34_p < 18.4) => 0.048942059,
                                              -0.0020530323));

s6_N164_8 :=  __common__( map(trim(C_HIGHINC) = ''     => 0.0025891959,
              ((real)c_highinc < 4.35) => -0.006505681,
                                          0.0025891959));

s6_N164_7 :=  __common__( map(trim(C_RNT500_P) = ''      => 0.028335887,
              ((real)c_rnt500_p < 14.45) => -0.013932161,
                                            0.028335887));

s6_N164_6 :=  __common__( if(((integer)add3_avm_automated_valuation < 52585), s6_N164_7, 0.045443732));

s6_N164_5 :=  __common__( map(trim(C_UNATTACH) = ''     => s6_N164_6,
              ((real)c_unattach < 90.5) => -0.0086342731,
                                           s6_N164_6));

s6_N164_4 :=  __common__( if((combo_dobscore < 98), s6_N164_5, s6_N164_8));

s6_N164_3 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.029046685, s6_N164_4));

s6_N164_2 :=  __common__( if(((real)c_inc_50k_p < 24.75), s6_N164_3, s6_N164_9));

s6_N164_1 :=  __common__( if(trim(C_INC_50K_P) != '', s6_N164_2, -0.0053960211));

s6_N165_8 :=  __common__( map(trim(C_MANY_CARS) = ''      => 0.066763584,
              ((real)c_many_cars < 167.5) => 0.001376397,
                                             0.066763584));

s6_N165_7 :=  __common__( if(((real)add1_lres < 2.5), 0.027898438, s6_N165_8));

s6_N165_6 :=  __common__( if(((real)_rel_criminal_count < 4.5), s6_N165_7, 0.036443076));

s6_N165_5 :=  __common__( map(trim(C_CHILD) = ''      => s6_N165_6,
              ((real)c_child < 30.75) => -0.0011894598,
                                         s6_N165_6));

s6_N165_4 :=  __common__( map(trim(C_UNEMP) = ''     => -0.027645163,
              ((real)c_unemp < 7.85) => -0.0073657222,
                                        -0.027645163));

s6_N165_3 :=  __common__( if(((real)c_civ_emp < 39.15), s6_N165_4, s6_N165_5));

s6_N165_2 :=  __common__( if(trim(C_CIV_EMP) != '', s6_N165_3, -0.026555367));

s6_N165_1 :=  __common__( if(((real)_nas < 2.5), s6_N165_2, 0.017034236));

s6_N166_9 :=  __common__( if(((real)_bus_addr_match < 0.5), 0.064526949, 0.012916372));

s6_N166_8 :=  __common__( if(((real)_addrs_5yr < 4.5), 0.029900043, -0.010334997));

s6_N166_7 :=  __common__( if((add1_lres < 68), s6_N166_8, s6_N166_9));

s6_N166_6 :=  __common__( map(trim(C_RNT750_P) = ''      => 0.084719686,
              ((real)c_rnt750_p < 29.75) => 0.013215126,
                                            0.084719686));

s6_N166_5 :=  __common__( map(trim(C_ASSAULT) = ''      => -0.0037076346,
              ((real)c_assault < 136.5) => s6_N166_6,
                                           -0.0037076346));

s6_N166_4 :=  __common__( if(((real)ssn_lowissue_age < 36.0556), -0.00079071682, s6_N166_5));

s6_N166_3 :=  __common__( if(((real)_phone_score < 1.5), s6_N166_4, s6_N166_7));

s6_N166_2 :=  __common__( if(((real)ssn_lowissue_age < 15.9022), -0.0015691567, s6_N166_3));

s6_N166_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N166_2, 0.00041211687));

s6_N167_12 :=  __common__( if(((real)c_bigapt_p < 47.95), -0.0049976153, 0.02329127));

s6_N167_11 :=  __common__( if(trim(C_BIGAPT_P) != '', s6_N167_12, -0.026203701));

s6_N167_10 :=  __common__( if(((real)c_totsales < 9719.5), -0.0086029325, 0.017415142));

s6_N167_9 :=  __common__( if(trim(C_TOTSALES) != '', s6_N167_10, -0.025502725));

s6_N167_8 :=  __common__( if((combo_dobscore < 95), 0.031748578, s6_N167_9));

s6_N167_7 :=  __common__( if(((real)rc_dirsaddr_lastscore < 23.5), 0.03598091, s6_N167_8));

s6_N167_6 :=  __common__( if(((integer)add2_avm_med < 147980), -0.015365893, s6_N167_7));

s6_N167_5 :=  __common__( if(((real)_num_purchase60 < 1.5), s6_N167_6, -0.017280214));

s6_N167_4 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.044380142,
              ((real)c_low_ed < 42.65) => -0.014394085,
                                          0.044380142));

s6_N167_3 :=  __common__( if(((real)add1_building_area2 < 982.5), s6_N167_4, s6_N167_5));

s6_N167_2 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N167_3, s6_N167_11));

s6_N167_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N167_2, -0.00058540343));

s6_N168_9 :=  __common__( map(trim(C_ROBBERY) = ''      => -0.023408931,
              ((real)c_robbery < 178.5) => -0.0049423363,
                                           -0.023408931));

s6_N168_8 :=  __common__( if(((real)add3_lres < 32.5), 0.061722389, 0.0044480427));

s6_N168_7 :=  __common__( map(trim(C_RNT250_P) = ''    => -0.014901801,
              ((real)c_rnt250_p < 6.9) => 0.042026847,
                                          -0.014901801));

s6_N168_6 :=  __common__( if(((real)add2_turnover_1yr_in < 416.5), s6_N168_7, -0.0087586611));

s6_N168_5 :=  __common__( if(((real)_phone_risk < 0.5), -0.00072581179, s6_N168_6));

s6_N168_4 :=  __common__( map(trim(C_MIL_EMP) = ''     => s6_N168_8,
              ((real)c_mil_emp < 3.55) => s6_N168_5,
                                          s6_N168_8));

s6_N168_3 :=  __common__( map(trim(C_MED_HVAL) = ''        => s6_N168_4,
              ((real)c_med_hval < 30657.5) => 0.023463913,
                                              s6_N168_4));

s6_N168_2 :=  __common__( if(((real)c_bel_edu < 184.5), s6_N168_3, s6_N168_9));

s6_N168_1 :=  __common__( if(trim(C_BEL_EDU) != '', s6_N168_2, -0.026511256));

s6_N169_8 :=  __common__( if(((real)add1_lres < 35.5), 0.030437512, -0.02774104));

s6_N169_7 :=  __common__( map(trim(C_RAPE) = ''      => s6_N169_8,
              ((integer)c_rape < 69) => 0.06021135,
                                        s6_N169_8));

s6_N169_6 :=  __common__( if(((real)add3_naprop < 0.5), -0.000488831, s6_N169_7));

s6_N169_5 :=  __common__( map(trim(C_HHSIZE) = ''      => -0.017441643,
              ((real)c_hhsize < 3.105) => s6_N169_6,
                                          -0.017441643));

s6_N169_4 :=  __common__( if(((integer)c_med_rent < 349), 0.051173011, s6_N169_5));

s6_N169_3 :=  __common__( if(trim(C_MED_RENT) != '', s6_N169_4, -0.025576243));

s6_N169_2 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), 0.0023688076, s6_N169_3));

s6_N169_1 :=  __common__( if(((real)_inq_perphone < 0.5), s6_N169_2, -0.0054904494));

s6_N170_8 :=  __common__( if(((real)_rel_count_addr < 1.5), 0.0043501644, 0.056442985));

s6_N170_7 :=  __common__( if(((real)_phone_risk < 0.5), 0.0037357046, s6_N170_8));

s6_N170_6 :=  __common__( if(((real)_inq_collection_count < 4.5), 0.00062965287, 0.04263787));

s6_N170_5 :=  __common__( if(((real)c_pop_25_34_p < 7.25), 0.067909291, s6_N170_6));

s6_N170_4 :=  __common__( if(trim(C_POP_25_34_P) != '', s6_N170_5, -0.026018897));

s6_N170_3 :=  __common__( if(((real)_addrs_10yr < 4.5), s6_N170_4, -0.0057580747));

s6_N170_2 :=  __common__( if(((real)add_bestmatch_level < 1.5), s6_N170_3, s6_N170_7));

s6_N170_1 :=  __common__( if(((real)add3_lres < 348.5), s6_N170_2, -0.022188312));

s6_N171_7 :=  __common__( if(((real)_util_adl_count < 1.5), 0.021969064, -0.022977349));

s6_N171_6 :=  __common__( if(((real)add1_building_area2 > NULL), 0.074860356, 0.013975246));

s6_N171_5 :=  __common__( if(((real)rc_fnamecount < 9.5), s6_N171_6, 0.0054117365));

s6_N171_4 :=  __common__( map(trim(C_TOTSALES) = ''       => s6_N171_7,
              ((real)c_totsales < 4548.5) => s6_N171_5,
                                             s6_N171_7));

s6_N171_3 :=  __common__( if(((real)add3_lres < 134.5), -3.4539303e-005, s6_N171_4));

s6_N171_2 :=  __common__( if(((real)_inq_count01 < 1.5), -0.0028638846, s6_N171_3));

s6_N171_1 :=  __common__( if(((real)add1_nhood_vacant_properties < 714.5), s6_N171_2, 0.027614722));

s6_N172_8 :=  __common__( map(trim(C_MED_HVAL) = ''         => 0.0013911105,
              ((integer)c_med_hval < 80334) => -0.029624314,
                                               0.0013911105));

s6_N172_7 :=  __common__( map(trim(C_INC_15K_P) = ''     => 0.073380526,
              ((real)c_inc_15k_p < 6.05) => 0.0095802714,
                                            0.073380526));

s6_N172_6 :=  __common__( if((add2_lres < 70), -0.0097094445, 0.020266271));

s6_N172_5 :=  __common__( if((add1_avm_automated_valuation < 301763), s6_N172_6, s6_N172_7));

s6_N172_4 :=  __common__( map(trim(C_MED_INC) = ''     => s6_N172_5,
              ((real)c_med_inc < 41.5) => 0.035797017,
                                          s6_N172_5));

s6_N172_3 :=  __common__( if(((real)c_hhsize < 2.785), s6_N172_4, s6_N172_8));

s6_N172_2 :=  __common__( if(trim(C_HHSIZE) != '', s6_N172_3, -0.026280853));

s6_N172_1 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), -0.0020673649, s6_N172_2));

s6_N173_8 :=  __common__( map(trim(C_RNT750_P) = ''     => -0.0025704589,
              ((real)c_rnt750_p < 19.2) => 0.033818107,
                                           -0.0025704589));

s6_N173_7 :=  __common__( if(((real)_addrs_15yr < 4.5), 0.051867576, s6_N173_8));

s6_N173_6 :=  __common__( if(((real)combined_age < 50.5), 0.0053170903, s6_N173_7));

s6_N173_5 :=  __common__( if(((real)c_mort_indx < 56.5), -0.0046627776, s6_N173_6));

s6_N173_4 :=  __common__( if(trim(C_MORT_INDX) != '', s6_N173_5, -0.026730759));

s6_N173_3 :=  __common__( if(((real)rc_addrcount < 1.5), -0.013470007, -0.0040789247));

s6_N173_2 :=  __common__( if((combo_dobscore < 80), 0.015711141, s6_N173_3));

s6_N173_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), s6_N173_2, s6_N173_4));

s6_N174_10 :=  __common__( if(((real)c_murders < 179.5), -0.0080268717, -0.030684671));

s6_N174_9 :=  __common__( if(trim(C_MURDERS) != '', s6_N174_10, -0.025595311));

s6_N174_8 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.045980054, -0.0033487656));

s6_N174_7 :=  __common__( map(trim(C_BLUE_EMPL) = ''      => s6_N174_8,
              ((real)c_blue_empl < 125.5) => 0.0020512098,
                                             s6_N174_8));

s6_N174_6 :=  __common__( if(((real)_inq_perssn < 0.5), -0.00021471249, 0.071257129));

s6_N174_5 :=  __common__( if(((real)add1_nhood_vacant_properties < 0.5), s6_N174_6, s6_N174_7));

s6_N174_4 :=  __common__( if(((real)add1_lres < 39.5), -0.002862188, s6_N174_5));

s6_N174_3 :=  __common__( if(((real)_inq_collection_count < 1.5), -0.0022457915, s6_N174_4));

s6_N174_2 :=  __common__( if(((real)ssn_lowissue_age < 25.5353), s6_N174_3, s6_N174_9));

s6_N174_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N174_2, 0.017312128));

s6_N175_9 :=  __common__( if(((integer)add1_avm_med < 132247), 0.075931846, 0.0017670831));

s6_N175_8 :=  __common__( if((combo_dobscore < 92), 0.025368034, -0.0010673951));

s6_N175_7 :=  __common__( map(trim(C_HVAL_100K_P) = ''      => s6_N175_9,
              ((real)c_hval_100k_p < 25.75) => s6_N175_8,
                                               s6_N175_9));

s6_N175_6 :=  __common__( if((add2_lres < 99), 0.069215873, 0.017939025));

s6_N175_5 :=  __common__( if(((real)c_retired2 < 13.5), s6_N175_6, s6_N175_7));

s6_N175_4 :=  __common__( if(trim(C_RETIRED2) != '', s6_N175_5, -0.027523884));

s6_N175_3 :=  __common__( if(((real)c_high_ed < 1.95), 0.024751829, -0.0024044222));

s6_N175_2 :=  __common__( if(trim(C_HIGH_ED) != '', s6_N175_3, 0.037920475));

s6_N175_1 :=  __common__( if(((real)add2_naprop < 3.5), s6_N175_2, s6_N175_4));

s6_N176_9 :=  __common__( if(((real)add1_nhood_vacant_properties < 16.5), 0.063730592, 0.027723187));

s6_N176_8 :=  __common__( if(((real)rc_lnamecount < 8.5), s6_N176_9, -0.0075418934));

s6_N176_7 :=  __common__( if(((real)_lnames_per_adl < 1.5), -0.010828651, s6_N176_8));

s6_N176_6 :=  __common__( if((combo_dobscore < 98), 0.0337159, 0.0072868535));

s6_N176_5 :=  __common__( if(((real)_rel_prop_owned_total < 1.5), -0.0039610993, s6_N176_6));

s6_N176_4 :=  __common__( map(trim(C_BEL_EDU) = ''      => -0.029006027,
              ((real)c_bel_edu < 195.5) => s6_N176_5,
                                           -0.029006027));

s6_N176_3 :=  __common__( if(((real)add1_unit_count < 20.5), s6_N176_4, s6_N176_7));

s6_N176_2 :=  __common__( if(((real)c_ab_av_edu < 107.5), s6_N176_3, -0.0035125909));

s6_N176_1 :=  __common__( if(trim(C_AB_AV_EDU) != '', s6_N176_2, -0.026232275));

s6_N177_9 :=  __common__( if(((real)_inq_perphone < 0.5), -0.021616397, 0.020537526));

s6_N177_8 :=  __common__( map(trim(C_YOUNG) = ''      => -0.027872337,
              ((real)c_young < 28.85) => s6_N177_9,
                                         -0.027872337));

s6_N177_7 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), 0.15595202, 0.018518139));

s6_N177_6 :=  __common__( map(trim(C_MED_AGE) = ''     => 0.084387124,
              ((real)c_med_age < 41.5) => s6_N177_7,
                                          0.084387124));

s6_N177_5 :=  __common__( map(trim(C_VACANT_P) = ''     => s6_N177_6,
              ((real)c_vacant_p < 3.65) => -0.00027328119,
                                           s6_N177_6));

s6_N177_4 :=  __common__( map(trim(C_CHILD) = ''      => s6_N177_5,
              ((real)c_child < 30.85) => 0.0017503085,
                                         s6_N177_5));

s6_N177_3 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), -0.0037716056, s6_N177_4));

s6_N177_2 :=  __common__( if(((real)c_hhsize < 3.545), s6_N177_3, s6_N177_8));

s6_N177_1 :=  __common__( if(trim(C_HHSIZE) != '', s6_N177_2, 0.0040453182));

s6_N178_9 :=  __common__( if(((real)c_born_usa < 31.5), 0.05252983, -0.004255594));

s6_N178_8 :=  __common__( if(trim(C_BORN_USA) != '', s6_N178_9, 0.099677376));

s6_N178_7 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), 0.020696887, 0.11914044));

s6_N178_6 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.0069459166,
              ((real)c_hhsize < 2.695) => s6_N178_7,
                                          0.0069459166));

s6_N178_5 :=  __common__( map((prof_license_category in ['0', '4'])           => -0.056163944,
              (prof_license_category in ['1', '2', '3', '5']) => -0.0081855672,
                                                                 -0.0081855672));

s6_N178_4 :=  __common__( if((combo_dobscore < 80), s6_N178_5, -0.002243567));

s6_N178_3 :=  __common__( if(((real)c_ownocc_p < 93.45), s6_N178_4, s6_N178_6));

s6_N178_2 :=  __common__( if(trim(C_OWNOCC_P) != '', s6_N178_3, -0.00019516309));

s6_N178_1 :=  __common__( if((add1_unit_count < 598), s6_N178_2, s6_N178_8));

s6_N179_9 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => 0.00049323816,
              ((real)c_asian_lang < 152.5) => 0.086438257,
                                              0.00049323816));

s6_N179_8 :=  __common__( if(((real)_rel_bankrupt_count < 0.5), 0.00047270908, s6_N179_9));

s6_N179_7 :=  __common__( map(trim(C_MANY_CARS) = ''      => s6_N179_8,
              ((real)c_many_cars < 165.5) => -0.00061737753,
                                             s6_N179_8));

s6_N179_6 :=  __common__( map(trim(C_UNATTACH) = ''      => 0.0014727109,
              ((real)c_unattach < 108.5) => 0.037218404,
                                            0.0014727109));

s6_N179_5 :=  __common__( if(((real)add1_lres < 0.5), s6_N179_6, s6_N179_7));

s6_N179_4 :=  __common__( if(((real)rc_addrcount < 1.5), -0.02005589, -0.012923912));

s6_N179_3 :=  __common__( map(trim(C_BLUE_COL) = ''      => 0.03118014,
              ((real)c_blue_col < 28.15) => s6_N179_4,
                                            0.03118014));

s6_N179_2 :=  __common__( if(((real)c_urban_p < 89.55), s6_N179_3, s6_N179_5));

s6_N179_1 :=  __common__( if(trim(C_URBAN_P) != '', s6_N179_2, 0.0014341003));

s6_N180_10 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.00097936191, 0.050822933));

s6_N180_9 :=  __common__( if(((real)add2_lres < 61.5), s6_N180_10, -0.004542983));

s6_N180_8 :=  __common__( if(((integer)add2_avm_med < 660845), -0.0026296508, s6_N180_9));

s6_N180_7 :=  __common__( if(((real)c_many_cars < 188.5), s6_N180_8, 0.048025309));

s6_N180_6 :=  __common__( if(trim(C_MANY_CARS) != '', s6_N180_7, 0.034078034));

s6_N180_5 :=  __common__( if(((real)_adls_per_addr_c6 < 1.5), -0.0084332796, 0.020747098));

s6_N180_4 :=  __common__( if(((real)_rel_within25miles_count < 2.5), 0.030270599, s6_N180_5));

s6_N180_3 :=  __common__( if(((real)_inq_count01 < 1.5), -0.0058373184, s6_N180_4));

s6_N180_2 :=  __common__( if(((real)add2_avm_to_med_ratio < 0.448085), 0.035304948, s6_N180_3));

s6_N180_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N180_2, s6_N180_6));

s6_N181_8 :=  __common__( map(trim(C_CHILD) = ''     => 0.022695742,
              ((real)c_child < 35.8) => -0.0174236,
                                        0.022695742));

s6_N181_7 :=  __common__( map(trim(C_TOTCRIME) = ''     => s6_N181_8,
              ((real)c_totcrime < 66.5) => 0.03587499,
                                           s6_N181_8));

s6_N181_6 :=  __common__( map(trim(C_TOTSALES) = ''     => s6_N181_7,
              ((real)c_totsales < 90.5) => 0.040411653,
                                           s6_N181_7));

s6_N181_5 :=  __common__( map(trim(C_VACANT_P) = ''      => -0.010914404,
              ((real)c_vacant_p < 12.25) => 0.00076009905,
                                            -0.010914404));

s6_N181_4 :=  __common__( map(trim(C_HHSIZE) = ''      => -0.022976189,
              ((real)c_hhsize < 3.525) => s6_N181_5,
                                          -0.022976189));

s6_N181_3 :=  __common__( if(((real)c_lar_fam < 173.5), s6_N181_4, s6_N181_6));

s6_N181_2 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N181_3, 0.0046843701));

s6_N181_1 :=  __common__( if(((real)_ssn_score < 1.5), s6_N181_2, 0.018190723));

s6_N182_10 :=  __common__( if(((integer)c_sfdu_p < 35), 0.05066431, 0.010347254));

s6_N182_9 :=  __common__( if(trim(C_SFDU_P) != '', s6_N182_10, -0.026760135));

s6_N182_8 :=  __common__( if(((real)c_hval_100k_p < 26.5), -0.0027974252, 0.023390027));

s6_N182_7 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N182_8, -0.025539994));

s6_N182_6 :=  __common__( if(((real)_addrs_last30 < 1.5), s6_N182_7, s6_N182_9));

s6_N182_5 :=  __common__( if(((real)add2_avm_to_med_ratio < 0.455233), 0.063091661, s6_N182_6));

s6_N182_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N182_5, 0.0012433503));

s6_N182_3 :=  __common__( if(((real)_paw_business_match < 0.5), s6_N182_4, -0.0043809302));

s6_N182_2 :=  __common__( if(((real)_ssncount < 1.5), -0.020440097, s6_N182_3));

s6_N182_1 :=  __common__( if(((real)_ssncount < 0.5), 0.013838385, s6_N182_2));

s6_N183_9 :=  __common__( if(((real)c_lowinc < 74.5), -0.00071893852, 0.023992265));

s6_N183_8 :=  __common__( if(trim(C_LOWINC) != '', s6_N183_9, 0.0083903599));

s6_N183_7 :=  __common__( if(((real)add2_nhood_vacant_properties < 25.5), 0.0038080897, -0.026398743));

s6_N183_6 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N183_7, -0.0017807648));

s6_N183_5 :=  __common__( map(trim(C_ASIAN_LANG) = ''       => -0.0082560905,
              ((integer)c_asian_lang < 147) => 0.031439849,
                                               -0.0082560905));

s6_N183_4 :=  __common__( if(((real)add1_building_area2 < 855.5), s6_N183_5, s6_N183_6));

s6_N183_3 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N183_4, s6_N183_8));

s6_N183_2 :=  __common__( if((add1_avm_automated_valuation < 1.20136e+006), s6_N183_3, 0.04120636));

s6_N183_1 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.034710604, s6_N183_2));

s6_N184_10 :=  __common__( map(trim(C_MED_INC) = ''     => -0.0010203399,
               ((real)c_med_inc < 66.5) => 0.034334866,
                                           -0.0010203399));

s6_N184_9 :=  __common__( if(((real)add2_avm_to_med_ratio < 1.0794), -0.0084526669, 0.041395811));

s6_N184_8 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N184_9, s6_N184_10));

s6_N184_7 :=  __common__( if(((real)_inq_count03_cap3 < 1.5), 0.0040454411, 0.062005882));

s6_N184_6 :=  __common__( map(trim(C_NO_MOVE) = ''      => s6_N184_7,
              ((real)c_no_move < 184.5) => 0.00031572786,
                                           s6_N184_7));

s6_N184_5 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), s6_N184_6, s6_N184_8));

s6_N184_4 :=  __common__( if(((real)_nap < 5.5), s6_N184_5, 0.028407052));

s6_N184_3 :=  __common__( if(((integer)add2_avm_med < 134682), -0.0056273368, s6_N184_4));

s6_N184_2 :=  __common__( if(((real)c_sfdu_p < 0.85), -0.017043236, s6_N184_3));

s6_N184_1 :=  __common__( if(trim(C_SFDU_P) != '', s6_N184_2, -0.012258574));

s6_N185_11 :=  __common__( map(trim(C_RNT750_P) = ''      => 0.019466877,
               ((real)c_rnt750_p < 47.95) => 0.00033325507,
                                             0.019466877));

s6_N185_10 :=  __common__( if((add1_avm_automated_valuation < 350475), 0.08753592, 0.0075535372));

s6_N185_9 :=  __common__( map(trim(C_ASSAULT) = ''     => -0.0034215794,
              ((real)c_assault < 60.5) => s6_N185_10,
                                          -0.0034215794));

s6_N185_8 :=  __common__( if(((real)add1_building_area2 < 2564.5), -0.0036608202, s6_N185_9));

s6_N185_7 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N185_8, -0.029529129));

s6_N185_6 :=  __common__( if(((real)add1_no_of_bedrooms2 > NULL), s6_N185_7, s6_N185_11));

s6_N185_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s6_N185_6, 0.024335139));

s6_N185_4 :=  __common__( if(((real)_ssncount < 1.5), -0.017750354, -0.0020093291));

s6_N185_3 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), s6_N185_4, s6_N185_5));

s6_N185_2 :=  __common__( if(((real)c_bel_edu < 196.5), s6_N185_3, -0.026709007));

s6_N185_1 :=  __common__( if(trim(C_BEL_EDU) != '', s6_N185_2, -0.0085707932));

s6_N186_10 :=  __common__( map(trim(C_FAMMAR18_P) = ''     => 0.041479531,
               ((real)c_fammar18_p < 61.5) => -0.003064574,
                                              0.041479531));

s6_N186_9 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => 0.045673302,
              (prof_license_category in ['0'])                     => 0.1518061,
                                                                      0.045673302));

s6_N186_8 :=  __common__( map(trim(C_EASIQLIFE) = ''     => s6_N186_10,
              ((real)c_easiqlife < 72.5) => s6_N186_9,
                                            s6_N186_10));

s6_N186_7 :=  __common__( map(trim(C_HVAL_60K_P) = ''    => 0.041494366,
              ((real)c_hval_60k_p < 6.6) => s6_N186_8,
                                            0.041494366));

s6_N186_6 :=  __common__( if(((real)add1_no_of_baths2 > NULL), 0.034181591, -0.0048216388));

s6_N186_5 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s6_N186_6, 0.022328621));

s6_N186_4 :=  __common__( if((combo_dobscore < 95), s6_N186_5, 0.0011111313));

s6_N186_3 :=  __common__( if(((real)add2_nhood_vacant_properties < 40.5), s6_N186_4, -0.00810683));

s6_N186_2 :=  __common__( if(((real)c_civ_emp < 75.05), s6_N186_3, s6_N186_7));

s6_N186_1 :=  __common__( if(trim(C_CIV_EMP) != '', s6_N186_2, -0.026313708));

s6_N187_9 :=  __common__( map(trim(C_CHILD) = ''      => 0.033257728,
              ((real)c_child < 30.95) => 0.00082113277,
                                         0.033257728));

s6_N187_8 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), -0.00068893427, s6_N187_9));

s6_N187_7 :=  __common__( if(((real)_rel_educationunder8_count < 0.5), 0.017994508, s6_N187_8));

s6_N187_6 :=  __common__( map(trim(C_UNATTACH) = ''     => -0.014979186,
              ((real)c_unattach < 68.5) => 0.019449203,
                                           -0.014979186));

s6_N187_5 :=  __common__( if(((real)add1_source_count < 2.5), s6_N187_6, 0.0020867494));

s6_N187_4 :=  __common__( if(((real)combined_age < 45.5), s6_N187_5, s6_N187_7));

s6_N187_3 :=  __common__( if(((real)c_hval_1001k_p < 0.85), s6_N187_4, -0.010262714));

s6_N187_2 :=  __common__( if(trim(C_HVAL_1001K_P) != '', s6_N187_3, 0.020852323));

s6_N187_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s6_N187_2, 0.014494944));

s6_N188_10 :=  __common__( if(((real)_nap < 3.5), -0.004928977, 0.014120642));

s6_N188_9 :=  __common__( if((combo_dobscore < 92), -0.01866309, s6_N188_10));

s6_N188_8 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s6_N188_9, -0.0023766078));

s6_N188_7 :=  __common__( if(((real)c_span_lang < 192.5), s6_N188_8, 0.019302927));

s6_N188_6 :=  __common__( if(trim(C_SPAN_LANG) != '', s6_N188_7, 0.00073604307));

s6_N188_5 :=  __common__( if(((real)_addr_stability_v2 < 4.5), 0.040941148, -0.0016785199));

s6_N188_4 :=  __common__( if(((real)_add_risk < 0.5), -0.00058805342, s6_N188_5));

s6_N188_3 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N188_4, s6_N188_6));

s6_N188_2 :=  __common__( if((add2_avm_automated_valuation < 988944), s6_N188_3, 0.024070305));

s6_N188_1 :=  __common__( if(((real)add1_lres < 424.5), s6_N188_2, 0.031360388));

s6_N189_8 :=  __common__( map(trim(C_RELIG_INDX) = ''       => 0.025717913,
              ((integer)c_relig_indx < 121) => -0.0024353802,
                                               0.025717913));

s6_N189_7 :=  __common__( map(trim(C_HVAL_80K_P) = ''     => -0.0016020611,
              ((real)c_hval_80k_p < 2.65) => 0.031368798,
                                             -0.0016020611));

s6_N189_6 :=  __common__( if(((real)add2_nhood_vacant_properties < 62.5), 6.5017418e-005, 0.022182756));

s6_N189_5 :=  __common__( if(((real)add2_nhood_vacant_properties < 88.5), s6_N189_6, -0.0094299084));

s6_N189_4 :=  __common__( map(trim(C_HVAL_20K_P) = ''      => s6_N189_7,
              ((real)c_hval_20k_p < 23.15) => s6_N189_5,
                                              s6_N189_7));

s6_N189_3 :=  __common__( if(((real)c_femdiv_p < 9.55), s6_N189_4, -0.018033885));

s6_N189_2 :=  __common__( if(trim(C_FEMDIV_P) != '', s6_N189_3, 0.012110954));

s6_N189_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s6_N189_2, s6_N189_8));

s6_N190_9 :=  __common__( map(trim(C_SPAN_LANG) = ''       => 0.044968251,
              ((integer)c_span_lang < 117) => -0.0033533321,
                                              0.044968251));

s6_N190_8 :=  __common__( if(((real)_rel_criminal_total < 1.5), s6_N190_9, -0.016712283));

s6_N190_7 :=  __common__( map(trim(C_RAPE) = ''     => s6_N190_8,
              ((real)c_rape < 56.5) => -0.026893352,
                                       s6_N190_8));

s6_N190_6 :=  __common__( if((add1_unit_count < 50), s6_N190_7, 0.035380426));

s6_N190_5 :=  __common__( if(((real)add2_lres < 5.5), 0.046379006, s6_N190_6));

s6_N190_4 :=  __common__( if((combo_dobscore < 92), -0.022996466, -0.0055825788));

s6_N190_3 :=  __common__( if(((real)_ssncount < 2.5), s6_N190_4, 0.0013231228));

s6_N190_2 :=  __common__( if(((real)_add_risk < 0.5), s6_N190_3, s6_N190_5));

s6_N190_1 :=  __common__( if(trim(C_HHSIZE) != '', s6_N190_2, 0.0097856094));

s6_N191_10 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.030827674,
               ((real)c_hhsize < 3.295) => 0.00035826943,
                                           0.030827674));

s6_N191_9 :=  __common__( if(((real)_addrs_last30 < 0.5), -0.0008334891, 0.02339697));

s6_N191_8 :=  __common__( map(trim(C_TOTSALES) = ''          => -0.029212642,
              ((integer)c_totsales < 158202) => s6_N191_9,
                                                -0.029212642));

s6_N191_7 :=  __common__( if(((real)_util_adl_count < 1.5), 0.081810882, -0.0054144066));

s6_N191_6 :=  __common__( map(trim(C_ASSAULT) = ''     => s6_N191_8,
              ((real)c_assault < 25.5) => s6_N191_7,
                                          s6_N191_8));

s6_N191_5 :=  __common__( if(((integer)add1_building_area2 < 1373), -0.011773127, s6_N191_6));

s6_N191_4 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N191_5, s6_N191_10));

s6_N191_3 :=  __common__( map(trim(C_HVAL_80K_P) = ''      => 0.040083298,
              ((real)c_hval_80k_p < 48.35) => s6_N191_4,
                                              0.040083298));

s6_N191_2 :=  __common__( if(((real)c_bigapt_p < 2.65), -0.006500915, s6_N191_3));

s6_N191_1 :=  __common__( if(trim(C_BIGAPT_P) != '', s6_N191_2, 0.025448019));

s6_N192_10 :=  __common__( map(trim(C_HVAL_100K_P) = ''     => -0.0016601354,
               ((real)c_hval_100k_p < 7.35) => 0.034741441,
                                               -0.0016601354));

s6_N192_9 :=  __common__( map((prof_license_category in ['1', '2', '3', '4']) => s6_N192_10,
              (prof_license_category in ['0', '5'])           => 0.066662386,
                                                                 s6_N192_10));

s6_N192_8 :=  __common__( map(trim(C_LOW_ED) = ''      => s6_N192_9,
              ((real)c_low_ed < 66.35) => 0.00045150935,
                                          s6_N192_9));

s6_N192_7 :=  __common__( map(trim(C_WHITE_COL) = ''      => 0.040551388,
              ((real)c_white_col < 40.35) => -0.0021222669,
                                             0.040551388));

s6_N192_6 :=  __common__( map(trim(C_HVAL_750K_P) = ''     => -0.017403392,
              ((real)c_hval_750k_p < 1.95) => s6_N192_7,
                                              -0.017403392));

s6_N192_5 :=  __common__( if(((real)_rel_count_addr < 0.5), s6_N192_6, -0.0037121239));

s6_N192_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N192_5, s6_N192_8));

s6_N192_3 :=  __common__( map(trim(C_LOW_ED) = ''      => -0.016785543,
              ((real)c_low_ed < 71.15) => s6_N192_4,
                                          -0.016785543));

s6_N192_2 :=  __common__( if(((real)c_low_ed < 80.05), s6_N192_3, 0.024471225));

s6_N192_1 :=  __common__( if(trim(C_LOW_ED) != '', s6_N192_2, -0.0016902183));

s6_N193_9 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.010706839, 0.047914495));

s6_N193_8 :=  __common__( map(trim(C_OWNOCC_P) = ''      => 0.01290222,
              ((real)c_ownocc_p < 35.65) => 0.031203555,
                                            0.01290222));

s6_N193_7 :=  __common__( map(trim(C_BEL_EDU) = ''      => s6_N193_9,
              ((real)c_bel_edu < 167.5) => s6_N193_8,
                                           s6_N193_9));

s6_N193_6 :=  __common__( map(trim(C_HIGH_ED) = ''      => 0.00010323824,
              ((real)c_high_ed < 17.15) => s6_N193_7,
                                           0.00010323824));

s6_N193_5 :=  __common__( map(trim(C_AB_AV_EDU) = ''     => s6_N193_6,
              ((real)c_ab_av_edu < 31.5) => -0.012023908,
                                            s6_N193_6));

s6_N193_4 :=  __common__( map(trim(C_LOW_HVAL) = ''     => 0.024316575,
              ((real)c_low_hval < 76.7) => s6_N193_5,
                                           0.024316575));

s6_N193_3 :=  __common__( map(trim(C_LOW_ED) = ''      => -0.01199644,
              ((real)c_low_ed < 71.15) => s6_N193_4,
                                          -0.01199644));

s6_N193_2 :=  __common__( if(((real)c_lar_fam < 46.5), -0.012904267, s6_N193_3));

s6_N193_1 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N193_2, 0.010223889));

s6_N194_9 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => 0.0055120937,
              (prof_license_category in ['2'])                     => 0.15272693,
                                                                      0.0055120937));

s6_N194_8 :=  __common__( map(trim(C_BIGAPT_P) = ''     => s6_N194_9,
              ((real)c_bigapt_p < 4.75) => -0.0029829164,
                                           s6_N194_9));

s6_N194_7 :=  __common__( if(((real)c_med_hhinc < 18286.5), -0.022313156, s6_N194_8));

s6_N194_6 :=  __common__( if(trim(C_MED_HHINC) != '', s6_N194_7, 0.0084425139));

s6_N194_5 :=  __common__( map(trim(C_MED_AGE) = ''     => -0.020316939,
              ((real)c_med_age < 47.5) => 0.0045497947,
                                          -0.020316939));

s6_N194_4 :=  __common__( if(((real)c_hval_60k_p < 0.15), s6_N194_5, 0.011838703));

s6_N194_3 :=  __common__( if(trim(C_HVAL_60K_P) != '', s6_N194_4, -0.026076922));

s6_N194_2 :=  __common__( if(((integer)add2_avm_med < 130442), -0.024212427, s6_N194_3));

s6_N194_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N194_2, s6_N194_6));

s6_N195_8 :=  __common__( if(((real)add1_nhood_vacant_properties < 73.5), -0.0016200457, 0.039119323));

s6_N195_7 :=  __common__( map(trim(C_BLUE_EMPL) = ''      => 0.062024931,
              ((real)c_blue_empl < 164.5) => s6_N195_8,
                                             0.062024931));

s6_N195_6 :=  __common__( if(((integer)add2_avm_med < 101579), 0.017410823, -0.00081511007));

s6_N195_5 :=  __common__( if(((real)_rel_criminal_count < 3.5), s6_N195_6, s6_N195_7));

s6_N195_4 :=  __common__( map(trim(C_LOWINC) = ''      => -0.014573322,
              ((real)c_lowinc < 58.35) => s6_N195_5,
                                          -0.014573322));

s6_N195_3 :=  __common__( if(((real)c_high_ed < 69.65), s6_N195_4, 0.050281844));

s6_N195_2 :=  __common__( if(trim(C_HIGH_ED) != '', s6_N195_3, -0.0049268599));

s6_N195_1 :=  __common__( if(((real)add1_lres < 53.5), -0.0045565437, s6_N195_2));

s6_N196_10 :=  __common__( map(trim(C_YOUNG) = ''      => 0.04386407,
               ((real)c_young < 27.55) => 0.0033190057,
                                          0.04386407));

s6_N196_9 :=  __common__( if(((real)combined_age < 34.5), -0.010589198, s6_N196_10));

s6_N196_8 :=  __common__( if(((real)gong_did_addr_ct < 0.5), -0.0039370957, 0.041924102));

s6_N196_7 :=  __common__( map(trim(C_RNT250_P) = ''      => 0.037430925,
              ((real)c_rnt250_p < 17.75) => -0.0083761227,
                                            0.037430925));

s6_N196_6 :=  __common__( if(((real)add1_unit_count < 5.5), s6_N196_7, s6_N196_8));

s6_N196_5 :=  __common__( if(((integer)add2_eda_sourced < 0.5), -0.00355296, s6_N196_6));

s6_N196_4 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), 0.00066862524, s6_N196_5));

s6_N196_3 :=  __common__( map(trim(C_APT20) = ''      => s6_N196_9,
              ((real)c_apt20 < 193.5) => s6_N196_4,
                                         s6_N196_9));

s6_N196_2 :=  __common__( if(((integer)c_med_rent < 1272), s6_N196_3, -0.014600679));

s6_N196_1 :=  __common__( if(trim(C_MED_RENT) != '', s6_N196_2, -0.026779233));

s6_N197_9 :=  __common__( map((prof_license_category in ['0', '1', '3']) => -0.011697611,
              (prof_license_category in ['2', '4', '5']) => 0.033889445,
                                                            -0.011697611));

s6_N197_8 :=  __common__( if(((real)_phone_risk < 0.5), 0.0055016777, 0.030982314));

s6_N197_7 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => -0.0041849568,
              (prof_license_category in ['0'])                     => 0.18341579,
                                                                      -0.0041849568));

s6_N197_6 :=  __common__( map(trim(C_MED_INC) = ''      => s6_N197_7,
              ((real)c_med_inc < 196.5) => 0.062694825,
                                           s6_N197_7));

s6_N197_5 :=  __common__( map(trim(C_MED_HHINC) = ''          => s6_N197_6,
              ((integer)c_med_hhinc < 116647) => -0.0036749549,
                                                 s6_N197_6));

s6_N197_4 :=  __common__( map(trim(C_INCOLLEGE) = ''     => s6_N197_8,
              ((real)c_incollege < 6.15) => s6_N197_5,
                                            s6_N197_8));

s6_N197_3 :=  __common__( map(trim(C_RECENT_MOV) = ''      => s6_N197_9,
              ((real)c_recent_mov < 177.5) => s6_N197_4,
                                              s6_N197_9));

s6_N197_2 :=  __common__( if(((real)c_hval_80k_p < 56.8), s6_N197_3, 0.029073857));

s6_N197_1 :=  __common__( if(trim(C_HVAL_80K_P) != '', s6_N197_2, 0.00069035625));

s6_N198_9 :=  __common__( map(trim(C_TOTSALES) = ''        => 0.013852651,
              ((integer)c_totsales < 2094) => 0.056046574,
                                              0.013852651));

s6_N198_8 :=  __common__( if(((real)add2_turnover_1yr_in < 280.5), -0.0075846658, s6_N198_9));

s6_N198_7 :=  __common__( if(((real)add2_turnover_1yr_in < 258.5), 0.0049757966, -0.0075310786));

s6_N198_6 :=  __common__( map(trim(C_MED_AGE) = ''     => s6_N198_7,
              ((real)c_med_age < 12.5) => -0.024430441,
                                          s6_N198_7));

s6_N198_5 :=  __common__( if(((real)add2_avm_to_med_ratio < 0.446534), 0.032289776, s6_N198_6));

s6_N198_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N198_5, -0.0010332676));

s6_N198_3 :=  __common__( if(((real)c_hval_60k_p < 31.45), s6_N198_4, s6_N198_8));

s6_N198_2 :=  __common__( if(trim(C_HVAL_60K_P) != '', s6_N198_3, -0.013083641));

s6_N198_1 :=  __common__( if(((real)add1_turnover_1yr_in < 4070.5), s6_N198_2, 0.035629757));

s6_N199_11 :=  __common__( if(((integer)add2_avm_med < 394242), -0.0004748596, 0.0529302));

s6_N199_10 :=  __common__( if(((real)_rel_incomeunder50_count < 2.5), -0.0058453166, s6_N199_11));

s6_N199_9 :=  __common__( map(trim(C_LOW_HVAL) = ''    => -0.0070510688,
              ((real)c_low_hval < 3.8) => s6_N199_10,
                                          -0.0070510688));

s6_N199_8 :=  __common__( map(trim(C_BORN_USA) = ''     => -0.0034424092,
              ((real)c_born_usa < 17.5) => s6_N199_9,
                                           -0.0034424092));

s6_N199_7 :=  __common__( if(((real)ssn_lowissue_age < -0.557229), 0.04338732, s6_N199_8));

s6_N199_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N199_7, 0.0013930279));

s6_N199_5 :=  __common__( if(((real)c_rnt2001_p < 26.25), s6_N199_6, 0.05481099));

s6_N199_4 :=  __common__( if(trim(C_RNT2001_P) != '', s6_N199_5, 0.0089675254));

s6_N199_3 :=  __common__( map(trim(C_NO_MOVE) = ''     => 0.060374664,
              ((real)c_no_move < 61.5) => -0.0089134834,
                                          0.060374664));

s6_N199_2 :=  __common__( if(((real)add2_avm_to_med_ratio < 0.499129), s6_N199_3, -0.0028403351));

s6_N199_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N199_2, s6_N199_4));

s6_N200_9 :=  __common__( map(trim(C_AB_AV_EDU) = ''     => -0.0033192548,
              ((real)c_ab_av_edu < 93.5) => 0.0076958053,
                                            -0.0033192548));

s6_N200_8 :=  __common__( if(((real)c_low_ed < 73.75), s6_N200_9, -0.016690085));

s6_N200_7 :=  __common__( if(trim(C_LOW_ED) != '', s6_N200_8, 0.023494852));

s6_N200_6 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), -0.016753774, 0.0065062319));

s6_N200_5 :=  __common__( if(((integer)add1_avm_med < 333657), s6_N200_6, -0.025453855));

s6_N200_4 :=  __common__( if(((real)add1_nhood_vacant_properties < 6.5), -0.013736257, 0.016076679));

s6_N200_3 :=  __common__( if(((real)c_femdiv_p < 3.45), s6_N200_4, s6_N200_5));

s6_N200_2 :=  __common__( if(trim(C_FEMDIV_P) != '', s6_N200_3, -0.026473291));

s6_N200_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N200_2, s6_N200_7));

s6_N201_10 :=  __common__( map(trim(C_WHITE_COL) = ''     => 9.702953e-005,
               ((real)c_white_col < 60.4) => 0.080458705,
                                             9.702953e-005));

s6_N201_9 :=  __common__( map(trim(C_HIGH_ED) = ''     => s6_N201_10,
              ((real)c_high_ed < 34.2) => -0.00055585756,
                                          s6_N201_10));

s6_N201_8 :=  __common__( map(trim(C_OWNOCC_P) = ''      => s6_N201_9,
              ((real)c_ownocc_p < 23.55) => -0.006867582,
                                            s6_N201_9));

s6_N201_7 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.029531195,
              ((real)c_span_lang < 188.5) => s6_N201_8,
                                             0.029531195));

s6_N201_6 :=  __common__( map(trim(C_MANY_CARS) = ''     => -0.00055592506,
              ((real)c_many_cars < 30.5) => s6_N201_7,
                                            -0.00055592506));

s6_N201_5 :=  __common__( if(((real)c_no_move < 197.5), s6_N201_6, 0.038823326));

s6_N201_4 :=  __common__( if(trim(C_NO_MOVE) != '', s6_N201_5, 0.0038753855));

s6_N201_3 :=  __common__( if(((real)combined_age < 19.5), 0.038761713, s6_N201_4));

s6_N201_2 :=  __common__( if(((real)ssn_lowissue_age < -0.699617), 0.044113051, s6_N201_3));

s6_N201_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N201_2, 0.0065458931));

s6_N202_10 :=  __common__( if((combo_dobscore < 65), -0.013376954, 0.00066458812));

s6_N202_9 :=  __common__( map(trim(C_YOUNG) = ''     => -0.0071190393,
              ((real)c_young < 19.5) => 0.066258488,
                                        -0.0071190393));

s6_N202_8 :=  __common__( map(trim(C_LOWRENT) = ''      => 0.047038108,
              ((real)c_lowrent < 26.95) => 0.0090908124,
                                           0.047038108));

s6_N202_7 :=  __common__( map(trim(C_POP_18_24_P) = ''     => s6_N202_8,
              ((real)c_pop_18_24_p < 8.95) => -0.016106493,
                                              s6_N202_8));

s6_N202_6 :=  __common__( map(trim(C_MANY_CARS) = ''     => -0.0068641383,
              ((real)c_many_cars < 46.5) => s6_N202_7,
                                            -0.0068641383));

s6_N202_5 :=  __common__( if(((real)c_fammar_p < 55.25), -0.019075096, s6_N202_6));

s6_N202_4 :=  __common__( if(trim(C_FAMMAR_P) != '', s6_N202_5, -0.025948617));

s6_N202_3 :=  __common__( if(((real)add2_no_of_bedrooms2 < 5.5), s6_N202_4, 0.042438745));

s6_N202_2 :=  __common__( if(((real)_boat_plane < 0.5), s6_N202_3, s6_N202_9));

s6_N202_1 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s6_N202_2, s6_N202_10));

s6_N203_9 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '5']) => 0.025338466,
              (prof_license_category in ['4'])                     => 0.21048684,
                                                                      0.025338466));

s6_N203_8 :=  __common__( if(((real)add2_mortgage_risky < 0.5), 0.010738066, 0.060079249));

s6_N203_7 :=  __common__( map(trim(C_VACANT_P) = ''     => s6_N203_8,
              ((real)c_vacant_p < 2.45) => -0.011432676,
                                           s6_N203_8));

s6_N203_6 :=  __common__( if(((real)add2_avm_to_med_ratio < 0.503831), 0.062941645, s6_N203_7));

s6_N203_5 :=  __common__( if(((real)_paw_business_match < 0.5), s6_N203_6, -0.0073376782));

s6_N203_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N203_5, 0.0022052916));

s6_N203_3 :=  __common__( if(((real)c_blue_col < 27.35), s6_N203_4, s6_N203_9));

s6_N203_2 :=  __common__( if(trim(C_BLUE_COL) != '', s6_N203_3, 0.0092396952));

s6_N203_1 :=  __common__( if(((real)_inq_perphone < 0.5), s6_N203_2, -0.0062473314));

s6_N204_12 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.058196964,
               ((real)c_span_lang < 135.5) => 0.006925256,
                                              0.058196964));

s6_N204_11 :=  __common__( if(((real)c_white_col < 38.15), -0.0073117668, s6_N204_12));

s6_N204_10 :=  __common__( if(trim(C_WHITE_COL) != '', s6_N204_11, 0.012464343));

s6_N204_9 :=  __common__( if(((integer)add2_turnover_1yr_in < 938), -0.0012736615, s6_N204_10));

s6_N204_8 :=  __common__( if(((real)add1_lres < 424.5), 0.0013139934, 0.040095834));

s6_N204_7 :=  __common__( if(((real)ssn_lowissue_age < -0.361446), 0.041564367, s6_N204_8));

s6_N204_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N204_7, -0.00051381569));

s6_N204_5 :=  __common__( if(((real)c_med_age < 18.5), -0.016200702, s6_N204_6));

s6_N204_4 :=  __common__( if(trim(C_MED_AGE) != '', s6_N204_5, -0.026483667));

s6_N204_3 :=  __common__( if(((real)add1_building_area2 < 678.5), 0.036417342, s6_N204_4));

s6_N204_2 :=  __common__( if(((real)_ssncount < 1.5), -0.01850267, s6_N204_3));

s6_N204_1 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N204_2, s6_N204_9));

s6_N205_8 :=  __common__( if(((real)_rel_prop_owned_total < 1.5), 0.058270303, -0.0089103303));

s6_N205_7 :=  __common__( if(((integer)add1_nhood_vacant_properties < 38), 0.036011329, 0.0049627808));

s6_N205_6 :=  __common__( map(trim(C_RAPE) = ''      => s6_N205_7,
              ((integer)c_rape < 53) => -0.0075092341,
                                        s6_N205_7));

s6_N205_5 :=  __common__( if(((real)add1_source_count < 1.5), s6_N205_6, 0.00079080242));

s6_N205_4 :=  __common__( map(trim(C_HIGHINC) = ''     => s6_N205_5,
              ((real)c_highinc < 4.35) => -0.0059030583,
                                          s6_N205_5));

s6_N205_3 :=  __common__( if(((real)c_rnt250_p < 50.95), s6_N205_4, s6_N205_8));

s6_N205_2 :=  __common__( if(trim(C_RNT250_P) != '', s6_N205_3, -0.0092642531));

s6_N205_1 :=  __common__( if((combo_dobscore < 65), 0.011429427, s6_N205_2));

s6_N206_8 :=  __common__( map(trim(C_HVAL_80K_P) = ''     => 0.0088111695,
              ((real)c_hval_80k_p < 5.45) => -0.029637152,
                                             0.0088111695));

s6_N206_7 :=  __common__( if(((real)_rel_homeunder50_count < 3.5), -0.029900077, 0.013246834));

s6_N206_6 :=  __common__( map(trim(C_MED_RENT) = ''      => s6_N206_7,
              ((real)c_med_rent < 534.5) => 0.047197422,
                                            s6_N206_7));

s6_N206_5 :=  __common__( map(trim(C_EDU_INDX) = ''      => -0.028446652,
              ((real)c_edu_indx < 175.5) => 0.00055188233,
                                            -0.028446652));

s6_N206_4 :=  __common__( if(((real)_rel_bankrupt_count < 4.5), s6_N206_5, s6_N206_6));

s6_N206_3 :=  __common__( if(((real)c_bel_edu < 195.5), s6_N206_4, -0.027547548));

s6_N206_2 :=  __common__( if(trim(C_BEL_EDU) != '', s6_N206_3, -0.012049126));

s6_N206_1 :=  __common__( if(((real)age < 80.5), s6_N206_2, s6_N206_8));

s6_N207_9 :=  __common__( if(((integer)add1_building_area2 < 1850), 0.046840123, -0.010173155));

s6_N207_8 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '4']) => s6_N207_9,
              (prof_license_category in ['5'])                     => 0.146337,
                                                                      s6_N207_9));

s6_N207_7 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N207_8, 0.0094525166));

s6_N207_6 :=  __common__( if(((real)ssn_lowissue_age < 10.5846), 0.05570992, 0.0034141358));

s6_N207_5 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N207_6, -0.02878727));

s6_N207_4 :=  __common__( if(((real)phn_cellpager < 0.5), s6_N207_5, -0.0067808438));

s6_N207_3 :=  __common__( if(((real)combined_age < 56.5), s6_N207_4, s6_N207_7));

s6_N207_2 :=  __common__( if(((real)input_dob_match_level < 6.5), 0.024864693, s6_N207_3));

s6_N207_1 :=  __common__( if(((real)_phone_score < 1.5), -0.00073240685, s6_N207_2));

s6_N208_9 :=  __common__( if((combo_dobscore < 80), -0.014063395, -0.0013949948));

s6_N208_8 :=  __common__( if(((real)add2_lres < 45.5), 0.026900637, -0.014368883));

s6_N208_7 :=  __common__( map(trim(C_AB_AV_EDU) = ''      => s6_N208_8,
              ((real)c_ab_av_edu < 104.5) => 0.033635298,
                                             s6_N208_8));

s6_N208_6 :=  __common__( map(trim(C_MANY_CARS) = ''     => -0.00061403112,
              ((real)c_many_cars < 53.5) => s6_N208_7,
                                            -0.00061403112));

s6_N208_5 :=  __common__( if(((real)c_low_ed < 61.95), s6_N208_6, -0.014765606));

s6_N208_4 :=  __common__( if(trim(C_LOW_ED) != '', s6_N208_5, -0.027875083));

s6_N208_3 :=  __common__( if(((real)combo_dobcount < 0.5), 0.028236745, s6_N208_4));

s6_N208_2 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s6_N208_3, s6_N208_9));

s6_N208_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N208_2, -0.025975782));

s6_N209_11 :=  __common__( if(((real)c_civ_emp < 75.75), -0.0020084783, 0.04773841));

s6_N209_10 :=  __common__( if(trim(C_CIV_EMP) != '', s6_N209_11, -0.025649751));

s6_N209_9 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s6_N209_10, 0.0013190501));

s6_N209_8 :=  __common__( if(((real)_addrs_last30 < 0.5), 0.0010588445, 0.035985827));

s6_N209_7 :=  __common__( if(((real)add2_nhood_vacant_properties < 22.5), s6_N209_8, -0.0090744991));

s6_N209_6 :=  __common__( if(((real)c_hval_100k_p < 23.6), s6_N209_7, 0.038310804));

s6_N209_5 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N209_6, -0.028984187));

s6_N209_4 :=  __common__( if(((real)rc_addrcount < 3.5), s6_N209_5, s6_N209_9));

s6_N209_3 :=  __common__( if(((real)c_easiqlife < 72.5), 0.0089425983, -0.0038511646));

s6_N209_2 :=  __common__( if(trim(C_EASIQLIFE) != '', s6_N209_3, 0.0054938079));

s6_N209_1 :=  __common__( if(((real)add2_naprop < 3.5), s6_N209_2, s6_N209_4));

s6_N210_9 :=  __common__( map(trim(C_FOR_SALE) = ''       => -0.0010832061,
              ((integer)c_for_sale < 113) => 0.0380804,
                                             -0.0010832061));

s6_N210_8 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.0080834021,
              ((real)c_hhsize < 2.195) => 0.045436146,
                                          0.0080834021));

s6_N210_7 :=  __common__( map(trim(C_HVAL_20K_P) = ''     => s6_N210_8,
              ((real)c_hval_20k_p < 1.25) => 0.00069582757,
                                             s6_N210_8));

s6_N210_6 :=  __common__( map(trim(C_TRAILER_P) = ''     => -0.0058324666,
              ((real)c_trailer_p < 1.05) => s6_N210_7,
                                            -0.0058324666));

s6_N210_5 :=  __common__( if(((real)_rel_felony_total < 2.5), s6_N210_6, s6_N210_9));

s6_N210_4 :=  __common__( map(trim(C_FEMDIV_P) = ''    => 0.037031199,
              ((real)c_femdiv_p < 4.2) => -0.012124595,
                                          0.037031199));

s6_N210_3 :=  __common__( if(((real)_prop_owned_total < 1.5), s6_N210_4, 0.058417732));

s6_N210_2 :=  __common__( if(((real)c_mort_indx < 12.5), s6_N210_3, s6_N210_5));

s6_N210_1 :=  __common__( if(trim(C_MORT_INDX) != '', s6_N210_2, 0.008799439));

s6_N211_9 :=  __common__( map(trim(C_TOTSALES) = ''        => 0.057586741,
              ((integer)c_totsales < 4080) => -0.00037901484,
                                              0.057586741));

s6_N211_8 :=  __common__( if(((real)_addrs_last24 < 4.5), -0.0029569647, s6_N211_9));

s6_N211_7 :=  __common__( map(trim(C_FOR_SALE) = ''      => 0.064362526,
              ((real)c_for_sale < 188.5) => s6_N211_8,
                                            0.064362526));

s6_N211_6 :=  __common__( map(trim(C_UNEMPL) = ''     => -0.0033972743,
              ((real)c_unempl < 46.5) => s6_N211_7,
                                         -0.0033972743));

s6_N211_5 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.049162168,
              ((real)c_span_lang < 139.5) => -0.018270289,
                                             0.049162168));

s6_N211_4 :=  __common__( if(((real)add3_naprop < 0.5), -0.017535125, s6_N211_5));

s6_N211_3 :=  __common__( map(trim(C_UNEMPL) = ''       => 0.029957949,
              ((integer)c_unempl < 158) => s6_N211_4,
                                           0.029957949));

s6_N211_2 :=  __common__( if(((real)c_sfdu_p < 2.55), s6_N211_3, s6_N211_6));

s6_N211_1 :=  __common__( if(trim(C_SFDU_P) != '', s6_N211_2, -0.013440238));

s6_N212_8 :=  __common__( map(trim(C_WHITE_COL) = ''      => -0.013721301,
              ((real)c_white_col < 17.15) => 0.0071479962,
                                             -0.013721301));

s6_N212_7 :=  __common__( map(trim(C_RETIRED2) = ''      => -0.0070910402,
              ((real)c_retired2 < 104.5) => 0.04363266,
                                            -0.0070910402));

s6_N212_6 :=  __common__( if(((real)_rel_felony_total < 2.5), -0.00049488264, s6_N212_7));

s6_N212_5 :=  __common__( if(((real)gong_did_addr_ct < 1.5), 0.0064401021, 0.04682818));

s6_N212_4 :=  __common__( map(trim(C_MORT_INDX) = ''     => s6_N212_6,
              ((real)c_mort_indx < 12.5) => s6_N212_5,
                                            s6_N212_6));

s6_N212_3 :=  __common__( if(((real)c_span_lang < 176.5), s6_N212_4, s6_N212_8));

s6_N212_2 :=  __common__( if(trim(C_SPAN_LANG) != '', s6_N212_3, -0.026432337));

s6_N212_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N212_2, 0.020893511));

s6_N213_13 :=  __common__( map(trim(C_OWNOCC_P) = ''      => 0.036898827,
               ((real)c_ownocc_p < 97.15) => -0.0042256569,
                                             0.036898827));

s6_N213_12 :=  __common__( map(trim(C_POP_25_34_P) = ''      => 0.033507287,
               ((real)c_pop_25_34_p < 18.65) => -0.00017585422,
                                                0.033507287));

s6_N213_11 :=  __common__( if(((real)add2_lres < 251.5), s6_N213_12, 0.058408157));

s6_N213_10 :=  __common__( if(((real)c_ab_av_edu < 45.5), s6_N213_11, s6_N213_13));

s6_N213_9 :=  __common__( if(trim(C_AB_AV_EDU) != '', s6_N213_10, -0.0089458214));

s6_N213_8 :=  __common__( if(((real)c_born_usa < 13.5), 0.022358504, -0.0024529208));

s6_N213_7 :=  __common__( if(trim(C_BORN_USA) != '', s6_N213_8, -0.025646515));

s6_N213_6 :=  __common__( if(((integer)add1_building_area2 < 1509), 0.032914627, -0.012494151));

s6_N213_5 :=  __common__( if(((real)add3_avm_automated_valuation < 43748.5), 0.0585775, -0.0054888002));

s6_N213_4 :=  __common__( if(((real)add1_avm_to_med_ratio < 0.68196), s6_N213_5, -0.0054474679));

s6_N213_3 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s6_N213_4, s6_N213_6));

s6_N213_2 :=  __common__( if(((real)add1_building_area2 > NULL), s6_N213_3, s6_N213_7));

s6_N213_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N213_2, s6_N213_9));

s6_N214_9 :=  __common__( map(trim(C_HVAL_20K_P) = ''    => 0.058273902,
              ((real)c_hval_20k_p < 0.2) => -0.0044963628,
                                            0.058273902));

s6_N214_8 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.018117642, 0.0068773316));

s6_N214_7 :=  __common__( map(trim(C_HIGH_ED) = ''      => s6_N214_8,
              ((real)c_high_ed < 11.65) => -0.0061965336,
                                           s6_N214_8));

s6_N214_6 :=  __common__( map(trim(C_HVAL_100K_P) = ''      => s6_N214_9,
              ((real)c_hval_100k_p < 15.25) => s6_N214_7,
                                               s6_N214_9));

s6_N214_5 :=  __common__( map(trim(C_RENTOCC_P) = ''      => 0.023701663,
              ((real)c_rentocc_p < 92.95) => s6_N214_6,
                                             0.023701663));

s6_N214_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N214_5, 0.031000907));

s6_N214_3 :=  __common__( map(trim(C_MED_RENT) = ''       => -0.0074199525,
              ((real)c_med_rent < 1135.5) => s6_N214_4,
                                             -0.0074199525));

s6_N214_2 :=  __common__( if(((real)c_hval_100k_p < 16.45), s6_N214_3, -0.0064282191));

s6_N214_1 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N214_2, -0.0025839296));

s6_N215_12 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '4']) => 0.00068529479,
               (prof_license_category in ['5'])                     => 0.23066457,
                                                                       0.00068529479));
s6_N215_11 :=  __common__( if(((real)mth_gong_did_first_seen < 20.5), 0.02961868, -0.0025887914));
s6_N215_10 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s6_N215_11, s6_N215_12));
s6_N215_9 :=  __common__( if(((integer)c_med_hhinc < 125337), s6_N215_10, 0.045175549));
s6_N215_8 :=  __common__( if(trim(C_MED_HHINC) != '', s6_N215_9, 0.047921593));
s6_N215_7 :=  __common__( if(((real)_inq_peraddr_cap8 < 7.5), s6_N215_8, 0.026182595));
s6_N215_6 :=  __common__( if(((real)c_pop_25_34_p < 14.4), 0.002724233, 0.035130764));
s6_N215_5 :=  __common__( if(trim(C_POP_25_34_P) != '', s6_N215_6, -0.026135618));
s6_N215_4 :=  __common__( if((combo_dobscore < 95), s6_N215_5, s6_N215_7));
s6_N215_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), -0.001413067, s6_N215_4));
s6_N215_2 :=  __common__( if(((real)ssn_lowissue_age < -0.774918), 0.044935002, s6_N215_3));
s6_N215_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N215_2, -0.0035709751));

s6_N216_10 :=  __common__( if(((real)add1_unit_count < 668.5), -0.0003166736, 0.031849308));
s6_N216_9 :=  __common__( if((add3_lres < 137), -0.0073268652, 0.053360883));
s6_N216_8 :=  __common__( if(mth_header_first_seen != null and ((real)mth_header_first_seen < 62.5), 0.031121373, -0.0067604799));
s6_N216_7 :=  __common__( if(((real)add1_building_area2 > NULL), -0.0042337035, s6_N216_8));
s6_N216_6 :=  __common__( if(((real)liens_historical_unreleased_ct < 0.5), s6_N216_7, s6_N216_9));
s6_N216_5 :=  __common__( map((prof_license_category in ['1', '5'])           => -0.0071546568,
              (prof_license_category in ['0', '2', '3', '4']) => 0.04974341,
                                                                 -0.0071546568));
s6_N216_4 :=  __common__( if(((real)add1_source_count < 2.5), 0.025013646, s6_N216_5));
s6_N216_3 :=  __common__( map(trim(C_RELIG_INDX) = ''       => 0.062434711,
              ((integer)c_relig_indx < 171) => s6_N216_4,
                                               0.062434711));
s6_N216_2 :=  __common__( if(((real)rc_dirsaddr_lastscore < 38.5), s6_N216_3, s6_N216_6));
s6_N216_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N216_2, s6_N216_10));

s6_N217_9 :=  __common__( map(trim(C_RAPE) = ''      => 0.03803779,
              ((real)c_rape < 100.5) => -0.024704628,
                                        0.03803779));

s6_N217_8 :=  __common__( map(trim(C_MED_HVAL) = ''          => s6_N217_9,
              ((integer)c_med_hval < 151290) => 0.04604778,
                                                s6_N217_9));

s6_N217_7 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.075242758, s6_N217_8));

s6_N217_6 :=  __common__( map(trim(C_AB_AV_EDU) = ''      => s6_N217_7,
              ((real)c_ab_av_edu < 181.5) => -0.0088031016,
                                             s6_N217_7));

s6_N217_5 :=  __common__( map(trim(C_WHITE_COL) = ''      => 0.033587832,
              ((real)c_white_col < 68.05) => 0.0024215779,
                                             0.033587832));

s6_N217_4 :=  __common__( map(trim(C_HVAL_100K_P) = ''      => 0.028386187,
              ((real)c_hval_100k_p < 49.95) => s6_N217_5,
                                               0.028386187));

s6_N217_3 :=  __common__( map(trim(C_LARCENY) = ''      => s6_N217_6,
              ((real)c_larceny < 157.5) => s6_N217_4,
                                           s6_N217_6));

s6_N217_2 :=  __common__( if(((real)c_inc_15k_p < 0.45), -0.018565071, s6_N217_3));

s6_N217_1 :=  __common__( if(trim(C_INC_15K_P) != '', s6_N217_2, 0.0045873816));

s6_N218_9 :=  __common__( if(((real)_nap < 5.5), -0.00019456916, 0.0278024));

s6_N218_8 :=  __common__( map(trim(C_MIL_EMP) = ''     => 0.042802506,
              ((real)c_mil_emp < 3.55) => s6_N218_9,
                                          0.042802506));

s6_N218_7 :=  __common__( map(trim(C_LOW_HVAL) = ''     => 0.029641356,
              ((real)c_low_hval < 65.9) => s6_N218_8,
                                           0.029641356));

s6_N218_6 :=  __common__( if(((real)_ssn_score < 1.5), s6_N218_7, 0.024753663));

s6_N218_5 :=  __common__( if((combo_dobscore < 80), 0.013748697, s6_N218_6));

s6_N218_4 :=  __common__( if(((real)add2_avm_med < 65302.5), 0.042685874, -0.00033903731));

s6_N218_3 :=  __common__( if(((real)add2_source_count < 5.5), -0.010933171, s6_N218_4));

s6_N218_2 :=  __common__( if(((real)c_highinc < 3.95), s6_N218_3, s6_N218_5));

s6_N218_1 :=  __common__( if(trim(C_HIGHINC) != '', s6_N218_2, -0.014242411));

s6_N219_10 :=  __common__( if(((real)_inq_collection_count < 1.5), -0.00023459271, 0.030741193));

s6_N219_9 :=  __common__( if(((real)_rel_educationunder12_count < 3.5), s6_N219_10, 0.046065014));

s6_N219_8 :=  __common__( if(((real)_inq_perssn < 2.5), 0.0004318543, s6_N219_9));

s6_N219_7 :=  __common__( map(trim(C_MURDERS) = ''     => 0.067795479,
              ((real)c_murders < 67.5) => 0.0046992118,
                                          0.067795479));

s6_N219_6 :=  __common__( if(((real)c_inc_50k_p < 3.65), s6_N219_7, s6_N219_8));

s6_N219_5 :=  __common__( if(trim(C_INC_50K_P) != '', s6_N219_6, 0.024820503));

s6_N219_4 :=  __common__( if(((real)_addrs_15yr < 9.5), s6_N219_5, -0.0052959541));

s6_N219_3 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.03176174, s6_N219_4));

s6_N219_2 :=  __common__( if(((real)ssn_lowissue_age < 26.0501), s6_N219_3, -0.010802524));

s6_N219_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N219_2, 0.0094088798));

s6_N220_8 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0066980031, 0.037653451));

s6_N220_7 :=  __common__( map(trim(C_HVAL_60K_P) = ''      => 0.036144151,
              ((real)c_hval_60k_p < 27.75) => 0.0078355925,
                                              0.036144151));

s6_N220_6 :=  __common__( if(((real)_inq_count06 < 2.5), 0.00022775536, s6_N220_7));

s6_N220_5 :=  __common__( map(trim(C_RECENT_MOV) = ''      => -0.011573808,
              ((real)c_recent_mov < 180.5) => s6_N220_6,
                                              -0.011573808));

s6_N220_4 :=  __common__( if(((real)c_recent_mov < 196.5), s6_N220_5, s6_N220_8));

s6_N220_3 :=  __common__( if(trim(C_RECENT_MOV) != '', s6_N220_4, 0.0028122489));

s6_N220_2 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => -0.007603041,
              (prof_license_category in ['2'])                     => 0.089440033,
                                                                      -0.007603041));

s6_N220_1 :=  __common__( if(((real)combined_age < 32.5), s6_N220_2, s6_N220_3));

s6_N221_9 :=  __common__( map(trim(C_INC_15K_P) = ''     => 0.042430314,
              ((real)c_inc_15k_p < 9.45) => 0.0072757787,
                                            0.042430314));

s6_N221_8 :=  __common__( map(trim(C_OWNOCC_P) = ''      => s6_N221_9,
              ((real)c_ownocc_p < 21.35) => -0.01966307,
                                            s6_N221_9));

s6_N221_7 :=  __common__( map(trim(C_HVAL_40K_P) = ''     => 0.047752694,
              ((real)c_hval_40k_p < 4.25) => s6_N221_8,
                                             0.047752694));

s6_N221_6 :=  __common__( if(((real)add2_lres < 2.5), 0.029832532, 0.00061579538));

s6_N221_5 :=  __common__( if(((real)combo_dobcount < 3.5), 0.031083175, s6_N221_6));

s6_N221_4 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.0041178228,
              ((real)c_fammar_p < 34.65) => 0.01461784,
                                            -0.0041178228));

s6_N221_3 :=  __common__( if(((real)_addrs_last30 < 1.5), s6_N221_4, s6_N221_5));

s6_N221_2 :=  __common__( if(((real)c_white_col < 51.35), s6_N221_3, s6_N221_7));

s6_N221_1 :=  __common__( if(trim(C_WHITE_COL) != '', s6_N221_2, 0.011986929));

s6_N222_9 :=  __common__( map(trim(C_MIL_EMP) = ''     => 0.026121928,
              ((real)c_mil_emp < 0.95) => 0.003129893,
                                          0.026121928));

s6_N222_8 :=  __common__( map(trim(C_FOR_SALE) = ''      => -0.014674136,
              ((real)c_for_sale < 165.5) => s6_N222_9,
                                            -0.014674136));

s6_N222_7 :=  __common__( map(trim(C_RNT750_P) = ''      => s6_N222_8,
              ((real)c_rnt750_p < 27.45) => 0.034401774,
                                            s6_N222_8));

s6_N222_6 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), 0.045675337, s6_N222_7));

s6_N222_5 :=  __common__( if(((real)_rel_homeover500_count < 3.5), -0.0053379481, 0.032002796));

s6_N222_4 :=  __common__( map(trim(C_RNT750_P) = ''      => s6_N222_6,
              ((real)c_rnt750_p < 26.65) => s6_N222_5,
                                            s6_N222_6));

s6_N222_3 :=  __common__( map(trim(C_HIGH_ED) = ''     => s6_N222_4,
              ((real)c_high_ed < 1.95) => 0.022262568,
                                          s6_N222_4));

s6_N222_2 :=  __common__( if(((integer)c_med_hval < 11006), -0.02181448, s6_N222_3));

s6_N222_1 :=  __common__( if(trim(C_MED_HVAL) != '', s6_N222_2, 0.01121424));

s6_N223_9 :=  __common__( if((add1_unit_count < 39), 0.01200647, 0.050140036));

s6_N223_8 :=  __common__( map(trim(C_RENTAL) = ''     => -0.0028526704,
              ((real)c_rental < 92.5) => s6_N223_9,
                                         -0.0028526704));

s6_N223_7 :=  __common__( if(((real)gong_did_addr_ct < 3.5), 0.0016735572, 0.046497242));

s6_N223_6 :=  __common__( if(((real)add2_avm_to_med_ratio < 0.448699), 0.054287758, s6_N223_7));

s6_N223_5 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N223_6, s6_N223_8));

s6_N223_4 :=  __common__( if(((real)c_lar_fam < 102.5), -0.0014183448, s6_N223_5));

s6_N223_3 :=  __common__( if(trim(C_LAR_FAM) != '', s6_N223_4, 0.0078495823));

s6_N223_2 :=  __common__( if(((real)_addrs_last90 < 0.5), -0.023364636, 0.0016478542));

s6_N223_1 :=  __common__( if((combo_dobscore < 80), s6_N223_2, s6_N223_3));

s6_N224_9 :=  __common__( if(((real)_inq_count01 < 0.5), 0.01830734, 0.044546096));

s6_N224_8 :=  __common__( map(trim(C_LARCENY) = ''      => s6_N224_9,
              ((real)c_larceny < 134.5) => -0.0025261097,
                                           s6_N224_9));

s6_N224_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), s6_N224_8, 0.046255229));

s6_N224_6 :=  __common__( if(((real)add2_lres < 2.5), 0.024638092, 0.0010056063));

s6_N224_5 :=  __common__( map(trim(C_RNT250_P) = ''     => 0.038679273,
              ((real)c_rnt250_p < 4.05) => s6_N224_6,
                                           0.038679273));

s6_N224_4 :=  __common__( map(trim(C_RNT250_P) = ''     => -0.0065307489,
              ((real)c_rnt250_p < 5.35) => s6_N224_5,
                                           -0.0065307489));

s6_N224_3 :=  __common__( if(((real)add2_naprop < 3.5), s6_N224_4, s6_N224_7));

s6_N224_2 :=  __common__( if(((real)c_bigapt_p < 2.75), -0.0014371832, s6_N224_3));

s6_N224_1 :=  __common__( if(trim(C_BIGAPT_P) != '', s6_N224_2, -0.0046135735));

s6_N225_9 :=  __common__( if(((real)c_span_lang < 130.5), -0.0033259345, 0.0053474088));

s6_N225_8 :=  __common__( if(trim(C_SPAN_LANG) != '', s6_N225_9, 0.022756486));

s6_N225_7 :=  __common__( map(trim(C_MED_HVAL) = ''          => -0.030809774,
              ((integer)c_med_hval < 119488) => -0.012323998,
                                                -0.030809774));

s6_N225_6 :=  __common__( map(trim(C_HVAL_40K_P) = ''     => 0.0074859193,
              ((real)c_hval_40k_p < 0.85) => -0.016696926,
                                             0.0074859193));

s6_N225_5 :=  __common__( if(((real)age < 45.5), s6_N225_6, s6_N225_7));

s6_N225_4 :=  __common__( if(((real)c_femdiv_p < 2.65), 0.0080945194, s6_N225_5));

s6_N225_3 :=  __common__( if(trim(C_FEMDIV_P) != '', s6_N225_4, -0.026530996));

s6_N225_2 :=  __common__( map((prof_license_category in ['1', '2', '3', '4']) => s6_N225_3,
              (prof_license_category in ['0', '5'])           => 0.064331345,
                                                                 s6_N225_3));

s6_N225_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N225_2, s6_N225_8));

s6_N226_9 :=  __common__( if(((real)age < 82.5), -0.0026681986, 0.019884738));
s6_N226_8 :=  __common__( if(((real)_lnames_per_adl < 2.5), 0.066617598, 0.0012751012));
s6_N226_7 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => -0.0060432333,
              (prof_license_category in ['0'])                     => 0.14343251,
                                                                      -0.0060432333));
s6_N226_6 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), 0.0085972414, s6_N226_7));
s6_N226_5 :=  __common__( map(trim(C_RNT2001_P) = ''      => 0.057536574,
              ((real)c_rnt2001_p < 26.05) => s6_N226_6,
                                             0.057536574));
s6_N226_4 :=  __common__( if(((real)_addrs_last90 < 2.5), s6_N226_5, s6_N226_8));
s6_N226_3 :=  __common__( if(((real)c_unempl < 48.5), s6_N226_4, s6_N226_9));
s6_N226_2 :=  __common__( if(trim(C_UNEMPL) != '', s6_N226_3, -0.026863939));
s6_N226_1 :=  __common__( if(((real)_ssncount < 1.5), -0.014685563, s6_N226_2));

s6_N227_10 :=  __common__( if(ssn_lowissue_age != null and ((real)ssn_lowissue_age < 11.4951), -0.0015862004, 0.045207821));
s6_N227_9 :=  __common__( if(((real)_nap < 3.5), 0.0074183539, s6_N227_10));
s6_N227_8 :=  __common__( if(((real)_inq_count01 < 0.5), -0.0038817117, 0.044772118));
s6_N227_7 :=  __common__( map(trim(C_LAR_FAM) = ''      => s6_N227_8,
              ((real)c_lar_fam < 168.5) => 0.00053856331,
                                           s6_N227_8));
s6_N227_6 :=  __common__( if(((real)_rel_prop_owned_count < 3.5), s6_N227_7, -0.019722041));
s6_N227_5 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s6_N227_6, 0.0024287701));
s6_N227_4 :=  __common__( if(((integer)add2_avm_med < 134925), -0.010849076, s6_N227_5));
s6_N227_3 :=  __common__( map(trim(C_BORN_USA) = ''      => s6_N227_9,
              ((real)c_born_usa < 149.5) => s6_N227_4,
                                            s6_N227_9));
s6_N227_2 :=  __common__( if(((real)c_high_ed < 1.95), 0.018195564, s6_N227_3));
s6_N227_1 :=  __common__( if(trim(C_HIGH_ED) != '', s6_N227_2, -0.0075328375));

s6_N228_9 :=  __common__( map(trim(C_ASIAN_LANG) = ''       => -0.028249781,
              ((integer)c_asian_lang < 131) => 0.01655107,
                                               -0.028249781));

s6_N228_8 :=  __common__( if(((real)c_asian_lang < 161.5), s6_N228_9, 0.04543205));

s6_N228_7 :=  __common__( if(trim(C_ASIAN_LANG) != '', s6_N228_8, -0.025608677));

s6_N228_6 :=  __common__( if(((real)add2_naprop < 3.5), -0.0027523581, s6_N228_7));

s6_N228_5 :=  __common__( map(trim(C_TOTCRIME) = ''     => -0.010187898,
              ((real)c_totcrime < 87.5) => 0.039580058,
                                           -0.010187898));

s6_N228_4 :=  __common__( if(((real)c_inc_50k_p < 12.35), 0.052489277, s6_N228_5));

s6_N228_3 :=  __common__( if(trim(C_INC_50K_P) != '', s6_N228_4, -0.026588622));

s6_N228_2 :=  __common__( if(((real)add2_lres < 8.5), s6_N228_3, s6_N228_6));

s6_N228_1 :=  __common__( if(((real)_rel_count_addr < 0.5), s6_N228_2, -0.00094399963));

s6_N229_8 :=  __common__( if(((real)_altlname < 0.5), 0.00075779557, 0.031440421));

s6_N229_7 :=  __common__( if(((real)add1_unit_count < 30.5), 0.011778152, 0.049273954));

s6_N229_6 :=  __common__( map(trim(C_FAMMAR_P) = ''      => s6_N229_8,
              ((real)c_fammar_p < 59.75) => s6_N229_7,
                                            s6_N229_8));

s6_N229_5 :=  __common__( map(trim(C_RNT750_P) = ''      => s6_N229_6,
              ((real)c_rnt750_p < 50.05) => -0.00018905996,
                                            s6_N229_6));

s6_N229_4 :=  __common__( if(((real)c_hval_1000k_p < 1.45), s6_N229_5, -0.015263337));

s6_N229_3 :=  __common__( if(trim(C_HVAL_1000K_P) != '', s6_N229_4, 0.0043774138));

s6_N229_2 :=  __common__( if((combo_dobscore < 65), 0.013324247, s6_N229_3));

s6_N229_1 :=  __common__( if(((real)_ssncount < 1.5), -0.011511861, s6_N229_2));

s6_N230_8 :=  __common__( if(((real)_num_purchase24 < 0.5), 0.0092986759, -0.019065926));

s6_N230_7 :=  __common__( if(((real)age < 62.5), s6_N230_8, 0.030799392));

s6_N230_6 :=  __common__( if(((real)rc_dirsaddr_lastscore < 34.5), s6_N230_7, -0.0042001008));

s6_N230_5 :=  __common__( if(((real)c_span_lang < 161.5), 0.0031117671, 0.039559974));

s6_N230_4 :=  __common__( if(trim(C_SPAN_LANG) != '', s6_N230_5, -0.026029617));

s6_N230_3 :=  __common__( if(((real)combo_dobcount < 0.5), s6_N230_4, s6_N230_6));

s6_N230_2 :=  __common__( map(trim(C_RETIRED) = ''     => -0.0010768353,
              ((real)c_retired < 9.15) => -0.026614325,
                                          -0.0010768353));

s6_N230_1 :=  __common__( if(((real)input_dob_match_level < 2.5), s6_N230_2, s6_N230_3));

s6_N231_9 :=  __common__( if(((real)_prop_owned_total < 4.5), 6.2624005e-005, -0.018620386));

s6_N231_8 :=  __common__( if(((integer)c_young < 26), -0.0074799482, -0.035213287));

s6_N231_7 :=  __common__( if(trim(C_YOUNG) != '', s6_N231_8, -0.026153365));

s6_N231_6 :=  __common__( if(((real)c_incollege < 5.55), -0.0072571235, 0.015059317));

s6_N231_5 :=  __common__( if(trim(C_INCOLLEGE) != '', s6_N231_6, -0.02565291));

s6_N231_4 :=  __common__( map((prof_license_category in ['1', '2', '4', '5']) => s6_N231_5,
              (prof_license_category in ['0', '3'])           => 0.05455556,
                                                                 s6_N231_5));

s6_N231_3 :=  __common__( if(((real)_rel_homeunder100_count < 3.5), s6_N231_4, -0.013579575));

s6_N231_2 :=  __common__( if(((real)_inq_count < 4.5), s6_N231_3, s6_N231_7));

s6_N231_1 :=  __common__( if(((real)rc_addrcount < 1.5), s6_N231_2, s6_N231_9));

s6_N232_10 :=  __common__( if(((real)_inq_count03_cap3 < 1.5), -0.0079279454, 0.018005628));

s6_N232_9 :=  __common__( map(trim(C_MURDERS) = ''      => s6_N232_10,
              ((integer)c_murders < 47) => 0.04397889,
                                           s6_N232_10));

s6_N232_8 :=  __common__( map(trim(C_CARTHEFT) = ''      => 0.032838941,
              ((real)c_cartheft < 147.5) => 0.0041087766,
                                            0.032838941));

s6_N232_7 :=  __common__( if(((real)add2_turnover_1yr_in < 263.5), s6_N232_8, -0.015948414));

s6_N232_6 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N232_7, s6_N232_9));

s6_N232_5 :=  __common__( map(trim(C_POP_25_34_P) = ''      => 0.047408984,
              ((real)c_pop_25_34_p < 23.45) => s6_N232_6,
                                               0.047408984));

s6_N232_4 :=  __common__( if(((real)_rel_educationunder12_count < 2.5), -2.9289005e-005, s6_N232_5));

s6_N232_3 :=  __common__( map(trim(C_RNT750_P) = ''      => -0.014098834,
              ((real)c_rnt750_p < 67.65) => s6_N232_4,
                                            -0.014098834));

s6_N232_2 :=  __common__( if(((real)c_low_hval < 88.15), s6_N232_3, -0.024543187));

s6_N232_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s6_N232_2, -0.026244779));

s6_N233_10 :=  __common__( if(((real)add2_source_count < 1.5), 0.032721222, -0.0044487979));

s6_N233_9 :=  __common__( if(((real)add3_naprop < 2.5), s6_N233_10, 0.04787206));

s6_N233_8 :=  __common__( if(((real)_altlname < 0.5), -0.0019315316, s6_N233_9));

s6_N233_7 :=  __common__( map(trim(C_SFDU_P) = ''     => -0.01312235,
              ((real)c_sfdu_p < 72.4) => 0.048600772,
                                         -0.01312235));

s6_N233_6 :=  __common__( map(trim(C_ROBBERY) = ''       => 0.039359247,
              ((integer)c_robbery < 130) => -0.011947022,
                                            0.039359247));

s6_N233_5 :=  __common__( if(((real)c_mort_indx < 44.5), -0.013588203, 0.00011870911));

s6_N233_4 :=  __common__( if(trim(C_MORT_INDX) != '', s6_N233_5, -0.026091417));

s6_N233_3 :=  __common__( if(((real)gong_did_addr_ct < 3.5), s6_N233_4, s6_N233_6));

s6_N233_2 :=  __common__( if(((real)add2_avm_to_med_ratio < 1.91816), s6_N233_3, s6_N233_7));

s6_N233_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s6_N233_2, s6_N233_8));

s6_N234_9 :=  __common__( map(trim(C_FEMDIV_P) = ''     => -0.022261461,
              ((real)c_femdiv_p < 4.95) => 0.0056264634,
                                           -0.022261461));

s6_N234_8 :=  __common__( if(((real)_phones_per_addr < 1.5), s6_N234_9, 0.017333908));

s6_N234_7 :=  __common__( map(trim(C_BORN_USA) = ''     => 0.086018609,
              ((real)c_born_usa < 41.5) => 0.016771653,
                                           0.086018609));

s6_N234_6 :=  __common__( map(trim(C_RNT750_P) = ''      => 0.031435834,
              ((real)c_rnt750_p < 37.35) => -0.013392778,
                                            0.031435834));

s6_N234_5 :=  __common__( map(trim(C_LAR_FAM) = ''      => s6_N234_7,
              ((real)c_lar_fam < 130.5) => s6_N234_6,
                                           s6_N234_7));

s6_N234_4 :=  __common__( if(((real)_addrs_15yr < 6.5), s6_N234_5, s6_N234_8));

s6_N234_3 :=  __common__( if(((real)_rel_criminal_total < 3.5), -0.00039550754, s6_N234_4));

s6_N234_2 :=  __common__( if(((real)c_blue_col < 0.1), -0.031849608, s6_N234_3));

s6_N234_1 :=  __common__( if(trim(C_BLUE_COL) != '', s6_N234_2, 0.027163457));

s6_N235_8 :=  __common__( map(trim(C_LAR_FAM) = ''     => 0.039151586,
              ((real)c_lar_fam < 94.5) => 0.001290887,
                                          0.039151586));

s6_N235_7 :=  __common__( if(((real)add3_source_count < 3.5), s6_N235_8, -0.012732422));

s6_N235_6 :=  __common__( if(((real)c_retired2 < 92.5), -0.0096280955, s6_N235_7));

s6_N235_5 :=  __common__( if(trim(C_RETIRED2) != '', s6_N235_6, 0.072820567));

s6_N235_4 :=  __common__( if(((real)_add_risk < 0.5), s6_N235_5, 0.034487424));

s6_N235_3 :=  __common__( if(((real)add1_source_count < 1.5), 0.021697058, s6_N235_4));

s6_N235_2 :=  __common__( if(((real)avg_lres < 15.5), 0.027294912, s6_N235_3));

s6_N235_1 :=  __common__( if(((real)_inq_count03_cap3 < 2.5), -0.0018939282, s6_N235_2));

s6_N236_10 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.02762819, -0.019677081));

s6_N236_9 :=  __common__( if(((real)rc_addrcount < 2.5), -0.027517103, -0.012644129));

s6_N236_8 :=  __common__( if(((real)add2_lres < 107.5), 0.0041685231, -0.0042724812));

s6_N236_7 :=  __common__( map(trim(C_MED_HVAL) = ''          => -0.021259586,
              ((integer)c_med_hval < 419445) => s6_N236_8,
                                                -0.021259586));

s6_N236_6 :=  __common__( map(trim(C_MED_AGE) = ''    => s6_N236_7,
              ((real)c_med_age < 8.5) => -0.018463541,
                                         s6_N236_7));

s6_N236_5 :=  __common__( if(((real)ssn_lowissue_age < 33.1887), s6_N236_6, s6_N236_9));

s6_N236_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), s6_N236_5, 0.0071130446));

s6_N236_3 :=  __common__( map(trim(C_HHSIZE) = ''      => s6_N236_10,
              ((real)c_hhsize < 4.005) => s6_N236_4,
                                          s6_N236_10));

s6_N236_2 :=  __common__( if(((real)c_hval_1001k_p < 20.9), s6_N236_3, 0.041349609));

s6_N236_1 :=  __common__( if(trim(C_HVAL_1001K_P) != '', s6_N236_2, -0.00086789236));

s6_N237_9 :=  __common__( map(trim(C_YOUNG) = ''      => -0.00049063009,
              ((real)c_young < 14.85) => -0.017454009,
                                         -0.00049063009));

s6_N237_8 :=  __common__( if(((real)_nas < 2.5), s6_N237_9, 0.012992535));

s6_N237_7 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.061215994,
              ((real)c_sfdu_p < 96.35) => -0.0049782819,
                                          0.061215994));

s6_N237_6 :=  __common__( if(((real)_ams_income_level < 2.5), 0.0032624608, 0.054484133));

s6_N237_5 :=  __common__( map((prof_license_category in ['1', '3', '4', '5']) => s6_N237_6,
              (prof_license_category in ['0', '2'])           => 0.06953764,
                                                                 s6_N237_6));

s6_N237_4 :=  __common__( map(trim(C_LAR_FAM) = ''      => s6_N237_7,
              ((real)c_lar_fam < 127.5) => s6_N237_5,
                                           s6_N237_7));

s6_N237_3 :=  __common__( if(((real)add2_nhood_vacant_properties < 9.5), -0.0075766412, s6_N237_4));

s6_N237_2 :=  __common__( if(((real)c_rentocc_p < 5.05), s6_N237_3, s6_N237_8));

s6_N237_1 :=  __common__( if(trim(C_RENTOCC_P) != '', s6_N237_2, -0.0012478087));

s6_N238_9 :=  __common__( map(trim(C_CHILD) = ''      => -0.0026438946,
              ((real)c_child < 26.85) => -0.029324588,
                                         -0.0026438946));

s6_N238_8 :=  __common__( map(trim(C_LOWINC) = ''      => 0.040632127,
              ((real)c_lowinc < 56.85) => 0.002032511,
                                          0.040632127));

s6_N238_7 :=  __common__( map(trim(C_LOWINC) = ''     => -0.019955407,
              ((real)c_lowinc < 59.5) => s6_N238_8,
                                         -0.019955407));

s6_N238_6 :=  __common__( map(trim(C_INC_15K_P) = ''     => 0.02353603,
              ((real)c_inc_15k_p < 39.9) => s6_N238_7,
                                            0.02353603));

s6_N238_5 :=  __common__( map(trim(C_LOW_ED) = ''      => s6_N238_9,
              ((real)c_low_ed < 65.25) => s6_N238_6,
                                          s6_N238_9));

s6_N238_4 :=  __common__( map(trim(C_SPAN_LANG) = ''     => s6_N238_5,
              ((real)c_span_lang < 48.5) => -0.011124851,
                                            s6_N238_5));

s6_N238_3 :=  __common__( map(trim(C_MED_AGE) = ''      => 0.032716238,
              ((real)c_med_age < 198.5) => s6_N238_4,
                                           0.032716238));

s6_N238_2 :=  __common__( if(((real)c_easiqlife < 173.5), s6_N238_3, 0.033155306));

s6_N238_1 :=  __common__( if(trim(C_EASIQLIFE) != '', s6_N238_2, -0.014183158));

s6_N239_9 :=  __common__( map(trim(C_FAMMAR18_P) = ''     => 0.024291144,
              ((real)c_fammar18_p < 19.6) => -0.020104296,
                                             0.024291144));

s6_N239_8 :=  __common__( if(((real)rc_addrcount < 2.5), 0.027520895, s6_N239_9));

s6_N239_7 :=  __common__( map(trim(C_LOW_HVAL) = ''     => 0.023230353,
              ((real)c_low_hval < 27.1) => -0.010009568,
                                           0.023230353));

s6_N239_6 :=  __common__( map(trim(C_BORN_USA) = ''     => 0.003810846,
              ((real)c_born_usa < 19.5) => s6_N239_7,
                                           0.003810846));

s6_N239_5 :=  __common__( map(trim(C_LOWINC) = ''      => 0.034522507,
              ((real)c_lowinc < 56.85) => s6_N239_6,
                                          0.034522507));

s6_N239_4 :=  __common__( map(trim(C_LOWINC) = ''      => -0.016790798,
              ((real)c_lowinc < 58.35) => s6_N239_5,
                                          -0.016790798));

s6_N239_3 :=  __common__( map(trim(C_INC_15K_P) = ''      => s6_N239_8,
              ((integer)c_inc_15k_p < 35) => s6_N239_4,
                                             s6_N239_8));

s6_N239_2 :=  __common__( if(((real)c_hval_100k_p < 43.85), s6_N239_3, -0.017826801));

s6_N239_1 :=  __common__( if(trim(C_HVAL_100K_P) != '', s6_N239_2, -0.026519423));


s6_tnscore :=  __common__( sum(s6_N0_1, s6_N1_1, s6_N2_1, s6_N3_1, s6_N4_1, s6_N5_1, s6_N6_1, s6_N7_1, s6_N8_1, s6_N9_1, s6_N10_1, s6_N11_1, s6_N12_1, s6_N13_1, s6_N14_1, s6_N15_1, s6_N16_1, s6_N17_1, s6_N18_1, s6_N19_1, s6_N20_1, s6_N21_1, s6_N22_1, s6_N23_1, s6_N24_1, s6_N25_1, s6_N26_1, s6_N27_1, s6_N28_1, s6_N29_1, s6_N30_1, s6_N31_1, s6_N32_1, s6_N33_1, s6_N34_1, s6_N35_1, s6_N36_1, s6_N37_1, s6_N38_1, s6_N39_1, s6_N40_1, s6_N41_1, s6_N42_1, s6_N43_1, s6_N44_1, s6_N45_1, s6_N46_1, s6_N47_1, s6_N48_1, s6_N49_1, s6_N50_1, s6_N51_1, s6_N52_1, s6_N53_1, s6_N54_1, s6_N55_1, s6_N56_1, s6_N57_1, s6_N58_1, s6_N59_1, s6_N60_1, s6_N61_1, s6_N62_1, s6_N63_1, s6_N64_1, s6_N65_1, s6_N66_1, s6_N67_1, s6_N68_1, s6_N69_1, s6_N70_1, s6_N71_1, s6_N72_1, s6_N73_1, s6_N74_1, s6_N75_1, s6_N76_1, s6_N77_1, s6_N78_1, s6_N79_1, s6_N80_1, s6_N81_1, s6_N82_1, s6_N83_1, s6_N84_1, s6_N85_1, s6_N86_1, s6_N87_1, s6_N88_1, s6_N89_1, s6_N90_1, s6_N91_1, s6_N92_1, s6_N93_1, s6_N94_1, s6_N95_1, s6_N96_1, s6_N97_1, s6_N98_1, s6_N99_1, s6_N100_1, s6_N101_1, s6_N102_1, s6_N103_1, s6_N104_1, s6_N105_1, s6_N106_1, s6_N107_1, s6_N108_1, s6_N109_1, s6_N110_1, s6_N111_1, s6_N112_1, s6_N113_1, s6_N114_1, s6_N115_1, s6_N116_1, s6_N117_1, s6_N118_1, s6_N119_1, s6_N120_1, s6_N121_1, s6_N122_1, s6_N123_1, s6_N124_1, s6_N125_1, s6_N126_1, s6_N127_1, s6_N128_1, s6_N129_1, s6_N130_1, s6_N131_1, s6_N132_1, s6_N133_1, s6_N134_1, s6_N135_1, s6_N136_1, s6_N137_1, s6_N138_1, s6_N139_1, s6_N140_1, s6_N141_1, s6_N142_1, s6_N143_1, s6_N144_1, s6_N145_1, s6_N146_1, s6_N147_1, s6_N148_1, s6_N149_1, s6_N150_1, s6_N151_1, s6_N152_1, s6_N153_1, s6_N154_1, s6_N155_1, s6_N156_1, s6_N157_1, s6_N158_1, s6_N159_1, s6_N160_1, s6_N161_1, s6_N162_1, s6_N163_1, s6_N164_1, s6_N165_1, s6_N166_1, s6_N167_1, s6_N168_1, s6_N169_1, s6_N170_1, s6_N171_1, s6_N172_1, s6_N173_1, s6_N174_1, s6_N175_1, s6_N176_1, s6_N177_1, s6_N178_1, s6_N179_1, s6_N180_1, s6_N181_1, s6_N182_1, s6_N183_1, s6_N184_1, s6_N185_1, s6_N186_1, s6_N187_1, s6_N188_1, s6_N189_1, s6_N190_1, s6_N191_1, s6_N192_1, s6_N193_1, s6_N194_1, s6_N195_1, s6_N196_1, s6_N197_1, s6_N198_1, s6_N199_1, s6_N200_1, s6_N201_1, s6_N202_1, s6_N203_1, s6_N204_1, s6_N205_1, s6_N206_1, s6_N207_1, s6_N208_1, s6_N209_1, s6_N210_1, s6_N211_1, s6_N212_1, s6_N213_1, s6_N214_1, s6_N215_1, s6_N216_1, s6_N217_1, s6_N218_1, s6_N219_1, s6_N220_1, s6_N221_1, s6_N222_1, s6_N223_1, s6_N224_1, s6_N225_1, s6_N226_1, s6_N227_1, s6_N228_1, s6_N229_1, s6_N230_1, s6_N231_1, s6_N232_1, s6_N233_1, s6_N234_1, s6_N235_1, s6_N236_1, s6_N237_1, s6_N238_1, s6_N239_1));

s6_score0 :=  __common__( exp(s6_tnscore));
s6_expsum :=  __common__( exp(s6_tnscore) + exp(-s6_tnscore));
s6_prob0 :=  __common__( s6_score0 / s6_expsum);

s6_base 	:=  __common__( 700);
s6_odds 	:=  __common__( 1/200);
s6_point 	:=  __common__( -50);

s6_FP40_raw :=  __common__( round(s6_point*(ln(s6_prob0/(1-s6_prob0)) - ln(s6_odds) - ln(6))/ln(2) + s6_base));
















// start of treenet segment 7 code

s7_N0_8 :=  __common__( if((combo_dobscore < 95), -1.3315499, -1.3956869));

s7_N0_7 :=  __common__( if(((real)_ssncount < 0.5), -1.1626337, s7_N0_8));

s7_N0_6 :=  __common__( if(((real)add_bestmatch_level < 1.5), -1.3285298, -1.1948347));

s7_N0_5 :=  __common__( if(((real)c_fammar_p < 50.05), -1.0901563, s7_N0_6));

s7_N0_4 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N0_5, -1.3450457));

s7_N0_3 :=  __common__( if(((real)attr_num_nonderogs90 < 5.5), s7_N0_4, -1.0889058));

s7_N0_2 :=  __common__( if(((integer)lname_eda_sourced < 0.5), s7_N0_3, -1.3429205));

s7_N0_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N0_2, s7_N0_7));

s7_N1_7 :=  __common__( if((combo_dobscore < 80), 0.086331944, -0.0055582839));

s7_N1_6 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.23258233, 0.06135349));

s7_N1_5 :=  __common__( if(((real)_ssncount < 0.5), s7_N1_6, s7_N1_7));

s7_N1_4 :=  __common__( if(((real)_ssns_per_addr < 9.5), 0.1100571, 0.21101289));

s7_N1_3 :=  __common__( if(((real)combined_age < 40.5), 0.083736697, s7_N1_4));

s7_N1_2 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N1_3, 0.022527371));

s7_N1_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N1_2, s7_N1_5));

s7_N2_7 :=  __common__( if(((real)rc_addrcount < 2.5), 0.019518159, -0.0089237753));

s7_N2_6 :=  __common__( if((combo_dobscore < 80), 0.078191916, s7_N2_7));

s7_N2_5 :=  __common__( if(((real)_ssncount < 0.5), 0.10434579, s7_N2_6));

s7_N2_4 :=  __common__( if(((real)_ssns_per_addr < 9.5), 0.087504231, 0.13977662));

s7_N2_3 :=  __common__( if(((real)age < 37.5), 0.055649776, s7_N2_4));

s7_N2_2 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N2_3, 0.012298248));

s7_N2_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N2_2, s7_N2_5));

s7_N3_8 :=  __common__( if(((real)combined_age < 49.5), 0.0001800446, 0.059670721));

s7_N3_7 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), s7_N3_8, 0.1048315));

s7_N3_6 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N3_7, -0.0087697847));

s7_N3_5 :=  __common__( if((combo_dobscore < 80), 0.065701752, s7_N3_6));

s7_N3_4 :=  __common__( if(((real)_ssncount < 0.5), 0.089682595, s7_N3_5));

s7_N3_3 :=  __common__( if(((real)c_fammar_p < 69.45), 0.098971571, 0.036641316));

s7_N3_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N3_3, 0.0087781047));

s7_N3_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N3_2, s7_N3_4));

s7_N4_8 :=  __common__( if(((real)combined_age < 73.5), -0.0077530054, 0.024755337));

s7_N4_7 :=  __common__( if(((real)_ssn_score < 2.5), s7_N4_8, 0.062703081));

s7_N4_6 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.070690912, s7_N4_7));

s7_N4_5 :=  __common__( if(((real)c_fammar_p < 69.05), 0.082628381, 0.037590884));

s7_N4_4 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N4_5, 0.034631091));

s7_N4_3 :=  __common__( if(((real)combined_age < 70.5), s7_N4_4, 0.14571629));

s7_N4_2 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N4_3, 0.0081708528));

s7_N4_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N4_2, s7_N4_6));

s7_N5_8 :=  __common__( if(((real)_ssncount < 0.5), 0.065869633, 0.0001842595));

s7_N5_7 :=  __common__( if(((real)age < 68.5), s7_N5_8, 0.075975496));

s7_N5_6 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N5_7, -0.011653651));

s7_N5_5 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.065114212, s7_N5_6));

s7_N5_4 :=  __common__( if(((real)combined_age < 56.5), 0.028428123, 0.079114995));

s7_N5_3 :=  __common__( if(((real)c_fammar_p < 48.15), 0.092030057, s7_N5_4));

s7_N5_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N5_3, 0.021980071));

s7_N5_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N5_2, s7_N5_5));

s7_N6_8 :=  __common__( if((combo_dobscore < 98), 0.028843907, -0.0059368863));

s7_N6_7 :=  __common__( if(((real)_ssns_per_addr < 9.5), 0.017733537, 0.064805824));

s7_N6_6 :=  __common__( if(((real)c_fammar_p < 60.85), 0.077294813, s7_N6_7));

s7_N6_5 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N6_6, 0.027530029));

s7_N6_4 :=  __common__( if(((real)attr_num_nonderogs30 < 2.5), 0.0012767777, s7_N6_5));

s7_N6_3 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N6_4, s7_N6_8));

s7_N6_2 :=  __common__( if(((real)_adls_per_phone < 0.5), 0.10187921, 0.050086959));

s7_N6_1 :=  __common__( if(((real)_ssncount < 0.5), s7_N6_2, s7_N6_3));

s7_N7_7 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.077415833, 0.017397046));

s7_N7_6 :=  __common__( if(((real)combined_age < 78.5), -0.0078787687, 0.034148511));

s7_N7_5 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.02862157, s7_N7_6));

s7_N7_4 :=  __common__( if(((real)_nas < 2.5), s7_N7_5, s7_N7_7));

s7_N7_3 :=  __common__( if(((real)_nas < 1.5), 0.021076688, 0.091646247));

s7_N7_2 :=  __common__( if(((real)add2_naprop < 3.5), s7_N7_3, 0.066563657));

s7_N7_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N7_2, s7_N7_4));

s7_N8_7 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.041176287, -0.0061324859));

s7_N8_6 :=  __common__( if(((real)_ssns_per_addr < 8.5), 0.049740583, 0.090929399));

s7_N8_5 :=  __common__( if(((real)add2_naprop < 3.5), 0.025439222, s7_N8_6));

s7_N8_4 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.098769202, s7_N8_5));

s7_N8_3 :=  __common__( if(((integer)_nas < 2), 0.005477766, 0.062292725));

s7_N8_2 :=  __common__( if(((real)attr_num_nonderogs30 < 3.5), s7_N8_3, s7_N8_4));

s7_N8_1 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N8_2, s7_N8_7));

s7_N9_9 :=  __common__( if(((real)c_fammar_p < 83.65), 0.077523017, 0.021626527));

s7_N9_8 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N9_9, -0.029281154));

s7_N9_7 :=  __common__( if(((real)c_robbery < 175.5), -0.0080587507, 0.016601561));

s7_N9_6 :=  __common__( if(trim(C_ROBBERY) != '', s7_N9_7, -0.0057006817));

s7_N9_5 :=  __common__( if((combo_dobscore < 98), 0.026110359, s7_N9_6));

s7_N9_4 :=  __common__( if(((real)_ssns_per_addr < 9.5), 0.024514586, 0.054120994));

s7_N9_3 :=  __common__( if(((real)attr_num_nonderogs90 < 2.5), -0.0029145809, s7_N9_4));

s7_N9_2 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N9_3, s7_N9_5));

s7_N9_1 :=  __common__( if(((real)_nas < 2.5), s7_N9_2, s7_N9_8));

s7_N10_9 :=  __common__( if(((real)age < 85.5), -0.0066997287, 0.060519787));

s7_N10_8 :=  __common__( if(((real)c_fammar_p < 50.45), 0.03507347, s7_N10_9));

s7_N10_7 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N10_8, 0.0012812983));

s7_N10_6 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.04095327, s7_N10_7));

s7_N10_5 :=  __common__( if(((real)combined_age < 70.5), 0.012768459, 0.062426283));

s7_N10_4 :=  __common__( if(((real)ver_src_p < 0.5), 0.033597055, 0.059697314));

s7_N10_3 :=  __common__( if(((real)c_fammar_p < 69.15), s7_N10_4, s7_N10_5));

s7_N10_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N10_3, 0.010830659));

s7_N10_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N10_2, s7_N10_6));

s7_N11_8 :=  __common__( if(((real)c_ownocc_p < 63.65), 0.065832565, 0.024228753));

s7_N11_7 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N11_8, -0.027862499));

s7_N11_6 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.071769467, 0.022416318));

s7_N11_5 :=  __common__( if(((real)_rel_educationunder12_count < 0.5), -0.0021495909, s7_N11_6));

s7_N11_4 :=  __common__( if(((real)combined_age < 59.5), s7_N11_5, 0.045928706));

s7_N11_3 :=  __common__( if(((real)attr_num_nonderogs180 < 6.5), s7_N11_4, 0.061117668));

s7_N11_2 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N11_3, -0.0062278788));

s7_N11_1 :=  __common__( if(((real)_nas < 2.5), s7_N11_2, s7_N11_7));

s7_N12_9 :=  __common__( if(((real)c_robbery < 162.5), -0.0076752309, 0.011713672));

s7_N12_8 :=  __common__( if(trim(C_ROBBERY) != '', s7_N12_9, -0.00097470207));

s7_N12_7 :=  __common__( if(((real)age < 80.5), s7_N12_8, 0.043418847));

s7_N12_6 :=  __common__( if(((real)input_dob_match_level < 4.5), 0.033703028, s7_N12_7));

s7_N12_5 :=  __common__( if(((real)c_fammar_p < 69.4), 0.040651705, 0.019852943));

s7_N12_4 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N12_5, 0.016332277));

s7_N12_3 :=  __common__( if(((real)_adls_per_addr_c6 < 4.5), s7_N12_4, 0.069958248));

s7_N12_2 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N12_3, -0.0025661887));

s7_N12_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N12_2, s7_N12_6));

s7_N13_8 :=  __common__( if(((real)age < 70.5), -0.0072792901, 0.015437746));

s7_N13_7 :=  __common__( if(((real)_nas < 2.5), s7_N13_8, 0.035776708));

s7_N13_6 :=  __common__( if(((integer)add2_eda_sourced < 0.5), 0.023467545, 0.056693771));

s7_N13_5 :=  __common__( if(((real)c_fammar_p < 43.35), 0.077760544, s7_N13_6));

s7_N13_4 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N13_5, 0.054864446));

s7_N13_3 :=  __common__( if(((real)_ssncount < 0.5), 0.047445465, 0.00031345036));

s7_N13_2 :=  __common__( if(((real)combined_age < 36.5), s7_N13_3, s7_N13_4));

s7_N13_1 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N13_2, s7_N13_7));

s7_N14_8 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.054674022, 0.025595629));

s7_N14_7 :=  __common__( if((combo_dobscore < 95), 0.02261873, -0.0066974967));

s7_N14_6 :=  __common__( if(((real)c_assault < 164.5), 0.017479043, 0.048807898));

s7_N14_5 :=  __common__( if(trim(C_ASSAULT) != '', s7_N14_6, 0.033901863));

s7_N14_4 :=  __common__( if(((real)combined_age < 70.5), s7_N14_5, 0.072893805));

s7_N14_3 :=  __common__( if(((real)attr_num_nonderogs90 < 3.5), 0.00054583793, s7_N14_4));

s7_N14_2 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N14_3, s7_N14_7));

s7_N14_1 :=  __common__( if(((real)_nas < 2.5), s7_N14_2, s7_N14_8));

s7_N15_9 :=  __common__( if(((real)c_bel_edu < 147.5), 0.02176485, 0.059370908));

s7_N15_8 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N15_9, -0.032640584));

s7_N15_7 :=  __common__( if((rc_dirsaddr_lastscore < 83), 0.060065302, 0.017767478));

s7_N15_6 :=  __common__( if(((real)c_robbery < 179.5), s7_N15_7, 0.089208879));

s7_N15_5 :=  __common__( if(trim(C_ROBBERY) != '', s7_N15_6, 0.037001733));

s7_N15_4 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0052827322, 0.021926365));

s7_N15_3 :=  __common__( if(((real)combined_age < 51.5), s7_N15_4, s7_N15_5));

s7_N15_2 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N15_3, -0.0052503213));

s7_N15_1 :=  __common__( if(((real)_nas < 2.5), s7_N15_2, s7_N15_8));

s7_N16_9 :=  __common__( if(((real)c_robbery < 153.5), -0.0088611169, 0.0094900141));

s7_N16_8 :=  __common__( if(trim(C_ROBBERY) != '', s7_N16_9, -0.008507021));

s7_N16_7 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), 0.0081312905, 0.046585726));

s7_N16_6 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N16_7, s7_N16_8));

s7_N16_5 :=  __common__( if(((real)add2_naprop < 3.5), 0.0015913403, 0.027911577));

s7_N16_4 :=  __common__( map(trim(C_ASSAULT) = ''      => 0.031986613,
             ((real)c_assault < 161.5) => s7_N16_5,
                                          0.031986613));

s7_N16_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s7_N16_4, 0.048583009));

s7_N16_2 :=  __common__( if(trim(C_ASSAULT) != '', s7_N16_3, -0.0018186003));

s7_N16_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N16_2, s7_N16_6));

s7_N17_8 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.045918866, 0.012066672));

s7_N17_7 :=  __common__( if(((real)attr_num_nonderogs30 < 3.5), 0.0097551473, 0.05019588));

s7_N17_6 :=  __common__( if(((real)c_robbery < 134.5), 0.0091212628, 0.041646288));

s7_N17_5 :=  __common__( if(trim(C_ROBBERY) != '', s7_N17_6, 0.026797692));

s7_N17_4 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0056388879, s7_N17_5));

s7_N17_3 :=  __common__( if(((real)combined_age < 60.5), s7_N17_4, s7_N17_7));

s7_N17_2 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N17_3, -0.0049381014));

s7_N17_1 :=  __common__( if(((real)_nas < 2.5), s7_N17_2, s7_N17_8));

s7_N18_9 :=  __common__( if(((real)combined_age < 78.5), -0.0070476103, 0.027466035));

s7_N18_8 :=  __common__( if(((real)c_fammar_p < 35.35), 0.051579858, 0.0045348775));

s7_N18_7 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N18_8, 0.010721531));

s7_N18_6 :=  __common__( if(((real)combined_age < 60.5), s7_N18_7, 0.033208291));

s7_N18_5 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N18_6, s7_N18_9));

s7_N18_4 :=  __common__( if(((real)c_ownocc_p < 8.5), 0.076668242, 0.018177126));

s7_N18_3 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N18_4, 0.032876618));

s7_N18_2 :=  __common__( if(((real)_nas < 2.5), s7_N18_3, 0.042227948));

s7_N18_1 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N18_2, s7_N18_5));

s7_N19_10 :=  __common__( if(((real)combined_age < 73.5), -0.0080806533, 0.018700851));

s7_N19_9 :=  __common__( if((combo_dobscore < 98), 0.016989149, s7_N19_10));

s7_N19_8 :=  __common__( if(((real)c_sfdu_p < 11.65), 0.024223219, s7_N19_9));

s7_N19_7 :=  __common__( if(trim(C_SFDU_P) != '', s7_N19_8, -0.018279414));

s7_N19_6 :=  __common__( if(((real)_ssn_score < 2.5), s7_N19_7, 0.029708821));

s7_N19_5 :=  __common__( if(((real)ssn_lowissue_age < 14.9767), 0.018078279, 0.053252813));

s7_N19_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N19_5, 0.057929292));

s7_N19_3 :=  __common__( if(((real)c_cartheft < 142.5), 0.0086990431, s7_N19_4));

s7_N19_2 :=  __common__( if(trim(C_CARTHEFT) != '', s7_N19_3, 0.01375211));

s7_N19_1 :=  __common__( if(((real)add1_source_count < 2.5), s7_N19_2, s7_N19_6));

s7_N20_8 :=  __common__( if((combo_dobscore < 80), 0.019849859, -0.0038679764));

s7_N20_7 :=  __common__( if(((real)c_fammar_p < 49.65), 0.031580628, s7_N20_8));

s7_N20_6 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N20_7, -0.0084496603));

s7_N20_5 :=  __common__( if(((real)rc_dirsaddr_lastscore < 84.5), 0.038588369, 0.012777015));

s7_N20_4 :=  __common__( if(((real)age < 39.5), 0.002064574, s7_N20_5));

s7_N20_3 :=  __common__( if(((integer)_nas < 2), s7_N20_4, 0.03646198));

s7_N20_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s7_N20_3, 0.049136994));

s7_N20_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N20_2, s7_N20_6));

s7_N21_8 :=  __common__( map(trim(C_MANY_CARS) = ''     => 0.0071442766,
             ((real)c_many_cars < 99.5) => 0.040598444,
                                           0.0071442766));

s7_N21_7 :=  __common__( if(((real)_phones_per_adl < 0.5), -0.0021504098, 0.024049321));

s7_N21_6 :=  __common__( if(((real)combined_age < 78.5), s7_N21_7, 0.067845351));

s7_N21_5 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N21_6, -0.0082624425));

s7_N21_4 :=  __common__( if(((real)rc_addrcount < 3.5), 0.038630507, 0.0097076379));

s7_N21_3 :=  __common__( if(((real)c_fammar_p < 49.65), s7_N21_4, s7_N21_5));

s7_N21_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N21_3, -0.0073055341));

s7_N21_1 :=  __common__( if(((real)_nas < 2.5), s7_N21_2, s7_N21_8));

s7_N22_8 :=  __common__( if(((real)phn_cellpager < 0.5), 0.0083454439, 0.084208015));

s7_N22_7 :=  __common__( if(((real)age < 67.5), 6.4959274e-005, s7_N22_8));

s7_N22_6 :=  __common__( if(((real)_rel_incomeunder25_count < 4.5), 0.014505346, 0.056498958));

s7_N22_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s7_N22_6, 0.076499458));

s7_N22_4 :=  __common__( if(((real)c_fammar_p < 66.05), s7_N22_5, s7_N22_7));

s7_N22_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N22_4, 0.02775309));

s7_N22_2 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N22_3, -0.008629324));

s7_N22_1 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.023622312, s7_N22_2));

s7_N23_8 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.010078746,
             ((real)c_civ_emp < 54.95) => 0.040525978,
                                          0.010078746));

s7_N23_7 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N23_8, -0.0026750037));

s7_N23_6 :=  __common__( if(((real)c_robbery < 162.5), -0.0065620491, s7_N23_7));

s7_N23_5 :=  __common__( if(trim(C_ROBBERY) != '', s7_N23_6, -0.018142733));

s7_N23_4 :=  __common__( if((combo_dobscore < 95), 0.018922782, s7_N23_5));

s7_N23_3 :=  __common__( if((combo_dobscore < 98), 0.060721465, 0.033844422));

s7_N23_2 :=  __common__( if(((real)_nap < 3.5), 0.010597395, s7_N23_3));

s7_N23_1 :=  __common__( if(((real)add1_source_count < 1.5), s7_N23_2, s7_N23_4));

s7_N24_8 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.041719881, 0.015398149));

s7_N24_7 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), -0.004313894, s7_N24_8));

s7_N24_6 :=  __common__( if(((real)_rel_educationunder12_count < 0.5), 0.01243375, 0.047718029));

s7_N24_5 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N24_6, 0.007854504));

s7_N24_4 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s7_N24_5, 0.055162025));

s7_N24_3 :=  __common__( if(((real)c_fammar_p < 35.55), 0.05094271, s7_N24_4));

s7_N24_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N24_3, 0.044955103));

s7_N24_1 :=  __common__( if(((real)add1_source_count < 2.5), s7_N24_2, s7_N24_7));

s7_N25_7 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.047189383, 0.0083006058));

s7_N25_6 :=  __common__( if(((real)_rel_educationunder12_count < 1.5), -0.0015978536, 0.023025782));

s7_N25_5 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N25_6, -0.010797222));

s7_N25_4 :=  __common__( if(((real)combined_age < 73.5), s7_N25_5, s7_N25_7));

s7_N25_3 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), 0.0077143402, 0.033953667));

s7_N25_2 :=  __common__( if(((real)add1_source_count < 1.5), 0.040220575, s7_N25_3));

s7_N25_1 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N25_2, s7_N25_4));

s7_N26_9 :=  __common__( if(((real)age < 67.5), 0.01035542, 0.086023608));

s7_N26_8 :=  __common__( if(((real)_phone_score < 2.5), -0.0053185096, s7_N26_9));

s7_N26_7 :=  __common__( if(((real)c_robbery < 147.5), 0.018629933, 0.042682746));

s7_N26_6 :=  __common__( if(trim(C_ROBBERY) != '', s7_N26_7, 0.050171099));

s7_N26_5 :=  __common__( if(((real)c_burglary < 165.5), 0.0027164653, 0.043157968));

s7_N26_4 :=  __common__( if(trim(C_BURGLARY) != '', s7_N26_5, 0.046946296));

s7_N26_3 :=  __common__( if(((real)add_bestmatch_level < 0.5), s7_N26_4, s7_N26_6));

s7_N26_2 :=  __common__( if(((real)_rel_educationunder12_count < 0.5), 0.0033603121, s7_N26_3));

s7_N26_1 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N26_2, s7_N26_8));

s7_N27_8 :=  __common__( if(((real)add1_unit_count < 2.5), 0.012714478, 0.040458379));

s7_N27_7 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.049813908, 0.018095451));

s7_N27_6 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), -0.0053635727, 0.022587037));

s7_N27_5 :=  __common__( if(((real)c_many_cars < 30.5), 0.015616411, s7_N27_6));

s7_N27_4 :=  __common__( if(trim(C_MANY_CARS) != '', s7_N27_5, -0.0032042994));

s7_N27_3 :=  __common__( if(((real)age < 81.5), s7_N27_4, s7_N27_7));

s7_N27_2 :=  __common__( if(((real)_nap < 5.5), s7_N27_3, 0.047092845));

s7_N27_1 :=  __common__( if(((real)_nas < 2.5), s7_N27_2, s7_N27_8));

s7_N28_8 :=  __common__( if(((real)_rel_incomeunder25_count < 4.5), 0.016126119, 0.070689123));

s7_N28_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), -0.0028497365, s7_N28_8));

s7_N28_6 :=  __common__( if(((real)rc_combo_sec_rangescore < 177.5), 0.0962412, 0.03786937));

s7_N28_5 :=  __common__( map(trim(C_RECENT_MOV) = ''     => 0.019703865,
             ((real)c_recent_mov < 56.5) => s7_N28_6,
                                            0.019703865));

s7_N28_4 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N28_5, 0.0027737604));

s7_N28_3 :=  __common__( if(((real)c_fammar_p < 49.65), s7_N28_4, s7_N28_7));

s7_N28_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N28_3, 0.0093664596));

s7_N28_1 :=  __common__( if(((real)_nas < 2.5), s7_N28_2, 0.023420921));

s7_N29_7 :=  __common__( if((rc_dirsaddr_lastscore < 95), 0.07755523, 0.029079594));

s7_N29_6 :=  __common__( if(((real)input_dob_match_level < 6.5), 0.054262861, 0.023822976));

s7_N29_5 :=  __common__( if(((real)add1_lres < 0.5), 0.026255322, -0.00070559035));

s7_N29_4 :=  __common__( if(((real)_rel_educationunder12_count < 3.5), s7_N29_5, s7_N29_6));

s7_N29_3 :=  __common__( if(((real)combined_age < 70.5), s7_N29_4, s7_N29_7));

s7_N29_2 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N29_3, -0.0076214863));

s7_N29_1 :=  __common__( if((combo_dobscore < 65), 0.020999862, s7_N29_2));

s7_N30_9 :=  __common__( if(((real)combined_age < 78.5), 0.01020266, 0.072705226));

s7_N30_8 :=  __common__( if(((real)_phone_score < 1.5), -0.0060571181, s7_N30_9));

s7_N30_7 :=  __common__( if(((real)c_born_usa < 58.5), 0.032025801, 0.009155525));

s7_N30_6 :=  __common__( if(trim(C_BORN_USA) != '', s7_N30_7, 0.039142567));

s7_N30_5 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 2.5), s7_N30_6, 0.057289426));

s7_N30_4 :=  __common__( if(((real)c_white_col < 20.15), 0.027437474, -0.0018550231));

s7_N30_3 :=  __common__( if(trim(C_WHITE_COL) != '', s7_N30_4, -0.0065626958));

s7_N30_2 :=  __common__( if(((real)ver_src_p < 0.5), s7_N30_3, s7_N30_5));

s7_N30_1 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N30_2, s7_N30_8));

s7_N31_7 :=  __common__( if(((real)add1_source_count < 4.5), 0.045763403, 0.0053225461));

s7_N31_6 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N31_7, 0.081053855));

s7_N31_5 :=  __common__( if(((real)combined_age < 74.5), -0.0038343098, s7_N31_6));

s7_N31_4 :=  __common__( if(((real)add_bestmatch_level < 0.5), -4.6752367e-005, 0.02504111));

s7_N31_3 :=  __common__( if(((integer)_nas < 2), s7_N31_4, 0.025489113));

s7_N31_2 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N31_3, s7_N31_5));

s7_N31_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s7_N31_2, 0.041770151));

s7_N32_8 :=  __common__( if(((real)input_dob_match_level < 4.5), 0.027506995, -0.0038906562));

s7_N32_7 :=  __common__( if(((real)add1_unit_count < 2.5), s7_N32_8, 0.038579033));

s7_N32_6 :=  __common__( map(trim(C_RENTAL) = ''      => 0.067290474,
             ((real)c_rental < 174.5) => 0.025725549,
                                         0.067290474));

s7_N32_5 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N32_6, 0.022525948));

s7_N32_4 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.00043579638, s7_N32_5));

s7_N32_3 :=  __common__( if(((real)c_born_usa < 33.5), s7_N32_4, -0.0044505083));

s7_N32_2 :=  __common__( if(trim(C_BORN_USA) != '', s7_N32_3, -0.00215725));

s7_N32_1 :=  __common__( if(((real)_nas < 2.5), s7_N32_2, s7_N32_7));

s7_N33_8 :=  __common__( if(((real)_rel_educationunder12_count < 2.5), 0.015035985, 0.078514249));

s7_N33_7 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N33_8, 0.07549943));

s7_N33_6 :=  __common__( if(((real)combined_age < 68.5), 0.0034371835, s7_N33_7));

s7_N33_5 :=  __common__( if(((real)c_cartheft < 144.5), -0.0070312928, s7_N33_6));

s7_N33_4 :=  __common__( if(trim(C_CARTHEFT) != '', s7_N33_5, -0.00029430983));

s7_N33_3 :=  __common__( if(((real)_nap < 2.5), 0.003984344, 0.044023066));

s7_N33_2 :=  __common__( if(((real)_rel_educationunder12_count < 2.5), 0.0085059939, s7_N33_3));

s7_N33_1 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N33_2, s7_N33_4));

s7_N34_7 :=  __common__( if(((real)add1_unit_count < 1.5), 0.01475218, 0.051184989));

s7_N34_6 :=  __common__( if(((real)add1_source_count < 3.5), 0.027300291, 0.004007701));

s7_N34_5 :=  __common__( if(((real)_rel_educationunder12_count < 1.5), -0.0041310594, s7_N34_6));

s7_N34_4 :=  __common__( if(((real)_ssn_score < 1.5), s7_N34_5, s7_N34_7));

s7_N34_3 :=  __common__( if(((real)add1_lres < 0.5), 0.042879725, 0.014261053));

s7_N34_2 :=  __common__( if(((real)_add_risk < 0.5), s7_N34_3, 0.0011767598));

s7_N34_1 :=  __common__( if(((real)add1_source_count < 1.5), s7_N34_2, s7_N34_4));

s7_N35_8 :=  __common__( if(((real)c_high_ed < 21.2), 0.066573124, -0.00073688155));

s7_N35_7 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N35_8, 0.29543552));

s7_N35_6 :=  __common__( if(((real)combo_dobcount < 5.5), 0.037248063, 0.013487634));

s7_N35_5 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.00072081251, s7_N35_6));

s7_N35_4 :=  __common__( if(((real)combined_age < 68.5), 0.0049247402, 0.044362421));

s7_N35_3 :=  __common__( if(((real)_phone_score < 1.5), -0.0064513711, s7_N35_4));

s7_N35_2 :=  __common__( if(((real)_nap < 3.5), s7_N35_3, s7_N35_5));

s7_N35_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s7_N35_2, s7_N35_7));

s7_N36_9 :=  __common__( map(trim(C_RECENT_MOV) = ''     => 0.0082424429,
             ((real)c_recent_mov < 59.5) => 0.046975626,
                                            0.0082424429));

s7_N36_8 :=  __common__( if(((real)_ssn_score < 1.5), -0.0042176722, s7_N36_9));

s7_N36_7 :=  __common__( if(((real)_nap < 5.5), s7_N36_8, 0.039414028));

s7_N36_6 :=  __common__( if(((real)_addrs_last12 < 0.5), -0.0017868564, 0.034339478));

s7_N36_5 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N36_6, 0.022259949));

s7_N36_4 :=  __common__( if(((real)age < 76.5), s7_N36_5, 0.070558871));

s7_N36_3 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.0066670752,
             ((real)c_civ_emp < 52.05) => s7_N36_4,
                                          0.0066670752));

s7_N36_2 :=  __common__( if(((real)c_fammar_p < 65.75), s7_N36_3, s7_N36_7));

s7_N36_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N36_2, -0.0047945197));

s7_N37_8 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.04081094, 0.015017757));

s7_N37_7 :=  __common__( map(trim(C_RECENT_MOV) = ''     => 0.0076819841,
             ((real)c_recent_mov < 62.5) => 0.052831798,
                                            0.0076819841));

s7_N37_6 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.0024779799,
             ((real)c_fammar_p < 47.85) => s7_N37_7,
                                           -0.0024779799));

s7_N37_5 :=  __common__( if(((real)_phones_per_adl < 0.5), s7_N37_6, s7_N37_8));

s7_N37_4 :=  __common__( if(((real)_nas < 1.5), s7_N37_5, 0.023037747));

s7_N37_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N37_4, -0.0032038878));

s7_N37_2 :=  __common__( if(((real)combined_age < 68.5), s7_N37_3, 0.032340622));

s7_N37_1 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N37_2, -0.0060455077));

s7_N38_8 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0048934651, 0.054201913));

s7_N38_7 :=  __common__( if(((real)_ssn_score < 1.5), 0.0044017554, 0.04188216));

s7_N38_6 :=  __common__( map(trim(C_BORN_USA) = ''     => -0.0061295885,
             ((real)c_born_usa < 43.5) => s7_N38_7,
                                          -0.0061295885));

s7_N38_5 :=  __common__( if(((real)_rel_felony_total < 1.5), s7_N38_6, 0.024814768));

s7_N38_4 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N38_5, 0.0038753874));

s7_N38_3 :=  __common__( if(((real)_nap < 5.5), s7_N38_4, s7_N38_8));

s7_N38_2 :=  __common__( if(((real)age < 81.5), s7_N38_3, 0.026853509));

s7_N38_1 :=  __common__( if((combo_dobscore < 80), 0.015578937, s7_N38_2));

s7_N39_8 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), 0.00076303591, 0.035384664));

s7_N39_7 :=  __common__( map(trim(C_CHILD) = ''      => 0.039828115,
             ((real)c_child < 20.85) => 0.10993936,
                                        0.039828115));

s7_N39_6 :=  __common__( if(((real)rc_addrcount < 2.5), 0.030537574, 0.023248364));

s7_N39_5 :=  __common__( if(((real)_phones_per_adl_c6 < 0.5), s7_N39_6, s7_N39_7));

s7_N39_4 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N39_5, 0.0077999384));

s7_N39_3 :=  __common__( if(((real)c_born_usa < 44.5), s7_N39_4, s7_N39_8));

s7_N39_2 :=  __common__( if(trim(C_BORN_USA) != '', s7_N39_3, 0.015129571));

s7_N39_1 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0043431488, s7_N39_2));

s7_N40_9 :=  __common__( if(((real)combo_dobcount < 4.5), 0.062963229, 0.033745254));

s7_N40_8 :=  __common__( if(((real)c_fammar_p < 85.95), s7_N40_9, -0.012636368));

s7_N40_7 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N40_8, 0.066045545));

s7_N40_6 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), -0.0035356728, 0.028904977));

s7_N40_5 :=  __common__( if(((real)_nap < 2.5), 0.0024650214, 0.040732556));

s7_N40_4 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0037824342, s7_N40_5));

s7_N40_3 :=  __common__( if(((real)c_born_usa < 11.5), s7_N40_4, s7_N40_6));

s7_N40_2 :=  __common__( if(trim(C_BORN_USA) != '', s7_N40_3, -0.0082155432));

s7_N40_1 :=  __common__( if(((real)_rel_felony_total < 1.5), s7_N40_2, s7_N40_7));

s7_N41_8 :=  __common__( map(trim(C_BLUE_EMPL) = ''     => 0.049296685,
             ((real)c_blue_empl < 30.5) => 0.0010482256,
                                           0.049296685));

s7_N41_7 :=  __common__( map(trim(C_INC_15K_P) = ''      => 0.039363079,
             ((real)c_inc_15k_p < 39.05) => 0.003904141,
                                            0.039363079));

s7_N41_6 :=  __common__( if(((real)_nas < 2.5), s7_N41_7, 0.027125248));

s7_N41_5 :=  __common__( if(((real)combined_age < 73.5), s7_N41_6, s7_N41_8));

s7_N41_4 :=  __common__( if(((real)c_cartheft < 144.5), -0.0050804954, s7_N41_5));

s7_N41_3 :=  __common__( if(trim(C_CARTHEFT) != '', s7_N41_4, 0.0015040157));

s7_N41_2 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), 0.0076827519, 0.030579143));

s7_N41_1 :=  __common__( if((combo_dobscore < 95), s7_N41_2, s7_N41_3));

s7_N42_9 :=  __common__( if(((real)_infutor_nap < 2.5), 0.0013790201, 0.037809854));

s7_N42_8 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N42_9, 0.049422603));

s7_N42_7 :=  __common__( map(trim(C_MED_AGE) = ''     => 0.014714429,
             ((real)c_med_age < 17.5) => 0.068962358,
                                         0.014714429));

s7_N42_6 :=  __common__( if(((real)c_bigapt_p < 62.85), -0.0030138803, s7_N42_7));

s7_N42_5 :=  __common__( if(trim(C_BIGAPT_P) != '', s7_N42_6, -0.018210433));

s7_N42_4 :=  __common__( if(((real)combined_age < 70.5), s7_N42_5, s7_N42_8));

s7_N42_3 :=  __common__( if(((real)c_med_age < 48.5), 0.03067595, 0.0073618726));

s7_N42_2 :=  __common__( if(trim(C_MED_AGE) != '', s7_N42_3, -0.027444655));

s7_N42_1 :=  __common__( if(((real)input_dob_match_level < 3.5), s7_N42_2, s7_N42_4));

s7_N43_8 :=  __common__( if(((real)_inq_peraddr_cap8 < 3.5), 0.016806101, 0.077294228));

s7_N43_7 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N43_8, -0.0013512665));

s7_N43_6 :=  __common__( if(((real)combined_age < 52.5), -0.0068158014, s7_N43_7));

s7_N43_5 :=  __common__( if(((real)c_inc_15k_p < 29.65), s7_N43_6, 0.01863406));

s7_N43_4 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N43_5, -0.003042549));

s7_N43_3 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.041127741, 0.016629275));

s7_N43_2 :=  __common__( if(((real)_nap < 3.5), 0.00034102283, s7_N43_3));

s7_N43_1 :=  __common__( if(((real)add1_source_count < 1.5), s7_N43_2, s7_N43_4));

s7_N44_9 :=  __common__( if(((real)c_bel_edu < 108.5), 0.0061681304, 0.042699622));

s7_N44_8 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N44_9, 0.04894046));

s7_N44_7 :=  __common__( if(((real)combined_age < 73.5), 0.0096481091, 0.045446488));

s7_N44_6 :=  __common__( if(((real)rc_addrcount < 3.5), 0.061358776, 0.0097323878));

s7_N44_5 :=  __common__( if(((real)c_mort_indx < 22.5), s7_N44_6, s7_N44_7));

s7_N44_4 :=  __common__( if(trim(C_MORT_INDX) != '', s7_N44_5, 0.038141451));

s7_N44_3 :=  __common__( if(((real)_nap < 3.5), 0.00067116582, s7_N44_4));

s7_N44_2 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0050999434, s7_N44_3));

s7_N44_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s7_N44_2, s7_N44_8));

s7_N45_9 :=  __common__( map(trim(C_CIV_EMP) = ''     => 0.097452373,
             ((real)c_civ_emp < 62.1) => 0.034169868,
                                         0.097452373));

s7_N45_8 :=  __common__( if(((real)_ssns_per_addr < 7.5), -0.013037691, s7_N45_9));

s7_N45_7 :=  __common__( if(((real)c_high_ed < 14.75), s7_N45_8, 0.0084086821));

s7_N45_6 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N45_7, 0.054181178));

s7_N45_5 :=  __common__( if(((real)add1_unit_count < 1.5), -0.0059359031, 0.022386263));

s7_N45_4 :=  __common__( if(((real)c_lar_fam < 154.5), s7_N45_5, 0.037111434));

s7_N45_3 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N45_4, -0.027732292));

s7_N45_2 :=  __common__( if(((real)_nas < 2.5), -0.00041047872, s7_N45_3));

s7_N45_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s7_N45_2, s7_N45_6));

s7_N46_8 :=  __common__( if(((real)combined_age < 68.5), -0.0041473602, 0.010401546));

s7_N46_7 :=  __common__( if(((real)_num_purchase36 < 0.5), 0.0077946961, 0.055107452));

s7_N46_6 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => s7_N46_7,
             ((real)c_fammar18_p < 27.75) => 0.050568952,
                                             s7_N46_7));

s7_N46_5 :=  __common__( if(((real)c_hhsize < 2.905), 0.0025645431, s7_N46_6));

s7_N46_4 :=  __common__( if(trim(C_HHSIZE) != '', s7_N46_5, 0.011852396));

s7_N46_3 :=  __common__( if(((real)add1_source_count < 2.5), s7_N46_4, s7_N46_8));

s7_N46_2 :=  __common__( if(((real)source_count < 5.5), -0.00097923453, 0.021427358));

s7_N46_1 :=  __common__( if((combo_dobscore < 95), s7_N46_2, s7_N46_3));

s7_N47_9 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), 0.070396617, 0.020317005));

s7_N47_8 :=  __common__( if(((real)phn_cellpager < 0.5), 0.026152456, 0.00043854788));

s7_N47_7 :=  __common__( if(((real)combined_age < 68.5), s7_N47_8, s7_N47_9));

s7_N47_6 :=  __common__( if(((real)_nap < 5.5), -0.0027321087, 0.026489744));

s7_N47_5 :=  __common__( if(((real)_phone_score < 1.5), s7_N47_6, s7_N47_7));

s7_N47_4 :=  __common__( map(trim(C_BORN_USA) = ''     => 0.0073591717,
             ((real)c_born_usa < 28.5) => 0.037950386,
                                          0.0073591717));

s7_N47_3 :=  __common__( if(((real)add1_building_area2 > NULL), 0.01283699, s7_N47_4));

s7_N47_2 :=  __common__( if(trim(C_BORN_USA) != '', s7_N47_3, 0.018896221));

s7_N47_1 :=  __common__( if(((real)add1_lres < 1.5), s7_N47_2, s7_N47_5));

s7_N48_10 :=  __common__( map(trim(C_INC_35K_P) = ''      => 0.030588919,
              ((real)c_inc_35k_p < 12.05) => 0.089927295,
                                             0.030588919));

s7_N48_9 :=  __common__( if(((real)c_high_ed < 14.75), s7_N48_10, 0.0078988537));

s7_N48_8 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N48_9, -0.029165968));

s7_N48_7 :=  __common__( if(((real)c_med_inc < 18.5), 0.036857495, 0.0091167436));

s7_N48_6 :=  __common__( if(trim(C_MED_INC) != '', s7_N48_7, 0.012417983));

s7_N48_5 :=  __common__( if(((real)c_burglary < 147.5), 0.0039411042, 0.0560011));

s7_N48_4 :=  __common__( if(trim(C_BURGLARY) != '', s7_N48_5, 0.1573631));

s7_N48_3 :=  __common__( if(((real)_ssn_score < 1.5), -0.0029958264, s7_N48_4));

s7_N48_2 :=  __common__( if(((real)_inq_collection_count < 0.5), s7_N48_3, s7_N48_6));

s7_N48_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s7_N48_2, s7_N48_8));

s7_N49_8 :=  __common__( if(((real)_phone_score < 2.5), 0.0056754275, 0.043059712));

s7_N49_7 :=  __common__( if(((real)combined_age < 63.5), -0.0028139392, s7_N49_8));

s7_N49_6 :=  __common__( if(((real)avg_lres < 29.5), 0.042408647, 0.011646163));

s7_N49_5 :=  __common__( if(((real)c_fammar_p < 40.95), s7_N49_6, s7_N49_7));

s7_N49_4 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N49_5, -0.0088210434));

s7_N49_3 :=  __common__( if(((real)_add_risk < 0.5), 0.034881511, 0.0068143931));

s7_N49_2 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N49_3, -0.0019171663));

s7_N49_1 :=  __common__( if(((real)add1_lres < 0.5), s7_N49_2, s7_N49_4));

s7_N50_9 :=  __common__( if(((real)c_ab_av_edu < 48.5), 0.045888987, 0.0090077394));

s7_N50_8 :=  __common__( if(trim(C_AB_AV_EDU) != '', s7_N50_9, -0.026238976));

s7_N50_7 :=  __common__( if(((real)combined_age < 51.5), s7_N50_8, 0.048177948));

s7_N50_6 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N50_7, 0.006366071));

s7_N50_5 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.023033024,
             ((real)c_span_lang < 195.5) => -0.0027019728,
                                            0.023033024));

s7_N50_4 :=  __common__( map(trim(C_LOW_HVAL) = ''      => 0.061873162,
             ((integer)c_low_hval < 75) => 0.012491653,
                                           0.061873162));

s7_N50_3 :=  __common__( if(((real)c_sfdu_p < 4.25), s7_N50_4, s7_N50_5));

s7_N50_2 :=  __common__( if(trim(C_SFDU_P) != '', s7_N50_3, -0.0030703954));

s7_N50_1 :=  __common__( if(((real)_rel_felony_count < 0.5), s7_N50_2, s7_N50_6));

s7_N51_7 :=  __common__( if(((real)_rel_felony_count < 1.5), 0.01022833, 0.048766291));

s7_N51_6 :=  __common__( if(((real)_inq_perssn < 1.5), s7_N51_7, 0.059916175));

s7_N51_5 :=  __common__( if(((real)_nap < 2.5), -0.0034647095, s7_N51_6));

s7_N51_4 :=  __common__( if(((real)combined_age < 82.5), -0.001557606, 0.018504459));

s7_N51_3 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), s7_N51_4, s7_N51_5));

s7_N51_2 :=  __common__( if(((real)_rel_educationunder12_count < 2.5), 0.011364801, 0.032386095));

s7_N51_1 :=  __common__( if(((real)add1_lres < 1.5), s7_N51_2, s7_N51_3));

s7_N52_9 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.014117476,
             ((real)c_civ_emp < 53.15) => 0.069416085,
                                          0.014117476));

s7_N52_8 :=  __common__( if(((real)_adls_per_addr_c6 < 2.5), 0.014775699, s7_N52_9));

s7_N52_7 :=  __common__( if(((real)source_count < 2.5), 0.043945666, s7_N52_8));

s7_N52_6 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N52_7, -0.00038382169));

s7_N52_5 :=  __common__( if(((real)combined_age < 86.5), -0.0033644681, 0.02073899));

s7_N52_4 :=  __common__( if(((real)_nap < 5.5), s7_N52_5, 0.027403414));

s7_N52_3 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 2.5), s7_N52_4, 0.01703854));

s7_N52_2 :=  __common__( if(((real)c_span_lang < 179.5), s7_N52_3, s7_N52_6));

s7_N52_1 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N52_2, -0.0025109806));

s7_N53_8 :=  __common__( if((rc_dirsaddr_lastscore < 62), 0.057283718, 0.016143966));

s7_N53_7 :=  __common__( map(trim(C_WHITE_COL) = ''      => 0.079688065,
             ((real)c_white_col < 60.95) => 0.014880388,
                                            0.079688065));

s7_N53_6 :=  __common__( if(((integer)add2_eda_sourced < 0.5), 0.00042484544, s7_N53_7));

s7_N53_5 :=  __common__( if(((real)c_lar_fam < 157.5), s7_N53_6, s7_N53_8));

s7_N53_4 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N53_5, 0.00010869287));

s7_N53_3 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.0210368, s7_N53_4));

s7_N53_2 :=  __common__( if(((real)combined_age < 40.5), -0.0069708844, 0.0026923042));

s7_N53_1 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), s7_N53_2, s7_N53_3));

s7_N54_7 :=  __common__( if(((real)_adls_per_phone_c6 < 0.5), 0.054722213, 0.0022942512));

s7_N54_6 :=  __common__( if(((real)combined_age < 68.5), 0.010351617, 0.043956576));

s7_N54_5 :=  __common__( if(((real)add1_unit_count < 355.5), -0.0027503515, 0.019195611));

s7_N54_4 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), s7_N54_5, s7_N54_6));

s7_N54_3 :=  __common__( if(((real)age < 86.5), s7_N54_4, s7_N54_7));

s7_N54_2 :=  __common__( if(((real)_altlname < 0.5), 0.0080880076, 0.033637227));

s7_N54_1 :=  __common__( if((combo_dobscore < 98), s7_N54_2, s7_N54_3));

s7_N55_9 :=  __common__( map(trim(C_AB_AV_EDU) = ''     => 0.074009573,
             ((real)c_ab_av_edu < 87.5) => 0.024734775,
                                           0.074009573));

s7_N55_8 :=  __common__( map(trim(C_TOTCRIME) = ''      => s7_N55_9,
             ((real)c_totcrime < 126.5) => 0.0066560098,
                                           s7_N55_9));

s7_N55_7 :=  __common__( map(trim(C_HVAL_100K_P) = ''    => 0.030402083,
             ((real)c_hval_100k_p < 8.4) => -0.019173724,
                                            0.030402083));

s7_N55_6 :=  __common__( if(((real)_rel_prop_owned_count < 0.5), 0.045416887, s7_N55_7));

s7_N55_5 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N55_6, 0.0091035001));

s7_N55_4 :=  __common__( map(trim(C_SFDU_P) = ''      => -0.0022471914,
             ((real)c_sfdu_p < 12.15) => 0.0098078445,
                                         -0.0022471914));

s7_N55_3 :=  __common__( if(((real)_rel_felony_count < 0.5), s7_N55_4, s7_N55_5));

s7_N55_2 :=  __common__( if(((real)c_inc_15k_p < 39.35), s7_N55_3, s7_N55_8));

s7_N55_1 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N55_2, -0.0017079564));

s7_N56_8 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), 0.013737181, 0.052465641));

s7_N56_7 :=  __common__( map(trim(C_CARTHEFT) = ''      => 0.031626536,
             ((real)c_cartheft < 135.5) => -0.00056687432,
                                           0.031626536));

s7_N56_6 :=  __common__( if((combo_dobscore < 98), 0.0082039447, -0.0028917657));

s7_N56_5 :=  __common__( if(((real)add1_lres < 2.5), 0.028366864, 0.0072914228));

s7_N56_4 :=  __common__( map(trim(C_AB_AV_EDU) = ''     => s7_N56_6,
             ((real)c_ab_av_edu < 46.5) => s7_N56_5,
                                           s7_N56_6));

s7_N56_3 :=  __common__( if(((real)c_inc_15k_p < 39.55), s7_N56_4, s7_N56_7));

s7_N56_2 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N56_3, 0.0014252052));

s7_N56_1 :=  __common__( if(((real)_adls_per_addr_c6 < 4.5), s7_N56_2, s7_N56_8));

s7_N57_9 :=  __common__( if(((real)c_many_cars < 63.5), 0.013950727, -0.00073047204));

s7_N57_8 :=  __common__( if(trim(C_MANY_CARS) != '', s7_N57_9, 0.019993532));

s7_N57_7 :=  __common__( if(((real)c_unattach < 125.5), 0.018685748, 0.089296598));

s7_N57_6 :=  __common__( if(trim(C_UNATTACH) != '', s7_N57_7, -0.02690432));

s7_N57_5 :=  __common__( if(((real)add2_lres < 2.5), s7_N57_6, s7_N57_8));

s7_N57_4 :=  __common__( map((prof_license_category in ['5'])                     => 0.03108438,
             (prof_license_category in ['0', '1', '2', '3', '4']) => 0.1057768,
                                                                     0.03108438));

s7_N57_3 :=  __common__( if(((real)_addrs_last24 < 3.5), 0.0092427469, s7_N57_4));

s7_N57_2 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N57_3, s7_N57_5));

s7_N57_1 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), -0.0021585767, s7_N57_2));

s7_N58_8 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0014378575, 0.039209992));

s7_N58_7 :=  __common__( if(((real)c_hhsize < 2.495), 0.0053889405, 0.047255112));

s7_N58_6 :=  __common__( if(trim(C_HHSIZE) != '', s7_N58_7, 0.066339932));

s7_N58_5 :=  __common__( if(((real)_inq_peraddr_cap8 < 0.5), 0.0071974279, s7_N58_6));

s7_N58_4 :=  __common__( if(((real)attr_num_nonderogs90 < 3.5), -0.0010059477, s7_N58_5));

s7_N58_3 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N58_4, 0.0013501875));

s7_N58_2 :=  __common__( if(((real)ver_src_sl < 0.5), s7_N58_3, -0.0090063595));

s7_N58_1 :=  __common__( if(((real)_nap < 5.5), s7_N58_2, s7_N58_8));

s7_N59_10 :=  __common__( if(((real)add1_lres < 6.5), 0.050285011, 0.014216345));

s7_N59_9 :=  __common__( if(((real)attr_num_nonderogs180 < 1.5), -0.024607277, -0.001042711));

s7_N59_8 :=  __common__( if(((real)_rel_bankrupt_count < 4.5), s7_N59_9, 0.020274066));

s7_N59_7 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.019662783,
             ((real)c_fammar_p < 89.05) => 0.016260392,
                                           -0.019662783));

s7_N59_6 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), s7_N59_7, 0.034360307));

s7_N59_5 :=  __common__( if(((real)attr_num_nonderogs90 < 3.5), -0.0034499945, s7_N59_6));

s7_N59_4 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N59_5, 0.039708492));

s7_N59_3 :=  __common__( if(((real)input_dob_match_level < 4.5), s7_N59_4, s7_N59_8));

s7_N59_2 :=  __common__( if(((real)c_low_hval < 72.05), s7_N59_3, s7_N59_10));

s7_N59_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N59_2, -0.0046374683));

s7_N60_8 :=  __common__( if(((real)c_robbery < 136.5), 0.010564822, 0.030728331));

s7_N60_7 :=  __common__( if(trim(C_ROBBERY) != '', s7_N60_8, 0.019376541));

s7_N60_6 :=  __common__( if(((real)combined_age < 35.5), -0.0024812511, s7_N60_7));

s7_N60_5 :=  __common__( if(((real)combined_age < 73.5), s7_N60_6, 0.036614162));

s7_N60_4 :=  __common__( if(((real)add2_nhood_vacant_properties < 20.5), 0.013845721, -0.0084682996));

s7_N60_3 :=  __common__( if(((real)_inq_peraddr_cap8 < 0.5), s7_N60_4, 0.024135541));

s7_N60_2 :=  __common__( if(((real)add1_source_count < 1.5), s7_N60_3, -0.0016895108));

s7_N60_1 :=  __common__( if(((real)_phone_score < 1.5), s7_N60_2, s7_N60_5));

s7_N61_9 :=  __common__( if(((real)c_rnt250_p < 3.2), 0.048773262, -0.00072019405));

s7_N61_8 :=  __common__( if(trim(C_RNT250_P) != '', s7_N61_9, 0.017550848));

s7_N61_7 :=  __common__( if(((real)_nap < 5.5), 1.0623727e-005, s7_N61_8));

s7_N61_6 :=  __common__( if(((real)_nap < 2.5), 0.0054178266, 0.032886988));

s7_N61_5 :=  __common__( if(((real)add2_source_count < 4.5), 0.00071541086, s7_N61_6));

s7_N61_4 :=  __common__( if((add1_unit_count < 37), s7_N61_5, 0.030283916));

s7_N61_3 :=  __common__( if(((real)c_ab_av_edu < 175.5), s7_N61_4, -0.014805737));

s7_N61_2 :=  __common__( if(trim(C_AB_AV_EDU) != '', s7_N61_3, 0.015343428));

s7_N61_1 :=  __common__( if(((real)add1_source_count < 1.5), s7_N61_2, s7_N61_7));

s7_N62_9 :=  __common__( if(((real)_altlname < 0.5), 0.015349654, 0.070745039));

s7_N62_8 :=  __common__( map(trim(C_FAMMAR_P) = ''     => 0.0027660185,
             ((real)c_fammar_p < 35.7) => 0.03845566,
                                          0.0027660185));

s7_N62_7 :=  __common__( map(trim(C_APT20) = ''      => s7_N62_9,
             ((real)c_apt20 < 169.5) => s7_N62_8,
                                        s7_N62_9));

s7_N62_6 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.05178237, 0.015931841));

s7_N62_5 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), -0.0004731317, s7_N62_6));

s7_N62_4 :=  __common__( if(((real)combined_age < 39.5), -0.0073279568, s7_N62_5));

s7_N62_3 :=  __common__( map(trim(C_LAR_FAM) = ''      => s7_N62_7,
             ((real)c_lar_fam < 143.5) => s7_N62_4,
                                          s7_N62_7));

s7_N62_2 :=  __common__( if(((real)c_med_hhinc < 14289.5), 0.036634194, s7_N62_3));

s7_N62_1 :=  __common__( if(trim(C_MED_HHINC) != '', s7_N62_2, 0.0015428577));

s7_N63_8 :=  __common__( if(((real)ssn_issued18 < 0.5), 0.015271684, 0.050548567));

s7_N63_7 :=  __common__( if(((real)_adls_per_phone < 0.5), s7_N63_8, 0.0092307122));

s7_N63_6 :=  __common__( if(((real)c_span_lang < 182.5), 0.011878799, 0.050947293));

s7_N63_5 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N63_6, 0.01413274));

s7_N63_4 :=  __common__( if(((real)rc_dirsaddr_lastscore < 47.5), s7_N63_5, -0.00092447366));

s7_N63_3 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), s7_N63_4, s7_N63_7));

s7_N63_2 :=  __common__( if(((real)_nap < 5.5), s7_N63_3, 0.038421697));

s7_N63_1 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), -0.0023683192, s7_N63_2));

s7_N64_7 :=  __common__( map(trim(C_BORN_USA) = ''      => -0.010445563,
             ((real)c_born_usa < 116.5) => 0.024325442,
                                           -0.010445563));
s7_N64_6 :=  __common__( if(((real)add3_source_count < 1.5), -0.0026968484, 0.037621556));
s7_N64_5 :=  __common__( if(((real)input_dob_match_level < 5.5), s7_N64_6, 0.0054122079));
s7_N64_4 :=  __common__( if(((real)_nap < 2.5), 0.001192847, 0.04254645));
s7_N64_3 :=  __common__( if(((real)combined_age < 86.5), -0.0029585921, s7_N64_4));
s7_N64_2 :=  __common__( if(((real)_inq_collection_count < 0.5), s7_N64_3, s7_N64_5));
s7_N64_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N64_2, s7_N64_7));

s7_N65_9 :=  __common__( if((combo_dobscore < 92), 0.033012509, 0.0080289421));
s7_N65_8 :=  __common__( map(trim(C_CHILD) = ''     => 0.034179744,
             ((real)c_child < 29.2) => s7_N65_9,
                                       0.034179744));
s7_N65_7 :=  __common__( if(((real)_rel_bankrupt_count < 0.5), 0.0082980139, 0.053339368));
s7_N65_6 :=  __common__( if(((real)_nap < 5.5), 0.0025553419, 0.035017949));
s7_N65_5 :=  __common__( if(((real)_inq_peraddr_cap8 < 7.5), s7_N65_6, 0.050983097));
s7_N65_4 :=  __common__( if(((real)age < 73.5), s7_N65_5, s7_N65_7));
s7_N65_3 :=  __common__( if(((real)_ssns_per_addr < 9.5), -0.0036882203, s7_N65_4));
s7_N65_2 :=  __common__( if(((real)c_apt20 < 186.5), s7_N65_3, s7_N65_8));
s7_N65_1 :=  __common__( if(trim(C_APT20) != '', s7_N65_2, -0.0071077366));

s7_N66_10 :=  __common__( if(((real)ssn_lowissue_age < 13.5309), 0.032402541, -0.00091881197));
s7_N66_9 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N66_10, 0.035596597));
s7_N66_8 :=  __common__( map((prof_license_category in ['0', '2', '3', '5']) => -0.00789256,
             (prof_license_category in ['1', '4'])           => 0.080101516,
                                                                -0.00789256));
s7_N66_7 :=  __common__( if(((real)source_count < 6.5), s7_N66_8, s7_N66_9));
s7_N66_6 :=  __common__( map(trim(C_MED_AGE) = ''      => s7_N66_7,
             ((integer)c_med_age < 35) => 0.027841229,
                                          s7_N66_7));
s7_N66_5 :=  __common__( if(((real)input_dob_match_level < 4.5), s7_N66_6, -0.0016955339));
s7_N66_4 :=  __common__( if(((real)avg_lres < 37.5), 0.043708356, 0.019026505));
s7_N66_3 :=  __common__( map(trim(C_RECENT_MOV) = ''     => 0.0048334214,
             ((real)c_recent_mov < 60.5) => s7_N66_4,
                                            0.0048334214));
s7_N66_2 :=  __common__( if(((real)c_fammar_p < 49.65), s7_N66_3, s7_N66_5));
s7_N66_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N66_2, -0.0066555125));

s7_N67_9 :=  __common__( map(trim(C_POP_18_24_P) = ''     => 0.034185047,
             ((real)c_pop_18_24_p < 8.85) => 0.012277482,
                                             0.034185047));

s7_N67_8 :=  __common__( if(((real)_phones_per_adl < 0.5), 0.0022688767, s7_N67_9));

s7_N67_7 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N67_8, -0.0029355068));

s7_N67_6 :=  __common__( if(((real)age < 33.5), -0.0069390444, s7_N67_7));

s7_N67_5 :=  __common__( if(((real)_infutor_nap < 2.5), 0.052840337, 0.011310315));

s7_N67_4 :=  __common__( map(trim(C_RNT250_P) = ''     => -0.001335404,
             ((integer)c_rnt250_p < 5) => s7_N67_5,
                                          -0.001335404));

s7_N67_3 :=  __common__( if(((real)add1_source_count < 2.5), s7_N67_4, 0.0084567949));

s7_N67_2 :=  __common__( if(((real)c_born_usa < 11.5), s7_N67_3, s7_N67_6));

s7_N67_1 :=  __common__( if(trim(C_BORN_USA) != '', s7_N67_2, -0.002387934));

s7_N68_9 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.044343783, -0.0052813173));

s7_N68_8 :=  __common__( map(trim(C_BIGAPT_P) = ''      => s7_N68_9,
             ((real)c_bigapt_p < 28.65) => 0.0041034139,
                                           s7_N68_9));

s7_N68_7 :=  __common__( if(((real)_adls_per_addr_c6 < 3.5), s7_N68_8, 0.033063209));

s7_N68_6 :=  __common__( if(((real)avg_lres < 11.5), 0.038573605, s7_N68_7));

s7_N68_5 :=  __common__( map(trim(C_POP_18_24_P) = ''     => 0.027416671,
             ((real)c_pop_18_24_p < 8.95) => 0.0066304479,
                                             0.027416671));

s7_N68_4 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N68_5, -0.00041302246));

s7_N68_3 :=  __common__( if(((real)_phones_per_adl < 0.5), -0.0039927098, s7_N68_4));

s7_N68_2 :=  __common__( if(((real)c_lar_fam < 152.5), s7_N68_3, s7_N68_6));

s7_N68_1 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N68_2, -0.00083468414));

s7_N69_8 :=  __common__( map(trim(C_RNT750_P) = ''      => 0.046936156,
             ((real)c_rnt750_p < 13.05) => 0.0030580614,
                                           0.046936156));

s7_N69_7 :=  __common__( map(trim(C_MED_INC) = ''    => 0.0024520214,
             ((real)c_med_inc < 8.5) => s7_N69_8,
                                        0.0024520214));

s7_N69_6 :=  __common__( map(trim(C_HVAL_40K_P) = ''    => 0.068779171,
             ((real)c_hval_40k_p < 4.4) => 5.9600676e-005,
                                           0.068779171));

s7_N69_5 :=  __common__( if(((real)add_bestmatch_level < 1.5), s7_N69_6, 0.060529728));

s7_N69_4 :=  __common__( if(((real)c_recent_mov < 14.5), s7_N69_5, s7_N69_7));

s7_N69_3 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N69_4, 0.047838478));

s7_N69_2 :=  __common__( if(((real)add1_lres < 2.5), 0.024844535, s7_N69_3));

s7_N69_1 :=  __common__( if(((real)_rel_educationunder12_count < 1.5), -0.0010719132, s7_N69_2));

s7_N70_9 :=  __common__( if(((real)_rel_incomeunder50_count < 4.5), 0.0036432839, 0.032368478));

s7_N70_8 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N70_9, 0.033745244));

s7_N70_7 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), -0.00012371737, 0.01413236));

s7_N70_6 :=  __common__( map(trim(C_TOTCRIME) = ''     => 0.0044633812,
             ((real)c_totcrime < 41.5) => 0.056891151,
                                          0.0044633812));

s7_N70_5 :=  __common__( if((combo_dobscore < 92), s7_N70_6, s7_N70_7));

s7_N70_4 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.0032493314, s7_N70_5));

s7_N70_3 :=  __common__( if(((real)combined_age < 78.5), s7_N70_4, s7_N70_8));

s7_N70_2 :=  __common__( if(((real)c_hval_20k_p < 69.55), s7_N70_3, 0.041004817));

s7_N70_1 :=  __common__( if(trim(C_HVAL_20K_P) != '', s7_N70_2, -0.0067987124));

s7_N71_8 :=  __common__( map(trim(C_FAMMAR18_P) = ''     => 0.065480713,
             ((real)c_fammar18_p < 35.1) => 0.019525665,
                                            0.065480713));

s7_N71_7 :=  __common__( map(trim(C_HIGH_ED) = ''      => -0.00090849426,
             ((real)c_high_ed < 14.85) => s7_N71_8,
                                          -0.00090849426));

s7_N71_6 :=  __common__( if(((real)c_highinc < 3.05), 0.049447257, 0.010436921));

s7_N71_5 :=  __common__( if(trim(C_HIGHINC) != '', s7_N71_6, -0.0021573807));

s7_N71_4 :=  __common__( if(((integer)add1_avm_med < 322887), -0.00025953462, 0.015766769));

s7_N71_3 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.0029705618, s7_N71_4));

s7_N71_2 :=  __common__( if(((real)add1_unit_count < 446.5), s7_N71_3, s7_N71_5));

s7_N71_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s7_N71_2, s7_N71_7));

s7_N72_8 :=  __common__( map(trim(C_UNEMPL) = ''      => 0.089217627,
             ((real)c_unempl < 135.5) => 0.02281706,
                                         0.089217627));

s7_N72_7 :=  __common__( if(((real)c_unattach < 154.5), 0.0064125135, s7_N72_8));

s7_N72_6 :=  __common__( if(trim(C_UNATTACH) != '', s7_N72_7, 0.076880982));

s7_N72_5 :=  __common__( if(((real)_phone_score < 1.5), -0.0016000858, s7_N72_6));

s7_N72_4 :=  __common__( if(((real)_rel_incomeunder25_count < 1.5), 0.016054439, 0.045745891));

s7_N72_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0076088589, s7_N72_4));

s7_N72_2 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), 0.0039508473, s7_N72_3));

s7_N72_1 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N72_2, s7_N72_5));

s7_N73_9 :=  __common__( if(((integer)c_ab_av_edu < 112), 0.048435967, -0.00046055082));

s7_N73_8 :=  __common__( if(trim(C_AB_AV_EDU) != '', s7_N73_9, 0.16614744));

s7_N73_7 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.02230992, 0.0015428389));

s7_N73_6 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0025010103, s7_N73_7));

s7_N73_5 :=  __common__( map(trim(C_RENTOCC_P) = ''      => -0.0009359756,
             ((real)c_rentocc_p < 28.45) => 0.078250572,
                                            -0.0009359756));

s7_N73_4 :=  __common__( if(((real)c_hhsize < 4.515), -0.0026616099, s7_N73_5));

s7_N73_3 :=  __common__( if(trim(C_HHSIZE) != '', s7_N73_4, -0.0025023474));

s7_N73_2 :=  __common__( if(((real)_phones_per_addr < 2.5), s7_N73_3, s7_N73_6));

s7_N73_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s7_N73_2, s7_N73_8));

s7_N74_7 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.048311846,
             ((integer)c_bel_edu < 95) => -0.0048203445,
                                          0.048311846));

s7_N74_6 :=  __common__( map(trim(C_RECENT_MOV) = ''     => s7_N74_7,
             ((real)c_recent_mov < 98.5) => 0.061883409,
                                            s7_N74_7));

s7_N74_5 :=  __common__( map(trim(C_HVAL_100K_P) = ''    => s7_N74_6,
             ((real)c_hval_100k_p < 1.5) => -0.000202484,
                                            s7_N74_6));

s7_N74_4 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N74_5, 0.013555928));

s7_N74_3 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), 0.0027688901, s7_N74_4));

s7_N74_2 :=  __common__( if(((real)_rel_felony_count < 1.5), -0.0021821186, 0.017252647));

s7_N74_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), s7_N74_2, s7_N74_3));

s7_N75_8 :=  __common__( if(((real)add1_unit_count < 9.5), 0.0041420808, 0.024128884));

s7_N75_7 :=  __common__( if((add2_avm_automated_valuation < 572500), s7_N75_8, 0.060333264));

s7_N75_6 :=  __common__( if(((real)avg_lres < 17.5), 0.048203224, s7_N75_7));

s7_N75_5 :=  __common__( if(((real)_wealth_index < 2.5), 0.059291971, 0.017657729));

s7_N75_4 :=  __common__( if(((real)c_fammar_p < 71.5), s7_N75_5, 0.0037361887));

s7_N75_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N75_4, -0.014649785));

s7_N75_2 :=  __common__( if(((real)add1_unit_count < 363.5), -0.00095718994, s7_N75_3));

s7_N75_1 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), s7_N75_2, s7_N75_6));

s7_N76_9 :=  __common__( if(((real)c_young < 27.75), 0.0093981083, 0.041886806));

s7_N76_8 :=  __common__( if(trim(C_YOUNG) != '', s7_N76_9, 0.11503011));

s7_N76_7 :=  __common__( if(((real)_ssn_score < 1.5), 0.00040739073, s7_N76_8));

s7_N76_6 :=  __common__( if(((real)add2_source_count < 5.5), 0.0026029845, 0.040006496));

s7_N76_5 :=  __common__( if(((real)_addrs_per_ssn < 6.5), 0.042654403, s7_N76_6));

s7_N76_4 :=  __common__( if(((real)_nap < 2.5), -0.0061855021, s7_N76_5));

s7_N76_3 :=  __common__( if(((real)c_relig_indx < 142.5), s7_N76_4, -0.0023758443));

s7_N76_2 :=  __common__( if(trim(C_RELIG_INDX) != '', s7_N76_3, -0.016627797));

s7_N76_1 :=  __common__( if(((real)add1_lres < 1.5), s7_N76_2, s7_N76_7));

s7_N77_9 :=  __common__( if(((real)c_robbery < 34.5), -0.015022582, 0.02260533));

s7_N77_8 :=  __common__( if(trim(C_ROBBERY) != '', s7_N77_9, 0.096527651));

s7_N77_7 :=  __common__( if(((real)combined_age < 70.5), 0.015800102, 0.048744151));

s7_N77_6 :=  __common__( if(((real)combo_dobcount < 2.5), 0.041917925, s7_N77_7));

s7_N77_5 :=  __common__( if(((real)c_ownocc_p < 84.85), s7_N77_6, -0.017520693));

s7_N77_4 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N77_5, 0.024545382));

s7_N77_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), -0.0022973934, 0.007656731));

s7_N77_2 :=  __common__( if(((real)_rel_felony_total < 1.5), s7_N77_3, s7_N77_4));

s7_N77_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N77_2, s7_N77_8));

s7_N78_9 :=  __common__( if(((real)rc_lnamecount < 10.5), 0.0089172418, 0.05891708));

s7_N78_8 :=  __common__( map(trim(C_HVAL_750K_P) = ''      => s7_N78_9,
             ((real)c_hval_750k_p < 13.75) => -0.0018724805,
                                              s7_N78_9));

s7_N78_7 :=  __common__( if(((real)rc_lnamecount < 1.5), 0.018699617, s7_N78_8));

s7_N78_6 :=  __common__( map(trim(C_HHSIZE) = ''     => 0.046659023,
             ((real)c_hhsize < 3.67) => 0.011992269,
                                        0.046659023));

s7_N78_5 :=  __common__( if(((real)_addrs_last90 < 1.5), s7_N78_6, 0.058783793));

s7_N78_4 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N78_5, 0.0027099986));

s7_N78_3 :=  __common__( if(((real)add_bestmatch_level < 1.5), 0.0047085696, s7_N78_4));

s7_N78_2 :=  __common__( if(((real)c_born_usa < 11.5), s7_N78_3, s7_N78_7));

s7_N78_1 :=  __common__( if(trim(C_BORN_USA) != '', s7_N78_2, -0.0055385389));

s7_N79_8 :=  __common__( if(((integer)c_burglary < 149), 0.0044338407, 0.027306651));

s7_N79_7 :=  __common__( if(trim(C_BURGLARY) != '', s7_N79_8, -0.03341854));

s7_N79_6 :=  __common__( if(((real)_inq_count < 1.5), 0.080393646, 0.032052243));

s7_N79_5 :=  __common__( if(((real)add1_lres < 62.5), 0.01412952, s7_N79_6));

s7_N79_4 :=  __common__( if(((integer)add1_avm_med < 381368), 0.010400547, s7_N79_5));

s7_N79_3 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N79_4, 0.0021888801));

s7_N79_2 :=  __common__( if(((real)_phones_per_adl_c6 < 0.5), -0.0018115778, s7_N79_3));

s7_N79_1 :=  __common__( if(((real)_nas < 2.5), s7_N79_2, s7_N79_7));

s7_N80_8 :=  __common__( if(((real)_addrs_last24 < 1.5), 0.068972545, -0.0029157494));

s7_N80_7 :=  __common__( if(((real)_prop_owned_total < 0.5), 0.014588792, 0.056126264));

s7_N80_6 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N80_7, s7_N80_8));

s7_N80_5 :=  __common__( map(trim(C_INC_35K_P) = ''     => 0.05757268,
             ((real)c_inc_35k_p < 7.95) => -0.0061731953,
                                           0.05757268));

s7_N80_4 :=  __common__( if(((real)combined_age < 39.5), -0.0058738775, 0.0020801852));

s7_N80_3 :=  __common__( if(((real)c_inc_15k_p < 48.45), s7_N80_4, s7_N80_5));

s7_N80_2 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N80_3, -0.0060527317));

s7_N80_1 :=  __common__( if(((real)_rel_felony_count < 1.5), s7_N80_2, s7_N80_6));

s7_N81_11 :=  __common__( map(trim(C_TOTSALES) = ''      => 0.014918357,
              ((real)c_totsales < 737.5) => 0.087283308,
                                            0.014918357));

s7_N81_10 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N81_11, 0.04019827));

s7_N81_9 :=  __common__( if(((real)c_recent_mov < 22.5), s7_N81_10, 0.013128452));

s7_N81_8 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N81_9, 0.0039922386));

s7_N81_7 :=  __common__( map((prof_license_category in ['0', '1', '2', '4', '5']) => 0.036570441,
             (prof_license_category in ['3'])                     => 0.20932369,
                                                                     0.036570441));

s7_N81_6 :=  __common__( if(((real)c_hhsize < 1.995), s7_N81_7, -0.0033518312));

s7_N81_5 :=  __common__( if(trim(C_HHSIZE) != '', s7_N81_6, 0.035663349));

s7_N81_4 :=  __common__( if(((real)age < 39.5), s7_N81_5, s7_N81_8));

s7_N81_3 :=  __common__( if(((real)c_lowinc < 85.6), -0.0013279885, 0.035600987));

s7_N81_2 :=  __common__( if(trim(C_LOWINC) != '', s7_N81_3, -0.009756815));

s7_N81_1 :=  __common__( if(((real)_phone_score < 1.5), s7_N81_2, s7_N81_4));

s7_N82_9 :=  __common__( if(((integer)c_med_hval < 68358), 0.048386626, 0.011773991));

s7_N82_8 :=  __common__( if(trim(C_MED_HVAL) != '', s7_N82_9, 0.076021021));

s7_N82_7 :=  __common__( if(((real)source_count < 0.5), 0.037516209, -0.00042469118));

s7_N82_6 :=  __common__( map(trim(C_CARTHEFT) = ''       => 0.0026644677,
             ((integer)c_cartheft < 114) => 0.027950937,
                                            0.0026644677));

s7_N82_5 :=  __common__( if(((real)add2_source_count < 3.5), -0.0057203615, s7_N82_6));

s7_N82_4 :=  __common__( if(((integer)c_assault < 22), 0.035723766, s7_N82_5));

s7_N82_3 :=  __common__( if(trim(C_ASSAULT) != '', s7_N82_4, 0.027850745));

s7_N82_2 :=  __common__( if((combo_dobscore < 80), s7_N82_3, s7_N82_7));

s7_N82_1 :=  __common__( if(((real)_adls_per_addr_c6 < 4.5), s7_N82_2, s7_N82_8));

s7_N83_10 :=  __common__( if(((real)c_rnt250_p < 2.5), 0.0071187866, 0.05118574));

s7_N83_9 :=  __common__( if(trim(C_RNT250_P) != '', s7_N83_10, 0.069821676));

s7_N83_8 :=  __common__( if(((real)add1_source_count < 3.5), s7_N83_9, 0.0088802145));

s7_N83_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N83_8, 0.014654229));

s7_N83_6 :=  __common__( map(trim(C_BIGAPT_P) = ''      => 0.05640864,
             ((real)c_bigapt_p < 51.45) => 0.017147525,
                                           0.05640864));

s7_N83_5 :=  __common__( if(((real)_addr_stability_v2 < 5.5), s7_N83_6, -0.011585367));

s7_N83_4 :=  __common__( if(((real)c_lowinc < 62.6), 0.0031148237, s7_N83_5));

s7_N83_3 :=  __common__( if(trim(C_LOWINC) != '', s7_N83_4, -0.029112139));

s7_N83_2 :=  __common__( if(((integer)add1_avm_med < 300794), -0.0032265158, s7_N83_3));

s7_N83_1 :=  __common__( if(((real)_rel_felony_total < 1.5), s7_N83_2, s7_N83_7));

s7_N84_7 :=  __common__( if(((real)rc_addrcount < 4.5), 0.04481531, 0.0061363185));

s7_N84_6 :=  __common__( if(((real)_inq_peraddr_cap8 < 4.5), 0.0066292676, 0.042554875));

s7_N84_5 :=  __common__( if(((integer)add1_avm_med < 300939), -0.0048871976, 0.0030400294));

s7_N84_4 :=  __common__( if(((real)_adls_per_addr_c6 < 2.5), s7_N84_5, s7_N84_6));

s7_N84_3 :=  __common__( if(((real)_rel_homeunder50_count < 1.5), 8.1784092e-005, 0.05268354));

s7_N84_2 :=  __common__( if(((real)rc_lnamecount < 1.5), s7_N84_3, s7_N84_4));

s7_N84_1 :=  __common__( if(((real)_rel_felony_count < 2.5), s7_N84_2, s7_N84_7));

s7_N85_10 :=  __common__( if(((real)add1_turnover_1yr_in < 232.5), -0.0011701446, 0.044235528));

s7_N85_9 :=  __common__( if(((real)combined_age < 87.5), -0.00083517843, s7_N85_10));

s7_N85_8 :=  __common__( map(trim(C_BORN_USA) = ''      => 0.01540249,
             ((integer)c_born_usa < 58) => 0.051293204,
                                           0.01540249));

s7_N85_7 :=  __common__( map(trim(C_NO_MOVE) = ''      => 0.04221626,
             ((real)c_no_move < 141.5) => -0.0021684874,
                                          0.04221626));

s7_N85_6 :=  __common__( if(((real)combined_age < 47.5), s7_N85_7, s7_N85_8));

s7_N85_5 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N85_6, -0.0050141498));

s7_N85_4 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 23.5), 0.043509446, s7_N85_5));

s7_N85_3 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N85_4, 0.0038554437));

s7_N85_2 :=  __common__( if(((real)c_fammar_p < 48.25), s7_N85_3, s7_N85_9));

s7_N85_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N85_2, 0.0041126967));

s7_N86_8 :=  __common__( if(((real)add2_source_count < 2.5), -0.0022441146, 0.04874142));

s7_N86_7 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.065850175,
             ((real)c_easiqlife < 139.5) => s7_N86_8,
                                            0.065850175));

s7_N86_6 :=  __common__( if(((real)_addrs_5yr < 3.5), 0.0013594446, s7_N86_7));

s7_N86_5 :=  __common__( if(((real)combo_dobcount < 4.5), s7_N86_6, 0.0081122543));

s7_N86_4 :=  __common__( if(((real)c_young < 26.85), 0.0012717061, s7_N86_5));

s7_N86_3 :=  __common__( if(trim(C_YOUNG) != '', s7_N86_4, -0.0020102868));

s7_N86_2 :=  __common__( if(((real)_nap < 5.5), s7_N86_3, 0.035164497));

s7_N86_1 :=  __common__( if(((real)add_bestmatch_level < 1.5), -0.0024524174, s7_N86_2));

s7_N87_9 :=  __common__( if(((real)c_vacant_p < 8.25), 0.01757877, 0.050929166));

s7_N87_8 :=  __common__( if(trim(C_VACANT_P) != '', s7_N87_9, -0.027802494));

s7_N87_7 :=  __common__( if(((real)combo_dobcount < 3.5), s7_N87_8, 0.0038809034));

s7_N87_6 :=  __common__( if(((real)c_relig_indx < 164.5), 0.017469403, 0.062510017));

s7_N87_5 :=  __common__( if(trim(C_RELIG_INDX) != '', s7_N87_6, -0.0264527));

s7_N87_4 :=  __common__( if((rc_dirsaddr_lastscore < 66), 0.024420051, 0.00033299853));

s7_N87_3 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N87_4, s7_N87_5));

s7_N87_2 :=  __common__( if(((real)combined_age < 64.5), -0.0021950334, s7_N87_3));

s7_N87_1 :=  __common__( if(((real)_altlname < 0.5), s7_N87_2, s7_N87_7));

s7_N88_10 :=  __common__( map(trim(C_INC_150K_P) = ''     => 0.04460615,
              ((real)c_inc_150k_p < 8.15) => -0.00095381121,
                                             0.04460615));

s7_N88_9 :=  __common__( if(((real)add2_turnover_1yr_in < 90.5), 0.078091124, s7_N88_10));

s7_N88_8 :=  __common__( if(((real)rc_addrcount < 2.5), 0.032371567, s7_N88_9));

s7_N88_7 :=  __common__( if(((real)ssn_lowissue_age < 24.6358), s7_N88_8, 0.052821478));

s7_N88_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N88_7, 0.038131412));

s7_N88_5 :=  __common__( if(((real)add1_lres < 45.5), 0.0017903988, s7_N88_6));

s7_N88_4 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N88_5, 0.00094235225));

s7_N88_3 :=  __common__( if(((real)_phones_per_adl_c6 < 0.5), -0.0016782969, s7_N88_4));

s7_N88_2 :=  __common__( if(((real)c_lar_fam < 189.5), s7_N88_3, 0.039692056));

s7_N88_1 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N88_2, -0.0089598997));

s7_N89_9 :=  __common__( if(((real)add2_lres < 13.5), 0.043004223, 0.0052120287));

s7_N89_8 :=  __common__( if(((real)age < 57.5), s7_N89_9, 0.047766457));

s7_N89_7 :=  __common__( if(((integer)lname_eda_sourced < 0.5), s7_N89_8, 0.0080149605));

s7_N89_6 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), 0.0018318155, s7_N89_7));

s7_N89_5 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.016224204, s7_N89_6));

s7_N89_4 :=  __common__( if(((real)avg_lres < 82.5), -0.0070994388, 0.0010287535));

s7_N89_3 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), s7_N89_4, s7_N89_5));

s7_N89_2 :=  __common__( if(((real)c_med_hhinc < 16009.5), 0.024227355, s7_N89_3));

s7_N89_1 :=  __common__( if(trim(C_MED_HHINC) != '', s7_N89_2, 0.00768632));

s7_N90_10 :=  __common__( if(((real)ssn_lowissue_age < 31.825), 0.0098193058, 0.052820322));

s7_N90_9 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N90_10, 0.12732318));

s7_N90_8 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.00044188963, s7_N90_9));

s7_N90_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s7_N90_8, 0.040888632));

s7_N90_6 :=  __common__( if(((real)avg_lres < 11.5), 0.042226304, s7_N90_7));

s7_N90_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), -0.00061366241, 0.0098652528));

s7_N90_4 :=  __common__( if(((real)gong_did_last_ct < 0.5), -0.0057333326, s7_N90_5));

s7_N90_3 :=  __common__( map(trim(C_HVAL_20K_P) = ''      => 0.038817079,
             ((real)c_hval_20k_p < 57.35) => s7_N90_4,
                                             0.038817079));

s7_N90_2 :=  __common__( if(((real)c_lar_fam < 152.5), s7_N90_3, s7_N90_6));

s7_N90_1 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N90_2, -0.0026377128));

s7_N91_10 :=  __common__( if(((real)c_larceny < 189.5), 0.0063527943, 0.050827072));

s7_N91_9 :=  __common__( if(trim(C_LARCENY) != '', s7_N91_10, 0.026383881));

s7_N91_8 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 4.5), s7_N91_9, 0.041822891));

s7_N91_7 :=  __common__( if(((real)ssn_lowissue_age < 34.0772), s7_N91_8, 0.043797096));

s7_N91_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N91_7, -0.026290569));

s7_N91_5 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N91_6, -0.00010328314));

s7_N91_4 :=  __common__( if(((real)avg_lres < 16.5), 0.046165071, s7_N91_5));

s7_N91_3 :=  __common__( if(((real)c_recent_mov < 3.5), 0.026334187, -0.00063132811));

s7_N91_2 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N91_3, -0.017378265));

s7_N91_1 :=  __common__( if(((real)_rel_incomeunder25_count < 4.5), s7_N91_2, s7_N91_4));

s7_N92_9 :=  __common__( if(((real)add1_source_count < 4.5), 0.049055443, 0.0032672003));

s7_N92_8 :=  __common__( if(((integer)add2_eda_sourced < 0.5), 0.010427599, s7_N92_9));

s7_N92_7 :=  __common__( map(trim(C_TOTCRIME) = ''      => 0.056948516,
             ((real)c_totcrime < 178.5) => 0.00022830553,
                                           0.056948516));

s7_N92_6 :=  __common__( if(((real)_infutor_nap < 2.5), s7_N92_7, s7_N92_8));

s7_N92_5 :=  __common__( map(trim(C_MED_HHINC) = ''         => 0.0027890842,
             ((integer)c_med_hhinc < 21844) => 0.02438815,
                                               0.0027890842));

s7_N92_4 :=  __common__( if(((integer)add1_avm_med < 398011), -0.0048840482, s7_N92_5));

s7_N92_3 :=  __common__( if(((real)combined_age < 59.5), s7_N92_4, s7_N92_6));

s7_N92_2 :=  __common__( if(((real)c_hval_20k_p < 57.35), s7_N92_3, 0.032620011));

s7_N92_1 :=  __common__( if(trim(C_HVAL_20K_P) != '', s7_N92_2, 0.00068490445));

s7_N93_8 :=  __common__( map(trim(C_RAPE) = ''      => 0.015150423,
             ((integer)c_rape < 82) => 0.06556301,
                                       0.015150423));

s7_N93_7 :=  __common__( if(((real)_addrs_per_ssn < 6.5), s7_N93_8, 0.01735152));

s7_N93_6 :=  __common__( if(((real)c_vacant_p < 11.55), s7_N93_7, -0.0068339631));

s7_N93_5 :=  __common__( if(trim(C_VACANT_P) != '', s7_N93_6, 0.035374352));

s7_N93_4 :=  __common__( if(((real)_inq_peraddr_cap8 < 3.5), s7_N93_5, 0.054208429));

s7_N93_3 :=  __common__( if(((real)attr_num_nonderogs30 < 3.5), -0.0078490168, s7_N93_4));

s7_N93_2 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N93_3, 0.0042786276));

s7_N93_1 :=  __common__( if(((real)add2_naprop < 3.5), -0.00095324901, s7_N93_2));

s7_N94_9 :=  __common__( if(((real)add2_turnover_1yr_in < 349.5), 0.032804004, -0.0027370599));

s7_N94_8 :=  __common__( if(((real)mth_gong_did_first_seen < 98.5), 0.0076734645, 0.047895253));

s7_N94_7 :=  __common__( map(trim(C_HIGHINC) = ''      => 0.073161953,
             ((real)c_highinc < 37.25) => s7_N94_8,
                                          0.073161953));

s7_N94_6 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.00094952313, 0.011066488));

s7_N94_5 :=  __common__( if(((real)_nap < 3.5), s7_N94_6, s7_N94_7));

s7_N94_4 :=  __common__( if(((real)_phones_per_adl < 0.5), -0.0020118891, s7_N94_5));

s7_N94_3 :=  __common__( if(((real)combined_age < 87.5), s7_N94_4, s7_N94_9));

s7_N94_2 :=  __common__( if(((real)c_lowinc < 85.95), s7_N94_3, 0.027839665));

s7_N94_1 :=  __common__( if(trim(C_LOWINC) != '', s7_N94_2, 0.0014641097));

s7_N95_8 :=  __common__( if(((real)rc_addrcount < 1.5), -0.019124078, -0.0084603156));
s7_N95_7 :=  __common__( if(mth_header_first_seen != NULL and ((real)mth_header_first_seen < 289.5), 0.039008683, -0.0018308513));
s7_N95_6 :=  __common__( if(((integer)rc_fnamessnmatch < 0.5), s7_N95_7, 0.0058591608));
s7_N95_5 :=  __common__( if(((integer)add2_eda_sourced < 0.5), -0.0021912676, 0.0083928041));
s7_N95_4 :=  __common__( if(((real)_altlname < 0.5), s7_N95_5, s7_N95_6));
s7_N95_3 :=  __common__( if(((real)c_fammar_p < 36.15), 0.018057419, s7_N95_4));
s7_N95_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N95_3, 0.00065159951));
s7_N95_1 :=  __common__( if(((real)_ams_income_level < 2.5), s7_N95_2, s7_N95_8));

s7_N96_8 :=  __common__( if(((real)rc_addrcount < 4.5), 0.06700933, 0.01365692));

s7_N96_7 :=  __common__( map(trim(C_LAR_FAM) = ''     => 0.0018767372,
             ((real)c_lar_fam < 92.5) => s7_N96_8,
                                         0.0018767372));

s7_N96_6 :=  __common__( if(((real)_adls_per_addr_c6 < 0.5), 0.020372653, 0.062805649));

s7_N96_5 :=  __common__( if(((real)_rel_prop_owned_count < 0.5), s7_N96_6, s7_N96_7));

s7_N96_4 :=  __common__( if(((real)c_fammar_p < 80.9), s7_N96_5, -0.0014107003));

s7_N96_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N96_4, -0.027202425));

s7_N96_2 :=  __common__( if(((real)_ssn_score < 1.5), -0.0006549401, 0.014080144));

s7_N96_1 :=  __common__( if(((real)_rel_felony_total < 1.5), s7_N96_2, s7_N96_3));

s7_N97_8 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.035514429,
             ((real)c_incollege < 4.05) => 0.0091159972,
                                           0.035514429));

s7_N97_7 :=  __common__( if(((real)c_med_hhinc < 27770.5), s7_N97_8, 0.0047948925));

s7_N97_6 :=  __common__( if(trim(C_MED_HHINC) != '', s7_N97_7, 0.0082630508));

s7_N97_5 :=  __common__( if(((real)_inq_peraddr_cap8 < 5.5), 0.0070997838, 0.046381033));

s7_N97_4 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N97_5, -0.00062067498));

s7_N97_3 :=  __common__( if(((real)_prop_owned_total < 0.5), -0.0047686752, s7_N97_4));

s7_N97_2 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), s7_N97_3, s7_N97_6));

s7_N97_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s7_N97_2, 0.02513823));

s7_N98_10 :=  __common__( if(((real)ssn_lowissue_age < 28.3817), -0.0011600334, 0.039622744));

s7_N98_9 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N98_10, -0.035205193));

s7_N98_8 :=  __common__( if(((real)c_rnt750_p < 57.75), s7_N98_9, 0.043027061));

s7_N98_7 :=  __common__( if(trim(C_RNT750_P) != '', s7_N98_8, 0.030629075));

s7_N98_6 :=  __common__( map(trim(C_CIV_EMP) = ''     => 0.0055758396,
             ((real)c_civ_emp < 60.4) => 0.044540456,
                                         0.0055758396));

s7_N98_5 :=  __common__( if(((real)c_unattach < 154.5), 0.0027068448, 0.033733272));

s7_N98_4 :=  __common__( if(trim(C_UNATTACH) != '', s7_N98_5, -0.0031049799));

s7_N98_3 :=  __common__( if(((real)combined_age < 66.5), s7_N98_4, s7_N98_6));

s7_N98_2 :=  __common__( if(((real)_phone_score < 2.5), -0.0019102481, s7_N98_3));

s7_N98_1 :=  __common__( if(((real)add1_unit_count < 360.5), s7_N98_2, s7_N98_7));

s7_N99_9 :=  __common__( map(trim(C_OWNOCC_P) = ''     => 0.0087529309,
             ((real)c_ownocc_p < 56.3) => 0.051360864,
                                          0.0087529309));

s7_N99_8 :=  __common__( if(((real)combined_age < 73.5), 0.0030466355, s7_N99_9));

s7_N99_7 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => s7_N99_8,
             ((real)c_fammar18_p < 16.75) => 0.031606571,
                                             s7_N99_8));

s7_N99_6 :=  __common__( if(((real)source_count < 1.5), 0.034869, s7_N99_7));

s7_N99_5 :=  __common__( if(((real)_rel_count_addr < 2.5), 0.015734018, 0.064767705));

s7_N99_4 :=  __common__( map(trim(C_LOW_ED) = ''      => s7_N99_5,
             ((real)c_low_ed < 53.25) => 0.001566563,
                                         s7_N99_5));

s7_N99_3 :=  __common__( if(((real)_rel_felony_total < 1.5), -0.0014354908, s7_N99_4));

s7_N99_2 :=  __common__( if(((real)c_lar_fam < 143.5), s7_N99_3, s7_N99_6));

s7_N99_1 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N99_2, -0.0080831022));

s7_N100_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), 0.0029171581, 0.1850249));

s7_N100_6 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s7_N100_7, 0.04125067));

s7_N100_5 :=  __common__( if(((real)age < 73.5), s7_N100_6, 0.043040402));

s7_N100_4 :=  __common__( if(((real)_addrs_last90 < 0.5), 0.0025715003, 0.031561534));

s7_N100_3 :=  __common__( map((prof_license_category in ['0', '1', '2', '4']) => s7_N100_4,
              (prof_license_category in ['3', '5'])           => 0.12750908,
                                                                 s7_N100_4));

s7_N100_2 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N100_3, s7_N100_5));

s7_N100_1 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 2.5), -0.00064147227, s7_N100_2));

s7_N101_9 :=  __common__( map(trim(C_MANY_CARS) = ''     => 0.00064502045,
              ((real)c_many_cars < 54.5) => 0.030993088,
                                            0.00064502045));

s7_N101_8 :=  __common__( if(((real)add1_turnover_1yr_in < 327.5), 0.017540717, 0.064803814));

s7_N101_7 :=  __common__( map(trim(C_FAMMAR_P) = ''      => 0.0042025831,
              ((real)c_fammar_p < 82.65) => s7_N101_8,
                                            0.0042025831));

s7_N101_6 :=  __common__( if(((real)c_sfdu_p < 44.05), -0.033119281, s7_N101_7));

s7_N101_5 :=  __common__( if(trim(C_SFDU_P) != '', s7_N101_6, -0.028736691));

s7_N101_4 :=  __common__( if(((integer)add1_building_area2 < 1147), 0.048125308, s7_N101_5));

s7_N101_3 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N101_4, s7_N101_9));

s7_N101_2 :=  __common__( if(((real)_nap < 2.5), 2.5331859e-005, s7_N101_3));

s7_N101_1 :=  __common__( if(((real)combined_age < 70.5), -0.0012404262, s7_N101_2));

s7_N102_9 :=  __common__( if(((real)rc_addrcount < 4.5), 0.019738179, -0.0078749503));

s7_N102_8 :=  __common__( if(((real)c_pop_25_34_p < 13.5), 0.0078461731, 0.033671452));

s7_N102_7 :=  __common__( if(trim(C_POP_25_34_P) != '', s7_N102_8, 0.10378982));

s7_N102_6 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N102_7, s7_N102_9));

s7_N102_5 :=  __common__( if(((real)c_cartheft < 147.5), 0.040413255, 0.0017821545));

s7_N102_4 :=  __common__( if(trim(C_CARTHEFT) != '', s7_N102_5, -0.032918848));

s7_N102_3 :=  __common__( if(((real)add1_unit_count < 17.5), 0.0021478369, s7_N102_4));

s7_N102_2 :=  __common__( if(((real)input_dob_match_level < 5.5), s7_N102_3, -0.0020582731));

s7_N102_1 :=  __common__( if(((real)combined_age < 78.5), s7_N102_2, s7_N102_6));

s7_N103_9 :=  __common__( if(((real)c_civ_emp < 55.25), 0.018934699, 0.0023802494));

s7_N103_8 :=  __common__( if(trim(C_CIV_EMP) != '', s7_N103_9, 0.020801637));

s7_N103_7 :=  __common__( if(((real)_phone_score < 1.5), -0.0027911028, s7_N103_8));

s7_N103_6 :=  __common__( if(((real)_rel_homeunder100_count < 2.5), 0.015508351, 0.054062501));

s7_N103_5 :=  __common__( if(((real)c_rape < 66.5), 0.054139243, 0.0046153661));

s7_N103_4 :=  __common__( if(trim(C_RAPE) != '', s7_N103_5, 0.11403047));

s7_N103_3 :=  __common__( if(((real)add1_lres < 2.5), s7_N103_4, 0.0023467284));

s7_N103_2 :=  __common__( if(((real)combined_age < 66.5), s7_N103_3, s7_N103_6));

s7_N103_1 :=  __common__( if(((real)rc_dirsaddr_lastscore < 30.5), s7_N103_2, s7_N103_7));

s7_N104_9 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => 0.060578305,
              ((real)c_fammar18_p < 34.55) => 0.0016909417,
                                              0.060578305));

s7_N104_8 :=  __common__( if(((real)add2_nhood_vacant_properties < 27.5), s7_N104_9, -0.01295563));

s7_N104_7 :=  __common__( map(trim(C_HIGHINC) = ''     => 0.076862778,
              ((real)c_highinc < 3.35) => 0.015108059,
                                          0.076862778));

s7_N104_6 :=  __common__( if(((real)source_count < 4.5), s7_N104_7, s7_N104_8));

s7_N104_5 :=  __common__( map(trim(C_BEL_EDU) = ''      => s7_N104_6,
              ((real)c_bel_edu < 154.5) => 0.0048523288,
                                           s7_N104_6));

s7_N104_4 :=  __common__( if(((real)_inq_peraddr_cap8 < 6.5), -0.0010811459, 0.014961142));

s7_N104_3 :=  __common__( if(((real)_altlname < 0.5), s7_N104_4, s7_N104_5));

s7_N104_2 :=  __common__( if(((real)c_inc_15k_p < 55.85), s7_N104_3, 0.032029859));

s7_N104_1 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N104_2, -5.1597454e-005));

s7_N105_8 :=  __common__( map(trim(C_MORT_INDX) = ''      => 0.010970081,
              ((integer)c_mort_indx < 78) => 0.04195235,
                                             0.010970081));

s7_N105_7 :=  __common__( if(((real)c_span_lang < 122.5), -0.0046557692, s7_N105_8));

s7_N105_6 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N105_7, 0.085685723));

s7_N105_5 :=  __common__( map(trim(C_MED_HVAL) = ''          => 0.019078425,
              ((integer)c_med_hval < 167785) => 0.0603514,
                                                0.019078425));

s7_N105_4 :=  __common__( if(((real)_rel_count_addr < 0.5), s7_N105_5, 0.0070108414));

s7_N105_3 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0008344067, s7_N105_4));

s7_N105_2 :=  __common__( if(((integer)add1_avm_med < 387475), -0.0024157568, s7_N105_3));

s7_N105_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N105_2, s7_N105_6));

s7_N106_8 :=  __common__( if(((real)attr_num_nonderogs90 < 4.5), 0.021050379, 0.072382427));

s7_N106_7 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N106_8, 0.0068640734));

s7_N106_6 :=  __common__( map(trim(C_RNT750_P) = ''      => -0.010144123,
              ((real)c_rnt750_p < 43.55) => s7_N106_7,
                                            -0.010144123));

s7_N106_5 :=  __common__( if(((real)age < 65.5), s7_N106_6, 0.054607823));

s7_N106_4 :=  __common__( if(((real)c_blue_col < 10.35), -0.0067883718, s7_N106_5));

s7_N106_3 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N106_4, 0.04876897));

s7_N106_2 :=  __common__( if(((real)add2_source_count < 8.5), s7_N106_3, 0.050210434));

s7_N106_1 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), -0.00092295284, s7_N106_2));

s7_N107_9 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.049290603,
              ((real)c_sfdu_p < 86.15) => 0.0051029093,
                                          0.049290603));

s7_N107_8 :=  __common__( if(((real)_ssn_score < 1.5), 0.0024058445, s7_N107_9));

s7_N107_7 :=  __common__( if(((integer)c_lar_fam < 77), -0.016737622, 0.012019354));

s7_N107_6 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N107_7, 0.017928676));

s7_N107_5 :=  __common__( if(((real)c_ownocc_p < 69.85), -0.028668743, -0.0065434639));

s7_N107_4 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N107_5, -0.0047105723));

s7_N107_3 :=  __common__( if(((real)add1_unit_count < 23.5), s7_N107_4, s7_N107_6));

s7_N107_2 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N107_3, -0.0028997998));

s7_N107_1 :=  __common__( if(((real)_ssns_per_addr < 5.5), s7_N107_2, s7_N107_8));

s7_N108_9 :=  __common__( if(((real)age < 58.5), 0.012775809, 0.040630205));

s7_N108_8 :=  __common__( if(((real)c_unattach < 82.5), -0.0096885719, s7_N108_9));

s7_N108_7 :=  __common__( if(trim(C_UNATTACH) != '', s7_N108_8, 0.025241986));

s7_N108_6 :=  __common__( if(((real)add2_naprop < 3.5), 0.0012967275, 0.018177346));

s7_N108_5 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N108_6, 0.00019361428));

s7_N108_4 :=  __common__( if(((real)c_totcrime < 184.5), s7_N108_5, 0.047416572));

s7_N108_3 :=  __common__( if(trim(C_TOTCRIME) != '', s7_N108_4, -0.015778868));

s7_N108_2 :=  __common__( if(((real)attr_num_nonderogs90 < 3.5), -0.005951298, s7_N108_3));

s7_N108_1 :=  __common__( if(((real)_rel_felony_total < 1.5), s7_N108_2, s7_N108_7));

s7_N109_10 :=  __common__( map(trim(C_BURGLARY) = ''     => 0.014774207,
               ((real)c_burglary < 27.5) => 0.074301335,
                                            0.014774207));

s7_N109_9 :=  __common__( if(((real)rc_lnamecount < 8.5), 0.0047006448, s7_N109_10));

s7_N109_8 :=  __common__( if(((integer)add1_avm_med < 327034), -0.0012539696, s7_N109_9));

s7_N109_7 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.0026991963, s7_N109_8));

s7_N109_6 :=  __common__( map(trim(C_NO_MOVE) = ''      => 0.078960676,
              ((integer)c_no_move < 51) => 0.0097557563,
                                           0.078960676));

s7_N109_5 :=  __common__( if(((real)_addrs_per_ssn < 4.5), -0.010398715, s7_N109_6));

s7_N109_4 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N109_5, 0.0083542904));

s7_N109_3 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), 0.0054114805, s7_N109_4));

s7_N109_2 :=  __common__( if(((real)c_ab_av_edu < 45.5), s7_N109_3, s7_N109_7));

s7_N109_1 :=  __common__( if(trim(C_AB_AV_EDU) != '', s7_N109_2, -0.0075242119));

s7_N110_9 :=  __common__( if(((integer)add2_nhood_vacant_properties < 36), 0.013289942, 0.048853099));

s7_N110_8 :=  __common__( if((combo_dobscore < 92), -0.020845222, 0.010648283));

s7_N110_7 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N110_8, s7_N110_9));

s7_N110_6 :=  __common__( if(((real)add1_source_count < 3.5), 0.018324965, 0.0036995425));

s7_N110_5 :=  __common__( map(trim(C_MED_HVAL) = ''          => 0.076615869,
              ((integer)c_med_hval < 391904) => s7_N110_6,
                                                0.076615869));

s7_N110_4 :=  __common__( if(((real)add2_naprop < 3.5), -0.00045599062, s7_N110_5));

s7_N110_3 :=  __common__( if(((real)combined_age < 67.5), s7_N110_4, s7_N110_7));

s7_N110_2 :=  __common__( if(((real)c_fammar_p < 84.65), s7_N110_3, -0.0042340029));

s7_N110_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N110_2, -0.0027591314));

s7_N111_10 :=  __common__( if(((real)_addr_stability_v2 < 5.5), 0.029346946, -0.0062465997));

s7_N111_9 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.042827218,
              ((real)c_bel_edu < 156.5) => -0.0025724296,
                                           0.042827218));

s7_N111_8 :=  __common__( map(trim(C_INC_25K_P) = ''      => s7_N111_9,
              ((real)c_inc_25k_p < 12.15) => 0.077042204,
                                             s7_N111_9));

s7_N111_7 :=  __common__( map(trim(C_INC_150K_P) = ''     => s7_N111_10,
              ((real)c_inc_150k_p < 2.25) => s7_N111_8,
                                             s7_N111_10));

s7_N111_6 :=  __common__( if(((real)_nas < 2.5), 0.0016171737, 0.0185861));

s7_N111_5 :=  __common__( if(((real)add2_avm_to_med_ratio < 1.86239), -0.00019191818, 0.042769833));

s7_N111_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N111_5, s7_N111_6));

s7_N111_3 :=  __common__( if(((real)combined_age < 73.5), s7_N111_4, s7_N111_7));

s7_N111_2 :=  __common__( if(((real)c_cartheft < 144.5), -0.0027513533, s7_N111_3));

s7_N111_1 :=  __common__( if(trim(C_CARTHEFT) != '', s7_N111_2, 0.0068610732));

s7_N112_10 :=  __common__( map(trim(C_MED_AGE) = ''     => -0.0087141235,
               ((real)c_med_age < 50.5) => 0.020091865,
                                           -0.0087141235));

s7_N112_9 :=  __common__( if(((real)_rel_count < 3.5), 0.04145785, s7_N112_10));

s7_N112_8 :=  __common__( if(((real)ssn_lowissue_age < 31.3527), 0.007954984, 0.047846751));

s7_N112_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N112_8, 0.036706015));

s7_N112_6 :=  __common__( map(trim(C_LAR_FAM) = ''      => 0.037135267,
              ((real)c_lar_fam < 189.5) => -0.0010208488,
                                           0.037135267));

s7_N112_5 :=  __common__( if(((integer)add3_eda_sourced < 0.5), s7_N112_6, s7_N112_7));

s7_N112_4 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.018973776, s7_N112_5));

s7_N112_3 :=  __common__( if(((real)combined_age < 88.5), s7_N112_4, 0.017967404));

s7_N112_2 :=  __common__( if(((real)c_bel_edu < 193.5), s7_N112_3, s7_N112_9));

s7_N112_1 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N112_2, -0.0021033782));

s7_N113_8 :=  __common__( map(trim(C_HVAL_1000K_P) = ''     => 0.11156642,
              ((real)c_hval_1000k_p < 4.45) => 0.011172123,
                                               0.11156642));

s7_N113_7 :=  __common__( if(((real)_rel_prop_owned_total < 3.5), -0.00014615356, s7_N113_8));

s7_N113_6 :=  __common__( if(((real)add1_source_count < 2.5), 0.048438367, s7_N113_7));

s7_N113_5 :=  __common__( map(trim(C_MORT_INDX) = ''     => -0.0078831409,
              ((real)c_mort_indx < 24.5) => 0.018389192,
                                            -0.0078831409));

s7_N113_4 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N113_5, -4.1713338e-005));

s7_N113_3 :=  __common__( if(((real)c_hval_500k_p < 21.55), s7_N113_4, s7_N113_6));

s7_N113_2 :=  __common__( if(trim(C_HVAL_500K_P) != '', s7_N113_3, -0.00096183919));

s7_N113_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 4.5), s7_N113_2, 0.018360188));

s7_N114_8 :=  __common__( if(((real)age < 73.5), -0.0047749467, 0.033337373));

s7_N114_7 :=  __common__( if(((real)rc_addrcount < 2.5), 0.040441024, 0.0098073997));

s7_N114_6 :=  __common__( if(((real)age < 57.5), s7_N114_7, 0.065743264));

s7_N114_5 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), 0.0018113733, 0.037620841));

s7_N114_4 :=  __common__( if(((real)_rel_bankrupt_count < 0.5), s7_N114_5, s7_N114_6));

s7_N114_3 :=  __common__( if(((real)c_high_ed < 20.45), s7_N114_4, s7_N114_8));

s7_N114_2 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N114_3, 0.025877882));

s7_N114_1 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), -0.00082075608, s7_N114_2));

s7_N115_8 :=  __common__( if(((integer)add1_avm_med < 548261), 0.011869526, 0.05938303));

s7_N115_7 :=  __common__( if(((real)_addrs_per_ssn < 7.5), 0.049072901, 0.0094196984));

s7_N115_6 :=  __common__( if(((real)_adls_per_addr_cap10 < 9.5), 0.00035689822, s7_N115_7));

s7_N115_5 :=  __common__( if(((real)c_low_ed < 63.05), 0.00038891805, s7_N115_6));

s7_N115_4 :=  __common__( if(trim(C_LOW_ED) != '', s7_N115_5, 0.014583134));

s7_N115_3 :=  __common__( if(((real)add2_source_count < 9.5), s7_N115_4, 0.042687112));

s7_N115_2 :=  __common__( if(((real)_phones_per_adl_c6 < 0.5), s7_N115_3, s7_N115_8));

s7_N115_1 :=  __common__( if(((real)_nap < 3.5), -0.0015113906, s7_N115_2));

s7_N116_9 :=  __common__( if(((real)ssn_lowissue_age > NULL), 0.0062742092, 0.078473337));

s7_N116_8 :=  __common__( if(((real)combined_age < 74.5), s7_N116_9, 0.028505515));

s7_N116_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), -0.0005888237, s7_N116_8));

s7_N116_6 :=  __common__( if(((real)_adlperssn_count < 0.5), 0.021422507, s7_N116_7));

s7_N116_5 :=  __common__( if(((integer)lname_eda_sourced < 0.5), 0.036930888, -0.0032917499));

s7_N116_4 :=  __common__( if(((real)add1_source_count < 0.5), s7_N116_5, s7_N116_6));

s7_N116_3 :=  __common__( if(((real)add_errorcode < 0.5), s7_N116_4, -0.018415095));

s7_N116_2 :=  __common__( if(((real)c_lowinc < 87.8), s7_N116_3, 0.033409066));

s7_N116_1 :=  __common__( if(trim(C_LOWINC) != '', s7_N116_2, 0.01219198));

s7_N117_7 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.033226346,
              ((real)c_easiqlife < 122.5) => 0.0025788562,
                                             0.033226346));

s7_N117_6 :=  __common__( map(trim(C_SFDU_P) = ''     => 0.016291407,
              ((real)c_sfdu_p < 62.8) => 0.048077728,
                                         0.016291407));

s7_N117_5 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), -0.0057978563, 0.031637134));

s7_N117_4 :=  __common__( if(((real)attr_num_nonderogs90 < 3.5), s7_N117_5, 0.0088391295));

s7_N117_3 :=  __common__( if(((real)_inq_count < 4.5), s7_N117_4, s7_N117_6));

s7_N117_2 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N117_3, -0.00059295722));

s7_N117_1 :=  __common__( if(((real)combined_age < 86.5), s7_N117_2, s7_N117_7));

s7_N118_11 :=  __common__( if(((real)c_span_lang < 146.5), 0.021870931, 0.074250128));

s7_N118_10 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N118_11, -0.025974421));

s7_N118_9 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), 0.0058987992, s7_N118_10));

s7_N118_8 :=  __common__( map(trim(C_EASIQLIFE) = ''     => -0.00075890058,
              ((real)c_easiqlife < 74.5) => 0.11303336,
                                            -0.00075890058));

s7_N118_7 :=  __common__( map(trim(C_INC_201K_P) = ''     => 0.15260373,
              ((real)c_inc_201k_p < 15.3) => s7_N118_8,
                                             0.15260373));

s7_N118_6 :=  __common__( if(((real)add1_source_count < 7.5), 0.0031502606, s7_N118_7));

s7_N118_5 :=  __common__( if(((real)c_assault < 14.5), s7_N118_6, 0.0022542264));

s7_N118_4 :=  __common__( if(trim(C_ASSAULT) != '', s7_N118_5, 0.01467304));

s7_N118_3 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.0028547455, s7_N118_4));

s7_N118_2 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 437.5), s7_N118_3, s7_N118_9));

s7_N118_1 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N118_2, -0.0010757631));

s7_N119_8 :=  __common__( if(((real)add3_lres < 9.5), 0.05420639, 0.019267072));

s7_N119_7 :=  __common__( map(trim(C_YOUNG) = ''     => -0.0059246564,
              ((real)c_young < 27.8) => s7_N119_8,
                                        -0.0059246564));

s7_N119_6 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.0043996657,
              ((real)c_fammar_p < 80.35) => s7_N119_7,
                                            -0.0043996657));

s7_N119_5 :=  __common__( if(((real)_rel_felony_total < 1.5), -0.0013784945, s7_N119_6));

s7_N119_4 :=  __common__( if(((real)c_ownocc_p < 97.55), s7_N119_5, 0.020869747));

s7_N119_3 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N119_4, 0.00024878801));

s7_N119_2 :=  __common__( map(trim(C_RENTOCC_P) = ''      => -0.0039379304,
              ((real)c_rentocc_p < 40.05) => 0.036912095,
                                             -0.0039379304));

s7_N119_1 :=  __common__( if(((real)input_dob_match_level < 0.5), s7_N119_2, s7_N119_3));

s7_N120_9 :=  __common__( if(((real)add3_lres < 0.5), -0.019522546, 0.037525444));

s7_N120_8 :=  __common__( map(trim(C_BORN_USA) = ''     => 0.0042206426,
              ((real)c_born_usa < 14.5) => s7_N120_9,
                                           0.0042206426));

s7_N120_7 :=  __common__( map(trim(C_POP_25_34_P) = ''      => 0.050177801,
              ((real)c_pop_25_34_p < 28.45) => s7_N120_8,
                                               0.050177801));

s7_N120_6 :=  __common__( map(trim(C_INC_201K_P) = ''      => 0.11848556,
              ((real)c_inc_201k_p < 15.35) => 0.019054078,
                                              0.11848556));

s7_N120_5 :=  __common__( map(trim(C_ASSAULT) = ''     => s7_N120_7,
              ((real)c_assault < 14.5) => s7_N120_6,
                                          s7_N120_7));

s7_N120_4 :=  __common__( if(((real)_inq_collection_count < 0.5), 0.00058030373, s7_N120_5));

s7_N120_3 :=  __common__( if(((real)add1_lres < 79.5), -0.003193291, s7_N120_4));

s7_N120_2 :=  __common__( if(((real)c_hval_20k_p < 57.35), s7_N120_3, 0.034597401));

s7_N120_1 :=  __common__( if(trim(C_HVAL_20K_P) != '', s7_N120_2, -0.0061265843));

s7_N121_8 :=  __common__( map(trim(C_BIGAPT_P) = ''     => -0.00079406981,
              ((real)c_bigapt_p < 0.35) => 0.065061704,
                                           -0.00079406981));

s7_N121_7 :=  __common__( if(((real)_phones_per_adl < 0.5), 0.0017637297, 0.03910502));

s7_N121_6 :=  __common__( if(((real)c_bigapt_p < 24.95), 0.0014215214, s7_N121_7));

s7_N121_5 :=  __common__( if(trim(C_BIGAPT_P) != '', s7_N121_6, 0.0088700916));

s7_N121_4 :=  __common__( if(((real)add2_turnover_1yr_in < 2738.5), s7_N121_5, 0.063176246));

s7_N121_3 :=  __common__( if(((real)add1_lres < 331.5), s7_N121_4, s7_N121_8));

s7_N121_2 :=  __common__( if(((integer)add1_turnover_1yr_in < 2), 0.064863107, s7_N121_3));

s7_N121_1 :=  __common__( if(((real)_phone_score < 1.5), -0.0016092257, s7_N121_2));

s7_N122_8 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), 0.0013093587, 0.031252463));

s7_N122_7 :=  __common__( if(((real)c_mort_indx < 42.5), 0.042260333, s7_N122_8));

s7_N122_6 :=  __common__( if(trim(C_MORT_INDX) != '', s7_N122_7, 0.051427968));

s7_N122_5 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.00040179588, 0.019040018));

s7_N122_4 :=  __common__( if(((real)rc_addrcount < 2.5), 0.0028075618, 0.081755522));

s7_N122_3 :=  __common__( if(((real)_add_risk < 0.5), s7_N122_4, 0.0017146657));

s7_N122_2 :=  __common__( if(((real)add1_source_count < 0.5), s7_N122_3, s7_N122_5));

s7_N122_1 :=  __common__( if(((real)combined_age < 79.5), s7_N122_2, s7_N122_6));

s7_N123_10 :=  __common__( map(trim(C_BEL_EDU) = ''     => -0.010491993,
               ((real)c_bel_edu < 14.5) => 0.064179076,
                                           -0.010491993));

s7_N123_9 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0095548999, s7_N123_10));

s7_N123_8 :=  __common__( map(trim(C_EASIQLIFE) = ''     => s7_N123_9,
              ((real)c_easiqlife < 74.5) => 0.070771485,
                                            s7_N123_9));

s7_N123_7 :=  __common__( if(((real)add1_building_area2 < 1258.5), 0.035047564, 0.007022626));

s7_N123_6 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N123_7, 0.0077917807));

s7_N123_5 :=  __common__( if(((real)age < 47.5), 0.00011130907, s7_N123_6));

s7_N123_4 :=  __common__( if(((real)rc_phonelnamecount < 0.5), s7_N123_5, -0.002772433));

s7_N123_3 :=  __common__( if(((real)_phones_per_addr < 0.5), -0.0051723627, s7_N123_4));

s7_N123_2 :=  __common__( if(((real)c_white_col < 68.55), s7_N123_3, s7_N123_8));

s7_N123_1 :=  __common__( if(trim(C_WHITE_COL) != '', s7_N123_2, 0.014148499));

s7_N124_8 :=  __common__( if(((real)add2_source_count < 8.5), -0.010657024, 0.02386681));

s7_N124_7 :=  __common__( map(trim(C_MED_HHINC) = ''         => -0.00073074239,
              ((integer)c_med_hhinc < 71608) => 0.041077791,
                                                -0.00073074239));

s7_N124_6 :=  __common__( map(trim(C_RNT500_P) = ''     => s7_N124_8,
              ((real)c_rnt500_p < 3.55) => s7_N124_7,
                                           s7_N124_8));

s7_N124_5 :=  __common__( map(trim(C_RECENT_MOV) = ''     => s7_N124_6,
              ((real)c_recent_mov < 76.5) => 0.022218702,
                                             s7_N124_6));

s7_N124_4 :=  __common__( if(((integer)c_totsales < 385109), s7_N124_5, 0.043852843));

s7_N124_3 :=  __common__( if(trim(C_TOTSALES) != '', s7_N124_4, 0.035626159));

s7_N124_2 :=  __common__( if(((real)add1_source_count < 2.5), s7_N124_3, 0.0015132416));

s7_N124_1 :=  __common__( if(((real)gong_did_addr_ct < 0.5), -0.0036131964, s7_N124_2));

s7_N125_9 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), 0.012287423, 0.043427338));

s7_N125_8 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.048981863,
              ((real)c_incollege < 4.15) => 0.0082085756,
                                            0.048981863));

s7_N125_7 :=  __common__( map(trim(C_MED_AGE) = ''     => 0.0075435704,
              ((real)c_med_age < 21.5) => s7_N125_8,
                                          0.0075435704));

s7_N125_6 :=  __common__( map(trim(C_ROBBERY) = ''      => s7_N125_7,
              ((real)c_robbery < 157.5) => -0.00060269187,
                                           s7_N125_7));

s7_N125_5 :=  __common__( if(((integer)add2_eda_sourced < 0.5), s7_N125_6, s7_N125_9));

s7_N125_4 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N125_5, -0.00047768344));

s7_N125_3 :=  __common__( if(((real)age < 28.5), -0.0055401202, s7_N125_4));

s7_N125_2 :=  __common__( if(((real)c_inc_15k_p < 55.75), s7_N125_3, 0.022422438));

s7_N125_1 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N125_2, 0.0071706345));

s7_N126_9 :=  __common__( if(((integer)_phone_score < 0), 0.07744841, 0.025741849));

s7_N126_8 :=  __common__( if(((real)_addrs_last36 < 4.5), s7_N126_9, -0.0017185099));

s7_N126_7 :=  __common__( if(((real)c_hval_40k_p < 2.55), -0.0039991069, s7_N126_8));

s7_N126_6 :=  __common__( if(trim(C_HVAL_40K_P) != '', s7_N126_7, 0.037073723));

s7_N126_5 :=  __common__( map(trim(C_CHILD) = ''      => 0.052144831,
              ((integer)c_child < 26) => -0.013824226,
                                         0.052144831));

s7_N126_4 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), -0.00065884747, s7_N126_5));

s7_N126_3 :=  __common__( if(trim(C_BIGAPT_P) != '', s7_N126_4, -0.0052531848));

s7_N126_2 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N126_3, 0.019610434));

s7_N126_1 :=  __common__( if(((real)_rel_felony_count < 1.5), s7_N126_2, s7_N126_6));

s7_N127_10 :=  __common__( map(trim(C_LOWINC) = ''     => 0.035841891,
               ((real)c_lowinc < 29.7) => -0.006545279,
                                          0.035841891));

s7_N127_9 :=  __common__( if(((real)_ssn_score < 1.5), -0.0016293919, s7_N127_10));

s7_N127_8 :=  __common__( if(((real)_rel_felony_count < 2.5), s7_N127_9, 0.043535003));

s7_N127_7 :=  __common__( map(trim(C_VACANT_P) = ''     => 0.0039740636,
              ((real)c_vacant_p < 3.75) => 0.050207115,
                                           0.0039740636));

s7_N127_6 :=  __common__( map(trim(C_RECENT_MOV) = ''     => 0.003223971,
              ((real)c_recent_mov < 39.5) => 0.023777806,
                                             0.003223971));

s7_N127_5 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.0012410855, s7_N127_6));

s7_N127_4 :=  __common__( if(((real)c_fammar_p < 41.95), -0.014867144, s7_N127_5));

s7_N127_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N127_4, -0.026725862));

s7_N127_2 :=  __common__( if(((real)add1_building_area2 < 92340.5), s7_N127_3, s7_N127_7));

s7_N127_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N127_2, s7_N127_8));

s7_N128_8 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), 0.0046808475, 0.030074174));

s7_N128_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), -0.00081860623, s7_N128_8));

s7_N128_6 :=  __common__( if(((real)_adlperssn_count < 0.5), 0.02063449, s7_N128_7));

s7_N128_5 :=  __common__( if(((real)combined_age < 55.5), 0.021944327, -0.010982858));

s7_N128_4 :=  __common__( map(trim(C_BORN_USA) = ''     => s7_N128_5,
              ((real)c_born_usa < 28.5) => 0.050023569,
                                           s7_N128_5));

s7_N128_3 :=  __common__( if(((real)c_ownocc_p < 21.75), -0.016859658, s7_N128_4));

s7_N128_2 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N128_3, 0.024794972));

s7_N128_1 :=  __common__( if(((real)add1_lres < 0.5), s7_N128_2, s7_N128_6));

s7_N129_12 :=  __common__( map(trim(C_MED_AGE) = ''      => 0.080385155,
               ((real)c_med_age < 109.5) => 0.019142258,
                                            0.080385155));

s7_N129_11 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => s7_N129_12,
               (prof_license_category in ['0'])                     => 0.18385601,
                                                                       s7_N129_12));

s7_N129_10 :=  __common__( if(((real)c_retired < 11.65), s7_N129_11, -4.1172902e-005));

s7_N129_9 :=  __common__( if(trim(C_RETIRED) != '', s7_N129_10, -0.028875118));

s7_N129_8 :=  __common__( if(((real)add1_unit_count < 10.5), 5.7581751e-005, s7_N129_9));

s7_N129_7 :=  __common__( if(((real)c_lar_fam < 82.5), -0.012038784, -0.00080997817));

s7_N129_6 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N129_7, 0.0037535052));

s7_N129_5 :=  __common__( if(((real)_prop_owned_total < 0.5), s7_N129_6, s7_N129_8));

s7_N129_4 :=  __common__( if(((real)c_highinc < 3.15), 0.047236504, 0.0026457538));

s7_N129_3 :=  __common__( if(trim(C_HIGHINC) != '', s7_N129_4, 0.5));

s7_N129_2 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 18.5), s7_N129_3, s7_N129_5));

s7_N129_1 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N129_2, -0.0011204379));

s7_N130_8 :=  __common__( if(((real)_rel_criminal_total < 2.5), -0.00095048223, 0.027422179));

s7_N130_7 :=  __common__( if(((real)age < 69.5), 0.0028303289, s7_N130_8));

s7_N130_6 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s7_N130_7, 0.044872));

s7_N130_5 :=  __common__( map(trim(C_BEL_EDU) = ''       => 0.060678009,
              ((integer)c_bel_edu < 109) => 0.0033589964,
                                            0.060678009));

s7_N130_4 :=  __common__( if(((real)c_hval_100k_p < 26.35), 0.0024031142, s7_N130_5));

s7_N130_3 :=  __common__( if(trim(C_HVAL_100K_P) != '', s7_N130_4, 0.0186581));

s7_N130_2 :=  __common__( if(((integer)add1_avm_med < 301933), -0.0058986119, s7_N130_3));

s7_N130_1 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 0.5), s7_N130_2, s7_N130_6));

s7_N131_8 :=  __common__( if(((real)rc_lnamecount < 1.5), 0.026172763, 0.00015819421));

s7_N131_7 :=  __common__( if(((real)c_vacant_p < 3.45), -0.0048128879, 0.02787349));

s7_N131_6 :=  __common__( if(trim(C_VACANT_P) != '', s7_N131_7, -0.03444251));

s7_N131_5 :=  __common__( if(((real)age < 51.5), s7_N131_6, -0.019959242));

s7_N131_4 :=  __common__( if(((real)add2_nhood_vacant_properties < 6.5), 0.031809606, s7_N131_5));

s7_N131_3 :=  __common__( if((combo_dobscore < 80), s7_N131_4, s7_N131_8));

s7_N131_2 :=  __common__( if((rc_dirsaddr_lastscore < 88), 0.010760276, -0.012626013));

s7_N131_1 :=  __common__( if(((real)_ssncount < 1.5), s7_N131_2, s7_N131_3));

s7_N132_11 :=  __common__( map(trim(C_INC_15K_P) = ''      => 0.041137709,
               ((real)c_inc_15k_p < 11.45) => 0.0094354048,
                                              0.041137709));

s7_N132_10 :=  __common__( if(((real)c_rnt500_p < 35.65), s7_N132_11, -0.0075681619));

s7_N132_9 :=  __common__( if(trim(C_RNT500_P) != '', s7_N132_10, 0.070121489));

s7_N132_8 :=  __common__( if(((real)_add_risk < 0.5), -0.00025364887, s7_N132_9));

s7_N132_7 :=  __common__( if(((real)add_errorcode < 0.5), s7_N132_8, -0.023662678));

s7_N132_6 :=  __common__( if(((real)mth_header_first_seen < 74.5), 0.030324578, -0.00068451315));

s7_N132_5 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N132_6, 0.032143652));

s7_N132_4 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N132_5, -0.01613928));

s7_N132_3 :=  __common__( if(((real)c_incollege < 6.95), s7_N132_4, 0.026785845));

s7_N132_2 :=  __common__( if(trim(C_INCOLLEGE) != '', s7_N132_3, 0.024814343));

s7_N132_1 :=  __common__( if(((real)add1_lres < 0.5), s7_N132_2, s7_N132_7));

s7_N133_8 :=  __common__( map(trim(C_POP_25_34_P) = ''      => 0.034134592,
              ((real)c_pop_25_34_p < 32.15) => 0.0015827951,
                                               0.034134592));

s7_N133_7 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.039757463,
              ((real)c_hhsize < 4.055) => s7_N133_8,
                                          0.039757463));

s7_N133_6 :=  __common__( if(mth_header_first_seen != null and ((real)mth_header_first_seen < 57.5), 0.0050078276, 0.052064503));

s7_N133_5 :=  __common__( if(((real)combo_dobcount < 5.5), s7_N133_6, 0.010470473));

s7_N133_4 :=  __common__( if(((real)c_retired < 3.95), s7_N133_5, s7_N133_7));

s7_N133_3 :=  __common__( if(trim(C_RETIRED) != '', s7_N133_4, 0.010922679));

s7_N133_2 :=  __common__( if(((real)rc_addrcount < 1.5), -0.007668623, -0.0014250268));

s7_N133_1 :=  __common__( if(((real)add_bestmatch_level < 1.5), s7_N133_2, s7_N133_3));

s7_N134_9 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), -0.0023903394, 0.0096721529));

s7_N134_8 :=  __common__( map(trim(C_MURDERS) = ''      => -0.005361985,
              ((integer)c_murders < 58) => 0.029322094,
                                           -0.005361985));

s7_N134_7 :=  __common__( map((prof_license_category in ['1', '2', '5']) => s7_N134_8,
              (prof_license_category in ['0', '3', '4']) => 0.090873505,
                                                            s7_N134_8));

s7_N134_6 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N134_7,
              ((real)c_rnt750_p < 18.15) => 0.043786702,
                                            s7_N134_7));

s7_N134_5 :=  __common__( map(trim(C_AB_AV_EDU) = ''     => s7_N134_6,
              ((real)c_ab_av_edu < 59.5) => -0.018050363,
                                            s7_N134_6));

s7_N134_4 :=  __common__( if((combo_dobscore < 98), s7_N134_5, s7_N134_9));

s7_N134_3 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), -0.002497905, s7_N134_4));

s7_N134_2 :=  __common__( if(((real)c_low_ed < 82.45), s7_N134_3, 0.020594001));

s7_N134_1 :=  __common__( if(trim(C_LOW_ED) != '', s7_N134_2, 0.0012933197));

s7_N135_8 :=  __common__( if(((real)_addrs_5yr < 3.5), 0.011833305, 0.063229188));

s7_N135_7 :=  __common__( if(((real)c_mort_indx < 50.5), s7_N135_8, 0.0079320509));

s7_N135_6 :=  __common__( if(trim(C_MORT_INDX) != '', s7_N135_7, 0.04586892));

s7_N135_5 :=  __common__( if(((real)_addr_score < 2.5), s7_N135_6, -0.010788311));

s7_N135_4 :=  __common__( if(((real)_rel_criminal_count < 3.5), s7_N135_5, 0.040475048));

s7_N135_3 :=  __common__( if(((real)_adls_per_addr_cap10 < 1.5), s7_N135_4, 0.001801606));

s7_N135_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 3.5), s7_N135_3, 0.029801765));

s7_N135_1 :=  __common__( if(((real)add_bestmatch_level < 1.5), -0.0013827298, s7_N135_2));

s7_N136_8 :=  __common__( if(((real)c_incollege < 7.4), -0.0079646416, 0.038711392));

s7_N136_7 :=  __common__( if(trim(C_INCOLLEGE) != '', s7_N136_8, -0.029731711));

s7_N136_6 :=  __common__( if(((real)add2_source_count < 5.5), s7_N136_7, 0.043949684));

s7_N136_5 :=  __common__( if(((real)combined_age < 60.5), 0.016690019, 0.055439822));

s7_N136_4 :=  __common__( if(((real)_addr_stability_v2 < 5.5), s7_N136_5, 0.0060962727));

s7_N136_3 :=  __common__( if(((real)add1_lres < 70.5), 0.00014481397, s7_N136_4));

s7_N136_2 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.0020271518, s7_N136_3));

s7_N136_1 :=  __common__( if(((real)_nap < 5.5), s7_N136_2, s7_N136_6));

s7_N137_8 :=  __common__( if(((real)add1_source_count < 4.5), 0.045394965, -0.0027182976));

s7_N137_7 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.082381581,
              ((real)c_easiqlife < 141.5) => 0.030122179,
                                             0.082381581));

s7_N137_6 :=  __common__( map(trim(C_INCOLLEGE) = ''      => 0.0052371417,
              ((real)c_incollege < 13.05) => s7_N137_7,
                                             0.0052371417));

s7_N137_5 :=  __common__( map(trim(C_LOWINC) = ''      => s7_N137_6,
              ((real)c_lowinc < 25.45) => -0.0041685148,
                                          s7_N137_6));

s7_N137_4 :=  __common__( map(trim(C_MED_HHINC) = ''         => -0.00078706291,
              ((integer)c_med_hhinc < 12622) => -0.024600494,
                                                -0.00078706291));

s7_N137_3 :=  __common__( if(((real)c_pop_25_34_p < 28.95), s7_N137_4, s7_N137_5));

s7_N137_2 :=  __common__( if(trim(C_POP_25_34_P) != '', s7_N137_3, -0.010853419));

s7_N137_1 :=  __common__( if(((real)add2_source_count < 10.5), s7_N137_2, s7_N137_8));

s7_N138_10 :=  __common__( if(((real)add_bestmatch_level < 1.5), 0.016218145, 0.037312123));

s7_N138_9 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => 0.0032665904,
              ((real)c_fammar18_p < 28.05) => s7_N138_10,
                                              0.0032665904));

s7_N138_8 :=  __common__( map(trim(C_HVAL_100K_P) = ''     => -0.0034663861,
              ((real)c_hval_100k_p < 4.05) => s7_N138_9,
                                              -0.0034663861));

s7_N138_7 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 19.5), 0.043780808, s7_N138_8));

s7_N138_6 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N138_7, -0.00087260259));

s7_N138_5 :=  __common__( if(((real)_adls_per_addr_c6 < 2.5), s7_N138_6, 0.023549423));

s7_N138_4 :=  __common__( if(((real)_rel_count_addr < 0.5), s7_N138_5, -0.0016259638));

s7_N138_3 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.0034020169,
              ((real)c_incollege < 6.95) => 0.055484912,
                                            0.0034020169));

s7_N138_2 :=  __common__( if(((real)c_recent_mov < 2.5), s7_N138_3, s7_N138_4));

s7_N138_1 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N138_2, -0.0073591923));

s7_N139_8 :=  __common__( map(trim(C_HVAL_100K_P) = ''     => 0.06202317,
              ((real)c_hval_100k_p < 5.45) => 0.014322878,
                                              0.06202317));

s7_N139_7 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.042772633,
              ((real)c_easiqlife < 131.5) => 0.011584051,
                                             0.042772633));

s7_N139_6 :=  __common__( map(trim(C_UNATTACH) = ''      => s7_N139_7,
              ((real)c_unattach < 115.5) => 0.0029756778,
                                            s7_N139_7));

s7_N139_5 :=  __common__( if(((real)add2_source_count < 4.5), s7_N139_6, s7_N139_8));

s7_N139_4 :=  __common__( if(((real)add2_lres < 54.5), s7_N139_5, 0.0036583856));

s7_N139_3 :=  __common__( if(((real)c_born_usa < 56.5), s7_N139_4, -0.0012512396));

s7_N139_2 :=  __common__( if(trim(C_BORN_USA) != '', s7_N139_3, 0.026596875));

s7_N139_1 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), -0.0017150372, s7_N139_2));

s7_N140_9 :=  __common__( if(((real)c_recent_mov < 50.5), 0.054476611, 0.0026739778));

s7_N140_8 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N140_9, -0.026035851));

s7_N140_7 :=  __common__( map(trim(C_HIGHINC) = ''     => 0.017901209,
              ((real)c_highinc < 3.05) => 0.042887833,
                                          0.017901209));

s7_N140_6 :=  __common__( if(((real)add1_turnover_1yr_in < 667.5), -0.0046667709, s7_N140_7));

s7_N140_5 :=  __common__( if(trim(C_RNT750_P) != '', s7_N140_6, 0.024378374));

s7_N140_4 :=  __common__( if(((real)add1_source_count < 1.5), 0.0076574539, -0.00038514757));

s7_N140_3 :=  __common__( if(((real)_addr_score < 2.5), s7_N140_4, -0.010978733));

s7_N140_2 :=  __common__( if(((real)add1_unit_count < 351.5), s7_N140_3, s7_N140_5));

s7_N140_1 :=  __common__( if(((real)add1_lres < 474.5), s7_N140_2, s7_N140_8));

s7_N141_9 :=  __common__( map(trim(C_RAPE) = ''     => 0.0021788427,
              ((real)c_rape < 14.5) => 0.02353866,
                                       0.0021788427));

s7_N141_8 :=  __common__( if((add2_avm_automated_valuation < 270217), -0.0014988344, s7_N141_9));

s7_N141_7 :=  __common__( map(trim(C_RECENT_MOV) = ''    => s7_N141_8,
              ((real)c_recent_mov < 2.5) => 0.031367621,
                                            s7_N141_8));

s7_N141_6 :=  __common__( map(trim(C_CIV_EMP) = ''     => 0.0085652086,
              ((real)c_civ_emp < 47.6) => 0.053017951,
                                          0.0085652086));

s7_N141_5 :=  __common__( map(trim(C_VACANT_P) = ''     => -0.01080506,
              ((real)c_vacant_p < 12.1) => 0.026805047,
                                           -0.01080506));

s7_N141_4 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.023899324,
              ((integer)c_fammar_p < 26) => s7_N141_5,
                                            -0.023899324));

s7_N141_3 :=  __common__( map(trim(C_FAMMAR_P) = ''      => s7_N141_6,
              ((real)c_fammar_p < 29.05) => s7_N141_4,
                                            s7_N141_6));

s7_N141_2 :=  __common__( if(((real)c_fammar_p < 34.45), s7_N141_3, s7_N141_7));

s7_N141_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N141_2, -0.0032260518));

s7_N142_8 :=  __common__( if(((real)add1_turnover_1yr_in < 148.5), 0.030262638, -0.001231763));

s7_N142_7 :=  __common__( if(((real)_phones_per_addr < 4.5), s7_N142_8, 0.047859307));

s7_N142_6 :=  __common__( if(((real)c_born_usa < 6.5), 0.067791301, s7_N142_7));

s7_N142_5 :=  __common__( if(trim(C_BORN_USA) != '', s7_N142_6, 0.05200482));

s7_N142_4 :=  __common__( if(((real)_infutor_nap < 2.5), 0.00060652126, s7_N142_5));

s7_N142_3 :=  __common__( if(((real)_inq_collection_count < 4.5), s7_N142_4, 0.038741767));

s7_N142_2 :=  __common__( if(((real)add1_lres < 159.5), -0.0021823116, s7_N142_3));

s7_N142_1 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.019946638, s7_N142_2));

s7_N143_9 :=  __common__( if(((real)ssn_lowissue_age < 13.9691), 0.052866111, 0.01759345));

s7_N143_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N143_9, 0.029767735));

s7_N143_7 :=  __common__( if(((real)add3_lres < 26.5), -0.014860276, 0.033885786));

s7_N143_6 :=  __common__( map(trim(C_CHILD) = ''      => s7_N143_8,
              ((real)c_child < 24.25) => s7_N143_7,
                                         s7_N143_8));

s7_N143_5 :=  __common__( if(((real)_nap < 3.5), 0.0066232915, s7_N143_6));

s7_N143_4 :=  __common__( if(((integer)c_med_rent < 853), s7_N143_5, -0.01048159));

s7_N143_3 :=  __common__( if(trim(C_MED_RENT) != '', s7_N143_4, 0.041626702));

s7_N143_2 :=  __common__( if(((real)_add_risk < 0.5), s7_N143_3, -0.0060735402));

s7_N143_1 :=  __common__( if(((real)add1_source_count < 1.5), s7_N143_2, -0.00037438048));

s7_N144_8 :=  __common__( if(((real)c_hval_40k_p < 5.4), 0.015715671, 0.053573415));

s7_N144_7 :=  __common__( if(trim(C_HVAL_40K_P) != '', s7_N144_8, -0.027557671));

s7_N144_6 :=  __common__( if(((real)combo_dobcount < 4.5), s7_N144_7, 0.0011009748));

s7_N144_5 :=  __common__( if(((real)_phone_score < 2.5), 0.018575571, 0.044945687));

s7_N144_4 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0045854543, s7_N144_5));

s7_N144_3 :=  __common__( if(((real)_addrs_10yr < 3.5), s7_N144_4, -0.001216551));

s7_N144_2 :=  __common__( if(((real)gong_did_addr_ct < 0.5), -0.0054127207, s7_N144_3));

s7_N144_1 :=  __common__( if(((real)_altlname < 0.5), s7_N144_2, s7_N144_6));

s7_N145_10 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.029205512,
               ((real)c_bel_edu < 134.5) => 0.0038427935,
                                            0.029205512));

s7_N145_9 :=  __common__( if(((real)mth_attr_date_last_derog < 56.5), 0.063084222, 0.011552213));

s7_N145_8 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N145_9, s7_N145_10));

s7_N145_7 :=  __common__( map(trim(C_BLUE_COL) = ''      => s7_N145_8,
              ((real)c_blue_col < 14.75) => -0.0032541434,
                                            s7_N145_8));

s7_N145_6 :=  __common__( if(((real)_rel_felony_count < 0.5), -0.0020575852, s7_N145_7));

s7_N145_5 :=  __common__( if(((real)add1_no_of_baths2 > NULL), 0.0072446061, 0.082147205));

s7_N145_4 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0090071961, s7_N145_5));

s7_N145_3 :=  __common__( if(((integer)add1_turnover_1yr_in < 1139), 0.0060203395, s7_N145_4));

s7_N145_2 :=  __common__( if(((real)c_low_ed < 14.25), s7_N145_3, s7_N145_6));

s7_N145_1 :=  __common__( if(trim(C_LOW_ED) != '', s7_N145_2, -0.0097557851));

s7_N146_10 :=  __common__( map(trim(C_OWNOCC_P) = ''      => 0.045266395,
               ((real)c_ownocc_p < 74.55) => -0.002821698,
                                             0.045266395));

s7_N146_9 :=  __common__( if(((integer)rc_lnamessnmatch < 0.5), 0.030605465, s7_N146_10));

s7_N146_8 :=  __common__( if(((real)rc_phoneaddrcount < 0.5), -0.001018511, -0.037444369));

s7_N146_7 :=  __common__( map(trim(C_SFDU_P) = ''      => 9.7373801e-005,
              ((real)c_sfdu_p < 19.75) => 0.018019598,
                                          9.7373801e-005));

s7_N146_6 :=  __common__( if(((real)add1_building_area2 < 1173.5), 0.019890407, 0.00037519193));

s7_N146_5 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N146_6, s7_N146_7));

s7_N146_4 :=  __common__( map(trim(C_EASIQLIFE) = ''      => s7_N146_5,
              ((real)c_easiqlife < 118.5) => -0.0016299327,
                                             s7_N146_5));

s7_N146_3 :=  __common__( if(((real)did_count < 1.5), s7_N146_4, s7_N146_8));

s7_N146_2 :=  __common__( if(((real)c_span_lang < 195.5), s7_N146_3, s7_N146_9));

s7_N146_1 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N146_2, -0.0033821357));

s7_N147_10 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), -0.0052493478, 0.063749237));

s7_N147_9 :=  __common__( map(trim(C_FOR_SALE) = ''      => 0.0089378298,
              ((real)c_for_sale < 103.5) => s7_N147_10,
                                            0.0089378298));

s7_N147_8 :=  __common__( map(trim(C_VACANT_P) = ''     => s7_N147_9,
              ((real)c_vacant_p < 6.75) => -0.004885756,
                                           s7_N147_9));

s7_N147_7 :=  __common__( if(((real)add1_turnover_1yr_in < 1615.5), -0.0025963482, s7_N147_8));

s7_N147_6 :=  __common__( if(((real)combo_dobcount < 3.5), 0.035575988, 0.0072712151));

s7_N147_5 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), 0.001227838, s7_N147_6));

s7_N147_4 :=  __common__( if(((real)c_totcrime < 184.5), s7_N147_5, 0.044312958));

s7_N147_3 :=  __common__( if(trim(C_TOTCRIME) != '', s7_N147_4, -0.012114198));

s7_N147_2 :=  __common__( if(((real)age < 35.5), -0.0056458927, s7_N147_3));

s7_N147_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N147_2, s7_N147_7));

s7_N148_8 :=  __common__( map(trim(C_SFDU_P) = ''     => 0.031274796,
              ((real)c_sfdu_p < 71.4) => 0.00024640063,
                                         0.031274796));

s7_N148_7 :=  __common__( if((avg_lres < 89), -0.0038059513, s7_N148_8));

s7_N148_6 :=  __common__( if(((real)c_rnt750_p < 16.3), -0.029914445, -0.0082784528));

s7_N148_5 :=  __common__( if(trim(C_RNT750_P) != '', s7_N148_6, -0.028884796));

s7_N148_4 :=  __common__( if(((real)_ssns_per_adl < 1.5), 0.0043032595, -0.028595466));

s7_N148_3 :=  __common__( if(((real)add1_nhood_vacant_properties < 18.5), s7_N148_4, s7_N148_5));

s7_N148_2 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), s7_N148_3, s7_N148_7));

s7_N148_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N148_2, 0.00096392459));

s7_N149_10 :=  __common__( if(((real)c_low_hval < 34.4), 0.0057916583, 0.049496412));

s7_N149_9 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N149_10, 0.049550262));

s7_N149_8 :=  __common__( map(trim(C_HIGHRENT) = ''     => 0.015706917,
              ((real)c_highrent < 12.6) => 0.11113666,
                                           0.015706917));

s7_N149_7 :=  __common__( if(((real)_inq_collection_count < 0.5), 0.023172237, s7_N149_8));

s7_N149_6 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N149_7, 0.0059103655));

s7_N149_5 :=  __common__( map(trim(C_CARTHEFT) = ''     => 0.0029198892,
              ((real)c_cartheft < 47.5) => s7_N149_6,
                                           0.0029198892));

s7_N149_4 :=  __common__( if(((real)c_inc_201k_p < 8.65), 1.402178e-005, s7_N149_5));

s7_N149_3 :=  __common__( if(trim(C_INC_201K_P) != '', s7_N149_4, 0.022801356));

s7_N149_2 :=  __common__( if(((real)add1_lres < 79.5), -0.0037431904, s7_N149_3));

s7_N149_1 :=  __common__( if(((real)add1_unit_count < 488.5), s7_N149_2, s7_N149_9));

s7_N150_8 :=  __common__( if(((real)mth_header_first_seen < 412.5), 0.0054564991, 0.037844347));

s7_N150_7 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N150_8, -0.0014442889));

s7_N150_6 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.019178932,
              ((real)c_incollege < 5.85) => -0.013022508,
                                            0.019178932));

s7_N150_5 :=  __common__( map(trim(C_OWNOCC_P) = ''      => 0.027315843,
              ((real)c_ownocc_p < 78.75) => s7_N150_6,
                                            0.027315843));

s7_N150_4 :=  __common__( if(((real)add2_lres < 121.5), -0.0063409042, s7_N150_5));

s7_N150_3 :=  __common__( if(((real)c_vacant_p < 17.3), s7_N150_4, -0.025739389));

s7_N150_2 :=  __common__( if(trim(C_VACANT_P) != '', s7_N150_3, -0.0097242608));

s7_N150_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N150_2, s7_N150_7));

s7_N151_10 :=  __common__( map(trim(C_ROBBERY) = ''      => 0.06945441,
               ((real)c_robbery < 124.5) => 0.028495955,
                                            0.06945441));

s7_N151_9 :=  __common__( if(((real)c_bel_edu < 60.5), 0.0051545573, s7_N151_10));

s7_N151_8 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N151_9, -0.026576376));

s7_N151_7 :=  __common__( if(((integer)c_totsales < 67280), 0.0054917457, 0.059973712));

s7_N151_6 :=  __common__( if(trim(C_TOTSALES) != '', s7_N151_7, -0.026145846));

s7_N151_5 :=  __common__( if(((real)add2_avm_to_med_ratio < 0.878085), -0.019460533, 0.039218948));

s7_N151_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N151_5, s7_N151_6));

s7_N151_3 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N151_4, 0.00083961967));

s7_N151_2 :=  __common__( if(((real)avg_lres < 217.5), s7_N151_3, s7_N151_8));

s7_N151_1 :=  __common__( if(((real)_phone_score < 2.5), -0.00022989715, s7_N151_2));

s7_N152_8 :=  __common__( if(((real)combo_dobcount < 1.5), 0.033563785, 0.001672011));

s7_N152_7 :=  __common__( if(((real)_rel_criminal_total < 1.5), s7_N152_8, 0.059049483));

s7_N152_6 :=  __common__( map(trim(C_INCOLLEGE) = ''     => -0.0071408365,
              ((real)c_incollege < 4.45) => 0.029558185,
                                            -0.0071408365));

s7_N152_5 :=  __common__( if(((real)c_rnt500_p < 15.7), s7_N152_6, s7_N152_7));

s7_N152_4 :=  __common__( if(trim(C_RNT500_P) != '', s7_N152_5, -0.027500379));

s7_N152_3 :=  __common__( if(((real)combo_dobcount < 4.5), s7_N152_4, 0.003429666));

s7_N152_2 :=  __common__( if(((integer)rc_lnamessnmatch < 0.5), -0.0066036699, 0.00023157194));

s7_N152_1 :=  __common__( if(((real)_altlname < 0.5), s7_N152_2, s7_N152_3));

s7_N153_8 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.0012872943,
              ((real)c_civ_emp < 44.45) => -0.02182882,
                                           0.0012872943));

s7_N153_7 :=  __common__( if(((real)input_dob_match_level < 3.5), 0.02616746, 0.0052941715));

s7_N153_6 :=  __common__( if(((real)_wealth_index < 2.5), s7_N153_7, s7_N153_8));

s7_N153_5 :=  __common__( if(((real)_inq_peraddr_cap8 < 5.5), s7_N153_6, 0.02554836));

s7_N153_4 :=  __common__( if(((real)c_pop_18_24_p < 3.45), 0.032445531, s7_N153_5));

s7_N153_3 :=  __common__( if(trim(C_POP_18_24_P) != '', s7_N153_4, 0.0106899));

s7_N153_2 :=  __common__( if(((real)gong_did_phone_ct < 2.5), s7_N153_3, 0.031303928));

s7_N153_1 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N153_2, 0.00020004468));

s7_N154_10 :=  __common__( if(((real)_ssns_per_addr < 0.5), 0.049628379, 0.014709174));

s7_N154_9 :=  __common__( if(((real)avg_lres < 67.5), -0.0086521316, 0.034174012));

s7_N154_8 :=  __common__( map(trim(C_ROBBERY) = ''      => s7_N154_10,
              ((real)c_robbery < 136.5) => s7_N154_9,
                                           s7_N154_10));

s7_N154_7 :=  __common__( if(((real)_add_risk < 0.5), s7_N154_8, -0.0049984608));

s7_N154_6 :=  __common__( if(((real)_addr_stability_v2 < 4.5), -0.022830499, 0.01614905));

s7_N154_5 :=  __common__( map(trim(C_MED_HVAL) = ''        => s7_N154_6,
              ((real)c_med_hval < 98112.5) => 0.017070372,
                                              s7_N154_6));

s7_N154_4 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N154_5, s7_N154_7));

s7_N154_3 :=  __common__( if(((real)add1_lres < 2.5), s7_N154_4, -0.0005099375));

s7_N154_2 :=  __common__( if(((integer)c_lar_fam < 36), -0.012352744, s7_N154_3));

s7_N154_1 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N154_2, 0.0015710254));

s7_N155_9 :=  __common__( if(((real)_adls_per_addr_c6 < 1.5), 0.064644809, 0.029943636));

s7_N155_8 :=  __common__( if(((real)c_unemp < 3.15), s7_N155_9, 0.015320154));

s7_N155_7 :=  __common__( if(trim(C_UNEMP) != '', s7_N155_8, -0.0017695202));

s7_N155_6 :=  __common__( if(((real)_add_risk < 0.5), s7_N155_7, -0.0026441236));

s7_N155_5 :=  __common__( if(((integer)lname_eda_sourced < 0.5), s7_N155_6, 0.0018309005));

s7_N155_4 :=  __common__( if(((real)c_inc_50k_p < 17.75), -0.01813988, 0.02032046));

s7_N155_3 :=  __common__( if(trim(C_INC_50K_P) != '', s7_N155_4, -0.028317973));

s7_N155_2 :=  __common__( if(((real)avg_lres < 24.5), s7_N155_3, s7_N155_5));

s7_N155_1 :=  __common__( if(((real)add1_lres < 1.5), s7_N155_2, -0.00075177239));

s7_N156_9 :=  __common__( if(((real)c_femdiv_p < 3.85), -0.0059647666, 0.041067732));

s7_N156_8 :=  __common__( if(trim(C_FEMDIV_P) != '', s7_N156_9, 0.057516959));

s7_N156_7 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.0007444104,
              ((integer)c_fammar_p < 80) => 0.049060904,
                                            -0.0007444104));

s7_N156_6 :=  __common__( if(((real)age < 67.5), 0.0029231048, s7_N156_7));

s7_N156_5 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N156_6, 0.076834761));

s7_N156_4 :=  __common__( if(((real)c_fammar_p < 44.85), 0.038978755, s7_N156_5));

s7_N156_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N156_4, -0.011341427));

s7_N156_2 :=  __common__( if(((real)_rel_count_addr < 4.5), -0.00013235893, s7_N156_3));

s7_N156_1 :=  __common__( if(((real)_rel_felony_total < 4.5), s7_N156_2, s7_N156_8));

s7_N157_9 :=  __common__( map(trim(C_HIGH_ED) = ''      => 0.011245355,
              ((integer)c_high_ed < 15) => 0.052090743,
                                           0.011245355));

s7_N157_8 :=  __common__( map(trim(C_RNT750_P) = ''    => -0.0072913939,
              ((real)c_rnt750_p < 3.4) => 0.036937001,
                                          -0.0072913939));

s7_N157_7 :=  __common__( map(trim(C_APT20) = ''      => s7_N157_9,
              ((real)c_apt20 < 164.5) => s7_N157_8,
                                         s7_N157_9));

s7_N157_6 :=  __common__( map(trim(C_UNEMPL) = ''      => s7_N157_7,
              ((real)c_unempl < 167.5) => 0.0034436795,
                                          s7_N157_7));

s7_N157_5 :=  __common__( if(((real)_rel_felony_total < 3.5), s7_N157_6, 0.037668573));

s7_N157_4 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.050723695,
              ((real)c_civ_emp < 83.15) => s7_N157_5,
                                           0.050723695));

s7_N157_3 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0010170307, s7_N157_4));

s7_N157_2 :=  __common__( if(((real)c_unattach < 87.5), -0.0035342197, s7_N157_3));

s7_N157_1 :=  __common__( if(trim(C_UNATTACH) != '', s7_N157_2, 0.0032692799));

s7_N158_8 :=  __common__( if(((real)add1_nhood_vacant_properties < 4.5), 0.11227171, 0.005593856));

s7_N158_7 :=  __common__( if(((real)_crim_rel_within100miles < 0.5), 0.0021313837, s7_N158_8));

s7_N158_6 :=  __common__( if(((real)_adls_per_addr_c6 < 2.5), s7_N158_7, 0.055207233));

s7_N158_5 :=  __common__( if(((real)combo_dobcount < 4.5), 0.050563651, s7_N158_6));

s7_N158_4 :=  __common__( if(((real)c_fammar_p < 71.5), 0.022400533, -0.0012699339));

s7_N158_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N158_4, 0.010959153));

s7_N158_2 :=  __common__( if(((real)add1_unit_count < 355.5), -0.0013883975, s7_N158_3));

s7_N158_1 :=  __common__( if(((real)add1_source_count < 10.5), s7_N158_2, s7_N158_5));

s7_N159_8 :=  __common__( map(trim(C_RETIRED2) = ''       => 0.0080783053,
              ((integer)c_retired2 < 112) => 0.068691561,
                                             0.0080783053));

s7_N159_7 :=  __common__( map(trim(C_VACANT_P) = ''     => 0.0043357285,
              ((real)c_vacant_p < 4.95) => 0.070182856,
                                           0.0043357285));

s7_N159_6 :=  __common__( if(((real)_rel_educationunder8_count < 2.5), 0.0007047375, s7_N159_7));

s7_N159_5 :=  __common__( if(((real)mth_header_first_seen > NULL), -0.0070073767, 0.25792247));

s7_N159_4 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), s7_N159_5, s7_N159_6));

s7_N159_3 :=  __common__( if(((real)c_vacant_p < 11.15), s7_N159_4, s7_N159_8));

s7_N159_2 :=  __common__( if(trim(C_VACANT_P) != '', s7_N159_3, 0.034165881));

s7_N159_1 :=  __common__( if(((real)_rel_bankrupt_count < 4.5), 7.2943045e-005, s7_N159_2));

s7_N160_9 :=  __common__( if(((real)_wealth_index < 1.5), 0.034727216, -0.018531972));

s7_N160_8 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => 0.032637319,
              ((real)c_asian_lang < 141.5) => -0.0012636308,
                                              0.032637319));

s7_N160_7 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), s7_N160_8, 0.042226521));

s7_N160_6 :=  __common__( if(((real)phn_cellpager < 0.5), 0.0027699227, s7_N160_7));

s7_N160_5 :=  __common__( if(((real)age < 58.5), -0.00060657788, s7_N160_6));

s7_N160_4 :=  __common__( map(trim(C_LAR_FAM) = ''      => s7_N160_5,
              ((integer)c_lar_fam < 36) => -0.012836773,
                                           s7_N160_5));

s7_N160_3 :=  __common__( map(trim(C_BORN_USA) = ''      => -0.00077412234,
              ((integer)c_born_usa < 77) => 0.033751728,
                                            -0.00077412234));

s7_N160_2 :=  __common__( if(((real)c_fammar_p < 25.75), s7_N160_3, s7_N160_4));

s7_N160_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N160_2, s7_N160_9));

s7_N161_8 :=  __common__( map(trim(C_WHITE_COL) = ''      => 0.083018,
              ((real)c_white_col < 29.25) => 0.017430251,
                                             0.083018));

s7_N161_7 :=  __common__( if(((real)_rel_within25miles_count < 3.5), -0.0016998053, s7_N161_8));

s7_N161_6 :=  __common__( map(trim(C_APT20) = ''     => s7_N161_7,
              ((real)c_apt20 < 99.5) => 0.0035255375,
                                        s7_N161_7));

s7_N161_5 :=  __common__( map(trim(C_BORN_USA) = ''     => s7_N161_6,
              ((real)c_born_usa < 28.5) => 0.044102364,
                                           s7_N161_6));

s7_N161_4 :=  __common__( if(((real)c_med_hval < 90930.5), s7_N161_5, 0.0014355338));

s7_N161_3 :=  __common__( if(trim(C_MED_HVAL) != '', s7_N161_4, 0.029739003));

s7_N161_2 :=  __common__( if(((real)rc_addrcount < 1.5), -0.0055451747, 1.2795463e-005));

s7_N161_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), s7_N161_2, s7_N161_3));

s7_N162_8 :=  __common__( if((combo_dobscore < 45), 0.017127007, -5.5896024e-005));

s7_N162_7 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((real)mth_ver_src_fsrc_fdate < 7.5), 0.03409021, s7_N162_8));

s7_N162_6 :=  __common__( if(((integer)add2_avm_med < 169270), 0.018006109, -0.0079455843));

s7_N162_5 :=  __common__( if(((real)_rel_count_addr < 1.5), s7_N162_6, -0.013208053));

s7_N162_4 :=  __common__( if(((real)c_inc_150k_p < 0.55), -0.030383161, s7_N162_5));

s7_N162_3 :=  __common__( if(trim(C_INC_150K_P) != '', s7_N162_4, -0.042030845));

s7_N162_2 :=  __common__( if(((real)combined_age < 19.5), 0.018553107, s7_N162_3));

s7_N162_1 :=  __common__( if(((real)_ssncount < 1.5), s7_N162_2, s7_N162_7));

s7_N163_10 :=  __common__( if(((integer)add2_turnover_1yr_in < 284), 0.048703273, -0.0023914213));

s7_N163_9 :=  __common__( if(((real)add1_unit_count < 0.5), 0.025063436, 0.00072621936));

s7_N163_8 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), 0.5, 0.0011324685));

s7_N163_7 :=  __common__( if(((real)add1_unit_count < 10.5), s7_N163_8, 0.049407319));

s7_N163_6 :=  __common__( if(((real)mth_header_first_seen < 15.5), s7_N163_7, s7_N163_9));

s7_N163_5 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N163_6, 0.0079438157));

s7_N163_4 :=  __common__( if(((integer)_ams_income_level < 0), s7_N163_5, -0.0069163904));

s7_N163_3 :=  __common__( map(trim(C_ASSAULT) = ''      => -0.011960184,
              ((real)c_assault < 189.5) => s7_N163_4,
                                           -0.011960184));

s7_N163_2 :=  __common__( if(((real)c_murders < 198.5), s7_N163_3, s7_N163_10));

s7_N163_1 :=  __common__( if(trim(C_MURDERS) != '', s7_N163_2, 0.00073801918));

s7_N164_8 :=  __common__( map(trim(C_RECENT_MOV) = ''     => -0.0044708563,
              ((real)c_recent_mov < 70.5) => 0.034771038,
                                             -0.0044708563));

s7_N164_7 :=  __common__( if(((real)c_fammar_p < 66.7), 0.031637271, s7_N164_8));

s7_N164_6 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N164_7, -0.028742519));

s7_N164_5 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), s7_N164_6, 0.041294661));

s7_N164_4 :=  __common__( if(((real)phn_cellpager < 0.5), 0.0029606324, s7_N164_5));

s7_N164_3 :=  __common__( if(((real)_inq_count < 4.5), 0.0032911771, 0.026917346));

s7_N164_2 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N164_3, -0.0026865513));

s7_N164_1 :=  __common__( if(((real)combined_age < 59.5), s7_N164_2, s7_N164_4));

s7_N165_8 :=  __common__( map(trim(C_CHILD) = ''      => 0.097197799,
              ((real)c_child < 27.75) => 0.039880886,
                                         0.097197799));

s7_N165_7 :=  __common__( if(((integer)add1_turnover_1yr_in < 345), 0.0013998668, 0.042154546));

s7_N165_6 :=  __common__( if(((integer)add1_avm_med < 220416), s7_N165_7, s7_N165_8));

s7_N165_5 :=  __common__( map(trim(C_CARTHEFT) = ''      => s7_N165_6,
              ((integer)c_cartheft < 31) => -0.018738435,
                                            s7_N165_6));

s7_N165_4 :=  __common__( if(((real)_rel_homeunder50_count < 2.5), s7_N165_5, -0.013720309));

s7_N165_3 :=  __common__( if(((real)c_mort_indx < 101.5), s7_N165_4, -0.001804422));

s7_N165_2 :=  __common__( if(trim(C_MORT_INDX) != '', s7_N165_3, 0.092238019));

s7_N165_1 :=  __common__( if(((real)combined_age < 78.5), -0.00084775665, s7_N165_2));

s7_N166_9 :=  __common__( if(((integer)c_no_move < 105), -0.0077562671, -0.034784183));

s7_N166_8 :=  __common__( if(trim(C_NO_MOVE) != '', s7_N166_9, -0.028586129));

s7_N166_7 :=  __common__( if(((real)_addrs_15yr < 9.5), -0.0013300175, -0.018465984));

s7_N166_6 :=  __common__( if(((real)_altlname < 0.5), s7_N166_7, 0.017058143));

s7_N166_5 :=  __common__( if(trim(C_RNT500_P) != '', s7_N166_6, 0.016779327));

s7_N166_4 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '5']) => s7_N166_5,
              (prof_license_category in ['4'])                     => 0.049050735,
                                                                      s7_N166_5));

s7_N166_3 :=  __common__( if(((real)_ssns_per_adl < 1.5), s7_N166_4, s7_N166_8));

s7_N166_2 :=  __common__( if(((real)add_errorcode < 0.5), s7_N166_3, -0.030914891));

s7_N166_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N166_2, 0.00097275585));

s7_N167_8 :=  __common__( if(((real)mth_gong_did_first_seen < 93.5), 0.02275224, 0.065042877));

s7_N167_7 :=  __common__( map(trim(C_INC_25K_P) = ''     => -0.0090131315,
              ((real)c_inc_25k_p < 4.25) => 0.026799587,
                                            -0.0090131315));

s7_N167_6 :=  __common__( map(trim(C_YOUNG) = ''     => 0.043146372,
              ((real)c_young < 29.5) => 0.0051753859,
                                        0.043146372));

s7_N167_5 :=  __common__( if(((real)c_fammar_p < 70.8), s7_N167_6, s7_N167_7));

s7_N167_4 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N167_5, 0.0035116772));

s7_N167_3 :=  __common__( if(((real)avg_lres < 152.5), s7_N167_4, s7_N167_8));

s7_N167_2 :=  __common__( if(((real)_phones_per_adl_c6 < 0.5), 0.0006289679, s7_N167_3));

s7_N167_1 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N167_2, -0.0036762256));

s7_N168_8 :=  __common__( map(trim(C_MED_HVAL) = ''        => 0.021404061,
              ((real)c_med_hval < 92678.5) => 0.094393534,
                                              0.021404061));

s7_N168_7 :=  __common__( if(((integer)rc_lnamessnmatch2 < 0.5), 0.004251631, s7_N168_8));

s7_N168_6 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), 0.0025541771, 0.018615236));

s7_N168_5 :=  __common__( if(((real)c_hval_100k_p < 37.75), s7_N168_6, s7_N168_7));

s7_N168_4 :=  __common__( if(trim(C_HVAL_100K_P) != '', s7_N168_5, 0.011071503));

s7_N168_3 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N168_4, -0.00053975145));

s7_N168_2 :=  __common__( if(((real)ver_src_p < 0.5), -0.0053782983, s7_N168_3));

s7_N168_1 :=  __common__( if(((real)rc_lnamecount < 1.5), 0.014969564, s7_N168_2));

s7_N169_10 :=  __common__( map(trim(C_RNT250_P) = ''     => 0.044349752,
               ((real)c_rnt250_p < 1.35) => -0.0038505173,
                                            0.044349752));

s7_N169_9 :=  __common__( map(trim(C_ASIAN_LANG) = ''       => 0.019418743,
              ((integer)c_asian_lang < 159) => 0.087583835,
                                               0.019418743));

s7_N169_8 :=  __common__( map(trim(C_RENTOCC_P) = ''     => s7_N169_9,
              ((real)c_rentocc_p < 15.9) => -0.0040692347,
                                            s7_N169_9));

s7_N169_7 :=  __common__( if(((real)ssn_lowissue_age < 15.816), s7_N169_8, -0.018110596));

s7_N169_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N169_7, -0.061271887));

s7_N169_5 :=  __common__( if(((real)add1_source_count < 2.5), 0.037164684, s7_N169_6));

s7_N169_4 :=  __common__( if(((real)_prop_owned_total < 3.5), s7_N169_5, 0.065057586));

s7_N169_3 :=  __common__( map(trim(C_HVAL_500K_P) = ''      => s7_N169_4,
              ((real)c_hval_500k_p < 21.55) => -0.00089038501,
                                               s7_N169_4));

s7_N169_2 :=  __common__( if(((real)c_murders < 198.5), s7_N169_3, s7_N169_10));

s7_N169_1 :=  __common__( if(trim(C_MURDERS) != '', s7_N169_2, 0.0035201527));

s7_N170_8 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.047457703,
              ((real)c_incollege < 7.55) => 0.00010536172,
                                            0.047457703));

s7_N170_7 :=  __common__( map(trim(C_RETIRED2) = ''      => 0.053588373,
              ((real)c_retired2 < 137.5) => s7_N170_8,
                                            0.053588373));

s7_N170_6 :=  __common__( if(((integer)rc_fnamessnmatch < 0.5), s7_N170_7, 0.0041254963));

s7_N170_5 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.031564189,
              ((real)c_bel_edu < 171.5) => s7_N170_6,
                                           0.031564189));

s7_N170_4 :=  __common__( if(((real)c_fammar_p < 64.05), -0.010216776, s7_N170_5));

s7_N170_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N170_4, -0.026512517));

s7_N170_2 :=  __common__( if(((real)_wealth_index < 1.5), 0.033645424, s7_N170_3));

s7_N170_1 :=  __common__( if(((real)_altlname < 0.5), -0.00057020259, s7_N170_2));

s7_N171_8 :=  __common__( if(((real)age < 61.5), 0.021942482, -0.021434256));

s7_N171_7 :=  __common__( if(((real)add_bestmatch_level < 1.5), 0.0022524681, s7_N171_8));

s7_N171_6 :=  __common__( map(trim(C_RAPE) = ''      => -0.0081069342,
              ((real)c_rape < 114.5) => s7_N171_7,
                                        -0.0081069342));

s7_N171_5 :=  __common__( map(trim(C_FOR_SALE) = ''      => 0.050331626,
              ((real)c_for_sale < 138.5) => 0.0049122713,
                                            0.050331626));

s7_N171_4 :=  __common__( if(((integer)add1_avm_med < 6134), s7_N171_5, s7_N171_6));

s7_N171_3 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N171_4, -0.00059283238));

s7_N171_2 :=  __common__( if(trim(C_UNATTACH) != '', s7_N171_3, -0.010613884));

s7_N171_1 :=  __common__( if((add3_avm_automated_valuation < 1.53148e+006), s7_N171_2, 0.045240821));

s7_N172_8 :=  __common__( if(((integer)_ams_income_level < 0), 0.0045070857, -0.012544024));

s7_N172_7 :=  __common__( map((prof_license_category in ['0', '1', '3', '5']) => s7_N172_8,
              (prof_license_category in ['2', '4'])           => 0.054074209,
                                                                 s7_N172_8));

s7_N172_6 :=  __common__( if(((integer)add2_avm_med < 390095), s7_N172_7, -0.014767301));

s7_N172_5 :=  __common__( if(((real)add1_nhood_vacant_properties < 311.5), s7_N172_6, -0.027149837));

s7_N172_4 :=  __common__( if(((real)add2_lres < 262.5), s7_N172_5, 0.021686997));

s7_N172_3 :=  __common__( if(((real)c_fammar_p < 91.3), s7_N172_4, -0.02574767));

s7_N172_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N172_3, -0.0057885145));

s7_N172_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N172_2, 0.00020111667));

s7_N173_10 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => 0.014787179,
               (prof_license_category in ['0'])                     => 0.35165903,
                                                                       0.014787179));

s7_N173_9 :=  __common__( if(((real)c_inc_15k_p < 7.15), -0.013726286, s7_N173_10));

s7_N173_8 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N173_9, -0.026234781));

s7_N173_7 :=  __common__( if(ssn_lowissue_age != null and ((real)ssn_lowissue_age < 4.30586), 0.053292017, s7_N173_8));

s7_N173_6 :=  __common__( if(((real)_num_purchase60 < 1.5), s7_N173_7, 0.055716198));

s7_N173_5 :=  __common__( if(((real)combined_age < 68.5), 0.0053712027, 0.028301571));

s7_N173_4 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => s7_N173_5,
              (prof_license_category in ['0'])                     => 0.13433274,
                                                                      s7_N173_5));

s7_N173_3 :=  __common__( if(((real)_rel_bankrupt_count < 3.5), -0.0014456977, s7_N173_4));

s7_N173_2 :=  __common__( if(((real)mth_header_first_seen < 450.5), s7_N173_3, s7_N173_6));

s7_N173_1 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N173_2, -0.0048700875));

s7_N174_9 :=  __common__( if(((real)add1_nhood_vacant_properties < 2.5), 0.076197733, 0.022749336));

s7_N174_8 :=  __common__( map(trim(C_ASSAULT) = ''     => -0.00071756009,
              ((real)c_assault < 59.5) => 0.079758981,
                                          -0.00071756009));

s7_N174_7 :=  __common__( if(((real)add2_lres < 15.5), s7_N174_8, -0.006595838));

s7_N174_6 :=  __common__( map(trim(C_TOTSALES) = ''         => s7_N174_9,
              ((integer)c_totsales < 10657) => s7_N174_7,
                                               s7_N174_9));

s7_N174_5 :=  __common__( if(((real)combo_dobcount < 0.5), -0.026447321, -0.0084582542));

s7_N174_4 :=  __common__( map(trim(C_ASSAULT) = ''      => s7_N174_5,
              ((real)c_assault < 189.5) => -0.00068483924,
                                           s7_N174_5));

s7_N174_3 :=  __common__( map(trim(C_OWNOCC_P) = ''      => s7_N174_6,
              ((real)c_ownocc_p < 96.95) => s7_N174_4,
                                            s7_N174_6));

s7_N174_2 :=  __common__( if(((real)c_pop_25_34_p < 43.45), s7_N174_3, 0.038370639));

s7_N174_1 :=  __common__( if(trim(C_POP_25_34_P) != '', s7_N174_2, -0.0044559803));

s7_N175_8 :=  __common__( if(((real)_addrs_last90 < 0.5), -0.023363829, 0.029090811));

s7_N175_7 :=  __common__( if(((real)_inq_peraddr_cap8 < 3.5), 0.0064203643, 0.0352145));

s7_N175_6 :=  __common__( map(trim(C_APT20) = ''      => -0.01210623,
              ((real)c_apt20 < 175.5) => s7_N175_7,
                                         -0.01210623));

s7_N175_5 :=  __common__( if(((integer)add2_eda_sourced < 0.5), -0.0017603094, s7_N175_6));

s7_N175_4 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N175_5, s7_N175_8));

s7_N175_3 :=  __common__( map(trim(C_BLUE_COL) = ''      => -0.025401345,
              ((integer)c_blue_col < 11) => 0.014112161,
                                            -0.025401345));

s7_N175_2 :=  __common__( map(trim(C_BURGLARY) = ''       => 0.03508426,
              ((integer)c_burglary < 126) => s7_N175_3,
                                             0.03508426));

s7_N175_1 :=  __common__( if(((real)source_count < 1.5), s7_N175_2, s7_N175_4));

s7_N176_9 :=  __common__( if(((real)rc_addrcount < 1.5), -0.013534102, -0.0042842528));

s7_N176_8 :=  __common__( map(trim(C_HIGHINC) = ''      => 0.036720616,
              ((real)c_highinc < 12.55) => -0.0092045258,
                                           0.036720616));

s7_N176_7 :=  __common__( map(trim(C_INC_25K_P) = ''      => 0.032855737,
              ((real)c_inc_25k_p < 15.55) => s7_N176_8,
                                             0.032855737));

s7_N176_6 :=  __common__( if(((real)_ssns_per_adl < 1.5), s7_N176_7, 0.044531466));

s7_N176_5 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.0052564139,
              ((real)c_sfdu_p < 35.75) => s7_N176_6,
                                          0.0052564139));

s7_N176_4 :=  __common__( if(((real)_phone_score < 1.5), -0.00036062677, s7_N176_5));

s7_N176_3 :=  __common__( map(trim(C_LAR_FAM) = ''      => 0.040382034,
              ((real)c_lar_fam < 190.5) => s7_N176_4,
                                           0.040382034));

s7_N176_2 :=  __common__( if(((real)c_for_sale < 144.5), s7_N176_3, s7_N176_9));

s7_N176_1 :=  __common__( if(trim(C_FOR_SALE) != '', s7_N176_2, 0.0066501934));

s7_N177_8 :=  __common__( map(trim(C_EXP_HOMES) = ''      => -0.037778671,
              ((real)c_exp_homes < 183.5) => -0.003352878,
                                             -0.037778671));

s7_N177_7 :=  __common__( map(trim(C_BEL_EDU) = ''      => -0.029407885,
              ((real)c_bel_edu < 179.5) => s7_N177_8,
                                           -0.029407885));

s7_N177_6 :=  __common__( if((add1_lres < 44), -0.0020185408, 0.029836423));

s7_N177_5 :=  __common__( if(((real)rc_dirsaddr_lastscore < 70.5), s7_N177_6, s7_N177_7));

s7_N177_4 :=  __common__( map(trim(C_RNT500_P) = ''      => 0.019626916,
              ((integer)c_rnt500_p < 68) => s7_N177_5,
                                            0.019626916));

s7_N177_3 :=  __common__( if(((real)c_med_age < 158.5), s7_N177_4, -0.021570963));

s7_N177_2 :=  __common__( if(trim(C_MED_AGE) != '', s7_N177_3, -0.0061790483));

s7_N177_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N177_2, 0.00061116895));

s7_N178_10 :=  __common__( map(trim(C_BLUE_COL) = ''      => 0.0013757711,
               ((real)c_blue_col < 12.75) => 0.053544324,
                                             0.0013757711));

s7_N178_9 :=  __common__( if(((integer)add2_turnover_1yr_in < 262), 0.044475564, 0.0041544901));

s7_N178_8 :=  __common__( if(((real)_rel_educationunder12_count < 4.5), 0.0048913026, s7_N178_9));

s7_N178_7 :=  __common__( if(((real)combined_age < 68.5), s7_N178_8, 0.022201032));

s7_N178_6 :=  __common__( if(((real)_adls_per_phone < 0.5), s7_N178_7, s7_N178_10));

s7_N178_5 :=  __common__( if(((real)ssn_lowissue_age < 9.273), -0.0057128559, s7_N178_6));

s7_N178_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N178_5, 0.0025633883));

s7_N178_3 :=  __common__( if(((real)_phone_score < 2.5), -0.0010552182, s7_N178_4));

s7_N178_2 :=  __common__( if(((real)c_lowinc < 87.9), s7_N178_3, 0.02171651));

s7_N178_1 :=  __common__( if(trim(C_LOWINC) != '', s7_N178_2, 0.0031876512));

s7_N179_9 :=  __common__( map(trim(C_RNT250_P) = ''     => -0.022564664,
              ((real)c_rnt250_p < 4.95) => 0.014984745,
                                           -0.022564664));

s7_N179_8 :=  __common__( if(((integer)c_totsales < 756), 0.04907329, s7_N179_9));

s7_N179_7 :=  __common__( if(trim(C_TOTSALES) != '', s7_N179_8, 0.033214994));

s7_N179_6 :=  __common__( if(((real)_ssns_per_addr < 3.5), -0.0053343061, 0.031106841));

s7_N179_5 :=  __common__( if(((real)combined_age < 86.5), -0.00075037797, s7_N179_6));

s7_N179_4 :=  __common__( if(((real)add2_lres < 26.5), 0.038862665, 0.0056648841));

s7_N179_3 :=  __common__( if(((real)c_recent_mov < 3.5), s7_N179_4, s7_N179_5));

s7_N179_2 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N179_3, -0.013503223));

s7_N179_1 :=  __common__( if(((real)_nap < 5.5), s7_N179_2, s7_N179_7));

s7_N180_9 :=  __common__( map(trim(C_LOWINC) = ''      => 0.0015791447,
              ((real)c_lowinc < 34.25) => 0.052661121,
                                          0.0015791447));

s7_N180_8 :=  __common__( if(((real)c_lowinc < 20.55), -0.0059682447, s7_N180_9));

s7_N180_7 :=  __common__( if(trim(C_LOWINC) != '', s7_N180_8, -0.026558692));

s7_N180_6 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 112.5), -0.0037332303, 0.011528565));

s7_N180_5 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), -0.0021755789, s7_N180_6));

s7_N180_4 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N180_5, 0.035909657));

s7_N180_3 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N180_4, -0.00050568753));

s7_N180_2 :=  __common__( if(((real)combined_age < 86.5), s7_N180_3, s7_N180_7));

s7_N180_1 :=  __common__( if(((real)add_errorcode < 0.5), s7_N180_2, -0.016269509));

s7_N181_10 :=  __common__( if(((real)c_highinc < 4.4), 0.052081947, 0.0046973193));

s7_N181_9 :=  __common__( if(trim(C_HIGHINC) != '', s7_N181_10, 0.056871121));

s7_N181_8 :=  __common__( map(trim(C_INC_15K_P) = ''      => 0.040477514,
              ((real)c_inc_15k_p < 15.15) => 0.0043360151,
                                             0.040477514));

s7_N181_7 :=  __common__( if(((real)_adls_per_phone_c6 < 0.5), s7_N181_8, 0.096312702));

s7_N181_6 :=  __common__( if(((real)_phone_risk < 0.5), 0.0033145546, 0.040722155));

s7_N181_5 :=  __common__( if(((real)_phone_score < 1.5), s7_N181_6, s7_N181_7));

s7_N181_4 :=  __common__( if(((real)_util_adl_count < 1.5), s7_N181_5, -0.0028840537));

s7_N181_3 :=  __common__( if(((real)add2_avm_to_med_ratio < 0.853417), -0.0072621021, s7_N181_4));

s7_N181_2 :=  __common__( if(((real)add1_unit_count < 452.5), s7_N181_3, s7_N181_9));

s7_N181_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N181_2, 0.00014367689));

s7_N182_11 :=  __common__( if((add1_avm_automated_valuation < 699949), 0.0074925912, 0.06058943));

s7_N182_10 :=  __common__( map(trim(C_INC_15K_P) = ''      => 0.040081299,
               ((real)c_inc_15k_p < 12.85) => 0.0090495157,
                                              0.040081299));

s7_N182_9 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N182_10, 0.0031202356));

s7_N182_8 :=  __common__( map(trim(C_WHITE_COL) = ''      => s7_N182_9,
              ((real)c_white_col < 59.95) => -0.0014052613,
                                             s7_N182_9));

s7_N182_7 :=  __common__( if(((real)c_fammar18_p < 8.75), -0.013014256, s7_N182_8));

s7_N182_6 :=  __common__( if(trim(C_FAMMAR18_P) != '', s7_N182_7, 0.0051907988));

s7_N182_5 :=  __common__( if(((real)c_many_cars < 35.5), 0.04349193, 0.00085307678));

s7_N182_4 :=  __common__( if(trim(C_MANY_CARS) != '', s7_N182_5, 0.23353808));

s7_N182_3 :=  __common__( if(((real)mth_header_first_seen < 16.5), s7_N182_4, s7_N182_6));

s7_N182_2 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N182_3, 0.0064687817));

s7_N182_1 :=  __common__( if(((integer)add3_eda_sourced < 0.5), s7_N182_2, s7_N182_11));

s7_N183_9 :=  __common__( if(((integer)add1_nhood_vacant_properties < 109), 0.029484963, -0.014754935));

s7_N183_8 :=  __common__( if(((real)add1_source_count < 1.5), s7_N183_9, -0.0005739517));

s7_N183_7 :=  __common__( if(((real)_add_apt < 0.5), -0.006129962, 0.015103218));

s7_N183_6 :=  __common__( map(trim(C_CARTHEFT) = ''      => -0.01736779,
              ((real)c_cartheft < 153.5) => 0.0075435508,
                                            -0.01736779));

s7_N183_5 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N183_6, s7_N183_7));

s7_N183_4 :=  __common__( map(trim(C_LAR_FAM) = ''     => s7_N183_5,
              ((real)c_lar_fam < 64.5) => -0.016497105,
                                          s7_N183_5));

s7_N183_3 :=  __common__( if(((real)c_vacant_p < 11.95), s7_N183_4, -0.021976739));

s7_N183_2 :=  __common__( if(trim(C_VACANT_P) != '', s7_N183_3, -0.0045324548));

s7_N183_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N183_2, s7_N183_8));

s7_N184_9 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 0.5), 0.0033547392, 0.041299686));

s7_N184_8 :=  __common__( if(((real)add1_lres < 5.5), s7_N184_9, -0.0039186847));

s7_N184_7 :=  __common__( map(trim(C_CHILD) = ''     => s7_N184_8,
              ((real)c_child < 6.95) => 0.035585461,
                                        s7_N184_8));

s7_N184_6 :=  __common__( if(((integer)add1_building_area2 < 1843), 0.016108326, -0.0015388401));

s7_N184_5 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N184_6, s7_N184_7));

s7_N184_4 :=  __common__( if(((real)c_hval_100k_p < 41.45), s7_N184_5, 0.03732808));

s7_N184_3 :=  __common__( if(trim(C_HVAL_100K_P) != '', s7_N184_4, 0.01640773));

s7_N184_2 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N184_3, -5.6592533e-005));

s7_N184_1 :=  __common__( if(((real)combined_age < 38.5), -0.0033145769, s7_N184_2));

s7_N185_9 :=  __common__( if(((real)add1_lres < 43.5), -0.0069831441, 0.03319025));

s7_N185_8 :=  __common__( if(((real)age < 55.5), s7_N185_9, -0.023999997));

s7_N185_7 :=  __common__( if(((real)_rel_homeunder50_count < 0.5), 0.041830569, s7_N185_8));

s7_N185_6 :=  __common__( if(((real)attr_num_nonderogs30 < 5.5), -0.0030224719, 0.083840293));

s7_N185_5 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N185_6,
              ((real)c_civ_emp < 85.35) => -0.00039469127,
                                           s7_N185_6));

s7_N185_4 :=  __common__( if(((real)_adl_score < 1.5), s7_N185_5, s7_N185_7));

s7_N185_3 :=  __common__( map(trim(C_BLUE_EMPL) = ''    => s7_N185_4,
              ((real)c_blue_empl < 3.5) => -0.02244492,
                                           s7_N185_4));

s7_N185_2 :=  __common__( if(((real)c_lowinc < 86.1), s7_N185_3, 0.022322232));

s7_N185_1 :=  __common__( if(trim(C_LOWINC) != '', s7_N185_2, -0.0034028943));

s7_N186_8 :=  __common__( map(trim(C_INC_15K_P) = ''     => 0.080714719,
              ((real)c_inc_15k_p < 6.95) => 0.011234909,
                                            0.080714719));

s7_N186_7 :=  __common__( map(trim(C_YOUNG) = ''      => 0.048831612,
              ((real)c_young < 23.95) => 0.0090173397,
                                         0.048831612));

s7_N186_6 :=  __common__( map(trim(C_RENTOCC_P) = ''      => 0.020508425,
              ((real)c_rentocc_p < 73.05) => -2.3314599e-005,
                                             0.020508425));

s7_N186_5 :=  __common__( if(((real)_adls_per_phone_c6 < 0.5), s7_N186_6, 0.036964392));

s7_N186_4 :=  __common__( if(((real)_rel_educationunder8_count < 4.5), s7_N186_5, s7_N186_7));

s7_N186_3 :=  __common__( if(trim(C_TOTCRIME) != '', s7_N186_4, -0.0073645681));

s7_N186_2 :=  __common__( if(((real)add1_source_count < 11.5), s7_N186_3, s7_N186_8));

s7_N186_1 :=  __common__( if(((real)_phone_score < 2.5), -0.00052840824, s7_N186_2));

s7_N187_9 :=  __common__( if(((real)_addrs_10yr < 3.5), 0.043328128, 0.0052593435));

s7_N187_8 :=  __common__( if(((real)_ssns_per_addr < 8.5), -0.0065101459, s7_N187_9));

s7_N187_7 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N187_8,
              ((real)c_civ_emp < 45.15) => 0.034430687,
                                           s7_N187_8));

s7_N187_6 :=  __common__( if(((real)c_sfdu_p < 95.75), s7_N187_7, 0.048633487));

s7_N187_5 :=  __common__( if(trim(C_SFDU_P) != '', s7_N187_6, 0.060068946));

s7_N187_4 :=  __common__( if(((real)c_pop_25_34_p < 12.25), -0.0098773902, 0.0082725753));

s7_N187_3 :=  __common__( if(trim(C_POP_25_34_P) != '', s7_N187_4, 0.013391124));

s7_N187_2 :=  __common__( if(((real)combined_age < 52.5), s7_N187_3, s7_N187_5));

s7_N187_1 :=  __common__( if(((real)_phone_score < 2.5), -0.00059565195, s7_N187_2));

s7_N188_10 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => 0.050139265,
               ((real)c_asian_lang < 177.5) => 0.00020765872,
                                               0.050139265));

s7_N188_9 :=  __common__( if(((real)add2_source_count < 4.5), -0.019136206, 0.03581375));

s7_N188_8 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), 0.17980608, 0.00027197957));

s7_N188_7 :=  __common__( if(((integer)lname_eda_sourced < 0.5), 0.080120279, 0.018639574));

s7_N188_6 :=  __common__( if(((real)add1_building_area2 < 1653.5), s7_N188_7, s7_N188_8));

s7_N188_5 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N188_6, s7_N188_9));

s7_N188_4 :=  __common__( if(((real)_inq_perssn < 2.5), -0.00088988613, s7_N188_5));

s7_N188_3 :=  __common__( map(trim(C_LAR_FAM) = ''      => s7_N188_4,
              ((integer)c_lar_fam < 36) => -0.012653641,
                                           s7_N188_4));

s7_N188_2 :=  __common__( if(((real)c_apt20 < 197.5), s7_N188_3, s7_N188_10));

s7_N188_1 :=  __common__( if(trim(C_APT20) != '', s7_N188_2, 0.011408689));

s7_N189_9 :=  __common__( if(((real)add1_source_count < 3.5), 0.042701531, 0.014428264));

s7_N189_8 :=  __common__( if(((real)c_highrent < 1.75), s7_N189_9, -0.021005645));

s7_N189_7 :=  __common__( if(trim(C_HIGHRENT) != '', s7_N189_8, -0.026262367));

s7_N189_6 :=  __common__( if(((real)_rel_count_addr < 0.5), 0.048245287, s7_N189_7));

s7_N189_5 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0038045749, 0.035153664));

s7_N189_4 :=  __common__( if(((real)c_born_usa < 11.5), s7_N189_5, 5.4564682e-005));

s7_N189_3 :=  __common__( if(trim(C_BORN_USA) != '', s7_N189_4, 0.02462317));

s7_N189_2 :=  __common__( if(((real)add2_naprop < 3.5), s7_N189_3, s7_N189_6));

s7_N189_1 :=  __common__( if((rc_dirsaddr_lastscore < 72), s7_N189_2, -0.0010438644));

s7_N190_9 :=  __common__( map(trim(C_FAMMAR18_P) = ''     => 0.034117611,
              ((real)c_fammar18_p < 34.6) => -0.0098906552,
                                             0.034117611));

s7_N190_8 :=  __common__( if(((real)add2_nhood_vacant_properties < 136.5), s7_N190_9, 0.066414828));

s7_N190_7 :=  __common__( map((prof_license_category in ['0', '1', '2', '3']) => s7_N190_8,
              (prof_license_category in ['4', '5'])           => 0.5,
                                                                 s7_N190_8));

s7_N190_6 :=  __common__( if(((real)add2_lres < 17.5), 0.016957617, -0.017195113));

s7_N190_5 :=  __common__( map(trim(C_POP_18_24_P) = ''      => s7_N190_7,
              ((real)c_pop_18_24_p < 10.55) => s7_N190_6,
                                               s7_N190_7));

s7_N190_4 :=  __common__( if(((real)add1_lres < 7.5), 0.03162982, s7_N190_5));

s7_N190_3 :=  __common__( if(((real)_addr_score < 2.5), 0.00020960546, -0.0083778882));

s7_N190_2 :=  __common__( if(((real)c_low_hval < 72.05), s7_N190_3, s7_N190_4));

s7_N190_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N190_2, -0.0027262137));

s7_N191_8 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.0023410602,
              ((real)c_relig_indx < 123.5) => 0.05588542,
                                              0.0023410602));

s7_N191_7 :=  __common__( if(((real)c_cartheft < 177.5), 0.00050772505, s7_N191_8));

s7_N191_6 :=  __common__( if(trim(C_CARTHEFT) != '', s7_N191_7, 0.020603532));

s7_N191_5 :=  __common__( if(((real)combined_age < 69.5), 0.0003826482, 0.0096003169));

s7_N191_4 :=  __common__( if(((real)_inq_peraddr_cap8 < 7.5), s7_N191_5, 0.029771641));

s7_N191_3 :=  __common__( if((combo_dobscore < 55), -0.01773422, -0.0041309964));

s7_N191_2 :=  __common__( if(((real)_ssns_per_addr < 5.5), s7_N191_3, s7_N191_4));

s7_N191_1 :=  __common__( if(((real)add1_unit_count < 498.5), s7_N191_2, s7_N191_6));

s7_N192_8 :=  __common__( if((add1_lres < 133), 0.0077800275, 0.039632926));

s7_N192_7 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N192_8, -0.0031641962));

s7_N192_6 :=  __common__( map(trim(C_NO_MOVE) = ''     => 0.017223725,
              ((real)c_no_move < 88.5) => 0.049794462,
                                          0.017223725));

s7_N192_5 :=  __common__( if(((real)_rel_incomeunder50_count < 4.5), 0.0043525078, s7_N192_6));

s7_N192_4 :=  __common__( if(((real)combo_dobcount < 3.5), s7_N192_5, s7_N192_7));

s7_N192_3 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 200.5), -0.005456381, 0.0011254982));

s7_N192_2 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N192_3, -0.0011228913));

s7_N192_1 :=  __common__( if(((real)_altlname < 0.5), s7_N192_2, s7_N192_4));

s7_N193_9 :=  __common__( if(((real)c_blue_col < 3.85), 0.029439466, 0.0031621694));

s7_N193_8 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N193_9, 0.012952096));

s7_N193_7 :=  __common__( if(((real)_phone_score < 1.5), -0.0019935395, s7_N193_8));

s7_N193_6 :=  __common__( if(((real)_addr_score < 2.5), 0.013763357, -0.020694415));

s7_N193_5 :=  __common__( map(trim(C_SFDU_P) = ''      => s7_N193_6,
              ((real)c_sfdu_p < 40.65) => 0.030071687,
                                          s7_N193_6));

s7_N193_4 :=  __common__( if(((real)avg_lres < 21.5), -0.0093249959, s7_N193_5));

s7_N193_3 :=  __common__( if(((real)c_unattach < 151.5), s7_N193_4, 0.029837533));

s7_N193_2 :=  __common__( if(trim(C_UNATTACH) != '', s7_N193_3, -0.005589221));

s7_N193_1 :=  __common__( if(((real)add1_lres < 1.5), s7_N193_2, s7_N193_7));

s7_N194_9 :=  __common__( if(ssn_lowissue_age != null and ((real)ssn_lowissue_age < 15.2067), 0.065383679, 0.012373576));

s7_N194_8 :=  __common__( map(trim(C_MORT_INDX) = ''       => -0.0081887175,
              ((integer)c_mort_indx < 153) => s7_N194_9,
                                              -0.0081887175));

s7_N194_7 :=  __common__( map(trim(C_MANY_CARS) = ''     => 0.0031481288,
              ((real)c_many_cars < 54.5) => s7_N194_8,
                                            0.0031481288));

s7_N194_6 :=  __common__( map(trim(C_HVAL_100K_P) = ''      => s7_N194_7,
              ((real)c_hval_100k_p < 37.35) => -0.001048307,
                                               s7_N194_7));

s7_N194_5 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.027709481,
              ((real)c_hhsize < 4.405) => s7_N194_6,
                                          0.027709481));

s7_N194_4 :=  __common__( map(trim(C_LOWINC) = ''      => 0.033434248,
              ((real)c_lowinc < 56.75) => -0.0093553975,
                                          0.033434248));

s7_N194_3 :=  __common__( if(((real)source_count < 3.5), s7_N194_4, -0.012718718));

s7_N194_2 :=  __common__( if(((real)c_med_age < 14.5), s7_N194_3, s7_N194_5));

s7_N194_1 :=  __common__( if(trim(C_MED_AGE) != '', s7_N194_2, -0.00076063626));

s7_N195_8 :=  __common__( map((prof_license_category in ['0', '1', '2', '5']) => -0.0054703452,
              (prof_license_category in ['3', '4'])           => 0.07764452,
                                                                 -0.0054703452));

s7_N195_7 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 0.5), s7_N195_8, 0.046059645));

s7_N195_6 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), -0.00052600513, 0.0069091017));

s7_N195_5 :=  __common__( if(((real)_nap < 5.5), s7_N195_6, s7_N195_7));

s7_N195_4 :=  __common__( if(((real)age < 40.5), 0.047697261, -0.0026401065));

s7_N195_3 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N195_4, 0.0076712966));

s7_N195_2 :=  __common__( if(((real)add1_lres < 0.5), s7_N195_3, s7_N195_5));

s7_N195_1 :=  __common__( if(((real)_addr_score < 2.5), s7_N195_2, -0.0080312155));

s7_N196_8 :=  __common__( map(trim(C_POP_18_24_P) = ''     => 0.02451677,
              ((real)c_pop_18_24_p < 8.15) => -0.0021630725,
                                              0.02451677));

s7_N196_7 :=  __common__( map(trim(C_BIGAPT_P) = ''      => 0.028675709,
              ((real)c_bigapt_p < 61.95) => -0.0012390426,
                                            0.028675709));

s7_N196_6 :=  __common__( if(((real)c_hval_80k_p < 11.95), s7_N196_7, s7_N196_8));

s7_N196_5 :=  __common__( if(trim(C_HVAL_80K_P) != '', s7_N196_6, -0.004079678));

s7_N196_4 :=  __common__( if(((real)age < 65.5), s7_N196_5, -0.018846311));

s7_N196_3 :=  __common__( if(((real)add1_source_count < 8.5), s7_N196_4, 0.025242897));

s7_N196_2 :=  __common__( if(((real)_addrs_last90 < 2.5), s7_N196_3, 0.030554954));

s7_N196_1 :=  __common__( if(((real)combo_dobcount < 1.5), s7_N196_2, -0.00072710539));

s7_N197_11 :=  __common__( if(((real)rc_lnamecount < 5.5), -0.0029072254, 0.024966272));

s7_N197_10 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), -0.021666869, s7_N197_11));

s7_N197_9 :=  __common__( if(((real)input_dob_match_level < 4.5), s7_N197_10, -0.0028326816));

s7_N197_8 :=  __common__( if(((real)c_highinc < 2.35), 0.051176523, 0.0046065863));

s7_N197_7 :=  __common__( if(trim(C_HIGHINC) != '', s7_N197_8, -0.027314899));

s7_N197_6 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 25.5), s7_N197_7, s7_N197_9));

s7_N197_5 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N197_6, -0.0071211358));

s7_N197_4 :=  __common__( map(trim(C_MORT_INDX) = ''     => 0.0098924813,
              ((real)c_mort_indx < 72.5) => 0.093362241,
                                            0.0098924813));

s7_N197_3 :=  __common__( if((add1_avm_automated_valuation < 373282), 0.0057413206, s7_N197_4));

s7_N197_2 :=  __common__( if(((real)add1_building_area2 < 1039.5), s7_N197_3, -0.0020959636));

s7_N197_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N197_2, s7_N197_5));

s7_N198_10 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0054751071, 0.018745918));

s7_N198_9 :=  __common__( if(((real)c_many_cars < 141.5), s7_N198_10, 0.059781104));

s7_N198_8 :=  __common__( if(trim(C_MANY_CARS) != '', s7_N198_9, 0.31906307));

s7_N198_7 :=  __common__( if(((real)_phones_per_addr_c6 < 1.5), -0.0038344134, s7_N198_8));

s7_N198_6 :=  __common__( if(((real)add1_turnover_1yr_in < 2243.5), s7_N198_7, 0.021074558));

s7_N198_5 :=  __common__( if(((real)add1_building_area2 > NULL), 0.0009295734, s7_N198_6));

s7_N198_4 :=  __common__( if(((real)c_rnt250_p < 9.45), -0.0086733261, 0.045420916));

s7_N198_3 :=  __common__( if(trim(C_RNT250_P) != '', s7_N198_4, -0.025775988));

s7_N198_2 :=  __common__( if(((real)_addr_stability_v2 < 2.5), 0.041819221, s7_N198_3));

s7_N198_1 :=  __common__( if(((real)_rel_count < 0.5), s7_N198_2, s7_N198_5));

s7_N199_9 :=  __common__( map(trim(C_BURGLARY) = ''      => 0.010195913,
              ((real)c_burglary < 164.5) => -0.0087926429,
                                            0.010195913));

s7_N199_8 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N199_9, -0.00042075482));

s7_N199_7 :=  __common__( map(trim(C_CHILD) = ''      => 0.0032558929,
              ((real)c_child < 28.35) => 0.14216486,
                                         0.0032558929));

s7_N199_6 :=  __common__( map(trim(C_EASIQLIFE) = ''     => 0.0041505399,
              ((real)c_easiqlife < 56.5) => s7_N199_7,
                                            0.0041505399));

s7_N199_5 :=  __common__( map(trim(C_LOWRENT) = ''     => 0.043715749,
              ((real)c_lowrent < 5.25) => -0.013220293,
                                          0.043715749));

s7_N199_4 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => 0.058666059,
              ((real)c_fammar18_p < 21.35) => s7_N199_5,
                                              0.058666059));

s7_N199_3 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => s7_N199_6,
              ((real)c_fammar18_p < 25.65) => s7_N199_4,
                                              s7_N199_6));

s7_N199_2 :=  __common__( if(((real)c_bel_edu < 13.5), s7_N199_3, s7_N199_8));

s7_N199_1 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N199_2, -0.006342947));

s7_N200_8 :=  __common__( if((add1_lres < 95), 0.0042438186, -0.022147735));

s7_N200_7 :=  __common__( map(trim(C_HIGHINC) = ''      => 0.022391794,
              ((real)c_highinc < 10.15) => -0.0081533646,
                                           0.022391794));

s7_N200_6 :=  __common__( map(trim(C_LARCENY) = ''      => 0.033023887,
              ((real)c_larceny < 151.5) => s7_N200_7,
                                           0.033023887));

s7_N200_5 :=  __common__( if(((real)combo_dobcount < 7.5), s7_N200_6, s7_N200_8));

s7_N200_4 :=  __common__( if(((real)attr_num_nonderogs90 < 3.5), -0.0090013958, s7_N200_5));

s7_N200_3 :=  __common__( if(((real)c_vacant_p < 10.85), s7_N200_4, -0.017240088));

s7_N200_2 :=  __common__( if(trim(C_VACANT_P) != '', s7_N200_3, 0.0029371649));

s7_N200_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N200_2, 0.0010671533));

s7_N201_9 :=  __common__( map(trim(C_LARCENY) = ''       => 0.055346332,
              ((integer)c_larceny < 178) => 0.0095408236,
                                            0.055346332));

s7_N201_8 :=  __common__( if(((real)add1_source_count < 7.5), 0.037820685, 0.11197023));

s7_N201_7 :=  __common__( if(((real)c_assault < 21.5), s7_N201_8, s7_N201_9));

s7_N201_6 :=  __common__( if(trim(C_ASSAULT) != '', s7_N201_7, 0.046982894));

s7_N201_5 :=  __common__( if(((real)_car_current < 0.5), -0.0023642951, s7_N201_6));

s7_N201_4 :=  __common__( if(((real)c_fammar_p < 36.15), 0.022306776, -0.000876658));

s7_N201_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N201_4, -0.028673405));

s7_N201_2 :=  __common__( if(((real)_inq_collection_count < 0.5), s7_N201_3, s7_N201_5));

s7_N201_1 :=  __common__( if(((integer)add1_avm_med < 327362), -0.0022730749, s7_N201_2));

s7_N202_9 :=  __common__( if(((real)c_totcrime < 184.5), 0.002101457, 0.03947117));

s7_N202_8 :=  __common__( if(trim(C_TOTCRIME) != '', s7_N202_9, -0.027699635));

s7_N202_7 :=  __common__( map(trim(C_EASIQLIFE) = ''       => 0.053072253,
              ((integer)c_easiqlife < 107) => 0.01425677,
                                              0.053072253));

s7_N202_6 :=  __common__( if(((real)c_hval_40k_p < 3.9), s7_N202_7, -0.0021516326));

s7_N202_5 :=  __common__( if(trim(C_HVAL_40K_P) != '', s7_N202_6, 0.0032411606));

s7_N202_4 :=  __common__( if(((real)avg_lres < 55.5), -0.025789035, 0.011226061));

s7_N202_3 :=  __common__( if(((real)_nap < 3.5), s7_N202_4, s7_N202_5));

s7_N202_2 :=  __common__( if(((real)add1_source_count < 1.5), s7_N202_3, s7_N202_8));

s7_N202_1 :=  __common__( if(((real)_prop_owned_total < 0.5), -0.0033138068, s7_N202_2));

s7_N203_9 :=  __common__( map(trim(C_UNEMPL) = ''     => 0.017893658,
              ((real)c_unempl < 64.5) => 0.077250701,
                                         0.017893658));

s7_N203_8 :=  __common__( if(((real)add3_lres < 16.5), s7_N203_9, 0.0021972508));

s7_N203_7 :=  __common__( if(((real)add1_source_count < 2.5), -0.018547529, 6.5747508e-005));

s7_N203_6 :=  __common__( map(trim(C_TRAILER_P) = ''     => s7_N203_8,
              ((real)c_trailer_p < 0.45) => s7_N203_7,
                                            s7_N203_8));

s7_N203_5 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.046868139,
              ((real)c_sfdu_p < 98.35) => s7_N203_6,
                                          0.046868139));

s7_N203_4 :=  __common__( map(trim(C_HIGH_ED) = ''     => -0.0028108477,
              ((real)c_high_ed < 9.25) => s7_N203_5,
                                          -0.0028108477));

s7_N203_3 :=  __common__( map(trim(C_CHILD) = ''      => 0.037346989,
              ((real)c_child < 39.85) => 0.0046384814,
                                         0.037346989));

s7_N203_2 :=  __common__( if(((real)c_larceny < 37.5), s7_N203_3, s7_N203_4));

s7_N203_1 :=  __common__( if(trim(C_LARCENY) != '', s7_N203_2, -0.012071114));

s7_N204_8 :=  __common__( if(((real)c_vacant_p < 5.6), 0.00031825218, 0.038130827));

s7_N204_7 :=  __common__( if(trim(C_VACANT_P) != '', s7_N204_8, -0.028582612));

s7_N204_6 :=  __common__( if(((real)add3_lres < 17.5), -0.0026145481, 0.042479302));

s7_N204_5 :=  __common__( if(((integer)add3_avm_automated_valuation < 547950), -0.00097972971, 0.035108514));

s7_N204_4 :=  __common__( if(((real)add1_turnover_1yr_in < 1134.5), s7_N204_5, s7_N204_6));

s7_N204_3 :=  __common__( if(((real)_rel_homeunder100_count < 4.5), s7_N204_4, s7_N204_7));

s7_N204_2 :=  __common__( if(((real)combo_dobcount < 1.5), s7_N204_3, -0.00061768291));

s7_N204_1 :=  __common__( if(((real)attr_num_nonderogs90 < 2.5), -0.0068279676, s7_N204_2));

s7_N205_8 :=  __common__( if(((real)_ssns_per_addr < 8.5), 0.00017834418, 0.032195771));

s7_N205_7 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.017589704,
              ((real)c_relig_indx < 157.5) => -0.0021679254,
                                              0.017589704));

s7_N205_6 :=  __common__( if(((real)_rel_count < 1.5), 0.039564466, s7_N205_7));

s7_N205_5 :=  __common__( if(((real)add2_lres < 33.5), 0.058176378, 0.014243326));

s7_N205_4 :=  __common__( map(trim(C_OWNOCC_P) = ''      => s7_N205_6,
              ((real)c_ownocc_p < 10.65) => s7_N205_5,
                                            s7_N205_6));

s7_N205_3 :=  __common__( if(((integer)c_med_hval < 261699), -0.001206134, s7_N205_4));

s7_N205_2 :=  __common__( if(trim(C_MED_HVAL) != '', s7_N205_3, -0.010641623));

s7_N205_1 :=  __common__( if(((real)_nap < 5.5), s7_N205_2, s7_N205_8));

s7_N206_8 :=  __common__( map(trim(C_SPAN_LANG) = ''       => 0.044999044,
              ((integer)c_span_lang < 135) => 0.020283652,
                                              0.044999044));

s7_N206_7 :=  __common__( if(((real)combo_dobcount < 2.5), -0.00087164374, s7_N206_8));

s7_N206_6 :=  __common__( if(((real)c_robbery < 53.5), -0.018624322, s7_N206_7));

s7_N206_5 :=  __common__( if(trim(C_ROBBERY) != '', s7_N206_6, 0.06295713));

s7_N206_4 :=  __common__( if(((real)_rel_bankrupt_count < 1.5), 0.0071517751, 0.042625666));

s7_N206_3 :=  __common__( if(((real)add1_source_count < 4.5), s7_N206_4, 0.0018067891));

s7_N206_2 :=  __common__( if(((real)add2_source_count < 7.5), -0.0015266109, s7_N206_3));

s7_N206_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N206_2, s7_N206_5));

s7_N207_8 :=  __common__( if(((real)_inq_count < 0.5), 0.0019562219, -0.028924662));

s7_N207_7 :=  __common__( if(((real)_rel_vehicle_owned_count < 2.5), s7_N207_8, 0.018013868));

s7_N207_6 :=  __common__( if(((real)combined_age < 38.5), 0.030896275, s7_N207_7));

s7_N207_5 :=  __common__( map(trim(C_UNEMP) = ''     => 0.045539179,
              ((real)c_unemp < 5.05) => 0.0027232327,
                                        0.045539179));

s7_N207_4 :=  __common__( map(trim(C_INC_50K_P) = ''      => s7_N207_5,
              ((real)c_inc_50k_p < 24.35) => -0.00077347539,
                                             s7_N207_5));

s7_N207_3 :=  __common__( if(((real)c_highrent < 65.75), s7_N207_4, -0.016489834));

s7_N207_2 :=  __common__( if(trim(C_HIGHRENT) != '', s7_N207_3, 0.00018913364));

s7_N207_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N207_2, s7_N207_6));

s7_N208_8 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0026567443, 0.029144491));

s7_N208_7 :=  __common__( if(((real)_nap < 5.5), 0.0014367078, s7_N208_8));

s7_N208_6 :=  __common__( if(((real)add1_turnover_1yr_in < 1572.5), s7_N208_7, 0.01391762));

s7_N208_5 :=  __common__( map(trim(C_FOR_SALE) = ''      => -0.0045128218,
              ((real)c_for_sale < 151.5) => s7_N208_6,
                                            -0.0045128218));

s7_N208_4 :=  __common__( if(((real)c_inc_25k_p < 23.25), s7_N208_5, -0.019745011));

s7_N208_3 :=  __common__( if(trim(C_INC_25K_P) != '', s7_N208_4, 0.00097962204));

s7_N208_2 :=  __common__( if(((real)age < 82.5), -0.010569457, 0.024747153));

s7_N208_1 :=  __common__( if(((real)_infutor_nap < 1.5), s7_N208_2, s7_N208_3));

s7_N209_9 :=  __common__( map(trim(C_RETIRED) = ''     => 0.0041381992,
              ((real)c_retired < 8.55) => 0.067449602,
                                          0.0041381992));

s7_N209_8 :=  __common__( map(trim(C_CHILD) = ''      => s7_N209_9,
              ((integer)c_child < 23) => 0.083132074,
                                         s7_N209_9));

s7_N209_7 :=  __common__( if(((real)_prop_owner < 2.5), s7_N209_8, 0.0059965954));

s7_N209_6 :=  __common__( map(trim(C_HVAL_80K_P) = ''      => 0.024988233,
              ((integer)c_hval_80k_p < 12) => -0.0043488933,
                                              0.024988233));

s7_N209_5 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), s7_N209_6, s7_N209_7));

s7_N209_4 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0011042755, s7_N209_5));

s7_N209_3 :=  __common__( if(((integer)add2_eda_sourced < 0.5), -0.00044321459, s7_N209_4));

s7_N209_2 :=  __common__( if(((integer)c_lar_fam < 36), -0.013157658, s7_N209_3));

s7_N209_1 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N209_2, -0.0072347418));

s7_N210_11 :=  __common__( if(((real)attr_num_nonderogs90 < 3.5), -0.004568888, 0.0026160931));

s7_N210_10 :=  __common__( if(((real)c_born_usa < 52.5), 0.067743679, 0.0061885882));

s7_N210_9 :=  __common__( if(trim(C_BORN_USA) != '', s7_N210_10, -0.025995431));

s7_N210_8 :=  __common__( if(((real)add3_lres < 6.5), s7_N210_9, 0.00010994848));

s7_N210_7 :=  __common__( if(((real)c_sfdu_p < 88.95), -0.0073230411, 0.012754181));

s7_N210_6 :=  __common__( if(trim(C_SFDU_P) != '', s7_N210_7, -0.02709417));

s7_N210_5 :=  __common__( if(((real)add1_avm_to_med_ratio < 0.402351), 0.062643794, s7_N210_6));

s7_N210_4 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N210_5, s7_N210_8));

s7_N210_3 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N210_4, s7_N210_11));

s7_N210_2 :=  __common__( if((prof_license_category in ['0', '1', '2', '3', '4', '5']), 0.039664459, -0.018288729));

s7_N210_1 :=  __common__( if((combo_dobscore < 45), s7_N210_2, s7_N210_3));

s7_N211_10 :=  __common__( if(((integer)add1_nhood_vacant_properties < 60), 0.036252602, -0.011121322));

s7_N211_9 :=  __common__( map(trim(C_HVAL_20K_P) = ''     => 0.02486116,
              ((real)c_hval_20k_p < 43.4) => -0.0010082191,
                                             0.02486116));

s7_N211_8 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 3.5), s7_N211_9, s7_N211_10));

s7_N211_7 :=  __common__( if(((real)c_hval_750k_p < 35.35), s7_N211_8, 0.040890335));

s7_N211_6 :=  __common__( if(trim(C_HVAL_750K_P) != '', s7_N211_7, 0.015707292));

s7_N211_5 :=  __common__( if(((real)c_low_hval < 85.8), 0.00053787705, -0.029029107));

s7_N211_4 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N211_5, -0.014767972));

s7_N211_3 :=  __common__( if(((real)add1_building_area2 < 1123.5), 0.0096728229, s7_N211_4));

s7_N211_2 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N211_3, s7_N211_6));

s7_N211_1 :=  __common__( if((combo_dobscore < 45), -0.012758823, s7_N211_2));

s7_N212_10 :=  __common__( map(trim(C_RETIRED2) = ''      => 0.10046473,
               ((integer)c_retired2 < 80) => 0.026400977,
                                             0.10046473));

s7_N212_9 :=  __common__( if(((real)add2_nhood_vacant_properties < 29.5), s7_N212_10, -0.0022794932));

s7_N212_8 :=  __common__( map(trim(C_UNEMP) = ''     => -0.0067252996,
              ((real)c_unemp < 0.75) => 0.044587433,
                                        -0.0067252996));

s7_N212_7 :=  __common__( if(((real)c_blue_col < 22.85), s7_N212_8, s7_N212_9));

s7_N212_6 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N212_7, 0.02753756));

s7_N212_5 :=  __common__( if(((real)c_trailer < 151.5), 0.012190728, 0.084435641));

s7_N212_4 :=  __common__( if(trim(C_TRAILER) != '', s7_N212_5, -0.026976566));

s7_N212_3 :=  __common__( if(((real)add1_no_of_baths2 > NULL), s7_N212_4, 0.017411108));

s7_N212_2 :=  __common__( if(((real)add2_lres < 34.5), s7_N212_3, s7_N212_6));

s7_N212_1 :=  __common__( if(((real)_rel_felony_count < 0.5), -0.00067416604, s7_N212_2));

s7_N213_8 :=  __common__( if(((integer)add2_nhood_vacant_properties < 22), 0.0095008263, 0.043705297));

s7_N213_7 :=  __common__( if(((real)_adls_per_addr_cap10 < 9.5), -0.0031224536, s7_N213_8));

s7_N213_6 :=  __common__( if(((real)_ams_level < 2.5), -0.0097700792, 0.00097296425));

s7_N213_5 :=  __common__( if(((real)_nap < 5.5), s7_N213_6, s7_N213_7));

s7_N213_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), 0.0019588686, 0.25115067));

s7_N213_3 :=  __common__( if(((real)c_bel_edu < 111.5), s7_N213_4, 0.039087973));

s7_N213_2 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N213_3, 0.21856478));

s7_N213_1 :=  __common__( if(((real)_rel_count < 0.5), s7_N213_2, s7_N213_5));

s7_N214_9 :=  __common__( if(((real)mth_header_first_seen > NULL), 0.00089366826, 0.13220985));

s7_N214_8 :=  __common__( map(trim(C_FAMMAR_P) = ''      => s7_N214_9,
              ((real)c_fammar_p < 80.15) => 0.0075769251,
                                            s7_N214_9));

s7_N214_7 :=  __common__( if(((real)_rel_educationunder12_count < 1.5), 0.0033534403, 0.039503055));

s7_N214_6 :=  __common__( map(trim(C_RENTAL) = ''      => s7_N214_7,
              ((real)c_rental < 178.5) => -0.0064437481,
                                          s7_N214_7));

s7_N214_5 :=  __common__( if(((real)_ssn_score < 1.5), s7_N214_6, 0.021220709));

s7_N214_4 :=  __common__( if(((real)avg_lres < 50.5), s7_N214_5, s7_N214_8));

s7_N214_3 :=  __common__( if(((real)bus_phone_match < 2.5), s7_N214_4, -0.0097937519));

s7_N214_2 :=  __common__( if(((real)c_inc_35k_p < 15.55), s7_N214_3, -0.0072005118));

s7_N214_1 :=  __common__( if(trim(C_INC_35K_P) != '', s7_N214_2, -0.0025753537));

s7_N215_10 :=  __common__( map(trim(C_INC_50K_P) = ''     => 0.028105524,
               ((real)c_inc_50k_p < 9.05) => -0.010179321,
                                             0.028105524));

s7_N215_9 :=  __common__( map(trim(C_UNEMP) = ''     => 0.090782726,
              ((real)c_unemp < 1.85) => 0.027439633,
                                        0.090782726));

s7_N215_8 :=  __common__( map(trim(C_INC_50K_P) = ''     => s7_N215_9,
              ((real)c_inc_50k_p < 7.35) => 0.013537595,
                                            s7_N215_9));

s7_N215_7 :=  __common__( map(trim(C_BORN_USA) = ''     => s7_N215_8,
              ((real)c_born_usa < 22.5) => -0.017737814,
                                           s7_N215_8));

s7_N215_6 :=  __common__( map(trim(C_HVAL_500K_P) = ''     => 0.053104086,
              ((real)c_hval_500k_p < 22.5) => -0.0009348248,
                                              0.053104086));

s7_N215_5 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N215_6,
              ((real)c_civ_emp < 65.45) => -0.020111261,
                                           s7_N215_6));

s7_N215_4 :=  __common__( if(((real)mth_gong_did_first_seen < 89.5), s7_N215_5, s7_N215_7));

s7_N215_3 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N215_4, s7_N215_10));

s7_N215_2 :=  __common__( if(((real)c_hval_750k_p < 13.75), -0.00090697762, s7_N215_3));

s7_N215_1 :=  __common__( if(trim(C_HVAL_750K_P) != '', s7_N215_2, 0.00415692));

s7_N216_8 :=  __common__( if(((integer)add1_turnover_1yr_in < 191), 0.0500626, -0.011244619));

s7_N216_7 :=  __common__( if(((integer)add1_avm_med < 272092), s7_N216_8, 0.086634345));

s7_N216_6 :=  __common__( map(trim(C_BLUE_COL) = ''      => 0.11515498,
              ((real)c_blue_col < 19.75) => -0.0035634553,
                                            0.11515498));

s7_N216_5 :=  __common__( if(((real)c_trailer_p < 6.75), -0.0072489729, s7_N216_6));

s7_N216_4 :=  __common__( if(trim(C_TRAILER_P) != '', s7_N216_5, -0.02577134));

s7_N216_3 :=  __common__( if(((real)_inq_collection_count < 0.5), s7_N216_4, s7_N216_7));

s7_N216_2 :=  __common__( if(((real)add3_source_count < 10.5), -0.00086255934, 0.034315221));

s7_N216_1 :=  __common__( if(((real)add1_source_count < 11.5), s7_N216_2, s7_N216_3));

s7_N217_9 :=  __common__( map(trim(C_MED_RENT) = ''      => 0.064869362,
              ((real)c_med_rent < 850.5) => 0.0068686668,
                                            0.064869362));

s7_N217_8 :=  __common__( map(trim(C_RECENT_MOV) = ''     => -0.014459937,
              ((real)c_recent_mov < 18.5) => 0.029622415,
                                             -0.014459937));

s7_N217_7 :=  __common__( map(trim(C_UNEMPL) = ''      => 0.0057680182,
              ((real)c_unempl < 139.5) => -0.00043037345,
                                          0.0057680182));

s7_N217_6 :=  __common__( map(trim(C_ASSAULT) = ''      => s7_N217_8,
              ((real)c_assault < 190.5) => s7_N217_7,
                                           s7_N217_8));

s7_N217_5 :=  __common__( if(((real)_phones_per_adl < 2.5), s7_N217_6, s7_N217_9));

s7_N217_4 :=  __common__( map(trim(C_BORN_USA) = ''      => 0.0079097819,
              ((integer)c_born_usa < 56) => 0.043205543,
                                            0.0079097819));

s7_N217_3 :=  __common__( map(trim(C_UNEMPL) = ''     => s7_N217_4,
              ((real)c_unempl < 91.5) => -0.0071083036,
                                         s7_N217_4));

s7_N217_2 :=  __common__( if(((real)c_recent_mov < 4.5), s7_N217_3, s7_N217_5));

s7_N217_1 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N217_2, 0.00030601992));

s7_N218_9 :=  __common__( if(((real)add_bestmatch_level < 1.5), 0.0092120817, 0.058890016));

s7_N218_8 :=  __common__( map(trim(C_BURGLARY) = ''      => 0.04058897,
              ((real)c_burglary < 148.5) => -0.0044030417,
                                            0.04058897));

s7_N218_7 :=  __common__( if((add1_avm_automated_valuation < 188784), 0.038185324, -0.0042891824));

s7_N218_6 :=  __common__( if(((real)_adlperssn_count < 2.5), -0.0021410297, s7_N218_7));

s7_N218_5 :=  __common__( map(trim(C_LOW_HVAL) = ''      => s7_N218_8,
              ((real)c_low_hval < 56.55) => s7_N218_6,
                                            s7_N218_8));

s7_N218_4 :=  __common__( if(((integer)add2_avm_med < 622820), s7_N218_5, s7_N218_9));

s7_N218_3 :=  __common__( if(((real)rc_dirsaddr_lastscore < 53.5), s7_N218_4, -0.002117056));

s7_N218_2 :=  __common__( if(((integer)c_med_hval < 11847), -0.017506664, s7_N218_3));

s7_N218_1 :=  __common__( if(trim(C_MED_HVAL) != '', s7_N218_2, 0.00018669833));

s7_N219_9 :=  __common__( if(((real)c_robbery < 135.5), 0.012421304, 0.059819974));

s7_N219_8 :=  __common__( if(trim(C_ROBBERY) != '', s7_N219_9, -0.026008904));

s7_N219_7 :=  __common__( if(((real)c_lowrent < 69.85), -0.0078318233, 0.022999476));

s7_N219_6 :=  __common__( if(trim(C_LOWRENT) != '', s7_N219_7, 0.035130691));

s7_N219_5 :=  __common__( map(trim(C_SFDU_P) = ''     => 0.045994791,
              ((real)c_sfdu_p < 72.5) => -0.0025791529,
                                         0.045994791));

s7_N219_4 :=  __common__( if(trim(C_HHSIZE) != '', s7_N219_5, 0.30949113));

s7_N219_3 :=  __common__( if(((real)_rel_count < 4.5), s7_N219_4, s7_N219_6));

s7_N219_2 :=  __common__( if(((real)_inq_perphone < 0.5), s7_N219_3, s7_N219_8));

s7_N219_1 :=  __common__( if(((real)_adls_per_addr_c6 < 3.5), -0.0004816898, s7_N219_2));

s7_N220_10 :=  __common__( if(((real)combined_age < 49.5), 0.011479403, 0.029738926));

s7_N220_9 :=  __common__( if(((real)c_pop_18_24_p < 5.95), -0.0056311215, s7_N220_10));

s7_N220_8 :=  __common__( if(trim(C_POP_18_24_P) != '', s7_N220_9, -0.025951649));

s7_N220_7 :=  __common__( if(((real)attr_num_nonderogs30 < 3.5), -0.0011926159, s7_N220_8));

s7_N220_6 :=  __common__( if(((integer)add1_building_area2 < 3471), s7_N220_7, -0.012436342));

s7_N220_5 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N220_6, 0.0019080677));

s7_N220_4 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N220_5, -0.0013842232));

s7_N220_3 :=  __common__( if(((real)c_apt20 < 192.5), -0.0097038396, 0.019932557));

s7_N220_2 :=  __common__( if(trim(C_APT20) != '', s7_N220_3, -0.0079001625));

s7_N220_1 :=  __common__( if(((real)attr_num_nonderogs90 < 2.5), s7_N220_2, s7_N220_4));

s7_N221_9 :=  __common__( map(trim(C_LOWINC) = ''      => -0.016382299,
              ((real)c_lowinc < 77.35) => 0.0029042124,
                                          -0.016382299));

s7_N221_8 :=  __common__( map(trim(C_EASIQLIFE) = ''     => s7_N221_9,
              ((real)c_easiqlife < 36.5) => -0.033198778,
                                            s7_N221_9));

s7_N221_7 :=  __common__( map(trim(C_VACANT_P) = ''     => -0.0033369961,
              ((real)c_vacant_p < 4.25) => 0.046253307,
                                           -0.0033369961));

s7_N221_6 :=  __common__( map(trim(C_RECENT_MOV) = ''    => s7_N221_8,
              ((real)c_recent_mov < 5.5) => s7_N221_7,
                                            s7_N221_8));

s7_N221_5 :=  __common__( map(trim(C_TOTSALES) = ''      => 0.061166744,
              ((real)c_totsales < 678.5) => 0.0064994031,
                                            0.061166744));

s7_N221_4 :=  __common__( map(trim(C_UNEMPL) = ''     => s7_N221_6,
              ((real)c_unempl < 38.5) => s7_N221_5,
                                         s7_N221_6));

s7_N221_3 :=  __common__( if(((real)_inq_peraddr_cap8 < 7.5), s7_N221_4, 0.033299043));

s7_N221_2 :=  __common__( if(((real)c_high_ed < 11.15), s7_N221_3, -0.0010666337));

s7_N221_1 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N221_2, 0.0032003744));

s7_N222_9 :=  __common__( map(trim(C_HVAL_60K_P) = ''    => 0.013085496,
              ((real)c_hval_60k_p < 0.7) => -0.015628866,
                                            0.013085496));

s7_N222_8 :=  __common__( if(((real)avg_lres < 154.5), 0.0064508548, 0.053498722));

s7_N222_7 :=  __common__( map(trim(C_ASSAULT) = ''       => s7_N222_9,
              ((integer)c_assault < 104) => s7_N222_8,
                                            s7_N222_9));

s7_N222_6 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.030806516,
              ((real)c_hhsize < 3.455) => 0.0018538241,
                                          0.030806516));

s7_N222_5 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N222_6, s7_N222_7));

s7_N222_4 :=  __common__( map(trim(C_HVAL_500K_P) = ''      => 0.023211214,
              ((real)c_hval_500k_p < 30.65) => -0.0014342824,
                                               0.023211214));

s7_N222_3 :=  __common__( if(((real)age < 63.5), s7_N222_4, s7_N222_5));

s7_N222_2 :=  __common__( if(((real)c_inc_15k_p < 54.85), s7_N222_3, 0.019714501));

s7_N222_1 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N222_2, -0.004612458));

s7_N223_9 :=  __common__( if(((real)add1_nhood_vacant_properties < 6.5), 0.031347909, -0.0043315023));

s7_N223_8 :=  __common__( if(((real)_phones_per_adl_c6 < 0.5), -0.015438775, s7_N223_9));

s7_N223_7 :=  __common__( if(((real)add3_source_count < 1.5), 0.057470041, 0.0056063762));

s7_N223_6 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => 0.009249866,
              (prof_license_category in ['0'])                     => 0.15728067,
                                                                      0.009249866));

s7_N223_5 :=  __common__( if(((real)add1_turnover_1yr_in < 1016.5), -0.020083397, s7_N223_6));

s7_N223_4 :=  __common__( map(trim(C_RNT500_P) = ''      => s7_N223_7,
              ((integer)c_rnt500_p < 23) => s7_N223_5,
                                            s7_N223_7));

s7_N223_3 :=  __common__( map(trim(C_HHSIZE) = ''      => s7_N223_8,
              ((real)c_hhsize < 1.865) => s7_N223_4,
                                          s7_N223_8));

s7_N223_2 :=  __common__( if(((real)c_ownocc_p < 17.35), s7_N223_3, -7.0539969e-005));

s7_N223_1 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N223_2, 0.00036056242));

s7_N224_9 :=  __common__( if(((real)c_bel_edu < 62.5), 0.063441098, 0.0016159494));

s7_N224_8 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N224_9, 0.056393724));

s7_N224_7 :=  __common__( if(((real)_ssn_score < 1.5), 0.00084872393, s7_N224_8));

s7_N224_6 :=  __common__( map(trim(C_BEL_EDU) = ''      => -0.040627653,
              ((real)c_bel_edu < 127.5) => -0.011829772,
                                           -0.040627653));

s7_N224_5 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.0015511573, -0.027201864));

s7_N224_4 :=  __common__( if(((real)c_inc_15k_p < 20.2), s7_N224_5, 0.017533332));

s7_N224_3 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N224_4, -0.028935686));

s7_N224_2 :=  __common__( if(((integer)rc_lnamessnmatch < 0.5), s7_N224_3, s7_N224_6));

s7_N224_1 :=  __common__( if(((real)_ssncount < 1.5), s7_N224_2, s7_N224_7));

s7_N225_8 :=  __common__( if(((real)add2_lres < 19.5), 0.040547712, 0.008876169));

s7_N225_7 :=  __common__( if(((real)gong_did_addr_ct < 2.5), 0.0023518299, s7_N225_8));

s7_N225_6 :=  __common__( if(((real)_nap < 5.5), s7_N225_7, 0.02231861));

s7_N225_5 :=  __common__( if(((real)c_incollege < 61.95), -0.0022860421, 0.023819582));

s7_N225_4 :=  __common__( if(trim(C_INCOLLEGE) != '', s7_N225_5, 0.0014628366));

s7_N225_3 :=  __common__( if(((real)_ssns_per_addr < 9.5), s7_N225_4, s7_N225_6));

s7_N225_2 :=  __common__( if(mth_header_first_seen!= null and ((integer)mth_header_first_seen < 254), -0.00086042566, -0.034520252));

s7_N225_1 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), s7_N225_2, s7_N225_3));

s7_N226_8 :=  __common__( map(trim(C_MED_RENT) = ''      => 0.0057457328,
              ((real)c_med_rent < 382.5) => 0.083243682,
                                            0.0057457328));

s7_N226_7 :=  __common__( map(trim(C_CIV_EMP) = ''     => s7_N226_8,
              ((real)c_civ_emp < 50.1) => 0.057070826,
                                          s7_N226_8));

s7_N226_6 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0053755795, s7_N226_7));

s7_N226_5 :=  __common__( if(((real)_addr_stability_v2 < 5.5), s7_N226_6, -8.3596992e-005));

s7_N226_4 :=  __common__( if(((real)c_hval_750k_p < 42.55), s7_N226_5, 0.044995462));

s7_N226_3 :=  __common__( if(trim(C_HVAL_750K_P) != '', s7_N226_4, 0.00048687594));

s7_N226_2 :=  __common__( if(((real)_nap < 5.5), s7_N226_3, 0.02784135));

s7_N226_1 :=  __common__( if(((real)add1_lres < 89.5), -0.0024933018, s7_N226_2));

s7_N227_9 :=  __common__( if(((real)avg_lres < 50.5), -0.0091948275, 0.042606692));

s7_N227_8 :=  __common__( if(((real)c_span_lang < 151.5), s7_N227_9, 0.048638269));

s7_N227_7 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N227_8, -0.026147937));

s7_N227_6 :=  __common__( map(trim(C_OWNOCC_P) = ''     => 0.049040224,
              ((real)c_ownocc_p < 99.8) => 0.0014924022,
                                           0.049040224));

s7_N227_5 :=  __common__( map(trim(C_RECENT_MOV) = ''     => 0.00062654011,
              ((real)c_recent_mov < 76.5) => 0.029470991,
                                             0.00062654011));

s7_N227_4 :=  __common__( if(((real)c_fammar_p < 40.4), s7_N227_5, s7_N227_6));

s7_N227_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N227_4, 0.030309258));

s7_N227_2 :=  __common__( if(((real)add2_source_count < 4.5), s7_N227_3, s7_N227_7));

s7_N227_1 :=  __common__( if(((real)add2_lres < 25.5), s7_N227_2, -0.0010987845));

s7_N228_10 :=  __common__( map((prof_license_category in ['0', '2', '4', '5']) => 0.044145554,
               (prof_license_category in ['1', '3'])           => 0.1935846,
                                                                  0.044145554));

s7_N228_9 :=  __common__( if(((real)_nap < 4.5), s7_N228_10, -0.0070919121));

s7_N228_8 :=  __common__( if(((real)ssn_lowissue_age < 14.5728), -0.0038150943, s7_N228_9));

s7_N228_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N228_8, 0.016754377));

s7_N228_6 :=  __common__( map(trim(C_TOTSALES) = ''        => -0.0050285222,
              ((integer)c_totsales < 2438) => 0.050534285,
                                              -0.0050285222));

s7_N228_5 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s7_N228_6, s7_N228_7));

s7_N228_4 :=  __common__( map(trim(C_UNEMPL) = ''      => 0.010903643,
              ((real)c_unempl < 136.5) => -0.00098307784,
                                          0.010903643));

s7_N228_3 :=  __common__( if(((real)c_child < 32.35), s7_N228_4, s7_N228_5));

s7_N228_2 :=  __common__( if(trim(C_CHILD) != '', s7_N228_3, 0.011889006));

s7_N228_1 :=  __common__( if(((real)_nap < 3.5), -0.00097588902, s7_N228_2));

s7_N229_9 :=  __common__( map(trim(C_HIGH_ED) = ''     => 0.016230797,
              ((real)c_high_ed < 8.15) => -0.012421396,
                                          0.016230797));

s7_N229_8 :=  __common__( map(trim(C_HVAL_80K_P) = ''     => 0.044121352,
              ((real)c_hval_80k_p < 13.1) => s7_N229_9,
                                             0.044121352));

s7_N229_7 :=  __common__( map(trim(C_HVAL_100K_P) = ''     => 0.00080313903,
              ((real)c_hval_100k_p < 3.75) => s7_N229_8,
                                              0.00080313903));

s7_N229_6 :=  __common__( if(((real)ssn_lowissue_age < 39.7809), s7_N229_7, 0.034096803));

s7_N229_5 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N229_6, 0.035280615));

s7_N229_4 :=  __common__( if(((real)c_murders < 160.5), 0.0022015573, s7_N229_5));

s7_N229_3 :=  __common__( if(trim(C_MURDERS) != '', s7_N229_4, 0.005661713));

s7_N229_2 :=  __common__( if(((real)_infutor_nap < 1.5), -0.0096242746, s7_N229_3));

s7_N229_1 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N229_2, -0.0023153885));

s7_N230_10 :=  __common__( if(((real)combined_age < 68.5), 0.0030585888, 0.034381329));

s7_N230_9 :=  __common__( if(((real)_phones_per_adl_c6 < 1.5), s7_N230_10, 0.074020522));

s7_N230_8 :=  __common__( if(((real)c_asian_lang < 115.5), s7_N230_9, -0.0062795473));

s7_N230_7 :=  __common__( if(trim(C_ASIAN_LANG) != '', s7_N230_8, -0.028671008));

s7_N230_6 :=  __common__( if((add2_avm_automated_valuation < 856177), s7_N230_7, 0.06299901));

s7_N230_5 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N230_6, -0.00094644317));

s7_N230_4 :=  __common__( if(((real)c_rentocc_p < 21.6), -0.0039470487, 0.045058427));

s7_N230_3 :=  __common__( if(trim(C_RENTOCC_P) != '', s7_N230_4, -0.0037035599));

s7_N230_2 :=  __common__( if(((real)add1_unit_count < 0.5), s7_N230_3, s7_N230_5));

s7_N230_1 :=  __common__( if(((real)add1_nhood_vacant_properties < 621.5), s7_N230_2, -0.018271615));

s7_N231_8 :=  __common__( if(((integer)add2_turnover_1yr_in < 242), 0.0025744407, 0.05574602));

s7_N231_7 :=  __common__( map(trim(C_BLUE_COL) = ''     => s7_N231_8,
              ((real)c_blue_col < 6.55) => -0.0086469385,
                                           s7_N231_8));

s7_N231_6 :=  __common__( if(((real)combined_age < 74.5), 0.003167326, s7_N231_7));

s7_N231_5 :=  __common__( if(((integer)add2_turnover_1yr_in < 3044), s7_N231_6, 0.05306013));

s7_N231_4 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.056327516,
              ((real)c_sfdu_p < 97.45) => s7_N231_5,
                                          0.056327516));

s7_N231_3 :=  __common__( if(((real)c_rentocc_p < 18.45), -0.0017072974, s7_N231_4));

s7_N231_2 :=  __common__( if(trim(C_RENTOCC_P) != '', s7_N231_3, 0.00060513845));

s7_N231_1 :=  __common__( if(((integer)add1_avm_med < 300796), -0.0022122322, s7_N231_2));

s7_N232_9 :=  __common__( if(((real)_addrs_last90 < 0.5), -0.018934674, 0.027823174));

s7_N232_8 :=  __common__( if(((real)avg_lres < 57.5), 0.038658518, 0.0040979596));

s7_N232_7 :=  __common__( map(trim(C_SPAN_LANG) = ''      => s7_N232_8,
              ((real)c_span_lang < 181.5) => 0.0036333214,
                                             s7_N232_8));

s7_N232_6 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.053307724,
              ((real)c_relig_indx < 196.5) => s7_N232_7,
                                              0.053307724));

s7_N232_5 :=  __common__( if(((real)_rel_count_addr < 0.5), 0.052319, 0.00073525426));

s7_N232_4 :=  __common__( if(((real)add1_unit_count < 0.5), s7_N232_5, -9.1887026e-005));

s7_N232_3 :=  __common__( if(((real)_altlname < 0.5), s7_N232_4, s7_N232_6));

s7_N232_2 :=  __common__( if(((real)c_vacant_p < 28.15), s7_N232_3, -0.017578003));

s7_N232_1 :=  __common__( if(trim(C_VACANT_P) != '', s7_N232_2, s7_N232_9));

s7_N233_11 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.064091886,
               ((real)c_civ_emp < 76.85) => 0.0059994286,
                                            0.064091886));

s7_N233_10 :=  __common__( if(((real)source_count < 11.5), s7_N233_11, 0.075174987));

s7_N233_9 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 259.5), 0.00094468914, 0.017853605));

s7_N233_8 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N233_9, 0.029041154));

s7_N233_7 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N233_8, 0.0067395552));

s7_N233_6 :=  __common__( if(((integer)rc_fnamessnmatch < 0.5), -0.003226227, s7_N233_7));

s7_N233_5 :=  __common__( if(((real)add1_source_count < 4.5), s7_N233_6, -0.00066177731));

s7_N233_4 :=  __common__( map(trim(C_INC_201K_P) = ''      => s7_N233_10,
              ((real)c_inc_201k_p < 20.65) => s7_N233_5,
                                              s7_N233_10));

s7_N233_3 :=  __common__( map(trim(C_HIGHRENT) = ''      => -0.016581871,
              ((real)c_highrent < 74.65) => s7_N233_4,
                                            -0.016581871));

s7_N233_2 :=  __common__( if(((real)c_robbery < 197.5), s7_N233_3, -0.018809803));

s7_N233_1 :=  __common__( if(trim(C_ROBBERY) != '', s7_N233_2, -0.0035163697));

s7_N234_10 :=  __common__( map(trim(C_INC_201K_P) = ''     => 0.045810831,
               ((real)c_inc_201k_p < 1.55) => -0.011441753,
                                              0.045810831));

s7_N234_9 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.057665582,
              ((real)c_hhsize < 2.855) => s7_N234_10,
                                          0.057665582));

s7_N234_8 :=  __common__( map(trim(C_WHITE_COL) = ''      => s7_N234_9,
              ((real)c_white_col < 20.05) => 0.052615048,
                                             s7_N234_9));

s7_N234_7 :=  __common__( map(trim(C_SPAN_LANG) = ''      => -0.021204837,
              ((real)c_span_lang < 180.5) => s7_N234_8,
                                             -0.021204837));

s7_N234_6 :=  __common__( if((add1_avm_automated_valuation < 66072), s7_N234_7, -0.0002733737));

s7_N234_5 :=  __common__( map(trim(C_RAPE) = ''     => -0.007889523,
              ((real)c_rape < 75.5) => 0.024795675,
                                       -0.007889523));

s7_N234_4 :=  __common__( if((combo_dobscore < 65), s7_N234_5, s7_N234_6));

s7_N234_3 :=  __common__( if(((real)c_fammar18_p < 8.45), -0.021108633, s7_N234_4));

s7_N234_2 :=  __common__( if(trim(C_FAMMAR18_P) != '', s7_N234_3, -0.026601487));

s7_N234_1 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N234_2, 0.00058957667));

s7_N235_8 :=  __common__( map(trim(C_UNEMP) = ''     => 0.056354873,
              ((real)c_unemp < 4.25) => 0.021433773,
                                        0.056354873));

s7_N235_7 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N235_8, 0.019040273));

s7_N235_6 :=  __common__( if(((real)_rel_homeunder100_count < 4.5), 0.0040953356, s7_N235_7));

s7_N235_5 :=  __common__( map(trim(C_AB_AV_EDU) = ''     => -0.00015282695,
              ((real)c_ab_av_edu < 41.5) => s7_N235_6,
                                            -0.00015282695));

s7_N235_4 :=  __common__( if(((real)add1_unit_count < 133.5), -0.0084781366, 0.012715933));

s7_N235_3 :=  __common__( if(((real)c_inc_150k_p < 0.65), s7_N235_4, s7_N235_5));

s7_N235_2 :=  __common__( if(trim(C_INC_150K_P) != '', s7_N235_3, 0.0048250719));

s7_N235_1 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.021727164, s7_N235_2));

s7_N236_11 :=  __common__( if(((real)_addr_stability_v2 < 3.5), 0.029608298, -0.003156456));

s7_N236_10 :=  __common__( if(((real)_rel_homeunder100_count < 3.5), -0.014540129, s7_N236_11));

s7_N236_9 :=  __common__( if(((real)_rel_incomeunder50_count < 4.5), -0.00025079793, 0.0070970305));

s7_N236_8 :=  __common__( if(((real)_addrs_last36 < 3.5), s7_N236_9, -0.0031838349));

s7_N236_7 :=  __common__( if(((real)c_bel_edu < 187.5), s7_N236_8, s7_N236_10));

s7_N236_6 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N236_7, -0.00041201771));

s7_N236_5 :=  __common__( map(trim(C_HVAL_80K_P) = ''    => 0.023338505,
              ((real)c_hval_80k_p < 4.4) => -0.025743223,
                                            0.023338505));

s7_N236_4 :=  __common__( if(((real)c_robbery < 152.5), s7_N236_5, 0.042169658));

s7_N236_3 :=  __common__( if(trim(C_ROBBERY) != '', s7_N236_4, -0.028414845));

s7_N236_2 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 12.5), s7_N236_3, s7_N236_6));

s7_N236_1 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N236_2, 0.0051356485));

s7_N237_8 :=  __common__( if(((real)_bus_addr_src_cnt < 1.5), -0.013291431, 0.025847515));

s7_N237_7 :=  __common__( if(((integer)add1_turnover_1yr_in < 276), 0.011176354, 0.038755832));

s7_N237_6 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((real)mth_ver_src_fsrc_fdate < 226.5), s7_N237_7, s7_N237_8));

s7_N237_5 :=  __common__( if(((real)_rel_homeunder100_count < 2.5), -0.018148134, 0.034149564));

s7_N237_4 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.020523292,
              ((real)c_civ_emp < 81.35) => 0.00093842806,
                                           0.020523292));

s7_N237_3 :=  __common__( if(((integer)c_lar_fam < 36), -0.010891969, s7_N237_4));

s7_N237_2 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N237_3, s7_N237_5));

s7_N237_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N237_2, s7_N237_6));

s7_N238_9 :=  __common__( map(trim(C_RNT250_P) = ''     => 0.077185614,
              ((real)c_rnt250_p < 9.85) => 0.01278019,
                                           0.077185614));

s7_N238_8 :=  __common__( if(((real)rc_addrcount < 2.5), 0.054427681, s7_N238_9));

s7_N238_7 :=  __common__( map(trim(C_TOTSALES) = ''        => s7_N238_8,
              ((real)c_totsales < 15420.5) => 0.0049151266,
                                              s7_N238_8));

s7_N238_6 :=  __common__( map(trim(C_EASIQLIFE) = ''     => 0.00031470101,
              ((real)c_easiqlife < 53.5) => 0.027459688,
                                            0.00031470101));

s7_N238_5 :=  __common__( if((add2_avm_automated_valuation < 308593), s7_N238_6, s7_N238_7));

s7_N238_4 :=  __common__( map(trim(C_INC_150K_P) = ''     => s7_N238_5,
              ((real)c_inc_150k_p < 5.85) => -0.00077068124,
                                             s7_N238_5));

s7_N238_3 :=  __common__( map(trim(C_MED_HHINC) = ''        => s7_N238_4,
              ((real)c_med_hhinc < 12283.5) => -0.022716486,
                                               s7_N238_4));

s7_N238_2 :=  __common__( if(((real)c_med_rent < 1364.5), s7_N238_3, -0.009741721));

s7_N238_1 :=  __common__( if(trim(C_MED_RENT) != '', s7_N238_2, -0.0023420474));

s7_N239_10 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.0056770306,
               ((real)c_sfdu_p < 11.65) => 0.062001297,
                                           0.0056770306));

s7_N239_9 :=  __common__( map(trim(C_POP_18_24_P) = ''      => s7_N239_10,
              ((real)c_pop_18_24_p < 13.65) => 0.00056587666,
                                               s7_N239_10));

s7_N239_8 :=  __common__( if(((real)_rel_within25miles_count < 4.5), 0.00022119004, 0.033834941));

s7_N239_7 :=  __common__( map(trim(C_HIGHINC) = ''     => s7_N239_8,
              ((real)c_highinc < 6.95) => -0.013452548,
                                          s7_N239_8));

s7_N239_6 :=  __common__( if(((real)c_inc_35k_p < 13.85), s7_N239_7, 0.025936017));

s7_N239_5 :=  __common__( if(trim(C_INC_35K_P) != '', s7_N239_6, 0.021586118));

s7_N239_4 :=  __common__( if(((real)add1_source_count < 2.5), s7_N239_5, -0.00096290462));

s7_N239_3 :=  __common__( if(((real)add1_nhood_vacant_properties < 24.5), s7_N239_4, -0.0067765453));

s7_N239_2 :=  __common__( if(((real)add1_turnover_1yr_in < 1600.5), s7_N239_3, s7_N239_9));

s7_N239_1 :=  __common__( if(((real)add1_building_area2 > NULL), 0.00091947748, s7_N239_2));

s7_N240_9 :=  __common__( if(((real)_wealth_index < 1.5), 0.025646586, -0.0090833171));

s7_N240_8 :=  __common__( map((prof_license_category in ['1', '2', '3', '5']) => s7_N240_9,
              (prof_license_category in ['0', '4'])           => 0.083430611,
                                                                 s7_N240_9));

s7_N240_7 :=  __common__( if(((real)_rel_educationunder12_count < 3.5), s7_N240_8, 0.036885919));

s7_N240_6 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.031442749,
              ((real)c_span_lang < 113.5) => -0.014832653,
                                             0.031442749));

s7_N240_5 :=  __common__( map(trim(C_RECENT_MOV) = ''      => 0.019513967,
              ((real)c_recent_mov < 153.5) => -0.016430546,
                                              0.019513967));

s7_N240_4 :=  __common__( if((combo_dobscore < 55), s7_N240_5, -3.9116585e-005));

s7_N240_3 :=  __common__( map(trim(C_INC_15K_P) = ''     => s7_N240_6,
              ((real)c_inc_15k_p < 48.5) => s7_N240_4,
                                            s7_N240_6));

s7_N240_2 :=  __common__( if(((real)c_hval_60k_p < 41.65), s7_N240_3, s7_N240_7));

s7_N240_1 :=  __common__( if(trim(C_HVAL_60K_P) != '', s7_N240_2, -0.0036386494));

s7_N241_7 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.040463367,
              ((real)c_span_lang < 135.5) => 0.0095890909,
                                             0.040463367));

s7_N241_6 :=  __common__( if(((real)age < 50.5), s7_N241_7, -0.0083969723));

s7_N241_5 :=  __common__( if(((real)_ssn_score < 1.5), 0.00011661436, s7_N241_6));

s7_N241_4 :=  __common__( if(((integer)add1_eda_sourced < 0.5), 0.000717432, -0.023724292));

s7_N241_3 :=  __common__( if((add2_avm_automated_valuation < 168424), s7_N241_4, 0.011710719));

s7_N241_2 :=  __common__( if(((real)combined_age < 60.5), s7_N241_3, -0.02637508));

s7_N241_1 :=  __common__( if((combo_dobscore < 55), s7_N241_2, s7_N241_5));

s7_N242_9 :=  __common__( map(trim(C_TOTSALES) = ''       => -0.0041432908,
              ((real)c_totsales < 1033.5) => 0.045721099,
                                             -0.0041432908));

s7_N242_8 :=  __common__( map(trim(C_RAPE) = ''      => 0.045736127,
              ((integer)c_rape < 60) => 0.01104647,
                                        0.045736127));

s7_N242_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), 0.0066066082, 0.12642954));

s7_N242_6 :=  __common__( if(((real)add_bestmatch_level < 0.5), s7_N242_7, s7_N242_8));

s7_N242_5 :=  __common__( if(((real)add2_lres < 47.5), s7_N242_6, s7_N242_9));

s7_N242_4 :=  __common__( map(trim(C_VACANT_P) = ''     => -0.036630657,
              ((real)c_vacant_p < 5.55) => -0.0032418425,
                                           -0.036630657));

s7_N242_3 :=  __common__( map(trim(C_SFDU_P) = ''    => 0.00023928257,
              ((real)c_sfdu_p < 0.1) => s7_N242_4,
                                        0.00023928257));

s7_N242_2 :=  __common__( if(((real)c_apt20 < 192.5), s7_N242_3, s7_N242_5));

s7_N242_1 :=  __common__( if(trim(C_APT20) != '', s7_N242_2, -0.0089784714));

s7_N243_10 :=  __common__( map(trim(C_HVAL_80K_P) = ''      => 0.022211229,
               ((real)c_hval_80k_p < 10.25) => -0.0051741336,
                                               0.022211229));

s7_N243_9 :=  __common__( map(trim(C_UNEMP) = ''     => 0.024845735,
              ((real)c_unemp < 5.55) => -0.01354542,
                                        0.024845735));

s7_N243_8 :=  __common__( map(trim(C_INC_15K_P) = ''      => s7_N243_9,
              ((real)c_inc_15k_p < 15.95) => 0.076539516,
                                             s7_N243_9));

s7_N243_7 :=  __common__( if(((real)add1_no_of_baths2 > NULL), s7_N243_8, s7_N243_10));

s7_N243_6 :=  __common__( map(trim(C_HVAL_40K_P) = ''     => 0.031565014,
              ((real)c_hval_40k_p < 1.85) => -0.009493186,
                                             0.031565014));

s7_N243_5 :=  __common__( map(trim(C_HIGHRENT) = ''    => 0.047323791,
              ((real)c_highrent < 1.9) => s7_N243_6,
                                          0.047323791));

s7_N243_4 :=  __common__( map(trim(C_SPAN_LANG) = ''      => s7_N243_5,
              ((real)c_span_lang < 195.5) => -0.0040058642,
                                             s7_N243_5));

s7_N243_3 :=  __common__( if(((real)_phones_per_adl < 0.5), s7_N243_4, 0.0021743858));

s7_N243_2 :=  __common__( if(((real)c_low_hval < 72.05), s7_N243_3, s7_N243_7));

s7_N243_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N243_2, 0.0017764453));

s7_N244_9 :=  __common__( map((prof_license_category in ['0', '2', '3', '4', '5']) => -0.023125339,
              (prof_license_category in ['1'])                     => 0.11031101,
                                                                      -0.023125339));

s7_N244_8 :=  __common__( if(((real)_rel_bankrupt_count < 2.5), 0.0095124088, 0.056471642));

s7_N244_7 :=  __common__( if(((real)source_count < 4.5), s7_N244_8, -0.00014927008));

s7_N244_6 :=  __common__( if(((real)_ssns_per_addr < 9.5), -0.0055545617, s7_N244_7));

s7_N244_5 :=  __common__( map(trim(C_INC_25K_P) = ''     => 0.094162284,
              ((real)c_inc_25k_p < 3.25) => -0.0059731922,
                                            0.094162284));

s7_N244_4 :=  __common__( map(trim(C_HIGH_HVAL) = ''     => s7_N244_5,
              ((real)c_high_hval < 59.2) => 0.0020101975,
                                            s7_N244_5));

s7_N244_3 :=  __common__( if(((real)_addrs_10yr < 4.5), s7_N244_4, s7_N244_6));

s7_N244_2 :=  __common__( if(((real)c_low_hval < 92.75), s7_N244_3, s7_N244_9));

s7_N244_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N244_2, 0.0032434422));

s7_N245_9 :=  __common__( map(trim(C_HVAL_500K_P) = ''      => 0.057000059,
              ((real)c_hval_500k_p < 10.35) => -0.0030883225,
                                               0.057000059));

s7_N245_8 :=  __common__( if(((real)_rel_criminal_total < 4.5), s7_N245_9, 0.072132627));

s7_N245_7 :=  __common__( map(trim(C_WHITE_COL) = ''      => s7_N245_8,
              ((real)c_white_col < 66.25) => 0.00060680344,
                                             s7_N245_8));

s7_N245_6 :=  __common__( if(((real)_rel_count_addr < 1.5), 0.014683242, -0.015439098));

s7_N245_5 :=  __common__( if(((real)_addrs_per_ssn < 6.5), s7_N245_6, -0.016060283));

s7_N245_4 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N245_5, -0.0037541418));

s7_N245_3 :=  __common__( map(trim(C_TOTSALES) = ''          => 0.027280245,
              ((integer)c_totsales < 632474) => s7_N245_4,
                                                0.027280245));

s7_N245_2 :=  __common__( if(((real)c_ownocc_p < 55.05), s7_N245_3, s7_N245_7));

s7_N245_1 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N245_2, 0.0070311502));

s7_N246_8 :=  __common__( map(trim(C_LAR_FAM) = ''     => 0.002111392,
              ((real)c_lar_fam < 74.5) => 0.088246788,
                                          0.002111392));

s7_N246_7 :=  __common__( map(trim(C_INC_15K_P) = ''     => 5.9785754e-006,
              ((real)c_inc_15k_p < 2.05) => 0.047154649,
                                            5.9785754e-006));

s7_N246_6 :=  __common__( map(trim(C_ROBBERY) = ''      => 0.064909494,
              ((real)c_robbery < 167.5) => 0.0057073914,
                                           0.064909494));

s7_N246_5 :=  __common__( map(trim(C_FAMMAR_P) = ''      => s7_N246_7,
              ((real)c_fammar_p < 56.45) => s7_N246_6,
                                            s7_N246_7));

s7_N246_4 :=  __common__( map((prof_license_category in ['1', '2', '3', '5']) => s7_N246_5,
              (prof_license_category in ['0', '4'])           => 0.098861337,
                                                                 s7_N246_5));

s7_N246_3 :=  __common__( if(((real)c_hval_100k_p < 37.55), -0.00028280006, s7_N246_4));

s7_N246_2 :=  __common__( if(trim(C_HVAL_100K_P) != '', s7_N246_3, -0.0029724291));

s7_N246_1 :=  __common__( if(((real)add2_nhood_vacant_properties < 1207.5), s7_N246_2, s7_N246_8));

s7_N247_9 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.02232002,
              ((real)c_easiqlife < 131.5) => 0.0017274262,
                                             0.02232002));

s7_N247_8 :=  __common__( map(trim(C_MED_HVAL) = ''          => 0.051917244,
              ((integer)c_med_hval < 321026) => s7_N247_9,
                                                0.051917244));

s7_N247_7 :=  __common__( if(((real)_nap < 3.5), 0.0010420165, s7_N247_8));

s7_N247_6 :=  __common__( if(((real)_ssncount < 0.5), -0.019715064, s7_N247_7));

s7_N247_5 :=  __common__( if(((real)_phones_per_adl < 0.5), -0.0025906253, s7_N247_6));

s7_N247_4 :=  __common__( map(trim(C_HVAL_60K_P) = ''      => -0.020262743,
              ((real)c_hval_60k_p < 51.65) => s7_N247_5,
                                              -0.020262743));

s7_N247_3 :=  __common__( map(trim(C_HIGH_ED) = ''      => -0.0020665308,
              ((real)c_high_ed < 11.35) => 0.037863779,
                                           -0.0020665308));

s7_N247_2 :=  __common__( if(((real)c_recent_mov < 2.5), s7_N247_3, s7_N247_4));

s7_N247_1 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N247_2, 0.0029959902));

s7_N248_9 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 1.5), 0.0069408388, 0.034688775));

s7_N248_8 :=  __common__( if(((integer)add1_avm_med < 397191), s7_N248_9, 0.037293726));

s7_N248_7 :=  __common__( map(trim(C_MED_RENT) = ''       => -0.010592625,
              ((integer)c_med_rent < 747) => s7_N248_8,
                                             -0.010592625));

s7_N248_6 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.0016810658, 0.0044547555));

s7_N248_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), s7_N248_6, s7_N248_7));

s7_N248_4 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '5']) => 0.013023146,
              (prof_license_category in ['4'])                     => 0.17926861,
                                                                      0.013023146));

s7_N248_3 :=  __common__( map(trim(C_VACANT_P) = ''     => s7_N248_4,
              ((real)c_vacant_p < 20.9) => -0.010640091,
                                           s7_N248_4));

s7_N248_2 :=  __common__( if(((real)c_white_col < 16.95), s7_N248_3, s7_N248_5));

s7_N248_1 :=  __common__( if(trim(C_WHITE_COL) != '', s7_N248_2, 0.0028884261));

s7_N249_8 :=  __common__( if(((real)combo_hphonecount < 0.5), 0.017800596, -0.012578564));

s7_N249_7 :=  __common__( if(((real)add2_nhood_vacant_properties < 12.5), 0.0096868038, -0.0086290762));

s7_N249_6 :=  __common__( map(trim(C_LAR_FAM) = ''     => s7_N249_7,
              ((real)c_lar_fam < 68.5) => -0.02072923,
                                          s7_N249_7));

s7_N249_5 :=  __common__( map(trim(C_CARTHEFT) = ''      => s7_N249_8,
              ((real)c_cartheft < 149.5) => s7_N249_6,
                                            s7_N249_8));

s7_N249_4 :=  __common__( map(trim(C_BEL_EDU) = ''      => -0.018233763,
              ((real)c_bel_edu < 171.5) => s7_N249_5,
                                           -0.018233763));

s7_N249_3 :=  __common__( if(((real)c_ab_av_edu < 182.5), s7_N249_4, -0.026696186));

s7_N249_2 :=  __common__( if(trim(C_AB_AV_EDU) != '', s7_N249_3, -0.015897139));

s7_N249_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N249_2, 0.00054232173));

s7_N250_8 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.0028927529, -0.025660966));

s7_N250_7 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.031667482,
              ((real)c_low_ed < 67.25) => 0.001924231,
                                          0.031667482));

s7_N250_6 :=  __common__( if(((real)add2_source_count < 8.5), s7_N250_7, 0.044695573));

s7_N250_5 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), -0.0035065382, s7_N250_6));

s7_N250_4 :=  __common__( map(trim(C_HVAL_80K_P) = ''      => 0.030608541,
              ((real)c_hval_80k_p < 56.75) => s7_N250_5,
                                              0.030608541));

s7_N250_3 :=  __common__( if(((real)_addrs_last36 < 2.5), 0.002390193, s7_N250_4));

s7_N250_2 :=  __common__( if(trim(C_UNEMPL) != '', s7_N250_3, -0.0025196947));

s7_N250_1 :=  __common__( if(((real)_ssn_score < 2.5), s7_N250_2, s7_N250_8));

s7_N251_10 :=  __common__( if(((real)_rel_prop_owned_count < 1.5), 0.063040036, 0.010081696));

s7_N251_9 :=  __common__( map(trim(C_POP_18_24_P) = ''     => s7_N251_10,
              ((real)c_pop_18_24_p < 6.35) => -0.0076290489,
                                              s7_N251_10));

s7_N251_8 :=  __common__( map(trim(C_EDU_INDX) = ''      => 0.03639865,
              ((real)c_edu_indx < 101.5) => 0.0032626174,
                                            0.03639865));

s7_N251_7 :=  __common__( map(trim(C_POP_25_34_P) = ''      => s7_N251_8,
              ((real)c_pop_25_34_p < 24.25) => 0.00083427589,
                                               s7_N251_8));

s7_N251_6 :=  __common__( if(((real)_prop_owned_total < 0.5), -0.0033505991, s7_N251_7));

s7_N251_5 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.017814373, s7_N251_6));

s7_N251_4 :=  __common__( if(((real)c_low_hval < 92.75), s7_N251_5, -0.01906505));

s7_N251_3 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N251_4, -0.001517606));

s7_N251_2 :=  __common__( if(((real)mth_header_first_seen < 535.5), s7_N251_3, s7_N251_9));

s7_N251_1 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N251_2, 0.012841767));

s7_N252_9 :=  __common__( if(((real)add2_turnover_1yr_in < 210.5), 0.039454536, -0.00019262797));

s7_N252_8 :=  __common__( if(((real)combo_dobcount < 3.5), 0.036938455, s7_N252_9));

s7_N252_7 :=  __common__( if(((real)c_totsales < 4869.5), s7_N252_8, -4.6142763e-005));

s7_N252_6 :=  __common__( if(trim(C_TOTSALES) != '', s7_N252_7, 0.014112804));

s7_N252_5 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.039693599,
              ((real)c_span_lang < 141.5) => 0.0096775585,
                                             0.039693599));

s7_N252_4 :=  __common__( if(((real)c_high_ed < 52.65), -0.00054883721, s7_N252_5));

s7_N252_3 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N252_4, -0.01087395));

s7_N252_2 :=  __common__( if(((real)_rel_homeunder50_count < 4.5), s7_N252_3, s7_N252_6));

s7_N252_1 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), -0.0022215152, s7_N252_2));

s7_N253_9 :=  __common__( if(((real)_adl_score < 1.5), -0.00059856995, 0.035310486));

s7_N253_8 :=  __common__( if(((integer)add1_avm_med < 199398), 0.0040066227, -0.024250876));

s7_N253_7 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N253_8, -0.012589879));

s7_N253_6 :=  __common__( if(((real)c_mort_indx < 24.5), 0.012506365, s7_N253_7));

s7_N253_5 :=  __common__( if(trim(C_MORT_INDX) != '', s7_N253_6, -0.0090920526));

s7_N253_4 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N253_5, s7_N253_9));

s7_N253_3 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N253_4, 0.054360296));

s7_N253_2 :=  __common__( if(((real)_phones_per_adl_c6 < 0.5), 0.0016847101, 0.01138651));

s7_N253_1 :=  __common__( if(((real)combo_dobcount < 4.5), s7_N253_2, s7_N253_3));

s7_N254_10 :=  __common__( if(((real)c_inc_150k_p < 3.35), 0.037564005, -0.0042568625));

s7_N254_9 :=  __common__( if(trim(C_INC_150K_P) != '', s7_N254_10, 0.031113083));

s7_N254_8 :=  __common__( if(((real)add1_source_count < 1.5), s7_N254_9, 0.0037164551));

s7_N254_7 :=  __common__( map(trim(C_UNEMPL) = ''      => 0.023781455,
              ((real)c_unempl < 138.5) => -0.0052283126,
                                          0.023781455));

s7_N254_6 :=  __common__( if(((real)gong_did_phone_ct < 1.5), s7_N254_7, 0.050593435));

s7_N254_5 :=  __common__( if(((real)c_lar_fam < 153.5), -0.00018448947, s7_N254_6));

s7_N254_4 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N254_5, -0.027420891));

s7_N254_3 :=  __common__( if(((real)add1_avm_to_med_ratio < 2.46947), s7_N254_4, 0.063403954));

s7_N254_2 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N254_3, s7_N254_8));

s7_N254_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), -0.0011069887, s7_N254_2));

s7_N255_8 :=  __common__( if(((integer)add3_avm_automated_valuation < 241375), 0.00026779419, 0.044061366));

s7_N255_7 :=  __common__( if(((real)_phones_per_adl_c6 < 0.5), s7_N255_8, 0.037452863));

s7_N255_6 :=  __common__( if(((real)add2_lres < 9.5), s7_N255_7, 0.00089886016));

s7_N255_5 :=  __common__( map(trim(C_LOW_HVAL) = ''     => 0.06691045,
              ((real)c_low_hval < 1.65) => 0.011998562,
                                           0.06691045));

s7_N255_4 :=  __common__( if(((integer)c_ab_av_edu < 124), 0.00037172564, s7_N255_5));

s7_N255_3 :=  __common__( if(trim(C_AB_AV_EDU) != '', s7_N255_4, -0.027079761));

s7_N255_2 :=  __common__( if(((real)add1_source_count < 0.5), s7_N255_3, s7_N255_6));

s7_N255_1 :=  __common__( if(((real)_rel_count_addr < 0.5), s7_N255_2, -0.00082395985));

s7_N256_10 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => 0.018531418,
               (prof_license_category in ['0'])                     => 0.41037855,
                                                                       0.018531418));

s7_N256_9 :=  __common__( if(((real)_inq_perssn < 1.5), -0.0079786839, s7_N256_10));

s7_N256_8 :=  __common__( map(trim(C_MANY_CARS) = ''     => 0.058658034,
              ((real)c_many_cars < 95.5) => -0.01267918,
                                            0.058658034));

s7_N256_7 :=  __common__( map(trim(C_FAMMAR_P) = ''      => s7_N256_8,
              ((real)c_fammar_p < 62.95) => 0.060400032,
                                            s7_N256_8));

s7_N256_6 :=  __common__( map(trim(C_HIGH_ED) = ''     => 0.0010504842,
              ((real)c_high_ed < 17.2) => s7_N256_7,
                                          0.0010504842));

s7_N256_5 :=  __common__( if(((integer)_ssn_score < 0), 0.016852175, 0.00042861542));

s7_N256_4 :=  __common__( if(((real)ssn_lowissue_age < 39.2442), s7_N256_5, s7_N256_6));

s7_N256_3 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N256_4, 0.0015999146));

s7_N256_2 :=  __common__( if(((real)c_bel_edu < 178.5), s7_N256_3, s7_N256_9));

s7_N256_1 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N256_2, -0.0067214637));

s7_N257_9 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), -0.00080570746, 0.026168513));

s7_N257_8 :=  __common__( map(trim(C_INC_201K_P) = ''     => 0.085261435,
              ((real)c_inc_201k_p < 9.15) => 0.003194741,
                                             0.085261435));

s7_N257_7 :=  __common__( if(((real)_inq_collection_count < 1.5), s7_N257_8, -0.0054653706));

s7_N257_6 :=  __common__( map(trim(C_EASIQLIFE) = ''     => s7_N257_7,
              ((real)c_easiqlife < 73.5) => 0.11961439,
                                            s7_N257_7));

s7_N257_5 :=  __common__( if((add1_avm_automated_valuation < 250467), 0.0016475567, s7_N257_6));

s7_N257_4 :=  __common__( if(((real)_inq_collection_count < 0.5), 0.0016947861, s7_N257_5));

s7_N257_3 :=  __common__( map(trim(C_ASSAULT) = ''     => s7_N257_9,
              ((real)c_assault < 14.5) => s7_N257_4,
                                          s7_N257_9));

s7_N257_2 :=  __common__( if(((real)c_highrent < 68.6), s7_N257_3, -0.018712145));

s7_N257_1 :=  __common__( if(trim(C_HIGHRENT) != '', s7_N257_2, 0.0053401237));

s7_N258_8 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.030063946,
              ((real)c_span_lang < 190.5) => -0.0030749888,
                                             0.030063946));

s7_N258_7 :=  __common__( if(((real)combined_age < 20.5), 0.04285724, s7_N258_8));

s7_N258_6 :=  __common__( map(trim(C_INC_201K_P) = ''     => -0.012285877,
              ((real)c_inc_201k_p < 1.15) => s7_N258_7,
                                             -0.012285877));

s7_N258_5 :=  __common__( if(((real)c_ownocc_p < 28.85), -0.01717604, s7_N258_6));

s7_N258_4 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N258_5, -0.011133423));

s7_N258_3 :=  __common__( if((add1_unit_count < 490), s7_N258_4, 0.021509569));

s7_N258_2 :=  __common__( if(((real)_rel_count_addr < 0.5), 0.0059360343, -0.00023558491));

s7_N258_1 :=  __common__( if(((real)_prop_owner < 4.5), s7_N258_2, s7_N258_3));

s7_N259_9 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), 0.0086349292, -0.021735747));

s7_N259_8 :=  __common__( map(trim(C_LARCENY) = ''      => 0.032646049,
              ((real)c_larceny < 159.5) => -0.0036796767,
                                           0.032646049));

s7_N259_7 :=  __common__( map(trim(C_LOW_HVAL) = ''     => 0.0065664693,
              ((real)c_low_hval < 0.15) => 0.070673683,
                                           0.0065664693));

s7_N259_6 :=  __common__( map(trim(C_POP_25_34_P) = ''     => -0.0030234528,
              ((real)c_pop_25_34_p < 5.65) => s7_N259_7,
                                              -0.0030234528));

s7_N259_5 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N259_6, 0.0014936495));

s7_N259_4 :=  __common__( if(((integer)c_lowinc < 82), s7_N259_5, s7_N259_8));

s7_N259_3 :=  __common__( if(trim(C_LOWINC) != '', s7_N259_4, 0.007568874));

s7_N259_2 :=  __common__( if(((real)add1_unit_count < 0.5), 0.039790865, s7_N259_3));

s7_N259_1 :=  __common__( if(((real)add_errorcode < 0.5), s7_N259_2, s7_N259_9));

s7_N260_10 :=  __common__( map(trim(C_CARTHEFT) = ''       => -0.030749474,
               ((integer)c_cartheft < 184) => -0.0055715333,
                                              -0.030749474));

s7_N260_9 :=  __common__( if(((integer)add1_turnover_1yr_in < 369), 0.019125766, 0.054526969));

s7_N260_8 :=  __common__( map(trim(C_CARTHEFT) = ''       => s7_N260_9,
              ((integer)c_cartheft < 150) => -0.0056781421,
                                             s7_N260_9));

s7_N260_7 :=  __common__( if(((real)_rel_felony_count < 0.5), -0.00024268675, 0.006718696));

s7_N260_6 :=  __common__( if(((real)add1_no_of_bedrooms2 > NULL), -0.029347208, 0.033691933));

s7_N260_5 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 9.5), s7_N260_6, s7_N260_7));

s7_N260_4 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N260_5, 0.0020645896));

s7_N260_3 :=  __common__( map(trim(C_HHSIZE) = ''      => s7_N260_8,
              ((real)c_hhsize < 3.845) => s7_N260_4,
                                          s7_N260_8));

s7_N260_2 :=  __common__( if(((real)c_child < 36.45), s7_N260_3, s7_N260_10));

s7_N260_1 :=  __common__( if(trim(C_CHILD) != '', s7_N260_2, -0.00042915574));

s7_N261_9 :=  __common__( map(trim(C_UNEMPL) = ''     => 0.015107542,
              ((real)c_unempl < 60.5) => 0.071387095,
                                         0.015107542));

s7_N261_8 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.031548824, 0.0079173899));

s7_N261_7 :=  __common__( if(((real)age < 70.5), 0.002709683, s7_N261_8));

s7_N261_6 :=  __common__( map(trim(C_HVAL_60K_P) = ''      => s7_N261_9,
              ((real)c_hval_60k_p < 15.15) => s7_N261_7,
                                              s7_N261_9));

s7_N261_5 :=  __common__( if(((real)c_young < 46.55), s7_N261_6, -0.023522106));

s7_N261_4 :=  __common__( if(trim(C_YOUNG) != '', s7_N261_5, 0.023943668));

s7_N261_3 :=  __common__( if(((real)c_larceny < 160.5), 0.00051150476, -0.0067845119));

s7_N261_2 :=  __common__( if(trim(C_LARCENY) != '', s7_N261_3, -0.0097415649));

s7_N261_1 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), s7_N261_2, s7_N261_4));

s7_N262_9 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.040592264,
              ((real)c_easiqlife < 100.5) => 0.0054022239,
                                             0.040592264));

s7_N262_8 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.034797837, s7_N262_9));

s7_N262_7 :=  __common__( map(trim(C_RENTOCC_P) = ''      => -0.013996875,
              ((real)c_rentocc_p < 15.05) => 0.032191277,
                                             -0.013996875));

s7_N262_6 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N262_7, s7_N262_8));

s7_N262_5 :=  __common__( map(trim(C_INC_25K_P) = ''     => -0.024496539,
              ((real)c_inc_25k_p < 12.1) => 0.0014457822,
                                            -0.024496539));

s7_N262_4 :=  __common__( if(((real)_ssncount < 1.5), s7_N262_5, -0.00034735467));

s7_N262_3 :=  __common__( if(((real)c_hval_20k_p < 57.35), s7_N262_4, 0.019704257));

s7_N262_2 :=  __common__( if(trim(C_HVAL_20K_P) != '', s7_N262_3, 0.0043253308));

s7_N262_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N262_2, s7_N262_6));

s7_N263_9 :=  __common__( if(((real)_phone_score < 1.5), -0.0065268865, 0.048815695));

s7_N263_8 :=  __common__( if(((real)c_civ_emp < 76.25), s7_N263_9, 0.077204611));

s7_N263_7 :=  __common__( if(trim(C_CIV_EMP) != '', s7_N263_8, 0.10903138));

s7_N263_6 :=  __common__( if(((real)source_count < 2.5), 0.023684962, -0.0058865643));

s7_N263_5 :=  __common__( if(((real)rc_phoneaddrcount < 0.5), 0.040127793, -0.014901098));

s7_N263_4 :=  __common__( if(((real)c_hval_60k_p < 49.85), 0.0015029089, s7_N263_5));

s7_N263_3 :=  __common__( if(trim(C_HVAL_60K_P) != '', s7_N263_4, -0.0039194988));

s7_N263_2 :=  __common__( if(((real)_email_domain_free_count < 0.5), s7_N263_3, s7_N263_6));

s7_N263_1 :=  __common__( if(((real)add2_turnover_1yr_in < 2849.5), s7_N263_2, s7_N263_7));

s7_N264_9 :=  __common__( if(((real)_adlperssn_count < 1.5), 0.012054171, 0.042988041));

s7_N264_8 :=  __common__( if(((real)c_vacant_p < 5.25), s7_N264_9, -0.00041273515));

s7_N264_7 :=  __common__( if(trim(C_VACANT_P) != '', s7_N264_8, -0.028120267));

s7_N264_6 :=  __common__( if(((integer)add3_avm_automated_valuation < 558993), 0.0060515826, 0.043608963));

s7_N264_5 :=  __common__( if(((real)c_rape < 193.5), s7_N264_6, 0.072406502));

s7_N264_4 :=  __common__( if(trim(C_RAPE) != '', s7_N264_5, 0.0010536206));

s7_N264_3 :=  __common__( if(((real)avg_lres < 179.5), s7_N264_4, -0.0037075698));

s7_N264_2 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N264_3, s7_N264_7));

s7_N264_1 :=  __common__( if(((real)combined_age < 59.5), -0.0013903804, s7_N264_2));

s7_N265_9 :=  __common__( if(((integer)add2_avm_med < 193063), 0.047189839, 0.0032390306));

s7_N265_8 :=  __common__( if(((integer)add1_turnover_1yr_in < 1641), -0.0019148923, s7_N265_9));

s7_N265_7 :=  __common__( map(trim(C_MED_HHINC) = ''        => s7_N265_8,
              ((real)c_med_hhinc < 24727.5) => 0.021836948,
                                               s7_N265_8));

s7_N265_6 :=  __common__( map(trim(C_RNT250_P) = ''      => -0.015814979,
              ((real)c_rnt250_p < 16.85) => s7_N265_7,
                                            -0.015814979));

s7_N265_5 :=  __common__( if(((integer)add2_turnover_1yr_in < 1066), s7_N265_6, -0.015415306));

s7_N265_4 :=  __common__( map(trim(C_MED_HHINC) = ''         => -0.02945971,
              ((integer)c_med_hhinc < 43857) => -0.0034849156,
                                                -0.02945971));

s7_N265_3 :=  __common__( if(((real)input_dob_match_level < 3.5), s7_N265_4, s7_N265_5));

s7_N265_2 :=  __common__( if(((real)c_born_usa < 26.5), s7_N265_3, 0.00034872101));

s7_N265_1 :=  __common__( if(trim(C_BORN_USA) != '', s7_N265_2, -0.0041672993));

s7_N266_9 :=  __common__( map(trim(C_LOW_ED) = ''     => 0.0037996549,
              ((real)c_low_ed < 55.4) => 0.044348504,
                                         0.0037996549));

s7_N266_8 :=  __common__( map(trim(C_FOR_SALE) = ''      => 0.026733147,
              ((real)c_for_sale < 168.5) => 0.0013906799,
                                            0.026733147));

s7_N266_7 :=  __common__( map(trim(C_HVAL_1001K_P) = ''     => -0.02578409,
              ((real)c_hval_1001k_p < 0.65) => s7_N266_8,
                                               -0.02578409));

s7_N266_6 :=  __common__( map(trim(C_RETIRED) = ''     => s7_N266_7,
              ((real)c_retired < 4.15) => 0.029939517,
                                          s7_N266_7));

s7_N266_5 :=  __common__( if(((real)_property_sold_total < 0.5), s7_N266_6, s7_N266_9));

s7_N266_4 :=  __common__( if(((real)combo_dobcount < 1.5), s7_N266_5, 0.0011546714));

s7_N266_3 :=  __common__( map(trim(C_MIL_EMP) = ''     => 0.060285631,
              ((real)c_mil_emp < 3.35) => s7_N266_4,
                                          0.060285631));

s7_N266_2 :=  __common__( if(((real)c_bel_edu < 100.5), -0.0020792488, s7_N266_3));

s7_N266_1 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N266_2, -0.010058301));

s7_N267_9 :=  __common__( if((add1_avm_automated_valuation < 82777), 0.038879361, -0.013816851));

s7_N267_8 :=  __common__( if(((real)add2_lres < 36.5), 0.04856008, 0.016273845));

s7_N267_7 :=  __common__( map(trim(C_RNT500_P) = ''      => s7_N267_8,
              ((real)c_rnt500_p < 14.75) => -0.0093401002,
                                            s7_N267_8));

s7_N267_6 :=  __common__( if(((real)rc_dirsaddr_lastscore < 177.5), 0.0067933845, -0.0069259872));

s7_N267_5 :=  __common__( map(trim(C_BIGAPT_P) = ''      => s7_N267_7,
              ((real)c_bigapt_p < 20.65) => s7_N267_6,
                                            s7_N267_7));

s7_N267_4 :=  __common__( map(trim(C_RECENT_MOV) = ''     => -0.00090676233,
              ((real)c_recent_mov < 39.5) => s7_N267_5,
                                             -0.00090676233));

s7_N267_3 :=  __common__( map(trim(C_MURDERS) = ''      => 0.024315937,
              ((real)c_murders < 198.5) => s7_N267_4,
                                           0.024315937));

s7_N267_2 :=  __common__( if(((real)c_hval_80k_p < 58.55), s7_N267_3, s7_N267_9));

s7_N267_1 :=  __common__( if(trim(C_HVAL_80K_P) != '', s7_N267_2, 0.0061514963));

s7_N268_8 :=  __common__( map(trim(C_NO_MOVE) = ''      => -0.026307576,
              ((integer)c_no_move < 50) => -0.00055665825,
                                           -0.026307576));

s7_N268_7 :=  __common__( map(trim(C_MORT_INDX) = ''     => -0.0083543132,
              ((real)c_mort_indx < 26.5) => 0.012291754,
                                            -0.0083543132));

s7_N268_6 :=  __common__( if(((real)_rel_within25miles_count < 0.5), 0.015894325, s7_N268_7));

s7_N268_5 :=  __common__( if((add2_lres < 206), s7_N268_6, 0.021855254));

s7_N268_4 :=  __common__( if(((real)combo_dobcount < 9.5), s7_N268_5, s7_N268_8));

s7_N268_3 :=  __common__( if(((real)c_femdiv_p < 1.25), -0.025868272, s7_N268_4));

s7_N268_2 :=  __common__( if(trim(C_FEMDIV_P) != '', s7_N268_3, -0.0032509327));

s7_N268_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N268_2, 0.00068809223));

s7_N269_9 :=  __common__( if(((real)_rel_homeunder100_count < 4.5), 0.0018897987, 0.038211519));

s7_N269_8 :=  __common__( if(((integer)add2_avm_med < 463096), s7_N269_9, 0.06896622));

s7_N269_7 :=  __common__( if(((real)add1_source_count < 11.5), -0.001274016, s7_N269_8));

s7_N269_6 :=  __common__( if(((real)avg_lres < 42.5), 0.058317726, 0.016735083));

s7_N269_5 :=  __common__( if(((real)_inq_count < 0.5), -0.006572842, s7_N269_6));

s7_N269_4 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N269_5, 0.0062555283));

s7_N269_3 :=  __common__( map(trim(C_RETIRED2) = ''     => s7_N269_7,
              ((real)c_retired2 < 17.5) => s7_N269_4,
                                           s7_N269_7));

s7_N269_2 :=  __common__( if(((real)c_med_age < 18.5), -0.0077654574, s7_N269_3));

s7_N269_1 :=  __common__( if(trim(C_MED_AGE) != '', s7_N269_2, 0.0061612903));

s7_N270_9 :=  __common__( if(((integer)add2_turnover_1yr_in < 301), -0.021426998, 0.027054092));

s7_N270_8 :=  __common__( if(((real)_adlperssn_count < 2.5), -0.016052731, s7_N270_9));

s7_N270_7 :=  __common__( if(((real)_car_current < 0.5), 0.032879879, -0.0077801967));

s7_N270_6 :=  __common__( map(trim(C_ROBBERY) = ''      => s7_N270_7,
              ((real)c_robbery < 146.5) => -0.010617473,
                                           s7_N270_7));

s7_N270_5 :=  __common__( if(((real)add1_turnover_1yr_in < 186.5), s7_N270_6, s7_N270_8));

s7_N270_4 :=  __common__( map(trim(C_TOTSALES) = ''       => 0.0042960889,
              ((real)c_totsales < 1030.5) => 0.034325268,
                                             0.0042960889));

s7_N270_3 :=  __common__( map(trim(C_BIGAPT_P) = ''      => s7_N270_4,
              ((real)c_bigapt_p < 62.95) => 0.00032418244,
                                            s7_N270_4));

s7_N270_2 :=  __common__( if(((real)c_low_ed < 66.35), s7_N270_3, s7_N270_5));

s7_N270_1 :=  __common__( if(trim(C_LOW_ED) != '', s7_N270_2, -0.0073925345));

s7_N271_9 :=  __common__( map(trim(C_HIGHINC) = ''     => -0.0059351074,
              ((real)c_highinc < 4.15) => 0.030332569,
                                          -0.0059351074));

s7_N271_8 :=  __common__( map(trim(C_HIGH_ED) = ''     => -0.014903417,
              ((real)c_high_ed < 24.7) => 0.045185016,
                                          -0.014903417));

s7_N271_7 :=  __common__( map(trim(C_LARCENY) = ''      => 0.062852163,
              ((real)c_larceny < 136.5) => s7_N271_8,
                                           0.062852163));

s7_N271_6 :=  __common__( if(((real)add1_lres < 59.5), s7_N271_7, s7_N271_9));

s7_N271_5 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((real)mth_ver_src_fsrc_fdate < 215.5), -0.0049260759, s7_N271_6));

s7_N271_4 :=  __common__( map(trim(C_BORN_USA) = ''      => 0.038247414,
              ((real)c_born_usa < 147.5) => s7_N271_5,
                                            0.038247414));

s7_N271_3 :=  __common__( if(((real)_inq_peraddr_cap8 < 3.5), 0.00052034582, s7_N271_4));

s7_N271_2 :=  __common__( if(((real)c_med_rent < 1713.5), s7_N271_3, -0.017036764));

s7_N271_1 :=  __common__( if(trim(C_MED_RENT) != '', s7_N271_2, 0.010334029));

s7_N272_10 :=  __common__( if(((real)gong_did_first_ct < 2.5), -0.003923426, 0.038688765));

s7_N272_9 :=  __common__( if(((real)add1_turnover_1yr_in < 2976.5), s7_N272_10, 0.027807802));

s7_N272_8 :=  __common__( if(((real)_rel_prop_owned_count < 3.5), -0.00040801046, 0.04546634));

s7_N272_7 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.044610906,
              ((real)c_bel_edu < 158.5) => s7_N272_8,
                                           0.044610906));

s7_N272_6 :=  __common__( if(((real)add2_turnover_1yr_in < 65.5), s7_N272_7, s7_N272_9));

s7_N272_5 :=  __common__( map(trim(C_FEMDIV_P) = ''     => 0.027206302,
              ((real)c_femdiv_p < 4.15) => 0.0015925228,
                                           0.027206302));

s7_N272_4 :=  __common__( if(((real)input_dob_match_level < 1.5), s7_N272_5, s7_N272_6));

s7_N272_3 :=  __common__( if(((real)add1_building_area2 > NULL), 0.00011835194, s7_N272_4));

s7_N272_2 :=  __common__( if(((real)c_inc_15k_p < 53.35), s7_N272_3, 0.021833474));

s7_N272_1 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N272_2, -0.00065194761));

s7_N273_9 :=  __common__( map(trim(C_TOTCRIME) = ''     => 0.021372166,
              ((real)c_totcrime < 34.5) => 0.082282752,
                                           0.021372166));

s7_N273_8 :=  __common__( if(((real)rc_addrcount < 3.5), 0.021812445, 0.0054087581));

s7_N273_7 :=  __common__( if(((real)add1_source_count < 9.5), s7_N273_8, s7_N273_9));

s7_N273_6 :=  __common__( map(trim(C_LOWINC) = ''      => 0.033442221,
              ((real)c_lowinc < 63.45) => 0.0014818886,
                                          0.033442221));

s7_N273_5 :=  __common__( if(((integer)add1_avm_med < 310236), s7_N273_6, s7_N273_7));

s7_N273_4 :=  __common__( if(((real)_phones_per_adl < 0.5), -0.0013388211, s7_N273_5));

s7_N273_3 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.00098226724, s7_N273_4));

s7_N273_2 :=  __common__( if(((real)_ssns_per_adl < 0.5), 0.012728534, s7_N273_3));

s7_N273_1 :=  __common__( if(trim(C_MURDERS) != '', s7_N273_2, -0.0014448798));

s7_N274_10 :=  __common__( if(((real)add3_lres < 229.5), 0.009855476, 0.043826569));

s7_N274_9 :=  __common__( if(((integer)add1_avm_med < 288652), 0.043066361, 0.0047554977));

s7_N274_8 :=  __common__( if(((integer)add1_building_area2 < 1498), s7_N274_9, -3.9204643e-005));

s7_N274_7 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N274_8, s7_N274_10));

s7_N274_6 :=  __common__( if(((real)_inq_peraddr_cap8 < 0.5), 0.00037491002, s7_N274_7));

s7_N274_5 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N274_6, -0.00083351888));

s7_N274_4 :=  __common__( if(((real)rc_phonelnamecount < 0.5), -0.025184161, -0.0059472354));

s7_N274_3 :=  __common__( if(((real)age < 66.5), -0.0027578718, s7_N274_4));

s7_N274_2 :=  __common__( if(((real)attr_num_nonderogs30 < 3.5), s7_N274_3, s7_N274_5));

s7_N274_1 :=  __common__( if(trim(C_TOTSALES) != '', s7_N274_2, 0.0051844335));

s7_N275_9 :=  __common__( map(trim(C_LOW_ED) = ''      => -0.0097549592,
              ((real)c_low_ed < 64.25) => -0.00056888093,
                                          -0.0097549592));

s7_N275_8 :=  __common__( map(trim(C_RNT250_P) = ''     => 0.018419356,
              ((real)c_rnt250_p < 0.55) => 0.10545786,
                                           0.018419356));

s7_N275_7 :=  __common__( map(trim(C_MORT_INDX) = ''     => s7_N275_8,
              ((real)c_mort_indx < 71.5) => -0.0015648073,
                                            s7_N275_8));

s7_N275_6 :=  __common__( map(trim(C_MURDERS) = ''      => -0.00030772296,
              ((real)c_murders < 188.5) => s7_N275_7,
                                           -0.00030772296));

s7_N275_5 :=  __common__( map(trim(C_FEMDIV_P) = ''     => s7_N275_6,
              ((real)c_femdiv_p < 2.75) => -0.0047714354,
                                           s7_N275_6));

s7_N275_4 :=  __common__( if(((real)age < 70.5), s7_N275_5, 0.042055094));

s7_N275_3 :=  __common__( map(trim(C_ROBBERY) = ''      => s7_N275_4,
              ((real)c_robbery < 174.5) => 0.0025438192,
                                           s7_N275_4));

s7_N275_2 :=  __common__( if(((real)c_recent_mov < 39.5), s7_N275_3, s7_N275_9));

s7_N275_1 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N275_2, 0.0032687527));

s7_N276_9 :=  __common__( map(trim(C_LOWINC) = ''      => 0.016177386,
              ((real)c_lowinc < 12.15) => 0.04786741,
                                          0.016177386));

s7_N276_8 :=  __common__( if(((real)source_count < 6.5), -0.00086052696, s7_N276_9));

s7_N276_7 :=  __common__( if(((real)add2_lres < 280.5), s7_N276_8, -0.024222185));

s7_N276_6 :=  __common__( if((combo_dobscore < 95), s7_N276_7, 0.0018193821));

s7_N276_5 :=  __common__( map(trim(C_ASSAULT) = ''     => -0.002224585,
              ((real)c_assault < 86.5) => s7_N276_6,
                                          -0.002224585));

s7_N276_4 :=  __common__( map(trim(C_RENTOCC_P) = ''      => 0.021993448,
              ((real)c_rentocc_p < 94.35) => s7_N276_5,
                                             0.021993448));

s7_N276_3 :=  __common__( map((prof_license_category in ['2', '3', '4', '5']) => -0.016094633,
              (prof_license_category in ['0', '1'])           => 0.078256483,
                                                                 -0.016094633));

s7_N276_2 :=  __common__( if(((real)c_ownocc_p < 1.15), s7_N276_3, s7_N276_4));

s7_N276_1 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N276_2, -0.0033034534));

s7_N277_9 :=  __common__( map(trim(C_MANY_CARS) = ''     => -0.007592772,
              ((real)c_many_cars < 37.5) => -0.025169194,
                                            -0.007592772));

s7_N277_8 :=  __common__( map(trim(C_INC_25K_P) = ''      => 0.026784886,
              ((real)c_inc_25k_p < 12.65) => -0.018857563,
                                             0.026784886));

s7_N277_7 :=  __common__( if(((real)add1_nhood_vacant_properties < 4.5), s7_N277_8, s7_N277_9));

s7_N277_6 :=  __common__( map(trim(C_MED_AGE) = ''     => -0.0011314539,
              ((real)c_med_age < 16.5) => s7_N277_7,
                                          -0.0011314539));

s7_N277_5 :=  __common__( if(((real)age < 47.5), 0.040883413, -0.018603226));

s7_N277_4 :=  __common__( map(trim(C_MANY_CARS) = ''     => s7_N277_5,
              ((real)c_many_cars < 69.5) => 0.067451778,
                                            s7_N277_5));

s7_N277_3 :=  __common__( map(trim(C_MORT_INDX) = ''     => s7_N277_4,
              ((real)c_mort_indx < 80.5) => -0.001698031,
                                            s7_N277_4));

s7_N277_2 :=  __common__( if(((real)c_recent_mov < 5.5), s7_N277_3, s7_N277_6));

s7_N277_1 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N277_2, 0.007180639));

s7_N278_8 :=  __common__( if(((real)combined_age < 55.5), -0.015642061, 0.048184792));

s7_N278_7 :=  __common__( if(mth_header_first_seen != null and ((real)mth_header_first_seen < 234.5), 0.05801891, s7_N278_8));

s7_N278_6 :=  __common__( map(trim(C_INC_35K_P) = ''      => 0.014081177,
              ((real)c_inc_35k_p < 14.45) => 0.072018098,
                                             0.014081177));

s7_N278_5 :=  __common__( if(((real)c_hval_20k_p < 2.2), -0.009357403, s7_N278_6));

s7_N278_4 :=  __common__( if(trim(C_HVAL_20K_P) != '', s7_N278_5, -0.027672976));

s7_N278_3 :=  __common__( if(((real)add1_lres < 5.5), s7_N278_4, 0.0035090681));

s7_N278_2 :=  __common__( if(((real)_rel_criminal_count < 3.5), s7_N278_3, s7_N278_7));

s7_N278_1 :=  __common__( if(((integer)add1_avm_med < 39319), s7_N278_2, -0.0003951276));

s7_N279_8 :=  __common__( map(trim(C_HIGH_ED) = ''     => 0.027675701,
              ((real)c_high_ed < 6.65) => 0.08618965,
                                          0.027675701));

s7_N279_7 :=  __common__( map(trim(C_LOWINC) = ''      => -0.0077729859,
              ((real)c_lowinc < 65.15) => s7_N279_8,
                                          -0.0077729859));

s7_N279_6 :=  __common__( map(trim(C_BURGLARY) = ''      => s7_N279_7,
              ((real)c_burglary < 124.5) => -0.00028445488,
                                            s7_N279_7));

s7_N279_5 :=  __common__( if(((real)combined_age < 64.5), 0.0051054506, 0.016368593));

s7_N279_4 :=  __common__( map(trim(C_RAPE) = ''      => -0.0065691063,
              ((real)c_rape < 104.5) => s7_N279_5,
                                        -0.0065691063));

s7_N279_3 :=  __common__( if(((real)c_low_hval < 49.35), s7_N279_4, s7_N279_6));

s7_N279_2 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N279_3, 0.017449878));

s7_N279_1 :=  __common__( if(((real)_nap < 3.5), -0.00031641609, s7_N279_2));

s7_N280_8 :=  __common__( if(((real)avg_lres < 349.5), -0.0035786272, 0.052660623));

s7_N280_7 :=  __common__( if(((real)add2_lres < 86.5), 0.069800637, -0.00074859504));

s7_N280_6 :=  __common__( if(((real)add3_lres < 21.5), s7_N280_7, -0.010073561));

s7_N280_5 :=  __common__( if(((real)source_count < 9.5), s7_N280_6, 0.07453158));

s7_N280_4 :=  __common__( if(((integer)add1_turnover_1yr_in < 4307), 0.0012916905, 0.042140406));

s7_N280_3 :=  __common__( if(((integer)c_med_hval < 451674), s7_N280_4, s7_N280_5));

s7_N280_2 :=  __common__( if(trim(C_MED_HVAL) != '', s7_N280_3, 0.002494179));

s7_N280_1 :=  __common__( if(((real)_util_adl_count < 1.5), s7_N280_2, s7_N280_8));

s7_N281_9 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), 0.10813655, -0.0028133172));

s7_N281_8 :=  __common__( if(((integer)add2_turnover_1yr_in < 1253), s7_N281_9, 0.064210049));

s7_N281_7 :=  __common__( if(((integer)c_easiqlife < 115), 0.018009553, 0.067632161));

s7_N281_6 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N281_7, -0.025653968));

s7_N281_5 :=  __common__( if(((real)combo_dobcount < 4.5), s7_N281_6, s7_N281_8));

s7_N281_4 :=  __common__( map(trim(C_WHITE_COL) = ''     => 0.019734612,
              ((real)c_white_col < 49.3) => -0.021793206,
                                            0.019734612));

s7_N281_3 :=  __common__( if(((real)add_errorcode < 0.5), -0.00026557777, s7_N281_4));

s7_N281_2 :=  __common__( if(trim(C_INC_35K_P) != '', s7_N281_3, 0.0005023278));

s7_N281_1 :=  __common__( if(((real)_inq_perssn < 2.5), s7_N281_2, s7_N281_5));

s7_N282_9 :=  __common__( if(((real)age < 49.5), -0.014013162, 0.065224301));

s7_N282_8 :=  __common__( map(trim(C_MURDERS) = ''      => 0.0048897799,
              ((real)c_murders < 173.5) => -0.015952606,
                                           0.0048897799));

s7_N282_7 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.0026688919,
              ((real)c_sfdu_p < 57.35) => s7_N282_8,
                                          0.0026688919));

s7_N282_6 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N282_7, 0.00050432772));

s7_N282_5 :=  __common__( map(trim(C_TOTCRIME) = ''      => s7_N282_9,
              ((real)c_totcrime < 184.5) => s7_N282_6,
                                            s7_N282_9));

s7_N282_4 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.028679868,
              ((real)c_relig_indx < 117.5) => -0.019712962,
                                              0.028679868));

s7_N282_3 :=  __common__( if(((real)attr_num_nonderogs180 < 4.5), 0.041144902, s7_N282_4));

s7_N282_2 :=  __common__( if(((real)add1_unit_count < 0.5), s7_N282_3, s7_N282_5));

s7_N282_1 :=  __common__( if(trim(C_TOTCRIME) != '', s7_N282_2, 0.0027153363));

s7_N283_9 :=  __common__( map(trim(C_SFDU_P) = ''      => -0.0012220574,
              ((real)c_sfdu_p < 33.15) => -0.024602129,
                                          -0.0012220574));

s7_N283_8 :=  __common__( if(((real)_rel_incomeunder50_count < 1.5), 0.015044104, 0.00081001062));

s7_N283_7 :=  __common__( map(trim(C_SPAN_LANG) = ''      => s7_N283_9,
              ((real)c_span_lang < 174.5) => s7_N283_8,
                                             s7_N283_9));

s7_N283_6 :=  __common__( map(trim(C_CARTHEFT) = ''       => 0.035012375,
              ((integer)c_cartheft < 142) => -4.5305584e-005,
                                             0.035012375));

s7_N283_5 :=  __common__( map(trim(C_MED_INC) = ''     => s7_N283_7,
              ((real)c_med_inc < 19.5) => s7_N283_6,
                                          s7_N283_7));

s7_N283_4 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.0015669078, s7_N283_5));

s7_N283_3 :=  __common__( map(trim(C_LOWINC) = ''      => -0.013618841,
              ((real)c_lowinc < 72.95) => s7_N283_4,
                                          -0.013618841));

s7_N283_2 :=  __common__( if(((real)c_asian_lang < 185.5), s7_N283_3, -0.0071606358));

s7_N283_1 :=  __common__( if(trim(C_ASIAN_LANG) != '', s7_N283_2, -0.00094601006));

s7_N284_7 :=  __common__( if((combo_dobscore < 92), -0.020458528, 0.0016993119));

s7_N284_6 :=  __common__( if(((real)_rel_count_addr < 4.5), s7_N284_7, 0.027828007));

s7_N284_5 :=  __common__( if(((real)add1_nhood_vacant_properties < 32.5), -0.0094578435, 0.021848262));

s7_N284_4 :=  __common__( map(trim(C_RENTOCC_P) = ''      => 0.023365435,
              ((real)c_rentocc_p < 14.45) => 0.062592929,
                                             0.023365435));

s7_N284_3 :=  __common__( if(((real)add_bestmatch_level < 0.5), s7_N284_4, s7_N284_5));

s7_N284_2 :=  __common__( if(((real)add1_source_count < 4.5), s7_N284_3, s7_N284_6));

s7_N284_1 :=  __common__( if(((real)combined_age < 70.5), -0.00067585418, s7_N284_2));

s7_N285_10 :=  __common__( map(trim(C_MED_INC) = ''      => -0.00084657818,
               ((integer)c_med_inc < 92) => 0.042476506,
                                            -0.00084657818));

s7_N285_9 :=  __common__( map(trim(C_NO_MOVE) = ''     => 0.0078959806,
              ((real)c_no_move < 44.5) => 0.043353415,
                                          0.0078959806));

s7_N285_8 :=  __common__( map(trim(C_LOW_HVAL) = ''    => -0.0048611445,
              ((real)c_low_hval < 8.2) => s7_N285_9,
                                          -0.0048611445));

s7_N285_7 :=  __common__( map(trim(C_LOW_ED) = ''      => -0.012688988,
              ((real)c_low_ed < 65.95) => -0.00041698316,
                                          -0.012688988));

s7_N285_6 :=  __common__( map(trim(C_SPAN_LANG) = ''      => s7_N285_8,
              ((real)c_span_lang < 193.5) => s7_N285_7,
                                             s7_N285_8));

s7_N285_5 :=  __common__( if(((real)_rel_felony_total < 2.5), s7_N285_6, s7_N285_10));

s7_N285_4 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N285_5, -0.0050248128));

s7_N285_3 :=  __common__( if(((integer)add1_building_area2 < 589), 0.042416213, 0.00029005909));

s7_N285_2 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N285_3, 0.025817284));

s7_N285_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N285_2, s7_N285_4));

s7_N286_10 :=  __common__( map(trim(C_INC_25K_P) = ''     => -0.0032624463,
               ((real)c_inc_25k_p < 3.85) => 0.022019629,
                                             -0.0032624463));

s7_N286_9 :=  __common__( map(trim(C_LOWRENT) = ''      => 0.053429276,
              ((real)c_lowrent < 15.95) => -0.00038717517,
                                           0.053429276));

s7_N286_8 :=  __common__( if(((real)_nap < 3.5), s7_N286_9, 0.046404847));

s7_N286_7 :=  __common__( map(trim(C_EASIQLIFE) = ''       => s7_N286_8,
              ((integer)c_easiqlife < 118) => -0.014439067,
                                              s7_N286_8));

s7_N286_6 :=  __common__( if(((real)c_born_usa < 30.5), s7_N286_7, s7_N286_10));

s7_N286_5 :=  __common__( if(trim(C_BORN_USA) != '', s7_N286_6, 0.06201302));

s7_N286_4 :=  __common__( if(((real)_rel_incomeunder25_count < 0.5), s7_N286_5, -0.0025724935));

s7_N286_3 :=  __common__( if(((real)_nap < 5.5), s7_N286_4, 0.021191786));

s7_N286_2 :=  __common__( if(((real)_ssncount < 1.5), -0.015483247, s7_N286_3));

s7_N286_1 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s7_N286_2, -0.00010545423));

s7_N287_10 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), 0.050363165, 0.0027100936));

s7_N287_9 :=  __common__( map(trim(C_OWNOCC_P) = ''     => 0.0085410192,
              ((real)c_ownocc_p < 20.3) => -0.016623785,
                                           0.0085410192));

s7_N287_8 :=  __common__( if((add1_lres < 164), s7_N287_9, s7_N287_10));

s7_N287_7 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.033732949,
              ((real)c_easiqlife < 137.5) => s7_N287_8,
                                             0.033732949));

s7_N287_6 :=  __common__( map(trim(C_RECENT_MOV) = ''     => s7_N287_7,
              ((real)c_recent_mov < 54.5) => 0.035469181,
                                             s7_N287_7));

s7_N287_5 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), 0.16220711, -0.016382563));

s7_N287_4 :=  __common__( if(((real)age < 16.5), s7_N287_5, 0.00086886373));

s7_N287_3 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N287_4, 0.0043677106));

s7_N287_2 :=  __common__( if(((real)c_bigapt_p < 62.85), s7_N287_3, s7_N287_6));

s7_N287_1 :=  __common__( if(trim(C_BIGAPT_P) != '', s7_N287_2, -0.0036365513));

s7_N288_9 :=  __common__( map(trim(C_RECENT_MOV) = ''      => 0.052167517,
              ((real)c_recent_mov < 169.5) => 0.0097018855,
                                              0.052167517));

s7_N288_8 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.033752522,
              ((real)c_span_lang < 158.5) => -0.005889306,
                                             0.033752522));

s7_N288_7 :=  __common__( if(((integer)rc_lnamessnmatch < 0.5), s7_N288_8, -0.011828487));

s7_N288_6 :=  __common__( if(((real)_addrs_last12 < 2.5), s7_N288_7, s7_N288_9));

s7_N288_5 :=  __common__( map(trim(C_RNT250_P) = ''    => 0.060183028,
              ((real)c_rnt250_p < 6.5) => -0.0062812884,
                                          0.060183028));

s7_N288_4 :=  __common__( if(((real)add_bestmatch_level < 1.5), s7_N288_5, 0.057272818));

s7_N288_3 :=  __common__( map(trim(C_INC_15K_P) = ''      => s7_N288_6,
              ((real)c_inc_15k_p < 16.35) => s7_N288_4,
                                             s7_N288_6));

s7_N288_2 :=  __common__( if(((real)c_low_hval < 66.45), -0.00074493557, s7_N288_3));

s7_N288_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N288_2, 0.002032238));

s7_N289_9 :=  __common__( map(trim(C_MED_HVAL) = ''          => 0.056747729,
              ((integer)c_med_hval < 148406) => -0.0058733588,
                                                0.056747729));

s7_N289_8 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.043983545,
              ((real)c_span_lang < 141.5) => -0.01330504,
                                             0.043983545));

s7_N289_7 :=  __common__( if(((real)_wealth_index < 1.5), s7_N289_8, -0.0090121986));

s7_N289_6 :=  __common__( if((combo_dobscore < 98), -0.021491709, s7_N289_7));

s7_N289_5 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.0016843427,
              ((real)c_sfdu_p < 71.25) => s7_N289_6,
                                          0.0016843427));

s7_N289_4 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N289_9,
              ((real)c_civ_emp < 82.45) => s7_N289_5,
                                           s7_N289_9));

s7_N289_3 :=  __common__( map(trim(C_LARCENY) = ''      => s7_N289_4,
              ((real)c_larceny < 149.5) => 0.0026506192,
                                           s7_N289_4));

s7_N289_2 :=  __common__( if(((real)c_femdiv_p < 2.15), -0.0062126353, s7_N289_3));

s7_N289_1 :=  __common__( if(trim(C_FEMDIV_P) != '', s7_N289_2, -0.0075336571));

s7_N290_10 :=  __common__( map((prof_license_category in ['0', '1', '2', '4', '5']) => 0.0024882621,
               (prof_license_category in ['3'])                     => 0.10073469,
                                                                       0.0024882621));

s7_N290_9 :=  __common__( if(((integer)rc_lnamessnmatch2 < 0.5), 0.054530481, s7_N290_10));

s7_N290_8 :=  __common__( if(((real)add3_lres < 1.5), s7_N290_9, -0.0071411535));

s7_N290_7 :=  __common__( if(((real)add2_source_count < 3.5), 0.056609159, 0.0033108152));

s7_N290_6 :=  __common__( map(trim(C_RECENT_MOV) = ''      => 0.0066946924,
              ((integer)c_recent_mov < 68) => 0.05602192,
                                              0.0066946924));

s7_N290_5 :=  __common__( map(trim(C_RAPE) = ''      => s7_N290_6,
              ((real)c_rape < 126.5) => -0.0072900391,
                                        s7_N290_6));

s7_N290_4 :=  __common__( if(((real)_rel_educationunder8_count < 2.5), s7_N290_5, s7_N290_7));

s7_N290_3 :=  __common__( if(((real)c_incollege < 2.95), s7_N290_4, s7_N290_8));

s7_N290_2 :=  __common__( if(trim(C_INCOLLEGE) != '', s7_N290_3, 0.011498384));

s7_N290_1 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N290_2, -0.00058139725));

s7_N291_9 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => 0.023944794,
              ((real)c_fammar18_p < 25.25) => 0.056052227,
                                              0.023944794));

s7_N291_8 :=  __common__( if(((real)_addrs_5yr < 4.5), 0.0010651077, s7_N291_9));

s7_N291_7 :=  __common__( if(((integer)_phone_score < 0), 0.044693152, 0.0095558403));

s7_N291_6 :=  __common__( if(((real)source_count < 3.5), s7_N291_7, 0.0015343588));

s7_N291_5 :=  __common__( if(((real)add1_turnover_1yr_in < 1580.5), s7_N291_6, s7_N291_8));

s7_N291_4 :=  __common__( map(trim(C_APT20) = ''      => s7_N291_5,
              ((real)c_apt20 < 179.5) => -9.1002246e-006,
                                         s7_N291_5));

s7_N291_3 :=  __common__( map(trim(C_ROBBERY) = ''      => 0.033885067,
              ((real)c_robbery < 189.5) => s7_N291_4,
                                           0.033885067));

s7_N291_2 :=  __common__( if(((real)c_robbery < 190.5), s7_N291_3, -0.009893324));

s7_N291_1 :=  __common__( if(trim(C_ROBBERY) != '', s7_N291_2, 0.0073554321));

s7_N292_8 :=  __common__( if(((real)_rel_incomeunder25_count < 4.5), 0.00018152087, -0.022014591));

s7_N292_7 :=  __common__( map(trim(C_MED_RENT) = ''       => s7_N292_8,
              ((integer)c_med_rent < 270) => 0.027259768,
                                             s7_N292_8));

s7_N292_6 :=  __common__( map(trim(C_HHSIZE) = ''      => -0.017663279,
              ((real)c_hhsize < 3.215) => s7_N292_7,
                                          -0.017663279));

s7_N292_5 :=  __common__( if(((real)_rel_within100miles_count < 2.5), s7_N292_6, 0.017050862));

s7_N292_4 :=  __common__( if(((real)c_hhsize < 1.945), -0.020029953, s7_N292_5));

s7_N292_3 :=  __common__( if(trim(C_HHSIZE) != '', s7_N292_4, -0.01192359));

s7_N292_2 :=  __common__( if(((real)_addrs_last36 < 5.5), s7_N292_3, -0.018430208));

s7_N292_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N292_2, 0.00096671176));

s7_N293_10 :=  __common__( map(trim(C_FAMMAR_P) = ''      => 0.00031279229,
               ((real)c_fammar_p < 46.05) => -0.020615155,
                                             0.00031279229));

s7_N293_9 :=  __common__( if(((real)rc_addrcount < 2.5), 0.047342125, 0.018552954));

s7_N293_8 :=  __common__( map(trim(C_UNEMP) = ''      => 0.038100194,
              ((real)c_unemp < 10.95) => 0.0040261252,
                                         0.038100194));

s7_N293_7 :=  __common__( if(((integer)add2_eda_sourced < 0.5), s7_N293_8, s7_N293_9));

s7_N293_6 :=  __common__( if(((real)add1_building_area2 < 1334.5), s7_N293_7, s7_N293_10));

s7_N293_5 :=  __common__( if(((real)_nap < 5.5), s7_N293_6, 0.023025163));

s7_N293_4 :=  __common__( if(((real)_ssns_per_addr < 4.5), -0.0072104447, s7_N293_5));

s7_N293_3 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N293_4, -0.00010866352));

s7_N293_2 :=  __common__( if(((real)c_low_ed < 84.25), s7_N293_3, 0.023421388));

s7_N293_1 :=  __common__( if(trim(C_LOW_ED) != '', s7_N293_2, -0.00035300706));

s7_N294_8 :=  __common__( map(trim(C_RETIRED) = ''      => 0.0042565934,
              ((real)c_retired < 14.85) => 0.057309942,
                                           0.0042565934));

s7_N294_7 :=  __common__( if(((real)_phones_per_addr < 5.5), 0.0042284121, 0.041743068));

s7_N294_6 :=  __common__( if(((real)combined_age < 71.5), s7_N294_7, s7_N294_8));

s7_N294_5 :=  __common__( if(((real)_rel_prop_owned_count < 0.5), s7_N294_6, 0.00030136575));

s7_N294_4 :=  __common__( map(trim(C_YOUNG) = ''      => 0.027105006,
              ((real)c_young < 28.05) => -0.00082842006,
                                         0.027105006));

s7_N294_3 :=  __common__( if(((real)c_easiqlife < 155.5), -0.0040174749, s7_N294_4));

s7_N294_2 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N294_3, 0.0010306968));

s7_N294_1 :=  __common__( if(((real)_ssns_per_addr < 5.5), s7_N294_2, s7_N294_5));

s7_N295_10 :=  __common__( if(((real)add1_turnover_1yr_in < 421.5), 0.053162212, 0.0057594455));

s7_N295_9 :=  __common__( if(((real)_adls_per_addr_cap10 < 9.5), 0.0085220456, s7_N295_10));

s7_N295_8 :=  __common__( if(((real)c_totcrime < 52.5), -0.013773928, s7_N295_9));

s7_N295_7 :=  __common__( if(trim(C_TOTCRIME) != '', s7_N295_8, -0.028521359));

s7_N295_6 :=  __common__( if(((real)add3_source_count < 3.5), -0.0003752914, s7_N295_7));

s7_N295_5 :=  __common__( if(((real)avg_lres < 196.5), s7_N295_6, 0.034640249));

s7_N295_4 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N295_5, 0.0015596643));

s7_N295_3 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 0.5), -0.0020433764, s7_N295_4));

s7_N295_2 :=  __common__( if(((real)ssn_lowissue_age < 54.44), s7_N295_3, -0.025278015));

s7_N295_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N295_2, 0.0036003981));

s7_N296_8 :=  __common__( if(((real)combined_age < 50.5), 0.011898291, 0.056139059));

s7_N296_7 :=  __common__( map(trim(C_LAR_FAM) = ''      => -0.022908657,
              ((real)c_lar_fam < 108.5) => 0.012217973,
                                           -0.022908657));

s7_N296_6 :=  __common__( map((prof_license_category in ['0', '2', '3', '4', '5']) => s7_N296_7,
              (prof_license_category in ['1'])                     => 0.19666626,
                                                                      s7_N296_7));

s7_N296_5 :=  __common__( map(trim(C_RNT500_P) = ''     => 0.035543259,
              ((real)c_rnt500_p < 26.7) => s7_N296_6,
                                           0.035543259));

s7_N296_4 :=  __common__( if(((real)c_ownocc_p < 11.45), s7_N296_5, 0.00068131553));

s7_N296_3 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N296_4, -0.00078673624));

s7_N296_2 :=  __common__( if(((real)add2_source_count < 4.5), s7_N296_3, s7_N296_8));

s7_N296_1 :=  __common__( if(((real)add2_lres < 19.5), s7_N296_2, -0.001612702));

s7_N297_10 :=  __common__( if(((real)_rel_felony_total < 1.5), -0.0016295329, 0.014425688));

s7_N297_9 :=  __common__( map(trim(C_ASSAULT) = ''       => 0.043325943,
              ((integer)c_assault < 176) => -0.0026302945,
                                            0.043325943));

s7_N297_8 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), 0.08396258, 0.040024754));

s7_N297_7 :=  __common__( if(((real)_ssns_per_addr < 3.5), s7_N297_8, -0.0058331329));

s7_N297_6 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N297_9,
              ((real)c_rnt750_p < 13.05) => s7_N297_7,
                                            s7_N297_9));

s7_N297_5 :=  __common__( if(((real)_rel_count < 1.5), s7_N297_6, s7_N297_10));

s7_N297_4 :=  __common__( if(((real)add1_building_area2 > NULL), 0.0011796279, s7_N297_5));

s7_N297_3 :=  __common__( map(trim(C_BLUE_COL) = ''      => -0.024496872,
              ((real)c_blue_col < 32.05) => s7_N297_4,
                                            -0.024496872));

s7_N297_2 :=  __common__( if(((real)c_vacant_p < 27.35), s7_N297_3, -0.01660406));

s7_N297_1 :=  __common__( if(trim(C_VACANT_P) != '', s7_N297_2, -0.0018121531));

s7_N298_10 :=  __common__( map(trim(C_BURGLARY) = ''       => 0.0413769,
               ((integer)c_burglary < 140) => 0.0046799497,
                                              0.0413769));

s7_N298_9 :=  __common__( if(((real)add2_naprop < 2.5), s7_N298_10, -0.008529099));

s7_N298_8 :=  __common__( if(((real)avg_lres < 11.5), -0.019281678, s7_N298_9));

s7_N298_7 :=  __common__( if(((real)c_inc_50k_p < 20.05), s7_N298_8, 0.034291821));

s7_N298_6 :=  __common__( if(trim(C_INC_50K_P) != '', s7_N298_7, 0.00029141332));

s7_N298_5 :=  __common__( if(((real)c_blue_empl < 37.5), 0.044825858, 0.0098670475));

s7_N298_4 :=  __common__( if(trim(C_BLUE_EMPL) != '', s7_N298_5, 0.038618475));

s7_N298_3 :=  __common__( if(((real)mth_gong_did_first_seen < 83.5), -0.0050429751, s7_N298_4));

s7_N298_2 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N298_3, s7_N298_6));

s7_N298_1 :=  __common__( if(((real)add1_source_count < 1.5), s7_N298_2, -0.0012516378));

s7_N299_9 :=  __common__( if(((real)mth_header_first_seen < 283.5), -0.00028265, -0.017286262));

s7_N299_8 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N299_9, -0.025983503));

s7_N299_7 :=  __common__( map(trim(C_HHSIZE) = ''      => -0.022382575,
              ((real)c_hhsize < 3.035) => s7_N299_8,
                                          -0.022382575));

s7_N299_6 :=  __common__( map((prof_license_category in ['2', '4'])           => s7_N299_7,
              (prof_license_category in ['0', '1', '3', '5']) => 0.022420136,
                                                                 s7_N299_7));

s7_N299_5 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N299_6, -0.029743036));

s7_N299_4 :=  __common__( if(((real)age < 32.5), 0.027771905, 0.0024187941));

s7_N299_3 :=  __common__( map(trim(C_RAPE) = ''     => -0.0091579622,
              ((real)c_rape < 80.5) => s7_N299_4,
                                       -0.0091579622));

s7_N299_2 :=  __common__( if(((integer)rc_lnamessnmatch < 0.5), s7_N299_3, s7_N299_5));

s7_N299_1 :=  __common__( if(((real)input_dob_match_level < 5.5), s7_N299_2, -0.00088869981));

s7_N300_9 :=  __common__( if(((real)_add_risk < 0.5), 0.037666046, 0.0069342041));

s7_N300_8 :=  __common__( if(((real)add1_source_count < 0.5), s7_N300_9, 0.00011065073));

s7_N300_7 :=  __common__( map(trim(C_ASIAN_LANG) = ''       => 0.028144532,
              ((integer)c_asian_lang < 144) => 0.0059924407,
                                               0.028144532));

s7_N300_6 :=  __common__( if(((integer)mth_ver_src_fsrc_fdate < 250), -0.0052870946, s7_N300_7));

s7_N300_5 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N300_6, -0.0017087607));

s7_N300_4 :=  __common__( if(((integer)add1_nhood_vacant_properties < 290), s7_N300_5, -0.023478914));

s7_N300_3 :=  __common__( if(((real)c_inc_201k_p < 3.95), s7_N300_4, -0.015914632));

s7_N300_2 :=  __common__( if(trim(C_INC_201K_P) != '', s7_N300_3, -0.012651011));

s7_N300_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N300_2, s7_N300_8));

s7_N301_9 :=  __common__( if(((integer)add2_avm_med < 498750), 0.094269761, 0.038161083));

s7_N301_8 :=  __common__( if(((real)add2_turnover_1yr_in < 380.5), s7_N301_9, -0.00088729133));

s7_N301_7 :=  __common__( if(((real)add3_source_count < 4.5), -0.0058622085, 0.030835417));

s7_N301_6 :=  __common__( map(trim(C_HIGH_HVAL) = ''      => s7_N301_7,
              ((real)c_high_hval < 18.95) => 0.054912558,
                                             s7_N301_7));

s7_N301_5 :=  __common__( if(ssn_lowissue_age != null and ((real)ssn_lowissue_age < 16.0296), s7_N301_6, s7_N301_8));

s7_N301_4 :=  __common__( map(trim(C_INCOLLEGE) = ''     => -0.011372941,
              ((real)c_incollege < 4.25) => 0.014941309,
                                            -0.011372941));

s7_N301_3 :=  __common__( map(trim(C_INC_50K_P) = ''     => s7_N301_5,
              ((real)c_inc_50k_p < 7.15) => s7_N301_4,
                                            s7_N301_5));

s7_N301_2 :=  __common__( if(((real)c_hval_750k_p < 13.75), 0.00025081117, s7_N301_3));

s7_N301_1 :=  __common__( if(trim(C_HVAL_750K_P) != '', s7_N301_2, -0.00056002861));

s7_N302_9 :=  __common__( if(((integer)c_no_move < 79), -0.0012490476, -0.022677196));

s7_N302_8 :=  __common__( if(trim(C_NO_MOVE) != '', s7_N302_9, -0.030379275));

s7_N302_7 :=  __common__( if(((real)input_dob_match_level < 4.5), s7_N302_8, -0.0028931812));

s7_N302_6 :=  __common__( if(((real)add1_nhood_vacant_properties < 33.5), 0.053809275, 0.0064286918));

s7_N302_5 :=  __common__( if(((real)c_inc_15k_p < 20.05), 0.0061456732, s7_N302_6));

s7_N302_4 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N302_5, -0.02636945));

s7_N302_3 :=  __common__( if(((real)add2_source_count < 6.5), 0.00045644058, s7_N302_4));

s7_N302_2 :=  __common__( if(((real)_ams_college_tier < 5.5), s7_N302_3, 0.046329594));

s7_N302_1 :=  __common__( if(((real)_lnames_per_adl < 2.5), s7_N302_2, s7_N302_7));

s7_N303_8 :=  __common__( map(trim(C_FEMDIV_P) = ''     => -0.020109905,
              ((real)c_femdiv_p < 3.45) => 0.023993546,
                                           -0.020109905));

s7_N303_7 :=  __common__( map(trim(C_INC_50K_P) = ''      => 0.032493008,
              ((real)c_inc_50k_p < 16.45) => s7_N303_8,
                                             0.032493008));

s7_N303_6 :=  __common__( if(((real)c_high_ed < 11.35), -0.032430172, s7_N303_7));

s7_N303_5 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N303_6, 0.00028303014));

s7_N303_4 :=  __common__( map(trim(C_INC_201K_P) = ''     => 0.0085653335,
              ((real)c_inc_201k_p < 1.35) => 0.038389277,
                                             0.0085653335));

s7_N303_3 :=  __common__( map((prof_license_category in ['1', '3', '4', '5']) => s7_N303_4,
              (prof_license_category in ['0', '2'])           => 0.13109773,
                                                                 s7_N303_4));

s7_N303_2 :=  __common__( if(((real)_addrs_per_ssn < 6.5), s7_N303_3, s7_N303_5));

s7_N303_1 :=  __common__( if(((real)add1_lres < 0.5), s7_N303_2, 0.00049198056));

s7_N304_9 :=  __common__( if(((real)add2_nhood_vacant_properties < 16.5), 0.035336644, 0.0036502544));

s7_N304_8 :=  __common__( if(((real)gong_did_addr_ct < 1.5), s7_N304_9, -0.012626713));

s7_N304_7 :=  __common__( map(trim(C_OWNOCC_P) = ''    => s7_N304_8,
              ((real)c_ownocc_p < 9.6) => 0.039930105,
                                          s7_N304_8));

s7_N304_6 :=  __common__( if(((real)c_easiqlife < 136.5), -0.00017124976, s7_N304_7));

s7_N304_5 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N304_6, 0.012317071));

s7_N304_4 :=  __common__( if(((real)add2_turnover_1yr_in < 40.5), 0.027294956, s7_N304_5));

s7_N304_3 :=  __common__( if(((real)c_ownocc_p < 18.45), -0.009404038, 0.00052648772));

s7_N304_2 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N304_3, 0.0083201355));

s7_N304_1 :=  __common__( if(((real)add1_unit_count < 53.5), s7_N304_2, s7_N304_4));

s7_N305_12 :=  __common__( if(((real)age < 83.5), 0.0015879471, 0.020996888));

s7_N305_11 :=  __common__( if(((integer)add1_avm_med < 185778), -0.003028834, s7_N305_12));

s7_N305_10 :=  __common__( if(((real)ssn_lowissue_age < 46.3855), s7_N305_11, -0.01554402));

s7_N305_9 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N305_10, -0.0038231691));

s7_N305_8 :=  __common__( if(((real)c_born_usa < 20.5), -0.018280105, -0.0030776897));

s7_N305_7 :=  __common__( if(trim(C_BORN_USA) != '', s7_N305_8, -0.0093313285));

s7_N305_6 :=  __common__( map(trim(C_FAMMAR18_P) = ''     => 0.099698911,
              ((real)c_fammar18_p < 36.2) => 0.0043977548,
                                             0.099698911));

s7_N305_5 :=  __common__( map(trim(C_VACANT_P) = ''    => s7_N305_6,
              ((real)c_vacant_p < 3.7) => -0.019471863,
                                          s7_N305_6));

s7_N305_4 :=  __common__( if(((real)c_blue_col < 20.9), 0.002334478, s7_N305_5));

s7_N305_3 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N305_4, 0.00028450896));

s7_N305_2 :=  __common__( if(((real)mth_attr_date_last_derog < 56.5), s7_N305_3, s7_N305_7));

s7_N305_1 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N305_2, s7_N305_9));

s7_N306_11 :=  __common__( map(trim(C_POP_18_24_P) = ''     => 0.0015097714,
               ((real)c_pop_18_24_p < 4.75) => 0.019974328,
                                               0.0015097714));

s7_N306_10 :=  __common__( map(trim(C_INC_150K_P) = ''     => -0.0079782314,
               ((real)c_inc_150k_p < 8.75) => s7_N306_11,
                                              -0.0079782314));

s7_N306_9 :=  __common__( if(((real)add2_no_of_bedrooms2 < 3.5), -0.01591402, 0.044412075));

s7_N306_8 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s7_N306_9, -0.017230945));

s7_N306_7 :=  __common__( map(trim(C_ASSAULT) = ''     => s7_N306_10,
              ((real)c_assault < 18.5) => s7_N306_8,
                                          s7_N306_10));

s7_N306_6 :=  __common__( map(trim(C_HIGHINC) = ''     => 0.054300046,
              ((real)c_highinc < 65.8) => s7_N306_7,
                                          0.054300046));

s7_N306_5 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => -0.00093125665,
              ((real)c_fammar18_p < 12.95) => -0.015733109,
                                              -0.00093125665));

s7_N306_4 :=  __common__( if(((real)add1_avm_automated_valuation < 20102.5), 0.043924313, s7_N306_5));

s7_N306_3 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N306_4, s7_N306_6));

s7_N306_2 :=  __common__( if(((integer)c_med_hhinc < 14290), 0.016491499, s7_N306_3));

s7_N306_1 :=  __common__( if(trim(C_MED_HHINC) != '', s7_N306_2, 0.002218462));

s7_N307_9 :=  __common__( if(((real)_wealth_index < 1.5), 0.025965927, -0.019284579));

s7_N307_8 :=  __common__( map(trim(C_RNT500_P) = ''     => 0.0035936927,
              ((real)c_rnt500_p < 27.7) => 0.036775263,
                                           0.0035936927));

s7_N307_7 :=  __common__( map(trim(C_VACANT_P) = ''    => -0.027895218,
              ((real)c_vacant_p < 5.5) => 0.0019970094,
                                          -0.027895218));

s7_N307_6 :=  __common__( if(((real)_ssns_per_addr < 9.5), -0.0014463171, 0.028107799));

s7_N307_5 :=  __common__( if(((real)_nap < 5.5), 6.1966396e-005, s7_N307_6));

s7_N307_4 :=  __common__( if(((real)add_errorcode < 0.5), s7_N307_5, s7_N307_7));

s7_N307_3 :=  __common__( map(trim(C_POP_18_24_P) = ''      => -0.009030701,
              ((real)c_pop_18_24_p < 15.75) => s7_N307_4,
                                               -0.009030701));

s7_N307_2 :=  __common__( if(((real)c_pop_18_24_p < 42.95), s7_N307_3, s7_N307_8));

s7_N307_1 :=  __common__( if(trim(C_POP_18_24_P) != '', s7_N307_2, s7_N307_9));

s7_N308_9 :=  __common__( if(((real)add2_avm_to_med_ratio < 1.00769), -0.025282667, 0.016455017));

s7_N308_8 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N308_9, -0.016841737));

s7_N308_7 :=  __common__( map(trim(C_HIGH_ED) = ''      => 0.083022177,
              ((real)c_high_ed < 14.25) => 0.012531689,
                                           0.083022177));

s7_N308_6 :=  __common__( if(((real)c_hval_40k_p < 4.5), 0.008492195, s7_N308_7));

s7_N308_5 :=  __common__( if(trim(C_HVAL_40K_P) != '', s7_N308_6, -0.026264524));

s7_N308_4 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 0.5), -0.0016436766, s7_N308_5));

s7_N308_3 :=  __common__( if(((real)add1_source_count < 1.5), 0.025692156, s7_N308_4));

s7_N308_2 :=  __common__( if(((integer)add3_eda_sourced < 0.5), -2.1439698e-005, s7_N308_3));

s7_N308_1 :=  __common__( if(((real)add_errorcode < 0.5), s7_N308_2, s7_N308_8));

s7_N309_8 :=  __common__( if(((real)add1_turnover_1yr_in < 227.5), 0.0053024273, -0.0010288274));

s7_N309_7 :=  __common__( map(trim(C_SFDU_P) = ''     => -0.0045161463,
              ((real)c_sfdu_p < 0.15) => -0.017852514,
                                         -0.0045161463));

s7_N309_6 :=  __common__( if(((real)_util_adl_count < 0.5), -0.0069493337, 0.040640946));

s7_N309_5 :=  __common__( if(((real)_rel_count < 0.5), s7_N309_6, s7_N309_7));

s7_N309_4 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.019415056,
              ((real)c_incollege < 69.5) => s7_N309_5,
                                            0.019415056));

s7_N309_3 :=  __common__( if(((real)c_easiqlife < 176.5), s7_N309_4, 0.042792511));

s7_N309_2 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N309_3, -0.00068381709));

s7_N309_1 :=  __common__( if(((real)_ssns_per_addr < 4.5), s7_N309_2, s7_N309_8));

s7_N310_8 :=  __common__( map(trim(C_HVAL_60K_P) = ''    => 0.060605096,
              ((real)c_hval_60k_p < 4.8) => 0.012422268,
                                            0.060605096));

s7_N310_7 :=  __common__( map(trim(C_LOW_ED) = ''     => 0.052283081,
              ((real)c_low_ed < 50.4) => s7_N310_8,
                                         0.052283081));

s7_N310_6 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0046926761, s7_N310_7));

s7_N310_5 :=  __common__( if((combo_dobscore < 95), 0.0098360716, -0.00015834911));

s7_N310_4 :=  __common__( if((add2_avm_automated_valuation < 265267), s7_N310_5, s7_N310_6));

s7_N310_3 :=  __common__( if(((real)c_assault < 73.5), s7_N310_4, -0.0017663075));

s7_N310_2 :=  __common__( if(trim(C_ASSAULT) != '', s7_N310_3, 0.00012353501));

s7_N310_1 :=  __common__( if(((real)add_errorcode < 0.5), s7_N310_2, -0.015521465));

s7_N311_9 :=  __common__( map(trim(C_MED_INC) = ''      => -0.00095420671,
              ((real)c_med_inc < 167.5) => 0.059483891,
                                           -0.00095420671));

s7_N311_8 :=  __common__( map(trim(C_SPAN_LANG) = ''     => -0.017060677,
              ((real)c_span_lang < 97.5) => 0.026334593,
                                            -0.017060677));

s7_N311_7 :=  __common__( map(trim(C_INCOLLEGE) = ''     => s7_N311_9,
              ((real)c_incollege < 4.85) => s7_N311_8,
                                            s7_N311_9));

s7_N311_6 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => s7_N311_7,
              (prof_license_category in ['0'])                     => 0.19374597,
                                                                      s7_N311_7));

s7_N311_5 :=  __common__( map(trim(C_FAMMAR_P) = ''      => s7_N311_6,
              ((real)c_fammar_p < 80.55) => 0.0012784047,
                                            s7_N311_6));

s7_N311_4 :=  __common__( map(trim(C_BLUE_COL) = ''     => s7_N311_5,
              ((real)c_blue_col < 6.35) => -0.0081063933,
                                           s7_N311_5));

s7_N311_3 :=  __common__( if(((real)combined_age < 78.5), 8.9305885e-005, s7_N311_4));

s7_N311_2 :=  __common__( if(((real)c_inc_25k_p < 20.15), s7_N311_3, -0.010155368));

s7_N311_1 :=  __common__( if(trim(C_INC_25K_P) != '', s7_N311_2, 0.002686734));

s7_N312_9 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.00040875858, 0.060475124));

s7_N312_8 :=  __common__( map(trim(C_HVAL_80K_P) = ''    => -0.02879539,
              ((real)c_hval_80k_p < 3.9) => -0.0051684834,
                                            -0.02879539));

s7_N312_7 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N312_8,
              ((real)c_rnt750_p < 11.35) => 0.0075984545,
                                            s7_N312_8));

s7_N312_6 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 278.5), s7_N312_7, -0.032363291));

s7_N312_5 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N312_6, -0.0075682901));

s7_N312_4 :=  __common__( map(trim(C_ASSAULT) = ''      => 0.025071317,
              ((integer)c_assault < 79) => -0.0077251969,
                                           0.025071317));

s7_N312_3 :=  __common__( if(((real)c_lowrent < 10.25), s7_N312_4, s7_N312_5));

s7_N312_2 :=  __common__( if(trim(C_LOWRENT) != '', s7_N312_3, -0.02616871));

s7_N312_1 :=  __common__( if(((real)_ssncount < 1.5), s7_N312_2, s7_N312_9));

s7_N313_8 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -7.6877117e-006,
              ((real)c_fammar_p < 82.65) => 0.057732005,
                                            -7.6877117e-006));

s7_N313_7 :=  __common__( map(trim(C_WHITE_COL) = ''     => 0.004104929,
              ((real)c_white_col < 54.5) => 0.055284138,
                                            0.004104929));

s7_N313_6 :=  __common__( if(((real)_inq_collection_count < 3.5), 0.0046986052, 0.038695801));

s7_N313_5 :=  __common__( if(((real)c_pop_25_34_p < 24.65), s7_N313_6, s7_N313_7));

s7_N313_4 :=  __common__( if(trim(C_POP_25_34_P) != '', s7_N313_5, -0.030538762));

s7_N313_3 :=  __common__( if(((real)add_bestmatch_level < 1.5), 0.00099513396, s7_N313_4));

s7_N313_2 :=  __common__( if(((real)_inq_perssn < 2.5), s7_N313_3, s7_N313_8));

s7_N313_1 :=  __common__( if(((real)_phones_per_addr_c6 < 0.5), -0.0010290172, s7_N313_2));

s7_N314_8 :=  __common__( if(((real)_adls_per_addr_cap10 < 9.5), 0.0041278092, 0.055751123));

s7_N314_7 :=  __common__( map(trim(C_LOW_HVAL) = ''     => -0.0089065204,
              ((real)c_low_hval < 87.6) => s7_N314_8,
                                           -0.0089065204));

s7_N314_6 :=  __common__( map(trim(C_LOW_HVAL) = ''      => 0.019473444,
              ((real)c_low_hval < 72.15) => -0.0004538907,
                                            0.019473444));

s7_N314_5 :=  __common__( map(trim(C_MED_HVAL) = ''        => s7_N314_6,
              ((real)c_med_hval < 44191.5) => -0.011749419,
                                              s7_N314_6));

s7_N314_4 :=  __common__( if(((real)c_hval_40k_p < 38.85), s7_N314_5, s7_N314_7));

s7_N314_3 :=  __common__( if(trim(C_HVAL_40K_P) != '', s7_N314_4, 0.00090367842));

s7_N314_2 :=  __common__( if(((real)add1_no_of_bedrooms2 > NULL), -0.021442881, 0.02222468));

s7_N314_1 :=  __common__( if(((real)input_dob_match_level < 0.5), s7_N314_2, s7_N314_3));

s7_N315_9 :=  __common__( map(trim(C_POP_18_24_P) = ''      => -0.005573265,
              ((real)c_pop_18_24_p < 12.05) => 0.0012457881,
                                               -0.005573265));

s7_N315_8 :=  __common__( if(((real)attr_num_nonderogs30 < 5.5), 0.04181121, -0.0025960061));

s7_N315_7 :=  __common__( map(trim(C_POP_25_34_P) = ''      => -0.028186478,
              ((real)c_pop_25_34_p < 14.35) => 0.0011955029,
                                               -0.028186478));

s7_N315_6 :=  __common__( if(((real)add2_source_count < 5.5), s7_N315_7, s7_N315_8));

s7_N315_5 :=  __common__( if(((real)_rel_count_addr < 0.5), 0.038465593, 0.0065265749));

s7_N315_4 :=  __common__( if(((real)age < 31.5), s7_N315_5, s7_N315_6));

s7_N315_3 :=  __common__( if(((real)add1_lres < 0.5), s7_N315_4, s7_N315_9));

s7_N315_2 :=  __common__( if(((real)c_hval_1001k_p < 23.35), s7_N315_3, -0.022528704));

s7_N315_1 :=  __common__( if(trim(C_HVAL_1001K_P) != '', s7_N315_2, -0.0022782746));

s7_N316_9 :=  __common__( map(trim(C_RECENT_MOV) = ''     => -0.014175354,
              ((real)c_recent_mov < 12.5) => 0.019528864,
                                             -0.014175354));

s7_N316_8 :=  __common__( map(trim(C_RECENT_MOV) = ''     => 0.0012167842,
              ((real)c_recent_mov < 86.5) => 0.053321348,
                                             0.0012167842));

s7_N316_7 :=  __common__( map(trim(C_BLUE_COL) = ''     => 0.042790437,
              ((real)c_blue_col < 18.9) => 0.007333596,
                                           0.042790437));

s7_N316_6 :=  __common__( map(trim(C_TOTSALES) = ''      => -0.0025134889,
              ((real)c_totsales < 860.5) => s7_N316_7,
                                            -0.0025134889));

s7_N316_5 :=  __common__( map(trim(C_BIGAPT_P) = ''      => s7_N316_8,
              ((real)c_bigapt_p < 66.05) => s7_N316_6,
                                            s7_N316_8));

s7_N316_4 :=  __common__( if(((real)age < 71.5), s7_N316_5, 0.028787322));

s7_N316_3 :=  __common__( map(trim(C_BORN_USA) = ''    => -0.00036593548,
              ((real)c_born_usa < 8.5) => s7_N316_4,
                                          -0.00036593548));

s7_N316_2 :=  __common__( if(((real)c_assault < 190.5), s7_N316_3, s7_N316_9));

s7_N316_1 :=  __common__( if(trim(C_ASSAULT) != '', s7_N316_2, -0.0074300489));

s7_N317_9 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => 0.01002016,
              (prof_license_category in ['0'])                     => 0.20360605,
                                                                      0.01002016));

s7_N317_8 :=  __common__( map(trim(C_BEL_EDU) = ''      => s7_N317_9,
              ((real)c_bel_edu < 193.5) => -0.013984792,
                                           s7_N317_9));

s7_N317_7 :=  __common__( map(trim(C_INC_35K_P) = ''      => s7_N317_8,
              ((real)c_inc_35k_p < 14.45) => -0.020995038,
                                             s7_N317_8));

s7_N317_6 :=  __common__( if(((integer)rc_watchlist_flag < 0.5), -0.0022914568, 0.027952064));

s7_N317_5 :=  __common__( map(trim(C_BEL_EDU) = ''      => s7_N317_7,
              ((real)c_bel_edu < 185.5) => s7_N317_6,
                                           s7_N317_7));

s7_N317_4 :=  __common__( map(trim(C_MED_HHINC) = ''         => s7_N317_5,
              ((integer)c_med_hhinc < 18647) => 0.018721271,
                                                s7_N317_5));

s7_N317_3 :=  __common__( map(trim(C_RAPE) = ''      => 0.031004164,
              ((real)c_rape < 198.5) => 0.0015854259,
                                        0.031004164));

s7_N317_2 :=  __common__( if(((real)c_hhsize < 2.775), s7_N317_3, s7_N317_4));

s7_N317_1 :=  __common__( if(trim(C_HHSIZE) != '', s7_N317_2, 0.00087395232));

s7_N318_8 :=  __common__( if(((real)_adls_per_addr_c6 < 0.5), 0.0079067618, 0.057796105));

s7_N318_7 :=  __common__( map(trim(C_HVAL_60K_P) = ''      => 0.037893595,
              ((integer)c_hval_60k_p < 23) => 0.0041056296,
                                              0.037893595));

s7_N318_6 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), s7_N318_7, s7_N318_8));

s7_N318_5 :=  __common__( map(trim(C_SPAN_LANG) = ''      => -0.014951895,
              ((real)c_span_lang < 161.5) => s7_N318_6,
                                             -0.014951895));

s7_N318_4 :=  __common__( if(((real)add2_lres < 48.5), 0.038310754, s7_N318_5));

s7_N318_3 :=  __common__( if(((real)c_hval_1001k_p < 4.15), s7_N318_4, 0.05701362));

s7_N318_2 :=  __common__( if(trim(C_HVAL_1001K_P) != '', s7_N318_3, -0.027103961));

s7_N318_1 :=  __common__( if(((real)add2_source_count < 7.5), -0.00038592796, s7_N318_2));

s7_N319_9 :=  __common__( if(((real)_ssns_per_addr < 2.5), 0.008930405, -0.026475991));

s7_N319_8 :=  __common__( map(trim(C_MED_HVAL) = ''          => -0.006000199,
              ((integer)c_med_hval < 137334) => 0.045095267,
                                                -0.006000199));

s7_N319_7 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => s7_N319_8,
              ((real)c_asian_lang < 182.5) => -0.011184268,
                                              s7_N319_8));

s7_N319_6 :=  __common__( if(((real)add1_lres < 6.5), 0.032633005, 0.0066127284));

s7_N319_5 :=  __common__( map(trim(C_HVAL_40K_P) = ''      => s7_N319_6,
              ((real)c_hval_40k_p < 24.15) => 0.00073472527,
                                              s7_N319_6));

s7_N319_4 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N319_7,
              ((real)c_rnt750_p < 67.25) => s7_N319_5,
                                            s7_N319_7));

s7_N319_3 :=  __common__( map(trim(C_HIGH_ED) = ''     => s7_N319_4,
              ((real)c_high_ed < 0.85) => 0.022583829,
                                          s7_N319_4));

s7_N319_2 :=  __common__( if(((real)c_low_hval < 88.45), s7_N319_3, s7_N319_9));

s7_N319_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N319_2, 0.00022281931));

s7_N320_9 :=  __common__( map(trim(C_INC_150K_P) = ''     => 0.026463412,
              ((real)c_inc_150k_p < 1.35) => -0.0079542688,
                                             0.026463412));

s7_N320_8 :=  __common__( if(((real)add2_lres < 108.5), 0.046340689, -0.0084563003));

s7_N320_7 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N320_8, s7_N320_9));

s7_N320_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N320_7, 0.08067667));

s7_N320_5 :=  __common__( if(((real)c_rnt250_p < 2.55), -0.0013310968, s7_N320_6));

s7_N320_4 :=  __common__( if(trim(C_RNT250_P) != '', s7_N320_5, 0.030891935));

s7_N320_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 2.5), -0.0012017759, s7_N320_4));

s7_N320_2 :=  __common__( map(trim(C_LARCENY) = ''      => 0.039448503,
              ((real)c_larceny < 118.5) => -0.00068266113,
                                           0.039448503));

s7_N320_1 :=  __common__( if(((real)source_count < 1.5), s7_N320_2, s7_N320_3));

s7_N321_8 :=  __common__( map(trim(C_ROBBERY) = ''       => 0.043119588,
              ((integer)c_robbery < 128) => 0.0012825974,
                                            0.043119588));

s7_N321_7 :=  __common__( if(((real)_rel_within100miles_count < 3.5), 0.0041049483, -0.022025143));

s7_N321_6 :=  __common__( map(trim(C_INCOLLEGE) = ''     => -0.029644153,
              ((real)c_incollege < 8.65) => -0.0071877008,
                                            -0.029644153));

s7_N321_5 :=  __common__( if(((real)c_easiqlife < 91.5), s7_N321_6, s7_N321_7));

s7_N321_4 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N321_5, -0.0034118552));

s7_N321_3 :=  __common__( if(((real)add1_nhood_vacant_properties < 283.5), s7_N321_4, -0.027714186));

s7_N321_2 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N321_3, -0.00093530587));

s7_N321_1 :=  __common__( if(((real)_phones_per_adl < 2.5), s7_N321_2, s7_N321_8));

s7_N322_9 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.03090845, 0.0017643939));

s7_N322_8 :=  __common__( if(((real)add1_avm_to_med_ratio < 2.75224), -0.00029344393, 0.03097594));

s7_N322_7 :=  __common__( map(trim(C_RAPE) = ''      => 0.0068554795,
              ((integer)c_rape < 63) => 0.031470909,
                                        0.0068554795));

s7_N322_6 :=  __common__( if(((integer)mth_ver_src_fsrc_fdate < 280), s7_N322_7, -0.0069088841));

s7_N322_5 :=  __common__( if((combo_dobscore < 80), s7_N322_6, s7_N322_8));

s7_N322_4 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N322_5, s7_N322_9));

s7_N322_3 :=  __common__( if(((real)c_apt20 < 192.5), -0.0093026076, 0.022535067));

s7_N322_2 :=  __common__( if(trim(C_APT20) != '', s7_N322_3, 0.017671909));

s7_N322_1 :=  __common__( if(((real)attr_num_nonderogs180 < 2.5), s7_N322_2, s7_N322_4));

s7_N323_8 :=  __common__( if(((integer)add1_avm_med < 57095), 0.015231379, -0.00094485865));

s7_N323_7 :=  __common__( map(trim(C_MED_HVAL) = ''          => 0.078879132,
              ((integer)c_med_hval < 143591) => 0.024649893,
                                                0.078879132));

s7_N323_6 :=  __common__( if((add1_lres < 38), 0.0012243312, s7_N323_7));

s7_N323_5 :=  __common__( if(((real)add2_source_count < 4.5), 0.005219318, s7_N323_6));

s7_N323_4 :=  __common__( if(((real)add2_lres < 34.5), s7_N323_5, s7_N323_8));

s7_N323_3 :=  __common__( if(((real)mth_header_first_seen < 498.5), s7_N323_4, -0.021824775));

s7_N323_2 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N323_3, -0.0020418506));

s7_N323_1 :=  __common__( if(((real)_ssns_per_addr < 5.5), -0.003086784, s7_N323_2));

s7_N324_9 :=  __common__( map(trim(C_LOWRENT) = ''      => 0.01486967,
              ((real)c_lowrent < 72.85) => -0.013250004,
                                           0.01486967));

s7_N324_8 :=  __common__( if(((real)c_lar_fam < 177.5), 0.00061090129, s7_N324_9));

s7_N324_7 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N324_8, -0.0030631568));

s7_N324_6 :=  __common__( if(((real)age < 44.5), -0.0051884759, 0.015032303));

s7_N324_5 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N324_6, -0.10984599));

s7_N324_4 :=  __common__( if(((real)mth_header_first_seen < 26.5), 0.028731648, s7_N324_5));

s7_N324_3 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N324_4, -0.028999681));

s7_N324_2 :=  __common__( if(((real)_addrs_last90 < 1.5), s7_N324_3, 0.03659888));

s7_N324_1 :=  __common__( if(((real)_wealth_index < 1.5), s7_N324_2, s7_N324_7));

s7_N325_9 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), 0.048029912, 0.0085443722));

s7_N325_8 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => s7_N325_9,
              ((real)c_asian_lang < 163.5) => -0.011472739,
                                              s7_N325_9));

s7_N325_7 :=  __common__( map(trim(C_NO_MOVE) = ''      => 0.03682387,
              ((real)c_no_move < 190.5) => -0.0063161269,
                                           0.03682387));

s7_N325_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N325_7, 0.071980685));

s7_N325_5 :=  __common__( if(((real)_ssncount < 1.5), -0.027196437, s7_N325_6));

s7_N325_4 :=  __common__( if(((real)ver_src_sl < 0.5), 0.00035694922, s7_N325_5));

s7_N325_3 :=  __common__( map(trim(C_HVAL_500K_P) = ''      => s7_N325_8,
              ((real)c_hval_500k_p < 33.75) => s7_N325_4,
                                               s7_N325_8));

s7_N325_2 :=  __common__( if(((integer)c_med_rent < 1864), s7_N325_3, -0.021187214));

s7_N325_1 :=  __common__( if(trim(C_MED_RENT) != '', s7_N325_2, -0.00075946201));

s7_N326_10 :=  __common__( if(((integer)add2_avm_med < 269957), 0.060414426, 0.0016400294));

s7_N326_9 :=  __common__( map(trim(C_FEMDIV_P) = ''    => 0.08535539,
              ((real)c_femdiv_p < 6.1) => s7_N326_10,
                                          0.08535539));

s7_N326_8 :=  __common__( map(trim(C_RETIRED2) = ''     => -0.027877754,
              ((real)c_retired2 < 94.5) => 0.030485659,
                                           -0.027877754));

s7_N326_7 :=  __common__( if(((real)_rel_count_addr < 2.5), s7_N326_8, s7_N326_9));

s7_N326_6 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => s7_N326_7,
              ((real)c_asian_lang < 146.5) => 0.0053647773,
                                              s7_N326_7));

s7_N326_5 :=  __common__( if(((real)_rel_incomeunder50_count < 4.5), 0.001382605, s7_N326_6));

s7_N326_4 :=  __common__( map(trim(C_MED_HVAL) = ''          => 0.052939281,
              ((integer)c_med_hval < 322869) => s7_N326_5,
                                                0.052939281));

s7_N326_3 :=  __common__( if(((real)c_rnt750_p < 50.25), -0.00036728514, s7_N326_4));

s7_N326_2 :=  __common__( if(trim(C_RNT750_P) != '', s7_N326_3, 0.0063796096));

s7_N326_1 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), -0.001501315, s7_N326_2));

s7_N327_8 :=  __common__( if(((real)gong_did_addr_ct < 0.5), -0.005345732, 0.040386919));

s7_N327_7 :=  __common__( if(((real)_inq_peraddr_cap8 < 7.5), -0.0022790299, s7_N327_8));

s7_N327_6 :=  __common__( if(((real)add2_source_count < 2.5), 0.046236817, 0.011232567));

s7_N327_5 :=  __common__( map(trim(C_RNT750_P) = ''     => -0.0022448709,
              ((real)c_rnt750_p < 42.3) => s7_N327_6,
                                           -0.0022448709));

s7_N327_4 :=  __common__( if(((real)combo_dobcount < 0.5), s7_N327_5, 0.0033733706));

s7_N327_3 :=  __common__( if(((real)c_hval_1000k_p < 7.35), s7_N327_4, -0.024923737));

s7_N327_2 :=  __common__( if(trim(C_HVAL_1000K_P) != '', s7_N327_3, 0.011816009));

s7_N327_1 :=  __common__( if(((real)_adls_per_addr_cap10 < 2.5), s7_N327_2, s7_N327_7));

s7_N328_9 :=  __common__( if(((integer)add1_avm_med < 225461), -0.014172974, 0.055342702));

s7_N328_8 :=  __common__( if(((real)add1_lres < 211.5), -0.0013443217, s7_N328_9));

s7_N328_7 :=  __common__( map(trim(C_ROBBERY) = ''    => s7_N328_8,
              ((real)c_robbery < 5.5) => 0.059069206,
                                         s7_N328_8));

s7_N328_6 :=  __common__( if(((real)_rel_count < 2.5), 0.055061183, s7_N328_7));

s7_N328_5 :=  __common__( if(((real)_ssncount < 1.5), -0.017936227, 0.0024638667));

s7_N328_4 :=  __common__( if(((real)input_dob_match_level < 2.5), s7_N328_5, 0.00058175983));

s7_N328_3 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N328_6,
              ((real)c_civ_emp < 78.75) => s7_N328_4,
                                           s7_N328_6));

s7_N328_2 :=  __common__( if(((real)c_inc_35k_p < 21.45), s7_N328_3, -0.023386649));

s7_N328_1 :=  __common__( if(trim(C_INC_35K_P) != '', s7_N328_2, 0.00066768563));

s7_N329_9 :=  __common__( if(((real)_addrs_last90 < 0.5), -0.029258825, 0.02358019));

s7_N329_8 :=  __common__( if(((real)_rel_educationunder12_count < 0.5), 0.012036117, -0.025542476));

s7_N329_7 :=  __common__( if(((real)_inq_count06 < 0.5), s7_N329_8, 0.038801803));

s7_N329_6 :=  __common__( map(trim(C_APT20) = ''      => 0.03452798,
              ((real)c_apt20 < 174.5) => s7_N329_7,
                                         0.03452798));

s7_N329_5 :=  __common__( map(trim(C_INC_150K_P) = ''     => -2.8457809e-005,
              ((real)c_inc_150k_p < 1.25) => -0.0048173968,
                                             -2.8457809e-005));

s7_N329_4 :=  __common__( map(trim(C_RNT2001_P) = ''      => 0.04734669,
              ((real)c_rnt2001_p < 28.15) => s7_N329_5,
                                             0.04734669));

s7_N329_3 :=  __common__( if(((real)add1_turnover_1yr_in < 2855.5), s7_N329_4, s7_N329_6));

s7_N329_2 :=  __common__( if(((real)c_rnt2001_p < 31.45), s7_N329_3, -0.020687789));

s7_N329_1 :=  __common__( if(trim(C_RNT2001_P) != '', s7_N329_2, s7_N329_9));

s7_N330_8 :=  __common__( if(((real)add1_turnover_1yr_in < 291.5), 0.061177791, 0.016000279));

s7_N330_7 :=  __common__( map(trim(C_MED_AGE) = ''     => s7_N330_8,
              ((real)c_med_age < 11.5) => -0.0029713222,
                                          s7_N330_8));

s7_N330_6 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => s7_N330_7,
              ((real)c_fammar18_p < 36.35) => -0.0029793209,
                                              s7_N330_7));

s7_N330_5 :=  __common__( if(((real)avg_lres < 3.5), -0.023969322, 0.00035769061));

s7_N330_4 :=  __common__( if(((real)c_bel_edu < 193.5), s7_N330_5, s7_N330_6));

s7_N330_3 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N330_4, -0.00067066018));

s7_N330_2 :=  __common__( if(((real)_email_domain_free_count < 0.5), s7_N330_3, -0.0055588178));

s7_N330_1 :=  __common__( if(((real)_adlperssn_count < 0.5), 0.015640238, s7_N330_2));

s7_N331_9 :=  __common__( map(trim(C_VACANT_P) = ''    => 0.064465922,
              ((real)c_vacant_p < 7.7) => -0.00099344544,
                                          0.064465922));

s7_N331_8 :=  __common__( map(trim(C_SFDU_P) = ''      => s7_N331_9,
              ((real)c_sfdu_p < 55.75) => -0.0099106885,
                                          s7_N331_9));

s7_N331_7 :=  __common__( map(trim(C_RETIRED2) = ''      => s7_N331_8,
              ((real)c_retired2 < 180.5) => 0.04975508,
                                            s7_N331_8));

s7_N331_6 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.061354819,
              ((real)c_span_lang < 101.5) => -0.0052120642,
                                             0.061354819));

s7_N331_5 :=  __common__( map(trim(C_AB_AV_EDU) = ''      => s7_N331_6,
              ((real)c_ab_av_edu < 115.5) => 0.092075079,
                                             s7_N331_6));

s7_N331_4 :=  __common__( if(((real)avg_lres < 78.5), s7_N331_5, s7_N331_7));

s7_N331_3 :=  __common__( if((add1_avm_automated_valuation < 127260), s7_N331_4, -0.0063520685));

s7_N331_2 :=  __common__( if(((real)c_retired < 26.95), 5.1366586e-005, s7_N331_3));

s7_N331_1 :=  __common__( if(trim(C_RETIRED) != '', s7_N331_2, 0.0036949269));

s7_N332_10 :=  __common__( if(((real)c_rnt250_p < 2.85), -0.0017857729, 0.0035884143));

s7_N332_9 :=  __common__( if(trim(C_RNT250_P) != '', s7_N332_10, 0.0077042081));

s7_N332_8 :=  __common__( map(trim(C_RECENT_MOV) = ''      => -0.041864762,
              ((real)c_recent_mov < 105.5) => -0.012288785,
                                              -0.041864762));

s7_N332_7 :=  __common__( if(((real)c_white_col < 40.9), s7_N332_8, -0.0032287754));

s7_N332_6 :=  __common__( if(trim(C_WHITE_COL) != '', s7_N332_7, -0.031357247));

s7_N332_5 :=  __common__( if(((real)_addrs_per_ssn < 2.5), 0.0091412287, -0.014109241));

s7_N332_4 :=  __common__( if(((real)c_bigapt_p < 22.25), s7_N332_5, 0.02047779));

s7_N332_3 :=  __common__( if(trim(C_BIGAPT_P) != '', s7_N332_4, -0.037939568));

s7_N332_2 :=  __common__( if(((real)add2_turnover_1yr_in < 290.5), s7_N332_3, s7_N332_6));

s7_N332_1 :=  __common__( if(((real)_ssncount < 1.5), s7_N332_2, s7_N332_9));

s7_N333_9 :=  __common__( map(trim(C_LOWRENT) = ''    => 0.0080803048,
              ((real)c_lowrent < 8.7) => 0.052175943,
                                         0.0080803048));

s7_N333_8 :=  __common__( map(trim(C_INC_25K_P) = ''      => 0.025836987,
              ((real)c_inc_25k_p < 15.55) => -0.0023633396,
                                             0.025836987));

s7_N333_7 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N333_9,
              ((integer)c_rnt750_p < 58) => s7_N333_8,
                                            s7_N333_9));

s7_N333_6 :=  __common__( if((add1_unit_count < 340), 0.00028350921, s7_N333_7));

s7_N333_5 :=  __common__( if(((real)combined_age < 23.5), 0.003343217, -0.021294565));

s7_N333_4 :=  __common__( if(((real)age < 16.5), s7_N333_5, s7_N333_6));

s7_N333_3 :=  __common__( if((add3_avm_automated_valuation < 1.50938e+006), s7_N333_4, 0.030768422));

s7_N333_2 :=  __common__( if(((real)c_low_hval < 88.05), s7_N333_3, -0.012773648));

s7_N333_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N333_2, -0.0090175698));

s7_N334_9 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.0061952255, 0.00067841386));

s7_N334_8 :=  __common__( map((prof_license_category in ['0', '1', '2']) => -0.025764898,
              (prof_license_category in ['3', '4', '5']) => 0.030580587,
                                                            -0.025764898));

s7_N334_7 :=  __common__( if(((real)add1_nhood_vacant_properties < 20.5), s7_N334_8, -0.0024595925));

s7_N334_6 :=  __common__( if(((real)add1_lres < 32.5), 0.014944083, -0.007223674));

s7_N334_5 :=  __common__( map((prof_license_category in ['3', '5'])           => s7_N334_6,
              (prof_license_category in ['0', '1', '2', '4']) => 0.053281587,
                                                                 s7_N334_6));

s7_N334_4 :=  __common__( if(((real)age < 43.5), s7_N334_5, s7_N334_7));

s7_N334_3 :=  __common__( if((combo_dobscore < 80), s7_N334_4, s7_N334_9));

s7_N334_2 :=  __common__( if(((real)c_inc_35k_p < 16.65), s7_N334_3, -0.0062409309));

s7_N334_1 :=  __common__( if(trim(C_INC_35K_P) != '', s7_N334_2, -0.0056372605));

s7_N335_7 :=  __common__( if(((real)bus_phone_match < 2.5), 0.0020258538, -0.0098190141));

s7_N335_6 :=  __common__( if(((real)age < 57.5), -0.0092768089, -0.024662804));

s7_N335_5 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N335_6, -0.0045746421));

s7_N335_4 :=  __common__( if(((real)_altlname < 0.5), 0.0015895604, 0.0480598));

s7_N335_3 :=  __common__( if(((integer)add2_avm_med < 60107), s7_N335_4, s7_N335_5));

s7_N335_2 :=  __common__( if(((real)input_dob_match_level < 0.5), 0.018935415, s7_N335_3));

s7_N335_1 :=  __common__( if(((integer)rc_fnamessnmatch < 0.5), s7_N335_2, s7_N335_7));

s7_N336_11 :=  __common__( map(trim(C_HVAL_60K_P) = ''     => 0.071453127,
               ((real)c_hval_60k_p < 6.95) => 0.0067971066,
                                              0.071453127));

s7_N336_10 :=  __common__( if(((real)_adlperssn_count < 2.5), 0.0038403142, s7_N336_11));

s7_N336_9 :=  __common__( if(((real)add1_building_area2 < 1416.5), s7_N336_10, -0.0044313998));

s7_N336_8 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N336_9, 3.5972117e-005));

s7_N336_7 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), 2.1091581e-005, s7_N336_8));

s7_N336_6 :=  __common__( if(((real)liens_historical_unreleased_ct < 1.5), s7_N336_7, -0.014122318));

s7_N336_5 :=  __common__( if(((real)_rel_within25miles_count < 3.5), -0.00073608432, 0.03497704));

s7_N336_4 :=  __common__( map(trim(C_CHILD) = ''     => s7_N336_6,
              ((real)c_child < 2.95) => s7_N336_5,
                                        s7_N336_6));

s7_N336_3 :=  __common__( if(((real)_addrs_last12 < 1.5), -0.0034845476, -0.026421114));

s7_N336_2 :=  __common__( if(((real)c_ownocc_p < 1.15), s7_N336_3, s7_N336_4));

s7_N336_1 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N336_2, 0.0031510124));

s7_N337_8 :=  __common__( map(trim(C_CHILD) = ''      => -0.0027888824,
              ((real)c_child < 15.95) => -0.021851413,
                                         -0.0027888824));

s7_N337_7 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N337_8, -0.00065797729));

s7_N337_6 :=  __common__( if((combo_dobscore < 80), 0.018288819, 0.0042452014));

s7_N337_5 :=  __common__( if(((real)c_retired < 5.85), s7_N337_6, s7_N337_7));

s7_N337_4 :=  __common__( if(trim(C_RETIRED) != '', s7_N337_5, -0.0074877072));

s7_N337_3 :=  __common__( if(((real)add1_unit_count < 8.5), -0.0069267194, 0.044917251));

s7_N337_2 :=  __common__( if(((real)_phone_score < 1.5), s7_N337_3, 0.079584));

s7_N337_1 :=  __common__( if(((real)add1_turnover_1yr_in < 0.5), s7_N337_2, s7_N337_4));

s7_N338_11 :=  __common__( if(((real)c_highinc < 5.75), 0.029882461, 0.00081227358));

s7_N338_10 :=  __common__( if(trim(C_HIGHINC) != '', s7_N338_11, 0.022995822));

s7_N338_9 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N338_10, 0.044217041));

s7_N338_8 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 316.5), -0.00063910921, s7_N338_9));

s7_N338_7 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N338_8, 0.03163508));

s7_N338_6 :=  __common__( if(((real)c_low_ed < 56.85), 0.0053482724, 0.030337483));

s7_N338_5 :=  __common__( if(trim(C_LOW_ED) != '', s7_N338_6, -0.026469497));

s7_N338_4 :=  __common__( if(((real)age < 57.5), s7_N338_5, 0.040781445));

s7_N338_3 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N338_4, 0.0055225026));

s7_N338_2 :=  __common__( if(((real)rc_dirsaddr_lastscore < 54.5), s7_N338_3, s7_N338_7));

s7_N338_1 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), 0.00018324159, s7_N338_2));

s7_N339_9 :=  __common__( if(((real)_rel_vehicle_owned_count < 1.5), 0.044059367, 0.012535175));

s7_N339_8 :=  __common__( map(trim(C_EASIQLIFE) = ''      => -0.020345667,
              ((real)c_easiqlife < 112.5) => 0.0081692463,
                                             -0.020345667));

s7_N339_7 :=  __common__( if(((real)c_femdiv_p < 4.05), s7_N339_8, s7_N339_9));

s7_N339_6 :=  __common__( if(trim(C_FEMDIV_P) != '', s7_N339_7, 0.007787661));

s7_N339_5 :=  __common__( map((prof_license_category in ['5'])                     => 0.035542547,
              (prof_license_category in ['0', '1', '2', '3', '4']) => 0.14505735,
                                                                      0.035542547));

s7_N339_4 :=  __common__( if(((integer)c_rnt500_p < 43), 0.0032524661, s7_N339_5));

s7_N339_3 :=  __common__( if(trim(C_RNT500_P) != '', s7_N339_4, -0.025675256));

s7_N339_2 :=  __common__( if(((real)_inq_perssn < 2.5), -0.00033436811, s7_N339_3));

s7_N339_1 :=  __common__( if(((real)_nap < 5.5), s7_N339_2, s7_N339_6));

s7_N340_9 :=  __common__( map(trim(C_BURGLARY) = ''      => -0.0022303826,
              ((real)c_burglary < 120.5) => 0.056683227,
                                            -0.0022303826));

s7_N340_8 :=  __common__( if(((real)add2_source_count < 9.5), 0.0028646823, 0.029202591));

s7_N340_7 :=  __common__( if(((real)_rel_felony_total < 3.5), s7_N340_8, s7_N340_9));

s7_N340_6 :=  __common__( if(((integer)c_med_hval < 25911), 0.037266965, s7_N340_7));

s7_N340_5 :=  __common__( if(trim(C_MED_HVAL) != '', s7_N340_6, -0.011344005));

s7_N340_4 :=  __common__( map(trim(C_OWNOCC_P) = ''     => -0.0018378645,
              ((real)c_ownocc_p < 0.15) => -0.022375088,
                                           -0.0018378645));

s7_N340_3 :=  __common__( if(((real)c_murders < 198.5), s7_N340_4, 0.030202481));

s7_N340_2 :=  __common__( if(trim(C_MURDERS) != '', s7_N340_3, 0.0066511688));

s7_N340_1 :=  __common__( if(((real)add1_lres < 110.5), s7_N340_2, s7_N340_5));

s7_N341_8 :=  __common__( if(((real)_addrs_per_ssn < 6.5), 0.067029122, 0.016312586));

s7_N341_7 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => 0.0010680267,
              (prof_license_category in ['2'])                     => 0.31054324,
                                                                      0.0010680267));

s7_N341_6 :=  __common__( if(((real)_ssns_per_addr < 5.5), s7_N341_7, s7_N341_8));

s7_N341_5 :=  __common__( map(trim(C_INC_50K_P) = ''      => -0.0064711261,
              ((real)c_inc_50k_p < 15.95) => s7_N341_6,
                                             -0.0064711261));

s7_N341_4 :=  __common__( map(trim(C_CIV_EMP) = ''     => s7_N341_5,
              ((real)c_civ_emp < 43.8) => 0.045094082,
                                          s7_N341_5));

s7_N341_3 :=  __common__( if(((real)c_rape < 86.5), s7_N341_4, -0.0030106435));

s7_N341_2 :=  __common__( if(trim(C_RAPE) != '', s7_N341_3, 0.0034243831));

s7_N341_1 :=  __common__( if(((real)_rel_within25miles_count < 0.5), s7_N341_2, -0.0004634106));

s7_N342_8 :=  __common__( if(((real)_infutor_nap < 2.5), -0.0013469703, 0.0033289517));

s7_N342_7 :=  __common__( map(trim(C_MED_HVAL) = ''          => 0.00056199811,
              ((integer)c_med_hval < 120508) => 0.041822433,
                                                0.00056199811));

s7_N342_6 :=  __common__( map(trim(C_SPAN_LANG) = ''      => s7_N342_7,
              ((real)c_span_lang < 161.5) => -0.0055259976,
                                             s7_N342_7));

s7_N342_5 :=  __common__( if(((integer)fname_eda_sourced < 0.5), -0.016264826, 0.017080514));

s7_N342_4 :=  __common__( if(((real)c_easiqlife < 116.5), s7_N342_5, s7_N342_6));

s7_N342_3 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N342_4, -0.033060448));

s7_N342_2 :=  __common__( if(((real)age < 63.5), s7_N342_3, -0.020579702));

s7_N342_1 :=  __common__( if(((real)attr_num_nonderogs180 < 2.5), s7_N342_2, s7_N342_8));

s7_N343_9 :=  __common__( map(trim(C_OWNOCC_P) = ''      => 0.023646993,
              ((real)c_ownocc_p < 71.55) => 0.082479979,
                                            0.023646993));

s7_N343_8 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => -0.0089082809,
              (prof_license_category in ['0'])                     => 0.19085477,
                                                                      -0.0089082809));

s7_N343_7 :=  __common__( if(((real)attr_num_nonderogs180 < 5.5), s7_N343_8, s7_N343_9));

s7_N343_6 :=  __common__( map(trim(C_SPAN_LANG) = ''     => 0.04842049,
              ((real)c_span_lang < 65.5) => -0.021533831,
                                            0.04842049));

s7_N343_5 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N343_6,
              ((real)c_civ_emp < 70.45) => -0.003544986,
                                           s7_N343_6));

s7_N343_4 :=  __common__( if(((real)_prop_owned_total < 4.5), s7_N343_5, 0.04207924));

s7_N343_3 :=  __common__( map(trim(C_UNATTACH) = ''     => s7_N343_7,
              ((real)c_unattach < 81.5) => s7_N343_4,
                                           s7_N343_7));

s7_N343_2 :=  __common__( if(((real)c_inc_201k_p < 19.75), -0.00024021332, s7_N343_3));

s7_N343_1 :=  __common__( if(trim(C_INC_201K_P) != '', s7_N343_2, 0.0050791146));

s7_N344_10 :=  __common__( map(trim(C_FEMDIV_P) = ''     => 0.049113156,
               ((real)c_femdiv_p < 3.35) => -0.012133819,
                                            0.049113156));

s7_N344_9 :=  __common__( if(((real)add2_source_count < 8.5), 0.0065929997, s7_N344_10));

s7_N344_8 :=  __common__( if(((real)add1_source_count < 4.5), s7_N344_9, 0.0012465977));

s7_N344_7 :=  __common__( if(((real)c_blue_col < 13.85), -0.00085876542, s7_N344_8));

s7_N344_6 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N344_7, 0.00049889161));

s7_N344_5 :=  __common__( if(((real)ssn_lowissue_age < -1.02683), 0.037213215, s7_N344_6));

s7_N344_4 :=  __common__( map((prof_license_category in ['2'])                     => -0.11306999,
              (prof_license_category in ['0', '1', '3', '4', '5']) => -0.016418666,
                                                                      -0.016418666));

s7_N344_3 :=  __common__( if(((real)rc_fnamecount < 1.5), s7_N344_4, s7_N344_5));

s7_N344_2 :=  __common__( if(((integer)_ssn_score < 0), 0.013368091, s7_N344_3));

s7_N344_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N344_2, 0.0046726319));

s7_N345_10 :=  __common__( if(((real)c_bel_edu < 187.5), -0.0067917689, -0.030743967));

s7_N345_9 :=  __common__( if(trim(C_BEL_EDU) != '', s7_N345_10, -0.026865065));

s7_N345_8 :=  __common__( if(((real)mth_header_first_seen > NULL), 0.0010496002, 0.29652601));

s7_N345_7 :=  __common__( map(trim(C_FEMDIV_P) = ''     => 0.042171717,
              ((real)c_femdiv_p < 4.75) => -0.0090867294,
                                           0.042171717));

s7_N345_6 :=  __common__( if(((real)mth_gong_did_first_seen < 94.5), s7_N345_7, 0.060389218));

s7_N345_5 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N345_6, s7_N345_8));

s7_N345_4 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.0084474339,
              ((real)c_span_lang < 194.5) => 0.00027340329,
                                             0.0084474339));

s7_N345_3 :=  __common__( if(((real)c_exp_homes < 196.5), s7_N345_4, s7_N345_5));

s7_N345_2 :=  __common__( if(trim(C_EXP_HOMES) != '', s7_N345_3, 0.0055159954));

s7_N345_1 :=  __common__( if(((real)bus_phone_match < 2.5), s7_N345_2, s7_N345_9));

s7_N346_10 :=  __common__( map(trim(C_UNEMPL) = ''      => 0.032837461,
               ((real)c_unempl < 177.5) => 0.0063983032,
                                           0.032837461));

s7_N346_9 :=  __common__( if(((real)c_sfdu_p < 3.85), s7_N346_10, -0.00083902978));

s7_N346_8 :=  __common__( if(trim(C_SFDU_P) != '', s7_N346_9, 0.013984321));

s7_N346_7 :=  __common__( if(((real)add1_building_area2 > NULL), -0.00044943035, s7_N346_8));

s7_N346_6 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.16951503, -0.001717244));

s7_N346_5 :=  __common__( if(((real)c_cartheft < 133.5), -0.011231513, 0.018518654));

s7_N346_4 :=  __common__( if(trim(C_CARTHEFT) != '', s7_N346_5, 0.037329677));

s7_N346_3 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N346_4, 0.036840313));

s7_N346_2 :=  __common__( if(((real)_add_risk < 0.5), s7_N346_3, s7_N346_6));

s7_N346_1 :=  __common__( if(((real)add1_lres < 0.5), s7_N346_2, s7_N346_7));

s7_N347_9 :=  __common__( map(trim(C_MED_INC) = ''      => 0.025746149,
              ((real)c_med_inc < 141.5) => -0.0011306539,
                                           0.025746149));

s7_N347_8 :=  __common__( map(trim(C_WHITE_COL) = ''      => s7_N347_9,
              ((real)c_white_col < 21.65) => 0.048798363,
                                             s7_N347_9));

s7_N347_7 :=  __common__( map(trim(C_RNT250_P) = ''    => s7_N347_8,
              ((real)c_rnt250_p < 0.1) => 0.00327764,
                                          s7_N347_8));

s7_N347_6 :=  __common__( if(((real)ver_src_p < 0.5), -0.006239719, s7_N347_7));

s7_N347_5 :=  __common__( map(trim(C_INC_150K_P) = ''     => s7_N347_6,
              ((real)c_inc_150k_p < 0.35) => -0.015114219,
                                             s7_N347_6));

s7_N347_4 :=  __common__( if((add2_avm_automated_valuation < 275900), 0.048685636, s7_N347_5));

s7_N347_3 :=  __common__( if((add2_avm_automated_valuation < 270542), -0.0015005717, s7_N347_4));

s7_N347_2 :=  __common__( if(((real)c_vacant_p < 25.45), s7_N347_3, -0.013301365));

s7_N347_1 :=  __common__( if(trim(C_VACANT_P) != '', s7_N347_2, -0.0086045156));

s7_N348_11 :=  __common__( if(((real)c_sfdu_p < 0.15), -0.011687733, 0.001068387));

s7_N348_10 :=  __common__( if(trim(C_SFDU_P) != '', s7_N348_11, 0.0056646942));

s7_N348_9 :=  __common__( map(trim(C_LOWINC) = ''      => 0.044660001,
              ((real)c_lowinc < 41.85) => -0.019231157,
                                          0.044660001));

s7_N348_8 :=  __common__( map(trim(C_INC_50K_P) = ''      => s7_N348_9,
              ((real)c_inc_50k_p < 16.95) => 0.073694013,
                                             s7_N348_9));

s7_N348_7 :=  __common__( if(((integer)add1_avm_med < 94559), s7_N348_8, 0.0019279097));

s7_N348_6 :=  __common__( map(trim(C_WHITE_COL) = ''     => -0.03011095,
              ((real)c_white_col < 52.5) => 0.031161313,
                                            -0.03011095));

s7_N348_5 :=  __common__( map(trim(C_INCOLLEGE) = ''     => s7_N348_6,
              ((real)c_incollege < 2.85) => 0.058604033,
                                            s7_N348_6));

s7_N348_4 :=  __common__( map(trim(C_UNEMPL) = ''     => -0.0058356172,
              ((real)c_unempl < 29.5) => s7_N348_5,
                                         -0.0058356172));

s7_N348_3 :=  __common__( if(((real)c_blue_col < 21.95), s7_N348_4, s7_N348_7));

s7_N348_2 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N348_3, 0.018299034));

s7_N348_1 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N348_2, s7_N348_10));

s7_N349_10 :=  __common__( if(((integer)add2_turnover_1yr_in < 772), 0.0089847286, 0.037535297));

s7_N349_9 :=  __common__( map(trim(C_BEL_EDU) = ''     => s7_N349_10,
              ((real)c_bel_edu < 39.5) => 0.038531275,
                                          s7_N349_10));

s7_N349_8 :=  __common__( map(trim(C_INC_15K_P) = ''     => s7_N349_9,
              ((real)c_inc_15k_p < 1.55) => -0.013354852,
                                            s7_N349_9));

s7_N349_7 :=  __common__( if(((real)combined_age < 26.5), 0.0009595101, s7_N349_8));

s7_N349_6 :=  __common__( map(trim(C_RNT500_P) = ''      => -0.015975222,
              ((real)c_rnt500_p < 63.45) => s7_N349_7,
                                            -0.015975222));

s7_N349_5 :=  __common__( if(((real)ssn_lowissue_age < 15.0507), s7_N349_6, -0.0014838095));

s7_N349_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N349_5, 0.007504143));

s7_N349_3 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N349_4, -0.00032493164));

s7_N349_2 :=  __common__( if(((real)c_sfdu_p < 0.15), -0.012329475, s7_N349_3));

s7_N349_1 :=  __common__( if(trim(C_SFDU_P) != '', s7_N349_2, 0.0050569411));

s7_N350_9 :=  __common__( if(((real)source_count < 3.5), 0.038264322, 0.0044311185));

s7_N350_8 :=  __common__( if(((real)ssn_lowissue_age < 15.1794), 0.040045261, -0.02273308));

s7_N350_7 :=  __common__( map((prof_license_category in ['2', '3', '4']) => s7_N350_8,
              (prof_license_category in ['0', '1', '5']) => 0.14905805,
                                                            s7_N350_8));

s7_N350_6 :=  __common__( if(((real)_addrs_5yr < 2.5), 0.10917256, s7_N350_7));

s7_N350_5 :=  __common__( if(((real)mth_gong_did_first_seen < 89.5), -0.0016097177, s7_N350_6));

s7_N350_4 :=  __common__( map(trim(C_LARCENY) = ''     => s7_N350_9,
              ((real)c_larceny < 18.5) => s7_N350_5,
                                          s7_N350_9));

s7_N350_3 :=  __common__( if(((real)_phones_per_adl < 0.5), 0.00042276843, s7_N350_4));

s7_N350_2 :=  __common__( if(((integer)c_med_hval < 198127), -0.00085925977, s7_N350_3));

s7_N350_1 :=  __common__( if(trim(C_MED_HVAL) != '', s7_N350_2, -0.0042367129));

s7_N351_9 :=  __common__( if(((real)rc_lnamecount < 8.5), 0.04400653, 0.1084241));

s7_N351_8 :=  __common__( map(trim(C_INC_50K_P) = ''      => 0.023289678,
              ((real)c_inc_50k_p < 12.25) => s7_N351_9,
                                             0.023289678));

s7_N351_7 :=  __common__( if(((real)add2_nhood_vacant_properties < 16.5), s7_N351_8, 0.012941384));

s7_N351_6 :=  __common__( if(((real)_car_current < 0.5), -0.0020759496, s7_N351_7));

s7_N351_5 :=  __common__( if(((real)_inq_collection_count < 0.5), 0.0031132453, s7_N351_6));

s7_N351_4 :=  __common__( if(((real)_addrs_10yr < 3.5), s7_N351_5, -0.00082061845));

s7_N351_3 :=  __common__( if(((real)combined_age < 89.5), s7_N351_4, -0.019244913));

s7_N351_2 :=  __common__( if(((real)c_larceny < 142.5), s7_N351_3, -0.0039513245));

s7_N351_1 :=  __common__( if(trim(C_LARCENY) != '', s7_N351_2, 0.00085212555));

s7_N352_10 :=  __common__( if((add2_lres < 174), 0.015058837, 0.061253898));

s7_N352_9 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 284.5), s7_N352_10, 0.00016840176));

s7_N352_8 :=  __common__( map(trim(C_RECENT_MOV) = ''     => -0.0023828836,
              ((real)c_recent_mov < 18.5) => 0.02276952,
                                             -0.0023828836));

s7_N352_7 :=  __common__( if(((real)_adls_per_phone_c6 < 0.5), -0.0060001874, 0.02655132));

s7_N352_6 :=  __common__( if(((real)add2_turnover_1yr_in < 416.5), s7_N352_7, 0.034771705));

s7_N352_5 :=  __common__( if(((real)add2_nhood_vacant_properties < 21.5), s7_N352_6, -0.011190655));

s7_N352_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N352_5, s7_N352_8));

s7_N352_3 :=  __common__( if(((real)add1_source_count < 7.5), s7_N352_4, s7_N352_9));

s7_N352_2 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N352_3, -0.00035850249));

s7_N352_1 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N352_2, -0.0060850782));

s7_N353_9 :=  __common__( map(trim(C_LOWINC) = ''      => 0.0058737181,
              ((real)c_lowinc < 42.45) => 0.059744029,
                                          0.0058737181));

s7_N353_8 :=  __common__( map(trim(C_INC_35K_P) = ''      => s7_N353_9,
              ((real)c_inc_35k_p < 10.35) => 0.00056217814,
                                             s7_N353_9));

s7_N353_7 :=  __common__( if(((real)_adls_per_addr_c6 < 0.5), 0.0017574594, -0.021116173));

s7_N353_6 :=  __common__( map(trim(C_RNT500_P) = ''      => 0.025487918,
              ((real)c_rnt500_p < 58.95) => s7_N353_7,
                                            0.025487918));

s7_N353_5 :=  __common__( map(trim(C_APT20) = ''      => s7_N353_8,
              ((real)c_apt20 < 106.5) => s7_N353_6,
                                         s7_N353_8));

s7_N353_4 :=  __common__( if(((real)add1_lres < 0.5), s7_N353_5, -0.00011504711));

s7_N353_3 :=  __common__( map(trim(C_LOW_ED) = ''     => s7_N353_4,
              ((real)c_low_ed < 4.35) => -0.026675639,
                                         s7_N353_4));

s7_N353_2 :=  __common__( if(((real)c_low_hval < 99.75), s7_N353_3, 0.020560476));

s7_N353_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N353_2, -0.0077977535));

s7_N354_8 :=  __common__( map(trim(C_MED_INC) = ''      => 0.068756516,
              ((real)c_med_inc < 184.5) => 0.00054827622,
                                           0.068756516));

s7_N354_7 :=  __common__( if(((real)add1_unit_count < 185.5), 0.0042194482, 0.025273237));

s7_N354_6 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N354_7, -0.00033687522));

s7_N354_5 :=  __common__( if(((real)c_white_col < 71.05), s7_N354_6, s7_N354_8));

s7_N354_4 :=  __common__( if(trim(C_WHITE_COL) != '', s7_N354_5, -0.0071304394));

s7_N354_3 :=  __common__( if(trim(C_HHSIZE) != '', -0.0036776252, 0.040742431));

s7_N354_2 :=  __common__( if(((real)_prop_owned_total < 0.5), s7_N354_3, s7_N354_4));

s7_N354_1 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N354_2, 0.023046118));

s7_N355_9 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 0.5), -0.0037727915, 0.032073515));

s7_N355_8 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.026802553,
              ((real)c_easiqlife < 144.5) => s7_N355_9,
                                             0.026802553));

s7_N355_7 :=  __common__( map(trim(C_ASIAN_LANG) = ''       => s7_N355_8,
              ((integer)c_asian_lang < 112) => -0.019205489,
                                               s7_N355_8));

s7_N355_6 :=  __common__( map((prof_license_category in ['0', '3', '4', '5']) => s7_N355_7,
              (prof_license_category in ['1', '2'])           => 0.087390788,
                                                                 s7_N355_7));

s7_N355_5 :=  __common__( map(trim(C_RECENT_MOV) = ''     => s7_N355_6,
              ((real)c_recent_mov < 44.5) => 0.032395383,
                                             s7_N355_6));

s7_N355_4 :=  __common__( if(((real)_infutor_nap < 2.5), -0.00029993383, 0.0067637944));

s7_N355_3 :=  __common__( if(((real)_prop_owned_total < 0.5), -0.0030976727, s7_N355_4));

s7_N355_2 :=  __common__( if(((real)c_bigapt_p < 61.55), s7_N355_3, s7_N355_5));

s7_N355_1 :=  __common__( if(trim(C_BIGAPT_P) != '', s7_N355_2, -0.00096505036));

s7_N356_8 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => 0.0024819909,
              ((integer)c_asian_lang < 81) => 0.0726745,
                                              0.0024819909));

s7_N356_7 :=  __common__( map((prof_license_category in ['0', '1', '2', '4', '5']) => s7_N356_8,
              (prof_license_category in ['3'])                     => 0.16533297,
                                                                      s7_N356_8));

s7_N356_6 :=  __common__( if(((real)_ssns_per_adl < 1.5), -0.0021619888, s7_N356_7));

s7_N356_5 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N356_6, 0.0066781335));

s7_N356_4 :=  __common__( if(((real)bus_name_match < 3.5), -0.00058591927, s7_N356_5));

s7_N356_3 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 0.5), -0.0062578695, 0.027531607));

s7_N356_2 :=  __common__( if(((real)_phone_score < 1.5), s7_N356_3, 0.050178033));

s7_N356_1 :=  __common__( if(((real)add1_turnover_1yr_in < 0.5), s7_N356_2, s7_N356_4));

s7_N357_12 :=  __common__( if(((real)c_fammar_p < 69.6), 0.029398469, 0.0032676719));

s7_N357_11 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N357_12, 0.0052229512));

s7_N357_10 :=  __common__( if(((real)_adls_per_addr_cap10 < 4.5), -0.0041971498, 0.0020021528));

s7_N357_9 :=  __common__( if(((real)add1_unit_count < 530.5), s7_N357_10, s7_N357_11));

s7_N357_8 :=  __common__( map(trim(C_BORN_USA) = ''       => 0.07074739,
              ((integer)c_born_usa < 144) => -0.00031664133,
                                             0.07074739));

s7_N357_7 :=  __common__( if(((real)c_no_move < 175.5), -0.0071389001, s7_N357_8));

s7_N357_6 :=  __common__( if(trim(C_NO_MOVE) != '', s7_N357_7, -0.02950725));

s7_N357_5 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.011970908, 0.052431155));

s7_N357_4 :=  __common__( if(((real)c_blue_col < 21.15), 0.0031002162, s7_N357_5));

s7_N357_3 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N357_4, -0.0040612053));

s7_N357_2 :=  __common__( if(((real)mth_attr_date_last_derog < 56.5), s7_N357_3, s7_N357_6));

s7_N357_1 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N357_2, s7_N357_9));

s7_N358_10 :=  __common__( map(trim(C_OWNOCC_P) = ''      => -0.014760968,
               ((real)c_ownocc_p < 71.65) => 0.045389741,
                                             -0.014760968));

s7_N358_9 :=  __common__( if(((real)rc_addrcount < 3.5), 0.037546505, s7_N358_10));

s7_N358_8 :=  __common__( if(((real)_nap < 3.5), 0.0039553692, s7_N358_9));

s7_N358_7 :=  __common__( map(trim(C_LOW_ED) = ''      => s7_N358_8,
              ((real)c_low_ed < 11.15) => 0.057751412,
                                          s7_N358_8));

s7_N358_6 :=  __common__( if(((real)_inq_peraddr_cap8 < 3.5), s7_N358_7, 0.048034597));

s7_N358_5 :=  __common__( if(((real)age < 45.5), 0.0014367355, s7_N358_6));

s7_N358_4 :=  __common__( if(((real)_infutor_nap < 2.5), -0.00041733115, s7_N358_5));

s7_N358_3 :=  __common__( if(((real)c_ownocc_p < 40.75), -0.0073219769, s7_N358_4));

s7_N358_2 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N358_3, 0.0094444255));

s7_N358_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N358_2, -0.00014763878));

s7_N359_9 :=  __common__( if(((real)avg_lres < 23.5), 0.041579059, 0.0048272512));

s7_N359_8 :=  __common__( map(trim(C_RENTAL) = ''      => -0.02154191,
              ((real)c_rental < 137.5) => s7_N359_9,
                                          -0.02154191));

s7_N359_7 :=  __common__( if(((real)add3_lres < 107.5), s7_N359_8, 0.036707454));

s7_N359_6 :=  __common__( if(((real)c_child < 20.55), 0.041806357, s7_N359_7));

s7_N359_5 :=  __common__( if(trim(C_CHILD) != '', s7_N359_6, 0.013200516));

s7_N359_4 :=  __common__( if(((real)combo_dobcount < 3.5), s7_N359_5, 0.0010926893));

s7_N359_3 :=  __common__( if(((real)c_inc_15k_p < 53.35), -0.00088679202, 0.020822194));

s7_N359_2 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N359_3, 0.00051187821));

s7_N359_1 :=  __common__( if(((real)_altlname < 0.5), s7_N359_2, s7_N359_4));

s7_N360_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.023652746, -0.070087925));

s7_N360_7 :=  __common__( map(trim(C_HVAL_60K_P) = ''      => s7_N360_8,
              ((real)c_hval_60k_p < 22.05) => -0.0076748803,
                                              s7_N360_8));

s7_N360_6 :=  __common__( map(trim(C_NO_MOVE) = ''      => 0.022756645,
              ((real)c_no_move < 117.5) => s7_N360_7,
                                           0.022756645));

s7_N360_5 :=  __common__( if(((real)_rel_homeover500_count < 0.5), s7_N360_6, 0.025778598));

s7_N360_4 :=  __common__( if(((real)c_med_age < 18.5), s7_N360_5, -0.00053680636));

s7_N360_3 :=  __common__( if(trim(C_MED_AGE) != '', s7_N360_4, 0.0056859348));

s7_N360_2 :=  __common__( map(trim(C_AB_AV_EDU) = ''      => -0.00077212308,
              ((real)c_ab_av_edu < 113.5) => -0.022258352,
                                             -0.00077212308));

s7_N360_1 :=  __common__( if((combo_dobscore < 45), s7_N360_2, s7_N360_3));

s7_N361_8 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((integer)mth_ver_src_fsrc_fdate < 118), 0.045867354, 0.0027610608));

s7_N361_7 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.0084079901,
              ((real)c_fammar_p < 66.75) => s7_N361_8,
                                            -0.0084079901));

s7_N361_6 :=  __common__( map(trim(C_RAPE) = ''     => 0.029234947,
              ((real)c_rape < 72.5) => 0.067117414,
                                       0.029234947));

s7_N361_5 :=  __common__( map(trim(C_BIGAPT_P) = ''     => s7_N361_6,
              ((real)c_bigapt_p < 2.05) => 0.01920383,
                                           s7_N361_6));

s7_N361_4 :=  __common__( if(((real)c_pop_25_34_p < 14.45), s7_N361_5, s7_N361_7));

s7_N361_3 :=  __common__( if(trim(C_POP_25_34_P) != '', s7_N361_4, -0.032882586));

s7_N361_2 :=  __common__( if(((real)_inq_count < 0.5), s7_N361_3, 0.0015335206));

s7_N361_1 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), 0.00051473722, s7_N361_2));

s7_N362_12 :=  __common__( if(((real)c_vacant_p < 4.95), -0.0040371144, 0.037613716));

s7_N362_11 :=  __common__( if(trim(C_VACANT_P) != '', s7_N362_12, 0.029661661));

s7_N362_10 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 4.5), -0.0039060287, 0.024694922));

s7_N362_9 :=  __common__( if(((real)combo_dobscore < 177.5), s7_N362_10, s7_N362_11));

s7_N362_8 :=  __common__( if(((real)_adls_per_phone < 0.5), 0.060415575, -0.0016020329));

s7_N362_7 :=  __common__( if(((integer)c_easiqlife < 97), 0.0028560159, s7_N362_8));

s7_N362_6 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N362_7, 0.045050651));

s7_N362_5 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), 0.0027057992, s7_N362_6));

s7_N362_4 :=  __common__( if(((real)add2_lres < 5.5), s7_N362_5, s7_N362_9));

s7_N362_3 :=  __common__( if(((real)c_sfdu_p < 7.15), -0.01192602, 0.00059903296));

s7_N362_2 :=  __common__( if(trim(C_SFDU_P) != '', s7_N362_3, -0.016414767));

s7_N362_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N362_2, s7_N362_4));

s7_N363_9 :=  __common__( if((add2_avm_automated_valuation < 234754), -0.0029017906, 0.031391358));

s7_N363_8 :=  __common__( if(trim(C_HHSIZE) != '', s7_N363_9, 0.38505784));

s7_N363_7 :=  __common__( if(((real)_addrs_15yr < 7.5), 0.06122439, 0.0017569759));

s7_N363_6 :=  __common__( if(((real)_ssns_per_addr < 9.5), 0.0026198507, s7_N363_7));

s7_N363_5 :=  __common__( if(((real)c_highrent < 2.45), s7_N363_6, -0.013100194));

s7_N363_4 :=  __common__( if(trim(C_HIGHRENT) != '', s7_N363_5, -0.02616754));

s7_N363_3 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N363_4, s7_N363_8));

s7_N363_2 :=  __common__( if((add1_unit_count < 244), s7_N363_3, 0.037695466));

s7_N363_1 :=  __common__( if(((real)_phones_per_adl < 1.5), -0.00076474972, s7_N363_2));

s7_N364_11 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.075934929,
               ((real)c_civ_emp < 64.25) => 0.018712366,
                                            0.075934929));

s7_N364_10 :=  __common__( if(((real)c_blue_col < 12.05), s7_N364_11, -0.010028432));

s7_N364_9 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N364_10, -0.028096845));

s7_N364_8 :=  __common__( map(trim(C_RECENT_MOV) = ''      => 0.072393726,
              ((real)c_recent_mov < 134.5) => -0.0045503582,
                                              0.072393726));

s7_N364_7 :=  __common__( map(trim(C_VACANT_P) = ''     => -0.0084045221,
              ((real)c_vacant_p < 6.55) => 0.041300587,
                                           -0.0084045221));

s7_N364_6 :=  __common__( map(trim(C_SPAN_LANG) = ''      => -0.024643731,
              ((real)c_span_lang < 197.5) => -0.00094349808,
                                             -0.024643731));

s7_N364_5 :=  __common__( map(trim(C_UNEMPL) = ''      => s7_N364_7,
              ((real)c_unempl < 183.5) => s7_N364_6,
                                          s7_N364_7));

s7_N364_4 :=  __common__( if(((real)c_inc_50k_p < 24.55), s7_N364_5, s7_N364_8));

s7_N364_3 :=  __common__( if(trim(C_INC_50K_P) != '', s7_N364_4, 0.026497228));

s7_N364_2 :=  __common__( if(((real)add2_no_of_bedrooms2 < 5.5), s7_N364_3, s7_N364_9));

s7_N364_1 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s7_N364_2, -0.00043327165));

s7_N365_9 :=  __common__( if(((real)ssn_lowissue_age < 16.2486), 0.0078822789, 0.066285393));

s7_N365_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N365_9, 0.030564476));

s7_N365_7 :=  __common__( map(trim(C_RECENT_MOV) = ''      => s7_N365_8,
              ((real)c_recent_mov < 133.5) => -0.0099563523,
                                              s7_N365_8));

s7_N365_6 :=  __common__( map(trim(C_HVAL_1000K_P) = ''    => 0.063766904,
              ((real)c_hval_1000k_p < 0.7) => 0.013466965,
                                              0.063766904));

s7_N365_5 :=  __common__( if(((real)c_born_usa < 61.5), s7_N365_6, s7_N365_7));

s7_N365_4 :=  __common__( if(trim(C_BORN_USA) != '', s7_N365_5, -0.026178042));

s7_N365_3 :=  __common__( if(((real)add1_unit_count < 0.5), 0.021287016, -1.5297957e-005));

s7_N365_2 :=  __common__( if(((integer)add3_eda_sourced < 0.5), s7_N365_3, s7_N365_4));

s7_N365_1 :=  __common__( if(((real)_util_adl_nap < 2.5), -0.0078951147, s7_N365_2));

s7_N366_9 :=  __common__( if(((real)c_low_ed < 5.55), 0.033767882, -0.0027051165));

s7_N366_8 :=  __common__( if(trim(C_LOW_ED) != '', s7_N366_9, 0.002549989));

s7_N366_7 :=  __common__( if((add1_avm_automated_valuation < 364650), 0.01873518, 0.06521523));

s7_N366_6 :=  __common__( if(ssn_lowissue_age != null and ((real)ssn_lowissue_age < 17.0578), 0.011146462, s7_N366_7));

s7_N366_5 :=  __common__( if(trim(C_POP_18_24_P) != '', s7_N366_6, 0.093277639));

s7_N366_4 :=  __common__( if(((real)add1_mortgage_risky < 0.5), 0.00084761212, 0.056929649));

s7_N366_3 :=  __common__( if(((real)_addrs_per_adl < 7.5), s7_N366_4, s7_N366_5));

s7_N366_2 :=  __common__( if(((real)add1_lres < 136.5), 0.00019878026, s7_N366_3));

s7_N366_1 :=  __common__( if(((real)_lnames_per_adl < 2.5), s7_N366_2, s7_N366_8));

s7_N367_9 :=  __common__( if(((real)avg_lres < 157.5), -0.020398269, 0.031145552));

s7_N367_8 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => 0.015833729,
              (prof_license_category in ['0'])                     => 0.10048258,
                                                                      0.015833729));

s7_N367_7 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.048278798,
              ((real)c_bel_edu < 104.5) => s7_N367_8,
                                           0.048278798));

s7_N367_6 :=  __common__( map(trim(C_BLUE_COL) = ''     => s7_N367_9,
              ((real)c_blue_col < 17.3) => s7_N367_7,
                                           s7_N367_9));

s7_N367_5 :=  __common__( map(trim(C_RENTOCC_P) = ''      => 0.0024192967,
              ((real)c_rentocc_p < 26.75) => -0.023162022,
                                             0.0024192967));

s7_N367_4 :=  __common__( if((combo_dobscore < 45), s7_N367_5, -2.2087868e-005));

s7_N367_3 :=  __common__( map(trim(C_INC_50K_P) = ''      => s7_N367_6,
              ((real)c_inc_50k_p < 24.25) => s7_N367_4,
                                             s7_N367_6));

s7_N367_2 :=  __common__( if(((real)c_span_lang < 197.5), s7_N367_3, -0.013722137));

s7_N367_1 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N367_2, -0.0034074391));

s7_N368_10 :=  __common__( if(((real)_util_adl_count < 3.5), 0.027457973, 0.067888026));

s7_N368_9 :=  __common__( map(trim(C_LOW_HVAL) = ''      => 0.0026436174,
              ((real)c_low_hval < 19.25) => s7_N368_10,
                                            0.0026436174));

s7_N368_8 :=  __common__( map(trim(C_INC_150K_P) = ''    => -0.0095076662,
              ((real)c_inc_150k_p < 7.2) => s7_N368_9,
                                            -0.0095076662));

s7_N368_7 :=  __common__( map(trim(C_LOWRENT) = ''      => -0.0037649378,
              ((real)c_lowrent < 18.65) => s7_N368_8,
                                           -0.0037649378));

s7_N368_6 :=  __common__( map(trim(C_RNT500_P) = ''      => 0.013100673,
              ((real)c_rnt500_p < 46.45) => s7_N368_7,
                                            0.013100673));

s7_N368_5 :=  __common__( if(((real)mth_header_first_seen < 16.5), 0.041539836, s7_N368_6));

s7_N368_4 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N368_5, 0.014474652));

s7_N368_3 :=  __common__( map(trim(C_EASIQLIFE) = ''     => s7_N368_4,
              ((real)c_easiqlife < 81.5) => -0.0044723767,
                                            s7_N368_4));

s7_N368_2 :=  __common__( if(((real)c_hval_40k_p < 2.75), -0.0011707394, s7_N368_3));

s7_N368_1 :=  __common__( if(trim(C_HVAL_40K_P) != '', s7_N368_2, -0.0016684231));

s7_N369_9 :=  __common__( map(trim(C_HVAL_500K_P) = ''     => -0.0039273813,
              ((real)c_hval_500k_p < 5.85) => 0.051472076,
                                              -0.0039273813));

s7_N369_8 :=  __common__( map(trim(C_FEMDIV_P) = ''     => s7_N369_9,
              ((real)c_femdiv_p < 4.65) => -0.0082820468,
                                           s7_N369_9));

s7_N369_7 :=  __common__( if(((real)_rel_count_addr < 1.5), 0.077141931, 0.0046063409));

s7_N369_6 :=  __common__( map(trim(C_TOTSALES) = ''        => s7_N369_8,
              ((integer)c_totsales < 2793) => s7_N369_7,
                                              s7_N369_8));

s7_N369_5 :=  __common__( map(trim(C_INC_50K_P) = ''     => 0.00046322685,
              ((real)c_inc_50k_p < 2.05) => -0.019340468,
                                            0.00046322685));

s7_N369_4 :=  __common__( map(trim(C_HIGH_ED) = ''      => s7_N369_6,
              ((real)c_high_ed < 64.55) => s7_N369_5,
                                           s7_N369_6));

s7_N369_3 :=  __common__( if(((real)add2_lres < 357.5), s7_N369_4, -0.011723769));

s7_N369_2 :=  __common__( if(((real)c_high_ed < 72.95), s7_N369_3, -0.016139071));

s7_N369_1 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N369_2, -0.011778466));

s7_N370_11 :=  __common__( if(((real)c_mort_indx < 12.5), 0.029821362, -0.0033000137));

s7_N370_10 :=  __common__( if(trim(C_MORT_INDX) != '', s7_N370_11, -0.0069369511));

s7_N370_9 :=  __common__( if(((integer)_ams_income_level < 0), 0.064030768, 0.007981509));

s7_N370_8 :=  __common__( if(((real)c_retired2 < 120.5), 0.0042978023, s7_N370_9));

s7_N370_7 :=  __common__( if(trim(C_RETIRED2) != '', s7_N370_8, 0.010829194));

s7_N370_6 :=  __common__( if(((real)ssn_lowissue_age < 2.35761), s7_N370_7, s7_N370_10));

s7_N370_5 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N370_6, 0.0033208054));

s7_N370_4 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N370_5, 0.080443427));

s7_N370_3 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N370_4, -0.00021580028));

s7_N370_2 :=  __common__( if((add1_avm_med < 1.96527e+006), s7_N370_3, 0.028497529));

s7_N370_1 :=  __common__( if((add2_avm_med < 1.27867e+006), s7_N370_2, -0.01817252));

s7_N371_11 :=  __common__( map(trim(C_LAR_FAM) = ''      => 0.027011218,
               ((real)c_lar_fam < 152.5) => -0.0050737853,
                                            0.027011218));

s7_N371_10 :=  __common__( if(((integer)add1_building_area2 < 1102), 0.036568483, -0.0010735566));

s7_N371_9 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N371_10, s7_N371_11));

s7_N371_8 :=  __common__( map(trim(C_HIGHRENT) = ''     => 0.06794559,
              ((real)c_highrent < 15.5) => s7_N371_9,
                                           0.06794559));

s7_N371_7 :=  __common__( if(((real)_ssns_per_adl < 2.5), 0.0037012487, 0.045686654));

s7_N371_6 :=  __common__( if(((real)mth_attr_date_last_derog < 161.5), -0.0043433496, 0.044388423));

s7_N371_5 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N371_6, s7_N371_7));

s7_N371_4 :=  __common__( map(trim(C_MED_INC) = ''     => s7_N371_5,
              ((real)c_med_inc < 26.5) => 0.030645271,
                                          s7_N371_5));

s7_N371_3 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N371_4,
              ((real)c_rnt750_p < 55.85) => -0.0014840894,
                                            s7_N371_4));

s7_N371_2 :=  __common__( if(((real)c_unempl < 176.5), s7_N371_3, s7_N371_8));

s7_N371_1 :=  __common__( if(trim(C_UNEMPL) != '', s7_N371_2, -0.0025395332));

s7_N372_9 :=  __common__( map(trim(C_RNT750_P) = ''      => 0.023087935,
              ((real)c_rnt750_p < 34.05) => -0.0032916975,
                                            0.023087935));

s7_N372_8 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.0268717, s7_N372_9));

s7_N372_7 :=  __common__( map(trim(C_BIGAPT_P) = ''     => 0.038519224,
              ((real)c_bigapt_p < 19.6) => s7_N372_8,
                                           0.038519224));

s7_N372_6 :=  __common__( map(trim(C_LAR_FAM) = ''     => s7_N372_7,
              ((real)c_lar_fam < 75.5) => -0.0080185773,
                                          s7_N372_7));

s7_N372_5 :=  __common__( if(((real)_add_risk < 0.5), -0.00031327476, s7_N372_6));

s7_N372_4 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.063516801, -0.014807953));

s7_N372_3 :=  __common__( if(((real)add1_source_count < 8.5), s7_N372_4, 0.027708994));

s7_N372_2 :=  __common__( if(((real)c_hhsize < 1.605), s7_N372_3, s7_N372_5));

s7_N372_1 :=  __common__( if(trim(C_HHSIZE) != '', s7_N372_2, 0.0030015142));

s7_N373_8 :=  __common__( if(((real)add2_nhood_vacant_properties < 14.5), 0.086732568, 0.021334731));

s7_N373_7 :=  __common__( map(trim(C_ROBBERY) = ''      => 0.00041673351,
              ((integer)c_robbery < 31) => s7_N373_8,
                                           0.00041673351));

s7_N373_6 :=  __common__( if((add1_avm_automated_valuation < 371951), -0.0019499935, s7_N373_7));

s7_N373_5 :=  __common__( if(((real)add1_building_area2 < 906.5), 0.054491423, s7_N373_6));

s7_N373_4 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N373_5, 0.00078845317));

s7_N373_3 :=  __common__( if((add1_avm_automated_valuation < 157724), -0.0031614111, 0.056519769));

s7_N373_2 :=  __common__( if(((real)combo_dobcount < 3.5), s7_N373_3, s7_N373_4));

s7_N373_1 :=  __common__( if(((real)add1_source_count < 9.5), -0.0017908594, s7_N373_2));

s7_N374_8 :=  __common__( if(ssn_lowissue_age != null and ((real)ssn_lowissue_age < 24.8891), 0.0074444426, 0.054780025));
s7_N374_7 :=  __common__( if(((real)c_inc_150k_p < 1.05), 0.048391851, s7_N374_8));
s7_N374_6 :=  __common__( if(trim(C_INC_150K_P) != '', s7_N374_7, 0.10301792));
s7_N374_5 :=  __common__( if(((real)add3_lres < 133.5), -0.023270764, 0.024245762));
s7_N374_4 :=  __common__( if(((real)add1_lres < 20.5), s7_N374_5, s7_N374_6));
s7_N374_3 :=  __common__( if(((real)add1_nhood_vacant_properties < 222.5), s7_N374_4, 0.045328053));
s7_N374_2 :=  __common__( if(((real)_inq_perssn < 1.5), 0.00096281515, s7_N374_3));
s7_N374_1 :=  __common__( if(((real)_inq_perphone < 0.5), s7_N374_2, -0.0047412957));

s7_N375_10 :=  __common__( map(trim(C_FOR_SALE) = ''     => -0.01615313,
               ((real)c_for_sale < 91.5) => 0.0026841786,
                                            -0.01615313));

s7_N375_9 :=  __common__( if(((real)c_assault < 177.5), s7_N375_10, 0.01733878));

s7_N375_8 :=  __common__( if(trim(C_ASSAULT) != '', s7_N375_9, -0.0044726927));

s7_N375_7 :=  __common__( if(((real)combined_age < 36.5), 0.0021684576, 0.033910809));

s7_N375_6 :=  __common__( map(trim(C_RELIG_INDX) = ''      => -0.012870658,
              ((real)c_relig_indx < 152.5) => s7_N375_7,
                                              -0.012870658));

s7_N375_5 :=  __common__( if(((real)_rel_incomeunder50_count < 3.5), -0.011065773, s7_N375_6));

s7_N375_4 :=  __common__( if(((integer)c_sfdu_p < 46), -0.021396873, s7_N375_5));

s7_N375_3 :=  __common__( if(trim(C_SFDU_P) != '', s7_N375_4, -0.027263761));

s7_N375_2 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N375_3, s7_N375_8));

s7_N375_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N375_2, -5.3794724e-005));

s7_N376_9 :=  __common__( map(trim(C_FOR_SALE) = ''     => -0.025423452,
              ((real)c_for_sale < 95.5) => 0.0089171505,
                                           -0.025423452));

s7_N376_8 :=  __common__( if(((real)_util_adl_count < 1.5), s7_N376_9, 0.018680819));

s7_N376_7 :=  __common__( if(((real)add1_unit_count < 2.5), s7_N376_8, 0.029005526));

s7_N376_6 :=  __common__( map(trim(C_RETIRED2) = ''      => 0.034598775,
              ((real)c_retired2 < 185.5) => -0.0099269593,
                                            0.034598775));

s7_N376_5 :=  __common__( if(((real)avg_lres < 62.5), s7_N376_6, 0.0005822776));

s7_N376_4 :=  __common__( if(((real)c_rental < 171.5), s7_N376_5, 0.0077946481));

s7_N376_3 :=  __common__( if(trim(C_RENTAL) != '', s7_N376_4, -0.0034441851));

s7_N376_2 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), -0.0005291059, s7_N376_3));

s7_N376_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N376_2, s7_N376_7));

s7_N377_9 :=  __common__( map(trim(C_RENTOCC_P) = ''      => -0.016055179,
              ((real)c_rentocc_p < 88.35) => 0.00090295537,
                                             -0.016055179));

s7_N377_8 :=  __common__( map(trim(C_MED_AGE) = ''      => 0.012218621,
              ((integer)c_med_age < 75) => 0.04631431,
                                           0.012218621));

s7_N377_7 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N377_8, -0.097397469));

s7_N377_6 :=  __common__( map(trim(C_CIV_EMP) = ''      => -0.011598994,
              ((real)c_civ_emp < 60.15) => s7_N377_7,
                                           -0.011598994));

s7_N377_5 :=  __common__( map(trim(C_MED_HVAL) = ''         => s7_N377_9,
              ((integer)c_med_hval < 24589) => s7_N377_6,
                                               s7_N377_9));

s7_N377_4 :=  __common__( map(trim(C_MED_HHINC) = ''        => s7_N377_5,
              ((real)c_med_hhinc < 19410.5) => -0.012997348,
                                               s7_N377_5));

s7_N377_3 :=  __common__( map(trim(C_INC_25K_P) = ''      => 0.022653247,
              ((real)c_inc_25k_p < 20.85) => -0.0059576925,
                                             0.022653247));

s7_N377_2 :=  __common__( if(((real)c_femdiv_p < 2.15), s7_N377_3, s7_N377_4));

s7_N377_1 :=  __common__( if(trim(C_FEMDIV_P) != '', s7_N377_2, 0.0012948307));

s7_N378_8 :=  __common__( if(((real)source_count < 2.5), 0.011704216, -5.3590235e-005));

s7_N378_7 :=  __common__( map(trim(C_UNATTACH) = ''     => 0.0064343377,
              ((real)c_unattach < 75.5) => -0.025605134,
                                           0.0064343377));

s7_N378_6 :=  __common__( if(((real)_rel_vehicle_owned_count < 2.5), s7_N378_7, 0.020406226));

s7_N378_5 :=  __common__( if(((real)_rel_count_addr < 1.5), -0.0073107069, -0.031436504));

s7_N378_4 :=  __common__( map(trim(C_MED_HHINC) = ''        => s7_N378_5,
              ((real)c_med_hhinc < 33463.5) => 0.003816656,
                                               s7_N378_5));

s7_N378_3 :=  __common__( if(((real)c_sfdu_p < 73.95), s7_N378_4, s7_N378_6));

s7_N378_2 :=  __common__( if(trim(C_SFDU_P) != '', s7_N378_3, -0.027522111));

s7_N378_1 :=  __common__( if(((real)input_dob_match_level < 1.5), s7_N378_2, s7_N378_8));

s7_N379_10 :=  __common__( map(trim(C_RECENT_MOV) = ''      => -0.012965324,
               ((real)c_recent_mov < 103.5) => 0.013679169,
                                               -0.012965324));

s7_N379_9 :=  __common__( if((add3_lres < 91), s7_N379_10, -0.02677512));

s7_N379_8 :=  __common__( if((combo_dobscore < 80), s7_N379_9, 0.00057481251));

s7_N379_7 :=  __common__( map(trim(C_YOUNG) = ''      => -0.022679073,
              ((real)c_young < 23.85) => 0.0029618779,
                                         -0.022679073));

s7_N379_6 :=  __common__( if((add1_avm_automated_valuation < 212539), -0.026440309, s7_N379_7));

s7_N379_5 :=  __common__( map(trim(C_HVAL_100K_P) = ''      => 0.0091066863,
              ((real)c_hval_100k_p < 20.65) => s7_N379_6,
                                               0.0091066863));

s7_N379_4 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N379_5, 0.00030541646));

s7_N379_3 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N379_4, s7_N379_8));

s7_N379_2 :=  __common__( if(((real)c_inc_35k_p < 23.25), s7_N379_3, -0.031736684));

s7_N379_1 :=  __common__( if(trim(C_INC_35K_P) != '', s7_N379_2, 0.0024838477));

s7_N380_8 :=  __common__( if((add2_avm_automated_valuation < 340460), -0.0066675789, -0.021361512));

s7_N380_7 :=  __common__( map(trim(C_RELIG_INDX) = ''     => -0.022022879,
              ((real)c_relig_indx < 81.5) => 0.0093586983,
                                             -0.022022879));

s7_N380_6 :=  __common__( map(trim(C_ASSAULT) = ''     => s7_N380_7,
              ((real)c_assault < 25.5) => 0.022322202,
                                          s7_N380_7));

s7_N380_5 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.021516721, s7_N380_6));

s7_N380_4 :=  __common__( if(((real)c_span_lang < 85.5), s7_N380_5, s7_N380_8));

s7_N380_3 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N380_4, 0.00019346548));

s7_N380_2 :=  __common__( if(((real)add2_lres < 255.5), s7_N380_3, 0.016012731));

s7_N380_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N380_2, 0.0012567684));

s7_N381_11 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 349.5), 0.069120423, 0.0070753566));

s7_N381_10 :=  __common__( if(((real)c_rnt250_p < 3.75), s7_N381_11, -0.0089274634));

s7_N381_9 :=  __common__( if(trim(C_RNT250_P) != '', s7_N381_10, -0.029101172));

s7_N381_8 :=  __common__( if(((real)_adls_per_phone_c6 < 0.5), s7_N381_9, -0.0047380234));

s7_N381_7 :=  __common__( if(((real)age < 51.5), 0.0019129557, s7_N381_8));

s7_N381_6 :=  __common__( if(((integer)add3_avm_automated_valuation < 419873), -4.119486e-005, s7_N381_7));

s7_N381_5 :=  __common__( if(((real)source_count < 1.5), 0.027553244, 0.00024036221));

s7_N381_4 :=  __common__( map(trim(C_LAR_FAM) = ''      => -0.027593578,
              ((real)c_lar_fam < 156.5) => -0.009779268,
                                           -0.027593578));

s7_N381_3 :=  __common__( if(((real)c_civ_emp < 41.65), s7_N381_4, s7_N381_5));

s7_N381_2 :=  __common__( if(trim(C_CIV_EMP) != '', s7_N381_3, -0.03024323));

s7_N381_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N381_2, s7_N381_6));

s7_N382_10 :=  __common__( if(((real)rc_lnamecount < 1.5), 0.02347598, -0.0020019682));

s7_N382_9 :=  __common__( if(((real)ssn_lowissue_age < 8.37076), 0.058773497, 0.013795436));

s7_N382_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N382_9, 0.049058128));

s7_N382_7 :=  __common__( map(trim(C_MURDERS) = ''      => 0.032266085,
              ((integer)c_murders < 81) => 0.0052011001,
                                           0.032266085));

s7_N382_6 :=  __common__( if(((real)age < 37.5), -0.0028223133, s7_N382_7));

s7_N382_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), s7_N382_6, s7_N382_8));

s7_N382_4 :=  __common__( if(((real)_ssns_per_addr < 7.5), -0.0055088321, s7_N382_5));

s7_N382_3 :=  __common__( if(((real)rc_dirsaddr_lastscore < 53.5), s7_N382_4, 0.0013430704));

s7_N382_2 :=  __common__( if(((real)c_totsales < 3272.5), s7_N382_3, s7_N382_10));

s7_N382_1 :=  __common__( if(trim(C_TOTSALES) != '', s7_N382_2, -0.0084079052));

s7_N383_10 :=  __common__( map(trim(C_INC_201K_P) = ''     => 0.059250205,
               ((real)c_inc_201k_p < 0.75) => -9.6229607e-005,
                                              0.059250205));

s7_N383_9 :=  __common__( map(trim(C_BURGLARY) = ''       => -0.019054019,
              ((integer)c_burglary < 104) => s7_N383_10,
                                             -0.019054019));

s7_N383_8 :=  __common__( if(((real)add1_source_count < 2.5), 0.044191179, s7_N383_9));

s7_N383_7 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0059349263, s7_N383_8));

s7_N383_6 :=  __common__( map(trim(C_RNT500_P) = ''      => s7_N383_7,
              ((real)c_rnt500_p < 22.35) => -0.01317202,
                                            s7_N383_7));

s7_N383_5 :=  __common__( if(((real)add1_avm_med < 38050.5), s7_N383_6, -0.00092877347));

s7_N383_4 :=  __common__( if(((real)c_inc_25k_p < 21.85), s7_N383_5, -0.012858975));

s7_N383_3 :=  __common__( if(trim(C_INC_25K_P) != '', s7_N383_4, 0.0022371198));

s7_N383_2 :=  __common__( if(((real)ssn_lowissue_age < 54.0553), s7_N383_3, 0.022605822));

s7_N383_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N383_2, 0.0041660017));

s7_N384_9 :=  __common__( if(((real)gong_did_addr_ct < 0.5), 0.035792593, -0.011267608));

s7_N384_8 :=  __common__( map(trim(C_WHITE_COL) = ''      => -0.014410877,
              ((real)c_white_col < 22.35) => -0.027150758,
                                             -0.014410877));

s7_N384_7 :=  __common__( if(((real)avg_lres < 179.5), s7_N384_8, s7_N384_9));

s7_N384_6 :=  __common__( map(trim(C_INC_150K_P) = ''     => -0.0089415107,
              ((real)c_inc_150k_p < 4.35) => 0.02706876,
                                             -0.0089415107));

s7_N384_5 :=  __common__( map(trim(C_CHILD) = ''      => s7_N384_7,
              ((real)c_child < 14.25) => s7_N384_6,
                                         s7_N384_7));

s7_N384_4 :=  __common__( map(trim(C_UNEMP) = ''     => 0.015082414,
              ((real)c_unemp < 5.45) => 0.0032468947,
                                        0.015082414));

s7_N384_3 :=  __common__( map(trim(C_NO_MOVE) = ''     => 1.3097357e-005,
              ((real)c_no_move < 28.5) => s7_N384_4,
                                          1.3097357e-005));

s7_N384_2 :=  __common__( if(((real)c_assault < 189.5), s7_N384_3, s7_N384_5));

s7_N384_1 :=  __common__( if(trim(C_ASSAULT) != '', s7_N384_2, 0.0028166112));

s7_N385_12 :=  __common__( if(ssn_lowissue_age != null and ((real)ssn_lowissue_age < 13.4392), -0.014671808, 0.053306906));

s7_N385_11 :=  __common__( if(((real)_nas < 2.5), 0.0017320519, 0.011857811));

s7_N385_10 :=  __common__( if(((real)add2_source_count < 9.5), s7_N385_11, s7_N385_12));

s7_N385_9 :=  __common__( if(((real)c_civ_emp < 63.55), s7_N385_10, -0.0041847173));

s7_N385_8 :=  __common__( if(trim(C_CIV_EMP) != '', s7_N385_9, -0.006333932));

s7_N385_7 :=  __common__( map(trim(C_ROBBERY) = ''      => 0.027500579,
              ((real)c_robbery < 184.5) => -0.00037555786,
                                           0.027500579));

s7_N385_6 :=  __common__( if(((real)c_robbery < 191.5), s7_N385_7, -0.026669366));

s7_N385_5 :=  __common__( if(trim(C_ROBBERY) != '', s7_N385_6, 0.00083262596));

s7_N385_4 :=  __common__( if(((real)add1_no_of_bedrooms2 > NULL), 0.0047075497, 0.057960911));

s7_N385_3 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 1.5), -0.00089016813, s7_N385_4));

s7_N385_2 :=  __common__( if(mth_attr_date_last_derog != null and ((real)mth_attr_date_last_derog > NULL), s7_N385_3, s7_N385_5));

s7_N385_1 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s7_N385_2, s7_N385_8));

s7_N386_9 :=  __common__( if(((real)c_med_hhinc < 23084.5), -0.01248431, -0.00093559049));

s7_N386_8 :=  __common__( if(trim(C_MED_HHINC) != '', s7_N386_9, -0.0085919943));

s7_N386_7 :=  __common__( map(trim(C_YOUNG) = ''      => 0.062526012,
              ((integer)c_young < 14) => 0.01026181,
                                         0.062526012));

s7_N386_6 :=  __common__( if(((real)_addrs_per_adl_c6 < 0.5), -0.0069632313, s7_N386_7));

s7_N386_5 :=  __common__( map(trim(C_RETIRED) = ''      => s7_N386_6,
              ((real)c_retired < 26.95) => 0.0032164248,
                                           s7_N386_6));

s7_N386_4 :=  __common__( map(trim(C_HHSIZE) = ''      => s7_N386_5,
              ((real)c_hhsize < 1.595) => -0.015441482,
                                          s7_N386_5));

s7_N386_3 :=  __common__( if(((real)c_med_inc < 3.5), 0.02295517, s7_N386_4));

s7_N386_2 :=  __common__( if(trim(C_MED_INC) != '', s7_N386_3, 0.010902151));

s7_N386_1 :=  __common__( if(((real)_adls_per_addr_cap10 < 0.5), s7_N386_2, s7_N386_8));

s7_N387_11 :=  __common__( if((add3_lres < 183), -0.012694447, 0.024088623));

s7_N387_10 :=  __common__( map(trim(C_YOUNG) = ''      => -0.0016499476,
               ((real)c_young < 27.85) => 0.040608876,
                                          -0.0016499476));

s7_N387_9 :=  __common__( if(((real)ssn_lowissue_age < 18.7144), s7_N387_10, 0.043265771));

s7_N387_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N387_9, -0.020034451));

s7_N387_7 :=  __common__( map(trim(C_FOR_SALE) = ''     => s7_N387_11,
              ((real)c_for_sale < 94.5) => s7_N387_8,
                                           s7_N387_11));

s7_N387_6 :=  __common__( map(trim(C_MURDERS) = ''      => s7_N387_7,
              ((real)c_murders < 173.5) => -0.00076913618,
                                           s7_N387_7));

s7_N387_5 :=  __common__( if(((real)c_assault < 191.5), s7_N387_6, -0.019927586));

s7_N387_4 :=  __common__( if(trim(C_ASSAULT) != '', s7_N387_5, -0.0060095481));

s7_N387_3 :=  __common__( map(trim(C_HVAL_100K_P) = ''     => -0.0039373346,
              ((real)c_hval_100k_p < 5.95) => 0.036225486,
                                              -0.0039373346));

s7_N387_2 :=  __common__( if(((integer)add1_building_area2 < 86457), 0.00013407756, s7_N387_3));

s7_N387_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N387_2, s7_N387_4));

s7_N388_10 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((integer)mth_ver_src_fsrc_fdate < 104), -0.016019728, 0.025983583));
s7_N388_9 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N388_10, 0.033926617));
s7_N388_8 :=  __common__( map(trim(C_INCOLLEGE) = ''     => -0.0027492953,
              ((real)c_incollege < 6.25) => -0.018981534,
                                            -0.0027492953));
s7_N388_7 :=  __common__( map(trim(C_RNT750_P) = ''     => s7_N388_9,
              ((real)c_rnt750_p < 60.2) => s7_N388_8,
                                           s7_N388_9));
s7_N388_6 :=  __common__( if(((integer)add1_nhood_vacant_properties < 84), 0.0072940665, 0.039504426));
s7_N388_5 :=  __common__( map(trim(C_APT20) = ''      => s7_N388_6,
              ((real)c_apt20 < 193.5) => 0.0030686636,
                                         s7_N388_6));
s7_N388_4 :=  __common__( if(((real)add1_source_count < 4.5), s7_N388_5, -0.00018688797));
s7_N388_3 :=  __common__( if(((real)_addr_score < 2.5), s7_N388_4, s7_N388_7));
s7_N388_2 :=  __common__( if(((real)c_inc_15k_p < 59.95), s7_N388_3, -0.020222269));
s7_N388_1 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N388_2, -0.012872906));

s7_N389_8 :=  __common__( if(((real)_addrs_last30 < 0.5), -0.003134479, 0.048312326));

s7_N389_7 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 21.5), 0.024960916, 0.001732391));

s7_N389_6 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N389_7, 0.010404336));

s7_N389_5 :=  __common__( if(((real)_adls_per_phone < 0.5), s7_N389_6, s7_N389_8));

s7_N389_4 :=  __common__( if(((real)add1_lres < 332.5), s7_N389_5, 0.036298668));

s7_N389_3 :=  __common__( if(((real)_phone_score < 2.5), 0.00040728035, s7_N389_4));

s7_N389_2 :=  __common__( if(((real)avg_lres < 386.5), s7_N389_3, 0.042425028));

s7_N389_1 :=  __common__( if(((real)add1_lres < 412.5), s7_N389_2, -0.014192815));

s7_N390_8 :=  __common__( if(((real)mth_header_first_seen > NULL), 0.015759603, 0.37586233));

s7_N390_7 :=  __common__( if(((real)combined_age < 21.5), s7_N390_8, -0.0011500953));

s7_N390_6 :=  __common__( map(trim(C_MANY_CARS) = ''     => 0.0062611474,
              ((real)c_many_cars < 43.5) => -0.010729448,
                                            0.0062611474));

s7_N390_5 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.01191261,
              ((integer)c_relig_indx < 82) => 0.045890927,
                                              0.01191261));

s7_N390_4 :=  __common__( map(trim(C_RNT500_P) = ''     => s7_N390_5,
              ((real)c_rnt500_p < 13.2) => -0.0050891725,
                                           s7_N390_5));

s7_N390_3 :=  __common__( if(((integer)c_ownocc_p < 13), s7_N390_4, s7_N390_6));

s7_N390_2 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N390_3, 0.028868911));

s7_N390_1 :=  __common__( if(((real)_addrs_10yr < 2.5), s7_N390_2, s7_N390_7));

s7_N391_8 :=  __common__( map(trim(C_BLUE_COL) = ''      => 0.056763505,
              ((real)c_blue_col < 25.05) => 0.0055426993,
                                            0.056763505));

s7_N391_7 :=  __common__( if(((real)avg_lres < 230.5), s7_N391_8, -0.016578673));

s7_N391_6 :=  __common__( map(trim(C_LOWINC) = ''      => 0.011006946,
              ((real)c_lowinc < 12.95) => 0.10924996,
                                          0.011006946));

s7_N391_5 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => -0.017076527,
              ((real)c_asian_lang < 122.5) => s7_N391_6,
                                              -0.017076527));

s7_N391_4 :=  __common__( if(((real)_inq_collection_count < 0.5), s7_N391_5, 0.04897991));

s7_N391_3 :=  __common__( if(((real)c_burglary < 30.5), s7_N391_4, s7_N391_7));

s7_N391_2 :=  __common__( if(trim(C_BURGLARY) != '', s7_N391_3, -0.02580644));

s7_N391_1 :=  __common__( if(((real)add1_source_count < 10.5), -0.0013118736, s7_N391_2));

s7_N392_8 :=  __common__( map(trim(C_BEL_EDU) = ''     => 0.0010685266,
              ((real)c_bel_edu < 14.5) => 0.059336162,
                                          0.0010685266));

s7_N392_7 :=  __common__( map(trim(C_SFDU_P) = ''      => s7_N392_8,
              ((real)c_sfdu_p < 64.75) => 0.086538138,
                                          s7_N392_8));

s7_N392_6 :=  __common__( map(trim(C_MURDERS) = ''     => 0.003423472,
              ((real)c_murders < 30.5) => s7_N392_7,
                                          0.003423472));

s7_N392_5 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N392_6, 0.013150964));

s7_N392_4 :=  __common__( if((combo_dobscore < 92), 0.03297066, s7_N392_5));

s7_N392_3 :=  __common__( if(((real)rc_fnamecount < 7.5), 0.010783354, -0.0033839028));

s7_N392_2 :=  __common__( if((add1_avm_automated_valuation < 274479), s7_N392_3, s7_N392_4));

s7_N392_1 :=  __common__( if(((real)add2_lres < 205.5), -0.00025884418, s7_N392_2));

s7_N393_11 :=  __common__( map(trim(C_TOTSALES) = ''        => -0.0011854875,
               ((integer)c_totsales < 2571) => 0.057586409,
                                               -0.0011854875));

s7_N393_10 :=  __common__( map(trim(C_LOWINC) = ''      => -0.023640455,
               ((real)c_lowinc < 57.05) => s7_N393_11,
                                           -0.023640455));

s7_N393_9 :=  __common__( map(trim(C_MED_HHINC) = ''        => s7_N393_10,
              ((real)c_med_hhinc < 24376.5) => 0.052335954,
                                               s7_N393_10));

s7_N393_8 :=  __common__( if(((real)mth_header_first_seen < 289.5), 0.003207373, -0.0054294718));

s7_N393_7 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N393_8, 0.034217268));

s7_N393_6 :=  __common__( map(trim(C_SPAN_LANG) = ''      => -0.023441258,
              ((real)c_span_lang < 197.5) => s7_N393_7,
                                             -0.023441258));

s7_N393_5 :=  __common__( if(((real)_wealth_index < 1.5), 0.035407915, s7_N393_6));

s7_N393_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N393_5, -9.3716009e-005));

s7_N393_3 :=  __common__( map(trim(C_HVAL_40K_P) = ''      => s7_N393_9,
              ((real)c_hval_40k_p < 36.05) => s7_N393_4,
                                              s7_N393_9));

s7_N393_2 :=  __common__( if(((real)c_med_hval < 34833.5), -0.010570545, s7_N393_3));

s7_N393_1 :=  __common__( if(trim(C_MED_HVAL) != '', s7_N393_2, 0.0010907872));

s7_N394_8 :=  __common__( map(trim(C_NO_MOVE) = ''     => -0.011816767,
              ((real)c_no_move < 59.5) => 0.027995201,
                                          -0.011816767));

s7_N394_7 :=  __common__( map(trim(C_EDU_INDX) = ''      => 0.018620621,
              ((real)c_edu_indx < 121.5) => -0.0094602396,
                                            0.018620621));

s7_N394_6 :=  __common__( map(trim(C_HVAL_60K_P) = ''     => -0.021742344,
              ((real)c_hval_60k_p < 2.45) => s7_N394_7,
                                             -0.021742344));

s7_N394_5 :=  __common__( if(((real)_rel_bankrupt_count < 1.5), s7_N394_6, s7_N394_8));

s7_N394_4 :=  __common__( if(trim(C_AB_AV_EDU) != '', s7_N394_5, -0.015995767));

s7_N394_3 :=  __common__( if(((real)add2_lres < 117.5), 0.017188834, -0.0060140605));

s7_N394_2 :=  __common__( if(((real)_rel_educationunder8_count < 4.5), -0.00011964298, s7_N394_3));

s7_N394_1 :=  __common__( if(((real)_addr_score < 2.5), s7_N394_2, s7_N394_4));

s7_N395_11 :=  __common__( if(((real)add1_nhood_vacant_properties < 9.5), 0.069996591, 0.0061011966));

s7_N395_10 :=  __common__( if(((real)add2_lres < 442.5), -0.0026791972, 0.036115173));

s7_N395_9 :=  __common__( if((add1_avm_automated_valuation < 639260), s7_N395_10, s7_N395_11));

s7_N395_8 :=  __common__( map(trim(C_RNT500_P) = ''     => 0.030688954,
              ((real)c_rnt500_p < 22.4) => 0.0016985632,
                                           0.030688954));

s7_N395_7 :=  __common__( if(((real)rc_fnamecount < 7.5), s7_N395_8, -0.0024149023));

s7_N395_6 :=  __common__( if(((real)mth_gong_did_first_seen < 100.5), s7_N395_7, 0.041288608));

s7_N395_5 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N395_6, -5.1178334e-006));

s7_N395_4 :=  __common__( map(trim(C_OWNOCC_P) = ''     => 0.0025484942,
              ((real)c_ownocc_p < 9.05) => -0.024765622,
                                           0.0025484942));

s7_N395_3 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N395_4, s7_N395_5));

s7_N395_2 :=  __common__( if(((real)c_inc_50k_p < 15.55), s7_N395_3, s7_N395_9));

s7_N395_1 :=  __common__( if(trim(C_INC_50K_P) != '', s7_N395_2, -0.00090077323));

s7_N396_9 :=  __common__( if(((real)mth_header_first_seen > NULL), -0.0050204006, 0.1595362));

s7_N396_8 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), -0.0058045429, s7_N396_9));

s7_N396_7 :=  __common__( if(((real)ver_src_p < 0.5), 0.041793127, -0.0069700395));

s7_N396_6 :=  __common__( map(trim(C_EASIQLIFE) = ''     => -0.0027107073,
              ((real)c_easiqlife < 92.5) => 0.047086813,
                                            -0.0027107073));

s7_N396_5 :=  __common__( if(((real)add1_building_area2 < 1148.5), 0.047583871, s7_N396_6));

s7_N396_4 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N396_5, s7_N396_7));

s7_N396_3 :=  __common__( if(((real)_inq_count06 < 1.5), s7_N396_4, 0.072693387));

s7_N396_2 :=  __common__( if(((real)add2_turnover_1yr_in < 1305.5), 0.00093738498, s7_N396_3));

s7_N396_1 :=  __common__( if(((real)add2_nhood_vacant_properties < 102.5), s7_N396_2, s7_N396_8));

s7_N397_10 :=  __common__( map(trim(C_LARCENY) = ''     => 0.011479376,
               ((real)c_larceny < 56.5) => 0.092427201,
                                           0.011479376));

s7_N397_9 :=  __common__( if(((real)add3_naprop < 0.5), -0.00083733827, s7_N397_10));

s7_N397_8 :=  __common__( map(trim(C_LAR_FAM) = ''      => -0.015876319,
              ((real)c_lar_fam < 184.5) => 0.0056750953,
                                           -0.015876319));

s7_N397_7 :=  __common__( map(trim(C_BIGAPT_P) = ''     => s7_N397_9,
              ((real)c_bigapt_p < 33.8) => s7_N397_8,
                                           s7_N397_9));

s7_N397_6 :=  __common__( if(((real)_ssns_per_addr < 4.5), -0.0047461105, s7_N397_7));

s7_N397_5 :=  __common__( if(((integer)c_totsales < 16637), s7_N397_6, -0.0034196058));

s7_N397_4 :=  __common__( if(trim(C_TOTSALES) != '', s7_N397_5, -0.014382499));

s7_N397_3 :=  __common__( if(((real)avg_lres < 272.5), s7_N397_4, -0.012842187));

s7_N397_2 :=  __common__( if(((real)add1_building_area2 < 648.5), 0.03450654, s7_N397_3));

s7_N397_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N397_2, -0.00026923751));

s7_N398_8 :=  __common__( map(trim(C_BLUE_COL) = ''     => 0.040993704,
              ((real)c_blue_col < 7.15) => 0.0040524105,
                                           0.040993704));

s7_N398_7 :=  __common__( if(((integer)add1_avm_med < 176067), -0.002455288, s7_N398_8));

s7_N398_6 :=  __common__( if(((real)age < 81.5), 0.0035890987, s7_N398_7));

s7_N398_5 :=  __common__( map(trim(C_INC_50K_P) = ''      => -0.016924966,
              ((real)c_inc_50k_p < 17.95) => 0.011500019,
                                             -0.016924966));

s7_N398_4 :=  __common__( if(((real)ver_positive_src_cnt < 4.5), s7_N398_5, -0.014935869));

s7_N398_3 :=  __common__( if(((real)c_low_ed < 64.25), -0.00049306662, s7_N398_4));

s7_N398_2 :=  __common__( if(trim(C_LOW_ED) != '', s7_N398_3, 0.00057114576));

s7_N398_1 :=  __common__( if(((real)add1_lres < 143.5), s7_N398_2, s7_N398_6));

s7_N399_7 :=  __common__( map(trim(C_HVAL_100K_P) = ''    => 0.00036547854,
              ((real)c_hval_100k_p < 5.7) => 0.054457532,
                                             0.00036547854));

s7_N399_6 :=  __common__( map((prof_license_category in ['0', '3', '4', '5']) => s7_N399_7,
              (prof_license_category in ['1', '2'])           => 0.20037062,
                                                                 s7_N399_7));

s7_N399_5 :=  __common__( if(((real)attr_num_nonderogs30 < 6.5), 0.0004893286, 0.039661119));

s7_N399_4 :=  __common__( if(((real)add3_source_count < 5.5), s7_N399_5, s7_N399_6));

s7_N399_3 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 1.5), s7_N399_4, -0.017705757));

s7_N399_2 :=  __common__( if(((real)add2_turnover_1yr_in < 1869.5), 0.050673516, s7_N399_3));

s7_N399_1 :=  __common__( if(((integer)add2_turnover_1yr_in < 1818), -0.0005288308, s7_N399_2));

s7_N400_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.011095239, -0.074887238));

s7_N400_7 :=  __common__( map(trim(C_LAR_FAM) = ''      => -0.015759168,
              ((real)c_lar_fam < 177.5) => -0.0014012602,
                                           -0.015759168));

s7_N400_6 :=  __common__( if(((real)add1_nhood_vacant_properties < 11.5), 0.0021114713, s7_N400_7));

s7_N400_5 :=  __common__( map(trim(C_HVAL_80K_P) = ''     => 0.029036628,
              ((real)c_hval_80k_p < 65.5) => s7_N400_6,
                                             0.029036628));

s7_N400_4 :=  __common__( map(trim(C_UNEMP) = ''      => s7_N400_8,
              ((real)c_unemp < 12.15) => s7_N400_5,
                                         s7_N400_8));

s7_N400_3 :=  __common__( if(((real)c_lowinc < 87.05), s7_N400_4, 0.017971079));

s7_N400_2 :=  __common__( if(trim(C_LOWINC) != '', s7_N400_3, 0.0056117929));

s7_N400_1 :=  __common__( if(((real)avg_lres < 4.5), -0.015465764, s7_N400_2));

s7_N401_8 :=  __common__( map(trim(C_APT20) = ''      => -0.0036931179,
              ((real)c_apt20 < 153.5) => 0.019487904,
                                         -0.0036931179));

s7_N401_7 :=  __common__( map((prof_license_category in ['0', '2', '3', '5']) => s7_N401_8,
              (prof_license_category in ['1', '4'])           => 0.091856502,
                                                                 s7_N401_8));

s7_N401_6 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N401_7, 0.0066238051));

s7_N401_5 :=  __common__( if(((real)c_lar_fam < 98.5), 0.00040891987, s7_N401_6));

s7_N401_4 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N401_5, 0.0020860717));

s7_N401_3 :=  __common__( if((combo_dobscore < 45), -0.018190067, s7_N401_4));

s7_N401_2 :=  __common__( if(((real)gong_did_addr_ct < 0.5), -0.0018858618, s7_N401_3));

s7_N401_1 :=  __common__( if(((real)_addrs_15yr < 9.5), s7_N401_2, -0.0044771422));

s7_N402_12 :=  __common__( if(((real)add2_turnover_1yr_in < 406.5), 0.011113022, 0.042572101));

s7_N402_11 :=  __common__( if(((real)c_recent_mov < 44.5), 0.024701848, 0.0031890175));

s7_N402_10 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N402_11, 0.023018239));

s7_N402_9 :=  __common__( if(((real)add2_avm_to_med_ratio < 0.905631), 0.063222298, 0.022478619));

s7_N402_8 :=  __common__( if(((real)_rel_homeunder100_count < 0.5), s7_N402_9, -0.002833404));

s7_N402_7 :=  __common__( if(((real)c_lar_fam < 76.5), -0.0072880957, s7_N402_8));

s7_N402_6 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N402_7, -0.025651885));

s7_N402_5 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N402_6, s7_N402_10));

s7_N402_4 :=  __common__( if(((real)_rel_count_addr < 0.5), s7_N402_5, -0.0016033258));

s7_N402_3 :=  __common__( if(((real)_rel_felony_total < 1.5), s7_N402_4, s7_N402_12));

s7_N402_2 :=  __common__( if(((real)_addrs_last36 < 4.5), s7_N402_3, -0.0070398335));

s7_N402_1 :=  __common__( if(((real)add1_building_area2 > NULL), -0.00025671486, s7_N402_2));

s7_N403_10 :=  __common__( map(trim(C_FAMMAR_P) = ''     => 0.059262884,
               ((real)c_fammar_p < 86.5) => -0.021656396,
                                            0.059262884));

s7_N403_9 :=  __common__( if(((real)add3_source_count < 2.5), 0.050708078, -0.0050140456));

s7_N403_8 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N403_9, s7_N403_10));

s7_N403_7 :=  __common__( if(((real)rc_phonelnamecount < 0.5), 0.015268022, -0.019564026));

s7_N403_6 :=  __common__( map(trim(C_LOWRENT) = ''     => 0.043120083,
              ((real)c_lowrent < 52.7) => s7_N403_7,
                                          0.043120083));

s7_N403_5 :=  __common__( map(trim(C_HHSIZE) = ''      => s7_N403_6,
              ((real)c_hhsize < 2.815) => -0.0071280732,
                                          s7_N403_6));

s7_N403_4 :=  __common__( map(trim(C_FEMDIV_P) = ''     => 0.038306024,
              ((real)c_femdiv_p < 7.55) => s7_N403_5,
                                           0.038306024));

s7_N403_3 :=  __common__( if(((real)_adls_per_addr_c6 < 3.5), -0.0014407834, s7_N403_4));

s7_N403_2 :=  __common__( if(((real)c_hval_750k_p < 31.65), s7_N403_3, s7_N403_8));

s7_N403_1 :=  __common__( if(trim(C_HVAL_750K_P) != '', s7_N403_2, -0.0022922762));

s7_N404_9 :=  __common__( map(trim(C_CHILD) = ''      => 0.075101563,
              ((real)c_child < 30.25) => 0.003236342,
                                         0.075101563));

s7_N404_8 :=  __common__( if(((real)_phones_per_adl < 0.5), -0.0097053933, 0.02790163));

s7_N404_7 :=  __common__( if((combo_dobscore < 92), s7_N404_8, -0.0085039808));

s7_N404_6 :=  __common__( map(trim(C_BURGLARY) = ''     => 0.00068263974,
              ((real)c_burglary < 18.5) => s7_N404_7,
                                           0.00068263974));

s7_N404_5 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N404_9,
              ((real)c_civ_emp < 84.55) => s7_N404_6,
                                           s7_N404_9));

s7_N404_4 :=  __common__( map(trim(C_LOW_HVAL) = ''      => -0.019620531,
              ((real)c_low_hval < 93.25) => s7_N404_5,
                                            -0.019620531));

s7_N404_3 :=  __common__( if(((real)ver_positive_src_cnt < 4.5), 0.0082334059, -0.02189108));

s7_N404_2 :=  __common__( if(((real)c_sfdu_p < 0.25), s7_N404_3, s7_N404_4));

s7_N404_1 :=  __common__( if(trim(C_SFDU_P) != '', s7_N404_2, 0.0044615369));

s7_N405_10 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 238.5), -0.0071247703, -0.027152586));

s7_N405_9 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N405_10, 0.043259617));

s7_N405_8 :=  __common__( if(((real)source_count < 6.5), -0.022211522, 0.0081680444));

s7_N405_7 :=  __common__( if(((real)_inq_peraddr_cap8 < 0.5), s7_N405_8, 0.017300335));

s7_N405_6 :=  __common__( if(((real)ssn_lowissue_age < 14.8549), s7_N405_7, s7_N405_9));

s7_N405_5 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N405_6, 0.0029100697));

s7_N405_4 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => s7_N405_5,
              (prof_license_category in ['0'])                     => 0.22961088,
                                                                      s7_N405_5));

s7_N405_3 :=  __common__( if(((real)add2_avm_to_med_ratio < 1.07644), -0.013892441, 0.011436544));

s7_N405_2 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N405_3, s7_N405_4));

s7_N405_1 :=  __common__( if(((real)input_dob_match_level < 5.5), s7_N405_2, -2.8132304e-005));

s7_N406_9 :=  __common__( map(trim(C_SPAN_LANG) = ''      => 0.022340376,
              ((real)c_span_lang < 172.5) => -0.0071666002,
                                             0.022340376));

s7_N406_8 :=  __common__( if(((real)_adls_per_addr_cap10 < 5.5), 0.022069425, s7_N406_9));

s7_N406_7 :=  __common__( if(((real)combo_dobcount < 0.5), s7_N406_8, 0.00012757392));

s7_N406_6 :=  __common__( map(trim(C_RENTOCC_P) = ''      => -0.0050548856,
              ((integer)c_rentocc_p < 75) => 0.052222472,
                                             -0.0050548856));

s7_N406_5 :=  __common__( map(trim(C_RENTOCC_P) = ''     => s7_N406_6,
              ((real)c_rentocc_p < 66.5) => -0.0088085242,
                                            s7_N406_6));

s7_N406_4 :=  __common__( if(((real)age < 66.5), s7_N406_5, -0.025211395));

s7_N406_3 :=  __common__( if(((real)rc_fnamecount < 3.5), s7_N406_4, s7_N406_7));

s7_N406_2 :=  __common__( if(((real)c_pop_25_34_p < 33.15), s7_N406_3, -0.01205185));

s7_N406_1 :=  __common__( if(trim(C_POP_25_34_P) != '', s7_N406_2, -0.00093180735));

s7_N407_9 :=  __common__( if(((real)add2_source_count < 8.5), -0.012642405, 0.02645108));

s7_N407_8 :=  __common__( if(((real)add1_turnover_1yr_in < 56.5), 0.053614641, 0.0048382248));

s7_N407_7 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N407_8, 0.001085849));

s7_N407_6 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.0011258782, 0.024508293));

s7_N407_5 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.010678419, -0.045917446));

s7_N407_4 :=  __common__( if(((real)add2_turnover_1yr_in < 77.5), s7_N407_5, s7_N407_6));

s7_N407_3 :=  __common__( if(((real)_phones_per_adl < 0.5), s7_N407_4, s7_N407_7));

s7_N407_2 :=  __common__( if(((real)c_armforce < 142.5), s7_N407_3, s7_N407_9));

s7_N407_1 :=  __common__( if(trim(C_ARMFORCE) != '', s7_N407_2, -0.0023396344));

s7_N408_11 :=  __common__( map(trim(C_SFDU_P) = ''      => -0.013080082,
               ((real)c_sfdu_p < 63.15) => -0.0010628285,
                                           -0.013080082));

s7_N408_10 :=  __common__( map(trim(C_ARMFORCE) = ''      => 0.026959102,
               ((real)c_armforce < 193.5) => s7_N408_11,
                                             0.026959102));

s7_N408_9 :=  __common__( if(((integer)add2_turnover_1yr_in < 232), 0.025191513, -0.013170094));

s7_N408_8 :=  __common__( map(trim(C_BURGLARY) = ''      => 0.024967629,
              ((real)c_burglary < 176.5) => s7_N408_9,
                                            0.024967629));

s7_N408_7 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => s7_N408_10,
              ((real)c_fammar18_p < 14.85) => s7_N408_8,
                                              s7_N408_10));

s7_N408_6 :=  __common__( if(((integer)mth_header_first_seen < 513), -0.0041506688, 0.036390929));

s7_N408_5 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N408_6, -0.00098237129));

s7_N408_4 :=  __common__( if(((real)add1_avm_to_med_ratio < 2.44532), s7_N408_5, 0.03124784));

s7_N408_3 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N408_4, s7_N408_7));

s7_N408_2 :=  __common__( if(((real)c_unempl < 103.5), 0.0013816626, s7_N408_3));

s7_N408_1 :=  __common__( if(trim(C_UNEMPL) != '', s7_N408_2, 0.0036073484));

s7_N409_9 :=  __common__( map(trim(C_UNEMPL) = ''     => 0.087268259,
              ((real)c_unempl < 66.5) => 0.019392432,
                                         0.087268259));

s7_N409_8 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.0083252949,
              ((real)c_low_ed < 31.35) => s7_N409_9,
                                          0.0083252949));

s7_N409_7 :=  __common__( map(trim(C_HVAL_100K_P) = ''      => -0.019170898,
              ((real)c_hval_100k_p < 52.25) => 0.0016206787,
                                               -0.019170898));

s7_N409_6 :=  __common__( map(trim(C_OWNOCC_P) = ''      => s7_N409_8,
              ((real)c_ownocc_p < 91.55) => s7_N409_7,
                                            s7_N409_8));

s7_N409_5 :=  __common__( map(trim(C_HIGHINC) = ''      => 0.037882824,
              ((real)c_highinc < 39.55) => s7_N409_6,
                                           0.037882824));

s7_N409_4 :=  __common__( if(((real)mth_header_first_seen > NULL), -0.0032057338, 0.045546179));

s7_N409_3 :=  __common__( map(trim(C_LOWINC) = ''      => s7_N409_5,
              ((real)c_lowinc < 16.75) => s7_N409_4,
                                          s7_N409_5));

s7_N409_2 :=  __common__( if(((real)c_blue_col < 29.35), s7_N409_3, -0.015211111));

s7_N409_1 :=  __common__( if(trim(C_BLUE_COL) != '', s7_N409_2, -0.0013674777));

s7_N410_8 :=  __common__( map(trim(C_WHITE_COL) = ''     => 0.035149863,
              ((real)c_white_col < 36.6) => -0.0078087484,
                                            0.035149863));

s7_N410_7 :=  __common__( if(((integer)add1_turnover_1yr_in < 205), 0.063365271, s7_N410_8));

s7_N410_6 :=  __common__( if(((real)source_count < 6.5), s7_N410_7, 0.0061253357));

s7_N410_5 :=  __common__( if((add2_avm_automated_valuation < 446763), s7_N410_6, 0.038969371));

s7_N410_4 :=  __common__( if(((real)c_fammar18_p < 23.55), -0.0084510856, s7_N410_5));

s7_N410_3 :=  __common__( if(trim(C_FAMMAR18_P) != '', s7_N410_4, 0.0028667715));

s7_N410_2 :=  __common__( if(((real)add_bestmatch_level < 0.5), -0.0013600034, s7_N410_3));

s7_N410_1 :=  __common__( if(((real)_rel_count_addr < 0.5), s7_N410_2, -0.001235479));

s7_N411_9 :=  __common__( if(((real)c_retired < 9.85), 0.0034320371, 0.066112981));

s7_N411_8 :=  __common__( if(trim(C_RETIRED) != '', s7_N411_9, -0.025928188));

s7_N411_7 :=  __common__( if(((real)add1_source_count < 1.5), 0.018446524, -0.00058511903));

s7_N411_6 :=  __common__( if(((integer)c_totsales < 399274), s7_N411_7, 0.042556358));

s7_N411_5 :=  __common__( if(trim(C_TOTSALES) != '', s7_N411_6, -0.025967458));

s7_N411_4 :=  __common__( if((combo_dobscore < 93), 0.021571248, s7_N411_5));

s7_N411_3 :=  __common__( if(((real)add2_source_count < 7.5), s7_N411_4, s7_N411_8));

s7_N411_2 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.0631345, s7_N411_3));

s7_N411_1 :=  __common__( if(((integer)add3_eda_sourced < 0.5), -0.0012955534, s7_N411_2));

s7_N412_9 :=  __common__( map(trim(C_RETIRED2) = ''     => 0.0038199666,
              ((real)c_retired2 < 43.5) => 0.032310435,
                                           0.0038199666));

s7_N412_8 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '5']) => -0.030708841,
              (prof_license_category in ['4'])                     => 0.20573632,
                                                                      -0.030708841));

s7_N412_7 :=  __common__( if(((integer)add1_avm_med < 127709), 0.0074197048, s7_N412_8));

s7_N412_6 :=  __common__( if(((real)combined_age < 43.5), s7_N412_7, s7_N412_9));

s7_N412_5 :=  __common__( map(trim(C_YOUNG) = ''      => 0.0097903553,
              ((integer)c_young < 28) => 0.040007137,
                                         0.0097903553));

s7_N412_4 :=  __common__( if(((real)add1_building_area2 > NULL), 0.0054522283, s7_N412_5));

s7_N412_3 :=  __common__( if(((real)rc_lnamecount < 5.5), s7_N412_4, s7_N412_6));

s7_N412_2 :=  __common__( if(((real)c_fammar_p < 43.85), s7_N412_3, 0.00034553266));

s7_N412_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N412_2, 0.0061127425));

s7_N413_9 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.010619873,
              ((real)c_relig_indx < 120.5) => 0.042433544,
                                              0.010619873));

s7_N413_8 :=  __common__( map(trim(C_APT20) = ''       => 0.0018453177,
              ((integer)c_apt20 < 124) => -0.027837572,
                                          0.0018453177));

s7_N413_7 :=  __common__( map(trim(C_RETIRED2) = ''      => s7_N413_8,
              ((integer)c_retired2 < 51) => 0.022403974,
                                            s7_N413_8));

s7_N413_6 :=  __common__( if(((real)c_sfdu_p < 79.25), s7_N413_7, s7_N413_9));

s7_N413_5 :=  __common__( if(trim(C_SFDU_P) != '', s7_N413_6, 0.040112067));

s7_N413_4 :=  __common__( if((add1_avm_automated_valuation < 408232), -0.0084453958, 0.035425758));

s7_N413_3 :=  __common__( if(((real)c_hhsize < 4.545), -0.00061584151, s7_N413_4));

s7_N413_2 :=  __common__( if(trim(C_HHSIZE) != '', s7_N413_3, 0.0016122138));

s7_N413_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N413_2, s7_N413_5));

s7_N414_8 :=  __common__( if(((real)_ssns_per_adl_c6 < 0.5), 0.0024429947, 0.068342663));

s7_N414_7 :=  __common__( map(trim(C_HIGH_ED) = ''      => 0.012607456,
              ((real)c_high_ed < 11.15) => s7_N414_8,
                                           0.012607456));

s7_N414_6 :=  __common__( map(trim(C_NO_MOVE) = ''     => 0.0064012383,
              ((real)c_no_move < 67.5) => s7_N414_7,
                                          0.0064012383));

s7_N414_5 :=  __common__( if(((real)avg_lres < 76.5), s7_N414_6, 0.002079536));

s7_N414_4 :=  __common__( map(trim(C_HVAL_60K_P) = ''     => s7_N414_5,
              ((real)c_hval_60k_p < 1.35) => -0.015901481,
                                             s7_N414_5));

s7_N414_3 :=  __common__( if(((integer)add1_avm_med < 106116), s7_N414_4, -0.0010831899));

s7_N414_2 :=  __common__( if(trim(C_BORN_USA) != '', s7_N414_3, 0.0012222527));

s7_N414_1 :=  __common__( if((add2_avm_automated_valuation < 1.6225e+006), s7_N414_2, 0.044945571));

s7_N415_8 :=  __common__( if(((real)age < 76.5), -0.011608271, 0.02299242));

s7_N415_7 :=  __common__( map(trim(C_LOWRENT) = ''     => 0.0041776878,
              ((real)c_lowrent < 1.85) => 0.039911088,
                                          0.0041776878));

s7_N415_6 :=  __common__( map(trim(C_RNT500_P) = ''      => 0.055319935,
              ((real)c_rnt500_p < 41.15) => s7_N415_7,
                                            0.055319935));

s7_N415_5 :=  __common__( if(((real)c_low_ed < 9.55), -0.029216314, 0.0039303622));

s7_N415_4 :=  __common__( if(trim(C_LOW_ED) != '', s7_N415_5, 0.0076011939));

s7_N415_3 :=  __common__( if(((real)add1_turnover_1yr_in < 1231.5), s7_N415_4, s7_N415_6));

s7_N415_2 :=  __common__( if(((real)_adls_per_addr_cap10 < 1.5), s7_N415_3, -0.00048864756));

s7_N415_1 :=  __common__( if(((integer)add2_avm_med < 700004), s7_N415_2, s7_N415_8));

s7_N416_9 :=  __common__( if(((real)mth_attr_date_last_derog < 63.5), 0.054920044, -0.0029018046));

s7_N416_8 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N416_9, 0.011964933));

s7_N416_7 :=  __common__( if(((real)_rel_felony_count < 0.5), 0.0010789075, s7_N416_8));

s7_N416_6 :=  __common__( map(trim(C_POP_25_34_P) = ''      => 0.039158435,
              ((real)c_pop_25_34_p < 29.15) => s7_N416_7,
                                               0.039158435));

s7_N416_5 :=  __common__( if(((real)_rel_prop_owned_count < 1.5), 0.025007656, -0.0024297136));

s7_N416_4 :=  __common__( if(((real)input_dob_match_level < 4.5), s7_N416_5, s7_N416_6));

s7_N416_3 :=  __common__( if(((real)c_hval_20k_p < 1.85), -0.00042722098, s7_N416_4));

s7_N416_2 :=  __common__( if(trim(C_HVAL_20K_P) != '', s7_N416_3, 0.0065267869));

s7_N416_1 :=  __common__( if(((real)add2_turnover_1yr_in < 4732.5), s7_N416_2, -0.02751408));

s7_N417_9 :=  __common__( if(((real)_addrs_per_adl_c6 < 1.5), -0.027788288, 0.022703754));

s7_N417_8 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '4']) => -0.01005476,
              (prof_license_category in ['5'])                     => 0.15409832,
                                                                      -0.01005476));

s7_N417_7 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N417_8,
              ((real)c_civ_emp < 51.75) => 0.036010018,
                                           s7_N417_8));

s7_N417_6 :=  __common__( map(trim(C_CARTHEFT) = ''      => 0.051995713,
              ((real)c_cartheft < 171.5) => s7_N417_7,
                                            0.051995713));

s7_N417_5 :=  __common__( map(trim(C_HIGH_ED) = ''      => 0.019408242,
              ((real)c_high_ed < 52.25) => 0.0030987165,
                                           0.019408242));

s7_N417_4 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N417_5, -0.0019004661));

s7_N417_3 :=  __common__( map(trim(C_INC_50K_P) = ''      => s7_N417_6,
              ((real)c_inc_50k_p < 22.85) => s7_N417_4,
                                             s7_N417_6));

s7_N417_2 :=  __common__( if(((real)c_easiqlife < 116.5), -0.0016198511, s7_N417_3));

s7_N417_1 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N417_2, s7_N417_9));

s7_N418_10 :=  __common__( map(trim(C_LOWINC) = ''     => 0.0057914765,
               ((real)c_lowinc < 14.3) => 0.091274381,
                                          0.0057914765));

s7_N418_9 :=  __common__( map(trim(C_RECENT_MOV) = ''      => 0.058783767,
              ((real)c_recent_mov < 159.5) => 0.012621275,
                                              0.058783767));

s7_N418_8 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.0082946372,
              ((real)c_civ_emp < 59.85) => s7_N418_9,
                                           0.0082946372));

s7_N418_7 :=  __common__( map(trim(C_RELIG_INDX) = ''      => s7_N418_8,
              ((real)c_relig_indx < 178.5) => 0.0027394645,
                                              s7_N418_8));

s7_N418_6 :=  __common__( map(trim(C_RELIG_INDX) = ''      => -0.022607152,
              ((real)c_relig_indx < 197.5) => s7_N418_7,
                                              -0.022607152));

s7_N418_5 :=  __common__( map(trim(C_SFDU_P) = ''      => s7_N418_10,
              ((real)c_sfdu_p < 97.85) => s7_N418_6,
                                          s7_N418_10));

s7_N418_4 :=  __common__( map(trim(C_INC_150K_P) = ''     => -0.00460091,
              ((real)c_inc_150k_p < 7.25) => s7_N418_5,
                                             -0.00460091));

s7_N418_3 :=  __common__( if(((real)c_low_ed < 64.25), s7_N418_4, -0.0074812328));

s7_N418_2 :=  __common__( if(trim(C_LOW_ED) != '', s7_N418_3, -0.0029910169));

s7_N418_1 :=  __common__( if(((real)add1_building_area2 > NULL), -0.0014841419, s7_N418_2));

s7_N419_9 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.0037324654,
              ((real)c_bel_edu < 112.5) => 0.043336999,
                                           0.0037324654));

s7_N419_8 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.040295129,
              ((real)c_sfdu_p < 83.55) => s7_N419_9,
                                          0.040295129));

s7_N419_7 :=  __common__( map(trim(C_BEL_EDU) = ''      => s7_N419_8,
              ((real)c_bel_edu < 107.5) => 0.00072205154,
                                           s7_N419_8));

s7_N419_6 :=  __common__( map(trim(C_VACANT_P) = ''     => 0.053962567,
              ((real)c_vacant_p < 6.85) => 0.0093768165,
                                           0.053962567));

s7_N419_5 :=  __common__( map(trim(C_MORT_INDX) = ''     => s7_N419_7,
              ((real)c_mort_indx < 20.5) => s7_N419_6,
                                            s7_N419_7));

s7_N419_4 :=  __common__( map(trim(C_HVAL_100K_P) = ''     => s7_N419_5,
              ((real)c_hval_100k_p < 0.95) => -0.0030904443,
                                              s7_N419_5));

s7_N419_3 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N419_4, -8.134653e-005));

s7_N419_2 :=  __common__( if(((real)c_high_ed < 5.45), -0.0069642985, s7_N419_3));

s7_N419_1 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N419_2, -0.0015304935));

s7_N420_9 :=  __common__( if(((real)add_bestmatch_level < 0.5), 0.0029142348, 0.044407007));

s7_N420_8 :=  __common__( if(((real)add1_source_count < 1.5), 0.036644759, 0.010480367));

s7_N420_7 :=  __common__( map(trim(C_RENTAL) = ''      => 0.021008029,
              ((real)c_rental < 183.5) => 0.0021976781,
                                          0.021008029));

s7_N420_6 :=  __common__( map(trim(C_INCOLLEGE) = ''      => -0.024259936,
              ((real)c_incollege < 15.55) => s7_N420_7,
                                             -0.024259936));

s7_N420_5 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N420_6,
              ((real)c_rnt750_p < 29.85) => -0.0048381578,
                                            s7_N420_6));

s7_N420_4 :=  __common__( map(trim(C_MANY_CARS) = ''      => s7_N420_8,
              ((real)c_many_cars < 163.5) => s7_N420_5,
                                             s7_N420_8));

s7_N420_3 :=  __common__( if(((real)add1_building_area2 > NULL), -0.00020206927, s7_N420_4));

s7_N420_2 :=  __common__( if(trim(C_MED_HHINC) != '', s7_N420_3, 0.0076649262));

s7_N420_1 :=  __common__( if(((real)_email_domain_free_count < 3.5), s7_N420_2, s7_N420_9));

s7_N421_10 :=  __common__( map(trim(C_INC_150K_P) = ''     => 0.030713488,
               ((integer)c_inc_150k_p < 6) => -0.026289849,
                                              0.030713488));

s7_N421_9 :=  __common__( map(trim(C_RETIRED2) = ''     => 0.033419954,
              ((real)c_retired2 < 48.5) => s7_N421_10,
                                           0.033419954));

s7_N421_8 :=  __common__( map(trim(C_INC_25K_P) = ''      => 0.012845531,
              ((real)c_inc_25k_p < 21.25) => -0.0075578462,
                                             0.012845531));

s7_N421_7 :=  __common__( if(((integer)add1_turnover_1yr_in < 2071), s7_N421_8, s7_N421_9));

s7_N421_6 :=  __common__( if(((real)_addrs_15yr < 1.5), 0.046298499, -0.01618045));

s7_N421_5 :=  __common__( if(((real)mth_header_first_seen < 274.5), s7_N421_6, 0.041436725));

s7_N421_4 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N421_5, -0.0064636767));

s7_N421_3 :=  __common__( if(((real)_addrs_last36 < 0.5), s7_N421_4, s7_N421_7));

s7_N421_2 :=  __common__( if(((real)c_born_usa < 23.5), s7_N421_3, 0.00087848016));

s7_N421_1 :=  __common__( if(trim(C_BORN_USA) != '', s7_N421_2, 0.0019434774));

s7_N422_9 :=  __common__( if(((real)_rel_homeunder100_count < 1.5), -0.021886581, 0.018466347));

s7_N422_8 :=  __common__( if(((real)add3_naprop < 1.5), s7_N422_9, 0.046603377));

s7_N422_7 :=  __common__( if(((real)_adls_per_addr_c6 < 0.5), -0.015536651, s7_N422_8));

s7_N422_6 :=  __common__( map(trim(C_INC_150K_P) = ''     => s7_N422_7,
              ((real)c_inc_150k_p < 0.45) => -0.028570068,
                                             s7_N422_7));

s7_N422_5 :=  __common__( map(trim(C_SFDU_P) = ''      => 0.030018125,
              ((real)c_sfdu_p < 92.15) => 0.0023667879,
                                          0.030018125));

s7_N422_4 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.00090632251,
              ((real)c_fammar_p < 67.55) => s7_N422_5,
                                            -0.00090632251));

s7_N422_3 :=  __common__( map(trim(C_ASSAULT) = ''      => s7_N422_6,
              ((real)c_assault < 191.5) => s7_N422_4,
                                           s7_N422_6));

s7_N422_2 :=  __common__( if(((real)c_hval_500k_p < 41.1), s7_N422_3, 0.030399203));

s7_N422_1 :=  __common__( if(trim(C_HVAL_500K_P) != '', s7_N422_2, 0.007405114));

s7_N423_10 :=  __common__( map(trim(C_MED_AGE) = ''      => -0.0034845764,
               ((real)c_med_age < 142.5) => 0.0016369273,
                                            -0.0034845764));

s7_N423_9 :=  __common__( map(trim(C_RNT500_P) = ''      => 0.021731766,
              ((real)c_rnt500_p < 16.75) => -0.016935211,
                                            0.021731766));

s7_N423_8 :=  __common__( if(((real)_rel_within25miles_count < 4.5), s7_N423_9, -0.024784647));

s7_N423_7 :=  __common__( map(trim(C_WHITE_COL) = ''      => 0.038827291,
              ((real)c_white_col < 24.05) => -0.00086573232,
                                             0.038827291));

s7_N423_6 :=  __common__( map(trim(C_MED_HVAL) = ''          => s7_N423_8,
              ((integer)c_med_hval < 118476) => s7_N423_7,
                                                s7_N423_8));

s7_N423_5 :=  __common__( map(trim(C_SPAN_LANG) = ''      => s7_N423_6,
              ((real)c_span_lang < 159.5) => -0.019422437,
                                             s7_N423_6));

s7_N423_4 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 407.5), s7_N423_5, 0.027861616));

s7_N423_3 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N423_4, 0.027552622));

s7_N423_2 :=  __common__( if(((real)c_many_cars < 19.5), s7_N423_3, s7_N423_10));

s7_N423_1 :=  __common__( if(trim(C_MANY_CARS) != '', s7_N423_2, 0.0074204909));

s7_N424_9 :=  __common__( if(((real)_num_purchase36 < 0.5), -0.013346762, 0.038377004));

s7_N424_8 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N424_9, 0.31235251));

s7_N424_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N424_8, 0.40626064));

s7_N424_6 :=  __common__( if(((real)_rel_incomeunder25_count < 2.5), -0.016247425, s7_N424_7));

s7_N424_5 :=  __common__( if(((real)rc_addrcount < 3.5), 0.017328674, 0.0008609951));

s7_N424_4 :=  __common__( if(((real)_inq_peraddr_cap8 < 2.5), -0.0032528905, s7_N424_5));

s7_N424_3 :=  __common__( if(((real)_addrs_15yr < 6.5), 0.0023021653, s7_N424_4));

s7_N424_2 :=  __common__( if(((real)c_relig_indx < 194.5), s7_N424_3, s7_N424_6));

s7_N424_1 :=  __common__( if(trim(C_RELIG_INDX) != '', s7_N424_2, -0.0043711269));

s7_N425_9 :=  __common__( map((prof_license_category in ['2', '3'])           => -0.0022963917,
              (prof_license_category in ['0', '1', '4', '5']) => 0.086752206,
                                                                 -0.0022963917));

s7_N425_8 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), 0.036455963, s7_N425_9));

s7_N425_7 :=  __common__( if(((real)add2_nhood_vacant_properties < 3.5), 0.067021437, s7_N425_8));

s7_N425_6 :=  __common__( if(((real)_rel_incomeunder50_count < 4.5), -0.0023973732, s7_N425_7));

s7_N425_5 :=  __common__( map(trim(C_LOW_ED) = ''     => 0.028301896,
              ((real)c_low_ed < 78.8) => 0.00036067081,
                                         0.028301896));

s7_N425_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), -0.00632679, -0.048110399));

s7_N425_3 :=  __common__( map(trim(C_INC_150K_P) = ''     => s7_N425_5,
              ((real)c_inc_150k_p < 0.45) => s7_N425_4,
                                             s7_N425_5));

s7_N425_2 :=  __common__( if(((real)c_low_hval < 72.05), s7_N425_3, s7_N425_6));

s7_N425_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N425_2, -0.0011788684));

s7_N426_8 :=  __common__( if(((real)_addrs_per_adl_c6 < 1.5), 0.015564789, 0.1172634));

s7_N426_7 :=  __common__( map(trim(C_MED_AGE) = ''     => -0.0019315424,
              ((real)c_med_age < 44.5) => 0.056296464,
                                          -0.0019315424));

s7_N426_6 :=  __common__( map(trim(C_MED_AGE) = ''       => 0.071233171,
              ((integer)c_med_age < 122) => s7_N426_7,
                                            0.071233171));

s7_N426_5 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N426_6,
              ((real)c_civ_emp < 78.05) => 0.0043582905,
                                           s7_N426_6));

s7_N426_4 :=  __common__( if(((real)c_hval_100k_p < 33.4), s7_N426_5, s7_N426_8));

s7_N426_3 :=  __common__( if(trim(C_HVAL_100K_P) != '', s7_N426_4, -0.027357075));

s7_N426_2 :=  __common__( if(((integer)add1_avm_med < 202846), -0.0016687756, s7_N426_3));

s7_N426_1 :=  __common__( if(((real)add1_lres < 112.5), -0.001308677, s7_N426_2));

s7_N427_9 :=  __common__( if(((real)_addrs_last24 < 3.5), 0.0097215397, 0.043195463));

s7_N427_8 :=  __common__( map(trim(C_BORN_USA) = ''     => -0.0242957,
              ((real)c_born_usa < 59.5) => s7_N427_9,
                                           -0.0242957));

s7_N427_7 :=  __common__( if(((integer)add1_turnover_1yr_in < 1647), -0.0048119023, s7_N427_8));

s7_N427_6 :=  __common__( map(trim(C_CHILD) = ''      => 0.0043390162,
              ((real)c_child < 27.95) => 0.039572755,
                                         0.0043390162));

s7_N427_5 :=  __common__( map(trim(C_RNT500_P) = ''     => 0.023794904,
              ((real)c_rnt500_p < 50.9) => -0.0024517942,
                                           0.023794904));

s7_N427_4 :=  __common__( if(((real)source_count < 8.5), s7_N427_5, s7_N427_6));

s7_N427_3 :=  __common__( if(((real)input_dob_match_level < 4.5), s7_N427_4, 0.0015400245));

s7_N427_2 :=  __common__( if(((real)c_rentocc_p < 47.05), s7_N427_3, s7_N427_7));

s7_N427_1 :=  __common__( if(trim(C_RENTOCC_P) != '', s7_N427_2, -0.00052118967));

s7_N428_12 :=  __common__( if(((real)c_fammar_p < 79.65), 0.0074029544, 0.046878457));

s7_N428_11 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N428_12, 0.038944431));

s7_N428_10 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((integer)mth_ver_src_fsrc_fdate < 291), s7_N428_11, -0.016762937));

s7_N428_9 :=  __common__( map(trim(C_TOTSALES) = ''        => 0.0044408102,
              ((integer)c_totsales < 2931) => 0.034212107,
                                              0.0044408102));

s7_N428_8 :=  __common__( map(trim(C_BIGAPT_P) = ''      => s7_N428_9,
              ((integer)c_bigapt_p < 33) => 0.0032755475,
                                            s7_N428_9));

s7_N428_7 :=  __common__( if(((real)c_lar_fam < 142.5), -0.0016571568, s7_N428_8));

s7_N428_6 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N428_7, -0.005847619));

s7_N428_5 :=  __common__( if(((real)liens_historical_unreleased_ct < 1.5), s7_N428_6, -0.020100038));

s7_N428_4 :=  __common__( if(((real)_ssn_score < 1.5), s7_N428_5, s7_N428_10));

s7_N428_3 :=  __common__( if(((real)c_hhsize < 1.505), 0.025303246, -0.00011197813));

s7_N428_2 :=  __common__( if(trim(C_HHSIZE) != '', s7_N428_3, -0.010685113));

s7_N428_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N428_2, s7_N428_4));

s7_N429_9 :=  __common__( if(((real)_rel_incomeunder25_count < 3.5), -0.028414889, 0.016735333));

s7_N429_8 :=  __common__( map(trim(C_TOTSALES) = ''        => -0.016456311,
              ((integer)c_totsales < 4163) => 0.024989734,
                                              -0.016456311));

s7_N429_7 :=  __common__( if(((real)add1_source_count < 5.5), -0.026622067, -0.0032934352));

s7_N429_6 :=  __common__( map(trim(C_TOTSALES) = ''       => s7_N429_8,
              ((real)c_totsales < 1424.5) => s7_N429_7,
                                             s7_N429_8));

s7_N429_5 :=  __common__( if(((real)_nap < 3.5), 0.0012805461, 0.012415835));

s7_N429_4 :=  __common__( map(trim(C_NO_MOVE) = ''     => -0.00059558124,
              ((real)c_no_move < 24.5) => s7_N429_5,
                                          -0.00059558124));

s7_N429_3 :=  __common__( map(trim(C_FAMMAR_P) = ''      => -0.014285785,
              ((real)c_fammar_p < 96.35) => s7_N429_4,
                                            -0.014285785));

s7_N429_2 :=  __common__( if(((real)c_lowinc < 74.05), s7_N429_3, s7_N429_6));

s7_N429_1 :=  __common__( if(trim(C_LOWINC) != '', s7_N429_2, s7_N429_9));

s7_N430_9 :=  __common__( if(((real)_rel_homeunder50_count < 3.5), 0.0040713369, 0.040169657));

s7_N430_8 :=  __common__( if(((real)c_pop_18_24_p < 8.95), 0.00032801651, 0.0071392011));

s7_N430_7 :=  __common__( if(trim(C_POP_18_24_P) != '', s7_N430_8, -0.0069732046));

s7_N430_6 :=  __common__( if(((real)_util_adl_count < 1.5), s7_N430_7, -0.0023976304));

s7_N430_5 :=  __common__( if(((real)_ssns_per_adl_c6 < 1.5), s7_N430_6, s7_N430_9));

s7_N430_4 :=  __common__( if(((real)add2_turnover_1yr_in < 240.5), 0.0116161, -0.011668797));

s7_N430_3 :=  __common__( if(((integer)mth_ver_src_fsrc_fdate < 297), s7_N430_4, -0.02476947));

s7_N430_2 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N430_3, 0.039676994));

s7_N430_1 :=  __common__( if((combo_dobscore < 55), s7_N430_2, s7_N430_5));

s7_N431_10 :=  __common__( if(((integer)add1_turnover_1yr_in < 25), 0.042666727, 0.0020315192));

s7_N431_9 :=  __common__( if(trim(C_RETIRED) != '', s7_N431_10, -0.0083301414));

s7_N431_8 :=  __common__( if(((real)add3_lres < 105.5), -0.00023411223, 0.068237866));

s7_N431_7 :=  __common__( if(((real)mth_header_first_seen > NULL), -0.0031151663, 0.23579045));

s7_N431_6 :=  __common__( if(((real)add2_lres < 70.5), 0.083568853, 0.0087972823));

s7_N431_5 :=  __common__( if(((real)add1_building_area2 < 3654.5), 0.0024029043, s7_N431_6));

s7_N431_4 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N431_5, s7_N431_7));

s7_N431_3 :=  __common__( if(((real)add1_avm_to_med_ratio < 1.95051), s7_N431_4, s7_N431_8));

s7_N431_2 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N431_3, s7_N431_9));

s7_N431_1 :=  __common__( if(((real)add2_nhood_vacant_properties < 14.5), s7_N431_2, -0.0023611381));

s7_N432_8 :=  __common__( map(trim(C_HVAL_100K_P) = ''    => 0.045379119,
              ((real)c_hval_100k_p < 1.3) => -0.0060912324,
                                             0.045379119));

s7_N432_7 :=  __common__( map(trim(C_RENTAL) = ''      => s7_N432_8,
              ((real)c_rental < 183.5) => -0.0047871551,
                                          s7_N432_8));

s7_N432_6 :=  __common__( map(trim(C_BORN_USA) = ''     => 0.0012228752,
              ((real)c_born_usa < 22.5) => s7_N432_7,
                                           0.0012228752));

s7_N432_5 :=  __common__( map(trim(C_UNATTACH) = ''     => -0.03003504,
              ((real)c_unattach < 68.5) => -0.00013406391,
                                           -0.03003504));

s7_N432_4 :=  __common__( map(trim(C_RETIRED2) = ''    => s7_N432_6,
              ((real)c_retired2 < 4.5) => s7_N432_5,
                                          s7_N432_6));

s7_N432_3 :=  __common__( if(((real)c_hhsize < 1.395), 0.020810983, s7_N432_4));

s7_N432_2 :=  __common__( if(trim(C_HHSIZE) != '', s7_N432_3, -0.0010014454));

s7_N432_1 :=  __common__( if(((real)add2_lres < 325.5), s7_N432_2, -0.012016854));

s7_N433_11 :=  __common__( map(trim(C_HVAL_80K_P) = ''      => 0.026074052,
               ((real)c_hval_80k_p < 19.65) => -0.012483777,
                                               0.026074052));

s7_N433_10 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '5']) => s7_N433_11,
               (prof_license_category in ['4'])                     => 0.092431709,
                                                                       s7_N433_11));

s7_N433_9 :=  __common__( map(trim(C_UNATTACH) = ''      => s7_N433_10,
              ((real)c_unattach < 151.5) => -0.01362252,
                                            s7_N433_10));

s7_N433_8 :=  __common__( map(trim(C_CHILD) = ''      => 0.038166417,
              ((real)c_child < 38.35) => 0.0051654002,
                                         0.038166417));

s7_N433_7 :=  __common__( if(((integer)add2_avm_med < 53331), s7_N433_8, -0.0007024179));

s7_N433_6 :=  __common__( if(((real)c_hval_60k_p < 32.85), s7_N433_7, s7_N433_9));

s7_N433_5 :=  __common__( if(trim(C_HVAL_60K_P) != '', s7_N433_6, -0.00088085011));

s7_N433_4 :=  __common__( if(((real)c_civ_emp < 55.65), 0.03062636, -0.0017374099));

s7_N433_3 :=  __common__( if(trim(C_CIV_EMP) != '', s7_N433_4, 0.036112297));

s7_N433_2 :=  __common__( if(((real)mth_header_first_seen < 17.5), s7_N433_3, s7_N433_5));

s7_N433_1 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N433_2, -0.0021816906));

s7_N434_10 :=  __common__( map(trim(C_FAMMAR18_P) = ''     => 0.028143941,
               ((real)c_fammar18_p < 34.7) => 0.082065949,
                                              0.028143941));

s7_N434_9 :=  __common__( map(trim(C_NO_MOVE) = ''      => 0.0025779899,
              ((real)c_no_move < 115.5) => s7_N434_10,
                                           0.0025779899));

s7_N434_8 :=  __common__( map(trim(C_WHITE_COL) = ''      => 0.0087762149,
              ((real)c_white_col < 29.55) => s7_N434_9,
                                             0.0087762149));

s7_N434_7 :=  __common__( if(((real)add2_nhood_vacant_properties < 47.5), s7_N434_8, 0.0014152549));

s7_N434_6 :=  __common__( if(((real)add2_nhood_vacant_properties < 40.5), -0.0014783049, s7_N434_7));

s7_N434_5 :=  __common__( map(trim(C_POP_25_34_P) = ''      => -0.012016943,
              ((real)c_pop_25_34_p < 15.35) => 0.029550311,
                                               -0.012016943));

s7_N434_4 :=  __common__( if(((integer)add3_avm_automated_valuation < 61768), -0.011869618, s7_N434_5));

s7_N434_3 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 43.5), s7_N434_4, s7_N434_6));

s7_N434_2 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N434_3, 0.0076809349));

s7_N434_1 :=  __common__( if(trim(C_UNEMP) != '', s7_N434_2, -0.0012944452));

s7_N435_10 :=  __common__( if(((real)_addrs_last90 < 0.5), 0.029903964, -0.017013702));

s7_N435_9 :=  __common__( map(trim(C_EASIQLIFE) = ''     => s7_N435_10,
              ((real)c_easiqlife < 86.5) => 0.046882954,
                                            s7_N435_10));

s7_N435_8 :=  __common__( if(((real)add2_lres < 126.5), s7_N435_9, -0.0053826603));

s7_N435_7 :=  __common__( map(trim(C_MED_AGE) = ''     => s7_N435_8,
              ((real)c_med_age < 19.5) => 0.045498413,
                                          s7_N435_8));

s7_N435_6 :=  __common__( map(trim(C_EDU_INDX) = ''       => -0.013896491,
              ((integer)c_edu_indx < 140) => s7_N435_7,
                                             -0.013896491));

s7_N435_5 :=  __common__( map(trim(C_EASIQLIFE) = ''     => s7_N435_6,
              ((real)c_easiqlife < 73.5) => -0.018919673,
                                            s7_N435_6));

s7_N435_4 :=  __common__( if(((real)c_sfdu_p < 3.35), s7_N435_5, -0.00047697041));

s7_N435_3 :=  __common__( if(trim(C_SFDU_P) != '', s7_N435_4, 0.0032206174));

s7_N435_2 :=  __common__( if(((integer)add1_building_area2 < 9899), 8.917677e-005, -0.014609299));

s7_N435_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N435_2, s7_N435_3));

s7_N436_10 :=  __common__( map(trim(C_INC_50K_P) = ''      => -0.0097529362,
               ((real)c_inc_50k_p < 25.35) => 0.046551648,
                                              -0.0097529362));

s7_N436_9 :=  __common__( if(((real)_rel_homeunder100_count < 4.5), -0.009226149, 0.041345393));

s7_N436_8 :=  __common__( map(trim(C_ROBBERY) = ''      => 0.055771206,
              ((real)c_robbery < 168.5) => s7_N436_9,
                                           0.055771206));

s7_N436_7 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N436_8, s7_N436_10));

s7_N436_6 :=  __common__( map(trim(C_EASIQLIFE) = ''     => 0.0030787991,
              ((real)c_easiqlife < 43.5) => 0.031602101,
                                            0.0030787991));

s7_N436_5 :=  __common__( map(trim(C_LOWRENT) = ''      => -0.0017435782,
              ((real)c_lowrent < 22.65) => s7_N436_6,
                                           -0.0017435782));

s7_N436_4 :=  __common__( map(trim(C_RNT750_P) = ''      => -0.013851608,
              ((real)c_rnt750_p < 75.25) => s7_N436_5,
                                            -0.013851608));

s7_N436_3 :=  __common__( map(trim(C_INC_50K_P) = ''      => s7_N436_7,
              ((real)c_inc_50k_p < 24.45) => s7_N436_4,
                                             s7_N436_7));

s7_N436_2 :=  __common__( if(((real)c_high_ed < 2.35), -0.014236819, s7_N436_3));

s7_N436_1 :=  __common__( if(trim(C_HIGH_ED) != '', s7_N436_2, 0.0071743645));

s7_N437_12 :=  __common__( if(((real)c_retired2 < 111.5), 0.023499746, 0.0014440406));

s7_N437_11 :=  __common__( if(trim(C_RETIRED2) != '', s7_N437_12, -0.027672961));

s7_N437_10 :=  __common__( if(((real)age < 30.5), -0.0065512517, s7_N437_11));

s7_N437_9 :=  __common__( if(((real)_phones_per_addr_c6 < 1.5), -0.0013800594, s7_N437_10));

s7_N437_8 :=  __common__( map(trim(C_TOTSALES) = ''         => -0.0014388397,
              ((integer)c_totsales < 15265) => 0.04357788,
                                               -0.0014388397));

s7_N437_7 :=  __common__( if(((real)add1_avm_to_med_ratio < 1.11235), -0.01021072, 0.069973878));

s7_N437_6 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N437_7, 0.023053909));

s7_N437_5 :=  __common__( map(trim(C_BURGLARY) = ''    => -0.00077233143,
              ((real)c_burglary < 1.5) => s7_N437_6,
                                          -0.00077233143));

s7_N437_4 :=  __common__( if(((real)c_ownocc_p < 24.45), -0.011813486, s7_N437_5));

s7_N437_3 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N437_4, -0.0054302632));

s7_N437_2 :=  __common__( if(((integer)add1_building_area2 < 107385), s7_N437_3, s7_N437_8));

s7_N437_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N437_2, s7_N437_9));

s7_N438_8 :=  __common__( if(((real)_inq_perssn < 2.5), -0.00091768816, 0.010918145));

s7_N438_7 :=  __common__( map(trim(C_RNT250_P) = ''     => 0.032726147,
              ((real)c_rnt250_p < 36.8) => -0.0095270031,
                                           0.032726147));

s7_N438_6 :=  __common__( map(trim(C_LARCENY) = ''      => 0.028426138,
              ((real)c_larceny < 160.5) => s7_N438_7,
                                           0.028426138));

s7_N438_5 :=  __common__( if(((real)c_span_lang < 173.5), s7_N438_6, 0.032327752));

s7_N438_4 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N438_5, 0.03580736));

s7_N438_3 :=  __common__( if(((real)_ssns_per_adl_c6 < 0.5), -0.0084921491, s7_N438_4));

s7_N438_2 :=  __common__( if(((real)_wealth_index < 1.5), s7_N438_3, s7_N438_8));

s7_N438_1 :=  __common__( if(((real)add3_source_count < 10.5), s7_N438_2, 0.031591572));

s7_N439_10 :=  __common__( if(((real)combo_dobcount < 3.5), 0.071716452, 0.0096636803));

s7_N439_9 :=  __common__( if(((real)_inq_collection_count < 1.5), 0.0035214026, 0.055344141));

s7_N439_8 :=  __common__( map(trim(C_EASIQLIFE) = ''     => -0.0068273708,
              ((real)c_easiqlife < 71.5) => s7_N439_9,
                                            -0.0068273708));

s7_N439_7 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N439_10,
              ((real)c_civ_emp < 67.95) => s7_N439_8,
                                           s7_N439_10));

s7_N439_6 :=  __common__( if(((real)ssn_lowissue_age < 5.52848), 0.014313777, 0.072456797));

s7_N439_5 :=  __common__( if(((real)ssn_lowissue_age < 6.26232), s7_N439_6, s7_N439_7));

s7_N439_4 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N439_5, -0.019535087));

s7_N439_3 :=  __common__( map(trim(C_RECENT_MOV) = ''     => -0.0010345092,
              ((real)c_recent_mov < 31.5) => s7_N439_4,
                                             -0.0010345092));

s7_N439_2 :=  __common__( if(((real)c_murders < 198.5), s7_N439_3, 0.020107613));

s7_N439_1 :=  __common__( if(trim(C_MURDERS) != '', s7_N439_2, -0.0079779717));

s7_N440_9 :=  __common__( map(trim(C_RENTAL) = ''      => -0.003945268,
              ((integer)c_rental < 63) => 0.036600369,
                                          -0.003945268));

s7_N440_8 :=  __common__( map(trim(C_BEL_EDU) = ''      => s7_N440_9,
              ((real)c_bel_edu < 193.5) => -0.0084447572,
                                           s7_N440_9));

s7_N440_7 :=  __common__( map(trim(C_MED_RENT) = ''      => 0.058886146,
              ((real)c_med_rent < 985.5) => -0.0086318684,
                                            0.058886146));

s7_N440_6 :=  __common__( map(trim(C_UNEMPL) = ''     => s7_N440_7,
              ((real)c_unempl < 59.5) => -0.01444076,
                                         s7_N440_7));

s7_N440_5 :=  __common__( map(trim(C_SPAN_LANG) = ''     => -0.00056157515,
              ((real)c_span_lang < 76.5) => 0.059443569,
                                            -0.00056157515));

s7_N440_4 :=  __common__( if((add1_avm_automated_valuation < 109026), s7_N440_5, s7_N440_6));

s7_N440_3 :=  __common__( map(trim(C_POP_18_24_P) = ''     => s7_N440_8,
              ((real)c_pop_18_24_p < 3.95) => s7_N440_4,
                                              s7_N440_8));

s7_N440_2 :=  __common__( if(((real)c_femdiv_p < 2.15), s7_N440_3, 0.0010945636));

s7_N440_1 :=  __common__( if(trim(C_FEMDIV_P) != '', s7_N440_2, -0.0070733689));

s7_N441_9 :=  __common__( if(((real)input_dob_match_level < 7.5), 0.0096238022, -0.0155463));

s7_N441_8 :=  __common__( map(trim(C_LARCENY) = ''      => 0.020545334,
              ((real)c_larceny < 118.5) => -0.0035592994,
                                           0.020545334));

s7_N441_7 :=  __common__( map(trim(C_POP_25_34_P) = ''      => 0.028312756,
              ((real)c_pop_25_34_p < 19.65) => s7_N441_8,
                                               0.028312756));

s7_N441_6 :=  __common__( map(trim(C_FOR_SALE) = ''     => s7_N441_9,
              ((real)c_for_sale < 93.5) => s7_N441_7,
                                           s7_N441_9));

s7_N441_5 :=  __common__( if(((integer)add1_avm_med < 331556), -0.0045469167, -0.02922324));

s7_N441_4 :=  __common__( map(trim(C_BLUE_COL) = ''     => s7_N441_6,
              ((real)c_blue_col < 7.15) => s7_N441_5,
                                           s7_N441_6));

s7_N441_3 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N441_4, 0.0024599621));

s7_N441_2 :=  __common__( if(((real)c_inc_35k_p < 13.75), s7_N441_3, -0.0044864483));

s7_N441_1 :=  __common__( if(trim(C_INC_35K_P) != '', s7_N441_2, 0.00030175332));

s7_N442_12 :=  __common__( map(trim(C_MED_AGE) = ''     => 0.0046145639,
               ((real)c_med_age < 28.5) => -0.020354792,
                                           0.0046145639));

s7_N442_11 :=  __common__( if(((real)c_sfdu_p < 16.5), 0.030126793, s7_N442_12));

s7_N442_10 :=  __common__( if(trim(C_SFDU_P) != '', s7_N442_11, 0.0001379365));

s7_N442_9 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N442_10, -0.0004803127));

s7_N442_8 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => 0.053041917,
              ((real)c_asian_lang < 116.5) => 0.0027523225,
                                              0.053041917));

s7_N442_7 :=  __common__( map(trim(C_VACANT_P) = ''      => s7_N442_8,
              ((real)c_vacant_p < 11.25) => 0.068486674,
                                            s7_N442_8));

s7_N442_6 :=  __common__( if(((real)c_vacant_p < 10.05), -0.0011915192, s7_N442_7));

s7_N442_5 :=  __common__( if(trim(C_VACANT_P) != '', s7_N442_6, -0.026370499));

s7_N442_4 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N442_5, s7_N442_9));

s7_N442_3 :=  __common__( if(((real)mth_header_first_seen < 504.5), s7_N442_4, 0.044320031));

s7_N442_2 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N442_3, 0.019521032));

s7_N442_1 :=  __common__( if(((real)add1_avm_med < 99503.5), s7_N442_2, -0.0011006234));

s7_N443_9 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => 0.036407552,
              ((real)c_asian_lang < 176.5) => 0.0038401679,
                                              0.036407552));
s7_N443_8 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((integer)mth_ver_src_fsrc_fdate < 349), s7_N443_9, 0.058711637));
s7_N443_7 :=  __common__( if(((real)add2_naprop < 0.5), 0.036943641, -0.013652016));
s7_N443_6 :=  __common__( if(((real)add1_building_area2 > NULL), 0.012450627, s7_N443_7));
s7_N443_5 :=  __common__( if(((real)avg_lres < 77.5), s7_N443_6, -0.011925741));
s7_N443_4 :=  __common__( map(trim(C_RNT750_P) = ''     => s7_N443_8,
              ((real)c_rnt750_p < 33.9) => s7_N443_5,
                                           s7_N443_8));
s7_N443_3 :=  __common__( if(((real)c_rental < 183.5), -0.0010855196, s7_N443_4));
s7_N443_2 :=  __common__( if(trim(C_RENTAL) != '', s7_N443_3, -0.001955362));
s7_N443_1 :=  __common__( if(((real)age < 89.5), s7_N443_2, -0.016508378));

s7_N444_12 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.060988459,
               ((real)c_relig_indx < 141.5) => 0.010682494,
                                               0.060988459));
s7_N444_11 :=  __common__( if(((real)c_pop_18_24_p < 6.25), -0.013658579, s7_N444_12));
s7_N444_10 :=  __common__( if(trim(C_POP_18_24_P) != '', s7_N444_11, -0.026059443));
s7_N444_9 :=  __common__( if(((real)c_bigapt_p < 16.35), -0.00018878593, 0.0047908088));
s7_N444_8 :=  __common__( if(trim(C_BIGAPT_P) != '', s7_N444_9, -0.00017876656));
s7_N444_7 :=  __common__( if(((real)c_white_col < 33.4), 0.035858529, -0.0068190234));
s7_N444_6 :=  __common__( if(trim(C_WHITE_COL) != '', s7_N444_7, -0.025936583));
s7_N444_5 :=  __common__( if(((real)age < 73.5), -0.011239481, s7_N444_6));
s7_N444_4 :=  __common__( if(((real)_phones_per_adl_c6 < 1.5), s7_N444_5, 0.025669132));
s7_N444_3 :=  __common__( if(((real)_infutor_nap < 1.5), s7_N444_4, s7_N444_8));
s7_N444_2 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 545.5), s7_N444_3, s7_N444_10));
s7_N444_1 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N444_2, 0.0063566603));

s7_N445_9 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.026822001, -0.0011805872));

s7_N445_8 :=  __common__( if(((real)avg_lres < 68.5), -0.0010618956, 0.007110893));

s7_N445_7 :=  __common__( if(((real)c_murders < 92.5), 0.026242066, 0.0011666779));

s7_N445_6 :=  __common__( if(trim(C_MURDERS) != '', s7_N445_7, 0.053286415));

s7_N445_5 :=  __common__( if((combo_dobscore < 65), s7_N445_6, s7_N445_8));

s7_N445_4 :=  __common__( if(((real)c_trailer_p < 5.45), -0.015654176, 0.017993822));

s7_N445_3 :=  __common__( if(trim(C_TRAILER_P) != '', s7_N445_4, -0.02568506));

s7_N445_2 :=  __common__( if(((real)_infutor_nap < 1.5), s7_N445_3, s7_N445_5));

s7_N445_1 :=  __common__( if(((real)combo_hphonecount < 0.5), s7_N445_2, s7_N445_9));

s7_N446_9 :=  __common__( if(((real)combined_age < 47.5), 0.03873528, 0.00099122162));

s7_N446_8 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), -0.03009657, 0.002732113));

s7_N446_7 :=  __common__( if(((real)c_span_lang < 122.5), s7_N446_8, s7_N446_9));

s7_N446_6 :=  __common__( if(trim(C_SPAN_LANG) != '', s7_N446_7, 0.038081352));

s7_N446_5 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), 0.0061141806, 0.035939781));

s7_N446_4 :=  __common__( map(trim(C_EDU_INDX) = ''      => s7_N446_5,
              ((real)c_edu_indx < 142.5) => 0.0003595004,
                                            s7_N446_5));

s7_N446_3 :=  __common__( if(((real)c_edu_indx < 160.5), s7_N446_4, -0.01316748));

s7_N446_2 :=  __common__( if(trim(C_EDU_INDX) != '', s7_N446_3, -0.0037259692));

s7_N446_1 :=  __common__( if(((real)_ssn_score < 1.5), s7_N446_2, s7_N446_6));

s7_N447_8 :=  __common__( map(trim(C_BEL_EDU) = ''      => -0.037752935,
              ((real)c_bel_edu < 183.5) => -0.011723394,
                                           -0.037752935));

s7_N447_7 :=  __common__( map(trim(C_AB_AV_EDU) = ''     => s7_N447_8,
              ((real)c_ab_av_edu < 37.5) => 0.013259266,
                                            s7_N447_8));

s7_N447_6 :=  __common__( map(trim(C_YOUNG) = ''      => 0.0351721,
              ((real)c_young < 52.15) => 0.0054875221,
                                         0.0351721));

s7_N447_5 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N447_6,
              ((real)c_rnt750_p < 55.05) => 0.00014390208,
                                            s7_N447_6));

s7_N447_4 :=  __common__( if(((real)c_assault < 189.5), s7_N447_5, s7_N447_7));

s7_N447_3 :=  __common__( if(trim(C_ASSAULT) != '', s7_N447_4, -0.0055461818));

s7_N447_2 :=  __common__( if(((real)_adls_per_addr_cap10 < 8.5), 0.028813764, -0.0017530732));

s7_N447_1 :=  __common__( if((combo_dobscore < 45), s7_N447_2, s7_N447_3));

s7_N448_9 :=  __common__( if(((real)c_highinc < 74.5), 0.00011846173, 0.037645837));

s7_N448_8 :=  __common__( if(trim(C_HIGHINC) != '', s7_N448_9, -0.013795765));

s7_N448_7 :=  __common__( map(trim(C_UNEMP) = ''     => -0.023899096,
              ((real)c_unemp < 2.05) => -5.4180215e-005,
                                        -0.023899096));

s7_N448_6 :=  __common__( if(((real)add2_turnover_1yr_in < 294.5), 0.013325862, -0.012026429));

s7_N448_5 :=  __common__( map(trim(C_RETIRED) = ''      => s7_N448_7,
              ((real)c_retired < 10.65) => s7_N448_6,
                                           s7_N448_7));

s7_N448_4 :=  __common__( if((add2_avm_automated_valuation < 251837), s7_N448_5, -0.028638734));

s7_N448_3 :=  __common__( if(((real)c_born_usa < 8.5), 0.016356162, s7_N448_4));

s7_N448_2 :=  __common__( if(trim(C_BORN_USA) != '', s7_N448_3, -0.034371532));

s7_N448_1 :=  __common__( if(((real)_ssncount < 1.5), s7_N448_2, s7_N448_8));

s7_N449_9 :=  __common__( if(((real)add1_source_count < 4.5), 0.041125178, 0.0078150729));

s7_N449_8 :=  __common__( map(trim(C_APT20) = ''      => 0.044242562,
              ((integer)c_apt20 < 99) => 0.0065942878,
                                         0.044242562));

s7_N449_7 :=  __common__( if(((real)add1_building_area2 < 2424.5), 0.0050086494, 0.04795949));

s7_N449_6 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N449_7, -0.0025932036));

s7_N449_5 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N449_6, -0.0068114768));

s7_N449_4 :=  __common__( if(((real)c_hval_60k_p < 19.5), s7_N449_5, s7_N449_8));

s7_N449_3 :=  __common__( if(trim(C_HVAL_60K_P) != '', s7_N449_4, -0.010561927));

s7_N449_2 :=  __common__( if(((real)age < 67.5), s7_N449_3, s7_N449_9));

s7_N449_1 :=  __common__( if(((real)rc_dirsaddr_lastscore < 20.5), s7_N449_2, -0.00070974511));

s7_N450_11 :=  __common__( map(trim(C_MANY_CARS) = ''      => -0.0080252227,
               ((real)c_many_cars < 132.5) => 0.058709857,
                                              -0.0080252227));

s7_N450_10 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.00096786083,
               ((real)c_incollege < 1.95) => s7_N450_11,
                                             0.00096786083));

s7_N450_9 :=  __common__( map(trim(C_CHILD) = ''      => -0.018750875,
              ((real)c_child < 30.75) => s7_N450_10,
                                         -0.018750875));

s7_N450_8 :=  __common__( map(trim(C_UNEMPL) = ''      => 0.036873658,
              ((real)c_unempl < 177.5) => -0.0036872668,
                                          0.036873658));

s7_N450_7 :=  __common__( if(((real)add1_avm_to_med_ratio < 0.482976), 0.042041222, s7_N450_8));

s7_N450_6 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N450_7, s7_N450_9));

s7_N450_5 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N450_6, 0.00055429319));

s7_N450_4 :=  __common__( map(trim(C_OWNOCC_P) = ''     => s7_N450_5,
              ((real)c_ownocc_p < 3.25) => 0.019325938,
                                           s7_N450_5));

s7_N450_3 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => -0.014470007,
              (prof_license_category in ['0'])                     => 0.082618646,
                                                                      -0.014470007));

s7_N450_2 :=  __common__( if(((real)c_ownocc_p < 1.35), s7_N450_3, s7_N450_4));

s7_N450_1 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N450_2, 0.0024917087));

s7_N451_10 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => 0.013155613,
               ((real)c_fammar18_p < 26.45) => 0.034200767,
                                               0.013155613));

s7_N451_9 :=  __common__( map(trim(C_APT20) = ''      => s7_N451_10,
              ((real)c_apt20 < 182.5) => -0.020225958,
                                         s7_N451_10));

s7_N451_8 :=  __common__( map(trim(C_VACANT_P) = ''     => 0.034555822,
              ((real)c_vacant_p < 11.2) => -0.00086382235,
                                           0.034555822));

s7_N451_7 :=  __common__( map(trim(C_TOTSALES) = ''        => 0.032135214,
              ((real)c_totsales < 24690.5) => -0.0073441208,
                                              0.032135214));

s7_N451_6 :=  __common__( map(trim(C_RENTOCC_P) = ''     => 0.044188956,
              ((real)c_rentocc_p < 61.5) => s7_N451_7,
                                            0.044188956));

s7_N451_5 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N451_6, s7_N451_8));

s7_N451_4 :=  __common__( map(trim(C_EASIQLIFE) = ''     => s7_N451_5,
              ((real)c_easiqlife < 44.5) => 0.04231785,
                                            s7_N451_5));

s7_N451_3 :=  __common__( if(((real)_addrs_last36 < 0.5), s7_N451_4, -0.0012692387));

s7_N451_2 :=  __common__( if(((real)c_rentocc_p < 94.25), s7_N451_3, s7_N451_9));

s7_N451_1 :=  __common__( if(trim(C_RENTOCC_P) != '', s7_N451_2, 0.006482647));

s7_N452_9 :=  __common__( if((combo_dobscore < 65), 0.017868118, 0.0038216761));

s7_N452_8 :=  __common__( if(((integer)add2_avm_med < 79560), s7_N452_9, -0.0012115552));

s7_N452_7 :=  __common__( if(((real)add2_nhood_vacant_properties < 100.5), -0.023299052, 0.0033846767));

s7_N452_6 :=  __common__( map(trim(C_HIGH_ED) = ''     => 0.011529397,
              ((real)c_high_ed < 9.95) => -0.014082667,
                                          0.011529397));

s7_N452_5 :=  __common__( map(trim(C_BEL_EDU) = ''      => s7_N452_6,
              ((real)c_bel_edu < 124.5) => 0.018063688,
                                           s7_N452_6));

s7_N452_4 :=  __common__( map(trim(C_RENTAL) = ''      => s7_N452_7,
              ((real)c_rental < 154.5) => s7_N452_5,
                                          s7_N452_7));

s7_N452_3 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N452_4, -0.063218445));

s7_N452_2 :=  __common__( if(((real)c_fammar_p < 41.35), s7_N452_3, s7_N452_8));

s7_N452_1 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N452_2, 0.0082815785));

s7_N453_9 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.0087974256,
              ((real)c_low_ed < 20.85) => 0.057338658,
                                          0.0087974256));

s7_N453_8 :=  __common__( if(((real)add1_nhood_vacant_properties < 0.5), 0.079454596, s7_N453_9));

s7_N453_7 :=  __common__( if(((integer)add2_avm_med < 314851), 0.002287662, s7_N453_8));

s7_N453_6 :=  __common__( if(((real)c_hval_500k_p < 6.95), s7_N453_7, -0.013953646));

s7_N453_5 :=  __common__( if(trim(C_HVAL_500K_P) != '', s7_N453_6, -0.027978313));

s7_N453_4 :=  __common__( if(((real)_altlname < 0.5), 0.00053940851, s7_N453_5));

s7_N453_3 :=  __common__( if(((integer)c_totsales < 250281), -0.011452354, 0.032627821));

s7_N453_2 :=  __common__( if(trim(C_TOTSALES) != '', s7_N453_3, -0.028526291));

s7_N453_1 :=  __common__( map((prof_license_category in ['1', '2', '3', '5']) => s7_N453_2,
              (prof_license_category in ['0', '4'])           => s7_N453_4,
                                                                 s7_N453_4));

s7_N454_10 :=  __common__( if(mth_ver_src_fsrc_fdate != null and ((integer)mth_ver_src_fsrc_fdate < 233), 0.034014039, -0.0050580978));
s7_N454_9 :=  __common__( if(((real)liens_historical_unreleased_ct < 1.5), 0.00054644164, -0.02128753));
s7_N454_8 :=  __common__( if(((real)add3_lres < 445.5), s7_N454_9, 0.03927623));
s7_N454_7 :=  __common__( if(((real)_ssn_score < 1.5), s7_N454_8, s7_N454_10));
s7_N454_6 :=  __common__( if(((real)rc_lnamecount < 9.5), -0.0028279332, -0.025053598));
s7_N454_5 :=  __common__( if((combo_dobscore < 92), s7_N454_6, -8.3274436e-005));
s7_N454_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N454_5, s7_N454_7));
s7_N454_3 :=  __common__( map(trim(C_MURDERS) = ''      => 0.026516891,
              ((real)c_murders < 199.5) => s7_N454_4,
                                           0.026516891));
s7_N454_2 :=  __common__( if(((real)c_lowinc < 88.1), s7_N454_3, 0.01819466));
s7_N454_1 :=  __common__( if(trim(C_LOWINC) != '', s7_N454_2, -0.0089648833));

s7_N455_9 :=  __common__( if(((real)_rel_bankrupt_count < 0.5), -0.010375742, -0.035340342));

s7_N455_8 :=  __common__( map(trim(C_RENTOCC_P) = ''      => 0.03385488,
              ((real)c_rentocc_p < 13.35) => 0.0078230422,
                                             0.03385488));

s7_N455_7 :=  __common__( map(trim(C_AB_AV_EDU) = ''     => s7_N455_8,
              ((real)c_ab_av_edu < 80.5) => -0.0055165821,
                                            s7_N455_8));

s7_N455_6 :=  __common__( map(trim(C_RENTAL) = ''      => -0.0081216056,
              ((real)c_rental < 122.5) => s7_N455_7,
                                          -0.0081216056));

s7_N455_5 :=  __common__( if(((real)c_vacant_p < 2.35), -0.014082432, s7_N455_6));

s7_N455_4 :=  __common__( if(trim(C_VACANT_P) != '', s7_N455_5, -0.026681164));

s7_N455_3 :=  __common__( if(((real)mth_header_first_seen < 318.5), s7_N455_4, s7_N455_9));

s7_N455_2 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N455_3, 0.0085962997));

s7_N455_1 :=  __common__( if(((real)input_dob_match_level < 5.5), s7_N455_2, -0.0001818939));

s7_N456_11 :=  __common__( map(trim(C_RENTAL) = ''      => 0.046374985,
               ((real)c_rental < 174.5) => 0.00047717645,
                                           0.046374985));

s7_N456_10 :=  __common__( map(trim(C_FAMMAR_P) = ''      => 0.018849528,
               ((real)c_fammar_p < 85.85) => 0.094583499,
                                             0.018849528));

s7_N456_9 :=  __common__( map(trim(C_INC_201K_P) = ''     => s7_N456_10,
              ((real)c_inc_201k_p < 5.05) => 0.0075209342,
                                             s7_N456_10));

s7_N456_8 :=  __common__( if(((real)add3_lres < 115.5), -0.0013340154, 0.065548395));

s7_N456_7 :=  __common__( if(((real)_inq_count < 2.5), -0.0050756378, s7_N456_8));

s7_N456_6 :=  __common__( map(trim(C_CIV_EMP) = ''      => s7_N456_9,
              ((real)c_civ_emp < 68.75) => s7_N456_7,
                                           s7_N456_9));

s7_N456_5 :=  __common__( map(trim(C_RETIRED) = ''     => s7_N456_6,
              ((real)c_retired < 6.25) => -0.010294526,
                                          s7_N456_6));

s7_N456_4 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N456_5, s7_N456_11));

s7_N456_3 :=  __common__( if(((real)c_lowrent < 7.75), s7_N456_4, -0.0041735847));

s7_N456_2 :=  __common__( if(trim(C_LOWRENT) != '', s7_N456_3, 0.016587938));

s7_N456_1 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s7_N456_2, -0.00027919336));

s7_N457_12 :=  __common__( if(((real)c_retired < 9.95), -0.01366178, 0.0048133627));

s7_N457_11 :=  __common__( if(trim(C_RETIRED) != '', s7_N457_12, -0.028181311));

s7_N457_10 :=  __common__( if(((real)_rel_criminal_total < 2.5), 0.0051083601, 0.067731058));

s7_N457_9 :=  __common__( map(trim(C_UNATTACH) = ''      => s7_N457_10,
              ((integer)c_unattach < 88) => -0.0087143477,
                                            s7_N457_10));

s7_N457_8 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => s7_N457_9,
              (prof_license_category in ['2'])                     => 0.32389066,
                                                                      s7_N457_9));

s7_N457_7 :=  __common__( if(((integer)add3_eda_sourced < 0.5), -0.0019483945, s7_N457_8));

s7_N457_6 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N457_7, s7_N457_11));

s7_N457_5 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.039530482,
              ((real)c_low_ed < 51.15) => -0.0054279085,
                                          0.039530482));

s7_N457_4 :=  __common__( if(((real)c_lar_fam < 137.5), s7_N457_5, 0.057938587));

s7_N457_3 :=  __common__( if(trim(C_LAR_FAM) != '', s7_N457_4, -0.031176066));

s7_N457_2 :=  __common__( if(((real)add2_turnover_1yr_in < 90.5), s7_N457_3, s7_N457_6));

s7_N457_1 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N457_2, -9.0763378e-005));

s7_N458_8 :=  __common__( map(trim(C_MORT_INDX) = ''     => 0.02423026,
              ((real)c_mort_indx < 51.5) => 0.092307559,
                                            0.02423026));

s7_N458_7 :=  __common__( if(((real)add2_turnover_1yr_in < 2186.5), 0.049538707, -0.010479042));

s7_N458_6 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => s7_N458_8,
              ((real)c_asian_lang < 156.5) => s7_N458_7,
                                              s7_N458_8));

s7_N458_5 :=  __common__( if(((real)combined_age < 56.5), 0.0063047845, 0.037995648));

s7_N458_4 :=  __common__( if(((real)c_born_usa < 50.5), s7_N458_5, -0.010172305));

s7_N458_3 :=  __common__( if(trim(C_BORN_USA) != '', s7_N458_4, 0.036757834));

s7_N458_2 :=  __common__( if(((real)_util_adl_nap < 3.5), s7_N458_3, s7_N458_6));

s7_N458_1 :=  __common__( if(((real)add2_turnover_1yr_in < 1822.5), -0.00033613444, s7_N458_2));

s7_N459_8 :=  __common__( map(trim(C_MED_INC) = ''      => 0.019971325,
              ((real)c_med_inc < 137.5) => -0.016888583,
                                           0.019971325));

s7_N459_7 :=  __common__( map(trim(C_MED_INC) = ''     => 0.055021567,
              ((real)c_med_inc < 87.5) => -0.0062785195,
                                          0.055021567));

s7_N459_6 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.064390743,
              ((real)c_low_ed < 62.65) => s7_N459_7,
                                          0.064390743));

s7_N459_5 :=  __common__( if(((real)_rel_educationunder8_count < 1.5), -0.011212274, s7_N459_6));

s7_N459_4 :=  __common__( map((prof_license_category in ['1', '2', '3', '4', '5']) => s7_N459_5,
              (prof_license_category in ['0'])                     => 0.21047716,
                                                                      s7_N459_5));

s7_N459_3 :=  __common__( if(((real)c_ab_av_edu < 84.5), s7_N459_4, s7_N459_8));

s7_N459_2 :=  __common__( if(trim(C_AB_AV_EDU) != '', s7_N459_3, 0.022723449));

s7_N459_1 :=  __common__( if(((real)_rel_bankrupt_count < 4.5), -0.00039207109, s7_N459_2));

s7_N460_8 :=  __common__( if(((real)add2_nhood_vacant_properties < 3.5), 0.03491373, 0.0056288548));

s7_N460_7 :=  __common__( if(((real)rc_fnamecount < 4.5), s7_N460_8, 0.0035414465));

s7_N460_6 :=  __common__( if(((real)c_pop_18_24_p < 8.95), 0.00036878964, s7_N460_7));

s7_N460_5 :=  __common__( if(trim(C_POP_18_24_P) != '', s7_N460_6, 0.0020900639));

s7_N460_4 :=  __common__( if(((real)combined_age < 20.5), -0.0090333415, -0.033001737));

s7_N460_3 :=  __common__( if(((real)_ssncount < 1.5), s7_N460_4, -0.0072234395));

s7_N460_2 :=  __common__( if(((real)_addrs_last36 < 0.5), 0.019156408, s7_N460_3));

s7_N460_1 :=  __common__( if(((real)age < 23.5), s7_N460_2, s7_N460_5));

s7_N461_9 :=  __common__( if(((real)c_pop_18_24_p < 9.55), 0.0065539917, 0.039633932));

s7_N461_8 :=  __common__( if(trim(C_POP_18_24_P) != '', s7_N461_9, -0.0041128756));

s7_N461_7 :=  __common__( if(((real)rc_fnamecount < 4.5), s7_N461_8, -0.0041172068));

s7_N461_6 :=  __common__( map(trim(C_HVAL_40K_P) = ''     => 0.010875381,
              ((real)c_hval_40k_p < 3.85) => 0.064119802,
                                             0.010875381));

s7_N461_5 :=  __common__( if(((real)add2_nhood_vacant_properties < 152.5), 0.0083637815, s7_N461_6));

s7_N461_4 :=  __common__( map(trim(C_ROBBERY) = ''      => s7_N461_5,
              ((real)c_robbery < 145.5) => -0.0035314225,
                                           s7_N461_5));

s7_N461_3 :=  __common__( if(((real)c_fammar_p < 59.75), s7_N461_4, 0.001594954));

s7_N461_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N461_3, 0.0013245065));

s7_N461_1 :=  __common__( if(((real)_addrs_15yr < 8.5), s7_N461_2, s7_N461_7));

s7_N462_9 :=  __common__( map(trim(C_LOW_ED) = ''      => -0.014393841,
              ((integer)c_low_ed < 60) => 0.023798062,
                                          -0.014393841));

s7_N462_8 :=  __common__( if(((integer)utility_sourced < 0.5), s7_N462_9, 0.060460564));

s7_N462_7 :=  __common__( if(((real)add2_nhood_vacant_properties < 3.5), 0.055716904, s7_N462_8));

s7_N462_6 :=  __common__( map(trim(C_POP_18_24_P) = ''     => s7_N462_7,
              ((real)c_pop_18_24_p < 9.25) => -0.0032019621,
                                              s7_N462_7));

s7_N462_5 :=  __common__( if(((real)_rel_prop_owned_count < 2.5), s7_N462_6, -0.014358343));

s7_N462_4 :=  __common__( if((add1_lres < 461), -0.0007775823, 0.016889771));

s7_N462_3 :=  __common__( map(trim(C_HVAL_40K_P) = ''      => 0.044284059,
              ((real)c_hval_40k_p < 35.95) => s7_N462_4,
                                              0.044284059));

s7_N462_2 :=  __common__( if(((real)c_low_hval < 72.05), s7_N462_3, s7_N462_5));

s7_N462_1 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N462_2, 0.002249712));

s7_N463_8 :=  __common__( if(((real)_addrs_per_ssn_c6 < 0.5), -0.0085519448, 0.011601064));

s7_N463_7 :=  __common__( if((add3_lres < 198), s7_N463_8, 0.013528262));

s7_N463_6 :=  __common__( if(((real)combined_age < 64.5), s7_N463_7, 0.014605597));

s7_N463_5 :=  __common__( if(((real)avg_lres < 181.5), s7_N463_6, -0.019709131));

s7_N463_4 :=  __common__( map(trim(C_LAR_FAM) = ''      => -0.024939209,
              ((real)c_lar_fam < 171.5) => s7_N463_5,
                                           -0.024939209));

s7_N463_3 :=  __common__( if(((real)c_burglary < 186.5), s7_N463_4, 0.012200695));

s7_N463_2 :=  __common__( if(trim(C_BURGLARY) != '', s7_N463_3, -0.0050655241));

s7_N463_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N463_2, 0.00093204115));

s7_N464_11 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 4.5), -0.00028366879, 0.024074778));

s7_N464_10 :=  __common__( if(((real)c_pop_25_34_p < 42.6), s7_N464_11, 0.035217683));

s7_N464_9 :=  __common__( if(trim(C_POP_25_34_P) != '', s7_N464_10, 0.0015379187));

s7_N464_8 :=  __common__( map(trim(C_INC_35K_P) = ''      => -0.009820749,
              ((real)c_inc_35k_p < 14.95) => 0.049838714,
                                             -0.009820749));

s7_N464_7 :=  __common__( map(trim(C_HVAL_80K_P) = ''      => 0.077785656,
              ((real)c_hval_80k_p < 14.25) => s7_N464_8,
                                              0.077785656));

s7_N464_6 :=  __common__( if(((real)rc_addrcount < 3.5), 0.0078813903, 0.0002132554));

s7_N464_5 :=  __common__( map(trim(C_LOW_ED) = ''      => -0.036890634,
              ((real)c_low_ed < 74.15) => s7_N464_6,
                                          -0.036890634));

s7_N464_4 :=  __common__( map(trim(C_LOW_HVAL) = ''      => s7_N464_7,
              ((real)c_low_hval < 72.05) => s7_N464_5,
                                            s7_N464_7));

s7_N464_3 :=  __common__( if(((real)c_cartheft < 135.5), s7_N464_4, -0.0035627575));

s7_N464_2 :=  __common__( if(trim(C_CARTHEFT) != '', s7_N464_3, 0.011649198));

s7_N464_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N464_2, s7_N464_9));

s7_N465_9 :=  __common__( map(trim(C_MURDERS) = ''      => 0.018107271,
              ((real)c_murders < 189.5) => -0.0094240321,
                                           0.018107271));

s7_N465_8 :=  __common__( map(trim(C_BIGAPT_P) = ''     => 0.017963896,
              ((real)c_bigapt_p < 0.65) => -0.024998248,
                                           0.017963896));

s7_N465_7 :=  __common__( map(trim(C_RNT500_P) = ''      => s7_N465_8,
              ((real)c_rnt500_p < 26.35) => -0.029499108,
                                            s7_N465_8));

s7_N465_6 :=  __common__( if(((real)add1_lres < 4.5), s7_N465_7, -0.0023328962));

s7_N465_5 :=  __common__( if(((real)_ams_income_level < 2.5), 0.0031760728, -0.0053409877));

s7_N465_4 :=  __common__( map(trim(C_RNT250_P) = ''     => 0.041931559,
              ((real)c_rnt250_p < 82.8) => s7_N465_5,
                                           0.041931559));

s7_N465_3 :=  __common__( map(trim(C_FOR_SALE) = ''      => s7_N465_6,
              ((real)c_for_sale < 160.5) => s7_N465_4,
                                            s7_N465_6));

s7_N465_2 :=  __common__( if(((real)c_pop_18_24_p < 14.85), s7_N465_3, s7_N465_9));

s7_N465_1 :=  __common__( if(trim(C_POP_18_24_P) != '', s7_N465_2, 0.00036599387));

s7_N466_9 :=  __common__( map(trim(C_INCOLLEGE) = ''     => -0.024189287,
              ((real)c_incollege < 5.85) => 0.0095089211,
                                            -0.024189287));

s7_N466_8 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.026771085,
              ((real)c_incollege < 9.35) => s7_N466_9,
                                            0.026771085));

s7_N466_7 :=  __common__( if(((real)add1_lres < 6.5), 0.040407734, s7_N466_8));

s7_N466_6 :=  __common__( map(trim(C_CARTHEFT) = ''      => -0.023127785,
              ((real)c_cartheft < 167.5) => -0.0041260005,
                                            -0.023127785));

s7_N466_5 :=  __common__( map(trim(C_RNT2001_P) = ''     => 0.033115603,
              ((real)c_rnt2001_p < 29.8) => -0.0011590382,
                                            0.033115603));

s7_N466_4 :=  __common__( map(trim(C_MED_RENT) = ''      => 0.0040247552,
              ((real)c_med_rent < 672.5) => s7_N466_5,
                                            0.0040247552));

s7_N466_3 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => s7_N466_6,
              ((real)c_asian_lang < 193.5) => s7_N466_4,
                                              s7_N466_6));

s7_N466_2 :=  __common__( if(((real)c_bigapt_p < 74.55), s7_N466_3, s7_N466_7));

s7_N466_1 :=  __common__( if(trim(C_BIGAPT_P) != '', s7_N466_2, -0.0018366895));

s7_N467_11 :=  __common__( map(trim(C_POP_25_34_P) = ''      => 0.04630413,
               ((real)c_pop_25_34_p < 12.15) => -0.014173139,
                                                0.04630413));

s7_N467_10 :=  __common__( map((prof_license_category in ['0', '1', '2', '3', '4']) => 0.018482528,
               (prof_license_category in ['5'])                     => 0.14490553,
                                                                       0.018482528));

s7_N467_9 :=  __common__( map(trim(C_RELIG_INDX) = ''      => s7_N467_10,
              ((real)c_relig_indx < 176.5) => -0.0055687139,
                                              s7_N467_10));

s7_N467_8 :=  __common__( if(((real)add2_no_of_bedrooms2 < 4.5), s7_N467_9, 0.050816739));

s7_N467_7 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s7_N467_8, 0.0059278683));

s7_N467_6 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N467_7, 0.00013022211));

s7_N467_5 :=  __common__( map(trim(C_HVAL_1000K_P) = ''     => s7_N467_6,
              ((real)c_hval_1000k_p < 0.55) => -0.0010433631,
                                               s7_N467_6));

s7_N467_4 :=  __common__( if(((real)add2_lres < 456.5), s7_N467_5, s7_N467_11));

s7_N467_3 :=  __common__( map(trim(C_HVAL_1001K_P) = ''     => -0.018514477,
              ((real)c_hval_1001k_p < 26.6) => s7_N467_4,
                                               -0.018514477));

s7_N467_2 :=  __common__( if(((real)c_hval_40k_p < 56.15), s7_N467_3, -0.023427171));

s7_N467_1 :=  __common__( if(trim(C_HVAL_40K_P) != '', s7_N467_2, -0.013276988));

s7_N468_11 :=  __common__( map(trim(C_FAMMAR_P) = ''     => 0.0070459384,
               ((real)c_fammar_p < 74.6) => -0.022274127,
                                            0.0070459384));

s7_N468_10 :=  __common__( map(trim(C_NO_MOVE) = ''     => s7_N468_11,
               ((real)c_no_move < 43.5) => 0.041624178,
                                           s7_N468_11));

s7_N468_9 :=  __common__( if(((real)_crim_rel_within25miles_cap5 < 1.5), s7_N468_10, 0.040860422));

s7_N468_8 :=  __common__( if(((real)add1_no_of_baths2 < 1.5), s7_N468_9, -0.0086674528));

s7_N468_7 :=  __common__( if(((real)add1_no_of_baths2 > NULL), s7_N468_8, -0.0060457197));

s7_N468_6 :=  __common__( if(((real)mth_header_first_seen < 329.5), 0.00077171136, s7_N468_7));

s7_N468_5 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N468_6, 0.0020670274));

s7_N468_4 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), -0.06525635, -0.016490438));

s7_N468_3 :=  __common__( if(((real)rc_addrcount < 5.5), s7_N468_4, 0.020888294));

s7_N468_2 :=  __common__( if(((real)c_hhsize < 1.605), s7_N468_3, s7_N468_5));

s7_N468_1 :=  __common__( if(trim(C_HHSIZE) != '', s7_N468_2, -0.0042737905));

s7_N469_9 :=  __common__( if(((real)add2_nhood_vacant_properties < 35.5), 0.0076828474, 0.055770656));

s7_N469_8 :=  __common__( map(trim(C_MANY_CARS) = ''     => s7_N469_9,
              ((real)c_many_cars < 59.5) => 0.05808675,
                                            s7_N469_9));

s7_N469_7 :=  __common__( map(trim(C_HVAL_80K_P) = ''     => 0.0022000234,
              ((real)c_hval_80k_p < 2.75) => 0.083225162,
                                             0.0022000234));

s7_N469_6 :=  __common__( if(((real)add1_building_area2 < 1263.5), s7_N469_7, 0.0031263473));

s7_N469_5 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N469_6, s7_N469_8));

s7_N469_4 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N469_5,
              ((real)c_rnt750_p < 33.85) => 0.0018015573,
                                            s7_N469_5));

s7_N469_3 :=  __common__( if(((real)c_inc_50k_p < 13.75), s7_N469_4, -0.0013048914));

s7_N469_2 :=  __common__( if(trim(C_INC_50K_P) != '', s7_N469_3, -0.0010937687));

s7_N469_1 :=  __common__( if(((real)add2_source_count < 4.5), -0.0016764369, s7_N469_2));

s7_N470_8 :=  __common__( if(((real)c_high_hval < 1.85), 0.0082340765, 0.062328118));

s7_N470_7 :=  __common__( if(trim(C_HIGH_HVAL) != '', s7_N470_8, -0.02566286));

s7_N470_6 :=  __common__( if(((real)_rel_count < 1.5), s7_N470_7, 0.0012397075));

s7_N470_5 :=  __common__( map(trim(C_MED_AGE) = ''       => 0.019707916,
              ((integer)c_med_age < 113) => 0.057779652,
                                            0.019707916));

s7_N470_4 :=  __common__( if(((real)add2_source_count < 5.5), s7_N470_5, -0.0061338468));

s7_N470_3 :=  __common__( if(((real)source_count < 6.5), -0.0083216957, s7_N470_4));

s7_N470_2 :=  __common__( if((combo_dobscore < 92), s7_N470_3, s7_N470_6));

s7_N470_1 :=  __common__( if(((real)_inq_collection_count < 0.5), -0.0012519863, s7_N470_2));

s7_N471_10 :=  __common__( if(((real)c_retired < 25.95), 0.00061735381, 0.013331973));

s7_N471_9 :=  __common__( if(trim(C_RETIRED) != '', s7_N471_10, -0.0021932721));

s7_N471_8 :=  __common__( if(((real)_ssns_per_addr_c6_cap5 < 0.5), -0.01906289, 0.012719647));

s7_N471_7 :=  __common__( if(((real)add2_nhood_vacant_properties < 158.5), 0.0099041555, 0.085053687));

s7_N471_6 :=  __common__( map(trim(C_HHSIZE) = ''      => -0.0053355301,
              ((real)c_hhsize < 2.445) => s7_N471_7,
                                          -0.0053355301));

s7_N471_5 :=  __common__( if((add1_avm_automated_valuation < 264204), 0.010409168, 0.082546365));

s7_N471_4 :=  __common__( map(trim(C_ASSAULT) = ''     => s7_N471_6,
              ((real)c_assault < 14.5) => s7_N471_5,
                                          s7_N471_6));

s7_N471_3 :=  __common__( if(((real)_boat_plane < 0.5), -0.0010574584, s7_N471_4));

s7_N471_2 :=  __common__( if(((real)age < 78.5), s7_N471_3, s7_N471_8));

s7_N471_1 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N471_2, s7_N471_9));

s7_N472_10 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.055207121,
               ((integer)c_bel_edu < 47) => -0.013712249,
                                            0.055207121));

s7_N472_9 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => s7_N472_10,
              ((real)c_fammar18_p < 34.15) => -0.010643186,
                                              s7_N472_10));

s7_N472_8 :=  __common__( map(trim(C_POP_25_34_P) = ''     => 0.054825624,
              ((real)c_pop_25_34_p < 26.2) => 0.011708522,
                                              0.054825624));

s7_N472_7 :=  __common__( map(trim(C_RENTAL) = ''      => 0.071701174,
              ((real)c_rental < 184.5) => s7_N472_8,
                                          0.071701174));

s7_N472_6 :=  __common__( if(((integer)add2_turnover_1yr_in < 264), s7_N472_7, s7_N472_9));

s7_N472_5 :=  __common__( map(trim(C_UNATTACH) = ''      => s7_N472_6,
              ((real)c_unattach < 126.5) => 0.0015456097,
                                            s7_N472_6));

s7_N472_4 :=  __common__( map(trim(C_UNEMPL) = ''      => -0.0055314549,
              ((real)c_unempl < 103.5) => s7_N472_5,
                                          -0.0055314549));

s7_N472_3 :=  __common__( if(((real)add2_no_of_bedrooms2 > NULL), s7_N472_4, -0.00012668743));

s7_N472_2 :=  __common__( if(((real)c_highrent < 74.15), s7_N472_3, -0.019039669));

s7_N472_1 :=  __common__( if(trim(C_HIGHRENT) != '', s7_N472_2, 0.003452156));

s7_N473_8 :=  __common__( map(trim(C_LARCENY) = ''     => -0.0044914376,
              ((real)c_larceny < 65.5) => 0.050831203,
                                          -0.0044914376));

s7_N473_7 :=  __common__( if(((real)_phones_per_addr < 1.5), s7_N473_8, 0.037458696));

s7_N473_6 :=  __common__( if((add2_lres < 530), 8.3928551e-005, 0.035529225));

s7_N473_5 :=  __common__( map(trim(C_LOW_HVAL) = ''     => s7_N473_7,
              ((real)c_low_hval < 76.9) => s7_N473_6,
                                           s7_N473_7));

s7_N473_4 :=  __common__( if(((real)c_low_hval < 88.15), s7_N473_5, -0.014091414));

s7_N473_3 :=  __common__( if(trim(C_LOW_HVAL) != '', s7_N473_4, -0.0037112973));

s7_N473_2 :=  __common__( if(((real)_inq_count < 0.5), 0.025028218, -0.0038599486));

s7_N473_1 :=  __common__( if((combo_dobscore < 45), s7_N473_2, s7_N473_3));

s7_N474_7 :=  __common__( map(trim(C_RNT750_P) = ''     => 0.079321391,
              ((real)c_rnt750_p < 41.4) => 0.0061808329,
                                           0.079321391));

s7_N474_6 :=  __common__( map(trim(C_CIV_EMP) = ''      => 0.085402801,
              ((real)c_civ_emp < 72.85) => s7_N474_7,
                                           0.085402801));

s7_N474_5 :=  __common__( if(((real)source_count < 9.5), 0.0018648541, s7_N474_6));

s7_N474_4 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), 0.016440816, 0.045288964));

s7_N474_3 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N474_4, s7_N474_5));

s7_N474_2 :=  __common__( if(((real)add2_lres < 209.5), 6.6538555e-005, s7_N474_3));

s7_N474_1 :=  __common__( if((add1_avm_automated_valuation < 263352), -0.0017230511, s7_N474_2));

s7_N475_9 :=  __common__( map(trim(C_RECENT_MOV) = ''      => 0.010962484,
              ((real)c_recent_mov < 188.5) => 0.061162778,
                                              0.010962484));

s7_N475_8 :=  __common__( map((prof_license_category in ['1', '2', '3', '4']) => s7_N475_9,
              (prof_license_category in ['0', '5'])           => 0.086240567,
                                                                 s7_N475_9));

s7_N475_7 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), 0.069376598, 0.00074599812));

s7_N475_6 :=  __common__( map(trim(C_RECENT_MOV) = ''      => s7_N475_8,
              ((real)c_recent_mov < 174.5) => s7_N475_7,
                                              s7_N475_8));

s7_N475_5 :=  __common__( map(trim(C_LAR_FAM) = ''      => 0.030931604,
              ((real)c_lar_fam < 189.5) => -0.00026086801,
                                           0.030931604));

s7_N475_4 :=  __common__( if(((real)add1_lres < 33.5), -0.0047686944, s7_N475_5));

s7_N475_3 :=  __common__( map(trim(C_INC_50K_P) = ''      => s7_N475_6,
              ((real)c_inc_50k_p < 23.85) => s7_N475_4,
                                             s7_N475_6));

s7_N475_2 :=  __common__( if(((integer)c_totcrime < 186), s7_N475_3, -0.026033878));

s7_N475_1 :=  __common__( if(trim(C_TOTCRIME) != '', s7_N475_2, -0.00015850585));

s7_N476_11 :=  __common__( map(trim(C_YOUNG) = ''      => -0.0017058475,
               ((real)c_young < 17.45) => 0.065454287,
                                          -0.0017058475));

s7_N476_10 :=  __common__( map(trim(C_TOTCRIME) = ''      => 0.047668376,
               ((real)c_totcrime < 154.5) => s7_N476_11,
                                             0.047668376));

s7_N476_9 :=  __common__( map(trim(C_INC_150K_P) = ''    => 0.017829712,
              ((real)c_inc_150k_p < 8.1) => 0.069209296,
                                            0.017829712));

s7_N476_8 :=  __common__( map(trim(C_RELIG_INDX) = ''      => -0.0019404173,
              ((real)c_relig_indx < 122.5) => s7_N476_9,
                                              -0.0019404173));

s7_N476_7 :=  __common__( map(trim(C_MED_RENT) = ''       => s7_N476_8,
              ((real)c_med_rent < 1123.5) => -0.0019744034,
                                             s7_N476_8));

s7_N476_6 :=  __common__( if(((real)_ssncount < 1.5), -0.019316627, -0.0016954897));

s7_N476_5 :=  __common__( if(((real)add1_avm_to_med_ratio < 1.19639), s7_N476_6, 0.0099178146));

s7_N476_4 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N476_5, s7_N476_7));

s7_N476_3 :=  __common__( if(((real)c_inc_50k_p < 21.95), s7_N476_4, s7_N476_10));

s7_N476_2 :=  __common__( if(trim(C_INC_50K_P) != '', s7_N476_3, -0.0047110792));

s7_N476_1 :=  __common__( if(((real)add2_avm_to_med_ratio > NULL), s7_N476_2, -0.00037157112));

s7_N477_10 :=  __common__( map(trim(C_INC_35K_P) = ''      => -0.024473802,
               ((real)c_inc_35k_p < 20.45) => -0.0010619341,
                                              -0.024473802));

s7_N477_9 :=  __common__( map(trim(C_YOUNG) = ''      => -0.0034720451,
              ((real)c_young < 22.15) => 0.070178509,
                                         -0.0034720451));

s7_N477_8 :=  __common__( map(trim(C_HVAL_20K_P) = ''     => 0.048710725,
              ((real)c_hval_20k_p < 19.6) => -0.0017561528,
                                             0.048710725));

s7_N477_7 :=  __common__( map(trim(C_BORN_USA) = ''    => s7_N477_8,
              ((real)c_born_usa < 8.5) => 0.052490711,
                                          s7_N477_8));

s7_N477_6 :=  __common__( if(((real)add1_no_of_baths2 > NULL), 0.00754622, s7_N477_7));

s7_N477_5 :=  __common__( if(((real)rc_dirsaddr_lastscore < 177.5), s7_N477_6, -0.0057955074));

s7_N477_4 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.041348554,
              ((real)c_relig_indx < 177.5) => s7_N477_5,
                                              0.041348554));

s7_N477_3 :=  __common__( map(trim(C_ARMFORCE) = ''      => s7_N477_9,
              ((real)c_armforce < 145.5) => s7_N477_4,
                                            s7_N477_9));

s7_N477_2 :=  __common__( if(((real)c_totsales < 4.5), s7_N477_3, s7_N477_10));

s7_N477_1 :=  __common__( if(trim(C_TOTSALES) != '', s7_N477_2, -0.0099590554));

s7_N478_10 :=  __common__( if(((real)mth_header_first_seen > NULL), -0.011413448, 0.1302797));

s7_N478_9 :=  __common__( map(trim(C_BORN_USA) = ''     => -0.012629354,
              ((real)c_born_usa < 13.5) => 0.026879529,
                                           -0.012629354));

s7_N478_8 :=  __common__( map(trim(C_BEL_EDU) = ''       => -0.019638112,
              ((integer)c_bel_edu < 118) => s7_N478_9,
                                            -0.019638112));

s7_N478_7 :=  __common__( if(((real)_rel_homeover500_count < 2.5), -0.00053782553, 0.040374676));

s7_N478_6 :=  __common__( map(trim(C_RENTOCC_P) = ''      => s7_N478_8,
              ((real)c_rentocc_p < 78.75) => s7_N478_7,
                                             s7_N478_8));

s7_N478_5 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.033955141,
              ((real)c_low_ed < 74.65) => 0.0058436587,
                                          0.033955141));

s7_N478_4 :=  __common__( map(trim(C_MED_HHINC) = ''         => s7_N478_6,
              ((integer)c_med_hhinc < 24816) => s7_N478_5,
                                                s7_N478_6));

s7_N478_3 :=  __common__( if(((real)add1_building_area2 > NULL), -0.00034440549, s7_N478_4));

s7_N478_2 :=  __common__( if(((real)c_hval_1000k_p < 7.65), s7_N478_3, s7_N478_10));

s7_N478_1 :=  __common__( if(trim(C_HVAL_1000K_P) != '', s7_N478_2, -0.0018657478));

s7_N479_9 :=  __common__( if(((real)rc_phoneaddrcount < 0.5), 0.068338355, -0.011497231));

s7_N479_8 :=  __common__( map(trim(C_BLUE_EMPL) = ''      => s7_N479_9,
              ((real)c_blue_empl < 129.5) => 0.0020268163,
                                             s7_N479_9));

s7_N479_7 :=  __common__( if(((integer)add1_avm_med < 549091), s7_N479_8, 0.044404927));

s7_N479_6 :=  __common__( if(((real)_add_risk < 0.5), s7_N479_7, 0.066893601));

s7_N479_5 :=  __common__( map(trim(C_RNT750_P) = ''     => 0.04914537,
              ((real)c_rnt750_p < 42.5) => 0.01148275,
                                           0.04914537));

s7_N479_4 :=  __common__( map(trim(C_RETIRED2) = ''      => s7_N479_5,
              ((real)c_retired2 < 160.5) => 0.00040849999,
                                            s7_N479_5));

s7_N479_3 :=  __common__( map(trim(C_RNT750_P) = ''      => s7_N479_6,
              ((real)c_rnt750_p < 55.85) => s7_N479_4,
                                            s7_N479_6));

s7_N479_2 :=  __common__( if(((real)c_incollege < 7.65), -0.00044399903, s7_N479_3));

s7_N479_1 :=  __common__( if(trim(C_INCOLLEGE) != '', s7_N479_2, 0.0019070953));

s7_N480_12 :=  __common__( if(((real)c_hval_750k_p < 39.15), -0.00052989418, 0.035979244));

s7_N480_11 :=  __common__( if(trim(C_HVAL_750K_P) != '', s7_N480_12, 0.011530731));

s7_N480_10 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), 0.001355996, s7_N480_11));

s7_N480_9 :=  __common__( if((combo_dobscore < 92), -0.0083164711, 0.027304253));

s7_N480_8 :=  __common__( if(((real)add2_lres < 1.5), 0.0006298969, -0.023923087));

s7_N480_7 :=  __common__( if(((real)mth_header_first_seen < 109.5), s7_N480_8, s7_N480_9));

s7_N480_6 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N480_7, 0.010719595));

s7_N480_5 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N480_6, -0.0019863575));

s7_N480_4 :=  __common__( map(trim(C_RELIG_INDX) = ''       => -0.0042069332,
              ((integer)c_relig_indx < 129) => -0.02930475,
                                               -0.0042069332));

s7_N480_3 :=  __common__( if(((real)c_burglary < 43.5), s7_N480_4, s7_N480_5));

s7_N480_2 :=  __common__( if(trim(C_BURGLARY) != '', s7_N480_3, -0.03237592));

s7_N480_1 :=  __common__( if(((real)_ssncount < 1.5), s7_N480_2, s7_N480_10));

s7_N481_8 :=  __common__( map((prof_license_category in ['0', '1', '3', '4', '5']) => -0.0076135925,
              (prof_license_category in ['2'])                     => 0.12186474,
                                                                      -0.0076135925));

s7_N481_7 :=  __common__( map(trim(C_MORT_INDX) = ''      => 0.010636702,
              ((real)c_mort_indx < 110.5) => -0.0029566047,
                                             0.010636702));

s7_N481_6 :=  __common__( if(((real)input_dob_match_level < 4.5), 0.013532429, s7_N481_7));

s7_N481_5 :=  __common__( map(trim(C_OWNOCC_P) = ''      => 0.049741826,
              ((real)c_ownocc_p < 12.15) => 0.0090579258,
                                            0.049741826));

s7_N481_4 :=  __common__( map(trim(C_SFDU_P) = ''     => s7_N481_6,
              ((real)c_sfdu_p < 14.1) => s7_N481_5,
                                         s7_N481_6));

s7_N481_3 :=  __common__( if(((real)c_recent_mov < 39.5), s7_N481_4, -0.00032758043));

s7_N481_2 :=  __common__( if(trim(C_RECENT_MOV) != '', s7_N481_3, -0.0034538387));

s7_N481_1 :=  __common__( if(((real)bus_phone_match < 2.5), s7_N481_2, s7_N481_8));

s7_N482_10 :=  __common__( map(trim(C_HVAL_100K_P) = ''      => 0.044319362,
               ((real)c_hval_100k_p < 11.45) => -0.0065684948,
                                                0.044319362));

s7_N482_9 :=  __common__( map(trim(C_ASIAN_LANG) = ''      => s7_N482_10,
              ((real)c_asian_lang < 144.5) => -0.016678075,
                                              s7_N482_10));

s7_N482_8 :=  __common__( map(trim(C_TOTSALES) = ''        => 0.035611517,
              ((integer)c_totsales < 1940) => -0.008281041,
                                              0.035611517));

s7_N482_7 :=  __common__( map(trim(C_CHILD) = ''      => 0.067072078,
              ((real)c_child < 22.05) => s7_N482_8,
                                         0.067072078));

s7_N482_6 :=  __common__( map(trim(C_HHSIZE) = ''      => s7_N482_9,
              ((real)c_hhsize < 2.415) => s7_N482_7,
                                          s7_N482_9));

s7_N482_5 :=  __common__( if(((real)avg_lres < 409.5), 0.06424384, -0.0034167511));

s7_N482_4 :=  __common__( if((avg_lres < 389), -0.00042332009, s7_N482_5));

s7_N482_3 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N482_4, 0.0029337022));

s7_N482_2 :=  __common__( if(((real)c_inc_50k_p < 24.25), s7_N482_3, s7_N482_6));

s7_N482_1 :=  __common__( if(trim(C_INC_50K_P) != '', s7_N482_2, -0.0045018395));

s7_N483_10 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 11.5), 0.026623571, -0.0035112531));

s7_N483_9 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N483_10, -0.034398145));

s7_N483_8 :=  __common__( if(((real)_ssns_per_addr < 4.5), s7_N483_9, 0.0019099169));

s7_N483_7 :=  __common__( if(((real)c_many_cars < 95.5), -0.032767328, -0.0090763836));

s7_N483_6 :=  __common__( if(trim(C_MANY_CARS) != '', s7_N483_7, 0.053243674));

s7_N483_5 :=  __common__( map(trim(C_LAR_FAM) = ''      => -0.0089962411,
              ((real)c_lar_fam < 118.5) => 0.021609975,
                                           -0.0089962411));

s7_N483_4 :=  __common__( if(((real)c_lowinc < 19.7), -0.012948699, s7_N483_5));

s7_N483_3 :=  __common__( if(trim(C_LOWINC) != '', s7_N483_4, -0.034563392));

s7_N483_2 :=  __common__( if(((real)age < 51.5), s7_N483_3, s7_N483_6));

s7_N483_1 :=  __common__( if((combo_dobscore < 80), s7_N483_2, s7_N483_8));

s7_N484_11 :=  __common__( if(((real)rc_lnamecount < 4.5), 0.0087859967, -0.018682766));

s7_N484_10 :=  __common__( map(trim(C_INC_25K_P) = ''      => s7_N484_11,
               ((real)c_inc_25k_p < 19.75) => -0.00014135354,
                                              s7_N484_11));

s7_N484_9 :=  __common__( if(((real)c_inc_15k_p < 48.55), s7_N484_10, 0.013800851));

s7_N484_8 :=  __common__( if(trim(C_INC_15K_P) != '', s7_N484_9, 0.0072119685));

s7_N484_7 :=  __common__( map(trim(C_HHSIZE) = ''      => 0.048346047,
              ((real)c_hhsize < 3.175) => 0.0050492906,
                                          0.048346047));

s7_N484_6 :=  __common__( if(((real)_inq_collection_count < 4.5), -0.00044307296, s7_N484_7));

s7_N484_5 :=  __common__( map(trim(C_TOTCRIME) = ''      => 0.027570784,
              ((real)c_totcrime < 184.5) => s7_N484_6,
                                            0.027570784));

s7_N484_4 :=  __common__( if(((real)c_ownocc_p < 26.65), -0.012024302, s7_N484_5));

s7_N484_3 :=  __common__( if(trim(C_OWNOCC_P) != '', s7_N484_4, -0.030899564));

s7_N484_2 :=  __common__( if(((real)add1_avm_to_med_ratio < 0.159989), 0.036027964, s7_N484_3));

s7_N484_1 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N484_2, s7_N484_8));

s7_N485_10 :=  __common__( map((prof_license_category in ['0', '1', '2', '4']) => -0.0034082815,
               (prof_license_category in ['3', '5'])           => 0.12287182,
                                                                  -0.0034082815));

s7_N485_9 :=  __common__( if(((real)ssn_lowissue_age < 13.3735), s7_N485_10, -0.017414023));

s7_N485_8 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N485_9, -0.019132512));

s7_N485_7 :=  __common__( if(((real)c_unattach < 153.5), s7_N485_8, 0.013310661));

s7_N485_6 :=  __common__( if(trim(C_UNATTACH) != '', s7_N485_7, -0.0046083933));

s7_N485_5 :=  __common__( if(((real)_inq_count < 1.5), -0.00092789828, 0.022361195));

s7_N485_4 :=  __common__( if(((integer)add1_building_area2 < 3483), s7_N485_5, -0.02622664));

s7_N485_3 :=  __common__( if(((real)_addrs_15yr < 9.5), s7_N485_4, -0.018079277));

s7_N485_2 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N485_3, s7_N485_6));

s7_N485_1 :=  __common__( if(((real)rc_addrcount < 1.5), s7_N485_2, 0.001261584));

s7_N486_10 :=  __common__( if(((integer)mth_gong_did_first_seen < 72), 0.077966258, 0.014690352));

s7_N486_9 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N486_10, 0.0068297575));

s7_N486_8 :=  __common__( map(trim(C_MED_HHINC) = ''        => 0.080835127,
              ((real)c_med_hhinc < 65901.5) => 0.018113129,
                                               0.080835127));

s7_N486_7 :=  __common__( if(((real)_addrs_per_adl < 7.5), s7_N486_8, -0.0006209433));

s7_N486_6 :=  __common__( map(trim(C_FAMMAR_P) = ''      => 0.0013516349,
              ((real)c_fammar_p < 77.55) => s7_N486_7,
                                            0.0013516349));

s7_N486_5 :=  __common__( map(trim(C_SPAN_LANG) = ''      => s7_N486_9,
              ((real)c_span_lang < 163.5) => s7_N486_6,
                                             s7_N486_9));

s7_N486_4 :=  __common__( map(trim(C_RNT2001_P) = ''     => s7_N486_5,
              ((real)c_rnt2001_p < 3.05) => 0.00087694705,
                                            s7_N486_5));

s7_N486_3 :=  __common__( if(((integer)add1_avm_med < 313252), -0.014730042, 0.001612081));

s7_N486_2 :=  __common__( if(((real)c_femdiv_p < 1.55), s7_N486_3, s7_N486_4));

s7_N486_1 :=  __common__( if(trim(C_FEMDIV_P) != '', s7_N486_2, 0.0019317119));

s7_N487_8 :=  __common__( if(((real)_addrs_15yr < 4.5), -0.026796903, -0.0031517562));

s7_N487_7 :=  __common__( if(((real)_adls_per_phone < 0.5), 0.02079582, -0.013845796));

s7_N487_6 :=  __common__( if(((real)input_dob_match_level < 7.5), s7_N487_7, s7_N487_8));

s7_N487_5 :=  __common__( if(((real)mth_gong_did_first_seen < 44.5), 0.022499987, -0.023924015));

s7_N487_4 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N487_5, -0.012162863));

s7_N487_3 :=  __common__( if(((real)attr_total_number_derogs < 3.5), 0.00024366092, s7_N487_4));

s7_N487_2 :=  __common__( if(((real)age < 90.5), s7_N487_3, 0.018266169));

s7_N487_1 :=  __common__( if(((real)_nas < 1.5), s7_N487_2, s7_N487_6));

s7_N488_10 :=  __common__( map(trim(C_INCOLLEGE) = ''     => 0.0047723339,
               ((real)c_incollege < 5.75) => 0.037019766,
                                             0.0047723339));

s7_N488_9 :=  __common__( if(((real)rc_addrcount < 2.5), s7_N488_10, 0.0065952463));

s7_N488_8 :=  __common__( if(((real)gong_did_addr_ct < 0.5), -0.0030419968, s7_N488_9));

s7_N488_7 :=  __common__( if(((real)_inq_peraddr_cap8 < 1.5), -0.0010855314, s7_N488_8));

s7_N488_6 :=  __common__( if(((real)mth_attr_date_last_derog < 103.5), -0.031756532, 0.010734702));

s7_N488_5 :=  __common__( if(((real)mth_attr_date_last_derog > NULL), s7_N488_6, -0.02402357));

s7_N488_4 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.022155021,
              ((real)c_low_ed < 58.85) => -0.0061067474,
                                          0.022155021));

s7_N488_3 :=  __common__( if(((real)add3_lres < 54.5), s7_N488_4, s7_N488_5));

s7_N488_2 :=  __common__( if(((real)c_fammar18_p < 10.55), s7_N488_3, s7_N488_7));

s7_N488_1 :=  __common__( if(trim(C_FAMMAR18_P) != '', s7_N488_2, 0.0055826822));

s7_N489_8 :=  __common__( map(trim(C_POP_18_24_P) = ''     => 0.064104518,
              ((real)c_pop_18_24_p < 7.75) => 0.0031859103,
                                              0.064104518));

s7_N489_7 :=  __common__( if(((real)add1_turnover_1yr_in < 111.5), 0.040379852, -0.0096117765));

s7_N489_6 :=  __common__( if(((real)attr_num_nonderogs30 < 6.5), s7_N489_7, s7_N489_8));

s7_N489_5 :=  __common__( map(trim(C_INC_150K_P) = ''     => 0.045051547,
              ((real)c_inc_150k_p < 2.35) => 0.011273178,
                                             0.045051547));

s7_N489_4 :=  __common__( if(((real)c_fammar_p < 70.2), s7_N489_5, s7_N489_6));

s7_N489_3 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N489_4, -0.026028443));

s7_N489_2 :=  __common__( if(((real)_phone_score < 2.5), 0.0018369545, s7_N489_3));

s7_N489_1 :=  __common__( if(((real)phn_cellpager < 0.5), s7_N489_2, -0.0022236271));

s7_N490_10 :=  __common__( map(trim(C_RNT500_P) = ''      => 0.01415057,
               ((real)c_rnt500_p < 41.95) => 0.054983022,
                                             0.01415057));

s7_N490_9 :=  __common__( map(trim(C_YOUNG) = ''      => s7_N490_10,
              ((real)c_young < 19.55) => -0.0078016504,
                                         s7_N490_10));

s7_N490_8 :=  __common__( map(trim(C_UNATTACH) = ''      => 0.018578266,
              ((real)c_unattach < 181.5) => 5.1414546e-005,
                                            0.018578266));

s7_N490_7 :=  __common__( if(((real)c_rentocc_p < 96.55), s7_N490_8, 0.018316827));

s7_N490_6 :=  __common__( if(trim(C_RENTOCC_P) != '', s7_N490_7, 0.009286856));

s7_N490_5 :=  __common__( if(((real)mth_header_first_seen < 535.5), s7_N490_6, s7_N490_9));

s7_N490_4 :=  __common__( if(((real)mth_header_first_seen > NULL), s7_N490_5, 0.00088926151));

s7_N490_3 :=  __common__( if(((real)c_easiqlife < 156.5), -0.011695174, 0.014854785));

s7_N490_2 :=  __common__( if(trim(C_EASIQLIFE) != '', s7_N490_3, -0.028967963));

s7_N490_1 :=  __common__( if((rc_combo_sec_rangescore < 25), s7_N490_2, s7_N490_4));

s7_N491_9 :=  __common__( if(((real)_addrs_last36 < 0.5), 0.031731217, -0.011652561));

s7_N491_8 :=  __common__( map(trim(C_RNT250_P) = ''     => -0.0064238566,
              ((real)c_rnt250_p < 8.45) => 0.011118485,
                                           -0.0064238566));

s7_N491_7 :=  __common__( if(((real)add2_lres < 43.5), s7_N491_8, 0.00030618307));

s7_N491_6 :=  __common__( if(((real)add2_nhood_vacant_properties < 774.5), -0.00051534576, 0.049691605));

s7_N491_5 :=  __common__( map(trim(C_BLUE_EMPL) = ''      => 0.051843362,
              ((real)c_blue_empl < 192.5) => s7_N491_6,
                                             0.051843362));

s7_N491_4 :=  __common__( map(trim(C_VACANT_P) = ''     => s7_N491_5,
              ((real)c_vacant_p < 5.55) => -0.00608496,
                                           s7_N491_5));

s7_N491_3 :=  __common__( if(((real)add2_source_count < 2.5), s7_N491_4, s7_N491_7));

s7_N491_2 :=  __common__( if(((real)c_for_sale < 185.5), s7_N491_3, s7_N491_9));

s7_N491_1 :=  __common__( if(trim(C_FOR_SALE) != '', s7_N491_2, 0.0048529863));

s7_N492_9 :=  __common__( if(((real)_util_adl_count < 2.5), 0.022636066, -0.0072758332));

s7_N492_8 :=  __common__( map(trim(C_UNEMP) = ''     => s7_N492_9,
              ((real)c_unemp < 4.15) => -0.014531927,
                                        s7_N492_9));

s7_N492_7 :=  __common__( map(trim(C_LAR_FAM) = ''      => -0.01764278,
              ((real)c_lar_fam < 113.5) => s7_N492_8,
                                           -0.01764278));

s7_N492_6 :=  __common__( map(trim(C_TOTSALES) = ''          => 0.021224442,
              ((integer)c_totsales < 236758) => -0.014473892,
                                                0.021224442));

s7_N492_5 :=  __common__( map(trim(C_HVAL_750K_P) = ''      => 0.027171788,
              ((real)c_hval_750k_p < 45.85) => 0.00046929913,
                                               0.027171788));

s7_N492_4 :=  __common__( if(((real)_addrs_last36 < 7.5), s7_N492_5, s7_N492_6));

s7_N492_3 :=  __common__( map(trim(C_LOW_ED) = ''      => 0.021497841,
              ((integer)c_low_ed < 84) => s7_N492_4,
                                          0.021497841));

s7_N492_2 :=  __common__( if(((real)c_rentocc_p < 85.65), s7_N492_3, s7_N492_7));

s7_N492_1 :=  __common__( if(trim(C_RENTOCC_P) != '', s7_N492_2, 0.0043973266));

s7_N493_10 :=  __common__( if(((real)mth_did2_header_first_seen > NULL), 0.5, 0.020438951));

s7_N493_9 :=  __common__( map(trim(C_RNT250_P) = ''    => -0.011261664,
              ((real)c_rnt250_p < 0.3) => s7_N493_10,
                                          -0.011261664));

s7_N493_8 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N493_9, 0.014123574));

s7_N493_7 :=  __common__( map(trim(C_BEL_EDU) = ''     => s7_N493_8,
              ((real)c_bel_edu < 80.5) => -0.011275986,
                                          s7_N493_8));

s7_N493_6 :=  __common__( if(((real)c_larceny < 153.5), s7_N493_7, -0.021519074));

s7_N493_5 :=  __common__( if(trim(C_LARCENY) != '', s7_N493_6, 0.017771791));

s7_N493_4 :=  __common__( if(((real)mth_gong_did_first_seen < 80.5), -0.012213939, 0.045786754));

s7_N493_3 :=  __common__( if(((real)mth_gong_did_first_seen > NULL), s7_N493_4, 0.018759487));

s7_N493_2 :=  __common__( if(((real)add1_unit_count < 0.5), s7_N493_3, 0.00076820989));

s7_N493_1 :=  __common__( if(((real)add2_lres < 283.5), s7_N493_2, s7_N493_5));

s7_N494_11 :=  __common__( if(((real)add1_turnover_1yr_in < 232.5), 0.049892823, -0.0072332251));

s7_N494_10 :=  __common__( if(((real)mth_ver_src_fsrc_fdate < 497.5), -0.0014366508, s7_N494_11));

s7_N494_9 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N494_10, 0.0037418846));

s7_N494_8 :=  __common__( map(trim(C_INC_50K_P) = ''      => 0.018272537,
              ((real)c_inc_50k_p < 11.55) => 0.088604062,
                                             0.018272537));

s7_N494_7 :=  __common__( map(trim(C_POP_25_34_P) = ''    => s7_N494_8,
              ((real)c_pop_25_34_p < 9.2) => -0.0024683875,
                                             s7_N494_8));

s7_N494_6 :=  __common__( if(((real)c_cartheft < 20.5), s7_N494_7, 0.0053244009));

s7_N494_5 :=  __common__( if(trim(C_CARTHEFT) != '', s7_N494_6, -0.026255615));

s7_N494_4 :=  __common__( if((add2_avm_automated_valuation < 322221), 0.00014427266, s7_N494_5));

s7_N494_3 :=  __common__( if((add2_avm_automated_valuation < 584121), s7_N494_4, -0.011224542));

s7_N494_2 :=  __common__( if(((real)_ssn_score < 2.5), s7_N494_3, -0.020076852));

s7_N494_1 :=  __common__( if(((real)add1_building_area2 > NULL), s7_N494_2, s7_N494_9));

s7_N495_8 :=  __common__( if(((real)rc_addrcount < 3.5), 0.014891831, -0.0044922173));

s7_N495_7 :=  __common__( if(((real)_rel_bankrupt_count < 3.5), s7_N495_8, 0.04511439));

s7_N495_6 :=  __common__( map(trim(C_HVAL_60K_P) = ''     => -0.0094518583,
              ((real)c_hval_60k_p < 8.25) => s7_N495_7,
                                             -0.0094518583));

s7_N495_5 :=  __common__( map(trim(C_NO_MOVE) = ''     => -0.0044007749,
              ((real)c_no_move < 24.5) => s7_N495_6,
                                          -0.0044007749));

s7_N495_4 :=  __common__( map(trim(C_RETIRED) = ''      => 0.031511606,
              ((real)c_retired < 36.25) => s7_N495_5,
                                           0.031511606));

s7_N495_3 :=  __common__( if(((real)c_fammar_p < 77.45), s7_N495_4, 0.0019961625));

s7_N495_2 :=  __common__( if(trim(C_FAMMAR_P) != '', s7_N495_3, -0.0027125298));

s7_N495_1 :=  __common__( if(((real)avg_lres < 3.5), -0.019989819, s7_N495_2));

s7_N496_9 :=  __common__( map(trim(C_HIGH_HVAL) = ''     => -0.0077544209,
              ((real)c_high_hval < 4.35) => 0.0067813979,
                                            -0.0077544209));

s7_N496_8 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N496_9, -0.0005730674));

s7_N496_7 :=  __common__( map(trim(C_INC_35K_P) = ''      => 0.035342319,
              ((real)c_inc_35k_p < 22.05) => s7_N496_8,
                                             0.035342319));

s7_N496_6 :=  __common__( if(((integer)mth_ver_src_fsrc_fdate < 279), 0.045534952, -0.0013195099));

s7_N496_5 :=  __common__( map(trim(C_RETIRED2) = ''     => s7_N496_6,
              ((real)c_retired2 < 76.5) => -0.018587548,
                                           s7_N496_6));

s7_N496_4 :=  __common__( map(trim(C_BEL_EDU) = ''      => 0.034266519,
              ((real)c_bel_edu < 156.5) => s7_N496_5,
                                           0.034266519));

s7_N496_3 :=  __common__( map(trim(C_RECENT_MOV) = ''    => s7_N496_7,
              ((real)c_recent_mov < 5.5) => s7_N496_4,
                                            s7_N496_7));

s7_N496_2 :=  __common__( if(((real)attr_num_nonderogs30 < 3.5), -0.0038065787, s7_N496_3));

s7_N496_1 :=  __common__( if(trim(C_ASSAULT) != '', s7_N496_2, 0.0022961965));

s7_N497_9 :=  __common__( map(trim(C_EASIQLIFE) = ''      => -0.023199204,
              ((real)c_easiqlife < 141.5) => 0.0053000419,
                                             -0.023199204));

s7_N497_8 :=  __common__( map(trim(C_EASIQLIFE) = ''      => 0.030309195,
              ((real)c_easiqlife < 153.5) => s7_N497_9,
                                             0.030309195));

s7_N497_7 :=  __common__( if(((integer)rc_input_addr_not_most_recent < 0.5), -0.0084819784, s7_N497_8));

s7_N497_6 :=  __common__( map(trim(C_BLUE_COL) = ''      => -0.029916573,
              ((real)c_blue_col < 23.95) => s7_N497_7,
                                            -0.029916573));

s7_N497_5 :=  __common__( if(((real)_inq_collection_count < 1.5), 0.00090348728, s7_N497_6));

s7_N497_4 :=  __common__( map(trim(C_AB_AV_EDU) = ''      => 0.016665846,
              ((real)c_ab_av_edu < 101.5) => -0.018019478,
                                             0.016665846));

s7_N497_3 :=  __common__( if(((real)_addrs_15yr < 5.5), s7_N497_4, -0.025071916));

s7_N497_2 :=  __common__( if(((real)c_born_usa < 2.5), s7_N497_3, s7_N497_5));

s7_N497_1 :=  __common__( if(trim(C_BORN_USA) != '', s7_N497_2, 0.0020356809));

s7_N498_8 :=  __common__( map(trim(C_NO_MOVE) = ''      => -0.026478755,
              ((integer)c_no_move < 98) => 0.037629405,
                                           -0.026478755));

s7_N498_7 :=  __common__( map(trim(C_CARTHEFT) = ''      => 0.082978873,
              ((real)c_cartheft < 132.5) => s7_N498_8,
                                            0.082978873));

s7_N498_6 :=  __common__( map(trim(C_TOTCRIME) = ''     => -0.0013488813,
              ((real)c_totcrime < 87.5) => s7_N498_7,
                                           -0.0013488813));

s7_N498_5 :=  __common__( map(trim(C_UNEMP) = ''     => -0.00078765802,
              ((real)c_unemp < 0.05) => s7_N498_6,
                                        -0.00078765802));

s7_N498_4 :=  __common__( map(trim(C_BURGLARY) = ''    => s7_N498_5,
              ((real)c_burglary < 3.5) => 0.055639318,
                                          s7_N498_5));

s7_N498_3 :=  __common__( if(((real)c_assault < 41.5), -0.0054265159, s7_N498_4));

s7_N498_2 :=  __common__( if(trim(C_ASSAULT) != '', s7_N498_3, -0.0043524951));

s7_N498_1 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N498_2, 0.019955657));

s7_N499_8 :=  __common__( map(trim(C_BLUE_COL) = ''      => 0.052690542,
              ((real)c_blue_col < 13.45) => 0.012195966,
                                            0.052690542));

s7_N499_7 :=  __common__( map(trim(C_MURDERS) = ''      => s7_N499_8,
              ((integer)c_murders < 78) => -0.0012318082,
                                           s7_N499_8));

s7_N499_6 :=  __common__( if(((real)c_vacant_p < 5.25), s7_N499_7, -0.0072678663));

s7_N499_5 :=  __common__( if(trim(C_VACANT_P) != '', s7_N499_6, -0.028859933));

s7_N499_4 :=  __common__( if(((real)_addrs_15yr < 3.5), 0.028655268, s7_N499_5));

s7_N499_3 :=  __common__( if(((real)phn_cellpager < 0.5), 0.00096695691, s7_N499_4));

s7_N499_2 :=  __common__( if(((real)combined_age < 51.5), -0.0019474521, s7_N499_3));

s7_N499_1 :=  __common__( if(((real)mth_ver_src_fsrc_fdate > NULL), s7_N499_2, 0.022821286));

s7_N500_11 :=  __common__( map(trim(C_INC_201K_P) = ''     => 0.0055707581,
               ((real)c_inc_201k_p < 0.85) => 0.045961164,
                                              0.0055707581));

s7_N500_10 :=  __common__( if(((real)rc_addrcount < 3.5), s7_N500_11, 0.0045662715));

s7_N500_9 :=  __common__( map(trim(C_UNEMPL) = ''      => -0.017576427,
              ((real)c_unempl < 145.5) => s7_N500_10,
                                          -0.017576427));

s7_N500_8 :=  __common__( if(((real)ssn_lowissue_age < 18.4789), s7_N500_9, 0.036679227));

s7_N500_7 :=  __common__( if(((real)ssn_lowissue_age > NULL), s7_N500_8, -0.089556441));

s7_N500_6 :=  __common__( map(trim(C_WHITE_COL) = ''      => -0.00099184555,
              ((real)c_white_col < 12.95) => 0.01607942,
                                             -0.00099184555));

s7_N500_5 :=  __common__( if(((real)_rel_felony_count < 0.5), s7_N500_6, s7_N500_7));

s7_N500_4 :=  __common__( if(((real)add1_building_area2 > NULL), 0.0010748811, s7_N500_5));

s7_N500_3 :=  __common__( map(trim(C_MED_RENT) = ''       => -0.0073901431,
              ((real)c_med_rent < 1338.5) => s7_N500_4,
                                             -0.0073901431));

s7_N500_2 :=  __common__( if(((real)c_hval_40k_p < 47.35), s7_N500_3, -0.019316669));

s7_N500_1 :=  __common__( if(trim(C_HVAL_40K_P) != '', s7_N500_2, -0.0043878791));

s7_N501_9 :=  __common__( if(((real)_addrs_15yr < 5.5), 0.041494707, 0.007275469));

s7_N501_8 :=  __common__( map(trim(C_FEMDIV_P) = ''     => 0.0037442227,
              ((real)c_femdiv_p < 5.15) => 0.053433285,
                                           0.0037442227));

s7_N501_7 :=  __common__( map(trim(C_NO_MOVE) = ''      => s7_N501_8,
              ((real)c_no_move < 134.5) => -0.0017698075,
                                           s7_N501_8));

s7_N501_6 :=  __common__( if(((real)add2_naprop < 1.5), s7_N501_7, s7_N501_9));

s7_N501_5 :=  __common__( map(trim(C_UNEMPL) = ''      => s7_N501_6,
              ((real)c_unempl < 141.5) => 0.00077255058,
                                          s7_N501_6));

s7_N501_4 :=  __common__( if(((real)_nap < 3.5), -0.0010814514, s7_N501_5));

s7_N501_3 :=  __common__( map(trim(C_RETIRED2) = ''    => s7_N501_4,
              ((real)c_retired2 < 3.5) => -0.025989356,
                                          s7_N501_4));

s7_N501_2 :=  __common__( if(((integer)c_med_hhinc < 12622), -0.027389202, s7_N501_3));

s7_N501_1 :=  __common__( if(trim(C_MED_HHINC) != '', s7_N501_2, 0.0088326247));

s7_N502_10 :=  __common__( if(((integer)c_totcrime < 135), 0.0027544398, 0.043661312));

s7_N502_9 :=  __common__( if(trim(C_TOTCRIME) != '', s7_N502_10, -0.025710413));

s7_N502_8 :=  __common__( map(trim(C_RELIG_INDX) = ''      => 0.077882553,
              ((real)c_relig_indx < 117.5) => 0.014682938,
                                              0.077882553));

s7_N502_7 :=  __common__( if(((real)add1_avm_to_med_ratio < 0.983976), s7_N502_8, 0.00078488705));

s7_N502_6 :=  __common__( if(((real)add1_avm_to_med_ratio > NULL), s7_N502_7, s7_N502_9));

s7_N502_5 :=  __common__( if(((integer)c_med_hval < 194282), -0.0008278414, 0.0060880011));

s7_N502_4 :=  __common__( if(trim(C_MED_HVAL) != '', s7_N502_5, -0.00056087625));

s7_N502_3 :=  __common__( if(((real)_add_risk < 0.5), s7_N502_4, s7_N502_6));

s7_N502_2 :=  __common__( if(((real)add2_turnover_1yr_in < 4036.5), -0.0030661351, 0.039238233));

s7_N502_1 :=  __common__( if(((real)rc_phoneaddr_addrcount < 0.5), s7_N502_2, s7_N502_3));

s7_N503_9 :=  __common__( if((add2_avm_automated_valuation < 97727), -0.0068321235, 0.042298572));

s7_N503_8 :=  __common__( if(((real)age < 60.5), s7_N503_9, 0.052893018));

s7_N503_7 :=  __common__( map(trim(C_NO_MOVE) = ''     => 0.0049393291,
              ((real)c_no_move < 23.5) => 0.049981356,
                                          0.0049393291));

s7_N503_6 :=  __common__( map(trim(C_FAMMAR18_P) = ''      => s7_N503_7,
              ((real)c_fammar18_p < 45.15) => -0.0059543782,
                                              s7_N503_7));

s7_N503_5 :=  __common__( map(trim(C_BIGAPT_P) = ''      => 0.028141237,
              ((real)c_bigapt_p < 39.55) => s7_N503_6,
                                            0.028141237));

s7_N503_4 :=  __common__( map(trim(C_RENTAL) = ''      => s7_N503_8,
              ((real)c_rental < 148.5) => s7_N503_5,
                                          s7_N503_8));

s7_N503_3 :=  __common__( if(((real)_add_risk < 0.5), -0.00018096499, s7_N503_4));

s7_N503_2 :=  __common__( if(((real)c_vacant_p < 27.35), s7_N503_3, -0.01401764));

s7_N503_1 :=  __common__( if(trim(C_VACANT_P) != '', s7_N503_2, 0.0029643598));





s7_tnscore :=  __common__( sum(s7_N0_1, s7_N1_1, s7_N2_1, s7_N3_1, s7_N4_1, s7_N5_1, s7_N6_1, s7_N7_1, s7_N8_1, s7_N9_1, s7_N10_1, s7_N11_1, s7_N12_1, s7_N13_1, s7_N14_1, s7_N15_1, s7_N16_1, s7_N17_1, s7_N18_1, s7_N19_1, s7_N20_1, s7_N21_1, s7_N22_1, s7_N23_1, s7_N24_1, s7_N25_1, s7_N26_1, s7_N27_1, s7_N28_1, s7_N29_1, s7_N30_1, s7_N31_1, s7_N32_1, s7_N33_1, s7_N34_1, s7_N35_1, s7_N36_1, s7_N37_1, s7_N38_1, s7_N39_1, s7_N40_1, s7_N41_1, s7_N42_1, s7_N43_1, s7_N44_1, s7_N45_1, s7_N46_1, s7_N47_1, s7_N48_1, s7_N49_1, s7_N50_1, s7_N51_1, s7_N52_1, s7_N53_1, s7_N54_1, s7_N55_1, s7_N56_1, s7_N57_1, s7_N58_1, s7_N59_1, s7_N60_1, s7_N61_1, s7_N62_1, s7_N63_1, s7_N64_1, s7_N65_1, s7_N66_1, s7_N67_1, s7_N68_1, s7_N69_1, s7_N70_1, s7_N71_1, s7_N72_1, s7_N73_1, s7_N74_1, s7_N75_1, s7_N76_1, s7_N77_1, s7_N78_1, s7_N79_1, s7_N80_1, s7_N81_1, s7_N82_1, s7_N83_1, s7_N84_1, s7_N85_1, s7_N86_1, s7_N87_1, s7_N88_1, s7_N89_1, s7_N90_1, s7_N91_1, s7_N92_1, s7_N93_1, s7_N94_1, s7_N95_1, s7_N96_1, s7_N97_1, s7_N98_1, s7_N99_1, s7_N100_1, s7_N101_1, s7_N102_1, s7_N103_1, s7_N104_1, s7_N105_1, s7_N106_1, s7_N107_1, s7_N108_1, s7_N109_1, s7_N110_1, s7_N111_1, s7_N112_1, s7_N113_1, s7_N114_1, s7_N115_1, s7_N116_1, s7_N117_1, s7_N118_1, s7_N119_1, s7_N120_1, s7_N121_1, s7_N122_1, s7_N123_1, s7_N124_1, s7_N125_1, s7_N126_1, s7_N127_1, s7_N128_1, s7_N129_1, s7_N130_1, s7_N131_1, s7_N132_1, s7_N133_1, s7_N134_1, s7_N135_1, s7_N136_1, s7_N137_1, s7_N138_1, s7_N139_1, s7_N140_1, s7_N141_1, s7_N142_1, s7_N143_1, s7_N144_1, s7_N145_1, s7_N146_1, s7_N147_1, s7_N148_1, s7_N149_1, s7_N150_1, s7_N151_1, s7_N152_1, s7_N153_1, s7_N154_1, s7_N155_1, s7_N156_1, s7_N157_1, s7_N158_1, s7_N159_1, s7_N160_1, s7_N161_1, s7_N162_1, s7_N163_1, s7_N164_1, s7_N165_1, s7_N166_1, s7_N167_1, s7_N168_1, s7_N169_1, s7_N170_1, s7_N171_1, s7_N172_1, s7_N173_1, s7_N174_1, s7_N175_1, s7_N176_1, s7_N177_1, s7_N178_1, s7_N179_1, s7_N180_1, s7_N181_1, s7_N182_1, s7_N183_1, s7_N184_1, s7_N185_1, s7_N186_1, s7_N187_1, s7_N188_1, s7_N189_1, s7_N190_1, s7_N191_1, s7_N192_1, s7_N193_1, s7_N194_1, s7_N195_1, s7_N196_1, s7_N197_1, s7_N198_1, s7_N199_1, s7_N200_1, s7_N201_1, s7_N202_1, s7_N203_1, s7_N204_1, s7_N205_1, s7_N206_1, s7_N207_1, s7_N208_1, s7_N209_1, s7_N210_1, s7_N211_1, s7_N212_1, s7_N213_1, s7_N214_1, s7_N215_1, s7_N216_1, s7_N217_1, s7_N218_1, s7_N219_1, s7_N220_1, s7_N221_1, s7_N222_1, s7_N223_1, s7_N224_1, s7_N225_1, s7_N226_1, s7_N227_1, s7_N228_1, s7_N229_1, s7_N230_1, s7_N231_1, s7_N232_1, s7_N233_1, s7_N234_1, s7_N235_1, s7_N236_1, s7_N237_1, s7_N238_1, s7_N239_1, s7_N240_1, s7_N241_1, s7_N242_1, s7_N243_1, s7_N244_1, s7_N245_1, s7_N246_1, s7_N247_1, s7_N248_1, s7_N249_1, s7_N250_1, s7_N251_1, s7_N252_1, s7_N253_1, s7_N254_1, s7_N255_1, s7_N256_1, s7_N257_1, s7_N258_1, s7_N259_1, s7_N260_1, s7_N261_1, s7_N262_1, s7_N263_1, s7_N264_1, s7_N265_1, s7_N266_1, s7_N267_1, s7_N268_1, s7_N269_1, s7_N270_1, s7_N271_1, s7_N272_1, s7_N273_1, s7_N274_1, s7_N275_1, s7_N276_1, s7_N277_1, s7_N278_1, s7_N279_1, s7_N280_1, s7_N281_1, s7_N282_1, s7_N283_1, s7_N284_1, s7_N285_1, s7_N286_1, s7_N287_1, s7_N288_1, s7_N289_1, s7_N290_1, s7_N291_1, s7_N292_1, s7_N293_1, s7_N294_1, s7_N295_1, s7_N296_1, s7_N297_1, s7_N298_1, s7_N299_1, s7_N300_1, s7_N301_1, s7_N302_1, s7_N303_1, s7_N304_1, s7_N305_1, s7_N306_1, s7_N307_1, s7_N308_1, s7_N309_1, s7_N310_1, s7_N311_1, s7_N312_1, s7_N313_1, s7_N314_1, s7_N315_1, s7_N316_1, s7_N317_1, s7_N318_1, s7_N319_1, s7_N320_1, s7_N321_1, s7_N322_1, s7_N323_1, s7_N324_1, s7_N325_1, s7_N326_1, s7_N327_1, s7_N328_1, s7_N329_1, s7_N330_1, s7_N331_1, s7_N332_1, s7_N333_1, s7_N334_1, s7_N335_1, s7_N336_1, s7_N337_1, s7_N338_1, s7_N339_1, s7_N340_1, s7_N341_1, s7_N342_1, s7_N343_1, s7_N344_1, s7_N345_1, s7_N346_1, s7_N347_1, s7_N348_1, s7_N349_1, s7_N350_1, s7_N351_1, s7_N352_1, s7_N353_1, s7_N354_1, s7_N355_1, s7_N356_1, s7_N357_1, s7_N358_1, s7_N359_1, s7_N360_1, s7_N361_1, s7_N362_1, s7_N363_1, s7_N364_1, s7_N365_1, s7_N366_1, s7_N367_1, s7_N368_1, s7_N369_1, s7_N370_1, s7_N371_1, s7_N372_1, s7_N373_1, s7_N374_1, s7_N375_1, s7_N376_1, s7_N377_1, s7_N378_1, s7_N379_1, s7_N380_1, s7_N381_1, s7_N382_1, s7_N383_1, s7_N384_1, s7_N385_1, s7_N386_1, s7_N387_1, s7_N388_1, s7_N389_1, s7_N390_1, s7_N391_1, s7_N392_1, s7_N393_1, s7_N394_1, s7_N395_1, s7_N396_1, s7_N397_1, s7_N398_1, s7_N399_1, s7_N400_1, s7_N401_1, s7_N402_1, s7_N403_1, s7_N404_1, s7_N405_1, s7_N406_1, s7_N407_1, s7_N408_1, s7_N409_1, s7_N410_1, s7_N411_1, s7_N412_1, s7_N413_1, s7_N414_1, s7_N415_1, s7_N416_1, s7_N417_1, s7_N418_1, s7_N419_1, s7_N420_1, s7_N421_1, s7_N422_1, s7_N423_1, s7_N424_1, s7_N425_1, s7_N426_1, s7_N427_1, s7_N428_1, s7_N429_1, s7_N430_1, s7_N431_1, s7_N432_1, s7_N433_1, s7_N434_1, s7_N435_1, s7_N436_1, s7_N437_1, s7_N438_1, s7_N439_1, s7_N440_1, s7_N441_1, s7_N442_1, s7_N443_1, s7_N444_1, s7_N445_1, s7_N446_1, s7_N447_1, s7_N448_1, s7_N449_1, s7_N450_1, s7_N451_1, s7_N452_1, s7_N453_1, s7_N454_1, s7_N455_1, s7_N456_1, s7_N457_1, s7_N458_1, s7_N459_1, s7_N460_1, s7_N461_1, s7_N462_1, s7_N463_1, s7_N464_1, s7_N465_1, s7_N466_1, s7_N467_1, s7_N468_1, s7_N469_1, s7_N470_1, s7_N471_1, s7_N472_1, s7_N473_1, s7_N474_1, s7_N475_1, s7_N476_1, s7_N477_1, s7_N478_1, s7_N479_1, s7_N480_1, s7_N481_1, s7_N482_1, s7_N483_1, s7_N484_1, s7_N485_1, s7_N486_1, s7_N487_1, s7_N488_1, s7_N489_1, s7_N490_1, s7_N491_1, s7_N492_1, s7_N493_1, s7_N494_1, s7_N495_1, s7_N496_1, s7_N497_1, s7_N498_1, s7_N499_1, s7_N500_1, s7_N501_1, s7_N502_1, s7_N503_1));

s7_score0 :=  __common__( exp(s7_tnscore));
s7_expsum :=  __common__( exp(s7_tnscore) + exp(-s7_tnscore));
s7_prob0 :=  __common__( s7_score0 / s7_expsum);

s7_base 	:=  __common__( 700);
s7_odds 	:=  __common__( 1/200);
s7_point 	:=  __common__( -50);
     
s7_FP40_raw :=  __common__( round(s7_point*(ln(s7_prob0/(1-s7_prob0)) - ln(s7_odds) - ln(12))/ln(2) + s7_base));  





base_final  :=  __common__( 700);
odds_final  :=  __common__( 1 / 200);
point_final :=  __common__( -50);

fp40_raw :=  __common__( map(
    uv_segment3 = '0-noSSN'           => s_no_ssn_score,
    uv_segment3 = '1-ssnprob'         => round(point_final * (s1_07_logit - ln(odds_final)) / ln(2) + base_final),
    uv_segment3 = '2-nas479'          => round(point_final * (s2_07_logit - ln(odds_final)) / ln(2) + base_final),
    uv_segment3 = '3-newdid'          => round(point_final * (s3_05_logit - ln(odds_final)) / ln(2) + base_final),
    uv_segment3 = '4-bureauonly'      => round(point_final * (s4_05_logit - ln(odds_final)) / ln(2) + base_final),
    uv_segment3 = '5-derog'           => round(point_final * (s5_07_logit - ln(odds_final) - ln(6)) / ln(2) + base_final),
    uv_segment3 = '6-recentActivity'  => s6_FP40_raw,
    // uv_segment3 = '7-other'           => s7_FP40_raw 
    s7_FP40_raw 
	));

fp40 :=  __common__( max(300, min(999, if(FP40_raw = NULL, -NULL, FP40_raw))));

or_decsssn :=  __common__( (unsigned1)ssnlength > 0 and rc_decsflag = '1');

or_ssnpriordob :=  __common__( (unsigned1)ssnlength > 0 and (integer)dobpop = 1 and rc_ssndobflag = '1');

or_prisonaddr :=  __common__( rc_hrisksic = '2225');

or_prisonphone :=  __common__( (integer)hphnpop = 1 and rc_hrisksicphone = '2225');

or_hraddr :=  __common__( rc_hriskaddrflag = '4' or rc_addrcommflag = '2');

or_hrphone :=  __common__( (integer)hphnpop = 1 and (rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '1'));

or_invalidssn :=  __common__( (unsigned1)ssnlength > 0 and (rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3'])));

or_invalidaddr :=  __common__( rc_addrvalflag != 'V');

or_invalidphone :=  __common__( (integer)hphnpop = 1 and (rc_phonevalflag = '0' or rc_hphonevalflag = '0'));

fp40_cap_9 :=  __common__( fp40);

fp40_cap_8 :=  __common__( if((integer)or_decsssn = 1, min(if(fp40_cap_9 = NULL, -NULL, fp40_cap_9), 499), fp40_cap_9));

fp40_cap_7 :=  __common__( if((integer)or_ssnpriordob = 1, min(if(fp40_cap_8 = NULL, -NULL, fp40_cap_8), 499), fp40_cap_8));

fp40_cap_6 :=  __common__( if((integer)or_prisonaddr = 1, min(if(fp40_cap_7 = NULL, -NULL, fp40_cap_7), 499), fp40_cap_7));

fp40_cap_5 :=  __common__( if((integer)or_prisonphone = 1, min(if(fp40_cap_6 = NULL, -NULL, fp40_cap_6), 499), fp40_cap_6));

fp40_cap_4 :=  __common__( if((integer)or_hraddr = 1, min(if(fp40_cap_5 = NULL, -NULL, fp40_cap_5), 765), fp40_cap_5));

fp40_cap_3 :=  __common__( if((integer)or_hrphone = 1, min(if(fp40_cap_4 = NULL, -NULL, fp40_cap_4), 765), fp40_cap_4));

fp40_cap_2 :=  __common__( if((integer)or_invalidssn = 1, min(if(fp40_cap_3 = NULL, -NULL, fp40_cap_3), 765), fp40_cap_3));

fp40_cap_1 :=  __common__( if((integer)or_invalidaddr = 1, min(if(fp40_cap_2 = NULL, -NULL, fp40_cap_2), 765), fp40_cap_2));

fp40_cap :=  __common__( if((integer)or_invalidphone = 1, min(if(fp40_cap_1 = NULL, -NULL, fp40_cap_1), 765), fp40_cap_1));

stolidscr :=  __common__( if((uv_segment3 in ['1-ssnprob', '2-nas479', '6-recentActivity']), fp40, 299));

stolidindex :=  __common__( map(
    stolidscr <= 299 => 1,
    stolidscr <= 300 => 9,
    stolidscr <= 420 => 8,
    stolidscr <= 500 => 7,
    stolidscr <= 630 => 6,
    stolidscr <= 680 => 5,
    stolidscr <= 700 => 4,
    stolidscr <= 720 => 3,
    stolidscr <= 999 => 2,
                        99));

synthidscr :=  __common__( if((uv_segment3 in ['1-ssnprob', '3-newdid', '4-bureauonly']), fp40, 299));

synthidindex :=  __common__( map(
    synthidscr <= 299 => 1,
    synthidscr <= 330 => 9,
    synthidscr <= 430 => 8,
    synthidscr <= 510 => 7,
    synthidscr <= 580 => 6,
    synthidscr <= 630 => 5,
    synthidscr <= 680 => 4,
    synthidscr <= 720 => 3,
    synthidscr <= 999 => 2,
                         99));

ssn_adl_prob2 :=  __common__( ssns_per_adl >= 4 or ssns_per_adl_c6 >= 2);

dseg :=  __common__( map(
    ver_src_DS or rc_decsflag = '1' or rc_ssndobflag = '1' or rc_pwssndobflag = '1' => 1,
    nas_summary = 4 or nas_summary = 7 or nas_summary = 9                                                 => 2,
    nap_summary <= 4 and nas_summary <= 4                                                                 => 3,
    rc_ssnmiskeyflag or rc_addrmiskeyflag or (integer)add1_house_number_match = 0                         => 4,
    ssn_adl_prob2 or lnames_per_adl_c6 > 1                                                                => 5,
                                                                                                             6));

manipidscr :=  __common__( if((dseg in [4, 5]) or (uv_segment3 in ['6-recentActivity', '7-other']), fp40, 299));

manipidindex :=  __common__( map(
    manipidscr <= 299 => 1,
    manipidscr <= 350 => 9,
    manipidscr <= 520 => 8,
    manipidscr <= 590 => 7,
    manipidscr <= 630 => 6,
    manipidscr <= 660 => 5,
    manipidscr <= 680 => 4,
    manipidscr <= 700 => 3,
    manipidscr <= 720 => 2,
    manipidscr <= 999 => 1,
                         99));

suspactscr :=  __common__( if(uv_segment3 = '5-derog', fp40, 299));

suspactindex :=  __common__( map(
    suspactscr <= 299 => 1,
    suspactscr <= 350 => 9,
    suspactscr <= 480 => 8,
    suspactscr <= 550 => 7,
    suspactscr <= 610 => 6,
    suspactscr <= 650 => 5,
    suspactscr <= 700 => 4,
    suspactscr <= 740 => 3,
    suspactscr <= 999 => 2,
                         99));

vulnvicscr :=  __common__( if(inferred_age <= 17 or inferred_age >= 70, fp40, 299));

vulnvicindex :=  __common__( map(
    vulnvicscr <= 299 => 1,
    vulnvicscr <= 400 => 9,
    vulnvicscr <= 490 => 8,
    vulnvicscr <= 570 => 7,
    vulnvicscr <= 620 => 6,
    vulnvicscr <= 660 => 5,
    vulnvicscr <= 700 => 4,
    vulnvicscr <= 730 => 3,
    vulnvicscr <= 999 => 2,
                         99));

friendfrdscr :=  __common__( if(rel_felony_count > 0 or rel_count_addr > 1 or inferred_age >= 70, fp40, 299));

friendfrdindex :=  __common__( map(
    friendfrdscr <= 299 => 1,
    friendfrdscr <= 340 => 9,
    friendfrdscr <= 450 => 8,
    friendfrdscr <= 570 => 7,
    friendfrdscr <= 620 => 6,
    friendfrdscr <= 660 => 5,
    friendfrdscr <= 690 => 4,
    friendfrdscr <= 710 => 3,
    friendfrdscr <= 730 => 2,
    friendfrdscr <= 999 => 1,
                           99));



		self.seq :=  le.bs.seq;
		
		ritmp :=  __common__( Models.fraudpoint_reasons(le.bs, le.ip, num_reasons, criminal ));
    reasons :=  __common__( Models.Common.checkFraudPointRC34(fp40_cap, ritmp, num_reasons));
    self.ri := reasons;
		self.score := (string)fp40_cap;
		
		self.StolenIdentityIndex        := (string1)stolidindex;
		self.SyntheticIdentityIndex     := (string1)synthidindex;
		self.ManipulatedIdentityIndex   := (string1)manipidindex;
		self.VulnerableVictimIndex      := (string1)vulnvicindex;
		self.FriendlyFraudIndex         := (string1)friendfrdindex;
		self.SuspiciousActivityIndex    := (string1)suspactindex;

	end;

	model :=   join(clam_ip, Easi.Key_Easi_Census,
		left.bs.shell_input.st<>''
			and left.bs.shell_input.county <>''
			and left.bs.shell_input.geo_blk <> ''
			and keyed(right.geolink=left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk),
		doModel(left, right), left outer,
		atmost(RiskWise.max_atmost)
		,keep(1)
	);
	return model;

end;

