import business_header_ss, NID;

fbc := File_Prep_Business_Contacts_Plus(state <> '', lname <> '');
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
