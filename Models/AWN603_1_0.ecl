import risk_indicators;

export AWN603_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam,  boolean OFAC=true) := function

awn510 := Models.AWN510_0_0(clam, ofac);

Models.Layout_ModelOut tweak_score(awn510 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	AirWaves_510 := (unsigned)le.score;
	
	scale1 := -2481.315167 
              + 6.91607 * 0.000001 * AirWaves_510 * AirWaves_510 * AirWaves_510
              - 0.015879584 * AirWaves_510 * AirWaves_510
              + 12.48056004 * AirWaves_510;

	air42 := map(scale1 >= 949 => scale1,
			   scale1 >= 882 => 949 - ((2.24) * (949 - scale1)),
			   scale1 >= 807 => 799 - ((2.67) * (881 - scale1)),
			   599 - (807 - scale1));

	diff := abs((750.0 - air42)) / 60.0 ;
	
	air44 := if(air42 < 750, (integer)(750 - 700 * ( diff / (1 + diff)  )), (integer)air42);
		
	capped_score := map(air44 > 999 => 999,
					air44 < 100 => 100,
					air44);
	SELF.score := (string)capped_score;
end;

final := project(awn510, tweak_score(left));

RETURN final;

END;