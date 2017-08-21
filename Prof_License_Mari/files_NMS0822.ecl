//New Mexico Real Estate Professional Licenses Files NMS0822
IMPORT _control, Prof_License_Mari;

EXPORT files_NMS0822 := MODULE

	SHARED code				:= 'NMS0822';
	// EXPORT company		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'company', 
													// Prof_License_Mari.layout_NMS0822.COMMON,
													// CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
	EXPORT pr:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'persons', 
													Prof_License_Mari.layout_NMS0822.COMMON,
													CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;
