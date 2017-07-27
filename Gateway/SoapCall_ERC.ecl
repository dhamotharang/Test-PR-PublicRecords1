// replacement for PropertyCharacteristics_Services.ERC_SoapCall_Function

import	iesp, Gateway;

out_rec := iesp.property_value_report.t_PropertyValueReportResponseEx;

export	SoapCall_ERC(	dataset(iesp.property_value_report.t_PropertyValueReportRequest)	pRequest,
													Gateway.Layouts.Config gateway_cfg, 
													integer waittime	=	Constants.Defaults.WAIT_TIMEOUT, 
													integer retries		=	Constants.Defaults.RETRIES
												)	:=
function

	pRequest_r := project(pRequest, transform(iesp.property_value_report.t_PropertyValueReportRequest,
																		self.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg),
																		self := left));
	
	// Create a temporary layout so as to capture the soap error message
	rExtendedSoapResponse	:= record(out_rec)
		integer code := 0;
		string	SoapMessage	:=	'';
	end;
	
	// Transform function to call when the gateway is down or the service name passed is wrong
	rExtendedSoapResponse	tFail(pRequest	L)	:=	transform
		Self.code := if (FAILCODE = 0, -1, FAILCODE);
		self.SoapMessage	:=	FAILMESSAGE;
		self							:=	[]; // in case of SOAP call failure we don't wan't anything else
	end;

	// Soap call to BlueBook gateway
	dERCSoapResponse	:=	soapcall(	pRequest_r,
																	gateway_cfg.Url,
																	'PropertyValueReport',
																	{pRequest_r},
																	dataset(rExtendedSoapResponse),
																	XPATH('PropertyValueReportResponseEx'),
																	ONFAIL(tFail(left)),
																	RETRY(0),
																	TIMEOUT(10),
																	TRIM
																);
	
	// Populate the exceptions section in the header if failure occurs
	out_rec	tParseSoapMessage(rExtendedSoapResponse	L)	:=	transform
		
		ds_err := dataset ([{'SoapCall', L.code, '', L.SoapMessage}], iesp.share.t_WsException);
		
		self.response._Header.Exceptions	:=	if (L.code != 0, ds_err);
		self															:=	L;
	end;

	return	project(dERCSoapResponse,tParseSoapMessage(left));
end;

