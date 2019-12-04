IMPORT  doxie,mdr;

EXPORT keys := MODULE

 EXPORT key_emailevent := INDEX(FILES.Email_Event_Base, 
	 {email_address, date_added, source}, {files.Email_Event_Base}, 
	 Constants.KeyName + doxie.Version_SuperKey + '::email_event_lkp');
	 
	 EXPORT key_domainevent := INDEX(FILES.Domain_Event_Base, 
	 {domain_name}, {files.Domain_Event_Base}, 
	 Constants.KeyName + doxie.Version_SuperKey + '::domain_lkp');

End;