IMPORT	LiensV2_SrcInfoRpt,	Orbit3, ut,
				versioncontrol,	RoxieKeyBuild,	_control, STD,	BuildLogger;

EXPORT	proc_Build_All(
		STRING		pVersion			=	(STRING)STD.Date.Today()
		,STRING		pServerIP			=	Constants().serverIP
		,STRING		pDirectory		=	Constants().Directory
		,STRING		pFilename			=	'*RiskView*'
		,STRING		pGroupName		=	_Dataset().groupname
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
	
	//	All filenames associated with this Dataset
	SHARED	dAll_filenames	:=	Filenames().dAll_filenames;
															
	//	Full Build (excluding commands which require ORBIT
	EXPORT	full_build	:=	SEQUENTIAL(
		BuildLogger.BuildStart(FALSE),
		BuildLogger.PrepStart(FALSE),
		versioncontrol.mUtilities.createsupers(dAll_filenames),
		spray_files,
		BuildLogger.PrepEnd(FALSE),
		BuildLogger.BaseStart(FALSE),
		LiensV2_SrcInfoRpt.proc_Build_Base(pversion).All,
		BuildLogger.BaseEnd(FALSE),
		BuildLogger.PostStart(FALSE),
		LiensV2_SrcInfoRpt.QA_Records(),
		// LiensV2_SrcInfoRpt.Strata_Population_Stats(	pversion,
																								// pIsTesting).All,
		BuildLogger.PostEnd(FALSE),
		BuildLogger.BuildEnd(FALSE)
	) : SUCCESS(Send_Emails(pversion).BuildSuccess),
			FAILURE(Send_Emails(pversion).BuildFailure);

	EXPORT	All	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping LiensV2_SrcInfoRpt.Proc_Build_All().All')
	);
end;
