IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	_Dataset().IsTesting)	:=
		tools.mod_Email_Notification_Lists(	_Control.MyInfo.EmailAddressNotify + ';tarun.patel@lexisnexis.com',	//	pEmailAddressTesting
																				_Control.MyInfo.EmailAddressNotify + ';tarun.patel@lexisnexis.com',	//	pEmailAddressSuccess
																				_Control.MyInfo.EmailAddressNotify + ';tarun.patel@lexisnexis.com',	//	pEmailAddressFailure
																				_Control.MyInfo.EmailAddressNotify + ';' +
																				RoxieKeyBuild.Email_Notification_List + ';tarun.patel@lexisnexis.com',	//	pEmailAddressRoxie
																				pIsTesting);	//	pIsTesting