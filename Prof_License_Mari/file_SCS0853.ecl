// SCS0853 / South Carolina Real Estate Appraisers Board / Real Estate Appraisers //
IMPORT _control, Prof_License_Mari;

export file_SCS0853 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'SCS0853' + '::' + 'using' + '::' + 'apr', 
															 Prof_License_Mari.layout_SCS0853.common,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

