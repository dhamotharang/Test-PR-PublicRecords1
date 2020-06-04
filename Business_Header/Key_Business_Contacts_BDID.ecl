Import Data_Services, business_header_ss, mdr, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
fbc := PRTE2_Business_Header.File_Prep_Business_Contacts_Plus(bdid > 0);
#ELSE
fbc := File_Prep_Business_Contacts_Plus(bdid > 0);
#END;

Layout_Business_Contact_Full_New t2full(fbc l) :=
transform
  self.ssn := if(mdr.sourceTools.sourceIsUtility(l.source), 0, l.ssn);
	self := l;
end;

fbc_table := project(fbc, t2full(left));

EXPORT Key_Business_Contacts_BDID := 
	INDEX(fbc_table, 
		  {bdid},
			{fbc_table},
		 Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::business_contacts.bdid_' + business_header_ss.key_version);