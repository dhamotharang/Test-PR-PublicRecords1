import risk_indicators;

export TBD606_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, unsigned3 history_date, boolean OFAC, boolean inCalif) := 

FUNCTION

tbd := TBD605_0_0(clam, history_date, OFAC, inCalif);

Layout_ModelOut tweak_score(clam le, tbd ri) := TRANSFORM
	
	td := (integer)ri.score;
	
	tbd6 := (integer)(-106.088682105 + (1158.588468413 * td/1000));

     tbd606 := map(le.ssn_verification.validation.deceased and tbd6 > 625 => 625,
			    tbd6 > 999 => 999,
			    tbd6 < 0 => 0,
			    tbd6);

	
     self.score := if(ri.score in ['101','102','103','104','105'], ri.score, intformat(tbd606,3,1));
	
	self := ri;
END;
final := join(clam, tbd, left.seq=right.seq, tweak_score(left,right), left outer);

RETURN final;

END;