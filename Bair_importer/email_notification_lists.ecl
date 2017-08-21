IMPORT _control,Bair;

EXPORT Email_Notification_Lists := MODULE
   SHARED elist        := Bair.Email_Notification_Lists;
	 EXPORT	LN_team			 := elist.developer + elist.quality_assurance;
	 EXPORT	developer		 := elist.developer;
	 EXPORT BuildSuccess :=	elist.developer;
   EXPORT BuildFailure := LN_team;
END;