IMPORT _Control;

EXPORT Email_Notification_Lists := MODULE
   EXPORT developer := _Control.MyInfo.EmailAddressNotify + ';albert.metzmaier@lexisnexis.com;';
   EXPORT tester 	 := _Control.MyInfo.EmailAddressNotify;
	 EXPORT quality_assurance := 'qualityassurance@seisint.com;';
	 EXPORT stats		 := _Control.MyInfo.EmailAddressNotify;
   EXPORT all_hands := developer + tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags.IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;