IMPORT Business_Header;

EXPORT File_Prep_BH_CompanyName_Phone_Plus := DATASET(
	'~thor_data400::BASE::business_header.CompanyName_Phone_building',
	Business_Header_SS.Layout_CompanyName_Phone_SS_Plus, 
	THOR);