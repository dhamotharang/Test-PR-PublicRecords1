// RVA1309_1: SFG Finance

import risk_indicators, riskwise, riskwisefcra, ut, std, riskview; 

export RVA1309_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clamPre, BOOLEAN isCalifornia = FALSE, BOOLEAN isFCRA = TRUE) := FUNCTION

	msa_bocashell := RECORD
		risk_indicators.Layout_Boca_Shell;
		string50 msa;
	end;

	clam := join(clamPre, Models.Key_MSA_Zip_Lookup(isFCRA), KEYED(left.shell_input.z5 = right.zip), 
							  TRANSFORM(msa_bocashell, self.msa:= right.msa, self:=left),
								left outer, keep(1));

  RVA_DEBUG := false;

  #if(RVA_DEBUG)
    layout_debug := record		
			
			INTEGER	 sysdate;
			integer	 ver_src_ba_pos;
			boolean	 ver_src_ba;
			integer	 ver_src_ds_pos;
			boolean	 ver_src_ds;
			integer	 ver_src_l2_pos;
			boolean	 ver_src_l2;
			integer	 ver_src_li_pos;
			boolean	 ver_src_li;
			integer	 iv_vp003_phn_invalid;
			integer	 iv_va060_dist_add_in_bst;
			STRING	 iv_db001_bankruptcy;
			integer	 iv_de001_eviction_recency;
			integer	 _header_first_seen;
			integer	 iv_sr001_m_hdr_fs;
			integer	 iv_ms001_ssns_per_adl;
			integer	 iv_mi001_adlperssn_count;
			integer	 iv_addr_non_phn_src_ct;
			integer	 iv_combined_age;
			integer	 iv_addrs_10yr;
			integer	 _gong_did_first_seen;
			integer	 iv_mos_since_gong_did_fst_seen;
			integer	 iv_gong_did_phone_ct;
			integer	 iv_ssns_per_addr_c6;
			integer	 iv_inq_recency;
			integer	 iv_inq_highriskcredit_count12;
			integer	 iv_inq_lnames_per_addr;
			integer	 _infutor_first_seen;
			integer	 iv_mos_since_infutor_first_seen;
			boolean	 ver_phn_inf;
			boolean	 ver_phn_nap;
			integer	 inf_phn_ver_lvl;
			integer	 nap_phn_ver_lvl;
			STRING	 iv_nap_phn_ver_x_inf_phn_ver;
			integer	 _impulse_last_seen;
			integer	 iv_mos_since_impulse_last_seen;
			integer	 iv_attr_bankruptcy_recency;
			integer	 iv_non_derog_count;
			integer	 iv_unreleased_liens_ct;
			string	 iv_criminal_x_felony;
			integer	 _reported_dob;
			integer	 reported_age;
			integer	 _combined_age;
			boolean	 evidence_of_college;
			STRING	 iv_college_attendance_x_age;
			integer	 iv_pb_average_dollars;
			integer	 iv_pl001_addr_stability_v2;
			integer	 iv_iq001_inq_count12;
			integer	 bureau_lname_tn_fseen_pos;
			string	 bureau_lname_fseen_tn;
			integer	 _bureau_lname_fseen_tn;
			integer	 bureau_lname_ts_fseen_pos;
			string	 bureau_lname_fseen_ts;
			integer	 _bureau_lname_fseen_ts;
			integer	 bureau_lname_tu_fseen_pos;
			string	 bureau_lname_fseen_tu;
			integer	 _bureau_lname_fseen_tu;
			integer	 bureau_lname_en_fseen_pos;
			string	 bureau_lname_fseen_en;
			integer	 _bureau_lname_fseen_en;
			integer	 bureau_lname_eq_fseen_pos;
			string	 bureau_lname_fseen_eq;
			integer	 _bureau_lname_fseen_eq;
			integer	 _src_bureau_lname_fseen;
			integer	 iv_mos_src_bureau_lname_fseen;
			string	 iv_inp_own_prop_x_addr_naprop;
			integer	 iv_addrs_per_adl;
			integer	 iv_inq_highriskcredit_recency;
			integer	 _impulse_first_seen;
			integer	 iv_mos_since_impulse_first_seen;
			STRING	 _msa;
			STRING	 _msa_group;
			real		 allinputs_subscore0;
			real		 allinputs_subscore1;
			real		 allinputs_subscore2;
			real		 allinputs_subscore3;
			real		 allinputs_subscore4;
			real		 allinputs_subscore5;
			real		 allinputs_subscore6;
			real		 allinputs_subscore7;
			real		 allinputs_subscore8;
			real		 allinputs_subscore9;
			real		 allinputs_subscore10;
			real		 allinputs_subscore11;
			real		 allinputs_subscore12;
			real		 allinputs_subscore13;
			real		 allinputs_subscore14;
			real		 allinputs_subscore15;
			real		 allinputs_subscore16;
			real		 allinputs_subscore17;
			real		 allinputs_subscore18;
			real		 allinputs_subscore19;
			real		 allinputs_subscore20;
			real		 allinputs_subscore21;
			real		 allinputs_subscore22;
			real		 allinputs_subscore23;
			real		 allinputs_subscore24;
			real		 allinputs_subscore25;
			real		 allinputs_rawscore;
			real		 allinputs_lnoddsscore;
			real		 nameaddr_subscore0;
			real		 nameaddr_subscore1;
			real		 nameaddr_subscore2;
			real		 nameaddr_subscore3;
			real		 nameaddr_subscore4;
			real		 nameaddr_subscore5;
			real		 nameaddr_subscore6;
			real		 nameaddr_subscore7;
			real		 nameaddr_subscore8;
			real		 nameaddr_subscore9;
			real		 nameaddr_subscore10;
			real		 nameaddr_subscore11;
			real		 nameaddr_subscore12;
			real		 nameaddr_subscore13;
			real		 nameaddr_subscore14;
			real		 nameaddr_subscore15;
			real		 nameaddr_subscore16;
			real		 nameaddr_subscore17;
			real		 nameaddr_rawscore;
			real		 nameaddr_lnoddsscore;
			string	 model_used;
			real		 point;
			real		 base;
			real		 odds;
			integer	 _rva1309_1_0;
			boolean	 bk_flag;
			boolean	 lien_rec_unrel_flag;
			boolean	 lien_hist_unrel_flag;
			boolean	 lien_flag;
			boolean	 ssn_deceased;
			boolean	 scored_222s;
			integer	 rva1309_1_0;
			boolean	 glrc08;
			boolean	 glrc97;
			boolean	 glrc98;
			boolean	 glrc9a;
			boolean	 glrc9d;
			boolean	 glrc9e;
			boolean	 glrc9f;
			boolean	 glrc9g;
			boolean	 glrc9h;
			boolean	 glrc9i;
			boolean	 glrc9o;
			boolean	 glrc9q;
			boolean	 glrc9r;
			boolean	 glrc9w;
			// boolean	 glrc9y;
			boolean	 glrcev;
			boolean	 glrcmi;
			boolean	 glrcms;
			boolean	 glrcbl;
			real		 rcvalue9o_1;
			real		 rcvalue9o;
			// real		 rcvalue9y_1;
			// real		 rcvalue9y;
			real		 rcvalue9f_1;
			real		 rcvalue9f_2;
			real		 rcvalue9f;
			real		 rcvalue9q_1;
			real		 rcvalue9q_2;
			real		 rcvalue9q_3;
			real		 rcvalue9q;
			real		 rcvalueev_1;
			real		 rcvalueev;
			real		 rcvalue9d_1;
			real		 rcvalue9d;
			real		 rcvalue98_1;
			real		 rcvalue98;
			real		 rcvalue9r_1;
			real		 rcvalue9r;
			real		 rcvaluems_1;
			real		 rcvaluems;
			real		 rcvalue9h_1;
			real		 rcvalue9h;
			real		 rcvalue08_1;
			real		 rcvalue08;
			real		 rcvaluemi_1;
			real		 rcvaluemi;
			real		 rcvalue9w_2;
			real		 rcvalue9w_1;
			real		 rcvalue9w;
			real		 rcvalue97_1;
			real		 rcvalue97;
			real		 rcvalue9e_1;
			real		 rcvalue9e_2;
			real		 rcvalue9e;
			real		 rcvalue9g_1;
			real		 rcvalue9g;
			real		 rcvalue9i_1;
			real		 rcvalue9i;
			real		 rcvaluebl_1;
			real		 rcvaluebl_2;
			real		 rcvaluebl_3;
			real		 rcvaluebl_4;
			real		 rcvaluebl;			
			real		 rcvalue9a_1;
			real		 rcvalue9a;

			STRING	 rc1;
			STRING	 rc2;
			STRING	 rc3;
			STRING	 rc4;
			STRING	 rc5;

			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	msa_name                         := le.msa;
	truedid                          := le.truedid;
	out_st                           := le.shell_input.st;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcount                     := le.iid.addrcount;
	rc_phonetype                     := le.iid.phonetype;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_lname_sources                := le.header_summary.ver_lname_sources;
	ver_lname_sources_first_seen     := le.header_summary.ver_lname_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	header_first_seen                := le.ssn_verification.header_first_seen;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	inq_count                        := le.acc_logs.inquiries.counttotal;
	inq_count01                      := le.acc_logs.inquiries.count01;
	inq_count03                      := le.acc_logs.inquiries.count03;
	inq_count06                      := le.acc_logs.inquiries.count06;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_count24                      := le.acc_logs.inquiries.count24;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_lnamesperaddr                := le.acc_logs.inquirylnamesperaddr;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	pb_total_dollars                 := le.ibehavior.total_dollars;
	infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_first_seen               := le.impulse.first_seen_date;
	impulse_last_seen                := le.impulse.last_seen_date;
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
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_age                          := le.student.age;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	addr_stability_v2                := le.addr_stability;
	
	NULL := -999999999;

	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

	ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');

	ver_src_ba := ver_src_ba_pos > 0;

	ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');

	ver_src_ds := ver_src_ds_pos > 0;

	ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');

	ver_src_l2 := ver_src_l2_pos > 0;

	ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');

	ver_src_li := ver_src_li_pos > 0;

	sysdate := Models.common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

	iv_vp003_phn_invalid := map(
			not(hphnpop)                                                    => NULL,
			rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5' => 1,
																																				 0);

	iv_va060_dist_add_in_bst := map(
			not(truedid)       => NULL,
			add1_isbestmatch   => 0,
			dist_a1toa2 = 9999 => NULL,
														dist_a1toa2);

	iv_db001_bankruptcy := map(
			not(truedid or (integer)ssnlength > 0)                                                                                               => '                 ',
			(disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
			(disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
			(rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
																																																																		 '0 - No BK        ');

	iv_de001_eviction_recency := map(
			not(truedid)                                                => NULL,
			(boolean)attr_eviction_count90                              => 3,
			(boolean)attr_eviction_count180                             => 6,
			(boolean)attr_eviction_count12                              => 12,
			(boolean)attr_eviction_count24 and attr_eviction_count >= 2 => 24,
			(boolean)attr_eviction_count24                              => 25,
			(boolean)attr_eviction_count36 and attr_eviction_count >= 2 => 36,
			(boolean)attr_eviction_count36                              => 37,
			(boolean)attr_eviction_count60 and attr_eviction_count >= 2 => 60,
			(boolean)attr_eviction_count60                              => 61,
			attr_eviction_count >= 2                                    => 98,
			attr_eviction_count >= 1                                    => 99,
																																		 0);

	_header_first_seen := Models.common.sas_date((string)(header_first_seen));

	iv_sr001_m_hdr_fs := map(
			not(truedid)                   => NULL,
			not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
																				-1);

	iv_ms001_ssns_per_adl := map(
			not(truedid)     => NULL,
			ssns_per_adl = 0 => 1,
													ssns_per_adl);

	iv_mi001_adlperssn_count := map(
			not((integer)ssnlength > 0)  => NULL,
			adlperssn_count = 0 => 1,
														 adlperssn_count);

	iv_addr_non_phn_src_ct := if(not(truedid) and add1_pop, NULL, rc_addrcount);

	_reported_dob_1 := Models.common.sas_date((string)(reported_dob));

	reported_age_1 := if(min(sysdate, _reported_dob_1) = NULL, NULL, truncate((sysdate - _reported_dob_1) / 365.25));

	iv_combined_age := map(
			not(truedid or dobpop) => NULL,
			age > 0                => age,
			(integer)input_dob_age > 0      => (integer)input_dob_age,
			inferred_age > 0       => inferred_age,
			reported_age_1 > 0     => reported_age_1,
			(integer)ams_age > 0            => (integer)ams_age,
																-1);

	iv_addrs_10yr := map(
			not(truedid)          => NULL,
			unique_addr_count = 0 => -1,
															 addrs_10yr);

	_gong_did_first_seen := Models.common.sas_date((string)(gong_did_first_seen));

	iv_mos_since_gong_did_fst_seen := map(
			not(truedid)                     => NULL,
			not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
																					-1);

	iv_gong_did_phone_ct := if(not(truedid), NULL, gong_did_phone_ct);

	iv_ssns_per_addr_c6 := if(not(add1_pop), NULL, ssns_per_addr_c6);

	iv_inq_recency := map(
			not(truedid) => NULL,
			(boolean)inq_count01  => 1,
			(boolean)inq_count03  => 3,
			(boolean)inq_count06  => 6,
			(boolean)inq_count12  => 12,
			(boolean)inq_count24  => 24,
			(boolean)inq_count    => 99,
											0);

	iv_inq_highriskcredit_count12 := if(not(truedid), NULL, inq_highRiskCredit_count12);

	iv_inq_lnames_per_addr := if(not(add1_pop), NULL, inq_lnamesperaddr);

	_infutor_first_seen := Models.common.sas_date((string)(infutor_first_seen));

	iv_mos_since_infutor_first_seen := map(
			not(hphnpop)                    => NULL,
			not(_infutor_first_seen = NULL) => if ((sysdate - _infutor_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _infutor_first_seen) / (365.25 / 12)), roundup((sysdate - _infutor_first_seen) / (365.25 / 12))),
																				 -1);

	ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

	ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

	inf_phn_ver_lvl := map(
			ver_phn_inf     => 3,
			infutor_nap = 1 => 1,
			infutor_nap = 0 => 0,
												 2);

	nap_phn_ver_lvl := map(
			ver_phn_nap     => 3,
			nap_summary = 1 => 1,
			nap_summary = 0 => 0,
												 2);

	iv_nap_phn_ver_x_inf_phn_ver := map(
			not(addrpop or hphnpop) => '   ',
			not(hphnpop)            => ' -1',
																 (string)nap_phn_ver_lvl + '-' + (string)inf_phn_ver_lvl);

	_impulse_last_seen := Models.common.sas_date((string)impulse_last_seen);

	iv_mos_since_impulse_last_seen := map(
			not(truedid)                   => NULL,
			not(_impulse_last_seen = NULL) => if ((sysdate - _impulse_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_last_seen) / (365.25 / 12)), roundup((sysdate - _impulse_last_seen) / (365.25 / 12))),
																				-1);

	iv_attr_bankruptcy_recency := map(
			not(truedid)                      => NULL,
			(boolean)attr_bankruptcy_count30           => 1,
			(boolean)attr_bankruptcy_count90           => 3,
			(boolean)attr_bankruptcy_count180          => 6,
			(boolean)attr_bankruptcy_count12           => 12,
			(boolean)attr_bankruptcy_count24           => 24,
			(boolean)attr_bankruptcy_count36           => 36,
			(boolean)attr_bankruptcy_count60           => 60,
			(rc_bansflag in ['1', '2'])       => 99,
			bankrupt                          => 99,
			contains_i(ver_sources, 'BA') > 0 => 99,
			filing_count > 0                  => 99,
			bk_recent_count > 0               => 99,
																					 0);

	iv_non_derog_count := if(not(truedid), NULL, attr_num_nonderogs);

	iv_unreleased_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))));

	iv_criminal_x_felony := if(not(truedid), '   ', (string)min(if(criminal_count = NULL, -NULL, criminal_count), 3) + '-' + (string)min(if(felony_count = NULL, -NULL, felony_count), 3));

	_reported_dob := Models.common.sas_date((string)(reported_dob));

	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));

	_combined_age := map(
			age > 0           => age,
			(integer)input_dob_age > 0 => (integer)input_dob_age,
			inferred_age > 0  => inferred_age,
			reported_age > 0  => reported_age,
			(integer)ams_age > 0       => (integer)ams_age,
													 -1);

	evidence_of_college := not(ams_college_code = '') or not(ams_college_type = '');

	clg(boolean iscollege, integer age) := if(iscollege, 'Y','N') + (string)((integer)(min(age, 60) / 10) * 10);

	iv_college_attendance_x_age := map(
			not(truedid or dobpop) => '',
			_combined_age = -1     => '',
																clg(evidence_of_college, _combined_age) );

	iv_pb_average_dollars := map(
			not(truedid)              => NULL,
			pb_average_dollars = '' => -1,
																	 (integer)pb_average_dollars);

	iv_pl001_addr_stability_v2 := if(not(truedid), NULL, (integer)addr_stability_v2);

	iv_iq001_inq_count12 := if(not(truedid), NULL, inq_count12);

	bureau_lname_tn_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TN' , ', ', 'E');

	bureau_lname_fseen_tn := if(bureau_lname_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_tn_fseen_pos, ','));

	_bureau_lname_fseen_tn := Models.common.sas_date((string)(bureau_lname_fseen_tn));

	bureau_lname_ts_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TS' , ', ', 'E');

	bureau_lname_fseen_ts := if(bureau_lname_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_ts_fseen_pos, ','));

	_bureau_lname_fseen_ts := Models.common.sas_date((string)(bureau_lname_fseen_ts));

	bureau_lname_tu_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'TU' , ', ', 'E');

	bureau_lname_fseen_tu := if(bureau_lname_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_tu_fseen_pos, ','));

	_bureau_lname_fseen_tu := Models.common.sas_date((string)(bureau_lname_fseen_tu));

	bureau_lname_en_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'EN' , ', ', 'E');

	bureau_lname_fseen_en := if(bureau_lname_en_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_en_fseen_pos, ','));

	_bureau_lname_fseen_en := Models.common.sas_date((string)(bureau_lname_fseen_en));

	bureau_lname_eq_fseen_pos := Models.Common.findw_cpp(ver_Lname_sources, 'EQ' , ', ', 'E');

	bureau_lname_fseen_eq := if(bureau_lname_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_Lname_sources_first_seen, bureau_lname_eq_fseen_pos, ','));

	_bureau_lname_fseen_eq := Models.common.sas_date((string)(bureau_lname_fseen_eq));

	_src_bureau_lname_fseen := if(max(_bureau_lname_fseen_tn, _bureau_lname_fseen_ts, _bureau_lname_fseen_tu, _bureau_lname_fseen_en, _bureau_lname_fseen_eq) = NULL, NULL, min(if(_bureau_lname_fseen_tn = NULL, -NULL, _bureau_lname_fseen_tn), if(_bureau_lname_fseen_ts = NULL, -NULL, _bureau_lname_fseen_ts), if(_bureau_lname_fseen_tu = NULL, -NULL, _bureau_lname_fseen_tu), if(_bureau_lname_fseen_en = NULL, -NULL, _bureau_lname_fseen_en), if(_bureau_lname_fseen_eq = NULL, -NULL, _bureau_lname_fseen_eq)));

	iv_mos_src_bureau_lname_fseen := map(
			not(truedid)                   => NULL,
			_src_bureau_lname_fseen = NULL => -1,
																				if ((sysdate - _src_bureau_lname_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_lname_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_lname_fseen) / (365.25 / 12))));

	iv_inp_own_prop_x_addr_naprop := map(
			not(add1_pop)            => '',
			property_owned_total > 0 => (string)(add1_naprop + 10),
																	('0' + (string)add1_naprop)[-2..]
			);

	iv_addrs_per_adl := if(not(truedid), NULL, addrs_per_adl);

	iv_inq_highriskcredit_recency := map(
			not(truedid)               => NULL,
			(boolean)inq_highRiskCredit_count01 => 1,
			(boolean)inq_highRiskCredit_count03 => 3,
			(boolean)inq_highRiskCredit_count06 => 6,
			(boolean)inq_highRiskCredit_count12 => 12,
			(boolean)inq_highRiskCredit_count24 => 24,
			(boolean)inq_highRiskCredit_count   => 99,
																		0);

	_impulse_first_seen := Models.common.sas_date((string)impulse_first_seen);

	iv_mos_since_impulse_first_seen := map(
			not(truedid)                    => NULL,
			not(_impulse_first_seen = NULL) => if ((sysdate - _impulse_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _impulse_first_seen) / (365.25 / 12)), roundup((sysdate - _impulse_first_seen) / (365.25 / 12))),
																				 -1);
	msa_used_names := [
			'LOS ANGELES-LONG BEACH-SANTAANA, CA',
			'HOUSTON-SUGAR LAND-BAYTOWN,TX',
			'CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI',
			'DALLAS-FORT WORTH-ARLINGTON,TX',
			'MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL',
			'SAN FRANCISCO-OAKLAND-FREMONT, CA',
			'NEW YORK-NORTHERN NEW JERSEY',
			'ATLANTA-SANDY SPRINGS-MARIETTA, GA',
			'DETROIT-WARREN-LIVONIA, MI',
			'SAN DIEGO-CARLSBAD-SAN MARCOS, CA',
			'INDIANAPOLIS-CARMEL, IN',
			'SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA',
			'ST. LOUIS, MO-IL',
			'SD NONMETROPOLITAN AREA',
			'SAN JOSE-SUNNYVALE-SANTACLARA, CA',
			'TX NONMETROPOLITAN AREA',
			'MILWAUKEE-WAUKESHA-WEST ALLIS, WI',
			'SAN ANTONIO, TX',
			'RIVERSIDE-SAN BERNARDINO-ONTARIO, CA',
			'CLEVELAND-ELYRIA-MENTOR,OH',
			'AUSTIN-ROUND ROCK, TX',
			'COLUMBUS, OH',
			'KANSAS CITY, MO-KS',
			'FRESNO, CA',
			'BAKERSFIELD, CA',
			'MS NONMETROPOLITAN AREA',
			'MEMPHIS, TN-AR-MS',
			'BOSTON-CAMBRIDGE-QUINCY,MA-NH',
			'HARTFORD-WEST HARTFORD-EASTHARTFORD, CT',
			'WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV',
			'ORLANDO-KISSIMMEE, FL',
			'NEW HAVEN-MILFORD, CT',
			'OK NONMETROPOLITAN AREA',
			'JACKSONVILLE, FL',
			'BIRMINGHAM-HOOVER, AL',
			'OKLAHOMA CITY, OK',
			'NEW ORLEANS-METAIRIE-KENNER,LA',
			'PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD',
			'LA NONMETROPOLITAN AREA',
			'CHARLOTTE-GASTONIA-CONCORD,NC-SC',
			'EL PASO, TX',
			'CA NONMETROPOLITAN AREA',
			'AR NONMETROPOLITAN AREA',
			'STOCKTON, CA',
			'MCALLEN-EDINBURG-MISSION,TX',
			'SAN JUAN-CAGUAS-GUAYNABO,PR',
			'NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN',
			'VISALIA-PORTERVILLE, CA',
			'MO NONMETROPOLITAN AREA',
			'LOUISVILLE/JEFFERSON COUNTY,KY-IN',
			'MT NONMETROPOLITAN AREA',
			'LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR',
			'BATON ROUGE, LA',
			'BRIDGEPORT-STAMFORD-NORWALK,CT',
			'KY NONMETROPOLITAN AREA',
			'SEATTLE-TACOMA-BELLEVUE,WA',
			'GRAND RAPIDS-WYOMING, MI',
			'MODESTO, CA',
			'NC NONMETROPOLITAN AREA',
			'MI NONMETROPOLITAN AREA',
			'GA NONMETROPOLITAN AREA',
			'SALINAS, CA',
			'RENO-SPARKS, NV',
			'TULSA, OK',
			'RALEIGH-CARY, NC',
			'CO NONMETROPOLITAN AREA',
			'TN NONMETROPOLITAN AREA',
			'KS NONMETROPOLITAN AREA',
			'AL NONMETROPOLITAN AREA',
			'WICHITA, KS',
			'SANTA ROSA-PETALUMA, CA',
			'JACKSON, MS',
			'DAYTON, OH',
			'OH NONMETROPOLITAN AREA',
			'PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA',
			'ND NONMETROPOLITAN AREA',
			'IN NONMETROPOLITAN AREA',
			'AKRON, OH',
			'VALLEJO-FAIRFIELD, CA',
			'COLUMBIA, SC',
			'PHOENIX-MESA-SCOTTSDALE,AZ',
			'BROWNSVILLE-HARLINGEN, TX',
			'GREENVILLE-MAULDIN-EASLEY, SC',
			'BEAUMONT-PORT ARTHUR, TX',
			'FARMINGTON, NM',
			'PORTLAND-VANCOUVER-BEAVERTON, OR-WA',
			'PORT ST. LUCIE, FL',
			'TOLEDO, OH',
			'MERCED, CA',
			'SPRINGFIELD, MO',
			'FL NONMETROPOLITAN AREA',
			'SANTA CRUZ-WATSONVILLE, CA'
	];
	_msa := if( MSA_NAME in msa_used_names, MSA_NAME, 'STATE: ' + out_st);


	_msa_group := map(
			_msa in ['AL NONMETROPOLITAN AREA','AR NONMETROPOLITAN AREA','GA NONMETROPOLITAN AREA','KY NONMETROPOLITAN AREA','LA NONMETROPOLITAN AREA','MS NONMETROPOLITAN AREA','NC NONMETROPOLITAN AREA','STATE: LA','TN NONMETROPOLITAN AREA'] => 'A ',
			_msa in ['BATON ROUGE, LA','JACKSON, MS','NEW ORLEANS-METAIRIE-KENNER,LA','STATE: AL','STATE: MS'] => 'B ',
			_msa in ['BEAUMONT-PORT ARTHUR, TX','BROWNSVILLE-HARLINGEN, TX','DALLAS-FORT WORTH-ARLINGTON,TX','EL PASO, TX','HOUSTON-SUGAR LAND-BAYTOWN,TX','MCALLEN-EDINBURG-MISSION,TX','SAN ANTONIO, TX','TX NONMETROPOLITAN AREA'] => 'C ',
			_msa in ['AKRON, OH','CLEVELAND-ELYRIA-MENTOR,OH','OH NONMETROPOLITAN AREA','STATE: OH','TOLEDO, OH'] => 'D ',
			_msa in ['AUSTIN-ROUND ROCK, TX'] => 'E ',
			_msa in ['ATLANTA-SANDY SPRINGS-MARIETTA, GA','BIRMINGHAM-HOOVER, AL','STATE: GA'] => 'F ',
			_msa in ['COLUMBUS, OH','DAYTON, OH'] => 'G ',
			_msa in ['BAKERSFIELD, CA','CA NONMETROPOLITAN AREA','FRESNO, CA','MERCED, CA','SACRAMENTO-ARDEN-ARCADE-ROSEVILLE, CA','SD NONMETROPOLITAN AREA','STOCKTON, CA','VALLEJO-FAIRFIELD, CA','VISALIA-PORTERVILLE, CA'] => 'H ',
			_msa in ['BOSTON-CAMBRIDGE-QUINCY,MA-NH','NEW YORK-NORTHERN NEW JERSEY','PHILADELPHIA-CAMDEN-WILMINGTON, PA-NJ-DE-MD','STATE: NJ','STATE: NY','STATE: PA','STATE: VI','WASHINGTON-ARLINGTON-ALEXANDRIA, DC-VA-MD-WV'] => 'I ',
			_msa in ['BRIDGEPORT-STAMFORD-NORWALK,CT','HARTFORD-WEST HARTFORD-EASTHARTFORD, CT','NEW HAVEN-MILFORD, CT','PROVIDENCE-NEW BEDFORD-FALLRIVER, RI-MA','STATE: CT'] => 'J ',
			_msa in ['CHARLOTTE-GASTONIA-CONCORD,NC-SC','COLUMBIA, SC','GREENVILLE-MAULDIN-EASLEY, SC','LOUISVILLE/JEFFERSON COUNTY,KY-IN','MEMPHIS, TN-AR-MS','RALEIGH-CARY, NC','STATE: KY','STATE: NC','STATE: SC','STATE: TN','STATE: WV'] => 'K ',
			_msa in ['CHICAGO-NAPERVILLE-JOLIET, IL-IN-WI'] => 'L ',
			_msa in ['CO NONMETROPOLITAN AREA','FARMINGTON, NM','MT NONMETROPOLITAN AREA','ND NONMETROPOLITAN AREA','STATE: CO','STATE: ID','STATE: MT','STATE: ND','STATE: SD','STATE: UT','STATE: WY'] => 'M ',
			_msa in ['DETROIT-WARREN-LIVONIA, MI','MILWAUKEE-WAUKESHA-WEST ALLIS, WI'] => 'N ',
			_msa in ['FL NONMETROPOLITAN AREA','JACKSONVILLE, FL','ORLANDO-KISSIMMEE, FL','PORT ST. LUCIE, FL','STATE: FL'] => 'O ',
			_msa in ['GRAND RAPIDS-WYOMING, MI','MI NONMETROPOLITAN AREA','STATE: IA','STATE: MI','STATE: MN','STATE: WI'] => 'P ',
			_msa in ['IN NONMETROPOLITAN AREA','INDIANAPOLIS-CARMEL, IN','STATE: IN'] => 'Q ',
			_msa in ['KANSAS CITY, MO-KS','KS NONMETROPOLITAN AREA','LITTLE ROCK-NORTH LITTLEROCK-CONWAY, AR','MO NONMETROPOLITAN AREA','OK NONMETROPOLITAN AREA','OKLAHOMA CITY, OK','SPRINGFIELD, MO','STATE: KS','STATE: NE','STATE: OK','STATE: TX',
														 'TULSA, OK','WICHITA, KS'] => 'R ',
			_msa in ['LOS ANGELES-LONG BEACH-SANTAANA, CA','MODESTO, CA','RIVERSIDE-SAN BERNARDINO-ONTARIO, CA','SAN DIEGO-CARLSBAD-SAN MARCOS, CA','STATE:','STATE: HI'] => 'S ',
			_msa in ['MIAMI-FORT LAUDERDALE-POMPANO BEACH, FL'] => 'T ',
			_msa in ['NASHVILLE-DAVIDSON-MURFREESBORO-FRANKLIN, TN'] => 'U ',
			_msa in ['PHOENIX-MESA-SCOTTSDALE,AZ','STATE: AZ','STATE: NM','STATE: NV'] => 'V ',
			_msa in ['PORTLAND-VANCOUVER-BEAVERTON, OR-WA','SEATTLE-TACOMA-BELLEVUE,WA','STATE: OR','STATE: WA'] => 'W ',
			_msa in ['RENO-SPARKS, NV','SALINAS, CA','SAN FRANCISCO-OAKLAND-FREMONT, CA','SAN JOSE-SUNNYVALE-SANTACLARA, CA','SANTA CRUZ-WATSONVILLE, CA','SANTA ROSA-PETALUMA, CA','STATE: CA'] => 'X ',
			_msa in ['SAN JUAN-CAGUAS-GUAYNABO,PR','STATE: GU','STATE: PR'] => 'Y ',
			_msa in ['ST. LOUIS, MO-IL','STATE: IL','STATE: MO'] => 'Z ',
			_msa in ['STATE: AK','STATE: AP','STATE: AR'] => 'AA',
			_msa in ['STATE: DE','STATE: MA','STATE: MD','STATE: ME','STATE: NH','STATE: VA','STATE: VT'] => 'AB',
			'');

	allinputs_subscore0 := map(
			(iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => 0.000000,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-0'])                                    => 0.165584,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-0', '1-1', '2-0', '2-1'])        => 0.116117,
			(iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-0', '3-1', '3-3']) => -0.263077,
																																											0.000000);

	allinputs_subscore1 := map(
			NULL < iv_pb_average_dollars AND iv_pb_average_dollars < 0 => 0.095317,
			0 <= iv_pb_average_dollars AND iv_pb_average_dollars < 23  => -0.243282,
			23 <= iv_pb_average_dollars AND iv_pb_average_dollars < 67 => -0.315243,
			67 <= iv_pb_average_dollars                                => -0.473161,
																																		0.000000);

	allinputs_subscore2 := map(
			(_msa_group in [' '])  => 0.000000,
			(_msa_group in ['A'])  => 0.004504,
			(_msa_group in ['AA']) => 0.000000,
			(_msa_group in ['AB']) => 0.001627,
			(_msa_group in ['B'])  => 0.008043,
			(_msa_group in ['C'])  => 0.041926,
			(_msa_group in ['D'])  => 0.008274,
			(_msa_group in ['E'])  => -0.022540,
			(_msa_group in ['F'])  => 0.018801,
			(_msa_group in ['G'])  => -0.046387,
			(_msa_group in ['H'])  => -0.050426,
			(_msa_group in ['I'])  => -0.007237,
			(_msa_group in ['J'])  => -0.019347,
			(_msa_group in ['K'])  => 0.008098,
			(_msa_group in ['L'])  => 0.010372,
			(_msa_group in ['M'])  => -0.160352,
			(_msa_group in ['N'])  => 0.056184,
			(_msa_group in ['O'])  => -0.038543,
			(_msa_group in ['P'])  => 0.009263,
			(_msa_group in ['Q'])  => 0.202624,
			(_msa_group in ['R'])  => -0.032881,
			(_msa_group in ['S'])  => 0.029795,
			(_msa_group in ['T'])  => 0.025732,
			(_msa_group in ['U'])  => -0.023539,
			(_msa_group in ['V'])  => -0.246679,
			(_msa_group in ['W'])  => -0.093410,
			(_msa_group in ['X'])  => -0.059180,
			(_msa_group in ['Y'])  => 0.000000,
			(_msa_group in ['Z'])  => 0.677338,
																0.000000);

	allinputs_subscore3 := map(
			NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0 => -0.023902,
			0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 11  => 0.356077,
			11 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 26 => 0.184375,
			26 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 37 => 0.151442,
			37 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 48 => 0.071599,
			48 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 71 => -0.159390,
			71 <= iv_mos_since_gong_did_fst_seen                                         => -0.287616,
																																											-0.000000);

	allinputs_subscore4 := map(
			NULL < iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 0 => 0.018273,
			0 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 11  => 0.292800,
			11 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 19 => 0.113000,
			19 <= iv_mos_since_infutor_first_seen AND iv_mos_since_infutor_first_seen < 38 => 0.020115,
			38 <= iv_mos_since_infutor_first_seen                                          => -0.257028,
																																												0.000000);

	allinputs_subscore5 := map(
			NULL < iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 1 => -0.054373,
			1 <= iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 2   => 0.315838,
			2 <= iv_inq_highriskcredit_count12 AND iv_inq_highriskcredit_count12 < 3   => 0.432151,
			3 <= iv_inq_highriskcredit_count12                                         => 0.916625,
																																										0.000000);

	allinputs_subscore6 := map(
			NULL < iv_non_derog_count AND iv_non_derog_count < 2 => 0.165868,
			2 <= iv_non_derog_count AND iv_non_derog_count < 3   => 0.082432,
			3 <= iv_non_derog_count AND iv_non_derog_count < 4   => -0.056462,
			4 <= iv_non_derog_count AND iv_non_derog_count < 5   => -0.164840,
			5 <= iv_non_derog_count AND iv_non_derog_count < 6   => -0.209688,
			6 <= iv_non_derog_count                              => -0.498174,
																															0.000000);

	allinputs_subscore7 := map(
			NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => -0.047235,
			3 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 25  => 0.518499,
			25 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 61 => 0.306552,
			61 <= iv_de001_eviction_recency                                    => 0.110988,
																																						0.000000);

	allinputs_subscore8 := map(
			NULL < iv_addrs_10yr AND iv_addrs_10yr < 0 => 0.096462,
			0 <= iv_addrs_10yr AND iv_addrs_10yr < 1   => -0.467177,
			1 <= iv_addrs_10yr AND iv_addrs_10yr < 2   => -0.326376,
			2 <= iv_addrs_10yr AND iv_addrs_10yr < 3   => -0.169667,
			3 <= iv_addrs_10yr AND iv_addrs_10yr < 4   => -0.038104,
			4 <= iv_addrs_10yr AND iv_addrs_10yr < 5   => -0.019056,
			5 <= iv_addrs_10yr AND iv_addrs_10yr < 6   => 0.028925,
			6 <= iv_addrs_10yr AND iv_addrs_10yr < 8   => 0.099209,
			8 <= iv_addrs_10yr                         => 0.121544,
																										0.000000);

	allinputs_subscore9 := map(
			NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => -0.077714,
			1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => 0.069527,
			2 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 3   => 0.121249,
			3 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 5   => 0.172513,
			5 <= iv_unreleased_liens_ct                                  => 0.353643,
																																			0.000000);

	allinputs_subscore10 := map(
			NULL < iv_inq_recency AND iv_inq_recency < 1 => -0.061918,
			1 <= iv_inq_recency AND iv_inq_recency < 6   => 0.209510,
			6 <= iv_inq_recency AND iv_inq_recency < 12  => 0.120205,
			12 <= iv_inq_recency                         => 0.030282,
																											0.000000);

	allinputs_subscore11 := map(
			NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 0   => -0.000000,
			0 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 272   => 0.038265,
			272 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 310 => -0.090219,
			310 <= iv_sr001_m_hdr_fs                             => -0.265906,
																															-0.000000);

	allinputs_subscore12 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => -0.038432,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => 0.005565,
			3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 5   => 0.162486,
			5 <= iv_ms001_ssns_per_adl                                 => 0.495558,
																																		-0.000000);

	allinputs_subscore13 := map(
			NULL < iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 1 => -0.034031,
			1 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 2   => -0.023851,
			2 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 3   => 0.088174,
			3 <= iv_gong_did_phone_ct AND iv_gong_did_phone_ct < 4   => 0.226305,
			4 <= iv_gong_did_phone_ct                                => 0.358973,
																																	-0.000000);

	allinputs_subscore14 := map(
			NULL < iv_mos_since_impulse_last_seen AND iv_mos_since_impulse_last_seen < 0 => -0.009824,
			0 <= iv_mos_since_impulse_last_seen AND iv_mos_since_impulse_last_seen < 21  => 0.380695,
			21 <= iv_mos_since_impulse_last_seen                                         => -0.157924,
																																											0.000000);

	allinputs_subscore15 := map(
			NULL < iv_vp003_phn_invalid AND iv_vp003_phn_invalid < 1 => -0.006736,
			1 <= iv_vp003_phn_invalid                                => 0.856932,
																																	0.000000);

	allinputs_subscore16 := map(
			NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => -0.050508,
			2 <= iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 3   => 0.002427,
			3 <= iv_mi001_adlperssn_count                                    => 0.135598,
																																					0.000000);

	allinputs_subscore17 := map(
			NULL < iv_inq_lnames_per_addr AND iv_inq_lnames_per_addr < 1 => -0.030367,
			1 <= iv_inq_lnames_per_addr AND iv_inq_lnames_per_addr < 2   => 0.057316,
			2 <= iv_inq_lnames_per_addr                                  => 0.244717,
																																			0.000000);

	allinputs_subscore18 := map(
			NULL < iv_attr_bankruptcy_recency AND iv_attr_bankruptcy_recency < 1 => 0.011966,
			1 <= iv_attr_bankruptcy_recency AND iv_attr_bankruptcy_recency < 36  => 0.224359,
			36 <= iv_attr_bankruptcy_recency                                     => -0.112868,
																																							0.000000);

	allinputs_subscore19 := map(
			(iv_criminal_x_felony in [' '])                                      => 0.000000,
			(iv_criminal_x_felony in ['0-0'])                                    => -0.014986,
			(iv_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => 0.179952,
			(iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 0.395141,
																																							0.000000);

	allinputs_subscore20 := map(
			NULL < iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 1 => -0.028994,
			1 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 2   => 0.059950,
			2 <= iv_ssns_per_addr_c6                               => 0.198385,
																																-0.000000);

	allinputs_subscore21 := map(
			(iv_db001_bankruptcy in ['2 - BK Dismissed'])  => 0.144993,
			(iv_db001_bankruptcy in ['3 - BK Other'])      => 0.044571,
			(iv_db001_bankruptcy in ['0 - No BK'])         => 0.011668,
			(iv_db001_bankruptcy in ['1 - BK Discharged']) => -0.140047,
																												0.000000);

	allinputs_subscore22 := map(
			NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1 => 0.040704,
			1 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 3   => -0.019341,
			3 <= iv_addr_non_phn_src_ct                                  => -0.081537,
																																			-0.000000);

	allinputs_subscore23 := map(
			NULL < iv_combined_age AND iv_combined_age < 16 => 0.000000,
			16 <= iv_combined_age AND iv_combined_age < 50  => 0.016292,
			50 <= iv_combined_age                           => -0.076308,
																												 0.000000);

	allinputs_subscore24 := map(
			(iv_college_attendance_x_age in [' '])                                      => -0.000000,
			(iv_college_attendance_x_age in ['N10', 'N20', 'N30', 'N40', 'N50', 'N60']) => 0.007502,
			(iv_college_attendance_x_age in ['Y10', 'Y20', 'Y30', 'Y40', 'Y50', 'Y60']) => -0.119134,
																																										 -0.000000);

	allinputs_subscore25 := map(
			NULL < iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 1 => -0.017907,
			1 <= iv_va060_dist_add_in_bst                                    => 0.026472,
																																					0.000000);

	allinputs_rawscore := allinputs_subscore0 +
			allinputs_subscore1 +
			allinputs_subscore2 +
			allinputs_subscore3 +
			allinputs_subscore4 +
			allinputs_subscore5 +
			allinputs_subscore6 +
			allinputs_subscore7 +
			allinputs_subscore8 +
			allinputs_subscore9 +
			allinputs_subscore10 +
			allinputs_subscore11 +
			allinputs_subscore12 +
			allinputs_subscore13 +
			allinputs_subscore14 +
			allinputs_subscore15 +
			allinputs_subscore16 +
			allinputs_subscore17 +
			allinputs_subscore18 +
			allinputs_subscore19 +
			allinputs_subscore20 +
			allinputs_subscore21 +
			allinputs_subscore22 +
			allinputs_subscore23 +
			allinputs_subscore24 +
			allinputs_subscore25;

	allinputs_lnoddsscore := allinputs_rawscore + -0.801913;

	nameaddr_subscore0 := map(
			NULL < iv_pb_average_dollars AND iv_pb_average_dollars < 0 => 0.106820,
			0 <= iv_pb_average_dollars AND iv_pb_average_dollars < 23  => -0.257877,
			23 <= iv_pb_average_dollars AND iv_pb_average_dollars < 67 => -0.345197,
			67 <= iv_pb_average_dollars                                => -0.527507,
																																		0.000000);

	nameaddr_subscore1 := map(
			(_msa_group in [' '])  => -0.000000,
			(_msa_group in ['A'])  => 0.020192,
			(_msa_group in ['AA']) => -0.000000,
			(_msa_group in ['AB']) => -0.019690,
			(_msa_group in ['B'])  => -0.031625,
			(_msa_group in ['C'])  => 0.051324,
			(_msa_group in ['D'])  => -0.031156,
			(_msa_group in ['E'])  => -0.007378,
			(_msa_group in ['F'])  => 0.018487,
			(_msa_group in ['G'])  => 0.079298,
			(_msa_group in ['H'])  => 0.014258,
			(_msa_group in ['I'])  => 0.035059,
			(_msa_group in ['J'])  => -0.030093,
			(_msa_group in ['K'])  => -0.004648,
			(_msa_group in ['L'])  => 0.001411,
			(_msa_group in ['M'])  => -0.262935,
			(_msa_group in ['N'])  => 0.052477,
			(_msa_group in ['O'])  => -0.029662,
			(_msa_group in ['P'])  => -0.016286,
			(_msa_group in ['Q'])  => 0.180581,
			(_msa_group in ['R'])  => 0.007848,
			(_msa_group in ['S'])  => 0.052131,
			(_msa_group in ['T'])  => 0.005845,
			(_msa_group in ['U'])  => -0.026457,
			(_msa_group in ['V'])  => -0.318781,
			(_msa_group in ['W'])  => -0.194968,
			(_msa_group in ['X'])  => -0.019896,
			(_msa_group in ['Y'])  => -0.000000,
			(_msa_group in ['Z'])  => 0.701047,
																-0.000000);

	nameaddr_subscore2 := map(
			NULL < iv_addrs_per_adl AND iv_addrs_per_adl < 2 => -0.631606,
			2 <= iv_addrs_per_adl AND iv_addrs_per_adl < 3   => -0.339305,
			3 <= iv_addrs_per_adl AND iv_addrs_per_adl < 4   => -0.280525,
			4 <= iv_addrs_per_adl AND iv_addrs_per_adl < 5   => -0.171982,
			5 <= iv_addrs_per_adl AND iv_addrs_per_adl < 6   => -0.095930,
			6 <= iv_addrs_per_adl AND iv_addrs_per_adl < 9   => -0.033981,
			9 <= iv_addrs_per_adl AND iv_addrs_per_adl < 11  => 0.089676,
			11 <= iv_addrs_per_adl                           => 0.129620,
																													0.000000);

	nameaddr_subscore3 := map(
			NULL < iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen < 0   => -0.731476,
			0 <= iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen < 264   => 0.065820,
			264 <= iv_mos_src_bureau_lname_fseen AND iv_mos_src_bureau_lname_fseen < 307 => -0.154022,
			307 <= iv_mos_src_bureau_lname_fseen                                         => -0.490876,
																																											0.000000);

	nameaddr_subscore4 := map(
			NULL < iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 0 => -0.043760,
			0 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 12  => 0.339391,
			12 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 39 => 0.164229,
			39 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 49 => 0.094473,
			49 <= iv_mos_since_gong_did_fst_seen AND iv_mos_since_gong_did_fst_seen < 99 => -0.174881,
			99 <= iv_mos_since_gong_did_fst_seen                                         => -0.430001,
																																											-0.000000);

	nameaddr_subscore5 := map(
			NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => -0.055124,
			1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 6   => 0.519631,
			6 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12  => 0.437125,
			12 <= iv_inq_highriskcredit_recency                                        => 0.261852,
																																										-0.000000);

	nameaddr_subscore6 := map(
			NULL < iv_de001_eviction_recency AND iv_de001_eviction_recency < 3 => -0.048000,
			3 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 24  => 0.626503,
			24 <= iv_de001_eviction_recency AND iv_de001_eviction_recency < 37 => 0.425159,
			37 <= iv_de001_eviction_recency                                    => 0.137553,
																																						-0.000000);

	nameaddr_subscore7 := map(
			NULL < iv_non_derog_count AND iv_non_derog_count < 2 => 0.156078,
			2 <= iv_non_derog_count AND iv_non_derog_count < 3   => 0.073789,
			3 <= iv_non_derog_count AND iv_non_derog_count < 4   => -0.055810,
			4 <= iv_non_derog_count AND iv_non_derog_count < 5   => -0.143567,
			5 <= iv_non_derog_count AND iv_non_derog_count < 6   => -0.192198,
			6 <= iv_non_derog_count                              => -0.421060,
																															-0.000000);

	nameaddr_subscore8 := map(
			NULL < iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 1 => -0.079214,
			1 <= iv_iq001_inq_count12 AND iv_iq001_inq_count12 < 2   => 0.114816,
			2 <= iv_iq001_inq_count12                                => 0.208844,
																																	-0.000000);

	nameaddr_subscore9 := map(
			NULL < iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 1 => -0.076428,
			1 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 2   => 0.061871,
			2 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 3   => 0.124351,
			3 <= iv_unreleased_liens_ct AND iv_unreleased_liens_ct < 5   => 0.207204,
			5 <= iv_unreleased_liens_ct                                  => 0.301558,
																																			0.000000);

	nameaddr_subscore10 := map(
			iv_inp_own_prop_x_addr_naprop <>'' and NULL < (integer)iv_inp_own_prop_x_addr_naprop AND (integer)iv_inp_own_prop_x_addr_naprop < 4 => 0.036113, // '' is not taken as missing...
			4 <= (integer)iv_inp_own_prop_x_addr_naprop AND (integer)iv_inp_own_prop_x_addr_naprop < 10  => -0.171394,
			10 <= (integer)iv_inp_own_prop_x_addr_naprop AND (integer)iv_inp_own_prop_x_addr_naprop < 14 => -0.019905,
			14 <= (integer)iv_inp_own_prop_x_addr_naprop                                        => -0.280985,
																																										-0.000000);

	nameaddr_subscore11 := map(
			(iv_db001_bankruptcy in [' '])                 => 0.000000,
			(iv_db001_bankruptcy in ['2 - BK Dismissed'])  => 0.240412,
			(iv_db001_bankruptcy in ['3 - BK Other'])      => -0.060350,
			(iv_db001_bankruptcy in ['0 - No BK'])         => 0.023282,
			(iv_db001_bankruptcy in ['1 - BK Discharged']) => -0.184606,
																												0.000000);

	nameaddr_subscore12 := map(
			NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => -0.027298,
			2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => -0.009468,
			3 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 5   => 0.125428,
			5 <= iv_ms001_ssns_per_adl                                 => 0.509525,
																																		0.000000);

	nameaddr_subscore13 := map(
			NULL < iv_pl001_addr_stability_v2 AND iv_pl001_addr_stability_v2 < 1 => 0.121898,
			1 <= iv_pl001_addr_stability_v2 AND iv_pl001_addr_stability_v2 < 2   => 0.158672,
			2 <= iv_pl001_addr_stability_v2 AND iv_pl001_addr_stability_v2 < 3   => 0.081732,
			3 <= iv_pl001_addr_stability_v2 AND iv_pl001_addr_stability_v2 < 4   => 0.023988,
			4 <= iv_pl001_addr_stability_v2 AND iv_pl001_addr_stability_v2 < 5   => 0.008050,
			5 <= iv_pl001_addr_stability_v2 AND iv_pl001_addr_stability_v2 < 6   => -0.057970,
			6 <= iv_pl001_addr_stability_v2                                      => -0.082282,
																																							0.000000);

	nameaddr_subscore14 := map(
			NULL < iv_mos_since_impulse_first_seen AND iv_mos_since_impulse_first_seen < 0 => -0.012234,
			0 <= iv_mos_since_impulse_first_seen AND iv_mos_since_impulse_first_seen < 21  => 0.391286,
			21 <= iv_mos_since_impulse_first_seen                                          => 0.003053,
																																												0.000000);

	nameaddr_subscore15 := map(
			(iv_criminal_x_felony in [' '])                                      => 0.000000,
			(iv_criminal_x_felony in ['0-0'])                                    => -0.016054,
			(iv_criminal_x_felony in ['1-0', '2-0', '3-0'])                      => 0.214669,
			(iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => 0.370923,
																																							0.000000);

	nameaddr_subscore16 := map(
			NULL < iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 1 => -0.031158,
			1 <= iv_ssns_per_addr_c6 AND iv_ssns_per_addr_c6 < 2   => 0.059860,
			2 <= iv_ssns_per_addr_c6                               => 0.223197,
																																-0.000000);

	nameaddr_subscore17 := map(
			(iv_college_attendance_x_age in [' '])                                      => 0.000000,
			(iv_college_attendance_x_age in ['N10', 'N20', 'N30', 'N40', 'N50', 'N60']) => 0.007069,
			(iv_college_attendance_x_age in ['Y10', 'Y20', 'Y30', 'Y40', 'Y50', 'Y60']) => -0.114433,
																																										 0.000000);

	nameaddr_rawscore := nameaddr_subscore0 +
			nameaddr_subscore1 +
			nameaddr_subscore2 +
			nameaddr_subscore3 +
			nameaddr_subscore4 +
			nameaddr_subscore5 +
			nameaddr_subscore6 +
			nameaddr_subscore7 +
			nameaddr_subscore8 +
			nameaddr_subscore9 +
			nameaddr_subscore10 +
			nameaddr_subscore11 +
			nameaddr_subscore12 +
			nameaddr_subscore13 +
			nameaddr_subscore14 +
			nameaddr_subscore15 +
			nameaddr_subscore16 +
			nameaddr_subscore17;

	nameaddr_lnoddsscore := nameaddr_rawscore + -0.798082;

	model_used := if( hphnpop and (integer)ssnlength > 0, 'All_Inputs', 'Name_Address');
	AllModel := model_used = 'All_Inputs';
	point := 40;

	base := 700;

	odds := .41 / (1 - .41);

	_rva1309_1_0 := if(AllModel, round(point * (-allinputs_lnoddsscore + ln(odds)) / ln(2) + base),  // all modell
															 round(point * (-nameaddr_lnoddsscore + ln(odds)) / ln(2) + base));  // name address

	rva1309_1_0_1 := min(if(max(round(_rva1309_1_0), 501) = NULL, -NULL, max(round(_rva1309_1_0), 501)), 900);

	bk_flag := (rc_bansflag in ['1', '2']) or ver_src_ba or bankrupt or filing_count > 0 or bk_recent_count > 0;

	lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

	lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

	lien_flag := ver_src_l2 or ver_src_li or lien_rec_unrel_flag or lien_hist_unrel_flag;

	ssn_deceased := rc_decsflag = '1' or ver_src_ds;

	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or (integer)input_dob_match_level >= 7 or lien_flag or criminal_count > 0 or bk_flag or ssn_deceased or truedid);

	rva1309_1_0 := map(
			ssn_deceased                                                                => 200,
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => 222,
																																												 rva1309_1_0_1);

	rc1_2 := '';

	rc2_1 := '';

	rc3_1 := '';

	rc4_1 := '';

	rc5_2 := '';

	glrc08 := hphnpop;

	glrc97 := criminal_count > 0;

	glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

	glrc9a := add1_naprop < 4 and property_owned_total < 1;

	glrc9d := addrs_5yr > 3;

	glrc9e := truedid and add1_pop and attr_num_nonderogs < 3;

	glrc9f := hphnpop;

	glrc9g := age < 30;

	glrc9h := iv_mos_since_impulse_last_seen >= 0;

	glrc9i := age < 30;

	glrc9o := add1_pop and hphnpop;

	glrc9q := Inq_count12 > 0;

	glrc9r := iv_mos_src_bureau_lname_fseen >= 0;

	glrc9w := bankrupt;

	// glrc9y := pb_total_dollars = '';

	glrcev := attr_eviction_count > 0;

	glrcmi := adlperssn_count > 1;

	glrcms := ssns_per_adl >= 2;

	glrcbl := 0;
//--------------------------------------------------------
	rcvalue9o_1 := if(AllModel, -(-0.263077 - allinputs_subscore0), NULL);
	rcvalue9o := if(AllModel, (integer)glrc9o * if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1))), NULL);

	// rcvalue9y_1 := if(AllModel, -(-0.473161 - allinputs_subscore1), -(-0.527507 - nameaddr_subscore0));
	// rcvalue9y := (integer)glrc9y * if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));

	rcvalue9f_1 := if(AllModel, -(-0.287616 - allinputs_subscore3), -(-0.430001 - nameaddr_subscore4));
	rcvalue9f_2 := if(AllModel, -(-0.257028 - allinputs_subscore4), NULL);
	rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1, rcvalue9f_2) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1), if(rcvalue9f_2 = NULL, 0, rcvalue9f_2)));

	rcvalue9q_1 := if(AllModel, -(-0.054373 - allinputs_subscore5), -(-0.055124 - nameaddr_subscore5));
	rcvalue9q_2 := if(AllModel, -(-0.061918 - allinputs_subscore10), -(-0.079214 - nameaddr_subscore8));
	rcvalue9q_3 := if(AllModel, -(-0.030367 - allinputs_subscore17), NULL);
	rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1, rcvalue9q_2, rcvalue9q_3) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1), if(rcvalue9q_2 = NULL, 0, rcvalue9q_2), if(rcvalue9q_3 = NULL, 0, rcvalue9q_3)));

	rcvalueev_1 := if(AllModel, -(-0.047235 - allinputs_subscore7), -(-0.048000 - nameaddr_subscore6));
	rcvalueev := (integer)glrcev * if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

	rcvalue9d_1 := if(AllModel, -(-0.326376 - allinputs_subscore8), -(-0.082282 - nameaddr_subscore13));
	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

	rcvalue98_1 := if(AllModel, -(-0.077714 - allinputs_subscore9), -(-0.076428 - nameaddr_subscore9));
	rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

	rcvalue9r_1 := if(AllModel, -(-0.077714 - allinputs_subscore11), -(-0.490876 - nameaddr_subscore3));
	rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));

	rcvaluems_1 := if(AllModel, -(-0.038432 - allinputs_subscore12), -(-0.027298 - nameaddr_subscore12));
	rcvaluems := (integer)glrcms * if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

	rcvalue9h_1 := if(AllModel, -(-0.157924 - allinputs_subscore14), -(-0.012234 - nameaddr_subscore14));
	rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

	rcvalue08_1 := if(AllModel, -(-0.006736 - allinputs_subscore15), NULL);
	rcvalue08 := if(AllModel, (integer)glrc08 * if(max(rcvalue08_1) = NULL, NULL, sum(if(rcvalue08_1 = NULL, 0, rcvalue08_1))), NULL);

	rcvaluemi_1 := if(AllModel, -(-0.050508 - allinputs_subscore16), NULL);
	rcvaluemi := if(AllModel, (integer)glrcmi * if(max(rcvaluemi_1) = NULL, NULL, sum(if(rcvaluemi_1 = NULL, 0, rcvaluemi_1))), NULL);

	rcvalue9w_1 := if(AllModel, -(0.011966 - allinputs_subscore18), -(-0.184606 - nameaddr_subscore11));
	rcvalue9w_2 := if(AllModel, -(0.011668 - allinputs_subscore21), NULL);
	rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1, rcvalue9w_2) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2)));

	rcvalue97_1 := if(AllModel, -(-0.014986 - allinputs_subscore19), -(-0.016054 - nameaddr_subscore15));
	rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

	rcvalue9e_1 := if(AllModel, -(-0.081537 - allinputs_subscore22), -(-0.421060 - nameaddr_subscore7));
	rcvalue9e_2 := if(AllModel, -(-0.498174 - allinputs_subscore6), NULL);
	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1, rcvalue9e_2) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2)));

	rcvalue9g_1 := if(AllModel, -(-0.076308 - allinputs_subscore23), NULL);
	rcvalue9g := if(AllModel, (integer)glrc9g * if(max(rcvalue9g_1) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1))), NULL);

	rcvalue9i_1 := if(AllModel, -(-0.119134 - allinputs_subscore24), -(-0.114433 - nameaddr_subscore17));
	rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1)));

	rcvaluebl_1 := if(AllModel, -(-0.246679 - allinputs_subscore2), -(-0.318781 - nameaddr_subscore1));
	rcvaluebl_2 := if(AllModel, -(-0.034031 - allinputs_subscore13), -(-0.631606 - nameaddr_subscore2));
	rcvaluebl_3 := if(AllModel, -(-0.028994 - allinputs_subscore20), -(-0.031158 - nameaddr_subscore16));
	rcvaluebl_4 := if(AllModel, -(-0.017907 - allinputs_subscore25), NULL);
	rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4)));

	rcvalue9a_1 := if(AllModel, NULL, -(-0.280985 - nameaddr_subscore10));
	rcvalue9a := 	 if(AllModel, NULL, (integer)glrc9a * if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1))) );


	ds_layout := {STRING rc, REAL value};

	rc_dataset := DATASET([
			{'9O', RCValue9O},
			// {'9Y', RCValue9Y},
			{'9F', RCValue9F},
			{'9Q', RCValue9Q},
			{'EV', RCValueEV},
			{'9D', RCValue9D},
			{'98', RCValue98},
			{'9R', RCValue9R},
			{'MS', RCValueMS},
			{'9H', RCValue9H},
			{'08', RCValue08},
			{'MI', RCValueMI},
			{'9W', RCValue9W},
			{'97', RCValue97},
			{'9E', RCValue9E},
			{'9G', RCValue9G},
			{'9I', RCValue9I},
			{'BL', RCValueBL},
			{'9A', RCValue9A}
			], ds_layout)(value>0);

	rc_dataset_sorted := choosen(sort(rc_dataset, -rc_dataset.value), 4);

	rcs := if( glrc9q and (NOT EXISTS(rc_dataset_sorted(rc='9Q'))) and inq_count12 > 0, rc_dataset_sorted + DATASET([{'9Q', NULL +1}], ds_layout), rc_dataset_sorted);

	rcs_override := MAP(
											rva1309_1_0 = 200 => DATASET([{'02', NULL +1}], ds_layout),
											rva1309_1_0 = 222 => DATASET([{'9X', NULL +1}], ds_layout),
											rva1309_1_0 = 900 => DATASET([{'  ', NULL +1}], ds_layout),
											NOT EXISTS(rc_dataset_sorted(rc != '')) => DATASET([{'36', NULL}], ds_layout),
											rcs
										);
										
	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

	rcs_final := PROJECT(sort(rcs_override, -value), TRANSFORM(Risk_Indicators.Layout_Desc,
				SELF.hri := LEFT.rc,
				SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
			));

	ri := MAP(
						riTemp[1].hri <> '00' => riTemp,
						rcs_final
						);
			
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes


//Intermediate variables
	#if(RVA_DEBUG)
	  self.clam															:= le;
		self.sysdate                          := sysdate;
		self.ver_src_ba_pos                   := ver_src_ba_pos;
		self.ver_src_ba                       := ver_src_ba;
		self.ver_src_ds_pos                   := ver_src_ds_pos;
		self.ver_src_ds                       := ver_src_ds;
		self.ver_src_l2_pos                   := ver_src_l2_pos;
		self.ver_src_l2                       := ver_src_l2;
		self.ver_src_li_pos                   := ver_src_li_pos;
		self.ver_src_li                       := ver_src_li;
		self.iv_vp003_phn_invalid             := iv_vp003_phn_invalid;
		self.iv_va060_dist_add_in_bst         := iv_va060_dist_add_in_bst;
		self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
		self.iv_de001_eviction_recency        := iv_de001_eviction_recency;
		self._header_first_seen               := _header_first_seen;
		self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
		self.iv_mi001_adlperssn_count         := iv_mi001_adlperssn_count;
		self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
		self.iv_combined_age                  := iv_combined_age;
		self.iv_addrs_10yr                    := iv_addrs_10yr;
		self._gong_did_first_seen             := _gong_did_first_seen;
		self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
		self.iv_gong_did_phone_ct             := iv_gong_did_phone_ct;
		self.iv_ssns_per_addr_c6              := iv_ssns_per_addr_c6;
		self.iv_inq_recency                   := iv_inq_recency;
		self.iv_inq_highriskcredit_count12    := iv_inq_highriskcredit_count12;
		self.iv_inq_lnames_per_addr           := iv_inq_lnames_per_addr;
		self._infutor_first_seen              := _infutor_first_seen;
		self.iv_mos_since_infutor_first_seen  := iv_mos_since_infutor_first_seen;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self._impulse_last_seen               := _impulse_last_seen;
		self.iv_mos_since_impulse_last_seen   := iv_mos_since_impulse_last_seen;
		self.iv_attr_bankruptcy_recency       := iv_attr_bankruptcy_recency;
		self.iv_non_derog_count               := iv_non_derog_count;
		self.iv_unreleased_liens_ct           := iv_unreleased_liens_ct;
		self.iv_criminal_x_felony             := iv_criminal_x_felony;
		self._reported_dob                    := _reported_dob;
		self.reported_age                     := reported_age;
		self._combined_age                    := _combined_age;
		self.evidence_of_college              := evidence_of_college;
		self.iv_college_attendance_x_age      := iv_college_attendance_x_age;
		self.iv_pb_average_dollars            := iv_pb_average_dollars;
		self.iv_pl001_addr_stability_v2       := iv_pl001_addr_stability_v2;
		self.iv_iq001_inq_count12             := iv_iq001_inq_count12;
		self.bureau_lname_tn_fseen_pos        := bureau_lname_tn_fseen_pos;
		self.bureau_lname_fseen_tn            := bureau_lname_fseen_tn;
		self._bureau_lname_fseen_tn           := _bureau_lname_fseen_tn;
		self.bureau_lname_ts_fseen_pos        := bureau_lname_ts_fseen_pos;
		self.bureau_lname_fseen_ts            := bureau_lname_fseen_ts;
		self._bureau_lname_fseen_ts           := _bureau_lname_fseen_ts;
		self.bureau_lname_tu_fseen_pos        := bureau_lname_tu_fseen_pos;
		self.bureau_lname_fseen_tu            := bureau_lname_fseen_tu;
		self._bureau_lname_fseen_tu           := _bureau_lname_fseen_tu;
		self.bureau_lname_en_fseen_pos        := bureau_lname_en_fseen_pos;
		self.bureau_lname_fseen_en            := bureau_lname_fseen_en;
		self._bureau_lname_fseen_en           := _bureau_lname_fseen_en;
		self.bureau_lname_eq_fseen_pos        := bureau_lname_eq_fseen_pos;
		self.bureau_lname_fseen_eq            := bureau_lname_fseen_eq;
		self._bureau_lname_fseen_eq           := _bureau_lname_fseen_eq;
		self._src_bureau_lname_fseen          := _src_bureau_lname_fseen;
		self.iv_mos_src_bureau_lname_fseen    := iv_mos_src_bureau_lname_fseen;
		self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;
		self.iv_addrs_per_adl                 := iv_addrs_per_adl;
		self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
		self._impulse_first_seen              := _impulse_first_seen;
		self.iv_mos_since_impulse_first_seen  := iv_mos_since_impulse_first_seen;
		self._msa                             := (string30)_msa; // validation file truncates strings at 30.
		self._msa_group                       := _msa_group;
		self.allinputs_subscore0              := allinputs_subscore0;
		self.allinputs_subscore1              := allinputs_subscore1;
		self.allinputs_subscore2              := allinputs_subscore2;
		self.allinputs_subscore3              := allinputs_subscore3;
		self.allinputs_subscore4              := allinputs_subscore4;
		self.allinputs_subscore5              := allinputs_subscore5;
		self.allinputs_subscore6              := allinputs_subscore6;
		self.allinputs_subscore7              := allinputs_subscore7;
		self.allinputs_subscore8              := allinputs_subscore8;
		self.allinputs_subscore9              := allinputs_subscore9;
		self.allinputs_subscore10             := allinputs_subscore10;
		self.allinputs_subscore11             := allinputs_subscore11;
		self.allinputs_subscore12             := allinputs_subscore12;
		self.allinputs_subscore13             := allinputs_subscore13;
		self.allinputs_subscore14             := allinputs_subscore14;
		self.allinputs_subscore15             := allinputs_subscore15;
		self.allinputs_subscore16             := allinputs_subscore16;
		self.allinputs_subscore17             := allinputs_subscore17;
		self.allinputs_subscore18             := allinputs_subscore18;
		self.allinputs_subscore19             := allinputs_subscore19;
		self.allinputs_subscore20             := allinputs_subscore20;
		self.allinputs_subscore21             := allinputs_subscore21;
		self.allinputs_subscore22             := allinputs_subscore22;
		self.allinputs_subscore23             := allinputs_subscore23;
		self.allinputs_subscore24             := allinputs_subscore24;
		self.allinputs_subscore25             := allinputs_subscore25;
		self.allinputs_rawscore               := allinputs_rawscore;
		self.allinputs_lnoddsscore            := allinputs_lnoddsscore;
		self.nameaddr_subscore0               := nameaddr_subscore0;
		self.nameaddr_subscore1               := nameaddr_subscore1;
		self.nameaddr_subscore2               := nameaddr_subscore2;
		self.nameaddr_subscore3               := nameaddr_subscore3;
		self.nameaddr_subscore4               := nameaddr_subscore4;
		self.nameaddr_subscore5               := nameaddr_subscore5;
		self.nameaddr_subscore6               := nameaddr_subscore6;
		self.nameaddr_subscore7               := nameaddr_subscore7;
		self.nameaddr_subscore8               := nameaddr_subscore8;
		self.nameaddr_subscore9               := nameaddr_subscore9;
		self.nameaddr_subscore10              := nameaddr_subscore10;
		self.nameaddr_subscore11              := nameaddr_subscore11;
		self.nameaddr_subscore12              := nameaddr_subscore12;
		self.nameaddr_subscore13              := nameaddr_subscore13;
		self.nameaddr_subscore14              := nameaddr_subscore14;
		self.nameaddr_subscore15              := nameaddr_subscore15;
		self.nameaddr_subscore16              := nameaddr_subscore16;
		self.nameaddr_subscore17              := nameaddr_subscore17;
		self.nameaddr_rawscore                := nameaddr_rawscore;
		self.nameaddr_lnoddsscore             := nameaddr_lnoddsscore;
		self.model_used												:= model_used;
		self.point                            := point;
		self.base                             := base;
		self.odds                             := odds;
		self._rva1309_1_0                     := _rva1309_1_0;
		self.bk_flag                          := bk_flag;
		self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
		self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
		self.lien_flag                        := lien_flag;
		self.ssn_deceased                     := ssn_deceased;
		self.scored_222s                      := scored_222s;
		self.rva1309_1_0                      := rva1309_1_0;
		self.glrc08                           := glrc08;
		self.glrc97                           := glrc97;
		self.glrc98                           := glrc98;
		self.glrc9a                           := glrc9a;
		self.glrc9d                           := glrc9d;
		self.glrc9e                           := glrc9e;
		self.glrc9f                           := glrc9f;
		self.glrc9g                           := glrc9g;
		self.glrc9h                           := glrc9h;
		self.glrc9i                           := glrc9i;
		self.glrc9o                           := glrc9o;
		self.glrc9q                           := glrc9q;
		self.glrc9r                           := glrc9r;
		self.glrc9w                           := glrc9w;
		self.glrc9y                           := glrc9y;
		self.glrcev                           := glrcev;
		self.glrcmi                           := glrcmi;
		self.glrcms                           := glrcms;
		self.glrcbl                           := glrcbl;
		self.rcvalue9o_1 := 	rcvalue9o_1;
		self.rcvalue9o := 		rcvalue9o;
		// self.rcvalue9y_1 := 	rcvalue9y_1;
		// self.rcvalue9y := 		rcvalue9y;
		self.rcvalue9f_1 := 	rcvalue9f_1;
		self.rcvalue9f_2 := 	rcvalue9f_2;
		self.rcvalue9f := 		rcvalue9f;
		self.rcvalue9q_1 := 	rcvalue9q_1;
		self.rcvalue9q_2 := 	rcvalue9q_2;
		self.rcvalue9q_3 := 	rcvalue9q_3;
		self.rcvalue9q := 		rcvalue9q;
		self.rcvalueev_1 := 	rcvalueev_1;
		self.rcvalueev := 		rcvalueev;
		self.rcvalue9d_1 := 	rcvalue9d_1;
		self.rcvalue9d := 		rcvalue9d;
		self.rcvalue98_1 := 	rcvalue98_1;
		self.rcvalue98 := 		rcvalue98;
		self.rcvalue9r_1 := 	rcvalue9r_1;
		self.rcvalue9r := 		rcvalue9r;
		self.rcvaluems_1 := 	rcvaluems_1;
		self.rcvaluems := 		rcvaluems;
		self.rcvalue9h_1 := 	rcvalue9h_1;
		self.rcvalue9h := 		rcvalue9h;
		self.rcvalue08_1 := 	rcvalue08_1;
		self.rcvalue08 := 		rcvalue08;
		self.rcvaluemi_1 := 	rcvaluemi_1;
		self.rcvaluemi := 		rcvaluemi;
		self.rcvalue9w_2 := 	rcvalue9w_2;
		self.rcvalue9w_1 := 	rcvalue9w_1;
		self.rcvalue9w := 		rcvalue9w;
		self.rcvalue97_1 := 	rcvalue97_1;
		self.rcvalue97 := 		rcvalue97;
		self.rcvalue9e_1 := 	rcvalue9e_1;
		self.rcvalue9e_2 := 	rcvalue9e_2;
		self.rcvalue9e := 		rcvalue9e;
		self.rcvalue9g_1 := 	rcvalue9g_1;
		self.rcvalue9g := 		rcvalue9g;
		self.rcvalue9i_1 := 	rcvalue9i_1;
		self.rcvalue9i := 		rcvalue9i;
		self.rcvaluebl_1 := 	rcvaluebl_1;
		self.rcvaluebl_2 := 	rcvaluebl_2;
		self.rcvaluebl_3 := 	rcvaluebl_3;
		self.rcvaluebl_4 := 	rcvaluebl_4;
		self.rcvaluebl :=			rcvaluebl;			
		self.rcvalue9a_1 := 	rcvalue9a_1;
		self.rcvalue9a := 		rcvalue9a;
		self.rc1                              := if(reasons[1].hri = '00', '', reasons[1].hri);
		self.rc2                              := if(reasons[2].hri = '00', '', reasons[2].hri);
		self.rc3                              := if(reasons[3].hri = '00', '', reasons[3].hri);
		self.rc4                              := if(reasons[4].hri = '00', '', reasons[4].hri);
		self.rc5                              := if(reasons[5].hri = '00', '', reasons[5].hri);
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		
		self.score := MAP(
											reasons[1].hri IN ['91','92','93','94'] 			=> (STRING3)((INTEGER)reasons[1].hri + 10),
											reasons[1].hri='35' => '100',
											(string3)rva1309_1_0
										);
										self := [];
	END;

	model := project( clam, doModel(left) );

	return model;
END;