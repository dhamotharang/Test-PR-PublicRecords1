import risk_indicators;

export CDN604_2_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam, boolean OFAC) := function

cdn604 := CDN604_0_0(clam, ofac);

Layout_ModelOut tweak_score(cdn604 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	cdnscore := (integer)le.score;
	
	CDN604_0_0 := map(cdnscore < 530 => 530,
				   cdnscore > 934 => 934,
				   cdnscore);

	total_score := 3474.029065
				 - 13.98362117 * CDN604_0_0
				 + 0.020690276 * CDN604_0_0 * CDN604_0_0
				 - 0.0000094226859451324 * CDN604_0_0 * CDN604_0_0 * CDN604_0_0;

	CDN604_2 := map(total_score < 685 => (total_score - 40) * 0.94,
				 total_score < 695 => (total_score - 40) * 0.96,
				 total_score < 700 => (total_score - 40) * 0.98,
				 (total_score - 40));


	CDN604_2_0 := map(CDN604_2 < 0 => 0,
				   CDN604_2 > 999 => 999,
				   (integer)CDN604_2);


	SELF.score := (string)CDN604_2_0;
end;
final := project(cdn604, tweak_score(left));

RETURN final;

END;