IMPORT STD, VersionControl, tools;

EXPORT Send_Emails(
	STRING pAddresses,
	STRING pVersion,
	STRING pMessage = ''
) := MODULE
	SHARED addresses := STD.Str.SplitWords(pAddresses, ',');

	EXPORT Call_Email_Notification := tools.mod_Email_Notification_Lists(
		addresses[1],
		addresses[1] + ';' + addresses[2] + ';',
		addresses[1] + ';' + addresses[2] + ';',
		addresses[1],,
		addresses[1] + ';' + addresses[2] + ';' + addresses[3] + ';'
	);

	EXPORT BuildSuccess := tools.fun_SendEmail(
		Call_Email_Notification.BuildSuccess,
		_Dataset().Name + ' Build Succeeded ' + pVersion,
		workunit
	);

	EXPORT BuildFailure := tools.fun_SendEmail(
		Call_Email_Notification.BuildFailure,
		_Dataset().Name + ' Build ' + pVersion + ' Failed',
		workunit + '\n' + failmessage
	);
END;
