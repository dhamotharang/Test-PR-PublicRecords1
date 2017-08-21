// MTS0398 / Montana Department of Labor and Industry /	Multiple Professions /
EXPORT file_MTS0398 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MTS0398' + '::' + 'using' + '::' + 're', 
																	 Prof_License_Mari.layout_MTS0398,
																	 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

//export file_MTS0398 := dataset('~thor400_88::in::prolic::MTS0398::all',Prof_License_Mari.layout_MTS0398,csv(heading(1)));