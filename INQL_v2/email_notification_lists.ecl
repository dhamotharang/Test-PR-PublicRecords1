EXPORT Email_Notification_Lists := MODULE

   shared developer 	:= 'Fernando.Incarnacao@lexisnexisrisk.com;';
	 shared manager    := 'jose.bello@lexisnexisrisk.com;'; 
   shared tester 		:= 'debendra.kumar@lexisnexisrisk.com;';
	 shared data_ops   := 'Charles.Pettola@lexisnexisrisk.com;';
	 
	 shared quality_assurance := developer + data_ops;
   shared all_hands := developer + data_ops + manager;
	 
   EXPORT BuildSuccess :=	quality_assurance;
   EXPORT BuildFailure := all_hands;
	 
END;