import data_services;
EXPORT Key_Business_Header_Company_Name := 
	INDEX(File_Business_Header_Plus, 
		  {company_name, __filepos }, 
		 data_services.data_location.prefix() + 'thor_data400::key::business_header.company_name_' + version);