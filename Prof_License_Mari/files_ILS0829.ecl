// Raw data for ILS0829 / Illinois Department of Professional Regulation / Multiple Professions // 
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_ILS0829 := MODULE

	SHARED code 								:= 'ILS0829';
	SHARED working_dir					:= 'using';
	
	EXPORT relic								:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 're', 
																					Prof_License_Mari.layout_ILS0829,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
	
END;
