//Raw professional license files from the Kansas Real Estate Agents, Brokers, & Firms
IMPORT ut,_control, Prof_License_Mari, Lib_FileServices;

EXPORT file_KSS0903 := MODULE

	SHARED code := 'KSS0903';
	SHARED file_name := 'rle';

	EXPORT rle		 := dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + file_name, 
														Prof_License_Mari.layout_KSS0903.common,
														csv(SEPARATOR([',']),QUOTE('"')));
END;