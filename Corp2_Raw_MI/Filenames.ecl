IMPORT tools;
	
EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
						 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_MI._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Master	      				:= tools.mod_FilenamesInput(Template('master1::mi'), pversion);					

	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) 			:= Corp2_Raw_MI._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Master	    								:= tools.mod_FilenamesBuild(Template('master1::mi'), pversion);
		EXPORT CorpMaster1AFile	    			:= tools.mod_FilenamesBuild(Template('corpmaster1afile::mi'), pversion);
		EXPORT CorpMaster1BFile	    			:= tools.mod_FilenamesBuild(Template('corpmaster1bfile::mi'), pversion);
		EXPORT DeleteFile	    						:= tools.mod_FilenamesBuild(Template('deletefile::mi'), pversion);
		EXPORT LP2AFile	    							:= tools.mod_FilenamesBuild(Template('lp2afile::mi'), pversion);
		EXPORT LP2BFile	    							:= tools.mod_FilenamesBuild(Template('lp2bfile::mi'), pversion);
		EXPORT NameRegistrationFile				:= tools.mod_FilenamesBuild(Template('nameregistrationfile::mi'), pversion);
		EXPORT LLC3AFile	    						:= tools.mod_FilenamesBuild(Template('llc3afile::mi'), pversion);
		EXPORT LLC3BFile	    						:= tools.mod_FilenamesBuild(Template('llc3bfile::mi'), pversion);
		EXPORT MailingFile	    					:= tools.mod_FilenamesBuild(Template('mailingfile::mi'), pversion);
		EXPORT PendingFile	    					:= tools.mod_FilenamesBuild(Template('pendingfile::mi'), pversion);
		EXPORT HistoryFile	    					:= tools.mod_FilenamesBuild(Template('historyfile::mi'), pversion);
		EXPORT AssumedNameFile	    			:= tools.mod_FilenamesBuild(Template('assumednamefile::mi'), pversion);
		EXPORT GeneralPartnerFile	  			:= tools.mod_FilenamesBuild(Template('generalpartnerfile::mi'), pversion);

		EXPORT dAll_Master		 						:= Master.dAll_filenames;
		EXPORT dAll_CorpMaster1AFile		 	:= CorpMaster1AFile.dAll_filenames;
		EXPORT dAll_CorpMaster1BFile		 	:= CorpMaster1BFile.dAll_filenames;
		EXPORT dAll_DeleteFile		 				:= DeleteFile.dAll_filenames;
		EXPORT dAll_LP2AFile		 					:= LP2AFile.dAll_filenames;
		EXPORT dAll_LP2BFile		 					:= LP2BFile.dAll_filenames;
		EXPORT dAll_NameRegistrationFile	:= NameRegistrationFile.dAll_filenames;
		EXPORT dAll_LLC3AFile		 					:= LLC3AFile.dAll_filenames;
		EXPORT dAll_LLC3BFile		 					:= LLC3BFile.dAll_filenames;
		EXPORT dAll_MailingFile		 				:= MailingFile.dAll_filenames;
		EXPORT dAll_PendingFile		 				:= PendingFile.dAll_filenames;
		EXPORT dAll_HistoryFile		 				:= HistoryFile.dAll_filenames;
		EXPORT dAll_AssumedNameFile		 		:= AssumedNameFile.dAll_filenames;
		EXPORT dAll_GeneralPartnerFile		:= GeneralPartnerFile.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_Master								+
																	 Base.dAll_CorpMaster1AFile		 	+
																	 Base.dAll_CorpMaster1BFile		 	+
																	 Base.dAll_DeleteFile		 				+
																	 Base.dAll_LP2AFile		 					+
																	 Base.dAll_LP2BFile		 					+
																	 Base.dAll_NameRegistrationFile	+
																	 Base.dAll_LLC3AFile		 				+
																	 Base.dAll_LLC3BFile		 				+
																	 Base.dAll_MailingFile		 			+
																	 Base.dAll_PendingFile		 			+
																	 Base.dAll_HistoryFile		 			+
																	 Base.dAll_AssumedNameFile		 	+
																	 Base.dAll_GeneralPartnerFile;		
  
END;