IMPORT _control,RoxieKeyBuild;

EXPORT Email_Notification_Lists := MODULE
   EXPORT developer :=
								'debendra.kumar@lexisnexis.com;'
							+ 'Oscar.Barrientos@lexisnexis.com;'
							// + 'Sesha.Nookala@lexisnexis.com;'
							// + 'Michael.Gould@lexisnexisrisk.com;'
							;
	 EXPORT quality_assurance :=
								'jose.bello@lexisnexis.com;'
							// + 'david.weaver@lexisnexis.com;' 
							;
	 EXPORT NOC :=
								'ris-glonoc@risk.lexisnexis.com'
							;
							
	 EXPORT imports :=
								'david.weaver@lexisnexisrisk.com;'
							;

		EXPORT Coverage_Report_DevList	:=
							'jose.bello@lexisnexis.com;'
							+'david.weaver@lexisnexis.com;'
							+'sean.borton@lexisnexisrisk.com;'
							+'robert.buttazzoni@lexisnexisrisk.com;'
							+'James.Hernandez@lexisnexisrisk.com;'
							+'an.nguyen@lexisnexisrisk.com;'
							+'tyler.walker@lexisnexisrisk.com;'
							// +'jason.trost@lexisnexis.com;'
							// +'Rob.Becker@lexisnexis.com;'
							;
		EXPORT Coverage_Report_ProductList	:=
							Coverage_Report_DevList
							// +'Julie.Gartner@lexisnexis.com;'
							;


   EXPORT tester       := _Control.MyInfo.EmailAddressNotify;
   EXPORT all_hands    := developer + tester + ';' + quality_assurance;
   EXPORT BuildSuccess :=	IF(_Flags().IsTesting, developer + tester, all_hands);
   EXPORT BuildFailure := BuildSuccess;
   EXPORT SchedFailure := IF(_Flags().IsTesting, developer + tester, all_hands);
	 
	 EXPORT BuildSuccess_Raidsreport :=	BuildSuccess +  imports;
	 EXPORT BuildFailure_Raidsreport := BuildSuccess_Raidsreport;
	 
END;