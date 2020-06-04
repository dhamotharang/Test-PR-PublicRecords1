IMPORT	Orbit3, ut, versioncontrol,	RoxieKeyBuild,	_control, STD,	BuildLogger;

EXPORT	proc_Build_All(
STRING	pVersion
    ,Constants.buildType	  pBuildType	= Constants.buildType.Daily
    ,STRING		pServerIP			=	Constants.serverIP
    ,STRING		pDirectory		=	Constants.Directory
    ,STRING		pFilename			=	'*'
    ,STRING		pGroupName		=	'thor400_dev01'//_Dataset().groupname
    ,BOOLEAN	pUpdateDOPS		=	TRUE
    ,STRING		pIsProdReady	=	IF(pBuildType	= Constants.buildType.Daily,'Y','N')
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
	// EXPORT	pUpdateFlag		:=	IF(pBuildType	= Constants().buildType.Daily,'D','F');
	// EXPORT	dops_update		:=	RoxieKeyBuild.updateversion('GatewayCollectionKeys', pVersion, _Control.MyInfo.EmailAddressNotify+';vani.chikte@lexisnexis.com', , 'N',isprodready:=pIsProdReady,updateflag:=pUpdateFlag); 															
	
	//	All filenames associated with this Dataset
	SHARED	dAll_filenames	:=	Filenames().dAll_filenames									+	
                              Keynames().dAll_filenames										;
															
	// Orbit Entry Creation
  // EXPORT	create_build	:=	IF(	ut.Weekday((INTEGER)pVersion[1..8]) NOT IN ['FRIDAY','SUNDAY'],
																// Orbit3.proc_Orbit3_CreateBuild ('SBFECV',pVersion,'N'),
																// OUTPUT('No Orbit Entry Needed for Friday and Sunday')
														// );

	//	Full Build (excluding commands which require ORBIT
	EXPORT	full_build	:=	SEQUENTIAL(
    versioncontrol.mUtilities.createsupers(dAll_filenames),
    spray_files,
    gateway_collection_log.Proc_build_base(pversion,pBuildType).All,
    gateway_collection_log.proc_Build_Keys(pversion,pBuildType).All

    // IF(pUpdateDOPS,
       // SEQUENTIAL(
          // dops_update,
          // create_build
       // )
    // ),
    // Business_Credit.QA_Records(),
    // Business_Credit.Strata_Population_Stats(pversion,
                                            // pIsTesting).All,
	) : SUCCESS(Send_Emails(pversion).Roxie),
			FAILURE(Send_Emails(pversion).BuildFailure);


	EXPORT	All	:=
	   IF(VersionControl.IsValidVersion(pversion)
		   ,full_build
		   ,OUTPUT('No Valid version parameter passed, skipping Proc_Build_All().All')
	     );
end;
