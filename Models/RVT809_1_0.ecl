import riskwise, risk_indicators, ut, riskwisefcra, std, riskview;

export RVT809_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, 
				boolean isCalifornia = false,
				boolean useRcSetV1 = false
				) := FUNCTION

RVT_DEBUG := false;


#if(RVT_DEBUG)
	// Process Model into Layout
layout_debug := record
layout_modelout.seq;
layout_modelout.score;
Boolean trueDID;
String in_dob;
Integer NAS_Summary;
Integer NAP_Summary;
String rc_hriskphoneflag;
String rc_decsflag;
String rc_ssndobflag;
String rc_pwssndobflag;
String rc_ssnlowissue;
String rc_sources;
String rc_hrisksic;
Integer combo_dobscore;
Integer PR_count;
Integer EM_count;
Integer adl_EQ_first_seen;
Boolean voter_avail;
String ssnlength;
Boolean add1_isbestmatch;
Integer add1_avm_automated_valuation;
Integer ADD1_NAPROP;
Integer PROPERTY_OWNED_TOTAL;
Integer PROPERTY_SOLD_TOTAL;
String telcordia_type;
Integer ssns_per_adl;
Integer addrs_per_ssn;
Integer ssns_per_addr;
Boolean Bankrupt;
Integer liens_historical_unreleased_ct;
Integer liens_historical_released_count;
Integer criminal_count;
Integer archive_date;
boolean source_tot_L2;
boolean source_tot_LI;
integer liens_recent_unreleased_count;
boolean lien_flag;
string input_dob_match_level;

string rc_bansflag;
boolean source_tot_BA;
integer filing_count;
integer bk_recent_count;
boolean bk_flag;
boolean source_tot_DS;
boolean ssn_deceased;
boolean scored_222s;

String archive_yr;
String archive_mo;
Integer today;
Integer today1900;
Integer birth1900;
Integer li1900;
Integer age_calc;
Boolean age_gt19;
Integer age_at_low_issue;
Integer age_at_low_issue_neg3_30;
Integer age_at_low_issue_neg7_50;
Real age_summary_m;
Integer in_date;
Integer time_snc_adl_eq_first_seen;
Integer time_snc_adl_eq_first_seen_7yrs;
Real time_snc_adl_eq_summary_m;
Boolean source_AK_tot;
Boolean source_AM_tot;
Boolean source_CG_tot;
Boolean source_P_tot;
Boolean source_PL_tot;
Boolean source_W_tot;
Boolean source_WP_tot;
Integer num_pos_sources_NOEQ_tot;
Integer num_pos_sources_NOEQ_tot_2;
Boolean no_voter_rec_when_avail;
Integer verfst_p;
Integer verlst_p;
Integer veradd_p;
Integer verphn_p;
Integer verphn_p_2;
Integer verlst_p_2;
Integer veradd_p_2;
Integer verfst_p_2;
Boolean pnotpots;
Boolean combo_dobscore_100;
Integer verx_b1;
Real verx_b2;
Real verx;
Real verx_m;
Real verx2_m;
Integer add1_avm_automated_val_500k_0td;
Integer add1_avm_automated_val_500k_td;
Boolean hi_addrs_per_ssn;
Boolean hi_ssns_per_addr;
Boolean ssns_per_adl_ge2;
Integer addrs_per_ssn_3;
Real add1_naprop_summary_m_0truedid;
Integer PR_ind;
Integer property_owned_ind;
Integer add1_naprop_summary;
Real add1_naprop_summary_m_truedid;
Boolean disconnected;
Boolean derog_flag;
Real outest;
Real p_1;
Integer cust_score;
Integer rvt809_1_0a;
Integer rvt809_1_0b;
Boolean ssndead;
Boolean ssnprior;
Boolean Corrections;
Integer RVT809_1_0;
layout_modelout.ri;
end;

	layout_debug DoModel(clam le) := TRANSFORM
#else
	Layout_ModelOut DoModel(clam le) := TRANSFORM
#end
		truedid                          := le.truedid;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_ssndobflag                    := le.iid.socsdobflag;
		rc_pwssndobflag                  := le.iid.pwsocsdobflag;
		rc_ssnlowissue                   := le.iid.socllowissue;
		rc_sources                       := le.iid.sources;
		rc_hrisksic                      := le.iid.hrisksic;
		combo_dobscore                   := le.iid.combo_dobscore;
		PR_count                         := le.source_verification.pr_count;
		EM_count                         := le.source_verification.em_count;
		adl_eq_first_seen                := le.source_verification.adl_eqfs_first_seen;
		voter_avail                      := le.available_sources.voter;
		ssnlength                        := le.input_validation.ssn_length;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		telcordia_type                   := le.phone_verification.telcordia_type;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		bankrupt                         := le.bjl.bankrupt;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		criminal_count                   := le.bjl.criminal_count;
		archive_date                     := if(le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate);

		input_dob_match_level            := le.dobmatchlevel;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		rc_bansflag                      := le.iid.bansflag;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;

		NULL := -999999999;

		BOOLEAN indexw(string source, string target, string delim) :=
			(source = target) OR
			(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
			(source[1..length(target)+1] = target + delim) OR
			(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);


		archive_yr := ((STRING)archive_date)[1..4];
		archive_mo := ((STRING)archive_date)[5..6];

		today := ut.DaysSince1900(archive_yr, archive_mo, '01');//) - ut.DaysSince1900('1960', '01', '01'));

		string2 fixDt( string2 part ) := if( (integer)part=0, '01', part );

		today1900 := today;
		birth1900 := ut.DaysSince1900( in_dob[1..4],         fixDt(in_dob[5..6]),         fixDt(in_dob[7..8]) );
		li1900    := ut.DaysSince1900( rc_ssnlowissue[1..4], fixDt(rc_ssnlowissue[5..6]), fixDt(rc_ssnlowissue[7..8]) );



		rc_ssnlowissue_sas := if( trim(rc_ssnlowissue) in ['0',''], -1,                 (integer)((today1900-li1900)/365.25));
		age_calc           := if( trim(in_dob)         in ['0',''], rc_ssnlowissue_sas, (integer)((today1900-birth1900)/365.25));
		age_gt19 := age_calc > 19;

		//age_at_low_issue := if( (integer)rc_ssnlowissue != 0 and (integer)in_dob != 0, (integer)((li1900-birth1900)/365.25), NULL ); 
		age_at_low_issue := if( trim(rc_ssnlowissue) not in ['','0'] and trim(in_dob) not in ['','0'], (integer)((li1900-birth1900)/365.25), NULL ); 
		age_at_low_issue_neg3_30 := max(min(age_at_low_issue,30),-3);
		age_at_low_issue_neg7_50 := max(min(age_at_low_issue,50),-7);

		

		age_summary_m :=  map(
			age_calc <= 18 => 35.73,
			age_calc <= 20 => 34.33,
			25.17
		);


		in_date := ut.DaysSince1900(
			((STRING)adl_eq_first_seen)[1..4],
			if( ((STRING)adl_eq_first_seen)[5..6]='00', '01', ((STRING)adl_eq_first_seen)[5..6] ),
			'01'//adl_eq_first_seen[7..8]
		);

		time_snc_adl_eq_first_seen := if( adl_eq_first_seen=0, NULL, (integer)((today-in_date)/30.4375) );

		time_snc_adl_eq_first_seen_7yrs := if( time_snc_adl_eq_first_seen != NULL, min((integer)(time_snc_adl_eq_first_seen/12),7), NULL );
		time_snc_adl_eq_summary_m := map(
			time_snc_adl_eq_first_seen_7yrs = NULL => 23.56,
			time_snc_adl_eq_first_seen_7yrs = 0    => 36.15,
			time_snc_adl_eq_first_seen_7yrs < 5    => 28.49,
			31.11
		);


		source_AK_tot := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'AK', ',') > 0);
		source_AM_tot := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'AM', ',') > 0);
		source_CG_tot := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'CG', ',') > 0);
		source_P_tot  := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'P', ',') > 0);
		source_PL_tot := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'PL', ',') > 0);
		source_W_tot  := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'W', ',') > 0);
		source_WP_tot := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'WP', ',') > 0);
		num_pos_sources_NOEQ_tot := if(max((integer)source_AM_tot, (integer)source_AK_tot, (integer)source_CG_tot, (integer)source_P_tot, (integer)source_PL_tot, (integer)source_W_tot, (integer)source_WP_tot) = NULL, NULL, sum((integer)source_AM_tot, (integer)source_AK_tot, (integer)source_CG_tot, (integer)source_P_tot, (integer)source_PL_tot, (integer)source_W_tot, (integer)source_WP_tot));

		num_pos_sources_NOEQ_tot_2 := min(if(num_pos_sources_NOEQ_tot = NULL, -NULL, num_pos_sources_NOEQ_tot), 2);

		no_voter_rec_when_avail := (voter_avail and (em_count = 0));

		verfst_p := 0;

		verlst_p := 0;

		veradd_p := 0;

		verphn_p := 0;

		verphn_p_2 :=  if(nap_summary in [4,6,7,9,10,11,12], 1, 0 );
		verlst_p_2 :=  if(nap_summary in [2,5,7,8,9,11,12], 1, 0 );
		veradd_p_2 :=  if(nap_summary in [3,5,6,8,10,11,12], 1, 0 );
		verfst_p_2 :=  if(nap_summary in [2,3,4,8,9,10,12], 1, 0 );

		pnotpots := telcordia_type not in ['00', '50', '51', '52', '54'];

		combo_dobscore_100 := (combo_dobscore = 100);

		verx_b1 := map(not(((boolean)verlst_p_2 or ((boolean)veradd_p_2 or ((boolean)verphn_p_2 or combo_dobscore_100))))  => 2,
									 not((boolean)verlst_p_2)                                                                            => 1,
									 not(((boolean)verlst_p_2 and ((boolean)veradd_p_2 and (boolean)verphn_p_2)))                        => 3,
									 (boolean)verlst_p_2 and ((boolean)veradd_p_2 and ((boolean)verphn_p_2 and not(combo_dobscore_100))) => 4,
																																																													5);

		verx_b2 := if(not(combo_dobscore_100) and not(((boolean)verphn_p_2 and (boolean)verlst_p_2)), 0, 3.5);

		verx := if(add1_isbestmatch, verx_b1, verx_b2);

		verx_m :=  map(
			verx = 0   => 39.59,
			verx = 1   => 38.81,
			verx = 2   => 32.67,
			verx = 3   => 30.41,
			verx = 3.5 => 27.52,
			verx = 4   => 25.80,
			23.53
		);

		verx2_m :=  map(pnotpots                                                                   => 45.00,
										(boolean)veradd_p_2 and not((boolean)verlst_p_2)                           => 38.74,
										not((boolean)veradd_p_2)                                                   => 33.21,
										(boolean)veradd_p_2 and ((boolean)verlst_p_2 and not((boolean)verphn_p_2)) => 30.56,
																																																	28.67);

		add1_avm_automated_val_500k_0td :=  if(add1_avm_automated_valuation != 0, min(if(if ((add1_avm_automated_valuation / 1000) >= 0, truncate((add1_avm_automated_valuation / 1000)), roundup((add1_avm_automated_valuation / 1000))) = NULL, -NULL, if ((add1_avm_automated_valuation / 1000) >= 0, truncate((add1_avm_automated_valuation / 1000)), roundup((add1_avm_automated_valuation / 1000)))), 500), 220);


		add1_avm_automated_val_500k_td := if( add1_avm_automated_valuation != 0, min(round(add1_avm_automated_valuation/1000),500), 140 );




		hi_addrs_per_ssn := (addrs_per_ssn >= 2);

		hi_ssns_per_addr := (ssns_per_addr > 10);

		ssns_per_adl_ge2 := (ssns_per_adl >= 2);

		addrs_per_ssn_3 := min(if(addrs_per_ssn = NULL, -NULL, addrs_per_ssn), 3);

		add1_naprop_summary_m_0truedid :=  map(add1_naprop = 0 => 35.97,
																					 add1_naprop = 1 => 39.31,
																															27.18);

		PR_ind := min(if(pr_count = NULL, -NULL, pr_count), 1);

		property_owned_ind := min(if(property_owned_total = NULL, -NULL, property_owned_total), 1);

		add1_naprop_summary :=  map((add1_naprop = 0) and not(((boolean)PR_ind or (boolean)property_owned_ind)) => 0,
																(add1_naprop = 0) and ((boolean)PR_ind or (boolean)property_owned_ind)      => 2,
																add1_naprop = 1                                                             => 1,
																																																							 2);

		add1_naprop_summary_m_truedid :=  map(add1_naprop_summary = 0 => 34.40,
																					add1_naprop_summary = 1 => 40.35,
																																		 23.37);

		disconnected := ((integer)(real)rc_hriskphoneflag = 5);

		derog_flag := (bankrupt or ((liens_historical_unreleased_ct > 0) or ((liens_historical_released_count > 0) or (criminal_count > 0))));





		/*--------------*/
		/*  TRUEDID=0   */
		/*--------------*/
		// if truedid = 0 then do;
		outest := if( truedid,
			-5.129274106
				+ verx_m  					* 0.0283899843
				+ age_summary_m  				* 0.0480156278
				+ age_at_low_issue_neg7_50  	* -0.0145995
				+ (integer)disconnected  				* 0.3636768473
				+ (integer)ssns_per_adl_ge2  			* 0.748242892
				+ addrs_per_ssn_3  			* 0.1612857934
				+ time_snc_adl_eq_summary_m  	* 0.0227478538
				+ num_pos_sources_NOEQ_tot_2  * -0.301547744
				+ (integer)no_voter_rec_when_avail  	* 0.3062173591
				+ add1_avm_automated_val_500k_td * -0.001605893
				+ add1_naprop_summary_m_truedid  		* 0.0354758728
				+ (integer)derog_flag  				* 1.1925182616,
				
			-3.117517334
				+ verx2_m  						* 0.0448601495
				+ add1_avm_automated_val_500k_0td  	* -0.002665597
				+ (integer)age_gt19  						* -0.436749128
				+ age_at_low_issue_neg3_30  		* -0.020489742
				+ (integer)hi_addrs_per_ssn  				* 0.3620542347
				+ (integer)hi_ssns_per_addr  				* 0.4557485217
				+ add1_naprop_summary_m_0truedid  			* 0.0463060091
			);
		p_1 := (exp(outest )) / (1+exp(outest ));




		cust_score := round(-40*(log(p_1/(1-p_1)) - log(1/21))/log(2) + 783);
		rvt809_1_0a := min(900,max(501,cust_score));


		Common.findw(  rc_sources, 'L2', ' ,', 'I', source_tot_L2, 'bool' );
		Common.findw(  rc_sources, 'LI', ' ,', 'I', source_tot_LI, 'bool' );
		lien_rec_unrel_flag := (liens_recent_unreleased_count > 0);
		lien_hist_unrel_flag := (liens_historical_unreleased_ct > 0);
		lien_flag := (((integer)source_tot_L2 = 1) or (((integer)source_tot_LI = 1) or (lien_rec_unrel_flag or lien_hist_unrel_flag)));

		Common.findw(  rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool' );
		bk_flag := ((rc_bansflag in ['1', '2']) or (((integer)source_tot_BA = 1) or (((integer)bankrupt = 1) or ((filing_count > 0) or (bk_recent_count > 0)))));
		
		Common.findw(  rc_sources, 'DS', ' ,', 'I', source_tot_DS, 'bool' );
		ssn_deceased := (((integer)rc_decsflag = 1) or ((integer)source_tot_DS = 1));

		scored_222s :=
			sum(property_owned_total,property_sold_total) > 0 or
			combo_dobscore  between 90 and 100 or
			(integer1)input_dob_match_level >= 7 or
			lien_flag or
			criminal_count > 0 or
			bk_flag or
			ssn_deceased or
			truedid
		;

		rvt809_1_0b := if(riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 222, rvt809_1_0a);

		ssndead     := ((integer)ssnlength>0 and rc_decsflag='1');
		ssnprior    := (rc_ssndobflag='1' or rc_pwssndobflag='1');
		corrections := (rc_hrisksic='2225');

		rvt809_1_0 := if((ssndead or ssnprior or corrections) and rvt809_1_0b > 670, 670, rvt809_1_0b );



		// <reason code logic stolen from rvr711_0_0>
		inCalif := isCalifornia and (
			(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
			+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
			+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		
		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			rvt809_1_0 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			RiskWise.rvReasonCodes(le, 4, inCalif, not useRcSetV1 /*use BS v2 reason codes*/)
		);
		// </reason>

		self.seq := le.seq;
		self.score := map(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			self.ri[1].hri='35' => '000',
			(STRING3)rvt809_1_0
		);

#if(RVT_DEBUG)
self.truedid := truedid;
self.in_dob := in_dob;
self.nas_summary := nas_summary;
self.nap_summary := nap_summary;
self.rc_hriskphoneflag := rc_hriskphoneflag;
self.rc_decsflag := rc_decsflag;
self.rc_ssndobflag := rc_ssndobflag;
self.rc_pwssndobflag := rc_pwssndobflag;
self.rc_ssnlowissue := rc_ssnlowissue;
self.rc_sources := rc_sources;
self.rc_hrisksic := rc_hrisksic;
self.combo_dobscore := combo_dobscore;
self.PR_count := PR_count;
self.EM_count := EM_count;
self.adl_eq_first_seen := adl_eq_first_seen;
self.voter_avail := voter_avail;
self.ssnlength := ssnlength;
self.add1_isbestmatch := add1_isbestmatch;
self.add1_avm_automated_valuation := add1_avm_automated_valuation;
self.add1_naprop := add1_naprop;
self.property_owned_total := property_owned_total;
self.property_sold_total := property_sold_total;
self.telcordia_type := telcordia_type;
self.ssns_per_adl := ssns_per_adl;
self.addrs_per_ssn := addrs_per_ssn;
self.ssns_per_addr := ssns_per_addr;
self.bankrupt := bankrupt;
self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
self.liens_historical_released_count := liens_historical_released_count;
self.criminal_count := criminal_count;
self.archive_date := archive_date;
self.archive_yr := archive_yr;
self.archive_mo := archive_mo;
self.today := today;
self.today1900 := today1900;
self.birth1900 := birth1900;
self.li1900 := li1900;
self.age_calc := age_calc;
self.age_gt19 := age_gt19;
self.age_at_low_issue := age_at_low_issue;
self.age_at_low_issue_neg3_30 := age_at_low_issue_neg3_30;
self.age_at_low_issue_neg7_50 := age_at_low_issue_neg7_50;
self.age_summary_m := age_summary_m;
self.in_date := in_date;
self.time_snc_adl_eq_first_seen := time_snc_adl_eq_first_seen;
self.time_snc_adl_eq_first_seen_7yrs := time_snc_adl_eq_first_seen_7yrs;
self.time_snc_adl_eq_summary_m := time_snc_adl_eq_summary_m;
self.source_AK_tot := source_AK_tot;
self.source_AM_tot := source_AM_tot;
self.source_CG_tot := source_CG_tot;
self.source_P_tot := source_P_tot;
self.source_PL_tot := source_PL_tot;
self.source_W_tot := source_W_tot;
self.source_WP_tot := source_WP_tot;
self.num_pos_sources_NOEQ_tot := num_pos_sources_NOEQ_tot;
self.num_pos_sources_NOEQ_tot_2 := num_pos_sources_NOEQ_tot_2;
self.no_voter_rec_when_avail := no_voter_rec_when_avail;
self.verfst_p := verfst_p;
self.verlst_p := verlst_p;
self.veradd_p := veradd_p;
self.verphn_p := verphn_p;
self.verphn_p_2 := verphn_p_2;
self.verlst_p_2 := verlst_p_2;
self.veradd_p_2 := veradd_p_2;
self.verfst_p_2 := verfst_p_2;
self.pnotpots := pnotpots;
self.combo_dobscore_100 := combo_dobscore_100;
self.verx_b1 := verx_b1;
self.verx_b2 := verx_b2;
self.verx := verx;
self.verx_m := verx_m;
self.verx2_m := verx2_m;
self.add1_avm_automated_val_500k_0td := add1_avm_automated_val_500k_0td;
self.add1_avm_automated_val_500k_td := add1_avm_automated_val_500k_td;
self.hi_addrs_per_ssn := hi_addrs_per_ssn;
self.hi_ssns_per_addr := hi_ssns_per_addr;
self.ssns_per_adl_ge2 := ssns_per_adl_ge2;
self.addrs_per_ssn_3 := addrs_per_ssn_3;
self.add1_naprop_summary_m_0truedid := add1_naprop_summary_m_0truedid;
self.PR_ind := PR_ind;
self.property_owned_ind := property_owned_ind;
self.add1_naprop_summary := add1_naprop_summary;
self.add1_naprop_summary_m_truedid := add1_naprop_summary_m_truedid;
self.disconnected := disconnected;
self.derog_flag := derog_flag;
self.outest := outest;
self.p_1 := p_1;
self.cust_score := cust_score;
self.rvt809_1_0a := rvt809_1_0a;
self.rvt809_1_0b := rvt809_1_0b;
self.ssndead := ssndead;
self.ssnprior := ssnprior;
self.corrections := corrections;
self.rvt809_1_0 := rvt809_1_0;


self.source_tot_L2 := source_tot_L2;
self.source_tot_LI := source_tot_LI;
self.liens_recent_unreleased_count := liens_recent_unreleased_count;
self.lien_flag := lien_flag;
self.input_dob_match_level := input_dob_match_level;
self.rc_bansflag := rc_bansflag;
self.source_tot_BA := source_tot_BA;
self.filing_count := filing_count;
self.bk_recent_count := bk_recent_count;
self.bk_flag := bk_flag;
self.source_tot_DS := source_tot_DS;
self.ssn_deceased := ssn_deceased;
self.scored_222s := scored_222s;


#end









	end;
	
	model := project( clam, domodel(left) );
	
	return model;
end;
