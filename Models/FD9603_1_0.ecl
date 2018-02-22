import risk_indicators, ut, std;

export FD9603_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true) :=

FUNCTION

fd3510 := Models.FD3510_0_0(clam, OFAC);

Models.Layout_ModelOut tweak_score(fd3510 le, clam rt) := transform
	SELF.seq := le.seq;
	
	Fraud_Score_510 := (integer)le.score;
	
	fdscore := MAP(Fraud_Score_510 <= 579 => 10,
				Fraud_Score_510 <= 584 => 20,
				Fraud_Score_510 <= 637 => 30,
				Fraud_Score_510 <= 641 => 40,
				Fraud_Score_510 <= 664 => 50,
				60);
				   
	
	hr_phone_n := (integer)rt.phone_verification.hr_phone;			   
	phone_zip_mismatch_n := (integer)rt.phone_verification.phone_zip_mismatch;
     disconnected_n := (integer)rt.phone_verification.disconnected;
     standardization_error := if(~(rt.address_validation.usps_deliverable) and ~(rt.address_verification.input_address_information.isbestmatch), 1, 0);			   
	ssninval := if(~rt.ssn_verification.validation.valid, 1,0);
	ssndead := (integer)rt.ssn_verification.validation.deceased;
	
	sysyear := IF(rt.historydate <> 999999, (integer)(((string)rt.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]));
	high_issue_dateyr := (integer)(((STRING)rt.ssn_verification.validation.high_issue_date)[1..4]);
     ssnage := sysyear - high_issue_dateyr;
	ssnprior_fa := if(ssnage <= 16, 1,0);
	
	hr_address_n := (integer)rt.address_validation.hr_address;
	bankrupt := (integer)rt.bjl.bankrupt;
				   
	fpcount := (hr_phone_n + phone_zip_mismatch_n + disconnected_n + standardization_error + ssninval + ssndead + ssnprior_fa + hr_address_n + bankrupt);

     phn_not_ver := if(rt.iid.nap_summary in [0,1], true, false);

     fdscore2 := if(rt.iid.nas_summary = 1, fdscore + 5, fdscore);
	
	pnotpots := if(rt.phone_verification.telcordia_type in ['00','50','51','52','54'], false, true);

     FD9603_1_0 := if(fdscore2 >= 40 and phn_not_ver and fpcount > 0,
				  MAP(pnotpots => 32,
					 phone_zip_mismatch_n = 1 or rt.iid.nas_summary = 1 => 31,
					 fdscore2),
				  fdscore2);
	
	SELF.score := (string)FD9603_1_0;
	
	reasons := le.ri;
	reason34 := DATASET([{'34',risk_indicators.getHRIDesc('34')},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc);
	SELF.ri := if((integer)FD9603_1_0 <= 30 and reasons[1].hri='00', reason34, reasons); 
end;
final := join(fd3510, clam, left.seq = right.seq, tweak_score(left, right));

RETURN final;

END;