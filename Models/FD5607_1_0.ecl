import risk_indicators;

export FD5607_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean isFCRA=false, boolean inCalif=false) :=

FUNCTION

fd3510 := FD3510_0_0(clam, OFAC, isFCRA, inCalif);

Layout_ModelOut tweak_score(fd3510 le) := TRANSFORM
		
	Fraud_Score_510 := (integer)le.score;
	
	FD5603_1_0 := MAP(Fraud_Score_510 <= 597 => '010',
				   Fraud_Score_510 <= 630 => '020',
				   Fraud_Score_510 <= 644 => '030',
				   Fraud_Score_510 <= 676 => '040',
				   '050');
	
	self.score := if(le.score in ['101','102','103','104','105'], le.score, FD5603_1_0);
	
	reasons := le.ri;
	reason34 := DATASET([{'34',risk_indicators.getHRIDesc('34')},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc);
	SELF.ri := if((integer)FD5603_1_0 <= 30 and reasons[1].hri='00', reason34, reasons); 
	self := le;
END;
final := project(fd3510, tweak_score(left));

RETURN final;

END;