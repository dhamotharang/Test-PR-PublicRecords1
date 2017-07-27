import ut, risk_indicators;

export AWD606_5_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, unsigned3 history_date, boolean OFAC, boolean inCalif) := 

FUNCTION

awd605 := AWD605_0_0(clam, history_date, ofac, inCalif);


Layout_ModelOut tweak_score(clam le, awd605 ri) := TRANSFORM
		
	AirWaves_605 := (unsigned)ri.score;
	
	awd606 := - 213918.1245 - 145.3732626 * AirWaves_605 + 0.08135088  * AirWaves_605 * AirWaves_605
				- 1.98688E-05 * AirWaves_605 * AirWaves_605 * AirWaves_605 + 99605.12488 * log(AirWaves_605);


	awd606_5 := map(awd606 < 250 => 250,
				 awd606 > 999 => 999,
				 (integer)awd606);
				 
	ver0 := if(le.iid.nap_summary = 0 and le.iid.nas_summary = 0, 1, 0);
	
	rc3set := [le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6];
	ssnprior := if('03' in rc3set, 1, 0);
	
	numsourc := le.name_verification.source_count + le.address_verification.input_address_information.source_count + le.address_verification.address_history_1.source_count +
			  le.address_verification.address_history_2.source_count + le.ssn_verification.header_count;
			  
	numsrc1 := if(numsourc > 9, 9, numsourc);
		
	awd := map(le.ssn_verification.validation.deceased => 202,
			 ssnprior = 1 => 204,	// added as an override on 8/1/2006
			 le.address_validation.corrections => 260,
			 ~le.ssn_verification.validation.valid and trim(le.shell_input.ssn) <> '' => 201,
			 ver0 = 1 => 200,
			 numsrc1 = 0 => if((awd606_5 - 20) > 870, ut.imin2(880, (awd606_5 - 20)), awd606_5),
			 numsrc1 = 2 and awd606_5 > 890 => ut.imin2(900, awd606_5),  
			 numsrc1 = 3 and awd606_5 > 910 => ut.imin2(920, awd606_5),  
			 numsrc1 = 4 and awd606_5 > 930 => ut.imin2(940, awd606_5),  
			 numsrc1 = 5 and awd606_5 > 950 => ut.imin2(960, awd606_5),
			 awd606_5);
	

	// social verification level override

	awd606_5_0 := map(le.iid.nas_summary = 0 and awd > 940 => ut.imin2(950, awd), 
				   le.iid.nas_summary = 1 and awd > 880 => ut.imin2(890, awd),
				   (string)le.iid.nas_summary in ['2','3','4'] and awd > 920 => ut.imin2(930, awd),  
				   le.iid.nas_summary = 5 and awd > 930 => ut.imin2(940, awd),
				   awd);

	// phone verification level override

	awd6 := if(le.iid.nap_summary = 4 and awd606_5_0 > 942, ut.imin2(950, awd606_5_0), awd606_5_0);     

	awd666 := if(~le.ssn_verification.validation.valid and le.shell_input.ssn not in ['999999999','000000000'], ut.imin2(600, awd6), awd6);


	ssnbad := map(le.shell_input.ssn in ['000000000','111111111','222222222','333333333','444444444','555555555','666666666','777777777',
								 '888888888','999999999','123123123','123456789','987654321','010101010','101010101'] or length(trim(le.shell_input.ssn)) <> 9 => 1,
			    le.shell_input.ssn[1..3] = '000' => 2,
			    0);


	vaddist := if(le.address_verification.input_address_information.address_score BETWEEN 81 AND 100, 1, 0);
	vaddcnt := if(le.input_validation.address, 1, 0);
	vadd := ut.max2(vaddist, vaddcnt);

	vlastist := if(le.name_verification.lname_score BETWEEN 81 AND 100, 1, 0);
	vlastcnt := if(le.input_validation.lastname, 1, 0);
	vlast := ut.max2(vlastist, vlastcnt);

	vfrstist := if(le.name_verification.fname_score BETWEEN 81 AND 100, 1, 0);
	vfrstcnt := if(le.input_validation.firstname, 1, 0);
	vfrst := ut.max2(vfrstist, vfrstcnt);

	vphnist := if(le.phone_verification.phone_score BETWEEN 81 AND 100, 1, 0);
	vphncnt := if(le.input_validation.homephone, 1, 0);
	vphn := ut.max2(vphnist, vphncnt);

	score249 := if(ssnbad = 1 or ssnbad = 2 and vfrst = 0 and vlast = 0 and vadd = 1 and vphn = 1, 1, 0); 

	awdScore := if(awd666 > 500 and score249 = 1, 250, awd666);


	score840 := if(ssnbad = 1 or ssnbad = 2, 1, 0);

	awdScore2 := if(awdScore > 840 and score840 = 1, 840, awdScore);

	
	awdScore4 := map(awdScore2 > 999 => 999,
				  awdScore2 < 0 => 0,
				  (integer)awdScore2);



	self.score := if(ri.score in ['101','102','103','104','105'], ri.score, (string)awdScore4);
	
	self := ri;
END;
final := join(clam, awd605, left.seq=right.seq, tweak_score(left,right), left outer);

RETURN final;

END;