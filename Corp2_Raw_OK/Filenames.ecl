IMPORT tools, Corp2_Raw_OK;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_OK._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Corp  := tools.mod_FilenamesInput(Template('all::ok'),  pversion);		
	END;

	EXPORT Base := MODULE
			EXPORT Template(STRING tag) := Corp2_Raw_OK._Dataset(pUseOtherEnvironment).FileTemplate + tag;

			EXPORT f01_Entity 		     := tools.mod_FilenamesBuild(Template('f01_Entity::ok')    ,pversion);
			EXPORT f02_Address			   := tools.mod_FilenamesBuild(Template('f02_Address::ok')   ,pversion);
			EXPORT f03_Agent 			   	 := tools.mod_FilenamesBuild(Template('f03_Agent::ok')     ,pversion);
			EXPORT f04_Officer 		  	 := tools.mod_FilenamesBuild(Template('f04_Officer::ok')   ,pversion);
			EXPORT f05_Names					 := tools.mod_FilenamesBuild(Template('f05_Names::ok')     ,pversion);
			EXPORT f06_AssocEnt   		 := tools.mod_FilenamesBuild(Template('f06_AssocEnt::ok')  ,pversion);
			EXPORT f07_StockData    	 := tools.mod_FilenamesBuild(Template('f07_StockData::ok') ,pversion);
			EXPORT f08_StockInfo    	 := tools.mod_FilenamesBuild(Template('f08_StockInfo::ok') ,pversion);		
			EXPORT f12_CorpType  	  	 := tools.mod_FilenamesBuild(Template('f12_CorpType::ok')  ,pversion);
			EXPORT f17_CorpFiling 	   := tools.mod_FilenamesBuild(Template('f17_CorpFiling::ok'),pversion);	

			EXPORT dAll_f01_Entity 		 := f01_Entity.dAll_filenames;
			EXPORT dAll_f02_Address		 := f02_Address.dAll_filenames;
			EXPORT dAll_f03_Agent 		 := f03_Agent.dAll_filenames;
			EXPORT dAll_f04_Officer 	 := f04_Officer.dAll_filenames;
			EXPORT dAll_f05_Names			 := f05_Names.dAll_filenames;
			EXPORT dAll_f06_AssocEnt   := f06_AssocEnt.dAll_filenames;
			EXPORT dAll_f07_StockData  := f07_StockData.dAll_filenames;
			EXPORT dAll_f08_StockInfo  := f08_StockInfo.dAll_filenames;	
			EXPORT dAll_f12_CorpType   := f12_CorpType.dAll_filenames;
			EXPORT dAll_f17_CorpFiling := f17_CorpFiling.dAll_filenames;	
		END; //end Base
		
		EXPORT dAll_filenames					:= Base.dAll_f01_Entity 		+
																		 Base.dAll_f02_Address 		+
																		 Base.dAll_f03_Agent 			+ 
																		 Base.dAll_f04_Officer 		+
																		 Base.dAll_f05_Names 		  +
																		 Base.dAll_f06_AssocEnt 	+
																		 Base.dAll_f07_StockData 	+
																		 Base.dAll_f08_StockInfo 	+
																		 Base.dAll_f12_CorpType 	+
																		 Base.dAll_f17_CorpFiling ;
																		
																				 
	END; //end Filenames