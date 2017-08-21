//Raw professional license files from the KANSAS APPRAISER LICENSING & CERTIFICATION BOARD
IMPORT ut,_control, Prof_License_Mari, Lib_FileServices;

EXPORT file_KSS0902 := MODULE

	SHARED code := 'KSS0902';
	SHARED file_name := 'apr';

	EXPORT apr		 := dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + file_name, 
														Prof_License_Mari.layout_KSS0902,
														csv(heading(1),SEPARATOR([',','\t']),QUOTE('"')));
END;