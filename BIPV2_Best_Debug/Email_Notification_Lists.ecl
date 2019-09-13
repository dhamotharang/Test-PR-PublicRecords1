IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	_Constants().IsTesting)	:=
		tools.mod_Email_Notification_Lists(	_Control.MyInfo.EmailAddressNotify,	//	pEmailAddressTesting
																				_Control.MyInfo.EmailAddressNotify + ';Kevin.Garrity@lexisnexis.com',	//	pEmailAddressSuccess
																				_Control.MyInfo.EmailAddressNotify + ';Kevin.Garrity@lexisnexis.com',	//	pEmailAddressFailure
																				_Control.MyInfo.EmailAddressNotify + ';' +
																				RoxieKeyBuild.Email_Notification_List + ';Kevin.Garrity@lexisnexis.com',	//	pEmailAddressRoxie
																				pIsTesting);	//	pIsTesting