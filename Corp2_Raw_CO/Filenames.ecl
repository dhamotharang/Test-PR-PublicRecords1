IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
								 BOOLEAN pUseOtherEnvironment = FALSE) := MODULE								 
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) 		:= Corp2_Raw_CO._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT CorpMstr	      					:= tools.mod_FilenamesInput(Template('corpmstr::co'), pversion);				
		EXPORT CorpTrdnm	     					:= tools.mod_FilenamesInput(Template('corptrdnm::co'), pversion);
		EXPORT CorpHist1      					:= tools.mod_FilenamesInput(Template('corphist::co'), pversion);
		EXPORT CorpHist2      					:= tools.mod_FilenamesInput(Template('corphist2::co'), pversion);
		EXPORT tmChange	    						:= tools.mod_FilenamesInput(Template('tmchange::co'),	pversion);
		EXPORT tmCorrection	    				:= tools.mod_FilenamesInput(Template('tmcorrection::co'), pversion);
		EXPORT tmExpired	    					:= tools.mod_FilenamesInput(Template('tmexpired::co'), pversion);
		EXPORT tmRegistration	    			:= tools.mod_FilenamesInput(Template('tmregistration::co'), pversion);
		EXPORT tmRenewal	    					:= tools.mod_FilenamesInput(Template('tmrenewal::co'), pversion);
		EXPORT tmTransfer	    					:= tools.mod_FilenamesInput(Template('tmtransfer::co'), pversion);
		EXPORT tmWithdraw	    					:= tools.mod_FilenamesInput(Template('tmwithdraw::co'), pversion);
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) 		:= Corp2_Raw_CO._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CorpMstr	    						:= tools.mod_FilenamesBuild(Template('corpmstr::co'), pversion);
		EXPORT CorpTrdnm	    					:= tools.mod_FilenamesBuild(Template('corptrdnm::co'), pversion);
		EXPORT CorpHist    							:= tools.mod_FilenamesBuild(Template('corphist::co'), pversion);
		EXPORT tmChange	    						:= tools.mod_FilenamesBuild(Template('tmchange::co'),	pversion);
		EXPORT tmCorrection	    				:= tools.mod_FilenamesBuild(Template('tmcorrection::co'), pversion);
		EXPORT tmExpired	    					:= tools.mod_FilenamesBuild(Template('tmexpired::co'), pversion);
		EXPORT tmRegistration	    			:= tools.mod_FilenamesBuild(Template('tmregistration::co'), pversion);
		EXPORT tmRenewal	    					:= tools.mod_FilenamesBuild(Template('tmrenewal::co'), pversion);
		EXPORT tmTransfer	    					:= tools.mod_FilenamesBuild(Template('tmtransfer::co'), pversion);
		EXPORT tmWithdraw	    					:= tools.mod_FilenamesBuild(Template('tmwithdraw::co'), pversion);
		EXPORT tmHistory	    					:= tools.mod_FilenamesBuild(Template('tmhistory::co'), pversion);
		

		EXPORT dAll_CorpMstr 						:= CorpMstr.dAll_filenames;
		EXPORT dAll_CorpTrdnm						:= CorpTrdnm.dAll_filenames;
		EXPORT dAll_CorpHist						:= CorpHist.dAll_filenames;
		EXPORT dAll_tmChange 						:= tmChange.dAll_filenames;
		EXPORT dAll_tmCorrection 				:= tmCorrection.dAll_filenames;
		EXPORT dAll_tmExpired						:= tmExpired.dAll_filenames;
		EXPORT dAll_tmRegistration 			:= tmRegistration.dAll_filenames;
		EXPORT dAll_tmRenewal 					:= tmRenewal.dAll_filenames;
		EXPORT dAll_tmTransfer 					:= tmTransfer.dAll_filenames;
		EXPORT dAll_tmWithdraw 					:= tmWithdraw.dAll_filenames;
		EXPORT dAll_tmHistory 					:= tmHistory.dAll_filenames;
		
	
	END;
	
  EXPORT dAll_filenames 						:= Base.dAll_CorpMstr 			+
																			 Base.dAll_CorpTrdnm 			+
																			 Base.dAll_CorpHist 			+
																			 Base.dAll_tmChange 			+
																			 Base.dAll_tmCorrection 	+
																			 Base.dAll_tmExpired  		+
																			 Base.dAll_tmRegistration +
																			 Base.dAll_tmRenewal 			+
																			 Base.dAll_tmTransfer  		+
																			 Base.dAll_tmWithdraw			
																			 ;
																			 
EXPORT dAll_tmHist			 						:= Base.dAll_tmHistory;
																			 
END;