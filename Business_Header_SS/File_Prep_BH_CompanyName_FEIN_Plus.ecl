IMPORT Business_Header;

EXPORT File_Prep_BH_CompanyName_FEIN_Plus := DATASET(
	'~thor_data400::BASE::business_header.CompanyName_FEIN_building',
	Business_Header_SS.Layout_CompanyName_FEIN_SS_Plus, 
	THOR);