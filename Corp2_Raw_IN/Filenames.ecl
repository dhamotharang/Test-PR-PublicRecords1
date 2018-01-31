IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) 		:= Corp2_Raw_IN._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT CorpAgents	      				:= tools.mod_FilenamesInput(Template('corp_agents::in'), 			 pversion);					
		EXPORT CorpCorporations	     		:= tools.mod_FilenamesInput(Template('corp_corporations::in'), pversion);					
		EXPORT CorpFilings	      			:= tools.mod_FilenamesInput(Template('corp_filings::in'), 		 pversion);					
		EXPORT CorpMergers	      			:= tools.mod_FilenamesInput(Template('corp_mergers::in'), 		 pversion);					
		EXPORT CorpNames	      				:= tools.mod_FilenamesInput(Template('corp_names::in'), 			 pversion);					
		EXPORT CorpOfficers	      			:= tools.mod_FilenamesInput(Template('corp_officers::in'), 		 pversion);					

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) 		:= Corp2_Raw_IN._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CorpAgents	      				:= tools.mod_FilenamesBuild(Template('corp_agents::in'), 			 pversion);					
		EXPORT CorpCorporations	     		:= tools.mod_FilenamesBuild(Template('corp_corporations::in'), pversion);					
		EXPORT CorpFilings	      			:= tools.mod_FilenamesBuild(Template('corp_filings::in'), 		 pversion);					
		EXPORT CorpMergers	      			:= tools.mod_FilenamesBuild(Template('corp_mergers::in'), 		 pversion);					
		EXPORT CorpNames	      				:= tools.mod_FilenamesBuild(Template('corp_names::in'), 			 pversion);					
		EXPORT CorpOfficers	      			:= tools.mod_FilenamesBuild(Template('corp_officers::in'), 		 pversion);					
		
		EXPORT dAll_CorpAgents 				 	:= CorpAgents.dAll_filenames;
		EXPORT dAll_CorpCorporations 		:= CorpCorporations.dAll_filenames;
		EXPORT dAll_CorpFilings 				:= CorpFilings.dAll_filenames;
		EXPORT dAll_CorpMergers 			 	:= CorpMergers.dAll_filenames;
		EXPORT dAll_CorpNames 					:= CorpNames.dAll_filenames;
		EXPORT dAll_CorpOfficers 				:= CorpOfficers.dAll_filenames;
	END;
	
  EXPORT dAll_filenames 						:= Base.dAll_CorpAgents 			+
																			 Base.dAll_CorpCorporations +
																			 Base.dAll_CorpFilings 			+
																			 Base.dAll_CorpMergers 			+
																			 Base.dAll_CorpNames 				+
																			 Base.dAll_CorpOfficers;

END;