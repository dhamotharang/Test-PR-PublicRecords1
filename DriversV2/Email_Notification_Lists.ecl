IMPORT DriversV2, _Control;

EXPORT Email_Notification_Lists := MODULE

   SHARED tester            := _Control.MyInfo.EmailAddressNotify;
	 SHARED quality_assurance := 'qualityassurance@seisint.com;';
	 SHARED all_hands         := tester + ';' + quality_assurance;

   EXPORT BuildSuccess :=	IF(DriversV2._Flags().IsTesting, tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
   EXPORT Stats        := BuildSuccess;

END;
