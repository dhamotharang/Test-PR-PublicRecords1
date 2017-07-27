IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT License_Status := tools.mod_FilenamesInput(Template('License_Status'), pversion);
		EXPORT Licensee       := tools.mod_FilenamesInput(Template('Licensee'), pversion);
		EXPORT IL_License     := tools.mod_FilenamesInput(Template('IL_License'), pversion);
		
		EXPORT dAll_filenames := License_Status.dAll_filenames +
			                       Licensee.dAll_filenames +
			                       IL_License.dAll_filenames;
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