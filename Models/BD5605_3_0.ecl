import Risk_Indicators, RiskWise, Business_Risk;

export BD5605_3_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Business_Risk.Layout_Output) biid, dataset(RiskWise.Layout_BusReasons_Input) orig_input,
			   boolean OFAC, string tribcode='') := 

FUNCTION

bd9605 := Models.BD9605_0_0(clam, biid, orig_input, OFAC, tribcode);


Layout_ModelOut tweak_score(bd9605 le) := TRANSFORM
		
	newscore6 := (real)le.score;
	
	bus_score56 := map(newscore6 >= 669.3 => 50,
				    newscore6 >= 655 => 40, 
				    newscore6 >= 638.5 => 30, 
				    newscore6 >= 605 => 20,
				    10);
	
	self.score := (string)bus_score56;
	
	self := le;
END;
final := project(bd9605, tweak_score(left));

RETURN final;

END;