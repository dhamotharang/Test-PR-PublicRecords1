IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	_Dataset().IsTesting)	:=
		tools.mod_Email_Notification_Lists(	'Christopher.Brodeur@lexisnexisrisk.com, Kranthi.Kumar@lexisnexisrisk.com', //	pEmailAddressTesting
																				'Kranthi.Kumar@lexisnexisrisk.com'+';Carlo.Ramos1@lexisnexisrisk.com'+';Benedict.Flores@lexisnexisrisk.com'+';Christopher.Brodeur@lexisnexisrisk.com'+';lea.smith@lexisnexisrisk.com'+';Ailie.Vitto@lexisnexisrisk.com'+';Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressSuccess
																				'Kranthi.Kumar@lexisnexisrisk.com'+';Christopher.Brodeur@lexisnexisrisk.com'+';Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressFailure
																				RoxieKeyBuild.Email_Notification_List + ';Kranthi.Kumar@lexisnexisrisk.com'+';Carlo.Ramos1@lexisnexisrisk.com'+';Benedict.Flores@lexisnexisrisk.com'+';Christopher.Brodeur@lexisnexisrisk.com'+';lea.smith@lexisnexisrisk.com'+';Ailie.Vitto@lexisnexisrisk.com'+';Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressRoxie
																				pIsTesting);	//	pIsTesting