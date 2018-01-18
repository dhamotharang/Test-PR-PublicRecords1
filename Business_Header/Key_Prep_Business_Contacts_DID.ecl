import data_services;
EXPORT Key_Prep_Business_Contacts_DID := 
	INDEX(File_Prep_Business_Contacts_Plus, 
		  {did, __filepos }, 
		 data_services.data_location.prefix() + 'thor_data400::key::business_contacts.did' + thorlib.wuid());