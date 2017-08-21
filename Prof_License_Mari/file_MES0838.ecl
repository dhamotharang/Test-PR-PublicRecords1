//Board of Real Estate Appraisers file from ME S0838
#workunit('name','File MES0838');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_MES0838 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MES0838' + '::' + 'using' + '::' + 'apr', 
															 Prof_License_Mari.layout_MES0838,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

//export file_MES0838 := dataset('~thor400_88::in::prolic::mes0838::appraiser.txt',Prof_License_Mari.layout_MES0838,csv(SEPARATOR(','),QUOTE('"'),HEADING(1),TERMINATOR(['\n', '\r\n'])));