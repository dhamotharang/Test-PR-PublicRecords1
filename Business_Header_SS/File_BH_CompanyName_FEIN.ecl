export File_BH_CompanyName_FEIN := 
	DATASET(
	'~thor_data400::BASE::business_header.CompanyName_FEIN_' + business_header_ss.file_version,
	Business_Header_SS.Layout_CompanyName_FEIN_SS, 
	THOR);