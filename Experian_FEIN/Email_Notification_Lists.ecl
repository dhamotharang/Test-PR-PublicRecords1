import roxiekeybuild, _control,tools;
export Email_Notification_Lists(

	 boolean	pIsTesting						= _Constants().IsTesting

) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify + ';kevin.reeder@lexisnexis.com;'	
		,_Control.MyInfo.EmailAddressNotify + ';kevin.reeder@lexisnexis.com;'	
		,_Control.MyInfo.EmailAddressNotify 		
		,pIsTesting						
	);
	

