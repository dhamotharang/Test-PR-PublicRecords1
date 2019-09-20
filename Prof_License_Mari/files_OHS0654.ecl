//Ohio Department of Commerce / Multiple Professions //
IMPORT _control, Prof_License_Mari;

EXPORT files_OHS0654 := MODULE

	EXPORT prof_file 			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'OHS0654' + '::' + 'using' + '::' + 're', 
															 Prof_License_Mari.layout_OHS0654.layout_profession,
															 CSV(SEPARATOR(','),heading(1),quote('"')));
	
	// EXPORT mortgage_file	:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'OHS0654' + '::' + 'using' + '::' + 'dfi', 
															 // Prof_License_Mari.layout_OHS0654.layout_mortgage,
															 // CSV(SEPARATOR(','),heading(1),quote('"')));
	
END;

/*	dataset('~thor_data400::in::prolic::OHS0654::BROKER_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::CGA_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::CGAR_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::CGAT_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::CRA_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::CRAR_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::CRAT_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::FOREIGN_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::LRA_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::LRAR_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::LRAT_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::RLC_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+ dataset('~thor_data400::in::prolic::OHS0654::RREAA_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												+dataset('~thor_data400::in::prolic::OHS0654::SALESPERSON_file.txt',Prof_License_Mari.layout_OHS0654.layout_profession,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
												;	
	
	export mortgage_file := dataset('~thor_data400::in::prolic::OHS0654::LO_file.txt',Prof_License_Mari.layout_OHS0654.layout_mortgage,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
													+dataset('~thor_data400::in::prolic::OHS0654::BRK_file.txt',Prof_License_Mari.layout_OHS0654.layout_mortgage,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)))
													+dataset('~thor_data400::in::prolic::OHS0654::SBRK_file.txt',Prof_License_Mari.layout_OHS0654.layout_mortgage,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));	

*/
