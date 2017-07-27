import business_header_ss;
EXPORT File_Business_Header_Best_Plus := DATASET(
	'~thor_data400::BASE::business_header.Best_' + business_header_ss.key_version,
	Business_Header.Layout_BH_Best_Plus, 
	THOR);