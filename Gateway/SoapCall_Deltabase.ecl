
EXPORT SoapCall_Deltabase(sqlDataset, 
	RequestLayout, 
	ResponseLayout, 
	SelectField = 'Select', 
	ResultDataRecsField = 'DataRecs'
) := FUNCTIONMACRO
		RequestLayout SqlStringTransform(RequestLayout Lreq) := TRANSFORM
				self := Lreq;
		END; 

		ResponseLayout FailJoin(RequestLayout ds) := TRANSFORM
			ASSERT(1=0, 'Soap Error:' + (string)FAILCODE + ':' + FAILMESSAGE + ':' + FAILMESSAGE('soapresponse'));
			self := ds;
			self := [];
		END;
		out := SOAPCALL(sqlDataset, EspServiceUrl, EspServiceName, 
							RequestLayout, //Probably should be moved to the shared iesp folder
							SqlStringTransform(LEFT),
							DATASET(ResponseLayout),
							xpath('DeltaBaseSelectResponse'),
							onfail(FailJoin(left)), 
							RETRY(0), TIMEOUT(60), TRIM, LOG);	
		outResponse := IF(sqlDataset[1].SelectField != '', out);
		//TODO is there any better handling we could add to ensure we are warned if failures occur?
		// string exceptionMessage := outDeltaBaseJoinResponse[1].ExceptionMessage;
		// string recordCount := outDeltaBaseJoinResponse[1].RecsReturned;
		// string timeTaken := outDeltaBaseJoinResponse[1].Latency;
		// IF(exceptionMessage<>'' [ ???  what to do ??? ] );
		RETURN NORMALIZE(outResponse, LEFT.ResultDataRecsField, TRANSFORM(RIGHT));
ENDMACRO;