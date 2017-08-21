IMPORT corp2, tools;

EXPORT Build_Bases(
	STRING																							pfiledate,
	STRING																							pversion,
	BOOLEAN																							puseprod,	
	DATASET(Corp2_Raw_MN.Layouts.FullFileLayoutIn)			pInFullFile  		= Corp2_Raw_MN.Files(pfiledate,pUseProd).Input.FullFile.Logical,
	DATASET(Corp2_Raw_MN.Layouts.FullFileLayoutBase)		pBaseFullFile		= IF(Corp2_Raw_MN._Flags.Base.FullFile, Corp2_Raw_MN.Files(,pUseOtherEnvironment := FALSE).Base.FullFile.qa, DATASET([], Corp2_Raw_MN.Layouts.FullFileLayoutBase)),
	DATASET(Corp2_Raw_MN.Layouts.MasterLayoutIn)				pInMaster   		= Corp2_Raw_MN.Files(pfiledate,pUseProd).Input.Master,
	DATASET(Corp2_Raw_MN.Layouts.MasterLayoutBase)			pBaseMaster 		= IF(Corp2_Raw_MN._Flags.Base.Master, Corp2_Raw_MN.Files(,pUseOtherEnvironment := FALSE).Base.Master.qa, DATASET([], Corp2_Raw_MN.Layouts.MasterLayoutBase)),
	DATASET(Corp2_Raw_MN.Layouts.FilingHistLayoutIn)		pInFilingHist   = Corp2_Raw_MN.Files(pfiledate,pUseProd).Input.FilingHist,
	DATASET(Corp2_Raw_MN.Layouts.FilingHistLayoutBase)	pBaseFilingHist = IF(Corp2_Raw_MN._Flags.Base.FilingHist, Corp2_Raw_MN.Files(,pUseOtherEnvironment := FALSE).Base.FilingHist.qa, DATASET([], Corp2_Raw_MN.Layouts.FilingHistLayoutBase)),
	DATASET(Corp2_Raw_MN.Layouts.NameAddrLayoutIn)			pInNameAddr   	= Corp2_Raw_MN.Files(pfiledate,pUseProd).Input.NameAddr,
	DATASET(Corp2_Raw_MN.Layouts.NameAddrLayoutBase)		pBaseNameAddr 	= IF(Corp2_Raw_MN._Flags.Base.NameAddr, Corp2_Raw_MN.Files(,pUseOtherEnvironment := FALSE).Base.NameAddr.qa, DATASET([], Corp2_Raw_MN.Layouts.NameAddrLayoutBase))
	
) := MODULE

	//************************************************************************************************
	//Build Base for the FullFile
	//************************************************************************************************
	Corp2_Raw_MN.Layouts.FullFileLayoutBase standardize_fullfile_input(Corp2_Raw_MN.Layouts.FullFileLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the MN Corp update file, add received dates, and PROJECT it into the base layout.
	workingFullFileUpdate := PROJECT(pInFullFile, standardize_fullfile_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedFullFile 			:= workingFullFileUpdate + pBaseFullFile;
	combinedFullFile_dist := DISTRIBUTE(combinedFullFile, HASH64(payload));
	combinedFullFile_sort := SORT(combinedFullFile_dist, payload, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_MN.Layouts.FullFileLayoutBase RollupFullFileBase(	Corp2_Raw_MN.Layouts.FullFileLayoutBase L,
																															Corp2_Raw_MN.Layouts.FullFileLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);																							 
	  SELF := L;
	END;
	
	basefullfile 							:= ROLLUP(combinedFullFile_sort,
																			RollupFullFileBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MN.Filenames(pversion).Base.FullFile.New, basefullfile, Build_FullFile_Base);
	
	//************************************************************************************************
	//Build Base for the Master - record_type = '01'
	//************************************************************************************************
	Corp2_Raw_MN.Layouts.MasterLayoutBase standardize_master_input(Corp2_Raw_MN.Layouts.MasterLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the MN Corp update file, add received dates, and PROJECT it into the base layout.
	workingMasterUpdate := PROJECT(pInMaster, standardize_master_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedMaster 			:= workingMasterUpdate + pBaseMaster;
	combinedMaster_dist := DISTRIBUTE(combinedMaster, HASH64(master_id));
	combinedMaster_sort := SORT(combinedMaster_dist, master_id, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_MN.Layouts.MasterLayoutBase RollupMasterBase(	Corp2_Raw_MN.Layouts.MasterLayoutBase L,
																													Corp2_Raw_MN.Layouts.MasterLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);																								 
	  SELF := L;
	END;
	
	basemaster	 							:= ROLLUP(combinedMaster_sort,
																			RollupMasterBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MN.Filenames(pversion).Base.Master.New, basemaster, Build_Master_Base);

	//************************************************************************************************
	//Build Base for the FilingHist - record_type = '02'
	//************************************************************************************************
	Corp2_Raw_MN.Layouts.FilingHistLayoutBase standardize_filinghist_input(Corp2_Raw_MN.Layouts.FilingHistLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the MN Corp update file, add received dates, and PROJECT it into the base layout.
	workingFilingHistUpdate := PROJECT(pInFilingHist, standardize_filinghist_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedFilingHist 			:= workingFilingHistUpdate + pBaseFilingHist;
	combinedFilingHist_dist := DISTRIBUTE(combinedFilingHist, HASH64(master_id));
	combinedFilingHist_sort := SORT(combinedFilingHist_dist, master_id, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_MN.Layouts.FilingHistLayoutBase RollupFilingHistBase(	Corp2_Raw_MN.Layouts.FilingHistLayoutBase L,
																																	Corp2_Raw_MN.Layouts.FilingHistLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);																								 
	  SELF := L;
	END;
	
	basefilinghist						:= ROLLUP(combinedFilingHist_sort,
																			RollupFilingHistBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MN.Filenames(pversion).Base.FilingHist.New, basefilinghist, Build_FilingHist_Base);

	//************************************************************************************************
	//Build Base for the NameAddr - record_type = '03'
	//************************************************************************************************
	Corp2_Raw_MN.Layouts.NameAddrLayoutBase standardize_nameaddr_input(Corp2_Raw_MN.Layouts.NameAddrLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the MN Corp update file, add received dates, and PROJECT it into the base layout.
	workingNameAddrUpdate := PROJECT(pInNameAddr, standardize_nameaddr_input(LEFT));

	// Combine base and update career to determine what's new.
	combinedNameAddr 			:= workingNameAddrUpdate + pBaseNameAddr;
	combinedNameAddr_dist := DISTRIBUTE(combinedNameAddr, HASH64(master_id));
	combinedNameAddr_sort := SORT(combinedNameAddr_dist, master_id, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_MN.Layouts.NameAddrLayoutBase RollupNameAddrBase(	Corp2_Raw_MN.Layouts.NameAddrLayoutBase L,
																															Corp2_Raw_MN.Layouts.NameAddrLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);																									 
	  SELF := L;
	END;
	
	basenameaddr 							:= ROLLUP(combinedNameAddr_sort,
																			RollupNameAddrBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MN.Filenames(pversion).Base.NameAddr.New, basenameaddr, Build_NameAddr_Base);

	EXPORT full_build := sequential(	Build_FullFile_Base,
																		Build_Master_Base,			//record_type = '01'
																		Build_FilingHist_Base,	//record_type = '02'
																		Build_NameAddr_Base,		//record_type = '03'
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											full_build,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MN.Build_Bases attribute')
									 );

END;
