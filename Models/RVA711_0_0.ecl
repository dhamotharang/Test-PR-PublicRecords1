import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, std, riskview;

export RVA711_0_0(
	grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam,
	boolean isCalifornia
) := FUNCTION

temp := record
	layout_modelout;
	
	#if(Risk_Indicators.iid_constants.validation_debug)
		Risk_Indicators.Layout_Boca_Shell clam;
		
		real	ModRVA8_vermod	;
		real	ModRVA8_fpmod	;
		
		real	lienCriminal_i_l	;
		real	add1_avm_med_fips_ratio2	;
		real	pr_count_l	;
		real	property_owned_purchase_f	;
		real	ssn_seen_years_i_l	;
		real	addr_stability_l	;
		
		// vermod best fields
		real	contrary_phone	;
		real	source_count_sum_pk_m	;
		real	ver_p_level_m	;
		real	source_addrfcraNegCap	;
		real	source_lnamefcraNegCap_bl	;
		real	source_addr_W	;
		real	bk_4_m	;
		
		// vermodnotbest
		real	add_score100	;
		real	source_lnamefcraNegCap_nbl	;
		real	source_addrfcraPos_compCap_nbl	;
		real	source_ssnfcraPos_compCap_nbl	;
		real	source_ssnfcraNegCap_nbl	;
		real	source_tot_WP	;

		
		// fpmod fields
		real	addprob_m	;
		real	phone_zip_mismatch_n	;
		real	pnotpots	;
		real	not_connected	;
		real	ssnprob	;
		real	ssns_per_adl_l	;
		real	adlperssn_count_l	;
		real	person_per_addr2_l	;
		real	ssns_per_adl_c6_l	;
		real	ssns_per_addr_c6_l	;
		real	phones_per_addr_c6_l	;
		real	phone_highRisk	;
		
		integer casserr_pk;
		integer zippobox;
		integer addprob;
		
	#end
end;


	temp doModel( clam le ) := TRANSFORM

		out_addr_status                 :=  le.address_validation.error_codes;
		in_dob                          :=  le.shell_input.dob;
		nas_summary                     :=  le.iid.nas_summary;
		nap_summary                     :=  le.iid.nap_summary;
		nap_status                      :=  le.iid.nap_status;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		rc_hriskphoneflag               :=  le.iid.hriskphoneflag;
		rc_phonezipflag                 :=  le.iid.phonezipflag;
		rc_decsflag                     :=  le.ssn_verification.validation.deceased;
		rc_ssnvalflag                   :=  le.iid.socsvalflag;
		rc_ssndobflag                   :=  le.iid.socsdobflag;
		rc_pwssndobflag                 :=  le.iid.pwsocsdobflag;
		rc_ssnhighissue                 :=  le.iid.soclhighissue;
		rc_hrisksic                     :=  le.iid.hrisksic;
		rc_dwelltype                    :=  trim(le.address_validation.dwelling_type);
		rc_sources                      :=  le.iid.sources;
		PR_count_in                     :=  le.source_verification.pr_count;
		rc_ziptypeflag                  :=  (INTEGER)le.address_validation.zip_type;
		lname_sources                   :=  StringLib.StringToUppercase(trim(le.Source_Verification.lastnamesources));
		addr_sources                    :=  StringLib.StringToUppercase(trim(le.Source_Verification.addrsources));
		ssn_sources                     :=  StringLib.StringToUppercase(trim(le.Source_Verification.socssources));
		addrpop                         :=  (integer)le.input_validation.address;
		ssnlength                       :=  le.input_validation.ssn_length;
		hphnpop                         :=  (INTEGER)le.input_validation.homephone;
		source_count                    :=  le.name_verification.source_count;
		add1_address_score              :=  le.address_verification.input_address_information.address_score;
		add1_isbestmatch                :=  le.address_verification.input_address_information.isbestmatch;
		add1_avm_automated_valuation    :=  le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips               :=  le.avm.input_address_information.avm_median_fips_level;
		add1_source_count               :=  le.address_verification.input_address_information.source_count;
		add1_credit_sourced             :=  le.address_verification.input_address_information.credit_sourced;
		add1_eda_sourced                :=  le.address_verification.input_address_information.eda_sourced;
		credit_first_seen               :=  le.ssn_verification.credit_first_seen;
		header_first_seen               :=  le.ssn_verification.header_first_seen;
		
		property_owned_purchase_count   :=  le.address_verification.owned.property_owned_purchase_count;
		telcordia_type                  :=  le.phone_verification.telcordia_type;
		credit_sourced                  :=  (INTEGER)le.ssn_verification.credit_sourced;
		ssns_per_adl_in                 :=  le.velocity_counters.ssns_per_adl;
		adlperssn_count_in              :=  le.SSN_Verification.adlPerSSN_count;
		adls_per_addr_in                :=  le.velocity_counters.adls_per_addr;
		ssns_per_addr_in                :=  le.velocity_counters.ssns_per_addr;
		ssns_per_adl_c6_in              :=  le.velocity_counters.ssns_per_adl_created_6months;
		ssns_per_addr_c6_in             :=  le.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6_in           :=  le.velocity_counters.phones_per_addr_created_6months;
		bankrupt                        :=  le.bjl.bankrupt;
		disposition                     :=  StringLib.StringToUppercase(trim(le.bjl.disposition));
		bk_recent_count                 :=  le.bjl.bk_recent_count;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bjl.criminal_count;
		addr_stability_in               :=  le.mobility_indicator;
		archive_date                    :=  le.historydate;




		/* HELPERS */
		mymin( a, b ) := MACRO if( (a)<(b), (a), (b) ) ENDMACRO;
		mymax( a, b ) := MACRO if( (a)>(b), (a), (b) ) ENDMACRO;

		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		/***********/



		/* !!! change scoring year to system year when scoring !!! */
		scoring_year := if( archive_date = 999999, (INTEGER)((STRING)Std.Date.Today())[1..4], (INTEGER)((STRING)archive_date)[1..4] );


		/* updated vermod */

		contrary_phone := (INTEGER)(nap_summary=1);

		verfst_p := (nap_summary in [2,3,4,8,9,10,12]);
		verlst_p := (nap_summary in [2,5,7,8,9,11,12]);
		veradd_p := (nap_summary in [3,5,6,8,10,11,12]);
		verphn_p := (nap_summary in [4,6,7,9,10,11,12]);


		phncount := (INTEGER)verfst_p+(INTEGER)verlst_p+(INTEGER)veradd_p+(INTEGER)verphn_p;
		
		source_count2 := map( 
			source_count <= 1 => 1,
			source_count  = 2 => 2,
			3
		);


		add1_source_count2 := mymin( add1_source_count, 5 );


		source_tot_WP  := contains_i(rc_sources,   'WP');
		source_addr_AM := contains_i(addr_sources, 'AM');
		source_addr_AR := contains_i(addr_sources, 'AR');
		source_addr_BA := contains_i(addr_sources, 'BA');
		source_addr_CG := contains_i(addr_sources, 'CG');
		source_addr_CO := contains_i(addr_sources, 'CO');
		source_addr_EB := contains_i(addr_sources, 'EB');
		source_addr_EM := contains_i(addr_sources, 'EM');
		source_addr_VO := contains_i(addr_sources, 'VO');
		source_addr_EM_VO := if(source_addr_EM=1 or source_addr_VO=1, 1, 0);
		source_addr_EQ := contains_i(addr_sources, 'EQ');
		source_addr_L2 := contains_i(addr_sources, 'L2');
		source_addr_MW := contains_i(addr_sources, 'MW');
		source_addr_P  := contains_i(addr_sources, 'P ');
		source_addr_PL := contains_i(addr_sources, 'PL');
		source_addr_W  := contains_i(addr_sources, 'W ');
		source_addr_WP := contains_i(addr_sources, 'WP');



		source_addrfcraPos := source_addr_AM+source_addr_AR+source_addr_CG+source_addr_EB+
							 source_addr_EM_VO+source_addr_EQ+source_addr_MW+source_addr_P +
							 source_addr_PL   +source_addr_W +source_addr_WP
		;

		source_addrfcraPos_comp := source_addrfcraPos + (INTEGER)add1_credit_sourced + (INTEGER)add1_eda_sourced;
		source_addrfcraPos_compCap  := mymax(1,mymin(5,source_addrfcraPos_comp));

		source_addrfcraPos_compCap_nbl := case( source_addrfcraPos_compCap,
			1 => -1.720195168,
			2  => -2.053128842,
			3  => -2.007301814,
			4  => -2.44214288,
			5  => -2.817687257,
			-1.933609304
		);


		source_addrfcraNeg := source_addr_BA+source_addr_CO+source_addr_L2;
		source_addrfcraNegCap := mymin(1,source_addrfcraNeg);


		source_lname_BA := contains_i(lname_sources, 'BA');
		source_lname_CO := contains_i(lname_sources, 'CO');
		source_lname_L2 := contains_i(lname_sources, 'L2');


		source_lnamefcraNeg    := source_lname_BA+source_lname_CO+source_lname_L2;
		source_lnamefcraNegCap := mymin(2,source_lnamefcraNeg);

		source_lnamefcraNegCap_bl := case( source_lnamefcraNegCap,
			0 => -2.623368611,
			1  => -2.296473731,
			2  => -2.240934804,
			-2.508008634
		);

		source_lnamefcraNegCap_nbl := case( source_lnamefcraNegCap,
			0 => -1.987257853,
			1  => -1.854597445,
			2  => -1.782779287,
			-1.933609304
		);


		source_ssn_AM := contains_i(ssn_sources, 'AM');
		source_ssn_AR := contains_i(ssn_sources, 'AR');
		source_ssn_BA := contains_i(ssn_sources, 'BA');
		source_ssn_CO := contains_i(ssn_sources, 'CO');
		source_ssn_EB := contains_i(ssn_sources, 'EB');
		source_ssn_EM := contains_i(ssn_sources, 'EM');
		source_ssn_VO := contains_i(ssn_sources, 'VO');
		source_ssn_EM_VO := if(source_ssn_EM=1 or source_ssn_VO=1, 1, 0);
		source_ssn_EQ := contains_i(ssn_sources, 'EQ');
		source_ssn_L2 := contains_i(ssn_sources, 'L2');
		source_ssn_MW := contains_i(ssn_sources, 'MW');
		source_ssn_P  := contains_i(ssn_sources, 'P ');
		source_ssn_PL := contains_i(ssn_sources, 'PL');
		source_ssn_W  := contains_i(ssn_sources, 'W ');
		source_ssn_WP := contains_i(ssn_sources, 'WP');

		source_ssnfcraPos := source_ssn_AM+source_ssn_AR+source_ssn_EB+
                                 source_ssn_EM_VO+source_ssn_EQ+source_ssn_MW+source_ssn_P+
                                 source_ssn_PL   +source_ssn_W +source_ssn_WP;

		source_ssnfcraPos_comp    := source_ssnfcraPos + credit_sourced;
		source_ssnfcraPos_compCap := mymax(1,mymin(4,source_ssnfcraPos_comp));
     
	 
		source_ssnfcraPos_compCap_nbl := case( source_ssnfcraPos_compCap,
			1 => -1.720402525,
			2  => -1.88687911,
			3  => -2.292899777,
			4  => -2.326976536,
			-1.933609304
		);

		source_ssnfcraNeg := source_ssn_BA+source_ssn_CO+source_ssn_L2;
		source_ssnfcraNegCap := mymin(2,source_ssnfcraNeg);

		source_ssnfcraNegCap_nbl := case( source_ssnfcraNegCap,
			0  => -1.948799591,
			1  => -1.936595371,
			2  => -1.595386154,
			-1.933609304
		);




/************************************************************/
		if add1_isbestmatch then
			/* To suppress warning messages */
			add_score100 := -1;
			ModRVA8_vermod_notbest := -1;
			/**********/
			
			source_count_sum_pk := map( 
				source_count2 >= 3 and add1_source_count2 >= 5 => 4,
				source_count2 >= 3 and add1_source_count2 >= 4 => 3,
				source_count2 >= 3                             => 2,
									   add1_source_count2 >= 3 => 2,
				source_count2 >= 2                             => 1,
				0
			);


			ver_p_level := map( 
				verphn_p and verlst_p and veradd_p and verfst_p => 4,
				verphn_p and verlst_p and ( veradd_p or verfst_p ) => 3,
				( phncount = 2 ) and verphn_p and veradd_p => 0,
				( phncount = 2 ) and verlst_p and veradd_p => 0,
				( phncount = 0 ) => 1,
				2
			);

			source_count_sum_pk_m := case( source_count_sum_pk,
				0 => 0.1042600,
				1 => 0.0961441,
				2 => 0.0667807,
				3 => 0.0498828,
				0.0432271
			);


			ver_p_level_m := case( ver_p_level,
				0 => 0.1043221,
				1 => 0.0922911,
				2 => 0.0851288,
				3 => 0.0664804,
				0.0529554
			);

			ModRVA8_vermod_best := -1.669615514
				+ contrary_phone  * 0.1836346774
				+ source_count_sum_pk_m  * 14.849115273
				+ ver_p_level_m  * 12.154706657
				+ source_addrfcraNegCap  * 0.4629588947
				+ source_lnamefcraNegCap_bl  * 1.1356845642
				+ source_addr_W  * -0.406398707
			;
			ModRVA8_vermod := 100 * ((exp(ModRVA8_vermod_best )) / (1+exp(ModRVA8_vermod_best )));

		else
 			/* To suppress warning messages */
			MODRVA8_vermod_best := -1;
			/**********/
		 
			source_count_sum_pk := map( 
				source_count2 >= 3 and add1_source_count2 >= 3 => 14,
				source_count2 >= 2 and add1_source_count2 >= 2 => 13,
				source_count2 >= 3 => 12,
				source_count2 >= 2 and add1_source_count2 >= 1 => 12,
				source_count2 >= 2 => 11,
				source_count2 >= 1 and add1_source_count2 >= 1 => 11,
				10
			);


			ver_p_level := map( 
				verphn_p and verlst_p and veradd_p and verfst_p => 13,
				verphn_p and verlst_p and ( veradd_p or verfst_p ) => 12,
				( phncount = 2 ) and verphn_p and veradd_p => 10,
				( phncount = 2 ) and verlst_p and veradd_p => 10,
			   11
			  );

				
			add_score100 := map( 
				( add1_address_score >= 50 ) and ( add1_address_score <= 100 ) => 1,
			   0
			);


			source_count_sum_pk_m := case( source_count_sum_pk,
				10 => 0.1524677,
				11 => 0.1336918,
				12 => 0.1112426,
				13 => 0.0852323,
				0.0671043
			);

			ver_p_level_m := case( ver_p_level,
				10 => 0.1462517,
				11 => 0.1344338,
				12 => 0.1009082,
				0.0897334
			);

			ModRVA8_vermod_notbest := 1.3504429996
				+ add_score100  * -0.155679272
				+ source_count_sum_pk_m  * 4.0165623069
				+ ver_p_level_m  * 9.3391088478
				+ source_addrfcraNegCap  * 0.2409996277
				+ source_lnamefcraNegCap_nbl  * 1.1795954613
				+ source_addrfcraPos_compCap_nbl  * 0.2479893132
				+ source_ssnfcraPos_compCap_nbl  * 0.3611844673
				+ source_ssnfcraNegCap_nbl  * 0.6681743744
				+ source_addr_W  * -1.188863723
				+ source_tot_WP  * -0.211763956
			;
			ModRVA8_vermod := 100 * ((exp(ModRVA8_vermod_notbest )) / (1+exp(ModRVA8_vermod_notbest )));

		end;                   /* of Add1_isbestmatch = 0 */
     




     

		/* updated fpmod */
		if addrpop then
			aptflag := if( rc_dwelltype='A', 1, 0 );
			zippobox := (INTEGER)(rc_ziptypeflag=1);


			ec1 := trim(out_addr_status)[1];
			ec3 := trim(out_addr_status)[3];
			ec4 := trim(out_addr_status)[4];

			addr_changed := (ec1='S' and ec3 != '0');
			unit_changed := (ec1='S' and ec4 != '0');


			casserr_pk := map( 
				ec1='S' and unit_changed and addr_changed => 4,
				ec1='S' and unit_changed                  => 3,
				ec1='E'                                   => 2,
				ec1='S'                  and addr_changed => 1,
				0
			);


			addprob := if( casserr_pk < 2 and zippobox = 1, 2, casserr_pk );


			addprob_m := case(addprob,
				0 => 0.0810986,
				1 => 0.0916095,
				2 => 0.1045328,
				3 => 0.1244692,
				0.1362468
			);
		else
			/* To suppress warning messages */
			ec1 := '-1';
		    ec3 := '-1';
		    ec4 := '-1';
			casserr_pk := -1;
			/**********/
			
			aptflag           := 0;
			zippobox          := 0;
			addr_changed      := 0;
			unit_changed      := 0;
			addprob           := 4;
			addprob_m         := 0.1362468;
		end;


		phone_zip_mismatch := if(rc_phonezipflag='1', 1, 0);
		disconnected := (INTEGER)((INTEGER)rc_hriskphoneflag=5);
		
		phone_zip_mismatch_n := if(hphnpop=1, phone_zip_mismatch, 0 );
		pnotpots := if(hphnpop=1, if(telcordia_type in ['00','50','51','52','54'], 0, 1), 0);	
		 
		not_connected := map(
			hphnpop=0 => 1,
			nap_status='C' and disconnected = 0 => 0,
			1
		);

		phone_highRisk := (INTEGER)((INTEGER)rc_hriskphoneflag != 0);
     
		ssn_valid := (INTEGER)rc_ssnvalflag in [0,3] or ((INTEGER)rc_ssnvalflag=2 and (INTEGER)ssnlength=4);
		high_issue_date := (INTEGER)rc_ssnhighissue;
		ssndead := (INTEGER)((INTEGER)ssnlength>0 and (INTEGER)rc_decsflag=1);

		
		if (INTEGER)ssnlength > 0 then
			ssninval := (INTEGER)((INTEGER)ssn_valid=0);
			high_issue_dateyr := (INTEGER)(high_issue_date/10000);

			dob_year := if((INTEGER)in_dob != 0, (INTEGER)in_dob[1..4], 0 );
			year_diff := high_issue_dateyr - dob_year;

			ssnprior := (INTEGER)(high_issue_dateyr > 0 and dob_year > 0 and year_diff between -100 and 2 );
			ssnprob := (INTEGER)(ssninval=1 or ssndead=1 or ssnprior=1);
		else
			/* To suppress warning messages */
			high_issue_dateyr := -1;
			dob_year  := -1;
			year_diff := -1;
			/**********/
			
			ssnprior := 0;
			ssninval := 0;
			ssnprob  := 0;
		end;


		ssns_per_adl := if( ssns_per_adl_in=0, 4, mymin(4,ssns_per_adl_in));


		ssns_per_adl_l := case( ssns_per_adl,
			1 => -2.367201531,
			2 => -2.241101861,
			3 => -2.112257287,
			4 => -1.750563707,
		   -2.321996539
		);

		adlperssn_count := if( adlperssn_count_in=0, 4, mymin(4,adlperssn_count_in) );


		adlperssn_count_l := case( adlperssn_count,
			1 => -2.365953725,
			2 => -2.319349935,
			3 => -2.20088088,
			4 => -2.039673052,
		   -2.321996539
		);

		adls_per_addr := map(
			adls_per_addr_in =  0 => 4,
			adls_per_addr_in =  1 => 3,
			adls_per_addr_in =  2 => 1,
			adls_per_addr_in < 10 => 2,
			adls_per_addr_in < 15 => 3,
			4           
		);

		ssns_per_addr := map(
			ssns_per_addr_in  =  0 => 4,
			ssns_per_addr_in  =  1 => 3,
			ssns_per_addr_in  =  2 => 1,
			ssns_per_addr_in <= 10 => 2,
			ssns_per_addr_in <= 15 => 3,
			4
		);
		
		person_per_addr := mymax(adls_per_addr,ssns_per_addr);

		person_per_addr2:= map(
			person_per_addr=1 and aptflag=1 => 3,
			aptflag=1                       => 4,
			person_per_addr
		);

		person_per_addr2_l := case( person_per_addr2,
			1 => -3.249981175,
			2 => -2.571468182,
			3 => -2.283959949,
			4 => -2.025261838,
		   -2.321996539
		);

		ssns_per_adl_c6 := mymin(2, ssns_per_adl_c6_in);
		ssns_per_adl_c6_l := case( ssns_per_adl_c6,
			0 => -2.389470461,
			1 => -2.223377107,
			2 => -1.578666249,
			-2.321996539
		);
		
		
		ssns_per_addr_c6 := mymin(4,ssns_per_addr_c6_in);
		ssns_per_addr_c6_l := case( ssns_per_addr_c6,
			0 => -2.498036273,
			1 => -2.202048665,
			2 => -2.046728597,
			3 => -1.938105224,
			4 => -1.602182737,
			-2.321996539
		);

		phones_per_addr_c6 := mymin(2,phones_per_addr_c6_in);
		phones_per_addr_c6_l := case( phones_per_addr_c6,
			0 => -2.421278881,
			1 => -2.071986133,
			2 => -1.885038792,
			-2.321996539
		);

		ModRVA8_fpmod_a := 5.500289273
			+ addprob_m  * 4.0718035934
			+ phone_zip_mismatch_n  * 0.1617434301
			+ pnotpots  * 0.1729425303
			+ not_connected  * 0.1730339431
			+ ssnprob  * 0.3685191331
			+ ssns_per_adl_l  * 0.719315381
			+ adlperssn_count_l  * 0.6948194687
			+ person_per_addr2_l  * 0.6352487721
			+ ssns_per_adl_c6_l  * 0.3303582715
			+ ssns_per_addr_c6_l  * 0.7828193179
			+ phones_per_addr_c6_l  * 0.4384576439
			+ phone_highRisk  * 0.193247606
		;
		ModRVA8_fpmod := 100 * ((exp(ModRVA8_fpmod_a)) / (1+exp(ModRVA8_fpmod_a)));





 /* derog bankrupt */

		bk_discharged := (INTEGER)(disposition[1..9]='DISCHARGE');
		bk_recent_count2 := (INTEGER)(bk_recent_count >= 1 );


		bk_4 := map( 
			bankrupt and bk_discharged = 0 and bk_recent_count2 = 1 => 2,
			bankrupt and bk_discharged = 0 => 1,
			0
		);

		bk_4_m := case( bk_4,
			0 => 0.0868878003,
			1 => 0.2010582011,
			0.2599009901
		);


		source_tot_L2 := contains_i(rc_sources,'L2');
     
		liens_unreleased_histor_f := (INTEGER)(liens_historical_unreleased_ct>0 or source_tot_L2>0);
		liens_unreleased_recent_f := (INTEGER)(liens_recent_unreleased_count  > 0);
		
		lien_i := if( liens_unreleased_recent_f=1, 2, liens_unreleased_histor_f );

		criminal_F := (INTEGER)(criminal_count>0);     
		liencriminal_i := if(criminal_f=1, 2, lien_i);
    

		lienCriminal_i_l := case( lienCriminal_i,
			0 => -2.427369225,
			1 => -2.033495169,
			2 => -1.814243424,
		   -2.321996539
		);

		/* avm */
		add1_avm_med_fips_ratio := if(
			(INTEGER)add1_avm_automated_valuation!=0 and (INTEGER)add1_avm_med_fips!=0,
			((real)add1_avm_automated_valuation)/((real)add1_avm_med_fips),
			-1
		);
		
		add1_avm_med_fips_ratio2 := if( add1_avm_med_fips_ratio=-1, 0.55, mymin(2,add1_avm_med_fips_ratio));

     
		/* other vars */
		pr_count := map(
			PR_count_in  = 0 => 0,
			pr_count_in <= 3 => 3,
			4
		);

		pr_count_l := case( pr_count,
     		0 => -2.01564031,
			3 => -2.737268654,
			4 => -3.092005668,
			-2.321996539
		);
	 
		property_owned_purchase_f := (INTEGER)(property_owned_purchase_count>0);     

		credit_first_seen2 := if(credit_first_seen!=0, credit_first_seen/100, -1 );
		header_first_seen2 := if(header_first_seen!=0, header_first_seen/100, -1 );
		credit_first_seen_years := if( scoring_year != 0 and credit_first_seen2 != -1, mymax(0,scoring_year-(INTEGER)credit_first_seen2), -1);
		header_first_seen_years := if( scoring_year != 0 and header_first_seen2 != -1, mymax(0,scoring_year-(INTEGER)header_first_seen2), -1);

		ssn_seen_years := mymax(credit_first_seen_years,header_first_seen_years);
     
		ssn_seen_years_i := map(
			ssn_seen_years  = -1 => 5,
			ssn_seen_years <=  4 => 4,
			ssn_seen_years <=  6 => 6,
			ssn_seen_years <=  8 => 8,
			ssn_seen_years <= 10 => 10,
			ssn_seen_years <= 11 => 11,
			ssn_seen_years <= 13 => 13,
			ssn_seen_years <= 14 => 14,
			ssn_seen_years <= 15 => 15,
			ssn_seen_years <= 16 => 16,
			ssn_seen_years <= 17 => 17,
			ssn_seen_years <= 22 => 22,
			23
		);

		ssn_seen_years_i_l := case( ssn_seen_years_i,
			 4 => -1.50944843,
			 5 => -1.684006603,
			 6 => -1.936467201,
			 8 => -2.065427783,
			10 => -2.113632898,
			11 => -2.144055901,
			13 => -2.15183709,
			14 => -2.27471769,
			15 => -2.318049309,
			16 => -2.314902079,
			17 => -2.406407718,
			22 => -2.574042491,
			23 => -2.914239221,
		   -2.321996539
		);

		addr_stability := case( (INTEGER)addr_stability_in,
			0 =>0,
			1 =>1,
			2 =>2,
			3 =>2,
			4 =>4,
			5 =>5,
			6
		);

		addr_stability_l := case( addr_stability,
			0 => -1.707970431,
			1 => -2.00484172,
			2 => -2.214370768,
			4 => -2.391281846,
			5 => -2.662358665,
			6 => -2.933715468,
			-2.321996539
		);
     
     
		/* final model */

		logit := 0.9221750198
			+ ModRVA8_vermod  * 0.0549180535
			+ bk_4_m  * 6.5576226994
			+ ModRVA8_fpmod  * 0.0452819267
			+ lienCriminal_i_l  * 0.7107538659
			+ addr_stability_l  * 0.365178327
			+ ssn_seen_years_i_l  * 0.4924646628
			+ add1_avm_med_fips_ratio2  * -0.328545059
			+ pr_count_l  * 0.3777995016
			+ property_owned_purchase_f  * -0.276167493
		;
     
		phat := (exp(logit )) / (1+exp(logit ));
		ModRVA8 := round(-40*(log(phat/(1-phat)) - log(1/21))/log(2) + 703);  


		RVA711_0_0_a := mymin(900,mymax(501,ModRVA8));

		/* override */

		ssnprior_x := ((INTEGER)rc_ssndobflag=1 or (INTEGER)rc_pwssndobflag=1);
		criminal_flag := (criminal_count>0);
		corrections := ((INTEGER)rc_hrisksic=2225);

		rva711_0_0_b := map(
			riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid)    => 222,
			RVA711_0_0_a>680 and (ssndead=1 or ssnprior_x or criminal_flag or corrections ) => 680,
			RVA711_0_0_a
		);
     
     

		riTemp  := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		self.ri := map(
			riTemp[1].hri <> '00' => riTemp,
			rva711_0_0_b = 222 and ~inCalif => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),		
			RiskWise.rvReasonCodes(le, 4, inCalif, true)
		);
		
	
		self.score := map
		(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			self.ri[1].hri='35' => '000',
			(string3)rva711_0_0_b
		);


		self.seq := le.seq;
		
#if(Risk_Indicators.iid_constants.validation_debug)	
		self.clam := le;
		self.ModRVA8_vermod	:=	ModRVA8_vermod	;
		self.ModRVA8_fpmod	:=	ModRVA8_fpmod	;
		self.bk_4_m	:=	bk_4_m	;
		self.lienCriminal_i_l	:=	lienCriminal_i_l	;
		self.add1_avm_med_fips_ratio2	:=	add1_avm_med_fips_ratio2	;
		self.pr_count_l	:=	pr_count_l	;
		self.property_owned_purchase_f	:=	property_owned_purchase_f	;
		self.ssn_seen_years_i_l	:=	ssn_seen_years_i_l	;
		self.addr_stability_l	:=	addr_stability_l	;
		
		self.contrary_phone	:= 	contrary_phone	;
		self.source_count_sum_pk_m	:= 	source_count_sum_pk_m	;
		self.ver_p_level_m	:= 	ver_p_level_m	;
		self.source_addrfcraNegCap	:= 	source_addrfcraNegCap	;
		self.source_lnamefcraNegCap_bl	:= 	source_lnamefcraNegCap_bl	;
		self.source_addr_W	:= 	source_addr_W	;
		
		self.add_score100	:= 	add_score100	;
		self.source_lnamefcraNegCap_nbl	:= 	source_lnamefcraNegCap_nbl	;
		self.source_addrfcraPos_compCap_nbl	:= 	source_addrfcraPos_compCap_nbl	;
		self.source_ssnfcraPos_compCap_nbl	:= 	source_ssnfcraPos_compCap_nbl	;
		self.source_ssnfcraNegCap_nbl	:= 	source_ssnfcraNegCap_nbl	;
		self.source_tot_WP	:= 	source_tot_WP	;

		self.addprob_m	:= 	addprob_m	;
		self.phone_zip_mismatch_n	:= 	phone_zip_mismatch_n	;
		self.pnotpots	:= 	pnotpots	;
		self.not_connected	:= 	not_connected	;
		self.ssnprob	:= 	ssnprob	;
		self.ssns_per_adl_l	:= 	ssns_per_adl_l	;
		self.adlperssn_count_l	:= 	adlperssn_count_l	;
		self.person_per_addr2_l	:= 	person_per_addr2_l	;
		self.ssns_per_adl_c6_l	:= 	ssns_per_adl_c6_l	;
		self.ssns_per_addr_c6_l	:= 	ssns_per_addr_c6_l	;
		self.phones_per_addr_c6_l	:= 	phones_per_addr_c6_l	;
		self.phone_highRisk	:= 	phone_highRisk	;

		self.casserr_pk := casserr_pk;
		self.zippobox := zippobox;
		self.addprob := addprob;
#end

		self := [];

	end;

	results := project(clam,doModel(LEFT));
	return results;
end;
     