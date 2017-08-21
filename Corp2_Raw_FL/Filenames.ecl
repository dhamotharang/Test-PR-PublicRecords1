IMPORT tools, Corp2_Raw_FL;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_FL._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		// Vendor Data Files
		EXPORT TMFile    := tools.mod_FilenamesInput(Template('TMFile::FLTM'),  pversion);
		EXPORT CorpFile  := tools.mod_FilenamesInput(Template('CorpFile::FL'),  pversion);		
		EXPORT EventFile := tools.mod_FilenamesInput(Template('EventFile::FL'), pversion);		
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_FL._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT TMFile    := tools.mod_FilenamesBuild(Template('TMFile::FLTM'),  pversion);
		EXPORT CorpFile  := tools.mod_FilenamesBuild(Template('CorpFile::FL'),  pversion);		
		EXPORT EventFile := tools.mod_FilenamesBuild(Template('EventFile::FL'), pversion);		
		
		
		EXPORT dAll_TMFile    := TMFile.dAll_filenames;
		EXPORT dAll_CorpFile  := CorpFile.dAll_filenames;
		EXPORT dAll_EventFile := EventFile.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_TMFile +
													 Base.dAll_CorpFile +
													 Base.dAll_EventFile ;
	
END;