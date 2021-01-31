IMPORT tools,strata;

EXPORT Build_Strata(
	STRING pversion,
	STRING pAddresses,
	BOOLEAN pOverwrite = FALSE,
	DATASET(Layouts.Base) pBaseFile = Files().Base.built,
	STRING pfileversion = 'using',
	BOOLEAN pUseOtherEnviron = tools._Constants.IsDataland,
	DATASET(Layouts.Input.Sprayed) pSprayedFile = Files(pfileversion,pUseOtherEnviron).Input.logical,
	BOOLEAN pIsTesting = tools._Constants.IsDataland
) := FUNCTION

	dUpdate := Strata_stats(pBaseFile,pfileversion,pUseOtherEnviron,pSprayedFile);

	Strata.mac_CreateXMLStats(
		dUpdate.dInputNoGrouping,
		_Constants().Name,
		'Input',
		pversion,
		Send_Emails(pAddresses, pVersion).Call_Email_Notification.buildsuccess,
		BuildInputNoGrouping_Strata,
		'View',
		'Population',
		,pIsTesting,
		pOverwrite
	);

	Strata.mac_CreateXMLStats(
		dUpdate.dUniqueInputNoGrouping,
		_Constants().Name,
		'Input',
		pversion,
		Send_Emails(pAddresses, pVersion).Call_Email_Notification.buildsuccess,
		BuildInputUniqueNoGrouping_Strata,
		'View','Uniques',,
		pIsTesting,
		pOverwrite
	);

	Strata.mac_CreateXMLStats(
		dUpdate.dNoGrouping,
		_Constants().Name,
		'base_file',
		pversion,
		Send_Emails(pAddresses, pVersion).Call_Email_Notification.buildsuccess,
		BuildNoGrouping_Strata,
		'View',
		'Population',,
		pIsTesting,
		pOverwrite
	);

	Strata.mac_CreateXMLStats(
		dUpdate.dCleanAddressState,
		_Constants().Name,
		'base_file',
		pversion,
		Send_Emails(pAddresses, pVersion).Call_Email_Notification.buildsuccess,
		BuildCleanAddressState_Strata,
		'Clean_State',
		'Population',,
		pIsTesting,
		pOverwrite
	);

	Strata.mac_CreateXMLStats(
		dUpdate.dUniqueNoGrouping,
		_Constants().Name,
		'base_file',
		pversion,
		Send_Emails(pAddresses, pVersion).Call_Email_Notification.buildsuccess,
		BuildUniqueNoGrouping_Strata,
		'View',
		'Uniques',,
		pIsTesting,
		pOverwrite
	);

	Strata.mac_CreateXMLStats(
		dUpdate.dUniqueCleanAddressState,
		_Constants().Name,
		'base_file',
		pversion,
		Send_Emails(pAddresses, pVersion).Call_Email_Notification.buildsuccess,
		BuildUniqueCleanAddressState_Strata,
		'Clean_State',
		'Uniques',,
		pIsTesting,pOverwrite
	);

	full_build := PARALLEL(
		BuildInputNoGrouping_Strata,
		BuildInputUniqueNoGrouping_Strata,
		BuildNoGrouping_Strata,
		BuildCleanAddressState_Strata,
		BuildUniqueNoGrouping_Strata,
		BuildUniqueCleanAddressState_Strata
	);

	RETURN IF(
		tools.fun_IsValidVersion(pversion),
		full_build,
		OUTPUT('No Valid version parameter passed, skipping Experian_FEIN.Build_Strata attribute')
	);

END;
