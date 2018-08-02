EXPORT CreateBuild(string			pLoginToken,
									 string			pMasterBuild,
									 string			pBuildName,
									 string			pBuildVersion,
									 string			pHPCCWorkunit,
									 string			pBuildStatus				=	'BuildInProgress',
									 integer1		pNewCoverage				=	1,
									 string			pVolume							=	'N/A',
									 string			pPlatformName				=	'NonFCRA Roxie',
									 string			pPlatformStatus			=	'NoQA'
									 ) := function

/////////////////////////////////////////////////////////////////////////////
	rPlatform	:=
	record
		string								PlatformName							{xpath('PlatformName')}								:=	pPlatformName;
		string								PlatformStatus						{xpath('PlatformStatus')}							:=	pPlatformStatus;
	end;	
	rRequestParms :=
	record
		string								ActualStartDate						{xpath('ActualStartDate')}						:=	'2015-11-22T12:00:00Z';
		string								BuildName									{xpath('BuildName')}									:=	pBuildName;
		string								BuildVersion							{xpath('BuildVersion')}								:=	pBuildVersion;
		boolean								ExcludeFromScorecard			{xpath('ExcludeFromScorecard')}				:=	true;
		string								HpccWorkUnit							{xpath('HpccWorkUnit')}								:=	pHpccWorkUnit;
		// string								MasterBuildId							{xpath('MasterBuildId')}							:=	;
		string								MasterBuildName						{xpath('MasterBuildName')}						:=	pMasterBuild;
		integer1							NewCoverageArea						{xpath('NewCoverageArea')}						:=	pNewCoverage;
		rPlatform							Platforms									{xpath('Platforms')};
		boolean								SkippedBuild							{xpath('SkippedBuild')}								:=	false;
	end;
	rCreateBuildReq := record
		rRequestParms					RecordRequestCreateBuild	{xpath('RecordRequestCreateBuild')};
	end;
	rOrbitRequest := 
	record 
		string 									LoginToken					{xpath('Token'),							maxlength(36)}		:=	pLoginToken;
		rCreateBuildReq					OrbRequest					{xpath('Request')};
	end;

	rRequestCapsule	:=
	record
		rOrbitRequest						request			{xpath('request')};
	end;

/////////////////////////////////////////////////////////////////////////////
	rCreateBuildResultFields	:= record
		integer4						BuildId										{xpath('BuildId')};
		string							BuildName									{xpath('BuildName')};
		string							BuildStatus								{xpath('BuildStatus')};
		string							BuildVersion							{xpath('BuildVersion')};
		string							HpccWorkUnit							{xpath('HpccWorkUnit')};
		string							MasterBuildId							{xpath('MasterBuildId')};
		string							MasterBuildName						{xpath('MasterBuildName')};
		string							ServerInfo								{xpath('ServerInfo')};
	end;	
	rResult2	:= record
		rCreateBuildResultFields		Result						{xpath('Result')};	
		string							Status										{xpath('Status')};
		string							Message										{xpath('Message')};
	end;	
	
	rCreateBuildResult	:= record
		rResult2						RecordResponseCreateBuild	{xpath('RecordResponseCreateBuild')};
	end;
	rResult	:=	record
		rCreateBuildResult	Result										{xpath('Result')};
		string							Status										{xpath('Status')};
	end;

	rCreateBuildResponseResult :=	record
		rResult							CreateBuildResult					{xpath('CreateBuildResult'),				maxlength(4096)};
	end;
	rFault  :=	record
		string         			FaultCode									{xpath('faultcode')};
		string    		    	FaultString								{xpath('faultstring')};
	end;
	
	rSOAPResponse	:= 	record
		rFault 	  					FaultRecord								{xpath('Fault')};
		rCreateBuildResponseResult	CreateBuildResponse			{xpath('CreateBuildResponse'), 		maxlength(300000)};
	end;

/////////////////////////////////////////////////////////////////////////////
	rSOAPResponse lOrbitResponse	:=	soapcall(Orbit3Insurance.EnvironmentVariables.ServiceURL,
															 'CreateBuild',
															 rRequestCapsule,
															 rSOAPResponse,
															 namespace(Orbit3Insurance.EnvironmentVariables.NameSpace),
															 literal,
															 soapaction(Orbit3Insurance.EnvironmentVariables.SoapActionPrefix +  'CreateBuild')
															);

	return if(Orbit3Insurance.EnvironmentVariables.updateme = 'yes', lOrbitResponse);
END;
