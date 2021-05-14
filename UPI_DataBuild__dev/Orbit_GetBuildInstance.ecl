IMPORT UPI_DataBuild__dev;
EXPORT Orbit_GetBuildInstance		 (	STRING BuildName
														,	STRING BuildVersion
														, STRING Token
														, STRING OrbitEnv
														)	:= FUNCTION
														
	// IMPORT Healthcare_Orbit;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	STRING sService := 'GetBuildInstance'	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - REQUEST
	rBuildINV		:= 	RECORD
		STRING				orbBuildName										{	XPATH('orb:BuildName'												)	}	:= BuildName			; // 'Scrub-CoreVendor-FIS'
		STRING				orbBuildVersion									{	XPATH('orb:BuildVersion'										)	}	:= BuildVersion		; // '20130815B'
	END	;	
	// -
	rBuilds			:= 	RECORD
		rBuildINV			orbBuildINV											{	XPATH('orb:BuildInstanceNameVersion'				)	}							;
	END	;
	// -
	rLex				:= 	RECORD
		rBuilds			 	orbBuilds												{	XPATH('orb:Builds'													)	}							;
		STRING 				orbToken		 										{	XPATH('orb:Token'														)	}	:= 	Token		;	
	END	;
	// -
	rRequest		:= 	RECORD
		rLex					lexRequest											{	XPATH('lex:request'													)	}							;
	END	;
	//-----------------------------------------------------------------------------------------------------------------------------------------
	// - RESPONSE
	rOrbit			:= RECORD
		STRING			 OrbitStatusCode									{	XPATH('OrbitStatusCode'											)	}							;
		STRING			 OrbitStatusDescription						{	XPATH('OrbitStatusDescription'							)	}							;
	END;
	// -
	rStatus 		:= 	RECORD
		STRING				Code														{	XPATH('Code'																)	}							;
		STRING				Description											{	XPATH('Description'													)	}							;
		STRING				bStatus													{	XPATH('Status'															)	}							;
	END;
	// -

	rRecordRequestGetBuildInstanceInput 		:= 	RECORD
		STRING				InputId								{	XPATH('InputId'						)	}							;
		STRING				Name									{	XPATH('Name'							)	}							;
		STRING				Status								{	XPATH('Status'						)	}							;
		STRING				Version								{	XPATH('Version'						)	}							;
	END;

	rBuidInputs 	:= 	RECORD
		DATASET(rRecordRequestGetBuildInstanceInput) RecordRequestGetBuildInstanceInput  {	XPATH('RecordRequestGetBuildInstanceInput'	)	}		;	
	END;

	rReceiveAndReceiveFileInfo := RECORD
		STRING ReceivingId 						{	XPATH('ReceivingId'					)	}							;
		STRING FileName 							{	XPATH('FileName'						)	}							;
		STRING ReceiveStatusDesc 			{	XPATH('ReceiveStatusDesc'		)	}							;
	END;	

	rReceivingDetails := RECORD
		DATASET(rReceiveAndReceiveFileInfo) ReceiveAndReceiveFileInfo  {	XPATH('ReceiveAndReceiveFileInfo'	)	}		;	
	END;

	rPlatform		:= 	RECORD			
		STRING				PlatformName		 								{	XPATH('PlatformName'												)	}							;							
		STRING				PlatformStatus		 							{	XPATH('PlatformStatus'											)	}							;							
	END	;
	// -
	rPlatforms	:= 	RECORD
		rPlatform			Platform		 										{	XPATH('Platform'														)	}							;	
	END	;
	// -
	rBuildIBR		:= 	RECORD
		STRING			 	Analyst													{	XPATH('Analyst'															)	}							;
		STRING			 	BuildId													{	XPATH('BuildId'															)	}							;
		STRING			 	BuildInstanceComputedBtr				{	XPATH('BuildInstanceComputedBtr'						)	}							;
		STRING			 	BuildInstanceCopy								{	XPATH('BuildInstanceCopy'										)	}							;
		STRING			 	BuildInstanceCreatedBy					{	XPATH('BuildInstanceCreatedBy'							)	}							;
		STRING			 	BuildInstanceCreatedDate				{	XPATH('BuildInstanceCreatedDate'						)	}							;
		STRING			 	BuildInstanceDataOne						{	XPATH('BuildInstanceDataOne'								)	}							;
		STRING			 	BuildInstanceDataTwo						{	XPATH('BuildInstanceDataTwo'								)	}							;
		STRING			 	BuildInstanceDescription				{	XPATH('BuildInstanceDescription'						)	}							;
		STRING			 	BuildInstanceDisableScoring			{	XPATH('BuildInstanceDisableScoring'					)	}							;
		STRING			 	BuildInstanceDocumentation			{	XPATH('BuildInstanceDocumentation'					)	}							;
		STRING			 	BuildInstanceEndDate						{	XPATH('BuildInstanceEndDate'								)	}							;
		STRING			 	BuildInstanceExtraBuild					{	XPATH('BuildInstanceExtraBuild'							)	}							;
		STRING			 	BuildInstanceIssueBugzilla			{	XPATH('BuildInstanceIssueBugzilla'					)	}							;
		STRING			 	BuildInstanceIssueNote					{	XPATH('BuildInstanceIssueNote'							)	}							;
		STRING			 	BuildInstanceNewCoverage				{	XPATH('BuildInstanceNewCoverage'						)	}							;
		STRING			 	BuildInstanceNextBuildDate			{	XPATH('BuildInstanceNextBuildDate'					)	}							;
		STRING			 	BuildInstanceOverrideBtr				{	XPATH('BuildInstanceOverrideBtr'						)	}							;
		STRING			 	BuildInstanceQAOwner						{	XPATH('BuildInstanceQAOwner'								)	}							;
		STRING			 	BuildInstanceQaEndDate					{	XPATH('BuildInstanceQaEndDate'							)	}							;
		STRING			 	BuildInstanceQaStartDate				{	XPATH('BuildInstanceQaStartDate'						)	}							;
		STRING			 	BuildInstanceScorecardIgnore		{	XPATH('BuildInstanceScorecardIgnore'				)	}							;
		STRING			 	BuildInstanceStartDate					{	XPATH('BuildInstanceStartDate'							)	}							;
		STRING			 	BuildInstanceTargetEndDate			{	XPATH('BuildInstanceTargetEndDate'					)	}							;
		STRING			 	BuildInstanceTargetReleaseDate 	{	XPATH('BuildInstanceTargetReleaseDate'			)	}							;
		STRING			 	BuildInstanceTargetStartDate 		{	XPATH('BuildInstanceTargetStartDate'				)	}							;
		STRING			 	BuildInstanceUpdateDate 				{	XPATH('BuildInstanceUpdateDate'							)	}							;
		STRING			 	BuildInstanceUpdateFrequency 		{	XPATH('BuildInstanceUpdateFrequency'				)	}							;
		STRING			 	BuildInstanceUpdateUser 				{	XPATH('BuildInstanceUpdateUser'							)	}							;
		STRING			 	BuildInstanceVolume 						{	XPATH('BuildInstanceVolume'									)	}							;
		STRING			 	BuildName 											{	XPATH('BuildName'														)	}							;
		STRING			 	BuildStatus 										{	XPATH('BuildStatus'													)	}							;
		STRING			 	BuildStatusDescription 					{	XPATH('BuildStatusDescription'							)	}							;
		STRING			 	BuildVersion					 					{	XPATH('BuildVersion'												)	}							;
		STRING			 	Documentation					 					{	XPATH('Documentation'												)	}							;
		STRING			 	HpccWorkUnit					 					{	XPATH('HpccWorkUnit'												)	}							;
		STRING			 	MasterBuild					 						{	XPATH('MasterBuild'													)	}							;
		STRING			 	MasterBuildStatus					 			{	XPATH('MasterBuildStatus'										)	}							;
		STRING			 	MasterBuildType					 				{	XPATH('MasterBuildType'											)	}							;
		STRING			 	NewCoverage					 						{	XPATH('NewCoverage'													)	}							;
		STRING			 	Notes					 									{	XPATH('Notes'																)	}							;
		STRING			 	OutputFileType					 				{	XPATH('OutputFileType'											)	}							;
		STRING			 	OutputFileURL						 				{	XPATH('OutputFileURL'												)	}							;
		rPlatforms		Platforms								 				{	XPATH('Platforms'														)	}							;
		STRING			 	Reason						 							{	XPATH('Reason'															)	}							;
		rReceivingDetails			 	ReceivingDetails			{	XPATH('ReceivingDetails'										)	}							;
		STRING			 	ScorecardExclude						 		{	XPATH('ScorecardExclude'										)	}							;
		STRING			 	SequenceId						 					{	XPATH('SequenceId'													)	}							;
		STRING			 	SequenceStatus						 			{	XPATH('SequenceStatus'											)	}							;
		STRING			 	SkippedBuild						 				{	XPATH('SkippedBuild'												)	}							;
		rStatus				Status													{ XPATH('Status'															)	}							;
		rBuidInputs   BuidInputs											{ XPATH('BuidInputs'													)	}							;
		STRING			 	VolumeId						 						{	XPATH('VolumeId'														)	}							;
	END;
	// - 
	rBuildsR 		:= 	RECORD
		rBuildIBR			BuildIBR 											{	XPATH('BuildInstanceBuildResponse'	)	}							;
	END;
	// -
	rResponse		:=	RECORD
		rBuildsR		 	Builds 												{	XPATH('Builds'											)	}							;
		rOrbit			 	OrbitStatus 									{	XPATH('OrbitStatus'									)	}							;
		STRING 				OriginalRequest								{	XPATH('OriginalRequest'							)	}							;
	END;

	OrbitCallQA	:=	SOAPCALL(		UPI_DataBuild__dev.Orbit_Tracking.TargetURL
														,	UPI_DataBuild__dev.Orbit_Tracking.SOAPService(sService)
														,	rRequest
														,	rResponse
														,	XPATH(UPI_DataBuild__dev.Orbit_Tracking.OrbitRR(sService)	)
														,	NAMESPACE(UPI_DataBuild__dev.Orbit_Tracking.Namespace_B)
														,	LITERAL
														,	SOAPACTION(UPI_DataBuild__dev.Orbit_Tracking.SoapPath(sService) )
														, RETRY(2)
														, LOG
													)	;

	OrbitCallPROD	:=	SOAPCALL(		UPI_DataBuild__dev.Orbit_TrackingPROD.TargetURL
														,	UPI_DataBuild__dev.Orbit_TrackingPROD.SOAPService(sService)
														,	rRequest
														,	rResponse
														,	XPATH(UPI_DataBuild__dev.Orbit_TrackingPROD.OrbitRR(sService)	)
														,	NAMESPACE(UPI_DataBuild__dev.Orbit_TrackingPROD.Namespace_B)
														,	LITERAL
														,	SOAPACTION(UPI_DataBuild__dev.Orbit_TrackingPROD.SoapPath(sService) )
														, RETRY(2)
														, LOG
													)	;
		RETURN	IF(OrbitEnv = 'QA', OrbitCallQA, OrbitCallPROD)	;
	
END ; 
 