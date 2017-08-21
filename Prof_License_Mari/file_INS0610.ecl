//Raw professional license file from INS0610
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_INS0610 := MODULE

	SHARED code 								:= 'INS0610';
	SHARED working_dir					:= 'using';
	
	EXPORT broker								:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'broker', 
																					Prof_License_Mari.layout_INS0610.broker,
																					CSV(SEPARATOR(','),heading(2),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))); 	
END;
