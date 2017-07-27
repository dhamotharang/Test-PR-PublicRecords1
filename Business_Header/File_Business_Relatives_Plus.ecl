import business_header_ss;
EXPORT File_Business_Relatives_Plus := DATASET(
	'~thor_data400::BASE::Business_Relatives_' + business_header_ss.key_version,
	Layout_Business_Relative_Plus,
	FLAT);