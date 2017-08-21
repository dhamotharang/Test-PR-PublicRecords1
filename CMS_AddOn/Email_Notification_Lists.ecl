IMPORT CMS_AddOn, _Control;

EXPORT Email_Notification_Lists := MODULE

   SHARED developer         := 'albert.metzmaier@lexisnexis.com;';
   SHARED tester            := _Control.MyInfo.EmailAddressNotify;
	 SHARED quality_assurance := 'qualityassurance@seisint.com;';
	 SHARED extra             := 'yoga.raghavaraju@lexisnexis.com;russell.streur@lexisnexis.com;kathy.bardeen@lexisnexis.com';
	 SHARED core_people       := developer + tester + ';' + quality_assurance;
   SHARED all_hands         := core_people + extra;

   EXPORT BuildSuccess :=	IF(CMS_AddOn._Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := IF(CMS_AddOn._Flags().IsTesting, developer + tester, core_people);
   EXPORT Stats        := BuildFailure;

END;
