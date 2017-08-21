IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists (STRING2 Medicare_State, String pVersion):= MODULE
   developer := 'kumaAs04@lexisnexis.com;';
	 tester := 'kumaAs04@lexisnexis.com;';
	 quality_assurance := 'kumaAs04@lexisnexis.com;';
   all_hands := developer + tester  + quality_assurance;
	 
   EXPORT BuildSuccess :=	IF(_Flags(Medicare_State, pVersion).IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
END;