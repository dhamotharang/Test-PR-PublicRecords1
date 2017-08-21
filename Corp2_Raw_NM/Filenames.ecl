IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NM._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT ImportMaster        	:= tools.mod_FilenamesInput(Template('import_master::nm'), pversion);					

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NM._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT ImportMaster    			:= tools.mod_FilenamesBuild(Template('import_master::nm'), pversion);

		EXPORT dAll_filenames 			:= ImportMaster.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames := Base.dAll_filenames;
  
END;