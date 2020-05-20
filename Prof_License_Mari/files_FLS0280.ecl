//Raw professional license files from the source FLS0280 RLE/APR
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_FLS0280 := MODULE

	SHARED code 								:= 'FLS0280';
	SHARED working_dir					:= 'using';
	SHARED file_lic64			 			:= 'lic64';
	SHARED file_re						 	:= 're';
	SHARED file_corp					 	:= 'corp';
	
	EXPORT lic64			 					:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_lic64, 
																					Prof_License_Mari.layout_FLS0280.lic64,
																					CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
	EXPORT re							 			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_re + '1', 
																					Prof_License_Mari.layout_FLS0280.re,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

	EXPORT co   					 			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_corp, 
																					Prof_License_Mari.layout_FLS0280.re,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;
