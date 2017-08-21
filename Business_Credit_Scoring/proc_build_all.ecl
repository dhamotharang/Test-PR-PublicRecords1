IMPORT	Business_Credit_Scoring,	versioncontrol,	RoxieKeyBuild,	_control, STD,	ut;

EXPORT	proc_Build_All(	STRING	pVersion		=	ut.GetDate,
												INTEGER	pThreads		=	Constants().threads,
												STRING	pRoxieIP		=	Constants().RoxieIP,
												BOOLEAN	pIsTesting	=	FALSE,
												BOOLEAN	pOverwrite	=	FALSE	
											)	:=	MODULE

	//	DOPS Flags and Command
	EXPORT	pUpdateFlag		:=	'F';	//	Always a Full Build
	EXPORT	pIsProdReady	:=	'N';	//	Must be QA'd First
	EXPORT	dops_update		:=	RoxieKeyBuild.updateversion('SbfeCvScoringKeys', pVersion, _Control.MyInfo.EmailAddressNotify+';Christopher.Brodeur@lexisnexis.com', , 'N',isprodready:=pIsProdReady,updateflag:=pUpdateFlag); 															
	
	//	All filenames associated with this Dataset
	SHARED	dAll_filenames	:=	filenames().dAll_filenames	+	keynames().dAll_filenames;

	//	Full Build
	EXPORT	full_build	:=	SEQUENTIAL(
		versioncontrol.mUtilities.createsupers(dAll_filenames),
		Business_Credit_Scoring.proc_Build_Base(pversion,pThreads,pRoxieIP).All,
		Business_Credit_Scoring.proc_Build_Keys(pversion).All,
		dops_update,
		Business_Credit_Scoring.QA_Records(),
		Business_Credit_Scoring.Strata_Population_Stats(pVersion,pIsTesting).All
	) : SUCCESS(Send_Emails(pversion).Roxie),
			FAILURE(Send_Emails(pversion).BuildFailure);
	
	EXPORT	All	:=
	IF(VersionControl.IsValidVersion(pversion)
		,full_build
		,OUTPUT('No Valid version parameter passed, skipping Business_Credit_Scoring.Proc_Build_All().All')
	);
end;
