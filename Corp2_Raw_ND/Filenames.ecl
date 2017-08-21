IMPORT tools, Corp2_Raw_ND;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_ND._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		// Vendor Data Files
		EXPORT Corp1      	:= tools.mod_FilenamesInput(Template('Corpa_Vendor::nd'), pversion);
		EXPORT Corp2      	:= tools.mod_FilenamesInput(Template('Corpb_Vendor::nd'), pversion);		
		EXPORT FictName1    := tools.mod_FilenamesInput(Template('Fictitios1_Vendor::nd'), pversion);		
		EXPORT FictName2  	:= tools.mod_FilenamesInput(Template('Fictitios2_Vendor::nd'), pversion);		
		EXPORT Partnership  := tools.mod_FilenamesInput(Template('partnership_vendor::nd'), pversion);	
		EXPORT TradeMark1   := tools.mod_FilenamesInput(Template('Trademarks1_Vendor::nd'), pversion);	
   	EXPORT TradeMark2   := tools.mod_FilenamesInput(Template('Trademarks2_Vendor::nd'), pversion);		
		EXPORT TradeName1   := tools.mod_FilenamesInput(Template('Tradename1_Vendor::nd'), pversion);	
   	EXPORT TradeName2   := tools.mod_FilenamesInput(Template('Tradename2_Vendor::nd'), pversion);	
	
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_ND._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Corp      	  := tools.mod_FilenamesBuild(Template('Corp_Vendor::nd'), pversion);
		EXPORT FictName     := tools.mod_FilenamesBuild(Template('Fictitios_Vendor::nd'), pversion);		
		EXPORT Partnership  := tools.mod_FilenamesBuild(Template('partnership_vendor::nd'), pversion);	
		EXPORT TradeMark    := tools.mod_FilenamesBuild(Template('Trademarks_Vendor::nd'), pversion);	
   	EXPORT TradeName    := tools.mod_FilenamesBuild(Template('Tradename_Vendor::nd'), pversion);	
   	
		EXPORT dAll_Corp 		    := Corp.dAll_filenames;
		EXPORT dAll_FictName 	  := FictName.dAll_filenames;
		EXPORT dAll_Partnership := Partnership.dAll_filenames;
		EXPORT dAll_TradeMark   := TradeMark.dAll_filenames;
		EXPORT dAll_TradeName   := TradeName.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_Corp 		   +
													 Base.dAll_FictName	   +
													 Base.dAll_Partnership +
													 Base.dAll_TradeMark	 +
													 Base.dAll_TradeName   ;
													 	
END;