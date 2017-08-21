// MDS0834 / Maryland Commission of Real Estate App & Home Insp / Real Estate Appraisers //
#workunit('name','File MDS0834');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_MDS0834 := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'MDS0834' + '::' + 'using' + '::' + 'file', 
																 Prof_License_Mari.layout_MDS0834.COMMON,
																 CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
												DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'MDS0834' + '::' + 'using' + '::' + 'file', 
																 Prof_License_Mari.layout_MDS0834.COMMON,
																 CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
												DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'MDS0834' + '::' + 'using' + '::' + 'file', 
																 Prof_License_Mari.layout_MDS0834.COMMON,
																 CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
												DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'MDS0834' + '::' + 'using' + '::' + 'file', 
																 Prof_License_Mari.layout_MDS0834.COMMON,
																 CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));
