IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_MN._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT FullFile      				:= tools.mod_FilenamesInput(Template('fullfile::mn'), pversion);					

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_MN._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT FullFile    					:= tools.mod_FilenamesBuild(Template('fullfile::mn'), pversion);
		EXPORT Master	    					:= tools.mod_FilenamesBuild(Template('master::mn'), pversion);
		EXPORT FilingHist    				:= tools.mod_FilenamesBuild(Template('filinghist::mn'), pversion);
		EXPORT NameAddr    					:= tools.mod_FilenamesBuild(Template('nameaddr::mn'), pversion);

		EXPORT dAll_FullFile 				:= FullFile.dAll_filenames;
		EXPORT dAll_Master 					:= Master.dAll_filenames;
		EXPORT dAll_FilingHist 			:= FilingHist.dAll_filenames;
		EXPORT dAll_NameAddr 				:= NameAddr.dAll_filenames;

	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_FullFile 	+
																	 Base.dAll_Master   	+
																	 Base.dAll_FilingHist	+
																	 Base.dAll_NameAddr;
  
END;