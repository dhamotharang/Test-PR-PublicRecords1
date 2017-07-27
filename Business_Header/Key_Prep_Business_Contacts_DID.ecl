EXPORT Key_Prep_Business_Contacts_DID := 
	INDEX(File_Prep_Business_Contacts_Plus, 
		  {did, __filepos }, 
		 '~thor_data400::key::business_contacts.did' + thorlib.wuid());