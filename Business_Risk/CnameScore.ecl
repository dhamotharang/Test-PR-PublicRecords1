// Takes in 2 company names and returns a score
// to maximize verification rates, added bridgerscorelib score
// didn't completely replace companysimilar because there were 
// instances where companysimilar passed the name and bridgerlib didn't
import ut, risk_indicators;

export CnameScore(string c, string c2) := function
	
	cscore := 100 - (ut.CompanySimilar100(c, c2, true));
	bridgerscore := (integer)(100*(bridgerscorelib.companyScore(c, c2)) );
	
	// if score passes already, don't bother calling bridgerscore
	score_enhanced := if(cscore < risk_indicators.iid_constants.min_score, bridgerscore, cscore);
	finalscore := if(c<>'' and c2<>'', score_enhanced, 255);

	return finalscore;
	
end;
	
