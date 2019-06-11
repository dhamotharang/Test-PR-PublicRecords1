//Raw Real Estate Appraiser file from LA S0833
#workunit('name','Yogurt: File LAS0833');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_LAS0833 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'LAS0833' + '::' + 'using' + '::' + 'apr', 
															 Prof_License_Mari.layout_LAS0833,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

//export file_LAS0833 := dataset('~thor400_88::in::prolic::las0833::appraiser.txt',Prof_License_Mari.layout_LAS0833,flat);
