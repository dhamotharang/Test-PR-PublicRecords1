//Raw data for Iowa Real Estate Commission & Appraisal / Real Estate Appraisers
#workunit('name','File IAS0826');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_IAS0826 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IAS0826' + '::' + 'using' + '::' + 'apr', 
															 Prof_License_Mari.layout_IAS0826.common,
															 CSV(SEPARATOR(','),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

//export file_IAS0826 := dataset('~thor400_88::in::prolic::IAS0826::apr',Prof_License_Mari.layout_IAS0826,csv(SEPARATOR('\t'),heading(1)));