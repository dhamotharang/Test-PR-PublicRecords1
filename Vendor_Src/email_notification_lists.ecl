IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE
	 EXPORT developer := 'vlad.petrokas@lexisnexisrisk.com;';
   tester := 'Harry.Gist@lexisnexisrisk.com;';
	 quality_assurance := 'vlad.petrokas@lexisnexisrisk.com;';
   all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
 
END;