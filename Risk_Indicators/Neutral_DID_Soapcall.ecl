import didville, riskwisefcra, doxie, gateway;

export Neutral_DID_Soapcall(DATASET(risk_indicators.layout_input) iid,
								DATASET(Gateway.Layouts.Config) gateways,
								UNSIGNED1	BSversion = 1, UNSIGNED1 append_best, STRING50 DataRestriction, boolean RetainInputDID) := function
								
inrec := record, maxlength(500000)
	dataset(risk_indicators.layout_input) batch_in;
	UNSIGNED1	BSversion;
	UNSIGNED1 Append_Best;
	STRING50	DataRestriction;
	boolean RetainInputDID;
	boolean _Blind := false;
end;
		
foo := dataset([{Project(iid, transform(risk_indicators.Layout_Input, self := left)), BSversion, append_best, DataRestriction, RetainInputDID, Gateway.Configuration.GetBlindOption(gateways)}], inrec);

Risk_Indicators.Layouts.Layout_Neutral_DID_Service errX(foo L) := transform
	self.errmsg := ERROR (FAILCODE, 'Neutral DID Service: ' + FAILMESSAGE);
	SELF.seq := L.batch_in[1].seq; 
	self := [];
end;

gateway_check := gateways(servicename IN riskwisefcra.Neutral_Service_Name)[1].url;
gateway_url := IF(gateway_check='',ERROR(301,doxie.ErrorCodes(301)),gateway_check);


soap_response := soapcall(foo, gateway_url, 'Risk_Indicators.Neutral_DID_Service',
		 		 inrec, transform(inrec, self := left), 
			 	 dataset(Risk_Indicators.Layouts.Layout_Neutral_DID_Service),
			 	 parallel(3), merge(33), // pass multiple records at 1 time
				 onFail(errX(LEFT)),
				 timeout(600));	// changed the timeout		


/*
// add error handling for dropped records in neutral_DID_service
// this error on the neutral roxie "EXCEPTION: Too many active queries" is not returning in the soapcall as a roxie exception
// comes through as a dropped record  from the soapcall instead
bad_soapcall := project(foo, transform(Risk_Indicators.Layouts.Layout_Neutral_DID_Service, 
	self.errmsg := ERROR (100, 'Neutral DID Service: ' + doxie.ErrorCodes(100));
	self.seq := left.batch_in[counter].seq;
	self := [];));
	
neutral_did_results := if(count(soap_response) > 0, soap_response, bad_soapcall);

// return neutral_did_results;
*/

return soap_response;
								
end;

