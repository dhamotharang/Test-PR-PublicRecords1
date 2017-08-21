// INS0644 / Indiana Department of Financial Institutions / Other Lenders //
IMPORT Prof_License_Mari;

EXPORT files_INS0644 := MODULE

	export ds_company 	:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'INS0644' + '::' + 'using' + '::' + 'ds_company', 
																 Prof_License_Mari.layout_INS0644.Corp,
																 FLAT);
	export ds_branch	 	:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'INS0644' + '::' + 'using' + '::' + 'ds_branch', 
																 Prof_License_Mari.layout_INS0644.Branch,
																 FLAT);
	export mtg_lender 	:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'INS0644' + '::' + 'using' + '::' + 'mtg_lender', 
																 Prof_License_Mari.layout_INS0644.Corp,
																 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\n')));
END;

// export files_INS0644 := MODULE

	// export ds_company := dataset('~thor_data400::in::prolic::ins0644::company.txt',Prof_License_Mari.layout_INS0644.Corp,flat);
	// export ds_branch := dataset('~thor_data400::in::prolic::ins0644::branch.txt',Prof_License_Mari.layout_INS0644.Branch,flat);
	// export mtg_lender := dataset('~thor_data400::in::prolic::ins0644::mortgage_lender.csv',Prof_License_Mari.layout_INS0644.Corp,csv(SEPARATOR(','),QUOTE('"'),heading(1),TERMINATOR('\n')));

// END;