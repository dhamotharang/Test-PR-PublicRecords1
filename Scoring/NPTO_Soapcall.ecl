
import RiskWise;

export NPTO_Soapcall(dataset(layout_NPTO_soapcall) indata, string roxieIP='http://certstagingvip.hpcc.risk.regn.net:9876') := function
	
errx := record
	string errorcode := '';
	RiskWise.Layout_NPTO;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := L;
	self := [];
end;

results := soapcall(indata, roxieIP,
				'RiskWise.RiskWiseMainNPTO', {indata},
				dataset(errx), onfail(err_out(LEFT)));
			
return results;

end;