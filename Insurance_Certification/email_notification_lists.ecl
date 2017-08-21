IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE
   tester := _Control.MyInfo.EmailAddressNotify;
	 quality_assurance := 'qualityassurance@seisint.com;';
   all_hands := tester + ';' + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;