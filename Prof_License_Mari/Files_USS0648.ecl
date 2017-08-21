IMPORT _control, Prof_License_Mari;

EXPORT files_USS0648 := MODULE

	EXPORT foicu 				:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'USS0648' + '::' + 'using' + '::' + 'foicu', 
													Prof_License_Mari.layout_USS0648.r_FOICU,
													CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
													 
	EXPORT cubi					:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'USS0648' + '::' + 'using' + '::' + 'cubi', 
													Prof_License_Mari.layout_USS0648.r_CRED_UNION,
													CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;