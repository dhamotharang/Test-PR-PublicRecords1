import risk_indicators;

export AIN605_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC) := function

ain509 := Models.AIN509_0_0(clam, ofac, false);		// this model does not use the tweak

Models.Layout_ModelOut tweak_score(ain509 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	Auto_Index509 := (unsigned)le.score;
	
	AIN605_1_0_pre_cap := map(Auto_Index509 > 775 => 766,
				   Auto_Index509 < 270 => 485,
				   (integer)(708.267 + -1.93728*Auto_Index509 + 0.00494277*Auto_Index509*Auto_Index509 + -0.00000302759*Auto_Index509*Auto_Index509*Auto_Index509));	


	// Score Cap change - Bug 36144
	AIN605_1_0 := map(AIN605_1_0_pre_cap < 250 => 250,
			 AIN605_1_0_pre_cap > 999 => 999,
			 AIN605_1_0_pre_cap);	

	SELF.score := (string)AIN605_1_0;
end;
final := project(ain509, tweak_score(left));

RETURN final;

END;