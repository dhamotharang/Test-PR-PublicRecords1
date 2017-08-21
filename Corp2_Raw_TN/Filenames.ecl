IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_TN._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Filing         			:= tools.mod_FilenamesInput(Template('filing::tn'), pversion);
		EXPORT FilingName         	:= tools.mod_FilenamesInput(Template('filing_name::tn'), pversion);		
		EXPORT Party         				:= tools.mod_FilenamesInput(Template('party::tn'), pversion);		
		EXPORT AnnualReport        	:= tools.mod_FilenamesInput(Template('annual_report::tn'), pversion);		
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_TN._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Filing    						:= tools.mod_FilenamesBuild(Template('filing::tn'), pversion);
		EXPORT FilingName         	:= tools.mod_FilenamesBuild(Template('filing_name::tn'), pversion);		
		EXPORT Party         				:= tools.mod_FilenamesBuild(Template('party::tn'), pversion);		
		EXPORT AnnualReport        	:= tools.mod_FilenamesBuild(Template('annual_report::tn'), pversion);		

		EXPORT dAll_filing 					:= Filing.dAll_filenames;
		EXPORT dAll_filingname 			:= FilingName.dAll_filenames;
		EXPORT dAll_party 					:= Party.dAll_filenames;
		EXPORT dAll_annualreport 		:= AnnualReport.dAll_filenames;
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_filing 		+
																	 Base.dAll_filingname +
													 				 Base.dAll_party		 	+
																	 Base.dAll_annualreport;
	
END;