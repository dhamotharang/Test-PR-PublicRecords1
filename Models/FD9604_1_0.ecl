import risk_indicators;

export FD9604_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true) :=

FUNCTION

fd3510 := Models.FD3510_0_0(clam, OFAC);

Models.Layout_ModelOut tweak_score(fd3510 le, clam rt) := transform
	SELF.seq := le.seq;
	
	Fraud_Score_510 := (integer)le.score;
	
	fdscore := MAP(rt.ssn_verification.validation.deceased => 10,
				rt.address_validation.corrections or rt.phone_verification.corrections => 20,
				Fraud_Score_510 < 589 => 10,
				Fraud_Score_510 < 603 => 20,
				Fraud_Score_510 < 618 => 30,
				Fraud_Score_510 < 625 => 40,
				Fraud_Score_510 < 635 => 50,
				Fraud_Score_510 < 641 => 60,
				Fraud_Score_510 < 649 => 70,
				Fraud_Score_510 < 663 => 80,
				90);
	
	SELF.score := (string)fdscore;
	
	reasons := le.ri;
	reason34 := DATASET([{'34',risk_indicators.getHRIDesc('34')},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc);
	SELF.ri := if((integer)fdscore <= 30 and reasons[1].hri='00', reason34, reasons);
end;
final := join(fd3510, clam, left.seq = right.seq, tweak_score(left, right));

RETURN final;

END;