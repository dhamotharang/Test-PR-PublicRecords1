EXPORT file_WYS0858 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'WYS0858' + '::' + 'using' + '::' + 'rel', 
																 Prof_License_Mari.layout_wys0858.Common,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\r','\r\n','\n'])));