//Raw professional license files from DES0630
IMPORT Prof_License_Mari;

export files_DES0630 := MODULE

	SHARED code 								:= 'DES0630';
	SHARED working_dir					:= 'using';
	
	EXPORT lender								:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'lender', 
																					Prof_License_Mari.layout_DES0630.layout_lender_raw,
																					CSV(SEPARATOR('\t'),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
																					
	EXPORT mbroker								:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'mbroker', 
																					Prof_License_Mari.layout_DES0630.layout_lender_raw,
																					CSV(SEPARATOR('\t'),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

	// lender := dataset('~thor_data400::in::proflic_mari::des0630::20130429::liclenders1.txt',
														// layout_DES0630_raw,
														// CSV(SEPARATOR('\t'),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;