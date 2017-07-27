IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Death       		:= tools.mod_FilenamesInput(Template('Death'), pversion);
		EXPORT Death_IL    		:= tools.mod_FilenamesInput(Template('Death_IL'), pversion);
		
		EXPORT dAll_filenames := Death.dAll_filenames +
		                         Death_IL.dAll_filenames;
	END;
	
	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Main                 := tools.mod_FilenamesBuild(Template('Data'), pversion);
		
		EXPORT dAll_filenames       := Main.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_filenames;
 
END;