// Federal Deposit Insurance Corporation
IMPORT _control, Prof_License_Mari;

export file_USS0643  := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'USS0643' + '::' + 'using' + '::' + 'lenders', 
															 Prof_License_Mari.layout_USS0643.raw,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) 	 
															 ;
