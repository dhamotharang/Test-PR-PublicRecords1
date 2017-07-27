IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE
   developer := 'deryck.murray@lexisnexis.com;andres.perez@lexisnexis.com;';
   tester := _Control.MyInfo.EmailAddressNotify;
	 //quality_assurance := 'qualityassurance@seisint.com;';
	 quality_assurance := 'kevin.reeder@lexisnexis.com;';
   all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;