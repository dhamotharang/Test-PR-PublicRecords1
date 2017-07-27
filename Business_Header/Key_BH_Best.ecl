import business_header_ss;
f_best := Business_Header.File_Business_Header_Best;


EXPORT Key_BH_Best := INDEX(
	f_best, 
	{bdid},
	{f_best},
	'~thor_data400::key::business_header.Best_' + business_header_ss.key_version );