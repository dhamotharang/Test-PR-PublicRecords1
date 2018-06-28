import roxiekeybuild, _control,tools;
export Email_Notification_Lists(

	 boolean	pIsTesting						= _Constants().IsTesting

) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify + ';giri.rajulapalli@lexisnexis.com;latoya.walden@lexisnexisrisk.com'	
		,_Control.MyInfo.EmailAddressNotify + ';giri.rajulapalli@lexisnexis.com;latoya.walden@lexisnexisrisk.com'	
		,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';giri.rajulapalli@lexisnexis.com;latoya.walden@lexisnexisrisk.com'		
		,pIsTesting						
	);
