import business_header_ss;
export File_Business_Relatives_Group_Plus := DATASET(
	'~thor_data400::BASE::Business_Relatives_Group_' + business_header_ss.key_version, 
	Layout_Business_Relative_Group_Plus, FLAT);