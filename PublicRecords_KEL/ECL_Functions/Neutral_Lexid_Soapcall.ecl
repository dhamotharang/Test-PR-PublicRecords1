IMPORT PublicRecords_KEL, Gateway, risk_indicators, riskwisefcra, Doxie;

EXPORT Neutral_Lexid_Soapcall(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) inputNoLexid,
		PublicRecords_KEL.Interface_Options Options) := FUNCTION
								
inrec := RECORD, MAXLENGTH(500000)
	DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) In_Layout;
	INTEGER	Score_Threshold;
	INTEGER InputUIDAppend := 0;
END;
		
LexidInput := DATASET([{PROJECT(inputNoLexid, 
	TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, SELF := LEFT)), 
		Options.ScoreThreshold
		}], inrec);

PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII errX(LexidInput L) := TRANSFORM
//	self.errmsg := ERROR (FAILCODE, 'Neutral Lexid Service: ' + FAILMESSAGE);
	SELF.InputUIDAppend := L.InputUIDAppend; 
	SELF := [];
END;

gateway_check := Options.gateways(servicename IN riskwisefcra.Neutral_Service_Name)[1].url;
gateway_url := IF(gateway_check='', ERROR(301, doxie.ErrorCodes(301)), gateway_check);

soap_response := SOAPCALL(LexidInput, 
		 gateway_url,
		 'PublicRecords_KEL.Neutral_Lexid_Service',
		 //inrec, //TRANSFORM(inrec, SELF := LEFT), 
		 {LexidInput},
		 DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII),
		 PARALLEL(3), MERGE(33), // pass multiple records at 1 time
		 ONFAIL(errX(LEFT)),
		 TIMEOUT(600));	// changed the timeout		


/*
// add error handling for dropped records in neutral_Lexis_service
// this error on the neutral roxie "EXCEPTION: Too many active queries" is not returning in the soapcall as a roxie exception
// comes through as a dropped record  from the soapcall instead
test_layout := record
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII;
	STRING120 errmsg := '';
END;
bad_soapcall := project(foo, transform(test_layout), 
	self.errmsg := ERROR (100, 'Neutral Lexid Service: ' + doxie.ErrorCodes(100));
	self.seq := left.batch_in[counter].seq;
	self := [];));
	
neutral_lexid_results := if(count(soap_response) > 0, soap_response, bad_soapcall);

// return neutral_lexid_results;
*/
//For debug output
//output(LexidInput, named('LexidInput'));
//output(gateway_url, named('gateway_url'));
//OUTPUT(soap_response, NAMED('soap_response'));

RETURN soap_response;
								
END;

