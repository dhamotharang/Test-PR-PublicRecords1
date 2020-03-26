//Raw real estate licenses from the CAS0681
// #workunit('name','File CAS0681');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;
	   
EXPORT file_CAS0681 := MODULE

	SHARED code := 'CAS0681';
	SHARED file_name := 'real_estate';

	EXPORT real_estate := dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + file_name, 
																Prof_License_Mari.layout_cas0681.common,
																CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;
