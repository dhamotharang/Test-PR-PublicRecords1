import	doxie,iesp,risk_indicators,ut, Gateway;

export	Velocity_SoapCall(	dataset(inquiry_services.velocity_layouts.r_uniqueid)	ds_in,
														Inquiry_Services.Velocity_Iparam.SearchRecords				in_mod
													)	:=
function
	// Using the same request and response layouts for both gateways
	// since the layouts are essentially the same except for the root tag
	l_request		:=	iesp.AccurintSpSearchAlertIdSProc.t_AccurintSpSearchAlertIdSProcRequest;
	l_response	:=	iesp.AccurintSpSearchAlertIdSProc.t_AccurintSpSearchAlertIdSProcResponse;

	// search_alert_gateway_url	:=	in_mod.GatewayURL;
	search_alert_gateway_url	:= if(	~in_mod.EDataVelocity, in_mod.Gateway_cfg(ut.fnTrim2Upper(servicename)=Gateway.Constants.ServiceName.SearchAlertID)[1].URL,
																			in_mod.Gateway_cfg(ut.fnTrim2Upper(servicename)=Gateway.Constants.ServiceName.SearchIdentityVelocityId)[1].URL
																	);
	
	// Service name for the gateway
	string	vServiceName	:=	if(	~in_mod.EDataVelocity,
																Inquiry_Services.Velocity_Constants.AlertIDServiceName,
																Inquiry_Services.Velocity_Constants.VelocityIDServiceName
															);
	
	// xpath tag name depending on the gateway
	string	vXpathTagName	:=	if(	~in_mod.EDataVelocity,
																'AccurintSpSearchAlertIdSProcResponse',
																'AccurintSpSearchIdentityVelocityIdSProcResponse'
															);
	
	// Transform for converting the DID to a string as expected by the gateway
	l_request	xformToString(ds_in	l)	:=
	transform
		self.inputparameters.unique_id	:=	intformat(l.uniqueid,12,1);
		self._Blind := Gateway.Configuration.GetBlindOption(in_mod.gateway_cfg);
	end;
	
	gw_request := project(ds_in,xformToString(left));
	
	// The transform to call to process the instructure data.
	// Eliminates the need to define default values for all fields in the instructure
	l_request	t(l_request	l)	:=
	transform
		self	:=	l;
	end;
	
	// Transform to call in case of failures
	l_response	myFail(l_request	l)	:=
	transform
		self.errorcode	:=	failcode;
		self.message		:=	if(failcode=0,'success',failmessage);
		self						:=	[];
	END;
	
	// Soap call to the gateway
	gw_response	:=	soapcall(	gw_request,
														search_alert_gateway_url,
														vServiceName,
														iesp.AccurintSpSearchAlertIdSProc.t_AccurintSpSearchAlertIdSProcRequest,
														t(left),
														dataset(iesp.AccurintSpSearchAlertIdSProc.t_AccurintSpSearchAlertIdSProcResponse),
														xpath(vXpathTagName),
														onfail(myFail(left))
													);
	
	// Slim the response layout to keep the relevant fields
	inquiry_services.Velocity_Layouts.Gateway.SlimResponse tSlimRes(gw_response	pInput)	:=
	transform
		self.Recs	:=	project(	pInput.Datasets.Records,	// Was able to use datasets.records instead of datasets[1].records as the max count for "datasets" is set to one
														transform(	inquiry_services.Velocity_Layouts.Gateway.Records,
																				self	:=	left;
																				self	:=	pInput;
																			)
													);
	end;

	p1	:=	project(gw_response,tSlimRes(left));

	// Normalize the child dataset records
	Inquiry_Services.Velocity_Layouts.Gateway.Records	tNormRecs(inquiry_services.Velocity_Layouts.Gateway.Records	ri)	:=
	transform
		self	:=	ri;
	end;
	
	p2	:=	normalize(p1,left.Recs,tNormRecs(right));
	
	// Populate the relevant value fields
	Inquiry_Services.Velocity_Layouts.Gateway.Out	tOut(Inquiry_Services.Velocity_Layouts.Gateway.Records	pInput)	:=
	transform
		self.Transaction_ID := ut.fnTrim2Upper(pInput.Fields(ut.fnTrim2Upper(Name)	=	'TRANSACTION_ID')[1].Value);
		self.Search_Date	:=	stringlib.stringfilterout(ut.fnTrim2Upper(pInput.Fields(ut.fnTrim2Upper(Name)	in	['DATE_ADDED','SEARCH_DATE'])[1].Value),'-')[1..8];
		self.Search_Time	:=	stringlib.stringfilterout(ut.fnTrim2Upper(pInput.Fields(ut.fnTrim2Upper(Name)	in	['DATE_ADDED','SEARCH_DATE'])[1].Value),':')[12..17];
		self.Vertical			:=	ut.fnTrim2Upper(pInput.Fields(ut.fnTrim2Upper(Name)	=	'VERTICAL')[1].Value);
		self.Industry			:=	ut.fnTrim2Upper(pInput.Fields(ut.fnTrim2Upper(Name)	=	'INDUSTRY')[1].Value);
		self.Description	:=	ut.fnTrim2Upper(pInput.Fields(ut.fnTrim2Upper(Name)	in	['DESCRIPTION','MOXIE_FUNCTION_DESC'])[1].Value);
		self.rec_Use			:=	ut.fnTrim2Upper(pInput.Fields(ut.fnTrim2Upper(Name)	in	['REC_USE'])[1].Value);
		self							:=	pInput;
	end;
	
	p3	:=	project(p2,tOut(left));
/* 	
   	// Outputs for debugging
   	output(gw_request,named('gw_request'));
   	output(gw_response,named('gw_response'));
   	output(p1,named('p1'));
   	output(p2,named('p2'));
   	output(p3,named('p3'));
*/
	
	return p3;
end;