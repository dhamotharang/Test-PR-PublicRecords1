IMPORT STD, _control, tools;

EXPORT Send_Email(STRING pVersion, STRING pAddresses, STRING pMessage='', BOOLEAN pIsTesting = false):= MODULE
	
	EXPORT build_success := fileservices.sendemail(
		Email_Notification_Lists(pAddresses, pIsTesting).BuildSuccess,
		'DNBFEINV2 Roxie Build Succeeded ' + pVersion,
		'Sample records located in WUID: ' + workunit
	);

	EXPORT build_failure := fileservices.sendemail(
		Email_Notification_Lists(pAddresses, pIsTesting).BuildFailure,
		'DNBFEINV2 '+pVersion+' Roxie Build FAILED',
		'WUID: ' + workunit + '\n' + pMessage
	);

	EXPORT build_completion	:= fileservices.sendemail(
		Email_Notification_Lists(pAddresses, pIsTesting).BuildSuccess,
		'DNBFEINV2 Full Build Process Completed ' + pVersion,
		'WUID: ' + workunit
	);

END;
