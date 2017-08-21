IMPORT _control, Prof_License_Mari;

export file_NES0859 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'NES0859' + '::' + 'using' + '::' + 'appr', 
															 Prof_License_Mari.layout_NES0859.src,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));