import risk_indicators;

export AWD606_6_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := FUNCTION

returnPHAT := true;

awd605 := AWD605_0_0(clam, ofac, inCalif, returnPHAT);

Layout_ModelOut tweak_score(clam le, awd605 ri) := TRANSFORM
		
	phat := (real)ri.score;
	
	score_temp := 1000-round(phat*1000);														 
	
	AWD606 := 607.67039 + score_temp
			* -1.08871 + score_temp
			* score_temp * 0.00150;		 

	awd606_6_0 := map(awd606 < 250 => 250,
				    awd606 > 999 => 999,
				    round(awd606));
				    
	awd606_6_override := map(le.ssn_verification.validation.deceased => 200,
						~le.ssn_verification.validation.valid and trim(le.shell_input.ssn) <> '' => 201,
						awd606_6_0);

	self.score := if(ri.score in ['101','102','103','104','105'], ri.score, (string)awd606_6_override);
	
	self := ri;
END;
final := join(clam, awd605, left.seq=right.seq, tweak_score(left,right), left outer);

RETURN final;

END;
