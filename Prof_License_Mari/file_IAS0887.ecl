//Raw data for Iowa Real Estate Commission & Appraisal / Real Estate 
#workunit('name','File IAS0887');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_IAS0887 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IAS0887' + '::' + 'using' + '::' + 'rle', 
															 Prof_License_Mari.layout_IAS0887.common,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

