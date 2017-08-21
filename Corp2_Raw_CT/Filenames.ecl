IMPORT corp2_raw_ct, tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	EXPORT Input := MODULE

		EXPORT Template(STRING tag) := Corp2_Raw_CT._Dataset(pUseOtherEnvironment).InputTemplate + tag;
	
		EXPORT BusFiling     				:= tools.mod_FilenamesInput(Template('tmpBusFiling::ct'), pversion);
		EXPORT BusMaster						:= tools.mod_FilenamesInput(Template('tmpBusMaster::ct'), pversion);
		EXPORT BusMerger  	  			:= tools.mod_FilenamesInput(Template('tmpbusmergr::ct'),	pversion);
		EXPORT BusOther   					:= tools.mod_FilenamesInput(Template('tmpbusother::ct'),  pversion);
		EXPORT BusReserve						:= tools.mod_FilenamesInput(Template('tmpbusrsvr::ct'),   pversion);
		EXPORT Corps   							:= tools.mod_FilenamesInput(Template('tmpCorp::ct'),			pversion);
		EXPORT DlmlPart 		   			:= tools.mod_FilenamesInput(Template('tmpDlmlPart::ct'),	pversion);
		EXPORT DlmtCorp   		 			:= tools.mod_FilenamesInput(Template('tmpDlmtCorp::ct'),	pversion);	
		EXPORT DlmtPart     				:= tools.mod_FilenamesInput(Template('tmpDlmtPart::ct'),  pversion);
		EXPORT FilmIndx    					:= tools.mod_FilenamesInput(Template('tmpFilmIndx::ct'),	pversion);	
		EXPORT FlmlPart		   				:= tools.mod_FilenamesInput(Template('tmpFlmlPart::ct'),  pversion);
		EXPORT FlmtCorp 		  			:= tools.mod_FilenamesInput(Template('tmpFlmtCorp::ct'),  pversion);
		EXPORT FlmtPart							:= tools.mod_FilenamesInput(Template('tmpFlmtPart::ct'),  pversion);
		EXPORT General							:= tools.mod_FilenamesInput(Template('tmpGeneralp::ct'),  pversion);
		EXPORT NameChg							:= tools.mod_FilenamesInput(Template('tmpNameChng::ct'),  pversion);
		EXPORT Prncipal						  := tools.mod_FilenamesInput(Template('tmpPrncipal::ct'),  pversion);
		EXPORT ForStat    					:= tools.mod_FilenamesInput(Template('tmpForStat::ct'),	  pversion);
		EXPORT Stock     						:= tools.mod_FilenamesInput(Template('tmpStock::ct'), 		pversion);

	END; //end Input

	EXPORT Base := MODULE
		EXPORT Template(STRING tag) := Corp2_Raw_CT._Dataset(pUseOtherEnvironment).FileTemplate + tag;

		EXPORT BusFiling 		    		:= tools.mod_FilenamesBuild(Template('BusFiling::ct'), pversion);
		EXPORT BusMaster						:= tools.mod_FilenamesBuild(Template('BusMaster::ct'), pversion);
		EXPORT BusMerger 			   		:= tools.mod_FilenamesBuild(Template('BusMerger::ct'), pversion);
		EXPORT BusOther 		  			:= tools.mod_FilenamesBuild(Template('BusOther::ct'),  pversion);
		EXPORT BusReserve						:= tools.mod_FilenamesBuild(Template('BusReserve::ct'),pversion);
		EXPORT Corps   							:= tools.mod_FilenamesBuild(Template('Corps::ct'),		 pversion);
		EXPORT DlmlPart    					:= tools.mod_FilenamesBuild(Template('DlmlPart::ct'),	 pversion);
		EXPORT DlmtCorp    					:= tools.mod_FilenamesBuild(Template('DlmtCorp::ct'),	 pversion);		
		EXPORT DlmtPart  	  	 			:= tools.mod_FilenamesBuild(Template('DlmtPart::ct'),  pversion);
		EXPORT FilmIndx 	  	 			:= tools.mod_FilenamesBuild(Template('FilmIndx::ct'),	 pversion);	
		EXPORT FlmlPart   					:= tools.mod_FilenamesBuild(Template('FlmlPart::ct'),  pversion);
		EXPORT FlmtCorp   					:= tools.mod_FilenamesBuild(Template('FlmtCorp::ct'),  pversion);
		EXPORT FlmtPart							:= tools.mod_FilenamesBuild(Template('FlmtPart::ct'),  pversion);
		EXPORT General							:= tools.mod_FilenamesBuild(Template('General::ct'),   pversion);
		EXPORT NameChg							:= tools.mod_FilenamesBuild(Template('NameChg::ct'),   pversion);
		EXPORT Prncipal						  := tools.mod_FilenamesBuild(Template('Prncipal::ct'),  pversion);
		EXPORT ForStat    					:= tools.mod_FilenamesBuild(Template('ForStat::ct'),	 pversion);
		EXPORT Stock     						:= tools.mod_FilenamesBuild(Template('Stock::ct'), 		 pversion);

		EXPORT dAll_BusFiling 		 	:= BusFiling.dAll_filenames;
		EXPORT dAll_BusMaster				:= BusMaster.dAll_filenames;
		EXPORT dAll_BusMerger 		 	:= BusMerger.dAll_filenames;
		EXPORT dAll_BusOther 		  	:= BusOther.dAll_filenames;
		EXPORT dAll_BusReserve			:= BusReserve.dAll_filenames;
		EXPORT dAll_Corps    				:= Corps.dAll_filenames;
		EXPORT dAll_DlmlPart    		:= DlmlPart.dAll_filenames;
		EXPORT dAll_DlmtCorp    		:= DlmtCorp.dAll_filenames;	
		EXPORT dAll_DlmtPart  	  	:= DlmtPart.dAll_filenames;
		EXPORT dAll_FilmIndx 	  		:= FilmIndx.dAll_filenames;	
		EXPORT dAll_FlmlPart   			:= FlmlPart.dAll_filenames;
		EXPORT dAll_FlmtCorp   			:= FlmtCorp.dAll_filenames;
		EXPORT dAll_FlmtPart				:= FlmtPart.dAll_filenames;
		EXPORT dAll_General					:= General.dAll_filenames;
		EXPORT dAll_NameChg					:= NameChg.dAll_filenames;
		EXPORT dAll_Prncipal				:= Prncipal.dAll_filenames;
		EXPORT dAll_ForStat    			:= ForStat.dAll_filenames;
		EXPORT dAll_Stock     			:= Stock.dAll_filenames;	
	END; //end Base
	
	EXPORT dAll_filenames					:= Base.dAll_BusFiling 			+
																	 Base.dAll_BusMaster 			+
																	 Base.dAll_BusMerger 			+ 
																	 Base.dAll_BusOther 			+
																	 Base.dAll_BusReserve 		+
																	 Base.dAll_Corps 					+
																	 Base.dAll_DlmlPart 			+
																	 Base.dAll_DlmtCorp 			+
																	 Base.dAll_DlmtPart 			+
																	 Base.dAll_FilmIndx 			+
																	 Base.dAll_FlmlPart 			+
																	 Base.dAll_FlmtCorp 			+
																	 Base.dAll_FlmtPart 			+
																	 Base.dAll_General 				+
																	 Base.dAll_NameChg 				+
																	 Base.dAll_Prncipal 			+
																	 Base.dAll_ForStat 				+
																	 Base.dAll_Stock;
																			 
END; //end Filenames