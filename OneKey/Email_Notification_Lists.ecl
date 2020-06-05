IMPORT roxiekeybuild, _control,tools;
EXPORT Email_Notification_Lists(BOOLEAN pIsTesting = _Constants().IsTesting) :=
  tools.mod_Email_Notification_Lists(_Control.MyInfo.EmailAddressNotify	
                                    ,_Control.MyInfo.EmailAddressNotify + ';Jason.Allerdings@lexisnexisrisk.com;'	
                                    ,_Control.MyInfo.EmailAddressNotify + ';Jason.Allerdings@lexisnexisrisk.com;Kent.Wolf@lexisnexisrisk.com;'	
                                    ,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';Jason.Allerdings@lexisnexisrisk.com'		
                                    ,pIsTesting);