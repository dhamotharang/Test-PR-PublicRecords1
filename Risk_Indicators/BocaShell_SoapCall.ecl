export BocaShell_SoapCall(dataset(Layout_InstID_SoapCall) indataset, string roxieIP='http://roxiestaging.br.seisint.com:9876')  := function

dist_dataset := DISTRIBUTE(indataset, RANDOM());

xlayout := RECORD
	risk_indicators.Layout_Boca_Shell;
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) :=
TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.seq := (unsigned)le.AccountNumber;
	SELF := [];
END;

// Dayton 80 way				
resu := soapcall(dist_dataset, roxieIP, 
				'risk_indicators.Boca_Shell', {dist_dataset}, 
				DATASET(xlayout),
				PARALLEL(2), onFail(myFail(LEFT)));

layout_output into_layout_output(resu le) := transform
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self := le.iid;
	self := le.shell_input;
	self := [];
end;

iid := project(resu, into_layout_output(left));

ylayout := record
	risk_indicators.Layout_Boca_Shell_Edina;
	DATASET(risk_indicators.Layout_Desc) ri;	
	string errorcode;
end;

// JRP 02/12/2008 - Dataset of actioncode and reasoncode settings which are passed to the getactioncodes and reasoncodes functions.
boolean IsInstantID := false;
reasoncode_settings := dataset([{IsInstantID}],riskwise.layouts.reasoncode_settings);	
	
ylayout add_reasons(iid le, resu rt) := transform	
	self.ri := Risk_indicators.reasonCodes(le,6,reasoncode_settings); 	
	self.iid.reason1 := self.ri[1].hri;
     self.iid.reason2 := self.ri[2].hri;
     self.iid.reason3 := self.ri[3].hri;
     self.iid.reason4 := self.ri[4].hri;
	self.iid.reason5 := self.ri[5].hri;
     self.iid.reason6 := self.ri[6].hri;
	self := rt;
end;

final := join(iid, resu, left.seq=right.seq, add_reasons(left, right));

return final;
	
end;


