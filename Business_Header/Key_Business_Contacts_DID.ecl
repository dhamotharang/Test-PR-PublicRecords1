import business_header_ss;

fbc := File_Prep_Business_Contacts_Plus (did > 0);
EXPORT Key_Business_Contacts_DID := 
	INDEX (fbc, {did}, {fp := __filepos}, 
         '~thor_data400::key::business_contacts.did_' + business_header_ss.key_version);
