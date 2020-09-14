IMPORT _control,tools,roxiekeybuild;

EXPORT Email_Notification_Lists(

	BOOLEAN	pIsTesting = DataBridge._Constants().IsTesting ) := 
			
  tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
	  ,_Control.MyInfo.EmailAddressNotify  
	  ,_Control.MyInfo.EmailAddressNotify  
	  ,_Control.MyInfo.EmailAddressNotify + ';Lindsey.Decot@lexisnexisrisk.com;Rosemary.Murphy@lexisnexisrisk.com;' + roxiekeybuild.Email_Notification_List
	  ,pIsTesting
	 );