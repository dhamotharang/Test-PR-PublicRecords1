Layout_Header_Word_Index_Plus := RECORD	
	Layout_Header_Word_Index;
	UNSIGNED8 __filepos {virtual(fileposition)}
END;

export File_BH_CompanyNameWords := DATASET(
	'~thor_data400::BASE::bh_co_name_words_built',
	Layout_Header_Word_Index_Plus,
	thor);