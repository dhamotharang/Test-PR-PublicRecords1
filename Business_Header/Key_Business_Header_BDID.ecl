import doxie, data_services;

EXPORT Key_Business_Header_BDID := 
	INDEX(File_Business_Header_Plus, 
		  {bdid, __filepos }, 
		 data_services.data_location.prefix() + 'thor_data400::key::business_header.bdid_' + doxie.Version_SuperKey);