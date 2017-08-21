//Raw professional license file from ILS0631
/* Convert HTML file to text file using the following steps:
To convert html to txt
   1.  Open html in Word.
   2.  Convert table to text using tab as delimiter.
   3.  Replace all manual line breaks with a caret (^) character.
   4.  Replace all " with blank.
   5.  Save as text only.
   6.  Remove Header
4/25/13 - This file is delivered to development team in xls/csv format now.
*/
IMPORT Prof_License_Mari;

EXPORT file_ILS0631 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'ILS0631' + '::' + 'using' + '::' + 'mtg_license', 
																					Prof_License_Mari.layout_ILS0631,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\r\n')));
	

//export file_ILS0631	:= dataset('~thor400_88::in::prolic::ils0631::mortgage.txt',Prof_License_Mari.layout_ILS0631,csv(SEPARATOR('|'), TERMINATOR(['\n', '\r\n'])));

