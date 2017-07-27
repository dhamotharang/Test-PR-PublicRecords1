import risk_indicators;

export TBN604_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC) :=

FUNCTION

tbn509 := Models.TBN509_0_0(clam, OFAC);

Models.Layout_ModelOut tweak_score(tbn509 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	thindex := (integer)le.score;
	
	TBN604 := -1899.33341
                + 2.621024591 * thindex
                + 0.006625695 * thindex * thindex
                + -1 * 7.20897 * 0.000001 * thindex * thindex * thindex;

    TBN604_1 := round(TBN604);
    
    TBN604_1_0 := MAP(TBN604_1 > 999 => 999,
				  TBN604_1 < 0 => 0,
				  TBN604_1);
	
	SELF.score := (string)TBN604_1_0;
end;
final := PROJECT(tbn509, tweak_score(left));

RETURN final;

END;