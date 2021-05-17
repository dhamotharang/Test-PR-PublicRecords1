IMPORT _control,RoxieKeyBuild, enclarity_facility_sanctions;

EXPORT Email_Notification_Lists := MODULE
   developer := 'jennifer.hennigar@lexisnexisrisk.com; jason.allerdings@lexisnexisrisk.com;';
   tester := 'jason.allerdings@lexisnexisrisk.com;';
	 //quality_assurance := 'qualityassurance@seisint.com;';
	 quality_assurance	:= 'jason.allerdings@lexisnexisrisk.com;';
   all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;