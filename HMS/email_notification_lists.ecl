IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE
   developer := 'ashok.kumar@lexis.nexis.com; andres.perez@lexisnexis.com;';  //'mary.bates@lexisnexis.com;';
   tester := _Control.MyInfo.EmailAddressNotify;
	 quality_assurance := _Control.MyInfo.EmailAddressNotify;//'qualityassurance@seisint.com;';
   all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;