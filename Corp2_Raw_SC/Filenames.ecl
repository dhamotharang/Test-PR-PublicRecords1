IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_SC._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT CorpFile     	:= tools.mod_FilenamesInput(Template('corpfile::sc'), pversion);
		EXPORT CorpName     	:= tools.mod_FilenamesInput(Template('corpnamefile::sc'), pversion);
		EXPORT CorpTXN  			:= tools.mod_FilenamesInput(Template('corptxnfile::sc'), pversion);

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_SC._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CorpFile     	:= tools.mod_FilenamesBuild(Template('corpfile::sc'), pversion);
		EXPORT CorpName     	:= tools.mod_FilenamesBuild(Template('corpnamefile::sc'), pversion);
		EXPORT CorpTXN  			:= tools.mod_FilenamesBuild(Template('corptxnfile::sc'), pversion);

		EXPORT dAll_CorpFile 	:= CorpFile.dAll_filenames;
		EXPORT dAll_CorpName 	:= CorpName.dAll_filenames;
		EXPORT dAll_CorpTXN 	:= CorpTXN.dAll_filenames;		

	END;
	
	EXPORT dAll_filenames 					:= Base.dAll_CorpFile 				+
																		 Base.dAll_CorpName        	+
																		 Base.dAll_CorpTXN;
	  
END;			