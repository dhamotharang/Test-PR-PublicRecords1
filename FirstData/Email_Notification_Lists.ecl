IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	_Dataset().pIsTesting)	:=
		tools.mod_Email_Notification_Lists(	_Control.MyInfo.EmailAddressNotify,	//	pEmailAddressTesting
																				_Control.MyInfo.EmailAddressNotify + ';xia.sheng@lexisnexisrisk.com' + ';Charlene.Ros@lexisnexisrisk.com',	//	pEmailAddressSuccess
																				_Control.MyInfo.EmailAddressNotify + ';xia.sheng@lexisnexisrisk.com' + ';Charlene.Ros@lexisnexisrisk.com',	//	pEmailAddressFailure
																				_Control.MyInfo.EmailAddressNotify + ';' +
																				RoxieKeyBuild.Email_Notification_List + ';xia.sheng@lexisnexisrisk.com' + ';Charlene.Ros@lexisnexisrisk.com',	//	pEmailAddressRoxie
																				pIsTesting);	//	pIsTesting
