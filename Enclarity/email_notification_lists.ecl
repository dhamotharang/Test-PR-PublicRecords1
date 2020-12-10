IMPORT _control,RoxieKeyBuild, enclarity;

EXPORT Email_Notification_Lists := MODULE
   developer := 'jennifer.hennigar@lexisnexisrisk.com;';
   tester := 'kevin.reeder@lexisnexisrisk.com; Sudhir.Kasavajjala@lexisnexisrisk.com; Senthilkumar.Periasamy@lexisnexisrisk.com;';
	 quality_assurance := 'lisa.brolsma@lnssi.com;';
	 qa2							:= 'cassandra.howser@lexisnexisrisk.com;';
   all_hands := developer + tester + quality_assurance + qa2;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;