EXPORT Email_Notification_Lists := MODULE

   developer 	:= 'jose.bello@lexisnexisrisk.com; debendra.kumar@lexisnexisrisk.com;Fernando.Incarnacao@lexisnexisrisk.com;';
   tester 		:= 'Wenhong.Ma@lexisnexisrisk.com;Fernando.Incarnacao@lexisnexisrisk.com;';//'Darren.Knowles@lexisnexis.com; Sudhir.Kasavajjala@lexisnexisrisk.com;';
	 quality_assurance := 'Fernando.Incarnacao@lexisnexisrisk.com;';
   all_hands := developer + tester + quality_assurance;
	 
   EXPORT BuildSuccess :=	all_hands;
   EXPORT BuildFailure := BuildSuccess;
	 
END;