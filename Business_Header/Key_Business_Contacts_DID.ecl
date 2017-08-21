Import Data_Services, business_header_ss, mdr, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
fbc := PRTE2_Business_Header.File_Prep_Business_Contacts_Plus (did > 0);
#ELSE
fbc := File_Prep_Business_Contacts_Plus (did > 0);
#END;

EXPORT Key_Business_Contacts_DID := 
	INDEX (fbc, {did}, {fp := __filepos}, 
         '~thor_data400::key::business_contacts.did_' + business_header_ss.key_version);
