export File_BH_CompanyName_Address := 
	DATASET(
	'~thor_data400::BASE::business_header.CompanyName_Address_' + business_header_ss.file_version,
	Business_Header_SS.Layout_CompanyName_Address_SS, 
	THOR);