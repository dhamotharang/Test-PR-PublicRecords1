IMPORT tools, Corp2_Raw_AZ;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_AZ._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT COREXT := tools.mod_FilenamesInput(Template('COREXT::AZ'), pversion);		
		EXPORT CHGEXT := tools.mod_FilenamesInput(Template('CHGEXT::AZ'), pversion);	
		EXPORT FLMEXT := tools.mod_FilenamesInput(Template('FLMEXT::AZ'), pversion);		
		EXPORT OFFEXT := tools.mod_FilenamesInput(Template('OFFEXT::AZ'), pversion);	
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_AZ._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT COREXT := tools.mod_FilenamesBuild(Template('COREXT::AZ'), pversion);
		EXPORT CHGEXT := tools.mod_FilenamesBuild(Template('CHGEXT::AZ'), pversion);
		EXPORT FLMEXT := tools.mod_FilenamesBuild(Template('FLMEXT::AZ'), pversion);
		EXPORT OFFEXT := tools.mod_FilenamesBuild(Template('OFFEXT::AZ'), pversion);

		EXPORT dAll_COREXT := COREXT.dAll_filenames;
		EXPORT dAll_CHGEXT := CHGEXT.dAll_filenames;
		EXPORT dAll_FLMEXT := FLMEXT.dAll_filenames;
		EXPORT dAll_OFFEXT := OFFEXT.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_COREXT + Base.dAll_CHGEXT + 
													 Base.dAll_FLMEXT + Base.dAll_OFFEXT ;
	
END;
