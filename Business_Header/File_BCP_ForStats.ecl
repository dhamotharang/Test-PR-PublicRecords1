import ut;
export File_BCP_ForStats := 
	DATASET(
		'~thor_data400::BASE::Business_Contacts', 
		business_header.Layout_Business_Contact_Plus, FLAT);