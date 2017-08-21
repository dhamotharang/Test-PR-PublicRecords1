IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	EXPORT Input := MODULE

		EXPORT Template(STRING tag) := Corp2_Raw_HI._Dataset(pUseOtherEnvironment).InputTemplate + tag;
	
		EXPORT CompanyMaster     		:= tools.mod_FilenamesInput(Template('companymaster::hi'), pversion);
		EXPORT CompanyOfficer				:= tools.mod_FilenamesInput(Template('companyofficer::hi'), pversion);
		EXPORT CompanyStock    			:= tools.mod_FilenamesInput(Template('companystock::hi'),	pversion);
		EXPORT CompanyTransaction   := tools.mod_FilenamesInput(Template('companytransaction::hi'), pversion);
		EXPORT TtsMaster						:= tools.mod_FilenamesInput(Template('ttsmaster::hi'), pversion);
		EXPORT TtsTransaction    		:= tools.mod_FilenamesInput(Template('ttstransaction::hi'),	pversion);

	END; //end Input

	EXPORT Base := MODULE
		EXPORT Template(STRING tag) 		:= Corp2_Raw_HI._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT CompanyMaster			  		:= tools.mod_FilenamesBuild(Template('companymaster::hi'), pversion);
		EXPORT CompanyOfficer						:= tools.mod_FilenamesBuild(Template('companyofficer::hi'), pversion);		
		EXPORT CompanyStock    					:= tools.mod_FilenamesBuild(Template('companystock::hi'), pversion);
		EXPORT CompanyTransaction				:= tools.mod_FilenamesBuild(Template('companytransaction::hi'), pversion);
		EXPORT TtsMaster								:= tools.mod_FilenamesBuild(Template('ttsmaster::hi'), pversion);		
		EXPORT TtsTransaction    				:= tools.mod_FilenamesBuild(Template('ttstransaction::hi'), pversion);		

		EXPORT dAll_CompanyMaster				:= CompanyMaster.dAll_filenames;
		EXPORT dAll_CompanyOfficer			:= CompanyOfficer.dAll_filenames;
		EXPORT dAll_CompanyStock 				:= CompanyStock.dAll_filenames;
		EXPORT dAll_CompanyTransaction	:= CompanyTransaction.dAll_filenames;
		EXPORT dAll_TtsMaster						:= TtsMaster.dAll_filenames;
		EXPORT dAll_TtsTransaction 			:= TtsTransaction.dAll_filenames;
	END; //end Base
	
	EXPORT dAll_filenames							:= Base.dAll_CompanyMaster 			+
																			 Base.dAll_CompanyOfficer 			+
																			 Base.dAll_CompanyStock 				+ 
																			 Base.dAll_CompanyTransaction 	+
																			 Base.dAll_TtsMaster 					+
																			 Base.dAll_TtsTransaction;
																			 
END; //end Filenames