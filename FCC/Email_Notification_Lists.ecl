import roxiekeybuild, _control,tools;
export Email_Notification_Lists(

	 boolean	pIsTesting						= _Constants().IsTesting

) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify + ';Kent.Wolf@lexisnexis.com;'	
		,_Control.MyInfo.EmailAddressNotify + ';Kent.Wolf@lexisnexis.com;'	
		,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';Kent.Wolf@lexisnexis.com;'		
		,pIsTesting
		,_Control.MyInfo.EmailAddressNotify + ';lbentley@seisint.com;jbreffni@seisint.com;Kent.Wolf@lexisnexis.com;'
	);
