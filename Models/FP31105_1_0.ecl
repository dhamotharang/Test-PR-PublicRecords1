IMPORT ut, EASI, RiskWise, RiskWiseFCRA, Risk_Indicators;

BocaShell_With_IP := RECORD
	Risk_Indicators.Layout_Boca_Shell bs;
	RiskWise.Layout_IP2O ip;
END;

EXPORT fp31105_1_0 (DATASET(BocaShell_With_IP) clam, INTEGER num_reasons = 6, BOOLEAN criminal = FALSE) := FUNCTION

	MODEL_DEBUG := false;
	
	#if(MODEL_DEBUG)
		Layout_Debug := RECORD


			/* Model Input Variables */
			STRING c_cartheft;
			STRING c_famotf18_p;
			STRING in_dob;
			INTEGER nas_summary;
			INTEGER nap_summary;
			INTEGER did_count;
			STRING rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			STRING rc_phonevalflag;
			STRING rc_hphonevalflag;
			STRING rc_phonezipflag;
			STRING rc_hriskaddrflag;
			STRING rc_decsflag;
			STRING rc_ssndobflag;
			STRING rc_ssnvalflag;
			STRING rc_pwssnvalflag;
			INTEGER rc_ssnhighissue;
			STRING rc_addrvalflag;
			STRING rc_dwelltype;
			STRING rc_addrcommflag;
			STRING rc_hrisksic;
			STRING rc_hrisksicphone;
			STRING rc_cityzipflag;
			BOOLEAN rc_watchlist_flag;
			STRING ssnlength;
			BOOLEAN dobpop;
			BOOLEAN hphnpop;
			BOOLEAN add1_isbestmatch;
			INTEGER add1_naprop;
			BOOLEAN add2_isbestmatch;
			INTEGER avg_lres;
			BOOLEAN addrs_prison_history;
			INTEGER ssns_per_adl;
			INTEGER adlperssn_count;
			INTEGER adls_per_addr;
			INTEGER ssns_per_adl_c6;
			INTEGER adls_per_addr_c6;
			INTEGER impulse_count;
			INTEGER attr_addrs_last24;
			INTEGER attr_num_aircraft;
			INTEGER attr_total_number_derogs;
			INTEGER attr_eviction_count;
			STRING disposition;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER felony_count;
			INTEGER rel_felony_count;
			INTEGER current_count;
			INTEGER watercraft_count;
			STRING ams_college_tier;
			BOOLEAN prof_license_flag;
			INTEGER estimated_income;
			INTEGER archive_date;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			INTEGER in_dob2;
			REAL years_in_dob;
			REAL mth_in_dob;
			INTEGER years_in_dob1;
			INTEGER best_match_level;
			INTEGER add1_naprop1;
			DECIMAL11_10 add1_naprop1_m;
			INTEGER avg_lres1;
			DECIMAL11_10 avg_lres1_l;
			INTEGER adlperssn_count1;
			INTEGER adls_per_addr_c61;
			DECIMAL11_10 adls_per_addr_c61_l;
			BOOLEAN impulse_flag;
			INTEGER attr_addrs_last241;
			INTEGER rel_felony_count1;
			DECIMAL11_10 rel_felony_count1_m;
			INTEGER current_count1;
			DECIMAL11_10 current_count1_m;
			INTEGER estimated_income_lvl;
			DECIMAL11_10 estimated_income_lvl_m;
			INTEGER bad_behavior;
			BOOLEAN watercraft_flag;
			INTEGER good_behavior;
			DECIMAL11_10 good_behavior_l;
			INTEGER c_cartheft1;
			DECIMAL11_10 c_cartheft1_m;
			INTEGER c_famotf18_p1;
			BOOLEAN crime_felony_flag;
			DECIMAL11_10 crime_felony_flag_m;
			BOOLEAN attr_eviction_flag;
			INTEGER lien_total;
			INTEGER derog_level3;
			DECIMAL11_10 derog_level3_m;
			INTEGER ssn_combo;
			DECIMAL11_10 ssn_combo_m;
			DECIMAL11_10 logit;
			INTEGER base;
			REAL odds;
			INTEGER point;
			DECIMAL11_10 phat;
			INTEGER fp3710;
			INTEGER mod1_custom1;
			INTEGER usps_deliverable;
			INTEGER ssnhighissue_yr;
			INTEGER dob_yr;
			INTEGER dob_mismatch;
			INTEGER verssn_s;
			INTEGER hr_phone;
			INTEGER phn_corrections;
			INTEGER not_deliverable;
			INTEGER add1_hr_address;
			INTEGER corrections;
			INTEGER ssn_valid;
			INTEGER watchlist_hit;
			INTEGER dob_mismatch_flag;
			INTEGER ssnpop;
			INTEGER nas_ver;
			INTEGER condition1;
			INTEGER verfst_p_1;
			INTEGER verlst_p_1;
			INTEGER veradd_p_1;
			INTEGER verphn_p_1;
			INTEGER contrary_phone_1;
			INTEGER verphn_p;
			INTEGER condition2;
			INTEGER disconnected;
			INTEGER condition3;
			INTEGER pnotpot;
			INTEGER condition4;
			INTEGER phninval;
			INTEGER phninval2_1;
			INTEGER busphone_flag_1;
			INTEGER hr_phone_flag_1;
			INTEGER non_land_phone_flag_1;
			INTEGER phninval2;
			INTEGER hr_phone_flag;
			INTEGER busphone_flag;
			INTEGER condition5;
			INTEGER condition6;
			INTEGER condition7;
			INTEGER phone_zip_mismatch;
			INTEGER condition8;
			INTEGER condition9;
			INTEGER condition10;
			INTEGER city_zip_mismatch;
			INTEGER condition11;
			INTEGER hirisk_commercial_flag;
			INTEGER condition12;
			INTEGER condition13;
			INTEGER deceased;
			INTEGER ssnprior_pi;
			INTEGER ssninval_pw;
			INTEGER aptflag;
			INTEGER condition14;
			INTEGER condition15;
			INTEGER condition16;
			INTEGER condition17;
			INTEGER condition18;
			INTEGER condition19;
			INTEGER fp31105_1_0;

			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
			STRING4 rc5;
			STRING4 rc6;
			
			Risk_Indicators.Layout_Boca_Shell clam;
			RiskWise.Layout_IP2O ip;
			
		END;
		Layout_Debug doModel(clam le, EASI.Key_Easi_Census ri) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le, EASI.Key_Easi_Census ri) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	c_cartheft                       := ri.CARTHEFT;
	c_famotf18_p                     := ri.FAMOTF18_P;
	in_dob                           := le.bs.shell_input.dob;
	nas_summary                      := le.bs.iid.nas_summary;
	nap_summary                      := le.bs.iid.nap_summary;
	did_count                        := le.bs.iid.didcount;
	rc_hriskphoneflag                := le.bs.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.bs.iid.hphonetypeflag;
	rc_phonevalflag                  := le.bs.iid.phonevalflag;
	rc_hphonevalflag                 := le.bs.iid.hphonevalflag;
	rc_phonezipflag                  := le.bs.iid.phonezipflag;
	rc_hriskaddrflag                 := le.bs.iid.hriskaddrflag;
	rc_decsflag                      := le.bs.iid.decsflag;
	rc_ssndobflag                    := le.bs.iid.socsdobflag;
	rc_ssnvalflag                    := le.bs.iid.socsvalflag;
	rc_pwssnvalflag                  := le.bs.iid.pwsocsvalflag;
	rc_ssnhighissue                  := (unsigned)le.bs.iid.soclhighissue;
	rc_addrvalflag                   := le.bs.iid.addrvalflag;
	rc_dwelltype                     := le.bs.iid.dwelltype;
	rc_addrcommflag                  := le.bs.iid.addrcommflag;
	rc_hrisksic                      := le.bs.iid.hrisksic;
	rc_hrisksicphone                 := le.bs.iid.hrisksicphone;
	rc_cityzipflag                   := le.bs.iid.cityzipflag;
	rc_watchlist_flag                := le.bs.iid.watchlisthit;
	ssnlength                        := le.bs.input_validation.ssn_length;
	dobpop                           := le.bs.input_validation.dateofbirth;
	hphnpop                          := le.bs.input_validation.homephone;
	add1_isbestmatch                 := le.bs.address_verification.input_address_information.isbestmatch;
	add1_naprop                      := le.bs.address_verification.input_address_information.naprop;
	add2_isbestmatch                 := le.bs.address_verification.address_history_1.isbestmatch;
	avg_lres                         := le.bs.other_address_info.avg_lres;
	addrs_prison_history             := le.bs.other_address_info.isprison;
	ssns_per_adl                     := le.bs.velocity_counters.ssns_per_adl;
	adlperssn_count                  := le.bs.ssn_verification.adlperssn_count;
	adls_per_addr                    := le.bs.velocity_counters.adls_per_addr;
	ssns_per_adl_c6                  := le.bs.velocity_counters.ssns_per_adl_created_6months;
	adls_per_addr_c6                 := le.bs.velocity_counters.adls_per_addr_created_6months;
	impulse_count                    := le.bs.impulse.count;
	attr_addrs_last24                := le.bs.other_address_info.addrs_last24;
	attr_num_aircraft                := le.bs.aircraft.aircraft_count;
	attr_total_number_derogs         := le.bs.total_number_derogs;
	attr_eviction_count              := le.bs.bjl.eviction_count;
	disposition                      := le.bs.bjl.disposition;
	liens_recent_unreleased_count    := le.bs.BJL.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bs.BJL.liens_historical_unreleased_count;
	felony_count                     := le.bs.bjl.felony_count;
	rel_felony_count                 := le.bs.relatives.relative_felony_count;
	current_count                    := le.bs.vehicles.current_count;
	watercraft_count                 := le.bs.watercraft.watercraft_count;
	ams_college_tier                 := le.bs.student.college_tier;
	prof_license_flag                := le.bs.professional_license.professional_license_flag;
	estimated_income                 := le.bs.estimated_income;
	archive_date                     := IF(le.bs.historydate = 999999, (INTEGER)ut.GetDate[1..6], (INTEGER)le.bs.historydate[1..6]);

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
	NULL := -999999999;
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	INTEGER year(integer sas_date) :=
		if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));
	
	sysdate := map(
	    trim((string)archive_date, LEFT, RIGHT) = '999999'  => Common.SAS_Date((STRING)if(le.bs.historydate=999999, (string)ut.getdate, (string6)le.bs.historydate+'01')),
	    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
	                                                           NULL);
	
	in_dob2 := Common.SAS_Date((STRING)(string)(in_dob));
	
	years_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, (sysdate - in_dob2) / 365.25);
	
	mth_in_dob := if(min(sysdate, in_dob2) = NULL, NULL, (sysdate - in_dob2) / 30.5);
	
	years_in_dob1 := map(
	    years_in_dob < 18  => 1,
	    years_in_dob <= 28 => 5,
	    years_in_dob <= 35 => 4,
	    years_in_dob <= 49 => 3,
	    years_in_dob <= 55 => 2,
	                          1);
	
	best_match_level := map(
	    (integer)add1_isbestmatch = 1 => 2,
	    (integer)add2_isbestmatch = 1 => 0,
	                                     1);
	
	add1_naprop1 := map(
	    add1_naprop >= 2 => 1,
	    add1_naprop = 1  => 3,
	                        2);
	
	add1_naprop1_m := map(
	    add1_naprop1 = 1 => (DECIMAL11_10)0.0004735656,
	    add1_naprop1 = 2 => (DECIMAL11_10)0.0032237744,
	    add1_naprop1 = 3 => (DECIMAL11_10)0.0039718634,
	                        (DECIMAL11_10)0.0021550195);
	
	avg_lres1 := map(
	    avg_lres = 0    => 2,
	    avg_lres <= 5   => 5,
	    avg_lres <= 37  => 4,
	    avg_lres <= 82  => 3,
	    avg_lres <= 100 => 2,
	                       1);
	
	avg_lres1_l := map(
	    avg_lres1 = 1 => (DECIMAL11_10)0.0001620531,
	    avg_lres1 = 2 => (DECIMAL11_10)0.000237435,
	    avg_lres1 = 3 => (DECIMAL11_10)0.0001467587,
	    avg_lres1 = 4 => (DECIMAL11_10)0.0001930722,
	    avg_lres1 = 5 => (DECIMAL11_10)0.0013989209,
	                     (DECIMAL11_10)0.0000534086);
	
	adlperssn_count1 := map(
	    adlperssn_count = 1  => 1,
	    adlperssn_count <= 2 => 2,
	                            3);
	
	adls_per_addr_c61 := if(adls_per_addr_c6 >= 4, 4, adls_per_addr_c6);
	
	adls_per_addr_c61_l := map(
	    adls_per_addr_c61 = 0 => (DECIMAL11_10)0.0000704408,
	    adls_per_addr_c61 = 1 => (DECIMAL11_10)0.0002369486,
	    adls_per_addr_c61 = 2 => (DECIMAL11_10)0.0004812136,
	    adls_per_addr_c61 = 3 => (DECIMAL11_10)0.0014080137,
	    adls_per_addr_c61 = 4 => (DECIMAL11_10)0.0022527512,
	                             (DECIMAL11_10)0.0000534086);
	
	impulse_flag := impulse_count > 0;
	
	attr_addrs_last241 := if(attr_addrs_last24 >= 5, 5, attr_addrs_last24);
	
	rel_felony_count1 := if(rel_felony_count >= 4, 4, rel_felony_count);
	
	rel_felony_count1_m := map(
	    rel_felony_count1 = 0 => (DECIMAL11_10)0.0014619728,
	    rel_felony_count1 = 1 => (DECIMAL11_10)0.0035575412,
	    rel_felony_count1 = 2 => (DECIMAL11_10)0.0062041737,
	    rel_felony_count1 = 3 => (DECIMAL11_10)0.0110573601,
	    rel_felony_count1 = 4 => (DECIMAL11_10)0.0186480186,
	                             (DECIMAL11_10)0.0021550195);
	
	current_count1 := if(current_count >= 3, 3, current_count);
	
	current_count1_m := map(
	    current_count1 = 0 => (DECIMAL11_10)0.0028328612,
	    current_count1 = 1 => (DECIMAL11_10)0.0025643804,
	    current_count1 = 2 => (DECIMAL11_10)0.0014464534,
	    current_count1 = 3 => (DECIMAL11_10)0.0012335825,
	                          (DECIMAL11_10)0.0021550195);
	
	estimated_income_lvl := map(
	    estimated_income = 0      => 3,
	    estimated_income <= 25000 => 5,
	    estimated_income <= 29000 => 4,
	    estimated_income <= 39000 => 3,
	    estimated_income <= 44000 => 2,
	                                 1);
	
	estimated_income_lvl_m := map(
	    estimated_income_lvl = 1 => (DECIMAL11_10)0.0007869196,
	    estimated_income_lvl = 2 => (DECIMAL11_10)0.001356949,
	    estimated_income_lvl = 3 => (DECIMAL11_10)0.0026211646,
	    estimated_income_lvl = 4 => (DECIMAL11_10)0.0055953447,
	    estimated_income_lvl = 5 => (DECIMAL11_10)0.0069767442,
	                                (DECIMAL11_10)0.0021550195);
	
	bad_behavior := if(did_count != 1 or (INTEGER)rc_cityzipflag = 1 or (integer)rc_watchlist_flag = 1 or (integer)addrs_prison_history = 1 or (INTEGER)rc_decsflag = 1 or (INTEGER)rc_ssndobflag = 1 or (INTEGER)rc_pwssnvalflag = 4 or (INTEGER)rc_addrcommflag = 1, 1, 0);
	
	watercraft_flag := watercraft_count > 0;
	
	good_behavior := if(attr_num_aircraft > 0 or (integer)watercraft_flag = 1 or (integer)prof_license_flag = 1 or (INTEGER)ams_college_tier > 0, 1, 0);
	
	good_behavior_l := map(
	    good_behavior = 0 => (DECIMAL11_10)0.0000627155,
	    good_behavior = 1 => (DECIMAL11_10)0.0002449004,
	                         (DECIMAL11_10)0.0000534086);
	
	c_cartheft1 := map(
	    TRIM(C_CARTHEFT) = '' or (INTEGER)C_CARTHEFT <= 98 			=> 1,
	    (INTEGER)C_CARTHEFT <= 157                             	=> 2,
	    (INTEGER)C_CARTHEFT <= 192                             	=> 3,
																																4);
	
	c_cartheft1_m := map(
	    c_cartheft1 = 1 => (DECIMAL11_10)0.0012936778,
	    c_cartheft1 = 2 => (DECIMAL11_10)0.0026563632,
	    c_cartheft1 = 3 => (DECIMAL11_10)0.003390469,
	    c_cartheft1 = 4 => (DECIMAL11_10)0.007875123,
	                       (DECIMAL11_10)0.0021550195);
	
	c_famotf18_p1 := map(
	    TRIM(C_FAMOTF18_P) = '' or (REAL)C_FAMOTF18_P <= 5 	=> 1,
	    (REAL)C_FAMOTF18_P <= 9                         			=> 2,
	    (REAL)C_FAMOTF18_P <= 15                        			=> 3,
	    (REAL)C_FAMOTF18_P <= 27                        			=> 4,
	                                                             5);
	
	crime_felony_flag := felony_count > 0;
	
	crime_felony_flag_m := map(
	    (integer)crime_felony_flag = 0 => (DECIMAL11_10)0.0017542577,
	    (integer)crime_felony_flag = 1 => (DECIMAL11_10)0.0153985507,
	                                      (DECIMAL11_10)0.0021550195);
	
	attr_eviction_flag := attr_eviction_count > 0;
	
	lien_total := liens_recent_unreleased_count + liens_historical_unreleased_ct;
	
	derog_level3 := map(
	    attr_eviction_flag or attr_total_number_derogs > 6 => 3,
	    lien_total > 0 or disposition = 'Dismissed'        => 2,
	                                                          1);
	
	derog_level3_m := map(
	    derog_level3 = 1 => (DECIMAL11_10)0.0014942623,
	    derog_level3 = 2 => (DECIMAL11_10)0.0017197961,
	    derog_level3 = 3 => (DECIMAL11_10)0.008042152,
	                        (DECIMAL11_10)0.0021550195);
	
	ssn_combo := map(
	    ssns_per_adl <= 1 and nas_summary >= 10                     => 1,
	    ssns_per_adl = 1 and nas_summary < 10                       => 3,
	    ssns_per_adl <= 1 or ssns_per_adl = 2 and nas_summary >= 10 => 2,
	    ssns_per_adl <= 3                                           => 4,
	                                                                   5);
	
	ssn_combo_m := map(
	    ssn_combo = 1 => (DECIMAL11_10)0.0009503863,
	    ssn_combo = 2 => (DECIMAL11_10)0.0018765472,
	    ssn_combo = 3 => (DECIMAL11_10)0.0032327074,
	    ssn_combo = 4 => (DECIMAL11_10)0.0048856053,
	    ssn_combo = 5 => (DECIMAL11_10)0.022479564,
	                     (DECIMAL11_10)0.0021550195);
	
			
	logit := -11.16770716
                  + years_in_dob1  * 0.2455575639
                  + best_match_level  * -0.239904897
                  + add1_naprop1_m  * 262.63181098
                  + avg_lres1_l  * 528.73722441
                  + adlperssn_count1  * 0.2573872864
                  + adls_per_addr_c61_l  * 455.22060814
                  + (integer)impulse_flag  * 1.0745298703
                  + attr_addrs_last241  * 0.1733383111
                  + rel_felony_count1_m  * 54.157149847
                  + current_count1_m  * 350.17729956
                  + estimated_income_lvl_m  * 142.03049127
                  + bad_behavior  * 0.5218637691
                  + good_behavior_l  * -3565.393973
                  + C_CARTHEFT1_m  * 137.2460573
                  + C_FAMOTF18_P1  * 0.204303012
                  + crime_felony_flag_m  * 71.144632216
                  + derog_level3_m  * 56.046470462
                  + ssn_combo_m  * 64.041797705;
	
	base := 555;
	
	odds := 0.0531 / 0.9469;
	
	point := -40;
	
	phat := exp(logit) / (1 + exp(logit));
	
	fp3710 := truncate(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);
	
	mod1_custom1 := max(300, min(999, if(fp3710 = NULL, -NULL, fp3710)));
	
	usps_deliverable := if(rc_addrvalflag = 'V', 1, 0);
	
	ssnhighissue_yr := map(
	    trim((STRING)rc_ssnhighissue) = '' => NULL,
	    rc_ssnhighissue = 0                => NULL,
	                                    (UNSIGNED)TRIM((string)rc_ssnhighissue[1..4]));
	
	dob_yr := map(
	    trim(in_dob) = '' 				=> NULL,
	    (INTEGER)in_dob = 0       => NULL,
																(UNSIGNED)(trim(in_dob[1..4])));
	
	dob_mismatch := map(
	    ssnhighissue_yr = NULL or dob_yr = NULL => 0,
	    dob_yr > ssnhighissue_yr and dobpop     => dob_yr - ssnhighissue_yr,
	                                               0);
	
	verssn_s := if((nas_summary in [4, 6, 7, 9, 10, 11, 12]), 1, 0);
	
	hr_phone := if((INTEGER)rc_hriskphoneflag = 6, 1, 0);
	
	phn_corrections := if((INTEGER)rc_hrisksicphone = 2225, 1, 0);
	
	not_deliverable := if(usps_deliverable = 0, 1, 0);
	
	add1_hr_address := if((INTEGER)rc_hriskaddrflag = 4, 1, 0);
	
	corrections := if((INTEGER)rc_hrisksic = 2225, 1, 0);
	
	ssn_valid := if((rc_ssnvalflag in ['0', '3']) or (INTEGER)rc_ssnvalflag = 2 and (INTEGER)ssnlength = 4, 1, 0);
	
	watchlist_hit := if((integer)rc_watchlist_flag = 1, 1, 0);
	
	dob_mismatch_flag := if(dob_mismatch > 0, 1, 0);
	
	ssnpop := if((INTEGER)ssnlength > 0, 1, 0);
	
	nas_ver := if(nas_summary >= 10, 1, 0);
	
	condition1 := if(ssnpop = 1 and nas_ver = 0, 1, 0);
	
	verfst_p_1 := 0;
	
	verlst_p_1 := 0;
	
	veradd_p_1 := 0;
	
	verphn_p_1 := 0;
	
	contrary_phone_1 := 0;
	
	verphn_p := map(
	    nap_summary = 0  => verphn_p_1,
	    nap_summary = 1  => verphn_p_1,
	    nap_summary = 2  => verphn_p_1,
	    nap_summary = 3  => verphn_p_1,
	    nap_summary = 4  => 1,
	    nap_summary = 5  => verphn_p_1,
	    nap_summary = 6  => 1,
	    nap_summary = 7  => 1,
	    nap_summary = 8  => verphn_p_1,
	    nap_summary = 9  => 1,
	    nap_summary = 10 => 1,
	    nap_summary = 11 => 1,
	                        1);
	
	condition2 := if(ssnpop = 1 and verssn_s = 0, 1, 0);
	
	disconnected := if((INTEGER)rc_hriskphoneflag = 5, 1, 0);
	
	condition3 := if((integer)hphnpop = 1 and verphn_p = 0 and disconnected = 1, 1, 0);
	
	pnotpot := if((trim(rc_hphonetypeflag) in ['0', 'Z']), 0, 1);
	
	condition4 := if((integer)hphnpop = 1 and verphn_p = 0 and pnotpot = 1, 1, 0);
	
	phninval := if((INTEGER)rc_phonevalflag = 0, 1, 0);
	
	phninval2_1 := 0;
	
	busphone_flag_1 := 0;
	
	hr_phone_flag_1 := 0;
	
	non_land_phone_flag_1 := 0;
	
	phninval2 := map(
	    rc_hphonevalflag = (string)0 => 1,
	    rc_hphonevalflag = (string)1 => phninval2_1,
	    rc_hphonevalflag = (string)3 => phninval2_1,
	                                    phninval2_1);
	
	hr_phone_flag := map(
	    rc_hphonevalflag = (string)0 => hr_phone_flag_1,
	    rc_hphonevalflag = (string)1 => hr_phone_flag_1,
	    rc_hphonevalflag = (string)3 => 1,
	                                    hr_phone_flag_1);
	
	busphone_flag := map(
	    rc_hphonevalflag = (string)0 => busphone_flag_1,
	    rc_hphonevalflag = (string)1 => 1,
	    rc_hphonevalflag = (string)3 => busphone_flag_1,
	                                    busphone_flag_1);
	
	condition5 := if((integer)hphnpop = 1 and verphn_p = 0 and (phninval = 1 or phninval2 = 1), 1, 0);
	
	condition6 := if((integer)hphnpop = 1 and (hr_phone = 1 or hr_phone_flag = 1 or phn_corrections = 1), 1, 0);
	
	condition7 := if((integer)hphnpop = 1 and verphn_p = 0 and busphone_flag = 1, 1, 0);
	
	phone_zip_mismatch := if((INTEGER)rc_phonezipflag = 1, 1, 0);
	
	condition8 := if((integer)hphnpop = 1 and verphn_p = 0 and phone_zip_mismatch = 1, 1, 0);
	
	condition9 := if((integer)hphnpop = 1 and verphn_p = 1 and phone_zip_mismatch = 1, 1, 0);
	
	condition10 := if(not_deliverable = 1, 1, 0);
	
	city_zip_mismatch := if((INTEGER)rc_cityzipflag = 1, 1, 0);
	
	condition11 := if(city_zip_mismatch = 1, 1, 0);
	
	hirisk_commercial_flag := if((rc_addrcommflag in ['1', '2']), 1, 0);
	
	condition12 := if(add1_hr_address = 1 or hirisk_commercial_flag = 1, 1, 0);
	
	condition13 := if(corrections = 1, 1, 0);
	
	deceased := if((INTEGER)rc_decsflag = 1, 1, 0);
	
	ssnprior_pi := if((INTEGER)rc_ssndobflag = 1, 1, 0);
	
	ssninval_pw := if((rc_pwssnvalflag in ['1', '2', '3']), 1, 0);
	
	aptflag := if(rc_dwelltype = 'A', 1, 0);
	
	condition14 := if(ssnpop = 1 and ((integer)dobpop = 1 and (deceased = 1 or ssn_valid = 0 or ssninval_pw = 1 or ssnprior_pi = 1) or (integer)dobpop = 0 and (deceased = 1 or ssn_valid = 0 or ssninval_pw = 1)), 1, 0);
	
	condition15 := if(ssnpop = 1 and ssns_per_adl_c6 >= 2, 1, 0);
	
	condition16 := if(aptflag = 0 and adls_per_addr >= 25, 1, 0);
	
	condition17 := if(ssnpop = 1 and adlperssn_count >= 6, 1, 0);
	
	condition18 := if(watchlist_hit = 1, 1, 0);
	
	condition19 := if((integer)dobpop = 1 and dob_mismatch_flag = 1, 1, 0);
	
	fp31105_1_0 := map(
	    condition14 = 1																																								=> min(735, mod1_custom1),
	    condition19 = 1																																								=> min(745, mod1_custom1),
	    (condition2 = 1 or condition3 = 1 or condition5 = 1 or condition6 = 1 or condition8 = 1 or
			condition13 = 1 or condition17 = 1) and mod1_custom1 > 840																		=> mod1_custom1 - 50,
	    (condition1 = 1 or condition4 = 1 or condition7 = 1 or condition9 = 1 or condition10 = 1 or
			condition11 = 1 or condition12 = 1 or condition15 = 1 or condition16 = 1 or 
			condition18 = 1) and mod1_custom1 > 925																												=> mod1_custom1 - 30,
																																																			 mod1_custom1
										);
	

	// #warning: Make sure to put the reason code logic here
	nugen := true;
	reasons_temp := riskwise.bdReasonCodesConsumer2( le.bs, le.ip, num_reasons, nugen, criminal );
	
	// If no reason codes are triggered and the score being returned is less than 800, return RC 34 - Per Bug 92594.
	reasons := Models.Common.checkFraudPointRC34(fp31105_1_0, reasons_temp, num_reasons);

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.c_cartheft := c_cartheft;
		SELF.c_famotf18_p := c_famotf18_p;
		SELF.in_dob := in_dob;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.did_count := did_count;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := rc_hphonetypeflag;
		SELF.rc_phonevalflag := rc_phonevalflag;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_phonezipflag := rc_phonezipflag;
		SELF.rc_hriskaddrflag := rc_hriskaddrflag;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssndobflag := rc_ssndobflag;
		SELF.rc_ssnvalflag := rc_ssnvalflag;
		SELF.rc_pwssnvalflag := rc_pwssnvalflag;
		SELF.rc_ssnhighissue := rc_ssnhighissue;
		SELF.rc_addrvalflag := rc_addrvalflag;
		SELF.rc_dwelltype := rc_dwelltype;
		SELF.rc_addrcommflag := rc_addrcommflag;
		SELF.rc_hrisksic := rc_hrisksic;
		SELF.rc_hrisksicphone := rc_hrisksicphone;
		SELF.rc_cityzipflag := rc_cityzipflag;
		SELF.rc_watchlist_flag := rc_watchlist_flag;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_naprop := add1_naprop;
		SELF.add2_isbestmatch := add2_isbestmatch;
		SELF.avg_lres := avg_lres;
		SELF.addrs_prison_history := addrs_prison_history;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.adlperssn_count := adlperssn_count;
		SELF.adls_per_addr := adls_per_addr;
		SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.impulse_count := impulse_count;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_num_aircraft := attr_num_aircraft;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.disposition := disposition;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.felony_count := felony_count;
		SELF.rel_felony_count := rel_felony_count;
		SELF.current_count := current_count;
		SELF.watercraft_count := watercraft_count;
		SELF.ams_college_tier := ams_college_tier;
		SELF.prof_license_flag := prof_license_flag;
		SELF.estimated_income := estimated_income;
		SELF.archive_date := archive_date;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.in_dob2 := in_dob2;
		SELF.years_in_dob := years_in_dob;
		SELF.mth_in_dob := mth_in_dob;
		SELF.years_in_dob1 := years_in_dob1;
		SELF.best_match_level := best_match_level;
		SELF.add1_naprop1 := add1_naprop1;
		SELF.add1_naprop1_m := add1_naprop1_m;
		SELF.avg_lres1 := avg_lres1;
		SELF.avg_lres1_l := avg_lres1_l;
		SELF.adlperssn_count1 := adlperssn_count1;
		SELF.adls_per_addr_c61 := adls_per_addr_c61;
		SELF.adls_per_addr_c61_l := adls_per_addr_c61_l;
		SELF.impulse_flag := impulse_flag;
		SELF.attr_addrs_last241 := attr_addrs_last241;
		SELF.rel_felony_count1 := rel_felony_count1;
		SELF.rel_felony_count1_m := rel_felony_count1_m;
		SELF.current_count1 := current_count1;
		SELF.current_count1_m := current_count1_m;
		SELF.estimated_income_lvl := estimated_income_lvl;
		SELF.estimated_income_lvl_m := estimated_income_lvl_m;
		SELF.bad_behavior := bad_behavior;
		SELF.watercraft_flag := watercraft_flag;
		SELF.good_behavior := good_behavior;
		SELF.good_behavior_l := good_behavior_l;
		SELF.c_cartheft1 := c_cartheft1;
		SELF.c_cartheft1_m := c_cartheft1_m;
		SELF.c_famotf18_p1 := c_famotf18_p1;
		SELF.crime_felony_flag := crime_felony_flag;
		SELF.crime_felony_flag_m := crime_felony_flag_m;
		SELF.attr_eviction_flag := attr_eviction_flag;
		SELF.lien_total := lien_total;
		SELF.derog_level3 := derog_level3;
		SELF.derog_level3_m := derog_level3_m;
		SELF.ssn_combo := ssn_combo;
		SELF.ssn_combo_m := ssn_combo_m;
		SELF.logit := logit;
		SELF.base := base;
		SELF.odds := odds;
		SELF.point := point;
		SELF.phat := phat;
		SELF.fp3710 := fp3710;
		SELF.mod1_custom1 := mod1_custom1;
		SELF.usps_deliverable := usps_deliverable;
		SELF.ssnhighissue_yr := ssnhighissue_yr;
		SELF.dob_yr := dob_yr;
		SELF.dob_mismatch := dob_mismatch;
		SELF.verssn_s := verssn_s;
		SELF.hr_phone := hr_phone;
		SELF.phn_corrections := phn_corrections;
		SELF.not_deliverable := not_deliverable;
		SELF.add1_hr_address := add1_hr_address;
		SELF.corrections := corrections;
		SELF.ssn_valid := ssn_valid;
		SELF.watchlist_hit := watchlist_hit;
		SELF.dob_mismatch_flag := dob_mismatch_flag;
		SELF.ssnpop := ssnpop;
		SELF.nas_ver := nas_ver;
		SELF.condition1 := condition1;
		SELF.verfst_p_1 := verfst_p_1;
		SELF.verlst_p_1 := verlst_p_1;
		SELF.veradd_p_1 := veradd_p_1;
		SELF.verphn_p_1 := verphn_p_1;
		SELF.contrary_phone_1 := contrary_phone_1;
		SELF.verphn_p := verphn_p;
		SELF.condition2 := condition2;
		SELF.disconnected := disconnected;
		SELF.condition3 := condition3;
		SELF.pnotpot := pnotpot;
		SELF.condition4 := condition4;
		SELF.phninval := phninval;
		SELF.phninval2_1 := phninval2_1;
		SELF.busphone_flag_1 := busphone_flag_1;
		SELF.hr_phone_flag_1 := hr_phone_flag_1;
		SELF.non_land_phone_flag_1 := non_land_phone_flag_1;
		SELF.phninval2 := phninval2;
		SELF.hr_phone_flag := hr_phone_flag;
		SELF.busphone_flag := busphone_flag;
		SELF.condition5 := condition5;
		SELF.condition6 := condition6;
		SELF.condition7 := condition7;
		SELF.phone_zip_mismatch := phone_zip_mismatch;
		SELF.condition8 := condition8;
		SELF.condition9 := condition9;
		SELF.condition10 := condition10;
		SELF.city_zip_mismatch := city_zip_mismatch;
		SELF.condition11 := condition11;
		SELF.hirisk_commercial_flag := hirisk_commercial_flag;
		SELF.condition12 := condition12;
		SELF.condition13 := condition13;
		SELF.deceased := deceased;
		SELF.ssnprior_pi := ssnprior_pi;
		SELF.ssninval_pw := ssninval_pw;
		SELF.aptflag := aptflag;
		SELF.condition14 := condition14;
		SELF.condition15 := condition15;
		SELF.condition16 := condition16;
		SELF.condition17 := condition17;
		SELF.condition18 := condition18;
		SELF.condition19 := condition19;
		SELF.fp31105_1_0 := fp31105_1_0;

		SELF.rc1 := reasons[1].hri;
		SELF.rc2 := reasons[2].hri;
		SELF.rc3 := reasons[3].hri;
		SELF.rc4 := reasons[4].hri;
		SELF.rc5 := reasons[5].hri;
		SELF.rc6 := reasons[6].hri;

		SELF.clam := le.bs;
		SELF.ip := le.ip;
	#else
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)fp31105_1_0;
		SELF.seq := le.bs.seq;
	#end
	END;

	model := JOIN(clam, EASI.Key_Easi_Census,
								KEYED(RIGHT.geolink = LEFT.bs.shell_input.st+LEFT.bs.shell_input.county+LEFT.bs.shell_input.geo_blk),
								doModel(LEFT,RIGHT),
								LEFT OUTER);

	RETURN(model);
END;
