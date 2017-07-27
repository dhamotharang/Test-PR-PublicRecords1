import risk_indicators;

export AWD606_4_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION

awd605 := AWD605_0_0(clam, ofac, inCalif);


Layout_ModelOut tweak_score(awd605 le) := TRANSFORM
		
	AirWaves_605 := (unsigned)le.score;
	
	awd606_4 := (integer)(297693.8131  
				+ 270.8411022 * AirWaves_605 - 0.189990533 * AirWaves_605 * AirWaves_605 + 5.85394E-05 * AirWaves_605 * AirWaves_605 * AirWaves_605 - 145403.5724 * log(AirWaves_605));

	awd606_4_0 := map(awd606_4 < 250 => 250,
				   awd606_4 > 999 => 999,
				   (integer)awd606_4);


	self.score := if(le.score in ['101','102','103','104','105'], le.score, (string)awd606_4_0);
	
	self := le;
END;
final := project(awd605, tweak_score(left));

RETURN final;

END;