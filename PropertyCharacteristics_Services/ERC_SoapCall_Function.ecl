#warning('Deprecated. Use Gateway.SoapCall_ERC instead.')
import	iesp;

out_rec := iesp.property_value_report.t_PropertyValueReportResponseEx;

export	ERC_SoapCall_Function(	dataset(iesp.property_value_report.t_PropertyValueReportRequest)	pRequest,
																string																														pGatewayURL
															)	:=
function
	
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
	dERCSoapResponse	:=	soapcall(	pRequest,
																	pGatewayURL,
																	'PropertyValueReport',
																	{pRequest},
																	dataset(rExtendedSoapResponse),
																	XPATH('PropertyValueReportResponseEx'),
																	ONFAIL(tFail(left)),
																	TRIM
																);
	
	// Populate the exceptions section in the header if failure occurs
	out_rec	tParseSoapMessage(rExtendedSoapResponse	L)	:=	transform
		
		ds_err := dataset ([{'SoapCall', L.code, '', L.SoapMessage}], iesp.share.t_WsException);
		
		self.response._Header.Exceptions	:=	if (L.code != 0, ds_err);
		self															:=	L;
	end;

	// output (dERCSoapResponse, named ('dERCSoapResponse'));
	return	project(dERCSoapResponse,tParseSoapMessage(left));
end;

