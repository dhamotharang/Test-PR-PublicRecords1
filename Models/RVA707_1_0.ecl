import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std, riskview;

export RVA707_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION

	Layout_ModelOut_ivars := record
		Layout_ModelOut;
		dataset(Models.Layout_Score) ivars;
	END;

	Layout_ModelOut_ivars doModel( clam le ) := TRANSFORM

		// variables
			in_dob                         := le.shell_input.dob;
			nas_summary                    := le.iid.nas_summary;
			nap_summary                    := le.iid.nap_summary;
			combo_dobscore                 := le.iid.combo_dobscore;
						   
		/*Phone Verification*/			
			telcordia_type                 := le.phone_verification.telcordia_type;
			rc_phonezipflag                := le.iid.phonezipflag;
			rc_hrisksicphone               := le.iid.hrisksicphone;
			rc_hriskphoneflag              := le.iid.hriskphoneflag;
			rc_disthphoneaddr              := le.iid.disthphoneaddr;
										   
			
		/*Address Validation/Verification*/			
			add1_isbestmatch               := le.address_verification.input_address_information.isbestmatch;
			add2_isbestmatch               := le.address_verification.address_history_1.isbestmatch;

			addrs_5yr                      := le.other_address_info.addrs_last_5years;
			addrs_15yr                     := le.other_address_info.addrs_last_15years;
					  
				
		/*Property Ownership*/			
			property_owned_total           := le.address_verification.owned.property_total;


		/*Professional Licence Factors*/
			prof_license_flag              := (INTEGER)le.professional_license.professional_license_flag;

		/*SSN Factors*/
			low_issue_date                 := le.ssn_verification.validation.low_issue_date;

		/*Source Factors*/
			rc_sources                     := le.iid.sources;
			PR_count                       := le.source_verification.pr_count;

		
		/*Velocity Factors*/			
			ssns_per_adl                   := le.velocity_counters.ssns_per_adl;
			ssns_per_addr                  := le.velocity_counters.ssns_per_addr;
			phones_per_adl_c6              := le.velocity_counters.phones_per_adl_created_6months;
			ssns_per_addr_c6               := le.velocity_counters.ssns_per_addr_created_6months;
			phones_per_addr_c6             := le.velocity_counters.phones_per_addr_created_6months;
			phones_per_addr                := le.velocity_counters.phones_per_addr;


		/*Bankruptcy/Derogatory Public Records*/			
			bankrupt                       := le.bjl.bankrupt;
			disposition                    := le.bjl.disposition;
			filing_count                   := le.bjl.filing_count;
			liens_recent_unreleased_count  := le.bjl.liens_recent_unreleased_count;
			liens_historical_unreleased_ct := le.bjl.liens_historical_unreleased_count;

			rc_decsflag                    := le.ssn_verification.validation.deceased;
			rc_ssndobflag                  := (INTEGER)le.iid.socsdobflag;
			rc_hrisksic                    := (INTEGER)le.iid.hrisksic;
			add1_naprop                    := le.address_verification.input_address_information.naprop;
			criminal_count                 := le.bjl.criminal_count;


	 /***********************************************************************************
	 * CODE STARTS HERE                                                                 *
	 ************************************************************************************/
		// helpers
		mymax( a, b ) := MACRO if( a > b, a, b ) ENDMACRO;
		mymin( a, b ) := MACRO if( a < b, a, b ) ENDMACRO;
		
		// today := if(history_date <> 999999, (integer)((string)history_date[1..4]), (integer)(ut.GetDate[1..4]));
		today := if(le.historydate <> 999999, ((string)le.historydate)[1..6] + '01', (STRING)Std.Date.Today());


		isbestmatch := map
		(
			not add1_isbestmatch and not add2_isbestmatch => 0,
			not add1_isbestmatch and     add2_isbestmatch => 1,
			2
		);

		nas_summary2 := map
		(
			nas_summary = 0 => 0,
			nas_summary = 1 => 1,
			nas_summary between 2 and 8 => 2,
			nas_summary between 9 and 11=> 3,
			4
		);

		nap_summary2 := map
		(
			nap_summary in [0,2] => 0,
			nap_summary = 1 => 1,
			nap_summary between 3 and 8 => 2,
			nap_summary between 9 and 11=> 3,
			4
		);


		verx := map
		(
			nas_summary2 = 0 and nap_summary2 <= 2     => 0,
			nas_summary2 < 4 and nap_summary2  = 1     => 1,
			nas_summary2 = 1 and nap_summary2 <= 3     => 1,
			nas_summary2 < 4 and nap_summary2 in [0,2] => 2,
			nas_summary2 < 4 and nap_summary2  = 3     => 3,
			nas_summary2 = 4 and nap_summary2  = 1     => 4,
			nas_summary2 < 4 and nap_summary2  = 4     => 5,
			nas_summary2 = 4 and nap_summary2 in [0,2] => 6,
			nas_summary2 = 4 and nap_summary2  = 3     => 7,
			8
		);

		verx2 := map
		(
			verx <= 5                     => verx,
			verx <  8 and isbestmatch < 2 => 5,
			verx =  8 and isbestmatch < 2 => 6,
			verx =  6 and isbestmatch = 2 => 7,
			verx =  7 and isbestmatch = 2 => 8,
			9
		);

		verx2_m := case( verx2,
			0 => 42.41,
			1 => 36.63,
			2 => 35.12,
			3 => 33.87,
			4 => 32.66,
			5 => 32.06,
			6 => 29.70,
			7 => 28.38,
			8 => 25.73,
			22.56
			// 9 => 22.56;
		);


		today1900 := ut.DaysSince1900( today[1..4], today[5..6], today[7..8] );
		birth1900 := ut.DaysSince1900( in_dob[1..4], in_dob[5..6], in_dob[7..8] );
		li1900    := ut.DaysSince1900( ((STRING)low_issue_date)[1..4], ((STRING)low_issue_date)[5..6], ((STRING)low_issue_date)[7..8] );
		
		age_calc := map
		(
			(INTEGER)in_dob = 0 and (INTEGER)low_issue_date != 0 => (INTEGER)((today1900 - li1900)/365.25),
			(INTEGER)in_dob = 0                                  => -1,
			(INTEGER)((today1900 - birth1900)/365.25)
		);

		age_calc2 := mymax(mymin(age_calc,65),20);

		combo_dobscore_100 := (INTEGER)(combo_dobscore = 100);



		dob_sas_undef := (INTEGER)in_dob = 0; // for sas: dob_sas = .
		age_low_issue_date := if( dob_sas_undef OR low_issue_date = 0 OR ((string)low_issue_date)[1..4]=in_dob[1..4], -1, (INTEGER)((li1900 - birth1900)/365.25) );
		age_low_issue_date2 := if( age_low_issue_date < 0, 18, mymin(age_low_issue_date,35) );

		rc_disthphoneaddr_0 := (rc_disthphoneaddr > 0);

		phone_zip_mismatch2 := ((INTEGER)rc_phonezipflag = 1);
		phn_corrections2    := ((INTEGER)rc_hrisksicphone = 2225);
		hr_phone2           := ((INTEGER)rc_hriskphoneflag = 6);

		badphone := (phone_zip_mismatch2 or phn_corrections2 or hr_phone2);

		phone_summary_m := map
		(
			badphone => 33.09,
			telcordia_type in ['04','65'] => 32.48,
			telcordia_type != '00'        => 30.89,
			telcordia_type = '00' and rc_disthphoneaddr_0 => 29.44, // why need the first condition here? the previous map clause should cover it
			28.23
		);


		property_owned_ind := mymin(property_owned_total,1) > 0;

		liens_unreleased_prop_m := map
		(
			property_owned_ind and liens_recent_unreleased_count = 0 and liens_historical_unreleased_ct = 0 => 21.05,
			property_owned_ind => 26.77,
			liens_recent_unreleased_count = 0 and liens_historical_unreleased_ct = 0 => 29.37,
			liens_recent_unreleased_count = 0 and liens_historical_unreleased_ct between 1 and 3 => 32.18,
			(liens_recent_unreleased_count = 0 and liens_historical_unreleased_ct > 3) or liens_recent_unreleased_count = 1 => 35.48,
			liens_recent_unreleased_count = 2 => 38.42,
			liens_recent_unreleased_count = 3 => 40.86,
			42.27
			// liens_recent_unreleased_count >= 4 => 42.27
		);


		bk_discharged := stringlib.stringtouppercase( disposition[1..5] ) = 'DISCH';

		bk_summary_m := map
		(
			not bankrupt                           => 31.01,
			filing_count > 1 and not bk_discharged => 28.25,
			filing_count = 1                       => 26.53,
			24.75
		);


		ssns_per_adl2a := mymin(ssns_per_adl,5);
		ssns_per_adl2  := if( ssns_per_adl2a = 0, 4, ssns_per_adl2a );

		ssns_per_addr2 := mymin(ssns_per_addr,35);

		phones_per_adl_c6_2 := mymin(phones_per_adl_c6,2);

		ssns_per_addr_c6_2 := mymin(ssns_per_addr_c6,4);

		phones_per_addr_summary_m := map
		(
			phones_per_addr_c6 = 0 => 29.12,
			phones_per_addr   <= 5 => 34.02,
			phones_per_addr   <= 10=> 32.14,
			29.12
		);


	/****************************/
		// implementation of a string contains function since StringLib.StringContains doesn't give expected results
		boolean contains( string src, string pat ) := stringlib.stringfind( src, pat, 1 ) != 0;

		source_AK_tot    := (INTEGER)contains( rc_sources, 'AK,' );
		source_AM_tot    := (INTEGER)contains( rc_sources, 'AM,' );
		source_AR_tot    := (INTEGER)contains( rc_sources, 'AR,' );
		source_BA_tot    := (INTEGER)contains( rc_sources, 'BA,' );
		source_CG_tot    := (INTEGER)contains( rc_sources, 'CG,' );
		source_D_tot     := (INTEGER)contains( rc_sources, 'D ,' );
		source_DA_tot    := (INTEGER)contains( rc_sources, 'DA,' );
		source_DS_tot    := (INTEGER)contains( rc_sources, 'DS,' );
		source_EB_tot    := (INTEGER)contains( rc_sources, 'EB,' );
		source_EM_tot    := (INTEGER)contains( rc_sources, 'EM,' );
		source_VO_tot    := (INTEGER)contains( rc_sources, 'VO,' );
		source_EM_VO_tot := if(source_EM_tot=1 or source_VO_tot=1, 1, 0);
		source_EQ_tot    := (INTEGER)contains( rc_sources, 'EQ,' );
		source_FF_tot    := (INTEGER)contains( rc_sources, 'FF,' );
		source_FR_tot    := (INTEGER)contains( rc_sources, 'FR,' );
		source_L2_tot    := (INTEGER)contains( rc_sources, 'L2,' );
		source_LI_tot    := (INTEGER)contains( rc_sources, 'LI,' );
		source_MW_tot    := (INTEGER)contains( rc_sources, 'MW,' );
		source_P_tot     := (INTEGER)contains( rc_sources, 'P ,' );
		source_PL_tot    := (INTEGER)contains( rc_sources, 'PL,' );
		source_TU_tot    := (INTEGER)contains( rc_sources, 'TU,' );
		source_V_tot     := (INTEGER)contains( rc_sources, 'V ,' );
		source_W_tot     := (INTEGER)contains( rc_sources, 'W ,' );
		source_WP_tot    := (INTEGER)contains( rc_sources, 'WP,' );
		source_other_tot := (INTEGER)contains( rc_sources, 'other,' );


		num_pos_sources_NOEQ_tot_fcra :=
			  source_AM_tot
			+ source_AR_tot
			+ source_CG_tot
			+ source_EB_tot
			+ source_EM_VO_tot
			+ source_MW_tot
			+ source_P_tot
			+ source_PL_tot
			+ source_V_tot
			+ source_W_tot
			+ source_WP_tot;


		num_pos_sources_NOEQ_tot_fcra2	:= mymin(num_pos_sources_NOEQ_tot_fcra,5);

		PR_count2  := mymin( PR_count,   5 );
		addrs_5yr2 := mymin( addrs_5yr,  8 );
		addrs_15yr2:= mymin( addrs_15yr, 15);


		outesta := -5.27609251
			+ verx2_m  * 0.0347043478
			+ age_calc2  * -0.007268344
			+ age_low_issue_date2  * -0.015083348
			+ combo_dobscore_100  * -0.078958635
			+ phone_summary_m  * 0.0146177231
			+ liens_unreleased_prop_m  * 0.0359796555
			+ bk_summary_m  * 0.0352319456
			+ prof_license_flag  * -0.163610462
			+ ssns_per_adl2  * 0.1007712363
			+ ssns_per_addr2  * 0.0041285429
			+ phones_per_adl_c6_2  * 0.1456760735
			+ ssns_per_addr_c6_2  * 0.0335380891
			+ phones_per_addr_summary_m  * 0.031409264
			+ num_pos_sources_NOEQ_tot_fcra2  * -0.080140035
			+ PR_count2  * -0.027910038
			+ addrs_5yr2  * 0.0434474522
			+ addrs_15yr2  * 0.0196406792
		 ;
		 outest := (exp(outesta )) / (1+exp(outesta ));

		base  := 703;
		odds  := 1/21;
		point := -40;

		phat := outest;
		rva707_1_0a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
		rva707_1_0b := mymin(rva707_1_0a, 900);
		rva707_1_0c := mymax(rva707_1_0b, 501);

		ssndead     := rc_decsflag;
		ssnprior    := (rc_ssndobflag = 1);
		corrections := (rc_hrisksic = 2225);

		rva707_1_0 := map
		(
			ssndead     and rva707_1_0c > 560 => 560,
			corrections and rva707_1_0c > 560 => 560,
			riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) and rva707_1_0c > 620 => 620, // 222 override is replaced with a 620 cap
			ssnprior    and rva707_1_0c > 620 => 620,
			criminal_count > 0 and rva707_1_0c > 610 => 610,
			rva707_1_0c
		);

		// reason codes
		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			RiskWise.rvReasonCodes(le, 4, inCalif)
		);

		self.score := map
		(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			le.rhode_island_insufficient_verification => '222',
			self.ri[1].hri='35' => '000',
			intformat(rva707_1_0,3,1)
		);

		self.seq := le.seq;

		self.ivars := dataset( [
			{verx2_m,                        'AutoRVA7071_IV01', '-1', [] },
			{age_calc2,                      'AutoRVA7071_IV02', '-1', [] },
			{age_low_issue_date2,            'AutoRVA7071_IV03', '-1', [] },
			{combo_dobscore_100,             'AutoRVA7071_IV04', '-1', [] },
			{phone_summary_m,                'AutoRVA7071_IV05', '-1', [] },
			{liens_unreleased_prop_m,        'AutoRVA7071_IV06', '-1', [] },
			{bk_summary_m,                   'AutoRVA7071_IV07', '-1', [] },
			{prof_license_flag,              'AutoRVA7071_IV08', '-1', [] },
			{ssns_per_adl2,                  'AutoRVA7071_IV09', '-1', [] },
			{ssns_per_addr2,                 'AutoRVA7071_IV10', '-1', [] },
			{phones_per_adl_c6_2,            'AutoRVA7071_IV11', '-1', [] },
			{ssns_per_addr_c6_2,             'AutoRVA7071_IV12', '-1', [] },
			{phones_per_addr_summary_m,      'AutoRVA7071_IV13', '-1', [] },
			{num_pos_sources_NOEQ_tot_fcra2, 'AutoRVA7071_IV14', '-1', [] },
			{PR_count2,                      'AutoRVA7071_IV15', '-1', [] },
			{addrs_5yr2,                     'AutoRVA7071_IV16', '-1', [] },
			{addrs_15yr2,                    'AutoRVA7071_IV17', '-1', [] }
			], Models.Layout_Score
		);


	END;
	
	final := project(clam, doModel(left));

	RETURN (final);
END;