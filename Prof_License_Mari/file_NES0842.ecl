/*Raw professional license file from the source NES0842
Replace all Quotes (") to single (') as it is messing up
the conversion.  Convert from xls file to tab delimited txt file
*/
#workunit('name','Yogurt: Files NES0842');
IMPORT _control, Prof_License_Mari;

export file_NES0842 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'NES0842' + '::' + 'using' + '::' + 're', 
															 Prof_License_Mari.layout_NES0842.common,
															 //CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['n\r\n','r\r\n'])));
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));