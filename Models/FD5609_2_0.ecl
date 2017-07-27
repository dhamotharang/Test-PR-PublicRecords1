import risk_indicators;

export FD5609_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, 
				boolean OFAC=true, boolean isFCRA=false, boolean inCalif=false, boolean fdReasonsWith38=false) := FUNCTION
								
fd3510 := Models.FD3510_0_0(clam, OFAC, isFCRA, inCalif, fdReasonsWith38);

Models.Layout_ModelOut tweak_score(fd3510 le) := transform
	SELF.seq := le.seq;
	
	Fraud_Score_510 := (integer)le.score;
	
	FD560920 := MAP(Fraud_Score_510 < 596 => '010',
				   Fraud_Score_510 < 624 => '020',
				   Fraud_Score_510 < 652 => '030',
				   Fraud_Score_510 < 677 => '040',
				   '050');
	
	SELF.score := FD560920;
	reasons := le.ri;
	reason34 := DATASET([{'34',risk_indicators.getHRIDesc('34')},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc);
	SELF.ri := if((integer)FD560920 <= 30 and reasons[1].hri='00', reason34, reasons); 
end;
final := project(fd3510, tweak_score(left));

RETURN final;

END;