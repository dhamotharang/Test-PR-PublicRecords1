IMPORT OKC_Probate, BuildLogger, VersionControl, STD, Orbit3;
EXPORT Proc_OKC_Probate_buildall(
		STRING		pVersion					=	(STRING)STD.Date.Today()
		,STRING		pServerIP			=	OKC_Probate.Constants(pVersion).serverIP
		,STRING		pDirectory		=	OKC_Probate.Constants(pVersion).Directory + pVersion
		,STRING		pFilename			=	'*csv'
		,STRING		pGroupName		=	_Dataset().groupname
		,BOOLEAN	pIsTesting		=	FALSE
		,BOOLEAN	pOverwrite		=	FALSE
	)	:=	MODULE

	//Spray files.  
	EXPORT	SprayFiles			:= IF(pDirectory != '', 
																									OKC_Probate.fSprayFiles
																									(
																										pVersion
																										,pServerIP
																										,pDirectory 
																										,pFilename 
																										,pGroupName
																										,pIsTesting
																										,pOverwrite
																									)
																								);
	
	//	All filenames associated with this Dataset
	SHARED	dAll_filenames	:=	Filenames().dAll_filenames;

	//	Orbit Entry Creation
	EXPORT	orbit_entry	:=	Orbit3.proc_Orbit3_CreateBuild('Probate Death Records',pVersion,'N');

	//	Full Build
	EXPORT	full_build	:=	SEQUENTIAL(
			BuildLogger.BuildStart(false),
			BuildLogger.PrepStart(false),
			versioncontrol.mUtilities.createsupers(dAll_filenames),
			SprayFiles,
			BuildLogger.PrepEnd(false),
			BuildLogger.BaseStart(False),
			OKC_Probate.Proc_OKC_Probate_buildfiles(pversion).All,
			BuildLogger.BaseEnd(False),
			BuildLogger.PostStart(False),
			OKC_Probate.QA_Records(),
			OKC_Probate.Strata_Population_Stats(pversion,
																							pIsTesting).All,
			BuildLogger.PostEnd(False),
			orbit_entry,
			BuildLogger.BuildEnd(false)
	) : SUCCESS(Send_Emails(pversion).BuildSuccess),
					FAILURE(Send_Emails(pversion).BuildFailure);

	//	Scrubs (Which require ORBIT)
	// EXPORT	ScrubsReports	:=	
	// IF(VersionControl.IsValidVersion(pVersion)
		// ,Scrubs_OKC_Probate.PostBuildScrubs(pVersion)
		// ,OUTPUT('No Valid version parameter passed, skipping OKC_Probate.Proc_OKC_Probate_buildall().ScrubsReports')
	// ) : SUCCESS(Send_Emails(pversion,pBuildMessage:='OKC Probate Scrubs are complete').BuildMessage),
					// FAILURE(Send_Emails(pversion).BuildFailure);
	
	EXPORT	All	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping OKC_Probate.Proc_OKC_Probate_buildall().All')
	);
end;
