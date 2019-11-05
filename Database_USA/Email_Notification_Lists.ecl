IMPORT _control,tools,roxiekeybuild;

EXPORT Email_Notification_Lists(

	BOOLEAN	pIsTesting = Database_USA._Constants().IsTesting ) := 
			
  tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
	  ,_Control.MyInfo.EmailAddressNotify + ';' + 'julianne.franzer@lexisnexisrisk.com;' + 'Christopher.Brodeur@lexisnexisrisk.com;'	 
	  ,_Control.MyInfo.EmailAddressNotify + ';' + 'julianne.franzer@lexisnexisrisk.com;' + 'Christopher.Brodeur@lexisnexisrisk.com;' 
	  ,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';' + 'julianne.franzer@lexisnexisrisk.com;' + 'Christopher.Brodeur@lexisnexisrisk.com;'
	  ,pIsTesting
	 );