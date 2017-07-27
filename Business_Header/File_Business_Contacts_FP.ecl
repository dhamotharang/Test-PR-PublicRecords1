import business_header_ss;
export File_Business_Contacts_FP := 
	DATASET(
	'~thor_data400::BASE::Business_Contacts',
    business_header.Layout_Business_Contact_Plus, FLAT);