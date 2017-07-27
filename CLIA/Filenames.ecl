IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Main                 := tools.mod_FilenamesInput(Template('Data'), pversion);
		EXPORT Accreditation        := tools.mod_FilenamesInput(Template('Accreditation'), pversion);
		EXPORT Compliance           := tools.mod_FilenamesInput(Template('Compliance'), pversion);
		EXPORT Microscopy           := tools.mod_FilenamesInput(Template('Microscopy'), pversion);
		EXPORT Waiver               := tools.mod_FilenamesInput(Template('Waiver'), pversion);
		
		EXPORT dAll_filenames :=
		  Main.dAll_filenames +
			Accreditation.dAll_filenames +
			Compliance.dAll_filenames +
			Microscopy.dAll_filenames +
			Waiver.dAll_filenames;
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