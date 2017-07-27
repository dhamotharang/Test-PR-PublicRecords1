IMPORT Business_Header;

EXPORT File_BH_CompanyName_Address_Plus := DATASET(
	'~thor_data400::BASE::business_header.CompanyName_Address_built',
	Business_Header_SS.Layout_CompanyName_Address_SS_Plus, 
	THOR);