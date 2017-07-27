import business_header;
export File_CNP_ForStats := DATASET(
	'~thor_data400::BASE::business_header.CompanyName',
	Business_Header_SS.Layout_CompanyName_SS_Plus, 
	THOR);