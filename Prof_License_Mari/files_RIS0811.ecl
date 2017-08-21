//State of Rhode Island Dept of Business Regulation
IMPORT Prof_License_Mari;

EXPORT files_RIS0811 := MODULE

	EXPORT apr 					:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'RIS0811' + '::' + 'using' + '::' + 'apr', 
													Prof_License_Mari.layout_RIS0811.rAppraiser,
													CSV(SEPARATOR(','),heading(1),quote('"')));
													 
	EXPORT re						:= //dataset(Common_Prof_Lic_Mari.SourcesFolder + 'RIS0811' + '::' + 'using' + '::' + 're', 
													//Prof_License_Mari.layout_RIS0811.rBroker_sl,
													//CSV(SEPARATOR(','),heading(1),quote('"'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'RIS0811' + '::' + 'using' + '::' + 're', 
													Prof_License_Mari.layout_RIS0811.rBroker_sl,
													CSV(SEPARATOR(','),heading(1),quote('"')));

END;

/* export files_RIS0811 := MODULE;
   	export apr :=		dataset('~thor_data400::in::prolic::RIS0811::apr.txt',Prof_License_Mari.layout_RIS0811.rAppraiser,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));
   	export broker := dataset('~thor_data400::in::prolic::RIS0811::rle_br.txt',Prof_License_Mari.layout_RIS0811.rBroker_sl,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));
   	export rle_sl := dataset('~thor_data400::in::prolic::RIS0811::rle_sl.txt',Prof_License_Mari.layout_RIS0811.rBroker_sl,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));
   
   END;
*/