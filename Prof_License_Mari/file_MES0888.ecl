//Board of Real Estate Licenses file from ME S0888
#workunit('name','File MES0888');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_MES0888 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MES0888' + '::' + 'using' + '::' + 're', 
															 Prof_License_Mari.layout_MES0888,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

//export file_MES0888 := dataset('~thor400_88::in::prolic::mes0888::real_estate.txt',Prof_License_Mari.layout_MES0888,csv(SEPARATOR(','),QUOTE('"'),HEADING(1),TERMINATOR(['\n', '\r\n'])));
