
// raw prof lic files from Colorado Division of Real Estate (mortgage)
//export file_COS0865 := dataset('~thor_data400::in::proflic_mari::cos0865::using::mtg',Prof_License_Mari.layout_COS0865.common,CSV(HEADING(1),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"')));

IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_COS0865 := MODULE


	SHARED code 								:= 'COS0865';
	SHARED working_dir					:= 'using';
	
	EXPORT active								:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'active', 
																					Prof_License_Mari.layout_COS0865.active,
																					CSV(HEADING(1),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"'))); 	
	
	EXPORT inactive							:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'inactive', 
																					Prof_License_Mari.layout_COS0865.inactive,
																					CSV(HEADING(1),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"'))); 	
	
	// EXPORT expired							:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'expired', 
																					// Prof_License_Mari.layout_COS0865.expired,
																					// CSV(HEADING(1),SEPARATOR(','),TERMINATOR('\r\n'),QUOTE('"'))); 	
END;