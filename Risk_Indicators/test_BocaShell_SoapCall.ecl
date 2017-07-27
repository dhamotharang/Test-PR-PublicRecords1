EXPORT test_BocaShell_SoapCall (dataset (Layout_InstID_SoapCall) indataset, 
                                string service_name, string service_url,
                                const unsigned1 call_number = 1)  := FUNCTION

boolean use_call_number := (call_number >0) AND (call_number <11);
unsigned1 par_calls := IF (use_call_number, call_number, 1); //not used; see #19389

dist_dataset := DISTRIBUTE (indataset, RANDOM());

xlayout := RECORD
	risk_indicators.Layout_Boca_Shell;
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) :=
TRANSFORM
	SELF.errorcode := FAILCODE + ' ' + FAILMESSAGE;
	SELF.seq := (unsigned)le.AccountNumber;
	SELF := [];
END;

// par_calls not used here, as PARALLEL expects const expr. see bug #19389
result := SOAPCALL (dist_dataset, service_url, 
                    service_name, {dist_dataset}, 
                    DATASET (xlayout),
                    PARALLEL (call_number), onFail(myFail (Left)));


ylayout := record
	risk_indicators.Layout_Boca_Shell;
	string errorcode;
end;
	
ylayout into_edina(result rt) := transform	
	self := rt;
end;

final := project(result, into_edina(left));

RETURN final;
	
END;