bh := Business_Header.File_Prep_Business_Contacts_Plus;

export Key_Prep_Business_Contacts_State_LFName := 
	index(bh, {state, string6  dph_lname := metaphonelib.DMetaPhone1(bh.lname), lname, 
					   typeof(bh.fname) pfname := datalib.preferredfirst(bh.fname), fname, __filepos}, 
				'~thor_data400::key::business_contacts.state.lfname' + thorlib.wuid());