IMPORT _control,tools;

EXPORT Email_Notification_Lists(

	BOOLEAN	pIsTesting = NAICSCodes._Constants().IsTesting ) := 
			
  tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
	  ,_Control.MyInfo.EmailAddressNotify + ';barbara.oneill@lexisnexisrisk.com;'
	  ,_Control.MyInfo.EmailAddressNotify + ';barbara.oneill@lexisnexisrisk.com;'
	  ,_Control.MyInfo.EmailAddressNotify + ';barbara.oneill@lexisnexisrisk.com;'
	  ,pIsTesting
	 );