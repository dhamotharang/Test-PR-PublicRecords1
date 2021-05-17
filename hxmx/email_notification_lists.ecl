IMPORT _control,RoxieKeyBuild, hxmx;

EXPORT Email_Notification_Lists := MODULE
   EXPORT developer := 'deryck.murray@lexisnexisrisk.com;jason.allerdings@lexisnexisrisk.com;';
   EXPORT tester := 'jason.allerdings@lexisnexisrisk.com';
	 //quality_assurance := 'qualityassurance@seisint.com;';
	 EXPORT quality_assurance := 'deryck.murray@lexisnexisrisk.com; jason.allerdings@lexisnexisrisk.com;';
   EXPORT all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(hxmx._Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;