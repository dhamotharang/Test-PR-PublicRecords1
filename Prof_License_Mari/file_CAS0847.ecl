//Raw professional license files from the California
IMPORT ut, _control,Prof_License_Mari,Lib_FileServices;

EXPORT file_CAS0847 := MODULE

	SHARED code 			:= 'CAS0847';
	SHARED file_name 	:= 'apr';

	EXPORT appraisers := dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + file_name, 
																Prof_License_Mari.layout_CAS0847,
																CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;

//export file_CAS0847 := dataset('~thor_data400::in::prolic::CAS0847::apr_web.txt',layout_CAS0847,flat);
	





