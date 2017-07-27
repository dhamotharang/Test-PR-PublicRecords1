import risk_indicators;

export FD9603_4_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true) :=

FUNCTION

fd3510 := Models.FD3510_0_0(clam, OFAC);

Models.Layout_ModelOut tweak_score(fd3510 le) := transform
	SELF.seq := le.seq;
	
	Fraud_Score_510 := (integer)le.score;
	
	FD9603_4_0 := MAP(Fraud_Score_510 < 562 => '010',       
				   Fraud_Score_510 < 607 => '020',      
				   Fraud_Score_510 < 613 => '030',      
				   Fraud_Score_510 < 633 => '040',  
				   Fraud_Score_510 < 647 => '050',      
				   Fraud_Score_510 < 648 => '060',      
				   Fraud_Score_510 < 663 => '070', 
				   Fraud_Score_510 < 680 => '080',              
				   '090');
	
	SELF.score := FD9603_4_0;
	
	reasons := le.ri;
	reason34 := DATASET([{'34',risk_indicators.getHRIDesc('34')},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc);
	SELF.ri := if((integer)FD9603_4_0 <= 30 and reasons[1].hri='00', reason34, reasons);
end;
final := project(fd3510, tweak_score(left));

RETURN final;

END;