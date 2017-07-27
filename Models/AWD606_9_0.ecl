import risk_indicators;

export AWD606_9_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION

awd605 := AWD605_0_0(clam, ofac, inCalif);


Layout_ModelOut tweak_score(clam le, awd605 ri) := TRANSFORM
		
	AirWaves_605 := (unsigned)ri.score;
	
	awd606 := - 182470.9705 - 97.42202531 * AirWaves_605 + 0.037559371 * AirWaves_605 * AirWaves_605 - 3.54262E-06 * AirWaves_605 * AirWaves_605 * AirWaves_605
				+ 82292.95214 * log(AirWaves_605);
				

	awd606_9_0 := map(le.ssn_verification.validation.deceased => 201,
				   le.address_validation.corrections => 202,
				   awd606 < 250 => 250,
				   awd606 > 999 => 999,
				   (integer)awd606);


	self.score := if(ri.score in ['101','102','103','104','105'], ri.score, (string)awd606_9_0);
	
	self := ri;
END;
final := join(clam, awd605, left.seq=right.seq, tweak_score(left,right), left outer);

RETURN final;

END;