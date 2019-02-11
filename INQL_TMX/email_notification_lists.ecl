IMPORT _control, RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE

   // KJE - ORIG - developer := 'jose.bello@lexisnexisRisk.com;';
   developer := 'karl.engvold@lexisnexisrisk.com;';
   
   tester := _Control.MyInfo.EmailAddressNotify;
   
	 //KJE - ORIG - quality_assurance := 'qualityassurance@seisint.com;';
	 quality_assurance := 'karl.engvold@lexisnexisrisk.com;';
   
   all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
   
   EXPORT BuildFailure := BuildSuccess;
   
END;