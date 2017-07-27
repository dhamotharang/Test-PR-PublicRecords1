import business_header_ss;
EXPORT File_Business_Contacts_Plus := 
	DATASET(
	'~thor_data400::BASE::Business_Contacts_' + business_header_ss.key_version,
    business_header.Layout_Business_Contact_Plus, FLAT);