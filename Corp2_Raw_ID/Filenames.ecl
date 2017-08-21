IMPORT corp2_raw_ID, tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_ID._Dataset(pUseOtherEnvironment).InputTemplate + tag;		
		EXPORT vendorRaw 						:= tools.mod_FilenamesInput(Template('vendorRaw::id'), pversion);
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_ID._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
		EXPORT vendorRaw 						:= tools.mod_FilenamesBuild(Template('vendorRaw::id'), pversion);
		EXPORT dAll_vendorRaw		    := vendorRaw.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_vendorRaw;
	  
END;