IMPORT tools, Corp2_Raw_CA;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_CA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		// Vendor Data Files
		EXPORT Mast := tools.mod_FilenamesInput(Template('mast::ca'), pversion);
		EXPORT Hist := tools.mod_FilenamesInput(Template('hist::ca'), pversion);		
		EXPORT LP   := tools.mod_FilenamesInput(Template('lp::ca'), pversion);		
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_CA._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Mast := tools.mod_FilenamesBuild(Template('mast::ca'), pversion);
		EXPORT Hist := tools.mod_FilenamesBuild(Template('hist::ca'), pversion);		
		EXPORT LP   := tools.mod_FilenamesBuild(Template('lp::ca'), pversion);	
		   	
		EXPORT dAll_Mast := Mast.dAll_filenames;
		EXPORT dAll_Hist := Hist.dAll_filenames;
		EXPORT dAll_LP   := LP.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_Mast +
													 Base.dAll_Hist +
													 Base.dAll_LP   ;
													 	
END;