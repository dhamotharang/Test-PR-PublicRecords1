IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_GA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT address         			:= tools.mod_FilenamesInput(Template('address::ga'), pversion);
		EXPORT Corporation         	:= tools.mod_FilenamesInput(Template('corporation::ga'), pversion);		
		EXPORT filing         			:= tools.mod_FilenamesInput(Template('filing::ga'), pversion);		
		EXPORT Officer         			:= tools.mod_FilenamesInput(Template('officer::ga'), pversion);	
		EXPORT RAgent         			:= tools.mod_FilenamesInput(Template('ragent::ga'), pversion);	
		EXPORT Stock         				:= tools.mod_FilenamesInput(Template('stock::ga'), pversion);			
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_GA._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
			
		EXPORT address         			:= tools.mod_FilenamesBuild(Template('address::ga'), pversion);	
		EXPORT Corporation    			:= tools.mod_FilenamesBuild(Template('corporations::ga'), pversion);
		EXPORT filing         			:= tools.mod_FilenamesBuild(Template('filing::ga'), pversion);			
		EXPORT Officer         			:= tools.mod_FilenamesBuild(Template('officer::ga'), pversion);		
		EXPORT RAgent         			:= tools.mod_FilenamesBuild(Template('ragent::ga'), pversion);	
		EXPORT Stock         				:= tools.mod_FilenamesBuild(Template('stock::ga'), pversion);
				
		EXPORT dAll_address					:= address.dAll_filenames;
		EXPORT dAll_corporation 		:= Corporation.dAll_filenames;
		EXPORT dAll_filing 					:= filing.dAll_filenames;
		EXPORT dAll_Officer 				:= Officer.dAll_filenames;
		EXPORT dAll_RAgent 					:= RAgent.dAll_filenames;
		EXPORT dAll_stock 					:= Stock.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_address		 		+
																	 Base.dAll_corporation 		+
																	 Base.dAll_filing		 			+
													 				 Base.dAll_Officer		 		+
																	 Base.dAll_RAgent         +																	 
																	 Base.dAll_stock;
	
END;