import risk_indicators;

export AWD606_10_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION

awd605 := AWD605_0_0(clam, ofac, inCalif);


Layout_ModelOut tweak_score(awd605 le) := TRANSFORM
		
	AirWaves_605 := (unsigned)le.score;
	
	awd606 := - 72424.57689 - 57.33164451 * AirWaves_605 + 0.037105511 * AirWaves_605 * AirWaves_605 - 1.05329E-05 * AirWaves_605 * AirWaves_605 * AirWaves_605
				+ 34728.51467 * log(AirWaves_605);


	awd606_10_0 := map(awd606 < 250 => 250,
				    awd606 > 999 => 999,
				    round(awd606));


	self.score := if(le.score in ['101','102','103','104','105'], le.score, (string)awd606_10_0);
	
	self := le;
END;
final := project(awd605, tweak_score(left));

RETURN final;

END;