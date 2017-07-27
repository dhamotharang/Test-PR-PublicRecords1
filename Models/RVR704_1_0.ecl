import risk_indicators;

export RVR704_1_0( grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam,	boolean isCalifornia ) := FUNCTION

rvr611 := Models.RVR611_0_0(clam, isCalifornia );

Models.Layout_ModelOut tweak(clam le, rvr611 ri) := transform
	SELF.seq := le.seq;
	
	rvScore := (integer)ri.score;

	rvr704 := map(
		rvScore = 222                     => 99,
		isCalifornia                      => 90,
		le.ConsumerFlags.security_freeze  => 91,
		le.ConsumerFlags.security_alert   => 92,
		le.ConsumerFlags.id_theft_flag    => 93,
		le.ConsumerFlags.dispute_flag     => 94,
		le.ConsumerFlags.negative_alert   => 95,
		(INTEGER)(rvScore/2 - 150)
	);
	
	SELF.score := (STRING)rvr704;
	SELF.ri := ri.ri;
	self := []; // for validation
end;


final := join(clam, rvr611, left.seq=right.seq, tweak(left,right));

RETURN final;

END;