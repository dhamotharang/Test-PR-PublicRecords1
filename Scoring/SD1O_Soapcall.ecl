import RiskWise;

export SD1O_Soapcall(dataset(layout_SD1O_soapcall) indata, string roxieIP='http://certstagingvip.hpcc.risk.regn.net:9876', boolean isFCRA=false) := function
	
errx := record
	string errorcode := '';
	RiskWise.Layout_SD1O;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := L;
	self := [];
end;

servicename := if(isFCRA, 'RiskWiseFCRA.RiskWiseMainSD1O', 'RiskWise.RiskWiseMainSD1O');

results := soapcall(indata, roxieIP,
				servicename, {indata},
				dataset(errx), onfail(err_out(LEFT)));
			
return results;

end;