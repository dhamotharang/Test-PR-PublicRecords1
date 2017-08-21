//Texas Office of Consumer Credit Commissioner
IMPORT _control, Prof_License_Mari;

EXPORT file_TXS0636 := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'TXS0636' + '::' + 'using' + '::' + 'reg_lenders', 
															 Prof_License_Mari.layout_TXS0636.src,
															 CSV(SEPARATOR(','),quote('"')));

