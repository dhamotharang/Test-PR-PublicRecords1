IMPORT tools, Corp2_Raw_WA; 

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_WA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Corporations     := tools.mod_FilenamesInput(Template('corporations::wa'), pversion);	
		EXPORT GoverningPersons := tools.mod_FilenamesInput(Template('governingpersons::wa'), pversion);	
		EXPORT DocumentTypes    := tools.mod_FilenamesInput(Template('documenttypes::wa'), pversion);	
		
	END;
										 	
END;
