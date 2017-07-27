import risk_indicators;

export FD5603_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam,  
				boolean OFAC=true, boolean isFCRA=false, boolean inCalif=false, boolean fdReasonsWith38=false) := FUNCTION
								
fd3510 := Models.FD3510_0_0(clam, OFAC, isFCRA, inCalif, fdReasonsWith38);

Models.Layout_ModelOut tweak_score(fd3510 le) := transform
	SELF.seq := le.seq;

	Fraud_Score_510 := (integer)le.score;
	
	FD5603_2_0 := MAP(Fraud_Score_510 < 598 => '010',
				   Fraud_Score_510 < 630 => '020',
				   Fraud_Score_510 < 645 => '030',
				   Fraud_Score_510 < 675 => '040',
				   '050');
	
	SELF.score := FD5603_2_0;
	
	reasons := le.ri;
	reason34 := DATASET([{'34',risk_indicators.getHRIDesc('34')},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc);
	SELF.ri := if((integer)FD5603_2_0 <= 30 and reasons[1].hri='00', reason34, reasons); 
end;
final := project(fd3510, tweak_score(left));

RETURN final;

END;