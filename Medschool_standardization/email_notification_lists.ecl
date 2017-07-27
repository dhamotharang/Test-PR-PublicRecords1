IMPORT _control,Medschool_standardization;

EXPORT Email_Notification_Lists := MODULE
   developer := 'jaideep.habbu@lexisnexis.com;';
   tester := _Control.MyInfo.EmailAddressNotify;
	 //quality_assurance := 'qualityassurance@seisint.com;';
	 quality_assurance := 'jaideep.habbu@lexisnexis.com;';
   all_hands := developer + tester + ';' + quality_assurance;
	 
 EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
 EXPORT BuildFailure := BuildSuccess;
END;