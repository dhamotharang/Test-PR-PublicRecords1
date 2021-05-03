import models;

export ThinDex_Soapcall(dataset(Layout_Thindex_Soapcall) indata, string roxieIP='http://certstagingvip.hpcc.risk.regn.net:9876') := function;
	
errx := record
	string errorcode := '';
	models.Layout_Model;
end;

errx err_out(indata L) := transform
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	self := L;
	self := [];
end;

results := soapcall(indata, roxieIP,
				'Models.ThinDex_Service', {indata},
				dataset(errx), onfail(err_out(LEFT)));
			
return results;

end;