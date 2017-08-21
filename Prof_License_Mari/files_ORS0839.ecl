//Oregon Real Estate Agency 
IMPORT Prof_License_Mari;

EXPORT files_ORS0839 := MODULE

	SHARED code 		:= 'ORS0839';
	
	EXPORT act_bususiness := dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'act_business', 
													 Prof_License_Mari.layout_ORS0839.business,
													 CSV(SEPARATOR(','),heading(1),quote('"')));
	EXPORT all_individual	:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'all_individual', 
													 Prof_License_Mari.layout_ORS0839.individual,
													 CSV(SEPARATOR(','),heading(1),quote('"')));
END;

/*
export files_ORS0839 := MODULE
	export active_bus := dataset('~thor_data400::in::prolic::ORS0839::active_business.txt',Prof_License_Mari.layout_ORS0839.business,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));
	export in_active_ind := dataset('~thor_data400::in::prolic::ORS0839::active_inactive_ind.txt',Prof_License_Mari.layout_ORS0839.individual,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));

END;
*/


 