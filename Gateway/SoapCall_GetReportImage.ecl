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
	
	iesp.accident_image.t_AccidentImageResponseEx tf_OnFail() := TRANSFORM
		SELF.Response.ErrorMessage             := FAILMESSAGE('soapresponse');
		SELF := [];
	end;
	
	
	//Get the timeout from "User.MaxWaitSeconds" in the request. If it's set to zero or less, assume 180 seconds.
	DefaultTimeout := 180;
	RawTimeout := (INTEGER) Request[1].User.MaxWaitSeconds;
	TrueTimeout := IF(RawTimeout <= 0, DefaultTimeout, RawTimeout);

	Url := IF(EXISTS(Request), gatewayCfg.Url, '');
	ds_soapcall_out := SOAPCALL(
		Request, 
		Url, 
		gatewayCfg.ServiceName, 
		iesp.accident_image.t_AccidentImageRequest, 
		populateRequest(LEFT),
		DATASET(iesp.accident_image.t_AccidentImageResponseEx),
		XPATH('AccidentImageResponseEx'),
		ONFAIL(tf_OnFail()), 
		RETRY(0), 
		TIMEOUT(TrueTimeout),
		TRIM,
		LOG
	);
// output(ds_soapcall_out,named('soap_out'));
	RETURN ds_soapcall_out;
END;