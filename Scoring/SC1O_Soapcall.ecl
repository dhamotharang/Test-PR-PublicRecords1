import RiskWise;

export SC1O_Soapcall(dataset(layout_SC1O_soapcall) indata, string roxieIP='http://certstagingvip.hpcc.risk.regn.net:9876') := function
	
errx := record
	string errorcode := '';
	RiskWise.Layout_SC1O;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := L;
	self := [];
end;

results := soapcall(indata, roxieIP,
				'RiskWise.RiskWiseMainSC1O', {indata},
				dataset(errx), onfail(err_out(LEFT)));
			
return results;

end;