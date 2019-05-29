IMPORT _control,tools,roxiekeybuild;

EXPORT Email_Notification_Lists(

	BOOLEAN	pIsTesting = FBNV2._Constants().IsTesting ) := 
			
  tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
	  ,_Control.MyInfo.EmailAddressNotify + ';barbara.oneill@lexisnexisrisk.com;' + 'Darren.Knowles@lexisnexisrisk.com;'
	  ,_Control.MyInfo.EmailAddressNotify + ';barbara.oneill@lexisnexisrisk.com;' + 'Darren.Knowles@lexisnexisrisk.com;'
	  ,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';barbara.oneill@lexisnexisrisk.com;'  + 'Darren.Knowles@lexisnexisrisk.com;'
	  ,pIsTesting
	 );