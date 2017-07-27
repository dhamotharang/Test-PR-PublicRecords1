import risk_indicators;

export CDN604_3_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, boolean OFAC) := function

cdn604 := CDN604_0_0(clam, ofac);

Layout_ModelOut tweak_score(cdn604 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	cdnscore := (integer)le.score;
	
	CDN604_3_0 := map(cdnscore <= 654 => 10,
				   cdnscore <= 676 => 20,
				   cdnscore <= 735 => 30,
				   cdnscore <= 771 => 40,
				   cdnscore <= 790 => 50,
				   cdnscore <= 801 => 60,
				   cdnscore <= 836 => 70,
				   cdnscore <= 854 => 80,
				   90);

	SELF.score := (string)CDN604_3_0;
end;
final := project(cdn604, tweak_score(left));

RETURN final;

END;