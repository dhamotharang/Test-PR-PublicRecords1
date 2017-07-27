export Key_Prep_Business_Contacts_SSN := 
	INDEX(File_Prep_Business_Contacts_Plus, 
		  {ssn, __filepos }, 
		 '~thor_data400::key::business_contacts.ssn' + thorlib.wuid());