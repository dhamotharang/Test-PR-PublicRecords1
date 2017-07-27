import business_header_ss;
EXPORT File_Business_Header_Plus := 
	DATASET(
	'~thor_data400::BASE::Business_Header_' + business_header_ss.key_version,
	Layout_Business_Header_Base_Plus, FLAT, opt);