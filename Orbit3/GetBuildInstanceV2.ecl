//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
EXPORT GetBuildInstanceV2(string			pLoginToken,
												string			pBuildName,
												string			pBuildVersion
											 ) :=
function
	/////////////////////////////////////////////////////////////////////////////
	rRequestParms :=
	record
		string														BuildName							{xpath('BuildName'),		maxlength(128)}		:=	pBuildName;
		string														BuildVersion						{xpath('BuildVersion'),		maxlength(32)}		:=	pBuildVersion;
	end;
	rRecordRequestGetBuildInstance	:=	record
		rRequestParms								                RecordRequestGetBuildInstance		{xpath('RecordRequestGetBuildInstance')};
	end;
	rOrbitRequest := 
	record 
		string 														LoginToken							{xpath('Token'),			maxlength(36)}		:=	pLoginToken;
		rRecordRequestGetBuildInstance		                        orbRequest							{xpath('Request')};
	end;
	rRequestCapsule	:= record
	    #IF((__ECL_VERSION_MAJOR__ = 7) AND (__ECL_VERSION_MINOR__ >= 8)) // 7.8 Tightened up the checking of the namespace in SOAP calls, it doesn't support multiple ones so this is in as a workaround until that is available. Unfortunately the workaround doesn't work on 7.6 hence the conditional here.
           $.Layouts.AdditionalNamespacesLayout;
        #END
		rOrbitRequest											    request								{xpath('request')};
	end;
	
	//////////////////////////////////////////////////////////////////////////////////
	rBuildInstanceDetails	:= record
		string	ActualStartDate																			{xpath('ActualStartDate')};
		string	AutoArchive																				{xpath('AutoArchive')};
		string	BuildInstanceId																			{xpath('BuildInstanceId')};
		string	BuildName																				{xpath('BuildName')};
		string	BuildTemplateTypeId																	    {xpath('BuildTemplateTypeId')};
		string	BuildVersion																			{xpath('BuildVersion')};
		string	BuildtoRelease																			{xpath('BuildtoRelease')};
		string	Documentation																			{xpath('Documentation')};
		string	ExcludeFromScorecard															 	    {xpath('ExcludeFromScorecard')};
		string	IsArchived																				{xpath('IsArchived')};
		string	MasterBuild																				{xpath('MasterBuild')};
		string	MasterBuildName																			{xpath('MasterBuildName')};
		string	NewCoverageArea																			{xpath('NewCoverageArea')};
		string	NextBuildDate																			{xpath('NextBuildDate')};
		string	PlatformBuildStatus																	    {xpath('PlatformBuildStatus')};
		string	QAAssignedTo																			{xpath('QAAssignedTo')};
		string	QAUserId																				{xpath('QAUserId')};
		string	SkippedBuild																			{xpath('SkippedBuild')};
		string	Status																					{xpath('Status')};
		string	VarianceBugzillaNumber															        {xpath('VarianceBugzillaNumber')};
		string	VarianceDate																			{xpath('VarianceDate')};
		string	VarianceIssue																			{xpath('VarianceIssue')};
		string	VarianceNote																			{xpath('VarianceNote')};
		string	Bugs																					{xpath('Bugs/')};
		string	BuidInputs																				{xpath('BuidInputs/')};
		string	Documents																				{xpath('Documents/')};
		string	Notes																					{xpath('Notes/')};
		string	Outputs																					{xpath('Outputs/')};
		string	ReceiveInputs																			{xpath('ReceiveInputs/')};
	end;
	rResult2	:= record
		rBuildInstanceDetails						            Result									{xpath('Result')};
		string													Status									{xpath('Status')};
		string													Message									{xpath('Message')};
	end;
	rRecordResponseGetBuildInstance	:= record
		rResult2	                                           RecordResponseGetBuildInstance			{xpath('RecordResponseGetBuildInstance')};
	end;
	rResult := record
		rRecordResponseGetBuildInstance	                        Result									{xpath('Result')};
		string													Status									{xpath('Status')};
		string													Message									{xpath('Message')};
	end;
	rGetBuildInstanceResponse :=	record
		rResult									 				GetBuildInstanceResult			        {xpath('GetBuildInstanceResult')};
	end;
	rFault  :=	record
		string         									        FaultCode								{xpath('faultcode')};
		string         									        FaultString								{xpath('faultstring')};
	end;
	rSOAPResponse	:= 	record
		rFault 	  											    FaultRecord								{xpath('Fault')};
		rGetBuildInstanceResponse				                GetBuildInstanceResponse		        {xpath('GetBuildInstanceResponse')};
	end;	
	/////////////////////////////////////////////////////////////////////////////
	lResponse	:=	soapcall(Orbit3.EnvironmentVariables.ServiceURL,
												'GetBuildInstance',
												 rRequestCapsule,
												 rSOAPResponse,
												 namespace(Orbit3.EnvironmentVariables.NameSpace),
												 literal,
												 soapaction(Orbit3.EnvironmentVariables.SoapActionPrefix +  'PR/GetBuildInstance')
												);

	assert(lResponse.GetBuildInstanceResponse.GetBuildInstanceResult.status <> 'Fail', 'Orbit3.GetBuildInstanceV2 - Failed ' + 
	       lResponse.GetBuildInstanceResponse.GetBuildInstanceResult.Result.RecordResponseGetBuildInstance.message, Fail);
	return	lResponse.GetBuildInstanceResponse.GetBuildInstanceResult.Result.RecordResponseGetBuildInstance.Result;
end;

