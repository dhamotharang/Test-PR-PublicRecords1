#workunit('name','Yogurt: File LAS0832');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_LAS0832 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'LAS0832' + '::' + 'using' + '::' + 're', 
															 Prof_License_Mari.layout_LAS0832,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
