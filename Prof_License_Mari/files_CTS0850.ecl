// CTS0850 / Connecticut Dept of Consumer Protection / Multiple Professions //
EXPORT files_CTS0850 := MODULE

	SHARED code 								:= 'CTS0850';
	SHARED working_dir					:= 'using';
	
	SHARED file_general_apprs		:= 'general_apprs';
	SHARED file_residential_apprs:= 'residential_apprs';
	SHARED file_mobile_parks		:= 'mobile_parks';
	SHARED file_provisional_apprs:= 'provisional_apprs';
	SHARED file_brokers				 	:= 'brokers';
	SHARED file_salespersons	 	:= 'salespersons';
	
	EXPORT brokers		 					:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_brokers, 
																					Prof_License_Mari.layout_CTS0850.layout_broker,
																					CSV(SEPARATOR(','),heading(1),quote('\"'),TERMINATOR(['\n','\r\n','\n\r'])));
	EXPORT provisional_apprs		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_general_apprs, 
																					Prof_License_Mari.layout_CTS0850.layout_appraiser,
																					CSV(SEPARATOR(','),heading(1),quote('\"'),TERMINATOR(['\n','\r\n','\n\r']))) +
																 dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_residential_apprs, 
																					Prof_License_Mari.layout_CTS0850.layout_appraiser,
																					CSV(SEPARATOR(','),heading(1),quote('\"'),TERMINATOR(['\n','\r\n','\n\r'])));				
	EXPORT appraisers						:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_provisional_apprs, 
																					Prof_License_Mari.layout_CTS0850.layout_salesperson,
																					CSV(SEPARATOR(','),heading(1),quote('\"'),TERMINATOR(['\n','\r\n','\n\r']))) +
																 dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_salespersons, 
																					Prof_License_Mari.layout_CTS0850.layout_salesperson,
																					CSV(SEPARATOR(','),heading(1),quote('\"'),TERMINATOR(['\n','\r\n','\n\r'])));				

	EXPORT mobilehome_parks			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + file_mobile_parks, 
																					Prof_License_Mari.layout_CTS0850.layout_mobilehome_park,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;
/* export files_CTS0850 := MODULE
   export broker :=	dataset('~thor_data400::in::prolic::CTS0850::Brokers_file.csv',Prof_License_Mari.layout_CTS0850.layout_broker,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
   export prov_appraiser := dataset('~thor_data400::in::prolic::CTS0850::Provisional_Apprs.csv',Prof_License_Mari.layout_CTS0850.layout_appraiser,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
   export appraiser := dataset('~thor_data400::in::prolic::CTS0850::General_Apprs.csv',Prof_License_Mari.layout_CTS0850.layout_salesperson,csv(SEPARATOR(','),QUOTE('"'),heading(1)))
   										+dataset('~thor_data400::in::prolic::CTS0850::Residential_Apprs.csv',Prof_License_Mari.layout_CTS0850.layout_salesperson,csv(SEPARATOR(','),QUOTE('"'),heading(1)))
   										+dataset('~thor_data400::in::prolic::CTS0850::Salesperson_file.csv',Prof_License_Mari.layout_CTS0850.layout_salesperson,csv(SEPARATOR(','),QUOTE('"'),heading(1)));
   												
   END;
*/