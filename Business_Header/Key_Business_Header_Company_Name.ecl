EXPORT Key_Business_Header_Company_Name := 
	INDEX(File_Business_Header_Plus, 
		  {company_name, __filepos }, 
		 '~thor_data400::key::business_header.company_name_' + version);