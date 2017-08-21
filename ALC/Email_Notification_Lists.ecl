IMPORT ALC, _Control;

EXPORT Email_Notification_Lists := MODULE

   SHARED developer         := 'albert.metzmaier@lexisnexis.com;';
   SHARED tester            := _Control.MyInfo.EmailAddressNotify;
	 SHARED quality_assurance := 'qualityassurance@seisint.com;';
	 SHARED all_hands         := developer + tester + ';' + quality_assurance;

   EXPORT BuildSuccess :=	IF(ALC._Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
   EXPORT Stats        := BuildSuccess;

END;
