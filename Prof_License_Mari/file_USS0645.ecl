// Federal Deposit Insurance Corporation
IMPORT _control, Prof_License_Mari;


EXPORT file_USS0645 := MODULE
		EXPORT lender          := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'USS0645' + '::' + 'using' + '::' + 'lender',
															 Prof_License_Mari.layout_USS0645.COMMON,
															 CSV(SEPARATOR(','),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))); 	 
		EXPORT branch          := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'USS0645' + '::' + 'using' + '::' + 'branch',
															 Prof_License_Mari.layout_USS0645.COMMON,
															 CSV(SEPARATOR(','),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))); 
END;

