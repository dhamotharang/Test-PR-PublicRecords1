import ut, risk_indicators;

export AWD606_8_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION

awd605 := AWD605_0_0(clam, ofac, inCalif);

Layout_ModelOut tweak_score(clam le, awd605 ri) := TRANSFORM
		
	AirWaves_605 := (unsigned)ri.score;
	
	awd606 := - 416557.6071 - 332.2247195 * AirWaves_605 + 0.214465991 * AirWaves_605 * AirWaves_605 - 6.11997E-05 * AirWaves_605 * AirWaves_605 * AirWaves_605
				+ 198798.2711 * log(AirWaves_605);
				
	
	rc3set := [le.iid.reason1, le.iid.reason2, le.iid.reason3, le.iid.reason4, le.iid.reason5, le.iid.reason6];
	ssnprior := if('03' in rc3set, 1, 0);
	
						
	awd606_8 := if(~le.input_validation.address and ~le.input_validation.homephone and le.ssn_verification.validation.valid, ut.imin2(775, awd606), awd606);

	awdScore1 := if(ssnprior = 1 or (~le.ssn_verification.validation.valid and trim(le.shell_input.ssn) <> ''), ut.imin2(630, awd606_8), awd606_8);

	awdScore2 := if(le.address_validation.corrections or le.ssn_verification.validation.deceased, ut.imin2(298, awdScore1), awdScore1);

	awd606_8_0 := map(
					 le.rhode_island_insufficient_verification => 222,
					 awd606 < 250 => 250,
				   awd606 > 999 => 999,
				   (integer)awdScore2);


	self.score := if(ri.score in ['101','102','103','104','105'], ri.score, (string)awd606_8_0);
	
	self := ri;
END;
final := join(clam, awd605, left.seq=right.seq, tweak_score(left,right), left outer);

RETURN final;

END;