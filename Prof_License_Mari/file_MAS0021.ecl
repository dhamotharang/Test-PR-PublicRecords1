// MAS0021 / Massachussets, Commonwealth of / Multiple Professions //
IMPORT Prof_License_Mari;

EXPORT file_MAS0021 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MAS0021' + '::' + 'using' + '::' + 're', 
															 Prof_License_Mari.layout_MAS0021.common,
															 CSV(SEPARATOR(','),quote('"')));

