import roxiekeybuild, _control,tools;

export Email_Notification_Lists(


) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify + ';kevin.devore@lexisnexis.com;'	
		,_Control.MyInfo.EmailAddressNotify + ';kevin.devore@lexisnexis.com;'	
		,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';kevin.devore@lexisnexis.com; RISBCTQualityAssurance@lexisnexis.com'		
					
	);