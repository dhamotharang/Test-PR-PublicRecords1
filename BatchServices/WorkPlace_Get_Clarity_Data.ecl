import AutoStandardI, iesp, Risk_Indicators, ut;

export WorkPlace_Get_Clarity_Data := module

 shared	Clarity_SoapCall(dataset(iesp.gateway_skiptrace.t_SkipTraceSearchRequest) infile, 
                                 string gateway_URL) := function

	rAppendFailCode_Layout	:=
	record(iesp.gateway_skiptrace.t_SkipTraceSearchResponseEx)
		integer	soapcode;
		string	soapmessage;
	end;
	
	iesp.gateway_skiptrace.t_SkipTraceSearchRequest xform_infile(infile L) := transform
		self := L;
	end;

	rAppendFailCode_Layout	xform_fail(infile L) := transform
		self.soapcode			:=	FAILCODE;
		self.soapmessage	:=	FAILMESSAGE;
		self := L;
		self := [];
	end;

	iesp.gateway_skiptrace.t_SkipTraceSearchResponseEx xform_FormatFail(rAppendFailCode_Layout L) := transform
		ds_exceptions	:=	dataset([{'SoapCall',L.soapcode,'',L.soapmessage}],iesp.share.t_WsException);
		
		// Fail the service if the gateway is down
		self.response._Header.status			:=	if(L.soapcode	=	-1,ERROR(L.soapcode,L.soapmessage),L.response._Header.status);
		
		self.response._Header.Exceptions	:=	if(L.soapcode	!=	0,ds_exceptions);
		self															:=	l;
	end;

  // The soapcall which actually accesses the gateway.
	soapcall_out := IF(gateway_URL != '',
	                   soapcall (infile, 
	                             gateway_URL, 
														   'SkipTraceSearch', 
														   iesp.gateway_skiptrace.t_SkipTraceSearchRequest,
														   xform_infile(LEFT), 
														   dataset(rAppendFailCode_Layout),
                                       XPATH('SkipTraceSearchResponseEx'),
														           onfail(xform_fail(LEFT)),
															 RETRY(0), TIMEOUT(20),TRIM,LOG
                               ));
	
  return project (soapcall_out, xform_FormatFail (Left));
	
 end; // end Clarity_SoapCall function
	
 export skipTraceParams := 
	  interface(AutoStandardI.PermissionI_Tools.params)
    // the 5 below are not needed for the batch service, but will probably be needed for ol
		export string50	ReferenceCode;
	  export string20	BillingCode;
	  export string50	QueryId;
	  export string 	RealTimePermissibleUse;
	  export string 	SubCustomerID;
		// ssn to search on; it needed to be named different from "ssn" due to syntax error
	  export string9	ssn9; 
 end;
	
 export val(SkipTraceParams in_mod, 
            dataset(Risk_Indicators.Layout_Gateways_In) in_gateways) := function

   // NOTE: Some gateway access attributes used for other products,(i.e. Polk, Experian, etc.),
	 // store the soap input "gateways" dataset directly here.
	 // However to use this attribute for both batch and online it was decided to pass in
	 // the "gateways" dataset which will be stored/handled in the attributes that call 
	 // this one.
	 
	 // For initial testing you can use one of the gateway_url lines below, 
	 // then comment it out when go to prod.
 	 // Note: in the urls below, "http:// + the part after the "@" is the ip of the ESP 
	 // gateway location.
	 // The part after the "http://" and before the "@" is the uid & password.
   // ESP gateway dev, on 10/18/10 securedev was re-configured to point at the vendor prod system for running initial tests
	 // gateway_url := 'https://webapp_roxie_test:web33436$@securedev.accurint.com/espdev/gw/?ver_=1.5';
   // ESP gateway cert, configured to point at vendor test system
	 //gateway_url := 'http://webapp_roxie_test:web33436$@rwgatewaycert.br.seisint.com:8090/WsGateway';
	 // OR per ken Subratie use this ip ----v
	 //gateway_url := 'http://webapp_roxie_test:web33436$@10.173.251.111:8090/WsGateway'; //.../SkipTraceSearch?form ???
	 // ESP gateway prod - on 10/28/10 SkipTraceSearch is scheduled to be released on ESP gateway prod
	 // This is similar to what Kettle passes in to RealTimePhones_BatchService
	 // gateway_url := 'http://web_bps_roxie:r45gu@lt-esponline01:8091/wsGateway';

	 ds_in_gateways := project(in_gateways,transform(risk_indicators.Layout_Gateways_In,
		                                      self.servicename  := StringLib.StringToUpperCase(LEFT.serviceName),
													                self := left));
	 gateway_url := ds_in_gateways(servicename='SKIPTRACESEARCH')[1].url;


   // A transform to format the gateway search request layout
	 iesp.gateway_skiptrace.t_SkipTraceSearchRequest prepRequest() := transform

		 // set iesp.share.t_BaseRequest rec layout fields
		 // are these needed to be set in the gateway search request structure ???
		 self.user.GLBPurpose    := trim((String)in_mod.GLBPurpose);
		 self.user.DLPurpose     := trim((String)in_mod.DPPAPurpose);			
		 self.user.QueryID       := trim(in_mod.QueryId);
		 self.user.ReferenceCode := trim(in_mod.ReferenceCode);
		 self.user.BillingCode   := trim(in_mod.BillingCode);	
		 
		 self.user               := []; // null out the other user options
		 self.RemoteLocations    := []; 
		 self.ServiceLocations   := [];

		 // Set 2 options fields specific to clarity gateway access that are not set by ESP.
		 //
	   // version 1 used until customers are accessing the gateway via the batch service
		 // Coordinate changing this with Emilie & her Clarity contact.
		 //self.Options.inquirypurposetype   := BatchServices.WorkPlace_Constants.CLARITY_INQ_PURPOSE_TESTING;
     // version 2 used for the 11/17/10 roxie release ------------------v
		 self.Options.inquirypurposetype   := BatchServices.WorkPlace_Constants.CLARITY_INQ_PURPOSE;
		 self.Options.inquirytradelinetype := BatchServices.WorkPlace_Constants.CLARITY_INQ_TRADELINE;     // version 2 used for the 11/17/10? (TBD) roxie release ------------------v
		 self.Options := [];  // null out the other options fields

		 // set the ssn to be searched by, dashes were removed prior to here
 		 self.SearchBy.SSN := trim(in_mod.ssn9);
		 self.SearchBy     := []; // null out the other searchby fields
   end;

   ClarityIn := dataset([prepRequest()]);

	 // Format error & message to return if URL from passed in "gateways" dataset was empty.
   ClarityOut := if(gateway_url<>'',
                    Clarity_SoapCall(ClarityIn, gateway_url),
										fail(dataset([],iesp.gateway_skiptrace.t_SkipTraceSearchResponseEx),
											   ut.constants_MessageCodes.GATEWAY_URL_MISSING,
												 ut.MessageCode(ut.constants_MessageCodes.GATEWAY_URL_MISSING,'')[1].msg)
									 );

   // Uncomment line below as needed for debugging 
   //output(clarityin, named('clarityin'));
	 
   return ClarityOut;
	 
 end;  // end val function

end; // end module
