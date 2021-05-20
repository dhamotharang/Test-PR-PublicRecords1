IMPORT _control,RoxieKeyBuild, enclarity_facility_sanctions;

EXPORT Email_Notification_Lists := MODULE
   developer := 'jennifer.hennigar@lexisnexisrisk.com; jason.allerdings@lexisnexisrisk.com;';
   //tester := '';
	 //quality_assurance := 'qualityassurance@seisint.com;';
	 //quality_assurance	:= '';
   all_hands := developer;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;