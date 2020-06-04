EXPORT Email_Notification_Lists := MODULE

   shared developer 	:= 'Fernando.Incarnacao@lexisnexisrisk.com;';
	 shared ops         := 'charles.pettola@lexisnexisrisk.com;';
   shared manager 		:= 'jose.bello@lexisnexisrisk.com;';
	 shared qa          := 'Prasanna.Kolli@lexisnexisrisk.com';
	 
   EXPORT BuildSuccess :=	developer + ops;
   EXPORT BuildFailure := developer + ops + manager;
	 EXPORT DopsUpdate   := developer + ops + qa;
	 
END;