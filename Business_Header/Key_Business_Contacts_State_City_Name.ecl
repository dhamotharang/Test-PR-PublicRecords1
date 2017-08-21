Import Data_Services, business_header_ss;
base := File_Prep_Business_Contacts_Plus;

EXPORT Key_Business_Contacts_State_City_Name := INDEX(
	base,
	{lname, state, city, fname, mname, __filepos},
	Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::business_contacts.state.city.name_' + business_header_ss.key_version);