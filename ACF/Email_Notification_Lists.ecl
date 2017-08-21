import roxiekeybuild, _control,  tools;

export Email_Notification_Lists(
																 boolean	pIsTesting = Tools._Constants.IsDataland
															 ) :=
		tools.mod_Email_Notification_Lists(
			 _Control.MyInfo.EmailAddressNotify	
			,_Control.MyInfo.EmailAddressNotify + 'john.freibaum@lexisnexisrisk.com; skasavajjala@lexisnexisrisk.com'
			,_Control.MyInfo.EmailAddressNotify + 'john.freibaum@lexisnexisrisk.com; skasavajjala@lexisnexisrisk.com'	
			,_Control.MyInfo.EmailAddressNotify + 'john.freibaum@lexisnexisrisk.com; skasavajjala@lexisnexisrisk.com'	
			,pIsTesting						
);