IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	_Dataset().IsTesting)	:=
		tools.mod_Email_Notification_Lists(	'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',	//	pEmailAddressTesting
																				'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',	//	pEmailAddressSuccess
																				'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',	//	pEmailAddressFailure
																				'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',	//	pEmailAddressRoxie
																				pIsTesting);	//	pIsTesting

