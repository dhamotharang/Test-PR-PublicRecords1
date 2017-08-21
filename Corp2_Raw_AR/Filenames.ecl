IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_AR._dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT CorpData  	  := tools.mod_FilenamesInput(Template('CorpData::AR'), pversion);		
		EXPORT CorpNames    := tools.mod_FilenamesInput(Template('CorpNames::AR'), pversion);		
		EXPORT CorpOfficer 	:= tools.mod_FilenamesInput(Template('CorpOfficer::AR'), pversion);	
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_AR._dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CorpData   	:= tools.mod_FilenamesBuild(Template('CorpData::AR'), pversion);
		EXPORT CorpNames  	:= tools.mod_FilenamesBuild(Template('CorpNames::AR'), pversion);
		EXPORT CorpOfficer 	:= tools.mod_FilenamesBuild(Template('CorpOfficer::AR'), pversion);
		

		EXPORT dAll_CorpData  	:= CorpData.dAll_filenames;
		EXPORT dAll_CorpNames 	:= CorpNames.dAll_filenames;
		EXPORT dAll_CorpOfficer := CorpOfficer.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 	:= Base.dAll_CorpData  +
													   Base.dAll_CorpNames +
														 Base.dAll_CorpOfficer;
	
END;
