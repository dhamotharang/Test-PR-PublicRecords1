IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE
   developer := 'jose.bello@lexisnexisrisk.com;debendra.kumar@lexisnexisrisk.com;';
   tester := _Control.MyInfo.EmailAddressNotify;
   quality_assurance := 'jose.bello@lexisnexisrisk.com;';
   all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
   
END;