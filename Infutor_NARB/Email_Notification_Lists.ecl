IMPORT _control,tools,roxiekeybuild;

EXPORT Email_Notification_Lists(

	BOOLEAN	pIsTesting = Infutor_NARB._Constants().IsTesting ) := 
			
  tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
	  ,_Control.MyInfo.EmailAddressNotify + ';audra.mireles@lexisnexis.com;'/* + '<data ops eng>@lexisnexisrisk.com;'*/	
	  ,_Control.MyInfo.EmailAddressNotify + ';audra.mireles@lexisnexis.com;'/* + '<data ops eng>@lexisnexisrisk.com;'*/
	  ,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';audra.mireles@lexisnexisrisk.com' /* + '<data ops eng>@lexisnexisrisk.com;'*/		
	  ,pIsTesting
	 );
		 
