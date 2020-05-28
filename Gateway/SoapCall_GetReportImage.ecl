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

	//Get the timeout from "User.MaxWaitSeconds" in the request. If it's set to zero or less, assume 120 seconds.
	DefaultTimeout := 120;
	RawTimeout := (INTEGER) Request[1].User.MaxWaitSeconds;
	TrueTimeout := IF(RawTimeout <= 0, DefaultTimeout, RawTimeout);

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
		TIMEOUT(TrueTimeout),
		TRIM,
		LOG
	);	

	RETURN Out;
END;