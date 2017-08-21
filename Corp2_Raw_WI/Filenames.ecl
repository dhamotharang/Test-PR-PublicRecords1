IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;		
		EXPORT comfichex         	  := tools.mod_FilenamesInput(Template('comfichex::wi'), pversion);		
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;		
		EXPORT comfichex    			  := tools.mod_FilenamesBuild(Template('comfichex::wi'), pversion);
		EXPORT dAll_filenames 			:= comfichex.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames := Base.dAll_filenames;
  
END;