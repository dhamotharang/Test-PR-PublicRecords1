//Raw professional license file from INS0901
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_INS0901 := MODULE

	SHARED code 								:= 'INS0901';
	SHARED working_dir					:= 'using';
	
	EXPORT appraiser						:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'appraiser', 
																					Prof_License_Mari.layout_INS0901,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
																					
		
END;

