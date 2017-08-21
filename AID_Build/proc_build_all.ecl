IMPORT	AID_Build,	versioncontrol,	RoxieKeyBuild,	_control, STD,	BuildLogger;

EXPORT	proc_Build_All(
					STRING	pVersion		=	(STRING8)Std.Date.Today(),
					BOOLEAN	pUpdateDOPS	=	TRUE
				)	:=	MODULE
	
#STORED ('dataset_name', _Dataset().Name); 
#STORED ('version', pVersion);
#STORED ('job_name', _Dataset().Name+'Build');
	
	//	DOPS Commands (Non-FCRA & FCRA
	EXPORT	dops_update				:=	RoxieKeyBuild.updateversion(
																	'AddressLineAIDKeys' 								//	Dataset name
																	,pVersion														//	uversion
																	,_Control.MyInfo.EmailAddressNotify	//	email_t
																	, 																	//	auto_pkg
																	,'N'																//	inenvment	=	'N' - nonfcra
																	,																		//	isboolready = 'Y'
																	,																		//	isprodready = 'N'
																	,																		//	inloc = 'B'
																	,																		//	indaliip = ''
																	,																		//	includeboolean = 'Y'
																	,																		//	updateflag = 'F'
																	,																		//	dops.constants.dopsenvironment
																); 															
	EXPORT	dops_update_FCRA	:=	RoxieKeyBuild.updateversion(
																	'FCRA_AddressLineAIDKeys' 					//	Dataset name
																	,pVersion														//	uversion
																	,_Control.MyInfo.EmailAddressNotify	//	email_t
																	, 																	//	auto_pkg
																	,'F'																//	inenvment	=	'F' - FCRA
																	,																		//	isboolready = 'Y'
																	,																		//	isprodready = 'N'
																	,																		//	inloc = 'B'
																	,																		//	indaliip = ''
																	,																		//	includeboolean = 'Y'
																	,																		//	updateflag = 'F'
																	,																		//	dops.constants.dopsenvironment
																); 															

	//	All filenames associated with this Dataset
	SHARED	dAll_filenames	:=	Keynames().dAll_filenames
															// +	Keynames(,,TRUE).dAll_filenames	//	FCRA
															;

	//	Full Build (excluding commands which require ORBIT
	EXPORT	full_build	:=	SEQUENTIAL(
		BuildLogger.BuildStart(FALSE),
		BuildLogger.PrepStart(FALSE),
		versioncontrol.mUtilities.createsupers(dAll_filenames),
		BuildLogger.PrepEnd(FALSE),
		
		BuildLogger.KeyStart(FALSE),
		AID_Build.proc_Build_Keys(pversion).All,
		BuildLogger.KeyEnd(FALSE),
		BuildLogger.PostStart(FALSE),
		IF(pUpdateDOPS,
			PARALLEL(
				dops_update
				// ,dops_update_FCRA
			)
		),
		BuildLogger.PostEnd(FALSE),
		BuildLogger.BuildEnd(FALSE)
	) : SUCCESS(Send_Emails(pversion).Roxie),
			FAILURE(Send_Emails(pversion).BuildFailure);

	EXPORT	All	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping AID_Build.proc_build_all().All')
	);
end;
