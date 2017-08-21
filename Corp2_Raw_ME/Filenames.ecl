IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) 			:= Corp2_Raw_ME._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT CorpBulk      							:= tools.mod_FilenamesInput(Template('corp_bulk::me'), pversion);
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) 			:= Corp2_Raw_ME._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CorpBulk    								:= tools.mod_FilenamesBuild(Template('corp_bulk::me'), pversion);

		EXPORT dAll_CorpBulk 							:= CorpBulk.dAll_filenames;
	END;
	
	EXPORT dAll_filenames 							:= Base.dAll_CorpBulk;
	
END;