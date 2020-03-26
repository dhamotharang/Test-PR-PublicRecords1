IMPORT tools, Corp2_Raw_AZ;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_AZ._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT COREXT := tools.mod_FilenamesInput(Template('COREXT::AZ'), pversion);		
		EXPORT CHGEXT := tools.mod_FilenamesInput(Template('CHGEXT::AZ'), pversion);	
		EXPORT FLMEXT := tools.mod_FilenamesInput(Template('FLMEXT::AZ'), pversion);		
		EXPORT OFFEXT := tools.mod_FilenamesInput(Template('OFFEXT::AZ'), pversion);	
		EXPORT INACTV := tools.mod_FilenamesInput(Template('INACTV::AZ'), pversion);
	END;

END;
