import Risk_Indicators, RiskWise, Business_Risk;

export BD5605_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Business_Risk.Layout_Output) biid, dataset(riskwise.Layout_BusReasons_Input) orig_input,
					 boolean OFAC) := 

FUNCTION

bd9605 := Models.BD9605_0_0(clam, biid, orig_input, OFAC);

Models.Layout_ModelOut tweak_score(bd9605 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	newscore6 := (real)le.score;
	
	bus_score56 := map(newscore6 >= 675.8 => '050',
				    newscore6 >= 652.4 => '040', 
				    newscore6 >= 641.9 => '030', 
				    newscore6 >= 633.2 => '020',
				    '010');
	
	SELF.score := bus_score56;
end;
final := project(bd9605, tweak_score(left));

RETURN final;

END;