IMPORT iesp;

EXPORT DATASET(iesp.accident_image.t_AccidentImageResponseEx) SoapCall_GetReportImage(
	Layouts.Config gatewayCfg, 
	DATASET(iesp.accident_image.t_AccidentImageRequest) Request
	) := FUNCTION
	
	//select SQL string transform
	iesp.accident_image.t_AccidentImageRequest populateRequest(iesp.accident_image.t_AccidentImageRequest Lreq) := TRANSFORM
		SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gatewayCfg);
		SELF := Lreq;
	END; 
	
	//The FAIL transform, assert without the FAIL param simply logs the error message.
	iesp.accident_image.t_AccidentImageResponseEx FailCall(iesp.accident_image.t_AccidentImageRequest ds) := TRANSFORM
		ASSERT(1 = 0, 'Soap Error:' + (string)FAILCODE + ':' + FAILMESSAGE + ':' + FAILMESSAGE('soapresponse'));
		SELF := ds;
		SELF := [];
	END;

	Url := IF(EXISTS(Request), gatewayCfg.Url, '');
	Out := SOAPCALL(
		Request, 
		Url, 
		gatewayCfg.ServiceName, 
		iesp.accident_image.t_AccidentImageRequest, 
		populateRequest(LEFT),
		DATASET(iesp.accident_image.t_AccidentImageResponseEx),
		XPATH('AccidentImageResponseEx'),
		ONFAIL(FailCall(LEFT)), 
		RETRY(0), 
		TIMEOUT(60),
		TRIM,
		LOG
	);	

	RETURN Out;
END;