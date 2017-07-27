import Risk_Indicators, RiskWise, Business_Risk;

export BD5605_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Business_Risk.Layout_Output) biid, dataset(riskwise.Layout_BusReasons_Input) orig_input,
				boolean OFAC, boolean nugen=false, boolean other_watchlists = false) := FUNCTION

// bd9605_0_0 is the generic which returns newscore6 and the business reason codes.  the clones are just tweaks to that score
bd9605 := Models.BD9605_0_0(clam, biid, orig_input, OFAC, '', nugen, other_watchlists);

Models.Layout_ModelOut tweak_score(bd9605 le) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	newscore6 := ROUND((real)le.score);
	
	bus_score56 := map(newscore6 > 688 => 50,
				    newscore6 > 672 => 40, 
				    newscore6 > 648 => 30, 
				    newscore6 > 627 => 20,
				    10);

	SELF.score := (string)bus_score56;
end;
final := project(bd9605, tweak_score(left));

RETURN final;

END;