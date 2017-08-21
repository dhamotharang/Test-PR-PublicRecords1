IMPORT corp2_raw_ks, tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_KS._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT CPABREP 				:= tools.mod_FilenamesInput(Template('cpabrep::ks'), pversion);					
		EXPORT CPADREP 				:= tools.mod_FilenamesInput(Template('cpadrep::ks'), pversion);					
		EXPORT CPAEREP 				:= tools.mod_FilenamesInput(Template('cpaerep::ks'), pversion);					
		EXPORT CPAHST 				:= tools.mod_FilenamesInput(Template('cpahst::ks') , pversion);					
		EXPORT CPAQREP 				:= tools.mod_FilenamesInput(Template('cpaqrep::ks'), pversion);					
		EXPORT CPBCREP 				:= tools.mod_FilenamesInput(Template('cpbcrep::ks'), pversion);					

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_KS._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CPABREP 				:= tools.mod_FilenamesBuild(Template('cpabrep::ks'), pversion);					
		EXPORT CPADREP 				:= tools.mod_FilenamesBuild(Template('cpadrep::ks'), pversion);					
		EXPORT CPAEREP 				:= tools.mod_FilenamesBuild(Template('cpaerep::ks'), pversion);					
		EXPORT CPAHST 				:= tools.mod_FilenamesBuild(Template('cpahst::ks') , pversion);					
		EXPORT CPAQREP 				:= tools.mod_FilenamesBuild(Template('cpaqrep::ks'), pversion);					
		EXPORT CPBCREP 				:= tools.mod_FilenamesBuild(Template('cpbcrep::ks'), pversion);	

		EXPORT dAll_CPABREP		:= CPABREP.dAll_filenames;
		EXPORT dAll_CPADREP		:= CPADREP.dAll_filenames;
		EXPORT dAll_CPAEREP		:= CPAEREP.dAll_filenames;
		EXPORT dAll_CPAHST		:= CPAHST.dAll_filenames;
		EXPORT dAll_CPAQREP		:= CPAQREP.dAll_filenames;
		EXPORT dAll_CPBCREP		:= CPBCREP.dAll_filenames;

	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_CPABREP  +
																	 Base.dAll_CPADREP  +
													 				 Base.dAll_CPAEREP	+
																	 Base.dAll_CPAHST		+
																	 Base.dAll_CPAQREP	+
																	 Base.dAll_CPBCREP;
	  
END;