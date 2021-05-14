IMPORT	Business_Credit,	Scrubs_Business_Credit,	BIPV2_Best_SBFE,	Orbit3, ut,
				versioncontrol,	RoxieKeyBuild,	_control, STD,	BuildLogger;

EXPORT	proc_Build_All(
		STRING		pVersion
		,Constants().buildType	pBuildType	= Constants().buildType.Daily
		,STRING		pServerIP			=	Constants().serverIP
		,STRING		pDirectory		=	Constants().Directory
		,STRING		pFilename			=	'*'
		,STRING		pGroupName		=	_Dataset().groupname
		,BOOLEAN	pUpdateDOPS		=	TRUE
		,STRING		pIsProdReady	=	IF(pBuildType	= Constants().buildType.Daily,'Y','N')
		,BOOLEAN	pIsTesting		=	FALSE
		,BOOLEAN	pOverwrite		=	FALSE
	)	:=	MODULE
	
	//	Spray Input Files
	EXPORT spray_files := if(pDirectory != '', fSprayFiles(
		pVersion
		,pServerIP
		,pDirectory 
		,pFilename 
		,pGroupName
		,pIsTesting
		,pOverwrite
	));
	
	//	DOPS Flags and Command
	EXPORT	pUpdateFlag		:=	IF(pBuildType	= Constants().buildType.Daily,'D','F');
	EXPORT	dops_update		:=	RoxieKeyBuild.updateversion('SbfeCvKeys', pVersion, 'Christopher.Brodeur@lexisnexis.com, Sudhir.Kasavajjala@lexisnexisrisk.com', , 'N',isprodready:=pIsProdReady,updateflag:=pUpdateFlag); 															
	
	//	All filenames associated with this Dataset
	SHARED	dAll_filenames	:=	Filenames().dAll_filenames									+	
															Keynames().dAll_filenames										+
															BIPV2_Best_SBFE.Filenames().dAll_filenames	+
															BIPV2_Best_SBFE.Keynames().dAll_filenames;
															
	//  Orbit Entry Creation
  EXPORT	create_build	:=	IF(	ut.Weekday((INTEGER)pVersion[1..8]) NOT IN ['FRIDAY','SUNDAY'],
																Orbit3.proc_Orbit3_CreateBuild ('SBFECV',pVersion,'N'),
																OUTPUT('No Orbit Entry Needed for Friday and Sunday')
														);

	//	Full Build (excluding commands which require ORBIT
	EXPORT	full_build	:=	SEQUENTIAL(
		BuildLogger.BuildStart(false),
		BuildLogger.PrepStart(false),
		versioncontrol.mUtilities.createsupers(dAll_filenames),
		spray_files,
		BuildLogger.PrepEnd(false),
		BuildLogger.BaseStart(False),
		Business_Credit.proc_Build_Base(pversion,pBuildType).All,
		BuildLogger.BaseEnd(False),
		BuildLogger.KeyStart(false),
		Business_Credit.proc_Build_Keys(pversion,pBuildType).All,
		BuildLogger.KeyEnd(false),
		BuildLogger.PostStart(False),
		IF(pUpdateDOPS,
			SEQUENTIAL(
				dops_update,
				create_build
			)
		),
		Business_Credit.QA_Records(),
		Business_Credit.Strata_Population_Stats(pversion,
																						pIsTesting).All,
		BuildLogger.PostEnd(False),
		BuildLogger.BuildEnd(false)
	) : SUCCESS(Send_Emails(pversion).Roxie),
			FAILURE(Send_Emails(pversion).BuildFailure);

	//	Scrubs (Which require ORBIT)
	EXPORT	ScrubsReports	:=	
	IF(VersionControl.IsValidVersion(pversion)
		,SEQUENTIAL(
			// We only ingest data on Daily builds so we will only Scrub the input file when data is available.
			IF(pBuildType	= Constants().buildType.Daily,
				Scrubs_Business_Credit.BuildSCRUBSReport(Filenames(pVersion).Input.Used,pVersion)),
			Scrubs_Business_Credit.PostBuildFullReport(pVersion,pBuildType)
		)
		,OUTPUT('No Valid version parameter passed, skipping Business_Credit.Proc_Build_All().ScrubsReports')
	) : SUCCESS(Send_Emails(pversion,pBuildMessage:='SBFE Scrubs are complete').BuildMessage),
			FAILURE(Send_Emails(pversion).BuildFailure);
	
	EXPORT	All	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping Business_Credit.Proc_Build_All().All')
	);
end;
