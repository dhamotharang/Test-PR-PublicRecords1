import risk_indicators, easi;

export FD5606_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(easi.layout_census) easi_census, unsigned3 history_date=999999, 
			  boolean OFAC=true, boolean isFCRA=false, boolean inCalif=false, boolean fdReasonsWith38=false, boolean nugen=false) := FUNCTION

fd3606 := Models.FD3606_0_0(clam, easi_census, history_date, OFAC, isFCRA, inCalif, fdReasonsWith38, nugen);

Models.Layout_ModelOut tweak_score(fd3606 le) := transform
	SELF.seq := le.seq;
	
	Fraud_Score_606 := (integer)le.score;
	
	FD5606_0_0 := map(
		Fraud_Score_606 <= 605 => '10',
		Fraud_Score_606 <= 624 => '20',
		Fraud_Score_606 <= 641 => '30',
		Fraud_Score_606 <= 679 => '40',
		'50'
	);


	SELF.score := FD5606_0_0;
	SELF.ri := le.ri;
	self := []; // for validation
end;
final := project(fd3606, tweak_score(left));

RETURN final;

END;