//Oklahoma Real Estate Commission
#workunit('name','Files OKS0817');
IMPORT _control, Prof_License_Mari;

export file_OKS0817 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'OKS0817' + '::' + 'using' + '::' + 're', 
															 Prof_License_Mari.layout_OKS0817,
															 CSV(SEPARATOR(','),heading(1),quote('"')));

//export file_OKS0817 := dataset('~thor_data400::in::prolic::OKS0817::extract.txt',Prof_License_Mari.layout_OKS0817,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));



