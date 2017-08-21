IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_MD._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT AmendHist          := tools.mod_FilenamesInput(Template('AmendHist::MD'), pversion);
		EXPORT ARCAmendHist       := tools.mod_FilenamesInput(Template('ARCAmendHist::MD'), pversion);
		EXPORT BusAddr         		:= tools.mod_FilenamesInput(Template('BusAddr::MD'), pversion);	
		EXPORT ARCBusAddr         := tools.mod_FilenamesInput(Template('ARCBusAddr::MD'), pversion);		
		EXPORT BusEntity      		:= tools.mod_FilenamesInput(Template('BusEntity::MD'), pversion);		
		EXPORT BusNmIndx       		:= tools.mod_FilenamesInput(Template('BusNmIndx::MD'), pversion);	
		EXPORT ARCBusNmIndx       := tools.mod_FilenamesInput(Template('ARCBusNmIndx::MD'), pversion);	
		EXPORT BusType       			:= tools.mod_FilenamesInput(Template('BusType::MD'), pversion);	
		EXPORT BusComment         := tools.mod_FilenamesInput(Template('BusComment::MD'), pversion);
		EXPORT EntityStatus       := tools.mod_FilenamesInput(Template('EntityStatus::MD'), pversion);	
		EXPORT FilingType       	:= tools.mod_FilenamesInput(Template('FilingType::MD'), pversion);	
		EXPORT TradeName          := tools.mod_FilenamesInput(Template('TradeName::MD'), pversion);		
		EXPORT FilmIndx       	  := tools.mod_FilenamesInput(Template('FilmIndx::MD'), pversion);	
		EXPORT ReserveName        := tools.mod_FilenamesInput(Template('ReserveName::MD'), pversion);	
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_MD._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
			
		EXPORT AmendHist         	:= tools.mod_FilenamesBuild(Template('AmendHist::MD'), pversion);	
		EXPORT ARCAmendHist    		:= tools.mod_FilenamesBuild(Template('ARCAmendHist::MD'), pversion);	
		EXPORT BusAddr    			  := tools.mod_FilenamesBuild(Template('BusAddr::MD'), pversion);
		EXPORT ARCBusAddr    			:= tools.mod_FilenamesBuild(Template('ARCBusAddr::MD'), pversion);
		EXPORT BusEntity     	    := tools.mod_FilenamesBuild(Template('BusEntity::MD'), pversion);			
		EXPORT BusNmIndx          := tools.mod_FilenamesBuild(Template('BusNmIndx::MD'), pversion);		
		EXPORT ARCBusNmIndx       := tools.mod_FilenamesBuild(Template('ARCBusNmIndx::MD'), pversion);		
		EXPORT BusType            := tools.mod_FilenamesBuild(Template('BusType::MD'), pversion);	
		EXPORT BusComment         := tools.mod_FilenamesBuild(Template('BusComment::MD'), pversion);
		EXPORT EntityStatus       := tools.mod_FilenamesBuild(Template('EntityStatus::MD'), pversion);		
		EXPORT FilingType       	:= tools.mod_FilenamesBuild(Template('FilingType::MD'), pversion);	
		EXPORT TradeName          := tools.mod_FilenamesBuild(Template('TradeName::MD'), pversion);
		EXPORT FilmIndx       	  := tools.mod_FilenamesBuild(Template('FilmIndx::MD'), pversion);	
		EXPORT ReserveName        := tools.mod_FilenamesBuild(Template('ReserveName::MD'), pversion);	
				
		EXPORT dAll_AmendHist			  := AmendHist.dAll_filenames;
		EXPORT dAll_ARCAmendHist  	:= ARCAmendHist.dAll_filenames;
		EXPORT dAll_BusAddr 			  := BusAddr.dAll_filenames;
		EXPORT dAll_ARCBusAddr 			:= ARCBusAddr.dAll_filenames;
		EXPORT dAll_BusEntity       := BusEntity.dAll_filenames;
		EXPORT dAll_BusNmIndx 		  := BusNmIndx.dAll_filenames;
		EXPORT dAll_ARCBusNmIndx 		:= ARCBusNmIndx.dAll_filenames;
		EXPORT dAll_BusType 		    := BusType.dAll_filenames;
		EXPORT dAll_BusComment 			:= BusComment.dAll_filenames;
		EXPORT dAll_EntityStatus 		:= EntityStatus.dAll_filenames;
		EXPORT dAll_FilingType 		  := FilingType.dAll_filenames;
		EXPORT dAll_TradeName 		  := TradeName.dAll_filenames;
		EXPORT dAll_FilmIndx 		    := FilmIndx.dAll_filenames;
		EXPORT dAll_ReserveName 		:= ReserveName.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_AmendHist			+
																	 Base.dAll_ARCAmendHist   +
																	 Base.dAll_BusAddr 				+
																	 Base.dAll_ARCBusAddr 		+
																	 Base.dAll_BusEntity			+
													 				 Base.dAll_ARCBusNmIndx		+ 
																	 Base.dAll_BusNmIndx			+
																	 Base.dAll_BusType   			+																	 
																	 Base.dAll_BusComment			+
																	 Base.dAll_EntityStatus		+
																	 Base.dAll_FilingType    	+																	 
																	 Base.dAll_TradeName			+
																	 Base.dAll_FilmIndx   		+																	 
																	 Base.dAll_ReserveName	   ;
	
END;