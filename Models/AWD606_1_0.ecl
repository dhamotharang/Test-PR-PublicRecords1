import risk_indicators;

export AWD606_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) inputclam, boolean OFAC, boolean inCalif, boolean ex14=false) := 

FUNCTION

//checks the conditions for the new Rhode Island legislation, sets the security freeze flag to true
clam := project(inputclam, 
		transform(risk_indicators.Layout_Boca_Shell, 			
			self.consumerflags.security_freeze := if(left.rhode_island_insufficient_verification and ex14, true, left.consumerflags.security_freeze);
			self := left));

awd605 := AWD605_0_0(clam, ofac, inCalif);


Layout_ModelOut tweak_score(awd605 le) := TRANSFORM
		
	AirWaves_605 := (unsigned)le.score;
	
	awd606 := 299724.7196 + 1265.36553  * AirWaves_605 - 0.577287623 * AirWaves_605 * AirWaves_605
				+ 0.000154834 * AirWaves_605 * AirWaves_605 * AirWaves_605 - 36096.97422 * sqrt(AirWaves_605);

	awd606_1 := (integer)(awd606);

	awd606_1_0 := map(awd606_1 < 250=> 250,
				   awd606_1 > 999 => 999,
				   awd606_1);


	self.score := if(le.score in ['101','102','103','104','105'], le.score, (string)awd606_1_0);
	
	self := le;
END;
final := project(awd605, tweak_score(left));

RETURN final;

END;