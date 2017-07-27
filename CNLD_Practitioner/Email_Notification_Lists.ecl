IMPORT _Control;

EXPORT Email_Notification_Lists := MODULE
   developer := 'julianne.franzer@lexisnexis.com;';
   tester := _Control.MyInfo.EmailAddressNotify;
	 quality_assurance := 'qualityassurance@seisint.com;';
   all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags.IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;