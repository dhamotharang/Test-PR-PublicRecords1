//Raw professional license file from IDS0262
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_IDS0262 := MODULE

	EXPORT apr	 					:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0262' + '::' + 'using' + '::' + 'apr', 
																					Prof_License_Mari.layout_IDS0262,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
	
END;

//export file_IDS0262 := MODULE
//export appraiser	:= dataset('~thor400_88::in::prolic::ids0262::appraiser.txt',Prof_License_Mari.layout_IDS0262,csv(HEADING(1), SEPARATOR(','), QUOTE('"'),TERMINATOR('\t\r\n\f')));
//END;