// SDS0810 / South Dakota Revenue and Regulation / Real Estate Appraisers //
IMPORT _control, Prof_License_Mari;

export file_SDS0810 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'SDS0810' + '::' + 'using' + '::' + 'apr', 
															 Prof_License_Mari.layout_SDS0810,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
															 