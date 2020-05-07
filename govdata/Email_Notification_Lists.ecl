IMPORT _control,tools,roxiekeybuild;

EXPORT Email_Notification_Lists(

	BOOLEAN	pIsTesting = Govdata._Constants().IsTesting ) := 
			
  tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
	  ,_Control.MyInfo.EmailAddressNotify + ';'  	
	  ,_Control.MyInfo.EmailAddressNotify + ';' 
	  ,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';' 
	  ,pIsTesting
	 );