IMPORT roxiekeybuild, tools, STD;

EXPORT Email_Notification_Lists(
	STRING  pAddresses, 
	BOOLEAN pIsTesting = _Constants().IsTesting
) := tools.mod_Email_Notification_Lists(
	STD.Str.FindReplace(pAddresses, ',', ';') + ';',
	STD.Str.FindReplace(pAddresses, ',', ';') + ';',
	STD.Str.FindReplace(pAddresses, ',', ';') + ';',
	STD.Str.FindReplace(pAddresses, ',', ';') + ';',
	pIsTesting,
	STD.Str.FindReplace(pAddresses, ',', ';') + ';'
) : DEPRECATED('Use Send_Mails instead.');
