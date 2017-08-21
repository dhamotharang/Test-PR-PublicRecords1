// IDS0658 / Idaho Dept of Finance / Multiple Professions //
//Raw professional license files from HIS0117
//#workunit('name','File IDS0658');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_IDS0658 := MODULE

	SHARED code 								:= 'IDS0658';
	
	EXPORT mortgage							:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'mortgage', 
																					Prof_License_Mari.layout_IDS0658.mortgage,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\r\n')));
	EXPORT icc									:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'icc', 
																					Prof_License_Mari.layout_IDS0658.icc,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\r\n')));			
END;
/*
export files_IDS0658 := MODULE

	export mortgage  := dataset('~thor_data400::in::prolic::ids0658::mortgage',Prof_License_Mari.layout_IDS0658.mortgage,csv(SEPARATOR('\t'),heading(1)));

	export icc       := dataset('~thor_data400::in::prolic::ids0658::icc',Prof_License_Mari.layout_IDS0658.icc,csv(SEPARATOR('\t'),heading(1)));
							    
END;
*/