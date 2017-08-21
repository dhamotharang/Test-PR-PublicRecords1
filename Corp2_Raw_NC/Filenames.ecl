IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_NC._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Addresses     		:= tools.mod_FilenamesInput(Template('Addresses::NC'), pversion);	
		EXPORT Corporations   	:= tools.mod_FilenamesInput(Template('Corporations::NC'), pversion);	
		EXPORT Directors       	:= tools.mod_FilenamesInput(Template('Directors::NC'), pversion);	
		EXPORT Filings      		:= tools.mod_FilenamesInput(Template('Filings::NC'), pversion);	
		EXPORT NameReservations := tools.mod_FilenamesInput(Template('NameReservations::NC'), pversion);	
		EXPORT Names         		:= tools.mod_FilenamesInput(Template('Names::NC'), pversion);
		EXPORT Officers       	:= tools.mod_FilenamesInput(Template('Officers::NC'), pversion);	
		EXPORT Partners     		:= tools.mod_FilenamesInput(Template('Partners::NC'), pversion);			
		EXPORT Stock         		:= tools.mod_FilenamesInput(Template('Stock::NC'), pversion);	
		EXPORT PendingFilings		:= tools.mod_FilenamesInput(Template('PendingFilings::NC'), pversion);
		EXPORT CorpOfficers     := tools.mod_FilenamesInput(Template('CorpOfficers::NC'), pversion);	
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_NC._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
			
		EXPORT Addresses         	:= tools.mod_FilenamesBuild(Template('Addresses::NC'), pversion);			
		EXPORT Corporations       := tools.mod_FilenamesBuild(Template('Corporations::NC'), pversion);	
		EXPORT Directors       		:= tools.mod_FilenamesBuild(Template('Directors::NC'), pversion);	
		EXPORT Filings     				:= tools.mod_FilenamesBuild(Template('Filings::NC'), pversion);		
		EXPORT NameReservations   := tools.mod_FilenamesBuild(Template('NameReservations::NC'), pversion);	
		EXPORT Names         			:= tools.mod_FilenamesBuild(Template('Names::NC'), pversion);
		EXPORT Officers       		:= tools.mod_FilenamesBuild(Template('Officers::NC'), pversion);	
		EXPORT Partners       		:= tools.mod_FilenamesBuild(Template('Partners::NC'), pversion);	
		EXPORT Stock    					:= tools.mod_FilenamesBuild(Template('Stock::NC'), pversion);
		EXPORT PendingFilings     := tools.mod_FilenamesBuild(Template('PendingFilings::NC'), pversion);	
		EXPORT CorpOfficers       := tools.mod_FilenamesBuild(Template('CorpOfficers::NC'), pversion);
				
		EXPORT dAll_Addresses			  := Addresses.dAll_filenames;
		EXPORT dAll_Corporations 		:= Corporations.dAll_filenames;
		EXPORT dAll_Directors 			:= Directors.dAll_filenames;
		EXPORT dAll_Filings   			:= Filings.dAll_filenames;
		EXPORT dAll_NameReservations:= NameReservations.dAll_filenames;
		EXPORT dAll_Names 					:= Names.dAll_filenames;
		EXPORT dAll_Officers 				:= Officers.dAll_filenames;
		EXPORT dAll_Partners 				:= Partners.dAll_filenames;
		EXPORT dAll_Stock 					:= Stock.dAll_filenames;
		EXPORT dAll_PendingFilings  := PendingFilings.dAll_filenames;
		EXPORT dAll_CorpOfficers 		:= CorpOfficers.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_Addresses				+
													 				 Base.dAll_Corporations			+
																	 Base.dAll_Directors		 		+
																	 Base.dAll_Filings					+
																	 Base.dAll_NameReservations +																	 
																	 Base.dAll_Names						+
																	 Base.dAll_Officers   			+																	 
																	 Base.dAll_Partners					+
																	 Base.dAll_Stock 						+
																	 Base.dAll_PendingFilings		+
																	 Base.dAll_CorpOfficers   	;
	
END;