﻿IMPORT _control,tools,roxiekeybuild;

EXPORT Email_Notification_Lists(

	BOOLEAN	pIsTesting = DataBridge._Constants().IsTesting ) := 
			
  tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
	  ,_Control.MyInfo.EmailAddressNotify  + ';' //+ 'elaine.mattox@lexisnexisrisk.com;' + 'Manuel.Tarectecan@lexisnexisrisk.com;'	
	  ,_Control.MyInfo.EmailAddressNotify  + ';' //+ 'elaine.mattox@lexisnexisrisk.com;' + 'Manuel.Tarectecan@lexisnexisrisk.com;'
	  ,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List  + ';' //+ 'elaine.mattox@lexisnexisrisk.com;' + 'Manuel.Tarectecan@lexisnexisrisk.com;'
	  ,pIsTesting
	 );