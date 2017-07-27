IMPORT Business_Header;

EXPORT File_BH_CompanyName_Address_Broad_Plus := DATASET(
	'~thor_data400::BASE::business_header.CompanyName_Address_Broad_built',
	Business_Header_SS.Layout_CompanyName_Address_Broad_SS_Plus, 
	THOR);