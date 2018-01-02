import business_header_ss, data_services;
f_best := Business_Header.File_Business_Header_Best;


EXPORT Key_BH_Best := INDEX(
	f_best, 
	{bdid},
	{f_best},
	data_services.data_location.prefix() + 'thor_data400::key::business_header.Best_' + business_header_ss.key_version );