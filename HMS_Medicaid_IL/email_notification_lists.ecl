/* IMPORT _control,RoxieKeyBuild;
   
   EXPORT Email_Notification_Lists := MODULE
      developer := 'kumaAs04@lexisnexis.com;';
      //tester := _Control.MyInfo.EmailAddressNotify;
   	 tester := 'kumaAs04@lexisnexis.com;';
   	 //quality_assurance := 'qualityassurance@seisint.com;';
   	 quality_assurance := 'kumaAs04@lexisnexis.com;';
      all_hands := developer + tester + ';' + quality_assurance;
   	 
      EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
      EXPORT BuildFailure := BuildSuccess;
   END;
*/