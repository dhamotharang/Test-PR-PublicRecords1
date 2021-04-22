import RiskWise;

export PRIO_Soapcall(dataset(layout_PRIO_soapcall) indata, string roxieIP='http://prdrroxiethorvip.hpcc.risk.regn.net:9876', parallel_threads) := function
	
errx := record
	string errorcode := '';
	RiskWise.Layout_PRIO;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := L;
	self := [];
end;

results := soapcall(indata, roxieIP,
				'RiskWise.RiskWiseMainPRIO', {indata},
				dataset(errx), parallel(parallel_threads), onfail(err_out(LEFT)));
			
return results;

end;
