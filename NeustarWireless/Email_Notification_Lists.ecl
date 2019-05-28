IMPORT _Control, RoxieKeyBuild, tools;

//Return values are BuildFailure, BuildSuccess, Roxie, Stats
EXPORT Email_Notification_Lists()	:=
		tools.mod_Email_Notification_Lists(	pEmailAddressTesting := _Control.MyInfo.EmailAddressNotify ,	
																				pEmailAddressSuccess := _Control.MyInfo.EmailAddressNotify + ';John.Freibaum@lexisnexisrisk.com;Dawn.Czajak@lexisnexisrisk.com',	
																				pEmailAddressFailure := _Control.MyInfo.EmailAddressNotify + ';John.Freibaum@lexisnexisrisk.com;Dawn.Czajak@lexisnexisrisk.com',	
																				pEmailAddressRoxie 	 := _Control.MyInfo.EmailAddressNotify + ';' + RoxieKeyBuild.Email_Notification_List + ';John.Freibaum@lexisnexisrisk.com;Dawn.Czajak@lexisnexisrisk.com',	
																				pIsTesting					 := tools._Constants.IsDataland,
																				pEmailAddressStats   :=  _Control.MyInfo.EmailAddressNotify + ';John.Freibaum@lexisnexisrisk.com;Dawn.Czajak@lexisnexisrisk.com' );	
																				
																				

