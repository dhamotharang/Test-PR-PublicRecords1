bh := Business_Header.File_Prep_Business_Contacts_Plus;

export Key_Prep_Business_Contacts_BDID :=
	index(bh, {bdid, __filepos}, 'key::business_contacts.bdid' + thorlib.wuid());