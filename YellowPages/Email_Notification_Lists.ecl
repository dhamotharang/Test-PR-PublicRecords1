import roxiekeybuild, _control,tools;

export Email_Notification_Lists(

	 boolean	pIsTesting						= Constants().IsTesting

) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify + ';kevin.reeder@lexisnexisrisk.com;qualityassurance@seisint.com'	
		,_Control.MyInfo.EmailAddressNotify + ';kevin.reeder@lexisnexisrisk.com'	
		,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';kevin.reeder@lexisnexisrisk.com'		
		,pIsTesting						
	);
