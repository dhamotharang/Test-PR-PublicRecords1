Import Data_Services, business_header_ss, mdr, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
fbc := project(PRTE2_Business_Header.File_Prep_Business_Contacts_Plus, transform(recordof(File_Prep_Business_Contacts_Plus), self.ssn := if(mdr.sourceTools.sourceIsUtility(left.source), 0, left.ssn), self := left));
#ELSE
fbc := project(File_Prep_Business_Contacts_Plus, transform(recordof(File_Prep_Business_Contacts_Plus), self.ssn := if(mdr.sourceTools.sourceIsUtility(left.source), 0, left.ssn), self := left));
#END;

export Key_Business_Contacts_FP := 
	INDEX(fbc, 
		  {fp := __filepos},
			{fbc},
		 Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::business_contacts.fp_' + business_header_ss.key_version);