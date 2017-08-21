IMPORT tools, corp2;

EXPORT Build_Bases_Master(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.MasterLayout)		    pInMasterFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.MasterFile,
	DATASET(Corp2_Raw_NY.Layouts.MasterLayoutBase)	  pBaseMasterFile   = IF(Corp2_Raw_NY._Flags.Base.Master, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.Master.qa, 	DATASET([], Corp2_Raw_NY.Layouts.MasterLayoutBase))
) := MODULE

  // -----------------------------
  // Build Master Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.MasterLayoutBase standardize_MasterInput(Corp2_Raw_NY.Layouts.MasterLayout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	MasterWorkingUpdate := PROJECT(pInMasterFile, standardize_MasterInput(LEFT));
	MasterCombined 			:= MasterWorkingUpdate + pBaseMasterFile;
	MasterCombined_dist := DISTRIBUTE(MasterCombined, HASH(corpidno));
	MasterCombined_sort := SORT(MasterCombined_dist, corpidno, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.MasterLayoutBase rollupMasterBase(Corp2_Raw_NY.Layouts.MasterLayoutBase L,
																												 Corp2_Raw_NY.Layouts.MasterLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
		SELF := L;
	END;
	
	baseMaster := ROLLUP(	MasterCombined_sort, rollupMasterBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.Master.New, baseMaster, Build_Master_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Master_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_Master attribute')
									 );

END;