//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
import Orbit3;

EXPORT GetProfileV2  (string pLoginToken,
					  dataset(Orbit3.Layouts.RequestGetProfileLayout) pProfiles
					  ) :=
function
	//***************************************************************************************************
  //** GetProfile Input
  //***************************************************************************************************
	rOrbitRequest := 
	record 
		string 		 		                            LoginToken	{xpath('Token'),		maxlength(36)}		:=	pLoginToken;
		dataset(Orbit3.Layouts.RequestGetProfileLayout)	orbRequest	{xpath('Request/RecordRequestGetProfile')}  :=  pProfiles;
	end;
	
	rRequestCapsule	:= record
	    #IF(((__ECL_VERSION_MAJOR__ = 7) AND (__ECL_VERSION_MINOR__ >= 8)) or  (__ECL_VERSION_MAJOR__ > 7)) // 7.8 Tightened up the checking of the namespace in SOAP calls, it doesn't support multiple ones so this is in as a workaround until that is available. Unfortunately the workaround doesn't work on 7.6 hence the conditional here.
           $.Layouts.AdditionalNamespacesLayout;
        #END	
		rOrbitRequest					                        request									{xpath('request')};
	end;
	
  //***************************************************************************************************
  //** GetProfile Response Output
  //***************************************************************************************************
	
   rResult2	:= record
		Orbit3.Layouts.ResponseGetProfileLayout		            Result									{xpath('Result')};
		string													Status									{xpath('Status')};
		string													Message									{xpath('Message')};
	end;
	
  rRecordResponseGetProfile	:= record
    dataset(rResult2)	                                        RecordResponseGetProfile				{xpath('RecordResponseGetProfile')};
	end;
	
  rResult := record
		rRecordResponseGetProfile	                            Result									{xpath('Result')};
		string													Status									{xpath('Status')};
		string													Message									{xpath('Message')};
	end;
	
  rGetProfileResponse :=	record
		rResult									 				GetProfileResult			            {xpath('GetProfileResult')};
	end;
    
	rFault  :=	record
		string         									        FaultCode								{xpath('faultcode')};
		string         									        FaultString							    {xpath('faultstring')};
	end;
    
	rSOAPResponse	:= 	record
		rFault 	  											    FaultRecord						        {xpath('Fault')};
		rGetProfileResponse				                        GetProfileResponse		                {xpath('GetProfileResponse')};
	end;	
	/////////////////////////////////////////////////////////////////////////////
	rSOAPResponse lResponse	:=	soapcall(Orbit3.EnvironmentVariables.ServiceURL,
												'GetProfile',
												 rRequestCapsule,
												 rSOAPResponse,
												 namespace(Orbit3.EnvironmentVariables.NameSpace),
												 literal,
												 soapaction(Orbit3.EnvironmentVariables.soapactionprofile +  'GetProfile')
												);

	assert(lResponse.GetProfileResponse.GetProfileResult.status <> 'Fail', 'Orbit3.GetProfile - Failed ' + 
	       lResponse.GetProfileResponse.GetProfileResult.Message);
           
	return	lResponse.GetProfileResponse.GetProfileResult.Result.RecordResponseGetProfile;
end;

