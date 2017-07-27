import risk_indicators;

export FD9603_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true) :=

FUNCTION

fd3510 := Models.FD3510_0_0(clam, OFAC);

Models.Layout_ModelOut tweak_score(fd3510 le, clam rt) := transform
	SELF.seq := le.seq;
	
	Fraud_Score_510 := (integer)le.score;

	fdscore := MAP(Fraud_Score_510 < 562 => 10,       
				Fraud_Score_510 < 565 => 20,      
				Fraud_Score_510 < 581 => 30,      
				Fraud_Score_510 < 588 => 40,      
				Fraud_Score_510 < 598 => 50,      
				Fraud_Score_510 < 609 => 60,      
				Fraud_Score_510 < 624 => 70,      
				Fraud_Score_510 < 639 => 80,      
				90);


/* override code starts here */
     verfst_p := if(rt.iid.nap_summary in [2,3,4,8,9,10,12], 1,0);
	verlst_p := if(rt.iid.nap_summary in [2,5,7,8,9,11,12], 1,0);
     veradd_p := if(rt.iid.nap_summary in [3,5,6,8,10,11,12], 1,0);
	verphn_p := if(rt.iid.nap_summary in [4,6,7,9,10,11,12], 1,0);

     verfst_s := if(rt.iid.nas_summary in [2,3,4,8,9,10,12], 1,0);
	verlst_s := if(rt.iid.nas_summary in [2,5,7,8,9,11,12], 1,0);
     veradd_s := if(rt.iid.nas_summary in [3,5,6,8,10,11,12], 1,0);
	verssn_s := if(rt.iid.nas_summary in [4,6,7,9,10,11,12], 1,0);

     verlst := if(verlst_p + verlst_s > 0, 1,0);
     veradd := if(veradd_p + veradd_s > 0, 1,0);

     verify4 := verlst + veradd + verssn_s + verphn_p;
	
	ssndead := rt.ssn_verification.validation.deceased;
     
	FD9603_2_0 := if(verify4 = 0 or ssndead, 35, fdscore);

	SELF.score := (string)FD9603_2_0;
	
	reasons := le.ri;
	reason34 := DATASET([{'34',risk_indicators.getHRIDesc('34')},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc);
	SELF.ri := if((integer)FD9603_2_0 <= 30 and reasons[1].hri='00', reason34, reasons); 
end;
final := join(fd3510, clam, left.seq = right.seq, tweak_score(left, right));

RETURN final;

END;