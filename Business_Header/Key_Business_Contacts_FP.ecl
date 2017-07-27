import business_header_ss;
fbc := File_Prep_Business_Contacts_Plus;
export Key_Business_Contacts_FP := 
	INDEX(fbc, 
		  {fp := __filepos},
			{fbc},
		 '~thor_data400::key::business_contacts.fp_' + business_header_ss.key_version);