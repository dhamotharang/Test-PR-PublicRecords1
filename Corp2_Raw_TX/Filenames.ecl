IMPORT tools, Corp2_Raw_TX;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_TX._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Corp  := tools.mod_FilenamesInput(Template('master::tx'),  pversion);		
	END;

END;
