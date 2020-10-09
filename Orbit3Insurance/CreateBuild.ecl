import STD;
EXPORT CreateBuild(string			pLoginToken,
									 string			pMasterBuild,
									 string			pBuildVersion,
									 string			pHPCCWorkunit = workunit,
									 string			pBuildStatus				=	'BUILD_IN_PROGRESS',
									 integer1		pNewCoverage				=	1,
									 string			pVolume							=	'N/A',
		dataset(Layouts.OrbitPlatformUpdateLayout) platformupdates = dataset([],Layouts.OrbitPlatformUpdateLayout)
									 ) := function

/////////////////////////////////////////////////////////////////////////////
	
	rRequestParms :=
	record
		string								ActualStartDate						{xpath('ActualStartDate')}						:=	STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE))[1..10]+'T'+STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE))[12..13]+':'+STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE))[15..16]+':'+STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE))[18..19]+'Z';
		string								BuildName									{xpath('BuildName')}									:=	pMasterBuild;
		string								BuildVersion							{xpath('BuildVersion')}								:=	pBuildVersion;
		boolean								ExcludeFromScorecard			{xpath('ExcludeFromScorecard')}				:=	true;
		string								HpccWorkUnit							{xpath('HpccWorkUnit')}								:=	pHpccWorkUnit;
		string								MasterBuildName						{xpath('MasterBuildName')}						:=	pMasterBuild;
		integer1							NewCoverageArea						{xpath('NewCoverageArea')}						:=	pNewCoverage;
dataset(Layouts.OrbitPlatformUpdateLayout) PlatformStatusUpdates {xpath('Platforms' )} := platformupdates ; 
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
	 #IF(STD.System.Util.PlatformVersionCheck('7.8')) 
	 Orbit3Insurance.Layouts.AdditionalNamespacesLayout;
	 #END
		rOrbitRequest						request			{xpath('request')};
	end;

/////////////////////////////////////////////////////////////////////////////
	rStatus := RECORD
	STRING	Status {XPATH('CreateBuildResponse/CreateBuildResult/Result/RecordResponseCreateBuild/Status')};
	STRING	Message {XPATH('CreateBuildResponse/CreateBuildResult/Result/RecordResponseCreateBuild/Message')};
	STRING BuildId {XPATH('CreateBuildResponse/CreateBuildResult/Result/RecordResponseCreateBuild/Result/BuildId')};

	end;

/////////////////////////////////////////////////////////////////////////////
	rStatus lOrbitResponse	:=	soapcall(Orbit3Insurance.EnvironmentVariables.ServiceURL,
															 'CreateBuild',
															 rRequestCapsule,
															 rStatus,
															 namespace(Orbit3Insurance.EnvironmentVariables.NameSpace),
															 literal,
															 soapaction(Orbit3Insurance.EnvironmentVariables.SoapActionPrefix +  'CreateBuild')
															);

	return if(Orbit3Insurance.EnvironmentVariables.updateme = 'yes', lOrbitResponse);
END;
