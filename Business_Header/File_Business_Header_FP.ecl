import Business_header;
export File_Business_Header_FP := 
	DATASET(
	'~thor_data400::BASE::Business_Header',
	Business_header.Layout_Business_Header_Base_Plus, FLAT);