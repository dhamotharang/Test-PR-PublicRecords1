//Raw professional license file from the source NHS0856
//Convert from xls file to tab delimited txt file

//export file_NHS0856 := dataset('~thor400_88::in::prolic::NHS0856::RealEstate.txt',Prof_License_Mari.layout_NHS0856,csv(SEPARATOR('\t'),heading(1)));
EXPORT file_NHS0856 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'NHS0856' + '::' + 'using' + '::' + 're', 
																Prof_License_Mari.layout_NHS0856,
																CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));