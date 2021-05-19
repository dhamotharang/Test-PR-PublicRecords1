IMPORT _control,RoxieKeyBuild, Emdeon;

EXPORT Email_Notification_Lists := MODULE

   EXPORT developer := 'deryck.murray@lexisnexisrisk.com;jason.allerdings@lexinexisrisk.com;';
   //EXPORT tester := '';
	 //quality_assurance := 'qualityassurance@seisint.com;';
	 EXPORT quality_assurance := 'deryck.murray@lexisnexisrisk.com;jason.allerdings@lexisnexisrisk.com;';
   EXPORT all_hands := developer + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(Emdeon._Flags().IsTesting, developer, all_hands);
   EXPORT BuildFailure := BuildSuccess;
	 
END;