import business_header;
export File_BH_CompanyName_Address_Broad := 
	DATASET(
	business_header.foreign_prod + 'thor_data400::BASE::business_header.CompanyName_Address_Broad_' + business_header_ss.file_version,
	Business_Header_SS.Layout_CompanyName_Address_Broad_SS, 
	THOR);