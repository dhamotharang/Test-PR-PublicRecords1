IMPORT tools;
	
EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_MI._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT CorpMaster	    			:= tools.mod_FilenamesInput(Template('corporation::mi'), pversion);
		EXPORT AssumedName	    		:= tools.mod_FilenamesInput(Template('assumedname::mi'), pversion);
		EXPORT GeneralPartner  			:= tools.mod_FilenamesInput(Template('generalpartner::mi'), pversion);
		EXPORT History	    				:= tools.mod_FilenamesInput(Template('history::mi'), pversion);
    EXPORT LLC            			:= tools.mod_FilenamesInput(Template('limitedliabilityco::mi'), pversion);  
		EXPORT LP             			:= tools.mod_FilenamesInput(Template('limitedpartnership::mi'), pversion);
		EXPORT NameRegistration			:= tools.mod_FilenamesInput(Template('nameregistration::mi'), pversion);
	END;
END;