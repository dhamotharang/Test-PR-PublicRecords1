IMPORT tools, Corp2_Raw_WA;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_WA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT corps := tools.mod_FilenamesInput(Template('wa_vendor_data::wa'), pversion);		
		
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_WA._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT corps := tools.mod_FilenamesBuild(Template('wa_vendor_data::wa'), pversion);		
   	
		EXPORT dAll_corps := corps.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_corps;
													 	
END;
