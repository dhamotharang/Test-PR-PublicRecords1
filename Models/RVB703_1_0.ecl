import risk_indicators, ut, riskwise, riskwisefcra, riskview;

export RVB703_1_0( grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean isCalifornia ) := FUNCTION

	Layout_ModelOut doModel( clam le ) := TRANSFORM
		// Input
			nas_summary                     := le.iid.nas_summary;
			nap_summary                     := le.iid.nap_summary;
			source_count                    := le.Name_Verification.source_count;
			add1_source_count               := le.address_verification.input_address_information.source_count;
			add1_isbestmatch				:= le.address_verification.input_address_information.isbestmatch;

			ssnlength                       := (INTEGER)le.input_validation.SSN_Length;
			// PropertyOwnership
			property_owned_total			:= le.address_verification.owned.property_total;
			property_sold_total				:= le.address_verification.sold.property_total;
			property_ambig_total			:= le.address_verification.ambiguous.property_total;
			add1_naprop                     := le.address_verification.input_address_information.naprop;
			add2_naprop                     := le.address_verification.address_history_1.naprop;
			add3_naprop                     := le.address_verification.address_history_2.naprop;


			// DerogatoryPublicRecords
			filing_count					:= le.bjl.filing_count;
			disposition                     := stringlib.StringToUppercase(trim(le.bjl.disposition));
			liens_historical_released_count := le.bjl.liens_historical_released_count;
			liens_recent_released_count     := le.bjl.liens_recent_released_count;
			liens_recent_unreleased_count   := le.bjl.liens_recent_unreleased_count;
			liens_historical_unreleased_ct  := le.bjl.liens_historical_unreleased_count;	

			// PhoneFactors		
			telcordia_type                  := le.Phone_Verification.telcordia_type;


			// SuspiciousSSNUsage		
			rc_decsflag                     := le.ssn_verification.validation.deceased;
			rc_ssnhighissue                 := le.ssn_verification.validation.high_issue_date;
			in_dob                          := le.shell_input.dob;
			adlperssn_count					:= le.ssn_verification.adlperssn_count;

			// Overrides
			rc_ssndobflag                   := (INTEGER)le.iid.socsdobflag;
			rc_hrisksic                     := (INTEGER)le.iid.hrisksic;
			criminal_count                  := le.bjl.criminal_count;
		//

		verfst_p := nap_summary in [2,3,4,8,9,10,12];
		verlst_p := nap_summary in [2,5,7,8,9,11,12];
		veradd_p := nap_summary in [3,5,6,8,10,11,12];
		verphn_p := nap_summary in [4,6,7,9,10,11,12];

		verfst_s := nas_summary in [2,3,4,8,9,10,12];	
		verlst_s := nas_summary in [2,5,7,8,9,11,12];	
		veradd_s := nas_summary in [3,5,6,8,10,11,12];	
		verssn_s := nas_summary in [4,6,7,9,10,11,12];	

		verphn := (INTEGER)verphn_p;
		verssn := (INTEGER)verssn_s;
		verfst := (INTEGER)( verfst_p or verfst_s );
		verlst := (INTEGER)( verlst_p or verlst_s );
		veradd := (INTEGER)( veradd_p or veradd_s );

		versum4 := verlst + veradd + verphn + verssn;

		vertree := 10000 * verfst +
					1000 * verlst +
					 100 * veradd +
					  10 * verphn +
					   1 * verssn;


		verx := map(
			add1_isbestmatch and source_count >= 4 and vertree=11111 => 10,
			add1_isbestmatch and source_count >= 4                   =>  9,
			add1_isbestmatch and nap_summary = 12                    =>  9,
			add1_isbestmatch and nap_summary in [9,10,11]            =>  7,
			add1_isbestmatch and nap_summary >= 8                    =>  5,
			add1_isbestmatch and versum4 = 4                         =>  6.5,
			~add1_isbestmatch and nas_summary=12                     =>  4,
			verphn=1 and verssn=1 and nap_summary = 12               =>  2.5,
			verphn=1 and verssn=1                                    =>  1.5,
			verphn=1 and versum4 <= 2                                =>  1,
			verphn=1 and versum4 <= 3                                =>  2.5,
			versum4 <= 2                                             =>  2,
			nas_summary=12 and nap_summary <= 6 and source_count >= 3=>  7.5,
			nas_summary=12 and nap_summary <= 8                      =>  6,
			nap_summary <= 5                                         =>  1.5,
			nap_summary <= 8                                         =>  2,
			-1
		);

		add1_source_count2 := if( add1_source_count >= 5, 5, add1_source_count );

		verx2 := map(
			verx=10 and add1_source_count2 = 5 => 13,
			verx= 9 and add1_source_count >= 4 => 12,
			verx in [9,10]                     => 11,
			verx
		);


		verx2_m := case( verx2,
			1   => 0.3787879,
			1.5 => 0.3040238,
			2   => 0.2661824,
			2.5 => 0.2533660,
			4   => 0.2489414,
			5   => 0.2349757,
			6   => 0.2344680,
			6.5 => 0.2148760,
			7   => 0.2109501,
			7.5 => 0.2067477,
			11  => 0.1928169,
			12  => 0.1552036,
			0.1447154
		);


        /*CONSUMER PHONE PROBLEMS*/
		pnotpots := if( telcordia_type in ['00','50','51','52','54'], 0, 1 );


        /*MULTIPLE ADL PER SSN*/

		mult_adl_ssn := map(
			adlperssn_count <= 1 => 1,
			adlperssn_count >= 4 => 4,
			adlperssn_count
		);

		mult_adl_ssn_m := case( mult_adl_ssn,
			1 => 0.2161238,
			2 => 0.2383871,
			3 => 0.2572353,
			0.2858720
		);


        /*SSN PROBLEMS*/
		if( ssnlength > 0 ) then
			ssndead := rc_decsflag;
			high_issue_dateyr := (integer)(rc_ssnhighissue/10000);
			dob_year := (INTEGER)in_dob[1..4];

			year_diff := high_issue_dateyr - dob_year;
			ssnprior := high_issue_dateyr > 0 and dob_year > 0 and year_diff between -100 and 2;
			
			ssnprob := (integer)(ssndead or ssnprior);
		else
			ssndead := 0;
			ssnprob := 0;
			ssnprior:= 0;
			
			// these three values are defined ONLY to suppress the warning
			// "Conditional assignment to <value> isn't defined in all branches, and has no previous definition"
			year_diff := 0;
			high_issue_dateyr := 0;
			dob_year := 0;
		end;


        //DEROG INFORMATION

		lien_recent_un  := Min(3, liens_recent_unreleased_count);
		lien_hist_un    := Min(3, liens_historical_unreleased_ct   );
		lien_recent_rel := Min(1, liens_recent_released_count      );
		lien_hist_rel   := Min(1, liens_historical_released_count  );

		lienflag := map(
			lien_recent_un  > 2 => 6,
			lien_recent_un  = 2 => 5,
			lien_recent_un  = 1 => 4,
			lien_hist_un    > 2 => 6,
			lien_hist_un    >=1 => 4,
			lien_recent_rel = 1 => 3,
			1
		);
		

		
		bk_discharged := (disposition[1..9]='DISCHARGE');
		bkflag2 := map(
			disposition IN ['DISMISSED','CASE DISMISSED'] => 3,
			filing_count >= 2                             => 2,
			not bk_discharged                             => 1,
			0
		);

		lienflag_m := case( lienflag,
			1 => 0.2185524,
			3 => 0.2699387,
			4 => 0.2751596,
			5 => 0.3016422,
			0.3441815
		);

		bkflag2_m := case(bkflag2,
			0 => 0.1913701,
			1 => 0.2414168,
			2 => 0.2470379,
			0.3477157
		);


		/* PROPERTY */
		property_owned_total_x := property_owned_total > 0;
		property_sold_total_x  := property_sold_total  > 0;
		property_ambig_total_x := property_ambig_total > 0;

		Prop_Owner := map(
			4 in [add1_naprop,add2_naprop,add3_naprop] => 2,
			property_owned_total_x or property_sold_total_x or property_ambig_total_x => 1,
			0
		);

		add1_naprop_level := map(
			add1_naprop = 4 => 2,
			add1_naprop = 3 or Prop_Owner >= 1 => 1,
			0
		);

		add1_naprop_level_m := case( add1_naprop_level,
			0 => 0.2472466,
			1 => 0.2210791,
			0.1751572
		);

		/* CALCULATE SCORE */

		log_iter15 := -6.492280293
					  + VERX2_M  * 2.1599913754
					  + PNOTPOTS  * 0.5520201339
					  + MULT_ADL_SSN_M  * 5.7071448844
					  + SSNPROB  * 0.1040669813
					  + LIENFLAG_M  * 5.0238445088
					  + BKFLAG2_M  * 5.0232136094
					  + ADD1_NAPROP_LEVEL_M  * 4.0597811564
		 ;
		log_iter15a := (exp(log_iter15 )) / (1+exp(log_iter15 ));
		phat:=log_iter15a;
		log_iter15b := round(1000 * log_iter15a)*0.1;


		base  := 703;
		odds  := 0.047619048;
		point := -40;

		rvb703_1_0a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

		rvb703_1_0b := map(
			rvb703_1_0a < 501 => 501,
			rvb703_1_0a > 900 => 900,
			rvb703_1_0a
		);

		rvb703_1_0c := if( riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 222, rvb703_1_0b ); // no scores


		ssnprior2 := (rc_ssndobflag = 1);
		corrections := (rc_hrisksic = 2225);
		crim_flag := (criminal_count > 0);

		rvb703_1_0d := if( (ssndead=1 or corrections or crim_flag or ssnprior2) and rvb703_1_0c > 610, 610, rvb703_1_0c ); // overrides

		// self.score := (string)rvb703_1_0d;
		self.seq := le.seq;
		self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		self.score := map(
			self.ri[1].hri in ['91','92','93','94','95'] => (string)((integer)self.ri[1].hri + 10),
			self.ri[1].hri='35' => '000',
			intformat(rvb703_1_0d,3,1)
		);
			
	END;

	out := project( clam, doModel(LEFT) );

	Layout_ModelOut addReasons(clam le, Layout_ModelOut ri) := TRANSFORM
		self.ri := if(ri.ri[1].hri <> '00', ri.ri, RiskWise.rvReasonCodes(le, 4, isCalifornia) );
		self := ri;
	END;
	final := join(clam, out, left.seq=right.seq, addReasons(left, right), left outer);

	RETURN (final);

END;