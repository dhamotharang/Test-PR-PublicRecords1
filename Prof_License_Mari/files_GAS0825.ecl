//Raw professional license files from the source GAS0825 RLE/APR
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_GAS0825 := MODULE

	SHARED code 								:= 'GAS0825';
	SHARED working_dir		:= 'using';
	SHARED delim								:= ';';
	
	EXPORT apr				 					:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'apr_actv', 
																					Prof_License_Mari.layout_GAS0825.apr,
																					CSV(SEPARATOR(delim),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +					
																	    dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'apr_inact', 
																					Prof_License_Mari.layout_GAS0825.apr,
																					CSV(SEPARATOR(delim), quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));					
	EXPORT re_active			 			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'rebk_actv', 
																					Prof_License_Mari.layout_GAS0825.re_active,
																					CSV(SEPARATOR('\t'),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
	EXPORT re_inactive		 			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'rebk_inact', 
																					Prof_License_Mari.layout_GAS0825.re_inactive,
																					CSV(SEPARATOR(delim),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;
