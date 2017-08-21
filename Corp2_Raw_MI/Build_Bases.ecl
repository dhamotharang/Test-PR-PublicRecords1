IMPORT corp2, tools, ut;

EXPORT Build_Bases(
	STRING																										pfiledate,
	STRING																										pversion,
	BOOLEAN																										puseprod,	
	DATASET(Corp2_Raw_MI.Layouts.MasterStringLayoutIn)				pInMaster   		= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.Master.Logical,
	DATASET(Corp2_Raw_MI.Layouts.MasterStringLayoutBase)			pBaseMaster 		= IF(Corp2_Raw_MI._Flags.Base.Master, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.Master.qa, DATASET([], Corp2_Raw_MI.Layouts.MasterStringLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.DeleteLayoutIn)							pInDelete   		= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.DeleteFile,
	DATASET(Corp2_Raw_MI.Layouts.DeleteLayoutBase)						pBaseDelete 		= IF(Corp2_Raw_MI._Flags.Base.DeleteFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.DeleteFile.qa, DATASET([], Corp2_Raw_MI.Layouts.DeleteLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.CorpMaster1ALayoutIn)				pInMaster1A   	= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.CorpMaster1AFile,
	DATASET(Corp2_Raw_MI.Layouts.CorpMaster1ALayoutBase)			pBaseMaster1A 	= IF(Corp2_Raw_MI._Flags.Base.CorpMaster1AFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.CorpMaster1AFile.qa, DATASET([], Corp2_Raw_MI.Layouts.CorpMaster1ALayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.CorpMaster1BLayoutIn)				pInMaster1B   	= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.CorpMaster1BFile,
	DATASET(Corp2_Raw_MI.Layouts.CorpMaster1BLayoutBase)			pBaseMaster1B 	= IF(Corp2_Raw_MI._Flags.Base.CorpMaster1BFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.CorpMaster1BFile.qa, DATASET([], Corp2_Raw_MI.Layouts.CorpMaster1BLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.LP2ALayoutIn)								pInLP2A   			= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.LP2AFile,
	DATASET(Corp2_Raw_MI.Layouts.LP2ALayoutBase)							pBaseLP2A 			= IF(Corp2_Raw_MI._Flags.Base.LP2AFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.LP2AFile.qa, DATASET([], Corp2_Raw_MI.Layouts.LP2ALayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.LP2BLayoutIn)								pInLP2B   			= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.LP2BFile,
	DATASET(Corp2_Raw_MI.Layouts.LP2BLayoutBase)							pBaseLP2B 			= IF(Corp2_Raw_MI._Flags.Base.LP2BFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.LP2BFile.qa, DATASET([], Corp2_Raw_MI.Layouts.LP2BLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.LLC3ALayoutIn)								pInLLC3A   			= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.LLC3AFile,
	DATASET(Corp2_Raw_MI.Layouts.LLC3ALayoutBase)							pBaseLLC3A 			= IF(Corp2_Raw_MI._Flags.Base.LLC3AFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.LLC3AFile.qa, DATASET([], Corp2_Raw_MI.Layouts.LLC3ALayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.LLC3BLayoutIn)								pInLLC3B   			= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.LLC3BFile,
	DATASET(Corp2_Raw_MI.Layouts.LLC3BLayoutBase)							pBaseLLC3B 			= IF(Corp2_Raw_MI._Flags.Base.LLC3BFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.LLC3BFile.qa, DATASET([], Corp2_Raw_MI.Layouts.LLC3BLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.NameRegistrationLayoutIn)		pInNameReg   		= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.NameRegistrationFile,
	DATASET(Corp2_Raw_MI.Layouts.NameRegistrationLayoutBase)	pBaseNameReg 		= IF(Corp2_Raw_MI._Flags.Base.NameRegistrationFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.NameRegistrationFile.qa, DATASET([], Corp2_Raw_MI.Layouts.NameRegistrationLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.MailingLayoutIn)							pInMailing   		= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.MailingFile,
	DATASET(Corp2_Raw_MI.Layouts.MailingLayoutBase)						pBaseMailing 		= IF(Corp2_Raw_MI._Flags.Base.MailingFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.MailingFile.qa, DATASET([], Corp2_Raw_MI.Layouts.MailingLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.PendingLayoutIn)							pInPending   		= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.PendingFile,
	DATASET(Corp2_Raw_MI.Layouts.PendingLayoutBase)						pBasePending 		= IF(Corp2_Raw_MI._Flags.Base.PendingFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.PendingFile.qa, DATASET([], Corp2_Raw_MI.Layouts.PendingLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.HistoryLayoutIn)							pInHistory   		= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.HistoryFile,
	DATASET(Corp2_Raw_MI.Layouts.HistoryLayoutBase)						pBaseHistory 		= IF(Corp2_Raw_MI._Flags.Base.HistoryFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.HistoryFile.qa, DATASET([], Corp2_Raw_MI.Layouts.HistoryLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.AssumedNameLayoutIn)					pInAssumed   		= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.AssumedNameFile,
	DATASET(Corp2_Raw_MI.Layouts.AssumedNameLayoutBase)				pBaseAssumed 		= IF(Corp2_Raw_MI._Flags.Base.AssumedNameFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.AssumedNameFile.qa, DATASET([], Corp2_Raw_MI.Layouts.AssumedNameLayoutBase)),
	DATASET(Corp2_Raw_MI.Layouts.GeneralPartnerLayoutIn)			pInGenPartner 	= Corp2_Raw_MI.Files(pfiledate,pUseProd).Input.GeneralPartnerFile,
	DATASET(Corp2_Raw_MI.Layouts.GeneralPartnerLayoutBase)		pBaseGenPartner = IF(Corp2_Raw_MI._Flags.Base.GeneralPartnerFile, Corp2_Raw_MI.Files(,pUseOtherEnvironment := FALSE).Base.GeneralPartnerFile.qa, DATASET([], Corp2_Raw_MI.Layouts.GeneralPartnerLayoutBase))
) := MODULE

	//************************************************************************************************
	//Build Base for the Master (Raw File that contains all the file types that follow.
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.MasterStringLayoutBase standardize_master_input(Corp2_Raw_MI.Layouts.MasterStringLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingmasterupdate := PROJECT(pInMaster, standardize_master_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedmaster 			:= workingmasterupdate + pBaseMaster;
	combinedmaster_dist := DISTRIBUTE(combinedmaster, HASH64(payload));
	combinedmaster_sort := SORT(combinedmaster_dist, payload, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.MasterStringLayoutBase rollupmasterbase(	Corp2_Raw_MI.Layouts.MasterStringLayoutBase L,
																																Corp2_Raw_MI.Layouts.MasterStringLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	basemasterfile := ROLLUP(	combinedmaster_sort,
														rollupmasterbase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_first_received, dt_last_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.Master.New, basemasterfile, Build_Master_Base);

	//************************************************************************************************
	//Build Base for the Delete Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.DeleteLayoutBase standardize_delete_input(Corp2_Raw_MI.Layouts.DeleteLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingdeleteupdate := PROJECT(pInDelete, standardize_delete_input(LEFT));

	// Combine base and update career to determine what's new.
	combineddelete 			:= workingdeleteupdate + pBaseDelete;
	combineddelete_dist := DISTRIBUTE(combineddelete, HASH(id_no_00));
	combineddelete_sort := SORT(combineddelete_dist, id_no_00, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.DeleteLayoutBase rollupdeletebase(	Corp2_Raw_MI.Layouts.DeleteLayoutBase L,
																													Corp2_Raw_MI.Layouts.DeleteLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basedeletefile := ROLLUP(	combineddelete_sort,
														rollupdeletebase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_first_received, dt_last_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.DeleteFile.New, basedeletefile, Build_Delete_Base);

	//************************************************************************************************
	//Build Base for the CorpMaster1AFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.CorpMaster1ALayoutBase standardize_master1a_input(Corp2_Raw_MI.Layouts.CorpMaster1ALayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingmaster1aupdate := PROJECT(pInMaster1A, standardize_master1a_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedmaster1a 			:= workingmaster1aupdate + pBaseMaster1A;
	combinedmaster1a_dist := DISTRIBUTE(combinedmaster1a, HASH(c_no_1a));
	combinedmaster1a_sort := SORT(combinedmaster1a_dist, c_no_1a, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.CorpMaster1ALayoutBase rollupmaster1abase(	Corp2_Raw_MI.Layouts.CorpMaster1ALayoutBase L,
																																	Corp2_Raw_MI.Layouts.CorpMaster1ALayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basemaster1afile := ROLLUP(	combinedmaster1a_sort,
															rollupmaster1abase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.CorpMaster1AFile.New, basemaster1afile, Build_Master1A_Base);

	//************************************************************************************************
	//Build Base for the CorpMaster1BFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.CorpMaster1BLayoutBase standardize_master1b_input(Corp2_Raw_MI.Layouts.CorpMaster1BLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingmaster1bupdate := PROJECT(pInMaster1B, standardize_master1b_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedmaster1b 			:= workingmaster1bupdate + pBaseMaster1B;
	combinedmaster1b_dist := DISTRIBUTE(combinedmaster1B, HASH(c_no_1b));
	combinedmaster1b_sort := SORT(combinedmaster1b_dist, c_no_1b, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.CorpMaster1BLayoutBase rollupmaster1bbase(	Corp2_Raw_MI.Layouts.CorpMaster1BLayoutBase L,
																																	Corp2_Raw_MI.Layouts.CorpMaster1BLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basemaster1bfile := ROLLUP(	combinedmaster1b_sort,
															rollupmaster1bbase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.CorpMaster1BFile.New, basemaster1bfile, Build_Master1B_Base);

	//************************************************************************************************
	//Build Base for the LP2AFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.LP2ALayoutBase standardize_lp2a_input(Corp2_Raw_MI.Layouts.LP2ALayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workinglp2aupdate := PROJECT(pInLP2A, standardize_lp2a_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedlp2a 			:= workinglp2aupdate + pBaseLP2A;
	combinedlp2a_dist := DISTRIBUTE(combinedlp2a, HASH(l_corp_no_2a));
	combinedlp2a_sort := SORT(combinedlp2a_dist, l_corp_no_2a, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.LP2ALayoutBase rolluplp2abase(	Corp2_Raw_MI.Layouts.LP2ALayoutBase L,
																											Corp2_Raw_MI.Layouts.LP2ALayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	baselp2afile := ROLLUP(	combinedlp2a_sort,
													rolluplp2abase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.LP2AFile.New, baselp2afile, Build_LP2A_Base);

	//************************************************************************************************
	//Build Base for the LP2BFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.LP2BLayoutBase standardize_lp2b_input(Corp2_Raw_MI.Layouts.LP2BLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workinglp2bupdate := PROJECT(pInLP2B, standardize_lp2b_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedlp2b 			:= workinglp2bupdate + pBaseLP2B;
	combinedlp2b_dist := DISTRIBUTE(combinedlp2b, HASH(l_corp_no_2b));
	combinedlp2b_sort := SORT(combinedlp2b_dist, l_corp_no_2b, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.LP2BLayoutBase rolluplp2bbase(	Corp2_Raw_MI.Layouts.LP2BLayoutBase L,
																											Corp2_Raw_MI.Layouts.LP2BLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	baselp2bfile := ROLLUP(	combinedlp2b_sort,
													rolluplp2bbase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.LP2BFile.New, baselp2bfile, Build_LP2B_Base);

	//************************************************************************************************
	//Build Base for the LLC3AFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.LLC3ALayoutBase standardize_llc3a_input(Corp2_Raw_MI.Layouts.LLC3ALayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingllc3aupdate := PROJECT(pInLLC3A, standardize_llc3a_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedllc3a 			:= workingllc3aupdate + pBaseLLC3A;
	combinedllc3a_dist := DISTRIBUTE(combinedllc3a, HASH(corp_3a));
	combinedllc3a_sort := SORT(combinedllc3a_dist, corp_3a, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.LLC3ALayoutBase rollupllc3abase(	Corp2_Raw_MI.Layouts.LLC3ALayoutBase L,
																												Corp2_Raw_MI.Layouts.LLC3ALayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basellc3afile := ROLLUP(	combinedllc3a_sort,
														rollupllc3abase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_first_received, dt_last_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.LLC3AFile.New, basellc3afile, Build_LLC3A_Base);

	//************************************************************************************************
	//Build Base for the LLC3BFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.LLC3BLayoutBase standardize_llc3b_input(Corp2_Raw_MI.Layouts.LLC3BLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingllc3bupdate := PROJECT(pInLLC3B, standardize_llc3b_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedllc3b 			:= workingllc3bupdate + pBaseLLC3B;
	combinedllc3b_dist := DISTRIBUTE(combinedllc3b, HASH(corp_3b));
	combinedllc3b_sort := SORT(combinedllc3b_dist, corp_3b, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.LLC3BLayoutBase rollupllc3bbase(	Corp2_Raw_MI.Layouts.LLC3BLayoutBase L,
																												Corp2_Raw_MI.Layouts.LLC3BLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basellc3bfile := ROLLUP(	combinedllc3b_sort,
														rollupllc3bbase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_first_received, dt_last_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.LLC3BFile.New, basellc3bfile, Build_LLC3B_Base);

	//************************************************************************************************
	//Build Base for the NameRegistrationFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.NameRegistrationLayoutBase standardize_nameregistration_input(Corp2_Raw_MI.Layouts.NameRegistrationLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingnameregistrationupdate := PROJECT(pInNameReg, standardize_nameregistration_input(LEFT));

	// Combine base and update career to determine what's new.
	combinednameregistration 			:= workingnameregistrationupdate + pBaseNameReg;
	combinednameregistration_dist := DISTRIBUTE(combinednameregistration, HASH(r_no_30));
	combinednameregistration_sort := SORT(combinednameregistration_dist, r_no_30, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.NameRegistrationLayoutBase rollupnameregistrationbase(	Corp2_Raw_MI.Layouts.NameRegistrationLayoutBase L,
																																							Corp2_Raw_MI.Layouts.NameRegistrationLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basenameregistrationfile := ROLLUP(	combinednameregistration_sort,
																			rollupnameregistrationbase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.NameRegistrationFile.New, basenameregistrationfile, Build_NameRegistration_Base);

	//************************************************************************************************
	//Build Base for the MailingFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.MailingLayoutBase standardize_mailing_input(Corp2_Raw_MI.Layouts.MailingLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingmailingupdate := PROJECT(pInMailing, standardize_mailing_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedmailing 			:= workingmailingupdate + pBaseMailing;
	combinedmailing_dist := DISTRIBUTE(combinedmailing, HASH(corp_no_50));
	combinedmailing_sort := SORT(combinedmailing_dist, corp_no_50, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.MailingLayoutBase rollupmailingbase(	Corp2_Raw_MI.Layouts.MailingLayoutBase L,
																														Corp2_Raw_MI.Layouts.MailingLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basemailingfile := ROLLUP(	combinedmailing_sort,
															rollupmailingbase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.MailingFile.New, basemailingfile, Build_Mailing_Base);

	//************************************************************************************************
	//Build Base for the PendingFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.PendingLayoutBase standardize_pending_input(Corp2_Raw_MI.Layouts.PendingLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingpendingupdate := PROJECT(pInPending, standardize_pending_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedpending 			:= workingpendingupdate + pBasePending;
	combinedpending_dist := DISTRIBUTE(combinedpending, HASH(pend_no_60));
	combinedpending_sort := SORT(combinedpending_dist, pend_no_60, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.PendingLayoutBase rolluppendingbase(	Corp2_Raw_MI.Layouts.PendingLayoutBase L,
																														Corp2_Raw_MI.Layouts.PendingLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basependingfile := ROLLUP(	combinedpending_sort,
															rolluppendingbase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.PendingFile.New, basependingfile, Build_Pending_Base);

	//************************************************************************************************
	//Build Base for the HistoryFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.HistoryLayoutBase standardize_history_input(Corp2_Raw_MI.Layouts.HistoryLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workinghistoryupdate := PROJECT(pInHistory, standardize_history_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedhistory 			:= workinghistoryupdate + pBaseHistory;
	combinedhistory_dist := DISTRIBUTE(combinedhistory, HASH(corp_no_70));
	combinedhistory_sort := SORT(combinedhistory_dist, corp_no_70, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.HistoryLayoutBase rolluphistorybase(	Corp2_Raw_MI.Layouts.HistoryLayoutBase L,
																														Corp2_Raw_MI.Layouts.HistoryLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basehistoryfile := ROLLUP(	combinedhistory_sort,
															rolluphistorybase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.HistoryFile.New, basehistoryfile, Build_History_Base);

	//************************************************************************************************
	//Build Base for the AssumedNameFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.AssumedNameLayoutBase standardize_assumed_input(Corp2_Raw_MI.Layouts.AssumedNameLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workingassumedupdate := PROJECT(pInAssumed, standardize_assumed_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedassumed 			:= workingassumedupdate + pBaseAssumed;
	combinedassumed_dist := DISTRIBUTE(combinedassumed, HASH(corp_no_80));
	combinedassumed_sort := SORT(combinedassumed_dist, corp_no_80, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.AssumedNameLayoutBase rollupassumedbase(	Corp2_Raw_MI.Layouts.AssumedNameLayoutBase L,
																																Corp2_Raw_MI.Layouts.AssumedNameLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseassumedfile := ROLLUP(	combinedassumed_sort,
															rollupassumedbase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.AssumedNameFile.New, baseassumedfile, Build_AssumedName_Base);

	//************************************************************************************************
	//Build Base for the GeneralPartnerFile Records (A record type within the Master Raw File).
	//************************************************************************************************
	Corp2_Raw_MI.Layouts.GeneralPartnerLayoutBase standardize_genpartner_input(Corp2_Raw_MI.Layouts.GeneralPartnerLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the MI Master update file, add received dates, and PROJECT it into the base layout.
	workinggenpartnerupdate := PROJECT(pInGenPartner, standardize_genpartner_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedgenpartner 			:= workinggenpartnerupdate + pBaseGenPartner;
	combinedgenpartner_dist := DISTRIBUTE(combinedgenpartner, HASH(gp_no_90));
	combinedgenpartner_sort := SORT(combinedgenpartner_dist, gp_no_90, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_MI.Layouts.GeneralPartnerLayoutBase rollupgenpartnerbase(	Corp2_Raw_MI.Layouts.GeneralPartnerLayoutBase L,
																																			Corp2_Raw_MI.Layouts.GeneralPartnerLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	basegenpartnerfile := ROLLUP(	combinedgenpartner_sort,
															rollupgenpartnerbase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_first_received, dt_last_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MI.Filenames(pversion).Base.GeneralPartnerFile.New, basegenpartnerfile, Build_GeneralPartner_Base);


	EXPORT full_build := SEQUENTIAL(	Build_Master_Base,
																		Build_Delete_Base,
																		Build_Master1A_Base,
																		Build_Master1B_Base,
																		Build_LP2A_Base,
																		Build_LP2B_Base,
																		Build_LLC3A_Base,
																		Build_LLC3B_Base,
																		Build_NameRegistration_Base,
																		Build_Mailing_Base,
																		Build_Pending_Base,
																		Build_History_Base,
																		Build_AssumedName_Base,
																		Build_GeneralPartner_Base,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MI.Build_Bases attribute')
									 );

END;