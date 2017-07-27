import risk_indicators;

export AIN602_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true) := function

ain509 := Models.AIN509_0_0(clam, ofac);

Models.Layout_ModelOut tweak_score(ain509 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	Auto_Index509 := (unsigned)le.score;
	
	autoIndexModel_1 := (integer)(0.000550894*(Auto_Index509*Auto_Index509*Auto_Index509) - 1.124386997*(Auto_Index509*Auto_Index509) + 766.9299571*Auto_Index509 -174141.3054174141);
		
	capped_score := map(autoIndexModel_1 > 999 => 999,
					autoIndexModel_1 < 0 => 0,
					autoIndexModel_1);
	SELF.score := (string)capped_score;
end;
final := project(ain509, tweak_score(left));

RETURN final;

END;