import business_header_ss;
base := File_Prep_Business_Contacts_Plus;

EXPORT Key_Business_Contacts_State_City_Name := INDEX(
	base,
	{lname, state, city, fname, mname, __filepos},
	'~thor_data400::key::business_contacts.state.city.name_' + business_header_ss.key_version);