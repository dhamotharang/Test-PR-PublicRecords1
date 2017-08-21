//Raw professional license files from the ARKANSAS APPRAISER LICENSING & CERTIFICATION BOARD
IMPORT ut,_control, Prof_License_Mari, Lib_FileServices;

EXPORT file_ARS0824 := MODULE

	SHARED code := 'ARS0824';
	SHARED file_name := 'apr';

	EXPORT apr		 := dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + file_name, 
														Prof_License_Mari.layout_ARS0824,
														csv(heading(1),SEPARATOR([',','\t']),QUOTE('"')));
END;