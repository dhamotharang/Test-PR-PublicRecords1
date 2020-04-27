Import _Control, RoxieKeyBuild;

Export Email_Notification_List := Module

	Export developer := 'Maurice.Vigueras@lexisnexisrisk.com'
										+',Veronica.Aldous@lexisnexisrisk.com'
										+',Gabriel.Marcan@lexisnexisrisk.com'
										;

	Export dops := 'Maurice.Vigueras@lexisnexisrisk.com'
										+',Veronica.Aldous@lexisnexisrisk.com'
										+',Gabriel.Marcan@lexisnexisrisk.com'
										;



  Export tester  := _Control.MyInfo.EmailAddressNotify;
  
  Export all_hands := developer + tester + ';' + dops;

 Export BuildSuccess := if(_flags().IsTesting, developer + tester, all_hands );

 Export BuildFailure := BuildSuccess;



End;