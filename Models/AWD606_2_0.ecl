import risk_indicators;

export AWD606_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION

awd605 := AWD605_0_0(clam, ofac, inCalif);


Layout_ModelOut tweak_score(awd605 le) := TRANSFORM
		
	AirWaves_605 := (unsigned)le.score;
	
	awd606 := 396132.6605 + 354.4705447 * AirWaves_605 - 0.241154373 * AirWaves_605 * AirWaves_605
				+ 7.14424E-05 * AirWaves_605 * AirWaves_605 * AirWaves_605 - 193278.6825 * log(AirWaves_605);	// check on the log10 here

	awd606_2 := (integer)(awd606);

	awd606_2_0 := map(awd606_2 < 250=> 250,
				   awd606_2 > 999 => 999,
				   awd606_2);


	self.score := if(le.score in ['101','102','103','104','105'], le.score, (string)awd606_2_0);
	
	self := le;
END;
final := project(awd605, tweak_score(left));

RETURN final;

END;