import business_header_ss, data_services;
f_brg := Business_Header.File_Business_Relatives_Group;


EXPORT Key_Business_Relatives_Group := INDEX(f_brg,
	{f_brg.group_id}, {f_brg},
	data_services.data_location.prefix() + 'thor_data400::key::business_header.Business_Relatives_Group_' + business_header_ss.key_version);