IMPORT	BankruptcyV3,	BankruptcyV2,	versioncontrol,	Scrubs,	scrubs_bk_withdrawnstatus,	STD,	ut,	tools;
EXPORT	proc_build_withdrawnstatus(
		STRING		pVersion			=	(STRING)STD.Date.Today()
		,STRING		pServerIP			=	BankruptcyV2.Constants(pVersion).serverIP
		,STRING		pDirectory		=	BankruptcyV2.Constants(pVersion).Directory
		,STRING		pFilename			=	'BKV3_Log_*.txt'
		,STRING		pGroupName		=	_Dataset().groupname
		,BOOLEAN	pIsTesting		=	FALSE
		,BOOLEAN	pOverwrite		=	FALSE
	)	:=	MODULE

	//	Spray WithdrawnStatus Files
	EXPORT spray_files := if(pDirectory != '', fSprayFiles(
		pVersion
		,pServerIP
		,pDirectory 
		,pFilename 
		,pGroupName
		,pIsTesting
		,pOverwrite
	));
	
	//	All filenames associated with WithdrawnStatus
	SHARED	dAll_filenames	:=	Filenames().dAll_filenames	+	
															Keynames().dAll_filenames		+
															Keynames(,,TRUE).dAll_filenames;

	//	Full Build (excluding commands which require ORBIT
	EXPORT	build_withdrawnstatus	:=	SEQUENTIAL(
		versioncontrol.mUtilities.createsupers(dAll_filenames),
		spray_files,
		BankruptcyV3.fn_processWithdrawnStatus(pVersion).All,
	) : SUCCESS(Send_Emails(pVersion,pBuildMessage:='WithdrawnStatus Basefile Build is complete').BuildMessage),
			FAILURE(Send_Emails(pVersion).BuildFailure);

	SHARED	recordsToScrub	:=	scrubs_bk_withdrawnstatus.In_bk_withdrawnstatus(STD.Str.FindCount(__filename,pVersion)>0);
	//	Scrubs (Which require ORBIT)
	EXPORT	Scrubs	:=	
	IF(VersionControl.IsValidVersion(pVersion)
		,SEQUENTIAL(
			Scrubs.ScrubsPlus_PassFile(	recordsToScrub,
																	'bk_withdrawnstatus',
																	'scrubs_bk_withdrawnstatus',
																	'scrubs_bk_withdrawnstatus',
																	'',
																	pVersion,
																	Email_Notification_Lists().Stats);
		)
		,OUTPUT('No Valid version parameter passed, skipping BankruptcyV3.proc_build_withdrawnstatus().ScrubsReports')
	) : SUCCESS(Send_Emails(pVersion,pBuildMessage:='WithdrawnStatus Scrubs are complete').BuildMessage),
			FAILURE(Send_Emails(pVersion).BuildFailure);
	
	EXPORT	All	:=
	IF(VersionControl.IsValidVersion(pVersion)
		,build_withdrawnstatus
		,OUTPUT('No Valid version parameter passed, skipping BankruptcyV3.proc_build_withdrawnstatus().All')
	);
end;
