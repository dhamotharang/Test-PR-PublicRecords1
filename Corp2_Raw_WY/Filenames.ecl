IMPORT tools;
	
EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) 			:= Corp2_Raw_WY._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Filing	      							:= tools.mod_FilenamesInput(Template('filing::wy'), pversion);					
		EXPORT FilingAR	     							:= tools.mod_FilenamesInput(Template('filing_annual_report::wy'), pversion);					
		EXPORT Party	      							:= tools.mod_FilenamesInput(Template('party::wy'), pversion);					

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) 		:= Corp2_Raw_WY._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Filing	    							:= tools.mod_FilenamesBuild(Template('filing::wy'), pversion);
		EXPORT FilingAR	    						:= tools.mod_FilenamesBuild(Template('filing_annual_report::wy'), pversion);
		EXPORT Party	    							:= tools.mod_FilenamesBuild(Template('party::wy'), pversion);

		EXPORT dAll_Filing 							:= Filing.dAll_filenames;
		EXPORT dAll_FilingAR 						:= FilingAR.dAll_filenames;
		EXPORT dAll_Party 							:= Party.dAll_filenames;
	
	END;
	
  EXPORT dAll_filenames 						:= Base.dAll_Filing 	+
																			 Base.dAll_FilingAR +
																			 Base.dAll_Party;
END;