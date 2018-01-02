import business_header_ss, data_services;
fbc := File_Prep_Business_Contacts_Plus;
export Key_Business_Contacts_FP := 
	INDEX(fbc, 
		  {fp := __filepos},
			{fbc},
		 data_services.data_location.prefix() + 'thor_data400::key::business_contacts.fp_' + business_header_ss.key_version);