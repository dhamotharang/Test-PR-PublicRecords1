IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) 	:= Corp2_Raw_NE._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT CorpActions          	:= tools.mod_FilenamesInput(Template('corporateactions::NE'), pversion);
		EXPORT CorpOfficers        		:= tools.mod_FilenamesInput(Template('corporateofficers::NE'), pversion);
		EXPORT CorpEntity         		:= tools.mod_FilenamesInput(Template('corporationentity::NE'), pversion);	
		EXPORT RegisteredAgent       	:= tools.mod_FilenamesInput(Template('registeredagent::NE'), pversion);
				
	  EXPORT CorpTypeTable     	    := tools.mod_FilenamesInput(Template('corporationtype::NE'), pversion);
		EXPORT CountryCodesTable   		:= tools.mod_FilenamesInput(Template('countrycodes::NE'), pversion);
		EXPORT ListOfStatesTable     	:= tools.mod_FilenamesInput(Template('listofstates::NE'), pversion);
		
		// Vendor files not currently being used, but leaving here for possible future use
		// EXPORT PositionHeldTable    	:= tools.mod_FilenamesInput(Template('PositionHeld::NE'), pversion);
		// EXPORT FilingTypeTable     	:= tools.mod_FilenamesInput(Template('FilingType::NE'), pversion);	
				
	END;

END;

