EXPORT AMEX_SoapCall (dataset (AMEX.layouts.Layout_amex_addtional_SoapCall) indataset, 
                                string service_name, string service_url,
                                const unsigned1 call_number = 1)  := FUNCTION

dist_dataset := DISTRIBUTE (indataset, RANDOM());

AMEX.layouts.outputProc2 myFail(dist_dataset le) :=
TRANSFORM
	SELF.errorcode := FAILCODE + ' ' + FAILMESSAGE;
	SELF.account := le.Account;
	SELF := [];
END;

result := SOAPCALL (dist_dataset, service_url, 
                    service_name, {dist_dataset}, 
                    DATASET (AMEX.layouts.outputProc2),
                    PARALLEL (call_number), onFail(myFail (Left)));

RETURN result;
	
END;