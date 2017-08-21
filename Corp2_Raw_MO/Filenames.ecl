IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_MO._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Address     		:= tools.mod_FilenamesInput(Template('Address::MO'), pversion);	
		EXPORT Corporation   	:= tools.mod_FilenamesInput(Template('Corporation::MO'), pversion);
		EXPORT Filing      		:= tools.mod_FilenamesInput(Template('Filing::MO'), pversion);
		EXPORT Names         	:= tools.mod_FilenamesInput(Template('Name::MO'), pversion);
		EXPORT Officer       	:= tools.mod_FilenamesInput(Template('Officer::MO'), pversion);	
		EXPORT Merger     		:= tools.mod_FilenamesInput(Template('Merger::MO'), pversion);			
		EXPORT Stock         	:= tools.mod_FilenamesInput(Template('Stock::MO'), pversion);		
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_MO._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
			
		EXPORT Address         	:= tools.mod_FilenamesBuild(Template('Address::MO'), pversion);			
		EXPORT Corporation      := tools.mod_FilenamesBuild(Template('Corporation::MO'), pversion);
		EXPORT Filing     			:= tools.mod_FilenamesBuild(Template('Filing::MO'), pversion);
		EXPORT Names         		:= tools.mod_FilenamesBuild(Template('Name::MO'), pversion);
		EXPORT Officer       		:= tools.mod_FilenamesBuild(Template('Officer::MO'), pversion);	
		EXPORT Merger       		:= tools.mod_FilenamesBuild(Template('Merger::MO'), pversion);	
		EXPORT Stock    				:= tools.mod_FilenamesBuild(Template('Stock::MO'), pversion);
				
		EXPORT dAll_Address			  := Address.dAll_filenames;
		EXPORT dAll_Corporation 	:= Corporation.dAll_filenames;
		EXPORT dAll_Filing   			:= Filing.dAll_filenames;
		EXPORT dAll_Names 				:= Names.dAll_filenames;
		EXPORT dAll_Officer 			:= Officer.dAll_filenames;
		EXPORT dAll_Merger 				:= Merger.dAll_filenames;
		EXPORT dAll_Stock 				:= Stock.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_Address				+
													 				 Base.dAll_Corporation		+
																	 Base.dAll_Filing					+																	 
																	 Base.dAll_Names					+
																	 Base.dAll_Officer   			+																	 
																	 Base.dAll_Merger					+
																	 Base.dAll_Stock 					;
	
END;