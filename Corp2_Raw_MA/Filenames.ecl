IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) 			:= Corp2_Raw_MA._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT CorpDataExport      				:= tools.mod_FilenamesInput(Template('corpdataexport::ma'), pversion);
		EXPORT CorpIndividualExport				:= tools.mod_FilenamesInput(Template('corpindividualexport::ma'), pversion);		
		EXPORT CorpNameChange       			:= tools.mod_FilenamesInput(Template('corpnamechange::ma'), pversion);		
		EXPORT CorpMerger         				:= tools.mod_FilenamesInput(Template('corpmerger::ma'),	pversion);
		EXPORT CorpDetailExport         	:= tools.mod_FilenamesInput(Template('corpdetailexport::ma'),	pversion);
		EXPORT CorpStockExport      			:= tools.mod_FilenamesInput(Template('corpstockexport::ma'), pversion);		
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) 			:= Corp2_Raw_MA._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CorpDataExport    					:= tools.mod_FilenamesBuild(Template('corpdataexport::ma'), pversion);
		EXPORT CorpIndividualExport			 	:= tools.mod_FilenamesBuild(Template('corpindividualexport::ma'), pversion);		
		EXPORT CorpNameChange							:= tools.mod_FilenamesBuild(Template('corpnamechange::ma'), pversion);
		EXPORT CorpMerger         				:= tools.mod_FilenamesBuild(Template('corpmerger::ma'), pversion);
		EXPORT CorpDetailExport         	:= tools.mod_FilenamesBuild(Template('corpdetailexport::ma'), pversion);
		EXPORT CorpStockExport      			:= tools.mod_FilenamesBuild(Template('corpstockexport::ma'), pversion);		

		EXPORT dAll_corpdataexport 				:= CorpDataExport.dAll_filenames;
		EXPORT dAll_corpindividualexport 	:= CorpIndividualExport.dAll_filenames;
		EXPORT dAll_corpnamechange 				:= CorpNameChange.dAll_filenames;
		EXPORT dAll_corpmerger 						:= CorpMerger.dAll_filenames;
		EXPORT dAll_corpdetailexport			:= CorpDetailExport.dAll_filenames;		
		EXPORT dAll_corpstockexport 			:= CorpStockExport.dAll_filenames;				
	END;
	
	EXPORT dAll_filenames 							:= Base.dAll_corpdataexport 			+
																				 Base.dAll_corpindividualexport +
																				 Base.dAll_corpnamechange		 		+
																				 Base.dAll_corpmerger		 				+
																				 Base.dAll_corpdetailexport			+
																				 Base.dAll_corpstockexport;
	
END;