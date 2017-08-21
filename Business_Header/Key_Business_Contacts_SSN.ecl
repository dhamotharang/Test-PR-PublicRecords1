Import Data_Services, business_header_ss, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
fbc := PRTE2_Business_Header.File_Prep_Business_Contacts_Plus (ssn > 0);
#ELSE
fbc := File_Prep_Business_Contacts_Plus (ssn > 0);
#END;

export Key_Business_Contacts_SSN := 
  INDEX (fbc, {ssn}, {fp := __filepos},
		     '~thor_data400::key::business_contacts.ssn_' + business_header_ss.key_version);