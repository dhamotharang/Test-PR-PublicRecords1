import roxiekeybuild, _control,tools;
export Email_Notification_Lists(BOOLEAN	pIsTesting = _Flags.IsTesting) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify 	
		,_Control.MyInfo.EmailAddressNotify 	
		,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List 		
		,pIsTesting						
	);
