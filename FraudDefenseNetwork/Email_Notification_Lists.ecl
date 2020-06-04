import roxiekeybuild, _control,tools;
export Email_Notification_Lists(

	 boolean	pIsTesting						= _Dataset().IsTesting

) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify + ';Kapildev.Kanyagundla@lexisnexis.com;DataFab-ALP@lexisnexis.com;Harry.Gist@lexisnexis.com'		
		,_Control.MyInfo.EmailAddressNotify + ';Kapildev.Kanyagundla@lexisnexis.com;DataFab-ALP@lexisnexis.com;Harry.Gist@lexisnexis.com'	
		,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';Kapildev.Kanyagundla@lexisnexis.com;DataFab-ALP@lexisnexis.com;Harry.Gist@lexisnexis.com'		
		,pIsTesting						
	);
