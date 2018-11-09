//Raw professional license files from the source MIS0298
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_MIS0298 := MODULE

	EXPORT Raw := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'MIS0298' + '::' + 'using' + '::' + 'real_estate', 
													 Prof_License_Mari.layout_MIS0298.Raw,
													 CSV(SEPARATOR(','),HEADING(0),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));
													 
END;