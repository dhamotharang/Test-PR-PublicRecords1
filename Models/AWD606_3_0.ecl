import risk_indicators;

export AWD606_3_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION

awd605 := AWD605_0_0(clam, ofac, inCalif);


Layout_ModelOut tweak_score(clam le, awd605 ri) := TRANSFORM
		
	AirWaves_605 := (unsigned)ri.score;
	
	awd606_3 := - 321487.8799 - 233.4328891 * AirWaves_605 + 0.138287284 * AirWaves_605 * AirWaves_605
				- 3.60412E-05 * AirWaves_605 * AirWaves_605 * AirWaves_605 + 151225.0979 * log(AirWaves_605);	// check the log10 here

	ver0 := if(~le.input_validation.firstname and ~le.input_validation.lastname and ~le.input_validation.address and ~le.input_validation.ssn
				and ~le.input_validation.homephone, 1, 0);

	awd606_3_0 := map(le.ssn_verification.validation.deceased => 202,
				   le.address_validation.corrections => 201,
				   ver0 = 1 => 200,
				   awd606_3 < 250 => 250,
				   awd606_3 > 999 => 999,
				   (integer)awd606_3);


	self.score := if(ri.score in ['101','102','103','104','105'], ri.score, (string)awd606_3_0);
	
	self := ri;
END;
final := join(clam, awd605, left.seq=right.seq, tweak_score(left,right), left outer);

RETURN final;

END;