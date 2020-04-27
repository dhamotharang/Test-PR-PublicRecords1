IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	Business_Credit_Scoring._Dataset().IsTesting)	:=
		tools.mod_Email_Notification_Lists(	_Control.MyInfo.EmailAddressNotify,	//	pEmailAddressTesting
																				_Control.MyInfo.EmailAddressNotify,	//	pEmailAddressSuccess
																				_Control.MyInfo.EmailAddressNotify,	//	pEmailAddressFailure
																				_Control.MyInfo.EmailAddressNotify + ';' +
																				RoxieKeyBuild.Email_Notification_List,	//	pEmailAddressRoxie
																				pIsTesting,	//	pIsTesting
																				_Control.MyInfo.EmailAddressNotify	//	pEmailAddressStats
																			);

