// NCS0840 / North Carolina Real Estate Commission / Real Estate //
IMPORT Prof_License_Mari;

EXPORT files_NCS0840 := MODULE

	SHARED code 		:= 'NCS0840';
	
	EXPORT inactive := dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'inactive', 
													 Prof_License_Mari.layout_NCS0840,
													 CSV(SEPARATOR('\t'),heading(1),quote('"')));
	EXPORT active 	:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'active', 
													 Prof_License_Mari.layout_NCS0840,
													 CSV(SEPARATOR(','),quote('"')));
END;