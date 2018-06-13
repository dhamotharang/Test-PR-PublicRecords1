IMPORT _control,tools;

EXPORT Email_Notification_Lists(

			BOOLEAN	pIsTesting = QA_Data._Constants().IsTesting ) := 
			
     tools.mod_Email_Notification_Lists(
								_Control.MyInfo.EmailAddressNotify	
							 ,_Control.MyInfo.EmailAddressNotify + ';audra.mireles@lexisnexis.com;' + 'darren.knowles@lexisnexisrisk.com;'	
							 ,_Control.MyInfo.EmailAddressNotify + ';audra.mireles@lexisnexis.com;'	+ 'darren.knowles@lexisnexisrisk.com;'	
							 ,_Control.MyInfo.EmailAddressNotify + ';audra.mireles@lexisnexis.com'	+ 'darren.knowles@lexisnexisrisk.com;'		
							 ,pIsTesting
							 );

