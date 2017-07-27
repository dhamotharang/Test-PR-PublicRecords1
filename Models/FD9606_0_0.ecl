import risk_indicators, easi;

export FD9606_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(easi.layout_census) easi_census,
			  boolean OFAC=true, boolean isFCRA=false, boolean inCalif=false, boolean fdReasonsWith38=false, boolean nugen=false) := FUNCTION

fd3606 := Models.FD3606_0_0(clam, easi_census, OFAC, isFCRA, inCalif, fdReasonsWith38, nugen);

Models.Layout_ModelOut tweak_score(fd3606 le) := transform
	SELF.seq := le.seq;
	
	Fraud_Score_606 := (integer)le.score;
	
	FD9606_0_0 := map(
		Fraud_Score_606 <= 594 => '010',
		Fraud_Score_606 <= 612 => '020',
		Fraud_Score_606 <= 624 => '030',
		Fraud_Score_606 <= 632 => '040',
		Fraud_Score_606 <= 641 => '050',
		Fraud_Score_606 <= 650 => '060',
		Fraud_Score_606 <= 656 => '070',
		Fraud_Score_606 <= 679 => '080',
		'090'
	);

	SELF.score := FD9606_0_0;
	SELF.ri := le.ri;
end;
final := project(fd3606, tweak_score(left));

RETURN final;

END;