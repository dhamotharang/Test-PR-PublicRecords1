IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_WV._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Addresses          := tools.mod_FilenamesInput(Template('addresses::WV'), pversion);
		EXPORT amendments         := tools.mod_FilenamesInput(Template('amendments::WV'), pversion);		
		EXPORT annualreports      := tools.mod_FilenamesInput(Template('annualreports::WV'), pversion);		
		EXPORT corporations       := tools.mod_FilenamesInput(Template('corporations::WV'), pversion);	
		EXPORT Dissolutions       := tools.mod_FilenamesInput(Template('dissolutions::WV'), pversion);	
		EXPORT dbas         			:= tools.mod_FilenamesInput(Template('dbas::WV'), pversion);
		EXPORT mergers       			:= tools.mod_FilenamesInput(Template('mergers::WV'), pversion);	
		EXPORT namechanges       	:= tools.mod_FilenamesInput(Template('namechanges::WV'), pversion);	
		EXPORT subsidiaries       := tools.mod_FilenamesInput(Template('subsidiaries::WV'), pversion);		
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_WV._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
			
		EXPORT Addresses         	:= tools.mod_FilenamesBuild(Template('addresses::WV'), pversion);	
		EXPORT amendments    			:= tools.mod_FilenamesBuild(Template('amendments::WV'), pversion);
		EXPORT annualreports     	:= tools.mod_FilenamesBuild(Template('annualreports::WV'), pversion);			
		EXPORT corporations       := tools.mod_FilenamesBuild(Template('corporations::WV'), pversion);		
		EXPORT Dissolutions       := tools.mod_FilenamesBuild(Template('dissolutions::WV'), pversion);	
		EXPORT dbas         			:= tools.mod_FilenamesBuild(Template('dbas::WV'), pversion);
		EXPORT mergers       			:= tools.mod_FilenamesBuild(Template('mergers::WV'), pversion);		
		EXPORT namechanges       	:= tools.mod_FilenamesBuild(Template('namechanges::WV'), pversion);	
		EXPORT subsidiaries       := tools.mod_FilenamesBuild(Template('subsidiaries::WV'), pversion);
				
		EXPORT dAll_Addresses			  := addresses.dAll_filenames;
		EXPORT dAll_amendments 			:= amendments.dAll_filenames;
		EXPORT dAll_annualreports   := annualreports.dAll_filenames;
		EXPORT dAll_corporations 		:= corporations.dAll_filenames;
		EXPORT dAll_Dissolutions 		:= dissolutions.dAll_filenames;
		EXPORT dAll_dbas 					  := dbas.dAll_filenames;
		EXPORT dAll_mergers 				:= mergers.dAll_filenames;
		EXPORT dAll_namechanges 		:= namechanges.dAll_filenames;
		EXPORT dAll_subsidiaries 		:= subsidiaries.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_addresses			+
																	 Base.dAll_amendments 		+
																	 Base.dAll_annualreports	+
													 				 Base.dAll_corporations		+
																	 Base.dAll_dissolutions   +																	 
																	 Base.dAll_dbas						+
																	 Base.dAll_mergers		 		+
																	 Base.dAll_namechanges    +																	 
																	 Base.dAll_subsidiaries	;
	
END;