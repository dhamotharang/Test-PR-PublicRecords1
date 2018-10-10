/*2008-10-08T23:18:50Z (Todd Steil)
remove references to riskview fields in boca shell which are not actually calculated at run time per bug 33800
*/
 /*  Modelers Notes
 *******************************************************************************************************
 *** RVT803_1_0  - nohit/thin file custom score for ATT to replace ex23      DHH                     ***
 *** This code contains override logic explicitly for ATT with values of 200-203                     ***
 *** Because of these overrides consult Darrin, if asked to append this score to a file              ***
 *******************************************************************************************************
*/

import riskwise, risk_indicators, ut, riskwisefcra, std, riskview;

export RVT803_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, 
				  boolean isCalifornia = false) :=


FUNCTION

	// Process Model into Layout
	Layout_ModelOut DoModel(clam le) := TRANSFORM	
	
	
	// reason codes
		riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		rv_codes := map(
											riTemp[1].hri <> '00' => riTemp,
											RiskWise.rvReasonCodes(le, 4, inCalif)
										);

		self.ri := rv_codes;
		
		
	
		
		// variables
		archive_date 											 := if(le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate);
    liens_recent_unreleased_count      := le.bjl.liens_recent_unreleased_count;       		// #369    NUM OF UNRELEASED LIENS IN LAST 2 YEARS
    liens_historical_unreleased_ct     := le.bjl.liens_historical_unreleased_count;   		// #370    NUM OF UNRELEASED LIENS EVER
    liens_recent_released_count        := le.bjl.liens_recent_released_count;         		// #371    NUM OF RELEASED LIENS IN LAST 2 YEARS
    liens_historical_released_count    := le.bjl.liens_historical_released_count;     		// #372    NUM OF RELEASED LIENS EVER
    rc_bansflag                        := le.iid.bansflag;												    		// #68     BANKRUPTCY INDICATOR
    criminal_count                     := le.bjl.criminal_count;									    		// #374    NUMBER OF CRIMINAL CONVICTIONS
    rc_decsflag                        := (integer)le.ssn_verification.validation.deceased;    		// #55     SSN DECEASED INDICATOR
    adlperssn_count                    := le.ssn_verification.adlperssn_count;        		// #346    CURRENT :=    // # OF UNIQUE ADL'S FOUND WITH SSN
    rc_sources                         := le.iid.sources;												      		// #69     HEADER SOURCES KEY
    property_owned_total               := le.address_verification.owned.property_total;   // #222    NUMBER OF OWNED PROPERTIES
    property_sold_total                := le.address_verification.sold.property_total;    // #227    NUMBER OD SOLD PROPERTIES
    add1_naprop                        := le.address_verification.input_address_information.naprop;   // #203    NAME-ADD-PROPERTY OWNERSHIP RESULTS
    add2_naprop                        := le.address_verification.address_history_1.naprop;   // #269    NAME-ADD-PROPERTY OWNERSHIP RESULTS
    add3_naprop                        := le.address_verification.address_history_2.naprop;				    // #304    NAME-ADD-PROPERTY OWNERSHIP RESULTS
    in_dob                             := le.shell_input.dob;														  // #29     INPUT DATE OF BIRTH
    rc_pwssnvalflag                    := le.iid.PWsocsvalflag;												    // #58     SSN VALID INDICATOR (PI)
    rc_pwssndobflag                    := le.iid.PWsocsdobflag; //SSN Prior Indicator (PW)    
		ams_college_type                   := le.student.college_type;												// #434    COLLEGE TYPE
    addrs_per_ssn                      := le.Velocity_Counters.addrs_per_ssn;					    // #347    CURRENT :=    // # OF ADDR'S FOUND WITH SSN
    nap_summary                        := le.iid.nap_summary;													    // #35     NAME-ADDR-PHN VERIFICATION FROM IID
    nas_summary                        := le.iid.nas_summary; 													  // #34     NAME-ADDR-SSN VERIFICATION FROM IID
    combo_dobscore                     := le.iid.combo_dobscore;											    // #109    DOB NAME MATCH SCORE
    rc_ssndobflag                      := (INTEGER)le.iid.socsdobflag;								    // #56     SSN PRIOR INDICATOR
    nap_status                         := le.iid.nap_Status;													    // #37     PHONE STATUS
    rc_hriskphoneflag                  := le.iid.hriskphoneflag;												  // #45     INPUT PHONE HIGH RISK INDICATOR
    rc_hphonetypeflag                  := StringLib.StringToUppercase(le.iid.hphonetypeflag);   // #46     INPUT PHONE TYPE
		rc_phonetype                       := trim(le.iid.phonetype);											    // #94     PHONE TYPE INDICATOR
    rc_hriskaddrflag                   := le.iid.hriskaddrflag;												    // #54     INPUT ADDR HIGH RISK INDICATOR
    rc_cityzipflag                     := le.iid.cityzipflag;													    // #98     CITY /ZIPCODE MISMATCH INDICATOR
    rc_addrvalflag                     := le.iid.addrvalflag;													    // #66     ADDR VALIDATION INDICATOR
    add1_avm_automated_valuation       := le.avm.input_address_information.avm_automated_valuation;   // #187    AVM: OVERALL VALUATION
    add1_lres                          := le.lres;																			  // #177    DIFFERENCE BETWEEN ARCHIVE DATE AND ADD1_DATE_FIRST_SEEN
    max_lres                           := le.Other_Address_Info.max_lres;								  // #325    MAX TIME AT ADDRESS
    ssnlength                          := (integer)le.input_validation.ssn_length;	      // #149    LENGTH OF INPUT SSN
    rc_hrisksic                        := (INTEGER)le.iid.hrisksic;										    // #89     SIC CODE FOR HIGH RISK COMMERCIAL ADDRESS(PRISON)
    rv_rc1                             := rv_codes[1].hri;		  									   		 //     1ST REASON CODE FOR RISKVIEW
    rv_rc2                             := rv_codes[2].hri;													 		 //     2ND REASON CODE FOR RISKVIEW
    rv_rc3                             := rv_codes[3].hri;																//     3RD REASON CODE FOR RISKVIEW
    rv_rc4                             := rv_codes[4].hri;																//     4TH REASON CODE FOR RISKVIEW
		year 															 := (integer)(archive_date / 100);
		fnamepop													 := (integer)le.input_validation.FirstName;
		lnamepop													 := (integer)le.input_validation.LastName;
		addrpop														 := (integer)le.input_validation.Address;
		hphnpop														 := (integer)le.input_validation.HomePhone;
		dobpop														 := (integer)le.input_validation.DateOfBirth;		

//******************************************************************************************************************************
		

//*** dobver ***;

    scr222 := riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid);

    dobver := if( ~scr222 AND combo_dobscore >= 90 AND combo_dobscore <= 100, 1, 0);
 
//*** derog1 ***;

    lien_recent_un := min(1, liens_recent_unreleased_count);
    lien_hist_un := min(1,liens_historical_unreleased_ct);
    lien_recent_rel := min(1,liens_recent_released_count);
    lien_hist_rel := min(1,liens_historical_released_count);

    lienx := if(lien_recent_un=1 or lien_hist_un=1 or lien_recent_rel=1 or lien_hist_rel=1, 1, 0);
    BKRT := if(rc_bansflag in ['1','2'], 1, 0);

    criminal_flag_tmp := if(criminal_count > 0, 1, 0);
    deceased := if(rc_decsflag = 1, 1, 0);
		derog := (integer)(deceased > 0 or criminal_flag_tmp > 0 or bkrt > 0 or lienx > 0);
		
//*** mult_adl_count_m ***;

		mult_adl_count := MAP(adlperssn_count <= 1 => 0,
													adlperssn_count <= 2 => 1,
													2);

    mult_adl_count_mn := MAP(mult_adl_count = 0 => 0.4310606061,
															mult_adl_count = 1 => 0.5247610773,
															0.562745098);


    mult_adl_count222 := if(adlperssn_count <= 1, 0, 1);




//*** num_pos_totc_m ***;

    // tot source count;

    source_tot_AM := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'AM', 1) >= 1, 1, 0);
    source_tot_AR := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'AR', 1) >= 1, 1, 0);
    source_tot_BA := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'BA', 1) >= 1, 1, 0);
    source_tot_D  := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'D ', 1) >= 1, 1, 0);
    source_tot_EB := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'EB', 1) >= 1, 1, 0);
    source_tot_EM := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'EM', 1) >= 1, 1, 0);
		source_tot_VO := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'VO', 1) >= 1, 1, 0);
		source_tot_EM_VO := if(source_tot_EM=1 or source_tot_VO=1, 1, 0);
    source_tot_EQ := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'EQ', 1) >= 1, 1, 0);
    source_tot_P  := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'P ' , 1) >= 1, 1, 0);
    source_tot_PL := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'PL', 1) >= 1, 1, 0);
    source_tot_TU := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'TU', 1) >= 1, 1, 0);
    source_tot_V  := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'V ' , 1) >= 1, 1, 0);
    source_tot_W  := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'W ' , 1) >= 1, 1, 0);
    source_tot_WP := if(StringLib.StringFind(StringLib.StringToUpperCase(rc_sources),'WP', 1) >= 1, 1, 0);

		
    num_pos_sources_tot := sum( source_tot_AM,
                                source_tot_AR,
                                source_tot_BA,
                                source_tot_D,
                                source_tot_EB,
                                source_tot_EM_VO,
                                source_tot_EQ,
                                 source_tot_P,
                                source_tot_PL,
                                source_tot_TU,
                                source_tot_V ,
                                source_tot_W ,
                                source_tot_WP
                            );


    num_pos_totd := if(num_pos_sources_tot > 1, 1, 0);
		num_pos_totc_mn := if(num_pos_totd = 0, 0.4909665763, 0.3554065381);
		
//*** propx_m ***;

    prop_own := if(property_owned_total > 0, 1, 0);
		prop_sold := if(property_sold_total > 0, 1, 0);
		prop_tot := if(prop_own=1 or prop_sold=1, 1, 0);


    NaProp4_any := if( add1_naprop = 4  or add2_naprop = 4 or add3_naprop = 4, 1, 0);
		NaProp3_any := if( add1_naprop = 3 or add2_naprop = 3 or add3_naprop = 3, 1, 0);

    propx := MAP(prop_tot = 1 or NaProp4_any = 1 => 2,
								 NaProp3_any = 1 => 1,
								 0);


    propx_mn := MAP(propx = 0 => 0.4815354713,
										propx = 1 => 0.4265041889,
										0.2916666667);

 //*** age1_b ***;

    dob_y := (integer)in_dob[1..4];
		age1 := if(dob_y=0, 0, year - dob_y);
		
		age1_bn_tmp := MAP(age1 <= 19 => 19,
									 age1 >= 51 => 51,
									 age1);
		
		// age override
		age1_bn := if(dobpop=0, 19, age1_bn_tmp);

//*** ssn18 ***;

		ssn18n := if(rc_pwssnvalflag = '5', 1, 0);


//*** col_type ***;

		col_typen := if(ams_college_type != ' ', 1, 0);
  

//*** addpssn_m  ***;

		addpssn := MAP(addrs_per_ssn = 1 => 0,
									 addrs_per_ssn  = 0 => 1,
									 addrs_per_ssn  = 2 => 2,
									 3);

		addpssn_mn := MAP(addpssn = 0 => 0.3928571429,
											addpssn = 1 => 0.4470068695,
											addpssn = 2 => 0.4674022066,
											0.5066592675) ;


// *fp_prob*;

		ssnprior_tmp := if(rc_ssndobflag = 1, 1, 0);
    disconnected := if(rc_hriskphoneflag = '5', 1, 0);

    ns_disco := if(trim(nap_status[1]) = 'D', 1, 0);
		disco_x := if(disconnected =1 or ns_disco =1, 1, 0);
		pcs_pi := if(rc_hriskphoneflag = '3', 1, 0);
		pcsm_pw := if(rc_hphonetypeflag = '3', 1, 0);
		PCS_phn := if(pcsm_pw = 1 or pcs_pi = 1, 1, 0);

		nongeo_phn := if(rc_hphonetypeflag = '7', 1, 0);
		non_us_phn := if(rc_phonetype = '3', 1, 0);

		phn_prob := if(pcs_phn=1 or nongeo_phn=1 or disco_x=1 or non_us_phn=1, 1, 0);
		po_box := if(rc_hriskaddrflag = '1', 1, 0);

		add_empty := if(rc_hriskaddrflag = '5', 1, 0);
		cityzip := if(rc_cityzipflag = '1', 1, 0);
		addinval := if(rc_addrvalflag = 'N', 1, 0);
		
		add_prob := MAP( (po_box = 1 or add_empty = 1 or cityzip = 1) and addinval = 1 and ~scr222 => 2,
										 (po_box = 1 or add_empty = 1 or cityzip = 1) and addinval = 1 and scr222 => 1,
										 addinval = 1 => 1,
										 0);


		fp_prob := MAP(ssnprior_tmp=1 => 3,
									 phn_prob=1 => 2,
									 add_prob > 0 => 1,
									 0);



//*** verx2_m ***;

		nap1a := MAP(nap_summary = 12 => 12,
								 nap_summary >= 10 => 11,
								 nap_summary >= 2 => 9,
								 nap_summary = 1 => 1,
								 0);

		nas1a := MAP(nas_summary >= 10 => 12,
								 nas_summary in [4,7,9,1] => 9,
								 nas_summary = 0 => 0,
								 2);


		verxn := MAP(nas1a = 12 and nap1a = 12 => 12,
								 (nas1a > 10 or nap1a > 10) and dobver = 1 => 11,
								 nas1a > 10 or nap1a > 10 => 10,
								 (nas1a = 0 and nap1a = 0) or (nas1a=9 and nap1a <= 1) => 0,
								 dobver= 1 => 11,
								 2);

	  verxn2 := MAP(verxn = 0 and fp_prob > 0 => -1,
									fp_prob > 1 => 2,
								  verxn);

		verx2_mn := MAP(verxn2 = -1 => 0.5561497,
										verxn2 = 0 => 0.4959839,
										verxn2 = 2 => 0.5081030,
										verxn2 = 10 => 0.4408316,
										verxn2 = 11 => 0.3272451,
										0.2966102);

		n_att1_1_tmp := -5.910119927
                + derog  * 0.5030169546
                + mult_adl_count_mn  * 3.1564225525
                + num_pos_totc_mn  * 1.8652226354
                + propx_mn  * 3.4535114687
                + age1_bn  * -0.01933369
                + ssn18n  * -0.46774087
                + col_typen  * -1.227153988
                + addpssn_mn  * 2.6400054433
                + verx2_mn  * 2.7157053483
    ;
		 
    n_att1_1 := (exp(n_att1_1_tmp )) / (1+exp(n_att1_1_tmp ));
    phat := n_att1_1;
		
		base := 703;
		odds := 0.047619048;
		point := -40;

		att1n_wrv := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base) +50;

//*** avm_ass ***;

		avm_ass := MAP(add1_avm_automated_valuation = 0 => 1,
									 add1_avm_automated_valuation < 200000 => 0,
									 2);

//*** lres222 ***;

		lres222 := if(add1_lres > 0 or max_lres > 0, 1, 0);


		derog222 := if(derog = 1, 3, fp_prob);

		derog222_m := MAP(derog222 = 0 => 0.4673413063,
											derog222 = 1 => 0.5027027027,
											derog222 = 2 => 0.5306666667,
											0.5372340426);



//*** age1_a ***;

		age1_a := MAP(age1 <= 19 => 0,
								  age1 <= 24 => 1,
								  age1 <= 29 => 2,
								  age1 <= 42 => 3,
								  age1 > 42 => 4,
								  0);



		n_att222_2_tmp := -1.495487652
                       + avm_ass  * -0.242969775
                       + lres222  * -0.57739793
                       + derog222_m  * 4.1956592217
                       + mult_adl_count222  * 0.6079998528
                       + age1_a  * -0.289009284
    ;
		 
		n_att222_2 := (exp(n_att222_2_tmp )) / (1+exp(n_att222_2_tmp ));
    phat222 := n_att222_2;


    att1n_222 := (integer)(point*(log(phat222/(1-phat222)) - log(odds))/log(2) + base)+ 40;

    att_all_scr_tmp := if(~scr222, att1n_wrv, att1n_222);
	 
	 
//**** overrides and caps ****;


    ssndead := if((integer)ssnlength>0 and rc_decsflag=1, 1, 0);
    ssnprior := if(rc_ssndobflag=1 or rc_pwssndobflag='1' or ssnprior_tmp=1, 1, 0);
    criminal_flag := if(criminal_count>0 or criminal_flag_tmp=1, 1, 0);
    corrections := if(rc_hrisksic=2225, 1, 0);

		ver0 := if(fnamepop=0 and lnamepop=0 and addrpop=0 and ssnlength=0 and hphnpop=0, 1, 0);
		
		// CAPS
    att_all_scr_tmp2 := MAP( att_all_scr_tmp < 501 => 501,
												att_all_scr_tmp > 900 => 900,
												ssnprior = 1 and att_all_scr_tmp > 570 => 570,
												criminal_flag = 1 and att_all_scr_tmp > 571 => 571,
												scr222 and att_all_scr_tmp > 621 => 621,
												att_all_scr_tmp);
						
		// OVERRIDES
    att_all_scr := MAP(ssndead=1 => 202,
												corrections=1 => 201,
												ver0 = 1 => 200,
												rv_rc1[1..2] = '19' or rv_rc2[1..2] ='19' or rv_rc3[1..2] = '19'
													or rv_rc4[1..2] = '19' => 203,
												nas_summary <= 4 and nap_summary <= 4 => 203,  		/* New line 3/2/2009 */
												rc_pwssnvalflag in ['1','2','3'] => min(att_all_scr_tmp2, 599), 	/* New line 3/2/2009 */
												att_all_scr_tmp2);												


		rvt803_1_0 := att_all_scr;
		

		self.score := map
		(
			riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
			self.ri[1].hri='35' => '000',
			intformat(rvt803_1_0,3,1)
		);

		self.seq := le.seq;		
		
	
	END;

	final := project(clam, DoModel(left));

	RETURN (final);

END;		