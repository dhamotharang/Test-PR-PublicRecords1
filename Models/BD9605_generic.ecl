import Risk_Indicators, RiskWise, Business_Risk;

export BD9605_generic(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Business_Risk.Layout_Output) biid, dataset(riskwise.Layout_BusReasons_Input) orig_input,
				boolean OFAC, boolean nugen=false, boolean other_watchlists = false) := FUNCTION

// bd9605_0_0 is the base logic which returns newscore6 and the business reason codes.  the clones are just tweaks to that score
bd9605 := Models.BD9605_0_0(clam, biid, orig_input, OFAC, '', nugen, other_watchlists);

Models.Layout_ModelOut tweak_score(bd9605 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	newscore6 := ROUND((real)le.score);
	
//******************************************************************************************;
//* output nine bins digits ====> bus_score96 *;
//******************************************************************************************;
	bus_score96 := map(newscore6 > 688 => 90, 
				    newscore6 > 672 => 80, 
				    newscore6 > 661 => 70, 
				    newscore6 > 651 => 60, 
				    newscore6 > 647 => 50, 
				    newscore6 > 643 => 40, 
				    newscore6 > 638 => 30, 
				    newscore6 > 627 => 20, 
				    10);

	SELF.score := intformat(bus_score96,3,1);
end;

final := project(bd9605, tweak_score(left));

RETURN final;

END;
