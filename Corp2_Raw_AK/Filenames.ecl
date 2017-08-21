IMPORT tools, Corp2_Raw_AK;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_AK._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Corporations  	:= tools.mod_FilenamesInput(Template('Corporations::AK'), pversion);		
		EXPORT Officials     	:= tools.mod_FilenamesInput(Template('Officials::AK'), pversion);			
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_AK._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Corporations   := tools.mod_FilenamesBuild(Template('corporations::AK'), pversion);
		EXPORT Officials    	:= tools.mod_FilenamesBuild(Template('officials::AK'), pversion);

		EXPORT dAll_corporations  := Corporations.dAll_filenames;
		EXPORT dAll_officials 	  := Officials.dAll_filenames;
	END;
	
	EXPORT dAll_filenames 	:= Base.dAll_corporations +
													   Base.dAll_officials;
	
END;
