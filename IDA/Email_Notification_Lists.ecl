EXPORT Email_Notification_Lists := MODULE

   shared developer 	:= 'vlad.petrokas@lexisnexisrisk.com;';
	 shared manager    := 'vlad.petrokas@lexisnexisrisk.com;';
   shared tester 		:= 'vlad.petrokas@lexisnexisrisk.com;';
	 shared data_ops   := 'vlad.petrokas@lexisnexisrisk.com;';
	 
	 shared quality_assurance := developer + data_ops;
   shared all_hands := developer + data_ops + manager;
	 
   EXPORT BuildSuccess :=	quality_assurance;
   EXPORT BuildFailure := all_hands;
	 
END;