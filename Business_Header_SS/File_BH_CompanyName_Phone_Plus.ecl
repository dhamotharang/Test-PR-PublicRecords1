IMPORT Business_Header;

EXPORT File_BH_CompanyName_Phone_Plus := DATASET(
	'~thor_data400::BASE::business_header.CompanyName_Phone_built',
	Business_Header_SS.Layout_CompanyName_Phone_SS_Plus, 
	THOR);