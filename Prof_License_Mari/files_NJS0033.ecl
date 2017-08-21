// NJS033 / New Jersey Department of Law and Public Safety / Multiple Professions //
// Data Shared btw Scank PLOTN/MARI processes //
IMPORT _control, Prof_License_Mari;

EXPORT files_NJS0033 := MODULE

	SHARED code				:= 'NJS0033';
	EXPORT apr	  		:= DATASET(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'apr', 
															Prof_License_Mari.layout_NJS0033.common,
															CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;