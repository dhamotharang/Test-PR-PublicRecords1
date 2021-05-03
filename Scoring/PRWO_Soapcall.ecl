import RiskWise;

export PRWO_Soapcall(dataset(layout_PRWO_soapcall) indata, string roxieIP='http://certstagingvip.hpcc.risk.regn.net:9876', boolean isFCRA=false) := function
	
errx := record
	string errorcode := '';
	RiskWise.Layout_PRWO;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := L;
	self := [];
end;

servicename := if(isFCRA, 'RiskWiseFCRA.RiskWiseMainPRWO', 'RiskWise.RiskWiseMainPRWO');

results := soapcall(indata, roxieIP,
				servicename, {indata},
				dataset(errx), onfail(err_out(LEFT)));
			
return results;

end;