﻿IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	_Dataset().IsTesting)	:=
		tools.mod_Email_Notification_Lists(	_Control.MyInfo.EmailAddressNotify,	//	pEmailAddressTesting
																				_Control.MyInfo.EmailAddressNotify + ';Carlo.Ramos1@lexisnexis.com'+';Benedict.Flores@lexisnexis.com'+';Christopher.Brodeur@lexisnexisrisk.com'+';intel357@bellsouth.net'+';lea.smith@lexisnexisrisk.com'+';Ailie.Vitto@lexisnexisrisk.com'+';Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressSuccess
																				_Control.MyInfo.EmailAddressNotify + ';Christopher.Brodeur@lexisnexisrisk.com'+';intel357@bellsouth.net'+';Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressFailure
																				_Control.MyInfo.EmailAddressNotify + ';' +
																				RoxieKeyBuild.Email_Notification_List + ';Carlo.Ramos1@lexisnexis.com'+';Benedict.Flores@lexisnexis.com'+';Christopher.Brodeur@lexisnexisrisk.com'+';intel357@bellsouth.net'+';lea.smith@lexisnexisrisk.com'+';Ailie.Vitto@lexisnexisrisk.com'+';Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressRoxie
																				pIsTesting);	//	pIsTesting