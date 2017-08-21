//Raw North Dakota Real Estate Commission from the source NDS0855
IMPORT _control, Prof_License_Mari;

EXPORT files_NDS0855 := MODULE
	
	EXPORT RE		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'NDS0855' + '::' + 'using' + '::' + 're', 
													Prof_License_Mari.layout_NDS0855,
													CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;