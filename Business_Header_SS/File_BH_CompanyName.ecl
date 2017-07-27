export File_BH_CompanyName := 
	DATASET(
	'~thor_data400::BASE::business_header.CompanyName_' + business_header_ss.file_version,
	Business_Header_SS.Layout_CompanyName_SS, 
	THOR);