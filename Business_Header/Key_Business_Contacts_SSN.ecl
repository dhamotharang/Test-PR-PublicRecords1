import business_header_ss;

fbc := File_Prep_Business_Contacts_Plus (ssn > 0);
export Key_Business_Contacts_SSN := 
  INDEX (fbc, {ssn}, {fp := __filepos},
		     '~thor_data400::key::business_contacts.ssn_' + business_header_ss.key_version);