IMPORT corp2_raw_la, tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) 			:= Corp2_Raw_LA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT CorpsEntities      				:= tools.mod_FilenamesInput(Template('corps_entities::la'), pversion);
		EXPORT Agents											:= tools.mod_FilenamesInput(Template('agents::la'), pversion);		
		EXPORT Filings       							:= tools.mod_FilenamesInput(Template('filings::la'), pversion);		
		EXPORT Mergers         						:= tools.mod_FilenamesInput(Template('mergers::la'),	pversion);
		EXPORT PreviousNames         			:= tools.mod_FilenamesInput(Template('previous_names::la'),	pversion);
		EXPORT TradeServices      				:= tools.mod_FilenamesInput(Template('trade_services::la'), pversion);
		EXPORT NameReservs      					:= tools.mod_FilenamesInput(Template('name_reservs::la'), pversion);
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) 			:= Corp2_Raw_LA._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CorpsEntities    					:= tools.mod_FilenamesBuild(Template('corps_entities::la'), pversion);
		EXPORT Agents			 								:= tools.mod_FilenamesBuild(Template('agents::la'), pversion);		
		EXPORT Filings										:= tools.mod_FilenamesBuild(Template('filings::la'), pversion);
		EXPORT Mergers         						:= tools.mod_FilenamesBuild(Template('mergers::la'), pversion);
		EXPORT PreviousNames         			:= tools.mod_FilenamesBuild(Template('previous_names::la'), pversion);
		EXPORT TradeServices      				:= tools.mod_FilenamesBuild(Template('trade_services::la'), pversion);		
		EXPORT NameReservs      					:= tools.mod_FilenamesBuild(Template('name_reservs::la'), pversion);		

		EXPORT dAll_corpsentities 				:= CorpsEntities.dAll_filenames;
		EXPORT dAll_agents 								:= Agents.dAll_filenames;
		EXPORT dAll_filings								:= Filings.dAll_filenames;
		EXPORT dAll_mergers 							:= Mergers.dAll_filenames;
		EXPORT dAll_previousnames					:= PreviousNames.dAll_filenames;		
		EXPORT dAll_tradeservices 				:= TradeServices.dAll_filenames;
		EXPORT dAll_namereservs 					:= NameReservs.dAll_filenames;				
		
	END;
	
	EXPORT dAll_filenames 							:= Base.dAll_corpsentities 			+
																				 Base.dAll_agents 						+
																				 Base.dAll_filings		 				+
																				 Base.dAll_mergers		 				+
																				 Base.dAll_previousnames			+
																				 Base.dAll_tradeservices			+
																				 Base.dAll_namereservs;
																				 
	
END;