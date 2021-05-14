import RiskWise;

export NP2O_Soapcall(dataset(layout_NP2O_soapcall) indata, string roxieIP='http://certstagingvip.hpcc.risk.regn.net:9876') := function
	
errx := record
	string errorcode := '';
	RiskWise.Layout_NP2O;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := L;
	self := [];
end;

results := soapcall(indata, roxieIP,
				'RiskWise.RiskWiseMainNP2O', {indata},
				dataset(errx), onfail(err_out(LEFT)));
			
return results;

end;