import roxiekeybuild, _control,tools;

export Email_Notification_Lists(

	 boolean	pIsTesting						= Constants().IsTesting

) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify + ';john.freibaum@lexisnexis.com;qualityassurance@seisint.com'	
		,_Control.MyInfo.EmailAddressNotify + ';john.freibaum@lexisnexis.com'	
		,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';john.freibaum@lexisnexis.com'		
		,pIsTesting						
	);
