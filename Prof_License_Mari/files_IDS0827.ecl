// IDS0827 / Idaho Real Estate Commission Agents/ Multiple Professions //
IMPORT Prof_License_Mari;

EXPORT files_IDS0827 := MODULE

	//Use for 20130502 and 20130807
	// export file_cmpy 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'company', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));
	// export file_mtg	 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'licensee', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));
																 	// export file_cmpy 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'company', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));
	// export file_cmpy 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'companies', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));
 
  // export file_mtg	 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'associate_broker', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'broker_inactive', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'cert_instructor', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'desig_broker', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'limited_broker', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'managing_associate_broker', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'managing_broker', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'managing_salesperson', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'salesperson', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));
	//For 20140714
	// export file_cmpy 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'branchoffice', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'corporations', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'llc', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'llp', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'lp', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'partnerships', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 // dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'sp', 
																 // Prof_License_Mari.layouts_IDS0827.rCompany,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));
 
  // export file_mtg	 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'licensees', 
																 // Prof_License_Mari.layouts_IDS0827.rMortgage,
																 // CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));

	//20140813
	export file_cmpy 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'branch', 
																 Prof_License_Mari.layouts_IDS0827.rCompany,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'corporation', 
																 Prof_License_Mari.layouts_IDS0827.rCompany,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'llc', 
																 Prof_License_Mari.layouts_IDS0827.rCompany,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'llp', 
																 Prof_License_Mari.layouts_IDS0827.rCompany,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'lp', 
																 Prof_License_Mari.layouts_IDS0827.rCompany,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'partnership', 
																 Prof_License_Mari.layouts_IDS0827.rCompany,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'sp', 
																 Prof_License_Mari.layouts_IDS0827.rCompany,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));
 
  export file_mtg	 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'associate_broker', 
																 Prof_License_Mari.layouts_IDS0827.rMortgage,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'broker', 
																 Prof_License_Mari.layouts_IDS0827.rMortgage,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'desig_broker', 
																 Prof_License_Mari.layouts_IDS0827.rMortgage,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'limited_broker', 
																 Prof_License_Mari.layouts_IDS0827.rMortgage,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'managing_associate_broker', 
																 Prof_License_Mari.layouts_IDS0827.rMortgage,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n'))) +
												 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'salesperson', 
																 Prof_License_Mari.layouts_IDS0827.rMortgage,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));


	export file_rel			:=  dataset(Common_Prof_Lic_Mari.SourcesFolder + 'IDS0827' + '::' + 'using' + '::' + 'rel', 
																 Prof_License_Mari.layouts_IDS0827.Common,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));
END;

