IMPORT	_Control,	RoxieKeyBuild,	tools;

EXPORT	Email_Notification_Lists(BOOLEAN	pIsTesting	=	_Dataset().IsTesting)	:=
	tools.mod_Email_Notification_Lists(	_Control.MyInfo.EmailAddressNotify,	//	pEmailAddressTesting
																			_Control.MyInfo.EmailAddressNotify	+	';Kevin.Garrity@lexisnexisrisk.com',	//	pEmailAddressSuccess
																			_Control.MyInfo.EmailAddressNotify	+	';Kevin.Garrity@lexisnexisrisk.com',	//	pEmailAddressFailure
																			_Control.MyInfo.EmailAddressNotify	+	';' +
																			RoxieKeyBuild.Email_Notification_List	+	';Kevin.Garrity@lexisnexisrisk.com',	//	pEmailAddressRoxie
																			pIsTesting);	//	pIsTesting

