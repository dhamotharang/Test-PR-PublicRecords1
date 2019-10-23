IMPORT tools, Corp2_Raw_MT;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_MT._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT VendorRaw      			:= tools.mod_FilenamesInput(Template('vendor_raw::mt'), pversion);					

	END;

END;