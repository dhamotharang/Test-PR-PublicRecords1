import roxiekeybuild, _control,tools;
export Email_Notification_Lists(

	 boolean	pIsTesting						= _Dataset().IsTesting

) :=
	tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
		,_Control.MyInfo.EmailAddressNotify + ';Oscar.Barrientos@lexisnexis.com;Jose.Bello@lexisnexisrisk.com;Sesha.Nookala@lexisnexisrisk.com'		
		,_Control.MyInfo.EmailAddressNotify + ';Oscar.Barrientos@lexisnexis.com;Jose.Bello@lexisnexisrisk.com;Sesha.Nookala@lexisnexisrisk.com'	
		,_Control.MyInfo.EmailAddressNotify //+ ';' + roxiekeybuild.Email_Notification_List + ';Oscar.Barrientos@lexisnexis.com;Jose.Bello@lexisnexisrisk.com;Sesha.Nookala@lexisnexisrisk.com'		
		,pIsTesting						
	);
