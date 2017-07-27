import risk_indicators;

export AWD710_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif ) := 

// this model is awd606_1_0 but with a 222 override.

FUNCTION

awd606 := AWD606_1_0(clam, ofac, inCalif);


Layout_ModelOut tweak_score(clam le, awd606 ri) := TRANSFORM
	override222 := (le.iid.nas_summary < 5 and le.iid.nap_summary < 5 and le.address_verification.input_address_information.naprop < 3);

	ri_score := (integer)ri.score;
	self.score := if( ri_score != 0 and ri_score not between 101 and 105 and override222, '222', ri.score );
	self := ri;
END;

final := join(clam, awd606, left.seq=right.seq, tweak_score(left,right), left outer);

RETURN final;

END;