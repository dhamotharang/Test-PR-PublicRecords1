IMPORT tools, Corp2_Raw_PA;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_PA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		// Vendor Data Files
		EXPORT CorpName      := tools.mod_FilenamesInput(Template('CorporationName::pa'), pversion);
		EXPORT Address       := tools.mod_FilenamesInput(Template('address::pa'), pversion);		
		EXPORT Officer       := tools.mod_FilenamesInput(Template('officer::pa'), pversion);		
		EXPORT Corporations  := tools.mod_FilenamesInput(Template('corporation::pa'), pversion);		
		EXPORT Filing        := tools.mod_FilenamesInput(Template('filing::pa'), pversion);	
		EXPORT Merger        := tools.mod_FilenamesInput(Template('merger::pa'), pversion);	
    // The Stock file is always empty and will be checked in the mapper to verify that it's still empty
		EXPORT Stock         := tools.mod_FilenamesInput(Template('stockOrig::pa'), pversion);		
	
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_PA._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CorpName    	 := tools.mod_FilenamesBuild(Template('CorpName::pa'), pversion);
		EXPORT Address       := tools.mod_FilenamesBuild(Template('Address::pa'), pversion);		
		EXPORT Officer       := tools.mod_FilenamesBuild(Template('Officer::pa'), pversion);		
		EXPORT Corporations  := tools.mod_FilenamesBuild(Template('Corporations::pa'), pversion);
		EXPORT Filing        := tools.mod_FilenamesBuild(Template('Filing::pa'), pversion);
		EXPORT Merger        := tools.mod_FilenamesBuild(Template('Merger::pa'), pversion);

		EXPORT dAll_CorpName 		 := CorpName.dAll_filenames;
		EXPORT dAll_Address 		 := Address.dAll_filenames;
		EXPORT dAll_Officer 		 := Officer.dAll_filenames;
		EXPORT dAll_Corporations := Corporations.dAll_filenames;	
		EXPORT dAll_Filing  		 := Filing.dAll_filenames;
		EXPORT dAll_Merger  		 := Merger.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_CorpName 		+
													 Base.dAll_Address      +
													 Base.dAll_Officer		  +
													 Base.dAll_Corporations +
													 Base.dAll_Filing 			+
													 Base.dAll_Merger				;
	
END;