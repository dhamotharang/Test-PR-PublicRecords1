Import Data_Services, business_header_ss, NID, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
fbc := PRTE2_Business_Header.File_Prep_Business_Contacts_Plus(state <> '', lname <> '');
#ELSE
fbc := File_Prep_Business_Contacts_Plus(state <> '', lname <> '');
#END;

USE_NEW := TRUE;

EXPORT Key_Business_Contacts_State_LFName := 
  INDEX (fbc,
           {state, 
					  string6 dph_lname := metaphonelib.DMetaPhone1 (fbc.lname), 
						lname, 
						qstring20 pfname := NID.PreferredFirstNew (fbc.fname,USE_NEW),
						fname},
				 {fp := __filepos},
         '~thor_data400::key::business_contacts.state.lfname_' + business_header_ss.key_version);
