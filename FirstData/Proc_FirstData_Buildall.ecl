IMPORT FirstData, BuildLogger, VersionControl, STD, Orbit3;
EXPORT Proc_FirstData_buildall(
		STRING		pVersion					=	(STRING)STD.Date.Today()
		,STRING		pServerIP			=	FirstData.Constants(pVersion).serverIP
		,STRING		pDirectory		=	FirstData.Constants(pVersion).Directory + pVersion + '/'
		,STRING		pFilename			=	'*csv'
		,STRING		pGroupName		=	_Dataset().pGroupname
		,BOOLEAN	pIsTesting		=	FALSE
		,BOOLEAN	pOverwrite		=	FALSE
	)	:=	MODULE

	//Spray files.  
	EXPORT	SprayFiles			:= IF(pDirectory != '', 
																									FirstData.fSprayFiles
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
	EXPORT	orbit_entry	:=	Orbit3.proc_Orbit3_CreateBuild('First Data',pVersion,'N');
	
	//	Full Build
	EXPORT	full_build	:=	SEQUENTIAL(
			BuildLogger.BuildStart(false),
			BuildLogger.PrepStart(false),
			versioncontrol.mUtilities.createsupers(dAll_filenames),
			SprayFiles,
			BuildLogger.PrepEnd(false),
			BuildLogger.BaseStart(False),
			FirstData.Build_BaseFile(pversion).ALL,
			BuildLogger.BaseEnd(False),
			BuildLogger.PostStart(False),
			FirstData.QA_Records(),
			// FirstData.Strata_Population_Stats(pversion,pIsTesting).All,
			BuildLogger.PostEnd(False),
			orbit_entry,
			BuildLogger.BuildEnd(false)
	) : SUCCESS(Send_Emails(pversion).BuildSuccess),
					FAILURE(Send_Emails(pversion).BuildFailure);

	EXPORT	All	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping FirstData.Proc_FirstData_Buildall().All')
	);
end;
