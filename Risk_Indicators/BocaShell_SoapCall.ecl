/*2008-03-06T14:56:34Z (Todd  Steil_Prod)

*/
import riskwise;

export BocaShell_SoapCall(dataset(Layout_InstID_SoapCall) indataset, string roxieIP='http://certstagingvip.hpcc.risk.regn.net:9876', integer thread_count=1)  := function

dist_dataset := DISTRIBUTE(indataset, RANDOM());

xlayout := RECORD
	risk_indicators.Layout_Boca_Shell;
	STRING200 errorcode;
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
				PARALLEL(thread_count), onFail(myFail(LEFT)));
return resu;

	
end;


