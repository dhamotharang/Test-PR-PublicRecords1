IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE
   //developer := 'angela.herzberg@lexisnexis.com;';
	 developer := 'vlad.petrokas@lexisnexisrisk.com;';
   tester := _Control.MyInfo.EmailAddressNotify;
	 //quality_assurance := 'qualityassurance@seisint.com;';
	 //quality_assurance := 'angela.herzberg@lexisnexis.com;';
	 quality_assurance := 'vlad.petrokas@lexisnexisrisk.com;';
   all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;