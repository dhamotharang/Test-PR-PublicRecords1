//Raw professional license files from the source MIS0298
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_MIS0298 := MODULE

	EXPORT broker := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'MIS0298' + '::' + 'using' + '::' + 'broker', 
													 Prof_License_Mari.layout_MIS0298.Broker,
													 CSV(SEPARATOR(','),HEADING(0),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));
													 
	EXPORT re 		:= DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'MIS0298' + '::' + 'using' + '::' + 'real_estate', 
													 Prof_License_Mari.layout_MIS0298.RealEstate,
													 CSV(SEPARATOR(','),HEADING(0),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));
													 
	EXPORT MiscLic:= DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'MIS0298' + '::' + 'using' + '::' + 'miscLic', 
													 Prof_License_Mari.layout_MIS0298.MiscLic,
													 CSV(SEPARATOR(','),HEADING(0),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r']))) ;

END;