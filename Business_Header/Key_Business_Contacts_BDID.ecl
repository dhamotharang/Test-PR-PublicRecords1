import business_header_ss;
fbc := File_Prep_Business_Contacts_Plus(bdid > 0);

Layout_Business_Contact_Full t2full(fbc l) :=
transform
	self := l;
end;

fbc_table := project(fbc, t2full(left));

EXPORT Key_Business_Contacts_BDID := 
	INDEX(fbc_table, 
		  {bdid},
			{fbc_table},
		 '~thor_data400::key::business_contacts.bdid_' + business_header_ss.key_version);