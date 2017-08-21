// MOS0634 / Missouri Mortgage
EXPORT file_MOS0634 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0634' + '::' + 'using' + '::' + 'mtg', 
																	 Prof_License_Mari.layout_MOS0634.common,
																	 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));