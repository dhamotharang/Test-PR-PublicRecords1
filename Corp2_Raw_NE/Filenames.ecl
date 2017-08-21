IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) 	:= Corp2_Raw_NE._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT CorpAction          		:= tools.mod_FilenamesInput(Template('CorpAction::NE'), pversion);
		EXPORT CorpOfficers        		:= tools.mod_FilenamesInput(Template('CorpOfficers::NE'), pversion);
		EXPORT CorpEntity         		:= tools.mod_FilenamesInput(Template('CorpEntity::NE'), pversion);	
		EXPORT RegisterAgent         	:= tools.mod_FilenamesInput(Template('RegisterAgent::NE'), pversion);	
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) 	:= Corp2_Raw_NE._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
			
		EXPORT CorpAction         		:= tools.mod_FilenamesBuild(Template('CorpAction::NE'), pversion);	
		EXPORT CorpOfficers    				:= tools.mod_FilenamesBuild(Template('CorpOfficers::NE'), pversion);	
		EXPORT CorpEntity    			  	:= tools.mod_FilenamesBuild(Template('CorpEntity::NE'), pversion);
		EXPORT RegisterAgent    			:= tools.mod_FilenamesBuild(Template('RegisterAgent::NE'), pversion);
				
		EXPORT dAll_CorpAction			  := CorpAction.dAll_filenames;
		EXPORT dAll_CorpOfficers  		:= CorpOfficers.dAll_filenames;
		EXPORT dAll_CorpEntity 			  := CorpEntity.dAll_filenames;
		EXPORT dAll_RegisterAgent 		:= RegisterAgent.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 					:= Base.dAll_CorpAction			+
																		 Base.dAll_CorpOfficers   +
																		 Base.dAll_CorpEntity 		+
																		 Base.dAll_RegisterAgent;
	
END;