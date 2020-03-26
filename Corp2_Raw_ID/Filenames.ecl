IMPORT corp2_raw_ID, tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_ID._Dataset(pUseOtherEnvironment).InputTemplate + tag;		
		
		EXPORT Filing 						  := tools.mod_FilenamesInput(Template('filing::id'), pversion);
		EXPORT FilingName 					:= tools.mod_FilenamesInput(Template('filingname::id'), pversion);
		EXPORT Party 						    := tools.mod_FilenamesInput(Template('party::id'), pversion);
		
	END;
 
END;