IMPORT ut,_control,Prof_License_Mari,Lib_FileServices;

EXPORT files_DES0846 := MODULE

	SHARED code 								:= 'DES0846';
	SHARED working_dir					:= 'using';
	SHARED file_appraisers 			:= 'apr';
	SHARED file_professionals 	:= 're';
	
	EXPORT appraisers	 					:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_appraisers, 
																					Prof_License_Mari.layout_DES0846,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
	EXPORT professionals	 			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_professionals, 
																					Prof_License_Mari.layout_DES0846,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;
