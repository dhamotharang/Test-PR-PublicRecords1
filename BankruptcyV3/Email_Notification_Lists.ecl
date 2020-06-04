IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	_Dataset().IsTesting)	:=
		tools.mod_Email_Notification_Lists(	_Control.MyInfo.EmailAddressNotify,	//	pEmailAddressTesting
																				_Control.MyInfo.EmailAddressNotify + ';Christopher.Brodeur@lexisnexis.com'+';intel357@bellsouth.net',	//	pEmailAddressSuccess
																				_Control.MyInfo.EmailAddressNotify + ';Christopher.Brodeur@lexisnexis.com'+';intel357@bellsouth.net',	//	pEmailAddressFailure
																				_Control.MyInfo.EmailAddressNotify + ';' +
																				RoxieKeyBuild.Email_Notification_List + ';Christopher.Brodeur@lexisnexis.com'+';intel357@bellsouth.net',	//	pEmailAddressRoxie
																				pIsTesting);	//	pIsTesting

