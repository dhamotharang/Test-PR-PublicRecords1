IMPORT tools, Corp2_Raw_MS;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_MS._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		// Vendor Data Files
		EXPORT Profiles := tools.mod_FilenamesInput(Template('profiles::ms'), pversion);		
		EXPORT Forms  	:= tools.mod_FilenamesInput(Template('forms::ms'), pversion);		
		
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_MS._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Profiles := tools.mod_FilenamesBuild(Template('profiles::ms'), pversion);		
		EXPORT Forms    := tools.mod_FilenamesBuild(Template('forms::ms'), pversion);	
   	
		EXPORT dAll_Profiles := Profiles.dAll_filenames;
		EXPORT dAll_Forms    := Forms.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_Profiles	+
													 Base.dAll_Forms    ;
													 	
END;
