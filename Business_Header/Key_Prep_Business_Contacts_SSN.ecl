import data_services;
export Key_Prep_Business_Contacts_SSN := 
	INDEX(File_Prep_Business_Contacts_Plus, 
		  {ssn, __filepos }, 
		 data_services.data_location.prefix() + 'thor_data400::key::business_contacts.ssn' + thorlib.wuid());