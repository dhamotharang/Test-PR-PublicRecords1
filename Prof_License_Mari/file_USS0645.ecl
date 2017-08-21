// Federal Deposit Insurance Corporation
IMPORT _control, Prof_License_Mari;


EXPORT file_USS0645 := MODULE
		EXPORT FOIA          := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'USS0645' + '::' + 'using' + '::' + 'lenders',
															 Prof_License_Mari.layout_USS0645.COMMON,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))); 	 

END;