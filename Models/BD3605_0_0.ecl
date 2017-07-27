/* Modeling group is calling this model BD3605_0_1 as it is the second version with score caps added. We are keeping the 
		original name BD3605_0_0  */

import Risk_Indicators, RiskWise, Business_Risk;

export BD3605_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Business_Risk.Layout_Output) biid, 
									dataset(riskwise.Layout_BusReasons_Input) orig_input,
									boolean OFAC, boolean nugen=false, boolean other_watchlists = false) := 

FUNCTION

bd9605 := Models.BD9605_0_0(clam, biid, orig_input, OFAC, '', nugen, other_watchlists);

Layout_ModelOut tweak_score(bd9605 le) := transform
	
	bd_score_pre_cap := round((real)le.score);  // this score is the output of bd9605_0_0
	bd_score := MAP(bd_score_pre_cap < 250 => 250,
									bd_score_pre_cap > 999 => 999,
									bd_score_pre_cap);
	
	
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	SELF.score := (string)bd_score;
end;
final := project(bd9605, tweak_score(left));

RETURN final;

END;