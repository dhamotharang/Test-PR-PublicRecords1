//Raw Mortgage Lenders files from USS0645
// Convert multiple sheet Excel file to text files 

export files_USS0645 := MODULE

	export T1Lenders	:= dataset('~thor_data400::in::prolic::uss0645::lenders1.txt',Prof_License_Mari.layout_USS0645.T1Lenders,csv(SEPARATOR('\t'),heading(1)));
	export T2Lenders	:= dataset('~thor_data400::in::prolic::uss0645::lenders2.txt',Prof_License_Mari.layout_USS0645.T2Lenders,csv(SEPARATOR('\t'),heading(1)));
	
END;