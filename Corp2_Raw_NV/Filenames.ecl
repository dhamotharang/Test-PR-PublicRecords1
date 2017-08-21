IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NV._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Corporation         	:= tools.mod_FilenamesInput(Template('corporation::nv'), pversion);
		EXPORT RA         					:= tools.mod_FilenamesInput(Template('ra::nv'), pversion);		
		EXPORT Officers         		:= tools.mod_FilenamesInput(Template('officers::nv'), pversion);		
		EXPORT Actions         			:= tools.mod_FilenamesInput(Template('actions::nv'), pversion);		
		EXPORT Stock         				:= tools.mod_FilenamesInput(Template('stocks::nv'), pversion);		
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NV._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Corporation    			:= tools.mod_FilenamesBuild(Template('corporations::nv'), pversion);
		EXPORT RA         					:= tools.mod_FilenamesBuild(Template('ra::nv'), pversion);		
		EXPORT Officers         		:= tools.mod_FilenamesBuild(Template('officers::nv'), pversion);		
		EXPORT Actions         			:= tools.mod_FilenamesBuild(Template('actions::nv'), pversion);		
		EXPORT Stock         				:= tools.mod_FilenamesBuild(Template('stocks::nv'), pversion);		

		EXPORT dAll_corporation 		:= Corporation.dAll_filenames;
		EXPORT dAll_ra 							:= RA.dAll_filenames;
		EXPORT dAll_officers 				:= Officers.dAll_filenames;
		EXPORT dAll_actions 				:= Actions.dAll_filenames;
		EXPORT dAll_stock 					:= Stock.dAll_filenames;				
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_corporation +
																	 Base.dAll_ra          +
													 				 Base.dAll_officers		 +
																	 Base.dAll_actions		 +
																	 Base.dAll_stock;
	
END;