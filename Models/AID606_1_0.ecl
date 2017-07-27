import risk_indicators;

export AID606_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION

aid606 := AID606_0_0(clam, ofac, inCalif);


Layout_ModelOut tweak_score(aid606 le) := TRANSFORM
		
	AutoIndex := (unsigned)le.score;
	
	ford := .0000413849664267324*(AutoIndex * AutoIndex * AutoIndex)
			   -  .0998209753006016 * (AutoIndex * AutoIndex)
			   +  81.1732991779467 * (AutoIndex)
			   -  21378.7867572268;

	ford_scr := map(ford < 350 => 350,
				 ford > 900 => 900,
				 (integer)ford);


	self.score := if(le.score in ['101','102','103','104','105'], le.score, (string)ford_scr);
	
	self := le;
END;
final := project(aid606, tweak_score(left));

RETURN final;

END;