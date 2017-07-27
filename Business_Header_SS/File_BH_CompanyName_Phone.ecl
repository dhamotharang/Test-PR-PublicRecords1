export File_BH_CompanyName_Phone := 
	DATASET(
	'~thor_data400::BASE::business_header.CompanyName_Phone_' + business_header_ss.file_version,
	Business_Header_SS.Layout_CompanyName_Phone_SS, 
	THOR);