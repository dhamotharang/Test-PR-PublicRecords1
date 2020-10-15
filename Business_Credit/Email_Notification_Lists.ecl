IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	_Dataset().IsTesting)	:=
		tools.mod_Email_Notification_Lists(	'Christopher.Brodeur@lexisnexisrisk.com',	//	pEmailAddressTesting
																				'Carlo.Ramos1@lexisnexis.com'+';Benedict.Flores@lexisnexis.com'+';Christopher.Brodeur@lexisnexisrisk.com'+';lea.smith@lexisnexisrisk.com'+';Ailie.Vitto@lexisnexisrisk.com'+';Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressSuccess
																				'Christopher.Brodeur@lexisnexisrisk.com'+';Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressFailure
																				RoxieKeyBuild.Email_Notification_List + ';Carlo.Ramos1@lexisnexis.com'+';Benedict.Flores@lexisnexis.com'+';Christopher.Brodeur@lexisnexisrisk.com'+';lea.smith@lexisnexisrisk.com'+';Ailie.Vitto@lexisnexisrisk.com'+';Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressRoxie
																				pIsTesting);	//	pIsTesting