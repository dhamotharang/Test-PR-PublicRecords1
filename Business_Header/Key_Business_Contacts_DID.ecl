import business_header_ss, data_services;

fbc := File_Prep_Business_Contacts_Plus (did > 0);
EXPORT Key_Business_Contacts_DID := 
	INDEX (fbc, {did}, {fp := __filepos}, 
         data_services.data_location.prefix() + 'thor_data400::key::business_contacts.did_' + business_header_ss.key_version);
