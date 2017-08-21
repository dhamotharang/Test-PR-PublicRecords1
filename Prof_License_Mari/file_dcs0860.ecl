//Raw professional license files from the ARKANSAS APPRAISER LICENSING & CERTIFICATION BOARD
IMPORT ut,_control, Prof_License_Mari, Lib_FileServices;

EXPORT file_DCS0860 := MODULE

	SHARED code := 'dcs0860';
	SHARED file_name := 'rle_License';

	EXPORT rle		 := DATASET(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + file_name, 
														Prof_License_Mari.layout_DCS0860.Common,
														CSV(HEADING(1),SEPARATOR(','),TERMINATOR('\n')));
END;