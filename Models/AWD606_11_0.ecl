import risk_indicators;

export AWD606_11_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := FUNCTION

returnPHAT := true;

awd605 := AWD605_0_0(clam, ofac, inCalif, returnPHAT);

Layout_ModelOut tweak_score(clam le, awd605 ri) := TRANSFORM
			
	phat := (real)ri.score;
	
	score_temp := 1000-round(phat*1000);														 
	
	AWD606 := 626 + score_temp
			* -0.205481 + score_temp * score_temp * 0.000222;		 

	awd606_11_0 := map(awd606 < 250 => 250,
				    awd606 > 999 => 999,
				    round(awd606));
				    
	self.score := if(ri.score in ['101','102','103','104','105'], ri.score, (string)awd606_11_0);
	
	self := ri;
END;
final := join(clam, awd605, left.seq=right.seq, tweak_score(left, right), left outer);

RETURN final;

END;