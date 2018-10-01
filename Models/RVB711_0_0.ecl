import risk_indicators, ut, riskwise, riskwisefcra, std, riskview;

export RVB711_0_0(
	dataset(Risk_Indicators.Layout_Boca_Shell) clam,
	boolean OFAC,
	boolean isCalifornia
) := FUNCTION


temp := record
	layout_modelout;

#if(Risk_Indicators.iid_constants.validation_debug)
		Risk_Indicators.Layout_Boca_Shell clam;
		real	logit_rvb	;
		real	fpmod711	;
		real	vermod711	;
		real	dist2	;
		real	input_age2	;
		real	dob100_newl	;
		real	Prop_tree_m	;
		real	lres_mod	;
		real	avm1	;
		real	lienCriminalBK_i_l	;
		real	low_issue_age2	;
		
		// vermod fields
		real	contrary_phone	;
		real	stolen_id_ap	;
		real	eda_sourced_level_m	;
		real	source_count_sum_m	;
		real	phone100_m	;
		real	_source_tot_P	;
		real	_source_totfcraNegCap_bestl	;
		real	_source_addrfcraPosCap_bestl	;
		real	_source_addrfcraNegCap_bestl	;
		real	_rc_numelever_bestl	;
		real	_rc_phoneaddr_phonecount	;
		real	_source_totfcraNegCap_notbestl	;
		real	_source_addrfcraPosCap_notbestl	;
		real	_rc_numelever_notbestl	;

#end
	
end;

temp	doModel( clam le ) := TRANSFORM
		out_addr_status                 :=  le.address_validation.error_codes;
		in_dob                          :=  trim(le.shell_input.dob);
		nas_summary                     :=  le.iid.nas_summary;
		nap_summary                     :=  le.iid.nap_summary;
		nap_status                      :=  le.iid.nap_status;
		rc_hriskphoneflag               :=  le.iid.hriskphoneflag;
		rc_phonezipflag                 :=  le.iid.phonezipflag;
		rc_decsflag                     :=  le.ssn_verification.validation.deceased;
		rc_ssndobflag                   :=  (INTEGER)le.iid.socsdobflag;
		rc_pwssndobflag                 :=  le.iid.PWsocsdobflag;
		rc_ssnvalflag                   :=  le.iid.socsvalflag;
		rc_ssnstate                     :=  le.iid.soclstate;
		rc_addrvalflag                  :=  le.iid.addrvalflag;
		rc_hriskaddrflag                :=  le.iid.hriskaddrflag;
		rc_hrisksicphone                :=  le.iid.hrisksicphone;
		combo_ssncount                  :=  le.iid.combo_ssncount;
		combo_ssnscore                  :=  le.iid.combo_ssnscore;
		rc_ssnlowissue                  :=  le.SSN_Verification.Validation.low_issue_date;
		rc_ssnhighissue                 :=  trim(le.iid.soclhighissue);
		rc_dwelltype                    :=  StringLib.StringToUppercase(trim(le.address_validation.dwelling_type));
		rc_sources                      :=  le.iid.sources;
		rc_numelever_in                 :=  le.iid.numelever;
		rc_phoneaddr_phonecount         :=  le.iid.phoneaddr_phonecount;
		rc_hrisksic                     :=  (INTEGER)le.iid.hrisksic;
		rc_disthphoneaddr               :=  le.iid.disthphoneaddr;
		combo_hphonescore               :=  le.iid.combo_hphonescore;
		combo_dobscore                  :=  le.iid.combo_dobscore;
		addr_sources                    :=  StringLib.StringToUppercase(trim(le.Source_Verification.addrsources));
		addrpop                         :=  (integer)le.input_validation.address;
		ssnlength                       :=  le.input_validation.ssn_length;
		dobpop                          :=  (INTEGER)le.input_validation.dateofbirth;
		hphnpop                         :=  (INTEGER)le.input_validation.homephone;
		source_count                    :=  le.name_verification.source_count;
		fname_eda_sourced               :=  le.name_verification.fname_eda_sourced;
		lname_eda_sourced               :=  le.name_verification.lname_eda_sourced;
		add1_isbestmatch                :=  le.address_verification.input_address_information.isbestmatch;
		add1_avm_automated_valuation    :=  le.avm.input_address_information.avm_automated_valuation;
		add1_source_count               :=  le.address_verification.input_address_information.source_count;
		add1_eda_sourced                :=  le.address_verification.input_address_information.eda_sourced;
		add1_occupant_owned             :=  le.address_verification.input_address_information.occupant_owned;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		add1_date_first_seen            :=  (STRING)le.address_verification.input_address_information.date_first_seen;
		property_owned_total            :=  le.address_verification.owned.property_total;
		property_sold_total             :=  le.address_verification.sold.property_total;
		property_ambig_total            :=  le.address_verification.ambiguous.property_total;
		add2_occupant_owned             :=  le.address_verification.address_history_1.occupant_owned;
		add2_naprop                     :=  le.address_verification.address_history_1.naprop;
		add2_date_first_seen            :=  (STRING)le.address_verification.address_history_1.date_first_seen;
		add3_occupant_owned             :=  le.address_verification.address_history_2.occupant_owned;
		add3_naprop                     :=  le.address_verification.address_history_2.naprop;
		add3_date_first_seen            :=  (STRING)le.address_verification.address_history_2.date_first_seen;
		telcordia_type                  :=  le.phone_verification.telcordia_type;
		ssns_per_addr                   :=  le.velocity_counters.ssns_per_addr;
		ssns_per_adl_c6                 :=  le.velocity_counters.ssns_per_adl_created_6months;
		ssns_per_addr_c6                :=  le.velocity_counters.ssns_per_addr_created_6months;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bjl.criminal_count;
		archive_date                    :=  if(le.historydate=999999,(unsigned3)((STRING)Std.Date.Today())[1..6],le.historydate);


		/* HELPERS */
		mymin( a, b ) := MACRO if( (a)<(b), (a), (b) ) ENDMACRO;
		mymax( a, b ) := MACRO if( (a)>(b), (a), (b) ) ENDMACRO;

		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		/***********/



		/************************************************************************************/
		/* Code Starts Here                                                                 */
		/************************************************************************************/

		usps_deliverable := (INTEGER)(rc_addrvalflag='V');
		
		dwelling_type := rc_dwelltype;

		hr_address := (INTEGER)((INTEGER)rc_hriskaddrflag=4);
		add1_hr_address := (INTEGER)((INTEGER)rc_hriskaddrflag=4);

				
		hr_phone := (INTEGER)((INTEGER)rc_hriskphoneflag=6);
		phn_corrections := (INTEGER)((INTEGER)rc_hrisksicphone=2225);

		ssn_score := combo_ssnscore;
		header_count := combo_ssncount;

		ssn_valid := (INTEGER)((INTEGER)rc_ssnvalflag in [0,3] or ((INTEGER)rc_ssnvalflag=2 and (INTEGER)ssnlength=4) );
		ssn_issued := ssn_valid;                              


		high_issue_date := (INTEGER)rc_ssnhighissue;
		issue_state := rc_ssnstate;


		ssnhighissue_yr := map(
			rc_ssnhighissue = '' => -1,
			high_issue_date =  0 => -1,
			(INTEGER)rc_ssnhighissue[1..4]
		); 

		dob_yr := map(
			         in_dob = '' => -1,
			(INTEGER)in_dob =  0 => -1,
			(INTEGER)in_dob[1..4]
		);

		dob_mismatch := map(
			ssnhighissue_yr = -1 or dob_yr = -1   => 0,
			dob_yr > ssnhighissue_yr and dobpop=1 => dob_yr - ssnhighissue_yr,
			0
		);


		/* End of Section to Convert BS20 Fields into BS10 Fields */


		/*********** _avm1 **************/
		apt := (INTEGER)(rc_dwelltype='A');

		_avm1 := map(
			apt=1 or add1_avm_automated_valuation > 2000000 => 70000,
			         add1_avm_automated_valuation =       0 => 110000,
			mymin(250000,add1_avm_automated_valuation)
		);

		/*********** _lienCriminalBK_i_l **************/

		source_addr_BA := contains_i(addr_sources,'BA');
		_source_tot_L2  := contains_i(rc_sources,  'L2');

		liens_unreleased_histor_f := (INTEGER)(liens_historical_unreleased_ct>0 or _source_tot_L2>0);
		liens_unreleased_recent_f := (INTEGER)(liens_recent_unreleased_count  > 0);

		lien_i := if(liens_unreleased_recent_f=1, 2, liens_unreleased_histor_f );
		criminal_flag := (INTEGER)(criminal_count>0);

		liencriminal_i := if(criminal_flag=1, 2, lien_i);
		_lienCriminalBK_i := if( liencriminal_i=0 and source_addr_ba=1, 1, liencriminal_i );

		_lienCriminalBK_i_l := map( 
			_lienCriminalBK_i = 0 => -3.897463069,
			_lienCriminalBK_i = 1 => -3.189568326,
			_lienCriminalBK_i = 2 => -2.704440074,
			-3.835272445
		);
		
		/*********** _rc_numelever_bestl **************/

		_rc_numelever := mymax(3,rc_numelever_in);

		_rc_numelever_bestl := map( 
			_rc_numelever = 3 => -2.822122641,
			_rc_numelever = 4 => -3.007204654,
			_rc_numelever = 5 => -3.670409899,
			_rc_numelever = 6 => -4.26383501,
			_rc_numelever = 7 => -4.298595091,
			-4.039715467
		);

		/*********** _rc_numelever_notbestl **************/

		_rc_numelever_notbestl := map( 
			_rc_numelever = 3 => -2.436897419,
			_rc_numelever = 4 => -2.774448678,
			_rc_numelever = 5 => -3.132952896,
			_rc_numelever = 6 => -3.557230085,
			_rc_numelever = 7 => -3.690508521,
			-3.26001311
		);

		/*********** _rc_phoneaddr_phonecount  **************/

		_rc_phoneaddr_phonecount := (INTEGER)(rc_phoneaddr_phonecount>0);

		/*********** _source_addrfcraNegCap_bestl **************/

		_source_addr_AK := contains_i(addr_sources, 'AK'); 
		_source_addr_BA := contains_i(addr_sources, 'BA'); 
		_source_addr_CO := contains_i(addr_sources, 'CO'); 
		_source_addr_DS := contains_i(addr_sources, 'DS'); 
		_source_addr_FF := contains_i(addr_sources, 'FF'); 
		_source_addr_L2 := contains_i(addr_sources, 'L2'); 
		_source_addr_LI := contains_i(addr_sources, 'LI'); 
		_source_addrfcraNeg := _source_addr_AK+_source_addr_BA+_source_addr_CO+_source_addr_DS+
								_source_addr_FF+_source_addr_L2+_source_addr_LI;
		_source_addrfcraNegCap := mymin(2,_source_addrfcraNeg);


		_source_addrfcraNegCap_bestl := map( 
			_source_addrfcraNegCap = 0 => -4.077515171,
			_source_addrfcraNegCap = 1 => -2.366516623,
			_source_addrfcraNegCap = 2 => -1.722766592,
			-4.039715467
		); 
		/*********** _source_addrfcraPosCap_bestl **************/

		_source_addr_AM := contains_i(addr_sources, 'AM'); 
		_source_addr_AR := contains_i(addr_sources, 'AR'); 
		_source_addr_CG := contains_i(addr_sources, 'CG'); 
		_source_addr_EB := contains_i(addr_sources, 'EB'); 
		_source_addr_EM := contains_i(addr_sources, 'EM'); 
		_source_addr_VO := contains_i(addr_sources, 'VO');
		_source_addr_EM_VO := if(_source_addr_EM=1 or _source_addr_VO=1, 1, 0);
		_source_addr_MW := contains_i(addr_sources, 'MW'); 
		_source_addr_P  := contains_i(addr_sources, 'P ' ); 
		_source_addr_PL := contains_i(addr_sources, 'PL'); 
		_source_addr_W  := contains_i(addr_sources, 'W ' ); 
		_source_addr_WP := contains_i(addr_sources, 'WP'); 
		_source_addrfcraPos :=
			 _source_addr_AM+_source_addr_AR+_source_addr_CG+_source_addr_EB+_source_addr_EM_VO
			+_source_addr_MW+_source_addr_P +_source_addr_PL+_source_addr_W +_source_addr_WP
		;

		_source_addrfcraPosCap := mymin(4,_source_addrfcraPos);

		_source_addrfcraPosCap_bestl := map( 
			_source_addrfcraPosCap = 0 => -3.756456815,
			_source_addrfcraPosCap = 1 => -4.279904916,
			_source_addrfcraPosCap = 2 => -4.817467124,
			_source_addrfcraPosCap = 3 => -4.935672116,
			_source_addrfcraPosCap = 4 => -5.245267956,
		   -4.039715467
		);
		/*********** _source_addrfcraPosCap_notbestl **************/

		_source_addrfcraPosCap_notbestl := map( 
			_source_addrfcraPosCap = 0 => -3.091644867,
			_source_addrfcraPosCap = 1 => -3.762430505,
			_source_addrfcraPosCap = 2 => -4.754915456,
			_source_addrfcraPosCap = 3 => -4.182050077,
			_source_addrfcraPosCap = 4 => -20.72326584,
			-3.26001311
		);

		/*********** _source_tot_P  **************/

		_source_tot_P := contains_i(rc_sources,'P '); 

		/*********** _source_totfcraNegCap_bestl  **************/

		_source_tot_AK := contains_i(rc_sources,'AK'); 
		_source_tot_BA := contains_i(rc_sources,'BA'); 
		_source_tot_CO := contains_i(rc_sources,'CO'); 
		_source_tot_DS := contains_i(rc_sources,'DS'); 
		_source_tot_FF := contains_i(rc_sources,'FF'); 
		_source_tot_LI := contains_i(rc_sources,'LI'); 
		_source_totfcraNeg := _source_tot_AK+_source_tot_BA+_source_tot_CO+_source_tot_DS+
								_source_tot_FF+_source_tot_L2+_source_tot_LI;
		_source_totfcraNegCap := mymin(2,_source_totfcraNeg);

		_source_totfcraNegCap_bestl := map( 
			_source_totfcraNegCap = 0 => -4.113968308,
			_source_totfcraNegCap = 1 => -3.477652292,
			_source_totfcraNegCap = 2 => -3.143193942,
		   -4.039715467
		);

		/*********** _source_totfcraNegCap_notbestl  **************/

		_source_totfcraNegCap_notbestl := map( 
			_source_totfcraNegCap = 0 => -3.294550709,
			_source_totfcraNegCap = 1 => -2.972778513,
			_source_totfcraNegCap = 2 => -2.852631413,
			-3.26001311
		);

		/*********** _velocity_ssns_per_addr_c6_l  **************/

		_velocity_ssns_per_addr_c6 := mymin(4,ssns_per_addr_c6 );

		_velocity_ssns_per_addr_c6_l := map( 
			_velocity_ssns_per_addr_c6 = 0 => -4.002129943,
			_velocity_ssns_per_addr_c6 = 1 => -3.677909311,
			_velocity_ssns_per_addr_c6 = 2 => -3.581865554,
			_velocity_ssns_per_addr_c6 = 3 => -3.290474896,
			_velocity_ssns_per_addr_c6 = 4 => -3.066660571,
		   -3.835272445
		);
		/*********** _velocity_ssns_per_addr_l **************/


		_velocity_ssns_per_addr := map(
			ssns_per_addr  =  0 => 22,
			ssns_per_addr  =  1 => 10,
			ssns_per_addr <=  2 =>  2,
			ssns_per_addr <=  3 =>  3,
			ssns_per_addr <=  4 =>  4,
			ssns_per_addr <=  5 =>  5,
			ssns_per_addr <=  7 =>  7,
			ssns_per_addr <=  8 =>  8,
			ssns_per_addr <= 10 => 10,
			ssns_per_addr <= 13 => 13,
			ssns_per_addr <= 22 => 22,
			23
		);

		_velocity_ssns_per_addr_l := map( 
			_velocity_ssns_per_addr = 2 => -4.693264201,
			_velocity_ssns_per_addr = 3 => -4.537498058,
			_velocity_ssns_per_addr = 4 => -4.348813535,
			_velocity_ssns_per_addr = 5 => -4.15031751,
			_velocity_ssns_per_addr = 7 => -4.112175239,
			_velocity_ssns_per_addr = 8 => -3.932013199,
			_velocity_ssns_per_addr = 10 => -3.82879092,
			_velocity_ssns_per_addr = 13 => -3.598128366,
			_velocity_ssns_per_addr = 22 => -3.409841647,
			_velocity_ssns_per_addr = 23 => -3.127075794,
			-3.835272445
		);

		/*********** _velocity_ssns_per_adl_c6  **************/

		_velocity_ssns_per_adl_c6 := (INTEGER)(ssns_per_adl_c6 > 1);

		/*********** addprob2_m  **************/

		aptflag := (INTEGER)((INTEGER)addrpop=1 and dwelling_type='A');


		error_codes := out_addr_status;
		ec1 := trim(out_addr_status)[1];
		ec3 := trim(out_addr_status)[3];
		ec4 := trim(out_addr_status)[4];

		addr_changed := ((INTEGER)addrpop=1 and ec1='S' and ec3 != '0');
		unit_changed := ((INTEGER)addrpop=1 and ec1='S' and ec4 != '0');

		casserror2 := map(
			error_codes='E412' => 2,
			ec1 = 'E'          => 3,
			ec1 = 'S' and addr_changed and unit_changed => 4,
			ec1 = 'S'                  and unit_changed => 3,
			ec1 = 'S' and addr_changed                  => 1,
			0
		);

		addprob2 := if(casserror2 <= 3 and aptflag=1, 3, casserror2 );

		addprob2_m := map(
			(INTEGER)addrpop = 0 => 0.0419542,
			addprob2 = 0 => 0.0171902,
			addprob2 = 1 => 0.0223955,
			addprob2 = 2 => 0.0269021,
			addprob2 = 3 => 0.0365517,
			0.0419542
		);
		

		/*********** contrary_phone  **************/
		contrary_phone := (INTEGER)(nap_summary=1);

		/*********** dist2  **************/
		distance := (INTEGER)rc_disthphoneaddr;

		dist2 := map(
			distance  = 9999 =>  1,
			distance >=   50 => 50,
			distance
		);

		/*********** dob100_newl  **************/

		dob_score := combo_dobscore;

		dob100 := map(
			dob_score BETWEEN 90 AND 100 => 2,
			dob_score BETWEEN 50 AND  80 => 1,
			0
		);

		dob100_newl := map( 
			dob100 = 0 => -2.94292276,
			dob100 = 1 => -3.604308242,
			dob100 = 2 => -4.007739951,
			-3.835272445
		); 

		/*********** eda_sourced_level_m  **************/

		eda_sourced_level := map(
			add1_isbestmatch and lname_eda_sourced and fname_eda_sourced => 12,
			add1_isbestmatch and lname_eda_sourced                       => 11,
			add1_isbestmatch                                             => 10,
			lname_eda_sourced and fname_eda_sourced and add1_eda_sourced =>  5,
			lname_eda_sourced and                       add1_eda_sourced =>  4,
			lname_eda_sourced and fname_eda_sourced                      =>  3,
			lname_eda_sourced                                            =>  2,
			                      fname_eda_sourced  or add1_eda_sourced =>  1,
			0
		);

		eda_sourced_level_m := map( 
			eda_sourced_level =  0 => 0.0559207,
			eda_sourced_level =  1 => 0.0402225,
			eda_sourced_level =  2 => 0.0376506,
			eda_sourced_level =  3 => 0.0341629,
			eda_sourced_level =  4 => 0.0270453,
			eda_sourced_level =  5 => 0.0194903,
			eda_sourced_level = 10 => 0.0250268,
			eda_sourced_level = 11 => 0.0173961,
			0.0123938
		);

		/*********** input_age2  **************/
		dob_y := if((INTEGER)in_dob != 0, (INTEGER)in_dob[1..4], 0 );
		arcdate := (STRING)archive_date;

		year := (INTEGER)arcdate[1..4];
		input_age := year - dob_y;
		input_age2:= map(
			input_age < 19 => 19,
			input_age > 65 => 65,
			input_age
		);

		/*********** low_issue_age2  **************/
		low_issue_date := (INTEGER)rc_ssnlowissue;
		low_issue_year := (INTEGER)((STRING)low_issue_date)[1..4];

		low_issue_age  := year - low_issue_year;
		low_issue_age2 := map(
			low_issue_age <   3 =>  3,
			low_issue_age > 150 => 18,
			low_issue_age >  40 => 40,
			low_issue_age
		);


		/*********** lres_mod  **************/

		add1_year_first_seen := (INTEGER)( add1_date_first_seen[1..4] );

		yfseen_pop := 1;
		lres_years := ( year - add1_year_first_seen );

		if lres_years > 1000 then
			lres_years := -1;
			yfseen_pop := 0;
		elseif lres_years > 30 then
			lres_years := 30;
		end;
		
		firstseendate := trim(add1_date_first_seen)[1..4];
		firstseendate1 := if( (INTEGER)firstseendate=0, 10000, (INTEGER)firstseendate);

		yfseen_pop1 := 1;
		lres_years1 := abs(year - firstseendate1);
		if lres_years1 > 1000 then
			lres_years1 := -1;
			yfseen_pop1 := 0;
		elseif lres_years1 > 100 then
			lres_years1 := 100;
		end;


		secondseendate := trim(add2_date_first_seen)[1..4];
		secondseendate2 := (INTEGER)secondseendate;

		yfseen_pop2 := 1;
		lres_years2 := abs(firstseendate1 - secondseendate2);

		if lres_years2 > 1000 then
			lres_years2 := -1;
			yfseen_pop2 := 0;
		elseif lres_years2 > 100 then
			lres_years2 := 100;
		end;

		thirdseendate := trim(add3_date_first_seen)[1..4];
		thirdseendate3 := (INTEGER)thirdseendate;

		yfseen_pop3 := 1;
		lres_years3 := abs(secondseendate2 - thirdseendate3);
		if lres_years3 > 1000 then
			lres_years3 := -1;
			yfseen_pop3 := 0;
		elseif lres_years3 > 100 then
			lres_years3 := 100;
		end;

		lres_sum :=
			 if(lres_years1=-1,0,lres_years1)
			+if(lres_years2=-1,0,lres_years2)
			+if(lres_years3=-1,0,lres_years3)
		;
		
		lres_denom  :=
			 (INTEGER)(lres_years1>=0)
			+(INTEGER)(lres_years2>=0)
			+(INTEGER)(lres_years3>=0)
		;
		avglres := if(lres_denom=0, -1, lres_sum/lres_denom);
		lres_avg := if( avglres = -1, -1, mymin( 12, avglres ));		

		yfseen_tree := map(
			yfseen_pop1=1 and yfseen_pop2=1 and yfseen_pop3=1 => 4,
			yfseen_pop1=1 and yfseen_pop2=0 and yfseen_pop3=0 => 4,
			yfseen_pop1=1 and yfseen_pop2=1                   => 3,
			yfseen_pop1=1                   and yfseen_pop3=1 => 2,
			yfseen_pop1=1                                     => 2,
			yfseen_pop1=0 and yfseen_pop2=0 and yfseen_pop3=0 => 0,
			1
		);

		lres_mod_a := -2.611547975
			+ lres_years  * -0.028981724
			+ lres_avg  * -0.076266436
			+ yfseen_tree  * -0.225844915
		;
		lres_mod_b := (exp(lres_mod_a)) / (1+exp(lres_mod_a));
		lres_mod := round(100 * lres_mod_b *10000)/10000;

		/*********** not_connected  **************/
		disconnected := (integer)((INTEGER)rc_hriskphoneflag=5);
		phone_zip_mismatch := (integer)((INTEGER)rc_phonezipflag=1);



		if hphnpop = 1 then
			phone_zip_mismatch_n := (INTEGER)phone_zip_mismatch;

			pnotpots := (INTEGER)(telcordia_type not in ['00','50','51','52','54']);
			not_connected := 1-(INTEGER)(nap_status='C' and disconnected=0);
		else
			phone_zip_mismatch_n := 0;
			pnotpots := 0;
			not_connected := 1;
		end;

		/*********** phone100_m  **************/

		phone_score := combo_hphonescore;
		phone100 := map(
			phone_score between 90 and 100 => 2,
			phone_score between 50 and  89 => 1,
			phone_score = 255              => 1,
			0
		);
		
		phone100_m := map(
			phone100 = 0 => 0.0467730239,
			phone100 = 1 => 0.0223746269,
			0.0141329951
		);

		/*********** Prop_tree_m  **************/
		property_owned_total_x := (INTEGER)(property_owned_total > 0 );
		property_sold_total_x  := (INTEGER)(property_sold_total > 0 );
		property_ambig_total_x := (INTEGER)(property_ambig_total > 0 );

		property_total_x := (property_owned_total_x+property_sold_total_x+property_ambig_total_x);

		prop_owner := map(
			4 in [add1_naprop,add2_naprop,add3_naprop] => 2,
			property_total_x > 0 => 1,
			0
		);

		prop_occupant_owner := (INTEGER)( add1_occupant_owned or add2_occupant_owned or add3_occupant_owned );

		Prop_tree := map( 
			Prop_Owner = 2 and Add1_Naprop = 4 => 3,
			Prop_Owner = 2 and Prop_occupant_Owner=1 => 2,
			Prop_Owner = 2 => 2,
			Prop_Owner = 1 => 2,
			Prop_Owner = 0 and Prop_occupant_Owner=1 => 1,
			Prop_Owner = 0 and Add1_Naprop >= 4 => 1,
			0
		);
		Prop_tree_m := map( 
			Prop_tree = 0 => 0.0329127,
			Prop_tree = 1 => 0.0268725,
			Prop_tree = 2 => 0.0226849,
			0.0101392
		);

		/*********** source_count_sum_m  **************/  

		 source_count2 := map(
			source_count > 4 => 4,
			source_count < 1 => 1,
			source_count
		);
	 
	 
		add1_source_count2 := map(
			add1_source_count > 6 => 6,
			add1_source_count < 1 => 1,
			add1_source_count
		);

		source_count_sum := if( (source_count2 + add1_source_count2) > 7, 7, source_count2 + add1_source_count2);

		if add1_isbestmatch then

			source_count2_m := map( 
				source_count2 = 1 => 0.026753171,
				source_count2 = 2 => 0.0158011669,
				source_count2 = 3 => 0.0118146016,
				0.0104448382
			);

			source_count_sum_m := map( 
				source_count_sum = 2 => 0,
				source_count_sum = 3 => 0.0272600186,
				source_count_sum = 4 => 0.0197140198,
				source_count_sum = 5 => 0.0151398,
				source_count_sum = 6 => 0.0134554289,
				0.0102030405
			); 

		else
			source_count_sum_m := -1;

			source_count2_m := map( 
				source_count2 = 1 => 0.0498369429,
				source_count2 = 2 => 0.0352613672,
				source_count2 = 3 => 0.0297385062,
				0.0215895611
			);
		end;

		/*********** ssnprob  **************/

		ssnpop := (INTEGER)((INTEGER)ssnlength>0);
		deceased := (INTEGER)((INTEGER)rc_decsflag=1);

		if ssnpop = 1 then
			ssninval := (INTEGER)(ssn_valid=0);
			ssndead := (INTEGER)deceased;

			high_issue_dateyr := (INTEGER)(high_issue_date/10000);
			dob_year := if((INTEGER)in_dob != 0, (INTEGER)in_dob[1..4], 0 );

			year_diff := high_issue_dateyr - dob_year;

			ssnprior := (INTEGER)( high_issue_dateyr > 0 and dob_year > 0 and year_diff between -100 and 2);
			ssnprob := (INTEGER)(ssninval=1 or ssndead=1 or ssnprior=1);
		else
			year_diff := -1;
			dob_year  := -1;
			high_issue_dateyr := -1;
			
			
			ssninval := 0;
			ssndead  := 0;
			ssnprob  := 0;
			ssnprior := 0;
		end;

		/*********** stolen_id_ap  **************/
		stolen_id_ap := (INTEGER)(nap_summary=6);



		/*** updated vermod ***/

		if add1_isbestmatch then

			phone100_m := map( 
				phone100 = 0 => 0.0467730239,
				phone100 = 1 => 0.0223746269,
				0.0141329951
			);

			logit_ver := 4.1164784768
				+ contrary_phone  * 0.6104395607
				+ stolen_id_ap  * 0.5274190056
				+ eda_sourced_level_m  * 15.616282529
				+ source_count_sum_m  * 9.5102291571
				+ phone100_m  * 25.038426801
				+ _source_tot_P  * -0.828707388
				+ _source_totfcraNegCap_bestl  * 0.7287342136
				+ _source_addrfcraPosCap_bestl  * 0.2048255809
				+ _source_addrfcraNegCap_bestl  * 0.7934298059
				+ _rc_numelever_bestl  * 0.4072886902
				+ _rc_phoneaddr_phonecount  * -0.196424183
			;
		else
			phone100_m := map( 
				phone100 = 0 => 0.0638722555,
				phone100 = 1 => 0.0450583543,
				0.0307844507
			);

			logit_ver := 2.7595822355
				+ contrary_phone  * 0.6796812538
				+ stolen_id_ap  * 0.3813480002
				+ eda_sourced_level_m  * 9.9805158067
				+ phone100_m  * 22.086748914
				+ _source_tot_P  * -0.486932695
				+ _source_totfcraNegCap_notbestl  * 1.3387613746
				+ _source_addrfcraPosCap_notbestl  * 0.4583893635
				+ _rc_numelever_notbestl  * 0.3935359315
			;
		end;
		phat_ver := (exp(logit_ver )) / (1+exp(logit_ver ));

		vermod711 := round((100 * phat_ver )/0.000001)*0.000001;


		/*** updated fpmod ***/
		fpmod711_a := 0.5088991582
			+ addprob2_m  * 21.482774605
			+ phone_zip_mismatch_n  * 0.7199921057
			+ pnotpots  * 0.4274487271
			+ not_connected  * 0.3441680341
			+ ssnprob  * 0.5718703218
			+ _velocity_ssns_per_addr_l  * 0.6690421688
			+ _velocity_ssns_per_adl_c6  * 0.5842196004
			+ _velocity_ssns_per_addr_c6_l  * 0.6507761329
		;
		fpmod711_b := (exp(fpmod711_a)) / (1+exp(fpmod711_a));

		fpmod711 := round((100 * fpmod711_b)/0.000001)*0.000001;
     

		/*** final mod ***/
		logit_rvb := if( dobpop=1,
			-0.122070727
				+ fpmod711  * 0.0887165909
				+ vermod711  * 0.1326703316
				+ dist2  * 0.0123461067
				+ input_age2  * -0.01655749
				+ dob100_newl  * 0.3015842838
				+ Prop_tree_m  * 17.468345831
				+ lres_mod  * 0.0631781028
				+ _avm1  * -1.65858E-6
				+ _lienCriminalBK_i_l  * 0.7397794698,
			-2.020382015
				+ fpmod711  * 0.1031568844
				+ vermod711  * 0.1373703907
				+ dist2  * 0.0123484346
				+ low_issue_age2  * -0.016251868
				+ Prop_tree_m  * 19.173803233
				+ lres_mod  * 0.0966718565
				+ _avm1  * -1.369482E-6
				+ _lienCriminalBK_i_l  * 0.6650145988
		);
		phat_rvb := (exp(logit_rvb )) / (1+exp(logit_rvb ));
		rvbMod7 := round(-40*(log(phat_rvb/(1-phat_rvb)) - log(1/21))/log(2) + 703); 
          
		RVB711_0_0_a := mymin(900,mymax(501,rvbMod7));

		/* override */
		ssndead_override  := ((INTEGER)ssnlength>0) and ((INTEGER)rc_decsflag=1);
		ssnprior_override := ((INTEGER)rc_ssndobflag=1 or (INTEGER)rc_pwssndobflag=1);
		corrections       := (rc_hrisksic=2225);

		rvb711_0 := map(
			RVB711_0_0_a >785 and (ssndead_override or ssnprior_override or criminal_flag=1 or corrections ) 	=> 785,
			riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid)                			=> 222,
			rvb711_0_0_a
		);

		// self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		
		// self.score := (STRING3)rvb711_0;

		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		inCalif := isCalifornia and (
			(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
			+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
			+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			rvb711_0 = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),		
			RiskWise.rvReasonCodes(le, 4, inCalif, true)
		);
		
	
		self.score := map
		(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			self.ri[1].hri='35' => '000',
			(string3)rvb711_0
		);


		self.seq := le.seq;

#if(Risk_Indicators.iid_constants.validation_debug)	
		self.clam := le;
		self.logit_rvb	:= 	logit_rvb	;
		self.fpmod711	:= 	fpmod711	;
		self.vermod711	:= 	vermod711	;
		self.dist2	:= 	dist2	;
		self.input_age2	:= 	input_age2	;
		self.dob100_newl	:= 	dob100_newl	;
		self.Prop_tree_m	:= 	Prop_tree_m	;
		self.lres_mod	:= 	lres_mod	;
		self.avm1	:= 	_avm1	;
		self.lienCriminalBK_i_l	:= 	_lienCriminalBK_i_l	;
		self.low_issue_age2	:= 	low_issue_age2	;
		
		// vermod fields
		self.contrary_phone	:= 	contrary_phone	;
		self.stolen_id_ap	:= 	stolen_id_ap	;
		self.eda_sourced_level_m	:= 	eda_sourced_level_m	;
		self.source_count_sum_m	:= 	source_count_sum_m	;
		self.phone100_m	:= 	phone100_m	;
		self._source_tot_P	:= 	_source_tot_P	;
		self._source_totfcraNegCap_bestl	:= 	_source_totfcraNegCap_bestl	;
		self._source_addrfcraPosCap_bestl	:= 	_source_addrfcraPosCap_bestl	;
		self._source_addrfcraNegCap_bestl	:= 	_source_addrfcraNegCap_bestl	;
		self._rc_numelever_bestl	:= 	_rc_numelever_bestl	;
		self._rc_phoneaddr_phonecount	:= 	_rc_phoneaddr_phonecount	;
		self._source_totfcraNegCap_notbestl	:= 	_source_totfcraNegCap_notbestl	;
		self._source_addrfcraPosCap_notbestl	:= 	_source_addrfcraPosCap_notbestl	;
		self._rc_numelever_notbestl	:= 	_rc_numelever_notbestl	;

#end

		self := [];
	END;

	final := project( clam, doModel(LEFT) );
	
	RETURN (final);
END;