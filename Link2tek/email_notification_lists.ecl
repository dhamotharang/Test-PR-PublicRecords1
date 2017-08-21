IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE
   developer := 'jennifer.hennigar@lexisnexis.com;';
   // tester := _Control.MyInfo.EmailAddressNotify;
	 quality_assurance := 'jennifer.hennigar@lexisnexis.com;';
   all_hands := developer /*+ tester*/ + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer /*+ tester*/, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;