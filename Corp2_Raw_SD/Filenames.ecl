IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_SD._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT vendor_main          := tools.mod_FilenamesInput(Template('vendor_main::sd'), pversion);
		EXPORT vendor_amendments    := tools.mod_FilenamesInput(Template('vendor_amendments::sd'), pversion);		
		EXPORT vendor_ar            := tools.mod_FilenamesInput(Template('vendor_ar::sd'), pversion);		

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_SD._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT vendor_main    			:= tools.mod_FilenamesBuild(Template('vendor_main::sd'), pversion);
		EXPORT vendor_amendments    := tools.mod_FilenamesBuild(Template('vendor_amendments::sd'), pversion);	
		EXPORT vendor_ar            := tools.mod_FilenamesBuild(Template('vendor_ar::sd'), pversion);		


		EXPORT dAll_vendor_main 		  := vendor_main.dAll_filenames;
		EXPORT dAll_vendor_amendments := vendor_amendments.dAll_filenames;	
		EXPORT dAll_vendor_ar       	:= vendor_ar.dAll_filenames;				

	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_vendor_main +
																	 Base.dAll_vendor_amendments +
																	 Base.dAll_vendor_ar;
	
END;