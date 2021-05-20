IMPORT _control,RoxieKeyBuild, hxmx;

EXPORT Email_Notification_Lists := MODULE
   EXPORT developer := 'jason.allerdings@lexisnexisrisk.com;kevin.reeder@lexisnexisrisk.com';
   //EXPORT tester := '';
	 //quality_assurance := 'qualityassurance@seisint.com;';
	 EXPORT quality_assurance := 'jason.allerdings@lexisnexisrisk.com;';
   EXPORT all_hands := developer  + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(hxmx._Flags().IsTesting, developer, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;