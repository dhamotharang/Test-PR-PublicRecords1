IMPORT tools, Corp2_Raw_NJ;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
	
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NJ._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Business             := tools.mod_FilenamesInput(Template('business::nj'), pversion);
	END;
	
	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NJ._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Business    			    := tools.mod_FilenamesBuild(Template('business::nj'), pversion);

		EXPORT dAll_filenames 			:= Business.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames := Base.dAll_filenames;
  
END;

