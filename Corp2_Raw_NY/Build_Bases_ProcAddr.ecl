IMPORT tools, corp2;

EXPORT Build_Bases_ProcAddr(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_NY.Layouts.ProcAddrLayout)		    pInProcAddrFile     = Corp2_Raw_NY.Files(pfiledate,puseprod).Input.ProcAddrFile,
	DATASET(Corp2_Raw_NY.Layouts.ProcAddrLayoutBase)	  pBaseProcAddrFile   = IF(Corp2_Raw_NY._Flags.Base.ProcAddr, Corp2_Raw_NY.Files(,pUseOtherEnvironment := FALSE).Base.ProcAddr.qa, 	DATASET([], Corp2_Raw_NY.Layouts.ProcAddrLayoutBase))
) := MODULE

  // -----------------------------
  // Build ProcAddr Base File
	// -----------------------------
	Corp2_Raw_NY.Layouts.ProcAddrLayoutBase standardize_ProcAddrInput(Corp2_Raw_NY.Layouts.ProcAddrLayout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	ProcAddrWorkingUpdate := PROJECT(pInProcAddrFile, standardize_ProcAddrInput(LEFT));
	ProcAddrCombined 			:= ProcAddrWorkingUpdate + pBaseProcAddrFile;
	ProcAddrCombined_dist := DISTRIBUTE(ProcAddrCombined, HASH(Process_corpidno));
	ProcAddrCombined_sort := SORT(ProcAddrCombined_dist, Process_corpidno, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_NY.Layouts.ProcAddrLayoutBase rollupProcAddrBase(Corp2_Raw_NY.Layouts.ProcAddrLayoutBase L,
																												     Corp2_Raw_NY.Layouts.ProcAddrLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
		SELF := L;
	END;
	
	baseProcAddr := ROLLUP(	ProcAddrCombined_sort, rollupProcAddrBase(LEFT, RIGHT),
															RECORD, EXCEPT dt_last_received, dt_first_received, LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NY.Filenames(pversion).Base.ProcAddr.New, baseProcAddr, Build_ProcAddr_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_ProcAddr_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NY.Build_Bases_ProcAddr attribute')
									 );

END;