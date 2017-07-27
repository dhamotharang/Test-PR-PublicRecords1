import Risk_Indicators, RiskWise, Business_Risk;

export BD9605_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Business_Risk.Layout_Output) biid, dataset(riskwise.Layout_BusReasons_Input) orig_input,
				boolean OFAC) := FUNCTION

// bd9605_0_0 is the generic which returns newscore6 and the business reason codes.  the clones are just tweaks to that score
bd9605 := Models.BD9605_0_0(clam, biid, orig_input, OFAC);

Models.Layout_ModelOut tweak_score(bd9605 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	newscore6 := (real)le.score;
	
//******************************************************************************************;
//* output nine bins digits ====> bus_score96 *;
//******************************************************************************************;
	bus_score96 := map(newscore6 >= 667.5 => 90, 
				    newscore6 >= 654 => 80, 
				    newscore6 >= 649 => 70, 
				    newscore6 >= 638.1 => 60, 
				    newscore6 >= 630 => 50, 
				    newscore6 >= 621.5 => 40, 
				    newscore6 >= 609.5 => 30, 
				    newscore6 >= 600 => 20, 
				    10);

	SELF.score := intformat(bus_score96,3,1);
end;

final := project(bd9605, tweak_score(left));

RETURN final;

END;
