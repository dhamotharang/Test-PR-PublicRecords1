IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_RI._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Entities          	:= tools.mod_FilenamesInput(Template('Entities::RI'), pversion);
		EXPORT Inactive_Entities  := tools.mod_FilenamesInput(Template('Inactive_Entities::RI'), pversion);
		EXPORT amendments         := tools.mod_FilenamesInput(Template('amendments::RI'), pversion);
		EXPORT Inactive_amendments:= tools.mod_FilenamesInput(Template('Inactive_amendments::RI'), pversion);	
		EXPORT Mergers      			:= tools.mod_FilenamesInput(Template('Mergers::RI'), pversion);		
		EXPORT Inactive_Mergers   := tools.mod_FilenamesInput(Template('Inactive_Mergers::RI'), pversion);		
		EXPORT Names       				:= tools.mod_FilenamesInput(Template('Names::RI'), pversion);	
		EXPORT Inactive_Names     := tools.mod_FilenamesInput(Template('Inactive_Names::RI'), pversion);	
		EXPORT Officers       		:= tools.mod_FilenamesInput(Template('Officers::RI'), pversion);	
		EXPORT Inactive_Officers  := tools.mod_FilenamesInput(Template('Inactive_Officers::RI'), pversion);	
		EXPORT Stocks         		:= tools.mod_FilenamesInput(Template('Stocks::RI'), pversion);
		EXPORT Inactive_Stocks    := tools.mod_FilenamesInput(Template('Inactive_Stocks::RI'), pversion);
	
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_RI._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
			
		EXPORT Entities         	:= tools.mod_FilenamesBuild(Template('Entities::RI'), pversion);	
		EXPORT amendments    			:= tools.mod_FilenamesBuild(Template('amendments::RI'), pversion);
		EXPORT Mergers     				:= tools.mod_FilenamesBuild(Template('Mergers::RI'), pversion);			
		EXPORT Names       				:= tools.mod_FilenamesBuild(Template('Names::RI'), pversion);		
		EXPORT Officers       		:= tools.mod_FilenamesBuild(Template('Officers::RI'), pversion);	
		EXPORT Stocks         		:= tools.mod_FilenamesBuild(Template('Stocks::RI'), pversion);
		EXPORT Inactive_Entities  := tools.mod_FilenamesBuild(Template('Inactive_Entities::RI'), pversion);	
		EXPORT Inactive_amendments:= tools.mod_FilenamesBuild(Template('Inactive_amendments::RI'), pversion);
		EXPORT Inactive_Mergers   := tools.mod_FilenamesBuild(Template('Inactive_Mergers::RI'), pversion);			
		EXPORT Inactive_Names     := tools.mod_FilenamesBuild(Template('Inactive_Names::RI'), pversion);		
		EXPORT Inactive_Officers  := tools.mod_FilenamesBuild(Template('Inactive_Officers::RI'), pversion);	
		EXPORT Inactive_Stocks    := tools.mod_FilenamesBuild(Template('Inactive_Stocks::RI'), pversion);
			
		EXPORT dAll_Entities							:= Entities.dAll_filenames;
		EXPORT dAll_amendments 						:= amendments.dAll_filenames;
		EXPORT dAll_Mergers   						:= Mergers.dAll_filenames;
		EXPORT dAll_Names 								:= Names.dAll_filenames;
		EXPORT dAll_Officers 							:= Officers.dAll_filenames;
		EXPORT dAll_Stocks 								:= Stocks.dAll_filenames;
		EXPORT dAll_Inactive_Entities			:= Entities.dAll_filenames;
		EXPORT dAll_Inactive_amendments 	:= amendments.dAll_filenames;
		EXPORT dAll_Inactive_Mergers   		:= Mergers.dAll_filenames;
		EXPORT dAll_Inactive_Names 				:= Names.dAll_filenames;
		EXPORT dAll_Inactive_Officers 		:= Officers.dAll_filenames;
		EXPORT dAll_Inactive_Stocks 			:= Stocks.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_Entities							+
																	 Base.dAll_amendments 					+
																	 Base.dAll_Mergers							+
													 				 Base.dAll_Names								+
																	 Base.dAll_Officers  						+																	 
																	 Base.dAll_Stocks								+
																	 Base.dAll_Inactive_Entities	  +
																	 Base.dAll_Inactive_amendments 	+
																	 Base.dAll_Inactive_Mergers			+
													 				 Base.dAll_Inactive_Names				+
																	 Base.dAll_Inactive_Officers  	+																	 
																	 Base.dAll_Inactive_Stocks			;
	
END;