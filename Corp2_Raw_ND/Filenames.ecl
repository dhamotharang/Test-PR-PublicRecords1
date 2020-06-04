IMPORT corp2_raw_ND, tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_ND._Dataset(pUseOtherEnvironment).InputTemplate + tag;		
		
		EXPORT Filing 				:= tools.mod_FilenamesInput(Template('filing::nd'), pversion);
		EXPORT Owner 					:= tools.mod_FilenamesInput(Template('owner::nd'), pversion);
		EXPORT Trademark 			:= tools.mod_FilenamesInput(Template('trademark::nd'), pversion);
		EXPORT TrademarkClass := tools.mod_FilenamesInput(Template('trademark_class::nd'), pversion);
		
	END;
 
END;