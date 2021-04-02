EXPORT Email_Notification_Lists := MODULE

   shared developer 	:= 'vlad.petrokas@lexisnexisrisk.com;';
	shared manager    := 'Gabriel.Marcan@lexisnexisrisk.com;';
   shared tester 		:= 'John.Granatino@lexisnexisrisk.com;';
	shared data_ops   := 'vlad.petrokas@lexisnexisrisk.com;';
	 
	shared quality_assurance := developer + data_ops + tester;
   shared all_hands := developer + tester + data_ops + manager;
	 
   EXPORT BuildSuccess :=	quality_assurance;
   EXPORT BuildFailure := all_hands;
	 
END;