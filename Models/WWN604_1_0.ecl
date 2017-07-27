import risk_indicators, riskwise;

export WWN604_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true) :=

FUNCTION

tbn509 := Models.TBN509_0_0(clam, OFAC);

// calculate reason codes here for tweak
Risk_Indicators.layout_output into_layout_output(clam le) := transform
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self.nxx_type := le.phone_verification.telcordia_type;
	self := le.iid;
	self := le.shell_input;
	self := le;
	self := [];
end;
iid := project(clam, into_layout_output(left));

ylayout := record
	risk_indicators.Layout_Boca_Shell;
	DATASET(risk_indicators.Layout_Desc) ri;	
end;

// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
boolean IsInstantID := false;
unsigned1 IIDVersion := 0;	// version 0 won't get the updated reason codes for v1
reasoncode_settings := dataset([{IsInstantID, IIDVersion}],riskwise.layouts.reasoncode_settings);
	
ylayout add_reasons(iid le, clam rt) := transform	
	self.ri := Risk_indicators.reasonCodes(le,6,reasoncode_settings); 	
	self.iid.reason1 := self.ri[1].hri;
     self.iid.reason2 := self.ri[2].hri;
     self.iid.reason3 := self.ri[3].hri;
     self.iid.reason4 := self.ri[4].hri;
	self.iid.reason5 := self.ri[5].hri;
     self.iid.reason6 := self.ri[6].hri;
	self := rt;
end;
withRC := join(iid, clam, left.seq=right.seq, add_reasons(left, right));
///////////////////////////////


Models.Layout_ModelOut tweak_score(tbn509 le, withRC rt) := transform
	SELF.seq := le.seq;
	SELF.ri := le.ri;
	
	thindex := (integer)le.score;
	
	verfst_p := if(rt.iid.nap_summary in [2,3,4,8,9,10,12], true, false);
	verlst_p := if(rt.iid.nap_summary in [2,5,7,8,9,11,12], true, false);
	veradd_p := if(rt.iid.nap_summary in [3,5,6,8,10,11,12], true, false);
	
	verfst_s := if(rt.iid.nas_summary in [2,3,4,8,9,10,12], true, false);
	verlst_s := if(rt.iid.nas_summary in [2,5,7,8,9,11,12], true, false);
     veradd_s := if(rt.iid.nas_summary in [3,5,6,8,10,11,12], true, false);
	
	verfirst := if(verfst_p or verfst_s, true, false);
	verlast := if(verlst_p or verlst_s, true, false);
	veraddress := if(veradd_p or veradd_s, true, false);
	verphone := if(rt.iid.nap_summary in [4,6,7,9,10,11,12], true, false);
	verssn := if(rt.iid.nas_summary in [4,6,7,9,10,11,12], true, false);
	
	verify4 := (integer)verlast + (integer)veraddress + (integer)verphone + (integer)verssn;
	
	riskSet := ['07','15','09','10','80','08','16','12','40','14','78','02','03','06','11'];
	risky := veraddress and ~rt.address_verification.input_address_information.isbestmatch;
	RiskAlert := if(rt.iid.reason1 in riskSet or rt.iid.reason2 in riskSet or rt.iid.reason3 in riskSet or rt.iid.reason4 in riskSet or
				 rt.iid.reason5 in riskSet or rt.iid.reason6 in riskSet or risky, true, false);
				 
	phoneSet := ['07','15','09','10','80','08','16'];
	Phoneprob := if(rt.iid.reason1 in phoneSet or rt.iid.reason2 in phoneSet or rt.iid.reason3 in phoneSet or rt.iid.reason4 in phoneSet or
				 rt.iid.reason5 in phoneSet or rt.iid.reason6 in phoneSet, true, false);
				 
	addSet := ['12','40','14','78','11'];
	Addprob := if(rt.iid.reason1 in addSet or rt.iid.reason2 in addSet or rt.iid.reason3 in addSet or rt.iid.reason4 in addSet or
			    rt.iid.reason5 in addSet or rt.iid.reason6 in addSet, true, false);
			    
	Multprob := if(Phoneprob and Addprob, true, false);
	
	IDtheft := map(rt.iid.reason1 in ['38','45','72'] or rt.iid.reason2 in ['38','45','72'] or rt.iid.reason3 in ['38','45','72'] or rt.iid.reason4 in ['38','45','72'] or
											   rt.iid.reason5 in ['38','45','72'] or rt.iid.reason6 in ['38','45','72'] => 1,
				rt.iid.cvi <= 20 and rt.iid.nas_summary in [1,4,7,9] => 1,
				rt.iid.reason1 in ['04','51'] or rt.iid.reason2 in ['04','51'] or rt.iid.reason3 in ['04','51'] or rt.iid.reason4 in ['04','51'] or
										   rt.iid.reason5 in ['04','51'] or rt.iid.reason6 in ['04','51'] => 2,
				0);
				

	WWN604_1_0 := map(rt.iid.reason1 = '29' or rt.iid.reason2 = '29' or rt.iid.reason3 = '29' or rt.iid.reason4 = '29' or rt.iid.reason5 = '29' or rt.iid.reason6 = '29' => 'B1',		   
				   rt.iid.reason1 = '02' or rt.iid.reason2 = '02' or rt.iid.reason3 = '02' or rt.iid.reason4 = '02' or rt.iid.reason5 = '02' or rt.iid.reason6 = '02' => 'F4',
				   rt.iid.reason1 = '03' or rt.iid.reason2 = '03' or rt.iid.reason3 = '03' or rt.iid.reason4 = '03' or rt.iid.reason5 = '03' or rt.iid.reason6 = '03' => 'F5',
				   rt.iid.reason1 = '06' or rt.iid.reason2 = '06' or rt.iid.reason3 = '06' or rt.iid.reason4 = '06' or rt.iid.reason5 = '06' or rt.iid.reason6 = '06' => 'F6',
				   verify4 = 4 AND thindex >= 680 AND ~RiskAlert => 'A1',	
				   verify4 = 4 AND thindex >= 680 AND RiskAlert => 'A2',
				   verify4 = 3 AND ~verphone AND thindex >= 680 AND ~RiskAlert => 'A3',
				   verify4 = 3 AND ~verphone AND thindex >= 680 AND RiskAlert => 'A4',
				   verify4 = 3 AND ~veraddress AND thindex >= 680 AND ~RiskAlert => 'A5',
				   verify4 = 3 AND ~veraddress AND thindex >= 680 AND RiskAlert => 'A6',
				   verssn AND verlast AND idtheft = 2 => 'F2',
				   verssn AND verlast AND idtheft = 1 => 'F1',
				   verssn AND verlast AND ~veraddress AND ~verphone AND multprob => 'E3',
				   verssn AND verlast AND ~veraddress AND ~verphone AND addprob => 'E1',
				   verssn AND verlast AND ~veraddress AND ~verphone AND phoneprob => 'E2',
				   verssn AND verlast AND ~veraddress AND ~verphone => 'D1',
				   rt.iid.reason1 = '31' or rt.iid.reason2 = '31' or rt.iid.reason3 = '31' or rt.iid.reason4 = '31' or rt.iid.reason5 = '31' or rt.iid.reason6 = '31' => 'B2',
				   verify4 = 4 AND ~RiskAlert => 'C1',	
				   verify4 = 4 AND RiskAlert => 'C2',
				   verssn AND ((integer)verlast + (integer)veraddress + (integer)verphone) = 2 => 'C3',
				   ~verssn AND ((integer)verlast + (integer)veraddress + (integer)verphone) = 3 => 'C4',
				   ~verssn AND verlast AND verphone => 'C5',
				   ~verssn AND verlast AND veraddress => 'C6',
				   verify4 = 3 => 'C7',
				   ~verssn AND veraddress AND verphone => 'D2',
				   ~verssn AND veraddress => 'D3',
				   ~verssn AND verphone => 'D4',
				   ~verssn AND verlast => 'D5',
				   verssn AND ~verlast AND veraddress AND ~verphone => 'D6',
				   verssn AND ~verlast AND ~veraddress AND verphone => 'D7',
				   verify4 = 0 AND ~RiskAlert => 'E4',
				   verify4 = 0 AND RiskAlert => 'E5',
				   rt.iid.reason1 = '30' or rt.iid.reason2 = '30' or rt.iid.reason3 = '30' or rt.iid.reason4 = '30' or rt.iid.reason5 = '30' or rt.iid.reason6 = '30' => 'B3',
				   'F7');

	ww := MAP(WWN604_1_0[1] = 'A' and ~rt.address_verification.input_address_information.isbestmatch => 'B4',
			WWN604_1_0[1] <> 'F' and ~rt.address_verification.input_address_information.isbestmatch => 'F9',
			WWN604_1_0);
	
	
	SELF.score := ww;
end;
final := join(tbn509, withRC, left.seq = right.seq, tweak_score(left, right));

RETURN final;

END;