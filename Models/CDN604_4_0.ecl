import risk_indicators;

export CDN604_4_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, boolean OFAC) := function

cdn604 := CDN604_0_0(clam, ofac);

Layout_ModelOut tweak_score(cdn604 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	cdnscore := (integer)le.score;
	
	cdn := if(cdnscore < 492, 492, cdnscore);

	CDN604_4 := 830.784926178888
				 - 1.01313986933811 * cdn
				 + 0.00103078135009078 * cdn * cdn;


	CDN604_4_0 := MAP(CDN604_4 < 0 => 0,
				   CDN604_4 > 999 => 999,
				   (integer)CDN604_4);

	SELF.score := (string)CDN604_4_0;
end;
final := project(cdn604, tweak_score(left));

RETURN final;

END;