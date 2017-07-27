import risk_indicators;

export CDN605_1_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, boolean OFAC, boolean useBillTo) := function

cdn604 := CDN604_0_0(clam, ofac, useBillTo);

Layout_ModelOut tweak_score(cdn604 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	cdnscore := (integer)le.score;
	
	CDN605_1_0 := map(cdnscore <= 655 => '010',
				   cdnscore <= 691 => '020',
				   cdnscore <= 726 => '030',
				   cdnscore <= 740 => '040',
				   '050');

	SELF.score := CDN605_1_0;
end;
final := project(cdn604, tweak_score(left));

RETURN final;

END;