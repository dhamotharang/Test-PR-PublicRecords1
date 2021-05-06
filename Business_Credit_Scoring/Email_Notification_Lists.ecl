IMPORT _Control, RoxieKeyBuild, tools;

EXPORT Email_Notification_Lists(BOOLEAN	pIsTesting	=	Business_Credit_Scoring._Dataset().IsTesting)	:=
		tools.mod_Email_Notification_Lists(	'Kranthi.Kumar@lexisnexisrisk.com,Christopher.Brodeur@lexisnexisrisk.com',	//	pEmailAddressTesting
																				'Kranthi.Kumar@lexisnexisrisk.com,Christopher.Brodeur@lexisnexisrisk.com,Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressSuccess
																				'Kranthi.Kumar@lexisnexisrisk.com,Christopher.Brodeur@lexisnexisrisk.com,Sudhir.Kasavajjala@lexisnexisrisk.com',	//	pEmailAddressFailure
																				'Kranthi.Kumar@lexisnexisrisk.com,Christopher.Brodeur@lexisnexisrisk.com,Sudhir.Kasavajjala@lexisnexisrisk.com' + 
																				RoxieKeyBuild.Email_Notification_List,	//	pEmailAddressRoxie
																				pIsTesting,	//	pIsTesting
																				_Control.MyInfo.EmailAddressNotify	//	pEmailAddressStats
																			);

