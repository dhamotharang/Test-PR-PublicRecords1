IMPORT ut, VersionControl, dops, tools, _control, Scrubs, STD, Scrubs_Experian_FEIN;

EXPORT Build_All(
	STRING  pVersion,
	STRING  pHostname,
	STRING  pAbsolutePath,
	STRING  pGlob,
	STRING  pAddresses,
	STRING  pCluster = 'Thor400_44',
	INTEGER pRecordsize = 291,
	BOOLEAN	pIsTesting = false,
	BOOLEAN	pOverwrite = false,
	DATASET(Layouts.Input.sprayed) pSprayedFile = Files().Input.using,
	DATASET(Layouts.Base) pBaseFile = Files().base.qa
) := FUNCTION

	full_build := SEQUENTIAL(
		Create_Supers,
		VersionControl.fSprayInputFiles(
			Spray(
				pHostname,
				pAbsolutePath,
				pGlob,
				pRecordsize,
				pVersion,
				pCluster	
			).Input
		),
		Build_Base(pVersion,pIsTesting,pSprayedFile,pBaseFile),
		Scrubs.ScrubsPlus(
			'Experian_FEIN',
			'Scrubs_Experian_FEIN',
			'Scrubs_Experian_FEIN_Base',
			'Base',
			pVersion,
			Send_Emails(pAddresses, pVersion).Call_Email_Notification.Stats,		
			false
		),
		Build_Keys(pVersion).all,
		dops.updateversion(
			'ExperianFEINKeys',
			pVersion,
			Send_Emails(pAddresses, pVersion).Get_Primary_Addresses,,
			'N'
		),
		Build_Strata(pVersion,pOverwrite,,,pIsTesting),
		Promote().Inputfiles.using2used,
		Promote().Buildfiles.Built2QA,
		QA_Records()
	): SUCCESS(Send_Emails(pAddresses, pVersion).BuildSuccess), FAILURE(Send_Emails(pAddresses, pVersion).BuildFailure);
	
	RETURN

	IF(
		tools.fun_IsValidVersion(pVersion),
		full_build,
		OUTPUT('No Valid version parameter passed, skipping Experian_FEIN.Build_All')
	);

END;
