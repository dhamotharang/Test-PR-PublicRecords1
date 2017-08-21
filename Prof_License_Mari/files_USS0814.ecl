/*2015-10-22T22:10:21Z (Xia Sheng)
Bug: 187038 -
*/
// National Real Estate Appraisers USS0814
IMPORT _control, Prof_License_Mari;

EXPORT files_USS0814 := MODULE

	SHARED code				:= 'USS0814';
	EXPORT asc			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'asc', 
													Prof_License_Mari.layout_uss0814,
													CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;


