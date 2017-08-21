IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Corporation         	:= tools.mod_FilenamesInput(Template('corporations::dc'), pversion);		
		
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Corporation    			:= tools.mod_FilenamesBuild(Template('corporations::dc'), pversion);

		EXPORT dAll_filenames 			:= Corporation.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames := Base.dAll_filenames;
  
END;